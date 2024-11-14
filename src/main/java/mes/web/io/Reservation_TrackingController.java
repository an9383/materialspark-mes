package mes.web.io;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.ReservationVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.FileUploadService;
import mes.web.ut.DateUtil;

@Controller
public class Reservation_TrackingController {
	
	@Value("${file.reservationTrackingPath}")
	private String reservation_Tracking_Path;
	
	@Inject
	private FileUploadService fileUploadService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	@Value("${matrlUploadDir}") private String matrlUploadDir;
	
	@Value("${factoryCode}") private String facotryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	//제품출고추적
	@RequestMapping(value = "/iosc0150", method = RequestMethod.GET)
	public String iosc0070(Locale locale, Model model) throws Exception {
		logger.info("제품출고추적");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
		return "io/iosc0150";
	}
	
	//목록조회
	@RequestMapping(value = "/io/reservation_List", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reservation_List() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목록조회");
//		List<MatrlInWhsRqtVo> reservation_List = matrlInWhsRqtService.listAll(matrlInWhsRqtVo);
		List<ReservationVo> reservation_List = new ArrayList<ReservationVo>();
		jsonData.put("data", reservation_List);
		
		return jsonData;
	}

	//추가양식 다운로드
	 @RequestMapping(value="io/reservation_BasicForm", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> reservation_BasicForm(HttpServletResponse res , HttpServletRequest req) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			  String saveFile = "제품출고추적_기본양식.xlsx"; 
			  String filePath = reservation_Tracking_Path+"제품출고추적_기본양식.xlsx";
			  fileDownload(res, req, saveFile, filePath);
			logger.info("파일 다운");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
		 
	//파일 다운로드
	public void fileDownload( HttpServletResponse res , HttpServletRequest req, String saveFile, String filePath) throws Exception{
		try {
			String dFile 	= saveFile;
			String path 	= filePath;
			File file 		= new File(path);
		
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				logger.info("익스");
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
				logger.info("크롬");
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
	
	//엑셀파일 업로드하는 ajax
	@RequestMapping(value= "io/reservation_ExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reservation_ExcelUpload(Model model, @RequestParam("excelfile") MultipartFile file) {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			//폴더 값이 없을 경우 삭제
			/*if(folderCount.length == 0) {
				folderDir.delete();
			}*/
			
			String path = reservation_Tracking_Path + "temporaryFolder";
			String url = fileUploadService.restore(file, logger, path);
			logger.info(url);
			model.addAttribute("url", url);
			jsonData.put("data", url);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("matrlInOutExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}
		return jsonData;
	}
	
	//테이블 생성(excel읽기)_ajax
	@RequestMapping(value = "/io/reservation_DataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reservation_DataList(String filename) throws Exception {
		Map<String, Object> jsonData	= new HashMap<String, Object>();
		CustomerExcelReader excelReader	= new CustomerExcelReader();
		try {
			List<ReservationVo> reservation_Data = excelReader.reservation_fileload(filename, logger);
			logger.info("테이블 생성(excel읽기)_ajax");
			File file = new File(filename);
			logger.info(filename);
			
			if(reservation_Data.size() != 0) {
				jsonData.put("data", reservation_Data);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "값이 존재하지 않습니다.");
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
		} catch (Exception e) {
			logger.info("matrlInOutExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}
		
		return jsonData;
	}
	
	
	
	
	
	
	
	
}




