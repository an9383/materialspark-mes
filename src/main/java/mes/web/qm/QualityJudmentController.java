package mes.web.qm;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.InspectInfoAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.MatrlInWhsRqtService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.po.WorkOrderService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class QualityJudmentController {
	
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private InspectInfoAdmService inspectInfoAdmService;
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private PdaService PdaService;
	@Inject
	private PreGoodsInventoryAdmService preGoodsInventoryAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private MatrlInWhsRqtService matrlInWhsRqtService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	@Value("${factoryCode}") private String facotryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(QualityJudmentController.class);
	
	//입출고관리 반품등록메인
	@RequestMapping(value = "/qmsc0170", method = RequestMethod.GET)
	public String qualityJudgmentMain(Locale locale, Model model) throws Exception {
		logger.info("품질판정 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
			
			systemCommonCodeVo.setBaseGroupCd("118"); // 자재불량유형
			systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("filmFaultyType", systemCommonCodeList );
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
        MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
        if("003".equals(facotryCode)) {
        	matrlInOutWhsAdmVo.setFactoryCode(facotryCode);
        	matrlInOutWhsAdmVo.setInWhsDateFrom(DateUtil.getDay("yyyy-mm-dd", -1));
        } else matrlInOutWhsAdmVo.setInWhsDateFrom(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setInWhsDateTo( DateUtil.getToday("yyyy-mm-dd"));
		matrlInOutWhsAdmVo.setTapTemp("1");
		List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmList = matrlInOutWhsAdmService.matrlFaultyTypeList(matrlInOutWhsAdmVo);
		model.addAttribute("matrlInOutWhsAdmList", matrlInOutWhsAdmList );
        
		return "qm/qmsc0170";
	}
	
	
	//입출고관리-자재 부적합현황 미승인&반품&실반품&폐기 로 상태변경
	@RequestMapping(value = "/qm/matrlInOutWhsInspectUpdateDtl_qmsc0170", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl_qmsc0170(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 부적합 상태 변경 = "+ matrlInOutWhsAdmList);
		try {
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("matrlInOutWhsAdmVo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcodeNo").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				if("009".equals(m.get("approvalCd").toString())) {
					matrlInOutWhsAdmVo.setStatusCd("A");
					matrlInOutWhsAdmVo.setFifoCheck("N");
				} else {
					matrlInOutWhsAdmVo.setStatusCd("I");
				}	
				
				if( m.get("frrrdType") != null ) {
					matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
				}
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				
				//재검일자
				if(facotryCode.equals("001") || facotryCode.equals("002") ) {
					matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());	
				} else if( facotryCode.equals("003") ) {
					//matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
					matrlInOutWhsAdmVo.setRetestDate(m.get("frrrdDate").toString());
					
					//PDA_pdsc0120인 경우레만 적용
					/*if( m.get("menuAuth").toString().equals("pdsc0120") ) {
						matrlInOutWhsAdmVo.setRemainQty(m.get("remainQty").toString());	
					}*/
					
				} else {
					jsonData.put("message", "시스템오류가 발생했습니다.");
					jsonData.put("result", "error");
					return jsonData;
				}
				
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				matrlInOutWhsAdmVo.setMatrlChargr(m.get("matrlChargr").toString());		
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());			
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);	//자재상태변경
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
				StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
				stockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", facotryCode);
				stockPaymentAdmService.stockPaymentMinus(stockPaymentAdmVoMinus);	//기존 위치 재고 -
				stockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, facotryCode);
				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//새 위치 재고 +
				
			}			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("품질관리 부적합 자재 상태변경 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//수입검사 합격 여부
	@RequestMapping(value = "/qm/inspectPassUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectPassUpdate_F3(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 합격여부");			
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();

			for(Map<String, Object> m : inspectList) {
				
				inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				inspectInfoAdmVo1.setInspectCd(m.get("inspectCd").toString());
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmVo1.setUpdId(Utils.getUserId());						
				
				inspectInfoAdmService.updatePass(inspectInfoAdmVo1);							
			}			

			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//입출고관리 반품목록조회
	@RequestMapping(value = "/qm/matrlFaultyTypeDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyTypeDataList_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 반품목록조회 = " + matrlInOutWhsAdmVo);
		try {
			matrlInOutWhsAdmVo.setFactoryCode(facotryCode);
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.matrlFaultyTypeList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 반품목록조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

 	//승인 여부 UPDATE
	@RequestMapping(value = "/qm/matrlInOutApprovalUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutApprovalUpdate(@RequestBody List<Map<String, Object>> approvalList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("승인 여부 Update" + approvalList);	
		try {
					
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();

			for(Map<String, Object> m : approvalList) {
				
				matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcodeNo").toString());
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				matrlInOutWhsAdmVo.setFrrrdDate(m.get("faultyDate").toString());
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());						
				
				matrlInOutWhsAdmService.matrlInOutApprovalUpdate(matrlInOutWhsAdmVo);
			}			

			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
}