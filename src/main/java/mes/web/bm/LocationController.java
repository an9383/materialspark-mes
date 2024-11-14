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
import mes.service.bm.LocationCodeService;
import mes.service.bm.LocationGroupService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class LocationController {
	
	@Inject
	private LocationGroupService locationGroupService;
	@Inject
	private LocationCodeService locationCodeService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(LocationController.class);
	
	//창고정보정보 메인
	@RequestMapping(value = "/bmsc0090", method = RequestMethod.GET)
	public String bmsc0090Get(Locale locale, Model model) throws Exception {	
		logger.info("창고정보정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> locationCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", locationCodeList );

		return "bm/bmsc0090";
	}	

	//창고정보그룹 목록조회
	@RequestMapping(value = "/bm/locationGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationGroupDataList(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보그룹 목록조회");
		try {		
			List<SystemCommonGroupVo> locationGroupList = locationGroupService.listAll();
			jsonData.put("data", locationGroupList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("창고정보그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보코드 목록조회
	@RequestMapping(value = "/bm/locationCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("창고정보코드 목록조회");
		try {
			systemCommonCodeVo.setUseYnCd("Y");
			List<SystemCommonCodeVo> locationCodeList = locationCodeService.listAll(systemCommonCodeVo);
			jsonData.put("data", locationCodeList);
			jsonData.put("result", "ok");	
	 	} catch (Exception e) {
			logger.info("창고정보그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보그룹 상세조회
	@RequestMapping(value = "/bm/locationGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationGroupView(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			systemCommonGroupVo = locationGroupService.read(systemCommonGroupVo);
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("창고정보그룹 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보그룹 등록
	@RequestMapping(value = "/bm/locationGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationGroupCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		systemCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			SystemCommonGroupVo locationGroupInfo = locationGroupService.read(systemCommonGroupVo);
			
			if(locationGroupInfo == null || locationGroupInfo.getBaseGroupCd() == null) {
				locationGroupService.create(systemCommonGroupVo);
				systemCommonGroupVo = locationGroupService.read(systemCommonGroupVo);
				logger.info("locationGroup 생성 완료 : " + systemCommonGroupVo);
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("창고정보그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보그룹 수정
	@RequestMapping(value = "/bm/locationGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> locationGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("창고정보그룹 : "+systemCommonGroupVo);
		try {
			systemCommonGroupVo.setUpdId(Utils.getUserId());
		    locationGroupService.update(systemCommonGroupVo);
		    systemCommonGroupVo = locationGroupService.read(systemCommonGroupVo);
		    jsonData.put("data", systemCommonGroupVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("창고정보그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보코드 상세조회
	@RequestMapping(value = "/bm/locationCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> locationCodeView(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("창고정보코드 상세조회 : "+systemCommonCodeVo);
		try {
			systemCommonCodeVo = locationCodeService.read(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("창고정보코드 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보코드 등록
	@RequestMapping(value = "/bm/locationCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> locationCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("창고정보코드 등록 = "+systemCommonCodeVo);
		
   		try {		
			systemCommonCodeVo.setRegId(Utils.getUserId());
			SystemCommonCodeVo locationCodeInfo = locationCodeService.read(systemCommonCodeVo);

			if(locationCodeInfo == null || locationCodeInfo.getBaseCd() == null) {
				locationCodeService.create(systemCommonCodeVo);
				systemCommonCodeVo = locationCodeService.read(systemCommonCodeVo);
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("창고정보그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보코드 수정
	@RequestMapping(value = "/bm/locationCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> locationCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("창고정보코드 수정 : "+systemCommonCodeVo);
   		try {
   			systemCommonCodeVo.setUpdId(Utils.getUserId());
		    locationCodeService.update(systemCommonCodeVo);
		    systemCommonCodeVo = locationCodeService.read(systemCommonCodeVo);
		    jsonData.put("data", systemCommonCodeVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("창고정보코드 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//창고정보그룹 SEQ(baseGroupCd) 조회
	@RequestMapping(value = "/bm/readLocationGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readLocationGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonGroupVo systemCommonGroupVo;		
		try {
			systemCommonGroupVo = locationGroupService.readGroupSeq();
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//창고정보그룹 SEQ(baseCd) 조회
	@RequestMapping(value = "/bm/readLocationCommonSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readLocationCommonSeq(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonCodeVo systemCommonCodeVo;
		try {
			systemCommonCodeVo = locationCodeService.readCommonSeq(systemCommonGroupVo);
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