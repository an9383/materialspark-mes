package mes.web.qm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.InspectInfoAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.po.WorkerChangeVo;
import mes.domain.qm.EdgeGoodsFaultyAdmVo;
import mes.domain.qm.GoodsFaultyAdmVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.GoodsPackService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.web.cm.Constants;
import mes.web.io.StockPaymentAdmController;
import mes.web.po.ProductionPerfTrayController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class GoodsInspectController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private InspectInfoAdmService inspectInfoService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;	
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private ProductionPerfTrayService productionPerfTrayService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	
	@Value("${factoryCode}") private String facotryCode;
	
	int appearFaultyCnt = 0;
	private static final Logger logger = LoggerFactory.getLogger(GoodsInspectController.class);
	/*------------------------엣지검사 시작------------------------*/
	//품질괄리 -완제품검사 엣지검사
	@RequestMapping(value = "/qmsc0050", method = RequestMethod.GET)
	public String qmsc0050GET(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-엣지검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		List<SystemCommonCodeVo>  workStatusCd = systemCommonCodeService.listAll(systemCommonCodeVo);
		systemCommonCodeVo.setBaseGroupCd("046"); // Sample수량
		List<SystemCommonCodeVo>  sampleCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		List<SystemCommonCodeVo>  edgeBigName = systemCommonCodeService.listAll(systemCommonCodeVo);
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		List<SystemCommonCodeVo>  edgeSmallName = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		
		
		model.addAttribute("workStatusCd", workStatusCd );
		model.addAttribute("sampleCount", sampleCount );
		model.addAttribute("edgeBigName", edgeBigName );
		model.addAttribute("edgeSmallName", edgeSmallName );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc0050";
	}
	
	//품질괄리 -완제품검사 엣지검사 - 솔브레인SLD(3공장)
	@RequestMapping(value = "/qmsc3050", method = RequestMethod.GET)
	public String qmsc3050(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-엣지검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("046"); // Sample수량
		List<SystemCommonCodeVo>  sampleCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("sampleCount", sampleCount );
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
//		systemCommonCodeVo.setBaseGroupCd("088"); // 외관검사 소분류
//		List<SystemCommonCodeVo> systemCommonCd = systemCommonCodeService.listAll(systemCommonCodeVo);
//		model.addAttribute("systemCommonCd", systemCommonCd);
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc3050";
	}
	
	//품질괄리 -완제품검사 엣지검사 - 머티리얼즈파크(2공장)
	@RequestMapping(value = "/qmsc2050", method = RequestMethod.GET)
	public String qmsc2050(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-엣지검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("046"); // Sample수량
		List<SystemCommonCodeVo>  sampleCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("sampleCount", sampleCount );
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc2050";
	}
	
	//품질괄리 -(트레이)엣지검사 - 머티리얼즈파크(2공장)
	@RequestMapping(value = "/qmsc2140", method = RequestMethod.GET)
	public String qmsc2140(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-엣지검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("046"); // Sample수량
		List<SystemCommonCodeVo>  sampleCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("sampleCount", sampleCount );
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인 사용자 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인 사용자 사번
		
		return "qm/qmsc2140";
	}
	
	//엣지검사완료 목록조회
	@RequestMapping(value = "qm/workOrderOutputSubList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderOutputSubList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사완료 목록조회");
		try {
			List<WorkOrdOutputSubVo> workOrdOutputSubList = goodsInspectService.workOrderOutputSubList(workOrdOutputSubVo);
			jsonData.put("data", workOrdOutputSubList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("엣지검사 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 상세조회(엣지, 외관검사에서 사용)
	@RequestMapping(value = "qm/readWorkOrderOutputSub", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readWorkOrderOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 상세조회(엣지, 외관검사에서 사용)");
		logger.info("받은 값 : " + workOrdOutputSubVo);
		
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.readWorkOrderOutputSub(workOrdOutputSubVo);
			jsonData.put("data", readWorkOrdOutputSubVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//엣지 & 외관검사 바코드스캔 (작업지시 조회)
	//@RequestMapping(value = "qm/barcodeScan", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> barcodeScanGET(WorkOrderVo workOrderVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("작업지시 조회(외관검사)");
	//	logger.info("받은 값 : " + workOrderVo);
	//	try {
	//		WorkOrderVo workOrderData = goodsInspectService.barcodeScan(workOrderVo);
	//		jsonData.put("data", workOrderData);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("작업지시 조회 실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "error");
	//	}
	//	return jsonData;
	//	
	//}
	
	//엣지 & 외관검사 바코드스캔 (작업지시 조회) - 생산실적 기준 주자재로 변경 후 - 1공장
	@RequestMapping(value = "qm/scanWorkOrdOutputSubOrdLotNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> scanWorkOrdOutputSubOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산ordLotNo 조회");
		logger.info("받은 값 : " + workOrdOutputSubVo);
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			jsonData.put("data", readWorkOrdOutputSubVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산ordLotNo 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//엣지검사 샘플,불량 등록
	@RequestMapping(value = "qm/edgeCheckInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckInsert(@RequestBody List<Map<String, Object>> edgeInspectList) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사 샘플,불량 등록");
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setMenuAuth(edgeInspectList.get(0).get("menuAuth").toString());
			workOrdOutputSubVo.setEdgeInspctDate(edgeInspectList.get(0).get("edgeInspctDate").toString());
			workOrdOutputSubVo.setOrdLotNo(edgeInspectList.get(0).get("ordLotNo").toString());
			//workOrdOutputSubVo.setEdgeRollFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeRollFaultySize").toString()));
			//workOrdOutputSubVo.setEdgeSymbolFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeSymbolFaultySize").toString()));
			//workOrdOutputSubVo.setEdgeBurFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeBurFaultySize").toString()));
			workOrdOutputSubVo.setEdgeInspctCharger(edgeInspectList.get(0).get("edgeInspctCharger").toString());
			workOrdOutputSubVo.setUserInputInspctCnt(Integer.parseInt(edgeInspectList.get(0).get("userInputInspctCnt").toString()));
			workOrdOutputSubVo.setEdgeSampleCnt(Integer.parseInt(edgeInspectList.get(0).get("edgeSampleCnt").toString()));
			workOrdOutputSubVo.setEdgeFaultyCnt(Integer.parseInt(edgeInspectList.get(0).get("edgeFaultyCnt").toString()));
			workOrdOutputSubVo.setSubWorkStatusCd(edgeInspectList.get(0).get("subWorkStatusCd").toString());
			workOrdOutputSubVo.setWorkOrdNo(edgeInspectList.get(0).get("workOrdNo").toString());
			workOrdOutputSubVo.setLotNo(edgeInspectList.get(0).get("lotNo").toString());
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if ("C".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				//int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt();	//엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
				int edgeOutputCnt = workOrdOutputSubVo.getUserInputInspctCnt() - workOrdOutputSubVo.getEdgeFaultyCnt();	//엣지양품수량 = 사용자 입력 실 검사수량 - 엣지불량수량
				workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
				//logger.info("엣지 양품수량 : (" + edgeOutputCnt + ") = 읽어온 생산수량 : (" + readWorkOrdOutputSubVo.getTotalCnt() + ") - 엣지불량 수량 : (" + workOrdOutputSubVo.getEdgeFaultyCnt() + ")");
				logger.info("엣지 양품수량 : (" + edgeOutputCnt + ") = 읽어온 생산수량 : (" + workOrdOutputSubVo.getUserInputInspctCnt() + ") - 엣지불량 수량 : (" + workOrdOutputSubVo.getEdgeFaultyCnt() + ")");
				workOrdOutputSubVo.setSubWorkStatusCd("E");
				workOrdOutputSubVo.setUpdId(Utils.getUserId());
				goodsInspectService.edgeCheckInsert(workOrdOutputSubVo);
				
				EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
				edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
				// 엣지검사 등록(엣지불량 TB Insert) 코드화 
				for(Map<String,Object> m : edgeInspectList) {
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
					edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
					edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
					edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
					edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
					edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());
					goodsInspectService.edgeCheckInsertCode(edgeGoodsFaultyAdmVo);				
				}
				
				jsonData.put("message", "엣지검사 등록되었습니다.");
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", readWorkOrdOutputSubVo.getSubWorkStatusNm() + " 상태의 작업지시입니다.<br> 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("엣지검사 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	/*@RequestMapping(value = "qm/edgeCheckInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckInsert(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사 샘플,불량 등록");
		logger.info("받은 값 : " + workOrdOutputSubVo);
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if ("C".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				//int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt();	//엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
				int edgeOutputCnt = workOrdOutputSubVo.getUserInputInspctCnt() - workOrdOutputSubVo.getEdgeFaultyCnt();	//엣지양품수량 = 사용자 입력 실 검사수량 - 엣지불량수량
				workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
				//logger.info("엣지 양품수량 : (" + edgeOutputCnt + ") = 읽어온 생산수량 : (" + readWorkOrdOutputSubVo.getTotalCnt() + ") - 엣지불량 수량 : (" + workOrdOutputSubVo.getEdgeFaultyCnt() + ")");
				logger.info("엣지 양품수량 : (" + edgeOutputCnt + ") = 읽어온 생산수량 : (" + workOrdOutputSubVo.getUserInputInspctCnt() + ") - 엣지불량 수량 : (" + workOrdOutputSubVo.getEdgeFaultyCnt() + ")");
				workOrdOutputSubVo.setSubWorkStatusCd("E");
				workOrdOutputSubVo.setUpdId(Utils.getUserId());
				goodsInspectService.edgeCheckInsert(workOrdOutputSubVo);
				jsonData.put("message", "엣지검사 등록되었습니다.");
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", readWorkOrdOutputSubVo.getSubWorkStatusNm() + " 상태의 작업지시입니다.<br> 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("엣지검사 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}*/
	
	//엣지검사 샘플,불량수정
	@RequestMapping(value = "qm/edgeCheckUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckUpdate(@RequestBody List<Map<String, Object>> edgeInspectList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사 샘플,불량 수정");
		
		WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		workOrdOutputSubVo.setMenuAuth(edgeInspectList.get(0).get("menuAuth").toString());
		workOrdOutputSubVo.setEdgeInspctDate(edgeInspectList.get(0).get("edgeInspctDate").toString());
		workOrdOutputSubVo.setOrdLotNo(edgeInspectList.get(0).get("ordLotNo").toString());
		//workOrdOutputSubVo.setEdgeRollFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeRollFaultySize").toString()));
		//workOrdOutputSubVo.setEdgeSymbolFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeSymbolFaultySize").toString()));
		//workOrdOutputSubVo.setEdgeBurFaultySize(Float.parseFloat(edgeInspectList.get(0).get("edgeBurFaultySize").toString()));
		workOrdOutputSubVo.setEdgeInspctCharger(edgeInspectList.get(0).get("edgeInspctCharger").toString());
		workOrdOutputSubVo.setUserInputInspctCnt(Integer.parseInt(edgeInspectList.get(0).get("userInputInspctCnt").toString()));
		workOrdOutputSubVo.setEdgeSampleCnt(Integer.parseInt(edgeInspectList.get(0).get("edgeSampleCnt").toString()));
		workOrdOutputSubVo.setEdgeFaultyCnt(Integer.parseInt(edgeInspectList.get(0).get("edgeFaultyCnt").toString()));
		workOrdOutputSubVo.setSubWorkStatusCd(edgeInspectList.get(0).get("subWorkStatusCd").toString());
		workOrdOutputSubVo.setWorkOrdNo(edgeInspectList.get(0).get("workOrdNo").toString());
		workOrdOutputSubVo.setLotNo(edgeInspectList.get(0).get("lotNo").toString());
		
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if (workOrdOutputSubVo.getSubWorkStatusCd().equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				if ("E".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
					//int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - readWorkOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
					int edgeOutputCnt = workOrdOutputSubVo.getUserInputInspctCnt() - workOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 사용자 입력 실 검사수량 - 엣지불량수량
					workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
					jsonData.put("message", "엣지검사 수정되었습니다.");
				} else if ("A".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
					//int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - readWorkOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
					int edgeOutputCnt = workOrdOutputSubVo.getUserInputInspctCnt() - workOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 사용자 입력 실 검사수량 - 엣지불량수량
					workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
					//int appearOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt() - readWorkOrdOutputSubVo.getAppearFaultyCnt(); //외관양품수량 = 읽어온 생산수량 - 엣지불량수량 - 읽어온 외관불량수량
					int appearOutputCnt = workOrdOutputSubVo.getUserInputInspctCnt() - workOrdOutputSubVo.getEdgeFaultyCnt() - readWorkOrdOutputSubVo.getAppearFaultyCnt(); //외관양품수량 = 읽어온 생산수량 - 사용자 입력 실 검사수량 - 읽어온 외관불량수량
					workOrdOutputSubVo.setAppearOutputCnt(appearOutputCnt);
					jsonData.put("message", "엣지검사 수정되었습니다!<br>외관검사 양품수량도 수정되었습니다!");
				}
				
			} else {
				jsonData.put("message", "생산LotNo 상태가 변경되었습니다!<br>다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}
			goodsInspectService.edgeCheckUpdate(workOrdOutputSubVo); // 작업지시 생산수량 서브 업데이트 
			
			// ↓ 밑으로는 코드화된 테이블 업데이트 
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
			edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
			edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
			goodsInspectService.edgeCheckDeleteCode(edgeGoodsFaultyAdmVo);
			for(Map<String,Object> m : edgeInspectList) {
				edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
				edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
				edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
				edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());
				goodsInspectService.edgeCheckInsertCode(edgeGoodsFaultyAdmVo);				
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("엣지검사 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	/*------------------------엣지검사 끝------------------------*/
	
	/*------------------------외관검사 시작------------------------*/
	//품질괄리 -완제품검사 외관검사
	@RequestMapping(value = "/qmsc0060", method = RequestMethod.GET)
	public String qmsc0060(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-외관검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd2", systemCommonCodeList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc0060";
	}
	
	//품질괄리 -완제품검사 외관검사 - 솔브레인SLD(3공장)
	@RequestMapping(value = "/qmsc3060", method = RequestMethod.GET)
	public String qmsc3060(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-외관검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc3060";
	}
	
	//품질괄리 -완제품검사 외관검사 - 머티리얼즈파크(2공장)
	@RequestMapping(value = "/qmsc2060", method = RequestMethod.GET)
	public String qmsc2060(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-외관검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		return "qm/qmsc2060";
	}
	
	//품질괄리 -(트레이)외관검사 - 머티리얼즈파크(2공장)
	@RequestMapping(value = "/qmsc2130", method = RequestMethod.GET)
	public String qmsc2130(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 완제품검사-외관검사");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인 사용자 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인 사용자 사번
		
		return "qm/qmsc2130";
	}
	
	//품질괄리 -(트레이)외관검사 - 솔브레인(4층)
	@RequestMapping(value = "/qmsc3310", method = RequestMethod.GET)
	public String qmsc3310(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 외관검사(4층)");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인 사용자 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인 사용자 사번
		
		return "qm/qmsc3310";
	}
	
	//품질괄리 -(트레이)외관검사 - 솔브레인(6층)
	@RequestMapping(value = "/qmsc3320", method = RequestMethod.GET)
	public String qmsc3320(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 외관검사(4층)");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("092"); // 검사상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workStatusCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인 사용자 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인 사용자 사번
		
		return "qm/qmsc3320";
	}
	
	//품질괄리 -완제품검사 날짜로 작업지시 목록조회(외관검사)
	@RequestMapping(value = "qm/readGoodsFaultyAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readGoodsFaultyAdmDataListGET(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("외관검사 목록 조회");

		try {
			List<WorkOrderVo> goodsFaultyAdmDataList = goodsInspectService.goodsFaultyAdmDataList(workOrderVo);
			jsonData.put("data", goodsFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("외관검사 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//외관검사 불량 등록
	@RequestMapping(value = "qm/appearCheckInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckInsertPOST(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("외관검사 불량 등록");
		
		GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
		WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		workOrdOutputSubVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
		workOrdOutputSubVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
		goodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
		goodsFaultyAdmVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
		try {
			WorkOrdOutputSubVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if ("E".equals(readWorkOrderData.getSubWorkStatusCd())) {
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
					goodsFaultyAdmVo.setOrdLotNo(m.get("ordLotNo").toString());
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
					goodsFaultyAdmVo.setRegId(Utils.getUserId());
					
					goodsInspectService.appearCheckInsertCode(goodsFaultyAdmVo);				
				}
				
				int appearOutputCnt = Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString());	//외관양품수량 = 엣지양품수량 - 외관불량수량
				workOrdOutputSubVo.setAppearOutputCnt(appearOutputCnt);											//외관 양품수량
				workOrdOutputSubVo.setAppearInspctCharger(inspectList.get(0).get("inspctChargr").toString());
				workOrdOutputSubVo.setAppearInspctDate(inspectList.get(0).get("faultyRegDate").toString());
				workOrdOutputSubVo.setAppearFaultyCnt(Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
				goodsInspectService.appearWorkOrderSubInsert(workOrdOutputSubVo);
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				workOrdOutputSubVo.setGoodsCd(readWorkOrderData.getGoodsCd());
				workOrdOutputSubVo.setWorkOrdLotNo(readWorkOrderData.getWorkOrdLotNo());
				StockPaymentAdmVo goodsInspctStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				goodsInspctStockPaymentAdmVoPlus = StockPaymentAdmController.goodsInspctStockPaymentPlus(workOrdOutputSubVo, facotryCode);
				stockPaymentAdmService.stockPaymentPlus(goodsInspctStockPaymentAdmVoPlus);	//새 위치 재고 +
				
				logger.info("외관검사 불량 등록 성공");
				jsonData.put("message", "외관검사 등록되었습니다.");
				jsonData.put("result", "ok");
				
			} else {
				jsonData.put("message", readWorkOrderData.getSubWorkStatusNm() + " 상태의 작업지시입니다.<br> 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}
			
		}
		catch (Exception e) {
			logger.info("외관검사 불량 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//외관검사 불량 수정
	@RequestMapping(value = "qm/appearCheckUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckUpdate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("외관검사 불량 업데이트");
		
		GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
		WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		workOrdOutputSubVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
		workOrdOutputSubVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
		goodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
		goodsFaultyAdmVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
		goodsInspectService.appearCheckDeleteCode(goodsFaultyAdmVo);	
		try {
			for(Map<String,Object> m : inspectList) {
				goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
				goodsFaultyAdmVo.setOrdLotNo(m.get("ordLotNo").toString());
				goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
				goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				goodsFaultyAdmVo.setRegId(Utils.getUserId());					
				
				goodsInspectService.appearCheckInsertCode(goodsFaultyAdmVo);	
			}					
			
			int appearOutputCnt = Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString());	//외관양품수량 = 엣지양품수량 - 외관불량수량
			workOrdOutputSubVo.setAppearOutputCnt(appearOutputCnt);											//외관 양품수량
			workOrdOutputSubVo.setAppearInspctCharger(inspectList.get(0).get("inspctChargr").toString());
			workOrdOutputSubVo.setAppearInspctDate(inspectList.get(0).get("faultyRegDate").toString());
			workOrdOutputSubVo.setAppearFaultyCnt(Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
			goodsInspectService.appearWorkOrderSubInsert(workOrdOutputSubVo);
			
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			WorkOrdOutputSubVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			workOrdOutputSubVo.setGoodsCd(readWorkOrderData.getGoodsCd());
			workOrdOutputSubVo.setWorkOrdLotNo(readWorkOrderData.getWorkOrdLotNo());
			StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
			StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
			stockPaymentAdmVoMinus = StockPaymentAdmController.goodsInspctStockPaymentMinus(workOrdOutputSubVo, "O", facotryCode);
			stockPaymentAdmService.stockPaymentMinus(stockPaymentAdmVoMinus);	//새 위치 재고 +
			stockPaymentAdmVoPlus = StockPaymentAdmController.goodsInspctStockPaymentPlus(workOrdOutputSubVo, facotryCode);
			stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//새 위치 재고 +
			
			jsonData.put("message", "외관검사 불량 수정되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("외관검사 불량 업데이트 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//외관검사 불량 등록 후 작업지시 외관합계 Insert(Update)
	//@RequestMapping(value = "qm/appearWorkOrderInsert", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> tappearWorkOrderInsertPOST(WorkOrderVo workOrderVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("외관검사 불량합계 작업지시에 업데이트");
	//	logger.info("받은 값 : " + workOrderVo);
	//	try {
	//		//먼저 엣지양품수량 확인.
	//		WorkOrderVo readWorkOrderData = goodsInspectService.barcodeScan(workOrderVo);
	//		int appearOutputCnt = readWorkOrderData.getEdgeOutputCnt() - appearFaultyCnt;	//외관양품수량 = 엣지양품수량 - 외관불량수량
	//		logger.info("외관 양품수량 : ("+appearOutputCnt+") = 읽어온 엣지양품 수량 : ("+readWorkOrderData.getEdgeOutputCnt()+") - 엣지불량 수량 : ("+appearFaultyCnt+")");
	//		workOrderVo.setAppearOutputCnt(appearOutputCnt);	//외관 양품수량
	//		logger.info("불량 계산 후 : " + workOrderVo);
	//		workOrderVo.setAppearFaultyCnt(appearFaultyCnt);
	//		goodsInspectService.appearWorkOrderInsert(workOrderVo);
	//		jsonData.put("data", appearFaultyCnt);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("엣지검사 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	appearFaultyCnt = 0;
	//	return jsonData;
	//}
	
	//외관불량TB 상세조회
	@RequestMapping(value = "qm/readGoodsFaultyAdm", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readGoodsFaultyAdmGET(GoodsFaultyAdmVo goodsFaultyAdm) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 조회(외관검사)");
		logger.info("받은 값 : " + goodsFaultyAdm);
		try {
			List<GoodsFaultyAdmVo> readGoodsFaultyAdm = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdm);
			jsonData.put("data", readGoodsFaultyAdm);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("외관불량 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//(트레이)외관불량TB 상세조회
	@RequestMapping(value = "qm/readTrayGoodsFaultyAdm_F2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readTrayGoodsFaultyAdm_F2(GoodsFaultyAdmVo goodsFaultyAdm) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("(트레이)외관불량TB 상세조회");
		logger.info("받은 값 : " + goodsFaultyAdm);
		try {
			goodsFaultyAdm.setFactoryCode(facotryCode);
			List<GoodsFaultyAdmVo> readGoodsFaultyAdm = goodsInspectService.readTrayGoodsFaultyAdmCode(goodsFaultyAdm);
			GoodsFaultyAdmVo goodsFaultyAdmReadVo = new GoodsFaultyAdmVo();
			if(readGoodsFaultyAdm.size() != 0) {
				goodsFaultyAdmReadVo = readGoodsFaultyAdm.get(0);			
				int visionCnt = 0;
				String seq = "";
				if(facotryCode.equals("003")) {					
					for(GoodsFaultyAdmVo m : readGoodsFaultyAdm) {
						if(m.getSeq() != null) {
							if(m.getSeq().equals(seq)) {
								
							} else {
								seq = m.getSeq();
								visionCnt += Integer.parseInt(m.getVisionInspCnt());
							}
						}
					}
					goodsFaultyAdmReadVo.setVisionInspCnt(Integer.toString(visionCnt));
				}
				
				readGoodsFaultyAdm.set(0,goodsFaultyAdmReadVo);
			}
			jsonData.put("data", readGoodsFaultyAdm);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("(트레이)외관불량TB 상세 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	/*------------------------외관검사 끝------------------------*/
	//품질관리 - 수입검사현황
	@RequestMapping(value = "/qmsc0100", method = RequestMethod.GET)
	public String qmsc0100GET(Locale locale, Model model) throws Exception {

		logger.info("수입검사현황 페이지");
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("managementCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("043"); // 수입검사 이상여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		return "qm/qmsc0100";
	}
	
	//품질관리 - 수입검사현황 (SLD)
	@RequestMapping(value = "/qmsc3100", method = RequestMethod.GET)
	public String qmsc3100GET(Locale locale, Model model) throws Exception {

		logger.info("수입검사현황 페이지");
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("managementCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("043"); // 수입검사 이상여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		return "qm/qmsc3100";
	}
	
	//품질관리 - 수입검사현황 (SLD)
	@RequestMapping(value = "/qmsc3110", method = RequestMethod.GET)
	public String qmsc3110GET(Locale locale, Model model) throws Exception {

		logger.info("수입검사현황 페이지");
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("managementCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("043"); // 수입검사 이상여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		return "qm/qmsc3110";
	}
	
	//품질관리 수입검사현황 자재명 리스트
	@RequestMapping(value = "/qm/inspectMatrlCodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectMatrlCodeList(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사현황 검색일 자재명List");
		try {
			List<InspectInfoAdmVo> matrlCdInOutList = inspectInfoService.inspectMatrlCodeList(inspectInfoAdmVo);
			jsonData.put("data", matrlCdInOutList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("수입검사현황 검색일 자재명List");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//수입검사현황 목록 조회
	@RequestMapping(value = "qm/inspectionListRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectionListReadGet(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사현황 목록 조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();			
			systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";		
			String codeList2 = "";	
			String codeListReal = "";
			String[] codeListArray = new String[45];
			String[] codeListArray2 = new String[45];
			String[] codeListRealArray = new String[45];
			int idx = 0, i = 1;
			//기존 공통코드에서 불러오는방식
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				/*if(m.getEtc1().equals(inspectInfoAdmVo.getMatrlGubunCd())) {
					codeList += "[" + m.getBaseCd() + "]" + ",";
					codeList2 += "[" + m.getBaseCd() + "]" + ",";
					codeListArray[idx] = m.getBaseCd();					
					codeListArray2[idx] = m.getBaseCd();	
					logger.info("수입검사현황 목록 조회" + codeListArray[idx] );
					idx++;
				} */
				codeListReal += "[" + m.getBaseCd() + "]" + ",";
				codeListRealArray[idx] = m.getBaseCd();			
				idx++;
			}
			
			// 공통코드를 45개까지만 등록하기로함. 
			for(i=1; i<46; i++) {
				codeList += "[" + String.format("%03d", i) + "]" + ",";
				codeList2 += "[" + String.format("%03d", i) + "]" + ",";
				codeListArray[i-1] = String.format("%03d", i);				
				codeListArray2[i-1] = String.format("%03d", i);
			}
			
			
			
			
			inspectInfoAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			inspectInfoAdmVo.setCodeList2(codeList2.substring(0,codeList2.length()-1));					
			inspectInfoAdmVo.setCodeListReal(codeListReal.substring(0,codeListReal.length()-1));		
			List<Map<String, String>> inspectInfoAdmList = new ArrayList<Map<String, String>>();
			if(facotryCode.equals("003")) {
				 inspectInfoAdmList = inspectInfoService.inspectListReadFac3(inspectInfoAdmVo);
			} else {
				 inspectInfoAdmList = inspectInfoService.inspectListRead(inspectInfoAdmVo);
			}
			
			
			
			List<InspectInfoAdmVo> dataList = new ArrayList<InspectInfoAdmVo>();
			for(Map<String, String> m : inspectInfoAdmList) {
				InspectInfoAdmVo inspectInfoAdmVoData = new InspectInfoAdmVo();
			
				
				inspectInfoAdmVoData.setRegDate(m.get("REG_DATE"));

				inspectInfoAdmVoData.setMatrlCd(m.get("MATRL_CD").toString());
				inspectInfoAdmVoData.setMatrlNm(m.get("MATRL_NM").toString());
				inspectInfoAdmVoData.setPreInWhsQty(m.get("PRE_IN_WHS_QTY").toString());
				inspectInfoAdmVoData.setInWhsQty(m.get("IN_WHS_QTY").toString());
				inspectInfoAdmVoData.setDiffQty(m.get("DIFF_QTY").toString());
				inspectInfoAdmVoData.setPreInWhsDate(m.get("PRE_IN_WHS_DATE").toString());
				inspectInfoAdmVoData.setDealCorpNm(m.get("DEAL_CORP_NM").toString());				
				inspectInfoAdmVoData.setInspectCd(m.get("INSPECT_CD").toString());
				inspectInfoAdmVoData.setInspectNm(m.get("INSPECT_NM").toString());
				inspectInfoAdmVoData.setMatrlGubunCd(m.get("MATRL_GUBUN_CD"));
				
				inspectInfoAdmVoData.setFileNm(m.get("FILE_NM"));
				inspectInfoAdmVoData.setFileGroup(String.valueOf(m.get("FILE_GROUP")));
				
				
				if(facotryCode.equals("003")) {
					inspectInfoAdmVoData.setLotNo(m.get("MAIN_LOT_NO").toString());
					inspectInfoAdmVoData.setInWhsGroupSeq(m.get("MAIN_IN_WHS_GROUP_SEQ"));	
				} else {
					inspectInfoAdmVoData.setLotNo(m.get("LOT_NO").toString());
					inspectInfoAdmVoData.setInWhsGroupSeq(m.get("IN_WHS_GROUP_SEQ"));	
				}
				
				
				
				inspectInfoAdmVoData.setInWhsDate(m.get("IN_WHS_DATE"));
				inspectInfoAdmVoData.setStatusCd(m.get("STATUS_CD"));
				inspectInfoAdmVoData.setStatusNm(m.get("STATUS_NM"));
				inspectInfoAdmVoData.setApprovalCd(m.get("APPROVAL_CD"));
				inspectInfoAdmVoData.setApprovalNm(m.get("APPROVAL_NM"));
				inspectInfoAdmVoData.setFrrrdDate(m.get("FRRRD_DATE"));
				inspectInfoAdmVoData.setFrrrdType(m.get("FRRRD_TYPE"));
				inspectInfoAdmVoData.setRetestDate(m.get("RETEST_DATE"));
				
				//inspectInfoAdmVoData.setRegDate(m.get("REG_DATE").toString());							
				if(codeListRealArray[0] != null) {
				inspectInfoAdmVoData.setOutInspectItem1(String.valueOf(m.get(String.valueOf(codeListRealArray[0]))));
				}
				if(codeListRealArray[1] != null) {
				inspectInfoAdmVoData.setOutInspectItem2(String.valueOf(m.get(String.valueOf(codeListRealArray[1]))));
				}
				if(codeListRealArray[2] != null) {
				inspectInfoAdmVoData.setOutInspectItem3(String.valueOf(m.get(String.valueOf(codeListRealArray[2]))));
				}
				if(codeListRealArray[3] != null) {
					inspectInfoAdmVoData.setOutInspectItem4(String.valueOf(m.get(String.valueOf(codeListRealArray[3]))));
				}
				if(codeListRealArray[4] != null) {
					inspectInfoAdmVoData.setOutInspectItem5(String.valueOf(m.get(String.valueOf(codeListRealArray[4]))));
				}
				if(codeListRealArray[5] != null) {
					inspectInfoAdmVoData.setOutInspectItem6(String.valueOf(m.get(String.valueOf(codeListRealArray[5]))));
				}
				if(codeListRealArray[6] != null) {
					inspectInfoAdmVoData.setOutInspectItem7(String.valueOf(m.get(String.valueOf(codeListRealArray[6]))));
				}
				if(codeListRealArray[7] != null) {
					inspectInfoAdmVoData.setOutInspectItem8(String.valueOf(m.get(String.valueOf(codeListRealArray[7]))));
				}
				if(codeListRealArray[8] != null) {
					inspectInfoAdmVoData.setOutInspectItem9(String.valueOf(m.get(String.valueOf(codeListRealArray[8]))));
				}
				if(codeListRealArray[9] != null) {
					inspectInfoAdmVoData.setOutInspectItem10(String.valueOf(m.get(String.valueOf(codeListRealArray[9]))));
				}
				if(codeListRealArray[10] != null) {
					inspectInfoAdmVoData.setOutInspectItem11(String.valueOf(m.get(String.valueOf(codeListRealArray[10]))));
				}
				if(codeListRealArray[11] != null) {
					inspectInfoAdmVoData.setOutInspectItem12(String.valueOf(m.get(String.valueOf(codeListRealArray[11]))));
				}
				if(codeListRealArray[12] != null) {
					inspectInfoAdmVoData.setOutInspectItem13(String.valueOf(m.get(String.valueOf(codeListRealArray[12]))));
				}
				if(codeListRealArray[13] != null) {
					inspectInfoAdmVoData.setOutInspectItem14(String.valueOf(m.get(String.valueOf(codeListRealArray[13]))));
				}
				if(codeListRealArray[14] != null) {
					inspectInfoAdmVoData.setOutInspectItem15(String.valueOf(m.get(String.valueOf(codeListRealArray[14]))));
				}
				//
				if(codeListRealArray[15] != null) {
					inspectInfoAdmVoData.setOutInspectItem16(String.valueOf(m.get(String.valueOf(codeListRealArray[15]))));
				}
				if(codeListRealArray[16] != null) {
					inspectInfoAdmVoData.setOutInspectItem17(String.valueOf(m.get(String.valueOf(codeListRealArray[16]))));
				}
				if(codeListRealArray[17] != null) {
					inspectInfoAdmVoData.setOutInspectItem18(String.valueOf(m.get(String.valueOf(codeListRealArray[17]))));
				}
				if(codeListRealArray[18] != null) {
					inspectInfoAdmVoData.setOutInspectItem19(String.valueOf(m.get(String.valueOf(codeListRealArray[18]))));
				}
				if(codeListRealArray[19] != null) {
					inspectInfoAdmVoData.setOutInspectItem20(String.valueOf(m.get(String.valueOf(codeListRealArray[19]))));
				}
				if(codeListRealArray[20] != null) {
					inspectInfoAdmVoData.setOutInspectItem21(String.valueOf(m.get(String.valueOf(codeListRealArray[20]))));
				}
				if(codeListRealArray[21] != null) {
					inspectInfoAdmVoData.setOutInspectItem22(String.valueOf(m.get(String.valueOf(codeListRealArray[21]))));
				}
				if(codeListRealArray[22] != null) {
					inspectInfoAdmVoData.setOutInspectItem23(String.valueOf(m.get(String.valueOf(codeListRealArray[22]))));
				}
				if(codeListRealArray[23] != null) {
					inspectInfoAdmVoData.setOutInspectItem24(String.valueOf(m.get(String.valueOf(codeListRealArray[23]))));
				}
				if(codeListRealArray[24] != null) {
					inspectInfoAdmVoData.setOutInspectItem25(String.valueOf(m.get(String.valueOf(codeListRealArray[24]))));
				}
				if(codeListRealArray[25] != null) {
					inspectInfoAdmVoData.setOutInspectItem26(String.valueOf(m.get(String.valueOf(codeListRealArray[25]))));
				}
				if(codeListRealArray[26] != null) {
					inspectInfoAdmVoData.setOutInspectItem27(String.valueOf(m.get(String.valueOf(codeListRealArray[26]))));
				}
				if(codeListRealArray[27] != null) {
					inspectInfoAdmVoData.setOutInspectItem28(String.valueOf(m.get(String.valueOf(codeListRealArray[27]))));
				}
				if(codeListRealArray[28] != null) {
					inspectInfoAdmVoData.setOutInspectItem29(String.valueOf(m.get(String.valueOf(codeListRealArray[28]))));
				}
				if(codeListRealArray[29] != null) {
					inspectInfoAdmVoData.setOutInspectItem30(String.valueOf(m.get(String.valueOf(codeListRealArray[29]))));
				}
				if(codeListRealArray[30] != null) {
					inspectInfoAdmVoData.setOutInspectItem31(String.valueOf(m.get(String.valueOf(codeListRealArray[30]))));
				}
				if(codeListRealArray[31] != null) {
					inspectInfoAdmVoData.setOutInspectItem32(String.valueOf(m.get(String.valueOf(codeListRealArray[31]))));
				}
				if(codeListRealArray[32] != null) {
					inspectInfoAdmVoData.setOutInspectItem33(String.valueOf(m.get(String.valueOf(codeListRealArray[32]))));
				}
				if(codeListRealArray[33] != null) {
					inspectInfoAdmVoData.setOutInspectItem34(String.valueOf(m.get(String.valueOf(codeListRealArray[33]))));
				}
				if(codeListRealArray[34] != null) {
					inspectInfoAdmVoData.setOutInspectItem35(String.valueOf(m.get(String.valueOf(codeListRealArray[34]))));
				}
				if(codeListRealArray[35] != null) {
					inspectInfoAdmVoData.setOutInspectItem36(String.valueOf(m.get(String.valueOf(codeListRealArray[35]))));
				}
				if(codeListRealArray[36] != null) {
					inspectInfoAdmVoData.setOutInspectItem37(String.valueOf(m.get(String.valueOf(codeListRealArray[36]))));
				}
				if(codeListRealArray[37] != null) {
					inspectInfoAdmVoData.setOutInspectItem38(String.valueOf(m.get(String.valueOf(codeListRealArray[37]))));
				}
				if(codeListRealArray[38] != null) {
					inspectInfoAdmVoData.setOutInspectItem39(String.valueOf(m.get(String.valueOf(codeListRealArray[38]))));
				}
				if(codeListRealArray[39] != null) {
					inspectInfoAdmVoData.setOutInspectItem40(String.valueOf(m.get(String.valueOf(codeListRealArray[39]))));
				}
				if(codeListRealArray[40] != null) {
					inspectInfoAdmVoData.setOutInspectItem41(String.valueOf(m.get(String.valueOf(codeListRealArray[40]))));
				}
				if(codeListRealArray[41] != null) {
					inspectInfoAdmVoData.setOutInspectItem42(String.valueOf(m.get(String.valueOf(codeListRealArray[41]))));
				}
				if(codeListRealArray[42] != null) {
					inspectInfoAdmVoData.setOutInspectItem43(String.valueOf(m.get(String.valueOf(codeListRealArray[42]))));
				}
				if(codeListRealArray[43] != null) {
					inspectInfoAdmVoData.setOutInspectItem44(String.valueOf(m.get(String.valueOf(codeListRealArray[43]))));
				}
				if(codeListRealArray[44] != null) {
					inspectInfoAdmVoData.setOutInspectItem45(String.valueOf(m.get(String.valueOf(codeListRealArray[44]))));
				}
				
				
				// 비고란 
				if(codeListRealArray[0] != null) {
					inspectInfoAdmVoData.setInsepctEtc001(String.valueOf(m.get("INSEPCT_ETC001")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc001(String.valueOf("N"));
				}
				if(codeListRealArray[1] != null) {
					inspectInfoAdmVoData.setInsepctEtc002(String.valueOf(m.get("INSEPCT_ETC002")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc002(String.valueOf("N"));
				}
				if(codeListRealArray[2] != null) {
					inspectInfoAdmVoData.setInsepctEtc003(String.valueOf(m.get("INSEPCT_ETC003")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc003(String.valueOf("N"));
				}
				if(codeListRealArray[3] != null) {
					inspectInfoAdmVoData.setInsepctEtc004(String.valueOf(m.get("INSEPCT_ETC004")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc004(String.valueOf("N"));
				}
				if(codeListRealArray[4] != null) {
					inspectInfoAdmVoData.setInsepctEtc005(String.valueOf(m.get("INSEPCT_ETC005")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc005(String.valueOf("N"));
				}
				if(codeListRealArray[5] != null) {
					inspectInfoAdmVoData.setInsepctEtc006(String.valueOf(m.get("INSEPCT_ETC006")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc006(String.valueOf("N"));
				}
				if(codeListRealArray[6] != null) {
					inspectInfoAdmVoData.setInsepctEtc007(String.valueOf(m.get("INSEPCT_ETC007")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc007(String.valueOf("N"));
				}
				if(codeListRealArray[7] != null) {
					inspectInfoAdmVoData.setInsepctEtc008(String.valueOf(m.get("INSEPCT_ETC008")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc008(String.valueOf("N"));
				}
				if(codeListRealArray[8] != null) {
					inspectInfoAdmVoData.setInsepctEtc009(String.valueOf(m.get("INSEPCT_ETC009")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc009(String.valueOf("N"));
				}
				if(codeListRealArray[9] != null) {
					inspectInfoAdmVoData.setInsepctEtc010(String.valueOf(m.get("INSEPCT_ETC010")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc010(String.valueOf("N"));
				}
				if(codeListRealArray[10] != null) {
					inspectInfoAdmVoData.setInsepctEtc011(String.valueOf(m.get("INSEPCT_ETC011")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc011(String.valueOf("N"));
				}
				if(codeListRealArray[11] != null) {
					inspectInfoAdmVoData.setInsepctEtc012(String.valueOf(m.get("INSEPCT_ETC012")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc012(String.valueOf("N"));
				}
				if(codeListRealArray[12] != null) {
					inspectInfoAdmVoData.setInsepctEtc013(String.valueOf(m.get("INSEPCT_ETC013")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc013(String.valueOf("N"));
				}
				if(codeListRealArray[13] != null) {
					inspectInfoAdmVoData.setInsepctEtc014(String.valueOf(m.get("INSEPCT_ETC014")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc014(String.valueOf("N"));
				}
				if(codeListRealArray[14] != null) {
					inspectInfoAdmVoData.setInsepctEtc015(String.valueOf(m.get("INSEPCT_ETC015")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc015(String.valueOf("N"));
				}
				//
				if(codeListRealArray[15] != null) {
					inspectInfoAdmVoData.setInsepctEtc016(String.valueOf(m.get("INSEPCT_ETC016")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc016(String.valueOf("N"));
				}
				if(codeListRealArray[16] != null) {
					inspectInfoAdmVoData.setInsepctEtc017(String.valueOf(m.get("INSEPCT_ETC017")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc017(String.valueOf("N"));
				}
				if(codeListRealArray[17] != null) {
					inspectInfoAdmVoData.setInsepctEtc018(String.valueOf(m.get("INSEPCT_ETC018")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc018(String.valueOf("N"));
				}
				if(codeListRealArray[18] != null) {
					inspectInfoAdmVoData.setInsepctEtc019(String.valueOf(m.get("INSEPCT_ETC019")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc019(String.valueOf("N"));
				}
				if(codeListRealArray[19] != null) {
					inspectInfoAdmVoData.setInsepctEtc020(String.valueOf(m.get("INSEPCT_ETC020")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc020(String.valueOf("N"));
				}
				if(codeListRealArray[20] != null) {
					inspectInfoAdmVoData.setInsepctEtc021(String.valueOf(m.get("INSEPCT_ETC021")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc021(String.valueOf("N"));
				}
				if(codeListRealArray[21] != null) {
					inspectInfoAdmVoData.setInsepctEtc022(String.valueOf(m.get("INSEPCT_ETC022")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc022(String.valueOf("N"));
				}
				if(codeListRealArray[22] != null) {
					inspectInfoAdmVoData.setInsepctEtc023(String.valueOf(m.get("INSEPCT_ETC023")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc023(String.valueOf("N"));
				}
				if(codeListRealArray[23] != null) {
					inspectInfoAdmVoData.setInsepctEtc024(String.valueOf(m.get("INSEPCT_ETC024")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc024(String.valueOf("N"));
				}
				if(codeListRealArray[24] != null){ 
					inspectInfoAdmVoData.setInsepctEtc025(String.valueOf(m.get("INSEPCT_ETC025")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc025(String.valueOf("N"));
				}
				if(codeListRealArray[25] != null) {
					inspectInfoAdmVoData.setInsepctEtc026(String.valueOf(m.get("INSEPCT_ETC026")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc026(String.valueOf("N"));
				}
				if(codeListRealArray[26] != null) {
					inspectInfoAdmVoData.setInsepctEtc027(String.valueOf(m.get("INSEPCT_ETC027")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc027(String.valueOf("N"));
				}
				if(codeListRealArray[27] != null) {
					inspectInfoAdmVoData.setInsepctEtc028(String.valueOf(m.get("INSEPCT_ETC028")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc028(String.valueOf("N"));
				}
				if(codeListRealArray[28] != null) {
					inspectInfoAdmVoData.setInsepctEtc029(String.valueOf(m.get("INSEPCT_ETC029")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc029(String.valueOf("N"));
				}
				if(codeListRealArray[29] != null){ 
					inspectInfoAdmVoData.setInsepctEtc030(String.valueOf(m.get("INSEPCT_ETC030")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc030(String.valueOf("N"));
				}
				if(codeListRealArray[30] != null){ 
					inspectInfoAdmVoData.setInsepctEtc031(String.valueOf(m.get("INSEPCT_ETC031")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc031(String.valueOf("N"));
				}
				if(codeListRealArray[31] != null){ 
					inspectInfoAdmVoData.setInsepctEtc032(String.valueOf(m.get("INSEPCT_ETC032")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc032(String.valueOf("N"));
				}
				if(codeListRealArray[32] != null){ 
					inspectInfoAdmVoData.setInsepctEtc033(String.valueOf(m.get("INSEPCT_ETC033")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc033(String.valueOf("N"));
				}
				if(codeListRealArray[33] != null){ 
					inspectInfoAdmVoData.setInsepctEtc034(String.valueOf(m.get("INSEPCT_ETC034")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc034(String.valueOf("N"));
				}
				if(codeListRealArray[34] != null){ 
					inspectInfoAdmVoData.setInsepctEtc035(String.valueOf(m.get("INSEPCT_ETC035")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc035(String.valueOf("N"));
				}
				if(codeListRealArray[35] != null){ 
					inspectInfoAdmVoData.setInsepctEtc036(String.valueOf(m.get("INSEPCT_ETC036")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc036(String.valueOf("N"));
				}
				if(codeListRealArray[36] != null){ 
					inspectInfoAdmVoData.setInsepctEtc037(String.valueOf(m.get("INSEPCT_ETC037")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc037(String.valueOf("N"));
				}
				if(codeListRealArray[37] != null){ 
					inspectInfoAdmVoData.setInsepctEtc038(String.valueOf(m.get("INSEPCT_ETC038")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc038(String.valueOf("N"));
				}
				if(codeListRealArray[38] != null){ 
					inspectInfoAdmVoData.setInsepctEtc039(String.valueOf(m.get("INSEPCT_ETC039")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc039(String.valueOf("N"));
				}
				if(codeListRealArray[39] != null){ 
					inspectInfoAdmVoData.setInsepctEtc040(String.valueOf(m.get("INSEPCT_ETC040")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc040(String.valueOf("N"));
				}
				if(codeListRealArray[40] != null){ 
					inspectInfoAdmVoData.setInsepctEtc041(String.valueOf(m.get("INSEPCT_ETC041")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc041(String.valueOf("N"));
				}
				if(codeListRealArray[41] != null){ 
					inspectInfoAdmVoData.setInsepctEtc042(String.valueOf(m.get("INSEPCT_ETC042")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc042(String.valueOf("N"));
				}
				if(codeListRealArray[42] != null){ 
					inspectInfoAdmVoData.setInsepctEtc043(String.valueOf(m.get("INSEPCT_ETC043")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc043(String.valueOf("N"));
				}
				if(codeListRealArray[43] != null){ 
					inspectInfoAdmVoData.setInsepctEtc044(String.valueOf(m.get("INSEPCT_ETC044")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc044(String.valueOf("N"));
				}
				if(codeListRealArray[44] != null){ 
					inspectInfoAdmVoData.setInsepctEtc045(String.valueOf(m.get("INSEPCT_ETC045")));
				} else {
					inspectInfoAdmVoData.setInsepctEtc045(String.valueOf("N"));
				}
				
				if("001".equals(inspectInfoAdmVo.getMatrlGubunCd())||"004".equals(inspectInfoAdmVo.getMatrlGubunCd())) {
					inspectInfoAdmVoData.setInspectItem13(m.get("INSPECT_ITEM13"));
					inspectInfoAdmVoData.setInspectItem14(m.get("INSPECT_ITEM14"));
					inspectInfoAdmVoData.setInspectItem15(m.get("INSPECT_ITEM15"));
					inspectInfoAdmVoData.setInspectItem16(m.get("INSPECT_ITEM16"));
					inspectInfoAdmVoData.setInspectItem17(m.get("INSPECT_ITEM17"));
					inspectInfoAdmVoData.setInspectItem18(m.get("INSPECT_ITEM18"));
					inspectInfoAdmVoData.setInspectItem19(m.get("INSPECT_ITEM19"));
					inspectInfoAdmVoData.setInspectItem20(m.get("INSPECT_ITEM20"));
					inspectInfoAdmVoData.setInspectItem21(m.get("INSPECT_ITEM21"));	
					
		
				}
				
				
				
				
				
				
				dataList.add(inspectInfoAdmVoData);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("수입검사현황 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//품질관리 - 일일 업무실적보고 1동 - Header
	@RequestMapping(value = "/qmsc0130", method = RequestMethod.GET)
	public String qmsc0130(Locale locale, Model model) throws Exception {

		logger.info("일일 업무실적보고 1동");
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		model.addAttribute("goodsCode", goodsCodeDataList );
		
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd", -1));

		return "qm/qmsc0130";
	}
	
	//품질관리 - 일일 업무실적보고 1동
	@RequestMapping(value = "qm/goodsInspectDailyWorkHeader", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectListHeader_qmsc0130(GoodsFaultyAdmVo goodsFaultyAdm) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("일일 업무실적보고 1동 현황 Header");
		logger.info("받은 값 : " + goodsFaultyAdm);
		try {
			List<GoodsFaultyAdmVo> readGoodsInspectDailyHeader = goodsInspectService.goodsInspectDailyWorkHeader(goodsFaultyAdm);
			//for(int i=0; i<readGoodsInspectDailyHeader.size(); i++) {
			//	//쿼리에서 날라온 순서대로 넣어줌-날라온 순서가 중요!!
			//	if ("QUARTER1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter1(readGoodsInspectDailyHeader.get(i).getHeaderQuarter() + "분기<br>(" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월~");
			//	} else if ("QUARTER2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter2(readGoodsInspectDailyHeader.get(i).getHeaderQuarter() + "분기<br>(" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월~");
			//	} else if ("QUARTER3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter3(readGoodsInspectDailyHeader.get(i).getHeaderQuarter() + "분기<br>(" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월~");
			//	} else if ("QUARTER1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter1(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월)");
			//	} else if ("QUARTER2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter2(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월)");
			//	} else if ("QUARTER3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setQuarter3(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월)");
			//		
			//	} else if ("MONTH1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setMonth1(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월<br>총계");
			//	} else if ("MONTH2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setMonth2(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월<br>총계");
			//	} else if ("MONTH3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setMonth3(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + "월<br>총계");
			//	//} else if ("MONTH1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//	//	goodsFaultyAdm.setMonth1(readGoodsInspectDailyHeader.get(i).get");
			//	//} else if ("MONTH1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//	//	goodsFaultyAdm.setMonth2(readGoodsInspectDailyHeader.get(i).get");
			//	//} else if ("MONTH1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//	//	goodsFaultyAdm.setMonth3(readGoodsInspectDailyHeader.get(i).get");
			//	
			//	} else if ("WEEK1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek1(readGoodsInspectDailyHeader.get(i).getHeaderIsoWeek() + "주차<br>" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay() + " ~ ");
			//	} else if ("WEEK2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek2(readGoodsInspectDailyHeader.get(i).getHeaderIsoWeek() + "주차<br>" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay() + " ~ ");
			//	} else if ("WEEK3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MIN".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek3(readGoodsInspectDailyHeader.get(i).getHeaderIsoWeek() + "주차<br>" + readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay() + " ~ ");
			//	} else if ("WEEK1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek1(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("WEEK2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek2(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("WEEK3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun()) && "MAX".equals(readGoodsInspectDailyHeader.get(i).getHeaderType())) {
			//		goodsFaultyAdm.setWeek3(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//		
			//	} else if ("DAY1".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay1(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY2".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay2(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY3".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay3(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY4".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay4(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY5".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay5(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY6".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay6(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY7".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay7(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY8".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay8(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY9".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay9(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY10".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay10(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY11".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay11(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY12".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay12(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY13".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay13(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	} else if ("DAY14".equals(readGoodsInspectDailyHeader.get(i).getHeaderGubun())) {
			//		goodsFaultyAdm.setDay14(readGoodsInspectDailyHeader.get(i).getHeaderMonth() + ". " + readGoodsInspectDailyHeader.get(i).getHeaderDay());
			//	}
			//}
			//jsonData.put("data", goodsFaultyAdm);
			
			jsonData.put("data", readGoodsInspectDailyHeader);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("일일 업무실적보고 1동 현황 Header");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//품질관리 - 일일업무실적보고 - 내용
	@RequestMapping(value = "qm/goodsInspectDailyWorkContent", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsInspectDailyWorkContent(GoodsFaultyAdmVo goodsFaultyAdm) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("일일 업무실적보고 1동 현황 Header");
		logger.info("받은 값 : " + goodsFaultyAdm);
		try {
			String equipCdList = goodsFaultyAdm.getEquipCd();
			equipCdList = equipCdList.replace("/", "', '");
			equipCdList = equipCdList.substring(3, equipCdList.length());
			equipCdList += "'";
			goodsFaultyAdm.setEquipCd(equipCdList);
			
			String goodsCdList = goodsFaultyAdm.getGoodsCd();
			goodsCdList = goodsCdList.replace("/", "', '");
			goodsCdList = goodsCdList.substring(3, goodsCdList.length());
			goodsCdList += "'";
			goodsFaultyAdm.setGoodsCd(goodsCdList);
			
			
			List<GoodsFaultyAdmVo> readGoodsInspectDailyContent = null;
			// 검색일자(외관검사일) 21.11.29 부터 생산실적으로 검색, 그외 작업지시 기준으로 검색(21. 11. 29 오전9시에 작업지시->생산실적으로 변경 업데이트하였음.)
			//if (Integer.parseInt(goodsFaultyAdm.getAppearInspctDate()) >= 20211129 ) {
				readGoodsInspectDailyContent = goodsInspectService.goodsInspectDailyWorkContent(goodsFaultyAdm);
			//} else {
			//	readGoodsInspectDailyContent = goodsInspectService.goodsInspectDailyWorkContentOld(goodsFaultyAdm);
			//}
			
			jsonData.put("data", readGoodsInspectDailyContent);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("일일 업무실적보고 1동 현황 Content");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	
	
	
	//MTP2동 비전불량현황 목록 조회
	@RequestMapping(value = "/po/readVisionFaultyAdmList_F2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readVisionFaultyAdmList_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP2동 비전불량현황 목록 조회");
		try {
			List<WorkOrdOutputSubVo> readVisionFaultyAdmList_F2 = workOrdOutputSubService.readVisionFaultyAdmList_F2(workOrdOutputSubVo);
			jsonData.put("data", readVisionFaultyAdmList_F2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("MTP2동 비전불량현황 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//MTP2동 비전불량수량 상세조회
	@RequestMapping(value = "/po/readVisionFaultCodeList_F2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readVisionFaultCodeList_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP2동 비전불량수량 상세조회");
		
		try {
			List<GoodsFaultyAdmVo> readVisionFaultCodeList_F2 = goodsInspectService.readVisionFaultCodeList_F2(goodsFaultyAdmVo);
			jsonData.put("data", readVisionFaultCodeList_F2);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("MTP2동 비전불량수량 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//MTP2동 비전불량현황 등록
	@RequestMapping(value = "/po/visionFaultyInsert_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> visionFaultyInsert_F2(@RequestBody List<Map<String, Object>> visionFaultyList, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP2동 비전불량현황 등록");
		
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			HttpSession session = request.getSession(true);
			
			String workOrdNo 			= visionFaultyList.get(0).get("workOrdNo").toString();
			String lotNo 				= visionFaultyList.get(0).get("lotNo").toString();
			
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			String visionFaultyAdmSeq 		= workOrdOutputSubService.visionFaultyAdmSeq(workOrdOutputSubVo);
			int visionFaultySum			= Integer.parseInt(visionFaultyList.get(0).get("visionFaultySum").toString());
			String dayNightCd 			= visionFaultyList.get(0).get("dayNightCd").toString();
			String faultyRegDate 		= visionFaultyList.get(0).get("faultyRegDate").toString();
			String userNumber 			= session.getAttribute(Constants.USER_NUMBER).toString();
			
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setSeq(visionFaultyAdmSeq);
			workOrdOutputSubVo.setFaultyCntSum(visionFaultySum);
			workOrdOutputSubVo.setInspctCharger(userNumber);
			workOrdOutputSubVo.setDayNightCd(dayNightCd);
			workOrdOutputSubVo.setFaultyRegDate(faultyRegDate);
			workOrdOutputSubVo.setRegId(Utils.getUserId());
			workOrdOutputSubService.visionFaultyAdmInsert_F2(workOrdOutputSubVo);
			workOrdOutputSubVo = workOrdOutputSubService.readVisionFaultyAdm_F2(workOrdOutputSubVo);
			
			//생산 비전불량 등록(엣지불량 TB Insert) 코드화 
			for(Map<String,Object> m : visionFaultyList) {
				GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				goodsFaultyAdmVo.setSeq(visionFaultyAdmSeq);
				goodsFaultyAdmVo.setFaultyRegDate(faultyRegDate);
				goodsFaultyAdmVo.setDayNightCd(dayNightCd);
				goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				goodsFaultyAdmVo.setInspctChargr(userNumber);
				goodsFaultyAdmVo.setRegId(Utils.getUserId());
				goodsInspectService.visionFaultyAdmCodeInsert_F2(goodsFaultyAdmVo);
			}
			//생산 비전불량 등록(엣지불량 TB Insert) 코드화 끝
			
			logger.info("생산 비전불량수량 불량 등록 성공");
			jsonData.put("data", workOrdOutputSubVo);
			jsonData.put("message", "비전불량수량 등록되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산 비전불량수량 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//MTP2동 비전불량현황 수정
	@RequestMapping(value = "/po/visionFaultyUpdate_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> visionFaultyUpdate_F2(@RequestBody List<Map<String, Object>> visionFaultyList, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP2동 비전불량현황 등록");
		
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			HttpSession session = request.getSession(true);
			
			String workOrdNo 			= visionFaultyList.get(0).get("workOrdNo").toString();
			String lotNo 				= visionFaultyList.get(0).get("lotNo").toString();
			String visionFaultyAdmSeq	= visionFaultyList.get(0).get("visionFaultySeq").toString();
			int visionFaultySum			= Integer.parseInt(visionFaultyList.get(0).get("visionFaultySum").toString());
			
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setSeq(visionFaultyAdmSeq);
			workOrdOutputSubVo.setFaultyCntSum(visionFaultySum);
			workOrdOutputSubVo.setUpdId(Utils.getUserId());
			workOrdOutputSubService.visionFaultyAdmUpdate_F2(workOrdOutputSubVo);
			workOrdOutputSubVo = workOrdOutputSubService.readVisionFaultyAdm_F2(workOrdOutputSubVo); 			
			
			//수정 전 삭제
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			goodsFaultyAdmVo.setSeq(visionFaultyAdmSeq);
			goodsInspectService.visionFaultyAdmCodeDelete_F2(goodsFaultyAdmVo);
			
			//생산 비전불량 등록(엣지불량 TB Insert) 코드화 
			for(Map<String,Object> m : visionFaultyList) {
				goodsFaultyAdmVo.setFaultyRegDate(workOrdOutputSubVo.getFaultyRegDate());
				goodsFaultyAdmVo.setDayNightCd(workOrdOutputSubVo.getDayNightCd());
				goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				goodsFaultyAdmVo.setInspctChargr(workOrdOutputSubVo.getInspctCharger());
				goodsFaultyAdmVo.setRegId(workOrdOutputSubVo.getRegId());
				goodsInspectService.visionFaultyAdmCodeInsert_F2(goodsFaultyAdmVo);
			}
			//생산 비전불량 등록(엣지불량 TB Insert) 코드화 끝
			
			logger.info("생산 비전불량수량 불량 등록 성공");
			jsonData.put("data", workOrdOutputSubVo);
			jsonData.put("message", "비전불량수량 등록되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산 비전불량수량 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//MTP2동 비전불량현황 삭제
	@RequestMapping(value = "/po/visionFaultyDelete_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> visionFaultyDelete_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP2동 비전불량현황 삭제");
		
		try {
			String workOrdNo 	=	workOrdOutputSubVo.getWorkOrdNo();
			String seq 			=	workOrdOutputSubVo.getSeq();
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			goodsFaultyAdmVo.setSeq(seq);
			goodsInspectService.visionFaultyAdmCodeDelete_F2(goodsFaultyAdmVo);
			workOrdOutputSubService.visionFaultyAdmDelete_F2(workOrdOutputSubVo);
			logger.info("생산 비전불량수량 불량 삭제 성공");
			
			jsonData.put("message", "비전불량수량 삭제되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산 비전불량수량 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	
	//솔브레인SLD 엣지검사 목록
	@RequestMapping(value = "/qm/edgeCheckList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> edgeCheckList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 엣지검사 목록 조회");
		try {
			List<WorkOrdOutputSubVo> workOrdOutputSubList = workOrdOutputSubService.edgeCheckList_F3(workOrdOutputSubVo);
			jsonData.put("data", workOrdOutputSubList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("엣지검사 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//엣지검사 상세조회 (엣지불량 TB Read) 코드화
	@RequestMapping(value = "qm/readEdgeGoodsFaultyAdmCode", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readEdgeGoodsFaultyAdmCode(EdgeGoodsFaultyAdmVo edgegoodsFaultyAdm) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사 상세조회 (엣지불량 TB Read) 코드화 : " + edgegoodsFaultyAdm);
		try {
			List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCode = goodsInspectService.readEdgeGoodsFaultyAdmCode(edgegoodsFaultyAdm);
			jsonData.put("data", readEdgeGoodsFaultyAdmCode);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("외관불량 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//(트레이)엣지검사 상세조회 (엣지불량 TB Read) 코드화
	@RequestMapping(value = "qm/readTrayEdgeGoodsFaultyAdmCode_F2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readTrayEdgeGoodsFaultyAdmCode_F2(EdgeGoodsFaultyAdmVo edgegoodsFaultyAdm) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("엣지검사 상세조회 (엣지불량 TB Read) 코드화 : " + edgegoodsFaultyAdm);
		try {
			List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCode = goodsInspectService.readTrayEdgeGoodsFaultyAdmCode(edgegoodsFaultyAdm);
			jsonData.put("data", readEdgeGoodsFaultyAdmCode);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("외관불량 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	/*//솔브레인SLD 엣지검사 등록
	@RequestMapping(value = "qm/edgeCheckInsert_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckInsert_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 엣지검사 등록");
		logger.info("받은 값 : " + workOrdOutputSubVo);
		try {
			String workOrdNo = workOrdOutputSubVo.getWorkOrdNo();
			String lotNo = workOrdOutputSubVo.getLotNo();
			String gubun = workOrdOutputSubVo.getGubun();
			String equipCd = workOrdOutputSubVo.getEquipCd();
			String ordDate = workOrdOutputSubVo.getOrdDate();
			String mainMatrlCd = workOrdOutputSubVo.getMainMatrlCd();
			String workOrdDate = workOrdOutputSubVo.getWorkOrdDate();
			logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);
			
			//생산LotNo 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 작업지시일, 주재료코드)
			String workOrdLotNo = getCreateWorkOrdLotNo(workOrdNo, lotNo, gubun, equipCd, ordDate, mainMatrlCd);
			if (workOrdLotNo.equals("errorType1")) {
				jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
				jsonData.put("result", "error");
				return jsonData;
			} else if (workOrdLotNo.equals("errorType2")) {
				jsonData.put("message", "생산LotNo 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			//생산전표번호 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 주재료코드, 전표번호일자)
			String ordLotNo = getCreateOrdLotNo(workOrdNo, lotNo, gubun, equipCd, mainMatrlCd, workOrdDate);
			if (ordLotNo.equals("errorType1")) {
				jsonData.put("message", "생산전표번호 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			
			workOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
			workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
			workOrdOutputSubVo.setUserInputInspctCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setOutputWeight("0");
			workOrdOutputSubVo.setOutputCnt(0);
			workOrdOutputSubVo.setVisionEdgeWeight("0");
			workOrdOutputSubVo.setVisionEdgeCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setSubWorkStatusCd("E");
			workOrdOutputSubVo.setRegId(Utils.getUserId());
			workOrdOutputSubService.edgeCheckInsert_F3(workOrdOutputSubVo);
			workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
			
			jsonData.put("message", "엣지검사 등록되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("엣지검사 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}*/
	
	
	//머티2공장(MTP2) 엣지검사 등록
	@RequestMapping(value = "qm/edgeCheckInsert_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckInsert_F2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 엣지검사 등록");
		try {
			String workOrdNo	= inspectList.get(0).get("workOrdNo").toString();
			String pIdx 		= inspectList.get(0).get("pIdx").toString();
			
			//생산실적 정보_Read
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			String edgeInspctDate = null, edgeInspctCharger = null;
			int edgeFaultyCnt = 0, appearOutputCnt = 0, index = 0;
			
			//엣지불량검사 코드화 저장
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
			
			
			edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");
			edgeGoodsFaultyAdmVo = goodsInspectService.selectEdgeGoodsFaultyAdmCodeSeq(edgeGoodsFaultyAdmVo);
			String seq = edgeGoodsFaultyAdmVo.getSeq();
			
			if( pIdx.toString().isEmpty() ) {
				//등록되지 않았을 경우
				for(Map<String,Object> m : inspectList) {
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					edgeGoodsFaultyAdmVo.setSeq(seq);							
					edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					edgeGoodsFaultyAdmVo.setInspctCharger(m.get("edgeInspctCharger").toString());	//검사 담당자
					edgeGoodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					edgeGoodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					
					goodsInspectService.edgeCheckInsertCodeSeq(edgeGoodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						edgeInspctDate 	= m.get("faultyRegDate").toString();
						edgeInspctCharger = m.get("edgeInspctCharger").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					edgeFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			} else {
				//등록되어 있는 경우
				
				edgeGoodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
				edgeGoodsFaultyAdmVo.setDayNightCd(inspectList.get(0).get("gubun").toString());
				//goodsInspectService.edgeCheckDeleteCode(edgeGoodsFaultyAdmVo);
				
				for(Map<String,Object> m : inspectList) {
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					edgeGoodsFaultyAdmVo.setSeq(seq);	
					edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					edgeGoodsFaultyAdmVo.setInspctCharger(m.get("edgeInspctCharger").toString());	//검사 담당자
					edgeGoodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					edgeGoodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					
					goodsInspectService.edgeCheckInsertCodeSeq(edgeGoodsFaultyAdmVo);

					index++;
					if (index == inspectList.size()) {
						edgeInspctDate 	= m.get("faultyRegDate").toString();
						edgeInspctCharger = m.get("edgeInspctCharger").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					edgeFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			}
			
			//트레이가 생성 됐고 외관검사일이 등록 되어 있지 않은 경우 첫 번째 트레이에 값을 담아 update 해준다.
			//if( inspectList.get(0).get("workStatusCd").toString().equals("C") ) {
				if( workOrdOutputSubVo != null ) {
					//if( workOrdOutputSubVo.getEdgeInspctDate() == null ) {
						//workOrdOutputSubVo = new WorkOrdOutputSubVo();
						/*workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
						workOrdOutputSubVo.setWorkOrdSeq("1");
						workOrdOutputSubVo.setEdgeInspctDate(edgeInspctDate);
						workOrdOutputSubVo.setEdgeFaultyCnt(edgeFaultyCnt);
						workOrdOutputSubVo.setEdgeInspctCharger(edgeInspctCharger);
						workOrdOutputSubVo.setUpdId( Utils.getUserId() );	//수장자
						workOrdOutputSubVo.setFaultyTrayCheckNum("001");	//전체: 001, 엣지만: 002, 외관만: 003
						workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);*/
					//}
					//생산 실적 delete Create
					ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
					productionPerfTrayController.trayFaultyRelatedCreate(workOrdNo);
				}
			//}
			
			logger.info("엣지검사 불량 등록 성공");
			jsonData.put("message", "외관검사 등록되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 엣지검사 등록 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//머티2공장(MTP2) 엣지검사 등록
	@RequestMapping(value = "qm/edgeCheckUpdate_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckUpdate_F2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 엣지검사 등록");
		try {
			String workOrdNo	= inspectList.get(0).get("workOrdNo").toString();
			String pIdx 		= inspectList.get(0).get("pIdx").toString();
			String seq 			= inspectList.get(0).get("seq").toString();
			
			//생산실적 정보_Read
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			String edgeInspctDate = null, edgeInspctCharger = null;
			int edgeFaultyCnt = 0, appearOutputCnt = 0, index = 0;
			
			//엣지불량검사 코드화 저장
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					
			
			if( pIdx.toString().isEmpty() ) {
				//등록되지 않았을 경우
				for(Map<String,Object> m : inspectList) {
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					edgeGoodsFaultyAdmVo.setSeq(seq);							
					edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					edgeGoodsFaultyAdmVo.setInspctCharger(m.get("edgeInspctCharger").toString());	//검사 담당자
					edgeGoodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					edgeGoodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					
					goodsInspectService.edgeCheckInsertCodeSeq(edgeGoodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						edgeInspctDate 	= m.get("faultyRegDate").toString();
						edgeInspctCharger = m.get("edgeInspctCharger").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					edgeFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			} else {
				//등록되어 있는 경우
				
				edgeGoodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
				edgeGoodsFaultyAdmVo.setDayNightCd(inspectList.get(0).get("gubun").toString());
				edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");
				edgeGoodsFaultyAdmVo.setSeq(seq);
				goodsInspectService.edgeCheckDeleteSeq(edgeGoodsFaultyAdmVo);
				
				for(Map<String,Object> m : inspectList) {
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					edgeGoodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					edgeGoodsFaultyAdmVo.setSeq(seq);	
					edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					edgeGoodsFaultyAdmVo.setInspctCharger(m.get("edgeInspctCharger").toString());	//검사 담당자
					edgeGoodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					edgeGoodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					
					goodsInspectService.edgeCheckInsertCodeSeq(edgeGoodsFaultyAdmVo);

					index++;
					if (index == inspectList.size()) {
						edgeInspctDate 	= m.get("faultyRegDate").toString();
						edgeInspctCharger = m.get("edgeInspctCharger").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					edgeFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			}
			
			//트레이가 생성 됐고 외관검사일이 등록 되어 있지 않은 경우 첫 번째 트레이에 값을 담아 update 해준다.
			//if( inspectList.get(0).get("workStatusCd").toString().equals("C") ) {
				if( workOrdOutputSubVo != null ) {
					//if( workOrdOutputSubVo.getEdgeInspctDate() == null ) {
						//workOrdOutputSubVo = new WorkOrdOutputSubVo();
						/*workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
						workOrdOutputSubVo.setWorkOrdSeq("1");
						workOrdOutputSubVo.setEdgeInspctDate(edgeInspctDate);
						workOrdOutputSubVo.setEdgeFaultyCnt(edgeFaultyCnt);
						workOrdOutputSubVo.setEdgeInspctCharger(edgeInspctCharger);
						workOrdOutputSubVo.setUpdId( Utils.getUserId() );	//수장자
						workOrdOutputSubVo.setFaultyTrayCheckNum("001");	//전체: 001, 엣지만: 002, 외관만: 003
						workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);*/
					//}
					//생산 실적 delete Create
					ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
					productionPerfTrayController.trayFaultyRelatedCreate(workOrdNo);
				}
			//}
			
			logger.info("엣지검사 불량 등록 성공");
			jsonData.put("message", "외관검사 등록되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 엣지검사 등록 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	//솔브레인SLD 엣지검사 등록(신규)
	@RequestMapping(value = "qm/edgeCheckInsert_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckInsert_F3(@RequestBody List<Map<String, Object>> edgeInspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 엣지검사 등록");
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			WorkerChangeVo workerChangeVo = new WorkerChangeVo();
			
			String workOrdNo 			= edgeInspectList.get(0).get("workOrdNo").toString();
			String lotNo 				= edgeInspectList.get(0).get("lotNo").toString();
			String gubun 				= edgeInspectList.get(0).get("gubun").toString();
			String equipCd	 			= edgeInspectList.get(0).get("equipCd").toString();
			String ordDate 				= edgeInspectList.get(0).get("ordDate").toString();
			String mainMatrlCd 			= edgeInspectList.get(0).get("mainMatrlCd").toString();
			String targetCnt 			= edgeInspectList.get(0).get("targetCnt").toString();
			String workOrdDate 			= edgeInspectList.get(0).get("workOrdDate").toString();
			String edgeInspctDate 		= edgeInspectList.get(0).get("edgeInspctDate").toString();
			String edgeInspctCharger 	= edgeInspectList.get(0).get("edgeInspctCharger").toString();
			
			workerChangeVo.setOrdDate(ordDate);
			workerChangeVo.setWorkOrdNo(workOrdNo);
			workerChangeVo.setEquipCd(equipCd);
			workerChangeVo.setReadCheckCode1("workerSearch");
			
			WorkerChangeVo workerChangeRead = workOrderService.workerChangeRead(workerChangeVo);
			
			String mainWorkChargr 	= workerChangeRead.getWorkerId();
			String teamCd 			= workerChangeRead.getWorkTeamCd();
			
			int edgeSampleCnt 			= Integer.parseInt(edgeInspectList.get(0).get("edgeSampleCnt").toString());
			int edgeFaultyCnt 			= Integer.parseInt(edgeInspectList.get(0).get("edgeFaultyCnt").toString());
			float edgeRollFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeRollFaultySize").toString());
			float edgeSymbolFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeSymbolFaultySize").toString());
			float edgeBurFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeBurFaultySize").toString());
			/*logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);*/
			
			//생산LotNo 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 작업지시일, 주재료코드)
			String workOrdLotNo = getCreateWorkOrdLotNo(workOrdNo, lotNo, gubun, equipCd, ordDate, mainMatrlCd);
			if (workOrdLotNo.equals("errorType1")) {
				jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
				jsonData.put("result", "error");
				return jsonData;
			} else if (workOrdLotNo.equals("errorType2")) {
				jsonData.put("message", "생산LotNo 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			//생산전표번호 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 주재료코드, 전표번호일자)
			String ordLotNo = getCreateOrdLotNo(workOrdNo, lotNo, gubun, equipCd, mainMatrlCd, workOrdDate);
			if (ordLotNo.equals("errorType1")) {
				jsonData.put("message", "생산전표번호 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}

			workOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
			
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setGubun(gubun);
			workOrdOutputSubVo.setEquipCd(equipCd);
			workOrdOutputSubVo.setOrdDate(ordDate);
			workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			workOrdOutputSubVo.setTargetCnt(targetCnt);
			workOrdOutputSubVo.setWorkOrdDate(workOrdDate);
			
			workOrdOutputSubVo.setEdgeInspctDate(edgeInspctDate);
			workOrdOutputSubVo.setEdgeInspctCharger(edgeInspctCharger);
			workOrdOutputSubVo.setMainWorkChargr(mainWorkChargr);		//작업자
			workOrdOutputSubVo.setTeamCd(teamCd);						//작업조
			workOrdOutputSubVo.setEdgeSampleCnt(edgeSampleCnt);
			workOrdOutputSubVo.setEdgeFaultyCnt(edgeFaultyCnt);
			workOrdOutputSubVo.setEdgeRollFaultySize(edgeRollFaultySize);
			workOrdOutputSubVo.setEdgeSymbolFaultySize(edgeSymbolFaultySize);
			workOrdOutputSubVo.setEdgeBurFaultySize(edgeBurFaultySize);
			
			int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
			workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
			workOrdOutputSubVo.setUserInputInspctCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setOutputWeight("0");
			workOrdOutputSubVo.setOutputCnt(0);
			workOrdOutputSubVo.setVisionEdgeWeight("0");
			workOrdOutputSubVo.setVisionEdgeCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setSubWorkStatusCd("E");
			workOrdOutputSubVo.setRegId(Utils.getUserId());
			
			workOrdOutputSubService.edgeCheckInsert_F3(workOrdOutputSubVo);
			workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
			
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
			edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			edgeGoodsFaultyAdmVo.setOrdLotNo(ordLotNo);
			
			// 엣지검사 등록(엣지불량 TB Insert) 코드화 
			for(Map<String,Object> m : edgeInspectList) {
				edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				edgeGoodsFaultyAdmVo.setOrdLotNo(ordLotNo);
				edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
				edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());
				goodsInspectService.edgeCheckInsertCode(edgeGoodsFaultyAdmVo);				
			}
			// 엣지검사 등록(엣지불량 TB Insert) 코드화 끝
			
			logger.info("엣지검사 불량 등록 성공");
			
			jsonData.put("message", "엣지검사 등록되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("엣지검사 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//솔브레인SLD 엣지검사 수정
	/*@RequestMapping(value = "qm/edgeCheckUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckUpdate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 엣지검사 수정");
		logger.info("받은 값 : " + workOrdOutputSubVo);
		try {
			
			//WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			//if (workOrdOutputSubVo.getSubWorkStatusCd().equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			//	//엣지O, 외관X
			//	if ("EF3".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			//		int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
			//		workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
			//		goodsInspectService.edgeCheckUpdate(workOrdOutputSubVo);
			//		jsonData.put("message", "엣지검사 수정되었습니다.");
			//		jsonData.put("result", "ok");
			//		
			//	//종료(엣지O, 외관O)
			//	} else if ("A".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			//		int edgeOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt(); //엣지양품수량 = 읽어온 생산수량 - 엣지불량수량
			//		workOrdOutputSubVo.setEdgeOutputCnt(edgeOutputCnt);
			//		int appearOutputCnt = readWorkOrdOutputSubVo.getTotalCnt() - workOrdOutputSubVo.getEdgeFaultyCnt() - readWorkOrdOutputSubVo.getAppearFaultyCnt(); //외관양품수량 = 읽어온 생산수량 - 엣지불량수량 - 읽어온 외관불량수량
			//		workOrdOutputSubVo.setAppearOutputCnt(appearOutputCnt);
			//		goodsInspectService.edgeCheckUpdate(workOrdOutputSubVo);
			//		jsonData.put("message", "엣지검사 수정되었습니다.");
			//		jsonData.put("result", "ok");
			//	}
			//} else {
			//	jsonData.put("message", "생산LotNo 상태가 변경되었습니다!<br>다시 스캔해 주세요!");
			//	jsonData.put("result", "fail");
			//}
			workOrdOutputSubVo.setUserInputInspctCnt(workOrdOutputSubVo.getEdgeFaultyCnt());			
			workOrdOutputSubVo.setOutputWeight("0");
			workOrdOutputSubVo.setOutputCnt(0);
			workOrdOutputSubVo.setVisionEdgeWeight("0");
			workOrdOutputSubVo.setVisionEdgeCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setUpdId(Utils.getUserId());
			
			workOrdOutputSubService.edgeCheckUpdate_F3(workOrdOutputSubVo);
			
			jsonData.put("message", "엣지검사 수정되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("엣지검사 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}*/
	
	
	//솔브레인SLD 엣지검사 수정(신규)
	@RequestMapping(value = "qm/edgeCheckUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckUpdate_F3(@RequestBody List<Map<String, Object>> edgeInspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 엣지검사 수정");
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			
			logger.info("edgeInspectList -------> "+edgeInspectList);
			logger.info("edgeInspectList -------> "+edgeInspectList.get(0));
			logger.info("edgeInspectList -------> "+edgeInspectList.get(0).get("workOrdNo").toString());
			
			String workOrdNo 			= edgeInspectList.get(0).get("workOrdNo").toString();
//			String lotNo 				= edgeInspectList.get(0).get("lotNo").toString();
//			String gubun 				= edgeInspectList.get(0).get("gubun").toString();
//			String equipCd	 			= edgeInspectList.get(0).get("equipCd").toString();
//			String ordDate 				= edgeInspectList.get(0).get("ordDate").toString();
//			String mainMatrlCd 			= edgeInspectList.get(0).get("mainMatrlCd").toString();
//			String targetCnt 			= edgeInspectList.get(0).get("targetCnt").toString();
//			String workOrdDate 			= edgeInspectList.get(0).get("workOrdDate").toString();
//			String edgeInspctDate 		= edgeInspectList.get(0).get("edgeInspctDate").toString();
			
			String ordLotNo 			= edgeInspectList.get(0).get("ordLotNo").toString();
			String edgeInspctCharger 	= edgeInspectList.get(0).get("edgeInspctCharger").toString();
			int edgeSampleCnt 			= Integer.parseInt(edgeInspectList.get(0).get("edgeSampleCnt").toString());
			int edgeFaultyCnt 			= Integer.parseInt(edgeInspectList.get(0).get("edgeFaultyCnt").toString());
			float edgeRollFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeRollFaultySize").toString());
			float edgeSymbolFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeSymbolFaultySize").toString());
			float edgeBurFaultySize 	= Float.parseFloat(edgeInspectList.get(0).get("edgeBurFaultySize").toString());
			
			logger.info(workOrdNo);
			/*logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);*/
			
			//생산LotNo 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 작업지시일, 주재료코드)
//			String workOrdLotNo = getCreateWorkOrdLotNo(workOrdNo, lotNo, gubun, equipCd, ordDate, mainMatrlCd);
//			String ordLotNo = getCreateOrdLotNo(workOrdNo, lotNo, gubun, equipCd, mainMatrlCd, workOrdDate);
			
			/*workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setGubun(gubun);
			workOrdOutputSubVo.setEquipCd(equipCd);
			workOrdOutputSubVo.setOrdDate(ordDate);
			workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			workOrdOutputSubVo.setTargetCnt(targetCnt);
			workOrdOutputSubVo.setWorkOrdDate(workOrdDate);
			workOrdOutputSubVo.setEdgeInspctDate(edgeInspctDate);*/
			
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			workOrdOutputSubVo.setEdgeInspctCharger(edgeInspctCharger);
			workOrdOutputSubVo.setEdgeSampleCnt(edgeSampleCnt);
			workOrdOutputSubVo.setEdgeFaultyCnt(edgeFaultyCnt);
			workOrdOutputSubVo.setEdgeRollFaultySize(edgeRollFaultySize);
			workOrdOutputSubVo.setEdgeSymbolFaultySize(edgeSymbolFaultySize);
			workOrdOutputSubVo.setEdgeBurFaultySize(edgeBurFaultySize);
			
//			int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
//			workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
			workOrdOutputSubVo.setUserInputInspctCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setOutputWeight("0");
			workOrdOutputSubVo.setOutputCnt(0);
			workOrdOutputSubVo.setVisionEdgeWeight("0");
			workOrdOutputSubVo.setVisionEdgeCnt(workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubVo.setSubWorkStatusCd("E");
			workOrdOutputSubVo.setUpdId(Utils.getUserId());
			logger.info("workOrdOutputSubVo 값 확인 : "+workOrdOutputSubVo);
			logger.info("workOrdOutputSubVo 값 확인 --------------------> "+workOrdOutputSubVo.getEdgeFaultyCnt());
			workOrdOutputSubService.edgeCheckUpdate_F3(workOrdOutputSubVo);
//			workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
			
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
			edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			edgeGoodsFaultyAdmVo.setOrdLotNo(ordLotNo);
			
			
			//솔브레인SLD 엣지검사 코드화 삭제(삭제 후 Insert)
			workOrdOutputSubService.edgeCheckGoodsFaultyAdmCodeDelete_F3(workOrdOutputSubVo);
			
			// 엣지검사 수정(엣지불량 TB Insert) 코드화 
			for(Map<String,Object> m : edgeInspectList) {
				edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				edgeGoodsFaultyAdmVo.setOrdLotNo(ordLotNo);
				edgeGoodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
				edgeGoodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
				edgeGoodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
				edgeGoodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
				edgeGoodsFaultyAdmVo.setRegId(Utils.getUserId());
				goodsInspectService.edgeCheckInsertCode(edgeGoodsFaultyAdmVo);				
			}
			// 엣지검사 수정(엣지불량 TB Insert) 코드화 끝
			
			jsonData.put("message", "엣지검사 수정되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("엣지검사 수정 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//머티2 - 엣지검사, 외관검사 검사상태 조회
	@RequestMapping(value = "qm/workStatusCheckList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workStatusCheckList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2 - 엣지검사, 외관검사 검사상태 조회");
		try {
			
			String oldWorkOrderNo	= "";
			String newWorkOrderNo	= workOrderVo.getWorkOrdNo();
			int checkCount 			= 0;
			
			WorkOrderVo workOrderListVo = new WorkOrderVo();
			workOrderListVo = workOrderVo;
			workOrderListVo.setWorkOrdNo("");
			
			workOrderListVo.setFactoryCode(facotryCode);
			List<WorkOrderVo> workOrderCheckList= workOrderService.qualityWorkOrderList_F3(workOrderListVo);
			
			//전체 값중 진행인 값이 있는지 확인
			for(int i=0; i<workOrderCheckList.size(); i++) {
				if(workOrderCheckList.get(i).getWorkInspectionStatusCd() != null) {
					if( workOrderCheckList.get(i).getWorkInspectionStatusCd().equals("S") )  {
						checkCount ++;
						oldWorkOrderNo = workOrderCheckList.get(i).getWorkOrdNo();
					}
				}
			}
			
			//값 체크
			if(checkCount == 0) {
				// 값 등록이 안되어 있을 때
				jsonData.put("data", workOrderCheckList);
				jsonData.put("result", "ok");
			} else if(checkCount >= 2){
				// 값이 두 개 이상 등록되어 있을 때
				jsonData.put("data", workOrderCheckList);
				jsonData.put("result", "haveValue");
			}else {
				// 값이 하나 등록이 되어 있을 때
				if( oldWorkOrderNo.equals(newWorkOrderNo) ) {
					// 값 등록이되어 있는데 현재 값이랑 동일 할 때
					jsonData.put("data", workOrderCheckList);
					jsonData.put("result", "ok");
				}else {
					jsonData.put("data", workOrderCheckList);
					jsonData.put("result", "haveValue");
				}
			}
			
		} catch (Exception e) {
			logger.info("머티2 - 엣지검사, 외관검사 검사상태 조회 오류 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//머티2 - 엣지검사, 외관검사 검사상태 등록
	@RequestMapping(value = "qm/workStatusCheckCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workStatusCheckCreate(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2 - 엣지검사, 외관검사 검사상태 등록");
		try {
			WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo();
			WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
			WorkOrderStatusCheckVo.setWorkInspectionStatusCd(workOrderVo.getWorkInspectionStatusCd()); // "" -> 값 없음, S -> 진행, C-> 완료
			workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			
		}
		return jsonData;
	}
	
	
	//머티2공장(MTP2) 외관검사 등록
	@RequestMapping(value = "qm/appearCheckInsert_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckInsert_F2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 외관검사 등록");
		try {
			String workOrdNo	= inspectList.get(0).get("workOrdNo").toString();
			String pIdx 		= inspectList.get(0).get("pIdx").toString();
			
			
			//생산실적 정보_Read
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			

			String appearInspctDate = null, appearInspctCharger = null;
			int appearFaultyCnt = 0, appearOutputCnt = 0, index = 0;

			
			
			//외관 불량검사 코드화 저장
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			
			goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");
			goodsFaultyAdmVo = goodsInspectService.selectGoodsFaultyAdmCodeSeq(goodsFaultyAdmVo);
			String seq = goodsFaultyAdmVo.getSeq();
			
			if( pIdx.toString().isEmpty() ) {
				//등록되지 않았을 경우
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					goodsFaultyAdmVo.setSeq(seq);
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					goodsFaultyAdmVo.setInspctChargr(m.get("inspctChargr").toString());		//검사 담당자
					goodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					goodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					
					goodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					goodsFaultyAdmVo.setFactoryCode(facotryCode);
					//visionInspCnt 업데이트
					if(facotryCode.equals("003")) {						
						String visionInspCnt  = inspectList.get(0).get("visionInspCnt").toString();					
						goodsFaultyAdmVo.setVisionInspCnt(visionInspCnt);
						
						goodsFaultyAdmVo.setNote1(m.get("note1").toString());					//원자재성 비고
						goodsFaultyAdmVo.setNote2(m.get("note2").toString());					//공정성 비고
					}
					
					goodsInspectService.appearCheckInsertCodeSeq(goodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						appearInspctDate 	= m.get("faultyRegDate").toString();
						appearInspctCharger = m.get("inspctChargr").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					appearFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			} else {
				//등록되어 있는 경우
				
				goodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
				goodsFaultyAdmVo.setDayNightCd(inspectList.get(0).get("gubun").toString());
				//goodsInspectService.appearCheckDeleteCode(goodsFaultyAdmVo);
				
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					goodsFaultyAdmVo.setSeq(seq);
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					goodsFaultyAdmVo.setInspctChargr(m.get("inspctChargr").toString());		//검사 담당자
					goodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					goodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					goodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					
					goodsFaultyAdmVo.setFactoryCode(facotryCode);
					//visionInspCnt 업데이트
					if(facotryCode.equals("003")) {						
						String visionInspCnt  = inspectList.get(0).get("visionInspCnt").toString();					
						goodsFaultyAdmVo.setVisionInspCnt(visionInspCnt);
						
						goodsFaultyAdmVo.setNote1(m.get("note1").toString());					//원자재성 비고
						goodsFaultyAdmVo.setNote2(m.get("note2").toString());					//공정성 비고
					}
					
					goodsInspectService.appearCheckInsertCodeSeq(goodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						appearInspctDate 	= m.get("faultyRegDate").toString();
						appearInspctCharger = m.get("inspctChargr").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					appearFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			}
			
			//트레이가 생성 됐고 외관검사일이 등록 되어 있지 않은 경우 첫 번째 트레이에 값을 담아 update 해준다.
			
			//if( inspectList.get(0).get("workStatusCd").toString().equals("C") ) {
				if( workOrdOutputSubVo != null ) {
					
					//if( workOrdOutputSubVo.getAppearInspctDate() == null ) {
						//workOrdOutputSubVo = new WorkOrdOutputSubVo();
						/*workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
						workOrdOutputSubVo.setWorkOrdSeq("1");
						workOrdOutputSubVo.setAppearInspctDate(appearInspctDate);
						workOrdOutputSubVo.setAppearFaultyCnt(appearFaultyCnt);
						workOrdOutputSubVo.setAppearInspctCharger(appearInspctCharger);
						//workOrdOutputSubVo.setAppearOutputCnt( workOrdOutputSubVo.getOutputTotalCnt() - appearFaultyCnt );
						workOrdOutputSubVo.setUpdId( Utils.getUserId() );	//수장자
						workOrdOutputSubVo.setFaultyTrayCheckNum("001");	//전체: 001, 엣지만: 002, 외관만: 003
						workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);*/
					//}
					//생산 실적 delete Create
					ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
					productionPerfTrayController.trayFaultyRelatedCreate(workOrdNo);
					
					
				}			
			//}
			
			logger.info("외관검사 불량 등록 성공");
			jsonData.put("message", "외관검사 등록되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 외관검사 등록 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//머티2공장(MTP2) 외관검사 등록
	@RequestMapping(value = "qm/appearCheckUpdate_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckUpdate_F2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 외관검사 등록");
		try {
			String workOrdNo	= inspectList.get(0).get("workOrdNo").toString();
			String pIdx 		= inspectList.get(0).get("pIdx").toString();
			String seq 			= inspectList.get(0).get("seq").toString();
			
			//생산실적 정보_Read
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			
			String appearInspctDate = null, appearInspctCharger = null;
			int appearFaultyCnt = 0, appearOutputCnt = 0, index = 0;

			//외관 불량검사 코드화 저장
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();			
			
			if( pIdx.toString().isEmpty() ) {
				//등록되지 않았을 경우
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					goodsFaultyAdmVo.setInspctChargr(m.get("inspctChargr").toString());		//검사 담당자
					goodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					goodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					goodsFaultyAdmVo.setRegId(Utils.getUserId());							//등록자
					goodsFaultyAdmVo.setFactoryCode(facotryCode);
					
					//visionInspCnt 업데이트
					if(facotryCode.equals("003")) {						
						String visionInspCnt  = inspectList.get(0).get("visionInspCnt").toString();					
						goodsFaultyAdmVo.setVisionInspCnt(visionInspCnt);
						
						goodsFaultyAdmVo.setNote1(m.get("note1").toString());					//원자재성 비고
						goodsFaultyAdmVo.setNote2(m.get("note2").toString());					//공정성 비고
					}
					
					goodsInspectService.appearCheckInsertCode(goodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						appearInspctDate 	= m.get("faultyRegDate").toString();
						appearInspctCharger = m.get("inspctChargr").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					appearFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			} else {
				//등록되어 있는 경우
				
				goodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
				goodsFaultyAdmVo.setDayNightCd(inspectList.get(0).get("gubun").toString());
				goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");	
				goodsFaultyAdmVo.setSeq(seq);
				goodsInspectService.appearCheckDeleteSeq(goodsFaultyAdmVo);
				
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);								//작업지시번호
					goodsFaultyAdmVo.setOrdLotNo(workOrdNo + "-T");							//생산 LotNo -> 트레이는 작지+-T
					goodsFaultyAdmVo.setSeq(seq);
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());	//불량 등록일
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());				//대분류 코드
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());				//소분류 코드
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());			//불량 개수
					goodsFaultyAdmVo.setInspctChargr(m.get("inspctChargr").toString());		//검사 담당자
					goodsFaultyAdmVo.setDayNightCd(m.get("gubun").toString());				//주야 구분
					goodsFaultyAdmVo.setWorkOrdDate(m.get("faultyRegDate").toString());		//검사일자
					goodsFaultyAdmVo.setRegId(Utils.getUserId());						//등록자					
					goodsFaultyAdmVo.setFactoryCode(facotryCode);
					//visionInspCnt 업데이트
					if(facotryCode.equals("003")) {						
						String visionInspCnt  = inspectList.get(0).get("visionInspCnt").toString();					
						goodsFaultyAdmVo.setVisionInspCnt(visionInspCnt);
						
						goodsFaultyAdmVo.setNote1(m.get("note1").toString());					//원자재성 비고
						goodsFaultyAdmVo.setNote2(m.get("note2").toString());					//공정성 비고
					}
					
					goodsInspectService.appearCheckInsertCodeSeq(goodsFaultyAdmVo);
					
					index++;
					if (index == inspectList.size()) {
						appearInspctDate 	= m.get("faultyRegDate").toString();
						appearInspctCharger = m.get("inspctChargr").toString();
						//appearOutputCnt		= m.get("faultyRegDate").toString();
					}
					appearFaultyCnt += Integer.parseInt( m.get("faultyCnt").toString() );
				}
			}
			
			//트레이가 생성 됐고 외관검사일이 등록 되어 있지 않은 경우 첫 번째 트레이에 값을 담아 update 해준다.
			
			//if( inspectList.get(0).get("workStatusCd").toString().equals("C") ) {
				if( workOrdOutputSubVo != null ) {
					
					//if( workOrdOutputSubVo.getAppearInspctDate() == null ) {
						//workOrdOutputSubVo = new WorkOrdOutputSubVo();
						/*workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
						workOrdOutputSubVo.setWorkOrdSeq("1");
						workOrdOutputSubVo.setAppearInspctDate(appearInspctDate);
						workOrdOutputSubVo.setAppearFaultyCnt(appearFaultyCnt);
						workOrdOutputSubVo.setAppearInspctCharger(appearInspctCharger);
						//workOrdOutputSubVo.setAppearOutputCnt( workOrdOutputSubVo.getOutputTotalCnt() - appearFaultyCnt );
						workOrdOutputSubVo.setUpdId( Utils.getUserId() );	//수장자
						workOrdOutputSubVo.setFaultyTrayCheckNum("001");	//전체: 001, 엣지만: 002, 외관만: 003
						workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);*/
					//}
					//생산 실적 delete Create
					ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
					productionPerfTrayController.trayFaultyRelatedCreate(workOrdNo);					
				}			
			//}
			
			logger.info("외관검사 불량 등록 성공");
			jsonData.put("message", "외관검사 등록되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 외관검사 등록 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//머티2공장(MTP2) 외관검사 삭제
	@RequestMapping(value = "qm/appearCheckDelete_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckDelete_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 외관검사 삭제");
		try {
			
			//외관 코드 Update
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(goodsFaultyAdmVo.getWorkOrdNo());
			workOrdOutputSubVo.setDayNightCd(goodsFaultyAdmVo.getDayNightCd());
			workOrdOutputSubVo.setOrdLotNo( goodsFaultyAdmVo.getWorkOrdNo() +"-T" );
			workOrdOutputSubVo.setSeq( goodsFaultyAdmVo.getSeq());
			//workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo.setFaultyTrayCheckNum("003");	//전체: 001, 엣지만: 002, 외관만: 003
			workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);
			
			//외관검사 불량 코드화 삭제
			goodsInspectService.appearCheckDeleteSeq(goodsFaultyAdmVo);
			logger.info("외관검사 불량 삭제 성공");
			jsonData.put("message", "외관검사 삭제되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 외관검사 삭제 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//솔브레인SLD 외관검사 등록
	@RequestMapping(value = "qm/appearCheckInsert_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckInsert_F3(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인SLD 외관검사 등록");
		try {
			/*
			 * ordDateCal workOrdNo equipCd
			 */
			WorkerChangeVo workerChangeVo = new WorkerChangeVo();
			
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();
			String lotNo 			= inspectList.get(0).get("lotNo").toString();
			String gubun 			= inspectList.get(0).get("gubun").toString();
			String equipCd 			= inspectList.get(0).get("equipCd").toString();
			String ordDate			= inspectList.get(0).get("ordDate").toString();
			String mainMatrlCd 		= inspectList.get(0).get("mainMatrlCd").toString();
			String workOrdDate 		= inspectList.get(0).get("workOrdDate").toString();
			
			workerChangeVo.setOrdDate(ordDate);
			workerChangeVo.setWorkOrdNo(workOrdNo);
			workerChangeVo.setEquipCd(equipCd);
			workerChangeVo.setReadCheckCode1("workerSearch");
			
			WorkerChangeVo workerChangeRead = workOrderService.workerChangeRead(workerChangeVo);
			
			String mainWorkChargr 	= workerChangeRead.getWorkerId();
			String teamCd 			= workerChangeRead.getWorkTeamCd();
			
			/*logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);*/
			
			//생산LotNo 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 작업지시일, 주재료코드)
			String workOrdLotNo = getCreateWorkOrdLotNo(workOrdNo, lotNo, gubun, equipCd, ordDate, mainMatrlCd);
			if (workOrdLotNo.equals("errorType1")) {
				jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
				jsonData.put("result", "error");
				return jsonData;
			} else if (workOrdLotNo.equals("errorType2")) {
				jsonData.put("message", "생산LotNo 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			//생산전표번호 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 주재료코드, 전표번호일자)
			String ordLotNo = getCreateOrdLotNo(workOrdNo, lotNo, gubun, equipCd, mainMatrlCd, workOrdDate);
			if (ordLotNo.equals("errorType1")) {
				jsonData.put("message", "생산전표번호 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setGubun(gubun);
			workOrdOutputSubVo.setEquipCd(equipCd);
			workOrdOutputSubVo.setOrdDate(ordDate);
			workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
			workOrdOutputSubVo.setTeamCd(teamCd);
			workOrdOutputSubVo.setWorkOrdDate(workOrdDate);
			workOrdOutputSubVo.setMainWorkChargr(mainWorkChargr);
			workOrdOutputSubVo.setAppearOutputCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()));		//외관 양품수량
			workOrdOutputSubVo.setAppearInspctCharger(inspectList.get(0).get("inspctChargr").toString());
			workOrdOutputSubVo.setAppearInspctDate(inspectList.get(0).get("faultyRegDate").toString());
			workOrdOutputSubVo.setAppearFaultyCnt(Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
			
			int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
			workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
			workOrdOutputSubVo.setTargetCnt(inspectList.get(0).get("targetCnt").toString());
			workOrdOutputSubVo.setUserInputInspctCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()) + Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
			workOrdOutputSubVo.setOutputWeight("0");
			workOrdOutputSubVo.setOutputCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()) + Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
			workOrdOutputSubVo.setVisionEdgeWeight("0");
			workOrdOutputSubVo.setVisionEdgeCnt(0);
			workOrdOutputSubVo.setSubWorkStatusCd("A");
			workOrdOutputSubVo.setRegId(Utils.getUserId());
			workOrdOutputSubService.appearCheckInsert_F3(workOrdOutputSubVo);
			workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
			
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
			goodsFaultyAdmVo.setOrdLotNo(ordLotNo);
			
			//WorkOrdOutputSubVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			//if ("E".equals(readWorkOrderData.getSubWorkStatusCd())) {
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
					goodsFaultyAdmVo.setOrdLotNo(ordLotNo);
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
					goodsFaultyAdmVo.setRegId(Utils.getUserId());
					goodsInspectService.appearCheckInsertCode(goodsFaultyAdmVo);				
				}					
				
				//int appearOutputCnt = Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString());	//외관양품수량 = 엣지양품수량 - 외관불량수량
				//workOrdOutputSubVo.setAppearOutputCnt(appearOutputCnt);											//외관 양품수량
				//workOrdOutputSubVo.setAppearInspctCharger(inspectList.get(0).get("inspctChargr").toString());
				//workOrdOutputSubVo.setAppearInspctDate(inspectList.get(0).get("faultyRegDate").toString());
				//workOrdOutputSubVo.setAppearFaultyCnt(Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
				//goodsInspectService.appearWorkOrderSubInsert(workOrdOutputSubVo);
				
				/*if(facotryCode.equals("002")) {
					
					WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo(); 
					WorkOrderVo workOrderReadVo = new WorkOrderVo();
					
					workOrderReadVo.setWorkOrdNo(workOrdNo);
					workOrderReadVo = workOrderService.read(workOrderReadVo);
					
					if("".equals(workOrderReadVo.getWorkInspectionStatusCd()) || workOrderReadVo.getWorkInspectionStatusCd() == null) {
						//검사 상태 값 Update
						WorkOrderStatusCheckVo.setWorkOrdNo(workOrdNo);
						WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
						WorkOrderStatusCheckVo.setWorkInspectionStatusCd("S"); // "" -> 값 없음, S -> 진행, C-> 완료
						logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
						workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
						//검사 상태 값 Update
					}
				}*/
				
				logger.info("외관검사 불량 등록 성공");
				jsonData.put("message", "외관검사 등록되었습니다.");
				jsonData.put("result", "ok");
				
			//} else {
			//	jsonData.put("message", readWorkOrderData.getSubWorkStatusNm() + " 상태의 작업지시입니다.<br> 다시 스캔해 주세요!");
			//	jsonData.put("result", "fail");
			//}
		}
		catch (Exception e) {
			logger.info("솔브레인SLD 외관검사 등록");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
		
	//솔브레인SLD 외관검사 수정
	@RequestMapping(value = "qm/appearCheckUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckUpdate_F3(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("외관검사 불량 업데이트");
		
		try {
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			String workOrdNo = inspectList.get(0).get("workOrdNo").toString();
			workOrdOutputSubVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
			String lotNo = inspectList.get(0).get("lotNo").toString();
			String gubun = inspectList.get(0).get("gubun").toString();
			String equipCd = inspectList.get(0).get("equipCd").toString();
			String ordDate = inspectList.get(0).get("ordDate").toString();
			String mainMatrlCd = inspectList.get(0).get("mainMatrlCd").toString();
			String workOrdDate = inspectList.get(0).get("workOrdDate").toString();
			logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);
			
			WorkOrdOutputSubVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if ("Y".equals(readWorkOrderData.getPackYn())) {
				jsonData.put("message", "포장이 완료된 생산전표번호입니다.<br>수정하실 수 없습니다!");
				jsonData.put("result", "fail");
				return jsonData;
			
			//외관검사 수정 실행
			} else {
				GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setWorkOrdNo(inspectList.get(0).get("workOrdNo").toString());
				goodsFaultyAdmVo.setOrdLotNo(inspectList.get(0).get("ordLotNo").toString());
				goodsInspectService.appearCheckDeleteCode(goodsFaultyAdmVo);
				
				for(Map<String,Object> m : inspectList) {
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
					goodsFaultyAdmVo.setOrdLotNo(m.get("ordLotNo").toString());
					goodsFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					goodsFaultyAdmVo.setMajorCd(m.get("majorCd").toString());
					goodsFaultyAdmVo.setMinorCd(m.get("minorCd").toString());
					goodsFaultyAdmVo.setFaultyCnt(m.get("faultyCnt").toString());
					goodsFaultyAdmVo.setRegId(Utils.getUserId());					
					goodsInspectService.appearCheckInsertCode(goodsFaultyAdmVo);	
				}
				
				workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
				workOrdOutputSubVo.setTargetCnt(inspectList.get(0).get("targetCnt").toString());
				workOrdOutputSubVo.setUserInputInspctCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()) + Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
				workOrdOutputSubVo.setOutputWeight("0");
				workOrdOutputSubVo.setOutputCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()) + Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
				workOrdOutputSubVo.setVisionEdgeWeight("0");
				workOrdOutputSubVo.setVisionEdgeCnt(0);
				workOrdOutputSubVo.setAppearOutputCnt(Integer.parseInt(inspectList.get(0).get("appearOutputCnt").toString()));		//외관 양품수량
				workOrdOutputSubVo.setAppearInspctCharger(inspectList.get(0).get("inspctChargr").toString());
				workOrdOutputSubVo.setAppearInspctDate(inspectList.get(0).get("faultyRegDate").toString());
				workOrdOutputSubVo.setAppearFaultyCnt(Integer.parseInt(inspectList.get(0).get("appearFaultyCnt").toString()));
				workOrdOutputSubVo.setUpdId(Utils.getUserId());
				workOrdOutputSubService.appearCheckUpdate_F3(workOrdOutputSubVo);	
				workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
				jsonData.put("message", "외관검사 불량 수정되었습니다.");
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("외관검사 불량 업데이트 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//머티2공장(MTP2) 엣지검사 삭제
	@RequestMapping(value = "qm/edgeCheckDelete_F2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> edgeCheckDelete_F2(EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("머티2공장(MTP2) 엣지검사 삭제");
		try {
			
			//엣지 코드 Update
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(edgeGoodsFaultyAdmVo.getWorkOrdNo());
			workOrdOutputSubVo.setDayNightCd(edgeGoodsFaultyAdmVo.getDayNightCd());
			workOrdOutputSubVo.setOrdLotNo( edgeGoodsFaultyAdmVo.getWorkOrdNo() +"-T" );
			//workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo.setFaultyTrayCheckNum("002");	//전체: 001, 엣지만: 002, 외관만: 003
			workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);
			
			//엣지검사 불량 코드화 삭제
			goodsInspectService.edgeCheckDeleteSeq(edgeGoodsFaultyAdmVo);
			logger.info("엣지검사 불량 삭제 성공");
			jsonData.put("message", "엣지검사 삭제되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("머티2공장(MTP2) 엣지검사 삭제 error");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	// 솔브레인SLD 외관검사 전표번호 삭제 
	@RequestMapping(value = "qm/appearCheckDelete_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> appearCheckDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			//시퀀스 값 가지고 오기
			//String workOrdSeq = workOrdOutputSubVo.getOrdLotNo(); workOrdSeq =
			//workOrdSeq.substring((workOrdSeq.length()-1), workOrdSeq.length());
			//workOrdOutputSubVo.setWorkOrdSeq(workOrdSeq);
			WorkOrdOutputSubVo appearCheckSeqCount_F3 = workOrdOutputSubService.appearCheckSeqCount_F3(workOrdOutputSubVo);
			logger.info("appearCheckSeqCount_F3 값 확인 : " + appearCheckSeqCount_F3);
			WorkOrdOutputSubVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			logger.info("appearCheckSeqCount_F3 : " + appearCheckSeqCount_F3);
			int workOrdSeqCount = Integer.parseInt(appearCheckSeqCount_F3.getWorkOrdSeqCount());
			logger.info("workOrdSeqCount ---------------> " + workOrdSeqCount);
			
			if (workOrdSeqCount == 0) {
				if ("Y".equals(readWorkOrderData.getPackYn())) {
					jsonData.put("message", "포장이 완료된 생산전표번호입니다.<br>삭제하실 수 없습니다!");
					jsonData.put("result", "fail");
					return jsonData;
				} else {
					
					//삭제할 전표번호의 생산LotNo이후 채번된 생산LotNo가 존재하는지 확인
					WorkOrdOutputSubVo appearCheckWorkOrdLotNoVo = new WorkOrdOutputSubVo();
					String[] splitWorkOrdNo = workOrdOutputSubVo.getWorkOrdNo().split("-");
					logger.info("splitWorkOrdNo[0] - " + splitWorkOrdNo[0]);
					appearCheckWorkOrdLotNoVo.setSplitWorkOrdNo(splitWorkOrdNo[0] + "-");
					appearCheckWorkOrdLotNoVo.setWorkOrdLotNo(readWorkOrderData.getWorkOrdLotNo());
					
					String[] splitWorkOrdLotNo = appearCheckWorkOrdLotNoVo.getWorkOrdLotNo().split("-");
					logger.info("splitWorkOrdLotNo 0 - " + splitWorkOrdLotNo[0]);
					logger.info("splitWorkOrdLotNo 1 - " + splitWorkOrdLotNo[1]);
					logger.info("splitWorkOrdLotNo[0] - " + splitWorkOrdLotNo[0] + "-" + splitWorkOrdLotNo[1].substring(0,7));
					appearCheckWorkOrdLotNoVo.setSplitWorkOrdLotNo(splitWorkOrdLotNo[0] + "-" + splitWorkOrdLotNo[1].substring(0,7));
					
					List<WorkOrdOutputSubVo> appearCheckWorkOrdLotNo_F3 = workOrdOutputSubService.appearCheckWorkOrdLotNo_F3(appearCheckWorkOrdLotNoVo);
					//SELECT * FROM TB_WORK_ORDER_OUTPUT_SUB
					//WHERE WORK_ORD_NO LIKE 'LD11A220316-' + '%'	--해당작지목록 중
					//AND WORK_ORD_LOT_NO > 'LD11AAL-220316D0'		--해당 생산LotNo 후에 채번된게 있는지 확인
					//AND WORK_ORD_LOT_NO LIKE 'LD11AAL-220316D' + %'	--주야 구분
					
					//해당 생산LotNo 이후 채번된 번호 없음->삭제진행
					if (appearCheckWorkOrdLotNo_F3.size() == 0) {
						//외관검사 삭제
						if (readWorkOrderData.getSubWorkStatusCd().equals("A")) {
							workOrdOutputSubService.appearAndEdgeCheckDelete_F3(workOrdOutputSubVo);
							workOrdOutputSubService.appearCheckGoodsFaultyAdmCodeDelete_F3(workOrdOutputSubVo); //솔브레인SLD 외관검사 코드화 삭제
							readWorkOrderData.setIpAddress(Utils.getClientIP(request));
							readWorkOrderData.setDltId(Utils.getUserId());
							workOrdOutputSubService.workOrdOutputSubCreateTemp(readWorkOrderData);
							logger.info("솔브레인SLD 외관검사 전표번호 삭제 후 : " + workOrdOutputSubVo);
							
							List<WorkOrdOutputSubVo> workOrdOutputSubList = workOrdOutputSubService.edgeCheckList_F3(readWorkOrderData);
							logger.info("값을 한번 확인해보겠습니다. 00000 : " +workOrdOutputSubList );
							logger.info("값을 한번 확인해보겠습니다. : " +workOrdOutputSubList.size() );
							
							//검사 상태 값 Update
							if(facotryCode.equals("002")) {
								WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo();
								if(workOrdOutputSubList.size() == 0) {
									WorkOrderStatusCheckVo.setWorkOrdNo(readWorkOrderData.getWorkOrdNo());
									WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
									WorkOrderStatusCheckVo.setWorkInspectionStatusCd(""); // "" -> 값 없음, S -> 진행, C-> 완료
									logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
									workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
								}
							}
							//검사 상태 값 Update
							
							jsonData.put("result", "ok");
						//엣지검사 삭제
						} else if (readWorkOrderData.getSubWorkStatusCd().equals("E")) {
							workOrdOutputSubService.appearAndEdgeCheckDelete_F3(workOrdOutputSubVo);
							workOrdOutputSubService.edgeCheckGoodsFaultyAdmCodeDelete_F3(workOrdOutputSubVo); //솔브레인SLD 엣지검사 코드화 삭제
							readWorkOrderData.setIpAddress(Utils.getClientIP(request));
							readWorkOrderData.setDltId(Utils.getUserId());
							workOrdOutputSubService.workOrdOutputSubCreateTemp(readWorkOrderData);
							logger.info("솔브레인SLD 엣지검사 전표번호 삭제 후 : " + workOrdOutputSubVo);
							jsonData.put("result", "ok");
						//그외 오류
						} else {
							jsonData.put("result", "error");
							jsonData.put("message", Utils.getErrorMessage());
						}
						
					//생산LotNo 채번규칙 위배->삭제X
					} else {
						String failMessage = "<br>";
						for (int i=0; i<appearCheckWorkOrdLotNo_F3.size(); i++) {
							failMessage += appearCheckWorkOrdLotNo_F3.get(i).getOrdLotNo() + "<br>";	
						}
						jsonData.put("message", "선택하신 생산전표 이후로 등록된 생산전표가 존재합니다!" + failMessage + "해당 생산전표번호를 먼저 삭제해주세요!");
						jsonData.put("result", "haveSeq");
					}
				}
			
			} else if (workOrdSeqCount != 0) {
				if (appearCheckSeqCount_F3.getSubWorkStatusCd().equals("A")) {
					jsonData.put("message", "선택하신 생산전표 이후로 등록된 생산전표가 존재합니다!<br>외관 검사에 있는 '" + appearCheckSeqCount_F3.getOrdLotNo() + "' 항목먼저 삭제해주세요");
					jsonData.put("result", "haveSeq");
					return jsonData;
				} else if (appearCheckSeqCount_F3.getSubWorkStatusCd().equals("E")) {
					jsonData.put("message", "선택하신 생산전표 이후로 등록된 생산전표가 존재합니다!<br>엣지 검사에 있는 '" + appearCheckSeqCount_F3.getOrdLotNo() + "' 항목먼저 삭제해주세요");
					jsonData.put("result", "haveSeq");
					return jsonData;
				} else {
					jsonData.put("result", "error");
					jsonData.put("message", Utils.getErrorMessage());
				}

			} else {
				jsonData.put("result", "error");
				jsonData.put("message", Utils.getErrorMessage());
			}

		} catch (Exception e) {
			logger.info("외관검사 삭제 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/* WorkOrdOutputSubController 에서도 똑같이 복붙하여 사용중임. 서비스들 Static으로 사용 할 수 있는 방법 찾아야함 */
	//생산LotNo 채번
	public String getCreateWorkOrdLotNo (String workOrdNo, String lotNo, String gubun, String equipCd, String ordDate, String mainMatrlCd) throws Exception {
		String workOrdLotNo = "";
		
    	try {
    		String checkWorkOrdLotNoOption = "";
			//같은 작지&주재료의 생산실적 입력 시 주야간이 변경될 경우 생산LotNo 새로 채번 여부
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("081");
			systemCommonCodeVo.setEtc1("Y");
			systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
			// 001 = 주야간 변경시 생산LotNo 채번 O
			// 002 = 주야간 변경시 생산LotNo 채번 X
			if (systemCommonCodeVo == null) {
				return workOrdLotNo = "errorType1";
			} else if ("001".equals(systemCommonCodeVo.getBaseCd())) {
				checkWorkOrdLotNoOption = "001";
			} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
				checkWorkOrdLotNoOption = "002";
			}
			EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
			equipCodeAdmVo.setEquipCd(equipCd);
			equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
			int bodyLength = equipCodeAdmVo.getEquipNm().replace("-", "").length();
			bodyLength += 10;	//생산lotNo 에서는 D,N을 잘라야하기에 10을더함
			
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setGubun(gubun);
			workOrdOutputSubVo.setEquipCd(equipCodeAdmVo.getEquipCd());
			workOrdOutputSubVo.setEquipNm(equipCodeAdmVo.getEquipNm());
			workOrdOutputSubVo.setOrdDate(ordDate);
			workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
			workOrdOutputSubVo.setCheckWorkOrdLotNoOption(checkWorkOrdLotNoOption);
			workOrdOutputSubVo.setBodyLength(bodyLength);
			
			logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCodeAdmVo.getEquipCd());
			logger.info(equipCodeAdmVo.getEquipNm());
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(checkWorkOrdLotNoOption);
			logger.info(Integer.toString(bodyLength));
			
			//생산LotNo(workOrdLotNo)생성													//옵션에따라 주야간 구분처리 추가하였음
			List<WorkOrdOutputSubVo> workOrdLotNoCheckList = workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
			if (workOrdLotNoCheckList.size() == 0) {
				String workOrdLotNoBody =  workOrdOutputSubService.createWorkOrdLotNoBody(workOrdOutputSubVo);	//ex) LD1ANC-21122D
				int workOrdLotNoCount =  workOrdOutputSubService.createWorkOrdLotNoCount(workOrdOutputSubVo);	//ex) 1
				workOrdLotNo = workOrdLotNoBody + Integer.toString(workOrdLotNoCount);							//ex) LD1ANC-21122D1
			} else {
				workOrdLotNo = workOrdLotNoCheckList.get(0).getWorkOrdLotNo();
			}
			
			logger.info("진짜 생산LotNo - " + workOrdLotNo);
    		
		} catch (Exception e) {
			workOrdLotNo = "errorType2";
			logger.info("생산LotNo(workOrdLotNo) 채번 에러!");
			e.printStackTrace();
		}
    	
    	return workOrdLotNo;
	}
	
	
	//생산전표번호 채번
	public String getCreateOrdLotNo (String workOrdNo, String lotNo, String gubun, String equipCd, String mainMatrlCd, String workOrdDate) throws Exception {
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEquipCd(equipCd);
		equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
		int bodyLength = equipCodeAdmVo.getEquipNm().replace("-", "").length();
		bodyLength += 12;
		
		String ordLotNo = "";
		WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
		workOrdOutputSubVo.setLotNo(lotNo);
		workOrdOutputSubVo.setGubun(gubun);
		workOrdOutputSubVo.setEquipCd(equipCodeAdmVo.getEquipCd());
		workOrdOutputSubVo.setEquipNm(equipCodeAdmVo.getEquipNm());
		workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
		workOrdOutputSubVo.setWorkOrdDate(workOrdDate);
		workOrdOutputSubVo.setBodyLength(bodyLength);
		
		logger.info(workOrdNo);
		logger.info(lotNo);
		logger.info(gubun);
		logger.info(equipCodeAdmVo.getEquipCd());
		logger.info(equipCodeAdmVo.getEquipNm());
		logger.info(mainMatrlCd);
		logger.info(workOrdDate);
		logger.info(Integer.toString(bodyLength));
		
    	try {
			String ordLotNoBody = workOrdOutputSubService.createOrdLotNoBody(workOrdOutputSubVo);
			logger.info("ordLotNoBody - " + ordLotNoBody);
			List<WorkOrdOutputSubVo> WorkOrdOutputSublist = workOrdOutputSubService.checkOrdLotNo(workOrdOutputSubVo);
			//생산전표번호 등록되었는지 확인
			int ordLotNoCount;
			if (WorkOrdOutputSublist.size() == 0) {
				ordLotNoCount = workOrdOutputSubService.createOrdLotNoCount(workOrdOutputSubVo);
				logger.info("ordLotNoCount - " + ordLotNoCount);
			} else {
				String ordLotNoSplit[] = WorkOrdOutputSublist.get(0).getOrdLotNo().split("-");
				String ordLotNoTemp1 = ordLotNoSplit[1];
				ordLotNoTemp1 = ordLotNoTemp1.substring(7, ordLotNoTemp1.length());
				logger.info("ordLotNoTemp1 - " + ordLotNoTemp1);
				ordLotNoCount = Integer.parseInt(ordLotNoTemp1);
				logger.info("ordLotNoCount - " + ordLotNoCount);
			}
			
			WorkOrdOutputSubVo ordLotNoVoTemp = new WorkOrdOutputSubVo();
			ordLotNoVoTemp.setOrdLotNo(ordLotNoBody + Integer.toString(ordLotNoCount));
			int ordLotNoLastCount = workOrdOutputSubService.createOrdLotNoLastCount(ordLotNoVoTemp);
			ordLotNo = ordLotNoBody + Integer.toString(ordLotNoCount) + "-" + Integer.toString(ordLotNoLastCount);			
			logger.info("ordLotNoBody - " + ordLotNoBody);
			logger.info("ordLotNoCount - " + ordLotNoCount);
			logger.info("ordLotNoLastCount - " + ordLotNoLastCount);
			logger.info("ordLotNo - " + ordLotNo);
    		
		} catch (Exception e) {
			ordLotNo = "errorType1";
			logger.info("생산생산전표번호(ordLotNo) 채번 에러!");
			e.printStackTrace();
		}
    	
    	return ordLotNo;
	}
	/* WorkOrdOutputSubController 에서도 똑같이 복붙하여 사용중임. 서비스들 Static으로 사용 할 수 있는 방법 찾아야함 */
	
	//외관검사 세부 목록
	@RequestMapping(value = "/qm/readGoodsFaultyAdmCodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readGoodsFaultyAdmCodeList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("외관검사 세부 목록");
		try {
			List<GoodsFaultyAdmVo> goodsFaultyAdmList = goodsInspectService.readGoodsFaultyAdmCodeList(goodsFaultyAdmVo);
			jsonData.put("data", goodsFaultyAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("외관검사 세부 목록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	// 엣지검사 목록
	@RequestMapping(value = "/qm/readEdgeGoodsFaultyAdmCodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readEdgeGoodsFaultyAdmCodeList(EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info(" 엣지검사 목록 조회");
		try {
			List<EdgeGoodsFaultyAdmVo> goodsFaultyAdmList = goodsInspectService.readEdgeGoodsFaultyAdmCodeList(edgeGoodsFaultyAdmVo);
			jsonData.put("data", goodsFaultyAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("엣지검사 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
}