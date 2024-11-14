package mes.web.em;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.em.AttachDataVo;
import mes.domain.bm.DealCorpAdmVo;
import mes.service.em.AttachDataService;
import mes.web.ut.Utils;


@Controller
public class AttachDataController {
	private static final Logger logger = LoggerFactory.getLogger(AttachDataController.class);
	
	@Value("${file.attachDataPath1}")
	private String filePath1;	
	
	@Value("${file.attachDataPath2}")
	private String filePath2;
	
	@Value("${file.attachDataPath3}")
	private String filePath3;
	
	@Value("${factoryCode}")
	private String factoryCode;
	
	@Inject
	private AttachDataService attachDataService;

	//관련 자료 전체 조회
	@RequestMapping(value = "em/attachDataAllList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> attachDataAllList(AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		attachDataVo.setRegId(Utils.getUserId());
		logger.info("관련 자료 전체 조회 = " + attachDataVo);
		try {
			List<AttachDataVo> attachDataList = attachDataService.attachDataAllList(attachDataVo);
			jsonData.put("data", attachDataList);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//관련 자료 조회
	@RequestMapping(value = "em/attachDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> equipAttachDataList(AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		attachDataVo.setRegId(Utils.getUserId());
//		logger.info("관련 자료 조회 = " + attachDataVo);
		try {
			List<AttachDataVo> attachDataList = attachDataService.attachDataList(attachDataVo);
			jsonData.put("data", attachDataList);
			jsonData.put("result", "ok");
		} catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//관련자료 Create
	@RequestMapping(value = "/em/attachDataCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipAttachDataCreate(AttachDataVo attachDataVo, MultipartHttpServletRequest multi, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("관련자료 등록 : " + attachDataVo);
		try {
			String attchPath = multi.getParameter("path").toString();
			String contents = multi.getParameter("contents");
			String attachSeq = multi.getParameter("attachSeq");
			String attachCd = multi.getParameter("attachCd");
			int seq = Integer.parseInt(attachSeq);
			String newFileName = "";
			String attachGubun = attachDataVo.getAttachGubun();
			String idCheck = attachDataVo.getIdCheck();
			String attachType = attachDataVo.getAttachType();
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + "/" + attachGubun + "/" + attachCd;
				break;
			case "002" :
				path = filePath2 + "/" + attachGubun + "/" + attachCd;
				break;
			case "003" :
				path = filePath3 + "/" + attachGubun + "/" + attachCd;
				break;
			}

			
			
			MultipartFile mFile = multi.getFile("fileNm");
			String fileName = mFile.getOriginalFilename(); //실제파일이름
			
			if(!(fileName == "" || fileName == null)) {
				File dir = new File(path);
				if(!dir.exists()) {
					dir.mkdirs();
				}
//				logger.info("실제 파일 이름 : " + fileName);
//				logger.info("실제 파일 이름 : " + attachType);
				attachDataVo.setEtc5(fileName.substring(fileName.lastIndexOf(".") + 1));
				
//				if(attachType!=null) {
//					newFileName = attachCd + "_" + seq + "_" + attachType + "." + fileName.substring(fileName.lastIndexOf(".") + 1);	
//				} else {
					newFileName = attachCd + "_" + seq + "." + fileName.substring(fileName.lastIndexOf(".") + 1);	
//				}
				
				
				mFile.transferTo(new File(path + "/" + newFileName));
				
				attachDataVo.setAttachFn(fileName);
//				logger.info("파일업로드 성공됨");
			}
			
			if(idCheck != null && idCheck.equals("BO")) {
				attachDataVo.setEtc1(multi.getParameter("etc1"));
				attachDataVo.setEtc2(multi.getParameter("etc2"));
			}
			if(idCheck.equals("EI") || idCheck.equals("ER") || idCheck.equals("DO")) {
				attachDataVo.setEtc1(multi.getParameter("etc1"));
			}
			if(attachGubun.equals("MS")) {
				attachDataVo.setAttachRegDate(multi.getParameter("attachRegDate"));
				attachDataVo.setEtc1(multi.getParameter("etc1"));
				attachDataVo.setEtc3(multi.getParameter("etc3"));
				attachDataVo.setEtc4(multi.getParameter("etc4"));
			}
			attachDataVo.setContents(contents);
			attachDataVo.setAttachPath(attchPath);
			attachDataVo.setRegId(Utils.getUserId());
			
			attachDataService.attachDataCreate(attachDataVo);
//			logger.info("서비스값 가져오기");
//			logger.info("등록후 vo:" + attachDataVo);
			jsonData.put("result", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", "시스템 오류가 발생했습니다.");
		}
		
		return jsonData;
	}
	
	//개발관리-첨부 승인
	@RequestMapping(value ="em/attachApproveUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> attachApproveUpdate(AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("개발관리-첨부 승인: " + attachDataVo);
		try {
			attachDataVo.setUpdId(Utils.getUserId());
			attachDataService.attachApproveUpdate(attachDataVo);
			jsonData.put("result", "ok" );
		}catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//관련 자료 Update
	@RequestMapping(value = "/em/attachDataUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> equipAttachDataUpdate(AttachDataVo attachDataVo, MultipartHttpServletRequest multi, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			MultipartFile mFile = multi.getFile("fileNm");
			String fileName = mFile.getOriginalFilename();   //실제파일이름
//			logger.info("실제 파일 이름 : " + fileName);
			if(fileName != null) {
				String attchPath = multi.getParameter("path").toString();
//				logger.info("YYYYMM : " + attchPath);
				String contents = multi.getParameter("contents");
				String attachSeq = multi.getParameter("attachSeq");
				String attachCd = multi.getParameter("attachCd");
				int seq = Integer.parseInt(attachSeq);
//				logger.info("seq : " + seq);
				String newFileName = "";
				String attachGubun = multi.getParameter("attachGubun");
				if(attachDataVo.getAttachGubun().toString().equals("MO")) {
					attachGubun = "MO";
				}
				if(attachDataVo.getAttachGubun().toString().equals("MI")) {
					attachGubun = "MI";
				}
				attachDataVo.setAttachGubun(attachGubun);
						
				String path = "";
				
				switch(factoryCode) {
				case "001" :
					path = filePath1 + "/" + attachGubun + "/" + attchPath;
					break;
				case "002" :
					path = filePath2 + "/" + attachGubun + "/" + attchPath;
					break;
				case "003" :
					path = filePath3 + "/" + attachGubun + "/" + attchPath;
					break;
				}
				
				File dir = new File(path);
				if(!dir.exists()) {
					dir.mkdirs();
				}
				
//				logger.info("실제 파일 이름 : " + fileName);
				newFileName = attachCd+"_"+seq + "." + fileName.substring(fileName.lastIndexOf(".") + 1);
				mFile.transferTo(new File(path + "/" + newFileName));
//				logger.info("파일업로드 성공됨");
				attachDataVo.setAttachFn(fileName);
				attachDataVo.setAttachPath(attchPath);
			}
			
			attachDataVo.setUpdId(Utils.getUserId());
//			logger.info("관련 자료 수정: " + attachDataVo);
			attachDataService.attachDataUpdate(attachDataVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
//	//관련 자료 Delete
//	@RequestMapping(value = "/em/attachDataDelete", method = RequestMethod.POST)
//	public @ResponseBody Map<String, Object> equipAttachDataDelete(AttachDataVo attachDataVo) throws Exception {
//		Map<String, Object> jsonData = new HashMap<>();
//		try {
//			logger.info("관련자료 삭제 : " + attachDataVo);
//			attachDataService.attachDataDelete(attachDataVo);
//			jsonData.put("result", "ok");
//		} catch (Exception e) {
//			e.printStackTrace();
//			jsonData.put("result", "error");
//			jsonData.put("message", Utils.getErrorMessage());
//		}
//		return jsonData;
//	}
//	
	//관련 자료 파일 Delete
	@RequestMapping(value = "/em/moldAttachFileDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> moldAttachFileDelete(
			@RequestParam(value = "attachCd") String attachCd,
		    @RequestParam(value = "attachSeq") String attachSeq,
		    @RequestParam(value = "attachType") String attachType,
		    @RequestParam(value = "attachPath") String attachPath,
		    @RequestParam(value = "attachFn") String attachFn,
		    AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			if(!(attachFn == "" || attachFn == null)) {

				String path = "";
				String ext = attachFn.substring(attachFn.indexOf(".")+1);
				String attachFileNm = attachCd + "_" + attachSeq + "." + ext;
				switch(factoryCode) {
				case "001" :
					path = filePath1 + "/" + attachDataVo.getAttachGubun() + "/"+ attachCd;
					break;
				case "002" :
					path = filePath2 + "/" + attachDataVo.getAttachGubun() + "/"+ attachCd;
					break;
				case "003" :
					path = filePath3 + "/" + attachDataVo.getAttachGubun() + "/"+ attachCd;
					break;
				}
				
//				logger.info("YYYYMM : "+path);
				
				File dir = new File(path + "/" + attachFileNm);
				if(dir.exists()) {
					dir.delete();
					
					File file = new File(path);
					
					if(file.exists()) {
						File[] folder = file.listFiles();
						if(folder.length == 0) {
							file.delete();
						}
					}
				}
				
				attachDataVo.setUpdId(Utils.getUserId());			
//				logger.info("관련자료 파일삭제 : " + attachDataVo);
				attachDataService.attachFileDelete(attachDataVo);
				attachDataService.attachDataDelete(attachDataVo);
				
			}
						
			attachDataVo.setUpdId(Utils.getUserId());			
//			logger.info("관련자료 파일삭제 : " + attachDataVo);
			attachDataService.attachFileDelete(attachDataVo);
			attachDataService.attachDataDelete(attachDataVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//관련 자료 파일 다운로드 (EQ)
	@RequestMapping(value = "/em/equipAttachDataDownload", method = RequestMethod.GET)
	public @ResponseBody void downloadFile(HttpServletResponse res, HttpServletRequest req,
			@RequestParam(value = "attachFn") String attachFn, @RequestParam(value = "attachSeq") String attachSeq,@RequestParam(value = "attachCd") String attachCd,
			@RequestParam(value = "attachGubun") String attachGubun,AttachDataVo attachDataVo) throws Exception {
		try {
			int seq = Integer.parseInt(attachSeq);
			attachDataVo.setAttachCd(attachCd);
			attachDataVo.setAttachGubun(attachGubun);
			
			String dFile = attachFn;
			String newFileName = seq + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + "/EQ/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "002" :
				path = filePath2 + "/EQ/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "003" :
				path = filePath3 + "/EQ/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			}
			
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
	
	//관련 자료 SEQ,NAME(attachSeq)
	@RequestMapping(value = "em/attachDataSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> attachDataSeq(AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			int attachSeq = attachDataService.attachDataSeq(attachDataVo);
			
			String regId = Utils.getUserNm();
			jsonData.put("name", regId);
			jsonData.put("seq", attachSeq);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//관련 자료 cd(attachCd)
	@RequestMapping(value = "em/attachDataCd", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> attachDataCd(AttachDataVo attachDataVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String attachCd = attachDataService.attachDataCd(attachDataVo);
			jsonData.put("attachCd", attachCd);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	// 관련 자료 파일 다운로드 (기본)
	@RequestMapping(value = "/em/attachDataDownload", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> downloadFile(HttpServletResponse res , HttpServletRequest req,AttachDataVo attachDataVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			int seq = Integer.parseInt(attachDataVo.getAttachSeq());

			String attachCd = attachDataVo.getAttachCd();
			String attachGubun = attachDataVo.getAttachGubun();
			
			String dFile = attachDataService.getAttachFileNm(attachDataVo);
			
			String newFileName = attachCd +"_"+seq + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
//			logger.info("newFileName:"+newFileName);

			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + '/' + attachGubun + '/' + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "002" :
				path = filePath2 + '/' + attachGubun + '/' + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "003" :
				path = filePath3 + '/' + attachGubun + '/' + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			}

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
		return jsonData;
	}
	
	
	// 관련 자료 파일 다운로드(MI)
	@RequestMapping(value = "/em/measureAttachDataDownload", method = RequestMethod.GET)
	public @ResponseBody void measureAttachDataDownload(HttpServletResponse res, HttpServletRequest req,
			@RequestParam(value = "attachFn") String attachFn, @RequestParam(value = "attachSeq") String attachSeq, @RequestParam(value = "attachCd") String attachCd,
			@RequestParam(value = "attachGubun") String attachGubun, @RequestParam(value = "attachType") String attachType, AttachDataVo attachDataVo) throws Exception {
		try {
			int seq = Integer.parseInt(attachSeq);
			attachDataVo.setAttachCd(attachCd);
			attachDataVo.setAttachGubun(attachGubun);
			attachDataVo.setAttachFn(URLDecoder.decode(attachFn,"UTF-8"));
			
			String dFile = attachDataService.getAttachFileNm(attachDataVo);
			
			String newFileName ="";
			if(attachType != null) {
				newFileName = attachCd +"_"+ seq +"_" + attachType + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
//				logger.info("index:"+dFile.lastIndexOf("."));
//				logger.info("pos:"+dFile.substring(dFile.lastIndexOf(".") + 1));
				                                                            
			} else {
				newFileName = attachCd +"_"+ seq + "." + dFile.substring(dFile.lastIndexOf(".") + 1);	
			}

			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + "/MI/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "002" :
				path = filePath2 + "/MI/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "003" :
				path = filePath3 + "/MI/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			}

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
	
	
	// 관련 자료 파일 다운로드 (MS)
	@RequestMapping(value = "/em/msAttachDataDownload", method = RequestMethod.GET)
	public @ResponseBody void msAttachDataDownload(HttpServletResponse res, HttpServletRequest req,
			@RequestParam(value = "attachFn") String attachFn, @RequestParam(value = "attachSeq") String attachSeq, @RequestParam(value = "attachCd") String attachCd,
			@RequestParam(value = "attachGubun") String attachGubun,AttachDataVo attachDataVo) throws Exception {
		try {
			int seq = Integer.parseInt(attachSeq);
			attachDataVo.setAttachCd(attachCd);
			attachDataVo.setAttachGubun("MS");

			String dFile = attachDataService.getAttachFileNm(attachDataVo);
			String newFileName = attachCd+"_"+seq + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + "/MS/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "002" :
				path = filePath2 + "/MS/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "003" :
				path = filePath3 + "/MS/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			}	

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
	
	// 관련 자료 파일 다운로드 (TA)
	@RequestMapping(value = "/em/taAttachDataDownload", method = RequestMethod.GET)
	public @ResponseBody void taAttachDataDownload(HttpServletResponse res, HttpServletRequest req,
			@RequestParam(value = "attachFn") String attachFn, @RequestParam(value = "attachSeq") String attachSeq, @RequestParam(value = "attachCd") String attachCd,
			AttachDataVo attachDataVo) throws Exception {
		try {
			int seq = Integer.parseInt(attachSeq);
			
			attachDataVo.setAttachCd(attachCd);
			attachDataVo.setAttachGubun("TA");

			String dFile = attachDataService.getAttachFileNm(attachDataVo);
			String newFileName = attachCd+ "_" + seq + "." + dFile.substring(dFile.lastIndexOf(".") + 1);
			String path = "";
			
			switch(factoryCode) {
			case "001" :
				path = filePath1 + "/TA/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "002" :
				path = filePath2 + "/TA/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			case "003" :
				path = filePath3 + "/TA/" + attachDataService.dtrFilePath(attachDataVo) + "/" + newFileName;
				break;
			}	

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
