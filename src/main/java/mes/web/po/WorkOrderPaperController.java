package mes.web.po;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jxls.area.Area;
import org.jxls.builder.AreaBuilder;
import org.jxls.builder.xls.XlsCommentAreaBuilder;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.expression.JexlExpressionEvaluator;
import org.jxls.transform.poi.PoiTransformer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.em.AgtSizeStep;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.EquipSizeCondStepVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.GoodsFaultyAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.po.EquipSizeCondStepService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.web.tm.InventoryAdmController;
import mes.web.ut.DateUtil;

@Controller
public class WorkOrderPaperController {
	
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;
	@Inject
	private EquipSizeCondStepService equipSizeCondStepService;
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;

	@Value("${factoryCode}") private String facotryCode;
	@Value("${workOrderDir}") private String workOrderDir;

	private static final Logger logger = LoggerFactory.getLogger(InventoryAdmController.class);
	
	//작업지시 엑셀다운
	@RequestMapping(value = "/po/workOrdExcelDown", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdExcelDown(WorkOrderVo workOrderVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MatrlCodeAdmVo 			matrlCodeAdmVo 				= new MatrlCodeAdmVo();
			MatrlCodeAdmVo 			filmVo 						= new MatrlCodeAdmVo();
			EquipTempaturCondAdm	equipTempaturCondSeq 		= new EquipTempaturCondAdm();
			EquipTempaturCondAdm	tempaturEquipCondBomAdmVo 	= new EquipTempaturCondAdm();
			EquipCondBomAdmVo 		equipTimeCondSeq 			= new EquipCondBomAdmVo();
			EquipCondBomAdmVo 		timeEquipCondBomAdmVo 		= new EquipCondBomAdmVo();
			EquipCondBomAdmVo 		pressureEquipCondBomAdmVo 	= new EquipCondBomAdmVo();
			WorkOrdOutputSubVo 		workOrdOutputSubVo 			= new WorkOrdOutputSubVo();
			GoodsFaultyAdmVo		goodsFaultyAdmVo 			= new GoodsFaultyAdmVo();	//외관검사 코드화Vo
			
			WorkOrderVo readWork = new WorkOrderVo();
			logger.info("workOrderVo : " + workOrderVo);
			
			String workOrdNo = workOrderVo.getWorkOrdNo();						//작지번호
			String workOrdLotNo = workOrderVo.getWorkOrdLotNo();				//생산LotNo
			//String workOrdSubOrdLotNo = workOrderVo.getWorkOrdSubOrdLotNo();	//생산전표번호
			String workOrdSubLotNo = workOrderVo.getWorkOrdSubLotNo();			//주자재LotNo
			
			//자재 관련
			matrlCodeAdmVo.setMatrlCd(workOrderVo.getAlnicuMatrlCd());
			matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);
			
			//표면처리
			//면취 유/무 설정
			if ( matrlCodeAdmVo.getChamferYnCd().equals("Y") ) {
				matrlCodeAdmVo.setChamferY("■");
				//matrlCodeAdmVo.setChamferN("");
			} else {
				//matrlCodeAdmVo.setChamferY("");
				matrlCodeAdmVo.setChamferN("□");
			}
			
			filmVo.setMatrlCd(workOrderVo.getFilmMatrlCd());
			filmVo 		=  matrlCodeAdmService.read(filmVo);
			readWork 	= workOrderService.read(workOrderVo);
			workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			//workOrdOutputSubVo.setOrdLotNo(workOrdSubOrdLotNo);
			List<WorkOrdOutputSubVo> outputSubList = workOrdOutputSubService.workOrdOutputSubList(workOrdOutputSubVo);
			
			String[] outputUserNmList = new String[10];
			
			for (int i = 0; i < outputSubList.size(); i++) {
				if (i == 0) {
					workOrderVo.setOrdLotNo(outputSubList.get(0).getOrdLotNo()); //생산실적 ordLotNo
					//readWork.setOutputCount1(Integer.parseInt(outputSubList.get(0).getOutputCnt()));
					//readWork.setOutputWeight1(outputSubList.get(0).getOutputWeight());
				}
				if (i == 1) {
					//readWork.setOutputCount2(Integer.parseInt(outputSubList.get(1).getOutputCnt()));
					//readWork.setOutputWeight2(outputSubList.get(1).getOutputWeight());
				}
				if (i == 2) {
					//readWork.setOutputCount3(Integer.parseInt(outputSubList.get(2).getOutputCnt()));
					//readWork.setOutputWeight3(outputSubList.get(2).getOutputWeight());
				}
				if (i == 3) {
					//readWork.setOutputCount4(Integer.parseInt(outputSubList.get(3).getOutputCnt()));
					//readWork.setOutputWeight4(outputSubList.get(3).getOutputWeight());
				}
				outputUserNmList[i] =  outputSubList.get(i).getUserNm();
			}
			
			//생산 작업자명 중복제거
			String outputUserNm = null;
			for (int kk=0; kk<outputUserNmList.length; kk++) {
				if (outputUserNmList[kk] == null) {
					continue;
				} else {
					if (outputUserNm == null) {
						outputUserNm = outputUserNmList[kk];
					} else {
						if (outputUserNm.contains(outputUserNmList[kk])) {
							continue;
						} else {
							outputUserNm += "/" + outputUserNmList[kk];
						}
					}
				}
			}
			 
			String inspctChargerNm = null;
			String inspctDate = null;
			
			
			
			logger.info("outputUserNmList 값  확인 --------------> "+outputSubList);
			logger.info("outputUserNmList 사이즈 확인 --------------> "+outputSubList.size());
			
			
			if ("001".equals(facotryCode)) {
				
			} else if ("002".equals(facotryCode) || "003".equals(facotryCode)) {
				//검사작업일지 검사자&검사일자 세팅
				/*if (inspctChargerNm == null) {
					inspctChargerNm = outputSubList.get(0).getEdgeInspctChargerNm();
					inspctDate = outputSubList.get(0).getEdgeInspctDate();
				}
				if (inspctChargerNm == null) {
					inspctChargerNm = outputSubList.get(0).getAppearInspctChargerNm();
					inspctDate = outputSubList.get(0).getAppearInspctDate();
				}
				inspctDate = inspctDate.substring(0, 4) + "-" + inspctDate.substring(4, 6) + "-" + inspctDate.substring(6, 8);
				*/
				
				String edgeName		= null;
				String appearName	= null;
				//중복제거
				for (int kk=0; kk<outputSubList.size(); kk++) {
					
					//엣지검사 값 담아주기
					if ( outputSubList.get(kk).getEdgeInspctChargerNm() != null && !outputSubList.get(kk).getEdgeInspctChargerNm().equals("") ) {
						
						if(edgeName == null) {
							edgeName = outputSubList.get(kk).getEdgeInspctChargerNm();
						} else {
							
							if ( edgeName.contains(outputSubList.get(kk).getEdgeInspctChargerNm()) ) {
								continue;
							} else {
								edgeName = edgeName + ", " + outputSubList.get(kk).getEdgeInspctChargerNm();
							}
						}
						
						inspctDate 	= outputSubList.get(kk).getEdgeInspctDate();
					}
					
					//외관검사자 값 담아주기
					if ( outputSubList.get(kk).getAppearInspctChargerNm() != null && !outputSubList.get(kk).getAppearInspctChargerNm().equals("") ) {
						
						if(appearName == null) {
							appearName = outputSubList.get(kk).getAppearInspctChargerNm();
						} else {
							
							if ( appearName.contains(outputSubList.get(kk).getAppearInspctChargerNm()) ) {
								continue;
							} else {
								appearName = appearName + ", " + outputSubList.get(kk).getAppearInspctChargerNm();
							}
						}
						
						inspctDate 	= outputSubList.get(kk).getAppearInspctDate();
					}
				}
				inspctChargerNm = edgeName + "/" + appearName;
				inspctDate = inspctDate.substring(0, 4) + "-" + inspctDate.substring(4, 6) + "-" + inspctDate.substring(6, 8);
				
			} else {
				jsonData.put("message", "시스템 오류가 발생하였습니다.");
				jsonData.put("result", "error");
				return jsonData;
			}
			
			
			logger.info("inspctChargerNm 값 확인 --------------> "+inspctChargerNm);
	
			//생산실적 리스트를 가져와 그 중 비전엣지검사 합계를 구함
			List<WorkOrdOutputSubVo> workOrdOutputSubList = workOrdOutputSubService.workOrdOutputSubList(workOrdOutputSubVo);
			int visionEdgeCntSum 	= 0;
			int totalOutputSum 		= 0;		//비전엣지검사수량 + 생산수량 = 종합수량
			int goodsCntSum 		= 0;		//외관양품수량(포장가능 수량)
			int totalFaultyCnt		= 0;
			for (WorkOrdOutputSubVo m : workOrdOutputSubList) {
				visionEdgeCntSum 	+= m.getVisionEdgeCnt();
				totalOutputSum 		+= m.getVisionEdgeCnt();
				totalOutputSum 		+= m.getOutputCnt();
				goodsCntSum 		+= m.getAppearOutputCnt();
				totalFaultyCnt		+= m.getAppearFaultyCnt();
			}
			//int totalFaultyCnt = totalOutputSum - goodsCntSum - visionEdgeCntSum;
			
			GoodsFaultyAdmVo sumFaultyType = new GoodsFaultyAdmVo();
			sumFaultyType.setWorkOrdNo(workOrdNo);
			sumFaultyType = workOrdOutputSubService.sumFaultyType(sumFaultyType);
			int finallOutputCnt = sumFaultyType.getEdgeFaultySum001() + totalFaultyCnt + goodsCntSum;	//검사작업일지 최종수량 = 엣지불량재검 + 외관불량합계 + 외관양품
			
			//시작시간이 없으면 공백으로 표시
			//NULL일경우 비교자체가안됨 수정하기 각종 예외처리 넣기!
			if (readWork.getWorkStartTime().toString().substring(0,16) != null ) {
				readWork.setWorkStartTime(	readWork.getWorkStartTime().toString().substring(0,16)	);	//yyyy-mm-dd hh:mm 형식
			} else {
			
			}
			//각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!각종 예외처리 넣기!
			workOrderVo.setOrdDate(DateUtil.getToday("yyyy-mm-dd"));
	
			//생산실적1가 0이면 0으로 세팅 & 수량 계산
			if (readWork.getOutputWeight1() != null) {
				//readWork.setOutputCount1((int)(Float.parseFloat(readWork.getOutputWeight1())/Float.parseFloat(readWork.getGravity())*1000));
			} else {
				readWork.setOutputCount1(0);
			}
			//생산실적2가 0이면 0으로 세팅 & 수량 계산
			if (readWork.getOutputWeight2() != null) {
				//readWork.setOutputCount2((int)(Float.parseFloat(readWork.getOutputWeight2())/Float.parseFloat(readWork.getGravity())*1000));
			} else {
				readWork.setOutputCount2(0);
			}
			//생산실적3가 0이면 0으로 세팅 & 수량 계산
			if (readWork.getOutputWeight3() != null) {
				//readWork.setOutputCount3((int)(Float.parseFloat(readWork.getOutputWeight3())/Float.parseFloat(readWork.getGravity())*1000));
			} else {
				readWork.setOutputCount3(0);
			}
			//생산실적4가 0이면 0으로 세팅 & 수량 계산
			if (readWork.getOutputWeight4() != null) {
				//readWork.setOutputCount4((int)(Float.parseFloat(readWork.getOutputWeight4())/Float.parseFloat(readWork.getGravity())*1000));
			} else {
				readWork.setOutputCount4(0);
			}
			
			//온도
			equipTempaturCondSeq.setEquipCondSeq(workOrderVo.getEquipCondSeq());
			tempaturEquipCondBomAdmVo = equipCondBomAdmService.tempaturRead(equipTempaturCondSeq);
			
			//시간, 압력
			equipTimeCondSeq.setEquipCondSeq(workOrderVo.getEquipCondSeq());
			timeEquipCondBomAdmVo = equipCondBomAdmService.timeRead(equipTimeCondSeq);
			pressureEquipCondBomAdmVo = equipCondBomAdmService.pressureRead(equipTimeCondSeq);	 
			
			//작업 전 읽어보기!!
			//공차(+,-) 가 같으면 Plus에다가 ± 붙여서 Plus 만 출력 -> 어차피 같으니,
			//공차(+,-) 가 다르면 Plus에다가  +, /- 붙여서  Plus 만 출력
			// + "℃"
	
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 예열
			if(tempaturEquipCondBomAdmVo.getWarmupAlwncePlus().equals(tempaturEquipCondBomAdmVo.getWarmupAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setWarmupAlwncePlus("±" + tempaturEquipCondBomAdmVo.getWarmupAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setWarmupAlwncePlus("+" + tempaturEquipCondBomAdmVo.getWarmupAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getWarmupAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 가접1 상
			if(tempaturEquipCondBomAdmVo.getFitup1UpAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup1UpAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup1UpAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup1UpAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup1UpAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup1UpAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup1UpAlwnceMinus());
			}
			//온도 가접2 하
			if(tempaturEquipCondBomAdmVo.getFitup1DownAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup1DownAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup1DownAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup1DownAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup1DownAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup1DownAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup1DownAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 푸셔1 상
			if(tempaturEquipCondBomAdmVo.getPush1UpAlwncePlus().equals(tempaturEquipCondBomAdmVo.getPush1UpAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setPush1UpAlwncePlus("±" + tempaturEquipCondBomAdmVo.getPush1UpAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setPush1UpAlwncePlus("+" + tempaturEquipCondBomAdmVo.getPush1UpAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getPush1UpAlwnceMinus());
			}
			//온도 푸셔1 하
			if(tempaturEquipCondBomAdmVo.getPush1DownAlwncePlus().equals(tempaturEquipCondBomAdmVo.getPush1DownAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setPush1DownAlwncePlus("±" + tempaturEquipCondBomAdmVo.getPush1DownAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setPush1DownAlwncePlus("+" + tempaturEquipCondBomAdmVo.getPush1DownAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getPush1DownAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 가접2 상좌
			if(tempaturEquipCondBomAdmVo.getFitup2UpleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup2UpleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup2UpleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup2UpleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup2UpleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup2UpleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup2UpleftAlwnceMinus());
			}
			//온도 가접2 하좌
			if(tempaturEquipCondBomAdmVo.getFitup2DownleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup2DownleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup2DownleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup2DownleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup2DownleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup2DownleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup2DownleftAlwnceMinus());
			}
			//온도 가접2 상우
			if(tempaturEquipCondBomAdmVo.getFitup2UprightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup2UprightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup2UprightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup2UprightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup2UprightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup2UprightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup2UprightAlwnceMinus());
			}
			//온도 가접2 하우
			if(tempaturEquipCondBomAdmVo.getFitup2DownrightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFitup2DownrightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFitup2DownrightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFitup2DownrightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFitup2DownrightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFitup2DownrightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFitup2DownrightAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 롤히트 상
			if(tempaturEquipCondBomAdmVo.getRollheatUpAlwncePlus().equals(tempaturEquipCondBomAdmVo.getRollheatUpAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setRollheatUpAlwncePlus("±" + tempaturEquipCondBomAdmVo.getRollheatUpAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setRollheatUpAlwncePlus("+" + tempaturEquipCondBomAdmVo.getRollheatUpAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getRollheatUpAlwnceMinus());
			}
			//온도 롤히트 하
			if(tempaturEquipCondBomAdmVo.getRollheatDownAlwncePlus().equals(tempaturEquipCondBomAdmVo.getRollheatDownAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setRollheatDownAlwncePlus("±" + tempaturEquipCondBomAdmVo.getRollheatDownAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setRollheatDownAlwncePlus("+" + tempaturEquipCondBomAdmVo.getRollheatDownAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getRollheatDownAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 1차 상좌
			if(tempaturEquipCondBomAdmVo.getFirstUpleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFirstUpleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFirstUpleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFirstUpleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFirstUpleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFirstUpleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFirstUpleftAlwnceMinus());
			}
			//온도 1차 하좌
			if(tempaturEquipCondBomAdmVo.getFirstDownleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFirstDownleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFirstDownleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFirstDownleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFirstDownleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFirstDownleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFirstDownleftAlwnceMinus());
			}
			//온도 1차 상우
			if(tempaturEquipCondBomAdmVo.getFirstUprightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFirstUprightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFirstUprightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFirstUprightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFirstUprightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFirstUprightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFirstUprightAlwnceMinus());
			}
			//온도 1차 하우
			if(tempaturEquipCondBomAdmVo.getFirstDownrightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getFirstDownrightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setFirstDownrightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getFirstDownrightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setFirstDownrightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getFirstDownrightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getFirstDownrightAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 2차 상좌
			if(tempaturEquipCondBomAdmVo.getSecondUpleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getSecondUpleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setSecondUpleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getSecondUpleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setSecondUpleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getSecondUpleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getSecondUpleftAlwnceMinus());
			}
			//온도 2차 하좌
			if(tempaturEquipCondBomAdmVo.getSecondDownleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getSecondDownleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setSecondDownleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getSecondDownleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setSecondDownleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getSecondDownleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getSecondDownleftAlwnceMinus());
			}
			//온도 2차 상우
			if(tempaturEquipCondBomAdmVo.getSecondUprightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getSecondUprightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setSecondUprightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getSecondUprightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setSecondUprightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getSecondUprightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getSecondUprightAlwnceMinus());
			}
			//온도 2차 하우
			if(tempaturEquipCondBomAdmVo.getSecondDownrightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getSecondDownrightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setSecondDownrightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getSecondDownrightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setSecondDownrightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getSecondDownrightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getSecondDownrightAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 3차 상좌
			if(tempaturEquipCondBomAdmVo.getThirdUpleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getThirdUpleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setThirdUpleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getThirdUpleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setThirdUpleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getThirdUpleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getThirdUpleftAlwnceMinus());
			}
			//온도 3차 하좌
			if(tempaturEquipCondBomAdmVo.getThirdDownleftAlwncePlus().equals(tempaturEquipCondBomAdmVo.getThirdDownleftAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setThirdDownleftAlwncePlus("±" + tempaturEquipCondBomAdmVo.getThirdDownleftAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setThirdDownleftAlwncePlus("+" + tempaturEquipCondBomAdmVo.getThirdDownleftAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getThirdDownleftAlwnceMinus());
			}
			//온도 3차 상우
			if(tempaturEquipCondBomAdmVo.getThirdUprightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getThirdUprightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setThirdUprightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getThirdUprightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setThirdUprightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getThirdUprightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getThirdUprightAlwnceMinus());
			}
			//온도 3차 하우
			if(tempaturEquipCondBomAdmVo.getThirdDownrightAlwncePlus().equals(tempaturEquipCondBomAdmVo.getThirdDownrightAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setThirdDownrightAlwncePlus("±" + tempaturEquipCondBomAdmVo.getThirdDownrightAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setThirdDownrightAlwncePlus("+" + tempaturEquipCondBomAdmVo.getThirdDownrightAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getThirdDownrightAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 진접1 상
			if(tempaturEquipCondBomAdmVo.getJinjeop1UpAlwncePlus().equals(tempaturEquipCondBomAdmVo.getJinjeop1UpAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setJinjeop1UpAlwncePlus("±" + tempaturEquipCondBomAdmVo.getJinjeop1UpAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setJinjeop1UpAlwncePlus("+" + tempaturEquipCondBomAdmVo.getJinjeop1UpAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getJinjeop1UpAlwnceMinus());
			}
			//온도 진접1 하
			if(tempaturEquipCondBomAdmVo.getJinjeop1DownAlwncePlus().equals(tempaturEquipCondBomAdmVo.getJinjeop1DownAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setJinjeop1DownAlwncePlus("±" + tempaturEquipCondBomAdmVo.getJinjeop1DownAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setJinjeop1DownAlwncePlus("+" + tempaturEquipCondBomAdmVo.getJinjeop1DownAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getJinjeop1DownAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//온도 진접2 상
			if(tempaturEquipCondBomAdmVo.getJinjeop2UpAlwncePlus().equals(tempaturEquipCondBomAdmVo.getJinjeop2UpAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setJinjeop2UpAlwncePlus("±" + tempaturEquipCondBomAdmVo.getJinjeop2UpAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setJinjeop2UpAlwncePlus("+" + tempaturEquipCondBomAdmVo.getJinjeop2UpAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getJinjeop2UpAlwnceMinus());
			}
			//온도 진접2 하
			if(tempaturEquipCondBomAdmVo.getJinjeop2DownAlwncePlus().equals(tempaturEquipCondBomAdmVo.getJinjeop2DownAlwnceMinus())) {
				  tempaturEquipCondBomAdmVo.setJinjeop2DownAlwncePlus("±" + tempaturEquipCondBomAdmVo.getJinjeop2DownAlwncePlus());	    	  
			} else {
				  tempaturEquipCondBomAdmVo.setJinjeop2DownAlwncePlus("+" + tempaturEquipCondBomAdmVo.getJinjeop2DownAlwncePlus() + " / -" + tempaturEquipCondBomAdmVo.getJinjeop2DownAlwnceMinus());
			}
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			
			
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 가접1
			if(timeEquipCondBomAdmVo.getFitupAlwncePlus().equals(timeEquipCondBomAdmVo.getFitupAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setFitupAlwncePlus("±" + timeEquipCondBomAdmVo.getFitupAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setFitupAlwncePlus("+" + timeEquipCondBomAdmVo.getFitupAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getFitupAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 가접2
			if(timeEquipCondBomAdmVo.getFitup2AlwncePlus().equals(timeEquipCondBomAdmVo.getFitup2AlwnceMinus())) {
				  timeEquipCondBomAdmVo.setFitup2AlwncePlus("±" + timeEquipCondBomAdmVo.getFitup2AlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setFitup2AlwncePlus("+" + timeEquipCondBomAdmVo.getFitup2AlwncePlus() + " / -" + timeEquipCondBomAdmVo.getFitup2AlwnceMinus());
			}
	
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 1차
			if(timeEquipCondBomAdmVo.getFirstAlwncePlus().equals(timeEquipCondBomAdmVo.getFirstAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setFirstAlwncePlus("±" + timeEquipCondBomAdmVo.getFirstAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setFirstAlwncePlus("+" + timeEquipCondBomAdmVo.getFirstAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getFirstAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 2차
			if(timeEquipCondBomAdmVo.getSecondAlwncePlus().equals(timeEquipCondBomAdmVo.getSecondAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setSecondAlwncePlus("±" + timeEquipCondBomAdmVo.getSecondAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setSecondAlwncePlus("+" + timeEquipCondBomAdmVo.getSecondAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getSecondAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 3차
			if(timeEquipCondBomAdmVo.getThirdAlwncePlus().equals(timeEquipCondBomAdmVo.getThirdAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setThirdAlwncePlus("±" + timeEquipCondBomAdmVo.getThirdAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setThirdAlwncePlus("+" + timeEquipCondBomAdmVo.getThirdAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getThirdAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 1차 푸셔
			if(timeEquipCondBomAdmVo.getPush1AlwncePlus().equals(timeEquipCondBomAdmVo.getPush1AlwnceMinus())) {
				  timeEquipCondBomAdmVo.setPush1AlwncePlus("±" + timeEquipCondBomAdmVo.getPush1AlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setPush1AlwncePlus("+" + timeEquipCondBomAdmVo.getPush1AlwncePlus() + " / -" + timeEquipCondBomAdmVo.getPush1AlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 1차 진접
			if(timeEquipCondBomAdmVo.getJinjeopAlwncePlus().equals(timeEquipCondBomAdmVo.getJinjeopAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setJinjeopAlwncePlus("±" + timeEquipCondBomAdmVo.getJinjeopAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setJinjeopAlwncePlus("+" + timeEquipCondBomAdmVo.getJinjeopAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getJinjeopAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 2차 진접
			if(timeEquipCondBomAdmVo.getJinjeop2AlwncePlus().equals(timeEquipCondBomAdmVo.getJinjeop2AlwnceMinus())) {
				  timeEquipCondBomAdmVo.setJinjeop2AlwncePlus("±" + timeEquipCondBomAdmVo.getJinjeop2AlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setJinjeop2AlwncePlus("+" + timeEquipCondBomAdmVo.getJinjeop2AlwncePlus() + " / -" + timeEquipCondBomAdmVo.getJinjeop2AlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 리폼
			if(timeEquipCondBomAdmVo.getReformAlwncePlus().equals(timeEquipCondBomAdmVo.getReformAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setReformAlwncePlus("±" + timeEquipCondBomAdmVo.getReformAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setReformAlwncePlus("+" + timeEquipCondBomAdmVo.getReformAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getReformAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//시간 냉각
			if(timeEquipCondBomAdmVo.getCoolAlwncePlus().equals(timeEquipCondBomAdmVo.getCoolAlwnceMinus())) {
				  timeEquipCondBomAdmVo.setCoolAlwncePlus("±" + timeEquipCondBomAdmVo.getCoolAlwncePlus());
			} else {
				  timeEquipCondBomAdmVo.setCoolAlwncePlus("+" + timeEquipCondBomAdmVo.getCoolAlwncePlus() + " / -" + timeEquipCondBomAdmVo.getCoolAlwnceMinus());
			}
			
			
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//압력 가접
			if(pressureEquipCondBomAdmVo.getFitupAlwncePlus().equals(pressureEquipCondBomAdmVo.getFitupAlwnceMinus())) {
				  pressureEquipCondBomAdmVo.setFitupAlwncePlus("±" + pressureEquipCondBomAdmVo.getFitupAlwncePlus());
			} else {
				  pressureEquipCondBomAdmVo.setFitupAlwncePlus("+" + pressureEquipCondBomAdmVo.getFitupAlwncePlus() + " / -" + pressureEquipCondBomAdmVo.getFitupAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//압력 1차푸셔
			if(pressureEquipCondBomAdmVo.getPush1AlwncePlus().equals(pressureEquipCondBomAdmVo.getPush1AlwnceMinus())) {
				  pressureEquipCondBomAdmVo.setPush1AlwncePlus("±" + pressureEquipCondBomAdmVo.getPush1AlwncePlus());
			} else {
				  pressureEquipCondBomAdmVo.setPush1AlwncePlus("+" + pressureEquipCondBomAdmVo.getPush1AlwncePlus() + " / -" + pressureEquipCondBomAdmVo.getPush1AlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//압력 1차 진접
			if(pressureEquipCondBomAdmVo.getJinjeopAlwncePlus().equals(pressureEquipCondBomAdmVo.getJinjeopAlwnceMinus())) {
				  pressureEquipCondBomAdmVo.setJinjeopAlwncePlus("±" + pressureEquipCondBomAdmVo.getJinjeopAlwncePlus());
			} else {
				  pressureEquipCondBomAdmVo.setJinjeopAlwncePlus("+" + pressureEquipCondBomAdmVo.getJinjeopAlwncePlus() + " / -" + pressureEquipCondBomAdmVo.getJinjeopAlwnceMinus());
			}
			
			/*---------------------------------------------------------------------------------------------------------------------------------------------------*/
			//압력 2차 진접
			if(pressureEquipCondBomAdmVo.getJinjeop2AlwncePlus().equals(pressureEquipCondBomAdmVo.getJinjeop2AlwnceMinus())) {
				  pressureEquipCondBomAdmVo.setJinjeop2AlwncePlus("±" + pressureEquipCondBomAdmVo.getJinjeop2AlwncePlus());
			} else {
				  pressureEquipCondBomAdmVo.setJinjeop2AlwncePlus("+" + pressureEquipCondBomAdmVo.getJinjeop2AlwncePlus() + " / -" + pressureEquipCondBomAdmVo.getJinjeop2AlwnceMinus());
			}
			
	
			/* ---------------------- 초, 중물 조건 읽기 ---------------------- */
			EquipCondBomAdmVo equipCondBomAdmVo = new EquipCondBomAdmVo();
			equipCondBomAdmVo.setEquipCondSeq(readWork.getEquipCondSeq());
			//치수 조건 읽기
			EquipCondBomAdmVo stepCond = new EquipCondBomAdmVo();
			stepCond = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("읽은 치수 정보"+stepCond);
	
			//치수 WP 공차
			if(stepCond.getWpLeftAlwncePlus().equals(stepCond.getWpLeftAlwnceMinus())) {
				stepCond.setWpLeftAlwncePlus("± " + stepCond.getWpLeftAlwnceMinus());	    	  
			} else {
				stepCond.setWpLeftAlwncePlus("+" + stepCond.getWpLeftAlwncePlus() + " / -" + stepCond.getWpLeftAlwnceMinus());
			}
			if(stepCond.getWpRightAlwncePlus().equals(stepCond.getWpRightAlwnceMinus())) {
				stepCond.setWpRightAlwncePlus("± " + stepCond.getWpRightAlwnceMinus());	    	  
			} else {
				stepCond.setWpRightAlwncePlus("+" + stepCond.getWpRightAlwncePlus() + " / -" + stepCond.getWpRightAlwnceMinus());
			}
			if(stepCond.getPitchLeftAlwncePlus().equals(stepCond.getPitchLeftAlwnceMinus())) {
				stepCond.setPitchLeftAlwncePlus("± " + stepCond.getPitchLeftAlwnceMinus());	    	  
			} else {
				stepCond.setPitchLeftAlwncePlus("+" + stepCond.getPitchLeftAlwncePlus() + " / -" + stepCond.getPitchLeftAlwnceMinus());
			}
			if(stepCond.getPitchRightAlwncePlus().equals(stepCond.getPitchRightAlwnceMinus())) {
				stepCond.setPitchRightAlwncePlus("± " + stepCond.getPitchRightAlwnceMinus());	    	  
			} else {
				stepCond.setPitchRightAlwncePlus("+" + stepCond.getPitchRightAlwncePlus() + " / -" + stepCond.getPitchRightAlwnceMinus());
			}
			if(stepCond.getPpfWingLeftAlwncePlus().equals(stepCond.getPpfWingLeftAlwnceMinus())) {
				stepCond.setPpfWingLeftAlwncePlus("± " + stepCond.getPpfWingLeftAlwnceMinus());	    	  
			} else {
				stepCond.setPpfWingLeftAlwncePlus("+" + stepCond.getPpfWingLeftAlwncePlus() + " / -" + stepCond.getPpfWingLeftAlwnceMinus());
			}
			if(stepCond.getPpfWingRightAlwncePlus().equals(stepCond.getPpfWingRightAlwnceMinus())) {
				stepCond.setPpfWingRightAlwncePlus("± " + stepCond.getPpfWingRightAlwnceMinus());	    	  
			} else {
				stepCond.setPpfWingRightAlwncePlus("+" + stepCond.getPpfWingRightAlwncePlus() + " / -" + stepCond.getPpfWingRightAlwnceMinus());
			}
			if(stepCond.getPpfDepthLeftAlwncePlus().equals(stepCond.getPpfDepthLeftAlwnceMinus())) {
				stepCond.setPpfDepthLeftAlwncePlus("± " + stepCond.getPpfDepthLeftAlwnceMinus());	    	  
			} else {
				stepCond.setPpfDepthLeftAlwncePlus("+" + stepCond.getPpfDepthLeftAlwncePlus() + " / -" + stepCond.getPpfDepthLeftAlwnceMinus());
			}
			if(stepCond.getPpfDepthRightAlwncePlus().equals(stepCond.getPpfDepthRightAlwnceMinus())) {
				stepCond.setPpfDepthRightAlwncePlus("± " + stepCond.getPpfDepthRightAlwnceMinus());	    	  
			} else {
				stepCond.setPpfDepthRightAlwncePlus("+" + stepCond.getPpfDepthRightAlwncePlus() + " / -" + stepCond.getPpfDepthRightAlwnceMinus());
			}
			if(stepCond.getFilmAlwncePlus().equals(stepCond.getFilmAlwnceMinus())) {
				stepCond.setFilmAlwncePlus("± " + stepCond.getFilmAlwnceMinus());	    	  
			} else {
				stepCond.setFilmAlwncePlus("+" + stepCond.getFilmAlwncePlus() + " / -" + stepCond.getFilmAlwnceMinus());
			}
			if(stepCond.getMetalDepthAlwncePlus().equals(stepCond.getMetalDepthAlwnceMinus())) {
				stepCond.setMetalDepthAlwncePlus("± " + stepCond.getMetalDepthAlwnceMinus());	    	  
			} else {
				stepCond.setMetalDepthAlwncePlus("+" + stepCond.getMetalDepthAlwncePlus() + " / -" + stepCond.getMetalDepthAlwnceMinus());
			}
			if(stepCond.getMetalThicknessAlwncePlus().equals(stepCond.getMetalThicknessAlwnceMinus())) {
				stepCond.setMetalThicknessAlwncePlus("± " + stepCond.getMetalThicknessAlwnceMinus());	    	  
			} else {
				stepCond.setMetalThicknessAlwncePlus("+" + stepCond.getMetalThicknessAlwncePlus() + " / -" + stepCond.getMetalThicknessAlwnceMinus());
			}
			if(stepCond.getThCenterAlwncePlus().equals(stepCond.getThCenterAlwnceMinus())) {
				stepCond.setThCenterAlwncePlus("± " + stepCond.getThCenterAlwnceMinus());	    	  
			} else {
				stepCond.setThCenterAlwncePlus("+" + stepCond.getThCenterAlwncePlus() + " / -" + stepCond.getThCenterAlwnceMinus());
			}
			if(stepCond.getThEdgeAlwncePlus().equals(stepCond.getThEdgeAlwnceMinus())) {
				stepCond.setThEdgeAlwncePlus("± " + stepCond.getThEdgeAlwnceMinus());	    	  
			} else {
				stepCond.setThEdgeAlwncePlus("+" + stepCond.getThEdgeAlwncePlus() + " / -" + stepCond.getThEdgeAlwnceMinus());
			}
			if(stepCond.getBurrAlwncePlus().equals(stepCond.getBurrAlwnceMinus())) {
				stepCond.setBurrAlwncePlus("± " + stepCond.getBurrAlwnceMinus());	    	  
			} else {
				stepCond.setBurrAlwncePlus("+" + stepCond.getBurrAlwncePlus() + " / -" + stepCond.getBurrAlwnceMinus());
			}
			
			
			/* ------ AGT 초물 ------ */
			//AGT 초물 온도
			EquipTempaturCondAdm firstAgtTempatur = new EquipTempaturCondAdm();
			EquipCondBomAdmVo firstAgtTime = new EquipCondBomAdmVo();
			EquipCondBomAdmVo firstAgtPressure = new EquipCondBomAdmVo();
			EquipTempaturCondAdm secondAgtTempatur = new EquipTempaturCondAdm();
			EquipCondBomAdmVo secondAgtTime = new EquipCondBomAdmVo();
			EquipCondBomAdmVo secondAgtPressure = new EquipCondBomAdmVo();
			AgtSizeStep firstStep = new AgtSizeStep();
			AgtSizeStep secondStep = new AgtSizeStep();
			AgtSizeStep thirdStep_F2 = new AgtSizeStep();
			EquipSizeCondStepVo thirdStep = new EquipSizeCondStepVo();
			
			//firstAgtTempatur.setWorkOrdNo(workOrdNo);
			//firstAgtTempatur.setOrdLotNo(workOrdSubOrdLotNo);
			//firstAgtTempatur.setLotNo(workOrdSubLotNo);
			//firstAgtTempatur.setStepCd("001");
			//firstAgtTempatur = equipCondBomAdmService.agtTempaturRead(firstAgtTempatur);
			//String stepCd = firstAgtTempatur.getStepCd();
			
			
			//if ("001".equals(stepCd)) {
			
				firstAgtTempatur.setWorkOrdNo(workOrdNo);
				//firstAgtTempatur.setOrdLotNo(workOrdSubOrdLotNo);
				firstAgtTempatur.setLotNo(workOrdSubLotNo);
				firstAgtTempatur.setStepCd("001");
				firstAgtTempatur = equipCondBomAdmService.agtTempaturRead(firstAgtTempatur);
			
				//AGT 초물 시간
				firstAgtTime.setWorkOrdNo(workOrdNo);
				//firstAgtTime.setOrdLotNo(workOrdSubOrdLotNo);
				firstAgtTime.setLotNo(workOrdSubLotNo);
				firstAgtTime.setStepCd("001");
				firstAgtTime = equipCondBomAdmService.agtTimeRead(firstAgtTime);
				
				//AGT 초물 압력
				firstAgtPressure.setWorkOrdNo(workOrdNo);
				//firstAgtPressure.setOrdLotNo(workOrdSubOrdLotNo);
				firstAgtPressure.setLotNo(workOrdSubLotNo);
				firstAgtPressure.setStepCd("001");
				firstAgtPressure = equipCondBomAdmService.agtPressureRead(firstAgtPressure);
				
				if ( firstAgtPressure != null ) {
					if ( !"".equals(firstAgtPressure.getWarmupCond()) ) {
						firstAgtPressure.setWarmupCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getWarmupCond()))/1000) );	
					}
					if ( !"".equals(firstAgtPressure.getFitupCond()) ) {
						firstAgtPressure.setFitupCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getFitupCond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getFirstCond()) ) {
						firstAgtPressure.setFirstCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getFirstCond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getPush1Cond()) ) {
						firstAgtPressure.setPush1Cond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getPush1Cond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getSecondCond()) ) {
						firstAgtPressure.setSecondCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getSecondCond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getJinjeopCond()) ) {
						firstAgtPressure.setJinjeopCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getJinjeopCond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getJinjeop2Cond()) ) {
						firstAgtPressure.setJinjeop2Cond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getJinjeop2Cond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getReformCond()) ) {
						firstAgtPressure.setReformCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getReformCond()))/1000) );
					}
					if ( !"".equals(firstAgtPressure.getCoolCond()) ) {
						firstAgtPressure.setCoolCond( String.format("%.2f", (Float.parseFloat(firstAgtPressure.getCoolCond()))/1000) );
					}
				}
				
				//초 Read
				firstStep.setWorkOrdNo(workOrdNo);
				//firstStep.setOrdLotNo(workOrdSubOrdLotNo);
				firstStep.setLotNo(workOrdSubLotNo);
				firstStep.setStepCd("001");
				//firstStep = equipSizeCondStepService.readEquipSizeCondStep(firstStep);
				firstStep = equipCondBomAdmService.agtSizeRead(firstStep);
				
				if ( firstStep == null ) {
					//jsonData.put("result", "fail");
					//jsonData.put("message", "초물을 등록해 주세요.");
					//return jsonData;
				} else {
					firstStep.setRegDate( firstStep.getRegDate().substring(11, 16) );
					//초물 편차부분 계산
					//Null 예외처리
					if ( firstStep != null) {
						//WP, PP폭 편차 계산
						firstStep.setAbsWp( Math.abs( Math.round( (Double.parseDouble(firstStep.getWpLeftAlwnce()) - Double.parseDouble(firstStep.getWpRightAlwnce())) *1000)/1000.0) );
						firstStep.setAbsPpf( Math.abs( Math.round( (Double.parseDouble(firstStep.getPpfDepthLeftAlwnce()) - Double.parseDouble(firstStep.getPpfDepthRightAlwnce())) *1000)/1000.0) );
					}
					logger.info("첫번째 : "+firstStep);
				}
				
			//} else if ("002".equals(stepCd)) {
				/* ------ AGT 중물 ------ */
				//AGT 초물 온도
				secondAgtTempatur.setWorkOrdNo(workOrdNo);
				//secondAgtTempatur.setOrdLotNo(workOrdSubOrdLotNo);
				secondAgtTempatur.setLotNo(workOrdSubLotNo);
				secondAgtTempatur.setStepCd("002");
				secondAgtTempatur = equipCondBomAdmService.agtTempaturRead(secondAgtTempatur);
				
				//AGT 초물 시간
				secondAgtTime.setWorkOrdNo(workOrdNo);
				//secondAgtTime.setOrdLotNo(workOrdSubOrdLotNo);
				secondAgtTime.setLotNo(workOrdSubLotNo);
				secondAgtTime.setStepCd("002");
				secondAgtTime = equipCondBomAdmService.agtTimeRead(secondAgtTime);
				
				//AGT 초물 압력
				secondAgtPressure.setWorkOrdNo(workOrdNo);
				//secondAgtPressure.setOrdLotNo(workOrdSubOrdLotNo);
				secondAgtPressure.setLotNo(workOrdSubLotNo);
				secondAgtPressure.setStepCd("002");
				secondAgtPressure = equipCondBomAdmService.agtPressureRead(secondAgtPressure);
				
				if ( secondAgtPressure != null ) {
					if ( !"".equals(secondAgtPressure.getWarmupCond()) ) {
						secondAgtPressure.setWarmupCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getWarmupCond()))/1000) );	
					}
					if ( !"".equals(secondAgtPressure.getFitupCond()) ) {
						secondAgtPressure.setFitupCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getFitupCond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getFirstCond()) ) {
						secondAgtPressure.setFirstCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getFirstCond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getPush1Cond()) ) {
						secondAgtPressure.setPush1Cond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getPush1Cond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getSecondCond()) ) {
						secondAgtPressure.setSecondCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getSecondCond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getJinjeopCond()) ) {
						secondAgtPressure.setJinjeopCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getJinjeopCond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getJinjeop2Cond()) ) {
						secondAgtPressure.setJinjeop2Cond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getJinjeop2Cond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getReformCond()) ) {
						secondAgtPressure.setReformCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getReformCond()))/1000) );
					}
					if ( !"".equals(secondAgtPressure.getCoolCond()) ) {
						secondAgtPressure.setCoolCond( String.format("%.2f", (Float.parseFloat(secondAgtPressure.getCoolCond()))/1000) );
					}
				}
				
				//중 Read
				secondStep.setWorkOrdNo(workOrdNo);
				//secondStep.setOrdLotNo(workOrdSubOrdLotNo);
				secondStep.setLotNo(workOrdSubLotNo);
				secondStep.setStepCd("002");
				//secondStep = equipSizeCondStepService.readEquipSizeCondStep(secondStep);
				secondStep = equipCondBomAdmService.agtSizeRead(secondStep);
				
				if (secondStep == null) {
					//jsonData.put("result", "fail");
					//jsonData.put("message", "중물을 등록해 주세요.");
					//return jsonData;
				} else {
					secondStep.setRegDate( secondStep.getRegDate().substring(11, 16) );
					//Null 예외처리
					if ( secondStep != null) {
						//WP, PP폭 편차 계산
						secondStep.setAbsWp( Math.abs( Math.round( (Double.parseDouble(secondStep.getWpLeftAlwnce()) - Double.parseDouble(secondStep.getWpRightAlwnce())) *1000)/1000.0) );
						secondStep.setAbsPpf( Math.abs( Math.round( (Double.parseDouble(secondStep.getPpfDepthLeftAlwnce()) - Double.parseDouble(secondStep.getPpfDepthRightAlwnce())) *1000)/1000.0) );
					}
					logger.info("두번째 : "+secondStep);
				}
				
				//MTP 1공장(성남)
				if ("001".equals(facotryCode)) {
					//종물 편차부분 계산
					//종 Read
					//종물일 경우 생산팀에서 필요는없지만 최종본을 볼 경우에는 필요
					//생산실적 입력기준이 주재료로 변경된 후에는 종물검색시에는 생산LotNo(ordLotNo)가 필요함
					thirdStep.setWorkOrdNo(workOrderVo.getWorkOrdNo());
					thirdStep.setLotNo(workOrdSubLotNo);
					thirdStep.setStepCd("003");
					thirdStep = equipSizeCondStepService.readEquipSizeCondStep(thirdStep);
					//Null 예외처리
					if (thirdStep != null) {
						//WP, PP폭 편차 계산
						thirdStep.setAbsWp(Math.abs(Math.round((Double.parseDouble(thirdStep.getWpLeftAlwnce()) - Double.parseDouble(thirdStep.getWpRightAlwnce())) * 1000) / 1000.0));
						thirdStep.setAbsPpf(Math.abs(Math.round((Double.parseDouble(thirdStep.getPpfDepthLeftAlwnce()) - Double.parseDouble(thirdStep.getPpfDepthRightAlwnce())) * 1000) / 1000.0));
					}
					logger.info("세번째 : " + thirdStep);
					
				//MTP 2공장(성남)
				} else if ("002".equals(facotryCode)) {
					//종 Read
					thirdStep_F2.setWorkOrdNo(workOrdNo);
					//thirdStep_F2.setOrdLotNo(workOrdSubOrdLotNo);
					thirdStep_F2.setLotNo(workOrdSubLotNo);
					thirdStep_F2.setStepCd("003");
					//thirdStep_F2 = equipSizeCondStepService.readEquipSizeCondStep(thirdStep_F2);
					thirdStep_F2 = equipCondBomAdmService.agtSizeRead(thirdStep_F2);

					if (thirdStep_F2 == null) {
						//jsonData.put("result", "fail");
						//jsonData.put("message", "중물을 등록해 주세요.");
						//return jsonData;
					} else {
						thirdStep_F2.setRegDate(thirdStep_F2.getRegDate().substring(11, 16));
						//Null 예외처리
						if (thirdStep_F2 != null) {
							//WP, PP폭 편차 계산
							thirdStep_F2.setAbsWp(Math.abs(Math.round((Double.parseDouble(thirdStep_F2.getWpLeftAlwnce()) - Double.parseDouble(thirdStep_F2.getWpRightAlwnce())) * 1000) / 1000.0));
							thirdStep_F2.setAbsPpf(Math.abs(Math.round((Double.parseDouble(thirdStep_F2.getPpfDepthLeftAlwnce()) - Double.parseDouble(thirdStep_F2.getPpfDepthRightAlwnce())) * 1000) / 1000.0));
						}
						logger.info("머티2공장 종물(치수) : " + thirdStep_F2);
					}
				}
				//SLD 3공장(파주)
				// else if ("003".equals(facotryCode)) {
				//}

			/* ---------------------- 초, 중물 조건 끝 ---------------------- */
				
			/* ---------------------- 외관검사 값 읽기 ---------------------- */
				
				/*	원자재 MMS M이 붙음
				 	공정은 PMS P가붙음 */
				goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				List<GoodsFaultyAdmVo> goodsFaultyAdmList = workOrdOutputSubService.excelGoodsFaultyAdmCodeList(goodsFaultyAdmVo);
				
			/* ---------------------- 외관검사 값 읽기 끝 ---------------------- */
			
			/* ---------------------- 작지 주자재4개, 부자재2개 읽기 시작 ---------------------- */
			List<WorkOrderVo> mainMatrlTop4 = workOrderService.workOrderMainMatrlTop4(workOrderVo);	//생산실적을 주자재를 기준으로 변경 후 검색조건에도 주자재 추가하였음
			List<WorkOrderVo> subMatrlTop4 = workOrderService.workOrderSubMatrlTop4(workOrderVo);
			/* ---------------------- 작지 주자재4개, 부자재2개 읽기  끝 ---------------------- */
			
			//종료된 직전작지가 연결된 자재가 있는지 확인
			WorkOrderVo checkConnectLotNo = new WorkOrderVo();
			checkConnectLotNo.setEquipCd(workOrderVo.getEquipCd());
			checkConnectLotNo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			checkConnectLotNo.setWorkOrdLotNo(workOrderVo.getWorkOrdLotNo());
			checkConnectLotNo = workOrderService.checkConnectLotNo(checkConnectLotNo);
			logger.info("작지 자재 연결 확인 - " + checkConnectLotNo);
			if (checkConnectLotNo == null) {
				workOrderVo.setConnectNm("");
			} else {
				workOrderVo.setConnectNm("(☆연결★)");
			}
	//		String OS1 = System.getProperty("os.name").toLowerCase();
	//		
	//		String ATTACH_PATH = workOrderDir;
	//		
	//		if (OS1.indexOf("win") >= 0) {
	//		   ATTACH_PATH = "c:/tmp/";
	//		}
			
			String ATTACH_PATH = workOrderDir;
			ATTACH_PATH += "/" + DateUtil.getToday("yyyymmdd");
			// [[ UUID생성 및 디렉토리 생성
			
			//String uuid = UUID.randomUUID().toString();
			File parent = new File(ATTACH_PATH);
			//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
			parent.mkdirs();
			//해당 경로에 만들 xlsx 파일 선언
			//File newfile = new File(parent.getAbsolutePath(), workOrdSubOrdLotNo + ".xlsx");
			File newfile = new File(parent.getAbsolutePath(), workOrdLotNo + ".xlsx");
			
			/*
			 * EstidtlVo estidtlVo = new EstidtlVo();
			 * estidtlVo.setQuote_no(estimateManagementVo.getQuote_no()); List<EstidtlVo>
			 * estidtlVoList = estidtlService.all(estidtlVo);
			 * 
			 * CustinfoVo custinfoVo = new CustinfoVo();
			 * custinfoVo.setCompany_id(estimateManagementVo.getCompany_id()); custinfoVo =
			 * custinfoService.read(custinfoVo); if(custinfoVo==null) {
			 * 
			 * }else {
			 * custinfoVo.setCompany_reg_no(custinfoVo.getCompany_reg_no1()+"-"+custinfoVo.
			 * getCompany_reg_no2()+"-"+custinfoVo.getCompany_reg_no3());
			 * custinfoVo.setPhone_no(custinfoVo.getPhone_no1()+"-"+custinfoVo.getPhone_no2(
			 * )+"-"+custinfoVo.getPhone_no3());
			 * custinfoVo.setFax_no(custinfoVo.getFax_no1()+"-"+custinfoVo.getFax_no2()+"-"+
			 * custinfoVo.getFax_no3());
			 * custinfoVo.setAddress(custinfoVo.getAddresss1()+" "+custinfoVo.
			 * getAddresss1_dtl()); }
			 */
			// [[ 엑셀파일 생성
			/*
			InputStream is = EstimateManagementController.class.getResourceAsStream("estimate.xlsx");
			FileOutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			Transformer transformer = PoiTransformer.createTransformer(is, os);
			AreaBuilder areaBuilder = new XlsCommentAreaBuilder(transformer);
			JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();
			 Map<String, Object> functionMap = new HashMap<>();
			 evaluator.getJexlEngine().setFunctions(functionMap);
			 
			transformer.getTransformationConfig().setExpressionEvaluator(evaluator);    
			*/
			//try{
				
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			InputStream is = null;
			//Excel 파일에 범위 설정하는 메모란은 무조건A1에 위치하여야 함!
			//MTP 1공장(성남)
			if ("001".equals(facotryCode)) {
				is = WorkOrderPaperController.class.getResourceAsStream("workOrderTemplateVer9.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐	
			//MTP 2공장(성남)
			} else if ("002".equals(facotryCode)) {
				is = WorkOrderPaperController.class.getResourceAsStream("workOrderTemplate_MTP2_F2.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
			//SLD 3공장(파주)
			} else if ("003".equals(facotryCode)) {
				is = WorkOrderPaperController.class.getResourceAsStream("workOrderTemplate_SLD_F3.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐	
			}
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			
			//logger.info("inputStream is : " + is.read(arg0));
			OutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			logger.info("OutputStream os : " + os);
			//파일 생성
			PoiTransformer transformer = PoiTransformer.createTransformer(is, os);
			/*
			   InputStream is = EstimateManagementController.class.getResourceAsStream("estimate3.xlsx");
			   OutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			   System.out.println(newfile.getAbsolutePath());
				
			   //Workbook workbook =  WorkbookFactory.create(is);
			   Transformer transformer = PoiTransformer.createTransformer(is,os);
			*/
			AreaBuilder areaBuilder = new XlsCommentAreaBuilder(transformer);
			
			JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();
			//Map<String, Object> functionMap = new HashMap<>();
				
			transformer.getTransformationConfig().setExpressionEvaluator(evaluator); 
			List<Area> xlsAreaList = areaBuilder.build();
			Area xlsArea1 = xlsAreaList.get(0);
			//XlsArea xlsArea1 = new XlsArea("금액별 견적서!A1:H20", transformer);
			 
			Context context = new Context();
			context.putVar("workOrder", workOrderVo);				//posc0010에서 받아온 값
			context.putVar("workOrdLotNo", workOrdLotNo);			//생산LotNo
			//context.putVar("workOrdSubOrdLotNo", workOrdSubOrdLotNo);//생산전표번호
			
			context.putVar("matrlCodeAdm", matrlCodeAdmVo);			//주자재 정보
			context.putVar("readWork", readWork);					//작지번호로 조회한 값
			context.putVar("film", filmVo);							//부자재 정보
			context.putVar("outputSubList", outputSubList);			//
			context.putVar("outputUserNm", outputUserNm);			//생산 작업자 목록
			context.putVar("visionEdgeCntSum", visionEdgeCntSum);	//생산수량 중 비전엣지검사수량 합계
			context.putVar("totalOutputSum", totalOutputSum);		//비전엣지검사수량 + 생산수량 = 종합수량
			context.putVar("totalFaultyCnt", totalFaultyCnt);		//총불량수량 = 총생산수량 - 양품수량 - 비전엣지기포수량
			context.putVar("goodsCntSum", goodsCntSum);				//외관양품수량
			context.putVar("inspctChargerNm", inspctChargerNm);		//검사자명
			context.putVar("inspctDate", inspctDate);				//검사일
			context.putVar("sumFaultyType", sumFaultyType);			//엣지,외관 불량유형별 합
			context.putVar("finallOutputCnt", finallOutputCnt);		//엣지,외관 불량유형별 합
			
			//표준(조건)
			context.putVar("tempatur", tempaturEquipCondBomAdmVo);
			context.putVar("time", timeEquipCondBomAdmVo);
			context.putVar("press", pressureEquipCondBomAdmVo);
			
			//초물
			//if ("001".equals(stepCd)) {
				context.putVar("firstAgtTempatur", firstAgtTempatur);
				context.putVar("firstAgtTime", firstAgtTime);
				context.putVar("firstAgtPressure", firstAgtPressure);
			//중물
			//} else if ("002".equals(stepCd)) {
				context.putVar("secondAgtTempatur", secondAgtTempatur);
				context.putVar("secondAgtTime", secondAgtTime);
				context.putVar("secondAgtPressure", secondAgtPressure);
			//}
			
			context.putVar("stepCond", stepCond);
			context.putVar("firstStep", firstStep);
			context.putVar("secondStep", secondStep);
			context.putVar("thirdStep", thirdStep);
			context.putVar("thirdStep_F2", thirdStep_F2);
			context.putVar("mainMatrlTop4", mainMatrlTop4);		//주자재 최대 4개까지 -> 주자재 기준으로 생산실적 입력 변경 후 1개만 표시됨
			context.putVar("subMatrlTop4", subMatrlTop4);		//부자재 최대 4개까지 표시
			
			context.putVar("goodsFaultyAdmList", goodsFaultyAdmList);		//외관검사 값 불러오기(수완 추가)
			
			//JxlsHelper.getInstance().processTemplate(is, os, context);
			
			if ("001".equals(facotryCode)) {
				xlsArea1.applyAt(new CellRef("Singal!A1"), context); 	
			//MTP 2공장(성남)
			} else if ("002".equals(facotryCode)) {
				xlsArea1.applyAt(new CellRef("Dual_F2!A1"), context); 
			//SLD 3공장(파주)
			} else if ("003".equals(facotryCode)) {
				xlsArea1.applyAt(new CellRef("Dual_F3!A1"), context);
			}
			
			xlsArea1.processFormulas();
			
			//시트 2번째 정보 넣을때
			//Area xlsArea2 = xlsAreaList.get(1);
			//xlsArea2.applyAt(new CellRef("Singal!A1"), context); 
			//xlsArea2.processFormulas();
			
			/*
			Area xlsArea3 = xlsAreaList.get(2);
			context.putVar("count", 0);
			xlsArea3.applyAt(new CellRef("자재별 견적서(상세)!A1"), context);
			xlsArea3.processFormulas();
			
			Area xlsArea4 = xlsAreaList.get(3);
			context.putVar("count", 0);
			context.putVar("partsCount", quote.getPartsJson().size());
			xlsArea4.applyAt(new CellRef("품목별 견적서!A1"), context);
			xlsArea4.processFormulas();
			*/
			
			
			transformer.write();
			
			//Workbook xlsxWb = transformer.getWorkbook();
					
			//xlsxWb.setPrintArea(
			//         1, //sheet index
			//         0, //start column
			//         53, //end column
			//         0, //start row
			//         610  //end row
			//);
			
			/*
			 * FileInputStream input_document = new FileInputStream(new
			 * File("C:\\workOrderTemplateVer9.xls"));
			 * 
			 * // Read workbook into HSSFWorkbook HSSFWorkbook my_xls_workbook = new
			 * HSSFWorkbook(input_document);
			 * 
			 * // Read worksheet into HSSFSheet HSSFSheet my_worksheet =
			 * my_xls_workbook.getSheetAt(0);
			 * 
			 * // To iterate over the rows Iterator<Row> rowIterator =
			 * my_worksheet.iterator();
			 * 
			 * // We will create output PDF document objects at this point Document
			 * iText_xls_2_pdf = new Document(); PdfWriter.getInstance(iText_xls_2_pdf, new
			 * FileOutputStream("Excel2PDF_Output.pdf")); iText_xls_2_pdf.open();
			 * 
			 * // We have two columns in the Excel sheet, so we create a PDF table with two
			 * columns // Note: There are ways to make this dynamic in nature, if you want
			 * to. PdfPTable my_table = new PdfPTable(2);
			 * 
			 * // We will use the object below to dynamically add new data to the table
			 * PdfPCell table_cell;
			 * 
			 * // Loop through rows. while (rowIterator.hasNext()) { Row row =
			 * rowIterator.next(); Iterator<Cell> cellIterator = row.cellIterator(); while
			 * (cellIterator.hasNext()) { Cell cell = cellIterator.next(); //Fetch CELL
			 * //switch (cell.getCellType()) { //Identify CELL type //you need to add more
			 * code here based on your requirement / transformations //case
			 * cell.CELL_TYPE_STRING: //Push the data from Excel to PDF Cell //feel free to
			 * move the code below to suit to your needs table_cell = new PdfPCell(new
			 * Phrase(cell.getStringCellValue())); my_table.addCell(table_cell); break; //}
			 * }
			 * 
			 * }
			 * 
			 * // Finally add the table to PDF document iText_xls_2_pdf.add(my_table);
			 * iText_xls_2_pdf.close();
			 * 
			 * // we created our pdf file.. input_document.close(); //close xls
			 */
			
			
			
			
			
			
			//  }catch(Exception e) {
			//    System.out.println(e);
			//  }finally {
		       
			//  }
			// String fileName = "견적서_" + workOrderVo.getDealCorpCd() + ".xlsx";
			// 
			// byte fileByte[] = Files.readAllBytes(newfile.toPath());
			// response.setContentType("application/octet-stream");
			// response.setContentLength(fileByte.length);
			// response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
			// response.setHeader("Content-Transfer-Encoding", "binary");
			// response.getOutputStream().write(fileByte);
			// response.getOutputStream().flush();
			// response.getOutputStream().close();
			// 
			// logger.info("제이슨 보내기 직전");
			
			jsonData.put("result", "ok");
			jsonData.put("path", parent.toString() );
			jsonData.put("data", workOrderVo);
			logger.info("제이슨 보낸 후" + jsonData);
			
		} catch (Exception e) {
			logger.info("작업지시 엑셀다운 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	// 엑셀다운로드
	@RequestMapping(value = "/po/workOrdExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView excelDownload(ModelAndView mv, @RequestParam(value="id") String workOrdSubOrdLotNo) throws Exception {
		//Map resultMap = new HashMap();
		
		String filePath = workOrderDir;
		logger.info("filePath : "+filePath);
		filePath 		+= "/" + DateUtil.getToday("yyyymmdd");
		String fileName = workOrdSubOrdLotNo + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file 		= new File(fullPath);
		logger.info("filePath : "+filePath);
		logger.info("fileName : "+fileName);
		logger.info("fullPath : "+fullPath);
		logger.info("file : "+file);
		
		//if (file.exists()) {
    	//	if (file.delete()) {
    	//		logger.info("파일삭제 성공");
    	//	} else {
    	//		logger.info("파일삭제 실패");
    	//	}
    	//} else {
    	//	logger.info("파일이 존재하지 않습니다.");
    	//}
		
		logger.info("ModelAndView : "+new ModelAndView("downloadView", "downloadFile", file));
		return new ModelAndView("downloadView", "downloadFile", file);
	}
}