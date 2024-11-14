package mes.web.bm;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class EquipCodeAdmController {
	
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(EquipCodeAdmController.class);
	
	//설비코드관리 페이지
	@RequestMapping(value = "/bmsc0030", method = RequestMethod.GET)
	public String equipCodeAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("설비코드관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("010"); // 설비 분류
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipCtrgy", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비 그룹
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );		

		systemCommonCodeVo.setBaseGroupCd("022"); // 설치 장소
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("installLocation", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("049"); // 설비 라인
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipLineCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("086"); // 가상 호기
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("virtualEquipCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("090"); // 듀얼호기 묶음
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dualEquipSet", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("095"); // 기본조회여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("selectYn", systemCommonCodeList );
		
		return "bm/bmsc0030";
	}
	
	//설비코드 전체 조회
	@RequestMapping(value = "/bm/equipCodeAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipCodeAdmDataList(EquipCodeAdmVo equipCodeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비정보관리 목록 조회 = "+ equipCodeAdmVo);
		try {
			List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
			jsonData.put("data", equipCodeAdmVoList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("설비정보관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//작업지시선택 설비리스트 & 모니터링 대상List
	@RequestMapping(value = "/bm/monitoringEquipCodeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> monitoringEquipCodeList(EquipCodeAdmVo equipCodeAdmVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비정보관리 목록 조회 = "+ equipCodeAdmVo);
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			List<EquipCodeAdmVo> equipCodeAdmVoList = null;
			
			//생산실적-공정실적관리(POP), posc0010중 모니터링 대상 ajax에서 날라왔는지 확인
			//if ("popMonitoring".equals(equipCodeAdmVo.getEquipGroup())) {
				//POP 접속 IP
				String clientIp = Utils.getClientIP(request);
				logger.info("접속자 IP : " + clientIp);
				systemCommonCodeVo.setBaseGroupCd("017"); //접속자 IP로 설비그룹이 설정되어 있는지 확인
				systemCommonCodeVo.setEtc1(clientIp);
				systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
				if (systemCommonCodeVo == null) {
					equipCodeAdmVo.setEquipGroup("empty");
				} else {
					equipCodeAdmVo.setEquipGroup(systemCommonCodeVo.getBaseCd());
				}
			//}

			equipCodeAdmVoList = equipCodeAdmService.listAll(equipCodeAdmVo);
			jsonData.put("data", equipCodeAdmVoList);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("설비정보관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	

	//설비코드 상세조회
	@RequestMapping(value = "/bm/equipCodeAdmView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipCodeAdmView(EquipCodeAdmVo equipCodeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비코드 상세조회 : "+equipCodeAdmVo);
		try {
			equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
			jsonData.put("data", equipCodeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비정보관리 목록 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//설비코드 등록
	@RequestMapping(value = "/bm/equipCodeAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCodeAdmCreate(EquipCodeAdmVo equipCodeAdmVo, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		
		try {
			equipCodeAdmVo.setEquipCheck("C");
			String checkCdNm= equipCodeAdmService.equipCdNmCheck(equipCodeAdmVo);
			if(!"Y".equals(checkCdNm)) {
				jsonData.put("message", "설비코드나 설비코드명을 중복으로 등록할 수 없습니다.<br/> 설비코드와 설비코드명을 확인해 주세요.");
				jsonData.put("data", equipCodeAdmVo);
				jsonData.put("result", "fail");				
			} else {
				equipCodeAdmVo.setRegId(Utils.getUserId());				
				equipCodeAdmService.create(equipCodeAdmVo);
				equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
				jsonData.put("data", equipCodeAdmVo);
				jsonData.put("result", "ok");
			}
		}
		catch (Exception e) {
			logger.info("설비정보관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//설비코드 수정
	@RequestMapping(value = "/bm/equipCodeAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipCodeAdmUpdate (EquipCodeAdmVo equipCodeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비코드관리 수정");

		try {
			equipCodeAdmVo.setEquipCheck("U");
			String checkCdNm= equipCodeAdmService.equipCdNmCheck(equipCodeAdmVo);
			if("Y".equals(checkCdNm)) {
				equipCodeAdmVo.setUpdId(Utils.getUserId());
				equipCodeAdmService.update(equipCodeAdmVo);
				jsonData.put("data", equipCodeAdmVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("message", "설비코드명을 중복으로 등록할 수 없습니다.<br/>  설비코드명을 확인해 주세요.");
				jsonData.put("data", equipCodeAdmVo);
				jsonData.put("result", "fail");					
			}
		}
		catch (Exception e) {
			logger.info("설비정보관리 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;		
	}
	
}