package mes.web.po;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.AgtBomVo;
import mes.service.em.EquipCondBomAdmService;
import mes.service.po.AgtService;
import mes.web.tm.InventoryAdmController;

@Controller
public class AgtPaperController {
	
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;
	@Inject
	private AgtService agtService;
	
	@Value("${factoryCode}") private String facotryCode;
	@Value("${workOrderDir}") private String workOrderDir;

	private static final Logger logger = LoggerFactory.getLogger(InventoryAdmController.class);
	
	//MTP 1동 설비게더링데이터 Excel 다운
	@RequestMapping(value = "/qm/agtExcel_nF1", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> agtExcel_nF1(AgtBomVo agtBomVo, EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			//제조조건 조회
			EquipTempaturCondAdm tempaturRead = new EquipTempaturCondAdm();
			EquipCondBomAdmVo timeRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo pressureRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			//제조조건 선택된게 없을경우 제조조건 검색 X
			if ("".equals(equipTempaturCondAdm.getEquipCondSeq())) {
	
			} else {
				tempaturRead = equipCondBomAdmService.tempaturRead(equipTempaturCondAdm);
				logger.info("온도 정보 : " + tempaturRead);
				timeRead = equipCondBomAdmService.timeRead(equipCondBomAdmVo);
				logger.info("시간 정보 : " + timeRead);
				pressureRead = equipCondBomAdmService.pressureRead(equipCondBomAdmVo);
				logger.info("압력 정보 : " + pressureRead);
				sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
				logger.info("치수 정보 : " + sizeRead);	
			}
			
			List<AgtBomVo> agtBomList = agtService.readDgsDataList_nF1(agtBomVo);
	
			String ATTACH_PATH = workOrderDir;
			
			File parent = new File(ATTACH_PATH);
			//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
			parent.mkdirs();
			//해당 경로에 만들 xlsx 파일 선언
			tempaturRead.setGoodsNm(tempaturRead.getGoodsNm().replace("/", "_"));	//제품명에 /가있을경우 해당폴더 다운불가-> _로 변환
			File newfile = new File(parent.getAbsolutePath(), agtBomVo.getChooseDate() + "_" + agtBomVo.getEquipNm() + "_" + tempaturRead.getGoodsNm() + "_" + agtBomVo.getIfEquipCondSeq() + ".xlsx");
			agtBomVo.setGoodsNm(tempaturRead.getGoodsNm());
			agtBomVo.setEquipCondSeq(agtBomVo.getIfEquipCondSeq());
			
			
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			InputStream is = AgtPaperController.class.getResourceAsStream("AgtData.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			
			
			OutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			logger.info("OutputStream os : " + os);
			//파일 생성
			PoiTransformer transformer = PoiTransformer.createTransformer(is, os);
			AreaBuilder areaBuilder = new XlsCommentAreaBuilder(transformer);
			JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();
			transformer.getTransformationConfig().setExpressionEvaluator(evaluator); 
			List<Area> xlsAreaList = areaBuilder.build();
			Area xlsArea1 = xlsAreaList.get(0);
			
			Context context = new Context();
			context.putVar("tempaturRead", tempaturRead);	//온도 제조조건
			context.putVar("timeRead", timeRead);			//시간 제조조건
			context.putVar("pressureRead", pressureRead);	//압력 제조조건
			context.putVar("sizeRead", sizeRead);			//치수 제조조건
			context.putVar("agtBomList", agtBomList);		//DGS 게더링 데이터List
			context.putVar("agtBomVo", agtBomVo);			//날짜&설비명&제조조건Seq
			
			xlsArea1.applyAt(new CellRef("Sheet1!A1"), context); 
			xlsArea1.processFormulas();
			
			//시트 2번째 정보 넣을때
			//Area xlsArea2 = xlsAreaList.get(1);
			//xlsArea2.applyAt(new CellRef("Singal!A1"), context); 
			//xlsArea2.processFormulas();
			
			/*
			Area xlsArea3 = xlsAreaList.get(2);
			context.putVar("count", 0);
			xlsArea3.applyAt(new CellRef("자재별 견적서(상세)!A1"), context);
			xlsArea3.processFormulas();
			
			Area xlsArea4 = xlsAreaList.get(3);
			context.putVar("count", 0);
			context.putVar("partsCount", quote.getPartsJson().size());
			xlsArea4.applyAt(new CellRef("품목별 견적서!A1"), context);
			xlsArea4.processFormulas();
			*/
			
			transformer.write();
			
			//Workbook xlsxWb = transformer.getWorkbook();
					
			//xlsxWb.setPrintArea(
			//         1, //sheet index
			//         0, //start column
			//         53, //end column
			//         0, //start row
			//         610  //end row
			//);
			
			/*
			 * FileInputStream input_document = new FileInputStream(new
			 * File("C:\\workOrderTemplateVer9.xls"));
			 * 
			 * // Read workbook into HSSFWorkbook HSSFWorkbook my_xls_workbook = new
			 * HSSFWorkbook(input_document);
			 * 
			 * // Read worksheet into HSSFSheet HSSFSheet my_worksheet =
			 * my_xls_workbook.getSheetAt(0);
			 * 
			 * // To iterate over the rows Iterator<Row> rowIterator =
			 * my_worksheet.iterator();
			 * 
			 * // We will create output PDF document objects at this point Document
			 * iText_xls_2_pdf = new Document(); PdfWriter.getInstance(iText_xls_2_pdf, new
			 * FileOutputStream("Excel2PDF_Output.pdf")); iText_xls_2_pdf.open();
			 * 
			 * // We have two columns in the Excel sheet, so we create a PDF table with two
			 * columns // Note: There are ways to make this dynamic in nature, if you want
			 * to. PdfPTable my_table = new PdfPTable(2);
			 * 
			 * // We will use the object below to dynamically add new data to the table
			 * PdfPCell table_cell;
			 * 
			 * // Loop through rows. while (rowIterator.hasNext()) { Row row =
			 * rowIterator.next(); Iterator<Cell> cellIterator = row.cellIterator(); while
			 * (cellIterator.hasNext()) { Cell cell = cellIterator.next(); //Fetch CELL
			 * //switch (cell.getCellType()) { //Identify CELL type //you need to add more
			 * code here based on your requirement / transformations //case
			 * cell.CELL_TYPE_STRING: //Push the data from Excel to PDF Cell //feel free to
			 * move the code below to suit to your needs table_cell = new PdfPCell(new
			 * Phrase(cell.getStringCellValue())); my_table.addCell(table_cell); break; //}
			 * }
			 * 
			 * }
			 * 
			 * // Finally add the table to PDF document iText_xls_2_pdf.add(my_table);
			 * iText_xls_2_pdf.close();
			 * 
			 * // we created our pdf file.. input_document.close(); //close xls
			 */

			
			//  }catch(Exception e) {
			//    System.out.println(e);
			//  }finally {
		       
			//  }
			// String fileName = "견적서_" + workOrderVo.getDealCorpCd() + ".xlsx";
			// 
			// byte fileByte[] = Files.readAllBytes(newfile.toPath());
			// response.setContentType("application/octet-stream");
			// response.setContentLength(fileByte.length);
			// response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileName,"UTF-8")+"\";");
			// response.setHeader("Content-Transfer-Encoding", "binary");
			// response.getOutputStream().write(fileByte);
			// response.getOutputStream().flush();
			// response.getOutputStream().close();
			// 
			// logger.info("제이슨 보내기 직전");
			
			jsonData.put("result", "ok");
			jsonData.put("path", parent.toString() );
			jsonData.put("data", agtBomVo);
			logger.info("제이슨 보낸 후" + jsonData);
			
		} catch (Exception e) {
			logger.info("제조조건&게더링데이터 Excel 다운 실패"
					+ "");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//MTP 2동 & 솔브레인SLD 설비게더링데이터 Excel 다운
	@RequestMapping(value = "/qm/agtExcel_F2F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> excelGET(AgtBomVo agtBomVo, EquipCondBomAdmVo equipCondBomAdmVo, EquipTempaturCondAdm equipTempaturCondAdm, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			//제조조건 조회
			EquipTempaturCondAdm tempaturRead = new EquipTempaturCondAdm();
			EquipCondBomAdmVo timeRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo pressureRead = new EquipCondBomAdmVo();
			EquipCondBomAdmVo sizeRead = new EquipCondBomAdmVo();
			//제조조건 선택된게 없을경우 제조조건 검색 X
			if ("".equals(equipTempaturCondAdm.getEquipCondSeq())) {
	
			} else {
				tempaturRead = equipCondBomAdmService.tempaturRead(equipTempaturCondAdm);
				logger.info("온도 정보 : " + tempaturRead);
				timeRead = equipCondBomAdmService.timeRead(equipCondBomAdmVo);
				logger.info("시간 정보 : " + timeRead);
				pressureRead = equipCondBomAdmService.pressureRead(equipCondBomAdmVo);
				logger.info("압력 정보 : " + pressureRead);
				sizeRead = equipCondBomAdmService.sizeRead(equipCondBomAdmVo);
				logger.info("치수 정보 : " + sizeRead);	
			}
			
			agtBomVo.setFactoryCode(facotryCode);
			
			List<AgtBomVo> agtBomList = agtService.readDgsDataList_F2F3(agtBomVo);
			String ATTACH_PATH = workOrderDir;
			File parent = new File(ATTACH_PATH);
			//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
			parent.mkdirs();
			
			//해당 경로에 만들 xlsx 파일 선언
			if( tempaturRead != null ) {
				 tempaturRead.setGoodsNm("all");
				if( tempaturRead.getGoodsNm() != null && !tempaturRead.getGoodsNm().equals("") ) {
					tempaturRead.setGoodsNm(tempaturRead.getGoodsNm().replace("/", "_"));	//제품명에 /가있을경우 해당폴더 다운불가-> _로 변환
				} else {
					tempaturRead.setGoodsNm("");
					agtBomVo.setIfEquipCondSeq("");
				}
			} else {
				tempaturRead = equipTempaturCondAdm;
				tempaturRead.setGoodsNm("");
				agtBomVo.setIfEquipCondSeq("");
			}
			
			File newfile = new File(parent.getAbsolutePath(), agtBomVo.getChooseDate() + "_" + agtBomVo.getEquipNm() + "_" + tempaturRead.getGoodsNm() + "_" + agtBomVo.getIfEquipCondSeq() + ".xlsx");
			agtBomVo.setGoodsNm(tempaturRead.getGoodsNm());
			agtBomVo.setEquipCondSeq(agtBomVo.getIfEquipCondSeq());
			
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			InputStream is = null;
			if ("002".equals(facotryCode)) {
				is = AgtPaperController.class.getResourceAsStream("AgtData_nF2.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐	
			} else if ("003".equals(facotryCode)) {
				is = AgtPaperController.class.getResourceAsStream("AgtData_nF3.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
			} else {
				jsonData.put("message", "공장코드 오류입니다. 관리자에게 문의해주세요!");
				jsonData.put("result", "fail");
			}
			//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
			
			OutputStream os = new FileOutputStream(newfile.getAbsolutePath());
			logger.info("OutputStream os : " + os);
			//파일 생성
			PoiTransformer transformer = PoiTransformer.createTransformer(is, os);
			AreaBuilder areaBuilder = new XlsCommentAreaBuilder(transformer);
			JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();
			transformer.getTransformationConfig().setExpressionEvaluator(evaluator); 
			List<Area> xlsAreaList = areaBuilder.build();
			Area xlsArea1 = xlsAreaList.get(0);
			
			Context context = new Context();
			context.putVar("tempaturRead", tempaturRead);	//온도 제조조건
			context.putVar("timeRead", timeRead);			//시간 제조조건
			context.putVar("pressureRead", pressureRead);	//압력 제조조건
			context.putVar("sizeRead", sizeRead);			//치수 제조조건
			context.putVar("agtBomList", agtBomList);		//DGS 게더링 데이터List
			context.putVar("agtBomVo", agtBomVo);			//날짜&설비명&제조조건Seq
			
			xlsArea1.applyAt(new CellRef("Sheet1!A1"), context); 
			xlsArea1.processFormulas();
			
			transformer.write();
			
			jsonData.put("result", "ok");
			jsonData.put("path", parent.toString() );
			jsonData.put("data", agtBomVo);
			logger.info("제이슨 보낸 후" + jsonData);
			
		} catch (Exception e) {
			logger.info("제조조건&게더링데이터 Excel 다운 실패"
					+ "");
			e.printStackTrace();
			jsonData.put("message", "시스템 오류가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	// 엑셀다운로드
	@RequestMapping(value = "/agtExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView  agtExcelDownload(ModelAndView modelAndView, @RequestParam(value="id") String agtExcelFilmName) throws Exception {
		
		String filePath = workOrderDir;
		String fileName = agtExcelFilmName + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file = new File(fullPath);
		logger.info(fullPath);
		
		return new ModelAndView("downloadView", "downloadFile", file);
	}
	
}