package mes.web.po;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.PrintSizManageVo;
import mes.domain.po.ProductionPerfTrayVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.qm.EdgeGoodsFaultyAdmVo;
import mes.domain.qm.GoodsFaultyAdmVo;
import mes.domain.qm.ShipInspectVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.GoodsPackService;
import mes.service.po.PrintSizManageService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.qm.ShipInspectService;
import mes.web.ut.DateUtil;
import mes.web.ut.Settings;
import mes.web.ut.Utils;

@Controller
public class ProductionPerfTrayController {
	
	public ProductionPerfTrayController() {}
	
	public ProductionPerfTrayController(ProductionPerfTrayService ps, WorkOrdOutputSubService ws, GoodsInspectService gs) {
		productionPerfTrayService	= ps;
		workOrdOutputSubService 	= ws;
		goodsInspectService 		= gs;
	}
		
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject 
	private ProductionPerfTrayService productionPerfTrayService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	@Inject
	private GoodsPackService goodsPackService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private GoodsInspectService goodsInspectService;
	@Inject
	private ShipInspectService shipInspectService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private PrintSizManageService printSizManageService;
	
	
	@Value("${factoryCode}") private String factoryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(ProductionPerfTrayController.class);
	
	
	
	//생산실적트레이 조회
	@RequestMapping(value="po/productionPerfTrayList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			jsonData.put("data", productionPerfTrayList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 삭제할 트레이가 마지막 작지인지 확인
	@RequestMapping(value="po/productionPerfTrayListCheckDelete" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayListCheckDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 삭제할 트레이가 마지막 작지인지 확인 조회 : "+productionPerfTrayVo);
		try {
			String workOrdNo = 	productionPerfTrayVo.getWorkOrdNo();
			productionPerfTrayVo = productionPerfTrayService.productionPerfTrayDeletedWorkOrdNoCheck(productionPerfTrayVo);
			
			//마지막 작지인지 Check
			if(workOrdNo.equals(productionPerfTrayVo.getWorkOrdNo())) {
				jsonData.put("data", productionPerfTrayVo);
				jsonData.put("result", "ok");	
			} else {
				jsonData.put("message", "마지막 작지만 삭제가 가능합니다.<br>마지막 작지를 선택 후 진행 해주세요.");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 프린터 조회_F2
	@RequestMapping(value="po/productionPerfTrayPrintList_F2" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayPrintList_F2(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 프린터 조회 : "+productionPerfTrayVo);
		try {
			// JSONArray jsonArray = new JSONArray();
			JSONParser jsonParser		= new JSONParser();
			JSONObject jsonObj			= new JSONObject();
			JSONArray jsonArray			= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
			JSONArray jsonArrayData 	= new JSONArray();
			JSONArray jsonArrayAllData	= new JSONArray();
			
			String image		= "";
			String equipGubun	= "S".equals(productionPerfTrayVo.getEquipNm()) ? "Ⓢ" : "Ⓓ";	//jsp에서 문자열 잘라 'S', 'D'로 보내줌
			
			ProductionPerfTrayVo productionPerfTrayVoDtl = new ProductionPerfTrayVo();
			
			//라벨 출력 값 만들어주는 부분
			for(int i=0; i<jsonArray.size(); i++ ) {
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				productionPerfTrayVoDtl.setLabelLotNo( jsonObjDtl.get("labelLotNo").toString() );
				productionPerfTrayVoDtl.setFactoryCode( "002" );
				List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayPrintList(productionPerfTrayVoDtl);
				
				jsonArrayData = new JSONArray();
				
				jsonArrayData.add( productionPerfTrayList.get(0).getGoodsNm() ); 		//제품 정보
				jsonArrayData.add( productionPerfTrayList.get(0).getProductPartQty() );	//총 수량
				jsonArrayData.add( productionPerfTrayList.get(0).getTrayNo1() ); 		//트레이 정보1
				jsonArrayData.add( productionPerfTrayList.get(0).getTrayNo2() ); 		//트레이 정보2
				jsonArrayData.add( productionPerfTrayList.get(0).getTrayNo3() ); 		//트레이 정보3
				jsonArrayData.add( productionPerfTrayList.get(0).getLabelLotNo() ); 	//BOX_NO
				jsonArrayData.add( productionPerfTrayList.get(0).getLabelLotNoSeq() ); 	//라벨로트시퀀스
				jsonArrayData.add( productionPerfTrayList.get(0).getMatrlGubunNm()  ); 	//재질
				
				jsonArrayData.add( equipGubun  ); 	//듀얼&싱글 구분자
				
				//자재명 판단          
                if (productionPerfTrayList.get(0).getGoodsCd().substring(0,1).equals("A")){
                   jsonArrayData.add( "Cathode Tab"  ); 	//제품 정보2
                } else if ( productionPerfTrayList.get(0).getGoodsCd().substring(0,1).equals("N")){
                	jsonArrayData.add( "Anode Tab"  ); 	//제품 정보2
                }
                //이미지 판단
                image = "";   
				if(productionPerfTrayList.get(0).getGoodsNm().contains("DE/SK")) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				//HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("HE370")) {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("E370")) {
					//image = "{XQ;03,0,L|}";
					image = "04";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("H200")) {
					//image = "{XQ;09,0,L|}";
					image = "10";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("P260")) {
					//image = "{XQ;11,0,L|}";
					image = "12";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("P395")) {
					//image = "{XQ;13,0,L|}";
					image = "14";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("E556")) {
					//image = "{XQ;15,0,L|}";
					image = "16";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("N60")) {
					//image = "{XQ;17,0,L|}";
					image = "18";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				jsonArrayData.add( image ); 	//이미지 정보
				
				jsonArrayAllData.add( jsonArrayData );
				jsonArrayData = new JSONArray();

				jsonArrayData.add( productionPerfTrayList.get(1).getGoodsNm() ); 		//제품 정보
				jsonArrayData.add( productionPerfTrayList.get(1).getProductPartQty() );	//총 수량
				jsonArrayData.add( productionPerfTrayList.get(1).getTrayNo4() ); 		//트레이 정보4
				jsonArrayData.add( productionPerfTrayList.get(1).getTrayNo5() ); 		//트레이 정보5
				jsonArrayData.add( productionPerfTrayList.get(1).getTrayNo6() ); 		//트레이 정보6
				jsonArrayData.add( productionPerfTrayList.get(1).getLabelLotNo() ); 	//BOX_NO
				jsonArrayData.add( productionPerfTrayList.get(1).getLabelLotNoSeq() ); 	//라벨로트시퀀스
				jsonArrayData.add( productionPerfTrayList.get(1).getMatrlGubunNm()  ); 	//재질
				
				jsonArrayData.add( equipGubun  ); 	//듀얼&싱글 구분자
				
				//자재명 판단          
                if (productionPerfTrayList.get(0).getGoodsCd().substring(0,1).equals("A")){
                   jsonArrayData.add( "Cathode Tab"  ); 	//제품 정보2
                } else if ( productionPerfTrayList.get(0).getGoodsCd().substring(0,1).equals("N")){
                	jsonArrayData.add( "Anode Tab"  ); 	//제품 정보2
                }
                //이미지 판단
                image = "";   
				if(productionPerfTrayList.get(0).getGoodsNm().contains("DE/SK")) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				//HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("HE370")) {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("E370")) {
					//image = "{XQ;03,0,L|}";
					image = "04";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("H200")) {
					//image = "{XQ;09,0,L|}";
					image = "10";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("P260")) {
					//image = "{XQ;11,0,L|}";
					image = "12";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("P395")) {
					//image = "{XQ;13,0,L|}";
					image = "14";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("E556")) {
					//image = "{XQ;15,0,L|}";
					image = "16";
				}
				else if(productionPerfTrayList.get(0).getGoodsNm().contains("N60")) {
					//image = "{XQ;17,0,L|}";
					image = "18";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "98";
				}
				jsonArrayData.add( image  ); 	//이미지 정보
				
				jsonArrayAllData.add( jsonArrayData );
			}
			logger.info("jsonArrayAllData ----> "+jsonArrayAllData);
			
			jsonData.put("data", jsonArrayAllData);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//생산실적트레이 프린터 조회_F3
	@RequestMapping(value="po/productionPerfTrayPrintList_F3" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayPrintList_F3(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 프린터 조회 : "+productionPerfTrayVo);
		try {
			// JSONArray jsonArray = new JSONArray();
			JSONParser jsonParser		= new JSONParser();
			JSONObject jsonObj			= new JSONObject();
			JSONArray jsonArray			= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
			JSONArray jsonArrayData 	= new JSONArray();
			JSONArray jsonArrayAllData	= new JSONArray();
			String image = "";
			
			ProductionPerfTrayVo productionPerfTrayVoDtl = new ProductionPerfTrayVo();
			
			//라벨 출력 값 만들어주는 부분
			for(int i=0; i<jsonArray.size(); i++ ) {
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				productionPerfTrayVoDtl.setLabelLotNo( jsonObjDtl.get("labelLotNo").toString() );
				productionPerfTrayVoDtl.setFactoryCode( "003" );
				List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayPrintList(productionPerfTrayVoDtl);
				
				//1번째 값 담아주는 부분 시작
				jsonArrayData = new JSONArray();
				
				jsonArrayData.add( productionPerfTrayList.get(0).getLabelLotNo() ); 	//BOX_XO
				jsonArrayData.add( productionPerfTrayList.get(0).getGijongNm() ); 		//기종별_NM
				jsonArrayData.add( productionPerfTrayList.get(0).getMatrlGubunNm()  ); 	//재질
				jsonArrayData.add( productionPerfTrayList.get(0).getProductQty() );		//한 개 수량

				//이미지 판단
				if("001".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				else if("002".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;97,0,L|}";
					image = "10";
				}
				else if("003".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;03,0,L|}";
					image = "12";
				}
				else if("004".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;09,0,L|}";
					image = "20";
				}
				else if("005".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//i
					image = "22";
				}
				else if("006".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;13,0,L|}";
					image = "04";
				}
				else if("007".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;15,0,L|}";
					image = "24";
				}
				else if("008".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "26";
				}
				else if("009".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "28";
				}
				else if("010".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "30";
				}
				else if("011".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "32";
				}
				else if("013".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "34";
				}
				else if("015".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "36";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "99";
				}
				
				jsonArrayData.add( image  ); 	//이미지 정보
				
				jsonArrayAllData.add( jsonArrayData );
				
				//2번째 값 담아주는 부분 시작
				jsonArrayData = new JSONArray();

				jsonArrayData.add( productionPerfTrayList.get(1).getLabelLotNo() ); 	//BOX_XO
				jsonArrayData.add( productionPerfTrayList.get(1).getGijongNm() ); 		//기종별_NM
				jsonArrayData.add( productionPerfTrayList.get(1).getMatrlGubunNm()  ); 	//재질
				jsonArrayData.add( productionPerfTrayList.get(1).getProductQty() );		//한 개 수량
				
                //이미지 판단
				if("001".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				else if("002".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;97,0,L|}";
					image = "10";
				}
				else if("003".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;03,0,L|}";
					image = "12";
				}
				else if("004".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;09,0,L|}";
					image = "20";
				}
				else if("005".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//i
					image = "22";
				}
				else if("006".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;13,0,L|}";
					image = "04";
				}
				else if("007".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;15,0,L|}";
					image = "24";
				}
				else if("008".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "26";
				}
				else if("009".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "28";
				}
				else if("010".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "30";
				}
				else if("011".equals(productionPerfTrayList.get(1).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "32";
				}
				else if("013".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "34";
				}
				else if("015".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "36";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "99";
				}
				jsonArrayData.add( image  ); 	//이미지 정보
				
				jsonArrayAllData.add( jsonArrayData );
				
				//3번째 값 담아주는 부분 시작
				jsonArrayData = new JSONArray();

				jsonArrayData.add( productionPerfTrayList.get(2).getLabelLotNo() ); 	//BOX_XO
				jsonArrayData.add( productionPerfTrayList.get(2).getGijongNm() ); 		//기종별_NM
				jsonArrayData.add( productionPerfTrayList.get(2).getMatrlGubunNm()  ); 	//재질
				jsonArrayData.add( productionPerfTrayList.get(2).getProductQty() );		//한 개 수량
				
                //이미지 판단
				if("001".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;01,0,L|}";
					image = "02";
				}
				else if("002".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;97,0,L|}";
					image = "10";
				}
				else if("003".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;03,0,L|}";
					image = "12";
				}
				else if("004".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;09,0,L|}";
					image = "20";
				}
				else if("005".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//i
					image = "22";
				}
				else if("006".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;13,0,L|}";
					image = "04";
				}
				else if("007".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;15,0,L|}";
					image = "24";
				}
				else if("008".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "26";
				}
				else if("009".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "28";
				}
				else if("010".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "30";
				}
				else if("011".equals(productionPerfTrayList.get(2).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "32";
				}
				else if("013".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "34";
				}
				else if("015".equals(productionPerfTrayList.get(0).getGijongCd())) {
					//image = "{XQ;17,0,L|}";
					image = "36";
				}
				else {
					//image = "{XQ;97,0,L|}";
					image = "99";
				}
				jsonArrayData.add( image  ); 	//이미지 정보
				
				//jsonArrayAllData.add( jsonArrayData );
			}
			logger.info("jsonArrayAllData ----> "+jsonArrayAllData);
			
			jsonData.put("data", jsonArrayAllData);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//생산실적트레이 이전 행&현재 행 조회
	@RequestMapping(value="po/trayInfoBeforeAfterList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> trayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 이전 행&현재 행 조회 : "+productionPerfTrayVo);
		try {
			List<ProductionPerfTrayVo> trayInfoBeforeAfterList = productionPerfTrayService.trayInfoBeforeAfterList(productionPerfTrayVo);
			jsonData.put("data", trayInfoBeforeAfterList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 상세조회
	@RequestMapping(value="po/productionPerfTrayRead" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 상세조회 : "+productionPerfTrayVo);
		try {
			ProductionPerfTrayVo productionPerfTrayRead = productionPerfTrayService.productionPerfTrayRead(productionPerfTrayVo);
			jsonData.put("data", productionPerfTrayRead);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 등록
	@RequestMapping(value="po/productionPerfTrayCreate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> productionPerfTrayCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 등록 : "+productionPerfTrayVo);
		try {
			
			JSONParser jsonParser	= new JSONParser();
			JSONObject jsonObj		= new JSONObject();
			JSONArray jsonArray		= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
			
			//고정 값이라 위에 선언 함
			jsonObj.put(0, jsonArray.get(0));
			JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
			
			String[] trayNo			= new String[21];	//트레이 번호
			String workOrdNo		= productionPerfTrayVo.getWorkOrdNo();	//작지 번호 
			int workOrdSeq 			= productionPerfTrayService.productionPerfTraySeq(productionPerfTrayVo);	//작지 순서
			int productQty			= 0;	//생산 수량(한 트레이 별)
			
			//제품별 생산 수량
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			goodsCodeAdmVo.setGoodsCd( jsonObjDtl.get("goodsCd").toString() );
			goodsCodeAdmVo	= goodsCodeAdmService.read(goodsCodeAdmVo);
			productQty		= Integer.parseInt(goodsCodeAdmVo.getProductQty().toString());
			
			//생산실적트레이 마지막 정보 조회
			ProductionPerfTrayVo lastinfoVo = productionPerfTrayService.productionPerfTrayLastInfo(productionPerfTrayVo);
			
			//생산실적트레이Vo 초기화
			ProductionPerfTrayVo productionPerfTrayVoDtl = new ProductionPerfTrayVo();
			
			//트레이 라벨 10개 저장
			for(int i=0; i<20; i++ ) {
				
				trayNo[i] = workOrdNo + "-T" + (i+1) ;	//트레이 번호 생성
				
				productionPerfTrayVoDtl.setTrayNo(trayNo[i]);										//트레이 번호
				productionPerfTrayVoDtl.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작지 번호
				productionPerfTrayVoDtl.setLastWorkOrdNo( lastinfoVo != null ? lastinfoVo.getWorkOrdNo() : "N" );	//전 작지 번호
				
				productionPerfTrayVoDtl.setEquipCd(jsonObjDtl.get("equipCd").toString());			//설비코드
				
				productionPerfTrayVoDtl.setDayNightCd(jsonObjDtl.get("dayNightCd").toString());		//주야 구분 
				productionPerfTrayVoDtl.setProductDate(jsonObjDtl.get("productDate").toString());	//생산 날짜
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//작업자

				productionPerfTrayVoDtl.setGoodsCd(jsonObjDtl.get("goodsCd").toString());			//제품코드
				productionPerfTrayVoDtl.setMatrlCd(jsonObjDtl.get("matrlCd").toString());			//자재코드
				productionPerfTrayVoDtl.setMatrlLotNo(jsonObjDtl.get("matrlLotNo").toString());		//자재로트
				productionPerfTrayVoDtl.setLastMatrlLotNo( lastinfoVo != null ? lastinfoVo.getMatrlLotNo() : "N" );	//전 작지 번호
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//라벨로트
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//생산전표번호
				
				productionPerfTrayVoDtl.setProductStatus("001");									//생산상태(미완료:001, 생산완료:002, 포장:003)
				productionPerfTrayVoDtl.setProductQty( productQty );								//생산수량
				productionPerfTrayVoDtl.setIncorporationGubun("N");									//혼입구분
				productionPerfTrayVoDtl.setIncorporationVisonGubun("N");							//혼입비전구분
				productionPerfTrayVoDtl.setWorkOrdSeq(workOrdSeq);									//작지순서
				productionPerfTrayVoDtl.setTurnNumber( (i+1) );										//순번
				productionPerfTrayVoDtl.setRegId( Utils.getUserId() );								//등록자
				
				//생산실적트레이테이블 등록
				productionPerfTrayService.productionPerfTrayCreate(productionPerfTrayVoDtl);
			}
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 수정 (작업지시선태 - 트레이 모달 저장 처리 시)
	@RequestMapping(value="po/productionPerfTrayUpdate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> productionPerfTrayUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 수정 : "+productionPerfTrayVo);
		logger.info("생산실적트레이 수정  arrayData : "+productionPerfTrayVo.getArrayData());
		try {
			
			Settings singletonSettings = Settings.getInstance();
			//2공장 트레이 생산 기능 잠금 O
			//if(factoryCode.equals("002")) {
				if( singletonSettings.lockTrayProduce ) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("002");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;								
				}
			//}
			
			
			logger.info("Array 확인 -> "+Arrays.asList(singletonSettings.useTrayProduceArray));

			int arrayLastNum = Arrays.asList(singletonSettings.useTrayProduceArray).indexOf(null);	//배열에 마지막 번호 가지고 오기
			boolean checkWorkOrderNo = Arrays.asList(singletonSettings.useTrayProduceArray).contains(productionPerfTrayVo.getWorkOrdNo()); //트레이 기존 배열에 현 작지가 존재하는지 확인
			
			logger.info("sudel -------------------------------------------> " +checkWorkOrderNo);
			logger.info("singletonSettings.useTrayProduce -------------------------------------------> " +singletonSettings.useTrayProduce);
			
			//싱글톤 트레이 생산 사용중이 아니라면
			if ( !singletonSettings.useTrayProduce || !checkWorkOrderNo ) {
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 사용으로 변경
				singletonSettings.useTrayProduce = true;
				//어떤 작지가 작업 중인지 표시
				singletonSettings.useTrayProduceArray[arrayLastNum] = productionPerfTrayVo.getWorkOrdNo();
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				
				
				//트레이 수정 시작
				JSONParser jsonParser	= new JSONParser();
				JSONObject jsonObj		= new JSONObject();
				JSONArray jsonArray		= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
				JSONArray labelLotArray	= new JSONArray();
				
				int allCount 			= jsonArray.size();							//생산실적트레이 전체 개수
				String date				= productionPerfTrayVo.getProductDate();	//생산 날짜
				String equipCd			= productionPerfTrayVo.getEquipCd();		//생산 설비 코드
				String equipNm			= productionPerfTrayVo.getEquipNm();		//생산 설비 이름
				String lgesGubun		= productionPerfTrayVo.getLgesGubun();		//생산 설비 이름
				logger.info("Vo 값 확인 하는 부분 :::::::::::::::::::: " +productionPerfTrayVo.getProductDate());
				
				
				
				//최초 LGES 코드를 이렇게하는 이유: 최초LGES코드를 알기 위해서 / 첫 트레이 기준으로 문자열을 잘라보면 작지번호이다. 
				//죄초로 발행된 작지번호를 가지고 첫 줄만 혼입이 가능하니 6개 이후부터는 현 존재하는 작지번호를 사용하면 된다.
				//고정 값이라 위에 선언 함
				jsonObj.put(0, jsonArray.get(0));
				JSONObject tempJsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
				String tempWorkOrdNo	= "";
				String tempDate			= "";

				//LGES인 경우에만
				if( "Y".equals(lgesGubun) ) {
					tempWorkOrdNo	= tempJsonObjDtl.get("trayNo").toString().substring(0, tempJsonObjDtl.get("trayNo").toString().lastIndexOf("-"));
					tempDate		= tempWorkOrdNo.substring(0, tempJsonObjDtl.get("trayNo").toString().indexOf('-'));
					tempDate = tempDate.substring(tempDate.length()-6, tempDate.length());
					logger.info("데이터 확인하는 값 ----------------------> " + tempJsonObjDtl.get("trayNo").toString());
				}
				
				//LGES 관련 코드
				ProductionPerfTrayVo lgesCodeVo = new  ProductionPerfTrayVo();
				if( "Y".equals(lgesGubun) ) {
					lgesCodeVo.setWorkOrdNo(tempWorkOrdNo);
					lgesCodeVo.setCutOrdDate(tempDate);
					lgesCodeVo = productionPerfTrayService.trayLgesCodeSeq(lgesCodeVo);
					//LGES 관련 코드
				}
				
				
				//생산실적6개라벨트레이번호 부여
				ProductionPerfTrayVo sudel = new  ProductionPerfTrayVo();
				sudel.setFactoryCode(factoryCode);
				if( "Y".equals(lgesGubun) ) {
					sudel.setProductDate( factoryCode.equals("003") ? tempDate : date);
				} else {
					sudel.setProductDate( factoryCode.equals("003") ? date.substring(2) : date);					
				}
				
				sudel.setEquipCd(equipCd);
				sudel = productionPerfTrayService.productionPerfTrayLabelSeq(sudel);
				//생산실적6개라벨트레이번호 부여
				
				
				logger.info("Vo 값 확인 하는 부분 22:::::::::::::::::::: " +productionPerfTrayVo.getProductDate());
				
				//String labelSeqNumber	= productionPerfTrayService.productionPerfTrayLabelSeq(productionPerfTrayVo);	//라벨 시퀀스
				String labelSeqNumber	= sudel.getBoxNo();
				String labelLotNo		= "";	//라벨로트 번호
				String mainLabelLotNo	= "";	//라벨로트 번호
				String workOrdNo		= productionPerfTrayVo.getWorkOrdNo();
				
				String lgesSeq			= lgesCodeVo.getLgesCode();
				String lgesCode			= "";
				String lgesCodeInfo		= "";
				
				//LGES인 경우에만
				if( "Y".equals(lgesGubun) ) {
					lgesCode		= equipNm.replace("-", "");
					//lgesCodeInfo	= lgesCode.substring(0, lgesCode.length()-1) + "_" + lgesCode.substring(lgesCode.length()-1, lgesCode.length()) + "_" + tempDate + "_D0";
					lgesCodeInfo	= lgesCode.substring(0, lgesCode.length()-1) + "-" + lgesCode.substring(lgesCode.length()-1, lgesCode.length()) + "-" + tempDate + "-D0";
					lgesCode		= lgesCodeInfo + lgesSeq;
					//logger.info("lgesCode >>>>>>>>>> " + lgesCode);					
				}
				
				//String equipNm			= productionPerfTrayVo.getWorkOrdNo();
				
				if( factoryCode.equals("001") || factoryCode.equals("002") ) {
					mainLabelLotNo = date +"-";
				} else {
					//labelLotNo = productionPerfTrayVo.getEquipNm().replace("-", "") + productionPerfTrayVo.getQutyNm() + "-" + productionPerfTrayVo.getGoodsInitial() + productionPerfTrayVo.getOrdDate() + productionPerfTrayVo.getDayNightCd();
					mainLabelLotNo = productionPerfTrayVo.getLabelLotNo();
				}
				
				
				//변경된 값 존재하는지 상태 확인
				boolean functionSudelCheck = trayStatusCheck( jsonArray, productionPerfTrayVo.getEquipCd(), productionPerfTrayVo.getWorkOrdNo(), "001", lgesGubun, productionPerfTrayVo.getProductDate() );
				logger.info("functionSudelCheck_________________----------------> " + functionSudelCheck);
				
				if( functionSudelCheck ) {
					singletonSettings.useTrayProduce = false;
					singletonSettings.useTrayProduceArray[arrayLastNum] = null;
					
					jsonData.put("message", "현재 트레이 상태가 변경 되었습니다.<br>다시 시도해주세요.");
					jsonData.put("result", "fail");
					return jsonData;
				}
				
				
				//생산실적트레이Vo 초기화
				ProductionPerfTrayVo trayExistingData	= new ProductionPerfTrayVo(); 	//트레이 기존 데이터
				ProductionPerfTrayVo trayVoDtl	= new ProductionPerfTrayVo();

				String labelLotNoSeq	= "";	//라벨 시퀀스
//				String goodsCd			= "";	//제품코드
//				String productStatus	= "";	//트레이 상태 값
//				String trayNumber		= "";	//트레이 순번
//				
//				int productQty			= 0;	//트레이 수량 (1T)
				
				int productPartQty		= 0;	//부분 트레이 생산 수랴(3T)
				int labelLotNoSeqCount	= 1;	//시퀀스 카운드(보조, 3T)
				int outputTotalCnt		= 0;	//전체 수량(live)
				
				int i = 0;	//jsonObj 증가 값(보조)
				
				/*
				 * 1) 전체 수량  % 6 == 0 인 경우 6T 씩 저장 가능해 첫번째 조건.
				 * - 조건 : 포장 상태가 아닌 상태.
				 * - 3T씩 라벨 시퀀스 부여, 6T씩 라벨 번호 부여.
				 * 2) 전체 수량  % 6 != 0 인 경우  6T 씩 저장 불가능 두 번째 조건.
				 * - 조건 : 포장 상태가 아닌 상태.
				 * - 저장되고 남은 값이 6보다 큰 경우 3T씩 라벨 시퀀스 부여, 6T씩 라벨 번호 부여.
				 * - 저장되고 남은 값이 6보다 작은 경우 라벨 번호, 시퀀스 부여 안함. +데이터만 저장 처리
				*/
				
				String firstLgesMainLabelLotNo = mainLabelLotNo.replace(date.substring(2), tempDate); 
				/*mainLabelLotNo.substring(mainLabelLotNo.indexOf('-')+1, mainLabelLotNo.length()-1);
				firstLgesMainLabelLotNo = firstLgesMainLabelLotNo.substring(firstLgesMainLabelLotNo.length()-6, firstLgesMainLabelLotNo.length());*/
				
				//트레이 라벨 저장하는 부분
				if(allCount % 6 == 0) {
					//★★★★★★★★★★★★★★★★★★★★★★★★나머지가 없는 경우 처리★★★★★★★★★★★★★★★★★★★★★★★★
					for(int cleanNo=1; cleanNo<=allCount; cleanNo++) {
						jsonObj.put(i, jsonArray.get(i));
						JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
						
						//시작
						trayVoDtl = new ProductionPerfTrayVo();
						trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );
						trayVoDtl = productionPerfTrayService.productionPerfTrayRead(trayVoDtl);
						trayExistingData = trayVoDtl;	//read한 값 담아주기
						
//						productQty		= 0;	//트레이 수량
//						goodsCd			= "";	//제품코드
//						productStatus	= "";	//상태 값
//						trayNumber		= "";	//트레이 순번
//						
//						productQty		= trayVoDtl.getProductQty();
//						goodsCd			= trayVoDtl.getGoodsCd();
//						productStatus	= trayVoDtl.getProductStatus();
//						trayNumber		= trayVoDtl.getTrayNo();
						
						//포장이 아닌경우에만 수정 가능 함
						if( trayVoDtl.getProductStatus().equals("001") || trayVoDtl.getProductStatus().equals("002") ) {
							trayVoDtl = new ProductionPerfTrayVo();
							
							//labelLotNo = date +"-"+ labelSeqNumber;	//라벨로트 생성 부여
							
							if(factoryCode.equals("003") && "Y".equals(lgesGubun) && i < 6 ) {
								labelLotNo = firstLgesMainLabelLotNo + labelSeqNumber;	//라벨로트 생성 부여
							} else {
								labelLotNo = mainLabelLotNo + labelSeqNumber;	//라벨로트 생성 부여
							}
							
							//LGES_코드부여
							if( "Y".equals(lgesGubun) ) {
								lgesCode = lgesCodeInfo + lgesSeq;
							}
							
							//라벨로트시퀀스생성
							if(labelLotNoSeqCount >= 0 && labelLotNoSeqCount <= 3) {
								labelLotNoSeq = labelLotNo + "-1";
								
								productPartQty += trayExistingData.getProductQty();	//트레이 수량(3개씩 합친 값)
								
								//생산 실적 테이블 값 저장
								if( labelLotNoSeqCount == 3 ) {
									
									GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
									
									goodsProductInfoAdmVo.setBoxNo(labelLotNoSeq);						//포장 번호
									goodsProductInfoAdmVo.setGoodsCd(trayExistingData.getGoodsCd());										//제품 코드
									goodsProductInfoAdmVo.setOrdGubun("003");										//오더 구분
									goodsProductInfoAdmVo.setPackCnt(productPartQty);								//포장 수량
									goodsProductInfoAdmVo.setPackDate(jsonObjDtl.get("productDate").toString());	//포장 일자*
									goodsProductInfoAdmVo.setGoodsInDate(jsonObjDtl.get("productDate").toString());	//제품입고일*
									goodsProductInfoAdmVo.setRemainCnt(productPartQty);								//남은 수량
									goodsProductInfoAdmVo.setGoodsStatus("001");									//제품 입출고 상태
									goodsProductInfoAdmVo.setFaultyStatus("001");									//제품 정상/불량 상태
									goodsProductInfoAdmVo.setDisuseYn("N");											//제품폐기여부
									goodsProductInfoAdmVo.setDivisionYn("N");										//제품재분할/재병합 여부								
									goodsProductInfoAdmVo.setRegId(Utils.getUserId());								//등록자
									goodsProductInfoAdmVo.setHistId(Utils.getUserId());								//기록자
									
									//DTL 추가 정보
									goodsProductInfoAdmVo.setBoxSeq(1);												//포장 번호 시퀀스
									goodsProductInfoAdmVo.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작업지시번호
									goodsProductInfoAdmVo.setWorkOrdLotNo(labelLotNoSeq);							//생산LotNo
									goodsProductInfoAdmVo.setOrdLotNo(labelLotNoSeq);								//생산전표번호
									goodsProductInfoAdmVo.setPackDtlCnt(productPartQty);							//포장상세수량
									goodsProductInfoAdmVo.setPrintYn("Y");											//바코드 출력 여부
									
									//TMP
									goodsProductInfoAdmVo.setPackNumber(labelLotNoSeq);								//미포장으로 변경 전표일자
									goodsProductInfoAdmVo.setPackRemainCnt(productPartQty);							//TMP_잔량
									
									//생산실적라벨발행등록_ADM
									// goodsPackService.createGoodsLabelPublish(goodsProductInfoAdmVo);
									
									//생산실적라벨발행등록_DTL
									// goodsPackService.createGoodsLabelPublishDtl(goodsProductInfoAdmVo);
									
									//생산실적라벨발행등록_HIST
									// goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);	//SELECT UPDATE
									
									//생산실적라벨발행등록_TMP
									// goodsPackService.createGoodsLabelTmp(goodsProductInfoAdmVo);
									
									//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
									/* StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
									createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(trayExistingData.getGoodsCd(), labelLotNoSeq, "002", "I", "007", productPartQty, factoryCode);	
									stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);*/
									
									 
									productPartQty = 0;
								}
								//생산 실적 테이블 값 저장 끝
							}
							if(labelLotNoSeqCount >= 4 && labelLotNoSeqCount <= 6) {
								labelLotNoSeq = labelLotNo + "-2";
								productPartQty += trayExistingData.getProductQty();	//트레이 수량(3개씩 합친 값)
								
								if(labelLotNoSeqCount == 6) {
									labelLotNoSeqCount = 0;
									
									//생산 실적 테이블 값 저장 시작
									GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
									
									goodsProductInfoAdmVo.setBoxNo(labelLotNoSeq);									//포장 번호
									goodsProductInfoAdmVo.setGoodsCd(trayExistingData.getGoodsCd());										//제품 코드
									goodsProductInfoAdmVo.setOrdGubun("003");										//오더 구분
									goodsProductInfoAdmVo.setPackCnt(productPartQty);								//포장 수량
									goodsProductInfoAdmVo.setPackDate(jsonObjDtl.get("productDate").toString());	//포장 일자*
									goodsProductInfoAdmVo.setGoodsInDate(jsonObjDtl.get("productDate").toString());	//제품입고일*
									goodsProductInfoAdmVo.setRemainCnt(productPartQty);								//남은 수량
									goodsProductInfoAdmVo.setGoodsStatus("001");									//제품 입출고 상태
									goodsProductInfoAdmVo.setFaultyStatus("001");									//제품 정상/불량 상태
									goodsProductInfoAdmVo.setDisuseYn("N");											//제품폐기여부
									goodsProductInfoAdmVo.setDivisionYn("N");										//제품재분할/재병합 여부								
									goodsProductInfoAdmVo.setRegId(Utils.getUserId());								//등록자
									goodsProductInfoAdmVo.setHistId(Utils.getUserId());								//기록자
									
									//DTL 추가 정보
									goodsProductInfoAdmVo.setBoxSeq(1);												//포장 번호 시퀀스
									goodsProductInfoAdmVo.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작업지시번호
									goodsProductInfoAdmVo.setWorkOrdLotNo(labelLotNoSeq);							//생산LotNo
									goodsProductInfoAdmVo.setOrdLotNo(labelLotNoSeq);								//생산전표번호
									goodsProductInfoAdmVo.setPackDtlCnt(productPartQty);							//포장상세수량
									goodsProductInfoAdmVo.setPrintYn("Y");											//바코드 출력 여부
									
									//TMP
									goodsProductInfoAdmVo.setPackNumber(labelLotNoSeq);								//미포장으로 변경 전표일자
									goodsProductInfoAdmVo.setPackRemainCnt(productPartQty);							//TMP_잔량
									
									//생산실적라벨발행등록_ADM
									// goodsPackService.createGoodsLabelPublish(goodsProductInfoAdmVo);
									
									//생산실적라벨발행등록_DTL
									// goodsPackService.createGoodsLabelPublishDtl(goodsProductInfoAdmVo);
									
									//생산실적라벨발행등록_HIST
									// goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);	//SELECT UPDATE
									
									//생산실적라벨발행등록_TMP
									// goodsPackService.createGoodsLabelTmp(goodsProductInfoAdmVo);
									
									//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
									/* StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
									createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(trayExistingData.getGoodsCd(), labelLotNoSeq, "002", "I", "007", productPartQty, factoryCode);	
									stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);*/
									
									//출하 검사 등록
									ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
									shipInspectAdmVo.setTrayNo(labelLotNo);
									shipInspectAdmVo.setTrayNo1(labelLotNo + "-1");
									shipInspectAdmVo.setTrayNo2(labelLotNo + "-2");
									
									if( "Y".equals(lgesGubun) ) {
										if( !"".equals( jsonObjDtl.get("lgesCode").toString() ) ) {
											//LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분
											String[] lgesCodeSplit = jsonObjDtl.get("lgesCode").toString().split("-");
											String changeLgesCode = labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]));
											shipInspectAdmVo.setTrayNo(changeLgesCode);
											shipInspectAdmVo.setTrayNo1(changeLgesCode + "-1");
											shipInspectAdmVo.setTrayNo2(changeLgesCode + "-2");
										} else {
											//LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 
											String[] lgesCodeSplit = lgesCode.split("-");
											String changeLgesCode = labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]));
											shipInspectAdmVo.setTrayNo(changeLgesCode);
											shipInspectAdmVo.setTrayNo1(changeLgesCode + "-1");
											shipInspectAdmVo.setTrayNo2(changeLgesCode + "-2");
										}
									}
									
									shipInspectAdmVo.setWorkOrdNo( jsonObjDtl.get("workOrdNo").toString() );
									shipInspectAdmVo.setMatrlLotNo( jsonObjDtl.get("matrlLotNo").toString() );
									shipInspectAdmVo.setFilmLotNo( trayExistingData.getFilmLotNo() );
									shipInspectAdmVo.setProductDate( jsonObjDtl.get("productDate").toString() );
									shipInspectAdmVo.setDayNightCd(jsonObjDtl.get("dayNightCd").toString());

									//shipInspectAdmVo.setInspStatus();
									shipInspectAdmVo.setReInspStatus("001");
									//shipInspectAdmVo.setDisStatus();
									//shipInspectAdmVo.setInspDate( date );
									shipInspectAdmVo.setFaultyCnt("0");
									//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
									//shipInspectAdmVo.setInspChargr(inspChargr);
									//shipInspectAdmVo.setDayNightCd(dayNightGubun);
									//shipInspectAdmVo.setFaultyGubun(faultyGubun);
									shipInspectAdmVo.setNextGubun("001");
									shipInspectAdmVo.setSeq("1");
//									shipInspectAdmVo.setRegId( Utils.getUserId() );
//									String seq = shipInspectService.selectTraySeq(shipInspectAdmVo);
									//shipInspectAdmVo.setSeq(seq);
									
									shipInspectService.shipAdmCreate(shipInspectAdmVo);
									//출하 검사 등록 끝
									
									productPartQty = 0;
									//생산 실적 테이블 값 저장 끝
									
								}								
							}
							//라벨로트 시퀀스 끝
							
							trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );	//트레이번호
							if( trayExistingData.getProductStatus().equals("001") ) {
								
								//첫번째 트레이는 무조건 메탈 혼입으로 변경
//								if( trayExistingData.getTurnNumber() == 1 ) {
//									trayVoDtl.setIncorporationGubun("Y");
//								}
								
								trayVoDtl.setChangeTrayNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//변경되는 트레이번호
								trayVoDtl.setTrayWorkerId( jsonObjDtl.get("trayWorkerId").toString() );	//작업자
								trayVoDtl.setProductDate( jsonObjDtl.get("productDate").toString() );	//작업일자
								trayVoDtl.setDayNightCd( jsonObjDtl.get("dayNightCd").toString() );		//주야 구분
								
								//작업지시 생산수량 서브	_insert
								WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
								workOrdOutputSubVo.setWorkOrdNo( jsonObjDtl.get("workOrdNo").toString() );				//작업지시번호
								workOrdOutputSubVo.setWorkOrdLotNo( jsonObjDtl.get("workOrdNo").toString() );			//생산LotNo
								workOrdOutputSubVo.setWorkOrdSeq( Integer.toString(trayExistingData.getTurnNumber()) );	//시퀀스
								// workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//작지 LotNo
								workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("workOrdNo").toString() +"-T" );			//작지 LotNo
								workOrdOutputSubVo.setLotNo( trayExistingData.getMatrlLotNo() );						//주자재 LotNo
								workOrdOutputSubVo.setSubWorkStatusCd("A");												//작업 상태
								workOrdOutputSubVo.setOutputCnt( trayExistingData.getProductQty() );					//생산수량
								workOrdOutputSubVo.setGubun( jsonObjDtl.get("dayNightCd").toString() );					//주/야 구분
								workOrdOutputSubVo.setWorkOrdDate( jsonObjDtl.get("productDate").toString() );			//전표일자
								workOrdOutputSubVo.setMainWorkChargr( jsonObjDtl.get("trayWorkerId").toString() );		//담당자
								workOrdOutputSubVo.setPackYn("Y");														//포장 여부
								workOrdOutputSubVo.setRegId( Utils.getUserId() );										//등록자

								//작업지시 생산수량 서브 저장
								//workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
								//작업지시 생산수량 서브	_insert 끝
							}
							
							//String[] lgesCodeSplit = jsonObjDtl.get("lgesCode").toString().split("-");
							//labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]) );
							
							
							trayVoDtl.setLabelLotNo(labelLotNo);		//라벨로트
							trayVoDtl.setLabelLotNoSeq(labelLotNoSeq);	//라벨로트시퀀스
							
							if( "Y".equals(lgesGubun) ) {
								if( !"".equals( jsonObjDtl.get("lgesCode").toString() ) ) {
									////LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 (객체 전달 시 객체에 대한 참조가 복사됨(얕은 복사))
									processLabel(jsonObjDtl.get("lgesCode").toString(), labelLotNo, labelLotNoSeq, trayVoDtl);
								} else {
									////LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 (객체 전달 시 객체에 대한 참조가 복사됨(얕은 복사))
									processLabel(lgesCode, labelLotNo, labelLotNoSeq, trayVoDtl);
								}
							}
							
							trayVoDtl.setProductStatus("003");			//생산상태(미완료:001, 생산완료:002, 포장:003)
							trayVoDtl.setUpdId( Utils.getUserId() );	//수장자
							labelLotArray.add( labelLotNo );			//만들어진 labelLotNo 값 담아주기
							labelLotNoSeqCount++;
							//생산실적트레이테이블 수정
							productionPerfTrayService.productionPerfTrayUpdate(trayVoDtl);
							trayVoDtl.setEquipCd(equipCd);
							//trayVoDtl.setWorkOrdNo(workOrdNo);
							productionPerfTrayService.lgesPrintWhetherUpdate(trayVoDtl);
						}
						
				        //트레이번호 값 담아주는 부분
				        if( cleanNo >= 6 ) {
				        	sudel.setFactoryCode(factoryCode);
				        	sudel.setProductDate( factoryCode.equals("003") ? date.substring(2) : date);
							sudel.setEquipCd(equipCd);
				        	sudel = productionPerfTrayService.productionPerfTrayLabelSeq( sudel );
				        	//라벨 시퀀스 업데이트
				        	labelSeqNumber = sudel.getBoxNo();
				        	
				        	if( "Y".equals(lgesGubun) ) {
					        	lgesCodeVo.setWorkOrdNo(workOrdNo);
					        	//lgesCodeVo.setCutOrdDate(tempDate);
								lgesCodeVo = productionPerfTrayService.trayLgesCodeSeq(lgesCodeVo);
								//lgess 시퀀스 업데이트
								lgesSeq = lgesCodeVo.getLgesCode();
				        	}
							
				        	cleanNo-=6;
				        	allCount-=6;
				        }
				        i++;
				        outputTotalCnt += trayExistingData.getProductQty();
				    }
					//★★★★★★★★★★★★★★★★★★★★★★★★나머지가 없는 경우 처리 끝★★★★★★★★★★★★★★★★★★★★★★★★
				} else {
					//★★★★★★★★★★★★★★★★★★★★★★★★나머지가 있는 경우 처리★★★★★★★★★★★★★★★★★★★★★★★★
					for(int dirtyNo=1; dirtyNo<=allCount; dirtyNo++) {
						jsonObj.put(i, jsonArray.get(i));
						JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
						 
				        if(allCount>=6) {
				        	//6개 이상의 트레이가 남아 포장이 가능한 상태 --여기서 부터 나머지가 없는 경우 처리하는 코드와 동일 함
				        	trayVoDtl = new ProductionPerfTrayVo();
				        	trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );
							trayVoDtl = productionPerfTrayService.productionPerfTrayRead(trayVoDtl);
							trayExistingData = trayVoDtl;	//read한 값 담아주기
							
//							productQty		= 0;	//트레이 수량
//							goodsCd			= "";	//제품코드
//							productStatus	= "";	//상태 값
//							
//							productQty		= trayVoDtl.getProductQty();
//							goodsCd			= trayVoDtl.getGoodsCd();
//							productStatus	= trayVoDtl.getProductStatus();
							
							//포장이 아닌경우에만 수정 가능 함
							if( trayVoDtl.getProductStatus().equals("001") || trayVoDtl.getProductStatus().equals("002") ) {
								trayVoDtl = new ProductionPerfTrayVo();
								//labelLotNo = date +"-"+ labelSeqNumber;	//라벨로트 생성 부여
								labelLotNo = mainLabelLotNo + labelSeqNumber;	//라벨로트 생성 부여
								
								//LGES_코드부여
								if( "Y".equals(lgesGubun) ) {
									lgesCode = lgesCodeInfo + lgesSeq;
								}
								
								//라벨로트시퀀스생성
								if(labelLotNoSeqCount >= 0 && labelLotNoSeqCount <= 3) {
									labelLotNoSeq = labelLotNo + "-1";
									
									productPartQty += trayExistingData.getProductQty();	//트레이 수량(3개씩 합친 값)
									
									//생산 실적 테이블 값 저장
									if( labelLotNoSeqCount == 3 ) {
										GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
										
										goodsProductInfoAdmVo.setBoxNo(labelLotNoSeq);									//포장 번호
										goodsProductInfoAdmVo.setGoodsCd(trayExistingData.getGoodsCd());										//제품 코드
										goodsProductInfoAdmVo.setOrdGubun("003");										//오더 구분
										goodsProductInfoAdmVo.setPackCnt(productPartQty);								//포장 수량
										goodsProductInfoAdmVo.setPackDate(jsonObjDtl.get("productDate").toString());	//포장 일자*
										goodsProductInfoAdmVo.setGoodsInDate(jsonObjDtl.get("productDate").toString());	//제품입고일*
										goodsProductInfoAdmVo.setRemainCnt(productPartQty);								//남은 수량
										goodsProductInfoAdmVo.setGoodsStatus("001");									//제품 입출고 상태
										goodsProductInfoAdmVo.setFaultyStatus("001");									//제품 정상/불량 상태
										goodsProductInfoAdmVo.setDisuseYn("N");											//제품폐기여부
										goodsProductInfoAdmVo.setDivisionYn("N");										//제품재분할/재병합 여부								
										goodsProductInfoAdmVo.setRegId(Utils.getUserId());								//등록자
										goodsProductInfoAdmVo.setHistId(Utils.getUserId());								//기록자
										
										//DTL 추가 정보
										goodsProductInfoAdmVo.setBoxSeq(1);												//포장 번호 시퀀스
										goodsProductInfoAdmVo.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작업지시번호
										goodsProductInfoAdmVo.setWorkOrdLotNo(labelLotNoSeq);							//생산LotNo
										goodsProductInfoAdmVo.setOrdLotNo(labelLotNoSeq);								//생산전표번호
										goodsProductInfoAdmVo.setPackDtlCnt(productPartQty);							//포장상세수량
										goodsProductInfoAdmVo.setPrintYn("Y");											//바코드 출력 여부
										
										//TMP
										goodsProductInfoAdmVo.setPackNumber(labelLotNoSeq);								//미포장으로 변경 전표일자
										goodsProductInfoAdmVo.setPackRemainCnt(productPartQty);							//TMP_잔량
										
										//생산실적라벨발행등록_ADM
										// goodsPackService.createGoodsLabelPublish(goodsProductInfoAdmVo);
										
										//생산실적라벨발행등록_DTL
										// goodsPackService.createGoodsLabelPublishDtl(goodsProductInfoAdmVo);
										
										//생산실적라벨발행등록_HIST
										// goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);	//SELECT UPDATE
										
										//생산실적라벨발행등록_TMP
										// goodsPackService.createGoodsLabelTmp(goodsProductInfoAdmVo);
										
										//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
										/* StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
										createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(trayExistingData.getGoodsCd(), labelLotNoSeq, "002", "I", "007", productPartQty, factoryCode);	
										stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);*/
										
										
										productPartQty = 0;
									}
									//생산 실적 테이블 값 저장 끝
								}
								if(labelLotNoSeqCount >= 4 && labelLotNoSeqCount <= 6) {
									labelLotNoSeq = labelLotNo + "-2";
									productPartQty += trayExistingData.getProductQty();	//트레이 수량(3개씩 합친 값)
									
									if(labelLotNoSeqCount == 6) {
										labelLotNoSeqCount = 0;
										
										//생산 실적 테이블 값 저장 시작
										GoodsProductInfoAdmVo goodsProductInfoAdmVo = new GoodsProductInfoAdmVo();
										
										goodsProductInfoAdmVo.setBoxNo(labelLotNoSeq);									//포장 번호
										goodsProductInfoAdmVo.setGoodsCd(trayExistingData.getGoodsCd());										//제품 코드
										goodsProductInfoAdmVo.setOrdGubun("003");										//오더 구분
										goodsProductInfoAdmVo.setPackCnt(productPartQty);								//포장 수량
										goodsProductInfoAdmVo.setPackDate(jsonObjDtl.get("productDate").toString());	//포장 일자*
										goodsProductInfoAdmVo.setGoodsInDate(jsonObjDtl.get("productDate").toString());	//제품입고일*
										goodsProductInfoAdmVo.setRemainCnt(productPartQty);								//남은 수량
										goodsProductInfoAdmVo.setGoodsStatus("001");									//제품 입출고 상태
										goodsProductInfoAdmVo.setFaultyStatus("001");									//제품 정상/불량 상태
										goodsProductInfoAdmVo.setDisuseYn("N");											//제품폐기여부
										goodsProductInfoAdmVo.setDivisionYn("N");										//제품재분할/재병합 여부								
										goodsProductInfoAdmVo.setRegId(Utils.getUserId());								//등록자
										goodsProductInfoAdmVo.setHistId(Utils.getUserId());								//기록자
										
										//DTL 추가 정보
										goodsProductInfoAdmVo.setBoxSeq(1);												//포장 번호 시퀀스
										goodsProductInfoAdmVo.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작업지시번호
										goodsProductInfoAdmVo.setWorkOrdLotNo(labelLotNoSeq);							//생산LotNo
										goodsProductInfoAdmVo.setOrdLotNo(labelLotNoSeq);								//생산전표번호
										goodsProductInfoAdmVo.setPackDtlCnt(productPartQty);							//포장상세수량
										goodsProductInfoAdmVo.setPrintYn("Y");											//바코드 출력 여부
										
										//TMP
										goodsProductInfoAdmVo.setPackNumber(labelLotNoSeq);								//미포장으로 변경 전표일자
										goodsProductInfoAdmVo.setPackRemainCnt(productPartQty);							//TMP_잔량
										
										//생산실적라벨발행등록_ADM
										// goodsPackService.createGoodsLabelPublish(goodsProductInfoAdmVo);
										
										//생산실적라벨발행등록_DTL
										// goodsPackService.createGoodsLabelPublishDtl(goodsProductInfoAdmVo);
										
										//생산실적라벨발행등록_HIST
										// goodsPackService.insertGoodsProductHist(goodsProductInfoAdmVo);	//SELECT UPDATE
										
										//생산실적라벨발행등록_TMP
										// goodsPackService.createGoodsLabelTmp(goodsProductInfoAdmVo);
										
										//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
										/* StockPaymentAdmVo createDivisionBoxNo1 = new StockPaymentAdmVo();
										createDivisionBoxNo1 = StockPaymentAdmController.goodsStockPaymentHist(trayExistingData.getGoodsCd(), labelLotNoSeq, "002", "I", "007", productPartQty, factoryCode);	
										stockPaymentAdmService.stockPaymentPlus(createDivisionBoxNo1);*/
										
										//출하 검사 등록
										ShipInspectVo shipInspectAdmVo = new ShipInspectVo();
										shipInspectAdmVo.setTrayNo(labelLotNo);
										shipInspectAdmVo.setTrayNo1(labelLotNo + "-1");
										shipInspectAdmVo.setTrayNo2(labelLotNo + "-2");
										
										if( "Y".equals(lgesGubun) ) {
											if( !"".equals( jsonObjDtl.get("lgesCode").toString() ) ) {
												//LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분
												String[] lgesCodeSplit = jsonObjDtl.get("lgesCode").toString().split("-");
												String changeLgesCode = labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]));
												shipInspectAdmVo.setTrayNo(changeLgesCode);
												shipInspectAdmVo.setTrayNo1(changeLgesCode + "-1");
												shipInspectAdmVo.setTrayNo2(changeLgesCode + "-2");
											} else {
												//LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 
												String[] lgesCodeSplit = lgesCode.split("-");
												String changeLgesCode = labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]));
												shipInspectAdmVo.setTrayNo(changeLgesCode);
												shipInspectAdmVo.setTrayNo1(changeLgesCode + "-1");
												shipInspectAdmVo.setTrayNo2(changeLgesCode + "-2");
											}
										}
										
										shipInspectAdmVo.setWorkOrdNo( jsonObjDtl.get("workOrdNo").toString() );
										shipInspectAdmVo.setMatrlLotNo( jsonObjDtl.get("matrlLotNo").toString() );
										shipInspectAdmVo.setFilmLotNo( trayExistingData.getFilmLotNo() );
										shipInspectAdmVo.setProductDate( jsonObjDtl.get("productDate").toString() );
										shipInspectAdmVo.setDayNightCd(jsonObjDtl.get("dayNightCd").toString());

										//shipInspectAdmVo.setInspStatus();
										shipInspectAdmVo.setReInspStatus("001");
										//shipInspectAdmVo.setDisStatus();
										//shipInspectAdmVo.setInspDate( date );
										shipInspectAdmVo.setFaultyCnt("0");
										//shipInspectAdmVo.setFaultyTrayNo(faultyTrayNo);
										//shipInspectAdmVo.setInspChargr(inspChargr);
										//shipInspectAdmVo.setDayNightCd(dayNightGubun);
										//shipInspectAdmVo.setFaultyGubun(faultyGubun);
										shipInspectAdmVo.setNextGubun("001");
										shipInspectAdmVo.setSeq("1");
										shipInspectAdmVo.setRegId( Utils.getUserId() );
										shipInspectService.shipAdmCreate(shipInspectAdmVo);
										//출하 검사 등록 끝
										
										
										productPartQty = 0;
										//생산 실적 테이블 값 저장 끝
									}								
								}
								//라벨로트 시퀀스 끝
					        	
					        	trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );	//트레이번호
					        	if( trayExistingData.getProductStatus().equals("001") ) {
					        		
									//첫번째 트레이는 무조건 메탈 혼입으로 변경
//									if( trayExistingData.getTurnNumber() == 1 ) {
//										trayVoDtl.setIncorporationGubun("Y");
//									}
									
									trayVoDtl.setChangeTrayNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//변경되는 트레이번호
									trayVoDtl.setTrayWorkerId( jsonObjDtl.get("trayWorkerId").toString() );	//작업자
									trayVoDtl.setProductDate( jsonObjDtl.get("productDate").toString() );	//작업일자
									trayVoDtl.setDayNightCd( jsonObjDtl.get("dayNightCd").toString() );		//주야 구분
									
									//작업지시 생산수량 서브	_insert
									WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
									workOrdOutputSubVo.setWorkOrdNo( jsonObjDtl.get("workOrdNo").toString() );				//작업지시번호
									workOrdOutputSubVo.setWorkOrdLotNo( jsonObjDtl.get("workOrdNo").toString() );			//생산LotNo
									workOrdOutputSubVo.setWorkOrdSeq( Integer.toString(trayExistingData.getTurnNumber()) );	//시퀀스
									//workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//작지 LotNo
									workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("workOrdNo").toString() +"-T" );			//작지 LotNo
									workOrdOutputSubVo.setLotNo( trayExistingData.getMatrlLotNo() );						//주자재 LotNo
									workOrdOutputSubVo.setSubWorkStatusCd("A");												//작업 상태
									workOrdOutputSubVo.setOutputCnt( trayExistingData.getProductQty() );					//생산수량
									workOrdOutputSubVo.setGubun( jsonObjDtl.get("dayNightCd").toString() );					//주/야 구분
									workOrdOutputSubVo.setWorkOrdDate( jsonObjDtl.get("productDate").toString() );			//전표일자
									workOrdOutputSubVo.setMainWorkChargr( jsonObjDtl.get("trayWorkerId").toString() );		//담당자
									workOrdOutputSubVo.setPackYn("Y");														//포장 여부
									workOrdOutputSubVo.setRegId( Utils.getUserId() );										//등록자
									
									//작업지시 생산수량 서브 저장
									//workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
									//작업지시 생산수량 서브	_insert 끝
									
								}
					        	trayVoDtl.setLabelLotNo(labelLotNo);		//라벨로트
					        	trayVoDtl.setLabelLotNoSeq(labelLotNoSeq);	//라벨로트시퀀스
					        	
					        	if( "Y".equals(lgesGubun) ) {
					        		if( !"".equals( jsonObjDtl.get("lgesCode").toString() ) ) {
					        			////LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 (객체 전달 시 객체에 대한 참조가 복사됨(얕은 복사))
										processLabel(lgesCode, labelLotNo, labelLotNoSeq, trayVoDtl);
									} else {
										////LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 (객체 전달 시 객체에 대한 참조가 복사됨(얕은 복사))
										processLabel(lgesCode, labelLotNo, labelLotNoSeq, trayVoDtl);
									}
					        	}
					        	
								trayVoDtl.setProductStatus("003");			//생산상태(미완료:001, 생산완료:002, 포장:003)
								trayVoDtl.setUpdId( Utils.getUserId() );	//수장자
								labelLotArray.add( labelLotNo );			//만들어진 labelLotNo 값 담아주기
								labelLotNoSeqCount++;
					        	//생산실적트레이테이블 수정
								productionPerfTrayService.productionPerfTrayUpdate(trayVoDtl);
								trayVoDtl.setEquipCd(equipCd);
								//trayVoDtl.setWorkOrdNo(workOrdNo);
								productionPerfTrayService.lgesPrintWhetherUpdate(trayVoDtl);
							}
							//6개 이상의 트레이가 남아 포장이 가능한 상태 끝
				        } else {
				        	//6개 이하의 트레이가 남아 포장이 불가능한 상태
				        	trayVoDtl = new ProductionPerfTrayVo();
				        	trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );
							trayVoDtl = productionPerfTrayService.productionPerfTrayRead(trayVoDtl);
							trayExistingData = trayVoDtl;	//read한 값 담아주기
//							productStatus = "";
//							productStatus = trayVoDtl.getProductStatus();
							
							if( trayVoDtl.getProductStatus().equals("001") || trayVoDtl.getProductStatus().equals("002") ) {
								trayVoDtl = new ProductionPerfTrayVo();
								trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() );	//트레이번호
								if( trayExistingData.getProductStatus().equals("001") ) {
									//첫번째 트레이는 무조건 메탈 혼입으로 변경
//									if( trayExistingData.getTurnNumber() == 1 ) {
//										trayVoDtl.setIncorporationGubun("Y");
//									}
									trayVoDtl.setChangeTrayNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//변경되는 트레이번호
									trayVoDtl.setTrayWorkerId( jsonObjDtl.get("trayWorkerId").toString() );	//작업자
									trayVoDtl.setProductDate( jsonObjDtl.get("productDate").toString() );	//작업일자
									trayVoDtl.setDayNightCd( jsonObjDtl.get("dayNightCd").toString() );		//주야 구분
									
									//작업지시 생산수량 서브	_insert
									WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
									workOrdOutputSubVo.setWorkOrdNo( jsonObjDtl.get("workOrdNo").toString() );				//작업지시번호
									workOrdOutputSubVo.setWorkOrdLotNo( jsonObjDtl.get("workOrdNo").toString() );			//생산LotNo
									workOrdOutputSubVo.setWorkOrdSeq( Integer.toString(trayExistingData.getTurnNumber()) );	//시퀀스
									//workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("trayNo").toString() +"_"+ jsonObjDtl.get("dayNightCd").toString() );	//작지 LotNo
									workOrdOutputSubVo.setOrdLotNo( jsonObjDtl.get("workOrdNo").toString() +"-T" );			//작지 LotNo
									workOrdOutputSubVo.setLotNo( trayExistingData.getMatrlLotNo() );						//주자재 LotNo
									workOrdOutputSubVo.setSubWorkStatusCd("A");												//작업 상태
									workOrdOutputSubVo.setOutputCnt( trayExistingData.getProductQty() );					//생산수량
									workOrdOutputSubVo.setGubun( jsonObjDtl.get("dayNightCd").toString() );					//주/야 구분
									workOrdOutputSubVo.setWorkOrdDate( jsonObjDtl.get("productDate").toString() );			//전표일자
									workOrdOutputSubVo.setMainWorkChargr( jsonObjDtl.get("trayWorkerId").toString() );		//담당자
									workOrdOutputSubVo.setPackYn("Y");														//포장 여부
									workOrdOutputSubVo.setRegId( Utils.getUserId() );										//등록자

									//작업지시 생산수량 서브 저장
									//workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
									//작업지시 생산수량 서브	_insert 끝
									
								}
								trayVoDtl.setProductStatus("002");			//생산상태(미완료:001, 생산완료:002, 포장:003)
								trayVoDtl.setUpdId( Utils.getUserId() );	//수장자
				        		//생산실적트레이테이블 수정
								productionPerfTrayService.productionPerfTrayUpdate(trayVoDtl);
							}
				        }
				        
				        //
				        if( dirtyNo>=6 ) {
				        	sudel.setFactoryCode(factoryCode);
				        	sudel.setProductDate( factoryCode.equals("003") ? date.substring(2) : date);
							sudel.setEquipCd(equipCd);
				        	sudel = productionPerfTrayService.productionPerfTrayLabelSeq( sudel );
				        	//라벨 시퀀스 업데이트
				        	labelSeqNumber = sudel.getBoxNo();
				        	
				        	if( "Y".equals(lgesGubun) ) {
					        	lgesCodeVo.setWorkOrdNo(workOrdNo);
					        	//lgesCodeVo.setCutOrdDate(tempDate);
								lgesCodeVo = productionPerfTrayService.trayLgesCodeSeq(lgesCodeVo);
								//lgess 시퀀스 업데이트
								lgesSeq = lgesCodeVo.getLgesCode();
				        	}
							
				        	dirtyNo-=6;
				        	allCount-=6;
				        }
				        i++;
				        outputTotalCnt += trayExistingData.getProductQty();
					 }
					//★★★★★★★★★★★★★★★★★★★★★★★★나머지가 있는 경우 처리 끝★★★★★★★★★★★★★★★★★★★★★★★★
				}
				
				logger.info("labelLotArray ------------------> "+labelLotArray);
				
				jsonData.put("data", labelLotArray);
				jsonData.put("result", "ok");
				//트레이 수정 종료
				
				//생산실적트레이 Update
				//trayFaultyRelatedUpdate( workOrdNo, outputTotalCnt );

				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 미사용으로 변경
				singletonSettings.useTrayProduce = false;
				//작지가 작업 종료로 변경
				singletonSettings.useTrayProduceArray[arrayLastNum] = null;
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
			} else {
				jsonData.put("message", "현재 트레이 생산 시스템이 사용중입니다.");
				jsonData.put("result", "using");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 혼입 여부 수정
	@RequestMapping(value="po/trayMixUpdate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> trayMixUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 수정 : "+productionPerfTrayVo);
		try {

			Settings singletonSettings = Settings.getInstance();
			//2공장 트레이 생산 기능 잠금 O
			//if(factoryCode.equals("002")) {
				if( singletonSettings.lockTrayProduce ) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("002");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;								
				}
			//}
			
			int arrayLastNum = Arrays.asList(singletonSettings.useTrayProduceArray).indexOf(null);	//배열에 마지막 번호 가지고 오기
			boolean checkWorkOrderNo = Arrays.asList(singletonSettings.useTrayProduceArray).contains(productionPerfTrayVo.getWorkOrdNo()); //트레이 기존 배열에 현 작지가 존재하는지 확인
			
			/*
			 * logger.info("useTrayProduce --> " +singletonSettings.useTrayProduce);
			 * logger.info("checkWorkOrderNo --> " +checkWorkOrderNo);
			 */
			
			logger.info("useTrayProduce --> " +!singletonSettings.useTrayProduce);
			logger.info("checkWorkOrderNo --> " +!checkWorkOrderNo);
			
			//싱글톤 트레이 생산 사용중이 아니라면
			if ( !singletonSettings.useTrayProduce || !checkWorkOrderNo ) {
				//싱글톤 트레이 시스템 사용으로 변경
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 사용으로 변경
				singletonSettings.useTrayProduce = true;
				//어떤 작지가 작업 중인지 표시
				singletonSettings.useTrayProduceArray[arrayLastNum] = productionPerfTrayVo.getWorkOrdNo();
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				
				//트레이 혼입 수정 시작
				JSONParser jsonParser	= new JSONParser();
				JSONObject jsonObj		= new JSONObject();
				JSONArray jsonArray		= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
				
				//변경된 값 존재하는지 상태 확인
				boolean functionSudelCheck = trayStatusCheck( jsonArray, productionPerfTrayVo.getEquipCd(), productionPerfTrayVo.getWorkOrdNo(), "003", productionPerfTrayVo.getLgesGubun(), productionPerfTrayVo.getProductDate() );
				
				if( functionSudelCheck ) {
					singletonSettings.useTrayProduce = false;
					singletonSettings.useTrayProduceArray[arrayLastNum] = null;
					
					jsonData.put("message", "현재 트레이 상태가 변경 되었습니다.<br>다시 시도해주세요.");
					jsonData.put("result", "fail");
					return jsonData;
				}
				
				//생산실적트레이Vo 초기화
				ProductionPerfTrayVo trayVoDtl = new ProductionPerfTrayVo();
				ProductionPerfTrayVo mixGubun = new ProductionPerfTrayVo();
				
				//혼입 여부 저장하는 부분
				for(int i=0; i<jsonArray.size(); i++) {
					jsonObj.put(i, jsonArray.get(i));
					JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
					trayVoDtl = new ProductionPerfTrayVo();

					
					if( jsonObjDtl.get("mixGubun").toString().equals("M") ) {
						//메탈인 경우
						//trayVoDtl.setIncorporationGubun(jsonObjDtl.get("incorporationGubun").toString());				//혼입 여부
						
						mixGubun = new ProductionPerfTrayVo();
						mixGubun.setTrayNo(jsonObjDtl.get("trayNo").toString());
						mixGubun = productionPerfTrayService.productionPerfTrayRead(mixGubun);
						
						if( jsonObjDtl.get("incorporationGubun").toString().equals("Y") ) {
							//현재 들어온 값이 메탈 혼입이고, 저장되어 있던 값이 혼입이 아닌경우
							if( !mixGubun.getIncorporationGubun().equals("Y") ) {
								//기존에 있던 비전 혼입이 혼입인 경우 _MV로 변경
								if( mixGubun.getIncorporationVisonGubun().equals("Y") ) {
									trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_V", "").replace("_M", "") + "_M" + "V");	//변경되는 트레이 번호
								} else {
									trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_V", "") + "_M");		//변경되는 트레이 번호
								}
							}
						} else {
							//현재 들어온 값이 메탈 혼입이 아니고, 저장되어 있던 값이 혼입인 경우 (기존 메탈 혼입 삭제)
							//기존에 있던 비전 혼입이 혼입인 경우 _V로 변경
							if( mixGubun.getIncorporationVisonGubun().equals("Y") ) {
								trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("M", ""));			//변경되는 트레이 번호	
							} else {
								trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_M", ""));			//변경되는 트레이 번호
							}
						}	
						
						trayVoDtl.setIncorporationGubun(jsonObjDtl.get("incorporationGubun").toString());		//혼입 여부
						trayVoDtl.setOutputSubCheck("Y");	//비전혼입인 경우에는 생산실적ordLotNo값 Update
						
						
					} else if( jsonObjDtl.get("mixGubun").toString().equals("V") ) {
						//비전인 경우
						mixGubun = new ProductionPerfTrayVo();
						mixGubun.setTrayNo(jsonObjDtl.get("trayNo").toString());
						mixGubun = productionPerfTrayService.productionPerfTrayRead(mixGubun);
						
						if( jsonObjDtl.get("incorporationVisonGubun").toString().equals("Y") ) {
							//현재 들어온 값이 비전 혼입이고 저장되어 있던 값이 혼입이 아닌경우
							if( !mixGubun.getIncorporationVisonGubun().equals("Y") ) {
								
								//기존에 있던 메탈 혼입이 혼입인 경우 _MV로 변경
								if( mixGubun.getIncorporationGubun().equals("Y") ) {
									trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_V", "").replace("_M", "") + "_M" + "V");	//변경되는 트레이 번호	
								} else {
									trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_M", "") + "_V");		//변경되는 트레이 번호
								}
							}
						} else {
							//현재 들어온 값이 비전 혼입이 아니고 저장되어 있던 값이 혼입인 경우 (기존 비전 혼입 삭제)
							trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_V", ""));			//변경되는 트레이 번호
							
							//기존에 있던 메탈 혼입이 혼입인 경우 _M로 변경
							if( mixGubun.getIncorporationGubun().equals("Y") ) {
								//기존에 있던 메탈 혼입이 혼입인 경우 + 기존에 있던 비전 혼입이 혼입인 경우(상태 : _MV)
								if( mixGubun.getIncorporationVisonGubun().equals("Y") ) {
									trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_MV", "") + "_M");	//변경되는 트레이 번호
								}
								//trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("V", ""));			//변경되는 트레이 번호
								//trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_MV", "") + "_M");	//변경되는 트레이 번호
							} else {
								trayVoDtl.setChangeTrayNo(jsonObjDtl.get("trayNo").toString().replace("_V", ""));			//변경되는 트레이 번호
							}
						}
						
						trayVoDtl.setIncorporationVisonGubun(jsonObjDtl.get("incorporationVisonGubun").toString());		//혼입 여부
						//trayVoDtl.setOutputSubCheck("Y");	//비전혼입인 경우에는 생산실적ordLotNo값 Update
					} else {
						jsonData.put("result", "error");
						jsonData.put("message", Utils.getErrorMessage());
						return jsonData;
					}
					
					trayVoDtl.setTrayNo(jsonObjDtl.get("trayNo").toString());											//트레이 번호
					//생산실적트레이테이블 수정
					productionPerfTrayService.productionPerfTrayUpdate(trayVoDtl);
				}
				jsonData.put("result", "ok");
				//트레이 혼입 수정 종료
				
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 미사용으로 변경
				singletonSettings.useTrayProduce = false;
				//작지가 작업 종료로 변경
				singletonSettings.useTrayProduceArray[arrayLastNum] = null;
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
			} else {
				jsonData.put("message", "현재 트레이 생산 시스템이 사용중입니다.");
				jsonData.put("result", "using");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//트레이 삭제 업데이트
	@RequestMapping(value="po/productionPerfTrayDeleteupdate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> productionPerfTrayDeleteupdate(ProductionPerfTrayVo productionPerfTrayVo, String workStatusCd) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 삭제 : "+productionPerfTrayVo);
		try {

			Settings singletonSettings = Settings.getInstance();
			//2공장 트레이 생산 기능 잠금 O
			//if(factoryCode.equals("002")) {
				if( singletonSettings.lockTrayProduce ) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("002");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;								
				}
			//}
			
			int arrayLastNum = Arrays.asList(singletonSettings.useTrayProduceArray).indexOf(null);	//배열에 마지막 번호 가지고 오기
			boolean checkWorkOrderNo = Arrays.asList(singletonSettings.useTrayProduceArray).contains(productionPerfTrayVo.getWorkOrdNo()); //트레이 기존 배열에 현 작지가 존재하는지 확인
			
			//싱글톤 트레이 생산 사용중이 아니라면
			if ( !singletonSettings.useTrayProduce || !checkWorkOrderNo ) {
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 사용으로 변경
				singletonSettings.useTrayProduce = true;
				//어떤 작지가 작업 중인지 표시
				singletonSettings.useTrayProduceArray[arrayLastNum] = productionPerfTrayVo.getWorkOrdNo();
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				
				//트레이 혼입 삭제 시작
				JSONParser jsonParser	= new JSONParser();
				JSONObject jsonObj		= new JSONObject();
				JSONArray jsonArray		= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
				
				//변경된 값 존재하는지 상태 확인
				boolean functionSudelCheck = trayStatusCheck( jsonArray, productionPerfTrayVo.getEquipCd(), productionPerfTrayVo.getWorkOrdNo(), "002", productionPerfTrayVo.getLgesGubun(), productionPerfTrayVo.getProductDate() );
				
				if( functionSudelCheck ) {
					singletonSettings.useTrayProduce = false;
					singletonSettings.useTrayProduceArray[arrayLastNum] = null;
					
					jsonData.put("message", "현재 트레이 상태가 변경 되었습니다.<br>다시 시도해주세요.");
					jsonData.put("result", "fail");
					return jsonData;
				}
				
				
				logger.info("트레이 정보 확인" +productionPerfTrayVo.getTrayNo());
				String workOrdNo	= productionPerfTrayVo.getWorkOrdNo();
				String equipCd		= productionPerfTrayVo.getEquipCd();
				String trayNo		= productionPerfTrayVo.getTrayNo();
				int deleteGoodsProsuctCheck = 0;
				
				//제품생산정보관리에 상태값 확인
				productionPerfTrayVo.setFactoryCode(factoryCode);	//1공장은 LabelLot(6), 2공장은 labelLotSeq(3)
				productionPerfTrayVo = productionPerfTrayService.productionPerfTrayDeletedGoodsProductCheck(productionPerfTrayVo);
				deleteGoodsProsuctCheck = productionPerfTrayVo.getDeleteGoodsProsuctCheck();
				
				//마지막 작지인지 확인
				productionPerfTrayVo.setEquipCd(equipCd);
				productionPerfTrayVo = productionPerfTrayService.productionPerfTrayDeletedWorkOrdNoCheck(productionPerfTrayVo);
				
				//여기 부분에서 상태값 체크 후 예외처리 적용하는부분 시작
				
				//마지막 작지인지 Check
				if(workOrdNo.equals(productionPerfTrayVo.getWorkOrdNo())) {
					//생산 실적 값 입고 되었는지 확인
					if( deleteGoodsProsuctCheck == 0 ) {
						
						//▶▶▶삭제 처리 시작◀◀◀
						//생산실적트레이Vo 초기화
						ProductionPerfTrayVo trayVoDtl	= new ProductionPerfTrayVo();
						ProductionPerfTrayVo mixGubun 	= new ProductionPerfTrayVo();
						ProductionPerfTrayVo readVo		= new ProductionPerfTrayVo();
						List<ProductionPerfTrayVo> list	= new ArrayList<ProductionPerfTrayVo>();
						
						//제품생산정보관리 / 생산실적 / 출하검사 ----> (전체) 삭제 시작
						productionPerfTrayVo.setWorkOrdNo( workOrdNo );
						productionPerfTrayVo.setTrayNo( trayNo );
						productionPerfTrayVo.setFactoryCode(factoryCode);	//1공장은 LabelLot(6), 2공장은 labelLotSeq(3)
						productionPerfTrayService.deleteAllGoodsProduct(productionPerfTrayVo);
						
						//저장하는 부분
						for(int i=0; i<jsonArray.size(); i++) {
							jsonObj.put(i, jsonArray.get(i));
							JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
							trayVoDtl = new ProductionPerfTrayVo();
							
							//제품생산정보관리 삭제 시작
							/*productionPerfTrayVo.setWorkOrdNo( workOrdNo );
							productionPerfTrayVo.setTrayNo( jsonObjDtl.get("trayNo").toString() );
							productionPerfTrayVo = productionPerfTrayService.productionPerfTrayRead(productionPerfTrayVo);
							productionPerfTrayService.deleteAllGoodsProduct(productionPerfTrayVo);*/
							
							//생산실적트레이 삭제
							trayVoDtl.setTrayNo( jsonObjDtl.get("trayNo").toString() ); 
							trayVoDtl.setChangeTrayNo( jsonObjDtl.get("trayNo").toString().replace("_D", "").replace("_N", "").replace("_MV", "").replace("_M", "").replace("_V", "") );
							trayVoDtl.setIncorporationGubun( "N" );
							trayVoDtl.setIncorporationVisonGubun( "N" );
							trayVoDtl.setTrayWorkerId( jsonObjDtl.get("trayWorkId").toString() );
							trayVoDtl.setProductStatus("001");
							//trayVoDtl.setTrayWorkerId("");;
							trayVoDtl.setUpdId(Utils.getUserId());
							productionPerfTrayService.productionPerfTrayUpdate(trayVoDtl);
						}
						
						// 상태가 삭제이고 라벨번호가 남아있는 트레이 리스트
						list = productionPerfTrayService.productionPerfTrayDeletedLabelRead(productionPerfTrayVo);
							
						// 삭제된 라벨번호 삭제해주기 
						for(ProductionPerfTrayVo m : list) {
							m.setUpdId(Utils.getUserId());
							productionPerfTrayService.productionPerfTrayDeletedLabelUpdate(m);
						}
						
						// 라벨없어진 tray 상태값 변경해주기
						productionPerfTrayVo.setUpdId(Utils.getUserId());
						productionPerfTrayService.productionPerfTrayDeletedLabelUpdate2(productionPerfTrayVo);
						jsonData.put("result", "ok");
						//▶▶▶삭제 처리 끝◀◀◀
						
						//생산실적트레이 Update
						if( workStatusCd.equals("C") ) {
							trayFaultyRelatedCreate( workOrdNo );							
						}
						
					} else {
						jsonData.put("message", "입고&출고된 제품입니다.<br>삭제 후 다시 진행 해주세요.");
						jsonData.put("result", "fail");
					}
					//생산 실적 값 입고 되었는지 확인 끝
					
				} else {
					jsonData.put("message", "마지막 작지만 삭제가 가능합니다.<br>마지막 작지를 선택 후 진행 해주세요.");
					jsonData.put("result", "fail");
				}
				//트레이 혼입 삭제 종료
				
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				//싱글톤 트레이 시스템 미사용으로 변경
				singletonSettings.useTrayProduce = false;
				//작지가 작업 종료로 변경
				singletonSettings.useTrayProduceArray[arrayLastNum] = null;
				//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
			} else {
				jsonData.put("message", "현재 트레이 생산 시스템이 사용중입니다.");
				jsonData.put("result", "using");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이 삭제
	@RequestMapping(value="po/productionPerfTrayDelete" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> productionPerfTrayDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 삭제 : "+productionPerfTrayVo);
		try {
			
			String deleteGubun	= productionPerfTrayVo.getDeleteGubun();	//001: 삭제, 002: 삭제 확인용
			String equipCd		= productionPerfTrayVo.getEquipCd();
			String workOrdNo	= productionPerfTrayVo.getWorkOrdNo();
			productionPerfTrayVo = productionPerfTrayService.productionPerfTrayDeleteCheck(productionPerfTrayVo);	//트레이 관련

			//생산 실적 테이블
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			List<WorkOrdOutputSubVo> workOrdOutputSubList =	workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
			
			int deleteCheck = Integer.parseInt( productionPerfTrayVo.getDeleteCheck() );
			if(deleteCheck != 0 || workOrdOutputSubList.size() != 0) {
				//값을 삭제 할 수 없습니다.
				jsonData.put("message", "생산실적, 생산실적(Tray)에 값이 등록되어 있습니다.<br>삭제 후 다시 시도해주세요.");
				jsonData.put("result", "fail");
			} else {
				
				//외관 불량 항목 조회
				GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				List<GoodsFaultyAdmVo> readGoodsFaultyAdm = goodsInspectService.readTrayGoodsFaultyAdmCode(goodsFaultyAdmVo);
				
				//엣지 불량 항목 조회
				EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo.setWorkOrdNo(workOrdNo);
				List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCode = goodsInspectService.readTrayEdgeGoodsFaultyAdmCode(edgeGoodsFaultyAdmVo);
				
				//외관 값과 엣지 값이 존재하는 경우 삭제 메세지
				if( readGoodsFaultyAdm.size() == 0 && readEdgeGoodsFaultyAdmCode.size() == 0 ) {
					if( deleteGubun.equals("001") ) {
						//001인 경우 실제 삭제 처리
						productionPerfTrayVo.setEquipCd(equipCd);
						productionPerfTrayVo.setWorkOrdNo(workOrdNo);;
						productionPerfTrayService.productionPerfTrayDelete(productionPerfTrayVo);
						jsonData.put("result", "ok");					
					} else if( deleteGubun.equals("002") ) {
						jsonData.put("result", "ok");
					}
				} else {
					//엣지 외관 값이 존재하는 경우
					jsonData.put("message", "외관&엣지에 값이 등록되어 있습니다.<br>삭제 후 다시 시도해주세요.");
					jsonData.put("result", "fail");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	//생산실적트레이 Create
	public @ResponseBody boolean trayFaultyRelatedCreate(String workOrdNo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		boolean check = false;
		try {
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			productionPerfTrayVo.setWorkOrdNo(workOrdNo);
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.workOrderSubCreateTrayDataAssistant(productionPerfTrayVo);
			
			//기존 생산 실적 서브 삭제
			workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
			workOrdOutputSubVo.setOrdLotNo(workOrdNo + "-T");
			workOrdOutputSubService.appearAndEdgeCheckDelete_F3(workOrdOutputSubVo);
			
			if( productionPerfTrayList.size() != 0 ) {
				
				for( int i=0; i < productionPerfTrayList.size(); i++) {
					ProductionPerfTrayVo data = productionPerfTrayList.get(i);
					//작업지시 생산수량 서브	_insert
					workOrdOutputSubVo = new WorkOrdOutputSubVo();
					workOrdOutputSubVo.setWorkOrdNo( workOrdNo );											//작업지시번호
					workOrdOutputSubVo.setWorkOrdLotNo( workOrdNo + "-T" + data.getDayNightCd() + (i+1) );	//생산LotNo
					workOrdOutputSubVo.setWorkOrdSeq( Integer.toString( (i+1) ) );							//시퀀스
					workOrdOutputSubVo.setOrdLotNo( workOrdNo +"-T" );										//작지 LotNo
					workOrdOutputSubVo.setLotNo( data.getMatrlLotNo() );									//주자재 LotNo
					workOrdOutputSubVo.setSubWorkStatusCd("A");												//작업 상태
					workOrdOutputSubVo.setOutputCnt( data.getProductQty() );								//생산수량
					workOrdOutputSubVo.setGubun( data.getDayNightCd() );									//주/야 구분
					workOrdOutputSubVo.setWorkOrdDate( data.getProductDate() );								//전표일자
					workOrdOutputSubVo.setMainWorkChargr( data.getTrayWorkerId() );							//담당자
					workOrdOutputSubVo.setPackYn("Y");														//포장 여부
					workOrdOutputSubVo.setUserInputInspctCnt( data.getProductQty() );						//검사수량
					workOrdOutputSubVo.setRegId( Utils.getUserId() );										//등록자
					
					//저장 구분이 Y인 경우 외관&엣지 불량 수량 담아 주기 시작
					if( data.getCreateGubun().equals("Y") ) {
						//if( data.getTurnNumber() == 1 ) {
							//외관 불량 수량 조회
							GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
							goodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
							goodsFaultyAdmVo.setDayNightCd(data.getDayNightCd() );			//주야 구분
							//goodsFaultyAdmVo.setInspctCharger( data.getTrayWorkerId() );	//작업자
							//goodsFaultyAdmVo.setWorkOrdDate( data.getProductDate() );		//트레이 생산 날짜
							List<GoodsFaultyAdmVo> goodsFaultyAdmList = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdmVo);
							
							//엣지 불량 수량 조회
							EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
							edgeGoodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
							edgeGoodsFaultyAdmVo.setDayNightCd(data.getDayNightCd() );			//주야 구분
							//edgeGoodsFaultyAdmVo.setInspctCharger( data.getTrayWorkerId() );	//작업자
							//edgeGoodsFaultyAdmVo.setWorkOrdDate( data.getProductDate() );		//트레이 생산 날짜
							List<EdgeGoodsFaultyAdmVo> edgeGoodsFaultyAdmList = goodsInspectService.readEdgeGoodsFaultyAdmCode(edgeGoodsFaultyAdmVo);
							
							//외관 불량 등록 되어 있을 때
							if( goodsFaultyAdmList.size() != 0) {
								goodsFaultyAdmVo = new GoodsFaultyAdmVo();
								goodsFaultyAdmVo = goodsFaultyAdmList.get(0);
								
								//외관 불량 값 담아주기
								workOrdOutputSubVo.setAppearOutputCnt(data.getProductQty());
								workOrdOutputSubVo.setAppearInspctDate(goodsFaultyAdmVo.getFaultyRegDate());
								workOrdOutputSubVo.setAppearFaultyCnt(goodsFaultyAdmVo.getTotalAppearFaultyCnt());
								workOrdOutputSubVo.setAppearInspctCharger(goodsFaultyAdmVo.getInspctCharger());
							}
							
							//엣지 검사 등록 되어 있을 때
							if( edgeGoodsFaultyAdmList.size() != 0) {
								edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
								edgeGoodsFaultyAdmVo = edgeGoodsFaultyAdmList.get(0);
								
								//엣지 불량 값 담아주기
								workOrdOutputSubVo.setEdgeInspctDate(edgeGoodsFaultyAdmVo.getFaultyRegDate());
								workOrdOutputSubVo.setEdgeFaultyCnt(edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt());
								workOrdOutputSubVo.setEdgeInspctCharger(edgeGoodsFaultyAdmVo.getInspctCharger());
							}
							
							//불량 수량 까지 합쳐진 값
							workOrdOutputSubVo.setUserInputInspctCnt( ( data.getProductQty() + goodsFaultyAdmVo.getTotalAppearFaultyCnt() + edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt() ) );
						//저장 구분이 Y인 경우 외관&엣지 불량 수량 담아 주기 끝
						}
					
					//작업지시 생산수량 서브 저장
					workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
					//작업지시 생산수량 서브	_insert 끝
					}
					
				
					//생산실적트레이 Update
					//check = trayFaultyRelatedUpdate(workOrdNo, 0);
				//}
			} else {
				//작지는 있지만 트레이가 안 만들어졌고, 솔블레인이 아닌 경우 실행
				//if(!"003".equals(factoryCode)) {
				
					int checkCount = 0;
				
					ProductionPerfTrayVo productionPerfTrayVo2 = new ProductionPerfTrayVo();
					productionPerfTrayVo2.setWorkOrdNo(workOrdNo);
					productionPerfTrayVo2 = productionPerfTrayService.productResultRead(productionPerfTrayVo2);
					
					ProductionPerfTrayVo data = productionPerfTrayVo2;
					
					//작업지시 생산수량 서브	_insert
					workOrdOutputSubVo = new WorkOrdOutputSubVo();
					workOrdOutputSubVo.setWorkOrdNo( workOrdNo );						//작업지시번호
					workOrdOutputSubVo.setWorkOrdLotNo( workOrdNo + "-T" + "D" + 1 );	//생산LotNo
					workOrdOutputSubVo.setWorkOrdSeq( Integer.toString( (1) ) );		//시퀀스
					workOrdOutputSubVo.setOrdLotNo( workOrdNo +"-T" );					//작지 LotNo
					workOrdOutputSubVo.setLotNo( data.getMatrlLotNo() );				//주자재 LotNo
					workOrdOutputSubVo.setSubWorkStatusCd("A");							//작업 상태
					workOrdOutputSubVo.setOutputCnt( 0 );								//생산수량
					workOrdOutputSubVo.setGubun( "D" );									//주/야 구분
					workOrdOutputSubVo.setWorkOrdDate( data.getOrdDate() );				//전표일자
					workOrdOutputSubVo.setMainWorkChargr( data.getWorkerId() );			//담당자
					workOrdOutputSubVo.setPackYn("Y");									//포장 여부
					workOrdOutputSubVo.setUserInputInspctCnt( 0 );						//검사수량
					workOrdOutputSubVo.setRegId( Utils.getUserId() );					//등록자
					//작업지시 생산수량 서브	_insert
					
					
					
					GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
					goodsFaultyAdmVo.setDayNightCd("D");			//주야 구분
					List<GoodsFaultyAdmVo> goodsFaultyAdmList = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdmVo);
					
					//엣지 불량 수량 조회
					EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
					edgeGoodsFaultyAdmVo.setDayNightCd("D");			//주야 구분
					List<EdgeGoodsFaultyAdmVo> edgeGoodsFaultyAdmList = goodsInspectService.readEdgeGoodsFaultyAdmCode(edgeGoodsFaultyAdmVo);
					
					checkCount = goodsFaultyAdmList.size() + edgeGoodsFaultyAdmList.size();
					
					//외관 불량 등록 되어 있을 때
					if( goodsFaultyAdmList.size() != 0) {
						goodsFaultyAdmVo = new GoodsFaultyAdmVo();
						goodsFaultyAdmVo = goodsFaultyAdmList.get(0);
						
						//외관 불량 값 담아주기
						workOrdOutputSubVo.setAppearOutputCnt(0);
						workOrdOutputSubVo.setAppearInspctDate(goodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setAppearFaultyCnt(goodsFaultyAdmVo.getTotalAppearFaultyCnt());
						workOrdOutputSubVo.setAppearInspctCharger(goodsFaultyAdmVo.getInspctCharger());
					}
					
					//엣지 검사 등록 되어 있을 때
					if( edgeGoodsFaultyAdmList.size() != 0) {
						edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
						edgeGoodsFaultyAdmVo = edgeGoodsFaultyAdmList.get(0);
						
						//엣지 불량 값 담아주기
						workOrdOutputSubVo.setEdgeInspctDate(edgeGoodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setEdgeFaultyCnt(edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt());
						workOrdOutputSubVo.setEdgeInspctCharger(edgeGoodsFaultyAdmVo.getInspctCharger());
					}
					
					//불량 수량 까지 합쳐진 값
					workOrdOutputSubVo.setUserInputInspctCnt( goodsFaultyAdmVo.getTotalAppearFaultyCnt() + edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt() );
			
					//작업지시 생산수량 서브 저장
					if( ( goodsFaultyAdmList.size() + edgeGoodsFaultyAdmList.size() ) != 0) {
						workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
					}
					//작업지시 생산수량 서브	 저장 끝
					
					
					
					
					
					
					//작업지시 생산수량 서브	_insert
					workOrdOutputSubVo = new WorkOrdOutputSubVo();
					workOrdOutputSubVo.setWorkOrdNo( workOrdNo );						//작업지시번호
					workOrdOutputSubVo.setWorkOrdLotNo( workOrdNo + "-T" + "N" + 1 );	//생산LotNo
					workOrdOutputSubVo.setWorkOrdSeq( Integer.toString( (1) ) );		//시퀀스
					workOrdOutputSubVo.setOrdLotNo( workOrdNo +"-T" );					//작지 LotNo
					workOrdOutputSubVo.setLotNo( data.getMatrlLotNo() );						//주자재 LotNo
					workOrdOutputSubVo.setSubWorkStatusCd("A");							//작업 상태
					workOrdOutputSubVo.setOutputCnt( 0 );								//생산수량
					workOrdOutputSubVo.setGubun( "N" );									//주/야 구분
					workOrdOutputSubVo.setWorkOrdDate( data.getOrdDate() );				//전표일자
					workOrdOutputSubVo.setMainWorkChargr( data.getWorkerId() );			//담당자
					workOrdOutputSubVo.setPackYn("Y");									//포장 여부
					workOrdOutputSubVo.setUserInputInspctCnt( 0 );						//검사수량
					workOrdOutputSubVo.setRegId( Utils.getUserId() );					//등록자
					//작업지시 생산수량 서브	_insert
					
					//야간 실적 조회 후 저장
					goodsFaultyAdmVo = new GoodsFaultyAdmVo();
					goodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
					goodsFaultyAdmVo.setDayNightCd("N");			//주야 구분
					goodsFaultyAdmList = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdmVo);
					
					//엣지 불량 수량 조회
					edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
					edgeGoodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );				//생산 전표 번호
					edgeGoodsFaultyAdmVo.setDayNightCd("N");			//주야 구분
					edgeGoodsFaultyAdmList = goodsInspectService.readEdgeGoodsFaultyAdmCode(edgeGoodsFaultyAdmVo);
					
					checkCount = checkCount + goodsFaultyAdmList.size() + edgeGoodsFaultyAdmList.size();
					
					//외관 불량 등록 되어 있을 때
					if( goodsFaultyAdmList.size() != 0) {
						goodsFaultyAdmVo = new GoodsFaultyAdmVo();
						goodsFaultyAdmVo = goodsFaultyAdmList.get(0);
						
						//외관 불량 값 담아주기
						workOrdOutputSubVo.setAppearOutputCnt(0);
						workOrdOutputSubVo.setAppearInspctDate(goodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setAppearFaultyCnt(goodsFaultyAdmVo.getTotalAppearFaultyCnt());
						workOrdOutputSubVo.setAppearInspctCharger(goodsFaultyAdmVo.getInspctCharger());
					}
					
					//엣지 검사 등록 되어 있을 때
					if( edgeGoodsFaultyAdmList.size() != 0) {
						edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
						edgeGoodsFaultyAdmVo = edgeGoodsFaultyAdmList.get(0);
						
						//엣지 불량 값 담아주기
						workOrdOutputSubVo.setEdgeInspctDate(edgeGoodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setEdgeFaultyCnt(edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt());
						workOrdOutputSubVo.setEdgeInspctCharger(edgeGoodsFaultyAdmVo.getInspctCharger());
					}
					
					//불량 수량 까지 합쳐진 값
					workOrdOutputSubVo.setUserInputInspctCnt( goodsFaultyAdmVo.getTotalAppearFaultyCnt() + edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt() );
			
					//작업지시 생산수량 서브 저장
					if( ( goodsFaultyAdmList.size() + edgeGoodsFaultyAdmList.size() ) != 0) {
						workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
					}
					//작업지시 생산수량 서브	 저장 끝
					
					//작지만 만들어진 경우
					if( checkCount == 0) {
						
						workOrdOutputSubVo = new WorkOrdOutputSubVo();
						workOrdOutputSubVo.setWorkOrdNo( workOrdNo );						//작업지시번호
						workOrdOutputSubVo.setWorkOrdLotNo( workOrdNo + "-T" + data.getOrdGubun() + 1 );	//생산LotNo
						workOrdOutputSubVo.setWorkOrdSeq( Integer.toString( (1) ) );		//시퀀스
						workOrdOutputSubVo.setOrdLotNo( workOrdNo +"-T" );					//작지 LotNo
						workOrdOutputSubVo.setLotNo( data.getMatrlLotNo() );						//주자재 LotNo
						workOrdOutputSubVo.setSubWorkStatusCd("A");							//작업 상태
						workOrdOutputSubVo.setOutputCnt( 0 );								//생산수량
						workOrdOutputSubVo.setGubun( data.getOrdGubun() );									//주/야 구분
						workOrdOutputSubVo.setWorkOrdDate( data.getOrdDate() );				//전표일자
						workOrdOutputSubVo.setMainWorkChargr( data.getWorkerId() );			//담당자
						workOrdOutputSubVo.setPackYn("Y");									//포장 여부
						workOrdOutputSubVo.setUserInputInspctCnt( 0 );						//검사수량
						workOrdOutputSubVo.setRegId( Utils.getUserId() );					//등록자
						
						workOrdOutputSubService.workOrdOutputSubCreate(workOrdOutputSubVo);
					}
					
					
				}
			//}
		} catch (Exception e) {
			check = true;
			e.printStackTrace();
		}
		return check;
	}
	
	//생산실적트레이 Update
	public @ResponseBody boolean trayFaultyRelatedUpdate(String workOrdNo, int outputTotalCnt) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		boolean check = false;
		try {
			
			//외관&엣지가 먼저 등록되어있는 경우 처리 시작
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo( workOrdNo );
			workOrdOutputSubVo.setWorkOrdSeq("1");
			workOrdOutputSubVo = workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			GoodsFaultyAdmVo goodsFaultyAdmVo = new GoodsFaultyAdmVo();
			goodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );
			//goodsFaultyAdmVo = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdmVo);
			List<GoodsFaultyAdmVo> goodsFaultyAdmList = goodsInspectService.readGoodsFaultyAdmCode(goodsFaultyAdmVo);
			
			EdgeGoodsFaultyAdmVo edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
			edgeGoodsFaultyAdmVo.setOrdLotNo( workOrdNo +"-T" );
			List<EdgeGoodsFaultyAdmVo> edgeGoodsFaultyAdmList = goodsInspectService.readEdgeGoodsFaultyAdmCode(edgeGoodsFaultyAdmVo);
			
			//외관 검사 등록 되어 있을 때
			if( goodsFaultyAdmList.size() != 0) {
				goodsFaultyAdmVo = new GoodsFaultyAdmVo();
				goodsFaultyAdmVo = goodsFaultyAdmList.get(0);
				
				// 생산 실적이 등록되어있을 때
				if( workOrdOutputSubVo.getWorkOrdNo() != null ) {
					//외관 불량 일이 빈 값 일 때
					//if ( workOrdOutputSubVo.getAppearInspctDate() == null ) {
						workOrdOutputSubVo.setAppearInspctDate(goodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setAppearFaultyCnt(goodsFaultyAdmVo.getTotalAppearFaultyCnt());
						workOrdOutputSubVo.setAppearInspctCharger(goodsFaultyAdmVo.getInspctCharger());
						//workOrdOutputSubVo.setAppearOutputCnt( outputTotalCnt - goodsFaultyAdmVo.getTotalAppearFaultyCnt() );
					//}
				}
				//workOrdOutputSubVo.setAppearOutputCnt( outputTotalCnt - goodsFaultyAdmVo.getTotalAppearFaultyCnt() );
			}
			
			//엣지 검사 등록 되어 있을 때
			if( edgeGoodsFaultyAdmList.size() != 0) {
				edgeGoodsFaultyAdmVo = new EdgeGoodsFaultyAdmVo();
				edgeGoodsFaultyAdmVo = edgeGoodsFaultyAdmList.get(0);
				// 생산 실적이 등록되어있을 때
				if( workOrdOutputSubVo.getWorkOrdNo() != null ) {
					
					//외관 불량 일이 빈 값 일 때
					//if ( workOrdOutputSubVo.getEdgeInspctDate() == null ) {
						workOrdOutputSubVo.setEdgeInspctDate(edgeGoodsFaultyAdmVo.getFaultyRegDate());
						workOrdOutputSubVo.setEdgeFaultyCnt(edgeGoodsFaultyAdmVo.getTotalEdgeFaultyCnt());
						workOrdOutputSubVo.setEdgeInspctCharger(edgeGoodsFaultyAdmVo.getInspctCharger());
					//}
				}
			}

			if( goodsFaultyAdmList.size() != 0 && edgeGoodsFaultyAdmList.size() != 0 ) {
				workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
				workOrdOutputSubVo.setWorkOrdSeq("1");
				workOrdOutputSubVo.setUpdId( Utils.getUserId() );	//수장자
				workOrdOutputSubVo.setFaultyTrayCheckNum("001");	//전체: 001, 엣지만: 002, 외관만: 003
				workOrdOutputSubService.workOrdOutputSubTrayFaultyRelatedUpdate(workOrdOutputSubVo);
				//외관&엣지가 먼저 등록되어있는 경우 처리 종료				
			}
			
			check = false;
			
		} catch (Exception e) {
			check = true;
			e.printStackTrace();
		}
		return check;
	}
	
	//생산실적트레이 싱글 톤 확인
	@RequestMapping(value="po/productionPerfTraySingleTonCheck" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTraySingleTonCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			Settings singletonSettings = Settings.getInstance();
			logger.info("생산실적트레이 싱글 톤 확인: "+singletonSettings.useTrayProduce);
			Boolean check = singletonSettings.useTrayProduce;
			
			jsonData.put("data", check);
			jsonData.put("array", Arrays.asList(singletonSettings.useTrayProduceArray));
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//변경된 값 존재하는지 상태 확인( 수정: 001 / 삭제:002 / 혼입: 003 )
	public @ResponseBody boolean trayStatusCheck( JSONArray jsonArray, String equipCd, String workOrdNo, String gubun, String lgesGubun, String productDate ) throws Exception{
		boolean check = false;
		try {
			JSONParser jsonParser	= new JSONParser();
			JSONObject jsonObj		= new JSONObject();
			
			//저장되어있는 값 불러 오기
			ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
			productionPerfTrayVo.setEquipCd(equipCd);
			productionPerfTrayVo.setWorkOrdNo(workOrdNo);
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayList(productionPerfTrayVo);
			List<ProductionPerfTrayVo> trayInfoBeforeAfterList = new ArrayList<>(); 
			
			if( "N".equals(lgesGubun) ) {
				trayInfoBeforeAfterList = productionPerfTrayService.trayInfoBeforeAfterList(productionPerfTrayVo);	
			} else if( "Y".equals(lgesGubun) ) {
				productionPerfTrayVo.setProductDate(productDate);
				trayInfoBeforeAfterList = productionPerfTrayService.lgesTrayInfoBeforeAfterList(productionPerfTrayVo);	
			} else {
				check = true;
				return check;
			}
			
			
			logger.info("ListArray ---------> "+productionPerfTrayList);
			logger.info("JSONArray ---------> "+jsonArray);

			logger.info("ListArray ---------> "+productionPerfTrayList.size());
			logger.info("ListArray2 ---------> "+trayInfoBeforeAfterList.size());
			logger.info("JSONArray ---------> "+jsonArray.size());
			
			String beforeTray	= "";
			String beforeStatus = "";
			String beforeVisonMix = "";
			String beforeMatelMix = "";
			
			String afterTray	= "";
			String afterStatus	= "";
			String afterVisonMix = "";
			String afterMatelMix = "";
			
			//이거 진짜 화나네..
			
			//수정: 001 / 삭제 검사: 002
			/*if( gubun.equals("002") ) {
				if( jsonArray.size() != trayInfoBeforeAfterList.size() ) {
					check = true;
					return check;
				}
			}*/
			
			//상태 값 검사 시작
			for(int i=0; i<jsonArray.size(); i++) {
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				
				beforeTray		= jsonObjDtl.get("trayNo").toString()+"_";
				beforeStatus	= jsonObjDtl.get("productStatus").toString();
				if( gubun.equals("003") ) {
					beforeVisonMix	= jsonObjDtl.get("afterIncorporationVisonGubun").toString();
					beforeMatelMix	= jsonObjDtl.get("afterIncorporationGubun").toString();
				} else {
					beforeVisonMix	= jsonObjDtl.get("incorporationVisonGubun").toString();
					beforeMatelMix	= jsonObjDtl.get("incorporationGubun").toString();					
				}
				
				logger.info("1>>>>>>>>>>>>>>>>>>>>>>>>>>>" + beforeTray);
				
				for(int k=0; k<productionPerfTrayList.size(); k++) {
					afterTray		= productionPerfTrayList.get(k).getTrayNo()+"_";
					afterStatus		= productionPerfTrayList.get(k).getProductStatus();
					afterVisonMix	= productionPerfTrayList.get(k).getIncorporationVisonGubun();
					afterMatelMix	= productionPerfTrayList.get(k).getIncorporationGubun();
					
					logger.info("2>>>>>>>>>>>>>>>>>>>>>>>>>>>" + afterTray);
					
					if( beforeTray.substring(0, beforeTray.indexOf("-T")).equals(workOrdNo) ) {
						//같은 작지인 경우 처리
						if( beforeTray.equals( afterTray ) || beforeTray.substring( 0, beforeTray.indexOf('_') ).equals( afterTray.substring(0, beforeTray.indexOf('_')) ) ) {
							
							if( beforeStatus.equals( afterStatus ) && beforeVisonMix.equals(afterVisonMix) && beforeMatelMix.equals(afterMatelMix)  ) {
								logger.info("ListArray ---------> "+ afterTray +":::::::::::::::::::"+ afterStatus);
								logger.info("JSONArray ---------> "+ beforeTray +":::::::::::::::::::"+ beforeStatus);
								check = false;
								productionPerfTrayList.remove(k);
								break;
								
							} else {
								check = true;
								return check;
							}
						}
						//같은 작지인 경우 처리 끝
					} else {
						//다른 작지인 경우 처리
						afterTray		= trayInfoBeforeAfterList.get(k).getTrayNo()+"_";
						afterStatus		= trayInfoBeforeAfterList.get(k).getProductStatus();
						afterVisonMix	= trayInfoBeforeAfterList.get(k).getIncorporationVisonGubun();
						afterMatelMix	= trayInfoBeforeAfterList.get(k).getIncorporationGubun();
						
						logger.info("3>>>>>>>>>>>>>>>>>>>>>>>>>>>" + afterTray);
						
						//같은 작지인 경우 아래 코드 실행
						if( beforeTray.equals( afterTray ) || beforeTray.substring( 0, beforeTray.indexOf('_') ).equals( afterTray.substring(0, beforeTray.indexOf('_')) ) ) {
							
							if( beforeStatus.equals( afterStatus ) && beforeVisonMix.equals(afterVisonMix) && beforeMatelMix.equals(afterMatelMix)  ) {
								
								logger.info("ListArray ---------> "+ afterTray +":::::::::::::::::::"+ afterStatus);
								logger.info("JSONArray ---------> "+ beforeTray +":::::::::::::::::::"+ beforeStatus);
								check = false;
								trayInfoBeforeAfterList.remove(k);
								break;
								
							} else {
								check = true;
								return check;
							}
						}
						//다른 작지인 경우 처리 끝
					}
				}
			}
			
			/*jsonObj.put(0, jsonArray.get(0));
			JSONObject jsonObjDtl2 = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
			
			int editSaveCount = Integer.parseInt(jsonObjDtl2.get("editSaveCount").toString());*/
			
			/*
			 * List<ProductionPerfTrayVo> trayInfoBeforeAfterList2 =
			 * (List<ProductionPerfTrayVo>) productionPerfTrayVo;
			 * 
			 * trayInfoBeforeAfterList.get( (trayInfoBeforeAfterList.size()-1)
			 * ).getTrayNo(); logger.info(">>>>>>>>>>>>>>>>>>>>>>>>>>"
			 * +trayInfoBeforeAfterList.get( (trayInfoBeforeAfterList.size()-1)
			 * ).getTrayNo()); productionPerfTrayList.indexOf( trayInfoBeforeAfterList.get(
			 * (trayInfoBeforeAfterList.size()-1) ).getTrayNo() );
			 * 
			 * //logger.info( "222222222222222>>>>>>>>>" + productionPerfTrayList.contains(
			 * trayInfoBeforeAfterList.get( (trayInfoBeforeAfterList.size()-1) ).getTrayNo()
			 * ) ); logger.info( "222222222222222>>>>>>>>>" +
			 * productionPerfTrayList.indexOf( trayInfoBeforeAfterList.get(
			 * (trayInfoBeforeAfterList.size()-1) ).getTrayNo() ) );
			 */
			
			
			/*
			 * logger.info("ListArray ---------> "+trayInfoBeforeAfterList);
			 * logger.info("JSONArray ---------> "+jsonArray);
			 * 
			 * logger.info("JSONArray ---------> "+jsonArray.size());
			 * logger.info("JSONArray ---------> "+trayInfoBeforeAfterList.size());
			 */
			
			/*if( jsonArray.size() == 0 || trayInfoBeforeAfterList.size() == 0 ) {
				//잘못된 정보
				check = true;
			} else {
				
				//삭제 처리 시
				if( jsonArray.size() == trayInfoBeforeAfterList.size() ) {
					
				}
			}*/
			//저장 처리 시
			/*if( jsonArray.size() != 0 && trayInfoBeforeAfterList.size() != 0 ) {
				if( (jsonArray.size() - trayInfoBeforeAfterList.size()) == editSaveCount ) {
					check = false;
				} else {
					check = true;
				}
			}*/
			
			/*if( jsonArray.size() != trayInfoBeforeAfterList.size() || trayInfoBeforeAfterList.size() == 0 || jsonArray.size() == 0 ) {
				check = true;
				return check;
			} else {
				for(int i=0; i<=jsonArray.size(); i++) {
					jsonObj.put(i, jsonArray.get(i));
					JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
					
					logger.info("ListArray ---------> "+ trayInfoBeforeAfterList.get(i).getTrayNo() +":::::::::::::::::::"+ trayInfoBeforeAfterList.get(i).getProductStatus());
					logger.info("JSONArray ---------> "+ jsonObjDtl.get("trayNo").toString() +":::::::::::::::::::"+ jsonObjDtl.get("productStatus").toString());
				}
			}*/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}
	
	//생산관리 - 트레이 생산수량 조회
	@RequestMapping(value = "/wmsc0190", method = RequestMethod.GET)
	public String wmsc0190GET(Locale locale, Model model) throws Exception {
		
		logger.info("생산관리 - 트레이 생산수량 조회");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("066"); // 검사상태(수입검사 합격여부)
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspStatus", systemCommonCodeList );
		
		return "wm/wmsc0190";
	}
	
	//생산실적트레이 생산수량 조회 
	@RequestMapping(value="po/productionPerfTrayProductQtyList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayProductQtyList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.productionPerfTrayProductQtyList(productionPerfTrayVo);
			jsonData.put("data", productionPerfTrayList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산실적트레이_Rank 
	@RequestMapping(value="po/productionPerfTrayRankList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> productionPerfTrayRankList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			List<ProductionPerfTrayVo> productionPerfTrayRankList = productionPerfTrayService.productionPerfTrayRankList(productionPerfTrayVo);
			
			jsonData.put("data", productionPerfTrayRankList);
			jsonData.put("reprintYn", productionPerfTrayRankList.get(0).getTrayReprintYn());
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	
	
	//LGES_관련 코드
	
	//LGES_생산실적트레이 조회
	@RequestMapping(value="po/lgesProductionPerfTrayList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> lgesProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			
			//이전 6개 실적 트레이
			List<ProductionPerfTrayVo> lgesEveProductionPerfTrayList = productionPerfTrayService.lgesEveProductionPerfTrayList(productionPerfTrayVo);
			String notTrayNo = "";
			if( lgesEveProductionPerfTrayList.size() != 0 ) {
				for(ProductionPerfTrayVo m : lgesEveProductionPerfTrayList) {
					notTrayNo += ",'"+ m.getTrayNo() + "'";
				}
				notTrayNo = notTrayNo.substring(1, notTrayNo.length());
			} else {
				notTrayNo = "' '";
			}
			
			productionPerfTrayVo.setNotTrayNo(notTrayNo);
			
			List<ProductionPerfTrayVo> productionPerfTrayList = productionPerfTrayService.lgesProductionPerfTrayList(productionPerfTrayVo);
			jsonData.put("data", productionPerfTrayList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//LGES_생산실적트레이 조회
	@RequestMapping(value="po/lgesEveProductionPerfTrayList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> lgesEveProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			//LGES_생산실적트레이 조회
			List<ProductionPerfTrayVo> lgesEveProductionPerfTrayList = productionPerfTrayService.lgesEveProductionPerfTrayList(productionPerfTrayVo);
			jsonData.put("data", lgesEveProductionPerfTrayList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//LGES_생산실적트레이 이전 행&현재 행 조회
	@RequestMapping(value="po/lgesTrayInfoBeforeAfterList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> lgesTrayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_생산실적트레이 이전 행&현재 행 조회: "+productionPerfTrayVo);
		try {
			List<ProductionPerfTrayVo> lgesTrayInfoBeforeAfterList = productionPerfTrayService.lgesTrayInfoBeforeAfterList(productionPerfTrayVo);
			jsonData.put("data", lgesTrayInfoBeforeAfterList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//LGES_개별 수량 조회
	@RequestMapping(value="po/lgesProductQty" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> lgesProductQty(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_생산실적트레이 이전 행&현재 행 조회: "+productionPerfTrayVo);
		try {
			//제품별 생산 수량 값 확인
			int productQty	= 0;
			String lgesCode	= "";
			
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			goodsCodeAdmVo.setGoodsCd( productionPerfTrayVo.getGoodsCd() );
			goodsCodeAdmVo	= goodsCodeAdmService.read(goodsCodeAdmVo);
			productQty		= Integer.parseInt(goodsCodeAdmVo.getProductQty().toString());
			lgesCode		= String.valueOf(goodsCodeAdmVo.getLgesCode());
			
			//제품 생산 수량 0인 경우 반환
			if( productQty == 0 || lgesCode == null || "".equals(lgesCode) || "null".equals(lgesCode) ) {
				jsonData.put("result", "fail");
				jsonData.put("message", "해당 제품에 트레이생산 수량 또는 LGES코드가 등록되어있지 않습니다.<br>제품코드관리에서 등록 후 다시 시도해주세요!");
				return jsonData;
			} else {
				//제품별 생산 수량 값 확인
				jsonData.put("productQty", productQty);
				jsonData.put("lgesCode", lgesCode);
				jsonData.put("result", "ok");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	//LGES_생산실적트레이 조회
	@RequestMapping(value="po/lgesCodePrintCheck" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> lgesCodePrintCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_생산실적트레이 조회 : "+productionPerfTrayVo);
		try {
			
			//LGES_코드 출력 여부 확인
			List<ProductionPerfTrayVo> lgesCodePrintCheck = productionPerfTrayService.lgesCodePrintCheck(productionPerfTrayVo);
			jsonData.put("data", lgesCodePrintCheck);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//LGES_프린트 출력 여부
	@RequestMapping(value="po/lgesPrintWhetherCreate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> lgesPrintWhetherCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_프린트 출력 여부 등록 : "+productionPerfTrayVo);
		try {
			//생산실적트레이테이블 등록
			productionPerfTrayVo.setRegId( Utils.getUserId() );
			productionPerfTrayService.lgesPrintWhetherCreate(productionPerfTrayVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//LGES_프린트 여부 수정
	@RequestMapping(value="po/lgesPrintWhetherUpdate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> lgesPrintWhetherUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_프린트 출력 여부 등록 : "+productionPerfTrayVo);
		try {
			//LGES_프린트 여부 수정
			productionPerfTrayVo.setUpdId( Utils.getUserId() );
			productionPerfTrayService.lgesPrintWhetherUpdate(productionPerfTrayVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//LGES_프린트 여부 삭제
	@RequestMapping(value="po/lgesPrintDelete" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> lgesPrintDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_프린트 출력 여부 등록 : "+productionPerfTrayVo);
		try {
			//LGES_프린트 여부 삭제
			productionPerfTrayVo.setWorkOrdNo(null);
			productionPerfTrayService.lgesPrintDelete(productionPerfTrayVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//프린트사이즈규격 읽기
	@RequestMapping(value="po/printSizManageRead" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> printSizManageRead(PrintSizManageVo printSizManageVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("프린트사이즈규격 읽기 : "+printSizManageVo);
		try {
			PrintSizManageVo printSizManageRead = printSizManageService.printSizManageRead(printSizManageVo);
			jsonData.put("data", printSizManageRead);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//프린트사이즈규격 저장
	@RequestMapping(value="po/printSizManageCreate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> printSizManageCreate(PrintSizManageVo printSizManageVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("프린트사이즈규격 저장 : "+printSizManageVo);
		try {
			
			PrintSizManageVo printSizManageRead = printSizManageService.printSizManageRead(printSizManageVo);
			
			if( printSizManageRead != null ) {
				printSizManageVo.setUpdId( Utils.getUserId() );
				printSizManageService.printSizManageUpdate(printSizManageVo);
				jsonData.put("result", "ok");
			} else {
				printSizManageVo.setRegId( Utils.getUserId() );
				printSizManageService.printSizManageCreate(printSizManageVo);
				jsonData.put("result", "ok");	
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	//개별 트레이 출력 여부 수정
	@RequestMapping(value="po/trayReprintCheckUpdate" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> trayReprintCheckUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("LGES_프린트 출력 여부 등록 : "+productionPerfTrayVo);
		try {
			//개별 트레이 출력 여부 수정
			productionPerfTrayService.trayReprintCheckUpdate(productionPerfTrayVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	//LGES_CODE와 LABE_LOT_NO 매칭 시키는 부분 (객체 전달 시 객체에 대한 참조가 복사됨(얕은 복사))
	private void processLabel(String lgesCode, String labelLotNo, String labelLotNoSeq, ProductionPerfTrayVo trayVoDtl) {
	    String[] lgesCodeSplit = lgesCode.split("-");

	    labelLotNo		= labelLotNo.replace(labelLotNo.substring(labelLotNo.indexOf('-')+2, labelLotNo.length()), (lgesCodeSplit[2] + lgesCodeSplit[3]));
	    labelLotNoSeq	= labelLotNoSeq.replace(labelLotNoSeq.substring(labelLotNoSeq.indexOf('-')+2, labelLotNoSeq.length()-2), (lgesCodeSplit[2] + lgesCodeSplit[3]));

	    trayVoDtl.setLabelLotNo(labelLotNo);
	    trayVoDtl.setLabelLotNoSeq(labelLotNoSeq);

	    trayVoDtl.setLgesCode(lgesCode);
	}
	
	
	
}