package mes.web.em;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.em.EquipRepairHistAdmVo;
import mes.service.em.EquipRepairHistAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class EquipRepairHistAdmController {

	@Inject
	private EquipRepairHistAdmService equipRepairHistAdmService;
		
	private static final Logger logger = LoggerFactory.getLogger(EquipRepairHistAdmController.class);

	// 설비보전이력관리 페이지
	@RequestMapping(value = "/emsc0010", method = RequestMethod.GET)
	public String emsc010GET(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("repairDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("repairDateTo", DateUtil.getToday("yyyy-mm-dd") );
		logger.info("설비보전이력관리 메인");
		
		return "em/emsc0010";
	}
	

	
	
	
	
	
	
	// 설비코드관리 페이지
	@RequestMapping(value = "/emsc0040", method = RequestMethod.GET)
	public String emsc0040GET(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("repairDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("repairDateTo", DateUtil.getToday("yyyy-mm-dd") );
		logger.info("수리이력조회 메인");
		
		return "em/emsc0040";
	}
	
	// memsInfo 페이지
	@RequestMapping(value = "/emsc0050", method = RequestMethod.GET)
	public String emsc0050(Model model, HttpServletRequest request) throws Exception {
		
		model.addAttribute("repairDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("repairDateTo", DateUtil.getToday("yyyy-mm-dd") );
		logger.info("memsInfo조회 메인");
		
		return "em/emsc0050";
	}
	
	//수리이력조회
	@RequestMapping(value = "/em/repairDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> repairDataListGET(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		
		logger.info("수리이력리스트 조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();

		try {
			List<EquipRepairHistAdmVo> equipRepairHistList = equipRepairHistAdmService.listAll(equipRepairHistAdmVo);
			jsonData.put("data", equipRepairHistList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수리이력리스트 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;		
	}
	
	//상세조회
	@RequestMapping(value = "/em/repairDataView", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> repairDataViewPOST(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		
		logger.info("수리이력 상세 조회");
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		
		try {
			equipRepairHistAdmVo = equipRepairHistAdmService.read(equipRepairHistAdmVo);
			equipRepairHistAdmVo.setTroubleDateTime(equipRepairHistAdmVo.getTroubleDate().substring(9));
			equipRepairHistAdmVo.setRepairDateTime(equipRepairHistAdmVo.getRepairDate().substring(9));
			jsonData.put("data", equipRepairHistAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("수리이력 상세 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	
	//설비 수리이력 등록
	@RequestMapping(value = "/em/equipRepairHistAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipRepairHistAdmCreate(HttpServletRequest request, EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 수리이력코드 등록");
				
		equipRepairHistAdmVo.setRepairRegDate(DateUtil.getToday("yyyymmdd"));
		equipRepairHistAdmVo.setRegId(Utils.getUserId());
		
		try {
			equipRepairHistAdmService.create(equipRepairHistAdmVo);		
			logger.info("설비 수리이력코드 등록 성공");
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("설비 수리이력코드 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
		
	//설비 수리이력  수정
	@RequestMapping(value = "/em/equipRepairHistAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipRepairHistAdmUpdate(HttpServletRequest request, EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비 수리이력코드 수정");
		equipRepairHistAdmVo.setUpdId(Utils.getUserId());
		
		try {
			equipRepairHistAdmService.update(equipRepairHistAdmVo);
			logger.info("설비 수리이력코드 수정 성공");
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("설비 수리이력코드 수정 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}	
	
	//등록일자 생성
	@RequestMapping(value = "/em/repairNoCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuIdCreate() throws Exception {
		
		EquipRepairHistAdmVo equipRepairHistAdmVo = new EquipRepairHistAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
		Date time = new Date();
		String time1 = format1.format(time);
		String seqSt = equipRepairHistAdmService.regSeq(time1);
		int seqStart = Integer.valueOf(seqSt);
		
		String tmp= String.format("%03d", seqStart); 
		String repairNo = time1 + "-" + tmp;
		equipRepairHistAdmVo.setRepairNo(repairNo);
		
		jsonData.put("data", equipRepairHistAdmVo);
		
		return jsonData;
	
	}
	
	//memsInfo_조회
	@RequestMapping(value = "/em/memsInfoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> memsInfoList(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		Map<String, Object>	jsonData = new HashMap<String, Object>();
		try {
			logger.info("memsInfo_조회");
			List<EquipRepairHistAdmVo> memsInfoList = equipRepairHistAdmService.memsInfoList(equipRepairHistAdmVo);
			jsonData.put("data", memsInfoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("memsInfo_조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;		
	}
	
}