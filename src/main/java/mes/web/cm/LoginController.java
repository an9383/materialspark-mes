package mes.web.cm;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONObject;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import mes.domain.bm.LogionHistVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.domain.sm.SystemLogAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.sm.MatrlUserService;
import mes.service.sm.MenuAuthService;
import mes.service.sm.MenuInfoAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
@RequestMapping("/")
public class LoginController {
	
	@Inject
	private MatrlUserService matrlUserService;
	@Inject
	private MenuAuthService menuAuthService;
	@Inject
	private MenuInfoAdmService menuInfoAdmService;
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	@Value("${factoryCode}") private String facotryCode;
	@Value("${factoryCode}") private String factoryCode;
	@Value("${apiKey}") private String apiKey;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	// 세션 검사
	public static boolean isValidSession(HttpServletRequest request) {
		if (request.getSession().getAttribute("userNumber") != null
				&& request.getSession().getAttribute("userId") != null	
				&& request.getSession().getAttribute("department") != null
		)
		{
			return true;
		} else {
		
			return false;
		}
	}
	
	// 로그인
	@RequestMapping(value = "/auth/login", method = RequestMethod.GET)
	public ModelAndView login(ModelAndView mav, HttpServletRequest request, HttpServletResponse response) throws Exception {

		MatrlUserVo matrlUserVo = new MatrlUserVo();
		HttpSession session = request.getSession(true);
		session.setAttribute(Constants.FACTORY_CODE, facotryCode);							//공장코드, 001-머티1공장(성남), 002-머티2공장(성남), 003-머티3공장(솔브레인 SLD)
		
		try {
			String menuPath = session.getAttribute(Constants.MENU_PATH).toString();
			logger.info(menuPath);
			//logger.info("세션O 로그인페이지->Main으로 이동");
			//mav.setViewName("redirect:/main");
			
			//setViewName("cm/main");
		}
		catch (NullPointerException e) {
			logger.info("menuPath존재X 세션X 로그인페이지 진행");
			//e.printStackTrace();
			
			
			boolean checkCookieId = false;
			//String menuAuth =  request.getParameter("menuAuth");
			//String requestURI = request.getRequestURI();
			//boolean check=false;
			//boolean checkCookiePw = false;
			
			//PC인지 Mobile인지 확인
			boolean checkMobile = Utils.checkMobile(request);
			
			//Cookie[] cookies = request.getCookies() ;
			//if(cookies != null){
			//    for(int i=0; i < cookies.length; i++){
			//        Cookie c = cookies[i] ;
			//        if( c.getName().equals("userId")) {
			//        	matrlUserVo.setUserId(c.getValue());
			//        	checkCookieId = true;
			//        }
			//        //if( c.getName().equals("userPw")) {
			//        //	matrlUserVo.setUserPw(c.getValue());
			//        //	checkCookiePw = true;
			//        //}
		    //	}
			//    //쿠키 O
			//    if(checkCookieId == true) {
			//    	MatrlUserVo userVo = matrlUserService.read(matrlUserVo);
			//    	logger.info("사용자 정보 : " + userVo);
			//    	
			//    	if (	matrlUserVo.getUserId().equals(userVo.getUserId())	) {
			//    		logger.info("세션 X 쿠키 O");
			//    		session.setAttribute("userNumber", userVo.getUserNumber());
			//			session.setAttribute("userNm", userVo.getUserNm());
			//			session.setAttribute("userId", userVo.getUserId());
			//			session.setAttribute("department", userVo.getDepartmentCd());
			//			//session.setAttribute("userAuth", authList);
			//			//session.setAttribute("menuAuth", menuPath);
			//			
			//			Utils.setUserId(userVo.getUserId());
			//			Utils.setUserNm(userVo.getUserNm());
			//			Utils.setUserNumber(userVo.getUserNumber());
			//			
			//			//logger.info("Cookie 로그인 ID : " + Utils.getUserId());
			//			//logger.info("Cookie 로그인 이름 : " + Utils.getUserNm());
			//			//logger.info("Cookie 로그인 번호 : " + Utils.getUserNumber());
			//			
			//			MenuAuthVo menuAuthVo = new MenuAuthVo();
			//			//HttpSession session = request.getSession(true);
			//			menuAuthVo.setDepartmentCd(userVo.getDepartmentCd());
			//			
			//			List<MenuInfoAdmVo> authList = menuInfoAdmService.menuInfo(menuAuthVo);
			//			String menuPath="";
			//			
			//			for(MenuInfoAdmVo m : authList) {
			//				menuPath += m.getMenuPath() + ",";
			//				
			//			}
			//			
			//			System.out.println(menuPath);
			//			// 사용자 정보
			//			session.setAttribute("userNumber", userVo.getUserNumber());
			//			session.setAttribute("userNm", userVo.getUserNm());
			//			session.setAttribute("userId", userVo.getUserId());
			//			session.setAttribute("department", userVo.getDepartmentCd());
			//			session.setAttribute("userAuth", authList);
			//			session.setAttribute("menuAuth", menuPath);
			//			Utils.setUserId(userVo.getUserId());
	        //
			//			//jsonData.put("result", "ok");
			//			
			//			
			//			if (checkMobile == true) {
			//				response.sendRedirect("/pdsc0070");
			//			} else {
			//				response.sendRedirect("/bmsc0010");
			//			}
			//    		
			//    	//세션O 쿠기O이나 값 불일치
			//		} else { 
			//			logger.info("세션 O 쿠키 O 쿠키 but DB 불일치");
			//			//response.sendRedirect(request.getContextPath() + "/auth/login");
			//			//return false;
			//		}
			//    //쿠키 X
			//    } else {
			//    	logger.info("세션 X 쿠키 X");
			//    	//response.sendRedirect(request.getContextPath() + "/auth/login");
			//    	//return false;
			//    }
			//}
	
			if (checkMobile == true) {
				mav.setViewName("/auth/pdsc0080");
			} else {
				mav.setViewName("/auth/login");
			}
			
		}
		
		return mav;
	}
		
	
	// 로그인 처리 - ajax
	@RequestMapping(value = "/auth/login_ajax", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginAjaxPOST(MatrlUserVo matrlUserVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		MenuAuthVo menuAuthVo = new MenuAuthVo();
		matrlUserVo.setFactoryCode(facotryCode);
		// DB에서 로그인 정보 조회
		MatrlUserVo userVo = matrlUserService.read(matrlUserVo);
		logger.info("userVo  ====> "+userVo);
		 
		//사용자 있음
		if (userVo != null) {
			if (!BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) ) {				 
				jsonData.put("result", "fail");
				jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
				
			//로그인 불가
			} else if ("002".equals(userVo.getEmpYnCd())) {
				jsonData.put("result", "fail");
				jsonData.put("message", "퇴사자는 로그인 할 수 없습니다! 관리자에게 문의바랍니다.");
				
			// 로그인 성공
			} else {
				HttpSession session = request.getSession(true);
				menuAuthVo.setDepartmentCd(userVo.getDepartmentCd());
				menuAuthVo.setUserNumber(userVo.getUserNumber());
				List<MenuInfoAdmVo> authList = menuInfoAdmService.menuInfo(menuAuthVo);
				String menuPath = menuAuthService.menuAuthPath(menuAuthVo);
//				for(MenuInfoAdmVo m : authList) {
//					menuPath += m.getMenuPath() + ",";
//				}
				logger.info("authList = "+authList);
				
				SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
				systemCommonCodeVo.setBaseGroupCd("039"); // 메뉴팝업여부
				List<SystemCommonCodeVo>systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
				session.setAttribute("menuPopupYnCdModal", systemCommonCodeList );
				
				// 사용자 정보
				session.setAttribute(Constants.USER_NUMBER, userVo.getUserNumber());
				session.setAttribute(Constants.USER_NAME, userVo.getUserNm());
				session.setAttribute(Constants.USER_ID, userVo.getUserId());
				session.setAttribute(Constants.USER_DEPARTMENT_CD, userVo.getDepartmentCd());
				session.setAttribute(Constants.USER_DEPARTMENT_NM, userVo.getDepartmentNm());
				session.setAttribute(Constants.TEAM_CD, userVo.getTeamCd());
				session.setAttribute(Constants.USER_AUTH, authList);
				session.setAttribute(Constants.MENU_PATH, menuPath);
				session.setAttribute(Constants.AUTO_LOGIN, (String)matrlUserVo.getRememberMe());	//자동로그인 체크여부
				session.setAttribute(Constants.MENU_POPUP_YN, userVo.getMenuPopupYn());
				session.setAttribute(Constants.EQUIP_GROUP_CD, userVo.getEquipGroupCd());			//사용자 설비그룹
				session.setAttribute(Constants.SHOW_MENU, "no");									//작업지시선택 Menu 보이기/숨기기
				session.setAttribute(Constants.FACTORY_CODE, facotryCode);							//공장코드, 001-머티1공장(성남), 002-머티2공장(성남), 003-머티3공장(솔브레인 SLD)
				if(facotryCode.equals("003")) {
					session.setAttribute(Constants.TEAM_PAGE_MOVE_YN, userVo.getTeamPageMoveYn());				// 생산팀 화면이동 솔브레인(003)만 적용		
				}
				Utils.setUserId(userVo.getUserId());
				Utils.setUserNm(userVo.getUserNm());
				Utils.setUserNumber(userVo.getUserNumber());
				Utils.setUserDepartmentCd(userVo.getDepartmentCd());
				Utils.setUserDepartmentNm(userVo.getDepartmentNm());
				session.setAttribute(Constants.USER_SESSION_VO, userVo);
								
				//유틸에 잘 적용 됬나 확인
				//logger.info(Utils.getUserId());
				//logger.info(Utils.getUserNm());
				//logger.info(Utils.getUserNumber());
				//logger.info(Utils.getUserDepartmentCd());
				//logger.info(Utils.getUserDepartmentNm());
				
				String rememberMe = (String)matrlUserVo.getRememberMe();
				if (rememberMe.equals("true")) {
					Cookie cookieUserId  = new Cookie(Constants.USER_ID, userVo.getUserId());
					cookieUserId.setMaxAge(60 * 60 * 24);
					cookieUserId.setPath("/");
					response.addCookie(cookieUserId);
					//Cookie cookieUserPw  = new Cookie("userPw", userVo.getUserPw());
					//cookieUserPw.setMaxAge(60 * 60 * 24);
					//cookieUserPw.setPath("/");
					//response.addCookie(cookieUserPw);
				}
				
				//PC인지 Mobile인지 확인
				boolean checkMobile = Utils.checkMobile(request);
				
				//로그인 기록
				LogionHistVo logionHistVo = new LogionHistVo();
				logionHistVo.setLoginNo(Long.toString(systemCommonGroupService.selectLoginNo()));
				logionHistVo.setUserId(userVo.getUserId());
				logionHistVo.setIpAddress(Utils.getClientIP(request));
				logionHistVo.setGubun("Login");
				if (checkMobile == true) {
					logionHistVo.setEtc("Mobile");
				} else {
					logionHistVo.setEtc("PC");
				}
				systemCommonGroupService.createLoginHist(logionHistVo);
				
				
//-------------------------------------------------------------------로그전송-----------------------------------------------------------------------------------				
				
				if( !factoryCode.equals("003") ) {
				
					logger.info("시스템로그 전송");
					
					SystemLogAdmVo systemLogAdmVo = new SystemLogAdmVo();
					HttpURLConnection conn = null;
					DocumentBuilderFactory t_dbf = null;
					DocumentBuilder t_db = null;
					Document t_doc = null;
					NodeList t_nodes = null;
					Node t_node = null;
					Element t_element = null;
					InputSource t_is = new InputSource();
					String recptnRsltCd = null;
	
					try {
						//Gson gson = new Gson();
						String data = null;
						t_dbf = DocumentBuilderFactory.newInstance();
						t_db = t_dbf.newDocumentBuilder();
						t_is = new InputSource();
						
						// IP수집
						String ip = request.getHeader("X-FORWARDED-FOR");
						if (ip == null) ip = request.getRemoteAddr();
						
						String answer = "";							
	
						data = "<logData>";
						data += "<crtfcKey>" + apiKey + "</crtfcKey>";
						data += "<logDt>" + DateUtil.getToday("yyyy-mm-dd hh:mm:ss:ms") + "</logDt>";
						data += "<useSe>" + "접속" + "</useSe>";
						data += "<sysUser>" + Utils.getUserNm() + "</sysUser>";
						data += "<conectIp>" + ip + "</conectIp>";
						data += "<dataUsgqty>" + "0" + "</dataUsgqty>";
						data += "</logData>";
	
						logger.info("data = " + data );
						String logDataXml =  URLEncoder.encode(data, "UTF-8");
						String parameters = "logData="+ logDataXml;
						String targetUrl = "https://log.smart-factory.kr/apisvc/sendLogDataXML.do";
						logger.info("parameters = " + parameters );
						
				        URL url = new URL(targetUrl);
				        //URLConnection connection = url.openConnection();
				        conn = (HttpURLConnection) url.openConnection();
				        conn.setRequestMethod("POST"); 
				        //conn.setRequestProperty("Accept", "application/json");
				        conn.setRequestProperty("Content-Type", "application/xml");
				        conn.setRequestProperty("Content-Type",  "application/x-www-form-urlencoded; charset=utf-8");
				        conn.setRequestProperty("Content-Length", Integer.toString(parameters.getBytes("utf-8").length));
				        conn.setRequestProperty("Cache-Control","no-cache");
				        conn.setUseCaches(false);// 캐싱데이터를 받을지 말지 세팅합니다.
				        conn.setDoOutput(true); // OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
				        conn.setDoInput(true); // InputStream으로 서버로 부터 응답을 받겠다는 옵션.
	
				        //Send request
				        //위에서 세팅한 정보값을 바탕으로 요청을 보냅니다.
				        OutputStream os = conn.getOutputStream();
				        os.write(parameters.getBytes("utf-8"));
				        os.close();
	
				        //Get Response  
				        InputStream is = conn.getInputStream();
				        //요청 결과 (response)를 BufferedReader로 받습니다.
				        BufferedReader rd = new BufferedReader(new InputStreamReader(is));
				        // 자바 5 이상은 StringBuffer 를 이용해서 결과 값을 읽습니다.
				        StringBuilder response2 = new StringBuilder(); 
				        String line;
				        while ((line = rd.readLine()) != null) {
				          response2.append(line);
				          response2.append('\r');
				        }
				        rd.close();
				        is.close();
				        //return response.toString();		        
	
	
						logger.info("response2 = " + response2.toString() );
						if(response2 != null || "".equals(response2.toString()))	{
							t_is.setCharacterStream(new StringReader(response2.toString()));
							t_doc = t_db.parse(t_is);
							t_nodes = t_doc.getElementsByTagName("recptnRsltCd");
							recptnRsltCd = t_nodes.item(0).getTextContent();
							logger.info("recptnRsltCd = " + recptnRsltCd);
						}
	
						if(!"AP1002".equals(recptnRsltCd))
						{
							logger.error("log interface error recptnRsltCd  = " + recptnRsltCd);
						}
						
						if("AP1002".equals(recptnRsltCd) || "AP1029".equals(recptnRsltCd)) {
							// 전송할 데이터 생성
							JSONObject jsonObj2 = new JSONObject();
							if(factoryCode.equals("001")) {
								jsonObj2.put("dealCorpIdx", 3); // 고객사 식별자
							} else if(factoryCode.equals("002")) {
								jsonObj2.put("dealCorpIdx", 4); // 고객사 식별자
							} else if(factoryCode.equals("003")) {
								jsonObj2.put("dealCorpIdx", 1); // 고객사 식별자
							}
						
							jsonObj2.put("sendDate", DateUtil.getCurrentYyyymmdd()); // 전송일자
							jsonObj2.put("sendQty", "1"); // 총 접속건수
							jsonObj2.put("regIdx", '1'); // 사용자
							
							System.out.println("jsonObj2 --> " + jsonObj2);
							
							// 데이터 전송
							StringBuilder urlBuilder = new StringBuilder("http://crm.hygino.co.kr/mt/sfApiLogIns"); /*URL*/
							urlBuilder.append("?");
							urlBuilder.append("dealCorpIdx="+jsonObj2.get("dealCorpIdx").toString()+"&");
							urlBuilder.append("sendDate="+jsonObj2.get("sendDate").toString()+"&");
							urlBuilder.append("sendQty="+jsonObj2.get("sendQty").toString()+"&");
							urlBuilder.append("regIdx="+jsonObj2.get("regIdx").toString());
					        
					        System.out.println(urlBuilder.toString());
					        URL url2 = new URL(urlBuilder.toString());
					        HttpURLConnection connCrm = (HttpURLConnection) url2.openConnection();
					        connCrm.setRequestMethod("POST");
					        connCrm.setRequestProperty("Content-type", "application/json");
					        connCrm.setDoOutput(true);
					        
					        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(connCrm.getOutputStream()));
					        bw.write(jsonObj2.toString());
					        bw.flush();
					        bw.close();
					        
					        System.out.println("response2 code: " + connCrm.getResponseCode());
					        BufferedReader rd2;
					        if(connCrm.getResponseCode() >= 200 && connCrm.getResponseCode() <= 300) {
					            rd2 = new BufferedReader(new InputStreamReader(connCrm.getInputStream()));
					        } else {
					            rd2 = new BufferedReader(new InputStreamReader(connCrm.getErrorStream()));
					        }
					        StringBuilder sb = new StringBuilder();
					        String line2;
					        while ((line2 = rd2.readLine()) != null) {
					            sb.append(line2);
					        }
					        rd2.close();
					        connCrm.disconnect();
					        
						}
	
					
					} catch (Exception e) {
						e.printStackTrace();
						
					} finally {
						if(conn != null) {
							conn.disconnect();
						}
					}
					
				}

				jsonData.put("result", "ok");
			}
		}
		
		// 사용자 없음
		else {
			jsonData.put("result", "error");
			jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
		}

		return jsonData;
	}
	
	//로그아웃
	@RequestMapping(value = "/auth/logout", method = {RequestMethod.GET,RequestMethod.POST})
	public void logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		
		//PC인지 Mobile인지 확인
		boolean checkMobile = Utils.checkMobile(request);
		
		//로그인 기록
		LogionHistVo logionHistVo = new LogionHistVo();
		logionHistVo.setLoginNo(Long.toString(systemCommonGroupService.selectLoginNo()));
		logionHistVo.setUserId(request.getSession().getAttribute("userId").toString());
		logionHistVo.setIpAddress(Utils.getClientIP(request));
		logionHistVo.setGubun("Logout");
		if (checkMobile == true) {
			logionHistVo.setEtc("Mobile");
		} else {
			logionHistVo.setEtc("PC");
		}
		systemCommonGroupService.createLoginHist(logionHistVo);
		
		session.invalidate();
		Cookie cookieUserId = new Cookie("userId", null);
		cookieUserId.setMaxAge(0);
		cookieUserId.setPath("/");
		response.addCookie(cookieUserId);
		//Cookie cookieUserPw = new Cookie("userPw", null);
		//cookieUserPw.setMaxAge(0);
		//cookieUserPw.setPath("/");
		//response.addCookie(cookieUserPw);
		response.sendRedirect("/auth/login");
	}
	
	/*
	 * 메뉴 권한 불러오기 로직 20-07-01
	 */
	/*
	 * MenuInfoAdmVo menuInfoAdmVo = new MenuInfoAdmVo();
	 * 
	 * List<MenuInfoAdmVo> menuList = menuInfoAdmService.listAll(menuInfoAdmVo);
	 * session.setAttribute("menuList", menuList);
	 * 
	 * ArrayList<UserMenuAuthVo> topMenuArray = new ArrayList();
	 * ArrayList<UserMenuAuthVo> subMenuArray = new ArrayList(); ArrayList<String>
	 * arrayUpperMenuId = new ArrayList();
	 * 
	 * for(MenuAuthVo m : authList) { //서브메뉴 채우기
	 * menuInfoAdmVo.setMenuId(m.getMenuId()); menuInfoAdmVo =
	 * menuInfoAdmService.read(menuInfoAdmVo); UserMenuAuthVo userMenuAuthVo = new
	 * UserMenuAuthVo(); userMenuAuthVo.setMenuId(menuInfoAdmVo.getMenuId());
	 * userMenuAuthVo.setMenuNm(menuInfoAdmVo.getMenuNm());
	 * userMenuAuthVo.setMenuPath(menuInfoAdmVo.getMenuPath());
	 * 
	 * if(menuInfoAdmVo.getUpperMenuId() != null) {
	 * userMenuAuthVo.setMenuCheck("sub");
	 * userMenuAuthVo.setMenuUpperId(menuInfoAdmVo.getUpperMenuId());
	 * arrayUpperMenuId.add(menuInfoAdmVo.getUpperMenuId());
	 * subMenuArray.add(userMenuAuthVo); } }
	 * 
	 * TreeSet<String> distinctData =new TreeSet<String>(arrayUpperMenuId);
	 * arrayUpperMenuId = new ArrayList<String>(distinctData);
	 * 
	 * for(String m : arrayUpperMenuId) { menuInfoAdmVo.setMenuId(m); menuInfoAdmVo
	 * = menuInfoAdmService.read(menuInfoAdmVo); UserMenuAuthVo userMenuAuthVo = new
	 * UserMenuAuthVo(); userMenuAuthVo.setMenuId(menuInfoAdmVo.getMenuId());
	 * userMenuAuthVo.setMenuNm(menuInfoAdmVo.getMenuNm());
	 * userMenuAuthVo.setMenuPath(menuInfoAdmVo.getMenuPath());
	 * userMenuAuthVo.setMenuCheck("upper"); topMenuArray.add(userMenuAuthVo);
	 * 
	 * }
	 * 
	 * session.setAttribute("topMenuData",topMenuArray);
	 * session.setAttribute("subMenuData",subMenuArray);
	 * System.out.println(topMenuArray); System.out.println(subMenuArray);
	 */

}