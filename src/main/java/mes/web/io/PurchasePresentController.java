package mes.web.io;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.inject.Inject;
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

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.io.ReservationVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.io.FileUploadService;
import mes.web.ut.DateUtil;

@Controller
public class PurchasePresentController {

	@Value("${file.reservationTrackingPath}")
	private String reservation_Tracking_Path;
	
	@Inject
	private FileUploadService fileUploadService;
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);

	//입출고관리 자재입고(바코드) 메인
	@RequestMapping(value = "/iosc0070", method = RequestMethod.GET)
	public String iosc0070GET(Locale locale, Model model) throws Exception {
		
		logger.info("출고현황 관리 페이지");	
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018");	//오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubun", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026");	//승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );

		return "io/iosc0070";
	}

	//입출고관리 자재입고(바코드) 메인
	@RequestMapping(value = "/iosc0180", method = RequestMethod.GET)
	public String iosc0180GET(Locale locale, Model model) throws Exception {
		
		logger.info("출고현황 관리 페이지");	
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018");	//오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubun", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026");	//승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );

		return "io/iosc0180";
	}
	
	
	//입출고관리 포장대기리스트
	@RequestMapping(value = "/iosc0210", method = RequestMethod.GET)
	public String iosc0210GET(Locale locale, Model model) throws Exception {
		logger.info("포장대기리스트 페이지");	
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018");	//오더구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubun", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("026");	//승인구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("approvalCd", systemCommonCodeList );

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );

		return "io/iosc0210";
	}
	
	//출고현황 List
	@RequestMapping(value = "/io/productOutpoutDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productOutpoutDataListGET(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고현황 List 조회");
		
		try {
			List<PurchaseOrderAdmVo> purchaseOrderAdmDataList = purchaseOrderAdmService.productOutpoutDataList(purchaseOrderAdmVo);
			jsonData.put("data", purchaseOrderAdmDataList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출고현황 List 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	}

	
	//출고현황 List
	@RequestMapping(value = "/io/productOutpoutDataDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> productOutpoutDataDtlList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("출고현황 List 조회");
		
		try {
			if("multi".equals(purchaseOrderAdmVo.getIsMulti())){
				String boxNo = purchaseOrderAdmVo.getBoxNo().replace("empty/", "");
				String matrlLotNo = purchaseOrderAdmVo.getMatrlLotNo().replace("empty/", "");
				String filmLotNo = purchaseOrderAdmVo.getFilmLotNo().replace("empty/", "");
				String customerLotNo = purchaseOrderAdmVo.getCustomerLotNo().replace("empty/", "");
				
				String boxNo1 = boxNo.replace("/", "', '");
				String matrlLotNo1 = matrlLotNo.replace("/", "', '");
				String filmLotNo1 = filmLotNo.replace("/", "', '");
				String customerLotNo1 = customerLotNo.replace("/", "', '");
			
				purchaseOrderAdmVo.setBoxNo(boxNo1);
				purchaseOrderAdmVo.setMatrlLotNo(matrlLotNo1);
				purchaseOrderAdmVo.setFilmLotNo(filmLotNo1);
				purchaseOrderAdmVo.setCustomerLotNo(customerLotNo1);
			}
				List<PurchaseOrderAdmVo> productOutpoutDataDtlList = purchaseOrderAdmService.productOutpoutDataDtlList(purchaseOrderAdmVo);
				logger.info("출고현황 List 조회" + productOutpoutDataDtlList);
				jsonData.put("data", productOutpoutDataDtlList);
				jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("출고현황 List 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	}
	
	//엑셀파일 업로드하는 ajax
	@RequestMapping(value= "io/multiRetv_ExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> multiRetv_ExcelUpload(Model model, @RequestParam("excelfile") MultipartFile file) {
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
			logger.info("multiRetv_ExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}
		return jsonData;
	}
	
	//테이블 생성(excel읽기)_ajax
	@RequestMapping(value = "/io/multiRetv_DataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> multiRetv_DataList(String filename) throws Exception {
		Map<String, Object> jsonData	= new HashMap<String, Object>();
		CustomerExcelReader excelReader	= new CustomerExcelReader();
		try {
			List<PurchaseOrderAdmVo> multiRetv_Data = excelReader.multiRetv_fileload(filename, logger);
			logger.info("테이블 생성(excel읽기)_ajax");
			File file = new File(filename);
			logger.info(filename);
			
			if(multiRetv_Data.size() != 0) {
				logger.info("multiRetv_Data는 >>>>> " + multiRetv_Data);
				jsonData.put("data", multiRetv_Data);
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