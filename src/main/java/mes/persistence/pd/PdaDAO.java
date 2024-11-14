package mes.persistence.pd;

import java.util.List;

import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.pd.GoodsProductInfoAdmVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;

public interface PdaDAO {

	//입출고관리 자재입고 Location 수정
	public void updatePdaLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재출고 제품코드, 설비코드 수정
	public void updatePda(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품 입고 boxNo 조회(제품 입고)
	public GoodsProductInfoAdmVo readGoodsProductInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 입고 Location 수정
	public void updateProductLocation(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//PDA 제품 출하대기 Update
	public void palletRelatedProductUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 입고 boxNo 조회(제품 출고)
	public GoodsProductInfoAdmVo readGoodsProductInfo2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//트레이 번호로 작업지시 조회
	public GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//Po그룹 시퀀스
	public String selectPoGroup(String poSeq) throws Exception;
	
	//트레이 번호로 작업지시 조회
	public PurchaseOrderAdmVo selectPoGroup_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//제품 출고 제품생산정보관리 수정
	public void updateBox(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//재고실사(제품) 입고일&위치 목록 조회
	public List<GoodsProductInfoAdmVo> goodsProductInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;

	//PDA 자재 불량&반품 처리 Update
	public void updateMatrlApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//PDA 재고 제품출고 Update
	public void updatePreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//제품 출고 재고제품 조회
	public PreGoodsInventoryAdmVo readPreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//제품 출고 재고제품 조회
	public List<PurchaseOrderAdmVo> palletRelatedProductList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//BoxNo에 포함된 작지번호목록 검색(입고시 실링검사에 사용)
	public List<GoodsProductInfoAdmVo> goodsProductWorkOrdList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 상태변경시 기록쌓기
	public void insertGoodsProductHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산제품 선입선출 적용
	public GoodsProductInfoAdmVo goodsProductFifoCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//BoxNo에 포함된 제품(초기재고) 검색
	public PreGoodsInventoryAdmVo preGoodsInventoryFifoCheck(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//BoxNo에 포함된 제품(초기재고) 검색 목록
	public List<PreGoodsInventoryAdmVo> preGoodsInventoryFifoCheckList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//BoxNo에 포함된 제품(초기재고) 검색
	public PurchaseOrderAdmVo poSeqSerchRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//박스 정보 삭제됨에 따라 업데이트
	public void palletBoxDelete_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//출하 취소 제품 정보 업데이트
	public void palletCancel_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//고객사LotNo 수정
	public void customerLotNoUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//박스 반품 처리
	public void boxReturnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 상태변경시 기록쌓기 - SLD
	public void insertGoodsProductHist_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 상태변경시 다중 기록쌓기 - SLD
	public void insertGoodsProductHist_F3_2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//파레트라벨 매핑 등록 상세조회
	public PurchaseOrderAdmVo palletMappingRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//파레트 번호 매칭 수정
	public void palletMappingUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//출하대기 박스 상세조회
	public PurchaseOrderAdmVo palletFactCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//출하대기체크 수정
	public void palletBoxFactCheckUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//출하대기 취소 처리 진행 
	public void palletBoxFactCheckCancelUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//점검대기로 상태값 변경
	public void palletCheckStatusReplaceUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//출하대기 박스 상세조회
	public PurchaseOrderAdmVo palletCustomerCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception;
	
	//포장대기로 상태값 변경
	public void packingWaitingStatusUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
}