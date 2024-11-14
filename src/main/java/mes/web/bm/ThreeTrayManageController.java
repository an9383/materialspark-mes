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
import mes.domain.bm.ThreeTrayManageVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.ThreeTrayManageService;
import mes.web.ut.DateUtil;

@Controller
public class ThreeTrayManageController {
	
	@Inject
	private ThreeTrayManageService threeTrayManageService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(ThreeTrayManageController.class);
	
	//3Tray중량관리 메인
	@RequestMapping(value = "/bmsc0160", method = RequestMethod.GET)
	public String bmsc0100(Locale locale, Model model) throws Exception {	
		logger.info("3Tray중량관리 메인");
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		List<ThreeTrayManageVo> dateList = threeTrayManageService.threeTrayWeightDate();
		model.addAttribute("maxDate", dateList.size() == 0 ? DateUtil.getToday("yyyy-mm-dd") : dateList.get(0).getMaxTrayWeightDate() );
		model.addAttribute("dateList", dateList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		List<SystemCommonCodeVo> systemCommonCodList;
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		systemCommonCodList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodList );

		systemCommonCodeVo.setBaseGroupCd("080"); // 기종코드
		systemCommonCodList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongCd", systemCommonCodList );
		
		return "bm/bmsc0160";
	}	

	//3트레이관리 목록조회
	@RequestMapping(value = "/bm/threeTrayManageList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> threeTrayManageList(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("3트레이관리 목록조회");
		try {
			List<ThreeTrayManageVo> systemCommonGroupList = threeTrayManageService.threeTrayManageList(threeTrayManageVo);
			jsonData.put("data", systemCommonGroupList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3트레이관리 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//3트레이관리 상세조회
	@RequestMapping(value = "/bm/threeTrayManageRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> threeTrayManageRead(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			threeTrayManageVo = threeTrayManageService.threeTrayManageRead(threeTrayManageVo);
			jsonData.put("data", threeTrayManageVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3트레이관리 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//3트레이관리 등록
	@RequestMapping(value = "/bm/threeTrayManageCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> threeTrayManageCreate(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			ThreeTrayManageVo seqVo = threeTrayManageService.threeTrayManageBaseCdSeq(threeTrayManageVo);
			
			threeTrayManageVo.setBaseCd(seqVo.getBaseCd());
			
			threeTrayManageService.threeTrayManageCreate(threeTrayManageVo);
			jsonData.put("data", threeTrayManageVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3트레이관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//3트레이관리일괄 등록
	@RequestMapping(value = "/bm/threeTrayManageBatchCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> threeTrayManageBatchCreate(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			threeTrayManageService.threeTrayManageBatchCreate(threeTrayManageVo);
			jsonData.put("data", threeTrayManageVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3트레이관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//3트레이관리 수정
	@RequestMapping(value = "/bm/threeTrayManageUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> threeTrayManageUpdate(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			threeTrayManageService.threeTrayManageUpdate(threeTrayManageVo);
			jsonData.put("data", threeTrayManageVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3트레이관리수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	

	//3트레이관리 SEQ(baseCd) 조회
	@RequestMapping(value = "/bm/threeTrayManageBaseCdSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> threeTrayManageBaseCdSeq(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			ThreeTrayManageVo systemCommonCodeVo = threeTrayManageService.threeTrayManageBaseCdSeq(threeTrayManageVo);
			jsonData.put("data", systemCommonCodeVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//날짜 검색조건 조회
	@RequestMapping(value = "/bm/threeTrayWeightDate", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> threeTrayWeightDate(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("날짜 검색조건 조회");
		try {
			List<ThreeTrayManageVo> threeTrayWeightDateList = threeTrayManageService.threeTrayWeightDate();
			jsonData.put("data", threeTrayWeightDateList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("날짜 검색조건 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	
	//3Tray 판정
	@RequestMapping(value = "/bm/threeTrayInspection", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> threeTrayInspection(ThreeTrayManageVo threeTrayManageVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("3Tray 판정 조회");
		try {
			List<ThreeTrayManageVo> threeTrayManageList = threeTrayManageService.threeTrayInspection(threeTrayManageVo);
			jsonData.put("data", threeTrayManageList);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("3Tray 판정 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	
	
	
	
}