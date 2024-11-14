package mes.persistence.bs;

import java.util.List;

import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.bs.PurchaseOrderDtl;
import mes.domain.bs.PurchaseOrderOutputHistVo;

public interface PurchaseOrderAdmDAO {

	//영업관리 구매주문정보목록조회
	public List<PurchaseOrderAdmVo> listPurchaseOrderAll(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 구매주문정보상세조회
	public PurchaseOrderAdmVo read(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 구매주문정보등록
	public void create(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 구매주문정보수정
	public void update(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 출고이력수정
	public void updateOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//영업관리 구매주문정보 삭제가능한지 체크
	public int purchaseOrderDeleteCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 구매주문정보 삭제
	public void purchaseOrderDelete(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 구매시퀀스
	public String selectPurchaseOrderSeq(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 영업일보목록조회
	public List<PurchaseOrderAdmVo> listPurchaseOrderDaily(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 영업일보목록조회
	public List<PurchaseOrderAdmVo> listPurchaseOrderDaily_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 영업일보목록상세조회
	public List<PurchaseOrderOutputHistVo> outputHistList(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//영업관리 영업일보목록상세조회
	public List<PurchaseOrderOutputHistVo> outputHistList_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
		
	//영업관리 제품 출하 내역 조회
	public List<PurchaseOrderDtl> inspectList(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
		
	//영업관리 출고이력목록조회
	public List<PurchaseOrderAdmVo> listOutputHistAll(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 수주집계표 거래처/품목별 
	public List<PurchaseOrderAdmVo> listDealGoods(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 수주집계표 오더구분별
	public List<PurchaseOrderAdmVo> listOrderGubun(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 년도별 수주집계표 거래처/품목별 
	public List<PurchaseOrderAdmVo> listDealGoodsYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 년도별 수주집계표 오더구분별
	public List<PurchaseOrderAdmVo> listOrderGubunYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	

	//구매주문출고 이력 등록
	public void histCreate(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//파레트에 트레이 추가 적재 출고이력 수정
	public void addTrayByPallet(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//파레트에 트레이 추가 적재 출고이력 수정
	public void addTrayByPallet_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//파레트에 트레이 출하 취소
	public void removeTrayByPallet(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//파레트에 트레이 출하 취소
	public void removeTrayByPallet_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//영업관리 구매주문정보수정
	public void updateQty(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//입출고관리 - 출고현황관리(iosc0070) 기간 조회
	public List<PurchaseOrderAdmVo> productOutpoutDataList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//입출고관리 - 출고현황관리(iosc0180) 기간 조회
	public List<PurchaseOrderAdmVo> productOutpoutDataDtlList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//제품 출하 내역 등록
	public void createPurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
	
	//제품 출하 취소 체크
	public int productOutputCancelCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//출하 기록 boxNo 변경여부 체크
	public int purchaseOrderDtlDeleteCheck(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
	
	//제품 출하 내역 등록
	public void deletePurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
	
	//제품 출하 내역 처리 후 순번 업데이트
	public void updatePurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
	
	//출하 취소 총 출하 수량 수정
	public void updatePurchaseOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//박스 교체로 새 박스 투입
	public void updatePurchaseOutputHistIn(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//출하 이력 단일 조회
	public PurchaseOrderOutputHistVo readPurchaseOrderOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//출하 이력 리스트 조회
	public List<PurchaseOrderOutputHistVo> readPurchaseOrderOutputHistList(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//출하 이력 수기 출고이력 조회
	public List<PurchaseOrderOutputHistVo> readPurchaseOrderOutputHistSugi(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//출고수량 0인 출하 이력 삭제
	public void deletePurchaseOrderOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//출하 취소 PO, 수량 기록
	public void createPurchaseCancelHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception;
	
	//해당 PO 출하 취소수량만큼 출하수량, 미출하수량 UPDATE
	public void updatePurchaseAdmOutputCancel(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//해당 PO 출하 수량만큼 출하수량, 미출하수량 UPDATE
	public void updatePurchaseAdmOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//불량처리 
	public void updateDtl(PurchaseOrderDtl purchaseOrderDtlVo) throws Exception;
	
	//박스 반품 처리
	public void boxReturnUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//파레트 이력 삭제
	public void palletDelete(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
		
	//PO_NO_SEQ 가져오기 
	public String purchaseOrderPoNoSeq(PurchaseOrderDtl purchaseOrderDtlVo) throws Exception;
	
	//영업관리 출고집계표 거래처/품목별
	public List<PurchaseOrderAdmVo> listDealGoodsOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 출고집계표 거래처
	public List<PurchaseOrderAdmVo> listDealOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
		
	//영업관리 출고집계표 오더구분별
	public List<PurchaseOrderAdmVo> listOrderGubunOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 년도별 출고집계표 거래처/품목별
	public List<PurchaseOrderAdmVo> listDealGoodsOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
		
	//영업관리 년도별 출고집계표 오더구분별
	public List<PurchaseOrderAdmVo> listOrderGubunOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
		
	//입출고관리-제품출하 PO추적
	public List<PurchaseOrderDtl> tracePurchaseOrderOutputHist(PurchaseOrderDtl purchaseOrderDtl) throws Exception;
	
	//입출고관리-제품출하 PO추적
	public List<PurchaseOrderAdmVo> tracePurchaseOrderOutputHist2(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//출고집계표 요약본
	public List<PurchaseOrderAdmVo> listchulgojipgye(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//샘플판매 목록 조회
	public List<PurchaseOrderAdmVo> purchaseOrderAdmSampleList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	
	
	//영업관리 출고집계표 거래처/품목별
	public List<PurchaseOrderAdmVo> listDealGoodsOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 출고집계표 거래처
	public List<PurchaseOrderAdmVo> listDealOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;	
	
	//영업관리 출고집계표 오더구분별
	public List<PurchaseOrderAdmVo> listOrderGubunOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//출고집계표 요약본
	public List<PurchaseOrderAdmVo> listchulgojipgye_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//샘플판매 목록 조회
	public List<PurchaseOrderAdmVo> purchaseOrderAdmSampleList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	
	//영업관리 출고집계표 거래처/품목별(년도)
	public List<PurchaseOrderAdmVo> listDealGoodsOutputYear_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//영업관리 출고집계표 오더구분별(년도)
	public List<PurchaseOrderAdmVo> listOrderGubunOutputYear_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	
}