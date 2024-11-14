package mes.web.wm;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.br.RawMatrlSupplyVo;
import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.em.ManufacturerVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.wm.MonthProductPresentVo;
import mes.domain.wm.ProductionPlanVo;
import mes.domain.wm.WorkOrderPlanVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.em.ManufacturerService;
import mes.service.po.WorkOrderService;
import mes.service.wm.WorkOrderPlanService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class WorkOrderPlanController {

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
	
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderPlanController.class);

	//생산관리 - 작업지시 페이지
	@RequestMapping(value = "/wmsc0010", method = RequestMethod.GET)
	public String wmsc0010GET(Locale locale, Model model) throws Exception {

		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc0010";
	}

	//해당설비&해당날짜 작업지시 조회
	@RequestMapping(value = "/wm/workOrderPlanList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderPlanListGET(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비정보관리 전제 조회");

		try {
			WorkOrderPlanVo workOrderPlanDay = workOrderPlanService.searchDay(workOrderPlanVo);
			jsonData.put("day", workOrderPlanDay);
			logger.info("주간 작업지시 정보" + workOrderPlanDay);
			WorkOrderPlanVo workOrderPlanNight = workOrderPlanService.searchNight(workOrderPlanVo);
			jsonData.put("night", workOrderPlanNight);
			logger.info("야간 작업지시 정보" + workOrderPlanDay);
			jsonData.put("result", "ok");
		} catch (NullPointerException e) {
			logger.info("작업지시 조회된 값이 없습니다.");
		} catch (Exception e) {
			logger.info("해당설비&해당날짜 작업지시 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//설비 계획 상세 조회
	@RequestMapping(value = "/wm/equipBomDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipBomDataListGET(EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm, ManufacturerVo manufacturerVo) throws Exception {

		logger.info("특정 설비계획 상세 조회");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("EquipCondBomAdmVo : " + equipCondBomAdmVo);
		logger.info("EquipTempaturCondAdm : " + equipTempaturCondAdm);

		try {
			manufacturerVo = manufacturerService.read(manufacturerVo);
			logger.info("제품코드 조회 : " + manufacturerVo);
			Map<String, Object> manufacturerMap = new HashMap<String, Object>();

			manufacturerMap.put("goodsCd", manufacturerVo.getGoodsCd()); //제품코드
			manufacturerMap.put("goodsNm", manufacturerVo.getGoodsNm()); //제품명
			manufacturerMap.put("model", manufacturerVo.getModel()); //규격
			manufacturerMap.put("qutyCd", manufacturerVo.getQutyCd()); //재질
			manufacturerMap.put("alniQutyNm", manufacturerVo.getAlniQutyNm()); //알류미늄or니켈 종류
			manufacturerMap.put("alniThickness", manufacturerVo.getAlniThickness()); //알류미늄or니켈 두께
			manufacturerMap.put("alniWidth", manufacturerVo.getAlniWidth()); //알류미늄or니켈 너비
			manufacturerMap.put("alniLength", manufacturerVo.getAlniLength()); //알류미늄or니켈 길이
			manufacturerMap.put("alniPitch", manufacturerVo.getAlniPitch()); //알류미늄or니켈 피치
			manufacturerMap.put("filmQutyNm", manufacturerVo.getFilmQutyNm()); //필름명
			manufacturerMap.put("filmThickness", manufacturerVo.getFilmThickness()); //필름 두께
			manufacturerMap.put("filmDepth", manufacturerVo.getFilmDepth()); //필름 규격		
			manufacturerMap.put("surfaceTrtmtCd", manufacturerVo.getSurfaceTrtmtCd()); //표면처리 코드(join)
			manufacturerMap.put("surfaceTrtmtNm", manufacturerVo.getSurfaceTrtmtNm()); //표면처리 명(join)
			jsonData.put("manufacturerData", manufacturerMap);

			EquipTempaturCondAdm tempaturRead = new EquipTempaturCondAdm();
			EquipCondBomAdmVo timeRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo pressureRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			tempaturRead = equipCondBomAdmService.tempaturRead(equipTempaturCondAdm);
			logger.info("온도 정보 : " + tempaturRead);
			timeRead = equipCondBomAdmService.timeRead(equipCondBomAdmVo);
			logger.info("시간 정보 : " + timeRead);
			pressureRead = equipCondBomAdmService.pressureRead(equipCondBomAdmVo);
			logger.info("압력 정보 : " + pressureRead);
			sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("치수 정보 : " + sizeRead);

			Map<String, Object> tempaturMap = new HashMap<String, Object>();
			Map<String, Object> timeMap = new HashMap<String, Object>();
			Map<String, Object> pressureMap = new HashMap<String, Object>();
			Map<String, Object> sizeMap = new HashMap<String, Object>();

			tempaturMap.put("equipCondSeq", tempaturRead.getEquipCondSeq());
			tempaturMap.put("warmupCond", tempaturRead.getWarmupCond());
			tempaturMap.put("warmupAlwncePlus", tempaturRead.getWarmupAlwncePlus());
			tempaturMap.put("warmupAlwnceMinus", tempaturRead.getWarmupAlwnceMinus());
			tempaturMap.put("fitup1UpCond", tempaturRead.getFitup1UpCond());
			tempaturMap.put("fitup1UpAlwncePlus", tempaturRead.getFitup1UpAlwncePlus());
			tempaturMap.put("fitup1UpAlwnceMinus", tempaturRead.getFitup1UpAlwnceMinus());
			tempaturMap.put("fitup1DownCond", tempaturRead.getFitup1DownCond());
			tempaturMap.put("fitup1DownAlwncePlus", tempaturRead.getFitup1DownAlwncePlus());
			tempaturMap.put("fitup1DownAlwnceMinus", tempaturRead.getFitup1DownAlwnceMinus());
			tempaturMap.put("fitup2UpleftCond", tempaturRead.getFitup2UpleftCond());
			tempaturMap.put("fitup2UpleftAlwncePlus", tempaturRead.getFitup2UpleftAlwncePlus());
			tempaturMap.put("fitup2UpleftAlwnceMinus", tempaturRead.getFitup2UpleftAlwnceMinus());
			tempaturMap.put("fitup2DownleftCond", tempaturRead.getFitup2DownleftCond());
			tempaturMap.put("fitup2DownleftAlwncePlus", tempaturRead.getFitup2DownleftAlwncePlus());
			tempaturMap.put("fitup2DownleftAlwnceMinus", tempaturRead.getFitup2DownleftAlwnceMinus());
			tempaturMap.put("fitup2UprightCond", tempaturRead.getFitup2UprightCond());
			tempaturMap.put("fitup2UprightAlwncePlus", tempaturRead.getFitup2UprightAlwncePlus());
			tempaturMap.put("fitup2UprightAlwnceMinus", tempaturRead.getFitup2UprightAlwnceMinus());
			tempaturMap.put("fitup2DownrightCond", tempaturRead.getFitup2DownrightCond());
			tempaturMap.put("fitup2DownrightAlwncePlus", tempaturRead.getFitup2DownrightAlwncePlus());
			tempaturMap.put("fitup2DownrightAlwnceMinus", tempaturRead.getFitup2DownrightAlwnceMinus());
			tempaturMap.put("rollheatUpCond", tempaturRead.getRollheatUpCond());
			tempaturMap.put("rollheatUpAlwncePlus", tempaturRead.getRollheatUpAlwncePlus());
			tempaturMap.put("rollheatUpAlwnceMinus", tempaturRead.getRollheatUpAlwnceMinus());
			tempaturMap.put("rollheatDownCond", tempaturRead.getRollheatDownCond());
			tempaturMap.put("rollheatDownAlwncePlus", tempaturRead.getRollheatDownAlwncePlus());
			tempaturMap.put("rollheatDownAlwnceMinus", tempaturRead.getRollheatDownAlwnceMinus());
			tempaturMap.put("firstUpleftCond", tempaturRead.getFirstUpleftCond());
			tempaturMap.put("firstUpleftAlwncePlus", tempaturRead.getFirstUpleftAlwncePlus());
			tempaturMap.put("firstUpleftAlwnceMinus", tempaturRead.getFirstUpleftAlwnceMinus());
			tempaturMap.put("firstDownleftCond", tempaturRead.getFirstDownleftCond());
			tempaturMap.put("firstDownleftAlwncePlus", tempaturRead.getFirstDownleftAlwncePlus());
			tempaturMap.put("firstDownleftAlwnceMinus", tempaturRead.getFirstDownleftAlwnceMinus());
			tempaturMap.put("firstUprightCond", tempaturRead.getFirstUprightCond());
			tempaturMap.put("firstUprightAlwncePlus", tempaturRead.getFirstUprightAlwncePlus());
			tempaturMap.put("firstUprightAlwnceMinus", tempaturRead.getFirstUprightAlwnceMinus());
			tempaturMap.put("firstDownrightCond", tempaturRead.getFirstDownrightCond());
			tempaturMap.put("firstDownrightAlwncePlus", tempaturRead.getFirstDownrightAlwncePlus());
			tempaturMap.put("firstDownrightAlwnceMinus", tempaturRead.getFirstDownrightAlwnceMinus());
			
			tempaturMap.put("push1UpCond", tempaturRead.getPush1UpCond());
			tempaturMap.put("push1UpAlwncePlus", tempaturRead.getPush1UpAlwncePlus());
			tempaturMap.put("push1UpAlwnceMinus", tempaturRead.getPush1UpAlwnceMinus());
			tempaturMap.put("push1DownCond", tempaturRead.getPush1DownCond());
			tempaturMap.put("push1DownAlwncePlus", tempaturRead.getPush1DownAlwncePlus());
			tempaturMap.put("push1DownAlwnceMinus", tempaturRead.getPush1DownAlwnceMinus());
			
			tempaturMap.put("secondUpleftCond", tempaturRead.getSecondUpleftCond());
			tempaturMap.put("secondUpleftAlwncePlus", tempaturRead.getSecondUpleftAlwncePlus());
			tempaturMap.put("secondUpleftAlwnceMinus", tempaturRead.getSecondUpleftAlwnceMinus());
			tempaturMap.put("secondDownleftCond", tempaturRead.getSecondDownleftCond());
			tempaturMap.put("secondDownleftAlwncePlus", tempaturRead.getSecondDownleftAlwncePlus());
			tempaturMap.put("secondDownleftAlwnceMinus", tempaturRead.getSecondDownleftAlwnceMinus());
			tempaturMap.put("secondUprightCond", tempaturRead.getSecondUprightCond());
			tempaturMap.put("secondUprightAlwncePlus", tempaturRead.getSecondUprightAlwncePlus());
			tempaturMap.put("secondUprightAlwnceMinus", tempaturRead.getSecondUprightAlwnceMinus());
			tempaturMap.put("secondDownrightCond", tempaturRead.getSecondDownrightCond());
			tempaturMap.put("secondDownrightAlwncePlus", tempaturRead.getSecondDownrightAlwncePlus());
			tempaturMap.put("secondDownrightAlwnceMinus", tempaturRead.getSecondDownrightAlwnceMinus());
			tempaturMap.put("thirdUpleftCond", tempaturRead.getThirdUpleftCond());
			tempaturMap.put("thirdUpleftAlwncePlus", tempaturRead.getThirdUpleftAlwncePlus());
			tempaturMap.put("thirdUpleftAlwnceMinus", tempaturRead.getThirdUpleftAlwnceMinus());
			tempaturMap.put("thirdDownleftCond", tempaturRead.getThirdDownleftCond());
			tempaturMap.put("thirdDownleftAlwncePlus", tempaturRead.getThirdDownleftAlwncePlus());
			tempaturMap.put("thirdDownleftAlwnceMinus", tempaturRead.getThirdDownleftAlwnceMinus());
			tempaturMap.put("thirdUprightCond", tempaturRead.getThirdUprightCond());
			tempaturMap.put("thirdUprightAlwncePlus", tempaturRead.getThirdUprightAlwncePlus());
			tempaturMap.put("thirdUprightAlwnceMinus", tempaturRead.getThirdUprightAlwnceMinus());
			tempaturMap.put("thirdDownrightCond", tempaturRead.getThirdDownrightCond());
			tempaturMap.put("thirdDownrightAlwncePlus", tempaturRead.getThirdDownrightAlwncePlus());
			tempaturMap.put("thirdDownrightAlwnceMinus", tempaturRead.getThirdDownrightAlwnceMinus());
			tempaturMap.put("jinjeop1UpCond", tempaturRead.getJinjeop1UpCond());
			tempaturMap.put("jinjeop1UpAlwncePlus", tempaturRead.getJinjeop1UpAlwncePlus());
			tempaturMap.put("jinjeop1UpAlwnceMinus", tempaturRead.getJinjeop1UpAlwnceMinus());
			tempaturMap.put("jinjeop1DownCond", tempaturRead.getJinjeop1DownCond());
			tempaturMap.put("jinjeop1DownAlwncePlus", tempaturRead.getJinjeop1DownAlwncePlus());
			tempaturMap.put("jinjeop1DownAlwnceMinus", tempaturRead.getJinjeop1DownAlwnceMinus());
			tempaturMap.put("jinjeop2UpCond", tempaturRead.getJinjeop2UpCond());
			tempaturMap.put("jinjeop2UpAlwncePlus", tempaturRead.getJinjeop2UpAlwncePlus());
			tempaturMap.put("jinjeop2UpAlwnceMinus", tempaturRead.getJinjeop2UpAlwnceMinus());
			tempaturMap.put("jinjeop2DownCond", tempaturRead.getJinjeop2DownCond());
			tempaturMap.put("jinjeop2DownAlwncePlus", tempaturRead.getJinjeop2DownAlwncePlus());
			tempaturMap.put("jinjeop2DownAlwnceMinus", tempaturRead.getJinjeop2DownAlwnceMinus());
			jsonData.put("tempaturData", tempaturMap);

			timeMap.put("equipCondSeq", timeRead.getEquipCondSeq());
			//timeMap.put("warmupCond", 			timeRead.getWarmupCond());
			//timeMap.put("warmupAlwncePlus", 	timeRead.getWarmupAlwncePlus());
			//timeMap.put("warmupAlwnceMinus", 	timeRead.getWarmupAlwnceMinus());
			timeMap.put("fitupCond", timeRead.getFitupCond());
			timeMap.put("fitupAlwncePlus", timeRead.getFitupAlwncePlus());
			timeMap.put("fitupAlwnceMinus", timeRead.getFitupAlwnceMinus());
			timeMap.put("fitup2Cond", timeRead.getFitup2Cond());
			timeMap.put("fitup2AlwncePlus", timeRead.getFitup2AlwncePlus());
			timeMap.put("fitup2AlwnceMinus", timeRead.getFitup2AlwnceMinus());
			timeMap.put("firstCond", timeRead.getFirstCond());
			timeMap.put("firstAlwncePlus", timeRead.getFirstAlwncePlus());
			timeMap.put("firstAlwnceMinus", timeRead.getFirstAlwnceMinus());
			timeMap.put("secondCond", timeRead.getSecondCond());
			timeMap.put("secondAlwncePlus", timeRead.getSecondAlwncePlus());
			timeMap.put("secondAlwnceMinus", timeRead.getSecondAlwnceMinus());
			timeMap.put("thirdCond", timeRead.getThirdCond());
			timeMap.put("thirdAlwncePlus", timeRead.getThirdAlwncePlus());
			timeMap.put("thirdAlwnceMinus", timeRead.getThirdAlwnceMinus());
			timeMap.put("jinjeopCond", timeRead.getJinjeopCond());
			timeMap.put("jinjeopAlwncePlus", timeRead.getJinjeopAlwncePlus());
			timeMap.put("jinjeopAlwnceMinus", timeRead.getJinjeopAlwnceMinus());
			timeMap.put("jinjeop2Cond", timeRead.getJinjeop2Cond());
			timeMap.put("jinjeop2AlwncePlus", timeRead.getJinjeop2AlwncePlus());
			timeMap.put("jinjeop2AlwnceMinus", timeRead.getJinjeop2AlwnceMinus());
			timeMap.put("push1Cond", timeRead.getPush1Cond());
			timeMap.put("push1AlwncePlus", timeRead.getPush1AlwncePlus());
			timeMap.put("push1AlwnceMinus", timeRead.getPush1AlwnceMinus());
			timeMap.put("reformCond", timeRead.getReformCond());
			timeMap.put("reformAlwncePlus", timeRead.getReformAlwncePlus());
			timeMap.put("reformAlwnceMinus", timeRead.getReformAlwnceMinus());
			timeMap.put("coolCond", timeRead.getCoolCond());
			timeMap.put("coolAlwncePlus", timeRead.getCoolAlwncePlus());
			timeMap.put("coolAlwnceMinus", timeRead.getCoolAlwnceMinus());
			jsonData.put("timeData", timeMap);

			pressureMap.put("equipCondSeq", pressureRead.getEquipCondSeq());
			pressureMap.put("fitupCond", pressureRead.getFitupCond());
			pressureMap.put("fitupAlwncePlus", pressureRead.getFitupAlwncePlus());
			pressureMap.put("fitupAlwnceMinus", pressureRead.getFitupAlwnceMinus());
			pressureMap.put("push1Cond", pressureRead.getPush1Cond());
			pressureMap.put("push1AlwncePlus", pressureRead.getPush1AlwncePlus());
			pressureMap.put("push1AlwnceMinus", pressureRead.getPush1AlwnceMinus());
			pressureMap.put("jinjeopCond", pressureRead.getJinjeopCond());
			pressureMap.put("jinjeopAlwncePlus", pressureRead.getJinjeopAlwncePlus());
			pressureMap.put("jinjeopAlwnceMinus", pressureRead.getJinjeopAlwnceMinus());
			pressureMap.put("jinjeop2Cond", pressureRead.getJinjeop2Cond());
			pressureMap.put("jinjeop2AlwncePlus", pressureRead.getJinjeop2AlwncePlus());
			pressureMap.put("jinjeop2AlwnceMinus", pressureRead.getJinjeop2AlwnceMinus());
			jsonData.put("pressureData", pressureMap);

			sizeMap.put("equipCondSeq", sizeRead.getEquipCondSeq());
			sizeMap.put("wpLeftCond", sizeRead.getWpLeftCond());
			sizeMap.put("wpLeftAlwncePlus", sizeRead.getWpLeftAlwncePlus());
			sizeMap.put("wpLeftAlwnceMinus", sizeRead.getWpLeftAlwnceMinus());
			sizeMap.put("wpRightCond", sizeRead.getWpRightCond());
			sizeMap.put("wpRightAlwncePlus", sizeRead.getWpRightAlwncePlus());
			sizeMap.put("wpRightAlwnceMinus", sizeRead.getWpRightAlwnceMinus());
			sizeMap.put("pitchLeftCond", sizeRead.getPitchLeftCond());
			sizeMap.put("pitchLeftAlwncePlus", sizeRead.getPitchLeftAlwncePlus());
			sizeMap.put("pitchLeftAlwnceMinus", sizeRead.getPitchLeftAlwnceMinus());
			sizeMap.put("pitchRightCond", sizeRead.getPitchRightCond());
			sizeMap.put("pitchRightAlwncePlus", sizeRead.getPitchRightAlwncePlus());
			sizeMap.put("pitchRightAlwnceMinus", sizeRead.getPitchRightAlwnceMinus());
			sizeMap.put("ppfWingLeftCond", sizeRead.getPpfWingLeftCond());
			sizeMap.put("ppfWingLeftAlwncePlus", sizeRead.getPpfWingLeftAlwncePlus());
			sizeMap.put("ppfWingLeftAlwnceMinus", sizeRead.getPpfWingLeftAlwnceMinus());
			sizeMap.put("ppfWingRightCond", sizeRead.getPpfWingRightCond());
			sizeMap.put("ppfWingRightAlwncePlus", sizeRead.getPpfWingRightAlwncePlus());
			sizeMap.put("ppfWingRightAlwnceMinus", sizeRead.getPpfWingRightAlwnceMinus());
			sizeMap.put("ppfDepthLeftCond", sizeRead.getPpfDepthLeftCond());
			sizeMap.put("ppfDepthLeftAlwncePlus", sizeRead.getPpfDepthLeftAlwncePlus());
			sizeMap.put("ppfDepthLeftAlwnceMinus", sizeRead.getPpfDepthLeftAlwnceMinus());
			sizeMap.put("ppfDepthRightCond", sizeRead.getPpfDepthRightCond());
			sizeMap.put("ppfDepthRightAlwncePlus", sizeRead.getPpfDepthRightAlwncePlus());
			sizeMap.put("ppfDepthRightAlwnceMinus", sizeRead.getPpfDepthRightAlwnceMinus());
			sizeMap.put("filmCond", sizeRead.getFilmCond());
			sizeMap.put("filmAlwncePlus", sizeRead.getFilmAlwncePlus());
			sizeMap.put("filmAlwnceMinus", sizeRead.getFilmAlwnceMinus());
			sizeMap.put("metalDepthCond", sizeRead.getMetalDepthCond());
			sizeMap.put("metalDepthAlwncePlus", sizeRead.getMetalDepthAlwncePlus());
			sizeMap.put("metalDepthAlwnceMinus", sizeRead.getMetalDepthAlwnceMinus());
			sizeMap.put("metalThicknessCond", sizeRead.getMetalThicknessCond());
			sizeMap.put("metalThicknessAlwncePlus", sizeRead.getMetalThicknessAlwncePlus());
			sizeMap.put("metalThicknessAlwnceMinus", sizeRead.getMetalThicknessAlwnceMinus());
			sizeMap.put("thCenterCond", sizeRead.getThCenterCond());
			sizeMap.put("thCenterAlwncePlus", sizeRead.getThCenterAlwncePlus());
			sizeMap.put("thCenterAlwnceMinus", sizeRead.getThCenterAlwnceMinus());
			sizeMap.put("thEdgeCond", sizeRead.getThEdgeCond());
			sizeMap.put("thEdgeAlwncePlus", sizeRead.getThEdgeAlwncePlus());
			sizeMap.put("thEdgeAlwnceMinus", sizeRead.getThEdgeAlwnceMinus());
			sizeMap.put("burrCond", sizeRead.getBurrCond());
			sizeMap.put("burrAlwncePlus", sizeRead.getBurrAlwncePlus());
			sizeMap.put("burrAlwnceMinus", sizeRead.getBurrAlwnceMinus());
			jsonData.put("sizeData", sizeMap);

			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("특정 설비계획 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//BOMList만 조회
	@RequestMapping(value = "/wm/onlyBomDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipBomDataBomListGET(EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm) throws Exception {

		logger.info("BOMList만 조회");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		EquipTempaturCondAdm tempaturRead = new EquipTempaturCondAdm();
		EquipCondBomAdmVo timeRead = new EquipCondBomAdmVo();
		EquipCondBomAdmVo pressureRead = new EquipCondBomAdmVo();
		EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();

		try {
			tempaturRead = equipCondBomAdmService.tempaturRead(equipTempaturCondAdm);
			logger.info("온도 정보 : " + tempaturRead);
			timeRead = equipCondBomAdmService.timeRead(equipCondBomAdmVo);
			logger.info("시간 정보 : " + timeRead);
			pressureRead = equipCondBomAdmService.pressureRead(equipCondBomAdmVo);
			logger.info("압력 정보 : " + pressureRead);
			sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("치수 정보 : " + sizeRead);
			Map<String, Object> tempaturMap = new HashMap<String, Object>();
			Map<String, Object> timeMap = new HashMap<String, Object>();
			Map<String, Object> pressureMap = new HashMap<String, Object>();
			Map<String, Object> sizeMap = new HashMap<String, Object>();

			if (tempaturRead != null) {
				tempaturMap.put("equipCondSeq", tempaturRead.getEquipCondSeq());
				tempaturMap.put("warmupCond", tempaturRead.getWarmupCond());
				tempaturMap.put("warmupAlwncePlus", tempaturRead.getWarmupAlwncePlus());
				tempaturMap.put("warmupAlwnceMinus", tempaturRead.getWarmupAlwnceMinus());
				tempaturMap.put("fitup1UpCond", tempaturRead.getFitup1UpCond());
				tempaturMap.put("fitup1UpAlwncePlus", tempaturRead.getFitup1UpAlwncePlus());
				tempaturMap.put("fitup1UpAlwnceMinus", tempaturRead.getFitup1UpAlwnceMinus());
				tempaturMap.put("fitup1DownCond", tempaturRead.getFitup1DownCond());
				tempaturMap.put("fitup1DownAlwncePlus", tempaturRead.getFitup1DownAlwncePlus());
				tempaturMap.put("fitup1DownAlwnceMinus", tempaturRead.getFitup1DownAlwnceMinus());
				tempaturMap.put("fitup2UpleftCond", tempaturRead.getFitup2UpleftCond());
				tempaturMap.put("fitup2UpleftAlwncePlus", tempaturRead.getFitup2UpleftAlwncePlus());
				tempaturMap.put("fitup2UpleftAlwnceMinus", tempaturRead.getFitup2UpleftAlwnceMinus());
				tempaturMap.put("fitup2DownleftCond", tempaturRead.getFitup2DownleftCond());
				tempaturMap.put("fitup2DownleftAlwncePlus", tempaturRead.getFitup2DownleftAlwncePlus());
				tempaturMap.put("fitup2DownleftAlwnceMinus", tempaturRead.getFitup2DownleftAlwnceMinus());
				tempaturMap.put("fitup2UprightCond", tempaturRead.getFitup2UprightCond());
				tempaturMap.put("fitup2UprightAlwncePlus", tempaturRead.getFitup2UprightAlwncePlus());
				tempaturMap.put("fitup2UprightAlwnceMinus", tempaturRead.getFitup2UprightAlwnceMinus());
				tempaturMap.put("fitup2DownrightCond", tempaturRead.getFitup2DownrightCond());
				tempaturMap.put("fitup2DownrightAlwncePlus", tempaturRead.getFitup2DownrightAlwncePlus());
				tempaturMap.put("fitup2DownrightAlwnceMinus", tempaturRead.getFitup2DownrightAlwnceMinus());
				tempaturMap.put("rollheatUpCond", tempaturRead.getRollheatUpCond());
				tempaturMap.put("rollheatUpAlwncePlus", tempaturRead.getRollheatUpAlwncePlus());
				tempaturMap.put("rollheatUpAlwnceMinus", tempaturRead.getRollheatUpAlwnceMinus());
				tempaturMap.put("rollheatDownCond", tempaturRead.getRollheatDownCond());
				tempaturMap.put("rollheatDownAlwncePlus", tempaturRead.getRollheatDownAlwncePlus());
				tempaturMap.put("rollheatDownAlwnceMinus", tempaturRead.getRollheatDownAlwnceMinus());
				tempaturMap.put("firstUpleftCond", tempaturRead.getFirstUpleftCond());
				tempaturMap.put("firstUpleftAlwncePlus", tempaturRead.getFirstUpleftAlwncePlus());
				tempaturMap.put("firstUpleftAlwnceMinus", tempaturRead.getFirstUpleftAlwnceMinus());
				tempaturMap.put("firstDownleftCond", tempaturRead.getFirstDownleftCond());
				tempaturMap.put("firstDownleftAlwncePlus", tempaturRead.getFirstDownleftAlwncePlus());
				tempaturMap.put("firstDownleftAlwnceMinus", tempaturRead.getFirstDownleftAlwnceMinus());
				tempaturMap.put("firstUprightCond", tempaturRead.getFirstUprightCond());
				tempaturMap.put("firstUprightAlwncePlus", tempaturRead.getFirstUprightAlwncePlus());
				tempaturMap.put("firstUprightAlwnceMinus", tempaturRead.getFirstUprightAlwnceMinus());
				tempaturMap.put("firstDownrightCond", tempaturRead.getFirstDownrightCond());
				tempaturMap.put("firstDownrightAlwncePlus", tempaturRead.getFirstDownrightAlwncePlus());
				tempaturMap.put("firstDownrightAlwnceMinus", tempaturRead.getFirstDownrightAlwnceMinus());
				tempaturMap.put("push1UpCond", tempaturRead.getPush1UpCond());
				tempaturMap.put("push1UpAlwncePlus", tempaturRead.getPush1UpAlwncePlus());
				tempaturMap.put("push1UpAlwnceMinus", tempaturRead.getPush1UpAlwnceMinus());
				tempaturMap.put("push1DownCond", tempaturRead.getPush1DownCond());
				tempaturMap.put("push1DownAlwncePlus", tempaturRead.getPush1DownAlwncePlus());
				tempaturMap.put("push1DownAlwnceMinus", tempaturRead.getPush1DownAlwnceMinus());
				tempaturMap.put("secondUpleftCond", tempaturRead.getSecondUpleftCond());
				tempaturMap.put("secondUpleftAlwncePlus", tempaturRead.getSecondUpleftAlwncePlus());
				tempaturMap.put("secondUpleftAlwnceMinus", tempaturRead.getSecondUpleftAlwnceMinus());
				tempaturMap.put("secondDownleftCond", tempaturRead.getSecondDownleftCond());
				tempaturMap.put("secondDownleftAlwncePlus", tempaturRead.getSecondDownleftAlwncePlus());
				tempaturMap.put("secondDownleftAlwnceMinus", tempaturRead.getSecondDownleftAlwnceMinus());
				tempaturMap.put("secondUprightCond", tempaturRead.getSecondUprightCond());
				tempaturMap.put("secondUprightAlwncePlus", tempaturRead.getSecondUprightAlwncePlus());
				tempaturMap.put("secondUprightAlwnceMinus", tempaturRead.getSecondUprightAlwnceMinus());
				tempaturMap.put("secondDownrightCond", tempaturRead.getSecondDownrightCond());
				tempaturMap.put("secondDownrightAlwncePlus", tempaturRead.getSecondDownrightAlwncePlus());
				tempaturMap.put("secondDownrightAlwnceMinus", tempaturRead.getSecondDownrightAlwnceMinus());
				tempaturMap.put("thirdUpleftCond", tempaturRead.getThirdUpleftCond());
				tempaturMap.put("thirdUpleftAlwncePlus", tempaturRead.getThirdUpleftAlwncePlus());
				tempaturMap.put("thirdUpleftAlwnceMinus", tempaturRead.getThirdUpleftAlwnceMinus());
				tempaturMap.put("thirdDownleftCond", tempaturRead.getThirdDownleftCond());
				tempaturMap.put("thirdDownleftAlwncePlus", tempaturRead.getThirdDownleftAlwncePlus());
				tempaturMap.put("thirdDownleftAlwnceMinus", tempaturRead.getThirdDownleftAlwnceMinus());
				tempaturMap.put("thirdUprightCond", tempaturRead.getThirdUprightCond());
				tempaturMap.put("thirdUprightAlwncePlus", tempaturRead.getThirdUprightAlwncePlus());
				tempaturMap.put("thirdUprightAlwnceMinus", tempaturRead.getThirdUprightAlwnceMinus());
				tempaturMap.put("thirdDownrightCond", tempaturRead.getThirdDownrightCond());
				tempaturMap.put("thirdDownrightAlwncePlus", tempaturRead.getThirdDownrightAlwncePlus());
				tempaturMap.put("thirdDownrightAlwnceMinus", tempaturRead.getThirdDownrightAlwnceMinus());
				tempaturMap.put("jinjeop1UpCond", tempaturRead.getJinjeop1UpCond());
				tempaturMap.put("jinjeop1UpAlwncePlus", tempaturRead.getJinjeop1UpAlwncePlus());
				tempaturMap.put("jinjeop1UpAlwnceMinus", tempaturRead.getJinjeop1UpAlwnceMinus());
				tempaturMap.put("jinjeop1DownCond", tempaturRead.getJinjeop1DownCond());
				tempaturMap.put("jinjeop1DownAlwncePlus", tempaturRead.getJinjeop1DownAlwncePlus());
				tempaturMap.put("jinjeop1DownAlwnceMinus", tempaturRead.getJinjeop1DownAlwnceMinus());
				tempaturMap.put("jinjeop2UpCond", tempaturRead.getJinjeop2UpCond());
				tempaturMap.put("jinjeop2UpAlwncePlus", tempaturRead.getJinjeop2UpAlwncePlus());
				tempaturMap.put("jinjeop2UpAlwnceMinus", tempaturRead.getJinjeop2UpAlwnceMinus());
				tempaturMap.put("jinjeop2DownCond", tempaturRead.getJinjeop2DownCond());
				tempaturMap.put("jinjeop2DownAlwncePlus", tempaturRead.getJinjeop2DownAlwncePlus());
				tempaturMap.put("jinjeop2DownAlwnceMinus", tempaturRead.getJinjeop2DownAlwnceMinus());
			}
			jsonData.put("tempaturData", tempaturMap);

			if (timeRead != null) {
				timeMap.put("equipCondSeq", timeRead.getEquipCondSeq());
				timeMap.put("fitupCond", timeRead.getFitupCond());
				timeMap.put("fitupAlwncePlus", timeRead.getFitupAlwncePlus());
				timeMap.put("fitupAlwnceMinus", timeRead.getFitupAlwnceMinus());
				timeMap.put("fitup2Cond", timeRead.getFitup2Cond());
				timeMap.put("fitup2AlwncePlus", timeRead.getFitup2AlwncePlus());
				timeMap.put("fitup2AlwnceMinus", timeRead.getFitup2AlwnceMinus());
				timeMap.put("firstCond", timeRead.getFirstCond());
				timeMap.put("firstAlwncePlus", timeRead.getFirstAlwncePlus());
				timeMap.put("firstAlwnceMinus", timeRead.getFirstAlwnceMinus());
				timeMap.put("secondCond", timeRead.getSecondCond());
				timeMap.put("secondAlwncePlus", timeRead.getSecondAlwncePlus());
				timeMap.put("secondAlwnceMinus", timeRead.getSecondAlwnceMinus());
				timeMap.put("thirdCond", timeRead.getThirdCond());
				timeMap.put("thirdAlwncePlus", timeRead.getThirdAlwncePlus());
				timeMap.put("thirdAlwnceMinus", timeRead.getThirdAlwnceMinus());
				timeMap.put("jinjeopCond", timeRead.getJinjeopCond());
				timeMap.put("jinjeopAlwncePlus", timeRead.getJinjeopAlwncePlus());
				timeMap.put("jinjeopAlwnceMinus", timeRead.getJinjeopAlwnceMinus());
				timeMap.put("jinjeop2Cond", timeRead.getJinjeop2Cond());
				timeMap.put("jinjeop2AlwncePlus", timeRead.getJinjeop2AlwncePlus());
				timeMap.put("jinjeop2AlwnceMinus", timeRead.getJinjeop2AlwnceMinus());
				timeMap.put("push1Cond", timeRead.getPush1Cond());
				timeMap.put("push1AlwncePlus", timeRead.getPush1AlwncePlus());
				timeMap.put("push1AlwnceMinus", timeRead.getPush1AlwnceMinus());
				timeMap.put("reformCond", timeRead.getReformCond());
				timeMap.put("reformAlwncePlus", timeRead.getReformAlwncePlus());
				timeMap.put("reformAlwnceMinus", timeRead.getReformAlwnceMinus());
				timeMap.put("coolCond", timeRead.getCoolCond());
				timeMap.put("coolAlwncePlus", timeRead.getCoolAlwncePlus());
				timeMap.put("coolAlwnceMinus", timeRead.getCoolAlwnceMinus());
			}
			jsonData.put("timeData", timeMap);

			if (pressureRead != null) {
				pressureMap.put("equipCondSeq", pressureRead.getEquipCondSeq());
				pressureMap.put("fitupCond", pressureRead.getFitupCond());
				pressureMap.put("fitupAlwncePlus", pressureRead.getFitupAlwncePlus());
				pressureMap.put("fitupAlwnceMinus", pressureRead.getFitupAlwnceMinus());			
				pressureMap.put("push1Cond", pressureRead.getPush1Cond());
				pressureMap.put("push1AlwncePlus", pressureRead.getPush1AlwncePlus());
				pressureMap.put("push1AlwnceMinus", pressureRead.getPush1AlwnceMinus());
				pressureMap.put("secondCond", pressureRead.getSecondCond());
				pressureMap.put("secondAlwncePlus", pressureRead.getSecondAlwncePlus());
				pressureMap.put("secondAlwnceMinus", pressureRead.getSecondAlwnceMinus());
				pressureMap.put("jinjeopCond", pressureRead.getJinjeopCond());
				pressureMap.put("jinjeopAlwncePlus", pressureRead.getJinjeopAlwncePlus());
				pressureMap.put("jinjeopAlwnceMinus", pressureRead.getJinjeopAlwnceMinus());
				pressureMap.put("jinjeop2Cond", pressureRead.getJinjeop2Cond());
				pressureMap.put("jinjeop2AlwncePlus", pressureRead.getJinjeop2AlwncePlus());
				pressureMap.put("jinjeop2AlwnceMinus", pressureRead.getJinjeop2AlwnceMinus());
			}
			jsonData.put("pressureData", pressureMap);

			if (sizeRead != null) {
				sizeMap.put("equipCondSeq", sizeRead.getEquipCondSeq());
				sizeMap.put("wpLeftCond", sizeRead.getWpLeftCond());
				sizeMap.put("wpLeftAlwncePlus", sizeRead.getWpLeftAlwncePlus());
				sizeMap.put("wpLeftAlwnceMinus", sizeRead.getWpLeftAlwnceMinus());
				sizeMap.put("wpRightCond", sizeRead.getWpRightCond());
				sizeMap.put("wpRightAlwncePlus", sizeRead.getWpRightAlwncePlus());
				sizeMap.put("wpRightAlwnceMinus", sizeRead.getWpRightAlwnceMinus());
				sizeMap.put("pitchLeftCond", sizeRead.getPitchLeftCond());
				sizeMap.put("pitchLeftAlwncePlus", sizeRead.getPitchLeftAlwncePlus());
				sizeMap.put("pitchLeftAlwnceMinus", sizeRead.getPitchLeftAlwnceMinus());
				sizeMap.put("pitchRightCond", sizeRead.getPitchRightCond());
				sizeMap.put("pitchRightAlwncePlus", sizeRead.getPitchRightAlwncePlus());
				sizeMap.put("pitchRightAlwnceMinus", sizeRead.getPitchRightAlwnceMinus());
				sizeMap.put("ppfWingLeftCond", sizeRead.getPpfWingLeftCond());
				sizeMap.put("ppfWingLeftAlwncePlus", sizeRead.getPpfWingLeftAlwncePlus());
				sizeMap.put("ppfWingLeftAlwnceMinus", sizeRead.getPpfWingLeftAlwnceMinus());
				sizeMap.put("ppfWingRightCond", sizeRead.getPpfWingRightCond());
				sizeMap.put("ppfWingRightAlwncePlus", sizeRead.getPpfWingRightAlwncePlus());
				sizeMap.put("ppfWingRightAlwnceMinus", sizeRead.getPpfWingRightAlwnceMinus());
				sizeMap.put("ppfDepthLeftCond", sizeRead.getPpfDepthLeftCond());
				sizeMap.put("ppfDepthLeftAlwncePlus", sizeRead.getPpfDepthLeftAlwncePlus());
				sizeMap.put("ppfDepthLeftAlwnceMinus", sizeRead.getPpfDepthLeftAlwnceMinus());
				sizeMap.put("ppfDepthRightCond", sizeRead.getPpfDepthRightCond());
				sizeMap.put("ppfDepthRightAlwncePlus", sizeRead.getPpfDepthRightAlwncePlus());
				sizeMap.put("ppfDepthRightAlwnceMinus", sizeRead.getPpfDepthRightAlwnceMinus());
				sizeMap.put("filmCond", sizeRead.getFilmCond());
				sizeMap.put("filmAlwncePlus", sizeRead.getFilmAlwncePlus());
				sizeMap.put("filmAlwnceMinus", sizeRead.getFilmAlwnceMinus());
				sizeMap.put("metalDepthCond", sizeRead.getMetalDepthCond());
				sizeMap.put("metalDepthAlwncePlus", sizeRead.getMetalDepthAlwncePlus());
				sizeMap.put("metalDepthAlwnceMinus", sizeRead.getMetalDepthAlwnceMinus());
				sizeMap.put("metalThicknessCond", sizeRead.getMetalThicknessCond());
				sizeMap.put("metalThicknessAlwncePlus", sizeRead.getMetalThicknessAlwncePlus());
				sizeMap.put("metalThicknessAlwnceMinus", sizeRead.getMetalThicknessAlwnceMinus());
				sizeMap.put("thCenterCond", sizeRead.getThCenterCond());
				sizeMap.put("thCenterAlwncePlus", sizeRead.getThCenterAlwncePlus());
				sizeMap.put("thCenterAlwnceMinus", sizeRead.getThCenterAlwnceMinus());
				sizeMap.put("thEdgeCond", sizeRead.getThEdgeCond());
				sizeMap.put("thEdgeAlwncePlus", sizeRead.getThEdgeAlwncePlus());
				sizeMap.put("thEdgeAlwnceMinus", sizeRead.getThEdgeAlwnceMinus());
				sizeMap.put("burrCond", sizeRead.getBurrCond());
				sizeMap.put("burrAlwncePlus", sizeRead.getBurrAlwncePlus());
				sizeMap.put("burrAlwnceMinus", sizeRead.getBurrAlwnceMinus());
			}
			jsonData.put("sizeData", sizeMap);

			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("bom List만 조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//해당설비&해당날짜 작업지시 생성
	@RequestMapping(value = "/bm/workOrderPlanCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderPlanCreatePOST(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<>();
		logger.info("해당설비&해당날짜 작업지시 생성");
		workOrderPlanVo.setRegId(Utils.getUserId());

		try {
			workOrderPlanService.create(workOrderPlanVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("해당설비&해당날짜 작업지시 생성 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//해당설비&해당날짜 작업지시 수정
	@RequestMapping(value = "/bm/workOrderPlanUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderPlanUpdatePOST(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		logger.info("해당설비&해당날짜 작업지시 수정");
		Map<String, Object> jsonData = new HashMap<>();
		workOrderPlanVo.setUpdId(Utils.getUserId());

		try {
			workOrderPlanService.update(workOrderPlanVo);
			jsonData.put("data", workOrderPlanVo);
			jsonData.put("result", "ok");                                                            
		} catch (Exception e) {
			logger.info("해당설비&해당날짜 작업지시 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//일자별 작지계획 자동등록
	@RequestMapping(value = "/wm/workOrderPlanAutoCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderPlanAutoCreate(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		logger.info("해당날짜의 모든 설비 최근 제조조건 자동등록");
		Map<String, Object> jsonData = new HashMap<>();
		workOrderPlanVo.setRegId(Utils.getUserId());	//자동등록 등록자 확인하기
		try {
			workOrderPlanService.workPlanAutoCreate(workOrderPlanVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("일자별  제조조건 자동등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//기간별 작지계획 자동등록
	@RequestMapping(value = "/wm/chooseWorkOrderPlanAutoCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> chooseWorkOrderPlanAutoCreate(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		logger.info("해당날짜의 모든 설비 최근 제조조건 자동등록");
		Map<String, Object> jsonData = new HashMap<>();
		workOrderPlanVo.setRegId(Utils.getUserId());	//자동등록 등록자 확인하기
		try {
			//혹시모를 24시가 지나서 새로운날짜가 되었을때 예외사항 대비
			if ((DateUtil.getToday("yyyy-mm-dd").replaceAll("-", "")).equals(workOrderPlanVo.getServerDate())) {
				workOrderPlanService.chooseWorkPlanAutoCreate(workOrderPlanVo);
				jsonData.put("message", "등록되었습니다.");
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "시스템 일자가 변경되었습니다.<br>새로고침(F5) 후 다시 시도해 주세요!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("기간별 제조조건 자동등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
		
	//미사용 - workPlanAutoCreate 서비스에 Delete 포함되어 들어가 있음.
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	//@RequestMapping(value = "/wm/workOrderPlanAutoDelete", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> workOrderPlanAutoDelete(WorkOrderPlanVo workOrderPlanVo) throws Exception {
    //
	//	logger.info("해당날짜의 모든 설비 최근 제조조건 자동등록 삭제");
	//	Map<String, Object> jsonData = new HashMap<>();
	//	try {
	//		workOrderPlanService.workPlanAutoDelete(workOrderPlanVo);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("해당날짜의 모든 설비 최근 제조조건 자동등록 삭제실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
    //
	//	return jsonData;
	//}
	
	
	//제품(원재고현황)
	@RequestMapping(value = "/wmsc0090", method = RequestMethod.GET)
	public String wmsc0090(Locale locale, Model model) throws Exception {
		
		logger.info("생산계획등록 메인");

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("orderGubunCd", systemCommonCodeList);

		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEtc1("2222");
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		return "wm/wmsc0090";
	}
	
	//생산관리/생산계획 - DataTable Header 생성
	@RequestMapping(value = "/wm/createMonthPlanHeader", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> createMonthPlanHeader(String planDate) throws Exception {

		logger.info("생산계획 - DataTable Header 생성");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			//ajax로 선택한 yyyymm을 가져와서 해당 달의 최대 일 수를 구함
			int intYear = Integer.parseInt(planDate.substring(0, 4));
			int intMonth = Integer.parseInt(planDate.substring(4, 6));
			LocalDate newMonth = LocalDate.of(intYear, intMonth, 1);
			//선택 월의 최대 일 수
			int lengthOfMonth = newMonth.lengthOfMonth();
			String stringYear = planDate.substring(0, 4);
			String stringMonth = planDate.substring(4, 6);
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			//존재하는 날짜들
			List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
			for (int i = 1; i <= lengthOfMonth; i++) {
				Date date = dateFormat.parse(stringYear + "-" + stringMonth + "-" + Integer.toString(i));
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				//1일, 2월, 3화, 4수, 5목, 6금, 7토
				int dayNum = cal.get(Calendar.DAY_OF_WEEK);
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", i);
				map.put("countDay", i + "일");
				map.put("day", dayNum);
				listMap.add(map);
				
				//String day = "";
				//switch (dayNum) {
				//        case 1:
				//            day = "일";
				//            break ;
				//        case 2:
				//            day = "월";
				//            break ;
				//        case 3:
				//            day = "화";
				//            break ;
				//        case 4:
				//            day = "수";
				//            break ;
				//        case 5:
				//            day = "목";
				//            break ;
				//        case 6:
				//            day = "금";
				//            break ;
				//        case 7:
				//            day = "토";
				//            break ;
				//             
				//}
				//System.out.println(day);
				
			}
			
			//존재하지 않는 날짜들
			for (int i=lengthOfMonth; i<31; i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", i);
				map.put("countDay", "");
				map.put("day", 0);
				listMap.add(map);
			}
			
			jsonData.put("dayCount", lengthOfMonth);
			jsonData.put("data", listMap);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산계획 - DataTable Header 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	//생산관리/생산계획 - DataTable Data(List) 생성
	@RequestMapping(value = "/wm/readMonthPlanBody", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthPlanBody(ProductionPlanVo productionPlanVo) throws Exception {

		logger.info("생산계획 - DataTable Header 생성");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			//ajax로 선택한 yyyymm을 가져와서 해당 달의 최대 일 수를 구함
			//int intYear = Integer.parseInt(productionPlanVo.getPlanDate().substring(0, 4));
			//int intMonth = Integer.parseInt(productionPlanVo.getPlanDate().substring(4, 6));
			//LocalDate newMonth = LocalDate.of(intYear, intMonth, 1);
			//선택 월의 최대 일 수
			//int lengthOfMonth = newMonth.lengthOfMonth();

			//해당 년월로 계획월 조회
			//List<ProductionPlanVo> productionPlanList = workOrderPlanService.readProductionPlan(productionPlanVo);		
			
			
			//등록된 계획이 없으면 설비 개수만큼 List를 만들어 줌
			//if ( productionPlanList.isEmpty() ) {
			//	
			//	EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
			//	List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listAll(equipCodeAdmVo);
			//	SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			//	systemCommonCodeVo.setBaseGroupCd("050"); //생산계획등록 타입
			//	List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			//	
			//	for (int i=0; i<equipCodeAdmList.size(); i++) {
			//		ProductionPlanVo equipoCd001 = new ProductionPlanVo();
			//		ProductionPlanVo equipoCd002 = new ProductionPlanVo();
			//		ProductionPlanVo equipoCd003 = new ProductionPlanVo();
			//		equipoCd001.setEquipCd(equipCodeAdmList.get(i).getEquipCd());
			//		equipoCd001.setEquipNm(equipCodeAdmList.get(i).getEquipNm());
			//		equipoCd002.setEquipCd(equipCodeAdmList.get(i).getEquipCd());
			//		equipoCd002.setEquipNm(equipCodeAdmList.get(i).getEquipNm());
			//		equipoCd003.setEquipCd(equipCodeAdmList.get(i).getEquipCd());
			//		equipoCd003.setEquipNm(equipCodeAdmList.get(i).getEquipNm());
			//		
			//		equipoCd001.setCountTypeCd(systemCommonCodeList.get(0).getBaseCd());	//001
			//		equipoCd001.setCountTypeNm(systemCommonCodeList.get(0).getBaseCdNm());	//확정계획수량
			//		productionPlanList.add(equipoCd001);
			//		equipoCd002.setCountTypeCd(systemCommonCodeList.get(1).getBaseCd());	//002
			//		equipoCd002.setCountTypeNm(systemCommonCodeList.get(1).getBaseCdNm());	//운영계획수량
			//		productionPlanList.add(equipoCd002);
			//		equipoCd003.setCountTypeCd(systemCommonCodeList.get(2).getBaseCd());	//003
			//		equipoCd003.setCountTypeNm(systemCommonCodeList.get(2).getBaseCdNm());	//차이수량
			//		productionPlanList.add(equipoCd003);
			//	}
			//} else {
			//	
			//}
			//jsonData.put("data", productionPlanList);
			//jsonData.put("result", "ok");
			
			List<ProductionPlanVo> outputList = new ArrayList<ProductionPlanVo>();
			String matrlCd = "";
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			for(int i=1; i <= 31; i++) {
				
				planDateList += "[" + productionPlanVo.getPlanDate().toString();
				planDateList += String.format("%02d", i);
				planDateList += "],";
				
				planDateListSetter[i-1] = productionPlanVo.getPlanDate().toString() + String.format("%02d", i);
			}
			productionPlanVo.setDayList(planDateList.substring(0,planDateList.length()-1));
			List<Map<String, String>> list  = workOrderPlanService.readProductionPlanNew(productionPlanVo);
			
			for(Map<String, String> m : list) {
				ProductionPlanVo productionPlanVo2 = new ProductionPlanVo();
				productionPlanVo2.setEquipCd(m.get("EQUIP_CD").toString());
				productionPlanVo2.setEquipNm(m.get("EQUIP_NM").toString());
				productionPlanVo2.setCountTypeCd(m.get("COUNT_TYPE_CD").toString());
				productionPlanVo2.setCountTypeNm(m.get("COUNT_TYPE_NM").toString());
				
				float countSum = 0;
				for(int i=1; i <= 31; i++) {
					if(m.get(planDateListSetter[i-1]) != null) {
						String value = String.valueOf(m.get(planDateListSetter[i-1]));
						countSum += Float.parseFloat(value);
					} else {
						countSum += 0;
					}
					
				}			
				productionPlanVo2.setCountSum(Float.toString(countSum));
				
				if(m.get(planDateListSetter[0]) != null) {
					productionPlanVo2.setCount1((String.valueOf(m.get(planDateListSetter[0]))));
					productionPlanVo2.setCount2((String.valueOf(m.get(planDateListSetter[1]))));
					productionPlanVo2.setCount3((String.valueOf(m.get(planDateListSetter[2]))));
					productionPlanVo2.setCount4((String.valueOf(m.get(planDateListSetter[3]))));
					productionPlanVo2.setCount5((String.valueOf(m.get(planDateListSetter[4]))));
					productionPlanVo2.setCount6((String.valueOf(m.get(planDateListSetter[5]))));
					productionPlanVo2.setCount7((String.valueOf(m.get(planDateListSetter[6]))));
					productionPlanVo2.setCount8((String.valueOf(m.get(planDateListSetter[7]))));
					productionPlanVo2.setCount9((String.valueOf(m.get(planDateListSetter[8]))));
					productionPlanVo2.setCount10((String.valueOf(m.get(planDateListSetter[9]))));
					productionPlanVo2.setCount11((String.valueOf(m.get(planDateListSetter[10]))));
					productionPlanVo2.setCount12((String.valueOf(m.get(planDateListSetter[11]))));
					productionPlanVo2.setCount13((String.valueOf(m.get(planDateListSetter[12]))));
					productionPlanVo2.setCount14((String.valueOf(m.get(planDateListSetter[13]))));
					productionPlanVo2.setCount15((String.valueOf(m.get(planDateListSetter[14]))));
					productionPlanVo2.setCount16((String.valueOf(m.get(planDateListSetter[15]))));
					productionPlanVo2.setCount17((String.valueOf(m.get(planDateListSetter[16]))));
					productionPlanVo2.setCount18((String.valueOf(m.get(planDateListSetter[17]))));
					productionPlanVo2.setCount19((String.valueOf(m.get(planDateListSetter[18]))));
					productionPlanVo2.setCount20((String.valueOf(m.get(planDateListSetter[19]))));
					productionPlanVo2.setCount21((String.valueOf(m.get(planDateListSetter[20]))));
					productionPlanVo2.setCount22((String.valueOf(m.get(planDateListSetter[21]))));
					productionPlanVo2.setCount23((String.valueOf(m.get(planDateListSetter[22]))));
					productionPlanVo2.setCount24((String.valueOf(m.get(planDateListSetter[23]))));
					productionPlanVo2.setCount25((String.valueOf(m.get(planDateListSetter[24]))));
					productionPlanVo2.setCount26((String.valueOf(m.get(planDateListSetter[25]))));
					productionPlanVo2.setCount27((String.valueOf(m.get(planDateListSetter[26]))));
					productionPlanVo2.setCount28((String.valueOf(m.get(planDateListSetter[27]))));
					productionPlanVo2.setCount29((String.valueOf(m.get(planDateListSetter[28]))));
					productionPlanVo2.setCount30((String.valueOf(m.get(planDateListSetter[29]))));
					productionPlanVo2.setCount31((String.valueOf(m.get(planDateListSetter[30]))));
				} else {
							productionPlanVo2.setCount1("0");
							productionPlanVo2.setCount2("0");
							productionPlanVo2.setCount3("0");
							productionPlanVo2.setCount4("0");
							productionPlanVo2.setCount5("0");
							productionPlanVo2.setCount6("0");
							productionPlanVo2.setCount7("0");
							productionPlanVo2.setCount8("0");
							productionPlanVo2.setCount9("0");
							productionPlanVo2.setCount10("0");
							productionPlanVo2.setCount11("0");
							productionPlanVo2.setCount12("0");
							productionPlanVo2.setCount13("0");
							productionPlanVo2.setCount14("0");
							productionPlanVo2.setCount15("0");
							productionPlanVo2.setCount16("0");
							productionPlanVo2.setCount17("0");
							productionPlanVo2.setCount18("0");
							productionPlanVo2.setCount19("0");
							productionPlanVo2.setCount20("0");
							productionPlanVo2.setCount21("0");
							productionPlanVo2.setCount22("0");
							productionPlanVo2.setCount23("0");
							productionPlanVo2.setCount24("0");
							productionPlanVo2.setCount25("0");
							productionPlanVo2.setCount26("0");
							productionPlanVo2.setCount27("0");
							productionPlanVo2.setCount28("0");
							productionPlanVo2.setCount29("0");
							productionPlanVo2.setCount30("0");
							productionPlanVo2.setCount31("0");
				}
				
				
				outputList.add(productionPlanVo2);	
				
				
			}
			jsonData.put("data", outputList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산계획 - DataTable Header 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	
	
	//생산관리-생산계획 등록&수정 처리
	//@RequestMapping(value = "/wm/insertMonthPlan", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> insertMonthPlan(@RequestBody List<Map<String, Object>> dataList) throws Exception {
    //
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("생산관리-생산계획 등록&수정 처리 " + dataList);
	//	ProductionPlanVo productionPlanVo001 = new ProductionPlanVo();
	//	ProductionPlanVo productionPlanVo002 = new ProductionPlanVo();
	//	ProductionPlanVo productionPlanVo003 = new ProductionPlanVo();
	//	ProductionPlanVo[] ProductionPlanList = new ProductionPlanVo[dataList.size()];
	//	
	//	try {
	//		int i = 0;
	//		//planType이 001=확정계획수량, 002=운영계획수량, 003=차이수량
	//		for (Map<String, Object> m : dataList) {
	//			productionPlanVo001.setRegId(Utils.getUserId());
	//			productionPlanVo001.setUpdId(Utils.getUserId());
	//			productionPlanVo002.setRegId(Utils.getUserId());
	//			productionPlanVo002.setUpdId(Utils.getUserId());
	//			productionPlanVo003.setRegId(Utils.getUserId());
	//			productionPlanVo003.setUpdId(Utils.getUserId());
	//			
	//			String equipCd = m.get("equipCd").toString();
	//			String planDate = m.get("planDate").toString();
	//			String countTypeCd = m.get("countTypeCd").toString();
	//			int count1 = Integer.parseInt(m.get("count1").toString());
	//			int count2 = Integer.parseInt(m.get("count2").toString());
	//			int count3 = Integer.parseInt(m.get("count3").toString());
	//			int count4 = Integer.parseInt(m.get("count4").toString());
	//			int count5 = Integer.parseInt(m.get("count5").toString());
	//			int count6 = Integer.parseInt(m.get("count6").toString());
	//			int count7 = Integer.parseInt(m.get("count7").toString());
	//			int count8 = Integer.parseInt(m.get("count8").toString());
	//			int count9 = Integer.parseInt(m.get("count9").toString());
	//			int count10 = Integer.parseInt(m.get("count10").toString());
	//			int count11 = Integer.parseInt(m.get("count11").toString());
	//			int count12 = Integer.parseInt(m.get("count12").toString());
	//			int count13 = Integer.parseInt(m.get("count13").toString());
	//			int count14 = Integer.parseInt(m.get("count14").toString());
	//			int count15 = Integer.parseInt(m.get("count15").toString());
	//			int count16 = Integer.parseInt(m.get("count16").toString());
	//			int count17 = Integer.parseInt(m.get("count17").toString());
	//			int count18 = Integer.parseInt(m.get("count18").toString());
	//			int count19 = Integer.parseInt(m.get("count19").toString());
	//			int count20 = Integer.parseInt(m.get("count20").toString());
	//			int count21 = Integer.parseInt(m.get("count21").toString());
	//			int count22 = Integer.parseInt(m.get("count22").toString());
	//			int count23 = Integer.parseInt(m.get("count23").toString());
	//			int count24 = Integer.parseInt(m.get("count24").toString());
	//			int count25 = Integer.parseInt(m.get("count25").toString());
	//			int count26 = Integer.parseInt(m.get("count26").toString());
	//			int count27 = Integer.parseInt(m.get("count27").toString());
	//			int count28 = Integer.parseInt(m.get("count28").toString());
	//			int count29 = Integer.parseInt(m.get("count29").toString());
	//			int count30 = Integer.parseInt(m.get("count30").toString());
	//			int count31 = Integer.parseInt(m.get("count31").toString());
	//			
	//			int countSum = count1 + count2 + count3 + count4 + count5 + count6 + count7 + count8 + count9 + count10;
	//				countSum += count11 + count12 + count13 + count14 + count15 + count16 + count17 + count18 + count19 + count20;
	//				countSum += count21 + count22 + count23 + count24 + count25 + count26 + count27 + count28 + count29 + count30;
	//				countSum += count31;
	//			
	//			//확정계획수량
	//			if ( countTypeCd.equals("001") ) {
	//				productionPlanVo001.setEquipCd(equipCd);
	//				productionPlanVo001.setPlanDate(planDate);
	//				productionPlanVo001.setCountTypeCd(countTypeCd);
	//				productionPlanVo001.setCountSum(countSum);
	//				productionPlanVo001.setCount1(count1);
	//				productionPlanVo001.setCount2(count2);
	//				productionPlanVo001.setCount3(count3);
	//				productionPlanVo001.setCount4(count4);
	//				productionPlanVo001.setCount5(count5);
	//				productionPlanVo001.setCount6(count6);
	//				productionPlanVo001.setCount7(count7);
	//				productionPlanVo001.setCount8(count8);
	//				productionPlanVo001.setCount9(count9);
	//				productionPlanVo001.setCount10(count10);
	//				productionPlanVo001.setCount11(count11);
	//				productionPlanVo001.setCount12(count12);
	//				productionPlanVo001.setCount13(count13);
	//				productionPlanVo001.setCount14(count14);
	//				productionPlanVo001.setCount15(count15);
	//				productionPlanVo001.setCount16(count16);
	//				productionPlanVo001.setCount17(count17);
	//				productionPlanVo001.setCount18(count18);
	//				productionPlanVo001.setCount19(count19);
	//				productionPlanVo001.setCount20(count20);
	//				productionPlanVo001.setCount21(count21);
	//				productionPlanVo001.setCount22(count22);
	//				productionPlanVo001.setCount23(count23);
	//				productionPlanVo001.setCount24(count24);
	//				productionPlanVo001.setCount25(count25);
	//				productionPlanVo001.setCount26(count26);
	//				productionPlanVo001.setCount27(count27);
	//				productionPlanVo001.setCount28(count28);
	//				productionPlanVo001.setCount29(count29);
	//				productionPlanVo001.setCount30(count30);
	//				productionPlanVo001.setCount31(count31);
	//				
	//				ProductionPlanList[i] = productionPlanVo001;
	//				//System.out.println(i + " - " + ProductionPlanList[i]);
	//				
	//			//운영계획수량
	//			} else if ( countTypeCd.equals("002") ) {
	//				productionPlanVo002.setEquipCd(equipCd);
	//				productionPlanVo002.setPlanDate(planDate);
	//				productionPlanVo002.setCountTypeCd(countTypeCd);
	//				productionPlanVo002.setCountSum(countSum);
	//				productionPlanVo002.setCount1(count1);
	//				productionPlanVo002.setCount2(count2);
	//				productionPlanVo002.setCount3(count3);
	//				productionPlanVo002.setCount4(count4);
	//				productionPlanVo002.setCount5(count5);
	//				productionPlanVo002.setCount6(count6);
	//				productionPlanVo002.setCount7(count7);
	//				productionPlanVo002.setCount8(count8);
	//				productionPlanVo002.setCount9(count9);
	//				productionPlanVo002.setCount10(count10);
	//				productionPlanVo002.setCount11(count11);
	//				productionPlanVo002.setCount12(count12);
	//				productionPlanVo002.setCount13(count13);
	//				productionPlanVo002.setCount14(count14);
	//				productionPlanVo002.setCount15(count15);
	//				productionPlanVo002.setCount16(count16);
	//				productionPlanVo002.setCount17(count17);
	//				productionPlanVo002.setCount18(count18);
	//				productionPlanVo002.setCount19(count19);
	//				productionPlanVo002.setCount20(count20);
	//				productionPlanVo002.setCount21(count21);
	//				productionPlanVo002.setCount22(count22);
	//				productionPlanVo002.setCount23(count23);
	//				productionPlanVo002.setCount24(count24);
	//				productionPlanVo002.setCount25(count25);
	//				productionPlanVo002.setCount26(count26);
	//				productionPlanVo002.setCount27(count27);
	//				productionPlanVo002.setCount28(count28);
	//				productionPlanVo002.setCount29(count29);
	//				productionPlanVo002.setCount30(count30);
	//				productionPlanVo002.setCount31(count31);
	//				
	//				ProductionPlanList[i] = productionPlanVo002;
	//				//System.out.println(i + " - " + ProductionPlanList[i]);
	//				
	//			} else if ( countTypeCd.equals("003") ) {
	//				
	//				productionPlanVo003.setEquipCd(equipCd);
	//				productionPlanVo003.setPlanDate(planDate);
	//				productionPlanVo003.setCountTypeCd(countTypeCd);
	//				productionPlanVo003.setCountSum(productionPlanVo001.getCountSum()-productionPlanVo002.getCountSum());
	//				productionPlanVo003.setCount1(productionPlanVo001.getCount1()-productionPlanVo002.getCount1());
	//				productionPlanVo003.setCount2(productionPlanVo001.getCount2()-productionPlanVo002.getCount2());
	//				productionPlanVo003.setCount3(productionPlanVo001.getCount3()-productionPlanVo002.getCount3());
	//				productionPlanVo003.setCount4(productionPlanVo001.getCount4()-productionPlanVo002.getCount4());
	//				productionPlanVo003.setCount5(productionPlanVo001.getCount5()-productionPlanVo002.getCount5());
	//				productionPlanVo003.setCount6(productionPlanVo001.getCount6()-productionPlanVo002.getCount6());
	//				productionPlanVo003.setCount7(productionPlanVo001.getCount7()-productionPlanVo002.getCount7());
	//				productionPlanVo003.setCount8(productionPlanVo001.getCount8()-productionPlanVo002.getCount8());
	//				productionPlanVo003.setCount9(productionPlanVo001.getCount9()-productionPlanVo002.getCount9());
	//				productionPlanVo003.setCount10(productionPlanVo001.getCount10()-productionPlanVo002.getCount10());
	//				productionPlanVo003.setCount11(productionPlanVo001.getCount11()-productionPlanVo002.getCount11());
	//				productionPlanVo003.setCount12(productionPlanVo001.getCount12()-productionPlanVo002.getCount12());
	//				productionPlanVo003.setCount13(productionPlanVo001.getCount13()-productionPlanVo002.getCount13());
	//				productionPlanVo003.setCount14(productionPlanVo001.getCount14()-productionPlanVo002.getCount14());
	//				productionPlanVo003.setCount15(productionPlanVo001.getCount15()-productionPlanVo002.getCount15());
	//				productionPlanVo003.setCount16(productionPlanVo001.getCount16()-productionPlanVo002.getCount16());
	//				productionPlanVo003.setCount17(productionPlanVo001.getCount17()-productionPlanVo002.getCount17());
	//				productionPlanVo003.setCount18(productionPlanVo001.getCount18()-productionPlanVo002.getCount18());
	//				productionPlanVo003.setCount19(productionPlanVo001.getCount19()-productionPlanVo002.getCount19());
	//				productionPlanVo003.setCount20(productionPlanVo001.getCount20()-productionPlanVo002.getCount20());
	//				productionPlanVo003.setCount21(productionPlanVo001.getCount21()-productionPlanVo002.getCount21());
	//				productionPlanVo003.setCount22(productionPlanVo001.getCount22()-productionPlanVo002.getCount22());
	//				productionPlanVo003.setCount23(productionPlanVo001.getCount23()-productionPlanVo002.getCount23());
	//				productionPlanVo003.setCount24(productionPlanVo001.getCount24()-productionPlanVo002.getCount24());
	//				productionPlanVo003.setCount25(productionPlanVo001.getCount25()-productionPlanVo002.getCount25());
	//				productionPlanVo003.setCount26(productionPlanVo001.getCount26()-productionPlanVo002.getCount26());
	//				productionPlanVo003.setCount27(productionPlanVo001.getCount27()-productionPlanVo002.getCount27());
	//				productionPlanVo003.setCount28(productionPlanVo001.getCount28()-productionPlanVo002.getCount28());
	//				productionPlanVo003.setCount29(productionPlanVo001.getCount29()-productionPlanVo002.getCount29());
	//				productionPlanVo003.setCount30(productionPlanVo001.getCount30()-productionPlanVo002.getCount30());
	//				productionPlanVo003.setCount31(productionPlanVo001.getCount31()-productionPlanVo002.getCount31());
	//				
	//				ProductionPlanList[i] = productionPlanVo003;
	//				
	//				productionPlanVo001 = new ProductionPlanVo();
	//				productionPlanVo002 = new ProductionPlanVo();
	//				productionPlanVo003 = new ProductionPlanVo();
	//			}
	//			
	//			i++;
	//		}
    //
	//		//해당 계획 월 전체 삭제
	//		workOrderPlanService.deleteProductionPlan(ProductionPlanList[0]);
	//		
	//		for (int a = 0; a < dataList.size(); a++) {
	//			workOrderPlanService.createProductionPlan(ProductionPlanList[a]);
	//		}
	//		
	//		jsonData.put("message", "저장되었습니다.");
	//		jsonData.put("result", "ok");
	//		
	//
	//	} catch (Exception e) {
	//		logger.info("생산관리-생산계획 등록&수정 처리");
	//		
	//		//해당planDate 모두 삭제? 등록일경우 모두삭제하면되는데 수정일경우엔?
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템 에러가 발생하였습니다");
	//		jsonData.put("result", "fail");
	//	}
    //
	//	return jsonData;
	//}
	
	//생산관리-생산계획 등록&수정 처리
	@RequestMapping(value = "/wm/insertMonthPlan", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertMonthPlan(@RequestBody List<Map<String, Object>> dataList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산관리-생산계획 등록&수정 처리 " + dataList);
		ProductionPlanVo productionPlanVo = new ProductionPlanVo();
		productionPlanVo.setPlanDate(dataList.get(0).get("planDate").toString());
		
		try {
			workOrderPlanService.deleteProductionPlan(productionPlanVo);
			for (Map<String, Object> m : dataList) {
				
				productionPlanVo = new ProductionPlanVo();
				String equipCd = m.get("equipCd").toString();
				String planDate = m.get("planDate").toString();
				String countTypeCd = m.get("countTypeCd").toString();			
				String[] count = new String[31];				
				
				productionPlanVo.setEquipCd(equipCd);
				productionPlanVo.setPlanDate(planDate.substring(0,6));
				productionPlanVo.setCountTypeCd(countTypeCd);	
				productionPlanVo.setRegId(Utils.getUserId());
				productionPlanVo.setUpdId(Utils.getUserId());		
				
			
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
					ProductionPlanVo productionPlanVo2 = new ProductionPlanVo();	
					productionPlanVo2.setEquipCd(equipCd);
					productionPlanVo2.setPlanDate(planDate.substring(0,6) + String.format("%02d", i+1));
					productionPlanVo2.setCountTypeCd(countTypeCd);	
					productionPlanVo2.setCnt(count[i]);		
					productionPlanVo2.setRegId(Utils.getUserId());
					productionPlanVo2.setUpdId(Utils.getUserId());		
					
					workOrderPlanService.createProductionPlan(productionPlanVo2);
					
				}			
				
				
			}
		
			jsonData.put("message", "저장되었습니다.");
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
		
		
	//월별 FP현황(설비별)
	@RequestMapping(value = "/wmsc0100", method = RequestMethod.GET)
	public String wmsc0100(Locale locale, Model model) throws Exception {
		
		logger.info("월별 FP현황(설비별)");

		//model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterDate",DateUtil.getDay("yyyy-mm-dd", -1));
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("orderGubunCd", systemCommonCodeList);

		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCodeAdmList", equipCodeAdmList);
		
		return "wm/wmsc0100";
	}
	
	//생산관리 - 작업지시 페이지 -> 솔브레인SLD
	@RequestMapping(value = "/wmsc3010", method = RequestMethod.GET)
	public String wmsc3010(Locale locale, Model model) throws Exception {

		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		//systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("equipGroupCd", systemCommonCodeList);
		
        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc3010";
	}
	
	//생산관리 - 작업지시 페이지 -> 솔브레인SLD
	@RequestMapping(value = "/wmsc3020", method = RequestMethod.GET)
	public String wmsc3020(Locale locale, Model model) throws Exception {
		logger.info("작업지시(설비별 생산계획) 메인");

        model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
        model.addAttribute("serverDateFuture", DateUtil.getDay("yyyy-mm-dd", 6));
        
		return "wm/wmsc3020";
	}

		
	
	//월별 FP현황(설비별)
		@RequestMapping(value = "/wmsc0120", method = RequestMethod.GET)
		public String wmsc0120(Locale locale, Model model) throws Exception {
			
			logger.info("월별 FP현황(설비별)");

			model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
			//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			//systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
			//List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			//model.addAttribute("orderGubunCd", systemCommonCodeList);

			EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
			List<EquipCodeAdmVo> equipCodeAdmList = equipCodeAdmService.listAll(equipCodeAdmVo);
			model.addAttribute("equipCodeAdmList", equipCodeAdmList);
			
			return "wm/wmsc0120";
		}
	
	//월별 FP현황(설비별)
	@RequestMapping(value = "/wm/readMonthProductPresentBody", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthProductPresentBody(MonthProductPresentVo monthProductPresentVo) throws Exception {

		logger.info("월별 FP현황(설비별) Body Read");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			//String toDay = DateUtil.getToday("yyyymmdd");
			//String toDay = DateUtil.getDay("yyyymmdd", -1);
			
			//검색 월이 오늘과 같으면.
			//if(toDay.substring(0, 6).equals(monthProductPresentVo.getPlanDate().substring(0,6))){
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + toDay.substring(6,8));
			//} else { //검색 월이 오늘과 다르면. 				
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + "31");
			//}
			
			//검색일자를 사용자가 선택하도록 하였음
			monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate().substring(0,6) + "01");
			monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate());
			
			for(int i=1; i <= 31; i++) {
				planDateList += "[" + monthProductPresentVo.getPlanDate().toString().substring(0,6);
				planDateList += String.format("%02d", i);
				planDateList += "],";				
				planDateListSetter[i-1] = monthProductPresentVo.getPlanDate().toString() + String.format("%02d", i);
			}
			monthProductPresentVo.setDayList(planDateList.substring(0,planDateList.length()-1));
			logger.info("검색 기간 : " + planDateList);
			
			//해당 년월로 계획월 조회
			List<MonthProductPresentVo> productionPlanList = workOrderPlanService.readMonthProductPresentBody(monthProductPresentVo);
			List<MonthProductPresentVo> productionPlanListNew = new ArrayList<MonthProductPresentVo>();
			for(MonthProductPresentVo m : productionPlanList) {
				m.setPlanDate(monthProductPresentVo.getPlanDate());
				productionPlanListNew.add(m);
			}
			
			jsonData.put("data", productionPlanListNew);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산계획 - DataTable Header 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//월별 FP현황(설비별)
	@RequestMapping(value = "/wm/readMonthProductPresentBodyOnlyHeader", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthProductPresentBodyOnlyHeader(MonthProductPresentVo monthProductPresentVo) throws Exception {

		logger.info("월별 FP현황(설비별) Header Read");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			
			//String toDay = DateUtil.getToday("yyyymmdd");
			String toDay = DateUtil.getDay("yyyymmdd", -1);
			
			
			//검색 월이 오늘과 같으면.
			//if(toDay.substring(0, 6).equals(monthProductPresentVo.getPlanDate().substring(0,6))){
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + toDay.substring(6,8));
			//} else { //검색 월이 오늘과 다르면. 				
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + "31");
			//}
			
			//검색일자를 사용자가 선택하도록 하였음
			monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate().substring(0,6) + "01");
			monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate());
			
			for(int i=1; i <= 31; i++) {
				planDateList += "[" + monthProductPresentVo.getPlanDate().toString().substring(0,6);
				planDateList += String.format("%02d", i);
				planDateList += "],";				
				planDateListSetter[i-1] = monthProductPresentVo.getPlanDate().toString() + String.format("%02d", i);
			}
			logger.info("검색 기간 : " + planDateList);
			monthProductPresentVo.setDayList(planDateList.substring(0,planDateList.length()-1));
			
			//해당 년월로 계획월 조회
			List<MonthProductPresentVo> productionPlanList = workOrderPlanService.readMonthProductPresentBodyHeaderOnly(monthProductPresentVo);
			List<MonthProductPresentVo> productionPlanListNew = new ArrayList<MonthProductPresentVo>();
			for(MonthProductPresentVo m : productionPlanList) {
				m.setPlanDate(monthProductPresentVo.getPlanDate());
				productionPlanListNew.add(m);
			}
			
			jsonData.put("data", productionPlanListNew);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산계획 - DataTable Header 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//월별 FP현황(설비별)
	@RequestMapping(value = "/wm/readMonthProductPresentBody2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readMonthProductPresentBody2(MonthProductPresentVo monthProductPresentVo) throws Exception {

		logger.info("월별 FP현황(설비별) Body Read2");
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String planDateList = "";
			String[] planDateListSetter = new String[31];
			//String toDay = DateUtil.getToday("yyyymmdd");
			String toDay = DateUtil.getDay("yyyymmdd", -1);
			
			//검색 월이 오늘과 같으면.
			//if(toDay.substring(0, 6).equals(monthProductPresentVo.getPlanDate().substring(0,6))){
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + toDay.substring(6,8));
			//} else { //검색 월이 오늘과 다르면. 				
			//	monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate() + "01");
			//	monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate() + "31");
			//}
			
			//검색일자를 사용자가 선택하도록 하였음
			monthProductPresentVo.setStartDate(monthProductPresentVo.getPlanDate().substring(0,6) + "01");
			monthProductPresentVo.setEndDate(monthProductPresentVo.getPlanDate());
			
			for(int i=1; i <= 31; i++) {
				planDateList += "[" + monthProductPresentVo.getPlanDate().toString().substring(0,6);
				planDateList += String.format("%02d", i);
				planDateList += "],";				
				planDateListSetter[i-1] = monthProductPresentVo.getPlanDate().toString() + String.format("%02d", i);
			}
			logger.info("검색 기간 : " + planDateList);
			monthProductPresentVo.setDayList(planDateList.substring(0,planDateList.length()-1));
			
			//해당 년월로 계획월 조회
			List<MonthProductPresentVo> productionPlanList = workOrderPlanService.readMonthProductPresentBody2(monthProductPresentVo);
			
			jsonData.put("data", productionPlanList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("생산계획 - DataTable Header 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//해당설비&일자의 작지계획 목록
	@RequestMapping(value = "/wm/equipWorkOrdPlanList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipWorkOrdPlanList(WorkOrderPlanVo workOrderPlanVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정실적관리(POP)/작업지시선택 - 작지 동적 추가할 작지계획List - " + workOrderPlanVo);
		
		try {
			List<WorkOrderPlanVo> equiopWorkOrdPlanList = workOrderPlanService.equipWorkOrdPlanList(workOrderPlanVo);
			jsonData.put("data", equiopWorkOrdPlanList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("해당설비&해당날짜 작업지시 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//선택 제조조건으로 작지번호 조합
	@RequestMapping(value = "/wm/createWorkOrder", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> createWorkOrder(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선택 제조조건으로 작지번호 조합 - " + workOrderVo);

		try {
			WorkOrderPlanVo workOrderPlanVo = new WorkOrderPlanVo();
			workOrderPlanVo.setEquipCondSeq(workOrderVo.getEquipCondSeq());
			workOrderPlanVo.setEquipCd(workOrderVo.getEquipCd());
			workOrderPlanVo.setPlanRegDate(workOrderVo.getOrdDate());
			workOrderPlanVo.setWorkGubunCd(workOrderVo.getOrdGubun());
			workOrderPlanVo = workOrderPlanService.readWorkOrderPlan(workOrderPlanVo);
			if (workOrderPlanVo == null) {
				jsonData.put("message", "해당 제조조건이 존재하지 않습니다<br>새로고침 후 다시 시도해 주세요!");
				jsonData.put("result", "fail");				
			} else {
				//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
				//systemCommonCodeVo.setBaseGroupCd("034");
				//systemCommonCodeVo.setBaseCd("B");
				//systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
				//workOrderPlanDay.setWorkStatusCd(systemCommonCodeVo.getBaseCd());
				//workOrderPlanDay.setWorkStatusNm(systemCommonCodeVo.getBaseCdAbbr());
				workOrderVo.setEquipCd(workOrderPlanVo.getEquipCd());
				workOrderVo.setOrdDate(workOrderPlanVo.getPlanRegDate());
				String workOrdNo = workOrderService.workOrdNoSeq(workOrderVo);
				logger.info(workOrdNo);
				
				workOrderVo.setWorkOrdNo(workOrdNo);
				workOrderVo.setGoodsCd(workOrderPlanVo.getGoodsCd());
				workOrderVo.setDealCorpCd(workOrderPlanVo.getDealCorpCd());		//해당제품정보의 출고처 자동선택
				workOrderVo.setOrdGubun(workOrderPlanVo.getWorkGubunCd());
				workOrderVo.setEquipCondSeq(workOrderPlanVo.getEquipCondSeq());
				workOrderVo.setWorkStatusCd("B");
				workOrderVo.setRegId(Utils.getUserId());
				workOrderService.createWorkOrder(workOrderVo);
				
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			logger.info("해당설비&해당날짜 작업지시 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//메모 등록
	@RequestMapping(value = "/wm/createMemo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createMemo(MonthProductPresentVo monthProductPresentVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모등록");
		
		try {			
			MonthProductPresentVo monthProductPresentVo2 = workOrderPlanService.memoList(monthProductPresentVo);			
			
			if(monthProductPresentVo2 == null) {
				monthProductPresentVo.setRegId(Utils.getUserId());
				workOrderPlanService.memoCreate(monthProductPresentVo);		
			} else {
				monthProductPresentVo.setUpdId(Utils.getUserId());
				workOrderPlanService.memoUpdate(monthProductPresentVo);			
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
	
	//메모 수정
	@RequestMapping(value = "/wm/updateMemo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateMemo(MonthProductPresentVo monthProductPresentVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모 수정");

		try {			
			monthProductPresentVo.setUpdId(Utils.getUserId());
			workOrderPlanService.memoUpdate(monthProductPresentVo);			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("메모 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//메모 삭제
	@RequestMapping(value = "/wm/deleteMemo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMemo(MonthProductPresentVo monthProductPresentVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모 삭제");

		try {			
			workOrderPlanService.memoDelete(monthProductPresentVo);			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("메모 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//메모 등록
	@RequestMapping(value = "/wm/memoDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> memoDataList(MonthProductPresentVo monthProductPresentVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메모 조회");

		try {					
			monthProductPresentVo = workOrderPlanService.memoList(monthProductPresentVo);			
			jsonData.put("result", "ok");
			jsonData.put("data", monthProductPresentVo);
		} catch (Exception e) {
			logger.info("메모 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
}