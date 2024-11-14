package mes.web.qm;

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
import mes.domain.qm.FaultyCommonCodeVo;
import mes.domain.qm.FaultyCommonGroupVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.qm.FaultyCommonCodeService;
import mes.service.qm.FaultyCommonGroupService;
import mes.web.ut.Utils;

@Controller
public class FaultyCommonController {
	
	@Inject
	private FaultyCommonGroupService faultyCommonGroupService;
	@Inject
	private FaultyCommonCodeService faultyCommonCodeService;
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(FaultyCommonController.class);
	
	//불량정보 메인
	@RequestMapping(value = "/qmsc0010", method = RequestMethod.GET)
	public String faultyCommonGroupMain1(Locale locale, Model model) throws Exception {	
		logger.info("불량정보 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );

		return "qm/qmsc0010";
	}	

	//불량그룹 목록조회
	@RequestMapping(value = "/qm/faultyCommonGroupDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyCommonGroupDataList(FaultyCommonGroupVo faultyCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량그룹 목록조회");
		try {		
			List<FaultyCommonGroupVo> faultyCommonGroupList = faultyCommonGroupService.listAll();
			jsonData.put("data", faultyCommonGroupList);
			//jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("불량그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량코드 목록조회
	@RequestMapping(value = "/qm/faultyCommonCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyCommonCodeDataList(FaultyCommonCodeVo faultyCommonCodeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량코드 목록조회");
		try {
			faultyCommonCodeVo.setUseYnCd("Y");
			List<FaultyCommonCodeVo> faultyCommonCodeList = faultyCommonCodeService.listAll(faultyCommonCodeVo);
			jsonData.put("data", faultyCommonCodeList);
			jsonData.put("result", "ok");	
	 	} catch (Exception e) {
			logger.info("불량그룹 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량그룹 상세조회
	@RequestMapping(value = "/qm/faultyCommonGroupView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyCommonGroupView(FaultyCommonGroupVo faultyCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			faultyCommonGroupVo = faultyCommonGroupService.read(faultyCommonGroupVo);
			jsonData.put("data", faultyCommonGroupVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("불량그룹 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량그룹 등록
	@RequestMapping(value = "/qm/faultyCommonGroupCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> faultyCommonGroupCreate(FaultyCommonGroupVo faultyCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		faultyCommonGroupVo.setRegId(Utils.getUserId());
		try {		
			FaultyCommonGroupVo faultyCommonGroupInfo = faultyCommonGroupService.read(faultyCommonGroupVo);
			
			if(faultyCommonGroupInfo == null || faultyCommonGroupInfo.getBaseGroupCd() == null) {
				faultyCommonGroupService.create(faultyCommonGroupVo);
				faultyCommonGroupVo = faultyCommonGroupService.read(faultyCommonGroupVo);				
				jsonData.put("data", faultyCommonGroupVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("data", faultyCommonGroupVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("불량그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량그룹 수정
	@RequestMapping(value = "/qm/faultyCommonGroupUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> faultyCommonGroupUpdate(FaultyCommonGroupVo faultyCommonGroupVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("불량그룹 : "+faultyCommonGroupVo);
		try {
			faultyCommonGroupVo.setUpdId(Utils.getUserId());
		    faultyCommonGroupService.update(faultyCommonGroupVo);
		    faultyCommonGroupVo = faultyCommonGroupService.read(faultyCommonGroupVo);
		    jsonData.put("data", faultyCommonGroupVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("불량그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량코드 상세조회
	@RequestMapping(value = "/qm/faultyCommonCodeView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> faultyCommonCodeView(FaultyCommonCodeVo faultyCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("불량코드 상세조회 : "+faultyCommonCodeVo);
		try {
			faultyCommonCodeVo = faultyCommonCodeService.read(faultyCommonCodeVo);
			jsonData.put("data", faultyCommonCodeVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("불량코드 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량코드 등록
	@RequestMapping(value = "/qm/faultyCommonCodeCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> faultyCommonCodeCreatePOST(FaultyCommonCodeVo faultyCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("불량코드 등록 = "+faultyCommonCodeVo);
		
   		try {		
			faultyCommonCodeVo.setRegId(Utils.getUserId());
			FaultyCommonCodeVo faultyCommonCodeInfo = faultyCommonCodeService.read(faultyCommonCodeVo);

			if(faultyCommonCodeInfo == null || faultyCommonCodeInfo.getBaseCd() == null) {
				faultyCommonCodeService.create(faultyCommonCodeVo);
				faultyCommonCodeVo = faultyCommonCodeService.read(faultyCommonCodeVo);
				jsonData.put("data", faultyCommonCodeVo);
				jsonData.put("result", "ok");			
			} else {
				jsonData.put("data", faultyCommonCodeVo);
				jsonData.put("result", "exist");		
			}
	 	} catch (Exception e) {
			logger.info("불량그룹 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량코드 수정
	@RequestMapping(value = "/qm/faultyCommonCodeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> faultyCommonCodeUpdate (FaultyCommonCodeVo faultyCommonCodeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("불량코드 수정 : "+faultyCommonCodeVo);
   		try {
   			faultyCommonCodeVo.setUpdId(Utils.getUserId());
		    faultyCommonCodeService.update(faultyCommonCodeVo);
		    faultyCommonCodeVo = faultyCommonCodeService.read(faultyCommonCodeVo);
		    jsonData.put("data", faultyCommonCodeVo);
		    jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("불량코드 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//불량그룹 SEQ(baseGroupCd) 조회
	@RequestMapping(value = "/qm/readGroupSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readGroupSeq() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		FaultyCommonGroupVo faultyCommonGroupVo;		
		try {
			faultyCommonGroupVo = faultyCommonGroupService.readGroupSeq();
			jsonData.put("data", faultyCommonGroupVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//불량그룹 SEQ(baseCd) 조회
	@RequestMapping(value = "/qm/readCommonSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readCommonSeq(FaultyCommonGroupVo faultyCommonGroupVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<>();
		FaultyCommonCodeVo faultyCommonCodeVo;
		try {
			faultyCommonCodeVo = faultyCommonCodeService.readCommonSeq(faultyCommonGroupVo);
			jsonData.put("data", faultyCommonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
}