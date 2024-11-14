package mes.web.tm;

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

import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.service.tm.InventoryAdmService;

@Controller
public class InventoryExcelController {
	
	@Inject
	private InventoryAdmService inventoryAdmService;
	
	@Value("${workOrderDir}") private String workOrderDir;

	private static final Logger logger = LoggerFactory.getLogger(InventoryAdmController.class);
	
	//제품 월별 재고현황 엑셀다운
	@RequestMapping(value = "/tm/monthGoodsProductionExcel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> monthGoodsProductionExcel(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		
		//선택 날짜로 전체 재고 조회(yyyy-mm)
		matrlInOutWhsAdmVo.setExcelTitle("월재고현황");
		List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList = inventoryAdmService.tmByGoodsMonthInventoryDtlList(matrlInOutWhsAdmVo);
		String ATTACH_PATH = workOrderDir;
		
		File parent = new File(ATTACH_PATH);
		//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
		parent.mkdirs();
		//해당 경로에 만들 xlsx 파일 선언
		File newfile = new File(parent.getAbsolutePath(), "monthProduct_" + matrlInOutWhsAdmVo.getPackDate() + ".xlsx");
		
		//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
		InputStream is = InventoryExcelController.class.getResourceAsStream("goodsProductAdm.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
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
		context.putVar("matrlInOutWhsAdmVo", matrlInOutWhsAdmVo);		//검색 날짜
		context.putVar("productList", tmByGoodsInventoryDtlList);	//온도 제조조건
		
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
		
		jsonData.put("result", "ok");
		jsonData.put("path", parent.toString() );
		jsonData.put("data", matrlInOutWhsAdmVo);
		logger.info("제이슨 보낸 후" + jsonData);
				
		return jsonData;
	}
		
	//제품 월별 재고현황 엑셀다운
	@RequestMapping(value = "/tm/monthGoodsProductionExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView monthGoodsProductionExcel(ModelAndView modelAndView, @RequestParam(value="id") String monthProductFilmName) throws Exception {
		
		String filePath = workOrderDir;
		String fileName = monthProductFilmName + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file = new File(fullPath);
		logger.info(fullPath);
		
		return new ModelAndView("downloadView", "downloadFile", file);
	}
		
	//제품 일별 재고현황 엑셀다운
	@RequestMapping(value = "/tm/dailyGoodsProductionExcel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> dailyGoodsProductionExcel(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		
		//선택 날짜로 전체 재고 조회(yyyy-mm-dd)
		matrlInOutWhsAdmVo.setExcelTitle("일재고현황");
		List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList = inventoryAdmService.tmByGoodsInventoryDtlListChecked(matrlInOutWhsAdmVo);
		String ATTACH_PATH = workOrderDir;
		
		File parent = new File(ATTACH_PATH);
		//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
		parent.mkdirs();
		//해당 경로에 만들 xlsx 파일 선언
		File newfile = new File(parent.getAbsolutePath(), "dailyProduct_" + matrlInOutWhsAdmVo.getPackDate() + ".xlsx");
		
		//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
		InputStream is = InventoryExcelController.class.getResourceAsStream("goodsProductAdm.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
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
		context.putVar("matrlInOutWhsAdmVo", matrlInOutWhsAdmVo);		//검색 날짜
		context.putVar("productList", tmByGoodsInventoryDtlList);	//온도 제조조건
		
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
		
		jsonData.put("result", "ok");
		jsonData.put("path", parent.toString() );
		jsonData.put("data", matrlInOutWhsAdmVo);
		logger.info("제이슨 보낸 후" + jsonData);
				
		return jsonData;
	}
	
	//제품 일별 재고현황 엑셀다운
	@RequestMapping(value = "/tm/dailyGoodsProductionExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView dailyGoodsProductionExcelDownload(ModelAndView modelAndView, @RequestParam(value="id") String dailyProductFilmName) throws Exception {
		
		String filePath = workOrderDir;
		String fileName = dailyProductFilmName + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file = new File(fullPath);
		logger.info(fullPath);
		
		return new ModelAndView("downloadView", "downloadFile", file);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//자재재고 전체다운
	@RequestMapping(value = "/tm/matrlInventoryExcel", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInventoryExcel(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		
		//선택 날짜로 전체 재고 조회(yyyy-mm-dd)
		List<MatrlInOutWhsAdmVo> tmByMatrlInventoryDtlList = inventoryAdmService.matrlInventorylList(matrlInOutWhsAdmVo);
		String ATTACH_PATH = workOrderDir;
		
		File parent = new File(ATTACH_PATH);
		//해당경로까지 폴더가 없으면 폴더만들기(경로만들기)
		parent.mkdirs();
		//해당 경로에 만들 xlsx 파일 선언
		File newfile = new File(parent.getAbsolutePath(), "matrlInventory_" + matrlInOutWhsAdmVo.getInWhsDate() + ".xlsx");
		
		//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!//중요!
		InputStream is = InventoryExcelController.class.getResourceAsStream("matrlInventory.xlsx");		//파일명 변경시 pom.xml도 변경해줘야함 미수정시 파일 ROOT 안말아짐
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
		context.putVar("matrlInOutWhsAdmVo", matrlInOutWhsAdmVo);
		context.putVar("matrlList", tmByMatrlInventoryDtlList);
		
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
		
		jsonData.put("result", "ok");
		jsonData.put("path", parent.toString() );
		jsonData.put("data", matrlInOutWhsAdmVo);
		logger.info("제이슨 보낸 후" + jsonData);
				
		return jsonData;
	}
	
	//제품 일별 재고현황 엑셀다운
	@RequestMapping(value = "/tm/matrlInventoryExcelDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView matrlInventoryExcelDownload(ModelAndView modelAndView, @RequestParam(value="id") String matrlFilmName) throws Exception {
		
		String filePath = workOrderDir;
		String fileName = matrlFilmName + ".xlsx";
		String fullPath = filePath + "/" + fileName;
		File file = new File(fullPath);
		logger.info(fullPath);
		
		return new ModelAndView("downloadView", "downloadFile", file);
	}
		
}