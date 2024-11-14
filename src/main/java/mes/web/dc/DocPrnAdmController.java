package mes.web.dc;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.dc.DocPrnAdmVo;
import mes.service.dc.DocPrnAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class DocPrnAdmController {
	
	@Inject
	private DocPrnAdmService docPrnAdmService;
	
	//문서관리 파일 업로드_경로 지정
	@Value("${file.docPrnAdmPath}")
	private String docPrnAdmPath;
	
	private static final Logger logger = LoggerFactory.getLogger(DocPrnAdmController.class);
	
	// 프린터 문서
	@RequestMapping(value="dcsc0020")
	public String dcsc0020Main(Model model) throws Exception{
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
			model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "dc/dcsc0020";
	}
	
	
	//문서관리 목록조회
	@RequestMapping(value = "dc/docPrnAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> partReqList(DocPrnAdmVo docPrnAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("문서관리 목록조회 : "+docPrnAdmVo);
			List<DocPrnAdmVo> docPrnAdmList = docPrnAdmService.docPrnAdmList_F1F2F3(docPrnAdmVo);
			jsonData.put("data", docPrnAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//문서관리 날짜  조회
	@RequestMapping(value = "dc/docPrnAdmDateList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> docPrnAdmDateList(DocPrnAdmVo docPrnAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("문서관리 날짜 목록조회 : "+docPrnAdmVo);
			List<DocPrnAdmVo> docPrnAdmList = docPrnAdmService.docPrnAdmDateList_F1F2F3(docPrnAdmVo);
			jsonData.put("data", docPrnAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//문서관리 등록
	@RequestMapping(value="dc/docPrnAdmCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> docPrnAdmCreate(MultipartHttpServletRequest multi, DocPrnAdmVo docPrnAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("문서관리 등록 :"+docPrnAdmVo);
		try {
			
			String newFileName	= "";
//			String mngtCode 	= docPrnAdmVo.getMngtCode();
			String fileRegDate	= docPrnAdmVo.getFileRegDate();
			String fileYear		= fileRegDate.substring(0,4);
			String fileMonth	= fileRegDate.substring(4,6);
			String path 		= docPrnAdmPath + "/" + fileYear + "/" + fileMonth;
			
			int mngtCode = docPrnAdmService.docPrnAdmOnlyMaxCodeRead_F1F2F3(docPrnAdmVo);
			logger.info("macCodee ---> "+mngtCode);
			
			File dir = new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			MultipartFile mFile = multi.getFile("file");
			String fileName = mFile.getOriginalFilename();
			
			if(!(fileName == null||fileName =="")) {
				newFileName = fileMonth + "_"+ mngtCode + "." + fileName.substring(fileName.lastIndexOf(".")+1);
				docPrnAdmVo.setFileNm(fileName);
				
				try {
					mFile.transferTo(new File(path+"/"+newFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			docPrnAdmVo.setMngtCode(Integer.toString(mngtCode));
			docPrnAdmVo.setRegId(Utils.getUserId());
			docPrnAdmService.docPrnAdmCreate_F1F2F3(docPrnAdmVo);
			logger.info("등록 후 Vo : " +docPrnAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//문서관리 삭제
	@RequestMapping(value = "dc/docPrnAdmDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> docPrnAdmDelete(DocPrnAdmVo docPrnAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("문서관리 삭제");
			
			String fileRegDate	= docPrnAdmVo.getFileRegDate();
			String fileYear		= fileRegDate.substring(0,4);
			String fileMonth	= fileRegDate.substring(4,6);
			String fileNm 		= docPrnAdmVo.getFileNm();
			
			String newFileNm	= fileMonth + "_"+  docPrnAdmVo.getMngtCode() + "." +  fileNm.substring(fileNm.lastIndexOf(".")+1);
			String filePath		= docPrnAdmPath + "/" + fileYear + "/" + fileMonth + "/" + newFileNm;
			String folderPath	= docPrnAdmPath + "/" + fileYear + "/" + fileMonth;
			
			logger.info("경로는 : "+filePath);
			
			File dir = new File(filePath);
			File folderDir = new File(folderPath);
			
			dir.delete();
			
			String[] folderCount = folderDir.list();
			
			//폴더 값이 없을 경우 삭제
			if(folderCount.length == 0) {
				folderDir.delete();
			}
			
			docPrnAdmService.docPrnAdmDelete_F1F2F3(docPrnAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//파일 다운로드
	@RequestMapping(value="dc/docPrnAdmFileDownload", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> docPrnAdmFileDownload( HttpServletResponse res , HttpServletRequest req, DocPrnAdmVo docPrnAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String saveFile 	= docPrnAdmVo.getFileNm();
			String fileYear		= docPrnAdmVo.getFileRegDate().substring(0,4);
			String fileMonth	= docPrnAdmVo.getFileRegDate().substring(4,6);
			String newFile		= fileMonth + "_"+  docPrnAdmVo.getMngtCode() + "." +  saveFile.substring(saveFile.lastIndexOf(".")+1);
			String filePath		= docPrnAdmPath + "/" + fileYear + "/" + fileMonth + "/" + newFile;
			
			fileDownload(res, req, saveFile, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	
	
	 //파일 다운로드
	 public void fileDownload( HttpServletResponse res , HttpServletRequest req, String saveFile, String filePath) throws Exception{
		try {
			
			String dFile = saveFile;
			String path = filePath;
			logger.info(path);
			File file = new File(path);
		
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

}
