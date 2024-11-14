package mes.web.qm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.qm.StateVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.qm.StateService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class StateController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private StateService stateService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(StateController.class);
	
	//품질관리 - 초중물 검사 현황
	@RequestMapping(value = "/qmsc0140", method = RequestMethod.GET)
	public String qmsc0140(Locale locale, Model model) throws Exception {
		logger.info("초중물 검사 현황");
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		model.addAttribute("goodsCode", goodsCodeDataList );
		
		return "qm/qmsc0140";
	}
	
	//품질관리 - 초중물 검사 현황
	@RequestMapping(value = "/qmsc3140", method = RequestMethod.GET)
	public String qmsc3140(Locale locale, Model model) throws Exception {
		logger.info("초중물 검사 현황");
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEquipGubun("D");	//23.11.20추가 6층 페이지 분리로 인한, 호기 구분자 추가
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		model.addAttribute("goodsCode", goodsCodeDataList );
		
		return "qm/qmsc3140";
	}
	
	//품질관리 - 초중물 검사 현황
	@RequestMapping(value = "/qmsc3150", method = RequestMethod.GET)
	public String qmsc3150(Locale locale, Model model) throws Exception {
		logger.info("초중물 검사 현황");
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEquipGubun("C");	//23.11.20추가 6층 페이지 분리로 인한, 호기 구분자 추가
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
		List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
		model.addAttribute("goodsCode", goodsCodeDataList );
		
		return "qm/qmsc3150";
	}
	
	//초중종물 검사현황 목로조회
	@RequestMapping(value = "/qm/stateList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> stateList(StateVo stateVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String equipCdList = stateVo.getEquipCd();
			List<Integer> errorArr = new ArrayList<Integer>();
			equipCdList = equipCdList.replace("/", "', '");
			equipCdList = equipCdList.substring(3, equipCdList.length());
			equipCdList += "'";
			stateVo.setEquipCd(equipCdList);
			
			List<StateVo> stateList = stateService.stateList(stateVo);
			List<StateVo> errorList = new ArrayList<StateVo>();
			
			JSONArray array 	= new JSONArray();	//조건을 담을 값
			JSONArray ArrayAll	= new JSONArray();	//조건을 담을 값
			JSONArray stateMax 	= new JSONArray();	//최대값을 담을 값
			JSONArray stateMin 	= new JSONArray();	//최소값을 담을 값
			
						
			
			for(int i=0; i<stateList.size(); i++) {
				
				ArrayAll = new JSONArray();	//조건을 담을 값
				
				ArrayAll.add(stateList.get(i).getWpLeftAlwnce());
				ArrayAll.add(stateList.get(i).getWpRightAlwnce());
				ArrayAll.add(stateList.get(i).getPitchLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPitchRightAlwnce());
				ArrayAll.add(stateList.get(i).getPpfWingLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPpfWingRightAlwnce());
				ArrayAll.add(stateList.get(i).getPpfDepthLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPpfDepthRightAlwnce());
				ArrayAll.add(stateList.get(i).getFilmAlwnce());
				ArrayAll.add(stateList.get(i).getMetalDepthAlwnce());
				ArrayAll.add(stateList.get(i).getMetalThicknessAlwnce());
				ArrayAll.add(stateList.get(i).getThCenterAlwnce());
				ArrayAll.add(stateList.get(i).getThEdgeAlwncePlus());
				ArrayAll.add(stateList.get(i).getBurrMetalAlwnce());
				ArrayAll.add(stateList.get(i).getBurrRcutAlwnce());
				ArrayAll.add(stateList.get(i).getBurrRedgeAlwnce());
				ArrayAll.add(stateList.get(i).getGatOfLayer());
				
				if(stateList.get(i).getStepCd().equals("000")) {
					stateMax = new JSONArray();	//최대값을 담을 값
					stateMin = new JSONArray();	//최소값을 담을 값
				}
				
				for(int j=0; j<16; j++) {
					
					if(stateList.get(i).getStepCd().equals("000")) {
						
						String stateSum = null;
						
						if(!ArrayAll.get(j).toString().equals("")) {
							stateSum = ArrayAll.get(j).toString().replace("-","").replace("[","").replace("]","").replace("+","");							
						} else {
							stateSum = "0 0 0";
						}
						
						String[] stateDivided = stateSum.split(" "); 
						
//						//logger.info("array 값 전체 확인 >>> " +array);
						
//						//logger.info("b >>> "+b);
						//logger.info("0 >>> "+Float.parseFloat(b[0]));
						//logger.info("1 >>> "+Float.parseFloat(b[1]));
						//logger.info("2 >>> "+Float.parseFloat(b[2]));
						if (stateDivided.length < 3) {
							System.out.println("qwer");
						}
						
						
						double stateMaxVal;
						double stateMinVal;
						
						
						if( stateDivided.length == 1 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]); 
							
							stateMaxVal = 0;
							stateMinVal = 0 - Float.parseFloat(stateDivided[0]);
						} else if( stateDivided.length == 2 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]);
							stateDivided[1] = (stateDivided[1].equals("") ? "0" : stateDivided[1]);
							
							stateMaxVal = Float.parseFloat(stateDivided[1]) + 0;
							stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						} else if( stateDivided.length == 3 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]);
							stateDivided[1] = (stateDivided[1].equals("") ? "0" : stateDivided[1]);
							stateDivided[2] = (stateDivided[2].equals("") ? "0" : stateDivided[2]);
							
							stateMaxVal = Float.parseFloat(stateDivided[1]) + Float.parseFloat(stateDivided[2]);
							stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						} else {
							stateMaxVal = 0;
							stateMinVal = 0;
						}
						
						//stateMaxVal = Float.parseFloat(stateDivided[1]) + Float.parseFloat(stateDivided[2]);						
						//stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						
						stateMaxVal = Math.round(stateMaxVal*1000) / 1000.0;
						stateMinVal = Math.round(stateMinVal*1000) / 1000.0;
						
						stateMax.add(stateMaxVal);	//최대값 
						stateMin.add(stateMinVal);	//최소값
						
						//logger.info("최대값  >>> "+stateMax);
						//logger.info("최소값  >>> "+stateMin);
						
						//logger.info("최대값 : "+j+"번째 확인 >>> "+stateMax.get(j));
						//logger.info("최소값 : "+j+"번째 확인 >>> "+stateMin.get(j));
					}
				}
				
				String[] errorYn = new String[16];
				
				for(int j=0; j<16; j++) {
					
					if(stateVo.getListGubun().equals("001")) {	
						if(!stateList.get(i).getStepCd().equals("000")) {
							//logger.info("000이 아닐때 값 확인하기 >>> " +stateList.get(i).getStepCd());
		            		//logger.info("X 값 확인 하기 전 >>> " +ArrayAll.get(j));
		            		String compareTarget = ArrayAll.get(j).toString();
		            		String max			 = stateMax.get(j).toString();
		            		String min			 = stateMin.get(j).toString();
		                	
		                	//전체 값을 돌면서 최대값 보다 초.중.종뭉에 값이 더 크거나 최소값 보다 더 작으면 실행시켜라 
		    	            if (Float.parseFloat(compareTarget) > Float.parseFloat(max)) {
		    	            	errorYn[j] = "Y";
		    	            	errorArr.add(i);
		    	            } else if(Float.parseFloat(compareTarget) < Float.parseFloat(min)){
		    	            	errorYn[j] = "Y";
		    	            	errorArr.add(i);
		    	            } else {
		    	            	errorYn[j] = "N";
		    	            }
		            	}
					} else {
						errorYn[j] = "N";
					}
	            }
				stateList.get(i).setStatusErrorYn(errorYn);
			}
			
			if(factoryCode.equals("003") && stateVo.getNgGubun().equals("002")) {
				List<Object> lists = errorArr.stream().distinct().collect(Collectors.toList());
				
				for(Object i : lists) {
					errorList.add(stateList.get((int)i-1));
					errorList.add(stateList.get((int)i));
				}
				jsonData.put("data", errorList);
			} else {
				jsonData.put("data", stateList);
			}

			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//초중종물 검사현황 목로조회
	@RequestMapping(value = "/qm/stateList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> stateList_F3(StateVo stateVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String equipCdList = stateVo.getEquipCd();
			List<Integer> errorArr = new ArrayList<Integer>();
			equipCdList = equipCdList.replace("/", "', '");
			equipCdList = equipCdList.substring(3, equipCdList.length());
			equipCdList += "'";
			stateVo.setEquipCd(equipCdList);
			
			List<StateVo> stateList = stateService.stateListF3(stateVo);
			List<StateVo> errorList = new ArrayList<StateVo>();
			
			JSONArray array 	= new JSONArray();	//조건을 담을 값
			JSONArray ArrayAll	= new JSONArray();	//조건을 담을 값
			JSONArray stateMax 	= new JSONArray();	//최대값을 담을 값
			JSONArray stateMin 	= new JSONArray();	//최소값을 담을 값
			
						
			
			for(int i=0; i<stateList.size(); i++) {
				
				ArrayAll = new JSONArray();	//조건을 담을 값
				
				ArrayAll.add(stateList.get(i).getMetalDepthAlwnce());
				ArrayAll.add(stateList.get(i).getPitchLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPpfDepthLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPpfDepthCenterAlwnce());
				ArrayAll.add(stateList.get(i).getPpfDepthRightAlwnce());
				ArrayAll.add(stateList.get(i).getFilmAlwnce());
				ArrayAll.add(stateList.get(i).getWpLeftAlwnce());
				ArrayAll.add(stateList.get(i).getWpCenterAlwnce());
				ArrayAll.add(stateList.get(i).getWpRightAlwnce());
				ArrayAll.add(stateList.get(i).getWpDeviationAlwnce());
				ArrayAll.add(stateList.get(i).getX1X2Alwnce());
				ArrayAll.add(stateList.get(i).getPpfWingLeftAlwnce());
				ArrayAll.add(stateList.get(i).getPpfWingRightAlwnce());
				ArrayAll.add(stateList.get(i).getMetalThicknessAlwnce());
				ArrayAll.add(stateList.get(i).getThEdgeAlwncePlus());
				ArrayAll.add(stateList.get(i).getThCenterAlwnce());
				ArrayAll.add(stateList.get(i).getThEdgeRightAlwnce());
				ArrayAll.add(stateList.get(i).getBurrMetalAlwnce());
				ArrayAll.add(stateList.get(i).getGapOfLayer());
				ArrayAll.add(stateList.get(i).getBendingAlwnce());
		
				
				if(stateList.get(i).getStepCd().equals("000")) {
					stateMax = new JSONArray();	//최대값을 담을 값
					stateMin = new JSONArray();	//최소값을 담을 값
				}
				
				for(int j=0; j<20; j++) {
					
					if(stateList.get(i).getStepCd().equals("000")) {
						
						String stateSum = null;						
						
						if(ArrayAll.get(j) != null && !ArrayAll.get(j).equals("")) {
							stateSum = ArrayAll.get(j).toString().replace("-","").replace("[","").replace("]","").replace("+","");							
						} else {
							stateSum = "0 0 0";
						}
						
						String[] stateDivided = stateSum.split(" "); 
						
//						//logger.info("array 값 전체 확인 >>> " +array);
						
//						//logger.info("b >>> "+b);
						//logger.info("0 >>> "+Float.parseFloat(b[0]));
						//logger.info("1 >>> "+Float.parseFloat(b[1]));
						//logger.info("2 >>> "+Float.parseFloat(b[2]));
						if (stateDivided.length < 3) {
							System.out.println("qwer");
						}
						
						
						double stateMaxVal;
						double stateMinVal;
						
						
						if( stateDivided.length == 1 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]); 
							
							stateMaxVal = 0;
							stateMinVal = 0 - Float.parseFloat(stateDivided[0]);
						} else if( stateDivided.length == 2 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]);
							stateDivided[1] = (stateDivided[1].equals("") ? "0" : stateDivided[1]);
							
							stateMaxVal = Float.parseFloat(stateDivided[1]) + 0;
							stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						} else if( stateDivided.length == 3 ) {
							
							stateDivided[0] = (stateDivided[0].equals("") ? "0" : stateDivided[0]);
							stateDivided[1] = (stateDivided[1].equals("") ? "0" : stateDivided[1]);
							stateDivided[2] = (stateDivided[2].equals("") ? "0" : stateDivided[2]);
							
							stateMaxVal = Float.parseFloat(stateDivided[1]) + Float.parseFloat(stateDivided[2]);
							stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						} else {
							stateMaxVal = 0;
							stateMinVal = 0;
						}
						
						//stateMaxVal = Float.parseFloat(stateDivided[1]) + Float.parseFloat(stateDivided[2]);						
						//stateMinVal = Float.parseFloat(stateDivided[1]) - Float.parseFloat(stateDivided[0]);
						
						stateMaxVal = Math.round(stateMaxVal*1000) / 1000.0;
						stateMinVal = Math.round(stateMinVal*1000) / 1000.0;
						
						stateMax.add(stateMaxVal);	//최대값 
						stateMin.add(stateMinVal);	//최소값
						
						//logger.info("최대값  >>> "+stateMax);
						//logger.info("최소값  >>> "+stateMin);
						
						//logger.info("최대값 : "+j+"번째 확인 >>> "+stateMax.get(j));
						//logger.info("최소값 : "+j+"번째 확인 >>> "+stateMin.get(j));
					}
				}
				
				String[] errorYn = new String[20];
				
				for(int j=0; j<20; j++) {
					
					if(stateVo.getListGubun().equals("001")) {	
						if(!stateList.get(i).getStepCd().equals("000")) {
							//logger.info("000이 아닐때 값 확인하기 >>> " +stateList.get(i).getStepCd());
		            		//logger.info("X 값 확인 하기 전 >>> " +ArrayAll.get(j));
							
							String copareT = "0";
							
							if(ArrayAll.get(j) != null) {
								copareT = ArrayAll.get(j).toString();
							}
							
		            		String compareTarget = copareT;
		            		String max			 = stateMax.get(j).toString();
		            		String min			 = stateMin.get(j).toString();
		                	
		                	//전체 값을 돌면서 최대값 보다 초.중.종뭉에 값이 더 크거나 최소값 보다 더 작으면 실행시켜라 
		            		
		    	            if (Float.parseFloat(compareTarget) > Float.parseFloat(max)) {
		    	            	logger.info("최대값당첨  >>> "+compareTarget + "///" + max + "///" + j + "번째");
		    	            	errorYn[j] = "Y";
		    	            	errorArr.add(i);
		    	            } else if(Float.parseFloat(compareTarget) < Float.parseFloat(min)){
		    	            	logger.info("최소값당첨 >>> "+compareTarget + "///" + min + "///" + j + "번째");
		    	            	errorYn[j] = "Y";
		    	            	errorArr.add(i);
		    	            } else {
		    	            	errorYn[j] = "N";
		    	            }
		            	}
					} else {
						errorYn[j] = "N";
					}
	            }
				stateList.get(i).setStatusErrorYn(errorYn);
			}
			
			if(factoryCode.equals("003") && stateVo.getNgGubun().equals("002")) {
				List<Object> lists = errorArr.stream().distinct().collect(Collectors.toList());
				
				for(Object i : lists) {
					errorList.add(stateList.get((int)i-1));
					errorList.add(stateList.get((int)i));
				}
				jsonData.put("data", errorList);
			} else {
				jsonData.put("data", stateList);
			}

			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}