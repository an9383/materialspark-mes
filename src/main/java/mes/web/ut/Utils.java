package mes.web.ut;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class Utils {

	private static String userId;
	private static String userNm;
	private static String userNumber;
	private static String userDepartmentCd;
	private static String userDepartmentNm;
	private static String systemErrorMessage = "시스템 오류가 발생했습니다.";

	public static String getUserDepartmentCd() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserDepartmentCd = request.getSession().getAttribute("userDepartmentCd").toString();
		return sessionUserDepartmentCd;
	}

	public static void setUserDepartmentCd(String userDepartmentCd) {
		Utils.userDepartmentCd = userDepartmentCd;
	}

	public static String getUserDepartmentNm() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserDepartmentNm = request.getSession().getAttribute("userDepartmentNm").toString();
		return sessionUserDepartmentNm;
	}

	public static void setUserDepartmentNm(String userDepartmentNm) {
		Utils.userDepartmentNm = userDepartmentNm;
	}

	public static String getUserId() {
		//if(userId == null || "".equals(userId)) {
		//   userId = "regId";
		//}
		//return userId;
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserId = request.getSession().getAttribute("userId").toString();
		if (sessionUserId == null || "".equals(sessionUserId)) {
			sessionUserId = "regId";
		}
		return sessionUserId;
	}

	public static void setUserId(String uid) {
		userId = uid;
	}

	public static String getUserNm() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserNm = request.getSession().getAttribute("userNm").toString();
		if (sessionUserNm == null || "".equals(sessionUserNm)) {
			sessionUserNm = "관리자";
		}
		return sessionUserNm;
	}

	public static void setUserNm(String uNm) {
		userNm = uNm;
	}

	public static String getUserNumber() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String sessionUserNumber = request.getSession().getAttribute("userNumber").toString();
		if (sessionUserNumber == null || "".equals(sessionUserNumber)) {
			sessionUserNumber = "0003";
		}
		return sessionUserNumber;
	}

	public static void setUserNumber(String uNumber) {
		userNumber = uNumber;
	}

	public static Map<String, Object> getInspect(Object vo) throws Exception {
		Map<String, Object> inspectMap = new HashMap<String, Object>();
		int idx = 0;
		for (Field field : vo.getClass().getDeclaredFields()) {
			field.setAccessible(true);
			//Object value = field.get(vo);
			if (field.get(vo) != null) {
				String value2[] = field.get(vo).toString().split("/");
				List<String> realV = new ArrayList<>();
				for (int i = 0; i < value2.length; i++) {
					if (value2[i] == null || value2[i] == "") {
						value2[i] = "";
					}
					realV.add(value2[i].replace("%2f", "/"));
				}
				inspectMap.put(Integer.toString(idx), realV);
				idx++;
			}
		}

		return inspectMap;
	}

	public static String getBoxNo(String modelNo, String workDt) {
		String boxNo = "";
		String yearStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String monthStr = "123456789ABC";

		modelNo = modelNo.replace("-", "");
		int workYearIdx = Integer.parseInt(workDt.substring(2, 4)) - 20;
		if (workYearIdx < 0)
			workYearIdx = 0;
		String cWorkYear = yearStr.substring(workYearIdx, workYearIdx + 1);
		int workMonthIdx = Integer.parseInt(workDt.substring(4, 6));
		if (workMonthIdx < 0)
			workYearIdx = 1;
		String cWorkMonth = monthStr.substring(workMonthIdx - 1, workMonthIdx);
		String sDay = workDt.substring(6, 8);

		boxNo = modelNo + cWorkYear + cWorkMonth + sDay;

		return boxNo;
	}

	public static String nullToString(String str) {

		if (str == null) {
			return "";
		}

		return str;
	}

	public static String getErrorMessage() {
		return systemErrorMessage;
	}

	public static String convert2UnderscoreCase(String camelStr) {

		String regex = "([a-z])([A-Z]+)";
		String replacement = "$1_$2";
		return camelStr.replaceAll(regex, replacement).toUpperCase();
	}
	
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		//logger.info("> X-FORWARDED-FOR : " + ip);

		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
			//logger.info("> Proxy-Client-IP : " + ip);
		}
		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");
			//logger.info(">  WL-Proxy-Client-IP : " + ip);
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
			//logger.info("> HTTP_CLIENT_IP : " + ip);
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			//logger.info("> HTTP_X_FORWARDED_FOR : " + ip);
		}
		if (ip == null) {
			ip = request.getRemoteAddr();
			//logger.info("> getRemoteAddr : "+ip);
		}
		//logger.info("> Result : IP Address : "+ip);
		return ip;
	}
	
	public static boolean checkMobile(HttpServletRequest request) {
		boolean checkMobile = false;
		request.getSession().setAttribute("isMobile", "web");
		String userAgent = request.getHeader("user-agent");
		String[] browser = {"iPhone", "iPod","Android"};
		for (int i = 0; i < browser.length; i++) {
		    if(userAgent.matches(".*"+browser[i]+".*")) {
		    	request.getSession().setAttribute("isMobile", "mobile");
		    	checkMobile = true;
		    	break;
		    }
		}
		
		return checkMobile;
	}

	//문자열 자르기 왼쪽
	public static String left(String str, int length) {
		String leftStr = null;
		if (str.length() < length) {
			length = str.length();
		}

		leftStr = str.substring(0, length);

		return leftStr;
	}

	//문자열 자르기 오른쪽
	public static String right(String str, int length) {
		String rightStr = null;
		if (str.length() < length) {
			length = str.length();
		}
		rightStr = str.substring(str.length() - length);
		return rightStr;
	}

}