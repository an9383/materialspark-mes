package mes.web.po;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.po.EquipSizeCondStepVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.em.AgtSizeStep;
import mes.persistence.po.WorkOrderDAO;
import mes.service.bm.SystemCommonCodeService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.po.EquipSizeCondStepService;
import mes.service.qm.GoodsInspectService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class EquipStepController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private WorkOrderDAO workOrderService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;
	@Inject
	private EquipSizeCondStepService equipSizeCondStepService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmMapper;
	@Inject
	private GoodsInspectService goodsInspectService;
	
	private static final Logger logger = LoggerFactory.getLogger(EquipStepController.class);

	//품질괄리 -완제품검사 엣지검사
	@RequestMapping(value = "/posc0040", method = RequestMethod.GET)
	public String posc0040GET(Locale locale, Model model) throws Exception {
		
		logger.info("공정이동관리(초중종물 등록)");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017");	//주설비그룹야
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGruop", systemCommonCodeList );
		model.addAttribute("serverDateFrom", DateUtil.getToday("yyyy-mm-dd") );
		
		return "po/posc0040";
	}
	
	//해당 설비&날짜 작업지시 조회
	@RequestMapping(value = "/po/workOrderStepDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderStepDataListGET(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비정보관리 전제 조회");
		try {
			List<WorkOrderVo> workOrderStepDataList = workOrderService.workOrderDataList(workOrderVo);
			jsonData.put("data", workOrderStepDataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("\"설비정보관리 전제 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}

		return jsonData;
	 }
	
	//치수 조건&데이터 조회
	@RequestMapping(value = "/po/workOrderStepData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderStepDataGET(WorkOrderVo workOrderVo, EquipCondBomAdmVo equipCondBomAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("치수 SEQ로 치수 조회");
		
		try {
			//치수 조건 읽기
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("읽은 치수 정보"+sizeRead);
			jsonData.put("condStepData", sizeRead);
			
			////AGT초 Read
			//AgtSizeStep firstStep = new AgtSizeStep();
			//firstStep.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			//firstStep.setStepCd("001");
			//firstStep = equipCondBomAdmMapper.agtSizeRead(firstStep);
			//logger.info("AGT 첫번째 : "+firstStep);
			//jsonData.put("firstStepData", firstStep);
			//
			////AGT중 Read
			//AgtSizeStep secondStep = new AgtSizeStep();
			//secondStep.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			//secondStep.setStepCd("002");
			//secondStep = equipCondBomAdmMapper.agtSizeRead(secondStep);
			//logger.info("AGT 두번째 : "+secondStep);
			//jsonData.put("secondStepData", secondStep);
			//
			////종 Read
			//EquipSizeCondStepVo thirdStep = new EquipSizeCondStepVo();
			//thirdStep.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			//thirdStep.setStepCd("003");
			//thirdStep = equipSizeCondStepService.readEquipSizeCondStep(thirdStep);
			//logger.info("세번째 : "+thirdStep);
			//jsonData.put("thirdStepData", thirdStep);
			
			jsonData.put("result", "ok");
		}
		catch (NullPointerException e) {
			logger.info("조회된 치수값이 없습니다.");
			jsonData.put("result", "fail");
		}
		catch (Exception e) {
			logger.info("치수정보 읽기 최상단 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	 }
	
	//치수 조건&데이터 조회
	@RequestMapping(value = "/po/sizeSixFloorRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> sizeSixFloorRead(WorkOrderVo workOrderVo, EquipCondBomAdmVo equipCondBomAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("치수 SEQ로 치수 조회");
		try {
			//치수 조건 읽기
			EquipCondBomAdmVo sizeRead = equipCondBomAdmService.sizeSixFloorRead(equipCondBomAdmVo);
			logger.info("읽은 치수 정보"+sizeRead);
			jsonData.put("condStepData", sizeRead);
			jsonData.put("result", "ok");
		}
		catch (NullPointerException e) {
			logger.info("조회된 치수값이 없습니다.");
			jsonData.put("result", "fail");
		}
		catch (Exception e) {
			logger.info("치수정보 읽기 최상단 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	 }
	
	//외관검사 종물등록&수정 시 전체 초,중,종물 Read(조건포함)
	@RequestMapping(value = "/qm/readWorkOrdOutputSubStepData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readWorkOrdOutputSubStepData(WorkOrderVo workOrderVo, EquipCondBomAdmVo equipCondBomAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("치수 SEQ로 치수 조회");
		
		try {
			//치수 조건 읽기
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
			logger.info("읽은 치수 조건  - " + sizeRead);
			jsonData.put("condStepData", sizeRead);
			
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
			readWorkOrdOutputSubVo.setOrdLotNo(workOrderVo.getOrdLotNo());
			readWorkOrdOutputSubVo = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(readWorkOrdOutputSubVo);	
			jsonData.put("readWorkOrdOutputSubVo", readWorkOrdOutputSubVo);
			
			//AGT초 Read
			AgtSizeStep firstStep = new AgtSizeStep();
			firstStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
			firstStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
			firstStep.setStepCd("001");
			firstStep = equipCondBomAdmMapper.agtSizeRead(firstStep);
			logger.info("AGT 첫번째 : "+firstStep);
			jsonData.put("firstStepData", firstStep);
			
			//AGT중 Read
			AgtSizeStep secondStep = new AgtSizeStep();
			secondStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
			secondStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
			secondStep.setStepCd("002");
			secondStep = equipCondBomAdmMapper.agtSizeRead(secondStep);
			logger.info("AGT 두번째 : "+secondStep);
			jsonData.put("secondStepData", secondStep);
			
			//AGT초물 or 중물
			//AgtSizeStep step = new AgtSizeStep();
			//step.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
			//step.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
			//step = equipCondBomAdmMapper.agtSizeRead(step);
			//
			//if ("001".equals(step.getStepCd())) {
			//	jsonData.put("firstStepData", step);	
			//} else if ("002".equals(step.getStepCd())) {
			//	jsonData.put("secondStepData", step);
			//}
			
			//종 Read
			EquipSizeCondStepVo thirdStep = new EquipSizeCondStepVo();
			thirdStep.setWorkOrdNo(readWorkOrdOutputSubVo.getWorkOrdNo());
			//thirdStep.setOrdLotNo(readWorkOrdOutputSubVo.getOrdLotNo());
			thirdStep.setLotNo(readWorkOrdOutputSubVo.getLotNo());
			thirdStep.setStepCd("003");
			thirdStep = equipSizeCondStepService.readEquipSizeCondStep(thirdStep);
			logger.info("세번째 : "+thirdStep);
			jsonData.put("thirdStepData", thirdStep);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("치수정보 읽기 최상단 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	 }
	
	//초중종물  등록
	@RequestMapping(value = "/po/insertWorkOrderStepData", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> insertWorkOrderStepData(EquipSizeCondStepVo equipSizeCondStepVo, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		equipSizeCondStepVo.setRegId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		logger.info("받은 값 : " + equipSizeCondStepVo);
		
		try {
			equipSizeCondStepVo.setStepCd("003");
			equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getThirdRegTime());
			equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getThirdWpLeftAlwnce());
			equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getThirdWpRightAlwnce());
			equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getThirdPitchLeftAlwnce());
			equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getThirdPitchRightAlwnce());
			equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getThirdPpfWingLeftAlwnce());
			equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getThirdPpfWingRightAlwnce());
			equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getThirdPpfDepthLeftAlwnce	());
			equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getThirdPpfDepthRightAlwnce());
			equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getThirdFilmAlwnce());
			equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getThirdMetalDepthAlwnce());
			equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getThirdMetalThicknessAlwnce());
			equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getThirdThCenterAlwnce());
			equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getThirdThEdgeAlwncePlus());
			equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getThirdThStepInput());
			equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getThirdBurrMetalAlwnce());
			equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getThirdBurrRcutAlwnce());
			equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getThirdBurrRedgeAlwnce());
			equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getThirdBulgeLeftupHeight());
			equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getThirdBulgeLeftdownHeight());
			equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getThirdBulgeRightupHeight());
			equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getThirdBulgeRightdownHeight());
			equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getThirdBulgeLeftupWidth());
			equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getThirdBulgeLeftdownWidth());
			equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getThirdBulgeRightupWidth());
			equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getThirdBulgeRightdownWidth());
			equipSizeCondStepVo.setBurrRedgeAlwnce("0");	//미사용 항목,들어으면 품질관리/초중종물 검사현황에서 표시되지 않음!
	
			equipSizeCondStepService.insertEquipSizeCondStep(equipSizeCondStepVo);
			
			//종물등록할때 초,중을 수정할 경우
			if( equipSizeCondStepVo.getFirstStepSearch().equals("success") ) {
				equipSizeCondStepVo.setStepCd("001");
				//equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getFirstRegTime());
				//equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getFirstWpLeftAlwnce());
				//equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getFirstWpRightAlwnce());
				//equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getFirstPitchLeftAlwnce());
				//equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getFirstPitchRightAlwnce());
				//equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getFirstPpfWingLeftAlwnce());
				//equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getFirstPpfWingRightAlwnce());
				//equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getFirstPpfDepthLeftAlwnce	());
				//equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getFirstPpfDepthRightAlwnce());
				//equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getFirstFilmAlwnce());
				//equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getFirstMetalDepthAlwnce());
				//equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getFirstMetalThicknessAlwnce());
				//equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getFirstThCenterAlwnce());
				//equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getFirstThEdgeAlwncePlus());
				equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getFirstThStepInput());
				//equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getFirstBurrMetalAlwnce());
				//equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getFirstBurrRcutAlwnce());
				//equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getFirstBurrRedgeAlwnce());
				//equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getFirstBulgeLeftupHeight());
				//equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getFirstBulgeLeftdownHeight());
				//equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getFirstBulgeRightupHeight());
				//equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getFirstBulgeRightdownHeight());
				//equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getFirstBulgeLeftupWidth());
				//equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getFirstBulgeLeftdownWidth());
				//equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getFirstBulgeRightupWidth());
				//equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getFirstBulgeRightdownWidth());
				
				//업데이트
				equipSizeCondStepService.updateAgtSizeCondStep_F1(equipSizeCondStepVo);
				logger.info("firstStep 업데이트 완료");
			}
			if( equipSizeCondStepVo.getSecondStepSearch().equals("success") ) {
				equipSizeCondStepVo.setStepCd("002");
				//equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getSecondRegTime());
				//equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getSecondWpLeftAlwnce());
				//equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getSecondWpRightAlwnce());
				//equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getSecondPitchLeftAlwnce());
				//equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getSecondPitchRightAlwnce());
				//equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getSecondPpfWingLeftAlwnce());
				//equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getSecondPpfWingRightAlwnce());
				//equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getSecondPpfDepthLeftAlwnce	());
				//equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getSecondPpfDepthRightAlwnce());
				//equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getSecondFilmAlwnce());
				//equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getSecondMetalDepthAlwnce());
				//equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getSecondMetalThicknessAlwnce());
				//equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getSecondThCenterAlwnce());
				//equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getSecondThEdgeAlwncePlus());
				equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getSecondThStepInput());
				//equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getSecondBurrMetalAlwnce());
				//equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getSecondBurrRcutAlwnce());
				//equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getSecondBurrRedgeAlwnce());
				//equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getSecondBulgeLeftupHeight());
				//equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getSecondBulgeLeftdownHeight());
				//equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getSecondBulgeRightupHeight());
				//equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getSecondBulgeRightdownHeight());
				//equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getSecondBulgeLeftupWidth());
				//equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getSecondBulgeLeftdownWidth());
				//equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getSecondBulgeRightupWidth());
				//equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getSecondBulgeRightdownWidth());
				//업데이트
				equipSizeCondStepService.updateAgtSizeCondStep_F1(equipSizeCondStepVo);
				logger.info("secondStep 업데이트 완료");
			}
			
			logger.info("외관검사 종물 등록 완료");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("치수 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	 }
	
	//초중종물  업데이트
	@RequestMapping(value = "/po/updateWorkOrderStepData", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrderStepDataPOST(EquipSizeCondStepVo equipSizeCondStepVo, HttpServletRequest request) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("초중종물  업데이트");
		equipSizeCondStepVo.setUpdId(Utils.getUserId());
		logger.info("로그인 ID : " + Utils.getUserId());
		logger.info("받은 값 : " + equipSizeCondStepVo);
		
		try {
			if( equipSizeCondStepVo.getFirstStepSearch().equals("success") ) {
				equipSizeCondStepVo.setStepCd("001");
				//equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getFirstRegTime());
				//equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getFirstWpLeftAlwnce());
				//equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getFirstWpRightAlwnce());
				//equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getFirstPitchLeftAlwnce());
				//equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getFirstPitchRightAlwnce());
				//equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getFirstPpfWingLeftAlwnce());
				//equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getFirstPpfWingRightAlwnce());
				//equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getFirstPpfDepthLeftAlwnce	());
				//equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getFirstPpfDepthRightAlwnce());
				//equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getFirstFilmAlwnce());
				//equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getFirstMetalDepthAlwnce());
				//equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getFirstMetalThicknessAlwnce());
				//equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getFirstThCenterAlwnce());
				//equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getFirstThEdgeAlwncePlus());
				equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getFirstThStepInput());
				//equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getFirstBurrMetalAlwnce());
				//equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getFirstBurrRcutAlwnce());
				//equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getFirstBurrRedgeAlwnce());
				//equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getFirstBulgeLeftupHeight());
				//equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getFirstBulgeLeftdownHeight());
				//equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getFirstBulgeRightupHeight());
				//equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getFirstBulgeRightdownHeight());
				//equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getFirstBulgeLeftupWidth());
				//equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getFirstBulgeLeftdownWidth());
				//equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getFirstBulgeRightupWidth());
				//equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getFirstBulgeRightdownWidth());
				
				//업데이트
				equipSizeCondStepService.updateAgtSizeCondStep_F1(equipSizeCondStepVo);
				logger.info("firstStep 업데이트 완료");
			}
			if( equipSizeCondStepVo.getSecondStepSearch().equals("success") ) {
				equipSizeCondStepVo.setStepCd("002");
				//equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getSecondRegTime());
				//equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getSecondWpLeftAlwnce());
				//equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getSecondWpRightAlwnce());
				//equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getSecondPitchLeftAlwnce());
				//equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getSecondPitchRightAlwnce());
				//equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getSecondPpfWingLeftAlwnce());
				//equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getSecondPpfWingRightAlwnce());
				//equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getSecondPpfDepthLeftAlwnce	());
				//equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getSecondPpfDepthRightAlwnce());
				//equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getSecondFilmAlwnce());
				//equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getSecondMetalDepthAlwnce());
				//equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getSecondMetalThicknessAlwnce());
				//equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getSecondThCenterAlwnce());
				//equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getSecondThEdgeAlwncePlus());
				equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getSecondThStepInput());
				//equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getSecondBurrMetalAlwnce());
				//equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getSecondBurrRcutAlwnce());
				//equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getSecondBurrRedgeAlwnce());
				//equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getSecondBulgeLeftupHeight());
				//equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getSecondBulgeLeftdownHeight());
				//equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getSecondBulgeRightupHeight());
				//equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getSecondBulgeRightdownHeight());
				//equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getSecondBulgeLeftupWidth());
				//equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getSecondBulgeLeftdownWidth());
				//equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getSecondBulgeRightupWidth());
				//equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getSecondBulgeRightdownWidth());
				//업데이트
				equipSizeCondStepService.updateAgtSizeCondStep_F1(equipSizeCondStepVo);
				logger.info("secondStep 업데이트 완료");
			}
			equipSizeCondStepVo.setStepCd("003");
			//equipSizeCondStepVo.ㄴㄷㅅ
			equipSizeCondStepVo.setRegTime(equipSizeCondStepVo.getThirdRegTime());
			equipSizeCondStepVo.setWpLeftAlwnce(equipSizeCondStepVo.getThirdWpLeftAlwnce());
			equipSizeCondStepVo.setWpRightAlwnce(equipSizeCondStepVo.getThirdWpRightAlwnce());
			equipSizeCondStepVo.setPitchLeftAlwnce(equipSizeCondStepVo.getThirdPitchLeftAlwnce());
			equipSizeCondStepVo.setPitchRightAlwnce(equipSizeCondStepVo.getThirdPitchRightAlwnce());
			equipSizeCondStepVo.setPpfWingLeftAlwnce(equipSizeCondStepVo.getThirdPpfWingLeftAlwnce());
			equipSizeCondStepVo.setPpfWingRightAlwnce(equipSizeCondStepVo.getThirdPpfWingRightAlwnce());
			equipSizeCondStepVo.setPpfDepthLeftAlwnce(equipSizeCondStepVo.getThirdPpfDepthLeftAlwnce	());
			equipSizeCondStepVo.setPpfDepthRightAlwnce(equipSizeCondStepVo.getThirdPpfDepthRightAlwnce());
			equipSizeCondStepVo.setFilmAlwnce(equipSizeCondStepVo.getThirdFilmAlwnce());
			equipSizeCondStepVo.setMetalDepthAlwnce(equipSizeCondStepVo.getThirdMetalDepthAlwnce());
			equipSizeCondStepVo.setMetalThicknessAlwnce(equipSizeCondStepVo.getThirdMetalThicknessAlwnce());
			equipSizeCondStepVo.setThCenterAlwnce(equipSizeCondStepVo.getThirdThCenterAlwnce());
			equipSizeCondStepVo.setThEdgeAlwncePlus(equipSizeCondStepVo.getThirdThEdgeAlwncePlus());
			equipSizeCondStepVo.setThStepInput(equipSizeCondStepVo.getThirdThStepInput());
			equipSizeCondStepVo.setBurrMetalAlwnce(equipSizeCondStepVo.getThirdBurrMetalAlwnce());
			equipSizeCondStepVo.setBurrRcutAlwnce(equipSizeCondStepVo.getThirdBurrRcutAlwnce());
			equipSizeCondStepVo.setBurrRedgeAlwnce(equipSizeCondStepVo.getThirdBurrRedgeAlwnce());
			equipSizeCondStepVo.setBulgeLeftupHeight(equipSizeCondStepVo.getThirdBulgeLeftupHeight());
			equipSizeCondStepVo.setBulgeLeftdownHeight(equipSizeCondStepVo.getThirdBulgeLeftdownHeight());
			equipSizeCondStepVo.setBulgeRightupHeight(equipSizeCondStepVo.getThirdBulgeRightupHeight());
			equipSizeCondStepVo.setBulgeRightdownHeight(equipSizeCondStepVo.getThirdBulgeRightdownHeight());
			equipSizeCondStepVo.setBulgeLeftupWidth(equipSizeCondStepVo.getThirdBulgeLeftupWidth());
			equipSizeCondStepVo.setBulgeLeftdownWidth(equipSizeCondStepVo.getThirdBulgeLeftdownWidth());
			equipSizeCondStepVo.setBulgeRightupWidth(equipSizeCondStepVo.getThirdBulgeRightupWidth());
			equipSizeCondStepVo.setBulgeRightdownWidth(equipSizeCondStepVo.getThirdBulgeRightdownWidth());
			equipSizeCondStepVo.setBurrRedgeAlwnce("0");	//미사용 항목,들어으면 품질관리/초중종물 검사현황에서 표시되지 않음!
			
			//업데이트
			equipSizeCondStepService.updateEquipSizeCondStep(equipSizeCondStepVo);
			logger.info("thirdStep 업데이트 완료");

			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("치수 수정 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	 }
	
}