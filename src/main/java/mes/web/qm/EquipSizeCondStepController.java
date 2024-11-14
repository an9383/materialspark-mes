package mes.web.qm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.po.EquipSizeCondStepVo;
import mes.domain.po.WorkOrderVo;
import mes.service.em.EquipCondBomAdmService;
import mes.service.po.EquipSizeCondStepService;
import mes.service.po.WorkOrderService;
import mes.web.po.EquipStepController;
import mes.web.ut.DateUtil;

@Controller
public class EquipSizeCondStepController {
	
	@Inject
	private EquipSizeCondStepService equipSizeCondStepService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;

	private static final Logger logger = LoggerFactory.getLogger(EquipStepController.class);
	
	@Value("${factoryCode}") private String factoryCode;
	
	//품질관리 - 초중종물관리
	@RequestMapping(value = "/qmsc0040", method = RequestMethod.GET)
	public String qmsc0040GET(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 초중종물관리");
		model.addAttribute("serverDateFrom", DateUtil.getToday("yyyy-mm-dd") );
		
		return "qm/qmsc0040";
	}
	
	//품질관리 - 초중종물관리
	@RequestMapping(value = "/qmsc3040", method = RequestMethod.GET)
	public String qmsc3040GET(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 초중종물관리");
		model.addAttribute("serverDateFrom", DateUtil.getToday("yyyy-mm-dd") );
		
		return "qm/qmsc3040";
	}
	
	//상단 WorkOrder 테이블 조회
	@RequestMapping(value = "/qm/workOrderReadDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderReadDataListGET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
					
		//WorkOrderVo workOrderVo = new WorkOrderVo();
		//workOrderVo.setOrdDate(ordDate);
		List<WorkOrderVo> workOrderList = workOrderService.workOrderRead(workOrderVo);
		logger.info(workOrderList.toString());
		jsonData.put("data",workOrderList);
		return jsonData;
	 }
	
	//해당 설비&날짜 작업지시 조회
	@RequestMapping(value = "/qm/sizeCheckDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeCheckDataListGET(EquipSizeCondStepVo equipSizeCondStepVo, String equipCondSeq) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();		
		EquipSizeCondStepVo[] equipSizeCondStepVoArray = new EquipSizeCondStepVo[3];		
		EquipCondBomAdmVo equipCondBomAdmVo = new EquipCondBomAdmVo();
		List<EquipSizeCondStepVo> equipSizeCondStepList =  new ArrayList<EquipSizeCondStepVo>();
		logger.info("해당설비 & 날짜 작업지시 조회");
		
		try {
			
			equipSizeCondStepVo.setStepCd("001");
			equipSizeCondStepVoArray[0] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			equipSizeCondStepList.add(0, equipSizeCondStepVoArray[0]);
			equipSizeCondStepVo.setStepCd("002");
			equipSizeCondStepVoArray[1] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			equipSizeCondStepList.add(1, equipSizeCondStepVoArray[1]);
			equipSizeCondStepVo.setStepCd("003");
			equipSizeCondStepVoArray[2] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			equipSizeCondStepList.add(2, equipSizeCondStepVoArray[2]);
			
			equipCondBomAdmVo.setEquipCondSeq(equipCondSeq);
			equipCondBomAdmVo = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			
			jsonData.put("step", equipSizeCondStepList);
			jsonData.put("cond", equipCondBomAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("해당설비 & 날짜 작업지시 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	 }
	
	//해당 설비&날짜 작업지시 조회
	@RequestMapping(value = "/qm/sizeCheckDataListNew", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeCheckDataListNewGET(EquipSizeCondStepVo equipSizeCondStepVo, String equipCondSeq) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();		
		//EquipSizeCondStepVo[] equipSizeCondStepVoArray = new EquipSizeCondStepVo[3];
		List<EquipSizeCondStepVo> equipSizeCondStepVoArray = new ArrayList<EquipSizeCondStepVo>();
		EquipCondBomAdmVo equipCondBomAdmVo = new EquipCondBomAdmVo();
		List<EquipSizeCondStepVo> equipSizeCondStepList =  new ArrayList<EquipSizeCondStepVo>();
		logger.info("해당설비 & 날짜 작업지시 조회");
		
		try {
			equipSizeCondStepList = equipSizeCondStepService.stepAverage(equipSizeCondStepVo);
			//equipSizeCondStepVo.setStepCd("001");
			//equipSizeCondStepVoArray[0] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			//equipSizeCondStepList.add(0, equipSizeCondStepVoArray[0]);
			//equipSizeCondStepVo.setStepCd("002");
			//equipSizeCondStepVoArray[1] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			//equipSizeCondStepList.add(1, equipSizeCondStepVoArray[1]);
			//equipSizeCondStepVo.setStepCd("003");
			//equipSizeCondStepVoArray[2] = equipSizeCondStepService.readEquipSizeCondStep(equipSizeCondStepVo);
			//equipSizeCondStepList.add(2, equipSizeCondStepVoArray[2]);
			
			equipCondBomAdmVo.setEquipCondSeq(equipCondSeq);
			if( !factoryCode.equals("003") ) {
				equipCondBomAdmVo = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);	
			} else {
				if ( equipSizeCondStepVo.getLineGubun() != null && !"".equals(equipSizeCondStepVo.getLineGubun()) && "4Line".equals(equipSizeCondStepVo.getLineGubun()) ) {
					equipCondBomAdmVo = equipCondBomAdmService.sizeSixFloorRead(equipCondBomAdmVo);	
				} else {
					equipCondBomAdmVo = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);	
				}
			}
			
			jsonData.put("step", equipSizeCondStepList);
			jsonData.put("cond", equipCondBomAdmVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("해당설비 & 날짜 작업지시 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	 }

	
	//품질관리 - 자주검사관리
	@RequestMapping(value = "/qmsc0030", method = RequestMethod.GET)
	public String qmsc0030GET(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 자주검사관리");
		model.addAttribute("serverDateFrom", DateUtil.getToday("yyyy-mm-dd") );
		
		return "qm/qmsc0030";
	}
	
	//자주검사관리 목록 조회
	@RequestMapping(value = "/qm/workOrderRead2DataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderRead2DataListGET(String ordDate) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
					
		WorkOrderVo workOrderVo = new WorkOrderVo();
		workOrderVo.setOrdDate(ordDate);
		List<WorkOrderVo> workOrderList = workOrderService.workOrderRead2(workOrderVo);
		logger.info(workOrderList.toString());
		jsonData.put("data",workOrderList);
		return jsonData;
	 }
	
	
}