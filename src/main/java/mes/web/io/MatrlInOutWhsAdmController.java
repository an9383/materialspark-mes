package mes.web.io;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.InspectInfoAdmVo;
import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.bs.PurchaseOrderDtl;
import mes.domain.bs.PurchaseOrderOutputHistVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.pd.GoodsProductInfoAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.ShipInspectVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.MatrlInWhsRqtService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.po.GoodsPackService;
import mes.service.po.WorkOrderService;
import mes.service.qm.ShipInspectService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Film;
import mes.web.ut.Utils;

@Controller
public class MatrlInOutWhsAdmController {
	
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
	@Inject
	private ShipInspectService shipInspectService;
	@Inject
	private GoodsPackService goodsPackService;
	
	//문서관리 파일 업로드_경로 지정
	@Value("${file.matrlInOutReport}")
	private String matrlInOutReport;
	
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	@Value("${lablePrint.IP1}") private String IP1;
	@Value("${lablePrint.IP2}") private String IP2;
	
	@Value("${lablePrint.port}") private String PORT;

	//입출고관리 자재입고(바코드) 메인
	@RequestMapping(value = "/iosc0020", method = RequestMethod.GET)
	public String matrlInOutWhsPreMain(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 자재입고(바코드) 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("077"); //자재창고
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("062"); //자재 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList );
		
		//MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
		//List<MatrlCodeAdmVo> matrlCdList = matrlCodeAdmService.matrlCdList(matrlCodeAdmVo);
		//model.addAttribute("matrlCdList", matrlCdList );
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setInWhsDate(DateUtil.getToday("yyyymmdd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.matrlCdInOutList(matrlInOutWhsAdmVo);
		logger.info("iosc0020 초기" + matrlCdInOutList);
		model.addAttribute("matrlCdList", matrlCdInOutList );
		
		return "io/iosc0020";
	}
	
	//입출고관리 반품등록메인
	@RequestMapping(value = "/iosc3080", method = RequestMethod.GET)
	public String matrlIncongruityMain(Locale locale, Model model) throws Exception {
		logger.info("입출고관리 자재 부적합 현황");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
        MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
        String day = DateUtil.getToday("yyyymmdd").substring(0, 6);
		
		//재검일자
        if( factoryCode.equals("001") || factoryCode.equals("002") ) {
        	matrlInOutWhsAdmVo.setInWhsDateFrom(day);
    		matrlInOutWhsAdmVo.setInWhsDateTo(day);        	
        } else if( factoryCode.equals("003") ) {
        	matrlInOutWhsAdmVo.setInWhsDateFrom_F3(day);
    		matrlInOutWhsAdmVo.setInWhsDateTo_F3(day);
        }
		matrlInOutWhsAdmVo.setTapTemp("7");
		List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmList = matrlInOutWhsAdmService.matrlFaultyTypeList(matrlInOutWhsAdmVo);
		model.addAttribute("matrlInOutWhsAdmList", matrlInOutWhsAdmList );
        
		return "io/iosc3080";
	}
	
	
	//제품출고요청 PO 기준 미출고 현황 메인
	@RequestMapping(value = "/iosc0050", method = RequestMethod.GET)
	public String matrlUnreleasedAdmMain(Locale locale, Model model) throws Exception {
		logger.info("제품출고요청 PO 기준 미출고 현황");		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-MM-dd") );			
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		return "io/iosc0050";		

	}
	
	//입출고관리 입고현황메인(1공장, 2공장 사용)
	@RequestMapping(value = "/iosc0030", method = RequestMethod.GET)
	public String matrlInOutWhsMain(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 입고현황관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("077"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("062"); //자재 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("033"); // 공장
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("factoryCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("agreeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("047"); // 자재 상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("statusCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setInWhsDateFrom(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setInWhsDateTo(DateUtil.getToday("yyyy-mm-dd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.matrlCdInOutList(matrlInOutWhsAdmVo);
		model.addAttribute("matrlCdList", matrlCdInOutList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc0030";
	}
	
	//입출고관리 입고현황메인(1공장, 2공장 사용)
	@RequestMapping(value = "/iosc3030", method = RequestMethod.GET)
	public String matrlInOutWhsMain_F3(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 입고현황관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("077"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("062"); //자재 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("033"); // 공장
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("factoryCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("agreeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("047"); // 자재 상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("statusCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setInWhsDateFrom(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setInWhsDateTo(DateUtil.getToday("yyyy-mm-dd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.matrlCdInOutList(matrlInOutWhsAdmVo);
		model.addAttribute("matrlCdList", matrlCdInOutList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc3030";
	}
	
	//입출고관리 Location수정
	@RequestMapping(value = "/io/matrlCdInOutList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdInOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재입고(바코드) 검색일 자재명List");
		try {
			List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.matrlCdInOutList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlCdInOutList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자재입고(바코드) 검색일 자재명List");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 수입검사 자재명 리스트
	@RequestMapping(value = "/io/inspectMatrlCodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectMatrlCodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사 검색일 자재명List");
		try {
			List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.inspectMatrlCodeList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlCdInOutList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("수입검사 검색일 자재명List");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리 자재투입 선입선출체크 리스트
	@RequestMapping(value = "/io/inputFifoCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inputFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 자재투입 선입선출체크 List");
		try {
			List<MatrlInOutWhsAdmVo> fifoCheck = matrlInOutWhsAdmService.inputFifoCheck(matrlInOutWhsAdmVo);
			jsonData.put("data", fifoCheck);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("입출고관리 자재투입 선입선출체크 List");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//입출고관리 반품등록메인
	@RequestMapping(value = "/iosc0080", method = RequestMethod.GET)
	public String matrlReturnMain(Locale locale, Model model) throws Exception {
		logger.info("입출고관리 반품등록메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc0080";
	}
	
	//입출고관리 자재투입(재고_출고량)
	@RequestMapping(value = "/iosc0040", method = RequestMethod.GET)
	public String matrlOutputWhsMain(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 자재투입(재고_출고량) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("125"); // 층구분자
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("floorCd", systemCommonCodeList);
		
        model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );		
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "io/iosc0040";
	}
	
	//입출고관리-제품출하 
	@RequestMapping(value = "/iosc0060", method = RequestMethod.GET)
	public String productShipmentGet(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 제품출하 메인");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList);
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "io/iosc0060";
	}
	
	//입출고관리-제품출하 
	@RequestMapping(value = "/iosc3060", method = RequestMethod.GET)
	public String productShipmentGet_F3(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 제품출하 메인");		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList);
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "io/iosc3060";
	}
	
	//입출고관리 선입선출관리
	@RequestMapping(value = "/iosc0090", method = RequestMethod.GET)
	public String firstInFirstOutMain(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 선입선출 관리 메인");
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        
		return "io/iosc0090";
	}	
	
	//입출고관리 입고현황메인(1공장, 2공장 사용)
	@RequestMapping(value = "/iosc0160", method = RequestMethod.GET)
	public String matrlInOutWhsMain0160(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 입고현황관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("077"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("062"); //자재 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("033"); // 공장
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("factoryCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("agreeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("047"); // 자재 상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("statusCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setInWhsDateFrom(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setInWhsDateTo(DateUtil.getToday("yyyy-mm-dd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.matrlCdInOutList(matrlInOutWhsAdmVo);
		model.addAttribute("matrlCdList", matrlCdInOutList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc0160";
	}
	
	
	//잔량이력관리(3공장만 사용)
	@RequestMapping(value = "/iosc3040", method = RequestMethod.GET)
	public String iosc3040(Locale locale, Model model) throws Exception {
		logger.info("잔량이력관리");		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-MM-dd") );			
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("poGubunCd", systemCommonCodeList );
		
		return "io/iosc3040";		

	}
	
	
	//입출고관리 가입고목록조회
	@RequestMapping(value = "/io/matrlInOutWhsPreDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsPreDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 가입고목록조회 = " + matrlInOutWhsAdmVo);
		try {
			String exceptSelectModalBarcodeNo	= matrlInOutWhsAdmVo.getExceptBarcodeNo();	//선택한 바코드
			logger.info("값 확인하는 코드 : " +exceptSelectModalBarcodeNo);
			logger.info("rkqt ghkrdls : " +exceptSelectModalBarcodeNo.contains("empty"));
			
			boolean firstScanCheck = exceptSelectModalBarcodeNo.contains("empty");
			String exceptBoxNoQuery = exceptSelectModalBarcodeNo.replace("/", "', '");
			
			if (firstScanCheck) {
				//이미 몇번 스캔하였으면..
			} else {
				exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
				logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
				exceptBoxNoQuery += "'";
				logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);		
			}
			
			String inApprovalCd = matrlInOutWhsAdmVo.getInApprovalCd().replace("/", "', '");
			
			matrlInOutWhsAdmVo.setExceptBarcodeNo(exceptBoxNoQuery);
			matrlInOutWhsAdmVo.setInApprovalCd(inApprovalCd);
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listPreInWhsAll(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 가입고목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	
	
	//제품출하 목록조회
	@RequestMapping(value = "/io/productShipmentDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productShipmentDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 제품출하목록조회 = " + matrlInOutWhsAdmVo);
		try {
			matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listAllProductShipment(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품출하 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//제품출하 상세목록조회
	@RequestMapping(value = "/io/productShipmentDtlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productShipmentDataListDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 제품출하 상세 목록조회 = " + matrlInOutWhsAdmVo);
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listAllProductShipmentDtl(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품출하 상세목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//제품출하 승인 업데이트
	@RequestMapping(value = "/io/productShipmentDataUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> productShipmentDataUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 제품출하 승인 업데이트  = " + matrlInOutWhsAdmVo);
		try {
			
			if(factoryCode.equals("001") || factoryCode.equals("002")) {
				matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
				Integer chkPallet = 0; 
				String poGrp = matrlInOutWhsAdmVo.getPoGroup();
				String newPoGrp = matrlInOutWhsAdmVo.getNewPoGroup();
				
				if(poGrp.equals(newPoGrp) == false) {
					chkPallet = matrlInOutWhsAdmService.checkPalletNo(matrlInOutWhsAdmVo);
				}
				
				if(chkPallet == 0 ) {
					matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
					matrlInOutWhsAdmService.updateApproval(matrlInOutWhsAdmVo);
					matrlInOutWhsAdmService.updateDtlPoGroup(matrlInOutWhsAdmVo);
					jsonData.put("result", "ok");
				}else {
					logger.info("존재하는 번호");
					jsonData.put("result", "exist");
				}
				
			}else {
			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmService.updateApproval(matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("입출고관리 제품출하 승인 업데이트 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//제품출하 출하 취소 체크
	@RequestMapping(value = "/io/productOutputCancelCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productOutputCancelCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품출하 출하 취소 체크  - " + purchaseOrderAdmVo);
		
		//받아온 PoNo의 값과 검색한 PoNo의 값이 같은지 확인
		try {
			int i = purchaseOrderAdmService.productOutputCancelCheck(purchaseOrderAdmVo);
			if (i != Integer.parseInt(purchaseOrderAdmVo.getPoGroup()) ) {
				
				PurchaseOrderAdmVo readPurchaseOrderAdmVo = new PurchaseOrderAdmVo();
				readPurchaseOrderAdmVo.setPoSeq(purchaseOrderAdmVo.getPoSeq());
				readPurchaseOrderAdmVo = purchaseOrderAdmService.read(readPurchaseOrderAdmVo);
				
				jsonData.put("message", "해당 등록번호(" + readPurchaseOrderAdmVo.getPoSeq() + ")<br>PO Number(" + readPurchaseOrderAdmVo.getPoNo() + ") 중 가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
				jsonData.put("result", "fail");
			} else {
				jsonData.put("message", "출하 취소 가능한 PO입니다.");
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("제품출하 출하 취소 체크 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품출하 출하 취소
	@RequestMapping(value = "/io/productOutputCancel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> productOutputCancel(@RequestBody List<Map<String, Object>> goodsBoxNoList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출하 취소 - " + goodsBoxNoList);
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();

		try {
			
			//불량상태 정상인지 확인
			//검사 반품일 경우에만 
			for (Map<String, Object> m : goodsBoxNoList) {
				String boxNo = m.get("boxNo").toString();	//출하 취소 BoxNo
				String removeTrayGubun = m.get("removeTrayGubun").toString();
				
				if ( boxNo.toString().substring(0, 1).equals("S") ) {
//					PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();	//재고제품
//					preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
//					if (!"001".equals(preGoodsInventoryDtl.getFaultyStatus())) {
//						jsonData.put("message", "불량 상태가 정상인 제품만 출하취소가 가능합니다!");
//						jsonData.put("result", "fail");
//						return jsonData;
//					}
				} else {
					if ("returnReInspect".equals(removeTrayGubun)) {
						GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();	//생산제품
						goodsProductInfoAdmVo.setBoxNo(boxNo);
						goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
						
						if (goodsProductInfoAdmVo.getMergeYn() != null) {
							jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + " - 분할&병합된 제품은 검사반품을 보낼 수 없습니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}	
					}
				}
			}
			PurchaseOrderAdmVo purchaseReadVo = new PurchaseOrderAdmVo();
			purchaseReadVo.setBoxNo(goodsBoxNoList.get(0).get("boxNo").toString());
			List<PurchaseOrderAdmVo> purchaseReadList = purchaseOrderAdmService.tracePurchaseOrderOutputHist2(purchaseReadVo);
			
			
			//String poSeq			= goodsBoxNoList.get(0).get("poSeq").toString();
			//String poGroup			= goodsBoxNoList.get(0).get("poGroup").toString();
			//String goodsStatusCheck	= goodsBoxNoList.get(0).get("poGroup").toString();
			
			String poSeq			= purchaseReadList.get(0).getPoSeq().toString();
			String poGroup			= purchaseReadList.get(0).getPoGroup().toString();
			String goodsStatusCheck	= purchaseReadList.get(0).getPoGroup().toString();
			
			int dtlCount	= Integer.parseInt(goodsBoxNoList.get(0).get("dtlCount").toString());	//현재 취소처리할 dtl의 변경 감지
			
			purchaseOrderAdmVo.setPoSeq(poSeq);
			
			PurchaseOrderAdmVo readPurchaseOrderAdmVo = new PurchaseOrderAdmVo();
			readPurchaseOrderAdmVo.setPoSeq(poSeq);
			readPurchaseOrderAdmVo = purchaseOrderAdmService.read(readPurchaseOrderAdmVo);
			
//			//제품출하 출하 취소 체크
//			int i = purchaseOrderAdmService.productOutputCancelCheck(purchaseOrderAdmVo);
//			if (i != Integer.parseInt(poGroup) ) {
//				
//				jsonData.put("message", "해당 등록번호(" + readPurchaseOrderAdmVo.getPoSeq() + ")<br>PO Number(" + readPurchaseOrderAdmVo.getPoNo() + ") 중 가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
//				jsonData.put("result", "fail");
//				
//			//출하 취소 처리 진행
//			} else {
				
				//dtlCount 사용하여 count 비교하기!!
				PurchaseOrderDtl purchaseOrderDtlCheck = new PurchaseOrderDtl();
				purchaseOrderDtlCheck.setPoSeq(poSeq);
				purchaseOrderDtlCheck.setPoGroup(poGroup);
				int dtlCountCheck = purchaseOrderAdmService.purchaseOrderDtlDeleteCheck(purchaseOrderDtlCheck);
				
				//개수가 변경되었으면 출하 처리 취소(이미 누군가 삭제하였음)
				if ( dtlCount != dtlCountCheck ) {
					jsonData.put("message", "해당 등록번호(" + readPurchaseOrderAdmVo.getPoSeq() + ")<br>PO Number(" + readPurchaseOrderAdmVo.getPoNo() + ") 중 가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
					jsonData.put("result", "fail");
					
				//진짜 출하 취소처리 진행
				} else {
					int cancelOutputSum = 0;	//출하취소 합계 수량
					for (Map<String, Object> m : goodsBoxNoList) {
						
						String boxNo = m.get("boxNo").toString();	//출하 취소 BoxNo
						int ouputCnt = Integer.parseInt(m.get("ouputCnt").toString());	//출하 수량
						String removeTrayGubun = m.get("removeTrayGubun").toString();	//cancelTray:출하취소 & returnReInspect:출하재검사
						
						//재고 제품 출하 취소처리
						if ( boxNo.toString().substring(0, 1).equals("S") ) {
							PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();	//재고제품
							preGoodsInventoryDtl.setBoxNo(boxNo);
							//해당boxNo로 재고제품을 읽어 와서 남아있는 잔여수량에다가 출하 취소수량 + & 상태값 입고(002)로
							preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
							preGoodsInventoryDtl.setRemainCnt( preGoodsInventoryDtl.getRemainCnt() + ouputCnt); //잔여수량 + 출하수량
							preGoodsInventoryDtl.setGoodsStatus("002");
							preGoodsInventoryDtl.setUpdId(Utils.getUserId());
							preGoodsInventoryDtl.setHistId(Utils.getUserId());
							//해당 재고제품 INFO UPDATE
							PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl);
							preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
							
							
							String stockPaymentLocationCd = null;
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
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
							stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryDtl.getGoodsCd(), preGoodsInventoryDtl.getBoxNo(), "003", "I", stockPaymentLocationCd, preGoodsInventoryDtl.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//수불 +
							
						//생산 제품 출하 취소처리
						} else {
							GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();	//생산제품
							goodsProductInfoAdmVo.setBoxNo(boxNo);
							//해당boxNo로 생산제품을 읽어 와서 남아있는 잔여수량에다가 출하 취소수량 + & 상태값 입고(002)로
							goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
							goodsProductInfoAdmVo.setRemainCnt( goodsProductInfoAdmVo.getRemainCnt() + ouputCnt); //잔여수량 + 출하수량
							
							//출하취소
							if ("cancelTray".equals(removeTrayGubun)) {
								goodsProductInfoAdmVo.setGoodsStatus("002");
								
								if(factoryCode.equals("003")) {
									goodsProductInfoAdmVo.setGoodsStatus("004");	//출하대기 상태
								}
								
							//검사반품
							} else if ("returnReInspect".equals(removeTrayGubun)) {
								goodsProductInfoAdmVo.setGoodsStatus("001");
								goodsProductInfoAdmVo.setFaultyStatus("003");
								
								if(factoryCode.equals("003")) {
									goodsProductInfoAdmVo.setGoodsStatus("002");	//입고상태로(3공장은 포장 없음)
									goodsProductInfoAdmVo.setCompleteYn("N");		//미료 상태로 변경해줌.
								}
								
								//트레이 박스일 때에만 검사반품 테이블에 Ins
								if (boxNo.length() == 15) {
									//검사반품 이력 쌓아두면 됨
									ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
									shipInspectAdmVo.setTrayNo(boxNo);
									shipInspectAdmVo.setTrayNo1(boxNo);
									shipInspectAdmVo.setTrayNo2(boxNo);
									
									ShipInspectVo shipInspectReadVo = new ShipInspectVo();
									shipInspectReadVo.setReInspStatus("001");
									shipInspectReadVo.setTrayNo(boxNo.substring(0,boxNo.length()-2));
									List<ShipInspectVo> ReadList = shipInspectService.shipInspAdmRead(shipInspectReadVo);
									
									//트레이 번호로 작업지시 조회
									GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo = new GoodsProductInfoAdmVo();	//생산제품
									readTrayBoxByWorkOrdNo.setBoxNo(boxNo);
									readTrayBoxByWorkOrdNo = PdaService.readTrayBoxByWorkOrdNo(readTrayBoxByWorkOrdNo);
									
									//shipInspectService.shipInspAdmRead(shipInspectAdmVo);
									shipInspectAdmVo.setWorkOrdNo(readTrayBoxByWorkOrdNo.getWorkOrdNo());
									shipInspectAdmVo.setMatrlLotNo(readTrayBoxByWorkOrdNo.getMatrlLotNo());
									shipInspectAdmVo.setFilmLotNo(readTrayBoxByWorkOrdNo.getFilmLotNo());
									//shipInspectAdmVo.setInspStatus();
									shipInspectAdmVo.setReInspStatus("003");
									//shipInspectAdmVo.setDisStatus();
									//shipInspectAdmVo.setInspDate( date );
									shipInspectAdmVo.setFaultyCnt("0");
									//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
									//shipInspectAdmVo.setInspChargr(inspChargr);
									shipInspectAdmVo.setDayNightCd(ReadList.get(0).getDayNightCd());
									shipInspectAdmVo.setProductDate(ReadList.get(0).getProductDate());
									//shipInspectAdmVo.setFaultyGubun(faultyGubun);
									shipInspectAdmVo.setNextGubun("001");				//출하재검
									shipInspectAdmVo.setRegId( Utils.getUserId() );
									
									String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
									shipInspectAdmVo.setSeq(seq);
									
									shipInspectService.shipAdmCreate(shipInspectAdmVo);	
								}
							}
							goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
							goodsProductInfoAdmVo.setHistId(Utils.getUserId());
							//해당 생산제품 INFO UPDATE
							PdaService.updateBox(goodsProductInfoAdmVo);
							PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
							
							String stockPaymentLocationCd = null;
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
							}
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
							stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmVo.getGoodsCd(), goodsProductInfoAdmVo.getBoxNo(), "002", "I", stockPaymentLocationCd, Integer.parseInt(goodsProductInfoAdmVo.getPackCnt()), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//수불 +
							goodsStatusCheck = goodsProductInfoAdmVo.getGoodsStatus();
						}
						
						//출하대기 상태가 아닌경우 실행
						if (!goodsStatusCheck.equals("004")) {
							//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
							PurchaseOrderDtl deletePurchaseOrderDtl = new PurchaseOrderDtl();
							deletePurchaseOrderDtl.setPoSeq(poSeq);
							deletePurchaseOrderDtl.setPoGroup(Integer.toString( Integer.parseInt(poGroup) ));
							deletePurchaseOrderDtl.setBoxNo(boxNo);
							purchaseOrderAdmService.deletePurchaseOrderDtl(deletePurchaseOrderDtl);
						}
						
						cancelOutputSum += ouputCnt;
					}
					
					//출하대기 상태가 아닌경우 실행
					if (!goodsStatusCheck.equals("004")) {
						//DELETE 기록 남기기
						PurchaseOrderOutputHistVo createPurchaseCancelHist = new PurchaseOrderOutputHistVo();
						createPurchaseCancelHist.setPoSeq(poSeq);
						createPurchaseCancelHist.setPoGroup(poGroup);
						createPurchaseCancelHist.setCancelOutputSum(-cancelOutputSum);
						createPurchaseCancelHist.setRegId(Utils.getUserId());
						purchaseOrderAdmService.createPurchaseCancelHist(createPurchaseCancelHist);
						
						//PO_ADM 미출고수량, 출고수량 UPDATE
	//					purchaseOrderAdmVo.setOutputQty(cancelOutputSum);
	//					purchaseOrderAdmVo.setRemainQty(cancelOutputSum);
	//					purchaseOrderAdmVo.setUpdId(Utils.getUserId());
	//					purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
						createPurchaseCancelHist.setCancelOutputSum(+cancelOutputSum);
						
						if(factoryCode.equals("001") || factoryCode.equals("002")) {
							purchaseOrderAdmService.removeTrayByPallet(createPurchaseCancelHist);
						} else {
							purchaseOrderAdmService.removeTrayByPallet_F3(createPurchaseCancelHist);
						}
						
						//출하seq 0일경우 삭제
						//이후 PO_HIST도 출하취소 합계수량만큼 미출고수량은 +, 출고수량은 - 하여 Update
						PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
						purchaseOrderOutputHistVo.setPoSeq(poSeq);
						purchaseOrderOutputHistVo.setPoGroup(poGroup);
						purchaseOrderOutputHistVo.setCancelOutputSum(cancelOutputSum);
						purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
						//purchaseOrderAdmService.updatePurchaseOutputHist(purchaseOrderOutputHistVo);	->removeTrayByPallet 서비스에서 대신수행
						
						//PO_HIST 업데이트 후에 다시 조회하여 출하수량(outputCnt)이 0이면 모두 출하취소된 PO라 삭제
						purchaseOrderOutputHistVo = purchaseOrderAdmService.readPurchaseOrderOutputHist(purchaseOrderOutputHistVo);
						//해당PO 출하량이 0인 출하기록 삭제
						if (purchaseOrderOutputHistVo.getOutputQty() == 0) {
							purchaseOrderAdmService.deletePurchaseOrderOutputHist(purchaseOrderOutputHistVo);
						}
						
						purchaseOrderAdmVo.setPoSeq(poSeq);
						purchaseOrderAdmVo = purchaseOrderAdmService.read(purchaseOrderAdmVo);
						
						purchaseOrderAdmVo.setUpdId(Utils.getUserId());
						purchaseOrderAdmVo.setOutputQty(purchaseOrderAdmVo.getOutputQty() - cancelOutputSum); //출고수량 누적+
						purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() + cancelOutputSum); //미출고수량 누적-
						purchaseOrderAdmService.updateQty(purchaseOrderAdmVo);
					}
					
					jsonData.put("message", "정상적으로 처리 되었습니다.");
					jsonData.put("result", "ok");
				}
//			}
			
		} catch (Exception e) {
			logger.info("제품출하 출하 취소 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//제품출하 출하 취소
	@RequestMapping(value = "/io/productOutputCancel2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> productOutputCancel2(@RequestBody List<Map<String, Object>> goodsBoxNoList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품 출하 취소 - " + goodsBoxNoList);
		PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
		GoodsProductInfoAdmVo goodsProductInfoAdmReadVo = new GoodsProductInfoAdmVo();
		try {
			
			//불량상태 정상인지 확인
			//검사 반품일 경우에만 
			for (Map<String, Object> m : goodsBoxNoList) {
				String boxNo = m.get("boxNo").toString();	//출하 취소 BoxNo
				String removeTrayGubun = m.get("removeTrayGubun").toString();
				
				if ( boxNo.toString().substring(0, 1).equals("S") ) {

				} else {
					if ("returnReInspect".equals(removeTrayGubun)) {
						goodsProductInfoAdmReadVo = new GoodsProductInfoAdmVo();	//생산제품
						goodsProductInfoAdmReadVo.setBoxNo(boxNo);
						goodsProductInfoAdmReadVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmReadVo);
						
						if (goodsProductInfoAdmReadVo.getMergeYn() != null) {
							jsonData.put("message", goodsProductInfoAdmReadVo.getBoxNo() + " - 분할&병합된 제품은 검사반품을 보낼 수 없습니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}	
					}
				}
			}
			PurchaseOrderAdmVo purchaseReadVo = new PurchaseOrderAdmVo();
			purchaseReadVo.setBoxNo(goodsBoxNoList.get(0).get("boxNo").toString());
			List<PurchaseOrderAdmVo> purchaseReadList = purchaseOrderAdmService.tracePurchaseOrderOutputHist2(purchaseReadVo);
			
			String poSeq			= "";
			String poGroup			= "";
			String goodsStatusCheck	= "";
					
			if("001".equals(goodsProductInfoAdmReadVo.getGoodsStatus())) { //포장상태
				jsonData.put("message", "포장상태인 제품은 검사반품을 보낼 수 없습니다!");
				jsonData.put("result", "fail");
				return jsonData;
			} else if("002".equals(goodsProductInfoAdmReadVo.getGoodsStatus())) { //입고상태
				String boxNo = goodsBoxNoList.get(0).get("boxNo").toString();
								
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();	//생산제품
				goodsProductInfoAdmVo.setBoxNo(boxNo);
				//해당boxNo로 생산제품을 읽어 와서 남아있는 잔여수량에다가 출하 취소수량 + & 상태값 입고(002)로
				goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
												
				//검사반품
				
				goodsProductInfoAdmVo.setGoodsStatus("001");
				goodsProductInfoAdmVo.setFaultyStatus("003");
				
				if(factoryCode.equals("003")) {
					goodsProductInfoAdmVo.setGoodsStatus("002");	//입고상태로(3공장은 포장 없음)
					goodsProductInfoAdmVo.setCompleteYn("N");		//미료 상태로 변경해줌.
				}
				
				//트레이 박스일 때에만 검사반품 테이블에 Ins
				if (boxNo.length() == 15) {
					//검사반품 이력 쌓아두면 됨
					ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
					shipInspectAdmVo.setTrayNo(boxNo);
					shipInspectAdmVo.setTrayNo1(boxNo);
					shipInspectAdmVo.setTrayNo2(boxNo);
					
					ShipInspectVo shipInspectReadVo = new ShipInspectVo();
					shipInspectReadVo.setReInspStatus("001");
					shipInspectReadVo.setTrayNo(boxNo.substring(0,boxNo.length()-2));
					List<ShipInspectVo> ReadList = shipInspectService.shipInspAdmRead(shipInspectReadVo);
					
					//트레이 번호로 작업지시 조회
					GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo = new GoodsProductInfoAdmVo();	//생산제품
					readTrayBoxByWorkOrdNo.setBoxNo(boxNo);
					readTrayBoxByWorkOrdNo = PdaService.readTrayBoxByWorkOrdNo(readTrayBoxByWorkOrdNo);
					
					//shipInspectService.shipInspAdmRead(shipInspectAdmVo);
					shipInspectAdmVo.setWorkOrdNo(readTrayBoxByWorkOrdNo.getWorkOrdNo());
					shipInspectAdmVo.setMatrlLotNo(readTrayBoxByWorkOrdNo.getMatrlLotNo());
					shipInspectAdmVo.setFilmLotNo(readTrayBoxByWorkOrdNo.getFilmLotNo());
					//shipInspectAdmVo.setInspStatus();
					shipInspectAdmVo.setReInspStatus("003");
					//shipInspectAdmVo.setDisStatus();
					//shipInspectAdmVo.setInspDate( date );
					shipInspectAdmVo.setFaultyCnt("0");
					//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
					//shipInspectAdmVo.setInspChargr(inspChargr);
					shipInspectAdmVo.setDayNightCd(ReadList.get(0).getDayNightCd());
					shipInspectAdmVo.setProductDate(ReadList.get(0).getProductDate());
					//shipInspectAdmVo.setFaultyGubun(faultyGubun);
					shipInspectAdmVo.setNextGubun("001");				//출하재검
					shipInspectAdmVo.setRegId( Utils.getUserId() );
					
					String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
					shipInspectAdmVo.setSeq(seq);
					
					shipInspectService.shipAdmCreate(shipInspectAdmVo);	
				}
				
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				goodsProductInfoAdmVo.setHistId(Utils.getUserId());
				//해당 생산제품 INFO UPDATE
				PdaService.updateBox(goodsProductInfoAdmVo);
				PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
				
				String stockPaymentLocationCd = null;
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
				}
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
				stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmVo.getGoodsCd(), goodsProductInfoAdmVo.getBoxNo(), "002", "I", stockPaymentLocationCd, Integer.parseInt(goodsProductInfoAdmVo.getPackCnt()), factoryCode);
				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//수불 +
				goodsStatusCheck = goodsProductInfoAdmVo.getGoodsStatus();
				
				jsonData.put("message", "정상적으로 처리 되었습니다.");
				jsonData.put("result", "ok");
				
			} else if("003".equals(goodsProductInfoAdmReadVo.getGoodsStatus()) || "004".equals(goodsProductInfoAdmReadVo.getGoodsStatus())) { //출하상태 이거나 출하대기 상태일때
				 poSeq			= purchaseReadList.get(0).getPoSeq().toString();    
				 poGroup			= purchaseReadList.get(0).getPoGroup().toString();  
				 goodsStatusCheck	= purchaseReadList.get(0).getPoGroup().toString();  
				 purchaseOrderAdmVo.setPoSeq(poSeq);
				 
				 int dtlCount	= Integer.parseInt(goodsBoxNoList.get(0).get("dtlCount").toString());	//현재 취소처리할 dtl의 변경 감지
					
					
					int cancelOutputSum = 0;	//출하취소 합계 수량
					for (Map<String, Object> m : goodsBoxNoList) {
						
						String boxNo = m.get("boxNo").toString();	//출하 취소 BoxNo
						int ouputCnt = Integer.parseInt(m.get("ouputCnt").toString());	//출하 수량
						String removeTrayGubun = m.get("removeTrayGubun").toString();	//cancelTray:출하취소 & returnReInspect:출하재검사
						
						//재고 제품 출하 취소처리
						if ( boxNo.toString().substring(0, 1).equals("S") ) {
							PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();	//재고제품
							preGoodsInventoryDtl.setBoxNo(boxNo);
							//해당boxNo로 재고제품을 읽어 와서 남아있는 잔여수량에다가 출하 취소수량 + & 상태값 입고(002)로
							preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
							preGoodsInventoryDtl.setRemainCnt( preGoodsInventoryDtl.getRemainCnt() + ouputCnt); //잔여수량 + 출하수량
							preGoodsInventoryDtl.setGoodsStatus("002");
							preGoodsInventoryDtl.setUpdId(Utils.getUserId());
							preGoodsInventoryDtl.setHistId(Utils.getUserId());
							//해당 재고제품 INFO UPDATE
							PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl);
							preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
							
							
							String stockPaymentLocationCd = null;
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
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
							stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryDtl.getGoodsCd(), preGoodsInventoryDtl.getBoxNo(), "003", "I", stockPaymentLocationCd, preGoodsInventoryDtl.getPackCnt(), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//수불 +
							
						//생산 제품 출하 취소처리
						} else {
							GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();	//생산제품
							goodsProductInfoAdmVo.setBoxNo(boxNo);
							//해당boxNo로 생산제품을 읽어 와서 남아있는 잔여수량에다가 출하 취소수량 + & 상태값 입고(002)로
							goodsProductInfoAdmVo = PdaService.readGoodsProductInfo2(goodsProductInfoAdmVo);
							goodsProductInfoAdmVo.setRemainCnt( goodsProductInfoAdmVo.getRemainCnt() + ouputCnt); //잔여수량 + 출하수량
							
							//출하취소
							if ("cancelTray".equals(removeTrayGubun)) {
								goodsProductInfoAdmVo.setGoodsStatus("002");
								
								if(factoryCode.equals("003")) {
									goodsProductInfoAdmVo.setGoodsStatus("004");	//출하대기 상태
								}
								
							//검사반품
							} else if ("returnReInspect".equals(removeTrayGubun)) {
								goodsProductInfoAdmVo.setGoodsStatus("001");
								goodsProductInfoAdmVo.setFaultyStatus("003");
								
								if(factoryCode.equals("003")) {
									goodsProductInfoAdmVo.setGoodsStatus("002");	//입고상태로(3공장은 포장 없음)
									goodsProductInfoAdmVo.setCompleteYn("N");		//미료 상태로 변경해줌.
								}
								
								//트레이 박스일 때에만 검사반품 테이블에 Ins
								if (boxNo.length() == 15) {
									//검사반품 이력 쌓아두면 됨
									ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
									shipInspectAdmVo.setTrayNo(boxNo);
									shipInspectAdmVo.setTrayNo1(boxNo);
									shipInspectAdmVo.setTrayNo2(boxNo);
									
									ShipInspectVo shipInspectReadVo = new ShipInspectVo();
									shipInspectReadVo.setReInspStatus("001");
									shipInspectReadVo.setTrayNo(boxNo.substring(0,boxNo.length()-2));
									List<ShipInspectVo> ReadList = shipInspectService.shipInspAdmRead(shipInspectReadVo);
									
									//트레이 번호로 작업지시 조회
									GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo = new GoodsProductInfoAdmVo();	//생산제품
									readTrayBoxByWorkOrdNo.setBoxNo(boxNo);
									readTrayBoxByWorkOrdNo = PdaService.readTrayBoxByWorkOrdNo(readTrayBoxByWorkOrdNo);
									
									//shipInspectService.shipInspAdmRead(shipInspectAdmVo);
									shipInspectAdmVo.setWorkOrdNo(readTrayBoxByWorkOrdNo.getWorkOrdNo());
									shipInspectAdmVo.setMatrlLotNo(readTrayBoxByWorkOrdNo.getMatrlLotNo());
									shipInspectAdmVo.setFilmLotNo(readTrayBoxByWorkOrdNo.getFilmLotNo());
									//shipInspectAdmVo.setInspStatus();
									shipInspectAdmVo.setReInspStatus("003");
									//shipInspectAdmVo.setDisStatus();
									//shipInspectAdmVo.setInspDate( date );
									shipInspectAdmVo.setFaultyCnt("0");
									//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
									//shipInspectAdmVo.setInspChargr(inspChargr);
									shipInspectAdmVo.setDayNightCd(ReadList.get(0).getDayNightCd());
									shipInspectAdmVo.setProductDate(ReadList.get(0).getProductDate());
									//shipInspectAdmVo.setFaultyGubun(faultyGubun);
									shipInspectAdmVo.setNextGubun("001");				//출하재검
									shipInspectAdmVo.setRegId( Utils.getUserId() );
									
									String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
									shipInspectAdmVo.setSeq(seq);
									
									shipInspectService.shipAdmCreate(shipInspectAdmVo);	
								}
							}
							goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
							goodsProductInfoAdmVo.setHistId(Utils.getUserId());
							//해당 생산제품 INFO UPDATE
							PdaService.updateBox(goodsProductInfoAdmVo);
							PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);			//생산제품 상태변경 기록
							
							String stockPaymentLocationCd = null;
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
							}
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
							stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmVo.getGoodsCd(), goodsProductInfoAdmVo.getBoxNo(), "002", "I", stockPaymentLocationCd, Integer.parseInt(goodsProductInfoAdmVo.getPackCnt()), factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//수불 +
							goodsStatusCheck = goodsProductInfoAdmVo.getGoodsStatus();
						}
						
						//출하대기 상태가 아닌경우 실행
						if (!goodsStatusCheck.equals("004")) {
							//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
							PurchaseOrderDtl deletePurchaseOrderDtl = new PurchaseOrderDtl();
							deletePurchaseOrderDtl.setPoSeq(poSeq);
							deletePurchaseOrderDtl.setPoGroup(Integer.toString( Integer.parseInt(poGroup) ));
							deletePurchaseOrderDtl.setBoxNo(boxNo);
							purchaseOrderAdmService.deletePurchaseOrderDtl(deletePurchaseOrderDtl);
						}
						
						cancelOutputSum += ouputCnt;
					}
					
					//출하대기 상태가 아닌경우 실행
					if (!goodsStatusCheck.equals("004")) {
						//DELETE 기록 남기기
						PurchaseOrderOutputHistVo createPurchaseCancelHist = new PurchaseOrderOutputHistVo();
						createPurchaseCancelHist.setPoSeq(poSeq);
						createPurchaseCancelHist.setPoGroup(poGroup);
						createPurchaseCancelHist.setCancelOutputSum(-cancelOutputSum);
						createPurchaseCancelHist.setRegId(Utils.getUserId());
						purchaseOrderAdmService.createPurchaseCancelHist(createPurchaseCancelHist);						

						createPurchaseCancelHist.setCancelOutputSum(+cancelOutputSum);
						
						if(factoryCode.equals("001") || factoryCode.equals("002")) {
							purchaseOrderAdmService.removeTrayByPallet(createPurchaseCancelHist);
						} else {
							purchaseOrderAdmService.removeTrayByPallet_F3(createPurchaseCancelHist);
						}
						
						//출하seq 0일경우 삭제
						//이후 PO_HIST도 출하취소 합계수량만큼 미출고수량은 +, 출고수량은 - 하여 Update
						PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
						purchaseOrderOutputHistVo.setPoSeq(poSeq);
						purchaseOrderOutputHistVo.setPoGroup(poGroup);
						purchaseOrderOutputHistVo.setCancelOutputSum(cancelOutputSum);
						purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
						//purchaseOrderAdmService.updatePurchaseOutputHist(purchaseOrderOutputHistVo);	->removeTrayByPallet 서비스에서 대신수행
						
						//PO_HIST 업데이트 후에 다시 조회하여 출하수량(outputCnt)이 0이면 모두 출하취소된 PO라 삭제
						purchaseOrderOutputHistVo = purchaseOrderAdmService.readPurchaseOrderOutputHist(purchaseOrderOutputHistVo);
						//해당PO 출하량이 0인 출하기록 삭제
						if (purchaseOrderOutputHistVo.getOutputQty() == 0) {
							purchaseOrderAdmService.deletePurchaseOrderOutputHist(purchaseOrderOutputHistVo);
						}
						
						purchaseOrderAdmVo.setPoSeq(poSeq);
						purchaseOrderAdmVo = purchaseOrderAdmService.read(purchaseOrderAdmVo);
						
						purchaseOrderAdmVo.setUpdId(Utils.getUserId());
						purchaseOrderAdmVo.setOutputQty(purchaseOrderAdmVo.getOutputQty() - cancelOutputSum); //출고수량 누적+
						purchaseOrderAdmVo.setRemainQty(purchaseOrderAdmVo.getRemainQty() + cancelOutputSum); //미출고수량 누적-
						purchaseOrderAdmService.updateQty(purchaseOrderAdmVo);
					}
					
					jsonData.put("message", "정상적으로 처리 되었습니다.");
					jsonData.put("result", "ok");
			}
			

			
			

			
		} catch (Exception e) {
			logger.info("제품출하 출하 취소 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//입출고관리 입고현황목록조회
	@RequestMapping(value = "/io/matrlInOutWhsDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 입고현황목록조회 = " + matrlInOutWhsAdmVo);
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listInWhsAll(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입입출고관리 입고현황목록조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리 반품목록조회
	@RequestMapping(value = "/io/matrlFaultyTypeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyTypeDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 반품목록조회 = " + matrlInOutWhsAdmVo);
		try {
			if(factoryCode.equals("003")) {
				matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
			}
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
	
	//입출고관리 입고자재상세조회
	@RequestMapping(value = "/io/matrlInOutWhsData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsData(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 입고자재상세조회");
		
		try {
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 입고자재상세 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//입출고관리 수정
	@RequestMapping(value = "/io/matrlInOutUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 수정");
		
		try {
			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmService.update(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 수정 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리 Location수정
	@RequestMapping(value = "/io/matrlInOutUpdateLocation", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutUpdateLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 Location 수정");
		
		try {
			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmService.updateLocation(matrlInOutWhsAdmVo);
			matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("입출고관리 Location 수정 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//입출고관리 FIFO 수정
	@RequestMapping(value = "/io/matrlInOutUpdateFifoCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutUpdateFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 FifoCheck 수정");
		
		try {
			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmService.updateFifoCheck(matrlInOutWhsAdmVo);
			matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("입출고관리 FifoCheck 수정 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//입출고관리 FIFO 선택 값만 수정
	@RequestMapping(value = "/qm/matrlFifoCheck_iosc0030", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlFifoCheck_iosc0030(String slashLotNo, String fifoCheck) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("slashLotNo ---------> " +slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				matrlInOutWhsAdmVo.setFifoCheck(fifoCheck);
				matrlInOutWhsAdmVo.setUpdDate(Utils.getUserId());
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmService.updateFifoCheck(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);	//자재이력등록
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 FIFO 선택 값만 수정(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//품질관리 수입검사 메인
	@RequestMapping(value = "/qmsc0020", method = RequestMethod.GET)
	public String matrlInOutWhsInspectMain(Locale locale, Model model) throws Exception {
		
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate );
		
		logger.info("품질관리 수입검사 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );
		//systemCommonCodeVo.setBaseGroupCd("004"); // Location
		//systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("locationCd", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("043"); // 수입검사 이상여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCheck", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("044"); // 라벨인쇄장수
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("printCountCheck", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("managementCd", systemCommonCodeList );

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setStartDate(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setEndDate(DateUtil.getToday("yyyymmdd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.inspectMatrlCodeList(matrlInOutWhsAdmVo);
		logger.info("qmsc0020 초기" + matrlCdInOutList);
		model.addAttribute("matrlCdList", matrlCdInOutList );

		return "qm/qmsc0020";
	}
	
	//품질관리 수입검사 메인
	@RequestMapping(value = "/qmsc3020", method = RequestMethod.GET)
	public String matrlInOutWhsInspectMainFac3(Locale locale, Model model) throws Exception {
		
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate );
		
		logger.info("품질관리 수입검사 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("026"); // 승인구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );
		//systemCommonCodeVo.setBaseGroupCd("004"); // Location
		//systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("locationCd", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("043"); // 수입검사 이상여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCheck", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("044"); // 라벨인쇄장수
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("printCountCheck", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("065"); // 수입검사 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("managementCd", systemCommonCodeList );

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setStartDate(DateUtil.getDay("yyyy-mm-dd", -6));
		matrlInOutWhsAdmVo.setEndDate(DateUtil.getToday("yyyymmdd"));
		List<MatrlInOutWhsAdmVo> matrlCdInOutList = matrlInOutWhsAdmService.inspectMatrlCodeList(matrlInOutWhsAdmVo);
		logger.info("qmsc3020 초기" + matrlCdInOutList);
		model.addAttribute("matrlCdList", matrlCdInOutList );

		return "qm/qmsc3020";
	}
	
	//품질관리 수입검사그룹목록조회
	@RequestMapping(value = "/qm/matrlInOutWhsInspectDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 수입검사그룹목록조회");
		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = new ArrayList<MatrlInOutWhsAdmVo>();
			if(factoryCode.equals("003")) {
				matrlInOutWhsAdmData = matrlInOutWhsAdmService.listInWhsInspectAllFac3(matrlInOutWhsAdmVo);
			} else {
				matrlInOutWhsAdmData = matrlInOutWhsAdmService.listInWhsInspectAll(matrlInOutWhsAdmVo);
			}		
			
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("품질관리 수입검사그룹목록조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 수입검사그룹상세목록조회
	@RequestMapping(value = "/qm/matrlInOutWhsInspectDataDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectDataDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 수입검사그룹 상세 목록 조회");
		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listInWhsInspectDtl(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("품질관리 수입검사그룹 상세 목록 조회 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}	

	//품질관리 수입검사관리 입고량 수정 
	@RequestMapping(value = "/qm/inspectQtyUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectQtyUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {	
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 입고량 수정   = " + matrlInOutWhsAdmVo);
		try {
			MatrlInOutWhsAdmVo matrlInOutWhsAdmData = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);

			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
			matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmData, "O", factoryCode);
			stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -

			//입고량Update 처리
			matrlInOutWhsAdmData.setInspectQty(matrlInOutWhsAdmVo.getInspectQty());
			matrlInOutWhsAdmData.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmData.setBarcodeNo(matrlInOutWhsAdmVo.getBarcodeNo());
			BigDecimal preInWhsQty = new BigDecimal(matrlInOutWhsAdmData.getPreInWhsQty());
			BigDecimal inspectQty = new BigDecimal(matrlInOutWhsAdmData.getInspectQty());
			BigDecimal diffQty = preInWhsQty.subtract(inspectQty);
			matrlInOutWhsAdmData.setDiffQty(String.valueOf(diffQty));
			matrlInOutWhsAdmService.updateinspectQty(matrlInOutWhsAdmData);
			matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmData);		//자재이력등록
			
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
			matrlInOutWhsAdmData.setRemainQty(matrlInOutWhsAdmVo.getRemainQty()); 
			matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmData, factoryCode);
			stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 입고현황 잔량 수정 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	//품질관리-수입검사관리
	@RequestMapping(value = "/qm/matrlInOutWhsInspectUpdateDtl", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 수입검사상세수정(승인/승인취소/불량/반품) = "+ matrlInOutWhsAdmList);
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo	= new MatrlInOutWhsAdmVo();
		MatrlInOutWhsAdmVo statusCdCheckVo		= new MatrlInOutWhsAdmVo();
		MatrlInOutWhsAdmVo inOutWhsRemainQty	= new MatrlInOutWhsAdmVo();
		MatrlCodeAdmVo matrlCodeAdmVo			= new MatrlCodeAdmVo();
		matrlCodeAdmVo.setMatrlCd(matrlInOutWhsAdmList.get(0).get("matrlCd").toString());
		matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);
		//String thickness = matrlCodeAdmVo.getThickness();
		//String filmCode="";
		//String barcode = "";
		try {
			
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				
				statusCdCheckVo = new MatrlInOutWhsAdmVo();
				statusCdCheckVo.setLotNo( m.get("lotNo").toString() );
				statusCdCheckVo = matrlInOutWhsAdmService.read(statusCdCheckVo);
				
				logger.info("statusCdCheckVo.getStatusCd() ----------------> "+statusCdCheckVo.getStatusCd());
				if( statusCdCheckVo.getStatusCd() != null && !statusCdCheckVo.getStatusCd().equals("P") ) {
				
				
					logger.info("matrlInOutWhsAdmVo : " + m);
					matrlInOutWhsAdmVo.setInWhsDesc(m.get("inWhsDesc").toString());
					matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
					matrlInOutWhsAdmVo.setPreInWhsQty(m.get("preInWhsQty").toString());			
					matrlInOutWhsAdmVo.setInspectQty(m.get("inspectQty").toString());
					matrlInOutWhsAdmVo.setRemainQty(m.get("remainQty").toString());
					matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
					matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
					matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
					matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
					matrlInOutWhsAdmVo.setInspctDate(m.get("inspctDate").toString());
					matrlInOutWhsAdmVo.setInWhsDate(m.get("inWhsDate").toString());
					matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
					
					if("001".contentEquals(matrlInOutWhsAdmVo.getApprovalCd())) {
						matrlInOutWhsAdmVo.setStatusCd("A");
					} else {
						matrlInOutWhsAdmVo.setStatusCd("S");
					}
					
					matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);
					
					//1, 2공장 수입검사 승인 시 잔량 Update
					if(factoryCode.equals("001") || factoryCode.equals("002")) {
						if(matrlInOutWhsAdmVo.getApprovalCd().equals("001")) {
							inOutWhsRemainQty = matrlInOutWhsAdmService.barcodeRead(matrlInOutWhsAdmVo);
							if(inOutWhsRemainQty == null) {
								matrlInOutWhsAdmVo.setRemainQty(m.get("preInWhsQty").toString());	
								matrlInOutWhsAdmService.updateRemainQty(matrlInOutWhsAdmVo);	//잔량 변경
							}else {
								if(inOutWhsRemainQty.getRemainQty() == null) {
									matrlInOutWhsAdmVo.setRemainQty(m.get("preInWhsQty").toString());
									matrlInOutWhsAdmService.updateRemainQty(matrlInOutWhsAdmVo);	//잔량 변경
								}
							}
						}
					}
					
					matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
					StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
					matrlInOutWhsAdmVo.setMatrlCd(matrlCodeAdmVo.getMatrlCd());
					matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
					stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
					matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				}
				
			}
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("품질관리 수입검사상세 수정(승인/승인취소/불량) 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	}
	
	
	//입출고관리-자재 부적합현황 미승인&반품&실반품&폐기 로 상태변경
	@RequestMapping(value = "/qm/matrlInOutWhsInspectUpdateDtl_iosc0080", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl_iosc0080(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 부적합 상태 변경 = "+ matrlInOutWhsAdmList);
		try {
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("matrlInOutWhsAdmVo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcode").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				matrlInOutWhsAdmVo.setStatusCd("I");
				matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
				matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				//matrlInOutWhsAdmVo.setFaultyStatus(m.get("faultyStatus").toString());
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());						
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);	//자재상태변경
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
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
	
	//입출고관리-자재 부적합현황 미승인&반품&실반품&폐기 로 상태변경
	@RequestMapping(value = "/qm/matrlInOutWhsInspectUpdateDtl_iosc0080_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl_iosc0080_F3(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 부적합 상태 변경 = "+ matrlInOutWhsAdmList);
		try {
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("matrlInOutWhsAdmVo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcode").toString());
				matrlInOutWhsAdmVo.setLotNo(m.get("barcode").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
				StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				String readApprovalCd = matrlInOutWhsAdmVo.getApprovalCd();
				String updateApprovalCd = m.get("approvalCd").toString();
				
				//현재 자재상태가 실제반품&자체폐기가 아니면 - 처리
				if (!("006".equals(readApprovalCd) || "007".equals(readApprovalCd) || "011".equals(updateApprovalCd))) {
					matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
					stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
				}
				
				//이후 자재상태Update
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				matrlInOutWhsAdmVo.setStatusCd("I");
				matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
				matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				
				if(factoryCode.equals("003") && m.get("filmType") != null) {
					matrlInOutWhsAdmVo.setFilmType(m.get("filmType").toString());
				}
				
				matrlInOutWhsAdmVo.setFautlyByProductionTeam(m.get("fautlyByProductionTeam").toString());
				//matrlInOutWhsAdmVo.setFaultyStatus(m.get("faultyStatus").toString());
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());						
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);	//자재상태변경
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				
				
				//업데이트 할 자재상태가 실제반품&자체폐기가 아닐경우 + 처리
				if ( !("006".equals(updateApprovalCd) || "007".equals(updateApprovalCd) || "011".equals(updateApprovalCd)) ) {
					matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
					stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				}
				
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
	
	//MTP 1동 작업지시선택 - 자재불량등록(실사량 기능 추가)
	@RequestMapping(value = "/qm/workOrdMatrlFaultyOut", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdMatrlFaultyOut(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MTP 1동 작업지시선택 - 자재불량등록(실사량 기능 추가) - "+ matrlInOutWhsAdmList);
		try {
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("matrlInOutWhsAdmVo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcode").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				matrlInOutWhsAdmVo.setStatusCd("I");
				matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
				matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				
				matrlInOutWhsAdmVo.setRemainQty(m.get("faultyInspectQty").toString());
				
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());						
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);	//자재상태변경
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				//StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
				StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				//matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
				//matrlStockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
				matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
				matrlStockPaymentAdmVoPlus.setSpQty(Float.parseFloat(m.get("faultyInspectQty").toString()));
				stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
			}			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("MTP 1동 작업지시선택 - 자재불량등록(실사량 기능 추가) 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//입출고관리-자재 부적합현황 불량상태 취소 상태변경
	@RequestMapping(value = "/qm/matrlInOutWhsInspectUpdateDtl_iosc0080_faultyCancel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl_iosc0080_faultyCancel(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 부적합 상태 변경 = "+ matrlInOutWhsAdmList);
		try {
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("matrlInOutWhsAdmVo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();	//선언 안하고 전역변수로 선언시 LotNo로 먼저 찾아짐(쿼리문)
				matrlInOutWhsAdmVo.setBarcodeNo(m.get("barcode").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
				matrlInOutWhsAdmVo.setStatusCd("P");
				matrlInOutWhsAdmVo.setFrrrdDate(m.get("frrrdDate").toString());
				matrlInOutWhsAdmVo.setFrrrdType(m.get("frrrdType").toString());
				matrlInOutWhsAdmVo.setFrrrdDesc(m.get("frrrdDesc").toString());
				matrlInOutWhsAdmVo.setFautlyByProductionTeam(m.get("fautlyByProductionTeam").toString());
				//matrlInOutWhsAdmVo.setFaultyStatus(m.get("faultyStatus").toString());
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());						
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);	//자재상태변경
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
				//StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
				stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
				//matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
				//matrlStockPaymentAdmVoPlus.setSpQty(Float.parseFloat(m.get("faultyInspectQty").toString()));
				//stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
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
	
	
	//자재 바코드 인쇄
	@RequestMapping(value = "/qm/matrlPrint_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPrint_F3(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사관리 자재 바코드 인쇄 = "+ matrlInOutWhsAdmList);
		
		//MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
		//matrlCodeAdmVo.setMatrlCd(matrlInOutWhsAdmList.get(0).get("matrlCd").toString());
		
		try {
			boolean delayTime = true;	//첫프린터인쇄 딜레이 true면 2초, false면 1초 대기
		    List<String[]> printList = new ArrayList<>(); // 데이터 리스트
			
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("검색할 LotNo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				logger.info("검색 값 : " + matrlInOutWhsAdmVo);
				//String thickness = matrlInOutWhsAdmVo.getThickness();
				//String filmCode = matrlInOutWhsAdmVo.getMatrlCd();
				String matrlInitial = matrlInOutWhsAdmVo.getMatrlInitial();
				String matrlNm = matrlInOutWhsAdmVo.getMatrlNm();
				String barcode = matrlInOutWhsAdmVo.getBarcodeNo();
				
				//필름일 경우 Ea로 표시
				String inspectQty = null;
				if ( matrlInOutWhsAdmVo.getBaseCdAbbr().equals("F") ) {
					inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Ea";
				} else {
					inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Kg";
				}
				//String filmCode = m.get("matrlCd").toString();
				//String barcode = m.get("barcode").toString();
				
				int countPrint = Integer.parseInt(m.get("countPrint").toString());
				logger.info("인쇄할 프린터 장 수 : " + countPrint);
				
				//자재코드의 etc1이 P2이면 IP2로 그외에는 IP1로 인쇄
				for(int i=1; i<=countPrint; i++) {
					String[] dataArr = new String[15];
				    
				    dataArr[0] = matrlInitial; // 제품코드
				    dataArr[1] = m.get("lotNo").toString(); // lotNo
				    dataArr[2] = barcode; // 바코드
				    dataArr[3] = matrlNm; // 제품사양
				    dataArr[4] = inspectQty; // 중량
				    dataArr[5] = matrlInOutWhsAdmVo.getEtc1(); // 체크1(출력)
				    // dataArr[6] = delayTime; // 딜레이 시간
					
				    printList.add(dataArr);
				    
					delayTime = false;
				}
			}
			//jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("printList", printList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("자재 바코드 인쇄 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
				
		return jsonData;
	}
	
	//자재 바코드 인쇄
	@RequestMapping(value = "/qm/matrlPrint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPrint(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사관리 자재 바코드 인쇄 = "+ matrlInOutWhsAdmList);
		
		//MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
		//matrlCodeAdmVo.setMatrlCd(matrlInOutWhsAdmList.get(0).get("matrlCd").toString());
		
		try {
			boolean delayTime = true;	//첫프린터인쇄 딜레이 true면 2초, false면 1초 대기
			
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("검색할 LotNo : " + m);
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				logger.info("검색 값 : " + matrlInOutWhsAdmVo);
				//String thickness = matrlInOutWhsAdmVo.getThickness();
				//String filmCode = matrlInOutWhsAdmVo.getMatrlCd();
				String matrlInitial = matrlInOutWhsAdmVo.getMatrlInitial();
				String matrlNm = matrlInOutWhsAdmVo.getMatrlNm();
				String barcode = matrlInOutWhsAdmVo.getBarcodeNo();
				
				//필름일 경우 Ea로 표시
				String inspectQty = null;
				if ( matrlInOutWhsAdmVo.getBaseCdAbbr().equals("F") ) {
					inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Ea";
				} else {
					inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Kg";
				}
				//String filmCode = m.get("matrlCd").toString();
				//String barcode = m.get("barcode").toString();
				
				int countPrint = Integer.parseInt(m.get("countPrint").toString());
				logger.info("인쇄할 프린터 장 수 : " + countPrint);
				
				//자재코드의 etc1이 P2이면 IP2로 그외에는 IP1로 인쇄
				for(int i=1; i<=countPrint; i++) {
					
					if( matrlInOutWhsAdmVo.getEtc1().equals("P2") ) {
						logger.info("수입검사관리 자재 IP2 인쇄 - " + IP2);
						Film.filmPrint(IP2, PORT, matrlInitial, m.get("lotNo").toString(), barcode, matrlNm, inspectQty, delayTime);
					} else {
						logger.info("수입검사관리 자재 IP1 인쇄 - " + IP1);
						Film.filmPrint(IP1, PORT, matrlInitial, m.get("lotNo").toString(), barcode, matrlNm, inspectQty, delayTime);
					}
					delayTime = false;
				}
			}
			//jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("자재 바코드 인쇄 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
				
		return jsonData;
	}
	
	//자재 바코드 인쇄 - 입고현황(iosc0030)
	@RequestMapping(value = "/qm/matrlPrint_iosc0030_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPrint_iosc0030_F3(String slashLotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			boolean delayTime = true;	//첫프린터인쇄 딜레이 true면 2초, false면 1초 대기
		    List<String[]> printList = new ArrayList<>(); // 데이터 리스트
			logger.info(slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				String matrlInitial = matrlInOutWhsAdmVo.getMatrlInitial();
				String matrlNm = matrlInOutWhsAdmVo.getMatrlNm();
				String barcode = matrlInOutWhsAdmVo.getBarcodeNo();
				//필름일 경우 Ea로 표시
				String inspectQty = null;
				if ( matrlInOutWhsAdmVo.getBaseCdAbbr().equals("F") ) {
					if(factoryCode.equals("003")) {
						inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Ea";						
					} else {
						inspectQty = matrlInOutWhsAdmVo.getRemainQty() + " Ea";	
					}
				} else {
					
					if(factoryCode.equals("003")) {
						inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Kg";						
					} else {
						inspectQty = matrlInOutWhsAdmVo.getRemainQty() + " Kg";	
					}
				}
				String[] dataArr = new String[15];
			    
			    dataArr[0] = matrlInitial; // 제품코드
			    dataArr[1] = arrayLotNo[i]; // lotNo
			    dataArr[2] = barcode; // 바코드
			    dataArr[3] = matrlNm; // 제품사양
			    dataArr[4] = inspectQty; // 중량
			    dataArr[5] = matrlInOutWhsAdmVo.getEtc1(); // 체크1(출력)
			    // dataArr[6] = delayTime; // 딜레이 시간
				
			    printList.add(dataArr);
			    
				delayTime = false;
			}
			jsonData.put("result", "ok");
			jsonData.put("printList", printList);
		} catch (Exception e) {
			logger.info("입고현황 바코드 인쇄 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	
	//자재 바코드 인쇄 - 입고현황(iosc0030)
	@RequestMapping(value = "/qm/matrlPrint_iosc0030", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPrint_iosc0030(String slashLotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			boolean delayTime = true;	//첫프린터인쇄 딜레이 true면 2초, false면 1초 대기
			logger.info(slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				String matrlInitial = matrlInOutWhsAdmVo.getMatrlInitial();
				String matrlNm = matrlInOutWhsAdmVo.getMatrlNm();
				String barcode = matrlInOutWhsAdmVo.getBarcodeNo();
				
				//필름일 경우 Ea로 표시
				String inspectQty = null;
				if ( matrlInOutWhsAdmVo.getBaseCdAbbr().equals("F") ) {
					//inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Ea";
					inspectQty = matrlInOutWhsAdmVo.getRemainQty() + " Ea";
				} else {
					//inspectQty = matrlInOutWhsAdmVo.getInspectQty() + " Kg";
					inspectQty = matrlInOutWhsAdmVo.getRemainQty() + " kg";
				}
				
				if( matrlInOutWhsAdmVo.getEtc1().equals("P2") ) {
					logger.info("수입검사관리 자재 IP2 인쇄");
					Film.filmPrint(IP2, PORT, matrlInitial, arrayLotNo[i], barcode, matrlNm, inspectQty, delayTime);
				} else {
					logger.info("수입검사관리 자재 IP1 인쇄");
					Film.filmPrint(IP1, PORT, matrlInitial, arrayLotNo[i], barcode, matrlNm, inspectQty, delayTime);
				}
				delayTime = false;
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입고현황 바코드 인쇄 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}

	//자재 불량 처리 - 입고현황(iosc0030)
	@RequestMapping(value = "/qm/matrlFaulty_iosc0030", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlFaulty_iosc0030(String slashLotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			boolean delayTime = true;	//첫프린터인쇄 딜레이 true면 2초, false면 1초 대기
			logger.info(slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				matrlInOutWhsAdmVo.setApprovalCd("003");
				//matrlInOutWhsAdmVo.setStatusCd("I");	//수입검사 대상
				
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);
				
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입고현황 불량처리 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//자재 반품 처리 - 입고현황(iosc0030)
	@RequestMapping(value = "/qm/matrlReturn_iosc0030", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlReturn_iosc0030(String slashLotNo, String inWhsDesc) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info(slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				matrlInOutWhsAdmVo.setApprovalCd("005");
				//matrlInOutWhsAdmVo.setStatusCd("I");		//수입검사 대상
				matrlInOutWhsAdmVo.setInWhsDesc(inWhsDesc);
				
				matrlInOutWhsAdmService.updateApprovalStatus(matrlInOutWhsAdmVo);
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입고현황 불량처리 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//자재 창고이동 처리 - 입고현황(iosc0030)
	@RequestMapping(value = "/qm/matrlLocation_iosc0030", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlLocation_iosc0030(String menuAuth, String slashLotNo, String locationCd) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info(slashLotNo);
			String[] arrayLotNo = slashLotNo.split("/");
			//첫번째 칸은 비어있음(첫 LotNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayLotNo.length; i++ ) {
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(arrayLotNo[i]);
				matrlInOutWhsAdmVo.setLocationCd(locationCd);
				matrlInOutWhsAdmVo.setUpdDate(Utils.getUserId());
				logger.info(arrayLotNo[i]);
				matrlInOutWhsAdmService.updateLocation(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입고현황 창고이동 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//수입검사 모달
	@RequestMapping(value = "/qm/inspectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectList(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사 모달 ");
		try {
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo2 = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo4 = new InspectInfoAdmVo();
			
			MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
			matrlCodeAdmVo.setMatrlCd(inspectInfoAdmVo.getMatrlCd());
			
			matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);			//해당 자재 상세조회
			inspectInfoAdmVo1 = inspectInfoAdmService.read(inspectInfoAdmVo);	//해당 자재의 수입검사대상이 자재, 원자재, 가공원자재 정보 조회
			inspectInfoAdmVo2 = inspectInfoAdmService.read2(inspectInfoAdmVo);	//해당 inWhsGroupSeq 로 수입검사 되어있는지 조회
			List<InspectInfoAdmVo> list = inspectInfoAdmService.read3(inspectInfoAdmVo); // 수입검사 롯트별 상단조회
			inspectInfoAdmVo4 = inspectInfoAdmService.read4(inspectInfoAdmVo); // 수입검사 롯트별 하단조회
		
		
			if(list.size() == 0) {
				jsonData.put("result", "fail");
				jsonData.put("matrlData",matrlCodeAdmVo);
				jsonData.put("data",Utils.getInspect(inspectInfoAdmVo1));
				jsonData.put("data2",inspectInfoAdmVo);
				jsonData.put("data3",list);
			} else {		
				jsonData.put("result", "ok");
				jsonData.put("matrlData",matrlCodeAdmVo);
				jsonData.put("data", Utils.getInspect(inspectInfoAdmVo1));
				if(inspectInfoAdmVo4 == null) {
					jsonData.put("data2", inspectInfoAdmVo4);	
				} else {
					jsonData.put("data2", Utils.getInspect(inspectInfoAdmVo4));	
				}				
				jsonData.put("data3",list);				
			}		
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}		
		
		return jsonData;
	}
	
	//수입검사 모달(SLD)
	@RequestMapping(value = "/qm/inspectList2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectList2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수입검사 모달 ");
		try {
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo4 = new InspectInfoAdmVo();
			
			Boolean checkInspect = true;
			
			MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
			matrlCodeAdmVo.setMatrlCd(inspectInfoAdmVo.getMatrlCd());
			
			matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);			//해당 자재 상세조회
			List<InspectInfoAdmVo> list = inspectInfoAdmService.read3New(inspectInfoAdmVo); // 수입검사 롯트별 상단조회
			inspectInfoAdmVo4 = inspectInfoAdmService.read4New(inspectInfoAdmVo); // 수입검사 롯트별 하단조회
		

			if(inspectInfoAdmVo4==null&&list.size()==0) { // 검사 등록안됨
				inspectInfoAdmVo1 = inspectInfoAdmService.dtlRead(inspectInfoAdmVo);
				checkInspect = true;
			} else { //검사 등록됨
				if(list.get(0).getMatrlCd().equals("")) { //기존데이터
					if(inspectInfoAdmVo.getMatrlGubunCd().equals("004")) {
						InspectInfoAdmVo tempVo = inspectInfoAdmVo;
						tempVo.setMatrlGubunCd("001");
						inspectInfoAdmVo1 = inspectInfoAdmService.dtlReadWithoutMatrlCd(tempVo);
					} else {
						inspectInfoAdmVo1 = inspectInfoAdmService.dtlReadWithoutMatrlCd(inspectInfoAdmVo);
					}
					checkInspect = false;
				} else {
					inspectInfoAdmVo1 = inspectInfoAdmService.dtlRead(inspectInfoAdmVo);
					checkInspect = true;
				}
			}
			
			if(checkInspect) { //신규데이터
				if(inspectInfoAdmVo1!=null) {
					if(list.size() == 0) {
						jsonData.put("result", "fail");
						jsonData.put("matrlData",matrlCodeAdmVo);
						jsonData.put("data",Utils.getInspect(inspectInfoAdmVo1));
						jsonData.put("data2",inspectInfoAdmVo);
						jsonData.put("data3",list);
						jsonData.put("from", "new");
					} else {		
						jsonData.put("result", "ok");
						jsonData.put("matrlData",matrlCodeAdmVo);
						jsonData.put("data", Utils.getInspect(inspectInfoAdmVo1));
						if(inspectInfoAdmVo4 == null) {
							jsonData.put("data2", inspectInfoAdmVo4);	
						} else {
							jsonData.put("data2", Utils.getInspect(inspectInfoAdmVo4));	
						}				
						jsonData.put("data3",list);		
						jsonData.put("from", "new");
					}	
				} else {
					jsonData.put("result", "empty");
				}
			} else { //기존데이터
				if(list.size() == 0) {
					jsonData.put("result", "fail");
					jsonData.put("matrlData",matrlCodeAdmVo);
					jsonData.put("data",Utils.getInspect(inspectInfoAdmVo1));
					jsonData.put("data2",inspectInfoAdmVo);
					jsonData.put("data3",list);
					jsonData.put("from", "origin");
				} else {		
					jsonData.put("result", "ok");
					jsonData.put("matrlData",matrlCodeAdmVo);
					jsonData.put("data", Utils.getInspect(inspectInfoAdmVo1));
					if(inspectInfoAdmVo4 == null) {
						jsonData.put("data2", inspectInfoAdmVo4);	
					} else {
						jsonData.put("data2", Utils.getInspect(inspectInfoAdmVo4));	
					}				
					jsonData.put("data3",list);			
					jsonData.put("from", "origin");
				}	
			}
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}		
		
		return jsonData;
	}
	
	//수입검사 저장 상단
	@RequestMapping(value = "/qm/inspectCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectCreate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 저장 ");
			InspectInfoAdmVo inspectInfoAdmVo =new InspectInfoAdmVo();
			inspectInfoAdmVo.setInWhsGroupSeq(inspectList.get(0).get("inWhsGroupSeq").toString());
			inspectInfoAdmVo.setMatrlGubunCd(inspectList.get(0).get("matrlGubunCd").toString());
			inspectInfoAdmVo.setLotNo(inspectList.get(0).get("lotNo").toString());
			
		
			int idx = inspectInfoAdmService.selectIdx(inspectInfoAdmVo).getIdx();
			for(Map<String, Object> m : inspectList) {
				InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setIdx(idx);
				inspectInfoAdmVo1.setInspectDate(m.get("inspectDate").toString());
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				inspectInfoAdmVo1.setManagementCd(m.get("managementCd").toString());
				inspectInfoAdmVo1.setResultCd(m.get("resultCd").toString());
				inspectInfoAdmVo1.setInspectEtc(m.get("inspectEtc").toString());
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmService.create3(inspectInfoAdmVo1);				
				idx++;
				
			}		
		
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}		
	
	//수입검사 저장 상단
	@RequestMapping(value = "/qm/inspectCreateNew", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectCreateSld(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 저장 ");
			InspectInfoAdmVo inspectInfoAdmVo =new InspectInfoAdmVo();
			inspectInfoAdmVo.setInWhsGroupSeq(inspectList.get(0).get("inWhsGroupSeq").toString());
			inspectInfoAdmVo.setMatrlGubunCd(inspectList.get(0).get("matrlGubunCd").toString());
			inspectInfoAdmVo.setLotNo(inspectList.get(0).get("lotNo").toString());
			
		
			int idx = inspectInfoAdmService.selectIdx(inspectInfoAdmVo).getIdx();
			for(Map<String, Object> m : inspectList) {
				InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setIdx(idx);
				inspectInfoAdmVo1.setInspectDate(m.get("inspectDate").toString());
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				inspectInfoAdmVo1.setManagementCd(m.get("managementCd").toString());
				inspectInfoAdmVo1.setResultCd(m.get("resultCd").toString());
				inspectInfoAdmVo1.setInspectEtc(m.get("inspectEtc").toString());
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmVo1.setMatrlCd(m.get("matrlCd").toString());
				inspectInfoAdmService.create3New(inspectInfoAdmVo1);				
				idx++;
				
			}		
		
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//수입검사 저장2 하단
	@RequestMapping(value = "/qm/inspectCreate2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectCreate2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 저장2 ");
			InspectInfoAdmVo inspectInfoAdmVo = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			for(Map<String, Object> m : inspectList) {
				inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				//inspectInfoAdmVo1.setInspectItem1(m.get("inspectItem1").toString());
				//inspectInfoAdmVo1.setInspectItem2(m.get("inspectItem2").toString());
				//inspectInfoAdmVo1.setInspectItem3(m.get("inspectItem3").toString());
				//inspectInfoAdmVo1.setInspectItem4(m.get("inspectItem4").toString());
				//inspectInfoAdmVo1.setInspectItem5(m.get("inspectItem5").toString());
				//inspectInfoAdmVo1.setInspectItem6(m.get("inspectItem6").toString());
				//inspectInfoAdmVo1.setInspectItem7(m.get("inspectItem7").toString());
				//inspectInfoAdmVo1.setInspectItem8(m.get("inspectItem8").toString());
				//inspectInfoAdmVo1.setInspectItem9(m.get("inspectItem9").toString());
				//inspectInfoAdmVo1.setInspectItem10(m.get("inspectItem10").toString());
				//inspectInfoAdmVo1.setInspectItem11(m.get("inspectItem11").toString());
				//inspectInfoAdmVo1.setInspectItem12(m.get("inspectItem12").toString());
				inspectInfoAdmVo1.setInspectItem13(m.get("inspectItem13").toString());
				inspectInfoAdmVo1.setInspectItem14(m.get("inspectItem14").toString());
				inspectInfoAdmVo1.setInspectItem15(m.get("inspectItem15").toString());
				inspectInfoAdmVo1.setInspectItem16(m.get("inspectItem16").toString());
				inspectInfoAdmVo1.setInspectItem17(m.get("inspectItem17").toString());
				inspectInfoAdmVo1.setInspectItem18(m.get("inspectItem18").toString());
				inspectInfoAdmVo1.setInspectItem19(m.get("inspectItem19").toString());
				inspectInfoAdmVo1.setInspectItem20(m.get("inspectItem20").toString());
				inspectInfoAdmVo1.setInspectItem21(m.get("inspectItem21").toString());

		
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmService.create4(inspectInfoAdmVo1);							
			}			
		/*	inspectInfoAdmVo = inspectInfoAdmService.read2(inspectInfoAdmVo1);
			if(inspectInfoAdmVo == null) {
				inspectInfoAdmService.create2(inspectInfoAdmVo1);
			} else {
				inspectInfoAdmVo.setUpdId(Utils.getUserId());
				inspectInfoAdmService.update2(inspectInfoAdmVo1);			
			}*/
			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//수입검사 저장2 하단
	@RequestMapping(value = "/qm/inspectCreateNew2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectCreate2Sld(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 저장2 ");
			InspectInfoAdmVo inspectInfoAdmVo = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			for(Map<String, Object> m : inspectList) {
				inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				//inspectInfoAdmVo1.setInspectItem1(m.get("inspectItem1").toString());
				//inspectInfoAdmVo1.setInspectItem2(m.get("inspectItem2").toString());
				//inspectInfoAdmVo1.setInspectItem3(m.get("inspectItem3").toString());
				//inspectInfoAdmVo1.setInspectItem4(m.get("inspectItem4").toString());
				//inspectInfoAdmVo1.setInspectItem5(m.get("inspectItem5").toString());
				//inspectInfoAdmVo1.setInspectItem6(m.get("inspectItem6").toString());
				//inspectInfoAdmVo1.setInspectItem7(m.get("inspectItem7").toString());
				//inspectInfoAdmVo1.setInspectItem8(m.get("inspectItem8").toString());
				//inspectInfoAdmVo1.setInspectItem9(m.get("inspectItem9").toString());
				//inspectInfoAdmVo1.setInspectItem10(m.get("inspectItem10").toString());
				//inspectInfoAdmVo1.setInspectItem11(m.get("inspectItem11").toString());
				//inspectInfoAdmVo1.setInspectItem12(m.get("inspectItem12").toString());
				inspectInfoAdmVo1.setInspectItem13(m.get("inspectItem13").toString());
				inspectInfoAdmVo1.setInspectItem14(m.get("inspectItem14").toString());
				inspectInfoAdmVo1.setInspectItem15(m.get("inspectItem15").toString());
				inspectInfoAdmVo1.setInspectItem16(m.get("inspectItem16").toString());
				inspectInfoAdmVo1.setInspectItem17(m.get("inspectItem17").toString());
				inspectInfoAdmVo1.setInspectItem18(m.get("inspectItem18").toString());
				inspectInfoAdmVo1.setInspectItem19(m.get("inspectItem19").toString());
				inspectInfoAdmVo1.setInspectItem20(m.get("inspectItem20").toString());
				inspectInfoAdmVo1.setInspectItem21(m.get("inspectItem21").toString());
				inspectInfoAdmVo1.setMatrlCd(m.get("matrlCd").toString());

		
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmService.create4New(inspectInfoAdmVo1);							
			}			
		/*	inspectInfoAdmVo = inspectInfoAdmService.read2(inspectInfoAdmVo1);
			if(inspectInfoAdmVo == null) {
				inspectInfoAdmService.create2(inspectInfoAdmVo1);
			} else {
				inspectInfoAdmVo.setUpdId(Utils.getUserId());
				inspectInfoAdmService.update2(inspectInfoAdmVo1);			
			}*/
			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}
	
	//수입검사 수정 상단
	@RequestMapping(value = "/qm/inspectUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectUpdate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 수정 ");
			InspectInfoAdmVo inspectInfoAdmVo =new InspectInfoAdmVo();
			inspectInfoAdmVo.setInWhsGroupSeq(inspectList.get(0).get("inWhsGroupSeq").toString());
			inspectInfoAdmVo.setMatrlGubunCd(inspectList.get(0).get("matrlGubunCd").toString());
			inspectInfoAdmVo.setLotNo(inspectList.get(0).get("lotNo").toString());
			
			int idx = inspectInfoAdmService.selectIdx(inspectInfoAdmVo).getIdx() - (inspectList.size()-1);	
			for(Map<String, Object> m : inspectList) {
				InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setIdx(idx);
				inspectInfoAdmVo1.setInspectDate(m.get("inspectDate").toString());
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				inspectInfoAdmVo1.setManagementCd(m.get("managementCd").toString());
				inspectInfoAdmVo1.setResultCd(m.get("resultCd").toString());
				inspectInfoAdmVo1.setInspectEtc(m.get("inspectEtc").toString());
				inspectInfoAdmVo1.setUpdId(Utils.getUserId());
				inspectInfoAdmService.update3(inspectInfoAdmVo1);				
				idx++;
				
			}		
		
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}		
	
	//수입검사 수정2 하단
	@RequestMapping(value = "/qm/inspectUpdate2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectUpdate2(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 수정2 ");
			InspectInfoAdmVo inspectInfoAdmVo = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			for(Map<String, Object> m : inspectList) {
				inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				//inspectInfoAdmVo1.setInspectItem1(m.get("inspectItem1").toString());
				//inspectInfoAdmVo1.setInspectItem2(m.get("inspectItem2").toString());
				//inspectInfoAdmVo1.setInspectItem3(m.get("inspectItem3").toString());
				//inspectInfoAdmVo1.setInspectItem4(m.get("inspectItem4").toString());
				//inspectInfoAdmVo1.setInspectItem5(m.get("inspectItem5").toString());
				//inspectInfoAdmVo1.setInspectItem6(m.get("inspectItem6").toString());
				//inspectInfoAdmVo1.setInspectItem7(m.get("inspectItem7").toString());
				//inspectInfoAdmVo1.setInspectItem8(m.get("inspectItem8").toString());
				//inspectInfoAdmVo1.setInspectItem9(m.get("inspectItem9").toString());
				//inspectInfoAdmVo1.setInspectItem10(m.get("inspectItem10").toString());
				//inspectInfoAdmVo1.setInspectItem11(m.get("inspectItem11").toString());
				//inspectInfoAdmVo1.setInspectItem12(m.get("inspectItem12").toString());
				inspectInfoAdmVo1.setInspectItem13(m.get("inspectItem13").toString());
				inspectInfoAdmVo1.setInspectItem14(m.get("inspectItem14").toString());
				inspectInfoAdmVo1.setInspectItem15(m.get("inspectItem15").toString());
				inspectInfoAdmVo1.setInspectItem16(m.get("inspectItem16").toString());
				inspectInfoAdmVo1.setInspectItem17(m.get("inspectItem17").toString());
				inspectInfoAdmVo1.setInspectItem18(m.get("inspectItem18").toString());
				inspectInfoAdmVo1.setInspectItem19(m.get("inspectItem19").toString());
				inspectInfoAdmVo1.setInspectItem20(m.get("inspectItem20").toString());
				inspectInfoAdmVo1.setInspectItem21(m.get("inspectItem21").toString());			
				inspectInfoAdmVo1.setUpdId(Utils.getUserId());
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmService.update4(inspectInfoAdmVo1);							
			}			
			
			//inspectInfoAdmVo.setUpdId(Utils.getUserId());
			//inspectInfoAdmService.update2(inspectInfoAdmVo1);			
			
			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//수입검사 수정 상단(SLD)
	@RequestMapping(value = "/qm/inspectUpdateNew", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectUpdateNew(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 수정 ");
			InspectInfoAdmVo inspectInfoAdmVo =new InspectInfoAdmVo();
			inspectInfoAdmVo.setInWhsGroupSeq(inspectList.get(0).get("inWhsGroupSeq").toString());
			inspectInfoAdmVo.setMatrlGubunCd(inspectList.get(0).get("matrlGubunCd").toString());
			inspectInfoAdmVo.setLotNo(inspectList.get(0).get("lotNo").toString());
			
			int idx = inspectInfoAdmService.selectIdx(inspectInfoAdmVo).getIdx() - (inspectList.size()-1);	
			for(Map<String, Object> m : inspectList) {
				InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setIdx(idx);
				inspectInfoAdmVo1.setInspectDate(m.get("inspectDate").toString());
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				inspectInfoAdmVo1.setManagementCd(m.get("managementCd").toString());
				inspectInfoAdmVo1.setResultCd(m.get("resultCd").toString());
				inspectInfoAdmVo1.setInspectEtc(m.get("inspectEtc").toString());
				inspectInfoAdmVo1.setUpdId(Utils.getUserId());
				inspectInfoAdmVo1.setMatrlCd(m.get("matrlCd").toString());
				inspectInfoAdmService.update3New(inspectInfoAdmVo1);				
				idx++;
				
			}		
		
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}		
	
	//수입검사 수정2 하단
	@RequestMapping(value = "/qm/inspectUpdateNew2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectUpdate2New(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 수정2 ");
			InspectInfoAdmVo inspectInfoAdmVo = new InspectInfoAdmVo();
			InspectInfoAdmVo inspectInfoAdmVo1 = new InspectInfoAdmVo();
			for(Map<String, Object> m : inspectList) {
				inspectInfoAdmVo1 = new InspectInfoAdmVo();
				inspectInfoAdmVo1.setInWhsGroupSeq(m.get("inWhsGroupSeq").toString());
				inspectInfoAdmVo1.setMatrlGubunCd(m.get("matrlGubunCd").toString());
				inspectInfoAdmVo1.setLotNo(m.get("lotNo").toString());
				//inspectInfoAdmVo1.setInspectItem1(m.get("inspectItem1").toString());
				//inspectInfoAdmVo1.setInspectItem2(m.get("inspectItem2").toString());
				//inspectInfoAdmVo1.setInspectItem3(m.get("inspectItem3").toString());
				//inspectInfoAdmVo1.setInspectItem4(m.get("inspectItem4").toString());
				//inspectInfoAdmVo1.setInspectItem5(m.get("inspectItem5").toString());
				//inspectInfoAdmVo1.setInspectItem6(m.get("inspectItem6").toString());
				//inspectInfoAdmVo1.setInspectItem7(m.get("inspectItem7").toString());
				//inspectInfoAdmVo1.setInspectItem8(m.get("inspectItem8").toString());
				//inspectInfoAdmVo1.setInspectItem9(m.get("inspectItem9").toString());
				//inspectInfoAdmVo1.setInspectItem10(m.get("inspectItem10").toString());
				//inspectInfoAdmVo1.setInspectItem11(m.get("inspectItem11").toString());
				//inspectInfoAdmVo1.setInspectItem12(m.get("inspectItem12").toString());
				inspectInfoAdmVo1.setInspectItem13(m.get("inspectItem13").toString());
				inspectInfoAdmVo1.setInspectItem14(m.get("inspectItem14").toString());
				inspectInfoAdmVo1.setInspectItem15(m.get("inspectItem15").toString());
				inspectInfoAdmVo1.setInspectItem16(m.get("inspectItem16").toString());
				inspectInfoAdmVo1.setInspectItem17(m.get("inspectItem17").toString());
				inspectInfoAdmVo1.setInspectItem18(m.get("inspectItem18").toString());
				inspectInfoAdmVo1.setInspectItem19(m.get("inspectItem19").toString());
				inspectInfoAdmVo1.setInspectItem20(m.get("inspectItem20").toString());
				inspectInfoAdmVo1.setInspectItem21(m.get("inspectItem21").toString());			
				inspectInfoAdmVo1.setUpdId(Utils.getUserId());
				inspectInfoAdmVo1.setRegId(Utils.getUserId());			
				inspectInfoAdmVo1.setMatrlCd(m.get("matrlCd").toString());
				inspectInfoAdmService.update4New(inspectInfoAdmVo1);							
			}			
			
			//inspectInfoAdmVo.setUpdId(Utils.getUserId());
			//inspectInfoAdmService.update2(inspectInfoAdmVo1);			
			
			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//수입검사 합격 여부
	@RequestMapping(value = "/qm/inspectPassCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectPassCheck(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("수입검사 합격여부");
			List<InspectInfoAdmVo> list = inspectInfoAdmService.listPass(inspectInfoAdmVo);
			
			if(list.size() == 0) {
				jsonData.put("data", "create");
			} else {
				jsonData.put("data", "update");
			}			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	
	//수입검사 합격 여부
	@RequestMapping(value = "/qm/inspectPassCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectPassCreate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
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
				
				inspectInfoAdmService.createPass(inspectInfoAdmVo1);							
			}			
			
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		
		return jsonData;
	}	
	
	//수입검사 합격 여부
		@RequestMapping(value = "/qm/inspectPassUpdate", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> inspectPassUpdate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
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
		
	
	//입출고관리 가출고목록조회
	@RequestMapping(value = "/io/matrlPreOutWhsDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlPreOutWhsDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재입고 입고현황목록조회 = " + matrlInOutWhsAdmVo);
		
		try {		
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.listPreOutWhsAll(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("설자재입고 입고현황목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}

		return jsonData;
	}
	
	//입출고관리 자재가출고수정처리
	@RequestMapping(value = "/io/matrlPreOutWhsDataUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPreOutWhsDataUpdate(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 자재가출고 수정처리 = "+ matrlInOutWhsAdmList);
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		try {
			
			boolean checkQty	= true;
			String failMessage	= "";
			
			//잔량 검사
			for(Map<String, Object> m : matrlInOutWhsAdmList) {
				logger.info("m ===> : " + m);
				matrlInOutWhsAdmVo.setBarcodeNo(null);
				matrlInOutWhsAdmVo.setLotNo(m.get("barcodeNo").toString());
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
				for(Map<String, Object> m : matrlInOutWhsAdmList) {
					logger.info("m ===> : " + m);
					matrlInOutWhsAdmVo.setBarcodeNo(null);
					matrlInOutWhsAdmVo.setLotNo(m.get("barcodeNo").toString());
					matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
					matrlInOutWhsAdmVo.setPreOutWhsDate(DateUtil.getToday("yyyyMMdd"));
					matrlInOutWhsAdmVo.setPreWorkCharger(m.get("preWorkCharger").toString());
					//matrlInOutWhsAdmVo.setPreOutEquipCd(m.get("preOutEquipCd").toString());
					//matrlInOutWhsAdmVo.setPreOutGoodsCd(m.get("preOutGoodsCd").toString());
					matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
					matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
					matrlInOutWhsAdmVo.setStatusCd("O");	//가출고 상태값
					
					//솔브레인 인 경우에만
					if ("003".equals(factoryCode)) {
						matrlInOutWhsAdmVo.setFloorGubun(m.get("floorGubun").toString()); //층 구분자
					}
					
					logger.info("입출고관리 자재가출고수정처리 out = "+ matrlInOutWhsAdmVo);
					matrlInOutWhsAdmService.updatePreOutWhsStatus(matrlInOutWhsAdmVo);
					matrlInOutWhsAdmVo.setHistId(Utils.getUserId());
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
			logger.info("입출고관리 자재가출고수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//입출고관리 자재 출고 승인으로 변경
	@RequestMapping(value = "/io/matrlPreOutWhsDataDelete_Change", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlPreOutWhsDataDelete_Change(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("입출고관리 자재가출고 승인으로 변경 = "+ matrlInOutWhsAdmVo);
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(matrlInOutWhsAdmVo);
			
			String statusCd = matrlInOutWhsAdmVo.getStatusCd();
			String barcodeNo = matrlInOutWhsAdmVo.getBarcodeNo();
			
			if (statusCd.equals("O")) {
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
				matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
				stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
				
				matrlInOutWhsAdmVo.setPreOutWhsDate(null);
				matrlInOutWhsAdmVo.setPreWorkCharger(null);
				matrlInOutWhsAdmVo.setPreOutQty(null);
				matrlInOutWhsAdmVo.setBarcodeNo(null);			
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				matrlInOutWhsAdmVo.setStatusCd("A");
				matrlInOutWhsAdmVo.setBarcodeNo(barcodeNo);
				
				logger.info("입출고관리 자재 출고 승인으로 변경 --> " +matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.matrlPreOutWhsDataDeleteChange(matrlInOutWhsAdmVo);
				matrlInOutWhsAdmVo.setHistId(Utils.getUserId());
				matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);	//자재이력등록
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
				matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
				stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
				
				jsonData.put("data", matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");
				
			} else {
				jsonData.put("message", "자재상태가 가출고인 항목만 삭제할 수 있습니다.");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			logger.info("입출고관리 자재가출고수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//입출고관리 자재가출고빈목록조회
	@RequestMapping(value = "/io/matrlPreOutWhsEmptyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlPreOutWhsEmptyList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 자재가출고빈목록조회 ");
		MatrlInOutWhsAdmVo matrlPreOutWhsEmptyList = new MatrlInOutWhsAdmVo();
		jsonData.put("data", matrlPreOutWhsEmptyList);
		return jsonData;
	}		

	//입출고관리  바코드가출고자재정보상세조회
	@RequestMapping(value = "/io/matrlPreOutWhsData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlPreOutWhsData(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리  바코드가출고자재정보 상세조회");
		logger.info(matrlInOutWhsAdmVo.toString());
		
		try {
			String exceptBarcodeNo = matrlInOutWhsAdmVo.getExceptBarcodeNo();	//스캔한 바코드
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			if(matrlInOutWhsAdmVo != null)  {
				logger.info(matrlInOutWhsAdmVo.toString());

				if( "A".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					//선입선출체크
					
					/*
					String commonFifoCheck = "";
					if( "003".equals(factoryCode) ) {
						if( "001".equals(matrlInOutWhsAdmVo.getMatrlFifoCheck()) ) {
							commonFifoCheck = "Y";
						} else {
							commonFifoCheck = "N";
						}
					} else {
						commonFifoCheck = "N";
					}
					*/
					
					if( "N".equals(matrlInOutWhsAdmVo.getFifoCheck()) ) {	// && "N".equals(commonFifoCheck)
						matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
						jsonData.put("result", "ok");							
					} else {
						
						logger.info("값 확인하는 코드 : " +exceptBarcodeNo);
						logger.info("rkqt ghkrdls : " +exceptBarcodeNo.contains("empty"));
						
						boolean firstScanCheck = exceptBarcodeNo.contains("empty");
						String exceptBoxNoQuery = exceptBarcodeNo.replace("/", "', '");	
						
						if (firstScanCheck) {
							
							//이미 몇번 스캔하였으면..
								
						} else {
							exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
							exceptBoxNoQuery += "'";
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);		
						}
						
						matrlInOutWhsAdmVo.setExceptBarcodeNo(exceptBoxNoQuery);
						List<MatrlInOutWhsAdmVo> fifoCheck = matrlInOutWhsAdmService.preOutWhsFifoCheck(matrlInOutWhsAdmVo);
						
//							if("Y".contentEquals(fifoCheck)) {
						logger.info("List 사이즈 조회 -------->" +fifoCheck.size());
						if( fifoCheck.size() == 0 ) {	//|| ("003".equals(factoryCode) && "002".equals(matrlInOutWhsAdmVo.getMatrlFifoCheck()))
							matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
							jsonData.put("result", "ok");					
						} else {
							
							/* //입고일 기준으로 D-2일 까지는 선입 선출 대상에서 제외됨(23.08.17 추가)
							SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
							systemCommonCodeVo.setBaseGroupCd("126"); //선입선출 미 대상 기간
							List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
							int fifoExceptDate = Integer.parseInt(systemCommonCodeList.get(0).getBaseCdNm());
							
							//입고일 기준으로 D-2일 까지는 선입 선출 대상에서 제외됨(23.08.17 추가)
							String dateStr = matrlInOutWhsAdmVo.getInWhsDate(); // 메서드 호출을 통해 날짜 문자열을 가져옴
							LocalDate parsedDate = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyyMMdd"));
							int date1 = Integer.parseInt( parsedDate.plusDays(fifoExceptDate).toString().replaceAll("-","") );
							int date2 = Integer.parseInt( DateUtil.getToday("yyyymmdd") ); 
							
							//23.08.22(솔브레인만 자재코드에 있는 선인선출 코드 사용함)
							if( "003".equals(factoryCode) ) {
								if( date1 >= date2 ) {
									//logger.info("아직 2일 안 지남");
									matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
									jsonData.put("result", "ok");
								} else {
									//자재 코드가 우선임 
									if( "002".equals(matrlInOutWhsAdmVo.getMatrlFifoCheck()) ) {
										matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
										jsonData.put("result", "ok");
									} else {
										//logger.info("2일 지남");
										jsonData.put("barcode", fifoCheck);
										jsonData.put("result", "before");										
									}
								}
							} else {
								//머티 1공장, 2공장은 그대로 사용
								jsonData.put("barcode", fifoCheck);
								jsonData.put("result", "before");
							}
							*/
							
							jsonData.put("barcode", fifoCheck);
							jsonData.put("result", "before");
//								jsonData.put("message", "해당 바코드 자재보다 출고되지 않은 이전 입고자재가 있습니다.<br>입고 자재를 확인해 주세요[" + fifoCheck + "]");
						}
					}	
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
	
	//선입선출 Check목록
	@RequestMapping(value = "io/preOutWhsFifoCheck", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> partReqList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			String exceptBarcodeNo = matrlInOutWhsAdmVo.getExceptBarcodeNo();	//스캔한 바코드
			
			logger.info("값 확인 -->"+matrlInOutWhsAdmVo.getBarcodeNo());
			
			if(!matrlInOutWhsAdmVo.getBarcodeNo().equals("")) {
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);	
				
				
				logger.info("값 확인하는 코드 : " +exceptBarcodeNo);
				logger.info("rkqt ghkrdls : " +exceptBarcodeNo.contains("empty"));
				
				boolean firstScanCheck = exceptBarcodeNo.contains("empty");
				String exceptBoxNoQuery = exceptBarcodeNo.replace("/", "', '");	
				
				if (firstScanCheck) {
					//이미 몇번 스캔하였으면..
				} else {
					exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
					logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
					exceptBoxNoQuery += "'";
					logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);		
				}
				
				matrlInOutWhsAdmVo.setExceptBarcodeNo(exceptBoxNoQuery);
				List<MatrlInOutWhsAdmVo> fifoCheck = matrlInOutWhsAdmService.preOutWhsFifoCheck(matrlInOutWhsAdmVo);
				logger.info("fifoCheck : "+fifoCheck);
				jsonData.put("data", fifoCheck);
			}
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//입출고관리  바코드가출고자재정보상세조회_수완이가 신규 추가 한 것(조회하면 클릭 시마다 선입선출 적용 시키는 부분)
	@RequestMapping(value = "/io/matrlPreOutWhsDataSuwan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlPreOutWhsDataSuwan(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수완이가 추가한 바코드 관련 내역 Vo값 확인하기 <__-__>"+matrlInOutWhsAdmVo);
		logger.info(matrlInOutWhsAdmVo.toString());
		
		try {
			String exceptSelectModalBarcodeNo	= matrlInOutWhsAdmVo.getExceptBarcodeNo();	//선택한 바코드
			
			JSONParser jsonParser 		= new JSONParser();
			JSONObject jsonObj 			= new JSONObject();
			JSONArray jsonArray 		= (JSONArray) jsonParser.parse(matrlInOutWhsAdmVo.getArrayData());
			String[] sendValue 			= new String[jsonArray.size()];	//보내줄 값
//			String sudel = "";
//			JSONArray sudel 		= (JSONArray) jsonParser.parse();
			JSONArray sudel 			= new JSONArray();
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo2 = new MatrlInOutWhsAdmVo();
			
			
			for(int i=0;i<jsonArray.size();i++){
				matrlInOutWhsAdmVo2 =new MatrlInOutWhsAdmVo();
				
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				
//				logger.info("DTL 확인 : " +jsonObjDtl);
				logger.info("DTL 확인 : " +jsonObjDtl.get("barcodeNo").toString());
				
				
				logger.info("Vo 값 확인해주기 ----> "+matrlInOutWhsAdmVo2);
//				logger.info("바코드 값 확인해주기 ----> "+matrlInOutWhsAdmVo.getBarcodeNo());
//				matrlInOutWhsAdmVo.setBarcodeNo("");
				matrlInOutWhsAdmVo2.setBarcodeNo(jsonObjDtl.get("barcodeNo").toString());
				
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo2);
				sudel.add(matrlInOutWhsAdmVo);
				logger.info("sudel 값 확인해주기 : " +sudel);
//				sudel.set(i, matrlInOutWhsAdmVo);
//				sendValue[i] = new String();
				
			}
			logger.info("sudel 값 확인해주기 : " +sudel);
			
			jsonData.put("receiveValue", sudel);
			jsonData.put("result", "ok");
			
			
			/*if(matrlInOutWhsAdmVo != null)  {
				logger.info(matrlInOutWhsAdmVo.toString());

				//승인 일 때
				if( "A".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					//선입선출체크
					
					if("N".equals(matrlInOutWhsAdmVo.getFifoCheck())) {
						matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getInspectQty());
						jsonData.put("result", "ok");
					} else {
						
						logger.info("값 확인하는 코드 : " +exceptSelectModalBarcodeNo);
						logger.info("rkqt ghkrdls : " +exceptSelectModalBarcodeNo.contains("empty"));
						
						boolean firstScanCheck = exceptSelectModalBarcodeNo.contains("empty");
						String exceptBoxNoQuery = exceptSelectModalBarcodeNo.replace("/", "', '");	
						
						if (firstScanCheck) {
							
							//이미 몇번 스캔하였으면..
								
						} else {
							exceptBoxNoQuery = exceptBoxNoQuery.substring(3, exceptBoxNoQuery.length());
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);
							exceptBoxNoQuery += "'";
							logger.info("exceptBoxNoQuery >>> " +exceptBoxNoQuery);		
						}
						
						matrlInOutWhsAdmVo.setExceptBarcodeNo(exceptBoxNoQuery);
						List<MatrlInOutWhsAdmVo> fifoCheck = matrlInOutWhsAdmService.preOutWhsFifoCheck(matrlInOutWhsAdmVo);
						
//							if("Y".contentEquals(fifoCheck)) {
						logger.info("List 사이즈 조회 -------->" +fifoCheck.size());
						if(fifoCheck.size() == 0) {
							matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getInspectQty());
							jsonData.put("result", "ok");					
						} else {
							jsonData.put("barcode", fifoCheck);
							jsonData.put("result", "before");				
						}
					}	
				} else  {
					jsonData.put("result", "fail");
					jsonData.put("message", matrlInOutWhsAdmVo.getApprovalNm() + "&" + matrlInOutWhsAdmVo.getStatusNm() + " 상태의 자재 입니다.");
				}
				
			} else {
				logger.info("조회된 값이 없습니다.");
				jsonData.put("message", "조회된 값이 없습니다. BarcodeNo나 LotNo를 확인해주세요.");
				jsonData.put("result", "fail");
			}*/
		} catch (Exception e) {
			logger.info("입출고관리  바코드가출고자재정보 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		jsonData.put("data", matrlInOutWhsAdmVo);
		return jsonData;
	}
	
	//생산팀에서 불량처리할 자재 스캔
	@RequestMapping(value = "/io/matrlFaultyScan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlFaultyScan(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산팀에서 불량처리할 자재 스캔");
		logger.info(matrlInOutWhsAdmVo.toString());
		try {
			matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			if(matrlInOutWhsAdmVo != null)  {
				logger.info(matrlInOutWhsAdmVo.toString());
				//가입고
				if ( "S".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					if ( "001".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "002".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 미승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "003".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 불량 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "004".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 보류 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "005".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "006".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 실제반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "007".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 자체폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "008".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "009".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "가입고 & 승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					}
					
				//수입검사
				} else if ( "I".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					if ( "001".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "002".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 미승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "003".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 불량 상태 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "004".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 보류 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "005".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "006".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 실제반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "007".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 자체폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "008".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "009".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사 & 승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					}
				
				//승인
				} else  if( "A".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					if ( "001".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "002".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료  & 미승인 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "003".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료  & 불량 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "004".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 보류 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "005".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "006".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 실제반품 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "007".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 자체폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "008".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "수입검사완료 & 폐기 상태의 자재 입니다.<br>가출고&생산 투입자재만 불량처리 할 수 있습니다!");
					} else if ( "009".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "ok");
						jsonData.put("data", matrlInOutWhsAdmVo);
					}
				
				//가출고(자재투입)
				} else if ( "O".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					if ( "001".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "ok");
						jsonData.put("data", matrlInOutWhsAdmVo);

					} else if ( "002".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 미승인 상태의 자재 입니다.");
					} else if ( "003".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 불량 상태의 자재 입니다.");
					} else if ( "004".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 보류 상태의 자재 입니다.");
					} else if ( "005".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 반품 상태의 자재 입니다.");
					} else if ( "006".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 실제반품 상태의 자재 입니다.");
					} else if ( "007".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 자체폐기 상태의 자재 입니다.");
					} else if ( "008".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 자재투입한 & 폐기 상태의 자재 입니다.");
					} else if ( "009".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "ok");
						jsonData.put("data", matrlInOutWhsAdmVo);
					}
				
				//생산투입
				} else if ( "P".equals(matrlInOutWhsAdmVo.getStatusCd()) ) {
					if ( "001".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "ok");
						jsonData.put("data", matrlInOutWhsAdmVo);
						
					} else if ( "002".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 투입된 & 미승인 상태의 자재 입니다.");
					} else if ( "003".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 투입된 & 불량 상태의 자재 입니다.");
					} else if ( "004".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 투입된 & 보류 상태의 자재 입니다.");
					} else if ( "005".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 투입된 & 반품 상태의 자재 입니다.");
					} else if ( "006".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 & 실제반품 상태의 자재 입니다.");
					} else if ( "007".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 & 자체폐기 상태의 자재 입니다.");
					} else if ( "008".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 생산에 & 폐기 상태의 자재 입니다.");
					} else if ( "009".equals(matrlInOutWhsAdmVo.getApprovalCd()) ) {
						jsonData.put("result", "ok");
						jsonData.put("data", matrlInOutWhsAdmVo);
					}
					
				//혹시 모를 에러 출력
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "알수 없는 에러가 발생하였습니다. 스캔한 자재코드를 가지고 관리자에게 문의 바랍니다.<br>오류코드:iosc0040-A001");
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
	
	//입출고관리 선입선출 목록 조회
	@RequestMapping(value = "/io/firstInFirstOutDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutWhsInspectUpdateDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선입선출 목록 조회 = "+ matrlInOutWhsAdmVo);		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmList = matrlInOutWhsAdmService.firstInFirstOutList(matrlInOutWhsAdmVo);			
			
			jsonData.put("data", matrlInOutWhsAdmList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("선입선출 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}	
		return jsonData;
	}	
	

	//입출고관리 선입선출 상세 목록 조회
	@RequestMapping(value = "/io/firstInFirstOutDtlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> firstInFirstOutDtlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선입선출 상세 목록 조회 = "+ matrlInOutWhsAdmVo);		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmList = matrlInOutWhsAdmService.firstInFirstOutDtlList(matrlInOutWhsAdmVo);			
			
			jsonData.put("data", matrlInOutWhsAdmList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("선입선출 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	
	//입출고관리 가출고목록조회
	@RequestMapping(value = "/io/deleteMatrlInOut", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMatrlInOut(@RequestBody List<Map<String, Object>> deleteList, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("삭제Lot  ");
		
		try {
			boolean check = true; //상태값체크
			boolean nullCheck = true; //상태값 null체크 
			 MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new  MatrlInOutWhsAdmVo();
			 InspectInfoAdmVo inspectInfoAdmVo =new InspectInfoAdmVo();
			 List<MatrlInOutWhsAdmVo> list = new ArrayList<MatrlInOutWhsAdmVo>();
			//logger.info("현재 IP 주소" + Utils.getClientIP(request));
			for(Map<String,Object> m : deleteList) {				
				matrlInOutWhsAdmVo = new  MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
				matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
				logger.info("matrlInOutWhsAdmVo : " + matrlInOutWhsAdmVo);

				if (matrlInOutWhsAdmVo != null) {
					if ("S".equals(matrlInOutWhsAdmVo.getStatusCd()) && "002".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
						list.add(matrlInOutWhsAdmVo);	
					} else {
						check = false;
					}	
				} else {
					nullCheck = false;
					jsonData.put("result", "statError");
					jsonData.put("message", "상태값이 변경되었습니다. 다시 조회 해주세요.");
					return jsonData;
				}
			}
					
			if (nullCheck) {
				if (check) {
					for (MatrlInOutWhsAdmVo m : list) {		
						inspectInfoAdmVo =new InspectInfoAdmVo();
						matrlInOutWhsAdmService.deleteMatrlHistBarcode(m);
						m.setIpAddress(Utils.getClientIP(request));
						m.setDltId(Utils.getUserId());
						matrlInOutWhsAdmService.insertMatrlInOutTemp(m);		//삭제데이터 TB_IN_OUT_ADM -> TB_IN_OUT_ADM_TEMP로 복사, 서비스 총 3개 실행함.			
						inspectInfoAdmVo.setLotNo(m.getLotNo());
						inspectInfoAdmService.delete1(inspectInfoAdmVo);
						inspectInfoAdmService.delete2(inspectInfoAdmVo);
						inspectInfoAdmService.deletePass(inspectInfoAdmVo);
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
						//StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
						matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "D", factoryCode);
						stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
						//matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
						//stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
						
					}
					jsonData.put("result", "ok");
					
				} else {
					jsonData.put("result", "statError");	
					jsonData.put("message", "미승인&가입고 상태의 자재만 삭제가 가능합니다.");
				}
				
			}else {
				jsonData.put("result", "statError");	
				jsonData.put("message", "상태값이 변경되었습니다. 다시 조회 해주세요.");
			}
			
			//해당 이력 삭제
			//matrlInOutWhsAdmService.updateMatrlInOutTempDltId(matrlInOutWhsAdmVo);	//삭제데이터 삭제자, 삭제일 UPDATE
			//matrlInOutWhsAdmService.deleteMatrlInOut(matrlInOutWhsAdmVo);			//삭제데이터 삭제
			
		} catch (Exception e) {
			logger.info("자재 삭제 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}

		return jsonData;
	}
	
	//출하 제품중 불량제품 Switching
	@RequestMapping(value = "/io/purchaseDtlSwitching", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> purchaseDtlSwitching(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
		logger.info("출하 제품중 불량제품 Switching" + goodsProductInfoAdmVo);
		try {
			int check = matrlInOutWhsAdmService.purchaseOrderDtlRead(goodsProductInfoAdmVo.getBoxNo());
			if(check == 0 ) {
				
				//불량상태 정상인지 확인
				if (goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S")) {
					PreGoodsInventoryAdmVo newFaultyCheck = new PreGoodsInventoryAdmVo();
					newFaultyCheck.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
					newFaultyCheck = PdaService.readPreGoodsInventoryDtl(newFaultyCheck);
					if (!"001".equals(newFaultyCheck.getFaultyStatus())) {
						jsonData.put("message", "교체할 제품의 불량상태가 정상이 아닙니다!");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					if (goodsProductInfoAdmVo.getBoxNoOld().substring(0, 1).equals("S")) {
						PreGoodsInventoryAdmVo oldFaultyCheck = new PreGoodsInventoryAdmVo();
						oldFaultyCheck.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
						oldFaultyCheck = PdaService.readPreGoodsInventoryDtl(oldFaultyCheck);
						if (!"001".equals(oldFaultyCheck.getFaultyStatus())) {
							jsonData.put("message", "기존 제품의 불량상태가 정상이 아닙니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}
					} else {
						GoodsProductInfoAdmVo oldfaultyCheck = new GoodsProductInfoAdmVo();
						oldfaultyCheck.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
						oldfaultyCheck = PdaService.readGoodsProductInfo(oldfaultyCheck);
						if (!"001".equals(oldfaultyCheck.getFaultyStatus())) {
							jsonData.put("message", "기존 제품의 불량상태가 정상이 아닙니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}
					}
				} else {
					GoodsProductInfoAdmVo faultyCheck = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
					if (faultyCheck == null) {
						jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ("Y".equals(faultyCheck.getDisuseYn())) {
						jsonData.put("message", "폐기된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ("D".equals(faultyCheck.getDivisionYn())) {
						jsonData.put("message", "분할된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ("M".equals(faultyCheck.getDivisionYn())) {
						jsonData.put("message", "병합된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if ((faultyCheck.getGoodsCd() != goodsProductInfoAdmVo.getGoodsCd()) && (faultyCheck.getRemainCnt() != goodsProductInfoAdmVo.getRemainCntOld())) {
						jsonData.put("message", "제품 정보가 변경되었습니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
						return jsonData;
					} else if (!"001".equals(faultyCheck.getFaultyStatus())) {
						jsonData.put("message", "교체할 제품의 불량상태가 정상이 아닙니다!");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
					if (goodsProductInfoAdmVo.getBoxNoOld().substring(0, 1).equals("S")) {
						PreGoodsInventoryAdmVo oldFaultyCheck = new PreGoodsInventoryAdmVo();
						oldFaultyCheck.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
						oldFaultyCheck = PdaService.readPreGoodsInventoryDtl(oldFaultyCheck);
						if (!"001".equals(oldFaultyCheck.getFaultyStatus())) {
							jsonData.put("message", "기존 제품의 불량상태가 정상이 아닙니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}
					} else {
						GoodsProductInfoAdmVo oldfaultyCheck = new GoodsProductInfoAdmVo();
						oldfaultyCheck.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
						oldfaultyCheck = PdaService.readGoodsProductInfo(oldfaultyCheck);
						if (!"001".equals(oldfaultyCheck.getFaultyStatus())) {
							jsonData.put("message", "기존 제품의 불량상태가 정상이 아닙니다!");
							jsonData.put("result", "fail");
							return jsonData;
						}
					}
				}
				
				
				
				
				
				
				
				
				
				
				
				//스캔제품(newBox)이 재고 제품인 경우
				if ( goodsProductInfoAdmVo.getBoxNo().substring(0, 1).equals("S") ) {
					
					//Switching 할 정상제품
					preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
					preGoodsInventoryDtl.setGoodsCd(goodsProductInfoAdmVo.getGoodsCd());
					preGoodsInventoryDtl = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl);
					if (preGoodsInventoryDtl == null) {
						jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
						jsonData.put("result", "fail");
					} else if (!"001".equals(preGoodsInventoryDtl.getFaultyStatus())) {
						jsonData.put("message", "불량상태가 정상인 새 제품을 스캔해주세요!");
						jsonData.put("result", "fail");
					} else if ((preGoodsInventoryDtl.getGoodsCd() != goodsProductInfoAdmVo.getGoodsCd()) && (preGoodsInventoryDtl.getRemainCnt() != goodsProductInfoAdmVo.getRemainCntOld())) {
						jsonData.put("message", "제품 정보가 변경되었습니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
					} else {
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo switchingBoxNo = new StockPaymentAdmVo();
						switchingBoxNo = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryDtl.getGoodsCd(), preGoodsInventoryDtl.getBoxNo(), "003", "O", "008", preGoodsInventoryDtl.getRemainCnt(), factoryCode);	
						stockPaymentAdmService.stockPaymentPlus(switchingBoxNo);
						//newBox 출고처리
						preGoodsInventoryDtl.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
						preGoodsInventoryDtl.setGoodsStatus("003");
						preGoodsInventoryDtl.setRemainCnt(0);
						preGoodsInventoryDtl.setUpdId(Utils.getUserId());
						preGoodsInventoryDtl.setHistId(Utils.getUserId());
						PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl);
						preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
						
						//Switching 할 검사반품
						//검사반품처리할 박스가 생산인지 재고인지 판단
						//재고제품
						if ( goodsProductInfoAdmVo.getBoxNoOld().substring(0, 1).equals("S") ) {
							PreGoodsInventoryAdmVo preGoodsInventoryDtl2 = new PreGoodsInventoryAdmVo();
							preGoodsInventoryDtl2.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
							preGoodsInventoryDtl2 = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl2);
							preGoodsInventoryDtl2.setGoodsStatus("002");
							preGoodsInventoryDtl2.setFaultyStatus("003");
							preGoodsInventoryDtl2.setRemainCnt(goodsProductInfoAdmVo.getRemainCntOld());	//취소할 출고수량만큼 잔여수량을 맞춰줌
							preGoodsInventoryDtl2.setUpdId(Utils.getUserId());
							preGoodsInventoryDtl2.setHistId(Utils.getUserId());
							//업데이트 해줌
							PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl2);
							preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl2); //재고제품 상태변경 이력쌓기
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo returnBoxNo = new StockPaymentAdmVo();
							returnBoxNo = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryDtl2.getGoodsCd(), preGoodsInventoryDtl2.getBoxNo(), "003", "I", "010", preGoodsInventoryDtl2.getRemainCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(returnBoxNo);
							
						//생산제품
						} else {
							GoodsProductInfoAdmVo oldGoodsProduct = new GoodsProductInfoAdmVo();
							oldGoodsProduct.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
							oldGoodsProduct = PdaService.readGoodsProductInfo(oldGoodsProduct);
							
							//제품 Switching 사용 시1,2공자은 포장으로 / 3공장은 입고상태로 변경
							if(factoryCode.equals("001") || factoryCode.equals("002")) {
								oldGoodsProduct.setGoodsStatus("001");								
							} else {
								oldGoodsProduct.setGoodsStatus("002");								
							}
							
							oldGoodsProduct.setFaultyStatus("003");
							oldGoodsProduct.setRemainCnt(goodsProductInfoAdmVo.getRemainCntOld());	//취소할 출고수량만큼 잔여수량을 맞춰줌
							oldGoodsProduct.setUpdId(Utils.getUserId());
							oldGoodsProduct.setHistId(Utils.getUserId());
							PdaService.updateBox(oldGoodsProduct);
							PdaService.insertGoodsProductHist(oldGoodsProduct);			//생산제품 상태변경 기록
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo returnBoxNo = new StockPaymentAdmVo();
							returnBoxNo = StockPaymentAdmController.goodsStockPaymentHist(oldGoodsProduct.getGoodsCd(), oldGoodsProduct.getBoxNo(), "002", "I", "010", oldGoodsProduct.getRemainCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(returnBoxNo);
						}
						
						//제품출하기록 BoxNo 변경
						PurchaseOrderDtl purchaseOrderDtlVo = new PurchaseOrderDtl();
						purchaseOrderDtlVo.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
						purchaseOrderDtlVo.setBoxNoOld(goodsProductInfoAdmVo.getBoxNoOld());
						purchaseOrderDtlVo.setCustomerLotNo(goodsProductInfoAdmVo.getCustomerLotNo());
						purchaseOrderDtlVo.setUpdId(Utils.getUserId());
						purchaseOrderAdmService.updateDtl(purchaseOrderDtlVo);
						
						jsonData.put("data", goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
					}
					
				//스캔제품(newBox)이 생산 제품인 경우
				} else {
					GoodsProductInfoAdmVo goodsProductInfoAdmVo2 = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
					if (goodsProductInfoAdmVo2 == null) {
						jsonData.put("message", "PO정보(제품코드)와 일치하지 않거나 존재하지 않는 BoxNo입니다.");
						jsonData.put("result", "fail");
					} else if ("Y".equals(goodsProductInfoAdmVo2.getDisuseYn())) {
						jsonData.put("message", "폐기된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
					} else if ("D".equals(goodsProductInfoAdmVo2.getDivisionYn())) {
						jsonData.put("message", "분할된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
					} else if ("M".equals(goodsProductInfoAdmVo2.getDivisionYn())) {
						jsonData.put("message", "병합된 제품입니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
					} else if ((goodsProductInfoAdmVo2.getGoodsCd() != goodsProductInfoAdmVo.getGoodsCd()) && (goodsProductInfoAdmVo2.getRemainCnt() != goodsProductInfoAdmVo.getRemainCntOld())) {
						jsonData.put("message", "제품 정보가 변경되었습니다. 다시 스캔해 주세요!");
						jsonData.put("result", "fail");
					} else {
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo switchingBoxNo = new StockPaymentAdmVo();
						switchingBoxNo = StockPaymentAdmController.goodsStockPaymentHist(goodsProductInfoAdmVo2.getGoodsCd(), goodsProductInfoAdmVo2.getBoxNo(), "002", "O", "008", goodsProductInfoAdmVo2.getRemainCnt(), factoryCode);	
						stockPaymentAdmService.stockPaymentPlus(switchingBoxNo);
						
						//newBox 출고처리
						//goodsProductInfoAdmVo2.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
						goodsProductInfoAdmVo2.setGoodsStatus("003");
						goodsProductInfoAdmVo2.setRemainCnt(0);
						goodsProductInfoAdmVo2.setUpdId(Utils.getUserId());
						goodsProductInfoAdmVo2.setHistId(Utils.getUserId());
						PdaService.updateBox(goodsProductInfoAdmVo2);
						PdaService.insertGoodsProductHist(goodsProductInfoAdmVo2);			//생산제품 상태변경 기록
						
						//Switching 할 검사반품
						//검사반품처리할 박스가 생산인지 재고인지 판단
						//재고제품
						if ( goodsProductInfoAdmVo.getBoxNoOld().substring(0, 1).equals("S") ) {
							PreGoodsInventoryAdmVo preGoodsInventoryDtl2 = new PreGoodsInventoryAdmVo();
							preGoodsInventoryDtl2.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
							preGoodsInventoryDtl2 = PdaService.readPreGoodsInventoryDtl(preGoodsInventoryDtl2);
							preGoodsInventoryDtl2.setGoodsStatus("002");
							preGoodsInventoryDtl2.setFaultyStatus("003");
							preGoodsInventoryDtl2.setRemainCnt(goodsProductInfoAdmVo.getRemainCntOld());	//취소할 출고수량만큼 잔여수량을 맞춰줌
							preGoodsInventoryDtl2.setUpdId(Utils.getUserId());
							preGoodsInventoryDtl2.setHistId(Utils.getUserId());
							//업데이트 해줌
							PdaService.updatePreGoodsInventoryDtl(preGoodsInventoryDtl2);
							preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl2); //재고제품 상태변경 이력쌓기
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo returnBoxNo = new StockPaymentAdmVo();
							returnBoxNo = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryDtl2.getGoodsCd(), preGoodsInventoryDtl2.getBoxNo(), "003", "I", "010", preGoodsInventoryDtl2.getRemainCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(returnBoxNo);
							
						//생산제품
						} else {
							GoodsProductInfoAdmVo oldGoodsProduct = new GoodsProductInfoAdmVo();
							oldGoodsProduct.setBoxNo(goodsProductInfoAdmVo.getBoxNoOld());
							oldGoodsProduct = PdaService.readGoodsProductInfo(oldGoodsProduct);
							//oldGoodsProduct.setGoodsStatus("002");
							oldGoodsProduct.setGoodsStatus(goodsProductInfoAdmVo.getGoodsStatus());	//트레이 로직으로 변경 후 반품시 포장상태로 바꼈음
							oldGoodsProduct.setFaultyStatus(goodsProductInfoAdmVo.getFaultyStatus());
							oldGoodsProduct.setRemainCnt(goodsProductInfoAdmVo.getRemainCntOld());	//취소할 출고수량만큼 잔여수량을 맞춰줌
							oldGoodsProduct.setUpdId(Utils.getUserId());
							oldGoodsProduct.setHistId(Utils.getUserId());
							PdaService.updateBox(oldGoodsProduct);
							PdaService.insertGoodsProductHist(oldGoodsProduct);			//생산제품 상태변경 기록
							
							
							//검사반품 이력 쌓아두면 됨, 트레이 일 경우에만
							if (oldGoodsProduct.getBoxNo().length() == 15) {
								ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
								shipInspectAdmVo.setTrayNo(oldGoodsProduct.getBoxNo());
								shipInspectAdmVo.setTrayNo1(oldGoodsProduct.getBoxNo());
								shipInspectAdmVo.setTrayNo2(oldGoodsProduct.getBoxNo());
								
								ShipInspectVo shipInspectReadVo = new ShipInspectVo();
								shipInspectReadVo.setReInspStatus("001");
								shipInspectReadVo.setTrayNo(oldGoodsProduct.getBoxNo().substring(0,oldGoodsProduct.getBoxNo().length()-2));
								List<ShipInspectVo> ReadList = shipInspectService.shipInspAdmRead(shipInspectReadVo);
								
								//트레이 번호로 작업지시 조회
								GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo = new GoodsProductInfoAdmVo();	//생산제품
								readTrayBoxByWorkOrdNo.setBoxNo(oldGoodsProduct.getBoxNo());
								readTrayBoxByWorkOrdNo = PdaService.readTrayBoxByWorkOrdNo(readTrayBoxByWorkOrdNo);
								
								shipInspectAdmVo.setWorkOrdNo(readTrayBoxByWorkOrdNo.getWorkOrdNo());
								shipInspectAdmVo.setMatrlLotNo(readTrayBoxByWorkOrdNo.getMatrlLotNo());
								shipInspectAdmVo.setFilmLotNo(readTrayBoxByWorkOrdNo.getFilmLotNo());
								//shipInspectAdmVo.setInspStatus();
								shipInspectAdmVo.setReInspStatus("003");
								//shipInspectAdmVo.setDisStatus();
								//shipInspectAdmVo.setInspDate( date );
								shipInspectAdmVo.setFaultyCnt("0");
								//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
								//shipInspectAdmVo.setInspChargr(inspChargr);
								//shipInspectAdmVo.setDayNightCd(dayNightGubun);
								//shipInspectAdmVo.setFaultyGubun(faultyGubun);
								shipInspectAdmVo.setDayNightCd(ReadList.get(0).getDayNightCd());
								shipInspectAdmVo.setProductDate(ReadList.get(0).getProductDate());
								
								shipInspectAdmVo.setNextGubun("001");				//출하재검
								shipInspectAdmVo.setRegId(Utils.getUserId());
								String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
								shipInspectAdmVo.setSeq(seq);
								shipInspectService.shipAdmCreate(shipInspectAdmVo);	
							}
							
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							StockPaymentAdmVo returnBoxNo = new StockPaymentAdmVo();
							returnBoxNo = StockPaymentAdmController.goodsStockPaymentHist(oldGoodsProduct.getGoodsCd(), oldGoodsProduct.getBoxNo(), "002", "I", goodsProductInfoAdmVo.getLocationCd(), oldGoodsProduct.getRemainCnt(), factoryCode);	
							stockPaymentAdmService.stockPaymentPlus(returnBoxNo);
						}
						
						//제품출하기록 BoxNo 변경
						PurchaseOrderDtl purchaseOrderDtlVo = new PurchaseOrderDtl();
						purchaseOrderDtlVo.setBoxNo(goodsProductInfoAdmVo.getBoxNo());
						purchaseOrderDtlVo.setBoxNoOld(goodsProductInfoAdmVo.getBoxNoOld());
						purchaseOrderDtlVo.setUpdId(Utils.getUserId());
						purchaseOrderDtlVo.setCustomerLotNo(goodsProductInfoAdmVo.getCustomerLotNo());
						purchaseOrderAdmService.updateDtl(purchaseOrderDtlVo);
						jsonData.put("data", goodsProductInfoAdmVo);
						jsonData.put("result", "ok");
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

	
	//입출고관리-자재 입출고 내역
	@RequestMapping(value = "/iosc0110", method = RequestMethod.GET)
	public String iosc0110(Locale locale, Model model) throws Exception {
		logger.info("입출고관리-자재 입출고 내역 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		return "io/iosc0110";
	}
	
	//입출고관리-자재입출고 내역 조회
	@RequestMapping(value = "/io/matrlInOutHistList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInOutHistList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리-자재입출고 내역 조회 = " + matrlInOutWhsAdmVo.getBarcodeNo());
		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutHistList = matrlInOutWhsAdmService.matrlInOutHistList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutHistList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자재 삭제 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}

		return jsonData;
	}
	
	//입출고관리-자재 입출고 내역
	@RequestMapping(value = "/iosc0120", method = RequestMethod.GET)
	public String iosc0120(Locale locale, Model model) throws Exception {
		logger.info("제품출하 추적");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "io/iosc0120";
	}
	
	//입출고관리-제품출하추적->포장번호로 출하PO 정보 확인
	@RequestMapping(value = "/io/tracePurchaseOrderOutputHist", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tracePurchaseOrderOutputHist(PurchaseOrderDtl purchaseOrderDtl, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리-제품출하추적->포장번호로 출하PO 정보 확인 - " + purchaseOrderDtl.getBoxNo());
		
		try {
			List<PurchaseOrderDtl> purchaseOrderDtlList = purchaseOrderAdmService.tracePurchaseOrderOutputHist(purchaseOrderDtl);
			jsonData.put("data", purchaseOrderDtlList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("입출고관리-제품출하추적->포장번호로 출하PO 정보 확인");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}

		return jsonData;
	}
	
	//입출고관리 입고현황 잔량 수정 
	@RequestMapping(value = "/io/remainQtyUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> remainQtyUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("입출고관리 입고현황 잔량 수정 = " + matrlInOutWhsAdmVo);
		try {
			MatrlInOutWhsAdmVo matrlInOutWhsAdmData = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			
			matrlInOutWhsAdmData.setUpdId(Utils.getUserId());
			if(matrlInOutWhsAdmVo.getRqSaveCheck() != null) {//rqSaveCheck: 작업지시선택에서 수정(잔량등록)하는지 체크
				matrlInOutWhsAdmData.setStatusCd("O");
				matrlInOutWhsAdmService.matrlPreOutWhsDataDeleteChange(matrlInOutWhsAdmData);
			}
			
			if(matrlInOutWhsAdmData.getStatusCd().equals("P")) {
				jsonData.put("message", "생산투입된 자재는 변경할 수 없습니다.");
				jsonData.put("result", "fail");
				return jsonData;
			}
			
			matrlInOutWhsAdmData.setRemainQty(matrlInOutWhsAdmVo.getRemainQty());
			matrlInOutWhsAdmService.updateRemainQty(matrlInOutWhsAdmData);
			matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmData);		//자재이력등록
			
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
			StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
			matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmData, "O", factoryCode);
			stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//기존 위치 재고 -
			matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmData, factoryCode);
			matrlStockPaymentAdmVoPlus.setSpQty(Float.parseFloat(matrlInOutWhsAdmVo.getRemainQty()));
			stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
			
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("입출고관리 입고현황 잔량 수정 에러");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//입출고관리- 파레트 라벨 출력
	@RequestMapping(value = "/iosc0170", method = RequestMethod.GET)
	public String iosc0170(Locale locale, Model model) throws Exception {
		logger.info("입출고관리-파레트 라벨 출력 메인");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		model.addAttribute("serverDateFrom", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDateTo", DateUtil.getDay("yyyy-mm-dd", +31));
		
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형	
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("111"); // 출력여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("printWetherType", systemCommonCodeList );
	
		systemCommonCodeVo.setBaseGroupCd("112"); // 완공여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("completeYnType", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("036"); // 제품 출하상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsStatus", systemCommonCodeList);
		
		return "io/iosc0170";
		}
		
		//제품입출고관리 / 파레트라벨출력 
		@RequestMapping(value = "/io/productShipmentDataList_iosc0170_F3", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> productShipmentDataList_iosc0170_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
			
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("제품입출고관리 파레트라벨출력  = " + matrlInOutWhsAdmVo);
			try {
				matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
				List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.productShipmentPalateDataList(matrlInOutWhsAdmVo);
				jsonData.put("data", matrlInOutWhsAdmData);
				jsonData.put("result", "ok");
			} catch (Exception e) {
				logger.info("파레트라벨출력 실패");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}

			return jsonData;
		}
				
				
		//제품입출고관리 / 파레트라벨 상세출력 
		@RequestMapping(value = "/io/productShipmentPalateDtlDataList_iosc0170_F3", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> productShipmentPalateDtlDataList_iosc0170_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
			
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("제품입출고관리 파레트라벨출력 상세출력  = " + matrlInOutWhsAdmVo);
			try {
				matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
				List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
				jsonData.put("data", matrlInOutWhsAdmData);
				jsonData.put("result", "ok");
			} catch (Exception e) {
				logger.info("파레트라벨출력 상세로딩 실패");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}

			return jsonData;
		}
		
		//제품입출고관리 / 파레트라벨 프린트 출력 여부
		@RequestMapping(value = "/io/productShipmentPrint_iosc0170_F3", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> productShipmentPrint_iosc0170_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("파레트라벨출력 프린트 출력여부  = " + matrlInOutWhsAdmVo);			
			try {
				matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
				logger.info("파레트라벨출력 프린트 출력여부 수정: " + matrlInOutWhsAdmVo);
				matrlInOutWhsAdmService.productShipmentPrintUpdate(matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");
			} catch (Exception e) {
				e.printStackTrace();
				jsonData.put("result", "error");
				jsonData.put("message", Utils.getErrorMessage());
			}
			return jsonData;
		}
		
		//제품 테이블 비고란 업데이트
		@RequestMapping(value = "/io/goodsProductDescUpdate_F3", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> goodsProductDescUpdate_F3(@RequestBody List<Map<String, Object>> goodsList) throws Exception {
			Map<String, Object> jsonData = new HashMap<String, Object>();
			try {
				logger.info("제품 테이블 비고란 업데이트 :  " + goodsList);
				//제품 비고 업데이트
				for (Map<String, Object> m : goodsList) {
					MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
					matrlInOutWhsAdmVo.setBoxNo(m.get("boxNo").toString());
					matrlInOutWhsAdmVo.setGoodsDesc(m.get("goodsDesc") == null ? null : m.get("goodsDesc").toString());
					matrlInOutWhsAdmService.goodsProductDescUpdate_F3(matrlInOutWhsAdmVo);
				}
				jsonData.put("result", "ok");
			} catch (Exception e) {
				e.printStackTrace();
				jsonData.put("result", "error");
				jsonData.put("message", Utils.getErrorMessage());
			}
			return jsonData;
		}
		
		
	//박스 반품처리 & 박스 삭제 처리
	@RequestMapping(value = "/io/boxReturn_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> boxReturn_F3(@RequestBody List<Map<String, Object>>  returnList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("반품박스 : " + returnList);
			
			if(returnList.get(0).get("dtlCount") != null) {
				int dtlCount = Integer.parseInt(returnList.get(0).get("dtlCount").toString());
				String poSeqChk = returnList.get(0).get("poSeq").toString();
				String poGroupChk = returnList.get(0).get("poGroup").toString();

				//dtlCount 사용하여 count 비교하기!!
				PurchaseOrderDtl purchaseOrderDtlCheck = new PurchaseOrderDtl();
				purchaseOrderDtlCheck.setPoSeq(poSeqChk);
				purchaseOrderDtlCheck.setPoGroup(poGroupChk);
				int dtlCountCheck = purchaseOrderAdmService.purchaseOrderDtlDeleteCheck(purchaseOrderDtlCheck);
				
				//개수가 변경되었으면 반품 처리 취소(이미 누군가 삭제하였음)
				if ( dtlCount != dtlCountCheck ) {
					jsonData.put("message", "가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
					jsonData.put("result", "error");
					return jsonData;
				} 
				
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setPoSeq(poSeqChk);
				matrlInOutWhsAdmVo.setPoGroup(poGroupChk);
				
				List<MatrlInOutWhsAdmVo> dtlListChk = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
			
				if(!"003".equals(dtlListChk.get(0).getGoodsStatus())) {
					jsonData.put("message", "가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
					jsonData.put("result", "error");
					return jsonData;
				}
			}
			
			for(Map<String, Object> m : returnList) {
				String poSeq = m.get("poSeq").toString();
				String poGroup = m.get("poGroup").toString();
				String returnboxNo = m.get("returnBoxNo").toString();
				String goodsStatus = m.get("goodsStatus").toString();
				String faultyStatusDate = m.get("faultyStatusDate").toString();
				String faultyStatus = m.get("faultyStatus").toString();
			
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setPoSeq(poSeq);
				matrlInOutWhsAdmVo.setPoGroup(poGroup);
				matrlInOutWhsAdmVo.setBoxNo(returnboxNo);
				
				List<MatrlInOutWhsAdmVo> dtlList = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
				
				int outputCnt = Integer.parseInt(dtlList.get(0).getOutputCnt());
				
				//TB_PURCHASE_ORDER_ADM 수량 업데이트
				PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
				purchaseOrderAdmVo.setOutputQty(outputCnt);
				purchaseOrderAdmVo.setRemainQty(outputCnt);
				purchaseOrderAdmVo.setUpdId(Utils.getUserId());
				purchaseOrderAdmVo.setPoSeq(poSeq);
				purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
				
				//TB_PURCHASE_ORDER_OUTPUT_HIST 수량 업데이트
				PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
				purchaseOrderOutputHistVo.setCancelOutputSum(outputCnt);
				purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
				purchaseOrderOutputHistVo.setPoSeq(poSeq);
				purchaseOrderOutputHistVo.setPoGroup(poGroup);
				purchaseOrderAdmService.updatePurchaseOutputHist(purchaseOrderOutputHistVo);
				
				//TB_GOODS_PRODUCT_INFO_ADM 부적합(대기) 상태 업데이트
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				goodsProductInfoAdmVo.setBoxNo(returnboxNo);
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				goodsProductInfoAdmVo.setRemainCnt(outputCnt);
				goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);
				goodsProductInfoAdmVo.setFaultyStatusDate(faultyStatusDate);
				goodsProductInfoAdmVo.setFaultyStatus(faultyStatus);
				PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
				
				goodsProductInfoAdmVo.setHistId(Utils.getUserId());
				PdaService.insertGoodsProductHist_F3(goodsProductInfoAdmVo);
				
				goodsProductInfoAdmVo.setGoodsStatus("002");
				goodsProductInfoAdmVo.setFaultyStatus("004");
				PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
				
				//TB_PURCHASE_ORDER_DTL 박스 삭제
				PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
				purchaseOrderDtl.setPoSeq(poSeq);
				purchaseOrderDtl.setPoGroup(poGroup);
				purchaseOrderDtl.setBoxNo(returnboxNo);
				purchaseOrderAdmService.deletePurchaseOrderDtl(purchaseOrderDtl);
				
				/*--------------------수불 정보 관련--------------------*/
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
				stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(0).getGoodsCd().toString(), returnboxNo, "002", "I", "010", Integer.parseInt(dtlList.get(0).getPackCnt().toString()), factoryCode);
				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
				/*--------------------수불 정보 관련--------------------*/
			}
			
//			/*--------------------박스 정보 관련--------------------*/
//			//박스 정보 삭제됨에 따라 업데이트
//			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
//			goodsProductInfoAdmVo.setPoSeq(poSeq);
//			goodsProductInfoAdmVo.setPoGroup(poGroup);
//			PdaService.palletBoxDelete_F3(goodsProductInfoAdmVo);
//			//박스 정보 삭제됨에 따라 업데이트
//
//			//박스 한개 씩 기록 남기게 값 가지고 오기
//			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
//			matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
//			matrlInOutWhsAdmVo.setPoSeq(poSeq);
//			matrlInOutWhsAdmVo.setPoGroup(poGroup);
//			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
//			//박스 한개 씩 기록 남기게 값 가지고 오기
//			
//			//가지고 온 값으로 박스 한개 씩 기록 남겨두기
//			for(int i=0; i < matrlInOutWhsAdmData.size(); i++) {
//				goodsProductInfoAdmVo.setBoxNo(matrlInOutWhsAdmData.get(i).getBoxNo());
//				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
//				goodsProductInfoAdmVo.setHistId(Utils.getUserId());
//				//해당 재고제품 INFO UPDATE
//				PdaService.insertGoodsProductHist(goodsProductInfoAdmVo); //재고제품 상태변경 이력쌓기
//				
//				/*--------------------수불 정보 관련--------------------*/
//				MatrlInOutWhsAdmVo m = matrlInOutWhsAdmData.get(i);
//				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//				StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//				stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(m.getGoodsCd().toString(), m.getBoxNo().toString(), "002", "D", "008", Integer.parseInt(m.getPackCnt().toString()), factoryCode);
//				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
//				/*--------------------수불 정보 관련--------------------*/
//			}
//			//가지고 온 값으로 박스 한개 씩 기록 남겨두기
//			/*--------------------박스 정보 관련--------------------*/
//			
//			/*--------------------파레트 정보 관련--------------------*/
//			//이후 트레이 있을 경우 Update
//			purchaseOrderAdmService.removeTrayByPallet_F3(purchaseOrderOutputHistVo);
//			//이후 트레이 있을 경우 Update
//			
//			//해당 파레트 삭제
//			purchaseOrderAdmService.deletePurchaseOrderOutputHist(purchaseOrderOutputHistVo);
//			//해당 파레트 삭제
//			
//			//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
//			PurchaseOrderDtl deletePurchaseOrderDtl = new PurchaseOrderDtl();
//			deletePurchaseOrderDtl.setPoSeq(poSeq);
//			deletePurchaseOrderDtl.setPoGroup(poGroup);
//			purchaseOrderAdmService.deletePurchaseOrderDtl(deletePurchaseOrderDtl);
//			//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
//			/*--------------------파레트 정보 관련--------------------*/
//			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//교체 박스 조회
	@RequestMapping(value = "/io/goodsProductInfoRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsProductInfoRead(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("교체 박스 조회  = " + goodsProductInfoAdmVo);
		try {
			String orgGoodsCd = goodsProductInfoAdmVo.getGoodsCd();
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			//String newGoodsCd = goodsProductInfoAdmVo.getGoodsCd();
			
			if(goodsProductInfoAdmVo == null) {
				jsonData.put("message", "해당 박스를 찾을 수 없습니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else if(!orgGoodsCd.equals(goodsProductInfoAdmVo.getGoodsCd())){
				jsonData.put("message", "서로 다른 제품입니다.");
				jsonData.put("result", "fail");
			} else if(!"007".equals(goodsProductInfoAdmVo.getGoodsStatus())) { //002 -> 007변경됨(23.07.20)
				jsonData.put("message", "포장대기 상태의 박스가 아닙니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else if(!(goodsProductInfoAdmVo.getCompleteYn() == null || "".equals(goodsProductInfoAdmVo.getCompleteYn()))) {
				jsonData.put("message", goodsProductInfoAdmVo.getBoxNo() + "이미 파레트 포장된 박스입니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else if(!"001".equals(goodsProductInfoAdmVo.getFaultyStatus())){
				jsonData.put("message", "정상인 박스가 아닙니다.");
				jsonData.put("result", "fail");
				return jsonData;
			} else {
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("교체 박스 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//박스 교체처리
	@RequestMapping(value = "/io/boxSwitch_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> boxSwitch_F3(@RequestBody List<Map<String, Object>>  switchList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("교체박스 : " + switchList);
			
			String poSeq = switchList.get(0).get("poSeq").toString();
			String poGroup = switchList.get(0).get("poGroup").toString();
			String switchingBoxNo = switchList.get(0).get("switchingBoxNo").toString();
			String goodsStatus = switchList.get(0).get("goodsStatus").toString();
			String faultyStatusDate = switchList.get(0).get("faultyStatusDate").toString();
			String faultyStatus = switchList.get(0).get("faultyStatus").toString();
			String newBoxNo = switchList.get(0).get("newBoxNo").toString();
			String locationInputDate = switchList.get(0).get("locationInputDate") == null ? null : switchList.get(0).get("locationInputDate").toString();
			String locationCd = "";
		
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			matrlInOutWhsAdmVo.setPoSeq(poSeq);
			matrlInOutWhsAdmVo.setPoGroup(poGroup);
			matrlInOutWhsAdmVo.setBoxNo(switchingBoxNo);
			
			List<MatrlInOutWhsAdmVo> dtlList = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
			
			int outputCnt = Integer.parseInt(dtlList.get(0).getOutputCnt());
			String poNoSeq = dtlList.get(0).getPoNoSeq();
			String completeYn = dtlList.get(0).getCompleteYn();
			
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setBoxNo(switchingBoxNo);
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			String customerLotNo = goodsProductInfoAdmVo.getCustomerLotNo();
			if("004".equals(goodsStatus)) {
				locationCd = goodsProductInfoAdmVo.getLocationCd();
			}
			
			//TB_PURCHASE_ORDER_ADM 수량 업데이트
			PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
			purchaseOrderAdmVo.setOutputQty(outputCnt);
			purchaseOrderAdmVo.setRemainQty(outputCnt);
			purchaseOrderAdmVo.setUpdId(Utils.getUserId());
			purchaseOrderAdmVo.setPoSeq(poSeq);
			purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
			
			//TB_PURCHASE_ORDER_OUTPUT_HIST 수량 업데이트
			PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
			purchaseOrderOutputHistVo.setCancelOutputSum(outputCnt);
			purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
			purchaseOrderOutputHistVo.setPoSeq(poSeq);
			purchaseOrderOutputHistVo.setPoGroup(poGroup);
			purchaseOrderAdmService.updatePurchaseOutputHist(purchaseOrderOutputHistVo);
			
			//TB_GOODS_PRODUCT_INFO_ADM 부적합(대기) 상태 업데이트
			goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setBoxNo(switchingBoxNo);
			goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
			goodsProductInfoAdmVo.setRemainCnt(outputCnt);
			goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);
			goodsProductInfoAdmVo.setFaultyStatusDate(faultyStatusDate);
			goodsProductInfoAdmVo.setFaultyStatus(faultyStatus);
			PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
			
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			PdaService.insertGoodsProductHist_F3(goodsProductInfoAdmVo);
			
			goodsProductInfoAdmVo.setGoodsStatus("002");
			goodsProductInfoAdmVo.setFaultyStatus("004");
			PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
			
			//TB_PURCHASE_ORDER_DTL 박스 삭제
			PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
			purchaseOrderDtl.setPoSeq(poSeq);
			purchaseOrderDtl.setPoGroup(poGroup);
			purchaseOrderDtl.setBoxNo(switchingBoxNo);
			purchaseOrderAdmService.deletePurchaseOrderDtl(purchaseOrderDtl);
			
			/*--------------------수불 정보 관련--------------------*/
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
			stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(0).getGoodsCd().toString(), switchingBoxNo, "002", "I", "010", Integer.parseInt(dtlList.get(0).getPackCnt().toString()), factoryCode);
			stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
			/*--------------------수불 정보 관련--------------------*/
			
			//새로운 박스 투입 시작
			goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setBoxNo(newBoxNo);
			goodsProductInfoAdmVo = PdaService.readGoodsProductInfo(goodsProductInfoAdmVo);
			
			String packCnt = goodsProductInfoAdmVo.getPackCnt();
			int remainCnt = goodsProductInfoAdmVo.getRemainCnt();
			String goodsCd = goodsProductInfoAdmVo.getGoodsCd();
			
			//TB_GOODS_PRODUCT_INFO_ADM 업데이트
			goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setBoxNo(newBoxNo);
			
			//출하대기인 경우에만 점검대기로 상태 값 다기 변경 진행
			/*if( goodsStatus.equals("004") ) {
				goodsProductInfoAdmVo.setGoodsStatus("005");	
			} else {
				goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);
			}*/
			
			goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);
			
			goodsProductInfoAdmVo.setCompleteYn(completeYn);
			goodsProductInfoAdmVo.setCustomerLotNo(customerLotNo);
			if("004".equals(goodsStatus)) {
				goodsProductInfoAdmVo.setLocationCd(locationCd);
			}
			PdaService.updateProductLocation(goodsProductInfoAdmVo);
			
			//출하대기인 경우에만 점검대기로 상태 값 다기 변경 진행
			/*if( goodsStatus.equals("004") ) {
				goodsProductInfoAdmVo.setGoodsStatus("005");
				goodsProductInfoAdmVo.setPoGroup(poGroup);
				PdaService.palletCheckStatusReplaceUpdate(goodsProductInfoAdmVo);	
			}*/
			
			//TB_GOODS_PRODUCT_INFO_ADM_HIST 이력생성
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			PdaService.insertGoodsProductHist_F3(goodsProductInfoAdmVo);
			
			//TB_PURCHASE_ORDER_OUTPUT_HIST, TB_PURCHASE_ORDER_ADM 수량 업데이트
			purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
			purchaseOrderOutputHistVo.setOutputQty(remainCnt);
			purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
			purchaseOrderOutputHistVo.setPoSeq(poSeq);
			purchaseOrderOutputHistVo.setPoGroup(poGroup);
			purchaseOrderAdmService.updatePurchaseOutputHistIn(purchaseOrderOutputHistVo);
			
			//TB_PURCHASE_ORDER_DTL 생성
			purchaseOrderDtl = new PurchaseOrderDtl();
			purchaseOrderDtl.setPoSeq(poSeq);
			purchaseOrderDtl.setPoGroup(poGroup);
			purchaseOrderDtl.setPoNoSeq(poNoSeq);
			purchaseOrderDtl.setGoodsCd(goodsCd);
			purchaseOrderDtl.setBoxNo(newBoxNo);
			purchaseOrderDtl.setPackCnt(Integer.parseInt(packCnt));
			purchaseOrderDtl.setOutputCnt(remainCnt);
			purchaseOrderDtl.setPoDate(faultyStatusDate.substring(0,10).replace("-", ""));
			purchaseOrderDtl.setLocationInputDate(locationInputDate);
			purchaseOrderDtl.setCompleteYn(completeYn);
			purchaseOrderDtl.setRegId(Utils.getUserId());
			purchaseOrderAdmService.createPurchaseOrderDtl(purchaseOrderDtl);
			
			/*--------------------수불 정보 관련--------------------*/
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			stockPaymentAdmVoMinus = new StockPaymentAdmVo();
			stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(goodsCd, newBoxNo, "002", "I", "008", Integer.parseInt(packCnt), factoryCode);
			stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
			/*--------------------수불 정보 관련--------------------*/
			
//				/*--------------------박스 정보 관련--------------------*/
//				//박스 정보 삭제됨에 따라 업데이트
//				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
//				goodsProductInfoAdmVo.setPoSeq(poSeq);
//				goodsProductInfoAdmVo.setPoGroup(poGroup);
//				PdaService.palletBoxDelete_F3(goodsProductInfoAdmVo);
//				//박스 정보 삭제됨에 따라 업데이트
//
//				//박스 한개 씩 기록 남기게 값 가지고 오기
//				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
//				matrlInOutWhsAdmVo.setFactoryCode(factoryCode);
//				matrlInOutWhsAdmVo.setPoSeq(poSeq);
//				matrlInOutWhsAdmVo.setPoGroup(poGroup);
//				List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmData = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
//				//박스 한개 씩 기록 남기게 값 가지고 오기
//				
//				//가지고 온 값으로 박스 한개 씩 기록 남겨두기
//				for(int i=0; i < matrlInOutWhsAdmData.size(); i++) {
//					goodsProductInfoAdmVo.setBoxNo(matrlInOutWhsAdmData.get(i).getBoxNo());
//					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
//					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
//					//해당 재고제품 INFO UPDATE
//					PdaService.insertGoodsProductHist(goodsProductInfoAdmVo); //재고제품 상태변경 이력쌓기
//					
//					/*--------------------수불 정보 관련--------------------*/
//					MatrlInOutWhsAdmVo m = matrlInOutWhsAdmData.get(i);
//					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
//					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//					stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(m.getGoodsCd().toString(), m.getBoxNo().toString(), "002", "D", "008", Integer.parseInt(m.getPackCnt().toString()), factoryCode);
//					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
//					/*--------------------수불 정보 관련--------------------*/
//				}
//				//가지고 온 값으로 박스 한개 씩 기록 남겨두기
//				/*--------------------박스 정보 관련--------------------*/
//				
//				/*--------------------파레트 정보 관련--------------------*/
//				//이후 트레이 있을 경우 Update
//				purchaseOrderAdmService.removeTrayByPallet_F3(purchaseOrderOutputHistVo);
//				//이후 트레이 있을 경우 Update
//				
//				//해당 파레트 삭제
//				purchaseOrderAdmService.deletePurchaseOrderOutputHist(purchaseOrderOutputHistVo);
//				//해당 파레트 삭제
//				
//				//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
//				PurchaseOrderDtl deletePurchaseOrderDtl = new PurchaseOrderDtl();
//				deletePurchaseOrderDtl.setPoSeq(poSeq);
//				deletePurchaseOrderDtl.setPoGroup(poGroup);
//				purchaseOrderAdmService.deletePurchaseOrderDtl(deletePurchaseOrderDtl);
//				//해당 poSeq, poGroup, boxNo 의 출하기록 삭제
//				/*--------------------파레트 정보 관련--------------------*/
//				
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//고객사LotNo 수정
	@RequestMapping(value = "/io/customerLotNoUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> customerLotNoUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("고객사LotNo 수정 :  " + goodsProductInfoAdmVo);
			//고객사LotNo 수정
			goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			PdaService.customerLotNoUpdate_F3(goodsProductInfoAdmVo);
			
			//재고제품 상태변경 이력쌓기
			PdaService.insertGoodsProductHist(goodsProductInfoAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
	
	//잔량이력관리 조회
	@RequestMapping(value = "/io/remainQtyHistory", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> remainQtyHistory(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("잔량이력관리 조회 : " + matrlInOutWhsAdmVo);
			List<MatrlInOutWhsAdmVo> remainQtyHistoryList = matrlInOutWhsAdmService.remainQtyHistory(matrlInOutWhsAdmVo);
			jsonData.put("data", remainQtyHistoryList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("잔량이력관리 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	//파레트 삭제
	@RequestMapping(value = "/io/palletDelete_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletDelete_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("파레트 삭제 : " + purchaseOrderAdmVo);
			
			String poSeq = purchaseOrderAdmVo.getPoSeq();
			String poGroup = purchaseOrderAdmVo.getPoGroup();
			int outputQty = purchaseOrderAdmVo.getOutputQty();
			
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			matrlInOutWhsAdmVo.setPoSeq(poSeq);
			matrlInOutWhsAdmVo.setPoGroup(poGroup);
			
			List<MatrlInOutWhsAdmVo> dtlList = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
			
			//TB_PURCHASE_ORDER_ADM 수량 업데이트
			purchaseOrderAdmVo = new PurchaseOrderAdmVo();
			purchaseOrderAdmVo.setOutputQty(outputQty);
			purchaseOrderAdmVo.setRemainQty(outputQty);
			purchaseOrderAdmVo.setUpdId(Utils.getUserId());
			purchaseOrderAdmVo.setPoSeq(poSeq);
			purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
			
			//TB_GOODS_PRODUCT_INFO_ADM 초기상태 업데이트
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setPoSeq(poSeq);
			goodsProductInfoAdmVo.setPoGroup(poGroup);
			PdaService.palletBoxDelete_F3(goodsProductInfoAdmVo);
			
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			PdaService.insertGoodsProductHist_F3_2(goodsProductInfoAdmVo);
			
			/*--------------------수불 정보 관련--------------------*/
			for(int i=0; i<dtlList.size(); i++) {
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
				stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(i).getGoodsCd(), dtlList.get(i).getBoxNo(), "002", "I", "007", Integer.parseInt(dtlList.get(i).getPackCnt()), factoryCode);
				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
			}
			
			/*--------------------수불 정보 관련--------------------*/
			
			purchaseOrderAdmVo.setPoGroup(poGroup);
			purchaseOrderAdmService.palletDelete(purchaseOrderAdmVo);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}	
	
	
	//파레트 단위 출하 취소
	@RequestMapping(value = "/io/palletOutputCancel_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> palletOutputCancel_F3(@RequestBody List<Map<String, Object>> cancelList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("파레트 삭제 : " + cancelList);
			
			String poSeq = cancelList.get(0).get("poSeq").toString();
			String poGroup = cancelList.get(0).get("poGroup").toString();
			int outputQty = Integer.parseInt(cancelList.get(0).get("outputQty").toString());
			int dtlCount = Integer.parseInt(cancelList.get(0).get("dtlCount").toString());
			
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			matrlInOutWhsAdmVo.setPoSeq(poSeq);
			matrlInOutWhsAdmVo.setPoGroup(poGroup);
			
			List<MatrlInOutWhsAdmVo> dtlList = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
			
			//dtlCount 사용하여 count 비교하기!!
			PurchaseOrderDtl purchaseOrderDtlCheck = new PurchaseOrderDtl();
			purchaseOrderDtlCheck.setPoSeq(poSeq);
			purchaseOrderDtlCheck.setPoGroup(poGroup);
			int dtlCountCheck = purchaseOrderAdmService.purchaseOrderDtlDeleteCheck(purchaseOrderDtlCheck);
			
			//개수가 변경되었으면 출하 처리 취소(이미 누군가 삭제하였음)
			if ( dtlCount != dtlCountCheck ) {
				jsonData.put("message", "가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
				jsonData.put("result", "fail");
				return jsonData;
			} 

			//TB_GOODS_PRODUCT_INFO_ADM 업데이트
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			goodsProductInfoAdmVo.setPoSeq(poSeq);
			goodsProductInfoAdmVo.setPoGroup(poGroup);
			PdaService.palletCancel_F3(goodsProductInfoAdmVo);
			
			//TB_GOODS_PRODUCT_INFO_ADM 이력 생성
			goodsProductInfoAdmVo.setHistId(Utils.getUserId());
			PdaService.insertGoodsProductHist_F3_2(goodsProductInfoAdmVo);
			
			/*--------------------수불 정보 관련--------------------*/
			for(int i=0; i<dtlList.size(); i++) {
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
				stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(i).getGoodsCd(), dtlList.get(i).getBoxNo(), "002", "I", "008", Integer.parseInt(dtlList.get(i).getPackCnt()), factoryCode);
				stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
			}
			
			/*--------------------수불 정보 관련--------------------*/
			
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//수입검사관리 문서 등록
	@RequestMapping(value="qm/matrlInOutReportUpload", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> matrlInOutReportUpload(MultipartHttpServletRequest multi, MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("문서관리 등록 :"+matrlInOutWhsAdmVo);
		try {
			
			String newFileName	= "";
			String fileYear		= matrlInOutWhsAdmVo.getInWhsDate();
			String path 		= matrlInOutReport + "/" + fileYear;
			String lotNo		= "";
			String fileGroup	= matrlInOutWhsAdmVo.getFileGroup();
			
			//파일이 처음 등록하는 경우
			if( fileGroup == null || fileGroup.equals("") || fileGroup.equals("null")) {
				//lot별 파일 구분자
				MatrlInOutWhsAdmVo maxGroupNum = new MatrlInOutWhsAdmVo();
				maxGroupNum	= matrlInOutWhsAdmService.matrlInOutReporFileGroupMaxNum(matrlInOutWhsAdmVo);
				fileGroup	= maxGroupNum.getFileGroup();				
			}
			
			File dir = new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			

			File[] fileList = dir.listFiles();

			// 파일이 존재하는 경우 삭제
			if (fileList != null) {
			    for (File file : fileList) {
			        String name = file.getName(); // 파일 이름 (확장자 포함)
			        if (name.contains(fileGroup)) {
			            // 파일이 존재하는 경우 삭제
			        	file.delete();
			            break;
			        }
			    }
			}
			// 파일이 존재하는 경우 삭제
			
			MultipartFile mFile	= multi.getFile("file");
			String fileName		= mFile.getOriginalFilename();
			
			if(!(fileName == null || fileName.equals("") )) {
				newFileName =  fileGroup + "." + fileName.substring(fileName.lastIndexOf(".")+1);
				matrlInOutWhsAdmVo.setFileNm(fileName);
				matrlInOutWhsAdmVo.setFileGroup(fileGroup);
				
				try {
					mFile.transferTo(new File(path+"/"+newFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
			matrlInOutWhsAdmService.matrlInOutReportUpload(matrlInOutWhsAdmVo);
			logger.info("등록 후 Vo : " +matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	
	//수입검사관리 문서 다운로드
	@RequestMapping(value = "qm/matrlInOutReportDownload", method = RequestMethod.GET)
	public @ResponseBody void matrlInOutReportDownload(HttpServletResponse res, HttpServletRequest req,
		    @RequestParam(value = "lotNo") String lotNo,
		    @RequestParam(value = "fileNm") String fileNm,
		    @RequestParam(value = "fileGroup") String fileGroup,
		    @RequestParam(value = "inWhsDate") String year,
		    MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		try {

			String dFile="";
			
			dFile = fileNm;

			String newFileName = fileGroup;

			String path = matrlInOutReport +"/"+ year + "/" + newFileName + "." + fileNm.substring(fileNm.lastIndexOf(".")+1);

			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
				dFile = new String(dFile.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + dFile + "\";");

			FileInputStream fis 		= new FileInputStream(file);
			BufferedInputStream bis		= new BufferedInputStream(fis);
			ServletOutputStream so		= res.getOutputStream();
			BufferedOutputStream bos	= new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	//박스 반품처리 & 박스 삭제 처리
	@RequestMapping(value = "/io/boxDispose_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> boxDispose_F3(@RequestBody List<Map<String, Object>>  returnList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("폐기 박스 : " + returnList);
			
			if(returnList.get(0).get("dtlCount") != null) {
				jsonData.put("result", "ok");
				int dtlCount = Integer.parseInt(returnList.get(0).get("dtlCount").toString());
				String poSeqChk = returnList.get(0).get("poSeq").toString();
				String poGroupChk = returnList.get(0).get("poGroup").toString();

				//dtlCount 사용하여 count 비교하기!!
				PurchaseOrderDtl purchaseOrderDtlCheck = new PurchaseOrderDtl();
				purchaseOrderDtlCheck.setPoSeq(poSeqChk);
				purchaseOrderDtlCheck.setPoGroup(poGroupChk);
				int dtlCountCheck = purchaseOrderAdmService.purchaseOrderDtlDeleteCheck(purchaseOrderDtlCheck);
				
				//개수가 변경되었으면 반품 처리 취소(이미 누군가 삭제하였음)
				if ( dtlCount != dtlCountCheck ) {
					jsonData.put("message", "가장 최근에 출고된 정보가 변경되었습니다.<br>확인 후 다시 선택해 주세요!");
					jsonData.put("result", "error");
					return jsonData;
				} 
				
				MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setPoSeq(poSeqChk);
				matrlInOutWhsAdmVo.setPoGroup(poGroupChk);
				
				List<MatrlInOutWhsAdmVo> dtlListChk = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
			
				if("003".equals(dtlListChk.get(0).getGoodsStatus())) {
					jsonData.put("message", "이미 출고된 제품은 폐기처리 할 수 없습니다.");
					jsonData.put("result", "error");
					return jsonData;
				}
				
				for(Map<String, Object> m : returnList) {
					String poSeq = m.get("poSeq").toString();
					String poGroup = m.get("poGroup").toString();
					String returnboxNo = m.get("returnBoxNo").toString();
					String goodsStatus = m.get("goodsStatus").toString();
					String faultyStatusDate = m.get("faultyStatusDate").toString();
					String faultyStatus = m.get("faultyStatus").toString();
				
					MatrlInOutWhsAdmVo matrlInOutWhsAdmVo2 = new MatrlInOutWhsAdmVo();
					matrlInOutWhsAdmVo2.setPoSeq(poSeq);
					matrlInOutWhsAdmVo2.setPoGroup(poGroup);
					matrlInOutWhsAdmVo2.setBoxNo(returnboxNo);
					
					List<MatrlInOutWhsAdmVo> dtlList = matrlInOutWhsAdmService.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo2);
					
					int outputCnt = Integer.parseInt(dtlList.get(0).getOutputCnt());
					
					//TB_PURCHASE_ORDER_ADM 수량 업데이트
					PurchaseOrderAdmVo purchaseOrderAdmVo = new PurchaseOrderAdmVo();
					purchaseOrderAdmVo.setOutputQty(outputCnt);
					purchaseOrderAdmVo.setRemainQty(outputCnt);
					purchaseOrderAdmVo.setUpdId(Utils.getUserId());
					purchaseOrderAdmVo.setPoSeq(poSeq);
					purchaseOrderAdmService.updatePurchaseAdmOutputCancel(purchaseOrderAdmVo);
					
					//TB_PURCHASE_ORDER_OUTPUT_HIST 수량 업데이트
					PurchaseOrderOutputHistVo purchaseOrderOutputHistVo = new PurchaseOrderOutputHistVo();
					purchaseOrderOutputHistVo.setCancelOutputSum(outputCnt);
					purchaseOrderOutputHistVo.setUpdId(Utils.getUserId());
					purchaseOrderOutputHistVo.setPoSeq(poSeq);
					purchaseOrderOutputHistVo.setPoGroup(poGroup);
					purchaseOrderAdmService.updatePurchaseOutputHist(purchaseOrderOutputHistVo);
					
					//TB_GOODS_PRODUCT_INFO_ADM 부적합(대기) 상태 업데이트
					GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
					goodsProductInfoAdmVo.setBoxNo(returnboxNo);
					goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
					goodsProductInfoAdmVo.setRemainCnt(outputCnt);
					goodsProductInfoAdmVo.setGoodsStatus(goodsStatus);
					goodsProductInfoAdmVo.setFaultyStatusDate(faultyStatusDate);
					goodsProductInfoAdmVo.setFaultyStatus(faultyStatus);
					PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
					
					goodsProductInfoAdmVo.setHistId(Utils.getUserId());
					PdaService.insertGoodsProductHist_F3(goodsProductInfoAdmVo);
					
					goodsProductInfoAdmVo.setGoodsStatus("002");
					goodsProductInfoAdmVo.setFaultyStatus("006");
					PdaService.boxReturnUpdate(goodsProductInfoAdmVo);
					
					//TB_PURCHASE_ORDER_DTL 박스 삭제
					PurchaseOrderDtl purchaseOrderDtl = new PurchaseOrderDtl();
					purchaseOrderDtl.setPoSeq(poSeq);
					purchaseOrderDtl.setPoGroup(poGroup);
					purchaseOrderDtl.setBoxNo(returnboxNo);
					purchaseOrderAdmService.deletePurchaseOrderDtl(purchaseOrderDtl);
					
					/*--------------------수불 정보 관련--------------------*/
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					//StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					//stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(0).getGoodsCd().toString(), returnboxNo, "002", "I", "010", Integer.parseInt(dtlList.get(0).getPackCnt().toString()), factoryCode);
					//stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus);	//기존 재고 -
					/*--------------------수불 정보 관련--------------------*/
					
					/*--------------------수불 정보 관련--------------------*/
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					stockPaymentAdmVoMinus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(0).getGoodsCd().toString(), returnboxNo, "002", "O", "008", Integer.parseInt(dtlList.get(0).getPackCnt().toString()), factoryCode);
					stockPaymentAdmService.stockPaymentMinus(stockPaymentAdmVoMinus);	//기존 재고 -
					/*--------------------수불 정보 관련--------------------*/
					
					
					/*--------------------수불 정보 관련--------------------*/
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					stockPaymentAdmVoPlus= StockPaymentAdmController.goodsStockPaymentHist(dtlList.get(0).getGoodsCd().toString(), returnboxNo, "002", "I", "011", Integer.parseInt(dtlList.get(0).getPackCnt().toString()), factoryCode);
					stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//폐기창고 재고 +
					/*--------------------수불 정보 관련--------------------*/
				}
		
				
			}
			
		
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	

	
	
}