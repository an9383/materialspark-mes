package mes.web.sm;

import java.util.HashMap;
import java.util.List;
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

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.sm.MenuAuthService;
import mes.service.sm.MenuInfoAdmService;
import mes.web.ut.Utils;

@Controller
public class UserAuthController {
	
	@Inject
	private MenuAuthService menuAuthService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private MenuInfoAdmService menuInfoAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	@RequestMapping(value = "/smsc0050", method = RequestMethod.GET)
	public String matrlUserMain(Model model) throws Exception {
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("098"); // 사용자권한 대분류
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("userAuthMainCategory", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("099"); // 사용자권한 소분류
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("userAuthSubCategory", systemCommonCodeList );
		
		return "sm/smsc0050";
	}
	//권한목록 조회
	@RequestMapping(value = "/sm/authDataList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuDataList(MenuAuthVo menuAuthVo) throws Exception {
		
		MenuInfoAdmVo menuInfoAdmVo = new MenuInfoAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("권한목록 조회");
		
		try {
			List<MenuInfoAdmVo> matrlParentData = menuInfoAdmService.readUpperAuth_F1F2F3(menuInfoAdmVo);
			List<MenuInfoAdmVo> matrlChildData = menuInfoAdmService.subAuth_F1F2F3(menuInfoAdmVo);
			if(menuAuthVo!=null) {
				/*if(0 == menuAuthService.readCheck(menuAuthVo).getCnt()) {
					menuAuthVo.setUserNumber("kkkk");
				}*/
				List<MenuAuthVo> menuAuthData = menuAuthService.readUserAuthAll_F1F2F3(menuAuthVo);
				jsonData.put("check", menuAuthData);
			} 
			jsonData.put("parent", matrlParentData);
			jsonData.put("child", matrlChildData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("권한 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
	
		return jsonData;
	}
	//권한 저장
	@RequestMapping(value = "/sm/userAuthSave", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> authSave(@RequestBody List<Map<String, Object>> matrlDepartmentList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		MenuAuthVo menuAuthVo = new MenuAuthVo();
		logger.info("권한 정보 저장" + matrlDepartmentList);
	
		try {
			if(matrlDepartmentList.size() != 0) {
				//menuAuthVo.setDepartmentCd(matrlDepartmentList.get(0).get("departmentCd").toString());
				menuAuthVo.setUserNumber(matrlDepartmentList.get(0).get("userNumber").toString());
				menuAuthService.deleteUserAuth_F1F2F3(menuAuthVo);   
					for(Map<String, Object> m : matrlDepartmentList) {			
						   menuAuthVo.setUserNumber(m.get("userNumber").toString());
						   menuAuthVo.setBaseCd(m.get("baseCd").toString());
						   menuAuthVo.setBaseCdNm(m.get("baseCdNm").toString());
						   menuAuthVo.setRegId(Utils.getUserId());
						   menuAuthVo.setUpdId(Utils.getUserId());
						   menuAuthService.createUserAuth_F1F2F3(menuAuthVo);					   
					}
				jsonData.put("result", "ok");
			} else {
				jsonData.put("result", "fail");
				jsonData.put("message", "최소 한개의 권한을 선택해주세요.");
			}
			
		} catch (Exception e) {
			logger.info("권한 정보 저장 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//사용자권한 삭제
	@RequestMapping(value = "/sm/deleteUserAuth", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> authDelete(MenuAuthVo menuAuthVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("권한 정보 삭제");
	
		try {
			menuAuthService.deleteUserAuth_F1F2F3(menuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("권한 정보 삭제 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//사용자 목록 조회
	@RequestMapping(value = "/sm/userList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> userList(MenuAuthVo menuAuthVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자(권한) 목록 조회");
	
		try {
			List<MenuAuthVo> returnMenuAuthVo = menuAuthService.userList_F1F2F3(menuAuthVo);
			jsonData.put("data", returnMenuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사용자(권한) 목록 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
		
	//사용자권한 목록 조회
	@RequestMapping(value = "/sm/userAuthList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> userAuthList(MenuAuthVo menuAuthVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("권한 목록 조회");
	
		try {
			List<MenuAuthVo> returnMenuAuthVo = menuAuthService.userAuthList_F1F2F3(menuAuthVo);
			jsonData.put("data", returnMenuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("권한 목록 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
			
		return jsonData;
	}
}

