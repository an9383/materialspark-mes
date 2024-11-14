package mes.web.qm;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.DateUtil;

@Controller
public class ReportController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;

	
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	/*------------------------엣지검사 시작------------------------*/
	//품질괄리 -완제품검사 엣지검사
	@RequestMapping(value = "/qmsc0070", method = RequestMethod.GET)
	public String bmsc0030GET(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 성적서관리");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "qm/qmsc0070";
	}

}