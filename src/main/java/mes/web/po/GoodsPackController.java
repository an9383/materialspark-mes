package mes.web.po;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.EquipSizeCondStepVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.ProductionPerfTrayVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.ShipInspectVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.po.EquipSizeCondStepService;
import mes.service.po.GoodsPackService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.qm.ShipInspectService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.MtpLabel;
import mes.web.ut.Settings;
import mes.web.ut.Utils;

@Controller
public class GoodsPackController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	@Inject
	private GoodsPackService goodsPackService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;	
	@Inject
	private EquipSizeCondStepService equipSizeCondStepService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private PreGoodsInventoryAdmService preGoodsInventoryAdmService;
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private ShipInspectService shipInspectService;
	@Inject
	private PdaService PdaService;
	@Inject
	private ProductionPerfTrayService productionPerfTrayService;
	
	private static final Logger logger = LoggerFactory.getLogger(GoodsPackController.class);
	
	@Value("${factoryCode}") private String factoryCode;
	@Value("${lablePrint.IP3}") private String IP3;
	@Value("${lablePrint.IP4}") private String IP4;
	@Value("${lablePrint.IP5}") private String IP5;
	@Value("${lablePrint.IP6}") private String IP6;
	@Value("${lablePrint.port}") private String PORT;
	
	//공정실적관리 작업지시 페이지
	@RequestMapping(value = "/posc0030", method = RequestMethod.GET)
	public String goodsPackMain(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리 생산실적라벨발행 메인");
		
//		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
//		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
//		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
//		model.addAttribute("workTeamCd", systemCommonCodeList );
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		//model.addAttribute("ip", IP );
		//model.addAttribute("port", PORT );
		model.addAttribute("goodsCode", goodsCodeDataList );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "po/posc0030";
	}
	
	//공정실적관리 작업지시 페이지_F3
	@RequestMapping(value = "/posc3030", method = RequestMethod.GET)
	public String posc3030(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리 생산실적라벨발행 메인");
		
//		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
//		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
//		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
//		model.addAttribute("workTeamCd", systemCommonCodeList );
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		//model.addAttribute("ip", IP );
		//model.addAttribute("port", PORT );
		model.addAttribute("goodsCode", goodsCodeDataList );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "po/posc3030";
	}
	
	//공정실적관리 작업지시 페이지
		@RequestMapping(value = "/posc0070", method = RequestMethod.GET)
		public String goodsPackRePrint(Locale locale, Model model) throws Exception {
			
			logger.info("공정실적관리 생산실적 재발행 메인");
			
//			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			
//			systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
//			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
//			model.addAttribute("workTeamCd", systemCommonCodeList );
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
			//model.addAttribute("ip", IP );
			//model.addAttribute("port", PORT );
			model.addAttribute("goodsCode", goodsCodeDataList );
			model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
			
			return "po/posc0070";
		}
	
	 //작업지시서 포장 목록조회
	 @RequestMapping(value = "/po/workOrderPackDataList", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> workOrderPackDataList(WorkOrderVo workOrderVo) throws Exception {
		 
		 Map<String, Object> jsonData = new HashMap<String, Object>();
		 logger.info("작업지시서 계획 목록조회");
		 try {
			 List<WorkOrderVo> workOrderData= goodsPackService.workOrderPackDataList(workOrderVo);
			 jsonData.put("data", workOrderData);
			 jsonData.put("result", "ok");
		 	}
			catch (Exception e) {
				logger.info("작업지시서 목록조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
			}			 
		 return jsonData;
	 }
	 
	//작업지시서 빈포장 목록조회
	@RequestMapping(value = "/po/workOrderPackDataEmptyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderPackDataEmptyList(HttpServletRequest request, WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 빈포장 목록조회");
		HttpSession session = request.getSession(true);
		try {
			
			if ("001".equals(session.getAttribute("factoryCode"))) {
				WorkOrderVo workOrderData = new WorkOrderVo();
				jsonData.put("data", workOrderData);
				jsonData.put("result", "ok");
			} else if ("002".equals(session.getAttribute("factoryCode"))) {
				WorkOrderVo workOrderData = new WorkOrderVo();
				jsonData.put("data", workOrderData);
				jsonData.put("result", "ok");
			} else if ("003".equals(session.getAttribute("factoryCode"))) {
				
				WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
				logger.info("Vo 확인 ----> "+workOrderVo.getWorkOrdDate());
				workOrdOutputSubVo.setWorkOrdDate(workOrderVo.getWorkOrdDate());
				
				List<WorkOrdOutputSubVo> dateLookupAllWorkOrdLotNoList = goodsInspectService.dateLookupAllWorkOrdLotNoList(workOrdOutputSubVo);
				
				jsonData.put("serverDate", DateUtil.getToday("yyyy-mm-dd"));
				jsonData.put("data", dateLookupAllWorkOrdLotNoList);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("작업지시서 빈포장 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//제품포장 목록조회(해외1,해외2,국내)
	@RequestMapping(value = "/po/goodsPackList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		goodsProductInfoAdmVo.setFactoryCode(factoryCode); 
		logger.info("제품포장 목록조회(해외1,해외2,국내) - " + goodsProductInfoAdmVo);
		try {
			List<GoodsProductInfoAdmVo> goodsLabelPublishData = goodsPackService.goodsPackList(goodsProductInfoAdmVo);
			jsonData.put("data", goodsLabelPublishData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품포장 목록조회(해외1,해외2,국내) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//제품포장 목록조회
	@RequestMapping(value = "/po/goodsUnPackList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsUnPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("제품포장 목록조회(해외1,해외2,국내)");
		try {
			List<GoodsProductInfoAdmVo> goodsLabelPublishData = goodsPackService.goodsUnPackList(goodsProductInfoAdmVo);
			jsonData.put("data", goodsLabelPublishData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품미포장 목록조회(해외1,해외2,국내) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//미제품포장의 특정 생산LotNo의 전표목록 조회
	@RequestMapping(value = "/po/goodsUnPackListDtl", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsUnPackListDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("제품포장 목록조회(해외1,해외2,국내)");
		try {
			List<GoodsProductInfoAdmVo> goodsLabelPublishData = goodsPackService.goodsUnPackDtlList(goodsProductInfoAdmVo);
			jsonData.put("data", goodsLabelPublishData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품미포장 목록조회(해외1, 해외2, 국내) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	 //작업지시 상세조회
	 @RequestMapping(value = "/po/workOrderData", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> workOrderData(WorkOrderVo workOrderVo) throws Exception {
		 Map<String, Object> jsonData = new HashMap<String, Object>();
		 logger.info("생산실적라벨발행 작업지시 상세조회");
		 try {
			 workOrderVo = workOrderService.read(workOrderVo);
			 jsonData.put("data", workOrderVo);
			 jsonData.put("result", "ok");
		 } catch (Exception e) {
				logger.info("생산실적라벨발행 작업지시 상세조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");			 
		 }			 
		 return jsonData;
	 }
	 
	 //생산실적 라벨발행 시 작지 스캔
	 /*
	 @RequestMapping(value = "/po/workOrdGoodsPackScan", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> goodsPackScan(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		 Map<String, Object> jsonData = new HashMap<String, Object>();
		 logger.info("생산실적 라벨발행 시 작지 스캔");
		 try {
			 WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			 //workOrderVo = workOrderService.read(workOrderVo);
			if (readWorkOrdOutputSubVo == null) {
				jsonData.put("message", "조회된 생산LotNo가 없습니다. 바코드를 확인해 주세요!");
				jsonData.put("result", "fail");
			} else {
			 	if ("Y".equals(readWorkOrdOutputSubVo.getPackYn())) {
			 		jsonData.put("message", "이미 포장된 생산LotNo 입니다.<br/>바코드를 확인해 주세요.");
					jsonData.put("result", "fail");
			 	//} else if ("B".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 	//	jsonData.put("message", "해당 작지는 미발행 작지입니다. 바코드를 확인해주세요!");
				//	jsonData.put("result", "fail");
			 	//} else if ("P".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 	//	jsonData.put("message", "해당 작지는 발행 상태 작지입니다. 바코드를 확인해주세요!");
				//	jsonData.put("result", "fail");
			 	} else if ("S".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 		jsonData.put("message", "해당 작지는 진행 상태 생산LotNo입니다. 바코드를 확인해주세요!");
					jsonData.put("result", "fail");
			 	} else if ("C".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 		jsonData.put("message", "해당 작지는 엣지검사 대상 생산LotNo입니다. 바코드를 확인해주세요!");
					jsonData.put("result", "fail");
			 	} else if ("E".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 		jsonData.put("message", "해당 작지는 외관검사 대상 생산LotNo입니다. 바코드를 확인해주세요!");
					jsonData.put("result", "fail");
			 	//} else if ("G".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 	//	jsonData.put("message", "해당 작지는 외관검사 대상 작지입니다. 작지바코드를 확인해주세요!");
				//	jsonData.put("result", "fail");
			 	} else if ("A".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
			 		//종물 등록 확인
					EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
					thirdEquipSizeCondStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
					thirdEquipSizeCondStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
					//thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
					thirdEquipSizeCondStep.setStepCd("003");
					thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(thirdEquipSizeCondStep);
					
			 		//종뭄 등록했는지 확인
					if( thirdEquipSizeCondStep.getCount() == 0 ) {
						jsonData.put("message", "종물을 등록 후 포장해주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					} else {
						//작지 스캔시 서버날짜로 포장, 미포장 검색조건에 사용
						jsonData.put("serverDate", DateUtil.getToday("yyyy-mm-dd") );
						jsonData.put("data", readWorkOrdOutputSubVo);
						jsonData.put("result", "ok");
					}
			 	}
			}
		 } catch (Exception e) {
				logger.info("생산실적 라벨발행 시 작지 스캔 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
		 }
		 
		 return jsonData;
	 }
	 */
	 
	//scanWorkOrdLotNo _사용안할때 날짜별 전체 조회
	@RequestMapping(value = "/po/dateLookupAllWorkOrdLotNoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> dateLookupAllWorkOrdLotNoList(HttpServletRequest request, WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("생산실적 라벨발행 시 날짜별 전체 조회");
		HttpSession session = request.getSession(true);
		try {
			
			List<WorkOrdOutputSubVo> dateLookupAllWorkOrdLotNoList = goodsInspectService.dateLookupAllWorkOrdLotNoList(workOrdOutputSubVo);
			
			jsonData.put("serverDate", DateUtil.getToday("yyyy-mm-dd"));
			jsonData.put("data", dateLookupAllWorkOrdLotNoList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 시 작지 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}	 
	
	@RequestMapping(value = "/po/workOrdGoodsPackScan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsPackScan(HttpServletRequest request, WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("생산실적 라벨발행 시 작지 스캔");
		HttpSession session = request.getSession(true);
		
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdLotNo(workOrdOutputSubVo);
			if (readWorkOrdOutputSubVo == null) {
				jsonData.put("message", "해당 생산LotNo로 포장 가능한 생산전표번호가 없습니다!");
				jsonData.put("result", "fail");
			} else {
				
				if ("001".equals(session.getAttribute("factoryCode"))) {
					EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
					thirdEquipSizeCondStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
					thirdEquipSizeCondStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
					thirdEquipSizeCondStep.setStepCd("003");
					thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(thirdEquipSizeCondStep);
					if (thirdEquipSizeCondStep.getCount() == 0) {
						jsonData.put("message", "종물을 등록 후 포장해주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}// else if ("002".equals(session.getAttribute("factoryCode")) || "003".equals(session.getAttribute("factoryCode"))) {
				//
				//}
				
				jsonData.put("serverDate", DateUtil.getToday("yyyy-mm-dd"));
				jsonData.put("data", readWorkOrdOutputSubVo);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 시 작지 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//작업지시 오더별 양품정보 수정
	@RequestMapping(value = "/po/updateWorkOrdAppearCnt", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrdAppearCnt(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<>();
		workOrdOutputSubVo.setUpdId(Utils.getUserId());
		logger.info("작업지시 오더별 양품정보 수정 = " + workOrdOutputSubVo);
		logger.info("로그인 ID : " + Utils.getUserId());

		try {
			workOrdOutputSubService.updateWorkOrdAppearCnt(workOrdOutputSubVo);
			jsonData.put("data", workOrdOutputSubVo);
			jsonData.put("message", workOrdOutputSubVo.getOrdLotNo() + " - 입력수량 저장되었습니다.");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업지시 오더별 양품정보 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
 
	
	@RequestMapping(value = "/po/goodsUnpackPublish", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> goodsUnpackPublish(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("생산 전표번호 미포장으로 변경 라벨발행= " + workOrdOutputSubVo);
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
			readWorkOrdOutputSubVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
			readWorkOrdOutputSubVo.setWorkOrdLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
			readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdLotNo(workOrdOutputSubVo);
			
			if (readWorkOrdOutputSubVo != null) {
				if (!workOrdOutputSubVo.getPackOrdLotNoList().equals(readWorkOrdOutputSubVo.getPackOrdLotNoList())) {
					jsonData.put("message", "해당 생산LotNo의 미포장으로 변경 할 수 있는 생산전표번호의 정보가 변경되었습니다.<br>생산LotNo를 다시 스캔해 주세요!");
					jsonData.put("result", "fail");
				} else if (workOrdOutputSubVo.getPackTotalCnt() != readWorkOrdOutputSubVo.getTotalCnt()) {
					jsonData.put("message", "해당 생산LotNo 생산전표번호의 생산수량이 변경되었습니다.<br>생산LotNo를 다시 스캔해 주세요!");
					jsonData.put("result", "fail");
				} else {
					String workOrdNo = workOrdOutputSubVo.getWorkOrdNo();
					String workOrdLotNo = workOrdOutputSubVo.getWorkOrdLotNo();
					String today = DateUtil.getToday("yyyymmdd");
					String frontToday = DateUtil.getToday("yyyy-mm-dd");
					int packNumberSeq = goodsInspectService.packNumberSeq(today);
					String packNumber = String.valueOf(today) + "-" + String.format("%05d", packNumberSeq);
					int packTotalCnt = workOrdOutputSubVo.getPackTotalCnt();
					int userOutputCnt = workOrdOutputSubVo.getUserOutputCnt();
					GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
					tmpGoodsProductInfoAdmVo.setGoodsCd(workOrdOutputSubVo.getGoodsCd());
					tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
					tmpGoodsProductInfoAdmVo.setWorkOrdLotNo(workOrdLotNo);
					tmpGoodsProductInfoAdmVo.setPackDtlCnt(userOutputCnt);
					tmpGoodsProductInfoAdmVo.setPackRemainCnt(userOutputCnt);
					tmpGoodsProductInfoAdmVo.setPackNumber(packNumber);
					tmpGoodsProductInfoAdmVo.setPackDate(today);
					tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo);
					String ordLotNoSlashList = readWorkOrdOutputSubVo.getPackOrdLotNoList();
					String[] ordLotNoArray = ordLotNoSlashList.split("/");
					String ordLotNoInList = "";
					for (int i = 0; i < ordLotNoArray.length; i++) {
						if (i != ordLotNoArray.length - 1) {
							ordLotNoInList = String.valueOf(ordLotNoInList) + "'" + ordLotNoArray[i] + "', ";
						} else {
							ordLotNoInList = String.valueOf(ordLotNoInList) + "'" + ordLotNoArray[i] + "'";
						}
					}
					logger.info("ordLotNoInList - " + ordLotNoInList);
					WorkOrdOutputSubVo updateOrdLotNoPackNumber = new WorkOrdOutputSubVo();
					updateOrdLotNoPackNumber.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
					updateOrdLotNoPackNumber.setWorkOrdLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
					updateOrdLotNoPackNumber.setOrdLotNo(ordLotNoInList);
					updateOrdLotNoPackNumber.setUserOutputCnt(workOrdOutputSubVo.getUserOutputCnt());
					updateOrdLotNoPackNumber.setPackNumber(packNumber);
					updateOrdLotNoPackNumber.setPackTotalCnt(workOrdOutputSubVo.getPackTotalCnt());
					updateOrdLotNoPackNumber.setPackOrdLotNoList(workOrdOutputSubVo.getPackOrdLotNoList());
					updateOrdLotNoPackNumber.setUpdId(Utils.getUserId());
					goodsInspectService.updateOrdLotNoPackNumber(updateOrdLotNoPackNumber);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					workOrdOutputSubVo.setGoodsCd(readWorkOrdOutputSubVo.getGoodsCd());
					workOrdOutputSubVo.setWorkOrdLotNo(readWorkOrdOutputSubVo.getWorkOrdLotNo());
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					stockPaymentAdmVoMinus = StockPaymentAdmController.goodsInspctStockPaymentMinus(workOrdOutputSubVo, "O", factoryCode);
					stockPaymentAdmVoMinus.setSpCount(workOrdOutputSubVo.getUserOutputCnt());
					stockPaymentAdmService.goodUnpackStockPaymentMinus(stockPaymentAdmVoMinus);	//기존 재고 -
					StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					stockPaymentAdmVoPlus = StockPaymentAdmController.goodsUnpackStockPaymentPlus(workOrdOutputSubVo, factoryCode);
					stockPaymentAdmVoPlus.setSpCount(workOrdOutputSubVo.getUserOutputCnt());
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//새 위치 재고 +
					
					jsonData.put("data", readWorkOrdOutputSubVo);
					jsonData.put("frontToday", frontToday);
					jsonData.put("message", "포장 대기 상태로로 변경되었습니다.");
					jsonData.put("result", "ok");
				}
				
			//검색값 X
			} else {
				jsonData.put("message", "해당 생산LotNo 생산전표번호의 생산수량이 변경되었습니다.<br>생산LotNo를 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
				
			}
			
			
			
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	
	//포장대기 복원
	@RequestMapping(value = "/po/workOrdLotNoUnpack", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdLotNoUnpack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("생산LotNo(미포장) 복원" + goodsProductInfoAdmVo);
		try {
			//제품미포장 생산LotNo로 상세조회
			GoodsProductInfoAdmVo readgoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			readgoodsProductInfoAdmVo = goodsPackService.readWorkOrdLotNoGoodsUnPack(goodsProductInfoAdmVo);
			//SELECT
			//	A.GOODS_CD
			//	, C.GOODS_NM
			//	, SUM(A.PACK_DTL_CNT) PACK_DTL_CNT
			//	, SUM(A.PACK_REMAIN_CNT) PACK_REMAIN_CNT
			//	, A.WORK_ORD_NO
			//	, A.WORK_ORD_LOT_NO
			//FROM TB_GOODS_PRODUCT_INFO_TMP A
			//	, TB_GOODS_CODE_ADM C
			//WHERE A.GOODS_CD = C.GOODS_CD
			//AND A.WORK_ORD_LOT_NO = #{workOrdLotNo}
			//GROUP BY A.GOODS_CD, GOODS_NM, A.WORK_ORD_NO, A.WORK_ORD_LOT_NO
			//HAVING SUM(A.PACK_REMAIN_CNT) != 0
			//ORDER BY A.WORK_ORD_LOT_NO
			
			//검색정보가 있으면
			if (readgoodsProductInfoAdmVo != null) {
				//각종 예외처리
				if (goodsProductInfoAdmVo.getPackDtlCnt() != readgoodsProductInfoAdmVo.getPackDtlCnt()) {
					jsonData.put("message", "선택하신 생산LotNo의 정보가 변경되었습니다!<br>다시 확인해 주세요!");
					jsonData.put("result", "fail");
					
				} else if (goodsProductInfoAdmVo.getPackRemainCnt() != readgoodsProductInfoAdmVo.getPackRemainCnt()) {
					jsonData.put("message", "선택하신 생산LotNo의 정보가 변경되었습니다!<br>다시 확인해 주세요!");
					jsonData.put("result", "fail");
					
				} else if (readgoodsProductInfoAdmVo.getPackDtlCnt() != readgoodsProductInfoAdmVo.getPackRemainCnt()) {
					jsonData.put("message", "총 수량과 잔여수량이 같아야지만 포장 대기를 복원처리 하실 수 있습니다!");
					jsonData.put("result", "fail");
					
				//해당 생산LotNo 의 총수량 = 잔여수량인지 확인
				} else if (readgoodsProductInfoAdmVo.getPackDtlCnt() == readgoodsProductInfoAdmVo.getPackRemainCnt()) {
					WorkOrdOutputSubVo updateWorkOrdLotNoUnpack = new WorkOrdOutputSubVo();
					updateWorkOrdLotNoUnpack.setWorkOrdLotNo(readgoodsProductInfoAdmVo.getWorkOrdLotNo());
					//해당 생산LotNo 들 중 포장된 생산실적 외관검사 종료시점으로 복구
					workOrdOutputSubService.updateWorkOrdLotNoUnpack(updateWorkOrdLotNoUnpack);
					//UPDATE TB_WORK_ORDER_OUTPUT_SUB
					//SET PACK_YN = 'N'
					//	, USER_OUTPUT_CNT = NULL
					//	, PACK_NUMBER = NULL
					//	, PACK_ORD_LOT_NO_LIST = NULL
					//	, PACK_TOTAL_CNT = NULL
					//WHERE WORK_ORD_LOT_NO = #{workOrdLotNo}
					//AND PACK_YN = 'Y'
					
					//TMP의 해당 생산LotNo 전체 삭제
					goodsPackService.deleteWorkOrdLotNoGoodsProductTmp(readgoodsProductInfoAdmVo);
					//DELETE TB_GOODS_PRODUCT_INFO_TMP
					//WHERE WORK_ORD_LOT_NO = #{workOrdLotNo}
					
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					updateWorkOrdLotNoUnpack.setGoodsCd(readgoodsProductInfoAdmVo.getGoodsCd());
					StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					stockPaymentAdmVoMinus = StockPaymentAdmController.goodUnpackStockPaymentMinus(updateWorkOrdLotNoUnpack, "O", factoryCode);
					stockPaymentAdmVoMinus.setSpCount(readgoodsProductInfoAdmVo.getPackDtlCnt());
					stockPaymentAdmService.goodUnpackStockPaymentMinus(stockPaymentAdmVoMinus);	//기존 재고 -
					
					stockPaymentAdmVoPlus = StockPaymentAdmController.goodsInspctStockPaymentPlus(updateWorkOrdLotNoUnpack, factoryCode);
					stockPaymentAdmVoPlus.setSpCount(readgoodsProductInfoAdmVo.getPackDtlCnt());
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//새 위치 재고 +
					
					
					jsonData.put("message", "해당 생산LotNo의 포장 대기 복원이 정상적으로 처리되었습니다.<br>외관검사가 추가로 완료된 생산전표가 있는지 확인해 주세요!");
					jsonData.put("result", "ok");
					
				} else {
					jsonData.put("message", "총수량과 잔여수량이 같아야지만 포장 대기를 복원처리 하실 수 있습니다!");
					jsonData.put("result", "fail");
				}
				
			} else {
				jsonData.put("message", "선택하신 생산LotNo 포장대기 정보가 없습니다!<br>다시 확인해 주세요!");
				jsonData.put("result", "fail");
			}
		
		} catch (Exception e) {
			logger.info("생산LotNo 포장 대기 복원 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품포장 라벨발행
	@RequestMapping(value = "/po/goodsLabelPublish", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsLabelPublish(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품포장 라벨발행 = "+ workOrdOutputSubVo);
		
		String goodsCd = workOrdOutputSubVo.getGoodsCd();
		String workOrdNo = workOrdOutputSubVo.getWorkOrdNo();
		String ordLotNo = workOrdOutputSubVo.getOrdLotNo();
		//String packDate = workOrdOutputSubVo.getPackDate();
		String packDate = DateUtil.getToday("yyyymmdd"); //등록은 항상 서버시간 기준으로 등록
		String retPackDate = DateUtil.getToday("yyyy-mm-dd");
		int packCnt = workOrdOutputSubVo.getPackCnt();
		int appearAbrfCnt = workOrdOutputSubVo.getAppearAbrfCnt();
		int appearAbrsCnt = workOrdOutputSubVo.getAppearAbrsCnt();
		int appearDmsCnt = workOrdOutputSubVo.getAppearDmsCnt();
		//int appearOutputCnt = workOrderVo.getAppearOutputCnt();
		workOrdOutputSubService.updateWorkOrdAppearCnt(workOrdOutputSubVo);
		
		GoodsCodeAdmVo readGoodsCodeAdmVo = new GoodsCodeAdmVo();
		readGoodsCodeAdmVo.setGoodsCd(goodsCd);
		readGoodsCodeAdmVo = goodsCodeAdmService.read(readGoodsCodeAdmVo);
		
		if (packCnt != Integer.parseInt(readGoodsCodeAdmVo.getPackUnitNm())) {
			jsonData.put("message", "제품의 포장단위가 " + packCnt + " -> " + readGoodsCodeAdmVo.getPackUnitNm() + " 으로 변경되었습니다!<br>새로고침(F5) 후 다시 스캔해 주세요");
			jsonData.put("result", "fail");
			
			return jsonData;
		}
		
		GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
		goodsProductInfoAdmVo.setGoodsCd(goodsCd);
		List<GoodsProductInfoAdmVo> tmpGoodsProductInfoAdmVoList = goodsPackService.goodsPackTmpInfoList(goodsProductInfoAdmVo);
		
		//포장수량 < 미포장수량 인지 확인
		for (int i=0; i<tmpGoodsProductInfoAdmVoList.size(); i++) {
			if (appearAbrfCnt != 0) {
				if ("001".equals(tmpGoodsProductInfoAdmVoList.get(i).getOrdGubun())) {
					if (Integer.parseInt(readGoodsCodeAdmVo.getPackUnitNm()) < tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt()) {
						jsonData.put("message", "제품의 포장단위가 " + packCnt + " 이지만 해외1의 미포장수량은 " + tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt() + " 입니다!<br>미포장수량을 먼저 포장 후 스캔하여 포장해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}
			}
			if (appearAbrsCnt != 0) {
				if ("002".equals(tmpGoodsProductInfoAdmVoList.get(i).getOrdGubun())) {
					if (Integer.parseInt(readGoodsCodeAdmVo.getPackUnitNm()) < tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt()) {
						jsonData.put("message", "제품의 포장단위가 " + packCnt + " 이지만 해외2의 미포장수량은 " + tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt() + " 입니다!<br>미포장수량을 먼저 포장 후 스캔하여 포장해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}
			}
			if (appearDmsCnt != 0) {
				if ("003".equals(tmpGoodsProductInfoAdmVoList.get(i).getOrdGubun())) {
					if (Integer.parseInt(readGoodsCodeAdmVo.getPackUnitNm()) < tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt()) {
						jsonData.put("message", "제품의 포장단위가 " + packCnt + " 이지만 국내 미포장수량은 " + tmpGoodsProductInfoAdmVoList.get(i).getPackDtlCnt() + " 입니다!<br>미포장수량을 먼저 포장 후 스캔하여 포장해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}
			}	
		}
		
		
		////초,중,종물이 모두 등록되어있는지 확인
		////초,중물 검색
		//EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
		//firstEquipSizeCondStepVo.setWorkOrdNo("LD1A210126-001");
		//List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
        //
		//logger.info("1 : " + EquipSizeCondStepList.size());
		//if ( EquipSizeCondStepList.size() < 2 ) {
		//	jsonData.put("message", "초,중물 등록여부를 확인해주세요");
		//	jsonData.put("result", "fail");	
		//}
        //
		////종물 검색
		//EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
		//thirdEquipSizeCondStep.setWorkOrdNo("LD1A210126-003");
		//thirdEquipSizeCondStep.setStepCd("003");
		//thirdEquipSizeCondStep  = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);
		//
		//logger.info("2 : " + thirdEquipSizeCondStep );
		//logger.info("4 : " + thirdEquipSizeCondStep.equals(null));
		
		int tmpCnt;
		int midCnt;
		int unPackCnt;
		int remainCnt;
		int divideCnt;
		
		String boxNo;
		String ordGubun;
		boolean errFlag = false;
		
		WorkOrdOutputSubVo tmpWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
		//WorkOrderVo tmpWorkOrderVo = new WorkOrderVo();
		GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
		int boxSeq; 
		try {
			tmpWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			//tmpWorkOrderVo = workOrderService.read(workOrderVo);
			if (!"A".equals(tmpWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				jsonData.put("message", tmpWorkOrdOutputSubVo.getSubWorkStatusNm() + "상태의 작지입니다.<br/>작업지시를 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
				
			} else if (tmpWorkOrdOutputSubVo != null && !"Y".equals(tmpWorkOrdOutputSubVo.getPackYn())) {
				
				//에러라벨로 발행된 boxNo가 있는지 확인
				tmpGoodsProductInfoAdmVo.setBoxNo("errorlabel");
				GoodsProductInfoAdmVo errorPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
				if (errorPackInfo != null && errorPackInfo.getWorkOrdNo() != null) {
					jsonData.put("message", "라벨 발행 중 오류가 발생한 작지번호[" + errorPackInfo.getWorkOrdNo() + " - " + errorPackInfo.getOrdLotNo() + "] 입니다.<br/> 라벨발행 오류를 확인해 주세요.");
					jsonData.put("result", "errorlabel");
				} else {
					//해외1, 해외2, 국내 순으로 포장
					for(int i=1; i <= 3; i++) {
						if (i == 1) {
							tmpCnt = appearAbrfCnt;
						} else if (i == 2) {
							tmpCnt = appearAbrsCnt;
						} else {
							tmpCnt = appearDmsCnt;
						}
						
						tmpGoodsProductInfoAdmVo.setBoxNo(packDate); //포장일 기준 최대 시퀀스 조회
						boxSeq = goodsPackService.selectGoodsPackSeqCd(tmpGoodsProductInfoAdmVo);
						ordGubun = String.format("%03d", i);
						String tmpBoxNo = goodsCd.concat(ordGubun); // goodsCd + 오더구분(001,002,003) 제품오더별 미포장정보 관리
						tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo);
						//여러 작지가 합쳐서 미포장수량 < 포장수량일 경우를 생각해 미포장수량 SUM으로 계산함.
						GoodsProductInfoAdmVo tmpPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
						
						//미포장 정보 처리
						midCnt = tmpCnt;
						if (tmpPackInfo != null && tmpPackInfo.getPackDtlCnt() > 0) {
							//	1박스가되려면 더 필요한 수량	== 포장수량	-	잔여 미포장수량
							//	754					==	900		-	146
							unPackCnt = packCnt - tmpPackInfo.getPackDtlCnt();
							
							//포장수량 + 잔여수량 < 1박스 포장수량 이면(남아있는 수량과 포장하려는 수량을 합해도 한박스가 되지 않는다면)
							if (tmpCnt < unPackCnt) { //포장수 < 미포장수
								if (tmpCnt > 0) {
									tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo);
									tmpGoodsProductInfoAdmVo.setBoxSeq(tmpPackInfo.getBoxSeq() + 1);
									tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
									tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
									tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
									tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
									tmpGoodsProductInfoAdmVo.setPackDtlCnt(tmpCnt);
									tmpGoodsProductInfoAdmVo.setPackDate(packDate);
									tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
									goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo);
								}
								continue;
							} else { //포장수 >= 미포장
								
								//포장수량이 900에 잔여수량이 146이면 나머지 754를 채워서 한박스를 만듬
								tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo);
								tmpGoodsProductInfoAdmVo.setBoxSeq(tmpPackInfo.getBoxSeq() + 1);
								tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
								tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
								tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
								tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
								tmpGoodsProductInfoAdmVo.setPackDtlCnt(unPackCnt);
								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
								tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
								goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //미포장수를 채운다
								
								//제품 DTL 생성
								boxNo = packDate.concat("-").concat(String.format("%04d", boxSeq));
								tmpGoodsProductInfoAdmVo.setBoxNo(boxNo);
								tmpGoodsProductInfoAdmVo.setTmpBoxNo(tmpBoxNo);
								tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
								goodsPackService.createGoodsPackTmpToDtl(tmpGoodsProductInfoAdmVo); //포장수를 채운 미포장 상세정보를 포장 상세정보로 등록한다.
								
								tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
								tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
								tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
								tmpGoodsProductInfoAdmVo.setPackCnt(packCnt);
								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
								tmpGoodsProductInfoAdmVo.setGoodsStatus("001"); //포장상태	 //포장상태 Code B에서 001로 변경됨 But Mapper에서 B로 고정되어있어서 일단 단순히 001로 바꿔줬음
								goodsPackService.createGoodsLabelPublish(tmpGoodsProductInfoAdmVo); //포장정보를 생성한다.
								tmpGoodsProductInfoAdmVo.setHistId(Utils.getUserId());
								goodsPackService.insertGoodsProductHist(tmpGoodsProductInfoAdmVo);	//생산제품 상태변경 기록
								
								boxSeq++;

								goodsPackService.deleteGoodsLabelTmp(tmpGoodsProductInfoAdmVo); // 미포장정보는 삭제한다.
								if (tmpCnt == unPackCnt) { //포장수와 미포장수가 동일한 경우 
									continue;
								}
								midCnt = tmpCnt - unPackCnt;
							}
						}
						//미포장 처리 후 제품포장 처리
						divideCnt = midCnt / packCnt; //완전 포장박수 수량
						remainCnt = midCnt % packCnt; //새 잔여수량

						if (divideCnt > 0) { //포장단위별 포장정보 생성
							for (int j = 0; j < divideCnt; j++) {

								boxNo = packDate.concat("-").concat(String.format("%04d", boxSeq));

								tmpGoodsProductInfoAdmVo.setBoxNo(boxNo);
								tmpGoodsProductInfoAdmVo.setBoxSeq(1); //포장정보와 포장상세정보와 포장갯수는 동일하다
								tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
								tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
								tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
								tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
								tmpGoodsProductInfoAdmVo.setPackDtlCnt(packCnt);
								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
								tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
								goodsPackService.createGoodsLabelPublishDtl(tmpGoodsProductInfoAdmVo); //포장 상세정보를 등록한다

								tmpGoodsProductInfoAdmVo.setBoxNo(boxNo);
								tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
								tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
								tmpGoodsProductInfoAdmVo.setPackCnt(packCnt);
								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
								tmpGoodsProductInfoAdmVo.setGoodsStatus("001"); //포장상태 //포장상태 Code B에서 001로 변경됨
								tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
								goodsPackService.createGoodsLabelPublish(tmpGoodsProductInfoAdmVo);
								tmpGoodsProductInfoAdmVo.setHistId(Utils.getUserId());
								goodsPackService.insertGoodsProductHist(tmpGoodsProductInfoAdmVo); //생산제품 상태변경 기록
								boxSeq++;
							}
						}

						if (remainCnt > 0) { //잔여 제품수는 미포장 정보로 등록 
							tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo);
							tmpGoodsProductInfoAdmVo.setBoxSeq(1);
							tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
							tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
							tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
							tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
							tmpGoodsProductInfoAdmVo.setPackDtlCnt(remainCnt);
							tmpGoodsProductInfoAdmVo.setPackDate(packDate);
							tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
							goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //미포장수를 채운다				
						}
					}
					WorkOrdOutputSubVo updateSubWorkStatusCd = new WorkOrdOutputSubVo();
					updateSubWorkStatusCd.setWorkOrdNo(workOrdNo);
					updateSubWorkStatusCd.setOrdLotNo(ordLotNo);
					updateSubWorkStatusCd.setPackYn("Y");
					updateSubWorkStatusCd.setUpdId(Utils.getUserId());
					workOrdOutputSubService.updateWorkOrdPublish(updateSubWorkStatusCd);//작지 포장상태로 변경
					//goodsPackService.updateWorkOrdPublish(tmpGoodsProductInfoAdmVo);	//작지 포장상태로 변경
					
					tmpGoodsProductInfoAdmVo.setTmpBoxNo("lastlabel");
					goodsPackService.deleteGoodsLabelTmp(tmpGoodsProductInfoAdmVo);		//마지막 작지정보 삭제후 등록
					
					tmpGoodsProductInfoAdmVo.setBoxNo("lastlabel");
					tmpGoodsProductInfoAdmVo.setBoxSeq(1);
					tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
					tmpGoodsProductInfoAdmVo.setOrdGubun("004");
					tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
					tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
					tmpGoodsProductInfoAdmVo.setPackDtlCnt(packCnt);
					tmpGoodsProductInfoAdmVo.setPackDate(packDate);
					tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
					
					goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //오류 발생처리	
					workOrdOutputSubVo.setPackDate(retPackDate); //서버시간으로 변경되도록 처리
					jsonData.put("data", workOrdOutputSubVo);
					jsonData.put("result", "ok");
				} // for
			} else {
				jsonData.put("message", "이미 라벨 발행된 작지번호 입니다.<br/> 바코드를 확인해 주세요.");
				jsonData.put("result", "label");
			}
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 오류");
			e.printStackTrace();
			jsonData.put("message", "생산실적 라벨 발행중 오류가 발생했습니다.<br/> 바코드를 확인해 주세요.");
			jsonData.put("result", "fail");
			errFlag = true;
		} finally {
			if (errFlag) {
				tmpGoodsProductInfoAdmVo.setBoxNo("errorlabel");
				tmpGoodsProductInfoAdmVo.setBoxSeq(1);
				tmpGoodsProductInfoAdmVo.setOrdGubun("004");
				tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
				tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
				tmpGoodsProductInfoAdmVo.setPackDtlCnt(packCnt);
				tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
				goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //오류 발생처리			
			}
		}

		return jsonData;
	}
	
	//미포장 수량 포장 라벨발행
	@RequestMapping(value = "/po/goodsTempLabelPublish", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsTempLabelPublish(@RequestBody List<Map<String, Object>> goodsTempList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		GoodsCodeAdmVo readGoodsCodeAdmVo = new GoodsCodeAdmVo();
		boolean goodsTempListCheck = true;
		boolean goodsPackUnitNmCheck = true;
		String boxNo = null;
		String packDate = null;
		int temp = 0;
		boolean errFlag = false;
		
		//각 오더구분별로 포장해야하는 완제품 수량
		int ordGubun001 = Integer.parseInt(goodsTempList.get(0).get("ordGubun001").toString());
		int ordGubun002 = Integer.parseInt(goodsTempList.get(0).get("ordGubun002").toString());
		int ordGubun003 = Integer.parseInt(goodsTempList.get(0).get("ordGubun003").toString());
		int totalRemainCnt = 0;								//선택한 생산LotNo의 포장해야할 총 잔여수량
		int[] workOrdLotNoRemainCntList = new int[9999];	//각 생산LotNo별 포장 후 남는 잔여수량 -> 그다음 생산LotNo 포장계산에 사용
		
		try {
			
			//데이터 검사
			for (Map<String, Object> m : goodsTempList) {
				GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				//tmpGoodsProductInfoAdmVo.setBoxNo(m.get("goodsCd").toString() + m.get("ordGubun").toString());
				//tmpGoodsProductInfoAdmVo.setOrdLotNo(m.get("ordLotNo").toString());
				tmpGoodsProductInfoAdmVo.setGoodsCd(m.get("goodsCd").toString());
				tmpGoodsProductInfoAdmVo.setWorkOrdLotNo(m.get("workOrdLotNo").toString());
				tmpGoodsProductInfoAdmVo = goodsPackService.readGoodsUnPack(tmpGoodsProductInfoAdmVo);
				//선택한 미포장 정보들이 변경되었나 체크
				if (tmpGoodsProductInfoAdmVo == null || tmpGoodsProductInfoAdmVo.getPackDtlCnt() != Integer.parseInt(m.get("packDtlCnt").toString()) || tmpGoodsProductInfoAdmVo.getPackRemainCnt() != Integer.parseInt(m.get("packRemainCnt").toString())) {
					goodsTempListCheck = false;
					break;
				}
				
				totalRemainCnt += tmpGoodsProductInfoAdmVo.getPackRemainCnt();
				
				//해당제품 포장수량 변경 체크
				if (temp == 0) {
					readGoodsCodeAdmVo.setGoodsCd(m.get("goodsCd").toString());
					readGoodsCodeAdmVo = goodsCodeAdmService.read(readGoodsCodeAdmVo);
					temp++;
					if (!readGoodsCodeAdmVo.getPackUnitNm().equals(m.get("packUnitNm").toString())) {
						goodsPackUnitNmCheck = false;
						break;
					}
				}
			}
		
			//미포장 포장 실행
			if (goodsTempListCheck == true && goodsPackUnitNmCheck == true) {
				
				Settings singletonSettings = Settings.getInstance();
				
				//제품포장 기능 Lock O
				if (singletonSettings.lockGoodsPacking == true) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("001");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;
					
				//제품포장 기능 Lock X
				} else if (singletonSettings.lockGoodsPacking == false) {
					
					//싱글톤 제품포장이 사용중이 아니라면
					if (singletonSettings.useGoodsPacking == false) {
						//진짜 싱글톤 제품포장이 사용중이 아니라면
						if (singletonSettings.useGoodsPacking == false) {
							//제품 포장을 진행할 테니 포장시스템 사용중이라고 변경
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							singletonSettings.useGoodsPacking = true;
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							
							//ADM 먼저 생성(boxNo채번)
							packDate = DateUtil.getToday("yyyymmdd"); //등록은 항상 서버시간 기준으로 등록
							int readPackUnitNm = Integer.parseInt(readGoodsCodeAdmVo.getPackUnitNm());
							String ordGubun = null;
							//String ordGubun = goodsTempList.get(0).get("ordGubun").toString();
							logger.info("111111111111111 - " + goodsTempList.size());
							//System.out.println("totalRemainCnt : " + totalRemainCnt);
							//int createBoxCount = totalRemainCnt / readPackUnitNm;
							//int doNotCreateBoxRemain = totalRemainCnt % readPackUnitNm;
							//System.out.println("createBoxCount : " + createBoxCount);
							//System.out.println("doNotCreateBoxRemain : " + doNotCreateBoxRemain);
							
							//맨 뒤에서부터
							//for (int i=goodsTempList.size()-1; 0<=i; i--) {
							//	System.out.println(goodsTempList.get(i));
							//}
							
							String workOrdNo = null;
							String workOrdLotNo = null;
							String goodsCd = null;
							int workOrdLotNoPackCnt = 0;		//해당 생산LotNo로 포장 할 개수
							int workOrdLotNoPackRemainCnt = 0;	//해당 생산LotNo로 포장 후 잔여수량
							int rememberRemainUpdateIndex = 0;	//잔여수량 update 한 생산LotNo 위치
							
							
							//포장로직 시작
							for (int i=0; i<goodsTempList.size(); i++) {
								workOrdNo = goodsTempList.get(i).get("workOrdNo").toString();
								workOrdLotNo = goodsTempList.get(i).get("workOrdLotNo").toString();
								goodsCd = goodsTempList.get(i).get("goodsCd").toString();
			 					workOrdLotNoPackCnt = Integer.parseInt(goodsTempList.get(i).get("packRemainCnt").toString());
								
								//처음 가져온 것들 중 첫번째 포장인지 판단
								if (i==0) {
									//최초 포장생산LotNo가 잔여수량 >= 완제품수량 일시 ADM, DTL 생성
									if (workOrdLotNoPackCnt >= readPackUnitNm) {
										//일단 포장가능한 완제품 수량만큼 포장(채번)
										//System.out.println("workOrdLotNoPackCnt / readPackUnitNm : " + workOrdLotNoPackCnt / readPackUnitNm);
										//System.out.println("workOrdLotNoPackCnt % readPackUnitNm : " + workOrdLotNoPackCnt % readPackUnitNm);
										for (int j=0; j<workOrdLotNoPackCnt / readPackUnitNm; j++) {
											boxNo = createBoxNoSeq(packDate);			//boxNo 채번
											logger.info("박스번호11111111 : " + boxNo);
											//제품 오더구분 세팅판별
											if (ordGubun001 > 0) {
												ordGubun001--;
												ordGubun = "001";
											} else if (ordGubun002 > 0) {
												ordGubun002--;
												ordGubun = "002";
											} else	if (ordGubun003 > 0) {
												ordGubun003--;
												ordGubun = "003";
											} else {
												ordGubun = "ERROR!";
											}
											
											//Dtl 생성
											GoodsProductInfoAdmVo createBoxNoDtl = new GoodsProductInfoAdmVo();
											//boxNo = createBoxNoSeq(packDate);
											createBoxNoDtl.setBoxNo(boxNo);
											createBoxNoDtl.setBoxSeq(1);
											createBoxNoDtl.setGoodsCd(goodsCd);
											createBoxNoDtl.setOrdGubun(ordGubun);
											createBoxNoDtl.setWorkOrdNo(workOrdNo);
											createBoxNoDtl.setWorkOrdLotNo(workOrdLotNo);
											createBoxNoDtl.setPackDtlCnt(readPackUnitNm);
											createBoxNoDtl.setPackDate(packDate);
											createBoxNoDtl.setRegId(Utils.getUserId());
											goodsPackService.createGoodsLabelPublishDtl(createBoxNoDtl);
											
											//Adm 생성
											GoodsProductInfoAdmVo createBoxNoAdm = new GoodsProductInfoAdmVo();
											createBoxNoAdm.setBoxNo(boxNo);
											createBoxNoAdm.setGoodsCd(goodsCd);
											createBoxNoAdm.setOrdGubun(ordGubun);
											createBoxNoAdm.setPackCnt(readPackUnitNm);
											createBoxNoAdm.setPackDate(packDate);
											createBoxNoAdm.setRegId(Utils.getUserId());
											goodsPackService.createGoodsLabelPublish(createBoxNoAdm);	//ADM 생성
											createBoxNoAdm.setHistId(Utils.getUserId());
											goodsPackService.insertGoodsProductHist(createBoxNoAdm);	//제품 기록
											
											//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
											StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
											stockPaymentAdmVoMinus= StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdLotNo, readPackUnitNm, factoryCode);
											stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
											StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
											stockPaymentAdmVoPlus= StockPaymentAdmController.goodsPackPlus(goodsCd, boxNo, readPackUnitNm, factoryCode);
											stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);		//새 위치 재고 +
										}
										
										//이후 잔여수량 - 포장수량을 해당 생산LotNo의 마지막 전표일자에 Update
										//int workOrdLotNoUsePackCnt = (workOrdLotNoPackCnt / readPackUnitNm) * readPackUnitNm;
										workOrdLotNoPackRemainCnt += workOrdLotNoPackCnt % readPackUnitNm;
										GoodsProductInfoAdmVo updateWorkOrdLotNoRemainCnt = new GoodsProductInfoAdmVo();
										updateWorkOrdLotNoRemainCnt.setWorkOrdLotNo(workOrdLotNo);
										updateWorkOrdLotNoRemainCnt.setPackRemainCnt(workOrdLotNoPackRemainCnt);
										
										//해당 생산LotNo 잔여수량 0으로 모두 update 한 후
										goodsPackService.updatePackRemainCntZero(updateWorkOrdLotNoRemainCnt);
										//해당 생산LotNo의 제일 마지막 전표번호를 포장후 잔여수량으로 update 해줌 -> 마지막 생산LotNo면 그대로 종료하면 되고 다음 생산LotNo가 있으면 계산해주면 됨! 나머지 다합쳐서 완제품이 안될 수 도 있기에 일단 여기서 한번 끊어줬음
										goodsPackService.updatePackRemainCnt(updateWorkOrdLotNoRemainCnt);
										
										//생산LotNo 별 잔여수량 
										rememberRemainUpdateIndex = 0;
										workOrdLotNoRemainCntList[i] = workOrdLotNoPackRemainCnt;
									
									//최초 포장하는데에도 수량이 부족해서 포장이 안되네 가져온 수량을 잔여수량에 넣어줌
									} else {
										//생산LotNo 별 잔여수량 
										rememberRemainUpdateIndex = 0;
										workOrdLotNoRemainCntList[i] = workOrdLotNoPackCnt;
										workOrdLotNoPackRemainCnt += workOrdLotNoPackCnt;
									}
								
								//생산LotNo 2번째부터 전에 남아있는 잔여수량까지 생각해서 로직세우기
								} else {
									
									//직전 잔여수량 들의 합계 + 다음 잔여수량 >= 완제품포장수량
									if (workOrdLotNoPackRemainCnt + workOrdLotNoPackCnt >= readPackUnitNm) {
										int dtlBoxSeq = 1;
										//제품 오더구분 세팅판별
										if (ordGubun001 > 0) {
											ordGubun001--;
											ordGubun = "001";
										} else if (ordGubun002 > 0) {
											ordGubun002--;
											ordGubun = "002";
										} else	if (ordGubun003 > 0) {
											ordGubun003--;
											ordGubun = "003";
										} else {
											ordGubun = "ERROR";
										}
										
										//잔여수량이 여러개일 수도 있으니 동적으로 dtl 만들어줘야 함
										boxNo = createBoxNoSeq(packDate);
										for (int kk = rememberRemainUpdateIndex; kk<i; kk++) {
											logger.info("박스번호 : " + boxNo);
											//Dtl 생성
											GoodsProductInfoAdmVo createBoxNoDtl = new GoodsProductInfoAdmVo();
											//boxNo = createBoxNoSeq(packDate);
											createBoxNoDtl.setBoxNo(boxNo);
											createBoxNoDtl.setBoxSeq(dtlBoxSeq);
											createBoxNoDtl.setGoodsCd(goodsTempList.get(kk).get("goodsCd").toString());
											createBoxNoDtl.setOrdGubun(ordGubun);
											createBoxNoDtl.setWorkOrdNo(goodsTempList.get(kk).get("workOrdNo").toString());
											createBoxNoDtl.setWorkOrdLotNo(goodsTempList.get(kk).get("workOrdLotNo").toString());
											createBoxNoDtl.setPackDtlCnt(workOrdLotNoRemainCntList[kk]);	//해당 생산LotNo의 포장 후 남은 잔여수량
											createBoxNoDtl.setPackDate(packDate);
											createBoxNoDtl.setRegId(Utils.getUserId());
											//잔여수량이 0이 아닐 경우에만 dtl 생성
											if (workOrdLotNoRemainCntList[kk] != 0) {
												goodsPackService.createGoodsLabelPublishDtl(createBoxNoDtl);
												
												//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
												StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
												stockPaymentAdmVoMinus= StockPaymentAdmController.goodsUnPackMinus(goodsCd, goodsTempList.get(kk).get("workOrdLotNo").toString(), workOrdLotNoRemainCntList[kk], factoryCode);
												stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
												StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
												stockPaymentAdmVoPlus= StockPaymentAdmController.goodsPackPlus(goodsCd, boxNo, workOrdLotNoRemainCntList[kk], factoryCode);
												stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);		//새 위치 재고 +
											}
											GoodsProductInfoAdmVo updateWorkOrdLotNoRemainCnt = new GoodsProductInfoAdmVo();
											updateWorkOrdLotNoRemainCnt.setWorkOrdLotNo(goodsTempList.get(kk).get("workOrdLotNo").toString());
											//DTL 생성 후 해당잔여수량도 0으로 UPDATE 다시 해줘야함
											goodsPackService.updatePackRemainCntZero(updateWorkOrdLotNoRemainCnt);
											dtlBoxSeq++;
											
										}
										//직전 잔여수량들이 처리되었으니 완포장이 되기위한 나머지 잔여수량을 현재 걸려잇는 생산LotNo에서 빼주고 나머지 계산
										int tempCnt = readPackUnitNm - workOrdLotNoPackRemainCnt;
										//DTL 생성
										GoodsProductInfoAdmVo createBoxNoDtl = new GoodsProductInfoAdmVo();
										//boxNo = createBoxNoSeq(packDate);
										createBoxNoDtl.setBoxNo(boxNo);
										createBoxNoDtl.setBoxSeq(dtlBoxSeq);
										createBoxNoDtl.setGoodsCd(goodsCd);
										createBoxNoDtl.setOrdGubun(ordGubun);
										createBoxNoDtl.setWorkOrdNo(workOrdNo);
										createBoxNoDtl.setWorkOrdLotNo(workOrdLotNo);
										createBoxNoDtl.setPackDtlCnt(tempCnt);
										createBoxNoDtl.setPackDate(packDate);
										createBoxNoDtl.setRegId(Utils.getUserId());
										goodsPackService.createGoodsLabelPublishDtl(createBoxNoDtl);
										
										//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
										StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
										stockPaymentAdmVoMinus= StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdLotNo, tempCnt, factoryCode);
										stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
										StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
										stockPaymentAdmVoPlus= StockPaymentAdmController.goodsPackPlus(goodsCd, boxNo, tempCnt, factoryCode);
										stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);		//새 위치 재고 +
										
										//ADM 생성
										GoodsProductInfoAdmVo createBoxNoAdm = new GoodsProductInfoAdmVo();
										createBoxNoAdm.setBoxNo(boxNo);
										createBoxNoAdm.setGoodsCd(goodsCd);
										createBoxNoAdm.setOrdGubun(ordGubun);
										createBoxNoAdm.setPackCnt(readPackUnitNm);
										createBoxNoAdm.setPackDate(packDate);
										createBoxNoAdm.setRegId(Utils.getUserId());
										goodsPackService.createGoodsLabelPublish(createBoxNoAdm);	//ADM 생성
										createBoxNoAdm.setHistId(Utils.getUserId());
										goodsPackService.insertGoodsProductHist(createBoxNoAdm);	//제품 기록
										
										//★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆
										//포장 잔여수량 - 직전 잔여수량 + 완제품이 되기위한 부족한 잔여수량
										workOrdLotNoPackCnt -= tempCnt;
										
										//부족한 부분은 채워줬으니 이제 나머지로 다시 adm,dtl 생성
										
										//일단 포장가능한 완제품 수량만큼 포장(채번)
										//System.out.println("workOrdLotNoPackCnt / readPackUnitNm : ☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★" + workOrdLotNoPackCnt / readPackUnitNm);
										//System.out.println("workOrdLotNoPackCnt % readPackUnitNm : ☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★" + workOrdLotNoPackCnt % readPackUnitNm);
										
										for (int j=0; j<workOrdLotNoPackCnt / readPackUnitNm; j++) {
											boxNo = createBoxNoSeq(packDate);			//boxNo 채번
											logger.info("박스번호33333333333333333 : " + boxNo);
											//Adm 생성
											createBoxNoAdm.setBoxNo(boxNo);
											createBoxNoAdm.setGoodsCd(goodsCd);
											//제품 오더구분 세팅판별
											if (ordGubun001 > 0) {
												ordGubun001--;
												ordGubun = "001";
											} else if (ordGubun002 > 0) {
												ordGubun002--;
												ordGubun = "002";
											} else	if (ordGubun003 > 0) {
												ordGubun003--;
												ordGubun = "003";
											} else {
												ordGubun = "ERROR!";
											}
											createBoxNoAdm.setOrdGubun(ordGubun);
											createBoxNoAdm.setPackCnt(readPackUnitNm);
											createBoxNoAdm.setPackDate(packDate);
											createBoxNoAdm.setRegId(Utils.getUserId());
											goodsPackService.createGoodsLabelPublish(createBoxNoAdm);	//ADM 생성
											createBoxNoAdm.setHistId(Utils.getUserId());
											goodsPackService.insertGoodsProductHist(createBoxNoAdm);	//제품 기록
											
											//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
											stockPaymentAdmVoMinus= StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdLotNo, readPackUnitNm, factoryCode);
											stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
											
											stockPaymentAdmVoPlus= StockPaymentAdmController.goodsPackPlus(goodsCd, boxNo, readPackUnitNm, factoryCode);
											stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);		//새 위치 재고 +
											
											//Dtl 생성
											//boxNo = createBoxNoSeq(packDate);
											createBoxNoDtl.setBoxNo(boxNo);
											createBoxNoDtl.setBoxSeq(1);
											createBoxNoDtl.setGoodsCd(goodsCd);
											createBoxNoDtl.setOrdGubun(ordGubun);
											createBoxNoDtl.setWorkOrdNo(workOrdNo);
											createBoxNoDtl.setWorkOrdLotNo(workOrdLotNo);
											createBoxNoDtl.setPackDtlCnt(readPackUnitNm);
											createBoxNoDtl.setPackDate(packDate);
											createBoxNoDtl.setRegId(Utils.getUserId());
											goodsPackService.createGoodsLabelPublishDtl(createBoxNoDtl);
										}
										
										//이후 잔여수량 - 포장수량을 해당 생산LotNo의 마지막 전표일자에 Update
										//int workOrdLotNoUsePackCnt = (workOrdLotNoPackCnt / readPackUnitNm) * readPackUnitNm;
										workOrdLotNoPackRemainCnt = workOrdLotNoPackCnt % readPackUnitNm;
										GoodsProductInfoAdmVo updateWorkOrdLotNoRemainCnt = new GoodsProductInfoAdmVo();
										updateWorkOrdLotNoRemainCnt.setWorkOrdLotNo(workOrdLotNo);
										updateWorkOrdLotNoRemainCnt.setPackRemainCnt(workOrdLotNoPackRemainCnt);
										
										//해당 생산LotNo 잔여수량 0으로 모두 update 한 후
										goodsPackService.updatePackRemainCntZero(updateWorkOrdLotNoRemainCnt);

										//해당 생산LotNo의 제일 마지막 전표번호를 포장후 잔여수량으로 update 해줌 -> 마지막 생산LotNo면 그대로 종료하면 되고 다음 생산LotNo가 있으면 계산해주면 됨! 나머지 다합쳐서 완제품이 안될 수 도 있기에 일단 여기서 한번 끊어줬음
										goodsPackService.updatePackRemainCnt(updateWorkOrdLotNoRemainCnt);
										
										//생산LotNo 별 잔여수량 
										rememberRemainUpdateIndex = i;
										workOrdLotNoRemainCntList[i] = workOrdLotNoPackRemainCnt;
									
									//최초 포장하는데에도 수량이 부족해서 포장이 안되네 가져온 수량을 잔여수량에 넣어줌
									} else {
										//생산LotNo 별 잔여수량 
										//rememberRemainUpdateIndex = i;
										workOrdLotNoRemainCntList[i] = workOrdLotNoPackCnt;
										workOrdLotNoPackRemainCnt += workOrdLotNoPackCnt;
									}
								}
							}
							//포장로직 끝
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							singletonSettings.useGoodsPacking = false;
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							
							jsonData.put("goodsPackStatusCode", "001");						
							jsonData.put("message", "선택하신 미포장수량 포장되었습니다.");
							jsonData.put("result", "ok");
							
						} else {
							jsonData.put("goodsPackStatusCode", "002");
							jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
							jsonData.put("result", "using");
						}
					} else {
						jsonData.put("goodsPackStatusCode", "002");
						jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
						jsonData.put("result", "using");
					}
					
				} else {
					jsonData.put("message", "제품포장 잠금기능 상태값 오류입니다.<br>관리자에게 문의해주세요!");
					jsonData.put("result", "lock");
					return jsonData;
				}
				
			} else {
				if (!goodsTempListCheck) {
					jsonData.put("goodsPackStatusCode", "003");
					jsonData.put("message", "선택한 미포장수량 정보가 변경되었습니다!<br>확인 후 다시 선택해 주세요!");
					jsonData.put("result", "fail");
				} else if (!goodsPackUnitNmCheck) {
					jsonData.put("goodsPackStatusCode", "003");
					jsonData.put("message", "선택한 제품의 포장수량이 변경되었습니다!<br>새로고침(F5) 후 다시 시도해 주세요!");
					jsonData.put("result", "fail");
				}
			}
			
		} catch (Exception e) {
			logger.info("미포장 포장라벨 발행 오류");
			e.printStackTrace();
			jsonData.put("goodsPackStatusCode", "004");
			jsonData.put("message", "시스템 오류가 발생하였습니다 .");
			jsonData.put("result", "error");
			errFlag = true;
		}
		
		return jsonData;
	}
	
	//트레이 포장
	@RequestMapping(value = "/po/goodsPackByTray_nF2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsPackByTray_nF2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
//		GoodsCodeAdmVo readGoodsCodeAdmVo = new GoodsCodeAdmVo();
//		boolean goodsTempListCheck = true;
//		boolean goodsPackUnitNmCheck = true;
//		String boxNo = null;
//		String packDate = null;
//		int temp = 0;
//		boolean errFlag = false;
		
		//각 오더구분별로 포장해야하는 완제품 수량
//		int ordGubun001 = Integer.parseInt(goodsTempList.get(0).get("ordGubun001").toString());
//		int ordGubun002 = Integer.parseInt(goodsTempList.get(0).get("ordGubun002").toString());
//		int ordGubun003 = Integer.parseInt(goodsTempList.get(0).get("ordGubun003").toString());
//		int totalRemainCnt = 0;								//선택한 생산LotNo의 포장해야할 총 잔여수량
//		int[] workOrdLotNoRemainCntList = new int[9999];	//각 생산LotNo별 포장 후 남는 잔여수량 -> 그다음 생산LotNo 포장계산에 사용
		
		
		
		try {
			
			String labelLotNo = goodsProductInfoAdmVo.getLabelLotNo();
			String labelLotNoSeq1 = labelLotNo + "-1";
			String labelLotNoSeq2 = labelLotNo + "-2";
			String workOrdNo = goodsProductInfoAdmVo.getWorkOrdNo();
			String ordGubun = goodsProductInfoAdmVo.getOrdGubun();
			//packUnitNm 가 홀수이면??
			int packCnt = Integer.parseInt(goodsProductInfoAdmVo.getPackUnitNm()) / 2;
			
			//labelLotNoSeq1, labelLotNoSeq2 가 포장 되었는지 안되었는지 확인 후
			GoodsProductInfoAdmVo readLabelLotNoSeq1 = new GoodsProductInfoAdmVo();
			GoodsProductInfoAdmVo readLabelLotNoSeq2 = new GoodsProductInfoAdmVo();
			readLabelLotNoSeq1.setBoxNo(labelLotNoSeq1);
			readLabelLotNoSeq2.setBoxNo(labelLotNoSeq2);
			readLabelLotNoSeq1 = goodsPackService.readGoodsProductInfo(readLabelLotNoSeq1);
			readLabelLotNoSeq2 = goodsPackService.readGoodsProductInfo(readLabelLotNoSeq2);
			if (readLabelLotNoSeq1 != null) {
				jsonData.put("message", "이미 포장된 LabelNo입니다.");
				jsonData.put("result", "fail");
				return jsonData;
			}
			
			WorkOrderVo readWorkOrderVo = new WorkOrderVo();
			readWorkOrderVo.setWorkOrdNo(workOrdNo);
			readWorkOrderVo = workOrderService.read(readWorkOrderVo);
			String goodsCd = readWorkOrderVo.getGoodsCd();
			
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			productionPerfTrayVo.setWorkOrdNo(workOrdNo);
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			
			String matrlLotNo = productionPerfTrayList.get(0).getMatrlLotNo();
			String filmLotNo = productionPerfTrayList.get(0).getFilmLotNo();
			
//			//싱글톤 포장 실행
//			Settings singletonSettings = Settings.getInstance();
//			//제품포장 기능 Lock O
//			if (singletonSettings.lockGoodsPacking == true) {
//				SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
//				systemCommonCode.setBaseGroupCd("096"); //시스템 기능 잠금
//				systemCommonCode.setBaseCd("001"); //제품 포장Lock
//				systemCommonCode = systemCommonCodeService.read(systemCommonCode);
//				jsonData.put("message", systemCommonCode.getEtc1());
//				jsonData.put("result", "lock");
//				return jsonData;
//
//			//제품포장 기능 Lock X
//			} else if (singletonSettings.lockGoodsPacking == false) {
//				//싱글톤 제품포장이 사용중이 아니라면
//				if (singletonSettings.useGoodsPacking == false) {
//					//제품 포장을 진행할 테니 포장시스템 사용중이라고 변경
//					singletonSettings.useGoodsPacking = true;
					
					//ADM 먼저 생성(boxNo채번)
					String packDate = DateUtil.getToday("yyyymmdd"); //등록은 항상 서버시간 기준으로 등록

					//Dtl 생성
					GoodsProductInfoAdmVo insLabelLotNoSeq1Dtl = new GoodsProductInfoAdmVo();
					//boxNo = createBoxNoSeq(packDate);
					insLabelLotNoSeq1Dtl.setBoxNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setBoxSeq(1);
					insLabelLotNoSeq1Dtl.setGoodsCd(goodsCd);
					insLabelLotNoSeq1Dtl.setOrdGubun(ordGubun);
					insLabelLotNoSeq1Dtl.setWorkOrdNo(workOrdNo);
					insLabelLotNoSeq1Dtl.setWorkOrdLotNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setOrdLotNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setPackDtlCnt(packCnt);
					insLabelLotNoSeq1Dtl.setPackDate(packDate);
					insLabelLotNoSeq1Dtl.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublishDtl(insLabelLotNoSeq1Dtl);

					GoodsProductInfoAdmVo insLabelLotNoSeq2Dtl = new GoodsProductInfoAdmVo();
					//boxNo = createBoxNoSeq(packDate);
					insLabelLotNoSeq2Dtl.setBoxNo(labelLotNoSeq2);
					insLabelLotNoSeq2Dtl.setBoxSeq(1);
					insLabelLotNoSeq2Dtl.setGoodsCd(goodsCd);
					insLabelLotNoSeq2Dtl.setOrdGubun(ordGubun);
					insLabelLotNoSeq2Dtl.setWorkOrdNo(workOrdNo);
					insLabelLotNoSeq2Dtl.setWorkOrdLotNo(labelLotNoSeq2);
					insLabelLotNoSeq2Dtl.setOrdLotNo(labelLotNoSeq2);
					insLabelLotNoSeq2Dtl.setPackDtlCnt(packCnt);
					insLabelLotNoSeq2Dtl.setPackDate(packDate);
					insLabelLotNoSeq2Dtl.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublishDtl(insLabelLotNoSeq2Dtl);
					
					//Adm 생성
					GoodsProductInfoAdmVo insLabelLotNoSeq1Adm = new GoodsProductInfoAdmVo();
					insLabelLotNoSeq1Adm.setBoxNo(labelLotNoSeq1);
					insLabelLotNoSeq1Adm.setGoodsCd(goodsCd);
					insLabelLotNoSeq1Adm.setOrdGubun(ordGubun);
					insLabelLotNoSeq1Adm.setPackCnt(packCnt);
					insLabelLotNoSeq1Adm.setPackDate(packDate);
					insLabelLotNoSeq1Adm.setMatrlLotNo(matrlLotNo);
					insLabelLotNoSeq1Adm.setGoodsStatus("001");
					insLabelLotNoSeq1Adm.setFilmLotNo(filmLotNo);
					insLabelLotNoSeq1Adm.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublish(insLabelLotNoSeq1Adm); //ADM 생성
					

					//Adm 생성
					GoodsProductInfoAdmVo insLabelLotNoSeq2Adm = new GoodsProductInfoAdmVo();
					insLabelLotNoSeq2Adm.setBoxNo(labelLotNoSeq2);
					insLabelLotNoSeq2Adm.setGoodsCd(goodsCd);
					insLabelLotNoSeq2Adm.setOrdGubun(ordGubun);
					insLabelLotNoSeq2Adm.setPackCnt(packCnt);
					insLabelLotNoSeq2Adm.setPackDate(packDate);
					insLabelLotNoSeq2Adm.setMatrlLotNo(matrlLotNo);
					insLabelLotNoSeq2Adm.setGoodsStatus("001");
					insLabelLotNoSeq2Adm.setFilmLotNo(filmLotNo);
					insLabelLotNoSeq2Adm.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublish(insLabelLotNoSeq2Adm); //ADM 생성
					
//					//포장로직 끝
//					singletonSettings.useGoodsPacking = true;

					//제품 이력 등록
					insLabelLotNoSeq1Adm.setHistId(Utils.getUserId());
					goodsPackService.insertGoodsProductHist(insLabelLotNoSeq1Adm);
					insLabelLotNoSeq2Adm.setHistId(Utils.getUserId());
					goodsPackService.insertGoodsProductHist(insLabelLotNoSeq2Adm);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
					stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
					
					StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					stockPaymentAdmVoPlus = StockPaymentAdmController.goodsPackPlus(goodsCd, labelLotNoSeq1, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus); //새 위치 재고 +
					stockPaymentAdmVoPlus = StockPaymentAdmController.goodsPackPlus(goodsCd, labelLotNoSeq2, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus); //새 위치 재고 +
					
					jsonData.put("goodsPackStatusCode", "001");
					jsonData.put("message", "포장되었습니다.");
					jsonData.put("result", "ok");
//				} else {
//					jsonData.put("goodsPackStatusCode", "002");
//					jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
//					jsonData.put("result", "using");
//				}
//
//			} else {
//				jsonData.put("message", "제품포장 잠금기능 상태값 오류입니다.<br>관리자에게 문의해주세요!");
//				jsonData.put("result", "lock");
//				return jsonData;
//			}
			
		} catch (Exception e) {
			logger.info("미포장 포장라벨 발행 오류");
			e.printStackTrace();
			jsonData.put("goodsPackStatusCode", "004");
			jsonData.put("message", "시스템 오류가 발생하였습니다 .");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//트레이 포장(1공장)
	@RequestMapping(value = "/po/goodsPackByTray_nF2_Factory1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsPackByTray_nF2_Factory1(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();		
		try {
			
			String labelLotNo = goodsProductInfoAdmVo.getLabelLotNo();
			String labelLotNoSeq1 = labelLotNo;
		
			String workOrdNo = goodsProductInfoAdmVo.getWorkOrdNo();
			String ordGubun = goodsProductInfoAdmVo.getOrdGubun();
			//packUnitNm 가 홀수이면??
			int packCnt = Integer.parseInt(goodsProductInfoAdmVo.getPackUnitNm());
			
			//labelLotNoSeq1, labelLotNoSeq2 가 포장 되었는지 안되었는지 확인 후
			GoodsProductInfoAdmVo readLabelLotNoSeq1 = new GoodsProductInfoAdmVo();
			
			readLabelLotNoSeq1.setBoxNo(labelLotNoSeq1);
			
			readLabelLotNoSeq1 = goodsPackService.readGoodsProductInfo(readLabelLotNoSeq1);
			
			if (readLabelLotNoSeq1 != null) {
				jsonData.put("message", "이미 포장된 LabelNo입니다.");
				jsonData.put("result", "fail");
				return jsonData;
			}
			
			WorkOrderVo readWorkOrderVo = new WorkOrderVo();
			readWorkOrderVo.setWorkOrdNo(workOrdNo);
			readWorkOrderVo = workOrderService.read(readWorkOrderVo);
			String goodsCd = readWorkOrderVo.getGoodsCd();
			
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			productionPerfTrayVo.setWorkOrdNo(workOrdNo);
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			
			String matrlLotNo = productionPerfTrayList.get(0).getMatrlLotNo();
			String filmLotNo = productionPerfTrayList.get(0).getFilmLotNo();
			

					
					//ADM 먼저 생성(boxNo채번)
					String packDate = DateUtil.getToday("yyyymmdd"); //등록은 항상 서버시간 기준으로 등록

					//Dtl 생성
					GoodsProductInfoAdmVo insLabelLotNoSeq1Dtl = new GoodsProductInfoAdmVo();
					//boxNo = createBoxNoSeq(packDate);
					insLabelLotNoSeq1Dtl.setBoxNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setBoxSeq(1);
					insLabelLotNoSeq1Dtl.setGoodsCd(goodsCd);
					insLabelLotNoSeq1Dtl.setOrdGubun(ordGubun);
					insLabelLotNoSeq1Dtl.setWorkOrdNo(workOrdNo);
					insLabelLotNoSeq1Dtl.setWorkOrdLotNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setOrdLotNo(labelLotNoSeq1);
					insLabelLotNoSeq1Dtl.setPackDtlCnt(packCnt);
					insLabelLotNoSeq1Dtl.setPackDate(packDate);
					insLabelLotNoSeq1Dtl.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublishDtl(insLabelLotNoSeq1Dtl);


					
					//Adm 생성
					GoodsProductInfoAdmVo insLabelLotNoSeq1Adm = new GoodsProductInfoAdmVo();
					insLabelLotNoSeq1Adm.setBoxNo(labelLotNoSeq1);
					insLabelLotNoSeq1Adm.setGoodsCd(goodsCd);
					insLabelLotNoSeq1Adm.setOrdGubun(ordGubun);
					insLabelLotNoSeq1Adm.setPackCnt(packCnt);
					insLabelLotNoSeq1Adm.setPackDate(packDate);
					
					if(factoryCode.equals("003" )) {
						insLabelLotNoSeq1Adm.setGoodsStatus("006");	//(솔) 입고
					} else {
						insLabelLotNoSeq1Adm.setGoodsStatus("001");	//(머) 포장
					}
					
					insLabelLotNoSeq1Adm.setPackDate(packDate);
					insLabelLotNoSeq1Adm.setMatrlLotNo(matrlLotNo);
					insLabelLotNoSeq1Adm.setFilmLotNo(filmLotNo);
					insLabelLotNoSeq1Adm.setRegId(Utils.getUserId());
					goodsPackService.createGoodsLabelPublish(insLabelLotNoSeq1Adm); //ADM 생성
					


					
//					//포장로직 끝
//					singletonSettings.useGoodsPacking = true;

					//제품 이력 등록
					insLabelLotNoSeq1Adm.setHistId(Utils.getUserId());
					goodsPackService.insertGoodsProductHist(insLabelLotNoSeq1Adm);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -

					
					StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					stockPaymentAdmVoPlus = StockPaymentAdmController.goodsPackPlus(goodsCd, labelLotNoSeq1, packCnt, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus); //새 위치 재고 +
					
					
					if(factoryCode.equals("003" )) {
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, labelLotNoSeq1, "002", "O", "007", packCnt, factoryCode);
						stockPaymentAdmService.stockPaymentPlus(goodsPackMinus); //기존 재고 -
						
						StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
						goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, labelLotNoSeq1, "002", "I", "008", packCnt, factoryCode);
						stockPaymentAdmService.stockPaymentPlus(goodsLocationIn); //새 위치 재고 +
					}
					
					jsonData.put("goodsPackStatusCode", "001");
					
					if(factoryCode.equals("001") || factoryCode.equals("002")) {
						jsonData.put("message", "포장되었습니다.");
					} else {
						jsonData.put("message", "입고되었습니다.");
					}
					
					jsonData.put("result", "ok");
//				} else {
//					jsonData.put("goodsPackStatusCode", "002");
//					jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
//					jsonData.put("result", "using");
//				}
//
//			} else {
//				jsonData.put("message", "제품포장 잠금기능 상태값 오류입니다.<br>관리자에게 문의해주세요!");
//				jsonData.put("result", "lock");
//				return jsonData;
//			}
			
		} catch (Exception e) {
			logger.info("미포장 포장라벨 발행 오류");
			e.printStackTrace();
			jsonData.put("goodsPackStatusCode", "004");
			jsonData.put("message", "시스템 오류가 발생하였습니다 .");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//시스템 최초 등록시간대로 BoxNo 채번 -> ex) 10.1 23:59:57에 최초 boxSeq 채번하여 10. 2. 00:01:30 까지 진행되어도 10.1일자 boxNo로 채번됨.
	public String createBoxNoSeq(String packDate) {
		String boxNo = null;
    	try {
    		GoodsProductInfoAdmVo createBoxNoSeq = new GoodsProductInfoAdmVo();
			createBoxNoSeq.setBoxNo(packDate); //포장일 기준 최대 시퀀스 조회
			int boxSeq = goodsPackService.selectGoodsPackSeqCd(createBoxNoSeq);
			boxNo = packDate.concat("-").concat(String.format("%04d", boxSeq));
			logger.info("채번된 BoxNo - " + boxNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	return boxNo;
	}
	
	//제품포장 라벨발행 취소
	//@RequestMapping(value = "/po/goodsLabelUnpublish", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> goodsLabelUnpublish(WorkOrderVo workOrderVo) throws Exception {
	//	
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("제품포장 라벨발행 취소 = " + workOrderVo);
	//	
	//	String lastWorkOrdNo = null;
	//	String lastOrdLotNo = null;
	//	String goodsCd = workOrderVo.getGoodsCd();
	//	String packDate = workOrderVo.getPackDate();
	//	int packCnt = workOrderVo.getPackCnt();
	//	String ordGubun;
	//	boolean errFlag = false;
	//	
	//	//WorkOrderVo tmpWorkOrderVo = new WorkOrderVo();
	//	GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
	//	
	//	try {
	//		//제품별로 가장 마지막으로 포장된 작업지시 조회
	//		tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
	//		tmpGoodsProductInfoAdmVo = goodsPackService.selectGoodsPackLastWorkOrdNo(tmpGoodsProductInfoAdmVo);
	//		
	//		if (tmpGoodsProductInfoAdmVo != null && tmpGoodsProductInfoAdmVo.getWorkOrdNo().length() > 5 && tmpGoodsProductInfoAdmVo.getOrdLotNo().length() > 5) {
	//			WorkOrdOutputSubVo readWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
	//			readWorkOrdOutputSubVo.setOrdLotNo(tmpGoodsProductInfoAdmVo.getOrdLotNo());
	//			readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(readWorkOrdOutputSubVo);
	//			//workOrderVo.setWorkOrdNo(lastWorkOrdNo);
	//			//workOrderVo = workOrderService.read(workOrderVo);
	//			
	//			//검색된 작업지시가 있으면
	//			if (readWorkOrdOutputSubVo != null && readWorkOrdOutputSubVo.getWorkOrdNo() != null && readWorkOrdOutputSubVo.getOrdLotNo() != null) {
	//				lastWorkOrdNo = readWorkOrdOutputSubVo.getWorkOrdNo();
	//				lastOrdLotNo = readWorkOrdOutputSubVo.getOrdLotNo();
	//				goodsCd = readWorkOrdOutputSubVo.getGoodsCd();
	//				packCnt = Integer.parseInt(readWorkOrdOutputSubVo.getPackUnitNm());
	//				tmpGoodsProductInfoAdmVo.setBoxNo("errorlabel");
	//				
	//				//에러라벨이 있는지 확인
	//				GoodsProductInfoAdmVo errorPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
	//				if (errorPackInfo != null && errorPackInfo.getWorkOrdNo() != null) {
	//					jsonData.put("message", "라벨 발행 중 오류가 발생한 작지번호[" + errorPackInfo.getWorkOrdNo() + " - " + errorPackInfo.getOrdLotNo() + "] 입니다.<br/> 라벨발행 오류를 확인해 주세요.");
	//					jsonData.put("result", "errorlabel");
	//				} else { // for
	//					
	//					//복원대상 제품 출하 되었는지 확인
	//					GoodsProductInfoAdmVo checkGoodsStatus  = new GoodsProductInfoAdmVo();
	//					checkGoodsStatus.setWorkOrdNo(lastWorkOrdNo);
	//					checkGoodsStatus.setOrdLotNo(lastOrdLotNo);
	//					List<GoodsProductInfoAdmVo> checkGoodsStatusList = goodsPackService.checkGoodsStatus(checkGoodsStatus);
	//					String checkGoodsStatusMessage = "";
	//					String checkGoodsFaultyMessage = "";
	//					boolean checkGoodsStatusBoolean = true;
	//					boolean checkGoodsFaultyBoolean = true;
	//					
	//					//입출고상태 확인
	//					for (int i=0; i<checkGoodsStatusList.size(); i++) {
	//						if ("003".equals(checkGoodsStatusList.get(i).getGoodsStatus())) {
	//							checkGoodsStatusMessage += checkGoodsStatusList.get(i).getBoxNo() + "<br>";
	//							checkGoodsStatusBoolean = false;
	//						}
	//					}
	//					//불량상태 확인
	//					for (int i=0; i<checkGoodsStatusList.size(); i++) {
	//						if (!"001".equals(checkGoodsStatusList.get(i).getFaultyStatus())) {
	//							checkGoodsFaultyMessage += checkGoodsStatusList.get(i).getBoxNo() + "<br>";
	//							checkGoodsFaultyBoolean = false;
	//						}
	//					}
	//					
	//					//true 이면 이상없음(해당 작지로 생산된 제품들 1개라도 출하X && 불량상태 정상)
	//					if (checkGoodsStatusBoolean == true && checkGoodsFaultyBoolean == true) {
	//						GoodsProductInfoAdmVo divisionWorkOrdCheck = new GoodsProductInfoAdmVo();
	//						divisionWorkOrdCheck.setWorkOrdNo(lastWorkOrdNo);
	//						divisionWorkOrdCheck.setOrdLotNo(lastOrdLotNo);
	//						//복원대상 작지번호로 분할 포장되어 있는 제품번호가 있는지 확인
	//						List<GoodsProductInfoAdmVo> divisionBoxNoList = goodsPackService.divisionWorkOrdCheck(divisionWorkOrdCheck);
	//						
	//						//분할포장된 BoxNo가 O, 복원 취소 
	//						if (divisionBoxNoList.size() != 0) {
	//							String divisionOrignalNoList = "";
	//							for (int i=0; i<divisionBoxNoList.size(); i++) {
	//								divisionOrignalNoList +=  divisionBoxNoList.get(i).getBoxNo();
	//								if( i+1 != divisionBoxNoList.size()) {
	//									divisionOrignalNoList += "<br>";
	//								}
	//							}
	//							jsonData.put("message", divisionOrignalNoList + "해당 제품번호가 분할 포장되어 복원 할 수 없습니다!");
	//							jsonData.put("result", "fail");
	//							
	//						//분할포장된 BoxNo가 X, 복원 진행
	//						} else {
	//							for (int i = 1; i <= 3; i++) {
    //
	//								ordGubun = String.format("%03d", i);
	//								String tmpBoxNo = goodsCd.concat(ordGubun); // goodsCd + 오더구분(001,002,003) 제품오더별 포장정보 관리							
	//								tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo); // 제품 오더별 템프 작지정보 삭제
	//								tmpGoodsProductInfoAdmVo.setTmpBoxNo(tmpBoxNo); // 제품 오더별 템프 작지정보 삭제
	//								tmpGoodsProductInfoAdmVo.setWorkOrdNo(lastWorkOrdNo);
	//								tmpGoodsProductInfoAdmVo.setOrdLotNo(lastOrdLotNo);
	//								tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
	//								tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
	//								tmpGoodsProductInfoAdmVo.setPackCnt(packCnt);
	//								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
	//								goodsPackService.deleteGoodsProductiHist(tmpGoodsProductInfoAdmVo);		//생산제품 상태이력 작지기준 삭제
	//								goodsPackService.deleteGoodsUnlabelTmp(tmpGoodsProductInfoAdmVo);		//해당 생산ordLotNo로 남아있는 미포장수량 삭제
    //
	//								//GoodsProductInfoAdmVo tmpPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
    //
	//								//if(tmpPackInfo != null && tmpPackInfo.getPackDtlCnt() > 0 ) { 
	//								//	continue;	// 템프 마지막 작지정보 삭제 후, 다른 작지정보가 존재한다면 마지막 작지 이므로 다음 오더로 진행
	//								//} else {
	//								// 포장단위 = 상세포장수 동일한 경우 삭제 
	//								goodsPackService.deleteGoodsUnlabelPackUnitInfo(tmpGoodsProductInfoAdmVo);	//기본정보 삭제	//TB_GOODS_PRODUCT_INFO_ADM 해당작지로만 포장된 완제품들 ADM 삭제
	//								goodsPackService.deleteGoodsUnlabelPackUnitDtl(tmpGoodsProductInfoAdmVo);	//상세정보 삭제	//TB_GOODS_PRODUCT_INFO_DTL 해당작지로만 포장된 완제품들 ADM 삭제
    //
	//								tmpGoodsProductInfoAdmVo.setTmpBoxNo(tmpBoxNo);
	//								tmpGoodsProductInfoAdmVo.setPackDate(packDate);
	//								goodsPackService.createGoodsPackDtlToTmp(tmpGoodsProductInfoAdmVo);				//포장수 < 포장단위 인 경우 템프로 이동	//혼합 제품 섞인 DTL 수량 TMP로 복사
	//								goodsPackService.deleteGoodsUnlabelNoPackUnitInfo(tmpGoodsProductInfoAdmVo);	//기본정보 삭제						//혼합 제품 TB_GOODS_PRODUCT_INFO_ADM 삭제
	//								
	//								goodsPackService.deleteGoodsUnlabelNoPackUnitDtl(tmpGoodsProductInfoAdmVo);		//상세정보 삭제						//혼합 제품 DTL 삭제
    //
	//								goodsPackService.deleteGoodsUnlabelTmp(tmpGoodsProductInfoAdmVo);				//임시정보삭제						//복사한 혼합제품 섞인 DLT 수량들 중 복원대상 작지&생산ordLotNo 삭제 - > 나머지들이 복원 후 미포장수량들임
	//								//}
	//							}
	//						
	//							tmpGoodsProductInfoAdmVo.setWorkOrdNo(lastWorkOrdNo);
	//							tmpGoodsProductInfoAdmVo.setOrdLotNo(lastOrdLotNo);
	//							tmpGoodsProductInfoAdmVo.setUpdId(Utils.getUserId());
	//							
	//							
	//							WorkOrdOutputSubVo updateSubWorkPackYn = new WorkOrdOutputSubVo();
	//							updateSubWorkPackYn.setWorkOrdNo(lastWorkOrdNo);
	//							updateSubWorkPackYn.setOrdLotNo(lastOrdLotNo);
	//							updateSubWorkPackYn.setPackYn("N");
	//							updateSubWorkPackYn.setUpdId(Utils.getUserId());
	//							workOrdOutputSubService.updateWorkOrdPublish(updateSubWorkPackYn);	//생산실적(ordLotNo 미포장 상태로 변경)
	//							//goodsPackService.updateWorkOrdPublish(tmpGoodsProductInfoAdmVo);	//작지 미포장상태로 변경
	//	
	//							tmpGoodsProductInfoAdmVo.setTmpBoxNo("lastlabel");
	//							goodsPackService.deleteGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //기존에 있던 TMP의 마지막 작지정보(lastLabel) 삭제
	//	
	//							tmpGoodsProductInfoAdmVo.setBoxNo("lastlabel");
	//							tmpGoodsProductInfoAdmVo.setBoxSeq(1);
	//							tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
	//							tmpGoodsProductInfoAdmVo.setOrdGubun("004");
	//							tmpGoodsProductInfoAdmVo.setWorkOrdNo(lastWorkOrdNo);
	//							tmpGoodsProductInfoAdmVo.setOrdLotNo(lastOrdLotNo);
	//							tmpGoodsProductInfoAdmVo.setPackDtlCnt(packCnt);
	//							tmpGoodsProductInfoAdmVo.setPackDate(packDate);
	//							tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
	//	
	//							goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //마지막 포장 정보(lastLabel) 정보 등록 or 오류 발생처리
	//							jsonData.put("data", readWorkOrdOutputSubVo);
	//							jsonData.put("result", "ok");
	//						} // for
	//						
	//					//해당 작지로 생산된 제품들 중 불량상태가 정상이 아닌제품 한개이상 존재. 복원거부
	//					} else if (checkGoodsFaultyBoolean == false) {
	//						jsonData.put("message", checkGoodsFaultyMessage + "<br>해당 작지로 포장된 제품이 비정상 상태입니다. 복원할 수 없습니다!<br>복원을 원할 경우 해당 제품 불량상태가 정상이여야 합니다!");
	//						jsonData.put("result", "fail");
	//					//해당 작지로 생산된 제품들 중 출하된 제품이 최소 한개이상 존재. 복원거부
	//					} else if (checkGoodsStatusBoolean == false) {
	//						jsonData.put("message", checkGoodsStatusMessage + "<br>해당 작지로 포장된 제품들이 출하되었습니다. 복원할 수 없습니다!<br>복원을 원할 경우 해당 제품 출하를 취소해 주세요.");
	//						jsonData.put("result", "fail");
	//					
	//					}
	//				}
    //
	//			//검색된 작업지시가 없을 경우
	//			} else {
	//				jsonData.put("message", "마지막 라벨 발행된 작지번호가 없습니다.<br/> 바코드를 확인해 주세요.");
	//				jsonData.put("result", "unlabel");
	//			}
	//		} else {
	//			jsonData.put("message", "복원할 제품 생산LotNo가 없습니다.<br/> 바코드를 확인해 주세요.");
	//			jsonData.put("result", "unlabel");
	//		}
	//	} catch (Exception e) {
	//		logger.info("생산실적 라벨발행 취소 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "생산실적 라벨 발행 취소중 오류가 발생했습니다.<br/> 바코드를 확인해 주세요.");
	//		jsonData.put("result", "error");
	//		errFlag = true;
	//	} finally {
	//		if (errFlag) {
	//			tmpGoodsProductInfoAdmVo.setBoxNo("errorlabel");
	//			tmpGoodsProductInfoAdmVo.setBoxSeq(1);
	//			tmpGoodsProductInfoAdmVo.setOrdGubun("004");
	//			tmpGoodsProductInfoAdmVo.setWorkOrdNo(lastWorkOrdNo);
	//			tmpGoodsProductInfoAdmVo.setOrdLotNo(lastOrdLotNo);
	//			tmpGoodsProductInfoAdmVo.setPackDtlCnt(packCnt);
	//			tmpGoodsProductInfoAdmVo.setPackDate(packDate);
	//			tmpGoodsProductInfoAdmVo.setRegId(Utils.getUserId());
	//			goodsPackService.createGoodsLabelTmp(tmpGoodsProductInfoAdmVo); //마지막 포장 정보(lastLabal) 정보 등록 or 오류 발생처리
	//		}
	//	}
	//	
	//	return jsonData;
	//}
	
	//제품포장번호 당 복원
	@RequestMapping(value = "/po/boxNoUnpublish", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> boxNoUnpublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 포장번호별 복원 기능 실행 = " + goodsProductInfoAdmVo);
		
		try {
			String boxNoData = goodsProductInfoAdmVo.getBoxNoData();
			String[] boxDataArray = boxNoData.split("/");
			String goodsCd = goodsProductInfoAdmVo.getGoodsCd();
			//String packDate = DateUtil.getToday("yyyymmdd");		//등록은 항상 서버시간 기준으로 등록
			List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = new ArrayList<GoodsProductInfoAdmVo>();
			boolean boxNoStatusCheck = true;
			//첫번째 위치는 비어있음
			for (int i=1; i<boxDataArray.length; i++) {
				//System.out.println("11111111111111 - " + boxDataArray[i]);
				GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
				readGoodsProductInfo.setBoxNo(boxDataArray[i]);
				readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
				readGoodsProductInfoAdmVoList.add(readGoodsProductInfo);
				
				if (readGoodsProductInfo == null) {
					boxNoStatusCheck = false;
					break;
				//제품코드 확인
				} else if (!goodsCd.equals(readGoodsProductInfo.getGoodsCd())) {
					boxNoStatusCheck = false;
					break;
				//출하 된 제품번호인지 확인
				} else if ("003".equals(readGoodsProductInfo.getGoodsStatus())) {
					boxNoStatusCheck = false;
					break;
				//불량상태의 제품번호인지 확인
				} else if (!"001".equals(readGoodsProductInfo.getFaultyStatus())) {
					boxNoStatusCheck = false;
					break;
				//폐기상태의 제품번호인지 확인
				} else if (!"N".equals(readGoodsProductInfo.getDisuseYn())) {
					boxNoStatusCheck = false;
					break;
				//분할상태의 제품번호인지 확인
				} else if (!"N".equals(readGoodsProductInfo.getDivisionYn())) {
					boxNoStatusCheck = false;
					break;
				}
			}
			
			//복원로직 수행
			if (boxNoStatusCheck) {
				
				Settings singletonSettings = Settings.getInstance();
				
				//제품포장 기능 Lock O
				if (singletonSettings.lockGoodsPacking == true) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("001");	//제품 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;
					
				//제품포장 기능 Lock X
				} else if (singletonSettings.lockGoodsPacking == false) {
					
					//싱글톤 제품포장이 사용중이 아니라면
					if (singletonSettings.useGoodsPacking == false) {
						//진짜 싱글톤 제품포장이 사용중이 아니라면
						if (singletonSettings.useGoodsPacking == false) {
							//제품 포장을 진행할 테니 포장시스템 사용중이라고 변경
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							singletonSettings.useGoodsPacking = true;
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							
							for (int i=0; i<readGoodsProductInfoAdmVoList.size(); i++) {
								//System.out.println(readGoodsProductInfoAdmVoList.get(i));
								
								//각각에 해당하는 생산LotNo로 포장수량 복구시키기
								List<GoodsProductInfoAdmVo> readBoxNoGoodsProductDtlList = goodsPackService.readBoxNoGoodsProductDtlList(readGoodsProductInfoAdmVoList.get(i));
								//SELECT
								//	BOX_NO
								//	, BOX_SEQ
								//	, GOODS_CD
								//	, ORD_GUBUN
								//	, WORK_ORD_NO
								//	, WORK_ORD_LOT_NO
								//	, ORD_LOT_NO
								//	, PACK_DTL_CNT
								//	, PACK_DATE
								//	, PRINT_YN
								//	, REG_ID
								//	, REG_DATE
								//	, UPD_ID
								//	, UPD_DATE
								//FROM TB_GOODS_PRODUCT_INFO_DTL
								//WHERE BOX_NO = #{boxNo}
								
								//검색 후 for문 돌면서 해당 생산LotNo에 미포장 TMP가 생성되어있는지 확인후 INSERT나 UPDATE 해주면 됨!
								for (int j=0; j<readBoxNoGoodsProductDtlList.size(); j++) {
									GoodsProductInfoAdmVo getGoodsProductInfo = new GoodsProductInfoAdmVo();
									getGoodsProductInfo.setGoodsCd(readBoxNoGoodsProductDtlList.get(j).getGoodsCd());
									getGoodsProductInfo.setWorkOrdNo(readBoxNoGoodsProductDtlList.get(j).getWorkOrdNo());
									getGoodsProductInfo.setWorkOrdLotNo(readBoxNoGoodsProductDtlList.get(j).getWorkOrdLotNo());
									getGoodsProductInfo.setPackDtlCnt(readBoxNoGoodsProductDtlList.get(j).getPackDtlCnt());
									
									GoodsProductInfoAdmVo checkWorkOrdLotNoUnPack = goodsPackService.checkWorkOrdLotNoUnPack(getGoodsProductInfo);
									//SELECT * FROM TB_GOODS_PRODUCT_INFO_TMP
									//WHERE 1=1
									//AND ORD_GUBUN = 'unpack'
									//AND GOODS_CD = #{goodsCd}
									//AND WORK_ORD_NO = #{workOrdNo}
									//AND WORK_ORD_LOT_NO = #{workOrdLotNo}
									
									//첫 복원
									if (checkWorkOrdLotNoUnPack == null) {
										GoodsProductInfoAdmVo createWorkOrdLotNoUnPack = new GoodsProductInfoAdmVo();
										//createWorkOrdLotNoUnPack = getGoodsProductInfo;	//이렇게하면 포인터처럼 사용되어서 create 변경하면 get도 같이 바뀜  이방식은  얕은복사임 주소만 복사되는거
										createWorkOrdLotNoUnPack.setGoodsCd(getGoodsProductInfo.getGoodsCd());
										createWorkOrdLotNoUnPack.setOrdGubun("UNP");
										createWorkOrdLotNoUnPack.setWorkOrdNo(getGoodsProductInfo.getWorkOrdNo());
										createWorkOrdLotNoUnPack.setWorkOrdLotNo(getGoodsProductInfo.getWorkOrdLotNo());
										createWorkOrdLotNoUnPack.setPackDtlCnt(0);
										createWorkOrdLotNoUnPack.setPackRemainCnt(getGoodsProductInfo.getPackDtlCnt());
										createWorkOrdLotNoUnPack.setPackNumber("UNP");
										createWorkOrdLotNoUnPack.setPackDate("UNP");
										createWorkOrdLotNoUnPack.setRegId(Utils.getUserId());
										goodsPackService.createWorkOrdLotNoUnPack(createWorkOrdLotNoUnPack);
										//INSERT INTO TB_GOODS_PRODUCT_INFO_TMP (
										//	GOODS_CD
										//	, ORD_GUBUN
										//	, WORK_ORD_NO
										//	, WORK_ORD_LOT_NO
										//	, PACK_DTL_CNT
										//	, PACK_REMAIN_CNT
										//	, PACK_NUMBER
										//	, PACK_DATE
										//	, REG_ID
										//, REG_DATE
										//) VALUES (
										//	#{goodsCd}
										//	, #{ordGubun}
										//	, #{workOrdNo}
										//	, #{workOrdLotNo}
										//	, #{packDtlCnt}
										//	, #{packRemainCnt}
										//	, #{packNumber}
										//	, #{packDate}
										//	, #{regId}
										//	, getDate()
										//)
										
										
									//복원되었던 적이 있음
									} else {
										GoodsProductInfoAdmVo updateWorkOrdLotNoUnPack = new GoodsProductInfoAdmVo(); 
										updateWorkOrdLotNoUnPack = getGoodsProductInfo;
										updateWorkOrdLotNoUnPack.setGoodsCd(getGoodsProductInfo.getGoodsCd());
										updateWorkOrdLotNoUnPack.setOrdGubun("UNP");
										updateWorkOrdLotNoUnPack.setWorkOrdNo(getGoodsProductInfo.getWorkOrdNo());
										updateWorkOrdLotNoUnPack.setWorkOrdLotNo(getGoodsProductInfo.getWorkOrdLotNo());
										updateWorkOrdLotNoUnPack.setPackDtlCnt(getGoodsProductInfo.getPackDtlCnt());
										updateWorkOrdLotNoUnPack.setUpdId(Utils.getUserId());
										goodsPackService.updateWorkOrdLotNoUnPack(updateWorkOrdLotNoUnPack);
										//UPDATE INTO TB_GOODS_PRODUCT_INFO_TMP (
										//SET  PACK_REMAIN_CNT += #{packDtlCnt}
										//	, UPD_ID = #{updId}
										//	, UPD_DATE = getDate()
										//WHERE ORD_GUBUN = #{ordGubun}
										//AND GOODS_CD = #{goodsCd}
										//AND WORK_ORD_NO = #{workOrdNo}
										//AND WORK_ORD_LOT_NO = #{workOrdLotNo}
									}
									
									//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
									StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
									stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(goodsCd, readBoxNoGoodsProductDtlList.get(j).getBoxNo(), "002", "D", "007", readBoxNoGoodsProductDtlList.get(j).getPackDtlCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
									StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
									stockPaymentAdmVoPlus= StockPaymentAdmController.goodsUnPackPlus(goodsCd, readBoxNoGoodsProductDtlList.get(j).getWorkOrdLotNo(), readBoxNoGoodsProductDtlList.get(j).getPackDtlCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);		//새 위치 재고 +
									
								}
								
								//ADM 삭제
								goodsPackService.deleteBoxNoGoodsProductAdm(readGoodsProductInfoAdmVoList.get(i));
								//DELETE TB_GOODS_PRODUCT_INFO_ADM 
								//WHERE BOX_NO = #{boxNo};
								//AND GOODS_CD = #{goodsCd};
								//AND ORD_GUBUN = #{ordGubun};
								
								//DTL 삭제
								goodsPackService.deleteBoxNoGoodsProductDtl(readGoodsProductInfoAdmVoList.get(i));
								//DELETE TB_GOODS_PRODUCT_INFO_ADM_HIST 
								//WHERE BOX_NO = #{boxNo};
								//AND GOODS_CD = #{goodsCd};
								//AND ORD_GUBUN = #{ordGubun};

								//HIST 삭제
								goodsPackService.deleteBoxNoGoodsProductHist(readGoodsProductInfoAdmVoList.get(i));
								//DELETE TB_GOODS_PRODUCT_INFO_DTL 
								//WHERE BOX_NO = #{boxNo};
								//AND GOODS_CD = #{goodsCd};
								//AND ORD_GUBUN = #{ordGubun};
							}
							
							//포장로직 끝
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							singletonSettings.useGoodsPacking = false;
							//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
							
							jsonData.put("goodsUnPackStatusCode", "001");	
							jsonData.put("message", "선택하신 포장번호를 복원하였습니다.");
							jsonData.put("result", "ok");
							
						} else {
							jsonData.put("goodsUnPackStatusCode", "002");
							jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
							jsonData.put("result", "using");
						}
					} else {
						jsonData.put("goodsUnPackStatusCode", "002");
						jsonData.put("message", "현재 포장관련 시스템이 사용중입니다.");
						jsonData.put("result", "using");
					}
				
				} else {
					jsonData.put("message", "제품포장 잠금기능 상태값 오류입니다.<br>관리자에게 문의해주세요!");
					jsonData.put("result", "lock");
					return jsonData;
				}
				
			} else {
				jsonData.put("goodsUnPackStatusCode", "003");
				jsonData.put("message", "제품상태가 정상이 아니거나 출하된 포장번호가 존재합니다!<br>다시 선택해 주세요!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("제품 포장번호별 복원 기능 실행 오류");
			e.printStackTrace();
			jsonData.put("goodsUnPackStatusCode", "004");
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//선택한 제품정보 복원목록 확인
	@RequestMapping(value = "/po/checkUnPackList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> checkUnPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선택한 제품정보 복원목록 확인" + goodsProductInfoAdmVo);
		
		try {
			String boxNoData = goodsProductInfoAdmVo.getBoxNoData();
			//페이지 첫 로딩시 예외처리
			if (boxNoData.equals("")) {
				boxNoData += "'emtpy'";
			} else {
				boxNoData = boxNoData.replace("/", "', '");
				boxNoData = boxNoData.substring(3, boxNoData.length());
				boxNoData += "'";	
			}
			goodsProductInfoAdmVo.setBoxNoData(boxNoData);			
			List<GoodsProductInfoAdmVo> readCheckUnPackList = goodsPackService.readBoxNoGoodsProductDtlList(goodsProductInfoAdmVo);
			
			jsonData.put("data", readCheckUnPackList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("선택한 제품정보 복원목록 확인");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다.");
			jsonData.put("result", "error");
		}
    
		return jsonData;
	}
	
	//생산실적 라벨발행 취소 대상 작지 확인
	//@RequestMapping(value = "/po/goodsLabelUnpublishCheck", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> goodsLabelUnpublishCheck(WorkOrderVo workOrderVo) throws Exception {
    //
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("제품포장 라벨발행 취소 = " + workOrderVo);
    //
	//	String goodsCd = workOrderVo.getGoodsCd();
	//	GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
    //
	//	try {
	//		tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
	//		tmpGoodsProductInfoAdmVo = goodsPackService.selectGoodsPackLastWorkOrdNo(tmpGoodsProductInfoAdmVo);
	//		if (tmpGoodsProductInfoAdmVo != null && tmpGoodsProductInfoAdmVo.getWorkOrdNo().length() > 5 && tmpGoodsProductInfoAdmVo.getOrdLotNo().length() > 5) {
	//			jsonData.put("data", tmpGoodsProductInfoAdmVo);
	//			jsonData.put("result", "ok");
	//		} else {
	//			jsonData.put("message", "복원할 제품의 생산LotNo가 없습니다.<br/> 바코드를 확인해 주세요.");
	//			jsonData.put("result", "unlabel");
	//		}
	//	} catch (Exception e) {
	//		logger.info("생산실적 라벨발행 취소 작지 확인 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "생산실적 라벨발행 취소 대상 작지 확인중 오류가 발생했습니다.<br/>새로고침 후 제품을 다시 선택해 주세요");
	//		jsonData.put("result", "error");
	//	}
    //
	//	return jsonData;
	//}
	
	//제품포장 라벨발행 오류처리
	@RequestMapping(value = "/po/goodsLabelPublishError", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsLabelPublishError(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {		 
		 
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품포장 라벨발행 오류처리 = "+ workOrdOutputSubVo);
		
		String workOrdNo = null;
		String ordLotNo = null;
		String goodsCd = null;
		String packDate = workOrdOutputSubVo.getPackDate();
		int packCnt = workOrdOutputSubVo.getPackCnt();
		String ordGubun;
		boolean errFlag = false;
		
		WorkOrderVo tmpWorkOrderVo = new WorkOrderVo();
		GoodsProductInfoAdmVo tmpGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();

		try {

			tmpGoodsProductInfoAdmVo.setBoxNo("errorlabel");
			GoodsProductInfoAdmVo errorPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
			if (errorPackInfo != null && errorPackInfo.getWorkOrdNo() != null) {
				workOrdOutputSubVo.setWorkOrdNo(errorPackInfo.getWorkOrdNo());
				workOrdOutputSubVo.setOrdLotNo(errorPackInfo.getOrdLotNo());
				
				WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
				//workOrderVo = workOrderService.read(workOrderVo);
				if (readWorkOrdOutputSubVo != null && readWorkOrdOutputSubVo.getWorkOrdNo() != null) {
					workOrdNo = readWorkOrdOutputSubVo.getWorkOrdNo();
					ordLotNo = readWorkOrdOutputSubVo.getOrdLotNo();
					goodsCd = readWorkOrdOutputSubVo.getGoodsCd();
					packCnt = Integer.parseInt(readWorkOrdOutputSubVo.getPackUnitNm());
					
					// for
					for(int i=1; i <= 3; i++) {
						ordGubun = String.format("%03d",i);
						String tmpBoxNo = goodsCd.concat(ordGubun);			//goodsCd + 오더구분(001,002,003) 제품오더별 포장정보 관리							
						tmpGoodsProductInfoAdmVo.setBoxNo(tmpBoxNo);		//제품 오더별 템프 작지정보 삭제
						tmpGoodsProductInfoAdmVo.setTmpBoxNo(tmpBoxNo);		// 제품 오더별 템프 작지정보 삭제
						tmpGoodsProductInfoAdmVo.setWorkOrdNo(workOrdNo);
						tmpGoodsProductInfoAdmVo.setOrdLotNo(ordLotNo);
						tmpGoodsProductInfoAdmVo.setGoodsCd(goodsCd);
						tmpGoodsProductInfoAdmVo.setOrdGubun(ordGubun);
						tmpGoodsProductInfoAdmVo.setPackCnt(packCnt);
						tmpGoodsProductInfoAdmVo.setPackDate(packDate);
						goodsPackService.deleteGoodsUnlabelTmp(tmpGoodsProductInfoAdmVo);
				
						//GoodsProductInfoAdmVo tmpPackInfo = goodsPackService.goodsPackTmpInfo(tmpGoodsProductInfoAdmVo);
						
						//if(tmpPackInfo != null && tmpPackInfo.getPackDtlCnt() > 0 ) { 
						//	continue;	// 템프 마지막 작지정보 삭제 후, 다른 작지정보가 존재한다면 마지막 작지 이므로 다음 오더로 진행
						//} else {
							// 포장단위 = 상세포장수 동일한 경우 삭제 
							goodsPackService.deleteGoodsUnlabelPackUnitInfo(tmpGoodsProductInfoAdmVo); 	//기본정보 삭제
							goodsPackService.deleteGoodsUnlabelPackUnitDtl(tmpGoodsProductInfoAdmVo); 	//상세정보 삭제
							
							tmpGoodsProductInfoAdmVo.setTmpBoxNo(tmpBoxNo);
							tmpGoodsProductInfoAdmVo.setPackDate(packDate);
							goodsPackService.createGoodsPackDtlToTmp(tmpGoodsProductInfoAdmVo); 		//포장수 < 포장단위 인 경우 템프로 이동
							
							goodsPackService.deleteGoodsUnlabelNoPackUnitInfo(tmpGoodsProductInfoAdmVo); 	//기본정보 삭제
							goodsPackService.deleteGoodsUnlabelNoPackUnitDtl(tmpGoodsProductInfoAdmVo); 	//상세정보 삭제
							
							goodsPackService.deleteGoodsUnlabelTmp(tmpGoodsProductInfoAdmVo); // 임시정보삭제
						//}
					}
					
					WorkOrdOutputSubVo updateSubWorkStatusCd = new WorkOrdOutputSubVo();
					updateSubWorkStatusCd.setWorkOrdNo(workOrdNo);
					updateSubWorkStatusCd.setOrdLotNo(ordLotNo);
					updateSubWorkStatusCd.setPackYn("N");
					updateSubWorkStatusCd.setUpdId(Utils.getUserId());
					workOrdOutputSubService.updateWorkOrdPublish(updateSubWorkStatusCd);//작지 포장상태로 변경
					//goodsPackService.updateWorkOrdPublish(tmpGoodsProductInfoAdmVo); //작지 미포장상태로 변경
					
					tmpGoodsProductInfoAdmVo.setTmpBoxNo("errorlabel");
					goodsPackService.deleteGoodsLabelTmp(tmpGoodsProductInfoAdmVo); // 오류 작지정보 삭제
					
					jsonData.put("data", readWorkOrdOutputSubVo);
					jsonData.put("result", "ok");
				} else { // for
					jsonData.put("message", "오류 복원할 제품 작지번호가 존재하지 않습니다.<br/> 바코드를 확인해 주세요.");
					jsonData.put("result", "unlabel");					
				}
			} else {
				jsonData.put("message", "오류 작지번호가 없습니다.<br/>바코드를 확인해 주세요.");
				jsonData.put("result", "unlabel");				
			}
		} catch (Exception e) {
				logger.info("생산실적 라벨발행 취소 오류");
				e.printStackTrace();
				jsonData.put("message", "생산실적 라벨 발행 취소중 오류가 발생했습니다.<br/> 바코드를 확인해 주세요.");
				jsonData.put("result", "fail");	
				errFlag = true;
		} finally {
			logger.info("생산실적 라벨발행 오류 처리 종료");
		}
	 	return jsonData;
	}
	
	//생산실적 라벨발행 프린트(스티커인쇄1 btnPrint)
	@RequestMapping(value = "/po/barcodePrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrdAppearCnt(@RequestParam(value="boxDataArray") String boxDataArray
																	/*
																	 @RequestParam(value="boxNo") String boxNo,
																	 @RequestParam(value="ordGubun") String ordGubun,
																	 @RequestParam(value="goodsCd") String goodsCd,
																	 @RequestParam(value="goodsNm") String goodsNm
																	 */
																	 ) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		Map<String, Object> printJsonData = new HashMap<String, Object>();
		
		logger.info(boxDataArray);
		String[] arrayBoxNo = boxDataArray.split("/");
		String boxNo = null;
		try {
			
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int k=1; k<arrayBoxNo.length; k++ ) {
				
				//전달받은 boxNo로 제품상세정보 확인
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				boxNo = arrayBoxNo[k];	//인쇄할 BoxNo
				goodsProductInfoAdmVo.setBoxNo(boxNo);
				goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				
				//제품 폐기 여부 확인(리로드가 되지 않아 폐기된제품을 인쇄선택시 예외사항처리)
				if ("Y".equals(goodsProductInfoAdmVo.getDisuseYn())) {
					jsonData.put("message", boxNo + " - 폐기된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//분할된 제품 인쇄 불가
				} else if ("D".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 분할된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				
				//병합된 제품 인쇄 불가
				} else if ("M".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 병합된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//인쇄 가능한 정상제품
				} else {
					//제품정보 읽기
					logger.info("생산실적 라벨발행 프린트(스티커인쇄2)" + goodsProductInfoAdmVo);
					GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
					goodsCodeAdmVo.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
					goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
					String packUnitNm = null;
					packUnitNm = goodsCodeAdmVo.getPackUnitNm();
					String IP = null;
					
					//제품의 포함된 작지번호 최대 3개까지읽기
					//List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(goodsProductInfoAdmVo);
					goodsProductInfoAdmVo.setFactoryCode(factoryCode);
					List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(goodsProductInfoAdmVo);
					int j = 0;
					String ordLotNo1 = "①";
					String ordLotNo2 = "②";
					String ordLotNo3 = "③";
					
					float tempDivison = 0;
					float stepAverage = 0;
					//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
					for (GoodsProductInfoAdmVo i : GoodsProductInfoAdmVoList) {
						if (0 == i.getPackDtlCnt()) {
							//아무것도 안함.
						} else {
							if (j > 2) {
								break;
							}
							//첫번째 작지만 평균 계산
							if (j == 0) {
								
								//WorkOrderVo workOrderVo1 = new WorkOrderVo();
								//workOrderVo1.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo1 = workOrderService.read(workOrderVo1);
								
								//WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
								//workOrdOutputSubVo.setWorkOrdNo(i.getWorkOrdNo());
								//workOrdOutputSubVo.setOrdLotNo(i.getOrdLotNo());
								//WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
								//ordLotNo1 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo1 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
								//초,중물 검색
								EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
								firstEquipSizeCondStepVo.setWorkOrdNo(i.getWorkOrdNo());
								firstEquipSizeCondStepVo.setLotNo(i.getLotNo());
								List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
								
								//종물 등록 확인
								EquipSizeCondStepVo checkThirdEquipSizeCondStep = new EquipSizeCondStepVo();
								checkThirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//checkThirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								checkThirdEquipSizeCondStep.setLotNo(i.getLotNo());
								checkThirdEquipSizeCondStep.setStepCd("003");
								checkThirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(checkThirdEquipSizeCondStep);

								//종물을 입력하지 않은 제품번호에서 중지
								if (checkThirdEquipSizeCondStep.getCount() == 0) {
									jsonData.put("message", "작지번호 : " + i.getWorkOrdNo() + "<br> 주자재 : &nbsp&nbsp: " + i.getLotNo() + "<br>종물을 입력해 주세요!");
									jsonData.put("result", "fail");
									return jsonData;
								}
								
								//종물 검색
								EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
								thirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								thirdEquipSizeCondStep.setLotNo(i.getLotNo());
								thirdEquipSizeCondStep.setStepCd("003");
								thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);

								float stepSum = 0;
								//AGT 초,중물이 비어있는 경우
								if (EquipSizeCondStepList.isEmpty()) {
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									tempDivison = 1;

								//AGT 초,중,종물 총개수
								} else {
									//초,중물 합
									for (int kk=0; kk<EquipSizeCondStepList.size(); kk++) {
										//초,중물 값이 0일경우 계산식에서 제외
										if (Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce()) != 0 && Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce()) != 0) {
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce());
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce());
											tempDivison++;
										}
									}
									//종물 합
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//초,중 + 종 = 총개수
									tempDivison++;
								}
								//소수점 2자리에서 반올림하여 1자리까지만 표시
								stepAverage = (float) (Math.round((stepSum / tempDivison) * 10) / 10.0);
								logger.info(String.valueOf(stepAverage));
								
							} else if (j == 1) {
								//WorkOrderVo workOrderVo2 = new WorkOrderVo();
								//workOrderVo2.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo2 = workOrderService.read(workOrderVo2);
								//ordLotNo2 += workOrderVo2.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								//ordLotNo2 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo2 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
							} else if (j == 2) {
								//WorkOrderVo workOrderVo3 = new WorkOrderVo();
								//workOrderVo3.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo3 = workOrderService.read(workOrderVo3);
								//ordLotNo3 += workOrderVo3.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								//ordLotNo3 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo3 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
							}
							j++;
						}
					}
					if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("A")) {
						IP = IP3;
					} else if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("N")) {
						IP = IP4;
					}
					logger.info("프린터 IP주소(스티커인쇄2) : " + IP);
					String workOrdCnt = null;
					printJsonData = MtpLabel.barCodePrint(IP, PORT, goodsProductInfoAdmVo, ordLotNo1, ordLotNo2, ordLotNo3, stepAverage, packUnitNm, workOrdCnt);
					//라벨발행 시 printYn 업데이트
					if ("printSuccess".equals(printJsonData.get("printResult"))) {
						goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
						goodsPackService.goodsPackPrintYnUpdate(goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
						jsonData.put("result", "fail");
					}
				}

			//for문 종료
			}
		} catch (NullPointerException e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) NullPoint 에러");
			e.printStackTrace();
			jsonData.put("message", "복원되어서 존재하지 않는 BoxNo입니다.");
			jsonData.put("result", "fail");
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 라벨발행 프린트(스티커인쇄2 btnPrint3)
	@RequestMapping(value = "/po/barcodePrint3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrdAppearCnt3(@RequestParam(value = "boxDataArray") String boxDataArray
																		/*
																		@RequestParam(value="boxNo") String boxNo,
																		@RequestParam(value="ordGubun") String ordGubun,
																		@RequestParam(value="goodsCd") String goodsCd,
																		@RequestParam(value="goodsNm") String goodsNm
																		*/
																		) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		Map<String, Object> printJsonData = new HashMap<String, Object>();
		
		logger.info(boxDataArray);
		String[] arrayBoxNo = boxDataArray.split("/");
		String boxNo = null;
		try {
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int k=1; k<arrayBoxNo.length; k++ ) {
				
				//전달받은 boxNo로 제품상세정보 확인
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				boxNo = arrayBoxNo[k];	//인쇄할 BoxNo
				goodsProductInfoAdmVo.setBoxNo(boxNo);
				goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				
				//제품 폐기 여부 확인(리로드가 되지 않아 폐기된제품을 인쇄선택시 예외사항처리)
				if ( "Y".equals(goodsProductInfoAdmVo.getDisuseYn()) ) {
					jsonData.put("message", boxNo + " - 폐기된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//분할된 제품 인쇄 불가
				} else if ("D".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 분할된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				
				//병합된 제품 인쇄 불가
				} else if ("M".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 병합된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//인쇄 가능한 정상제품
				} else {
					//제품정보 읽기
					logger.info("생산실적 라벨발행 프린트(스티커인쇄2)" + goodsProductInfoAdmVo);
					GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
					goodsCodeAdmVo.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
					goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
					String packUnitNm = null;
					packUnitNm = goodsCodeAdmVo.getPackUnitNm();
					String IP = null;
					
					//제품의 포함된 작지번호 최대 3개까지읽기
					//List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(goodsProductInfoAdmVo);
					goodsProductInfoAdmVo.setFactoryCode(factoryCode);
					List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(goodsProductInfoAdmVo);
					int j = 0;
					String ordLotNo1 = "①";
					String ordLotNo2 = "②";
					String ordLotNo3 = "③";
					
					int tempDivison = 0;
					float stepAverage = 0;
					//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
					for (GoodsProductInfoAdmVo i : GoodsProductInfoAdmVoList) {
						if (0 == i.getPackDtlCnt()) {
							//아무것도 안함.
						} else {
							if (j > 2) {
								break;
							}
							//첫번째 작지만 평균 계산
							if (j == 0) {
								
								//WorkOrderVo workOrderVo1 = new WorkOrderVo();
								//workOrderVo1.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo1 = workOrderService.read(workOrderVo1);
								
								//WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
								//workOrdOutputSubVo.setWorkOrdNo(i.getWorkOrdNo());
								//workOrdOutputSubVo.setOrdLotNo(i.getOrdLotNo());
								//WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
								//ordLotNo1 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo1 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
								//초,중물 검색
								EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
								firstEquipSizeCondStepVo.setWorkOrdNo(i.getWorkOrdNo());
								firstEquipSizeCondStepVo.setLotNo(i.getLotNo());
								List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
								
								//종물 등록 확인
								EquipSizeCondStepVo checkThirdEquipSizeCondStep = new EquipSizeCondStepVo();
								checkThirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//checkThirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								checkThirdEquipSizeCondStep.setLotNo(i.getLotNo());
								checkThirdEquipSizeCondStep.setStepCd("003");
								checkThirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(checkThirdEquipSizeCondStep);

								//종물 을 입력하지 않은 제품번호에서 중지
								if (checkThirdEquipSizeCondStep.getCount() == 0) {
									jsonData.put("message", "작지번호 : " + i.getWorkOrdNo() + "<br> 주자재 : &nbsp&nbsp: " + i.getLotNo() + "<br>종물을 입력해 주세요!");
									jsonData.put("result", "fail");
									return jsonData;
								}
								
								//종물 검색
								EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
								thirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								thirdEquipSizeCondStep.setLotNo(i.getLotNo());
								thirdEquipSizeCondStep.setStepCd("003");
								thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);

								float stepSum = 0;
								//AGT 초,중물이 비어있는 경우
								if (EquipSizeCondStepList.isEmpty()) {
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									tempDivison = 1;

								//AGT 초,중,종물 총개수
								} else {
									//초,중물 합
									for (int kk=0; kk<EquipSizeCondStepList.size(); kk++) {
										//초,중물 값이 0일경우 계산식에서 제외
										if (Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce()) != 0 && Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce()) != 0) {
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce());
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce());
											tempDivison++;
										}
									}
									//종물 합
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//초,중 + 종 = 총개수
									tempDivison++;
								}
								//소수점 2자리에서 반올림하여 1자리까지만 표시
								stepAverage = (float) (Math.round((stepSum / tempDivison) * 10) / 10.0);
								logger.info(String.valueOf(stepAverage));

							} else if (j == 1) {
								//WorkOrderVo workOrderVo2 = new WorkOrderVo();
								//workOrderVo2.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo2 = workOrderService.read(workOrderVo2);
								//ordLotNo2 += workOrderVo2.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								//ordLotNo2 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo2 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
							} else if (j == 2) {
								//WorkOrderVo workOrderVo3 = new WorkOrderVo();
								//workOrderVo3.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo3 = workOrderService.read(workOrderVo3);
								//ordLotNo3 += workOrderVo3.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								//ordLotNo3 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo3 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								
							}
							j++;
						}
					}
					if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("A")) {
						IP = IP5;
					} else if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("N")) {
						IP = IP6;
					}
					logger.info("프린터 IP주소(스티커인쇄2) : " + IP);
					String workOrdCnt = null;
					printJsonData = MtpLabel.barCodePrint(IP, PORT, goodsProductInfoAdmVo, ordLotNo1, ordLotNo2, ordLotNo3, stepAverage, packUnitNm, workOrdCnt);
					//라벨발행 시 printYn 업데이트
					if ("printSuccess".equals(printJsonData.get("printResult"))) {
						goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
						goodsPackService.goodsPackPrintYnUpdate(goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
						jsonData.put("result", "fail");
					}
				}

			//for문 종료
			}
		} catch (NullPointerException e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) NullPoint 에러");
			e.printStackTrace();
			jsonData.put("message", "복원되어서 존재하지 않는 BoxNo입니다.");
			jsonData.put("result", "fail");
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 라벨발행 프린트(스티커인쇄2 btnPrint3)
	@RequestMapping(value = "/po/barcodePrint3_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrdAppearCnt3_F3(HttpServletRequest request,
																		@RequestParam(value = "boxDataArray") String boxDataArray
																		/*
																		@RequestParam(value="boxNo") String boxNo,
																		@RequestParam(value="ordGubun") String ordGubun,
																		@RequestParam(value="goodsCd") String goodsCd,
																		@RequestParam(value="goodsNm") String goodsNm
																		*/
																		) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		Map<String, Object> printJsonData = new HashMap<String, Object>();
	    List<String[]> printList = new ArrayList<>();
	    HttpSession session = request.getSession(true);
		logger.info(boxDataArray);
		String[] arrayBoxNo = boxDataArray.split("/");
		String boxNo = null;
		try {
			if (!"002".equals(session.getAttribute("factoryCode")) && !"003".equals(session.getAttribute("factoryCode"))) {
				jsonData.put("message", "잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int k=1; k<arrayBoxNo.length; k++ ) {
				
				//전달받은 boxNo로 제품상세정보 확인
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				boxNo = arrayBoxNo[k];	//인쇄할 BoxNo
				goodsProductInfoAdmVo.setBoxNo(boxNo);
				goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				
				//제품 폐기 여부 확인(리로드가 되지 않아 폐기된제품을 인쇄선택시 예외사항처리)
				if ( "Y".equals(goodsProductInfoAdmVo.getDisuseYn()) ) {
					jsonData.put("message", boxNo + " - 폐기된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//분할된 제품 인쇄 불가
				} else if ("D".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 분할된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				
				//병합된 제품 인쇄 불가
				} else if ("M".equals(goodsProductInfoAdmVo.getDivisionYn())) {
					jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 병합된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//인쇄 가능한 정상제품
				} else {
					//제품정보 읽기
					logger.info("생산실적 라벨발행 프린트(스티커인쇄2)" + goodsProductInfoAdmVo);
					GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
					goodsCodeAdmVo.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
					goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
					String packUnitNm = null;
					packUnitNm = goodsCodeAdmVo.getPackUnitNm();
					String IP = null;
					
					//제품의 포함된 작지번호 최대 3개까지읽기
					//List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(goodsProductInfoAdmVo);
					goodsProductInfoAdmVo.setFactoryCode(factoryCode);
					List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(goodsProductInfoAdmVo);
					int j = 0;
					String ordLotNo1 = "①";
					String ordLotNo2 = "②";
					String ordLotNo3 = "③";
					
					int tempDivison = 0;
					float stepAverage = 0;
					//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
					for (GoodsProductInfoAdmVo i : GoodsProductInfoAdmVoList) {
						if (0 == i.getPackDtlCnt()) {
							//아무것도 안함.
						} else {
							if (j > 2) {
								break;
							}
							//첫번째 작지만 평균 계산
							if (j == 0) {
								//ordLotNo1 += i.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo1 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								//초,중물 검색
								EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
								firstEquipSizeCondStepVo.setWorkOrdNo(i.getWorkOrdNo());
								firstEquipSizeCondStepVo.setLotNo(i.getLotNo());
								List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
								
								//종물 등록 확인
								//EquipSizeCondStepVo checkThirdEquipSizeCondStep = new EquipSizeCondStepVo();
								//EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
								
								//MTP 2공장의 경우 품질팀에서 종물데이터를 등록함
								//if ("002".equals(session.getAttribute("factoryCode"))) {
								//	//checkThirdEquipSizeCondStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
								//	//checkThirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								//	//checkThirdEquipSizeCondStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
								//	checkThirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//	checkThirdEquipSizeCondStep.setLotNo(i.getLotNo());
								//	
								//	checkThirdEquipSizeCondStep.setStepCd("003");
								//	checkThirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(checkThirdEquipSizeCondStep);
								//	
								//	//종물 을 입력하지 않은 제품번호에서 중지
								//	if (checkThirdEquipSizeCondStep.getCount() == 0) {
								//		jsonData.put("message", "작지번호 : " + i.getWorkOrdNo() + "<br> 주자재 : &nbsp&nbsp: " + i.getLotNo() + "<br>종물을 입력해 주세요!");
								//		jsonData.put("result", "fail");
								//		return jsonData;
								//	}
								//	
								//	//thirdEquipSizeCondStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
								//	//thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
								//	//thirdEquipSizeCondStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
								//	thirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
								//	thirdEquipSizeCondStep.setLotNo(i.getLotNo());
								//	thirdEquipSizeCondStep.setStepCd("003");
								//	thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);
								//	
								////솔브레인SLD의 경우 생산팀에서 초,중,종물 데이터를 불러옴
								//} else if ("003".equals(session.getAttribute("factoryCode"))) {
								//	
								//}
								
								float stepSum = 0;
								//AGT 초,중물이 비어있는 경우
								if (EquipSizeCondStepList.isEmpty()) {
									////MTP 2공장 종물만 등록한 경우
									//if ("002".equals(session.getAttribute("factoryCode"))) {
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//	tempDivison = 1;
									//	
									////솔브레인SLD 초,중,종물을 하나도 등록하지 않은 경우
									//} else if ("003".equals(session.getAttribute("factoryCode"))) {
										stepAverage = 0;
									//}
									
								//AGT 초,중,종물 총개수
								} else {
									//초,중물 합
									for (int kk=0; kk<EquipSizeCondStepList.size(); kk++) {
										//초,중물 값이 0일경우 계산식에서 제외
										if (Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce()) != 0 && Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce()) != 0) {
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce());
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce());
											tempDivison++;
										}
									}
									
									////종물 합 - MTP 2공장의 경우 품질팀에서 종물데이터를 등록함
									//if ("002".equals(session.getAttribute("factoryCode"))) {
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//	//초,중 + 종 = 총개수
									//	tempDivison++;
									//}

								}
								
								//소수점 2자리에서 반올림하여 1자리까지만 표시
								stepAverage = (float) (Math.round((stepSum / tempDivison) * 10) / 10.0);
								logger.info(String.valueOf(stepAverage));

							} else if (j == 1) {
								//WorkOrderVo workOrderVo2 = new WorkOrderVo();
								//workOrderVo2.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo2 = workOrderService.read(workOrderVo2);
								//ordLotNo2 += workOrderVo2.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo2 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
							} else if (j == 2) {
								//WorkOrderVo workOrderVo3 = new WorkOrderVo();
								//workOrderVo3.setWorkOrdNo(i.getWorkOrdNo());
								//workOrderVo3 = workOrderService.read(workOrderVo3);
								//ordLotNo3 += workOrderVo3.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
								ordLotNo3 += i.getWorkOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
							}
							j++;
						}
					}
					//if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("A")) {
					//	IP = IP5;
					//} else if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("N")) {
					//	IP = IP6;
					//}
					//logger.info("프린터 IP주소(스티커인쇄2) : " + IP);
					String workOrdCnt = null;
					String desc = "";
					String image2 = "";
					//자재명 판단  	  	
			  	  	if (goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("A")){
			  	  		desc = "Cathode Tab (Al)";
			  	  	} else if (goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("N")){
			  	  		desc = "Anode Tab (NiCu)"; 
			  	  	}
			  	  	
				    if(goodsProductInfoAdmVo.getGoodsNm().contains("DE/SK")) {
				    	//image = "{XQ;01,0,L|}";
				    	image2 = "02";
				    }
				    //HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("HE370")) {
				    	//image = "{XQ;97,0,L|}";
				    	image2 = "98";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("E370")) {
				    	//image = "{XQ;03,0,L|}";
				    	image2 = "04";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("H200")) {
				    	//image = "{XQ;09,0,L|}";
				    	image2 = "10";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("P260")) {
				    	//image = "{XQ;11,0,L|}";
				    	image2 = "12";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("P395")) {
				    	//image = "{XQ;13,0,L|}";
				    	image2 = "14";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("E556")) {
				    	//image = "{XQ;15,0,L|}";
				    	image2 = "16";
				    }
				    else if(goodsProductInfoAdmVo.getGoodsNm().contains("N60")) {
				    	//image = "{XQ;17,0,L|}";
				    	image2 = "18";
				    }
				    else {
				    	//image = "{XQ;97,0,L|}";
				    	image2 = "98";
				    }
				    
				    String[] dataArr = new String[15];
				    
				    dataArr[0] = goodsProductInfoAdmVo.getBoxNo();
				    dataArr[1] = goodsProductInfoAdmVo.getGoodsNm();
				    dataArr[2] = ordLotNo1;
				    dataArr[3] = ordLotNo2;
				    dataArr[4] = ordLotNo3;
				    dataArr[5] = goodsProductInfoAdmVo.getOrdGubunNm();
				    dataArr[6] = Float.toString(stepAverage);
				    dataArr[7] = desc;
				    dataArr[8] = workOrdCnt;
				    dataArr[9] = packUnitNm;
				    dataArr[10] = image2;
					
				    printList.add(dataArr);
					
					//라벨발행 시 printYn 업데이트
					//if ("printSuccess".equals(printJsonData.get("printResult"))) {
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsPackService.goodsPackPrintYnUpdate(goodsProductInfoAdmVo);
					jsonData.put("result", "ok");
					//} else {
					//	jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
					//	jsonData.put("result", "fail");
					//}
				}

			//for문 종료
			}
		} catch (NullPointerException e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) NullPoint 에러");
			e.printStackTrace();
			jsonData.put("message", "복원되어서 존재하지 않는 BoxNo입니다.");
			jsonData.put("result", "fail");
		} catch (Exception e) {
			logger.info("생산실적 라벨발행 프린트(스티커인쇄2) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		jsonData.put("printList", printList);
		
		return jsonData;
	}
	
	//분할&병합 할 제품 정보 읽기
	@RequestMapping(value = "po/readDivisionMeargeBoxNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readDivisionMeargeBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("분할 할 제품 정보 읽기" + goodsProductInfoAdmVo);
		
		try {
			logger.info(goodsProductInfoAdmVo.getBoxNo());
			goodsProductInfoAdmVo = goodsPackService.readDivisionMeargeBoxNo(goodsProductInfoAdmVo);
			
			if ( goodsProductInfoAdmVo == null ) {
				jsonData.put("message", "이미 분할되었거나 없는 포장번호 입니다.<br>포장번호를 확인해 주세요!");
				jsonData.put("result", "fail");
			} else if (0 == goodsProductInfoAdmVo.getRemainCnt()) {
				jsonData.put("message", "남은수량이 0인 제품은 분할&병합 할 수 없습니다!");
				jsonData.put("result", "fail");
			} else if(!"001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
				jsonData.put("message", goodsProductInfoAdmVo.getFaultyStatusNm() + " 상태의 제품입니다.");
				jsonData.put("result", "fail");
			} else if ("001".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
				jsonData.put("message", "포장상태 제품은 분할&병합 할 수 없습니다.<br>입고 상태의 제품만 분할&병합 할 수 있습니다!");
				jsonData.put("result", "fail");
			} else if ("003".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
				jsonData.put("message", "출고상태 제품은 분할&병합 할 수 없습니다.<br>입고 상태의 제품만 분할&병합 할 수 있습니다!");
				jsonData.put("result", "fail");
			} else if ("D".equals(goodsProductInfoAdmVo.getDivisionYn())) {
				jsonData.put("message", "이미 분할 된 포장번호로 분할&병합 할 수 없습니다!");
				jsonData.put("result", "fail");
			} else if ("M".equals(goodsProductInfoAdmVo.getDivisionYn())) {
				jsonData.put("message", "이미 병합된 포장번호로 분할&병합 할 수 없습니다!");
				jsonData.put("result", "fail");
			} else if ("003".equals(goodsProductInfoAdmVo.getDisposeGubun())) {
				jsonData.put("message", "폐기지정된 포장번호 입니다.");
				jsonData.put("result", "fail");
			} else if ("004".equals(goodsProductInfoAdmVo.getDisposeGubun())) {
				jsonData.put("message", "폐기된 포장번호 입니다.");
				jsonData.put("result", "fail");
			} else {
				
				//3공장에서 사용중인 미료&완료에 값이 들어가 있으면 파레트 포장 대상
				if( factoryCode.equals("003") ) {
					if( goodsProductInfoAdmVo.getCompleteYn() != null ) {
						if( !goodsProductInfoAdmVo.getCompleteYn().equals("") ) {
							jsonData.put("message", "파레트 포장된 제품은 분할&병합할 수 없습니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}
					}
				}
				
				jsonData.put("data", goodsProductInfoAdmVo);
				//jsonData.put("message", "분할 가능한 포장번호입니다.");
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
				logger.info("분할 할 제품 boxNo read 에러");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
		}
		
		return jsonData;
	}
		
	//제품 분할 포장 가능 여부 확인
	@RequestMapping(value = "po/divisionBoxNoCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> divisionBoxNoCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		logger.info("제품 포장 분할 가능 여부 확인");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			List<GoodsProductInfoAdmVo> originalBoxNoCheck = goodsPackService.divisionBoxNoListCheck(goodsProductInfoAdmVo);
			//해당 원장BoxNo가 분할 가능한지, 이상이 없는지 확인
			if (originalBoxNoCheck.size() == 0) {
				jsonData.put("message", "존재하지 않거나 분할&병합 불가능한 제품번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "researchFail");
			} else if (originalBoxNoCheck.size() == 1) {
				
				if ( "Y".equals(originalBoxNoCheck.get(0).getDisuseYn()) ) {
					jsonData.put("messaㅁge", "폐기된 작지는 분할 할 수 없습니다!");
					jsonData.put("result", "researchFail");
					
				} else if ( "D".equals(originalBoxNoCheck.get(0).getDivisionYn()) ) {
					jsonData.put("message", "이미 분할된 포장번호 입니다.");
					jsonData.put("result", "print");
					
				} else if ( "M".equals(originalBoxNoCheck.get(0).getDivisionYn()) ) {
					jsonData.put("message", "이미 병합된 포장번호 입니다.");
					jsonData.put("result", "print");
					
				} else {
					jsonData.put("data", originalBoxNoCheck);
					jsonData.put("message", "분할 포장 가능한 제품번호입니다.");
					jsonData.put("result", "ok");
				}
				
			} else if (originalBoxNoCheck.size() >= 2) {
				jsonData.put("message", "혼합 포장된 제품은 분할 할 수 없습니다!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("제품 분할 포장 가능 여부 확인 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
    
		return jsonData;
	}
	
	//제품 포장 분할 생성
	@RequestMapping(value = "po/createDivisionBoxNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createDivisionBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo, @RequestParam(value="jsonArray") String jsonArray) throws Exception {
		
		logger.info("제품 포장 분할 수행 - " + goodsProductInfoAdmVo);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		try {
			GoodsProductInfoAdmVo readGoodsProductInfoByTray = new GoodsProductInfoAdmVo();
			readGoodsProductInfoByTray.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
			
			//제품 분할 포장 가능 여부 확인
			List<GoodsProductInfoAdmVo> readGoodsProductInfoList = goodsPackService.divisionBoxNoListCheck(goodsProductInfoAdmVo);

			//제품 존재 여부 확인
			if (readGoodsProductInfoList.size() == 0) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 존재하지 않거나 분할&병합 불가능한 제품번호 입니다!<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");

			//혼합작지 여부 확인 -> 혼합작지도 분할 가능하도록 변경됨.
			//} else if (readGoodsProductInfoList.size() > 1) {
			//	jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 혼합 작지 제품은 분할 할 수 없습니다.<br>제품번호를 확인해 주세요!");
			//	jsonData.put("result", "fail");
            //
				
			//폐기 유무 확인
			} else if ("Y".equals(readGoodsProductInfoList.get(0).getDisuseYn())) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 폐기된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");

			//분할 유무 확인
			} else if ("D".equals(readGoodsProductInfoList.get(0).getDivisionYn())) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 이미 분할된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");
			
			//병합 유무 확인
			} else if ("M".equals(readGoodsProductInfoList.get(0).getDivisionYn())) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 이미 병합된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");
			
			//제품 정보 일치 확인
			} else {
				//가져온 boxNo로 goodsCd, ordGubun, workOrdNo, packDtlCnt 일치하는지 확인 후
				//분할 실행
				if (goodsProductInfoAdmVo.getGoodsCd().equals(readGoodsProductInfoList.get(0).getGoodsCd()) &&
					goodsProductInfoAdmVo.getOrdGubun().equals(readGoodsProductInfoList.get(0).getOrdGubun()) &&
					goodsProductInfoAdmVo.getWorkOrdNo().equals(readGoodsProductInfoList.get(0).getWorkOrdNo()) &&
					goodsProductInfoAdmVo.getPackDtlCnt() == (readGoodsProductInfoList.get(0).getPackDtlCnt()) ) {
					
					//싱글톤 포장 실행
					Settings singletonSettings = Settings.getInstance();
					
					//제품포장 기능 Lock O
					if (singletonSettings.lockGoodsPacking == true) {
						SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
						systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
						systemCommonCode.setBaseCd("001");	//제푸 포장Lock
						systemCommonCode = systemCommonCodeService.read(systemCommonCode);
						jsonData.put("message", systemCommonCode.getEtc1());
						jsonData.put("result", "lock");
						return jsonData;
						
					//제품포장 기능 Lock X
					} else if (singletonSettings.lockGoodsPacking == false) {
						
						//싱글톤 제품포장이 사용중이 아니라면
						if (singletonSettings.useGoodsPacking == false) {
							//제품 포장을 진행할 테니 포장시스템 사용중이라고 변경
							singletonSettings.useGoodsPacking = true;
							
							// 분할수량 목록
							JSONParser jsonParser = new JSONParser();
							JSONArray dataArray = (JSONArray) jsonParser.parse(jsonArray);
							List<GoodsProductInfoAdmVo> tempBoxList = new ArrayList<>();
							JSONObject jsonObj = new JSONObject();
					        for(int i=0;i<dataArray.size();i++) {
					        	jsonObj.put(i, dataArray.get(i));
					    		JSONObject jsonObject = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
					    		
					    		GoodsProductInfoAdmVo tempBoxVo = new GoodsProductInfoAdmVo();
					    		tempBoxVo.setBoxNo("");
					    		tempBoxVo.setTempBoxNo(jsonObject.get("tempBoxNo").toString());
					    		tempBoxVo.setDivisionCnt(Integer.parseInt(jsonObject.get("divisionCnt").toString()));
					    		tempBoxList.add(tempBoxVo);
					        }
							
							//분할박스 생성
							GoodsProductInfoAdmVo selBoxNo = new GoodsProductInfoAdmVo();
							ProductionPerfTrayVo sudel = new ProductionPerfTrayVo();
							String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
							
							
							sudel.setFactoryCode(factoryCode);
							sudel.setProductDate(factoryCode.equals("003") ? packDate.substring(2) : packDate);
							//sudel.setEquipCd(readGoodsProductInfoList.get(0).getEquipCd());
							 
							
							selBoxNo.setBoxNo(packDate);
							String matrlLotNo	= null;
							String filmLotNo	= null;
							String locationCd	= readGoodsProductInfoList.get(0).getLocationCd();
							
							//트레이 적용 전 양식 -> 20220914-0001
							if (goodsProductInfoAdmVo.getBoxNo().length() == 13) {
								int boxNo_index = goodsPackService.selectGoodsPackSeqCd(selBoxNo);
								for(int i=0;i<tempBoxList.size();i++) {
									tempBoxList.get(i).setBoxNo(packDate.concat("-").concat(String.format("%04d", boxNo_index+i)));
								}
							//트레이 적용 후 양식 -> 20220914-0001-1
							} else if (goodsProductInfoAdmVo.getBoxNo().length() == 15) {
								//MATRL_LOT_NO, FILM_LOT_NO 정보를 넣어주기 위해 읽어옴 
								readGoodsProductInfoByTray = goodsPackService.readGoodsProductInfo(readGoodsProductInfoByTray);
								matrlLotNo = readGoodsProductInfoByTray.getMatrlLotNo();
								filmLotNo = readGoodsProductInfoByTray.getFilmLotNo();
								
								sudel = productionPerfTrayService.goodsBoxNoTrayLabelSeq(sudel);
								String labelSeqNumber	= sudel.getBoxNo();
								
								for(int i=0;i<tempBoxList.size();i++) {
									tempBoxList.get(i).setBoxNo(packDate + "-" + labelSeqNumber + "-" + Integer.toString(i+1));
								}
								locationCd = readGoodsProductInfoByTray.getLocationCd();
							
							//3공장 트레이 채번 기준 적용 후 양식 -> DV01AAL-D221030Y01
							} else if(goodsProductInfoAdmVo.getBoxNo().length() == 18) {
								
								sudel = productionPerfTrayService.goodsBoxNoTrayLabelSeq(sudel);		//시퀀스
								String labelSeqNumber	= sudel.getBoxNo();								//시퀀스
								
								String[] exBoXNo = new String[3];
								exBoXNo[0] = goodsProductInfoAdmVo.getBoxNo();
								exBoXNo[1] = exBoXNo[0].substring( 0, exBoXNo[0].indexOf("-")+2 );							//가지고 가야하는 기존 번호 (DV01AAL-D)
								exBoXNo[2] = exBoXNo[0].substring( exBoXNo[0].indexOf('-')+2 ).substring(6).substring(0,1);	//가지고 가야하는 기존 주야 구분 부분 (D or N)
								
								
								for(int i=0;i<tempBoxList.size();i++) {
									
									String sudelNum = "";
									if(factoryCode.equals("003")) {
										sudelNum = (Integer.parseInt(labelSeqNumber)+i > 9) ? Integer.toString(Integer.parseInt(labelSeqNumber)+i) : "0" + Integer.toString(Integer.parseInt(labelSeqNumber)+i);
									} else {
										sudelNum = Integer.toString(Integer.parseInt(labelSeqNumber)+i);
									}
									
									tempBoxList.get(i).setBoxNo(exBoXNo[1] + packDate.substring(2) + "Y" + sudelNum);
									//tempBoxList.get(i).setBoxNo(exBoXNo[1] + packDate.substring(2) + exBoXNo[2] + Integer.toString(Integer.parseInt(labelSeqNumber)+i));
								}
							}
							
							List<GoodsProductInfoAdmVo> selBoxNoList = new ArrayList<>();
							
							for(int j=0;j<tempBoxList.size();j++) {
								GoodsProductInfoAdmVo selBoxNoEmpty = new GoodsProductInfoAdmVo();
								selBoxNoEmpty.setBoxNo(tempBoxList.get(j).getBoxNo());
								selBoxNoEmpty.setSelBoxNo1(goodsProductInfoAdmVo.getBoxNo());
								selBoxNoEmpty.setMergeYn("D");
								selBoxNoEmpty.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
								selBoxNoEmpty.setOrdGubun(goodsProductInfoAdmVo.getOrdGubun());
								//selBoxNoEmpty.setPackCnt(goodsProductInfoAdmVo.getPackCnt());
								selBoxNoEmpty.setPackCnt(tempBoxList.get(j).getDivisionCnt());
								selBoxNoEmpty.setRemainCnt(tempBoxList.get(j).getDivisionCnt());
								
								if( factoryCode.equals("001") || factoryCode.equals("002") ) {
									selBoxNoEmpty.setGoodsStatus("001");	
								} else {
									selBoxNoEmpty.setGoodsStatus("002");	//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
									//selBoxNoEmpty.setLocationCd(locationCd);//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
								}
								
								//selBoxNoEmpty.setGoodsStatus("001");
								//selBoxNoEmpty.setGoodsStatus("002");	//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
								//selBoxNoEmpty.setLocationCd(locationCd);//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
								
								selBoxNoEmpty.setFaultyStatus("001");
								selBoxNoEmpty.setDisuseYn("N");
								selBoxNoEmpty.setDivisionYn("N");
								selBoxNoEmpty.setMatrlLotNo(matrlLotNo);
								selBoxNoEmpty.setFilmLotNo(filmLotNo);
								selBoxNoEmpty.setRegId(Utils.getUserId());
								selBoxNoEmpty.setHistId(Utils.getUserId());
								
								selBoxNoList.add(selBoxNoEmpty);
							}
							
							jsonData.put("orignalBoxNo", selBoxNoList.get(0));
							
							for(int k=0;k<selBoxNoList.size();k++) {
								goodsPackService.createDivisionBoxNo(selBoxNoList.get(k));
							}
							
							
							//제품 포장을 진행할 테니 포장시스템 미사용으로 변경
							singletonSettings.useGoodsPacking = false;
							
							for(int l=0;l<selBoxNoList.size();l++) {
								goodsPackService.insertGoodsProductHist(selBoxNoList.get(l));						//생산제품 상태변경 기록
								//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
								StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
								createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(selBoxNoList.get(l).getGoodsCd(), selBoxNoList.get(l).getBoxNo(), "002", "I", "007", selBoxNoList.get(l).getPackCnt(), factoryCode);	
								stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);
								
								if(factoryCode.equals("003" )) {
									//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
									StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
									goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(selBoxNoList.get(l).getGoodsCd(), selBoxNoList.get(l).getBoxNo(), "002", "O", "007", selBoxNoList.get(l).getPackCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(goodsPackMinus); //기존 재고 -
									
									StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
									goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(selBoxNoList.get(l).getGoodsCd(), selBoxNoList.get(l).getBoxNo(), "002", "I", "008", selBoxNoList.get(l).getPackCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(goodsLocationIn); //새 위치 재고 +
								}
							}
							
							//원장 분할여부 Y로 Update
							goodsProductInfoAdmVo.setDivisionYn("D");
							goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
							goodsProductInfoAdmVo.setHistId(Utils.getUserId());
							goodsPackService.updateGoodsInfoAdmDivision(goodsProductInfoAdmVo);
							goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo orignalDivisionBoxNoMinus = new StockPaymentAdmVo();
							orignalDivisionBoxNoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmVo.getGoodsCd(), goodsProductInfoAdmVo.getBoxNo(), "002", "O", "008", goodsProductInfoAdmVo.getPackCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(orignalDivisionBoxNoMinus);
							
							
							
							//원장 분할유무 
							jsonData.put("divisionBoxNo", tempBoxList);
							jsonData.put("message", "분할되었습니다.");
							jsonData.put("result", "ok");
							
						}
					}

				} else {
					jsonData.put("message", "해당 포장번호의 제품정보가 변경되었습니다.<br>포장번호를 다시 선택해 주세요!");
					jsonData.put("result", "fail");
				}
			}

		} catch (Exception e) {
			logger.info("제품 포장 분할 수행");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품 병합 포장 수행
	@RequestMapping(value = "po/createMergeBoxNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMergeBoxNo(@RequestBody List<Map<String, Object>> boxNoList) throws Exception {
		logger.info("제품 병합 포장 수행 - " + boxNoList);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = new ArrayList<>(); // 병합할 포장번호 목록
		for (Map<String, Object> m : boxNoList) {
			GoodsProductInfoAdmVo getGoodsProductInfoEmpty = new GoodsProductInfoAdmVo();
			getGoodsProductInfoEmpty.setBoxNo(m.get("boxNo").toString());
			getGoodsProductInfoEmpty.setGoodsCd(m.get("goodsCd").toString());
			getGoodsProductInfoEmpty.setPackCnt(Integer.parseInt(m.get("packCnt").toString()));
			getGoodsProductInfoEmpty.setRemainCnt(Integer.parseInt(m.get("remainCnt").toString()));
			getGoodsProductInfoEmpty.setMergeCnt(Integer.parseInt(m.get("mergeCnt").toString()));
			getGoodsProductInfoEmpty.setOrdGubun(m.get("ordGubun").toString());
			getGoodsProductInfoEmpty.setChangeOrdGubun(m.get("changeOrdGubun").toString());
			GoodsProductInfoAdmVoList.add(getGoodsProductInfoEmpty);
		}
		
		try {
			List<GoodsProductInfoAdmVo> readGoodsProductInfoList = new ArrayList<>(); // 제품 분할&병합 포장 가능 여부 확인 목록
			boolean status = true;
			for(int i=0;i<GoodsProductInfoAdmVoList.size();i++) {
				readGoodsProductInfoList.add(goodsPackService.divisionBoxNoListCheck(GoodsProductInfoAdmVoList.get(i)).get(0));
				//병합1 존재 여부 확인 
				if (readGoodsProductInfoList.size() == 0) {
					jsonData.put("message", GoodsProductInfoAdmVoList.get(i).getBoxNo() + " - 존재하지 않거나 분할&병합 불가능한 제품번호 입니다.<br>제품번호를 확인해 주세요!");
					jsonData.put("result", "fail");
					status = false;
					break;
				//병합1 폐기 유무 확인
				} else if ("Y".equals(readGoodsProductInfoList.get(i).getDisuseYn())) {
					jsonData.put("message", GoodsProductInfoAdmVoList.get(i).getBoxNo() + " - 폐기된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
					jsonData.put("result", "fail");
					status = false;
					break;
				//병합1 분할 유무 확인
				} else if ("D".equals(readGoodsProductInfoList.get(i).getDivisionYn())) {
					jsonData.put("message", GoodsProductInfoAdmVoList.get(i).getBoxNo() + " - 이미 분할된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
					jsonData.put("result", "fail");
					status = false;
					break;
				//병합1 병합 유무 확인
				} else if ("M".equals(readGoodsProductInfoList.get(i).getDivisionYn())) {
					jsonData.put("message", GoodsProductInfoAdmVoList.get(i).getBoxNo() + " - 이미 병합된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
					jsonData.put("result", "fail");
					status = false;
					break;
				} else if ( !(GoodsProductInfoAdmVoList.get(i).getGoodsCd().equals(readGoodsProductInfoList.get(i).getGoodsCd()) &&
							  GoodsProductInfoAdmVoList.get(i).getOrdGubun().equals(readGoodsProductInfoList.get(i).getOrdGubun()) &&
							  GoodsProductInfoAdmVoList.get(i).getPackCnt() == (readGoodsProductInfoList.get(i).getPackCnt()) &&
							  GoodsProductInfoAdmVoList.get(i).getRemainCnt() == (readGoodsProductInfoList.get(i).getRemainCnt())) ) {
					jsonData.put("message", GoodsProductInfoAdmVoList.get(i).getBoxNo() + "의 제품정보가 변경되었습니다.<br>포장번호를 다시 선택해 주세요!");
					jsonData.put("result", "fail");
					status = false;
					break;
				}
			}
			
			//제품 정보 일치 확인
			if(status) {
				//싱글톤 포장 실행
				Settings singletonSettings = Settings.getInstance();
				
				//제품포장 기능 Lock O
				if (singletonSettings.lockGoodsPacking == true) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("001");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;
					
				//제품포장 기능 Lock X
				} else if (singletonSettings.lockGoodsPacking == false) {
					
					//싱글톤 제품포장이 사용중이 아니라면
					if (singletonSettings.useGoodsPacking == false) {
						//제품 포장을 진행할 테니 포장시스템 사용중이라고 변경
						singletonSettings.useGoodsPacking = true;
							
						//병합 박스정보 생성
						GoodsProductInfoAdmVo mergeBoxNoAdm = new GoodsProductInfoAdmVo();
						String packDate1 = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
						mergeBoxNoAdm.setBoxNo(packDate1);
						
						String mergeBoxNo = null;
						String matrlLotNo = null;
						String filmLotNo = null;
						String locationCd = GoodsProductInfoAdmVoList.get(0).getLocationCd();
								
						//트레이 적용 전 양식 -> 20220914-0001
						/*if (GoodsProductInfoAdmVoList.get(0).getBoxNo().length() == 13) {
							mergeBoxNo = packDate1.concat("-").concat(String.format("%04d", goodsPackService.selectGoodsPackSeqCd(mergeBoxNoAdm)));
							
						//트레이 적용 후 양식 -> 20220914-0001-1
						} else*/
						if (GoodsProductInfoAdmVoList.get(0).getBoxNo().length() == 13 || GoodsProductInfoAdmVoList.get(0).getBoxNo().length() == 15) {
							//MATRL_LOT_NO, FILM_LOT_NO 정보를 넣어주기 위해 읽어옴 
							for(int j=0;j<GoodsProductInfoAdmVoList.size();j++) {
								GoodsProductInfoAdmVo readGoodsProductInfoByTray = new GoodsProductInfoAdmVo();
								readGoodsProductInfoByTray.setBoxNo(GoodsProductInfoAdmVoList.get(j).getBoxNo());
								readGoodsProductInfoByTray = goodsPackService.readGoodsProductInfo(readGoodsProductInfoByTray);
								if(j==0) {
									matrlLotNo = readGoodsProductInfoByTray.getMatrlLotNo();
									filmLotNo = readGoodsProductInfoByTray.getFilmLotNo();
								} else {
									matrlLotNo = matrlLotNo + "/" + readGoodsProductInfoByTray.getMatrlLotNo();
									filmLotNo = filmLotNo + "/" + readGoodsProductInfoByTray.getFilmLotNo();
								}
								
								locationCd = readGoodsProductInfoByTray.getLocationCd();
							}
							
							
							ProductionPerfTrayVo sudel = new ProductionPerfTrayVo();
							sudel.setProductDate(packDate1);
							sudel.setFactoryCode(factoryCode);
							sudel = productionPerfTrayService.goodsBoxNoTrayLabelSeq(sudel);
							String labelSeqNumber	= sudel.getBoxNo();
							mergeBoxNo = packDate1 + "-" + labelSeqNumber + "-1";
							
							//boxNo2 = packDate1 + "-" + labelSeqNumber + "-2";
						} else if(GoodsProductInfoAdmVoList.get(0).getBoxNo().length() == 18) {
							
							ProductionPerfTrayVo sudel = new ProductionPerfTrayVo();
							sudel.setFactoryCode(factoryCode);
							sudel.setProductDate(factoryCode.equals("003") ? packDate1.substring(2) : packDate1);
							//sudel.setEquipCd(readGoodsProductInfoList.get(0).getEquipCd());
							sudel = productionPerfTrayService.goodsBoxNoTrayLabelSeq(sudel);	//시퀀스
							
							String labelSeqNumber	= sudel.getBoxNo();							//시퀀스
							String[] exBoXNo		= new String[3];
							String subEquipNm		= GoodsProductInfoAdmVoList.get(0).getBoxNo().substring(0,2);
							
							exBoXNo[0] = GoodsProductInfoAdmVoList.get(0).getBoxNo();
							exBoXNo[1] = exBoXNo[0].substring( 5, exBoXNo[0].indexOf("-")+2 );							//가지고 가야하는 기존 번호 (AL-D)
							exBoXNo[2] = exBoXNo[0].substring( exBoXNo[0].indexOf('-')+2 ).substring(6).substring(0,1);	//가지고 가야하는 기존 주야 구분 부분 (D or N)
							
							//DV00A(default)AL-D221102Y(default)01
							//mergeBoxNo = "DV00A" + exBoXNo[1] + packDate1.substring(2) + "Y" + labelSeqNumber;
							mergeBoxNo = subEquipNm + "00A" + exBoXNo[1] + packDate1.substring(2) + "Y" + labelSeqNumber;
						}
						
						String boxNoConcat = "";
						int packCnt = 0;
						for(int k=0;k<GoodsProductInfoAdmVoList.size();k++) {
							boxNoConcat = boxNoConcat + GoodsProductInfoAdmVoList.get(k).getBoxNo() + "/";
							packCnt = packCnt + GoodsProductInfoAdmVoList.get(k).getMergeCnt();
						}
						
						mergeBoxNoAdm.setBoxNo(mergeBoxNo);
						mergeBoxNoAdm.setSelBoxNo1("");
						mergeBoxNoAdm.setSelBoxNo2(boxNoConcat);
						mergeBoxNoAdm.setMergeYn("M");
						mergeBoxNoAdm.setGoodsCd(GoodsProductInfoAdmVoList.get(0).getGoodsCd());
						if( factoryCode.equals("002") || factoryCode.equals("003") ) {
							mergeBoxNoAdm.setOrdGubun(GoodsProductInfoAdmVoList.get(0).getOrdGubun());
						} else {
							mergeBoxNoAdm.setOrdGubun(GoodsProductInfoAdmVoList.get(0).getChangeOrdGubun());
						}
						//mergeBoxNoAdm.setPackCnt(GoodsProductInfoAdmVoList.get(0).getPackCnt());
						mergeBoxNoAdm.setPackCnt(packCnt);
						mergeBoxNoAdm.setRemainCnt(packCnt);
						
						if( factoryCode.equals("001") || factoryCode.equals("002") ) {
							mergeBoxNoAdm.setGoodsStatus("001");	
						} else {
							mergeBoxNoAdm.setGoodsStatus("002");	//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
							mergeBoxNoAdm.setLocationCd(locationCd);//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
						}
						
						//mergeBoxNoAdm.setGoodsStatus("001");
						//mergeBoxNoAdm.setGoodsStatus("002");	//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
						//mergeBoxNoAdm.setLocationCd(locationCd);//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
						
						mergeBoxNoAdm.setFaultyStatus("001");
						mergeBoxNoAdm.setDisuseYn("N");
						mergeBoxNoAdm.setDivisionYn("N");
						mergeBoxNoAdm.setMatrlLotNo(matrlLotNo);
						mergeBoxNoAdm.setFilmLotNo(filmLotNo);
						mergeBoxNoAdm.setRegId(Utils.getUserId());
						mergeBoxNoAdm.setHistId(Utils.getUserId());
						jsonData.put("data", mergeBoxNoAdm);
						goodsPackService.createDivisionBoxNo(mergeBoxNoAdm);

						//제품 포장을 진행할 테니 포장시스템 사용중 해제
						singletonSettings.useGoodsPacking = false;
						
						goodsPackService.insertGoodsProductHist(mergeBoxNoAdm);					//생산제품 상태변경 기록
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo orignalMergeBoxNoPlus = new StockPaymentAdmVo();
						orignalMergeBoxNoPlus = StockPaymentAdmController.goodsStockPaymentHist(mergeBoxNoAdm.getGoodsCd(), mergeBoxNoAdm.getBoxNo(), "002", "I", "007", mergeBoxNoAdm.getPackCnt(), factoryCode);	
						stockPaymentAdmService.stockPaymentPlus(orignalMergeBoxNoPlus);
						
						if(factoryCode.equals("003" )) {
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
							goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(mergeBoxNoAdm.getGoodsCd(), mergeBoxNoAdm.getBoxNo(), "002", "O", "007", mergeBoxNoAdm.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(goodsPackMinus); //기존 재고 -
							
							StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
							goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(mergeBoxNoAdm.getGoodsCd(), mergeBoxNoAdm.getBoxNo(), "002", "I", "008", mergeBoxNoAdm.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(goodsLocationIn); //새 위치 재고 +
						}
						
						//병합한 포장번호들 병합여부 M으로 Update
						for(int l=0;l<GoodsProductInfoAdmVoList.size();l++) {
							GoodsProductInfoAdmVoList.get(l).setDivisionYn("M");
							GoodsProductInfoAdmVoList.get(l).setUpdId(Utils.getUserId());
							GoodsProductInfoAdmVoList.get(l).setHistId(Utils.getUserId());
							goodsPackService.updateGoodsInfoAdmDivision(GoodsProductInfoAdmVoList.get(l));
							goodsPackService.insertGoodsProductHist(GoodsProductInfoAdmVoList.get(l));			//생산제품 상태변경 기록
							
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo mergeBox1 = new StockPaymentAdmVo();
							mergeBox1 = StockPaymentAdmController.goodsStockPaymentHist(GoodsProductInfoAdmVoList.get(l).getGoodsCd(),
																						GoodsProductInfoAdmVoList.get(l).getBoxNo(),
																						"002", "O", "008",
																						GoodsProductInfoAdmVoList.get(l).getPackCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(mergeBox1);
						}
						
						//병합한 포장번호중 잔여수량과 병합수량이 다를 경우 잔여수량에서 병합수량을 뺀 수량을 분할상태로 신규채번
						for(int m=0;m<GoodsProductInfoAdmVoList.size();m++) {
							int remainCnt = GoodsProductInfoAdmVoList.get(m).getRemainCnt(); // 잔여수량
							int mergeCnt = GoodsProductInfoAdmVoList.get(m).getMergeCnt(); // 병합수량
							int diffCnt = remainCnt - mergeCnt;
							if(remainCnt != mergeCnt) { // 잔여수량과 병합수량이 다를 경우
								String matrlLotNo_div = "";
								String filmLotNo_div = "";
								GoodsProductInfoAdmVo goodsProductInfoAdmAddVo = new GoodsProductInfoAdmVo();
								String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
								goodsProductInfoAdmAddVo.setBoxNo(packDate1);
								
								ProductionPerfTrayVo sudel = new ProductionPerfTrayVo();
								sudel.setFactoryCode(factoryCode);
								sudel.setProductDate(factoryCode.equals("003") ? packDate1.substring(2) : packDate1);
								sudel.setEquipCd(readGoodsProductInfoList.get(0).getEquipCd());
								
								String boxNo = "";
								//트레이 적용 전 양식 -> 20220914-0001
								if (GoodsProductInfoAdmVoList.get(m).getBoxNo().length() == 13) {
									boxNo = packDate1.concat("-").concat(String.format("%04d", goodsPackService.selectGoodsPackSeqCd(GoodsProductInfoAdmVoList.get(m))));
									
								//트레이 적용 후 양식 -> 20220914-0001-1
								} else if (GoodsProductInfoAdmVoList.get(m).getBoxNo().length() == 15) {
									//MATRL_LOT_NO, FILM_LOT_NO 정보를 넣어주기 위해 읽어옴
									GoodsProductInfoAdmVo readGoodsProductInfoByTray = new GoodsProductInfoAdmVo();
									readGoodsProductInfoByTray.setBoxNo(GoodsProductInfoAdmVoList.get(m).getBoxNo());
									readGoodsProductInfoByTray = goodsPackService.readGoodsProductInfo(readGoodsProductInfoByTray);
									matrlLotNo_div = readGoodsProductInfoByTray.getMatrlLotNo();
									filmLotNo_div = readGoodsProductInfoByTray.getFilmLotNo();
									
									
									sudel = productionPerfTrayService.productionPerfTrayLabelSeq(sudel);
									String labelSeqNumber	= sudel.getBoxNo();
									boxNo = packDate + "-" + labelSeqNumber + "-1";
									locationCd = readGoodsProductInfoByTray.getLocationCd();
								
								//3공장 트레이 채번 기준 적용 후 양식 -> DV01AAL-D221030D01
								} else if(GoodsProductInfoAdmVoList.get(m).getBoxNo().length() == 18) {
									
									sudel = productionPerfTrayService.productionPerfTrayLabelSeq(sudel);	//시퀀스
									String labelSeqNumber	= sudel.getBoxNo();								//시퀀스
									
									String[] exBoXNo = new String[3];
									exBoXNo[0] = GoodsProductInfoAdmVoList.get(m).getBoxNo();
									
									exBoXNo[1] = exBoXNo[0].substring( 0, exBoXNo[0].indexOf("-")+2 );							//가지고 가야하는 기존 번호 (DV01AAL-D)
									exBoXNo[2] = exBoXNo[0].substring( exBoXNo[0].indexOf('-')+2 ).substring(6).substring(0,1);	//가지고 가야하는 기존 주야 구분 부분 (D or N)
									
									boxNo = exBoXNo[1] + packDate1.substring(2) + exBoXNo[2] + labelSeqNumber;
								}
								
								goodsProductInfoAdmAddVo.setBoxNo(boxNo);
								goodsProductInfoAdmAddVo.setSelBoxNo1(GoodsProductInfoAdmVoList.get(m).getBoxNo());
								goodsProductInfoAdmAddVo.setMergeYn("D");
								goodsProductInfoAdmAddVo.setGoodsCd(GoodsProductInfoAdmVoList.get(m).getGoodsCd());
								
								if( factoryCode.equals("002") || factoryCode.equals("003") ) {
									goodsProductInfoAdmAddVo.setOrdGubun(GoodsProductInfoAdmVoList.get(m).getOrdGubun());
								} else {
									goodsProductInfoAdmAddVo.setOrdGubun(GoodsProductInfoAdmVoList.get(m).getChangeOrdGubun());
								}
								
								//goodsProductInfoAdmAddVo.setPackCnt(goodsProductInfoAdmVo.getPackCnt());
								goodsProductInfoAdmAddVo.setPackCnt(diffCnt);
								goodsProductInfoAdmAddVo.setRemainCnt(diffCnt);
								
								if( factoryCode.equals("001") || factoryCode.equals("002") ) {
									goodsProductInfoAdmAddVo.setGoodsStatus("001");	
								} else {
									goodsProductInfoAdmAddVo.setGoodsStatus("002");	//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
									//goodsProductInfoAdmAddVo.setLocationCd(locationCd);//트레이 로직으로 변경 후 분할&병합 시 입고상태로 생성
								}

								goodsProductInfoAdmAddVo.setFaultyStatus("001");
								goodsProductInfoAdmAddVo.setDisuseYn("N");
								goodsProductInfoAdmAddVo.setDivisionYn("N");
								goodsProductInfoAdmAddVo.setMatrlLotNo(matrlLotNo_div);
								goodsProductInfoAdmAddVo.setFilmLotNo(filmLotNo_div);
								goodsProductInfoAdmAddVo.setRegId(Utils.getUserId());
								goodsProductInfoAdmAddVo.setHistId(Utils.getUserId());
								
								jsonData.put("orignalBoxNo", goodsProductInfoAdmAddVo);
								goodsPackService.createDivisionBoxNo(goodsProductInfoAdmAddVo);

								//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
								StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
								createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmAddVo.getGoodsCd(), goodsProductInfoAdmAddVo.getBoxNo(), "002", "I", "007", goodsProductInfoAdmAddVo.getPackCnt(), factoryCode);	
								stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);

								if(factoryCode.equals("003" )) {
									//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
									StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
									goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmAddVo.getGoodsCd(), goodsProductInfoAdmAddVo.getBoxNo(), "002", "O", "007", goodsProductInfoAdmAddVo.getPackCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(goodsPackMinus); //기존 재고 -
									
									StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
									goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmAddVo.getGoodsCd(), goodsProductInfoAdmAddVo.getBoxNo(), "002", "I", "008", goodsProductInfoAdmAddVo.getPackCnt(), factoryCode);
									stockPaymentAdmService.stockPaymentPlus(goodsLocationIn); //새 위치 재고 +
								}
							}
						}
						
						//원장 분할유무 
						jsonData.put("divisionBoxNo", mergeBoxNoAdm);
						jsonData.put("message", "병합되었습니다.");
						jsonData.put("result", "ok");
						
					}
				}
			}

		} catch (Exception e) {
			logger.info("제품 포장 분할 수행");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
		
	//생산실적 분할 포장 인쇄1(분할 인쇄1 divisionPrint1)
	//@RequestMapping(value = "/po/divisionPrint", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> divisionPrint(GoodsProductInfoAdmVo goodsProductDivision) throws Exception {
    //
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	Map<String, Object> printJsonData = new HashMap<String, Object>();
	//	logger.info("분할 BoxNo : " + goodsProductDivision.getBoxNo() + " 선택 위치 : " + goodsProductDivision.getChoosePrintLocation());
	//	try {
	//		//전달받은 분할 BoxNo로 분할박스 정보 조회
	//		String divisionBoxNo = goodsProductDivision.getBoxNo();
	//		String choosePrintLocation = goodsProductDivision.getChoosePrintLocation();
	//		goodsProductDivision = goodsPackService.readDivisionBoxNo(goodsProductDivision);
	//		//String originalBoxNo = goodsProductDivision.getOrignalBoxNo();
    //
	//		//분할 박스 정보의 Orignal BoxNo로 원장정보 조회
	//		GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
	//		//readOrignalBoxNoVo.setBoxNo(originalBoxNo);
	//		readOrignalBoxNoVo = goodsPackService.readGoodsProductInfo(readOrignalBoxNoVo);
    //
	//		//제품 폐기 여부 확인(리로드가 되지 않아 폐기된제품을 인쇄선택시 예외사항처리)
	//		if ("Y".equals(readOrignalBoxNoVo.getDisuseYn())) {
	//			//jsonData.put("message", originalBoxNo + " - 폐기된 제품입니다.");
	//			jsonData.put("result", "fail");
    //
	//			return jsonData;
    //
	//		} else {
	//			//제품정보 읽기
	//			logger.info("생산실적 라벨발행 프린트(스티커인쇄2)" + readOrignalBoxNoVo);
	//			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
	//			goodsCodeAdmVo.setGoodsCd(readOrignalBoxNoVo.getGoodsCd());
	//			goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
	//			//String packUnitNm = null;
	//			//packUnitNm = goodsCodeAdmVo.getPackUnitNm();
	//			String IP = null;
    //
	//			//제품의 포함된 작지번호 최대 3개까지읽기
	//			List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInWorkOrdNo(readOrignalBoxNoVo);
	//			int j = 0;
	//			String ordLotNo1 = "①";
	//			String ordLotNo2 = "②";
	//			String ordLotNo3 = "③";
    //
	//			int tempDivison = 0;
	//			float stepAverage = 0;
	//			//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
	//			for (GoodsProductInfoAdmVo i : GoodsProductInfoAdmVoList) {
	//				if (0 == i.getPackDtlCnt()) {
	//					//아무것도 안함.
	//				} else {
	//					if (j > 2) {
	//						break;
	//					}
	//					//첫번째 작지만 평균 계산
	//					if (j == 0) {
    //
	//						WorkOrderVo workOrderVo1 = new WorkOrderVo();
	//						workOrderVo1.setWorkOrdNo(i.getWorkOrdNo());
	//						workOrderVo1 = workOrderService.read(workOrderVo1);
	//						ordLotNo1 += workOrderVo1.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
	//						//초,중물 검색
	//						EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
	//						firstEquipSizeCondStepVo.setWorkOrdNo(i.getWorkOrdNo());
	//						List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
    //
	//						//종물 검색
	//						EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
	//						thirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
	//						thirdEquipSizeCondStep.setStepCd("003");
    //
	//						//종물 등록 확인
	//						thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(thirdEquipSizeCondStep);
    //
	//						//종물 을 입력하지 않은 제품번호에서 중지
	//						if (thirdEquipSizeCondStep.getCount() == 0) {
	//							//jsonData.put("message", "작지번호 : " + i.getWorkOrdNo() + "<br> BoxNo &nbsp&nbsp: " + originalBoxNo + "<br>종물을 입력해 주세요!");
	//							jsonData.put("result", "fail");
	//							return jsonData;
	//						}
    //
	//						thirdEquipSizeCondStep.setWorkOrdNo(i.getWorkOrdNo());
	//						thirdEquipSizeCondStep.setStepCd("003");
	//						thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);
    //
	//						//초,중,몰 WP(좌) + PP폭(좌) / 3 계산하여 소수점 3자리까지 표기
	//						float wpLeft1 = 0, wpLeft2 = 0, wpLeft3 = 0, ppLeft1 = 0, ppLeft2 = 0, ppLeft3 = 0;
    //
	//						//AGT 초,중물이 비어있는 경우
	//						if (EquipSizeCondStepList.isEmpty()) {
	//							wpLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
	//							ppLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
	//							tempDivison = 1;
    //
	//							//AGT 초 or 중물 하나만 있을 경우
	//						} else if (EquipSizeCondStepList.size() == 1) {
    //
	//							wpLeft1 = Float.parseFloat(EquipSizeCondStepList.get(0).getWpLeftAlwnce());
	//							ppLeft1 = Float.parseFloat(EquipSizeCondStepList.get(0).getPpfDepthLeftAlwnce());
	//							wpLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
	//							ppLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
	//							tempDivison = 2;
    //
	//							//초,중,종물이 모두 있는 경우
	//						} else {
	//							for (int step = 0; step < 3; step++) {
	//								if (step == 0) {
	//									wpLeft1 = Float.parseFloat(EquipSizeCondStepList.get(0).getWpLeftAlwnce());
	//									ppLeft1 = Float.parseFloat(EquipSizeCondStepList.get(0).getPpfDepthLeftAlwnce());
	//								} else if (step == 1) {
	//									wpLeft2 = Float.parseFloat(EquipSizeCondStepList.get(1).getWpLeftAlwnce());
	//									ppLeft2 = Float.parseFloat(EquipSizeCondStepList.get(1).getPpfDepthLeftAlwnce());
	//								} else if (step == 2) {
	//									wpLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
	//									ppLeft3 = Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
	//								}
	//							}
	//							tempDivison = 3;
	//						}
    //
	//						//System.out.println(tempDivison);
	//						stepAverage = (float) (Math.round(((wpLeft1 + wpLeft2 + wpLeft3 + ppLeft1 + ppLeft2 + ppLeft3) / tempDivison) * 10) / 10.0);
	//						logger.info(String.valueOf(stepAverage));
    //
	//					} else if (j == 1) {
	//						WorkOrderVo workOrderVo2 = new WorkOrderVo();
	//						workOrderVo2.setWorkOrdNo(i.getWorkOrdNo());
	//						workOrderVo2 = workOrderService.read(workOrderVo2);
	//						ordLotNo2 += workOrderVo2.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
	//					} else if (j == 2) {
	//						WorkOrderVo workOrderVo3 = new WorkOrderVo();
	//						workOrderVo3.setWorkOrdNo(i.getWorkOrdNo());
	//						workOrderVo3 = workOrderService.read(workOrderVo3);
	//						ordLotNo3 += workOrderVo3.getOrdLotNo() + "(" + i.getPackDtlCnt() + ")";
	//					}
	//					j++;
	//				}
	//			}
    //
	//			if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("A")) {
	//				if ("001".equals(choosePrintLocation)) {
	//					IP = IP3;
	//				} else if ("002".equals(choosePrintLocation)) {
	//					IP = IP5;
	//				}
    //
	//			} else if (goodsCodeAdmVo.getGoodsCd().toString().substring(0, 1).equals("N")) {
	//				if ("001".equals(choosePrintLocation)) {
	//					IP = IP4;
	//				} else if ("002".equals(choosePrintLocation)) {
	//					IP = IP6;
	//				}
	//			}
	//			logger.info("분할1 인쇄 프린터 주소 : " + IP);
    //
	//			readOrignalBoxNoVo.setBoxNo(divisionBoxNo);
	//			printJsonData = MtpLabel.barCodePrint(IP, PORT, readOrignalBoxNoVo, ordLotNo1, ordLotNo2, ordLotNo3, stepAverage, Integer.toString(goodsProductDivision.getPackCnt()));
	//			//라벨발행 시 printYn 업데이트
	//			if ("printSuccess".equals(printJsonData.get("printResult"))) {
	//				goodsProductDivision.setUpdId(Utils.getUserId());
	//				goodsProductDivision.setPrintYn("Y");
	//				goodsPackService.goodsDivisionPackPrintYnUpdate(goodsProductDivision);
	//				jsonData.put("result", "ok");
	//			} else {
	//				jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
	//				jsonData.put("result", "fail");
	//			}
	//		}
    //
	//	} catch (Exception e) {
	//		logger.info("분할1 인쇄 에러");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
    //
	//	return jsonData;
	//}
	
	
	//제품 분할 포장 분할 취소
	@RequestMapping(value = "po/divisionBoxNoCancle", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> divisionBoxNoCancle(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		logger.info("제품 포장 분할 취소 수행 - " + goodsProductInfoAdmVo);
		Map<String, Object> jsonData = new HashMap<String, Object>();

		try {
			GoodsProductInfoAdmVo readgoodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
			
			GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
			readGoodsProductInfo.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
			//제품 분할 포장 가능 여부 확인(작지 번호 가져오기)
			List<GoodsProductInfoAdmVo> readGoodsProductInfoList = goodsPackService.divisionBoxNoListCheck(goodsProductInfoAdmVo);
			
			//제품 존재 여부 확인
			if ( readgoodsProductInfoAdmVo == null ) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 존재하지 않거나 분할&병합 불가능한 제품번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");
			
			//혼합작지 여부 확인
			//} else if ( readGoodsProductInfoList.size() > 1 ) {
			//	jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 혼합 작지 제품은 분할 할 수 없습니다.<br>제품번호를 확인해 주세요!");
			//	jsonData.put("result", "fail");
				
			//폐기 유무 확인
			} else if ( "Y".equals(readGoodsProductInfoList.get(0).getDisuseYn()) )  {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 폐기된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");
			
			//분할 유무 확인
			} else if ( "Y".equals(readGoodsProductInfoList.get(0).getDivisionYn()) )  {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 이미 분할된 포장번호 입니다.<br>제품번호를 확인해 주세요!");
				jsonData.put("result", "fail");
				
			//제품 정보 일치 확인
			} else {
				//가져온 boxNo로 goodsCd, ordGubun 일치하는지 확인
				if ( goodsProductInfoAdmVo.getGoodsCd().equals(readgoodsProductInfoAdmVo.getGoodsCd()) &&
						goodsProductInfoAdmVo.getOrdGubun().equals(readgoodsProductInfoAdmVo.getOrdGubun()) &&
						goodsProductInfoAdmVo.getWorkOrdNo().equals(readGoodsProductInfoList.get(0).getWorkOrdNo()) ) {
						
						GoodsProductInfoAdmVo deleteDivisionBoxNo = new GoodsProductInfoAdmVo();
						//deleteDivisionBoxNo.setOrignalBoxNo(goodsProductInfoAdmVo.getBoxNo());
						//원장 BoxNo로 분할된 박스 List 조회
						//List<GoodsProductInfoAdmVo> readDivisionBoxList = goodsPackService.readDivisionBoxList(deleteDivisionBoxNo);
												
						//VO의 remainCnt INT여서 Remain이 null이면 0으로 조회됨 ->
						//제품상태가 001(포장) 이면서 remainCnt 가 0이 아니거나,
						//제품상태가 002(입고) 이면서 remainCnt 가 0이 아니면 출하된 상태임.
						//if ( !(readDivisionBoxList.get(0).getRemainCnt() == 0 && "001".equals(readDivisionBoxList.get(0).getGoodsStatus())) && 
						//	 !(readDivisionBoxList.get(0).getRemainCnt() == 0 && "002".equals(readDivisionBoxList.get(0).getGoodsStatus()))	) {
						//	jsonData.put("message", readDivisionBoxList.get(0).getBoxNo() + "가 이미 출하되어 분할 취소 할 수 없습니다!");
						//	jsonData.put("result", "fail");
						//	return jsonData;
						//} else if ( !(readDivisionBoxList.get(1).getRemainCnt() == 0 && "001".equals(readDivisionBoxList.get(0).getGoodsStatus())) && 
						//			!(readDivisionBoxList.get(1).getRemainCnt() == 0 && "002".equals(readDivisionBoxList.get(0).getGoodsStatus()))	) {
						//	jsonData.put("message", readDivisionBoxList.get(1).getBoxNo() + "가 이미 출하되어 분할 취소 할 수 없습니다!");
						//	jsonData.put("result", "fail");
						//	return jsonData;
						//}
						//분할 테이블 삭제 실행
						goodsPackService.deleveDivisionBoxNo(deleteDivisionBoxNo);
						
						//분할 완료시 원장 제품번호 분할여부 Y로 업데이트
						goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
						goodsProductInfoAdmVo.setDivisionYn("N");
						//goodsPackService.updateGoodsInfoAdmDivision(goodsProductInfoAdmVo);
						
						jsonData.put("message", "분할 취소되었습니다.");
						jsonData.put("result", "ok");
						
				} else {
					jsonData.put("message", "해당 포장번호의 제품정보가 변경되었습니다.<br>포장번호를 다시 선택해 주세요!");
					jsonData.put("result", "fail");
				}
			}
			
			
		} catch (Exception e) {
			logger.info("제품 포장 분할 수행 ");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//생산제품 분할/병합
	@RequestMapping(value = "/posc0080", method = RequestMethod.GET)
	public String posc0080(Locale locale, Model model) throws Exception {
		logger.info("생산제품 분할/병합");
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//오더구분 공통코드
		systemCommonCodeVo.setBaseGroupCd("018");
		List<SystemCommonCodeVo> ordGubun = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubun", ordGubun);
		
		model.addAttribute("goodsCode", goodsCodeDataList );
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "po/posc0080";
	}
	
	//생산제품 분할/병합
	@RequestMapping(value = "/posc3080", method = RequestMethod.GET)
	public String posc3080(Locale locale, Model model) throws Exception {
		logger.info("생산제품 분할/병합");
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//오더구분 공통코드
		systemCommonCodeVo.setBaseGroupCd("018");
		List<SystemCommonCodeVo> ordGubun = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubun", ordGubun);
		
		model.addAttribute("goodsCode", goodsCodeDataList );
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "po/posc3080";
	}
	
	//분할&병합 제품리스트 조회
	@RequestMapping(value = "/po/readDivisionGoodsPackList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readDivisionGoodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품포장 목록조회(해외1,해외2,국내)");
		try {
			List<GoodsProductInfoAdmVo> divisionGoodsProductInfoAdmList = goodsPackService.readDivisionGoodsPackList(goodsProductInfoAdmVo);
			jsonData.put("data", divisionGoodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("분할/병합 제품 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//분할&병합 제품리스트 조회
	@RequestMapping(value = "/po/divisionMergePrintTest", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> divisionMergePrintTest(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품포장 목록조회(해외1,해외2,국내)");
		try {
			
			if(!factoryCode.equals("003")) {
				goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				
				JSONArray jsonArrayData 	= new JSONArray();
				jsonArrayData.add( goodsProductInfoAdmVo.getGoodsNm() ); 		//제품 정보
				jsonArrayData.add( goodsProductInfoAdmVo.getPackCnt() );		//총 수량
				jsonArrayData.add( "-" ); 										//트레이 정보1
				jsonArrayData.add( "-" ); 										//트레이 정보2
				jsonArrayData.add( "-" ); 										//트레이 정보3
				jsonArrayData.add( "-" );		 								//BOX_NO
				jsonArrayData.add( goodsProductInfoAdmVo.getBoxNo() ); 			//라벨로트시퀀스
				
				jsonArrayData.add( goodsProductInfoAdmVo.getMatrlGubunNm()  ); 	//재질
				
				if ( goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("A") ){
					jsonArrayData.add( "Cathode Tab"  ); 	//제품 정보2
				} else if ( goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("N")){
	            	jsonArrayData.add( "Anode Tab"  ); 	//제품 정보2
	            }
				
				  //이미지 판단
				String image = "";   
				if(goodsProductInfoAdmVo.getGoodsNm().contains("DE/SK")) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				//HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("HE370")) {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("E370")) {
					//image = "{XQ;03,0,L|}";
					image = "04";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("H200")) {
					//image = "{XQ;09,0,L|}";
					image = "10";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("P260")) {
					//image = "{XQ;11,0,L|}";
					image = "12";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("P395")) {
					//image = "{XQ;13,0,L|}";
					image = "14";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("E556")) {
					//image = "{XQ;15,0,L|}";
					image = "16";
				}
				else if(goodsProductInfoAdmVo.getGoodsNm().contains("N60")) {
					//image = "{XQ;17,0,L|}";
					image = "18";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				jsonArrayData.add( image  ); 	//이미지 정보
				
				jsonData.put("data", jsonArrayData);
				jsonData.put("result", "ok");
				
			} else {
				
				//솔브레인
				goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				
				JSONArray jsonArrayData 	= new JSONArray();
				
				jsonArrayData.add( goodsProductInfoAdmVo.getBoxNo() ); 			//라벨로트시퀀스
				jsonArrayData.add( goodsProductInfoAdmVo.getGoodsNm() ); 		//제품 정보
				jsonArrayData.add( goodsProductInfoAdmVo.getMatrlGubunNm()  ); 	//재질
				jsonArrayData.add( goodsProductInfoAdmVo.getPackCnt() );		//총 수량
				
				//이미지 판단
				String image = "";
				
				//이미지 판단
				if("001".equals( goodsProductInfoAdmVo.getGijongCd() )) {
					image = "02";
				} else if("002".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "10";
				} else if("003".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "12";
				} else if("004".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "20";
				} else if("005".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "22";
				} else if("006".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "04";
				} else if("007".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "24";
				} else if("008".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "26";
				} else if("009".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "28";
				} else if("010".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "30";
				} else if("011".equals(goodsProductInfoAdmVo.getGijongCd())) {
					image = "32";
				} else {
					image = "99";
				}
				
				jsonArrayData.add( image  ); 	//이미지 정보
				
				jsonData.put("data", jsonArrayData);
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("분할/병합 제품 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//생산실적 분할&병합 포장 인쇄(분할&병합 인쇄)
	@RequestMapping(value = "/po/divisionMergePrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> divisionMergePrint(GoodsProductInfoAdmVo getGoodsProductInfo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		Map<String, Object> printJsonData = new HashMap<String, Object>();	//인쇄 결과(성공&실패)
		logger.info("인쇄 BoxNo : " + getGoodsProductInfo.getBoxNo());
		logger.info("인쇄 위치 : " + getGoodsProductInfo.getChoosePrintLocation());
		try {
			//선언 후 -1로 초기화
			int[] orignalBoxList = new int[9999];			//goodsTraceList 중 원장의 위치
			for (int kk=0; kk<9999; kk++) {
				orignalBoxList[kk] = -1;
			}
			
			GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
			readGoodsProductInfo.setBoxNo(getGoodsProductInfo.getBoxNo());
			readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
			//폐기된 제품 인쇄 불가
			if ("Y".equals(readGoodsProductInfo.getDisuseYn())) {
				jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 폐기된 제품입니다.");
				jsonData.put("result", "fail");
				return jsonData;

			//분할된 제품 인쇄 불가
			} else if ("D".equals(readGoodsProductInfo.getDivisionYn())) {
				jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 분할된 제품입니다.");
				jsonData.put("result", "fail");
				return jsonData;
			
			//병합된 제품 인쇄 불가
			} else if ("M".equals(readGoodsProductInfo.getDivisionYn())) {
				jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 병합된 제품입니다.");
				jsonData.put("result", "fail");
				return jsonData;
					
			//인쇄 가능한 정상제품
			//정상적으로 인쇄가 가능하다면 원장BoxNo 추적 후 해당 원장들의 작지번호 조회 및 초,중,종물 치수 계산
			} else {
				/* ------------------------------------------------------ 원장 추적 로직 시작 ------------------------------------------------------ */
				String[] goodsTraceList = new String[9999];		//검색해야하는 boxNo 목록들
				int orginalBoxIndex = 0;
				int i=1;	//?
				
				//최초포장번호의 부모들 기본세팅
				goodsTraceList[0] = readGoodsProductInfo.getSelBoxNo1();
				if (null != readGoodsProductInfo.getSelBoxNo2()) {
					goodsTraceList[1] = readGoodsProductInfo.getSelBoxNo2();
					i++;	//for문 좀 적게돌게 줄여주는 역할
				}
				
				//i = 추적하기위해 읽은 boxNo의 위치
				for (int j=0; j<9999; j++) {
					//추적배열의 해당위치가 비었다는것은 더이상 추적할 boxNo가 없다는 뜻임. 이후 orignalBoxList로 원장번호들을 찾아 초,중물 계산해주면됨(작지순서는 어케?)
					if (null == goodsTraceList[j]) {
						break;
					}
					
					GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
					readGoodsTrace.setBoxNo(goodsTraceList[j]);
					readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
					
					if ( null == readGoodsTrace.getSelBoxNo1() ) {
						logger.info("원장 번호 - " + readGoodsTrace.getBoxNo());	//selBoxNo1이 없다는건 원장이라는 뜻
						orignalBoxList[orginalBoxIndex] = j;					//원장 위치 저장
						orginalBoxIndex++;
					} else {
						//넣기 전 중복검사
						boolean distinctCheck = true;
						for (int jj=0; jj<9999; jj++) {
							if (null == goodsTraceList[jj]) {
								break;
							}
							if (readGoodsTrace.getSelBoxNo1().equals(goodsTraceList[jj])) {
								logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo1());
								distinctCheck = false;
							}
						}
						//selBoxNo1가 존재한다는건 원장이 아니라는뜻임
						//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
						if (distinctCheck) {
							int k=i;
							while (goodsTraceList[k]!=null) {
								k++;
							}
							goodsTraceList[k] = readGoodsTrace.getSelBoxNo1();
							i++;
						}
					}
					
					if (null==readGoodsTrace.getSelBoxNo2()) {
						//selBoxNo2가 없는거는 원장이랑 관련없음.
					
					
					} else {
						//넣기 전 중복검사
						boolean distinctCheck = true;
						for (int jj=0; jj<9999; jj++) {
							if (null == goodsTraceList[jj]) {
								break;
							}
							if (readGoodsTrace.getSelBoxNo2().equals(goodsTraceList[jj])) {
								logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo2());
								distinctCheck = false;
							}
						}
						//selBoxNo2가 존재한다는건 원장이 아니라는뜻임
						//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
						if (distinctCheck) {
							int k=i;
							while (goodsTraceList[k]!=null) {
								k++;
							}
							goodsTraceList[k] = readGoodsTrace.getSelBoxNo2();
							i++;
						}
					}
				}
				
				for (int kk=0; kk<9999; kk++) {
					if ( goodsTraceList[kk] != null) {
						logger.info("추적해야하는 boxNo 리스트 : " + kk + " - " + orignalBoxList[kk] );
					}
				}
				for (int kk=0; kk<9999; kk++) {
					if ( orignalBoxList[kk] != -1) {
						logger.info("원장 위치 : " + orignalBoxList[kk]);
						logger.info("원장 포장번호 : " + goodsTraceList[orignalBoxList[kk]]);
					}
				}
				/* ------------------------------------------------------ 원장 추적 로직 종료 ------------------------------------------------------ */
				List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoTotalList = new ArrayList<GoodsProductInfoAdmVo>();
				for (int kk=0; kk<9999; kk++) {
					if ( orignalBoxList[kk] != -1) {
						logger.info("원장 위치 - " + orignalBoxList[kk]);
						GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
						//원장번호를 찾아 작지검색
						readOrignalBoxNoVo.setBoxNo(goodsTraceList[orignalBoxList[kk]]);
						//List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(readOrignalBoxNoVo);
						readOrignalBoxNoVo.setFactoryCode(factoryCode);
						List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(readOrignalBoxNoVo);
						//읽어온 작지들을 차례대로 총 작지List에 넣어줌
						for (int o=0; o<readGoodsProductInfoAdmVoList.size(); o++) {
							GoodsProductInfoAdmVoTotalList.add(readGoodsProductInfoAdmVoList.get(o));
						}
					} else {
						break;
					}
				}
				
				for (int o=0; o<GoodsProductInfoAdmVoTotalList.size(); o++) {
					logger.info("해당 원장의 작지번호 : " + GoodsProductInfoAdmVoTotalList.get(o).toString());
				}
				
				//제품정보 읽기
				String IP = null;
				//제품의 포함된 작지번호 최대 3개까지읽기
				int j = 0;
				String ordLotNo1 = "①";
				String ordLotNo2 = "②";
				String ordLotNo3 = "③";
                
				int tempDivison = 0;
				float stepAverage = 0;
				//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
				for (GoodsProductInfoAdmVo ii : GoodsProductInfoAdmVoTotalList) {
					if (0 == ii.getPackDtlCnt()) {
						//아무것도 안함.
					} else {
						if (j > 2) {
							break;
						}
						//첫번째 작지만 평균 계산
						if (j == 0) {
                
							//WorkOrderVo workOrderVo1 = new WorkOrderVo();
							//workOrderVo1.setWorkOrdNo(ii.getWorkOrdNo());
							//workOrderVo1 = workOrderService.read(workOrderVo1);
							//WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
							//workOrdOutputSubVo.setWorkOrdNo(ii.getWorkOrdNo());
							//workOrdOutputSubVo.setOrdLotNo(ii.getOrdLotNo());
							//WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
							//ordLotNo1 += ii.getOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
							ordLotNo1 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
							
							//초,중물 검색
							EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
							firstEquipSizeCondStepVo.setWorkOrdNo(ii.getWorkOrdNo());
							firstEquipSizeCondStepVo.setLotNo(ii.getLotNo());
							List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
                
							//종물 등록 확인
							EquipSizeCondStepVo checkThirdEquipSizeCondStep = new EquipSizeCondStepVo();
							checkThirdEquipSizeCondStep.setWorkOrdNo(ii.getWorkOrdNo());
							//checkThirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
							checkThirdEquipSizeCondStep.setLotNo(ii.getLotNo());
							checkThirdEquipSizeCondStep.setStepCd("003");
							checkThirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(checkThirdEquipSizeCondStep);

							//종물 을 입력하지 않은 제품번호에서 중지
							if (checkThirdEquipSizeCondStep.getCount() == 0) {
								jsonData.put("message", "작지번호 : " + ii.getWorkOrdNo() + "<br> 주자재 : &nbsp&nbsp: " + ii.getLotNo() + "<br>종물을 입력해 주세요!");
								jsonData.put("result", "fail");
								return jsonData;
							}
							
							//종물 검색
							EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
							thirdEquipSizeCondStep.setWorkOrdNo(ii.getWorkOrdNo());
							//thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
							thirdEquipSizeCondStep.setLotNo(ii.getLotNo());
							thirdEquipSizeCondStep.setStepCd("003");
							thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);
                
							float stepSum = 0;
							//AGT 초,중물이 비어있는 경우
							if (EquipSizeCondStepList.isEmpty()) {
								stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
								stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
								tempDivison = 1;

							//AGT 초,중,종물 총개수
							} else {
								//초,중물 합
								for (int kk=0; kk<EquipSizeCondStepList.size(); kk++) {
									//초,중물 값이 0일경우 계산식에서 제외
									if (Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce()) != 0 && Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce()) != 0) {
										stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce());
										stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce());
										tempDivison++;
									}
								}
								//종물 합
								stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
								stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
								//초,중 + 종 = 총개수
								tempDivison++;
							}
							
							//소수점 2자리에서 반올림하여 1자리까지만 표시
							stepAverage = (float) (Math.round((stepSum / tempDivison) * 10) / 10.0);
							logger.info(String.valueOf(stepAverage));
                
						} else if (j == 1) {
							//WorkOrderVo workOrderVo2 = new WorkOrderVo();
							//workOrderVo2.setWorkOrdNo(ii.getWorkOrdNo());
							//workOrderVo2 = workOrderService.read(workOrderVo2);
							ordLotNo2 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
						} else if (j == 2) {
							//WorkOrderVo workOrderVo3 = new WorkOrderVo();
							//workOrderVo3.setWorkOrdNo(ii.getWorkOrdNo());
							//workOrderVo3 = workOrderService.read(workOrderVo3);
							ordLotNo3 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
						}
						j++;
					}
				}
                
				if (readGoodsProductInfo.getGoodsCd().toString().substring(0, 1).equals("A")) {
					if ("001".equals(getGoodsProductInfo.getChoosePrintLocation())) {
						IP = IP3;
					} else if ("002".equals(getGoodsProductInfo.getChoosePrintLocation())) {
						IP = IP5;
					}
                
				} else if (readGoodsProductInfo.getGoodsCd().toString().substring(0, 1).equals("N")) {
					if ("001".equals(getGoodsProductInfo.getChoosePrintLocation())) {
						IP = IP4;
					} else if ("002".equals(getGoodsProductInfo.getChoosePrintLocation())) {
						IP = IP6;
					}
				}
				logger.info("생산제품 분할/병합 제품 라벨인쇄 IP 주소 : " + IP);
                
				//readOrignalBoxNoVo.setBoxNo(readGoodsProductInfo.getBoxNo());
				printJsonData = MtpLabel.barCodePrint(IP, PORT, readGoodsProductInfo, ordLotNo1, ordLotNo2, ordLotNo3, stepAverage,
														Integer.toString(readGoodsProductInfo.getRemainCnt()), Integer.toString(GoodsProductInfoAdmVoTotalList.size()));
				//라벨발행 시 printYn 업데이트
				if ("printSuccess".equals(printJsonData.get("printResult"))) {
					readGoodsProductInfo.setUpdId(Utils.getUserId());
					readGoodsProductInfo.setPrintYn("Y");
					goodsPackService.goodsDivisionPackPrintYnUpdate(readGoodsProductInfo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
					jsonData.put("result", "fail");
				}
			}
			
		} catch (Exception e) {
			logger.info("분할1 인쇄 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 분할&병합 포장 인쇄(분할&병합 인쇄)
		@RequestMapping(value = "/po/divisionMergePrint_F3", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> divisionMergePrint_F3(HttpServletRequest request, GoodsProductInfoAdmVo getGoodsProductInfo) throws Exception {
			Map<String, Object> jsonData = new HashMap<String, Object>();
			Map<String, Object> printJsonData = new HashMap<String, Object>();	//인쇄 결과(성공&실패)
		    List<String[]> printList = new ArrayList<>();
		    HttpSession session = request.getSession(true);
			logger.info("인쇄 BoxNo : " + getGoodsProductInfo.getBoxNo());
			logger.info("인쇄 위치 : " + getGoodsProductInfo.getChoosePrintLocation());
			try {
				
				if (!"002".equals(session.getAttribute("factoryCode")) && !"003".equals(session.getAttribute("factoryCode"))) {
					jsonData.put("message", "잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!");
					jsonData.put("result", "error");
					return jsonData;
				}
				
				//선언 후 -1로 초기화
				int[] orignalBoxList = new int[9999];			//goodsTraceList 중 원장의 위치
				for (int kk=0; kk<9999; kk++) {
					orignalBoxList[kk] = -1;
				}
				
				GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
				readGoodsProductInfo.setBoxNo(getGoodsProductInfo.getBoxNo());
				readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
				//폐기된 제품 인쇄 불가
				if ("Y".equals(readGoodsProductInfo.getDisuseYn())) {
					jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 폐기된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;

				//분할된 제품 인쇄 불가
				} else if ("D".equals(readGoodsProductInfo.getDivisionYn())) {
					jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 분할된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				
				//병합된 제품 인쇄 불가
				} else if ("M".equals(readGoodsProductInfo.getDivisionYn())) {
					jsonData.put("message", readGoodsProductInfo.getBoxNo() + " - 병합된 제품입니다.");
					jsonData.put("result", "fail");
					return jsonData;
						
				//인쇄 가능한 정상제품
				//정상적으로 인쇄가 가능하다면 원장BoxNo 추적 후 해당 원장들의 작지번호 조회 및 초,중,종물 치수 계산
				} else {
					/* ------------------------------------------------------ 원장 추적 로직 시작 ------------------------------------------------------ */
					String[] goodsTraceList = new String[9999];		//검색해야하는 boxNo 목록들
					int orginalBoxIndex = 0;
					int i=1;	//?
					
					//최초포장번호의 부모들 기본세팅
					goodsTraceList[0] = readGoodsProductInfo.getSelBoxNo1();
					if (null != readGoodsProductInfo.getSelBoxNo2()) {
						goodsTraceList[1] = readGoodsProductInfo.getSelBoxNo2();
						i++;	//for문 좀 적게돌게 줄여주는 역할
					}
					
					//i = 추적하기위해 읽은 boxNo의 위치
					for (int j=0; j<9999; j++) {
						//추적배열의 해당위치가 비었다는것은 더이상 추적할 boxNo가 없다는 뜻임. 이후 orignalBoxList로 원장번호들을 찾아 초,중물 계산해주면됨(작지순서는 어케?)
						if (null == goodsTraceList[j]) {
							break;
						}
						
						GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
						readGoodsTrace.setBoxNo(goodsTraceList[j]);
						readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
						
						if ( null == readGoodsTrace.getSelBoxNo1() ) {
							logger.info("원장 번호 - " + readGoodsTrace.getBoxNo());	//selBoxNo1이 없다는건 원장이라는 뜻
							orignalBoxList[orginalBoxIndex] = j;					//원장 위치 저장
							orginalBoxIndex++;
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo1().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo1());
									distinctCheck = false;
								}
							}
							//selBoxNo1가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo1();
								i++;
							}
						}
						
						if (null==readGoodsTrace.getSelBoxNo2()) {
							//selBoxNo2가 없는거는 원장이랑 관련없음.
						
						
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo2().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo2());
									distinctCheck = false;
								}
							}
							//selBoxNo2가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo2();
								i++;
							}
						}
					}
					
					for (int kk=0; kk<9999; kk++) {
						if ( goodsTraceList[kk] != null) {
							logger.info("추적해야하는 boxNo 리스트 : " + kk + " - " + orignalBoxList[kk] );
						}
					}
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 : " + orignalBoxList[kk]);
							logger.info("원장 포장번호 : " + goodsTraceList[orignalBoxList[kk]]);
						}
					}
					/* ------------------------------------------------------ 원장 추적 로직 종료 ------------------------------------------------------ */
					List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoTotalList = new ArrayList<GoodsProductInfoAdmVo>();
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 - " + orignalBoxList[kk]);
							GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
							//원장번호를 찾아 작지검색
							readOrignalBoxNoVo.setBoxNo(goodsTraceList[orignalBoxList[kk]]);
							//List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(readOrignalBoxNoVo);
							readOrignalBoxNoVo.setFactoryCode(factoryCode);
							List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(readOrignalBoxNoVo);
							//읽어온 작지들을 차례대로 총 작지List에 넣어줌
							for (int o=0; o<readGoodsProductInfoAdmVoList.size(); o++) {
								GoodsProductInfoAdmVoTotalList.add(readGoodsProductInfoAdmVoList.get(o));
							}
						} else {
							break;
						}
					}
					
					for (int o=0; o<GoodsProductInfoAdmVoTotalList.size(); o++) {
						logger.info("해당 원장의 작지번호 : " + GoodsProductInfoAdmVoTotalList.get(o).toString());
					}
					
					//제품정보 읽기
					String IP = null;
					//제품의 포함된 작지번호 최대 3개까지읽기
					int j = 0;
					String ordLotNo1 = "①";
					String ordLotNo2 = "②";
					String ordLotNo3 = "③";
	                
					int tempDivison = 0;
					float stepAverage = 0;
					//포장수량이 0이 아닌 작지에서 최대 3개까지만 출력(4개시에 1개 무시)
					for (GoodsProductInfoAdmVo ii : GoodsProductInfoAdmVoTotalList) {
						if (0 == ii.getPackDtlCnt()) {
							//아무것도 안함.
						} else {
							if (j > 2) {
								break;
							}
							//첫번째 작지만 평균 계산
							if (j == 0) {
	                
								//WorkOrderVo workOrderVo1 = new WorkOrderVo();
								//workOrderVo1.setWorkOrdNo(ii.getWorkOrdNo());
								//workOrderVo1 = workOrderService.read(workOrderVo1);
								//WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
								//workOrdOutputSubVo.setWorkOrdNo(ii.getWorkOrdNo());
								//workOrdOutputSubVo.setOrdLotNo(ii.getOrdLotNo());
								//WorkOrdOutputSubVo readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
								//ordLotNo1 += ii.getOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
								ordLotNo1 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
								
								//초, 중물 검색
								EquipSizeCondStepVo firstEquipSizeCondStepVo = new EquipSizeCondStepVo();
								firstEquipSizeCondStepVo.setWorkOrdNo(ii.getWorkOrdNo());
								firstEquipSizeCondStepVo.setLotNo(ii.getLotNo());
								List<EquipSizeCondStepVo> EquipSizeCondStepList = equipSizeCondStepService.stepAverage(firstEquipSizeCondStepVo);
								
								//종물 검색
								EquipSizeCondStepVo checkThirdEquipSizeCondStep = new EquipSizeCondStepVo();
								EquipSizeCondStepVo thirdEquipSizeCondStep = new EquipSizeCondStepVo();
								
								//MTP 2공장의 경우 품질팀에서 종물데이터를 등록함
								if ("002".equals(session.getAttribute("factoryCode"))) {
									//checkThirdEquipSizeCondStep.setWorkOrdNo(ii.getWorkOrdNo());
									////checkThirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
									//checkThirdEquipSizeCondStep.setLotNo(ii.getLotNo());
									//checkThirdEquipSizeCondStep.setStepCd("003");
									//checkThirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStepCount(checkThirdEquipSizeCondStep);
                                    //
									////종물 을 입력하지 않은 제품번호에서 중지
									//if (checkThirdEquipSizeCondStep.getCount() == 0) {
									//	jsonData.put("message", "작지번호 : " + ii.getWorkOrdNo() + "<br> 주자재 : &nbsp&nbsp: " + ii.getLotNo() + "<br>종물을 입력해 주세요!");
									//	jsonData.put("result", "fail");
									//	return jsonData;
									//}
									//thirdEquipSizeCondStep.setWorkOrdNo(ii.getWorkOrdNo());
									////thirdEquipSizeCondStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
									//thirdEquipSizeCondStep.setLotNo(ii.getLotNo());
									//thirdEquipSizeCondStep.setStepCd("003");
									//thirdEquipSizeCondStep = equipSizeCondStepService.readEquipSizeCondStep(thirdEquipSizeCondStep);
									
								//솔브레인SLD의 경우 생산팀에서 초,중,종물 데이터를 불러옴
								} else if ("003".equals(session.getAttribute("factoryCode"))) {
									
								}
								
	                
								float stepSum = 0;
								//AGT 초,중물이 비어있는 경우
								if (EquipSizeCondStepList.isEmpty()) {
									//MTP 2공장 종물만 등록한 경우
									//if ("002".equals(session.getAttribute("factoryCode"))) {
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//	tempDivison = 1;
									//	
									////솔브레인SLD 초,중,종물을 하나도 등록하지 않은 경우
									//} else if ("003".equals(session.getAttribute("factoryCode"))) {
										stepAverage = 0;
									//}

								//AGT 초,중,종물 총개수
								} else {
									//초,중물 합
									for (int kk=0; kk<EquipSizeCondStepList.size(); kk++) {
										//초,중물 값이 0일경우 계산식에서 제외
										if (Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce()) != 0 && Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce()) != 0) {
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getWpLeftAlwnce());
											stepSum += Float.parseFloat(EquipSizeCondStepList.get(kk).getPpfDepthLeftAlwnce());
											tempDivison++;
										}
									}
									////종물 합 - MTP 2공장의 경우 품질팀에서 종물데이터를 등록함
									//if ("002".equals(session.getAttribute("factoryCode"))) {
									//	//종물 합
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getWpLeftAlwnce());
									//	stepSum += Float.parseFloat(thirdEquipSizeCondStep.getPpfDepthLeftAlwnce());
									//	//초,중 + 종 = 총개수
									//	tempDivison++;
									//}
								}
								//소수점 2자리에서 반올림하여 1자리까지만 표시
								stepAverage = (float) (Math.round((stepSum / tempDivison) * 10) / 10.0);
								logger.info(String.valueOf(stepAverage));
	                
							} else if (j == 1) {
								//WorkOrderVo workOrderVo2 = new WorkOrderVo();
								//workOrderVo2.setWorkOrdNo(ii.getWorkOrdNo());
								//workOrderVo2 = workOrderService.read(workOrderVo2);
								ordLotNo2 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
							} else if (j == 2) {
								//WorkOrderVo workOrderVo3 = new WorkOrderVo();
								//workOrderVo3.setWorkOrdNo(ii.getWorkOrdNo());
								//workOrderVo3 = workOrderService.read(workOrderVo3);
								ordLotNo3 += ii.getWorkOrdLotNo() + "(" + ii.getPackDtlCnt() + ")";
							}
							j++;
						}
					}
	                
					if (readGoodsProductInfo.getGoodsCd().toString().substring(0, 1).equals("A")) {
						if ("001".equals(getGoodsProductInfo.getChoosePrintLocation())) {
							IP = IP3;
						} else if ("002".equals(getGoodsProductInfo.getChoosePrintLocation())) {
							IP = IP5;
						}
	                
					} else if (readGoodsProductInfo.getGoodsCd().toString().substring(0, 1).equals("N")) {
						if ("001".equals(getGoodsProductInfo.getChoosePrintLocation())) {
							IP = IP4;
						} else if ("002".equals(getGoodsProductInfo.getChoosePrintLocation())) {
							IP = IP6;
						}
					}
					logger.info("생산제품 분할/병합 제품 라벨인쇄 IP 주소 : " + IP);
					String workOrdCnt = null;
					String desc = "";
					String image2 = "";
					//자재명 판단  	  	
			  	  	if (readGoodsProductInfo.getGoodsCd().substring(0,1).equals("A")){
			  	  		desc = "Cathode Tab (Al)";
			  	  	} else if (readGoodsProductInfo.getGoodsCd().substring(0,1).equals("N")){
			  	  		desc = "Anode Tab (NiCu)";
			  	  	}
			  	  	
				    if(readGoodsProductInfo.getGoodsNm().contains("DE/SK")) {
				    	//image = "{XQ;01,0,L|}";
				    	image2 = "02";
				    }
				    //HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
				    else if(readGoodsProductInfo.getGoodsNm().contains("HE370")) {
				    	//image = "{XQ;97,0,L|}";
				    	image2 = "98";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("E370")) {
				    	//image = "{XQ;03,0,L|}";
				    	image2 = "04";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("H200")) {
				    	//image = "{XQ;09,0,L|}";
				    	image2 = "10";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("P260")) {
				    	//image = "{XQ;11,0,L|}";
				    	image2 = "12";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("P395")) {
				    	//image = "{XQ;13,0,L|}";
				    	image2 = "14";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("E556")) {
				    	//image = "{XQ;15,0,L|}";
				    	image2 = "16";
				    }
				    else if(readGoodsProductInfo.getGoodsNm().contains("N60")) {
				    	//image = "{XQ;17,0,L|}";
				    	image2 = "18";
				    }
				    else {
				    	//image = "{XQ;97,0,L|}";
				    	image2 = "98";
				    }
				    
				    String[] dataArr = new String[15];
				    
				    dataArr[0] = readGoodsProductInfo.getBoxNo();
				    dataArr[1] = readGoodsProductInfo.getGoodsNm();
				    dataArr[2] = ordLotNo1;
				    dataArr[3] = ordLotNo2;
				    dataArr[4] = ordLotNo3;
				    dataArr[5] = readGoodsProductInfo.getOrdGubunNm();
				    dataArr[6] = Float.toString(stepAverage);
				    dataArr[7] = desc;
				    dataArr[8] = Integer.toString(GoodsProductInfoAdmVoTotalList.size());
				    dataArr[9] = Integer.toString(readGoodsProductInfo.getRemainCnt());
				    dataArr[10] = image2;
					
				    printList.add(dataArr);
				    //라벨발행 시 printYn 업데이트
					//if ("printSuccess".equals(printJsonData.get("printResult"))) {
					readGoodsProductInfo.setUpdId(Utils.getUserId());
					readGoodsProductInfo.setPrintYn("Y");
					goodsPackService.goodsDivisionPackPrintYnUpdate(readGoodsProductInfo);
					jsonData.put("result", "ok");
					jsonData.put("printList", printList);
					//} else {
					//	jsonData.put("message", "프린터 연결에 실패하였습니다.<br>프린터 전원과 네트워크 상태를 확인해 주세요!");
					//	jsonData.put("result", "fail");
					//}
				}
				
			} catch (Exception e) {
				logger.info("분할1 인쇄 에러");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
			}
			
			return jsonData;
		}
		//생산실적 분할&병합 포장 인쇄(분할&병합 인쇄)
	
	//생산실적 분할&병합 작지 추적
	@RequestMapping(value = "/po/traceBoxNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> traceBoxNo(GoodsProductInfoAdmVo getGoodsProductInfo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoTotalList = new ArrayList<GoodsProductInfoAdmVo>();
		logger.info("추적 BoxNo : " + getGoodsProductInfo.getBoxNo());
		
		if ("".equals(getGoodsProductInfo.getBoxNo())) {
			//맨 처음 페이지로딩시 제품을 선택한것이 아니기 때문에 아무것도 하지 않음
			jsonData.put("data", GoodsProductInfoAdmVoTotalList);
			
		} else {
			try {
				//선언 후 -1로 초기화
				int[] orignalBoxList = new int[9999];			//goodsTraceList 중 원장의 위치
				for (int kk=0; kk<9999; kk++) {
					orignalBoxList[kk] = -1;
				}
				
				GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
				readGoodsProductInfo.setBoxNo(getGoodsProductInfo.getBoxNo());
				readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
				//폐기된 제품 인쇄 불가
				if (readGoodsProductInfo == null) {
					jsonData.put("message", getGoodsProductInfo.getBoxNo() + "존재하지 않는 포장번호 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
					
				//인쇄 가능한 정상제품
				//정상적으로 인쇄가 가능하다면 원장BoxNo 추적 후 해당 원장들의 작지번호 조회 및 초,중,종물 치수 계산
				} else {
					/* ------------------------------------------------------ 원장 추적 로직 시작 ------------------------------------------------------ */
					String[] goodsTraceList = new String[9999];		//검색해야하는 boxNo 목록들
					int orginalBoxIndex = 0;
					int i=1;	//?
					
					//최초포장번호의 부모들 기본세팅
					goodsTraceList[0] = readGoodsProductInfo.getSelBoxNo1();
					if (null != readGoodsProductInfo.getSelBoxNo2()) {
						goodsTraceList[1] = readGoodsProductInfo.getSelBoxNo2();
						i++;	//for문 좀 적게돌게 줄여주는 역할
					}
					
					//i = 추적하기위해 읽은 boxNo의 위치
					for (int j=0; j<9999; j++) {
						//추적배열의 해당위치가 비었다는것은 더이상 추적할 boxNo가 없다는 뜻임. 이후 orignalBoxList로 원장번호들을 찾아 초,중물 계산해주면됨(작지순서는 어케?)
						if (null == goodsTraceList[j] || goodsTraceList[j].equals("")) {
							break;
						}
						
						GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
						readGoodsTrace.setBoxNo(goodsTraceList[j]);
						readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
						
						if ( null == readGoodsTrace.getSelBoxNo1() ) {
							logger.info("원장 번호 - " + readGoodsTrace.getBoxNo());	//selBoxNo1이 없다는건 원장이라는 뜻
							orignalBoxList[orginalBoxIndex] = j;					//원장 위치 저장
							orginalBoxIndex++;
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo1().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo1());
									distinctCheck = false;
								}
							}
							//selBoxNo1가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo1();
								i++;
							}
						}
						
						if (null==readGoodsTrace.getSelBoxNo2()) {
							//selBoxNo2가 없는거는 원장이랑 관련없음.
						
						
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo2().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo2());
									distinctCheck = false;
								}
							}
							//selBoxNo2가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo2();
								i++;
							}
						}
					}
					
					for (int kk=0; kk<9999; kk++) {
						if ( goodsTraceList[kk] != null) {
							logger.info("추적해야하는 boxNo 리스트 : " + kk + " - " + orignalBoxList[kk] );
						}
					}
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 : " + orignalBoxList[kk]);
							logger.info("원장 포장번호 : " + goodsTraceList[orignalBoxList[kk]]);
						}
					}
					/* ------------------------------------------------------ 원장 추적 로직 종료 ------------------------------------------------------ */
					
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 - " + orignalBoxList[kk]);
							GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
							//원장번호를 찾아 작지검색
							readOrignalBoxNoVo.setBoxNo(goodsTraceList[orignalBoxList[kk]]);
							//List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(readOrignalBoxNoVo);
							readOrignalBoxNoVo.setFactoryCode(factoryCode);
							List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(readOrignalBoxNoVo);
							//읽어온 작지들을 차례대로 총 작지List에 넣어줌
							for (int o=0; o<readGoodsProductInfoAdmVoList.size(); o++) {
								GoodsProductInfoAdmVoTotalList.add(readGoodsProductInfoAdmVoList.get(o));
							}
						} else {
							break;
						}
					}
					
					for (int o=0; o<GoodsProductInfoAdmVoTotalList.size(); o++) {
						logger.info("해당 원장의 작지번호 : " + GoodsProductInfoAdmVoTotalList.get(o).toString());
					}
				
				}
				jsonData.put("data", GoodsProductInfoAdmVoTotalList);
				jsonData.put("result", "ok");
			
			} catch (Exception e) {
				logger.info("분할1 인쇄 에러");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
			}
		}
		
		return jsonData;
	}
	
	
	//작업지시 실링검사 입력
	@RequestMapping(value = "/posc0090", method = RequestMethod.GET)
	public String posc0090(Locale locale, Model model) throws Exception {
		logger.info("작업지시 실링검사 입력");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "po/posc0090";
	}
	
	//실링검사 입력작지목록
	@RequestMapping(value = "/po/sealingWorkOrdList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sealingWorkOrdList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("실링검사 입력작지목록 = "+ workOrderVo);
		try {
			List<WorkOrderVo> sealingWorkOrdList = workOrderService.sealingWorkOrdList(workOrderVo);
			jsonData.put("data", sealingWorkOrdList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//실링검사 대상작지 확인
	//@RequestMapping(value = "/po/readWorkOrdSealing", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> workOrderMatrlDataList(WorkOrderVo workOrderVo) throws Exception {
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("작업지시 상세조회 = "+ workOrderVo);
	//	
	//	try {
	//		WorkOrderVo readWorkOrderData = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrderVo);
	//		if ("B".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("P".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("S".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("C".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("E".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("G".equals(readWorkOrderData.getWorkStatusCd())) {
	//			jsonData.put("message", readWorkOrderData.getWorkStatusNm() + " 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//			jsonData.put("result", "fail");
	//		} else if ("A".equals(readWorkOrderData.getWorkStatusCd())) {
	//			if (readWorkOrderData.getPackYn() == null || "N".equals(readWorkOrderData.getPackYn())) {
	//				jsonData.put("message", "종료되었으나 미포장 상태의 작지입니다.<br>작지번호를 확인해 주세요!");
	//				jsonData.put("result", "fail");	
	//			} else if ("Y".equals(readWorkOrderData.getPackYn())) {
	//				jsonData.put("data", readWorkOrderData);
	//				jsonData.put("message", "조회되었습니다.");
	//				jsonData.put("result", "ok");
	//			}
	//		}
	//		
	//	} catch (Exception e) {
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "error");
	//	}
	//	
	//	return jsonData;
	//}
	
	//실링검사 입력
	@RequestMapping(value = "/po/updateSealingWorkOrd", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> updateSealingWorkOrd(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("실링검사 입력 = "+ workOrderVo);
		
		try {
			workOrderService.updateSealingWorkOrd(workOrderVo);
			jsonData.put("message", "저장되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//boxNo
	@RequestMapping(value = "/po/boxNoWorkOrdTrace", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> boxNoWorkOrdTrace(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("boxNo = "+ goodsProductInfoAdmVo);
		try {
			List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(goodsProductInfoAdmVo);

			for (int i=0; i<GoodsProductInfoAdmVoList.size(); i++) {
				//주자재 투입내역 가공 - 최대 3개만
				String mainMatrlList = GoodsProductInfoAdmVoList.get(i).getMainMatrlList();
				String [] mainMatrlArray = mainMatrlList.split(",");
				int mainMatrlArraySize = mainMatrlArray.length;
				if (mainMatrlArraySize == 1) {
					GoodsProductInfoAdmVoList.get(i).setMainMatrl1(mainMatrlArray[0]);
				} else if (mainMatrlArraySize == 2) {
					GoodsProductInfoAdmVoList.get(i).setMainMatrl1(mainMatrlArray[0]);
					GoodsProductInfoAdmVoList.get(i).setMainMatrl2(mainMatrlArray[1]);
				} else if (mainMatrlArraySize >= 3) {
					GoodsProductInfoAdmVoList.get(i).setMainMatrl1(mainMatrlArray[0]);
					GoodsProductInfoAdmVoList.get(i).setMainMatrl2(mainMatrlArray[1]);
					GoodsProductInfoAdmVoList.get(i).setMainMatrl3(mainMatrlArray[2]);
				}
				//부자재 투입내역 가공 - 최대 3개만				
				//String subMatrlList = GoodsProductInfoAdmVoList.get(i).getSubMatrlList();
				//String [] subMatrlArray = subMatrlList.split(",");
				//int subMatrlArraySize = subMatrlArray.length;
				//if (subMatrlArraySize == 1) {
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl1(subMatrlArray[0]);
				//} else if (subMatrlArraySize == 2) {
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl1(subMatrlArray[0]);
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl2(subMatrlArray[1]);
				//} else if (subMatrlArraySize >= 3) {
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl1(subMatrlArray[0]);
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl2(subMatrlArray[1]);
				//	GoodsProductInfoAdmVoList.get(i).setSubMatrl3(subMatrlArray[2]);
				//}
			}
			jsonData.put("data", GoodsProductInfoAdmVoList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//입출고관리-제품출하 추적
	@RequestMapping(value = "/po/tracePurchaseBoxNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tracePurchaseBoxNo(GoodsProductInfoAdmVo getGoodsProductInfo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoTotalList = new ArrayList<GoodsProductInfoAdmVo>();
		logger.info("추적 BoxNo : " + getGoodsProductInfo.getBoxNo());
		
		if ("empty".equals(getGoodsProductInfo.getBoxNo())) {
			//맨 처음 페이지로딩시 제품을 선택한것이 아니기 때문에 아무것도 하지 않음
			jsonData.put("data", GoodsProductInfoAdmVoTotalList);
			
		} else {
			
			try {
				if( !getGoodsProductInfo.getBoxNo().equals("") && getGoodsProductInfo.getBoxNo() != null ) {
					//재고제품
					if (getGoodsProductInfo.getBoxNo().substring(0, 1).equals("S")) {
						PreGoodsInventoryAdmVo preGoodsInventoryAdmVo = new PreGoodsInventoryAdmVo();
						preGoodsInventoryAdmVo.setBoxNo(getGoodsProductInfo.getBoxNo());
						List<PreGoodsInventoryAdmVo> preGoodsInventoryAdmVoList = preGoodsInventoryAdmService.tracePurchaseBoxNo(preGoodsInventoryAdmVo);
						
						if (preGoodsInventoryAdmVoList == null) {
							jsonData.put("message", "존재하지 않는 재고제품 포장번호입니다!");
							jsonData.put("result", "fail");
							return jsonData; 
						}
						
						jsonData.put("data", preGoodsInventoryAdmVoList);
						jsonData.put("result", "ok");
						
					//생산제품
					} else {
						
						getGoodsProductInfo = goodsPackService.readGoodsProductInfo(getGoodsProductInfo);
						
						if (getGoodsProductInfo == null) {
							jsonData.put("data", GoodsProductInfoAdmVoTotalList);
							jsonData.put("message", "존재하지 않는 생산제품 포장번호입니다!");
							jsonData.put("result", "fail");
							return jsonData; 
						}
						
						//신규 트레이 로직
						if(getGoodsProductInfo.getBoxNo().length() == 15) {
							getGoodsProductInfo = goodsPackService.readGoodsProductInfoByTray(getGoodsProductInfo);
							GoodsProductInfoAdmVoTotalList.add(getGoodsProductInfo);
							jsonData.put("data", GoodsProductInfoAdmVoTotalList);
							jsonData.put("result", "ok");
							return jsonData; 
						}
						
						//기존 박스번호
						//생산제품 중 원박스
						if (getGoodsProductInfo.getSelBoxNo1() == null && getGoodsProductInfo.getSelBoxNo2() == null) {
								//List<GoodsProductInfoAdmVo> goodsProductInfoAdmList= goodsPackService.selectBoxNoInOrdLotNo(getGoodsProductInfo);
								getGoodsProductInfo.setFactoryCode(factoryCode);
								List<GoodsProductInfoAdmVo> goodsProductInfoAdmList= goodsPackService.selectBoxNoInOrdLotNo_new(getGoodsProductInfo);
								jsonData.put("data", goodsProductInfoAdmList);
								jsonData.put("result", "ok");	
						
						//생산제품 중 분할&병합 박스
						} else {
							GoodsProductInfoAdmVoTotalList.add(getGoodsProductInfo);	//추적하기전 스캔한 포장정보 리스트에 넣어줌
							//선언 후 -1로 초기화
							int[] orignalBoxList = new int[9999];			//goodsTraceList 중 원장의 위치
							for (int kk=0; kk<9999; kk++) {
								orignalBoxList[kk] = -1;
							}
							
							GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
							readGoodsProductInfo.setBoxNo(getGoodsProductInfo.getBoxNo());
							readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
							//폐기된 제품 인쇄 불가
							if (readGoodsProductInfo == null) {
								jsonData.put("message", getGoodsProductInfo.getBoxNo() + "존재하지 않는 포장번호 입니다.");
								jsonData.put("result", "fail");
								return jsonData;
								
							//인쇄 가능한 정상제품
							//정상적으로 인쇄가 가능하다면 원장BoxNo 추적 후 해당 원장들의 작지번호 조회 및 초,중,종물 치수 계산
							} else {
								/* ------------------------------------------------------ 원장 추적 로직 시작 ------------------------------------------------------ */
								String[] goodsTraceList = new String[9999];		//검색해야하는 boxNo 목록들
								int orginalBoxIndex = 0;
								int i=1;	//?
								
								//최초포장번호의 부모들 기본세팅
								goodsTraceList[0] = readGoodsProductInfo.getSelBoxNo1();
								if (null != readGoodsProductInfo.getSelBoxNo2()) {
									goodsTraceList[1] = readGoodsProductInfo.getSelBoxNo2();
									i++;	//for문 좀 적게돌게 줄여주는 역할
								}
								
								//i = 추적하기위해 읽은 boxNo의 위치
								for (int j=0; j<9999; j++) {
									//추적배열의 해당위치가 비었다는것은 더이상 추적할 boxNo가 없다는 뜻임. 이후 orignalBoxList로 원장번호들을 찾아 초,중물 계산해주면됨(작지순서는 어케?)
									if (null == goodsTraceList[j]) {
										break;
									}
									
									GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
									readGoodsTrace.setBoxNo(goodsTraceList[j]);
									readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
									
									if ( null == readGoodsTrace.getSelBoxNo1() ) {
										logger.info("원장 번호 - " + readGoodsTrace.getBoxNo());	//selBoxNo1이 없다는건 원장이라는 뜻
										orignalBoxList[orginalBoxIndex] = j;					//원장 위치 저장
										orginalBoxIndex++;
									} else {
										//넣기 전 중복검사
										boolean distinctCheck = true;
										for (int jj=0; jj<9999; jj++) {
											if (null == goodsTraceList[jj]) {
												break;
											}
											if (readGoodsTrace.getSelBoxNo1().equals(goodsTraceList[jj])) {
												logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo1());
												distinctCheck = false;
											}
										}
										//selBoxNo1가 존재한다는건 원장이 아니라는뜻임
										//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
										if (distinctCheck) {
											int k=i;
											while (goodsTraceList[k]!=null) {
												k++;
											}
											goodsTraceList[k] = readGoodsTrace.getSelBoxNo1();
											i++;
										}
									}
									
									if (null==readGoodsTrace.getSelBoxNo2()) {
										//selBoxNo2가 없는거는 원장이랑 관련없음.
									
									
									} else {
										//넣기 전 중복검사
										boolean distinctCheck = true;
										for (int jj=0; jj<9999; jj++) {
											if (null == goodsTraceList[jj]) {
												break;
											}
											if (readGoodsTrace.getSelBoxNo2().equals(goodsTraceList[jj])) {
												logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo2());
												distinctCheck = false;
											}
										}
										//selBoxNo2가 존재한다는건 원장이 아니라는뜻임
										//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
										if (distinctCheck) {
											int k=i;
											while (goodsTraceList[k]!=null) {
												k++;
											}
											goodsTraceList[k] = readGoodsTrace.getSelBoxNo2();
											i++;
										}
									}
								}
								
								for (int kk=0; kk<9999; kk++) {
									if ( goodsTraceList[kk] != null) {
										logger.info("추적해야하는 boxNo 리스트 : " + kk + " - " + orignalBoxList[kk] );
									}
								}
								for (int kk=0; kk<9999; kk++) {
									if ( orignalBoxList[kk] != -1) {
										logger.info("원장 위치 : " + orignalBoxList[kk]);
										logger.info("원장 포장번호 : " + goodsTraceList[orignalBoxList[kk]]);
									}
								}
								/* ------------------------------------------------------ 원장 추적 로직 종료 ------------------------------------------------------ */
								
								for (int kk=0; kk<9999; kk++) {
									if ( orignalBoxList[kk] != -1) {
										logger.info("원장 위치 - " + orignalBoxList[kk]);
										GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
										//원장번호를 찾아 작지검색
										readOrignalBoxNoVo.setBoxNo(goodsTraceList[orignalBoxList[kk]]);
										//List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo(readOrignalBoxNoVo);
										getGoodsProductInfo.setFactoryCode(factoryCode);
										List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList= goodsPackService.selectBoxNoInOrdLotNo_new(getGoodsProductInfo);
										
										//읽어온 작지들을 차례대로 총 작지List에 넣어줌
										for (int o=0; o<readGoodsProductInfoAdmVoList.size(); o++) {
											GoodsProductInfoAdmVoTotalList.add(readGoodsProductInfoAdmVoList.get(o));
										}
									} else {
										break;
									}
								}
								
								for (int o=0; o<GoodsProductInfoAdmVoTotalList.size(); o++) {
									logger.info("해당 원장의 작지번호 : " + GoodsProductInfoAdmVoTotalList.get(o).toString());
								}
							
							}
							jsonData.put("data", GoodsProductInfoAdmVoTotalList);
							jsonData.put("result", "ok");
						}
					}
				} else if( !getGoodsProductInfo.getCustomerLotNo().equals("") && getGoodsProductInfo.getCustomerLotNo() != null ) {
					
					//일단 고객사 LotNo로 박스번호들 찾고
					//박스길이로 정보를 다시 찾아보자
					getGoodsProductInfo.setFactoryCode(factoryCode);
					
					List<GoodsProductInfoAdmVo> tempCustomerList = new ArrayList<GoodsProductInfoAdmVo>();
					tempCustomerList = goodsPackService.selectCustomerLotNo_F1F2F3(getGoodsProductInfo);
					
					for (int o=0; o<tempCustomerList.size(); o++) {
						GoodsProductInfoAdmVo readGoodsProductInfo777 = new GoodsProductInfoAdmVo();
						readGoodsProductInfo777.setBoxNo(tempCustomerList.get(o).getBoxNo());
						//트레이
						if (tempCustomerList.get(o).getBoxNo().length() == 15) {
							readGoodsProductInfo777 = goodsPackService.readGoodsProductInfoByTray(readGoodsProductInfo777);
							GoodsProductInfoAdmVoTotalList.add(readGoodsProductInfo777);
							
						//기존 포장번호
						} else {
							readGoodsProductInfo777.setFactoryCode(factoryCode);	//ㅋㅋㅋ이거없으면 널포인트 에러나네 한참찾았네
							goodsPackService.selectBoxNoInOrdLotNo_new(readGoodsProductInfo777);
							List<GoodsProductInfoAdmVo> tempCustomerList2 = goodsPackService.selectBoxNoInOrdLotNo_new(readGoodsProductInfo777);
							for (int temp=0; temp<tempCustomerList2.size(); temp++) {
								GoodsProductInfoAdmVoTotalList.add(tempCustomerList2.get(temp));
							}
						}
					}
					
					jsonData.put("data", GoodsProductInfoAdmVoTotalList);
					jsonData.put("result", "ok");
				}
			} catch (Exception e) {
				logger.info("입출고관리-제품출하 추적 에러");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
			}
		}
		
		return jsonData;
	}
	
	//제품 다중 추적(주재료)
	@RequestMapping(value = "/po/goodsTraceByMatrlLotNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsTraceByMatrlLotNo(@RequestBody List<Map<String, Object>> matrlLotNoList) throws Exception {
		logger.info("제품 다중 추적(주재료) - " + matrlLotNoList);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<GoodsProductInfoAdmVo> goodsTraceByMatrlLotNo = new ArrayList<GoodsProductInfoAdmVo>();
		
		try {
			for (Map<String, Object> m : matrlLotNoList) {
				GoodsProductInfoAdmVo getGoodsProductInfo = new GoodsProductInfoAdmVo();
				getGoodsProductInfo.setLotNo(m.get("typeText").toString());
				//해당 주재료로 채번된 포장번호목록 조회
				List<GoodsProductInfoAdmVo> goodsTraceList = goodsPackService.goodsTraceByMatrlLotNo(getGoodsProductInfo);
				
				//★☆★☆★☆★☆★☆분할&병합 추적 시작★☆★☆★☆★☆★☆
				String[] traceBoxList = new String[9999];
				int orignalTraceIndex = goodsTraceList.size();		//처음 원장 폐기 boxNo 수량
				int traceIndex = goodsTraceList.size();				//처음 로직 시작시 traceBoxList가 비어있는 위치
				
				//추적해야할 원장 BoxNoList
				for (int i=0; i<goodsTraceList.size(); i++) {
					traceBoxList[i] = goodsTraceList.get(i).getBoxNo();
				}
				
				for (int i=0; i<9999; i++) {
					if (traceBoxList[i] == null) {
						break;
					}
					GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
					readGoodsTrace.setBoxNo(traceBoxList[i]);
					readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
					
					//분할여부가 N이면 분할&병합 하지 않은 제품
					if ("N".equals(readGoodsTrace.getDivisionYn())) {
						
					//분할&병합 하였으면 채번된 번호 찾아서 traceBoxList에 넣어줌
					} else {
						List<GoodsProductInfoAdmVo> goodsDisuseTraceList = goodsPackService.traceDisuseBoxNo(readGoodsTrace);
						for (int j=0; j<goodsDisuseTraceList.size(); j++) {
							if (null != goodsDisuseTraceList.get(j).getSelBoxNo1()) {
								//중복검사
								boolean distinctCheck = true;
								for (int jj=0; jj<9999; jj++) {
									if (traceBoxList[jj] == null) {
										break;
									}
									if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
										logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
										distinctCheck = false;
									}
								}
								
								//중복이 없으면 추적리스트에 넣어줌
								if (distinctCheck) {
									traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
									traceIndex++;	
								}
							}
							if (null != goodsDisuseTraceList.get(j).getSelBoxNo2()) {
								//중복검사
								boolean distinctCheck = true;
								for (int jj=0; jj<9999; jj++) {
									if (traceBoxList[jj] == null) {
										break;
									}
									if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
										logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
										distinctCheck = false;
									}
								}
								
								//중복이 없으면 추적리스트에 넣어줌
								if (distinctCheck) {
									traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
									traceIndex++;
								}
							}
						}
					}
				}
				
				//추적한 BoxNoList
				for (int i=0; i<9999; i++) {
					if (traceBoxList[i] == null) {
						break;
					}
					logger.info("추적 완료 boxNo " + traceBoxList[i]);
					GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
					readGoodsProductInfo.setBoxNo(traceBoxList[i]);
					readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
					
					//분할되지 않은 제품이면 상세LotNo까지 표시
					if (readGoodsProductInfo.getSelBoxNo1() == null) {
						readGoodsProductInfo.setLotNo(getGoodsProductInfo.getLotNo());
						List<GoodsProductInfoAdmVo> readGoodsProductInfoList = goodsPackService.selectGoodsByMatrlLotNo(readGoodsProductInfo);
						goodsTraceByMatrlLotNo.addAll(readGoodsProductInfoList);	

					//분할&병합되었으면 자재LotNo 같은정보 표시X
					} else {
						goodsTraceByMatrlLotNo.add(readGoodsProductInfo);	
					}
					
				}
				//★☆★☆★☆★☆★☆분할&병합 추적 종료★☆★☆★☆★☆★☆
			}
			
			jsonData.put("data", goodsTraceByMatrlLotNo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("제품 다중 추적(주재료) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//제품 다중 추적(포장번호)
	@RequestMapping(value = "/po/goodsTraceByBoxNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsTraceByBoxNo(@RequestBody List<Map<String, Object>> matrlLotNoList) throws Exception {
		logger.info("제품 다중 추적(포장번호) - " + matrlLotNoList);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<GoodsProductInfoAdmVo> goodsTraceByMatrlLotNo = new ArrayList<GoodsProductInfoAdmVo>();
		
		try {
			
		} catch (Exception e) {
			logger.info("제품 다중 추적(주재료) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//PO 납기일로 제품 추적
	@RequestMapping(value = "/po/goodsTraceByPurchase", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsTraceByPurchase(@RequestBody List<Map<String, Object>> matrlLotNoList) throws Exception {
		logger.info("PO 납기일로 제품 추적 - " + matrlLotNoList);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<GoodsProductInfoAdmVo> goodsTraceByPurchase = new ArrayList<GoodsProductInfoAdmVo>();
		
		try {
			GoodsProductInfoAdmVo getGoodsProductInfo = new GoodsProductInfoAdmVo();
			for (Map<String, Object> m : matrlLotNoList) {
				getGoodsProductInfo.setChooseDateFrom(m.get("chooseDateFrom").toString());
				getGoodsProductInfo.setChooseDateTo(m.get("chooseDateTo").toString());
				
				//출하된 생산포장번호 중 분할&병합된 목록
				List<GoodsProductInfoAdmVo> divisionGoodsTraceList = goodsPackService.goodsTraceByPurchaseDivision(getGoodsProductInfo);
				
				if (divisionGoodsTraceList.isEmpty()) {
					break;
				}
				
				for (int qq=0; qq<divisionGoodsTraceList.size(); qq++) {
					/* ------------------------------------------------------ 원장 추적 로직 시작 ------------------------------------------------------ */
					//선언 후 -1로 초기화
					int[] orignalBoxList = new int[9999];			//goodsTraceList 중 원장의 위치
					for (int kk=0; kk<9999; kk++) {
						orignalBoxList[kk] = -1;
					}
					
					String[] goodsTraceList = new String[9999];		//검색해야하는 boxNo 목록들
					int orginalBoxIndex = 0;
					int i=1;	//?
					
					//최초포장번호의 부모들 기본세팅
					goodsTraceList[0] = divisionGoodsTraceList.get(qq).getSelBoxNo1();
					if (null != divisionGoodsTraceList.get(qq).getSelBoxNo2()) {
						goodsTraceList[1] = divisionGoodsTraceList.get(qq).getSelBoxNo2();
						i++;	//for문 좀 적게돌게 줄여주는 역할
					}
					
					//i = 추적하기위해 읽은 boxNo의 위치
					for (int j=0; j<9999; j++) {
						//추적배열의 해당위치가 비었다는것은 더이상 추적할 boxNo가 없다는 뜻임. 이후 orignalBoxList로 원장번호들을 찾아 초,중물 계산해주면됨(작지순서는 어케?)
						if (null == goodsTraceList[j]) {
							break;
						}
						
						GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
						readGoodsTrace.setBoxNo(goodsTraceList[j]);
						readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
						
						if (null == readGoodsTrace.getSelBoxNo1()) {
							logger.info("원장 번호 - " + readGoodsTrace.getBoxNo());	//selBoxNo1이 없다는건 원장이라는 뜻
							orignalBoxList[orginalBoxIndex] = j;					//원장 위치 저장
							orginalBoxIndex++;
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo1().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo1());
									distinctCheck = false;
								}
							}
							//selBoxNo1가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo1();
								i++;
							}
						}
						
						if (null==readGoodsTrace.getSelBoxNo2()) {
							//selBoxNo2가 없는거는 원장이랑 관련없음.
						
						
						} else {
							//넣기 전 중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (null == goodsTraceList[jj]) {
									break;
								}
								if (readGoodsTrace.getSelBoxNo2().equals(goodsTraceList[jj])) {
									logger.info("중복 발생 - " + readGoodsTrace.getSelBoxNo2());
									distinctCheck = false;
								}
							}
							//selBoxNo2가 존재한다는건 원장이 아니라는뜻임
							//해당boxNo로 새로 찾아들어가야하니 배열의 빈칸중 제일 앞에부터 넣어줌
							if (distinctCheck) {
								int k=i;
								while (goodsTraceList[k]!=null) {
									k++;
								}
								goodsTraceList[k] = readGoodsTrace.getSelBoxNo2();
								i++;
							}
						}
					}
					
					for (int kk=0; kk<9999; kk++) {
						if ( goodsTraceList[kk] != null) {
							logger.info("추적해야하는 boxNo 리스트 : " + kk + " - " + orignalBoxList[kk] );
						}
					}
					
					
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 : " + orignalBoxList[kk]);
							logger.info("원장 포장번호 : " + goodsTraceList[orignalBoxList[kk]]);
						}
					}
					/* ------------------------------------------------------ 원장 추적 로직 종료 ------------------------------------------------------ */
					goodsTraceByPurchase.add(divisionGoodsTraceList.get(qq));
					//List<GoodsProductInfoAdmVo> GoodsProductInfoAdmVoTotalList = new ArrayList<GoodsProductInfoAdmVo>();
					for (int kk=0; kk<9999; kk++) {
						if ( orignalBoxList[kk] != -1) {
							logger.info("원장 위치 - " + orignalBoxList[kk]);
							GoodsProductInfoAdmVo readOrignalBoxNoVo = new GoodsProductInfoAdmVo();
							//원장번호를 찾아 작지검색
							readOrignalBoxNoVo.setBoxNo(goodsTraceList[orignalBoxList[kk]]);
							readOrignalBoxNoVo.setFactoryCode(factoryCode);
							List<GoodsProductInfoAdmVo> readGoodsProductInfoAdmVoList = goodsPackService.selectBoxNoInOrdLotNo_new(readOrignalBoxNoVo);
							//읽어온 작지들을 차례대로 총 작지List에 넣어줌
							for (int o=0; o<readGoodsProductInfoAdmVoList.size(); o++) {
								goodsTraceByPurchase.add(readGoodsProductInfoAdmVoList.get(o));
							}
						} else {
							break;
						}
					}
					
					//for (int o=0; o<GoodsProductInfoAdmVoTotalList.size(); o++) {
					//	logger.info("해당 원장의 작지번호 : " + GoodsProductInfoAdmVoTotalList.get(o).toString());
					//}
					
				}

			}
			
			//이후 분할&병합이 이루어지지 않은 포장번호들 추적하여 붙여넣어줌
			List<GoodsProductInfoAdmVo> goodsTraceByPurchaseList = goodsPackService.goodsTraceByPurchase(getGoodsProductInfo);
			goodsTraceByPurchase.addAll(goodsTraceByPurchaseList);
			
			jsonData.put("data", goodsTraceByPurchase);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("제품 다중 추적(주재료) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//제품 불량상태 변경
	@RequestMapping(value = "/po/changeGoodsProductFaultyType", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> changeGoodsProductFaultyType(@RequestBody List<Map<String, Object>> goodsProductList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 불량상태 변경 boxNo : "+ goodsProductList);
		try {
			for(Map<String, Object> m : goodsProductList) {
				String boxNo = m.get("boxNo").toString();
				
				//재고 제품 불량상태 변경
				if ( boxNo.toString().substring(0, 1).equals("S") ) {
					
					PreGoodsInventoryAdmVo readPreGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
					readPreGoodsInventoryDtl.setBoxNo(boxNo);
					readPreGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(readPreGoodsInventoryDtl);
					
					if (readPreGoodsInventoryDtl == null) { 
						jsonData.put("message", "존재하지 않는 초기재고 제품번호입니다!");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					//출하상태이면 수불X
					if ("003".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
						
					} else {
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
						String stockPaymentLocationCd = null;	// 수불창고 - 001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
						//제품 포장
						if ("001".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "007";
							} else if ("002".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							}
							
						//제품 입고
						} else if ("002".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "008";
							} else if ("002".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(readPreGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							}
						}

						//기존 제품상태가 폐기이면 아무것도 안함
						if (!"non".equals(stockPaymentLocationCd)) {
							stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readPreGoodsInventoryDtl.getGoodsCd(), readPreGoodsInventoryDtl.getBoxNo(), "003", "O", stockPaymentLocationCd, readPreGoodsInventoryDtl.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
						}
					}
					
					PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();	//재고제품
					preGoodsInventoryDtl.setBoxNo(boxNo);
					preGoodsInventoryDtl.setFaultyStatus(m.get("faultyStatus").toString());
					preGoodsInventoryDtl.setFaultyDate(m.get("faultyDate").toString());
					preGoodsInventoryDtl.setFaultyType(m.get("faultyType").toString());
					preGoodsInventoryDtl.setFaultyDesc(m.get("faultyDesc").toString());
					preGoodsInventoryDtl.setUpdId(Utils.getUserId());
					preGoodsInventoryDtl.setHistId(Utils.getUserId());
					preGoodsInventoryAdmService.changePreGoodsProductFaultyType(preGoodsInventoryDtl);	//재고제품 불량상태변경
					preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); 		//재고제품 상태변경 이력쌓기
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					String stockPaymentLocationCd = null;	// 수불창고 - 001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
					//출하상태이면 수불X
					if ("003".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
						
					} else {
						//제품 포장
						if ("001".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "007";
							} else if ("002".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							}
							
						//제품 입고
						} else if ("002".equals(readPreGoodsInventoryDtl.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "008";
							} else if ("002".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(preGoodsInventoryDtl.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							}
						}
	
						//update 상태가 정상&불량&검사반품&대기이면 해당 제품창고에 + 처리
						if (!"non".equals(stockPaymentLocationCd)) {
							stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readPreGoodsInventoryDtl.getGoodsCd(), readPreGoodsInventoryDtl.getBoxNo(), "003", "I", stockPaymentLocationCd, readPreGoodsInventoryDtl.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//수불 +
							
						//update 상태가 폐기이면 부적합창고에서 - 처리
						} else {
							stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readPreGoodsInventoryDtl.getGoodsCd(), readPreGoodsInventoryDtl.getBoxNo(), "003", "O", "010", readPreGoodsInventoryDtl.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//수불 -
						}
					}
					
					
				//생산 제품 불량상태 변경
				} else {
					logger.info("goodsProductList : " + m);
					GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
					readGoodsProductInfo.setBoxNo(boxNo);
					readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
					
					if (readGoodsProductInfo == null) { 
						jsonData.put("message", "존재하지 않는 생산제품번호입니다!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ("D".equals(readGoodsProductInfo.getDivisionYn())) {
						jsonData.put("message", "분할한 생산제품은 부적합 처리 하실 수 없습니다!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ("M".equals(readGoodsProductInfo.getDivisionYn())) {
						jsonData.put("message", "병합한 생산제품은 부적합 처리 하실 수 없습니다!");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					//출하상태이면 수불X
					if ("003".equals(readGoodsProductInfo.getGoodsStatus())) {
						
					} else {
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
						String stockPaymentLocationCd = null;	// 수불창고 - 001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
						//제품 포장
						if ("001".equals(readGoodsProductInfo.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "007";
							} else if ("002".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							} else if ("006".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "011";
							}
							
						//제품 입고
						} else if ("002".equals(readGoodsProductInfo.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "008";
							} else if ("002".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							} else if ("006".equals(readGoodsProductInfo.getFaultyStatus())) {
								stockPaymentLocationCd = "011";
							}
						}

						//기존 제품상태가 폐기이면 아무것도 안함
						if (!"non".equals(stockPaymentLocationCd)) {
							stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfo.getGoodsCd(), readGoodsProductInfo.getBoxNo(), "002", "O", stockPaymentLocationCd, readGoodsProductInfo.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -	
						}
					}
					
					
					GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
					goodsProductInfoAdmVo.setBoxNo(boxNo);
					goodsProductInfoAdmVo.setFaultyStatus(m.get("faultyStatus").toString());
					goodsProductInfoAdmVo.setFaultyDate(m.get("faultyDate").toString());
					goodsProductInfoAdmVo.setFaultyType(m.get("faultyType").toString());
					goodsProductInfoAdmVo.setFaultyDesc(m.get("faultyDesc").toString());
					goodsProductInfoAdmVo.setDisposeGubun(m.get("disposeGubun").toString());
					if("005".equals(m.get("faultyStatus").toString())) { //폐기일경우 트레이 상태값 업데이트
						goodsProductInfoAdmVo.setDisuseYn("Y");
						ShipInspectVo shipInspectVo = new ShipInspectVo();
						shipInspectVo.setTrayNo(boxNo);
						List<ShipInspectVo> shipList = shipInspectService.shipInspAdmRead(shipInspectVo);
						if( shipList.size() != 0 ) {
							shipInspectVo = shipList.get(0);
							shipInspectVo.setUpdId(Utils.getUserId());
							shipInspectVo.setDisStatus("001");
							shipInspectVo.setGubun("001");
							shipInspectService.shipAdmDisStatusUpdate(shipInspectVo);							
						}
					} else {
						goodsProductInfoAdmVo.setDisuseYn("N");
					}
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
					goodsPackService.changeGoodsProductFaultyType(goodsProductInfoAdmVo);	//생산제품 불량상태변경
					goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
					
					if("003".equals(factoryCode) && "001".equals(m.get("faultyStatus").toString())) {
						goodsProductInfoAdmVo.setFaultyDate("");
						goodsPackService.changeGoodsProductFaultyType(goodsProductInfoAdmVo);	//생산제품 불량상태변경
					}
					
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					String stockPaymentLocationCd = null;	// 수불창고 - 001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
					//출하상태이면 수불X
					if ("003".equals(readGoodsProductInfo.getGoodsStatus())) {
						
					} else {
						//제품 포장
						if ("001".equals(readGoodsProductInfo.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "007";
							} else if ("002".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							} else if ("006".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "011";
							}
							
						//제품 입고
						} else if ("002".equals(readGoodsProductInfo.getGoodsStatus())) {
							//faultyStatus - 001:정상, 002:불량, 003:검사 반품, 004:대기, 005:폐기
							if ("001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "008";
							} else if ("002".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("003".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("004".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "009";
							} else if ("005".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "non";
							} else if ("003".equals(factoryCode) && "013".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "010";
							} else if ("006".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
								stockPaymentLocationCd = "011";
							}
						}
						
						if("003".equals(factoryCode) && "013".equals(m.get("faultyStatus").toString())){
							//검사반품 이력 쌓아두면 됨
							ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
							ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
							
							shipInspectAdmVo.setTrayNo(boxNo);
							shipInspectAdmVo.setTrayNo1(boxNo);
							shipInspectAdmVo.setTrayNo2(boxNo);
							
							ShipInspectVo shipInspectReadVo = new ShipInspectVo();
							shipInspectReadVo.setReInspStatus("001");
							shipInspectReadVo.setTrayNo(boxNo);
							List<ShipInspectVo> ReadList = shipInspectService.shipInspAdmRead(shipInspectReadVo);						
							
							//트레이 번호로 작업지시 조회
							GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo = new GoodsProductInfoAdmVo();	//생산제품
							readTrayBoxByWorkOrdNo.setBoxNo(boxNo);
							readTrayBoxByWorkOrdNo = goodsPackService.readTrayBoxByWorkOrdNo3(readTrayBoxByWorkOrdNo);
							
							//shipInspectService.shipInspAdmRead(shipInspectAdmVo);
							shipInspectAdmVo.setWorkOrdNo(readTrayBoxByWorkOrdNo.getWorkOrdNo());
							shipInspectAdmVo.setMatrlLotNo(readTrayBoxByWorkOrdNo.getMatrlLotNo());
							shipInspectAdmVo.setFilmLotNo(readTrayBoxByWorkOrdNo.getFilmLotNo());
							//shipInspectAdmVo.setInspStatus();
							//shipInspectAdmVo.setReInspStatus("003");
							shipInspectAdmVo.setReInspStatus("004");	//원래는 002이였음, 001: 출하검사, 002: 재검사, 003: 출하재검사 +004: 출하검사의뢰 추가됨
							//shipInspectAdmVo.setDisStatus();
							//shipInspectAdmVo.setInspDate( date );
							shipInspectAdmVo.setFaultyCnt("0");
							//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
							//shipInspectAdmVo.setInspChargr(inspChargr);
							shipInspectAdmVo.setDayNightCd(ReadList.get(0).getDayNightCd());
							shipInspectAdmVo.setProductDate(ReadList.get(0).getProductDate());
							//shipInspectAdmVo.setFaultyGubun(faultyGubun);
							shipInspectAdmVo.setNextGubun("001");				//출하재검
							
							
							//shipInspectAdmVo.setDisStatus("002");
							
							shipInspectAdmVo.setRegId( Utils.getUserId() );
							
							//구분자 이동으로 변경
							shipInspectAdmVo2.setTrayNo(boxNo);
							
							int maxIdx = shipInspectService.shipInspectMaxIdxRead(shipInspectAdmVo2).getIdx();
							shipInspectAdmVo2.setIdx(maxIdx);
							shipInspectAdmVo2.setNextGubun("002");
							shipInspectAdmVo2.setUpdId(Utils.getUserId());
							shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);
							//구분자 이동으로 변경
							
							String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
							shipInspectAdmVo.setSeq(seq);
							
							shipInspectService.shipAdmCreate(shipInspectAdmVo);
							
						}
						
						//update 상태가 정상&불량&검사반품&대기이면 해당 제품창고에 + 처리
						if (!"non".equals(stockPaymentLocationCd)) {
							stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfo.getGoodsCd(), readGoodsProductInfo.getBoxNo(), "002", "I", stockPaymentLocationCd, readGoodsProductInfo.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//수불 +
							
						//update 상태가 폐기이면 부적합창고에서 - 처리 -> 이미 -처리 됨
						} else {
							//stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfo.getGoodsCd(), readGoodsProductInfo.getBoxNo(), "002", "O", "010", readGoodsProductInfo.getPackCnt(), factoryCode);
							//stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//수불 -
						}
					}
				}
			}
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("제품 불량상태 변경 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//입출고관리-제품 검사&부적합 페이지
	@RequestMapping(value = "/iosc0130", method = RequestMethod.GET)
	public String iosc0130(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리-제품 검사&부적합 페이지");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "io/iosc0130";
	}
	
	//입출고관리-제품 검사&부적합 페이지
	@RequestMapping(value = "/iosc3130", method = RequestMethod.GET)
	public String iosc3130(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리-제품 검사&부적합 페이지");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("120"); // 제품 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faultyStatusList", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "io/iosc3130";
	}
	
	//입출고관리-제품 검사&부적합 현황 목록
	@RequestMapping(value = "/io/goodsFaultyTypeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsFaultyTypeDataList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리-제품 검사&부적합 현황 목록 = " + goodsProductInfoAdmVo);
		try {
			List<GoodsProductInfoAdmVo> goodsProductInfoAdmList = goodsPackService.goodsFaultyTypeDataList(goodsProductInfoAdmVo);
			jsonData.put("data", goodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 반품목록조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리-제품 검사&부적합 현황 목록
	@RequestMapping(value = "/io/goodsFaultyTypeDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsFaultyTypeDataList_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리-제품 검사&부적합 현황 목록 = " + goodsProductInfoAdmVo);
		try {
			List<GoodsProductInfoAdmVo> goodsProductInfoAdmList = goodsPackService.goodsFaultyTypeDataList_F3(goodsProductInfoAdmVo);
			jsonData.put("data", goodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 반품목록조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리-제품 입출고 내역
	@RequestMapping(value = "/iosc0140", method = RequestMethod.GET)
	public String iosc0140(Locale locale, Model model) throws Exception {
		logger.info("입출고관리-제품 입출고 내역 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품불량유형
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList );
		
		return "io/iosc0140";
	}
	//입출고관리-제품 입출고내역
	@RequestMapping(value = "/io/goodsProductInOutHistList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInOutHistList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리-제품 입출고내역 : " + goodsProductInfoAdmVo);
		try {
			//분할된 박스인지 확인
			//GoodsProductInfoAdmVo goodsProductInfoAdmVo2 = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
			
			
			//분할되지 않았으면.
			
			 List<GoodsProductInfoAdmVo> goodsProductInfoAdmList = goodsPackService.goodsProductInOutHistList2(goodsProductInfoAdmVo);
						
			
			
			
			
			
			jsonData.put("data", goodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리-제품 입출고내역 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	@RequestMapping(value = "/tmsc0110", method = RequestMethod.GET)
	public String tmsc0110(Locale locale, Model model) throws Exception {
		logger.info("품질관리 - 창고별제품위치");
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("004"); // 자재재질
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("location", systemCommonCodeList );
		
		//model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		//model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "tm/tmsc0110";
	}
	
	//창고별 제품위치 리스트조회
	@RequestMapping(value = "/tm/locationList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고별 제품위치 리스트조회 : " + goodsProductInfoAdmVo);
		try {				
			// 창고번호가 존재하는 만큼 리스트 만들어주기
			
			// 박스번호, 창고번호  읽어오기
			List<GoodsProductInfoAdmVo> goodsProductInfoAdmList = goodsPackService.locationList(goodsProductInfoAdmVo);		
			
			jsonData.put("data", goodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("창고별 제품위치 리스트조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
			
		return jsonData;
	}
	
}