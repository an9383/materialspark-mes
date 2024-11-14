package mes.web.bm;

import java.lang.reflect.Field;
import java.util.ArrayList;
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

import mes.domain.bm.EquipCondPressureAdmVo;
import mes.domain.bm.EquipCondSizeAdmVo;
import mes.domain.bm.EquipCondTempaturAdmVo;
import mes.domain.bm.EquipCondTempaturSixFloorAdmVo;
import mes.domain.bm.EquipCondTimeAdmVo;
import mes.domain.bm.EquipCondTimeSixFloorAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.EquipCondPressureAdmService;
import mes.service.bm.EquipCondSizeAdmService;
import mes.service.bm.EquipCondTempaturAdmService;
import mes.service.bm.EquipCondTimeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class BomController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCondTempaturAdmService equipCondTempaturAdmService;	//온도
	@Inject
	private EquipCondTimeAdmService equipCondTimeAdmService;			//시간
	@Inject
	private EquipCondPressureAdmService equipCondPressureAdmService;	//압력
	@Inject
	private EquipCondSizeAdmService equipCondSizeAdmService;			//치수
	
	private static final Logger logger = LoggerFactory.getLogger(BomController.class);
	
	//BOM정보관리 메인
	@RequestMapping(value = "/bmsc0040", method = RequestMethod.GET)
	public String bomAdmMain(Locale locale, Model model) throws Exception {
		logger.info("BOM정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("023"); // BOM 목록
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("bom", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용유무
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );
		return "bm/bmsc0040";
	}
	
	//BOM정보관리 메인
	@RequestMapping(value = "/bmsc3040", method = RequestMethod.GET)
	public String bomAdmFac3Main(Locale locale, Model model) throws Exception {
		logger.info("BOM정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("023"); // BOM 목록
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("bom", systemCommonCodeList );
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용유무
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );
		return "bm/bmsc3040";
	}
	
	//BOM정보관리 메인
	@RequestMapping(value = "/bmsc3050", method = RequestMethod.GET)
	public String bmsc3050(Locale locale, Model model) throws Exception {
		logger.info("BOM정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("127"); // BOM 목록
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("bom", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용유무
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );
		
		//온도
		EquipCondTempaturSixFloorAdmVo equipCondTempaturSixFloorAdmVo = new EquipCondTempaturSixFloorAdmVo();
		Field[] fields = equipCondTempaturSixFloorAdmVo.getClass().getDeclaredFields();
		List<String> fieldValues = new ArrayList<>();
		
		//여기까지 개수 고정 후 사용(136개) 추가되면 Vo 추가 후 추가된 만큼 늘려주기
		for (int i = 0; i < 137; i++) {
		    fieldValues.add(fields[i].getName());
		}
		model.addAttribute("tempaturFieldsVo", fieldValues);
		
		//시간
		EquipCondTimeSixFloorAdmVo equipCondTimeSixFloorAdmVo = new EquipCondTimeSixFloorAdmVo();
		fields = equipCondTimeSixFloorAdmVo.getClass().getDeclaredFields();
		fieldValues = new ArrayList<>();
		
		//여기까지 개수 고정 후 사용(50개) 추가되면 Vo 추가 후 추가된 만큼 늘려주기
		for (int i = 0; i < 50; i++) {
		    fieldValues.add(fields[i].getName());
		}
		model.addAttribute("timeFieldsVo", fieldValues);
		
		//치수
		EquipCondSizeAdmVo equipCondSizeAdmVo = new EquipCondSizeAdmVo();
		fields = equipCondSizeAdmVo.getClass().getDeclaredFields();
		fieldValues = new ArrayList<>();
		
		//여기까지 개수 고정 후 사용(65개) 추가되면 Vo 추가 후 추가된 만큼 늘려주기
		for (int i = 0; i < 65; i++) {
		    fieldValues.add(fields[i].getName());
		}
		model.addAttribute("sizeFieldsVo", fieldValues);
		
		
		return "bm/bmsc3050";
	}
	
	/*-------------- 온도 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 온도 목록조회
	@RequestMapping(value = "/bm/tempaturDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tempaturDataList(EquipCondTempaturAdmVo equipCondTempaturAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 온도 목록조회");
		try {		
			List<EquipCondTempaturAdmVo> equipCondTempaturAdmVoList= equipCondTempaturAdmService.listAll(equipCondTempaturAdmVo);
			jsonData.put("data", equipCondTempaturAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 온도 상세조회
	@RequestMapping(value = "/bm/tempaturView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tempaturView(EquipCondTempaturAdmVo equipCondTempaturAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 상세조회 = "+ equipCondTempaturAdmVo);
		try {		
			equipCondTempaturAdmVo = equipCondTempaturAdmService.read(equipCondTempaturAdmVo);
			jsonData.put("data", equipCondTempaturAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 온도 등록
	@RequestMapping(value = "/bm/tempaturCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tempaturCreate(EquipCondTempaturAdmVo equipCondTempaturAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 등록 = "+ equipCondTempaturAdmVo);
		
		try {
			String sequence = equipCondTempaturAdmService.selectTempaturSeqCd();	// 시퀀스 코드번호 조회
			equipCondTempaturAdmVo.setTempaturCondCd(sequence);
			equipCondTempaturAdmVo.setRegId(Utils.getUserId());
			
			equipCondTempaturAdmService.create(equipCondTempaturAdmVo);
			equipCondTempaturAdmVo = equipCondTempaturAdmService.read(equipCondTempaturAdmVo);
			jsonData.put("data", equipCondTempaturAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 온도 수정
	@RequestMapping(value = "/bm/tempaturUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tempaturUpdate(EquipCondTempaturAdmVo equipCondTempaturAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 수정 = "+ equipCondTempaturAdmVo);
		try {
			equipCondTempaturAdmVo.setUpdId(Utils.getUserId());
			equipCondTempaturAdmService.update(equipCondTempaturAdmVo);
			equipCondTempaturAdmVo = equipCondTempaturAdmService.read(equipCondTempaturAdmVo);
		    jsonData.put("data", equipCondTempaturAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 온도 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	/*-------------- 시간 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 시간 목록조회
	@RequestMapping(value = "/bm/timeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> timeDataList(EquipCondTimeAdmVo equipCondTimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 시간 목록조회 = "+ equipCondTimeAdmVo);
		try {
			List<EquipCondTimeAdmVo> equipCondTimeAdmVoList= equipCondTimeAdmService.listAll(equipCondTimeAdmVo);
			jsonData.put("data", equipCondTimeAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 시간 상세조회
	@RequestMapping(value = "/bm/timeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> timeView(EquipCondTimeAdmVo equipCondTimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 상세조회 = "+ equipCondTimeAdmVo);
		try {		
			equipCondTimeAdmVo = equipCondTimeAdmService.read(equipCondTimeAdmVo);
			jsonData.put("data", equipCondTimeAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("BOM 시간 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 시간 등록
	@RequestMapping(value = "/bm/timeCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> timeCreate(EquipCondTimeAdmVo equipCondTimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 등록 = "+ equipCondTimeAdmVo);
		
		try {
			String sequence = equipCondTimeAdmService.selectTimeSeqCd();	// 시퀀스조회
			equipCondTimeAdmVo.setTimeCondCd(sequence);
			equipCondTimeAdmVo.setRegId(Utils.getUserId());
			
			equipCondTimeAdmService.create(equipCondTimeAdmVo);
			equipCondTimeAdmVo = equipCondTimeAdmService.read(equipCondTimeAdmVo);
			jsonData.put("data", equipCondTimeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;			
	}
	
	//BOM 시간 수정
	@RequestMapping(value = "/bm/timeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> timeUpdate (EquipCondTimeAdmVo equipCondTimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 수정 = "+ equipCondTimeAdmVo);
		try {		
			equipCondTimeAdmService.update(equipCondTimeAdmVo);
			equipCondTimeAdmVo = equipCondTimeAdmService.read(equipCondTimeAdmVo);
		    jsonData.put("data", equipCondTimeAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 시간 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	/*-------------- 압력 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 압력 목록조회
	@RequestMapping(value = "/bm/pressureDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> pressureDataList(EquipCondPressureAdmVo equipCondPressureAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 압력 목록조회 = "+equipCondPressureAdmVo);
		try {
			List<EquipCondPressureAdmVo> equipCondPressureAdmVoList= equipCondPressureAdmService.listAll(equipCondPressureAdmVo);
			jsonData.put("data", equipCondPressureAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 압력 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 압력 상세조회
	@RequestMapping(value = "/bm/pressureView", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> pressureView(EquipCondPressureAdmVo equipCondPressureAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 압력 상세조회 = "+equipCondPressureAdmVo);
		try {		
			equipCondPressureAdmVo = equipCondPressureAdmService.read(equipCondPressureAdmVo);
			jsonData.put("data", equipCondPressureAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 압력 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 등록
	@RequestMapping(value = "/bm/pressureCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> pressureCreate(EquipCondPressureAdmVo equipCondPressureAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 압력 등록 = "+equipCondPressureAdmVo);
		try {			
			String sequence = equipCondPressureAdmService.selectPressureSeqCd();	// 코드번호 부여하기
			equipCondPressureAdmVo.setPressureCondCd(sequence);
			equipCondPressureAdmVo.setRegId(Utils.getUserId());
			equipCondPressureAdmService.create(equipCondPressureAdmVo);
			equipCondPressureAdmVo = equipCondPressureAdmService.read(equipCondPressureAdmVo);
			jsonData.put("data", equipCondPressureAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 압력 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 수정
	@RequestMapping(value = "/bm/pressureUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> pressureUpdate (EquipCondPressureAdmVo equipCondPressureAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 압력 수정 = "+equipCondPressureAdmVo);
		try {
			equipCondPressureAdmVo.setUpdId(Utils.getUserId());
			equipCondPressureAdmService.update(equipCondPressureAdmVo);
			equipCondPressureAdmVo = equipCondPressureAdmService.read(equipCondPressureAdmVo);
		    jsonData.put("data", equipCondPressureAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 압력 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 압력 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	/*-------------- 치수 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 치수 목록조회
	@RequestMapping(value = "/bm/sizeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeDataList(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 치수 목록조회 = "+equipCondSizeAdmVo);
		try {
			List<EquipCondSizeAdmVo> equipCondSizeAdmVoList= equipCondSizeAdmService.listAll(equipCondSizeAdmVo);
			jsonData.put("data", equipCondSizeAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 압력 상세조회
	@RequestMapping(value = "/bm/sizeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeView(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 상세조회 = "+equipCondSizeAdmVo);
		try {
			equipCondSizeAdmVo = equipCondSizeAdmService.read(equipCondSizeAdmVo);
			jsonData.put("data", equipCondSizeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 등록
	@RequestMapping(value = "/bm/sizeCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sizeCreate(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 등록 = "+equipCondSizeAdmVo);
		try {
			String sequence = equipCondSizeAdmService.selectSizeSeqCd();	// 코드번호 부여하기
			equipCondSizeAdmVo.setSizeCondCd(sequence);
			equipCondSizeAdmVo.setRegId(Utils.getUserId());
			equipCondSizeAdmService.create(equipCondSizeAdmVo);
			equipCondSizeAdmVo = equipCondSizeAdmService.read(equipCondSizeAdmVo);
			jsonData.put("data", equipCondSizeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 수정
	@RequestMapping(value = "/bm/sizeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sizeUpdate(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 수정 = "+equipCondSizeAdmVo);
		try {
			equipCondSizeAdmVo.setUpdId(Utils.getUserId());
			equipCondSizeAdmService.update(equipCondSizeAdmVo);
			equipCondSizeAdmVo = equipCondSizeAdmService.read(equipCondSizeAdmVo);
		    jsonData.put("data", equipCondSizeAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 등록 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 치수 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	
	
	
	
	
	
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ6층 온도 정보(Bom온도조건관리)_23.10.24 추가ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	/*-------------- 온도 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 온도 목록조회
	@RequestMapping(value = "/bm/tempaturSixFloorList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tempaturSixFloorList(EquipCondTempaturSixFloorAdmVo equipCondTempaturSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 온도 목록조회");
		try {		
			List<EquipCondTempaturSixFloorAdmVo> equipCondTempaturSixFloorAdmVoList= equipCondTempaturAdmService.tempaturSixFloorList(equipCondTempaturSixFloorAdmVo);
			jsonData.put("data", equipCondTempaturSixFloorAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 온도 상세조회
	@RequestMapping(value = "/bm/tempaturSixFloorRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tempaturSixFloorRead(EquipCondTempaturSixFloorAdmVo equipCondTempaturSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 상세조회 = "+ equipCondTempaturSixFloorAdmVo);
		try {		
			equipCondTempaturSixFloorAdmVo = equipCondTempaturAdmService.tempaturSixFloorRead(equipCondTempaturSixFloorAdmVo);
			jsonData.put("data", equipCondTempaturSixFloorAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 온도 등록
	@RequestMapping(value = "/bm/tempaturSixFloorCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tempaturSixFloorCreate(EquipCondTempaturSixFloorAdmVo equipCondTempaturSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 등록 = "+ equipCondTempaturSixFloorAdmVo);
		
		try {
			String sequence = equipCondTempaturAdmService.selectTempaturSixFloorSeqCd();	// 시퀀스 코드번호 조회
			equipCondTempaturSixFloorAdmVo.setTempaturCondCd(sequence);
			equipCondTempaturSixFloorAdmVo.setRegId(Utils.getUserId());
			
			equipCondTempaturAdmService.tempaturSixFloorCreate(equipCondTempaturSixFloorAdmVo);
			equipCondTempaturSixFloorAdmVo = equipCondTempaturAdmService.tempaturSixFloorRead(equipCondTempaturSixFloorAdmVo);
			jsonData.put("data", equipCondTempaturSixFloorAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 온도 수정
	@RequestMapping(value = "/bm/tempaturSixFloorUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> tempaturSixFloorUpdate(EquipCondTempaturSixFloorAdmVo equipCondTempaturSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 온도 수정 = "+ equipCondTempaturSixFloorAdmVo);
		try {
			equipCondTempaturSixFloorAdmVo.setUpdId(Utils.getUserId());
			equipCondTempaturAdmService.tempaturSixFloorUpdate(equipCondTempaturSixFloorAdmVo);
			equipCondTempaturSixFloorAdmVo = equipCondTempaturAdmService.tempaturSixFloorRead(equipCondTempaturSixFloorAdmVo);
		    jsonData.put("data", equipCondTempaturSixFloorAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 온도 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	
	
	
	/*-------------- 시간 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 시간 목록조회
	@RequestMapping(value = "/bm/timeSixFloorList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> timeSixFloorList(EquipCondTimeSixFloorAdmVo equipCondTimeSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 시간 목록조회 = "+ equipCondTimeSixFloorAdmVo);
		try {
			List<EquipCondTimeSixFloorAdmVo> equipCondTimeSixFloorAdmVoList= equipCondTimeAdmService.timeSixFloorList(equipCondTimeSixFloorAdmVo);
			jsonData.put("data", equipCondTimeSixFloorAdmVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 시간 상세조회
	@RequestMapping(value = "/bm/timeSixFloorRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> timeSixFloorRead(EquipCondTimeSixFloorAdmVo equipCondTimeSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 상세조회 = "+ equipCondTimeSixFloorAdmVo);
		try {		
			equipCondTimeSixFloorAdmVo = equipCondTimeAdmService.timeSixFloorRead(equipCondTimeSixFloorAdmVo);
			jsonData.put("data", equipCondTimeSixFloorAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("BOM 시간 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 시간 등록
	@RequestMapping(value = "/bm/timeSixFloorCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> timeSixFloorCreate(EquipCondTimeSixFloorAdmVo equipCondTimeSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 등록 = "+ equipCondTimeSixFloorAdmVo);
		
		try {
			String sequence = equipCondTimeAdmService.selectTimeSixFloorSeqCd();	// 시퀀스조회
			equipCondTimeSixFloorAdmVo.setTimeCondCd(sequence);
			equipCondTimeSixFloorAdmVo.setRegId(Utils.getUserId());
			
			equipCondTimeAdmService.timeSixFloorCreate(equipCondTimeSixFloorAdmVo);
			equipCondTimeSixFloorAdmVo = equipCondTimeAdmService.timeSixFloorRead(equipCondTimeSixFloorAdmVo);
			jsonData.put("data", equipCondTimeSixFloorAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;			
	}
	
	//BOM 시간 수정
	@RequestMapping(value = "/bm/timeSixFloorUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> timeSixFloorUpdate (EquipCondTimeSixFloorAdmVo equipCondTimeSixFloorAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 시간 수정 = "+ equipCondTimeSixFloorAdmVo);
		try {		
			equipCondTimeAdmService.timeSixFloorUpdate(equipCondTimeSixFloorAdmVo);
			equipCondTimeSixFloorAdmVo = equipCondTimeAdmService.timeSixFloorRead(equipCondTimeSixFloorAdmVo);
		    jsonData.put("data", equipCondTimeSixFloorAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 시간 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 시간 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	
	/*-------------- 치수 시작 ---------------------------------------------------------------------------------------------------------------------------------------*/
	//BOM 치수 목록조회
	@RequestMapping(value = "/bm/sizeSixFloorList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeSixFloorList(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("BOM 치수 목록조회 = "+equipCondSizeAdmVo);
		try {
			List<EquipCondSizeAdmVo> sizeSixFloorList = equipCondSizeAdmService.sizeSixFloorList(equipCondSizeAdmVo);
			jsonData.put("data", sizeSixFloorList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//BOM 압력 상세조회
	@RequestMapping(value = "/bm/sizeSixFloorRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeSixFloorRead(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 상세조회 = "+equipCondSizeAdmVo);
		try {
			equipCondSizeAdmVo = equipCondSizeAdmService.sizeSixFloorRead(equipCondSizeAdmVo);
			jsonData.put("data", equipCondSizeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 등록
	@RequestMapping(value = "/bm/sizeSixFloorCeate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sizeSixFloorCeate(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 등록 = "+equipCondSizeAdmVo);
		try {
			String sequence = equipCondSizeAdmService.selectSizeSixFloorSeqCd();	// 코드번호 부여하기
			equipCondSizeAdmVo.setSizeCondCd(sequence);
			equipCondSizeAdmVo.setRegId(Utils.getUserId());
			equipCondSizeAdmService.sizeSixFloorCeate(equipCondSizeAdmVo);
			equipCondSizeAdmVo = equipCondSizeAdmService.sizeSixFloorRead(equipCondSizeAdmVo);
			jsonData.put("data", equipCondSizeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//BOM 압력 수정
	@RequestMapping(value = "/bm/sizeSixFloorUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> sizeSixFloorUpdate(EquipCondSizeAdmVo equipCondSizeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("BOM 치수 수정 = "+equipCondSizeAdmVo);
		try {
			equipCondSizeAdmVo.setUpdId(Utils.getUserId());
			equipCondSizeAdmService.sizeSixFloorUpdate(equipCondSizeAdmVo);
			equipCondSizeAdmVo = equipCondSizeAdmService.sizeSixFloorRead(equipCondSizeAdmVo);
		    jsonData.put("data", equipCondSizeAdmVo);
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 치수 등록 수정");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	/*-------------- 치수 끝 ---------------------------------------------------------------------------------------------------------------------------------------*/
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ6층 온도 정보(Bom온도조건관리)_23.10.24 추가ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}