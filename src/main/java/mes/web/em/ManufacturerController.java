package mes.web.em;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipCondCommonAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.em.ManufacturerVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.em.ManufacturerService;
import mes.web.ut.Utils;

@Controller
public class ManufacturerController {

	@Inject
	private ManufacturerService manufacturerService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;

	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(ManufacturerController.class);	
	
	// 설비코드관리 페이지
	@RequestMapping(value = "/emsc0020", method = RequestMethod.GET)
	public String emsc0020GET(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList );
		
		return "em/emsc0020";
	}
	
	// 설비코드관리 페이지
	@RequestMapping(value = "/emsc3020", method = RequestMethod.GET)
	public String emsc3020GET(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList );
		
		return "em/emsc3020";
	}
	
	// 설비코드관리 페이지
	@RequestMapping(value = "/eisc0030", method = RequestMethod.GET)
	public String eisc0030GET(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList );
		
		return "ei/eisc0030";
	}

	//제조조건관리 설비 계획 목록 조회
	@RequestMapping(value = "/em/manufacturerDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> manufacturerDataListGET(ManufacturerVo manufacturerVo) throws Exception {
		
		logger.info("제조조건관리 설비 계획 목록 조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		
		try {
			List<ManufacturerVo> ManufacturerVoList= manufacturerService.listAll(manufacturerVo);
			jsonData.put("data", ManufacturerVoList);
		} catch (Exception e) {
			logger.info("제조조건관리 설비 계획 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;		
	}
	
	//제조조건관리 계획 상세 조회
	@RequestMapping(value = "/em/manufacturerData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> manufacturerDataGET(ManufacturerVo manufacturerVo) throws Exception {
		
		logger.info("제조조건관리 계획 상세 조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		try {
			ManufacturerVo ManufacturerVoList= manufacturerService.read(manufacturerVo);
			jsonData.put("data", ManufacturerVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제조조건관리 계획 상세 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	// 설비코드 클릭 시 해당 설비 계획 목록 조회
	@RequestMapping(value = "/em/manufacturerPlanListRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> manufacturerPlanListReadGET (EquipCondCommonAdmVo equipCondCommonAdmVo) throws Exception {
		
		logger.info("설비코드 클릭 시 해당 설비 계획 목록 조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		
		try {
			List<ManufacturerVo> ManufacturerRead= manufacturerService.listRead(equipCondCommonAdmVo);
			jsonData.put("data", ManufacturerRead);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비코드 클릭 시 해당 설비 계획 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	// 제품코드 상세조회
	@RequestMapping(value = "/em/manufacturerRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> manufacturerReadGET(ManufacturerVo manufacturerVo) throws Exception {
		
		logger.info("제품코드 상세조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		
		try {
			ManufacturerVo ManufacturerRead= manufacturerService.read(manufacturerVo);
			jsonData.put("data", ManufacturerRead);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품코드 상세조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//설비 계획 등록
	@RequestMapping(value = "/em/equipCondCommonAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCondCommonAdmCreatePOST(@RequestBody List<Map<String, Object>> bomList, HttpServletRequest request) throws Exception {

		logger.info("설비계획 등록");
		logger.info("제조조건관리 - 설비계획 등록 BOM 조건 = "+ bomList);
		Map<String, Object> jsonData = new HashMap<String, Object>();
		EquipTempaturCondAdm equipTempaturCondAdm = new EquipTempaturCondAdm();
		EquipCondBomAdmVo equipCondBomAdmVo = new EquipCondBomAdmVo();
		EquipCondCommonAdmVo equipCondCommonAdmVo = new EquipCondCommonAdmVo();
		int fpGubunCnt = 0;
		int i = 0;
		String equipCondSeq = manufacturerService.selectEquipCondSeq();
		logger.info("생성할 Seq 번호 : " + equipCondSeq);
		equipTempaturCondAdm.setEquipCondSeq(equipCondSeq); 
		equipTempaturCondAdm.setRegId(Utils.getUserId());
		equipCondCommonAdmVo.setEquipCondSeq(equipCondSeq);
		equipCondCommonAdmVo.setRegId(Utils.getUserId());
		equipCondBomAdmVo.setEquipCondSeq(equipCondSeq);
		equipCondBomAdmVo.setRegId(Utils.getUserId());
		
		equipCondCommonAdmVo.setEquipCd(bomList.get(0).get("equipCd").toString());
		
		try {	
			
			if(bomList.get(0).get("fpMainGubun").toString().equals("001")) {			
				equipCondCommonAdmVo.setFactoryCode(factoryCode);
				manufacturerService.deleteFpMainGubun(equipCondCommonAdmVo);	
				logger.info("팩토리코드 : "+equipCondCommonAdmVo.getFactoryCode());
			}	
			
			
			
			for(Map<String, Object> m : bomList) {
				logger.info("i 값 : "+i);
				logger.info("m ===> " + m);
				if ( i==0 ) {	//설비조건공통관리
					equipCondCommonAdmVo.setEquipCd(m.get("equipCd").toString());
					equipCondCommonAdmVo.setGoodsCd(m.get("goodsCd").toString());
					equipCondCommonAdmVo.setFpUseYn(m.get("fpUseYn").toString());
					equipCondCommonAdmVo.setFpMainGubun(m.get("fpMainGubun").toString());					
	
					
					equipCondCommonAdmVo.setUseYnCd("Y");
					logger.info("공통코드 : " + equipCondCommonAdmVo);
					manufacturerService.equipCondCommonAdmcreate(equipCondCommonAdmVo);
				}
				else if( i==1 || i==2 || i==3) {
					if (i==1) {
						//온도 등록
						equipTempaturCondAdm.setWarmupCond(m.get("warmupCond").toString());
						equipTempaturCondAdm.setWarmupAlwncePlus(m.get("warmupAlwncePlus").toString());
						equipTempaturCondAdm.setWarmupAlwnceMinus(m.get("warmupAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup1UpCond(m.get("fitup1UpCond").toString());
						equipTempaturCondAdm.setFitup1UpAlwncePlus(m.get("fitup1UpAlwncePlus").toString());
						equipTempaturCondAdm.setFitup1UpAlwnceMinus(m.get("fitup1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup1DownCond(m.get("fitup1DownCond").toString());
						equipTempaturCondAdm.setFitup1DownAlwncePlus(m.get("fitup1DownAlwncePlus").toString());
						equipTempaturCondAdm.setFitup1DownAlwnceMinus(m.get("fitup1DownAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2UpleftCond(m.get("fitup2UpleftCond").toString());
						equipTempaturCondAdm.setFitup2UpleftAlwncePlus(m.get("fitup2UpleftAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2UpleftAlwnceMinus(m.get("fitup2UpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2DownleftCond(m.get("fitup2DownleftCond").toString());
						equipTempaturCondAdm.setFitup2DownleftAlwncePlus(m.get("fitup2DownleftAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2DownleftAlwnceMinus(m.get("fitup2DownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2UprightCond(m.get("fitup2UprightCond").toString());
						equipTempaturCondAdm.setFitup2UprightAlwncePlus(m.get("fitup2UprightAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2UprightAlwnceMinus(m.get("fitup2UprightAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2DownrightCond(m.get("fitup2DownrightCond").toString());
						equipTempaturCondAdm.setFitup2DownrightAlwncePlus(m.get("fitup2DownrightAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2DownrightAlwnceMinus(m.get("fitup2DownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setRollheatUpCond(m.get("rollheatUpCond").toString());
						equipTempaturCondAdm.setRollheatUpAlwncePlus(m.get("rollheatUpAlwncePlus").toString());
						equipTempaturCondAdm.setRollheatUpAlwnceMinus(m.get("rollheatUpAlwnceMinus").toString());
						equipTempaturCondAdm.setRollheatDownCond(m.get("rollheatDownCond").toString());
						equipTempaturCondAdm.setRollheatDownAlwncePlus(m.get("rollheatDownAlwncePlus").toString());
						equipTempaturCondAdm.setRollheatDownAlwnceMinus(m.get("rollheatDownAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstUpleftCond(m.get("firstUpleftCond").toString());
						equipTempaturCondAdm.setFirstUpleftAlwncePlus(m.get("firstUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setFirstUpleftAlwnceMinus(m.get("firstUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstDownleftCond(m.get("firstDownleftCond").toString());
						equipTempaturCondAdm.setFirstDownleftAlwncePlus(m.get("firstDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setFirstDownleftAlwnceMinus(m.get("firstDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstUprightCond(m.get("firstUprightCond").toString());
						equipTempaturCondAdm.setFirstUprightAlwncePlus(m.get("firstUprightAlwncePlus").toString());
						equipTempaturCondAdm.setFirstUprightAlwnceMinus(m.get("firstUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstDownrightCond(m.get("firstDownrightCond").toString());
						equipTempaturCondAdm.setFirstDownrightAlwncePlus(m.get("firstDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setFirstDownrightAlwnceMinus(m.get("firstDownrightAlwnceMinus").toString());
						
						equipTempaturCondAdm.setPush1UpCond(m.get("push1UpCond").toString());
						equipTempaturCondAdm.setPush1UpAlwncePlus(m.get("push1UpAlwncePlus").toString());
						equipTempaturCondAdm.setPush1UpAlwnceMinus(m.get("push1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setPush1DownCond(m.get("push1DownCond").toString());
						equipTempaturCondAdm.setPush1DownAlwncePlus(m.get("push1DownAlwncePlus").toString());
						equipTempaturCondAdm.setPush1DownAlwnceMinus(m.get("push1DownAlwnceMinus").toString());
												
						equipTempaturCondAdm.setSecondUpleftCond(m.get("secondUpleftCond").toString());
						equipTempaturCondAdm.setSecondUpleftAlwncePlus(m.get("secondUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setSecondUpleftAlwnceMinus(m.get("secondUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondDownleftCond(m.get("secondDownleftCond").toString());
						equipTempaturCondAdm.setSecondDownleftAlwncePlus(m.get("secondDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setSecondDownleftAlwnceMinus(m.get("secondDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondUprightCond(m.get("secondUprightCond").toString());
						equipTempaturCondAdm.setSecondUprightAlwncePlus(m.get("secondUprightAlwncePlus").toString());
						equipTempaturCondAdm.setSecondUprightAlwnceMinus(m.get("secondUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondDownrightCond(m.get("secondDownrightCond").toString());
						equipTempaturCondAdm.setSecondDownrightAlwncePlus(m.get("secondDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setSecondDownrightAlwnceMinus(m.get("secondDownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdUpleftCond(m.get("thirdUpleftCond").toString());
						equipTempaturCondAdm.setThirdUpleftAlwncePlus(m.get("thirdUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setThirdUpleftAlwnceMinus(m.get("thirdUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdDownleftCond(m.get("thirdDownleftCond").toString());
						equipTempaturCondAdm.setThirdDownleftAlwncePlus(m.get("thirdDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setThirdDownleftAlwnceMinus(m.get("thirdDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdUprightCond(m.get("thirdUprightCond").toString());
						equipTempaturCondAdm.setThirdUprightAlwncePlus(m.get("thirdUprightAlwncePlus").toString());
						equipTempaturCondAdm.setThirdUprightAlwnceMinus(m.get("thirdUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdDownrightCond(m.get("thirdDownrightCond").toString());
						equipTempaturCondAdm.setThirdDownrightAlwncePlus(m.get("thirdDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setThirdDownrightAlwnceMinus(m.get("thirdDownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop1UpCond(m.get("jinjeop1UpCond").toString());
						equipTempaturCondAdm.setJinjeop1UpAlwncePlus(m.get("jinjeop1UpAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop1UpAlwnceMinus(m.get("jinjeop1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop1DownCond(m.get("jinjeop1DownCond").toString());
						equipTempaturCondAdm.setJinjeop1DownAlwncePlus(m.get("jinjeop1DownAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop1DownAlwnceMinus(m.get("jinjeop1DownAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop2UpCond(m.get("jinjeop2UpCond").toString());
						equipTempaturCondAdm.setJinjeop2UpAlwncePlus(m.get("jinjeop2UpAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop2UpAlwnceMinus(m.get("jinjeop2UpAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop2DownCond(m.get("jinjeop2DownCond").toString());
						equipTempaturCondAdm.setJinjeop2DownAlwncePlus(m.get("jinjeop2DownAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop2DownAlwnceMinus(m.get("jinjeop2DownAlwnceMinus").toString());						
						
						equipCondBomAdmService.tempaturCreate(equipTempaturCondAdm);
					}
					else if (i==2) {
						//시간 등록
						equipCondBomAdmVo.setFitupCond(m.get("fitupCond").toString());
						equipCondBomAdmVo.setFitupAlwncePlus(m.get("fitupAlwncePlus").toString());
						equipCondBomAdmVo.setFitupAlwnceMinus(m.get("fitupAlwnceMinus").toString());
						equipCondBomAdmVo.setFitup2Cond(m.get("fitup2Cond").toString());
						equipCondBomAdmVo.setFitup2AlwncePlus(m.get("fitup2AlwncePlus").toString());
						equipCondBomAdmVo.setFitup2AlwnceMinus(m.get("fitup2AlwnceMinus").toString());
						equipCondBomAdmVo.setFirstCond(m.get("firstCond").toString());
						equipCondBomAdmVo.setFirstAlwncePlus(m.get("firstAlwncePlus").toString());
						equipCondBomAdmVo.setFirstAlwnceMinus(m.get("firstAlwnceMinus").toString());
						equipCondBomAdmVo.setSecondCond(m.get("secondCond").toString());
						equipCondBomAdmVo.setSecondAlwncePlus(m.get("secondAlwncePlus").toString());
						equipCondBomAdmVo.setSecondAlwnceMinus(m.get("secondAlwnceMinus").toString());
						
						equipCondBomAdmVo.setThirdCond(m.get("thirdCond").toString());
						equipCondBomAdmVo.setThirdAlwncePlus(m.get("thirdAlwncePlus").toString());
						equipCondBomAdmVo.setThirdAlwnceMinus(m.get("thirdAlwnceMinus").toString());
						
						equipCondBomAdmVo.setJinjeopCond(m.get("jinjeopCond").toString());
						equipCondBomAdmVo.setJinjeopAlwncePlus(m.get("jinjeopAlwncePlus").toString());
						equipCondBomAdmVo.setJinjeopAlwnceMinus(m.get("jinjeopAlwnceMinus").toString());
						
						equipCondBomAdmVo.setJinjeop2Cond(m.get("jinjeop2Cond").toString());
						equipCondBomAdmVo.setJinjeop2AlwncePlus(m.get("jinjeop2AlwncePlus").toString());
						equipCondBomAdmVo.setJinjeop2AlwnceMinus(m.get("jinjeop2AlwnceMinus").toString());
						equipCondBomAdmVo.setPush1Cond(m.get("push1Cond").toString());
						equipCondBomAdmVo.setPush1AlwncePlus(m.get("push1AlwncePlus").toString());
						equipCondBomAdmVo.setPush1AlwnceMinus(m.get("push1AlwnceMinus").toString());
												
						equipCondBomAdmVo.setReformCond(m.get("reformCond").toString());
						equipCondBomAdmVo.setReformAlwncePlus(m.get("reformAlwncePlus").toString());
						equipCondBomAdmVo.setReformAlwnceMinus(m.get("reformAlwnceMinus").toString());
						
						equipCondBomAdmVo.setCoolCond(m.get("coolCond").toString());
						equipCondBomAdmVo.setCoolAlwncePlus(m.get("coolAlwncePlus").toString());
						equipCondBomAdmVo.setCoolAlwnceMinus(m.get("coolAlwnceMinus").toString());
						
						equipCondBomAdmService.timeCreate(equipCondBomAdmVo);
					}
					else if (i==3) {
						//압력 등록
						equipCondBomAdmVo.setFitupCond(m.get("fitupCond").toString());
						equipCondBomAdmVo.setFitupAlwncePlus(m.get("fitupAlwncePlus").toString());
						equipCondBomAdmVo.setFitupAlwnceMinus(m.get("fitupAlwnceMinus").toString());
						equipCondBomAdmVo.setPush1Cond(m.get("push1Cond").toString());
						equipCondBomAdmVo.setPush1AlwncePlus(m.get("push1AlwncePlus").toString());
						equipCondBomAdmVo.setPush1AlwnceMinus(m.get("push1AlwnceMinus").toString());
						//equipCondBomAdmVo.setSecondCond(m.get("secondCond").toString());
						//equipCondBomAdmVo.setSecondAlwncePlus(m.get("secondAlwncePlus").toString());
						//equipCondBomAdmVo.setSecondAlwnceMinus(m.get("secondAlwnceMinus").toString());
						equipCondBomAdmVo.setJinjeopCond(m.get("jinjeopCond").toString());
						equipCondBomAdmVo.setJinjeopAlwncePlus(m.get("jinjeopAlwncePlus").toString());
						equipCondBomAdmVo.setJinjeopAlwnceMinus(m.get("jinjeopAlwnceMinus").toString());
						
						equipCondBomAdmVo.setJinjeop2Cond(m.get("jinjeop2Cond").toString());
						equipCondBomAdmVo.setJinjeop2AlwncePlus(m.get("jinjeop2AlwncePlus").toString());
						equipCondBomAdmVo.setJinjeop2AlwnceMinus(m.get("jinjeop2AlwnceMinus").toString());
						
						equipCondBomAdmService.pressureCreate(equipCondBomAdmVo);
					}
					logger.info("온도 시간 압력  = "+ equipCondBomAdmVo);
				}
				else if ( i==4 ) {
					//치수 등록
					//equipCondBomAdmVo.setWpLeftCond(m.get("wpLeftCond").toString());
					//equipCondBomAdmVo.setWpLeftAlwncePlus(m.get("wpLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setWpLeftAlwnceMinus(m.get("wpLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setWpRightCond(m.get("wpRightCond").toString());
					//equipCondBomAdmVo.setWpRightAlwncePlus(m.get("wpRightAlwncePlus").toString());
					//equipCondBomAdmVo.setWpRightAlwnceMinus(m.get("wpRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setPitchLeftCond(m.get("pitchLeftCond").toString());
					//equipCondBomAdmVo.setPitchLeftAlwncePlus(m.get("pitchLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPitchLeftAlwnceMinus(m.get("pitchLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPitchRightCond(m.get("pitchRightCond").toString());
					//equipCondBomAdmVo.setPitchRightAlwncePlus(m.get("pitchRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPitchRightAlwnceMinus(m.get("pitchRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfWingLeftCond(m.get("ppfWingLeftCond").toString());
					//equipCondBomAdmVo.setPpfWingLeftAlwncePlus(m.get("ppfWingLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfWingLeftAlwnceMinus(m.get("ppfWingLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfWingRightCond(m.get("ppfWingRightCond").toString());
					//equipCondBomAdmVo.setPpfWingRightAlwncePlus(m.get("ppfWingRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfWingRightAlwnceMinus(m.get("ppfWingRightAlwnceMinus").toString());	
					//equipCondBomAdmVo.setPpfDepthLeftCond(m.get("ppfDepthLeftCond").toString());
					//equipCondBomAdmVo.setPpfDepthLeftAlwncePlus(m.get("ppfDepthLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfDepthLeftAlwnceMinus(m.get("ppfDepthLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfDepthRightCond(m.get("ppfDepthRightCond").toString());
					//equipCondBomAdmVo.setPpfDepthRightAlwncePlus(m.get("ppfDepthRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfDepthRightAlwnceMinus(m.get("ppfDepthRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setFilmCond(m.get("filmCond").toString());
					//equipCondBomAdmVo.setFilmAlwncePlus(m.get("filmAlwncePlus").toString());
					//equipCondBomAdmVo.setFilmAlwnceMinus(m.get("filmAlwnceMinus").toString());
					//equipCondBomAdmVo.setMetalDepthCond(m.get("metalDepthCond").toString());
					//equipCondBomAdmVo.setMetalDepthAlwncePlus(m.get("metalDepthAlwncePlus").toString());
					//equipCondBomAdmVo.setMetalDepthAlwnceMinus(m.get("metalDepthAlwnceMinus").toString());
					//equipCondBomAdmVo.setMetalThicknessCond(m.get("metalThicknessCond").toString());
					//equipCondBomAdmVo.setMetalThicknessAlwncePlus(m.get("metalThicknessAlwncePlus").toString());
					//equipCondBomAdmVo.setMetalThicknessAlwnceMinus(m.get("metalThicknessAlwnceMinus").toString());
					//equipCondBomAdmVo.setThCenterCond(m.get("thCenterCond").toString());
					//equipCondBomAdmVo.setThCenterAlwncePlus(m.get("thCenterAlwncePlus").toString());
					//equipCondBomAdmVo.setThCenterAlwnceMinus(m.get("thCenterAlwnceMinus").toString());
					//equipCondBomAdmVo.setThEdgeCond(m.get("thEdgeCond").toString());
					//equipCondBomAdmVo.setThEdgeAlwncePlus(m.get("thEdgeAlwncePlus").toString());
					//equipCondBomAdmVo.setThEdgeAlwnceMinus(m.get("thEdgeAlwnceMinus").toString());
					//equipCondBomAdmVo.setGapOfLayerCond(m.get("gapOfLayerCond").toString());
					//equipCondBomAdmVo.setGapOfLayerPlus(m.get("gapOfLayerPlus").toString());
					//equipCondBomAdmVo.setGapOfLayerMinus(m.get("gapOfLayerMinus").toString());
					//equipCondBomAdmVo.setBurrCond(m.get("burrCond").toString());
					//equipCondBomAdmVo.setBurrAlwncePlus(m.get("burrAlwncePlus").toString());
					//equipCondBomAdmVo.setBurrAlwnceMinus(m.get("burrAlwnceMinus").toString());
					
					
					
					equipCondBomAdmVo.setMetalDepthCond(m.get("metalDepthCond").toString());
					equipCondBomAdmVo.setPitchLeftCond(m.get("pitchLeftCond").toString());
					equipCondBomAdmVo.setPpfDepthLeftCond(m.get("ppfDepthLeftCond").toString());
					equipCondBomAdmVo.setPpfDepthCenterCond(m.get("ppfDepthCenterCond").toString());
					equipCondBomAdmVo.setPpfDepthRightCond(m.get("ppfDepthRightCond").toString());
					equipCondBomAdmVo.setFilmCond(m.get("filmCond").toString());
					equipCondBomAdmVo.setWpLeftCond(m.get("wpLeftCond").toString());
					equipCondBomAdmVo.setWpCenterCond(m.get("wpCenterCond").toString());
					equipCondBomAdmVo.setWpRightCond(m.get("wpRightCond").toString());
					equipCondBomAdmVo.setWpDeviationCond(m.get("wpDeviationCond").toString());
					equipCondBomAdmVo.setX1X2Cond(m.get("x1X2Cond").toString());
					equipCondBomAdmVo.setPpfWingLeftCond(m.get("ppfWingLeftCond").toString());
					equipCondBomAdmVo.setPpfWingRightCond(m.get("ppfWingRightCond").toString());
					equipCondBomAdmVo.setMetalThicknessCond(m.get("metalThicknessCond").toString());
					equipCondBomAdmVo.setThEdgeCond(m.get("thEdgeCond").toString());
					equipCondBomAdmVo.setThCenterCond(m.get("thCenterCond").toString());
					equipCondBomAdmVo.setThEdgeRightCond(m.get("thEdgeRightCond").toString());
					equipCondBomAdmVo.setBurrCond(m.get("burrCond").toString());
					equipCondBomAdmVo.setGapOfLayerCond(m.get("gapOfLayerCond").toString());
					equipCondBomAdmVo.setBendingCond(m.get("bendingCond").toString());
					
					equipCondBomAdmVo.setMetalDepthAlwncePlus(m.get("metalDepthAlwncePlus").toString());
					equipCondBomAdmVo.setPitchLeftAlwncePlus(m.get("pitchLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthLeftAlwncePlus(m.get("ppfDepthLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthCenterAlwncePlus(m.get("ppfDepthCenterAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthRightAlwncePlus(m.get("ppfDepthRightAlwncePlus").toString());
					equipCondBomAdmVo.setFilmAlwncePlus(m.get("filmAlwncePlus").toString());
					equipCondBomAdmVo.setWpLeftAlwncePlus(m.get("wpLeftAlwncePlus").toString());
					equipCondBomAdmVo.setWpCenterAlwncePlus(m.get("wpCenterAlwncePlus").toString());
					equipCondBomAdmVo.setWpRightAlwncePlus(m.get("wpRightAlwncePlus").toString());
					equipCondBomAdmVo.setWpDeviationAlwncePlus(m.get("wpDeviationAlwncePlus").toString());
					equipCondBomAdmVo.setX1X2AlwncePlus(m.get("x1X2AlwncePlus").toString());
					equipCondBomAdmVo.setPpfWingLeftAlwncePlus(m.get("ppfWingLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfWingRightAlwncePlus(m.get("ppfWingRightAlwncePlus").toString());
					equipCondBomAdmVo.setMetalThicknessAlwncePlus(m.get("metalThicknessAlwncePlus").toString());
					equipCondBomAdmVo.setThEdgeAlwncePlus(m.get("thEdgeAlwncePlus").toString());
					equipCondBomAdmVo.setThCenterAlwncePlus(m.get("thCenterAlwncePlus").toString());
					equipCondBomAdmVo.setThEdgeRightAlwncePlus(m.get("thEdgeRightAlwncePlus").toString());
					equipCondBomAdmVo.setBurrAlwncePlus(m.get("burrAlwncePlus").toString());
					equipCondBomAdmVo.setGapOfLayerPlus(m.get("gapOfLayerAlwncePlus").toString());
					equipCondBomAdmVo.setBendingAlwncePlus(m.get("bendingAlwncePlus").toString());
					
					equipCondBomAdmVo.setMetalDepthAlwnceMinus(m.get("metalDepthAlwnceMinus").toString());
					equipCondBomAdmVo.setPitchLeftAlwnceMinus(m.get("pitchLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthLeftAlwnceMinus(m.get("ppfDepthLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthCenterAlwnceMinus(m.get("ppfDepthCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthRightAlwnceMinus(m.get("ppfDepthRightAlwnceMinus").toString());
					equipCondBomAdmVo.setFilmAlwnceMinus(m.get("filmAlwnceMinus").toString());
					equipCondBomAdmVo.setWpLeftAlwnceMinus(m.get("wpLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setWpCenterAlwnceMinus(m.get("wpCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setWpRightAlwnceMinus(m.get("wpRightAlwnceMinus").toString());
					equipCondBomAdmVo.setWpDeviationAlwnceMinus(m.get("wpDeviationAlwnceMinus").toString());
					equipCondBomAdmVo.setX1X2AlwnceMinus(m.get("x1X2AlwnceMinus").toString());
					equipCondBomAdmVo.setPpfWingLeftAlwnceMinus(m.get("ppfWingLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfWingRightAlwnceMinus(m.get("ppfWingRightAlwnceMinus").toString());
					equipCondBomAdmVo.setMetalThicknessAlwnceMinus(m.get("metalThicknessAlwnceMinus").toString());
					equipCondBomAdmVo.setThEdgeAlwnceMinus(m.get("thEdgeAlwnceMinus").toString());
					equipCondBomAdmVo.setThCenterAlwnceMinus(m.get("thCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setThEdgeRightAlwnceMinus(m.get("thEdgeRightAlwnceMinus").toString());
					equipCondBomAdmVo.setBurrAlwnceMinus(m.get("burrAlwnceMinus").toString());
					equipCondBomAdmVo.setGapOfLayerMinus(m.get("gapOfLayerAlwnceMinus").toString());
					equipCondBomAdmVo.setBendingAlwnceMinus(m.get("bendingAlwnceMinus").toString());
					
					
					
					
					//사이즈 등록
					equipCondBomAdmService.sizeCreate(equipCondBomAdmVo);
					logger.info("치수 조건  = "+ equipCondBomAdmVo);
				}
				i++;
			}
			logger.info("설비계획 등록 성공");
			jsonData.put("result", "ok");
						
			
		} catch (Exception e) {
			logger.info("설비계획 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//설비 계획 수정
	@RequestMapping(value = "/em/equipCondCommonAdmEdit", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCondCommonAdmEditPOST(@RequestBody List<Map<String, Object>> bomList, EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm, HttpServletRequest request) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제조조건관리 - 설비계획 수정 BOM 조건 = "+ bomList);
		equipCondBomAdmVo.setUpdId(Utils.getUserId());
		equipTempaturCondAdm.setUpdId(Utils.getUserId());
		int i = 0;
		EquipCondCommonAdmVo equipCondCommonAdmVo = new EquipCondCommonAdmVo();
		logger.info("수정 받아온 값 : "+bomList);
		equipCondCommonAdmVo.setEquipCd(bomList.get(0).get("equipCd").toString());
		
		try {	
			if(bomList.get(0).get("fpMainGubun").toString().equals("001")) {		
				equipCondCommonAdmVo.setFactoryCode(factoryCode);
				manufacturerService.deleteFpMainGubun(equipCondCommonAdmVo);			
				logger.info("팩토리코드 : "+equipCondCommonAdmVo.getFactoryCode());
			}
			for(Map<String, Object> m : bomList) {
				logger.info("i 값 : "+i);
				if( i==0) {
					equipCondBomAdmVo.setEquipCondSeq(m.get("equipCondSeq").toString());	//hidden으로 숨긴 SEQ값 가져옴
					equipTempaturCondAdm.setEquipCondSeq(m.get("equipCondSeq").toString());
					equipCondCommonAdmVo.setEquipCondSeq(m.get("equipCondSeq").toString());
					equipCondCommonAdmVo.setFpUseYn(m.get("fpUseYn").toString());
					equipCondCommonAdmVo.setFpMainGubun(m.get("fpMainGubun").toString());
					
					manufacturerService.equipCondCommonAdmUpdate(equipCondCommonAdmVo);				
					
				}
				else if( i==1 || i==2 || i==3) {
					if (i==1) {
						//온도 수정
						equipTempaturCondAdm.setWarmupCond(m.get("warmupCond").toString());
						equipTempaturCondAdm.setWarmupAlwncePlus(m.get("warmupAlwncePlus").toString());
						equipTempaturCondAdm.setWarmupAlwnceMinus(m.get("warmupAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup1UpCond(m.get("fitup1UpCond").toString());
						equipTempaturCondAdm.setFitup1UpAlwncePlus(m.get("fitup1UpAlwncePlus").toString());
						equipTempaturCondAdm.setFitup1UpAlwnceMinus(m.get("fitup1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup1DownCond(m.get("fitup1DownCond").toString());
						equipTempaturCondAdm.setFitup1DownAlwncePlus(m.get("fitup1DownAlwncePlus").toString());
						equipTempaturCondAdm.setFitup1DownAlwnceMinus(m.get("fitup1DownAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2UpleftCond(m.get("fitup2UpleftCond").toString());
						equipTempaturCondAdm.setFitup2UpleftAlwncePlus(m.get("fitup2UpleftAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2UpleftAlwnceMinus(m.get("fitup2UpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2DownleftCond(m.get("fitup2DownleftCond").toString());
						equipTempaturCondAdm.setFitup2DownleftAlwncePlus(m.get("fitup2DownleftAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2DownleftAlwnceMinus(m.get("fitup2DownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2UprightCond(m.get("fitup2UprightCond").toString());
						equipTempaturCondAdm.setFitup2UprightAlwncePlus(m.get("fitup2UprightAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2UprightAlwnceMinus(m.get("fitup2UprightAlwnceMinus").toString());
						equipTempaturCondAdm.setFitup2DownrightCond(m.get("fitup2DownrightCond").toString());
						equipTempaturCondAdm.setFitup2DownrightAlwncePlus(m.get("fitup2DownrightAlwncePlus").toString());
						equipTempaturCondAdm.setFitup2DownrightAlwnceMinus(m.get("fitup2DownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setRollheatUpCond(m.get("rollheatUpCond").toString());
						equipTempaturCondAdm.setRollheatUpAlwncePlus(m.get("rollheatUpAlwncePlus").toString());
						equipTempaturCondAdm.setRollheatUpAlwnceMinus(m.get("rollheatUpAlwnceMinus").toString());
						equipTempaturCondAdm.setRollheatDownCond(m.get("rollheatDownCond").toString());
						equipTempaturCondAdm.setRollheatDownAlwncePlus(m.get("rollheatDownAlwncePlus").toString());
						equipTempaturCondAdm.setRollheatDownAlwnceMinus(m.get("rollheatDownAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstUpleftCond(m.get("firstUpleftCond").toString());
						equipTempaturCondAdm.setFirstUpleftAlwncePlus(m.get("firstUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setFirstUpleftAlwnceMinus(m.get("firstUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstDownleftCond(m.get("firstDownleftCond").toString());
						equipTempaturCondAdm.setFirstDownleftAlwncePlus(m.get("firstDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setFirstDownleftAlwnceMinus(m.get("firstDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstUprightCond(m.get("firstUprightCond").toString());
						equipTempaturCondAdm.setFirstUprightAlwncePlus(m.get("firstUprightAlwncePlus").toString());
						equipTempaturCondAdm.setFirstUprightAlwnceMinus(m.get("firstUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setFirstDownrightCond(m.get("firstDownrightCond").toString());
						equipTempaturCondAdm.setFirstDownrightAlwncePlus(m.get("firstDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setFirstDownrightAlwnceMinus(m.get("firstDownrightAlwnceMinus").toString());
						
						equipTempaturCondAdm.setPush1UpCond(m.get("push1UpCond").toString());
						equipTempaturCondAdm.setPush1UpAlwncePlus(m.get("push1UpAlwncePlus").toString());
						equipTempaturCondAdm.setPush1UpAlwnceMinus(m.get("push1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setPush1DownCond(m.get("push1DownCond").toString());
						equipTempaturCondAdm.setPush1DownAlwncePlus(m.get("push1DownAlwncePlus").toString());
						equipTempaturCondAdm.setPush1DownAlwnceMinus(m.get("push1DownAlwnceMinus").toString());

						equipTempaturCondAdm.setSecondUpleftCond(m.get("secondUpleftCond").toString());
						equipTempaturCondAdm.setSecondUpleftAlwncePlus(m.get("secondUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setSecondUpleftAlwnceMinus(m.get("secondUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondDownleftCond(m.get("secondDownleftCond").toString());
						equipTempaturCondAdm.setSecondDownleftAlwncePlus(m.get("secondDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setSecondDownleftAlwnceMinus(m.get("secondDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondUprightCond(m.get("secondUprightCond").toString());
						equipTempaturCondAdm.setSecondUprightAlwncePlus(m.get("secondUprightAlwncePlus").toString());
						equipTempaturCondAdm.setSecondUprightAlwnceMinus(m.get("secondUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setSecondDownrightCond(m.get("secondDownrightCond").toString());
						equipTempaturCondAdm.setSecondDownrightAlwncePlus(m.get("secondDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setSecondDownrightAlwnceMinus(m.get("secondDownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdUpleftCond(m.get("thirdUpleftCond").toString());
						equipTempaturCondAdm.setThirdUpleftAlwncePlus(m.get("thirdUpleftAlwncePlus").toString());
						equipTempaturCondAdm.setThirdUpleftAlwnceMinus(m.get("thirdUpleftAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdDownleftCond(m.get("thirdDownleftCond").toString());
						equipTempaturCondAdm.setThirdDownleftAlwncePlus(m.get("thirdDownleftAlwncePlus").toString());
						equipTempaturCondAdm.setThirdDownleftAlwnceMinus(m.get("thirdDownleftAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdUprightCond(m.get("thirdUprightCond").toString());
						equipTempaturCondAdm.setThirdUprightAlwncePlus(m.get("thirdUprightAlwncePlus").toString());
						equipTempaturCondAdm.setThirdUprightAlwnceMinus(m.get("thirdUprightAlwnceMinus").toString());
						equipTempaturCondAdm.setThirdDownrightCond(m.get("thirdDownrightCond").toString());
						equipTempaturCondAdm.setThirdDownrightAlwncePlus(m.get("thirdDownrightAlwncePlus").toString());
						equipTempaturCondAdm.setThirdDownrightAlwnceMinus(m.get("thirdDownrightAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop1UpCond(m.get("jinjeop1UpCond").toString());
						equipTempaturCondAdm.setJinjeop1UpAlwncePlus(m.get("jinjeop1UpAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop1UpAlwnceMinus(m.get("jinjeop1UpAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop1DownCond(m.get("jinjeop1DownCond").toString());
						equipTempaturCondAdm.setJinjeop1DownAlwncePlus(m.get("jinjeop1DownAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop1DownAlwnceMinus(m.get("jinjeop1DownAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop2UpCond(m.get("jinjeop2UpCond").toString());
						equipTempaturCondAdm.setJinjeop2UpAlwncePlus(m.get("jinjeop2UpAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop2UpAlwnceMinus(m.get("jinjeop2UpAlwnceMinus").toString());
						equipTempaturCondAdm.setJinjeop2DownCond(m.get("jinjeop2DownCond").toString());
						equipTempaturCondAdm.setJinjeop2DownAlwncePlus(m.get("jinjeop2DownAlwncePlus").toString());
						equipTempaturCondAdm.setJinjeop2DownAlwnceMinus(m.get("jinjeop2DownAlwnceMinus").toString());
						
						equipCondBomAdmService.tempaturUpdate(equipTempaturCondAdm);
					}
					else if (i==2) {
						//시간 수정
						equipCondBomAdmVo.setFitupCond(m.get("fitupCond").toString());
						equipCondBomAdmVo.setFitupAlwncePlus(m.get("fitupAlwncePlus").toString());
						equipCondBomAdmVo.setFitupAlwnceMinus(m.get("fitupAlwnceMinus").toString());
						equipCondBomAdmVo.setFitup2Cond(m.get("fitup2Cond").toString());
						equipCondBomAdmVo.setFitup2AlwncePlus(m.get("fitup2AlwncePlus").toString());
						equipCondBomAdmVo.setFitup2AlwnceMinus(m.get("fitup2AlwnceMinus").toString());
						equipCondBomAdmVo.setFirstCond(m.get("firstCond").toString());
						equipCondBomAdmVo.setFirstAlwncePlus(m.get("firstAlwncePlus").toString());
						equipCondBomAdmVo.setFirstAlwnceMinus(m.get("firstAlwnceMinus").toString());
						equipCondBomAdmVo.setSecondCond(m.get("secondCond").toString());
						equipCondBomAdmVo.setSecondAlwncePlus(m.get("secondAlwncePlus").toString());
						equipCondBomAdmVo.setSecondAlwnceMinus(m.get("secondAlwnceMinus").toString());
						
						equipCondBomAdmVo.setThirdCond(m.get("thirdCond").toString());
						equipCondBomAdmVo.setThirdAlwncePlus(m.get("thirdAlwncePlus").toString());
						equipCondBomAdmVo.setThirdAlwnceMinus(m.get("thirdAlwnceMinus").toString());
						
						equipCondBomAdmVo.setJinjeopCond(m.get("jinjeopCond").toString());
						equipCondBomAdmVo.setJinjeopAlwncePlus(m.get("jinjeopAlwncePlus").toString());
						equipCondBomAdmVo.setJinjeopAlwnceMinus(m.get("jinjeopAlwnceMinus").toString());
						
						equipCondBomAdmVo.setThirdCond(m.get("thirdCond").toString());
						equipCondBomAdmVo.setThirdAlwncePlus(m.get("thirdAlwncePlus").toString());
						equipCondBomAdmVo.setThirdAlwnceMinus(m.get("thirdAlwnceMinus").toString());
						equipCondBomAdmVo.setJinjeop2Cond(m.get("jinjeop2Cond").toString());
						equipCondBomAdmVo.setJinjeop2AlwncePlus(m.get("jinjeop2AlwncePlus").toString());
						equipCondBomAdmVo.setJinjeop2AlwnceMinus(m.get("jinjeop2AlwnceMinus").toString());
						equipCondBomAdmVo.setPush1Cond(m.get("push1Cond").toString());
						equipCondBomAdmVo.setPush1AlwncePlus(m.get("push1AlwncePlus").toString());
						equipCondBomAdmVo.setPush1AlwnceMinus(m.get("push1AlwnceMinus").toString());
						
						equipCondBomAdmVo.setReformCond(m.get("reformCond").toString());
						equipCondBomAdmVo.setReformAlwncePlus(m.get("reformAlwncePlus").toString());
						equipCondBomAdmVo.setReformAlwnceMinus(m.get("reformAlwnceMinus").toString());

						equipCondBomAdmVo.setCoolCond(m.get("coolCond").toString());
						equipCondBomAdmVo.setCoolAlwncePlus(m.get("coolAlwncePlus").toString());
						equipCondBomAdmVo.setCoolAlwnceMinus(m.get("coolAlwnceMinus").toString());
						
						equipCondBomAdmService.timeUpdate(equipCondBomAdmVo);
					}
					else if (i==3) {
						//치수 수정
						equipCondBomAdmVo.setFitupCond(m.get("fitupCond").toString());
						equipCondBomAdmVo.setFitupAlwncePlus(m.get("fitupAlwncePlus").toString());
						equipCondBomAdmVo.setFitupAlwnceMinus(m.get("fitupAlwnceMinus").toString());
						equipCondBomAdmVo.setPush1Cond(m.get("push1Cond").toString());
						equipCondBomAdmVo.setPush1AlwncePlus(m.get("push1AlwncePlus").toString());
						equipCondBomAdmVo.setPush1AlwnceMinus(m.get("push1AlwnceMinus").toString());
						//equipCondBomAdmVo.setSecondCond(m.get("secondCond").toString());
						//equipCondBomAdmVo.setSecondAlwncePlus(m.get("secondAlwncePlus").toString());
						//equipCondBomAdmVo.setSecondAlwnceMinus(m.get("secondAlwnceMinus").toString());
						equipCondBomAdmVo.setJinjeopCond(m.get("jinjeopCond").toString());
						equipCondBomAdmVo.setJinjeopAlwncePlus(m.get("jinjeopAlwncePlus").toString());
						equipCondBomAdmVo.setJinjeopAlwnceMinus(m.get("jinjeopAlwnceMinus").toString());
						
						equipCondBomAdmVo.setJinjeop2Cond(m.get("jinjeop2Cond").toString());
						equipCondBomAdmVo.setJinjeop2AlwncePlus(m.get("jinjeop2AlwncePlus").toString());
						equipCondBomAdmVo.setJinjeop2AlwnceMinus(m.get("jinjeop2AlwnceMinus").toString());

						equipCondBomAdmService.pressureUpdate(equipCondBomAdmVo);
					}
					logger.info("온도 시간 압력  = "+ equipCondBomAdmVo);
				}
				else if ( i==4 ) {
					//equipCondBomAdmVo.setWpLeftCond(m.get("wpLeftCond").toString());
					//equipCondBomAdmVo.setWpLeftAlwncePlus(m.get("wpLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setWpLeftAlwnceMinus(m.get("wpLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setWpRightCond(m.get("wpRightCond").toString());
					//equipCondBomAdmVo.setWpRightAlwncePlus(m.get("wpRightAlwncePlus").toString());
					//equipCondBomAdmVo.setWpRightAlwnceMinus(m.get("wpRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setPitchLeftCond(m.get("pitchLeftCond").toString());
					//equipCondBomAdmVo.setPitchLeftAlwncePlus(m.get("pitchLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPitchLeftAlwnceMinus(m.get("pitchLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPitchRightCond(m.get("pitchRightCond").toString());
					//equipCondBomAdmVo.setPitchRightAlwncePlus(m.get("pitchRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPitchRightAlwnceMinus(m.get("pitchRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfWingLeftCond(m.get("ppfWingLeftCond").toString());
					//equipCondBomAdmVo.setPpfWingLeftAlwncePlus(m.get("ppfWingLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfWingLeftAlwnceMinus(m.get("ppfWingLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfWingRightCond(m.get("ppfWingRightCond").toString());
					//equipCondBomAdmVo.setPpfWingRightAlwncePlus(m.get("ppfWingRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfWingRightAlwnceMinus(m.get("ppfWingRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfDepthLeftCond(m.get("ppfDepthLeftCond").toString());
					//equipCondBomAdmVo.setPpfDepthLeftAlwncePlus(m.get("ppfDepthLeftAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfDepthLeftAlwnceMinus(m.get("ppfDepthLeftAlwnceMinus").toString());
					//equipCondBomAdmVo.setPpfDepthRightCond(m.get("ppfDepthRightCond").toString());
					//equipCondBomAdmVo.setPpfDepthRightAlwncePlus(m.get("ppfDepthRightAlwncePlus").toString());
					//equipCondBomAdmVo.setPpfDepthRightAlwnceMinus(m.get("ppfDepthRightAlwnceMinus").toString());
					//equipCondBomAdmVo.setFilmCond(m.get("filmCond").toString());
					//equipCondBomAdmVo.setFilmAlwncePlus(m.get("filmAlwncePlus").toString());
					//equipCondBomAdmVo.setFilmAlwnceMinus(m.get("filmAlwnceMinus").toString());
					//equipCondBomAdmVo.setMetalDepthCond(m.get("metalDepthCond").toString());
					//equipCondBomAdmVo.setMetalDepthAlwncePlus(m.get("metalDepthAlwncePlus").toString());
					//equipCondBomAdmVo.setMetalDepthAlwnceMinus(m.get("metalDepthAlwnceMinus").toString());
					//equipCondBomAdmVo.setMetalThicknessCond(m.get("metalThicknessCond").toString());
					//equipCondBomAdmVo.setMetalThicknessAlwncePlus(m.get("metalThicknessAlwncePlus").toString());
					//equipCondBomAdmVo.setMetalThicknessAlwnceMinus(m.get("metalThicknessAlwnceMinus").toString());
					//equipCondBomAdmVo.setThCenterCond(m.get("thCenterCond").toString());
					//equipCondBomAdmVo.setThCenterAlwncePlus(m.get("thCenterAlwncePlus").toString());
					//equipCondBomAdmVo.setThCenterAlwnceMinus(m.get("thCenterAlwnceMinus").toString());
					//equipCondBomAdmVo.setThEdgeCond(m.get("thEdgeCond").toString());
					//equipCondBomAdmVo.setThEdgeAlwncePlus(m.get("thEdgeAlwncePlus").toString());
					//equipCondBomAdmVo.setThEdgeAlwnceMinus(m.get("thEdgeAlwnceMinus").toString());
					//equipCondBomAdmVo.setGapOfLayerCond(m.get("gapOfLayerCond").toString());
					//equipCondBomAdmVo.setGapOfLayerPlus(m.get("gapOfLayerPlus").toString());
					//equipCondBomAdmVo.setGapOfLayerMinus(m.get("gapOfLayerMinus").toString());
					//equipCondBomAdmVo.setBurrCond(m.get("burrCond").toString());
					//equipCondBomAdmVo.setBurrAlwncePlus(m.get("burrAlwncePlus").toString());
					//equipCondBomAdmVo.setBurrAlwnceMinus(m.get("burrAlwnceMinus").toString());
					equipCondBomAdmVo.setMetalDepthCond(m.get("metalDepthCond").toString());
					equipCondBomAdmVo.setPitchLeftCond(m.get("pitchLeftCond").toString());
					equipCondBomAdmVo.setPpfDepthLeftCond(m.get("ppfDepthLeftCond").toString());
					equipCondBomAdmVo.setPpfDepthCenterCond(m.get("ppfDepthCenterCond").toString());
					equipCondBomAdmVo.setPpfDepthRightCond(m.get("ppfDepthRightCond").toString());
					equipCondBomAdmVo.setFilmCond(m.get("filmCond").toString());
					equipCondBomAdmVo.setWpLeftCond(m.get("wpLeftCond").toString());
					equipCondBomAdmVo.setWpCenterCond(m.get("wpCenterCond").toString());
					equipCondBomAdmVo.setWpRightCond(m.get("wpRightCond").toString());
					equipCondBomAdmVo.setWpDeviationCond(m.get("wpDeviationCond").toString());
					equipCondBomAdmVo.setX1X2Cond(m.get("x1X2Cond").toString());
					equipCondBomAdmVo.setPpfWingLeftCond(m.get("ppfWingLeftCond").toString());
					equipCondBomAdmVo.setPpfWingRightCond(m.get("ppfWingRightCond").toString());
					equipCondBomAdmVo.setMetalThicknessCond(m.get("metalThicknessCond").toString());
					equipCondBomAdmVo.setThEdgeCond(m.get("thEdgeCond").toString());
					equipCondBomAdmVo.setThCenterCond(m.get("thCenterCond").toString());
					equipCondBomAdmVo.setThEdgeRightCond(m.get("thEdgeRightCond").toString());
					equipCondBomAdmVo.setBurrCond(m.get("burrCond").toString());
					equipCondBomAdmVo.setGapOfLayerCond(m.get("gapOfLayerCond").toString());
					equipCondBomAdmVo.setBendingCond(m.get("bendingCond").toString());
					
					equipCondBomAdmVo.setMetalDepthAlwncePlus(m.get("metalDepthAlwncePlus").toString());
					equipCondBomAdmVo.setPitchLeftAlwncePlus(m.get("pitchLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthLeftAlwncePlus(m.get("ppfDepthLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthCenterAlwncePlus(m.get("ppfDepthCenterAlwncePlus").toString());
					equipCondBomAdmVo.setPpfDepthRightAlwncePlus(m.get("ppfDepthRightAlwncePlus").toString());
					equipCondBomAdmVo.setFilmAlwncePlus(m.get("filmAlwncePlus").toString());
					equipCondBomAdmVo.setWpLeftAlwncePlus(m.get("wpLeftAlwncePlus").toString());
					equipCondBomAdmVo.setWpCenterAlwncePlus(m.get("wpCenterAlwncePlus").toString());
					equipCondBomAdmVo.setWpRightAlwncePlus(m.get("wpRightAlwncePlus").toString());
					equipCondBomAdmVo.setWpDeviationAlwncePlus(m.get("wpDeviationAlwncePlus").toString());
					equipCondBomAdmVo.setX1X2AlwncePlus(m.get("x1X2AlwncePlus").toString());
					equipCondBomAdmVo.setPpfWingLeftAlwncePlus(m.get("ppfWingLeftAlwncePlus").toString());
					equipCondBomAdmVo.setPpfWingRightAlwncePlus(m.get("ppfWingRightAlwncePlus").toString());
					equipCondBomAdmVo.setMetalThicknessAlwncePlus(m.get("metalThicknessAlwncePlus").toString());
					equipCondBomAdmVo.setThEdgeAlwncePlus(m.get("thEdgeAlwncePlus").toString());
					equipCondBomAdmVo.setThCenterAlwncePlus(m.get("thCenterAlwncePlus").toString());
					equipCondBomAdmVo.setThEdgeRightAlwncePlus(m.get("thEdgeRightAlwncePlus").toString());
					equipCondBomAdmVo.setBurrAlwncePlus(m.get("burrAlwncePlus").toString());
					equipCondBomAdmVo.setGapOfLayerPlus(m.get("gapOfLayerAlwncePlus").toString());
					equipCondBomAdmVo.setBendingAlwncePlus(m.get("bendingAlwncePlus").toString());
					
					equipCondBomAdmVo.setMetalDepthAlwnceMinus(m.get("metalDepthAlwnceMinus").toString());
					equipCondBomAdmVo.setPitchLeftAlwnceMinus(m.get("pitchLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthLeftAlwnceMinus(m.get("ppfDepthLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthCenterAlwnceMinus(m.get("ppfDepthCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfDepthRightAlwnceMinus(m.get("ppfDepthRightAlwnceMinus").toString());
					equipCondBomAdmVo.setFilmAlwnceMinus(m.get("filmAlwnceMinus").toString());
					equipCondBomAdmVo.setWpLeftAlwnceMinus(m.get("wpLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setWpCenterAlwnceMinus(m.get("wpCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setWpRightAlwnceMinus(m.get("wpRightAlwnceMinus").toString());
					equipCondBomAdmVo.setWpDeviationAlwnceMinus(m.get("wpDeviationAlwnceMinus").toString());
					equipCondBomAdmVo.setX1X2AlwnceMinus(m.get("x1X2AlwnceMinus").toString());
					equipCondBomAdmVo.setPpfWingLeftAlwnceMinus(m.get("ppfWingLeftAlwnceMinus").toString());
					equipCondBomAdmVo.setPpfWingRightAlwnceMinus(m.get("ppfWingRightAlwnceMinus").toString());
					equipCondBomAdmVo.setMetalThicknessAlwnceMinus(m.get("metalThicknessAlwnceMinus").toString());
					equipCondBomAdmVo.setThEdgeAlwnceMinus(m.get("thEdgeAlwnceMinus").toString());
					equipCondBomAdmVo.setThCenterAlwnceMinus(m.get("thCenterAlwnceMinus").toString());
					equipCondBomAdmVo.setThEdgeRightAlwnceMinus(m.get("thEdgeRightAlwnceMinus").toString());
					equipCondBomAdmVo.setBurrAlwnceMinus(m.get("burrAlwnceMinus").toString());
					equipCondBomAdmVo.setGapOfLayerMinus(m.get("gapOfLayerAlwnceMinus").toString());
					equipCondBomAdmVo.setBendingAlwnceMinus(m.get("bendingAlwnceMinus").toString());
					//사이즈 수정
					equipCondBomAdmService.sizeUpdate(equipCondBomAdmVo);
					logger.info("치수 조건  = "+ equipCondBomAdmVo);
				}
				i++;
			}
			logger.info("설비계획 수정 성공");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비계획 수정  실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//설비 계획 상세 조회
	@RequestMapping(value = "/em/equipBomDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipBomDataListGET(EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm,ManufacturerVo manufacturerVo) throws Exception {

		logger.info("특정 설비계획 상세 조회");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("EquipCondBomAdmVo : " + equipCondBomAdmVo);
		logger.info("EquipTempaturCondAdm : " + equipTempaturCondAdm);
		logger.info("ManufacturerVo : " + manufacturerVo);
		
		try {
			manufacturerVo = manufacturerService.read(manufacturerVo);
			logger.info("제품코드 조회 : " + manufacturerVo);
			Map<String, Object> manufacturerMap = new HashMap<String, Object>();
					
			manufacturerMap.put("goodsCd", 			manufacturerVo.getGoodsCd());          //제품코드           
			manufacturerMap.put("goodsNm", 			manufacturerVo.getGoodsNm());          //제품명 
			manufacturerMap.put("qutyCd", 			manufacturerVo.getQutyCd());           //재질 코드
			manufacturerMap.put("alniQutyNm", 		manufacturerVo.getAlniQutyNm());       //알류미늄or니켈 종류 
			manufacturerMap.put("model", 			manufacturerVo.getModel());            //규격      
			manufacturerMap.put("alniThickness", 	manufacturerVo.getAlniThickness());    //알류미늄or니켈 두께  
			manufacturerMap.put("alniDepth", 		manufacturerVo.getAlniDepth());       //알류미늄or니켈 폭    
			manufacturerMap.put("alniWidth", 		manufacturerVo.getAlniWidth());        //알류미늄or니켈 너비    
			manufacturerMap.put("alniLength", 		manufacturerVo.getAlniLength());       //알류미늄or니켈 길이    
			manufacturerMap.put("alniPitch", 		manufacturerVo.getAlniPitch());        //알류미늄or니켈 피치 
			manufacturerMap.put("filmQutyNm", 		manufacturerVo.getFilmQutyNm());       //필름명            
			manufacturerMap.put("filmThickness", 	manufacturerVo.getFilmThickness());    //필름 두께          
			manufacturerMap.put("filmDepth", 		manufacturerVo.getFilmDepth());        //필름 규격
			manufacturerMap.put("filmMatrlDesc", 	manufacturerVo.getFilmMatrlDesc());    //필름 비고
			manufacturerMap.put("fpUseYn", 			manufacturerVo.getFpUseYn());          //사용유무           
			manufacturerMap.put("fpMainGubun", 			manufacturerVo.getFpMainGubun());          //메인구분         
			jsonData.put("manufacturerData", manufacturerMap);
			
			EquipTempaturCondAdm tempaturRead = new EquipTempaturCondAdm();
			EquipCondBomAdmVo timeRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo pressureRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			
			tempaturRead = equipCondBomAdmService.tempaturRead(equipTempaturCondAdm);
			timeRead = equipCondBomAdmService.timeRead(equipCondBomAdmVo);
			pressureRead = equipCondBomAdmService.pressureRead(equipCondBomAdmVo);
			sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("온도 정보 : "+tempaturRead);
			logger.info("시간 정보 : "+timeRead);
			logger.info("압력 정보 : "+pressureRead);
			logger.info("치수 정보 : "+sizeRead);
			
			Map<String, Object> tempaturMap = new HashMap<String, Object>();
			Map<String, Object> timeMap = new HashMap<String, Object>();
			Map<String, Object> pressureMap = new HashMap<String, Object>();
			Map<String, Object> sizeMap = new HashMap<String, Object>();
			
			tempaturMap.put("equipCondSeq", 			tempaturRead.getEquipCondSeq());
			tempaturMap.put("warmupCond", 				tempaturRead.getWarmupCond());
			tempaturMap.put("warmupAlwncePlus", 		tempaturRead.getWarmupAlwncePlus());
			tempaturMap.put("warmupAlwnceMinus", 		tempaturRead.getWarmupAlwnceMinus());
			tempaturMap.put("fitup1UpCond", 			tempaturRead.getFitup1UpCond());
			tempaturMap.put("fitup1UpAlwncePlus", 		tempaturRead.getFitup1UpAlwncePlus());
			tempaturMap.put("fitup1UpAlwnceMinus", 		tempaturRead.getFitup1UpAlwnceMinus());
			tempaturMap.put("fitup1DownCond", 			tempaturRead.getFitup1DownCond());
			tempaturMap.put("fitup1DownAlwncePlus", 	tempaturRead.getFitup1DownAlwncePlus());
			tempaturMap.put("fitup1DownAlwnceMinus", 	tempaturRead.getFitup1DownAlwnceMinus());
			tempaturMap.put("fitup2UpleftCond", 		tempaturRead.getFitup2UpleftCond());
			tempaturMap.put("fitup2UpleftAlwncePlus", 	tempaturRead.getFitup2UpleftAlwncePlus());
			tempaturMap.put("fitup2UpleftAlwnceMinus", 	tempaturRead.getFitup2UpleftAlwnceMinus());
			tempaturMap.put("fitup2DownleftCond", 		tempaturRead.getFitup2DownleftCond());
			tempaturMap.put("fitup2DownleftAlwncePlus", tempaturRead.getFitup2DownleftAlwncePlus());
			tempaturMap.put("fitup2DownleftAlwnceMinus",tempaturRead.getFitup2DownleftAlwnceMinus());
			tempaturMap.put("fitup2UprightCond", 		tempaturRead.getFitup2UprightCond());
			tempaturMap.put("fitup2UprightAlwncePlus", 	tempaturRead.getFitup2UprightAlwncePlus());
			tempaturMap.put("fitup2UprightAlwnceMinus", tempaturRead.getFitup2UprightAlwnceMinus());
			tempaturMap.put("fitup2DownrightCond", 		tempaturRead.getFitup2DownrightCond());
			tempaturMap.put("fitup2DownrightAlwncePlus",tempaturRead.getFitup2DownrightAlwncePlus());
			tempaturMap.put("fitup2DownrightAlwnceMinus",tempaturRead.getFitup2DownrightAlwnceMinus());
			tempaturMap.put("rollheatUpCond", 			tempaturRead.getRollheatUpCond());
			tempaturMap.put("rollheatUpAlwncePlus", 	tempaturRead.getRollheatUpAlwncePlus());
			tempaturMap.put("rollheatUpAlwnceMinus", 	tempaturRead.getRollheatUpAlwnceMinus());
			tempaturMap.put("rollheatDownCond", 		tempaturRead.getRollheatDownCond());
			tempaturMap.put("rollheatDownAlwncePlus", 	tempaturRead.getRollheatDownAlwncePlus());
			tempaturMap.put("rollheatDownAlwnceMinus", 	tempaturRead.getRollheatDownAlwnceMinus());
			tempaturMap.put("firstUpleftCond", 			tempaturRead.getFirstUpleftCond());
			tempaturMap.put("firstUpleftAlwncePlus", 	tempaturRead.getFirstUpleftAlwncePlus());
			tempaturMap.put("firstUpleftAlwnceMinus", 	tempaturRead.getFirstUpleftAlwnceMinus());
			tempaturMap.put("firstDownleftCond", 		tempaturRead.getFirstDownleftCond());
			tempaturMap.put("firstDownleftAlwncePlus", 	tempaturRead.getFirstDownleftAlwncePlus());
			tempaturMap.put("firstDownleftAlwnceMinus", tempaturRead.getFirstDownleftAlwnceMinus());
			tempaturMap.put("firstUprightCond", 		tempaturRead.getFirstUprightCond());
			tempaturMap.put("firstUprightAlwncePlus", 	tempaturRead.getFirstUprightAlwncePlus());
			tempaturMap.put("firstUprightAlwnceMinus", 	tempaturRead.getFirstUprightAlwnceMinus());
			tempaturMap.put("firstDownrightCond", 		tempaturRead.getFirstDownrightCond());
			tempaturMap.put("firstDownrightAlwncePlus", tempaturRead.getFirstDownrightAlwncePlus());
			tempaturMap.put("firstDownrightAlwnceMinus",tempaturRead.getFirstDownrightAlwnceMinus());
			
			tempaturMap.put("push1UpCond",tempaturRead.getPush1UpCond());
			tempaturMap.put("push1UpAlwncePlus",tempaturRead.getPush1UpAlwncePlus());
			tempaturMap.put("push1UpAlwnceMinus",tempaturRead.getPush1UpAlwnceMinus());
			tempaturMap.put("push1DownCond",tempaturRead.getPush1DownCond());
			tempaturMap.put("push1DownAlwncePlus",tempaturRead.getPush1DownAlwncePlus());
			tempaturMap.put("push1DownAlwnceMinus",tempaturRead.getPush1DownAlwnceMinus());
			
			tempaturMap.put("secondUpleftCond", 		tempaturRead.getSecondUpleftCond());
			tempaturMap.put("secondUpleftAlwncePlus", 	tempaturRead.getSecondUpleftAlwncePlus());
			tempaturMap.put("secondUpleftAlwnceMinus", 	tempaturRead.getSecondUpleftAlwnceMinus());
			tempaturMap.put("secondDownleftCond", 		tempaturRead.getSecondDownleftCond());
			tempaturMap.put("secondDownleftAlwncePlus", tempaturRead.getSecondDownleftAlwncePlus());
			tempaturMap.put("secondDownleftAlwnceMinus",tempaturRead.getSecondDownleftAlwnceMinus());
			tempaturMap.put("secondUprightCond", 		tempaturRead.getSecondUprightCond());
			tempaturMap.put("secondUprightAlwncePlus", 	tempaturRead.getSecondUprightAlwncePlus());
			tempaturMap.put("secondUprightAlwnceMinus", tempaturRead.getSecondUprightAlwnceMinus());
			tempaturMap.put("secondDownrightCond", 		tempaturRead.getSecondDownrightCond());
			tempaturMap.put("secondDownrightAlwncePlus",tempaturRead.getSecondDownrightAlwncePlus());
			tempaturMap.put("secondDownrightAlwnceMinus",tempaturRead.getSecondDownrightAlwnceMinus());
			tempaturMap.put("thirdUpleftCond", 			tempaturRead.getThirdUpleftCond());
			tempaturMap.put("thirdUpleftAlwncePlus", 	tempaturRead.getThirdUpleftAlwncePlus());
			tempaturMap.put("thirdUpleftAlwnceMinus", 	tempaturRead.getThirdUpleftAlwnceMinus());
			tempaturMap.put("thirdDownleftCond", 		tempaturRead.getThirdDownleftCond());
			tempaturMap.put("thirdDownleftAlwncePlus", 	tempaturRead.getThirdDownleftAlwncePlus());
			tempaturMap.put("thirdDownleftAlwnceMinus", tempaturRead.getThirdDownleftAlwnceMinus());
			tempaturMap.put("thirdUprightCond", 		tempaturRead.getThirdUprightCond());
			tempaturMap.put("thirdUprightAlwncePlus", 	tempaturRead.getThirdUprightAlwncePlus());
			tempaturMap.put("thirdUprightAlwnceMinus", 	tempaturRead.getThirdUprightAlwnceMinus());
			tempaturMap.put("thirdDownrightCond", 		tempaturRead.getThirdDownrightCond());
			tempaturMap.put("thirdDownrightAlwncePlus", tempaturRead.getThirdDownrightAlwncePlus());
			tempaturMap.put("thirdDownrightAlwnceMinus",tempaturRead.getThirdDownrightAlwnceMinus());
			tempaturMap.put("jinjeop1UpCond", 			tempaturRead.getJinjeop1UpCond());
			tempaturMap.put("jinjeop1UpAlwncePlus", 	tempaturRead.getJinjeop1UpAlwncePlus());
			tempaturMap.put("jinjeop1UpAlwnceMinus", 	tempaturRead.getJinjeop1UpAlwnceMinus());
			tempaturMap.put("jinjeop1DownCond", 		tempaturRead.getJinjeop1DownCond());
			tempaturMap.put("jinjeop1DownAlwncePlus", 	tempaturRead.getJinjeop1DownAlwncePlus());
			tempaturMap.put("jinjeop1DownAlwnceMinus", 	tempaturRead.getJinjeop1DownAlwnceMinus());
			tempaturMap.put("jinjeop2UpCond", 			tempaturRead.getJinjeop2UpCond());
			tempaturMap.put("jinjeop2UpAlwncePlus", 	tempaturRead.getJinjeop2UpAlwncePlus());
			tempaturMap.put("jinjeop2UpAlwnceMinus", 	tempaturRead.getJinjeop2UpAlwnceMinus());
			tempaturMap.put("jinjeop2DownCond", 		tempaturRead.getJinjeop2DownCond());
			tempaturMap.put("jinjeop2DownAlwncePlus", 	tempaturRead.getJinjeop2DownAlwncePlus());
			tempaturMap.put("jinjeop2DownAlwnceMinus", 	tempaturRead.getJinjeop2DownAlwnceMinus());
			jsonData.put("tempaturData", tempaturMap);
			
			timeMap.put("equipCondSeq", 		timeRead.getEquipCondSeq());
			timeMap.put("fitupCond",			timeRead.getFitupCond());
			timeMap.put("fitupAlwncePlus", 		timeRead.getFitupAlwncePlus());
			timeMap.put("fitupAlwnceMinus", 	timeRead.getFitupAlwnceMinus());
			timeMap.put("fitup2Cond",			timeRead.getFitup2Cond());
			timeMap.put("fitup2AlwncePlus", 	timeRead.getFitup2AlwncePlus());
			timeMap.put("fitup2AlwnceMinus", 	timeRead.getFitup2AlwnceMinus());
			timeMap.put("firstCond", 			timeRead.getFirstCond());
			timeMap.put("firstAlwncePlus",		timeRead.getFirstAlwncePlus());
			timeMap.put("firstAlwnceMinus", 	timeRead.getFirstAlwnceMinus());
			
			timeMap.put("secondCond", 			timeRead.getSecondCond());
			timeMap.put("secondAlwncePlus",		timeRead.getSecondAlwncePlus());
			timeMap.put("secondAlwnceMinus", 	timeRead.getSecondAlwnceMinus());
			
			timeMap.put("thirdCond", 			timeRead.getThirdCond());
			timeMap.put("thirdAlwncePlus",		timeRead.getThirdAlwncePlus());
			timeMap.put("thirdAlwnceMinus", 	timeRead.getThirdAlwnceMinus());
			
			timeMap.put("jinjeopCond", 			timeRead.getJinjeopCond());
			timeMap.put("jinjeopAlwncePlus", 	timeRead.getJinjeopAlwncePlus());
			timeMap.put("jinjeopAlwnceMinus", 	timeRead.getJinjeopAlwnceMinus());
			timeMap.put("jinjeop2Cond", 		timeRead.getJinjeop2Cond());
			timeMap.put("jinjeop2AlwncePlus", 	timeRead.getJinjeop2AlwncePlus());
			timeMap.put("jinjeop2AlwnceMinus", 	timeRead.getJinjeop2AlwnceMinus());
			
			timeMap.put("push1Cond", 			timeRead.getPush1Cond());
			timeMap.put("push1AlwncePlus", 		timeRead.getPush1AlwncePlus());
			timeMap.put("push1AlwnceMinus", 	timeRead.getPush1AlwnceMinus());
			
			timeMap.put("reformCond", 			timeRead.getReformCond());
			timeMap.put("reformAlwncePlus", 	timeRead.getReformAlwncePlus());
			timeMap.put("reformAlwnceMinus", 	timeRead.getReformAlwnceMinus());
			
			timeMap.put("coolCond", 			timeRead.getCoolCond());
			timeMap.put("coolAlwncePlus", 		timeRead.getCoolAlwncePlus());
			timeMap.put("coolAlwnceMinus", 		timeRead.getCoolAlwnceMinus());
			
			jsonData.put("timeData", timeMap);
			
			pressureMap.put("equipCondSeq", 		pressureRead.getEquipCondSeq());
			pressureMap.put("fitupCond",			pressureRead.getFitupCond());
			pressureMap.put("fitupAlwncePlus", 		pressureRead.getFitupAlwncePlus());
			pressureMap.put("fitupAlwnceMinus", 	pressureRead.getFitupAlwnceMinus());

			pressureMap.put("push1Cond", 			pressureRead.getPush1Cond());
			pressureMap.put("push1AlwncePlus",		pressureRead.getPush1AlwncePlus());
			pressureMap.put("push1AlwnceMinus", 	pressureRead.getPush1AlwnceMinus());
			//pressureMap.put("secondCond", 			pressureRead.getSecondCond());
			//pressureMap.put("secondAlwncePlus",		pressureRead.getSecondAlwncePlus());
			//pressureMap.put("secondAlwnceMinus", 	pressureRead.getSecondAlwnceMinus());
			pressureMap.put("jinjeopCond", 			pressureRead.getJinjeopCond());
			pressureMap.put("jinjeopAlwncePlus", 	pressureRead.getJinjeopAlwncePlus());
			pressureMap.put("jinjeopAlwnceMinus", 	pressureRead.getJinjeopAlwnceMinus());
			
			pressureMap.put("jinjeop2Cond", 		pressureRead.getJinjeop2Cond());
			pressureMap.put("jinjeop2AlwncePlus", 	pressureRead.getJinjeop2AlwncePlus());
			pressureMap.put("jinjeop2AlwnceMinus", 	pressureRead.getJinjeop2AlwnceMinus());

			jsonData.put("pressureData", pressureMap);
			
			//sizeMap.put("equipCondSeq", 			sizeRead.getEquipCondSeq());
			//sizeMap.put("wpLeftCond", 				sizeRead.getWpLeftCond());
			//sizeMap.put("wpLeftAlwncePlus", 		sizeRead.getWpLeftAlwncePlus());
			//sizeMap.put("wpLeftAlwnceMinus", 		sizeRead.getWpLeftAlwnceMinus());
			//sizeMap.put("wpRightCond", 				sizeRead.getWpRightCond());
			//sizeMap.put("wpRightAlwncePlus", 		sizeRead.getWpRightAlwncePlus());
			//sizeMap.put("wpRightAlwnceMinus", 		sizeRead.getWpRightAlwnceMinus());
			//sizeMap.put("pitchLeftCond", 			sizeRead.getPitchLeftCond());
			//sizeMap.put("pitchLeftAlwncePlus", 		sizeRead.getPitchLeftAlwncePlus());
			//sizeMap.put("pitchLeftAlwnceMinus", 	sizeRead.getPitchLeftAlwnceMinus());
			//sizeMap.put("pitchRightCond", 			sizeRead.getPitchRightCond());
			//sizeMap.put("pitchRightAlwncePlus", 	sizeRead.getPitchRightAlwncePlus());
			//sizeMap.put("pitchRightAlwnceMinus",	sizeRead.getPitchRightAlwnceMinus());
			//sizeMap.put("ppfWingLeftCond", 			sizeRead.getPpfWingLeftCond());
			//sizeMap.put("ppfWingLeftAlwncePlus",	sizeRead.getPpfWingLeftAlwncePlus());
			//sizeMap.put("ppfWingLeftAlwnceMinus", 	sizeRead.getPpfWingLeftAlwnceMinus());
			//sizeMap.put("ppfWingRightCond", 		sizeRead.getPpfWingRightCond());
			//sizeMap.put("ppfWingRightAlwncePlus", 	sizeRead.getPpfWingRightAlwncePlus());
			//sizeMap.put("ppfWingRightAlwnceMinus", 	sizeRead.getPpfWingRightAlwnceMinus());
			//sizeMap.put("ppfDepthLeftCond", 		sizeRead.getPpfDepthLeftCond());
			//sizeMap.put("ppfDepthLeftAlwncePlus", 	sizeRead.getPpfDepthLeftAlwncePlus());
			//sizeMap.put("ppfDepthLeftAlwnceMinus", 	sizeRead.getPpfDepthLeftAlwnceMinus());
			//sizeMap.put("ppfDepthRightCond", 		sizeRead.getPpfDepthRightCond());
			//sizeMap.put("ppfDepthRightAlwncePlus", 	sizeRead.getPpfDepthRightAlwncePlus());
			//sizeMap.put("ppfDepthRightAlwnceMinus", sizeRead.getPpfDepthRightAlwnceMinus());
			//sizeMap.put("filmCond", 				sizeRead.getFilmCond());
			//sizeMap.put("filmAlwncePlus", 			sizeRead.getFilmAlwncePlus());
			//sizeMap.put("filmAlwnceMinus", 			sizeRead.getFilmAlwnceMinus());
			//sizeMap.put("metalDepthCond", 			sizeRead.getMetalDepthCond());
			//sizeMap.put("metalDepthAlwncePlus", 	sizeRead.getMetalDepthAlwncePlus());
			//sizeMap.put("metalDepthAlwnceMinus", 	sizeRead.getMetalDepthAlwnceMinus());
			//sizeMap.put("metalThicknessCond", 		sizeRead.getMetalThicknessCond());
			//sizeMap.put("metalThicknessAlwncePlus", sizeRead.getMetalThicknessAlwncePlus());
			//sizeMap.put("metalThicknessAlwnceMinus",sizeRead.getMetalThicknessAlwnceMinus());
			//sizeMap.put("thCenterCond", 			sizeRead.getThCenterCond());
			//sizeMap.put("thCenterAlwncePlus", 		sizeRead.getThCenterAlwncePlus());
			//sizeMap.put("thCenterAlwnceMinus", 		sizeRead.getThCenterAlwnceMinus());
			//sizeMap.put("thEdgeCond", 				sizeRead.getThEdgeCond());
			//sizeMap.put("thEdgeAlwncePlus", 		sizeRead.getThEdgeAlwncePlus());
			//sizeMap.put("thEdgeAlwnceMinus", 		sizeRead.getThEdgeAlwnceMinus());
			//sizeMap.put("gapOfLayerCond", 			sizeRead.getGapOfLayerCond());
			//sizeMap.put("gapOfLayerPlus", 			sizeRead.getGapOfLayerPlus());
			//sizeMap.put("gapOfLayerMinus", 			sizeRead.getGapOfLayerMinus());
			//sizeMap.put("burrCond", 				sizeRead.getBurrCond());
			//sizeMap.put("burrAlwncePlus", 			sizeRead.getBurrAlwncePlus());
			//sizeMap.put("burrAlwnceMinus", 			sizeRead.getBurrAlwnceMinus());
			
			sizeMap.put("metalDepthCond",          sizeRead.getMetalDepthCond());
			sizeMap.put("pitchLeftCond",           sizeRead.getPitchLeftCond());
			sizeMap.put("ppfDepthLeftCond",        sizeRead.getPpfDepthLeftCond());
			sizeMap.put("ppfDepthCenterCond",      sizeRead.getPpfDepthCenterCond());
			sizeMap.put("ppfDepthRightCond",       sizeRead.getPpfDepthRightCond());
			sizeMap.put("filmCond",                sizeRead.getFilmCond());
			sizeMap.put("wpLeftCond",              sizeRead.getWpLeftCond());
			sizeMap.put("wpCenterCond",            sizeRead.getWpCenterCond());
			sizeMap.put("wpRightCond",             sizeRead.getWpRightCond());
			sizeMap.put("wpDeviationCond",         sizeRead.getWpDeviationCond());
			sizeMap.put("x1X2Cond",                sizeRead.getX1X2Cond());
			sizeMap.put("ppfWingLeftCond",         sizeRead.getPpfWingLeftCond());
			sizeMap.put("ppfWingRightCond",        sizeRead.getPpfWingRightCond());
			sizeMap.put("metalThicknessCond",      sizeRead.getMetalThicknessCond());
			sizeMap.put("thEdgeCond",              sizeRead.getThEdgeCond());
			sizeMap.put("thCenterCond",            sizeRead.getThCenterCond());
			sizeMap.put("thEdgeRightCond",         sizeRead.getThEdgeRightCond());
			sizeMap.put("burrCond",                sizeRead.getBurrCond());
			sizeMap.put("gapOfLayerCond",          sizeRead.getGapOfLayerCond());
			sizeMap.put("bendingCond",             sizeRead.getBendingCond());
			
			sizeMap.put("metalDepthAlwncePlus",          sizeRead.getMetalDepthAlwncePlus());
			sizeMap.put("pitchLeftAlwncePlus",           sizeRead.getPitchLeftAlwncePlus());
			sizeMap.put("ppfDepthLeftAlwncePlus",        sizeRead.getPpfDepthLeftAlwncePlus());
			sizeMap.put("ppfDepthCenterAlwncePlus",      sizeRead.getPpfDepthCenterAlwncePlus());
			sizeMap.put("ppfDepthRightAlwncePlus",       sizeRead.getPpfDepthRightAlwncePlus());
			sizeMap.put("filmAlwncePlus",                sizeRead.getFilmAlwncePlus());
			sizeMap.put("wpLeftAlwncePlus",              sizeRead.getWpLeftAlwncePlus());
			sizeMap.put("wpCenterAlwncePlus",            sizeRead.getWpCenterAlwncePlus());
			sizeMap.put("wpRightAlwncePlus",             sizeRead.getWpRightAlwncePlus());
			sizeMap.put("wpDeviationAlwncePlus",         sizeRead.getWpDeviationAlwncePlus());
			sizeMap.put("x1X2AlwncePlus",                sizeRead.getX1X2AlwncePlus());
			sizeMap.put("ppfWingLeftAlwncePlus",         sizeRead.getPpfWingLeftAlwncePlus());
			sizeMap.put("ppfWingRightAlwncePlus",        sizeRead.getPpfWingRightAlwncePlus());
			sizeMap.put("metalThicknessAlwncePlus",      sizeRead.getMetalThicknessAlwncePlus());
			sizeMap.put("thEdgeAlwncePlus",              sizeRead.getThEdgeAlwncePlus());
			sizeMap.put("thCenterAlwncePlus",            sizeRead.getThCenterAlwncePlus());
			sizeMap.put("thEdgeRightAlwncePlus",         sizeRead.getThEdgeRightAlwncePlus());
			sizeMap.put("burrAlwncePlus",                sizeRead.getBurrAlwncePlus());
			sizeMap.put("gapOfLayerAlwncePlus",          sizeRead.getGapOfLayerPlus());
			sizeMap.put("bendingAlwncePlus",             sizeRead.getBendingAlwncePlus());
			
			sizeMap.put("metalDepthAlwnceMinus",          sizeRead.getMetalDepthAlwnceMinus());
			sizeMap.put("pitchLeftAlwnceMinus",           sizeRead.getPitchLeftAlwnceMinus());
			sizeMap.put("ppfDepthLeftAlwnceMinus",        sizeRead.getPpfDepthLeftAlwnceMinus());
			sizeMap.put("ppfDepthCenterAlwnceMinus",      sizeRead.getPpfDepthCenterAlwnceMinus());
			sizeMap.put("ppfDepthRightAlwnceMinus",       sizeRead.getPpfDepthRightAlwnceMinus());
			sizeMap.put("filmAlwnceMinus",                sizeRead.getFilmAlwnceMinus());
			sizeMap.put("wpLeftAlwnceMinus",              sizeRead.getWpLeftAlwnceMinus());
			sizeMap.put("wpCenterAlwnceMinus",            sizeRead.getWpCenterAlwnceMinus());
			sizeMap.put("wpRightAlwnceMinus",             sizeRead.getWpRightAlwnceMinus());
			sizeMap.put("wpDeviationAlwnceMinus",         sizeRead.getWpDeviationAlwnceMinus());
			sizeMap.put("x1X2AlwnceMinus",                sizeRead.getX1X2AlwnceMinus());
			sizeMap.put("ppfWingLeftAlwnceMinus",         sizeRead.getPpfWingLeftAlwnceMinus());
			sizeMap.put("ppfWingRightAlwnceMinus",        sizeRead.getPpfWingRightAlwnceMinus());
			sizeMap.put("metalThicknessAlwnceMinus",      sizeRead.getMetalThicknessAlwnceMinus());
			sizeMap.put("thEdgeAlwnceMinus",              sizeRead.getThEdgeAlwnceMinus());
			sizeMap.put("thCenterAlwnceMinus",            sizeRead.getThCenterAlwnceMinus());
			sizeMap.put("thEdgeRightAlwnceMinus",         sizeRead.getThEdgeRightAlwnceMinus());
			sizeMap.put("burrAlwnceMinus",                sizeRead.getBurrAlwnceMinus());
			sizeMap.put("gapOfLayerAlwnceMinus",          sizeRead.getGapOfLayerMinus());
			sizeMap.put("bendingAlwnceMinus",             sizeRead.getBendingAlwnceMinus());
					

			
			jsonData.put("sizeData", sizeMap);
	
			jsonData.put("result", "ok");
			logger.info("설비계획 조회 성공");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비계획 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
}