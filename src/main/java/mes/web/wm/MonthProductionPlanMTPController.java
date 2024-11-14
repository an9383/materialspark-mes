package mes.web.wm;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.SalesPlanAdmVo;
import mes.domain.wm.MonthProductionPlanVo;
import mes.domain.wm.TestDataVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.SalesPlanAdmService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.em.ManufacturerService;
import mes.service.po.WorkOrderService;
import mes.service.wm.MonthProductionPlanMTPService;
import mes.service.wm.WorkOrderPlanService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class MonthProductionPlanMTPController {

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
	private MonthProductionPlanMTPService monthProductionPlanService;
	@Inject
	private SalesPlanAdmService salesPlanAdmService;
	
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MonthProductionPlanMTPController.class);

	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc1210", method = RequestMethod.GET)
	public String wmsc1210GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc1210";
	}
		
	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc1220", method = RequestMethod.GET)
	public String wmsc1220GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc1220";
	}
	
	//생산관리 - SLD 월별 FP
	@RequestMapping(value = "/wmsc1230", method = RequestMethod.GET)
	public String wmsc1230GET(Locale locale, Model model) throws Exception {

		logger.info("SLD 월별 FP 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		systemCommonCodeVo.setBaseGroupCd("112"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("npGubunList", systemCommonCodeList);
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeAdmList = goodsCodeAdmService.goosdCdGijonglist(goodsCodeAdmVo);
		model.addAttribute("goodsCodeList", goodsCodeAdmList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc1230";
	}
	
	//영업관리 - FP일지
	@RequestMapping(value = "/wmsc0250", method = RequestMethod.GET)
	public String wmsc0250GET(Locale locale, Model model) throws Exception {

		logger.info("FP일지");
		String[] date = DateUtil.getToday("yyyy-mm-dd").split("-");
		String day = date[2];
		String month = date[1];
		
		Calendar cal2 = Calendar.getInstance();
		cal2.set(Integer.parseInt(date[0]),(Integer.parseInt(month)-1),Integer.parseInt(day));
		cal2.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yesterDay = sdf.format(cal2.getTime());

		String yesterday = yesterDay.substring(6,8);
		
		model.addAttribute("day", day);
		model.addAttribute("month", month);
		model.addAttribute("yesterday", yesterday);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
        
		return "wm/wmsc0250";
	}
	
	//영업관리 - 계획대비실적
	@RequestMapping(value = "/wmsc0260", method = RequestMethod.GET)
	public String wmsc0260GET(Locale locale, Model model) throws Exception {

		logger.info("계획대비실적");
		String[] date = DateUtil.getToday("yyyy-mm-dd").split("-");
		String day = date[2];
		String month = date[1];
		
		Calendar cal2 = Calendar.getInstance();
		cal2.set(Integer.parseInt(date[0]),(Integer.parseInt(month)-1),Integer.parseInt(day));
		cal2.add(Calendar.DATE, -1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String yesterDay = sdf.format(cal2.getTime());

		String yesterday = yesterDay.substring(6,8);
		
		model.addAttribute("day", day);
		model.addAttribute("month", month);
		model.addAttribute("yesterday", yesterday);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
        
		return "wm/wmsc0260";
	}
	
	//생산관리 - SLD 월별 FP 확정여부 체크
	@RequestMapping(value = "/wm/checkCompleteYnMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkCompleteYnMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/checkJobChangeMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkJobChangeMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/updateCompleteYnModifyMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCompleteYnModifyMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/updateCompleteYnMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateCompleteYnMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/jobChangeModalMTP", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jobChangeModalMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/jobChangeGoodsModalMTP", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jobChangeGoodsModalMTP(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/readMonthPlanBodySLDMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLDMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/readMonthPlanBodySLDModifyMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLDModifyMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/insertMonthProductionPlanMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthProductionPlanMTP(@RequestBody List<Map<String, Object>> dataList) throws Exception {

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
					List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
					String planDate = m.get("fpDate").toString();				
					String completeYn = m.get("completeYn").toString();
					String goodsCd = m.get("goodsCd").toString();
					goodsCodeAdmVo.setGoodsCd(goodsCd);;
					goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
					String tecTime = equipCodeAdmList.get(0).getEquipTacTime();	
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
						
						monthProductionPlanVo2.setPlanCnt(Double.toString((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );			
				
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
	@RequestMapping(value = "/wm/insertMonthProductionPlanJobChangeMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthProductionPlanJobChangeMTP(@RequestBody List<Map<String, Object>> dataList) throws Exception {

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
				//String completeYn = m.get("completeYn").toString();
				String jobChangeDate = m.get("jobChangeDate").toString();
				String jobChangeStartDate = m.get("jobChangeStartDate").toString();
				String jobChangeEndDate = m.get("jobChangeEndDate").toString();
				GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
				goodsCodeAdmVo.setGoodsCd(goodsCd);;
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
				//String tecTime = goodsCodeAdmVo.getTecTime();	
				
				//등록부
				MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
				monthProductionPlanVo2.setEquipCd(equipCd);	
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
				String tecTime = equipCodeAdmList.get(0).getEquipTacTime();
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
				monthProductionPlanVo2.setPlanCnt(Double.toString((((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );
				
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
				//String tecTime = goodsCodeAdmVo.getTecTime();	
				
				//등록부
				MonthProductionPlanVo monthProductionPlanVo2 = new MonthProductionPlanVo();	
				monthProductionPlanVo2.setEquipCd(equipCd);			
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
				String tecTime = equipCodeAdmList.get(0).getEquipTacTime();
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
				monthProductionPlanVo2.setPlanCnt(Double.toString( (((Double.parseDouble(opTime) * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );
				
				
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
	@RequestMapping(value = "/wm/monthProductionManMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionManMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/createManMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createManMTP(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanSumListMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanSumListMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanGijongListMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanGijongListMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanDtlListMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanDtlListMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanSummaryDataMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanSummaryDataMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/createMonthSumDataMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthSumDataMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/createMonthSumDataReadMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthSumDataReadMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanYeildReadMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildReadMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanYeildCreateMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildCreateMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/monthProductionPlanYeildDeleteMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monthProductionPlanYeildDeleteMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/jcModalListMTP", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> jcModalListMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/deleteMonthProductionPlanMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMonthProductionPlanMTP(@RequestBody List<Map<String, Object>> dataList) throws Exception {

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
				List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listEquipMTP(equipCodeAdmVo);
				String planDate = m.get("fpDate").toString();				
				String completeYn = m.get("completeYn").toString();
				String goodsCd = m.get("goodsCd").toString();				
				goodsCodeAdmVo.setGoodsCd(goodsCd);;
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
				String tecTime = equipCodeAdmList.get(0).getEquipTacTime();	
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
					
					monthProductionPlanVo2.setPlanCnt(Double.toString((((opTime * 60 * 60) * (Double.parseDouble(equipCodeAdmList.get(0).getEquipCapa())) * Double.parseDouble(readVo.getYeild1()) * Double.parseDouble(readVo.getYeild2()))) / Double.parseDouble(tecTime)) );			
		
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
	@RequestMapping(value = "/wm/readMonthPlanBodySLDCheckMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBodySLDCheckMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/deleteMonthProductionPlanMainMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMonthProductionPlanMainMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/createMonthProductionMemoMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMonthProductionMemoMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/memoMonthProductionMemoMTP", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> memoMonthProductionMemoMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {

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
	@RequestMapping(value = "/wm/dailyInvenListMTP", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> dailyInvenListMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 목록 모달");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			List<MonthProductionPlanVo> list =  monthProductionPlanService.dailyInvenList(monthProductionPlanVo);			
			
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
	@RequestMapping(value = "/wm/dailyInvenReadMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenReadMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	@RequestMapping(value = "/wm/dailyInvenCreateMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenCreateMTP(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		
		logger.info("기종별일일재고 등록");
	
		Map<String, Object> jsonData = new HashMap<>();
		MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
		
		try {
			
			
			monthProductionPlanVo.setFpDate(dataList.get(0).get("fpDate1").toString());
			monthProductionPlanVo.setGoodsCd(dataList.get(0).get("goodsCd").toString());
			monthProductionPlanVo.setLastMonthStock(dataList.get(0).get("lastMonthStock").toString());
			monthProductionPlanVo.setGubun(dataList.get(0).get("gubun").toString());
			monthProductionPlanVo.setRegId(Utils.getUserId());
		
			monthProductionPlanService.dailyInvenAdmDelete(monthProductionPlanVo);
			monthProductionPlanService.dailyInvenAdmCreate(monthProductionPlanVo);		
			if(!"001".equals(dataList.get(0).get("fpDate2").toString()) ) {
				
				for(Map<String, Object> m : dataList) {
					monthProductionPlanVo = new MonthProductionPlanVo();
					
					monthProductionPlanVo.setFpDate(m.get("fpDate2").toString());
					monthProductionPlanVo.setGoodsCd(m.get("goodsCd").toString());
					monthProductionPlanVo.setOutGubun(m.get("outGubun").toString());
					monthProductionPlanVo.setOutputCnt(m.get("outputCnt").toString());
					monthProductionPlanVo.setDealCorpCd(m.get("dealCorpCd").toString());
					monthProductionPlanVo.setRegId(Utils.getUserId());
					monthProductionPlanService.dailyInvenDelete(monthProductionPlanVo);	
					monthProductionPlanService.dailyInvenCreate(monthProductionPlanVo);		
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
	@RequestMapping(value = "/wm/dailyInvenCreateRealMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dailyInvenCreateRealMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	
	
	//기종별일일재고 실데이터
	@RequestMapping(value = "/wm/gijongDailyPlan1MTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> gijongDailyPlan1MTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실데이터");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String fpDate = monthProductionPlanVo.getFpDate();
			int year = Integer.parseInt(fpDate.substring(0,4));
			int month = Integer.parseInt(fpDate.substring(4,6));
			monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
			monthProductionPlanVo.setChooseDateTo(fpDate);
			monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
			Calendar cal = Calendar.getInstance();
			cal.set(year,(month-1),1);
			monthProductionPlanVo.setLastDate(Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));			
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
	
	//기종별일일재고 실데이터
	@RequestMapping(value = "/wm/gijongDailyPlan2MTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> gijongDailyPlan2MTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("기종별일일재고 실데이터");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String fpDate = monthProductionPlanVo.getFpDate();
			int year = Integer.parseInt(fpDate.substring(0,4));
			int month = Integer.parseInt(fpDate.substring(4,6));
			monthProductionPlanVo.setChooseDateFrom(fpDate.substring(0,6)+"01");
			monthProductionPlanVo.setChooseDateTo(fpDate);
			monthProductionPlanVo.setFpDate(fpDate.substring(0,6));
			Calendar cal = Calendar.getInstance();
			cal.set(year,(month-1),1);
			monthProductionPlanVo.setLastDate(Integer.toString(cal.getActualMaximum(Calendar.DAY_OF_MONTH)));			
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
	@RequestMapping(value = "/wm/createNextMonthStockMTP", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createNextMonthStockMTP(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
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
	
	//FP일지 1번 리스트
	@RequestMapping(value = "/wm/fpDailyList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> fpDailyList(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("FP일지 1번 리스트");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String chooseDateTo = monthProductionPlanVo.getChooseDateTo();
			int year = Integer.parseInt(chooseDateTo.substring(0,4));
			int month = Integer.parseInt(chooseDateTo.substring(4,6));
			int day = Integer.parseInt(chooseDateTo.substring(6,8));			
			Calendar cal2 = Calendar.getInstance();
			cal2.set(year,(month-1),day);
			cal2.add(Calendar.DATE, -1);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String yesterDay = sdf.format(cal2.getTime());
			monthProductionPlanVo.setChooseDateTo(yesterDay);
			monthProductionPlanVo.setChooseDateFrom(monthProductionPlanVo.getChooseDateTo().substring(0,6) + "01");
			List<MonthProductionPlanVo> list =  monthProductionPlanService.fpDailyList1(monthProductionPlanVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");			

		} catch (Exception e) {
			logger.info("FP일지 1번 리스트 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//FP일지 2번 리스트
	@RequestMapping(value = "/wm/fpDailyList3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> fpDailyList3(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("FP일지 2번 리스트");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			monthProductionPlanVo.setChooseDateFrom(monthProductionPlanVo.getChooseDateTo().substring(0,6) + "01");
			List<MonthProductionPlanVo> list =  monthProductionPlanService.fpDailyList3(monthProductionPlanVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");			

		} catch (Exception e) {
			logger.info("FP일지 2번 리스트 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//계획대비 실적 1번 리스트
	@RequestMapping(value = "/wm/performanceAginstPlanMonth", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> performanceAginstPlanMonth(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("계획대비 실적 1번 리스트");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			monthProductionPlanVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			List<MonthProductionPlanVo> list =  monthProductionPlanService.performanceAginstPlanMonth(monthProductionPlanVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");			

		} catch (Exception e) {
			logger.info("계획대비 실적 1번 리스트 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//계획대비 실적 2번 리스트
	@RequestMapping(value = "/wm/performanceAginstPlanTotal", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> performanceAginstPlanTotal(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		logger.info("계획대비 실적 2번 리스트");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + monthProductionPlanVo.getFpDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			monthProductionPlanVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			
			List<MonthProductionPlanVo> list =  monthProductionPlanService.performanceAginstPlanTotal(monthProductionPlanVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");			

		} catch (Exception e) {
			logger.info("계획대비 실적 2번 리스트 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	
	}
	
	//영업관리 판매계획 분기별조회
	@RequestMapping(value = "/wm/salesPlanAdmQuarterDataListNew", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> salesPlanAdmQuarterDataListNew(SalesPlanAdmVo salesPlanAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 판매계획 분기별조회");				
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + salesPlanAdmVo.getPlanYear().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			salesPlanAdmVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			List<SalesPlanAdmVo> dataList = salesPlanAdmService.quarterListNew(salesPlanAdmVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획 분기별조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//매출계획대비실적 조회
	@RequestMapping(value = "/wm/readPerformanceAgainstPlan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readPerformanceAgainstPlan(MonthProductionPlanVo monthProductionPlanVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("매출계획대비실적 조회");				
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + monthProductionPlanVo.getPlanDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			monthProductionPlanVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			List<MonthProductionPlanVo> dataList = monthProductionPlanService.readPerformanceAgainstPlan(monthProductionPlanVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("매출계획대비실적 조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//매출계획대비실적 입력
	@RequestMapping(value = "/wm/createPerformanceAgainstPlan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createPerformanceAgainstPlan(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("매출계획대비실적 입력" + dataList);				
		try {
			String planDateList = "";
			List<MonthProductionPlanVo> list = new ArrayList<MonthProductionPlanVo>();
			MonthProductionPlanVo monthProductionPlanVo = new MonthProductionPlanVo();
			monthProductionPlanVo.setPlanDate(dataList.get(0).get("planDate").toString());
			monthProductionPlanService.deletePerformanceAgainstPlan(monthProductionPlanVo);
			for (Map<String, Object> m : dataList) {
				
				list = new ArrayList<MonthProductionPlanVo>();
				String gubun = m.get("gubun").toString();
				String planDate = m.get("planDate").toString();
				String[] count = new String[12];	
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
			
				
				for(int i = 0; i < 12; i++) {
					monthProductionPlanVo = new MonthProductionPlanVo();
					monthProductionPlanVo.setCnt(count[i]);						
					monthProductionPlanVo.setGubun(gubun);			
					monthProductionPlanVo.setPlanDate(planDate.substring(0,4) + String.format("%02d", i+1));	
					monthProductionPlanVo.setRegId(Utils.getUserId());
		
					if(!"0".equals(count[i])) {
						list.add(monthProductionPlanVo);								
					}
				}	
				if(list.size() != 0) {
					monthProductionPlanService.createPerformanceAgainstPlan(list); //설비별 비가동, 가동시간
				}
				
			}
			
		
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("매출계획대비실적 입력 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	


}