package mes.web.br;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.br.RawMatrlSupplyVo;
import mes.domain.bs.SalesPlanAdmVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.br.RawMatrlSupplyService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class RawMatrlSupplyController {

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private RawMatrlSupplyService rawMatrlSupplyService;
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(RawMatrlSupplyController.class);

	//원자재수급 계획등록 메인
	@RequestMapping(value = "/brsc0010", method = RequestMethod.GET)
	public String brsc0010GET(Locale locale, Model model) throws Exception {

		logger.info("원자재수급 계획등록 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyList", systemCommonCodeList);
		
		MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();	
		List<MatrlCodeAdmVo> matrlCodeList = matrlCodeAdmService.listAll(matrlCodeAdmVo);
		model.addAttribute("matrlCodeList", matrlCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "br/brsc0010";
	}
	
	//원자재수급 관리 메인
	@RequestMapping(value = "/brsc0020", method = RequestMethod.GET)
	public String brsc0020GET(Locale locale, Model model) throws Exception {

		logger.info("원자재수급 관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyList", systemCommonCodeList);
		
		MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();	
		//matrlCodeAdmVo.setDefectCd("004");
		List<MatrlCodeAdmVo> matrlCodeList = matrlCodeAdmService.listAll(matrlCodeAdmVo);
		model.addAttribute("matrlCodeList", matrlCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "br/brsc0020";
	}
	
	
	//원재료 수불 명세서
	@RequestMapping(value = "/brsc0030", method = RequestMethod.GET)
	public String brsc0030GET(Locale locale, Model model) throws Exception {

		logger.info("원재료 수불 명세서");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyList", systemCommonCodeList);
		
		MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();	
		List<MatrlCodeAdmVo> matrlCodeList = matrlCodeAdmService.listAll(matrlCodeAdmVo);
		model.addAttribute("matrlCodeList", matrlCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "br/brsc0030";
	}
		
	//원자재수급 계획등록 목록조회
	@RequestMapping(value = "br/readMonthPlanListAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanListAll(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획등록 목록조회 " + rawMatrlSupplyVo);
		try {
			List<RawMatrlSupplyVo> outputList = new ArrayList<RawMatrlSupplyVo>();
			//String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for (int i = 1; i <= 31; i++) {
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				planDateListSetter[i - 1] = rawMatrlSupplyVo.getPlanDate().toString() + String.format("%02d", i);
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));
			logger.info("planDateListSetter : " + planDateListSetter);
			List<Map<String, String>> list = rawMatrlSupplyService.listAll(rawMatrlSupplyVo);

			
			for (int j=0; j<list.size(); j++) {
				RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
				rawMatrlSupplyVo2.setMatrlCd(list.get(j).get("MATRL_CD").toString());
				rawMatrlSupplyVo2.setMatrlNm(list.get(j).get("MATRL_NM").toString());
				rawMatrlSupplyVo2.setQutyCd(list.get(j).get("QUTY_CD").toString());
				rawMatrlSupplyVo2.setQutyNm(list.get(j).get("QUTY_NM").toString());
				
				//한번이라도 저장하면 0으로라도 저장되어 있음
				if (list.get(j).get("GUBUN_CD") != null) {
					System.out.println(String.valueOf(list.get(j).get("REMAIN_QTY")));
					System.out.println(String.valueOf(list.get(j).get("REMAIN_QTY")).getClass());
					System.out.println(Float.parseFloat(String.valueOf(list.get(j).get("REMAIN_QTY"))));
					
					rawMatrlSupplyVo2.setRemainQty(Float.parseFloat(String.valueOf(list.get(j).get("REMAIN_QTY"))));			
					rawMatrlSupplyVo2.setSumQty(Float.parseFloat(String.valueOf(list.get(j).get("SUM_QTY"))));				
					rawMatrlSupplyVo2.setRollRemain(Integer.parseInt(String.valueOf(list.get(j).get("ROLL_REMAIN"))));				
					rawMatrlSupplyVo2.setRollSum(Integer.parseInt(String.valueOf(list.get(j).get("ROLL_SUM"))));

					float countSum = 0;		//kg 총합
					int countRollSum = 0;	//롤수 총개수
					for (int i = 1; i <= 31; i++) {
						if (list.get(j).get(planDateListSetter[i - 1]) != null) {
							String value = String.valueOf(list.get(j).get(planDateListSetter[i - 1]));
							countSum += Float.parseFloat(value);
						}
						if (list.get(j+1).get(planDateListSetter[i - 1]) != null) {
							String value = String.valueOf(list.get(j+1).get(planDateListSetter[i - 1]));
							countRollSum += Float.parseFloat(value);
						}
					}
					rawMatrlSupplyVo2.setCountSum(countSum);
					rawMatrlSupplyVo2.setCountRollSum(countRollSum);
					
					//Kg
					rawMatrlSupplyVo2.setCount1(String.valueOf(list.get(j).get(planDateListSetter[0])));
					rawMatrlSupplyVo2.setCount2(String.valueOf(list.get(j).get(planDateListSetter[1])));
					rawMatrlSupplyVo2.setCount3(String.valueOf(list.get(j).get(planDateListSetter[2])));
					rawMatrlSupplyVo2.setCount4(String.valueOf(list.get(j).get(planDateListSetter[3])));
					rawMatrlSupplyVo2.setCount5(String.valueOf(list.get(j).get(planDateListSetter[4])));
					rawMatrlSupplyVo2.setCount6(String.valueOf(list.get(j).get(planDateListSetter[5])));
					rawMatrlSupplyVo2.setCount7(String.valueOf(list.get(j).get(planDateListSetter[6])));
					rawMatrlSupplyVo2.setCount8(String.valueOf(list.get(j).get(planDateListSetter[7])));
					rawMatrlSupplyVo2.setCount9(String.valueOf(list.get(j).get(planDateListSetter[8])));
					rawMatrlSupplyVo2.setCount10(String.valueOf(list.get(j).get(planDateListSetter[9])));
					rawMatrlSupplyVo2.setCount11(String.valueOf(list.get(j).get(planDateListSetter[10])));
					rawMatrlSupplyVo2.setCount12(String.valueOf(list.get(j).get(planDateListSetter[11])));
					rawMatrlSupplyVo2.setCount13(String.valueOf(list.get(j).get(planDateListSetter[12])));
					rawMatrlSupplyVo2.setCount14(String.valueOf(list.get(j).get(planDateListSetter[13])));
					rawMatrlSupplyVo2.setCount15(String.valueOf(list.get(j).get(planDateListSetter[14])));
					rawMatrlSupplyVo2.setCount16(String.valueOf(list.get(j).get(planDateListSetter[15])));
					rawMatrlSupplyVo2.setCount17(String.valueOf(list.get(j).get(planDateListSetter[16])));
					rawMatrlSupplyVo2.setCount18(String.valueOf(list.get(j).get(planDateListSetter[17])));
					rawMatrlSupplyVo2.setCount19(String.valueOf(list.get(j).get(planDateListSetter[18])));
					rawMatrlSupplyVo2.setCount20(String.valueOf(list.get(j).get(planDateListSetter[19])));
					rawMatrlSupplyVo2.setCount21(String.valueOf(list.get(j).get(planDateListSetter[20])));
					rawMatrlSupplyVo2.setCount22(String.valueOf(list.get(j).get(planDateListSetter[21])));
					rawMatrlSupplyVo2.setCount23(String.valueOf(list.get(j).get(planDateListSetter[22])));
					rawMatrlSupplyVo2.setCount24(String.valueOf(list.get(j).get(planDateListSetter[23])));
					rawMatrlSupplyVo2.setCount25(String.valueOf(list.get(j).get(planDateListSetter[24])));
					rawMatrlSupplyVo2.setCount26(String.valueOf(list.get(j).get(planDateListSetter[25])));
					rawMatrlSupplyVo2.setCount27(String.valueOf(list.get(j).get(planDateListSetter[26])));
					rawMatrlSupplyVo2.setCount28(String.valueOf(list.get(j).get(planDateListSetter[27])));
					rawMatrlSupplyVo2.setCount29(String.valueOf(list.get(j).get(planDateListSetter[28])));
					rawMatrlSupplyVo2.setCount30(String.valueOf(list.get(j).get(planDateListSetter[29])));
					rawMatrlSupplyVo2.setCount31(String.valueOf(list.get(j).get(planDateListSetter[30])));
					
					//롤수
					rawMatrlSupplyVo2.setRollCount1(String.valueOf(list.get(j+1).get(planDateListSetter[0])));
					rawMatrlSupplyVo2.setRollCount2(String.valueOf(list.get(j+1).get(planDateListSetter[1])));
					rawMatrlSupplyVo2.setRollCount3(String.valueOf(list.get(j+1).get(planDateListSetter[2])));
					rawMatrlSupplyVo2.setRollCount4(String.valueOf(list.get(j+1).get(planDateListSetter[3])));
					rawMatrlSupplyVo2.setRollCount5(String.valueOf(list.get(j+1).get(planDateListSetter[4])));
					rawMatrlSupplyVo2.setRollCount6(String.valueOf(list.get(j+1).get(planDateListSetter[5])));
					rawMatrlSupplyVo2.setRollCount7(String.valueOf(list.get(j+1).get(planDateListSetter[6])));
					rawMatrlSupplyVo2.setRollCount8(String.valueOf(list.get(j+1).get(planDateListSetter[7])));
					rawMatrlSupplyVo2.setRollCount9(String.valueOf(list.get(j+1).get(planDateListSetter[8])));
					rawMatrlSupplyVo2.setRollCount10(String.valueOf(list.get(j+1).get(planDateListSetter[9])));
					rawMatrlSupplyVo2.setRollCount11(String.valueOf(list.get(j+1).get(planDateListSetter[10])));
					rawMatrlSupplyVo2.setRollCount12(String.valueOf(list.get(j+1).get(planDateListSetter[11])));
					rawMatrlSupplyVo2.setRollCount13(String.valueOf(list.get(j+1).get(planDateListSetter[12])));
					rawMatrlSupplyVo2.setRollCount14(String.valueOf(list.get(j+1).get(planDateListSetter[13])));
					rawMatrlSupplyVo2.setRollCount15(String.valueOf(list.get(j+1).get(planDateListSetter[14])));
					rawMatrlSupplyVo2.setRollCount16(String.valueOf(list.get(j+1).get(planDateListSetter[15])));
					rawMatrlSupplyVo2.setRollCount17(String.valueOf(list.get(j+1).get(planDateListSetter[16])));
					rawMatrlSupplyVo2.setRollCount18(String.valueOf(list.get(j+1).get(planDateListSetter[17])));
					rawMatrlSupplyVo2.setRollCount19(String.valueOf(list.get(j+1).get(planDateListSetter[18])));
					rawMatrlSupplyVo2.setRollCount20(String.valueOf(list.get(j+1).get(planDateListSetter[19])));
					rawMatrlSupplyVo2.setRollCount21(String.valueOf(list.get(j+1).get(planDateListSetter[20])));
					rawMatrlSupplyVo2.setRollCount22(String.valueOf(list.get(j+1).get(planDateListSetter[21])));
					rawMatrlSupplyVo2.setRollCount23(String.valueOf(list.get(j+1).get(planDateListSetter[22])));
					rawMatrlSupplyVo2.setRollCount24(String.valueOf(list.get(j+1).get(planDateListSetter[23])));
					rawMatrlSupplyVo2.setRollCount25(String.valueOf(list.get(j+1).get(planDateListSetter[24])));
					rawMatrlSupplyVo2.setRollCount26(String.valueOf(list.get(j+1).get(planDateListSetter[25])));
					rawMatrlSupplyVo2.setRollCount27(String.valueOf(list.get(j+1).get(planDateListSetter[26])));
					rawMatrlSupplyVo2.setRollCount28(String.valueOf(list.get(j+1).get(planDateListSetter[27])));
					rawMatrlSupplyVo2.setRollCount29(String.valueOf(list.get(j+1).get(planDateListSetter[28])));
					rawMatrlSupplyVo2.setRollCount30(String.valueOf(list.get(j+1).get(planDateListSetter[29])));
					rawMatrlSupplyVo2.setRollCount31(String.valueOf(list.get(j+1).get(planDateListSetter[30])));
					
					j++;	//해당 주자재로 등록된 계획있으면 다다음 행으로 넘어감
					
				//저장되어있지 않음
				} else {
					
					//rawMatrlSupplyVo2.setRemainQty(0);
					rawMatrlSupplyVo2.setSumQty(0);
					//rawMatrlSupplyVo2.setRollRemain(0);
					rawMatrlSupplyVo2.setRollSum(0);
					rawMatrlSupplyVo2.setCountSum(0);
					rawMatrlSupplyVo2.setCountRollSum(0);
					rawMatrlSupplyVo2.setRemainQty(Float.parseFloat(String.valueOf(list.get(j).get("REMAIN_QTY"))));	
					rawMatrlSupplyVo2.setRollRemain(Integer.parseInt(String.valueOf(list.get(j).get("ROLL_REMAIN"))));	
					
					//Kg
					rawMatrlSupplyVo2.setCount1("0");
					rawMatrlSupplyVo2.setCount2("0");
					rawMatrlSupplyVo2.setCount3("0");
					rawMatrlSupplyVo2.setCount4("0");
					rawMatrlSupplyVo2.setCount5("0");
					rawMatrlSupplyVo2.setCount6("0");
					rawMatrlSupplyVo2.setCount7("0");
					rawMatrlSupplyVo2.setCount8("0");
					rawMatrlSupplyVo2.setCount9("0");
					rawMatrlSupplyVo2.setCount10("0");
					rawMatrlSupplyVo2.setCount11("0");
					rawMatrlSupplyVo2.setCount12("0");
					rawMatrlSupplyVo2.setCount13("0");
					rawMatrlSupplyVo2.setCount14("0");
					rawMatrlSupplyVo2.setCount15("0");
					rawMatrlSupplyVo2.setCount16("0");
					rawMatrlSupplyVo2.setCount17("0");
					rawMatrlSupplyVo2.setCount18("0");
					rawMatrlSupplyVo2.setCount19("0");
					rawMatrlSupplyVo2.setCount20("0");
					rawMatrlSupplyVo2.setCount21("0");
					rawMatrlSupplyVo2.setCount22("0");
					rawMatrlSupplyVo2.setCount23("0");
					rawMatrlSupplyVo2.setCount24("0");
					rawMatrlSupplyVo2.setCount25("0");
					rawMatrlSupplyVo2.setCount26("0");
					rawMatrlSupplyVo2.setCount27("0");
					rawMatrlSupplyVo2.setCount28("0");
					rawMatrlSupplyVo2.setCount29("0");
					rawMatrlSupplyVo2.setCount30("0");
					rawMatrlSupplyVo2.setCount31("0");
					
					//롤수
					rawMatrlSupplyVo2.setRollCount1("0");
					rawMatrlSupplyVo2.setRollCount2("0");
					rawMatrlSupplyVo2.setRollCount3("0");
					rawMatrlSupplyVo2.setRollCount4("0");
					rawMatrlSupplyVo2.setRollCount5("0");
					rawMatrlSupplyVo2.setRollCount6("0");
					rawMatrlSupplyVo2.setRollCount7("0");
					rawMatrlSupplyVo2.setRollCount8("0");
					rawMatrlSupplyVo2.setRollCount9("0");
					rawMatrlSupplyVo2.setRollCount10("0");
					rawMatrlSupplyVo2.setRollCount11("0");
					rawMatrlSupplyVo2.setRollCount12("0");
					rawMatrlSupplyVo2.setRollCount13("0");
					rawMatrlSupplyVo2.setRollCount14("0");
					rawMatrlSupplyVo2.setRollCount15("0");
					rawMatrlSupplyVo2.setRollCount16("0");
					rawMatrlSupplyVo2.setRollCount17("0");
					rawMatrlSupplyVo2.setRollCount18("0");
					rawMatrlSupplyVo2.setRollCount19("0");
					rawMatrlSupplyVo2.setRollCount20("0");
					rawMatrlSupplyVo2.setRollCount21("0");
					rawMatrlSupplyVo2.setRollCount22("0");
					rawMatrlSupplyVo2.setRollCount23("0");
					rawMatrlSupplyVo2.setRollCount24("0");
					rawMatrlSupplyVo2.setRollCount25("0");
					rawMatrlSupplyVo2.setRollCount26("0");
					rawMatrlSupplyVo2.setRollCount27("0");
					rawMatrlSupplyVo2.setRollCount28("0");
					rawMatrlSupplyVo2.setRollCount29("0");
					rawMatrlSupplyVo2.setRollCount30("0");
					rawMatrlSupplyVo2.setRollCount31("0");
				}
				
				
				outputList.add(rawMatrlSupplyVo2);

			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재수급 계획등록 목록조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//원자재수급 계획등록 등록
	@RequestMapping(value = "/br/insertMonthMatrlList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthMatrlList(@RequestBody List<Map<String, Object>> dataList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획등록 등록 " + dataList);
		RawMatrlSupplyVo rawMatrlSupplyVo = new RawMatrlSupplyVo();
		List<RawMatrlSupplyVo> list = new ArrayList<RawMatrlSupplyVo>();
		try {
			for (Map<String, Object> m : dataList) {
				String matrlCd = m.get("matrlCd").toString();
				String planDate = m.get("planDate").toString();
				String gubunCd = m.get("gubunCd").toString();
				String insertTypeCd = m.get("insertTypeCd").toString();
				float[] count = new float[35];

				rawMatrlSupplyVo = new RawMatrlSupplyVo();
				rawMatrlSupplyVo.setMatrlCd(matrlCd);
				rawMatrlSupplyVo.setPlanDate(planDate.substring(0, 6));
				rawMatrlSupplyVo.setGubunCd(gubunCd);
				rawMatrlSupplyVo.setInsertTypeCd(insertTypeCd);
				rawMatrlSupplyVo.setRegId(Utils.getUserId());
				//rawMatrlSupplyVo.setUpdId(Utils.getUserId());
				rawMatrlSupplyService.delete(rawMatrlSupplyVo);

				count[0] = Float.parseFloat(m.get("count1").toString());
				count[1] = Float.parseFloat(m.get("count2").toString());
				count[2] = Float.parseFloat(m.get("count3").toString());
				count[3] = Float.parseFloat(m.get("count4").toString());
				count[4] = Float.parseFloat(m.get("count5").toString());
				count[5] = Float.parseFloat(m.get("count6").toString());
				count[6] = Float.parseFloat(m.get("count7").toString());
				count[7] = Float.parseFloat(m.get("count8").toString());
				count[8] = Float.parseFloat(m.get("count9").toString());
				count[9] = Float.parseFloat(m.get("count10").toString());
				count[10] = Float.parseFloat(m.get("count11").toString());
				count[11] = Float.parseFloat(m.get("count12").toString());
				count[12] = Float.parseFloat(m.get("count13").toString());
				count[13] = Float.parseFloat(m.get("count14").toString());
				count[14] = Float.parseFloat(m.get("count15").toString());
				count[15] = Float.parseFloat(m.get("count16").toString());
				count[16] = Float.parseFloat(m.get("count17").toString());
				count[17] = Float.parseFloat(m.get("count18").toString());
				count[18] = Float.parseFloat(m.get("count19").toString());
				count[19] = Float.parseFloat(m.get("count20").toString());
				count[20] = Float.parseFloat(m.get("count21").toString());
				count[21] = Float.parseFloat(m.get("count22").toString());
				count[22] = Float.parseFloat(m.get("count23").toString());
				count[23] = Float.parseFloat(m.get("count24").toString());
				count[24] = Float.parseFloat(m.get("count25").toString());
				count[25] = Float.parseFloat(m.get("count26").toString());
				count[26] = Float.parseFloat(m.get("count27").toString());
				count[27] = Float.parseFloat(m.get("count28").toString());
				count[28] = Float.parseFloat(m.get("count29").toString());
				count[29] = Float.parseFloat(m.get("count30").toString());
				count[30] = Float.parseFloat(m.get("count31").toString());
				count[31] = Float.parseFloat(m.get("remainQty").toString());
				count[32] = Float.parseFloat(m.get("sumQty").toString());
				count[33] = Float.parseFloat(m.get("rollRemain").toString());
				count[34] = Float.parseFloat(m.get("rollSum").toString());

				for (int i = 0; i < 31; i++) {
					RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
					rawMatrlSupplyVo2.setMatrlCd(matrlCd);
					rawMatrlSupplyVo2.setPlanDate(planDate.substring(0, 6) + String.format("%02d", i + 1));
					rawMatrlSupplyVo2.setGubunCd(gubunCd);
					rawMatrlSupplyVo2.setCnt(count[i]);
					rawMatrlSupplyVo2.setRemainQty((int)(count[i]));
					rawMatrlSupplyVo2.setRegId(Utils.getUserId());
					rawMatrlSupplyVo2.setUpdId(Utils.getUserId());
					rawMatrlSupplyVo2.setRemainQty(count[31]);
					rawMatrlSupplyVo2.setSumQty(count[32]);
					rawMatrlSupplyVo2.setRollRemain((int)(count[33]));
					rawMatrlSupplyVo2.setRollSum((int)(count[34]));

					rawMatrlSupplyService.create(rawMatrlSupplyVo2);
				}
			}

			jsonData.put("message", "저장되었습니다.");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("원자재수급 계획등록 등록 오류");
			//해당planDate 모두 삭제? 등록일경우 모두삭제하면되는데 수정일경우엔?
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//원자재수급 계획 조회 1-1번
	@RequestMapping(value = "br/readMonthPlanListTab11", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanListTab11(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획 조회 1-1번 목록조회 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyVo.setStartDate(rawMatrlSupplyVo.getPlanDate().toString() + "01");
			LocalDate now = LocalDate.now();
			int toDay = now.getDayOfMonth();
			int month = now.getMonthValue();

			int planMonth = Integer.parseInt(rawMatrlSupplyVo.getPlanDate().toString().substring(rawMatrlSupplyVo.getPlanDate().toString().length()-2,rawMatrlSupplyVo.getPlanDate().toString().length()));
			
			logger.info("현재달 : " + month);
			logger.info("조회달 : " + planMonth);
			logger.info("오늘 : " + toDay);
			
			if(planMonth == month) {
				if(rawMatrlSupplyVo.getDateGubun().equals("1")) {
					rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + "31");
				} else {
					rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + Integer.toString(toDay));
				}				
			} else {
				rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + "31");
			}

			List<RawMatrlSupplyVo> list  = rawMatrlSupplyService.listTab1(rawMatrlSupplyVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재수급 계획 조회 1-1번 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//원자재수급 계획 조회 1-2번
	@RequestMapping(value = "br/readMonthPlanListTab12", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanListTab12(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획 조회 1-2번 목록조회 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyVo.setStartDate(rawMatrlSupplyVo.getPlanDate().toString() + "01");
			LocalDate now = LocalDate.now();
			int toDay = now.getDayOfMonth();
			toDay = toDay - 1;
			
			int planMonth = Integer.parseInt(rawMatrlSupplyVo.getPlanDate().toString().substring(rawMatrlSupplyVo.getPlanDate().toString().length()-2,rawMatrlSupplyVo.getPlanDate().toString().length()));
			int month = now.getMonthValue();
			
			logger.info("현재달 : " + month);
			logger.info("조회달 : " + planMonth);
			logger.info("어제 : " + toDay);
			
			if(planMonth == month) {
				if(rawMatrlSupplyVo.getDateGubun().equals("1")) {
					rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + "31");
				} else {
					rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + Integer.toString(toDay));
				}
				
			} else {
				rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + "31");
			}

			rawMatrlSupplyVo.setEndDate(rawMatrlSupplyVo.getPlanDate().toString() + Integer.toString(toDay));
			
			List<RawMatrlSupplyVo> list  = rawMatrlSupplyService.listTab1(rawMatrlSupplyVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재수급 계획 조회 1-2번 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
		
	//원자재수급 계획 조회 2번
	@RequestMapping(value = "br/readMonthPlanListTab2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanListTab2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획 조회 2번 목록조회 " + rawMatrlSupplyVo);
		try {	
			
			List<RawMatrlSupplyVo> list  = rawMatrlSupplyService.listTab2(rawMatrlSupplyVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재수급 계획 조회 2번 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//원자재수급 계획 조회 3번
	@RequestMapping(value = "br/readMonthPlanListTab3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMonthPlanListTab3(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획 조회 3번 목록조회 " + rawMatrlSupplyVo);
		try {		
			String planDateMonth = rawMatrlSupplyVo.getPlanDate().substring(0,6);
			String planDate = rawMatrlSupplyVo.getPlanDate().toString();
			
			int year =  Integer.parseInt(rawMatrlSupplyVo.getPlanDate().substring(0,4));
			int month = Integer.parseInt(rawMatrlSupplyVo.getPlanDate().substring(4,6));

			
			rawMatrlSupplyVo.setPlanDate(planDateMonth);
			List<RawMatrlSupplyVo> matrlCdList = rawMatrlSupplyService.selectMatrlCd(rawMatrlSupplyVo);
			
			List<RawMatrlSupplyVo> outputList = new ArrayList<RawMatrlSupplyVo>();
			rawMatrlSupplyVo.setStartDate(planDateMonth + "01");	
			rawMatrlSupplyVo.setEndDate(planDate);
			
			Calendar cal = Calendar.getInstance();
			cal.set(year, month - 1, 1);
			cal.add(Calendar.MONTH, -1);    // 한달 전			
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyyMMdd");
			rawMatrlSupplyVo.setLastMonthStart(dateFormatter.format(cal.getTime()));			
			rawMatrlSupplyVo.setLastMonthEnd(dateFormatter.format(cal.getTime()).substring(0,6)+"31");
			
			
			String codeList = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for(int i=1; i <= 31; i++) {
				
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";				
				planDateListSetter[i-1] = rawMatrlSupplyVo.getPlanDate().toString() + String.format("%02d", i);
			}
			
			if(matrlCdList.size() == 0) {
				codeList = "\'\',";
			} else {
				for(RawMatrlSupplyVo m : matrlCdList) {				
					codeList += "\'";
					codeList += m.getMatrlCd();
					codeList += "\',";			
				}
			}

			logger.info("원자재수급 계획 조회 3번 값조회 " + codeList + planDateList);
			rawMatrlSupplyVo.setCodeList(codeList.substring(0,codeList.length()-1));
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0,planDateList.length()-1));
			
			List<Map<String, String>> list  = rawMatrlSupplyService.listTab3(rawMatrlSupplyVo);			
			
			float planSum = 0;
			float inputSum = 0;
			float outputSum = 0;
			
			for(Map<String, String> m : list) {
				RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
				
				rawMatrlSupplyVo2.setGubunja(m.get("GUBUNJA").toString());
				rawMatrlSupplyVo2.setGubunja2(m.get("GUBUNJA2").toString());
				rawMatrlSupplyVo2.setMatrlCd(m.get("MATRL_CD").toString());
				rawMatrlSupplyVo2.setMatrlNm(m.get("MATRL_NM").toString());
				rawMatrlSupplyVo2.setTotalQty(String.valueOf(m.get("TOTAL_QTY"))); //당월재고 + 당원생산실 재고
				rawMatrlSupplyVo2.setRemainQtyTotal(String.valueOf(m.get("REMAIN_QTY"))); //전월재고 + 전월 생산실재고
				rawMatrlSupplyVo2.setSumQtyTotal(String.valueOf(m.get("SUM_QTY"))); //당월 생산실 재고
				rawMatrlSupplyVo2.setFaultyQty(String.valueOf(m.get("FAULTY_QTY"))); //실반품수량
				rawMatrlSupplyVo2.setResultQty(String.valueOf(m.get("RESULT_QTY"))); //현월 생산실 재고
		
				
				if(m.get("SUM_REMAIN") != null) { //전월재고 + 전월 생산실재고 
					rawMatrlSupplyVo2.setSumRemain(String.valueOf(m.get("SUM_REMAIN")));
				} else {
					rawMatrlSupplyVo2.setSumRemain("0");
				}
				
				float countSum = 0;
				
				
				for(int i=1; i <= 31; i++) {
					if(m.get(planDateListSetter[i-1]) != null) {
						String value = String.valueOf(m.get(planDateListSetter[i-1]));
						countSum +=Float.parseFloat(value);
					} else {
						countSum += 0;
					}
					
				}
			//	if(rawMatrlSupplyVo2.getGubunja().equals("1")) {
			//		planSum = countSum;
			//	}
			//	if(rawMatrlSupplyVo2.getGubunja().equals("2")) {
			//		inputSum = countSum;
			//	}
				if(rawMatrlSupplyVo2.getGubunja().equals("6")) {
					rawMatrlSupplyVo2.setSumQtyTotal("-" + rawMatrlSupplyVo2.getResultQty());
					countSum = countSum + ( Float.parseFloat(rawMatrlSupplyVo2.getSumRemain()) - Float.parseFloat(rawMatrlSupplyVo2.getResultQty()));
					logger.info("tttttttttttttttttttt" + countSum);
					logger.info("qqqqqqqqqqqqqqqqqqqq" + Float.parseFloat(rawMatrlSupplyVo2.getResultQty()));
					logger.info("zzzzzzzzzzzzzzzzzzz" + Float.parseFloat(rawMatrlSupplyVo2.getSumRemain()));
				}
				if(rawMatrlSupplyVo2.getGubunja().equals("7")) {
					rawMatrlSupplyVo2.setSumQtyTotal("-" + rawMatrlSupplyVo2.getResultQty());
					countSum = countSum + (Float.parseFloat(rawMatrlSupplyVo2.getSumRemain()) - Float.parseFloat(rawMatrlSupplyVo2.getResultQty()));
					logger.info("tttttttttttttttttttt111111111111111111" + countSum);
				}
			//	if(rawMatrlSupplyVo2.getGubunja().equals("8")) {					
			//		rawMatrlSupplyVo2.setCountSum((inputSum*100)/planSum);
			//	} 
			//	if(rawMatrlSupplyVo2.getGubunja().equals("9")) {
			//		rawMatrlSupplyVo2.setCountSum(Float.parseFloat(rawMatrlSupplyVo2.getSumRemain()));
			//	}
			//	else {
					rawMatrlSupplyVo2.setCountSum(countSum);
			//	}
				
				
				
				
		
				rawMatrlSupplyVo2.setCount1(String.valueOf(m.get(planDateListSetter[0])));
				rawMatrlSupplyVo2.setCount2(String.valueOf(m.get(planDateListSetter[1])));
				rawMatrlSupplyVo2.setCount3(String.valueOf(m.get(planDateListSetter[2])));
				rawMatrlSupplyVo2.setCount4(String.valueOf(m.get(planDateListSetter[3])));
				rawMatrlSupplyVo2.setCount5(String.valueOf(m.get(planDateListSetter[4])));
				rawMatrlSupplyVo2.setCount6(String.valueOf(m.get(planDateListSetter[5])));
				rawMatrlSupplyVo2.setCount7(String.valueOf(m.get(planDateListSetter[6])));
				rawMatrlSupplyVo2.setCount8(String.valueOf(m.get(planDateListSetter[7])));
				rawMatrlSupplyVo2.setCount9(String.valueOf(m.get(planDateListSetter[8])));
				rawMatrlSupplyVo2.setCount10(String.valueOf(m.get(planDateListSetter[9])));
				rawMatrlSupplyVo2.setCount11(String.valueOf(m.get(planDateListSetter[10])));
				rawMatrlSupplyVo2.setCount12(String.valueOf(m.get(planDateListSetter[11])));
				rawMatrlSupplyVo2.setCount13(String.valueOf(m.get(planDateListSetter[12])));
				rawMatrlSupplyVo2.setCount14(String.valueOf(m.get(planDateListSetter[13])));
				rawMatrlSupplyVo2.setCount15(String.valueOf(m.get(planDateListSetter[14])));
				rawMatrlSupplyVo2.setCount16(String.valueOf(m.get(planDateListSetter[15])));
				rawMatrlSupplyVo2.setCount17(String.valueOf(m.get(planDateListSetter[16])));
				rawMatrlSupplyVo2.setCount18(String.valueOf(m.get(planDateListSetter[17])));
				rawMatrlSupplyVo2.setCount19(String.valueOf(m.get(planDateListSetter[18])));
				rawMatrlSupplyVo2.setCount20(String.valueOf(m.get(planDateListSetter[19])));
				rawMatrlSupplyVo2.setCount21(String.valueOf(m.get(planDateListSetter[20])));
				rawMatrlSupplyVo2.setCount22(String.valueOf(m.get(planDateListSetter[21])));
				rawMatrlSupplyVo2.setCount23(String.valueOf(m.get(planDateListSetter[22])));
				rawMatrlSupplyVo2.setCount24(String.valueOf(m.get(planDateListSetter[23])));
				rawMatrlSupplyVo2.setCount25(String.valueOf(m.get(planDateListSetter[24])));
				rawMatrlSupplyVo2.setCount26(String.valueOf(m.get(planDateListSetter[25])));
				rawMatrlSupplyVo2.setCount27(String.valueOf(m.get(planDateListSetter[26])));
				rawMatrlSupplyVo2.setCount28(String.valueOf(m.get(planDateListSetter[27])));
				rawMatrlSupplyVo2.setCount29(String.valueOf(m.get(planDateListSetter[28])));
				rawMatrlSupplyVo2.setCount30(String.valueOf(m.get(planDateListSetter[29])));
				rawMatrlSupplyVo2.setCount31(String.valueOf(m.get(planDateListSetter[30])));
			
				
				outputList.add(rawMatrlSupplyVo2);	
				
				
			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
			
			
		} catch (Exception e) {
			logger.info("원자재수급 계획 조회 3번 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//구매량 리스트 조회
	@RequestMapping(value = "br/readMatrlCodeListWithBuyCnt", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithBuyCnt(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("구매량 리스트 조회 " + rawMatrlSupplyVo);
		try {		
			List<RawMatrlSupplyVo> outputList = new ArrayList<RawMatrlSupplyVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[12];
			for(int i=1; i <= 12; i++) {
				
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4);
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4) + String.format("%02d", i);
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0,planDateList.length()-1));
			logger.info("구매량 리스트 조회 " + rawMatrlSupplyVo.getPlanDateList());
			List<Map<String, String>> list  = rawMatrlSupplyService.listAll2(rawMatrlSupplyVo);
			RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
			
			for(Map<String, String> m : list) {		
				rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
				rawMatrlSupplyVo2.setMatrlCd(m.get("MATRL_CD").toString());
				rawMatrlSupplyVo2.setMatrlNm(m.get("MATRL_NM").toString());	
				if(m.get(planDateListSetter[0]) != null) {					
					
					rawMatrlSupplyVo2.setCount1(String.valueOf(m.get(planDateListSetter[0])));
					rawMatrlSupplyVo2.setCount2(String.valueOf(m.get(planDateListSetter[1])));
					rawMatrlSupplyVo2.setCount3(String.valueOf(m.get(planDateListSetter[2])));
					rawMatrlSupplyVo2.setCount4(String.valueOf(m.get(planDateListSetter[3])));
					rawMatrlSupplyVo2.setCount5(String.valueOf(m.get(planDateListSetter[4])));
					rawMatrlSupplyVo2.setCount6(String.valueOf(m.get(planDateListSetter[5])));
					rawMatrlSupplyVo2.setCount7(String.valueOf(m.get(planDateListSetter[6])));
					rawMatrlSupplyVo2.setCount8(String.valueOf(m.get(planDateListSetter[7])));
					rawMatrlSupplyVo2.setCount9(String.valueOf(m.get(planDateListSetter[8])));
					rawMatrlSupplyVo2.setCount10(String.valueOf(m.get(planDateListSetter[9])));
					rawMatrlSupplyVo2.setCount11(String.valueOf(m.get(planDateListSetter[10])));
					rawMatrlSupplyVo2.setCount12(String.valueOf(m.get(planDateListSetter[11])));

				} else {
					rawMatrlSupplyVo2.setCount1("0");
					rawMatrlSupplyVo2.setCount2("0");
					rawMatrlSupplyVo2.setCount3("0");
					rawMatrlSupplyVo2.setCount4("0");
					rawMatrlSupplyVo2.setCount5("0");
					rawMatrlSupplyVo2.setCount6("0");
					rawMatrlSupplyVo2.setCount7("0");
					rawMatrlSupplyVo2.setCount8("0");
					rawMatrlSupplyVo2.setCount9("0");
					rawMatrlSupplyVo2.setCount10("0");
					rawMatrlSupplyVo2.setCount11("0");
					rawMatrlSupplyVo2.setCount12("0");
				
				}
				
				outputList.add(rawMatrlSupplyVo2);
			}			
			
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("구매량 리스트 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//구매량 상세 조회
	@RequestMapping(value = "br/readMatrlCodeListWithBuyCntRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithBuyCntRead(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("구매량 상세 조회 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyVo = rawMatrlSupplyService.read(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("구매량 리스트 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//구매량 등록
	@RequestMapping(value = "br/readMatrlCodeListWithBuyCntCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithBuyCntCreate(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		RawMatrlSupplyVo rawMatrlSupplyVo = new RawMatrlSupplyVo();	
		List<RawMatrlSupplyVo> list = new ArrayList<RawMatrlSupplyVo>();	
		logger.info("구매량 등록 " + rawMatrlSupplyVo);
		try {	
			
			float[] count = new float[12];
			
			for (Map<String, Object> m : dataList) {
				
				String matrlCd	= m.get("matrlCd").toString();
				String planDate	= m.get("planDate").toString();
				
				count[0]	= Float.parseFloat(m.get("count1").toString());
				count[1]	= Float.parseFloat(m.get("count2").toString());
				count[2]	= Float.parseFloat(m.get("count3").toString());
				count[3]	= Float.parseFloat(m.get("count4").toString());
				count[4]	= Float.parseFloat(m.get("count5").toString());
				count[5]	= Float.parseFloat(m.get("count6").toString());
				count[6]	= Float.parseFloat(m.get("count7").toString());
				count[7]	= Float.parseFloat(m.get("count8").toString());
				count[8]	= Float.parseFloat(m.get("count9").toString());
				count[9]	= Float.parseFloat(m.get("count10").toString());
				count[10]	= Float.parseFloat(m.get("count11").toString());
				count[11]	= Float.parseFloat(m.get("count12").toString());
				
				rawMatrlSupplyVo = new RawMatrlSupplyVo();	
				rawMatrlSupplyVo.setMatrlCd(matrlCd);
				rawMatrlSupplyVo.setPlanDate(planDate.substring(0,4));
				rawMatrlSupplyVo.setRegId(Utils.getUserId());
				rawMatrlSupplyService.delete2(rawMatrlSupplyVo);
				
				for(int i = 0; i < 12; i++) {
					RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();	
					rawMatrlSupplyVo2.setMatrlCd(matrlCd);
					rawMatrlSupplyVo2.setPlanDate(planDate.substring(0,4) + String.format("%02d", i+1));
					rawMatrlSupplyVo2.setCnt((count[i]));
					rawMatrlSupplyVo2.setRegId(Utils.getUserId());
					rawMatrlSupplyVo2.setUpdId(Utils.getUserId());
					rawMatrlSupplyService.create2(rawMatrlSupplyVo2);
					
				}
			}			
		
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("구매량 등록 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//구매량 삭제
	@RequestMapping(value = "br/readMatrlCodeListWithBuyCntDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithBuyCntDelete(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("구매량삭제 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyService.delete2(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("구매량 삭제 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//구매량 수정
	@RequestMapping(value = "br/readMatrlCodeListWithBuyCntUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithBuyCntUpdate(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("구매량 수정 " + rawMatrlSupplyVo);
		try {		
			 rawMatrlSupplyVo.setUpdId(Utils.getUserId());
			rawMatrlSupplyService.update2(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("구매량 수정 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//수율 리스트 조회
	@RequestMapping(value = "br/readMatrlCodeListWithYieldCnt", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithYieldCnt(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수율 리스트 조회 " + rawMatrlSupplyVo);
		try {		
			List<RawMatrlSupplyVo> outputList = new ArrayList<RawMatrlSupplyVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[12];
			for(int i=1; i <= 12; i++) {
				
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4);
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4) + String.format("%02d", i);
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0,planDateList.length()-1));
			logger.info("수율 리스트 조회 " + rawMatrlSupplyVo.getPlanDateList());
			List<Map<String, String>> list  = rawMatrlSupplyService.listAllYield(rawMatrlSupplyVo);
			RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
			
			for(Map<String, String> m : list) {		
				rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
				rawMatrlSupplyVo2.setMatrlCd(m.get("MATRL_CD").toString());
				rawMatrlSupplyVo2.setMatrlNm(m.get("MATRL_NM").toString());	
				if(m.get(planDateListSetter[0]) != null) {					
					
					rawMatrlSupplyVo2.setCount1(String.valueOf(m.get(planDateListSetter[0])));
					rawMatrlSupplyVo2.setCount2(String.valueOf(m.get(planDateListSetter[1])));
					rawMatrlSupplyVo2.setCount3(String.valueOf(m.get(planDateListSetter[2])));
					rawMatrlSupplyVo2.setCount4(String.valueOf(m.get(planDateListSetter[3])));
					rawMatrlSupplyVo2.setCount5(String.valueOf(m.get(planDateListSetter[4])));
					rawMatrlSupplyVo2.setCount6(String.valueOf(m.get(planDateListSetter[5])));
					rawMatrlSupplyVo2.setCount7(String.valueOf(m.get(planDateListSetter[6])));
					rawMatrlSupplyVo2.setCount8(String.valueOf(m.get(planDateListSetter[7])));
					rawMatrlSupplyVo2.setCount9(String.valueOf(m.get(planDateListSetter[8])));
					rawMatrlSupplyVo2.setCount10(String.valueOf(m.get(planDateListSetter[9])));
					rawMatrlSupplyVo2.setCount11(String.valueOf(m.get(planDateListSetter[10])));
					rawMatrlSupplyVo2.setCount12(String.valueOf(m.get(planDateListSetter[11])));

				} else {
					rawMatrlSupplyVo2.setCount1("0");
					rawMatrlSupplyVo2.setCount2("0");
					rawMatrlSupplyVo2.setCount3("0");
					rawMatrlSupplyVo2.setCount4("0");
					rawMatrlSupplyVo2.setCount5("0");
					rawMatrlSupplyVo2.setCount6("0");
					rawMatrlSupplyVo2.setCount7("0");
					rawMatrlSupplyVo2.setCount8("0");
					rawMatrlSupplyVo2.setCount9("0");
					rawMatrlSupplyVo2.setCount10("0");
					rawMatrlSupplyVo2.setCount11("0");
					rawMatrlSupplyVo2.setCount12("0");
				
				}
				
				outputList.add(rawMatrlSupplyVo2);
			}			
			
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수율 리스트 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//수율 상세 조회
	@RequestMapping(value = "br/readMatrlCodeListWithYieldCntRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithYieldCntRead(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수율 상세 조회 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyVo = rawMatrlSupplyService.readYield(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수율 상세 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//수율 등록
	@RequestMapping(value = "br/readMatrlCodeListWithYieldCntCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithYieldCntCreate(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		RawMatrlSupplyVo rawMatrlSupplyVo = new RawMatrlSupplyVo();	
		List<RawMatrlSupplyVo> list = new ArrayList<RawMatrlSupplyVo>();	
		logger.info("수율 등록 " + rawMatrlSupplyVo);
		try {	
			
			float[] count = new float[12];
			
			for (Map<String, Object> m : dataList) {
				
				String matrlCd	= m.get("matrlCd").toString();
				String planDate	= m.get("planDate").toString();
				
				count[0]	= Float.parseFloat(m.get("count1").toString());
				count[1]	= Float.parseFloat(m.get("count2").toString());
				count[2]	= Float.parseFloat(m.get("count3").toString());
				count[3]	= Float.parseFloat(m.get("count4").toString());
				count[4]	= Float.parseFloat(m.get("count5").toString());
				count[5]	= Float.parseFloat(m.get("count6").toString());
				count[6]	= Float.parseFloat(m.get("count7").toString());
				count[7]	= Float.parseFloat(m.get("count8").toString());
				count[8]	= Float.parseFloat(m.get("count9").toString());
				count[9]	= Float.parseFloat(m.get("count10").toString());
				count[10]	= Float.parseFloat(m.get("count11").toString());
				count[11]	= Float.parseFloat(m.get("count12").toString());
				
				rawMatrlSupplyVo = new RawMatrlSupplyVo();	
				rawMatrlSupplyVo.setMatrlCd(matrlCd);
				rawMatrlSupplyVo.setPlanDate(planDate.substring(0,4));
				rawMatrlSupplyVo.setRegId(Utils.getUserId());
				rawMatrlSupplyService.deleteYield(rawMatrlSupplyVo);
				
				for(int i = 0; i < 12; i++) {
					RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();	
					rawMatrlSupplyVo2.setMatrlCd(matrlCd);
					rawMatrlSupplyVo2.setPlanDate(planDate.substring(0,4) + String.format("%02d", i+1));
					rawMatrlSupplyVo2.setCnt((count[i]));
					rawMatrlSupplyVo2.setRegId(Utils.getUserId());
					rawMatrlSupplyVo2.setUpdId(Utils.getUserId());
					rawMatrlSupplyService.createYield(rawMatrlSupplyVo2);
					
				}
			}			
		
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수율 등록 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//수율 삭제
	@RequestMapping(value = "br/readMatrlCodeListWithYieldCntDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithYieldCntDelete(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수율 삭제 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyService.deleteYield(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수율 삭제 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//수율 수정
	@RequestMapping(value = "br/readMatrlCodeListWithYieldCntUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithYieldCntUpdate(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수율 수정 " + rawMatrlSupplyVo);
		try {		
			 rawMatrlSupplyVo.setUpdId(Utils.getUserId());
			rawMatrlSupplyService.updateYield(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수율 수정 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
		
	//단가 리스트 조회
	@RequestMapping(value = "br/readMatrlCodeListWithPrice", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("단가 리스트 조회 " + rawMatrlSupplyVo);
		try {		
			
			List<RawMatrlSupplyVo> outputList = new ArrayList<RawMatrlSupplyVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[12];
			for(int i=1; i <= 12; i++) {
				
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4);
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = rawMatrlSupplyVo.getPlanDate().toString().substring(0, 4) + String.format("%02d", i);
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0,planDateList.length()-1));
			logger.info("단가 리스트 조회 " + rawMatrlSupplyVo.getPlanDateList());
			List<Map<String, String>> list  = rawMatrlSupplyService.listMatrlPrice(rawMatrlSupplyVo);
			RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
			
			for(Map<String, String> m : list) {		
				rawMatrlSupplyVo2 = new RawMatrlSupplyVo();
				rawMatrlSupplyVo2.setMatrlCd(m.get("MATRL_CD").toString());
				rawMatrlSupplyVo2.setMatrlNm(m.get("MATRL_NM").toString());	
				if(m.get(planDateListSetter[0]) != null) {	
					
					
					
					rawMatrlSupplyVo2.setCount1(String.valueOf(m.get(planDateListSetter[0])));
					rawMatrlSupplyVo2.setCount2(String.valueOf(m.get(planDateListSetter[1])));
					rawMatrlSupplyVo2.setCount3(String.valueOf(m.get(planDateListSetter[2])));
					rawMatrlSupplyVo2.setCount4(String.valueOf(m.get(planDateListSetter[3])));
					rawMatrlSupplyVo2.setCount5(String.valueOf(m.get(planDateListSetter[4])));
					rawMatrlSupplyVo2.setCount6(String.valueOf(m.get(planDateListSetter[5])));
					rawMatrlSupplyVo2.setCount7(String.valueOf(m.get(planDateListSetter[6])));
					rawMatrlSupplyVo2.setCount8(String.valueOf(m.get(planDateListSetter[7])));
					rawMatrlSupplyVo2.setCount9(String.valueOf(m.get(planDateListSetter[8])));
					rawMatrlSupplyVo2.setCount10(String.valueOf(m.get(planDateListSetter[9])));
					rawMatrlSupplyVo2.setCount11(String.valueOf(m.get(planDateListSetter[10])));
					rawMatrlSupplyVo2.setCount12(String.valueOf(m.get(planDateListSetter[11])));

				} else {
					rawMatrlSupplyVo2.setCount1("0");
					rawMatrlSupplyVo2.setCount2("0");
					rawMatrlSupplyVo2.setCount3("0");
					rawMatrlSupplyVo2.setCount4("0");
					rawMatrlSupplyVo2.setCount5("0");
					rawMatrlSupplyVo2.setCount6("0");
					rawMatrlSupplyVo2.setCount7("0");
					rawMatrlSupplyVo2.setCount8("0");
					rawMatrlSupplyVo2.setCount9("0");
					rawMatrlSupplyVo2.setCount10("0");
					rawMatrlSupplyVo2.setCount11("0");
					rawMatrlSupplyVo2.setCount12("0");
				
				}
				
				outputList.add(rawMatrlSupplyVo2);
			}
			
			
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("단가 리스트 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//단가 상세 조회
	@RequestMapping(value = "br/readMatrlCodeListWithPriceRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithPriceRead(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("단가 상세 조회 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyVo = rawMatrlSupplyService.readMatrlPrice(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("단가 리스트 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//단가 등록
	@RequestMapping(value = "br/readMatrlCodeListWithPriceCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithPriceCreate(@RequestBody List<Map<String, Object>> dataList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		RawMatrlSupplyVo rawMatrlSupplyVo = new RawMatrlSupplyVo();	
		List<RawMatrlSupplyVo> list = new ArrayList<RawMatrlSupplyVo>();	
		logger.info("단가 등록 " + dataList);
		try {	
			int[] count = new int[12];
			
			for (Map<String, Object> m : dataList) {
				String matrlCd = m.get("matrlCd").toString();
				String planDate = m.get("planDate").toString();
				
				count[0]= Integer.parseInt(m.get("count1").toString());
				count[1]= Integer.parseInt(m.get("count2").toString());
				count[2]= Integer.parseInt(m.get("count3").toString());
				count[3]= Integer.parseInt(m.get("count4").toString());
				count[4]= Integer.parseInt(m.get("count5").toString());
				count[5]= Integer.parseInt(m.get("count6").toString());
				count[6]= Integer.parseInt(m.get("count7").toString());
				count[7]= Integer.parseInt(m.get("count8").toString());
				count[8]= Integer.parseInt(m.get("count9").toString());
				count[9] = Integer.parseInt(m.get("count10").toString());
				count[10] = Integer.parseInt(m.get("count11").toString());
				count[11] = Integer.parseInt(m.get("count12").toString());
				
				rawMatrlSupplyVo = new RawMatrlSupplyVo();	
				rawMatrlSupplyVo.setMatrlCd(matrlCd);
				rawMatrlSupplyVo.setPlanDate(planDate.substring(0,4));
				rawMatrlSupplyVo.setRegId(Utils.getUserId());
				rawMatrlSupplyService.deleteMatrlPrice(rawMatrlSupplyVo);
				
				for(int i = 0; i < 12; i++) {
					RawMatrlSupplyVo rawMatrlSupplyVo2 = new RawMatrlSupplyVo();	
					rawMatrlSupplyVo2.setMatrlCd(matrlCd);
					rawMatrlSupplyVo2.setPlanDate(planDate.substring(0,4) + String.format("%02d", i+1));					
					rawMatrlSupplyVo2.setPrice(Integer.toString(count[i]));	
					rawMatrlSupplyVo2.setRegId(Utils.getUserId());
					rawMatrlSupplyVo2.setUpdId(Utils.getUserId());
					rawMatrlSupplyService.createMatrlPrice(rawMatrlSupplyVo2);
					
				}
			}		
		
	
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("단가 등록 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//단가 삭제
	@RequestMapping(value = "br/readMatrlCodeListWithPriceDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithPriceDelete(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("단가삭제 " + rawMatrlSupplyVo);
		try {		
			rawMatrlSupplyService.deleteMatrlPrice(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("단가 삭제 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//단가 수정
	@RequestMapping(value = "br/readMatrlCodeListWithPriceUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMatrlCodeListWithPriceUpdate(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("단가 수정 " + rawMatrlSupplyVo);
		try {		
			 rawMatrlSupplyVo.setUpdId(Utils.getUserId());
			rawMatrlSupplyService.updateMatrlPrice(rawMatrlSupplyVo);
			
			jsonData.put("data", rawMatrlSupplyVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("단가 수정 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//원자재 수불 명세서 조회
	@RequestMapping(value = "br/readRawMatrlInOutList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readRawMatrlInOutList(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재 수불 명세서 조회 " + rawMatrlSupplyVo);
		try {		
			List<RawMatrlSupplyVo> list  = rawMatrlSupplyService.listRawMartl(rawMatrlSupplyVo);
			
			for(RawMatrlSupplyVo m : list) {
				m.setPreInWhsQtyTotal(new BigDecimal(m.getPreInWhsQtyTotal()).toPlainString());
				m.setPreInWhsQty(new BigDecimal(m.getPreInWhsQty()).toPlainString());
				
				m.setPreOutWhsQtyTotal(new BigDecimal(m.getPreOutWhsQtyTotal()).toPlainString());
				m.setPreOutWhsQty(new BigDecimal(m.getPreOutWhsQty()).toPlainString());
				
				m.setRemainQtyTotal(new BigDecimal(m.getRemainQtyTotal()).toPlainString());			
				
				m.setResultQtyTotal(new BigDecimal(m.getResultQtyTotal()).toPlainString());
				m.setResultQty(new BigDecimal(m.getResultQty()).toPlainString());
				
				m.setSumQtyTotal(new BigDecimal(m.getSumQtyTotal()).toPlainString());
			}
			
			
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재 수불 명세서 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
		
	
	//자재수급관리 실적관리
	@RequestMapping(value = "/br/performanceMatrl", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> performanceMatrl(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재수급관리 실적관리");				
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString().substring(0,4);
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			List<RawMatrlSupplyVo> dataList = rawMatrlSupplyService.performanceMatrl(rawMatrlSupplyVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("자재수급관리 실적관리 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//자재수급관리 생산대비사용율
	@RequestMapping(value = "/br/performanceMatrl2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> performanceMatrl2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재수급관리 실적관리");				
		try {
			String planDateList = "";
			for (int i = 1; i <= 12; i++) {
				planDateList += "[" + rawMatrlSupplyVo.getPlanDate().toString().substring(0,4);
				planDateList += String.format("%02d", i);
				planDateList += "],";				
			}
			rawMatrlSupplyVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));			
			List<RawMatrlSupplyVo> dataList = rawMatrlSupplyService.performanceMatrl2(rawMatrlSupplyVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("자재수급관리 실적관리 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//원자재 수불 명세서 누적 조회
	@RequestMapping(value = "br/readRawMatrlInOutListSum", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readRawMatrlInOutListSum(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재 수불 명세서 누적 조회 " + rawMatrlSupplyVo);
		try {		
			List<RawMatrlSupplyVo> list  = rawMatrlSupplyService.listRawMartlSum(rawMatrlSupplyVo);
			
			for(RawMatrlSupplyVo m : list) {
				m.setPreInWhsQtyTotal(new BigDecimal(m.getPreInWhsQtyTotal()).toPlainString());
				m.setPreInWhsQty(new BigDecimal(m.getPreInWhsQty()).toPlainString());
				
				m.setPreOutWhsQtyTotal(new BigDecimal(m.getPreOutWhsQtyTotal()).toPlainString());
				m.setPreOutWhsQty(new BigDecimal(m.getPreOutWhsQty()).toPlainString());
				
				m.setRemainQtyTotal(new BigDecimal(m.getRemainQtyTotal()).toPlainString());			
				
				m.setResultQtyTotal(new BigDecimal(m.getResultQtyTotal()).toPlainString());
				m.setResultQty(new BigDecimal(m.getResultQty()).toPlainString());
				
				m.setSumQtyTotal(new BigDecimal(m.getSumQtyTotal()).toPlainString());
			}
			
			
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("원자재 수불 명세서 누적 조회 에러발생");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
		
	


}