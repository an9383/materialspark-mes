package mes.web.bm;

import java.text.DateFormat;
import java.util.Date;
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
import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class MatrlCodeAdmController {

	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);

	//자재코드관리 메인
	@RequestMapping(value = "/bmsc0060", method = RequestMethod.GET)
	public String matrlCdAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("자재코드관리 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("009"); // 자재구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlGubunCd", systemCommonCodeList );

		systemCommonCodeVo.setBaseGroupCd("019"); // 구분(연질/경질)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gubunCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("020"); // 면취(압연)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("chamferYnCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("021"); // 표면처리
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("surfaceTrtmtCd", systemCommonCodeList );		
		
		systemCommonCodeVo.setBaseGroupCd("008"); // 생산단위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("productUnitCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("008"); // 재고단위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("tmUnitCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("079"); // 샘플여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("sampleYn", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("095"); // 기본조회여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlSelectYn", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("097"); // 자재결함구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("defectCode", systemCommonCodeList);
		
		return "bm/bmsc0060";
	}

	//자재코드관리 목록조회
	@RequestMapping(value = "/bm/matrlCdDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdDataList(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 목록조회 = "+ matrlCodeAdmVo);
		try {		
			List<MatrlCodeAdmVo> matrlCodeAdmData = matrlCodeAdmService.listAll(matrlCodeAdmVo);
			jsonData.put("data", matrlCodeAdmData);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("자재코드관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
	 return jsonData;
	}
	
	//자재코드관리 상세조회
	@RequestMapping(value = "/bm/matrlCdData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlCdData(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 상세조회");
		try {
			matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);
			jsonData.put("data", matrlCodeAdmVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("자재코드관리 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}

	//자재코드관리 등록
	@RequestMapping(value = "/bm/matrlCdCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlCdCreate(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 등록");
		
		try {
			String matrlSeq = matrlCodeAdmService.selectMatrlSeqCd();
			
			matrlCodeAdmVo.setMatrlSeq(matrlSeq);
			//String matrlCd = matrlCodeAdmVo.getQutyCd().concat(matrlSeq);
			String matrlCd = matrlCodeAdmVo.getMatrlInitial().substring(0, 1).concat(matrlSeq);
			matrlCodeAdmVo.setMatrlCd(matrlCd);
			matrlCodeAdmVo.setRegId(Utils.getUserId());
			matrlCodeAdmService.create(matrlCodeAdmVo);
			jsonData.put("data", matrlCodeAdmVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("자재코드관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	

	//자재코드관리 등록_3공장
	@RequestMapping(value = "/bm/matrlCdCreate_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlCdCreate_F3(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 등록");
		try {
			
			MatrlCodeAdmVo sudel = new MatrlCodeAdmVo();
			sudel.setMatrlCd(matrlCodeAdmVo.getMatrlCd());
			sudel = matrlCodeAdmService.matrlCodeDupliCheck(sudel);
			
			//중복 검사 진행
			if( sudel.getDupliCheck() != 0 ) {
				jsonData.put("data", matrlCodeAdmVo);
				jsonData.put("message", "자재코드가 이미 등록되어 있는 번호 입니다.<br>확인 후 다시 입력해주세요.");
				jsonData.put("result", "fail");
				return jsonData;
			} else {
				String matrlSeq = matrlCodeAdmService.selectMatrlSeqCd();
				matrlCodeAdmVo.setMatrlSeq(matrlSeq);
				matrlCodeAdmVo.setRegId(Utils.getUserId());
				matrlCodeAdmService.create(matrlCodeAdmVo);
				jsonData.put("data", matrlCodeAdmVo);
				jsonData.put("result", "ok");				
			}
	 	} catch (Exception e) {
			logger.info("자재코드관리 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}
	
	//자재코드관리 수정
	@RequestMapping(value = "/bm/matrlCdUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlCdUpdate(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 수정");
		try {
			/*
			 * String matrlCd =
			 * matrlCodeAdmVo.getQutyCd().concat(matrlCodeAdmVo.getMatrlSeq());
			 * 
			 * if(!matrlCd.equals(matrlCodeAdmVo.getMatrlCd())) { // 재질변경에 따른 자재코드정보 변경
			 * matrlCodeAdmVo.setMatrlCd(matrlCd); }
			 */
			matrlCodeAdmVo.setUpdId(Utils.getUserId());
			matrlCodeAdmService.update(matrlCodeAdmVo);
			jsonData.put("data", matrlCodeAdmVo);
			jsonData.put("result", "ok");
			
	 	} catch (Exception e) {
			logger.info("자재코드관리 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;
	}	


	//자재코드관리 목록팝업
	@RequestMapping(value = "/cmsc0050", method = RequestMethod.GET)
	public String matrlCdAdmPop(HttpServletRequest request, Locale locale, Model model) throws Exception {
		
		logger.info("자재코드관리 목록팝업");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		String matrlQuty = request.getParameter("qutyType");
		model.addAttribute("matrlQuty", matrlQuty );
		return "cm/cmsc0050";
	}
	
}

