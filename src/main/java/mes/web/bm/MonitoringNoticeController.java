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

import mes.domain.bm.MonitoringNoticeVo;
import mes.service.bm.MonitoringNoticeService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class MonitoringNoticeController {

	@Inject
	private MonitoringNoticeService monitoringNoticeService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;

	private static final Logger logger = LoggerFactory.getLogger(MonitoringNoticeController.class);

	//모니터링 공지사항 메인
	@RequestMapping(value = "/bmsc0130", method = RequestMethod.GET)
	public String monitoringNoticeMain(Locale locale, Model model) throws Exception {

		logger.info("모니터링 공지사항 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);

		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("082"); // 게시여부
		//List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("posted", systemCommonCodeList );		

		return "bm/bmsc0130";
	}

	//모니터링 공지사항 목록조회
	@RequestMapping(value = "/bm/monitoringNoticeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> monitoringNoticeDataList(MonitoringNoticeVo monitoringNoticeVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모니터링 공지사항 목록조회");
		try {
			List<MonitoringNoticeVo> monitoringNoticeList = monitoringNoticeService.monitoringNoticeList(monitoringNoticeVo);
			jsonData.put("data", monitoringNoticeList);
		} catch (Exception e) {
			logger.info("모니터링 공지사항 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//모니터링 공지사항 상세조회
	@RequestMapping(value = "/bm/monitoringNoticeRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> monitoringNoticeRead(MonitoringNoticeVo monitoringNoticeVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모니터링 공지사항 상세 목록조회");
		try {
			monitoringNoticeVo = monitoringNoticeService.monitoringNoticeRead(monitoringNoticeVo);
			jsonData.put("data", monitoringNoticeVo);
			
		} catch (Exception e) {
			logger.info("모니터링 공지사항 상세 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}

	//모니터링 공지사항 등록
	@RequestMapping(value = "/bm/monitoringNoticeCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monitoringNoticeCreate(MonitoringNoticeVo monitoringNoticeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모니터링 공지사항 등록");
		try {
			int idx = monitoringNoticeService.monitoringNoticeSelectIdx();
			monitoringNoticeVo.setRegId(Utils.getUserId());
			monitoringNoticeVo.setIdx(idx);
			monitoringNoticeService.monitoringNoticeCreate(monitoringNoticeVo);
			jsonData.put("data", monitoringNoticeVo);
			jsonData.put("result", "ok");
			jsonData.put("message", "등록 되었습니다.");
			
		} catch (Exception e) {
			logger.info("모니터링 공지사항 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//모니터링 공지사항 수정
	@RequestMapping(value = "/bm/monitoringNoticeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monitoringNoticeUpdate(MonitoringNoticeVo monitoringNoticeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모니터링 공지사항 수정");
		try {
			monitoringNoticeVo.setUpdId(Utils.getUserId());
			monitoringNoticeService.monitoringNoticeUpdate(monitoringNoticeVo);
			jsonData.put("data", monitoringNoticeVo);
			jsonData.put("message", "수정 되었습니다.");
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("모니터링 공지사항 수정 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

}