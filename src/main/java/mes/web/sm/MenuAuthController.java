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
public class MenuAuthController {
	
	@Inject
	private MenuAuthService menuAuthService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private MenuInfoAdmService menuInfoAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	@RequestMapping(value = "/smsc0030", method = RequestMethod.GET)
	public String matrlUserMain(Model model) throws Exception {
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("045"); // 권한유무
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("authCd", systemCommonCodeList );
		return "sm/smsc0030";
	}
	
	//부서 목록 조회
	@RequestMapping(value = "/sm/departmentDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> departmentDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부서 목록조회");
		systemCommonCodeVo.setBaseGroupCd("013");
		List<SystemCommonCodeVo> menuInfoData = systemCommonCodeService.listAll(systemCommonCodeVo);
		jsonData.put("data", menuInfoData);
		
		return jsonData;
	}

	//메뉴목록 조회
	@RequestMapping(value = "/sm/menuDataList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuDataList(MenuAuthVo menuAuthVo) throws Exception {
		
		MenuInfoAdmVo menuInfoAdmVo = new MenuInfoAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부서 목록조회");
		
		try {
			List<MenuInfoAdmVo> matrlParentData = menuInfoAdmService.readUpperMenu(menuInfoAdmVo);
			List<MenuInfoAdmVo> matrlChildData = menuInfoAdmService.subMenu(menuInfoAdmVo);
			if(menuAuthVo!=null) {
				if(0 == menuAuthService.readCheck(menuAuthVo).getCnt()) {
					menuAuthVo.setUserNumber("kkkk");
				}
				List<MenuAuthVo> menuAuthData = menuAuthService.readAll(menuAuthVo);
				jsonData.put("check", menuAuthData);
			} 
			/*
			 * int a = matrlUserData.size(); for(int i=0; i<a; i++) { jsonData.put("data"+i,
			 * matrlUserData.get(i)); }
			 */
			jsonData.put("parent", matrlParentData);
			jsonData.put("child", matrlChildData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("부서 목록 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//권한 저장
	@RequestMapping(value = "/sm/authSave", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> authSave(@RequestBody List<Map<String, Object>> matrlDepartmentList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		MenuAuthVo menuAuthVo = new MenuAuthVo();
		logger.info("권한 정보 저장" + matrlDepartmentList);

		try {
			if(matrlDepartmentList.size() != 0) {
				menuAuthVo.setDepartmentCd(matrlDepartmentList.get(0).get("departmentCd").toString());
				menuAuthVo.setUserNumber(matrlDepartmentList.get(0).get("userNumber").toString());
				menuAuthService.delete(menuAuthVo);   
				
					for(Map<String, Object> m : matrlDepartmentList) {						
						   menuAuthVo.setMenuId(m.get("menuId").toString());
						   menuAuthVo.setDepartmentCd(m.get("departmentCd").toString());
						   menuAuthVo.setUseYnCd(m.get("useYnCd").toString());
						   menuAuthVo.setUserNumber(m.get("userNumber").toString());
						   menuAuthVo.setRegId(Utils.getUserId());
						   menuAuthVo.setUpdId(Utils.getUserId());
						    menuAuthService.create(menuAuthVo);					   
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
		
		/*
		 * for(Map<String, Object> m : matrlDepartmentList) { MenuInfoAdmVo
		 * menuInfoAdmVo = new MenuInfoAdmVo();
		 * menuInfoAdmVo.setMenuId(m.get("menuId").toString());
		 * 
		 * menuInfoAdmVo = menuInfoAdmService.read(menuInfoAdmVo); for(Map<String,
		 * Object> k : matrlDepartmentList) { int i=0;
		 * if(menuInfoAdmVo.getUpperMenuId().equals(k.get("menuId").toString()) ||
		 * menuInfoAdmVo.getUpperMenuId()==null ) {
		 * 
		 * } else { ++i; if(i == k.size()) {
		 * 
		 * menuAuthVo.setMenuId(menuInfoAdmVo.getUpperMenuId());
		 * menuAuthVo.setDepartmentCd(m.get("departmentCd").toString());
		 * menuAuthVo.setUseYnCd(m.get("useYnCd").toString());
		 * menuAuthVo.setRegId("Utils.getUserId()"); menuAuthVo.setUpdId(Utils.getUserId());
		 * 
		 * if(menuAuthService.check(menuAuthVo)==null){
		 * menuAuthService.create(menuAuthVo); } else {
		 * menuAuthService.delete(menuAuthVo); menuAuthService.create(menuAuthVo);
		 * 
		 * //menuAuthService.update(menuAuthVo);
		 * 
		 * }
		 * 
		 * } } } }
		 */
		
	}
	
	//권한 삭제
	@RequestMapping(value = "/sm/authDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> authDelete(MenuAuthVo menuAuthVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("권한 정보 삭제");

		try {
			menuAuthService.delete(menuAuthVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("권한 정보 삭제 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	/*
	 * @RequestMapping(value = "/asideMenu", method = RequestMethod.POST)
	 * public @ResponseBody Map<String, Object> asideMenu(HttpServletRequest
	 * request, RedirectAttributes rttr) throws Exception {
	 * 
	 * Map<String, Object> jsonData = new HashMap<String, Object>(); MenuInfoAdmVo
	 * menuInfoAdmVo = new MenuInfoAdmVo(); HttpSession session =
	 * request.getSession(true);
	 * 
	 * 
	 * List<UserMenuAuthVo> userMenuAuthData = new ArrayList<UserMenuAuthVo>();
	 * logger.info("aside 메뉴"); //로그인 유저 메뉴 권한리스트
	 * System.out.println("userAuth Start--------------------------");
	 * System.out.println(session.getAttribute("userAuth")); List<MenuAuthVo>
	 * attribute = (List<MenuAuthVo>) session.getAttribute("userAuth");
	 * 
	 * for(MenuAuthVo m : attribute) { menuInfoAdmVo.setMenuId(m.getMenuId());
	 * menuInfoAdmVo = menuInfoAdmService.read(menuInfoAdmVo); UserMenuAuthVo
	 * userMenuAuthVo = new UserMenuAuthVo();
	 * userMenuAuthVo.setMenuId(menuInfoAdmVo.getMenuId());
	 * userMenuAuthVo.setMenuNm(menuInfoAdmVo.getMenuNm());
	 * userMenuAuthVo.setMenuPath(menuInfoAdmVo.getMenuPath());
	 * 
	 * if(menuInfoAdmVo.getUpperMenuId() == null) {
	 * userMenuAuthVo.setMenuCheck("upper"); } else {
	 * userMenuAuthVo.setMenuCheck("sub");
	 * userMenuAuthVo.setMenuUpperId(menuInfoAdmVo.getUpperMenuId()); }
	 * 
	 * userMenuAuthData.add(userMenuAuthVo); System.out.println(userMenuAuthData); }
	 * 
	 * jsonData.put("result", userMenuAuthData);
	 * 
	 * return jsonData; }
	 */
	

}

