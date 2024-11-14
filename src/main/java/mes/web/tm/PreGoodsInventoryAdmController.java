package mes.web.tm;

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
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.pd.PdaService;
import mes.service.tm.InventoryAdmService;
import mes.service.tm.PreGoodsInventoryAdmService;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Film;
import mes.web.ut.Utils;

@Controller
public class PreGoodsInventoryAdmController {

	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	@Inject
	private PreGoodsInventoryAdmService preGoodsInventoryAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private InventoryAdmService inventoryAdmService;
	@Inject
	private PdaService PdaService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	@Value("${factoryCode}") private String facotryCode;

	private static final Logger logger = LoggerFactory.getLogger(PreGoodsInventoryAdmController.class);

	//선처리재고관리정보 초기제품재고관리 메인
	@RequestMapping(value = "/tmsc0060", method = RequestMethod.GET)
	public String preGoodsInventoryAdmMain(Locale locale, Model model) throws Exception {

		logger.info("선처리재고관리정보 초기제품재고관리 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("orderGubunCd", systemCommonCodeList);

		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		return "tm/tmsc0060";
	}

	//선처리재고관리정보 목록조회
	@RequestMapping(value = "/tm/preGoodsInventoryDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preGoodsInventoryDataList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 목록조회");

		try {
			List<PreGoodsInventoryAdmVo> preGoodsInventoryDataList = preGoodsInventoryAdmService.listPreInvntryAll(preGoodsInventoryAdmVo);
			jsonData.put("data", preGoodsInventoryDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("선처리재고관리정보 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}

	//선처리재고관리정보 상세조회
	@RequestMapping(value = "/tm/preGoodsInventoryData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsCodeData(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 상세조회");

		try {
			preGoodsInventoryAdmVo = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
			jsonData.put("data", preGoodsInventoryAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("선처리재고관리정보 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 상세 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
	
	//재고등록 - 임시 BoxNo 채번 후 출력
	//@RequestMapping(value = "/tm/preGoodsInventoryDtlCheck", method = RequestMethod.GET)
	//public @ResponseBody Map<String, Object> preGoodsInventoryDtlCheck(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
    //
	//	Map<String, Object> jsonData = new HashMap<String, Object>();
	//	logger.info("재고 등록 임시 BoxNo 채번");
    //
	//	logger.info(preGoodsInventoryAdmVo.toString());
	//	try {
	//		//이미 등록되어 있는지 여부 확인
	//		PreGoodsInventoryAdmVo preGoodsInventoryAdmCheck = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
	//		if ( preGoodsInventoryAdmCheck==null ) {
	//			for (int i=0; i<preGoodsInventoryAdmVo.getInputBoxCnt(); i++) {
	//				
	//				
	//			}
	//		} else {
	//			
	//		}
	//		
	//		jsonData.put("data", preGoodsInventoryAdmVo);
	//		jsonData.put("result", "ok");
	//	} catch (Exception e) {
	//		logger.info("선처리재고관리정보 상세조회 오류");
	//		e.printStackTrace();
	//		jsonData.put("message", "선처리재고관리정보 상세 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
	//		jsonData.put("result", "fail");
	//	}
    //
	//	return jsonData;
	//}
	

	//재고관리-제품(초기재고) 등록
	@RequestMapping(value = "/tm/preGoodsInventoryCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsInventoryCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 등록 & 재고 제품 등록");
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();
		
		try {
			//preGoodsInventoryAdmVo.setLastYn("Y");
			PreGoodsInventoryAdmVo readPreGoodsInventoryAdm = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
			if (readPreGoodsInventoryAdm == null || readPreGoodsInventoryAdm.getInvntryNo() == null) {

				GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
				goodsCodeAdmVo.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
				goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);

				int boxCnt = preGoodsInventoryAdmVo.getInputBoxCnt();	//입력받은 제품 수량
				//초기제품Dtl BoxNo 채번&등록
				for (int i=1; i<=preGoodsInventoryAdmVo.getInputBoxCnt(); i++) {
					//초기재고 DTL 등록
					String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
					preGoodsInventoryDtl.setBoxNo("S" + packDate);
					
					int boxSeq = 0;
					//Al 제품 채번
					if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("A")) {
						boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqAl(preGoodsInventoryDtl);
						//0001~4999번대 채번시 시퀀스가 5000이면.. 채번시 중지, preCreate 수량도 조절
						if ( boxSeq == 5000 ) {
							boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
							jsonData.put("message", "AL 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
							jsonData.put("result", "fail");
							break;
						}
						
					//Nicu 제품 채번
					} else if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("N")) {
						boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqNicu(preGoodsInventoryDtl);
						if (boxSeq == 1) {
							boxSeq = 5001;
							
						//5001~9999번대 채번시 시퀀스가 10000 이면.. 채번 중지하기 수량 preCreate 시 수량도 조절
						} else if ( boxSeq == 10000) {
							boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
							jsonData.put("message", "Nicu 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
							jsonData.put("result", "fail");
							break;
						}
					}
					
					String boxNo = "S" + packDate.concat("-").concat(String.format("%04d", boxSeq));
					preGoodsInventoryDtl.setInvntryNo(preGoodsInventoryAdmVo.getInvntryNo());
					preGoodsInventoryDtl.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
					preGoodsInventoryDtl.setOrderGubunCd(preGoodsInventoryAdmVo.getOrderGubunCd());
					preGoodsInventoryDtl.setBoxNo(boxNo);
					preGoodsInventoryDtl.setPackCnt(preGoodsInventoryAdmVo.getPackCnt());
					preGoodsInventoryDtl.setRemainCnt(preGoodsInventoryAdmVo.getPackCnt());
					preGoodsInventoryDtl.setRegId(Utils.getUserId());
					preGoodsInventoryDtl.setHistId(Utils.getUserId());
					preGoodsInventoryDtl.setGoodsInDate(DateUtil.getToday("yyyymmdd"));
					
					preGoodsInventoryAdmService.preGoodsPackDtlCreate(preGoodsInventoryDtl);
					preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl);	//재고제품 입출고내역
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
					goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryAdmVo.getGoodsCd(), boxNo, "003", "I", "008", preGoodsInventoryAdmVo.getPackCnt(), facotryCode);	
					stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
				}
				
				//초기재고 ADM 등록
				preGoodsInventoryAdmVo.setCustomerModelNo(preGoodsInventoryAdmVo.getModelNo());
				//preGoodsInventoryAdmVo.setForwordBoxCnt(0);
				//preGoodsInventoryAdmVo.setInvntryBoxCnt(preGoodsInventoryAdmVo.getForwordBoxCnt() + boxCnt );
				preGoodsInventoryAdmVo.setInputBoxCnt(boxCnt);
				preGoodsInventoryAdmVo.setInvntryBoxCnt(boxCnt);
				preGoodsInventoryAdmVo.setLastYn("Y");
				preGoodsInventoryAdmVo.setRegId(Utils.getUserId());
				preGoodsInventoryAdmService.preCreate(preGoodsInventoryAdmVo);
				
				jsonData.put("data", preGoodsInventoryAdmVo);
				if ( "fail".equals(jsonData.get("result"))) {
					
				} else {
					jsonData.put("message", "등록되었습니다.");
					jsonData.put("result", "ok");
				}

			} else {
				jsonData.put("data", preGoodsInventoryAdmVo);
				jsonData.put("result", "exist");
			}
			
		} catch (Exception e) {
			
			//오류발생시 해당 DTL 삭제
			preGoodsInventoryAdmService.preGoodsPackDtlDelete(preGoodsInventoryDtl);
			
			logger.info("선처리재고관리정보 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 등록중 오류가 발생했습니다.<br/> 등록정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}
	
	
	//재고제품Dtl 목록조회
	@RequestMapping(value = "/tm/preGoodsInventoryDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preGoodsInventoryDtlList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고제품Dtl 목록조회");

		try {
			List<PreGoodsInventoryAdmVo> preGoodsInventoryDataList = preGoodsInventoryAdmService.preGoodsInventoryDtlList(preGoodsInventoryAdmVo);
			jsonData.put("data", preGoodsInventoryDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("선처리재고관리정보 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고제품Dtl 목록조회 오류가 발생하였습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}
		
	//재고관리-제품(초기재고) BOX 추가 생성
	@RequestMapping(value = "/tm/preGoodsInventoryPlus", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsInventoryUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리-제품(초기재고) BOX 추가 생성");
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();		//추가할 Box 수량 및 해당 ADM 정보
		PreGoodsInventoryAdmVo readPreGoodsInventoryAdm = new PreGoodsInventoryAdmVo();	//읽어온 재고 ADM
		try {
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			goodsCodeAdmVo.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
			goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
			preGoodsInventoryAdmVo.setUpdId(Utils.getUserId());
			
			int boxCnt = preGoodsInventoryAdmVo.getBoxPlus();	//입력받은 제품 수량
			//초기제품Dtl BoxNo 채번&등록
			for (int i=1; i<=preGoodsInventoryAdmVo.getBoxPlus(); i++) {
				//초기재고 DTL 등록
				String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
				preGoodsInventoryDtl.setBoxNo("S" + packDate);
				
				int boxSeq = 0;
				//Al 제품 채번
				if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("A")) {
					boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqAl(preGoodsInventoryDtl);
					//0001~4999번대 채번시 시퀀스가 5000이면.. 채번시 중지, preCreate 수량도 조절
					if ( boxSeq == 5000 ) {
						boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
						jsonData.put("message", "AL 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
						jsonData.put("result", "fail");
						break;
					}
					
				//Nicu 제품 채번
				} else if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("N")) {
					boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqNicu(preGoodsInventoryDtl);
					if (boxSeq == 1) {
						boxSeq = 5001;
						
					//5001~9999번대 채번시 시퀀스가 10000 이면.. 채번 중지하기 수량 preCreate 시 수량도 조절
					} else if ( boxSeq == 10000) {
						boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
						jsonData.put("message", "Nicu 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
						jsonData.put("result", "fail");
						break;
					}
				}
				
				String boxNo = "S" + packDate.concat("-").concat(String.format("%04d", boxSeq));
				preGoodsInventoryDtl.setInvntryNo(preGoodsInventoryAdmVo.getInvntryNo());
				preGoodsInventoryDtl.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
				preGoodsInventoryDtl.setOrderGubunCd(preGoodsInventoryAdmVo.getOrderGubunCd());
				preGoodsInventoryDtl.setBoxNo(boxNo);
				preGoodsInventoryDtl.setPackCnt(preGoodsInventoryAdmVo.getPackCnt());
				preGoodsInventoryDtl.setRemainCnt(preGoodsInventoryAdmVo.getPackCnt());
				preGoodsInventoryDtl.setGoodsInDate(preGoodsInventoryAdmVo.getGoodsInDate());
				preGoodsInventoryDtl.setInventoryDesc(preGoodsInventoryAdmVo.getInventoryDesc());
				preGoodsInventoryDtl.setRegId(Utils.getUserId());
				preGoodsInventoryDtl.setHistId(Utils.getUserId());
				preGoodsInventoryAdmService.preGoodsPackDtlCreate(preGoodsInventoryDtl);
				preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
				goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryAdmVo.getGoodsCd(), boxNo, "003", "I", "008", preGoodsInventoryAdmVo.getPackCnt(), facotryCode);	
				stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
				
			}
			//생성 완료 후 추가된 Box 수량만큼 ADM도 수정
			readPreGoodsInventoryAdm = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
			readPreGoodsInventoryAdm.setInputBoxCnt(readPreGoodsInventoryAdm.getInputBoxCnt() + boxCnt);		//입고수량 + 추가수량
			readPreGoodsInventoryAdm.setInvntryBoxCnt(readPreGoodsInventoryAdm.getInvntryBoxCnt() + boxCnt);	//재고수량 + 추가수량
			preGoodsInventoryAdmService.preUpdate(readPreGoodsInventoryAdm);
			
			jsonData.put("data", readPreGoodsInventoryAdm);
			if ( "fail".equals(jsonData.get("result"))) {
				
			} else {
				jsonData.put("message", "추가되었습니다.");
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("재고관리-제품(초기재고) BOX 추가 생성 = 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리-제품(초기재고) BOX 추가 생성 중 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//재고관리-제품(초기재고) 선택 BoxNo 삭제
	@RequestMapping(value = "/tm/preGoodsInventoryMinus", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsInventoryMinus(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			boolean deleteCheck = true;
			logger.info(preGoodsInventoryAdmVo.getBoxMinus());
			String[] arrayBoxNo = preGoodsInventoryAdmVo.getBoxMinus().split("/");
			//첫번째 칸은 비어있음(첫 BoxNo 앞에 /가 붙어있기때문)
			for ( int i=1; i<arrayBoxNo.length; i++ ) {
				//해당 BoxNo들이 삭재할 수 있는 번호들인지 확인
				PreGoodsInventoryAdmVo readPreGoodsInventoryAdmVo = new PreGoodsInventoryAdmVo();
				readPreGoodsInventoryAdmVo.setBoxNo(arrayBoxNo[i]);
				logger.info(arrayBoxNo[i]);
				readPreGoodsInventoryAdmVo = PdaService.readPreGoodsInventoryDtl(readPreGoodsInventoryAdmVo);
				
				//출하된 제품일시 다시선택
				if ( readPreGoodsInventoryAdmVo.getPackCnt() != readPreGoodsInventoryAdmVo.getRemainCnt() ) {
					deleteCheck = false;
					jsonData.put("message", readPreGoodsInventoryAdmVo.getBoxNo() + " 이미 출하된 제품으로 삭제 할 수 없습니다.<br>다시 선택해 주세요!");
					jsonData.put("result", "fail");
					break;
				} else if ( !"001".equals(readPreGoodsInventoryAdmVo.getFaultyStatus()) ) {
					deleteCheck = false;
					jsonData.put("message", "불량상태가 정상인 제품만 삭제할 수 있습니다!");
					jsonData.put("result", "fail");
					break;
				}
			}
			
			//해당 BoxNo 삭제 실행
			if ( deleteCheck ) {
				int minusCount = 0;
				for ( int i=1; i<arrayBoxNo.length; i++ ) {
					logger.info("삭제할 BoxNo : " + arrayBoxNo[i]);
					
					//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
					PreGoodsInventoryAdmVo readPreGoodsInventoryAdmVo = new PreGoodsInventoryAdmVo();
					readPreGoodsInventoryAdmVo.setBoxNo(arrayBoxNo[i]);
					readPreGoodsInventoryAdmVo = PdaService.readPreGoodsInventoryDtl(readPreGoodsInventoryAdmVo);
					StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
					goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryAdmVo.getGoodsCd(), readPreGoodsInventoryAdmVo.getBoxNo(), "003", "D", "008", readPreGoodsInventoryAdmVo.getPackCnt(), facotryCode);	
					stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
					
					//삭제실행
					PreGoodsInventoryAdmVo deletePreGoodsInventoryDtl = new PreGoodsInventoryAdmVo();	//읽어온 재고 ADM
					deletePreGoodsInventoryDtl.setBoxNo(arrayBoxNo[i]);
					preGoodsInventoryAdmService.preDtlDelete(deletePreGoodsInventoryDtl);
					preGoodsInventoryAdmService.deletePreGoodsProductHist(deletePreGoodsInventoryDtl);	//재고제품이력 삭제
					minusCount++;
				}
				PreGoodsInventoryAdmVo readPreGoodsInventoryAdm = new PreGoodsInventoryAdmVo();	//읽어온 재고 ADM
				//생성 완료 후 추가된 Box 수량만큼 ADM도 수정
				readPreGoodsInventoryAdm = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
				readPreGoodsInventoryAdm.setInputBoxCnt(readPreGoodsInventoryAdm.getInputBoxCnt() - minusCount);		//입고수량 - 삭제수량
				readPreGoodsInventoryAdm.setInvntryBoxCnt(readPreGoodsInventoryAdm.getInvntryBoxCnt() - minusCount);	//재고수량 - 삭제수량
				preGoodsInventoryAdmService.preUpdate(readPreGoodsInventoryAdm);
				jsonData.put("data", readPreGoodsInventoryAdm);
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("입고현황 바코드 인쇄 실패(iosc0030)");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
				
		return jsonData;
	}
	
	//제품코드관리 수정
	/*
	 * @RequestMapping(value = "/tm/preGoodsInventoryUpdate", method =
	 * RequestMethod.POST) public @ResponseBody Map<String, Object>
	 * preGoodsInventoryUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws
	 * Exception {
	 * 
	 * Map<String, Object> jsonData = new HashMap<String, Object>();
	 * logger.info("선처리재고관리정보 수정"); try {
	 * preGoodsInventoryAdmVo.setForwordBoxCnt(0);
	 * preGoodsInventoryAdmVo.setInvntryBoxCnt(preGoodsInventoryAdmVo.
	 * getForwordBoxCnt() + preGoodsInventoryAdmVo.getInputBoxCnt());
	 * preGoodsInventoryAdmVo.setLastYn("Y");
	 * preGoodsInventoryAdmVo.setUpdId(Utils.getUserId());
	 * 
	 * preGoodsInventoryAdmService.preUpdate(preGoodsInventoryAdmVo);
	 * jsonData.put("data", preGoodsInventoryAdmVo); jsonData.put("result", "ok"); }
	 * catch (Exception e) { logger.info("선처리재고관리정보 수정 오류"); e.printStackTrace();
	 * jsonData.put("message", "선처리재고관리정보 수정중 오류가 발생했습니다.<br/> 수정정보를 확인해 주세요.");
	 * jsonData.put("result", "fail"); } return jsonData; }
	 */

	//선처리재고관리정보 바코드출고관리 메인
	@RequestMapping(value = "/iosc0100", method = RequestMethod.GET)
	public String preGoodsInventoryOutput(Locale locale, Model model) throws Exception {

		logger.info("선처리재고관리정보 바코드출고관리 메인");
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("orderGubunCd", systemCommonCodeList);

		return "io/iosc0100";
	}

	//선처리재고관리정보 출고이력목록조회
	@RequestMapping(value = "/tm/preGoodsOutputHistDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preGoodsOutputHistDataList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 출고이력목록조회 = " + preGoodsInventoryAdmVo);

		try {
			List<PreGoodsInventoryAdmVo> preGoodsInventoryDataList = preGoodsInventoryAdmService.listInvntryOutputHist(preGoodsInventoryAdmVo);
			jsonData.put("data", preGoodsInventoryDataList);
		} catch (Exception e) {
			logger.info("선처리재고관리정보 출고이력목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 출고이력 목록조회 오류가 발생했습니다.<br/> 재고관리 정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//선처리재고관리정보 출고이력 상세목록조회
	@RequestMapping(value = "/tm/preGoodsOutputDtlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preGoodsOutputDtlDataList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 출고이력 상세목록 조회 = " + preGoodsInventoryAdmVo);

		try {
			List<PreGoodsInventoryAdmVo> preGoodsInventoryDataDtlList = preGoodsInventoryAdmService.listInvntryOutputDtl(preGoodsInventoryAdmVo);
			jsonData.put("data", preGoodsInventoryDataDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("선처리재고관리정보 출고이력목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 출고이력 상세목록 조회 오류가 발생했습니다.<br/> 재고관리 정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//선처리재고관리정보 출고이력등록
	@RequestMapping(value = "/tm/preGoodsOutputHistCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsOutputHistCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 출고이력등록 = " + preGoodsInventoryAdmVo);
		try {
			//출고가 가능한지 재고량 확인 후 출고이력 등록 진행
			preGoodsInventoryAdmVo.setLastYn("Y");
			PreGoodsInventoryAdmVo inventoryAdmVo = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);

			if (inventoryAdmVo.getInvntryBoxCnt() >= preGoodsInventoryAdmVo.getOutputBoxCnt()) { // 전체재고량-출고량
				String slipNo = preGoodsInventoryAdmService.selectSlipSeq(preGoodsInventoryAdmVo);
				preGoodsInventoryAdmVo.setSlipNo(slipNo);
				preGoodsInventoryAdmVo.setOutputAllCnt(preGoodsInventoryAdmVo.getOutputBoxCnt() * preGoodsInventoryAdmVo.getPackCnt());
				preGoodsInventoryAdmVo.setRegId(Utils.getUserId());
				preGoodsInventoryAdmService.preOutputHistCreate(preGoodsInventoryAdmVo); // 출고이력생성
				preGoodsInventoryAdmService.preOutputUpdate(preGoodsInventoryAdmVo); // 재고정보변경
				preGoodsInventoryAdmVo = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo); //현재 재고정보

				jsonData.put("result", "ok");
				jsonData.put("data", preGoodsInventoryAdmVo);
			} else {
				jsonData.put("result", "over");
				jsonData.put("data", preGoodsInventoryAdmVo);
			}
		} catch (Exception e) {
			logger.info("선처리재고관리정보 출고이력 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 출고이력 등록중 오류가 발생했습니다.<br/> 등록정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//선처리재고관리정보 출고이력 상세등록
	@RequestMapping(value = "/tm/preGoodsOutputDtlCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsOutputDtlCreate(@RequestBody List<Map<String, Object>> preGoodsInventoryAdmList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 출고이력 상세등록 = " + preGoodsInventoryAdmList);
		PreGoodsInventoryAdmVo preGoodsInventoryAdmVo = new PreGoodsInventoryAdmVo();
		String slipNo = "";
		
		try {
			int idx = 0;
			for (Map<String, Object> m : preGoodsInventoryAdmList) {
				logger.debug("m ===> : " + m);
				preGoodsInventoryAdmVo.setInvntryNo(m.get("invntryNo").toString());
				preGoodsInventoryAdmVo.setGoodsCd(m.get("goodsCd").toString());
				preGoodsInventoryAdmVo.setModel(m.get("model").toString());
				preGoodsInventoryAdmVo.setModelNo(m.get("modelNo").toString());
				preGoodsInventoryAdmVo.setSlipSeq(Integer.parseInt(m.get("slipSeq").toString()));
				preGoodsInventoryAdmVo.setOrderGubunCd(m.get("orderGubunCd").toString());
				preGoodsInventoryAdmVo.setDealCorpCd(m.get("dealCorpCd").toString());
				preGoodsInventoryAdmVo.setPackCnt(Integer.parseInt(m.get("packCnt").toString()));
				preGoodsInventoryAdmVo.setOutputBoxCnt(Integer.parseInt(m.get("outputBoxCnt").toString()));
				preGoodsInventoryAdmVo.setCustomerModelNo(m.get("customerModelNo").toString());
				preGoodsInventoryAdmVo.setQutyCd((m.get("qutyCd").toString()));
				preGoodsInventoryAdmVo.setOutputHistDate((m.get("outputHistDate").toString()));
				preGoodsInventoryAdmVo.setOutputDtlDate((m.get("outputDtlDate").toString()));
				preGoodsInventoryAdmVo.setRegId(Utils.getUserId());
				PreGoodsInventoryAdmVo tmpGoodsInventoryAdmVo = preGoodsInventoryAdmVo;
				
				//출고가 가능한지 재고량 확인 후 출고이력 등록 진행
				if (idx == 0) {
					preGoodsInventoryAdmVo.setLastYn("Y");
					PreGoodsInventoryAdmVo inventoryAdmVo = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);

					if (inventoryAdmVo.getInvntryBoxCnt() >= preGoodsInventoryAdmVo.getOutputBoxCnt()) { // 전체재고량-출고량
						slipNo = preGoodsInventoryAdmService.selectSlipSeq(preGoodsInventoryAdmVo);
						preGoodsInventoryAdmVo.setSlipNo(slipNo);
						preGoodsInventoryAdmVo.setOutputAllCnt(preGoodsInventoryAdmVo.getOutputBoxCnt() * preGoodsInventoryAdmVo.getPackCnt());
						preGoodsInventoryAdmVo.setRegId(Utils.getUserId());
						preGoodsInventoryAdmService.preOutputHistCreate(preGoodsInventoryAdmVo); // 출고이력생성
						preGoodsInventoryAdmService.preOutputUpdate(preGoodsInventoryAdmVo); // 재고정보변경		
						preGoodsInventoryAdmVo = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo); //현재 재고정보

						jsonData.put("result", "ok");
						jsonData.put("data", preGoodsInventoryAdmVo);
					} else {
						jsonData.put("result", "over");
						jsonData.put("data", preGoodsInventoryAdmVo);
						break;
					}
				}
				
				tmpGoodsInventoryAdmVo.setSlipNo(slipNo);
				preGoodsInventoryAdmService.preOutputDtlCreate(tmpGoodsInventoryAdmVo);
				idx++;
				
			}
		} catch (Exception e) {
			logger.info("선처리재고관리정보 출고이력 상세등록 오류");
			e.printStackTrace();
			jsonData.put("message", "선처리재고관리정보 출고이력 상세 등록중 오류가 발생했습니다.<br/> 등록정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		return jsonData;
	}

	//제품(원재고현황)
	@RequestMapping(value = "/tmsc0070", method = RequestMethod.GET)
	public String preGoodsInventoryInfoMain(Locale locale, Model model) throws Exception {
		
		logger.info("선처리재고관리정보 제품재고정보메인");
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();

		systemCommonCodeVo.setBaseGroupCd("018"); // 오더구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("orderGubunCd", systemCommonCodeList);

		return "tm/tmsc0070";
	}

	//제품(월재고현황)-ADM
	@RequestMapping(value = "/tm/tmByGoodsMonthInventoryList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsMonthInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품(월재고현황) = " + matrlInOutWhsAdmVo);
		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmVoDataList = inventoryAdmService.tmByGoodsMonthInventoryList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmVoDataList);
		} catch (Exception e) {
			logger.info("제품(월재고현황) 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "제품(월재고현황) 조회 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//제품(월재고현황)-DTL
	@RequestMapping(value = "/tm/tmByGoodsMonthInventoryDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsMonthInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품(월재고현황) 상세 = " + matrlInOutWhsAdmVo);
		
		try {
			List<MatrlInOutWhsAdmVo> matrlInOutWhsAdmVoDataList = inventoryAdmService.tmByGoodsMonthInventoryDtlList(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlInOutWhsAdmVoDataList);
		} catch (Exception e) {
			logger.info("제품(월재고현황) 상세 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "제품(월재고현황) 상세 조회 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//선처리재고관리정보 제품출고빈목록
	@RequestMapping(value = "/tm/preGoodsOutputEmptyList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> preGoodsOutputEmptyList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("선처리재고관리정보 제품출고빈목록  ");
		PreGoodsInventoryAdmVo preGoodsInventoryDataList = new PreGoodsInventoryAdmVo();
		jsonData.put("data", preGoodsInventoryDataList);
		return jsonData;
	}
	
	//재고관리-제품(초기재고) BOX 개별단위 생성
	@RequestMapping(value = "/tm/preGoodsInventoryPlusEa", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> preGoodsInventoryPlusEa(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리-제품(초기재고) BOX 추가 생성");
		PreGoodsInventoryAdmVo preGoodsInventoryDtl = new PreGoodsInventoryAdmVo();		//추가할 Box 수량 및 해당 ADM 정보
		PreGoodsInventoryAdmVo readPreGoodsInventoryAdm = new PreGoodsInventoryAdmVo();	//읽어온 재고 ADM
		try {
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			goodsCodeAdmVo.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
			goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
			preGoodsInventoryAdmVo.setUpdId(Utils.getUserId());
			
			//box 갯수 세는 로직
			double boxCnt1 = (double)(preGoodsInventoryAdmVo.getBoxPlus() / preGoodsInventoryAdmVo.getPackCnt());
			int boxCnt = (int)boxCnt1+1;
			int remainCnt = 0;
			remainCnt = preGoodsInventoryAdmVo.getBoxPlus() % preGoodsInventoryAdmVo.getPackCnt();
			
			//int boxCnt = preGoodsInventoryAdmVo.getBoxPlus();	//입력받은 제품 수량
			//초기제품Dtl BoxNo 채번&등록
			int i=1;
			for (i=1; i<=boxCnt-1; i++) {
				//초기재고 DTL 등록
				String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
				preGoodsInventoryDtl.setBoxNo("S" + packDate);
				
				int boxSeq = 0;
				//Al 제품 채번
				if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("A")) {
					boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqAl(preGoodsInventoryDtl);
					//0001~4999번대 채번시 시퀀스가 5000이면.. 채번시 중지, preCreate 수량도 조절
					if ( boxSeq == 5000 ) {
						boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
						jsonData.put("message", "AL 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
						jsonData.put("result", "fail");
						break;
					}
					
				//Nicu 제품 채번
				} else if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("N")) {
					boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqNicu(preGoodsInventoryDtl);
					if (boxSeq == 1) {
						boxSeq = 5001;
						
					//5001~9999번대 채번시 시퀀스가 10000 이면.. 채번 중지하기 수량 preCreate 시 수량도 조절
					} else if ( boxSeq == 10000) {
						boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
						jsonData.put("message", "Nicu 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
						jsonData.put("result", "fail");
						break;
					}
				}
				
				String boxNo = "S" + packDate.concat("-").concat(String.format("%04d", boxSeq));
				preGoodsInventoryDtl.setInvntryNo(preGoodsInventoryAdmVo.getInvntryNo());
				preGoodsInventoryDtl.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
				preGoodsInventoryDtl.setOrderGubunCd(preGoodsInventoryAdmVo.getOrderGubunCd());
				preGoodsInventoryDtl.setBoxNo(boxNo);
				preGoodsInventoryDtl.setRemainCnt(preGoodsInventoryAdmVo.getPackCnt());
				preGoodsInventoryDtl.setPackCnt(preGoodsInventoryAdmVo.getPackCnt());
				preGoodsInventoryDtl.setGoodsInDate(preGoodsInventoryAdmVo.getGoodsInDate());
				preGoodsInventoryDtl.setInventoryDesc(preGoodsInventoryAdmVo.getInventoryDesc());
				preGoodsInventoryDtl.setRegId(Utils.getUserId());
				preGoodsInventoryDtl.setHistId(Utils.getUserId());
				preGoodsInventoryAdmService.preGoodsPackDtlCreate(preGoodsInventoryDtl);
				preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
				
				//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
				StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
				goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryAdmVo.getGoodsCd(), boxNo, "003", "I", "008", preGoodsInventoryAdmVo.getPackCnt(), facotryCode);	
				stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
			}
			
			//남은 갯수 추가 
			String packDate = DateUtil.getToday("yyyymmdd"); // 등록은 항상 서버시간 기준으로 등록
			preGoodsInventoryDtl.setBoxNo("S" + packDate);
			
			int boxSeq = 0;
			//Al 제품 채번
			if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("A")) {
				boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqAl(preGoodsInventoryDtl);
				//0001~4999번대 채번시 시퀀스가 5000이면.. 채번시 중지, preCreate 수량도 조절
				if ( boxSeq == 5000 ) {
					boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
					jsonData.put("message", "AL 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
					jsonData.put("result", "fail");					
				}
				
			//Nicu 제품 채번
			} else if (goodsCodeAdmVo.getGoodsCd().substring(0,1).equals("N")) {
				boxSeq = preGoodsInventoryAdmService.selectPreGoodsPackSeqNicu(preGoodsInventoryDtl);
				if (boxSeq == 1) {
					boxSeq = 5001;					
				//5001~9999번대 채번시 시퀀스가 10000 이면.. 채번 중지하기 수량 preCreate 시 수량도 조절
				} else if ( boxSeq == 10000) {
					boxCnt = i - 1;	//실제 생성된 box 수량 카운트, 생성 전이라 1을 빼줌
					jsonData.put("message", "Nicu 제품 재고 일일 최대 생성 수량은 4999개입니다.<br>추가로 생성 시 내일 생성해 주세요!");
					jsonData.put("result", "fail");					
				}
			}
			
			String boxNo = "S" + packDate.concat("-").concat(String.format("%04d", boxSeq));
			preGoodsInventoryDtl.setInvntryNo(preGoodsInventoryAdmVo.getInvntryNo());
			preGoodsInventoryDtl.setGoodsCd(preGoodsInventoryAdmVo.getGoodsCd());
			preGoodsInventoryDtl.setOrderGubunCd(preGoodsInventoryAdmVo.getOrderGubunCd());
			preGoodsInventoryDtl.setBoxNo(boxNo);
			//preGoodsInventoryDtl.setPackCnt(preGoodsInventoryAdmVo.getPackCnt());
			preGoodsInventoryDtl.setPackCnt(remainCnt);
			preGoodsInventoryDtl.setRemainCnt(remainCnt);
			preGoodsInventoryDtl.setGoodsInDate(preGoodsInventoryAdmVo.getGoodsInDate());
			preGoodsInventoryDtl.setInventoryDesc(preGoodsInventoryAdmVo.getInventoryDesc());
			preGoodsInventoryDtl.setRegId(Utils.getUserId());
			preGoodsInventoryDtl.setHistId(Utils.getUserId());
			preGoodsInventoryAdmService.preGoodsPackDtlCreate(preGoodsInventoryDtl);
			preGoodsInventoryAdmService.insertPreGoodsProductHist(preGoodsInventoryDtl); //재고제품 상태변경 이력쌓기
			//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
			StockPaymentAdmVo goodsPackMinus = new StockPaymentAdmVo();
			goodsPackMinus = StockPaymentAdmController.goodsStockPaymentHist(preGoodsInventoryAdmVo.getGoodsCd(), boxNo, "003", "I", "008", remainCnt, facotryCode);	
			stockPaymentAdmService.stockPaymentPlus(goodsPackMinus);
			
			//생성 완료 후 추가된 Box 수량만큼 ADM도 수정
			readPreGoodsInventoryAdm = preGoodsInventoryAdmService.preRead(preGoodsInventoryAdmVo);
			readPreGoodsInventoryAdm.setInputBoxCnt(readPreGoodsInventoryAdm.getInputBoxCnt() + boxCnt);		//입고수량 + 추가수량
			readPreGoodsInventoryAdm.setInvntryBoxCnt(readPreGoodsInventoryAdm.getInvntryBoxCnt() + boxCnt);	//재고수량 + 추가수량
			preGoodsInventoryAdmService.preUpdate(readPreGoodsInventoryAdm);
			
			jsonData.put("data", readPreGoodsInventoryAdm);
			if ( "fail".equals(jsonData.get("result"))) {
				
			} else {
				jsonData.put("message", "추가되었습니다.");
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			logger.info("재고관리-제품(초기재고) BOX 추가 생성 = 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리-제품(초기재고) BOX 추가 생성 중 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
}
