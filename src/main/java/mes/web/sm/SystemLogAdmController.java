package mes.web.sm;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

//import com.google.gson.Gson;

import mes.domain.bm.SystemCommonGroupVo;
import mes.domain.sm.SystemLogAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.sm.SystemLogAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
import java.net.URLEncoder;
import java.io.OutputStream;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
//import java.net.URLConnection;
import java.net.HttpURLConnection;
//import javax.net.ssl.HttpsURLConnection;
//import javax.net.ssl.HostnameVerifier;
//import javax.net.ssl.HttpsURLConnection;
//import javax.net.ssl.SSLContext;
//import javax.net.ssl.SSLSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import java.io.StringReader;	

@Controller
public class SystemLogAdmController {
	
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	
	@Inject
	private SystemLogAdmService systemLogAdmService;
	
	@Value("${apiKey}") private String apiKey;
	@Value("${logGubun}") private String logGubun;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	//시스템로그관리 페이지
	@RequestMapping(value = "/smsc0060", method = RequestMethod.GET)
	public String matrlUserMain(Locale locale, Model model) throws Exception {
		logger.info("시스템로그관리 페이지");
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055");
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		return "sm/smsc0060";
	}
	
	//시스템로그관리 - 로그인기록관리 목록조회
	@RequestMapping(value="sm/systemLogAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception{
		logger.info("로그인기록관리 목록조회");
	    Map<String, Object> jsonData = new HashMap<String, Object>();
	    try {
	        List<SystemLogAdmVo> systemLogAdmList = systemLogAdmService.systemLogAdmList(systemLogAdmVo);
	        jsonData.put("data", systemLogAdmList);
	        jsonData.put("result", "ok");
	    } catch (Exception e) {
	        e.printStackTrace();
	        jsonData.put("result", "error");
	        jsonData.put("message", Utils.getErrorMessage());
	    }
	    return jsonData;
	}
	
	//시스템로그관리 - 페이지접속기록관리 목록조회
	@RequestMapping(value="sm/pageLogAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> pageLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception{
		logger.info("페이지접속기록관리 목록조회");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			List<SystemLogAdmVo> systemLogAdmList = systemLogAdmService.pageLogAdmList(systemLogAdmVo);
			jsonData.put("data", systemLogAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//시스템로그관리 - 시스템접속기록관리 로그센터 전송
	@RequestMapping(value="sm/systemLogSend", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> systemLogSend(SystemLogAdmVo systemLogAdmVo) throws Exception{
		logger.info("시스템로그 전송");
		Map<String, Object> jsonData = new HashMap<String, Object>();
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


			List<SystemLogAdmVo> systemLogAdmList = systemLogAdmService.systemLogAdmList(systemLogAdmVo);
			
			for(int i=0; i < systemLogAdmList.size(); i++) {
				systemLogAdmVo = systemLogAdmList.get(i);
				
				data = "<logData>";
				data += "<crtfcKey>"+ apiKey +"</crtfcKey>";
				data += "<logDt>" + systemLogAdmVo.getLogDate() +"</logDt>";
				data += "<useSe>" + systemLogAdmVo.getGubun() +"</useSe>";
				data += "<sysUser>" + systemLogAdmVo.getUserNm() +"</sysUser>";
				data += "<conectIp>" + systemLogAdmVo.getIpAddress() +"</conectIp>";
				data += "<dataUsgqty>" + "0" +"</dataUsgqty>";
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
		        StringBuilder response = new StringBuilder(); 
		        String line;
		        while ((line = rd.readLine()) != null) {
		          response.append(line);
		          response.append('\r');
		        }
		        rd.close();
		        is.close();
		        //return response.toString();		        


				logger.info("response = " + response.toString() );
				if(response != null || "".equals(response.toString()))	{
					t_is.setCharacterStream(new StringReader(response.toString()));
					t_doc = t_db.parse(t_is);
					t_nodes = t_doc.getElementsByTagName("recptnRsltCd");
					recptnRsltCd = t_nodes.item(0).getTextContent();
					logger.info("recptnRsltCd = " + recptnRsltCd);
				}

				if(!"AP1002".equals(recptnRsltCd))
				{
					logger.error("log interface error recptnRsltCd  = " + recptnRsltCd);
				}
				if(logGubun != "001") {
					break; // 로컬,개발 단건처리, 운영 1일 전체 연동
				}
			}
			
			/*
			String xmlData = "<Result xmlns=\"\"><recptnDt>2022-10-01 22:57:38.609</recptnDt><recptnRsltCd>AP1002</recptnRsltCd><recptnRslt>데이터 이관 완료</recptnRslt><recptnRsltDtl></recptnRsltDtl></Result>\r\n";
			t_is.setCharacterStream(new StringReader(xmlData));
			t_doc = t_db.parse(t_is);
			t_nodes = t_doc.getElementsByTagName("recptnRsltCd");
			logger.info("recptnRsltCd = " + t_nodes.item(0).getTextContent());		
			//SystemLogAdmVo ssystemLogAdmVo = gson.fromJson(redisStringData, SystemLogAdmVo.class);
			*/
			jsonData.put("data", "");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		} finally {
			if(conn != null) {
				conn.disconnect();
			}
		}		
		
		return jsonData;
	}	
}
