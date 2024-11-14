package mes.service.pd;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.pd.GoodsProductInfoAdmVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.persistence.pd.PdaDAO;

@Service
public class PdaServiceImpl implements PdaService {
	@Inject
	private PdaDAO dao;

	//입출고관리 자재입고 Location 수정
	@Override
	public void updatePdaLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updatePdaLocation(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재출고 제품코드, 설비코드 수정
	@Override
	public void updatePda(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updatePda(matrlInOutWhsAdmVo);
	}
	
	//제품 입고 boxNo 조회(제품 입고)
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.readGoodsProductInfo(goodsProductInfoAdmVo);
	}
	
	//제품 입고 Location 수정
	@Override
	public void updateProductLocation(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.updateProductLocation(goodsProductInfoAdmVo);
	}
	
	//PDA 제품 출하대기 Update
	@Override
	public void palletRelatedProductUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.palletRelatedProductUpdate_F3(goodsProductInfoAdmVo);
	}
	
	//제품 입고 boxNo 조회(제품 출고)
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfo2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.readGoodsProductInfo2(goodsProductInfoAdmVo);
	}
	
	//트레이 번호로 작업지시 조회
	@Override
	public GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.readTrayBoxByWorkOrdNo(goodsProductInfoAdmVo);
	}
	
	//Po그룹 시퀀스
	@Override
	public String selectPoGroup(String poSeq) throws Exception{
		return dao.selectPoGroup(poSeq);
	}
	
	//트레이 번호로 작업지시 조회
	@Override
	public PurchaseOrderAdmVo selectPoGroup_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.selectPoGroup_F3(purchaseOrderAdmVo);
	}
	
	//제품 출고 제품생산정보관리 수정
	@Override
	public void updateBox(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.updateBox(goodsProductInfoAdmVo);
	}
	
	//제품 출고 제품생산정보관리 수정
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.goodsProductInfoList(goodsProductInfoAdmVo);
	}
	
	//PDA 자재 불량&반품 처리 Update
	@Override
	public void updateMatrlApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateMatrlApproval(matrlInOutWhsAdmVo);
	}
	
	//PDA 재고 제품출고 Update
	@Override
	public void updatePreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		dao.updatePreGoodsInventoryDtl(preGoodsInventoryAdmVo);
	}
	
	//제품 출고 재고제품 조회
	@Override
	public PreGoodsInventoryAdmVo readPreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.readPreGoodsInventoryDtl(preGoodsInventoryAdmVo);
	}
	
	//제품 출고 재고제품 조회
	@Override
	public List<PurchaseOrderAdmVo> palletRelatedProductList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.palletRelatedProductList_F3(purchaseOrderAdmVo);
	}
	
	//BoxNo에 포함된 작지번호목록 검색(입고시 실링검사에 사용)
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductWorkOrdList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.goodsProductWorkOrdList(goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 기록쌓기
	@Override
	public void insertGoodsProductHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.insertGoodsProductHist(goodsProductInfoAdmVo);
	}
	
	//생산제품 선입선출 적용
	@Override
	public GoodsProductInfoAdmVo goodsProductFifoCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.goodsProductFifoCheck(goodsProductInfoAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색
	@Override
	public PreGoodsInventoryAdmVo preGoodsInventoryFifoCheck(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.preGoodsInventoryFifoCheck(preGoodsInventoryAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색 목록
	@Override
	public List<PreGoodsInventoryAdmVo> preGoodsInventoryFifoCheckList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.preGoodsInventoryFifoCheckList(preGoodsInventoryAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색
	@Override
	public PurchaseOrderAdmVo poSeqSerchRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.poSeqSerchRead(purchaseOrderAdmVo);
	}
	
	//박스 정보 삭제됨에 따라 업데이트
	@Override
	public void palletBoxDelete_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.palletBoxDelete_F3(goodsProductInfoAdmVo);
	}
	
	//출하 취소 제품 정보 업데이트
	@Override
	public void palletCancel_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.palletCancel_F3(goodsProductInfoAdmVo);
	}
	
	//고객사LotNo 수정
	@Override
	public void customerLotNoUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.customerLotNoUpdate_F3(goodsProductInfoAdmVo);
	}
	
	//박스 반품 처리
	@Override
	public void boxReturnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.boxReturnUpdate(goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 기록쌓기 - SLD
	@Override
	public void insertGoodsProductHist_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.insertGoodsProductHist_F3(goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 다중 기록쌓기 - SLD
	@Override
	public void insertGoodsProductHist_F3_2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.insertGoodsProductHist_F3_2(goodsProductInfoAdmVo);
	}
	
	//파레트라벨 매핑 등록 상세조회
	@Override
	public PurchaseOrderAdmVo palletMappingRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.palletMappingRead(purchaseOrderAdmVo);
	}
	
	//파레트 번호 매칭 수정
	@Override
	public void palletMappingUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		 dao.palletMappingUpdate(purchaseOrderAdmVo);
	}
	
	//출하대기 박스 상세조회
	@Override
	public PurchaseOrderAdmVo palletFactCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.palletFactCheckRead(purchaseOrderAdmVo);
	}
	
	//출하대기체크 수정
	@Override
	public void palletBoxFactCheckUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.palletBoxFactCheckUpdate(goodsProductInfoAdmVo);
	}
	
	//출하대기 취소 처리 진행
	@Override
	public void palletBoxFactCheckCancelUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.palletBoxFactCheckCancelUpdate(goodsProductInfoAdmVo);
	}
	
	//점검대기로 상태값 변경
	@Override
	public void palletCheckStatusReplaceUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.palletCheckStatusReplaceUpdate(goodsProductInfoAdmVo);
	}
	
	//출하대기 박스 상세조회
	@Override
	public PurchaseOrderAdmVo palletCustomerCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return dao.palletCustomerCheckRead(purchaseOrderAdmVo);
	}
	
	//포장대기로 상태값 변경
	@Override
	public void packingWaitingStatusUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 dao.packingWaitingStatusUpdate(goodsProductInfoAdmVo);
	}
}