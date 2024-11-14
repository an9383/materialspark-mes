package mes.web.em;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.em.AttachDataVo;
import mes.domain.em.CommonCodeAdmVo;
import mes.domain.em.CorrDataListVo;
import mes.domain.em.MeasureInstrmtAdmVo;
import mes.domain.sm.MatrlUserVo;
import mes.service.em.AttachDataService;
import mes.service.em.CommonCodeAdmService;
import mes.service.em.MeasureInstrmtAdmService;
import mes.service.sm.MatrlUserService;
import mes.web.io.CustomerExcelReader;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@PropertySources({
    @PropertySource("classpath:/jdbc.properties"),
    @PropertySource("classpath:/config.properties")
})
@Controller
public class MeasureInstrmtAdmController {

	@Inject
	private MeasureInstrmtAdmService measureInstrmtAdmService;

	@Inject
	private CommonCodeAdmService commonCodeAdmService;
	
	@Inject
	private AttachDataService attachDataService;
	
	@Inject
	private MatrlUserService matrlUserService;
	
	@Value("${file.measureExcelUpload}") 
	private String measureExcelUpload;
	
	@Value("${file.measureBasicForm}") 
	private String measureBasicForm;
	
	@Value("${file.measureInstrmtAdm1}")
	private String measurePath1;
	
	@Value("${file.measureInstrmtAdm2}")
	private String measurePath2;
	
	@Value("${file.measureInstrmtAdm3}")
	private String measurePath3;
	
	@Value("${file.attachDataPath1}")
	private String filePath1;
	
	@Value("${file.attachDataPath2}")
	private String filePath2;

	@Value("${file.attachDataPath3}")
	private String filePath3;
	
	@Value("${file.corrDataListPath1}")
	private String corrDataPath1;
	
	@Value("${file.corrDataListPath2}")
	private String corrDataPath2;
	
	@Value("${file.corrDataListPath3}")
	private String corrDataPath3;
	
	@Value("${factoryCode}")
	private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MeasureInstrmtAdmController.class);
	
	//계측기관리 메인
	@RequestMapping(value = "/emsc0060", method = RequestMethod.GET)
	public String measureInstrmtAdmMain(Locale locale, Model model) throws Exception {
		logger.info("계측기관리 메인");
		try {
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate );
			model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
			
			model.addAttribute("userNm", Utils.getUserNm());
			model.addAttribute("userNumber", Utils.getUserNumber());
			
			CommonCodeAdmVo commonCodeVo = new CommonCodeAdmVo();
			
			commonCodeVo.setBaseGroupCd("024"); // 사용여부
			commonCodeVo.setUseYnCd("001");
			List<CommonCodeAdmVo> measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useYn", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("013"); // 부서
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("admDept", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("014"); // 담당
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainChargr", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("103"); // 단위
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitUnit", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("104"); // 계측기구분
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitGubun", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("105"); // 장비위치
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitLoc", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("106"); // 사용빈도
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useFqy", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("107"); // 사용 주기
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("corrCycle", measureInstrmtList);
			
			commonCodeVo.setBaseGroupCd("108"); // 기기종류
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitKind", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("109"); // 구분(사출/봉제)
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainGubun", measureInstrmtList);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "em/emsc0060";
	}
	
	//계측기 이력 메인
	@RequestMapping(value = "/emsc0080", method = RequestMethod.GET)
	public String emsc0080(Locale locale, Model model) throws Exception {
		logger.info("계측기 이력 메인");
		try {
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate );
			model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
			
			model.addAttribute("userNm", Utils.getUserNm());
			model.addAttribute("userNumber", Utils.getUserNumber());
			
			CommonCodeAdmVo commonCodeVo = new CommonCodeAdmVo();
			
			commonCodeVo.setBaseGroupCd("024"); // 사용여부
			commonCodeVo.setUseYnCd("001");
			List<CommonCodeAdmVo> measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useYn", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("013"); // 부서
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("admDept", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("014"); // 담당
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainChargr", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("103"); // 단위
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitUnit", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("104"); // 계측기구분
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitGubun", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("105"); // 장비위치
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitLoc", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("106"); // 사용빈도
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useFqy", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("107"); // 사용 주기
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("corrCycle", measureInstrmtList);
			
			commonCodeVo.setBaseGroupCd("108"); // 기기종류
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitKind", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("109"); // 구분(사출/봉제)
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainGubun", measureInstrmtList);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "em/emsc0080";
	}
	
	//계측기 정기점검계획대비실적 메인
	@RequestMapping(value = "/emsc0070", method = RequestMethod.GET)
	public String emsc0070Main(Locale locale, Model model) throws Exception {
		logger.info("계측기 정기점검계획대비실적 메인");
		try {
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate );
			model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
			
			model.addAttribute("userNm", Utils.getUserNm());
			model.addAttribute("userNumber", Utils.getUserNumber());
			
			CommonCodeAdmVo commonCodeVo = new CommonCodeAdmVo();
			
			commonCodeVo.setBaseGroupCd("024"); // 사용여부
			commonCodeVo.setUseYnCd("001");
			List<CommonCodeAdmVo> measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useYn", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("013"); // 부서
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("admDept", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("014"); // 담당
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainChargr", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("103"); // 단위
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitUnit", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("104"); // 계측기구분
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitGubun", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("105"); // 장비위치
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitLoc", measureInstrmtList );
			
			commonCodeVo.setBaseGroupCd("106"); // 사용빈도
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("useFqy", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("107"); // 사용주기
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("corrCycle", measureInstrmtList);
			
			commonCodeVo.setBaseGroupCd("108"); // 기기종류
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mitKind", measureInstrmtList);

			commonCodeVo.setBaseGroupCd("109"); // 구분(사출/봉제)
			commonCodeVo.setUseYnCd("001");
			measureInstrmtList = commonCodeAdmService.CommonCodeList(commonCodeVo);
			model.addAttribute("mainGubun", measureInstrmtList);
			
			MatrlUserVo matrlUserVo = new MatrlUserVo(); //작성자
			List<MatrlUserVo> matrlUserList = matrlUserService.listAll(matrlUserVo);
			model.addAttribute("userList", matrlUserList );
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "em/emsc0070";
	}
	
	//계측기관리 전체조회
	@RequestMapping(value = "/em/measureInstrmtAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> measureInstrmtAdmList(MeasureInstrmtAdmVo MeasureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("계측기관리 읽기 : "+MeasureInstrmtAdmVo);
		try {
			List<MeasureInstrmtAdmVo> list  = measureInstrmtAdmService.measureInstrmtAdmList(MeasureInstrmtAdmVo);
			logger.info("검색 후 : "+list);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//계측기관리 상세조회
	@RequestMapping(value = "/em/measureInstrmtAdmRead", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> measureInstrmtAdmRead(CorrDataListVo corrDataListVo, MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("계측기 읽기 : "+measureInstrmtAdmVo);
		try {
			measureInstrmtAdmVo  = measureInstrmtAdmService.measureInstrmtAdmRead(measureInstrmtAdmVo);
//			logger.info("검색 후 : "+measureInstrmtAdmVo);
//			String filePath = measureInstrmtAdmVo.getImageFile1();
//			if(!(filePath == "" || filePath == null)){
//				String path = filePath.substring(0,filePath.indexOf("!"));
//				String oldFileNm = filePath.substring(filePath.indexOf("!")+1);
//				
//				File file = new File(path + "/" + oldFileNm);
//				String base = fileToString(file);
//				
//
//				
//				jsonData.put("base64", base);
//			}
			jsonData.put("data", measureInstrmtAdmVo);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	public String fileToString(File file) {
		String fileString = new String();
		
		byte[] base = new byte[(int) file.length()];
		try (FileInputStream fis = new FileInputStream(file)) {
			fis.read(base, 0, base.length);
			
			fileString = new String(base.toString());
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		return fileString;
	}
	
	//계측기 코드 생성
	@RequestMapping(value = "/em/getMitCd", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> getMitCd(MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("계측기 읽기 : "+measureInstrmtAdmVo);
		try {
			String mitCd = measureInstrmtAdmService.measureInstrmtSeq();
			jsonData.put("data", mitCd);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
		
		
	//계측기관리 등록
	@RequestMapping(value = "/em/measureInstrmtAdmCreate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> measureInstrmtAdmCreate(MeasureInstrmtAdmVo measureInstrmtAdmVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("계측기 등록: " + measureInstrmtAdmVo);
		try {
			measureInstrmtAdmVo.setMitCd(measureInstrmtAdmService.measureInstrmtSeq());
			measureInstrmtAdmVo.setRegId(Utils.getUserId());
			measureInstrmtAdmService.measureInstrmtAdmCreate(measureInstrmtAdmVo);
//			uploadFile(multi, corrDataListVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//게측기(엑셀) Create
	@RequestMapping(value="em/measureExcelCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> measureExcelCreate(@RequestBody List<Map<String, Object>> measureInstrmtAdmList) throws Exception{
		MeasureInstrmtAdmVo measureInstrmtAdmVo = new MeasureInstrmtAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("계측기 등록 :"+measureInstrmtAdmList);
		try {
			for(Map<String, Object> m :measureInstrmtAdmList) {
				
				String mitCd = measureInstrmtAdmService.measureInstrmtSeq();
				measureInstrmtAdmVo.setMitCd(mitCd);
				measureInstrmtAdmVo.setAdmNo(m.get("admNo").toString());
				measureInstrmtAdmVo.setMitNo(m.get("mitNo").toString());
				measureInstrmtAdmVo.setMitNm(m.get("mitNm").toString());
				measureInstrmtAdmVo.setMitLoc(m.get("mitLoc").toString());
				measureInstrmtAdmVo.setAdmDept(m.get("admDept").toString());
				measureInstrmtAdmVo.setMainChargr(m.get("mainChargr").toString());
				measureInstrmtAdmVo.setCorrCycle(m.get("corrCycle").toString());
				measureInstrmtAdmVo.setCorrCount(m.get("corrCount").toString());
				measureInstrmtAdmVo.setMitForm(m.get("mitForm").toString());
				measureInstrmtAdmVo.setMitKind(m.get("mitKind").toString());
				measureInstrmtAdmVo.setModelNm(m.get("modelNm").toString());
				measureInstrmtAdmVo.setMfcCorpNm(m.get("mfcCorpNm").toString());
				measureInstrmtAdmVo.setAcqDate(m.get("acqDate").toString());
				measureInstrmtAdmVo.setAcqCost(m.get("acqCost").toString());
				measureInstrmtAdmVo.setMitDesc(m.get("mitDesc").toString());
				measureInstrmtAdmVo.setUseYn("001");
				measureInstrmtAdmVo.setRegId(Utils.getUserId());
				measureInstrmtAdmService.measureInstrmtAdmCreate(measureInstrmtAdmVo);
			}
			
			jsonData.put("result", "ok");
				
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//계측기관리 수정
	@RequestMapping(value = "/em/measureInstrmtAdmUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> measureInstrmtAdmUpdate(CorrDataListVo corrDataListVo, MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			measureInstrmtAdmVo.setUpdId(Utils.getUserId());			
			measureInstrmtAdmService.measureInstrmtAdmUpdate(measureInstrmtAdmVo);
//			uploadFile(multi, corrDataListVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//계측기관리 삭제
	@RequestMapping(value = "/em/measureInstrmtAdmDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> measureInstrmtAdmDelete(
			@RequestParam(value = "mitCd") String mitCd,
			@RequestParam(value = "attachGubun") String attachGubun,
			@RequestParam(value = "attachCd") String attachCd,
			MeasureInstrmtAdmVo measureInstrmtAdmVo, 
			CorrDataListVo corrDataListVo, 
			AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String mPath = "";
			String cPath = "";
			String aPath = "";
			
			switch(factoryCode) {
			case "001" :
				mPath = measurePath1 + mitCd;
				cPath = corrDataPath1 + "001" + "/" + mitCd;
				aPath = filePath1 + attachGubun + "/" + mitCd;
				break;
			case "002" :
				mPath = measurePath2 + mitCd;
				cPath = corrDataPath1 + "001" + "/" + mitCd;
				aPath = filePath2 + attachGubun + "/" + mitCd;
				break;
			case "003" :
				mPath = measurePath3 + mitCd;
				cPath = corrDataPath1 + "001" + "/" + mitCd;
				aPath = filePath3 + attachGubun + "/" + mitCd;
				break;
			}

			//기본정보 삭제
			measureInstrmtAdmService.measureInstrmtAdmDelete(measureInstrmtAdmVo);
			folderDelete(mPath);
			
			//교정이력 삭제
			measureInstrmtAdmService.attachCorreDataDelete(corrDataListVo);
			folderDelete(cPath);
			
			//관련자료 삭제
			attachDataService.attachDataDelete(attachDataVo);
			folderDelete(aPath);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//계측기관리 이미지 경로조회
//	@RequestMapping(value = "/em/measureInstrmtImgRead", method = RequestMethod.GET)
//	public @ResponseBody Map<String, Object> measureInstrmtImgRead(MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
//		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("이미지조회");
//		try {
//		
//			MeasureInstrmtAdmVo vo=measureInstrmtAdmService.measureInstrmtImgRead(measureInstrmtAdmVo);
//			if (vo.getImageFile1() != null) {
//				String imageFile1 = new String(Base64.encodeBase64(vo.getImageFile1()));
//				String imageFile1Nm = vo.getImageFile1Nm();
//				jsonData.put("imageFile1", imageFile1);
//				jsonData.put("imageFile1Nm", imageFile1Nm);
//			}
//			if (vo.getImageFile2() != null) {
//				String imageFile2 = new String(Base64.encodeBase64(vo.getImageFile2()));
//				String imageFile2Nm = vo.getImageFile2Nm();
//				jsonData.put("imageFile2", imageFile2);
//				jsonData.put("imageFile2Nm", imageFile2Nm);
//			}
//			if (vo.getImageFile3() != null) {
//				String imageFile3 = new String(Base64.encodeBase64(vo.getImageFile3()));
//				String imageFile3Nm = vo.getImageFile3Nm();
//				jsonData.put("imageFile3", imageFile3);
//				jsonData.put("imageFile3Nm", imageFile3Nm);
//			}
//			if (vo.getImageFile4() != null) {
//				String imageFile4 = new String(Base64.encodeBase64(vo.getImageFile4()));
//				String imageFile4Nm = vo.getImageFile4Nm();
//				jsonData.put("imageFile4", imageFile4);
//				jsonData.put("imageFile4Nm", imageFile4Nm);
//			}
//			jsonData.put("data", vo);
//			jsonData.put("result", "ok");
//		} catch (Exception e) {
//			e.printStackTrace();
//			jsonData.put("result", "error");
//		}
//		return jsonData;
//	}
	 
	
	//수리이력 이미지 업로드 ver.2 --- 기존의 4장 등록을 기본정보 등록, 수정할 때 한장 함께 업로드 되는것으로 변경
	@RequestMapping(value = "/em/measureInstrmtImageUpload2", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> measureInstrmtImageUpload2(MeasureInstrmtAdmVo measureInstrmtAdmVo, 
			CorrDataListVo corrDataListVo, MultipartHttpServletRequest multi) throws Exception {
		logger.debug("수리이력 이미지 업로드");
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			String mitCd = corrDataListVo.getMitCd();
			String corrSeq = measureInstrmtAdmService.getCorrSeq(corrDataListVo);
			String path = "";
			String newFileNm = "";
			
			MultipartFile mFile = multi.getFile("imgAdd1");
			
			//저장하려는 파일 이름
			String insertFileName = mFile.getOriginalFilename();
			
			measureInstrmtAdmVo = measureInstrmtAdmService.measureInstrmtImgRead(measureInstrmtAdmVo);
			
			//이미 저장된 파일 이름
			String oldFile = "";
			if(!(measureInstrmtAdmVo.getImageFile1Nm() == null || measureInstrmtAdmVo.getImageFile1Nm() == "")) {
				oldFile = measureInstrmtAdmVo.getImageFile1Nm();
			}
			
			switch(factoryCode) {
			case "001" :
				path = measurePath1 + mitCd;
				break;
			case "002" :
				path = measurePath2 + mitCd;
				break;
			case "003" :
				path = measurePath3 + mitCd;
				break;
			}
			
			//저장하려는 파일이 빈 파일이면
			if(insertFileName.equals("") || insertFileName==null) {
//				measureInstrmtAdmVo.setImageFile1Nm(multi.getParameter("olfFile").toString());
				
				//저장된 파일이 빈 값이 아니라면 저장되어 있는 파일을 삭제한다.
				if(oldFile!=null) {
					measureInstrmtAdmVo.setUpdId(Utils.getUserId());		
					measureInstrmtAdmService.measureInstrmtImageDelete(measureInstrmtAdmVo);
				}
			} else {
				
				//저장하는 파일이 빈 파일 이나리면 수정한다.
				String extension = insertFileName.substring(insertFileName.lastIndexOf(".") + 1);
				String[] imageList = {"tif","pjp","xbm","jxl","svgz","jpg","jpeg","ico","tiff","gif","svg","jfif","webp","png","bmp","pjpeg","avif","TIF","PJP","XBM","JXL","SVGZ","JPG","JPEG","ICO","TIFF","GIF","SVG","JFIF","WEBP","PNG","BMP","PJPEG","AVIF"};
				Long size = mFile.getSize();
				
				//파일 형식, 크기 비교
				if(!Arrays.asList(imageList).contains(extension)) {
					jsonData.put("result", "extensionError");
		  		} 
//				else if (size > (1 * 1024 * 1024)) {
//		  			jsonData.put("result", "sizeError");
//				} 
				else {
					File dir = new File(path);
					if(!dir.exists()) {
						dir.mkdirs();
					}
					newFileNm = mitCd + "_" + corrSeq + "." + insertFileName.substring(insertFileName.lastIndexOf(".") + 1);
					measureInstrmtAdmVo.setImageFile1(path + "!" + newFileNm);
					measureInstrmtAdmVo.setImageFile1Nm(insertFileName);
					
					measureInstrmtAdmService.measureInstrmtImageUpload(measureInstrmtAdmVo);
					try {
						mFile.transferTo(new File(path + "/" + newFileNm));
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
			}
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	
	
	//계측기관리 이미지 업로드(DB저장)
	@RequestMapping(value = "/em/measureInstrmtImageUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> measureInstrmtImageUpload(CorrDataListVo corrDataListVo, MeasureInstrmtAdmVo measureInstrmtAdmVo,
			MultipartHttpServletRequest multi) throws Exception {
		logger.info("업로드 컨트롤러 시작");
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("계측기이미지 vo = " + measureInstrmtAdmVo);
			//이미지 번호
			String value = multi.getParameter("value");
			MultipartFile mFile = multi.getFile("imgAdd" + value);
			
			String fileName = mFile.getOriginalFilename(); // 원본 파일 명
					
			String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
			String[] imageList = {"tif","pjp","xbm","jxl","svgz","jpg","jpeg","ico","tiff","gif","svg","jfif","webp","png","bmp","pjpeg","avif","TIF","PJP","XBM","JXL","SVGZ","JPG","JPEG","ICO","TIFF","GIF","SVG","JFIF","WEBP","PNG","BMP","PJPEG","AVIF"};
//			Long size = mFile.getSize();
			
			if(!Arrays.asList(imageList).contains(extension)) {
				jsonData.put("result", "extensionError");
	  		} 
//			else if (size > (1 * 1024 * 1024)) {
//	  			jsonData.put("result", "sizeError");
//			} 
			else if (mFile == null || mFile.isEmpty()) {

			} else {
				switch(value) {
				case "1" :
//					measureInstrmtAdmVo.setImageFile1(mFile.getBytes());
					measureInstrmtAdmVo.setImageFile1Nm(fileName);
					break;
				case "2" :
//					measureInstrmtAdmVo.setImageFile2(mFile.getBytes());
					measureInstrmtAdmVo.setImageFile2Nm(fileName);
					break;
				case "3" :
//					measureInstrmtAdmVo.setImageFile3(mFile.getBytes());
					measureInstrmtAdmVo.setImageFile3Nm(fileName);
					break;
				case "4" :
//					measureInstrmtAdmVo.setImageFile4(mFile.getBytes());
					measureInstrmtAdmVo.setImageFile4Nm(fileName);
					break;
				}
				
				measureInstrmtAdmService.measureInstrmtImageUpload(measureInstrmtAdmVo);
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//계측기관리 이미지 Delete
	@RequestMapping(value = "/em/measureInstrmtImageDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> measureInstrmtImageDelete(CorrDataListVo corrDataListVo, MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("파일 삭제 vo:"+measureInstrmtAdmVo);
		try {
			
			measureInstrmtAdmVo.setUpdId(Utils.getUserId());		
			measureInstrmtAdmService.measureInstrmtImageDelete(measureInstrmtAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
			logger.info(""+Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//첨부파일 삭제
	@RequestMapping(value = "/em/measureInstrmtfileDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> fileDelete1(
			@RequestParam(value = "path") String path,
		    @RequestParam(value = "imageFile1Nm") String imageFile1Nm,
		    MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();

		fileDelete(path, imageFile1Nm);

		jsonData.put("result", "ok");
		
		return jsonData;
	}
	
	//기본정보 첨부파일 다운로드
	@RequestMapping(value = "/em/measureInstrmtAdmFileDownload", method = RequestMethod.GET)
	public @ResponseBody void measureInstrmtAdmFileDownload(HttpServletResponse res, HttpServletRequest req,
		    @RequestParam(value = "mitCdVal") String mitCd,
		    @RequestParam(value = "changedFile1Nm") String changedFile1Nm,
		    MeasureInstrmtAdmVo measureInstrmtAdmVo, CorrDataListVo corrDataListVo) throws Exception {
		try {
			
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = measurePath1 + mitCd + "/" + changedFile1Nm;;
				break;
			case "002" :
				path = measurePath2 + mitCd + "/" + changedFile1Nm;;
				break;
			case "003" :
				path = measurePath3 + mitCd + "/" + changedFile1Nm;;
				break;
			}
			
			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				changedFile1Nm = URLEncoder.encode(changedFile1Nm, "UTF-8").replaceAll("\\+", "%20");
			} else {
				changedFile1Nm = new String(changedFile1Nm.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=" + changedFile1Nm + ";");

			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//계측기관리 엑셀조회
	@RequestMapping(value = "em/measureExcelDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> measureExcelDataList(MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info(measureInstrmtAdmVo.getUrl());
		
		if(measureInstrmtAdmVo.getUrl()==null || measureInstrmtAdmVo.getUrl().equals("")) {
			List<MeasureInstrmtAdmVo> MeasureInstrmtList = new ArrayList<MeasureInstrmtAdmVo>();
			jsonData.put("data", MeasureInstrmtList);
		}else {
			CustomerExcelReader excelReader = new CustomerExcelReader();
			List<MeasureInstrmtAdmVo> MeasureInstrmtList = excelReader.measureFileload(measureInstrmtAdmVo.getUrl(), logger);
			jsonData.put("data", MeasureInstrmtList);
			
			logger.info("견적관리 엑셀조회:" + MeasureInstrmtList);				
			File file = new File(measureInstrmtAdmVo.getUrl());
			logger.info(measureInstrmtAdmVo.getUrl());

			if( file.exists() ){
	    		if(file.delete()){
	    			logger.info("파일삭제 성공");    			
	    		}else{
	    			logger.info("파일삭제 실패");
	    		}
	    	}else{
	    		logger.info("파일이 존재하지 않습니다.");
	    	}
			
		}
		return jsonData;
	}
	
	//계측기관리 업로드
	@RequestMapping(value= "em/measureExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> measureExcelUpload(Model model,@RequestParam("excelfile") MultipartFile file) {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		String url = null;
		String fileName = "";
		try {
			// 파일 정보
			String originFilename = file.getOriginalFilename();
			String extName = originFilename;
			Long size = file.getSize();
			String path = measureExcelUpload;
			
			// 서버에서 저장 할 파일 이름
//			TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
//			Calendar calendar = Calendar.getInstance(tz);
//			fileName += calendar.get(Calendar.YEAR);
//			fileName += calendar.get(Calendar.MONTH)+1;
//			fileName += calendar.get(Calendar.DATE);
//			fileName += calendar.get(Calendar.HOUR);
//			fileName += calendar.get(Calendar.MINUTE);
//			fileName += calendar.get(Calendar.SECOND);
			
			// 서버에서 저장 할 파일 이름
			Date today = new Date();
			SimpleDateFormat nowDate = new SimpleDateFormat("yyyyMMddhhmmss");
			logger.info("현재시간 : " + nowDate.format(today));
			fileName += nowDate.format(today);
			
			String[] originalFileName = extName.split("\\.");
			if(originalFileName[1].equals("xlsx")) {
				fileName += ".xlsx";		
			} else if(originalFileName[1].equals("xls")) {
				fileName += ".xls";		
			}
			
			String saveFileName = fileName;
			
			logger.info("originFilename : " + originFilename);
			logger.info("extensionName : " + extName);
			logger.info("size : " + size);
			logger.info("saveFileName : " + saveFileName);
			
			logger.info("path : " + path);
			
			File Folder = new File(path);
			
			if (!Folder.exists()) {
				try{
				    Folder.mkdirs(); //폴더 생성합니다.
				    logger.info("폴더가 생성되었습니다.");
			        } 
			        catch(Exception e){
				    e.getStackTrace();
				}        
		         }else {
		        	 logger.info("이미 폴더가 생성되어 있습니다.");
			}
			
			boolean result = false;
			byte[] data = file.getBytes();
			
			logger.info("writeFile path ===> " +path);
			
			FileOutputStream fos = new FileOutputStream(path + "/" + saveFileName);
			logger.info("data ==> " + data);
			fos.write(data);
			fos.close();
			
			url = path + saveFileName;
			logger.info(url);
			jsonData.put("data", url);
			jsonData.put("result", "ok");
		}
		catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();	
			throw new RuntimeException(e);
		}
		
		return jsonData;
			
	}
	
	//기본양식 다운로드
	@RequestMapping(value="em/measureBasicForm", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> measureBasicForm( HttpServletResponse res , HttpServletRequest req,
			MeasureInstrmtAdmVo measureInstrmtAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			String saveFile = "basicMeasure.xlsx"; 
			String filePath = measureBasicForm + "/basicMeasure.xlsx";
			fileDownload(res, req, saveFile, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}

	//파일 삭제하는 함수
	public void fileDelete(String path, String fileName) throws Exception{
		
		File delfile = new File(path + "/" + fileName);
		
		if(delfile.exists()) {    //삭제하고자 하는 파일이 해당 서버에 존재하면 삭제시킨다
			delfile.delete();
			
			File file = new File(path);
			
			if(file.exists()) {
				File[] folder = file.listFiles();
				if(folder.length == 0) {
					file.delete();
				}
			}
        } else {
        	File file = new File(path);
        	
        	if(file.exists()) {
				File[] folder = file.listFiles();
				if(folder.length == 0) {
					file.delete();
				}
			}
        	
        }
		
	}
	
	//폴더 삭제하는 함수
	public void folderDelete(String path) throws Exception{
		
		File delfolder = new File(path);
		
		while(delfolder.exists()) {
			File[] folder_list = delfolder.listFiles(); //파일리스트 얻어오기
					
			for (int j = 0; j < folder_list.length; j++) {
				folder_list[j].delete(); //파일 삭제 		
			}
					
			if(folder_list.length == 0 && delfolder.isDirectory()){ 
				delfolder.delete(); //대상폴더 삭제
			}
	            }
	}
	
	//파일 다운로드
	public void fileDownload( HttpServletResponse res , HttpServletRequest req, String saveFile, String filePath) throws Exception{
		try {
			
			String dFile = saveFile;
			String path = "";
			switch(factoryCode) {
			case "001" :
				path = filePath1;
				break;
			case "002" :
				path = filePath2;
				break;
			case "003" :
				path = filePath3;
				break;
			}

//			logger.info(path);
			File file = new File(path);
		
			String userAgent = req.getHeader("User-Agent");
	
			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);
	
			if (ie) {
//				logger.info("익스");
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
//				logger.info("크롬");
				dFile = new String(dFile.getBytes("UTF-8"), "ISO-8859-1");
			}
			
	
			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + dFile + "\";");
	
			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);
	
			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}
	
			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	  }
	
	//교정사항이력 자료 등록
	@RequestMapping(value = "/em/corrDataListCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> corrDataListCreate(CorrDataListVo corrDataListVo, MultipartHttpServletRequest multi, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("교정사항이력 자료 : " );
		
		try {
			String newFileName = "";
			String mitCd = corrDataListVo.getMitCd();
			String corrSeq = measureInstrmtAdmService.getCorrSeq(corrDataListVo);
			String corrGubun = corrDataListVo.getCorrGubun();
			if(mitCd == null || mitCd.equals("")) {
				mitCd = measureInstrmtAdmService.measureInstrmtSeq();
			}
			
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = corrDataPath1 + "/" + corrGubun + "/" + mitCd;
				break;
			case "002" :
				path = corrDataPath2 + "/" + corrGubun + "/" + mitCd;
				break;
			case "003" :
				path = corrDataPath3 + "/" + corrGubun + "/" + mitCd;
				break;
			}
			
			
			MultipartFile mFile = multi.getFile("fileNm");
			String fileName = mFile.getOriginalFilename();   //실제파일이름
//			logger.info("실제 파일 이름 : "+ fileName);
			
			if(!(fileName == "" || fileName == null)) {
				File dir = new File(path);
				if(!dir.exists()) {
					dir.mkdirs();
				}
			
			
			
				newFileName = mitCd + "_" + corrSeq + "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				mFile.transferTo(new File(path + "/" + newFileName));
				
				corrDataListVo.setAttachFn(fileName);
				corrDataListVo.setAttachPath(path + "/" + newFileName);
//				logger.info("파일업로드 성공됨");
			}
			
			corrDataListVo.setCorrSeq(corrSeq);
			corrDataListVo.setRegId(Utils.getUserNumber());
			
			measureInstrmtAdmService.attachCorreDataCreate(corrDataListVo);
//			logger.info("등록후 vo:" + corrDataListVo);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		
		return jsonData;
	}
	
	//차기예정 교정사항이력 등록
	@RequestMapping(value="em/corrWillDataListCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> corrWillDataListCreate(CorrDataListVo corrDataListVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("차기예정 교정사항이력 등록 :" + corrDataListVo);
		try {
			String corrSeq = measureInstrmtAdmService.getCorrSeq(corrDataListVo);
			corrDataListVo.setCorrSeq(corrSeq);
			corrDataListVo.setRegId(Utils.getUserNumber());
			measureInstrmtAdmService.attachCorreDataCreate(corrDataListVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//교정사항이력 자료 수정
	@RequestMapping(value = "/em/corrDataListUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> corrDataListUpdate(CorrDataListVo corrDataListVo, MultipartHttpServletRequest multi, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("교정사항이력 자료: " );
		
		try {
			String attachFn = corrDataListVo.getAttachFn();
			String newFileName = "";
			String mitCd = corrDataListVo.getMitCd();
			String corrSeq = corrDataListVo.getCorrSeq();
			String corrGubun = corrDataListVo.getCorrGubun();
			if(mitCd == null || mitCd.equals("")) {
				mitCd = measureInstrmtAdmService.measureInstrmtSeq();
			}
			String path = corrDataPath1 + "/" + corrGubun + "/" + mitCd;
			
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			MultipartFile mFile = multi.getFile("fileNm");
			String fileName = mFile.getOriginalFilename();   //업로드하는 파일 이름
//			logger.info("실제 파일 이름 : " + fileName);
			
			if(fileName!=null && !(fileName.equals(""))) {
				newFileName = mitCd + "_" + corrSeq + "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				mFile.transferTo(new File(path + "/" + newFileName));
				corrDataListVo.setAttachFn(fileName);
				corrDataListVo.setAttachPath(path + "/" + newFileName);
			} else {
				corrDataListVo.setAttachFn(attachFn);
				corrDataListVo.setAttachPath(path + "/" + newFileName);
			}
//			logger.info("파일업로드 성공됨");
			
			//String corrSeq = measureInstrmtAdmService.getCorrSeq(corrDataListVo);
			//corrDataListVo.setCorrSeq(corrSeq);
			corrDataListVo.setUpdId(Utils.getUserId());
			
			measureInstrmtAdmService.attachCorreDataUpdate(corrDataListVo);
//			logger.info("등록후 vo : " + corrDataListVo);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		
		return jsonData;
	}
	
	//교정사항이력 자료 삭제
	@RequestMapping(value = "em/corrDataListDelete", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> corrDataListDelete(
			@RequestParam("mitCd") String mitCd,
			@RequestParam("corrSeq") String corrSeq,
			@RequestParam("corrGubun") String corrGubun,
			@RequestParam("attachFn") String attachFn,
			CorrDataListVo corrDataListVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		corrDataListVo.setRegId(Utils.getUserId());
		try {
			String fileName = "";
			String path = "";
			String ext = attachFn.substring(attachFn.indexOf(".")+1);
			
			switch(factoryCode) {
			case "001" :
				path = corrDataPath1 + "/" + corrGubun + "/" + mitCd;
				break;
			case "002" :
				path = corrDataPath2 + "/" + corrGubun + "/" + mitCd;
				break;
			case "003" :
				path = corrDataPath3 + "/" + corrGubun + "/" + mitCd;
				break;
			}
			
			fileName = mitCd + "_" + corrSeq + "." + ext;
			
			fileDelete(path, fileName);
			
			measureInstrmtAdmService.attachCorreDataDelete(corrDataListVo);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	
		
	//교정사항 이력 조회
	@RequestMapping(value = "em/attachCorreDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> attachCorreDataList(CorrDataListVo corrDataListVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		corrDataListVo.setRegId(Utils.getUserId());
//		logger.info("관련 자료 조회 = "+ corrDataListVo);
		try {
			List<CorrDataListVo> corrDataList = measureInstrmtAdmService.attachCorreDataList(corrDataListVo);
			jsonData.put("data", corrDataList);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	
	//계측기 교정사항이력 Read
	@RequestMapping(value = "/em/measureInstrmtCorreAdmRead", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> measureInstrmtCorreAdmRead(CorrDataListVo corrDataListVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
//		logger.info("계측기 읽기 : "+corrDataListVo);
		try {
			corrDataListVo  = measureInstrmtAdmService.measureInstrmtCorreAdmRead(corrDataListVo);
//			logger.info("검색 후 : " + corrDataListVo);
			jsonData.put("data", corrDataListVo);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	
	//교정사항 첨부파일 다운로드
	@RequestMapping(value = "/em/corrDataFileDownload", method = RequestMethod.GET)
	public @ResponseBody void corrDataFileDownload(HttpServletResponse res, HttpServletRequest req, CorrDataListVo corrDataListVo) throws Exception {
		try {
			
//			logger.info("vo:===============>"+corrDataListVo);
			CorrDataListVo fileNm = measureInstrmtAdmService.measureInstrmtCorreAdmRead(corrDataListVo);
			
			String dFile = fileNm.getAttachFn();
			String newFileName = corrDataListVo.getMitCd() + "_" + corrDataListVo.getCorrSeq() + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
			String path = corrDataPath1 + corrDataListVo.getCorrGubun() + "/" + corrDataListVo.getMitCd() + "/" + newFileName;
			
			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
				dFile = new String(dFile.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=" + dFile + ";");

			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
	




