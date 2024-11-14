package mes.web.wm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.domain.po.AllFaultyAdmVo;
import mes.domain.po.EquipMatrlFaultyAdmVo;
import mes.domain.po.EquipPrcssFaultyAdmVo;
import mes.domain.po.EquipReplaceFaultyAdmVo;
import mes.domain.po.EquipTroubleFaultyAdmVo;
import mes.domain.po.FaultyQtyVo;
import mes.domain.wm.FaultyHistoryVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.po.AllFaultyAdmService;
import mes.service.po.EquipFaultyAdmService;
import mes.web.ut.DateUtil;

@Controller
public class FaultyStatsController {

	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipFaultyAdmService equipFaultyService;
	@Inject
	private AllFaultyAdmService allFaultyAdmService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	
	@Value("${factoryCode}") private String factoryCode;

	private static final Logger logger = LoggerFactory.getLogger(FaultyStatsController.class);

	//생산관리 - 작업지시 페이지
	@RequestMapping(value = "/wmsc0070", method = RequestMethod.GET)
	public String wmsc0070GET(Locale locale, Model model) throws Exception {

		logger.info("불량내역조회(전체) 페이지");
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "wm/wmsc0070";
	}
	
	//생산관리 - 작업지시 페이지_F3
	@RequestMapping(value = "/wmsc3070", method = RequestMethod.GET)
	public String wmsc3070GET(Locale locale, Model model) throws Exception {

		logger.info("불량내역조회(전체) 페이지");
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("114"); //Strip Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm114", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("115"); //공정 Trouble 조치 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm115", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("116"); //치수 불량 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm116", systemCommonGroupVo.getBaseGroupCdNm());
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("117"); // 바구니 무게
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("basketWeight", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "wm/wmsc3070";
	}

	//공정불량조회(전체) 기간 조회
	//@RequestMapping(value = "wm/readFaultyHistory", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> readFaultyHistoryGET(FaultyHistoryVo faultyHistoryVo) throws Exception {
    //
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("공정불량조회(전체) 기간 조회");
    //
	//	try {
	//		List<FaultyHistoryVo> faultyHistoryVoList = equipFaultyService.readFaultyHistoryList(faultyHistoryVo);
	//		jsonData.put("data", faultyHistoryVoList);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("공정불량 기간조회 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "error");
	//	}
	//	
	//	return jsonData;
	//}
	
	//생산실적 기종별(불량내역전체 포함)
	@RequestMapping(value = "wm/readActualOutputGoodsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputGoodsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 기종별(불량내역전체 포함) 기간 조회");
		try {
			
			List<FaultyHistoryVo> faultyHistoryVoList;
			
			if(factoryCode.equals("003" )) {
				faultyHistoryVoList = equipFaultyService.readActualOutputGoodsList_F3(faultyHistoryVo);
			} else {
				faultyHistoryVoList = equipFaultyService.readActualOutputGoodsList(faultyHistoryVo);
			}
			
			jsonData.put("data", faultyHistoryVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 기종별(불량내역전체 포함) 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	///생산실적 설비별(불량내역전체 포함)
	@RequestMapping(value = "wm/readActualOutputEquipsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputEquipsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 설비별(불량내역전체 포함) 기간 조회");
		try {
			
			List<FaultyHistoryVo> faultyHistoryVoList;
			
			if(factoryCode.equals("003" )) {
				faultyHistoryVoList = equipFaultyService.readActualOutputEquipsList_F3(faultyHistoryVo);
			} else {
				faultyHistoryVoList = equipFaultyService.readActualOutputEquipsList(faultyHistoryVo);
			}
			
			jsonData.put("data", faultyHistoryVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 설비별(불량내역전체 포함) 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 기종별(불량내역전체 포함)
	@RequestMapping(value = "wm/readActualOutputPeopolesList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputPeopolesList(FaultyHistoryVo faultyHistoryVo) throws Exception {
    
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 직원별(불량내역전체 포함)기간 조회");
    
		try {
			//List<FaultyHistoryVo> faultyHistoryVoList = equipFaultyService.readActualOutputPeopolesList(faultyHistoryVo);
			
			List<FaultyHistoryVo> faultyHistoryVoList;
			
			if(factoryCode.equals("003" )) {
				faultyHistoryVoList = equipFaultyService.readActualOutputPeopolesList_F3(faultyHistoryVo);
			} else {
				faultyHistoryVoList = equipFaultyService.readActualOutputPeopolesList(faultyHistoryVo);
			}
			
			jsonData.put("data", faultyHistoryVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 직원별(불량내역전체 포함)조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 일자별(불량내역전체 포함)
	@RequestMapping(value = "wm/readActualOutputDateList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputDateList(FaultyHistoryVo faultyHistoryVo) throws Exception {
    
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 일자별(불량내역전체 포함)기간 조회");
    
		try {
			//List<FaultyHistoryVo> faultyHistoryVoList = equipFaultyService.readActualOutputPeopolesList(faultyHistoryVo);
			
			List<FaultyHistoryVo> faultyHistoryVoList;
			
			//if(factoryCode.equals("003" )) {
			faultyHistoryVoList = equipFaultyService.readActualOutputDateList_F3(faultyHistoryVo);
			//} else {
			//	faultyHistoryVoList = equipFaultyService.readActualOutputPeopolesList(faultyHistoryVo);
			//}
			
			jsonData.put("data", faultyHistoryVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 일자별(불량내역전체 포함)조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산실적 자재별(불량내역전체 포함)
	@RequestMapping(value = "wm/readActualOutputMatrlsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputMatrlsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
    
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 자재별(불량내역전체 포함) 기간 조회");
    
		try {
			List<FaultyHistoryVo> faultyHistoryVoList = equipFaultyService.readActualOutputMatrlsList(faultyHistoryVo);
			jsonData.put("data", faultyHistoryVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 자재별(불량내역전체 포함) 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	

	//불량내역조회(상세) - 작업지시 페이지
	@RequestMapping(value = "/wmsc0080", method = RequestMethod.GET)
	public String wmsc0080GET(Locale locale, Model model) throws Exception {

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		logger.info("공정불량조회(상세) 기간 조회");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeVo.setUseYnCd("미사용도 가지고 올래~~");// 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("changeFaulty", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipTroubleFaulty", systemCommonCodeList );
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		return "wm/wmsc0080";
	}
	
	//불량내역조회(상세) - 작업지시 페이지
	@RequestMapping(value = "/wmsc3080", method = RequestMethod.GET)
	public String wmsc3080GET(Locale locale, Model model) throws Exception {

		int codeTotalCount = 0;
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		logger.info("공정불량조회(상세) 기간 조회");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeVo.setUseYnCd("미사용도 가지고 올래~~");// 교체불량 불량상태
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code052Count", systemCommonCodeList.size());
		model.addAttribute("code052NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("processFaulty", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code053Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code053NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("matrlFaulty", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code054Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code054NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("changeFaulty", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code055Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code055NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("equipTroubleFaulty", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("114"); // Strip Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code114Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code114NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("faulty114", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("115"); // 공정 Trouble 조치 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code115Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code115NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("faulty115", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("116"); // 치수 불량 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("code116Count", systemCommonCodeList.size() + codeTotalCount);
		model.addAttribute("code116NormalCount", systemCommonCodeList.size());
		codeTotalCount += systemCommonCodeList.size() -1;
		model.addAttribute("faulty116", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("114"); //Strip Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm114", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("115"); //공정 Trouble 조치 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm115", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("116"); //치수 불량 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm116", systemCommonGroupVo.getBaseGroupCdNm());

		return "wm/wmsc3080";
	}

	//공정불량 통계 기간 목록 조회
	@RequestMapping(value = "wm/readPrcssFaultyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readPrcssFaultyListGET(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정불량 기간 목록 조회");
		AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
		try {
			String systemCode = "";
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			systemCode = systemCode.substring(0, systemCode.length() - 1);
			logger.info(systemCode);
			equipPrcssFaultyAdmVo.setSystemCode(systemCode);
			List<Map<String, String>> prcssFaultyAdmDataList = equipFaultyService.readPrcssFaultyListKg(equipPrcssFaultyAdmVo);
			List<AllFaultyAdmVo>allFaultyAdmDataList = new ArrayList<AllFaultyAdmVo>();
			
			for (Map<String, String> m : prcssFaultyAdmDataList) {
				allFaultyAdmVo = new AllFaultyAdmVo();								
			    allFaultyAdmVo.setEquipNm(m.get("EQUIP_NM").toString());
			    allFaultyAdmVo.setGoodsNm(m.get("GOODS_NM").toString());
			    allFaultyAdmVo.setDayNightNm(m.get("DAY_NIGHT_NM").toString());
			    allFaultyAdmVo.setAlnicuMatrlNm(m.get("ALNICU_MATRL_NM").toString());
			    //allFaultyAdmVo.setWorkTeamNm(m.get("WORK_TEAM_NM").toString());
			    //allFaultyAdmVo.setUserNm(m.get("USER_NM").toString());			    
			    allFaultyAdmVo.setFaultyRegDate(m.get("ORD_DATE").toString());
				allFaultyAdmVo.setKg1(String.valueOf(m.get("001")));
				allFaultyAdmVo.setKg2(String.valueOf(m.get("002")));
				allFaultyAdmVo.setKg3(String.valueOf(m.get("003")));
				allFaultyAdmVo.setKg4(String.valueOf(m.get("004")));
				allFaultyAdmVo.setKg5(String.valueOf(m.get("005")));
				allFaultyAdmVo.setKg6(String.valueOf(m.get("006")));
				allFaultyAdmVo.setKg7(String.valueOf(m.get("007")));
				allFaultyAdmVo.setKg8(String.valueOf(m.get("008")));
				allFaultyAdmVo.setKg9(String.valueOf(m.get("009")));
				allFaultyAdmVo.setKg10(String.valueOf(m.get("010")));
				allFaultyAdmVo.setKg11(String.valueOf(m.get("011")));
				
				//allFaultyAdmVo.setKg12(String.valueOf(m.get("012")));
				allFaultyAdmVo.setKg12(String.valueOf(m.get("023")));	//치수 불량(023) 중간 구멍 대체.. 해결방법은..?
				
				allFaultyAdmVo.setKg13(String.valueOf(m.get("013")));
				allFaultyAdmVo.setKg14(String.valueOf(m.get("014")));
				allFaultyAdmVo.setKg15(String.valueOf(m.get("015")));
				allFaultyAdmVo.setKg16(String.valueOf(m.get("016")));
				allFaultyAdmVo.setKg17(String.valueOf(m.get("017")));
				allFaultyAdmVo.setKg18(String.valueOf(m.get("018")));
				allFaultyAdmVo.setKg19(String.valueOf(m.get("019")));
				allFaultyAdmVo.setKg20(String.valueOf(m.get("020")));
				allFaultyAdmVo.setKg21(String.valueOf(m.get("021")));
				allFaultyAdmVo.setKg22(String.valueOf(m.get("022")));
				allFaultyAdmVo.setKg23(String.valueOf(m.get("023")));
				allFaultyAdmVo.setKg24(String.valueOf(m.get("024")));
				allFaultyAdmVo.setKg25(String.valueOf(m.get("025")));
				allFaultyAdmVo.setKg26(String.valueOf(m.get("026")));
				allFaultyAdmVo.setKg27(String.valueOf(m.get("027")));
				allFaultyAdmVo.setKg28(String.valueOf(m.get("028")));
				allFaultyAdmVo.setKg29(String.valueOf(m.get("029")));
				allFaultyAdmVo.setKg30(String.valueOf(m.get("030")));
				allFaultyAdmVo.setKg31(String.valueOf(m.get("031")));
				allFaultyAdmVo.setKg32(String.valueOf(m.get("032")));
				allFaultyAdmVo.setKg33(String.valueOf(m.get("033")));
				allFaultyAdmVo.setKg34(String.valueOf(m.get("034")));
				allFaultyAdmVo.setKg35(String.valueOf(m.get("035")));
				allFaultyAdmVo.setKg36(String.valueOf(m.get("036")));
				allFaultyAdmVo.setKg37(String.valueOf(m.get("037")));
				allFaultyAdmVo.setKg38(String.valueOf(m.get("038")));
				allFaultyAdmVo.setKg39(String.valueOf(m.get("039")));
				allFaultyAdmVo.setKg40(String.valueOf(m.get("040")));
				allFaultyAdmVo.setEa1(Float.toString((Float.parseFloat(String.valueOf(m.get("001"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa2(Float.toString((Float.parseFloat(String.valueOf(m.get("002"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa3(Float.toString((Float.parseFloat(String.valueOf(m.get("003"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa4(Float.toString((Float.parseFloat(String.valueOf(m.get("004"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa5(Float.toString((Float.parseFloat(String.valueOf(m.get("005"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa6(Float.toString((Float.parseFloat(String.valueOf(m.get("006"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa7(Float.toString((Float.parseFloat(String.valueOf(m.get("007"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa8(Float.toString((Float.parseFloat(String.valueOf(m.get("008"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa9(Float.toString((Float.parseFloat(String.valueOf(m.get("009"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa10(Float.toString((Float.parseFloat(String.valueOf(m.get("010"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa11(Float.toString((Float.parseFloat(String.valueOf(m.get("011"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				
				//allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(m.get("012"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));		//치수 불량(023) 중간 구멍 대체.. 해결방법은..?
				allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(m.get("023"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				
				allFaultyAdmVo.setEa13(Float.toString((Float.parseFloat(String.valueOf(m.get("013"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa14(Float.toString((Float.parseFloat(String.valueOf(m.get("014"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa15(Float.toString((Float.parseFloat(String.valueOf(m.get("015"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa16(Float.toString((Float.parseFloat(String.valueOf(m.get("016"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa17(Float.toString((Float.parseFloat(String.valueOf(m.get("017"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa18(Float.toString((Float.parseFloat(String.valueOf(m.get("018"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa19(Float.toString((Float.parseFloat(String.valueOf(m.get("019"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa20(Float.toString((Float.parseFloat(String.valueOf(m.get("020"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa21(Float.toString((Float.parseFloat(String.valueOf(m.get("021"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa22(Float.toString((Float.parseFloat(String.valueOf(m.get("022"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa23(Float.toString((Float.parseFloat(String.valueOf(m.get("023"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));				
				allFaultyAdmVo.setEa24(Float.toString((Float.parseFloat(String.valueOf(m.get("024"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa25(Float.toString((Float.parseFloat(String.valueOf(m.get("025"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa26(Float.toString((Float.parseFloat(String.valueOf(m.get("026"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa27(Float.toString((Float.parseFloat(String.valueOf(m.get("027"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa28(Float.toString((Float.parseFloat(String.valueOf(m.get("028"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa29(Float.toString((Float.parseFloat(String.valueOf(m.get("029"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa30(Float.toString((Float.parseFloat(String.valueOf(m.get("030"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa31(Float.toString((Float.parseFloat(String.valueOf(m.get("031"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa32(Float.toString((Float.parseFloat(String.valueOf(m.get("032"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa33(Float.toString((Float.parseFloat(String.valueOf(m.get("033"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa34(Float.toString((Float.parseFloat(String.valueOf(m.get("034"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa35(Float.toString((Float.parseFloat(String.valueOf(m.get("035"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa36(Float.toString((Float.parseFloat(String.valueOf(m.get("036"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa37(Float.toString((Float.parseFloat(String.valueOf(m.get("037"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa38(Float.toString((Float.parseFloat(String.valueOf(m.get("038"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa39(Float.toString((Float.parseFloat(String.valueOf(m.get("039"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa40(Float.toString((Float.parseFloat(String.valueOf(m.get("040"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				
				allFaultyAdmDataList.add(allFaultyAdmVo);
				
			}
			jsonData.put("data", allFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("공정불량 기간 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//원자재불량 통계 기간 목록 조회
	@RequestMapping(value = "wm/readMatrlFaultyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlFaultyListGET(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정불량 기간 목록 조회");

		AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
		try {
			String systemCode = "";
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			systemCode = systemCode.substring(0, systemCode.length() - 1);
			logger.info(systemCode);
			equipMatrlFaultyAdmVo.setSystemCode(systemCode);
			List<Map<String, String>> prcssFaultyAdmDataList = equipFaultyService.readMatrlFaultyListKg(equipMatrlFaultyAdmVo);
			List<AllFaultyAdmVo> allFaultyAdmDataList = new ArrayList<AllFaultyAdmVo>();
				
			for (Map<String, String> m : prcssFaultyAdmDataList) {
				allFaultyAdmVo = new AllFaultyAdmVo();
			    allFaultyAdmVo.setEquipNm(m.get("EQUIP_NM").toString());
			    allFaultyAdmVo.setGoodsNm(m.get("GOODS_NM").toString());
			    allFaultyAdmVo.setDayNightNm(m.get("DAY_NIGHT_NM").toString());
			    allFaultyAdmVo.setAlnicuMatrlNm(m.get("ALNICU_MATRL_NM").toString());
			    //allFaultyAdmVo.setWorkTeamNm(m.get("WORK_TEAM_NM").toString());
			    //allFaultyAdmVo.setUserNm(m.get("USER_NM").toString());			    
			    allFaultyAdmVo.setFaultyRegDate(m.get("ORD_DATE").toString());
				allFaultyAdmVo.setKg1(String.valueOf(m.get("001")));
				allFaultyAdmVo.setKg2(String.valueOf(m.get("002")));
				allFaultyAdmVo.setKg3(String.valueOf(m.get("003")));
				allFaultyAdmVo.setKg4(String.valueOf(m.get("004")));
				allFaultyAdmVo.setKg5(String.valueOf(m.get("005")));
				allFaultyAdmVo.setKg6(String.valueOf(m.get("006")));
				allFaultyAdmVo.setKg7(String.valueOf(m.get("007")));
				allFaultyAdmVo.setKg8(String.valueOf(m.get("008")));
				allFaultyAdmVo.setKg9(String.valueOf(m.get("009")));
				allFaultyAdmVo.setKg10(String.valueOf(m.get("010")));
				allFaultyAdmVo.setKg11(String.valueOf(m.get("011")));
				allFaultyAdmVo.setKg12(String.valueOf(m.get("012")));
				allFaultyAdmVo.setKg13(String.valueOf(m.get("013")));
				allFaultyAdmVo.setKg14(String.valueOf(m.get("014")));
				allFaultyAdmVo.setKg15(String.valueOf(m.get("015")));
				allFaultyAdmVo.setKg16(String.valueOf(m.get("016")));
				allFaultyAdmVo.setKg17(String.valueOf(m.get("017")));
				allFaultyAdmVo.setKg18(String.valueOf(m.get("018")));
				allFaultyAdmVo.setKg19(String.valueOf(m.get("019")));
				allFaultyAdmVo.setKg20(String.valueOf(m.get("020")));
				allFaultyAdmVo.setKg21(String.valueOf(m.get("021")));
				allFaultyAdmVo.setKg22(String.valueOf(m.get("022")));
				allFaultyAdmVo.setKg23(String.valueOf(m.get("023")));
				allFaultyAdmVo.setKg24(String.valueOf(m.get("024")));
				allFaultyAdmVo.setKg25(String.valueOf(m.get("025")));
				allFaultyAdmVo.setKg26(String.valueOf(m.get("026")));
				allFaultyAdmVo.setKg27(String.valueOf(m.get("027")));
				allFaultyAdmVo.setKg28(String.valueOf(m.get("028")));
				allFaultyAdmVo.setKg29(String.valueOf(m.get("029")));
				allFaultyAdmVo.setKg30(String.valueOf(m.get("030")));
				allFaultyAdmVo.setKg31(String.valueOf(m.get("031")));
				allFaultyAdmVo.setKg32(String.valueOf(m.get("032")));
				allFaultyAdmVo.setKg33(String.valueOf(m.get("033")));
				allFaultyAdmVo.setKg34(String.valueOf(m.get("034")));
				allFaultyAdmVo.setKg35(String.valueOf(m.get("035")));
				allFaultyAdmVo.setKg36(String.valueOf(m.get("036")));
				allFaultyAdmVo.setKg37(String.valueOf(m.get("037")));
				allFaultyAdmVo.setKg38(String.valueOf(m.get("038")));
				allFaultyAdmVo.setKg39(String.valueOf(m.get("039")));
				allFaultyAdmVo.setKg40(String.valueOf(m.get("040")));
				allFaultyAdmVo.setEa1(Float.toString((Float.parseFloat(String.valueOf(m.get("001"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa2(Float.toString((Float.parseFloat(String.valueOf(m.get("002"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa3(Float.toString((Float.parseFloat(String.valueOf(m.get("003"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa4(Float.toString((Float.parseFloat(String.valueOf(m.get("004"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa5(Float.toString((Float.parseFloat(String.valueOf(m.get("005"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa6(Float.toString((Float.parseFloat(String.valueOf(m.get("006"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa7(Float.toString((Float.parseFloat(String.valueOf(m.get("007"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa8(Float.toString((Float.parseFloat(String.valueOf(m.get("008"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa9(Float.toString((Float.parseFloat(String.valueOf(m.get("009"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa10(Float.toString((Float.parseFloat(String.valueOf(m.get("010"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa11(Float.toString((Float.parseFloat(String.valueOf(m.get("011"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(m.get("012"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa13(Float.toString((Float.parseFloat(String.valueOf(m.get("013"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa14(Float.toString((Float.parseFloat(String.valueOf(m.get("014"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa15(Float.toString((Float.parseFloat(String.valueOf(m.get("015"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa16(Float.toString((Float.parseFloat(String.valueOf(m.get("016"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa17(Float.toString((Float.parseFloat(String.valueOf(m.get("017"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa18(Float.toString((Float.parseFloat(String.valueOf(m.get("018"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa19(Float.toString((Float.parseFloat(String.valueOf(m.get("019"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa20(Float.toString((Float.parseFloat(String.valueOf(m.get("020"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa21(Float.toString((Float.parseFloat(String.valueOf(m.get("021"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa22(Float.toString((Float.parseFloat(String.valueOf(m.get("022"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa23(Float.toString((Float.parseFloat(String.valueOf(m.get("023"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa24(Float.toString((Float.parseFloat(String.valueOf(m.get("024"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa25(Float.toString((Float.parseFloat(String.valueOf(m.get("025"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa26(Float.toString((Float.parseFloat(String.valueOf(m.get("026"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa27(Float.toString((Float.parseFloat(String.valueOf(m.get("027"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa28(Float.toString((Float.parseFloat(String.valueOf(m.get("028"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa29(Float.toString((Float.parseFloat(String.valueOf(m.get("029"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa30(Float.toString((Float.parseFloat(String.valueOf(m.get("030"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa31(Float.toString((Float.parseFloat(String.valueOf(m.get("031"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa32(Float.toString((Float.parseFloat(String.valueOf(m.get("032"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa33(Float.toString((Float.parseFloat(String.valueOf(m.get("033"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa34(Float.toString((Float.parseFloat(String.valueOf(m.get("034"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa35(Float.toString((Float.parseFloat(String.valueOf(m.get("035"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa36(Float.toString((Float.parseFloat(String.valueOf(m.get("036"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa37(Float.toString((Float.parseFloat(String.valueOf(m.get("037"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa38(Float.toString((Float.parseFloat(String.valueOf(m.get("038"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa39(Float.toString((Float.parseFloat(String.valueOf(m.get("039"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa40(Float.toString((Float.parseFloat(String.valueOf(m.get("040"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmDataList.add(allFaultyAdmVo);
			}
			jsonData.put("data", allFaultyAdmDataList);
			jsonData.put("result", "ok");
		}catch (Exception e) {
			logger.info("원자재불량 기간 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//교체불량 통계 기간 목록 조회
	@RequestMapping(value = "wm/readReplaceFaultyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readReplaceFaultyListGET(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("교체불량 기간 목록 조회");

		try {
			String systemCode = "";
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			systemCode = systemCode.substring(0, systemCode.length() - 1);
			logger.info(systemCode);
			equipReplaceFaultyAdmVo.setSystemCode(systemCode);
			List<Map<String, String>> replaceAdmDataList = equipFaultyService.readReplaceFaultyListKg(equipReplaceFaultyAdmVo);
			List<Map<String, String>> replaceAdmDataList2 = equipFaultyService.readReplaceFaultyListCount(equipReplaceFaultyAdmVo);
			List<AllFaultyAdmVo> allFaultyAdmDataList = new ArrayList<AllFaultyAdmVo>();
			List<AllFaultyAdmVo> allFaultyAdmDataList2 = new ArrayList<AllFaultyAdmVo>();
			AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
			AllFaultyAdmVo allFaultyAdmVo2 = new AllFaultyAdmVo();
			int a = 0;
		
			for(Map<String, String> m : replaceAdmDataList2) {
				allFaultyAdmVo2 = new AllFaultyAdmVo();
				allFaultyAdmVo2.setCount1(String.valueOf(m.get("001")));
				allFaultyAdmVo2.setCount2(String.valueOf(m.get("002")));
				allFaultyAdmVo2.setCount3(String.valueOf(m.get("003")));
				allFaultyAdmVo2.setCount4(String.valueOf(m.get("004")));
				allFaultyAdmVo2.setCount5(String.valueOf(m.get("005")));
				allFaultyAdmVo2.setCount6(String.valueOf(m.get("006")));
				allFaultyAdmVo2.setCount7(String.valueOf(m.get("007")));
				allFaultyAdmVo2.setCount8(String.valueOf(m.get("008")));
				allFaultyAdmVo2.setCount9(String.valueOf(m.get("009")));
				allFaultyAdmVo2.setCount10(String.valueOf(m.get("010")));
				allFaultyAdmVo2.setCount11(String.valueOf(m.get("011")));
				allFaultyAdmVo2.setCount12(String.valueOf(m.get("012")));
				allFaultyAdmVo2.setCount13(String.valueOf(m.get("013")));
				allFaultyAdmVo2.setCount14(String.valueOf(m.get("014")));
				allFaultyAdmVo2.setCount15(String.valueOf(m.get("015")));
				allFaultyAdmVo2.setCount16(String.valueOf(m.get("016")));
				allFaultyAdmVo2.setCount17(String.valueOf(m.get("017")));
				allFaultyAdmVo2.setCount18(String.valueOf(m.get("018")));
				allFaultyAdmVo2.setCount19(String.valueOf(m.get("019")));
				allFaultyAdmVo2.setCount20(String.valueOf(m.get("020")));
				allFaultyAdmVo2.setCount21(String.valueOf(m.get("021")));
				allFaultyAdmVo2.setCount22(String.valueOf(m.get("022")));
				allFaultyAdmVo2.setCount23(String.valueOf(m.get("023")));
				allFaultyAdmVo2.setCount24(String.valueOf(m.get("024")));
				allFaultyAdmVo2.setCount25(String.valueOf(m.get("025")));
				allFaultyAdmVo2.setCount26(String.valueOf(m.get("026")));
				allFaultyAdmVo2.setCount27(String.valueOf(m.get("027")));
				allFaultyAdmVo2.setCount28(String.valueOf(m.get("028")));
				allFaultyAdmVo2.setCount29(String.valueOf(m.get("029")));
				allFaultyAdmVo2.setCount30(String.valueOf(m.get("030")));
				allFaultyAdmVo2.setCount31(String.valueOf(m.get("031")));
				allFaultyAdmVo2.setCount32(String.valueOf(m.get("032")));
				allFaultyAdmVo2.setCount33(String.valueOf(m.get("033")));
				allFaultyAdmVo2.setCount34(String.valueOf(m.get("034")));
				allFaultyAdmVo2.setCount35(String.valueOf(m.get("035")));
				allFaultyAdmVo2.setCount36(String.valueOf(m.get("036")));
				allFaultyAdmVo2.setCount37(String.valueOf(m.get("037")));
				allFaultyAdmVo2.setCount38(String.valueOf(m.get("038")));
				allFaultyAdmVo2.setCount39(String.valueOf(m.get("039")));
				allFaultyAdmVo2.setCount40(String.valueOf(m.get("040")));
				allFaultyAdmDataList2.add(allFaultyAdmVo2);
			}
		
			for(Map<String, String> m : replaceAdmDataList) {
				allFaultyAdmVo = new AllFaultyAdmVo();
			    allFaultyAdmVo.setEquipNm(m.get("EQUIP_NM").toString());
			    allFaultyAdmVo.setGoodsNm(m.get("GOODS_NM").toString());
			    allFaultyAdmVo.setDayNightNm(m.get("DAY_NIGHT_NM").toString());
			    allFaultyAdmVo.setAlnicuMatrlNm(m.get("ALNICU_MATRL_NM").toString());
			    //allFaultyAdmVo.setWorkTeamNm(m.get("WORK_TEAM_NM").toString());
			    //allFaultyAdmVo.setUserNm(m.get("USER_NM").toString());
			    allFaultyAdmVo.setFaultyRegDate(m.get("ORD_DATE").toString());
		
				allFaultyAdmVo.setKg1(String.valueOf(m.get("001")));
				allFaultyAdmVo.setKg2(String.valueOf(m.get("002")));
				allFaultyAdmVo.setKg3(String.valueOf(m.get("003")));
				allFaultyAdmVo.setKg4(String.valueOf(m.get("004")));
				allFaultyAdmVo.setKg5(String.valueOf(m.get("005")));
				allFaultyAdmVo.setKg6(String.valueOf(m.get("006")));
				allFaultyAdmVo.setKg7(String.valueOf(m.get("007")));
				allFaultyAdmVo.setKg8(String.valueOf(m.get("008")));
				allFaultyAdmVo.setKg9(String.valueOf(m.get("009")));
				allFaultyAdmVo.setKg10(String.valueOf(m.get("010")));
				allFaultyAdmVo.setKg11(String.valueOf(m.get("011")));
				allFaultyAdmVo.setKg12(String.valueOf(m.get("012")));
				allFaultyAdmVo.setKg13(String.valueOf(m.get("013")));
				allFaultyAdmVo.setKg14(String.valueOf(m.get("014")));
				allFaultyAdmVo.setKg15(String.valueOf(m.get("015")));
				allFaultyAdmVo.setKg16(String.valueOf(m.get("016")));
				allFaultyAdmVo.setKg17(String.valueOf(m.get("017")));
				allFaultyAdmVo.setKg18(String.valueOf(m.get("018")));
				allFaultyAdmVo.setKg19(String.valueOf(m.get("019")));
				allFaultyAdmVo.setKg20(String.valueOf(m.get("020")));
				allFaultyAdmVo.setKg21(String.valueOf(m.get("021")));
				allFaultyAdmVo.setKg22(String.valueOf(m.get("022")));
				allFaultyAdmVo.setKg23(String.valueOf(m.get("023")));
				allFaultyAdmVo.setKg24(String.valueOf(m.get("024")));
				allFaultyAdmVo.setKg25(String.valueOf(m.get("025")));
				allFaultyAdmVo.setKg26(String.valueOf(m.get("026")));
				allFaultyAdmVo.setKg27(String.valueOf(m.get("027")));
				allFaultyAdmVo.setKg28(String.valueOf(m.get("028")));
				allFaultyAdmVo.setKg29(String.valueOf(m.get("029")));
				allFaultyAdmVo.setKg30(String.valueOf(m.get("030")));
				allFaultyAdmVo.setKg31(String.valueOf(m.get("031")));
				allFaultyAdmVo.setKg32(String.valueOf(m.get("032")));
				allFaultyAdmVo.setKg33(String.valueOf(m.get("033")));
				allFaultyAdmVo.setKg34(String.valueOf(m.get("034")));
				allFaultyAdmVo.setKg35(String.valueOf(m.get("035")));
				allFaultyAdmVo.setKg36(String.valueOf(m.get("036")));
				allFaultyAdmVo.setKg37(String.valueOf(m.get("037")));
				allFaultyAdmVo.setKg38(String.valueOf(m.get("038")));
				allFaultyAdmVo.setKg39(String.valueOf(m.get("039")));
				allFaultyAdmVo.setKg40(String.valueOf(m.get("040")));
				                                                                                                                                                
				allFaultyAdmVo.setEa1(Float.toString((Float.parseFloat(String.valueOf(m.get("001"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa2(Float.toString((Float.parseFloat(String.valueOf(m.get("002"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa3(Float.toString((Float.parseFloat(String.valueOf(m.get("003"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa4(Float.toString((Float.parseFloat(String.valueOf(m.get("004"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa5(Float.toString((Float.parseFloat(String.valueOf(m.get("005"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa6(Float.toString((Float.parseFloat(String.valueOf(m.get("006"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa7(Float.toString((Float.parseFloat(String.valueOf(m.get("007"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa8(Float.toString((Float.parseFloat(String.valueOf(m.get("008"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa9(Float.toString((Float.parseFloat(String.valueOf(m.get("009"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa10(Float.toString((Float.parseFloat(String.valueOf(m.get("010"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa11(Float.toString((Float.parseFloat(String.valueOf(m.get("011"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(m.get("012"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa13(Float.toString((Float.parseFloat(String.valueOf(m.get("013"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa14(Float.toString((Float.parseFloat(String.valueOf(m.get("014"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa15(Float.toString((Float.parseFloat(String.valueOf(m.get("015"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa16(Float.toString((Float.parseFloat(String.valueOf(m.get("016"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa17(Float.toString((Float.parseFloat(String.valueOf(m.get("017"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa18(Float.toString((Float.parseFloat(String.valueOf(m.get("018"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa19(Float.toString((Float.parseFloat(String.valueOf(m.get("019"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa20(Float.toString((Float.parseFloat(String.valueOf(m.get("020"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa21(Float.toString((Float.parseFloat(String.valueOf(m.get("021"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa22(Float.toString((Float.parseFloat(String.valueOf(m.get("022"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa23(Float.toString((Float.parseFloat(String.valueOf(m.get("023"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa24(Float.toString((Float.parseFloat(String.valueOf(m.get("024"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa25(Float.toString((Float.parseFloat(String.valueOf(m.get("025"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa26(Float.toString((Float.parseFloat(String.valueOf(m.get("026"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa27(Float.toString((Float.parseFloat(String.valueOf(m.get("027"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa28(Float.toString((Float.parseFloat(String.valueOf(m.get("028"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa29(Float.toString((Float.parseFloat(String.valueOf(m.get("029"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa30(Float.toString((Float.parseFloat(String.valueOf(m.get("030"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa31(Float.toString((Float.parseFloat(String.valueOf(m.get("031"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa32(Float.toString((Float.parseFloat(String.valueOf(m.get("032"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa33(Float.toString((Float.parseFloat(String.valueOf(m.get("033"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa34(Float.toString((Float.parseFloat(String.valueOf(m.get("034"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa35(Float.toString((Float.parseFloat(String.valueOf(m.get("035"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa36(Float.toString((Float.parseFloat(String.valueOf(m.get("036"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa37(Float.toString((Float.parseFloat(String.valueOf(m.get("037"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa38(Float.toString((Float.parseFloat(String.valueOf(m.get("038"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa39(Float.toString((Float.parseFloat(String.valueOf(m.get("039"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				allFaultyAdmVo.setEa40(Float.toString((Float.parseFloat(String.valueOf(m.get("040"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));
				
				allFaultyAdmVo.setCount1(allFaultyAdmDataList2.get(a).getCount1());
				allFaultyAdmVo.setCount2(allFaultyAdmDataList2.get(a).getCount2());
				allFaultyAdmVo.setCount3(allFaultyAdmDataList2.get(a).getCount3());
				allFaultyAdmVo.setCount4(allFaultyAdmDataList2.get(a).getCount4());
				allFaultyAdmVo.setCount5(allFaultyAdmDataList2.get(a).getCount5());
				allFaultyAdmVo.setCount6(allFaultyAdmDataList2.get(a).getCount6());
				allFaultyAdmVo.setCount7(allFaultyAdmDataList2.get(a).getCount7());
				allFaultyAdmVo.setCount8(allFaultyAdmDataList2.get(a).getCount8());
				allFaultyAdmVo.setCount9(allFaultyAdmDataList2.get(a).getCount9());
				allFaultyAdmVo.setCount10(allFaultyAdmDataList2.get(a).getCount10());
				allFaultyAdmVo.setCount11(allFaultyAdmDataList2.get(a).getCount11());
				allFaultyAdmVo.setCount12(allFaultyAdmDataList2.get(a).getCount12());
				allFaultyAdmVo.setCount13(allFaultyAdmDataList2.get(a).getCount13());
				allFaultyAdmVo.setCount14(allFaultyAdmDataList2.get(a).getCount14());
				allFaultyAdmVo.setCount15(allFaultyAdmDataList2.get(a).getCount15());
				allFaultyAdmVo.setCount16(allFaultyAdmDataList2.get(a).getCount16());
				allFaultyAdmVo.setCount17(allFaultyAdmDataList2.get(a).getCount17());
				allFaultyAdmVo.setCount18(allFaultyAdmDataList2.get(a).getCount18());
				allFaultyAdmVo.setCount19(allFaultyAdmDataList2.get(a).getCount19());
				allFaultyAdmVo.setCount20(allFaultyAdmDataList2.get(a).getCount20());
				allFaultyAdmVo.setCount21(allFaultyAdmDataList2.get(a).getCount21());
				allFaultyAdmVo.setCount22(allFaultyAdmDataList2.get(a).getCount22());
				allFaultyAdmVo.setCount23(allFaultyAdmDataList2.get(a).getCount23());
				allFaultyAdmVo.setCount24(allFaultyAdmDataList2.get(a).getCount24());
				allFaultyAdmVo.setCount25(allFaultyAdmDataList2.get(a).getCount25());
				allFaultyAdmVo.setCount26(allFaultyAdmDataList2.get(a).getCount26());
				allFaultyAdmVo.setCount27(allFaultyAdmDataList2.get(a).getCount27());
				allFaultyAdmVo.setCount28(allFaultyAdmDataList2.get(a).getCount28());
				allFaultyAdmVo.setCount29(allFaultyAdmDataList2.get(a).getCount29());
				allFaultyAdmVo.setCount30(allFaultyAdmDataList2.get(a).getCount30());
				allFaultyAdmVo.setCount31(allFaultyAdmDataList2.get(a).getCount31());
				allFaultyAdmVo.setCount32(allFaultyAdmDataList2.get(a).getCount32());
				allFaultyAdmVo.setCount33(allFaultyAdmDataList2.get(a).getCount33());
				allFaultyAdmVo.setCount34(allFaultyAdmDataList2.get(a).getCount34());
				allFaultyAdmVo.setCount35(allFaultyAdmDataList2.get(a).getCount35());
				allFaultyAdmVo.setCount36(allFaultyAdmDataList2.get(a).getCount36());
				allFaultyAdmVo.setCount37(allFaultyAdmDataList2.get(a).getCount37());
				allFaultyAdmVo.setCount38(allFaultyAdmDataList2.get(a).getCount38());
				allFaultyAdmVo.setCount39(allFaultyAdmDataList2.get(a).getCount39());
				allFaultyAdmVo.setCount40(allFaultyAdmDataList2.get(a).getCount40());

				allFaultyAdmDataList.add(allFaultyAdmVo);
				
				a++;
			
				
			}
			jsonData.put("data", allFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("교체불량 기간 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//설비 Trouble불량 통계 목록 기간 조회
	@RequestMapping(value = "wm/readTroubleFaultyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readTroubleFaultyListGET(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비Trouble 기간 목록 조회");

		try {
			//List<EquipTroubleFaultyAdmVo> troubleAdmDataList = equipFaultyService.readTroubleFaultyList(equipTroubleFaultyAdmVo);
			List<AllFaultyAdmVo> allFaultyAdmDataList = new ArrayList<AllFaultyAdmVo>();
			List<AllFaultyAdmVo> allFaultyAdmDataList2 = new ArrayList<AllFaultyAdmVo>();
			List<AllFaultyAdmVo> allFaultyAdmDataList3 = new ArrayList<AllFaultyAdmVo>();
			AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
			AllFaultyAdmVo allFaultyAdmVo2 = new AllFaultyAdmVo();
			AllFaultyAdmVo allFaultyAdmVo3 = new AllFaultyAdmVo();
			
			String systemCode = "";
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			systemCode = systemCode.substring(0,systemCode.length()-1);
			equipTroubleFaultyAdmVo.setSystemCode(systemCode);
			
			List<Map<String, String>> troubleAdmDataList = equipFaultyService.readTroubleFaultyListKg(equipTroubleFaultyAdmVo);
			List<Map<String, String>> troubleAdmDataList2 = equipFaultyService.readTroubleFaultyListCount(equipTroubleFaultyAdmVo);
			List<Map<String, String>> troubleAdmDataList3 = equipFaultyService.readTroubleFaultyListContent(equipTroubleFaultyAdmVo);
			

			int a = 0;
			
			
			for(Map<String, String> m : troubleAdmDataList2) {
				allFaultyAdmVo2 = new AllFaultyAdmVo();
				
				allFaultyAdmVo2.setCount1(String.valueOf(m.get("001")));                                                                                            
				allFaultyAdmVo2.setCount2(String.valueOf(m.get("002")));                                                                                            
				allFaultyAdmVo2.setCount3(String.valueOf(m.get("003")));                                                                                            
				allFaultyAdmVo2.setCount4(String.valueOf(m.get("004")));                                                                                            
				allFaultyAdmVo2.setCount5(String.valueOf(m.get("005")));                                                                                            
				allFaultyAdmVo2.setCount6(String.valueOf(m.get("006")));                                                                                            
				allFaultyAdmVo2.setCount7(String.valueOf(m.get("007")));                                                                                            
				allFaultyAdmVo2.setCount8(String.valueOf(m.get("008")));                                                                                            
				allFaultyAdmVo2.setCount9(String.valueOf(m.get("009")));                                                                                            
				allFaultyAdmVo2.setCount10(String.valueOf(m.get("010")));                                                                                           
				allFaultyAdmVo2.setCount11(String.valueOf(m.get("011")));                                                                                           
				allFaultyAdmVo2.setCount12(String.valueOf(m.get("012")));                                                                                           
				allFaultyAdmVo2.setCount13(String.valueOf(m.get("013")));                                                                                           
				allFaultyAdmVo2.setCount14(String.valueOf(m.get("014")));                                                                                           
				allFaultyAdmVo2.setCount15(String.valueOf(m.get("015")));                                                                                           
				allFaultyAdmVo2.setCount16(String.valueOf(m.get("016")));                                                                                           
				allFaultyAdmVo2.setCount17(String.valueOf(m.get("017")));                                                                                           
				allFaultyAdmVo2.setCount18(String.valueOf(m.get("018")));                                                                                           
				allFaultyAdmVo2.setCount19(String.valueOf(m.get("019")));                                                                                           
				allFaultyAdmVo2.setCount20(String.valueOf(m.get("020")));                                                                                           
				allFaultyAdmVo2.setCount21(String.valueOf(m.get("021")));                                                                                           
				allFaultyAdmVo2.setCount22(String.valueOf(m.get("022")));                                                                                           
				allFaultyAdmVo2.setCount23(String.valueOf(m.get("023")));                                                                                           
				allFaultyAdmVo2.setCount24(String.valueOf(m.get("024")));                                                                                           
				allFaultyAdmVo2.setCount25(String.valueOf(m.get("025")));                                                                                           
				allFaultyAdmVo2.setCount26(String.valueOf(m.get("026")));                                                                                           
				allFaultyAdmVo2.setCount27(String.valueOf(m.get("027")));                                                                                           
				allFaultyAdmVo2.setCount28(String.valueOf(m.get("028")));                                                                                           
				allFaultyAdmVo2.setCount29(String.valueOf(m.get("029")));                                                                                           
				allFaultyAdmVo2.setCount30(String.valueOf(m.get("030")));                                                                                           
				allFaultyAdmVo2.setCount31(String.valueOf(m.get("031")));                                                                                           
				allFaultyAdmVo2.setCount32(String.valueOf(m.get("032")));                                                                                           
				allFaultyAdmVo2.setCount33(String.valueOf(m.get("033")));                                                                                           
				allFaultyAdmVo2.setCount34(String.valueOf(m.get("034")));                                                                                           
				allFaultyAdmVo2.setCount35(String.valueOf(m.get("035")));                                                                                           
				allFaultyAdmVo2.setCount36(String.valueOf(m.get("036")));                                                                                           
				allFaultyAdmVo2.setCount37(String.valueOf(m.get("037")));                                                                                           
				allFaultyAdmVo2.setCount38(String.valueOf(m.get("038")));                                                                                           
				allFaultyAdmVo2.setCount39(String.valueOf(m.get("039")));                                                                                           
				allFaultyAdmVo2.setCount40(String.valueOf(m.get("040")));  
				allFaultyAdmDataList2.add(allFaultyAdmVo2);
				
				
			}			
			
			for(Map<String, String> m : troubleAdmDataList3) {
				allFaultyAdmVo3 = new AllFaultyAdmVo();
				
				allFaultyAdmVo3.setContent1(String.valueOf(m.get("001")));                                                                                            
				allFaultyAdmVo3.setContent2(String.valueOf(m.get("002")));                                                                                            
				allFaultyAdmVo3.setContent3(String.valueOf(m.get("003")));                                                                                            
				allFaultyAdmVo3.setContent4(String.valueOf(m.get("004")));                                                                                            
				allFaultyAdmVo3.setContent5(String.valueOf(m.get("005")));                                                                                            
				allFaultyAdmVo3.setContent6(String.valueOf(m.get("006")));                                                                                            
				allFaultyAdmVo3.setContent7(String.valueOf(m.get("007")));                                                                                            
				allFaultyAdmVo3.setContent8(String.valueOf(m.get("008")));                                                                                            
				allFaultyAdmVo3.setContent9(String.valueOf(m.get("009")));                                                                                            
				allFaultyAdmVo3.setContent10(String.valueOf(m.get("010")));                                                                                           
				allFaultyAdmVo3.setContent11(String.valueOf(m.get("011")));                                                                                           
				allFaultyAdmVo3.setContent12(String.valueOf(m.get("012")));                                                                                           
				allFaultyAdmVo3.setContent13(String.valueOf(m.get("013")));                                                                                           
				allFaultyAdmVo3.setContent14(String.valueOf(m.get("014")));                                                                                           
				allFaultyAdmVo3.setContent15(String.valueOf(m.get("015")));                                                                                           
				allFaultyAdmVo3.setContent16(String.valueOf(m.get("016")));                                                                                           
				allFaultyAdmVo3.setContent17(String.valueOf(m.get("017")));                                                                                           
				allFaultyAdmVo3.setContent18(String.valueOf(m.get("018")));                                                                                           
				allFaultyAdmVo3.setContent19(String.valueOf(m.get("019")));                                                                                           
				allFaultyAdmVo3.setContent20(String.valueOf(m.get("020")));                                                                                           
				allFaultyAdmVo3.setContent21(String.valueOf(m.get("021")));                                                                                           
				allFaultyAdmVo3.setContent22(String.valueOf(m.get("022")));                                                                                           
				allFaultyAdmVo3.setContent23(String.valueOf(m.get("023")));                                                                                           
				allFaultyAdmVo3.setContent24(String.valueOf(m.get("024")));                                                                                           
				allFaultyAdmVo3.setContent25(String.valueOf(m.get("025")));                                                                                           
				allFaultyAdmVo3.setContent26(String.valueOf(m.get("026")));                                                                                           
				allFaultyAdmVo3.setContent27(String.valueOf(m.get("027")));                                                                                           
				allFaultyAdmVo3.setContent28(String.valueOf(m.get("028")));                                                                                           
				allFaultyAdmVo3.setContent29(String.valueOf(m.get("029")));                                                                                           
				allFaultyAdmVo3.setContent30(String.valueOf(m.get("030")));                                                                                           
				allFaultyAdmVo3.setContent31(String.valueOf(m.get("031")));                                                                                           
				allFaultyAdmVo3.setContent32(String.valueOf(m.get("032")));                                                                                           
				allFaultyAdmVo3.setContent33(String.valueOf(m.get("033")));                                                                                           
				allFaultyAdmVo3.setContent34(String.valueOf(m.get("034")));                                                                                           
				allFaultyAdmVo3.setContent35(String.valueOf(m.get("035")));                                                                                           
				allFaultyAdmVo3.setContent36(String.valueOf(m.get("036")));                                                                                           
				allFaultyAdmVo3.setContent37(String.valueOf(m.get("037")));                                                                                           
				allFaultyAdmVo3.setContent38(String.valueOf(m.get("038")));                                                                                           
				allFaultyAdmVo3.setContent39(String.valueOf(m.get("039")));                                                                                           
				allFaultyAdmVo3.setContent40(String.valueOf(m.get("040")));  
				
				allFaultyAdmDataList3.add(allFaultyAdmVo3);
				    
				
			}
			
			for(Map<String, String> m : troubleAdmDataList) {
				allFaultyAdmVo = new AllFaultyAdmVo();
				
				
			    allFaultyAdmVo.setEquipNm(m.get("EQUIP_NM").toString());
			    allFaultyAdmVo.setGoodsNm(m.get("GOODS_NM").toString());
			    allFaultyAdmVo.setDayNightNm(m.get("DAY_NIGHT_NM").toString());
			    allFaultyAdmVo.setAlnicuMatrlNm(m.get("ALNICU_MATRL_NM").toString());
			    //allFaultyAdmVo.setWorkTeamNm(m.get("WORK_TEAM_NM").toString());
			    //allFaultyAdmVo.setUserNm(m.get("USER_NM").toString());			    
			    allFaultyAdmVo.setFaultyRegDate(m.get("ORD_DATE").toString());
		
				allFaultyAdmVo.setKg1(String.valueOf(m.get("001")));                                                                                            
				allFaultyAdmVo.setKg2(String.valueOf(m.get("002")));                                                                                            
				allFaultyAdmVo.setKg3(String.valueOf(m.get("003")));                                                                                            
				allFaultyAdmVo.setKg4(String.valueOf(m.get("004")));                                                                                            
				allFaultyAdmVo.setKg5(String.valueOf(m.get("005")));                                                                                            
				allFaultyAdmVo.setKg6(String.valueOf(m.get("006")));                                                                                            
				allFaultyAdmVo.setKg7(String.valueOf(m.get("007")));                                                                                            
				allFaultyAdmVo.setKg8(String.valueOf(m.get("008")));                                                                                            
				allFaultyAdmVo.setKg9(String.valueOf(m.get("009")));                                                                                            
				allFaultyAdmVo.setKg10(String.valueOf(m.get("010")));                                                                                           
				allFaultyAdmVo.setKg11(String.valueOf(m.get("011")));                                                                                           
				allFaultyAdmVo.setKg12(String.valueOf(m.get("012")));                                                                                           
				allFaultyAdmVo.setKg13(String.valueOf(m.get("013")));                                                                                           
				allFaultyAdmVo.setKg14(String.valueOf(m.get("014")));                                                                                           
				allFaultyAdmVo.setKg15(String.valueOf(m.get("015")));                                                                                           
				allFaultyAdmVo.setKg16(String.valueOf(m.get("016")));                                                                                           
				allFaultyAdmVo.setKg17(String.valueOf(m.get("017")));                                                                                           
				allFaultyAdmVo.setKg18(String.valueOf(m.get("018")));                                                                                           
				allFaultyAdmVo.setKg19(String.valueOf(m.get("019")));                                                                                           
				allFaultyAdmVo.setKg20(String.valueOf(m.get("020")));                                                                                           
				allFaultyAdmVo.setKg21(String.valueOf(m.get("021")));                                                                                           
				allFaultyAdmVo.setKg22(String.valueOf(m.get("022")));                                                                                           
				allFaultyAdmVo.setKg23(String.valueOf(m.get("023")));                                                                                           
				allFaultyAdmVo.setKg24(String.valueOf(m.get("024")));                                                                                           
				allFaultyAdmVo.setKg25(String.valueOf(m.get("025")));                                                                                           
				allFaultyAdmVo.setKg26(String.valueOf(m.get("026")));                                                                                           
				allFaultyAdmVo.setKg27(String.valueOf(m.get("027")));                                                                                           
				allFaultyAdmVo.setKg28(String.valueOf(m.get("028")));                                                                                           
				allFaultyAdmVo.setKg29(String.valueOf(m.get("029")));                                                                                           
				allFaultyAdmVo.setKg30(String.valueOf(m.get("030")));                                                                                           
				allFaultyAdmVo.setKg31(String.valueOf(m.get("031")));                                                                                           
				allFaultyAdmVo.setKg32(String.valueOf(m.get("032")));                                                                                           
				allFaultyAdmVo.setKg33(String.valueOf(m.get("033")));                                                                                           
				allFaultyAdmVo.setKg34(String.valueOf(m.get("034")));                                                                                           
				allFaultyAdmVo.setKg35(String.valueOf(m.get("035")));                                                                                           
				allFaultyAdmVo.setKg36(String.valueOf(m.get("036")));                                                                                           
				allFaultyAdmVo.setKg37(String.valueOf(m.get("037")));                                                                                           
				allFaultyAdmVo.setKg38(String.valueOf(m.get("038")));                                                                                           
				allFaultyAdmVo.setKg39(String.valueOf(m.get("039")));                                                                                           
				allFaultyAdmVo.setKg40(String.valueOf(m.get("040")));                                                                                           
				                                                                                                                                                
				allFaultyAdmVo.setEa1(Float.toString((Float.parseFloat(String.valueOf(m.get("001"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa2(Float.toString((Float.parseFloat(String.valueOf(m.get("002"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa3(Float.toString((Float.parseFloat(String.valueOf(m.get("003"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa4(Float.toString((Float.parseFloat(String.valueOf(m.get("004"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa5(Float.toString((Float.parseFloat(String.valueOf(m.get("005"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa6(Float.toString((Float.parseFloat(String.valueOf(m.get("006"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa7(Float.toString((Float.parseFloat(String.valueOf(m.get("007"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa8(Float.toString((Float.parseFloat(String.valueOf(m.get("008"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa9(Float.toString((Float.parseFloat(String.valueOf(m.get("009"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));  
				allFaultyAdmVo.setEa10(Float.toString((Float.parseFloat(String.valueOf(m.get("010"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa11(Float.toString((Float.parseFloat(String.valueOf(m.get("011"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(m.get("012"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa13(Float.toString((Float.parseFloat(String.valueOf(m.get("013"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa14(Float.toString((Float.parseFloat(String.valueOf(m.get("014"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa15(Float.toString((Float.parseFloat(String.valueOf(m.get("015"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa16(Float.toString((Float.parseFloat(String.valueOf(m.get("016"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa17(Float.toString((Float.parseFloat(String.valueOf(m.get("017"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa18(Float.toString((Float.parseFloat(String.valueOf(m.get("018"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa19(Float.toString((Float.parseFloat(String.valueOf(m.get("019"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa20(Float.toString((Float.parseFloat(String.valueOf(m.get("020"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa21(Float.toString((Float.parseFloat(String.valueOf(m.get("021"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa22(Float.toString((Float.parseFloat(String.valueOf(m.get("022"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa23(Float.toString((Float.parseFloat(String.valueOf(m.get("023"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000));	
				allFaultyAdmVo.setEa24(Float.toString((Float.parseFloat(String.valueOf(m.get("024"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa25(Float.toString((Float.parseFloat(String.valueOf(m.get("025"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa26(Float.toString((Float.parseFloat(String.valueOf(m.get("026"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa27(Float.toString((Float.parseFloat(String.valueOf(m.get("027"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa28(Float.toString((Float.parseFloat(String.valueOf(m.get("028"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa29(Float.toString((Float.parseFloat(String.valueOf(m.get("029"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa30(Float.toString((Float.parseFloat(String.valueOf(m.get("030"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa31(Float.toString((Float.parseFloat(String.valueOf(m.get("031"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa32(Float.toString((Float.parseFloat(String.valueOf(m.get("032"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa33(Float.toString((Float.parseFloat(String.valueOf(m.get("033"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa34(Float.toString((Float.parseFloat(String.valueOf(m.get("034"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa35(Float.toString((Float.parseFloat(String.valueOf(m.get("035"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa36(Float.toString((Float.parseFloat(String.valueOf(m.get("036"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa37(Float.toString((Float.parseFloat(String.valueOf(m.get("037"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa38(Float.toString((Float.parseFloat(String.valueOf(m.get("038"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa39(Float.toString((Float.parseFloat(String.valueOf(m.get("039"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				allFaultyAdmVo.setEa40(Float.toString((Float.parseFloat(String.valueOf(m.get("040"))) / Float.parseFloat(m.get("GRAVITY").toString())) * 1000)); 
				
				allFaultyAdmVo.setCount1(allFaultyAdmDataList2.get(a).getCount1());   
				allFaultyAdmVo.setCount2(allFaultyAdmDataList2.get(a).getCount2());   
				allFaultyAdmVo.setCount3(allFaultyAdmDataList2.get(a).getCount3());   
				allFaultyAdmVo.setCount4(allFaultyAdmDataList2.get(a).getCount4());   
				allFaultyAdmVo.setCount5(allFaultyAdmDataList2.get(a).getCount5());   
				allFaultyAdmVo.setCount6(allFaultyAdmDataList2.get(a).getCount6());   
				allFaultyAdmVo.setCount7(allFaultyAdmDataList2.get(a).getCount7());   
				allFaultyAdmVo.setCount8(allFaultyAdmDataList2.get(a).getCount8());   
				allFaultyAdmVo.setCount9(allFaultyAdmDataList2.get(a).getCount9());   
				allFaultyAdmVo.setCount10(allFaultyAdmDataList2.get(a).getCount10());  
				allFaultyAdmVo.setCount11(allFaultyAdmDataList2.get(a).getCount11());  
				allFaultyAdmVo.setCount12(allFaultyAdmDataList2.get(a).getCount12());  
				allFaultyAdmVo.setCount13(allFaultyAdmDataList2.get(a).getCount13());  
				allFaultyAdmVo.setCount14(allFaultyAdmDataList2.get(a).getCount14());  
				allFaultyAdmVo.setCount15(allFaultyAdmDataList2.get(a).getCount15());  
				allFaultyAdmVo.setCount16(allFaultyAdmDataList2.get(a).getCount16());  
				allFaultyAdmVo.setCount17(allFaultyAdmDataList2.get(a).getCount17());  
				allFaultyAdmVo.setCount18(allFaultyAdmDataList2.get(a).getCount18());  
				allFaultyAdmVo.setCount19(allFaultyAdmDataList2.get(a).getCount19());  
				allFaultyAdmVo.setCount20(allFaultyAdmDataList2.get(a).getCount20());  
				allFaultyAdmVo.setCount21(allFaultyAdmDataList2.get(a).getCount21()); 
				allFaultyAdmVo.setCount22(allFaultyAdmDataList2.get(a).getCount22()); 
				allFaultyAdmVo.setCount23(allFaultyAdmDataList2.get(a).getCount23()); 
				allFaultyAdmVo.setCount24(allFaultyAdmDataList2.get(a).getCount24()); 
				allFaultyAdmVo.setCount25(allFaultyAdmDataList2.get(a).getCount25()); 
				allFaultyAdmVo.setCount26(allFaultyAdmDataList2.get(a).getCount26()); 
				allFaultyAdmVo.setCount27(allFaultyAdmDataList2.get(a).getCount27()); 
				allFaultyAdmVo.setCount28(allFaultyAdmDataList2.get(a).getCount28()); 
				allFaultyAdmVo.setCount29(allFaultyAdmDataList2.get(a).getCount29()); 
				allFaultyAdmVo.setCount30(allFaultyAdmDataList2.get(a).getCount30()); 
				allFaultyAdmVo.setCount31(allFaultyAdmDataList2.get(a).getCount31()); 
				allFaultyAdmVo.setCount32(allFaultyAdmDataList2.get(a).getCount32()); 
				allFaultyAdmVo.setCount33(allFaultyAdmDataList2.get(a).getCount33()); 
				allFaultyAdmVo.setCount34(allFaultyAdmDataList2.get(a).getCount34()); 
				allFaultyAdmVo.setCount35(allFaultyAdmDataList2.get(a).getCount35()); 
				allFaultyAdmVo.setCount36(allFaultyAdmDataList2.get(a).getCount36()); 
				allFaultyAdmVo.setCount37(allFaultyAdmDataList2.get(a).getCount37()); 
				allFaultyAdmVo.setCount38(allFaultyAdmDataList2.get(a).getCount38()); 
				allFaultyAdmVo.setCount39(allFaultyAdmDataList2.get(a).getCount39()); 
				allFaultyAdmVo.setCount40(allFaultyAdmDataList2.get(a).getCount40()); 

				if ("0".equals(allFaultyAdmDataList3.get(a).getContent1())) {allFaultyAdmVo.setContent1("-");} else { allFaultyAdmVo.setContent1(allFaultyAdmDataList3.get(a).getContent1());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent2())) {allFaultyAdmVo.setContent2("-");} else { allFaultyAdmVo.setContent2(allFaultyAdmDataList3.get(a).getContent2());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent3())) {allFaultyAdmVo.setContent3("-");} else { allFaultyAdmVo.setContent3(allFaultyAdmDataList3.get(a).getContent3());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent4())) {allFaultyAdmVo.setContent4("-");} else { allFaultyAdmVo.setContent4(allFaultyAdmDataList3.get(a).getContent4());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent5())) {allFaultyAdmVo.setContent5("-");} else { allFaultyAdmVo.setContent5(allFaultyAdmDataList3.get(a).getContent5());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent6())) {allFaultyAdmVo.setContent6("-");} else { allFaultyAdmVo.setContent6(allFaultyAdmDataList3.get(a).getContent6());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent7())) {allFaultyAdmVo.setContent7("-");} else { allFaultyAdmVo.setContent7(allFaultyAdmDataList3.get(a).getContent7());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent8())) {allFaultyAdmVo.setContent8("-");} else { allFaultyAdmVo.setContent8(allFaultyAdmDataList3.get(a).getContent8());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent9())) {allFaultyAdmVo.setContent9("-");} else { allFaultyAdmVo.setContent9(allFaultyAdmDataList3.get(a).getContent9());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent10())) {allFaultyAdmVo.setContent10("-");} else { allFaultyAdmVo.setContent10(allFaultyAdmDataList3.get(a).getContent10());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent11())) {allFaultyAdmVo.setContent11("-");} else { allFaultyAdmVo.setContent11(allFaultyAdmDataList3.get(a).getContent11());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent12())) {allFaultyAdmVo.setContent12("-");} else { allFaultyAdmVo.setContent12(allFaultyAdmDataList3.get(a).getContent12());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent13())) {allFaultyAdmVo.setContent13("-");} else { allFaultyAdmVo.setContent13(allFaultyAdmDataList3.get(a).getContent13());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent14())) {allFaultyAdmVo.setContent14("-");} else { allFaultyAdmVo.setContent14(allFaultyAdmDataList3.get(a).getContent14());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent15())) {allFaultyAdmVo.setContent15("-");} else { allFaultyAdmVo.setContent15(allFaultyAdmDataList3.get(a).getContent15());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent16())) {allFaultyAdmVo.setContent16("-");} else { allFaultyAdmVo.setContent16(allFaultyAdmDataList3.get(a).getContent16());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent17())) {allFaultyAdmVo.setContent17("-");} else { allFaultyAdmVo.setContent17(allFaultyAdmDataList3.get(a).getContent17());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent18())) {allFaultyAdmVo.setContent18("-");} else { allFaultyAdmVo.setContent18(allFaultyAdmDataList3.get(a).getContent18());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent19())) {allFaultyAdmVo.setContent19("-");} else { allFaultyAdmVo.setContent19(allFaultyAdmDataList3.get(a).getContent19());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent20())) {allFaultyAdmVo.setContent20("-");} else { allFaultyAdmVo.setContent20(allFaultyAdmDataList3.get(a).getContent20());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent21())) {allFaultyAdmVo.setContent21("-");} else { allFaultyAdmVo.setContent21(allFaultyAdmDataList3.get(a).getContent21());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent22())) {allFaultyAdmVo.setContent22("-");} else { allFaultyAdmVo.setContent22(allFaultyAdmDataList3.get(a).getContent22());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent23())) {allFaultyAdmVo.setContent23("-");} else { allFaultyAdmVo.setContent23(allFaultyAdmDataList3.get(a).getContent23());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent24())) {allFaultyAdmVo.setContent24("-");} else { allFaultyAdmVo.setContent24(allFaultyAdmDataList3.get(a).getContent24());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent25())) {allFaultyAdmVo.setContent25("-");} else { allFaultyAdmVo.setContent25(allFaultyAdmDataList3.get(a).getContent25());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent26())) {allFaultyAdmVo.setContent26("-");} else { allFaultyAdmVo.setContent26(allFaultyAdmDataList3.get(a).getContent26());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent27())) {allFaultyAdmVo.setContent27("-");} else { allFaultyAdmVo.setContent27(allFaultyAdmDataList3.get(a).getContent27());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent28())) {allFaultyAdmVo.setContent28("-");} else { allFaultyAdmVo.setContent28(allFaultyAdmDataList3.get(a).getContent28());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent29())) {allFaultyAdmVo.setContent29("-");} else { allFaultyAdmVo.setContent29(allFaultyAdmDataList3.get(a).getContent29());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent30())) {allFaultyAdmVo.setContent30("-");} else { allFaultyAdmVo.setContent30(allFaultyAdmDataList3.get(a).getContent30());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent31())) {allFaultyAdmVo.setContent31("-");} else { allFaultyAdmVo.setContent31(allFaultyAdmDataList3.get(a).getContent31());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent32())) {allFaultyAdmVo.setContent32("-");} else { allFaultyAdmVo.setContent32(allFaultyAdmDataList3.get(a).getContent32());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent33())) {allFaultyAdmVo.setContent33("-");} else { allFaultyAdmVo.setContent33(allFaultyAdmDataList3.get(a).getContent33());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent34())) {allFaultyAdmVo.setContent34("-");} else { allFaultyAdmVo.setContent34(allFaultyAdmDataList3.get(a).getContent34());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent35())) {allFaultyAdmVo.setContent35("-");} else { allFaultyAdmVo.setContent35(allFaultyAdmDataList3.get(a).getContent35());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent36())) {allFaultyAdmVo.setContent36("-");} else { allFaultyAdmVo.setContent36(allFaultyAdmDataList3.get(a).getContent36());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent37())) {allFaultyAdmVo.setContent37("-");} else { allFaultyAdmVo.setContent37(allFaultyAdmDataList3.get(a).getContent37());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent38())) {allFaultyAdmVo.setContent38("-");} else { allFaultyAdmVo.setContent38(allFaultyAdmDataList3.get(a).getContent38());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent39())) {allFaultyAdmVo.setContent39("-");} else { allFaultyAdmVo.setContent39(allFaultyAdmDataList3.get(a).getContent39());}
				if ("0".equals(allFaultyAdmDataList3.get(a).getContent40())) {allFaultyAdmVo.setContent40("-");} else { allFaultyAdmVo.setContent40(allFaultyAdmDataList3.get(a).getContent40());}
				
				allFaultyAdmDataList.add(allFaultyAdmVo);
				a++;
			}
			
			jsonData.put("data", allFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비 Trouble불량 기간 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//권취중량 일별 목록조회
	@RequestMapping(value = "wm/readFaultyQty", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readFaultyQty(FaultyQtyVo faultyQtyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("권취중량 기간 목록 조회");
		try {
			
			faultyQtyVo.setFactoryCode(factoryCode);
			List<FaultyQtyVo> readFaultyQtyList = equipFaultyService.readFaultyQty(faultyQtyVo);
			
			jsonData.put("data", readFaultyQtyList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("권취중량 기간 목록 조회 에러");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//불량중량
	@RequestMapping(value = "/wmsc0110", method = RequestMethod.GET)
	public String wmsc0110GET(Locale locale, Model model) throws Exception {
		logger.info("생산관리 불량중량페이지");
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();	//설비코드
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList);

		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setGroupCode1("'052', '053', '054', '055'");	//생산-공정조정, 원자재불량, 교체Loss, 설비 부품교체
		List<SystemCommonGroupVo>  gubunList = systemCommonGroupService.listAll(systemCommonGroupVo);
		
		model.addAttribute("gubunCd", gubunList);
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setGroupCode1("'052', '053', '054', '055'"); // Location
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCode", systemCommonCodeList);
		
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "wm/wmsc0110";
	}
	
	//불량중량 목록조회
	@RequestMapping(value = "wm/badWeightList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> badWeightList(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량중량 목록조회 - " + allFaultyAdmVo);
		try {
			String equipCdList = allFaultyAdmVo.getEquipCd();
			equipCdList = equipCdList.replace("/", "', '");
			equipCdList = equipCdList.substring(3, equipCdList.length());
			equipCdList += "'";
			allFaultyAdmVo.setEquipCd(equipCdList);
			//052 = 001(생산-공정조정), 053 = 002(원자재불량), 054 = 003(교체Loss), 055 = 004(설비 부품교체)
			if ("052".equals(allFaultyAdmVo.getGubun())) {
				allFaultyAdmVo.setGubun("001");
			} else if ("053".equals(allFaultyAdmVo.getGubun())) {
				allFaultyAdmVo.setGubun("002");
			} else if ("054".equals(allFaultyAdmVo.getGubun())) {
				allFaultyAdmVo.setGubun("003");
			} else if ("055".equals(allFaultyAdmVo.getGubun())) {
				allFaultyAdmVo.setGubun("004");
			}
			List<AllFaultyAdmVo> badWeightList = allFaultyAdmService.badWeightList(allFaultyAdmVo);
			jsonData.put("data", badWeightList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("불량중량 목록조회");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드 시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	//모든 장애 목록 조회
	@RequestMapping(value = "wm/allFaultList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> allFaultList(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모든 장애 목록 조회");
		try {
			
			String systemCode = "";
			
			logger.info("오늘날짜 이무니다 : " + DateUtil.getToday("yyyyMMdd"));
			
			//시스템 코드 값 담아주기
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			

			
			
			systemCode = systemCode.substring(0, systemCode.length() - 1);
			logger.info(systemCode);
			//시스템 코드 값 담아주기 끝
			
			//전체 값 담아줄 변수
			List<AllFaultyAdmVo> allFaultArrayList = new ArrayList<AllFaultyAdmVo>();
			
			//생산-교체 Loss 교체(1)
			equipReplaceFaultyAdmVo.setSystemCode(systemCode);
			logger.info("1-KG");
			List<Map<String, String>> replaceAdmDataList 		= equipFaultyService.readReplaceFaultyListKg(equipReplaceFaultyAdmVo);
			logger.info("1-Count");
			List<Map<String, String>> replaceAdmDataList2 		= equipFaultyService.readReplaceFaultyListCount(equipReplaceFaultyAdmVo);
			
			//생산-공정 조정(2)
			EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo 		= new EquipPrcssFaultyAdmVo();
			equipPrcssFaultyAdmVo.setSystemCode(systemCode);
			equipPrcssFaultyAdmVo.setFaultyDateTo(equipReplaceFaultyAdmVo.getFaultyDateTo());
			equipPrcssFaultyAdmVo.setFaultyDateFrom(equipReplaceFaultyAdmVo.getFaultyDateFrom());
			logger.info("2-KG");
			List<Map<String, String>> prcssFaultyAdmDataList_2	= equipFaultyService.readPrcssFaultyListKg(equipPrcssFaultyAdmVo);
			
			//생산-원자재불량 교체(3)
			EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo			= new EquipMatrlFaultyAdmVo();
			equipMatrlFaultyAdmVo.setSystemCode(systemCode);
			equipMatrlFaultyAdmVo.setFaultyDateTo(equipReplaceFaultyAdmVo.getFaultyDateTo());
			equipMatrlFaultyAdmVo.setFaultyDateFrom(equipReplaceFaultyAdmVo.getFaultyDateFrom());
			logger.info("3-KG");
			List<Map<String, String>> prcssFaultyAdmDataList_3	= equipFaultyService.readMatrlFaultyListKg(equipMatrlFaultyAdmVo);
			
			//생산-설비 부품 교체(4)
			EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo 	= new EquipTroubleFaultyAdmVo();
			equipTroubleFaultyAdmVo.setSystemCode(systemCode);
			equipTroubleFaultyAdmVo.setFaultyDateTo(equipReplaceFaultyAdmVo.getFaultyDateTo());
			equipTroubleFaultyAdmVo.setFaultyDateFrom(equipReplaceFaultyAdmVo.getFaultyDateFrom());
			logger.info("4-KG");
			List<Map<String, String>> troubleAdmDataList_4 		= equipFaultyService.readTroubleFaultyListKg(equipTroubleFaultyAdmVo);
			logger.info("4-Count");
			List<Map<String, String>> troubleAdmDataList2_4		= equipFaultyService.readTroubleFaultyListCount(equipTroubleFaultyAdmVo);
			logger.info("4-Content");
			List<Map<String, String>> troubleAdmDataList3_4		= equipFaultyService.readTroubleFaultyListContent(equipTroubleFaultyAdmVo);
			
			//list 값 비교 후 MAX값 찾기
			int maxCount	= 0;
			int[] take		= new int[7];	//List 사이즈 만큼 선언
			maxCount = replaceAdmDataList.size();
			take[0] = replaceAdmDataList.size();
			take[1] = replaceAdmDataList2.size();
			take[2] = prcssFaultyAdmDataList_2.size();
			take[3] = prcssFaultyAdmDataList_3.size();
			take[4] = troubleAdmDataList_4.size();
			take[5] = troubleAdmDataList2_4.size();
			take[6] = troubleAdmDataList3_4.size();
			
			for(int i=0; i<6; i++) {
				if(maxCount<=take[(i+1)]) {
					maxCount = take[(i+1)];
					
				}
			}
			logger.info("maxCount 값 확인 : " +maxCount);
			//list 값 비교 후 MAX값 찾기 끝
			
			//전체 값 담아주기
			for(int i = 0; i < maxCount; i++) {
				AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
				
				/*logger.info("(1)-1번 KG -----> " +replaceAdmDataList.get(i).get("GOODS_NM"));
				logger.info("(1)-2번 KG -----> " +prcssFaultyAdmDataList_2.get(i).get("GOODS_NM"));
				logger.info("(1)-3번 KG -----> " +prcssFaultyAdmDataList_3.get(i).get("GOODS_NM"));
				logger.info("(1)-4번 KG -----> " +troubleAdmDataList_4.get(i).get("GOODS_NM"));*/
				
				allFaultyAdmVo.setEquipNm(replaceAdmDataList.get(i).get("EQUIP_NM").toString());
			    allFaultyAdmVo.setDayNightNm(replaceAdmDataList.get(i).get("DAY_NIGHT_NM").toString());
			    allFaultyAdmVo.setFaultyRegDate(replaceAdmDataList.get(i).get("ORD_DATE").toString());
				
				//기본정보 - 전체 값 중 제품이 null 또는 빈값이 아닐경우 제품, 재질 값 담아주기
				if(replaceAdmDataList.get(i).get("GOODS_NM") != null && !replaceAdmDataList.get(i).get("GOODS_NM").equals("")) {
					logger.info("1번 KG -----> " +replaceAdmDataList.get(i).get("GOODS_NM").toString());
					
					allFaultyAdmVo.setGoodsNm(replaceAdmDataList.get(i).get("GOODS_NM").toString());
				    allFaultyAdmVo.setAlnicuMatrlNm(replaceAdmDataList.get(i).get("ALNICU_MATRL_NM").toString());
				    
				} else if(prcssFaultyAdmDataList_2.get(i).get("GOODS_NM") != null && !prcssFaultyAdmDataList_2.get(i).get("GOODS_NM").equals("")) {
					logger.info("2 KG -----> " +prcssFaultyAdmDataList_2.get(i).get("GOODS_NM").toString());
					
				    allFaultyAdmVo.setGoodsNm(prcssFaultyAdmDataList_2.get(i).get("GOODS_NM").toString());
				    allFaultyAdmVo.setAlnicuMatrlNm(prcssFaultyAdmDataList_2.get(i).get("ALNICU_MATRL_NM").toString());
				    
				} else if(prcssFaultyAdmDataList_3.get(i).get("GOODS_NM") != null && !prcssFaultyAdmDataList_3.get(i).get("GOODS_NM").equals("")) {
					logger.info("3번 KG -----> " +prcssFaultyAdmDataList_3.get(i).get("GOODS_NM").toString());
					
				    allFaultyAdmVo.setGoodsNm(prcssFaultyAdmDataList_3.get(i).get("GOODS_NM").toString());
				    allFaultyAdmVo.setAlnicuMatrlNm(prcssFaultyAdmDataList_3.get(i).get("ALNICU_MATRL_NM").toString());
				    
				} else if(troubleAdmDataList_4.get(i).get("GOODS_NM") != null && !troubleAdmDataList_4.get(i).get("GOODS_NM").equals("")) {
					logger.info("4번 KG -----> " +troubleAdmDataList_4.get(i).get("GOODS_NM").toString());
					
				    allFaultyAdmVo.setGoodsNm(troubleAdmDataList_4.get(i).get("GOODS_NM").toString());
				    allFaultyAdmVo.setAlnicuMatrlNm(troubleAdmDataList_4.get(i).get("ALNICU_MATRL_NM").toString());
				}
				
				//생산-교체 Loss 교체(1) 시작
				if (replaceAdmDataList.size() > i) {
					//기본정보
					/*allFaultyAdmVo.setEquipNm(replaceAdmDataList.get(i).get("EQUIP_NM").toString());
				    allFaultyAdmVo.setGoodsNm(replaceAdmDataList.get(i).get("GOODS_NM").toString());
				    allFaultyAdmVo.setDayNightNm(replaceAdmDataList.get(i).get("DAY_NIGHT_NM").toString());
				    allFaultyAdmVo.setAlnicuMatrlNm(replaceAdmDataList.get(i).get("ALNICU_MATRL_NM").toString());
				    //allFaultyAdmVo.setWorkTeamNm(replaceAdmDataList.get(i).get("WORK_TEAM_NM").toString());
				    //allFaultyAdmVo.setUserNm(replaceAdmDataList.get(i).get("USER_NM").toString());
				    allFaultyAdmVo.setFaultyRegDate(replaceAdmDataList.get(i).get("ORD_DATE").toString());*/
					/*
					 * JSONArray jsonarr = new JSONArray();
					 * 
					 * 
					 * JSONObject asdf = new JSONObject(); asdf.put("kg"+1, get);
					 * 
					 * jsonarr.add(asdf); String jsonString = jsonarr.toString();
					 */
					
					 /*let parseData = JSON.parse(row['jsonString']);
					 parseData['kg1']*/
					 
					 
					allFaultyAdmVo.setKg1(String.valueOf(replaceAdmDataList.get(i).get("001")));
					allFaultyAdmVo.setKg2(String.valueOf(replaceAdmDataList.get(i).get("002")));
					allFaultyAdmVo.setKg3(String.valueOf(replaceAdmDataList.get(i).get("003")));
					allFaultyAdmVo.setKg4(String.valueOf(replaceAdmDataList.get(i).get("004")));
					allFaultyAdmVo.setKg5(String.valueOf(replaceAdmDataList.get(i).get("005")));
					allFaultyAdmVo.setKg6(String.valueOf(replaceAdmDataList.get(i).get("006")));
					allFaultyAdmVo.setKg7(String.valueOf(replaceAdmDataList.get(i).get("007")));
					allFaultyAdmVo.setKg8(String.valueOf(replaceAdmDataList.get(i).get("008")));
					allFaultyAdmVo.setKg9(String.valueOf(replaceAdmDataList.get(i).get("009")));
					allFaultyAdmVo.setKg10(String.valueOf(replaceAdmDataList.get(i).get("010")));
					allFaultyAdmVo.setKg11(String.valueOf(replaceAdmDataList.get(i).get("011")));
					allFaultyAdmVo.setKg12(String.valueOf(replaceAdmDataList.get(i).get("012")));
					allFaultyAdmVo.setKg13(String.valueOf(replaceAdmDataList.get(i).get("013")));
					allFaultyAdmVo.setKg14(String.valueOf(replaceAdmDataList.get(i).get("014")));
					allFaultyAdmVo.setKg15(String.valueOf(replaceAdmDataList.get(i).get("015")));
					allFaultyAdmVo.setKg16(String.valueOf(replaceAdmDataList.get(i).get("016")));
					allFaultyAdmVo.setKg17(String.valueOf(replaceAdmDataList.get(i).get("017")));
					allFaultyAdmVo.setKg18(String.valueOf(replaceAdmDataList.get(i).get("018")));
					allFaultyAdmVo.setKg19(String.valueOf(replaceAdmDataList.get(i).get("019")));
					allFaultyAdmVo.setKg20(String.valueOf(replaceAdmDataList.get(i).get("020")));
					allFaultyAdmVo.setKg21(String.valueOf(replaceAdmDataList.get(i).get("021")));
					allFaultyAdmVo.setKg22(String.valueOf(replaceAdmDataList.get(i).get("022")));
					allFaultyAdmVo.setKg23(String.valueOf(replaceAdmDataList.get(i).get("023")));
					allFaultyAdmVo.setKg24(String.valueOf(replaceAdmDataList.get(i).get("024")));
					allFaultyAdmVo.setKg25(String.valueOf(replaceAdmDataList.get(i).get("025")));
					allFaultyAdmVo.setKg26(String.valueOf(replaceAdmDataList.get(i).get("026")));
					allFaultyAdmVo.setKg27(String.valueOf(replaceAdmDataList.get(i).get("027")));
					allFaultyAdmVo.setKg28(String.valueOf(replaceAdmDataList.get(i).get("028")));
					allFaultyAdmVo.setKg29(String.valueOf(replaceAdmDataList.get(i).get("029")));
					allFaultyAdmVo.setKg30(String.valueOf(replaceAdmDataList.get(i).get("030")));
					allFaultyAdmVo.setKg31(String.valueOf(replaceAdmDataList.get(i).get("031")));
					allFaultyAdmVo.setKg32(String.valueOf(replaceAdmDataList.get(i).get("032")));
					allFaultyAdmVo.setKg33(String.valueOf(replaceAdmDataList.get(i).get("033")));
					allFaultyAdmVo.setKg34(String.valueOf(replaceAdmDataList.get(i).get("034")));
					allFaultyAdmVo.setKg35(String.valueOf(replaceAdmDataList.get(i).get("035")));
					allFaultyAdmVo.setKg36(String.valueOf(replaceAdmDataList.get(i).get("036")));
					allFaultyAdmVo.setKg37(String.valueOf(replaceAdmDataList.get(i).get("037")));
					allFaultyAdmVo.setKg38(String.valueOf(replaceAdmDataList.get(i).get("038")));
					allFaultyAdmVo.setKg39(String.valueOf(replaceAdmDataList.get(i).get("039")));
					allFaultyAdmVo.setKg40(String.valueOf(replaceAdmDataList.get(i).get("040")));
					                                                                                                                                                
					allFaultyAdmVo.setEa1(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("001"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa2(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("002"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa3(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("003"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa4(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("004"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa5(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("005"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa6(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("006"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa7(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("007"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa8(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("008"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa9(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("009"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa10(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("010"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa11(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("011"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa12(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("012"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa13(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("013"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa14(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("014"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa15(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("015"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa16(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("016"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa17(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("017"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa18(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("018"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa19(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("019"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa20(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("020"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa21(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("021"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa22(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("022"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa23(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("023"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa24(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("024"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa25(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("025"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa26(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("026"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa27(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("027"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa28(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("028"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa29(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("029"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa30(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("030"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa31(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("031"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa32(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("032"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa33(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("033"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa34(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("034"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa35(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("035"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa36(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("036"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa37(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("037"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa38(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("038"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa39(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("039"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa40(Float.toString((Float.parseFloat(String.valueOf(replaceAdmDataList.get(i).get("040"))) / Float.parseFloat(replaceAdmDataList.get(i).get("GRAVITY").toString())) * 1000));
				}
				
				if (replaceAdmDataList2.size() > i) {
					allFaultyAdmVo.setCount1(String.valueOf(replaceAdmDataList2.get(i).get("001")));
					allFaultyAdmVo.setCount2(String.valueOf(replaceAdmDataList2.get(i).get("002")));
					allFaultyAdmVo.setCount3(String.valueOf(replaceAdmDataList2.get(i).get("003")));
					allFaultyAdmVo.setCount4(String.valueOf(replaceAdmDataList2.get(i).get("004")));
					allFaultyAdmVo.setCount5(String.valueOf(replaceAdmDataList2.get(i).get("005")));
					allFaultyAdmVo.setCount6(String.valueOf(replaceAdmDataList2.get(i).get("006")));
					allFaultyAdmVo.setCount7(String.valueOf(replaceAdmDataList2.get(i).get("007")));
					allFaultyAdmVo.setCount8(String.valueOf(replaceAdmDataList2.get(i).get("008")));
					allFaultyAdmVo.setCount9(String.valueOf(replaceAdmDataList2.get(i).get("009")));
					allFaultyAdmVo.setCount10(String.valueOf(replaceAdmDataList2.get(i).get("010")));
					allFaultyAdmVo.setCount11(String.valueOf(replaceAdmDataList2.get(i).get("011")));
					allFaultyAdmVo.setCount12(String.valueOf(replaceAdmDataList2.get(i).get("012")));
					allFaultyAdmVo.setCount13(String.valueOf(replaceAdmDataList2.get(i).get("013")));
					allFaultyAdmVo.setCount14(String.valueOf(replaceAdmDataList2.get(i).get("014")));
					allFaultyAdmVo.setCount15(String.valueOf(replaceAdmDataList2.get(i).get("015")));
					allFaultyAdmVo.setCount16(String.valueOf(replaceAdmDataList2.get(i).get("016")));
					allFaultyAdmVo.setCount17(String.valueOf(replaceAdmDataList2.get(i).get("017")));
					allFaultyAdmVo.setCount18(String.valueOf(replaceAdmDataList2.get(i).get("018")));
					allFaultyAdmVo.setCount19(String.valueOf(replaceAdmDataList2.get(i).get("019")));
					allFaultyAdmVo.setCount20(String.valueOf(replaceAdmDataList2.get(i).get("020")));
					allFaultyAdmVo.setCount21(String.valueOf(replaceAdmDataList2.get(i).get("021")));
					allFaultyAdmVo.setCount22(String.valueOf(replaceAdmDataList2.get(i).get("022")));
					allFaultyAdmVo.setCount23(String.valueOf(replaceAdmDataList2.get(i).get("023")));
					allFaultyAdmVo.setCount24(String.valueOf(replaceAdmDataList2.get(i).get("024")));
					allFaultyAdmVo.setCount25(String.valueOf(replaceAdmDataList2.get(i).get("025")));
					allFaultyAdmVo.setCount26(String.valueOf(replaceAdmDataList2.get(i).get("026")));
					allFaultyAdmVo.setCount27(String.valueOf(replaceAdmDataList2.get(i).get("027")));
					allFaultyAdmVo.setCount28(String.valueOf(replaceAdmDataList2.get(i).get("028")));
					allFaultyAdmVo.setCount29(String.valueOf(replaceAdmDataList2.get(i).get("029")));
					allFaultyAdmVo.setCount30(String.valueOf(replaceAdmDataList2.get(i).get("030")));
					allFaultyAdmVo.setCount31(String.valueOf(replaceAdmDataList2.get(i).get("031")));
					allFaultyAdmVo.setCount32(String.valueOf(replaceAdmDataList2.get(i).get("032")));
					allFaultyAdmVo.setCount33(String.valueOf(replaceAdmDataList2.get(i).get("033")));
					allFaultyAdmVo.setCount34(String.valueOf(replaceAdmDataList2.get(i).get("034")));
					allFaultyAdmVo.setCount35(String.valueOf(replaceAdmDataList2.get(i).get("035")));
					allFaultyAdmVo.setCount36(String.valueOf(replaceAdmDataList2.get(i).get("036")));
					allFaultyAdmVo.setCount37(String.valueOf(replaceAdmDataList2.get(i).get("037")));
					allFaultyAdmVo.setCount38(String.valueOf(replaceAdmDataList2.get(i).get("038")));
					allFaultyAdmVo.setCount39(String.valueOf(replaceAdmDataList2.get(i).get("039")));
					allFaultyAdmVo.setCount40(String.valueOf(replaceAdmDataList2.get(i).get("040")));
				}
				//생산-교체 Loss 교체(1)끝
				
				//생산-공정 조정(2) 시작
				if (prcssFaultyAdmDataList_2.size() > i) {
					allFaultyAdmVo.setKg1_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("001")));
					allFaultyAdmVo.setKg2_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("002")));
					allFaultyAdmVo.setKg3_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("003")));
					allFaultyAdmVo.setKg4_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("004")));
					allFaultyAdmVo.setKg5_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("005")));
					allFaultyAdmVo.setKg6_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("006")));
					allFaultyAdmVo.setKg7_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("007")));
					allFaultyAdmVo.setKg8_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("008")));
					allFaultyAdmVo.setKg9_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("009")));
					allFaultyAdmVo.setKg10_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("010")));
					allFaultyAdmVo.setKg11_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("011")));
					
					//allFaultyAdmVo.setKg12_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("012")));
					allFaultyAdmVo.setKg12_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("023")));	//치수 불량(023) 중간 구멍 대체.. 해결방법은..?
					
					allFaultyAdmVo.setKg13_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("013")));
					allFaultyAdmVo.setKg14_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("014")));
					allFaultyAdmVo.setKg15_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("015")));
					allFaultyAdmVo.setKg16_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("016")));
					allFaultyAdmVo.setKg17_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("017")));
					allFaultyAdmVo.setKg18_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("018")));
					allFaultyAdmVo.setKg19_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("019")));
					allFaultyAdmVo.setKg20_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("020")));
					allFaultyAdmVo.setKg21_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("021")));
					allFaultyAdmVo.setKg22_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("022")));
					allFaultyAdmVo.setKg23_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("023")));
					allFaultyAdmVo.setKg24_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("024")));
					allFaultyAdmVo.setKg25_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("025")));
					allFaultyAdmVo.setKg26_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("026")));
					allFaultyAdmVo.setKg27_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("027")));
					allFaultyAdmVo.setKg28_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("028")));
					allFaultyAdmVo.setKg29_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("029")));
					allFaultyAdmVo.setKg30_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("030")));
					allFaultyAdmVo.setKg31_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("031")));
					allFaultyAdmVo.setKg32_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("032")));
					allFaultyAdmVo.setKg33_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("033")));
					allFaultyAdmVo.setKg34_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("034")));
					allFaultyAdmVo.setKg35_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("035")));
					allFaultyAdmVo.setKg36_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("036")));
					allFaultyAdmVo.setKg37_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("037")));
					allFaultyAdmVo.setKg38_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("038")));
					allFaultyAdmVo.setKg39_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("039")));
					allFaultyAdmVo.setKg40_2(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("040")));
					
					allFaultyAdmVo.setEa1_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("001"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa2_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("002"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa3_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("003"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa4_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("004"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa5_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("005"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa6_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("006"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa7_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("007"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa8_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("008"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa9_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("009"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa10_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("010"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa11_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("011"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					
					//allFaultyAdmVo.setEa12_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("012"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa12_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("023"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));		//치수 불량(023) 중간 구멍 대체.. 해결방법은..?
					
					allFaultyAdmVo.setEa13_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("013"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa14_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("014"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa15_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("015"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa16_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("016"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa17_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("017"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa18_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("018"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa19_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("019"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa20_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("020"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa21_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("021"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa22_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("022"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa23_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("023"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa24_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("024"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa25_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("025"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa26_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("026"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa27_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("027"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa28_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("028"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa29_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("029"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa30_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("030"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa31_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("031"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa32_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("032"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa33_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("033"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa34_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("034"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa35_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("035"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa36_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("036"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa37_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("037"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa38_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("038"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa39_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("039"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa40_2(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_2.get(i).get("040"))) / Float.parseFloat(prcssFaultyAdmDataList_2.get(i).get("GRAVITY").toString())) * 1000));
				}
				//생산-공정 조정(2) 끝
				
				//생산-원자재불량 교체(3) 시작
				if (prcssFaultyAdmDataList_3.size() > i) {
					allFaultyAdmVo.setKg1_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("001")));
					allFaultyAdmVo.setKg2_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("002")));
					allFaultyAdmVo.setKg3_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("003")));
					allFaultyAdmVo.setKg4_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("004")));
					allFaultyAdmVo.setKg5_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("005")));
					allFaultyAdmVo.setKg6_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("006")));
					allFaultyAdmVo.setKg7_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("007")));
					allFaultyAdmVo.setKg8_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("008")));
					allFaultyAdmVo.setKg9_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("009")));
					allFaultyAdmVo.setKg10_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("010")));
					allFaultyAdmVo.setKg11_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("011")));
					allFaultyAdmVo.setKg12_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("012")));
					allFaultyAdmVo.setKg13_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("013")));
					allFaultyAdmVo.setKg14_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("014")));
					allFaultyAdmVo.setKg15_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("015")));
					allFaultyAdmVo.setKg16_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("016")));
					allFaultyAdmVo.setKg17_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("017")));
					allFaultyAdmVo.setKg18_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("018")));
					allFaultyAdmVo.setKg19_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("019")));
					allFaultyAdmVo.setKg20_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("020")));
					allFaultyAdmVo.setKg21_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("021")));
					allFaultyAdmVo.setKg22_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("022")));
					allFaultyAdmVo.setKg23_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("023")));
					allFaultyAdmVo.setKg24_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("024")));
					allFaultyAdmVo.setKg25_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("025")));
					allFaultyAdmVo.setKg26_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("026")));
					allFaultyAdmVo.setKg27_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("027")));
					allFaultyAdmVo.setKg28_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("028")));
					allFaultyAdmVo.setKg29_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("029")));
					allFaultyAdmVo.setKg30_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("030")));
					allFaultyAdmVo.setKg31_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("031")));
					allFaultyAdmVo.setKg32_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("032")));
					allFaultyAdmVo.setKg33_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("033")));
					allFaultyAdmVo.setKg34_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("034")));
					allFaultyAdmVo.setKg35_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("035")));
					allFaultyAdmVo.setKg36_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("036")));
					allFaultyAdmVo.setKg37_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("037")));
					allFaultyAdmVo.setKg38_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("038")));
					allFaultyAdmVo.setKg39_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("039")));
					allFaultyAdmVo.setKg40_3(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("040")));
					
					allFaultyAdmVo.setEa1_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("001"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa2_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("002"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa3_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("003"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa4_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("004"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa5_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("005"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa6_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("006"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa7_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("007"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa8_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("008"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa9_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("009"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa10_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("010"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa11_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("011"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa12_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("012"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa13_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("013"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa14_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("014"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa15_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("015"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa16_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("016"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa17_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("017"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa18_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("018"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa19_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("019"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa20_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("020"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa21_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("021"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa22_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("022"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa23_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("023"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa24_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("024"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa25_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("025"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa26_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("026"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa27_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("027"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa28_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("028"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa29_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("029"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa30_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("030"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa31_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("031"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa32_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("032"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa33_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("033"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa34_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("034"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa35_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("035"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa36_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("036"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa37_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("037"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa38_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("038"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa39_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("039"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
					allFaultyAdmVo.setEa40_3(Float.toString((Float.parseFloat(String.valueOf(prcssFaultyAdmDataList_3.get(i).get("040"))) / Float.parseFloat(prcssFaultyAdmDataList_3.get(i).get("GRAVITY").toString())) * 1000));
				}
				//생산-원자재불량 교체(3) 끝
				
				//생산-설비 부품 교체(4) 시작
				if (troubleAdmDataList_4.size() > i) {
					allFaultyAdmVo.setKg1_4(String.valueOf(troubleAdmDataList_4.get(i).get("001")));                                                                                            
					allFaultyAdmVo.setKg2_4(String.valueOf(troubleAdmDataList_4.get(i).get("002")));                                                                                            
					allFaultyAdmVo.setKg3_4(String.valueOf(troubleAdmDataList_4.get(i).get("003")));                                                                                            
					allFaultyAdmVo.setKg4_4(String.valueOf(troubleAdmDataList_4.get(i).get("004")));                                                                                            
					allFaultyAdmVo.setKg5_4(String.valueOf(troubleAdmDataList_4.get(i).get("005")));                                                                                            
					allFaultyAdmVo.setKg6_4(String.valueOf(troubleAdmDataList_4.get(i).get("006")));                                                                                            
					allFaultyAdmVo.setKg7_4(String.valueOf(troubleAdmDataList_4.get(i).get("007")));                                                                                            
					allFaultyAdmVo.setKg8_4(String.valueOf(troubleAdmDataList_4.get(i).get("008")));                                                                                            
					allFaultyAdmVo.setKg9_4(String.valueOf(troubleAdmDataList_4.get(i).get("009")));                                                                                            
					allFaultyAdmVo.setKg10_4(String.valueOf(troubleAdmDataList_4.get(i).get("010")));                                                                                           
					allFaultyAdmVo.setKg11_4(String.valueOf(troubleAdmDataList_4.get(i).get("011")));                                                                                           
					allFaultyAdmVo.setKg12_4(String.valueOf(troubleAdmDataList_4.get(i).get("012")));                                                                                           
					allFaultyAdmVo.setKg13_4(String.valueOf(troubleAdmDataList_4.get(i).get("013")));                                                                                           
					allFaultyAdmVo.setKg14_4(String.valueOf(troubleAdmDataList_4.get(i).get("014")));                                                                                           
					allFaultyAdmVo.setKg15_4(String.valueOf(troubleAdmDataList_4.get(i).get("015")));                                                                                           
					allFaultyAdmVo.setKg16_4(String.valueOf(troubleAdmDataList_4.get(i).get("016")));                                                                                           
					allFaultyAdmVo.setKg17_4(String.valueOf(troubleAdmDataList_4.get(i).get("017")));                                                                                           
					allFaultyAdmVo.setKg18_4(String.valueOf(troubleAdmDataList_4.get(i).get("018")));                                                                                           
					allFaultyAdmVo.setKg19_4(String.valueOf(troubleAdmDataList_4.get(i).get("019")));                                                                                           
					allFaultyAdmVo.setKg20_4(String.valueOf(troubleAdmDataList_4.get(i).get("020")));                                                                                           
					allFaultyAdmVo.setKg21_4(String.valueOf(troubleAdmDataList_4.get(i).get("021")));                                                                                           
					allFaultyAdmVo.setKg22_4(String.valueOf(troubleAdmDataList_4.get(i).get("022")));                                                                                           
					allFaultyAdmVo.setKg23_4(String.valueOf(troubleAdmDataList_4.get(i).get("023")));                                                                                           
					allFaultyAdmVo.setKg24_4(String.valueOf(troubleAdmDataList_4.get(i).get("024")));                                                                                           
					allFaultyAdmVo.setKg25_4(String.valueOf(troubleAdmDataList_4.get(i).get("025")));                                                                                           
					allFaultyAdmVo.setKg26_4(String.valueOf(troubleAdmDataList_4.get(i).get("026")));                                                                                           
					allFaultyAdmVo.setKg27_4(String.valueOf(troubleAdmDataList_4.get(i).get("027")));                                                                                           
					allFaultyAdmVo.setKg28_4(String.valueOf(troubleAdmDataList_4.get(i).get("028")));                                                                                           
					allFaultyAdmVo.setKg29_4(String.valueOf(troubleAdmDataList_4.get(i).get("029")));                                                                                           
					allFaultyAdmVo.setKg30_4(String.valueOf(troubleAdmDataList_4.get(i).get("030")));                                                                                           
					allFaultyAdmVo.setKg31_4(String.valueOf(troubleAdmDataList_4.get(i).get("031")));                                                                                           
					allFaultyAdmVo.setKg32_4(String.valueOf(troubleAdmDataList_4.get(i).get("032")));                                                                                           
					allFaultyAdmVo.setKg33_4(String.valueOf(troubleAdmDataList_4.get(i).get("033")));                                                                                           
					allFaultyAdmVo.setKg34_4(String.valueOf(troubleAdmDataList_4.get(i).get("034")));                                                                                           
					allFaultyAdmVo.setKg35_4(String.valueOf(troubleAdmDataList_4.get(i).get("035")));                                                                                           
					allFaultyAdmVo.setKg36_4(String.valueOf(troubleAdmDataList_4.get(i).get("036")));                                                                                           
					allFaultyAdmVo.setKg37_4(String.valueOf(troubleAdmDataList_4.get(i).get("037")));                                                                                           
					allFaultyAdmVo.setKg38_4(String.valueOf(troubleAdmDataList_4.get(i).get("038")));                                                                                           
					allFaultyAdmVo.setKg39_4(String.valueOf(troubleAdmDataList_4.get(i).get("039")));                                                                                           
					allFaultyAdmVo.setKg40_4(String.valueOf(troubleAdmDataList_4.get(i).get("040")));                                                                                           
					                                                                                                                                                
					allFaultyAdmVo.setEa1_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("001"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa2_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("002"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa3_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("003"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa4_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("004"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa5_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("005"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa6_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("006"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa7_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("007"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa8_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("008"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa9_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("009"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));  
					allFaultyAdmVo.setEa10_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("010"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa11_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("011"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa12_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("012"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa13_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("013"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa14_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("014"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa15_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("015"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa16_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("016"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa17_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("017"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa18_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("018"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa19_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("019"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa20_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("020"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa21_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("021"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa22_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("022"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa23_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("023"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));	
					allFaultyAdmVo.setEa24_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("024"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa25_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("025"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa26_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("026"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa27_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("027"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa28_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("028"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa29_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("029"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa30_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("030"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa31_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("031"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa32_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("032"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa33_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("033"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa34_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("034"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa35_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("035"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa36_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("036"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa37_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("037"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa38_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("038"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa39_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("039"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000)); 
					allFaultyAdmVo.setEa40_4(Float.toString((Float.parseFloat(String.valueOf(troubleAdmDataList_4.get(i).get("040"))) / Float.parseFloat(troubleAdmDataList_4.get(i).get("GRAVITY").toString())) * 1000));
				}
				
				if (troubleAdmDataList2_4.size() > i) {
					allFaultyAdmVo.setCount1_4(String.valueOf(troubleAdmDataList2_4.get(i).get("001")));
					allFaultyAdmVo.setCount2_4(String.valueOf(troubleAdmDataList2_4.get(i).get("002")));
					allFaultyAdmVo.setCount3_4(String.valueOf(troubleAdmDataList2_4.get(i).get("003")));
					allFaultyAdmVo.setCount4_4(String.valueOf(troubleAdmDataList2_4.get(i).get("004")));
					allFaultyAdmVo.setCount5_4(String.valueOf(troubleAdmDataList2_4.get(i).get("005")));
					allFaultyAdmVo.setCount6_4(String.valueOf(troubleAdmDataList2_4.get(i).get("006")));
					allFaultyAdmVo.setCount7_4(String.valueOf(troubleAdmDataList2_4.get(i).get("007")));
					allFaultyAdmVo.setCount8_4(String.valueOf(troubleAdmDataList2_4.get(i).get("008")));
					allFaultyAdmVo.setCount9_4(String.valueOf(troubleAdmDataList2_4.get(i).get("009")));
					allFaultyAdmVo.setCount10_4(String.valueOf(troubleAdmDataList2_4.get(i).get("010")));
					allFaultyAdmVo.setCount11_4(String.valueOf(troubleAdmDataList2_4.get(i).get("011")));
					allFaultyAdmVo.setCount12_4(String.valueOf(troubleAdmDataList2_4.get(i).get("012")));
					allFaultyAdmVo.setCount13_4(String.valueOf(troubleAdmDataList2_4.get(i).get("013")));
					allFaultyAdmVo.setCount14_4(String.valueOf(troubleAdmDataList2_4.get(i).get("014")));
					allFaultyAdmVo.setCount15_4(String.valueOf(troubleAdmDataList2_4.get(i).get("015")));
					allFaultyAdmVo.setCount16_4(String.valueOf(troubleAdmDataList2_4.get(i).get("016")));
					allFaultyAdmVo.setCount17_4(String.valueOf(troubleAdmDataList2_4.get(i).get("017")));
					allFaultyAdmVo.setCount18_4(String.valueOf(troubleAdmDataList2_4.get(i).get("018")));
					allFaultyAdmVo.setCount19_4(String.valueOf(troubleAdmDataList2_4.get(i).get("019")));
					allFaultyAdmVo.setCount20_4(String.valueOf(troubleAdmDataList2_4.get(i).get("020")));
					allFaultyAdmVo.setCount21_4(String.valueOf(troubleAdmDataList2_4.get(i).get("021")));
					allFaultyAdmVo.setCount22_4(String.valueOf(troubleAdmDataList2_4.get(i).get("022")));
					allFaultyAdmVo.setCount23_4(String.valueOf(troubleAdmDataList2_4.get(i).get("023")));
					allFaultyAdmVo.setCount24_4(String.valueOf(troubleAdmDataList2_4.get(i).get("024")));
					allFaultyAdmVo.setCount25_4(String.valueOf(troubleAdmDataList2_4.get(i).get("025")));
					allFaultyAdmVo.setCount26_4(String.valueOf(troubleAdmDataList2_4.get(i).get("026")));
					allFaultyAdmVo.setCount27_4(String.valueOf(troubleAdmDataList2_4.get(i).get("027")));
					allFaultyAdmVo.setCount28_4(String.valueOf(troubleAdmDataList2_4.get(i).get("028")));
					allFaultyAdmVo.setCount29_4(String.valueOf(troubleAdmDataList2_4.get(i).get("029")));
					allFaultyAdmVo.setCount30_4(String.valueOf(troubleAdmDataList2_4.get(i).get("030")));
					allFaultyAdmVo.setCount31_4(String.valueOf(troubleAdmDataList2_4.get(i).get("031")));
					allFaultyAdmVo.setCount32_4(String.valueOf(troubleAdmDataList2_4.get(i).get("032")));
					allFaultyAdmVo.setCount33_4(String.valueOf(troubleAdmDataList2_4.get(i).get("033")));
					allFaultyAdmVo.setCount34_4(String.valueOf(troubleAdmDataList2_4.get(i).get("034")));
					allFaultyAdmVo.setCount35_4(String.valueOf(troubleAdmDataList2_4.get(i).get("035")));
					allFaultyAdmVo.setCount36_4(String.valueOf(troubleAdmDataList2_4.get(i).get("036")));
					allFaultyAdmVo.setCount37_4(String.valueOf(troubleAdmDataList2_4.get(i).get("037")));
					allFaultyAdmVo.setCount38_4(String.valueOf(troubleAdmDataList2_4.get(i).get("038")));
					allFaultyAdmVo.setCount39_4(String.valueOf(troubleAdmDataList2_4.get(i).get("039")));
					allFaultyAdmVo.setCount40_4(String.valueOf(troubleAdmDataList2_4.get(i).get("040")));
				}
				
				if (troubleAdmDataList3_4.size() > i) {
					allFaultyAdmVo.setContent1_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("001"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("001")));
					allFaultyAdmVo.setContent2_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("002"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("002")));
					allFaultyAdmVo.setContent3_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("003"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("003")));
					allFaultyAdmVo.setContent4_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("004"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("004")));
					allFaultyAdmVo.setContent5_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("005"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("005")));
					allFaultyAdmVo.setContent6_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("006"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("006")));
					allFaultyAdmVo.setContent7_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("007"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("007")));
					allFaultyAdmVo.setContent8_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("008"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("008")));
					allFaultyAdmVo.setContent9_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("009"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("009")));
					allFaultyAdmVo.setContent10_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("010"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("010")));
					allFaultyAdmVo.setContent11_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("011"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("011")));
					allFaultyAdmVo.setContent12_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("012"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("012")));
					allFaultyAdmVo.setContent13_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("013"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("013")));
					allFaultyAdmVo.setContent14_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("014"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("014")));
					allFaultyAdmVo.setContent15_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("015"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("015")));
					allFaultyAdmVo.setContent16_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("016"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("016")));
					allFaultyAdmVo.setContent17_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("017"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("017")));
					allFaultyAdmVo.setContent18_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("018"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("018")));
					allFaultyAdmVo.setContent19_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("019"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("019")));
					allFaultyAdmVo.setContent20_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("020"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("020")));
					allFaultyAdmVo.setContent21_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("021"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("021")));
					allFaultyAdmVo.setContent22_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("022"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("022")));
					allFaultyAdmVo.setContent23_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("023"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("023")));
					allFaultyAdmVo.setContent24_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("024"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("024")));
					allFaultyAdmVo.setContent25_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("025"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("025")));
					allFaultyAdmVo.setContent26_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("026"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("026")));
					allFaultyAdmVo.setContent27_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("027"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("027")));
					allFaultyAdmVo.setContent28_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("028"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("028")));
					allFaultyAdmVo.setContent29_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("029"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("029")));
					allFaultyAdmVo.setContent30_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("030"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("030")));
					allFaultyAdmVo.setContent31_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("031"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("031")));
					allFaultyAdmVo.setContent32_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("032"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("032")));
					allFaultyAdmVo.setContent33_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("033"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("033")));
					allFaultyAdmVo.setContent34_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("034"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("034")));
					allFaultyAdmVo.setContent35_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("035"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("035")));
					allFaultyAdmVo.setContent36_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("036"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("036")));
					allFaultyAdmVo.setContent37_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("037"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("037")));
					allFaultyAdmVo.setContent38_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("038"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("038")));
					allFaultyAdmVo.setContent39_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("039"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("039")));
					allFaultyAdmVo.setContent40_4("0".equals(String.valueOf(troubleAdmDataList3_4.get(i).get("040"))) ? "-" : String.valueOf(troubleAdmDataList3_4.get(i).get("040")));
				}
				//생산-설비 부품 교체(4)
				
				allFaultArrayList.add(allFaultyAdmVo);	//전체 Vo 값 담아주기
			}
			
			jsonData.put("data", allFaultArrayList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("모든 장애 목록 조회");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	
	
	
	
	
	
	//모든 장애 목록 조회
	@RequestMapping(value = "wm/allFaultList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> allFaultList_F3(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모든 장애 목록 조회");
		try {
			
			String systemCode = "";
			
			logger.info("오늘날짜 이무니다 : " + DateUtil.getToday("yyyyMMdd"));
			
			//시스템 코드 값 담아주기
			for(int i=1; i<=40; i++) {
				systemCode += "[";
				systemCode += String.format("%03d",i);
				systemCode += "],";
			}
			
			
			systemCode = systemCode.substring(0, systemCode.length() - 1);
			logger.info(systemCode);
			//시스템 코드 값 담아주기 끝
			
			//전체 값 담아줄 변수
			List<AllFaultyAdmVo> allFaultArrayList 			= new ArrayList<AllFaultyAdmVo>();
			AllFaultyAdmVo testVo = new AllFaultyAdmVo();
			List<Map<String, String>> allFaultArrayList2	= new ArrayList<Map<String, String>>();
			
			//VO 값 지정
			EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo = new EquipPrcssFaultyAdmVo();
			equipPrcssFaultyAdmVo.setSystemCode(systemCode);
			equipPrcssFaultyAdmVo.setFaultyDateTo(equipReplaceFaultyAdmVo.getFaultyDateTo());
			equipPrcssFaultyAdmVo.setFaultyDateFrom(equipReplaceFaultyAdmVo.getFaultyDateFrom());
			equipPrcssFaultyAdmVo.setGubun("001");

			//Cutting 수량
			List<Map<String, String>> faultyDataList052Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList052Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			
			//Metal 교체 Loss
			equipPrcssFaultyAdmVo.setGubun("002");
			List<Map<String, String>> faultyDataList053Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList053Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			
			//Film 교체 Loss
			equipPrcssFaultyAdmVo.setGubun("003");
			List<Map<String, String>> faultyDataList054Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList054Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			
			//Teflon 교체 Loss
			equipPrcssFaultyAdmVo.setGubun("004");
			List<Map<String, String>> faultyDataList055Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList055Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			
			//Strip Loss
			equipPrcssFaultyAdmVo.setGubun("005");
			List<Map<String, String>> faultyDataList114Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList114Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			
			//공정 Trouble 조치 Loss
			equipPrcssFaultyAdmVo.setGubun("006");
			List<Map<String, String>> faultyDataList115Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList115Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList115Content	= equipFaultyService.faultyIntegratedListContent(equipPrcssFaultyAdmVo);
			
			//치수 불량 Loss
			equipPrcssFaultyAdmVo.setGubun("007");
			List<Map<String, String>> faultyDataList116Count	= equipFaultyService.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList116Kg		= equipFaultyService.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
			List<Map<String, String>> faultyDataList116Content	= equipFaultyService.faultyIntegratedListContent(equipPrcssFaultyAdmVo);
			
			JSONArray jsonArr = new JSONArray();
			
			//Cutting 수량
			for(int i = 0; i < faultyDataList052Count.size(); i++) {
				
				JSONObject jsonObj = new JSONObject();
				
				//기본 정보 값 담아주기
				jsonObj.put("faultyRegDate", faultyDataList114Kg.get(i).get( "ORD_DATE" ));
				jsonObj.put("dayNightNm", faultyDataList114Kg.get(i).get( "DAY_NIGHT_NM" ));
				jsonObj.put("equipNm", faultyDataList114Kg.get(i).get( "EQUIP_NM" ));
				
				if( faultyDataList052Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList052Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList052Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList052Kg.get(i).get( "ALNICU_MATRL_NM" ));
				} else if( faultyDataList053Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList053Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList053Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList053Kg.get(i).get( "ALNICU_MATRL_NM" ));
				} else if( faultyDataList054Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList054Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList054Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList054Kg.get(i).get( "ALNICU_MATRL_NM" ));
				} else if( faultyDataList055Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList055Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList055Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList055Kg.get(i).get( "ALNICU_MATRL_NM" ));					
				} else if( faultyDataList114Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList114Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList114Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList114Kg.get(i).get( "ALNICU_MATRL_NM" ));
				} else if( faultyDataList115Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList115Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList115Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList115Kg.get(i).get( "ALNICU_MATRL_NM" ));
				} else if( faultyDataList116Kg.get(i).get( "GOODS_NM" ) != null && !faultyDataList116Kg.get(i).get( "GOODS_NM" ).equals("") ) {
					jsonObj.put("goodsNm", faultyDataList116Kg.get(i).get( "GOODS_NM" ));
					jsonObj.put("alnicuMatrlNm", faultyDataList116Kg.get(i).get( "ALNICU_MATRL_NM" ));
				}
				//기본 정보 값 담아주기
				
				//오른쪽 데이터 값 담아주기 최대 40개까지
				for(int k=1; k<=40; k++) {
					String number = "";
					number = (String) (k < 10 ? "00"+k : k < 100 ? "0"+k : k) ;
					
					//Cutting 수량
					jsonObj.put("count"+k, faultyDataList052Count.get(i).get( number ));						
					jsonObj.put("kg"+k, faultyDataList052Kg.get(i).get( number ));
					jsonObj.put( "ea"+k, Float.toString((Float.parseFloat(String.valueOf(faultyDataList052Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList052Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					jsonObj.put("baseCd"+k, number );

					//Metal 교체 Loss
					jsonObj.put("count"+k+"_2", faultyDataList053Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_2", faultyDataList053Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_2", Float.toString((Float.parseFloat(String.valueOf(faultyDataList053Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList053Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					
					//Film 교체 Loss
					jsonObj.put("count"+k+"_3", faultyDataList054Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_3", faultyDataList054Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_3", Float.toString((Float.parseFloat(String.valueOf(faultyDataList054Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList054Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					
					//Teflon 교체 Loss
					jsonObj.put("count"+k+"_4", faultyDataList055Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_4", faultyDataList055Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_4", Float.toString((Float.parseFloat(String.valueOf(faultyDataList055Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList055Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					
					//Strip Loss
					jsonObj.put("count"+k+"_5", faultyDataList114Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_5", faultyDataList114Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_5", Float.toString((Float.parseFloat(String.valueOf(faultyDataList114Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList114Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					
					//공정 Trouble 조치 Loss
					jsonObj.put("count"+k+"_6", faultyDataList115Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_6", faultyDataList115Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_6", Float.toString((Float.parseFloat(String.valueOf(faultyDataList115Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList115Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					jsonObj.put("content"+k+"_6", faultyDataList115Content.get(i).get( number ).toString().equals("0") ? "-" : String.valueOf(faultyDataList115Content.get(i).get( number )) );
					
					//치수 불량 Loss
					jsonObj.put("count"+k+"_7", faultyDataList116Count.get(i).get( number ));						
					jsonObj.put("kg"+k+"_7", faultyDataList116Kg.get(i).get( number ));
					jsonObj.put( "ea"+k+"_7", Float.toString((Float.parseFloat(String.valueOf(faultyDataList116Kg.get(i).get( number ))) / Float.parseFloat(faultyDataList116Kg.get(i).get( "GRAVITY" ).toString())) * 1000) );
					jsonObj.put("content"+k+"_7", faultyDataList116Content.get(i).get( number ).toString().equals("0") ? "-" : String.valueOf(faultyDataList116Content.get(i).get( number )) );
				}
				
				jsonArr.add(jsonObj);
			}
			
			//logger.info("jsonArr -----------> " +jsonArr);
			
			jsonData.put("data", jsonArr );
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("모든 장애 목록 조회");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/wmsc0140", method = RequestMethod.GET)
	public String wmsc0140(Locale locale, Model model) throws Exception {
		logger.info("생산관리 설비별 투입 중량페이지");
		
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		

		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();	//설비코드
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList);
		
		return "wm/wmsc0140";
	}
	


}