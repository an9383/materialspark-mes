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

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.mm.InWhsAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.mm.InWhsAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class InWhsAdmController {

	private static final Logger logger = LoggerFactory.getLogger(InWhsAdmController.class);

	private static final int String = 0;

	private static final int Map = 0;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private InWhsAdmService inWhsAdmService; 

	// 개별입고등록 메인
	@RequestMapping(value = "/mmsc0030", method = RequestMethod.GET)
	public String iosc0210(Locale locale, Model model) throws Exception {
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("076"); //창고코드
		List<SystemCommonCodeVo> locationList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationNo", locationList);
		
		return "mm/mmsc0030";
	}
	
	//가입고등록 상세조회
	@RequestMapping(value = "mm/preInWhsAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preInWhsAdmList(InWhsAdmVo inWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("가입고목록 : "+inWhsAdmVo);
		try {
			if(inWhsAdmVo.getPoNo()==null || inWhsAdmVo.getPoNo().equals("")) {
				List<InWhsAdmVo> list = new ArrayList<InWhsAdmVo>();
				jsonData.put("data", list);
			}else {
				List<InWhsAdmVo> inWhsAdmList = inWhsAdmService.preInWhsAdmList(inWhsAdmVo);
				jsonData.put("data", inWhsAdmList);
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

	//가입고등록 삭제
	@RequestMapping(value = "mm/preInWhsAdmDelete", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preInWhsAdmDelete(InWhsAdmVo inWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("가입고등록 삭제 : "+inWhsAdmVo);
		try {
			
			/*if(!inWhsAdmService.statusCdCheck(inWhsAdmVo).equals("S")) {
				jsonData.put("result", "noDel");
			}else {
				inWhsAdmService.preInWhsAdmDelete(inWhsAdmVo);
				jsonData.put("result", "ok");
			}*/
			inWhsAdmService.preInWhsAdmDelete(inWhsAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	
	//가입고등록 자재상태 확인
	@RequestMapping(value = "mm/statusCdCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> statusCdCheck(InWhsAdmVo inWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재상태 확인 : "+inWhsAdmVo);
		try {
			
			if(!inWhsAdmService.statusCdCheck(inWhsAdmVo).equals("S")) {
				jsonData.put("result", "noEdit");
			}else {
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
	//입고등록
	
	//입고등록 목록조회
	@RequestMapping(value = "io/inWhsAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inWhsAdmRead(InWhsAdmVo inWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		logger.info("입고상세목록 : "+inWhsAdmVo);
		try {
			InWhsAdmVo vo;
			
			if(inWhsAdmVo.getBarcodeNo()==null || inWhsAdmVo.getBarcodeNo().equals("")) {
				 vo = new InWhsAdmVo();
				 jsonData.put("data", vo);
				 jsonData.put("result", "ok");
				
			}else {
				vo = inWhsAdmService.inWhsAdmRead(inWhsAdmVo);
				
				if(vo==null) {
				
					jsonData.put("result", "empty");
				
				}else {
				
					if(vo.getPairCnt()==null || vo.getPairCnt().equals("0.000")) {
						jsonData.put("result", "notRemain");
					} else {
					
						//수입검사 여부 : Y
						if(vo.getInspectYn().equals("001")) {
							if(vo.getStatusCd().equals("I")) {
								jsonData.put("result", "notApproval");
							}else if(vo.getStatusCd().equals("S")) {
								jsonData.put("result", "notInspect");
							}else {
								jsonData.put("data", vo);
								jsonData.put("result", "ok");
							}
						}else {
							jsonData.put("data", vo);
							jsonData.put("result", "ok");
						}
					}
				}
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage()
					);
		}
		return jsonData;
	}
	
	//******************개별입고**************************
	//개별입고 목록조회
	@RequestMapping(value = "mm/individualAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> individualAdmList(InWhsAdmVo inWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("개별입고 목록조회 : "+inWhsAdmVo);
		try {
			
			List<InWhsAdmVo> list = inWhsAdmService.individualAdmList(inWhsAdmVo);
			if(list==null) {
				list = new ArrayList<InWhsAdmVo>();
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
	
	//개별입고 등록
	@RequestMapping(value="mm/individualAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> individualAdmCreate(@RequestBody List<Map<String, Object>> inWhsAdmList) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			InWhsAdmVo inWhsAdmVo = new InWhsAdmVo();
			for(Map<String, Object> m :inWhsAdmList) {
				
				logger.info("개별입고등록:"+inWhsAdmVo);
				//바코드번호, lot번호
				String date = m.get("partCd").toString()+"-"+DateUtil.getToday("yyyyMMdd").substring(2,8);
				String poSeq = inWhsAdmService.getBarcodeSeq(date);   
				String barcodeNo = date+"-"+ poSeq;
				
				//입고시퀀스
				String dateTo = DateUtil.getToday("yyyyMMdd").substring(2,8);
				String inSeq = inWhsAdmService.getInSeq(dateTo);
				String sudel = dateTo+'-'+inSeq;
				
				inWhsAdmVo.setInSeq(sudel);
				
				inWhsAdmVo.setPoNo(m.get("poNo").toString());
				inWhsAdmVo.setPoSeq(Integer.parseInt(m.get("poSeq").toString()));
				
				inWhsAdmVo.setBarcodeNo(barcodeNo);
				inWhsAdmVo.setLotNo(barcodeNo);
				
				//기본정보
				inWhsAdmVo.setPartCd(m.get("partCd").toString());
				inWhsAdmVo.setPartRev(m.get("partRev").toString());
				inWhsAdmVo.setPreInWhsDate(m.get("preInWhsDate").toString());
				inWhsAdmVo.setPreInWhsQty(m.get("preInWhsQty").toString());
				inWhsAdmVo.setInWhsQty(m.get("preInWhsQty").toString());	//입고수량 가입고 수량과 동일하게 처리
				inWhsAdmVo.setRemainQty(m.get("preInWhsQty").toString());	//입고수량 가입고 수량과 동일하게 처리
				inWhsAdmVo.setInWhsDesc(m.get("inWhsDesc").toString());
				inWhsAdmVo.setSpplyCorpCd(m.get("spplyCorpCd").toString());
				inWhsAdmVo.setLocationNo(m.get("locationNo").toString());
				inWhsAdmVo.setAreaCd(m.get("areaCd").toString());
				inWhsAdmVo.setFloorCd(m.get("floorCd").toString());
				
				inWhsAdmVo.setStatusCd("I");	//I : 입고, O : 출고, R : 요청출고
//				inWhsAdmVo.setInspectYn(m.get("inspectYn").toString());
				
				inWhsAdmVo.setRegId(Utils.getUserId());
				
				inWhsAdmService.preInWhsAdmCreate(inWhsAdmVo);
				
				jsonData.put("result", "ok");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//개별입고수정
	@RequestMapping(value="mm/individualAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> individualAdmUpdate(@RequestBody List<Map<String, Object>> inWhsAdmList) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			InWhsAdmVo inWhsAdmVo = new InWhsAdmVo();
			for(Map<String, Object> m :inWhsAdmList) {
				
				logger.info("개별입고수정:"+inWhsAdmVo);

				inWhsAdmVo.setPoNo(m.get("poNo").toString());	//개별입고일자
				inWhsAdmVo.setInSeq(m.get("inSeq").toString());	//개별입고일자
				
				inWhsAdmVo.setPreInWhsDate(m.get("preInWhsDate").toString());	//개별입고일자
				inWhsAdmVo.setPreInWhsQty(m.get("preInWhsQty").toString());		//가입고 수량
				inWhsAdmVo.setInWhsQty(m.get("preInWhsQty").toString());		//입고수량 가입고 수량과 동일하게 처리
				inWhsAdmVo.setRemainQty(m.get("preInWhsQty").toString());		//입고수량 가입고 수량과 동일하게 처리
				inWhsAdmVo.setInWhsDesc(m.get("inWhsDesc").toString());			//비고
//				inWhsAdmVo.setSpplyCorpCd(m.get("spplyCorpCd").toString());		//거래처
				inWhsAdmVo.setLocationNo(m.get("locationNo").toString());		//창고코드
				inWhsAdmVo.setAreaCd(m.get("areaCd").toString());
				inWhsAdmVo.setFloorCd(m.get("floorCd").toString());
				
				inWhsAdmVo.setRegId(Utils.getUserId());
				
				inWhsAdmService.preInWhsAdmUpdate(inWhsAdmVo);
				
				jsonData.put("result", "ok");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
}
