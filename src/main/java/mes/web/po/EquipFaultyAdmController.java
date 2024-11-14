package mes.web.po;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.AllFaultyAdmVo;
import mes.domain.po.TotalFaultyAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.AllFaultyAdmService;
import mes.service.po.EquipFaultyAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class EquipFaultyAdmController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipFaultyAdmService equipFaultyAdmService;
	@Inject
	private AllFaultyAdmService allFaultyAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(EquipFaultyAdmController.class);
	
	@Value("${factoryCode}") private String factoryCode;
	
	//공정실적관리 불량등록
	@RequestMapping(value = "/posc0050", method = RequestMethod.GET)
	public String posc0050GET(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리 불량등록 페이지");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017");	//설비그룹
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
		
		//systemCommonCodeVo.setBaseGroupCd("028");	//주야
		//systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("dayNightCd", systemCommonCodeList );	
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "po/posc0050";
	}
	
	/*
	 * //공정실적관리 불량등록
	 * 
	 * @RequestMapping(value = "/qmsc0010", method = RequestMethod.GET) public
	 * String qmsc0010GET(Locale locale, Model model) throws Exception {
	 * 
	 * //logger.info("품질관리 불량정보등록 페이지"); //SystemCommonCodeVo systemCommonCodeVo =
	 * new SystemCommonCodeVo(); // //systemCommonCodeVo.setBaseGroupCd("017");
	 * //주설비그룹야 //List<SystemCommonCodeVo> systemCommonCodeList =
	 * systemCommonCodeService.listAll(systemCommonCodeVo);
	 * //model.addAttribute("equipGroup", systemCommonCodeList ); //
	 * //systemCommonCodeVo.setBaseGroupCd("028"); //주야 //systemCommonCodeList =
	 * systemCommonCodeService.listAll(systemCommonCodeVo);
	 * //model.addAttribute("dayNightCd", systemCommonCodeList ); //
	 * //model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
	 * 
	 * return "qm/qmsc0010"; }
	 */
	
	//통계 조회
	@RequestMapping(value = "po/readTotalFaulty", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readTotalFaultyGET(TotalFaultyAdmVo totalFaultyAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("통계 조회");
		logger.info("받은 값 : " + totalFaultyAdmVo.getEquipCd() + ", " + totalFaultyAdmVo.getFaultyRegDate());
		
		try {
			totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
			//equipPrcssFaultyAdmVo = equipFaultyAdmService.totalPrcssFaulty(equipPrcssFaultyAdmVo);
			//equipMatrlFaultyAdmVo = equipFaultyAdmService.totalMatrlFaulty(equipMatrlFaultyAdmVo);
			//equipReplaceFaultyAdmVo = equipFaultyAdmService.totalReplaceFaulty(equipReplaceFaultyAdmVo);
			//equipTroubleFaultyAdmVo = equipFaultyAdmService.totalTroubleFaulty(equipTroubleFaultyAdmVo);
			//logger.info("공정 통계 : " + equipPrcssFaultyAdmVo);
			//logger.info("원자재 통계 totalMatrlFaulty : " + equipMatrlFaultyAdmVo);
			//logger.info("교체 통계 : " + equipReplaceFaultyAdmVo);
			//logger.info("설비트러블 통계 : " + equipTroubleFaultyAdmVo);
			logger.info("전체 불량 통계 : " + totalFaultyAdmVo);
			//jsonData.put("prcssTotalData", equipPrcssFaultyAdmVo);
			//jsonData.put("matrlTotalData", equipMatrlFaultyAdmVo);
			//jsonData.put("replaceTotalData", equipReplaceFaultyAdmVo);
			//jsonData.put("troubleTotalData", equipTroubleFaultyAdmVo);
			jsonData.put("totatFaultyData", totalFaultyAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("공정불량 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	/*------------------------------------------------------ 공정불량 시작 ------------------------------------------------------*/
	//불량중량 조회
	@RequestMapping(value = "po/readFaultyAll", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정불량 조회");
		logger.info("받은 값 : " + allFaultyAdmVo);
		AllFaultyAdmVo allFaultyAdmVo2 = null;
		
		try {
			List<AllFaultyAdmVo> list = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);		
			logger.info("공정불량 조회 값 : " + allFaultyAdmVo);
			if(list.size() != 0) {
				jsonData.put("readData", list);			
			} else {
				jsonData.put("readData", allFaultyAdmVo2);			
			}
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("공정불량 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//공정불량 등록
	//@RequestMapping(value = "po/createPrcssFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> createPrcssFaultyPOST(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("공정불량 등록");
	//	equipPrcssFaultyAdmVo.setRegId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + equipPrcssFaultyAdmVo);
	//	
	//	try {
	//		equipFaultyAdmService.createPrcssFaulty(equipPrcssFaultyAdmVo);
	//		logger.info("공정불량 등록 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("공정불량 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "공정불량 저장 실패하였습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//불량중량 등록
	@RequestMapping(value = "po/createFaultyAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createFaultyAll(@RequestBody List<Map<String, Object>> allFaultyAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량중량 등록");
		try {
			
			AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
			logger.info("로그인 ID : " + Utils.getUserId());
			logger.info("받은 값 : " + allFaultyAdmList);
			
			float sum = 0;
			int count = 0;
			
			List<AllFaultyAdmVo> list = new ArrayList<AllFaultyAdmVo>();
			allFaultyAdmVo.setEquipCd(allFaultyAdmList.get(0).get("equipCd").toString());
			allFaultyAdmVo.setWorkOrdNo(allFaultyAdmList.get(0).get("workOrdNo").toString());
			allFaultyAdmVo.setLotNo(allFaultyAdmList.get(0).get("lotNo").toString());
			allFaultyAdmVo.setFaultyRegDate(allFaultyAdmList.get(0).get("faultyRegDate").toString());
			allFaultyAdmVo.setGubun(allFaultyAdmList.get(0).get("gubun").toString());
			allFaultyAdmVo.setDayNightCd(allFaultyAdmList.get(0).get("dayNightCd").toString());
			
			List<AllFaultyAdmVo> list2 = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);
			List<AllFaultyAdmVo> list3 = new ArrayList<AllFaultyAdmVo>();
			
			allFaultyAdmService.deleteFaultyAll(allFaultyAdmVo);
			
			if (!"empty".equals(allFaultyAdmList.get(0).get("systemCode").toString())) {
				for(Map<String, Object> m : allFaultyAdmList) {
					allFaultyAdmVo = new AllFaultyAdmVo();
					allFaultyAdmVo.setEquipCd(m.get("equipCd").toString());
					allFaultyAdmVo.setLotNo(m.get("lotNo").toString());
					allFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					allFaultyAdmVo.setOrdDate(m.get("ordDate").toString());
					allFaultyAdmVo.setDayNightCd(m.get("dayNightCd").toString());
					allFaultyAdmVo.setGubun(m.get("gubun").toString());
					allFaultyAdmVo.setSystemCode(String.format("%03d",Integer.parseInt(m.get("systemCode").toString())));
					allFaultyAdmVo.setFaultySeq(Integer.parseInt(m.get("faultySeq").toString()));
					allFaultyAdmVo.setFaultyCount(m.get("faultyCount").toString());			//개수 구하기
					allFaultyAdmVo.setFaulty(m.get("faulty").toString());
					allFaultyAdmVo.setFaultyDatetime(m.get("faultyDatetime").toString());
					allFaultyAdmVo.setFaultyDesc(m.get("faultyDesc").toString());
					allFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
					allFaultyAdmVo.setRegId(Utils.getUserId());
					sum += Float.parseFloat(m.get("faulty").toString());
					if(Float.parseFloat(m.get("faulty").toString())>0) {
						count++;
					}
					list.add(allFaultyAdmVo);
//					list2.add(allFaultyAdmVo);
				}
				
				//테프론값 + 실리콘 값만 저장 해놓음
				for(int i=0; i<list2.size(); i++) {
					if(list2.get(i).getGubun().equals("003")) {
						if(list2.get(i).getSystemCode().equals("003") || list2.get(i).getSystemCode().equals("004") || list2.get(i).getSystemCode().equals("007") || list2.get(i).getSystemCode().equals("008")) {
							sum += Float.parseFloat(list2.get(i).getFaulty().toString());
							count++;
							list3.add(list2.get(i));
						}
					}
				}
				
				list2 = new ArrayList<AllFaultyAdmVo>();
				list3.addAll(list);
				list3.addAll(list2);
				
				/*for(AllFaultyAdmVo m : list) {
					m.setPrcsTotal(Float.toString(sum));
					m.setPrcsCnt(Integer.toString(count));
					allFaultyAdmService.createFaultyAll(m);
				}*/
				
				for(AllFaultyAdmVo m : list3) {
					m.setPrcsTotal(Float.toString(sum));
					m.setPrcsCnt(Integer.toString(count));
					allFaultyAdmService.createFaultyAll(m);
				}
			}else {
				for(int i=0; i<list2.size(); i++) {
					//생산교체-Loss에서 003, 004 / 007, 008이 테프론 교체 및 진접 교체 라서 다시 등록 시키는 거임
					if(list2.get(i).getGubun().equals("003")) {
						if(!list2.get(i).getSystemCode().equals("001") && !list2.get(i).getSystemCode().equals("002") && !list2.get(i).getSystemCode().equals("005") && !list2.get(i).getSystemCode().equals("006")) {
							allFaultyAdmService.createFaultyAll(list2.get(i));
						}
					}
				}
			}
			
			logger.info("불량중량 등록 성공");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("불량중량 등록 에러발생");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//테프론 등록
	@RequestMapping(value = "po/createFaultyAll_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createFaultyAll_F3( AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("테프론 교체 " + allFaultyAdmVo);
		try {			
			logger.info("로그인 ID : " + Utils.getUserId());		
			
			List<AllFaultyAdmVo> list = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);
			
			float sum	= 0; 
			float count	= 0; 
			
			if(list.size() != 0) {				
				sum		= Float.parseFloat(list.get(0).getPrcsTotal().toString());
				count	= Float.parseFloat(list.get(0).getPrcsCnt().toString());  
			}
			
			int seq = allFaultyAdmService.ptfeSeq(allFaultyAdmVo).getFaultySeq();
			allFaultyAdmService.deleteFaultyAll(allFaultyAdmVo);
			
			if (!"empty".equals(allFaultyAdmVo.getSystemCode().toString())) {
	
				allFaultyAdmVo.setRegId(Utils.getUserId());				
				allFaultyAdmVo.setFaultySeq(seq);
				
				list.add(allFaultyAdmVo);				
				sum += Float.parseFloat(allFaultyAdmVo.getFaulty().toString());
				if(Float.parseFloat(allFaultyAdmVo.getFaulty().toString())>0) {
					count++;
				}								
				
				int faultyCount1 = 0;
				int faultyCount2 = 0;
				int faultyCount3 = 0;
				int faultyCount4 = 0;

				//1, 2공장	: 실리콘 구분자 003번 / 공통코드 번호 : 003, 007번(1, 2차)
				//1, 2공장	: 테프론 구분자 003번 / 공통코드 번호 : 004, 008번(1, 2차)
				
				//3 공장		: 실리콘 구분자 004번 / 공통코드 번호 : 001, 002번(1, 2차)
				//3 공장		: 테프론 구분자 004번 / 공통코드 번호 : 003, 004번(1, 2차)
				
				if( factoryCode.equals("001") || factoryCode.equals("002") ) {
				
					for(AllFaultyAdmVo m : list) {
						if("004".equals(m.getSystemCode().toString())) {
							faultyCount1++;
						}
						if("008".equals(m.getSystemCode().toString())) {
							faultyCount2++;
						}
						if("003".equals(m.getSystemCode().toString())) {
							faultyCount3++;
						}
						if("007".equals(m.getSystemCode().toString())) {
							faultyCount4++;
						}
					}
					
					for(AllFaultyAdmVo m : list) {
						m.setPrcsTotal(Float.toString(sum));
						m.setPrcsCnt(Float.toString(count));
						if("004".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount1));
						}
						if("008".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount2));
						}
						if("003".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount3));
						}
						if("007".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount4));
						}
						
						allFaultyAdmService.createFaultyAll(m);
						
					}
				} else if( factoryCode.equals("003") ) {
					for(AllFaultyAdmVo m : list) {
						if("003".equals(m.getSystemCode().toString())) {
							faultyCount1++;
						}
						if("004".equals(m.getSystemCode().toString())) {
							faultyCount2++;
						}
						if("001".equals(m.getSystemCode().toString())) {
							faultyCount3++;
						}
						if("002".equals(m.getSystemCode().toString())) {
							faultyCount4++;
						}
					}
					
					for(AllFaultyAdmVo m : list) {
						m.setPrcsTotal(Float.toString(sum));
						m.setPrcsCnt(Float.toString(count));
						if("003".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount1));
						}
						if("004".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount2));
						}
						if("001".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount3));
						}
						if("002".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount4));
						}
						
						allFaultyAdmService.createFaultyAll(m);
						
					}
				}
			}
			
			logger.info("불량중량 등록 성공");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("불량중량 등록 에러발생");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//불량중량 상세조회
	@RequestMapping(value = "po/readDtlPrcssFaulty", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
				
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정불량 상세 조회");
		logger.info("받은 값 : " + allFaultyAdmVo);
		AllFaultyAdmVo allFaultyAdmVo2 = null;
			
		try {
			allFaultyAdmVo2 = allFaultyAdmService.readDtlPrcssFaulty(allFaultyAdmVo);		
			logger.info("공정불량 조회 값 : " + allFaultyAdmVo);
			jsonData.put("data", allFaultyAdmVo2);						
			jsonData.put("result", "ok");
				
		} catch (Exception e) {
			logger.info("공정불량 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//불량중량 등록 솔브레인
	@RequestMapping(value = "po/createFaultyAll_F3_2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createFaultyAll_F3_2(@RequestBody List<Map<String, Object>> allFaultyAdmList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량중량 등록");
		try {
			
			AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
			logger.info("로그인 ID : " + Utils.getUserId());
			logger.info("받은 값 : " + allFaultyAdmList);
			
			float sum = 0;
			int count = 0;
			
			List<AllFaultyAdmVo> list = new ArrayList<AllFaultyAdmVo>();
			allFaultyAdmVo.setEquipCd(allFaultyAdmList.get(0).get("equipCd").toString());
			allFaultyAdmVo.setWorkOrdNo(allFaultyAdmList.get(0).get("workOrdNo").toString());
			allFaultyAdmVo.setLotNo(allFaultyAdmList.get(0).get("lotNo").toString());
			allFaultyAdmVo.setFaultyRegDate(allFaultyAdmList.get(0).get("faultyRegDate").toString());
			allFaultyAdmVo.setGubun(allFaultyAdmList.get(0).get("gubun").toString());
			allFaultyAdmVo.setDayNightCd(allFaultyAdmList.get(0).get("dayNightCd").toString());
			
			List<AllFaultyAdmVo> list2 = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);
			List<AllFaultyAdmVo> list3 = new ArrayList<AllFaultyAdmVo>();
			/*for(AllFaultyAdmVo m : list2) {
				if("004".equals(m.getSystemCode().toString())) {					
					sum += Float.parseFloat(m.getFaulty().toString());
					if(Float.parseFloat(m.getFaulty().toString())>0) {
						count++;
					}
					list.add(m);
				}
				if("008".equals(m.getSystemCode().toString())) {					
					sum += Float.parseFloat(m.getFaulty().toString());
					if(Float.parseFloat(m.getFaulty().toString())>0) {
						count++;
					}
					list.add(m);
				}
				if("003".equals(m.getSystemCode().toString())) {					
					sum += Float.parseFloat(m.getFaulty().toString());
					if(Float.parseFloat(m.getFaulty().toString())>0) {
						count++;
					}
					list.add(m);
				}
				if("007".equals(m.getSystemCode().toString())) {					
					sum += Float.parseFloat(m.getFaulty().toString());
					if(Float.parseFloat(m.getFaulty().toString())>0) {
						count++;
					}
					list.add(m);
				}
			}*/
			
//			list = new ArrayList<AllFaultyAdmVo>();		//초기화 코드 추가
			
//			logger.info("값 : "+allFaultyAdmList.size());
//			logger.info("123 : "+allFaultyAdmList.get(0).get("systemCode"));
			
			allFaultyAdmService.deleteFaultyAll(allFaultyAdmVo);
			
			if (!"empty".equals(allFaultyAdmList.get(0).get("systemCode").toString())) {
				
				for(Map<String, Object> m : allFaultyAdmList) {
					allFaultyAdmVo = new AllFaultyAdmVo();
					allFaultyAdmVo.setEquipCd(m.get("equipCd").toString());
					allFaultyAdmVo.setLotNo(m.get("lotNo").toString());
					allFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
					allFaultyAdmVo.setOrdDate(m.get("ordDate").toString());
					allFaultyAdmVo.setDayNightCd(m.get("dayNightCd").toString());
					allFaultyAdmVo.setGubun(m.get("gubun").toString());
					allFaultyAdmVo.setSystemCode(String.format("%03d",Integer.parseInt(m.get("systemCode").toString())));
					allFaultyAdmVo.setFaultySeq(Integer.parseInt(m.get("faultySeq").toString()));
					allFaultyAdmVo.setFaultyCount(m.get("faultyCount").toString());			//개수 구하기
					allFaultyAdmVo.setFaulty(m.get("faulty").toString());
					allFaultyAdmVo.setFaultyDatetime(m.get("faultyDatetime").toString());
					allFaultyAdmVo.setFaultyDesc(m.get("faultyDesc").toString());
					allFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
					allFaultyAdmVo.setRegId(Utils.getUserId());
					sum += Float.parseFloat(m.get("faulty").toString());
					if(Float.parseFloat(m.get("faulty").toString())>0) {
						count++;
					}
					list.add(allFaultyAdmVo);
//					list2.add(allFaultyAdmVo);
				}
				
//				logger.info("sudel 1 : "+list.size());
//				logger.info("sudel 2 : "+list2.size());
				
				//1, 2공장	: 실리콘 구분자 003번 / 공통코드 번호 : 003, 007번(1, 2차)
				//1, 2공장	: 테프론 구분자 003번 / 공통코드 번호 : 004, 008번(1, 2차)
				
				//3 공장		: 실리콘 구분자 004번 / 공통코드 번호 : 001, 002번(1, 2차)
				//3 공장		: 테프론 구분자 004번 / 공통코드 번호 : 003, 004번(1, 2차)
				
				//테프론값만 저장 해놓음
				if( factoryCode.equals("001") || factoryCode.equals("002") ) {
					for(int i=0; i<list2.size(); i++) {
						if(list2.get(i).getGubun().equals("003")) {
							if(list2.get(i).getSystemCode().equals("004") || list2.get(i).getSystemCode().equals("008")) {
								sum += Float.parseFloat(list2.get(i).getFaulty().toString());
								count++;
								list3.add(list2.get(i));
							}
						}
					}
				} else if( factoryCode.equals("003") ) {
					for(int i=0; i<list2.size(); i++) {
						if(list2.get(i).getGubun().equals("004")) {
							if(list2.get(i).getSystemCode().equals("003") || list2.get(i).getSystemCode().equals("004")) {
								sum += Float.parseFloat(list2.get(i).getFaulty().toString());
								count++;
								list3.add(list2.get(i));
							}
						}
					}
				}
				//테프론값만 저장 해놓음
				
				list2 = new ArrayList<AllFaultyAdmVo>();
				list3.addAll(list);
				list3.addAll(list2);
				
				for(AllFaultyAdmVo m : list3) {
					m.setPrcsTotal(Float.toString(sum));
					m.setPrcsCnt(Integer.toString(count));
					allFaultyAdmService.createFaultyAll(m);
				}
				
			} else {
				
				if( factoryCode.equals("001") || factoryCode.equals("002") ) {
					for(int i=0; i<list2.size(); i++) {
						//생산교체-Loss에서 004 / 008이 테프론 교체  라서 다시 등록 시키는 거임
						if(list2.get(i).getGubun().equals("003")) {
							if(!list2.get(i).getSystemCode().equals("001") && !list2.get(i).getSystemCode().equals("002")  && !list2.get(i).getSystemCode().equals("003") && !list2.get(i).getSystemCode().equals("005") && !list2.get(i).getSystemCode().equals("006") && !list2.get(i).getSystemCode().equals("007")) {
								allFaultyAdmService.createFaultyAll(list2.get(i));
							}
						}
					}
				} else if( factoryCode.equals("003") ) {
					for(int i=0; i<list2.size(); i++) {
						//Teflon 교체 Loss에서 003 / 004이 테프론 교체  라서 다시 등록 시키는 거임
						if(list2.get(i).getGubun().equals("004")) {
							if( list2.get(i).getSystemCode().equals("003") || list2.get(i).getSystemCode().equals("004") ) {
								allFaultyAdmService.createFaultyAll(list2.get(i));
							}
						}
					}
				}
			}
			
			logger.info("불량중량 등록 성공");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("불량중량 등록 에러발생");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//불량중량 수정
	@RequestMapping(value = "po/updateFaultyAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateFaultyAll( AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("테프론 교체 수정 " + allFaultyAdmVo);
		try {			
			logger.info("로그인 ID : " + Utils.getUserId());		
				
			List<AllFaultyAdmVo> list = allFaultyAdmService.readUpdPrcssFaulty(allFaultyAdmVo);
			AllFaultyAdmVo selectAllFaultyAdmVo = new AllFaultyAdmVo();
			selectAllFaultyAdmVo = allFaultyAdmService.readUpdDtlPrcssFaulty(allFaultyAdmVo);
			float sum	= 0; 
			float count	= 0; 
			
			if(list.size() != 0) {				
				sum		= Float.parseFloat(list.get(0).getPrcsTotal().toString());
				count	= Float.parseFloat(list.get(0).getPrcsCnt().toString());  
			}
			sum -= Float.parseFloat(selectAllFaultyAdmVo.getFaulty().toString()); //수정할 항목의 이전중량을 빼줌 -> 수정한 항목을 나중에 +해줘야함
			
			int seq = selectAllFaultyAdmVo.getFaultySeq();//allFaultyAdmService.ptfeSeq(allFaultyAdmVo).getFaultySeq();
			//allFaultyAdmService.deleteFaultyAll(allFaultyAdmVo);
				
			if (!"empty".equals(allFaultyAdmVo.getSystemCode().toString())) {
		
				allFaultyAdmVo.setUpdId(Utils.getUserId());				

				/*allFaultyAdmVo.setFaultySeq(seq);
					
				list.add(allFaultyAdmVo);*/				
				sum += Float.parseFloat(allFaultyAdmVo.getFaulty().toString());
				int faultyCount1 = 0;
				int faultyCount2 = 0;
				int faultyCount3 = 0;
				int faultyCount4 = 0;
				
				//1, 2공장	: 실리콘 구분자 003번 / 공통코드 번호 : 003, 007번(1, 2차)
				//1, 2공장	: 테프론 구분자 003번 / 공통코드 번호 : 004, 008번(1, 2차)
				
				//3 공장		: 실리콘 구분자 004번 / 공통코드 번호 : 001, 002번(1, 2차)
				//3 공장		: 테프론 구분자 004번 / 공통코드 번호 : 003, 004번(1, 2차)
				
				if( factoryCode.equals("001") || factoryCode.equals("002") ) {
					for(AllFaultyAdmVo m : list) {
						if("004".equals(m.getSystemCode().toString())) {
							faultyCount1++;
						}
						if("008".equals(m.getSystemCode().toString())) {
							faultyCount2++;
						}
						if("003".equals(m.getSystemCode().toString())) {
							faultyCount3++;
						}
						if("007".equals(m.getSystemCode().toString())) {
							faultyCount4++;
						}
					}
				} else if( factoryCode.equals("003") ) {
					for(AllFaultyAdmVo m : list) {
						if("003".equals(m.getSystemCode().toString())) {
							faultyCount1++;
						}
						if("004".equals(m.getSystemCode().toString())) {
							faultyCount2++;
						}
						if("001".equals(m.getSystemCode().toString())) {
							faultyCount3++;
						}
						if("002".equals(m.getSystemCode().toString())) {
							faultyCount4++;
						}
					}
				}
				
				for(AllFaultyAdmVo m : list) {
					m.setPrcsTotal(Float.toString(sum));
					m.setPrcsCnt(Float.toString(count));
					
					if( factoryCode.equals("001") || factoryCode.equals("002") ) {
		
						if("004".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount1));
						}
						if("008".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount2));
						}
						if("003".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount3));
						}
						if("007".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount4));
						}
					} else if( factoryCode.equals("003") ) {
						
						m.setPrcsTotal(Float.toString(sum));
						m.setPrcsCnt(Float.toString(count));
			
						if("003".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount1));
						}
						if("004".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount2));
						}
						if("001".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount3));
						}
						if("002".equals(m.getSystemCode().toString())) {
							m.setFaultyCount(Integer.toString(faultyCount4));
						}
					}
					//logger.info(Integer.toString(allFaultyAdmVo.getFaultySeq()));
					//logger.info(Integer.toString(m.getFaultySeq()));
					//logger.info((allFaultyAdmVo.getSystemCode()));
					//logger.info((m.getSystemCode()));
					
					if( allFaultyAdmVo.getFaultySeq() == m.getFaultySeq() && allFaultyAdmVo.getSystemCode().equals( m.getSystemCode() )) {
						allFaultyAdmVo.setPrcsTotal(m.getPrcsTotal());
						allFaultyAdmVo.setPrcsCnt(m.getPrcsCnt());
						allFaultyAdmService.updateFaultyAll(allFaultyAdmVo);
						//logger.info("=========================================================");
					} else {
						m.setUpdId(Utils.getUserId());
						m.setOldFaultyRegDate(allFaultyAdmVo.getOldFaultyRegDate());
						allFaultyAdmService.updateFaultyAll(m);
					}
				}
			}
			
			logger.info("불량중량 수정 성공");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("불량중량 수정 에러발생");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다");
			jsonData.put("result", "error");
		}
			
		return jsonData;
	}
	
	//불량중량 수정
	//@RequestMapping(value = "po/updateFaultyAll", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> updateFaultyAll(@RequestBody List<Map<String, Object>> allFaultyAdmList) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("불량중량 수정");
	//	
	//	try {
	//		AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
	//		logger.info("로그인 ID : " + Utils.getUserId());
	//		logger.info("받은 값 : " + allFaultyAdmList);
	//		
	//		float sum = 0;
	//		int count = 0;
	//		List<AllFaultyAdmVo> list = new ArrayList<AllFaultyAdmVo>();
	//		allFaultyAdmVo.setEquipCd(allFaultyAdmList.get(0).get("equipCd").toString());
	//		allFaultyAdmVo.setWorkOrdNo(allFaultyAdmList.get(0).get("workOrdNo").toString());
	//		allFaultyAdmVo.setFaultyRegDate(allFaultyAdmList.get(0).get("faultyRegDate").toString());
	//		allFaultyAdmVo.setGubun(allFaultyAdmList.get(0).get("gubun").toString());
	//		allFaultyAdmVo.setDayNightCd(allFaultyAdmList.get(0).get("dayNightCd").toString());
	//		allFaultyAdmService.deleteFaultyAll(allFaultyAdmVo);
	//		
	//		if (!"empty".equals(allFaultyAdmList.get(0).get("systemCode").toString())) {
	//			for(Map<String, Object> m : allFaultyAdmList) {
	//				allFaultyAdmVo = new AllFaultyAdmVo();
	//				allFaultyAdmVo.setEquipCd(m.get("equipCd").toString());
	//				allFaultyAdmVo.setFaultyRegDate(m.get("faultyRegDate").toString());
	//				allFaultyAdmVo.setOrdDate(m.get("ordDate").toString());
	//				allFaultyAdmVo.setDayNightCd(m.get("dayNightCd").toString());
	//				allFaultyAdmVo.setGubun(m.get("gubun").toString());
	//				allFaultyAdmVo.setSystemCode(String.format("%03d",Integer.parseInt(m.get("systemCode").toString())));
	//				allFaultyAdmVo.setFaultySeq(Integer.parseInt(m.get("faultySeq").toString()));
	//				allFaultyAdmVo.setFaulty(m.get("faulty").toString());
	//				allFaultyAdmVo.setFaultyDesc(m.get("faultyDesc").toString());
	//				allFaultyAdmVo.setWorkOrdNo(m.get("workOrdNo").toString());
	//				allFaultyAdmVo.setRegId(Utils.getUserId());
	//				sum += Float.parseFloat(m.get("faulty").toString());
	//				if(Float.parseFloat(m.get("faulty").toString())>0) {
	//					count++;
	//				}
	//				list.add(allFaultyAdmVo);
	//			}
	//			
	//			for(AllFaultyAdmVo m : list) {
	//				m.setPrcsTotal(Float.toString(sum));
	//				m.setPrcsCnt(Integer.toString(count));
	//				allFaultyAdmService.createFaultyAll(m);
	//			}
	//		}
	//		
	//		logger.info("불량중량 수정 성공");
	//		jsonData.put("result", "ok");
    //
	//	} catch (Exception e) {
	//		logger.info("불량중량 수정 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	/*------------------------------------------------------ 공정불량 끝 ------------------------------------------------------*/
	
	/*------------------------------------------------------ 원자재불량 시작 ------------------------------------------------------*/
	//원자재불량 조회
	//@RequestMapping(value = "po/readMatrlFaulty", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> readMatrlFaultyPOST(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
	//	
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("원자재불량 조회");
	//	logger.info("받은 값 : " + allFaultyAdmVo);
	//	AllFaultyAdmVo allFaultyAdmVo2 = null;
	//	
	//	try {
	//		List<AllFaultyAdmVo> list = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);		
	//		
	//		logger.info("원자재불량 조회성공");
	//		logger.info("원자재불량 조회 값 : " + allFaultyAdmVo);
	//		if(list.size()!=0) {
	//			jsonData.put("readData", list);			
	//			jsonData.put("result", "ok");
	//		} else {
	//			jsonData.put("readData", allFaultyAdmVo2);			
	//			jsonData.put("result", "ok");
	//		}
	//	} catch (Exception e) {
	//		logger.info("원자재불량 조회 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//원자재불량 등록
	//@RequestMapping(value = "po/createMatrlFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> createMatrlFaultyPOST(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("원자재불량 등록");
	//	equipMatrlFaultyAdmVo.setRegId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + equipMatrlFaultyAdmVo);
	//	
	//	try {
	//		equipFaultyAdmService.createMatrlFaulty(equipMatrlFaultyAdmVo);
	//		logger.info("원자재불량 등록 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("원자재불량 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//원자재불량 수정
	//@RequestMapping(value = "po/updateMatrlFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> updateMatrlFaultyPOST(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("원자재불량 수정");		
	//	equipMatrlFaultyAdmVo.setUpdId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + equipMatrlFaultyAdmVo);
	//	
	//	try {
	//		equipFaultyAdmService.updateMatrlFaulty(equipMatrlFaultyAdmVo);
	//		logger.info("원자재불량 수정 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("원자재불량 수정 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	/*------------------------------------------------------ 원자재불량 끝 ------------------------------------------------------*/
	
	/*------------------------------------------------------ 교체불량 시작 ------------------------------------------------------*/
	//교체불량 조회
	//@RequestMapping(value = "po/readReplaceFaulty", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> readReplaceFaultyPOST(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
	//	
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("교체불량 조회");
	//	logger.info("받은 값 : " + equipReplaceFaultyAdmVo);
	//	
	//	try {
	//		equipReplaceFaultyAdmVo = equipFaultyAdmService.readReplaceFaulty(equipReplaceFaultyAdmVo);
	//		logger.info("교체불량 조회성공");
	//		logger.info("교체불량 조회 값 : " + equipReplaceFaultyAdmVo);
	//		jsonData.put("readData", equipReplaceFaultyAdmVo);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("교체불량 조회 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//교체불량 등록
	//@RequestMapping(value = "po/createReplaceFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> createReplaceFaultyPOST(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("교체불량 등록");
	//	equipReplaceFaultyAdmVo.setRegId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + equipReplaceFaultyAdmVo);
	//	
	//	try {
	//		equipFaultyAdmService.createReplaceFaulty(equipReplaceFaultyAdmVo);
	//		logger.info("교체불량 등록 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("교체불량 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//교체불량 수정
	//@RequestMapping(value = "po/updateReplaceFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> updateReplaceFaultyPOST(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("교체불량 수정");
	//	equipReplaceFaultyAdmVo.setUpdId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + equipReplaceFaultyAdmVo);
	//	
	//	try {
	//		equipFaultyAdmService.updateReplaceFaulty(equipReplaceFaultyAdmVo);
	//		logger.info("교체불량 수정 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("교체불량 수정 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	/*------------------------------------------------------ 교체불량 끝 ------------------------------------------------------*/
	
	/*------------------------------------------------------ 설비 트러블 불량 시작 ------------------------------------------------------*/
	//설비 트러블 불량 조회
	//@RequestMapping(value = "po/readTroubleFaulty", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> readTroubleFaultyPOST(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
	//	
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("설비 트러블 불량 조회");
	//	logger.info("받은 값 : " + equipTroubleFaultyAdmVo);
	//	
	//	try {
	//		equipTroubleFaultyAdmVo = equipFaultyAdmService.readTroubleFaulty(equipTroubleFaultyAdmVo);
	//		logger.info("설비 트러블 불량 조회성공");
	//		logger.info("설비 트러블 불량 조회 값 : " + equipTroubleFaultyAdmVo);
	//		jsonData.put("readData", equipTroubleFaultyAdmVo);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("설비 트러블 불량 조회 실패");
	//		e.printStackTrace();
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//설비 트러블 불량 등록
	//@RequestMapping(value = "po/createTroubleFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> createTroubleFaultyPOST(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("설비트러블 불량 등록");
	//	allFaultyAdmVo.setRegId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + allFaultyAdmVo);
	//	String[] cnt = allFaultyAdmVo.getFaulty().split("/");
	//	float sum = 0;
	//	int count = 0;
	//
	//	int idx=0;
	//	for(int i=0; i < cnt.length; i++) {			
	//		if( ((idx+1) % 5) == 0 || ((idx+1) % 6) == 0) {
	//						
	//		} else {
	//			sum += Float.parseFloat(cnt[i]);
	//			if(Float.parseFloat(cnt[i])>0) {
	//				count++;
	//			}
	//		}
	//		if(idx==5) {
	//			idx = 0;
	//		}else {
	//			idx++;
	//		}
	//		
	//	}
	//	allFaultyAdmVo.setPrcsTotal(Float.toString(sum));
	//	allFaultyAdmVo.setPrcsCnt(Integer.toString(count));
	//	
	//	try {
	//		allFaultyAdmService.createFaultyAll(allFaultyAdmVo);
	//		logger.info("공정불량 등록 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("공정불량 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "공정불량 저장 실패하였습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	
	//설비 트러블 불량 수정
	//@RequestMapping(value = "po/updateTroubleFaulty", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> updateTroubleFaultyPOST(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
	//		
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("설비트러블 불량 등록");
	//	allFaultyAdmVo.setRegId(Utils.getUserId());
	//	logger.info("로그인 ID : " + Utils.getUserId());
	//	logger.info("받은 값 : " + allFaultyAdmVo);
	//	String[] cnt = allFaultyAdmVo.getFaulty().split("/");
	//	float sum = 0;
	//	int count = 0;
	//
	//	int idx=0;
	//	for(int i=0; i < cnt.length; i++) {			
	//		if( ((idx+1) % 5) == 0 || ((idx+1) % 6) == 0) {
	//						
	//		} else {
	//			sum += Float.parseFloat(cnt[i]);
	//			if(Float.parseFloat(cnt[i])>0) {
	//				count++;
	//			}
	//		}
	//		if(idx==5) {
	//			idx = 0;
	//		}else {
	//			idx++;
	//		}
	//		
	//	}
	//	allFaultyAdmVo.setPrcsTotal(Float.toString(sum));
	//	allFaultyAdmVo.setPrcsCnt(Integer.toString(count));
	//	
	//	try {
	//		allFaultyAdmService.updateFaultyAll(allFaultyAdmVo);
	//		logger.info("공정불량 등록 성공");
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("공정불량 등록 실패");
	//		e.printStackTrace();
	//		jsonData.put("message", "공정불량 저장 실패하였습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//	
	//	return jsonData;
	//}
	/*------------------------------------------------------ 설비 트러블 불량 끝 ------------------------------------------------------*/

}