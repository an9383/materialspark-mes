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
import mes.service.bm.DowntimeCodeService;
import mes.service.bm.DowntimeGroupService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class DowntimeController {
	
	@Inject
	private DowntimeGroupService downtimeGroupService;
	@Inject
	private DowntimeCodeService downtimeCodeService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(DowntimeController.class);
	
	//비가동정보 메인
	@RequestMapping(value = "/bmsc0110", method = RequestMethod.GET)
	public String bmsc0110Get(Locale locale, Model model) throws Exception {	
		logger.info("비가동정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> downtimeCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", downtimeCodeList );

		return "bm/bmsc0110";
	}	

	//비가동그룹 목록조회
	@RequestMapping(value = "/bm/downtimeGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> downtimeGroupDataList(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동그룹 목록조회");
		try {		
			List<SystemCommonGroupVo> downtimeGroupList = downtimeGroupService.listAll();
			jsonData.put("data", downtimeGroupList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("비가동그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동코드 목록조회
	@RequestMapping(value = "/bm/downtimeCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> downtimeCodeDataList(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동코드 목록조회");
		try {
			systemCommonCodeVo.setUseYnCd("Y");
			List<SystemCommonCodeVo> downtimeCodeList = downtimeCodeService.listAll(systemCommonCodeVo);
			jsonData.put("data", downtimeCodeList);
			jsonData.put("result", "ok");	
	 	} catch (Exception e) {
			logger.info("비가동그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동그룹 상세조회
	@RequestMapping(value = "/bm/downtimeGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> downtimeGroupView(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			systemCommonGroupVo = downtimeGroupService.read(systemCommonGroupVo);
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("비가동그룹 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동그룹 등록
	@RequestMapping(value = "/bm/downtimeGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> downtimeGroupCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		systemCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			SystemCommonGroupVo downtimeGroupInfo = downtimeGroupService.read(systemCommonGroupVo);
			
			if(downtimeGroupInfo == null || downtimeGroupInfo.getBaseGroupCd() == null) {
				downtimeGroupService.create(systemCommonGroupVo);
				systemCommonGroupVo = downtimeGroupService.read(systemCommonGroupVo);
				logger.info("downtimeGroup 생성 완료 : " + systemCommonGroupVo);
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", systemCommonGroupVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("비가동그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동그룹 수정
	@RequestMapping(value = "/bm/downtimeGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> downtimeGroupUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("비가동그룹 : "+systemCommonGroupVo);
		try {
			systemCommonGroupVo.setUpdId(Utils.getUserId());
		    downtimeGroupService.update(systemCommonGroupVo);
		    systemCommonGroupVo = downtimeGroupService.read(systemCommonGroupVo);
		    jsonData.put("data", systemCommonGroupVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("비가동그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동코드 상세조회
	@RequestMapping(value = "/bm/downtimeCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> downtimeCodeView(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("비가동코드 상세조회 : "+systemCommonCodeVo);
		try {
			systemCommonCodeVo = downtimeCodeService.read(systemCommonCodeVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("비가동코드 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동코드 등록
	@RequestMapping(value = "/bm/downtimeCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> downtimeCodeCreatePOST(SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("비가동코드 등록 = "+systemCommonCodeVo);
		
   		try {		
			systemCommonCodeVo.setRegId(Utils.getUserId());
			SystemCommonCodeVo downtimeCodeInfo = downtimeCodeService.read(systemCommonCodeVo);

			if(downtimeCodeInfo == null || downtimeCodeInfo.getBaseCd() == null) {
				downtimeCodeService.create(systemCommonCodeVo);
				systemCommonCodeVo = downtimeCodeService.read(systemCommonCodeVo);
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("data", systemCommonCodeVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("비가동그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동코드 수정
	@RequestMapping(value = "/bm/downtimeCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> downtimeCodeUpdate (SystemCommonCodeVo systemCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("비가동코드 수정 : "+systemCommonCodeVo);
   		try {
   			systemCommonCodeVo.setUpdId(Utils.getUserId());
		    downtimeCodeService.update(systemCommonCodeVo);
		    systemCommonCodeVo = downtimeCodeService.read(systemCommonCodeVo);
		    jsonData.put("data", systemCommonCodeVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("비가동코드 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//비가동그룹 SEQ(baseGroupCd) 조회
	@RequestMapping(value = "/bm/readDowntimeGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readDowntimeGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonGroupVo systemCommonGroupVo;		
		try {
			systemCommonGroupVo = downtimeGroupService.readGroupSeq();
			jsonData.put("data", systemCommonGroupVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//비가동그룹 SEQ(baseCd) 조회
	@RequestMapping(value = "/bm/readDowntimeCommonSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readDowntimeCommonSeq(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		SystemCommonCodeVo systemCommonCodeVo;
		try {
			systemCommonCodeVo = downtimeCodeService.readCommonSeq(systemCommonGroupVo);
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