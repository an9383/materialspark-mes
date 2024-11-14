package mes.web.bm;

import java.io.File;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.AccidentFreeVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.qm.ReliabilityResultVo;
import mes.service.bm.AccidentFreeService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class AccidentFreeController {
	
	@Inject
	private AccidentFreeService accidentFreeService;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	
	private static final Logger logger = LoggerFactory.getLogger(AccidentFreeController.class);

	//무재해관리 메인
	@RequestMapping(value = "/bmsc0120", method = RequestMethod.GET)
	public String accidentFreeMain(Locale locale, Model model) throws Exception {
		
		logger.info("무재해관리 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("082"); // 게시여부
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("posted", systemCommonCodeList );		
		
		return "bm/bmsc0120";
	}
	
	//무재해관리 메인
		@RequestMapping(value = "/bmsc3120", method = RequestMethod.GET)
		public String accidentFreeMain3fac(Locale locale, Model model) throws Exception {
			
			logger.info("무재해관리 메인");
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate );
			
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			systemCommonCodeVo.setBaseGroupCd("082"); // 게시여부
			List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("posted", systemCommonCodeList );		
			
			return "bm/bmsc3120";
		}
	
	//무재해관리 목록조회
	@RequestMapping(value = "/bm/accidentFreeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> accidentFreeDataList(AccidentFreeVo accidentFreeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("무재해관리 목록조회");
		 try {		
			List<AccidentFreeVo> list = accidentFreeService.listAll(accidentFreeVo);
			jsonData.put("data", list);
		 } catch (Exception e) {
				logger.info("무재해관리 목록조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }			 
		 return jsonData;
	}
	
	//현수막 목록조회
	@RequestMapping(value = "/bm/accidentFreeImgDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> accidentFreeImgDataList(AccidentFreeVo accidentFreeVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("현수막 목록조회");
		 try {		
			List<AccidentFreeVo> list = accidentFreeService.listImg(accidentFreeVo);
			jsonData.put("data", list);
		 } catch (Exception e) {
				logger.info("현수막 목록조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }			 
		 return jsonData;
	}
	
	//무재해관리 상세 메인
	@RequestMapping(value = "/bm/accidentFreeRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> accidentFreeRead(AccidentFreeVo accidentFreeVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("무재해관리 상세 목록조회");
		 try {		
			 accidentFreeVo = accidentFreeService.read(accidentFreeVo);
			jsonData.put("data", accidentFreeVo);
		 } catch (Exception e) {
				logger.info("무재해관리 상세 목록조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }			 
		 return jsonData;
	}
	
	//무재해관리 등록
	@RequestMapping(value = "/bm/accidentFreeCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accidentFreeCreate(AccidentFreeVo accidentFreeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("무재해관리 등록");
		try {
			
			  String idx = accidentFreeService.selectIdx();
			  accidentFreeVo.setRegId(Utils.getUserId());
			  accidentFreeVo.setIdx(idx);
			  accidentFreeService.create(accidentFreeVo);
			 
			jsonData.put("result", "ok");
			jsonData.put("message", "등록 되었습니다.");
		}
		catch (Exception e) {
			logger.info("무재해관리 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//무재해관리 수정
	@RequestMapping(value = "/bm/accidentFreeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accidentFreeUpdate(AccidentFreeVo accidentFreeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("무재해관리 수정");
		try {
			accidentFreeVo.setUpdId(Utils.getUserId());
			accidentFreeService.update(accidentFreeVo);		
			jsonData.put("message", "수정 되었습니다.");
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("무재해관리 수정 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//현수막 이미지 업로드
	@RequestMapping(value = "/bm/accidentFreeImgUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> accidentFreeImgUpload(MultipartHttpServletRequest multi) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			AccidentFreeVo accidentFreeVo = new AccidentFreeVo();
			logger.info("현수막 이미지 업로드 :" + accidentFreeVo);
			
			// 이미지 값
			MultipartFile mFile = multi.getFile("img");
			
			String fileName = mFile.getOriginalFilename(); // 원본 파일 명
			logger.info("fileName : " + fileName);
			String fileFormat = fileName.substring(fileName.lastIndexOf(".")+1);
			logger.info("확장자 : "+fileFormat);
			
			//파일 검사
			if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
			
				
				if (mFile == null || mFile.isEmpty()) {

				} else {
					accidentFreeVo.setIdx(accidentFreeService.selectIdxImg());
					accidentFreeVo.setImg(mFile.getBytes());
					accidentFreeVo.setImgNm(fileName);
					accidentFreeVo.setRegId(Utils.getUserId().toString());
				}
				accidentFreeService.createImg(accidentFreeVo);
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
	
	
	


	
}
