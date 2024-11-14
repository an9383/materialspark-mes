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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.qm.GoodsDisposeVo;
import mes.domain.qm.ReliabilityLeakageResultVo;
import mes.domain.qm.ShipInspectVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.GoodsPackService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsDisposeService;
import mes.service.qm.GoodsInspectService;
import mes.service.qm.ShipInspectService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class GoodsDisposeController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private InspectInfoAdmService inspectInfoService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;	
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private ProductionPerfTrayService productionPerfTrayService;
	@Inject
	private ShipInspectService shipInspectService;
	@Inject
	private GoodsPackService goodsPackService;
	@Inject
	private GoodsDisposeService goodsDisposeService;
	
	@Value("${factoryCode}") private String factoryCode;
	@Value("${file.disposeFilePath}")	private String disposeFilePath;
	private static final Logger logger = LoggerFactory.getLogger(GoodsDisposeController.class);	
	
	//품질관리 - 이상발생보고
	@RequestMapping(value = "/qmsc0230", method = RequestMethod.GET)
	public String qmsc0190(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 이상발생보고");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();	
		systemCommonCodeVo.setBaseGroupCd("013"); // 부서
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("departmentCode", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("121"); // 이상발생부서
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("abnormalPrcssCode", systemCommonCodeList);

		
		return "qm/qmsc0230";
	}
	
	//이상발생보고 목록조회
	@RequestMapping(value="qm/goodsDisposeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsDisposeList(GoodsDisposeVo goodsDisposeVo) throws Exception{
	    Map<String, Object> jsonData = new HashMap<String, Object>();
	    logger.info("품질관리 - 이상발생보고 목록조회");
	    try {			
	        List<GoodsDisposeVo> list = goodsDisposeService.list(goodsDisposeVo);
	        jsonData.put("data", list);
	        jsonData.put("result", "ok");
	    } catch (Exception e) {
	        e.printStackTrace();
	        jsonData.put("result", "error");
	        jsonData.put("message", Utils.getErrorMessage());
	    }
	    return jsonData;
	}
	
	//폐기등록
	@RequestMapping(value = "qm/goodsDisposeAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsDisposeAdmCreate(MultipartHttpServletRequest multi,			 
			    @RequestParam(value = "abnormalDate") String abnormalDate,
			    @RequestParam(value = "abnormalPrcss") String abnormalPrcss,	
			    @RequestParam(value = "abnormalDesc") String abnormalDesc,
			    @RequestParam(value = "manager") String manager,
			    @RequestParam(value = "isolationYn") String isolationYn			
			    ) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		 
		try {						
			GoodsDisposeVo goodsDisposeVo = new GoodsDisposeVo();
			 //goodsDisposeVo.setAbnormalNo(abnormalNo);
			 goodsDisposeVo.setAbnormalDate(abnormalDate);
			 goodsDisposeVo.setAbnormalPrcss(abnormalPrcss);
			 goodsDisposeVo.setAbnormalDesc(abnormalDesc);
			 goodsDisposeVo.setManager(manager);
			 goodsDisposeVo.setIsolationYn(isolationYn);
			 goodsDisposeVo.setAbnormalNo( goodsDisposeService.selectNoSeq(goodsDisposeVo));			 
			
			logger.info("폐기등록" + goodsDisposeVo);

			String newFileName	= "";			
			String path 		= disposeFilePath + "/" + goodsDisposeVo.getAbnormalNo();				

			
			File dir = new File(path);
			
			if(!dir.exists()) {
				dir.mkdirs();
			}
			

			File[] fileList = dir.listFiles();

			// 파일이 존재하는 경우 삭제
			if (fileList != null) {
			    for (File file : fileList) {
			        String name = file.getName(); // 파일 이름 (확장자 포함)
			        if (name.contains(goodsDisposeVo.getAbnormalNo())) {
			            // 파일이 존재하는 경우 삭제
			        	file.delete();
			            break;
			        }
			    }
			}
			// 파일이 존재하는 경우 삭제
			
			MultipartFile mFile	= multi.getFile("file");
			String fileName		= mFile.getOriginalFilename();
			
			if(!(fileName == null || fileName.equals("") )) {
				newFileName =  goodsDisposeVo.getAbnormalNo() + "." + fileName.substring(fileName.lastIndexOf(".")+1);
				goodsDisposeVo.setFileNm(fileName);

				try {
					mFile.transferTo(new File(path+"/"+newFileName));
				} catch (Exception e) {
					e.printStackTrace();
					jsonData.put("result", "error");
					jsonData.put("message", Utils.getErrorMessage());
				}
			}
			
			goodsDisposeVo.setAccCnt(goodsDisposeService.selectAccCnt(goodsDisposeVo));
			goodsDisposeVo.setFileNm(fileName);
			goodsDisposeVo.setRegId(Utils.getUserId());
			goodsDisposeService.createAdm(goodsDisposeVo);			

			jsonData.put("result", "ok");
			jsonData.put("data", goodsDisposeVo.getAbnormalNo());
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//폐기등록
	@RequestMapping(value = "qm/goodsDisposeDtlCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsDisposeDtlCreate(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		ShipInspectVo shipInspectVo = new ShipInspectVo();
		GoodsDisposeVo goodsDisposeVo = new GoodsDisposeVo();
		//ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
		
		try {			
			//goodsDisposeVo.setAbnormalDate(DateUtil.getCurrentYyyymmdd());
			//goodsDisposeService.createAdm(goodsDisposeVo);				
			
			//goodsDisposeVo.setAbnormalDate(list.get(0).get("abnormalDate").toString());
			//goodsDisposeVo.setAbnormalNo( goodsDisposeService.selectNoSeq(goodsDisposeVo));
			
		
			for(Map<String, Object> m : list) {
				goodsDisposeVo = new GoodsDisposeVo();
				shipInspectVo = new ShipInspectVo();

				//productionPerfTrayVo.setLabelLotNo(m.get("labelLotNo").toString()); //트레이번호 가져오기
				//List<ProductionPerfTrayVo> trayList = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
				
				//for(ProductionPerfTrayVo t : trayList) {
				goodsDisposeVo.setAbnormalNo(m.get("abnormalNo").toString());
				goodsDisposeVo.setLabelLotNoSeq(m.get("labelLotNo").toString());
				//솔브레인일경우
				goodsDisposeVo.setBoxNo(m.get("labelLotNo").toString());
				//goodsDisposeVo.setTrayNo(t.getTrayNo().toString());
				goodsDisposeVo.setEquipCd(m.get("equipCd").toString());
				goodsDisposeVo.setWorkChargr(m.get("workChargr").toString());
				goodsDisposeVo.setInspctChargr(m.get("inspctChargr").toString());
				goodsDisposeVo.setGoodsCd(m.get("goodsCd").toString());
				goodsDisposeVo.setLotNo(m.get("matrlLotNo").toString());
				goodsDisposeVo.setFilmLotNo(m.get("filmLotNo").toString());
				goodsDisposeVo.setInspctDate(m.get("inspctDate").toString());
				goodsDisposeVo.setProductDate(m.get("productDate").toString());
				goodsDisposeVo.setAbnormalCnt(m.get("abnormalCnt").toString());
				goodsDisposeVo.setProductQty(m.get("productQty").toString());
				goodsDisposeVo.setDepartmentCd(m.get("departmentCd").toString());
				goodsDisposeVo.setFaultyCnt(m.get("faultyCnt").toString());
				goodsDisposeVo.setDisposeGubun("002");
				goodsDisposeVo.setRegId(Utils.getUserId());
				
				goodsDisposeService.createDtl(goodsDisposeVo);				//}
				
				shipInspectVo.setTrayNo(m.get("labelLotNo").toString());
				List<ShipInspectVo> shipList = shipInspectService.shipInspAdmRead(shipInspectVo);
				shipInspectVo = shipList.get(0);
				shipInspectVo.setDisStatus("003");				
				shipInspectVo.setGubun("001");
				shipInspectService.shipAdmDisStatusUpdate(shipInspectVo);
				
			}
			
		
			
			
			jsonData.put("result", "ok");
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//폐기지정
	@RequestMapping(value = "qm/goodsDisposeAppoint", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsDisposeAppoint(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		ShipInspectVo shipInspectVo = new ShipInspectVo();
		GoodsDisposeVo goodsDisposeVo = new GoodsDisposeVo();
		GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
		
		try {			
		
			for(Map<String, Object> m : list) {
				goodsDisposeVo = new GoodsDisposeVo();
				shipInspectVo = new ShipInspectVo();

				//goodsDisposeVo.setAbnormalNo(m.get("abnormalNo").toString());
				goodsDisposeVo.setLabelLotNoSeq(m.get("labelLotNo").toString());
				goodsDisposeVo.setAppointDate(DateUtil.getToday("yyyyMMdd").toString());
				goodsDisposeVo.setDisposeGubun("003");
				goodsDisposeVo.setUpdId(Utils.getUserId());				
				goodsDisposeService.updateDisposeGubun(goodsDisposeVo);				//}
				
				shipInspectVo.setTrayNo(m.get("labelLotNo").toString());
				List<ShipInspectVo> shipList = shipInspectService.shipInspAdmRead(shipInspectVo);
				shipInspectVo = shipList.get(0);
				shipInspectVo.setUpdId(Utils.getUserId());
				shipInspectVo.setDisStatus("004");
				shipInspectVo.setGubun("001");
				shipInspectService.shipAdmDisStatusUpdate(shipInspectVo);
				
				goodsProductInfoAdmVo.setBoxNo(m.get("labelLotNo").toString());	
				goodsProductInfoAdmVo.setAppointDate(DateUtil.getToday("yyyyMMdd").toString());
				goodsProductInfoAdmVo.setDisposeGubun("003");
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				
				goodsPackService.updateDisAppoint(goodsProductInfoAdmVo);
				
			}

			jsonData.put("result", "ok");		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//폐기지정 취소
	@RequestMapping(value = "qm/goodsDisposeCancel", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsDisposeCancel(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		ShipInspectVo shipInspectVo = new ShipInspectVo();
		GoodsDisposeVo goodsDisposeVo = new GoodsDisposeVo();
		GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
		
		try {			
		
			for(Map<String, Object> m : list) {
				goodsDisposeVo = new GoodsDisposeVo();
				shipInspectVo = new ShipInspectVo();

				//goodsDisposeVo.setAbnormalNo(m.get("abnormalNo").toString());
				goodsDisposeVo.setLabelLotNoSeq(m.get("labelLotNo").toString());
				goodsDisposeVo.setAppointDate("");
				goodsDisposeVo.setDisposeGubun("002");
				goodsDisposeVo.setUpdId(Utils.getUserId());				
				goodsDisposeService.updateDisposeGubun(goodsDisposeVo);				//}
				
				shipInspectVo.setTrayNo(m.get("labelLotNo").toString());
				List<ShipInspectVo> shipList = shipInspectService.shipInspAdmRead(shipInspectVo);
				shipInspectVo = shipList.get(0);
				shipInspectVo.setUpdId(Utils.getUserId());
				shipInspectVo.setDisStatus("003");
				shipInspectVo.setGubun("001");
				shipInspectService.shipAdmDisStatusUpdate(shipInspectVo);
				
				goodsProductInfoAdmVo.setBoxNo(m.get("labelLotNo").toString());	
				goodsProductInfoAdmVo.setAppointDate("");
				goodsProductInfoAdmVo.setDisposeGubun("002");
				goodsProductInfoAdmVo.setUpdId(Utils.getUserId());
				goodsPackService.updateDisAppoint(goodsProductInfoAdmVo);
				
			}

			jsonData.put("result", "ok");		
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//Leakage Dstry File Dtl 다운로드
	@RequestMapping(value = "qm/downloadDisposeFile", method = RequestMethod.GET)
	public @ResponseBody void downloadDisposeFile(HttpServletResponse res, HttpServletRequest req,
		    @RequestParam(value = "abnormalNo") String abnormalNo,
		    @RequestParam(value = "fileNm") String fileNm,

		    ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		try {

			String dFile="";
			
			dFile = abnormalNo;

			String newFileName = dFile + '.' + fileNm.substring(fileNm.lastIndexOf(".")+1);;

			String path = disposeFilePath + dFile + "/" + newFileName;

			File file = new File(path);
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				fileNm = URLEncoder.encode(fileNm, "UTF-8").replaceAll("\\+", "%20");
			} else {
				fileNm = new String(fileNm.getBytes("UTF-8"), "ISO-8859-1");
			}

			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + fileNm + "\";");

			FileInputStream fis 		= new FileInputStream(file);
			BufferedInputStream bis		= new BufferedInputStream(fis);
			ServletOutputStream so		= res.getOutputStream();
			BufferedOutputStream bos	= new BufferedOutputStream(so);

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
	
//	goodsProductInfoAdmVo.setBoxNo(m.get("labelLotNoSeq").toString());
//	goodsProductInfoAdmVo = goodsPackService.readGoodsProductInfo(goodsProductInfoAdmVo);
//		
//	if("001".equals(goodsProductInfoAdmVo.getGoodsStatus())) {
//		//폐기 등록						
//		
//		//폐기 성공
//		shipInspectVo.setDisStatus("001");
//		shipInspectService.shipAdmDisStatusUpdate(shipInspectVo);
//		
//		goodsProductInfoAdmVo.setFaultyDate(DateUtil.getToday("yyyymmdd"));
//		goodsProductInfoAdmVo.setFaultyType("출하검사폐기");
//		goodsProductInfoAdmVo.setUpdId(Utils.getUserId());				
//		
//		//수불 출고
//		StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//		stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(m.get("goodsCd").toString(), m.get("labelLotNoSeq").toString(),"002","O","007", packCnt, factoryCode);
//		stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -								
//		stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//		stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(m.get("goodsCd").toString(),m.get("labelLotNoSeq").toString(),"002","O","007", packCnt, factoryCode);
//		stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //기존 재고 -
//																				
//		stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//		stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(m.get("goodsCd").toString(), m.get("labelLotNoSeq").toString(),"002","I","010", packCnt, factoryCode);
//		stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //부적합 창고
//		stockPaymentAdmVoMinus = new StockPaymentAdmVo();
//		stockPaymentAdmVoMinus = StockPaymentAdmController.goodsStockPaymentHist(m.get("goodsCd").toString(), m.get("labelLotNoSeq").toString(),"002","I","010", packCnt, factoryCode);
//		stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoMinus); //부적합 창고
//		
//		//폐기
//		goodsPackService.goodsProductDisuse(goodsProductInfoAdmVoRead);				
//		jsonData.put("result", "ok");
//	} 
//	} else {
//		//폐기 실패
//		jsonData.put("result", "fail");
//		jsonData.put("message", "이미 입고/출고된 제품입니다.");
//	}
//	
//	} else {
//		//폐기 실패
//		jsonData.put("result", "fail");
//		jsonData.put("message", "마지막 차수가 아닙니다.");
//	}
//				
}