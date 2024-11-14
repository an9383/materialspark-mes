package mes.web.po;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.po.AgtVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuAuthVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.po.AgtService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.qm.GoodsInspectService;
import mes.service.sm.MatrlUserService;
import mes.service.sm.MenuAuthService;
import mes.web.ut.Utils;

@Controller
public class WorkOrdOutputSubController {

	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private AgtService agtService;
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private MatrlUserService matrlUserService;
	@Inject
	private MenuAuthService menuAuthService;
	
	private static final Logger logger = LoggerFactory.getLogger(WorkOrdOutputSubController.class);

	//생산수량 목록조회
	@RequestMapping(value = "/po/outputCntDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> outputCntDataList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산수량 목록조회");
		try {
			List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.workOrdOutputSubList(workOrdOutputSubVo);
			jsonData.put("data", WorkOrdOutputSubList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("생산수량 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//생산수량 상세조회
	//@RequestMapping(value = "/po/outputCntDataRead", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> outputCntDataRead(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("생산수량 목록 상세조회");
	//	try {
	//		WorkOrdOutputSubVo list = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
	//		jsonData.put("data", list);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("생산수량 목록 상세조회 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "error");
	//	}
    //
	//	return jsonData;
	//}

	//생산수량 생성
	@RequestMapping(value = "/po/outputCntDataCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outputCntDataCreate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산수량 생성 - " + workOrdOutputSubVo);
		try {
			//같은 작지&주재료의 생산실적 입력 시 주야간이 변경될 경우 생산LotNo 새로 채번 여부
			//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			//systemCommonCodeVo.setBaseGroupCd("081");
			//systemCommonCodeVo.setEtc1("Y");
			//systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
			//// 001 = 주야간 변경시 생산LotNo 채번 O
			//// 002 = 주야간 변경시 생산LotNo 채번 X
			//if (systemCommonCodeVo == null) {
			//	jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
			//	jsonData.put("result", "fail");
			//	return jsonData;
			//	
			//} else if ("001".equals(systemCommonCodeVo.getBaseCd())) {
			//	workOrdOutputSubVo.setCheckWorkOrdLotNoOption("001");
			//} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
			//	workOrdOutputSubVo.setCheckWorkOrdLotNoOption("002");
			//}
			//String checkWorkOrdLotNoOption = systemCommonCodeVo.getBaseCd();
			//MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			//matrlInOutWhsAdmVo.setLotNo(workOrdOutputSubVo.getLotNo());
			//matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
			workOrdOutputSubVo.setMainWorkChargr(Utils.getUserNumber());
			workOrdOutputSubVo.setRegId(Utils.getUserId());
			
			String workOrdNo = workOrdOutputSubVo.getWorkOrdNo();
			String lotNo = workOrdOutputSubVo.getLotNo();
			String gubun = workOrdOutputSubVo.getGubun();
			String equipCd = workOrdOutputSubVo.getEquipCd();
			String ordDate = workOrdOutputSubVo.getOrdDate();
			String mainMatrlCd = workOrdOutputSubVo.getMainMatrlCd();
			String workOrdDate = workOrdOutputSubVo.getWorkOrdDate();	//요거 추가로 받아와야함
			logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCd);
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(workOrdDate);
			
			//생산LotNo 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 작업지시일, 주재료코드)
			String workOrdLotNo = getCreateWorkOrdLotNo(workOrdNo, lotNo, gubun, equipCd, ordDate, mainMatrlCd);
			if (workOrdLotNo.equals("errorType1")) {
				jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
				jsonData.put("result", "error");
				return jsonData;
			} else if (workOrdLotNo.equals("errorType2")) {
				jsonData.put("message", "생산LotNo 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			
			logger.info("진짜 생산LotNo - " + workOrdLotNo);
			
			//LotNo(workOrdLotNo)생성													//옵션에따라 주야간 구분처리 추가하였음
			//List<WorkOrdOutputSubVo> workOrdLotNoCheckList = workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
			//
			//if (workOrdLotNoCheckList.size() == 0) {
			//	String workOrdLotNoBody =  workOrdOutputSubService.createWorkOrdLotNoBody(workOrdOutputSubVo);	//ex) LD1ANC-21122D
			//	int workOrdLotNoCount =  workOrdOutputSubService.createWorkOrdLotNoCount(workOrdOutputSubVo);	//ex) 1
			//	workOrdLotNo = workOrdLotNoBody + Integer.toString(workOrdLotNoCount);							//ex) LD1ANC-21122D1
			//} else {
			//	workOrdLotNo = workOrdLotNoCheckList.get(0).getWorkOrdLotNo();
			//}
			//logger.info("진짜 생산LotNo - " + workOrdLotNo);
			//createOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
			//------------------------------------------------------------------------------------------------------------
			
			//생산전표번호 채번 필요인자(작지번호, 주재료LotNo, 전표번호 주야구분, 설비코드, 주재료코드, 전표번호일자)
			String ordLotNo = getCreateOrdLotNo(workOrdNo, lotNo, gubun, equipCd, mainMatrlCd, workOrdDate);
			if (ordLotNo.equals("errorType1")) {
				jsonData.put("message", "생산전표번호 채번오류가 발생하였습니다.<br>관리자에게 문의해 주세요!");
				jsonData.put("result", "error");
				return jsonData;
			}
			
			//String ordLotNoBody = workOrdOutputSubService.createOrdLotNoBody(workOrdOutputSubVo);
			//List<WorkOrdOutputSubVo> WorkOrdOutputSublist = workOrdOutputSubService.checkOrdLotNo(workOrdOutputSubVo);
			////생산전표번호 등록되었는지 확인
			//int ordLotNoCount;
			//if (WorkOrdOutputSublist.size() == 0) {
			//	ordLotNoCount = workOrdOutputSubService.createOrdLotNoCount(workOrdOutputSubVo);
			//} else {
			//	String ordLotNoSplit[] = WorkOrdOutputSublist.get(0).getOrdLotNo().split("-");
			//	String ordLotNoTemp1 = ordLotNoSplit[1];
			//	ordLotNoTemp1 = ordLotNoTemp1.substring(7, ordLotNoTemp1.length());
			//	logger.info("ordLotNoTemp1 - " + ordLotNoTemp1);
			//	ordLotNoCount = Integer.parseInt(ordLotNoTemp1);
			//}
			//
			//WorkOrdOutputSubVo ordLotNoVoTemp = new WorkOrdOutputSubVo();
			//ordLotNoVoTemp.setOrdLotNo(ordLotNoBody + Integer.toString(ordLotNoCount));
			//int ordLotNoLastCount = workOrdOutputSubService.createOrdLotNoLastCount(ordLotNoVoTemp);
			//ordLotNo = ordLotNoBody + Integer.toString(ordLotNoCount) + "-" + Integer.toString(ordLotNoLastCount);			
			//logger.info("ordLotNoBody - " + ordLotNoBody);
			//logger.info("ordLotNoCount - " + ordLotNoCount);
			//logger.info("ordLotNoLastCount - " + ordLotNoLastCount);
			//logger.info("ordLotNo - " + ordLotNo);
			
			workOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
			workOrdOutputSubVo.setOrdLotNo(ordLotNo);
			int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
			workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
			workOrdOutputSubVo.setSubWorkStatusCd("C");
			workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
			workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			//생산 전표번호 등록 후 해당전표번호로 초물 or 중물 판단 후 등록
			int countLotNoOutput = workOrdOutputSubService.countLotNoOutput(workOrdOutputSubVo);	//해당 생산LotNo로 처음 등록된 생산전표번호 검색
			
			String stepCd;
			String message;
			
			if (countLotNoOutput == 1) {
				stepCd = "001";
				message = "생산실적 등록되었습니다.<br>해당설비의 초물을 불러오는 중입니다!";
			} else if (countLotNoOutput == 2) {
				stepCd = "002";
				message = "생산실적 등록되었습니다.<br>해당설비의 중물을 불러오는 중입니다!";
			} else {
				stepCd = "000";
				message = "생산실적 등록되었습니다.";
			}
			
			jsonData.put("data", readWorkOrdOutputSubVo);
			jsonData.put("stepCd", stepCd);
			jsonData.put("message", message);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			logger.info("생산수량 생성 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//생산수량 생성
	//@RequestMapping(value = "/po/outputCntDataCreate_F3", method = RequestMethod.POST)
	//public @ResponseBody Map<String, Object> outputCntDataCreate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("생산수량 생성 - " + workOrdOutputSubVo);
	//	try {
	//		//같은 작지&주재료의 생산실적 입력 시 주야간이 변경될 경우 생산LotNo 새로 채번 여부
	//		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
	//		systemCommonCodeVo.setBaseGroupCd("081");
	//		systemCommonCodeVo.setEtc1("Y");
	//		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
	//		// 001 = 주야간 변경시 생산LotNo 채번 O
	//		// 002 = 주야간 변경시 생산LotNo 채번 X
	//		if (systemCommonCodeVo == null) {
	//			jsonData.put("message", "생산LotNo 채번기준 옵션이 선택되어 있지 않습니다!<br>기준정보관리/시스템공통코드관리 - 기초코드 081번을 확인해주세요!<br>사용하실 옵션의 체크1에 Y를 표기하여주시기 바랍니다!");
	//			jsonData.put("result", "fail");
	//			return jsonData;
	//			
	//		} else if ("001".equals(systemCommonCodeVo.getBaseCd())) {
	//			workOrdOutputSubVo.setCheckWorkOrdLotNoOption("001");
	//		} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
	//			workOrdOutputSubVo.setCheckWorkOrdLotNoOption("002");
	//		}
	//		
	//		
	//		String workOrdLotNo = "";
	//		WorkOrdOutputSubVo createOrdOutputSubVo = new WorkOrdOutputSubVo();
	//		workOrdOutputSubVo.setMainWorkChargr(Utils.getUserNumber());
	//		workOrdOutputSubVo.setRegId(Utils.getUserId());
	//		
	//		//LotNo(workOrdLotNo)생성													//옵션에따라 주야간 구분처리 추가하였음
	//		List<WorkOrdOutputSubVo> workOrdLotNoCheckList = workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
	//		
	//		if (workOrdLotNoCheckList.size() == 0) {
	//			String workOrdLotNoBody =  workOrdOutputSubService.createWorkOrdLotNoBody(workOrdOutputSubVo);	//ex) LD1ANC-21122D
	//			int workOrdLotNoCount =  workOrdOutputSubService.createWorkOrdLotNoCount(workOrdOutputSubVo);	//ex) 1
	//			workOrdLotNo = workOrdLotNoBody + Integer.toString(workOrdLotNoCount);							//ex) LD1ANC-21122D1
	//		} else {
	//			workOrdLotNo = workOrdLotNoCheckList.get(0).getWorkOrdLotNo();
	//		}
	//		logger.info("진짜 생산LotNo - " + workOrdLotNo);
	//		createOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
	//		
	//		String ordLotNoBody = workOrdOutputSubService.createOrdLotNoBody(workOrdOutputSubVo);
	//		List<WorkOrdOutputSubVo> WorkOrdOutputSublist = workOrdOutputSubService.checkOrdLotNo(workOrdOutputSubVo);
	//		//생산전표번호 등록되었는지 확인
	//		int ordLotNoCount;
	//		if (WorkOrdOutputSublist.size() == 0) {
	//			ordLotNoCount = workOrdOutputSubService.createOrdLotNoCount(workOrdOutputSubVo);
	//		} else {
	//			String ordLotNoSplit[] = WorkOrdOutputSublist.get(0).getOrdLotNo().split("-");
	//			String ordLotNoTemp1 = ordLotNoSplit[1];
	//			ordLotNoTemp1 = ordLotNoTemp1.substring(7, ordLotNoTemp1.length());
	//			logger.info("ordLotNoTemp1 - " + ordLotNoTemp1);
	//			ordLotNoCount = Integer.parseInt(ordLotNoTemp1);
	//		}
	//		
	//		WorkOrdOutputSubVo ordLotNoVoTemp = new WorkOrdOutputSubVo();
	//		ordLotNoVoTemp.setOrdLotNo(ordLotNoBody + Integer.toString(ordLotNoCount));
	//		int ordLotNoLastCount = workOrdOutputSubService.createOrdLotNoLastCount(ordLotNoVoTemp);
	//		String ordLotNo = ordLotNoBody + Integer.toString(ordLotNoCount) + "-" + Integer.toString(ordLotNoLastCount);			
	//		logger.info("ordLotNoBody - " + ordLotNoBody);
	//		logger.info("ordLotNoCount - " + ordLotNoCount);
	//		logger.info("ordLotNoLastCount - " + ordLotNoLastCount);
	//		logger.info("ordLotNo - " + ordLotNo);
	//		
	//		workOrdOutputSubVo.setWorkOrdLotNo(workOrdLotNo);
	//		workOrdOutputSubVo.setOrdLotNo(ordLotNo);
	//		int workOrdSeq = Integer.parseInt(workOrdOutputSubService.workOrdOutputSubSeq(workOrdOutputSubVo));
	//		workOrdOutputSubVo.setWorkOrdSeq(Integer.toString(workOrdSeq));
	//		workOrdOutputSubVo.setSubWorkStatusCd("EF3");
	//		workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
	//		workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
	//		WorkOrdOutputSubVo readWorkOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
	//		
	//		//생산 전표번호 등록 후 해당전표번호로 초물 or 중물 판단 후 등록
	//		int countLotNoOutput = workOrdOutputSubService.countLotNoOutput(workOrdOutputSubVo);	//해당 생산LotNo로 처음 등록된 생산전표번호 검색
	//		
	//		String stepCd;
	//		String message;
	//		
	//		//if (countLotNoOutput == 1) {
	//		//	stepCd = "001";
	//		//	message = "생산실적 등록되었습니다.<br>해당설비의 초물을 불러오는 중입니다!";
	//		//} else if (countLotNoOutput == 2) {
	//		//	stepCd = "002";
	//		//	message = "생산실적 등록되었습니다.<br>해당설비의 중물을 불러오는 중입니다!";
	//		//} else {
	//		//	stepCd = "000";
	//		//	message = "생산실적 등록되었습니다.";
	//		//}
	//		
	//		stepCd = "000";
	//		message = "생산실적 등록되었습니다.";
	//		
	//		jsonData.put("data", readWorkOrdOutputSubVo);
	//		jsonData.put("stepCd", stepCd);
	//		jsonData.put("message", message);
	//		jsonData.put("result", "ok");
    //
	//	} catch (Exception e) {
	//		logger.info("생산수량 생성 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "시스템오류가 발생했습니다.");
	//		jsonData.put("result", "error");
	//	}
    //
	//	return jsonData;
	//}


	//생산수량 수정
	@RequestMapping(value = "/po/outputCntDataUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outputCntDataUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산수량 수정");
		try {
			WorkOrdOutputSubVo checkSubOutputStatus = goodsInspectService.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
			if ("C".equals(checkSubOutputStatus.getSubWorkStatusCd())) {
				String regTime = "";
				workOrdOutputSubVo.setUpdId(Utils.getUserId());
				workOrdOutputSubService.workOrdOutputSubUpdate(workOrdOutputSubVo);
				//List<WorkOrdOutputSubVo> list = workOrdOutputSubService.list(workOrdOutputSubVo);
				//int sum = 0;
				//for (WorkOrdOutputSubVo m : list) {
				//	sum += Integer.parseInt(m.getOutputCnt());
				//	sum += m.getVisionEdgeCnt();
				//}
				//workOrdOutputSubVo.setOutputCnt(Integer.toString(sum));
				//workOrdOutputSubVo.setUpdId(Utils.getUserId());
				workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
				WorkOrdOutputSubVo readWorkOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
				regTime = readWorkOrdOutputSubVo.getRegDate();
				jsonData.put("data", regTime);
				jsonData.put("message", "생산실적 수정되었습니다.");
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "생산 전표번호 상태가 변경되었습니다!<br>완료상태의 생산 전표번호만 수정 하실 수 있습니다!");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			logger.info("생산수량 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}

	//생산실적 등록자 수정
	@RequestMapping(value = "/po/registrantChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> registrant(WorkOrderVo workOrderVo, WorkOrdOutputSubVo workOrdOutputSubVo, MatrlUserVo matrlUserVo, MenuAuthVo menuAuthVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();		
		logger.info("생산실적 등록자 수정");
		try {
			menuAuthVo.setUseUserId(matrlUserVo.getUserId());
			menuAuthVo.setLoginUserId(Utils.getUserId());
			menuAuthVo.setLotNo(workOrderVo.getOrdLotNo());
			WorkOrdOutputSubVo checkWorkOrdOutputSubVo = workOrdOutputSubService.checkChangeOrdLotNo_F1F2(workOrdOutputSubVo);
			
			MatrlUserVo userVo = matrlUserService.userAuthDeleteCheck_F1F2F3(matrlUserVo);
			if( userVo == null ) {
				jsonData.put("result", "fail");
				jsonData.put("message", "권한이 없는 계정입니다.");				
			} else if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {
				jsonData.put("result", "fail");
				jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
			} else {
				if( checkWorkOrdOutputSubVo == null) {
					jsonData.put("message", "해당 전표번호의 상태 값이 변경되었습니다!<br>다시 시도해주세요!");
					jsonData.put("result", "fail");
				} else {
					//등록자변경 권한사용 로그처리
					menuAuthVo.setUseAuthCode("003");
					menuAuthService.userAuthUseHist_F1F2F3(menuAuthVo);
					workOrdOutputSubVo.setUpdId(Utils.getUserId());
					workOrdOutputSubService.registrantChange(workOrdOutputSubVo);
					jsonData.put("message", "생산실적 등록자 수정 수정되었습니다.");
					jsonData.put("result", "ok");
				}
			}

		} catch (Exception e) {
			logger.info("생산실적 등록자 수정오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
	
		return jsonData;
	}
		
	//생산수량 삭제
	@RequestMapping(value = "/po/outputCntDataDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outputCntDataDelete(WorkOrdOutputSubVo workOrdOutputSubVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산수량 삭제 - " + workOrdOutputSubVo);
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
			readWorkOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			if ("C".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				
				//선택 생산실적전표가 해당 작지의 가장 최근등록한 생산실적전표인지 확인
				int checkCount = workOrdOutputSubService.checkWorkOrdOutputSubCount(readWorkOrdOutputSubVo);
				if (checkCount == Integer.parseInt(workOrdOutputSubVo.getWorkOrdSeq())) {
					readWorkOrdOutputSubVo.setIpAddress(Utils.getClientIP(request));
					readWorkOrdOutputSubVo.setDltId(Utils.getUserId());
					workOrdOutputSubService.workOrdOutputSubCreateTemp(readWorkOrdOutputSubVo);
					workOrdOutputSubService.workOrdOutputSubDelete(readWorkOrdOutputSubVo);
					
					//List<WorkOrdOutputSubVo> list = workOrdOutputSubService.list(workOrdOutputSubVo);
					//int sum = 0;
					//for (WorkOrdOutputSubVo m : list) {
					//	sum += Integer.parseInt(m.getOutputCnt());
					//	sum += m.getVisionEdgeCnt();
					//}
					//workOrdOutputSubVo.setOutputCnt(Integer.toString(sum));
					//workOrdOutputSubVo.setUpdId(Utils.getUserId());
					workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
					
					AgtVo agtVo = new AgtVo();					
					agtVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
					agtVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
					agtVo.setLotNo(workOrdOutputSubVo.getLotNo());
					agtVo.setStepCd(workOrdOutputSubVo.getStepCd());
					agtService.deletePress(agtVo);
					agtService.deleteSize(agtVo);
					agtService.deleteTemp(agtVo);
					agtService.deleteTime(agtVo);
					
					jsonData.put("message", "생산전표번호 삭제 되었습니다.");
					jsonData.put("result", "ok");			
				} else {
					jsonData.put("message", "가장 최근 등록한 생산 전표번호순으로 삭제 하실 수 있습니다!");
					jsonData.put("result", "fail");	
				}
			} else {
				jsonData.put("message", "생산 완료된 생산실적만 삭제 할 수 있습니다!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("생산수량 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//생산수량 삭제
	@RequestMapping(value = "/po/outputCntDataDelete_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> outputCntDataDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산수량 삭제 - " + workOrdOutputSubVo);
		try {
			WorkOrdOutputSubVo readWorkOrdOutputSubVo = new WorkOrdOutputSubVo();
			readWorkOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			if ("C".equals(readWorkOrdOutputSubVo.getSubWorkStatusCd())) {
				
				//선택 생산실적전표가 해당 작지의 가장 최근등록한 생산실적전표인지 확인
				int checkCount = workOrdOutputSubService.checkWorkOrdOutputSubCount(readWorkOrdOutputSubVo);
				if (checkCount == Integer.parseInt(workOrdOutputSubVo.getWorkOrdSeq())) {
					readWorkOrdOutputSubVo.setIpAddress(Utils.getClientIP(request));
					readWorkOrdOutputSubVo.setDltId(Utils.getUserId());
					workOrdOutputSubService.workOrdOutputSubCreateTemp(readWorkOrdOutputSubVo);
					workOrdOutputSubService.workOrdOutputSubDelete(readWorkOrdOutputSubVo);
					
					//List<WorkOrdOutputSubVo> list = workOrdOutputSubService.list(workOrdOutputSubVo);
					//int sum = 0;
					//for (WorkOrdOutputSubVo m : list) {
					//	sum += Integer.parseInt(m.getOutputCnt());
					//	sum += m.getVisionEdgeCnt();
					//}
					//workOrdOutputSubVo.setOutputCnt(Integer.toString(sum));
					//workOrdOutputSubVo.setUpdId(Utils.getUserId());
					workOrdOutputSubService.updateMainWorkOrdOutput(workOrdOutputSubVo);
					
					//AgtVo agtVo = new AgtVo();					
					//agtVo.setWorkOrdNo(workOrdOutputSubVo.getWorkOrdNo());
					//agtVo.setOrdLotNo(workOrdOutputSubVo.getOrdLotNo());
					//agtVo.setLotNo(workOrdOutputSubVo.getLotNo());
					//agtVo.setStepCd(workOrdOutputSubVo.getStepCd());
					//agtService.deletePress(agtVo);
					//agtService.deleteSize(agtVo);
					//agtService.deleteTemp(agtVo);
					//agtService.deleteTime(agtVo);
					
					jsonData.put("message", "생산전표번호 삭제 되었습니다.");
					jsonData.put("result", "ok");			
				} else {
					jsonData.put("message", "가장 최근 등록한 생산 전표번호순으로 삭제 하실 수 있습니다!");
					jsonData.put("result", "fail");	
				}
			} else {
				jsonData.put("message", "생산 완료된 생산실적만 삭제 할 수 있습니다!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("생산수량 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//작업지시 인쇄시 대상 ordLotNO 목록 조회
	@RequestMapping(value = "/po/workOrdExcelDownOrdLotNoList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdExcelDownOrdLotNoList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 인쇄시 대상 ordLotNO 목록 조회");
		try {
			List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.workOrdOutputSubList(workOrdOutputSubVo);
			jsonData.put("data", WorkOrdOutputSubList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업지시 인쇄시 대상 ordLotNO 목록 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}

	//솔브레인SLD 작지인쇄 목록
	@RequestMapping(value = "/po/workOrdExcelDownOrdLotNoList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrdExcelDownOrdLotNoList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 인쇄시 대상 ordLotNO 목록 조회");
		try {
			List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.workOrdExcelDownOrdLotNoList_F3(workOrdOutputSubVo);
			jsonData.put("data", WorkOrdOutputSubList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업지시 인쇄시 대상 ordLotNO 목록 조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	/* GoodsInspectController 에서도 똑같이 복붙하여 사용중임. 서비스들 Static으로 사용 할 수 있는 방법 찾아야함 */
	//생산LotNo 채번
	public String getCreateWorkOrdLotNo (String workOrdNo, String lotNo, String gubun, String equipCd, String ordDate, String mainMatrlCd) throws Exception {
		String workOrdLotNo = "";
		
    	try {
    		String checkWorkOrdLotNoOption = "";
			//같은 작지&주재료의 생산실적 입력 시 주야간이 변경될 경우 생산LotNo 새로 채번 여부
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("081");
			systemCommonCodeVo.setEtc1("Y");
			systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
			// 001 = 주야간 변경시 생산LotNo 채번 O
			// 002 = 주야간 변경시 생산LotNo 채번 X
			if (systemCommonCodeVo == null) {
				return workOrdLotNo = "errorType1";
			} else if ("001".equals(systemCommonCodeVo.getBaseCd())) {
				checkWorkOrdLotNoOption = "001";
			} else if ("002".equals(systemCommonCodeVo.getBaseCd())) {
				checkWorkOrdLotNoOption = "002";
			}
			EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
			equipCodeAdmVo.setEquipCd(equipCd);
			equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
			int bodyLength = equipCodeAdmVo.getEquipNm().replace("-", "").length();
			bodyLength += 10;	//생산lotNo 에서는 D,N을 잘라야하기에 10을더함
			
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setLotNo(lotNo);
			workOrdOutputSubVo.setGubun(gubun);
			workOrdOutputSubVo.setEquipCd(equipCodeAdmVo.getEquipCd());
			workOrdOutputSubVo.setEquipNm(equipCodeAdmVo.getEquipNm());
			workOrdOutputSubVo.setOrdDate(ordDate);
			workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
			workOrdOutputSubVo.setCheckWorkOrdLotNoOption(checkWorkOrdLotNoOption);
			workOrdOutputSubVo.setBodyLength(bodyLength);
			
			logger.info(workOrdNo);
			logger.info(lotNo);
			logger.info(gubun);
			logger.info(equipCodeAdmVo.getEquipCd());
			logger.info(equipCodeAdmVo.getEquipNm());
			logger.info(ordDate);
			logger.info(mainMatrlCd);
			logger.info(checkWorkOrdLotNoOption);
			logger.info(Integer.toString(bodyLength));
			
			//생산LotNo(workOrdLotNo)생성													//옵션에따라 주야간 구분처리 추가하였음
			List<WorkOrdOutputSubVo> workOrdLotNoCheckList = workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
			if (workOrdLotNoCheckList.size() == 0) {
				String workOrdLotNoBody =  workOrdOutputSubService.createWorkOrdLotNoBody(workOrdOutputSubVo);	//ex) LD1ANC-21122D
				int workOrdLotNoCount =  workOrdOutputSubService.createWorkOrdLotNoCount(workOrdOutputSubVo);	//ex) 1
				workOrdLotNo = workOrdLotNoBody + Integer.toString(workOrdLotNoCount);							//ex) LD1ANC-21122D1
			} else {
				workOrdLotNo = workOrdLotNoCheckList.get(0).getWorkOrdLotNo();
			}
			
			logger.info("진짜 생산LotNo - " + workOrdLotNo);
    		
		} catch (Exception e) {
			workOrdLotNo = "errorType2";
			logger.info("생산LotNo(workOrdLotNo) 채번 에러!");
			e.printStackTrace();
		}
    	
    	return workOrdLotNo;
	}
	
	
	//생산전표번호 채번
	public String getCreateOrdLotNo (String workOrdNo, String lotNo, String gubun, String equipCd, String mainMatrlCd, String workOrdDate) throws Exception {
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		equipCodeAdmVo.setEquipCd(equipCd);
		equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
		int bodyLength = equipCodeAdmVo.getEquipNm().replace("-", "").length();
		bodyLength += 12;
		
		String ordLotNo = "";
		WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
		workOrdOutputSubVo.setLotNo(lotNo);
		workOrdOutputSubVo.setGubun(gubun);
		workOrdOutputSubVo.setEquipCd(equipCodeAdmVo.getEquipCd());
		workOrdOutputSubVo.setEquipNm(equipCodeAdmVo.getEquipNm());
		workOrdOutputSubVo.setMainMatrlCd(mainMatrlCd);
		workOrdOutputSubVo.setWorkOrdDate(workOrdDate);
		workOrdOutputSubVo.setBodyLength(bodyLength);
		
		logger.info(workOrdNo);
		logger.info(lotNo);
		logger.info(gubun);
		logger.info(equipCodeAdmVo.getEquipCd());
		logger.info(equipCodeAdmVo.getEquipNm());
		logger.info(mainMatrlCd);
		logger.info(workOrdDate);
		logger.info(Integer.toString(bodyLength));
		
    	try {
			String ordLotNoBody = workOrdOutputSubService.createOrdLotNoBody(workOrdOutputSubVo);
			logger.info("ordLotNoBody - " + ordLotNoBody);
			List<WorkOrdOutputSubVo> WorkOrdOutputSublist = workOrdOutputSubService.checkOrdLotNo(workOrdOutputSubVo);
			//생산전표번호 등록되었는지 확인
			int ordLotNoCount;
			if (WorkOrdOutputSublist.size() == 0) {
				ordLotNoCount = workOrdOutputSubService.createOrdLotNoCount(workOrdOutputSubVo);
				logger.info("ordLotNoCount - " + ordLotNoCount);
			} else {
				String ordLotNoSplit[] = WorkOrdOutputSublist.get(0).getOrdLotNo().split("-");
				String ordLotNoTemp1 = ordLotNoSplit[1];
				ordLotNoTemp1 = ordLotNoTemp1.substring(7, ordLotNoTemp1.length());
				logger.info("ordLotNoTemp1 - " + ordLotNoTemp1);
				ordLotNoCount = Integer.parseInt(ordLotNoTemp1);
				logger.info("ordLotNoCount - " + ordLotNoCount);
			}
			
			WorkOrdOutputSubVo ordLotNoVoTemp = new WorkOrdOutputSubVo();
			ordLotNoVoTemp.setOrdLotNo(ordLotNoBody + Integer.toString(ordLotNoCount));
			int ordLotNoLastCount = workOrdOutputSubService.createOrdLotNoLastCount(ordLotNoVoTemp);
			ordLotNo = ordLotNoBody + Integer.toString(ordLotNoCount) + "-" + Integer.toString(ordLotNoLastCount);			
			logger.info("ordLotNoBody - " + ordLotNoBody);
			logger.info("ordLotNoCount - " + ordLotNoCount);
			logger.info("ordLotNoLastCount - " + ordLotNoLastCount);
			logger.info("ordLotNo - " + ordLotNo);
    		
		} catch (Exception e) {
			ordLotNo = "errorType1";
			logger.info("생산생산전표번호(ordLotNo) 채번 에러!");
			e.printStackTrace();
		}
    	
    	return ordLotNo;
	}
	/* GoodsInspectController 에서도 똑같이 복붙하여 사용중임. 서비스들 Static으로 사용 할 수 있는 방법 찾아야함 */
	
}