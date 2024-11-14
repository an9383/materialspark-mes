package mes.web.wm;

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
import mes.domain.wm.LotTraceVo;
import mes.service.wm.LotTraceService;
import mes.web.ut.DateUtil;

@Controller
public class LotTraceController {

	@Inject
	private LotTraceService lotTraceService;

	private static final Logger logger = LoggerFactory.getLogger(LotTraceController.class);

	//생산관리 - LOT추적
	@RequestMapping(value = "/wmsc0060", method = RequestMethod.GET)
	public String lotTraceMain(Locale locale, Model model) throws Exception {

		logger.info("LOT추적 메인");

		String todate = DateUtil.getToday("yyyy-mm-dd");
		model.addAttribute("serverDate", todate);

		return "wm/wmsc0060";
	}

	//포장별 작지투입 자재 목록 조회
	@RequestMapping(value = "/wm/workOrdMatrlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdMatrlList(LotTraceVo lotTraceVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("포장별 작지투입 자재정보 목록 조회 = " + lotTraceVo);
		//String Code = "";
		try {
			List<LotTraceVo> workOrdMatrlList = lotTraceService.workOrdMatrlList(lotTraceVo);
			jsonData.put("data", workOrdMatrlList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("포장별 작지투입 자재정보 목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "Lot추적 자재목록 조회중 오류가 발생했습니다.<br/> 작지의 자재정보를 확인해 주세요.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//작지 자재투입 생산진행 상세내역 조회
	@RequestMapping(value = "/wm/workOrdMatrlDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdMatrlDtlList(LotTraceVo lotTraceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("포장별 작지투입 자재정보 목록 조회 = " + lotTraceVo);
		//String Code = "";
		
		try {
			List<LotTraceVo> workOrdMatrlDtlList = lotTraceService.workOrdMatrlDtlList(lotTraceVo);
			jsonData.put("data", workOrdMatrlDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작지 자재투입 생산진행 상세내역 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "Lot추적 상세 조회중 오류가 발생했습니다.<br/> 작지의 자재정보를 확인해 주세요.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
}