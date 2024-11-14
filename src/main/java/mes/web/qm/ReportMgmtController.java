package mes.web.qm;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.DealCorpAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.qm.ReportMgmtVo;
import mes.service.bm.DealCorpAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.qm.ReportMgmtService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ReportMgmtController {
	
	@Value("${file.reportMgmtPath}")
	private String file_report_Mgmt_Path;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private ReportMgmtService reportMgmtService;
	@Inject
	private DealCorpAdmService dealCorpAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(ReportMgmtController.class);
	
	//품질관리 - 성적서관리
	@RequestMapping(value = "/qmsc0160", method = RequestMethod.GET)
	public String qmsc0140(Locale locale, Model model) throws Exception {
		logger.info("성적서관리");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();
		
		systemCommonCodeVo.setBaseGroupCd("007"); // 재질
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("019"); // 구분(연질/경질)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gubunCd", systemCommonCodeList );
		
		dealCorpAdmVo.setUseYnCd("001"); // 거래처정보관리
		List<DealCorpAdmVo> dealCorpAdmList= dealCorpAdmService.listAll(dealCorpAdmVo);
		model.addAttribute("dealCorpAdmList", dealCorpAdmList);
		
		return "qm/qmsc0160";
	}
	
	//성적서관리_Adm목로조회
	@RequestMapping(value = "qm/reportMgmtAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportMgmtAdmList(ReportMgmtVo reportMgmtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("성적서관리_Adm목로조회 : "+reportMgmtVo);
			List<ReportMgmtVo> reportMgmtAdmList = reportMgmtService.reportMgmtAdmList(reportMgmtVo);
			jsonData.put("data", reportMgmtAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//성적서관리_Adm 상세조회
	@RequestMapping(value = "qm/reportMgmtAdmRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportMgmtAdmRead(ReportMgmtVo reportMgmtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("성적서관리_Adm 상세조회 : "+reportMgmtVo);
			ReportMgmtVo reportMgmt = reportMgmtService.reportMgmtAdmRead(reportMgmtVo);
			jsonData.put("data", reportMgmt);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//성적서관리_Dtl목로조회
	@RequestMapping(value = "qm/reportMgmtDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportMgmtDtlList(ReportMgmtVo reportMgmtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("성적서관리_Dtl목로조회 : "+reportMgmtVo);
			List<ReportMgmtVo> reportMgmtAdmList = reportMgmtService.reportMgmtDtlList(reportMgmtVo);
			jsonData.put("data", reportMgmtAdmList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	/*//성적서관리 Adm, Dtl 등록
	@RequestMapping(value = "qm/reportMgmtCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reportMgmtCreate(ReportMgmtVo reportMgmtVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			logger.info("성적관리 등록 : "+ reportMgmtVo);
			
			JSONParser jsonParser		 	= new JSONParser();
			JSONObject jsonObj 				= new JSONObject();
			JSONArray jsonArray 			= (JSONArray) jsonParser.parse(reportMgmtVo.getArrayData());
			ReportMgmtVo reportMgmtDtlVo 	= new ReportMgmtVo();
			ReportMgmtVo reportMgmtAdmVo 	= new ReportMgmtVo();
			
			int idx = reportMgmtService.reportMgmtAdmIdx(DateUtil.getToday("yyyyMMdd").toString());
			
			logger.info("IDX값 확인 ---------------------------> "+idx);
			
			jsonObj.put(0, jsonArray.get(0));
			JSONObject jsonObjAdm = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
			
			reportMgmtAdmVo.setIdx			(Integer.toString(idx));
			reportMgmtAdmVo.setQutyCd		(jsonObjAdm.get("qutyCd").toString());
			reportMgmtAdmVo.setGubunCd		(jsonObjAdm.get("gubunCd").toString());
			reportMgmtAdmVo.setValidDate	(jsonObjAdm.get("validDate").toString());
			reportMgmtAdmVo.setTabGubunCd	(jsonObjAdm.get("tabGubunCd").toString());
			reportMgmtAdmVo.setRegId		(jsonObjAdm.get("regId").toString());
			
			logger.info("Adm 값 확인 -------->> "+reportMgmtAdmVo);
			
//			reportMgmtService.reportMgmtAdmCreate(reportMgmtAdmVo);
			
			for(int i=0;i<jsonArray.size();i++){
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				
				reportMgmtDtlVo.setIdx				(Integer.toString(idx));
				reportMgmtDtlVo.setDocumentSeq		(jsonObjDtl.get("documentSeq").toString());
				reportMgmtDtlVo.setDocumentTitle	(jsonObjDtl.get("documentTitle").toString());
				reportMgmtDtlVo.setDocumentContents	(jsonObjDtl.get("documentContents").toString());
				reportMgmtDtlVo.setTabGubunCd		(jsonObjDtl.get("tabGubunCd").toString());
				reportMgmtDtlVo.setRegId			(jsonObjDtl.get("regId").toString());
				
//				reportMgmtService.reportMgmtDtlCreate(reportMgmtDtlVo);
				logger.info("Dtl 값 확인 -------->> "+reportMgmtDtlVo);
			}
			
			jsonData.put("result", "ok");

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}*/
	
	//성적서관리 Adm, Dtl 등록
	@RequestMapping(value = "qm/reportMgmtCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reportMgmtCreate(ReportMgmtVo reportMgmtVo, MultipartHttpServletRequest multi) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String tabGubunCd = reportMgmtVo.getTabGubunCd();
			int idxValue = reportMgmtService.reportMgmtAdmIdx(tabGubunCd);
			
			String idx = tabGubunCd +'-'+ idxValue ;
			
			if("".equals(reportMgmtVo.getIdx()) || reportMgmtVo.getIdx() == null) {
				reportMgmtVo.setIdx(idx);
				reportMgmtVo.setRegId(Utils.getUserId());
				reportMgmtService.reportMgmtAdmCreate(reportMgmtVo);
				logger.info("성적서관리 Adm 등록 Vo 값 확인 : " +reportMgmtVo);
				uploadFile(reportMgmtVo, multi);
			}else if(!"".equals(reportMgmtVo.getIdx()) || reportMgmtVo.getIdx() != null) {
				reportMgmtVo.setUpdId(Utils.getUserId());
				reportMgmtService.reportMgmtAdmUpdate(reportMgmtVo);
				logger.info("성적서관리 Adm 수정 Vo 값 확인 : " +reportMgmtVo);
				uploadFile(reportMgmtVo, multi);
			}else {
				jsonData.put("result", "error");
				jsonData.put("message", Utils.getErrorMessage());
				return jsonData;
			}
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//성적서관리_Adm 파일 삭제
	@RequestMapping(value = "qm/reportMgmtAdmDelete", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportMgmtAdmDelete(ReportMgmtVo reportMgmtVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			reportMgmtService.reportMgmtAdmDelete(reportMgmtVo);
			logger.info("성적서관리_Adm 파일 삭제" + reportMgmtVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//성적서관리 파일 업로드
	public void uploadFile(ReportMgmtVo reportMgmtVo, MultipartHttpServletRequest multi) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			String newFileName = "";
			
			String tabGubunCd 	= reportMgmtVo.getTabGubunCd();
			String path 		= file_report_Mgmt_Path+tabGubunCd+'\\'+reportMgmtVo.getIdx();
			
			File dir = new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			int tableCount = Integer.parseInt(reportMgmtVo.getTableCount().toString());
			logger.info("tableCount : "+tableCount);
			
			for(int i=0; i<tableCount; i++) {
				MultipartFile mFile = multi.getFile("fileNm"+i);
				
				if(mFile == null) {
					logger.info("null이다.");
				}else if(mFile != null) {
					String fileName = mFile.getOriginalFilename();
					int seq 		= reportMgmtService.reportMgmtDtlSeq(reportMgmtVo.getIdx());
					
					try {
//						mFile.transferTo(new File(path + "\\" + newFileName));
						logger.info("SEQ 값 확인해줄게~~"+multi.getParameter("documentSeq_Rename"+i).toString());
						logger.info("fileName 값 확인 : "+fileName);
						
						if(multi.getParameter("documentSeq_Rename"+i).toString().equals("")) {
							
							if(!(fileName).equals("") || !"".equals(fileName) || fileName != "") {
								newFileName = tabGubunCd+"_"+ seq +"." +fileName.substring(fileName.lastIndexOf(".")+1);
								mFile.transferTo(new File(path + "\\" + newFileName));
								
								reportMgmtVo.setDocumentSeq(Integer.toString(seq));
								reportMgmtVo.setDocumentTitle(multi.getParameter("documentTitle"+i).toString()); //여기서 오류 나가지고 고쳐야함
								reportMgmtVo.setDocumentContents(fileName);
								reportMgmtVo.setRegId(Utils.getUserId());
								
								reportMgmtService.reportMgmtDtlCreate(reportMgmtVo);
								logger.info("성적서관리 Dtl 등록 Vo 값 확인 : " +reportMgmtVo);
							}
							
						}else if(!multi.getParameter("documentSeq_Rename"+i).toString().equals("")) {
							/*newFileName = tabGubunCd+"_"+ multi.getParameter("documentSeq_Rename"+i).toString() +"." +fileName.substring(fileName.lastIndexOf(".")+1);
							mFile.transferTo(new File(path + "\\" + newFileName));
							
							reportMgmtVo.setDocumentTitle(multi.getParameter("documentTitle"+i).toString()); //여기서 오류 나가지고 고쳐야함
							reportMgmtVo.setDocumentContents(fileName);	//path + "\\" + newFileName, fileFor fileNm
							
							reportMgmtService.reportMgmtDtlUpdate(reportMgmtVo);*/
							logger.info("성적서관리 Dtl 수정 Vo 값 확인 : " +reportMgmtVo);
						}else {
							jsonData.put("result", "error");
							jsonData.put("message", Utils.getErrorMessage());
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
			
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
			e.printStackTrace();
		}
	}
	
	 //파일 다운로드할 값 정리
	 @RequestMapping(value="qm/reportMgmtDtlDownloadFile", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> reportMgmtDtlDownloadFile(HttpServletResponse res , HttpServletRequest req,  ReportMgmtVo reportMgmtVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String saveFile 	= reportMgmtVo.getDocumentContents();
			String tabGubunCd 	= reportMgmtVo.getTabGubunCd();
			String newFile 		= tabGubunCd+"_"+ reportMgmtVo.getDocumentSeq() +"." +reportMgmtVo.getDocumentContents().substring(reportMgmtVo.getDocumentContents().lastIndexOf(".")+1);
			logger.info("newFile -----------> "+newFile);
			logger.info("newFile2222 -----------> "+reportMgmtVo.getDocumentContents().substring(reportMgmtVo.getDocumentContents().lastIndexOf(".")+1));
			String filePath 	= file_report_Mgmt_Path + tabGubunCd + "\\" +reportMgmtVo.getIdx() +'\\' + newFile;
			
			logger.info("filePath -----------> "+filePath);
			
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
	 
	//성적서관리_Dtl 파일 삭제
	@RequestMapping(value = "qm/reportMgmtDtlDlete", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportMgmtDtlDlete(ReportMgmtVo reportMgmtVo, HttpServletResponse res , HttpServletRequest req) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			logger.info("삭제 Vo 값 확인 "+reportMgmtVo);
			String tabGubunCd 	= reportMgmtVo.getTabGubunCd();
			String newFile 		= tabGubunCd+"_"+ reportMgmtVo.getDocumentSeq() +"." +reportMgmtVo.getDocumentContents().substring(reportMgmtVo.getDocumentContents().lastIndexOf(".")+1);
			
			String path 	= file_report_Mgmt_Path + tabGubunCd + "\\" +reportMgmtVo.getIdx() +'\\' + newFile;
			
			logger.info("경로는 : "+path);
			
			File dir = new File(path);
			dir.delete();
			
//			reportMgmtVo.setDocumentContents(null);
//			reportMgmtVo.setTabGubunCd(null);
	
			reportMgmtService.reportMgmtDtlDelete(reportMgmtVo);
			logger.info("성적서관리_Dtl 파일 삭제" + reportMgmtVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
}