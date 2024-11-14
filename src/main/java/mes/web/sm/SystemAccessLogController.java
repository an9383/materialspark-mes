package mes.web.sm;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bt.BatchProcVo;
import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.SystemAccessLogVo;
import mes.service.bt.BatchProcService;
import mes.service.sm.SystemAccessLogService;
import mes.web.cm.Constants;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class SystemAccessLogController {

	@Inject
	private SystemAccessLogService systemAccessLogService;
	@Inject
	private BatchProcService batchProcService;	
	
	private static final Logger logger = LoggerFactory.getLogger(SystemAccessLogController.class);
	
	//로그기록관리 메인
	@RequestMapping(value = "/smsc0040", method = RequestMethod.GET)
	public String matrlUserMain(Model model) throws Exception {
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));		
			
		return "sm/smsc0040";
	
	}
	
	//로그이력관리 메인
	@RequestMapping(value = "/smsc0080", method = RequestMethod.GET)
	public String matrlUserLogMain(Model model) throws Exception {
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));		
			
		return "sm/smsc0080";
	
	}
		
	//로그 사용자 목록조회
	@RequestMapping(value = "/sm/systemAccessLogList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdDataList(SystemAccessLogVo systemAccessLogVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("사용자 목록조회");
		
		try {
			List<SystemAccessLogVo> matrlUserData = systemAccessLogService.smlistAll(systemAccessLogVo);
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
	
	//로그이력관리 목록조회
	@RequestMapping(value = "/sm/systemChangeLogList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemChangeLogList(SystemAccessLogVo systemAccessLogVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("로그이력관리 목록조회");
		try {
			List<SystemAccessLogVo> matrlUserData = systemAccessLogService.systemChangeLogList(systemAccessLogVo);
			jsonData.put("data", matrlUserData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("로그이력관리 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	// 로그이력관리 등록
	@RequestMapping(value = "/sm/systemChangeLogCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> systemChangeLogCreate(HttpServletRequest request, SystemAccessLogVo systemAccessLogVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("로그이력관리 등록");
		try {
//			String requestURI = request.getRequestURI();
			HttpSession session = request.getSession(true);
			MatrlUserVo userVo = (MatrlUserVo)session.getAttribute(Constants.USER_SESSION_VO);
//			String menuUrl = requestURI.substring(requestURI.length()-8, requestURI.length());
			
			systemAccessLogVo.setUserNumber(userVo.getUserNumber().toString());
			systemAccessLogVo.setUserId(userVo.getUserId().toString()); 
			systemAccessLogVo.setUserNm(userVo.getUserNm().toString()); 
			systemAccessLogVo.setDepartmentCd(userVo.getDepartmentCd().toString());	
//			systemAccessLogVo.setMenuPath(menuUrl);
			systemAccessLogVo.setRegId(Utils.getUserId());
			
			systemAccessLogService.systemChangeLogCreate(systemAccessLogVo);
			
			jsonData.put("data", systemAccessLogVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("로그이력관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//시스템로그관리 - 시스템접속기록관리 로그센터 전송
	@RequestMapping(value="sm/systemLogSend", method = RequestMethod.POST)
	public void systemLogSend(SystemAccessLogVo systemAccessLogVo) throws Exception{
		try {
			int count = 0;
			
			SystemAccessLogVo systemAccessVo = new SystemAccessLogVo();
			systemAccessVo.setStartDate(DateUtil.getCurrentYyyymmdd());
			systemAccessVo.setLastDate(DateUtil.getCurrentYyyymmdd());
			List<SystemAccessLogVo> systemLogAdmList = systemAccessLogService.smlistAll(systemAccessVo);
			
			count = systemLogAdmList.size();
			for(int i=0;i<systemLogAdmList.size();i++) {
				// 전송할 데이터 생성
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("crtfcKey", "$5$API$/V.NXKzTzJ2WfOhWuu3VRv5uPj3iGsMEMnzXv/IL.r6"); // api 인증키
				jsonObj.put("logDt", systemLogAdmList.get(i).getRegDate()); // 로그일시
				jsonObj.put("useSe", "접속"); // 접속구분
				jsonObj.put("sysUser", systemLogAdmList.get(i).getUserId()); // 사용자
				jsonObj.put("conectIp", systemLogAdmList.get(i).getIpAddr()); // IP정보
				jsonObj.put("dataUsgqty", 0); // 데이터사용량(숫자)
				
				// 데이터 전송
				StringBuilder urlBuilder = new StringBuilder("https://log.smart-factory.kr/apisvc/sendLogDataJSON.do"); /*URL*/
		        urlBuilder.append("?" + URLEncoder.encode("logData","UTF-8") + "=" + URLEncoder.encode(jsonObj.toJSONString(), "UTF-8"));
		        URL url = new URL(urlBuilder.toString());
		        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		        conn.setRequestMethod("POST");
		        conn.setRequestProperty("Content-type", "application/json");
		        System.out.println("Response code: " + conn.getResponseCode());
		        BufferedReader rd;
		        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
		            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		        } else {
		            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		        }
		        StringBuilder sb = new StringBuilder();
		        String line;
		        while ((line = rd.readLine()) != null) {
		            sb.append(line);
		        }
		        rd.close();
		        conn.disconnect();
		        System.out.println(sb.toString());
			}
			
			
			// 전송할 데이터 생성
			JSONObject jsonObj2 = new JSONObject();
			jsonObj2.put("dealCorpIdx",7); // 고객사 식별자
			jsonObj2.put("sendDate", DateUtil.getCurrentYyyymmdd()); // 전송일자
			jsonObj2.put("sendQty", count); // 총 접속건수
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
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Content-type", "application/json");
	        conn.setDoOutput(true);
	        
	        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        bw.write(jsonObj2.toString());
	        bw.flush();
	        bw.close();
	        
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	        
	        BatchProcVo batchProcVo = new BatchProcVo();
			batchProcVo.setBatchId(Constants.BATCH_ID_02);
			batchProcVo.setBatchNm(Constants.BATCH_ID_02_NM);
			batchProcVo.setBatchGubun(Constants.BATCH_ID_02_NM);
			batchProcVo.setBatchStartTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
			batchProcVo.setTmMon(DateUtil.getToday("yyyymmdd").substring(0,6));
			batchProcVo.setSuccessYn(Constants.BATCH_SUCCESS);
			batchProcVo.setBatchEndTime(DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
			batchProcService.batchProcLog(batchProcVo);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}	
	
}
