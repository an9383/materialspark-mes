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
import org.springframework.web.bind.annotation.RequestBody;
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
import mes.domain.qm.ReliabilityLeakageResultVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.FileUploadService;
import mes.service.qm.ReliabilityLeakageResultService;
import mes.web.io.CustomerExcelReader;
import mes.web.po.AgtPaperController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ReliabilityLeakageResultController {

	@Value("${file.reliabilityLeakageResult}")
	private String reliability_leakageDstry_result_Path;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private ReliabilityLeakageResultService reliabilityLeakageResultService;
	@Inject
	private FileUploadService fileUploadService;
	
	@Value("${factoryCode}") private String facotryCode;
	@Value("${reliabilityCheckUploadDir}") private String reliabilityCheckUploadDir;
	
	private static final Logger logger = LoggerFactory.getLogger(ReliabilityLeakageResultController.class);
	
	
	
	//Leakage 결과
	@RequestMapping(value = "/qmsc3280", method = RequestMethod.GET)
	public String qmsc3280(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / Leakage Test 결과");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//주야간 구분
		systemCommonCodeVo.setBaseGroupCd("028");
		List<SystemCommonCodeVo> dayNGubun = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dayNGubun", dayNGubun);
		
		return "qm/qmsc3280";
	}
	
	//파괴 결과
	@RequestMapping(value = "/qmsc3290", method = RequestMethod.GET)
	public String qmsc3290(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 파괴 결과");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		//주야간 구분
		systemCommonCodeVo.setBaseGroupCd("028");
		List<SystemCommonCodeVo> dayNGubun = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("dayNGubun", dayNGubun);
		
		return "qm/qmsc3290";
	}

	//Leakage Dstry 결과 목록
	@RequestMapping(value = "qm/reliabilityLeakageResultList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//			logger.info("Leakage Test 결과 전체 목록조회");
			List<ReliabilityLeakageResultVo> reliabilityLeakageResultList = reliabilityLeakageResultService.reliabilityLeakageResultList(reliabilityLeakageResultVo);
		
//			logger.info("Leakage Test 결과 전체 목록조회" +reliabilityLeakageResultList);

			jsonData.put("data", reliabilityLeakageResultList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//Leakage Dstry 등록 목록
	@RequestMapping(value = "qm/reliabilityLeakageResultCreateList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultCreateList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//			logger.info("Leakage Test 등록 목록"+reliabilityLeakageResultVo);
			List<ReliabilityLeakageResultVo> reliabilityLeakageResultList = reliabilityLeakageResultService.reliabilityLeakageResultCreateList(reliabilityLeakageResultVo);
		
//			logger.info("Leakage Test 등록 목록" +reliabilityLeakageResultList);

			jsonData.put("data", reliabilityLeakageResultList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//Leakage Dstry 목록 상세
	@RequestMapping(value = "qm/reliabilityLeakageResultReadList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultSelectList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//			logger.info("Leakage Test 목록 상세");
			List<ReliabilityLeakageResultVo> reliabilityLeakageResultReadList = reliabilityLeakageResultService.reliabilityLeakageResultReadList(reliabilityLeakageResultVo);
		
//			logger.info("Leakage Test 목록 상세" +reliabilityLeakageResultReadList);

			jsonData.put("data", reliabilityLeakageResultReadList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//Leakage Test 결과등록
	@RequestMapping(value = "qm/reliabilityLeakageResultCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultCreate(@RequestBody List<Map<String, Object>> leakageTestList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		ReliabilityLeakageResultVo reliabilityLeakageResultVo = new ReliabilityLeakageResultVo();
//		logger.info("Leakage Test 결과등록 ");
		try {	
			String testDate = leakageTestList.get(0).get("testDate").toString();
			String leakDstryGubun = leakageTestList.get(0).get("leakDstryGubun").toString();
			int seq = 0;
			int regSeq = 0;
			if(leakDstryGubun.equals("001")) {
				seq = reliabilityLeakageResultService.reliabilityLeakageResultSeq(testDate);
			}else if(leakDstryGubun.equals("002")) {
				seq = reliabilityLeakageResultService.reliabilityDstryResultSeq(testDate);
			}
			regSeq = reliabilityLeakageResultService.regSeq(leakDstryGubun);
			
			String ddate = DateUtil.getToday("YYYY-MM-dd HH:mm");
//				String testSeq = testDate + '_' + seq;			
//				reliabilityLeakageResultVo.setLeakageTestSeq(testSeq);
			for(Map<String, Object> m : leakageTestList) {
				reliabilityLeakageResultVo = new ReliabilityLeakageResultVo();
				reliabilityLeakageResultVo.setRegSeq(regSeq);
				reliabilityLeakageResultVo.setRegId(Utils.getUserId());
				reliabilityLeakageResultVo.setRegDate(ddate);
				reliabilityLeakageResultVo.setTestDate(testDate);
				reliabilityLeakageResultVo.setTestSeq(seq);
				reliabilityLeakageResultVo.setEquipNm(m.get("equipNm").toString());
				reliabilityLeakageResultVo.setGubunDay(m.get("gubunDay").toString());
				reliabilityLeakageResultVo.setDay_0_1(m.get("day_0_1").toString());
				reliabilityLeakageResultVo.setGubunNight(m.get("gubunNight").toString());
				reliabilityLeakageResultVo.setNight_0_1(m.get("night_0_1").toString());
				reliabilityLeakageResultVo.setLeakDstryGubun(m.get("leakDstryGubun").toString());
				
				reliabilityLeakageResultService.reliabilityLeakageResultCreate(reliabilityLeakageResultVo);
			}
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry 수정
	@RequestMapping(value = "qm/reliabilityLeakageResultUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultUpdate(@RequestBody List<Map<String, Object>> leakageTestUpdateList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		ReliabilityLeakageResultVo reliabilityLeakageResultVo = new ReliabilityLeakageResultVo();
//		logger.info("Leakage Test 수정 ");
		try {
			
			String testDate = leakageTestUpdateList.get(0).get("testDate").toString();
			String seq = "";
			for(Map<String, Object> m : leakageTestUpdateList) {
				reliabilityLeakageResultVo = new ReliabilityLeakageResultVo();
				reliabilityLeakageResultVo.setTestDate(testDate);
				seq = m.get("testSeq").toString();
				reliabilityLeakageResultVo.setTestSeq(Integer.parseInt(seq));
				reliabilityLeakageResultVo.setEquipNm(m.get("equipNm").toString());
				reliabilityLeakageResultVo.setGubunDay(m.get("gubunDay").toString());
				reliabilityLeakageResultVo.setDay_0_1(m.get("day_0_1").toString());
				reliabilityLeakageResultVo.setGubunNight(m.get("gubunNight").toString());
				reliabilityLeakageResultVo.setNight_0_1(m.get("night_0_1").toString());
				reliabilityLeakageResultVo.setLeakDstryGubun(m.get("leakDstryGubun").toString());
				reliabilityLeakageResultVo.setRegDate(m.get("regDate").toString());
				
				reliabilityLeakageResultVo.setUpdId(Utils.getUserId());
				
				reliabilityLeakageResultService.reliabilityLeakageResultUpdate(reliabilityLeakageResultVo);
			}
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry 삭제
	@RequestMapping(value = "qm/reliabilityLeakageResultDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//				logger.info("Leakage Dstry 삭제");
			String dtlFileNo = reliabilityLeakageResultVo.getLeakDstryFileNo();
			
			String path = reliability_leakageDstry_result_Path + dtlFileNo;
			
			File folder = new File(path);
			
			while(folder.exists()) {
				File[] folder_list = folder.listFiles(); //파일리스트 얻어오기
						
				for (int j = 0; j < folder_list.length; j++) {
					folder_list[j].delete(); //파일 삭제 
							
				}
						
				if(folder_list.length == 0 && folder.isDirectory()){ 
					folder.delete(); //대상폴더 삭제
				}
		    }

			String admRegDate = reliabilityLeakageResultVo.getRegDate();
			reliabilityLeakageResultVo.setAdmRegDate(admRegDate);
			
			reliabilityLeakageResultService.reliabilityLeakageDtlResultDelete(reliabilityLeakageResultVo);
			
			reliabilityLeakageResultService.reliabilityLeakageResultDelete(reliabilityLeakageResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry File Dtl 목록조회
	@RequestMapping(value = "qm/reliabilityLeakageResultDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reliabilityLeakageResultDtlList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//						logger.info("목록조회: "+reportUploadVo);
		try {
//							System.out.print("리스트 확인용	:	"+reportUploadVo);
			List<ReliabilityLeakageResultVo> reportUploadDtlList = reliabilityLeakageResultService.reliabilityLeakageResultDtlList(reliabilityLeakageResultVo);
			jsonData.put("data", reportUploadDtlList);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//Leakage Dstry File Dtl 사진 수정
	@RequestMapping(value = "qm/reliabilityLeakageDstryPhotoCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageDstryPhotoCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo, MultipartHttpServletRequest multi) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//			logger.info("Leakage Dstry File Dtl 사진 수정 :" + reliabilityLeakageResultVo);
			
			String tDate = reliabilityLeakageResultVo.getTestDate();
			int tSeq = reliabilityLeakageResultVo.getTestSeq();
			String leakDstryGubun = reliabilityLeakageResultVo.getLeakDstryGubun().toString();
			String admRegDate = reliabilityLeakageResultVo.getRegDate();
			String leakDstryFileNo = tDate + '_' + leakDstryGubun + '_' + tSeq;
			
			reliabilityLeakageResultVo.setLeakDstryFileNo(leakDstryFileNo);
			reliabilityLeakageResultVo.setAdmRegDate(admRegDate);

			String filePath = reliability_leakageDstry_result_Path + leakDstryFileNo;
			String changeName = "";
			
			// 이미지 값
			List<MultipartFile> mFile = multi.getFiles("testPhoto");
			
			for(int i=0; i<mFile.size(); i++) {
				String fileName = mFile.get(i).getOriginalFilename(); // 원본 파일 명
//				logger.info("fileName : " + fileName);
				String fileFormat = fileName.substring(fileName.lastIndexOf(".")+1);
//				logger.info("확장자 : "+fileFormat);
				
				//파일 검사
				if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
//					String date 	= DateUtil.getToday("yyyyMMdd").substring(2,8);
//					String seq 		= reliabilityLeakageResultService.getTrustPhotoSeq(date);
					
//					double fileSizeMb = (mFile.getSize() / 1024.0)/1024.0;;	//(MB)파일 사이즈
//					double fileSizeKb = mFile.getSize() / 1024.0;			//(KB)파일 사이즈
//					
//					UUID uuidTemp = UUID.randomUUID();
//					String fileUuId = uuidTemp.toString();	//Key 값
					
					if (mFile.get(i) == null || mFile.get(i).isEmpty()) {

					} else {
						int fileSeq = reliabilityLeakageResultService.reliabilityLeakageDtlResultSeq(reliabilityLeakageResultVo);
						String fSeq = Integer.toString(fileSeq);
						reliabilityLeakageResultVo.setLeakDstryFileNo(leakDstryFileNo);
						reliabilityLeakageResultVo.setAdmRegDate(admRegDate);
						reliabilityLeakageResultVo.setFileSeq(fSeq);
						reliabilityLeakageResultVo.setFileOriginName(fileName);
						reliabilityLeakageResultVo.setFilePath(filePath);
						
						changeName = leakDstryFileNo + "_" + fSeq + '.' + fileName.substring(fileName.lastIndexOf(".")+1) ;
						reliabilityLeakageResultVo.setFileName(changeName);
					}
					
					uploadFile(mFile.get(i), reliabilityLeakageResultVo, changeName);	//이미지 업로드
					
					reliabilityLeakageResultService.reliabilityPhotoCreate(reliabilityLeakageResultVo);
					jsonData.put("result", "ok");
				} else {
			    	jsonData.put("result", "extensionError");
			    	jsonData.put("message", "이미지파일을 선택해 주세요.");
			    }
				
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry File Dtl 파일 업로드
	public void uploadFile(MultipartFile mFile, ReliabilityLeakageResultVo reliabilityLeakageResultVo, String changeName) throws Exception {
		try {
			String tDate = reliabilityLeakageResultVo.getTestDate();
			int tSeq = reliabilityLeakageResultVo.getTestSeq();
			String leakDstryFileNo = tDate + '_' + reliabilityLeakageResultVo.getLeakDstryGubun().toString() + '_' + tSeq ;

			String newFileName = "";
			String path = reliability_leakageDstry_result_Path + leakDstryFileNo;
			
			logger.info("path : "+path);
			
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			String fileName = mFile.getOriginalFilename();
			
			String fSeq = reliabilityLeakageResultVo.getFileSeq();
			
			newFileName = leakDstryFileNo + "_" + fSeq + "." +fileName.substring(fileName.lastIndexOf(".")+1);
			
			if(mFile == null || mFile.isEmpty()) {
				reliabilityLeakageResultVo.setFileName(newFileName);
			} else {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//Leakage Dstry File Dtl 다운로드
	@RequestMapping(value = "qm/downloadDtlFile", method = RequestMethod.GET)
	public @ResponseBody void downloadFile(HttpServletResponse res, HttpServletRequest req,
		    @RequestParam(value = "testDate") String testDate,
		    @RequestParam(value = "testSeq") String testSeq,
		    @RequestParam(value = "fileSeq") String fileSeq,
		    @RequestParam(value = "leakDstryGubun") String leakDstryGubun,
		    @RequestParam(value = "fileOriginName") String fileOriginName,
		    ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		try {

			String dFile="";
			
			dFile = testDate + '_' + leakDstryGubun + '_' + testSeq;

			String newFileName = dFile + '_' + fileSeq + '.' + fileOriginName.substring(fileOriginName.lastIndexOf(".")+1);;

			String path = reliability_leakageDstry_result_Path + dFile + "/" + newFileName;

			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				fileOriginName = URLEncoder.encode(fileOriginName, "UTF-8").replaceAll("\\+", "%20");
			} else {
				fileOriginName = new String(fileOriginName.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + fileOriginName + "\";");

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
	
	//Leakage Dstry Dtl 비고 수정
	@RequestMapping(value = "qm/reliabilityLeakageDtlResultUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageDtlResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("Leakage Test 수정 ");
		try {
			reliabilityLeakageResultService.reliabilityLeakageDtlResultUpdate(reliabilityLeakageResultVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry Dtl 삭제
	@RequestMapping(value = "qm/reliabilityLeakageDtlResultDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reliabilityLeakageDtlResultDelete(@RequestBody List<Map<String, Object>>  dtlDelList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
//			logger.info("Leakage Dstry Dtl 삭제");
			
			for(Map<String, Object> m : dtlDelList) {
			String dtlFileName = m.get("fileName").toString();
			String dtlFileNo = m.get("leakDstryFileNo").toString();
			String admRegDate = m.get("admRegDate").toString();
			String fileSeq = m.get("fileSeq").toString();
			
			String path = reliability_leakageDstry_result_Path + dtlFileNo + '/' + dtlFileName;
			
			File dir = new File(path);
			dir.delete();
			
			ReliabilityLeakageResultVo reliabilityLeakageResultVo = new ReliabilityLeakageResultVo();
			reliabilityLeakageResultVo.setLeakDstryFileNo(dtlFileNo);
			reliabilityLeakageResultVo.setAdmRegDate(admRegDate);
			reliabilityLeakageResultVo.setFileSeq(fileSeq);
			reliabilityLeakageResultService.reliabilityLeakageDtlResultDelete(reliabilityLeakageResultVo);
			}
			
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
}