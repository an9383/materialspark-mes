package mes.web.wm;

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
import mes.domain.po.WorkOrderVo;
import mes.persistence.qm.GoodsInspectDAO;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.DateUtil;

@Controller
public class ActualOutputController {

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private GoodsInspectDAO workOrderService;

	private static final Logger logger = LoggerFactory.getLogger(ActualOutputController.class);

	//생산관리 - 작업지시 페이지
	@RequestMapping(value = "/wmsc0020", method = RequestMethod.GET)
	public String wmsc0020GET(Locale locale, Model model) throws Exception {

		logger.info("생산실적관리 페이지");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dayNightCd", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "wm/wmsc0020";
	}

	//생산실적 일자조회
	@RequestMapping(value = "wm/readActualOutputDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputDataListGET(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적 일자조회");

		try {
			List<WorkOrderVo> goodsFaultyAdmDataList = workOrderService.readActualOutputDataList(workOrderVo);
			jsonData.put("data", goodsFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적 일자조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//생산실적관리 날짜 조회 - eisc0010
	@RequestMapping(value = "wm/readActualOutputDataList_eisc0010", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readActualOutputDataListEisc0010GET(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적관리 날짜 조회");

		try {
			List<WorkOrderVo> goodsFaultyAdmDataList = workOrderService.actualOutputDataList_eisc0010(workOrderVo);
			jsonData.put("data", goodsFaultyAdmDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산실적관리 날짜 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//생산관리 - 생산현황조회
	@RequestMapping(value = "/wmsc0040", method = RequestMethod.GET)
	public String wmsc0040GET(Locale locale, Model model) throws Exception {

		logger.info("생산실적관리 페이지");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList);

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));

		return "wm/wmsc0040";
	}

	//생산관리 - 생산현황 기간별 조회
	@RequestMapping(value = "wm/readTotalActualOutputDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readTotalActualOutputDataList(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산현황 날짜 조회");
		logger.info("받은 값 : " + workOrderVo);

		try {
			/*
			 * if() { 날짜계산 추가 예정(최대 검색등록이 7 }
			 */
			List<WorkOrderVo> totalActualOutputDataList = workOrderService.readTotalActualOutputDataList(workOrderVo);
			jsonData.put("data", totalActualOutputDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산현황 날짜 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

}