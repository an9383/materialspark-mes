package mes.persistence.pd;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.pd.GoodsProductInfoAdmVo;
import mes.domain.tm.PreGoodsInventoryAdmVo;

@Repository
public class PdaDAOImpl implements PdaDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.pd.pdaMapper";
	
	//입출고관리  Location 수정	
	@Override
	public void updatePdaLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".updatePdaLocation", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재출고 제품코드, 설비코드 수정
	@Override
	public void updatePda(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updatePda", matrlInOutWhsAdmVo);
	}
	
	//제품 입고 boxNo 조회(제품 입고)
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".readGoodsProductInfo", goodsProductInfoAdmVo);
	}
	
	//제품 입고 Location 수정
	@Override
	public void updateProductLocation(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".updateProductLocation", goodsProductInfoAdmVo);
	}
	
	//PDA 제품 출하대기 Update
	@Override
	public void palletRelatedProductUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".palletRelatedProductUpdate_F3", goodsProductInfoAdmVo);
	}
	
	//제품 입고 boxNo 조회(제품 출고)
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfo2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".readGoodsProductInfo2", goodsProductInfoAdmVo);
	}
	
	//트레이 번호로 작업지시 조회
	@Override
	public GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".readTrayBoxByWorkOrdNo", goodsProductInfoAdmVo);
	}
	
	//Po그룹 시퀀스
	@Override
	public String selectPoGroup(String poSeq) throws Exception{
		return session.selectOne(namespace + ".selectPoGroup",poSeq);
	}
	
	//트레이 번호로 작업지시 조회
	@Override
	public PurchaseOrderAdmVo selectPoGroup_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectOne(namespace + ".selectPoGroup_F3", purchaseOrderAdmVo);
	}
	
	//제품 출고 제품생산정보관리 수정
	@Override
	public void updateBox(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".updateBox", goodsProductInfoAdmVo);
	}
	
	//재고실사(제품) 입고일&위치 목록 조회
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".goodsProductInfoList", goodsProductInfoAdmVo);
	}
	
	//PDA 자재 불량&반품 처리 Update
	public void updateMatrlApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updateMatrlApproval", matrlInOutWhsAdmVo);
	}
	
	//PDA 재고 제품출고 Update
	public void updatePreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		session.update(namespace + ".updatePreGoodsInventoryDtl", preGoodsInventoryAdmVo);
	}
	
	//제품 출고 재고제품 조회
	public PreGoodsInventoryAdmVo readPreGoodsInventoryDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return session.selectOne(namespace + ".readPreGoodsInventoryDtl", preGoodsInventoryAdmVo);
	}
	
	//제품 출고 재고제품 조회
	public List<PurchaseOrderAdmVo> palletRelatedProductList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace + ".palletRelatedProductList_F3", purchaseOrderAdmVo);
	}
	
	//BoxNo에 포함된 작지번호목록 검색(입고시 실링검사에 사용)
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductWorkOrdList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".goodsProductWorkOrdList", goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 기록쌓기
	public void insertGoodsProductHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.insert(namespace + ".insertGoodsProductHist", goodsProductInfoAdmVo);
	}
	
	//생산제품 선입선출 적용
	public GoodsProductInfoAdmVo goodsProductFifoCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".goodsProductFifoCheck", goodsProductInfoAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색
	public PreGoodsInventoryAdmVo preGoodsInventoryFifoCheck(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return session.selectOne(namespace + ".preGoodsInventoryFifoCheck", preGoodsInventoryAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색 목록
	@Override
	public List<PreGoodsInventoryAdmVo> preGoodsInventoryFifoCheckList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return session.selectList(namespace + ".preGoodsInventoryFifoCheckList", preGoodsInventoryAdmVo);
	}
	
	//BoxNo에 포함된 제품(초기재고) 검색
	public PurchaseOrderAdmVo poSeqSerchRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectOne(namespace + ".poSeqSerchRead", purchaseOrderAdmVo);
	}
	
	//박스 정보 삭제됨에 따라 업데이트
	@Override
	public void palletBoxDelete_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".palletBoxDelete_F3", goodsProductInfoAdmVo);
	}
	
	//출하 취소 제품 정보 업데이트
	@Override
	public void palletCancel_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".palletCancel_F3", goodsProductInfoAdmVo);
	}
	
	//고객사LotNo 수정
	@Override
	public void customerLotNoUpdate_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".customerLotNoUpdate_F3", goodsProductInfoAdmVo);
	}
	
	//박스 반품 처리
	@Override
	public void boxReturnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 session.update(namespace + ".boxReturnUpdate", goodsProductInfoAdmVo); 
	}
	
	//제품 상태변경시 기록쌓기 - SLD
	@Override
	public void insertGoodsProductHist_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".insertGoodsProductHist_F3", goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 다중 기록쌓기 - SLD
	@Override
	public void insertGoodsProductHist_F3_2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		session.update(namespace + ".insertGoodsProductHist_F3_2", goodsProductInfoAdmVo);
	}
	
	//파레트라벨 매핑 등록 상세조회
	public PurchaseOrderAdmVo palletMappingRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectOne(namespace + ".palletMappingRead", purchaseOrderAdmVo);
	}
	
	//파레트 번호 매칭 수정
	@Override
	public void palletMappingUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		 session.update(namespace + ".palletMappingUpdate", purchaseOrderAdmVo); 
	}
	
	//출하대기 박스 상세조회
	public PurchaseOrderAdmVo palletFactCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectOne(namespace + ".palletFactCheckRead", purchaseOrderAdmVo);
	}
	
	//출하대기체크 수정
	@Override
	public void palletBoxFactCheckUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 session.update(namespace + ".palletBoxFactCheckUpdate", goodsProductInfoAdmVo); 
	}
	
	//출하대기 취소 처리 진행
	@Override
	public void palletBoxFactCheckCancelUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 session.update(namespace + ".palletBoxFactCheckCancelUpdate", goodsProductInfoAdmVo); 
	}
	
	//점검대기로 상태값 변경
	@Override
	public void palletCheckStatusReplaceUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 session.update(namespace + ".palletCheckStatusReplaceUpdate", goodsProductInfoAdmVo); 
	}
	
	//출하대기 박스 상세조회
	public PurchaseOrderAdmVo palletCustomerCheckRead(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectOne(namespace + ".palletCustomerCheckRead", purchaseOrderAdmVo);
	}
	
	//포장대기로 상태값 변경
	@Override
	public void packingWaitingStatusUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		 session.update(namespace + ".packingWaitingStatusUpdate", goodsProductInfoAdmVo); 
	}
}