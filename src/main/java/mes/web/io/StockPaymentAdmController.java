package mes.web.io;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class StockPaymentAdmController {
	
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	
	//수불 이력(자재&제품) :
	@RequestMapping(value = "/tmsc0120", method = RequestMethod.GET)
	public String tmsc0120(Locale locale, Model model) throws Exception {
		logger.info("수불 이력(자재&제품)");
		
		return "tm/tmsc0120";
	}
	
	//수불 이력(자재&제품) :
	@RequestMapping(value = "/io/readStockPaymentAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> readStockPaymentAdmList(StockPaymentAdmVo stockPaymentAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("수불 이력(자재&제품) : " + stockPaymentAdmVo);
		try {				
			List<StockPaymentAdmVo> readStockPaymentAdmList = stockPaymentAdmService.readStockPaymentAdmList(stockPaymentAdmVo);		
			jsonData.put("data", readStockPaymentAdmList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("수불 이력(자재&제품) :");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
			
		return jsonData;
	}
	
	//자재 수불 +
	public static StockPaymentAdmVo matrlStockPaymentPlus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		stockPaymentAdmVo.setSpCd(matrlInOutWhsAdmVo.getMatrlCd());		//자재코드
			stockPaymentAdmVo.setLotNo(matrlInOutWhsAdmVo.getLotNo());		//자재 LotNo
			stockPaymentAdmVo.setSpType("001");								//001 : 자재, 002 : 생산제품, 003 : 제품초기재고
			stockPaymentAdmVo.setSpCount(1);													//개수(추후 필름일 경우 슬리팅개수)
			stockPaymentAdmVo.setSpQty(Float.parseFloat(matrlInOutWhsAdmVo.getRemainQty()));	//무게
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
			//가입고(Start)-수입검사(Inspection)-승인(Approval)-가출고(Output)-생산투입(Product)
			//승인(001)-미승인(002)-불량(003)-보류(004)-반품(005)-실제반품(006)-자체폐기(007)-폐기(008)-재사용(009)
			//가입고&승인
			if ("S".equals(matrlInOutWhsAdmVo.getStatusCd()) && "001".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("001");
    		//가입고&미승인
			} else if ("S".equals(matrlInOutWhsAdmVo.getStatusCd()) && "002".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
    			stockPaymentAdmVo.setSpGubun("I");
    			stockPaymentAdmVo.setLocationCd("001");	//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
    		//가입고&불량
    		} else if ("S".equals(matrlInOutWhsAdmVo.getStatusCd()) && "003".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
    			stockPaymentAdmVo.setSpGubun("I");
    			stockPaymentAdmVo.setLocationCd("003");
    		//가입고&보류
    		} else if ("S".equals(matrlInOutWhsAdmVo.getStatusCd()) && "004".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
    			stockPaymentAdmVo.setSpGubun("I");
    			stockPaymentAdmVo.setLocationCd("002");
    			
			//승인&승인
    		} else if ("A".equals(matrlInOutWhsAdmVo.getStatusCd()) && "001".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("001");
			//승인&재사용
    		} else if ("A".equals(matrlInOutWhsAdmVo.getStatusCd()) && "009".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("001");
			//폐기반품	
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "010".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//수입검사&미승인
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "002".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("001");
			//수입검사&불량
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "003".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//수입검사&보류
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "004".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("002");
			//수입검사&반품
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "005".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//수입검사&실제반품
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "006".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//수입검사&자체폐기
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "007".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//수입검사&폐기
    		} else if ("I".equals(matrlInOutWhsAdmVo.getStatusCd()) && "008".equals(matrlInOutWhsAdmVo.getApprovalCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("003");
			//출고&승인
			} else if ("O".equals(matrlInOutWhsAdmVo.getStatusCd())) {
				stockPaymentAdmVo.setSpGubun("I");
				stockPaymentAdmVo.setLocationCd("004");
			}
				
			
		} catch (Exception e) {
			logger.info("자재 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//자재 수불 -
	public static StockPaymentAdmVo matrlStockPaymentMinus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo, String spGubun, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//lotNo,regId,spGubun만 있으면 됨, 나머진 쿼리에서 다함
			stockPaymentAdmVo.setLotNo(matrlInOutWhsAdmVo.getLotNo());
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			stockPaymentAdmVo.setSpGubun(spGubun);
		} catch (Exception e) {
			logger.info("자재 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	
	//제품 검사 종료  +
	public static StockPaymentAdmVo goodsInspctStockPaymentPlus(WorkOrdOutputSubVo workOrdOutputSubVo, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
    		stockPaymentAdmVo.setSpCd(workOrdOutputSubVo.getGoodsCd());
			stockPaymentAdmVo.setLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
			stockPaymentAdmVo.setSpType("002");
			stockPaymentAdmVo.setSpGubun("I");
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(workOrdOutputSubVo.getAppearOutputCnt());
			stockPaymentAdmVo.setLocationCd("005");
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 검사 종료 -
	public static StockPaymentAdmVo goodsInspctStockPaymentMinus(WorkOrdOutputSubVo workOrdOutputSubVo, String spGubun, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
			stockPaymentAdmVo.setLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
			stockPaymentAdmVo.setLocationCd("005");
			stockPaymentAdmVo.setSpGubun(spGubun);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 포장 대기 +
	public static StockPaymentAdmVo goodsUnpackStockPaymentPlus(WorkOrdOutputSubVo workOrdOutputSubVo, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
    		stockPaymentAdmVo.setSpCd(workOrdOutputSubVo.getGoodsCd());
			stockPaymentAdmVo.setLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
			stockPaymentAdmVo.setSpType("002");
			stockPaymentAdmVo.setSpGubun("I");
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(workOrdOutputSubVo.getUserOutputCnt());
			stockPaymentAdmVo.setLocationCd("006");
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 포장대기 복원
	public static StockPaymentAdmVo goodUnpackStockPaymentMinus(WorkOrdOutputSubVo workOrdOutputSubVo, String spGubun, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
			stockPaymentAdmVo.setLotNo(workOrdOutputSubVo.getWorkOrdLotNo());
			stockPaymentAdmVo.setLocationCd("006");
			stockPaymentAdmVo.setSpGubun(spGubun);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	
	
	//제품 포장 실행(포장대기 -)
	public static StockPaymentAdmVo goodsUnPackMinus(String goodsCd, String workOrdLotNo, int readPackUnitNm, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
			stockPaymentAdmVo.setSpCd(goodsCd);
			stockPaymentAdmVo.setLotNo(workOrdLotNo);
			stockPaymentAdmVo.setSpType("002");
			stockPaymentAdmVo.setSpGubun("O");
			stockPaymentAdmVo.setLocationCd("006");
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(readPackUnitNm);
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
			
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 포장 실행(포장완료 +)
	public static StockPaymentAdmVo goodsPackPlus(String goodsCd, String boxNo, int readPackUnitNm, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
			stockPaymentAdmVo.setSpCd(goodsCd);
			stockPaymentAdmVo.setLotNo(boxNo);
			stockPaymentAdmVo.setSpType("002");
			stockPaymentAdmVo.setSpGubun("I");
			stockPaymentAdmVo.setLocationCd("007");
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(readPackUnitNm);
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 수불에 기본적으로 사용
	public static StockPaymentAdmVo goodsStockPaymentHist(String goodsCd, String boxNo, String spType, String spGubun, String locationCd, int readPackUnitNm, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
			stockPaymentAdmVo.setSpCd(goodsCd);
			stockPaymentAdmVo.setLotNo(boxNo);
			stockPaymentAdmVo.setSpType(spType);
			stockPaymentAdmVo.setSpGubun(spGubun);
			stockPaymentAdmVo.setLocationCd(locationCd);
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(readPackUnitNm);
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}
	
	//제품 포장 복원(포장대기 +)
	public static StockPaymentAdmVo goodsUnPackPlus(String goodsCd, String workOrdLotNo, int readPackUnitNm, String factoryCode) throws Exception {
		StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
    	try {
    		//001:자재 재고창고, 002:자재 대기창고, 003:자재 부적합창고, 004:자재 생산실 창고, 005:제품 검사완료 창고, 006:제품 포장대기 창고, 007:제품 포장완료, 008:제품 입고창고, 009:제품 대기창고, 010:제품 부적합창고
			stockPaymentAdmVo.setSpCd(goodsCd);
			stockPaymentAdmVo.setLotNo(workOrdLotNo);
			stockPaymentAdmVo.setSpType("002");
			stockPaymentAdmVo.setSpGubun("I");
			stockPaymentAdmVo.setLocationCd("006");
			stockPaymentAdmVo.setSpQty(1);
			stockPaymentAdmVo.setSpCount(readPackUnitNm);
			stockPaymentAdmVo.setFactoryCd(factoryCode);
			stockPaymentAdmVo.setRegId(Utils.getUserId());
		} catch (Exception e) {
			logger.info("제품 수불 판단 시스템에러");
			e.printStackTrace();
		}
    	
    	return stockPaymentAdmVo;
	}

}