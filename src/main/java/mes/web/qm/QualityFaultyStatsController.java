package mes.web.qm;

import java.io.File;
import java.io.FileOutputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.output.ByteArrayOutputStream;
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
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.GoodsFaultyAdmVo;
import mes.domain.sm.MatrlUserVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.sm.MatrlUserService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class QualityFaultyStatsController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private MatrlUserService matrlUserService;
	
	private static final Logger logger = LoggerFactory.getLogger(QualityFaultyStatsController.class);
	
	@Value("${factoryCode}") private String facotryCode;
	
	//품질관리 - 불량집계현황 페이지
	@RequestMapping(value = "/qmsc0080", method = RequestMethod.GET)
	public String qmsc0080GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(일자) 페이지");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeGoodsFaultyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("101"); // 최종검사현황(종합수량) 제외 값
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("exceptFaultyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("093"); //생산비전불량 현황 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); //생산비전불량 현황 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyCd", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "qm/qmsc0080";
	}
	
	//품질관리 - 불량집계현황 페이지_2공장
	@RequestMapping(value = {"/qmsc2080",}, method = RequestMethod.GET)
	public String qmsc2080GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(일자) 페이지");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeGoodsFaultyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("093"); // 생산 비전불량수량 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); // 생산 비전불량수량 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("101"); // 최종검사현황(종합수량) 제외 값
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("exceptFaultyCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList);
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		
		return "qm/qmsc2080";
		
	
	}
	
	//품질관리 - 불량집계현황 페이지_2공장
		@RequestMapping(value = {"/qmsc2081"}, method = RequestMethod.GET)
		public String qmsc2081GET(Locale locale, Model model) throws Exception {

			logger.info("불량집계현황(일자) 페이지");
			
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("goodsFaultyType", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("systemCommonCd", systemCommonCodeList );
			
			systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("edgeBigName", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("edgeGoodsFaultyCd", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("093"); // 생산 비전불량수량 대분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("visionFaultyBigName", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("094"); // 생산 비전불량수량 소분류
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("visionFaultyCd", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("101"); // 최종검사현황(종합수량) 제외 값
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("exceptFaultyCd", systemCommonCodeList);
			
			systemCommonCodeVo.setBaseGroupCd("007"); // 재질
			systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			model.addAttribute("qutyCd", systemCommonCodeList);
			
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
			model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

			
			return "qm/qmsc2081";
			
		
		}
	
	//품질관리 - 불량집계현황 페이지_3공장
	@RequestMapping(value = "/qmsc3080", method = RequestMethod.GET)
	public String qmsc3080GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(일자) 페이지");
			
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
			
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("087"); // 엣지검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeBigName", systemCommonCodeList);
			
		systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("edgeGoodsFaultyCd", systemCommonCodeList);
			
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		return "qm/qmsc3080";
	}
		
	//품질관리 -불량집계현황(일자) 목록조회
	@RequestMapping(value = "qm/faultyTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderDataListGET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
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
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList2(codeList2.substring(0, codeList2.length() - 1));
			
			List<Map<String, String>> workOrderList = workOrderService.faultyDayTotalList(workOrderVo);		
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM"));
				workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER"));		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
				workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				} else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}				
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());				
				
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));

				dataList.add(workOrderVodata);
			}
			//for (int i=0; i<dataList.size(); i++) {
			//	System.out.println("111111111 - " + dataList.get(i));
			//	
			//}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 -불량집계현황(일자) 목록조회_F2
	@RequestMapping(value = "qm/edgeFaultyTotalDataList_F2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> edgeFaultyTotalDataList_F2(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회_F2");
		try {
			workOrderVo.setFactoryCode(facotryCode);
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("088"); // 엣지검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList 		= "";			
			String[] codeListArray	= new String[80];
			int idx 				= 0;
			Arrays.fill(codeListArray, "0");
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			
			logger.info("엣지불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = workOrderService.edgeFaultyDayTotalList(workOrderVo);		
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setEdgeInspctDate			(m.get("EDGE_INSPCT_DATE"));			//엣지검사일
				workOrderVodata.setEdgeInspctCharger		(m.get("EDGE_INSPCT_CHARGER"));		//엣지 검사자
				workOrderVodata.setEdgeInspctChargerNm		(m.get("EDGE_INSPCT_CHARGER_NM"));	//엣지검사자_NM
				
				workOrderVodata.setUserInputInspctCnt		(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt				(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate					(m.get("WORK_ORD_DATE").toString());
				workOrderVodata.setOrdGubunNm				(m.get("ORD_GUBUN_NM").toString());
				workOrderVodata.setGubun					(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm					(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd					(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo				(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo				(m.get("WORK_ORD_LOT_NO").toString());
				workOrderVodata.setOrdLotNo					(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo					(m.get("LOT_NO").toString());
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm		(m.get("MAIN_WORK_CHARGR_NM").toString());
					workOrderVodata.setMainWorkChargr		(m.get("MAIN_WORK_CHARGR").toString());
				} else {
					workOrderVodata.setMainWorkChargrNm		("");
					workOrderVodata.setMainWorkChargr		("");
				}				
				
				workOrderVodata.setEdgeOutputCnt			(Integer.parseInt(String.valueOf((m.get("EDGE_OUTPUT_CNT")))));
//				workOrderVodata.setEdgeOutputCnt			(Integer.parseInt(String.valueOf((0))));							//엣지양품수량
				workOrderVodata.setEdgeFaultyCnt			(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));		//엣지불량수량
				
				workOrderVodata.setGoodsNm					(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd					(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm					(m.get("QUTY_NM").toString());
				workOrderVodata.setModel					(m.get("MODEL").toString());					

				workOrderVodata.setFaulty1 (String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2 (String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3 (String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4 (String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5 (String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6 (String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7 (String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8 (String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9 (String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				dataList.add(workOrderVodata);
			}
			//for (int i=0; i<dataList.size(); i++) {
			//	System.out.println("111111111 - " + dataList.get(i));
			//	
			//}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("엣지 불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	

	//품질관리 -불량집계현황(일자) 목록조회(작지번호별)
	@RequestMapping(value = "qm/workOrderTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderTotalDataListGet(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회(작지번호별)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = workOrderService.workOrderTotalDataList(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
//				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				//appearFaultyCnt불량수량
			//	workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
			//	//userInputInspctCnt검사수량
			//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
			//	
			//	if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
			//		//appearFaultyCnt불량수량
			//		workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//userInputInspctCnt검사수량
			//		workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//엣지기포수량
			//		/*if( m.get(codeListArray[79]) != null) {
			//			workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
			//		} else {
			//			workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
			//		}*/
			//		
			//	} 
			//	
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
						Integer.parseInt(workOrderVodata.getFaulty2() ) +			
						Integer.parseInt(workOrderVodata.getFaulty3() ) +
						Integer.parseInt(workOrderVodata.getFaulty4() ) +
						Integer.parseInt(workOrderVodata.getFaulty5() ) +
						Integer.parseInt(workOrderVodata.getFaulty6() ) +
						Integer.parseInt(workOrderVodata.getFaulty7() ) +
						Integer.parseInt(workOrderVodata.getFaulty8() ) +
						Integer.parseInt(workOrderVodata.getFaulty9() ) +
						Integer.parseInt(workOrderVodata.getFaulty10()) +
						Integer.parseInt(workOrderVodata.getFaulty11()) +
						Integer.parseInt(workOrderVodata.getFaulty12()) +
						Integer.parseInt(workOrderVodata.getFaulty13()) +
						Integer.parseInt(workOrderVodata.getFaulty14()) +
						Integer.parseInt(workOrderVodata.getFaulty15()) +
						Integer.parseInt(workOrderVodata.getFaulty16()) +
						Integer.parseInt(workOrderVodata.getFaulty17()) +
						Integer.parseInt(workOrderVodata.getFaulty18()) +
						Integer.parseInt(workOrderVodata.getFaulty19()) +
						Integer.parseInt(workOrderVodata.getFaulty20()) +
						Integer.parseInt(workOrderVodata.getFaulty21()) +
						Integer.parseInt(workOrderVodata.getFaulty22()) +
						Integer.parseInt(workOrderVodata.getFaulty23()) +
						Integer.parseInt(workOrderVodata.getFaulty24()) +
						Integer.parseInt(workOrderVodata.getFaulty25()) +
						Integer.parseInt(workOrderVodata.getFaulty26()) +
						Integer.parseInt(workOrderVodata.getFaulty27()) +
						Integer.parseInt(workOrderVodata.getFaulty28()) +
						Integer.parseInt(workOrderVodata.getFaulty29()) +
						Integer.parseInt(workOrderVodata.getFaulty30()) +
						Integer.parseInt(workOrderVodata.getFaulty31()) +
						Integer.parseInt(workOrderVodata.getFaulty32()) +
						Integer.parseInt(workOrderVodata.getFaulty33()) +
						Integer.parseInt(workOrderVodata.getFaulty34()) +
						Integer.parseInt(workOrderVodata.getFaulty35()) +
						Integer.parseInt(workOrderVodata.getFaulty36()) +
						Integer.parseInt(workOrderVodata.getFaulty37()) +
						Integer.parseInt(workOrderVodata.getFaulty38()) +
						Integer.parseInt(workOrderVodata.getFaulty39()) +
						Integer.parseInt(workOrderVodata.getFaulty40()) +
						Integer.parseInt(workOrderVodata.getFaulty41()) +
						Integer.parseInt(workOrderVodata.getFaulty42()) +
						Integer.parseInt(workOrderVodata.getFaulty43()) +
						Integer.parseInt(workOrderVodata.getFaulty44()) +
						Integer.parseInt(workOrderVodata.getFaulty45()) +
						Integer.parseInt(workOrderVodata.getFaulty46()) +
						Integer.parseInt(workOrderVodata.getFaulty47()) +
						Integer.parseInt(workOrderVodata.getFaulty48()) +
						Integer.parseInt(workOrderVodata.getFaulty49()) +
						Integer.parseInt(workOrderVodata.getFaulty50()) +
						Integer.parseInt(workOrderVodata.getFaulty51()) +
						Integer.parseInt(workOrderVodata.getFaulty52()) +
						Integer.parseInt(workOrderVodata.getFaulty53()) +
						Integer.parseInt(workOrderVodata.getFaulty54()) +
						Integer.parseInt(workOrderVodata.getFaulty55()) +
						Integer.parseInt(workOrderVodata.getFaulty56()) +
						Integer.parseInt(workOrderVodata.getFaulty57()) +
						Integer.parseInt(workOrderVodata.getFaulty58()) +
						Integer.parseInt(workOrderVodata.getFaulty59()) +
						Integer.parseInt(workOrderVodata.getFaulty60()) +
						Integer.parseInt(workOrderVodata.getFaulty61()) +
						Integer.parseInt(workOrderVodata.getFaulty62()) +
						Integer.parseInt(workOrderVodata.getFaulty63()) +
						Integer.parseInt(workOrderVodata.getFaulty64()) +
						Integer.parseInt(workOrderVodata.getFaulty65()) +
						Integer.parseInt(workOrderVodata.getFaulty66()) +
						Integer.parseInt(workOrderVodata.getFaulty67()) +
						Integer.parseInt(workOrderVodata.getFaulty68()) +
						Integer.parseInt(workOrderVodata.getFaulty69()) +
						Integer.parseInt(workOrderVodata.getFaulty70()) +
						Integer.parseInt(workOrderVodata.getFaulty71()) +
						Integer.parseInt(workOrderVodata.getFaulty72()) +
						Integer.parseInt(workOrderVodata.getFaulty73()) +
						Integer.parseInt(workOrderVodata.getFaulty74()) +
						Integer.parseInt(workOrderVodata.getFaulty75()) +
						Integer.parseInt(workOrderVodata.getFaulty76()) +
						Integer.parseInt(workOrderVodata.getFaulty77()) +
						Integer.parseInt(workOrderVodata.getFaulty78()) +
						Integer.parseInt(workOrderVodata.getFaulty79()) +
						Integer.parseInt(workOrderVodata.getFaulty80()) +
						Integer.parseInt(workOrderVodata.getFaulty81()) +
						Integer.parseInt(workOrderVodata.getFaulty82()) +
						Integer.parseInt(workOrderVodata.getFaulty83()) +
						Integer.parseInt(workOrderVodata.getFaulty84()) +
						Integer.parseInt(workOrderVodata.getFaulty85()) +
						Integer.parseInt(workOrderVodata.getFaulty86()) +
						Integer.parseInt(workOrderVodata.getFaulty87()) +
						Integer.parseInt(workOrderVodata.getFaulty88()) +
						Integer.parseInt(workOrderVodata.getFaulty89()) +
						Integer.parseInt(workOrderVodata.getFaulty90()) +
						Integer.parseInt(workOrderVodata.getFaulty91()) +
						Integer.parseInt(workOrderVodata.getFaulty92()) +
						Integer.parseInt(workOrderVodata.getFaulty93()) +
						Integer.parseInt(workOrderVodata.getFaulty94()) +
						Integer.parseInt(workOrderVodata.getFaulty95()) +
						Integer.parseInt(workOrderVodata.getFaulty96()) +
						Integer.parseInt(workOrderVodata.getFaulty97()) +
						Integer.parseInt(workOrderVodata.getFaulty98()) +
						Integer.parseInt(workOrderVodata.getFaulty99()) +
						Integer.parseInt(workOrderVodata.getFaulty100()) +
						Integer.parseInt(workOrderVodata.getFaulty101()) +
						Integer.parseInt(workOrderVodata.getFaulty102()) +
						Integer.parseInt(workOrderVodata.getFaulty103()) +
						Integer.parseInt(workOrderVodata.getFaulty104()) +
						Integer.parseInt(workOrderVodata.getFaulty105()) +
						Integer.parseInt(workOrderVodata.getFaulty106()) +
						Integer.parseInt(workOrderVodata.getFaulty107()) +
						Integer.parseInt(workOrderVodata.getFaulty108()) +
						Integer.parseInt(workOrderVodata.getFaulty109()) +
						Integer.parseInt(workOrderVodata.getFaulty110()) +
						Integer.parseInt(workOrderVodata.getFaulty111()) +
						Integer.parseInt(workOrderVodata.getFaulty112()) +
						Integer.parseInt(workOrderVodata.getFaulty113()) +
						Integer.parseInt(workOrderVodata.getFaulty114()) +
						Integer.parseInt(workOrderVodata.getFaulty115()) +
						Integer.parseInt(workOrderVodata.getFaulty116()) +
						Integer.parseInt(workOrderVodata.getFaulty117()) +
						Integer.parseInt(workOrderVodata.getFaulty118()) +
						Integer.parseInt(workOrderVodata.getFaulty119()) +
						Integer.parseInt(workOrderVodata.getFaulty120()) +
						Integer.parseInt(workOrderVodata.getFaulty121()) +
						Integer.parseInt(workOrderVodata.getFaulty122()) +
						Integer.parseInt(workOrderVodata.getFaulty123()) +
						Integer.parseInt(workOrderVodata.getFaulty124()) +
						Integer.parseInt(workOrderVodata.getFaulty125()) +
						Integer.parseInt(workOrderVodata.getFaulty126()) +
						Integer.parseInt(workOrderVodata.getFaulty127()) +
						Integer.parseInt(workOrderVodata.getFaulty128()) +
						Integer.parseInt(workOrderVodata.getFaulty129()) +
						Integer.parseInt(workOrderVodata.getFaulty130()) +
						Integer.parseInt(workOrderVodata.getFaulty131()) +
						Integer.parseInt(workOrderVodata.getFaulty132()) +
						Integer.parseInt(workOrderVodata.getFaulty133()) +
						Integer.parseInt(workOrderVodata.getFaulty134()) +
						Integer.parseInt(workOrderVodata.getFaulty135()) +
						Integer.parseInt(workOrderVodata.getFaulty136()) +
						Integer.parseInt(workOrderVodata.getFaulty137()) +
						Integer.parseInt(workOrderVodata.getFaulty138()) +
						Integer.parseInt(workOrderVodata.getFaulty139()) +
						Integer.parseInt(workOrderVodata.getFaulty140());
						
						//appearFaultyCnt불량수량
						//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setAppearFaultyCnt(totalfaulty);
						//userInputInspctCnt검사수량
						if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
							int valueDiff = 0;
							valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						} else {
							workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						}
						
						
						if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
							//appearFaultyCnt불량수량
							//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							int valueDiff = 0;
							if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
								valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
								workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							} else {
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							}
							//userInputInspctCnt검사수량
							//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							

							//엣지기포수량
							/*if( m.get(codeListArray[79]) != null) {
								workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
							} else {
								workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
							}*/
							
						} 
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	
	
	
	
	
	//품질관리 -불량집계현황(일자) 목록조회(작지번호별)_F3
	@RequestMapping(value = "qm/workOrderTotalDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderTotalDataListGet_F3(WorkOrderVo workOrderVo) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회(작지번호별)");
		try {
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				if(m.getBaseCd().equals("082")) {
					edgeGubunVal = idx;
				}
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = workOrderService.workOrderTotalDataList_F3(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
//					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));
				//appearFaultyCnt불량수량
				workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
				//userInputInspctCnt검사수량
				workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					//appearFaultyCnt불량수량
					workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					//userInputInspctCnt검사수량
					workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					//엣지기포수량
					/*if( m.get(codeListArray[79]) != null) {
						workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
					} else {
						workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
					}*/
					
				} 
				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	
	
	
	
	//품질관리 -불량집계현황(일자) 목록조회(작지번호별)
	@RequestMapping(value = "qm/comprehensiveQtyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> comprehensiveQtyList(WorkOrderVo workOrderVo) throws Exception {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회(작지번호별)");
		try {
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				if(m.getBaseCd().equals("024")) {
					edgeGubunVal = idx;
				}
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> comprehensiveQtyList = workOrderService.comprehensiveQtyList_F1F2(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : comprehensiveQtyList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				

				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
				Integer.parseInt(workOrderVodata.getFaulty2() ) +			
				Integer.parseInt(workOrderVodata.getFaulty3() ) +
				Integer.parseInt(workOrderVodata.getFaulty4() ) +
				Integer.parseInt(workOrderVodata.getFaulty5() ) +
				Integer.parseInt(workOrderVodata.getFaulty6() ) +
				Integer.parseInt(workOrderVodata.getFaulty7() ) +
				Integer.parseInt(workOrderVodata.getFaulty8() ) +
				Integer.parseInt(workOrderVodata.getFaulty9() ) +
				Integer.parseInt(workOrderVodata.getFaulty10()) +
				Integer.parseInt(workOrderVodata.getFaulty11()) +
				Integer.parseInt(workOrderVodata.getFaulty12()) +
				Integer.parseInt(workOrderVodata.getFaulty13()) +
				Integer.parseInt(workOrderVodata.getFaulty14()) +
				Integer.parseInt(workOrderVodata.getFaulty15()) +
				Integer.parseInt(workOrderVodata.getFaulty16()) +
				Integer.parseInt(workOrderVodata.getFaulty17()) +
				Integer.parseInt(workOrderVodata.getFaulty18()) +
				Integer.parseInt(workOrderVodata.getFaulty19()) +
				Integer.parseInt(workOrderVodata.getFaulty20()) +
				Integer.parseInt(workOrderVodata.getFaulty21()) +
				Integer.parseInt(workOrderVodata.getFaulty22()) +
				Integer.parseInt(workOrderVodata.getFaulty23()) +
				Integer.parseInt(workOrderVodata.getFaulty24()) +
				Integer.parseInt(workOrderVodata.getFaulty25()) +
				Integer.parseInt(workOrderVodata.getFaulty26()) +
				Integer.parseInt(workOrderVodata.getFaulty27()) +
				Integer.parseInt(workOrderVodata.getFaulty28()) +
				Integer.parseInt(workOrderVodata.getFaulty29()) +
				Integer.parseInt(workOrderVodata.getFaulty30()) +
				Integer.parseInt(workOrderVodata.getFaulty31()) +
				Integer.parseInt(workOrderVodata.getFaulty32()) +
				Integer.parseInt(workOrderVodata.getFaulty33()) +
				Integer.parseInt(workOrderVodata.getFaulty34()) +
				Integer.parseInt(workOrderVodata.getFaulty35()) +
				Integer.parseInt(workOrderVodata.getFaulty36()) +
				Integer.parseInt(workOrderVodata.getFaulty37()) +
				Integer.parseInt(workOrderVodata.getFaulty38()) +
				Integer.parseInt(workOrderVodata.getFaulty39()) +
				Integer.parseInt(workOrderVodata.getFaulty40()) +
				Integer.parseInt(workOrderVodata.getFaulty41()) +
				Integer.parseInt(workOrderVodata.getFaulty42()) +
				Integer.parseInt(workOrderVodata.getFaulty43()) +
				Integer.parseInt(workOrderVodata.getFaulty44()) +
				Integer.parseInt(workOrderVodata.getFaulty45()) +
				Integer.parseInt(workOrderVodata.getFaulty46()) +
				Integer.parseInt(workOrderVodata.getFaulty47()) +
				Integer.parseInt(workOrderVodata.getFaulty48()) +
				Integer.parseInt(workOrderVodata.getFaulty49()) +
				Integer.parseInt(workOrderVodata.getFaulty50()) +
				Integer.parseInt(workOrderVodata.getFaulty51()) +
				Integer.parseInt(workOrderVodata.getFaulty52()) +
				Integer.parseInt(workOrderVodata.getFaulty53()) +
				Integer.parseInt(workOrderVodata.getFaulty54()) +
				Integer.parseInt(workOrderVodata.getFaulty55()) +
				Integer.parseInt(workOrderVodata.getFaulty56()) +
				Integer.parseInt(workOrderVodata.getFaulty57()) +
				Integer.parseInt(workOrderVodata.getFaulty58()) +
				Integer.parseInt(workOrderVodata.getFaulty59()) +
				Integer.parseInt(workOrderVodata.getFaulty60()) +
				Integer.parseInt(workOrderVodata.getFaulty61()) +
				Integer.parseInt(workOrderVodata.getFaulty62()) +
				Integer.parseInt(workOrderVodata.getFaulty63()) +
				Integer.parseInt(workOrderVodata.getFaulty64()) +
				Integer.parseInt(workOrderVodata.getFaulty65()) +
				Integer.parseInt(workOrderVodata.getFaulty66()) +
				Integer.parseInt(workOrderVodata.getFaulty67()) +
				Integer.parseInt(workOrderVodata.getFaulty68()) +
				Integer.parseInt(workOrderVodata.getFaulty69()) +
				Integer.parseInt(workOrderVodata.getFaulty70()) +
				Integer.parseInt(workOrderVodata.getFaulty71()) +
				Integer.parseInt(workOrderVodata.getFaulty72()) +
				Integer.parseInt(workOrderVodata.getFaulty73()) +
				Integer.parseInt(workOrderVodata.getFaulty74()) +
				Integer.parseInt(workOrderVodata.getFaulty75()) +
				Integer.parseInt(workOrderVodata.getFaulty76()) +
				Integer.parseInt(workOrderVodata.getFaulty77()) +
				Integer.parseInt(workOrderVodata.getFaulty78()) +
				Integer.parseInt(workOrderVodata.getFaulty79()) +
				Integer.parseInt(workOrderVodata.getFaulty80()) +
				Integer.parseInt(workOrderVodata.getFaulty81()) +
				Integer.parseInt(workOrderVodata.getFaulty82()) +
				Integer.parseInt(workOrderVodata.getFaulty83()) +
				Integer.parseInt(workOrderVodata.getFaulty84()) +
				Integer.parseInt(workOrderVodata.getFaulty85()) +
				Integer.parseInt(workOrderVodata.getFaulty86()) +
				Integer.parseInt(workOrderVodata.getFaulty87()) +
				Integer.parseInt(workOrderVodata.getFaulty88()) +
				Integer.parseInt(workOrderVodata.getFaulty89()) +
				Integer.parseInt(workOrderVodata.getFaulty90()) +
				Integer.parseInt(workOrderVodata.getFaulty91()) +
				Integer.parseInt(workOrderVodata.getFaulty92()) +
				Integer.parseInt(workOrderVodata.getFaulty93()) +
				Integer.parseInt(workOrderVodata.getFaulty94()) +
				Integer.parseInt(workOrderVodata.getFaulty95()) +
				Integer.parseInt(workOrderVodata.getFaulty96()) +
				Integer.parseInt(workOrderVodata.getFaulty97()) +
				Integer.parseInt(workOrderVodata.getFaulty98()) +
				Integer.parseInt(workOrderVodata.getFaulty99()) +
				Integer.parseInt(workOrderVodata.getFaulty100()) +
				Integer.parseInt(workOrderVodata.getFaulty101()) +
				Integer.parseInt(workOrderVodata.getFaulty102()) +
				Integer.parseInt(workOrderVodata.getFaulty103()) +
				Integer.parseInt(workOrderVodata.getFaulty104()) +
				Integer.parseInt(workOrderVodata.getFaulty105()) +
				Integer.parseInt(workOrderVodata.getFaulty106()) +
				Integer.parseInt(workOrderVodata.getFaulty107()) +
				Integer.parseInt(workOrderVodata.getFaulty108()) +
				Integer.parseInt(workOrderVodata.getFaulty109()) +
				Integer.parseInt(workOrderVodata.getFaulty110()) +
				Integer.parseInt(workOrderVodata.getFaulty111()) +
				Integer.parseInt(workOrderVodata.getFaulty112()) +
				Integer.parseInt(workOrderVodata.getFaulty113()) +
				Integer.parseInt(workOrderVodata.getFaulty114()) +
				Integer.parseInt(workOrderVodata.getFaulty115()) +
				Integer.parseInt(workOrderVodata.getFaulty116()) +
				Integer.parseInt(workOrderVodata.getFaulty117()) +
				Integer.parseInt(workOrderVodata.getFaulty118()) +
				Integer.parseInt(workOrderVodata.getFaulty119()) +
				Integer.parseInt(workOrderVodata.getFaulty120()) +
				Integer.parseInt(workOrderVodata.getFaulty121()) +
				Integer.parseInt(workOrderVodata.getFaulty122()) +
				Integer.parseInt(workOrderVodata.getFaulty123()) +
				Integer.parseInt(workOrderVodata.getFaulty124()) +
				Integer.parseInt(workOrderVodata.getFaulty125()) +
				Integer.parseInt(workOrderVodata.getFaulty126()) +
				Integer.parseInt(workOrderVodata.getFaulty127()) +
				Integer.parseInt(workOrderVodata.getFaulty128()) +
				Integer.parseInt(workOrderVodata.getFaulty129()) +
				Integer.parseInt(workOrderVodata.getFaulty130()) +
				Integer.parseInt(workOrderVodata.getFaulty131()) +
				Integer.parseInt(workOrderVodata.getFaulty132()) +
				Integer.parseInt(workOrderVodata.getFaulty133()) +
				Integer.parseInt(workOrderVodata.getFaulty134()) +
				Integer.parseInt(workOrderVodata.getFaulty135()) +
				Integer.parseInt(workOrderVodata.getFaulty136()) +
				Integer.parseInt(workOrderVodata.getFaulty137()) +
				Integer.parseInt(workOrderVodata.getFaulty138()) +
				Integer.parseInt(workOrderVodata.getFaulty139()) +
				Integer.parseInt(workOrderVodata.getFaulty140());
				
				//appearFaultyCnt불량수량
				//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
				workOrderVodata.setAppearFaultyCnt(totalfaulty);
				//userInputInspctCnt검사수량
				if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
					int valueDiff = 0;
					valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
					workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
				} else {
					workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
				}
				
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					//appearFaultyCnt불량수량
					//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					int valueDiff = 0;
					if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
						valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					} else {
						workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					}
					//userInputInspctCnt검사수량
					//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					

					//엣지기포수량
					/*if( m.get(codeListArray[79]) != null) {
						workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
					} else {
						workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
					}*/
					
				} 
				
				if( m.get(codeListArray[200]) != null) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(종합수량) 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	//최종검사현황(작업자목록조회 )
	@RequestMapping(value="qm/finalInspectionWorkerList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> finalInspectionWorkerList(MatrlUserVo matrlUserVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("최종검사현황(작업자목록조회 ) : "+matrlUserVo);
		try {
			List<MatrlUserVo> finalInspectionWorkerList = matrlUserService.finalInspectionWorkerList(matrlUserVo);
			jsonData.put("data", finalInspectionWorkerList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	} 
	
	//품질관리 - 생산비전불량(작업지시별)
	@RequestMapping(value = "qm/visionWorkOrdTotalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionWorkOrdTotalList(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산비전불량(작업지시별) 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("094"); //생산 비전불량수량 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[100];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("생산비전불량(작업지시별) - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			
			List<Map<String, String>> workOrderList = workOrderService.visionWorkOrdTotalList_nF2(workOrderVo);
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setWorkOrdNo(String.valueOf(m.get("WORK_ORD_NO")));
				workOrderVodata.setLotNo(String.valueOf(m.get("LOT_NO")));
				workOrderVodata.setFaultyCntSum(String.valueOf(m.get("FAULTY_CNT_SUM")));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));

				dataList.add(workOrderVodata);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산비전불량(작업지시별) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리/최종검사현황 - 생산비전불량(작업자)
	@RequestMapping(value = "qm/visionChargerTotalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionChargerTotalList(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산비전불량(작업자) 목록조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("094"); //생산 비전불량수량 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[100];
			//String[] codeListArray = new String[systemCommonCodeList.size()];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				//logger.info("최종검사현황 목록 조회" + codeListArray[idx]);
				idx++;
			}
			logger.info("생산비전불량(작업자) - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));
			
			List<Map<String, String>> workOrderList = workOrderService.visionChargerTotalList_nF2(workOrderVo);
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setInspctChargr(String.valueOf(m.get("INSPCT_CHARGER")));
				workOrderVodata.setUserNm(String.valueOf(m.get("USER_NM")));
				workOrderVodata.setUserId(String.valueOf(m.get("USER_ID")));
				workOrderVodata.setFaultyCntSum(String.valueOf(m.get("FAULTY_CNT_SUM")));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));

				dataList.add(workOrderVodata);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산비전불량(작업자) 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//품질관리 - 불량집계현황 페이지
	@RequestMapping(value = "/qmsc0090", method = RequestMethod.GET)
	public String qmsc0090GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(기간) 페이지");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();			

		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "qm/qmsc0090";
	}
	
	//품질관리 - 불량집계현황 페이지fa2
	@RequestMapping(value = "/qmsc2090", method = RequestMethod.GET)
	public String qmsc2090GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(기간) 페이지");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();			

		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "qm/qmsc2090";
	}
		
	
	//품질관리 - 불량집계현황 페이지fa2
	@RequestMapping(value = "/qmsc2100", method = RequestMethod.GET)
	public String qmsc2100GET(Locale locale, Model model) throws Exception {

		logger.info("불량집계현황(기간) 페이지");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();			

		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "qm/qmsc2100";
	}
	
	//불량집계현황(기간) 기간별 조회
	@RequestMapping(value = "qm/faultyWeekTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWeekTotalDataListGET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 기간별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("최종검사집계(기간) 목록 조회" + codeListArray[idx]);
				idx++;
			}
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWeekTotalList(goodsFaultyAdmVo);			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));

				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//불량집계현황(기간) 기간별 조회 - Fa2
	@RequestMapping(value = "qm/faultyWeekTotalDataListFa2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWeekTotalDataListFa2GET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 기간별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				logger.info("최종검사집계(기간) 목록 조회" + codeListArray[idx]);
				idx++;
			}
			List<Map<String, String>> workOrderList = new ArrayList<Map<String, String>>();
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			if (workOrderVo.getMenuAuth().equals("qmsc2100")) {
				workOrderList = goodsInspectService.faultyWeekTotalSumListFa2(goodsFaultyAdmVo);		
			} else {
				workOrderList = goodsInspectService.faultyWeekTotalListFa2(goodsFaultyAdmVo);		
			}	
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setAppearInspctDate(m.get("WORK_ORD_DATE"));
				workOrderVodata.setReInspCnt(String.valueOf((m.get("RE_INSP_CNT"))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
				if(m.get("MATRL_FAULTY_CNT") == null) {
					workOrderVodata.setMatrlFaultyCnt(0);
				} else {
					workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
				}
				if(m.get("FILM_FAULTY_CNT") == null) {
					workOrderVodata.setFilmFaultyCnt(0);
				} else {
					workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
				}
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
		
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				if( m.get(codeListArray[200]) != null) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				dataList.add(workOrderVodata);
			}
			
			
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//불량집계현황(기간) 기간별 조회 - 설비별/주야/제품별
	@RequestMapping(value = "qm/faultyEquipGoodsTotalListFa", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyEquipGoodsTotalListFaGET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 설비별/주야/제품별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();		
				if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				logger.info("최종검사집계(기간) 설비별/주야/제품별 목록 조회" + codeListArray[idx]);
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			List<Map<String, String>> workOrderList;
			//if(facotryCode.equals("003")) {
			//	 workOrderList = goodsInspectService.faultyEquipGoodsTotalListFa3(goodsFaultyAdmVo);
			//} else {
//				 workOrderList = goodsInspectService.faultyEquipGoodsTotalListFa(goodsFaultyAdmVo);
			//}				
			if (workOrderVo.getMenuAuth().equals("qmsc2100")) {
				workOrderList = goodsInspectService.faultyEquipGoodsTotalSumListFa(goodsFaultyAdmVo);		
			} else {
				workOrderList = goodsInspectService.faultyEquipGoodsTotalListFa(goodsFaultyAdmVo);		
			}	
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
				
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
				if(m.get("MATRL_FAULTY_CNT") == null) {
					workOrderVodata.setMatrlFaultyCnt(0);
				} else {
					workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
				}
				if(m.get("FILM_FAULTY_CNT") == null) {
					workOrderVodata.setFilmFaultyCnt(0);
				} else {
					workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
				}		
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
				
				workOrderVodata.setEquipNm(String.valueOf((m.get("EQUIP_NM"))));
				workOrderVodata.setGoodsNm(String.valueOf((m.get("GOODS_NM"))));
				workOrderVodata.setGoodsCd(String.valueOf((m.get("GOODS_CD"))));
				workOrderVodata.setEquipCd(String.valueOf((m.get("EQUIP_CD"))));
				workOrderVodata.setGubun(String.valueOf((m.get("GUBUN"))));
				workOrderVodata.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
		
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				if( m.get(codeListArray[200]) != null) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 설비별/주야/제품별 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//불량집계현황(기간) 제품별 조회
	@RequestMapping(value = "qm/faultyGoodsTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWeekGoodsDataListGET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 제품별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("최종검사집계(제품) 목록 조회" + codeListArray[idx]);
				idx++;
				
			}
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyGoodsTotalList(goodsFaultyAdmVo);			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());	
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());	
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//불량집계현황(기간) 제품별 조회fa2
		@RequestMapping(value = "qm/faultyGoodsTotalDataListFa2", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> faultyWeekGoodsDataListFa2GET(WorkOrderVo workOrderVo) throws Exception {
			
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("불량집계현황(기간) 제품별 조회");
			try {
				GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
				goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
		
				SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
				systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
				List<SystemCommonCodeVo>  systemCommonCodeList;
				if(facotryCode.equals("003")) {
					 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
				} else {
					 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
				}
				//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
				
				String codeList = "";			
				String[] codeListArray = new String[201];
				Arrays.fill(codeListArray, "0");
				int idx = 0, edgeGubunVal = 0;
				for(SystemCommonCodeVo m : systemCommonCodeList) {
					
					codeList += "[" + m.getBaseCd() + "]" + ",";
					codeListArray[idx] = m.getBaseCd();					
					logger.info("최종검사집계(제품) 목록 조회" + codeListArray[idx]);
					if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
						if(m.getBaseCd().equals("082")) {
							edgeGubunVal = idx;
						}	
					} else {
						if(m.getBaseCd().equals("024")) {
							edgeGubunVal = idx;
						}
					}
					
					idx++;
					
				}
				codeList += "[" + 200 + "]" + ",";
				codeListArray[200] = "200";
				goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));	
				

				List<Map<String, String>> workOrderList = new ArrayList<Map<String, String>>();
				if (workOrderVo.getMenuAuth().equals("qmsc2100")) {
					workOrderList = goodsInspectService.faultyGoodsTotalSumListFa2(goodsFaultyAdmVo);		
				} else {
					workOrderList = goodsInspectService.faultyGoodsTotalListFa2(goodsFaultyAdmVo);		
				}		
				List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
				
				for(Map<String, String> m : workOrderList) {
					WorkOrderVo workOrderVodata = new WorkOrderVo();
					//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
					//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
					workOrderVodata.setReInspCnt(String.valueOf((m.get("RE_INSP_CNT"))));
					workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
					workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
					if(m.get("MATRL_FAULTY_CNT") == null) {
						workOrderVodata.setMatrlFaultyCnt(0);
					} else {
						workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
					}
					if(m.get("FILM_FAULTY_CNT") == null) {
						workOrderVodata.setFilmFaultyCnt(0);
					} else {
						workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
					}
					//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
					workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
					workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
					workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
					workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());	
					workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());	
			
					workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
					workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
					workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
					workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
					workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
					workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
					workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
					workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
					workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
					workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
					workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
					workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
					workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
					workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
					workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
					workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
					workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
					workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
					workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
					workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
					workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
					workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
					workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
					workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
					workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
					workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
					workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
					workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
					workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
					workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
					workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
					workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
					workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
					workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
					workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
					workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
					workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
					workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
					workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
					workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
					workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
					workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
					workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
					workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
					workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
					workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
					workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
					workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
					workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
					workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
					workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
					workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
					workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
					workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
					workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
					workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
					workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
					workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
					workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
					workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
					workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
					workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
					workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
					workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
					workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
					workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
					workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
					workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
					workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
					workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
					workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
					workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
					workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
					workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
					workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
					workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
					workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
					workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
					workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
					workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

					
					
					workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
					workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
					workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
					workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
					workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
					workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
					workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
					workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
					workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
					workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
					workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
					workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
					workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
					workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
					workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
					workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
					workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
					workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
					workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
					workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
					workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
					workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
					workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
					workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
					workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
					workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
					workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
					workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
					workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
					workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
					workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
					workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
					workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
					workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
					workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
					workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
					workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
					workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
					workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
					workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
					workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
					workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
					workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
					workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
					workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
					workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
					workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
					workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
					workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
					workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
					workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
					workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
					workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
					workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
					workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
					workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
					workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
					workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
					workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
					workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
					if( m.get(codeListArray[200]) != null) {
						switch(edgeGubunVal) {
							case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
							case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
							case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
							case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
							case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
							case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
							case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
							case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
							case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
							case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
							case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
							case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
							case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
							case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
							case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
							case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
							case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
							case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
							case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
							case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
							case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
							case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
							case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
							case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
							case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
							case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
							case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
							case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
							case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
							case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
							case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
							case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
							case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
							case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
							case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
							case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
							case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
							case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
							case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
							case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
							case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
							case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
							case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
							case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
							case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
							case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
							case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
							case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
							case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
							case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
							case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
							case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
							case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
							case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
							case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
							case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
							case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
							case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
							case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
							case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
							case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
							case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
							case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
							case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
							case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
							case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
							case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
							case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
							case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
							case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
							case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
							case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
							case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
							case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
							case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
							case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
							case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
							case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
							case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
							case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
							case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
							case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
							case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
							case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
							case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
							case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
							case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
							case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
							case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
							case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
							case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
							case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
							case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
							case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
							case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
							case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
							case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
							case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
							case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
							case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
							case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
							case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
							case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
							case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
							case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
							case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
							case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
							case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
							case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
							case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
							case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
							case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
							case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
							case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
							case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
							case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
							case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
							case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
							case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
							case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
							case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
							case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
							case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
							case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
							case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
							case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
							case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
							case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
							case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
							case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
							case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
							case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
							case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
							case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
							case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
							case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
							case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
							case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
							case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
							case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
						}
					}
					
					dataList.add(workOrderVodata);
				}
							
				
				jsonData.put("data", dataList);
				jsonData.put("result", "ok");
			} catch (Exception e) {
				logger.info("불량집계현황(기간) 기간별 조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}
			return jsonData;
		}
		
		
		
	//불량집계현황(기간) 유형별 조회
	@RequestMapping(value = "qm/faultyTypeTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWeekTypeDataListGET(GoodsFaultyAdmVo  goodsFaultyAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 유형별 조회");
		try {
			List<GoodsFaultyAdmVo > goodsFaultyAdmVoList = goodsInspectService.faultyTypeTotalList(goodsFaultyAdmVo);
			jsonData.put("data", goodsFaultyAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 유형별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//불량집계현황(기간) 유형별 조회-fa2
		@RequestMapping(value = "qm/faultyTypeTotalDataListFa2", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> faultyWeekTypeDataListFa2GET(GoodsFaultyAdmVo  goodsFaultyAdmVo) throws Exception {
			
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("불량집계현황(기간) 유형별 조회");
			try {
				List<GoodsFaultyAdmVo > goodsFaultyAdmVoList = goodsInspectService.faultyTypeTotalListFa2(goodsFaultyAdmVo);
				jsonData.put("data", goodsFaultyAdmVoList);
				jsonData.put("result", "ok");
			} catch (Exception e) {
				logger.info("불량집계현황(기간) 유형별 조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}
			return jsonData;
		}
	//불량집계현황(기간) 설비별 조회
	@RequestMapping(value = "qm/faultyEquipTotalDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyEquipTotalDataListGET(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 설비별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("최종검사집계(설비) 목록 조회" + codeListArray[idx]);
				idx++;
				
			}
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyEquipTotalDataList(goodsFaultyAdmVo);			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());	
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());	
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 설비별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	//불량집계현황(기간) 설비별 조회 Fa2
		@RequestMapping(value = "qm/faultyEquipTotalDataListFa2", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> faultyEquipTotalDataListFa2GET(WorkOrderVo workOrderVo) throws Exception {
			
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("불량집계현황(기간) 설비별 조회");
			try {
				GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
				goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
		
				SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
				systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
				List<SystemCommonCodeVo>  systemCommonCodeList;
				if(facotryCode.equals("003")) {
					 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
				} else {
					 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
				}
				//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
				
				String codeList = "";			
				String[] codeListArray = new String[201];
				Arrays.fill(codeListArray, "0");
				int idx = 0, edgeGubunVal = 0;
				for(SystemCommonCodeVo m : systemCommonCodeList) {
					
					codeList += "[" + m.getBaseCd() + "]" + ",";
					codeListArray[idx] = m.getBaseCd();					
					logger.info("최종검사집계(설비) 목록 조회" + codeListArray[idx]);
					if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
						if(m.getBaseCd().equals("082")) {
							edgeGubunVal = idx;
						}	
					} else {
						if(m.getBaseCd().equals("024")) {
							edgeGubunVal = idx;
						}
					}
					
					idx++;
					
				}
				codeList += "[" + 200 + "]" + ",";
				codeListArray[200] = "200";
				goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));		
				List<Map<String, String>> workOrderList = new ArrayList<Map<String, String>>();
				if (workOrderVo.getMenuAuth().equals("qmsc2100")) {
					workOrderList = goodsInspectService.faultyEquipTotalSumDataListFa2(goodsFaultyAdmVo);		
				} else {
					workOrderList = goodsInspectService.faultyEquipTotalDataListFa2(goodsFaultyAdmVo);		
				}				
				List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
				
				for(Map<String, String> m : workOrderList) {
					WorkOrderVo workOrderVodata = new WorkOrderVo();
					//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
					//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
					workOrderVodata.setReInspCnt(String.valueOf((m.get("RE_INSP_CNT"))));
					workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
					workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
					if(m.get("MATRL_FAULTY_CNT") == null) {
						workOrderVodata.setMatrlFaultyCnt(0);
					} else {
						workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
					}
					if(m.get("FILM_FAULTY_CNT") == null) {
						workOrderVodata.setFilmFaultyCnt(0);
					} else {
						workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
					}
					//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
					workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
					workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
					workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
					workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());	
					workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
					//workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
			
					workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
					workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
					workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
					workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
					workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
					workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
					workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
					workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
					workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
					workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
					workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
					workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
					workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
					workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
					workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
					workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
					workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
					workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
					workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
					workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
					workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
					workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
					workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
					workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
					workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
					workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
					workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
					workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
					workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
					workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
					workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
					workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
					workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
					workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
					workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
					workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
					workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
					workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
					workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
					workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
					workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
					workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
					workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
					workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
					workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
					workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
					workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
					workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
					workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
					workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
					workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
					workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
					workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
					workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
					workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
					workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
					workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
					workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
					workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
					workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
					workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
					workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
					workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
					workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
					workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
					workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
					workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
					workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
					workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
					workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
					workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
					workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
					workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
					workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
					workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
					workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
					workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
					workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
					workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
					workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

					
					
					workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
					workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
					workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
					workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
					workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
					workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
					workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
					workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
					workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
					workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
					workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
					workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
					workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
					workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
					workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
					workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
					workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
					workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
					workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
					workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
					workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
					workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
					workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
					workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
					workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
					workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
					workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
					workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
					workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
					workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
					workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
					workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
					workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
					workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
					workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
					workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
					workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
					workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
					workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
					workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
					workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
					workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
					workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
					workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
					workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
					workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
					workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
					workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
					workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
					workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
					workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
					workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
					workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
					workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
					workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
					workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
					workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
					workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
					workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
					workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
					if( m.get(codeListArray[200]) != null) {
						switch(edgeGubunVal) {
							case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
							case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
							case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
							case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
							case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
							case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
							case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
							case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
							case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
							case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
							case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
							case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
							case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
							case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
							case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
							case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
							case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
							case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
							case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
							case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
							case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
							case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
							case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
							case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
							case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
							case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
							case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
							case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
							case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
							case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
							case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
							case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
							case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
							case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
							case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
							case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
							case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
							case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
							case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
							case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
							case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
							case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
							case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
							case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
							case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
							case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
							case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
							case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
							case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
							case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
							case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
							case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
							case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
							case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
							case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
							case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
							case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
							case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
							case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
							case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
							case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
							case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
							case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
							case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
							case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
							case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
							case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
							case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
							case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
							case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
							case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
							case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
							case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
							case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
							case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
							case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
							case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
							case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
							case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
							case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
							case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
							case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
							case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
							case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
							case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
							case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
							case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
							case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
							case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
							case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
							case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
							case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
							case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
							case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
							case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
							case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
							case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
							case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
							case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
							case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
							case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
							case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
							case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
							case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
							case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
							case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
							case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
							case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
							case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
							case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
							case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
							case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
							case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
							case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
							case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
							case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
							case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
							case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
							case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
							case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
							case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
							case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
							case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
							case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
							case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
							case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
							case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
							case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
							case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
							case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
							case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
							case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
							case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
							case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
							case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
							case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
							case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
							case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
							case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
							case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
						}
					}
					dataList.add(workOrderVodata);
				}
							
				
				jsonData.put("data", dataList);
				jsonData.put("result", "ok");
				
			} catch (Exception e) {
				logger.info("불량집계현황(기간) 설비별 조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");
			}
			return jsonData;
		}
		
		
		
		
		
		
		
		
		
		
		
	//불량집계현황(공정 불량) 기간별 조회 - Fa2
	@RequestMapping(value = "qm/faultyProcessTotalDataListFa2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyProcessTotalDataListFa2GET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(공정 불량) 기간별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			
			if( !facotryCode.equals("003") ) {
				systemCommonCodeVo.setEtc5("002"); // 공정 불량만 가지고 옴				
			}
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			/*
			 * systemCommonCodeList.get(0).getEtc5() != null
			 * systemCommonCodeList.get(0).getEtc5().equals("002");
			 */
			
			String codeList = "";			
			String[] codeListArray = new String[140];
			Arrays.fill(codeListArray, "0");
			int idx = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("최종검사집계(공정 불량) 목록 조회" + codeListArray[idx]);
				idx++;
			}
			
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));
			
			String processList = codeList.substring(0,codeList.length()-1);
			logger.info("processList -----> " +processList);
			processList = processList.replace("[", "'").replace("]", "'");
			
			goodsFaultyAdmVo.setProcessList(processList);
			List<Map<String, String>> workOrderList = goodsInspectService.faultyProcessTotalListFa2(goodsFaultyAdmVo);			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
		
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1])));
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79])));				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139])));
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검포함 리스트 조회
	@RequestMapping(value = "qm/faultyWorkOrdNoReInspListFa", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWorkOrdNoReInspListFaGET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황 목록조회(작지번호별)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWorkOrdNoReInspListFa(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
//				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setCnt(String.valueOf((m.get("CNT"))));
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());		
				//System.out.println(workOrderVodata.getModel());
				workOrderVodata.setSeq(String.valueOf((m.get("SEQ"))));
				workOrderVodata.setTrayNo(m.get("TRAY_NO").toString());				
				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				//appearFaultyCnt불량수량
			//	workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
			//	//userInputInspctCnt검사수량
			//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
			//	
			//	if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
			//		//appearFaultyCnt불량수량
			//		workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//userInputInspctCnt검사수량
			//		workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//엣지기포수량
			//		/*if( m.get(codeListArray[79]) != null) {
			//			workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
			//		} else {
			//			workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
			//		}*/
			//		
			//	} 
			//	
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
						Integer.parseInt(workOrderVodata.getFaulty2() ) +			
						Integer.parseInt(workOrderVodata.getFaulty3() ) +
						Integer.parseInt(workOrderVodata.getFaulty4() ) +
						Integer.parseInt(workOrderVodata.getFaulty5() ) +
						Integer.parseInt(workOrderVodata.getFaulty6() ) +
						Integer.parseInt(workOrderVodata.getFaulty7() ) +
						Integer.parseInt(workOrderVodata.getFaulty8() ) +
						Integer.parseInt(workOrderVodata.getFaulty9() ) +
						Integer.parseInt(workOrderVodata.getFaulty10()) +
						Integer.parseInt(workOrderVodata.getFaulty11()) +
						Integer.parseInt(workOrderVodata.getFaulty12()) +
						Integer.parseInt(workOrderVodata.getFaulty13()) +
						Integer.parseInt(workOrderVodata.getFaulty14()) +
						Integer.parseInt(workOrderVodata.getFaulty15()) +
						Integer.parseInt(workOrderVodata.getFaulty16()) +
						Integer.parseInt(workOrderVodata.getFaulty17()) +
						Integer.parseInt(workOrderVodata.getFaulty18()) +
						Integer.parseInt(workOrderVodata.getFaulty19()) +
						Integer.parseInt(workOrderVodata.getFaulty20()) +
						Integer.parseInt(workOrderVodata.getFaulty21()) +
						Integer.parseInt(workOrderVodata.getFaulty22()) +
						Integer.parseInt(workOrderVodata.getFaulty23()) +
						Integer.parseInt(workOrderVodata.getFaulty24()) +
						Integer.parseInt(workOrderVodata.getFaulty25()) +
						Integer.parseInt(workOrderVodata.getFaulty26()) +
						Integer.parseInt(workOrderVodata.getFaulty27()) +
						Integer.parseInt(workOrderVodata.getFaulty28()) +
						Integer.parseInt(workOrderVodata.getFaulty29()) +
						Integer.parseInt(workOrderVodata.getFaulty30()) +
						Integer.parseInt(workOrderVodata.getFaulty31()) +
						Integer.parseInt(workOrderVodata.getFaulty32()) +
						Integer.parseInt(workOrderVodata.getFaulty33()) +
						Integer.parseInt(workOrderVodata.getFaulty34()) +
						Integer.parseInt(workOrderVodata.getFaulty35()) +
						Integer.parseInt(workOrderVodata.getFaulty36()) +
						Integer.parseInt(workOrderVodata.getFaulty37()) +
						Integer.parseInt(workOrderVodata.getFaulty38()) +
						Integer.parseInt(workOrderVodata.getFaulty39()) +
						Integer.parseInt(workOrderVodata.getFaulty40()) +
						Integer.parseInt(workOrderVodata.getFaulty41()) +
						Integer.parseInt(workOrderVodata.getFaulty42()) +
						Integer.parseInt(workOrderVodata.getFaulty43()) +
						Integer.parseInt(workOrderVodata.getFaulty44()) +
						Integer.parseInt(workOrderVodata.getFaulty45()) +
						Integer.parseInt(workOrderVodata.getFaulty46()) +
						Integer.parseInt(workOrderVodata.getFaulty47()) +
						Integer.parseInt(workOrderVodata.getFaulty48()) +
						Integer.parseInt(workOrderVodata.getFaulty49()) +
						Integer.parseInt(workOrderVodata.getFaulty50()) +
						Integer.parseInt(workOrderVodata.getFaulty51()) +
						Integer.parseInt(workOrderVodata.getFaulty52()) +
						Integer.parseInt(workOrderVodata.getFaulty53()) +
						Integer.parseInt(workOrderVodata.getFaulty54()) +
						Integer.parseInt(workOrderVodata.getFaulty55()) +
						Integer.parseInt(workOrderVodata.getFaulty56()) +
						Integer.parseInt(workOrderVodata.getFaulty57()) +
						Integer.parseInt(workOrderVodata.getFaulty58()) +
						Integer.parseInt(workOrderVodata.getFaulty59()) +
						Integer.parseInt(workOrderVodata.getFaulty60()) +
						Integer.parseInt(workOrderVodata.getFaulty61()) +
						Integer.parseInt(workOrderVodata.getFaulty62()) +
						Integer.parseInt(workOrderVodata.getFaulty63()) +
						Integer.parseInt(workOrderVodata.getFaulty64()) +
						Integer.parseInt(workOrderVodata.getFaulty65()) +
						Integer.parseInt(workOrderVodata.getFaulty66()) +
						Integer.parseInt(workOrderVodata.getFaulty67()) +
						Integer.parseInt(workOrderVodata.getFaulty68()) +
						Integer.parseInt(workOrderVodata.getFaulty69()) +
						Integer.parseInt(workOrderVodata.getFaulty70()) +
						Integer.parseInt(workOrderVodata.getFaulty71()) +
						Integer.parseInt(workOrderVodata.getFaulty72()) +
						Integer.parseInt(workOrderVodata.getFaulty73()) +
						Integer.parseInt(workOrderVodata.getFaulty74()) +
						Integer.parseInt(workOrderVodata.getFaulty75()) +
						Integer.parseInt(workOrderVodata.getFaulty76()) +
						Integer.parseInt(workOrderVodata.getFaulty77()) +
						Integer.parseInt(workOrderVodata.getFaulty78()) +
						Integer.parseInt(workOrderVodata.getFaulty79()) +
						Integer.parseInt(workOrderVodata.getFaulty80()) +
						Integer.parseInt(workOrderVodata.getFaulty81()) +
						Integer.parseInt(workOrderVodata.getFaulty82()) +
						Integer.parseInt(workOrderVodata.getFaulty83()) +
						Integer.parseInt(workOrderVodata.getFaulty84()) +
						Integer.parseInt(workOrderVodata.getFaulty85()) +
						Integer.parseInt(workOrderVodata.getFaulty86()) +
						Integer.parseInt(workOrderVodata.getFaulty87()) +
						Integer.parseInt(workOrderVodata.getFaulty88()) +
						Integer.parseInt(workOrderVodata.getFaulty89()) +
						Integer.parseInt(workOrderVodata.getFaulty90()) +
						Integer.parseInt(workOrderVodata.getFaulty91()) +
						Integer.parseInt(workOrderVodata.getFaulty92()) +
						Integer.parseInt(workOrderVodata.getFaulty93()) +
						Integer.parseInt(workOrderVodata.getFaulty94()) +
						Integer.parseInt(workOrderVodata.getFaulty95()) +
						Integer.parseInt(workOrderVodata.getFaulty96()) +
						Integer.parseInt(workOrderVodata.getFaulty97()) +
						Integer.parseInt(workOrderVodata.getFaulty98()) +
						Integer.parseInt(workOrderVodata.getFaulty99()) +
						Integer.parseInt(workOrderVodata.getFaulty100()) +
						Integer.parseInt(workOrderVodata.getFaulty101()) +
						Integer.parseInt(workOrderVodata.getFaulty102()) +
						Integer.parseInt(workOrderVodata.getFaulty103()) +
						Integer.parseInt(workOrderVodata.getFaulty104()) +
						Integer.parseInt(workOrderVodata.getFaulty105()) +
						Integer.parseInt(workOrderVodata.getFaulty106()) +
						Integer.parseInt(workOrderVodata.getFaulty107()) +
						Integer.parseInt(workOrderVodata.getFaulty108()) +
						Integer.parseInt(workOrderVodata.getFaulty109()) +
						Integer.parseInt(workOrderVodata.getFaulty110()) +
						Integer.parseInt(workOrderVodata.getFaulty111()) +
						Integer.parseInt(workOrderVodata.getFaulty112()) +
						Integer.parseInt(workOrderVodata.getFaulty113()) +
						Integer.parseInt(workOrderVodata.getFaulty114()) +
						Integer.parseInt(workOrderVodata.getFaulty115()) +
						Integer.parseInt(workOrderVodata.getFaulty116()) +
						Integer.parseInt(workOrderVodata.getFaulty117()) +
						Integer.parseInt(workOrderVodata.getFaulty118()) +
						Integer.parseInt(workOrderVodata.getFaulty119()) +
						Integer.parseInt(workOrderVodata.getFaulty120()) +
						Integer.parseInt(workOrderVodata.getFaulty121()) +
						Integer.parseInt(workOrderVodata.getFaulty122()) +
						Integer.parseInt(workOrderVodata.getFaulty123()) +
						Integer.parseInt(workOrderVodata.getFaulty124()) +
						Integer.parseInt(workOrderVodata.getFaulty125()) +
						Integer.parseInt(workOrderVodata.getFaulty126()) +
						Integer.parseInt(workOrderVodata.getFaulty127()) +
						Integer.parseInt(workOrderVodata.getFaulty128()) +
						Integer.parseInt(workOrderVodata.getFaulty129()) +
						Integer.parseInt(workOrderVodata.getFaulty130()) +
						Integer.parseInt(workOrderVodata.getFaulty131()) +
						Integer.parseInt(workOrderVodata.getFaulty132()) +
						Integer.parseInt(workOrderVodata.getFaulty133()) +
						Integer.parseInt(workOrderVodata.getFaulty134()) +
						Integer.parseInt(workOrderVodata.getFaulty135()) +
						Integer.parseInt(workOrderVodata.getFaulty136()) +
						Integer.parseInt(workOrderVodata.getFaulty137()) +
						Integer.parseInt(workOrderVodata.getFaulty138()) +
						Integer.parseInt(workOrderVodata.getFaulty139()) +
						Integer.parseInt(workOrderVodata.getFaulty140());
						
						//appearFaultyCnt불량수량
						//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setAppearFaultyCnt(totalfaulty);
						//userInputInspctCnt검사수량
						if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
							int valueDiff = 0;
							valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						} else {
							workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						}
						
						
						if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
							//appearFaultyCnt불량수량
							//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							int valueDiff = 0;
							if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
								valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
								workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							} else {
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							}
							//userInputInspctCnt검사수량
							//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							

							//엣지기포수량
							/*if( m.get(codeListArray[79]) != null) {
								workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
							} else {
								workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
							}*/
							
						} 
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검집계 리스트 조회
	@RequestMapping(value = "qm/faultyWorkOrdNoReInspTotalListFa", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWorkOrdNoReInspTotalListFaGET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산검사현황 목록조회(재검집계)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWorkOrdNoReInspTotalListFa(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
				
				workOrderVodata.setWorkOrdDateMm(m.get("WORK_ORD_DATE_MM").toString());
				workOrderVodata.setWorkOrdDateWw(m.get("WORK_ORD_DATE_WW").toString());
				
//				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setCnt(String.valueOf((m.get("CNT"))));
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultyCnt(String.valueOf((m.get("FAULTY_CNT"))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());		
				//System.out.println(workOrderVodata.getModel());
				workOrderVodata.setSeq(String.valueOf((m.get("SEQ"))));
				workOrderVodata.setTrayNo(m.get("TRAY_NO").toString());				
				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				//appearFaultyCnt불량수량
			//	workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
			//	//userInputInspctCnt검사수량
			//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
			//	
			//	if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
			//		//appearFaultyCnt불량수량
			//		workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//userInputInspctCnt검사수량
			//		workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//엣지기포수량
			//		/*if( m.get(codeListArray[79]) != null) {
			//			workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
			//		} else {
			//			workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
			//		}*/
			//		
			//	} 
			//	
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
						Integer.parseInt(workOrderVodata.getFaulty2() ) +			
						Integer.parseInt(workOrderVodata.getFaulty3() ) +
						Integer.parseInt(workOrderVodata.getFaulty4() ) +
						Integer.parseInt(workOrderVodata.getFaulty5() ) +
						Integer.parseInt(workOrderVodata.getFaulty6() ) +
						Integer.parseInt(workOrderVodata.getFaulty7() ) +
						Integer.parseInt(workOrderVodata.getFaulty8() ) +
						Integer.parseInt(workOrderVodata.getFaulty9() ) +
						Integer.parseInt(workOrderVodata.getFaulty10()) +
						Integer.parseInt(workOrderVodata.getFaulty11()) +
						Integer.parseInt(workOrderVodata.getFaulty12()) +
						Integer.parseInt(workOrderVodata.getFaulty13()) +
						Integer.parseInt(workOrderVodata.getFaulty14()) +
						Integer.parseInt(workOrderVodata.getFaulty15()) +
						Integer.parseInt(workOrderVodata.getFaulty16()) +
						Integer.parseInt(workOrderVodata.getFaulty17()) +
						Integer.parseInt(workOrderVodata.getFaulty18()) +
						Integer.parseInt(workOrderVodata.getFaulty19()) +
						Integer.parseInt(workOrderVodata.getFaulty20()) +
						Integer.parseInt(workOrderVodata.getFaulty21()) +
						Integer.parseInt(workOrderVodata.getFaulty22()) +
						Integer.parseInt(workOrderVodata.getFaulty23()) +
						Integer.parseInt(workOrderVodata.getFaulty24()) +
						Integer.parseInt(workOrderVodata.getFaulty25()) +
						Integer.parseInt(workOrderVodata.getFaulty26()) +
						Integer.parseInt(workOrderVodata.getFaulty27()) +
						Integer.parseInt(workOrderVodata.getFaulty28()) +
						Integer.parseInt(workOrderVodata.getFaulty29()) +
						Integer.parseInt(workOrderVodata.getFaulty30()) +
						Integer.parseInt(workOrderVodata.getFaulty31()) +
						Integer.parseInt(workOrderVodata.getFaulty32()) +
						Integer.parseInt(workOrderVodata.getFaulty33()) +
						Integer.parseInt(workOrderVodata.getFaulty34()) +
						Integer.parseInt(workOrderVodata.getFaulty35()) +
						Integer.parseInt(workOrderVodata.getFaulty36()) +
						Integer.parseInt(workOrderVodata.getFaulty37()) +
						Integer.parseInt(workOrderVodata.getFaulty38()) +
						Integer.parseInt(workOrderVodata.getFaulty39()) +
						Integer.parseInt(workOrderVodata.getFaulty40()) +
						Integer.parseInt(workOrderVodata.getFaulty41()) +
						Integer.parseInt(workOrderVodata.getFaulty42()) +
						Integer.parseInt(workOrderVodata.getFaulty43()) +
						Integer.parseInt(workOrderVodata.getFaulty44()) +
						Integer.parseInt(workOrderVodata.getFaulty45()) +
						Integer.parseInt(workOrderVodata.getFaulty46()) +
						Integer.parseInt(workOrderVodata.getFaulty47()) +
						Integer.parseInt(workOrderVodata.getFaulty48()) +
						Integer.parseInt(workOrderVodata.getFaulty49()) +
						Integer.parseInt(workOrderVodata.getFaulty50()) +
						Integer.parseInt(workOrderVodata.getFaulty51()) +
						Integer.parseInt(workOrderVodata.getFaulty52()) +
						Integer.parseInt(workOrderVodata.getFaulty53()) +
						Integer.parseInt(workOrderVodata.getFaulty54()) +
						Integer.parseInt(workOrderVodata.getFaulty55()) +
						Integer.parseInt(workOrderVodata.getFaulty56()) +
						Integer.parseInt(workOrderVodata.getFaulty57()) +
						Integer.parseInt(workOrderVodata.getFaulty58()) +
						Integer.parseInt(workOrderVodata.getFaulty59()) +
						Integer.parseInt(workOrderVodata.getFaulty60()) +
						Integer.parseInt(workOrderVodata.getFaulty61()) +
						Integer.parseInt(workOrderVodata.getFaulty62()) +
						Integer.parseInt(workOrderVodata.getFaulty63()) +
						Integer.parseInt(workOrderVodata.getFaulty64()) +
						Integer.parseInt(workOrderVodata.getFaulty65()) +
						Integer.parseInt(workOrderVodata.getFaulty66()) +
						Integer.parseInt(workOrderVodata.getFaulty67()) +
						Integer.parseInt(workOrderVodata.getFaulty68()) +
						Integer.parseInt(workOrderVodata.getFaulty69()) +
						Integer.parseInt(workOrderVodata.getFaulty70()) +
						Integer.parseInt(workOrderVodata.getFaulty71()) +
						Integer.parseInt(workOrderVodata.getFaulty72()) +
						Integer.parseInt(workOrderVodata.getFaulty73()) +
						Integer.parseInt(workOrderVodata.getFaulty74()) +
						Integer.parseInt(workOrderVodata.getFaulty75()) +
						Integer.parseInt(workOrderVodata.getFaulty76()) +
						Integer.parseInt(workOrderVodata.getFaulty77()) +
						Integer.parseInt(workOrderVodata.getFaulty78()) +
						Integer.parseInt(workOrderVodata.getFaulty79()) +
						Integer.parseInt(workOrderVodata.getFaulty80()) +
						Integer.parseInt(workOrderVodata.getFaulty81()) +
						Integer.parseInt(workOrderVodata.getFaulty82()) +
						Integer.parseInt(workOrderVodata.getFaulty83()) +
						Integer.parseInt(workOrderVodata.getFaulty84()) +
						Integer.parseInt(workOrderVodata.getFaulty85()) +
						Integer.parseInt(workOrderVodata.getFaulty86()) +
						Integer.parseInt(workOrderVodata.getFaulty87()) +
						Integer.parseInt(workOrderVodata.getFaulty88()) +
						Integer.parseInt(workOrderVodata.getFaulty89()) +
						Integer.parseInt(workOrderVodata.getFaulty90()) +
						Integer.parseInt(workOrderVodata.getFaulty91()) +
						Integer.parseInt(workOrderVodata.getFaulty92()) +
						Integer.parseInt(workOrderVodata.getFaulty93()) +
						Integer.parseInt(workOrderVodata.getFaulty94()) +
						Integer.parseInt(workOrderVodata.getFaulty95()) +
						Integer.parseInt(workOrderVodata.getFaulty96()) +
						Integer.parseInt(workOrderVodata.getFaulty97()) +
						Integer.parseInt(workOrderVodata.getFaulty98()) +
						Integer.parseInt(workOrderVodata.getFaulty99()) +
						Integer.parseInt(workOrderVodata.getFaulty100()) +
						Integer.parseInt(workOrderVodata.getFaulty101()) +
						Integer.parseInt(workOrderVodata.getFaulty102()) +
						Integer.parseInt(workOrderVodata.getFaulty103()) +
						Integer.parseInt(workOrderVodata.getFaulty104()) +
						Integer.parseInt(workOrderVodata.getFaulty105()) +
						Integer.parseInt(workOrderVodata.getFaulty106()) +
						Integer.parseInt(workOrderVodata.getFaulty107()) +
						Integer.parseInt(workOrderVodata.getFaulty108()) +
						Integer.parseInt(workOrderVodata.getFaulty109()) +
						Integer.parseInt(workOrderVodata.getFaulty110()) +
						Integer.parseInt(workOrderVodata.getFaulty111()) +
						Integer.parseInt(workOrderVodata.getFaulty112()) +
						Integer.parseInt(workOrderVodata.getFaulty113()) +
						Integer.parseInt(workOrderVodata.getFaulty114()) +
						Integer.parseInt(workOrderVodata.getFaulty115()) +
						Integer.parseInt(workOrderVodata.getFaulty116()) +
						Integer.parseInt(workOrderVodata.getFaulty117()) +
						Integer.parseInt(workOrderVodata.getFaulty118()) +
						Integer.parseInt(workOrderVodata.getFaulty119()) +
						Integer.parseInt(workOrderVodata.getFaulty120()) +
						Integer.parseInt(workOrderVodata.getFaulty121()) +
						Integer.parseInt(workOrderVodata.getFaulty122()) +
						Integer.parseInt(workOrderVodata.getFaulty123()) +
						Integer.parseInt(workOrderVodata.getFaulty124()) +
						Integer.parseInt(workOrderVodata.getFaulty125()) +
						Integer.parseInt(workOrderVodata.getFaulty126()) +
						Integer.parseInt(workOrderVodata.getFaulty127()) +
						Integer.parseInt(workOrderVodata.getFaulty128()) +
						Integer.parseInt(workOrderVodata.getFaulty129()) +
						Integer.parseInt(workOrderVodata.getFaulty130()) +
						Integer.parseInt(workOrderVodata.getFaulty131()) +
						Integer.parseInt(workOrderVodata.getFaulty132()) +
						Integer.parseInt(workOrderVodata.getFaulty133()) +
						Integer.parseInt(workOrderVodata.getFaulty134()) +
						Integer.parseInt(workOrderVodata.getFaulty135()) +
						Integer.parseInt(workOrderVodata.getFaulty136()) +
						Integer.parseInt(workOrderVodata.getFaulty137()) +
						Integer.parseInt(workOrderVodata.getFaulty138()) +
						Integer.parseInt(workOrderVodata.getFaulty139()) +
						Integer.parseInt(workOrderVodata.getFaulty140());
						
						//appearFaultyCnt불량수량
						//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setAppearFaultyCnt(totalfaulty);
						//userInputInspctCnt검사수량
						if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
							int valueDiff = 0;
							valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							//workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
							workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						} else {
							workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						}
						
						
						if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
							//appearFaultyCnt불량수량
							workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							//workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							
							int valueDiff = 0;
							if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
								valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
								//workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
								
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							} else {
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							}
							//userInputInspctCnt검사수량
							//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							

							//엣지기포수량
							/*if( m.get(codeListArray[79]) != null) {
								workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
							} else {
								workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
							}*/
							
						} 
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검만 리스트 조회
	@RequestMapping(value = "qm/faultyWorkOrdNoReInspOnlyListFa", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyWorkOrdNoReInspOnlyListFaGET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산검사현황 목록조회(재검만)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWorkOrdNoReInspOnlyListFa(workOrderVo);		
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
//				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setCnt(String.valueOf((m.get("CNT"))));
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());		
				//System.out.println(workOrderVodata.getModel());
				workOrderVodata.setSeq(String.valueOf((m.get("SEQ"))));
				workOrderVodata.setTrayNo(m.get("TRAY_NO").toString());				
				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				//appearFaultyCnt불량수량
			//	workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
			//	//userInputInspctCnt검사수량
			//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
			//	
			//	if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
			//		//appearFaultyCnt불량수량
			//		workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//userInputInspctCnt검사수량
			//		workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//엣지기포수량
			//		/*if( m.get(codeListArray[79]) != null) {
			//			workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
			//		} else {
			//			workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
			//		}*/
			//		
			//	} 
			//	
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
						Integer.parseInt(workOrderVodata.getFaulty2() ) +			
						Integer.parseInt(workOrderVodata.getFaulty3() ) +
						Integer.parseInt(workOrderVodata.getFaulty4() ) +
						Integer.parseInt(workOrderVodata.getFaulty5() ) +
						Integer.parseInt(workOrderVodata.getFaulty6() ) +
						Integer.parseInt(workOrderVodata.getFaulty7() ) +
						Integer.parseInt(workOrderVodata.getFaulty8() ) +
						Integer.parseInt(workOrderVodata.getFaulty9() ) +
						Integer.parseInt(workOrderVodata.getFaulty10()) +
						Integer.parseInt(workOrderVodata.getFaulty11()) +
						Integer.parseInt(workOrderVodata.getFaulty12()) +
						Integer.parseInt(workOrderVodata.getFaulty13()) +
						Integer.parseInt(workOrderVodata.getFaulty14()) +
						Integer.parseInt(workOrderVodata.getFaulty15()) +
						Integer.parseInt(workOrderVodata.getFaulty16()) +
						Integer.parseInt(workOrderVodata.getFaulty17()) +
						Integer.parseInt(workOrderVodata.getFaulty18()) +
						Integer.parseInt(workOrderVodata.getFaulty19()) +
						Integer.parseInt(workOrderVodata.getFaulty20()) +
						Integer.parseInt(workOrderVodata.getFaulty21()) +
						Integer.parseInt(workOrderVodata.getFaulty22()) +
						Integer.parseInt(workOrderVodata.getFaulty23()) +
						Integer.parseInt(workOrderVodata.getFaulty24()) +
						Integer.parseInt(workOrderVodata.getFaulty25()) +
						Integer.parseInt(workOrderVodata.getFaulty26()) +
						Integer.parseInt(workOrderVodata.getFaulty27()) +
						Integer.parseInt(workOrderVodata.getFaulty28()) +
						Integer.parseInt(workOrderVodata.getFaulty29()) +
						Integer.parseInt(workOrderVodata.getFaulty30()) +
						Integer.parseInt(workOrderVodata.getFaulty31()) +
						Integer.parseInt(workOrderVodata.getFaulty32()) +
						Integer.parseInt(workOrderVodata.getFaulty33()) +
						Integer.parseInt(workOrderVodata.getFaulty34()) +
						Integer.parseInt(workOrderVodata.getFaulty35()) +
						Integer.parseInt(workOrderVodata.getFaulty36()) +
						Integer.parseInt(workOrderVodata.getFaulty37()) +
						Integer.parseInt(workOrderVodata.getFaulty38()) +
						Integer.parseInt(workOrderVodata.getFaulty39()) +
						Integer.parseInt(workOrderVodata.getFaulty40()) +
						Integer.parseInt(workOrderVodata.getFaulty41()) +
						Integer.parseInt(workOrderVodata.getFaulty42()) +
						Integer.parseInt(workOrderVodata.getFaulty43()) +
						Integer.parseInt(workOrderVodata.getFaulty44()) +
						Integer.parseInt(workOrderVodata.getFaulty45()) +
						Integer.parseInt(workOrderVodata.getFaulty46()) +
						Integer.parseInt(workOrderVodata.getFaulty47()) +
						Integer.parseInt(workOrderVodata.getFaulty48()) +
						Integer.parseInt(workOrderVodata.getFaulty49()) +
						Integer.parseInt(workOrderVodata.getFaulty50()) +
						Integer.parseInt(workOrderVodata.getFaulty51()) +
						Integer.parseInt(workOrderVodata.getFaulty52()) +
						Integer.parseInt(workOrderVodata.getFaulty53()) +
						Integer.parseInt(workOrderVodata.getFaulty54()) +
						Integer.parseInt(workOrderVodata.getFaulty55()) +
						Integer.parseInt(workOrderVodata.getFaulty56()) +
						Integer.parseInt(workOrderVodata.getFaulty57()) +
						Integer.parseInt(workOrderVodata.getFaulty58()) +
						Integer.parseInt(workOrderVodata.getFaulty59()) +
						Integer.parseInt(workOrderVodata.getFaulty60()) +
						Integer.parseInt(workOrderVodata.getFaulty61()) +
						Integer.parseInt(workOrderVodata.getFaulty62()) +
						Integer.parseInt(workOrderVodata.getFaulty63()) +
						Integer.parseInt(workOrderVodata.getFaulty64()) +
						Integer.parseInt(workOrderVodata.getFaulty65()) +
						Integer.parseInt(workOrderVodata.getFaulty66()) +
						Integer.parseInt(workOrderVodata.getFaulty67()) +
						Integer.parseInt(workOrderVodata.getFaulty68()) +
						Integer.parseInt(workOrderVodata.getFaulty69()) +
						Integer.parseInt(workOrderVodata.getFaulty70()) +
						Integer.parseInt(workOrderVodata.getFaulty71()) +
						Integer.parseInt(workOrderVodata.getFaulty72()) +
						Integer.parseInt(workOrderVodata.getFaulty73()) +
						Integer.parseInt(workOrderVodata.getFaulty74()) +
						Integer.parseInt(workOrderVodata.getFaulty75()) +
						Integer.parseInt(workOrderVodata.getFaulty76()) +
						Integer.parseInt(workOrderVodata.getFaulty77()) +
						Integer.parseInt(workOrderVodata.getFaulty78()) +
						Integer.parseInt(workOrderVodata.getFaulty79()) +
						Integer.parseInt(workOrderVodata.getFaulty80()) +
						Integer.parseInt(workOrderVodata.getFaulty81()) +
						Integer.parseInt(workOrderVodata.getFaulty82()) +
						Integer.parseInt(workOrderVodata.getFaulty83()) +
						Integer.parseInt(workOrderVodata.getFaulty84()) +
						Integer.parseInt(workOrderVodata.getFaulty85()) +
						Integer.parseInt(workOrderVodata.getFaulty86()) +
						Integer.parseInt(workOrderVodata.getFaulty87()) +
						Integer.parseInt(workOrderVodata.getFaulty88()) +
						Integer.parseInt(workOrderVodata.getFaulty89()) +
						Integer.parseInt(workOrderVodata.getFaulty90()) +
						Integer.parseInt(workOrderVodata.getFaulty91()) +
						Integer.parseInt(workOrderVodata.getFaulty92()) +
						Integer.parseInt(workOrderVodata.getFaulty93()) +
						Integer.parseInt(workOrderVodata.getFaulty94()) +
						Integer.parseInt(workOrderVodata.getFaulty95()) +
						Integer.parseInt(workOrderVodata.getFaulty96()) +
						Integer.parseInt(workOrderVodata.getFaulty97()) +
						Integer.parseInt(workOrderVodata.getFaulty98()) +
						Integer.parseInt(workOrderVodata.getFaulty99()) +
						Integer.parseInt(workOrderVodata.getFaulty100()) +
						Integer.parseInt(workOrderVodata.getFaulty101()) +
						Integer.parseInt(workOrderVodata.getFaulty102()) +
						Integer.parseInt(workOrderVodata.getFaulty103()) +
						Integer.parseInt(workOrderVodata.getFaulty104()) +
						Integer.parseInt(workOrderVodata.getFaulty105()) +
						Integer.parseInt(workOrderVodata.getFaulty106()) +
						Integer.parseInt(workOrderVodata.getFaulty107()) +
						Integer.parseInt(workOrderVodata.getFaulty108()) +
						Integer.parseInt(workOrderVodata.getFaulty109()) +
						Integer.parseInt(workOrderVodata.getFaulty110()) +
						Integer.parseInt(workOrderVodata.getFaulty111()) +
						Integer.parseInt(workOrderVodata.getFaulty112()) +
						Integer.parseInt(workOrderVodata.getFaulty113()) +
						Integer.parseInt(workOrderVodata.getFaulty114()) +
						Integer.parseInt(workOrderVodata.getFaulty115()) +
						Integer.parseInt(workOrderVodata.getFaulty116()) +
						Integer.parseInt(workOrderVodata.getFaulty117()) +
						Integer.parseInt(workOrderVodata.getFaulty118()) +
						Integer.parseInt(workOrderVodata.getFaulty119()) +
						Integer.parseInt(workOrderVodata.getFaulty120()) +
						Integer.parseInt(workOrderVodata.getFaulty121()) +
						Integer.parseInt(workOrderVodata.getFaulty122()) +
						Integer.parseInt(workOrderVodata.getFaulty123()) +
						Integer.parseInt(workOrderVodata.getFaulty124()) +
						Integer.parseInt(workOrderVodata.getFaulty125()) +
						Integer.parseInt(workOrderVodata.getFaulty126()) +
						Integer.parseInt(workOrderVodata.getFaulty127()) +
						Integer.parseInt(workOrderVodata.getFaulty128()) +
						Integer.parseInt(workOrderVodata.getFaulty129()) +
						Integer.parseInt(workOrderVodata.getFaulty130()) +
						Integer.parseInt(workOrderVodata.getFaulty131()) +
						Integer.parseInt(workOrderVodata.getFaulty132()) +
						Integer.parseInt(workOrderVodata.getFaulty133()) +
						Integer.parseInt(workOrderVodata.getFaulty134()) +
						Integer.parseInt(workOrderVodata.getFaulty135()) +
						Integer.parseInt(workOrderVodata.getFaulty136()) +
						Integer.parseInt(workOrderVodata.getFaulty137()) +
						Integer.parseInt(workOrderVodata.getFaulty138()) +
						Integer.parseInt(workOrderVodata.getFaulty139()) +
						Integer.parseInt(workOrderVodata.getFaulty140());
						
						//appearFaultyCnt불량수량
						//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setAppearFaultyCnt(totalfaulty);
						//userInputInspctCnt검사수량
						//if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
						//	int valueDiff = 0;
						//	valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							//workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						//} else {
						//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						//}
						workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) );
						
						if( workOrderGubunVal.equals("check")) {
							//appearFaultyCnt불량수량
							//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							//workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get("EDGE_FAULTY_CNT"))));
							//int valueDiff = 0;
							//if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
							//	valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							//	workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							//} else {
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get("EDGE_FAULTY_CNT"))) );
							//}
							//userInputInspctCnt검사수량
							//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							

							//엣지기포수량
							/*if( m.get(codeListArray[79]) != null) {
								workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
							} else {
								workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
							}*/
							
						} 
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//불량집계현황(기간) 제품별 조회fa2
	@RequestMapping(value = "qm/faultyInitialGoodsTotalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyInitialGoodsTotalList(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 제품별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				logger.info("최종검사집계(제품) 목록 조회" + codeListArray[idx]);
				if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
				
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));	
			
	
			List<Map<String, String>> workOrderList = new ArrayList<Map<String, String>>();
			if (workOrderVo.getMenuAuth().equals("qmsc2100")) {
				workOrderList = goodsInspectService.faultyGoodsTotalSumListFa2(goodsFaultyAdmVo);		
			} else {
				workOrderList = goodsInspectService.faultyInitialGoodsTotalList(goodsFaultyAdmVo);		
			}		
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				//workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());			
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setReInspCnt(String.valueOf((m.get("RE_INSP_CNT"))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
				if(m.get("MATRL_FAULTY_CNT") == null) {
					workOrderVodata.setMatrlFaultyCnt(0);
				} else {
					workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
				}
				if(m.get("FILM_FAULTY_CNT") == null) {
					workOrderVodata.setFilmFaultyCnt(0);
				} else {
					workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
				}
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
				workOrderVodata.setMatrlInitial(m.get("MATRL_INITIAL").toString());	
				//workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());	
		
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));
	
				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				if( m.get(codeListArray[200]) != null) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				dataList.add(workOrderVodata);
			}
						
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	//생산검사집계/주차 별&월 별
	@RequestMapping(value = "qm/faultyByWeekAndMonthTotalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyByWeekAndMonthTotalList(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량집계현황(기간) 기간별 조회");
		try {
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setChooseDate(workOrderVo.getChooseDate());
			goodsFaultyAdmVo.setChooseDateFrom(workOrderVo.getChooseDateFrom());
	
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();					
				if((facotryCode.equals("001") || facotryCode.equals("002")) && !workOrderVo.getMenuAuth().equals("qmsc2100")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				logger.info("최종검사집계(기간) 목록 조회" + codeListArray[idx]);
				idx++;
			}
			List<Map<String, String>> workOrderList = new ArrayList<Map<String, String>>();
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			goodsFaultyAdmVo.setCodeList(codeList.substring(0,codeList.length()-1));	
			
			
			if( workOrderVo.getDateDivision().equals("week") ) {
				workOrderList = goodsInspectService.faultyByWeekTotalList(goodsFaultyAdmVo);
			} else if( workOrderVo.getDateDivision().equals("month") ) {
				workOrderList = goodsInspectService.faultyByMonthTotalList(goodsFaultyAdmVo);
			}
			
				
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				
				//workOrderVodata.setAppearInspctDate( m.get("WORK_ORD_DATE") );
				
				if( workOrderVo.getDateDivision().equals("week") ) {
					workOrderVodata.setAppearInspctDate( String.valueOf(m.get("WORK_ORD_DATE_YYYY")) + "년 " + String.valueOf(m.get("WORK_ORD_DATE")) + "주차" );
				} else if( workOrderVo.getDateDivision().equals("month") ) {
					workOrderVodata.setAppearInspctDate( String.valueOf(m.get("WORK_ORD_DATE_YYYY")) + "년 " + String.valueOf(m.get("WORK_ORD_DATE")) + "월" );
				}
				
				workOrderVodata.setReInspCnt(String.valueOf((m.get("RE_INSP_CNT"))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("USER_INPUT_INSPCT_CNT")))));
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));	
				if(m.get("MATRL_FAULTY_CNT") == null) {
					workOrderVodata.setMatrlFaultyCnt(0);
				} else {
					workOrderVodata.setMatrlFaultyCnt(Integer.parseInt(String.valueOf((m.get("MATRL_FAULTY_CNT")))));
				}
				if(m.get("FILM_FAULTY_CNT") == null) {
					workOrderVodata.setFilmFaultyCnt(0);
				} else {
					workOrderVodata.setFilmFaultyCnt(Integer.parseInt(String.valueOf((m.get("FILM_FAULTY_CNT")))));
				}
				//workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setFaultSum(Integer.parseInt(String.valueOf((m.get("FAULT_SUM")))));
				workOrderVodata.setEdgeFaultyCnt(Integer.parseInt(String.valueOf((m.get("EDGE_FAULTY_CNT")))));
				workOrderVodata.setFaultPercent(Float.parseFloat(String.valueOf((m.get("FAULT_PERCENT")))));
		
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				if( m.get(codeListArray[200]) != null) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				dataList.add(workOrderVodata);
			}
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황(기간) 기간별 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검집계 리스트 조회
	@RequestMapping(value = "qm/workOrderReInspSynthesisList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderReInspSynthesisList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산검사현황 목록조회(재검집계)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			if(facotryCode.equals("003")) {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}
			
			JSONObject[] jArray = new JSONObject[201];
			JSONObject jObj		= new JSONObject();
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				jObj = new JSONObject();
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				jObj.put("baseCd", m.getBaseCd());
				jObj.put("baseNm", m.getBaseCdNm());
				jObj.put("gubun", m.getEtc1());
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				jArray[idx] = jObj;
				//jArray.add(jObj);
				idx++;
			}

			JSONObject obj;
			JSONObject sudelKing1 = new JSONObject();
			JSONObject sudelKing2 = new JSONObject();;
			JSONObject[] distinctItems	= new JSONObject[201];
		    String baseNm				= "";
		    String gubun				= "";
			boolean isDuplicated		= false;
			
			for (int i = 0; i < jArray.length; i++) {
				if( jArray[i] != null ) {
				    obj	= jArray[i];
				    baseNm	= obj.get("baseNm").toString();
				    gubun	= obj.get("gubun").toString();
	
				    isDuplicated = false;

			        //gubun에 따른 baseNm 중복 검사
		            for (int j = 0; j < distinctItems.length; j++) {
		            	
		            	if( gubun.equals("001") || gubun.equals("004") ) {
			                if (distinctItems[j] != null && distinctItems[j].get("baseNm").toString().equals(baseNm) && (distinctItems[j].get("gubun").equals("001") || distinctItems[j].get("gubun").equals("004"))) {
			                    isDuplicated = true;
			                    break;
			                }
		            	}
		                
		            	if( gubun.equals("002") || gubun.equals("005") ) {
			                if (distinctItems[j] != null && distinctItems[j].get("baseNm").toString().equals(baseNm) && (distinctItems[j].get("gubun").equals("002") || distinctItems[j].get("gubun").equals("005"))) {
			                	isDuplicated = true;
			                    break;
			                }
		            	}
		            }
		            //gubun에 따른 baseNm 중복 검사
				
				    if (!isDuplicated) {
				    	distinctItems[i] = obj;
				    	if( gubun.equals("001") || gubun.equals("004") ) {
				    		sudelKing1.put(obj.get("baseNm").toString(), obj.get("baseCd").toString());
				    	} else if( gubun.equals("002") || gubun.equals("005") ) {
				    		sudelKing2.put(obj.get("baseNm").toString(), obj.get("baseCd").toString());
				    	}
				    }
				}
			}
			
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWorkOrdNoReInspTotalListFa(workOrderVo);
			
			
			
			int totalfaulty		= 0;
			String fieldName	= "";
			String fieldValue	= "";
			Field field;
			
			List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
			
			WorkOrderVo workOrderVodata = new WorkOrderVo();
			for (int i = 0; i < workOrderList.size(); i++) {
				workOrderVodata = new WorkOrderVo();
				Map<String, String> m = workOrderList.get(i);
				
				//앞쪽 데이터 생성
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
				workOrderVodata.setWorkOrdDateMm(m.get("WORK_ORD_DATE_MM").toString());
				workOrderVodata.setWorkOrdDateWw(m.get("WORK_ORD_DATE_WW").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setCnt(String.valueOf((m.get("CNT"))));
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
				    workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
				}  else {
				    workOrderVodata.setMainWorkChargrNm("");
				    workOrderVodata.setMainWorkChargr("");
				}

				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
				    workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
				}  else {
				    workOrderVodata.setEdgeInspctChargerNm("");
				    workOrderVodata.setEdgeInspctCharger("");
				}

				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
				    workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				}  else {
				    workOrderVodata.setAppearInspctChargerNm("");
				    workOrderVodata.setAppearInspctCharger("");
				}

				if(m.get("APPEAR_INSPCT_DATE") != null) {
				    workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
				    workOrderVodata.setAppearInspctDate("");
				}

				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());
				workOrderVodata.setSeq(String.valueOf((m.get("SEQ"))));
				workOrderVodata.setTrayNo(m.get("TRAY_NO").toString());
				//앞쪽 데이터 생성
				
				
				JSONObject resultArray = new JSONObject();
				
				//시스템공통코드 140개까지 생길거 같아 미리 140개까지 for문(이 방식을 시스템 공통코드 데이터 길이 만큼 뽑고 JSP에서도 같은 방식으로 뽑으면, 컬럼 추가해도 수정안해도됨) 즉, 해더 데이터 테이블 컬럼도 동적으로 제작
				for (int j = 1; j <= 139; j++) {
					String resultId = "";
					
					if( jArray[j - 1] != null ) {
						
						//머티인 경우 메탈부랑 필름부로 구분
						if (jArray[j - 1].get("gubun").equals("001") || jArray[j - 1].get("gubun").equals("004")) {
							resultId = String.valueOf(sudelKing1.get(jArray[j - 1].get("baseNm")));
						} else if (jArray[j - 1].get("gubun").equals("002") || jArray[j - 1].get("gubun").equals("005")) {
							resultId = String.valueOf(sudelKing2.get(jArray[j - 1].get("baseNm")));
						}
						//머티인 경우 메탈부랑 필름부로 구분

						//중복 검사 및 합지기
						if (resultArray.get(resultId) == null) {
							//데이터가 null인 경우 현재 데이터 그냥 담아주기
							resultArray.put(resultId, m.get(codeListArray[j - 1]));
						} else {
							//데이터가 null이 아닌 경우 기존에 가지고 있는 데이터와 합친 후 다시 담아주기
							if( m.get(codeListArray[j - 1]) != null ) {
								int tempResult = 0;
									tempResult = Integer.parseInt(String.valueOf(m.get(codeListArray[j - 1]))) + Integer.parseInt(String.valueOf(resultArray.get(resultId)));
								resultArray.put(resultId, tempResult);
							}
						}
						//중복 검사 및 합지기
					}
			    }
				

				totalfaulty		= 0;
		        for (int k = 1; k <= resultArray.size(); k++) {
					fieldName	= "faulty" + k;
					field		= workOrderVodata.getClass().getDeclaredField(fieldName);
					
			        field.setAccessible(true);
			        
			        fieldValue = ( distinctItems[(k-1)] == null || resultArray.get(distinctItems[(k-1)].get("baseCd")) == null ) ? "0" : String.valueOf( resultArray.get(distinctItems[(k-1)].get("baseCd")) );
			        field.set(workOrderVodata, String.valueOf(fieldValue == null ? 0 : fieldValue));
			        
			        fieldValue	= (String) field.get(workOrderVodata);
			        totalfaulty	+= Integer.parseInt(fieldValue == null ? "0" : fieldValue);
				}
		        
		    	
		        
		        //불량 관려  처리 시작
		        //appearFaultyCnt불량수량
		        workOrderVodata.setAppearFaultyCnt(totalfaulty);
				
				//userInputInspctCnt검사수량
				if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
					int valueDiff = 0;
					valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
					workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
				} else {
					workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
				}
				
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					//appearFaultyCnt불량수량
					workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					
					int valueDiff = 0;
					if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
						valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						
						workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					} else {
						workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
					}
				}
		        //불량 관려  처리 종료
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					fieldName = "faulty" + (edgeGubunVal + 1);
					field = workOrderVodata.getClass().getDeclaredField(fieldName);
					field.setAccessible(true);
					int currentFaultyValue = Integer.parseInt(String.valueOf( field.get(workOrderVodata) == null ? "0" : field.get(workOrderVodata) ));
					int newFaultyValue = Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + currentFaultyValue;
					field.set(workOrderVodata, String.valueOf(newFaultyValue));
				}
				
				dataList.add(workOrderVodata);
				
			}
			
			
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
	
	
	//생산검사현황- 작업지시별(재검포함 엑셀다운로드)
	@RequestMapping(value = "qm/workOrderReInspExcelDownload", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderReInspExcelDownload(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		//.xls 확장자 지원
		HSSFWorkbook wb = null;
		HSSFSheet sheet = null;
		Row row = null;
		Cell cell = null;
		
		//.xlsx 확장자 지원
		XSSFWorkbook xssfWb = null; // .xlsx
		XSSFSheet xssfSheet = null; // .xlsx
		XSSFRow xssfRow = null; // .xlsx
		XSSFCell xssfCell = null;// .xlsx
		
		
		try {			
			List<WorkOrderVo> list = workOrdWithReInsp(workOrderVo);
			jsonData.put("data",list);
			
			List<SystemCommonCodeVo>  systemCommonCodeList;
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			int countCommonCode = 0;			
			systemCommonCodeVo.setOrderGubun("001");
			systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);		
			countCommonCode = systemCommonCodeList.size();
			
			int rowNo = 0; // 행 갯수 
			// 워크북 생성
			xssfWb = new XSSFWorkbook();
			xssfSheet = xssfWb.createSheet("생산검사현황(재검포함)"); // 워크시트 이름
			
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
			xssfCell.setCellValue("생산검사현황(재검포함)"); 
			
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			
			
			CellStyle cellStyle_Body = xssfWb.createCellStyle(); 
			cellStyle_Body.setAlignment(HorizontalAlignment.CENTER); 
			
			//테이블 스타일 설정
			CellStyle cellStyle_Table_Header = xssfWb.createCellStyle();
			cellStyle_Table_Header.setBorderTop(BorderStyle.THIN); //테두리 위쪽
			cellStyle_Table_Header.setBorderBottom(BorderStyle.THIN); //테두리 아래쪽
			cellStyle_Table_Header.setBorderLeft(BorderStyle.THIN); //테두리 왼쪽
			cellStyle_Table_Header.setBorderRight(BorderStyle.THIN); //테두리 오른쪽
			cellStyle_Table_Header.setAlignment(HorizontalAlignment.CENTER);
			cellStyle_Table_Header.setVerticalAlignment(VerticalAlignment.CENTER);

			//여기에 검색조건 추가로 달아주고
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			xssfCell = xssfRow.createCell((short) 0); 			
			xssfCell.setCellValue("생산일"); 
			
			xssfCell = xssfRow.createCell((short) 1); 			
			xssfCell.setCellValue(workOrderVo.getChooseDateFrom() + "~" + workOrderVo.getChooseDateTo()); 
			
			xssfCell = xssfRow.createCell((short) 3); 			
			xssfCell.setCellValue("날짜전체적용"); 
			
			xssfCell = xssfRow.createCell((short) 4); 			
			xssfCell.setCellValue(workOrderVo.getGubun1()); 
			
			xssfCell = xssfRow.createCell((short) 6); 			
			xssfCell.setCellValue("엣지불량수량포함"); 
		
			xssfCell = xssfRow.createCell((short) 7); 			
			xssfCell.setCellValue(workOrderVo.getGubun2()); 
			
			xssfCell = xssfRow.createCell((short) 9); 			
			xssfCell.setCellValue("검사자"); 
			
			xssfCell = xssfRow.createCell((short) 10); 			
			xssfCell.setCellValue(workOrderVo.getUserNm()); 
			
			xssfCell = xssfRow.createCell((short) 12); 			
			xssfCell.setCellValue("재질"); 
			
			xssfCell = xssfRow.createCell((short) 13); 			
			xssfCell.setCellValue(workOrderVo.getQutyNm()); 						

			
			xssfRow = xssfSheet.createRow(rowNo++);  // 빈행 추가
			xssfCell = xssfRow.createCell((short) 0); 
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("작업지시일"); 
			
			xssfCell = xssfRow.createCell((short) 1); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("생산일"); 
			
			xssfCell = xssfRow.createCell((short) 2); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("설비명"); 
			
			xssfCell = xssfRow.createCell((short) 3); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("작지번호"); 
			
			xssfCell = xssfRow.createCell((short) 4); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("제품"); 
			
			xssfCell = xssfRow.createCell((short) 5); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("재질"); 
			
			xssfCell = xssfRow.createCell((short) 6); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("트레이번호"); 
			
			xssfCell = xssfRow.createCell((short) 7); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("차수"); 
			
			xssfCell = xssfRow.createCell((short) 8); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("주야구분"); 
			
			xssfCell = xssfRow.createCell((short) 9); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("검사수량"); 
			
			xssfCell = xssfRow.createCell((short) 10); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("양품수량"); 
			
			xssfCell = xssfRow.createCell((short) 11); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("시료수"); 
			
			xssfCell = xssfRow.createCell((short) 12); 
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("불량수량"); 
			
			xssfCell = xssfRow.createCell((short) 13); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("생산비전"); 
			
			xssfCell = xssfRow.createCell((short) 14); 		
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("불량률"); 
			
			xssfCell = xssfRow.createCell((short) 15); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("시료불량률"); 
			
			xssfCell = xssfRow.createCell((short) 16); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("생산작업자"); 
			
			xssfCell = xssfRow.createCell((short) 17); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("외관검사일"); 
			
			xssfCell = xssfRow.createCell((short) 18); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("엣지검사자"); 
			
			xssfCell = xssfRow.createCell((short) 19); 		
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("외관검사자"); 
			
			xssfCell = xssfRow.createCell((short) 20); 
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("생산LOTNO"); 
			
			xssfCell = xssfRow.createCell((short) 21); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("규격"); 
			
			xssfCell = xssfRow.createCell((short) 22); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("주자재"); 
			
			xssfCell = xssfRow.createCell((short) 23); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("부자재1"); 
			
			xssfCell = xssfRow.createCell((short) 24); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("부자재2"); 
			
			xssfCell = xssfRow.createCell((short) 25); 	
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("부자재3"); 
			
			xssfCell = xssfRow.createCell((short) 26); 		
			xssfCell.setCellStyle(cellStyle_Table_Header); 
			xssfCell.setCellValue("부자재4"); 
			
			int cnt001 = 0;
			int cnt002 = 0;
			int cnt008 = 0;
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
			
			
			
			
			for(WorkOrderVo m : list) {
				xssfRow = xssfSheet.createRow(rowNo++);
				
				xssfCell = xssfRow.createCell((short) 0);
				if(m.getTrayNo().equals("소계")) {
					xssfCell.setCellValue("소계");
				} else {
					xssfCell.setCellValue(DateUtil.changeDateFormat2(m.getWorkOrdDate()));
				}
				
				xssfCell = xssfRow.createCell((short) 1); 	
				if(m.getTrayNo().equals("소계")) {
					xssfCell.setCellValue("");
				} else {
					xssfCell.setCellValue(DateUtil.changeDateFormat2(m.getOrdDate()));
				}			
				
				xssfCell = xssfRow.createCell((short) 2); 	
				xssfCell.setCellValue(m.getEquipNm()); 
				
				xssfCell = xssfRow.createCell((short) 3); 	
				xssfCell.setCellValue(m.getWorkOrdNo()); 
				
				xssfCell = xssfRow.createCell((short) 4); 	
				xssfCell.setCellValue(m.getGoodsNm()); 
				
				xssfCell = xssfRow.createCell((short) 5); 	
				xssfCell.setCellValue(m.getQutyNm()); 
				
				xssfCell = xssfRow.createCell((short) 6); 
				if("소계".equals(m.getTrayNo())){
					xssfCell.setCellValue(""); 
				} else {
					xssfCell.setCellValue(m.getTrayNo()); 
				}
				
				xssfCell = xssfRow.createCell((short) 7); 	
				xssfCell.setCellValue(m.getSeq()); 
				
				xssfCell = xssfRow.createCell((short) 8); 
				if("D".equals(m.getGubun())) {
					xssfCell.setCellValue("주간"); 
				} else if("N".equals(m.getGubun())){
					xssfCell.setCellValue("야간"); 
				} 
				
				
				xssfCell = xssfRow.createCell((short) 9); 	
				xssfCell.setCellValue(m.getUserInputInspctCnt()); 
				
				xssfCell = xssfRow.createCell((short) 10); 	
				xssfCell.setCellValue(m.getAppearOutputCnt()); 
				
				xssfCell = xssfRow.createCell((short) 11); 	
				xssfCell.setCellValue(m.getCnt()); 
				
				xssfCell = xssfRow.createCell((short) 12); 
				xssfCell.setCellValue(m.getAppearFaultyCnt()); 
				
				xssfCell = xssfRow.createCell((short) 13); 	
				xssfCell.setCellValue(m.getVisionFaultySum()); 
				
				xssfCell = xssfRow.createCell((short) 14); 
				if(m.getUserInputInspctCnt() != 0){
					xssfCell.setCellValue(m.getAppearFaultyCnt() / m.getUserInputInspctCnt() * 100 + "%"); 
            	} else{
            		xssfCell.setCellValue("0%");
                }			
				
				xssfCell = xssfRow.createCell((short) 15); 	
				if(Double.parseDouble(m.getCnt()) != 0){
					xssfCell.setCellValue(m.getAppearFaultyCnt() / Double.parseDouble(m.getCnt()) * 100 + "%"); 
            	} else{
            		xssfCell.setCellValue("0%");
                }
								
				xssfCell = xssfRow.createCell((short) 16); 	
				xssfCell.setCellValue(m.getMainWorkChargrNm()); 
				
				xssfCell = xssfRow.createCell((short) 17); 	
				if(m.getAppearInspctDate().equals("") || m.getAppearInspctDate() == null) {
					xssfCell.setCellValue("");
				} else {
					xssfCell.setCellValue(DateUtil.changeDateFormat2(m.getAppearInspctDate()));
				}					
				
				xssfCell = xssfRow.createCell((short) 18); 	
				xssfCell.setCellValue(m.getEdgeInspctChargerNm()); 
				
				xssfCell = xssfRow.createCell((short) 19); 		
				xssfCell.setCellValue(m.getAppearInspctChargerNm()); 
				
				xssfCell = xssfRow.createCell((short) 20); 
				xssfCell.setCellValue(m.getWorkOrdLotNo()); 
				
				xssfCell = xssfRow.createCell((short) 21); 	
				xssfCell.setCellValue(m.getModel()); 
				
				xssfCell = xssfRow.createCell((short) 22); 	
				xssfCell.setCellValue(m.getLotNo()); 
				
				xssfCell = xssfRow.createCell((short) 23); 	
				xssfCell.setCellValue(m.getSubFilm1()); 
				
				xssfCell = xssfRow.createCell((short) 24); 	
				xssfCell.setCellValue(m.getSubFilm2()); 
				
				xssfCell = xssfRow.createCell((short) 25); 	
				xssfCell.setCellValue(m.getSubFilm3()); 
				
				xssfCell = xssfRow.createCell((short) 26); 		
				xssfCell.setCellValue(m.getSubFilm4());
				
				for(int i = 1; i <= commonCodeLength; i++) {
					fieldName = "faulty" + i;
					field = m.getClass().getDeclaredField(fieldName);
					field.setAccessible(true);
					xssfCell = xssfRow.createCell((short) 27+(i-1));
					xssfCell.setCellValue(String.valueOf(field.get(m)));
					 				
				}		

			}
			
			
			for (int i=0;i<(27+cnt001+cnt002+1);i++) //autuSizeColumn after setColumnWidth setting!!
			{
				xssfSheet.autoSizeColumn(i);
				xssfSheet.setColumnWidth(i, (xssfSheet.getColumnWidth(i))+1024 ); //이건 자동으로 조절 하면 너무 딱딱해 보여서 자동조정한 사이즈에 (short)512를 추가해 주니 한결 보기 나아졌다.
			}
			
			
			//String localFile = "C:\\Users\\User\\Desktop\\" + "테스트_엑셀" + ".xlsx";
			//
			//File file = new File(localFile);
			//FileOutputStream fos = null;
			//fos = new FileOutputStream(file);
			//xssfWb.write(fos);
            //
			//if (xssfWb != null)	xssfWb.close();
			//if (fos != null) fos.close();			
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

	//생산검사현황-작업지시별(재검포함)		
	public List<WorkOrderVo> workOrdWithReInsp(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<WorkOrderVo> dataList = new ArrayList<WorkOrderVo>();
		logger.info("불량집계현황 목록조회(작지번호별)");
		try {
			
			String workOrderGubunVal = workOrderVo.getWorkOrderGubun().toString();
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
			List<SystemCommonCodeVo>  systemCommonCodeList;
			int countCommonCode = 0;
			if(facotryCode.equals("003")) {
				systemCommonCodeVo.setOrderGubun("001");
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2Fa3(systemCommonCodeVo);		
				 countCommonCode = systemCommonCodeList.size();
			} else {
				 systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
			}			
			
			String codeList = "";			
			String[] codeListArray = new String[201];
			Arrays.fill(codeListArray, "0");
			int idx = 0, edgeGubunVal = 0;
			
			for(SystemCommonCodeVo m : systemCommonCodeList) {
				codeList += "[" + m.getBaseCd() + "]" + ",";
				codeListArray[idx] = m.getBaseCd();
				
				if(facotryCode.equals("001") || facotryCode.equals("002")) {
					if(m.getBaseCd().equals("082")) {
						edgeGubunVal = idx;
					}	
				} else {
					if(m.getBaseCd().equals("024")) {
						edgeGubunVal = idx;
					}
				}
				
				idx++;
			}
			codeList += "[" + 200 + "]" + ",";
			codeListArray[200] = "200";
			logger.info("외관불량항목 - " + codeList.substring(0, codeList.length() - 1));
			workOrderVo.setCodeList(codeList.substring(0, codeList.length() - 1));		
			
			List<Map<String, String>> workOrderList = goodsInspectService.faultyWorkOrdNoReInspListFa(workOrderVo);		
			
			
			for(Map<String, String> m : workOrderList) {
				WorkOrderVo workOrderVodata = new WorkOrderVo();
				workOrderVodata.setWorkOrdDate(m.get("WORK_ORD_DATE").toString());
				workOrderVodata.setCountCommonCode(countCommonCode);				
				//workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
				//workOrderVodata.setAppearInspctCharger(m.get("APPEAR_INSPCT_CHARGER").toString());		
				workOrderVodata.setUserInputInspctCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				//workOrderVodata.setOutputCnt(Integer.parseInt(String.valueOf((m.get("OUTPUT_CNT")))));
				workOrderVodata.setOrdDate(m.get("WORK_ORD_DATE").toString());
//				workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				//workOrderVodata.setOrdGubunNm(m.get("ORD_GUBUN_NM").toString());
				//workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setEquipNm(m.get("EQUIP_NM").toString());
				workOrderVodata.setEquipCd(m.get("EQUIP_CD").toString());
				workOrderVodata.setWorkOrdNo(m.get("WORK_ORD_NO").toString());
				workOrderVodata.setWorkOrdLotNo(m.get("WORK_ORD_LOT_NO").toString());
				//workOrderVodata.setOrdLotNo(m.get("ORD_LOT_NO").toString());
				workOrderVodata.setLotNo(m.get("LOT_NO").toString());
				workOrderVodata.setGubun(m.get("GUBUN").toString());
				workOrderVodata.setCnt(String.valueOf((m.get("CNT"))));
				workOrderVodata.setVisionFaultySum(String.valueOf(m.get("VISION_FAULTY_SUM")));
				workOrderVodata.setSubFilm1(String.valueOf(m.get("SUB_FILM1")));
				workOrderVodata.setSubFilm2(String.valueOf(m.get("SUB_FILM2")));
				workOrderVodata.setSubFilm3(String.valueOf(m.get("SUB_FILM3")));
				workOrderVodata.setSubFilm4(String.valueOf(m.get("SUB_FILM4")));
				
				if(m.get("MAIN_WORK_CHARGR_NM") != null) {
					workOrderVodata.setMainWorkChargrNm(m.get("MAIN_WORK_CHARGR_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setMainWorkChargrNm("");
					workOrderVodata.setMainWorkChargr("");
				}
				
				if(m.get("EDGE_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setEdgeInspctChargerNm(m.get("EDGE_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setEdgeInspctChargerNm("");
					workOrderVodata.setEdgeInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_CHARGER_NM") != null) {
					workOrderVodata.setAppearInspctChargerNm(m.get("APPEAR_INSPCT_CHARGER_NM").toString());
					//workOrderVodata.setMainWorkChargr(m.get("MAIN_WORK_CHARGR").toString());
				}  else {
					workOrderVodata.setAppearInspctChargerNm("");
					workOrderVodata.setAppearInspctCharger("");
				}
				
				if(m.get("APPEAR_INSPCT_DATE") != null) {
					workOrderVodata.setAppearInspctDate(m.get("APPEAR_INSPCT_DATE").toString());
				}  else {
					workOrderVodata.setAppearInspctDate("");
				}
				
				workOrderVodata.setAppearOutputCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_OUTPUT_CNT")))));
				workOrderVodata.setAppearFaultyCnt(Integer.parseInt(String.valueOf((m.get("APPEAR_FAULTY_CNT")))));
				workOrderVodata.setGoodsNm(m.get("GOODS_NM").toString());
				workOrderVodata.setGoodsCd(m.get("GOODS_CD").toString());
				workOrderVodata.setQutyNm(m.get("QUTY_NM").toString());
				workOrderVodata.setModel(m.get("MODEL").toString());		
				//System.out.println(workOrderVodata.getModel());
				workOrderVodata.setSeq(String.valueOf((m.get("SEQ"))));
				workOrderVodata.setTrayNo(m.get("TRAY_NO").toString());				
				
				
				 //+ String.valueOf(m.get(codeListArray[79])); //+ Integer.valueOf(m.get(codeListArray[79]));
				
				workOrderVodata.setFaulty1(String.valueOf(m.get(codeListArray[0]) == null ? 0 : m.get(codeListArray[0])));
				workOrderVodata.setFaulty2(String.valueOf(m.get(codeListArray[1]) == null ? 0 : m.get(codeListArray[1])));				
				workOrderVodata.setFaulty3(String.valueOf(m.get(codeListArray[2]) == null ? 0 : m.get(codeListArray[2])));
				workOrderVodata.setFaulty4(String.valueOf(m.get(codeListArray[3]) == null ? 0 : m.get(codeListArray[3])));
				workOrderVodata.setFaulty5(String.valueOf(m.get(codeListArray[4]) == null ? 0 : m.get(codeListArray[4])));
				workOrderVodata.setFaulty6(String.valueOf(m.get(codeListArray[5]) == null ? 0 : m.get(codeListArray[5])));
				workOrderVodata.setFaulty7(String.valueOf(m.get(codeListArray[6]) == null ? 0 : m.get(codeListArray[6])));
				workOrderVodata.setFaulty8(String.valueOf(m.get(codeListArray[7]) == null ? 0 : m.get(codeListArray[7])));
				workOrderVodata.setFaulty9(String.valueOf(m.get(codeListArray[8]) == null ? 0 : m.get(codeListArray[8])));
				workOrderVodata.setFaulty10(String.valueOf(m.get(codeListArray[9]) == null ? 0 : m.get(codeListArray[9])));
				workOrderVodata.setFaulty11(String.valueOf(m.get(codeListArray[10]) == null ? 0 : m.get(codeListArray[10])));
				workOrderVodata.setFaulty12(String.valueOf(m.get(codeListArray[11]) == null ? 0 : m.get(codeListArray[11])));
				workOrderVodata.setFaulty13(String.valueOf(m.get(codeListArray[12]) == null ? 0 : m.get(codeListArray[12])));
				workOrderVodata.setFaulty14(String.valueOf(m.get(codeListArray[13]) == null ? 0 : m.get(codeListArray[13])));
				workOrderVodata.setFaulty15(String.valueOf(m.get(codeListArray[14]) == null ? 0 : m.get(codeListArray[14])));
				workOrderVodata.setFaulty16(String.valueOf(m.get(codeListArray[15]) == null ? 0 : m.get(codeListArray[15])));
				workOrderVodata.setFaulty17(String.valueOf(m.get(codeListArray[16]) == null ? 0 : m.get(codeListArray[16])));
				workOrderVodata.setFaulty18(String.valueOf(m.get(codeListArray[17]) == null ? 0 : m.get(codeListArray[17])));
				workOrderVodata.setFaulty19(String.valueOf(m.get(codeListArray[18]) == null ? 0 : m.get(codeListArray[18])));
				workOrderVodata.setFaulty20(String.valueOf(m.get(codeListArray[19]) == null ? 0 : m.get(codeListArray[19])));
				workOrderVodata.setFaulty21(String.valueOf(m.get(codeListArray[20]) == null ? 0 : m.get(codeListArray[20])));
				workOrderVodata.setFaulty22(String.valueOf(m.get(codeListArray[21]) == null ? 0 : m.get(codeListArray[21])));
				workOrderVodata.setFaulty23(String.valueOf(m.get(codeListArray[22]) == null ? 0 : m.get(codeListArray[22])));
				workOrderVodata.setFaulty24(String.valueOf(m.get(codeListArray[23]) == null ? 0 : m.get(codeListArray[23])));
				workOrderVodata.setFaulty25(String.valueOf(m.get(codeListArray[24]) == null ? 0 : m.get(codeListArray[24])));
				workOrderVodata.setFaulty26(String.valueOf(m.get(codeListArray[25]) == null ? 0 : m.get(codeListArray[25])));
				workOrderVodata.setFaulty27(String.valueOf(m.get(codeListArray[26]) == null ? 0 : m.get(codeListArray[26])));
				workOrderVodata.setFaulty28(String.valueOf(m.get(codeListArray[27]) == null ? 0 : m.get(codeListArray[27])));
				workOrderVodata.setFaulty29(String.valueOf(m.get(codeListArray[28]) == null ? 0 : m.get(codeListArray[28])));
				workOrderVodata.setFaulty30(String.valueOf(m.get(codeListArray[29]) == null ? 0 : m.get(codeListArray[29])));
				workOrderVodata.setFaulty31(String.valueOf(m.get(codeListArray[30]) == null ? 0 : m.get(codeListArray[30])));
				workOrderVodata.setFaulty32(String.valueOf(m.get(codeListArray[31]) == null ? 0 : m.get(codeListArray[31])));
				workOrderVodata.setFaulty33(String.valueOf(m.get(codeListArray[32]) == null ? 0 : m.get(codeListArray[32])));
				workOrderVodata.setFaulty34(String.valueOf(m.get(codeListArray[33]) == null ? 0 : m.get(codeListArray[33])));
				workOrderVodata.setFaulty35(String.valueOf(m.get(codeListArray[34]) == null ? 0 : m.get(codeListArray[34])));
				workOrderVodata.setFaulty36(String.valueOf(m.get(codeListArray[35]) == null ? 0 : m.get(codeListArray[35])));
				workOrderVodata.setFaulty37(String.valueOf(m.get(codeListArray[36]) == null ? 0 : m.get(codeListArray[36])));
				workOrderVodata.setFaulty38(String.valueOf(m.get(codeListArray[37]) == null ? 0 : m.get(codeListArray[37])));
				workOrderVodata.setFaulty39(String.valueOf(m.get(codeListArray[38]) == null ? 0 : m.get(codeListArray[38])));
				workOrderVodata.setFaulty40(String.valueOf(m.get(codeListArray[39]) == null ? 0 : m.get(codeListArray[39])));
				workOrderVodata.setFaulty41(String.valueOf(m.get(codeListArray[40]) == null ? 0 : m.get(codeListArray[40])));
				workOrderVodata.setFaulty42(String.valueOf(m.get(codeListArray[41]) == null ? 0 : m.get(codeListArray[41])));
				workOrderVodata.setFaulty43(String.valueOf(m.get(codeListArray[42]) == null ? 0 : m.get(codeListArray[42])));
				workOrderVodata.setFaulty44(String.valueOf(m.get(codeListArray[43]) == null ? 0 : m.get(codeListArray[43])));
				workOrderVodata.setFaulty45(String.valueOf(m.get(codeListArray[44]) == null ? 0 : m.get(codeListArray[44])));
				workOrderVodata.setFaulty46(String.valueOf(m.get(codeListArray[45]) == null ? 0 : m.get(codeListArray[45])));
				workOrderVodata.setFaulty47(String.valueOf(m.get(codeListArray[46]) == null ? 0 : m.get(codeListArray[46])));
				workOrderVodata.setFaulty48(String.valueOf(m.get(codeListArray[47]) == null ? 0 : m.get(codeListArray[47])));
				workOrderVodata.setFaulty49(String.valueOf(m.get(codeListArray[48]) == null ? 0 : m.get(codeListArray[48])));
				workOrderVodata.setFaulty50(String.valueOf(m.get(codeListArray[49]) == null ? 0 : m.get(codeListArray[49])));
				workOrderVodata.setFaulty51(String.valueOf(m.get(codeListArray[50]) == null ? 0 : m.get(codeListArray[50])));
				workOrderVodata.setFaulty52(String.valueOf(m.get(codeListArray[51]) == null ? 0 : m.get(codeListArray[51])));
				workOrderVodata.setFaulty53(String.valueOf(m.get(codeListArray[52]) == null ? 0 : m.get(codeListArray[52])));
				workOrderVodata.setFaulty54(String.valueOf(m.get(codeListArray[53]) == null ? 0 : m.get(codeListArray[53])));
				workOrderVodata.setFaulty55(String.valueOf(m.get(codeListArray[54]) == null ? 0 : m.get(codeListArray[54])));
				workOrderVodata.setFaulty56(String.valueOf(m.get(codeListArray[55]) == null ? 0 : m.get(codeListArray[55])));
				workOrderVodata.setFaulty57(String.valueOf(m.get(codeListArray[56]) == null ? 0 : m.get(codeListArray[56])));
				workOrderVodata.setFaulty58(String.valueOf(m.get(codeListArray[57]) == null ? 0 : m.get(codeListArray[57])));
				workOrderVodata.setFaulty59(String.valueOf(m.get(codeListArray[58]) == null ? 0 : m.get(codeListArray[58])));
				workOrderVodata.setFaulty60(String.valueOf(m.get(codeListArray[59]) == null ? 0 : m.get(codeListArray[59])));
				workOrderVodata.setFaulty61(String.valueOf(m.get(codeListArray[60]) == null ? 0 : m.get(codeListArray[60])));
				workOrderVodata.setFaulty62(String.valueOf(m.get(codeListArray[61]) == null ? 0 : m.get(codeListArray[61])));
				workOrderVodata.setFaulty63(String.valueOf(m.get(codeListArray[62]) == null ? 0 : m.get(codeListArray[62])));
				workOrderVodata.setFaulty64(String.valueOf(m.get(codeListArray[63]) == null ? 0 : m.get(codeListArray[63])));
				workOrderVodata.setFaulty65(String.valueOf(m.get(codeListArray[64]) == null ? 0 : m.get(codeListArray[64])));
				workOrderVodata.setFaulty66(String.valueOf(m.get(codeListArray[65]) == null ? 0 : m.get(codeListArray[65])));
				workOrderVodata.setFaulty67(String.valueOf(m.get(codeListArray[66]) == null ? 0 : m.get(codeListArray[66])));
				workOrderVodata.setFaulty68(String.valueOf(m.get(codeListArray[67]) == null ? 0 : m.get(codeListArray[67])));
				workOrderVodata.setFaulty69(String.valueOf(m.get(codeListArray[68]) == null ? 0 : m.get(codeListArray[68])));
				workOrderVodata.setFaulty70(String.valueOf(m.get(codeListArray[69]) == null ? 0 : m.get(codeListArray[69])));
				workOrderVodata.setFaulty71(String.valueOf(m.get(codeListArray[70]) == null ? 0 : m.get(codeListArray[70])));
				workOrderVodata.setFaulty72(String.valueOf(m.get(codeListArray[71]) == null ? 0 : m.get(codeListArray[71])));
				workOrderVodata.setFaulty73(String.valueOf(m.get(codeListArray[72]) == null ? 0 : m.get(codeListArray[72])));
				workOrderVodata.setFaulty74(String.valueOf(m.get(codeListArray[73]) == null ? 0 : m.get(codeListArray[73])));
				workOrderVodata.setFaulty75(String.valueOf(m.get(codeListArray[74]) == null ? 0 : m.get(codeListArray[74])));
				workOrderVodata.setFaulty76(String.valueOf(m.get(codeListArray[75]) == null ? 0 : m.get(codeListArray[75])));
				workOrderVodata.setFaulty77(String.valueOf(m.get(codeListArray[76]) == null ? 0 : m.get(codeListArray[76])));
				workOrderVodata.setFaulty78(String.valueOf(m.get(codeListArray[77]) == null ? 0 : m.get(codeListArray[77])));
				workOrderVodata.setFaulty79(String.valueOf(m.get(codeListArray[78]) == null ? 0 : m.get(codeListArray[78])));
				workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[79]) == null ? 0 : m.get(codeListArray[79])));

				
				
				workOrderVodata.setFaulty81(String.valueOf(m.get(codeListArray[80]) == null ? 0 : m.get(codeListArray[80])));
				workOrderVodata.setFaulty82(String.valueOf(m.get(codeListArray[81]) == null ? 0 : m.get(codeListArray[81])));
				workOrderVodata.setFaulty83(String.valueOf(m.get(codeListArray[82]) == null ? 0 : m.get(codeListArray[82])));
				workOrderVodata.setFaulty84(String.valueOf(m.get(codeListArray[83]) == null ? 0 : m.get(codeListArray[83])));
				workOrderVodata.setFaulty85(String.valueOf(m.get(codeListArray[84]) == null ? 0 : m.get(codeListArray[84])));
				workOrderVodata.setFaulty86(String.valueOf(m.get(codeListArray[85]) == null ? 0 : m.get(codeListArray[85])));
				workOrderVodata.setFaulty87(String.valueOf(m.get(codeListArray[86]) == null ? 0 : m.get(codeListArray[86])));
				workOrderVodata.setFaulty88(String.valueOf(m.get(codeListArray[87]) == null ? 0 : m.get(codeListArray[87])));
				workOrderVodata.setFaulty89(String.valueOf(m.get(codeListArray[88]) == null ? 0 : m.get(codeListArray[88])));
				workOrderVodata.setFaulty90(String.valueOf(m.get(codeListArray[89]) == null ? 0 : m.get(codeListArray[89])));
				workOrderVodata.setFaulty91(String.valueOf(m.get(codeListArray[90]) == null ? 0 : m.get(codeListArray[90])));
				workOrderVodata.setFaulty92(String.valueOf(m.get(codeListArray[91]) == null ? 0 : m.get(codeListArray[91])));
				workOrderVodata.setFaulty93(String.valueOf(m.get(codeListArray[92]) == null ? 0 : m.get(codeListArray[92])));
				workOrderVodata.setFaulty94(String.valueOf(m.get(codeListArray[93]) == null ? 0 : m.get(codeListArray[93])));
				workOrderVodata.setFaulty95(String.valueOf(m.get(codeListArray[94]) == null ? 0 : m.get(codeListArray[94])));
				workOrderVodata.setFaulty96(String.valueOf(m.get(codeListArray[95]) == null ? 0 : m.get(codeListArray[95])));
				workOrderVodata.setFaulty97(String.valueOf(m.get(codeListArray[96]) == null ? 0 : m.get(codeListArray[96])));
				workOrderVodata.setFaulty98(String.valueOf(m.get(codeListArray[97]) == null ? 0 : m.get(codeListArray[97])));
				workOrderVodata.setFaulty99(String.valueOf(m.get(codeListArray[98]) == null ? 0 : m.get(codeListArray[98])));
				workOrderVodata.setFaulty100(String.valueOf(m.get(codeListArray[99]) == null ? 0 : m.get(codeListArray[99])));
				workOrderVodata.setFaulty101(String.valueOf(m.get(codeListArray[100]) == null ? 0 : m.get(codeListArray[100])));
				workOrderVodata.setFaulty102(String.valueOf(m.get(codeListArray[101]) == null ? 0 : m.get(codeListArray[101])));
				workOrderVodata.setFaulty103(String.valueOf(m.get(codeListArray[102]) == null ? 0 : m.get(codeListArray[102])));
				workOrderVodata.setFaulty104(String.valueOf(m.get(codeListArray[103]) == null ? 0 : m.get(codeListArray[103])));
				workOrderVodata.setFaulty105(String.valueOf(m.get(codeListArray[104]) == null ? 0 : m.get(codeListArray[104])));
				workOrderVodata.setFaulty106(String.valueOf(m.get(codeListArray[105]) == null ? 0 : m.get(codeListArray[105])));
				workOrderVodata.setFaulty107(String.valueOf(m.get(codeListArray[106]) == null ? 0 : m.get(codeListArray[106])));
				workOrderVodata.setFaulty108(String.valueOf(m.get(codeListArray[107]) == null ? 0 : m.get(codeListArray[107])));
				workOrderVodata.setFaulty109(String.valueOf(m.get(codeListArray[108]) == null ? 0 : m.get(codeListArray[108])));
				workOrderVodata.setFaulty110(String.valueOf(m.get(codeListArray[109]) == null ? 0 : m.get(codeListArray[109])));
				workOrderVodata.setFaulty111(String.valueOf(m.get(codeListArray[110]) == null ? 0 : m.get(codeListArray[110])));
				workOrderVodata.setFaulty112(String.valueOf(m.get(codeListArray[111]) == null ? 0 : m.get(codeListArray[111])));
				workOrderVodata.setFaulty113(String.valueOf(m.get(codeListArray[112]) == null ? 0 : m.get(codeListArray[112])));
				workOrderVodata.setFaulty114(String.valueOf(m.get(codeListArray[113]) == null ? 0 : m.get(codeListArray[113])));
				workOrderVodata.setFaulty115(String.valueOf(m.get(codeListArray[114]) == null ? 0 : m.get(codeListArray[114])));
				workOrderVodata.setFaulty116(String.valueOf(m.get(codeListArray[115]) == null ? 0 : m.get(codeListArray[115])));
				workOrderVodata.setFaulty117(String.valueOf(m.get(codeListArray[116]) == null ? 0 : m.get(codeListArray[116])));
				workOrderVodata.setFaulty118(String.valueOf(m.get(codeListArray[117]) == null ? 0 : m.get(codeListArray[117])));
				workOrderVodata.setFaulty119(String.valueOf(m.get(codeListArray[118]) == null ? 0 : m.get(codeListArray[118])));
				workOrderVodata.setFaulty120(String.valueOf(m.get(codeListArray[119]) == null ? 0 : m.get(codeListArray[119])));
				workOrderVodata.setFaulty121(String.valueOf(m.get(codeListArray[120]) == null ? 0 : m.get(codeListArray[120])));
				workOrderVodata.setFaulty122(String.valueOf(m.get(codeListArray[121]) == null ? 0 : m.get(codeListArray[121])));
				workOrderVodata.setFaulty123(String.valueOf(m.get(codeListArray[122]) == null ? 0 : m.get(codeListArray[122])));
				workOrderVodata.setFaulty124(String.valueOf(m.get(codeListArray[123]) == null ? 0 : m.get(codeListArray[123])));
				workOrderVodata.setFaulty125(String.valueOf(m.get(codeListArray[124]) == null ? 0 : m.get(codeListArray[124])));
				workOrderVodata.setFaulty126(String.valueOf(m.get(codeListArray[125]) == null ? 0 : m.get(codeListArray[125])));
				workOrderVodata.setFaulty127(String.valueOf(m.get(codeListArray[126]) == null ? 0 : m.get(codeListArray[126])));
				workOrderVodata.setFaulty128(String.valueOf(m.get(codeListArray[127]) == null ? 0 : m.get(codeListArray[127])));
				workOrderVodata.setFaulty129(String.valueOf(m.get(codeListArray[128]) == null ? 0 : m.get(codeListArray[128])));
				workOrderVodata.setFaulty130(String.valueOf(m.get(codeListArray[129]) == null ? 0 : m.get(codeListArray[129])));
				workOrderVodata.setFaulty131(String.valueOf(m.get(codeListArray[130]) == null ? 0 : m.get(codeListArray[130])));
				workOrderVodata.setFaulty132(String.valueOf(m.get(codeListArray[131]) == null ? 0 : m.get(codeListArray[131])));
				workOrderVodata.setFaulty133(String.valueOf(m.get(codeListArray[132]) == null ? 0 : m.get(codeListArray[132])));
				workOrderVodata.setFaulty134(String.valueOf(m.get(codeListArray[133]) == null ? 0 : m.get(codeListArray[133])));
				workOrderVodata.setFaulty135(String.valueOf(m.get(codeListArray[134]) == null ? 0 : m.get(codeListArray[134])));
				workOrderVodata.setFaulty136(String.valueOf(m.get(codeListArray[135]) == null ? 0 : m.get(codeListArray[135])));
				workOrderVodata.setFaulty137(String.valueOf(m.get(codeListArray[136]) == null ? 0 : m.get(codeListArray[136])));
				workOrderVodata.setFaulty138(String.valueOf(m.get(codeListArray[137]) == null ? 0 : m.get(codeListArray[137])));
				workOrderVodata.setFaulty139(String.valueOf(m.get(codeListArray[138]) == null ? 0 : m.get(codeListArray[138])));
				workOrderVodata.setFaulty140(String.valueOf(m.get(codeListArray[139]) == null ? 0 : m.get(codeListArray[139])));
				
				
				//appearFaultyCnt불량수량
			//	workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
			//	//userInputInspctCnt검사수량
			//	workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
			//	
			//	if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
			//		//appearFaultyCnt불량수량
			//		workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//userInputInspctCnt검사수량
			//		workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
			//		//엣지기포수량
			//		/*if( m.get(codeListArray[79]) != null) {
			//			workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
			//		} else {
			//			workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
			//		}*/
			//		
			//	} 
			//	
				int totalfaulty = Integer.parseInt(workOrderVodata.getFaulty1()) +
						Integer.parseInt(workOrderVodata.getFaulty2() ) +			
						Integer.parseInt(workOrderVodata.getFaulty3() ) +
						Integer.parseInt(workOrderVodata.getFaulty4() ) +
						Integer.parseInt(workOrderVodata.getFaulty5() ) +
						Integer.parseInt(workOrderVodata.getFaulty6() ) +
						Integer.parseInt(workOrderVodata.getFaulty7() ) +
						Integer.parseInt(workOrderVodata.getFaulty8() ) +
						Integer.parseInt(workOrderVodata.getFaulty9() ) +
						Integer.parseInt(workOrderVodata.getFaulty10()) +
						Integer.parseInt(workOrderVodata.getFaulty11()) +
						Integer.parseInt(workOrderVodata.getFaulty12()) +
						Integer.parseInt(workOrderVodata.getFaulty13()) +
						Integer.parseInt(workOrderVodata.getFaulty14()) +
						Integer.parseInt(workOrderVodata.getFaulty15()) +
						Integer.parseInt(workOrderVodata.getFaulty16()) +
						Integer.parseInt(workOrderVodata.getFaulty17()) +
						Integer.parseInt(workOrderVodata.getFaulty18()) +
						Integer.parseInt(workOrderVodata.getFaulty19()) +
						Integer.parseInt(workOrderVodata.getFaulty20()) +
						Integer.parseInt(workOrderVodata.getFaulty21()) +
						Integer.parseInt(workOrderVodata.getFaulty22()) +
						Integer.parseInt(workOrderVodata.getFaulty23()) +
						Integer.parseInt(workOrderVodata.getFaulty24()) +
						Integer.parseInt(workOrderVodata.getFaulty25()) +
						Integer.parseInt(workOrderVodata.getFaulty26()) +
						Integer.parseInt(workOrderVodata.getFaulty27()) +
						Integer.parseInt(workOrderVodata.getFaulty28()) +
						Integer.parseInt(workOrderVodata.getFaulty29()) +
						Integer.parseInt(workOrderVodata.getFaulty30()) +
						Integer.parseInt(workOrderVodata.getFaulty31()) +
						Integer.parseInt(workOrderVodata.getFaulty32()) +
						Integer.parseInt(workOrderVodata.getFaulty33()) +
						Integer.parseInt(workOrderVodata.getFaulty34()) +
						Integer.parseInt(workOrderVodata.getFaulty35()) +
						Integer.parseInt(workOrderVodata.getFaulty36()) +
						Integer.parseInt(workOrderVodata.getFaulty37()) +
						Integer.parseInt(workOrderVodata.getFaulty38()) +
						Integer.parseInt(workOrderVodata.getFaulty39()) +
						Integer.parseInt(workOrderVodata.getFaulty40()) +
						Integer.parseInt(workOrderVodata.getFaulty41()) +
						Integer.parseInt(workOrderVodata.getFaulty42()) +
						Integer.parseInt(workOrderVodata.getFaulty43()) +
						Integer.parseInt(workOrderVodata.getFaulty44()) +
						Integer.parseInt(workOrderVodata.getFaulty45()) +
						Integer.parseInt(workOrderVodata.getFaulty46()) +
						Integer.parseInt(workOrderVodata.getFaulty47()) +
						Integer.parseInt(workOrderVodata.getFaulty48()) +
						Integer.parseInt(workOrderVodata.getFaulty49()) +
						Integer.parseInt(workOrderVodata.getFaulty50()) +
						Integer.parseInt(workOrderVodata.getFaulty51()) +
						Integer.parseInt(workOrderVodata.getFaulty52()) +
						Integer.parseInt(workOrderVodata.getFaulty53()) +
						Integer.parseInt(workOrderVodata.getFaulty54()) +
						Integer.parseInt(workOrderVodata.getFaulty55()) +
						Integer.parseInt(workOrderVodata.getFaulty56()) +
						Integer.parseInt(workOrderVodata.getFaulty57()) +
						Integer.parseInt(workOrderVodata.getFaulty58()) +
						Integer.parseInt(workOrderVodata.getFaulty59()) +
						Integer.parseInt(workOrderVodata.getFaulty60()) +
						Integer.parseInt(workOrderVodata.getFaulty61()) +
						Integer.parseInt(workOrderVodata.getFaulty62()) +
						Integer.parseInt(workOrderVodata.getFaulty63()) +
						Integer.parseInt(workOrderVodata.getFaulty64()) +
						Integer.parseInt(workOrderVodata.getFaulty65()) +
						Integer.parseInt(workOrderVodata.getFaulty66()) +
						Integer.parseInt(workOrderVodata.getFaulty67()) +
						Integer.parseInt(workOrderVodata.getFaulty68()) +
						Integer.parseInt(workOrderVodata.getFaulty69()) +
						Integer.parseInt(workOrderVodata.getFaulty70()) +
						Integer.parseInt(workOrderVodata.getFaulty71()) +
						Integer.parseInt(workOrderVodata.getFaulty72()) +
						Integer.parseInt(workOrderVodata.getFaulty73()) +
						Integer.parseInt(workOrderVodata.getFaulty74()) +
						Integer.parseInt(workOrderVodata.getFaulty75()) +
						Integer.parseInt(workOrderVodata.getFaulty76()) +
						Integer.parseInt(workOrderVodata.getFaulty77()) +
						Integer.parseInt(workOrderVodata.getFaulty78()) +
						Integer.parseInt(workOrderVodata.getFaulty79()) +
						Integer.parseInt(workOrderVodata.getFaulty80()) +
						Integer.parseInt(workOrderVodata.getFaulty81()) +
						Integer.parseInt(workOrderVodata.getFaulty82()) +
						Integer.parseInt(workOrderVodata.getFaulty83()) +
						Integer.parseInt(workOrderVodata.getFaulty84()) +
						Integer.parseInt(workOrderVodata.getFaulty85()) +
						Integer.parseInt(workOrderVodata.getFaulty86()) +
						Integer.parseInt(workOrderVodata.getFaulty87()) +
						Integer.parseInt(workOrderVodata.getFaulty88()) +
						Integer.parseInt(workOrderVodata.getFaulty89()) +
						Integer.parseInt(workOrderVodata.getFaulty90()) +
						Integer.parseInt(workOrderVodata.getFaulty91()) +
						Integer.parseInt(workOrderVodata.getFaulty92()) +
						Integer.parseInt(workOrderVodata.getFaulty93()) +
						Integer.parseInt(workOrderVodata.getFaulty94()) +
						Integer.parseInt(workOrderVodata.getFaulty95()) +
						Integer.parseInt(workOrderVodata.getFaulty96()) +
						Integer.parseInt(workOrderVodata.getFaulty97()) +
						Integer.parseInt(workOrderVodata.getFaulty98()) +
						Integer.parseInt(workOrderVodata.getFaulty99()) +
						Integer.parseInt(workOrderVodata.getFaulty100()) +
						Integer.parseInt(workOrderVodata.getFaulty101()) +
						Integer.parseInt(workOrderVodata.getFaulty102()) +
						Integer.parseInt(workOrderVodata.getFaulty103()) +
						Integer.parseInt(workOrderVodata.getFaulty104()) +
						Integer.parseInt(workOrderVodata.getFaulty105()) +
						Integer.parseInt(workOrderVodata.getFaulty106()) +
						Integer.parseInt(workOrderVodata.getFaulty107()) +
						Integer.parseInt(workOrderVodata.getFaulty108()) +
						Integer.parseInt(workOrderVodata.getFaulty109()) +
						Integer.parseInt(workOrderVodata.getFaulty110()) +
						Integer.parseInt(workOrderVodata.getFaulty111()) +
						Integer.parseInt(workOrderVodata.getFaulty112()) +
						Integer.parseInt(workOrderVodata.getFaulty113()) +
						Integer.parseInt(workOrderVodata.getFaulty114()) +
						Integer.parseInt(workOrderVodata.getFaulty115()) +
						Integer.parseInt(workOrderVodata.getFaulty116()) +
						Integer.parseInt(workOrderVodata.getFaulty117()) +
						Integer.parseInt(workOrderVodata.getFaulty118()) +
						Integer.parseInt(workOrderVodata.getFaulty119()) +
						Integer.parseInt(workOrderVodata.getFaulty120()) +
						Integer.parseInt(workOrderVodata.getFaulty121()) +
						Integer.parseInt(workOrderVodata.getFaulty122()) +
						Integer.parseInt(workOrderVodata.getFaulty123()) +
						Integer.parseInt(workOrderVodata.getFaulty124()) +
						Integer.parseInt(workOrderVodata.getFaulty125()) +
						Integer.parseInt(workOrderVodata.getFaulty126()) +
						Integer.parseInt(workOrderVodata.getFaulty127()) +
						Integer.parseInt(workOrderVodata.getFaulty128()) +
						Integer.parseInt(workOrderVodata.getFaulty129()) +
						Integer.parseInt(workOrderVodata.getFaulty130()) +
						Integer.parseInt(workOrderVodata.getFaulty131()) +
						Integer.parseInt(workOrderVodata.getFaulty132()) +
						Integer.parseInt(workOrderVodata.getFaulty133()) +
						Integer.parseInt(workOrderVodata.getFaulty134()) +
						Integer.parseInt(workOrderVodata.getFaulty135()) +
						Integer.parseInt(workOrderVodata.getFaulty136()) +
						Integer.parseInt(workOrderVodata.getFaulty137()) +
						Integer.parseInt(workOrderVodata.getFaulty138()) +
						Integer.parseInt(workOrderVodata.getFaulty139()) +
						Integer.parseInt(workOrderVodata.getFaulty140());
						
						//appearFaultyCnt불량수량
						//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
						workOrderVodata.setAppearFaultyCnt(totalfaulty);
						//userInputInspctCnt검사수량
						if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
							int valueDiff = 0;
							valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
							workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						} else {
							workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))));
						}
						
						
						if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
							//appearFaultyCnt불량수량
							//workOrderVodata.setAppearFaultyCnt(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							workOrderVodata.setAppearFaultyCnt(totalfaulty + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							int valueDiff = 0;
							if(Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))) != totalfaulty) {
								valueDiff = Math.abs(totalfaulty-Integer.valueOf(String.valueOf(m.get("APPEAR_FAULTY_CNT"))));
								workOrderVodata.setUserInputInspctCnt(valueDiff + Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							} else {
								workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							}
							//userInputInspctCnt검사수량
							//workOrderVodata.setUserInputInspctCnt(Integer.valueOf(String.valueOf(m.get("OUTPUT_CNT"))) + Integer.valueOf(String.valueOf(m.get(codeListArray[200]))));
							

							//엣지기포수량
							/*if( m.get(codeListArray[79]) != null) {
								workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(m.get(codeListArray[79])))));
							} else {
								workOrderVodata.setFaulty80(String.valueOf(m.get(codeListArray[200]) ));
							}*/
							
						} 
				
				if( m.get(codeListArray[200]) != null && workOrderGubunVal.equals("check")) {
					switch(edgeGubunVal) {
						case 0: workOrderVodata.setFaulty1(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty1())))); break;
						case 1: workOrderVodata.setFaulty2(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty2())))); break;
						case 2: workOrderVodata.setFaulty3(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty3())))); break;
						case 3: workOrderVodata.setFaulty4(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty4())))); break;
						case 4: workOrderVodata.setFaulty5(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty5())))); break;
						case 5: workOrderVodata.setFaulty6(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty6())))); break;
						case 6: workOrderVodata.setFaulty7(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty7())))); break;
						case 7: workOrderVodata.setFaulty8(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty8())))); break;
						case 8: workOrderVodata.setFaulty9(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty9())))); break;
						case 9: workOrderVodata.setFaulty10(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty10())))); break;
						case 10: workOrderVodata.setFaulty11(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty11())))); break;
						case 11: workOrderVodata.setFaulty12(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty12())))); break;
						case 12: workOrderVodata.setFaulty13(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty13())))); break;
						case 13: workOrderVodata.setFaulty14(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty14())))); break;
						case 14: workOrderVodata.setFaulty15(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty15())))); break;
						case 15: workOrderVodata.setFaulty16(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty16())))); break;
						case 16: workOrderVodata.setFaulty17(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty17())))); break;
						case 17: workOrderVodata.setFaulty18(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty18())))); break;
						case 18: workOrderVodata.setFaulty19(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty19())))); break;
						case 19: workOrderVodata.setFaulty20(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty20())))); break;
						case 20: workOrderVodata.setFaulty21(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty21())))); break;
						case 21: workOrderVodata.setFaulty22(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty22())))); break;
						case 22: workOrderVodata.setFaulty23(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty23())))); break;
						case 23: workOrderVodata.setFaulty24(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty24())))); break;
						case 24: workOrderVodata.setFaulty25(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty25())))); break;
						case 25: workOrderVodata.setFaulty26(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty26())))); break;
						case 26: workOrderVodata.setFaulty27(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty27())))); break;
						case 27: workOrderVodata.setFaulty28(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty28())))); break;
						case 28: workOrderVodata.setFaulty29(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty29())))); break;
						case 29: workOrderVodata.setFaulty30(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty30())))); break;
						case 30: workOrderVodata.setFaulty31(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty31())))); break;
						case 31: workOrderVodata.setFaulty32(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty32())))); break;
						case 32: workOrderVodata.setFaulty33(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty33())))); break;
						case 33: workOrderVodata.setFaulty34(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty34())))); break;
						case 34: workOrderVodata.setFaulty35(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty35())))); break;
						case 35: workOrderVodata.setFaulty36(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty36())))); break;
						case 36: workOrderVodata.setFaulty37(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty37())))); break;
						case 37: workOrderVodata.setFaulty38(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty38())))); break;
						case 38: workOrderVodata.setFaulty39(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty39())))); break;
						case 39: workOrderVodata.setFaulty40(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty40())))); break;
						case 40: workOrderVodata.setFaulty41(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty41())))); break;
						case 41: workOrderVodata.setFaulty42(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty42())))); break;
						case 42: workOrderVodata.setFaulty43(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty43())))); break;
						case 43: workOrderVodata.setFaulty44(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty44())))); break;
						case 44: workOrderVodata.setFaulty45(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty45())))); break;
						case 45: workOrderVodata.setFaulty46(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty46())))); break;
						case 46: workOrderVodata.setFaulty47(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty47())))); break;
						case 47: workOrderVodata.setFaulty48(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty48())))); break;
						case 48: workOrderVodata.setFaulty49(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty49())))); break;
						case 49: workOrderVodata.setFaulty50(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty50())))); break;
						case 50: workOrderVodata.setFaulty51(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty51())))); break;
						case 51: workOrderVodata.setFaulty52(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty52())))); break;
						case 52: workOrderVodata.setFaulty53(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty53())))); break;
						case 53: workOrderVodata.setFaulty54(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty54())))); break;
						case 54: workOrderVodata.setFaulty55(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty55())))); break;
						case 55: workOrderVodata.setFaulty56(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty56())))); break;
						case 56: workOrderVodata.setFaulty57(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty57())))); break;
						case 57: workOrderVodata.setFaulty58(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty58())))); break;
						case 58: workOrderVodata.setFaulty59(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty59())))); break;
						case 59: workOrderVodata.setFaulty60(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty60())))); break;
						case 60: workOrderVodata.setFaulty61(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty61())))); break;
						case 61: workOrderVodata.setFaulty62(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty62())))); break;
						case 62: workOrderVodata.setFaulty63(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty63())))); break;
						case 63: workOrderVodata.setFaulty64(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty64())))); break;
						case 64: workOrderVodata.setFaulty65(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty65())))); break;
						case 65: workOrderVodata.setFaulty66(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty66())))); break;
						case 66: workOrderVodata.setFaulty67(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty67())))); break;
						case 67: workOrderVodata.setFaulty68(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty68())))); break;
						case 68: workOrderVodata.setFaulty69(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty69())))); break;
						case 69: workOrderVodata.setFaulty70(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty70())))); break;
						case 70: workOrderVodata.setFaulty71(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty71())))); break;
						case 71: workOrderVodata.setFaulty72(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty72())))); break;
						case 72: workOrderVodata.setFaulty73(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty73())))); break;
						case 73: workOrderVodata.setFaulty74(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty74())))); break;
						case 74: workOrderVodata.setFaulty75(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty75())))); break;
						case 75: workOrderVodata.setFaulty76(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty76())))); break;
						case 76: workOrderVodata.setFaulty77(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty77())))); break;
						case 77: workOrderVodata.setFaulty78(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty78())))); break;
						case 78: workOrderVodata.setFaulty79(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty79())))); break;
						case 79: workOrderVodata.setFaulty80(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty80())))); break;
						case 80: workOrderVodata.setFaulty81(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty81())))); break;
						case 81: workOrderVodata.setFaulty82(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty82())))); break;
						case 82: workOrderVodata.setFaulty83(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty83())))); break;
						case 83: workOrderVodata.setFaulty84(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty84())))); break;
						case 84: workOrderVodata.setFaulty85(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty85())))); break;
						case 85: workOrderVodata.setFaulty86(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty86())))); break;
						case 86: workOrderVodata.setFaulty87(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty87())))); break;
						case 87: workOrderVodata.setFaulty88(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty88())))); break;
						case 88: workOrderVodata.setFaulty89(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty89())))); break;
						case 89: workOrderVodata.setFaulty90(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty90())))); break;
						case 90: workOrderVodata.setFaulty91(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty91())))); break;
						case 91: workOrderVodata.setFaulty92(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty92())))); break;
						case 92: workOrderVodata.setFaulty93(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty93())))); break;
						case 93: workOrderVodata.setFaulty94(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty94())))); break;
						case 94: workOrderVodata.setFaulty95(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty95())))); break;
						case 95: workOrderVodata.setFaulty96(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty96())))); break;
						case 96: workOrderVodata.setFaulty97(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty97())))); break;
						case 97: workOrderVodata.setFaulty98(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty98())))); break;
						case 98: workOrderVodata.setFaulty99(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty99())))); break;
						case 99: workOrderVodata.setFaulty100(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty100())))); break;
						case 100: workOrderVodata.setFaulty101(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty101())))); break;
						case 101: workOrderVodata.setFaulty102(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty102())))); break;
						case 102: workOrderVodata.setFaulty103(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty103())))); break;
						case 103: workOrderVodata.setFaulty104(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty104())))); break;
						case 104: workOrderVodata.setFaulty105(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty105())))); break;
						case 105: workOrderVodata.setFaulty106(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty106())))); break;
						case 106: workOrderVodata.setFaulty107(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty107())))); break;
						case 107: workOrderVodata.setFaulty108(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty108())))); break;
						case 108: workOrderVodata.setFaulty109(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty109())))); break;
						case 109: workOrderVodata.setFaulty110(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty110())))); break;
						case 110: workOrderVodata.setFaulty111(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty111())))); break;
						case 111: workOrderVodata.setFaulty112(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty112())))); break;
						case 112: workOrderVodata.setFaulty113(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty113())))); break;
						case 113: workOrderVodata.setFaulty114(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty114())))); break;
						case 114: workOrderVodata.setFaulty115(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty115())))); break;
						case 115: workOrderVodata.setFaulty116(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty116())))); break;
						case 116: workOrderVodata.setFaulty117(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty117())))); break;
						case 117: workOrderVodata.setFaulty118(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty118())))); break;
						case 118: workOrderVodata.setFaulty119(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty119())))); break;
						case 119: workOrderVodata.setFaulty120(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty120())))); break;
						case 120: workOrderVodata.setFaulty121(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty121())))); break;
						case 121: workOrderVodata.setFaulty122(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty122())))); break;
						case 122: workOrderVodata.setFaulty123(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty123())))); break;
						case 123: workOrderVodata.setFaulty124(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty124())))); break;
						case 124: workOrderVodata.setFaulty125(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty125())))); break;
						case 125: workOrderVodata.setFaulty126(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty126())))); break;
						case 126: workOrderVodata.setFaulty127(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty127())))); break;
						case 127: workOrderVodata.setFaulty128(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty128())))); break;
						case 128: workOrderVodata.setFaulty129(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty129())))); break;
						case 129: workOrderVodata.setFaulty130(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty130())))); break;
						case 130: workOrderVodata.setFaulty131(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty131())))); break;
						case 131: workOrderVodata.setFaulty132(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty132())))); break;
						case 132: workOrderVodata.setFaulty133(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty133())))); break;
						case 133: workOrderVodata.setFaulty134(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty134())))); break;
						case 134: workOrderVodata.setFaulty135(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty135())))); break;
						case 135: workOrderVodata.setFaulty136(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty136())))); break;
						case 136: workOrderVodata.setFaulty137(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty137())))); break;
						case 137: workOrderVodata.setFaulty138(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty138())))); break;
						case 138: workOrderVodata.setFaulty139(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty139())))); break;
						case 139: workOrderVodata.setFaulty140(String.valueOf( Integer.parseInt(String.valueOf(m.get(codeListArray[200]))) + Integer.parseInt(String.valueOf(workOrderVodata.getFaulty140())))); break;
					}
				}
				
				
				dataList.add(workOrderVodata);
			}
			
		} catch (Exception e) {
			logger.info("불량집계현황 목록조회 오류");
			e.printStackTrace();
		}
			
		return dataList;
	}

}