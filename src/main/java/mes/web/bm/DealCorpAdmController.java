package mes.web.bm;

import java.text.DateFormat;
import java.util.Date;
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

import mes.domain.bm.DealCorpAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.DealCorpAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class DealCorpAdmController {
	@Inject
	private DealCorpAdmService dealCorpAdmService;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	
	private static final Logger logger = LoggerFactory.getLogger(DealCorpAdmController.class);

	//거래처정보관리 메인
	@RequestMapping(value = "/bmsc0020", method = RequestMethod.GET)
	public String dealCorpAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("거래처정보관리 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		jsonData.put("useYnCd", systemCommonCodeList);
		model.addAttribute("useYnCd", systemCommonCodeList );
		model.addAttribute("useYnCdJson", jsonData );
		
		systemCommonCodeVo.setBaseGroupCd("123"); // 거래처정보
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dealCorpInfoCd", systemCommonCodeList);
		
		return "bm/bmsc0020";
	}

	//거래처정보관리 목록조회
	@RequestMapping(value = "/bm/dealCorpDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> dealCorpDataList(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보관리 목록조회");
		try {		
			List<DealCorpAdmVo> dealCorpAdmData = dealCorpAdmService.listAll(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmData);
		} catch (Exception e) {
			logger.info("거래처정보관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//거래처정보관리 상세조회
	@RequestMapping(value = "/bm/dealCorpData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> dealCorpData(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보관리 상세조회");
		try {		
			dealCorpAdmVo = dealCorpAdmService.read(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmVo);
			
		} catch (Exception e) {
			logger.info("거래처정보관리 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//거래처정보관리 등록
	@RequestMapping(value = "/bm/dealCorpCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpCreate(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보관리 등록");
		try {			
			String dealCorpCd = dealCorpAdmService.selectDealCorpSeqCd();
			dealCorpAdmVo.setDealCorpCd(dealCorpCd);
			dealCorpAdmVo.setRegId(Utils.getUserId());
			dealCorpAdmService.create(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("거래처정보관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//거래처정보관리 수정
	@RequestMapping(value = "/bm/dealCorpUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> dealCorpUpdate(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("거래처정보관리 수정");
		try {		
			dealCorpAdmVo.setUpdId(Utils.getUserId());
			dealCorpAdmService.update(dealCorpAdmVo);
			jsonData.put("data", dealCorpAdmVo);
			jsonData.put("result", "ok");		
		} catch (Exception e) {
			logger.info("거래처정보관리 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//거래처정보관리 메인
	@RequestMapping(value = "/cmsc0020", method = RequestMethod.GET)
	public String dealCorpAdmPop(Locale locale, Model model) throws Exception {
		
		logger.info("거래처정보관리 팝업");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );

		return "cm/cmsc0020";
	}	
		
}
