package mes.web.po;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.AgtSixFloorVo;
import mes.domain.po.AgtVo;
import mes.domain.po.RealTimeRedisBomVo;
import mes.domain.po.WorkOrderVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.po.AgtService;
import mes.service.po.WorkOrderService;
import mes.web.ut.Utils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Controller
public class AgtController {

	@Inject
	private AgtService agtService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private WorkOrderService workOrderService;
	
	@Value("${dgsRedisIP}") private String dgsRedisIP;
	@Value("${factoryCode}") private String facotryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(AgtController.class);

	//에이젼트 온도 데이터 조회
	@RequestMapping(value = "/po/agtReadTemp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtReadTemp(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 온도 데이터 조회 = " + agtVo);
		try {
			String workOrdNo = agtVo.getWorkOrdNo();
			//String ordLotNo = agtVo.getOrdLotNo();
			//String stepCd = agtVo.getStepCd();
			String lotNo = agtVo.getLotNo();
			List<AgtVo> agtList = new ArrayList<AgtVo>();
			
			//if ("001".equals(stepCd)) {
				AgtVo firstStepAgtVo = new AgtVo();
				firstStepAgtVo.setWorkOrdNo(workOrdNo);
			//	firstStepAgtVo.setOrdLotNo(ordLotNo);
				firstStepAgtVo.setStepCd("001");
				firstStepAgtVo.setLotNo(lotNo);
				if (agtService.checkTemp(firstStepAgtVo) != 0) {		//초물데이터가 있다면
					agtList.add(agtService.readTemp(firstStepAgtVo));	//데이터조회 및 목록에 추가
				}	
			//} else if ("002".equals(stepCd)) {
				AgtVo secondStepAgtVo = new AgtVo();
				secondStepAgtVo.setWorkOrdNo(workOrdNo);
			//	secondStepAgtVo.setOrdLotNo(ordLotNo);
				secondStepAgtVo.setStepCd("002");
				secondStepAgtVo.setLotNo(lotNo);
				if (agtService.checkTemp(secondStepAgtVo) != 0) {		//중물데이터가 있다면
					agtList.add(agtService.readTemp(secondStepAgtVo));	//데이터조회 및 목록에 추가
				}	
			//}// else if ("003".equals(stepCd)) {
			//	AgtVo thirdStepAgtVo = new AgtVo();
			//	thirdStepAgtVo.setWorkOrdNo(workOrdNo);
			//	thirdStepAgtVo.setOrdLotNo(ordLotNo);
			//	thirdStepAgtVo.setStepCd("003");
			//	thirdStepAgtVo.setLotNo(lotNo);
			//	if (agtService.checkTemp(thirdStepAgtVo) != 0) {		//종물데이터가 있다면
			//		agtList.add(agtService.readTemp(thirdStepAgtVo));	//데이터조회 및 목록에 추가
			//	}
			//}
			jsonData.put("data", agtList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//에이젼트 온도 데이터 조회 (23.11.16 나중에 6층 온도 사용시 추가해줘야함 테이블이 변경됨 )
		@RequestMapping(value = "/po/agtReadTemp_F3", method = RequestMethod.POST)
		public @ResponseBody Map<String, Object> agtReadTemp_F3(AgtVo agtVo) throws Exception {
			Map<String, Object> jsonData = new HashMap<String, Object>();
			logger.info("에이젼트 온도 데이터 조회 = " + agtVo);
			try {
				String workOrdNo = agtVo.getWorkOrdNo();
				//String ordLotNo = agtVo.getOrdLotNo();
				//String stepCd = agtVo.getStepCd();
				String lotNo = agtVo.getLotNo();
				List<AgtVo> agtList = new ArrayList<AgtVo>();
				
				//if ("001".equals(stepCd)) {
					AgtVo firstStepAgtVo = new AgtVo();
					firstStepAgtVo.setWorkOrdNo(workOrdNo);
				//	firstStepAgtVo.setOrdLotNo(ordLotNo);
					firstStepAgtVo.setStepCd("001");
					firstStepAgtVo.setLotNo(lotNo);
					if (agtService.checkTemp(firstStepAgtVo) != 0) {		//초물데이터가 있다면
						agtList.add(agtService.readTemp(firstStepAgtVo));	//데이터조회 및 목록에 추가
					}	
				//} else if ("002".equals(stepCd)) {
					AgtVo secondStepAgtVo = new AgtVo();
					secondStepAgtVo.setWorkOrdNo(workOrdNo);
				//	secondStepAgtVo.setOrdLotNo(ordLotNo);
					secondStepAgtVo.setStepCd("002");
					secondStepAgtVo.setLotNo(lotNo);
					if (agtService.checkTemp(secondStepAgtVo) != 0) {		//중물데이터가 있다면
						agtList.add(agtService.readTemp(secondStepAgtVo));	//데이터조회 및 목록에 추가
					}	
				//}// else if ("003".equals(stepCd)) {
					AgtVo thirdStepAgtVo = new AgtVo();
					thirdStepAgtVo.setWorkOrdNo(workOrdNo);
				//	thirdStepAgtVo.setOrdLotNo(ordLotNo);
					thirdStepAgtVo.setStepCd("003");
					thirdStepAgtVo.setLotNo(lotNo);
					if (agtService.checkTemp(thirdStepAgtVo) != 0) {		//종물데이터가 있다면
						agtList.add(agtService.readTemp(thirdStepAgtVo));	//데이터조회 및 목록에 추가
					}
				//}
				jsonData.put("data", agtList);
				jsonData.put("result", "ok");
				
			} catch (Exception e) {
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
			}

			return jsonData;
		}

	//에이젼트 온도 조건 읽기
	@RequestMapping(value = "/po/readTempCond", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readTempCond(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 온도 조건 읽기 = " + agtVo);
		try {
			EquipTempaturCondAdm equipTempaturCondAdm = new EquipTempaturCondAdm();
			equipTempaturCondAdm.setWorkOrdNo(agtVo.getWorkOrdNo());
			equipTempaturCondAdm = agtService.readTempCond(equipTempaturCondAdm);
			jsonData.put("data", equipTempaturCondAdm);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//에이젼트 온도 데이터 수정
	@RequestMapping(value = "/po/agtUpdateTemp", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtUpdateTemp(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 온도 데이터 수정 = " + agtVo);
		try {
			agtVo.setUpdId(Utils.getUserId());
			agtService.updateTemp(agtVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//초중종물 불러오기 (자동입력)
	@RequestMapping(value = "/po/agtDataLoad", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtDataLoad(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초중종물 불러오기 (자동입력) " + workOrderVo);
		try {
			WorkOrderVo readVo = workOrderService.checkBefoerMatrlLotNo(workOrderVo);
			workOrderVo.setLastWorkOrdNo(readVo.getWorkOrdNo());
			
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			List<AgtVo> agtList = agtService.readTemp2(agtVo);
			if(agtList.size() == 0) {
				if(readVo != null) {
					if(readVo.getLotNo().equals(workOrderVo.getLotNo())) {			
						agtService.dataLoadSize(workOrderVo);
						agtService.dataLoadTemp(workOrderVo);	
						agtService.dataLoadTime(workOrderVo);
						agtService.dataLoadPress(workOrderVo);	
						jsonData.put("result", "ok"); // 블러오기 가능
					} else {					
						jsonData.put("message", "직전작지와 LOT NO가 일치하지 않습니다.");
						jsonData.put("result", "fail"); // 불러오기 불가능
					}
				} else {
					jsonData.put("message", "직전작지를 읽어올 수 없습니다.");
					jsonData.put("result", "fail");
				}
			} else {
				jsonData.put("message", "등록된 초.중.종물이 존재합니다.");
				jsonData.put("result", "fail");
			}			 

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	//에이젼트 치수 데이터 조회
	@RequestMapping(value = "/po/agtReadSize", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtReadSize(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 조회 = " + agtVo);
		try {
			String workOrdNo = agtVo.getWorkOrdNo();
			//String ordLotNo = agtVo.getOrdLotNo();
			//String stepCd = agtVo.getStepCd();
			String lotNo = agtVo.getLotNo();
			List<AgtVo> agtList = new ArrayList<AgtVo>();
			
			//if ("001".equals(stepCd)) {
				AgtVo firstStepAgtVo = new AgtVo();
				firstStepAgtVo.setWorkOrdNo(workOrdNo);
			//	firstStepAgtVo.setOrdLotNo(ordLotNo);
				firstStepAgtVo.setStepCd("001");
				firstStepAgtVo.setLotNo(lotNo);
				if (agtService.checkSize(firstStepAgtVo) != 0) {		//초물데이터가 있다면
					agtList.add(agtService.readSize(firstStepAgtVo));	//데이터조회 및 목록에 추가
				}	
			//} else if ("002".equals(stepCd)) {
				AgtVo secondStepAgtVo = new AgtVo();
				secondStepAgtVo.setWorkOrdNo(workOrdNo);
			//	secondStepAgtVo.setOrdLotNo(ordLotNo);
				secondStepAgtVo.setStepCd("002");
				secondStepAgtVo.setLotNo(lotNo);
				if (agtService.checkSize(secondStepAgtVo) != 0) {		//중물데이터가 있다면
					agtList.add(agtService.readSize(secondStepAgtVo));	//데이터조회 및 목록에 추가
				}
				
			//}// else if ("003".equals(stepCd)) {
			//	AgtVo thirdStepAgtVo = new AgtVo();
			//	thirdStepAgtVo.setWorkOrdNo(workOrdNo);
			//	thirdStepAgtVo.setOrdLotNo(ordLotNo);
			//	thirdStepAgtVo.setStepCd(stepCd);
			//	thirdStepAgtVo.setLotNo(lotNo);
			//	if (agtService.checkSize(thirdStepAgtVo) != 0) {		//종물데이터가 있다면
			//		agtList.add(agtService.readSize(thirdStepAgtVo));	//데이터조회 및 목록에 추가
			//	}	
			//}
			
			jsonData.put("data", agtList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//에이젼트 치수 데이터 조회
	@RequestMapping(value = "/po/agtReadSize_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtReadSize_F3(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 조회 = " + agtVo);
		try {
			String workOrdNo = agtVo.getWorkOrdNo();
			//String ordLotNo = agtVo.getOrdLotNo();
			//String stepCd = agtVo.getStepCd();
			String lotNo = agtVo.getLotNo();
			List<AgtVo> agtList = new ArrayList<AgtVo>();
			int count = 0;
			//if ("001".equals(stepCd)) {
				AgtVo firstStepAgtVo = new AgtVo();
				firstStepAgtVo.setWorkOrdNo(workOrdNo);
			//	firstStepAgtVo.setOrdLotNo(ordLotNo);
				firstStepAgtVo.setStepCd("001");
				firstStepAgtVo.setLotNo(lotNo);
				if (agtService.checkSize(firstStepAgtVo) != 0) {		//초물데이터가 있다면
					agtList.add(agtService.readSize(firstStepAgtVo));	//데이터조회 및 목록에 추가
					count++;
				}	
			//} else if ("002".equals(stepCd)) {
				AgtVo secondStepAgtVo = new AgtVo();
				secondStepAgtVo.setWorkOrdNo(workOrdNo);
			//	secondStepAgtVo.setOrdLotNo(ordLotNo);
				secondStepAgtVo.setStepCd("002");
				secondStepAgtVo.setLotNo(lotNo);
				if (agtService.checkSize(secondStepAgtVo) != 0) {		//중물데이터가 있다면
					agtList.add(agtService.readSize(secondStepAgtVo));	//데이터조회 및 목록에 추가
					count++;
				}
				
			//}// else if ("003".equals(stepCd)) {
				AgtVo thirdStepAgtVo = new AgtVo();
				thirdStepAgtVo.setWorkOrdNo(workOrdNo);
			//	thirdStepAgtVo.setOrdLotNo(ordLotNo);
				thirdStepAgtVo.setStepCd("003");
				thirdStepAgtVo.setLotNo(lotNo);
				if (agtService.checkSize(thirdStepAgtVo) != 0) {		//종물데이터가 있다면
					agtList.add(agtService.readSize(thirdStepAgtVo));	//데이터조회 및 목록에 추가
					count++;
				}	
			//}
			
			jsonData.put("check", count);	
			jsonData.put("data", agtList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//에이젼트 치수 데이터 조회
	@RequestMapping(value = "/po/agtSizeSixFloorList_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtSizeSixFloorList_F3(AgtSixFloorVo agtSixFloorBomVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 조회 = " + agtSixFloorBomVo);
		try {
			List<AgtSixFloorVo> agtSizeSixFloorList	= agtService.agtSizeSixFloorList(agtSixFloorBomVo);
			
			//jsonData.put("check", count);
			jsonData.put("data", agtSizeSixFloorList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	

	//에이젼트 치수 데이터 수정
	@RequestMapping(value = "/po/agtUpdateSize", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtUpdateSize(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 수정 = " + agtVo);
		try {
			agtVo.setUpdId(Utils.getUserId());
			agtService.updateSize(agtVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//에이젼트 치수 데이터 수정
	@RequestMapping(value = "/po/agtSizeSixFloorUpdate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtSizeSixFloorUpdate_F3(AgtSixFloorVo agtSixFloorVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 수정 = " + agtSixFloorVo);
		try {
			agtSixFloorVo.setUpdId(Utils.getUserId());
			agtService.agtSizeSixFloorUpdate(agtSixFloorVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	//에이젼트 치수 추가 데이터 수정
	@RequestMapping(value = "/po/agtUpdateSizeMore", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtUpdateSizeMore(AgtVo agtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("에이젼트 치수 데이터 수정 = " + agtVo);
		try {
			agtService.updateSizeMore(agtVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//초물 삭제
	@RequestMapping(value = "/po/agtFirstDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtFirstDelete(AgtVo agtVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초물 삭제" + agtVo);
		try {			
			
			AgtVo agtVo1 = agtService.readPress(agtVo);
			AgtVo agtVo2 = agtService.readSize(agtVo);
			AgtVo agtVo3 = agtService.readTemp(agtVo);
			AgtVo agtVo4 = agtService.readTime(agtVo);
				 
			agtVo1.setIpAddress(Utils.getClientIP(request));
			agtVo2.setIpAddress(Utils.getClientIP(request));
			agtVo3.setIpAddress(Utils.getClientIP(request));
			agtVo4.setIpAddress(Utils.getClientIP(request));
			
			agtVo1.setDltId(Utils.getUserId());
			agtVo2.setDltId(Utils.getUserId());
			agtVo3.setDltId(Utils.getUserId());
			agtVo4.setDltId(Utils.getUserId());
			 
			agtService.createPressureTemp(agtVo1);
			agtService.createSizeTemp(agtVo2);
			agtService.createTempatureTemp(agtVo3);
			agtService.createTimeTemp(agtVo4);
						 
			agtService.deletePress(agtVo);
			agtService.deleteSize(agtVo);
			agtService.deleteTemp(agtVo);
			agtService.deleteTime(agtVo);
			
			jsonData.put("result", "ok");
			jsonData.put("message", "삭제가 완료되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	//초, 중, 종물 데이터 삭제 진행
	@RequestMapping(value = "/po/agtAllDelete_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> agtAllDelete_F3(AgtSixFloorVo agtSixFloorVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초물 삭제" + agtSixFloorVo);
		try {			
			
			agtSixFloorVo.setIpAddress(Utils.getClientIP(request));
			agtSixFloorVo.setDltId(Utils.getUserId());
			 
			agtService.agtTempaturTempCreate(agtSixFloorVo);
			agtService.agtTimeTempCreate(agtSixFloorVo);
			agtService.agtSizeTempCreate(agtSixFloorVo);
			
			agtService.agtTempaturTempDelete(agtSixFloorVo);
			agtService.agtTimeTempDelete(agtSixFloorVo);
			agtService.agtSizeTempDelete(agtSixFloorVo);
			
			jsonData.put("result", "ok");
			jsonData.put("message", "삭제가 완료되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	/*
	//에이젼트 치수 데이터 조회
	@RequestMapping(value = "/po/workOrderStepInsert", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderStepInsert(String workOrdNo, String stepCd, String ifEquipCd, String lotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("AGT 초,중물 등록 - " + workOrdNo + ", " + stepCd + ", " + ifEquipCd);
		try {
			AgtBomVo agtBomVo = new AgtBomVo();
			agtBomVo.setIfWorkorderCd(workOrdNo);
			agtBomVo.setIfEquipCd(ifEquipCd);
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrdNo);
			agtVo.setStepCd(stepCd);
			agtVo.setLotNo(lotNo);
			
			//View 작지번호가 존재 하지 않는 경우 ifEquipCd 로 검색
			if (agtService.checkViewBomData(agtBomVo) == 0) {
				
				//온도,치수 Agt테이블에 이미 등록되어 있는지 확인
				if (agtService.checkSize(agtVo) != 0 && agtService.checkTemp(agtVo) != 0) {
					if ( stepCd.equals("001") ) {
						jsonData.put("message", "이미 등록된 초물이 존재합니다.");
					} else if ( stepCd.equals("002") ) {
						jsonData.put("message", "이미 등록된 중물이 존재합니다.");
					}
					jsonData.put("result", "fail");
				
				} else {
					//agtView 데이터 읽어옴
					agtBomVo = agtService.readViewBomData(agtBomVo);
					AgtVo timeAgtVo = new AgtVo();
					AgtVo pressureAgtVo = new AgtVo();
					AgtVo tempaturAgtVo = new AgtVo();
					AgtVo sizeAgtVo = new AgtVo();
					
					//시간
					timeAgtVo.setWorkOrdNo(workOrdNo);
					timeAgtVo.setStepCd(stepCd);
					timeAgtVo.setEquipCd(ifEquipCd);
					timeAgtVo.setLotNo(lotNo);
					timeAgtVo.setWarmupCond("0");
					timeAgtVo.setFitupCond("0");
					timeAgtVo.setFitup2Cond("0");
					timeAgtVo.setFirstCond("0");
					timeAgtVo.setSecondCond("0");
					timeAgtVo.setThirdCond("0");
					timeAgtVo.setJinjeopCond("0");
					timeAgtVo.setJinjeop2Cond("0");
					timeAgtVo.setPush1Cond("0");
					timeAgtVo.setReformCond("0");
					timeAgtVo.setCoolCond("0");
					timeAgtVo.setRegId(Utils.getUserId());
					
					//압력
					pressureAgtVo.setWorkOrdNo(workOrdNo);
					pressureAgtVo.setStepCd(stepCd);
					pressureAgtVo.setEquipCd(ifEquipCd);
					pressureAgtVo.setLotNo(lotNo);
					pressureAgtVo.setWarmupCond("0");
					pressureAgtVo.setFitupCond("0");
					pressureAgtVo.setFirstCond("0");
					pressureAgtVo.setPush1Cond("0");
					pressureAgtVo.setSecondCond("0");
					pressureAgtVo.setJinjeopCond("0");
					pressureAgtVo.setJinjeop2Cond("0");
					pressureAgtVo.setReformCond("0");
					pressureAgtVo.setCoolCond("0");
					pressureAgtVo.setRegId(Utils.getUserId());
					
					//온도
					tempaturAgtVo.setWorkOrdNo(workOrdNo);
					tempaturAgtVo.setStepCd(stepCd);
					tempaturAgtVo.setEquipCd(ifEquipCd);
					tempaturAgtVo.setLotNo(lotNo);
					tempaturAgtVo.setWarmupCond("0");
					tempaturAgtVo.setFitup1UpCond("0");
					tempaturAgtVo.setFitup1DownCond("0");
					tempaturAgtVo.setFitup2UpleftCond("0");
					tempaturAgtVo.setFitup2DownleftCond("0");
					tempaturAgtVo.setFitup2UprightCond("0");
					tempaturAgtVo.setFitup2DownrightCond("0");
					tempaturAgtVo.setRollheatUpCond("0");
					tempaturAgtVo.setRollheatDownCond("0");
					tempaturAgtVo.setFirstUpleftCond("0");
					tempaturAgtVo.setFirstDownleftCond("0");
					tempaturAgtVo.setFirstUprightCond("0");
					tempaturAgtVo.setFirstDownrightCond("0");
					tempaturAgtVo.setPush1UpCond("0");
					tempaturAgtVo.setPush1DownCond("0");
					tempaturAgtVo.setSecondUpleftCond("0");
					tempaturAgtVo.setSecondDownleftCond("0");
					tempaturAgtVo.setSecondUprightCond("0");
					tempaturAgtVo.setSecondDownrightCond("0");
					tempaturAgtVo.setThirdUpleftCond("0");
					tempaturAgtVo.setThirdDownleftCond("0");
					tempaturAgtVo.setThirdUprightCond("0");
					tempaturAgtVo.setThirdDownrightCond("0");
					tempaturAgtVo.setJinjeop1UpCond("0");
					tempaturAgtVo.setJinjeop1DownCond("0");
					tempaturAgtVo.setJinjeop2UpCond("0");
					tempaturAgtVo.setJinjeop2DownCond("0");
					tempaturAgtVo.setRegId(Utils.getUserId());
					
					//치수
					sizeAgtVo.setWorkOrdNo(workOrdNo);
					sizeAgtVo.setStepCd(stepCd);
					sizeAgtVo.setEquipCd(ifEquipCd);
					sizeAgtVo.setLotNo(lotNo);
					sizeAgtVo.setWpLeftAlwnce("0");
					sizeAgtVo.setWpRightAlwnce("0");
					sizeAgtVo.setPitchLeftAlwnce("0");
					sizeAgtVo.setPitchRightAlwnce("0");
					sizeAgtVo.setPpfWingLeftAlwnce("0");
					sizeAgtVo.setPpfWingRightAlwnce("0");
					sizeAgtVo.setPpfDepthLeftAlwnce("0");
					sizeAgtVo.setPpfDepthRightAlwnce("0");
					sizeAgtVo.setFilmAlwnce("0");
					sizeAgtVo.setMetalDepthAlwnce("0");
					sizeAgtVo.setMetalThicknessAlwnce("0");
					sizeAgtVo.setThCenterAlwnce("0");
					sizeAgtVo.setThEdgeAlwncePlus("0");
					sizeAgtVo.setBulgeLeftupHeight("0");
					sizeAgtVo.setBulgeLeftdownHeight("0");
					sizeAgtVo.setBulgeRightupHeight("0");
					sizeAgtVo.setBulgeRightdownHeight("0");
					sizeAgtVo.setBulgeLeftupWidth("0");
					sizeAgtVo.setBulgeLeftdownWidth("0");
					sizeAgtVo.setBulgeRightupWidth("0");
					sizeAgtVo.setBulgeRightdownWidth("0");
					sizeAgtVo.setBurrMetalAlwnce("0");
					sizeAgtVo.setBurrRcutAlwnce("0");
					sizeAgtVo.setBurrRedgeAlwnce("0");
					sizeAgtVo.setRegId(Utils.getUserId());
					
					if (agtBomVo == null) {
						jsonData.put("message", "해당 설비(" + ifEquipCd + ")의 측정데이터가 없습니다.<br>수기로 입력해 주세요!");
						
					} else {
						
						//시간
						timeAgtVo.setEquipCd(agtBomVo.getIfEquipCd());				
						//timeAgtVo.set(agtBomVo.getIfGaHeatTime());				//가융착(열)	-> MES 등록 안함
						timeAgtVo.setFitupCond(agtBomVo.getIfGaPressTime());		//가웅착(압)	-> 가접1
						timeAgtVo.setFirstCond(agtBomVo.getIf1stmtHeatTime());		//1차메탈
						timeAgtVo.setPush1Cond(agtBomVo.getIf1stmtPushTime());		//1차푸셔
						timeAgtVo.setJinjeopCond(agtBomVo.getIfJinTime());			//진접1
						timeAgtVo.setSecondCond(agtBomVo.getIf2ndmtHeatTime());		//2차메탈
						//timeAgtVo.set(agtBomVo.getIf2ndmtPushTime());				//2차푸셔		-> 사용 안함
						timeAgtVo.setCoolCond(agtBomVo.getIfCoolTime());			//냉각
						timeAgtVo.setJinjeop2Cond(agtBomVo.getIfReformTime());		//진접2
						timeAgtVo.setReformCond(agtBomVo.getIfReformTime());		//AGT리폼은 View의 어느컬럼임? -> 리폼=진접2 같은명칭임. AGT에서도 2개 동시에 등록해주고있음. 리폼 미사용
						//timeAgtVo.set(agtBomVo.getIfSuTime());					//수평가대		-> MES 등록 안함
						//timeAgtVo.setReformCond(agtBomVo.getIf3rdmtPushTime());	//3차푸셔		-> 사용 안함
						timeAgtVo.setThirdCond(agtBomVo.getIf3rdmtHeatTime());		//3차메탈
						
						//압력 - 위 3가지만 AGT에서 날라옴
						pressureAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
						pressureAgtVo.setPush1Cond(agtBomVo.getIfPressure1ch());	//1차푸셔 압력
						pressureAgtVo.setJinjeopCond(agtBomVo.getIfPressure2ch());	//1차진접 압력
						pressureAgtVo.setJinjeop2Cond(agtBomVo.getIfPressure3ch());	//2차진접 압력
						
						//온도 - 예열, 가접1 상하, 가접2 상하좌우, 롤히터 상하 수기 입력받음
						tempaturAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
						tempaturAgtVo.setFirstUpleftCond(agtBomVo.getIf1stMetalUL());		//1차메탈상좌
						tempaturAgtVo.setFirstUprightCond(agtBomVo.getIf1stMetalUR());		//1차메탈상우
						tempaturAgtVo.setFirstDownleftCond(agtBomVo.getIf1stMetalDL());		//1차메탈하좌
						tempaturAgtVo.setFirstDownrightCond(agtBomVo.getIf1stMetalDR());	//1차메탈하우
						tempaturAgtVo.setJinjeop1UpCond(agtBomVo.getIf1stJinjubU());		//진접1상
						tempaturAgtVo.setJinjeop1DownCond(agtBomVo.getIf1stJinjubD());		//진접1하
						tempaturAgtVo.setSecondUpleftCond(agtBomVo.getIf2ndMetalUL());		//2차메탈상좌
						tempaturAgtVo.setSecondUprightCond(agtBomVo.getIf2ndMetalUR());		//2차메탈상우
						tempaturAgtVo.setSecondDownleftCond(agtBomVo.getIf2ndMetalDL());	//2차메탈하좌
						tempaturAgtVo.setSecondDownrightCond(agtBomVo.getIf2ndMetalDR());	//2차메탈하우
						tempaturAgtVo.setPush1UpCond(agtBomVo.getIf1stMetalpushU());		//1차푸셔상
						tempaturAgtVo.setPush1DownCond(agtBomVo.getIf1stMetalpushD());		//1차푸셔하
						tempaturAgtVo.setThirdUpleftCond(agtBomVo.getIf3rdMetalUL());		//3차메탈상좌
						tempaturAgtVo.setThirdUprightCond(agtBomVo.getIf3rdMetalUR());		//3차메탈상우
						tempaturAgtVo.setThirdDownleftCond(agtBomVo.getIf3rdMetalDL());		//3차메탈하좌
						tempaturAgtVo.setThirdDownrightCond(agtBomVo.getIf3rdMetalDR());	//3차메탈하우
						tempaturAgtVo.setJinjeop2UpCond(agtBomVo.getIf2ndJinjubU());		//진접2상
						tempaturAgtVo.setJinjeop2DownCond(agtBomVo.getIf2ndJinjubD());		//진접2하
						
						//치수
						sizeAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
						sizeAgtVo.setWpLeftAlwnce(agtBomVo.getHeadlengthLeft());		//WP좌
						sizeAgtVo.setPitchLeftAlwnce(agtBomVo.getMetallengthLeft());	//Pitch좌
						sizeAgtVo.setPpfWingLeftAlwnce(agtBomVo.getWinglengthLeft());	//PPF날개좌
						sizeAgtVo.setWpRightAlwnce(agtBomVo.getHeadlengthRight());		//WP우
						sizeAgtVo.setPitchRightAlwnce(agtBomVo.getMetallengthRight());	//Pitch우
						sizeAgtVo.setPpfWingRightAlwnce(agtBomVo.getWinglengthRight());	//PPF날개우
						
						//sizeAgtVo.setPpfDepthLeftAlwnce(agtBomVo.getFilmwidthLeft());			//P.P Film 폭
						//sizeAgtVo.setPpfDepthRightAlwnce(agtBomVo.getFilmwidthRight());		//P.P Film 폭
						sizeAgtVo.setPpfDepthLeftAlwnce(agtBomVo.getFilmwidthLeftInside());		//P.P Film 폭 내측
						sizeAgtVo.setPpfDepthRightAlwnce(agtBomVo.getFilmwidthRightInside());	//P.P Film 폭 내측
						
						sizeAgtVo.setBulgeLeftupHeight(agtBomVo.getFilmdolgiLeftupHeight());		//돌기좌상높이
						sizeAgtVo.setBulgeLeftupWidth(agtBomVo.getFilmdolgiLeftupWidth());			//돌기좌상너비
						sizeAgtVo.setBulgeLeftdownHeight(agtBomVo.getFilmdolgiLeftdownHeight());	//돌기좌하높이
						sizeAgtVo.setBulgeLeftdownWidth(agtBomVo.getFilmdolgiLeftdownWidth());		//돌기좌하너비
						sizeAgtVo.setBulgeRightupHeight(agtBomVo.getFilmdolgiRightupHeight());		//돌기우상높이
						sizeAgtVo.setBulgeRightupWidth(agtBomVo.getFilmdolgiRightupWidth());		//돌기우상너비
						sizeAgtVo.setBulgeRightdownHeight(agtBomVo.getFilmdolgiRightdownHeight());	//돌기우하높이
						sizeAgtVo.setBulgeRightdownWidth(agtBomVo.getFilmdolgiRightdownWidth());	//돌기우하너비
						sizeAgtVo.setFilmAlwnce( String.valueOf( (Double.parseDouble(agtBomVo.getFilmtotallengthUp()) + Double.parseDouble(agtBomVo.getFilmtotallengthDown())) / 2) );	//(필름상 + 필름하)/2 = 필름 폭
						sizeAgtVo.setMetalDepthAlwnce( String.valueOf( (Double.parseDouble(agtBomVo.getMetalwidthDown()) + Double.parseDouble(agtBomVo.getMetalwidthUp())) / 2) );		//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
						
						jsonData.put("message", "해당작지(" + workOrdNo + ")의 BOM 데이터가 조회되지 않습니다.<br>" + agtBomVo.getIfEquipCd() + "의 가장 최근 측정정보를 가져옵니다.<br>반드시 수치를 확인 후 수정해 주세요!");
						logger.info(agtBomVo.toString());
					}
					
					agtService.createTime(timeAgtVo);
					agtService.createPressure(pressureAgtVo);
					agtService.createTempature(tempaturAgtVo);
					agtService.createSize(sizeAgtVo);
					
					jsonData.put("result", "ok");
				}
				
				
			//View 작지번호가 존재 할 경우 workOrdNo 로 검색
			} else {
				
				//온도,치수 Agt테이블에 이미 등록되어 있는지 확인
				if ( agtService.checkSize(agtVo) != 0 && agtService.checkTemp(agtVo) != 0 ) {
					if ( stepCd.equals("001") ) {
						jsonData.put("message", "이미 등록된 초물이 존재합니다.");
					} else if ( stepCd.equals("002") ) {
						jsonData.put("message", "이미 등록된 중물이 존재합니다.");
					}
					jsonData.put("result", "fail");
					
				} else {
					//agtView 데이터 읽어옴
					agtBomVo = agtService.readViewBomData(agtBomVo);
					
					//시간
					AgtVo timeAgtVo = new AgtVo();
					timeAgtVo.setWorkOrdNo(workOrdNo);
					timeAgtVo.setStepCd(stepCd);
					timeAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
					timeAgtVo.setLotNo(lotNo);
					timeAgtVo.setWarmupCond("0");
					timeAgtVo.setFitupCond("0");
					timeAgtVo.setFitup2Cond("0");
					timeAgtVo.setFirstCond("0");
					timeAgtVo.setSecondCond("0");
					timeAgtVo.setThirdCond("0");
					timeAgtVo.setJinjeopCond("0");
					timeAgtVo.setJinjeop2Cond("0");
					timeAgtVo.setPush1Cond("0");
					timeAgtVo.setReformCond("0");
					timeAgtVo.setCoolCond("0");
					timeAgtVo.setRegId(Utils.getUserId());
					
					//timeAgtVo.set(agtBomVo.getIfGaHeatTime());				//가융착(열)	-> MES 등록 안함
					timeAgtVo.setFitupCond(agtBomVo.getIfGaPressTime());		//가웅착(압)	-> 가접1
					timeAgtVo.setFirstCond(agtBomVo.getIf1stmtHeatTime());		//1차메탈
					timeAgtVo.setPush1Cond(agtBomVo.getIf1stmtPushTime());		//1차푸셔
					timeAgtVo.setJinjeopCond(agtBomVo.getIfJinTime());			//진접1
					timeAgtVo.setSecondCond(agtBomVo.getIf2ndmtHeatTime());		//2차메탈
					//timeAgtVo.set(agtBomVo.getIf2ndmtPushTime());				//2차푸셔		-> 사용 안함
					timeAgtVo.setCoolCond(agtBomVo.getIfCoolTime());			//냉각
					timeAgtVo.setJinjeop2Cond(agtBomVo.getIfReformTime());		//진접2
					timeAgtVo.setReformCond(agtBomVo.getIfReformTime());		//AGT리폼은 View의 어느컬럼임? -> 리폼=진접2 같은명칭임. AGT에서도 2개 동시에 등록해주고있음. 리폼 미사용
					//timeAgtVo.set(agtBomVo.getIfSuTime());					//수평가대		-> MES 등록 안함
					//timeAgtVo.setReformCond(agtBomVo.getIf3rdmtPushTime());	//3차푸셔		-> 사용 안함
					timeAgtVo.setThirdCond(agtBomVo.getIf3rdmtHeatTime());		//3차메탈
					
					agtService.createTime(timeAgtVo);

					
					//압력
					AgtVo pressureAgtVo = new AgtVo();
					pressureAgtVo.setWorkOrdNo(workOrdNo);
					pressureAgtVo.setStepCd(stepCd);
					pressureAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
					pressureAgtVo.setLotNo(lotNo);
					pressureAgtVo.setWarmupCond("0");
					pressureAgtVo.setFitupCond("0");
					pressureAgtVo.setFirstCond("0");
					pressureAgtVo.setPush1Cond("0");
					pressureAgtVo.setSecondCond("0");
					pressureAgtVo.setJinjeopCond("0");
					pressureAgtVo.setJinjeop2Cond("0");
					pressureAgtVo.setReformCond("0");
					pressureAgtVo.setCoolCond("0");
					pressureAgtVo.setRegId(Utils.getUserId());
					
					pressureAgtVo.setPush1Cond(agtBomVo.getIfPressure1ch());	//1차푸셔 압력
					pressureAgtVo.setJinjeopCond(agtBomVo.getIfPressure2ch());	//1차진접 압력
					pressureAgtVo.setJinjeop2Cond(agtBomVo.getIfPressure3ch());	//2차진접 압력
					//압력은 위 3가지만 AGT에서 날라옴
					agtService.createPressure(pressureAgtVo);
					
					
					//온도
					AgtVo tempaturAgtVo = new AgtVo();
					tempaturAgtVo.setWorkOrdNo(workOrdNo);
					tempaturAgtVo.setStepCd(stepCd);
					tempaturAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
					tempaturAgtVo.setLotNo(lotNo);
					tempaturAgtVo.setWarmupCond("0");
					tempaturAgtVo.setFitup1UpCond("0");
					tempaturAgtVo.setFitup1DownCond("0");
					tempaturAgtVo.setFitup2UpleftCond("0");
					tempaturAgtVo.setFitup2DownleftCond("0");
					tempaturAgtVo.setFitup2UprightCond("0");
					tempaturAgtVo.setFitup2DownrightCond("0");
					tempaturAgtVo.setRollheatUpCond("0");
					tempaturAgtVo.setRollheatDownCond("0");
					tempaturAgtVo.setFirstUpleftCond("0");
					tempaturAgtVo.setFirstDownleftCond("0");
					tempaturAgtVo.setFirstUprightCond("0");
					tempaturAgtVo.setFirstDownrightCond("0");
					tempaturAgtVo.setPush1UpCond("0");
					tempaturAgtVo.setPush1DownCond("0");
					tempaturAgtVo.setSecondUpleftCond("0");
					tempaturAgtVo.setSecondDownleftCond("0");
					tempaturAgtVo.setSecondUprightCond("0");
					tempaturAgtVo.setSecondDownrightCond("0");
					tempaturAgtVo.setThirdUpleftCond("0");
					tempaturAgtVo.setThirdDownleftCond("0");
					tempaturAgtVo.setThirdUprightCond("0");
					tempaturAgtVo.setThirdDownrightCond("0");
					tempaturAgtVo.setJinjeop1UpCond("0");
					tempaturAgtVo.setJinjeop1DownCond("0");
					tempaturAgtVo.setJinjeop2UpCond("0");
					tempaturAgtVo.setJinjeop2DownCond("0");
					tempaturAgtVo.setRegId(Utils.getUserId());
					
					tempaturAgtVo.setFirstUpleftCond(agtBomVo.getIf1stMetalUL());		//1차메탈상좌
					tempaturAgtVo.setFirstUprightCond(agtBomVo.getIf1stMetalUR());		//1차메탈상우
					tempaturAgtVo.setFirstDownleftCond(agtBomVo.getIf1stMetalDL());		//1차메탈하좌
					tempaturAgtVo.setFirstDownrightCond(agtBomVo.getIf1stMetalDR());	//1차메탈하우
					tempaturAgtVo.setJinjeop1UpCond(agtBomVo.getIf1stJinjubU());		//진접1상
					tempaturAgtVo.setJinjeop1DownCond(agtBomVo.getIf1stJinjubD());		//진접1하
					tempaturAgtVo.setSecondUpleftCond(agtBomVo.getIf2ndMetalUL());		//2차메탈상좌
					tempaturAgtVo.setSecondUprightCond(agtBomVo.getIf2ndMetalUR());		//2차메탈상우
					tempaturAgtVo.setSecondDownleftCond(agtBomVo.getIf2ndMetalDL());	//2차메탈하좌
					tempaturAgtVo.setSecondDownrightCond(agtBomVo.getIf2ndMetalDR());	//2차메탈하우
					tempaturAgtVo.setPush1UpCond(agtBomVo.getIf1stMetalpushU());		//1차푸셔상
					tempaturAgtVo.setPush1DownCond(agtBomVo.getIf1stMetalpushD());		//1차푸셔하
					tempaturAgtVo.setThirdUpleftCond(agtBomVo.getIf3rdMetalUL());		//3차메탈상좌
					tempaturAgtVo.setThirdUprightCond(agtBomVo.getIf3rdMetalUR());		//3차메탈상우
					tempaturAgtVo.setThirdDownleftCond(agtBomVo.getIf3rdMetalDL());		//3차메탈하좌
					tempaturAgtVo.setThirdDownrightCond(agtBomVo.getIf3rdMetalDR());	//3차메탈하우
					tempaturAgtVo.setJinjeop2UpCond(agtBomVo.getIf2ndJinjubU());		//진접2상
					tempaturAgtVo.setJinjeop2DownCond(agtBomVo.getIf2ndJinjubD());		//진접2하
					//예열, 가접1 상하, 가접2 상하좌우, 롤히터 상하 수기 입력받음
					agtService.createTempature(tempaturAgtVo);
					
					
					//치수
					AgtVo sizeAgtVo = new AgtVo();
					sizeAgtVo.setWorkOrdNo(workOrdNo);
					sizeAgtVo.setStepCd(stepCd);
					sizeAgtVo.setEquipCd(agtBomVo.getIfEquipCd());
					sizeAgtVo.setLotNo(lotNo);
					sizeAgtVo.setWpLeftAlwnce("0");
					sizeAgtVo.setWpRightAlwnce("0");
					sizeAgtVo.setPitchLeftAlwnce("0");
					sizeAgtVo.setPitchRightAlwnce("0");
					sizeAgtVo.setPpfWingLeftAlwnce("0");
					sizeAgtVo.setPpfWingRightAlwnce("0");
					sizeAgtVo.setPpfDepthLeftAlwnce("0");
					sizeAgtVo.setPpfDepthRightAlwnce("0");
					sizeAgtVo.setFilmAlwnce("0");
					sizeAgtVo.setMetalDepthAlwnce("0");
					sizeAgtVo.setMetalThicknessAlwnce("0");
					sizeAgtVo.setThCenterAlwnce("0");
					sizeAgtVo.setThEdgeAlwncePlus("0");
					sizeAgtVo.setBulgeLeftupHeight("0");
					sizeAgtVo.setBulgeLeftdownHeight("0");
					sizeAgtVo.setBulgeRightupHeight("0");
					sizeAgtVo.setBulgeRightdownHeight("0");
					sizeAgtVo.setBulgeLeftupWidth("0");
					sizeAgtVo.setBulgeLeftdownWidth("0");
					sizeAgtVo.setBulgeRightupWidth("0");
					sizeAgtVo.setBulgeRightdownWidth("0");
					sizeAgtVo.setBurrMetalAlwnce("0");
					sizeAgtVo.setBurrRcutAlwnce("0");
					sizeAgtVo.setBurrRedgeAlwnce("0");
					sizeAgtVo.setRegId(Utils.getUserId());
					
					sizeAgtVo.setWpLeftAlwnce(agtBomVo.getHeadlengthLeft());		//WP좌
					sizeAgtVo.setPitchLeftAlwnce(agtBomVo.getMetallengthLeft());	//Pitch좌
					sizeAgtVo.setPpfWingLeftAlwnce(agtBomVo.getWinglengthLeft());	//PPF날개좌
					sizeAgtVo.setWpRightAlwnce(agtBomVo.getHeadlengthRight());		//WP우
					sizeAgtVo.setPitchRightAlwnce(agtBomVo.getMetallengthRight());	//Pitch우
					sizeAgtVo.setPpfWingRightAlwnce(agtBomVo.getWinglengthRight());	//PPF날개우
					
					//sizeAgtVo.setPpfDepthLeftAlwnce(agtBomVo.getFilmwidthLeft());			//P.P Film 폭
					//sizeAgtVo.setPpfDepthRightAlwnce(agtBomVo.getFilmwidthRight());		//P.P Film 폭
					sizeAgtVo.setPpfDepthLeftAlwnce(agtBomVo.getFilmwidthLeftInside());		//P.P Film 폭 내측
					sizeAgtVo.setPpfDepthRightAlwnce(agtBomVo.getFilmwidthRightInside());	//P.P Film 폭 내측
					
					sizeAgtVo.setBulgeLeftupHeight(agtBomVo.getFilmdolgiLeftupHeight());		//돌기좌상높이
					sizeAgtVo.setBulgeLeftupWidth(agtBomVo.getFilmdolgiLeftupWidth());			//돌기좌상너비
					sizeAgtVo.setBulgeLeftdownHeight(agtBomVo.getFilmdolgiLeftdownHeight());	//돌기좌하높이
					sizeAgtVo.setBulgeLeftdownWidth(agtBomVo.getFilmdolgiLeftdownWidth());		//돌기좌하너비
					sizeAgtVo.setBulgeRightupHeight(agtBomVo.getFilmdolgiRightupHeight());		//돌기우상높이
					sizeAgtVo.setBulgeRightupWidth(agtBomVo.getFilmdolgiRightupWidth());		//돌기우상너비
					sizeAgtVo.setBulgeRightdownHeight(agtBomVo.getFilmdolgiRightdownHeight());	//돌기우하높이
					sizeAgtVo.setBulgeRightdownWidth(agtBomVo.getFilmdolgiRightdownWidth());	//돌기우하너비
					sizeAgtVo.setFilmAlwnce( String.valueOf( (Double.parseDouble(agtBomVo.getFilmtotallengthUp()) + Double.parseDouble(agtBomVo.getFilmtotallengthDown())) / 2) );	//(필름상 + 필름하)/2 = 필름 폭
					sizeAgtVo.setMetalDepthAlwnce( String.valueOf( (Double.parseDouble(agtBomVo.getMetalwidthUp()) + Double.parseDouble(agtBomVo.getMetalwidthDown())) / 2) );		//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
					
					agtService.createSize(sizeAgtVo);
					
					logger.info(agtBomVo.toString());
					jsonData.put("message", agtBomVo.getIfEquipCd() + " - " + agtBomVo.getIfWorkorderCd() + " 등록되었습니다.");
					jsonData.put("result", "ok");
				}
			}
			
			logger.info("AGT 초,중물 등록 - " + workOrdNo);
			logger.info("AGT 초,중물 등록 - " + stepCd);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	*/
	
	
	
	
	
	//에이젼트 치수 데이터 조회
	//@RequestMapping(value = "/po/workOrderStepInsert", method = RequestMethod.POST)
	@RequestMapping(value = "/po/workOrderStepInsertRedis_DB0", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderStepInsertRedis_DB0(String workOrdNo, String ordLotNo,String stepCd, String equipCd, String lotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("AGT 초,중물 등록 - " + workOrdNo + ", " + stepCd + ", " + equipCd);
		try {
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrdNo);
			agtVo.setOrdLotNo(ordLotNo);
			agtVo.setStepCd(stepCd);
			agtVo.setLotNo(lotNo);
			//온도,치수 Agt테이블에 이미 등록되어 있는지 확인
			if (agtService.checkSize(agtVo) != 0 && agtService.checkTemp(agtVo) != 0) {
				if (stepCd.equals("001")) {
					jsonData.put("message", "이미 등록된 초물이 존재합니다.");
				} else if (stepCd.equals("002")) {
					jsonData.put("message", "이미 등록된 중물이 존재합니다.");
				}
				jsonData.put("result", "fail");
			
			//등록 진행
			} else {
				logger.info("설비코드 ===> : " + equipCd);
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
				boolean virtualMachine = false;
				String equipNm = equipCodeAdmVo.getEquipNm();
				//가상설비 일경우
				if (equipCodeAdmVo.getEtc1() != null && !"".equals(equipCodeAdmVo.getEtc1())) {
					equipNm = equipCodeAdmVo.getEtc1();
					virtualMachine = true;
				}
				String redisStringData = redisData(equipNm);
				
				//가상설비일 경우 equipNm을 다시 원상태(가상설비)로 돌려줌
				if (virtualMachine) {
					equipNm = equipCodeAdmVo.getEquipNm();
				}
				
				AgtVo timeAgtVo = new AgtVo();
				AgtVo pressureAgtVo = new AgtVo();
				AgtVo tempaturAgtVo = new AgtVo();
				AgtVo sizeAgtVo = new AgtVo();
				timeAgtVo.setWorkOrdNo(workOrdNo);
				timeAgtVo.setOrdLotNo(ordLotNo);
				timeAgtVo.setStepCd(stepCd);
				timeAgtVo.setEquipCd(equipNm);
				timeAgtVo.setLotNo(lotNo);
				timeAgtVo.setWarmupCond("0");
				timeAgtVo.setFitupCond("0");
				timeAgtVo.setFitup2Cond("0");
				timeAgtVo.setFirstCond("0");
				timeAgtVo.setSecondCond("0");
				timeAgtVo.setThirdCond("0");
				timeAgtVo.setJinjeopCond("0");
				timeAgtVo.setJinjeop2Cond("0");
				timeAgtVo.setPush1Cond("0");
				timeAgtVo.setReformCond("0");
				timeAgtVo.setCoolCond("0");
				timeAgtVo.setRegId(Utils.getUserId());
				
				pressureAgtVo.setWorkOrdNo(workOrdNo);
				pressureAgtVo.setOrdLotNo(ordLotNo);
				pressureAgtVo.setStepCd(stepCd);
				pressureAgtVo.setEquipCd(equipNm);
				pressureAgtVo.setLotNo(lotNo);
				pressureAgtVo.setWarmupCond("0");
				pressureAgtVo.setFitupCond("0");
				pressureAgtVo.setFirstCond("0");
				pressureAgtVo.setPush1Cond("0");
				pressureAgtVo.setSecondCond("0");
				pressureAgtVo.setJinjeopCond("0");
				pressureAgtVo.setJinjeop2Cond("0");
				pressureAgtVo.setReformCond("0");
				pressureAgtVo.setCoolCond("0");
				pressureAgtVo.setRegId(Utils.getUserId());
				
				tempaturAgtVo.setWorkOrdNo(workOrdNo);
				tempaturAgtVo.setOrdLotNo(ordLotNo);
				tempaturAgtVo.setStepCd(stepCd);
				tempaturAgtVo.setEquipCd(equipNm);
				tempaturAgtVo.setLotNo(lotNo);
				tempaturAgtVo.setWarmupCond("0");
				tempaturAgtVo.setFitup1UpCond("0");
				tempaturAgtVo.setFitup1DownCond("0");
				tempaturAgtVo.setFitup2UpleftCond("0");
				tempaturAgtVo.setFitup2DownleftCond("0");
				tempaturAgtVo.setFitup2UprightCond("0");
				tempaturAgtVo.setFitup2DownrightCond("0");
				tempaturAgtVo.setRollheatUpCond("0");
				tempaturAgtVo.setRollheatDownCond("0");
				tempaturAgtVo.setFirstUpleftCond("0");
				tempaturAgtVo.setFirstDownleftCond("0");
				tempaturAgtVo.setFirstUprightCond("0");
				tempaturAgtVo.setFirstDownrightCond("0");
				tempaturAgtVo.setPush1UpCond("0");
				tempaturAgtVo.setPush1DownCond("0");
				tempaturAgtVo.setSecondUpleftCond("0");
				tempaturAgtVo.setSecondDownleftCond("0");
				tempaturAgtVo.setSecondUprightCond("0");
				tempaturAgtVo.setSecondDownrightCond("0");
				tempaturAgtVo.setThirdUpleftCond("0");
				tempaturAgtVo.setThirdDownleftCond("0");
				tempaturAgtVo.setThirdUprightCond("0");
				tempaturAgtVo.setThirdDownrightCond("0");
				tempaturAgtVo.setJinjeop1UpCond("0");
				tempaturAgtVo.setJinjeop1DownCond("0");
				tempaturAgtVo.setJinjeop2UpCond("0");
				tempaturAgtVo.setJinjeop2DownCond("0");
				tempaturAgtVo.setRegId(Utils.getUserId());
				
				sizeAgtVo.setWorkOrdNo(workOrdNo);
				sizeAgtVo.setOrdLotNo(ordLotNo);
				sizeAgtVo.setStepCd(stepCd);
				sizeAgtVo.setEquipCd(equipNm);
				sizeAgtVo.setLotNo(lotNo);
				sizeAgtVo.setWpLeftAlwnce("0");
				sizeAgtVo.setWpRightAlwnce("0");
				sizeAgtVo.setPitchLeftAlwnce("0");
				sizeAgtVo.setPitchRightAlwnce("0");
				sizeAgtVo.setPpfWingLeftAlwnce("0");
				sizeAgtVo.setPpfWingRightAlwnce("0");
				sizeAgtVo.setPpfDepthLeftAlwnce("0");
				sizeAgtVo.setPpfDepthRightAlwnce("0");
				sizeAgtVo.setFilmAlwnce("0");
				sizeAgtVo.setMetalDepthAlwnce("0");
				sizeAgtVo.setMetalThicknessAlwnce("0");
				sizeAgtVo.setThCenterAlwnce("0");
				sizeAgtVo.setThEdgeAlwncePlus("0");
				sizeAgtVo.setThStepInput("0");
				sizeAgtVo.setThEdgeCnt("0");
				sizeAgtVo.setThEdgeResult("0");
				sizeAgtVo.setBulgeLeftupHeight("0");
				sizeAgtVo.setBulgeLeftdownHeight("0");
				sizeAgtVo.setBulgeRightupHeight("0");
				sizeAgtVo.setBulgeRightdownHeight("0");
				sizeAgtVo.setBulgeLeftupWidth("0");
				sizeAgtVo.setBulgeLeftdownWidth("0");
				sizeAgtVo.setBulgeRightupWidth("0");
				sizeAgtVo.setBulgeRightdownWidth("0");
				sizeAgtVo.setBurrMetalAlwnce("0");
				sizeAgtVo.setBurrRcutAlwnce("0");
				sizeAgtVo.setBurrRedgeAlwnce("0");
				sizeAgtVo.setRegId(Utils.getUserId());
				
				//해당설비 정보X
				if (redisStringData == null || redisStringData.equals("empty")) {
					logger.info(equipNm + " - 해당설비 측정값 없음");
					agtService.createTime(timeAgtVo);
					agtService.createPressure(pressureAgtVo);
					agtService.createTempature(tempaturAgtVo);
					agtService.createSize(sizeAgtVo);
					
					jsonData.put("message", equipNm + " - 해당설비 측정값 없어 모든 값이 0으로 등록됩니다!");
					jsonData.put("result", "fail");
				
				//해당설비 정보O
				} else {
					logger.info(equipNm + ", 원본 - " + redisStringData);
					//redisStringData = redisStringData.replace("null", ""0"");			//null 값 0으로 치환
					//redisStringData = redisStringData.replace("":""", "":"0"");		//공백 값 0으로 치환
					Gson gson = new Gson();
					RealTimeRedisBomVo realTimeRedisBomVo = gson.fromJson(redisStringData, RealTimeRedisBomVo.class);	//jsonString형식을 Vo에 맞게 변환
					logger.info(equipNm + ", 변환 - " + realTimeRedisBomVo);
					
					//redis에 등록되어있는 시간								//YYYY랑 yyyy랑 다름 주의!
					SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					//Redis 0번 DB는 regDate 사용
					//Redis 1번 DB는 ctime 사용
					//Date readRegDate = datetimeFormat.parse(readRedisAgtBomVo.getRegDate());
					Date readRegDate = datetimeFormat.parse(realTimeRedisBomVo.getCtime());
					
					long readRegDateToMinute = readRegDate.getTime();
					//logger.info("등록시간 가공전 : " + readRedisAgtBomVo.getRegDate());
					//logger.info("등록시간 가공 후: " + readRegDate);
					
					//현재시간
					Date currentDate = new Date();
					//logger.info("현재시간 가공전: " + currentDate);
					currentDate = datetimeFormat.parse(datetimeFormat.format(currentDate));
					//logger.info("현재시간 가공후: " + currentDate);
					long currentDateToMinute = currentDate.getTime();
					long diffMinute = (currentDateToMinute - readRegDateToMinute) / 60000;
					logger.info("현재시간 - 등록시간 = " + diffMinute);
					
					//시간
					for (int i=0; i<realTimeRedisBomVo.getDataSetTimeNm().length; i++) {
						String timeNm = realTimeRedisBomVo.getDataSetTimeNm()[i];
						if (null == timeNm) {
							continue;
						//가접1
						} else if ("gaungchakpresstime".equals(timeNm)) {
							timeAgtVo.setFitupCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//1차 메탈
						} else if ("1stMTheattime".equals(timeNm)) {
							timeAgtVo.setFirstCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//1차 푸셔
						} else if ("1stMTpushtime".equals(timeNm)) {
							timeAgtVo.setPush1Cond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//진접1
						} else if ("jinjubtime".equals(timeNm)) {
							timeAgtVo.setJinjeopCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//2차메탈
						} else if ("2ndMTheattime".equals(timeNm)) {
							timeAgtVo.setSecondCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//냉각
						} else if ("cooltime".equals(timeNm)) {
							timeAgtVo.setCoolCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//진접2 = 리폼
						} else if ("reformtime".equals(timeNm)) {
							timeAgtVo.setJinjeop2Cond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							timeAgtVo.setReformCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						//3차메탈
						} else if ("3rdMTheattime".equals(timeNm)) {
							timeAgtVo.setThirdCond(Float.toString(Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i])));
							continue;
						} else {
							continue;
						}
					}
					
					//압력
					for (int i=0; i<realTimeRedisBomVo.getDataSetPrssNm().length; i++) {
						String pressureNm = realTimeRedisBomVo.getDataSetPrssNm()[i];
						if (null == pressureNm) {
							continue;
						//1차 푸셔
						} else if ("IF_Pressure_1ch".equals(pressureNm)) {
							pressureAgtVo.setPush1Cond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						//1차 진접
						} else if ("IF_Pressure_2ch".equals(pressureNm)) {
							pressureAgtVo.setJinjeopCond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						//2차 진접
						} else if ("IF_Pressure_3ch".equals(pressureNm)) {
							pressureAgtVo.setJinjeop2Cond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						} else {
							continue;
						}
					}
					
					//온도
					for (int i=0; i<realTimeRedisBomVo.getDataSetTempNm().length; i++) {
						String tempNm = realTimeRedisBomVo.getDataSetTempNm()[i];
						if (null == tempNm) {
							continue;
						//1차메탈상좌
						} else if ("1stMLeftUp".equals(tempNm)) {
							tempaturAgtVo.setFirstUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈상우
						} else if ("1stMRightUp".equals(tempNm)) {
							tempaturAgtVo.setFirstUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈하좌
						} else if ("1stMLeftDown".equals(tempNm)) {
							tempaturAgtVo.setFirstDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈하우
						} else if ("1stMRightDown".equals(tempNm)) {
							tempaturAgtVo.setFirstDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접1상
						} else if ("Jinjub1Up".equals(tempNm)) {
							tempaturAgtVo.setJinjeop1UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접1하
						} else if ("Jinjub1Down".equals(tempNm)) {
							tempaturAgtVo.setJinjeop1DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈상좌
						} else if ("2ndMLeftUp".equals(tempNm)) {
							tempaturAgtVo.setSecondUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈상우
						} else if ("2ndMRightUp".equals(tempNm)) {
							tempaturAgtVo.setSecondUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈하좌
						} else if ("2ndMLeftDown".equals(tempNm)) {
							tempaturAgtVo.setSecondDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈하우
						} else if ("2ndMRightDown".equals(tempNm)) {
							tempaturAgtVo.setSecondDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차푸셔상
						} else if ("1stMPusherUp".equals(tempNm)) {
							tempaturAgtVo.setPush1UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차푸셔하
						} else if ("1stMPusherDown".equals(tempNm)) {
							tempaturAgtVo.setPush1DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈상좌
						} else if ("3rdMLeftUp".equals(tempNm)) {
							tempaturAgtVo.setThirdUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈상우
						} else if ("3rdMRightUp".equals(tempNm)) {
							tempaturAgtVo.setThirdUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈하좌
						} else if ("3rdMLeftDown".equals(tempNm)) {
							tempaturAgtVo.setThirdDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈하우
						} else if ("3rdMRightDown".equals(tempNm)) {
							tempaturAgtVo.setThirdDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접2상
						} else if ("Jinjub2U".equals(tempNm)) {
							tempaturAgtVo.setJinjeop2UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접2하
						} else if ("Jinjub2D".equals(tempNm)) {
							tempaturAgtVo.setJinjeop2DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						} else {
							continue;
						}
					}
					
					//치수
					for (int i=0; i<realTimeRedisBomVo.getDataSetVisionNm().length; i++) {
						String sizeNm = realTimeRedisBomVo.getDataSetVisionNm()[i];
						if (null == sizeNm) {
							continue;
						//WP좌
						} else if ("HeadLength_Left".equals(sizeNm)) {
							sizeAgtVo.setWpLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//Pitch좌
						} else if ("MetalLength_Left".equals(sizeNm)) {
							sizeAgtVo.setPitchLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//PPF날개좌
						} else if ("WingLength_Left".equals(sizeNm)) {
							sizeAgtVo.setPpfWingLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//WP우
						} else if ("HeadLength_Right".equals(sizeNm)) {
							sizeAgtVo.setWpRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//Pitch우
						} else if ("MetalLength_Right".equals(sizeNm)) {
							sizeAgtVo.setPitchRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//PPF날개우
						} else if ("WingLength_Right".equals(sizeNm)) {
							sizeAgtVo.setPpfWingRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//P.P Film 폭 내측 좌
						} else if ("FilmWidth_Left_Inside".equals(sizeNm)) {
							sizeAgtVo.setPpfDepthLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//P.P Film 폭 내측 우
						} else if ("FilmWidth_Right_Inside".equals(sizeNm)) {
							sizeAgtVo.setPpfDepthRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기좌상높이
						} else if ("FilmDolgi_LeftUp_Height".equals(sizeNm)) {
							sizeAgtVo.setBulgeLeftupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기좌상너비
						} else if ("FilmDolgi_LeftUp_Width".equals(sizeNm)) {
							sizeAgtVo.setBulgeLeftupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기좌하높이
						} else if ("FilmDolgi_LeftDown_Height".equals(sizeNm)) {
							sizeAgtVo.setBulgeLeftdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기좌하너비
						} else if ("FilmDolgi_LeftDown_Width".equals(sizeNm)) {
							sizeAgtVo.setBulgeLeftdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기우상높이
						} else if ("FilmDolgi_RightUp_Height".equals(sizeNm)) {
							sizeAgtVo.setBulgeRightupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기우상너비
						} else if ("FilmDolgi_RightUp_Width".equals(sizeNm)) {
							sizeAgtVo.setBulgeRightupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기우하높이
						} else if ("FilmDolgi_RightDown_Height".equals(sizeNm)) {
							sizeAgtVo.setBulgeRightdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//돌기우하너비
						} else if ("FilmDolgi_RightDown_Width".equals(sizeNm)) {
							sizeAgtVo.setBulgeRightdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
							continue;
						//(필름상 + 필름하)/2 = 필름 폭
						} else if ("FilmTotalLength_Up".equals(sizeNm)) {
							for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
								String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
								if ("FilmTotalLength_Down".equals(sizeNm2)) {
									if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j]) != 0) ) {
										sizeAgtVo.setFilmAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
										logger.info("필름 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
										logger.info("필름 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
									}
									break;
								}
							}
							continue;
						//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
						} else if ("MetalWidth_Up".equals(sizeNm)) {
							for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
								String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
								if ("MetalWidth_Down".equals(sizeNm2)) {
									if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j]) != 0) ) {
										sizeAgtVo.setMetalDepthAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
										logger.info("메탈 폭 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
										logger.info("메탈 폭 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
										break;
									}
								}			
							}
							continue;
							
						} else {
							continue;
						}
					}
					
					agtService.createTime(timeAgtVo);
					agtService.createPressure(pressureAgtVo);
					agtService.createTempature(tempaturAgtVo);
					agtService.createSize(sizeAgtVo);
					
					if ("001".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 초물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
					} else if ("002".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 중물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
					} else if ("003".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 종물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
					} else {
						jsonData.put("message", "초중물 등록 에러가 발생하였습니다.");
						jsonData.put("result", "fail");
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	//에이젼트 치수 데이터 조회
	//@RequestMapping(value = "/po/workOrderStepInsert", method = RequestMethod.POST)
	@RequestMapping(value = "/po/workOrderStepInsertRedis_DB0_F2F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderStepInsertRedis_DB0_F2F3(String workOrdNo, String ordLotNo, String stepCd, String equipCd, String lotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("AGT 초,중물 등록 - " + workOrdNo + ", " + stepCd + ", " + equipCd);
		try {
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrdNo);
			agtVo.setOrdLotNo(ordLotNo);
			agtVo.setStepCd(stepCd);
			agtVo.setLotNo(lotNo);
			//온도,치수 Agt테이블에 이미 등록되어 있는지 확인
			if (agtService.checkSize(agtVo) != 0 && agtService.checkTemp(agtVo) != 0) {
				if (stepCd.equals("001")) {
					jsonData.put("message", "이미 등록된 초물이 존재합니다.");
				} else if (stepCd.equals("002")) {
					jsonData.put("message", "이미 등록된 중물이 존재합니다.");
				}
				jsonData.put("result", "fail");
			
			//등록 진행
			} else {
				logger.info("설비코드 ===> : " + equipCd);
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
				boolean virtualMachine = false;
				String equipNm = equipCodeAdmVo.getEquipNm();
				//가상설비 일경우
				if (equipCodeAdmVo.getEtc1() != null && !"".equals(equipCodeAdmVo.getEtc1())) {
					equipNm = equipCodeAdmVo.getEtc1();
					virtualMachine = true;
				}
				String redisStringData = redisData(equipNm);
				
				//가상설비일 경우 equipNm을 다시 원상태(가상설비)로 돌려줌
				if (virtualMachine) {
					equipNm = equipCodeAdmVo.getEquipNm();
				}
				
				AgtVo timeAgtVo = new AgtVo();
				AgtVo pressureAgtVo = new AgtVo();
				AgtVo tempaturAgtVo = new AgtVo();
				AgtVo sizeAgtVo = new AgtVo();
				timeAgtVo.setWorkOrdNo(workOrdNo);
				timeAgtVo.setOrdLotNo(ordLotNo);
				timeAgtVo.setStepCd(stepCd);
				timeAgtVo.setEquipCd(equipNm);
				timeAgtVo.setLotNo(lotNo);
				timeAgtVo.setWarmupCond("0");
				timeAgtVo.setFitupCond("0");
				timeAgtVo.setFitup2Cond("0");
				timeAgtVo.setFirstCond("0");
				timeAgtVo.setSecondCond("0");
				timeAgtVo.setThirdCond("0");
				timeAgtVo.setJinjeopCond("0");
				timeAgtVo.setJinjeop2Cond("0");
				timeAgtVo.setPush1Cond("0");
				timeAgtVo.setReformCond("0");
				timeAgtVo.setCoolCond("0");
				timeAgtVo.setRegId(Utils.getUserId());
				
				pressureAgtVo.setWorkOrdNo(workOrdNo);
				pressureAgtVo.setOrdLotNo(ordLotNo);
				pressureAgtVo.setStepCd(stepCd);
				pressureAgtVo.setEquipCd(equipNm);
				pressureAgtVo.setLotNo(lotNo);
				pressureAgtVo.setWarmupCond("0");
				pressureAgtVo.setFitupCond("0");
				pressureAgtVo.setFirstCond("0");
				pressureAgtVo.setPush1Cond("0");
				pressureAgtVo.setSecondCond("0");
				pressureAgtVo.setJinjeopCond("0");
				pressureAgtVo.setJinjeop2Cond("0");
				pressureAgtVo.setReformCond("0");
				pressureAgtVo.setCoolCond("0");
				pressureAgtVo.setRegId(Utils.getUserId());
				
				tempaturAgtVo.setWorkOrdNo(workOrdNo);
				tempaturAgtVo.setOrdLotNo(ordLotNo);
				tempaturAgtVo.setStepCd(stepCd);
				tempaturAgtVo.setEquipCd(equipNm);
				tempaturAgtVo.setLotNo(lotNo);
				tempaturAgtVo.setWarmupCond("0");
				tempaturAgtVo.setFitup1UpCond("0");
				tempaturAgtVo.setFitup1DownCond("0");
				tempaturAgtVo.setFitup2UpleftCond("0");
				tempaturAgtVo.setFitup2DownleftCond("0");
				tempaturAgtVo.setFitup2UprightCond("0");
				tempaturAgtVo.setFitup2DownrightCond("0");
				tempaturAgtVo.setRollheatUpCond("0");
				tempaturAgtVo.setRollheatDownCond("0");
				tempaturAgtVo.setFirstUpleftCond("0");
				tempaturAgtVo.setFirstDownleftCond("0");
				tempaturAgtVo.setFirstUprightCond("0");
				tempaturAgtVo.setFirstDownrightCond("0");
				tempaturAgtVo.setPush1UpCond("0");
				tempaturAgtVo.setPush1DownCond("0");
				tempaturAgtVo.setSecondUpleftCond("0");
				tempaturAgtVo.setSecondDownleftCond("0");
				tempaturAgtVo.setSecondUprightCond("0");
				tempaturAgtVo.setSecondDownrightCond("0");
				tempaturAgtVo.setThirdUpleftCond("0");
				tempaturAgtVo.setThirdDownleftCond("0");
				tempaturAgtVo.setThirdUprightCond("0");
				tempaturAgtVo.setThirdDownrightCond("0");
				tempaturAgtVo.setJinjeop1UpCond("0");
				tempaturAgtVo.setJinjeop1DownCond("0");
				tempaturAgtVo.setJinjeop2UpCond("0");
				tempaturAgtVo.setJinjeop2DownCond("0");
				tempaturAgtVo.setRegId(Utils.getUserId());
				
				sizeAgtVo.setWorkOrdNo(workOrdNo);
				sizeAgtVo.setOrdLotNo(ordLotNo);
				sizeAgtVo.setStepCd(stepCd);
				sizeAgtVo.setEquipCd(equipNm);
				sizeAgtVo.setLotNo(lotNo);
				sizeAgtVo.setWpLeftAlwnce("0");
				sizeAgtVo.setWpRightAlwnce("0");
				sizeAgtVo.setPitchLeftAlwnce("0");
				sizeAgtVo.setPitchRightAlwnce("0");
				sizeAgtVo.setPpfWingLeftAlwnce("0");
				sizeAgtVo.setPpfWingRightAlwnce("0");
				sizeAgtVo.setPpfDepthLeftAlwnce("0");
				sizeAgtVo.setPpfDepthRightAlwnce("0");
				sizeAgtVo.setFilmAlwnce("0");
				sizeAgtVo.setMetalDepthAlwnce("0");
				sizeAgtVo.setMetalThicknessAlwnce("0");
				sizeAgtVo.setThCenterAlwnce("0");
				sizeAgtVo.setThEdgeAlwncePlus("0");
				sizeAgtVo.setThStepInput("0");
				sizeAgtVo.setThEdgeCnt("0");
				sizeAgtVo.setThEdgeResult("0");
				sizeAgtVo.setBulgeLeftupHeight("0");
				sizeAgtVo.setBulgeLeftdownHeight("0");
				sizeAgtVo.setBulgeRightupHeight("0");
				sizeAgtVo.setBulgeRightdownHeight("0");
				sizeAgtVo.setBulgeLeftupWidth("0");
				sizeAgtVo.setBulgeLeftdownWidth("0");
				sizeAgtVo.setBulgeRightupWidth("0");
				sizeAgtVo.setBulgeRightdownWidth("0");
				sizeAgtVo.setBurrMetalAlwnce("0");
				sizeAgtVo.setBurrRcutAlwnce("0");
				sizeAgtVo.setBurrRedgeAlwnce("0");
				sizeAgtVo.setRegId(Utils.getUserId());
				sizeAgtVo.setPpfDepthCenterAlwnce("0");				
				sizeAgtVo.setWpCenterAlwnce("0");				
				sizeAgtVo.setWpDeviationAlwnce("0");				
				sizeAgtVo.setX1X2Alwnce("0");
				
				sizeAgtVo.setThEdgeRightAlwnce("0");
				sizeAgtVo.setGapOfLayer("0");
				sizeAgtVo.setBendingAlwnce("0");
				
				
				//해당설비 정보X
				if (redisStringData == null || redisStringData.equals("empty")) {
					logger.info(equipNm + " - 해당설비 측정값 없음");
					agtService.createTime(timeAgtVo);
					agtService.createPressure(pressureAgtVo);
					agtService.createTempature(tempaturAgtVo);
					agtService.createSize(sizeAgtVo);
					
					jsonData.put("message", equipNm + " - 해당설비 측정값 없어 모든 값이 0으로 등록됩니다!");
					jsonData.put("checkCreate", "create");
					jsonData.put("result", "fail");
				
				//해당설비 정보O
				} else {
					logger.info(equipNm + ", 원본 - " + redisStringData);
					//redisStringData = redisStringData.replace("null", ""0"");			//null 값 0으로 치환
					//redisStringData = redisStringData.replace("":""", "":"0"");		//공백 값 0으로 치환
					Gson gson = new Gson();
					RealTimeRedisBomVo realTimeRedisBomVo = gson.fromJson(redisStringData, RealTimeRedisBomVo.class);	//jsonString형식을 Vo에 맞게 변환
					logger.info(equipNm + ", 변환 - " + realTimeRedisBomVo);
					
					//redis에 등록되어있는 시간								//YYYY랑 yyyy랑 다름 주의!
					SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					//Redis 0번 DB는 regDate 사용
					//Redis 1번 DB는 ctime 사용
					//Date readRegDate = datetimeFormat.parse(readRedisAgtBomVo.getRegDate());
					Date readRegDate = datetimeFormat.parse(realTimeRedisBomVo.getCtime());
					
					long readRegDateToMinute = readRegDate.getTime();
					//logger.info("등록시간 가공전 : " + readRedisAgtBomVo.getRegDate());
					//logger.info("등록시간 가공 후: " + readRegDate);
					
					//현재시간
					Date currentDate = new Date();
					//logger.info("현재시간 가공전: " + currentDate);
					currentDate = datetimeFormat.parse(datetimeFormat.format(currentDate));
					//logger.info("현재시간 가공후: " + currentDate);
					long currentDateToMinute = currentDate.getTime();
					long diffMinute = (currentDateToMinute - readRegDateToMinute) / 60000;
					logger.info("현재시간 - 등록시간 = " + diffMinute);
					
					//시간
					for (int i=0; i<realTimeRedisBomVo.getDataSetTimeNm().length; i++) {
						String timeNm = realTimeRedisBomVo.getDataSetTimeNm()[i];
						if (null == timeNm) {
							continue;
						//가접1
						} else if ("gaungchakpresstime".equals(timeNm)) {
							timeAgtVo.setFitupCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//1차 메탈
						} else if ("1stMTheattime".equals(timeNm)) {
							timeAgtVo.setFirstCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//1차 푸셔
						} else if ("1stMTpushtime".equals(timeNm)) {
							timeAgtVo.setPush1Cond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//진접1
						} else if ("jinjubtime".equals(timeNm)) {
							timeAgtVo.setJinjeopCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//2차메탈
						} else if ("2ndMTheattime".equals(timeNm)) {
							timeAgtVo.setSecondCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//냉각
						} else if ("cooltime".equals(timeNm)) {
							timeAgtVo.setCoolCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//진접2 = 리폼
						} else if ("reformtime".equals(timeNm)) {
							timeAgtVo.setJinjeop2Cond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							timeAgtVo.setReformCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						//3차메탈
						} else if ("3rdMTheattime".equals(timeNm)) {
							timeAgtVo.setThirdCond( String.format("%.1f", Float.parseFloat(realTimeRedisBomVo.getDataSetTimeVal()[i]) / 10 ) );
							continue;
						} else {
							continue;
						}
					}
					
					//압력
					for (int i=0; i<realTimeRedisBomVo.getDataSetPrssNm().length; i++) {
						String pressureNm = realTimeRedisBomVo.getDataSetPrssNm()[i];
						if (null == pressureNm) {
							continue;
						//1차 푸셔
						} else if ("IF_Pressure_1ch".equals(pressureNm)) {
							pressureAgtVo.setPush1Cond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						//1차 진접
						} else if ("IF_Pressure_2ch".equals(pressureNm)) {
							pressureAgtVo.setJinjeopCond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						//2차 진접
						} else if ("IF_Pressure_3ch".equals(pressureNm)) {
							pressureAgtVo.setJinjeop2Cond(realTimeRedisBomVo.getDataSetPrssVal()[i]);
							continue;
						} else {
							continue;
						}
					}
					
					//온도
					for (int i=0; i<realTimeRedisBomVo.getDataSetTempNm().length; i++) {
						String tempNm = realTimeRedisBomVo.getDataSetTempNm()[i];
						if (null == tempNm) {
							continue;
						//1차메탈상좌
						} else if ("1stMTUpLeft".equals(tempNm)) {
							tempaturAgtVo.setFirstUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈상우
						} else if ("1stMTUpRight".equals(tempNm)) {
							tempaturAgtVo.setFirstUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈하좌
						} else if ("1stMTDownLeft".equals(tempNm)) {
							tempaturAgtVo.setFirstDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차메탈하우
						} else if ("1stMTDownRight".equals(tempNm)) {
							tempaturAgtVo.setFirstDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접1상
						} else if ("jinjub1Up".equals(tempNm)) {
							tempaturAgtVo.setJinjeop1UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접1하
						} else if ("jinjub1Down".equals(tempNm)) {
							tempaturAgtVo.setJinjeop1DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						
						
						//진접2(2차푸셔)상
						} else if ("2ndPushUp".equals(tempNm)) {
							tempaturAgtVo.setJinjeop2UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//진접2(2차푸셔)하
						} else if ("2ndPushDown".equals(tempNm)) {
							tempaturAgtVo.setJinjeop2DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//가접 상
						} else if ("UpGajub".equals(tempNm)) {
							tempaturAgtVo.setFitup1UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//가접 하
						} else if ("DownGajub".equals(tempNm)) {
							tempaturAgtVo.setFitup1DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//예열(상부메탈예열)
						} else if ("UpMTheat".equals(tempNm)) {
							tempaturAgtVo.setWarmupCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//예열(하부메탈예열)	-> 추후 MES 제조조건 상,하부로 추가예정
						//} else if ("DownMTheat".equals(tempNm)) {
						//	tempaturAgtVo.setWarmupCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
						//	continue;
						
						//2차메탈상좌
						} else if ("2ndMTUpLeft".equals(tempNm)) {
							tempaturAgtVo.setSecondUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈상우
						} else if ("2ndMTUpRight".equals(tempNm)) {
							tempaturAgtVo.setSecondUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈하좌
						} else if ("2ndMTDownLeft".equals(tempNm)) {
							tempaturAgtVo.setSecondDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//2차메탈하우
						} else if ("2ndMTDownRight".equals(tempNm)) {
							tempaturAgtVo.setSecondDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차푸셔상
						} else if ("1stPushUp".equals(tempNm)) {
							tempaturAgtVo.setPush1UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//1차푸셔하
						} else if ("1stPushDown".equals(tempNm)) {
							tempaturAgtVo.setPush1DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈상좌
						} else if ("3rdMTUpLeft".equals(tempNm)) {
							tempaturAgtVo.setThirdUpleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈상우
						} else if ("3rdMTUpRight".equals(tempNm)) {
							tempaturAgtVo.setThirdUprightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈하좌
						} else if ("3rdMTDownLeft".equals(tempNm)) {
							tempaturAgtVo.setThirdDownleftCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
						//3차메탈하우
						} else if ("3rdMTDownRight".equals(tempNm)) {
							tempaturAgtVo.setThirdDownrightCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
							continue;
							
						//MTP 1공장(싱글)호기에만 존재??
						////진접2상
						//} else if ("Jinjub2U".equals(tempNm)) {
						//	tempaturAgtVo.setJinjeop2UpCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
						//	continue;
						////진접2하
						//} else if ("Jinjub2D".equals(tempNm)) {
						//	tempaturAgtVo.setJinjeop2DownCond(realTimeRedisBomVo.getDataSetTempVal()[i]);
						//	continue;
						} else {
							continue;
						}
					}
					
					
					
					//MTP 2동인 경우 dataSetVisionNm 사용
					if ("002".equals(facotryCode)) {
						//치수
						for (int i=0; i<realTimeRedisBomVo.getDataSetVisionNm().length; i++) {
							String sizeNm = realTimeRedisBomVo.getDataSetVisionNm()[i];
							if (null == sizeNm) {
								continue;
							//WP좌
							} else if ("HeadLength_Left".equals(sizeNm)) {
								sizeAgtVo.setWpLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//Pitch좌
							} else if ("MetalLength_Left".equals(sizeNm)) {
								sizeAgtVo.setPitchLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//PPF날개좌
							} else if ("WingLength_Left".equals(sizeNm)) {
								sizeAgtVo.setPpfWingLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//WP우
							} else if ("HeadLength_Right".equals(sizeNm)) {
								sizeAgtVo.setWpRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//Pitch우
							} else if ("MetalLength_Right".equals(sizeNm)) {
								sizeAgtVo.setPitchRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//PPF날개우
							} else if ("WingLength_Right".equals(sizeNm)) {
								sizeAgtVo.setPpfWingRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//P.P Film 폭 내측 좌
							} else if ("FilmWidth_Left_Inside".equals(sizeNm)) {
								sizeAgtVo.setPpfDepthLeftAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//P.P Film 폭 내측 우
							} else if ("FilmWidth_Right_Inside".equals(sizeNm)) {
								sizeAgtVo.setPpfDepthRightAlwnce(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기좌상높이
							} else if ("FilmDolgi_LeftUp_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기좌상너비
							} else if ("FilmDolgi_LeftUp_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기좌하높이
							} else if ("FilmDolgi_LeftDown_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기좌하너비
							} else if ("FilmDolgi_LeftDown_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기우상높이
							} else if ("FilmDolgi_RightUp_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기우상너비
							} else if ("FilmDolgi_RightUp_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기우하높이
							} else if ("FilmDolgi_RightDown_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//돌기우하너비
							} else if ("FilmDolgi_RightDown_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
								continue;
							//(필름상 + 필름하)/2 = 필름 폭
							} else if ("FilmTotalLength_Up".equals(sizeNm)) {
								for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
									String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
									if ("FilmTotalLength_Down".equals(sizeNm2)) {
										if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j]) != 0) ) {
											sizeAgtVo.setFilmAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
											logger.info("필름 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
											logger.info("필름 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
										}
										break;
									}
								}
								continue;
							//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
							} else if ("MetalWidth_Up".equals(sizeNm)) {
								for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
									String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
									if ("MetalWidth_Down".equals(sizeNm2)) {
										if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j]) != 0) ) {
											sizeAgtVo.setMetalDepthAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
											logger.info("메탈 폭 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
											logger.info("메탈 폭 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
											break;
										}
									}			
								}
								continue;
								
							} else {
								continue;
							}
						}
						
					//솔브레인SLD인 경우 dataSetVisIpcNm 사용
					} else if ("003".equals(facotryCode)) {
						//치수
						for (int i=0; i<realTimeRedisBomVo.getDataSetVisIpcNm().length; i++) {
							String sizeNm = realTimeRedisBomVo.getDataSetVisIpcNm()[i];
							if (null == sizeNm) {
								continue;
							//WP좌
							} else if ("HeadLength_Left".equals(sizeNm)) {
								sizeAgtVo.setWpLeftAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//Pitch좌
							} else if ("MetalLength_Left".equals(sizeNm)) {
								sizeAgtVo.setPitchLeftAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//PPF날개좌
							} else if ("WingLength_Left".equals(sizeNm)) {
								sizeAgtVo.setPpfWingLeftAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//WP우
							} else if ("HeadLength_Right".equals(sizeNm)) {
								sizeAgtVo.setWpRightAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//Pitch우
							} else if ("MetalLength_Right".equals(sizeNm)) {
								sizeAgtVo.setPitchRightAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//PPF날개우
							} else if ("WingLength_Right".equals(sizeNm)) {
								sizeAgtVo.setPpfWingRightAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//P.P Film 폭 내측 좌
							} else if ("FilmWidth_Left_Inside".equals(sizeNm)) {
								sizeAgtVo.setPpfDepthLeftAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//P.P Film 폭 내측 우
							} else if ("FilmWidth_Right_Inside".equals(sizeNm)) {
								sizeAgtVo.setPpfDepthRightAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기좌상높이
							} else if ("FilmDolgi_LeftUp_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftupHeight(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기좌상너비
							} else if ("FilmDolgi_LeftUp_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftupWidth(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기좌하높이
							} else if ("FilmDolgi_LeftDown_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftdownHeight(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기좌하너비
							} else if ("FilmDolgi_LeftDown_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeLeftdownWidth(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기우상높이
							} else if ("FilmDolgi_RightUp_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightupHeight(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기우상너비
							} else if ("FilmDolgi_RightUp_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightupWidth(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기우하높이
							} else if ("FilmDolgi_RightDown_Height".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightdownHeight(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//돌기우하너비
							} else if ("FilmDolgi_RightDown_Width".equals(sizeNm)) {
								sizeAgtVo.setBulgeRightdownWidth(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//film폭(중)
							} else if ("FilmWidth_Middle_Inside".equals(sizeNm)) {
								sizeAgtVo.setPpfDepthCenterAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//Welding part(중)
							} else if ("HeadLength_Middle".equals(sizeNm)) {
								sizeAgtVo.setWpCenterAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//Welding part 좌우편차
							} else if ("HeadLength_Deviation".equals(sizeNm)) {
								sizeAgtVo.setWpDeviationAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//대각선 길이 편차 (X1 - X2)
							} else if ("X1_X2".equals(sizeNm)) {
								sizeAgtVo.setX1X2Alwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							////(필름상 + 필름하)/2 = 필름 폭
							//} else if ("FilmTotalLength_Up".equals(sizeNm)) {
							//	for (int j=0; j<realTimeRedisBomVo.getDataSetVisIpcNm().length; j++) {
							//		String sizeNm2 = realTimeRedisBomVo.getDataSetVisIpcNm()[j];
							//		if ("FilmTotalLength_Down".equals(sizeNm2)) {
							//			if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[j]) != 0) ) {
							//				sizeAgtVo.setFilmAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
							//				logger.info("필름 상 - " + realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
							//				logger.info("필름 하 - " + realTimeRedisBomVo.getDataSetVisIpcVal()[j]);
							//			}
							//			break;
							//		}
							//	}
							//	continue;
							//(필름상 + 필름하)/2 = 필름 폭		-> 2022.5.26 비전장비 업데이트 후 필름 하 0으로 처리
							} else if ("FilmTotalLength_Up".equals(sizeNm)) {
								sizeAgtVo.setFilmAlwnce(realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								logger.info("필름 상 - " + realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
								continue;
							//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
							} else if ("MetalWidth_Up".equals(sizeNm)) {
								for (int j=0; j<realTimeRedisBomVo.getDataSetVisIpcNm().length; j++) {
									String sizeNm2 = realTimeRedisBomVo.getDataSetVisIpcNm()[j];
									if ("MetalWidth_Down".equals(sizeNm2)) {
										if ( (Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[j]) != 0) ) {
											sizeAgtVo.setMetalDepthAlwnce( String.valueOf( ((Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisIpcVal()[j])) / 2) ));	//(필름상 + 필름하)/2 = 필름 폭
											logger.info("메탈 폭 상 - " + realTimeRedisBomVo.getDataSetVisIpcVal()[i]);
											logger.info("메탈 폭 하 - " + realTimeRedisBomVo.getDataSetVisIpcVal()[j]);
											break;
										}
									}			
								}
								continue;
								
							} else {
								continue;
							}
						}
					}
					
					agtService.createTime(timeAgtVo);
					agtService.createPressure(pressureAgtVo);
					agtService.createTempature(tempaturAgtVo);
					agtService.createSize(sizeAgtVo);
					
					if ("001".equals(stepCd)) {
						if(facotryCode.equals("001") || facotryCode.equals("002")) {
							if (diffMinute > 5 ) {
								logger.info("수집시간이 5분 초과된 데이터!");
								jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							} else {
								jsonData.put("message", equipNm + "설비의 초물이 등록되었습니다.");
							}	
						} else if (facotryCode.equals("003")) {
							if (diffMinute > 10 ) {
								logger.info("수집시간이 10분 초과된 데이터!");
								jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 10분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							} else {
								jsonData.put("message", equipNm + "설비의 초물이 등록되었습니다.");
							}
						} else {
							jsonData.put("message", "시스템 오류가 발생했습니다.");
							jsonData.put("result", "error");
							
							return jsonData;
						}
						
						jsonData.put("result", "ok");
						
					} else if ("002".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 중물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
					} else if ("003".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + realTimeRedisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 종물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
					} else {
						jsonData.put("message", "잘못된 초중종물 정보입니다!");
						jsonData.put("result", "fail");
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//에이젼트 치수 데이터 조회
	@RequestMapping(value = "/po/workOrderStepInsertRedis_DB0_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderStepInsertRedis_DB0_F3(String workOrdNo, String ordLotNo, String stepCd, String equipCd, String lotNo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("AGT 초,중물 등록 - " + workOrdNo + ", " + stepCd + ", " + equipCd);
		try {
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrdNo);
			agtVo.setOrdLotNo(ordLotNo);
			agtVo.setStepCd(stepCd);
			agtVo.setLotNo(lotNo);
			
			AgtSixFloorVo agtSixFloorVo = new AgtSixFloorVo();
			agtSixFloorVo.setWorkOrdNo(workOrdNo);
			agtSixFloorVo.setOrdLotNo(ordLotNo);
			agtSixFloorVo.setStepCd(stepCd);
			agtSixFloorVo.setLotNo(lotNo);
			
			//온도,치수 Agt테이블에 이미 등록되어 있는지 확인
			if (agtService.agtCheckSizeSixFloor(agtSixFloorVo) != 0 && agtService.checkTemp(agtVo) != 0) {
				if (stepCd.equals("001")) {
					jsonData.put("message", "이미 등록된 초물이 존재합니다.");
				} else if (stepCd.equals("002")) {
					jsonData.put("message", "이미 등록된 중물이 존재합니다.");
				}
				
				jsonData.put("result", "fail");
				
			} else {
				//등록 진행
				boolean virtualMachine	= false;
				String equipNm			= null;
				String redisStringData	= null;
						
				logger.info("설비코드 ===> : " + equipCd);
				
				//설비 정보 불러오기
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipCd(equipCd);
				equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
				
				equipNm = equipCodeAdmVo.getEquipNm();
				
				//가상설비인 경우 설비명 변경 
				if (equipCodeAdmVo.getEtc1() != null && !"".equals(equipCodeAdmVo.getEtc1())) {
					equipNm = equipCodeAdmVo.getEtc1();
					virtualMachine = true;
				}
				
				//설비이름으로 -> RedisData 조회
				redisStringData = redisData(equipNm);
				
				//가상설비일 경우 equipNm을 다시 원상태(가상설비)로 돌려줌
				if (virtualMachine) {
					equipNm = equipCodeAdmVo.getEquipNm();
				}
				//설비 정보 불러오기
				
				//AgtSixFloorVo[] agtArrayVo= new AgtSixFloorVo[3];	//[0]: tempatur, [1]: time, [2]: size
				AgtSixFloorVo agtAllVo = new AgtSixFloorVo();
				
				//압력 Vo data Name 불러오기
				String redisId	= null;	//현재 레디스 Id(이름) 
				Field[] fields	= agtAllVo.getClass().getDeclaredFields();	//AgtSixFloorVo에 있는 필드명
				Field field		= null;	//필드 접근자를 통합 Vo 동적 data 삽입 역할
				String fieldsId	= null;	//대문자(UpperCase_) 변환 후 비교를 위해 필요한 변수
				String sizeNm2	= null;	//치수문자 담을 변수
				
				//기본정보 세팅
			    agtAllVo.setWorkOrdNo(workOrdNo);
			    agtAllVo.setOrdLotNo(ordLotNo);
			    agtAllVo.setStepCd(stepCd);
			    agtAllVo.setEquipCd(equipNm);
			    agtAllVo.setLotNo(lotNo);
			    agtAllVo.setRegId(Utils.getUserId());
			    
			    for (int k = 0; k < 95; k++) {
					field = agtAllVo.getClass().getDeclaredField(fields[k].getName());
					field.setAccessible(true);
					field.set(agtAllVo, "0");
			    }
			    //기본정보 세팅
				
				
				//해당설비 정보X
				if (redisStringData == null || redisStringData.equals("empty")) {
					logger.info(equipNm + " - 해당설비 측정값 없음");
					
					agtService.agtTempatureSixFloorCreate(agtAllVo);
					agtService.agtTimeSixFloorCreate(agtAllVo);
					agtService.agtSizeSixFloorCreate(agtAllVo);
					 					
					jsonData.put("message", equipNm + " - 해당설비 측정값 없어 모든 값이 0으로 등록됩니다!");
					jsonData.put("checkCreate", "create");
					jsonData.put("result", "fail");
				
				//해당설비 정보O
				} else {
					logger.info(equipNm + ", 원본 - " + redisStringData);
					Gson gson = new Gson();
					RealTimeRedisBomVo redisBomVo = gson.fromJson(redisStringData, RealTimeRedisBomVo.class);	//jsonString형식을 Vo에 맞게 변환
					logger.info(equipNm + ", 변환 - " + redisBomVo);
					
					//redis에 등록되어있는 시간								//YYYY랑 yyyy랑 다름 주의!
					SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					//Redis 0번 DB는 regDate 사용
					//Redis 1번 DB는 ctime 사용
					Date readRegDate = datetimeFormat.parse(redisBomVo.getCtime());
					
					long readRegDateToMinute = readRegDate.getTime();
					//logger.info("등록시간 가공전 : " + readRedisAgtBomVo.getRegDate());
					//logger.info("등록시간 가공 후: " + readRegDate);
					
					//현재시간
					Date currentDate	= new Date();
					currentDate			= datetimeFormat.parse(datetimeFormat.format(currentDate));
						
					long currentDateToMinute	= currentDate.getTime();
					long diffMinute				= (currentDateToMinute - readRegDateToMinute) / 60000;
					
					logger.info("현재시간 - 등록시간 = " + diffMinute);
					
					
					
					//온도
					for (int i=0; i<redisBomVo.getDataSetTempNm().length; i++) {
						redisId = String.valueOf( redisBomVo.getDataSetTempNm()[i] ).toUpperCase();	//대문자로 변경
						
						//온도(tempature)데이터 담아주기 ( 전체 AgtSixFloorVo에서 0~45까지가 온도 관련 Vo임 )
						for (int k = 0; k < 45; k++) {
							fieldsId = fields[k].getName().toUpperCase();	//대문자로 변경 후 데이터 담아주기
							
						    if ( redisId != null && fieldsId.equals(redisId)) {
								
								//데이터 담아주기
								field = agtAllVo.getClass().getDeclaredField(fields[k].getName());	//원래 Vo에 있는 데이터로 호츌 진행
								field.setAccessible(true);												//private 접근 허용
								field.set(agtAllVo, redisBomVo.getDataSetTempVal()[i]);			//원래 담겨있는 데이터로 담아주기
							}
						}
						//온도(tempature)데이터 담아주기
					}
					
					
					//시간
					for (int i=0; i<redisBomVo.getDataSetTimeNm().length; i++) {
						redisId = String.valueOf( redisBomVo.getDataSetTimeNm()[i] ).toUpperCase();	//대문자로 변경
						
						redisId = redisId.replaceFirst("1", "ONE");
						redisId = redisId.replaceFirst("2", "TWO");
						redisId = redisId.replaceFirst("3", "THREE");
						
						//시간(time)데이터 담아주기 ( 전체 AgtSixFloorVo에서 45~61까지가 온도 관련 Vo임 )
						for (int k = 45; k < 61; k++) {
							fieldsId = fields[k].getName().toUpperCase();
							
						    if ( redisId != null && fieldsId.equals(redisId)) {
								
								field = agtAllVo.getClass().getDeclaredField(fields[k].getName());
								field.setAccessible(true);
								field.set(agtAllVo, redisBomVo.getDataSetTimeVal()[i]);
							}
						}
						//시간(time)데이터 담아주기
					}
					//logger.info("agtAllVo : " +agtAllVo);
					//logger.info("agtArrayVo 끝");
					
					//솔브레인SLD인 경우 dataSetVisIpcNm 사용
					//치수 
					for (int i=0; i<redisBomVo.getDataSetVisIpcNm().length; i++) {
						String sizeNm = redisBomVo.getDataSetVisIpcNm()[i];
						
						//logger.info("Nm : " + sizeNm);
						//logger.info("values : " + redisBomVo.getDataSetVisIpcVal()[i]);
						
						if ( null == sizeNm || "".equals(redisBomVo.getDataSetVisIpcVal()[i]) ) {
						//WP좌
						} else if ("HeadLength_Left".equals(sizeNm)) {
							agtAllVo.setWpLeftAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//Pitch좌
						} else if ("MetalLength_Left".equals(sizeNm)) {
							agtAllVo.setPitchLeftAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//PPF날개좌
						} else if ("WingLength_Left".equals(sizeNm)) {
							agtAllVo.setPpfWingLeftAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//WP우
						} else if ("HeadLength_Right".equals(sizeNm)) {
							agtAllVo.setWpRightAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//Pitch우
						} else if ("MetalLength_Right".equals(sizeNm)) {
							agtAllVo.setPitchRightAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//PPF날개우
						} else if ("WingLength_Right".equals(sizeNm)) {
							agtAllVo.setPpfWingRightAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//P.P Film 폭 내측 좌
						} else if ("FilmWidth_Left_Inside".equals(sizeNm)) {
							agtAllVo.setPpfDepthLeftAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//P.P Film 폭 내측 우
						} else if ("FilmWidth_Right_Inside".equals(sizeNm)) {
							agtAllVo.setPpfDepthRightAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기좌상높이
						} else if ("FilmDolgi_LeftUp_Height".equals(sizeNm)) {
							agtAllVo.setBulgeLeftupHeight(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기좌상너비
						} else if ("FilmDolgi_LeftUp_Width".equals(sizeNm)) {
							agtAllVo.setBulgeLeftupWidth(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기좌하높이
						} else if ("FilmDolgi_LeftDown_Height".equals(sizeNm)) {
							agtAllVo.setBulgeLeftdownHeight(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기좌하너비
						} else if ("FilmDolgi_LeftDown_Width".equals(sizeNm)) {
							agtAllVo.setBulgeLeftdownWidth(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기우상높이
						} else if ("FilmDolgi_RightUp_Height".equals(sizeNm)) {
							agtAllVo.setBulgeRightupHeight(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기우상너비
						} else if ("FilmDolgi_RightUp_Width".equals(sizeNm)) {
							agtAllVo.setBulgeRightupWidth(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기우하높이
						} else if ("FilmDolgi_RightDown_Height".equals(sizeNm)) {
							agtAllVo.setBulgeRightdownHeight(redisBomVo.getDataSetVisIpcVal()[i]);
						//돌기우하너비
						} else if ("FilmDolgi_RightDown_Width".equals(sizeNm)) {
							agtAllVo.setBulgeRightdownWidth(redisBomVo.getDataSetVisIpcVal()[i]);
						//film폭(중)
						} else if ("FilmWidth_Middle_Inside".equals(sizeNm)) {
							agtAllVo.setPpfDepthCenterAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//Welding part(중)
						} else if ("HeadLength_Middle".equals(sizeNm)) {
							agtAllVo.setWpCenterAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//Welding part 좌우편차
						} else if ("HeadLength_Deviation".equals(sizeNm)) {
							agtAllVo.setWpDeviationAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						//대각선 길이 편차 (X1 - X2)
						} else if ("X1_X2".equals(sizeNm)) {
							agtAllVo.setX1X2Alwnce(redisBomVo.getDataSetVisIpcVal()[i]);
						} else if ("FilmTotalLength_Up".equals(sizeNm)) {
							agtAllVo.setFilmAlwnce(redisBomVo.getDataSetVisIpcVal()[i]);
							logger.info("필름 상 - " + redisBomVo.getDataSetVisIpcVal()[i]);
						//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
						} else if ("MetalWidth_Up".equals(sizeNm)) {
							for (int j=0; j<redisBomVo.getDataSetVisIpcNm().length; j++) {
								sizeNm2 = redisBomVo.getDataSetVisIpcNm()[j];
								if ("MetalWidth_Down".equals(sizeNm2)) {
									String tempA = redisBomVo.getDataSetVisIpcVal()[i];
									String tempB = redisBomVo.getDataSetVisIpcVal()[j];
									
									Double dA = Double.parseDouble(tempA = (tempA == null || "".equals(tempA)) ?  "0.0" : tempA);
									Double dB = Double.parseDouble(tempB = (tempB == null || "".equals(tempB)) ?  "0.0" : tempB);
									
									if ( (dA + dB) != 0 ) {
										agtAllVo.setMetalDepthAlwnce( String.valueOf( (dA+dB)/2 ) );	//(필름상 + 필름하)/2 = 필름 폭
										logger.info("메탈 폭 상 - " + redisBomVo.getDataSetVisIpcVal()[i]);
										logger.info("메탈 폭 하 - " + redisBomVo.getDataSetVisIpcVal()[j]);
										break;
									}
								}			
							}
						} else {
							continue;
						}
					}
					
					
					agtService.agtTempatureSixFloorCreate(agtAllVo);
					agtService.agtTimeSixFloorCreate(agtAllVo);
					agtService.agtSizeSixFloorCreate(agtAllVo);
					
					
					
					if ("001".equals(stepCd)) {
						if (diffMinute > 10 ) {
							logger.info("수집시간이 10분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 10분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + redisBomVo.getCtime());
						} else {
							jsonData.put("message", equipNm + "설비의 초물이 등록되었습니다.");
						}
						jsonData.put("result", "ok");
						
					} else if ("002".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + redisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 중물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
						
					} else if ("003".equals(stepCd)) {
						if (diffMinute > 5 ) {
							logger.info("수집시간이 5분 초과된 데이터!");
							jsonData.put("message", equipNm + " - 해당 설비의 최근 측정정보가 5분이상 경과되었습니다!<br>비전 에이전트를 확인해주세요!<br>가장 최근 측정정보를 가져옵니다! - " + redisBomVo.getCtime());
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", equipNm + "설비의 종물이 등록되었습니다.");
							jsonData.put("result", "ok");
						}
						
					} else {
						jsonData.put("message", "잘못된 초중종물 정보입니다!");
						jsonData.put("result", "fail");
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	public String redisData(String equipNm) {
    	String redisAgtData = "emtpy";
    	try {
	    	if (equipNm == null || equipNm.equals("")) {
	    		
	    	} else {
				JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
				//JedisPool pool = new JedisPool(jedisPoolConfig, "220.90.132.250", 6379, 1000);
				//JedisPool pool = new JedisPool(jedisPoolConfig, "192.168.231.97", 6379, 1000);
				//13379
				
				//JedisPool pool = new JedisPool(jedisPoolConfig, dgsRedisIP, 6379, 1000);
				JedisPool pool = new JedisPool(jedisPoolConfig, dgsRedisIP, 6379, 1000);
				
				//Jedis풀 생성(JedisPoolConfig, host, port, timeout, password)
				Jedis jedis = pool.getResource();//thread, db pool처럼 필요할 때마다 getResource()로 받아서 쓰고 다 쓰면 close로 닫아야 한다.
				//jedis.auth("비밀번호");
				
				jedis.select(0);		//DB 선택
				//jedis.select(1);		//DB 선택
				
				redisAgtData = jedis.get(equipNm);
				if(jedis != null) {
					jedis.close();
				}
				
				pool.close();
	    	}
		} catch (Exception e) {
			logger.info("pop 모니터링 Redis 에러");
			e.printStackTrace();
		}
    	
    	return redisAgtData;
	}
	
}