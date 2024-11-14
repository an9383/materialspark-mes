package mes.web.sm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.sm.MatrlUserVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.sm.MatrlUserService;
import mes.web.ut.Utils;

@Controller
public class MatrlUserController {
	
	@Inject
	private MatrlUserService matrlUserService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	//자재코드관리 메인
	@RequestMapping(value = "/smsc0010", method = RequestMethod.GET)
	public String matrlUserMain(Model model) throws Exception {
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("025"); // 입퇴유무
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("empYnCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("013"); // 담당
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("departmentCd", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("014"); // 담당
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("chargrDuty", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("015"); // 직위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("postCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("teamCd", systemCommonCodeList );		
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("029"); // 사업장
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workplaceCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("039"); // 메뉴팝업여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("menuPopupYnCd", systemCommonCodeList );
		
		return "sm/smsc0010";
	}
		
	@RequestMapping(value = "/sm/matrlUserDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdDataList(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 목록조회 : " + matrlUserVo);
		try {
			List<MatrlUserVo> matrlUserData = matrlUserService.listAll(matrlUserVo);
			jsonData.put("data", matrlUserData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("사용자 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	@RequestMapping(value = "/sm/matrlUserDataList2", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdDataList2(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 목록조회");
		
		try {
			List<MatrlUserVo> matrlUserData1 = matrlUserService.listAll2(matrlUserVo);
			System.out.println("데이터리스트는 : " + matrlUserData1);
			jsonData.put("data", matrlUserData1);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("사용자 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//삭제권한 사용자 목록조회
	@RequestMapping(value = "/sm/userAuthDeleteList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> userAuthDeleteList(MatrlUserVo matrlUserVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("삭제권한 사용자 목록조회 : " + matrlUserVo);
		try {
			List<MatrlUserVo> matrlUserData = matrlUserService.userAuthDeleteListAll_F1F2F3(matrlUserVo);
			jsonData.put("data", matrlUserData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("삭제권한 사용자 목록조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	//권한 사용자 체크
	@RequestMapping(value = "/sm/authIdCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> authIdCheck(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("삭제권한 사용자 체크");
		try {
			MatrlUserVo userVo = matrlUserService.userAuthDeleteCheck_F1F2F3(matrlUserVo);
			if( userVo == null ) {
				jsonData.put("result", "fail");
				jsonData.put("message", "권한이 존재하지 않는 아이디 입니다.");
			} else {
				if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {				 
					jsonData.put("result", "fail");
					jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
				//로그인 불가
				} else {
					jsonData.put("result", "ok");
				}
				//jsonData.put("data", matrlUserVo);
			}			
		} catch (Exception e) {
			logger.info("삭제권한 사용자 체크 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	@RequestMapping(value = "/sm/matrlUserData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdData(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 상세 조회");
		
		try {
			matrlUserVo.setFactoryCode(factoryCode);
			matrlUserVo = matrlUserService.read(matrlUserVo);
			jsonData.put("data", matrlUserVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사용자 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//유저정보 등록
	@RequestMapping(value = "/sm/matrlUserCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlUserCreate(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 등록");
		matrlUserVo.setRegId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		try {
			String matrlUserNumberSeq = matrlUserService.selectUserNumberSeq();
			matrlUserVo.setUserNumber(matrlUserNumberSeq);
			matrlUserVo.setUserPw(BCrypt.hashpw(matrlUserVo.getUserPw().toString(), BCrypt.gensalt(12)));
			matrlUserVo.setFactoryCode(factoryCode);
			matrlUserService.create(matrlUserVo);
			jsonData.put("data", matrlUserVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사용자 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//유저정보 수정
	@RequestMapping(value = "/sm/matrlUserUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlUserUpdate(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 수정");
		matrlUserVo.setUpdId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		
		try {
			if(matrlUserVo.getUserPw().equals("") || matrlUserVo.getUserPw() == null ) {
				
			} else {
				matrlUserVo.setUserPw(BCrypt.hashpw(matrlUserVo.getUserPw().toString(), BCrypt.gensalt(12)));
			}			
			matrlUserVo.setFactoryCode(factoryCode);
			matrlUserService.update(matrlUserVo);		
			jsonData.put("data", matrlUserVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사용자 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	
	
	@RequestMapping(value = "/sm/checkIdData", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkUserId(MatrlUserVo matrlUserVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("id 체크");
		
		try {
			matrlUserVo.setFactoryCode(factoryCode);
			matrlUserVo = matrlUserService.read(matrlUserVo);
			jsonData.put("res", matrlUserVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("id 체크 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//사번코드 생성
	@RequestMapping(value = "/sm/userNumberCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> userNumberCreate() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사번코드 생성");
		
		try {
			String matrlUserNumberSeq = matrlUserService.selectUserNumberSeq();
			MatrlUserVo matrlUserVo = new MatrlUserVo();
			matrlUserVo.setUserNumber(matrlUserNumberSeq);
			jsonData.put("data", matrlUserVo);	
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사번코드 생성 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}		
	
	//사용자 정보조회
	@RequestMapping(value = "/sm/info", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> infoMain(HttpServletRequest request, Model model) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();		
		MatrlUserVo matrlUserVo = new MatrlUserVo();		
		
		matrlUserVo.setUserId(request.getSession().getAttribute("userId").toString());
		matrlUserVo.setUserNumber(request.getSession().getAttribute("userNumber").toString());
		try {	
			matrlUserVo = matrlUserService.read(matrlUserVo);
			logger.info("조사아아앙아아아아" + matrlUserVo);
			jsonData.put("data", matrlUserVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("사용자 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/sm/passChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> passChange(@RequestParam(value="nowPass") String nowPass,
														@RequestParam(value="changePassword") String changePass,																								
														HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		MatrlUserVo matrlUserVo = new MatrlUserVo();
		logger.info("--------------------------------------------------");
		logger.info(" " + nowPass);
		logger.info(" " + changePass);

		try {
			matrlUserVo.setUserId(request.getSession().getAttribute("userId").toString());
			matrlUserVo.setUserNumber(request.getSession().getAttribute("userNumber").toString());
			matrlUserVo = matrlUserService.read(matrlUserVo);
			matrlUserVo.setUpdId(Utils.getUserId());
			if (!BCrypt.checkpw (nowPass,matrlUserVo.getUserPw()) ) {				 
				jsonData.put("result", "fail");
				jsonData.put("message", "비밀번호가 일치하지 않습니다.");
			} else {
				matrlUserVo.setUserPw(BCrypt.hashpw(changePass.toString(), BCrypt.gensalt(12)));
				matrlUserService.update(matrlUserVo);
				jsonData.put("data", matrlUserVo);
				jsonData.put("result", "ok");
			}			
		
		} catch (Exception e) {
			logger.info("사용자 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	
	
	
	//메뉴팝업여부 변경
	@RequestMapping(value = "/sm/menuPopupChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuPopupChange(@RequestParam(value="menuPopupYn") String menuPopupYn, HttpServletRequest request) throws Exception {
		MatrlUserVo matrlUserVo = new MatrlUserVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();	

		try {
			matrlUserVo.setUserId(request.getSession().getAttribute("userId").toString());
			matrlUserVo.setUserNumber(request.getSession().getAttribute("userNumber").toString());
			matrlUserVo = matrlUserService.read(matrlUserVo);
			matrlUserVo.setUpdId(Utils.getUserId());
			matrlUserVo.setMenuPopupYn(menuPopupYn);
			matrlUserService.update(matrlUserVo);	
		
			jsonData.put("data", matrlUserVo);
			jsonData.put("result", "ok");
			
		
		} catch (Exception e) {
			logger.info("사용자 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	
	
	
	
	
}
