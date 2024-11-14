package mes.web.wm;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;

import javax.inject.Inject;

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
import io.jsonwebtoken.io.IOException;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.wm.MonthProductionPlanVo;
import mes.domain.wm.TestDataVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.em.ManufacturerService;
import mes.service.po.WorkOrderService;
import mes.service.wm.MonthProductionPlanService;
import mes.service.wm.WorkOrderPlanService;
import mes.service.io.FileUploadService;
import mes.web.io.CustomerExcelReader;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class MonthProductionPlanController {

	@Value("${file.monthPlanPath}")
	private String filePath;
	
	@Inject
	private FileUploadService fileUploadService;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private WorkOrderPlanService workOrderPlanService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;
	@Inject
	private ManufacturerService manufacturerService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private MonthProductionPlanService monthProductionPlanService;
	
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MonthProductionPlanController.class);

	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc0210", method = RequestMethod.GET)
	public String wmsc0210GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc0210";
	}
		
	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc0220", method = RequestMethod.GET)
	public String wmsc0220GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc0220";
	}
	
	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc0230", method = RequestMethod.GET)
	public String wmsc0230GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeAdmList = goodsCodeAdmService.goosdCdGijonglist(goodsCodeAdmVo);
		model.addAttribute("goodsCodeList", goodsCodeAdmList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc0230";
	}
	
	//생산관리 - SLD 월별 FP 확정여부 체크
	@RequestMapping(value = "/wm/checkCompleteYn", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			monthProductionPlanVo =  monthProductionPlanService.checkCompleteYn(monthProductionPlanVo);
			
			if(monthProductionPlanVo != null) {
				if("001".equals(monthProductionPlanVo.getCompleteYn())) {
					jsonData.put("result", "error");
					jsonData.put("message", "이미 확정된 계획입니다.");					
				} else {
					jsonData.put("result", "ok");
				}
			} else {				
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			logger.info("SLD 월별 FP 확정여부 체크 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 잡체인지 저장여부
	@RequestMapping(value = "/wm/checkJobChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkJobChange(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("잡체인지 저장여부");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			int count =  monthProductionPlanService.checkJobChange(monthProductionPlanVo);
			
			if(count == 0) {
				jsonData.put("result", "error");
				jsonData.put("message", "먼저 비가동 구분에 잡체인지를 선택하고 비가동시간을 입력하여 저장후에 입력해주세요.");
			} else {				
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			logger.info("잡체인지 저장여부 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 확정여부 수정 (운영판)
	@RequestMapping(value = "/wm/updateCompleteYnModify", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCompleteYnModify(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 월별 FP 확정여부 수정");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.checkCompleteYn(monthProductionPlanVo);
			
			if(readVo == null) { //저장된게 없다면				
				jsonData.put("result", "error");
				jsonData.put("message", "먼저 저장을 해주세요!");
				
			} else { //저장된것이 있다면
				if("001".equals(monthProductionPlanVo.getCompleteYn())) {
					jsonData.put("result", "error");
					jsonData.put("message", "이미 확정된 계획입니다.");					
				} else {
					//확정 데이터 저장하는 부분
					monthProductionPlanVo.setUpdId(Utils.getUserId());
					monthProductionPlanVo.setRegId(Utils.getUserId());
					//List<MonthProductionPlanVo> dtlList = monthProductionPlanService.readDtl(monthProductionPlanVo);
					String[] planDateListSetter = new String[31];
					String planDateList = "";				
					String isNullPlanDataList = "";
					String dataSum = "";
					for(int i=1; i <= 31; i++) {
						
						planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
						planDateList += String.format("%02d", i);
						planDateList += "],";					
						planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
						
						isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						isNullPlanDataList += String.format("%02d", i);
						isNullPlanDataList += "],0) ";
						isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
						
						dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						dataSum += String.format("%02d", i);
						dataSum += "],0)+";
						
					}			
					
					monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
					monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
					monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));		

					monthProductionPlanService.createCplPlanCnt(monthProductionPlanVo); //계획수량
					
					monthProductionPlanService.updateCompleteYn(monthProductionPlanVo);		
					jsonData.put("result", "ok");
					
				}
			
			}

		} catch (Exception e) {
			logger.info("SLD 월별 FP 확정여부 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 확정여부 수정 (확정판)
	@RequestMapping(value = "/wm/updateCompleteYn", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 월별 FP 확정여부 수정");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.checkCompleteYn(monthProductionPlanVo);
			
			if(readVo == null) { //저장된게 없다면				
				jsonData.put("result", "error");
				jsonData.put("message", "먼저 저장을 해주세요!");
				
			} else { //저장된것이 있다면
				if("001".equals(readVo.getCompleteYn())) {
					jsonData.put("result", "error");
					jsonData.put("message", "이미 확정된 계획입니다.");					
				} else {
					//확정 데이터 저장하는 부분
					monthProductionPlanVo.setUpdId(Utils.getUserId());
					monthProductionPlanVo.setRegId(Utils.getUserId());
					//List<MonthProductionPlanVo> dtlList = monthProductionPlanService.readDtl(monthProductionPlanVo);
					String[] planDateListSetter = new String[31];
					String planDateList = "";				
					String isNullPlanDataList = "";
					String dataSum = "";
					for(int i=1; i <= 31; i++) {
						
						planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
						planDateList += String.format("%02d", i);
						planDateList += "],";					
						planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
						
						isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						isNullPlanDataList += String.format("%02d", i);
						isNullPlanDataList += "],0) ";
						isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
						
						dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						dataSum += String.format("%02d", i);
						dataSum += "],0)+";
						
					}			
					
					monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
					monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
					monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));				
					
					//monthProductionPlanService.createCplDualCapa(monthProductionPlanVo); //듀얼케파
					//monthProductionPlanService.createCplTecTime(monthProductionPlanVo); //택타임
					//monthProductionPlanService.createCplSecond(monthProductionPlanVo);	//second	
					monthProductionPlanService.createCplPlanCnt(monthProductionPlanVo); //계획수량
					
					

					
					monthProductionPlanService.updateCompleteYn(monthProductionPlanVo);		
					jsonData.put("result", "ok");
					
				}
			
			}

		} catch (Exception e) {
			logger.info("SLD 월별 FP 확정여부 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 잡체인지 모달
	@RequestMapping(value = "/wm/jobChangeModal", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jobChangeModal(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 잡체인지 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			List<MonthProductionPlanVo> readList = new ArrayList<MonthProductionPlanVo>();
			readList =  monthProductionPlanService.jobChangeModal(monthProductionPlanVo);
			
			jsonData.put("data", readList);

		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 잡체인지 모달 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 잡체인지 제품 모달
	@RequestMapping(value = "/wm/jobChangeGoodsModal", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jobChangeGoodsModal(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		
		logger.info(" SLD 월별 FP 잡체인지 제품 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			List<GoodsCodeAdmVo> readList = new ArrayList<GoodsCodeAdmVo>();
			goodsCodeAdmVo.setFactoryCode(factoryCode);
			readList =  goodsCodeAdmService.jobChangeGoodsModal(goodsCodeAdmVo);
			
			jsonData.put("data", readList);

		} catch (Exception e) {
			logger.info(" SLD 월별 FP 잡체인지 제품 모달 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}

	//생산관리/SLD 월별 FP - DataTable Data(List) 생성
	@RequestMapping(value = "/wm/readMonthPlanBodySLD", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLD(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		logger.info("SLD 월별 FP");
		Map<String, Object> jsonData = new HashMap<>();
		try {			
			
			List<MonthProductionPlanVo> outputList = new ArrayList<MonthProductionPlanVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for(int i=1; i <= 31; i++) {
				
				planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
			}
			monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
			List<Map<String, String>> list  = monthProductionPlanService.monthProductionPlanListTime(monthProductionPlanVo);
			List<Map<String, String>> list2  = monthProductionPlanService.monthProductionPlanListGubun(monthProductionPlanVo);
			int index = 0;
			for(Map<String, String> m : list) {
				
				MonthProductionPlanVo productionPlanVo2 = new MonthProductionPlanVo();
				productionPlanVo2.setEquipNm(m.get("EQUIP_NM").toString());		
				productionPlanVo2.setEquipCd(m.get("EQUIP_CD").toString());		
				productionPlanVo2.setGoodsNm(m.get("GOODS_NM"));	
				productionPlanVo2.setGoodsCd(m.get("GOODS_CD"));	
				productionPlanVo2.setQutyNm(m.get("QUTY_NM"));
				

				if(m.get("EQUIP_NM").toString() != null) {
					productionPlanVo2.setPlanDate1((String.valueOf(m.get(planDateListSetter[0]))));
					productionPlanVo2.setPlanDate2((String.valueOf(m.get(planDateListSetter[1]))));
					productionPlanVo2.setPlanDate3((String.valueOf(m.get(planDateListSetter[2]))));
					productionPlanVo2.setPlanDate4((String.valueOf(m.get(planDateListSetter[3]))));
					productionPlanVo2.setPlanDate5((String.valueOf(m.get(planDateListSetter[4]))));
					productionPlanVo2.setPlanDate6((String.valueOf(m.get(planDateListSetter[5]))));
					productionPlanVo2.setPlanDate7((String.valueOf(m.get(planDateListSetter[6]))));
					productionPlanVo2.setPlanDate8((String.valueOf(m.get(planDateListSetter[7]))));
					productionPlanVo2.setPlanDate9((String.valueOf(m.get(planDateListSetter[8]))));
					productionPlanVo2.setPlanDate10((String.valueOf(m.get(planDateListSetter[9]))));
					productionPlanVo2.setPlanDate11((String.valueOf(m.get(planDateListSetter[10]))));
					productionPlanVo2.setPlanDate12((String.valueOf(m.get(planDateListSetter[11]))));
					productionPlanVo2.setPlanDate13((String.valueOf(m.get(planDateListSetter[12]))));
					productionPlanVo2.setPlanDate14((String.valueOf(m.get(planDateListSetter[13]))));
					productionPlanVo2.setPlanDate15((String.valueOf(m.get(planDateListSetter[14]))));
					productionPlanVo2.setPlanDate16((String.valueOf(m.get(planDateListSetter[15]))));
					productionPlanVo2.setPlanDate17((String.valueOf(m.get(planDateListSetter[16]))));
					productionPlanVo2.setPlanDate18((String.valueOf(m.get(planDateListSetter[17]))));
					productionPlanVo2.setPlanDate19((String.valueOf(m.get(planDateListSetter[18]))));
					productionPlanVo2.setPlanDate20((String.valueOf(m.get(planDateListSetter[19]))));
					productionPlanVo2.setPlanDate21((String.valueOf(m.get(planDateListSetter[20]))));
					productionPlanVo2.setPlanDate22((String.valueOf(m.get(planDateListSetter[21]))));
					productionPlanVo2.setPlanDate23((String.valueOf(m.get(planDateListSetter[22]))));
					productionPlanVo2.setPlanDate24((String.valueOf(m.get(planDateListSetter[23]))));
					productionPlanVo2.setPlanDate25((String.valueOf(m.get(planDateListSetter[24]))));
					productionPlanVo2.setPlanDate26((String.valueOf(m.get(planDateListSetter[25]))));
					productionPlanVo2.setPlanDate27((String.valueOf(m.get(planDateListSetter[26]))));
					productionPlanVo2.setPlanDate28((String.valueOf(m.get(planDateListSetter[27]))));
					productionPlanVo2.setPlanDate29((String.valueOf(m.get(planDateListSetter[28]))));
					productionPlanVo2.setPlanDate30((String.valueOf(m.get(planDateListSetter[29]))));
					productionPlanVo2.setPlanDate31((String.valueOf(m.get(planDateListSetter[30]))));
					
					productionPlanVo2.setGubun1((String.valueOf(list2.get(index).get(planDateListSetter[0]))));
					productionPlanVo2.setGubun2((String.valueOf(list2.get(index).get(planDateListSetter[1]))));
					productionPlanVo2.setGubun3((String.valueOf(list2.get(index).get(planDateListSetter[2]))));
					productionPlanVo2.setGubun4((String.valueOf(list2.get(index).get(planDateListSetter[3]))));
					productionPlanVo2.setGubun5((String.valueOf(list2.get(index).get(planDateListSetter[4]))));
					productionPlanVo2.setGubun6((String.valueOf(list2.get(index).get(planDateListSetter[5]))));
					productionPlanVo2.setGubun7((String.valueOf(list2.get(index).get(planDateListSetter[6]))));
					productionPlanVo2.setGubun8((String.valueOf(list2.get(index).get(planDateListSetter[7]))));
					productionPlanVo2.setGubun9((String.valueOf(list2.get(index).get(planDateListSetter[8]))));
					productionPlanVo2.setGubun10((String.valueOf(list2.get(index).get(planDateListSetter[9]))));
					productionPlanVo2.setGubun11((String.valueOf(list2.get(index).get(planDateListSetter[10]))));
					productionPlanVo2.setGubun12((String.valueOf(list2.get(index).get(planDateListSetter[11]))));
					productionPlanVo2.setGubun13((String.valueOf(list2.get(index).get(planDateListSetter[12]))));
					productionPlanVo2.setGubun14((String.valueOf(list2.get(index).get(planDateListSetter[13]))));
					productionPlanVo2.setGubun15((String.valueOf(list2.get(index).get(planDateListSetter[14]))));
					productionPlanVo2.setGubun16((String.valueOf(list2.get(index).get(planDateListSetter[15]))));
					productionPlanVo2.setGubun17((String.valueOf(list2.get(index).get(planDateListSetter[16]))));
					productionPlanVo2.setGubun18((String.valueOf(list2.get(index).get(planDateListSetter[17]))));
					productionPlanVo2.setGubun19((String.valueOf(list2.get(index).get(planDateListSetter[18]))));
					productionPlanVo2.setGubun20((String.valueOf(list2.get(index).get(planDateListSetter[19]))));
					productionPlanVo2.setGubun21((String.valueOf(list2.get(index).get(planDateListSetter[20]))));
					productionPlanVo2.setGubun22((String.valueOf(list2.get(index).get(planDateListSetter[21]))));
					productionPlanVo2.setGubun23((String.valueOf(list2.get(index).get(planDateListSetter[22]))));
					productionPlanVo2.setGubun24((String.valueOf(list2.get(index).get(planDateListSetter[23]))));
					productionPlanVo2.setGubun25((String.valueOf(list2.get(index).get(planDateListSetter[24]))));
					productionPlanVo2.setGubun26((String.valueOf(list2.get(index).get(planDateListSetter[25]))));
					productionPlanVo2.setGubun27((String.valueOf(list2.get(index).get(planDateListSetter[26]))));
					productionPlanVo2.setGubun28((String.valueOf(list2.get(index).get(planDateListSetter[27]))));
					productionPlanVo2.setGubun29((String.valueOf(list2.get(index).get(planDateListSetter[28]))));
					productionPlanVo2.setGubun30((String.valueOf(list2.get(index).get(planDateListSetter[29]))));
					productionPlanVo2.setGubun31((String.valueOf(list2.get(index).get(planDateListSetter[30]))));
				} else {
					productionPlanVo2.setPlanDate1("0");
					productionPlanVo2.setPlanDate2("0");
					productionPlanVo2.setPlanDate3("0");
					productionPlanVo2.setPlanDate4("0");
					productionPlanVo2.setPlanDate5("0");
					productionPlanVo2.setPlanDate6("0");
					productionPlanVo2.setPlanDate7("0");
					productionPlanVo2.setPlanDate8("0");
					productionPlanVo2.setPlanDate9("0");
					productionPlanVo2.setPlanDate10("0");
					productionPlanVo2.setPlanDate11("0");
					productionPlanVo2.setPlanDate12("0");
					productionPlanVo2.setPlanDate13("0");
					productionPlanVo2.setPlanDate14("0");
					productionPlanVo2.setPlanDate15("0");
					productionPlanVo2.setPlanDate16("0");
					productionPlanVo2.setPlanDate17("0");
					productionPlanVo2.setPlanDate18("0");
					productionPlanVo2.setPlanDate19("0");
					productionPlanVo2.setPlanDate20("0");
					productionPlanVo2.setPlanDate21("0");
					productionPlanVo2.setPlanDate22("0");
					productionPlanVo2.setPlanDate23("0");
					productionPlanVo2.setPlanDate24("0");
					productionPlanVo2.setPlanDate25("0");
					productionPlanVo2.setPlanDate26("0");
					productionPlanVo2.setPlanDate27("0");
					productionPlanVo2.setPlanDate28("0");
					productionPlanVo2.setPlanDate29("0");
					productionPlanVo2.setPlanDate30("0");
					productionPlanVo2.setPlanDate31("0");
					
					productionPlanVo2.setGubun1("0");
					productionPlanVo2.setGubun2("0");
					productionPlanVo2.setGubun3("0");
					productionPlanVo2.setGubun4("0");
					productionPlanVo2.setGubun5("0");
					productionPlanVo2.setGubun6("0");
					productionPlanVo2.setGubun7("0");
					productionPlanVo2.setGubun8("0");
					productionPlanVo2.setGubun9("0");
					productionPlanVo2.setGubun10("0");
					productionPlanVo2.setGubun11("0");
					productionPlanVo2.setGubun12("0");
					productionPlanVo2.setGubun13("0");
					productionPlanVo2.setGubun14("0");
					productionPlanVo2.setGubun15("0");
					productionPlanVo2.setGubun16("0");
					productionPlanVo2.setGubun17("0");
					productionPlanVo2.setGubun18("0");
					productionPlanVo2.setGubun19("0");
					productionPlanVo2.setGubun20("0");
					productionPlanVo2.setGubun21("0");
					productionPlanVo2.setGubun22("0");
					productionPlanVo2.setGubun23("0");
					productionPlanVo2.setGubun24("0");
					productionPlanVo2.setGubun25("0");
					productionPlanVo2.setGubun26("0");
					productionPlanVo2.setGubun27("0");
					productionPlanVo2.setGubun28("0");
					productionPlanVo2.setGubun29("0");
					productionPlanVo2.setGubun30("0");
					productionPlanVo2.setGubun31("0");
				}
				
				
				outputList.add(productionPlanVo2);	
				index++;
				
			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok"); 
			
		} catch (Exception e) {
			logger.info("SLD 월별 FP 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//생산관리/SLD 월별 FP - DataTable Data(List) 생성
	@RequestMapping(value = "/wm/readMonthPlanBodySLDModify", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLDModify(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		logger.info("SLD 월별 FP");
		Map<String, Object> jsonData = new HashMap<>();
		try {			
			
			List<MonthProductionPlanVo> outputList = new ArrayList<MonthProductionPlanVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for(int i=1; i <= 31; i++) {
				
				planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
			}
			monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
		
			
			List<MonthProductionPlanVo> readList  = monthProductionPlanService.readDtl(monthProductionPlanVo);
			if(readList.size() == 0) {
				monthProductionPlanVo.setCplGubun("001");
			}			
			
			List<Map<String, String>> list  = monthProductionPlanService.monthProductionPlanListTime(monthProductionPlanVo);
			List<Map<String, String>> list2  = monthProductionPlanService.monthProductionPlanListGubun(monthProductionPlanVo);
			int index = 0;
			for(Map<String, String> m : list) {
				
				MonthProductionPlanVo productionPlanVo2 = new MonthProductionPlanVo();
				productionPlanVo2.setEquipNm(m.get("EQUIP_NM").toString());		
				productionPlanVo2.setEquipCd(m.get("EQUIP_CD").toString());		
				productionPlanVo2.setGoodsNm(m.get("GOODS_NM"));	
				productionPlanVo2.setGoodsCd(m.get("GOODS_CD"));	
				productionPlanVo2.setQutyNm(m.get("QUTY_NM"));
				

				if(m.get("EQUIP_NM").toString() != null) {
					productionPlanVo2.setPlanDate1((String.valueOf(m.get(planDateListSetter[0]))));
					productionPlanVo2.setPlanDate2((String.valueOf(m.get(planDateListSetter[1]))));
					productionPlanVo2.setPlanDate3((String.valueOf(m.get(planDateListSetter[2]))));
					productionPlanVo2.setPlanDate4((String.valueOf(m.get(planDateListSetter[3]))));
					productionPlanVo2.setPlanDate5((String.valueOf(m.get(planDateListSetter[4]))));
					productionPlanVo2.setPlanDate6((String.valueOf(m.get(planDateListSetter[5]))));
					productionPlanVo2.setPlanDate7((String.valueOf(m.get(planDateListSetter[6]))));
					productionPlanVo2.setPlanDate8((String.valueOf(m.get(planDateListSetter[7]))));
					productionPlanVo2.setPlanDate9((String.valueOf(m.get(planDateListSetter[8]))));
					productionPlanVo2.setPlanDate10((String.valueOf(m.get(planDateListSetter[9]))));
					productionPlanVo2.setPlanDate11((String.valueOf(m.get(planDateListSetter[10]))));
					productionPlanVo2.setPlanDate12((String.valueOf(m.get(planDateListSetter[11]))));
					productionPlanVo2.setPlanDate13((String.valueOf(m.get(planDateListSetter[12]))));
					productionPlanVo2.setPlanDate14((String.valueOf(m.get(planDateListSetter[13]))));
					productionPlanVo2.setPlanDate15((String.valueOf(m.get(planDateListSetter[14]))));
					productionPlanVo2.setPlanDate16((String.valueOf(m.get(planDateListSetter[15]))));
					productionPlanVo2.setPlanDate17((String.valueOf(m.get(planDateListSetter[16]))));
					productionPlanVo2.setPlanDate18((String.valueOf(m.get(planDateListSetter[17]))));
					productionPlanVo2.setPlanDate19((String.valueOf(m.get(planDateListSetter[18]))));
					productionPlanVo2.setPlanDate20((String.valueOf(m.get(planDateListSetter[19]))));
					productionPlanVo2.setPlanDate21((String.valueOf(m.get(planDateListSetter[20]))));
					productionPlanVo2.setPlanDate22((String.valueOf(m.get(planDateListSetter[21]))));
					productionPlanVo2.setPlanDate23((String.valueOf(m.get(planDateListSetter[22]))));
					productionPlanVo2.setPlanDate24((String.valueOf(m.get(planDateListSetter[23]))));
					productionPlanVo2.setPlanDate25((String.valueOf(m.get(planDateListSetter[24]))));
					productionPlanVo2.setPlanDate26((String.valueOf(m.get(planDateListSetter[25]))));
					productionPlanVo2.setPlanDate27((String.valueOf(m.get(planDateListSetter[26]))));
					productionPlanVo2.setPlanDate28((String.valueOf(m.get(planDateListSetter[27]))));
					productionPlanVo2.setPlanDate29((String.valueOf(m.get(planDateListSetter[28]))));
					productionPlanVo2.setPlanDate30((String.valueOf(m.get(planDateListSetter[29]))));
					productionPlanVo2.setPlanDate31((String.valueOf(m.get(planDateListSetter[30]))));
					
					productionPlanVo2.setGubun1((String.valueOf(list2.get(index).get(planDateListSetter[0]))));
					productionPlanVo2.setGubun2((String.valueOf(list2.get(index).get(planDateListSetter[1]))));
					productionPlanVo2.setGubun3((String.valueOf(list2.get(index).get(planDateListSetter[2]))));
					productionPlanVo2.setGubun4((String.valueOf(list2.get(index).get(planDateListSetter[3]))));
					productionPlanVo2.setGubun5((String.valueOf(list2.get(index).get(planDateListSetter[4]))));
					productionPlanVo2.setGubun6((String.valueOf(list2.get(index).get(planDateListSetter[5]))));
					productionPlanVo2.setGubun7((String.valueOf(list2.get(index).get(planDateListSetter[6]))));
					productionPlanVo2.setGubun8((String.valueOf(list2.get(index).get(planDateListSetter[7]))));
					productionPlanVo2.setGubun9((String.valueOf(list2.get(index).get(planDateListSetter[8]))));
					productionPlanVo2.setGubun10((String.valueOf(list2.get(index).get(planDateListSetter[9]))));
					productionPlanVo2.setGubun11((String.valueOf(list2.get(index).get(planDateListSetter[10]))));
					productionPlanVo2.setGubun12((String.valueOf(list2.get(index).get(planDateListSetter[11]))));
					productionPlanVo2.setGubun13((String.valueOf(list2.get(index).get(planDateListSetter[12]))));
					productionPlanVo2.setGubun14((String.valueOf(list2.get(index).get(planDateListSetter[13]))));
					productionPlanVo2.setGubun15((String.valueOf(list2.get(index).get(planDateListSetter[14]))));
					productionPlanVo2.setGubun16((String.valueOf(list2.get(index).get(planDateListSetter[15]))));
					productionPlanVo2.setGubun17((String.valueOf(list2.get(index).get(planDateListSetter[16]))));
					productionPlanVo2.setGubun18((String.valueOf(list2.get(index).get(planDateListSetter[17]))));
					productionPlanVo2.setGubun19((String.valueOf(list2.get(index).get(planDateListSetter[18]))));
					productionPlanVo2.setGubun20((String.valueOf(list2.get(index).get(planDateListSetter[19]))));
					productionPlanVo2.setGubun21((String.valueOf(list2.get(index).get(planDateListSetter[20]))));
					productionPlanVo2.setGubun22((String.valueOf(list2.get(index).get(planDateListSetter[21]))));
					productionPlanVo2.setGubun23((String.valueOf(list2.get(index).get(planDateListSetter[22]))));
					productionPlanVo2.setGubun24((String.valueOf(list2.get(index).get(planDateListSetter[23]))));
					productionPlanVo2.setGubun25((String.valueOf(list2.get(index).get(planDateListSetter[24]))));
					productionPlanVo2.setGubun26((String.valueOf(list2.get(index).get(planDateListSetter[25]))));
					productionPlanVo2.setGubun27((String.valueOf(list2.get(index).get(planDateListSetter[26]))));
					productionPlanVo2.setGubun28((String.valueOf(list2.get(index).get(planDateListSetter[27]))));
					productionPlanVo2.setGubun29((String.valueOf(list2.get(index).get(planDateListSetter[28]))));
					productionPlanVo2.setGubun30((String.valueOf(list2.get(index).get(planDateListSetter[29]))));
					productionPlanVo2.setGubun31((String.valueOf(list2.get(index).get(planDateListSetter[30]))));
				} else {
					productionPlanVo2.setPlanDate1("0");
					productionPlanVo2.setPlanDate2("0");
					productionPlanVo2.setPlanDate3("0");
					productionPlanVo2.setPlanDate4("0");
					productionPlanVo2.setPlanDate5("0");
					productionPlanVo2.setPlanDate6("0");
					productionPlanVo2.setPlanDate7("0");
					productionPlanVo2.setPlanDate8("0");
					productionPlanVo2.setPlanDate9("0");
					productionPlanVo2.setPlanDate10("0");
					productionPlanVo2.setPlanDate11("0");
					productionPlanVo2.setPlanDate12("0");
					productionPlanVo2.setPlanDate13("0");
					productionPlanVo2.setPlanDate14("0");
					productionPlanVo2.setPlanDate15("0");
					productionPlanVo2.setPlanDate16("0");
					productionPlanVo2.setPlanDate17("0");
					productionPlanVo2.setPlanDate18("0");
					productionPlanVo2.setPlanDate19("0");
					productionPlanVo2.setPlanDate20("0");
					productionPlanVo2.setPlanDate21("0");
					productionPlanVo2.setPlanDate22("0");
					productionPlanVo2.setPlanDate23("0");
					productionPlanVo2.setPlanDate24("0");
					productionPlanVo2.setPlanDate25("0");
					productionPlanVo2.setPlanDate26("0");
					productionPlanVo2.setPlanDate27("0");
					productionPlanVo2.setPlanDate28("0");
					productionPlanVo2.setPlanDate29("0");
					productionPlanVo2.setPlanDate30("0");
					productionPlanVo2.setPlanDate31("0");
					
					productionPlanVo2.setGubun1("0");
					productionPlanVo2.setGubun2("0");
					productionPlanVo2.setGubun3("0");
					productionPlanVo2.setGubun4("0");
					productionPlanVo2.setGubun5("0");
					productionPlanVo2.setGubun6("0");
					productionPlanVo2.setGubun7("0");
					productionPlanVo2.setGubun8("0");
					productionPlanVo2.setGubun9("0");
					productionPlanVo2.setGubun10("0");
					productionPlanVo2.setGubun11("0");
					productionPlanVo2.setGubun12("0");
					productionPlanVo2.setGubun13("0");
					productionPlanVo2.setGubun14("0");
					productionPlanVo2.setGubun15("0");
					productionPlanVo2.setGubun16("0");
					productionPlanVo2.setGubun17("0");
					productionPlanVo2.setGubun18("0");
					productionPlanVo2.setGubun19("0");
					productionPlanVo2.setGubun20("0");
					productionPlanVo2.setGubun21("0");
					productionPlanVo2.setGubun22("0");
					productionPlanVo2.setGubun23("0");
					productionPlanVo2.setGubun24("0");
					productionPlanVo2.setGubun25("0");
					productionPlanVo2.setGubun26("0");
					productionPlanVo2.setGubun27("0");
					productionPlanVo2.setGubun28("0");
					productionPlanVo2.setGubun29("0");
					productionPlanVo2.setGubun30("0");
					productionPlanVo2.setGubun31("0");
				}
				
				
				outputList.add(productionPlanVo2);	
				index++;
				
			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok"); 
			
		} catch (Exception e) {
			logger.info("SLD 월별 FP 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//생산관리-생산계획 등록&수정 처리
	@RequestMapping(value = "/wm/insertMonthProductionPlan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthProductionPlan(@RequestBody List<Map<String, Object>> dataList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리-생산계획 등록&수정 처리 " + dataList);
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		MonthProductionPlanVo readVo = new MonthProductionPlanVo();		
		monthProductionPlanVo.setFpDate(dataList.get(0).get("fpDate").toString().substring(0,6));
		monthProductionPlanVo.setCplGubun(dataList.get(0).get("cplGubun").toString());		
		
		try {
			readVo.setFpDate(dataList.get(0).get("fpDate").toString().substring(0,6)); 
			readVo.setCplGubun("001");          		
			readVo =  monthProductionPlanService.readYeild(readVo);
			
			if(readVo != null) {				
			
				readVo.setJobChangeDate("ok");
				readVo.setCplGubun(dataList.get(0).get("cplGubun").toString());
				
				List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
				List<MonthProductionPlanVo> listDtl = new ArrayList<MonthProductionPlanVo>();
	
				//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
				///systemCommonCodeVo.setBaseGroupCd("113"); // FP수율
				//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
				
				
				List<MonthProductionPlanVo> jobChangeList = monthProductionPlanService.readDtl(readVo); //삭제전 잡체인지 데이터 가져오기
				String checkJobChange = "002";
				monthProductionPlanService.delete(monthProductionPlanVo);
				monthProductionPlanService.deleteGoods(monthProductionPlanVo);
				monthProductionPlanService.deleteDtl(monthProductionPlanVo);
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				for (Map<String, Object> m : dataList) {
					
					list = new ArrayList<MonthProductionPlanVo>();
					listDtl = new ArrayList<MonthProductionPlanVo>();
					GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
					//monthProductionPlanVo = new MonthProductionPlanVo();
					String cplGubun = m.get("cplGubun").toString();
					String equipCd = m.get("equipCd").toString();
					EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
					equipCodeAdmVo.setEquipCd(equipCd);
					List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
					String planDate = m.get("fpDate").toString();				
					String completeYn = m.get("completeYn").toString();
					String goodsCd = m.get("goodsCd").toString();
					//String opTime = m.get("opTime").toString();
					//String tecTime = m.get("tecTime").toString();
					//String planCnt = m.get("planCnt").toString();
					goodsCodeAdmVo.setGoodsCd(goodsCd);;
					goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
					String tecTime = goodsCodeAdmVo.getTecTime();	
					String[] count = new String[31];	
					String[] npTime = new String[31];	
					
					
				
					count[0]= (m.get("count1").toString());
					count[1]= (m.get("count2").toString());
					count[2]= (m.get("count3").toString());
					count[3]= (m.get("count4").toString());
					count[4]= (m.get("count5").toString());
					count[5]= (m.get("count6").toString());
					count[6]= (m.get("count7").toString());
					count[7]= (m.get("count8").toString());
					count[8]= (m.get("count9").toString());
					count[9] = (m.get("count10").toString());
					count[10] = (m.get("count11").toString());
					count[11] = (m.get("count12").toString());
					count[12] = (m.get("count13").toString());
					count[13] = (m.get("count14").toString());
					count[14] = (m.get("count15").toString());
					count[15] = (m.get("count16").toString());
					count[16] = (m.get("count17").toString());
					count[17] = (m.get("count18").toString());
					count[18] = (m.get("count19").toString());
					count[19] = (m.get("count20").toString());
					count[20] = (m.get("count21").toString());
					count[21] = (m.get("count22").toString());
					count[22] = (m.get("count23").toString());
					count[23] = (m.get("count24").toString());
					count[24] = (m.get("count25").toString());
					count[25] = (m.get("count26").toString());
					count[26] = (m.get("count27").toString());
					count[27] = (m.get("count28").toString());
					count[28] = (m.get("count29").toString());
					count[29] = (m.get("count30").toString());
					count[30] = (m.get("count31").toString());			
					
					npTime[0]= (m.get("npTime1").toString());
					npTime[1]= (m.get("npTime2").toString());
					npTime[2]= (m.get("npTime3").toString());
					npTime[3]= (m.get("npTime4").toString());
					npTime[4]= (m.get("npTime5").toString());
					npTime[5]= (m.get("npTime6").toString());
					npTime[6]= (m.get("npTime7").toString());
					npTime[7]= (m.get("npTime8").toString());
					npTime[8]= (m.get("npTime9").toString());
					npTime[9] = (m.get("npTime10").toString());
					npTime[10] = (m.get("npTime11").toString());
					npTime[11] = (m.get("npTime12").toString());
					npTime[12] = (m.get("npTime13").toString());
					npTime[13] = (m.get("npTime14").toString());
					npTime[14] = (m.get("npTime15").toString());
					npTime[15] = (m.get("npTime16").toString());
					npTime[16] = (m.get("npTime17").toString());
					npTime[17] = (m.get("npTime18").toString());
					npTime[18] = (m.get("npTime19").toString());
					npTime[19] = (m.get("npTime20").toString());
					npTime[20] = (m.get("npTime21").toString());
					npTime[21] = (m.get("npTime22").toString());
					npTime[22] = (m.get("npTime23").toString());
					npTime[23] = (m.get("npTime24").toString());
					npTime[24] = (m.get("npTime25").toString());
					npTime[25] = (m.get("npTime26").toString());
					npTime[26] = (m.get("npTime27").toString());
					npTime[27] = (m.get("npTime28").toString());
					npTime[28] = (m.get("npTime29").toString());
					npTime[29] = (m.get("npTime30").toString());
					npTime[30] = (m.get("npTime31").toString());	
									
					
					for(int i = 0; i < 31; i++) {
						MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
						monthProductionPlanVo2.setEquipCd(equipCd);			
						monthProductionPlanVo2.setGoodsCd(goodsCd);			
						monthProductionPlanVo2.setCplGubun(cplGubun);
						monthProductionPlanVo2.setCompleteYn(completeYn);
	
						monthProductionPlanVo2.setRegId(Utils.getUserId());					
						monthProductionPlanVo2.setFpDate(planDate.substring(0,6) + String.format("%02d", i+1));	
						monthProductionPlanVo2.setNpGubun(count[i]);	
						if(count[i].equals("999")) {
							checkJobChange = "001";
						}
						monthProductionPlanVo2.setNpTime(npTime[i]);	
						
						double opTime = 24 - Double.parseDouble(npTime[i]);
						
						monthProductionPlanVo2.setOpTime(Double.toString(opTime));
						
						//텍타임은 제품관리에서 가져와야함.
						monthProductionPlanVo2.setTecTime(tecTime);				
						
						//monthProductionPlanVo2.setPlanCnt(Double.toString((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );			
						monthProductionPlanVo2.setPlanCnt(Double.toString(Math.round((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime))) );
						monthProductionPlanVo2.setRegId(Utils.getUserId());
			
						listDtl.add(monthProductionPlanVo2);
						if(!"0".equals(count[i])) {
							list.add(monthProductionPlanVo2);			
							
						}
						//monthProductionPlanService.createDtl(monthProductionPlanVo2); //제품별 가동시간
						
						
					}			
					if(list.size() != 0) {
						monthProductionPlanService.create(list); //설비별 비가동, 가동시간
					}
					
					if(listDtl.size() != 0) {
						monthProductionPlanService.createDtl(listDtl); //설비별 비가동, 가동시간
						monthProductionPlanService.createGoods(listDtl);
					}
				}
				
				
				
				//운영판일 경우 지금 FP용 데이터 생성
				if("002".equals(monthProductionPlanVo.getCplGubun())) {
					
					monthProductionPlanVo.setRegId(Utils.getUserId());				
					String[] planDateListSetter = new String[31];
					String planDateList = "";				
					String isNullPlanDataList = "";
					String dataSum = "";
					for(int i=1; i <= 31; i++) {
						
						planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
						planDateList += String.format("%02d", i);
						planDateList += "],";					
						planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
						
						isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						isNullPlanDataList += String.format("%02d", i);
						isNullPlanDataList += "],0) ";
						isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
						
						dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
						dataSum += String.format("%02d", i);
						dataSum += "],0)+";
						
					}			
					
					monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
					monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
					monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
					
					monthProductionPlanService.deleteCplPlan(monthProductionPlanVo); // 확정수량 운영판		
					monthProductionPlanService.createCplDualCapa(monthProductionPlanVo); //듀얼케파
					monthProductionPlanService.createCplTecTime(monthProductionPlanVo); //택타임
					monthProductionPlanService.createCplSecond(monthProductionPlanVo);	//second
					monthProductionPlanService.createCplPlanCntModify(monthProductionPlanVo); // 확정수량 운영판
				}
				
				if(jobChangeList.size() != 0 && jobChangeList != null) {
					insertMonthProductionPlanJobChangeFunc(jobChangeList);
				}
				
				jsonData.put("message", "저장되었습니다.");
				jsonData.put("checkJobChange", checkJobChange);			
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "수율을 먼저 입력해주세요.");	
				jsonData.put("result", "error");
			}
	
		} catch (Exception e) {
			logger.info("생산관리-생산계획 등록&수정 처리");
			
			//해당planDate 모두 삭제? 등록일경우 모두삭제하면되는데 수정일경우엔?
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	//생산관리-생산계획 잡체인지 등록
	@RequestMapping(value = "/wm/insertMonthProductionPlanJobChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthProductionPlanJobChange(@RequestBody List<Map<String, Object>> dataList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리-생산계획 잡체인지 등록 " + dataList);
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		
		monthProductionPlanVo.setEquipCd(dataList.get(0).get("equipCd").toString());
		monthProductionPlanVo.setChooseDateFrom(dataList.get(0).get("jobChangeDate").toString());
		monthProductionPlanVo.setChooseDateTo(dataList.get(0).get("jobChangeDate").toString());
		monthProductionPlanVo.setCplGubun(dataList.get(0).get("cplGubun").toString());
			
		String planDate = dataList.get(0).get("jobChangeDate").toString();	
		
		String fpDate = dataList.get(0).get("fpDate").toString().substring(0,6);
		
		List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
		MonthProductionPlanVo readVo = new MonthProductionPlanVo();
		readVo.setFpDate(fpDate);
		readVo.setCplGubun("001");
		readVo =  monthProductionPlanService.readYeild(readVo);
		
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		///systemCommonCodeVo.setBaseGroupCd("113"); // FP수율
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		try {
			//삭제부			
						
			String goodsCd ="";
			monthProductionPlanService.deleteDtl(monthProductionPlanVo); //잡체인지 일자에 있는 데이터 삭제
			
			for (Map<String, Object> m : dataList) {				
				
				goodsCd = m.get("goodsCd").toString();
				String opTime = m.get("opTime").toString();
						
				String cplGubun = m.get("cplGubun").toString();
				String equipCd = m.get("equipCd").toString();					
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
				//String completeYn = m.get("completeYn").toString();
				String jobChangeDate = m.get("jobChangeDate").toString();
				String jobChangeStartDate = m.get("jobChangeStartDate").toString();
				String jobChangeEndDate = m.get("jobChangeEndDate").toString();
				GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
				goodsCodeAdmVo.setGoodsCd(goodsCd);;
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
				String tecTime = goodsCodeAdmVo.getTecTime();	
				
				//등록부
				MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
				monthProductionPlanVo2.setEquipCd(equipCd);			
				monthProductionPlanVo2.setGoodsCd(goodsCd);						
				monthProductionPlanVo2.setCplGubun(cplGubun);
				//monthProductionPlanVo2.setCompleteYn(completeYn);
				monthProductionPlanVo2.setJobChangeDate(jobChangeDate);
				monthProductionPlanVo2.setJobChangeStartDate(jobChangeStartDate);
				monthProductionPlanVo2.setJobChangeEndDate(jobChangeEndDate);		
				monthProductionPlanVo2.setTecTime(tecTime);
				monthProductionPlanVo2.setCplGubun(cplGubun);
				
				monthProductionPlanVo2.setFpDate(planDate);	
				monthProductionPlanVo2.setOpTime(opTime);				
				
				monthProductionPlanVo2.setRegId(Utils.getUserId());					
				monthProductionPlanVo2.setUpdId(Utils.getUserId());					
			
				//double planCnt = (Double.parseDouble(opTime) * 60 * 60) / Double.parseDouble(tecTime);
				//monthProductionPlanVo2.setPlanCnt(Double.toString((((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );
				monthProductionPlanVo2.setPlanCnt(Double.toString(Math.round( (((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime))) );
				list.add(monthProductionPlanVo2);				
			
				//텍타임은 제품관리에서 가져와야함.	
				
				monthProductionPlanService.jobChangeUpdate(monthProductionPlanVo2);
			}
			
			monthProductionPlanService.createDtl(list);	
			
			//운영판일 경우 지금 FP용 데이터 생성
			if("002".equals(monthProductionPlanVo.getCplGubun())) {
				monthProductionPlanVo.setFpDate(fpDate);
				monthProductionPlanVo.setRegId(Utils.getUserId());				
				String[] planDateListSetter = new String[31];
				String planDateList = "";				
				String isNullPlanDataList = "";
				String dataSum = "";
				for(int i=1; i <= 31; i++) {
					
					planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
					planDateList += String.format("%02d", i);
					planDateList += "],";					
					planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
					
					isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					isNullPlanDataList += String.format("%02d", i);
					isNullPlanDataList += "],0) ";
					isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
					
					dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					dataSum += String.format("%02d", i);
					dataSum += "],0)+";
					
				}			
				
				monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
				monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
				monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));	
							
				monthProductionPlanVo.setEquipCd("");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				monthProductionPlanService.createCplDualCapa(monthProductionPlanVo); //듀얼케파
				monthProductionPlanService.createCplTecTime(monthProductionPlanVo); //택타임
				monthProductionPlanService.createCplSecond(monthProductionPlanVo);	//second
				monthProductionPlanService.createCplPlanCntModify(monthProductionPlanVo); // 확정수량 운영판
				
				for(MonthProductionPlanVo m : list) {
					System.out.println("잡체인지 데이터~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + m);									
					m.setGubun("004");				
					m.setFpDate(fpDate);
					m.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
					m.setDataSum(dataSum.substring(0,dataSum.length()-1));
					m.setDayList(planDateList.substring(0,planDateList.length()-1));	
					List<MonthProductionPlanVo> readList = monthProductionPlanService.readFpTotalComplete(m);					
					
					if(readList.size() == 0) { //잡체인지 등록한것이 확정판에 없었을 경우							
						monthProductionPlanService.createFpTotalList(m);
						//monthProductionPlanService.createCplPlanCnt(m); //계획수량
					}
				}

			}
			


			jsonData.put("message", "저장되었습니다.");
			jsonData.put("result", "ok");
			
	
		} catch (Exception e) {
			logger.info("생산관리-생산계획 잡체인지 등록 오류");
			
			//해당planDate 모두 삭제? 등록일경우 모두삭제하면되는데 수정일경우엔?
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//잡체인지 데이터 남기기
	public void insertMonthProductionPlanJobChangeFunc(List<MonthProductionPlanVo> dataList) throws Exception {
		
		logger.info("잡체인지 데이터 남기기 " + dataList);
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		
		monthProductionPlanVo.setEquipCd(dataList.get(0).getEquipCd().toString());
		monthProductionPlanVo.setChooseDateFrom(dataList.get(0).getJobChangeDate().toString());
		monthProductionPlanVo.setChooseDateTo(dataList.get(0).getJobChangeDate().toString());
		monthProductionPlanVo.setCplGubun(dataList.get(0).getCplGubun().toString());
			
		String planDate = dataList.get(0).getJobChangeDate().toString();			
		String fpDate = dataList.get(0).getFpDate().toString().substring(0,6);
		
		List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
		MonthProductionPlanVo readVo = new MonthProductionPlanVo();
		readVo.setFpDate(fpDate);
		readVo.setCplGubun("001");
		readVo =  monthProductionPlanService.readYeild(readVo);

		try {
			//삭제부			
						
			String goodsCd ="";			
			
			for (MonthProductionPlanVo m : dataList) {				
				
				goodsCd = m.getGoodsCd().toString();
				String opTime = m.getOpTime().toString();						
				String cplGubun = m.getCplGubun().toString();
				String equipCd = m.getEquipCd().toString();
				String jobChangeDate = m.getJobChangeDate().toString();
				String jobChangeStartDate = m.getJobChangeStartDate().toString();
				String jobChangeEndDate = m.getJobChangeEndDate().toString();
				GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
				goodsCodeAdmVo.setGoodsCd(goodsCd);;
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
				String tecTime = goodsCodeAdmVo.getTecTime();	
				
				//등록부
				MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
				monthProductionPlanVo2.setEquipCd(equipCd);			
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
				monthProductionPlanVo2.setGoodsCd(goodsCd);						
				monthProductionPlanVo2.setCplGubun(cplGubun);			
				monthProductionPlanVo2.setJobChangeDate(jobChangeDate);
				monthProductionPlanVo2.setJobChangeStartDate(jobChangeStartDate);
				monthProductionPlanVo2.setJobChangeEndDate(jobChangeEndDate);		
				monthProductionPlanVo2.setTecTime(tecTime);
				monthProductionPlanVo2.setCompleteYn("002");
	
				
				monthProductionPlanVo2.setFpDate(jobChangeDate);	
				monthProductionPlanVo2.setOpTime(opTime);				
				
				monthProductionPlanVo2.setRegId(Utils.getUserId());					
				monthProductionPlanVo2.setUpdId(Utils.getUserId());	
				//monthProductionPlanVo2.setPlanCnt(Double.toString( (((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );
				monthProductionPlanVo2.setPlanCnt(Double.toString(Math.round( (((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime))) );
				
				list.add(monthProductionPlanVo2);	
				
				monthProductionPlanVo = new MonthProductionPlanVo();
				monthProductionPlanVo.setEquipCd(m.getEquipCd().toString());
				monthProductionPlanVo.setChooseDateFrom(m.getJobChangeDate().toString());	
				monthProductionPlanVo.setCplGubun(m.getCplGubun().toString());
				//monthProductionPlanVo.setGoodsCd(goodsCd);
				//텍타임은 제품관리에서 가져와야함.					
				monthProductionPlanService.deleteDtl(monthProductionPlanVo); //잡체인지 일자에 있는 데이터 삭제
				monthProductionPlanService.jobChangeUpdate(monthProductionPlanVo2);
			}
			
			monthProductionPlanService.createDtl(list);	
			
			//운영판일 경우 지금 FP용 데이터 생성
			if("002".equals(monthProductionPlanVo.getCplGubun())) {
				monthProductionPlanVo.setFpDate(fpDate);
				monthProductionPlanVo.setRegId(Utils.getUserId());				
				String[] planDateListSetter = new String[31];
				String planDateList = "";				
				String isNullPlanDataList = "";
				String dataSum = "";
				for(int i=1; i <= 31; i++) {
					
					planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
					planDateList += String.format("%02d", i);
					planDateList += "],";					
					planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
					
					isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					isNullPlanDataList += String.format("%02d", i);
					isNullPlanDataList += "],0) ";
					isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
					
					dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					dataSum += String.format("%02d", i);
					dataSum += "],0)+";
					
				}			
				
				monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
				monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
				monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
				
				//monthProductionPlanService.deleteCplPlanEx(monthProductionPlanVo); // 확정수량 운영판
				//확정판에서는 없는 잡체인지가 운영판에서 생겼을 경우 				
				monthProductionPlanVo.setEquipCd("");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				monthProductionPlanService.createCplDualCapa(monthProductionPlanVo); //듀얼케파
				monthProductionPlanService.createCplTecTime(monthProductionPlanVo); //택타임
				monthProductionPlanService.createCplSecond(monthProductionPlanVo);	//second
				monthProductionPlanService.createCplPlanCntModify(monthProductionPlanVo); // 확정수량 운영판
				
				for(MonthProductionPlanVo m : list) {
					System.out.println("잡체인지 데이터~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" + m);											
					m.setGubun("004");
					m.setFpDate(fpDate);
					m.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
					m.setDataSum(dataSum.substring(0,dataSum.length()-1));
					m.setDayList(planDateList.substring(0,planDateList.length()-1));	
					List<MonthProductionPlanVo> readList = monthProductionPlanService.readFpTotalComplete(m);					
					System.out.println("사이즈가 없나?" + readList.size());		
					if(readList.size() == 0) { //잡체인지 등록한것이 확정판에 없었을 경우			
						System.out.println("넣는다!");		
						monthProductionPlanService.createFpTotalList(m);
						//monthProductionPlanService.createCplPlanCnt(m); //계획수량
					}
				}
				
				

			}

			
	
		} catch (Exception e) {
			logger.info("잡체인지 데이터 남기기 오류");			
			e.printStackTrace();
		
		}

	
	}
	
	//생산관리 - 월별 FP 작업자 조회
	@RequestMapping(value = "/wm/monthProductionMan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("월별 FP 작업자 조회");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			
			
			List<MonthProductionPlanVo> outputList = new ArrayList<MonthProductionPlanVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for(int i=1; i <= 31; i++) {
				
				planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
			}
			monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));		
			
			
			if("002".equals(monthProductionPlanVo.getCplGubun())) { //운영판일떄
				List<MonthProductionPlanVo> readList = monthProductionPlanService.monthProductionPlanManList(monthProductionPlanVo);
				if(readList.size() == 0) { //저장된게 없으면
					monthProductionPlanVo.setCplGubun("001"); //확정판이 조회되게
				}
			}

			List<Map<String, String>> list  = monthProductionPlanService.monthProductionPlanMan(monthProductionPlanVo);			
	
			for(Map<String, String> m : list) {
				
				MonthProductionPlanVo productionPlanVo2 = new MonthProductionPlanVo();
		
				

				if(m.get("DAY_NIGHT_GUBUN")!=null) {
					productionPlanVo2.setDayNightGubun(m.get("DAY_NIGHT_GUBUN"));
					productionPlanVo2.setPlanDate1((String.valueOf(m.get(planDateListSetter[0]))));
					productionPlanVo2.setPlanDate2((String.valueOf(m.get(planDateListSetter[1]))));
					productionPlanVo2.setPlanDate3((String.valueOf(m.get(planDateListSetter[2]))));
					productionPlanVo2.setPlanDate4((String.valueOf(m.get(planDateListSetter[3]))));
					productionPlanVo2.setPlanDate5((String.valueOf(m.get(planDateListSetter[4]))));
					productionPlanVo2.setPlanDate6((String.valueOf(m.get(planDateListSetter[5]))));
					productionPlanVo2.setPlanDate7((String.valueOf(m.get(planDateListSetter[6]))));
					productionPlanVo2.setPlanDate8((String.valueOf(m.get(planDateListSetter[7]))));
					productionPlanVo2.setPlanDate9((String.valueOf(m.get(planDateListSetter[8]))));
					productionPlanVo2.setPlanDate10((String.valueOf(m.get(planDateListSetter[9]))));
					productionPlanVo2.setPlanDate11((String.valueOf(m.get(planDateListSetter[10]))));
					productionPlanVo2.setPlanDate12((String.valueOf(m.get(planDateListSetter[11]))));
					productionPlanVo2.setPlanDate13((String.valueOf(m.get(planDateListSetter[12]))));
					productionPlanVo2.setPlanDate14((String.valueOf(m.get(planDateListSetter[13]))));
					productionPlanVo2.setPlanDate15((String.valueOf(m.get(planDateListSetter[14]))));
					productionPlanVo2.setPlanDate16((String.valueOf(m.get(planDateListSetter[15]))));
					productionPlanVo2.setPlanDate17((String.valueOf(m.get(planDateListSetter[16]))));
					productionPlanVo2.setPlanDate18((String.valueOf(m.get(planDateListSetter[17]))));
					productionPlanVo2.setPlanDate19((String.valueOf(m.get(planDateListSetter[18]))));
					productionPlanVo2.setPlanDate20((String.valueOf(m.get(planDateListSetter[19]))));
					productionPlanVo2.setPlanDate21((String.valueOf(m.get(planDateListSetter[20]))));
					productionPlanVo2.setPlanDate22((String.valueOf(m.get(planDateListSetter[21]))));
					productionPlanVo2.setPlanDate23((String.valueOf(m.get(planDateListSetter[22]))));
					productionPlanVo2.setPlanDate24((String.valueOf(m.get(planDateListSetter[23]))));
					productionPlanVo2.setPlanDate25((String.valueOf(m.get(planDateListSetter[24]))));
					productionPlanVo2.setPlanDate26((String.valueOf(m.get(planDateListSetter[25]))));
					productionPlanVo2.setPlanDate27((String.valueOf(m.get(planDateListSetter[26]))));
					productionPlanVo2.setPlanDate28((String.valueOf(m.get(planDateListSetter[27]))));
					productionPlanVo2.setPlanDate29((String.valueOf(m.get(planDateListSetter[28]))));
					productionPlanVo2.setPlanDate30((String.valueOf(m.get(planDateListSetter[29]))));
					productionPlanVo2.setPlanDate31((String.valueOf(m.get(planDateListSetter[30]))));
				}
				else {
					productionPlanVo2.setDayNightGubun(m.get("GUBUNJA"));
					productionPlanVo2.setPlanDate1("");
					productionPlanVo2.setPlanDate2("");
					productionPlanVo2.setPlanDate3("");
					productionPlanVo2.setPlanDate4("");
					productionPlanVo2.setPlanDate5("");
					productionPlanVo2.setPlanDate6("");
					productionPlanVo2.setPlanDate7("");
					productionPlanVo2.setPlanDate8("");
					productionPlanVo2.setPlanDate9("");
					productionPlanVo2.setPlanDate10("");
					productionPlanVo2.setPlanDate11("");
					productionPlanVo2.setPlanDate12("");
					productionPlanVo2.setPlanDate13("");
					productionPlanVo2.setPlanDate14("");
					productionPlanVo2.setPlanDate15("");
					productionPlanVo2.setPlanDate16("");
					productionPlanVo2.setPlanDate17("");
					productionPlanVo2.setPlanDate18("");
					productionPlanVo2.setPlanDate19("");
					productionPlanVo2.setPlanDate20("");
					productionPlanVo2.setPlanDate21("");
					productionPlanVo2.setPlanDate22("");
					productionPlanVo2.setPlanDate23("");
					productionPlanVo2.setPlanDate24("");
					productionPlanVo2.setPlanDate25("");
					productionPlanVo2.setPlanDate26("");
					productionPlanVo2.setPlanDate27("");
					productionPlanVo2.setPlanDate28("");
					productionPlanVo2.setPlanDate29("");
					productionPlanVo2.setPlanDate30("");
					productionPlanVo2.setPlanDate31("");
				}
				outputList.add(productionPlanVo2);					
			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok"); 		
		} catch (Exception e) {
			logger.info(" 월별 FP 작업자 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;	
	}
	
	//생산관리 - 월별 FP 작업자 등록
	@RequestMapping(value = "/wm/createMan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMan(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		
		logger.info("월별 FP 작업자 등록");
		Map<String, Object> jsonData = new HashMap<>();
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		monthProductionPlanVo.setFpDate(dataList.get(0).get("fpDate").toString().substring(0,6));
		monthProductionPlanVo.setCplGubun(dataList.get(0).get("cplGubun").toString());
		List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
		
		try {
			monthProductionPlanService.deleteMan(monthProductionPlanVo);
			for (Map<String, Object> m : dataList) {
				
				list = new ArrayList<MonthProductionPlanVo>();				
				String dayNightGubun = m.get("dayNightGubun").toString();
				String cplGubun = m.get("cplGubun").toString();			
				String planDate = m.get("fpDate").toString();
				String[] count = new String[31];	
			
			
				count[0]= (m.get("count1").toString());
				count[1]= (m.get("count2").toString());
				count[2]= (m.get("count3").toString());
				count[3]= (m.get("count4").toString());
				count[4]= (m.get("count5").toString());
				count[5]= (m.get("count6").toString());
				count[6]= (m.get("count7").toString());
				count[7]= (m.get("count8").toString());
				count[8]= (m.get("count9").toString());
				count[9] = (m.get("count10").toString());
				count[10] = (m.get("count11").toString());
				count[11] = (m.get("count12").toString());
				count[12] = (m.get("count13").toString());
				count[13] = (m.get("count14").toString());
				count[14] = (m.get("count15").toString());
				count[15] = (m.get("count16").toString());
				count[16] = (m.get("count17").toString());
				count[17] = (m.get("count18").toString());
				count[18] = (m.get("count19").toString());
				count[19] = (m.get("count20").toString());
				count[20] = (m.get("count21").toString());
				count[21] = (m.get("count22").toString());
				count[22] = (m.get("count23").toString());
				count[23] = (m.get("count24").toString());
				count[24] = (m.get("count25").toString());
				count[25] = (m.get("count26").toString());
				count[26] = (m.get("count27").toString());
				count[27] = (m.get("count28").toString());
				count[28] = (m.get("count29").toString());
				count[29] = (m.get("count30").toString());
				count[30] = (m.get("count31").toString());			
				

				for(int i = 0; i < 31; i++) {
					MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	

					monthProductionPlanVo2.setCplGubun(cplGubun);
					monthProductionPlanVo2.setRegId(Utils.getUserId());					
					monthProductionPlanVo2.setFpDate(planDate.substring(0,6) + String.format("%02d", i+1));	
					monthProductionPlanVo2.setDayNightGubun(dayNightGubun);	
					monthProductionPlanVo2.setProductMan(count[i]);				
		
					if(!"".equals(count[i])) {
						list.add(monthProductionPlanVo2);
					}
					
				}			
				if(list.size() != 0) {
					monthProductionPlanService.createMan(list); //설비별 비가동, 가동시간
				}
			}
			jsonData.put("message", "저장되었습니다.");			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info(" 월별 FP 작업자 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	
	//생산관리 - SLD 월별 FP 요약본 조회
	@RequestMapping(value = "/wm/monthProductionPlanSumList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanSumList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 월별 FP 요약본 조회");
		Map<String, Object> jsonData = new HashMap<>();
		String fpDate = monthProductionPlanVo.getFpDate();
		monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
		monthProductionPlanVo.setChooseDateTo(fpDate);
		monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
		
		try {
			List<MonthProductionPlanVo> list =  monthProductionPlanService.monthProductionPlanSumList(monthProductionPlanVo);
			
			jsonData.put("data", list);
		} catch (Exception e) {
			logger.info(" SLD 월별 FP 요약본 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 기종별 요약본 조회
	@RequestMapping(value = "/wm/monthProductionPlanGijongList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanGijongList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 월별 FP 기종별 요약본 조회");
		Map<String, Object> jsonData = new HashMap<>();
		String fpDate = monthProductionPlanVo.getFpDate();
		monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
		monthProductionPlanVo.setChooseDateTo(fpDate);
		monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
		
		try {
			List<MonthProductionPlanVo> list =  monthProductionPlanService.monthProductionPlanGijongList(monthProductionPlanVo);
			
			jsonData.put("data", list);
		} catch (Exception e) {
			logger.info(" SLD 월별 FP 기종별 요약본 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 상세 요약본 조회
	@RequestMapping(value = "/wm/monthProductionPlanDtlList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 월별 FP 상세 요약본 조회 "+monthProductionPlanVo.getGubun());
		Map<String, Object> jsonData = new HashMap<>();
		String fpDate = monthProductionPlanVo.getFpDate();
		monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
		monthProductionPlanVo.setChooseDateTo(fpDate);
		monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
		
		try {
			
			List<TestDataVo> list =  monthProductionPlanService.monthProductionPlanDtlList(monthProductionPlanVo);			
			jsonData.put("data", list);
		} catch (Exception e) {
			logger.info(" SLD 월별 FP 상세 요약본 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 요약정보 테이블 조회
	@RequestMapping(value = "/wm/monthProductionPlanSummaryData", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanSummaryData(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("SLD 요약정보 테이블 조회");
		Map<String, Object> jsonData = new HashMap<>();
		String fpDate = monthProductionPlanVo.getFpDate();
		monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
		monthProductionPlanVo.setChooseDateTo(fpDate);
		monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
		
		
		
		try {
			String lastDate = "";
			if("01".equals(fpDate.substring(6,8))) {
				lastDate = fpDate.substring(0,6)+"01";
			} else {
				lastDate = Integer.toString(Integer.parseInt(fpDate) - 1);
			}		
			monthProductionPlanVo.setLastDate(lastDate);		
			
			List<MonthProductionPlanVo> list1 =  monthProductionPlanService.bestOutputCnt(monthProductionPlanVo);
			List<MonthProductionPlanVo> list2 =  monthProductionPlanService.bestCapaDay(monthProductionPlanVo);
			List<MonthProductionPlanVo> list3 =  monthProductionPlanService.lastDayWorker(monthProductionPlanVo);
			List<MonthProductionPlanVo> list4 =  monthProductionPlanService.lastDayEquipCnt(monthProductionPlanVo);
			
			jsonData.put("list1", list1);
			jsonData.put("list2", list2);
			jsonData.put("list3", list3);
			jsonData.put("list4", list4);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info(" SLD 요약정보 테이블 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 목표등록
	@RequestMapping(value = "/wm/createMonthSumData", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthSumData(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 목표등록");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.monthSumData(monthProductionPlanVo);
			
			if(readVo == null) { //없으면 생성
				monthProductionPlanVo.setRegId(Utils.getUserId());
				monthProductionPlanService.createTheory(monthProductionPlanVo);
			} else { //있으면 수정
				monthProductionPlanVo.setUpdId(Utils.getUserId());
				monthProductionPlanService.updateTheory(monthProductionPlanVo);
			}			
			
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 목표등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 목표 조회
	@RequestMapping(value = "/wm/createMonthSumDataRead", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthSumDataRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 조회");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.monthSumData(monthProductionPlanVo);				
			
			jsonData.put("result", "ok");
			jsonData.put("data", readVo);

		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 수율 조회
	@RequestMapping(value = "/wm/monthProductionPlanYeildRead", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 수율 조회");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.readYeild(monthProductionPlanVo);				
			
			jsonData.put("result", "ok");
			jsonData.put("data", readVo);

		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 수율 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//생산관리 - SLD 월별 FP 수율 생성
	@RequestMapping(value = "/wm/monthProductionPlanYeildCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 수율 생성");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			readVo =  monthProductionPlanService.readYeild(monthProductionPlanVo);
			if(readVo == null) { //없으면 생성
				monthProductionPlanVo.setRegId(Utils.getUserId());
				monthProductionPlanService.createYeild(monthProductionPlanVo);
			} else { //있으면 수정
				monthProductionPlanVo.setUpdId(Utils.getUserId());
				monthProductionPlanService.updateYeild(monthProductionPlanVo);
			}		
			
			jsonData.put("result", "ok");
			jsonData.put("data", readVo);

		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 수율 생성 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}	

	//생산관리 - SLD 월별 FP 수율 삭제
	@RequestMapping(value = "/wm/monthProductionPlanYeildDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("생산관리 - SLD 월별 FP 수율 삭제");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			monthProductionPlanService.deleteYeild(monthProductionPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산관리 - SLD 월별 FP 수율 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//잡체인지 목록 모달
	@RequestMapping(value = "/wm/jcModalList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jcModalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("잡체인지 목록 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			List<MonthProductionPlanVo> list =  monthProductionPlanService.jcModalList(monthProductionPlanVo);			
			
			jsonData.put("result", "ok");
			jsonData.put("data", list);

		} catch (Exception e) {
			logger.info("잡체인지 목록 모달 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//잡체인지 삭제
	@RequestMapping(value = "/wm/deleteMonthProductionPlan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMonthProductionPlan(@RequestBody List<Map<String, Object>> dataList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리-생산계획 등록&수정 처리 " + dataList);
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		MonthProductionPlanVo readVo = new MonthProductionPlanVo();		
		monthProductionPlanVo.setFpDate(dataList.get(0).get("fpDate").toString().substring(0,6));
		monthProductionPlanVo.setCplGubun(dataList.get(0).get("cplGubun").toString());
		monthProductionPlanVo.setEquipCd(dataList.get(0).get("equipCd").toString());
		readVo.setFpDate(dataList.get(0).get("fpDate").toString().substring(0,6)); 
		readVo.setCplGubun("001");          		
		readVo =  monthProductionPlanService.readYeild(readVo);
		readVo.setJobChangeDate("ok");
		readVo.setCplGubun(dataList.get(0).get("cplGubun").toString());
		
		
		List<MonthProductionPlanVo> listDtl = new ArrayList<MonthProductionPlanVo>();
		
		try {			
			monthProductionPlanService.deleteDtl(monthProductionPlanVo);
			monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
			for (Map<String, Object> m : dataList) {
				
				
				listDtl = new ArrayList<MonthProductionPlanVo>();
				GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
				
				String cplGubun = m.get("cplGubun").toString();
				String equipCd = m.get("equipCd").toString();
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipSLD(equipCodeAdmVo);
				String planDate = m.get("fpDate").toString();				
				String completeYn = m.get("completeYn").toString();
				String goodsCd = m.get("goodsCd").toString();				
				goodsCodeAdmVo.setGoodsCd(goodsCd);;
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
				String tecTime = goodsCodeAdmVo.getTecTime();	
				String[] count = new String[31];	
				String[] npTime = new String[31];	
				
				
			
				count[0]= (m.get("count1").toString());
				count[1]= (m.get("count2").toString());
				count[2]= (m.get("count3").toString());
				count[3]= (m.get("count4").toString());
				count[4]= (m.get("count5").toString());
				count[5]= (m.get("count6").toString());
				count[6]= (m.get("count7").toString());
				count[7]= (m.get("count8").toString());
				count[8]= (m.get("count9").toString());
				count[9] = (m.get("count10").toString());
				count[10] = (m.get("count11").toString());
				count[11] = (m.get("count12").toString());
				count[12] = (m.get("count13").toString());
				count[13] = (m.get("count14").toString());
				count[14] = (m.get("count15").toString());
				count[15] = (m.get("count16").toString());
				count[16] = (m.get("count17").toString());
				count[17] = (m.get("count18").toString());
				count[18] = (m.get("count19").toString());
				count[19] = (m.get("count20").toString());
				count[20] = (m.get("count21").toString());
				count[21] = (m.get("count22").toString());
				count[22] = (m.get("count23").toString());
				count[23] = (m.get("count24").toString());
				count[24] = (m.get("count25").toString());
				count[25] = (m.get("count26").toString());
				count[26] = (m.get("count27").toString());
				count[27] = (m.get("count28").toString());
				count[28] = (m.get("count29").toString());
				count[29] = (m.get("count30").toString());
				count[30] = (m.get("count31").toString());			
				
				npTime[0]= (m.get("npTime1").toString());
				npTime[1]= (m.get("npTime2").toString());
				npTime[2]= (m.get("npTime3").toString());
				npTime[3]= (m.get("npTime4").toString());
				npTime[4]= (m.get("npTime5").toString());
				npTime[5]= (m.get("npTime6").toString());
				npTime[6]= (m.get("npTime7").toString());
				npTime[7]= (m.get("npTime8").toString());
				npTime[8]= (m.get("npTime9").toString());
				npTime[9] = (m.get("npTime10").toString());
				npTime[10] = (m.get("npTime11").toString());
				npTime[11] = (m.get("npTime12").toString());
				npTime[12] = (m.get("npTime13").toString());
				npTime[13] = (m.get("npTime14").toString());
				npTime[14] = (m.get("npTime15").toString());
				npTime[15] = (m.get("npTime16").toString());
				npTime[16] = (m.get("npTime17").toString());
				npTime[17] = (m.get("npTime18").toString());
				npTime[18] = (m.get("npTime19").toString());
				npTime[19] = (m.get("npTime20").toString());
				npTime[20] = (m.get("npTime21").toString());
				npTime[21] = (m.get("npTime22").toString());
				npTime[22] = (m.get("npTime23").toString());
				npTime[23] = (m.get("npTime24").toString());
				npTime[24] = (m.get("npTime25").toString());
				npTime[25] = (m.get("npTime26").toString());
				npTime[26] = (m.get("npTime27").toString());
				npTime[27] = (m.get("npTime28").toString());
				npTime[28] = (m.get("npTime29").toString());
				npTime[29] = (m.get("npTime30").toString());
				npTime[30] = (m.get("npTime31").toString());	
								
				
				for(int i = 0; i < 31; i++) {
					MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
					monthProductionPlanVo2.setEquipCd(equipCd);			
					monthProductionPlanVo2.setGoodsCd(goodsCd);			
					monthProductionPlanVo2.setCplGubun(cplGubun);
					monthProductionPlanVo2.setCompleteYn(completeYn);

					monthProductionPlanVo2.setRegId(Utils.getUserId());					
					monthProductionPlanVo2.setFpDate(planDate.substring(0,6) + String.format("%02d", i+1));	
					monthProductionPlanVo2.setNpGubun(count[i]);					
					monthProductionPlanVo2.setNpTime(npTime[i]);	
					
					double opTime = 24 - Double.parseDouble(npTime[i]);
					
					monthProductionPlanVo2.setOpTime(Double.toString(opTime));
					
					//텍타임은 제품관리에서 가져와야함.
					monthProductionPlanVo2.setTecTime(tecTime);				
					
					//monthProductionPlanVo2.setPlanCnt(Double.toString((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );			
					monthProductionPlanVo2.setPlanCnt(Double.toString(Math.round((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime))) );
					monthProductionPlanVo2.setRegId(Utils.getUserId());
		
					listDtl.add(monthProductionPlanVo2);					
				}	
				
				if(listDtl.size() != 0) {
					monthProductionPlanService.createDtl(listDtl); //설비별 비가동, 가동시간
				}
			}
			
			//운영판일 경우 지금 FP용 데이터 생성
			if("002".equals(monthProductionPlanVo.getCplGubun())) {
				
				monthProductionPlanVo.setRegId(Utils.getUserId());				
				String[] planDateListSetter = new String[31];
				String planDateList = "";				
				String isNullPlanDataList = "";
				String dataSum = "";
				for(int i=1; i <= 31; i++) {
					
					planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
					planDateList += String.format("%02d", i);
					planDateList += "],";					
					planDateListSetter[i-1] = monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i);
					
					isNullPlanDataList += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					isNullPlanDataList += String.format("%02d", i);
					isNullPlanDataList += "],0) ";
					isNullPlanDataList += "[" + monthProductionPlanVo.getFpDate().toString() + String.format("%02d", i) + "],";
					
					dataSum += "ISNULL([" + monthProductionPlanVo.getFpDate().toString();
					dataSum += String.format("%02d", i);
					dataSum += "],0)+";
					
				}			
				
				monthProductionPlanVo.setDayListNull(isNullPlanDataList.substring(0,isNullPlanDataList.length()-1));
				monthProductionPlanVo.setDataSum(dataSum.substring(0,dataSum.length()-1));
				monthProductionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
				//monthProductionPlanVo.setGubun("005");
				//monthProductionPlanVo.setEquipCd("");
				//monthProductionPlanService.deleteCplPlan(monthProductionPlanVo); // 확정수량 운영판			
				monthProductionPlanService.createCplDualCapa(monthProductionPlanVo); //듀얼케파
				monthProductionPlanService.createCplTecTime(monthProductionPlanVo); //택타임
				monthProductionPlanService.createCplSecond(monthProductionPlanVo);	//second	
				monthProductionPlanService.createCplPlanCntModify(monthProductionPlanVo); // 확정수량 운영판
				jsonData.put("message", "삭제되었습니다.");	
			} else {
				jsonData.put("message", "삭제되었습니다. 확정을 다시 해주세요.");	
			}
			
			
					
			jsonData.put("result", "ok");
			
	
		} catch (Exception e) {
			logger.info("생산관리-생산계획 등록&수정 처리");
			
			//해당planDate 모두 삭제? 등록일경우 모두삭제하면되는데 수정일경우엔?
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	//생산관리/SLD 월별 FP - 있는지 체크
	@RequestMapping(value = "/wm/readMonthPlanBodySLDCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLDCheck(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		logger.info("SLD 월별 FP");
		Map<String, Object> jsonData = new HashMap<>();
		try {					
			
			List<MonthProductionPlanVo> list  = monthProductionPlanService.readDtl(monthProductionPlanVo);
			
			if(list.size() == 0) {				
				jsonData.put("result", "ok"); 
			} else {
				jsonData.put("result", "fail"); 
				
			}
			
			
		} catch (Exception e) {
			logger.info("SLD 월별 FP 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//FP 데이터 삭제
	@RequestMapping(value = "/wm/deleteMonthProductionPlanMain", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMonthProductionPlanMain(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리-FP삭제 " + monthProductionPlanVo);

		
		try {			
			monthProductionPlanService.delete(monthProductionPlanVo);
			monthProductionPlanService.deleteDtl(monthProductionPlanVo);
			monthProductionPlanService.deleteGoods(monthProductionPlanVo);
			
			if("001".equals(monthProductionPlanVo.getGubun())) {				
				monthProductionPlanVo.setGubun("004");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
			} else {
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				monthProductionPlanVo.setGubun("001");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				monthProductionPlanVo.setGubun("002");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);
				monthProductionPlanVo.setGubun("003");
				monthProductionPlanService.deleteCplPlan(monthProductionPlanVo);				
			}
			
			jsonData.put("result", "ok");
			
	
		} catch (Exception e) {
			logger.info("FP 데이터 삭제 오류");
					
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	

	
	
	//메모 등록
	@RequestMapping(value = "/wm/createMonthProductionMemo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthProductionMemo(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모등록");
		
		try {			
			MonthProductionPlanVo monthProductPresentVo2 = monthProductionPlanService.memoList(monthProductionPlanVo);			
			
			if(monthProductPresentVo2 == null) {
				monthProductionPlanVo.setRegId(Utils.getUserId());
				monthProductionPlanService.memoCreate(monthProductionPlanVo);		
			} else {
				monthProductionPlanVo.setUpdId(Utils.getUserId());
				monthProductionPlanService.memoUpdate(monthProductionPlanVo);			
			}

			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("메모 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//메모 조회
	@RequestMapping(value = "/wm/memoMonthProductionMemo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> memoMonthProductionMemo(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모 조회");

		try {					
			monthProductionPlanVo = monthProductionPlanService.memoList(monthProductionPlanVo);			
			jsonData.put("result", "ok");
			jsonData.put("data", monthProductionPlanVo);
		} catch (Exception e) {
			logger.info("메모 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//기종별일일재고 목록 모달
	//@RequestMapping(value = "/wm/dailyInvenList", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> dailyInvenList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
	//	
	//	logger.info("기종별일일재고 목록 모달");
	//	Map<String, Object> jsonData = new HashMap<>();
	//	try {
	//		List<MonthProductionPlanVo> list =  monthProductionPlanService.dailyInvenList(monthProductionPlanVo);			
	//		
	//		jsonData.put("result", "ok");
	//		jsonData.put("data", list);
    //
	//	} catch (Exception e) {
	//		logger.info("기종별일일재고 목록 모달 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
    //
	//	return jsonData;
	//
	//}
	
	//기종별일일재고 목록 모달
	@RequestMapping(value = "/wm/dailyInvenList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 목록 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			List<MonthProductionPlanVo> list =  monthProductionPlanService.dailyInvenDtlList(monthProductionPlanVo);			
			
			jsonData.put("result", "ok");
			jsonData.put("data", list);

		} catch (Exception e) {
			logger.info("기종별일일재고 목록 모달 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//기종별일일재고 목록 모달
	@RequestMapping(value = "/wm/dailyInvenRead", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 목록 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			monthProductionPlanVo  =  monthProductionPlanService.dailyInvenRead(monthProductionPlanVo);			
			
			jsonData.put("result", "ok");
			jsonData.put("data", monthProductionPlanVo);

		} catch (Exception e) {
			logger.info("기종별일일재고 목록 모달 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	
	//기종별일일재고 등록
	@RequestMapping(value = "/wm/dailyInvenCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenCreate(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		
		logger.info("기종별일일재고 등록" + dataList);
	
		Map<String, Object> jsonData = new HashMap<>();
		List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		
		try {			
			monthProductionPlanVo.setFpDate(dataList.get(0).get("fpDate").toString());
			monthProductionPlanVo.setOutGubun(dataList.get(0).get("outGubun").toString());
			monthProductionPlanService.dailyInvenDelete(monthProductionPlanVo);	
			for (Map<String, Object> m : dataList) {
				
				list = new ArrayList<MonthProductionPlanVo>();				
				String goodsCd = m.get("goodsCd").toString();
				String outGubun = m.get("outGubun").toString();
				String dealCorpCd = m.get("dealCorpCd").toString();
				String fpDate = m.get("fpDate").toString();
				String[] count = new String[31];	
			
			
				count[0]= (m.get("count1").toString());
				count[1]= (m.get("count2").toString());
				count[2]= (m.get("count3").toString());
				count[3]= (m.get("count4").toString());
				count[4]= (m.get("count5").toString());
				count[5]= (m.get("count6").toString());
				count[6]= (m.get("count7").toString());
				count[7]= (m.get("count8").toString());
				count[8]= (m.get("count9").toString());
				count[9] = (m.get("count10").toString());
				count[10] = (m.get("count11").toString());
				count[11] = (m.get("count12").toString());
				count[12] = (m.get("count13").toString());
				count[13] = (m.get("count14").toString());
				count[14] = (m.get("count15").toString());
				count[15] = (m.get("count16").toString());
				count[16] = (m.get("count17").toString());
				count[17] = (m.get("count18").toString());
				count[18] = (m.get("count19").toString());
				count[19] = (m.get("count20").toString());
				count[20] = (m.get("count21").toString());
				count[21] = (m.get("count22").toString());
				count[22] = (m.get("count23").toString());
				count[23] = (m.get("count24").toString());
				count[24] = (m.get("count25").toString());
				count[25] = (m.get("count26").toString());
				count[26] = (m.get("count27").toString());
				count[27] = (m.get("count28").toString());
				count[28] = (m.get("count29").toString());
				count[29] = (m.get("count30").toString());
				count[30] = (m.get("count31").toString());			
				

				for(int i = 0; i < 31; i++) {
					MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();					
					
					monthProductionPlanVo2.setGoodsCd(goodsCd);
					monthProductionPlanVo2.setDealCorpCd(dealCorpCd);
					monthProductionPlanVo2.setOutGubun(outGubun);
					monthProductionPlanVo2.setRegId(Utils.getUserId());				
					monthProductionPlanVo2.setFpDate(fpDate.substring(0,6) + String.format("%02d", i+1));			
					monthProductionPlanVo2.setOutputCnt(count[i]);				
		
					if(!"".equals(count[i])) {
						list.add(monthProductionPlanVo2);
					}
					
				}			
				if(list.size() != 0) {
					monthProductionPlanService.dailyInvenCreate(list);
				}
			}
			jsonData.put("result", "ok");
	

		} catch (Exception e) {
			logger.info("기종별일일재고 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//기종별일일재고 실재고 등록
	@RequestMapping(value = "/wm/dailyInvenCreateReal", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenCreateReal(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실재고  등록");	
		Map<String, Object> jsonData = new HashMap<>();
		
		try {

			monthProductionPlanVo.setRegId(Utils.getUserId());		
			monthProductionPlanService.dailyInvenAdmDelete(monthProductionPlanVo);
			monthProductionPlanService.dailyInvenAdmCreate(monthProductionPlanVo);		
			
			jsonData.put("result", "ok");
	

		} catch (Exception e) {
			logger.info("기종별일일재고 실재고  등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//기종별일일재고 실재고 삭제
	@RequestMapping(value = "/wm/dailyInvenCreateRealDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenCreateRealDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실재고  등록");	
		Map<String, Object> jsonData = new HashMap<>();
		
		try {

			monthProductionPlanVo.setRegId(Utils.getUserId());		
			monthProductionPlanService.dailyInvenAdmDelete(monthProductionPlanVo);	
			
			jsonData.put("result", "ok");
	

		} catch (Exception e) {
			logger.info("기종별일일재고 실재고  삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	
	//기종별일일재고 실데이터
	@RequestMapping(value = "/wm/gijongDailyPlan1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> gijongDailyPlan1(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실데이터");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String fpDate = monthProductionPlanVo.getFpDate();
			int year = Integer.parseInt(fpDate.substring(0,4));
			int month = Integer.parseInt(fpDate.substring(4,6));
			int day = Integer.parseInt(fpDate.substring(6,8));
			monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
			monthProductionPlanVo.setChooseDateTo(fpDate);
			monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
			Calendar cal = Calendar.getInstance();
			cal.set(year,(month-1),1);
			monthProductionPlanVo.setLastDate(Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));		
			
			Calendar cal2 = Calendar.getInstance();
			cal2.set(year,(month-1),day);
			cal2.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String yesterDay = sdf.format(cal2.getTime());
			monthProductionPlanVo.setYesterDay(yesterDay);
			monthProductionPlanVo.setYesterDayF(yesterDay.substring(6,8));
			List<MonthProductionPlanVo> list  =  monthProductionPlanService.gijongDailyPlan1(monthProductionPlanVo);			
			
			jsonData.put("result", "ok");
			jsonData.put("data", list);

		} catch (Exception e) {
			logger.info("기종별일일재고 실데이터 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//기종별일일재고 입력
	@RequestMapping(value = "/wm/gijongDailyPlan2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> gijongDailyPlan2(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 입력");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String fpDate = monthProductionPlanVo.getFpDate();
			int year = Integer.parseInt(fpDate.substring(0,4));
			int month = Integer.parseInt(fpDate.substring(4,6));
			int day = Integer.parseInt(fpDate.substring(6,8));
			monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
			monthProductionPlanVo.setChooseDateTo(fpDate);
			monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
			Calendar cal = Calendar.getInstance();
			cal.set(year,(month-1),1);
			monthProductionPlanVo.setLastDate(Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));	
			
			Calendar cal2 = Calendar.getInstance();
			cal2.set(year,(month-1),day);
			cal2.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String yesterDay = sdf.format(cal2.getTime());
			monthProductionPlanVo.setYesterDay(yesterDay);
			monthProductionPlanVo.setYesterDayF(yesterDay.substring(6,8));
			List<MonthProductionPlanVo> list  =  monthProductionPlanService.gijongDailyPlan2(monthProductionPlanVo);			
			
			jsonData.put("result", "ok");
			jsonData.put("data", list);

		} catch (Exception e) {
			logger.info("기종별일일재고 실데이터 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//기종별일일재고 실데이터 마감
	@RequestMapping(value = "/wm/createNextMonthStock", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createNextMonthStock(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실데이터 마감");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String fpDate = monthProductionPlanVo.getFpDate();
			int year = Integer.parseInt(fpDate.substring(0,4));
			int month = Integer.parseInt(fpDate.substring(4,6));	//이번달
	
			Calendar cal = Calendar.getInstance();
			Calendar cal2 = Calendar.getInstance();
			cal.set(year,(month-1),1);	
			cal2.set(year,(month),1);	//다음달
			cal2.add(Calendar.MONTH, 1);
			MonthProductionPlanVo readVo = new MonthProductionPlanVo();
			
			monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
			monthProductionPlanVo.setChooseDateTo(fpDate.substring(0,6)+Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));
			monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
			
			monthProductionPlanVo.setNextMonth(Integer.toString(cal2.get(Calendar.YEAR)) + String.format("%02d",cal2.get(Calendar.MONTH) ) );
		
			monthProductionPlanVo.setLastDate(Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));
			readVo.setFpDate(monthProductionPlanVo.getNextMonth());
			readVo.setGubun(monthProductionPlanVo.getGubun());
			
			List<MonthProductionPlanVo> list = monthProductionPlanService.dailyInvenAdmList(readVo);
			
			if(list.size() == 0 ) {
				if(monthProductionPlanVo.getGubun().equals("002")) {
					monthProductionPlanService.createNextMonthStock(monthProductionPlanVo);
				} else {
					monthProductionPlanService.createNextMonthStockReal(monthProductionPlanVo);	
				}
				
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "duplicate");
				jsonData.put("message", "이미 다음달 재고가 등록이 되어있습니다.");
			}
			

			//List<MonthProductionPlanVo> list  =  monthProductionPlanService.gijongDailyPlan2(monthProductionPlanVo);			
			
			
			//jsonData.put("data", list);

		} catch (Exception e) {
			logger.info("기종별일일재고 실데이터 마감 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	
	//작업자 엑셀 업로드하는 부분
	@RequestMapping(value= "/wm/monthExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthExcelUpload(Model model, @RequestParam("excelfile") MultipartFile file) {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String path = filePath + "temporaryFolder";
			String url = fileUploadService.restore(file, logger, path);
			logger.info(url);
			model.addAttribute("url", url);
			jsonData.put("data", url);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("monthExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}
		return jsonData;
	}
	
	//월별 설비 JC 및 PM 일정 엑셀 업로드
	@RequestMapping(value="/wm/readMonthPlanByExcel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanByExcel(String filename) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		CustomerExcelReader excelReader = new CustomerExcelReader();
		
		try {
			List<String> monthPlanList = excelReader.monthPlan_fileload(filename, logger);
			logger.info("테이블생성_ajax");
			File file= new File(filename);
			logger.info(filename);
			
			if(monthPlanList.size() != 0) {
				jsonData.put("data", monthPlanList);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "값이 존재하지 않습니다");
				jsonData.put("result", "fail");
			}
			
			if(file.exists()) {
				if(file.delete()) {
					logger.info("삭제 성공");
				} else {
					logger.info("삭제 실패");
				}
			} else {
				logger.info("파일존재하지않음");
			}
			
		} catch(Exception e) {
			logger.info("readMonthPlanByExcel오류");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류 발생");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

}