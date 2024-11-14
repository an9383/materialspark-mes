package mes.web.bm;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.web.ut.Utils;

@Controller
public class SystemCommonController {
	
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(SystemCommonController.class);
	
	//시스템공통정보 메인
	@RequestMapping(value = "/bmsc0050", method = RequestMethod.GET)
	public String systemCommonGroupMain(Locale locale, Model model) throws Exception {	
		logger.info("시스템공통정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );

		return "bm/bmsc0050";
	}	

	//시스템공통그룹 목록조회
	@RequestMapping(value = "/bm/systemCommonGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemCommonGroupDataList(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시스템공통그룹 목록조회");
		try {
			List<SystemCommonGroupVo> systemCommonGroupList = systemCommonGroupService.listAll(systemCommonGroupVo);
			jsonData.put("data", systemCommonGroupList);
			//jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통코드 목록조회
	@RequestMapping(value = "/bm/systemCommonCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemCommonCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시스템공통코드 목록조회");
		try {
			systemCommonCodeVo.setUseYnCd("Y");
			List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeList);
			jsonData.put("result", "ok");	
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통그룹 상세조회
	@RequestMapping(value = "/bm/systemCommonGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemCommonGroupView(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통그룹 등록
	@RequestMapping(value = "/bm/systemCommonGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> systemCommonGroupCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		systemCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			SystemCommonGroupVo systemCommonGroupInfo = systemCommonGroupService.read(systemCommonGroupVo);
			
			if(systemCommonGroupInfo == null || systemCommonGroupInfo.getBaseGroupCd() == null) {
				systemCommonGroupService.create(systemCommonGroupVo);
				systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
				logger.info("systemCommonGroup 생성 완료 : " + systemCommonGroupVo);
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통그룹 수정
	@RequestMapping(value = "/bm/systemCommonGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> systemCommonGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통그룹 : "+systemCommonGroupVo);
		try {
			systemCommonGroupVo.setUpdId(Utils.getUserId());
		    systemCommonGroupService.update(systemCommonGroupVo);
		    systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		    jsonData.put("data", systemCommonGroupVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통코드 상세조회
	@RequestMapping(value = "/bm/systemCommonCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> systemCommonCodeView(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 상세조회 : "+systemCommonCodeVo);
		try {
			systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("시스템공통코드 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통코드 등록
	@RequestMapping(value = "/bm/systemCommonCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> systemCommonCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 등록 = "+systemCommonCodeVo);
		
   		try {		
			systemCommonCodeVo.setRegId(Utils.getUserId());
			SystemCommonCodeVo systemCommonCodeInfo = systemCommonCodeService.read(systemCommonCodeVo);

			if(systemCommonCodeInfo == null || systemCommonCodeInfo.getBaseCd() == null) {
				systemCommonCodeService.create(systemCommonCodeVo);
				systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("시스템공통그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통코드 수정
	@RequestMapping(value = "/bm/systemCommonCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> systemCommonCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 수정 : "+systemCommonCodeVo);
   		try {
   			systemCommonCodeVo.setUpdId(Utils.getUserId());
		    systemCommonCodeService.update(systemCommonCodeVo);
		    systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		    jsonData.put("data", systemCommonCodeVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("시스템공통코드 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//시스템공통그룹 SEQ(baseGroupCd) 조회
	@RequestMapping(value = "/bm/readGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonGroupVo systemCommonGroupVo;		
		try {
			systemCommonGroupVo = systemCommonGroupService.readGroupSeq();
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//시스템공통그룹 SEQ(baseCd) 조회
	@RequestMapping(value = "/bm/readCommonSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readCommonSeq(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonCodeVo systemCommonCodeVo;
		try {
			systemCommonCodeVo = systemCommonCodeService.readCommonSeq(systemCommonGroupVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//시스템공통정보 외관검사만
	@RequestMapping(value = "/bmsc0150", method = RequestMethod.GET)
	public String bmsc0150(Locale locale, Model model) throws Exception {	
		logger.info("시스템공통정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );

		return "bm/bmsc0150";
	}
	
}