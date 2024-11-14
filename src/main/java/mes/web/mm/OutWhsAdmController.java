package mes.web.mm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysql.jdbc.Util;

import lombok.Data;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.mm.InWhsAdmVo;
import mes.domain.mm.OutWhsAdmVo;
//import mes.domain.tm.StockPaymentAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.mm.InWhsAdmService;
import mes.service.mm.OutWhsAdmService;
//import mes.service.tm.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class OutWhsAdmController {

	private static final Logger logger = LoggerFactory.getLogger(OutWhsAdmController.class);

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	@Inject
	private InWhsAdmService inWhsAdmService;
	
	@Inject
	private OutWhsAdmService outWhsAdmService;
	
//	@Inject
//	private StockPaymentAdmService stockPaymentAdmService;
	
	
	// 자제출고(공통) 메인
	@RequestMapping(value = "/mmsc0060", method = RequestMethod.GET)
	public String mmsc0060(Locale locale, Model model) throws Exception {
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		model.addAttribute("userNumber", Utils.getUserNumber());
		model.addAttribute("userNm", Utils.getUserNm());
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("076"); //창고코드
		List<SystemCommonCodeVo> locationList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationNo", locationList);

		return "mm/mmsc0060";
	}
	
	//자재출고 목록조회 -> 개별출고 목록조회
	@RequestMapping(value = "mm/preOutWhsAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preOutWhsAdmList(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 목록조회 : "+outWhsAdmVo);
		try {
			logger.info("outCase:"+outWhsAdmVo.getOutCase());
			List<OutWhsAdmVo> preOutWhsAdmList = outWhsAdmService.preOutWhsAdmList(outWhsAdmVo);
			
			jsonData.put("data", preOutWhsAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//자재출고 목록조회
	@RequestMapping(value = "mm/preOutWhsAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preOutWhsAdmRead(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 상세조회 : "+outWhsAdmVo);
		try {
			
			List<OutWhsAdmVo> preOutWhsAdmList = outWhsAdmService.preOutWhsAdmRead(outWhsAdmVo);
			
			jsonData.put("data", preOutWhsAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//자재출고 목록조회
	@RequestMapping(value = "mm/preOutWhsAdmRead2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preOutWhsAdmRead2(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 상세조회 : "+outWhsAdmVo);
		try {
			
			 List<OutWhsAdmVo> preOutWhsAdmList;
			 if(outWhsAdmVo.getWorkOrdNo()!=null && !outWhsAdmVo.getWorkOrdNo().equals("")) {
				 preOutWhsAdmList = outWhsAdmService.preOutWhsAdmRead(outWhsAdmVo);
			 }else {
				 preOutWhsAdmList = new ArrayList<OutWhsAdmVo>();
			 }
			
			jsonData.put("data", preOutWhsAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	
	//자재출고 상세조회
	@RequestMapping(value = "mm/barcodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> barcodeList(InWhsAdmVo vo ,OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		InWhsAdmVo inWhsAdmVo = new InWhsAdmVo();
		OutWhsAdmVo outWhsAdmVo2 = new OutWhsAdmVo();
		
		logger.info("바코드 상세조회 : "+outWhsAdmVo);
		try {
			
			if(outWhsAdmVo.getBarcodeNo()!=null && !outWhsAdmVo.getBarcodeNo().equals("")) {
				//자재입고 확인
				inWhsAdmVo = inWhsAdmService.inWhsAdmRead(vo);
				
				if(inWhsAdmVo==null) {
					
					logger.info("여기로 들어옴!!!!!");
					outWhsAdmVo.setBarcodeNo(vo.getBarcodeNo());
					outWhsAdmVo2 = outWhsAdmService.itemPartRead(outWhsAdmVo);
					
					if(outWhsAdmVo2==null) {
						logger.info("여기로 들어옴222222");
						jsonData.put("result", "empty");
					}else {
						if(outWhsAdmVo2.getRemainQty()==0.000 || outWhsAdmVo2.getRemainQty()==null ) {
							jsonData.put("result", "notRemainQty");
						}else {
							/*
							 * int preOutQty = outWhsAdmService.getConsumpt(outWhsAdmVo);
							 * logger.info("출고량(총소모량):"+preOutQty);
							 * 
							 * jsonData.put("preOutQty", preOutQty);
							 */
							jsonData.put("data", outWhsAdmVo2);
							jsonData.put("result", "ok");
						}
					}
				}else {
					//공통부품인지 확인
					/*if(inWhsAdmVo.getPartGubun().equals("003")){
						jsonData.put("result", "commonGubun");
						
					}else {*/
					outWhsAdmVo.setPartCd(inWhsAdmVo.getPartCd());
					outWhsAdmVo.setPartRev(inWhsAdmVo.getPartRev());
					
					//작지번호에 해당하는 바코드여부 확인
					if(outWhsAdmService.checkBarcodeNo(outWhsAdmVo)==0) {
						jsonData.put("result", "incorrect");
						
					}else {
						//자재상태가 가입고, 수입검사, 승인상태인지 확인
						if(inWhsAdmVo.getStatusCd().equals("S")||inWhsAdmVo.getStatusCd().equals("I")||inWhsAdmVo.getStatusCd().equals("A")) {
							jsonData.put("result", "notInWhs");
						}else if(inWhsAdmVo.getStatusCd().equals("P")){
							jsonData.put("result", "already");
						}else {
							
							//남은수량 확인
							if(inWhsAdmVo.getRemainQty().equals("0.000") || inWhsAdmVo.getRemainQty()==null) {
								jsonData.put("result", "notRemainQty");
							}else {
								
								float inWhsQty = Float.parseFloat(inWhsAdmVo.getInWhsQty());
								float preOutQty = outWhsAdmService.getConsumpt(outWhsAdmVo);
								logger.info("입고량"+inWhsQty);
								logger.info("소요량"+preOutQty);
								
								if(inWhsQty>preOutQty) {
									jsonData.put("preOutQty", preOutQty);
								}else {
									jsonData.put("preOutQty", inWhsQty);
									
								}
							
								jsonData.put("data", inWhsAdmVo);
								jsonData.put("result", "ok");
							}
						}
					}
				}
			}else {
				jsonData.put("data", inWhsAdmVo);
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	
	//자재출고(공통) 상세조회
	@RequestMapping(value = "mm/barcodeCommonList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> barcodeCommonList(InWhsAdmVo vo ,OutWhsAdmVo vo2) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		InWhsAdmVo inWhsAdmVo = new InWhsAdmVo();
		OutWhsAdmVo outWhsAdmVo2 = new OutWhsAdmVo();
		logger.info("바코드 상세조회 : "+vo);
		try {
			
			if(vo.getBarcodeNo()!=null && !vo.getBarcodeNo().equals("")) {
				//자재입고 확인
				inWhsAdmVo = inWhsAdmService.inWhsAdmBarcodeRead(vo);	//입고 테이블 조회
				
				if(inWhsAdmVo==null) {
					jsonData.put("result", "empty");
				}else {
					//남은수량 확인
					if(inWhsAdmVo.getRemainQty().equals("0.000") || inWhsAdmVo.getRemainQty()==null) {
						jsonData.put("result", "notRemainQty");
					}else {
						jsonData.put("data", inWhsAdmVo);
						jsonData.put("result", "ok");
					}
				}
			}else {
				jsonData.put("data", inWhsAdmVo);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//출고수량과 총소료량 비교 조회 
	@RequestMapping(value = "mm/compareConsumptPreOutQty", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> compareConsumptPreOutQty(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 출고량과 총소요량조회 : "+outWhsAdmVo);
		try {

			int count = 0;
			
			List<OutWhsAdmVo> list = outWhsAdmService.compareConsumptPreOutQty(outWhsAdmVo);
			
			if(list.size()==0) {
				jsonData.put("result", "notConfirm");
				jsonData.put("message", "미출고된 자재가 있습니다. 확인해주세요.");
			}else {

				for(int i=0; i<list.size(); i++) {
					
					if(list.get(i).getDiffQty().equals("N")) count++;
				}
				
				if(count==0) {
					
					//작지 테이블에 확정컬럼 추가
					jsonData.put("result", "ok");
				}else {
					jsonData.put("result", "notConfirm");
					jsonData.put("message", "미출고된 자재가 있습니다. 확인해주세요.");
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
		
	//자재출고 등록
	@RequestMapping(value = "mm/preOutWhsAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preOutWhsAdmCreate(@RequestBody List<Map<String, Object>> outWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		OutWhsAdmVo outWhsAdmVo = new OutWhsAdmVo();
//		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
		logger.info("자재출고 등록 : "+outWhsAdmList);
		try {
			
			outWhsAdmVo.setItemCd(outWhsAdmList.get(0).get("itemCd").toString());
			outWhsAdmVo.setItemRev(outWhsAdmList.get(0).get("itemRev").toString());
			outWhsAdmVo.setWorkOrdNo(outWhsAdmList.get(0).get("workOrdNo").toString());
			outWhsAdmVo.setPreOutWhsDate(outWhsAdmList.get(0).get("preOutWhsDate").toString());
			outWhsAdmVo.setPreWorkCharger(outWhsAdmList.get(0).get("preWorkCharger").toString());
			outWhsAdmVo.setInWhsDesc(outWhsAdmList.get(0).get("inWhsDesc").toString());
			outWhsAdmVo.setOutCase(outWhsAdmList.get(0).get("outCase").toString());
			outWhsAdmVo.setPartGubun("003");
			
			logger.info("리스트 사이즈>>>"+outWhsAdmList.size());
			
			//중복제거
			List<String> outWhsAdmDistinctList = new ArrayList<String>();
			for(Map<String, Object> m : outWhsAdmList){
	            if(!outWhsAdmDistinctList.contains(m.get("partCd").toString()+m.get("partRev").toString())) {
	            	outWhsAdmDistinctList.add(m.get("partCd").toString()+m.get("partRev").toString());
	            }
	        }
			
			for(Map<String, Object> m : outWhsAdmList) {
				
				if(m.get("poNo").toString().equals("null") || m.get("poNo").toString()==null) {
					//발주번호
					String today = DateUtil.getToday("YYMMdd");
					String poNoSeq = inWhsAdmService.getPoNo(today);
					String poNo = "I"+today+"-"+poNoSeq;
					
					outWhsAdmVo.setPoNo(poNo);
					outWhsAdmVo.setPoSeq(0);
					outWhsAdmVo.setInSeq("0");
					outWhsAdmVo.setLotNo(m.get("barcodeNo").toString());
				}else {
					outWhsAdmVo.setPoNo(m.get("poNo").toString());
					outWhsAdmVo.setPoSeq(Integer.parseInt(m.get("poSeq").toString()));
					outWhsAdmVo.setInSeq(m.get("inSeq").toString());
					outWhsAdmVo.setLotNo(m.get("lotNo").toString());
				}
				
				outWhsAdmVo.setLotNo(m.get("lotNo").toString());
				outWhsAdmVo.setBarcodeNo(m.get("barcodeNo").toString());
				outWhsAdmVo.setPartCd(m.get("partCd").toString());
				outWhsAdmVo.setPartRev(m.get("partRev").toString());
				outWhsAdmVo.setPreOutQty(Float.parseFloat(m.get("preOutQty").toString()));
				outWhsAdmVo.setLocationCd(m.get("locationCd").toString());
				outWhsAdmVo.setAreaCd(m.get("areaCd").toString());
				outWhsAdmVo.setFloorCd(m.get("floorCd").toString());
				outWhsAdmVo.setLocationNo(m.get("locationNo").toString());
				outWhsAdmVo.setStatusCd("O");
				outWhsAdmVo.setOutSeq(outWhsAdmService.getOutSeq(outWhsAdmVo));
					
				
				outWhsAdmVo.setRegId(Utils.getUserId());
				outWhsAdmService.preOutWhsAdmCreate(outWhsAdmVo);
				
				//출고테이블에 해당 바코드 여부확인
				//출고테이블 update
				/*if(outWhsAdmService.barcodeExsitCheck(outWhsAdmVo)>0) {	
					
					logger.info("존재함");
					
					outWhsAdmVo.setUpdId(Utils.getUserId());
					outWhsAdmService.updatePreOutQty(outWhsAdmVo);
					
				//출고테이블 create	
				}else {													
					
					logger.info("존재NONONONO");
					
					outWhsAdmVo.setRegId(Utils.getUserId());
					outWhsAdmService.preOutWhsAdmCreate(outWhsAdmVo);
				}
				*/
				//입고 테이블 update
				if(outWhsAdmVo.getPoNo()!=null && !outWhsAdmVo.getPoNo().equals("")) {
					outWhsAdmService.updateRemainQty(outWhsAdmVo);
				}
					
				//수불테이블 Create
				/*String spNo = stockPaymentAdmService.getSpNo(DateUtil.getToday("yyyymmdd")); //수불 전표번호
				
				stockPaymentAdmVo.setSpNo(spNo);
				stockPaymentAdmVo.setSpSeq(stockPaymentAdmService.getSpSeq(stockPaymentAdmVo));
				stockPaymentAdmVo.setSpType("001");
				stockPaymentAdmVo.setSpCd(outWhsAdmVo.getPartCd());
				stockPaymentAdmVo.setSpRev(outWhsAdmVo.getPartRev());
				stockPaymentAdmVo.setSpGubun("002");
				stockPaymentAdmVo.setSpDate(outWhsAdmVo.getPreOutWhsDate());
				stockPaymentAdmVo.setSpQty(Float.toString(outWhsAdmVo.getPreOutQty()));
				stockPaymentAdmVo.setBarcodeNo(outWhsAdmVo.getBarcodeNo());
				stockPaymentAdmVo.setSourceNo(outWhsAdmVo.getBarcodeNo());
				stockPaymentAdmVo.setLocationCd(outWhsAdmVo.getLocationCd());
				stockPaymentAdmVo.setAreaCd(outWhsAdmVo.getAreaCd());
				stockPaymentAdmVo.setFloorCd(outWhsAdmVo.getFloorCd());
				stockPaymentAdmVo.setLocationNo(outWhsAdmVo.getLocationNo());
				stockPaymentAdmVo.setRegId(Utils.getUserId());
				
				stockPaymentAdmService.stockPaymentAdmCreate(stockPaymentAdmVo);*/
				
			}
			jsonData.put("result", "ok");
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//개별출고 등록
	@RequestMapping(value = "mm/preOutWhsAdmCommonCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preOutWhsAdmCommonCreate(@RequestBody List<Map<String, Object>> outWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		OutWhsAdmVo outWhsAdmVo = new OutWhsAdmVo();
//		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
		logger.info("개별출고 등록 : "+outWhsAdmList);
		try {
			
			for(Map<String, Object> m : outWhsAdmList) {
				//출고테이블
				
				if(m.get("poNo").toString().equals("null") || m.get("poNo").toString()==null) {
					//발주번호
					String today = DateUtil.getToday("YYMMdd");
					String poNoSeq = inWhsAdmService.getPoNo(today);
					String poNo = "I"+today+"-"+poNoSeq;
					
					outWhsAdmVo.setPoNo(poNo);
					outWhsAdmVo.setPoSeq(0);
					outWhsAdmVo.setInSeq("0");
					outWhsAdmVo.setLotNo(m.get("barcodeNo").toString());
				}else {
					outWhsAdmVo.setPoNo(m.get("poNo").toString());
					outWhsAdmVo.setPoSeq(Integer.parseInt(m.get("poSeq").toString()));
					outWhsAdmVo.setInSeq(m.get("inSeq").toString());
					outWhsAdmVo.setLotNo(m.get("lotNo").toString());
				}
					
				outWhsAdmVo.setOutSeq(outWhsAdmService.getOutSeq(outWhsAdmVo));
				outWhsAdmVo.setBarcodeNo(m.get("barcodeNo").toString());
				outWhsAdmVo.setPartCd(m.get("partCd").toString());
				outWhsAdmVo.setPartRev(m.get("partRev").toString());
				outWhsAdmVo.setPreOutQty(Float.parseFloat(m.get("preOutQty").toString()));
				outWhsAdmVo.setLocationCd(m.get("locationCd").toString());
				outWhsAdmVo.setAreaCd(m.get("areaCd").toString());
				outWhsAdmVo.setFloorCd(m.get("floorCd").toString());
				outWhsAdmVo.setLocationNo(m.get("locationNo").toString());
				outWhsAdmVo.setStatusCd("O");
				outWhsAdmVo.setPreOutWhsDate(outWhsAdmList.get(0).get("preOutWhsDate").toString());
				outWhsAdmVo.setPreWorkCharger(outWhsAdmList.get(0).get("preWorkCharger").toString());
				outWhsAdmVo.setInWhsDesc(outWhsAdmList.get(0).get("inWhsDesc").toString());
				outWhsAdmVo.setOutCase(outWhsAdmList.get(0).get("outCase").toString());
			
					
				outWhsAdmVo.setRegId(Utils.getUserId());
				outWhsAdmService.preOutWhsAdmCreate(outWhsAdmVo);
				//출고테이블에 해당 바코드 여부확인
				//출고테이블 update
				/*if(outWhsAdmService.barcodeExsitCheck(outWhsAdmVo)>0) {	
					
					logger.info("존재함");
					
					outWhsAdmVo.setUpdId(Utils.getUserId());
					outWhsAdmService.updatePreOutQty(outWhsAdmVo);
					
				//출고테이블 create	
				}else {													
					
					logger.info("존재NONONONO");
					
					outWhsAdmVo.setRegId(Utils.getUserId());
					outWhsAdmService.preOutWhsAdmCreate(outWhsAdmVo);
				}
				*/
				//입고 테이블 update
				if(outWhsAdmVo.getPoNo()!=null && !outWhsAdmVo.getPoNo().equals("")) {
					outWhsAdmService.updateRemainQty(outWhsAdmVo);
				}
					
				//수불테이블 Create
				/*String spNo = stockPaymentAdmService.getSpNo(DateUtil.getToday("yyyymmdd"));
				stockPaymentAdmVo.setSpNo(spNo);
				stockPaymentAdmVo.setSpSeq(stockPaymentAdmService.getSpSeq(stockPaymentAdmVo));
				stockPaymentAdmVo.setSpType("001");
				stockPaymentAdmVo.setSpCd(outWhsAdmVo.getPartCd());
				stockPaymentAdmVo.setSpRev(outWhsAdmVo.getPartRev());
				stockPaymentAdmVo.setSpGubun("002");
				stockPaymentAdmVo.setSpDate(outWhsAdmVo.getPreOutWhsDate());
				stockPaymentAdmVo.setSpQty(Float.toString(outWhsAdmVo.getPreOutQty()));
				stockPaymentAdmVo.setBarcodeNo(outWhsAdmVo.getBarcodeNo());
				stockPaymentAdmVo.setSourceNo(outWhsAdmVo.getBarcodeNo());
				stockPaymentAdmVo.setLocationCd(outWhsAdmVo.getLocationCd());
				stockPaymentAdmVo.setAreaCd(outWhsAdmVo.getAreaCd());
				stockPaymentAdmVo.setFloorCd(outWhsAdmVo.getFloorCd());
				stockPaymentAdmVo.setLocationNo(outWhsAdmVo.getLocationNo());
				stockPaymentAdmVo.setRegId(Utils.getUserId());
				
				stockPaymentAdmService.stockPaymentAdmCreate(stockPaymentAdmVo);*/
			}
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	
	//자재출고 출고량 수정
	@RequestMapping(value = "mm/updatePreOutQty", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updatePreOutQty(@RequestBody List<Map<String, Object>> outWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		OutWhsAdmVo outWhsAdmVo = new OutWhsAdmVo();
		logger.info("자재출고 출고량 수정 : "+outWhsAdmList);
		try {
			outWhsAdmVo.setUpdId(Utils.getUserId());
			
			for(Map<String, Object> m : outWhsAdmList) {
				
				outWhsAdmVo.setBarcodeNo(m.get("barcodeNo").toString());
				
				//입고수량과 비교해야함
				
				
				outWhsAdmService.updatePreOutQty(outWhsAdmVo);
				
				//입출고 남은수량 수정
				outWhsAdmService.updateRemainQty(outWhsAdmVo);
				
				jsonData.put("result", "ok");
					
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//자재출고 확정여부수정
	@RequestMapping(value = "mm/updateConfirmYn", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> updateConfirmYn(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 확정여부 수정 : "+outWhsAdmVo);
		try {
			outWhsAdmVo.setUpdId(Utils.getUserId());
			
			outWhsAdmService.updateConfirmYn(outWhsAdmVo);
			jsonData.put("result", "ok");
		
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//자재출고현황 작지번호 모달 조회
	@RequestMapping(value = "mm/workOrdNoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdNoList(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고현황 작지번호 모달 조회 : "+outWhsAdmVo);
		try {
			
			List<OutWhsAdmVo> workOrdNoList = outWhsAdmService.workOrdNoList(outWhsAdmVo);
			jsonData.put("data", workOrdNoList);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//수주상세별 출고 모니터링 조회
	@RequestMapping(value = "mm/outMonitoringList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> outMonitoringList(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주상세별 출고 모니터링 조회 : "+outWhsAdmVo);
		try {
			
			List<OutWhsAdmVo> list = outWhsAdmService.outMonitoringList(outWhsAdmVo);
			if(list==null) {
				list = new ArrayList<OutWhsAdmVo>();
			}
			jsonData.put("data", list);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//재공창고현항
	//재공창고 기본조회
	@RequestMapping(value = "mm/wareHouseList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> wareHouseList(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주상세별 출고 모니터링 조회 : "+outWhsAdmVo);
		try {
			
			List<OutWhsAdmVo> list = outWhsAdmService.wareHouseList(outWhsAdmVo);
			if(list==null) {
				list = new ArrayList<OutWhsAdmVo>();
			}
			jsonData.put("data", list);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//재공창고 상세조회
	@RequestMapping(value = "mm/wareHouseRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> wareHouseRead(OutWhsAdmVo outWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주상세별 출고 모니터링 조회 : "+outWhsAdmVo);
		try {
			
			List<OutWhsAdmVo> list = outWhsAdmService.wareHouseRead(outWhsAdmVo);
			if(list==null) {
				list = new ArrayList<OutWhsAdmVo>();
			}
			jsonData.put("data", list);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
}


