package mes.web.bs;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.bs.PurchaseOrderDtl;
import mes.domain.bs.PurchaseOrderOutputHistVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class PurchaseOrderAdmController {
	
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	
	private static final Logger logger = LoggerFactory.getLogger(PurchaseOrderAdmController.class);
	
	@Value("${factoryCode}") private String factoryCode;
	
	//영업관리 메인
	@RequestMapping(value = "/bssc0010", method = RequestMethod.GET)
	public String purchaseOrderAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 메인");

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
		purchaseOrderAdmVo.setPoDate(DateUtil.getToday("yyyymmdd"));
		String purchaseOrderSeq = purchaseOrderAdmService.selectPurchaseOrderSeq(purchaseOrderAdmVo);
		logger.info("purchaseOrderSeq = " + purchaseOrderSeq);
		model.addAttribute("purchaseOrderSeq", purchaseOrderSeq );

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("032"); // 화폐단위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("moneyUnitCd", systemCommonCodeList );		

		return "bs/bssc0010";
	}

	//영업관리 영업일보
	@RequestMapping(value = "/bssc0020", method = RequestMethod.GET)
	public String purchaseOrderAdmDailyReport(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 영업일보");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("089"); // 수기출고
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("outputCd", systemCommonCodeList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0020";
	}
	
	//영업관리 영업현황
	@RequestMapping(value = "/bssc0030", method = RequestMethod.GET)
	public String purchaseOrderAdmInfo(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 영업현황");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0030";
	}	
	
	//영업관리 수주집계표
	@RequestMapping(value = "/bssc0040", method = RequestMethod.GET)
	public String purchaseOrderAdmInfoJibgye(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 수주집계표");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0040";
	}	
	
	//영업관리 년도별 수주집계표
	@RequestMapping(value = "/bssc0050", method = RequestMethod.GET)
	public String purchaseOrderAdmInfoYear(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 년도별 수주집계표");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0050";
	}	
	
	//영업관리 수주집계표
	@RequestMapping(value = "/bssc0060", method = RequestMethod.GET)
	public String purchaseOrderAdmOutputJibgye(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 출고집계표");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0060";
	}	
	
	//영업관리 년도별 수주집계표
	@RequestMapping(value = "/bssc0070", method = RequestMethod.GET)
	public String purchaseOrderAdmOutputYear(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 년도별 출고집계표");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "bs/bssc0070";
	}	
	
	//영업관리 구매주문정보목록조회
	@RequestMapping(value = "/bs/purchaseOrderDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDataList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문정보 목록조회");
		try {
			purchaseOrderAdmVo.setFactoryCode(factoryCode);
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listPurchaseOrderAll(purchaseOrderAdmVo);
			jsonData.put("data", purchaseOrderAdmData);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보 목록조 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//영업관리 구매주문정보상세조회
	@RequestMapping(value = "/bs/purchaseOrderData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderData(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문정보 상세조회");
		try {
			purchaseOrderAdmVo = purchaseOrderAdmService.read(purchaseOrderAdmVo);
			jsonData.put("data", purchaseOrderAdmVo);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보 상세조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//영업관리 구매주문정보 삭제
	@RequestMapping(value = "/bs/purchaseOrderDelete", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDelete(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문정보 삭제");
		logger.info(purchaseOrderAdmVo.toString());
		try {
			//해당 PO로 출하된 제품이 있는지 확인 후 없으면 삭제 실행
			int count = purchaseOrderAdmService.purchaseOrderDeleteCheck(purchaseOrderAdmVo);
			if (count == 0) {
				purchaseOrderAdmService.purchaseOrderDelete(purchaseOrderAdmVo);
				jsonData.put("message", "삭제되었습니다.");
				jsonData.put("result", "ok");
				
				return jsonData;
			}
			jsonData.put("message", "해당 PO로 출고된 제품이 있습니다!<br>삭제 할 수 없습니다.");
			jsonData.put("result", "fail");
			
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보 삭제 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//영업관리 구매주문정보등록
	@RequestMapping(value = "/bs/purchaseOrderCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderCreate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문 정보등록 = "+ purchaseOrderAdmVo);
		
		try {
			String purchaseOrderSeq = purchaseOrderAdmService.selectPurchaseOrderSeq(purchaseOrderAdmVo);
			String poSeq = purchaseOrderAdmVo.getPoDate().concat("-" + purchaseOrderSeq); //PO시퀀스 재설정
			purchaseOrderAdmVo.setPoSeq(poSeq);
			purchaseOrderAdmVo.setOutputQty(0);
			purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getPoQty());		
			purchaseOrderAdmVo.setRegId(Utils.getUserId());
			purchaseOrderAdmService.create(purchaseOrderAdmVo);
			purchaseOrderSeq = purchaseOrderAdmService.selectPurchaseOrderSeq(purchaseOrderAdmVo); // 등록 후 등록날짜 변경에 따른  po시퀀스 재조회하여 UI 등록 시퀀스 설정
			
			String today = DateUtil.getToday("yyyymmdd");
			poSeq = today.concat("-" + purchaseOrderSeq);
			purchaseOrderAdmVo.setPoSeq(poSeq);

			logger.info("영업관리 구매주문정보 등록 완료");
			jsonData.put("message", "등록되었습니다.");
			jsonData.put("data", purchaseOrderAdmVo);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//영업관리 구매주문정보수정 가능여부 확인(출하여부 확인)
	@RequestMapping(value = "/bs/purchaseOrderAdmUpdateCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderAdmUpdateCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문정보수정 가능여부 확인(출하여부 확인)");
		purchaseOrderAdmVo.setUpdId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		try {
			int count = purchaseOrderAdmService.purchaseOrderDeleteCheck(purchaseOrderAdmVo);
			//출하기록 X
			if (count == 0) {
				jsonData.put("message", "수정 가능한 PO입니다.");
				jsonData.put("result", "ok");
			//출하기록 O
			} else {
				jsonData.put("message", "출하 기록이 있는 수정 가능한 PO입니다.");
				jsonData.put("result", "ok");
			}
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보수정 가능여부 확인(출하여부 확인) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	 }
		
	//영업관리 구매주문정보수정(출하여부 확인 포함)
	@RequestMapping(value = "/bs/purchaseOrderUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo, PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문 정보수정");
		purchaseOrderAdmVo.setUpdId(Utils.getUserId());
		purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		
		try {
			PurchaseOrderAdmVo readPurchaseOrderAdmVo = new PurchaseOrderAdmVo();
			
			List<PurchaseOrderOutputHistVo> readPurchaseOrderOutputHistVoData = purchaseOrderAdmService.readPurchaseOrderOutputHistList(purchaseOrderOutputHistVo);
			PurchaseOrderOutputHistVo readPurchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
			
			readPurchaseOrderAdmVo.setPoSeq(purchaseOrderAdmVo.getPoSeq());
			readPurchaseOrderAdmVo = purchaseOrderAdmService.read(readPurchaseOrderAdmVo);
			
			int count = purchaseOrderAdmService.purchaseOrderDeleteCheck(purchaseOrderAdmVo);
			//출하기록 X
			if (count == 0) {				
				//수정시 미출고량 = 오더량 - 출고량
				purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getPoQty() - readPurchaseOrderAdmVo.getOutputQty());
				purchaseOrderAdmService.update(purchaseOrderAdmVo);				
				jsonData.put("message", "수정되었습니다.");
				jsonData.put("result", "ok");
				
			//출하기록 O
			} else {
				
				//출하기록이 있는 PO 수정사항 중 오더량 or 제품코드이 변경되었다면
				if ( !(purchaseOrderAdmVo.getGoodsCd().equals(readPurchaseOrderAdmVo.getGoodsCd())
						&& (purchaseOrderAdmVo.getPoQty() == readPurchaseOrderAdmVo.getPoQty())) ) {
					
					purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getPoQty() - readPurchaseOrderAdmVo.getOutputQty());									
					purchaseOrderAdmService.update(purchaseOrderAdmVo);		
					
					int i = 1 ;
					
					for(PurchaseOrderOutputHistVo j : readPurchaseOrderOutputHistVoData) {		
						readPurchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq());
						readPurchaseOrderOutputHistVo.setPoGroup(Integer.toString(i));
						readPurchaseOrderOutputHistVo = purchaseOrderAdmService.readPurchaseOrderOutputHist(readPurchaseOrderOutputHistVo);	
						readPurchaseOrderOutputHistVo.setPoNo(purchaseOrderAdmVo.getPoNo());
						readPurchaseOrderOutputHistVo.setPoQty(purchaseOrderAdmVo.getPoQty());
						readPurchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
						purchaseOrderAdmService.updateOutputHist(readPurchaseOrderOutputHistVo);
						i++;
					}					
					jsonData.put("message", "수정되었습니다.");
					jsonData.put("result", "ok");
					
				//출하기록이 있으나 PO수정사항 중 오더량 and 제품코드가 변경X
				} else {
					//수정시 미출고량 = 오더량 - 출고량
					purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getPoQty() - readPurchaseOrderAdmVo.getOutputQty());					
					purchaseOrderAdmService.update(purchaseOrderAdmVo);
					
					int i = 1 ;
					
					for(PurchaseOrderOutputHistVo j : readPurchaseOrderOutputHistVoData) {		
						readPurchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq());
						readPurchaseOrderOutputHistVo.setPoGroup(Integer.toString(i));
						readPurchaseOrderOutputHistVo = purchaseOrderAdmService.readPurchaseOrderOutputHist(readPurchaseOrderOutputHistVo);	
						readPurchaseOrderOutputHistVo.setPoNo(purchaseOrderAdmVo.getPoNo());
						readPurchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
						purchaseOrderAdmService.updateOutputHist(readPurchaseOrderOutputHistVo);
						i++;
					}		
					jsonData.put("message", "수정되었습니다.");
					jsonData.put("result", "ok");
				}
				
			}
			
		}
		catch (Exception e) {
			logger.info("영업관리 구매주문정보수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	 }

	//영업관리 영업일보목록조회
	@RequestMapping(value = "/bs/purchaseOutputList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOutputList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 영업일보 목록조회" + purchaseOrderAdmVo.getOutputGubun());
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
					
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listPurchaseOrderDaily_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listPurchaseOrderDaily(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("영업관리 영업일보목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}	
	//영업관리 영업일보목록 상세조회
	@RequestMapping(value = "/bs/outputHistList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> outputHistList(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 영업일보 목록상세조회" + purchaseOrderOutputHistVo.getOutputGubun());
		try {
			//수주대비 출고현화에서 사용안함 
			if(factoryCode.equals("003") && "pdsc3040".equals(purchaseOrderOutputHistVo.getMenuAuth())) {
				String exceptPallet = purchaseOrderOutputHistVo.getExceptPallet();
				
				logger.info("제외할 파레트번호>>>" + exceptPallet);
				
				String exceptPallet1 = exceptPallet.replace("empty/", "");
				String exceptPallet2 = exceptPallet1.replace("/", ", ");
				purchaseOrderOutputHistVo.setExceptPallet(exceptPallet2);
			
			}
			
			List<PurchaseOrderOutputHistVo> purchaseOrderAdmData;
			
			if(factoryCode.equals("003") && !"pdsc3040".equals(purchaseOrderOutputHistVo.getMenuAuth())) {
				purchaseOrderAdmData = purchaseOrderAdmService.outputHistList_F3(purchaseOrderOutputHistVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.outputHistList(purchaseOrderOutputHistVo);				
			}
			/*List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}*/				
			jsonData.put("data", purchaseOrderAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("영업관리 영업일보목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}	
	//영업관리 제품 출하 내역 조회
	@RequestMapping(value = "/bs/inspectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectList(PurchaseOrderDtl purchaseOrderDtl) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 제품 출하 내역 조회");
		try {
			List<PurchaseOrderDtl> purchaseOrderDtlData = purchaseOrderAdmService.inspectList(purchaseOrderDtl);
			jsonData.put("data", purchaseOrderDtlData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("영업관리 제품 출하 내역 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}	
	//영업관리 출고이력목록조회
	@RequestMapping(value = "/bs/purchaseOutputHistList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOutputHistList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 구매주문정보 목록조회");
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listOutputHistAll(purchaseOrderAdmVo);
			jsonData.put("data", purchaseOrderAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("영업관리 영업일보목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}	
	
	
	//수주집계표 거래처/품목별 조회
	@RequestMapping(value = "/bs/purchaseOrderDealGoods", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDealGoods(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주집계표 거래처/품목별 조회");
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listDealGoods(purchaseOrderAdmVo);
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수주집계표 거래처/품목별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	//수주집계표 오더구분별 조회
	@RequestMapping(value = "/bs/purchaseOrderOrderGubun", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderOrderGubun(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수주집계표 오더구분별 조회");
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubun(purchaseOrderAdmVo);
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수주집계표 오더구분별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	//년도별 수주집계표 거래처/품목별 조회
	@RequestMapping(value = "/bs/purchaseOrderDealGoodsYear", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDealGoodsYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info(" 년도별 수주집계표 거래처/품목별 조회");
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listDealGoodsYear(purchaseOrderAdmVo);
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("년도별 수주집계표 거래처/품목별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	//년도별 수주집계표 오더구분별 조회
	@RequestMapping(value = "/bs/purchaseOrderOrderGubunYear", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderOrderGubunYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("년도별 수주집계표 오더구분별 조회");
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubunYear(purchaseOrderAdmVo);
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {		
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("년도별 수주집계표 오더구분별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	// 출고집계표 거래처/품목별 조회
	@RequestMapping(value = "/bs/purchaseOrderDealGoodsOutput", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDealGoodsOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고집계표 거래처/품목별 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealGoodsOutput_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealGoodsOutput(purchaseOrderAdmVo);
			}
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2 = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setTotalPrice3(new BigDecimal(m.getTotalPrice3()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출고집계표 거래처/품목별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	// 출고집계표 거래처별 조회
	@RequestMapping(value = "/bs/purchaseOrderDealOutput", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDealOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고집계표 거래처별 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealOutput_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealOutput(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2 = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setTotalPrice3(new BigDecimal(m.getTotalPrice3()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출고집계표 거래처별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	// 출고집계표 오더구분별 조회
	@RequestMapping(value = "/bs/purchaseOrderOrderGubunOutput", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderOrderGubunOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고집계표 오더구분별 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubunOutput_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubunOutput(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2 = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setTotalPrice3(new BigDecimal(m.getTotalPrice3()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출고집계표 오더구분별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	// 출고집계표 년도별 거래처/품목별 조회
	@RequestMapping(value = "/bs/purchaseOrderDealGoodsOutputYear", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderDealGoodsOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("년도별 출고집계표 거래처/품목별 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealGoodsOutputYear_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listDealGoodsOutputYear(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2 = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setTotalPrice3(new BigDecimal(m.getTotalPrice3()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("년도별 출고집계표 거래처/품목별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	// 출고집계표 년도별 오더구분별 조회
	@RequestMapping(value = "/bs/purchaseOrderOrderGubunOutputYear", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderOrderGubunOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("년도별 출고집계표 년도별오더구분별 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubunOutputYear_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listOrderGubunOutputYear(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2 = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setTotalPrice3(new BigDecimal(m.getTotalPrice3()).toPlainString());
				purchaseOrderAdmData2.add(m);
			}
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("년도별 출고집계표 오더구분별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	//영업관리 수기출고 목록 조회
	@RequestMapping(value = "/bs/purchaseOutputHistListSugi", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOutputHistListSugi(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 수기출하 리스트");
		try {
			List<PurchaseOrderOutputHistVo> purchaseOrderAdmData = purchaseOrderAdmService.readPurchaseOrderOutputHistSugi(purchaseOrderOutputHistVo);
			jsonData.put("data", purchaseOrderAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("영업관리 영업일보목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}	
	
	//영업관리 수기출고 등록
	@RequestMapping(value = "/bs/purchaseOrderHistOutputGubunCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderHistOutputGubunCreate(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 수기출고 등록 = "+ purchaseOrderOutputHistVo);
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
		PurchaseOrderOutputHistVo purchaseOrderOutputHistVo2 = new PurchaseOrderOutputHistVo();
		try {
			int outputQty = 0;
			String outputHistDate = "";
			String outputGubun = "";
			purchaseOrderAdmVo.setPoSeq(purchaseOrderOutputHistVo.getPoSeq());
			outputHistDate = purchaseOrderOutputHistVo.getOutputHistDate();
			outputGubun = purchaseOrderOutputHistVo.getOutputGubun();
			outputQty = purchaseOrderOutputHistVo.getOutputQty();
			int poGroup = purchaseOrderAdmService.productOutputCancelCheck(purchaseOrderAdmVo); //가장높은 poGroup			
			purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
			purchaseOrderOutputHistVo2 = purchaseOrderAdmService.readPurchaseOrderOutputHist(purchaseOrderOutputHistVo);
			
					
			
			int remain = 0;
			int preOutputSum = 0;
			if(purchaseOrderOutputHistVo2 == null) {			
				if(outputQty > purchaseOrderOutputHistVo.getPoQty() ) {
					jsonData.put("message", "출고수량이 오더량을 초과 할 수 없습니다.");		
					jsonData.put("result", "fail");
					
				} else {
					purchaseOrderOutputHistVo.setOutputQty(outputQty);				
					purchaseOrderOutputHistVo.setRemainQty(purchaseOrderOutputHistVo.getPoQty() - outputQty);				
					purchaseOrderOutputHistVo.setPreOutputQty(0);							
					poGroup = poGroup + 1;	
					
					purchaseOrderOutputHistVo.setApprovalCd("001");
					purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
					purchaseOrderOutputHistVo.setOutputGubun(outputGubun);
					purchaseOrderOutputHistVo.setOutputHistDate(outputHistDate);			
					purchaseOrderOutputHistVo.setRegId(Utils.getUserId());			
					purchaseOrderAdmService.histCreate(purchaseOrderOutputHistVo);
					
					
					purchaseOrderAdmVo.setRemainQty(outputQty);
					purchaseOrderAdmVo.setOutputQty(outputQty);
					purchaseOrderAdmVo.setUpdId(Utils.getUserId());				
					purchaseOrderAdmService.updatePurchaseAdmOutput(purchaseOrderAdmVo);
					jsonData.put("message", "등록되었습니다.");		
					jsonData.put("result", "ok");
					
				}			
			} else {
				purchaseOrderOutputHistVo.setApprovalCd("001");
				preOutputSum = purchaseOrderOutputHistVo2.getOutputQty() + purchaseOrderOutputHistVo2.getPreOutputQty();
				remain = purchaseOrderOutputHistVo2.getRemainQty() - purchaseOrderOutputHistVo.getOutputQty() ;	
				if(remain < 0) {
					jsonData.put("message", "출고수량이 잔여수량을 초과 할 수 없습니다.");		
					jsonData.put("result", "fail");
				} else {
					purchaseOrderOutputHistVo.setOutputQty(outputQty);
					purchaseOrderOutputHistVo.setRemainQty(remain);
					purchaseOrderOutputHistVo.setPreOutputQty(preOutputSum);			
					poGroup = poGroup + 1;			
					purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
					purchaseOrderOutputHistVo.setOutputGubun(outputGubun);
					purchaseOrderOutputHistVo.setOutputHistDate(outputHistDate);			
					purchaseOrderOutputHistVo.setRegId(Utils.getUserId());
					purchaseOrderAdmService.histCreate(purchaseOrderOutputHistVo);
					
					purchaseOrderAdmVo.setRemainQty(outputQty);
					purchaseOrderAdmVo.setOutputQty(outputQty);
					purchaseOrderAdmVo.setUpdId(Utils.getUserId());				
					purchaseOrderAdmService.updatePurchaseAdmOutput(purchaseOrderAdmVo);
					jsonData.put("message", "등록되었습니다.");		
					jsonData.put("result", "ok");
				}
				
				
			}
					
		
			logger.info("수기출고 등록 완료");
			
		}
		catch (Exception e) {
			logger.info("수기출고 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	//영업관리 수기출고 삭제
	@RequestMapping(value = "/bs/purchaseOrderHistOutputGubunDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseOrderHistOutputGubunDelete(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 수기출고 삭제 = "+ purchaseOrderOutputHistVo);
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
		PurchaseOrderOutputHistVo purchaseOrderOutputHistVo2 = new PurchaseOrderOutputHistVo();
		try {

			purchaseOrderAdmVo.setPoSeq(purchaseOrderOutputHistVo.getPoSeq());			
			int poGroup = purchaseOrderAdmService.productOutputCancelCheck(purchaseOrderAdmVo); //가장높은 poGroup			
			purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
			purchaseOrderOutputHistVo2 = purchaseOrderAdmService.readPurchaseOrderOutputHist(purchaseOrderOutputHistVo);

			if(purchaseOrderOutputHistVo2 == null) {				
				
			} else {
				if("001".equals(purchaseOrderOutputHistVo2.getOutputGubun())) {					
					jsonData.put("message", "마지막으로 출하된 제품이 수기출하가 된 제품이 아닙니다.");		
					jsonData.put("result", "fail");
				} else {								
					
					purchaseOrderAdmVo.setRemainQty(purchaseOrderOutputHistVo2.getOutputQty());
					purchaseOrderAdmVo.setOutputQty(purchaseOrderOutputHistVo2.getOutputQty());
					purchaseOrderAdmVo.setUpdId(Utils.getUserId());		
					purchaseOrderAdmService.deletePurchaseOrderOutputHist(purchaseOrderOutputHistVo);
					purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
					jsonData.put("message", "마지막으로 등록된 수기출하 제품이 삭제되었습니다.");		
					jsonData.put("result", "ok");
				}
				
			}
					
		
			logger.info("수기출고 삭제 완료");
			
		}
		catch (Exception e) {
			logger.info("수기출고 삭제 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	// 출고집계표 요약본
	@RequestMapping(value = "/bs/purchaseOrderListchulgojipgye", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderListchulgojipgye(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고집계표 요약본 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.listchulgojipgye_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.listchulgojipgye(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {						
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setRemainQty(Integer.parseInt(new BigDecimal(m.getRemainQty()).toPlainString()));
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				
				purchaseOrderAdmData2.add(m);
			}
			
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출고집계표 요약본 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	
	
	//샘플판매 목록 조회
	@RequestMapping(value = "/bs/purchaseOrderAdmSampleList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> purchaseOrderAdmSampleList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("샘플판매 목록 조회");
		try {
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData;
			
			if( factoryCode.equals("003") ) {
				purchaseOrderAdmData = purchaseOrderAdmService.purchaseOrderAdmSampleList_F3(purchaseOrderAdmVo);
			} else {
				purchaseOrderAdmData = purchaseOrderAdmService.purchaseOrderAdmSampleList(purchaseOrderAdmVo);
			}
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmData2  = new ArrayList<PurchaseOrderAdmVo>();
			for(PurchaseOrderAdmVo m : purchaseOrderAdmData) {						
				
				m.setTotalPrice1(new BigDecimal(m.getTotalPrice1()).toPlainString());
				m.setTotalPrice2(new BigDecimal(m.getTotalPrice2()).toPlainString());
				m.setRemainQty(Integer.parseInt(new BigDecimal(m.getRemainQty()).toPlainString()));
				m.setOutputPri(new BigDecimal(m.getOutputPri()).toPlainString());
				m.setNotOutputPri(new BigDecimal(m.getNotOutputPri()).toPlainString());
				
				purchaseOrderAdmData2.add(m);
			}
			
			jsonData.put("data", purchaseOrderAdmData2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("샘플판매 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다..");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}	

}
