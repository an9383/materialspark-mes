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
import mes.service.bm.ProcessCodeService;
import mes.service.bm.ProcessGroupService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class ProcessController {
	
	@Inject
	private ProcessGroupService processGroupService;
	@Inject
	private ProcessCodeService processCodeService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(ProcessController.class);
	
	//공정순서정보 메인
	@RequestMapping(value = "/bmsc0100", method = RequestMethod.GET)
	public String bmsc0100(Locale locale, Model model) throws Exception {	
		logger.info("공정순서정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> processCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", processCodeList );

		return "bm/bmsc0100";
	}	

	//공정순서그룹 목록조회
	@RequestMapping(value = "/bm/processGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> processGroupDataList(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정순서그룹 목록조회");
		try {		
			List<SystemCommonGroupVo> processGroupList = processGroupService.listAll();
			jsonData.put("data", processGroupList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("공정순서그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서코드 목록조회
	@RequestMapping(value = "/bm/processCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> processCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("공정순서코드 목록조회");
		try {
			systemCommonCodeVo.setUseYnCd("Y");
			List<SystemCommonCodeVo> processCodeList = processCodeService.listAll(systemCommonCodeVo);
			jsonData.put("data", processCodeList);
			jsonData.put("result", "ok");	
	 	} catch (Exception e) {
			logger.info("공정순서그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서그룹 상세조회
	@RequestMapping(value = "/bm/processGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> processGroupView(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			systemCommonGroupVo = processGroupService.read(systemCommonGroupVo);
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("공정순서그룹 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서그룹 등록
	@RequestMapping(value = "/bm/processGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> processGroupCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		systemCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			SystemCommonGroupVo processGroupInfo = processGroupService.read(systemCommonGroupVo);
			
			if(processGroupInfo == null || processGroupInfo.getBaseGroupCd() == null) {
				processGroupService.create(systemCommonGroupVo);
				systemCommonGroupVo = processGroupService.read(systemCommonGroupVo);
				logger.info("processGroup 생성 완료 : " + systemCommonGroupVo);
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("공정순서그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서그룹 수정
	@RequestMapping(value = "/bm/processGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> processGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("공정순서그룹 : "+systemCommonGroupVo);
		try {
			systemCommonGroupVo.setUpdId(Utils.getUserId());
		    processGroupService.update(systemCommonGroupVo);
		    systemCommonGroupVo = processGroupService.read(systemCommonGroupVo);
		    jsonData.put("data", systemCommonGroupVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("공정순서그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서코드 상세조회
	@RequestMapping(value = "/bm/processCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> processCodeView(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("공정순서코드 상세조회 : "+systemCommonCodeVo);
		try {
			systemCommonCodeVo = processCodeService.read(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("공정순서코드 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서코드 등록
	@RequestMapping(value = "/bm/processCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> processCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("공정순서코드 등록 = "+systemCommonCodeVo);
		
   		try {		
			systemCommonCodeVo.setRegId(Utils.getUserId());
			SystemCommonCodeVo processCodeInfo = processCodeService.read(systemCommonCodeVo);

			if(processCodeInfo == null || processCodeInfo.getBaseCd() == null) {
				processCodeService.create(systemCommonCodeVo);
				systemCommonCodeVo = processCodeService.read(systemCommonCodeVo);
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("공정순서그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서코드 수정
	@RequestMapping(value = "/bm/processCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> processCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("공정순서코드 수정 : "+systemCommonCodeVo);
   		try {
   			systemCommonCodeVo.setUpdId(Utils.getUserId());
		    processCodeService.update(systemCommonCodeVo);
		    systemCommonCodeVo = processCodeService.read(systemCommonCodeVo);
		    jsonData.put("data", systemCommonCodeVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("공정순서코드 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//공정순서그룹 SEQ(baseGroupCd) 조회
	@RequestMapping(value = "/bm/readProcessGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readProcessGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonGroupVo systemCommonGroupVo;		
		try {
			systemCommonGroupVo = processGroupService.readGroupSeq();
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//공정순서그룹 SEQ(baseCd) 조회
	@RequestMapping(value = "/bm/readProcessCommonSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readProcessCommonSeq(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonCodeVo systemCommonCodeVo;
		try {
			systemCommonCodeVo = processCodeService.readCommonSeq(systemCommonGroupVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
}