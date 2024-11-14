package mes.web.mm;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.mm.ItemPartAdmVo;
//import mes.domain.io.ItemUnitcostHisAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.mm.ItemPartAdmService;
import mes.web.io.CustomerExcelReader;
//import mes.service.io.ItemUnitcostHisAdmService;
//import mes.web.cm.CustomerExcelReader;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ItemPartAdmController {
	
	@Inject
	private ItemPartAdmService itemPartAdmService;
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
//	@Inject
//	private ItemUnitcostHisAdmService itemUnitcostHisAdmService;

	private static final Logger logger = LoggerFactory.getLogger(ItemPartAdmController.class);
	
	@Value("${file.inspectPath}")
	private String file_Inspect_Path;
	
	@Value("${file.itemAttachPath}")
	private String file_Item_Attach_Path;
	
	@Value("${file.itemPartBasicForm}")
	private String itemPartBasicForm;
	
	@Value("${file.itemPartExcelUpload}") 
	private String itemPartExcelUpload;

	@RequestMapping(value="mmsc0010")
	public String main(Model model) throws Exception{
		try {
			SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
			
			//부품단위 공통코드
			systemCommonCodeVo.setBaseGroupCd("072");
			List<SystemCommonCodeVo> partUnitList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("partUnit", partUnitList);
			
			//부품구분 공통코드
			systemCommonCodeVo.setBaseGroupCd("069");
			List<SystemCommonCodeVo> partGubunList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("partGubun", partGubunList);
			
			//부품타입 공통코드
			systemCommonCodeVo.setBaseGroupCd("070");
			List<SystemCommonCodeVo> partTypeList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("partType", partTypeList);
			
			//사용여부 공통코드
			systemCommonCodeVo.setBaseGroupCd("024");
			List<SystemCommonCodeVo> useYnList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("useYn", useYnList);
			
			//수입검사여부 공통코드
			systemCommonCodeVo.setBaseGroupCd("071");
			List<SystemCommonCodeVo> inspectYnList = systemCommonCodeService.listAll(systemCommonCodeVo);
			model.addAttribute("inspectYn", inspectYnList);
			
			model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
			
			String userNm = Utils.getUserNm();
			model.addAttribute("userNm", userNm );
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mm/mmsc0010";
	}
	
	//품목정보관리(부품) 목록조회
	@RequestMapping(value="mm/itemPartAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPartAdmList(ItemPartAdmVo itemPartAdmVo, HttpServletRequest request) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 목록 조회 : "+ itemPartAdmVo);
		try {
			
			/*String start = request.getParameter("start"); 
			String length = request.getParameter("length");
			String searchVal = request.getParameter("search[value]");	
			String ordDir = request.getParameter("order[0][dir]");
			String ordColumnIdx = request.getParameter("order[0][column]");
			String ordColumn = request.getParameter("columns["+ ordColumnIdx +"][data]");
			
			
			
			logger.info("start = "+ start + ",length = " +length + ",searchVal = " +searchVal + ",ordColumn = " +ordColumn + ",ordDir = " +ordDir);
			
			itemPartAdmVo.setSearchVal(searchVal);
			ordColumn =  Utils.convert2UnderscoreCase(ordColumn);
			itemPartAdmVo.setOrdDir(ordDir);
			itemPartAdmVo.setOrdColumn(ordColumn);*/
			
			
			List<ItemPartAdmVo> listAll = itemPartAdmService.itemPartAdmList(itemPartAdmVo);
			
			/*int totalCount = 0;
			if(listAll.size() > 0) {
				totalCount = listAll.get(0).getTotalCount();
			}
			jsonData.put("recordsTotal", totalCount);
			jsonData.put("recordsFiltered", totalCount);*/
			jsonData.put("data", listAll);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리(부품) 상세조회
	@RequestMapping(value="mm/itemPartDtlList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> itemPartDtlList(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 상세 조회 : "+itemPartAdmVo);
		try {
			ItemPartAdmVo dao = itemPartAdmService.itemPartDtlList(itemPartAdmVo);
			jsonData.put("data", dao);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	} 
	
	//부품수입검사기준서 조회
	@RequestMapping(value="mm/itemPartInspectList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> itemPartInspectList(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품수입검사기준서 조회 : "+itemPartAdmVo);
		try {
			List<ItemPartAdmVo> itemPartInspectList = itemPartAdmService.itemPartInspectList(itemPartAdmVo);
			jsonData.put("data", itemPartInspectList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	/*//부품수입검사기준서 상세조회
	@RequestMapping(value="mm/itemPartInspectRead" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> itemPartInspectRead(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품수입검사기준서 상세조회 : "+itemPartAdmVo);
		try {
			
			ItemPartAdmVo itemPartInspectRead = itemPartAdmService.itemPartInspectRead(itemPartAdmVo);
			jsonData.put("data", itemPartInspectRead);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	} */

	
	//부품관련자료 조회
	@RequestMapping(value="mm/itemPartAttachDataList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> itemPartAttachDataList(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품관련자료 조회 : "+itemPartAdmVo);
		try {
			List<ItemPartAdmVo> itemPartAttachDataList = itemPartAdmService.itemPartAttachDataList(itemPartAdmVo);
			jsonData.put("data", itemPartAttachDataList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	} 
		
	
	//품목정보관리(부품) 등록
	@RequestMapping(value="mm/itemPartAdmCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartAdmCreate(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 등록 :"+itemPartAdmVo);
		try {
			if(itemPartAdmService.overlapPartCd(itemPartAdmVo) == 0) {
				itemPartAdmVo.setRegId(Utils.getUserId());
				itemPartAdmService.itemPartAdmCreate(itemPartAdmVo);
				
				//자재이력관리 Create
				/*ItemUnitcostHisAdmVo vo = new ItemUnitcostHisAdmVo();
				vo.setPartCd(itemPartAdmVo.getPartCd());
				vo.setPartRev(itemPartAdmVo.getPartRev()); 
				vo.setUnitCost(itemPartAdmVo.getUnitCost());
				vo.setStartDate(DateUtil.getToday("yyyymmddhhmmss"));
				vo.setRegId(Utils.getUserId());
				int partSeq = itemUnitcostHisAdmService.getPartSeq(vo);
				vo.setPartSeq(partSeq);
				itemUnitcostHisAdmService.itemUnitcostHisAdmCreate(vo);*/
				
				jsonData.put("result", "ok");
			}else {
				jsonData.put("result", "exist");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//품목정보관리(부품) Revison 등록
	@RequestMapping(value="mm/itemPartRevCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartRevCreate(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 리비전 등록 :"+itemPartAdmVo);
		try {
			itemPartAdmVo.setRegId(Utils.getUserId());
			itemPartAdmService.itemPartAdmCreate(itemPartAdmVo);
			logger.info("등록 후 Vo:"+itemPartAdmVo);
			
			/*//자재이력관리 Create
			ItemUnitcostHisAdmVo vo = new ItemUnitcostHisAdmVo();
			vo.setPartCd(itemPartAdmVo.getPartCd());
			vo.setPartRev(itemPartAdmVo.getPartRev()); 
			vo.setUnitCost(itemPartAdmVo.getUnitCost());
			vo.setStartDate(DateUtil.getToday("yyyymmddhhmmss"));
			vo.setRegId(Utils.getUserId());
			
			int partSeq = itemUnitcostHisAdmService.getPartSeq(vo);
			vo.setPartSeq(partSeq);
			
			itemUnitcostHisAdmService.itemUnitcostHisAdmCreate(vo);*/
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//품목정보관리(부품) 엑셀등록
	@RequestMapping(value="mm/itemPartAdmExcelCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartAdmCreate(@RequestBody List<Map<String, Object>> itemPartAdmList) throws Exception{
		ItemPartAdmVo itemPartAdmVo = new ItemPartAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리(부품) 등록 :"+itemPartAdmVo);
		try {
			
			int count=0;
			String partCdList="";
			
			for(Map<String, Object> m :itemPartAdmList) {
				
				itemPartAdmVo.setPartCd(m.get("partCd").toString());
				itemPartAdmVo.setPartRev(m.get("partRev").toString());
				
				if(itemPartAdmService.overlapPartCd(itemPartAdmVo) > 0) {
					partCdList.concat("/"+itemPartAdmVo.getPartCd());
					partCdList = itemPartAdmVo.getPartCd();
					logger.info(partCdList);
					count++;
				}
			}
			logger.info("count : "+count);
			
			if(count==0) {
				logger.info("create query start");
				for(Map<String, Object> m :itemPartAdmList) {
					
					itemPartAdmVo.setPartCd(m.get("partCd").toString());
					itemPartAdmVo.setPartRev(m.get("partRev").toString());
					
					//중복체크함 
					if(itemPartAdmService.overlapPartCd(itemPartAdmVo) == 0) {
						itemPartAdmVo.setPartNm(m.get("partNm").toString());
						itemPartAdmVo.setPartGubun(m.get("partGubun").toString());
						itemPartAdmVo.setPartType(m.get("partType").toString());
						itemPartAdmVo.setPartSpec(m.get("partSpec").toString());
						itemPartAdmVo.setInCorpCd(m.get("inCorpCd").toString());
						itemPartAdmVo.setPartUnit(m.get("partUnit").toString());
						itemPartAdmVo.setBasicDlvDate(m.get("basicDlvDate").toString());
						itemPartAdmVo.setUnitCost(Integer.parseInt(m.get("unitCost").toString()));
						itemPartAdmVo.setSafetyStockQty(m.get("safetyStockQty").toString());
						itemPartAdmVo.setBarcodeYn(m.get("barcodeYn").toString());
						itemPartAdmVo.setUseYn(m.get("useYn").toString());
						itemPartAdmVo.setInspectYn(m.get("inspectYn").toString());
						itemPartAdmVo.setPartDesc(m.get("partDesc").toString());
						itemPartAdmVo.setRegId(Utils.getUserId());
						
						itemPartAdmService.itemPartAdmCreate(itemPartAdmVo);
						
						/*//자재이력관리 Create
						ItemUnitcostHisAdmVo vo = new ItemUnitcostHisAdmVo();
						vo.setPartCd(itemPartAdmVo.getPartCd());
						vo.setPartRev(itemPartAdmVo.getPartRev()); 
						vo.setUnitCost(itemPartAdmVo.getUnitCost());
						vo.setStartDate(DateUtil.getToday("yyyymmddhhmmss"));
						vo.setRegId(Utils.getUserId());
						
						int partSeq = itemUnitcostHisAdmService.getPartSeq(vo);
						vo.setPartSeq(partSeq);
						
						itemUnitcostHisAdmService.itemUnitcostHisAdmCreate(vo);*/
					}
					
					jsonData.put("result", "ok");
				}
			}else {
				jsonData.put("result", "exist");
				jsonData.put("partCd", partCdList);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//부품수입검사기준서 등록
	@RequestMapping(value="mm/itemPartInspectCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartInspectCreate(MultipartHttpServletRequest multi, ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품수입검사기준서 등록 :"+itemPartAdmVo);
		try {
			
			String newFileName="";
			String PartCd = itemPartAdmVo.getPartCd();
			String path = file_Inspect_Path+"/"+PartCd;
			
			File dir= new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			MultipartFile mFile = multi.getFile("file");
			String fileName=mFile.getOriginalFilename();
			int partSeq = itemPartAdmService.getInspectPartSeq(itemPartAdmVo);
			
			if(!(fileName == null||fileName =="")) {
				newFileName = PartCd+"_"+partSeq+"."+fileName.substring(fileName.lastIndexOf(".")+1);
				itemPartAdmVo.setFileNm(fileName);
				
				try {
					mFile.transferTo(new File(path+"/"+newFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			itemPartAdmVo.setRegId(Utils.getUserId());
			itemPartAdmVo.setPartSeq(partSeq);
			itemPartAdmService.itemPartInspectCreate(itemPartAdmVo);
			logger.info("등록 후 Vo:"+itemPartAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//부품관련자료 등록
	@RequestMapping(value="mm/itemPartAttachDataCreate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartAttachDataCreate(MultipartHttpServletRequest multi, ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품관련자료 등록 :"+itemPartAdmVo);
		try {
			
			String newFileName="";
			String partCd = itemPartAdmVo.getPartCd();
			String partRev = itemPartAdmVo.getPartRev();
			String path = file_Item_Attach_Path+"/"+partCd+"/"+partRev;
			
			File dir= new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			
			MultipartFile mFile = multi.getFile("file");
			String fileName=mFile.getOriginalFilename();
			int partSeq = itemPartAdmService.getAttachPartSeq(itemPartAdmVo);
			
			if(!(fileName == null||fileName =="")) {
				newFileName = partCd+"_"+partSeq+"."+fileName.substring(fileName.lastIndexOf(".")+1);
				itemPartAdmVo.setFileNm(fileName);
				
				try {
					mFile.transferTo(new File(path + "/" +newFileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			itemPartAdmVo.setRegId(Utils.getUserId());
			itemPartAdmVo.setPartSeq(partSeq);
			itemPartAdmService.itemPartAttachDataCreate(itemPartAdmVo);
			logger.info("등록 후 Vo:"+itemPartAdmVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//품목정보관리(부품) 수정
	@RequestMapping(value="mm/itemPartAdmUpdate", method = RequestMethod.POST)
	@ResponseBody Map<String, Object> itemPartAdmUpdate(ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("품목정보관리 수정 :"+itemPartAdmVo);
		try {
			itemPartAdmVo.setUpdId(Utils.getUserId());
			itemPartAdmService.itemPartAdmUpdate(itemPartAdmVo);
			logger.info("수정 후 Vo:"+itemPartAdmVo);
			
			/*ItemUnitcostHisAdmVo vo = new ItemUnitcostHisAdmVo();
			vo.setPartCd(itemPartAdmVo.getPartCd());
			vo.setPartRev(itemPartAdmVo.getPartRev()); 
			
			int lastUnitCost = itemUnitcostHisAdmService.getLastUnitCost(vo);
			logger.info(""+lastUnitCost);
			if(itemPartAdmVo.getUnitCost()!=lastUnitCost) {
				int partSeq = itemUnitcostHisAdmService.getPartSeq(vo);
				
				//이전 이력 종료일 Update
				vo.setPartSeq(partSeq-1);
				vo.setEndDate(DateUtil.getToday("yyyymmddhhmmss"));
				vo.setUpdId(Utils.getUserId());
				itemUnitcostHisAdmService.itemUnitcostHisAdmUpdate(vo);
				
				//자재이력관리 Create
				vo.setUnitCost(itemPartAdmVo.getUnitCost());
				vo.setStartDate(DateUtil.getToday("yyyymmddhhmmss"));
				vo.setRegId(Utils.getUserId());
				vo.setPartSeq(partSeq);
				
				itemUnitcostHisAdmService.itemUnitcostHisAdmCreate(vo);
			}*/
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

	//부품수입검사기준서 삭제
	@RequestMapping(value = "/mm/itemPartInspectDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPartAdmDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품수입검사기준서 삭제: "+itemPartAdmVo);
		try {
			itemPartAdmService.itemPartInspectDelete(itemPartAdmVo);
			jsonData.put("result", "ok");
		}catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	

	//부품수입검사기준서 삭제
	@RequestMapping(value = "/mm/itemPartAttachDataDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPartAttachDataDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품관련자료 삭제: "+itemPartAdmVo);
		try {
			itemPartAdmService.itemPartAttachDataDelete(itemPartAdmVo);
			jsonData.put("result", "ok");
		}catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	 //파일 다운로드
	 @RequestMapping(value="mm/itemPartInspectFileDownload", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> itemPartInspectDownloadFile(
			 HttpServletResponse res , HttpServletRequest req,
			 ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String saveFile = itemPartAdmService.getFileNm(itemPartAdmVo);
			String newFile = itemPartAdmVo.getPartCd() + "_" + itemPartAdmVo.getPartSeq() + "." + saveFile.substring(saveFile.lastIndexOf(".") + 1);
			String filePath = file_Inspect_Path + "/" + itemPartAdmVo.getPartCd() + "/" + newFile;
			
			fileDownload(res, req, saveFile, filePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	  }
	 
	
	 //파일 다운로드
	 @RequestMapping(value="mm/itemPartAttachFileDownload", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> itemPartAttachDownloadFile(
			 HttpServletResponse res , HttpServletRequest req,
			 ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			String saveFile = itemPartAdmService.getAttachFileNm(itemPartAdmVo);
			String newFile = itemPartAdmVo.getPartCd() + "_" + itemPartAdmVo.getPartSeq() + "." + saveFile.substring(saveFile.lastIndexOf(".") + 1);
			String filePath = file_Item_Attach_Path + "/" + itemPartAdmVo.getPartCd() + "/" + itemPartAdmVo.getPartRev() + "/" + newFile;
			
			fileDownload(res, req, saveFile, filePath);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	 
	 //기본양식 다운로드
	 @RequestMapping(value="mm/itemPartBasicForm", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> itemPartBasicFormDownload(
			 HttpServletResponse res , HttpServletRequest req,
			 ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			  String saveFile = "품목정보(일반자재)_기본양식.xlsx"; 
			  String filePath = itemPartBasicForm+"품목정보(일반자재)_기본양식.xlsx";
			 
			/*
			 * String saveFile = "테이블_설계서_코모텍_v0.1_2020120"; String newFile =
			 * "1000011300_4.xlsx"; String filePath = file_Item_Attach_Path +
			 * "\\1000011300\\100\\" + newFile;
			 */
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

	
	//partCd값 가져오기
	@RequestMapping(value="mm/getPartRev" , method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getPartRev(ItemPartAdmVo itemPartAdmVo)throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			ItemPartAdmVo partRev = itemPartAdmService.getPartRev(itemPartAdmVo);
					
			jsonData.put("data", partRev);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	
	
	/*//부품수입검사기준서 시퀀스 가져오기
	@RequestMapping(value = "/bm/getPartSeq", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getPartSeq(ItemPartAdmVo itemPartAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("부품수입검사기준서 시퀀스 조회: "+itemPartAdmVo);
		try {
			String userNm = Utils.getUserNm();
			int getPartSeq = itemPartAdmService.getInspectPartSeq(itemPartAdmVo);
			
			jsonData.put("seq", getPartSeq);
			jsonData.put("name", userNm);
			jsonData.put("result", "ok");
		}catch(Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData; 
	}*/
	
	//견적관리 엑셀조회
	@RequestMapping(value = "mm/itemPartExcelDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> itemPartExcelDataList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info(itemPartAdmVo.getUrl());
		
		if(itemPartAdmVo.getUrl()==null || itemPartAdmVo.getUrl().equals("")) {
			List<ItemPartAdmVo> itemPartAdmList = new ArrayList<ItemPartAdmVo>();
			jsonData.put("data", itemPartAdmList);
		}else {
			CustomerExcelReader excelReader = new CustomerExcelReader();
			List<ItemPartAdmVo> itemPartAdmList = excelReader.itemPartFileload(itemPartAdmVo.getUrl(), logger);
			jsonData.put("data", itemPartAdmList);
			
			logger.info("견적관리 엑셀조회:"+itemPartAdmList);				
			File file = new File(itemPartAdmVo.getUrl());
			logger.info(itemPartAdmVo.getUrl());

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
	
	@RequestMapping(value= "mm/itemPartExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> itemPartExcelUpload(Model model,@RequestParam("excelfile") MultipartFile file) {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		String url = null;
		String fileName = "";
		try {
			// 파일 정보
			String originFilename = file.getOriginalFilename();
			String extName = originFilename;
			Long size = file.getSize();
			String path = itemPartExcelUpload;
			
			// 서버에서 저장 할 파일 이름
			TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
			Calendar calendar = Calendar.getInstance(tz);
			fileName += calendar.get(Calendar.YEAR);
			fileName += calendar.get(Calendar.MONTH)+1;
			fileName += calendar.get(Calendar.DATE);
			fileName += calendar.get(Calendar.HOUR);
			fileName += calendar.get(Calendar.MINUTE);
			fileName += calendar.get(Calendar.SECOND);
			
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
				}catch(Exception e) {
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

}
