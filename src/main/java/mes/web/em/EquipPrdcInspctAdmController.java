package mes.web.em;

import java.util.Calendar;
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
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.em.EquipPrdcInspctAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.EquipPrdcInspctAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class EquipPrdcInspctAdmController {

	@Inject
	private EquipPrdcInspctAdmService equipPrdcInspctAdmService;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
		
	private static final Logger logger = LoggerFactory.getLogger(EquipPrdcInspctAdmController.class);

	//정기검사관리 페이지
	@RequestMapping(value = "/emsc0030", method = RequestMethod.GET)
	public String inspctResultGet(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("정기검사관리 메인");
		String today = DateUtil.getToday("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();		
		cal.set(Integer.parseInt(today.substring(0,4)),Integer.parseInt(today.substring(5,7))-1,Integer.parseInt(today.substring(8,10)));
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		model.addAttribute("serverDate", today);
		model.addAttribute("lastDay", cal.getActualMaximum(Calendar.DAY_OF_MONTH));
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("038"); // 정기검사결과
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspctResult", systemCommonCodeList );

		return "em/emsc0030";
	}
	
	//정기검사관리 목록 조회
	@RequestMapping(value = "/em/equipPrdcInspctDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipPrdcInspctDataList(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo1) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("정기검사관리 빈 목록 조회" + equipPrdcInspctAdmVo1);
		String today = DateUtil.getToday("yyyy-MM-dd");		
		//Calendar cal = Calendar.getInstance();		
		//cal.set(Integer.parseInt(today.substring(0,4)),Integer.parseInt(equipPrdcInspctAdmVo1.getInspctRegDate().substring(4,6))-1, equipPrdcInspctAdmVo1.getInspctDay());		
		//int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);	
		
		try {
			logger.info("정기검사관리 빈 목록 조회");
			List<EquipPrdcInspctAdmVo> equipPrdcInspctAdmList = equipPrdcInspctAdmService.listAll(equipPrdcInspctAdmVo1);
			//logger.info("정기검사관리 빈 목록 조회111111111111111111111111111" + equipPrdcInspctAdmList);
			jsonData.put("data", equipPrdcInspctAdmList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("정기검사관리 빈 목록 조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		/*
		for(int i=0; i < equipPrdcInspctAdmList.size(); i++) {
			EquipPrdcInspctAdmVo equipPrdcInspctAdmVo = new EquipPrdcInspctAdmVo();
			equipPrdcInspctAdmVo = equipPrdcInspctAdmList.get(i);	
			equipPrdcInspctAdmVo.setLastDay(i+1);
			equipPrdcInspctAdmList.set(i, equipPrdcInspctAdmVo);			
		}	

		for(int i=equipPrdcInspctAdmList.size(); i < lastDay; i++) {
			EquipPrdcInspctAdmVo equipPrdcInspctAdmVo = new EquipPrdcInspctAdmVo();
			equipPrdcInspctAdmVo.setLastDay(i+1);
			equipPrdcInspctAdmList.add(i, equipPrdcInspctAdmVo);		
		}
		*/
		return jsonData;
	}	
	
	
	//정기검사관리 상세 목록 조회 - 미사용??? 확인필요
	@RequestMapping(value = "/em/equipPrdcInspctAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipPrdcInspctAdmDataList(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("정기검사관리 상세 조회");
		try {
			logger.info("정기검사관리 빈 목록 조회");
			equipPrdcInspctAdmVo.setInspctRegDate(equipPrdcInspctAdmVo.getInspctRegDate() + String.format("%02d",equipPrdcInspctAdmVo.getInspctDay()));			
			equipPrdcInspctAdmVo = equipPrdcInspctAdmService.read(equipPrdcInspctAdmVo);		
			jsonData.put("data", equipPrdcInspctAdmVo);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("정기검사관리 상세조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//정기검사관리 등록
	@RequestMapping(value = "/em/equipPrdcInspctAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipPrdcInspctAdmCreate(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("정기검사관리 등록");
		try {
			equipPrdcInspctAdmVo.setRegId(Utils.getUserId());
			equipPrdcInspctAdmVo.setInspctRegDate(equipPrdcInspctAdmVo.getInspctRegDate() + String.format("%02d",equipPrdcInspctAdmVo.getInspctDay()));		
			equipPrdcInspctAdmService.create(equipPrdcInspctAdmVo);
			jsonData.put("result", "ok");
			
		} catch(Exception e) {
			logger.info("정기검사관리 등록 에러 발생");
			jsonData.put("result", "fail");
			jsonData.put("message", "시스템오류가 발생했습니다.");
			e.printStackTrace();
		}
		
		return jsonData;
	}
	
	//정기검사관리 수정
	@RequestMapping(value = "/em/equipPrdcInspctAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipPrdcInspctAdmUpdate(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("정기검사관리 수정");
		try {
			equipPrdcInspctAdmVo.setRegId(Utils.getUserId());
			equipPrdcInspctAdmVo.setInspctRegDate(equipPrdcInspctAdmVo.getInspctRegDate() + String.format("%02d",equipPrdcInspctAdmVo.getInspctDay()));		
			equipPrdcInspctAdmService.delete(equipPrdcInspctAdmVo);
			equipPrdcInspctAdmService.create(equipPrdcInspctAdmVo);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			jsonData.put("result", "fail");
			jsonData.put("message", "시스템오류가 발생했습니다.");
			e.printStackTrace();
		}
		
		return jsonData;
	}
	
	
	
	
}