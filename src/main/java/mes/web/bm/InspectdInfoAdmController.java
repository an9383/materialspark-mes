package mes.web.bm;

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
import mes.domain.bm.InspectInfoAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class InspectdInfoAdmController {
	
	//@Inject
	//private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private InspectInfoAdmService inspectInfoAdmService;
	@Value("${factoryCode}")
	private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(InspectdInfoAdmController.class);
	
	//품질정보관리 메인
	@RequestMapping(value = "/bmsc0070", method = RequestMethod.GET)
	public String bmsc0070(Locale locale, Model model) throws Exception {	
		logger.info("품질정보관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("040"); // 자재 관리항목
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd041", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("041"); // 원자재 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd042", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("042"); // 가공원자재 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd043", systemCommonCodeList );
		
		return "bm/bmsc0070";
	}	
	
	//품질정보관리 메인
	@RequestMapping(value = "/bmsc3170", method = RequestMethod.GET)
	public String bmsc0170(Locale locale, Model model) throws Exception {	
		logger.info("품질정보관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("040"); // 자재 관리항목
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd041", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("041"); // 원자재 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd042", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("042"); // 가공원자재 관리항목
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("baseCd043", systemCommonCodeList );
		
		return "bm/bmsc3170";
	}	


	//품질정보관리 목록조회
	@RequestMapping(value = "/bm/inspectInfoAdmGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectInfoAdmGroupDataList() throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품질정보 관리 009 조회");
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.inspectList(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeList);
	 	} catch (Exception e) {
			logger.info("품질정보 관리 009 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	
	//품질정보관리 상세조회
	@RequestMapping(value = "/bm/inspectInfoAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectInfoAdmRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			logger.info("품질정보관리 상세조회");
			inspectInfoAdmVo = inspectInfoAdmService.read(inspectInfoAdmVo);			
			Map<String, Object> inspectMap = new HashMap<String, Object>();
			inspectMap = Utils.getInspect(inspectInfoAdmVo);
			
			logger.info("품질정보관리 상세조회 있음");
			jsonData.put("data", inspectMap);
			jsonData.put("result", "ok");			 
				
		} catch (NullPointerException e) {
			logger.info("품질정보관리 상세조회 없음");
			jsonData.put("message", "조회된 값이 없습니다. 생성해 주세요!");
			jsonData.put("result", "fail");
		} catch (Exception e) {
			logger.info("품질정보관리 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}			 
		return jsonData;
	}
	
	//품질정보관리 자재코드별 상세조회
	@RequestMapping(value = "/bm/inspectInfoAdmReadByMatrlCd", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inspectInfoAdmReadByMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			logger.info("품질정보관리 자재코드별 상세조회");
			inspectInfoAdmVo = inspectInfoAdmService.dtlRead(inspectInfoAdmVo);			
			Map<String, Object> inspectMap = new HashMap<String, Object>();
			inspectMap = Utils.getInspect(inspectInfoAdmVo);
			
			logger.info("품질정보관리 자재코드별 상세조회 있음");
			jsonData.put("data", inspectMap);
			jsonData.put("result", "ok");			 
				
		} catch (NullPointerException e) {
			logger.info("품질정보관리 자재코드별 상세조회 없음");
			jsonData.put("message", "조회된 값이 없습니다. 생성해 주세요!");
			jsonData.put("result", "fail");
		} catch (Exception e) {
			logger.info("품질정보관리 자재코드별 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}			 
		return jsonData;
	}
	
	//품질정보관리 등록
	@RequestMapping(value = "/bm/inspectInfoAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectInfoAdmCreate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		inspectInfoAdmVo.setRegId(Utils.getUserId());
		try {
			inspectInfoAdmService.create(inspectInfoAdmVo);
			logger.info("품질정보관리 생성 완료");
			jsonData.put("data", inspectInfoAdmVo);
			jsonData.put("message", "저장되었습니다.");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("품질정보관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//품질정보관리 수정
	@RequestMapping(value = "/bm/inspectInfoAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectInfoAdmUpdate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		inspectInfoAdmVo.setUpdId(Utils.getUserId());
		logger.info("품질정보관리  수정");
		try {
			inspectInfoAdmService.update(inspectInfoAdmVo);
			logger.info("품질정보관리  수정 완료");
			jsonData.put("message", "수정되었습니다.");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("품질정보관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	//품질정보관리(자재코드별) 등록
	@RequestMapping(value = "/bm/inspectInfoAdmCreateByMatrlCd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectInfoAdmCreateByMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		inspectInfoAdmVo.setRegId(Utils.getUserId());
		try {
			inspectInfoAdmService.dtlCreate(inspectInfoAdmVo);
			logger.info("품질정보관리(자재코드별) 생성 완료");
			jsonData.put("data", inspectInfoAdmVo);
			jsonData.put("message", "저장되었습니다.");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("품질정보관리(자재코드별) 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//품질정보관리(자재코드별) 수정
	@RequestMapping(value = "/bm/inspectInfoAdmUpdateByMatrlCd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> inspectInfoAdmUpdateByMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		inspectInfoAdmVo.setUpdId(Utils.getUserId());
		logger.info("품질정보관리(자재코드별)  수정");
		try {
			inspectInfoAdmService.dtlUpdate(inspectInfoAdmVo);
			logger.info("품질정보관리(자재코드별)  수정 완료");
			jsonData.put("message", "수정되었습니다.");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("품질정보관리(자재코드별) 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//시스템공통코드 목록조회
	/*
	 * @RequestMapping(value = "/bm/inspectInfoAdmCodeDataList", method =
	 * RequestMethod.GET) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws
	 * Exception {
	 * 
	 * Map<String, Object> jsonData = new HashMap<String, Object>();
	 * logger.info("시스템공통코드 목록조회"); try { systemCommonCodeVo.setUseYnCd("Y");
	 * List<SystemCommonCodeVo> systemCommonCodeList =
	 * systemCommonCodeService.inspectInfoListAll(systemCommonCodeVo);
	 * jsonData.put("data", systemCommonCodeList); jsonData.put("result", "ok"); }
	 * catch (Exception e) { logger.info("시스템공통그룹 조회 오류"); e.printStackTrace();
	 * jsonData.put("message", "시스템오류가 발생했습니다."); jsonData.put("result", "fail"); }
	 * return jsonData; }
	 */
	

	/*
	 
	 * 
	 * //시스템공통그룹 수정
	 * 
	 * @RequestMapping(value = "/bm/inspectInfoAdmGroupUpdate", method =
	 * RequestMethod.POST) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception { Map<String, Object> jsonData = new HashMap<>();
	 * logger.info("시스템공통그룹 : "+systemCommonGroupVo); try {
	 * systemCommonGroupVo.setUpdId(Utils.getUserId());
	 * systemCommonGroupService.inspectInfoUpdate(systemCommonGroupVo);
	 * systemCommonGroupVo =
	 * systemCommonGroupService.inspectInfoRead(systemCommonGroupVo);
	 * jsonData.put("data", systemCommonGroupVo); jsonData.put("result", "ok"); }
	 * catch (Exception e) { logger.info("시스템공통그룹 등록 오류"); e.printStackTrace();
	 * jsonData.put("message", "시스템오류가 발생했습니다."); jsonData.put("result", "fail"); }
	 * return jsonData; }
	 */
	
	/*
	 * //시스템공통코드 상세조회
	 * 
	 * @RequestMapping(value = "/bm/inspectInfoAdmCodeView", method =
	 * RequestMethod.GET) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmCodeView(SystemCommonCodeVo systemCommonCodeVo) throws
	 * Exception { Map<String, Object> jsonData = new HashMap<>();
	 * logger.info("시스템공통코드 상세조회 : "+systemCommonCodeVo); try { systemCommonCodeVo =
	 * systemCommonCodeService.inspectInfoRead(systemCommonCodeVo);
	 * jsonData.put("data", systemCommonCodeVo); jsonData.put("result", "ok"); }
	 * catch (Exception e) { logger.info("시스템공통코드 상세조회 오류"); e.printStackTrace();
	 * jsonData.put("message", "시스템오류가 발생했습니다."); jsonData.put("result", "fail"); }
	 * return jsonData; }
	 */
	/*
	 * //시스템공통코드 등록
	 * 
	 * @RequestMapping(value = "/bm/inspectInfoAdmCodeCreate", method =
	 * RequestMethod.POST) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws
	 * Exception { Map<String, Object> jsonData = new HashMap<>();
	 * logger.info("시스템공통코드 등록 = "+systemCommonCodeVo);
	 * 
	 * try { systemCommonCodeVo.setRegId(Utils.getUserId()); SystemCommonCodeVo
	 * systemCommonCodeInfo =
	 * systemCommonCodeService.inspectInfoRead(systemCommonCodeVo);
	 * 
	 * if(systemCommonCodeInfo == null || systemCommonCodeInfo.getBaseCd() == null)
	 * { systemCommonCodeService.inspectInfoCreate(systemCommonCodeVo);
	 * systemCommonCodeVo =
	 * systemCommonCodeService.inspectInfoRead(systemCommonCodeVo);
	 * jsonData.put("data", systemCommonCodeVo); jsonData.put("result", "ok"); }
	 * else { jsonData.put("data", systemCommonCodeVo); jsonData.put("result",
	 * "exist"); } } catch (Exception e) { logger.info("시스템공통그룹 등록 오류");
	 * e.printStackTrace(); jsonData.put("message", "시스템오류가 발생했습니다.");
	 * jsonData.put("result", "fail"); } return jsonData; }
	 */
	
	/*
	 * //시스템공통코드 수정
	 * 
	 * @RequestMapping(value = "/bm/inspectInfoAdmCodeUpdate", method =
	 * RequestMethod.POST) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws
	 * Exception { Map<String, Object> jsonData = new HashMap<>();
	 * logger.info("시스템공통코드 수정 : "+systemCommonCodeVo); try {
	 * systemCommonCodeVo.setUpdId(Utils.getUserId());
	 * systemCommonCodeService.inspectInfoUpdate(systemCommonCodeVo);
	 * systemCommonCodeVo =
	 * systemCommonCodeService.inspectInfoRead(systemCommonCodeVo);
	 * jsonData.put("data", systemCommonCodeVo); jsonData.put("result", "ok"); }
	 * catch (Exception e) { logger.info("시스템공통코드 수정 오류"); e.printStackTrace();
	 * jsonData.put("message", "시스템오류가 발생했습니다."); jsonData.put("result", "fail"); }
	 * return jsonData; }
	 */
	
	//시스템공통그룹 SEQ(baseGroupCd) 조회
	//@RequestMapping(value = "/bm/inspectInfoAdmReadGroupSeq", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> inspectInfoAdmReadGroupSeq() throws Exception {
	//	
	//	Map<String, Object> jsonData = new HashMap<>();
	//	SystemCommonGroupVo systemCommonGroupVo;		
	//	try {
	//		systemCommonGroupVo = systemCommonGroupService.inspectInfoReadGroupSeq();
	//		jsonData.put("data", systemCommonGroupVo);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "fail");
	//	}
	//	return jsonData;
	//}
	
	//시스템공통그룹 SEQ(baseCd) 조회
	/*
	 * @RequestMapping(value = "/bm/inspectInfoAdmReadSeq", method =
	 * RequestMethod.GET) public @ResponseBody Map<String, Object>
	 * inspectInfoAdmReadSeq(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception {
	 * 
	 * Map<String, Object> jsonData = new HashMap<>(); SystemCommonCodeVo
	 * systemCommonCodeVo; try { systemCommonCodeVo =
	 * systemCommonCodeService.inspectInfoReadCommonSeq(systemCommonGroupVo);
	 * jsonData.put("data", systemCommonCodeVo); jsonData.put("result", "ok"); }
	 * catch (Exception e) { e.printStackTrace(); jsonData.put("message",
	 * "시스템오류가 발생했습니다."); jsonData.put("result", "fail"); } return jsonData; }
	 */
}