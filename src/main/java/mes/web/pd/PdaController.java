package mes.web.pd;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.LogionHistVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.bs.PurchaseOrderDtl;
import mes.domain.bs.PurchaseOrderOutputHistVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.pd.GoodsProductInfoAdmVo;
import mes.domain.po.ProductionPerfTrayVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.ShipInspectVo;
import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.qm.ShipInspectService;
import mes.service.sm.MatrlUserService;
import mes.service.sm.MenuInfoAdmService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.cm.Constants;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class PdaController {
	
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private MatrlUserService matrlUserService;
	@Inject
	private MenuInfoAdmService menuInfoAdmService;
	@Inject
	private PdaService PdaService;
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private PreGoodsInventoryAdmService preGoodsInventoryAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private ProductionPerfTrayService productionPerfTrayService;
	@Inject
	private ShipInspectService shipInspectService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(PdaController.class);

	//PDA 로그인 페이지
	@RequestMapping(value = "/auth/pdsc0080", method = RequestMethod.GET)
	public String pda011GET(Model model, HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.FACTORY_CODE, factoryCode);							//공장코드, 001-머티1공장(성남), 002-머티2공장(성남), 003-머티3공장(솔브레인 SLD)
		
		logger.info("PDA 로그인 페이지");

		return "auth/pdsc0080";
		//return "auth/login";
	}

	//제품출고
	@RequestMapping(value = "/pdsc0040", method = RequestMethod.GET)
	public String pdsc0040GET(Model model) throws Exception {

		logger.info("PDA 제품출고 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0040";
	}
	
	//제품출고
	@RequestMapping(value = "/pdsc3040", method = RequestMethod.GET)
	public String pdsc3040GET(Model model) throws Exception {

		logger.info("PDA 제품출고 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3040";
	}
	
	//미료&완공
	@RequestMapping(value = "/pdsc3050", method = RequestMethod.GET)
	public String pdsc3050GET(Model model) throws Exception {

		logger.info("PDA 미료&완공 지정 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		return "pd/pdsc3050";
	}
	
	//위치지정
	@RequestMapping(value = "/pdsc3060", method = RequestMethod.GET)
	public String pdsc3060GET(Model model) throws Exception {

		logger.info("PDA 위치지정 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		return "pd/pdsc3060";
	}
	
	//파레트라벨 매핑 등록
	@RequestMapping(value = "/pdsc3070", method = RequestMethod.GET)
	public String pdsc3070GET(Model model) throws Exception {

		logger.info("PDA 파레트라벨 매핑 등록 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3070";
	}
	
	//출하대기체크
	@RequestMapping(value = "/pdsc3080", method = RequestMethod.GET)
	public String pdsc3080GET(Model model) throws Exception {

		logger.info("PDA 출하대기체크 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3080";
	}
	
	//제품입고 전 스캔
	@RequestMapping(value = "/pdsc3090", method = RequestMethod.GET)
	public String pdsc3090GET(Model model) throws Exception {

		logger.info("PDA 제품입고 전 스캔 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3090";
	}
	
	//자재 상태 변경
	@RequestMapping(value = "/pdsc3100", method = RequestMethod.GET)
	public String pdsc3100GET(Model model) throws Exception {

		logger.info("PDA 자재 상태 변경 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3100";
	}
		
	//제품출고
	@RequestMapping(value = "/pdsc2040", method = RequestMethod.GET)
	public String pdsc2040GET(Model model) throws Exception {

		logger.info("PDA 제품출고 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc2040";
	}

	// PDA로그인 처리 - ajax
	@RequestMapping(value = "/pd/login_ajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginAjaxPOST(MatrlUserVo matrlUserVo, HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		MenuAuthVo menuAuthVo = new MenuAuthVo();
		logger.info("PDA 로그인");
		logger.info("MatrlUserVo : " + matrlUserVo);

		try {
			// DB에서 로그인 정보 조회
			MatrlUserVo userVo = matrlUserService.read(matrlUserVo);
			logger.info("userVo  ====> " + userVo);
			// 사용자 있음
			if (userVo != null) {
				// 비밀번호 틀림
				//if(!userVo.getUserPw().toString().equals(matrlUserVo.getUserPw().toString())) {
				if (!BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw())) {
					jsonData.put("result", "error");
					jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
				}
				// 로그인 불가
				else if ("N".equals(userVo.getEmpYnCd())) {
					jsonData.put("result", "error");
					jsonData.put("message", "로그인이 불가능한 상태입니다. 관리자에게 문의바랍니다.");
				}
				// 로그인 성공
				else {
					HttpSession session = request.getSession(true);
					menuAuthVo.setDepartmentCd(userVo.getDepartmentCd());
					List<MenuInfoAdmVo> authList = menuInfoAdmService.menuInfo(menuAuthVo);
					String menuPath = "";

					for (MenuInfoAdmVo m : authList) {
						menuPath += m.getMenuPath() + ",";
					}
					logger.info(menuPath);
					// 사용자 정보
					session.setAttribute("userNumber", userVo.getUserNumber());
					session.setAttribute("userNm", userVo.getUserNm());
					session.setAttribute("userId", userVo.getUserId());
					session.setAttribute("rememberMe", (String) matrlUserVo.getRememberMe());
					session.setAttribute("department", userVo.getDepartmentCd());
					session.setAttribute("userAuth", authList);
					session.setAttribute("menuAuth", menuPath);
					Utils.setUserId(userVo.getUserId());

					jsonData.put("result", "ok");
				}
			}
			// 사용자 없음
			else {
				jsonData.put("result", "error");
				jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
			}

		} catch (Exception e) {
			logger.info("PDA 로그인 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//PDA 메뉴 페이지
	@RequestMapping(value = "/pdsc0070", method = RequestMethod.GET)
	public String pdsc0070GET(Model model) throws Exception {
		logger.info("PDA 메뉴 페이지");

		return "pd/pdsc0070";
	}

	//자재입고
	@RequestMapping(value = "/pdsc0010", method = RequestMethod.GET)
	public String pdsc0010GET(Model model) throws Exception {

		logger.info("PDA 자재입고 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("077"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0010";
	}

	//자재입고 바코드스캔
	@RequestMapping(value = "/io/matrlLocationCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlPreOutWhsData(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리  바코드가출고자재정보 상세조회");
		logger.info(matrlInOutWhsAdmVo.toString());
		try {
			String allLookup = matrlInOutWhsAdmVo.getAllLookup();
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray2 = new JSONArray();
			int xCount = 0; 
			
			if(allLookup.equals("001")){
				logger.info("나는 전체 바코드야");
				List<MatrlInOutWhsAdmVo> barcodeList = matrlInOutWhsAdmService.barcodeList(matrlInOutWhsAdmVo);
				jsonData.put("data3", barcodeList);
				for(int i=0; i<barcodeList.size(); i++) {
					
//					if (barcodeList.get(i).getStatusCd().equals("A") && barcodeList.get(i).getApprovalCd().equals("001")) {
						
						jsonArray.add(barcodeList.get(i));
						
						jsonData.put("data", jsonArray);
						jsonData.put("result", "ok");
//					}else {
						xCount++;
//						jsonArray2.add(barcodeList.get(i));
//						jsonData.put("data2", jsonArray2);
						jsonData.put("xCount", xCount);
//					}
					
				}
			}else if(allLookup.equals("002")) {
				logger.info("나는 개별 바코드야");
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				
				if (matrlInOutWhsAdmVo.getStatusCd().equals("A") && matrlInOutWhsAdmVo.getApprovalCd().equals("001")) {
					jsonData.put("data", matrlInOutWhsAdmVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "수입검사 승인 자재(투입X)만 창고이동이 가능합니다.");
					jsonData.put("result", "fail");
				}
				
			}else if(allLookup.equals("003")) {
				logger.info("나는 검사 바코드야");
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(matrlInOutWhsAdmVo);
				jsonData.put("data", matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");
			}
			
			/*logger.info(matrlInOutWhsAdmVo.toString());
			if (matrlInOutWhsAdmVo != null) {
				if (matrlInOutWhsAdmVo.getStatusCd().equals("A") && matrlInOutWhsAdmVo.getApprovalCd().equals("001")) {
					jsonData.put("data", matrlInOutWhsAdmVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "수입검사 승인 자재(투입X)만 창고이동이 가능합니다.");
					jsonData.put("result", "fail");
				}
			}*/

		} catch (NullPointerException e) {
			logger.info("조회된 값이 없습니다.");
			jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
			jsonData.put("result", "error");
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//자재입고 자재위치 Update
	@RequestMapping(value = "/pd/locationUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationUpdatePOST(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재입고 자재위치 Update " + matrlInOutWhsAdmList);
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();

		try {
			for (Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.debug("m ===> : " + m);
				matrlInOutWhsAdmVo.setBarcodeNo((m.get("barcodeNo").toString()));
				matrlInOutWhsAdmVo.setLocationCd(m.get("locationCd").toString());
				/* matrlInOutWhsAdmVo.setInWhsDate(m.get("inWhsDate").toString()); */
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				logger.info("입출고관리 자재가출고수정처리 out = " + matrlInOutWhsAdmVo);
				PdaService.updatePdaLocation(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("자재입고 자재위치 Update 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//자재출고
	@RequestMapping(value = "/pdsc0020", method = RequestMethod.GET)
	public String pdsc0020GET(Model model) throws Exception {
		logger.info("PDA 자재출고 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("125"); // 층구분자
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("floorCd", systemCommonCodeList);

		return "pd/pdsc0020";
	}
	
	//폐기등록
	@RequestMapping(value = "/pdsc3020", method = RequestMethod.GET)
	public String pdsc3020GET(Model model) throws Exception {

		logger.info("PDA 폐기등록 페이지");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("120"); // 제품 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faultyStatusList", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3020";
	}

	//자재출고 설비명, 제품명 Update
	@RequestMapping(value = "/pd/goodsEquipUpdatePOST", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsEquipUpdatePOST(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 설비명, 제품명 Update " + matrlInOutWhsAdmList);
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		try {
			
			boolean checkQty	= true;
			String failMessage	= "";
			
			//잔량 검사
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("m ===> : " + m);
				matrlInOutWhsAdmVo.setLotNo(null);
				matrlInOutWhsAdmVo.setBarcodeNo(null);
				matrlInOutWhsAdmVo.setBarcodeNo((m.get("barcodeNo").toString()));
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				
				logger.info( "기존 출고량" +Float.parseFloat( m.get("preOutQty").toString() ) );
				logger.info( "출고량" +Float.parseFloat( matrlInOutWhsAdmVo.getRemainQty() ) );
				
				//잔량 변경 시
				if( Float.parseFloat( m.get("preOutQty").toString() ) != Float.parseFloat( matrlInOutWhsAdmVo.getRemainQty() ) ) {
					checkQty = false;
					failMessage = "기존 잔량이 변경되었습니다. 다시 스캔&선택해주세요!";
					break;
				}
				
				logger.info("출고일 --> "+Integer.parseInt( m.get("preOutWhsDate").toString().replaceAll("-", "") ) );
				logger.info("입고일 --> "+Integer.parseInt( matrlInOutWhsAdmVo.getInWhsDate().replaceAll("-", "") ) );
				//출고일 & 입고일 비교
				if( Integer.parseInt( m.get("preOutWhsDate").toString().replaceAll("-", "") ) < Integer.parseInt( matrlInOutWhsAdmVo.getPreInWhsDate().replaceAll("-", "") ) ) {
					checkQty = false;
					failMessage = "출고일 보다 가입고일이 이전에 등록되어 있어야 합니다.<br>스캔&선택을 다시 해주세요!";
					break;
				}
			}
			
			if(checkQty) {
				for (Map<String, Object> m : matrlInOutWhsAdmList) {
					matrlInOutWhsAdmVo.setLotNo(null);
					matrlInOutWhsAdmVo.setBarcodeNo(null);
					matrlInOutWhsAdmVo.setBarcodeNo((m.get("barcodeNo").toString()));
					matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
					
					matrlInOutWhsAdmVo.setPreOutGoodsCd(m.get("preOutGoodsCd").toString());
					matrlInOutWhsAdmVo.setPreOutEquipCd(m.get("preOutEquipCd").toString());
					matrlInOutWhsAdmVo.setPreOutWhsDate(m.get("preOutWhsDate").toString());
					matrlInOutWhsAdmVo.setPreOutQty(m.get("preOutQty").toString());
					matrlInOutWhsAdmVo.setPreWorkCharger(Utils.getUserNumber()); //로그인한 ID의 회원번호
					matrlInOutWhsAdmVo.setStatusCd("O");
					
					//솔브레인 인 경우에만
					if ("003".equals(factoryCode)) {
						matrlInOutWhsAdmVo.setFloorGubun(m.get("floorGubun").toString()); //층 구분자
					}
					
					matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
					logger.info("입출고관리 자재가출고수정처리 = " + matrlInOutWhsAdmVo);
					PdaService.updatePda(matrlInOutWhsAdmVo);
					matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
					StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
					matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
					stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
					matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				}
	
				jsonData.put("data", matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");
			} else {
				if(!failMessage.equals("")) {
					jsonData.put("message", failMessage);	
				}else {
					jsonData.put("message", "알 수 없는 에러가 발생했습니다. 스캔한 자료를 가지고 관리자에게 문의 바랍니다. <br>오류코드:iosc0040-checkQty-failMessage");					
				}
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("자재출고 설비명, 제품명 Update 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//자재상태 변경 바코드 상세 조회
	@RequestMapping(value = "/io/matrlStatusChangeRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlStatusChangeRead(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리  바코드가출고자재정보 상세조회");
		logger.info(matrlInOutWhsAdmVo.toString());
		try {
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			if(matrlInOutWhsAdmVo != null)  {
				logger.info(matrlInOutWhsAdmVo.toString());

				if( (!"P".equals(matrlInOutWhsAdmVo.getStatusCd())) && ("001".equals(matrlInOutWhsAdmVo.getApprovalCd())) ) {
					matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
					jsonData.put("result", "ok");
				} else  {
					jsonData.put("result", "fail");
					jsonData.put("message", matrlInOutWhsAdmVo.getApprovalNm() + "&" + matrlInOutWhsAdmVo.getStatusNm() + " 상태의 자재 입니다.");
				}
			} else {
				logger.info("조회된 값이 없습니다.");
				jsonData.put("message", "조회된 값이 없습니다. BarcodeNo나 LotNo를 확인해주세요.");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			logger.info("입출고관리  바코드가출고자재정보 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		jsonData.put("data", matrlInOutWhsAdmVo);
		return jsonData;
	}
	
	
	//자재 상태 값 수정
	@RequestMapping(value = "/pd/matrlStatusChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlStatusChange(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재출고 설비명, 제품명 Update " + matrlInOutWhsAdmList);
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		try {
			
			for (Map<String, Object> m : matrlInOutWhsAdmList) {
				matrlInOutWhsAdmVo.setLotNo(null);
				matrlInOutWhsAdmVo.setBarcodeNo(null);
				matrlInOutWhsAdmVo.setBarcodeNo((m.get("barcodeNo").toString()));
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setStatusCd("P");
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				logger.info("입출고관리 자재가출고수정처리 = " + matrlInOutWhsAdmVo);
				PdaService.updatePda(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
				StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
				stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
				/*
				matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
				stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				*/
			}

			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("자재출고 설비명, 제품명 Update 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	//자재입고
	@RequestMapping(value = "/pdsc0030", method = RequestMethod.GET)
	public String pdsc0030GET(Model model) throws Exception {

		logger.info("PDA 제품입고 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0030";
	}
	
	//자재입고
	@RequestMapping(value = "/pdsc2030", method = RequestMethod.GET)
	public String pdsc2030GET(Model model) throws Exception {

		logger.info("PDA 제품입고 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc2030";
	}
	
	//자재입고_3공장_F3
	@RequestMapping(value = "/pdsc3030", method = RequestMethod.GET)
	public String pdsc3030GET(Model model) throws Exception {

		logger.info("PDA 제품입고 페이지_F3");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc3030";
	}

	//자재 입고 boxNo 스캔
	//@RequestMapping(value = "/", method = RequestMethod.GET)
	//public String goodsProductInfoDataGET(Model model) throws Exception {
	//	
	//	return "pd/pdsc0010";
	//}

	//제품 입고 boxNo 스캔
	@RequestMapping(value = "/pd/goodsProductInfoData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoDataGET(GoodsProductInfoAdmVo goodsProductInfoAdmVo, SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("PDA boxNo 스캔");
		try {
			
			String restock = goodsProductInfoAdmVo.getRestock();
			String poModelNoCheck = goodsProductInfoAdmVo.getPoModelNo();
			
			String poSeq		= goodsProductInfoAdmVo.getPoSeq();
			String poGroup		= goodsProductInfoAdmVo.getPoGroup();
			Boolean addPallet	= Boolean.parseBoolean( goodsProductInfoAdmVo.getAddPallet() );
			
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			logger.info("조회 값 : " + goodsProductInfoAdmVo);
			
			//getGoodsStatus == 003 -> 제품출고
			if (goodsProductInfoAdmVo == null) {
				jsonData.put("message", "조회된 BoxNo가 없습니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else {
				if (goodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", "이미 출하된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", "폐기된 BoxNo 입니다.");
					jsonData.put("result", "fail");
				//} else if (!goodsProductInfoAdmVo.getGoodsStatus().equals("001")) { ->불량제품이여도 불량창고로 입고되어야 하기에
				//	jsonData.put("message", "정상 상태의 제품이 아닙니다.");
				//	jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDivisionYn().equals("D")) {
					jsonData.put("message", "분할된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDivisionYn().equals("M")) {
					jsonData.put("message", "병합된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else {
					if (factoryCode.equals("001") || factoryCode.equals("002")) {
						if("no".equals(restock) && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
							jsonData.put("message", "이미 입고된 제품입니다.<br>재입고를 원할 경우 재입고 체크박스를 선택해 주세요!");
							jsonData.put("result", "fail");
							return jsonData;
						}
					} else if(factoryCode.equals("003")) {
						if(goodsProductInfoAdmVo.getCompleteYn() != null && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
							jsonData.put("message", "이미 파레트 포장된 제품입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
						//23.07.06추가
						if("006".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
							jsonData.put("message", "출하검사완료된 상태입니다.<br>제품입고 전 스캔을 지정해주세요.");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
						if ( !goodsProductInfoAdmVo.getModelNo().equals(poModelNoCheck)) {
							jsonData.put("message", "PO Number가 다릅니다 다시 선택 해주세요.");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
						if(!"001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
							jsonData.put("message", "정상인 제품이 아닙니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
						if("003".equals(goodsProductInfoAdmVo.getDisposeGubun())) {
							jsonData.put("message", "폐기지정된 제품입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
						if( !addPallet ) {
							//(현)파레트가 완공 상태인지 확인
							PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
							purchaseOrderDtl.setPoSeq(poSeq);
							purchaseOrderDtl.setPoGroup(poGroup);
							List<PurchaseOrderDtl> purchaseOrderDtlData = purchaseOrderAdmService.inspectList(purchaseOrderDtl);
							
							if( purchaseOrderDtlData.size() == 0 ) {
								jsonData.put("result", "fail");
								jsonData.put("message", "파레트번호가 존재 하지 않습니다.");
								return jsonData;
							}
							if( purchaseOrderDtlData.get(0).getCompleteYn().equals("Y") ) {
								jsonData.put("result", "fail");
								jsonData.put("message", "이미 완공 처리된 파레트번호입니다.<br>파레트 번호를 확인해주세요.");
								return jsonData;
							}
							//(현)파레트가 완공 상태인지 확인
						}
					}
					
					//MTP 1,2공장(성남)
//					if ("001".equals(factoryCode) || "002".equals(factoryCode)) {
					
					if ("001".equals(factoryCode) || "002".equals(factoryCode)) {
						systemCommonCodeVo.setBaseGroupCd("004"); // Location
						systemCommonCodeVo.setEtc2(goodsProductInfoAdmVo.getModelNo());
						systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
						
						if (systemCommonCodeVo == null) {
							jsonData.put("message", "해당 제품의 ModelNo와 일치하는 창고코드의 체크2가 없습니다!<br>제품정보&창고코드를 확인해 주세요!");
							jsonData.put("result", "fail");
							return jsonData;
						}
						jsonData.put("locationCd", systemCommonCodeVo.getBaseCd());
					}
						//선택한 창고정보의 ModelNo(etc2)와 제품정보의 ModelNo정보가 같은지 확인
//						if (systemCommonCodeVo.getEtc2().equals(goodsProductInfoAdmVo.getModelNo())) {
							
							//트레이 출하검사 여부 확인
//							if ( "001".equals(factoryCode) || "002".equals(factoryCode) ) {
								//분할&병합된 박스는 출하검사 확인 안함
								if ( goodsProductInfoAdmVo.getMergeYn() == null ) {
										ShipInspectVo shipInspectVoByTray3 = new ShipInspectVo();
										String trayNo = goodsProductInfoAdmVo.getBoxNo();

									//1공장에서는 3개짜리 트레이 번호를 사용하지 않음.
									//기존 BoxNo가 아닌 신규 트레이 BoxNo인 경우에만 실행
									if( trayNo.length() != 13 || "003".equals(factoryCode) ) {
										shipInspectVoByTray3.setTrayNo(trayNo);
										shipInspectVoByTray3 = shipInspectService.shipInspectAdmSelByGoodsIn(shipInspectVoByTray3);
										
										//3개짜리 트레이 번호가 없을 때 실행
										if (shipInspectVoByTray3 == null) {
											ShipInspectVo shipInspectVoByTray6 = new ShipInspectVo();
											
											trayNo = trayNo.length() != 13 ? trayNo.substring(0, trayNo.length() - 2) : trayNo;
											shipInspectVoByTray6.setTrayNo(trayNo);
											shipInspectVoByTray6 = shipInspectService.shipInspectAdmSelByGoodsIn(shipInspectVoByTray6);
											
											if( shipInspectVoByTray6 != null ) {
												//출하검사 상태가 합격이 아니면
												if (!"001".equals(shipInspectVoByTray6.getInspStatus())) {
													jsonData.put("message", shipInspectVoByTray6.getReInspStatusNm() + " 합격 제품이 아닙니다!");
													jsonData.put("result", "fail");
													return jsonData;
													
												//출하검사 폐기가 정상이 아니면
												} else if (!"002".equals(shipInspectVoByTray6.getDisStatus())) {
													jsonData.put("message", "폐기 상태의 제품입니다!");
													jsonData.put("result", "fail");
													return jsonData;
												}
											}
										} else {
											//3개짜리 트레이 번호가 있을 때 실행
											
											if( shipInspectVoByTray3 != null ) {
												//출하검사 상태가 합격이 아니면
												if (!"001".equals(shipInspectVoByTray3.getInspStatus())) {
													jsonData.put("message", shipInspectVoByTray3.getReInspStatusNm() + " 합격 제품이 아닙니다!");
													jsonData.put("result", "fail");
													return jsonData;
													
												//출하검사 폐기가 정상이 아니면
												} else if (!"002".equals(shipInspectVoByTray3.getDisStatus())) {
													jsonData.put("message", "폐기 상태의 제품입니다!");
													jsonData.put("result", "fail");
													return jsonData;
												//출하검사 폐기가 정상이 아니면
												} else if ("002".equals(shipInspectVoByTray3.getReInspStatus())) {
													jsonData.put("message", "출하재검을 진행해 주세요!");
													jsonData.put("result", "fail");
													return jsonData;
												}
											}
										}
									}
								}
//							}
							
							//jsonData.put("locationCd", systemCommonCodeVo.getBaseCd());
							jsonData.put("data", goodsProductInfoAdmVo);
							jsonData.put("result", "ok");
							
//						} else {
//							jsonData.put("message", "창고 ModelNo 정보와 제품 ModelNo 정보가 다릅니다.<br>제품정보를 확인해주세요!");
//							jsonData.put("result", "fail");
//						}
						
					//SLD 3공장(파주)
					/*} else if ("003".equals(factoryCode)) {
						jsonData.put("data", goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					}*/
				}
			}
		} catch (Exception e) {
			logger.info("제품입고 boxNo 스캔 실패");
			e.printStackTrace();
			jsonData.put("message", "BoxNo 조회 실패하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	//제품 입고  trayNo (3) 스캔
	@RequestMapping(value = "/pd/goodsProductInfoDataTray", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoDataTrayGET(GoodsProductInfoAdmVo goodsProductInfoAdmVo, SystemCommonCodeVo systemCommonCodeVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("PDA boxNo 스캔");

		try {
			String restock = goodsProductInfoAdmVo.getRestock();
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			String labelLotSeq = goodsProductInfoAdmVo.getBoxNo();
			productionPerfTrayVo.setLabelLotNoSeq(labelLotSeq);
			
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);

			logger.info("조회 값 : " + goodsProductInfoAdmVo);
			//getGoodsStatus == 003 -> 제품출고
			if (goodsProductInfoAdmVo == null) {
				jsonData.put("message", "조회된 TrayNo가 없습니다.");
				jsonData.put("result", "fail");
			} else {
				
			
				
				
				if (goodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", "이미 출하된 TrayNo 입니다.");
					jsonData.put("result", "fail");
				} else if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", "폐기된 TrayNo 입니다.");
					jsonData.put("result", "fail");			
				} else if ("no".equals(restock) && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
					jsonData.put("message", "이미 입고된 제품입니다.<br>재입고를 원할 경우 재입고 체크박스를 선택해 주세요!");
					jsonData.put("result", "fail");
					
				} else {
					//MTP 1,2공장(성남)
					if ("001".equals(factoryCode) || "002".equals(factoryCode)) {
						systemCommonCodeVo.setBaseGroupCd("004"); // Location
						systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
						
						//선택한 창고정보의 ModelNo(etc2)와 제품정보의 ModelNo정보가 같은지 확인
						if (systemCommonCodeVo.getEtc2().equals(goodsProductInfoAdmVo.getModelNo())) {
							
							//List<GoodsProductInfoAdmVo> goodsProductWorkOrdList = PdaService.goodsProductWorkOrdList(goodsProductInfoAdmVo);
							boolean sealingTemp = true;				
							
							//실링검사 이상없을 경우
							if (sealingTemp) {
								List<ProductionPerfTrayVo> productionPerfTrayList = new ArrayList<ProductionPerfTrayVo>();
								if(labelLotSeq.length() != 13) {
									logger.info("이게 뭐지!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + productionPerfTrayVo.getLabelLotNoSeq());
									 productionPerfTrayList = productionPerfTrayService.trayLabelSelect(productionPerfTrayVo);
									 jsonData.put("data2", productionPerfTrayList);
								} else {
									productionPerfTrayVo.setLabelLotNo("");
									productionPerfTrayList.add(productionPerfTrayVo);
									jsonData.put("data2",productionPerfTrayList );
								}
								jsonData.put("data", goodsProductInfoAdmVo);
								
								
								jsonData.put("result", "ok");
							}
							
						} else {
							jsonData.put("message", "창고 ModelNo 정보와 제품 ModelNo 정보가 다릅니다.<br>제품정보를 확인해주세요!");
							jsonData.put("result", "fail");
						}
						
					//SLD 3공장(파주)
					} else if ("003".equals(factoryCode)) {
						jsonData.put("data", goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					}
				}
			}
		} catch (Exception e) {
			logger.info("제품입고 boxNo 스캔 실패");
			e.printStackTrace();
			jsonData.put("message", "BoxNo 조회 실패하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//제품 입고 trayNo (6) 스캔
	@RequestMapping(value = "/pd/goodsProductInfoDataTraySix", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoDataTraySixGET(GoodsProductInfoAdmVo goodsProductInfoAdmVo, SystemCommonCodeVo systemCommonCodeVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("PDA boxNo 스캔");

		try {
			String restock = goodsProductInfoAdmVo.getRestock();
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			productionPerfTrayVo.setLabelLotNo(goodsProductInfoAdmVo.getBoxNo());
			String LabelNo = goodsProductInfoAdmVo.getBoxNo();
			
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.trayLabelSelect(productionPerfTrayVo);
			GoodsProductInfoAdmVo goodsProductInfoAdmVo2 = new GoodsProductInfoAdmVo();
						
			goodsProductInfoAdmVo.setBoxNo(productionPerfTrayList.get(0).getLabelLotNoSeq());
			goodsProductInfoAdmVo2.setBoxNo(productionPerfTrayList.get(1).getLabelLotNoSeq());
			
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			goodsProductInfoAdmVo2  = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo2);
			
			
			
			
			logger.info("조회 값 : " + goodsProductInfoAdmVo);
			//getGoodsStatus == 003 -> 제품출고
			if (goodsProductInfoAdmVo == null) {
				jsonData.put("message", "조회된 TrayNo가 없습니다.");
				jsonData.put("result", "fail");
			} else {				
				if (goodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", "이미 출하된 TrayNo 입니다.");
					jsonData.put("result", "fail");
				} else if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", "폐기된 TrayNo 입니다.");
					jsonData.put("result", "fail");	
				} else if ("no".equals(restock) && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
					jsonData.put("message", "이미 입고된 제품입니다.<br>재입고를 원할 경우 재입고 체크박스를 선택해 주세요!");
					jsonData.put("result", "fail");
					
				} else {
					//MTP 1,2공장(성남)
					if ("001".equals(factoryCode) || "002".equals(factoryCode)) {
						systemCommonCodeVo.setBaseGroupCd("004"); // Location
						systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
						
						//선택한 창고정보의 ModelNo(etc2)와 제품정보의 ModelNo정보가 같은지 확인
						if (systemCommonCodeVo.getEtc2().equals(goodsProductInfoAdmVo.getModelNo())) {							
					
							boolean sealingTemp = true;		
							
							//실링검사 이상없을 경우
							if (sealingTemp) {								
								jsonData.put("data", goodsProductInfoAdmVo);	
								jsonData.put("data2", goodsProductInfoAdmVo2);	
								jsonData.put("data3", LabelNo);
								jsonData.put("result", "ok");
							}
							
						} else {
							jsonData.put("message", "창고 ModelNo 정보와 제품 ModelNo 정보가 다릅니다.<br>제품정보를 확인해주세요!");
							jsonData.put("result", "fail");
						}
						
					//SLD 3공장(파주)
					} else if ("003".equals(factoryCode)) {
						jsonData.put("data", goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					}
				}
			}
		} catch (Exception e) {
			logger.info("제품입고 boxNo 스캔 실패");
			e.printStackTrace();
			jsonData.put("message", "BoxNo 조회 실패하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//제품입고 Location Update
	@RequestMapping(value = "/pd/updateProductLocation", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateProductLocationPOST(@RequestBody List<Map<String, Object>> goodsProductInfoAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품입고 Location Update " + goodsProductInfoAdmList);
		GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();

		try {
			boolean check = true;
			for (Map<String, Object> m : goodsProductInfoAdmList) {
				GoodsProductInfoAdmVo readGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				readGoodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
				readGoodsProductInfoAdmVo = PdaService.readGoodsProductInfo(readGoodsProductInfoAdmVo);
				
				//입고 전 제품 상태 체크
				if (readGoodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 이미 출하된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 폐기된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				//} else if (!readGoodsProductInfoAdmVo.getGoodsStatus().equals("001")) {
				//	jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 정상 상태의 제품이 아닙니다.");
				//	jsonData.put("result", "fail");
				//	check = false;
				//	break;
				} else if (readGoodsProductInfoAdmVo.getDivisionYn().equals("D")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 분할된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDivisionYn().equals("M")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 병합된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				}
				
				//입고 전 실링검사결과 체크
				//List<GoodsProductInfoAdmVo> goodsProductWorkOrdList = PdaService.goodsProductWorkOrdList(readGoodsProductInfoAdmVo);
				//for (int i=0; i<goodsProductWorkOrdList.size(); i++) {
				//	if (check) {
				//		if (goodsProductWorkOrdList.get(i).getSealingDate() == null) {
				//			check = false;
				//			jsonData.put("message", "실링검사가 입력되지 않았습니다!<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo());
				//			jsonData.put("result", "fail");
				//			break;
				//		} else if (goodsProductWorkOrdList.get(i).getSealing1() < 1) {
				//			check = false;
				//			jsonData.put("message", "실링검사결과 불합격 작지입니다. 입고시킬 수 없습니다!<br>실효1값 : " + goodsProductWorkOrdList.get(i).getSealing1() + " 불합격 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo());
				//			jsonData.put("result", "fail");
				//			break;
				//		} else if (goodsProductWorkOrdList.get(i).getSealing2() < 1) {
				//			check = false;
				//			jsonData.put("message", "실링검사결과 불합격 작지입니다. 입고시킬 수 없습니다!<br>실효2값 : " + goodsProductWorkOrdList.get(i).getSealing2() + " 불합격 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo());
				//			jsonData.put("result", "fail");
				//			break;
				//		} else if ("Y".equals(goodsProductWorkOrdList.get(i).getFilmFaultyCheck())) {
				//			check = false;
				//			jsonData.put("message", "필름 외관이상 제품입니다. 입고시킬 수 없습니다!<br>필름 외관이상 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo());
				//			jsonData.put("result", "fail");
				//			break;
				//		}
				//	}
				//}
				
			}

			if (check) {
				for (Map<String, Object> m : goodsProductInfoAdmList) {
					goodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
					goodsProductInfoAdmVo.setLocationCd(m.get("locationCd").toString());
					goodsProductInfoAdmVo.setGoodsInDate(m.get("goodsInDate").toString());
					goodsProductInfoAdmVo.setGoodsStatus("002");
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
					
					
					//제품 update를 먼저하면 재입고인지 확인이 안되어 수불을 먼저 등록!
					GoodsProductInfoAdmVo readGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
					readGoodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
					readGoodsProductInfoAdmVo = PdaService.readGoodsProductInfo(readGoodsProductInfoAdmVo);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
					//재입고이면
					if ("002".equals(readGoodsProductInfoAdmVo.getGoodsStatus())) {
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "O", "008", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);	
					
					//최초 입고이면
					} else {
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "O", "007", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);
					}
					stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
					
					StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
					goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "I", "008", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);
					stockPaymentAdmService.stockPaymentPlus(goodsLocationIn);
					
					
					
					logger.info("제품 입고 Location Update : " + goodsProductInfoAdmVo);
					PdaService.updateProductLocation(goodsProductInfoAdmVo);
					PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
					
				}
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			logger.info("제품입고 위치 지정 실패");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//3공장 파레트 포장
	@RequestMapping(value = "/pd/updateProductLocation_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateProductLocation_F3(@RequestBody List<Map<String, Object>> goodsProductInfoAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			logger.info("제품입고 Location Update " + goodsProductInfoAdmList);
			
			GoodsProductInfoAdmVo goodsProductInfoAdmVo			= new GoodsProductInfoAdmVo();
			PurchaseOrderAdmVo purchaseOrderAdmVo				= new PurchaseOrderAdmVo();			//PO정보
			PurchaseOrderAdmVo poGroupInfoVo					= new PurchaseOrderAdmVo();			//PO정보
			PurchaseOrderOutputHistVo purchaseOrderOutputHistVo	= new PurchaseOrderOutputHistVo();	//PO정보 기록
			
			boolean check			= true;	//오류 체크
			int userOutputCntSum	= 0;	//
			String poGroup			= "";	//모델명(품명) + 파레트 포장일 + 시퀀스(16200035A22102801)
			int sum					= 0;	//
			
			//파레트 (true/false)
			Boolean addPallet = Boolean.parseBoolean( goodsProductInfoAdmList.get(0).get("addPallet").toString() );

			//입고 전 제품 상태 체크
			for (Map<String, Object> m : goodsProductInfoAdmList) {
				GoodsProductInfoAdmVo readGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				readGoodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
				readGoodsProductInfoAdmVo = PdaService.readGoodsProductInfo(readGoodsProductInfoAdmVo);
				
				if (readGoodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 이미 출하된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 폐기된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDivisionYn().equals("D")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 분할된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDivisionYn().equals("M")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 병합된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if(goodsProductInfoAdmVo.getCompleteYn() != null && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
					jsonData.put("message", "이미 파레트 포장된 제품입니다.");
					jsonData.put("result", "fail");
					check = false;
					return jsonData;
				}
				
				userOutputCntSum += Integer.parseInt(m.get("userOutputCnt").toString());
			}
			//입고 전 제품 상태 체크
			
			//입고시킬 PO정보를 가져옴
			String poSeq = goodsProductInfoAdmList.get(0).get("poSeq").toString();
			purchaseOrderAdmVo.setPoSeq(poSeq);
			purchaseOrderAdmVo = purchaseOrderAdmService.read(purchaseOrderAdmVo);
			//입고시킬 PO정보를 가져옴
			
			//출고수량 > 미출고수량 인지 확인
			logger.info("purchaseOrderAdmVo" +purchaseOrderAdmVo);
			if( purchaseOrderAdmVo != null ) {
				if (userOutputCntSum > purchaseOrderAdmVo.getRemainQty()) {
					logger.info("출고수량 > 미출고수량 인 경우");
					jsonData.put("result", "fail");
					jsonData.put("message", "입고수량이 " + userOutputCntSum + "으로 미출고수량보다 많습니다!<br>PO정보를 확인해주세요.");
					check = false;
					return jsonData;
				}
			}
			//출고수량 > 미출고수량 인지 확인

			//파레트 포장 시작
			if (check) {
				
				//poGroup 값 담아주는 부분
				if ( !addPallet ) {
					//기존 파래트가 있어 파레트 추가를 선택 하지 않은 경우(기존 파레트 번호 사용)
					poGroup = goodsProductInfoAdmList.get(0).get("poGroup").toString();

					//(현)파레트가 완공 상태인지 확인
					PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
					purchaseOrderDtl.setPoSeq(poSeq);
					purchaseOrderDtl.setPoGroup(poGroup);
					List<PurchaseOrderDtl> purchaseOrderDtlData = purchaseOrderAdmService.inspectList(purchaseOrderDtl);
					
					if( purchaseOrderDtlData.size() == 0 ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "파레트번호가 존재 하지 않습니다.");
						return jsonData;
					}
					if( purchaseOrderDtlData.get(0).getCompleteYn().equals("Y") ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 완공 처리된 파레트번호입니다.");
						return jsonData;
					}
					//(현)파레트가 완공 상태인지 확인
					
				} else {
					//파레트 추가가 선택 되어 신규인 경우(신규 파레트 번호채번)
					purchaseOrderAdmVo.setPoSeq(poSeq);
					purchaseOrderAdmVo.setPoDate( goodsProductInfoAdmList.get(0).get("deliveryDate").toString() );
					poGroupInfoVo	= PdaService.selectPoGroup_F3(purchaseOrderAdmVo);
					
					//솔브레인 파레트 번호 : 16200045A2022103001(모델명+포장일(입고일)+시퀀스) (Old)
					//솔브레인 파레트 번호 : 202211280012022120601(등록번호+납기일+시퀀스) (New)
					String s_poSeq	= goodsProductInfoAdmList.get(0).get("poSeq").toString().replaceAll("-", "");
					String s_date	= goodsProductInfoAdmList.get(0).get("deliveryDate").toString();
					String s_seq	= poGroupInfoVo.getPoGroup();
					poGroup			=  s_poSeq + s_date +s_seq;
				}
				//poGroup 값 담아주는 부분
				
				purchaseOrderOutputHistVo.setPoGroup(poGroup);
				
				//poNoSeq 불러오는 부분
				PurchaseOrderDtl purchaseOrderDtl2 = new PurchaseOrderDtl();
				purchaseOrderDtl2.setPoSeq(poSeq);
				purchaseOrderDtl2.setPoGroup(poGroup);
				int poNoSeq = Integer.parseInt(purchaseOrderAdmService.purchaseOrderPoNoSeq(purchaseOrderDtl2));
				//poNoSeq 불러오는 부분
					
				List<PurchaseOrderDtl> newList = new ArrayList<PurchaseOrderDtl>();
				for (Map<String, Object> m : goodsProductInfoAdmList) {
						
					sum += Integer.parseInt(m.get("userOutputCnt").toString());
					
					//PDA 자재입고 Location Update
					goodsProductInfoAdmVo.setGoodsStatus("002");								//제품 입출고 상태
					goodsProductInfoAdmVo.setCompleteYn("N");									//미료: N /완료: Y
					goodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));				//박스번호
					//goodsProductInfoAdmVo.setLocationCd(m.get("locationCd").toString());		//창고지정
					goodsProductInfoAdmVo.setGoodsInDate(m.get("goodsInDate").toString());		//입고일(파레트포장 일)
					goodsProductInfoAdmVo.setCustomerLotNo(m.get("customerLotNo").toString());	//고객사 LotNo
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
					
					PdaService.updateProductLocation(goodsProductInfoAdmVo);	//파레트 포장(입고)
					PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);	//생산제품 상태변경 기록
					//PDA 자재입고 Location Update
				
					//insertDtl 값 담아주는 부분 시작
					PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
					purchaseOrderDtl.setPoSeq(poSeq);														//PO등록번호
					purchaseOrderDtl.setPoGroup(poGroup);													//3공장에서는 이 컬럼을 파레트 번호로 사용함
					purchaseOrderDtl.setGoodsCd(m.get("goodsCd").toString());								//제품코드
					purchaseOrderDtl.setBoxNo(m.get("boxNo").toString());									//박스번호
					purchaseOrderDtl.setPackCnt( Integer.parseInt(m.get("packCnt").toString()) );			//포장수량
					purchaseOrderDtl.setOutputCnt( Integer.parseInt(m.get("userOutputCnt").toString()) );	//출고수량	-> 포장 수량
					purchaseOrderDtl.setCompleteYn("N");													//미료: N /완료: Y						
					purchaseOrderDtl.setPoDate(m.get("goodsInDate").toString());							//출하일
					purchaseOrderDtl.setRegId(Utils.getUserId());											//생성자

					//출하 기록 생성
					newList.add(purchaseOrderDtl);
					//insertDtl 값 담아주는 부분 종료
				}
				
				//insertDtl
				Collections.reverse(newList);
				for (PurchaseOrderDtl m : newList) {					
					m.setPoNoSeq(Integer.toString(poNoSeq)); 					
					purchaseOrderAdmService.createPurchaseOrderDtl(m);
					poNoSeq++;
				}
				//insertDtl
				
				
				//PO기록 수정
				//파레트 적재 추가일 경우(2공장 기준으로 1,3공장 만듬)
				if ( !addPallet ) {
					//추가한 파레트 부터 이후 파레트까지 출고이력 보정
					purchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq().toString());
					purchaseOrderOutputHistVo.setPoGroup(poGroup);
					purchaseOrderOutputHistVo.setOutputQty(sum);									//추가 출고 수량
					purchaseOrderAdmService.addTrayByPallet_F3(purchaseOrderOutputHistVo);
					
				} else {
					purchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq().toString());
					purchaseOrderOutputHistVo.setPoNo(purchaseOrderAdmVo.getPoNo().toString());
					purchaseOrderOutputHistVo.setPreOutputQty(purchaseOrderAdmVo.getOutputQty());
					purchaseOrderOutputHistVo.setOutputQty(sum);
					purchaseOrderOutputHistVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() - sum);
					purchaseOrderOutputHistVo.setOutputHistDate((goodsProductInfoAdmList.get(0).get("goodsInDate").toString()));
					purchaseOrderOutputHistVo.setApprovalCd("002");
					purchaseOrderOutputHistVo.setCompleteYn("N");
					purchaseOrderOutputHistVo.setRegId(Utils.getUserId());
					purchaseOrderOutputHistVo.setOutputGubun("001");
					purchaseOrderAdmService.histCreate(purchaseOrderOutputHistVo);
				}
				
				purchaseOrderAdmVo.setUpdId(Utils.getUserId());
				purchaseOrderAdmVo.setOutputQty(purchaseOrderAdmVo.getOutputQty() + sum); //출고수량 누적+
				purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() - sum); //미출고수량 누적-
				purchaseOrderAdmService.updateQty(purchaseOrderAdmVo);
			}
			//PO기록 수정 끝

			//완공인 경우 해당 파레트 관련 전체 처리 ( 미료 -> 완공 / 입고 -> 출고 대기 로 변경 ) 
			/*if( Boolean.parseBoolean(goodsProductInfoAdmList.get(0).get("completeYn").toString()) ) {
				GoodsProductInfoAdmVo goodsProductInfoAdmVo2 = new GoodsProductInfoAdmVo();
				goodsProductInfoAdmVo.setGoodsStatus("004");	//제품 입출고 상태 - 출하대기상태로 변경
				goodsProductInfoAdmVo.setCompleteYn("Y");		//미료: N /완료: Y
				goodsProductInfoAdmVo.setPoGroup(poGroup);
				goodsProductInfoAdmVo.setPoSeq(poSeq);
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				
				//PDA 제품 출하대기 Update
				PdaService.palletRelatedProductUpdate_F3(goodsProductInfoAdmVo);
			}*/
			
			jsonData.put("data", purchaseOrderOutputHistVo);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("제품입고 위치 지정 실패");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	//제품입고 Location Update (tray)
	@RequestMapping(value = "/pd/updateProductLocationTray", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateProductLocationTrayPOST(@RequestBody List<Map<String, Object>> goodsProductInfoAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품입고 Location Update " + goodsProductInfoAdmList);
		GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();

		try {
			boolean check = true;
			for (Map<String, Object> m : goodsProductInfoAdmList) {
				GoodsProductInfoAdmVo readGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				readGoodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
				readGoodsProductInfoAdmVo = PdaService.readGoodsProductInfo(readGoodsProductInfoAdmVo);
				
				//입고 전 제품 상태 체크
				if (readGoodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 이미 출하된 제품 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;
				} else if (readGoodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", readGoodsProductInfoAdmVo.getBoxNo() + "는 폐기된 제품 입니다.");
					jsonData.put("result", "fail");
					check = false;
					break;		
				}			
				
			}

			if (check) {
				for (Map<String, Object> m : goodsProductInfoAdmList) {
					goodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
					goodsProductInfoAdmVo.setLocationCd(m.get("locationCd").toString());
					goodsProductInfoAdmVo.setGoodsInDate(m.get("goodsInDate").toString());
					goodsProductInfoAdmVo.setGoodsStatus("002");
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
					
					
					//제품 update를 먼저하면 재입고인지 확인이 안되어 수불을 먼저 등록!
					GoodsProductInfoAdmVo readGoodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
					readGoodsProductInfoAdmVo.setBoxNo((m.get("boxNo").toString()));
					readGoodsProductInfoAdmVo = PdaService.readGoodsProductInfo(readGoodsProductInfoAdmVo);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
					//재입고이면
					if ("002".equals(readGoodsProductInfoAdmVo.getGoodsStatus())) {
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "O", "008", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);	
					
					//최초 입고이면
					} else {
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "O", "007", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);
					}
					stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
					
					StockPaymentAdmVo goodsLocationIn = new StockPaymentAdmVo();
					goodsLocationIn = StockPaymentAdmController.goodsStockPaymentHist(readGoodsProductInfoAdmVo.getGoodsCd(), readGoodsProductInfoAdmVo.getBoxNo(), "002", "I", "008", Integer.parseInt(readGoodsProductInfoAdmVo.getPackCnt()), factoryCode);
					stockPaymentAdmService.stockPaymentPlus(goodsLocationIn);
					
					
					
					logger.info("제품 입고 Location Update : " + goodsProductInfoAdmVo);
					PdaService.updateProductLocation(goodsProductInfoAdmVo);
					PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
					
				}
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			logger.info("제품입고 위치 지정 실패");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	
	//제품출고 목록
	@RequestMapping(value = "/pd/goodsProductInfoAdmData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoAdmData(GoodsProductInfoAdmVo goodsProductInfoAdmVo, PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
		logger.info("제품생산정보관리 " + goodsProductInfoAdmVo);
		String exceptBoxNo = goodsProductInfoAdmVo.getExceptBoxNo();
		
		try {
			logger.info(goodsProductInfoAdmVo.getBoxNo());
			//String goodsFifoCheck = goodsProductInfoAdmVo.getGoodsFifoCheckCd();
			
			//재고 제품인 경우
			if (goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S")) {
				preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
				preGoodsInventoryDtl.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
				//preGoodsInventoryDtl.setOrderGubunCd(goodsProductInfoAdmVo.getOrdGubun());	-> 머티 요청으로 해당PO에 제품코드만 일치하면 됨 같은제품의 다른타입(해외1,2,국내)가 출하 될 수 있음
				preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
				if (preGoodsInventoryDtl != null) {
					if (preGoodsInventoryDtl.getRemainCnt() == 0) {
						jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (!"001".equals(preGoodsInventoryDtl.getFaultyStatus().toString())) {
						jsonData.put("message", preGoodsInventoryDtl.getFaultyStatusNm() + " 상태의 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					/**************** 추가한 부분 *********************/
					preGoodsInventoryAdmVo = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryAdmVo);
					
					SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
					systemCommonCodeVo.setBaseGroupCd("063"); //제품 선입선출
					systemCommonCodeVo.setEtc1("Y");
					systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
					
					if(systemCommonCodeVo != null) {
						preGoodsInventoryAdmVo.setGoodsFifoCheckCd(systemCommonCodeVo.getBaseCd());
						preGoodsInventoryAdmVo.setGoodsFifoCheckNm(systemCommonCodeVo.getBaseCdNm());
					}else {
						preGoodsInventoryAdmVo.setGoodsFifoCheckCd("003");
						preGoodsInventoryAdmVo.setGoodsFifoCheckNm("초기재고 미적용");
					}
					
					logger.info("System코드 확인하기 --------------> " +systemCommonCodeVo.getBaseCd());
					
					//제품 선입선출 적용(통제), 옵션 선택이 되어있지 않아도
					if (systemCommonCodeVo == null || "001".equals(systemCommonCodeVo.getBaseCd())) {
						//이미 스캔한 boxNo 들 선입선출 대상에서 제외
						boolean firstScanCheck = exceptBoxNo.contains("empty");
						String exceptBoxNoQuery = exceptBoxNo.replace("/", "', '");	
						logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
						//최초스캔이면..
						if (firstScanCheck) {
							
						//이미 몇번 스캔하였으면..
							
						} else {
							exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
							exceptBoxNoQuery += "'";
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);								
						}
						preGoodsInventoryAdmVo.setExceptBoxNo(exceptBoxNoQuery);
						preGoodsInventoryDtl = PdaService.preGoodsInventoryFifoCheck(preGoodsInventoryAdmVo);
						
						if ("Y".equals(preGoodsInventoryDtl.getBoxNo())) {
							jsonData.put("fifoCheck", "yes");
							jsonData.put("message", "추가되었습니다.");
							
						} else {
//							jsonData.put("fifoCheck", "no");
//							jsonData.put("message1", "선입선출 해야할 입고된 생산제품이 존재합니다.");
//							jsonData.put("message2", "포장번호 : " + preGoodsInventoryDtl.getBoxNo());
//							jsonData.put("message3", "선입선출 대상 총 개수 : " + preGoodsInventoryDtl.getGoodsFifoCount());
							
							List<PreGoodsInventoryAdmVo> preGoodsInventoryFifoCheckList = PdaService.preGoodsInventoryFifoCheckList(preGoodsInventoryAdmVo);
							logger.info("선입선출 목록 : "+preGoodsInventoryFifoCheckList);
							
							jsonData.put("fifoCheck", "no");
							jsonData.put("message1", "선입선출 해야할 입고된 생산제품이 존재합니다.");
							jsonData.put("message2", "선 출하 포장번호 : " + preGoodsInventoryDtl.getBoxNo());
							jsonData.put("message3", "선입선출 대상 총 개수 : " + preGoodsInventoryFifoCheckList.size()+ "개");
							jsonData.put("checkList", preGoodsInventoryFifoCheckList);
						}
						
					//제품 선입선출 적용(확인)
					} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
						//이미 스캔한 boxNo 들 선입선출 대상에서 제외
						boolean firstScanCheck = exceptBoxNo.contains("empty");
						String exceptBoxNoQuery = exceptBoxNo.replace("/", "', '");
						logger.info("exceptBoxNoQuery : " +exceptBoxNoQuery);
						//최초스캔이면..
						if (firstScanCheck) {
							
						//이미 몇번 스캔하였으면..
							
						} else {
							exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
							exceptBoxNoQuery += "'";
							logger.info("exceptBoxNoQuery2 ---> " +exceptBoxNoQuery);								
						}
						preGoodsInventoryAdmVo.setExceptBoxNo(exceptBoxNoQuery);
						logger.info("preGoodsInventoryAdmVo : " +preGoodsInventoryAdmVo);
						logger.info("preGoodsInventoryAdmVo : " +preGoodsInventoryAdmVo.getGoodsInDate());
						preGoodsInventoryDtl = PdaService.preGoodsInventoryFifoCheck(preGoodsInventoryAdmVo);
						
						if ("Y".equals(preGoodsInventoryDtl.getBoxNo())) {
							jsonData.put("fifoCheck", "yes");
							jsonData.put("message", "추가되었습니다.");
							
						} else {
							List<PreGoodsInventoryAdmVo> preGoodsInventoryFifoCheckList = PdaService.preGoodsInventoryFifoCheckList(preGoodsInventoryAdmVo);
							logger.info("선입선출 목록 : "+preGoodsInventoryFifoCheckList);
							
							jsonData.put("fifoCheck", "no");
							jsonData.put("message1", "선입선출 해야할 입고된 생산제품이 존재합니다.");
							jsonData.put("message2", "선 출하 포장번호 : " + preGoodsInventoryDtl.getBoxNo());
							jsonData.put("message3", "선입선출 대상 총 개수 : " + preGoodsInventoryFifoCheckList.size() + "개");
							jsonData.put("checkList", preGoodsInventoryFifoCheckList);
						}
						
					//제품 선입선출 미적용
					} else if ("003".equals(systemCommonCodeVo.getBaseCd())) {
						jsonData.put("message", "추가되었습니다.");
					}
					/**************** 추가한 부분 끝 *********************/
					
//					jsonData.put("data", preGoodsInventoryDtl);
					jsonData.put("data", preGoodsInventoryAdmVo);
					jsonData.put("message", "추가되었습니다.");
					jsonData.put("result", "ok");
					
				} else {
					jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
					jsonData.put("result", "fail");
				}

			//생산 제품인 경우
			} else {
				goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
				if (goodsProductInfoAdmVo != null) {
					if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
						jsonData.put("message", "폐기된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getDivisionYn().equals("D")) {
						jsonData.put("message", "분할된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getDivisionYn().equals("M")) {
						jsonData.put("message", "병합된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getGoodsStatus().equals("001")) {
						jsonData.put("message", "입고되지않은 BoxNo입니다.<br>입고를 먼저 진행해 주세요.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getRemainCnt() == 0) {
						jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (!"001".equals(goodsProductInfoAdmVo.getFaultyStatus().toString())) {
						jsonData.put("message", goodsProductInfoAdmVo.getFaultyStatusNm() + " 상태의 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}

					boolean sealingTemp = true;				//실링검사 합격여부 체크
					String sealingMessage = null;			//실링검사값 불합격시 메시지
					//해당제품 작지추적 & 실링검사값 확인
					//List<GoodsProductInfoAdmVo> goodsProductWorkOrdList = PdaService.goodsProductWorkOrdList(goodsProductInfoAdmVo);
					//for (int i=0; i<goodsProductWorkOrdList.size(); i++) {
					//	if (goodsProductWorkOrdList.get(i).getSealingDate() == null) {
					//		sealingTemp = false;
					//		sealingMessage = "실링검사가 입력되지 않았습니다!<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
					//		break;
					//	} else if (goodsProductWorkOrdList.get(i).getSealing1() < 1) {
					//		sealingTemp = false;
					//		sealingMessage = "실링검사결과 불합격 작지입니다. 출고시킬 수 없습니다!<br>실효1값 : " + goodsProductWorkOrdList.get(i).getSealing1() + " 불합격 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
					//		break;
					//	} else if (goodsProductWorkOrdList.get(i).getSealing2() < 1) {
					//		sealingTemp = false;
					//		sealingMessage = "실링검사결과 불합격 작지입니다. 출고시킬 수 없습니다!<br>실효2값 : " + goodsProductWorkOrdList.get(i).getSealing2() + " 불합격 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
					//		break;
					//	} else if ("Y".equals(goodsProductWorkOrdList.get(i).getFilmFaultyCheck())) {
					//		sealingTemp = false;
					//		sealingMessage = "필름 외관이상 제품입니다. 출고시킬 수 없습니다!<br>필름 외관이상 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
					//		break;
					//	}
					//}
					if (sealingTemp) {
						SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
						GoodsProductInfoAdmVo goodsProductFifoCheckVo = new GoodsProductInfoAdmVo();
						systemCommonCodeVo.setBaseGroupCd("063"); //제품 선입선출
						systemCommonCodeVo.setEtc1("Y");
						systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
						if ( systemCommonCodeVo != null) {
							goodsProductInfoAdmVo.setGoodsFifoCheckCd(systemCommonCodeVo.getBaseCd());
							goodsProductInfoAdmVo.setGoodsFifoCheckNm(systemCommonCodeVo.getBaseCdNm());	
						} else {
							goodsProductInfoAdmVo.setGoodsFifoCheckCd("001");
							goodsProductInfoAdmVo.setGoodsFifoCheckNm("적용(통제)");
						}
						//제품 선입선출 적용(통제), 옵션 선택이 되어있지 않아도
						if (systemCommonCodeVo == null || "001".equals(systemCommonCodeVo.getBaseCd())) {
							//이미 스캔한 boxNo 들 선입선출 대상에서 제외
							boolean firstScanCheck = exceptBoxNo.contains("empty");
							String exceptBoxNoQuery = exceptBoxNo.replace("/", "', '");
							logger.info(exceptBoxNoQuery);
							//최초스캔이면..
							if (firstScanCheck) {
								
							//이미 몇번 스캔하였으면..
							} else {
								exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
								logger.info(exceptBoxNoQuery);
								exceptBoxNoQuery += "'";
								logger.info(exceptBoxNoQuery);								
							}
							goodsProductInfoAdmVo.setExceptBoxNo(exceptBoxNoQuery);
							goodsProductFifoCheckVo = PdaService.goodsProductFifoCheck(goodsProductInfoAdmVo);
							
							if ("Y".equals(goodsProductFifoCheckVo.getBoxNo())) {
								jsonData.put("fifoCheck", "yes");
								jsonData.put("message", "추가되었습니다.");
								
							} else {
								jsonData.put("fifoCheck", "no");
								jsonData.put("message1", "선입선출 해야할 입고된 생산제품이 존재합니다.");
								jsonData.put("message2", "포장번호 : " + goodsProductFifoCheckVo.getBoxNo());
								jsonData.put("message3", "선입선출 대상 총 개수 : " + goodsProductFifoCheckVo.getGoodsFifoCount());
//								jsonData.put("checkList", goodsProductFifoCheckVo);
								
								preGoodsInventoryAdmVo.setGoodsInDate(goodsProductInfoAdmVo.getGoodsInDate());
								preGoodsInventoryAdmVo.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
								preGoodsInventoryAdmVo.setExceptBoxNo(goodsProductInfoAdmVo.getExceptBoxNo());
								
								List<PreGoodsInventoryAdmVo> goodsProductFifoCheckList = PdaService.preGoodsInventoryFifoCheckList(preGoodsInventoryAdmVo);
								logger.info("선입선출 목록 : "+goodsProductFifoCheckList);
								jsonData.put("checkList", goodsProductFifoCheckList);
							}
							
						//제품 선입선출 적용(확인)
						} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
							//이미 스캔한 boxNo 들 선입선출 대상에서 제외
							boolean firstScanCheck = exceptBoxNo.contains("empty");
							String exceptBoxNoQuery = exceptBoxNo.replace("/", "', '");
							logger.info(exceptBoxNoQuery);
							//최초스캔이면..
							if (firstScanCheck) {
								
							//이미 몇번 스캔하였으면..
							} else {
								exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
								logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
								exceptBoxNoQuery += "'";
								logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);						
							}
							goodsProductInfoAdmVo.setExceptBoxNo(exceptBoxNoQuery);
							goodsProductFifoCheckVo = PdaService.goodsProductFifoCheck(goodsProductInfoAdmVo);
							
							if ("Y".equals(goodsProductFifoCheckVo.getBoxNo())) {
								jsonData.put("fifoCheck", "yes");
								jsonData.put("message", "추가되었습니다.");
								
							} else {
								jsonData.put("fifoCheck", "no");
								jsonData.put("message1", "선입선출 해야할 입고된 생산제품이 존재합니다.");
								jsonData.put("message2", "포장번호 : " + goodsProductFifoCheckVo.getBoxNo());
								jsonData.put("message3", "선입선출 대상 총 개수 : " + goodsProductFifoCheckVo.getGoodsFifoCount());
//								jsonData.put("checkList", goodsProductFifoCheckVo);
								
								preGoodsInventoryAdmVo.setGoodsInDate(goodsProductInfoAdmVo.getGoodsInDate());
								preGoodsInventoryAdmVo.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
								preGoodsInventoryAdmVo.setExceptBoxNo(goodsProductInfoAdmVo.getExceptBoxNo());
								
								List<PreGoodsInventoryAdmVo> goodsProductFifoCheckList = PdaService.preGoodsInventoryFifoCheckList(preGoodsInventoryAdmVo);
								logger.info("선입선출 목록 : "+goodsProductFifoCheckList);
								jsonData.put("checkList", goodsProductFifoCheckList);
							}
							
						//제품 선입선출 미적용
						} else if ("003".equals(systemCommonCodeVo.getBaseCd())) {
							jsonData.put("message", "추가되었습니다.");
						}
						
						jsonData.put("result", "ok");
						jsonData.put("data", goodsProductInfoAdmVo);
						
					} else {
						jsonData.put("message", sealingMessage);
						jsonData.put("result", "fail");
					}
					
				} else {
					jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
					jsonData.put("result", "fail");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//제품출고 목록
	@RequestMapping(value = "/pd/goodsProductInfoAdmData3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoAdmData3(GoodsProductInfoAdmVo goodsProductInfoAdmVo, PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
		logger.info("제품생산정보관리 " + goodsProductInfoAdmVo);
		String exceptBoxNo = goodsProductInfoAdmVo.getExceptBoxNo();
		
		try {
			logger.info(goodsProductInfoAdmVo.getBoxNo());
			//String goodsFifoCheck = goodsProductInfoAdmVo.getGoodsFifoCheckCd();
			
			//재고 제품인 경우
			if (goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S")) {
				preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
				preGoodsInventoryDtl.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
				//preGoodsInventoryDtl.setOrderGubunCd(goodsProductInfoAdmVo.getOrdGubun());	-> 머티 요청으로 해당PO에 제품코드만 일치하면 됨 같은제품의 다른타입(해외1,2,국내)가 출하 될 수 있음
				preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
				if (preGoodsInventoryDtl != null) {
					if (preGoodsInventoryDtl.getRemainCnt() == 0) {
						jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (!"001".equals(preGoodsInventoryDtl.getFaultyStatus().toString())) {
						jsonData.put("message", preGoodsInventoryDtl.getFaultyStatusNm() + " 상태의 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					/**************** 추가한 부분 *********************/
					preGoodsInventoryAdmVo = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryAdmVo);
					
					SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
					systemCommonCodeVo.setBaseGroupCd("063"); //제품 선입선출
					systemCommonCodeVo.setEtc1("Y");
					systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
					
					if(systemCommonCodeVo != null) {
						preGoodsInventoryAdmVo.setGoodsFifoCheckCd(systemCommonCodeVo.getBaseCd());
						preGoodsInventoryAdmVo.setGoodsFifoCheckNm(systemCommonCodeVo.getBaseCdNm());
					}else {
						preGoodsInventoryAdmVo.setGoodsFifoCheckCd("003");
						preGoodsInventoryAdmVo.setGoodsFifoCheckNm("초기재고 미적용");
					}
					
					logger.info("System코드 확인하기 --------------> " +systemCommonCodeVo.getBaseCd());

					
					/**************** 추가한 부분 끝 *********************/
					
//					jsonData.put("data", preGoodsInventoryDtl);
					jsonData.put("data", preGoodsInventoryAdmVo);
					jsonData.put("message", "추가되었습니다.");
					jsonData.put("result", "ok");
					
				} else {
					jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
					jsonData.put("result", "fail");
				}

			//생산 제품인 경우
			} else {
				goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
				if (goodsProductInfoAdmVo != null) {
					if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
						jsonData.put("message", "폐기된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getDivisionYn().equals("D")) {
						jsonData.put("message", "분할된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getDivisionYn().equals("M")) {
						jsonData.put("message", "병합된 BoxNo 입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getGoodsStatus().equals("001")) {
						jsonData.put("message", "입고되지않은 BoxNo입니다.<br>입고를 먼저 진행해 주세요.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (goodsProductInfoAdmVo.getRemainCnt() == 0) {
						jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (!"006".equals(goodsProductInfoAdmVo.getFaultyStatus().toString())) {
						jsonData.put("message","폐기이동된 제품이 아닙니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					jsonData.put("message", "추가되었습니다.");
					jsonData.put("result", "ok");
					jsonData.put("data", goodsProductInfoAdmVo);
					
				} else {
					jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
					jsonData.put("result", "fail");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	//PDA 파레트 관련 제품  조회
	@RequestMapping(value = "/pd/palletRelatedProductList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> palletRelatedProductList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			logger.info("PDA 파레트 관련 제품  조회" + purchaseOrderAdmVo);
			
			List<PurchaseOrderAdmVo> purchaseOrderAdmList = PdaService.palletRelatedProductList_F3(purchaseOrderAdmVo);
			
			Boolean check = true;
			int i=0;
			
			for( i=0; i<purchaseOrderAdmList.size(); i++ ) {
				if( !"Y".equals(purchaseOrderAdmList.get(i).getFactCheck()) ) {
					check = false;
				}
			}
			
			if( check ) {
				jsonData.put("result", "ok");
				jsonData.put("data", purchaseOrderAdmList);
			} else {
				jsonData.put("result", "faile");
				jsonData.put("message", "출하대기 체크 완료 후 다시 스캔해주세요.");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	

	//제품출고
	@RequestMapping(value = "/pd/outWhsPOST", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outWhsPOST(@RequestBody List<Map<String, Object>> boxNoList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품출고 " + boxNoList);
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo(); //PO정보
		PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo(); //PO정보 기록
		try {
			boolean userOutputCntSumCheck	= true;	//출고수량 > 미출고수량 검증
			boolean remainCheck 			= true;	//제품BoxNo 남은수량 검증
			boolean faultyStatusCheck	 	= true;	//제품 불량상태 검증
			boolean divisionCheck 			= true;	//제품 분할여부 체크
			boolean mergeCheck 				= true;	//제품 병합여부 체크
			String remainBoxNo 				= null;
			int userOutputCntSum 			= 0;
			boolean sealingTemp 			= true;	//실링검사 합격여부 체크
			String sealingMessage			= null;	//실링검사값 불합격시 메시지
			
			//출고시킬 PO정보를 가져옴
			String poSeq = boxNoList.get(0).get("poSeq").toString();
			purchaseOrderAdmVo.setPoSeq(poSeq);
			purchaseOrderAdmVo = purchaseOrderAdmService.read(purchaseOrderAdmVo);
			
			for (Map<String, Object> m : boxNoList) {				
				userOutputCntSum += Integer.parseInt(m.get("userOutputCnt").toString());
			}

			//출고수량 > 미출고수량 인지 확인
			if (userOutputCntSum > purchaseOrderAdmVo.getRemainQty()) {
				userOutputCntSumCheck = false;

			//출고수량 <= 미출고수량 이면 정상(O)
			} else {
				//먼저 받아온 리스트 중 remain 값이 boxNo를 다시 조회해서 나온 remain 값이랑 동일한지 비교하기 -> 스캔 후 제품이 출하되었는지 다시한번 확인하는 것임!
				for (Map<String, Object> m : boxNoList) {
					String boxNo = m.get("boxNo1").toString();
					//int remainCnt = Integer.parseInt(m.get("remainCnt").toString());
					//재고제품인지 생산제품인지 판단
					if (boxNo.substring(0, 1).equals("S")) {
						PreGoodsInventoryAdmVo preGoodsInventoryDtlCheck = new PreGoodsInventoryAdmVo(); //재고제품 remainCnt 검사
						preGoodsInventoryDtlCheck.setBoxNo(boxNo);
						preGoodsInventoryDtlCheck = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtlCheck);
//						if (preGoodsInventoryDtlCheck.getRemainCnt() != remainCnt) {
//							remainBoxNo = boxNo;
//							remainCheck = false;
//							break;
//						}
						if (!"001".equals(preGoodsInventoryDtlCheck.getFaultyStatus().toString())) {
							remainBoxNo = boxNo;
							faultyStatusCheck = false;
							break;
						}
					} else {
						GoodsProductInfoAdmVo goodsProductInfoCheck = new GoodsProductInfoAdmVo(); //생산제품 remainCnt 검사
						goodsProductInfoCheck.setBoxNo(boxNo);
						goodsProductInfoCheck = PdaService.readGoodsProductInfo2(goodsProductInfoCheck);
//						if (goodsProductInfoCheck.getRemainCnt() != remainCnt) {
//							remainBoxNo = boxNo;
//							remainCheck = false;
//							break;
//						}
						if (!"001".equals(goodsProductInfoCheck.getFaultyStatus().toString())) {
							remainBoxNo = boxNo;
							faultyStatusCheck = false;
							break;
						}
						if ("D".equals(goodsProductInfoCheck.getDivisionYn())) {
							remainBoxNo = boxNo;
							divisionCheck = false;
							break;
						}
						if ("M".equals(goodsProductInfoCheck.getDivisionYn())) {
							remainBoxNo = boxNo;
							mergeCheck = false;
							break;
						}

						//해당제품 작지추적 & 실링검사값 확인
						//List<GoodsProductInfoAdmVo> goodsProductWorkOrdList = PdaService.goodsProductWorkOrdList(goodsProductInfoCheck);
						//for (int i=0; i<goodsProductWorkOrdList.size(); i++) {
						//	if (goodsProductWorkOrdList.get(i).getSealingDate() == null) {
						//		sealingTemp = false;
						//		sealingMessage = "실링검사가 입력되지 않았습니다!<br>BoxNo - " + goodsProductWorkOrdList.get(i).getBoxNo() + "<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
						//		break;
						//	} else if (goodsProductWorkOrdList.get(i).getSealing1() < 1) {
						//		sealingTemp = false;
						//		sealingMessage = "실링검사결과 불합격 작지입니다. 입고시킬 수 없습니다!<br>실효1값 : " + goodsProductWorkOrdList.get(i).getSealing1() + "<br>BoxNo - " + goodsProductWorkOrdList.get(i).getBoxNo() + "<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
						//		break;
						//	} else if (goodsProductWorkOrdList.get(i).getSealing2() < 1) {
						//		sealingTemp = false;
						//		sealingMessage = "실링검사결과 불합격 작지입니다. 입고시킬 수 없습니다!<br>실효2값 : " + goodsProductWorkOrdList.get(i).getSealing2() + "<br>BoxNo - " + goodsProductWorkOrdList.get(i).getBoxNo() + "<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
						//		break;
						//	} else if ("Y".equals(goodsProductWorkOrdList.get(i).getFilmFaultyCheck())) {
						//		sealingTemp = false;
						//		sealingMessage = "필름 외관이상 제품입니다. 입고시킬 수 없습니다!<br>BoxNo - " + goodsProductWorkOrdList.get(i).getBoxNo() + "<br>미입력 작지 - " + goodsProductWorkOrdList.get(i).getWorkOrdNo();
						//		break;
						//	}
						//}
						
					}
				}
			}

			//--------------------동일하면 출하 실행------------------------------------------------------------

			//출하 실행
			if (remainCheck == true && userOutputCntSumCheck == true && faultyStatusCheck == true && divisionCheck == true && mergeCheck == true && sealingTemp == true) {

				int poGroup = 0;
				String addPallet = boxNoList.get(0).get("addPallet").toString();
				
				if ( ("001".equals(factoryCode) || "002".equals(factoryCode) || "003".equals(factoryCode)) && "false".equals(addPallet) ) {
					poGroup = Integer.parseInt(boxNoList.get(0).get("poGroup").toString());
				} else {
					poGroup = Integer.parseInt(PdaService.selectPoGroup(purchaseOrderAdmVo.getPoSeq().toString()));
				}
				
				purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
				int sum = 0;
				PurchaseOrderDtl purchaseOrderDtl2 = new PurchaseOrderDtl();
				purchaseOrderDtl2.setPoSeq(poSeq);
				purchaseOrderDtl2.setPoGroup(Integer.toString( poGroup ));
				purchaseOrderDtl2.setFactoryCode(factoryCode);
				//purchaseOrderPoNoSeq 쿼리에서 2공장이면 poGroup까지 사용하여 채번함
				int poNoSeq = Integer.parseInt(purchaseOrderAdmService.purchaseOrderPoNoSeq(purchaseOrderDtl2));
				
				//2공장 실시간 파레트 적재 추가
				
				List<PurchaseOrderDtl> newList = new ArrayList<PurchaseOrderDtl>();
				for (Map<String, Object> m : boxNoList) {
					String boxNo 			= m.get("boxNo1").toString();
					String goodsOutDate 	= m.get("goodsOutDate").toString();
					String goodsCd 			= m.get("goodsCd").toString();
					int packCnt 			= Integer.parseInt(m.get("packCnt").toString());
					int userOutputCnt 		= Integer.parseInt(m.get("userOutputCnt").toString());
					String customerLotNo 	= m.get("customerLotNo").toString();
					sum += userOutputCnt;

					//재고제품인지 생산제품인지 판단
					if (boxNo.toString().substring(0, 1).equals("S")) {
						PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo(); //재고제품
						preGoodsInventoryDtl.setBoxNo(boxNo);
						preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
						preGoodsInventoryDtl.setRemainCnt(preGoodsInventoryDtl.getRemainCnt() - userOutputCnt); //잔여수량 - 출하수량
						//잔여수량이 0이면 출하상태(003), 남아있으면 포장상태(002) ->이제는 분할해서 출하되기에 안쓰는부분?
						if (preGoodsInventoryDtl.getRemainCnt() != 0) {
							preGoodsInventoryDtl.setGoodsStatus("002");
						} else {
							preGoodsInventoryDtl.setGoodsStatus("003");
						}
						preGoodsInventoryDtl.setUpdId(Utils.getUserId());
						preGoodsInventoryDtl.setHistId(Utils.getUserId());
						PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl);
						preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, boxNo, "003", "O", "008", userOutputCnt, factoryCode);	
						stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
						
					} else {
						GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo(); //생산제품
						goodsProductInfoAdmVo.setBoxNo(boxNo);
						goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
						goodsProductInfoAdmVo.setRemainCnt(goodsProductInfoAdmVo.getRemainCnt() - userOutputCnt); //잔여수량 - 출하수량
						goodsProductInfoAdmVo.setCustomerLotNo(customerLotNo);
						//잔여수량이 0이면 출하상태(003), 남아있으면 포장상태(002)
						if (goodsProductInfoAdmVo.getRemainCnt() != 0) {
							goodsProductInfoAdmVo.setGoodsStatus("002");
						} else {
							goodsProductInfoAdmVo.setGoodsStatus("003");
						}
						goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
						goodsProductInfoAdmVo.setHistId(Utils.getUserId());
						PdaService.updateBox(goodsProductInfoAdmVo);
						PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
						goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, boxNo, "002", "O", "008", userOutputCnt, factoryCode);	
						stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
						
					}

					PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
					purchaseOrderDtl.setPoSeq(poSeq);				//제품코드
					purchaseOrderDtl.setPoGroup(Integer.toString( poGroup ));			//제품코드
					purchaseOrderDtl.setGoodsCd(goodsCd);			//제품코드
					purchaseOrderDtl.setBoxNo(boxNo);				//박스번호
					purchaseOrderDtl.setPackCnt(packCnt);			//포장수량
					purchaseOrderDtl.setOutputCnt(userOutputCnt);	//출고수량
					purchaseOrderDtl.setPoDate(goodsOutDate);		//출하일
					purchaseOrderDtl.setRegId(Utils.getUserId());	//생성자
					//purchaseOrderDtl.setPoNoSeq(Integer.toString(poNoSeq)); //PO_NO_SEQ

					//출하 기록 생성
					//purchaseOrderAdmService.createPurchaseOrderDtl(purchaseOrderDtl);
					newList.add(purchaseOrderDtl);
					//poNoSeq++;
				}
				Collections.reverse(newList);
				for (PurchaseOrderDtl m : newList) {					
					m.setPoNoSeq(Integer.toString(poNoSeq)); 					
					purchaseOrderAdmService.createPurchaseOrderDtl(m);
					poNoSeq++;
				}

				//PO기록 수정
				//파레트 적재 추가일 경우(2공장 기준으로 1,3공장 만듬)
				if ( ("001".equals(factoryCode) || "002".equals(factoryCode) || "003".equals(factoryCode)) && "false".equals(addPallet) ) {
					//추가한 파레트 부터 이후 파레트까지 출고이력 보정
					purchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq().toString());
					purchaseOrderOutputHistVo.setPoGroup(Integer.toString(poGroup));
					//purchaseOrderOutputHistVo.setPreOutputQty(purchaseOrderAdmVo.getOutputQty());
					purchaseOrderOutputHistVo.setOutputQty(sum);									//추가 출고 수량
					//purchaseOrderOutputHistVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() - sum);
					//purchaseOrderOutputHistVo.setOutputHistDate((boxNoList.get(0).get("goodsOutDate").toString()));
					//purchaseOrderOutputHistVo.setApprovalCd("002");
					//purchaseOrderOutputHistVo.setRegId(Utils.getUserId());
					//purchaseOrderOutputHistVo.setOutputGubun("001");
					purchaseOrderAdmService.addTrayByPallet(purchaseOrderOutputHistVo);
					
				} else {
					purchaseOrderOutputHistVo.setPoSeq(purchaseOrderAdmVo.getPoSeq().toString());
					purchaseOrderOutputHistVo.setPoNo(purchaseOrderAdmVo.getPoNo().toString());
					purchaseOrderOutputHistVo.setPreOutputQty(purchaseOrderAdmVo.getOutputQty());
					purchaseOrderOutputHistVo.setOutputQty(sum);
					purchaseOrderOutputHistVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() - sum);
					purchaseOrderOutputHistVo.setOutputHistDate((boxNoList.get(0).get("goodsOutDate").toString()));
					purchaseOrderOutputHistVo.setApprovalCd("002");
					purchaseOrderOutputHistVo.setRegId(Utils.getUserId());
					purchaseOrderOutputHistVo.setOutputGubun("001");
					purchaseOrderAdmService.histCreate(purchaseOrderOutputHistVo);
				}
				

				purchaseOrderAdmVo.setUpdId(Utils.getUserId());
				purchaseOrderAdmVo.setOutputQty(purchaseOrderAdmVo.getOutputQty() + sum); //출고수량 누적+
				purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() - sum); //미출고수량 누적-
				purchaseOrderAdmService.updateQty(purchaseOrderAdmVo);

				jsonData.put("result", "ok");
			} else {
				if (userOutputCntSumCheck == false) {
					logger.info("출고수량 > 미출고수량 인 경우");
					jsonData.put("message", "출고수량이 " + userOutputCntSum + "으로 미출고수량보다 많습니다!<br>PO정보를 확인해주세요.");
				} else if (remainCheck == false) {
					logger.info("스캔한 제품들 중 이미 출하된 제품이 존재");
					jsonData.put("message", "스캔한 제품 중 " + remainBoxNo + "(이)가 이미 출고되어 잔여수량이 변경되었습니다.<br>PO재선택 및 BoxNo를 다시 스캔해 주세요!");
				} else if (faultyStatusCheck == false) {
					logger.info("불량상태 제품 존재");
					jsonData.put("message", "스캔한 제품 중 " + remainBoxNo + "(이)가 출고가능한 상태가 아닙니다.<br>제품 상태를 다시 확인해주세요!");
				} else if (divisionCheck == false) {
					logger.info("분할 제품 존재");
					jsonData.put("message", "스캔한 제품 중 " + remainBoxNo + "(이)가 분할된 제품입니다.<br>제품을 다시 확인해주세요!");
				} else if (mergeCheck == false) {
					logger.info("병합 제품 존재");
					jsonData.put("message", "스캔한 제품 중 " + remainBoxNo + "(이)가 병합된 제품입니다.<br>제품을 다시 확인해주세요!");
				} else if (sealingTemp == false) {
					logger.info("실링검사 불합격 존재");
					jsonData.put("message", sealingMessage);
				}

				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			logger.info("제품출고 실패");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	
	
	
	//PDA 파레트 관련 제품  출하
	@RequestMapping(value = "/pd/palletRelatedProductOut_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletRelatedProductOut_F3(@RequestBody List<Map<String, Object>> boxNoList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("PDA 파레트 관련 제품  조회" + boxNoList);
			
			for (Map<String, Object> m : boxNoList) {
				GoodsProductInfoAdmVo goodsProductInfoCheck = new GoodsProductInfoAdmVo(); //생산제품 remainCnt 검사
				String boxNo = m.get("boxNo1").toString();
				
				goodsProductInfoCheck.setBoxNo(boxNo);
				goodsProductInfoCheck = PdaService.readGoodsProductInfo2(goodsProductInfoCheck);
	//			}
				if ("003".equals(goodsProductInfoCheck.getDisposeGubun())) {
					jsonData.put("message", "스캔한 제품 중 " + boxNo + "(이)가 폐기지정 상태입니다.<br>해당 제품을 제외하고 다시 시도해주세요!");
					jsonData.put("result", "fail");
					return jsonData;
				}
				
				if (!"001".equals(goodsProductInfoCheck.getFaultyStatus().toString())) {
					jsonData.put("message", "스캔한 제품 중 " + boxNo + "(이)가 출고가능한 상태가 아닙니다.<br>제품 상태를 다시 확인해주세요!");
					jsonData.put("result", "fail");
					return jsonData;
				}
				if ("D".equals(goodsProductInfoCheck.getDivisionYn())) {
					jsonData.put("message", "스캔한 제품 중 " + boxNo + "(이)가 분할된 제품입니다.<br>제품을 다시 확인해주세요!");
					jsonData.put("result", "fail");
					return jsonData;
				}
				if ("M".equals(goodsProductInfoCheck.getDivisionYn())) {
					jsonData.put("message", "스캔한 제품 중 " + boxNo + "(이)가 병합된 제품입니다.<br>제품을 다시 확인해주세요!");
					jsonData.put("result", "fail");
					return jsonData;
				}
			}
			
			for (Map<String, Object> m : boxNoList) {
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo(); //생산제품
				
				goodsProductInfoAdmVo.setBoxNo(m.get("boxNo1").toString());
				goodsProductInfoAdmVo.setRemainCnt(0); //잔여수량 - 출하수량
				goodsProductInfoAdmVo.setGoodsStatus("003");
				goodsProductInfoAdmVo.setGoodsOutDate(m.get("goodsOutDate").toString());
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				goodsProductInfoAdmVo.setHistId(Utils.getUserId());
				
				PdaService.updateBox(goodsProductInfoAdmVo);
				PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
				goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(m.get("goodsCd").toString(), m.get("boxNo1").toString(), "002", "O", "008", Integer.parseInt(m.get("packCnt").toString()), factoryCode);	
				stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
			}
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	//PDA 파레트 관련 제품  미료&완공 처리 로직
	@RequestMapping(value = "/pd/palletRelatedCompleteYn_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletRelatedCompleteYn_F3(@RequestBody List<Map<String, Object>> boxNoList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("PDA 파레트 관련 제품  조회" + boxNoList);
			String completeYn1	= boxNoList.get(0).get("completeYn1") == null ? null : boxNoList.get(0).get("completeYn1").toString();
			String goodsStatus	= boxNoList.get(0).get("locationCd") == null ? "002" : "004"; //001: 포장 / 002: 입고 / 003:출하 / 004: 대기 / 005: 점검대기 (23.06.26점검 대기가 추가됨에 따라 004 -> 005로 상태 값이 변경됨)
			String locationCd	= boxNoList.get(0).get("locationCd") == null ? null : boxNoList.get(0).get("locationCd").toString();
			String poGroup		= boxNoList.get(0).get("poGroup") == null ? null : boxNoList.get(0).get("poGroup").toString();
			
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			for (Map<String, Object> m : boxNoList) {
				
				//생산제품
				goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				
				goodsProductInfoAdmVo.setBoxNo(m.get("boxNo1").toString());				//박스 번호
				goodsProductInfoAdmVo.setCompleteYn(completeYn1);						//미료: N /완료: Y
				goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);						//상태 값
				goodsProductInfoAdmVo.setLocationCd(locationCd);						//창고
				goodsProductInfoAdmVo.setPoSeq(m.get("poSeq").toString());				//PoNumber(수주 번호)
				goodsProductInfoAdmVo.setPoGroup(m.get("poGroup").toString());			//파레트 번호
				
				if( m.get("locationInputDate") != null ) {
					goodsProductInfoAdmVo.setLocationInputDate(m.get("locationInputDate").toString());	//창고입고날짜(최초만 기억)
				}
				
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());						// 
				goodsProductInfoAdmVo.setHistId(Utils.getUserId());						//
				
				logger.info("PDA 파레트 관련 제품  미료&완공 처리 로직 : " + goodsProductInfoAdmVo);
				PdaService.palletRelatedProductUpdate_F3(goodsProductInfoAdmVo);		//미료&완공/창고지정 
				PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);				//생산제품 상태변경 기록
			}
			
			//미료 처리 시 체킹 전체 삭제 진행
			/*if( (completeYn1 != null && completeYn1.equals("N")) || (goodsStatus != null && goodsStatus.equals("005")) ) {
				goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				goodsProductInfoAdmVo.setPoGroup(poGroup);
				PdaService.palletBoxFactCheckCancelUpdate(goodsProductInfoAdmVo);
			}*/
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	//재고 실사(자재)
	@RequestMapping(value = "/pdsc0050", method = RequestMethod.GET)
	public String pdsc0050(Model model) throws Exception {

		logger.info("PDA 재고실사(자재) 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0050";
	}

	//재고실사(자재) - 입출고관리 입고현황목록조회
	@RequestMapping(value = "/pd/readMatrlInOutWhsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고 실사(자재) 목록 조회 " + matrlInOutWhsAdmVo);

		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listPreInWhsAll(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고 실사(자재) 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//재고 실사(제품)
	@RequestMapping(value = "/pdsc0060", method = RequestMethod.GET)
	public String pdsc0060(Model model) throws Exception {

		logger.info("PDA 재고실사(자재) 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0060";
	}

	//재고실사(제품) 입고일&위치 목록 조회
	@RequestMapping(value = "/pd/goodsProductInfoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("재고실사(제품) 입고일&위치 목록 조회" + goodsProductInfoAdmVo);
			List<GoodsProductInfoAdmVo> goodsProductInfoAdmList = PdaService.goodsProductInfoList(goodsProductInfoAdmVo);
			jsonData.put("data", goodsProductInfoAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고실사 조회 오류입니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//재고실사(제품) BoxNo 스캔
	@RequestMapping(value = "/pd/productBoxNoScan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productBoxNoScan(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		goodsProductInfoAdmVo.setGoodsStatus("002");
		logger.info("재고실사(제품) " + goodsProductInfoAdmVo);

		try {
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
			jsonData.put("data", goodsProductInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "입력값이 정확하지 않습니다.");
			jsonData.put("fail", "ok");
		}

		return jsonData;
	}

	//PDA 로그아웃
	@RequestMapping(value = "/pd/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		
		//PC인지 Mobile인지 확인
		boolean checkMobile = Utils.checkMobile(request);
		
		//로그인 기록
		LogionHistVo logionHistVo = new LogionHistVo();
		logionHistVo.setLoginNo(Long.toString(systemCommonGroupService.selectLoginNo()));
		logionHistVo.setUserId(request.getSession().getAttribute("userId").toString());
		logionHistVo.setIpAddress(Utils.getClientIP(request));
		logionHistVo.setGubun("Logout");
		if (checkMobile == true) {
			logionHistVo.setEtc("Mobile");
		} else {
			logionHistVo.setEtc("PC");
		}
		systemCommonGroupService.createLoginHist(logionHistVo);
		
		session.invalidate();
		Cookie cookieUserId = new Cookie("userId", null);
		cookieUserId.setMaxAge(0);
		cookieUserId.setPath("/");
		response.addCookie(cookieUserId);
		//Cookie cookieUserPw = new Cookie("userPw", null);
		//cookieUserPw.setMaxAge(0);
		//cookieUserPw.setPath("/");
		//response.addCookie(cookieUserPw);
		response.sendRedirect("/auth/pdsc0080");
	}

	//자재 불량&반품
	@RequestMapping(value = "/pdsc0090", method = RequestMethod.GET)
	public String pdsc0090GET(Model model) throws Exception {

		logger.info("PDA 자재 불량&반품 페이지");
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("004"); // Location
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("locationCode", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0090";
	}

	//자재 불량&반품 바코드스캔
	@RequestMapping(value = "/io/matrlFaultyReturnCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyReturnCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 불량&반품 자재 바코드 스캔");
		logger.info(matrlInOutWhsAdmVo.toString());

		try {
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			logger.info(matrlInOutWhsAdmVo.toString());
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");

		} catch (NullPointerException e) {
			logger.info("조회된 값이 없습니다.");
			jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
			jsonData.put("result", "error");
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//제품출고 목록
	@RequestMapping(value = "/pd/goodsProductInfoAdmData2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoAdmData2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
		logger.info("제품생산정보관리 " + goodsProductInfoAdmVo);
		try {

			logger.info(goodsProductInfoAdmVo.getBoxNo());
			int check = matrlInOutWhsAdmService.purchaseOrderDtlRead(goodsProductInfoAdmVo.getBoxNo());
			if (check == 0) {
				//재고 제품인 경우
				if (goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S")) {

					preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
					preGoodsInventoryDtl.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
					//preGoodsInventoryDtl.setOrderGubunCd(goodsProductInfoAdmVo.getOrdGubun());	-> 머티 요청으로 해당PO에 제품코드만 일치하면 됨 같은제품의 다른타입(해외1,2,국내)가 출하 될 수 있음
					preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
					if (preGoodsInventoryDtl != null) {
						if (preGoodsInventoryDtl.getRemainCnt() == 0) {
							jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						} else if (!"001".equals(preGoodsInventoryDtl.getFaultyStatus())) {
							jsonData.put("message", preGoodsInventoryDtl.getFaultyStatusNm() + " 상태의 제품입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}

						jsonData.put("data", preGoodsInventoryDtl);
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
						jsonData.put("result", "fail");
					}

				//생산 제품인 경우
				} else {
					goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
					if (goodsProductInfoAdmVo != null) {
						if (goodsProductInfoAdmVo.getGoodsStatus().equals("001")) {
							jsonData.put("message", "입고되지않은 BoxNo입니다.<br>입고를 먼저 진행해 주세요.");
							jsonData.put("result", "fail");
							return jsonData;
						} else if ("Y".equals(goodsProductInfoAdmVo.getDisuseYn())) {
							jsonData.put("message", "폐기된 제품입니다. 다시 스캔해 주세요!");
							jsonData.put("result", "fail");
						} else if ("D".equals(goodsProductInfoAdmVo.getDivisionYn())) {
							jsonData.put("message", "분할된 제품입니다. 다시 스캔해 주세요!");
							jsonData.put("result", "fail");
						} else if ("M".equals(goodsProductInfoAdmVo.getDivisionYn())) {
							jsonData.put("message", "병합된 제품입니다. 다시 스캔해 주세요!");
							jsonData.put("result", "fail");
						} else if (goodsProductInfoAdmVo.getRemainCnt() == 0) {
							jsonData.put("message", "잔여수량이 0인 포장번호입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						} else if (!"001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
							jsonData.put("message", goodsProductInfoAdmVo.getFaultyStatusNm() + " 상태의 제품입니다.");
							jsonData.put("result", "fail");
							return jsonData;
						} else {
							jsonData.put("data", goodsProductInfoAdmVo);
							jsonData.put("result", "ok");	
						}
					} else {
						jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
						jsonData.put("result", "fail");
					}
				}
			} else {
				jsonData.put("message", "이미 출하된 BoxNO 입니다.");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//자재 불량&반품 Update

	//@RequestMapping(value = "/pd/approvalUpdate", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> approvalUpdateGET(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
	//
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("자재 불량&반품 자재 상태 Update " + matrlInOutWhsAdmList);
	//	MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
	//
	//	try {
	//		for (Map<String, Object> m : matrlInOutWhsAdmList) {
	//			logger.debug("m ===> : " + m);
	//			matrlInOutWhsAdmVo.setBarcodeNo((m.get("barcodeNo").toString()));
	//			matrlInOutWhsAdmVo.setLocationCd(m.get("approvalCd").toString());
	//			//matrlInOutWhsAdmVo.setStatusCd("I");
	//			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
	//			logger.info("입출고관리 자재가출고수정처리 ourlIt = " + matrlInOutWhsAdmVo);
	//			PdaService.updateMatrlApproval(matrlInOutWhsAdmVo);
	//			jsonData.put("result", "ok");
	//		}
	//	} catch (Exception e) {
	//		logger.info("자재입고 자재위치 Update 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//
	//	return jsonData;
	//}
	
	//자재 상태확인
	@RequestMapping(value = "/pdsc0100", method = RequestMethod.GET)
	public String pdsc0100(Model model) throws Exception {

		logger.info("PDA 자재 상태확인 페이지");
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("004"); // Location
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("locationCode", systemCommonCodeList);
		//model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0100";
	}

	//자재 불량&반품 바코드스캔
	@RequestMapping(value = "/pd/matrlStatusCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlStatusCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재 불량&반품 바코드스캔");
		logger.info(matrlInOutWhsAdmVo.toString());

		try {
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			logger.info(matrlInOutWhsAdmVo.toString());
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");

		} catch (NullPointerException e) {
			logger.info("조회된 값이 없습니다.");
			jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
			jsonData.put("result", "fail");
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//제품 상태확인
	@RequestMapping(value = "/pdsc0110", method = RequestMethod.GET)
	public String pdsc0110(Model model) throws Exception {

		logger.info("PDA 제품 상태확인 페이지");
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("goodsFaultyType", systemCommonCodeList);
		//model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "pd/pdsc0110";
	}
	
	//제품 상태확인 바코드스캔
	@RequestMapping(value = "/pd/goodsStatusCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsStatusCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 상태확인 - " + goodsProductInfoAdmVo);

		try {
			//재고 제품
			if (goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S")) {
				PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
				preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
				preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
				jsonData.put("data", preGoodsInventoryDtl);
				jsonData.put("result", "ok");
			
			//생산 제품
			} else {
				goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
				jsonData.put("data", goodsProductInfoAdmVo);
				jsonData.put("result", "ok");
			}

		} catch (NullPointerException e) {
			logger.info("조회된 값이 없습니다.");
			jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
			jsonData.put("result", "fail");
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//PDA 자재부적합현황관리
	@RequestMapping(value = "/pdsc0120", method = RequestMethod.GET) 
	public String pdsc0120(Model model, HttpServletRequest request) throws Exception {
		logger.info("PDA 자재부적합현황관리 페이지");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("026"); // 승인 구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList);
		
		return "pd/pdsc0120";
	}
	
	//자재 불량&반품 바코드스캔
	@RequestMapping(value = "/pd/matrlFaultyVoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyVoList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			MatrlInOutWhsAdmVo matrlFaultyVoList = new MatrlInOutWhsAdmVo();
			jsonData.put("data", matrlFaultyVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//자재 불량&반품 바코드스캔
	@RequestMapping(value = "/pd/matrlFaultyCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
//			List<MatrlInOutWhsAdmVo> barcodeList = matrlInOutWhsAdmService.listInWhsAll(matrlInOutWhsAdmVo);

			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			
//			logger.info("barcodeList 값 확인 ----> " +barcodeList);
//			logger.info("barcodeList 값 확인 ----> " +barcodeList.size());
			
			logger.info("barcodeList 값 확인 ----> " +matrlInOutWhsAdmVo);
			
			
			/*if(barcodeList.size() == 0) {
				jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
				jsonData.put("result", "fail");
			} else {
				logger.info(matrlInOutWhsAdmVo.toString());
				jsonData.put("data", barcodeList);
				jsonData.put("result", "ok");
			}*/
			
			if(matrlInOutWhsAdmVo == null) {
				jsonData.put("message", "조회된 값이 없습니다. BarcodeNo를 확인해주세요.");
				jsonData.put("result", "fail");
			} else {
				logger.info(matrlInOutWhsAdmVo.toString());
				jsonData.put("data", matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//자재 잔량 변경
	@RequestMapping(value = "/pd/updateRemainQty", method = RequestMethod.POST)
//	public @ResponseBody Map<String, Object> updateRemainQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
	public @ResponseBody Map<String, Object> updateRemainQty(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				
				matrlInOutWhsAdmVo.setRemainQty(m.get("remainQty").toString());
				matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
				
				matrlInOutWhsAdmService.updateRemainQty(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	
	
	//파레트 번호로 PO정보 조회
	@RequestMapping(value = "/pd/poSeqSerchRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> poSeqSerchRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("파레트 번호로 PO정보 조회");
			
			//파레트 번호로 PO정보 조회
			purchaseOrderAdmVo = PdaService.poSeqSerchRead(purchaseOrderAdmVo);
			
			if( purchaseOrderAdmVo != null ) {
				jsonData.put("data", purchaseOrderAdmVo);
				jsonData.put("result", "ok");				
			} else {
				jsonData.put("message", "조회된 PO번호가 없습니다.<br>파레트 번호를 확인해주세요.");
				jsonData.put("result", "fail");
			}

		} catch (NullPointerException e) {
			logger.info("조회된 값이 없습니다.");
			jsonData.put("message", "조회된 수주번호가 없습니다.파레트번포를 확인해주세요.");
			jsonData.put("result", "fail");
			e.printStackTrace();
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	
	//파레트라벨 매핑 등록 관련
	@RequestMapping(value = "/pd/palletMappingRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> palletMappingRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			PurchaseOrderAdmVo purchaseOrderAdmRead = PdaService.palletMappingRead(purchaseOrderAdmVo);
			
			String poGroupCount = "";
			
			if( purchaseOrderAdmRead != null ) {
				poGroupCount = purchaseOrderAdmRead.getPoGroupCount();	
			}
			
			jsonData.put("data", purchaseOrderAdmRead);
			jsonData.put("poGroupCount", poGroupCount);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//파레트 번호 매칭 수정
	@RequestMapping(value = "/pd/palletMappingUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletMappingUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			JSONParser jsonParser	= new JSONParser();
			JSONObject jsonObj		= new JSONObject();
			JSONArray jsonArray		= (JSONArray) jsonParser.parse(purchaseOrderAdmVo.getPalletMappingDataArray());
			PurchaseOrderAdmVo purchaseOrderAdmRead = new PurchaseOrderAdmVo(); 
			
			for(int i=0; i<jsonArray.size(); i++ ) {
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				purchaseOrderAdmVo.setPoGroup( jsonObjDtl.get("palletNo").toString() );
				purchaseOrderAdmVo.setCustomerPalletNo( jsonObjDtl.get("customerPalletNo").toString() );
				purchaseOrderAdmVo.setUpdId(Utils.getUserId());
				
				purchaseOrderAdmRead = PdaService.palletMappingRead(purchaseOrderAdmVo);
				
				//값 체킹 후 저장 처리 진행
				if( purchaseOrderAdmRead != null ) {
					PdaService.palletMappingUpdate(purchaseOrderAdmVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("result", "faile");
				}
				
			}
			
			
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//파레트라벨 매핑 등록 관련
	@RequestMapping(value = "/pd/palletFactCheckRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> palletFactCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			PurchaseOrderAdmVo palletFactCheckRead = PdaService.palletFactCheckRead(purchaseOrderAdmVo);
			
			String factCheck = "";
			
			if( palletFactCheckRead != null ) {
				factCheck = palletFactCheckRead.getFactCheck();	
			}
			
			jsonData.put("data", factCheck);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//출하대기체크 수정
	@RequestMapping(value = "/pd/palletBoxFactCheckUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletBoxFactCheckUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
			purchaseOrderAdmVo.setPoGroup(goodsProductInfoAdmVo.getPoGroup());
			PurchaseOrderAdmVo purchaseOrderAdmRead = PdaService.palletMappingRead(purchaseOrderAdmVo);
			
			//값 체킹 후 저장 처리 진행
			if( purchaseOrderAdmRead != null ) {
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				PdaService.palletBoxFactCheckUpdate(goodsProductInfoAdmVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "faile");
			}
			
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	
	//파레트라벨 매핑 등록 관련
	@RequestMapping(value = "/pd/palletCustomerCheckRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> palletCustomerCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			PurchaseOrderAdmVo palletCustomerCheckRead = PdaService.palletCustomerCheckRead(purchaseOrderAdmVo);
			
			String factCheck = "";
			
			if( palletCustomerCheckRead != null ) {
				jsonData.put("data", palletCustomerCheckRead);
				factCheck = palletCustomerCheckRead.getFactCheck();
				jsonData.put("factCheck", factCheck);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("data", palletCustomerCheckRead);
				jsonData.put("factCheck", factCheck);
				jsonData.put("result", "faile");
			}
			
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	
	//제품 입고 전 스캔
	@RequestMapping(value = "/pd/goodsProductBeforeScan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductBeforeScan(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			
			/*if( goodsProductInfoAdmVo.getGoodsStatus().equals("006") ) {
				jsonData.put("data", goodsProductInfoAdmVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", goodsProductInfoAdmVo);
				jsonData.put("result", "faile");
			}
			*/
			
			if( goodsProductInfoAdmVo == null ) {
				jsonData.put("message", "조회된 BoxNo가 없습니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else {
				
				//스캔된 박스 상태 확인
				if (goodsProductInfoAdmVo.getGoodsStatus().equals("003")) {
					jsonData.put("message", "이미 출하된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDisuseYn().equals("Y")) {
					jsonData.put("message", "폐기된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDivisionYn().equals("D")) {
					jsonData.put("message", "분할된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else if (goodsProductInfoAdmVo.getDivisionYn().equals("M")) {
					jsonData.put("message", "병합된 BoxNo 입니다.");
					jsonData.put("result", "fail");
					return jsonData;
				} else {
					if(goodsProductInfoAdmVo.getCompleteYn() != null && "002".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
						jsonData.put("message", "이미 파레트 포장된 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					//포장대기인 상태 스캔 시
					if("007".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
						jsonData.put("message", "이미 입고된 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					//
					if(!"006".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
						jsonData.put("message", "검사완료 상태만 스캔 가능합니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					//불량인 경우
					if(!"001".equals(goodsProductInfoAdmVo.getFaultyStatus())) {
						jsonData.put("message", "정상인 제품이 아닙니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					//폐기인 경우
					if("003".equals(goodsProductInfoAdmVo.getDisposeGubun())) {
						jsonData.put("message", "폐기지정된 제품입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}
				
				if ( goodsProductInfoAdmVo.getMergeYn() == null ) {
					ShipInspectVo shipInspectVoByTray3 = new ShipInspectVo();
					String trayNo = goodsProductInfoAdmVo.getBoxNo();
	
					//1공장에서는 3개짜리 트레이 번호를 사용하지 않음.
					//기존 BoxNo가 아닌 신규 트레이 BoxNo인 경우에만 실행
					if( trayNo.length() != 13 || "003".equals(factoryCode) ) {
						shipInspectVoByTray3.setTrayNo(trayNo);
						shipInspectVoByTray3 = shipInspectService.shipInspectAdmSelByGoodsIn(shipInspectVoByTray3);
						
						//3개짜리 트레이 번호가 없을 때 실행
						if (shipInspectVoByTray3 == null) {
							ShipInspectVo shipInspectVoByTray6 = new ShipInspectVo();
							
							trayNo = trayNo.length() != 13 ? trayNo.substring(0, trayNo.length() - 2) : trayNo;
							shipInspectVoByTray6.setTrayNo(trayNo);
							shipInspectVoByTray6 = shipInspectService.shipInspectAdmSelByGoodsIn(shipInspectVoByTray6);
							
							if( shipInspectVoByTray6 != null ) {
								//출하검사 상태가 합격이 아니면
								if (!"001".equals(shipInspectVoByTray6.getInspStatus())) {
									jsonData.put("message", shipInspectVoByTray6.getReInspStatusNm() + " 합격 제품이 아닙니다!");
									jsonData.put("result", "fail");
									return jsonData;
									
								//출하검사 폐기가 정상이 아니면
								} else if (!"002".equals(shipInspectVoByTray6.getDisStatus())) {
									jsonData.put("message", "폐기 상태의 제품입니다!");
									jsonData.put("result", "fail");
									return jsonData;
								}
							}
						} else {
							//3개짜리 트레이 번호가 있을 때 실행
							
							if( shipInspectVoByTray3 != null ) {
								//출하검사 상태가 합격이 아니면
								if (!"001".equals(shipInspectVoByTray3.getInspStatus())) {
									jsonData.put("message", shipInspectVoByTray3.getReInspStatusNm() + " 합격 제품이 아닙니다!");
									jsonData.put("result", "fail");
									return jsonData;
								//출하검사 폐기가 정상이 아니면
								} else if (!"002".equals(shipInspectVoByTray3.getDisStatus())) {
									jsonData.put("message", "폐기 상태의 제품입니다!");
									jsonData.put("result", "fail");
									return jsonData;
								//출하검사 폐기가 정상이 아니면
								} else if ("002".equals(shipInspectVoByTray3.getReInspStatus())) {
									jsonData.put("message", "출하재검을 진행해 주세요!");
									jsonData.put("result", "fail");
									return jsonData;
								}
							}
						}
					}
					jsonData.put("data", goodsProductInfoAdmVo);
					jsonData.put("result", "ok");
				}
			}
			
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//포장대기로 상태값 변경
	@RequestMapping(value = "/pd/packingWaitingStatusUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> packingWaitingStatusUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			//GoodsProductInfoAdmVo data = new GoodsProductInfoAdmVo();
			//data = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
			
			goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			goodsProductInfoAdmVo.setInWhsDate(DateUtil.getToday("yyyymmdd"));
			PdaService.packingWaitingStatusUpdate(goodsProductInfoAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("PDA 자재입고 바코드 스캔 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
}