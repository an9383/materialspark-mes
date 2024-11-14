package mes.web.em;

import java.lang.reflect.Field;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCondSizeAdmVo;
import mes.domain.bm.EquipCondTempaturSixFloorAdmVo;
import mes.domain.bm.EquipCondTimeSixFloorAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.em.EquipCondCommonAdmVo;
import mes.domain.em.ManufacturerVo;
import mes.service.bm.EquipCondSizeAdmService;
import mes.service.bm.EquipCondTempaturAdmService;
import mes.service.bm.EquipCondTimeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.ManufacturerService;
import mes.web.ut.Utils;

@Controller
public class ManufacturerSixFloorController {

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCondTempaturAdmService equipCondTempaturAdmService;
	@Inject
	private EquipCondTimeAdmService equipCondTimeAdmService;
	@Inject
	private EquipCondSizeAdmService equipCondSizeAdmService;
	@Inject
	private ManufacturerService manufacturerService;
	

	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(ManufacturerSixFloorController.class);	
	
	//설비코드관리 페이지
	@RequestMapping(value = "/emsc3030", method = RequestMethod.GET)
	public String emsc3020GET(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("작업지시(설비별 생산계획) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList );
		
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
		
		return "em/emsc3030";
	}
	
	//설비 계획 상세 조회
	@RequestMapping(value = "/em/equipBomDataSixFloorList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipBomDataSixFloorList(ManufacturerVo manufacturerVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("특정 설비계획 상세 조회" + manufacturerVo.getMenuAuth());
		try {
			
			String pageGubun	= manufacturerVo.getPageGubun();
			String equipCondSeq	= manufacturerVo.getEquipCondSeq();
			
			manufacturerVo = manufacturerService.read(manufacturerVo);
			logger.info("제품코드 조회 : " + manufacturerVo);
			jsonData.put("manufacturerData", manufacturerVo);
			
			EquipCondTempaturSixFloorAdmVo tempaturVo	= new EquipCondTempaturSixFloorAdmVo();
			EquipCondTimeSixFloorAdmVo timeVo			= new EquipCondTimeSixFloorAdmVo();
			EquipCondSizeAdmVo sizeVo					= new EquipCondSizeAdmVo();

			tempaturVo.setPageGubun(pageGubun);
			tempaturVo.setEquipCondSeq(equipCondSeq);
			
			timeVo.setPageGubun(pageGubun);
			timeVo.setEquipCondSeq(equipCondSeq);
			
			sizeVo.setPageGubun(pageGubun);
			sizeVo.setEquipCondSeq(equipCondSeq);
			
			tempaturVo	= equipCondTempaturAdmService.tempaturSixFloorRead(tempaturVo);
			timeVo		= equipCondTimeAdmService.timeSixFloorRead(timeVo);
			sizeVo		= equipCondSizeAdmService.sizeSixFloorRead(sizeVo);
			
			jsonData.put("tempaturData", tempaturVo);
			jsonData.put("timeData", timeVo);
			jsonData.put("sizeData", sizeVo);
	
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
	
	//4Line 설비 계획 일괄 등록
	@RequestMapping(value = "/em/equipCondCommonSixFloorAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCondCommonSixFloorAdmCreate(EquipCondTempaturSixFloorAdmVo tempaturVo, EquipCondTimeSixFloorAdmVo timeVo, EquipCondSizeAdmVo sizeVo, EquipCondCommonAdmVo commonVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비계획 등록");
		try {
			String equipCondSeq = manufacturerService.selectEquipCondSeq();	//설비 시퀀스 번호 생성
			logger.info("생성할 Seq 번호 : " + equipCondSeq);
			
			//생성된 설비 시퀀스 번호 부여
			tempaturVo.setEquipCondSeq(equipCondSeq);
			timeVo.setEquipCondSeq(equipCondSeq);
			sizeVo.setEquipCondSeq(equipCondSeq);
			commonVo.setEquipCondSeq(equipCondSeq);
			
			//등록자
			tempaturVo.setRegId(Utils.getUserId());
			timeVo.setRegId(Utils.getUserId());
			sizeVo.setRegId(Utils.getUserId());
			commonVo.setRegId(Utils.getUserId());
			
			//뭔가(FP)를 삭제? 업데이트 하는 코드
			if( "001".equals(commonVo.getFpMainGubun()) ) {			
				commonVo.setFactoryCode(factoryCode);
				manufacturerService.deleteFpMainGubun(commonVo);	
				logger.info("팩토리코드 : "+commonVo.getFactoryCode());
			}
			
			commonVo.setUseYnCd("Y");
			
			//4Line 설비조건공통관리 생성
			manufacturerService.equipCondCommonSixFloorAdmCreate(commonVo);
			//온도
			equipCondTempaturAdmService.tempaturSixFloorCreate(tempaturVo);
			//시간
			equipCondTimeAdmService.timeSixFloorCreate(timeVo);
			//치수
			equipCondSizeAdmService.sizeSixFloorCeate(sizeVo);
			
			logger.info("설비계획 등록 성공");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//4Line 설비 계획 일괄 수정
	@RequestMapping(value = "/em/equipCondCommonSixFloorAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCondCommonSixFloorAdmUpdate(EquipCondTempaturSixFloorAdmVo tempaturVo, EquipCondTimeSixFloorAdmVo timeVo, EquipCondSizeAdmVo sizeVo, EquipCondCommonAdmVo commonVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비계획 수정");
		try {
			//수정자
			tempaturVo.setUpdId(Utils.getUserId());
			timeVo.setUpdId(Utils.getUserId());
			sizeVo.setUpdId(Utils.getUserId());
			commonVo.setUpdId(Utils.getUserId());
			
			//뭔가(FP)를 삭제? 업데이트 하는 코드
			if( "001".equals(commonVo.getFpMainGubun()) ) {			
				commonVo.setFactoryCode(factoryCode);
				manufacturerService.deleteFpMainGubun(commonVo);	
				logger.info("팩토리코드 : "+commonVo.getFactoryCode());
			}
			
			//4Line 설비조건공통관리 생성
			manufacturerService.equipCondCommonSixFloorAdmUpdate(commonVo);
			//온도
			equipCondTempaturAdmService.tempaturSixFloorUpdate(tempaturVo);
			//시간
			equipCondTimeAdmService.timeSixFloorUpdate(timeVo);
			//치수
			equipCondSizeAdmService.sizeSixFloorUpdate(sizeVo);
			
			logger.info("설비계획 수정 성공");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("BOM 온도 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
}