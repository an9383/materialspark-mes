package mes.web.bt;

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
import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.inject.Inject;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.google.gson.Gson;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.sm.SystemLogAdmVo;
import mes.domain.wm.VisionDataVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.sm.SystemLogAdmService;
import mes.service.wm.VisionDataService;
import mes.web.ut.DateUtil;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Configuration
@PropertySource("classpath:/config.properties")
public class BatchProcController {

	@Inject
	private VisionDataService visionDataService;	
	
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	
	@Inject
	private SystemLogAdmService systemLogAdmService;
	
	@Value("${visionRedisIp}") private String visionRedisIp;
	@Value("${factoryCode}") private String factoryCode;
	@Value("${apiKey}") private String apiKey;
	
	private static final Logger logger = LoggerFactory.getLogger(BatchProcController.class);

	//영업관리 메인
	//@RequestMapping(value = "/bssc0010", method = RequestMethod.GET)
	//@RequestMapping(value = "/wm/visionDataListGetBatch", method = RequestMethod.POST)
	//비전데이터 가져오기 배치용
	//@Scheduled(cron="0 49 10 ? * *")	
	//야간 데이터
	public void visionDataListGetBatch() throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		try {		
			if(!factoryCode.equals("003")) { //3공장이 아닐경우만
				
			
			
				logger.info("비전데이터 가져오기 ");
				logger.info("batchScheduler batchTmData ==================> " + DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
				logger.info("batchScheduler visionRedisIp ==================> " + visionRedisIp);
				
				
				String thisDate = DateUtil.getToday("yyyymmddHHmmss");
				thisDate = thisDate.substring(0, thisDate.length()-2);
				thisDate += "00";
				logger.info("batchScheduler batchTmData ==================>**************** " + thisDate);
				String redisAgtData 	= "empty";
				VisionDataVo visionDataVo = new VisionDataVo(); 			
				//List<VisionDataVo> workOrdList = visionDataService.visionDataSet(visionDataVo);
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				List<EquipCodeAdmVo> EquipCodeAdmList = equipCodeAdmService.visionDataListAll(equipCodeAdmVo);
				
				
				
				String redisAgtDataConfirm 	= "empty";
				String[] redisAgtDataConfirmArray;
				JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();				
				//JedisPool pool = new JedisPool(jedisPoolConfig, "192.168.232.106", 6379, 1000);		
				JedisPool pool = new JedisPool(jedisPoolConfig, visionRedisIp, 6379, 1000);
				Jedis jedis = pool.getResource();			
				jedis.select(0); //DB 선택
				for(EquipCodeAdmVo m : EquipCodeAdmList) {
					jedis.set(m.getEquipNm() + "_GET", "S,"+ thisDate + "," + m.getWorkOrdNo() + ",O," + m.getEquipNm());	
				}
				TimeUnit.SECONDS.sleep(3);
				
				
				LocalTime now = LocalTime.now();
				int hour = now.getHour();
				for(EquipCodeAdmVo m : EquipCodeAdmList) {
					//jedis.set(m.getEquipNm() + "_GET", "S,"+ DateUtil.getToday("yyyymmddHHmmss") + "," + m.getWorkOrdNo() + ",O," + m.getEquipNm());	
					redisAgtDataConfirm = jedis.get(m.getEquipNm() + "_GET");
					redisAgtDataConfirmArray = redisAgtDataConfirm.split(",");
					redisAgtData= jedis.get(m.getEquipNm() + "_SET");
					String[] answer;
					Gson gson = new Gson();
				
					
					if (redisAgtData == null || redisAgtData.equals("empty")) {
						visionDataVo = new VisionDataVo(); 
						logger.info("batchScheduler batchTmData 빈값  :  ");
						visionDataVo.setCloseTime(thisDate);
						visionDataVo.setWorkOrdNo(m.getWorkOrdNo());
						visionDataVo.setFairCnt("0");
						
						String today = DateUtil.getToday("yyyymmdd");
						int hourDate = Integer.parseInt(today.substring(today.length()-2,today.length()));						
						hourDate--;						
						String thisDay = today.substring(0,today.length()-2);
						visionDataVo.setInsertDate(thisDay + String.format("%02d", hourDate));
						
						visionDataVo.setDayNightGubun("N");				
						//visionDataVo.setInsertDate( DateUtil.getToday("yyyymmdd"));
						//visionDataVo.setWorkChargr(m.getWorkerId());
						visionDataVo.setWorkChargr(m.getWorkerId());
						visionDataVo.setEquipCd(m.getEquipCd());
						visionDataVo.setVisionGubun("002");
						visionDataVo.setReserved1("0");
						visionDataVo.setReserved2("0");
						visionDataVo.setReserved3("0");
						visionDataVo.setReserved4("0");
						visionDataVo.setReserved5("0");
						visionDataVo.setReserved6("0");
						visionDataVo.setReserved7("0");
						visionDataVo.setReserved8("0");
						visionDataVo.setReserved9("0");
						visionDataVo.setReserved10("0");
						visionDataVo.setReserved11("0");
						visionDataVo.setReserved12("0");
						visionDataVo.setReserved13("0");
						visionDataVo.setReserved14("0");
						visionDataVo.setReserved15("0");
						visionDataVo.setReserved16("0");
						visionDataVo.setReserved17("0");
						visionDataVo.setReserved18("0");
						visionDataVo.setReserved19("0");
						visionDataVo.setReserved20("0");
						visionDataVo.setReserved21("0");
						visionDataVo.setReserved22("0");
						visionDataVo.setReserved23("0");
						visionDataVo.setReserved24("0");
						visionDataVo.setReserved25("0");
						visionDataVo.setReserved26("0");
						visionDataVo.setReserved27("0");
						visionDataVo.setReserved28("0");
						visionDataVo.setReserved29("0");
						visionDataVo.setReserved30("0");
						visionDataVo.setReserved31("0");
						visionDataVo.setReserved32("0");
						visionDataVo.setReserved33("0");
						visionDataVo.setReserved34("0");
						visionDataVo.setReserved35("0");
						visionDataVo.setReserved36("0");
						visionDataVo.setReserved37("0");
						visionDataVo.setRegId("vision");
						visionDataService.create(visionDataVo);
						
					} else {
						if(redisAgtDataConfirmArray[0].equals("E")) {
							visionDataVo = new VisionDataVo(); 
							visionDataVo = gson.fromJson(redisAgtData, VisionDataVo.class);	//jsonString형식을 Vo에 맞게 변환					
							answer = visionDataVo.getDataSetCloseVal();
						
							if(answer[0].equals(redisAgtDataConfirmArray[1])) {
								visionDataVo.setCloseTime(answer[0]);
								visionDataVo.setWorkOrdNo(answer[1]);
								visionDataVo.setFairCnt(answer[2]);
								
								String today = DateUtil.getToday("yyyymmdd");
								int hourDate = Integer.parseInt(today.substring(today.length()-2,today.length()));						
								hourDate--;						
								String thisDay = today.substring(0,today.length()-2);
								
								visionDataVo.setDayNightGubun("N");				
								//visionDataVo.setInsertDate( DateUtil.getToday("yyyymmdd"));
								visionDataVo.setInsertDate(thisDay + String.format("%02d", hourDate));
								//visionDataVo.setWorkChargr(m.getWorkerId());
								visionDataVo.setWorkChargr(m.getWorkerId());
								visionDataVo.setEquipCd(m.getEquipCd());
								visionDataVo.setVisionGubun("002");
								visionDataVo.setReserved1(answer[3]);
								visionDataVo.setReserved2(answer[4]);
								visionDataVo.setReserved3(answer[5]);
								visionDataVo.setReserved4(answer[6]);
								visionDataVo.setReserved5(answer[7]);
								visionDataVo.setReserved6(answer[8]);
								visionDataVo.setReserved7(answer[9]);
								visionDataVo.setReserved8(answer[10]);
								visionDataVo.setReserved9(answer[11]);
								visionDataVo.setReserved10(answer[12]);
								visionDataVo.setReserved11(answer[13]);
								visionDataVo.setReserved12(answer[14]);
								visionDataVo.setReserved13(answer[15]);
								visionDataVo.setReserved14(answer[16]);
								visionDataVo.setReserved15(answer[17]);
								visionDataVo.setReserved16(answer[18]);
								visionDataVo.setReserved17(answer[19]);
								visionDataVo.setReserved18(answer[20]);
								visionDataVo.setReserved19(answer[21]);
								visionDataVo.setReserved20(answer[22]);
								visionDataVo.setReserved21(answer[23]);
								visionDataVo.setReserved22(answer[24]);
								visionDataVo.setReserved23(answer[25]);
								visionDataVo.setReserved24(answer[26]);
								visionDataVo.setReserved25(answer[27]);
								visionDataVo.setReserved26(answer[28]);
								visionDataVo.setReserved27(answer[29]);
								visionDataVo.setReserved28(answer[30]);
								visionDataVo.setReserved29(answer[31]);
								visionDataVo.setReserved30(answer[32]);
								visionDataVo.setReserved31(answer[33]);
								visionDataVo.setReserved32(answer[34]);
								visionDataVo.setReserved33(answer[35]);
								visionDataVo.setReserved34(answer[36]);
								visionDataVo.setReserved35(answer[37]);
								visionDataVo.setReserved36(answer[38]);
								visionDataVo.setReserved37(answer[39]);
								visionDataVo.setRegId("vision");
								
								visionDataService.create(visionDataVo);
							} else {
								jsonData.put("message", "오류가 발생했습니다.");
								jsonData.put("result", "fail");			 
							}
							 
						} else {
							jsonData.put("message", "오류가 발생했습니다.");
							jsonData.put("result", "fail");			 
						}
	
					}
	
				}			
				
				
				if (jedis != null) {
					jedis.close();
				}
				pool.close();
				jsonData.put("result", "ok");	
					
			
			}
		} catch (Exception e) {
			logger.info("비전데이터 가져오기 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
	
	}
	
	//주간 데이터
		public void visionDataListGetBatchNight() throws Exception {
				Map<String, Object> jsonData = new HashMap<String, Object>();
				
				try {		
					if(!factoryCode.equals("003")) { //3공장이 아닐경우만
					logger.info("비전데이터 가져오기 ");
					logger.info("batchScheduler batchTmData ==================> " + DateUtil.getDay("yyyy-mm-dd hh:mm:ss:ms", 0));
					logger.info("batchScheduler visionRedisIp ==================> " + visionRedisIp);
					String thisDate = DateUtil.getToday("yyyymmddHHmmss");
					thisDate = thisDate.substring(0, thisDate.length()-2);
					thisDate += "00";
					
					String redisAgtData 	= "empty";
					VisionDataVo visionDataVo = new VisionDataVo(); 			
					///List<VisionDataVo> workOrdList = visionDataService.visionDataSet(visionDataVo);	
					EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
					List<EquipCodeAdmVo> EquipCodeAdmList = equipCodeAdmService.visionDataListAll(equipCodeAdmVo);
					String redisAgtDataConfirm 	= "empty";
					String[] redisAgtDataConfirmArray;
					JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();				
					//JedisPool pool = new JedisPool(jedisPoolConfig, "192.168.232.106", 6379, 1000);
					JedisPool pool = new JedisPool(jedisPoolConfig, visionRedisIp, 6379, 1000);
					Jedis jedis = pool.getResource();			
					jedis.select(0); //DB 선택
					for(EquipCodeAdmVo m : EquipCodeAdmList) {
						jedis.set(m.getEquipNm() + "_GET", "S,"+ thisDate + "," + m.getWorkOrdNo() + ",O," + m.getEquipNm());	
					}
					TimeUnit.SECONDS.sleep(3);
					for(EquipCodeAdmVo m : EquipCodeAdmList) {
						//jedis.set(m.getEquipNm() + "_GET", "S,"+ DateUtil.getToday("yyyymmddHHmmss") + "," + m.getWorkOrdNo() + ",O," + m.getEquipNm());	
						redisAgtDataConfirm = jedis.get(m.getEquipNm() + "_GET");
						redisAgtDataConfirmArray = redisAgtDataConfirm.split(",");
						redisAgtData= jedis.get(m.getEquipNm() + "_SET");	
						String[] answer;
						Gson gson = new Gson();
	
						if (redisAgtData == null || redisAgtData.equals("empty")) {
							visionDataVo = new VisionDataVo(); 
							logger.info("batchScheduler batchTmData 빈값  :  ");
							visionDataVo.setCloseTime(thisDate);
							visionDataVo.setWorkOrdNo(m.getWorkOrdNo());
							visionDataVo.setFairCnt("0");
							
							visionDataVo.setDayNightGubun("D");				
							visionDataVo.setInsertDate( DateUtil.getToday("yyyymmdd"));
							//visionDataVo.setWorkChargr(m.getWorkerId());
							visionDataVo.setWorkChargr(m.getWorkerId());
							visionDataVo.setEquipCd(m.getEquipCd());
							visionDataVo.setVisionGubun("002");
							visionDataVo.setReserved1("0");
							visionDataVo.setReserved2("0");
							visionDataVo.setReserved3("0");
							visionDataVo.setReserved4("0");
							visionDataVo.setReserved5("0");
							visionDataVo.setReserved6("0");
							visionDataVo.setReserved7("0");
							visionDataVo.setReserved8("0");
							visionDataVo.setReserved9("0");
							visionDataVo.setReserved10("0");
							visionDataVo.setReserved11("0");
							visionDataVo.setReserved12("0");
							visionDataVo.setReserved13("0");
							visionDataVo.setReserved14("0");
							visionDataVo.setReserved15("0");
							visionDataVo.setReserved16("0");
							visionDataVo.setReserved17("0");
							visionDataVo.setReserved18("0");
							visionDataVo.setReserved19("0");
							visionDataVo.setReserved20("0");
							visionDataVo.setReserved21("0");
							visionDataVo.setReserved22("0");
							visionDataVo.setReserved23("0");
							visionDataVo.setReserved24("0");
							visionDataVo.setReserved25("0");
							visionDataVo.setReserved26("0");
							visionDataVo.setReserved27("0");
							visionDataVo.setReserved28("0");
							visionDataVo.setReserved29("0");
							visionDataVo.setReserved30("0");
							visionDataVo.setReserved31("0");
							visionDataVo.setReserved32("0");
							visionDataVo.setReserved33("0");
							visionDataVo.setReserved34("0");
							visionDataVo.setReserved35("0");
							visionDataVo.setReserved36("0");
							visionDataVo.setReserved37("0");
							visionDataVo.setRegId("vision");
							visionDataService.create(visionDataVo);
						} else {
							if(redisAgtDataConfirmArray[0].equals("E")) {
								visionDataVo = gson.fromJson(redisAgtData, VisionDataVo.class);	//jsonString형식을 Vo에 맞게 변환					
								answer = visionDataVo.getDataSetCloseVal();
								if(answer[0].equals(redisAgtDataConfirmArray[1])) {
									visionDataVo.setCloseTime(answer[0]);
									visionDataVo.setWorkOrdNo(answer[1]);
									visionDataVo.setFairCnt(answer[2]);
									visionDataVo.setVisionGubun("002");
									visionDataVo.setDayNightGubun("D");				
									visionDataVo.setInsertDate( DateUtil.getToday("yyyymmdd"));
									//visionDataVo.setWorkChargr(m.getWorkerId());
									visionDataVo.setWorkChargr(m.getWorkerId());
									visionDataVo.setEquipCd(m.getEquipCd());
									
									visionDataVo.setReserved1(answer[3]);
									visionDataVo.setReserved2(answer[4]);
									visionDataVo.setReserved3(answer[5]);
									visionDataVo.setReserved4(answer[6]);
									visionDataVo.setReserved5(answer[7]);
									visionDataVo.setReserved6(answer[8]);
									visionDataVo.setReserved7(answer[9]);
									visionDataVo.setReserved8(answer[10]);
									visionDataVo.setReserved9(answer[11]);
									visionDataVo.setReserved10(answer[12]);
									visionDataVo.setReserved11(answer[13]);
									visionDataVo.setReserved12(answer[14]);
									visionDataVo.setReserved13(answer[15]);
									visionDataVo.setReserved14(answer[16]);
									visionDataVo.setReserved15(answer[17]);
									visionDataVo.setReserved16(answer[18]);
									visionDataVo.setReserved17(answer[19]);
									visionDataVo.setReserved18(answer[20]);
									visionDataVo.setReserved19(answer[21]);
									visionDataVo.setReserved20(answer[22]);
									visionDataVo.setReserved21(answer[23]);
									visionDataVo.setReserved22(answer[24]);
									visionDataVo.setReserved23(answer[25]);
									visionDataVo.setReserved24(answer[26]);
									visionDataVo.setReserved25(answer[27]);
									visionDataVo.setReserved26(answer[28]);
									visionDataVo.setReserved27(answer[29]);
									visionDataVo.setReserved28(answer[30]);
									visionDataVo.setReserved29(answer[31]);
									visionDataVo.setReserved30(answer[32]);
									visionDataVo.setReserved31(answer[33]);
									visionDataVo.setReserved32(answer[34]);
									visionDataVo.setReserved33(answer[35]);
									visionDataVo.setReserved34(answer[36]);
									visionDataVo.setReserved35(answer[37]);
									visionDataVo.setReserved36(answer[38]);
									visionDataVo.setReserved37(answer[39]);
									visionDataVo.setRegId("vision");
						
									
									visionDataService.create(visionDataVo);
								} else {
									jsonData.put("message", "오류가 발생했습니다.");
									jsonData.put("result", "fail");			 
								}
								 
							} else {
								jsonData.put("message", "오류가 발생했습니다.");
								jsonData.put("result", "fail");			 
							}
	
						}
	
					}			
					
					
					if (jedis != null) {
						jedis.close();
					}
					pool.close();
					jsonData.put("result", "ok");	
						
				
				}
			} catch (Exception e) {
				logger.info("비전데이터 가져오기 오류");
				e.printStackTrace();
				jsonData.put("message", "오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
			}
		
		}
		
		//시스템로그관리 - 시스템접속기록관리 로그센터 전송
		public void systemLogSendBatch1Factory() throws Exception{
			logger.info("시스템로그 전송");
			
			SystemLogAdmVo systemLogAdmVo = new SystemLogAdmVo();
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
				
				String answer = "";
				
				systemLogAdmVo.setChooseDate1(DateUtil.getCurrentYyyymmdd());
				systemLogAdmVo.setChooseDate2(DateUtil.getCurrentYyyymmdd());
				System.out.println(DateUtil.getCurrentYyyymmdd());
				List<SystemLogAdmVo> systemLogAdmList = systemLogAdmService.systemLogAdmList(systemLogAdmVo);
				int count = systemLogAdmList.size();
				if(systemLogAdmList == null) {
					count = 0;
				}
				
				
				
				
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
				        URL url2 = new URL(urlBuilder.toString());
				        HttpURLConnection connCrm = (HttpURLConnection) url2.openConnection();
				        connCrm.setRequestMethod("POST");
				        connCrm.setRequestProperty("Content-type", "application/json");
				        connCrm.setDoOutput(true);
				        
				        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(connCrm.getOutputStream()));
				        bw.write(jsonObj2.toString());
				        bw.flush();
				        bw.close();
				        
				        System.out.println("Response code: " + connCrm.getResponseCode());
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
						
					
					
				}
				
				
			
		        
			
			
			} catch (Exception e) {
				e.printStackTrace();
				
			} finally {
				if(conn != null) {
					conn.disconnect();
				}
			}		
			
		
		}	
		

}
