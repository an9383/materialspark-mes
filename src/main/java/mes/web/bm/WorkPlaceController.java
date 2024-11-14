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
import mes.service.bm.WorkPlaceCodeService;
import mes.service.bm.WorkPlaceGroupService;
import mes.web.ut.Utils;

@Controller
public class WorkPlaceController {
	
	@Inject
	private WorkPlaceGroupService workPlaceGroupService;
	@Inject
	private WorkPlaceCodeService workPlaceCodeService;
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(WorkPlaceController.class);
	
	//시스템공통정보 메인
	@RequestMapping(value = "/bmsc0080", method = RequestMethod.GET)
	public String bmsc0080(Locale locale, Model model) throws Exception {	
		logger.info("시스템공통정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );

		return "bm/bmsc0080";
	}	

	//시스템공통그룹 목록조회
	@RequestMapping(value = "/bm/workPlaceGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workPlaceGroupDataList(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시스템공통그룹 목록조회");
		try {		
			List<SystemCommonGroupVo> workPlaceGroupList = workPlaceGroupService.listAll();
			jsonData.put("data", workPlaceGroupList);
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
	@RequestMapping(value = "/bm/workPlaceCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workPlaceCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시스템공통코드 목록조회");
		try {
			systemCommonCodeVo.setUseYnCd("Y");
			List<SystemCommonCodeVo> workPlaceCodeList = workPlaceCodeService.listAll(systemCommonCodeVo);
			jsonData.put("data", workPlaceCodeList);
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
	@RequestMapping(value = "/bm/workPlaceGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workPlaceGroupView(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			systemCommonGroupVo = workPlaceGroupService.read(systemCommonGroupVo);
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
	@RequestMapping(value = "/bm/workPlaceGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workPlaceGroupCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		systemCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			SystemCommonGroupVo workPlaceGroupInfo = workPlaceGroupService.read(systemCommonGroupVo);
			
			if(workPlaceGroupInfo == null || workPlaceGroupInfo.getBaseGroupCd() == null) {
				workPlaceGroupService.create(systemCommonGroupVo);
				systemCommonGroupVo = workPlaceGroupService.read(systemCommonGroupVo);
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
	@RequestMapping(value = "/bm/workPlaceGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> workPlaceGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통그룹 : "+systemCommonGroupVo);
		try {
			systemCommonGroupVo.setUpdId(Utils.getUserId());
		    workPlaceGroupService.update(systemCommonGroupVo);
		    systemCommonGroupVo = workPlaceGroupService.read(systemCommonGroupVo);
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
	@RequestMapping(value = "/bm/workPlaceCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workPlaceCodeView(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 상세조회 : "+systemCommonCodeVo);
		try {
			systemCommonCodeVo = workPlaceCodeService.read(systemCommonCodeVo);
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
	@RequestMapping(value = "/bm/workPlaceCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> workPlaceCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 등록 = "+systemCommonCodeVo);
		
   		try {		
			systemCommonCodeVo.setRegId(Utils.getUserId());
			SystemCommonCodeVo workPlaceCodeInfo = workPlaceCodeService.read(systemCommonCodeVo);

			if(workPlaceCodeInfo == null || workPlaceCodeInfo.getBaseCd() == null) {
				workPlaceCodeService.create(systemCommonCodeVo);
				systemCommonCodeVo = workPlaceCodeService.read(systemCommonCodeVo);
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
	@RequestMapping(value = "/bm/workPlaceCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workPlaceCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("시스템공통코드 수정 : "+systemCommonCodeVo);
   		try {
   			systemCommonCodeVo.setUpdId(Utils.getUserId());
		    workPlaceCodeService.update(systemCommonCodeVo);
		    systemCommonCodeVo = workPlaceCodeService.read(systemCommonCodeVo);
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
	@RequestMapping(value = "/bm/readWorkPlaceGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readWorkPlaceGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonGroupVo systemCommonGroupVo;		
		try {
			systemCommonGroupVo = workPlaceGroupService.readGroupSeq();
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
	@RequestMapping(value = "/bm/readWorkPlaceSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readWorkPlaceSeq(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonCodeVo systemCommonCodeVo;
		try {
			systemCommonCodeVo = workPlaceCodeService.readCommonSeq(systemCommonGroupVo);
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