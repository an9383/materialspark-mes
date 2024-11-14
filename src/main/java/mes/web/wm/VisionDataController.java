package mes.web.wm;

import java.time.LocalTime;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.TimeUnit;

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

import com.google.gson.Gson;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.wm.VisionDataVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.po.WorkOrderService;
import mes.service.wm.VisionDataService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Controller
public class VisionDataController {

	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private VisionDataService visionDataService;
	
	
	@Value("${factoryCode}") private String factoryCode;
	@Value("${visionRedisIp}") private String visionRedisIp;
	private static final Logger logger = LoggerFactory.getLogger(VisionDataController.class);

	//비전데이터 조회 화면 메인
	@RequestMapping(value = "/wmsc0170", method = RequestMethod.GET)
	public String wmsc0170(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("비전데이터 조회 화면 메인");
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		

		
		return "wm/wmsc0170";
	}
	
	//비전데이터 조회 집계 화면 메인
	@RequestMapping(value = "/wmsc0180", method = RequestMethod.GET)
	public String wmsc0180(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("비전데이터 조회 집계 화면 메인");
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		

		
		return "wm/wmsc0180";
	}
	
	//비전데이터 비교 조회 집계 화면 메인
	@RequestMapping(value = "/wmsc0240", method = RequestMethod.GET)
	public String wmsc0240(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("비전데이터 조회 집계 화면 메인");
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		

		
		return "wm/wmsc0240";
	}
	
	//비전데이터 가져오기
	@RequestMapping(value = "/wm/visionDataListGet", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> visionDataListGet(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비전데이터 가져오기 = " + workOrderVo);
		try {
			
			
		
			String workOrdNo		= workOrderVo.getWorkOrdNo();
			String equipNm			= workOrderVo.getEquipNm();
			String redisAgtData 	= "empty";
			String redisAgtDataConfirm 	= "empty";
			String[] redisAgtDataConfirmArray;
			VisionDataVo visionDataVo = new VisionDataVo(); 					
			
			JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();				
			JedisPool pool = new JedisPool(jedisPoolConfig, visionRedisIp, 6379, 1000);
			Jedis jedis = pool.getResource();			
			jedis.select(0); //DB 선택
			
			
			jedis.set(equipNm + "_GET", "S,"+ DateUtil.getToday("yyyymmddHHmmss") + "," + workOrdNo + ",O," + equipNm);
			TimeUnit.SECONDS.sleep(3);
			redisAgtDataConfirm = jedis.get(equipNm + "_GET");
			redisAgtDataConfirmArray = redisAgtDataConfirm.split(",");
			
			String[] answer;	
			Gson gson = new Gson();
			redisAgtData = jedis.get(equipNm + "_SET");
			
			LocalTime now = LocalTime.now();
			int hour = now.getHour();
			
			if (redisAgtData == null || redisAgtData.equals("empty")) {
				jsonData.put("result", "fail");
				jsonData.put("message", equipNm + "의 측정값이 없습니다.");
			} else {
				if(redisAgtDataConfirmArray[0].equals("E")) {
					visionDataVo = gson.fromJson(redisAgtData, VisionDataVo.class);	//jsonString형식을 Vo에 맞게 변환					
					answer = visionDataVo.getDataSetCloseVal();
					if(answer[0].equals(redisAgtDataConfirmArray[1])) {
						
						workOrderVo = workOrderService.read(workOrderVo);
						
						visionDataVo.setCloseTime(answer[0]);
						visionDataVo.setWorkOrdNo(answer[1]);
						visionDataVo.setFairCnt(answer[2]);
						
					
						String today = DateUtil.getToday("yyyymmdd");
						int hourDate = Integer.parseInt(today.substring(today.length()-2,today.length()));
						if(hour >= 0 && hour < 7) {
							hourDate--;
						}
						String dayNight = "N";
						//주야구분
						if(hour >= 7 && hour < 19) {
							dayNight = "D";
						}
						String thisDay = today.substring(0,today.length()-2);
						visionDataVo.setInsertDate(thisDay + String.format("%02d", hourDate));
						visionDataVo.setWorkChargr(workOrderVo.getWorkerId());
						visionDataVo.setDayNightGubun(dayNight);
						visionDataVo.setEquipCd(workOrderVo.getEquipCd());
						visionDataVo.setVisionGubun("001");
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
						visionDataVo.setRegId(Utils.getUserId());
						
						visionDataService.create(visionDataVo);
						
						jsonData.put("result", "ok");	
						
					} else {
						jsonData.put("message", "오류가 발생했습니다.");
						jsonData.put("result", "fail");			 
					}

				} else {
					jsonData.put("message", "오류가 발생했습니다.");
					jsonData.put("result", "fail");			 
				}
				
				
				
			}

			logger.info("workOrdNo ---->zzzzzzzzzzzzz "+ redisAgtData);
			if (jedis != null) {
				jedis.close();
			}
			pool.close();

		} catch (Exception e) {
			logger.info("비전데이터 가져오기 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//비전데이터 목록 조회
	@RequestMapping(value = "/wm/visionDataAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionDataAdmList(VisionDataVo visionDataVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비전데이터 목록 조회");
	
		try {
			List<VisionDataVo> list = visionDataService.list(visionDataVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비전데이터 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//MES비전데이터 목록 조회
	@RequestMapping(value = "/wm/mesVisionDataAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> mesVisionDataAdmList(VisionDataVo visionDataVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("MES비전데이터 목록 조회");
	
		try {
			List<VisionDataVo> list = visionDataService.mesVisionDataRead(visionDataVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("MES비전데이터 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//비전데이터 목록 기간별 집계 조회
	@RequestMapping(value = "/wm/visionDataAdmListTotal", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionDataAdmListTotal(VisionDataVo visionDataVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비전데이터 목록 기간별 집계 조회");
	
		try {
			List<VisionDataVo> list = visionDataService.listTotal(visionDataVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비전데이터 목록 기간별 집계 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//비전데이터 목록 LOT별 집계 조회
	@RequestMapping(value = "/wm/visionDataAdmListLot", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionDataAdmListLot(VisionDataVo visionDataVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비전데이터 목록 Lot별 집계 조회");
	
		try {
			List<VisionDataVo> list = visionDataService.listLot(visionDataVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비전데이터 목록 Lot별 집계 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	

	//비전데이터 목록 일자별 집계 조회
	@RequestMapping(value = "/wm/visionDataAdmListDay", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> visionDataAdmListDay(VisionDataVo visionDataVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비전데이터 목록 일자별 집계 조회");
	
		try {
			List<VisionDataVo> list = visionDataService.listDay(visionDataVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비전데이터 목록 일자별 집계 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	

}

