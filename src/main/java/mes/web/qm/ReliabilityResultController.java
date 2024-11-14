package mes.web.qm;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInWhsRqtVo;
import mes.domain.mm.ItemPartAdmVo;
import mes.domain.qm.ReliabilityResultVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.FileUploadService;
import mes.service.qm.ReliabilityResultService;
import mes.web.io.CustomerExcelReader;
import mes.web.po.AgtPaperController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ReliabilityResultController {

	@Value("${file.reliabilityResult}")
	private String reliability_result_Path;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private ReliabilityResultService reliabilityResultService;
	@Inject
	private FileUploadService fileUploadService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	
	@Value("${factoryCode}") private String facotryCode;
	@Value("${reliabilityCheckUploadDir}") private String reliabilityCheckUploadDir;
	
	private static final Logger logger = LoggerFactory.getLogger(ReliabilityResultController.class);
	/*------------------------엣지검사 시작------------------------*/
	//품질괄리 - 신뢰성 결과
	@RequestMapping(value = "/qmsc0150", method = RequestMethod.GET)
	public String qmsc0150(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 신뢰성 결과");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//신뢰성 결과 사진 개수
		systemCommonCodeVo.setBaseGroupCd("084");
		List<SystemCommonCodeVo> photoCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("photoCount", photoCount);
		
		return "qm/qmsc0150";
	}
	
	//품질괄리 - 신뢰성 결과 등록(실링)
	@RequestMapping(value = "/qmsc3210", method = RequestMethod.GET)
	public String qmsc3210(Locale locale, Model model) throws Exception {
		logger.info("품질관리 / 신뢰성 결과 등록(실링)");
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//신뢰성 결과 사진 개수
		/*systemCommonCodeVo.setBaseGroupCd("084");
		List<SystemCommonCodeVo> photoCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("photoCount", photoCount);*/
		
		return "qm/qmsc3210";
	}
	
	//품질괄리 - 신뢰성 결과 조회(일일)
	@RequestMapping(value = "/qmsc3220", method = RequestMethod.GET)
	public String qmsc3220(Locale locale, Model model) throws Exception {
		logger.info("품질관리 / 신뢰성 결과 조회(일일)");
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//설비
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		//기종
		systemCommonCodeVo.setBaseGroupCd("080");
		List<SystemCommonCodeVo> gijongList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongList", gijongList);
		
		return "qm/qmsc3220";
	}
	
	//품질괄리 - 신뢰성 결과 조회(24시간)
	@RequestMapping(value = "/qmsc3230", method = RequestMethod.GET)
	public String qmsc3230(Locale locale, Model model) throws Exception {
		logger.info("품질관리 / 신뢰성 결과 조회(24시간)");
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//설비
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		//기종
		systemCommonCodeVo.setBaseGroupCd("080");
		List<SystemCommonCodeVo> gijongList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongList", gijongList);
		
		return "qm/qmsc3230";
	}
	
	//품질괄리 - 신뢰성 결과 조회(15시간)
	@RequestMapping(value = "/qmsc3240", method = RequestMethod.GET)
	public String qmsc3240(Locale locale, Model model) throws Exception {
		logger.info("품질관리 / 신뢰성 결과 조회(15시간)");
		
		if("003".equals(facotryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//설비
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		//기종
		systemCommonCodeVo.setBaseGroupCd("080");
		List<SystemCommonCodeVo> gijongList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongList", gijongList);
		
		return "qm/qmsc3240";
	}
	
	@RequestMapping(value= "bm/reliabilityCheckExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityCheckExcelUpload(Model model,@RequestParam("excelfile") MultipartFile file) {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
		
		try {		
			String url = fileUploadService.restore(file, logger, reliabilityCheckUploadDir);
			logger.info(url);
			model.addAttribute("url", url);
			matrlInWhsRqtVo.setUrl(url);
			jsonData.put("data", matrlInWhsRqtVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("matrlInOutExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}

		return jsonData;
			
	}
	
	//신뢰성결과 3공장 파일 읽기
	@RequestMapping(value = "/bm/reliabilityCheckDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityCheckDataList_F3(String filename) throws Exception {
		CustomerExcelReader excelReader 		= new CustomerExcelReader();
		Map<String, Object> jsonData 			= new HashMap<String, Object>();

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//신뢰성 실링 기준값
		systemCommonCodeVo.setBaseGroupCd("111");
		List<SystemCommonCodeVo> shillingValList = systemCommonCodeService.listAll(systemCommonCodeVo);
		try {
			List<ReliabilityResultVo> matrlInWhsRqtData = excelReader.fileload_qmsc3210_F3(filename, logger, shillingValList);
			logger.info("신뢰성결과 엑셀조회(3공장)");
			File file = new File(filename);
			logger.info("filename : "+filename);
			logger.info("matrlInWhsRqtData : "+matrlInWhsRqtData);
			
			if(matrlInWhsRqtData.size() != 0) {
				jsonData.put("data", matrlInWhsRqtData);
				jsonData.put("result", "ok");
			}else {
				jsonData.put("message", "파일에 잘못된 값이 있습니다.<br>확인 후 시도해주세요.");
				jsonData.put("result", "fail");
			}
			
			if (file.exists()) {
					if (file.delete()) {
						logger.info("파일삭제 성공");
					} else {
						logger.info("파일삭제 실패");
					}
				} else {
					logger.info("파일이 존재하지 않습니다.");
				}
		} catch(NumberFormatException e) {
			jsonData.put("message", "파일에 잘못된 값이 있습니다.<br>확인 후 시도해주세요.");
			jsonData.put("result", "fail");
		}

		return jsonData;
		
	}
	
	//신뢰성 결과 전체조회
	@RequestMapping(value = "qm/reliabilityResultList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityResultList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 전체 목록조회");
			List<ReliabilityResultVo> reliabilityResultList = reliabilityResultService.reliabilityResultList(reliabilityResultVo);
		
			logger.info("신뢰성 결과 전체 목록조회" +reliabilityResultList);

			jsonData.put("data", reliabilityResultList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//신뢰성 실링 전체조회
	@RequestMapping(value = "qm/reliabilityResultShillingList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityResultShillingList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 실링 전체 목록조회"+reliabilityResultVo);
			List<ReliabilityResultVo> reliabilityResultList = reliabilityResultService.reliabilityResultShillingList(reliabilityResultVo);
		
			logger.info("신뢰성 실링 전체 목록조회" +reliabilityResultList);

			jsonData.put("data", reliabilityResultList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//신뢰성 결과 특정 Read(List)
	@RequestMapping(value = "qm/reliabilityResultSelectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityResultSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 특정 Read(List)");
			List<ReliabilityResultVo> reliabilityResultSelectList = reliabilityResultService.reliabilityResultSelectList(reliabilityResultVo);
		
			logger.info("신뢰성 결과 특정 Read(List)" +reliabilityResultSelectList);

			jsonData.put("data", reliabilityResultSelectList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//신뢰성결과 전체 등록 & 수정
	@RequestMapping(value = "qm/reliabilityResultCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityResultCreate(ReliabilityResultVo reliabilityResultVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			JSONParser jsonParser 			= new JSONParser();
			JSONObject jsonObj 				= new JSONObject();
			JSONArray jsonArray 			= (JSONArray) jsonParser.parse(reliabilityResultVo.getArrayData());
			ReliabilityResultVo trustDtlVo 	= new ReliabilityResultVo();
			
			for(int i=0;i<jsonArray.size();i++){
				
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				
				if (jsonObjDtl.get("trustSeq").toString().isEmpty()) {
					
					logger.info("-------------나는 값을 가지고 있지 않은 테이블이야---------------");
					String date 	= DateUtil.getToday("yyyyMMdd").substring(2,8);
					String seq 		= reliabilityResultService.getTrustSeq(date);
					String trustSeq = date+'-'+seq;
					
					trustDtlVo.setLotNo(jsonObjDtl.get("lotNo").toString());				//자재투입LOT
					trustDtlVo.setTrustGubun(jsonObjDtl.get("trustGubun").toString());		//구분
					
					logger.info("시퀀스 값은 : "+trustSeq);
					trustDtlVo.setTrustSeq(trustSeq);										//시퀀스
					
					trustDtlVo.setTestDate(jsonObjDtl.get("testDate").toString());			//입력일자
					trustDtlVo.setData1(jsonObjDtl.get("data1").toString());				//실효1번
					trustDtlVo.setData2(jsonObjDtl.get("data2").toString());				//실효2번
					trustDtlVo.setData3(jsonObjDtl.get("data3").toString());				//수치
					trustDtlVo.setData4(jsonObjDtl.get("data4").toString());				//OK/NG
					trustDtlVo.setTrustDesc(jsonObjDtl.get("trustDesc").toString());		// 비고
					trustDtlVo.setRegId(Utils.getUserId());									//등록자
					
					logger.info("신뢰성결과 전체 등록 : "+ trustDtlVo);
					reliabilityResultService.reliabilityResultCreate(trustDtlVo);
					
				}else {
					logger.info("***************나는 값을 가지고 있는 테이블이야*******************");
					//기존 테이블 수정 부분
					
					trustDtlVo.setLotNo(jsonObjDtl.get("lotNo").toString());				//자재투입LOT
					trustDtlVo.setTrustGubun(jsonObjDtl.get("trustGubun").toString());		//구분
					trustDtlVo.setTrustSeq(jsonObjDtl.get("trustSeq").toString());			//기존 시퀀스
					
					trustDtlVo.setTestDate(jsonObjDtl.get("testDate").toString());			//입력일자
					trustDtlVo.setData1(jsonObjDtl.get("data1").toString());				//실효1번
					trustDtlVo.setData2(jsonObjDtl.get("data2").toString());				//실효2번
					trustDtlVo.setData3(jsonObjDtl.get("data3").toString());				//수치
					trustDtlVo.setData4(jsonObjDtl.get("data4").toString());				//OK/NG
					trustDtlVo.setTrustDesc(jsonObjDtl.get("trustDesc").toString());		// 비고
					trustDtlVo.setUpdId(Utils.getUserId());									//수정자
					
					reliabilityResultService.reliabilityResultUpdate(trustDtlVo);
				}
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성결과 실링 등록
	@RequestMapping(value = "qm/reliabilityResultShillingCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityResultShillingCreate(
			@RequestParam(value="insertList", required=false) String insertList,
			@RequestParam(value="deleteList", required=false) String deleteList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {	
			ReliabilityResultVo reliabilityResultVo = new ReliabilityResultVo();
			reliabilityResultVo.setRegId(Utils.getUserId());
			reliabilityResultVo.setInsertList(insertList);
			reliabilityResultVo.setDeleteList(deleteList);
			//logger.error("신뢰성결과 실링 등록 : "+ insertList);
			//logger.error("신뢰성결과 실링 등록 : "+ deleteList);
			//logger.error("신뢰성결과 실링 등록 : "+ reliabilityResultVo);
			reliabilityResultService.reliabilityResultShillingDelete(reliabilityResultVo);
			reliabilityResultService.reliabilityResultShillingCreate(reliabilityResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 삭제
	@RequestMapping(value = "qm/reliabilityResultDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityResultDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 삭제");
			reliabilityResultService.reliabilityResultDelete(reliabilityResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//---------------------------------------------------------------사진 관련---------------------------------------------------------------//
	
	//신뢰성 결과 특정 사진  Read(List)
	@RequestMapping(value = "qm/reliabilityPhotoSelectList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityPhotoSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 특정 사진  Read(List)");
			List<ReliabilityResultVo> reliabilityResultSelectList = reliabilityResultService.reliabilityPhotoSelectList(reliabilityResultVo);
			
			String[] imageFile = new String[reliabilityResultSelectList.size()];
			String[] imageFileNm = new String[reliabilityResultSelectList.size()];
			String[] trustPhotoSeq = new String[reliabilityResultSelectList.size()];
			String[] imageChangeFileNm = new String[reliabilityResultSelectList.size()];
			String[] imageFileSize = new String[reliabilityResultSelectList.size()];
			
			for (int i=0; i<reliabilityResultSelectList.size(); i++) {
				
				//사진 Base64
				if (reliabilityResultSelectList.get(i).getImageFile() != null) {
					imageFile[i] = new String(Base64.encodeBase64(reliabilityResultSelectList.get(i).getImageFile()));
					jsonData.put("imageFile", imageFile);
				}
				
				//파일 명
				if (reliabilityResultSelectList.get(i).getImageFileNm() != null) {
					imageFileNm[i] = reliabilityResultSelectList.get(i).getImageFileNm();
					jsonData.put("imageFileNm", imageFileNm);
				}
				
				//바뀐 파일 명
				if (reliabilityResultSelectList.get(i).getImageChangeFileNm() != null) {
					imageChangeFileNm[i] = reliabilityResultSelectList.get(i).getImageChangeFileNm();
					jsonData.put("imageChangeFileNm", imageChangeFileNm);
				}
				
				//파일 사이즈
				if (reliabilityResultSelectList.get(i).getImageFileSize() != null) {
					imageFileSize[i] = reliabilityResultSelectList.get(i).getImageFileSize();
					jsonData.put("imageFileSize", imageFileSize);
				}
				
				//사진관련 시퀀스
				trustPhotoSeq[i]  = reliabilityResultSelectList.get(i).getTrustPhotoSeq();
				jsonData.put("trustPhotoSeq", trustPhotoSeq);
			}
			jsonData.put("photoSize", reliabilityResultSelectList.size());
			
			logger.info("신뢰성 결과 특정 Read(List)" +reliabilityResultSelectList);

			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 사진 공백 파일 등록
	@RequestMapping(value = "qm/reliabilityPhotoBlankCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityPhotoBlankCreate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 사진 공백 등록 :" + reliabilityResultVo);
			
			String searchCondition = reliabilityResultVo.getLotNo().toString() + reliabilityResultVo.getTrustGubun().toString();
			String trustPhotoSeq 	= reliabilityResultService.getTrustPhotoSeq(searchCondition);
			
			logger.info("사진관련 시퀀스 : "+trustPhotoSeq);
			
			reliabilityResultVo.setTrustPhotoSeq(trustPhotoSeq);
			
			reliabilityResultService.reliabilityPhotoCreate(reliabilityResultVo);
			
			jsonData.put("result", "ok");
			jsonData.put("trustPhotoSeq", trustPhotoSeq);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 사진 수정
	@RequestMapping(value = "qm/reliabilityPhotoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityPhotoUpdate(ReliabilityResultVo reliabilityResultVo, MultipartHttpServletRequest multi) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 사진 수정 :" + reliabilityResultVo);
			
			// 이미지 값
			MultipartFile mFile = multi.getFile("trustPhoto");

			String fileName = mFile.getOriginalFilename(); // 원본 파일 명
			logger.info("fileName : " + fileName);
			String fileFormat = fileName.substring(fileName.lastIndexOf(".")+1);
			logger.info("확장자 : "+fileFormat);
			
			//파일 검사
			if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
//				String date 	= DateUtil.getToday("yyyyMMdd").substring(2,8);
//				String seq 		= reliabilityResultService.getTrustPhotoSeq(date);
				String trustPhotoSeq = multi.getParameter("trustPhotoSeq").toString();
				
				double fileSizeMb = (mFile.getSize() / 1024.0)/1024.0;;	//(MB)파일 사이즈
				double fileSizeKb = mFile.getSize() / 1024.0;			//(KB)파일 사이즈
				
				UUID uuidTemp = UUID.randomUUID();
				String fileUuId = uuidTemp.toString();	//Key 값
				
				if (mFile == null || mFile.isEmpty()) {

				} else {
					reliabilityResultVo.setTrustPhotoSeq(trustPhotoSeq);
//					reliabilityResultVo.setImageFile(mFile.getBytes());
					reliabilityResultVo.setImageFileNm(fileName);
					reliabilityResultVo.setImageChangeFileNm(fileUuId + "." +fileName.substring(fileName.lastIndexOf(".")+1));
					logger.info("파일 사이즈 값 확인 --> "+mFile.getSize());
					
					if(mFile.getSize() > 1048576) {
						//파일 사이즈가 1MB 이상일 때
						int mbCheck = Double.toString(fileSizeMb).indexOf(".");
						if(mbCheck == 1) {
							logger.info("값 확인 ---> "+fileSizeMb);
							reliabilityResultVo.setImageFileSize(Math.floor(fileSizeMb*100)/100.0 +"MB");
						}else if(mbCheck == 2) {
							reliabilityResultVo.setImageFileSize(Math.floor(fileSizeMb*10)/10.0 +"MB");
						}else {
							logger.info("sudelSudel ---> "+(int) Math.floor(fileSizeMb));
							reliabilityResultVo.setImageFileSize((int) Math.floor(fileSizeMb)+"MB");	
						}
					}else {
						//파일 사이즈가 1MB 이하일 때
						int kbCheck = Double.toString(fileSizeKb).indexOf(".");
						if(kbCheck == 1) {
							reliabilityResultVo.setImageFileSize(Math.floor(fileSizeKb*100)/100.0 +"KB");
						}else if(kbCheck == 2) {
							reliabilityResultVo.setImageFileSize(Math.floor(fileSizeKb*10)/10.0 +"KB");
						}else {
							logger.info("sudelSudel ---> "+(int) Math.floor(fileSizeKb));
							reliabilityResultVo.setImageFileSize((int) Math.floor(fileSizeKb)+"KB");	
						}
					}
				}
				
				uploadFile(multi, reliabilityResultVo, fileUuId);	//이미지 업로드
				
				reliabilityResultService.reliabilityPhotoUpdate(reliabilityResultVo);
				jsonData.put("result", "ok");
			} else {
		    	jsonData.put("result", "extensionError");
		    	jsonData.put("message", "이미지파일을 선택해 주세요.");
		    }
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 파일 업로드
	public void uploadFile(MultipartHttpServletRequest multi, ReliabilityResultVo reliabilityResultVo, String fileUuId) throws Exception {
		try {
			String lotNo = multi.getParameter("lotNo").toString();
			String trustGubun = multi.getParameter("trustGubun").toString();
			
			String newFileName = "";
			String path = reliability_result_Path+ "/" + lotNo + "/" + trustGubun;
			
			logger.info("path : "+path);
			
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			for(int i=1; i<=1; i++) {
				MultipartFile mFile = multi.getFile("trustPhoto");
				logger.info(mFile.getName());
				logger.info("파일 비어있니?"+mFile.isEmpty());
				if(mFile.isEmpty()) {
				
					switch (i) {
					case 1:
						reliabilityResultVo.setImageFileNm("");
						break;
					}
					
				}else {
					String fileName = mFile.getOriginalFilename();
					
					newFileName = fileUuId+"." +fileName.substring(fileName.lastIndexOf(".")+1);
					
					switch (i) {
					case 1:
						reliabilityResultVo.setImageFileNm(fileName);
						break;
					}
					
					try {
						mFile.transferTo(new File(path + "/" + newFileName));	//실제 파일을 저장하는 부분
						
//						ZipOutputStream outputStream = null;
//						FileInputStream fileInputStream = null;
//						
//						fileInputStream = new FileInputStream(mFile.getName());
//		                outputStream.putNextEntry(new ZipEntry(mFile.getName()));
//			                
//		                outputStream.closeEntry();
//		                outputStream.close();
//		                fileInputStream.close();
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//신뢰성 결과 파일 다운로드
	@RequestMapping(value = "qm/downloadFile", method = RequestMethod.GET)
	public @ResponseBody void downloadFile(HttpServletResponse res, HttpServletRequest req,
		    @RequestParam(value = "lotNo") String lotNo,
		    @RequestParam(value = "trustGubun") String trustGubun,
		    @RequestParam(value = "trustPhotoSeq") String trustPhotoSeq,
		    @RequestParam(value = "imageFileNm") String imageFileNm,
		    @RequestParam(value = "imageChangeFileNm") String imageChangeFileNm,
		    ReliabilityResultVo reliabilityResultVo) throws Exception {
		try {

			String dFile="";
			
			dFile = imageFileNm;

			String newFileName = imageChangeFileNm;

			String path = reliability_result_Path +"/"+ lotNo + "/" + trustGubun + "/" + newFileName;

			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
				dFile = new String(dFile.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + dFile + "\";");

			FileInputStream fis 		= new FileInputStream(file);
			BufferedInputStream bis		= new BufferedInputStream(fis);
			ServletOutputStream so		= res.getOutputStream();
			BufferedOutputStream bos	= new BufferedOutputStream(so);

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
	
	//신뢰성 결과 사진 삭제
	@RequestMapping(value = "qm/reliabilityPhotoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityPhotoDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 사진 삭제(수정)");
			
			ReliabilityResultVo reliabilityPhotoRead = reliabilityResultService.reliabilityPhotoRead(reliabilityResultVo);
			logger.info("사진 고유 키 이름 : "+reliabilityPhotoRead.getImageChangeFileNm().toString());
			
			String path = reliability_result_Path
							+ "/" + reliabilityPhotoRead.getLotNo().toString() 
							+ "/" + reliabilityPhotoRead.getTrustGubun().toString()
							+ "/" + reliabilityPhotoRead.getImageChangeFileNm().toString();
			logger.info("경로는 : "+path);
			
			File dir = new File(path);
			dir.delete();
			
			reliabilityResultVo.setImageFileNm(null);
			reliabilityResultVo.setImageChangeFileNm(null);
			reliabilityResultVo.setImageFile(null);
			reliabilityResultVo.setImageFileSize(null);
			
			reliabilityResultService.reliabilityPhotoUpdate(reliabilityResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 공백 사진 삭제
	@RequestMapping(value = "qm/reliabilityBlankPhotoDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityBlankPhotoDelete(ReliabilityResultVo reliabilityResultVo, String array[]) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 사진 삭제");
			
			for(int i=0; i<array.length; i++) {
				logger.info(array[i]);
				logger.info("array 안에 들어가는 값은? > "+array[i]);
				reliabilityResultVo.setTrustPhotoSeq(array[i]);
				reliabilityResultService.reliabilityPhotoDelete(reliabilityResultVo);
			}
			
			reliabilityResultService.trustPhotoSeqUpdate(reliabilityResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//신뢰성 결과 전체 사진 삭제
	@RequestMapping(value = "qm/reliabilityPhotoAllDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityPhotoAllDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("신뢰성 결과 사진 전체 삭제");
			
			String path = reliability_result_Path
							+ "/" + reliabilityResultVo.getLotNo().toString() 
							+ "/" + reliabilityResultVo.getTrustGubun().toString();
			logger.info("경로는 : "+path);
			
			File dir = new File(path);	//경로를 담아준다.
			File[] deleteFolderList = dir.listFiles();	//하위 파일들에 값을 담아준다.
			
			if(deleteFolderList != null) {
				for (int j = 0; j < deleteFolderList.length; j++) {
					System.out.println(deleteFolderList[j]);
					deleteFolderList[j].delete();	//하위 파일 for문 돌리면서 전체
				}
				dir.delete(); //상위 폴더 삭제
			}
			
			reliabilityResultService.reliabilityPhotoDelete(reliabilityResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
}