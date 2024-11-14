package mes.web.ei;

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
public class EquipLinkController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(EquipLinkController.class);
	
	//공정실적관리 작업지시 페이지
	@RequestMapping(value = "/eisc0010", method = RequestMethod.GET)
	public String EquipLinkMain(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList );		
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "ei/eisc0010";
	}
	
	//공정실적관리 작업지시 페이지
	@RequestMapping(value = "/eisc3020", method = RequestMethod.GET)
	public String eisc3020(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList );		
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "ei/eisc3020";
	}
	
	//생산실적 메인
	@RequestMapping(value = "/eisc0020", method = RequestMethod.GET)
	public String EquipLinkMain2(Locale locale, Model model) throws Exception {
		
		logger.info("생산실적 메인");

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("028"); // 주야구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dayNightCd", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "ei/eisc0020";
	}	
	
}