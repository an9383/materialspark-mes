package mes.web.io;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
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

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellCopyPolicy;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ComparisonOperator;
import org.apache.poi.ss.usermodel.ConditionalFormatting;
import org.apache.poi.ss.usermodel.ConditionalFormattingRule;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PatternFormatting;
import org.apache.poi.ss.usermodel.PrintSetup;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.SheetConditionalFormatting;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jxls.area.Area;
import org.jxls.builder.AreaBuilder;
import org.jxls.builder.xls.XlsCommentAreaBuilder;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.expression.JexlExpressionEvaluator;
import org.jxls.transform.poi.PoiTransformer;
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
import org.springframework.web.servlet.ModelAndView;

import mes.domain.bm.DealCorpAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.ReservationVo;
import mes.service.bm.DealCorpAdmService;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.io.FileUploadService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.MatrlInWhsRqtService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.po.GoodsPackService;
import mes.service.po.WorkOrderService;
import mes.service.qm.ShipInspectService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ShipReportsController {
	
	@Value("${file.platedTrackingPath}")
	private String plated_Tracking_Path;
	
	@Inject
	private FileUploadService fileUploadService;
	
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private InspectInfoAdmService inspectInfoAdmService;
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private PdaService PdaService;
	@Inject
	private PreGoodsInventoryAdmService preGoodsInventoryAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private MatrlInWhsRqtService matrlInWhsRqtService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private ShipInspectService shipInspectService;
	@Inject
	private DealCorpAdmService dealCorpAdmService;
	
	@Inject
	private GoodsPackService goodsPackService;
	
	
	@Value("${factoryCode}") private String factoryCode;
	@Value("${workOrderDir}") private String workOrderDir;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	//도금두께등록 페이지
	@RequestMapping(value = "/iosc0200", method = RequestMethod.GET)
	public String iosc0200(Locale locale, Model model) throws Exception {
		
		logger.info("도금두께등록 페이지");
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc0200";
	}
	
	//성적서관리 페이지
	@RequestMapping(value = "/iosc0190", method = RequestMethod.GET)
	public String iosc0190(Locale locale, Model model) throws Exception {
		
		logger.info("입출고관리 입고현황관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("007"); //재질
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlNm", systemCommonCodeList );
		
		DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();
		List<DealCorpAdmVo> dealCorpAdmData = dealCorpAdmService.listAll(dealCorpAdmVo);
		model.addAttribute("dealCorpAdm", dealCorpAdmData );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
        model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
        
		return "io/iosc0190";
	}
	
	
	//제품출하검사성적서 목록조회
	@RequestMapping(value = "/io/shipReportsList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipReportsList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품출하검사성적서 " + matrlInOutWhsAdmVo);
		try {
			List<MatrlInOutWhsAdmVo> shipReportsList = matrlInOutWhsAdmService.shipReportsList(matrlInOutWhsAdmVo);
			jsonData.put("data", shipReportsList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품출하검사성적서 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//제품출하검사성적서 서브 목록조회
	@RequestMapping(value = "/io/shipReportsDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipReportsDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품출하검사성적서 서브 : " + matrlInOutWhsAdmVo);
		try {
			List<MatrlInOutWhsAdmVo> shipReportsDtlList = matrlInOutWhsAdmService.shipReportsDtlList(matrlInOutWhsAdmVo);
			jsonData.put("data", shipReportsDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품출하검사성적서 서브 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	
	
	//도금두께 목록조회
	@RequestMapping(value = "/io/platedList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> platedList() throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("목록조회");
		List<ReservationVo> platedList = new ArrayList<ReservationVo>();
		jsonData.put("data", platedList);
		
		return jsonData;
	}
	
	
	//도금두께 등록
	@RequestMapping(value = "/io/shipReportsPlatedCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> shipReportsPlatedCreate(@RequestBody List<Map<String, Object>> platedList) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("도금두께 등록 : " + platedList);
		try {
			
			MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			
			for (Map<String, Object> m : platedList) {
				matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
				matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
				matrlInOutWhsAdmVo.setThicknessQty( Float.parseFloat(m.get("thicknessQty").toString()) );
				matrlInOutWhsAdmVo.setRegId( Utils.getUserId() );
				matrlInOutWhsAdmService.shipReportsPlatedCreate(matrlInOutWhsAdmVo);
			}
			//matrlInOutWhsAdmVo.setRegId( Utils.getUserId() );
			
			//matrlInOutWhsAdmService.shipReportsPlatedCreate(matrlInOutWhsAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("제품출하 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	//추가양식 다운로드
	@RequestMapping(value="io/platedBasicForm", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> platedBasicForm(HttpServletResponse res , HttpServletRequest req) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			String saveFile = "도금두께등록_기본양식.xlsx"; 
			String filePath = plated_Tracking_Path+saveFile;
			fileDownload(res, req, saveFile, filePath);
			logger.info("파일 다운");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	
	//도금두께엑셀업로드하는 부분
	@RequestMapping(value= "io/platedExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> platedExcelUpload(Model model, @RequestParam("excelfile") MultipartFile file) {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			
			String path = plated_Tracking_Path + "temporaryFolder";
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
	
	//도금두께_테이블 생성(excel읽기)_ajax
	@RequestMapping(value = "/io/platedDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> platedDataList(String filename) throws Exception {
		Map<String, Object> jsonData	= new HashMap<String, Object>();
		CustomerExcelReader excelReader	= new CustomerExcelReader();
		try {
			List<ReservationVo> reservation_Data = excelReader.plated_fileload(filename, logger);
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
	
	
	//성적서 엑셀다운
	@RequestMapping(value = "/io/reportExcelProduce", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> reportExcelProduce(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
	
			/*InputStream is = null;
			//Excel 파일에 범위 설정하는 메모란은 무조건A1에 위치하여야 함!
			//MTP 1공장(성남)
			if ("001".equals(factoryCode)) {
				is = ShipReportsController.class.getResourceAsStream("출하검사성적서(머티).xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐	
			//MTP 2공장(성남)
			} else if ("002".equals(factoryCode)) {
				is = ShipReportsController.class.getResourceAsStream("출하검사성적서(머티).xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
			//SLD 3공장(파주)
			} else if ("003".equals(factoryCode)) {
				//is = WorkOrderPaperController.class.getResourceAsStream("workOrderTemplate_SLD_F3.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐	
			}*/
			//String dealCorpNm	= matrlInOutWhsAdmVo.getDealCorpNm();
			//String toDay		= DateUtil.getToday("yyyy-mm-dd");
			
			String excelFormGubun = matrlInOutWhsAdmVo.getExcelFormGubun();	//001: 한 페이지에 전체 행 출력, 002: 30개씩 잘라서 새 시트 생성
			
			List<MatrlInOutWhsAdmVo> shipReportsDtlList = matrlInOutWhsAdmService.shipReportsDtlList(matrlInOutWhsAdmVo);
			
			String toDay 			= matrlInOutWhsAdmVo.getDeliveryDate();
			String model 			= shipReportsDtlList.get(0).getModel();
			String goodsCdInitial	= shipReportsDtlList.get(0).getGoodsCd().substring(0, 1);
			String goodsNm			= shipReportsDtlList.get(0).getGoodsNm();
			
			model = model == null ? "-" : model.substring( 0, model.indexOf('(') );
			
			matrlInOutWhsAdmVo.setToDay( toDay.replaceAll("-", ".") );
			matrlInOutWhsAdmVo.setModel( model );
			
			
			String ATTACH_PATH = workOrderDir;
			File parent = new File(ATTACH_PATH);
			//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
			parent.mkdirs();
			File newfile = new File(parent.getAbsolutePath(), "출하검사성적서(머티).xlsx");

			InputStream is = ShipReportsController.class.getResourceAsStream("ShipReport(MP).xlsx"); //파일 경로 수정
			OutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			logger.info("OutputStream os : " + os);

			//파일 생성
			PoiTransformer transformer = PoiTransformer.createTransformer(is, os);
			AreaBuilder areaBuilder = new XlsCommentAreaBuilder(transformer);
			JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();

			transformer.getTransformationConfig().setExpressionEvaluator(evaluator);
			
			List<Area> xlsAreaList = areaBuilder.build();

			if (xlsAreaList.isEmpty()) {
				throw new RuntimeException("No XlsArea found in the input template file. \n 입력 템플릿 파일에서 XlsArea를 찾을 수 없습니다.");
			}
			
			//기준 배열에 담아주기
			String[] stdArray = standardAppointed(model, goodsNm);
			
			Area xlsArea1 = xlsAreaList.get(0);
			
			//데이터 담아주는 부분
			Context context = new Context();
			
			context.putVar("reportList", shipReportsDtlList);
			context.putVar("reportVo", matrlInOutWhsAdmVo);
			context.putVar("stdArray", stdArray);

			xlsArea1.applyAt(new CellRef("Sheet1!A1"), context);
			//데이터 담아주는 부분
			
			int rowSize	= shipReportsDtlList.size();
			
			//도금이 아닌 경우 열 숨김 처리 진행
	        if( !goodsCdInitial.equals("N") ) {
	        	Workbook workbook	= transformer.getWorkbook();
	        	Sheet sheetSudel = workbook.getSheet("Sheet1");	// 숨길 열이 있는 시트 선택
		        sheetSudel.setColumnHidden(15,  true); 					//열 숨김 처리	
	        }
	      	//도금이 아닌 경우 열 숨김 처리 진행
			
			//엑셀 양식 지정
			if( excelFormGubun.equals("001") ) {
				
				//조건부 서식 설정
				
				CellReference topLeftRef;	// 범위 시작 위치를 지정
				CellReference bottomRightRef;	// 범위 끝 위치를 지정
				
				Sheet SheetForm = transformer.getWorkbook().getSheet("Sheet1");	//시트 가지고 오기
				SheetConditionalFormatting sheetConditionalFormatting = SheetForm.getSheetConditionalFormatting();	//객체 생생
				
				String colLetter	= "";
				String maxFormula	= "";
				String minFormula	= "";
				CellRangeAddress cfr;	//conditionalFormattingRange
				
				//열 반복
				for (int col = 0; col <= 11; col++) {
					colLetter	= CellReference.convertNumToColString( (col + 3) );	//처음 시작을 D로 시작
					
					if( !colLetter.equals("H") && !colLetter.equals("M") ) {
					    maxFormula		= "LEFT($" + colLetter + "$16,FIND(\"±\",$" + colLetter + "$16)-1) + MID($" + colLetter + "$16,SEARCH(\"±\",$" + colLetter + "$16)+1,99)";
					    minFormula		= "LEFT($" + colLetter + "$16,FIND(\"±\",$" + colLetter + "$16)-1) - MID($" + colLetter + "$16,SEARCH(\"±\",$" + colLetter + "$16)+1,99)";
					    
					    //조건부서식지정
						//MAX
					    ConditionalFormattingRule maxRule = sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.GT, maxFormula);
					    PatternFormatting maxFill = maxRule.createPatternFormatting();
					    maxFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
					    
						//MIN
					    ConditionalFormattingRule minRule = sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.LT, minFormula);
					    PatternFormatting minFill = minRule.createPatternFormatting();
					    minFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
					  	//조건부서식지정
					    
					    // 조건부 서식이 지정될 범위 설정
					    topLeftRef		= new CellReference(colLetter + "18");	//시작(고정))
					    bottomRightRef	= new CellReference(colLetter + (rowSize + 17));	//끝(고정))
					    cfr				= new CellRangeAddress( topLeftRef.getRow(), bottomRightRef.getRow(), topLeftRef.getCol(), bottomRightRef.getCol() );
					    
					    CellRangeAddress[] cellRangeAddresses = { cfr };

					    // 조건부 서식 지정
					    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, maxRule);
					    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, minRule);
					} else {
						maxFormula = "MID($" + colLetter + "$16, SEARCH(\"x\",$" + colLetter +"$16)+1,99) + 0";
					    
					    //조건부서식지정
						//MAX
					    ConditionalFormattingRule maxRule	= sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.GT, maxFormula);
					    PatternFormatting maxFill			= maxRule.createPatternFormatting();
					    maxFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
					  	//조건부서식지정
					    
					    // 조건부 서식이 지정될 범위 설정
					    topLeftRef		= new CellReference(colLetter + "18");	//시작(고정))
					    bottomRightRef	= new CellReference(colLetter + (rowSize + 17));	//끝)
					    cfr				= new CellRangeAddress( topLeftRef.getRow(), bottomRightRef.getRow(), topLeftRef.getCol(), bottomRightRef.getCol() );
					    
					    CellRangeAddress[] cellRangeAddresses = { cfr };

					    // 조건부 서식 지정
					    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, maxRule);
					}
				}
				//조건부 서식 설정
				
			} else if( excelFormGubun.equals("002")) {
				//여기서 부터 Sheet 반복해주는 부분
				
				Workbook workbook	= transformer.getWorkbook();
				Sheet sheet1		= workbook.getSheet("Sheet1");
				int sheetIndex		= workbook.getSheetIndex(sheet1);
				Sheet newSheet		= sheet1;
				int count			= 2;
				int rowIndex		= 1;
				
				int startDlt		= 47;
				int endDlt			= (rowSize+17) - 30;
				
				int paperSheetIndex = 0;
				PrintSetup printSetup;
				CellReference tps;	//topPaperSetting	
				CellReference bps;	//bottompaperSetting
				
				for (int i = 0; i < rowSize; i++) {
					
					//한 시트에 30개의 행이 들어갈 때마다 새로운 시트를 생성
				    if (rowIndex >= 30) {
				    	if( count <= ((rowSize/30)) ) {
					        newSheet = workbook.cloneSheet(sheetIndex);
					        workbook.setSheetName(workbook.getSheetIndex(newSheet), "Sheet" + count);
					        rowIndex = 0;
					        
					        //도금이 아닌 경우 열 숨김 처리 진행
					        if( !goodsCdInitial.equals("N") ) {
					        	Sheet sheetSudel = workbook.getSheet("Sheet" + count);	// 숨길 열이 있는 시트 선택
						        sheetSudel.setColumnHidden(15,  true); 					//열 숨김 처리	
					        }
					      	//도금이 아닌 경우 열 숨김 처리 진행
					        
					        
						    // 수식 지정
						    /*String excelFormula = "SUM(B18:B1048576)";

						    // 수식이 지정될 셀 참조
						    CellReference cellRef = new CellReference("E10");
						    
						    Row row = newSheet.getRow(cellRef.getRow());
						    if (row == null) {
						        row = newSheet.createRow(cellRef.getRow());
						    }
						    
						    Cell cell = row.getCell(cellRef.getCol());
						    if (cell == null) {
						        cell = row.createCell(cellRef.getCol());
						    }

						    cell.setCellFormula(excelFormula);*/
						    
						    workbook.setForceFormulaRecalculation(true); // 수식 계산 강제 실행
						    // 수식 설정
						    
					        
					        //추가된 시트에서 작업 진행
							reportDelete("Sheet"+count, "A18", "T"+startDlt, transformer, "47");
							reportDelete("Sheet"+count, "A48", "T"+endDlt, transformer, "47");
							
							//용지 설정
							printSetup = workbook.getSheet("Sheet" + count).getPrintSetup();
							printSetup.setLandscape(true); // 가로 방향으로 설정
							//workbook.getSheet("Sheet" + count).setFitToPage(true); // 페이지에 맞게 조정
							//workbook.getSheet("Sheet" + count).setHorizontallyCenter(true); // 수평 중앙 정렬
							//workbook.getSheet("Sheet" + count).setVerticallyCenter(true); // 수직 중앙 정렬
							
							paperSheetIndex = workbook.getSheetIndex("Sheet"+count);
							tps	= new CellReference(0, 0);
							bps	= new CellReference(46, 19);
							workbook.setPrintArea( paperSheetIndex, (tps.formatAsString() + ":" + bps.formatAsString()) );
							//용지 설정
							
							startDlt	+= 30;
							endDlt		-= 30;
							
							count++;
				    	} else {
				    		
				    		if( (rowSize%30) != 0 ) {
					    		//리스트 크기가 30으로 나누어떨어지지 않을 경우, 마지막으로 실행
					    		newSheet = workbook.cloneSheet(sheetIndex);
						        workbook.setSheetName(workbook.getSheetIndex(newSheet), "Sheet" + count);
						        rowIndex = 0;
						        
						      	//도금이 아닌 경우 열 숨김 처리 진행
						        if( !goodsCdInitial.equals("N") ) {
						        	Sheet sheetSudel = workbook.getSheet("Sheet" + count);	// 숨길 열이 있는 시트 선택
							        sheetSudel.setColumnHidden(15,  true); 					//열 숨김 처리	
						        }
						      	//도금이 아닌 경우 열 숨김 처리 진행
						        
						        /*
						        logger.info("Sheet Number >>>>>>>>>>> " +count);
						        logger.info("startDlt >>>>>>>>>>> " +startDlt);
						        logger.info("endDlt >>>>>>>>>>> " +endDlt);
						        logger.info("startDlt >>>>>>>>>>> " +Integer.toString(((rowSize%30) + 17)));
						        */
						        
					    		reportDelete("Sheet"+count, "A18", "T"+startDlt, transformer, Integer.toString(((rowSize%30) + 17)));
					    		
					    		//용지 설정
								printSetup = workbook.getSheet("Sheet" + count).getPrintSetup();
								printSetup.setLandscape(true); // 가로 방향으로 설정
								
								paperSheetIndex = workbook.getSheetIndex("Sheet"+count);
								tps	= new CellReference(0, 0);
								bps	= new CellReference(46, 19);
								workbook.setPrintArea( paperSheetIndex, (tps.formatAsString() + ":" + bps.formatAsString()) );
								//용지 설정
				    		}
				    	}
				    }
				    
				    // 행 추가하는 코드
				    rowIndex++;
				}
				//여기서 부터 Sheet 반복해주는 부분
	
				//시트1에 복사가 끝났으니 시트1도 30개 데이터만 남기기
				reportDelete("Sheet1", "A48", ("T"+(rowSize+17)), transformer, "47");
			}
			
			xlsArea1.processFormulas();
			transformer.write();
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("작업지시 엑셀다운 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	//기종별에 따른 기준 목록조회
	@RequestMapping(value = "/io/standardAppointedList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> standardAppointedList(String model, String goodsNm) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("기종별에 따른 기준 목록조회 " + goodsNm);
		try {
			model = model == null ? "-" : model.substring( 0, model.indexOf('(') );
			String[] stdArray = standardAppointed(model, goodsNm);
			jsonData.put("data", stdArray);
		} catch (Exception e) {
			logger.info("기종별에 따른 기준 목록조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	//기종별에 따른 기준 값
	public String[] standardAppointed(String model, String goodsNm) throws Exception {
		
		String[] stdArray = new String[17];
		
		if( model.equals("0.2x45-PP10.0x49-46.5P") && goodsNm.contains("E556") ) {
			//E556(NC)
			stdArray[0] = "10.0±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "2.0±0.5";
			stdArray[3] = "5.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.200±0.015";
			stdArray[6] = "0.500±0.030";
			stdArray[7] = "49.0±0.5";
			stdArray[8] = "46.5±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "6 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\n" + "OK / NG";
			//E556(NC)
		} else if( model.equals("0.3x45-PP9.5x55-48P") && goodsNm.contains("P395") ) {
			//P395(NC)
			stdArray[0] = "9.5±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "5.0±0.5";
			stdArray[3] = "4.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.300±0.015";
			stdArray[6] = "0.600±0.030";
			stdArray[7] = "55.0±0.5";
			stdArray[8] = "48.0±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "6 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\n" + "OK / NG";
			//P395(NC)
		} else if( model.equals("0.3x45-PP9.5x55-39P") && goodsNm.contains("N60") ) {
			//N60(NC)
			stdArray[0] = "9.5±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "5.0±0.5";
			stdArray[3] = "4.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.300±0.015";
			stdArray[6] = "0.600±0.030";
			stdArray[7] = "55.0±0.5";
			stdArray[8] = "39.0±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "6 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\n" + "OK / NG";
			//N60(NC)
		} else if( model.equals("0.4x45-PP10.0x49-46.5P") && goodsNm.contains("E556") ) {
			//E556(AL)
			stdArray[0] = "10.0±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "2.0±0.5";
			stdArray[3] = "5.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.400±0.015";
			stdArray[6] = "0.700±0.030";
			stdArray[7] = "49.0±0.5";
			stdArray[8] = "46.5±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "7 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\r\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\r\n" + "OK / NG";
			//E556(AL)
		} else if( model.equals("0.4x45-PP9.5x55-48P") && goodsNm.contains("P395") ) {
			//P395(AL)
			stdArray[0] = "9.5±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "5.0±0.5";
			stdArray[3] = "4.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.400±0.015";
			stdArray[6] = "0.700±0.030";
			stdArray[7] = "55.0±0.5";
			stdArray[8] = "48.0±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "7 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\r\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\r\n" + "OK / NG";
			//P395(AL)
		} else if( model.equals("0.4x45-PP9.5x55-39P") && goodsNm.contains("N60") ) {
			//N60(AL)
			stdArray[0] = "9.5±0.5";
			stdArray[1] = "45.0±0.2";
			stdArray[2] = "5.0±0.5";
			stdArray[3] = "4.5±0.5";
			stdArray[4] = "Max0.3";
			stdArray[5] = "0.400±0.015";
			stdArray[6] = "0.700±0.030";
			stdArray[7] = "55.0±0.5";
			stdArray[8] = "39.0±0.5";
			stdArray[9] = "Max0.5";
			stdArray[10] = "OK/NO";
			stdArray[11] = "More than\n" + "7 times";
			stdArray[12] = "2.5㎛±0.7㎛";
			stdArray[13] = "OK/NO";
			stdArray[14] = "OK/NO";
			stdArray[15] = "0.015\n" + "OK/NG";
			stdArray[16] = "Max 0.5↓\n" + "OK / NG";
			//N60(AL)
		}
			
		return stdArray;
	}
	
	public void reportDelete(String sheetName, String startCell, String endCell, PoiTransformer transformer, String endForm) throws Exception {
		
		Workbook workbook = transformer.getWorkbook();
		Sheet sheet = workbook.getSheet(sheetName);
		
		//삭제
		CellReference topLeftRef		= new CellReference(startCell);	// 범위 시작 위치를 지정
		CellReference bottomRightRef	= new CellReference(endCell);	// 범위 끝 위치를 지정

		int firstRow		= topLeftRef.getRow();		// 시작 위치의 행 번호
		int lastRow			= bottomRightRef.getRow();	// 끝 위치의 행 번호
		int numRowsToDelete	= lastRow - firstRow + 1;	// 삭제할 행의 개수를 계산

		for (int rowIndex = firstRow; rowIndex <= lastRow; rowIndex++) {
		    Row row = sheet.getRow(rowIndex);

		    if (row != null) {
		    	sheet.removeRow(row);
		    }
		}

		// 삭제한 행만큼 나머지 행들을 이동
		if (numRowsToDelete > 0) {
		    sheet.shiftRows(lastRow + 1, sheet.getLastRowNum(), -numRowsToDelete);
		}
		
		
		//조건부 서식 설정
		Sheet SheetForm = transformer.getWorkbook().getSheet(sheetName);	//시트 가지고 오기
		SheetConditionalFormatting sheetConditionalFormatting = SheetForm.getSheetConditionalFormatting();	//객체 생생
		
		String colLetter	= "";
		String maxFormula	= "";
		String minFormula	= "";
		CellRangeAddress cfr;	//conditionalFormattingRange
		
		
		//열 반복
		for (int col = 0; col <= 11; col++) {
			colLetter	= CellReference.convertNumToColString( (col + 3) );	//처음 시작을 D로 시작
			
			if( !colLetter.equals("H") && !colLetter.equals("M") ) {
			    maxFormula	= "LEFT($" + colLetter + "$16,FIND(\"±\",$" + colLetter + "$16)-1) + MID($" + colLetter + "$16,SEARCH(\"±\",$" + colLetter + "$16)+1,99)";
			    minFormula	= "LEFT($" + colLetter + "$16,FIND(\"±\",$" + colLetter + "$16)-1) - MID($" + colLetter + "$16,SEARCH(\"±\",$" + colLetter + "$16)+1,99)";
			    
			    //조건부서식지정
				//MAX
			    ConditionalFormattingRule maxRule = sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.GT, maxFormula);
			    PatternFormatting maxFill = maxRule.createPatternFormatting();
			    maxFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
			    
				//MIN
			    ConditionalFormattingRule minRule = sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.LT, minFormula);
			    PatternFormatting minFill = minRule.createPatternFormatting();
			    minFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
			  	//조건부서식지정
			    
			    // 조건부 서식이 지정될 범위 설정
			    topLeftRef		= new CellReference(colLetter + "18");	//시작(고정))
			    bottomRightRef	= new CellReference(colLetter + endForm);	//끝)
			    cfr				= new CellRangeAddress( topLeftRef.getRow(), bottomRightRef.getRow(), topLeftRef.getCol(), bottomRightRef.getCol() );
			    
			    CellRangeAddress[] cellRangeAddresses = { cfr };

			    // 조건부 서식 지정
			    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, maxRule);
			    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, minRule);
			} else {
				
			    maxFormula = "MID($" + colLetter + "$16, SEARCH(\"x\",$" + colLetter +"$16)+1,99) + 0";
			    
			    //조건부서식지정
				//MAX
			    ConditionalFormattingRule maxRule = sheetConditionalFormatting.createConditionalFormattingRule(ComparisonOperator.GT, maxFormula);
			    PatternFormatting maxFill = maxRule.createPatternFormatting();
			    maxFill.setFillBackgroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
			  	//조건부서식지정
			    
			    // 조건부 서식이 지정될 범위 설정
			    topLeftRef		= new CellReference(colLetter + "18");	//시작(고정))
			    bottomRightRef	= new CellReference(colLetter + endForm);	//끝)
			    cfr				= new CellRangeAddress( topLeftRef.getRow(), bottomRightRef.getRow(), topLeftRef.getCol(), bottomRightRef.getCol() );
			    
			    CellRangeAddress[] cellRangeAddresses = { cfr };

			    // 조건부 서식 지정
			    sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, maxRule);
			    //sheetConditionalFormatting.addConditionalFormatting(cellRangeAddresses, minRule);
			}
		}
		//조건부 서식 설정
	}
	
	// 엑셀다운로드
	@RequestMapping(value = "io/reportExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView reportExcelDownload(ModelAndView modelAndView, @RequestParam(value="id") String agtExcelFilmName) throws Exception {
		
		String filePath = workOrderDir;
		String fileName = agtExcelFilmName + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file = new File(fullPath);
		logger.info(fullPath);
		
		return new ModelAndView("downloadView", "downloadFile", file);
	}


}