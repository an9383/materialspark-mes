package mes.web.wm;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.br.RawMatrlSupplyVo;
import mes.domain.po.EquipDowntimeAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.EquipDowntimeAdmService;
import mes.service.po.WorkOrderService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class OperationController {

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipDowntimeAdmService equipDowntimeAdmService;
	@Inject
	private WorkOrderService workOrderService;

	private static final Logger logger = LoggerFactory.getLogger(OperationController.class);

	//생산관리 - 설비가동/비가동관리
	@RequestMapping(value = "/wmsc0050", method = RequestMethod.GET)
	public String wmsc0050GET(Locale locale, Model model) throws Exception {

		logger.info("설비가동/비가동관리메인");

		String todate = DateUtil.getToday("yyyy-mm-dd");
		model.addAttribute("serverDate", todate);

		return "wm/wmsc0050";
	}
	
	//생산관리 - 작업일보관리
	@RequestMapping(value = "/wmsc0030", method = RequestMethod.GET)
	public String workDayListGET(Locale locale, Model model) throws Exception {

		logger.info("작업일보 메인");
		String todate = DateUtil.getToday("yyyy-mm-dd");
		String dateFrom = DateUtil.getDay("yyyy-mm-dd", -6);
				
		model.addAttribute("serverDateFrom", dateFrom);
		model.addAttribute("serverDate", todate);

		return "wm/wmsc0030";
	}

	//해당설비&해당날짜 작업지시 조회
	@RequestMapping(value = "/wm/operationDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderPlanListGET(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유 전체 조회");

		String Code = "";
		try {
			List<EquipDowntimeAdmVo> equipDowntimeAdmList = equipDowntimeAdmService.operationListAll(equipDowntimeAdmVo);
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("012"); // 조편성
			List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);

			if (equipDowntimeAdmList != null) {
				for (EquipDowntimeAdmVo m : equipDowntimeAdmList) {
					if (m.getCode1().equals("Y")) {
						Code = " " + systemCommonCodeList.get(0).getBaseCdNm();
					} else if (m.getCode2().equals("Y")) {
						Code += " " + systemCommonCodeList.get(1).getBaseCdNm();
					} else if (m.getCode3().equals("Y")) {
						Code += " " + systemCommonCodeList.get(2).getBaseCdNm();
					} else if (m.getCode4().equals("Y")) {
						Code += " " + systemCommonCodeList.get(3).getBaseCdNm();
					} else if (m.getCode5().equals("Y")) {
						Code += " " + systemCommonCodeList.get(4).getBaseCdNm();
					} else if (m.getCode6().equals("Y")) {
						Code += " " + systemCommonCodeList.get(5).getBaseCdNm();
					} else if (m.getCode7().equals("Y")) {
						Code += " " + systemCommonCodeList.get(6).getBaseCdNm();
					}

					m.setCode(Code);
				}
			}
			jsonData.put("data", equipDowntimeAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유 전체 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//작업일보 목록 조회
	@RequestMapping(value = "/wm/workDayDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workDayDataList(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업일보 목록조회");
	
		try {
			List<WorkOrderVo> workOrderList = workOrderService.operationList(workOrderVo);
			
			jsonData.put("data", workOrderList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업일보 목록조회 실패");
			e.printStackTrace();
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//제품(원재고현황)
	@RequestMapping(value = "/wmsc0130", method = RequestMethod.GET)
	public String wmsc0130(Locale locale, Model model) throws Exception {
		
		logger.info("설비 월별 가동률");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "wm/wmsc0130";
	}
	
	
	//설비 월별 가동률
	@RequestMapping(value = "wm/readEquipOperationBody", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readEquipOperationBody(EquipDowntimeAdmVo getEquipDowntimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("원자재수급 계획등록 목록조회 " + getEquipDowntimeAdmVo);
		try {
			List<EquipDowntimeAdmVo> outputList = new ArrayList<EquipDowntimeAdmVo>();
			String[] planDateListSetter = new String[32];
			planDateListSetter[31] = "ORD_DATE_TOTAL";
			String planDateList = "[ORD_DATE_TOTAL], ";
			
			String getMonth = getEquipDowntimeAdmVo.getPlanDate().toString();
			int year = Integer.parseInt(Utils.left(getMonth, 4));
			int month = Integer.parseInt(Utils.right(getMonth, 2));
			int lastDay = 0;
			Calendar cal = Calendar.getInstance();
			cal.set(year, month - 1, 1);
			lastDay = cal.getActualMaximum(Calendar.DATE);
			
			for (int i = 1; i <= 31; i++) {
				planDateList += "[" + getEquipDowntimeAdmVo.getPlanDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				planDateListSetter[i-1] = getEquipDowntimeAdmVo.getPlanDate().toString() + String.format("%02d", i);
			}
			getEquipDowntimeAdmVo.setPlanDateList(planDateList.substring(0, planDateList.length() - 1));
			System.out.println(planDateListSetter);
			logger.info("planDateListSetter : " + planDateListSetter);
			
			
			//★☆★☆★☆ 중요! - 쿼리에서 전체 총합(A_TOTAL)를 제일아래행에 오게 정렬한 뒤에 계산해주어야 함!
			List<Map<String, String>> list = equipDowntimeAdmService.equipOperationBody(getEquipDowntimeAdmVo);
			//합계가 제일 위로 올라와야 하기 때문에 일단 반복문 한번 돌려서 총합계 구한다음 상세합계들을 구해줬음
			
			float totalWorkTime1 = 0;
			float totalWorkTime2 = 0;
			float totalWorkTime3 = 0;
			float totalWorkTime4 = 0;
			float totalWorkTime5 = 0;
			float totalWorkTime6 = 0;
			float totalWorkTime7 = 0;
			float totalWorkTime8 = 0;
			float totalWorkTime9 = 0;
			float totalWorkTime10 = 0;
			float totalWorkTime11 = 0;
			float totalWorkTime12 = 0;
			float totalWorkTime13 = 0;
			float totalWorkTime14 = 0;
			float totalWorkTime15 = 0;
			float totalWorkTime16 = 0;
			float totalWorkTime17 = 0;
			float totalWorkTime18 = 0;
			float totalWorkTime19 = 0;
			float totalWorkTime20 = 0;
			float totalWorkTime21 = 0;
			float totalWorkTime22 = 0;
			float totalWorkTime23 = 0;
			float totalWorkTime24 = 0;
			float totalWorkTime25 = 0;
			float totalWorkTime26 = 0;
			float totalWorkTime27 = 0;
			float totalWorkTime28 = 0;
			float totalWorkTime29 = 0;
			float totalWorkTime30 = 0;
			float totalWorkTime31 = 0;
			
			float totalFullWorkTime1 = 0;
			float totalFullWorkTime2 = 0;
			float totalFullWorkTime3 = 0;
			float totalFullWorkTime4 = 0;
			float totalFullWorkTime5 = 0;
			float totalFullWorkTime6 = 0;
			float totalFullWorkTime7 = 0;
			float totalFullWorkTime8 = 0;
			float totalFullWorkTime9 = 0;
			float totalFullWorkTime10 = 0;
			float totalFullWorkTime11 = 0;
			float totalFullWorkTime12 = 0;
			float totalFullWorkTime13 = 0;
			float totalFullWorkTime14 = 0;
			float totalFullWorkTime15 = 0;
			float totalFullWorkTime16 = 0;
			float totalFullWorkTime17 = 0;
			float totalFullWorkTime18 = 0;
			float totalFullWorkTime19 = 0;
			float totalFullWorkTime20 = 0;
			float totalFullWorkTime21 = 0;
			float totalFullWorkTime22 = 0;
			float totalFullWorkTime23 = 0;
			float totalFullWorkTime24 = 0;
			float totalFullWorkTime25 = 0;
			float totalFullWorkTime26 = 0;
			float totalFullWorkTime27 = 0;
			float totalFullWorkTime28 = 0;
			float totalFullWorkTime29 = 0;
			float totalFullWorkTime30 = 0;
			float totalFullWorkTime31 = 0;

			
			for (int j=1; j<list.size(); j++) {
				EquipDowntimeAdmVo totalEquipDowntimeAdmVo = new EquipDowntimeAdmVo();
				totalEquipDowntimeAdmVo.setEquipCd(String.valueOf(list.get(j).get("EQUIP_CD")));
				totalEquipDowntimeAdmVo.setEquipNm(String.valueOf(list.get(j).get("EQUIP_NM")));
				//int equipCount = Integer.parseInt(String.valueOf(list.get(j).get("EQUIP_COUNT")));
				//분
				if (list.get(j).get(planDateListSetter[0]) == null) { totalEquipDowntimeAdmVo.setWorkTime1(0); totalEquipDowntimeAdmVo.setFullWorkTime1(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[0]))); totalEquipDowntimeAdmVo.setWorkTime1(workTime); totalEquipDowntimeAdmVo.setFullWorkTime1(24.0); totalWorkTime1 += workTime; totalFullWorkTime1 += 24.0; }
				if (list.get(j).get(planDateListSetter[1]) == null) { totalEquipDowntimeAdmVo.setWorkTime2(0); totalEquipDowntimeAdmVo.setFullWorkTime2(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[1]))); totalEquipDowntimeAdmVo.setWorkTime2(workTime); totalEquipDowntimeAdmVo.setFullWorkTime2(24.0); totalWorkTime2 += workTime; totalFullWorkTime2 += 24.0; }
				if (list.get(j).get(planDateListSetter[2]) == null) { totalEquipDowntimeAdmVo.setWorkTime3(0); totalEquipDowntimeAdmVo.setFullWorkTime3(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[2]))); totalEquipDowntimeAdmVo.setWorkTime3(workTime); totalEquipDowntimeAdmVo.setFullWorkTime3(24.0); totalWorkTime3 += workTime; totalFullWorkTime3 += 24.0; }
				if (list.get(j).get(planDateListSetter[3]) == null) { totalEquipDowntimeAdmVo.setWorkTime4(0); totalEquipDowntimeAdmVo.setFullWorkTime4(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[3]))); totalEquipDowntimeAdmVo.setWorkTime4(workTime); totalEquipDowntimeAdmVo.setFullWorkTime4(24.0); totalWorkTime4 += workTime; totalFullWorkTime4 += 24.0; }
				if (list.get(j).get(planDateListSetter[4]) == null) { totalEquipDowntimeAdmVo.setWorkTime5(0); totalEquipDowntimeAdmVo.setFullWorkTime5(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[4]))); totalEquipDowntimeAdmVo.setWorkTime5(workTime); totalEquipDowntimeAdmVo.setFullWorkTime5(24.0); totalWorkTime5 += workTime; totalFullWorkTime5 += 24.0; }
				if (list.get(j).get(planDateListSetter[5]) == null) { totalEquipDowntimeAdmVo.setWorkTime6(0); totalEquipDowntimeAdmVo.setFullWorkTime6(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[5]))); totalEquipDowntimeAdmVo.setWorkTime6(workTime); totalEquipDowntimeAdmVo.setFullWorkTime6(24.0); totalWorkTime6 += workTime; totalFullWorkTime6 += 24.0; }
				if (list.get(j).get(planDateListSetter[6]) == null) { totalEquipDowntimeAdmVo.setWorkTime7(0); totalEquipDowntimeAdmVo.setFullWorkTime7(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[6]))); totalEquipDowntimeAdmVo.setWorkTime7(workTime); totalEquipDowntimeAdmVo.setFullWorkTime7(24.0); totalWorkTime7 += workTime; totalFullWorkTime7 += 24.0; }
				if (list.get(j).get(planDateListSetter[7]) == null) { totalEquipDowntimeAdmVo.setWorkTime8(0); totalEquipDowntimeAdmVo.setFullWorkTime8(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[7]))); totalEquipDowntimeAdmVo.setWorkTime8(workTime); totalEquipDowntimeAdmVo.setFullWorkTime8(24.0); totalWorkTime8 += workTime; totalFullWorkTime8 += 24.0; }
				if (list.get(j).get(planDateListSetter[8]) == null) { totalEquipDowntimeAdmVo.setWorkTime9(0); totalEquipDowntimeAdmVo.setFullWorkTime9(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[8]))); totalEquipDowntimeAdmVo.setWorkTime9(workTime); totalEquipDowntimeAdmVo.setFullWorkTime9(24.0); totalWorkTime9 += workTime; totalFullWorkTime9 += 24.0; }
				if (list.get(j).get(planDateListSetter[9]) == null) { totalEquipDowntimeAdmVo.setWorkTime10(0); totalEquipDowntimeAdmVo.setFullWorkTime10(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[9]))); totalEquipDowntimeAdmVo.setWorkTime10(workTime); totalEquipDowntimeAdmVo.setFullWorkTime10(24.0); totalWorkTime10 += workTime; totalFullWorkTime10 += 24.0; }
				if (list.get(j).get(planDateListSetter[10]) == null) { totalEquipDowntimeAdmVo.setWorkTime11(0); totalEquipDowntimeAdmVo.setFullWorkTime11(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[10]))); totalEquipDowntimeAdmVo.setWorkTime11(workTime); totalEquipDowntimeAdmVo.setFullWorkTime11(24.0); totalWorkTime11 += workTime; totalFullWorkTime11 += 24.0; }
				if (list.get(j).get(planDateListSetter[11]) == null) { totalEquipDowntimeAdmVo.setWorkTime12(0); totalEquipDowntimeAdmVo.setFullWorkTime12(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[11]))); totalEquipDowntimeAdmVo.setWorkTime12(workTime); totalEquipDowntimeAdmVo.setFullWorkTime12(24.0); totalWorkTime12 += workTime; totalFullWorkTime12 += 24.0; }
				if (list.get(j).get(planDateListSetter[12]) == null) { totalEquipDowntimeAdmVo.setWorkTime13(0); totalEquipDowntimeAdmVo.setFullWorkTime13(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[12]))); totalEquipDowntimeAdmVo.setWorkTime13(workTime); totalEquipDowntimeAdmVo.setFullWorkTime13(24.0); totalWorkTime13 += workTime; totalFullWorkTime13 += 24.0; }
				if (list.get(j).get(planDateListSetter[13]) == null) { totalEquipDowntimeAdmVo.setWorkTime14(0); totalEquipDowntimeAdmVo.setFullWorkTime14(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[13]))); totalEquipDowntimeAdmVo.setWorkTime14(workTime); totalEquipDowntimeAdmVo.setFullWorkTime14(24.0); totalWorkTime14 += workTime; totalFullWorkTime14 += 24.0; }
				if (list.get(j).get(planDateListSetter[14]) == null) { totalEquipDowntimeAdmVo.setWorkTime15(0); totalEquipDowntimeAdmVo.setFullWorkTime15(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[14]))); totalEquipDowntimeAdmVo.setWorkTime15(workTime); totalEquipDowntimeAdmVo.setFullWorkTime15(24.0); totalWorkTime15 += workTime; totalFullWorkTime15 += 24.0; }
				if (list.get(j).get(planDateListSetter[15]) == null) { totalEquipDowntimeAdmVo.setWorkTime16(0); totalEquipDowntimeAdmVo.setFullWorkTime16(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[15]))); totalEquipDowntimeAdmVo.setWorkTime16(workTime); totalEquipDowntimeAdmVo.setFullWorkTime16(24.0); totalWorkTime16 += workTime; totalFullWorkTime16 += 24.0; }
				if (list.get(j).get(planDateListSetter[16]) == null) { totalEquipDowntimeAdmVo.setWorkTime17(0); totalEquipDowntimeAdmVo.setFullWorkTime17(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[16]))); totalEquipDowntimeAdmVo.setWorkTime17(workTime); totalEquipDowntimeAdmVo.setFullWorkTime17(24.0); totalWorkTime17 += workTime; totalFullWorkTime17 += 24.0; }
				if (list.get(j).get(planDateListSetter[17]) == null) { totalEquipDowntimeAdmVo.setWorkTime18(0); totalEquipDowntimeAdmVo.setFullWorkTime18(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[17]))); totalEquipDowntimeAdmVo.setWorkTime18(workTime); totalEquipDowntimeAdmVo.setFullWorkTime18(24.0); totalWorkTime18 += workTime; totalFullWorkTime18 += 24.0; }
				if (list.get(j).get(planDateListSetter[18]) == null) { totalEquipDowntimeAdmVo.setWorkTime19(0); totalEquipDowntimeAdmVo.setFullWorkTime19(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[18]))); totalEquipDowntimeAdmVo.setWorkTime19(workTime); totalEquipDowntimeAdmVo.setFullWorkTime19(24.0); totalWorkTime19 += workTime; totalFullWorkTime19 += 24.0; }
				if (list.get(j).get(planDateListSetter[19]) == null) { totalEquipDowntimeAdmVo.setWorkTime20(0); totalEquipDowntimeAdmVo.setFullWorkTime20(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[19]))); totalEquipDowntimeAdmVo.setWorkTime20(workTime); totalEquipDowntimeAdmVo.setFullWorkTime20(24.0); totalWorkTime20 += workTime; totalFullWorkTime20 += 24.0; }
				if (list.get(j).get(planDateListSetter[20]) == null) { totalEquipDowntimeAdmVo.setWorkTime21(0); totalEquipDowntimeAdmVo.setFullWorkTime21(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[20]))); totalEquipDowntimeAdmVo.setWorkTime21(workTime); totalEquipDowntimeAdmVo.setFullWorkTime21(24.0); totalWorkTime21 += workTime; totalFullWorkTime21 += 24.0; }
				if (list.get(j).get(planDateListSetter[21]) == null) { totalEquipDowntimeAdmVo.setWorkTime22(0); totalEquipDowntimeAdmVo.setFullWorkTime22(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[21]))); totalEquipDowntimeAdmVo.setWorkTime22(workTime); totalEquipDowntimeAdmVo.setFullWorkTime22(24.0); totalWorkTime22 += workTime; totalFullWorkTime22 += 24.0; }
				if (list.get(j).get(planDateListSetter[22]) == null) { totalEquipDowntimeAdmVo.setWorkTime23(0); totalEquipDowntimeAdmVo.setFullWorkTime23(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[22]))); totalEquipDowntimeAdmVo.setWorkTime23(workTime); totalEquipDowntimeAdmVo.setFullWorkTime23(24.0); totalWorkTime23 += workTime; totalFullWorkTime23 += 24.0; }
				if (list.get(j).get(planDateListSetter[23]) == null) { totalEquipDowntimeAdmVo.setWorkTime24(0); totalEquipDowntimeAdmVo.setFullWorkTime24(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[23]))); totalEquipDowntimeAdmVo.setWorkTime24(workTime); totalEquipDowntimeAdmVo.setFullWorkTime24(24.0); totalWorkTime24 += workTime; totalFullWorkTime24 += 24.0; }
				if (list.get(j).get(planDateListSetter[24]) == null) { totalEquipDowntimeAdmVo.setWorkTime25(0); totalEquipDowntimeAdmVo.setFullWorkTime25(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[24]))); totalEquipDowntimeAdmVo.setWorkTime25(workTime); totalEquipDowntimeAdmVo.setFullWorkTime25(24.0); totalWorkTime25 += workTime; totalFullWorkTime25 += 24.0; }
				if (list.get(j).get(planDateListSetter[25]) == null) { totalEquipDowntimeAdmVo.setWorkTime26(0); totalEquipDowntimeAdmVo.setFullWorkTime26(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[25]))); totalEquipDowntimeAdmVo.setWorkTime26(workTime); totalEquipDowntimeAdmVo.setFullWorkTime26(24.0); totalWorkTime26 += workTime; totalFullWorkTime26 += 24.0; }
				if (list.get(j).get(planDateListSetter[26]) == null) { totalEquipDowntimeAdmVo.setWorkTime27(0); totalEquipDowntimeAdmVo.setFullWorkTime27(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[26]))); totalEquipDowntimeAdmVo.setWorkTime27(workTime); totalEquipDowntimeAdmVo.setFullWorkTime27(24.0); totalWorkTime27 += workTime; totalFullWorkTime27 += 24.0; }
				if (list.get(j).get(planDateListSetter[27]) == null) { totalEquipDowntimeAdmVo.setWorkTime28(0); totalEquipDowntimeAdmVo.setFullWorkTime28(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[27]))); totalEquipDowntimeAdmVo.setWorkTime28(workTime); totalEquipDowntimeAdmVo.setFullWorkTime28(24.0); totalWorkTime28 += workTime; totalFullWorkTime28 += 24.0; }
				if (list.get(j).get(planDateListSetter[28]) == null) { totalEquipDowntimeAdmVo.setWorkTime29(0); totalEquipDowntimeAdmVo.setFullWorkTime29(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[28]))); totalEquipDowntimeAdmVo.setWorkTime29(workTime); totalEquipDowntimeAdmVo.setFullWorkTime29(24.0); totalWorkTime29 += workTime; totalFullWorkTime29 += 24.0; }
				if (list.get(j).get(planDateListSetter[29]) == null) { totalEquipDowntimeAdmVo.setWorkTime30(0); totalEquipDowntimeAdmVo.setFullWorkTime30(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[29]))); totalEquipDowntimeAdmVo.setWorkTime30(workTime); totalEquipDowntimeAdmVo.setFullWorkTime30(24.0); totalWorkTime30 += workTime; totalFullWorkTime30 += 24.0; }
				if (list.get(j).get(planDateListSetter[30]) == null) { totalEquipDowntimeAdmVo.setWorkTime31(0); totalEquipDowntimeAdmVo.setFullWorkTime31(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[30]))); totalEquipDowntimeAdmVo.setWorkTime31(workTime); totalEquipDowntimeAdmVo.setFullWorkTime31(24.0); totalWorkTime31 += workTime; totalFullWorkTime31 += 24.0; }
				
				//%수식
				if (totalEquipDowntimeAdmVo.getFullWorkTime1() == 0) { totalEquipDowntimeAdmVo.setPercent1(0); } else { totalEquipDowntimeAdmVo.setPercent1(totalEquipDowntimeAdmVo.getWorkTime1() / totalEquipDowntimeAdmVo.getFullWorkTime1() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime2() == 0) { totalEquipDowntimeAdmVo.setPercent2(0); } else { totalEquipDowntimeAdmVo.setPercent2(totalEquipDowntimeAdmVo.getWorkTime2() / totalEquipDowntimeAdmVo.getFullWorkTime2() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime3() == 0) { totalEquipDowntimeAdmVo.setPercent3(0); } else { totalEquipDowntimeAdmVo.setPercent3(totalEquipDowntimeAdmVo.getWorkTime3() / totalEquipDowntimeAdmVo.getFullWorkTime3() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime4() == 0) { totalEquipDowntimeAdmVo.setPercent4(0); } else { totalEquipDowntimeAdmVo.setPercent4(totalEquipDowntimeAdmVo.getWorkTime4() / totalEquipDowntimeAdmVo.getFullWorkTime4() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime5() == 0) { totalEquipDowntimeAdmVo.setPercent5(0); } else { totalEquipDowntimeAdmVo.setPercent5(totalEquipDowntimeAdmVo.getWorkTime5() / totalEquipDowntimeAdmVo.getFullWorkTime5() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime6() == 0) { totalEquipDowntimeAdmVo.setPercent6(0); } else { totalEquipDowntimeAdmVo.setPercent6(totalEquipDowntimeAdmVo.getWorkTime6() / totalEquipDowntimeAdmVo.getFullWorkTime6() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime7() == 0) { totalEquipDowntimeAdmVo.setPercent7(0); } else { totalEquipDowntimeAdmVo.setPercent7(totalEquipDowntimeAdmVo.getWorkTime7() / totalEquipDowntimeAdmVo.getFullWorkTime7() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime8() == 0) { totalEquipDowntimeAdmVo.setPercent8(0); } else { totalEquipDowntimeAdmVo.setPercent8(totalEquipDowntimeAdmVo.getWorkTime8() / totalEquipDowntimeAdmVo.getFullWorkTime8() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime9() == 0) { totalEquipDowntimeAdmVo.setPercent9(0); } else { totalEquipDowntimeAdmVo.setPercent9(totalEquipDowntimeAdmVo.getWorkTime9() / totalEquipDowntimeAdmVo.getFullWorkTime9() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime10() == 0) { totalEquipDowntimeAdmVo.setPercent10(0); } else { totalEquipDowntimeAdmVo.setPercent10(totalEquipDowntimeAdmVo.getWorkTime10() / totalEquipDowntimeAdmVo.getFullWorkTime10() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime11() == 0) {totalEquipDowntimeAdmVo.setPercent11(0); } else { totalEquipDowntimeAdmVo.setPercent11(totalEquipDowntimeAdmVo.getWorkTime11() / totalEquipDowntimeAdmVo.getFullWorkTime11() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime12() == 0) {totalEquipDowntimeAdmVo.setPercent12(0); } else { totalEquipDowntimeAdmVo.setPercent12(totalEquipDowntimeAdmVo.getWorkTime12() / totalEquipDowntimeAdmVo.getFullWorkTime12() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime13() == 0) {totalEquipDowntimeAdmVo.setPercent13(0); } else { totalEquipDowntimeAdmVo.setPercent13(totalEquipDowntimeAdmVo.getWorkTime13() / totalEquipDowntimeAdmVo.getFullWorkTime13() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime14() == 0) {totalEquipDowntimeAdmVo.setPercent14(0); } else { totalEquipDowntimeAdmVo.setPercent14(totalEquipDowntimeAdmVo.getWorkTime14() / totalEquipDowntimeAdmVo.getFullWorkTime14() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime15() == 0) {totalEquipDowntimeAdmVo.setPercent15(0); } else { totalEquipDowntimeAdmVo.setPercent15(totalEquipDowntimeAdmVo.getWorkTime15() / totalEquipDowntimeAdmVo.getFullWorkTime15() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime16() == 0) {totalEquipDowntimeAdmVo.setPercent16(0); } else { totalEquipDowntimeAdmVo.setPercent16(totalEquipDowntimeAdmVo.getWorkTime16() / totalEquipDowntimeAdmVo.getFullWorkTime16() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime17() == 0) {totalEquipDowntimeAdmVo.setPercent17(0); } else { totalEquipDowntimeAdmVo.setPercent17(totalEquipDowntimeAdmVo.getWorkTime17() / totalEquipDowntimeAdmVo.getFullWorkTime17() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime18() == 0) {totalEquipDowntimeAdmVo.setPercent18(0); } else { totalEquipDowntimeAdmVo.setPercent18(totalEquipDowntimeAdmVo.getWorkTime18() / totalEquipDowntimeAdmVo.getFullWorkTime18() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime19() == 0) {totalEquipDowntimeAdmVo.setPercent19(0); } else { totalEquipDowntimeAdmVo.setPercent19(totalEquipDowntimeAdmVo.getWorkTime19() / totalEquipDowntimeAdmVo.getFullWorkTime19() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime20() == 0) {totalEquipDowntimeAdmVo.setPercent20(0); } else { totalEquipDowntimeAdmVo.setPercent20(totalEquipDowntimeAdmVo.getWorkTime20() / totalEquipDowntimeAdmVo.getFullWorkTime20() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime21() == 0) {totalEquipDowntimeAdmVo.setPercent21(0); } else { totalEquipDowntimeAdmVo.setPercent21(totalEquipDowntimeAdmVo.getWorkTime21() / totalEquipDowntimeAdmVo.getFullWorkTime21() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime22() == 0) {totalEquipDowntimeAdmVo.setPercent22(0); } else { totalEquipDowntimeAdmVo.setPercent22(totalEquipDowntimeAdmVo.getWorkTime22() / totalEquipDowntimeAdmVo.getFullWorkTime22() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime23() == 0) {totalEquipDowntimeAdmVo.setPercent23(0); } else { totalEquipDowntimeAdmVo.setPercent23(totalEquipDowntimeAdmVo.getWorkTime23() / totalEquipDowntimeAdmVo.getFullWorkTime23() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime24() == 0) {totalEquipDowntimeAdmVo.setPercent24(0); } else { totalEquipDowntimeAdmVo.setPercent24(totalEquipDowntimeAdmVo.getWorkTime24() / totalEquipDowntimeAdmVo.getFullWorkTime24() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime25() == 0) {totalEquipDowntimeAdmVo.setPercent25(0); } else { totalEquipDowntimeAdmVo.setPercent25(totalEquipDowntimeAdmVo.getWorkTime25() / totalEquipDowntimeAdmVo.getFullWorkTime25() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime26() == 0) {totalEquipDowntimeAdmVo.setPercent26(0); } else { totalEquipDowntimeAdmVo.setPercent26(totalEquipDowntimeAdmVo.getWorkTime26() / totalEquipDowntimeAdmVo.getFullWorkTime26() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime27() == 0) {totalEquipDowntimeAdmVo.setPercent27(0); } else { totalEquipDowntimeAdmVo.setPercent27(totalEquipDowntimeAdmVo.getWorkTime27() / totalEquipDowntimeAdmVo.getFullWorkTime27() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime28() == 0) {totalEquipDowntimeAdmVo.setPercent28(0); } else { totalEquipDowntimeAdmVo.setPercent28(totalEquipDowntimeAdmVo.getWorkTime28() / totalEquipDowntimeAdmVo.getFullWorkTime28() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime29() == 0) {totalEquipDowntimeAdmVo.setPercent29(0); } else { totalEquipDowntimeAdmVo.setPercent29(totalEquipDowntimeAdmVo.getWorkTime29() / totalEquipDowntimeAdmVo.getFullWorkTime29() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime30() == 0) {totalEquipDowntimeAdmVo.setPercent30(0); } else { totalEquipDowntimeAdmVo.setPercent30(totalEquipDowntimeAdmVo.getWorkTime30() / totalEquipDowntimeAdmVo.getFullWorkTime30() * 100); }
				if (totalEquipDowntimeAdmVo.getFullWorkTime31() == 0) {totalEquipDowntimeAdmVo.setPercent31(0); } else { totalEquipDowntimeAdmVo.setPercent31(totalEquipDowntimeAdmVo.getWorkTime31() / totalEquipDowntimeAdmVo.getFullWorkTime31() * 100); }
				//outputList.add(equipDowntimeAdmVo);
			}
			
			EquipDowntimeAdmVo equipDowntimeAdmVo = new EquipDowntimeAdmVo();
			equipDowntimeAdmVo.setEquipCd(String.valueOf(list.get(0).get("EQUIP_CD")));
			equipDowntimeAdmVo.setEquipNm(String.valueOf(list.get(0).get("EQUIP_NM")));
			equipDowntimeAdmVo.setWorkTimeTotal(String.valueOf(list.get(0).get(planDateListSetter[31])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[31]))));
			equipDowntimeAdmVo.setWorkTime1(String.valueOf(list.get(0).get(planDateListSetter[0])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[0]))));
			equipDowntimeAdmVo.setWorkTime2(String.valueOf(list.get(0).get(planDateListSetter[1])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[1]))));				
			equipDowntimeAdmVo.setWorkTime3(String.valueOf(list.get(0).get(planDateListSetter[2])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[2]))));
			equipDowntimeAdmVo.setWorkTime4(String.valueOf(list.get(0).get(planDateListSetter[3])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[3]))));
			equipDowntimeAdmVo.setWorkTime5(String.valueOf(list.get(0).get(planDateListSetter[4])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[4]))));
			equipDowntimeAdmVo.setWorkTime6(String.valueOf(list.get(0).get(planDateListSetter[5])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[5]))));
			equipDowntimeAdmVo.setWorkTime7(String.valueOf(list.get(0).get(planDateListSetter[6])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[6]))));
			equipDowntimeAdmVo.setWorkTime8(String.valueOf(list.get(0).get(planDateListSetter[7])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[7]))));
			equipDowntimeAdmVo.setWorkTime9(String.valueOf(list.get(0).get(planDateListSetter[8])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[8]))));
			equipDowntimeAdmVo.setWorkTime10(String.valueOf(list.get(0).get(planDateListSetter[9])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[9]))));
			equipDowntimeAdmVo.setWorkTime11(String.valueOf(list.get(0).get(planDateListSetter[10])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[10]))));
			equipDowntimeAdmVo.setWorkTime12(String.valueOf(list.get(0).get(planDateListSetter[11])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[11]))));
			equipDowntimeAdmVo.setWorkTime13(String.valueOf(list.get(0).get(planDateListSetter[12])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[12]))));
			equipDowntimeAdmVo.setWorkTime14(String.valueOf(list.get(0).get(planDateListSetter[13])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[13]))));
			equipDowntimeAdmVo.setWorkTime15(String.valueOf(list.get(0).get(planDateListSetter[14])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[14]))));
			equipDowntimeAdmVo.setWorkTime16(String.valueOf(list.get(0).get(planDateListSetter[15])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[15]))));
			equipDowntimeAdmVo.setWorkTime17(String.valueOf(list.get(0).get(planDateListSetter[16])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[16]))));
			equipDowntimeAdmVo.setWorkTime18(String.valueOf(list.get(0).get(planDateListSetter[17])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[17]))));
			equipDowntimeAdmVo.setWorkTime19(String.valueOf(list.get(0).get(planDateListSetter[18])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[18]))));
			equipDowntimeAdmVo.setWorkTime20(String.valueOf(list.get(0).get(planDateListSetter[19])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[19]))));
			equipDowntimeAdmVo.setWorkTime21(String.valueOf(list.get(0).get(planDateListSetter[20])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[20]))));
			equipDowntimeAdmVo.setWorkTime22(String.valueOf(list.get(0).get(planDateListSetter[21])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[21]))));
			equipDowntimeAdmVo.setWorkTime23(String.valueOf(list.get(0).get(planDateListSetter[22])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[22]))));
			equipDowntimeAdmVo.setWorkTime24(String.valueOf(list.get(0).get(planDateListSetter[23])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[23]))));
			equipDowntimeAdmVo.setWorkTime25(String.valueOf(list.get(0).get(planDateListSetter[24])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[24]))));
			equipDowntimeAdmVo.setWorkTime26(String.valueOf(list.get(0).get(planDateListSetter[25])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[25]))));
			equipDowntimeAdmVo.setWorkTime27(String.valueOf(list.get(0).get(planDateListSetter[26])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[26]))));
			equipDowntimeAdmVo.setWorkTime28(String.valueOf(list.get(0).get(planDateListSetter[27])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[27]))));
			equipDowntimeAdmVo.setWorkTime29(String.valueOf(list.get(0).get(planDateListSetter[28])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[28]))));
			equipDowntimeAdmVo.setWorkTime30(String.valueOf(list.get(0).get(planDateListSetter[29])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[29]))));
			equipDowntimeAdmVo.setWorkTime31(String.valueOf(list.get(0).get(planDateListSetter[30])) == "null" ? 0 : Float.parseFloat(String.valueOf(list.get(0).get(planDateListSetter[30]))));
			
			//총집계이면 설비수 만큼 곱해줌
			equipDowntimeAdmVo.setFullWorkTime1(totalFullWorkTime1);
			equipDowntimeAdmVo.setFullWorkTime2(totalFullWorkTime2);
			equipDowntimeAdmVo.setFullWorkTime3(totalFullWorkTime3);
			equipDowntimeAdmVo.setFullWorkTime4(totalFullWorkTime4);
			equipDowntimeAdmVo.setFullWorkTime5(totalFullWorkTime5);
			equipDowntimeAdmVo.setFullWorkTime6(totalFullWorkTime6);
			equipDowntimeAdmVo.setFullWorkTime7(totalFullWorkTime7);
			equipDowntimeAdmVo.setFullWorkTime8(totalFullWorkTime8);
			equipDowntimeAdmVo.setFullWorkTime9(totalFullWorkTime9);
			equipDowntimeAdmVo.setFullWorkTime10(totalFullWorkTime10);
			equipDowntimeAdmVo.setFullWorkTime11(totalFullWorkTime11);
			equipDowntimeAdmVo.setFullWorkTime12(totalFullWorkTime12);
			equipDowntimeAdmVo.setFullWorkTime13(totalFullWorkTime13);
			equipDowntimeAdmVo.setFullWorkTime14(totalFullWorkTime14);
			equipDowntimeAdmVo.setFullWorkTime15(totalFullWorkTime15);
			equipDowntimeAdmVo.setFullWorkTime16(totalFullWorkTime16);
			equipDowntimeAdmVo.setFullWorkTime17(totalFullWorkTime17);
			equipDowntimeAdmVo.setFullWorkTime18(totalFullWorkTime18);
			equipDowntimeAdmVo.setFullWorkTime19(totalFullWorkTime19);
			equipDowntimeAdmVo.setFullWorkTime20(totalFullWorkTime20);
			equipDowntimeAdmVo.setFullWorkTime21(totalFullWorkTime21);
			equipDowntimeAdmVo.setFullWorkTime22(totalFullWorkTime22);
			equipDowntimeAdmVo.setFullWorkTime23(totalFullWorkTime23);
			equipDowntimeAdmVo.setFullWorkTime24(totalFullWorkTime24);
			equipDowntimeAdmVo.setFullWorkTime25(totalFullWorkTime25);
			equipDowntimeAdmVo.setFullWorkTime26(totalFullWorkTime26);
			equipDowntimeAdmVo.setFullWorkTime27(totalFullWorkTime27);
			equipDowntimeAdmVo.setFullWorkTime28(totalFullWorkTime28);
			equipDowntimeAdmVo.setFullWorkTime29(totalFullWorkTime29);
			equipDowntimeAdmVo.setFullWorkTime30(totalFullWorkTime30);
			equipDowntimeAdmVo.setFullWorkTime31(totalFullWorkTime31);
			
			if (totalFullWorkTime1 == 0) { equipDowntimeAdmVo.setPercent1(0); } else { equipDowntimeAdmVo.setPercent1(totalWorkTime1 / equipDowntimeAdmVo.getFullWorkTime1() * 100); }
			if (totalFullWorkTime2 == 0) { equipDowntimeAdmVo.setPercent2(0); } else { equipDowntimeAdmVo.setPercent2(totalWorkTime2 / equipDowntimeAdmVo.getFullWorkTime2() * 100); }
			if (totalFullWorkTime3 == 0) { equipDowntimeAdmVo.setPercent3(0); } else { equipDowntimeAdmVo.setPercent3(totalWorkTime3 / equipDowntimeAdmVo.getFullWorkTime3() * 100); }
			if (totalFullWorkTime4 == 0) { equipDowntimeAdmVo.setPercent4(0); } else { equipDowntimeAdmVo.setPercent4(totalWorkTime4 / equipDowntimeAdmVo.getFullWorkTime4() * 100); }
			if (totalFullWorkTime5 == 0) { equipDowntimeAdmVo.setPercent5(0); } else { equipDowntimeAdmVo.setPercent5(totalWorkTime5 / equipDowntimeAdmVo.getFullWorkTime5() * 100); }
			if (totalFullWorkTime6 == 0) { equipDowntimeAdmVo.setPercent6(0); } else { equipDowntimeAdmVo.setPercent6(totalWorkTime6 / equipDowntimeAdmVo.getFullWorkTime6() * 100); }
			if (totalFullWorkTime7 == 0) { equipDowntimeAdmVo.setPercent7(0); } else { equipDowntimeAdmVo.setPercent7(totalWorkTime7 / equipDowntimeAdmVo.getFullWorkTime7() * 100); }
			if (totalFullWorkTime8 == 0) { equipDowntimeAdmVo.setPercent8(0); } else { equipDowntimeAdmVo.setPercent8(totalWorkTime8 / equipDowntimeAdmVo.getFullWorkTime8() * 100); }
			if (totalFullWorkTime9 == 0) { equipDowntimeAdmVo.setPercent9(0); } else { equipDowntimeAdmVo.setPercent9(totalWorkTime9 / equipDowntimeAdmVo.getFullWorkTime9() * 100); }
			if (totalFullWorkTime10 == 0) { equipDowntimeAdmVo.setPercent10(0); } else { equipDowntimeAdmVo.setPercent10(totalWorkTime10 / equipDowntimeAdmVo.getFullWorkTime10() * 100); }
			if (totalFullWorkTime11 == 0) { equipDowntimeAdmVo.setPercent11(0); } else { equipDowntimeAdmVo.setPercent11(totalWorkTime11 / equipDowntimeAdmVo.getFullWorkTime11() * 100); }
			if (totalFullWorkTime12 == 0) { equipDowntimeAdmVo.setPercent12(0); } else { equipDowntimeAdmVo.setPercent12(totalWorkTime12 / equipDowntimeAdmVo.getFullWorkTime12() * 100); }
			if (totalFullWorkTime13 == 0) { equipDowntimeAdmVo.setPercent13(0); } else { equipDowntimeAdmVo.setPercent13(totalWorkTime13 / equipDowntimeAdmVo.getFullWorkTime13() * 100); }
			if (totalFullWorkTime14 == 0) { equipDowntimeAdmVo.setPercent14(0); } else { equipDowntimeAdmVo.setPercent14(totalWorkTime14 / equipDowntimeAdmVo.getFullWorkTime14() * 100); }
			if (totalFullWorkTime15 == 0) { equipDowntimeAdmVo.setPercent15(0); } else { equipDowntimeAdmVo.setPercent15(totalWorkTime15 / equipDowntimeAdmVo.getFullWorkTime15() * 100); }
			if (totalFullWorkTime16 == 0) { equipDowntimeAdmVo.setPercent16(0); } else { equipDowntimeAdmVo.setPercent16(totalWorkTime16 / equipDowntimeAdmVo.getFullWorkTime16() * 100); }
			if (totalFullWorkTime17 == 0) { equipDowntimeAdmVo.setPercent17(0); } else { equipDowntimeAdmVo.setPercent17(totalWorkTime17 / equipDowntimeAdmVo.getFullWorkTime17() * 100); }
			if (totalFullWorkTime18 == 0) { equipDowntimeAdmVo.setPercent18(0); } else { equipDowntimeAdmVo.setPercent18(totalWorkTime18 / equipDowntimeAdmVo.getFullWorkTime18() * 100); }
			if (totalFullWorkTime19 == 0) { equipDowntimeAdmVo.setPercent19(0); } else { equipDowntimeAdmVo.setPercent19(totalWorkTime19 / equipDowntimeAdmVo.getFullWorkTime19() * 100); }
			if (totalFullWorkTime20 == 0) { equipDowntimeAdmVo.setPercent20(0); } else { equipDowntimeAdmVo.setPercent20(totalWorkTime20 / equipDowntimeAdmVo.getFullWorkTime20() * 100); }
			if (totalFullWorkTime21 == 0) { equipDowntimeAdmVo.setPercent21(0); } else { equipDowntimeAdmVo.setPercent21(totalWorkTime21 / equipDowntimeAdmVo.getFullWorkTime21() * 100); }
			if (totalFullWorkTime22 == 0) { equipDowntimeAdmVo.setPercent22(0); } else { equipDowntimeAdmVo.setPercent22(totalWorkTime22 / equipDowntimeAdmVo.getFullWorkTime22() * 100); }
			if (totalFullWorkTime23 == 0) { equipDowntimeAdmVo.setPercent23(0); } else { equipDowntimeAdmVo.setPercent23(totalWorkTime23 / equipDowntimeAdmVo.getFullWorkTime23() * 100); }
			if (totalFullWorkTime24 == 0) { equipDowntimeAdmVo.setPercent24(0); } else { equipDowntimeAdmVo.setPercent24(totalWorkTime24 / equipDowntimeAdmVo.getFullWorkTime24() * 100); }
			if (totalFullWorkTime25 == 0) { equipDowntimeAdmVo.setPercent25(0); } else { equipDowntimeAdmVo.setPercent25(totalWorkTime25 / equipDowntimeAdmVo.getFullWorkTime25() * 100); }
			if (totalFullWorkTime26 == 0) { equipDowntimeAdmVo.setPercent26(0); } else { equipDowntimeAdmVo.setPercent26(totalWorkTime26 / equipDowntimeAdmVo.getFullWorkTime26() * 100); }
			if (totalFullWorkTime27 == 0) { equipDowntimeAdmVo.setPercent27(0); } else { equipDowntimeAdmVo.setPercent27(totalWorkTime27 / equipDowntimeAdmVo.getFullWorkTime27() * 100); }
			if (totalFullWorkTime28 == 0) { equipDowntimeAdmVo.setPercent28(0); } else { equipDowntimeAdmVo.setPercent28(totalWorkTime28 / equipDowntimeAdmVo.getFullWorkTime28() * 100); }
			if (totalFullWorkTime29 == 0) { equipDowntimeAdmVo.setPercent29(0); } else { equipDowntimeAdmVo.setPercent29(totalWorkTime29 / equipDowntimeAdmVo.getFullWorkTime29() * 100); }
			if (totalFullWorkTime30 == 0) { equipDowntimeAdmVo.setPercent30(0); } else { equipDowntimeAdmVo.setPercent30(totalWorkTime30 / equipDowntimeAdmVo.getFullWorkTime30() * 100); }
			if (totalFullWorkTime31 == 0) { equipDowntimeAdmVo.setPercent31(0); } else { equipDowntimeAdmVo.setPercent31(totalWorkTime31 / equipDowntimeAdmVo.getFullWorkTime31() * 100); }
			
			//해당 월 전체 작업시간
			float sumFullWorkTime = 0;
			sumFullWorkTime =  totalFullWorkTime1 +
								totalFullWorkTime2 +
								totalFullWorkTime3 +
								totalFullWorkTime4 +
								totalFullWorkTime5 +
								totalFullWorkTime6 +
								totalFullWorkTime7 +
								totalFullWorkTime8 +
								totalFullWorkTime9 +
								totalFullWorkTime10 +
								totalFullWorkTime11 +
								totalFullWorkTime12 +
								totalFullWorkTime13 +
								totalFullWorkTime14 +
								totalFullWorkTime15 +
								totalFullWorkTime16 +
								totalFullWorkTime17 +
								totalFullWorkTime18 +
								totalFullWorkTime19 +
								totalFullWorkTime20 +
								totalFullWorkTime21 +
								totalFullWorkTime22 +
								totalFullWorkTime23 +
								totalFullWorkTime24 +
								totalFullWorkTime25 +
								totalFullWorkTime26 +
								totalFullWorkTime27 +
								totalFullWorkTime28 +
								totalFullWorkTime29 +
								totalFullWorkTime30 +
								totalFullWorkTime31;
			equipDowntimeAdmVo.setFullWorkTimeTotal(sumFullWorkTime);
			
			//해당 월 전체 작업장 시간
			float sumWorkTime =  totalWorkTime1 +
								totalWorkTime2 +
								totalWorkTime3 +
								totalWorkTime4 +
								totalWorkTime5 +
								totalWorkTime6 +
								totalWorkTime7 +
								totalWorkTime8 +
								totalWorkTime9 +
								totalWorkTime10 +
								totalWorkTime11 +
								totalWorkTime12 +
								totalWorkTime13 +
								totalWorkTime14 +
								totalWorkTime15 +
								totalWorkTime16 +
								totalWorkTime17 +
								totalWorkTime18 +
								totalWorkTime19 +
								totalWorkTime20 +
								totalWorkTime21 +
								totalWorkTime22 +
								totalWorkTime23 +
								totalWorkTime24 +
								totalWorkTime25 +
								totalWorkTime26 +
								totalWorkTime27 +
								totalWorkTime28 +
								totalWorkTime29 +
								totalWorkTime30 +
								totalWorkTime31;
			if (sumWorkTime == 0) { equipDowntimeAdmVo.setPercentTotal(0); } else { equipDowntimeAdmVo.setPercentTotal(sumWorkTime / sumFullWorkTime * 100); }
			
			//모든 총합계 추가
			outputList.add(equipDowntimeAdmVo);
			
			
			
			
			
			
			
			
			
			
			//개별 계산
			for (int j=1; j<list.size(); j++) {
				EquipDowntimeAdmVo equipDowntimeAdmVo1 = new EquipDowntimeAdmVo();
				equipDowntimeAdmVo1.setEquipCd(String.valueOf(list.get(j).get("EQUIP_CD")));
				equipDowntimeAdmVo1.setEquipNm(String.valueOf(list.get(j).get("EQUIP_NM")));
				//int equipCount = Integer.parseInt(String.valueOf(list.get(j).get("EQUIP_COUNT")));
				float totalWorkTime = 0;
				float totalFullWorkTime = 0;
				
				if (list.get(j).get(planDateListSetter[0]) == null) { equipDowntimeAdmVo1.setWorkTime1(0); equipDowntimeAdmVo1.setFullWorkTime1(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[0]))); equipDowntimeAdmVo1.setWorkTime1(workTime); equipDowntimeAdmVo1.setFullWorkTime1(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[1]) == null) { equipDowntimeAdmVo1.setWorkTime2(0); equipDowntimeAdmVo1.setFullWorkTime2(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[1]))); equipDowntimeAdmVo1.setWorkTime2(workTime); equipDowntimeAdmVo1.setFullWorkTime2(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[2]) == null) { equipDowntimeAdmVo1.setWorkTime3(0); equipDowntimeAdmVo1.setFullWorkTime3(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[2]))); equipDowntimeAdmVo1.setWorkTime3(workTime); equipDowntimeAdmVo1.setFullWorkTime3(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[3]) == null) { equipDowntimeAdmVo1.setWorkTime4(0); equipDowntimeAdmVo1.setFullWorkTime4(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[3]))); equipDowntimeAdmVo1.setWorkTime4(workTime); equipDowntimeAdmVo1.setFullWorkTime4(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[4]) == null) { equipDowntimeAdmVo1.setWorkTime5(0); equipDowntimeAdmVo1.setFullWorkTime5(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[4]))); equipDowntimeAdmVo1.setWorkTime5(workTime); equipDowntimeAdmVo1.setFullWorkTime5(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[5]) == null) { equipDowntimeAdmVo1.setWorkTime6(0); equipDowntimeAdmVo1.setFullWorkTime6(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[5]))); equipDowntimeAdmVo1.setWorkTime6(workTime); equipDowntimeAdmVo1.setFullWorkTime6(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[6]) == null) { equipDowntimeAdmVo1.setWorkTime7(0); equipDowntimeAdmVo1.setFullWorkTime7(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[6]))); equipDowntimeAdmVo1.setWorkTime7(workTime); equipDowntimeAdmVo1.setFullWorkTime7(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[7]) == null) { equipDowntimeAdmVo1.setWorkTime8(0); equipDowntimeAdmVo1.setFullWorkTime8(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[7]))); equipDowntimeAdmVo1.setWorkTime8(workTime); equipDowntimeAdmVo1.setFullWorkTime8(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[8]) == null) { equipDowntimeAdmVo1.setWorkTime9(0); equipDowntimeAdmVo1.setFullWorkTime9(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[8]))); equipDowntimeAdmVo1.setWorkTime9(workTime); equipDowntimeAdmVo1.setFullWorkTime9(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[9]) == null) { equipDowntimeAdmVo1.setWorkTime10(0); equipDowntimeAdmVo1.setFullWorkTime10(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[9]))); equipDowntimeAdmVo1.setWorkTime10(workTime); equipDowntimeAdmVo1.setFullWorkTime10(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[10]) == null) { equipDowntimeAdmVo1.setWorkTime11(0); equipDowntimeAdmVo1.setFullWorkTime11(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[10]))); equipDowntimeAdmVo1.setWorkTime11(workTime); equipDowntimeAdmVo1.setFullWorkTime11(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[11]) == null) { equipDowntimeAdmVo1.setWorkTime12(0); equipDowntimeAdmVo1.setFullWorkTime12(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[11]))); equipDowntimeAdmVo1.setWorkTime12(workTime); equipDowntimeAdmVo1.setFullWorkTime12(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[12]) == null) { equipDowntimeAdmVo1.setWorkTime13(0); equipDowntimeAdmVo1.setFullWorkTime13(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[12]))); equipDowntimeAdmVo1.setWorkTime13(workTime); equipDowntimeAdmVo1.setFullWorkTime13(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[13]) == null) { equipDowntimeAdmVo1.setWorkTime14(0); equipDowntimeAdmVo1.setFullWorkTime14(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[13]))); equipDowntimeAdmVo1.setWorkTime14(workTime); equipDowntimeAdmVo1.setFullWorkTime14(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[14]) == null) { equipDowntimeAdmVo1.setWorkTime15(0); equipDowntimeAdmVo1.setFullWorkTime15(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[14]))); equipDowntimeAdmVo1.setWorkTime15(workTime); equipDowntimeAdmVo1.setFullWorkTime15(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[15]) == null) { equipDowntimeAdmVo1.setWorkTime16(0); equipDowntimeAdmVo1.setFullWorkTime16(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[15]))); equipDowntimeAdmVo1.setWorkTime16(workTime); equipDowntimeAdmVo1.setFullWorkTime16(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[16]) == null) { equipDowntimeAdmVo1.setWorkTime17(0); equipDowntimeAdmVo1.setFullWorkTime17(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[16]))); equipDowntimeAdmVo1.setWorkTime17(workTime); equipDowntimeAdmVo1.setFullWorkTime17(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[17]) == null) { equipDowntimeAdmVo1.setWorkTime18(0); equipDowntimeAdmVo1.setFullWorkTime18(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[17]))); equipDowntimeAdmVo1.setWorkTime18(workTime); equipDowntimeAdmVo1.setFullWorkTime18(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[18]) == null) { equipDowntimeAdmVo1.setWorkTime19(0); equipDowntimeAdmVo1.setFullWorkTime19(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[18]))); equipDowntimeAdmVo1.setWorkTime19(workTime); equipDowntimeAdmVo1.setFullWorkTime19(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[19]) == null) { equipDowntimeAdmVo1.setWorkTime20(0); equipDowntimeAdmVo1.setFullWorkTime20(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[19]))); equipDowntimeAdmVo1.setWorkTime20(workTime); equipDowntimeAdmVo1.setFullWorkTime20(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[20]) == null) { equipDowntimeAdmVo1.setWorkTime21(0); equipDowntimeAdmVo1.setFullWorkTime21(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[20]))); equipDowntimeAdmVo1.setWorkTime21(workTime); equipDowntimeAdmVo1.setFullWorkTime21(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[21]) == null) { equipDowntimeAdmVo1.setWorkTime22(0); equipDowntimeAdmVo1.setFullWorkTime22(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[21]))); equipDowntimeAdmVo1.setWorkTime22(workTime); equipDowntimeAdmVo1.setFullWorkTime22(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[22]) == null) { equipDowntimeAdmVo1.setWorkTime23(0); equipDowntimeAdmVo1.setFullWorkTime23(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[22]))); equipDowntimeAdmVo1.setWorkTime23(workTime); equipDowntimeAdmVo1.setFullWorkTime23(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[23]) == null) { equipDowntimeAdmVo1.setWorkTime24(0); equipDowntimeAdmVo1.setFullWorkTime24(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[23]))); equipDowntimeAdmVo1.setWorkTime24(workTime); equipDowntimeAdmVo1.setFullWorkTime24(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[24]) == null) { equipDowntimeAdmVo1.setWorkTime25(0); equipDowntimeAdmVo1.setFullWorkTime25(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[24]))); equipDowntimeAdmVo1.setWorkTime25(workTime); equipDowntimeAdmVo1.setFullWorkTime25(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[25]) == null) { equipDowntimeAdmVo1.setWorkTime26(0); equipDowntimeAdmVo1.setFullWorkTime26(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[25]))); equipDowntimeAdmVo1.setWorkTime26(workTime); equipDowntimeAdmVo1.setFullWorkTime26(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[26]) == null) { equipDowntimeAdmVo1.setWorkTime27(0); equipDowntimeAdmVo1.setFullWorkTime27(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[26]))); equipDowntimeAdmVo1.setWorkTime27(workTime); equipDowntimeAdmVo1.setFullWorkTime27(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[27]) == null) { equipDowntimeAdmVo1.setWorkTime28(0); equipDowntimeAdmVo1.setFullWorkTime28(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[27]))); equipDowntimeAdmVo1.setWorkTime28(workTime); equipDowntimeAdmVo1.setFullWorkTime28(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[28]) == null) { equipDowntimeAdmVo1.setWorkTime29(0); equipDowntimeAdmVo1.setFullWorkTime29(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[28]))); equipDowntimeAdmVo1.setWorkTime29(workTime); equipDowntimeAdmVo1.setFullWorkTime29(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[29]) == null) { equipDowntimeAdmVo1.setWorkTime30(0); equipDowntimeAdmVo1.setFullWorkTime30(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[29]))); equipDowntimeAdmVo1.setWorkTime30(workTime); equipDowntimeAdmVo1.setFullWorkTime30(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				if (list.get(j).get(planDateListSetter[30]) == null) { equipDowntimeAdmVo1.setWorkTime31(0); equipDowntimeAdmVo1.setFullWorkTime31(0); } else { float workTime = Float.parseFloat(String.valueOf(list.get(j).get(planDateListSetter[30]))); equipDowntimeAdmVo1.setWorkTime31(workTime); equipDowntimeAdmVo1.setFullWorkTime31(24.0); totalWorkTime += workTime; totalFullWorkTime += 24.0; }
				
				//%수식
				if (totalWorkTime == 0) { equipDowntimeAdmVo1.setPercentTotal(0); } else { equipDowntimeAdmVo1.setWorkTimeTotal(totalWorkTime); equipDowntimeAdmVo1.setFullWorkTimeTotal(totalFullWorkTime); equipDowntimeAdmVo1.setPercentTotal(totalWorkTime / totalFullWorkTime * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime1() == 0) { equipDowntimeAdmVo1.setPercent1(0); } else { equipDowntimeAdmVo1.setPercent1(equipDowntimeAdmVo1.getWorkTime1() / equipDowntimeAdmVo1.getFullWorkTime1() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime2() == 0) { equipDowntimeAdmVo1.setPercent2(0); } else { equipDowntimeAdmVo1.setPercent2(equipDowntimeAdmVo1.getWorkTime2() / equipDowntimeAdmVo1.getFullWorkTime2() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime3() == 0) { equipDowntimeAdmVo1.setPercent3(0); } else { equipDowntimeAdmVo1.setPercent3(equipDowntimeAdmVo1.getWorkTime3() / equipDowntimeAdmVo1.getFullWorkTime3() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime4() == 0) { equipDowntimeAdmVo1.setPercent4(0); } else { equipDowntimeAdmVo1.setPercent4(equipDowntimeAdmVo1.getWorkTime4() / equipDowntimeAdmVo1.getFullWorkTime4() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime5() == 0) { equipDowntimeAdmVo1.setPercent5(0); } else { equipDowntimeAdmVo1.setPercent5(equipDowntimeAdmVo1.getWorkTime5() / equipDowntimeAdmVo1.getFullWorkTime5() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime6() == 0) { equipDowntimeAdmVo1.setPercent6(0); } else { equipDowntimeAdmVo1.setPercent6(equipDowntimeAdmVo1.getWorkTime6() / equipDowntimeAdmVo1.getFullWorkTime6() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime7() == 0) { equipDowntimeAdmVo1.setPercent7(0); } else { equipDowntimeAdmVo1.setPercent7(equipDowntimeAdmVo1.getWorkTime7() / equipDowntimeAdmVo1.getFullWorkTime7() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime8() == 0) { equipDowntimeAdmVo1.setPercent8(0); } else { equipDowntimeAdmVo1.setPercent8(equipDowntimeAdmVo1.getWorkTime8() / equipDowntimeAdmVo1.getFullWorkTime8() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime9() == 0) { equipDowntimeAdmVo1.setPercent9(0); } else { equipDowntimeAdmVo1.setPercent9(equipDowntimeAdmVo1.getWorkTime9() / equipDowntimeAdmVo1.getFullWorkTime9() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime10() == 0) { equipDowntimeAdmVo1.setPercent10(0); } else { equipDowntimeAdmVo1.setPercent10(equipDowntimeAdmVo1.getWorkTime10() / equipDowntimeAdmVo1.getFullWorkTime10() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime11() == 0) { equipDowntimeAdmVo1.setPercent11(0); } else { equipDowntimeAdmVo1.setPercent11(equipDowntimeAdmVo1.getWorkTime11() / equipDowntimeAdmVo1.getFullWorkTime11() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime12() == 0) { equipDowntimeAdmVo1.setPercent12(0); } else { equipDowntimeAdmVo1.setPercent12(equipDowntimeAdmVo1.getWorkTime12() / equipDowntimeAdmVo1.getFullWorkTime12() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime13() == 0) { equipDowntimeAdmVo1.setPercent13(0); } else { equipDowntimeAdmVo1.setPercent13(equipDowntimeAdmVo1.getWorkTime13() / equipDowntimeAdmVo1.getFullWorkTime13() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime14() == 0) { equipDowntimeAdmVo1.setPercent14(0); } else { equipDowntimeAdmVo1.setPercent14(equipDowntimeAdmVo1.getWorkTime14() / equipDowntimeAdmVo1.getFullWorkTime14() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime15() == 0) { equipDowntimeAdmVo1.setPercent15(0); } else { equipDowntimeAdmVo1.setPercent15(equipDowntimeAdmVo1.getWorkTime15() / equipDowntimeAdmVo1.getFullWorkTime15() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime16() == 0) { equipDowntimeAdmVo1.setPercent16(0); } else { equipDowntimeAdmVo1.setPercent16(equipDowntimeAdmVo1.getWorkTime16() / equipDowntimeAdmVo1.getFullWorkTime16() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime17() == 0) { equipDowntimeAdmVo1.setPercent17(0); } else { equipDowntimeAdmVo1.setPercent17(equipDowntimeAdmVo1.getWorkTime17() / equipDowntimeAdmVo1.getFullWorkTime17() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime18() == 0) { equipDowntimeAdmVo1.setPercent18(0); } else { equipDowntimeAdmVo1.setPercent18(equipDowntimeAdmVo1.getWorkTime18() / equipDowntimeAdmVo1.getFullWorkTime18() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime19() == 0) { equipDowntimeAdmVo1.setPercent19(0); } else { equipDowntimeAdmVo1.setPercent19(equipDowntimeAdmVo1.getWorkTime19() / equipDowntimeAdmVo1.getFullWorkTime19() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime20() == 0) { equipDowntimeAdmVo1.setPercent20(0); } else { equipDowntimeAdmVo1.setPercent20(equipDowntimeAdmVo1.getWorkTime20() / equipDowntimeAdmVo1.getFullWorkTime20() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime21() == 0) { equipDowntimeAdmVo1.setPercent21(0); } else { equipDowntimeAdmVo1.setPercent21(equipDowntimeAdmVo1.getWorkTime21() / equipDowntimeAdmVo1.getFullWorkTime21() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime22() == 0) { equipDowntimeAdmVo1.setPercent22(0); } else { equipDowntimeAdmVo1.setPercent22(equipDowntimeAdmVo1.getWorkTime22() / equipDowntimeAdmVo1.getFullWorkTime22() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime23() == 0) { equipDowntimeAdmVo1.setPercent23(0); } else { equipDowntimeAdmVo1.setPercent23(equipDowntimeAdmVo1.getWorkTime23() / equipDowntimeAdmVo1.getFullWorkTime23() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime24() == 0) { equipDowntimeAdmVo1.setPercent24(0); } else { equipDowntimeAdmVo1.setPercent24(equipDowntimeAdmVo1.getWorkTime24() / equipDowntimeAdmVo1.getFullWorkTime24() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime25() == 0) { equipDowntimeAdmVo1.setPercent25(0); } else { equipDowntimeAdmVo1.setPercent25(equipDowntimeAdmVo1.getWorkTime25() / equipDowntimeAdmVo1.getFullWorkTime25() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime26() == 0) { equipDowntimeAdmVo1.setPercent26(0); } else { equipDowntimeAdmVo1.setPercent26(equipDowntimeAdmVo1.getWorkTime26() / equipDowntimeAdmVo1.getFullWorkTime26() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime27() == 0) { equipDowntimeAdmVo1.setPercent27(0); } else { equipDowntimeAdmVo1.setPercent27(equipDowntimeAdmVo1.getWorkTime27() / equipDowntimeAdmVo1.getFullWorkTime27() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime28() == 0) { equipDowntimeAdmVo1.setPercent28(0); } else { equipDowntimeAdmVo1.setPercent28(equipDowntimeAdmVo1.getWorkTime28() / equipDowntimeAdmVo1.getFullWorkTime28() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime29() == 0) { equipDowntimeAdmVo1.setPercent29(0); } else { equipDowntimeAdmVo1.setPercent29(equipDowntimeAdmVo1.getWorkTime29() / equipDowntimeAdmVo1.getFullWorkTime29() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime30() == 0) { equipDowntimeAdmVo1.setPercent30(0); } else { equipDowntimeAdmVo1.setPercent30(equipDowntimeAdmVo1.getWorkTime30() / equipDowntimeAdmVo1.getFullWorkTime30() * 100); }
				if (equipDowntimeAdmVo1.getFullWorkTime31() == 0) { equipDowntimeAdmVo1.setPercent31(0); } else { equipDowntimeAdmVo1.setPercent31(equipDowntimeAdmVo1.getWorkTime31() / equipDowntimeAdmVo1.getFullWorkTime31() * 100); }
				outputList.add(equipDowntimeAdmVo1);
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
	
}