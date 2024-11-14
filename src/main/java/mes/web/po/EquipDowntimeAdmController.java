package mes.web.po;

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
import mes.domain.po.EquipDowntimeAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.EquipDowntimeAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class EquipDowntimeAdmController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipDowntimeAdmService equipDowntimeAdmService;

	private static final Logger logger = LoggerFactory.getLogger(EquipDowntimeAdmController.class);

	//비가동사유등록 메인
	@RequestMapping(value = "/posc0060", method = RequestMethod.GET)
	public String mmsc0020GET(Model model, HttpServletRequest request) throws Exception {
		
		logger.info("비가동사유등록 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 주야 구분
		List<SystemCommonCodeVo>  systemCommonCodeList  = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dayNightCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("011"); //  구분
		systemCommonCodeList  = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
				
		return "po/posc0060";
	}
	
	//비가동사유구분 조회
	@RequestMapping(value = "/po/equipDowntimeAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipDowntimeAdmDataList(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유구분 조회 = " + equipDowntimeAdmVo);
		
		try {
			List<EquipDowntimeAdmVo> equipDowntimeAdmData = equipDowntimeAdmService.listAll(equipDowntimeAdmVo);
			jsonData.put("data", equipDowntimeAdmData);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("설비정보관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	}	
	
	//비가동사유구분 등록
	@RequestMapping(value = "/po/equipDowntimeAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipDowntimeAdmCreate(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유구분 등록 = " + equipDowntimeAdmVo);
		try {
			
			equipDowntimeAdmVo.setRegId(Utils.getUserId());
			equipDowntimeAdmService.delete(equipDowntimeAdmVo);		
			equipDowntimeAdmService.create(equipDowntimeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유구분 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//비가동사유구분 등록_F3
	@RequestMapping(value = "/po/equipDowntimeAdmCreate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipDowntimeAdmCreate_F3(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유구분 등록 = " + equipDowntimeAdmVo);
		try {
			String date 		= DateUtil.getToday("yyyyMMdd").substring(2,8);
			String seq 			= equipDowntimeAdmService.downtimeIdx(date);
			String downtimeIdx	= date+'-'+seq;
			
			equipDowntimeAdmVo.setDowntimeIdx(downtimeIdx);
			equipDowntimeAdmVo.setRegId(Utils.getUserId());
			equipDowntimeAdmService.delete(equipDowntimeAdmVo);		
			equipDowntimeAdmService.create(equipDowntimeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유구분 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//비가동사유구분 수정
	@RequestMapping(value = "/po/equipDowntimeAdmaUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipDowntimeAdmaUpdate(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유구분 수정 = " + equipDowntimeAdmVo);
		
		try {
			equipDowntimeAdmVo.setUpdId(Utils.getUserId());
//			equipDowntimeAdmService.delete(equipDowntimeAdmVo);		
			equipDowntimeAdmService.update(equipDowntimeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유구분 등록 실패");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}	
	
	//비가동사유구분 삭제
	@RequestMapping(value = "/po/equipDowntimeAdmaDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipDowntimeAdmaDelete(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유구분 삭제: " + equipDowntimeAdmVo);
		try {
			equipDowntimeAdmService.delete(equipDowntimeAdmVo);		
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유구분 삭제 실패");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}	
	
	//비가동 사유 조회
	@RequestMapping(value = "/po/equipDowntimeAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipDowntimeAdmRead(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("비가동사유 불러오기 = " + equipDowntimeAdmVo);		
		
		try {
			equipDowntimeAdmVo = equipDowntimeAdmService.listChecked(equipDowntimeAdmVo);
			jsonData.put("data", equipDowntimeAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("비가동사유 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}

		return jsonData;
	}	

}