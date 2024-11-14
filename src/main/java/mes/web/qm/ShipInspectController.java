package mes.web.qm;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.apache.poi.hpsf.Array;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.ProductionPerfTrayVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.ShipInspectTempListVo;
import mes.domain.qm.ShipInspectVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.GoodsPackService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.qm.ShipInspectService;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ShipInspectController {
	
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
	private ShipInspectService shipInspectService;
	@Inject
	private GoodsPackService goodsPackService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	int appearFaultyCnt = 0;
	private static final Logger logger = LoggerFactory.getLogger(ShipInspectController.class);	
	

	
	//품질관리 -출하검사
	@RequestMapping(value = "/qmsc0180", method = RequestMethod.GET)
	public String qmsc0180(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 -출하검사");
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
		
		systemCommonCodeVo.setBaseGroupCd("018"); // 포장 오더구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("boxOrdGubunCd", systemCommonCodeList);
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인한 유저 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인한 유저 번호
		
		return "qm/qmsc0180";
	}
	
	//품질관리 -출하검사(1공장
	@RequestMapping(value = "/qmsc1180", method = RequestMethod.GET)
	public String qmsc1180(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 -출하검사");
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
		
		systemCommonCodeVo.setBaseGroupCd("018"); // 포장 오더구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("boxOrdGubunCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인한 유저 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인한 유저 번호
		
		return "qm/qmsc1180";
	}
	
	//생산관리 -재검등록
	@RequestMapping(value = "/wmsc0150", method = RequestMethod.GET)
	public String wmsc0150(Locale locale, Model model) throws Exception {
		
		logger.info("생산관리 -재검등록");
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
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	//서버시간 오늘날짜
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인한 유저 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인한 유저 번호
		
		return "wm/wmsc0150";
	}
	
	//생산관리 -재검등록
	@RequestMapping(value = "/wmsc1150", method = RequestMethod.GET)
	public String wmsc1150(Locale locale, Model model) throws Exception {
		
		logger.info("생산관리 -재검등록");
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
		model.addAttribute("userNm", Utils.getUserNm() );	// 로그인한 유저 이름
		model.addAttribute("userNumber", Utils.getUserNumber() );	// 로그인한 유저 번호
		
		return "wm/wmsc1150";
	}
	
	//품질관리 출하검사 트레이 리스트
	@RequestMapping(value = "/qm/shipInspSelectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspSelectList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 트레이 리스트");
		try {
			List<ShipInspectVo> list = shipInspectService.shipInspSelectList(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 트레이 리스트");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 출하검사 트레이 리스트 이력조회
	@RequestMapping(value = "/qm/shipListRecord", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipListRecord(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 출하검사 트레이 리스트 이력조회");
		try {
			List<ShipInspectVo> list = shipInspectService.shipListRecord(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("품질관리 출하검사 트레이 리스트 이력조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 출하재검사 트레이 리스트 이력조회
	@RequestMapping(value = "/qm/shipListRecordDtl", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipListRecordDtl(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질관리 출하재검사 트레이 리스트 이력조회");
		try {
			List<ShipInspectVo> list = shipInspectService.shipListRecordDtl(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("품질관리 출하재검사 트레이 리스트 이력조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//출하검사 메인  조회
	@RequestMapping(value = "/qm/shipInspAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspAdmRead(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 메인 조회");
		try {				
			List<ShipInspectVo> list = shipInspectService.shipInspAdmRead(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 메인 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//SLD 재검등록 전 기록 불러오기
	@RequestMapping(value = "/qm/shipInspAdmReadSLDReInsp", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspAdmReadSLDReInsp(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 메인 조회");
		try {				
			List<ShipInspectVo> list = shipInspectService.shipInspAdmRead(shipInspectVo);
			if(list.size() == 1) {
				if(list.get(0).getInspDate() == null && list.get(0).getSeq().equals("1")) {
					shipInspectVo.setReInspStatus("001");
					list = shipInspectService.shipInspAdmRead(shipInspectVo);
					jsonData.put("listSeq", "first");
				} else if(list.get(0).getInspDate() == null && !list.get(0).getSeq().equals("1")){
					shipInspectVo.setReInspStatus("003");
					String seq = shipInspectService.selectTraySeq(shipInspectVo);
					int seqInt = Integer.parseInt(seq) - 1;
					shipInspectVo.setSeq(Integer.toString(seqInt));
					list = shipInspectService.shipInspAdmRead(shipInspectVo);
					jsonData.put("listSeq", "third");
				} else {
					jsonData.put("listSeq", "second");
				}
			}
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 메인 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사현황  조회
	@RequestMapping(value = "/qm/shipInspStatusList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspStatusList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 메인 조회");
		try {				
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);



			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("출하검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			shipInspectVo.setCodeList(codeList.substring(0,codeList.length()-1));	
			shipInspectVo.setFactoryCode(factoryCode);
			List<Map<String, String>> list;
			if(factoryCode.equals("003")) {
				list = shipInspectService.shipInspStatusList_fa3(shipInspectVo);
			} else {
				list = shipInspectService.shipInspStatusList(shipInspectVo);
			}
			
			List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
			
			for(Map<String, String> m : list) {
				ShipInspectVo shipInspectVodata = new ShipInspectVo();
				shipInspectVodata.setLabelLotNoSeq(String.valueOf(m.get("LABEL_LOT_NO_SEQ").toString()));							
				shipInspectVodata.setIdx(Integer.parseInt(String.valueOf((m.get("IDX")))));
				shipInspectVodata.setEquipNm(String.valueOf((m.get("EQUIP_NM"))));
				shipInspectVodata.setEquipCd(String.valueOf((m.get("EQUIP_CD"))));
				shipInspectVodata.setFilmLotNo(String.valueOf((m.get("FILM_LOT_NO"))));
				shipInspectVodata.setMatrlLotNo(String.valueOf((m.get("MATRL_LOT_NO"))));
				shipInspectVodata.setGoodsNm(String.valueOf((m.get("GOODS_NM"))));
				shipInspectVodata.setGoodsCd(String.valueOf((m.get("GOODS_CD"))));
				shipInspectVodata.setProductQty(Integer.parseInt(String.valueOf((m.get("PRODUCT_QTY")))));
				shipInspectVodata.setInspDate(String.valueOf(m.get("INSP_DATE")));
				shipInspectVodata.setFaultyTrayNo(String.valueOf(m.get("FAULTY_TRAY_NO")));
				shipInspectVodata.setInspStatus(String.valueOf(m.get("INSP_STATUS").toString()));
				shipInspectVodata.setReInspStatus(String.valueOf(m.get("RE_INSP_STATUS").toString()));
				shipInspectVodata.setNextGubun(String.valueOf(m.get("NEXT_GUBUN").toString()));
				shipInspectVodata.setWorkOrdNo(String.valueOf(m.get("WORK_ORD_NO").toString()));
				shipInspectVodata.setTrayWorkerId(String.valueOf(m.get("TRAY_WORKER_ID").toString()));
				shipInspectVodata.setTrayWorkerIdNm(String.valueOf(m.get("TRAY_WORKER_ID_NM")));
				shipInspectVodata.setInspChargr(String.valueOf(m.get("INSP_CHARGR").toString()));
				shipInspectVodata.setInspChargrNm(String.valueOf(m.get("INSP_CHARGR_NM").toString()));
				shipInspectVodata.setFaultyCnt(String.valueOf(m.get("FAULTY_CNT")));
				shipInspectVodata.setQutyNm(String.valueOf(m.get("QUTY_NM").toString()));
				shipInspectVodata.setDayNightCd(String.valueOf(m.get("DAY_NIGHT_CD").toString()));
				shipInspectVodata.setProductDate(String.valueOf(m.get("PRODUCT_DATE")));
				shipInspectVodata.setUpdDate(String.valueOf(m.get("UPD_DATE")));
				shipInspectVodata.setDepartmentCd(String.valueOf(m.get("DEPARTMENT_CD")));
				shipInspectVodata.setDisStatus(String.valueOf(m.get("DIS_STATUS")));
				
				shipInspectVodata.setProductDateMm(String.valueOf(m.get("PRODUCT_DATE_MM")));
				shipInspectVodata.setProductDateWw(String.valueOf(m.get("PRODUCT_DATE_WW")));
				
				shipInspectVodata.setSampleCnt(String.valueOf(m.get("SAMPLE_CNT").toString()));
			
				if(factoryCode.equals("003")) {
					shipInspectVodata.setThreeTrayWeight(String.valueOf(m.get("THREE_TRAY_WEIGHT")));
					shipInspectVodata.setThreeTrayWeightCheck(String.valueOf(m.get("THREE_TRAY_WEIGHT_CHECK")));
				}
				
				shipInspectVodata.setFaultyGubun(String.valueOf(m.get("FAULTY_GUBUN").toString()));
				shipInspectVodata.setInspProductQty(String.valueOf(m.get("INSP_PRODUCT_QTY")));
				
				shipInspectVodata.setInspGubun(String.valueOf(m.get("INSP_GUBUN")));
				shipInspectVodata.setReInspSystem(String.valueOf(m.get("RE_INSP_SYSTEM")));
				shipInspectVodata.setInspDesc(String.valueOf(m.get("INSP_DESC")));
				
				
				shipInspectVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				shipInspectVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				dataList.add(shipInspectVodata);
			}
			
		
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사현황 메인 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	
	
	//출하검사현황  조회
	@RequestMapping(value = "/qm/shipInspStatusTempListF3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspStatusTempListF3(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {				
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			
			List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				//logger.info("출하검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			
			shipInspectVo.setCodeList(codeList.substring(0,codeList.length()-1));	
			shipInspectVo.setFactoryCode(factoryCode);
			List<Map<String, String>> list = shipInspectService.shipInspStatusList_fa3(shipInspectVo);
			
			//신규 변수
			ArrayList<HashMap<String, Object>> jsonArr = new ArrayList<>();
			HashMap<String, Object> jsonObj = new HashMap<String, Object>();
			
			for(Map<String, String> m : list) {
				//필요한 부분
				//jsonObj = new JSONObject();
				jsonObj = new HashMap<>();
				
				jsonObj.put("labelLotNoSeq", String.valueOf(m.get("LABEL_LOT_NO_SEQ")));
				jsonObj.put("idx", String.valueOf(m.get("IDX")));
				jsonObj.put("equipNm", String.valueOf(m.get("EQUIP_NM")));
				jsonObj.put("equipCd", String.valueOf(m.get("EQUIP_CD")));
				jsonObj.put("filmLotNo", String.valueOf(m.get("FILM_LOT_NO")));
				jsonObj.put("matrlLotNo", String.valueOf(m.get("MATRL_LOT_NO")));
				jsonObj.put("goodsNm", String.valueOf(m.get("GOODS_NM")));
				jsonObj.put("goodsCd", String.valueOf(m.get("GOODS_CD")));
				jsonObj.put("productQty", String.valueOf(m.get("PRODUCT_QTY")));
				jsonObj.put("inspDate", String.valueOf(m.get("INSP_DATE")));
				jsonObj.put("faultyTrayNo", String.valueOf(m.get("FAULTY_TRAY_NO")));
				jsonObj.put("inspStatus", String.valueOf(m.get("INSP_STATUS")));
				jsonObj.put("reInspStatus", String.valueOf(m.get("RE_INSP_STATUS")));
				jsonObj.put("nextGubun", String.valueOf(m.get("NEXT_GUBUN")));
				jsonObj.put("workOrdNo", String.valueOf(m.get("WORK_ORD_NO")));
				jsonObj.put("trayWorkerId", String.valueOf(m.get("TRAY_WORKER_ID")));
				jsonObj.put("trayWorkerIdNm", String.valueOf(m.get("TRAY_WORKER_ID_NM")));
				jsonObj.put("inspChargr", String.valueOf(m.get("INSP_CHARGR")));
				jsonObj.put("inspChargrNm", String.valueOf(m.get("INSP_CHARGR_NM")));
				jsonObj.put("faultyCnt", String.valueOf(m.get("FAULTY_CNT")));
				jsonObj.put("qutyNm", String.valueOf(m.get("QUTY_NM")));
				jsonObj.put("dayNightCd", String.valueOf(m.get("DAY_NIGHT_CD")));
				jsonObj.put("productDate", String.valueOf(m.get("PRODUCT_DATE")));
				jsonObj.put("updDate", String.valueOf(m.get("UPD_DATE")));
				jsonObj.put("departmentCd", String.valueOf(m.get("DEPARTMENT_CD")));
				jsonObj.put("disStatus", String.valueOf(m.get("DIS_STATUS")));
				jsonObj.put("productDateMm", String.valueOf(m.get("PRODUCT_DATE_MM")));
				jsonObj.put("productDateWw", String.valueOf(m.get("PRODUCT_DATE_WW")));
				jsonObj.put("sampleCnt", String.valueOf(m.get("SAMPLE_CNT")));
				jsonObj.put("threeTrayWeight", String.valueOf(m.get("THREE_TRAY_WEIGHT")));
				jsonObj.put("threeTrayWeightCheck", String.valueOf(m.get("THREE_TRAY_WEIGHT_CHECK")));
				
				jsonObj.put("faultyGubun", String.valueOf(m.get("FAULTY_GUBUN")));
				jsonObj.put("inspProductQty", String.valueOf(m.get("INSP_PRODUCT_QTY")));
				jsonObj.put("inspGubun", String.valueOf(m.get("INSP_GUBUN")));
				jsonObj.put("reInspSystem", String.valueOf(m.get("RE_INSP_SYSTEM")));
				jsonObj.put("inspDesc", String.valueOf(m.get("INSP_DESC")));
				//필요한 부분
			
				//140까지 담아주는 데이터  값
				for( int i = 0; i < 140; i++ ) {
					if( m.get(codeListArray[(i)]) != null && !"".equals(m.get(codeListArray[(i)])) ) {
						jsonObj.put("faulty"+(i+1), String.valueOf(m.get(codeListArray[(i)])));						
					}
				}
				//140까지 담아주는 데이터  값
				
				jsonArr.add(jsonObj);
			}
			logger.info("데이터 담기 완료");
			jsonData.put("data", jsonArr);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사현황 메인 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	//출하검사 현황(상세) 조회
	@RequestMapping(value = "/qm/shipInspStatusDetailList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspStatusDetailList(ShipInspectTempListVo shipInspectTempListVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 현황(상세) 조회");
		try {
			shipInspectTempListVo.setFactoryCode(factoryCode);
			List<ShipInspectTempListVo> list = shipInspectService.shipInspStatusDetailList(shipInspectTempListVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 현황(상세) 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//출하검사 세부내역 조회
	@RequestMapping(value = "/qm/shipInspDtlRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspDtlRead(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 세부내역 조회");
		try {
			List<ShipInspectVo> admList = shipInspectService.shipInspAdmRead(shipInspectVo);
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			if(admList.size() != 0) {
				 list = shipInspectService.shipInspDtlRead(admList.get(0));
			} 
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 세부내역 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사 세부내역 조회
	@RequestMapping(value = "/qm/shipInspDtlRead_fn3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspDtlRead_fn3(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 세부내역 조회");
		try {
			List<ShipInspectVo> admList = shipInspectService.shipInspAdmRead(shipInspectVo);
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			if(admList.size() != 0) {
				 list = shipInspectService.shipInspDtlRead(admList.get(0));
			} 
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 세부내역 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사 등록
	@RequestMapping(value = "qm/shipInspectCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectCreate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 등록");
		try {

			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();
			String reInspStatus 	= inspectList.get(0).get("reInspStatus").toString();
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String productDate		= inspectList.get(0).get("productDate").toString();
			String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setTrayNo1(trayNo + "-1");
			shipInspectAdmVo.setTrayNo2(trayNo + "-2");
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setNextGubun("001");
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setInspGubun(inspGubun);
			

			shipInspectAdmVo.setRegId(thisId);
			
			shipInspectService.shipAdmCreate(shipInspectAdmVo);
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}					


			logger.info("출하검사 불량 등록 성공");
			jsonData.put("message", "출하검사 등록되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하검사 등록");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	// 출하검사 수정
	@RequestMapping(value = "qm/shipInspectUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectUpdate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 수정");
		try {
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();
			String reInspStatus 	= inspectList.get(0).get("reInspStatus").toString();
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String seq				= inspectList.get(0).get("seq").toString();
			String inspDesc			= inspectList.get(0).get("inspDesc").toString();
			String sampleCnt		= inspectList.get(0).get("sampleCnt").toString();
			String productDate		= inspectList.get(0).get("productDate").toString();
			String nextGubun		= inspectList.get(0).get("nextGubun").toString();
			//String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setRegId(thisId);
			shipInspectAdmVo.setNextGubun(nextGubun);
			shipInspectAdmVo.setSeq(seq);			
			shipInspectAdmVo.setInspDesc(inspDesc);
			shipInspectAdmVo.setSampleCnt(sampleCnt);
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setInspGubun("001");
			
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			shipInspectAdmVo.setIdx(Integer.parseInt(shipInspIdx));
			shipInspectService.shipAdmUpdate(shipInspectAdmVo);
			shipInspectService.shipDtlDelete(shipInspectAdmVo);
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}					
	
	
			logger.info("출하검사 불량 수정 성공");
			jsonData.put("message", "출하검사 등록되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하검사 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
	
		return jsonData;
	}
	
	// 출하검사 수정
	@RequestMapping(value = "qm/shipInspectUpdate_Fn3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectUpdate_Fn3(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 수정");
		try {
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();
			String reInspStatus 	= inspectList.get(0).get("reInspStatus").toString();
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String seq				= inspectList.get(0).get("seq").toString();
			String inspDesc			= inspectList.get(0).get("inspDesc").toString();
			String sampleCnt		= inspectList.get(0).get("sampleCnt").toString();
			
			String threeTrayWeight	= inspectList.get(0).get("threeTrayWeight").toString();
			String trayWeightDate	= inspectList.get(0).get("trayWeightDate").toString();
			
			String productDate		= inspectList.get(0).get("productDate").toString();
			String nextGubun		= inspectList.get(0).get("nextGubun").toString();
			String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			String reInspSystem		= inspectList.get(0).get("reInspSystem").toString();
			//String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setRegId(thisId);
			shipInspectAdmVo.setNextGubun(nextGubun);
			shipInspectAdmVo.setSeq(seq);			
			shipInspectAdmVo.setInspDesc(inspDesc);
			shipInspectAdmVo.setSampleCnt(sampleCnt);
			
			shipInspectAdmVo.setThreeTrayWeight(threeTrayWeight);
			shipInspectAdmVo.setTrayWeightDate(trayWeightDate);
			
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setInspGubun(inspGubun);			
			shipInspectAdmVo.setReInspSystem(reInspSystem);
			shipInspectAdmVo.setFactoryCode("003");
			
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			shipInspectAdmVo.setIdx(Integer.parseInt(shipInspIdx));
			shipInspectService.shipAdmUpdate(shipInspectAdmVo);
			shipInspectService.shipDtlDelete(shipInspectAdmVo);
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}
			
			if("001".equals(inspStatus)) {
				//TB_GOODS_PRODUCT_INFO_ADM 부적합(대기) 상태 업데이트
				GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
				goodsProductInfoAdmVo.setBoxNo(trayNo);
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				goodsPackService.changeFaultyStatusGood(goodsProductInfoAdmVo);
				
				goodsProductInfoAdmVo.setHistId(Utils.getUserId());
				goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);
			}
	
			logger.info("출하검사 불량 수정 성공");
			jsonData.put("message", "출하검사 등록되었습니다.");
			jsonData.put("result", "ok");
	
		}
		catch (Exception e) {
			logger.info("출하검사 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
	
		return jsonData;
	}
	
	// 출하검사 수정 (1공장)
	@RequestMapping(value = "qm/shipInspectUpdateFact1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectUpdateFact1(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 수정");
		try {
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();
			String reInspStatus 	= inspectList.get(0).get("reInspStatus").toString();
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String seq				= inspectList.get(0).get("seq").toString();
			String inspDesc			= inspectList.get(0).get("inspDesc").toString();
			String sampleCnt			= inspectList.get(0).get("sampleCnt").toString();
			String productDate		= inspectList.get(0).get("productDate").toString();
			String nextGubun		= inspectList.get(0).get("nextGubun").toString();
			//String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setRegId(thisId);
			shipInspectAdmVo.setNextGubun(nextGubun);
			shipInspectAdmVo.setSeq(seq);			
			shipInspectAdmVo.setInspDesc(inspDesc);
			shipInspectAdmVo.setSampleCnt(sampleCnt);
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setInspGubun("001");
			
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			shipInspectAdmVo.setIdx(Integer.parseInt(shipInspIdx));
			shipInspectService.shipAdmUpdate(shipInspectAdmVo);
			shipInspectService.shipDtlDelete(shipInspectAdmVo);
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}					
	
	
			logger.info("출하검사 불량 수정 성공");
			jsonData.put("message", "출하검사 등록되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하검사 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
	
		return jsonData;
	}
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기
	@RequestMapping(value = "/qm/getAddLotNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getAddLotNo(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
		try {
			String trayNo = shipInspectVo.getTrayNo();
			String reInspStatus = shipInspectVo.getReInspStatus();
			//shipInspectVo = shipInspectService.getAddLotNo(shipInspectVo);		
			//shipInspectVo.setTrayNo(trayNo);
			//shipInspectVo.setReInspStatus(reInspStatus);
			shipInspectVo.setUpdId(Utils.getUserId());
			shipInspectService.shipAdmLotNoUpdate(shipInspectVo);

			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기 (재검등록)
	@RequestMapping(value = "/qm/getAddLotNo_Fn2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getAddLotNo_Fn2(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
		try {
			String trayNo = shipInspectVo.getTrayNo();
			String reInspStatus = shipInspectVo.getReInspStatus();
			String seq = shipInspectVo.getSeq();
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			HashSet<String> matrlLotSet = new HashSet<>(); //중복제거
			HashSet<String> filmLotSet = new HashSet<>(); //중복제거
			String matrlLotNo ="";
			String filmLotNo ="";
			
			if(trayNo.length() == 15) {
				productionPerfTrayVo.setLabelLotNoSeq(trayNo);
			} else {
				productionPerfTrayVo.setLabelLotNo(trayNo);
			}

			List<ProductionPerfTrayVo> list = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			shipInspectVo.setEquipCd(list.get(0).getEquipCd());
			List<ShipInspectVo> listLot =  shipInspectService.getAddLotNoList(shipInspectVo);		
			
			for(ShipInspectVo m : listLot) {
				matrlLotSet.add(m.getMatrlLotNo());
				filmLotSet.add(m.getFilmLotNo());
			}
			for(String m : matrlLotSet) {
				matrlLotNo += m + ",";
			}
			for(String m : filmLotSet) {
				filmLotNo += m + ",";
			}
			
			
			shipInspectVo.setTrayNo(trayNo);
			shipInspectVo.setReInspStatus(reInspStatus);
			shipInspectVo.setSeq(seq);
			shipInspectVo.setMatrlLotNo(matrlLotNo.substring(0,matrlLotNo.length()-1));
			shipInspectVo.setFilmLotNo(filmLotNo.substring(0,filmLotNo.length()-1));
			shipInspectVo.setUpdId(Utils.getUserId());
			shipInspectService.shipAdmLotNoUpdate(shipInspectVo);

			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기 3개 (출하검사/출하재검)
	@RequestMapping(value = "/qm/getAddLotNoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getAddLotNoList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
		try {
			String trayNo = shipInspectVo.getTrayNo();		
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			if(trayNo.length() == 15) {
				productionPerfTrayVo.setLabelLotNoSeq(trayNo);
			} else {
				productionPerfTrayVo.setLabelLotNo(trayNo);
			}
			List<ProductionPerfTrayVo> list = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			shipInspectVo.setEquipCd(list.get(0).getEquipCd());
			List<ShipInspectVo> lotLlist = shipInspectService.getAddLotNoList(shipInspectVo);		

			jsonData.put("data", lotLlist);	
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//솔브레인 재검사 Lot_No 불러오기
	@RequestMapping(value = "/qm/getReTestAddLotNoReadt_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getReTestAddLotNoReadt_F3(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("솔브레인 재검사 Lot_No 불러오기");
		try {
			shipInspectVo = shipInspectService.getReTestAddLotNoReadt_F3(shipInspectVo);
			List<ShipInspectVo> lotLlist = new ArrayList<>();
			lotLlist.add(shipInspectVo);
			jsonData.put("data", lotLlist);	
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("솔브레인 재검사 Lot_No 불러오기");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사 LOT 추가
	@RequestMapping(value = "/qm/getAddLotNoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getAddLotNoUpdate(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 LOT 추가 ");
		try {
			shipInspectVo.setUpdId(Utils.getUserId());
			shipInspectService.shipAdmLotNoUpdate(shipInspectVo);			
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 LOT 추가");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	// 출하검사 삭제
	@RequestMapping(value = "qm/shipInspectDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectDelete(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			// 입고 다음 프로세스로 넘어갔는지 체크 로직 추가 예정
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			List<ShipInspectVo> list2 = new ArrayList<ShipInspectVo>();
			List<ShipInspectVo> list001 = new ArrayList<ShipInspectVo>();
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			GoodsProductInfoAdmVo goodsProductInfoAdmVoRead = new GoodsProductInfoAdmVo();
			

	
			
			
			String shipInspIdx = "";
			shipInspectAdmVo.setIdx(shipInspectVo.getIdx());
			shipInspectAdmVo.setTrayNo(shipInspectVo.getTrayNo());
			String trayNo = shipInspectVo.getTrayNo();
			goodsProductInfoAdmVo.setBoxNo(shipInspectVo.getTrayNo());
			shipInspectAdmVo.setReInspStatus(shipInspectVo.getReInspStatus());
			
			if("001".equals(shipInspectVo.getReInspStatus())) { //삭제하지 않고 데이터만 제거.
				// 재검으로 넘어갔는지 체크
				list001 = shipInspectService.shipInspAdmRead(shipInspectVo);				
				//shipInspectVo.setReInspStatus("002");
		
				
				ShipInspectVo shipInspectAdmVo1 = new ShipInspectVo();
				ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
				shipInspectAdmVo1.setTrayNo(trayNo + "-1");
				shipInspectAdmVo1.setReInspStatus("002");
				shipInspectAdmVo2.setTrayNo(trayNo + "-2");
				shipInspectAdmVo2.setReInspStatus("002");
				
				String workOrdNo = shipInspectVo.getWorkOrdNo();
				String ordGubun = shipInspectVo.getOrdGubun();
				//packUnitNm 가 홀수이면??
				int packCnt = Integer.parseInt(shipInspectVo.getPackUnitNm()) / 2;
				
				WorkOrderVo readWorkOrderVo = new WorkOrderVo();
				readWorkOrderVo.setWorkOrdNo(workOrdNo);
				readWorkOrderVo = workOrderService.read(readWorkOrderVo);
				String goodsCd = readWorkOrderVo.getGoodsCd();
				
				
				list = shipInspectService.shipInspAdmRead(shipInspectAdmVo1);
				list2 = shipInspectService.shipInspAdmRead(shipInspectAdmVo2);
				
					
				//재검으로 넘어갔다면
				if((list.size() != 0 || list2.size() != 0)) {
					//삭제 실패
					if((list.get(0).getInspDate() == null && list2.get(0).getInspDate() == null)) {
						goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
						//포장이 안되어 있으면
						if(goodsProductInfoAdmVoRead == null) {
							//삭제 성공
							
							
							shipInspectAdmVo.setWorkOrdNo(list001.get(0).getWorkOrdNo());
							shipInspectAdmVo.setMatrlLotNo(list001.get(0).getMatrlLotNo());
							shipInspectAdmVo.setFilmLotNo(list001.get(0).getFilmLotNo());						
							shipInspectAdmVo.setReInspStatus("001");
							shipInspectAdmVo.setFaultyCnt("0");
							shipInspectAdmVo.setUpdId(Utils.getUserId());
							shipInspectAdmVo.setNextGubun("001");	
							
							shipInspectService.shipAdmUpdate(shipInspectAdmVo);
							shipInspectService.shipDtlDelete(shipInspectAdmVo);
						
							goodsProductInfoAdmVo.setBoxNo(trayNo + "-1");
							goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
							
							goodsProductInfoAdmVo.setBoxNo(trayNo + "-2");
							goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
							
							StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
							stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
							stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
							
							shipInspectService.shipAdmDelete(list.get(0));
							shipInspectService.shipDtlDelete(list.get(0));
							shipInspectService.shipAdmDelete(list2.get(0));
							shipInspectService.shipDtlDelete(list2.get(0));
							
							
							jsonData.put("result", "ok");
						}
						//포장이 되어있으면
						else {
							//포장상태라면 삭제가능
							if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus())) {
								shipInspectAdmVo.setWorkOrdNo(list001.get(0).getWorkOrdNo());
								shipInspectAdmVo.setMatrlLotNo(list001.get(0).getMatrlLotNo());
								shipInspectAdmVo.setFilmLotNo(list001.get(0).getFilmLotNo());						
								shipInspectAdmVo.setReInspStatus("001");
								shipInspectAdmVo.setFaultyCnt("0");
								shipInspectAdmVo.setUpdId(Utils.getUserId());
								shipInspectAdmVo.setNextGubun("001");	
								
								shipInspectService.shipAdmUpdate(shipInspectAdmVo);
								shipInspectService.shipDtlDelete(shipInspectAdmVo);
								
								goodsProductInfoAdmVo.setBoxNo(trayNo + "-1");
								goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
								goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
								goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
								
								goodsProductInfoAdmVo.setBoxNo(trayNo + "-2");
								goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
								goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
								goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
								
								StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
								stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
								stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
								stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
								stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
								
								shipInspectService.shipAdmDelete(list.get(0));
								shipInspectService.shipDtlDelete(list.get(0));
								shipInspectService.shipAdmDelete(list2.get(0));
								shipInspectService.shipDtlDelete(list2.get(0));
								
								jsonData.put("result", "ok");
							} else {
								jsonData.put("result", "fail");
								jsonData.put("message", "이미 입고/출고가 완료된 제품입니다.");
							}

						}					

				
					} else {
						jsonData.put("result", "fail");
						jsonData.put("message", "재검등록 먼저 삭제해 주세요.");
					}
					
				}
				//재검으로 안 넘어갔다면
				else {
					
					goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
					//포장이 안되어 있으면
					if(goodsProductInfoAdmVoRead == null) {
						//삭제 성공
						
						
						shipInspectAdmVo.setWorkOrdNo(list001.get(0).getWorkOrdNo());
						shipInspectAdmVo.setMatrlLotNo(list001.get(0).getMatrlLotNo());
						shipInspectAdmVo.setFilmLotNo(list001.get(0).getFilmLotNo());						
						shipInspectAdmVo.setReInspStatus("001");
						shipInspectAdmVo.setFaultyCnt("0");
						shipInspectAdmVo.setUpdId(Utils.getUserId());
						shipInspectAdmVo.setNextGubun("001");	
						
						shipInspectService.shipAdmUpdate(shipInspectAdmVo);
						shipInspectService.shipDtlDelete(shipInspectAdmVo);
					
						goodsProductInfoAdmVo.setBoxNo(trayNo + "-1");
						goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
						goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
						goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
						
						goodsProductInfoAdmVo.setBoxNo(trayNo + "-2");
						goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
						goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
						goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
						
						StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
						stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
						stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
						stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
						stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
						
						
						
						
						jsonData.put("result", "ok");
					}
					//포장이 되어있으면
					else {
						//포장상태라면 삭제가능
						if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus())) {
							shipInspectAdmVo.setWorkOrdNo(list001.get(0).getWorkOrdNo());
							shipInspectAdmVo.setMatrlLotNo(list001.get(0).getMatrlLotNo());
							shipInspectAdmVo.setFilmLotNo(list001.get(0).getFilmLotNo());						
							shipInspectAdmVo.setReInspStatus("001");
							shipInspectAdmVo.setFaultyCnt("0");
							shipInspectAdmVo.setUpdId(Utils.getUserId());
							shipInspectAdmVo.setNextGubun("001");	
							
							shipInspectService.shipAdmUpdate(shipInspectAdmVo);
							shipInspectService.shipDtlDelete(shipInspectAdmVo);
							
							goodsProductInfoAdmVo.setBoxNo(trayNo + "-1");
							goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
							
							goodsProductInfoAdmVo.setBoxNo(trayNo + "-2");
							goodsPackService.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
							goodsPackService.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
							
							StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
							stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
							stockPaymentAdmVoMinus = StockPaymentAdmController.goodsUnPackMinus(goodsCd, workOrdNo, packCnt, factoryCode);
							stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
							
							
							
							jsonData.put("result", "ok");
						} else {
							jsonData.put("result", "fail");
							jsonData.put("message", "이미 입고/출고가 완료된 제품입니다.");
						}

					}					

				}

			} else if("002".equals(shipInspectVo.getReInspStatus())) {
				// 출하재검으로 넘어갔는지 체크
				shipInspectVo.setReInspStatus("003");
				list = shipInspectService.shipInspAdmRead(shipInspectVo);
				list2 = shipInspectService.shipInspAdmRead(shipInspectAdmVo);					
		
				//출하재검으로 넘어갔다면
				if(list.size() != 0 ) {
					//출하재검에 등록이 안되어있다면
					if(list.get(0).getInspDate() == null) {
						shipInspectAdmVo.setWorkOrdNo(list2.get(0).getWorkOrdNo());
						shipInspectAdmVo.setMatrlLotNo(list2.get(0).getMatrlLotNo());
						shipInspectAdmVo.setFilmLotNo(list2.get(0).getFilmLotNo());						
						shipInspectAdmVo.setReInspStatus("002");
						shipInspectAdmVo.setFaultyCnt("0");
						shipInspectAdmVo.setUpdId(Utils.getUserId());
						shipInspectAdmVo.setNextGubun("001");	
						
						shipInspectService.shipAdmUpdate(shipInspectAdmVo);
						shipInspectService.shipDtlDelete(shipInspectAdmVo);
						
						shipInspectService.shipAdmDelete(list.get(0));
						shipInspectService.shipDtlDelete(list.get(0));
						
						jsonData.put("result", "ok");
						
					} else {
						//삭제 실패
						jsonData.put("result", "fail");
						jsonData.put("message", "출하재검에서 먼저 삭제해 주세요.");
					}
					
				}
				//출하재검으로 안 넘어갔다면
				else {
					
					goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
					//포장이 안되어 있으면
					if(goodsProductInfoAdmVoRead == null) {
						//삭제 성공

						shipInspectAdmVo.setWorkOrdNo(list2.get(0).getWorkOrdNo());
						shipInspectAdmVo.setMatrlLotNo(list2.get(0).getMatrlLotNo());
						shipInspectAdmVo.setFilmLotNo(list2.get(0).getFilmLotNo());						
						shipInspectAdmVo.setReInspStatus("002");
						shipInspectAdmVo.setFaultyCnt("0");
						shipInspectAdmVo.setUpdId(Utils.getUserId());
						shipInspectAdmVo.setNextGubun("001");	
						
						shipInspectService.shipAdmUpdate(shipInspectAdmVo);
						shipInspectService.shipDtlDelete(shipInspectAdmVo);
						
			
						
						jsonData.put("result", "ok");
					}
					//포장이 되어있으면
					else {
						//포장상태라면 삭제가능
						if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus())) {
							
							shipInspectAdmVo.setWorkOrdNo(list2.get(0).getWorkOrdNo());
							shipInspectAdmVo.setMatrlLotNo(list2.get(0).getMatrlLotNo());
							shipInspectAdmVo.setFilmLotNo(list2.get(0).getFilmLotNo());						
							shipInspectAdmVo.setReInspStatus("002");
							shipInspectAdmVo.setFaultyCnt("0");
							shipInspectAdmVo.setUpdId(Utils.getUserId());
							shipInspectAdmVo.setNextGubun("001");	
							
							shipInspectService.shipAdmUpdate(shipInspectAdmVo);
							shipInspectService.shipDtlDelete(shipInspectAdmVo);

							
						
							
							jsonData.put("result", "ok");
						} else {
							jsonData.put("result", "fail");
							jsonData.put("message", "이미 입고/출고가 완료된 제품입니다.");
						}
					}					
				}
				
			} else {
				goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
				list2 = shipInspectService.shipInspAdmRead(shipInspectAdmVo);	
				//포장이 안되어 있으면
				if(goodsProductInfoAdmVoRead == null) {
					//삭제 성공				

					
					shipInspectAdmVo.setWorkOrdNo(list2.get(0).getWorkOrdNo());
					shipInspectAdmVo.setMatrlLotNo(list2.get(0).getMatrlLotNo());
					shipInspectAdmVo.setFilmLotNo(list2.get(0).getFilmLotNo());						
					shipInspectAdmVo.setReInspStatus("003");
					shipInspectAdmVo.setFaultyCnt("0");
					shipInspectAdmVo.setUpdId(Utils.getUserId());
					shipInspectAdmVo.setNextGubun("001");	
					
					shipInspectService.shipAdmUpdate(shipInspectAdmVo);
					shipInspectService.shipDtlDelete(shipInspectAdmVo);
					jsonData.put("result", "ok");
				}
				//포장이 되어있으면
				else {
					//포장상태라면 삭제가능
					if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus())) {
						shipInspectAdmVo.setWorkOrdNo(list2.get(0).getWorkOrdNo());
						shipInspectAdmVo.setMatrlLotNo(list2.get(0).getMatrlLotNo());
						shipInspectAdmVo.setFilmLotNo(list2.get(0).getFilmLotNo());						
						shipInspectAdmVo.setReInspStatus("003");
						shipInspectAdmVo.setFaultyCnt("0");
						shipInspectAdmVo.setUpdId(Utils.getUserId());
						shipInspectAdmVo.setNextGubun("001");	
						
						shipInspectService.shipAdmUpdate(shipInspectAdmVo);
						shipInspectService.shipDtlDelete(shipInspectAdmVo);

						
					
						jsonData.put("result", "ok");
					} else {
						jsonData.put("result", "fail");
						jsonData.put("message", "이미 입고/출고가 완료된 제품입니다.");
					}

				}										

			}



		} catch (Exception e) {
			logger.info("출하검사 삭제 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	
	//출하검사 재검으로 이관
	@RequestMapping(value = "qm/shipInspectReInspStatusUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectReInspStatusUpdate(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 재검으로 이관");
		try {

			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();		
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			list = shipInspectService.shipInspAdmRead(shipInspectVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
	
			
			String trayNo1			= list.get(0).getTrayNo1().toString();
			String trayNo2			= list.get(0).getTrayNo2().toString();
			String workOrdNo 		= list.get(0).getWorkOrdNo().toString();		
			String matrlLotNo 		= list.get(0).getMatrlLotNo().toString();
			String filmLotNo 		= list.get(0).getFilmLotNo().toString();
			String productDate 		= list.get(0).getProductDate().toString();
			//String inspGubun		= list.get(0).getInspGubun().toString();
			String reInspStatus 	= "002";
			String inspStatus 		= "002";
			String disStatus 		= "002";
			

			String thisId = Utils.getUserId();
			
			//3개짜리 트레이 1번 생성
			shipInspectAdmVo.setTrayNo(trayNo1);
			shipInspectAdmVo.setTrayNo1(trayNo1);
			shipInspectAdmVo.setTrayNo2(trayNo1);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			//shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setFaultyCnt("0");
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);		
			shipInspectAdmVo.setNextGubun("001");
			shipInspectAdmVo.setInspGubun("001");
			
			String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq);
			shipInspectService.shipAdmCreate(shipInspectAdmVo);
			
			//3개짜리 트레이 2번 생성
			shipInspectAdmVo.setTrayNo(trayNo2);
			shipInspectAdmVo.setTrayNo1(trayNo2);
			shipInspectAdmVo.setTrayNo2(trayNo2);

			seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq);
			
			shipInspectService.shipAdmCreate(shipInspectAdmVo);
			
			//재검으로 상태값 업데이트
			ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
			shipInspectAdmVo2.setIdx(list.get(0).getIdx());
			shipInspectAdmVo2.setReInspStatus("001");
			shipInspectAdmVo2.setNextGubun("002");
			shipInspectAdmVo2.setUpdId(thisId);
			shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);

			logger.info("출하검사 재검으로 이관 성공");
			jsonData.put("message", "재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하검사 재검으로 이관");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//출하검사 재검으로 이관(1공장)
	@RequestMapping(value = "qm/shipInspectReInspStatusUpdateFactory1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectReInspStatusUpdateFactory1(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사 재검으로 이관");
		try {

			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();		
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			list = shipInspectService.shipInspAdmRead(shipInspectVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
	
			
			String trayNo1			= list.get(0).getTrayNo().toString();
		
			String workOrdNo 		= list.get(0).getWorkOrdNo().toString();		
			String matrlLotNo 		= list.get(0).getMatrlLotNo().toString();
			String filmLotNo 		= list.get(0).getFilmLotNo().toString();
			String productDate 		= list.get(0).getProductDate().toString();
			//String inspGubun		= list.get(0).getInspGubun().toString();
			String reInspStatus 	= "002";
			String inspStatus 		= "002";
			String disStatus 		= "002";
			

			String thisId = Utils.getUserId();
			
			//3개짜리 트레이 1번 생성
			shipInspectAdmVo.setTrayNo(trayNo1);
			shipInspectAdmVo.setTrayNo1(trayNo1);
			shipInspectAdmVo.setTrayNo2(trayNo1);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			//shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setFaultyCnt("0");
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);		
			shipInspectAdmVo.setNextGubun("001");
			shipInspectAdmVo.setInspGubun("001");
			
			String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq);
			shipInspectService.shipAdmCreate(shipInspectAdmVo);
			/*
			 * //3개짜리 트레이 2번 생성 shipInspectAdmVo.setTrayNo(trayNo2);
			 * shipInspectAdmVo.setTrayNo1(trayNo2); shipInspectAdmVo.setTrayNo2(trayNo2);
			 * 
			 * seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			 * shipInspectAdmVo.setSeq(seq);
			 * 
			 * shipInspectService.shipAdmCreate(shipInspectAdmVo);
			 */
			
			//재검으로 상태값 업데이트
			ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
			shipInspectAdmVo2.setIdx(list.get(0).getIdx());
			shipInspectAdmVo2.setReInspStatus("001");
			shipInspectAdmVo2.setNextGubun("002");
			shipInspectAdmVo2.setUpdId(thisId);
			shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);

			logger.info("출하검사 재검으로 이관 성공");
			jsonData.put("message", "재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하검사 재검으로 이관");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//출하재검사 재검으로 이관
	@RequestMapping(value = "qm/shipInspectReInspStatusUpdateReturn", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectReInspStatusUpdateReturn(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하재검사 재검으로 이관");
		try {

			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();		
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			list = shipInspectService.shipInspAdmRead(shipInspectVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
	
			
			String trayNo1			= list.get(0).getTrayNo1().toString();
			String trayNo2			= list.get(0).getTrayNo2().toString();
			String workOrdNo 		= list.get(0).getWorkOrdNo().toString();		
			String matrlLotNo 		= list.get(0).getMatrlLotNo().toString();
			String filmLotNo 		= list.get(0).getFilmLotNo().toString();
			String productDate 		= list.get(0).getProductDate().toString();
			//String inspGubun		= list.get(0).getInspGubun().toString();
			String reInspStatus 	= "002";
			String inspStatus 		= "002";
			String disStatus 		= "002";
			

			String thisId = Utils.getUserId();
			
			//3개짜리 트레이 1번 생성
			shipInspectAdmVo.setTrayNo(trayNo1);
			shipInspectAdmVo.setTrayNo1(trayNo1);
			shipInspectAdmVo.setTrayNo2(trayNo1);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			//shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setFaultyCnt("0");
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);		
			shipInspectAdmVo.setNextGubun("001");
			//shipInspectAdmVo.setInspGubun(inspGubun);
			
			String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq);
			shipInspectService.shipAdmCreate(shipInspectAdmVo);

			//재검으로 상태값 업데이트
			ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
			shipInspectAdmVo2.setIdx(list.get(0).getIdx());
			shipInspectAdmVo2.setReInspStatus("003");
			shipInspectAdmVo2.setNextGubun("002");
			shipInspectAdmVo2.setUpdId(thisId);
			shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);

			logger.info("출하재검사 재검으로 이관 성공");
			jsonData.put("message", "재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하재검사 재검으로 이관");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//출하재검사 재검으로 이관(1공장)
	@RequestMapping(value = "qm/shipInspectReInspStatusUpdateReturnFactory1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectReInspStatusUpdateReturnFactory1(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하재검사 재검으로 이관");
		try {

			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();		
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			list = shipInspectService.shipInspAdmRead(shipInspectVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
	
			
			String trayNo1			= list.get(0).getTrayNo1().toString();
			String trayNo2			= list.get(0).getTrayNo2().toString();
			String workOrdNo 		= list.get(0).getWorkOrdNo().toString();		
			String matrlLotNo 		= list.get(0).getMatrlLotNo().toString();
			String filmLotNo 		= list.get(0).getFilmLotNo().toString();
			String productDate 		= list.get(0).getProductDate().toString();
			//String inspGubun		= list.get(0).getInspGubun().toString();
			String reInspStatus 	= "002";
			String inspStatus 		= "002";
			String disStatus 		= "002";
			

			String thisId = Utils.getUserId();
			
			//3개짜리 트레이 1번 생성
			shipInspectAdmVo.setTrayNo(trayNo1);
			shipInspectAdmVo.setTrayNo1(trayNo1);
			shipInspectAdmVo.setTrayNo2(trayNo1);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			//shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setFaultyCnt("0");
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);		
			shipInspectAdmVo.setNextGubun("001");
			//shipInspectAdmVo.setInspGubun(inspGubun);
			
			String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq);
			shipInspectService.shipAdmCreate(shipInspectAdmVo);

			//재검으로 상태값 업데이트
			ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
			shipInspectAdmVo2.setIdx(list.get(0).getIdx());
			shipInspectAdmVo2.setReInspStatus("003");
			shipInspectAdmVo2.setNextGubun("002");
			shipInspectAdmVo2.setUpdId(thisId);
			shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);

			logger.info("출하재검사 재검으로 이관 성공");
			jsonData.put("message", "재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하재검사 재검으로 이관");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산관리 재검등록 트레이 리스트
	@RequestMapping(value = "/qm/reShipInspSelectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reShipInspSelectList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리 재검등록 트레이 리스트");
		try {
			List<ShipInspectVo> list = shipInspectService.reShipInspSelectList(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 트레이 리스트");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	// 재검등록 수정
	@RequestMapping(value = "qm/reShipInspectUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reShipInspectUpdate(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재검등록 수정");
		try {
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();			
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String seq				= inspectList.get(0).get("seq").toString();
			String inspDesc			= inspectList.get(0).get("inspDesc").toString();
			String productDate		= inspectList.get(0).get("productDate").toString();
			String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			
			//String reInspStatus		= inspectList.get(0).get("reInspStatus").toString();
			String reInspStatus		= "002";
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setInspDesc(inspDesc);
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);
			shipInspectAdmVo.setUpdId(thisId);
			shipInspectAdmVo.setInspGubun(inspGubun);
		
			shipInspectAdmVo.setSeq(seq);
			
			
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			shipInspectAdmVo.setIdx(Integer.parseInt(shipInspIdx));
			shipInspectAdmVo.setNextGubun(list.get(0).getNextGubun());
			shipInspectService.shipAdmUpdate(shipInspectAdmVo);
			shipInspectService.shipDtlDelete(shipInspectAdmVo);
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}					
				
			if(list.size() != 0) {
				if("001".equals(list.get(0).getNextGubun())) {
					jsonData.put("data", "ok");
				} else {
					jsonData.put("data", "no");
				}
				
			}
	
			logger.info("출하검사 불량 수정 성공");
			jsonData.put("message", "재검 등록되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("재검 등록 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
	
		return jsonData;
	}

	// 재검등록 수정
	@RequestMapping(value = "qm/reShipInspectUpdate_fn3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reShipInspectUpdate_fn3(@RequestBody List<Map<String, Object>> inspectList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재검등록 수정");
		try {
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();		
			ShipInspectVo shipInspectDtlVo = new ShipInspectVo();
			ShipInspectVo shipInspectLotAddVo = new ShipInspectVo();
			
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();
			
			String trayNo			= inspectList.get(0).get("trayNo").toString();	
			String workOrdNo 		= inspectList.get(0).get("workOrdNo").toString();		
			String matrlLotNo 		= inspectList.get(0).get("matrlLotNo").toString();
			String filmLotNo 		= inspectList.get(0).get("filmLotNo").toString();
			String inspStatus 		= inspectList.get(0).get("inspStatus").toString();			
			String disStatus 		= "002";
			String inspDate 		= inspectList.get(0).get("inspDate").toString();
			String faultyCnt		= inspectList.get(0).get("faultyTotalCnt").toString();
			String faultyTrayNo		= inspectList.get(0).get("faultyTrayNo").toString();
			String inspChargr		= inspectList.get(0).get("inspChargr").toString();
			String dayNightGubun 	= inspectList.get(0).get("dayNightGubun").toString();
			String faultyGubun		= inspectList.get(0).get("faultyGubun").toString();
			String seq				= inspectList.get(0).get("seq").toString();
			String inspDesc			= inspectList.get(0).get("inspDesc").toString();
			String productDate		= inspectList.get(0).get("productDate").toString();
			String inspGubun		= inspectList.get(0).get("inspGubun").toString();
			//String reInspRange		= inspectList.get(0).get("reInspRange").toString();
			String reInspSystem		= inspectList.get(0).get("reInspSystem").toString();
			
			//String reInspStatus		= inspectList.get(0).get("reInspStatus").toString();
			//String reInspStatus		= "002";
			String reInspStatus		= inspectList.get(0).get("reInspStatus").toString();
			String thisId = Utils.getUserId();			
			
			shipInspectAdmVo.setTrayNo(trayNo);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);
			shipInspectAdmVo.setInspDate(inspDate);
			shipInspectAdmVo.setFaultyCnt(faultyCnt);
			shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
			shipInspectAdmVo.setInspChargr(inspChargr);
			shipInspectAdmVo.setDayNightCd(dayNightGubun);
			shipInspectAdmVo.setFaultyGubun(faultyGubun);
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setInspDesc(inspDesc);
			shipInspectAdmVo.setProductDate(productDate);
			shipInspectAdmVo.setRegId(thisId);
			shipInspectAdmVo.setUpdId(thisId);
			shipInspectAdmVo.setInspGubun(inspGubun);
			//shipInspectAdmVo.setReInspRange(reInspRange);
			shipInspectAdmVo.setReInspSystem(reInspSystem);
			shipInspectAdmVo.setFactoryCode("003");
		
			shipInspectAdmVo.setSeq(seq);
			
			
			list = shipInspectService.shipInspAdmRead(shipInspectAdmVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
			shipInspectAdmVo.setIdx(Integer.parseInt(shipInspIdx));
			shipInspectAdmVo.setNextGubun(list.get(0).getNextGubun());
			shipInspectService.shipAdmUpdate(shipInspectAdmVo);
			shipInspectService.shipDtlDelete(shipInspectAdmVo);
			
			for(Map<String,Object> m : inspectList) {
				shipInspectDtlVo = new ShipInspectVo();
				shipInspectDtlVo.setShipInspIdx(shipInspIdx);
				shipInspectDtlVo.setMajorCd(m.get("majorCd").toString());
				shipInspectDtlVo.setMinorCd(m.get("minorCd").toString());
				shipInspectDtlVo.setFaultyCnt(m.get("faultyCnt").toString());
				shipInspectDtlVo.setRegId(thisId);
				shipInspectService.shipDtlCreate(shipInspectDtlVo);				
			}
			
			//재검 Lot 불러오기
			shipInspectLotAddVo.setLabelLotNo(trayNo);
			shipInspectLotAddVo = shipInspectService.getReTestAddLotNoReadt_F3(shipInspectLotAddVo);
			
			//Lot 추가
			shipInspectLotAddVo.setTrayNo(trayNo);
			shipInspectLotAddVo.setReInspStatus(reInspStatus);
			shipInspectLotAddVo.setSeq(seq);
			shipInspectLotAddVo.setUpdId(Utils.getUserId());
			shipInspectService.shipAdmLotNoUpdate(shipInspectLotAddVo);

			if(list.size() != 0) {
				if("001".equals(list.get(0).getNextGubun())) {
					jsonData.put("data", "ok");
				} else {
					jsonData.put("data", "no");
				}
				
			}
	
			logger.info("출하검사 불량 수정 성공");
			jsonData.put("message", "재검 등록되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("재검 등록 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
	
		return jsonData;
	}
	
	//품질관리 출하재검사 트레이 리스트
	@RequestMapping(value = "/qm/reShipInspSelectList2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reShipInspSelectList2(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하재검사 트레이 리스트");
		try {
			List<ShipInspectVo> list = shipInspectService.reShipInspSelectList2(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출하검사 트레이 리스트");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//출하재검으로 이관
	@RequestMapping(value = "qm/shipInspectReInspStatusUpdate2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectReInspStatusUpdate2(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하재검으로 이관");
		try {
			
			List<ShipInspectVo> list = new ArrayList<ShipInspectVo>();		
			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			list = shipInspectService.shipInspAdmRead(shipInspectVo);
			String shipInspIdx = Integer.toString(list.get(0).getIdx());
	
			
			String trayNo1			= list.get(0).getTrayNo1().toString();

			String workOrdNo 		= list.get(0).getWorkOrdNo().toString();		
			String matrlLotNo 		= list.get(0).getMatrlLotNo().toString();
			String filmLotNo 		= list.get(0).getFilmLotNo().toString();
			String seq 				= list.get(0).getSeq().toString();
			String productDate		= list.get(0).getProductDate().toString();
			//String inspGubun		= list.get(0).getInspGubun().toString();
			String reInspStatus 	= "003";
			String inspStatus 		= "002";
			String disStatus 		= "002";

			String thisId = Utils.getUserId();
			
			//3개짜리 트레이 1번 생성
			shipInspectAdmVo.setTrayNo(trayNo1);
			shipInspectAdmVo.setTrayNo1(trayNo1);
			shipInspectAdmVo.setTrayNo2(trayNo1);
			shipInspectAdmVo.setWorkOrdNo(workOrdNo);
			shipInspectAdmVo.setMatrlLotNo(matrlLotNo);
			shipInspectAdmVo.setFilmLotNo(filmLotNo);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setDisStatus(disStatus);		
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setFaultyCnt("0");
			shipInspectAdmVo.setRegId(thisId);		
			shipInspectAdmVo.setProductDate(productDate);		
			shipInspectAdmVo.setNextGubun("001");
			//shipInspectAdmVo.setInspGubun("001");
			
			
			String seq2 = shipInspectService.selectTraySeq(shipInspectAdmVo);
			shipInspectAdmVo.setSeq(seq2);
			shipInspectService.shipAdmCreate(shipInspectAdmVo);			

			//출하재검으로 상태값 업데이트
			ShipInspectVo shipInspectAdmVo2 = new ShipInspectVo();
			shipInspectAdmVo2.setIdx(list.get(0).getIdx());
			//shipInspectAdmVo2.setReInspStatus("002");
			shipInspectAdmVo2.setReInspStatus(list.get(0).getReInspStatus().toString());
			shipInspectAdmVo.setSeq(seq);
			shipInspectAdmVo2.setNextGubun("002");
			shipInspectAdmVo2.setUpdId(thisId);
			shipInspectService.shipAdmReInspStatUpdate(shipInspectAdmVo2);

			logger.info("출하재검으로 이관 성공");
			jsonData.put("message", "출하재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				


			logger.info("출하재검으로 이관 성공");
			jsonData.put("message", "출하재검으로 이관되었습니다.");
			jsonData.put("result", "ok");
				
	
		}
		catch (Exception e) {
			logger.info("출하재검으로 이관 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	// 출하검사 폐기
	@RequestMapping(value = "qm/shipInspectDisposal", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipInspectDisposal(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			List<ShipInspectVo> listReInsp = new ArrayList<ShipInspectVo>(); //재검등록
			List<ShipInspectVo> listInsp = new ArrayList<ShipInspectVo>(); //출하재검사

			ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
			
			GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
			GoodsProductInfoAdmVo goodsProductInfoAdmVoRead = new GoodsProductInfoAdmVo();
			GoodsProductInfoAdmVo goodsProductInfoAdmVoRead2 = new GoodsProductInfoAdmVo();
			
			int shipInspIdx = shipInspectVo.getIdx();
			String trayNo = shipInspectVo.getTrayNo();
			String reInspStatus = shipInspectVo.getReInspStatus();
			String nextGubun = shipInspectVo.getNextGubun();
			int thisSeq = Integer.parseInt(shipInspectVo.getSeq());
			String inspStatus = shipInspectVo.getInspStatus();
			
			shipInspectAdmVo.setIdx(shipInspIdx);			
			shipInspectAdmVo.setTrayNo(trayNo);			
			shipInspectAdmVo.setReInspStatus(reInspStatus);
			shipInspectAdmVo.setNextGubun(nextGubun);
			shipInspectAdmVo.setInspStatus(inspStatus);
			shipInspectAdmVo.setSeq(Integer.toString(thisSeq));
			goodsProductInfoAdmVo.setBoxNo(shipInspectVo.getTrayNo());
			
			String seq = shipInspectService.selectTraySeq(shipInspectVo);
			int maxSeq = Integer.parseInt(seq) - 1;
			
			listInsp = shipInspectService.shipInspAdmRead(shipInspectVo);
			String inspDate = listInsp.get(0).getInspDate();
			String inspChargr = listInsp.get(0).getInspChargr();
			
			String workOrdNo = shipInspectVo.getWorkOrdNo();
			String ordGubun = shipInspectVo.getOrdGubun();
			//packUnitNm 가 홀수이면??
			int totalPackCnt =  Integer.parseInt(shipInspectVo.getPackUnitNm());
			int packCnt = Integer.parseInt(shipInspectVo.getPackUnitNm()) / 2;
			
			WorkOrderVo readWorkOrderVo = new WorkOrderVo();
			readWorkOrderVo.setWorkOrdNo(workOrdNo);
			readWorkOrderVo = workOrderService.read(readWorkOrderVo);
			String goodsCd = readWorkOrderVo.getGoodsCd();
		
			
			if("001".equals(reInspStatus)) { // 출하검사
				if("001".equals(nextGubun)) { //재검요청 안했을시
					
					goodsProductInfoAdmVo.setBoxNo(trayNo + "-1");
					goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
					
					goodsProductInfoAdmVo.setBoxNo(trayNo + "-2");
					goodsProductInfoAdmVoRead2 = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
					
					//트레이1 트레이2 둘다 확인 
					if(("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus()) && "003".equals(goodsProductInfoAdmVoRead.getFaultyStatus())) || ("001".equals(goodsProductInfoAdmVoRead2.getGoodsStatus()) && "003".equals(goodsProductInfoAdmVoRead2.getFaultyStatus()))) {
						//폐기 등록 실패
						jsonData.put("result", "fail");
						jsonData.put("message", "출하재검사 상태인 트레이입니다.");
					} else {
						if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus()) && "001".equals(goodsProductInfoAdmVoRead2.getGoodsStatus())) {
							//폐기 등록						
							if(maxSeq == thisSeq) { //마지막 차수일 경우
								if("002".equals(inspStatus)) { // 불합격 상태일 경우
									//폐기 성공
									shipInspectAdmVo.setDisStatus("001");
									shipInspectService.shipAdmDisStatusUpdate(shipInspectAdmVo);
									
									goodsProductInfoAdmVoRead.setFaultyDate(inspDate);
									goodsProductInfoAdmVoRead.setFaultyType("출하검사폐기");
									goodsProductInfoAdmVoRead.setUpdId(Utils.getUserId());
									
									goodsProductInfoAdmVoRead2.setFaultyDate(inspDate);
									goodsProductInfoAdmVoRead2.setFaultyType("출하검사폐기");
									goodsProductInfoAdmVoRead2.setUpdId(Utils.getUserId());				
									
									//수불 출고
									StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
									stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo+"-1","002","O","007", packCnt, factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -								
									stockPaymentAdmVoMinus = new StockPaymentAdmVo();
									stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo+"-2","002","O","007", packCnt, factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
																											
									stockPaymentAdmVoMinus = new StockPaymentAdmVo();
									stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo+"-1","002","I","010", packCnt, factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //부적합 창고
									stockPaymentAdmVoMinus = new StockPaymentAdmVo();
									stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo+"-2","002","I","010", packCnt, factoryCode);
									stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //부적합 창고
									
									//폐기
									goodsPackService.goodsProductDisuse(goodsProductInfoAdmVoRead);
									goodsPackService.goodsProductDisuse(goodsProductInfoAdmVoRead2);
									jsonData.put("result", "ok");
								} else { //합격일 경우
									jsonData.put("result", "fail");
									jsonData.put("message", "합격상태인 제품은 폐기 할 수 없습니다.");
								}
						} else {
							//폐기 실패
							jsonData.put("result", "fail");
							jsonData.put("message", "이미 입고/출고된 제품입니다.");
						}
						
						} else {
							//폐기 실패
							jsonData.put("result", "fail");
							jsonData.put("message", "마지막 차수가 아닙니다.");
						}
								
					}
				} else { //했을시
					//폐기 등록 실패
					jsonData.put("result", "fail");
					jsonData.put("message", "재검사를 요청한 제품입니다.");
				}
				
			}  else if("003".equals(reInspStatus)) { //출하재검사
				if("001".equals(nextGubun)) { //재검요청 안했을시
					//폐기 등록
					if(maxSeq == thisSeq) { //마지막 차수일 경우
						if("002".equals(inspStatus)) { // 불합격 상태일 경우
							//폐기 성공
							goodsProductInfoAdmVoRead = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
							if("001".equals(goodsProductInfoAdmVoRead.getGoodsStatus())) {
																
								shipInspectAdmVo.setDisStatus("001");
								shipInspectService.shipAdmDisStatusUpdate(shipInspectAdmVo);
								
								goodsProductInfoAdmVoRead.setFaultyDate(inspDate);
								goodsProductInfoAdmVoRead.setFaultyType("출하검사폐기");
								goodsProductInfoAdmVoRead.setUpdId(Utils.getUserId());
								
								//수불 출고
								StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
								stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo,"002","O","007", totalPackCnt, factoryCode);
								stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -								
						
								stockPaymentAdmVoMinus = new StockPaymentAdmVo();
								stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(goodsCd, trayNo,"002","I","010", totalPackCnt, factoryCode);
								stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //부적합 창고							

								//폐기
								goodsPackService.goodsProductDisuse(goodsProductInfoAdmVoRead);
								
								jsonData.put("result", "ok");
							} else{
								jsonData.put("result", "fail");
								jsonData.put("message", "이미 입고/출고된 제품입니다.");
							}
							
						} else { //합격일 경우
							jsonData.put("result", "fail");
							jsonData.put("message", "합격상태인 제품은 폐기 할 수 없습니다.");
						}
					} else {
						//폐기 실패
						jsonData.put("result", "fail");
						jsonData.put("message", "마지막 차수가 아닙니다.");
					}
					
				} else { //했을시
					//폐기 등록 실패
					jsonData.put("result", "fail");
					jsonData.put("message", "재검사를 요청한 제품입니다.");
				}
				
			}
			



		} catch (Exception e) {
			logger.info("출하검사 폐기등록 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//재검현황  조회
	@RequestMapping(value = "/qm/shipInspStatusListReInsp", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspStatusListReInsp(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재검현황 메인 조회");
		try {				
			List<ShipInspectVo> list = shipInspectService.shipInspStatusListReInsp(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("재검현황 메인 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//3공장 트레이 조회
	@RequestMapping(value = "/qm/shipInspSelectListFn3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspSelectListFn3(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("3공장 트레이 조회");
		try {
			List<ShipInspectVo> list = shipInspectService.shipInspSelectListFn3(shipInspectVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("3공장 트레이 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//출하검사집계표 조회
	@RequestMapping(value = "/qm/shipInspTotalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspTotalList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하검사집계표 설비명");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();			
			systemCommonCodeVo.setBaseGroupCd("068"); // 수입검사
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";		
			String codeList2 = "";	
			String codeListSum = ",";
			String[] codeListArray = new String[150];
			int idx = 1, i = 0;
			//기존 공통코드에서 불러오는방식
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				if (m.getEtc1().equals("001")) {
					codeList += "[" + m.getBaseCd() + "]" + ",";
					codeList2 += ", ISNULL(SUM([" + m.getBaseCd() + "]), 0) faulty"+idx;
					codeListArray[idx] = m.getBaseCd();
					idx++;
				}		
			}
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				if (m.getEtc1().equals("002")) {
					codeList += "[" + m.getBaseCd() + "]" + ",";
					codeList2 += ", ISNULL(SUM([" + m.getBaseCd() + "]), 0) faulty"+idx;
					codeListArray[idx] = m.getBaseCd();
					idx++;
				}		
			}
			for (i = 1; i < idx; i++) {
				codeListSum += " ISNULL(SUM([" + codeListArray[i] + "]), 0) +";
			}
			
			codeListSum = codeListSum.substring(0,codeListSum.length()-1);
			codeListSum += "faultySum";
			
			codeList2 += codeListSum;
			
			shipInspectVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			shipInspectVo.setCodeList2(codeList2);			
			List<ShipInspectVo> list = shipInspectService.shipInspTotalList(shipInspectVo);
			
			for (i = 0; i < list.size(); i++) {
				list.get(i).getFaulty1();
			}
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("3공장 트레이 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//품질관리 - 출하집계표 일자별 목록조회
	@RequestMapping(value = "qm/shipInspTotalDateList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspTotalDateList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하집계표 일자별  목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";
			String codeList2 = "";
			String[] codeListArray = new String[140];
			String[] codeListArray2 = new String[140];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();				
				codeList2 += "ISNULL(" +  "[" + m.getBaseCd() + "]" + ", 0 ) AS " +  "[" + m.getBaseCd() + "],";
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList2(codeList2.substring(0, codeList2.length() - 1));
			
			List<Map<String, String>> shipInspList;	
			if(factoryCode.equals("001") || factoryCode.equals("002")) {
				shipInspList = shipInspectService.shipInspTotalDateList(shipInspectVo);
			} else {//공장일때
				if(shipInspectVo.getDateCheck().equals("001")) { //검사일
					shipInspList = shipInspectService.shipInspTotalDateList_fa3_insp(shipInspectVo);
				} else { //생산일
					shipInspList = shipInspectService.shipInspTotalDateList_fa3_prod(shipInspectVo);
				}
			}
			
			
			List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
			for(Map<String, String> m : shipInspList) {
				ShipInspectVo shipInspectData = new ShipInspectVo();		
				
				shipInspectData.setInspDate(m.get("INSP_DATE").toString());
				shipInspectData.setDayNightCd(m.get("DAY_NIGHT_CD").toString());
	
				shipInspectData.setCheckQty(String.valueOf((m.get("CHECK_QTY"))));
				shipInspectData.setCheckLot(String.valueOf((m.get("CHECK_LOT"))));
				shipInspectData.setSuccessLot(String.valueOf((m.get("SUCCESS_LOT"))));     
				shipInspectData.setSuccessQty(String.valueOf((m.get("SUCCESS_QTY"))));  
				shipInspectData.setSuccessPercent(String.valueOf((m.get("SUCCESS_PERCENT"))));    
				shipInspectData.setFaultyLot(String.valueOf((m.get("FAULTY_LOT"))));         
				shipInspectData.setFaultyQty(String.valueOf((m.get("FAULTY_QTY"))));	       
				shipInspectData.setSyryo(String.valueOf((m.get("SYRYO"))));
				shipInspectData.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
				shipInspectData.setSyryoFaultyPercent(String.valueOf((m.get("SYRYO_FAULTY_PERCENT"))));
			
				
				shipInspectData.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectData.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectData.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectData.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectData.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectData.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectData.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectData.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectData.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectData.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectData.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectData.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectData.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectData.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectData.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectData.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectData.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectData.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectData.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectData.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectData.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectData.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectData.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectData.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectData.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectData.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectData.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectData.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectData.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectData.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectData.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectData.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectData.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectData.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectData.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectData.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectData.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectData.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectData.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectData.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectData.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectData.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectData.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectData.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectData.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectData.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectData.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectData.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectData.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectData.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectData.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectData.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectData.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectData.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectData.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectData.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectData.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectData.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectData.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectData.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectData.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectData.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectData.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectData.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectData.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectData.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectData.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectData.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectData.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectData.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectData.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectData.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectData.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectData.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectData.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectData.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectData.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectData.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectData.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectData.setFaulty80(String.valueOf(m.get(codeListArray[79])));
				shipInspectData.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectData.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectData.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectData.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectData.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectData.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectData.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectData.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectData.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectData.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectData.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectData.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectData.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectData.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectData.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectData.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectData.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectData.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectData.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectData.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectData.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectData.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectData.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectData.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectData.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectData.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectData.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectData.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectData.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectData.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectData.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectData.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectData.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectData.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectData.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectData.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectData.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectData.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectData.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectData.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectData.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectData.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectData.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectData.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectData.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectData.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectData.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectData.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectData.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectData.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectData.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectData.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectData.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectData.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectData.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectData.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectData.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectData.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectData.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectData.setFaulty140(String.valueOf(m.get(codeListArray[139])));

				dataList.add(shipInspectData);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출하집계표 일자별  목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 - 출하집계표 설비별 목록조회
	@RequestMapping(value = "qm/shipInspTotalEquipList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspTotalEquipList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하집계표 설비별 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";
			String codeList2 = "";
			String[] codeListArray = new String[140];
			String[] codeListArray2 = new String[140];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();				
				codeList2 += "ISNULL(" +  "[" + m.getBaseCd() + "]" + ", 0 ) AS " +  "[" + m.getBaseCd() + "],";
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList2(codeList2.substring(0, codeList2.length() - 1));
			
			//List<Map<String, String>> shipInspList = shipInspectService.shipInspTotalEquipList(shipInspectVo);
			List<Map<String, String>> shipInspList;	
			if(factoryCode.equals("001") || factoryCode.equals("002")) {
				shipInspList = shipInspectService.shipInspTotalEquipList(shipInspectVo);
			} else {//공장일때
				if(shipInspectVo.getDateCheck().equals("001")) { //검사일
					shipInspList = shipInspectService.shipInspTotalEquipList_fa3_insp(shipInspectVo);
				} else { //생산일
					shipInspList = shipInspectService.shipInspTotalEquipList_fa3_prod(shipInspectVo);
				}
			}
			List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
			for(Map<String, String> m : shipInspList) {
				ShipInspectVo shipInspectData = new ShipInspectVo();		
				
				shipInspectData.setEquipNm(m.get("EQUIP_NM").toString());
				//shipInspectData.setDayNightCd(m.get("DAY_NIGHT_CD").toString());
	
				shipInspectData.setCheckQty(String.valueOf((m.get("CHECK_QTY"))));
				shipInspectData.setCheckLot(String.valueOf((m.get("CHECK_LOT"))));
				shipInspectData.setSuccessLot(String.valueOf((m.get("SUCCESS_LOT"))));     
				shipInspectData.setSuccessQty(String.valueOf((m.get("SUCCESS_QTY"))));  
				shipInspectData.setSuccessPercent(String.valueOf((m.get("SUCCESS_PERCENT"))));    
				shipInspectData.setFaultyLot(String.valueOf((m.get("FAULTY_LOT"))));         
				shipInspectData.setFaultyQty(String.valueOf((m.get("FAULTY_QTY"))));	       
				shipInspectData.setSyryo(String.valueOf((m.get("SYRYO"))));
				shipInspectData.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
				shipInspectData.setSyryoFaultyPercent(String.valueOf((m.get("SYRYO_FAULTY_PERCENT"))));
			
				
				shipInspectData.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectData.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectData.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectData.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectData.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectData.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectData.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectData.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectData.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectData.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectData.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectData.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectData.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectData.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectData.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectData.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectData.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectData.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectData.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectData.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectData.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectData.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectData.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectData.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectData.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectData.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectData.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectData.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectData.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectData.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectData.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectData.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectData.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectData.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectData.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectData.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectData.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectData.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectData.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectData.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectData.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectData.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectData.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectData.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectData.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectData.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectData.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectData.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectData.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectData.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectData.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectData.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectData.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectData.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectData.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectData.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectData.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectData.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectData.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectData.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectData.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectData.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectData.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectData.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectData.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectData.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectData.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectData.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectData.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectData.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectData.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectData.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectData.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectData.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectData.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectData.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectData.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectData.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectData.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectData.setFaulty80(String.valueOf(m.get(codeListArray[79])));
				shipInspectData.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectData.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectData.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectData.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectData.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectData.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectData.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectData.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectData.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectData.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectData.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectData.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectData.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectData.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectData.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectData.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectData.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectData.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectData.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectData.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectData.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectData.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectData.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectData.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectData.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectData.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectData.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectData.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectData.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectData.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectData.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectData.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectData.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectData.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectData.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectData.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectData.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectData.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectData.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectData.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectData.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectData.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectData.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectData.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectData.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectData.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectData.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectData.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectData.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectData.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectData.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectData.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectData.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectData.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectData.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectData.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectData.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectData.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectData.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectData.setFaulty140(String.valueOf(m.get(codeListArray[139])));

				dataList.add(shipInspectData);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출하집계표 설비별 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//품질관리 - 출하집계표 기간별 목록조회
	@RequestMapping(value = "qm/shipInspTotalDayList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspTotalDayList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하집계표 기간별 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";
			String codeList2 = "";
			String[] codeListArray = new String[140];
			String[] codeListArray2 = new String[140];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();				
				codeList2 += "ISNULL(" +  "[" + m.getBaseCd() + "]" + ", 0 ) AS " +  "[" + m.getBaseCd() + "],";
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList2(codeList2.substring(0, codeList2.length() - 1));
			
			//List<Map<String, String>> shipInspList = shipInspectService.shipInspTotalDayList(shipInspectVo);
			
			List<Map<String, String>> shipInspList;	
			if(factoryCode.equals("001") || factoryCode.equals("002")) {
				shipInspList = shipInspectService.shipInspTotalDayList(shipInspectVo);
			} else {//공장일때
				if(shipInspectVo.getDateCheck().equals("001")) { //검사일
					shipInspList = shipInspectService.shipInspTotalDayList_fa3_insp(shipInspectVo);
				} else { //생산일
					shipInspList = shipInspectService.shipInspTotalDayList_fa3_prod(shipInspectVo);
				}
			}
			
			List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
			for(Map<String, String> m : shipInspList) {
				ShipInspectVo shipInspectData = new ShipInspectVo();		
				
				shipInspectData.setInspDate(m.get("INSP_DATE").toString());
				//shipInspectData.setDayNightCd(m.get("DAY_NIGHT_CD").toString());
	
				shipInspectData.setCheckQty(String.valueOf((m.get("CHECK_QTY"))));
				shipInspectData.setCheckLot(String.valueOf((m.get("CHECK_LOT"))));
				shipInspectData.setSuccessLot(String.valueOf((m.get("SUCCESS_LOT"))));     
				shipInspectData.setSuccessQty(String.valueOf((m.get("SUCCESS_QTY"))));  
				shipInspectData.setSuccessPercent(String.valueOf((m.get("SUCCESS_PERCENT"))));    
				shipInspectData.setFaultyLot(String.valueOf((m.get("FAULTY_LOT"))));         
				shipInspectData.setFaultyQty(String.valueOf((m.get("FAULTY_QTY"))));	       
				shipInspectData.setSyryo(String.valueOf((m.get("SYRYO"))));
				shipInspectData.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
				shipInspectData.setSyryoFaultyPercent(String.valueOf((m.get("SYRYO_FAULTY_PERCENT"))));
			
				
				shipInspectData.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectData.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectData.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectData.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectData.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectData.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectData.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectData.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectData.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectData.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectData.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectData.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectData.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectData.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectData.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectData.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectData.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectData.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectData.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectData.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectData.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectData.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectData.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectData.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectData.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectData.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectData.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectData.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectData.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectData.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectData.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectData.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectData.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectData.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectData.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectData.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectData.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectData.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectData.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectData.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectData.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectData.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectData.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectData.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectData.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectData.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectData.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectData.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectData.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectData.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectData.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectData.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectData.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectData.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectData.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectData.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectData.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectData.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectData.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectData.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectData.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectData.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectData.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectData.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectData.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectData.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectData.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectData.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectData.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectData.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectData.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectData.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectData.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectData.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectData.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectData.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectData.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectData.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectData.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectData.setFaulty80(String.valueOf(m.get(codeListArray[79])));
				shipInspectData.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectData.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectData.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectData.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectData.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectData.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectData.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectData.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectData.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectData.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectData.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectData.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectData.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectData.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectData.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectData.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectData.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectData.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectData.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectData.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectData.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectData.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectData.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectData.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectData.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectData.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectData.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectData.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectData.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectData.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectData.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectData.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectData.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectData.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectData.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectData.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectData.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectData.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectData.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectData.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectData.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectData.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectData.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectData.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectData.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectData.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectData.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectData.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectData.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectData.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectData.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectData.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectData.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectData.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectData.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectData.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectData.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectData.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectData.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectData.setFaulty140(String.valueOf(m.get(codeListArray[139])));

				dataList.add(shipInspectData);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출하집계표 기간별 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 - 출하집계표 제품별 목록조회
	@RequestMapping(value = "qm/shipInspTotalGoodsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspTotalGoodsList(ShipInspectVo shipInspectVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출하집계표 제품별 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";
			String codeList2 = "";
			String[] codeListArray = new String[140];
			String[] codeListArray2 = new String[140];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();				
				codeList2 += "ISNULL(" +  "[" + m.getBaseCd() + "]" + ", 0 ) AS " +  "[" + m.getBaseCd() + "],";
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			shipInspectVo.setCodeList2(codeList2.substring(0, codeList2.length() - 1));
			
			//List<Map<String, String>> shipInspList = shipInspectService.shipInspTotalGoodsList(shipInspectVo);
			List<Map<String, String>> shipInspList;	
			if(factoryCode.equals("001") || factoryCode.equals("002")) {
				shipInspList = shipInspectService.shipInspTotalGoodsList(shipInspectVo);
			} else {//공장일때
				if(shipInspectVo.getDateCheck().equals("001")) { //검사일
					shipInspList = shipInspectService.shipInspTotalGoodsList_fa3_insp(shipInspectVo);
				} else { //생산일
					shipInspList = shipInspectService.shipInspTotalGoodsList_fa3_prod(shipInspectVo);
				}
			}
			
			List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
			for(Map<String, String> m : shipInspList) {
				ShipInspectVo shipInspectData = new ShipInspectVo();		
				
				shipInspectData.setGoodsNm(m.get("GOODS_NM").toString());
				//shipInspectData.setDayNightCd(m.get("DAY_NIGHT_CD").toString());
	
				shipInspectData.setCheckQty(String.valueOf((m.get("CHECK_QTY"))));
				shipInspectData.setCheckLot(String.valueOf((m.get("CHECK_LOT"))));
				shipInspectData.setSuccessLot(String.valueOf((m.get("SUCCESS_LOT"))));     
				shipInspectData.setSuccessQty(String.valueOf((m.get("SUCCESS_QTY"))));  
				shipInspectData.setSuccessPercent(String.valueOf((m.get("SUCCESS_PERCENT"))));    
				shipInspectData.setFaultyLot(String.valueOf((m.get("FAULTY_LOT"))));         
				shipInspectData.setFaultyQty(String.valueOf((m.get("FAULTY_QTY"))));	       
				shipInspectData.setSyryo(String.valueOf((m.get("SYRYO"))));
				shipInspectData.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
				shipInspectData.setSyryoFaultyPercent(String.valueOf((m.get("SYRYO_FAULTY_PERCENT"))));
			
				
				shipInspectData.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectData.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectData.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectData.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectData.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectData.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectData.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectData.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectData.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectData.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectData.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectData.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectData.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectData.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectData.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectData.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectData.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectData.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectData.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectData.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectData.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectData.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectData.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectData.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectData.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectData.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectData.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectData.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectData.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectData.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectData.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectData.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectData.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectData.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectData.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectData.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectData.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectData.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectData.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectData.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectData.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectData.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectData.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectData.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectData.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectData.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectData.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectData.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectData.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectData.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectData.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectData.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectData.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectData.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectData.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectData.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectData.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectData.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectData.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectData.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectData.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectData.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectData.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectData.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectData.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectData.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectData.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectData.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectData.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectData.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectData.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectData.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectData.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectData.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectData.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectData.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectData.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectData.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectData.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectData.setFaulty80(String.valueOf(m.get(codeListArray[79])));
				shipInspectData.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectData.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectData.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectData.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectData.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectData.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectData.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectData.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectData.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectData.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectData.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectData.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectData.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectData.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectData.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectData.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectData.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectData.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectData.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectData.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectData.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectData.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectData.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectData.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectData.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectData.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectData.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectData.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectData.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectData.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectData.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectData.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectData.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectData.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectData.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectData.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectData.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectData.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectData.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectData.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectData.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectData.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectData.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectData.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectData.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectData.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectData.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectData.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectData.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectData.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectData.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectData.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectData.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectData.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectData.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectData.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectData.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectData.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectData.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectData.setFaulty140(String.valueOf(m.get(codeListArray[139])));

				dataList.add(shipInspectData);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("출하집계표 제품별 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	
	//재검 등록 안되어 있으면 재검 요청 취소
	@RequestMapping(value = "/qm/reInspectRequestCancel_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reInspectRequestCancel_F3(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재검 등록 안되어 있으면 재검 요청 취소");
		try {
			shipInspectVo = shipInspectService.reInspectRequestCancel(shipInspectVo);
			jsonData.put("data", shipInspectVo.getResultValue());
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//품질관리- 출하검사현황
	@RequestMapping(value = "qm/shipInspExcelDownload", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipInspExcelDownload(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		
		//.xls 확장자 지원
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		Row row			= null;
		Cell cell		= null;
		
		//.xlsx 확장자 지원
		XSSFWorkbook xssfWb = null;
		XSSFSheet xssfSheet = null;
		XSSFRow xssfRow		= null;
		XSSFCell xssfCell	= null;
		
		try {
			
			//출하검사 현황 헤더 받는 부분
			String[] fixedHeader = shipInspectVo.getFixedHeader();
			
			
			List<ShipInspectVo> list = shipInspStatusDataList(shipInspectVo);
			jsonData.put("data",list);
			
			List<SystemCommonCodeVo>  systemCommonCodeList;
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			int countCommonCode = 0;			
			//systemCommonCodeVo.setOrderGubun("001");
			systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			countCommonCode = systemCommonCodeList.size();
			
			int rowNo = 0; // 행 갯수 
			// 워크북 생성
			xssfWb = new XSSFWorkbook();
			xssfSheet = xssfWb.createSheet("출하검사현황"); // 워크시트 이름
			
			//헤더용 폰트 스타일
			XSSFFont font = xssfWb.createFont();
			font.setFontName(HSSFFont.FONT_ARIAL); //폰트스타일
			font.setFontHeightInPoints((short)14); //폰트크기
			font.setBold(true); //Bold 유무
			
			//테이블 타이틀 스타일
			CellStyle cellStyle_Title = xssfWb.createCellStyle();
			
			//xssfSheet.setColumnWidth(3, (xssfSheet.getColumnWidth(3))+(short)2048); // 3번째 컬럼 넓이 조절
			//xssfSheet.setColumnWidth(4, (xssfSheet.getColumnWidth(4))+(short)2048); // 4번째 컬럼 넓이 조절
			//xssfSheet.setColumnWidth(5, (xssfSheet.getColumnWidth(5))+(short)2048); // 5번째 컬럼 넓이 조절
			//xssfSheet.setColumnWidth(8, (xssfSheet.getColumnWidth(8))+(short)4096); // 8번째 컬럼 넓이 조절
			
			cellStyle_Title.setFont(font); // cellStle에 font를 적용
			cellStyle_Title.setAlignment(HorizontalAlignment.CENTER); // 정렬
			
			//셀병합
			xssfSheet.addMergedRegion(new CellRangeAddress(0, 0, 0, (26+countCommonCode))); //첫행, 마지막행, 첫열, 마지막열( 0번째 행의 0~8번째 컬럼을 병합한다)
						
			//타이틀 생성
			xssfRow = xssfSheet.createRow(rowNo++); //행 객체 추가
			xssfCell = xssfRow.createCell((short) 0); 
			xssfCell.setCellStyle(cellStyle_Title); 
			xssfCell.setCellValue("출하검사현황"); 
			
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			
			
			CellStyle cellStyle_Body = xssfWb.createCellStyle(); 
			cellStyle_Body.setAlignment(HorizontalAlignment.CENTER); 
			
			//테이블 스타일 설정
			CellStyle cellStyle_Table_Header = xssfWb.createCellStyle();
			cellStyle_Table_Header.setBorderTop(BorderStyle.THIN);				//테두리 위쪽
			cellStyle_Table_Header.setBorderBottom(BorderStyle.THIN);			//테두리 아래쪽
			cellStyle_Table_Header.setBorderLeft(BorderStyle.THIN);				//테두리 왼쪽
			cellStyle_Table_Header.setBorderRight(BorderStyle.THIN);			//테두리 오른쪽
			cellStyle_Table_Header.setAlignment(HorizontalAlignment.CENTER);
			cellStyle_Table_Header.setVerticalAlignment(VerticalAlignment.CENTER);

			//고정 헤더만들어주는 부분
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			
			for(int i=0; i<fixedHeader.length; i++) {
				
				xssfCell = xssfRow.createCell((short) i); 
				xssfCell.setCellStyle(cellStyle_Table_Header); 
				xssfCell.setCellValue(fixedHeader[i]);
			}
			//고정 헤더만들어주는 부분
			
			int cnt001 = 0;
			int cnt002 = 0;
			int cnt008 = 0;
			
			//동적 헤더만들어주는 부분
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				if(m.getEtc1() != null  ) {					
					if("001".equals(m.getEtc1()) && (m.getEtc8() == null || "".equals(m.getEtc8()))) {
						cnt001++;						
					}
					if("002".equals(m.getEtc1()) && (m.getEtc8() == null || "".equals(m.getEtc8()))) {
						cnt002++;
					}
					if(m.getEtc8() != null && !"".equals(m.getEtc8())) {
						cnt008++;
					}
				}				
			}
			//동적 헤더만들어주는 부분
			
			xssfCell = xssfRow.createCell((short) 27);		
			xssfCell.setCellValue("원자재성불량");
			xssfCell.setCellStyle(cellStyle_Table_Header);
			
			for(int i = 28; i < 27+cnt001; i++) {
				xssfCell = xssfRow.createCell((short) i);		
				xssfCell.setCellStyle(cellStyle_Table_Header);
			}
			xssfSheet.addMergedRegion(new CellRangeAddress(rowNo-1, rowNo-1, 27, (27+cnt001)-1)); //첫행,마지막행,첫열,마지막열  (현재 3번째행)
			
			xssfCell = xssfRow.createCell((short) (27+cnt001));		
			xssfCell.setCellValue("공정성불량");
			xssfCell.setCellStyle(cellStyle_Table_Header);
			for(int i = (28+cnt001); i < (27+cnt001+cnt002); i++) {
				xssfCell = xssfRow.createCell((short) i);		
				xssfCell.setCellStyle(cellStyle_Table_Header);
			}
			xssfSheet.addMergedRegion(new CellRangeAddress(rowNo-1, rowNo-1, (27+cnt001), (27+cnt001+cnt002)-1)); //첫행,마지막행,첫열,마지막열  (현재 3번째행)		
			
			//헤더 생성
			xssfRow = xssfSheet.createRow(rowNo); //4번째 줄
			for(int i = 0; i < 27; i++) {
				xssfCell = xssfRow.createCell((short) i); 	
				xssfCell.setCellStyle(cellStyle_Table_Header); 
				xssfSheet.addMergedRegion(new CellRangeAddress(rowNo-1, (rowNo), i, i)); //첫행,마지막행,첫열,마지막열  (현재 3번째행)
			}			
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				xssfCell = xssfRow.createCell((short) idx+27);
				xssfCell.setCellStyle(cellStyle_Table_Header);
				xssfCell.setCellValue(m.getBaseCdNm());
				idx++;				
			}			
			
			int commonCodeLength = cnt001 + cnt002 + cnt008;
	
			
			rowNo++;
			
			String fieldName	= "";
			String fieldValue	= "";
			Field field;
			
			//fixedColumn[0];
			//int
			
			String[] fixedColumn = shipInspectVo.getFixedColumn();
			Field field1;
			Object fieldValue1;
			
			for(ShipInspectVo m : list) {
				xssfRow = xssfSheet.createRow(rowNo++);
				
				//고정 데이터 불러오는 코드
			    for(int i=0; i<fixedColumn.length; i++) {
			        String columnName	= fixedColumn[i];
			        if( !columnName.equals("") ) {
			        	field1	= m.getClass().getDeclaredField(columnName);
			        	field1.setAccessible(true);
			        	
				        fieldValue1	= field1.get(m);
				        
				        xssfCell = xssfRow.createCell((short) i);
				        xssfCell.setCellValue(String.valueOf(fieldValue1));			        	
			        }
			    }
			    //고정 데이터 불러오는 코드
				
				for(int i = 1; i <= commonCodeLength; i++) {
					fieldName = "faulty" + i;
					field = m.getClass().getDeclaredField(fieldName);
					field.setAccessible(true);
					xssfCell = xssfRow.createCell((short) fixedColumn.length+(i-1));
					xssfCell.setCellValue( String.valueOf(field.get(m)).equals("null") ? "0" : String.valueOf(field.get(m)) );
				}

			}
			
			
			for (int i=0;i<(27+cnt001+cnt002+1);i++) //autuSizeColumn after setColumnWidth setting!!
			{
				xssfSheet.autoSizeColumn(i);
				xssfSheet.setColumnWidth(i, (xssfSheet.getColumnWidth(i))+1024 ); //이건 자동으로 조절 하면 너무 딱딱해 보여서 자동조정한 사이즈에 (short)512를 추가해 주니 한결 보기 나아졌다.
			}
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			xssfWb.write(baos);
			xssfWb.close();
			jsonData.put("result", "ok");
			jsonData.put("blob", baos.toByteArray());
			
			}
			catch(Exception e){
				logger.info("불량집계현황(기간) 기간별 조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}finally{
				
		    }
		
		
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//출하검사현황  조회
	public List<ShipInspectVo> shipInspStatusDataList(ShipInspectVo shipInspectVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<ShipInspectVo> dataList = new ArrayList<ShipInspectVo>();
		logger.info("출하검사 메인 조회");
		
		try {				
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(factoryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("출하검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			shipInspectVo.setCodeList(codeList.substring(0,codeList.length()-1));	
			shipInspectVo.setFactoryCode(factoryCode);
			List<Map<String, String>> list;
			if(factoryCode.equals("003")) {
				list = shipInspectService.shipInspStatusList_fa3(shipInspectVo);
			} else {
				list = shipInspectService.shipInspStatusList(shipInspectVo);
			}
			
			for(Map<String, String> m : list) {
				ShipInspectVo shipInspectVodata = new ShipInspectVo();
				shipInspectVodata.setLabelLotNoSeq(String.valueOf(m.get("LABEL_LOT_NO_SEQ").toString()));							
				shipInspectVodata.setIdx(Integer.parseInt(String.valueOf((m.get("IDX")))));
				shipInspectVodata.setEquipNm(String.valueOf((m.get("EQUIP_NM"))));				
				shipInspectVodata.setFilmLotNo(String.valueOf((m.get("FILM_LOT_NO"))));
				shipInspectVodata.setMatrlLotNo(String.valueOf((m.get("MATRL_LOT_NO"))));
				shipInspectVodata.setGoodsNm(String.valueOf((m.get("GOODS_NM"))));
				shipInspectVodata.setProductQty(Integer.parseInt(String.valueOf((m.get("PRODUCT_QTY")))));
				shipInspectVodata.setInspDate(String.valueOf(m.get("INSP_DATE")));
				shipInspectVodata.setFaultyTrayNo(String.valueOf(m.get("FAULTY_TRAY_NO")));
				shipInspectVodata.setInspStatus(String.valueOf(m.get("INSP_STATUS").toString()));
				shipInspectVodata.setReInspStatus(String.valueOf(m.get("RE_INSP_STATUS").toString()));
				shipInspectVodata.setNextGubun(String.valueOf(m.get("NEXT_GUBUN").toString()));
				shipInspectVodata.setWorkOrdNo(String.valueOf(m.get("WORK_ORD_NO").toString()));
				shipInspectVodata.setTrayWorkerId(String.valueOf(m.get("TRAY_WORKER_ID").toString()));
				shipInspectVodata.setTrayWorkerIdNm(String.valueOf(m.get("TRAY_WORKER_ID_NM").toString()));
				shipInspectVodata.setInspChargrNm(String.valueOf(m.get("INSP_CHARGR_NM").toString()));
				shipInspectVodata.setFaultyCnt(String.valueOf(m.get("FAULTY_CNT")));
				shipInspectVodata.setQutyNm(String.valueOf(m.get("QUTY_NM").toString()));
				shipInspectVodata.setDayNightCd(String.valueOf(m.get("DAY_NIGHT_CD").toString()));
				shipInspectVodata.setProductDate(String.valueOf(m.get("PRODUCT_DATE")));
				shipInspectVodata.setDisStatus(String.valueOf(m.get("DIS_STATUS")));
				shipInspectVodata.setUpdDate(String.valueOf(m.get("UPD_DATE")));
				
				shipInspectVodata.setProductDateMm(String.valueOf(m.get("PRODUCT_DATE_MM")));
				shipInspectVodata.setProductDateWw(String.valueOf(m.get("PRODUCT_DATE_WW")));
				
				shipInspectVodata.setSampleCnt(String.valueOf(m.get("SAMPLE_CNT").toString()));
			
				if(factoryCode.equals("003")) {
					shipInspectVodata.setThreeTrayWeight(String.valueOf(m.get("THREE_TRAY_WEIGHT")));
					shipInspectVodata.setThreeTrayWeightCheck(String.valueOf(m.get("THREE_TRAY_WEIGHT_CHECK")));
				}
				
				shipInspectVodata.setFaultyGubun(String.valueOf(m.get("FAULTY_GUBUN").toString()));
				shipInspectVodata.setInspProductQty(String.valueOf(m.get("INSP_PRODUCT_QTY")));
				
				shipInspectVodata.setInspGubun(String.valueOf(m.get("INSP_GUBUN")));
				shipInspectVodata.setReInspSystem(String.valueOf(m.get("RE_INSP_SYSTEM")));
				shipInspectVodata.setInspDesc(String.valueOf(m.get("INSP_DESC")));
				
				
				shipInspectVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				shipInspectVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				shipInspectVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				shipInspectVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				shipInspectVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				shipInspectVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				shipInspectVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				shipInspectVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				shipInspectVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				shipInspectVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				shipInspectVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				shipInspectVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				shipInspectVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				shipInspectVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				shipInspectVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				shipInspectVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				shipInspectVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				shipInspectVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				shipInspectVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				shipInspectVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				shipInspectVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				shipInspectVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				shipInspectVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				shipInspectVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				shipInspectVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				shipInspectVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				shipInspectVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				shipInspectVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				shipInspectVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				shipInspectVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				shipInspectVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				shipInspectVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				shipInspectVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				shipInspectVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				shipInspectVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				shipInspectVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				shipInspectVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				shipInspectVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				shipInspectVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				shipInspectVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				shipInspectVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				shipInspectVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				shipInspectVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				shipInspectVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				shipInspectVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				shipInspectVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				shipInspectVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				shipInspectVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				shipInspectVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				shipInspectVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				shipInspectVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				shipInspectVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				shipInspectVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				shipInspectVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				shipInspectVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				shipInspectVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				shipInspectVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				shipInspectVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				shipInspectVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				shipInspectVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				shipInspectVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				shipInspectVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				shipInspectVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				shipInspectVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				shipInspectVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				shipInspectVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				shipInspectVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				shipInspectVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				shipInspectVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				shipInspectVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				shipInspectVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				shipInspectVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				shipInspectVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				shipInspectVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				shipInspectVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				shipInspectVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				shipInspectVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				shipInspectVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				shipInspectVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				shipInspectVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				shipInspectVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				shipInspectVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				shipInspectVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				shipInspectVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				shipInspectVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				shipInspectVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				shipInspectVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				shipInspectVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				shipInspectVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				shipInspectVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				shipInspectVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				shipInspectVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				shipInspectVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				shipInspectVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				shipInspectVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				shipInspectVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				shipInspectVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				shipInspectVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				shipInspectVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				shipInspectVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				shipInspectVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				shipInspectVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				shipInspectVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				shipInspectVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				shipInspectVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				shipInspectVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				shipInspectVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				shipInspectVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				shipInspectVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				shipInspectVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				shipInspectVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				shipInspectVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				shipInspectVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				shipInspectVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				shipInspectVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				shipInspectVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				shipInspectVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				shipInspectVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				shipInspectVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				shipInspectVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				shipInspectVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				shipInspectVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				shipInspectVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				shipInspectVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				shipInspectVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				shipInspectVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				shipInspectVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				shipInspectVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				shipInspectVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				shipInspectVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				shipInspectVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				shipInspectVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				shipInspectVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				shipInspectVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				shipInspectVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				shipInspectVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				shipInspectVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				shipInspectVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				shipInspectVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				shipInspectVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				dataList.add(shipInspectVodata);
			}
		
		} catch (Exception e) {
			logger.info("출하검사현황 메인 조회");
			e.printStackTrace();
		}
		return dataList;
	}
	
}