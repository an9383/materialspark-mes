package mes.persistence.bs;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bs.PurchaseOrderAdmVo;
import mes.domain.bs.PurchaseOrderDtl;
import mes.domain.bs.PurchaseOrderOutputHistVo;


@Repository
public class PurchaseOrderAdmDAOImpl implements PurchaseOrderAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bs.purchaseOrderAdmMapper";
	
	//영업관리 구매주문정보목록조회
	@Override
	public List<PurchaseOrderAdmVo> listPurchaseOrderAll(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listPurchaseOrderAll", purchaseOrderAdmVo);
	}

	//영업관리 구매주문정보상세조회
	@Override
	public PurchaseOrderAdmVo read(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		return session.selectOne(namespace+".read", purchaseOrderAdmVo);
	}
	
	//영업관리 구매주문정보등록
	@Override
	public void create(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		session.insert(namespace+".create", purchaseOrderAdmVo);
	}
	
	//영업관리 구매주문정보수정
	@Override
	public void update(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		session.update(namespace+".update", purchaseOrderAdmVo);
	}
	
	//영업관리 출고이력수정
	@Override
	public void updateOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		session.update(namespace+".updateOutputHist", purchaseOrderOutputHistVo);
	}
		
	//영업관리 구매주문정보 삭제가능한지 체크
	@Override
	public int purchaseOrderDeleteCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		return session.selectOne(namespace+".purchaseOrderDeleteCheck", purchaseOrderAdmVo);
	}
	
	//출하 기록 boxNo 변경여부 체크
	@Override
	public int purchaseOrderDtlDeleteCheck(PurchaseOrderDtl purchaseOrderDtl) throws Exception {
		return session.selectOne(namespace+".purchaseOrderDtlDeleteCheck", purchaseOrderDtl);
	}
	
	//영업관리 구매주문정보 삭제
	@Override
	public void purchaseOrderDelete(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		session.delete(namespace+".purchaseOrderDelete", purchaseOrderAdmVo);
	}
	
	//영업관리 구매시퀀스
	@Override
	public String selectPurchaseOrderSeq(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		return session.selectOne(namespace+".selectPurchaseOrderSeq", purchaseOrderAdmVo);
	}	
	
	//영업관리  영업일보목록조회
	@Override
	public List<PurchaseOrderAdmVo> listPurchaseOrderDaily(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listPurchaseOrderDaily", purchaseOrderAdmVo);
	}
	
	//영업관리  영업일보목록조회
	@Override
	public List<PurchaseOrderAdmVo> listPurchaseOrderDaily_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listPurchaseOrderDaily_F3", purchaseOrderAdmVo);
	}
	
	//영업관리  영업일보목록상세조회
	@Override
	public List<PurchaseOrderOutputHistVo> outputHistList(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		return session.selectList(namespace+".outputHistList", purchaseOrderOutputHistVo);
	}
	
	//영업관리  영업일보목록상세조회
	@Override
	public List<PurchaseOrderOutputHistVo> outputHistList_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		return session.selectList(namespace+".outputHistList_F3", purchaseOrderOutputHistVo);
	}
	
	//영업관리 제품 출하 내역 조회
	@Override
	public List<PurchaseOrderDtl> inspectList(PurchaseOrderDtl purchaseOrderDtl) throws Exception{
		return session.selectList(namespace+".inspectList", purchaseOrderDtl);
	}
		
	//영업관리  출고이력목록조회
	@Override
	public List<PurchaseOrderAdmVo> listOutputHistAll(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOutputHistAll", purchaseOrderAdmVo);
	}
	
	//영업관리 수주집계표 거래처/품목별 
	@Override
	public List<PurchaseOrderAdmVo> listDealGoods(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoods", purchaseOrderAdmVo);
	}
	
	//영업관리 년도별 수주집계표 거래처/품목별 
	@Override
	public List<PurchaseOrderAdmVo> listDealGoodsYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoodsYear", purchaseOrderAdmVo);
	}
	
	//영업관리 년도별 수주집계표 오더구분별
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubunYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubunYear", purchaseOrderAdmVo);
	}
	
	//영업관리 수주집계표 오더구분별
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubun(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubun", purchaseOrderAdmVo);
	}
	
	//구매주문출고 이력 등록
	@Override
	public void histCreate(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.insert(namespace + ".histCreate",purchaseOrderOutputHistVo);
	}
	
	//파레트에 트레이 추가 적재 출고이력 수정
	@Override
	public void addTrayByPallet(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.update(namespace + ".addTrayByPallet",purchaseOrderOutputHistVo);
	}
	
	//파레트에 트레이 추가 적재 출고이력 수정
	@Override
	public void addTrayByPallet_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.update(namespace + ".addTrayByPallet_F3",purchaseOrderOutputHistVo);
	}

	//파레트에 트레이 출하 취소
	@Override
	public void removeTrayByPallet(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.update(namespace + ".removeTrayByPallet",purchaseOrderOutputHistVo);
	}
	
	//파레트에 트레이 출하 취소
	@Override
	public void removeTrayByPallet_F3(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.update(namespace + ".removeTrayByPallet_F3",purchaseOrderOutputHistVo);
	}
	
	//영업관리 구매주문정보수정
	@Override
	public void updateQty(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		session.update(namespace+".updateQty", purchaseOrderAdmVo);
	}
		
	//입출고관리 - 출고현황관리(iosc0070) 기간 조회
	@Override
	public List<PurchaseOrderAdmVo> productOutpoutDataList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".productOutpoutDataList", purchaseOrderAdmVo);
	}
	
	//입출고관리 - 출고현황관리(iosc0180) 기간 조회
	@Override
	public List<PurchaseOrderAdmVo> productOutpoutDataDtlList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".productOutpoutDataDtlList", purchaseOrderAdmVo);
	}
	
	//제품 출하 내역 등록
	@Override
	public void createPurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception {
		session.insert(namespace+".createPurchaseOrderDtl", purchaseOrderDtl);
	}
	
	//제품 출하 취소 체크
	@Override
	public int productOutputCancelCheck(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		return session.selectOne(namespace+".productOutputCancelCheck", purchaseOrderAdmVo);
	}
	
	//출하 취소 boxNo 삭제 
	@Override
	public void deletePurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception {
		session.delete(namespace+".deletePurchaseOrderDtl", purchaseOrderDtl);
	}
	
	//출하 취소 boxNo 삭제 후 순번 업데이트
	@Override
	public void updatePurchaseOrderDtl(PurchaseOrderDtl purchaseOrderDtl) throws Exception {
		session.update(namespace+".updatePurchaseOrderDtl", purchaseOrderDtl);
	}
		
	//출하 취소 총 출하 수량 수정
	@Override
	public void updatePurchaseOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		session.update(namespace+".updatePurchaseOutputHist", purchaseOrderOutputHistVo);
	}
	
	//박스 교체로 새 박스 투입
	@Override
	public void updatePurchaseOutputHistIn(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		session.update(namespace+".updatePurchaseOutputHistIn", purchaseOrderOutputHistVo);
	}
	
	//출하 이력 단일 조회
	@Override
	public PurchaseOrderOutputHistVo readPurchaseOrderOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		return session.selectOne(namespace+".readPurchaseOrderOutputHist", purchaseOrderOutputHistVo);
	}
	
	//출하 이력 리스트 조회
	@Override
	public List<PurchaseOrderOutputHistVo> readPurchaseOrderOutputHistList(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		return session.selectList(namespace+".readPurchaseOrderOutputHistList", purchaseOrderOutputHistVo);
	}
	
	//출하 이력 수기 출고이력 조회
	@Override
	public List<PurchaseOrderOutputHistVo> readPurchaseOrderOutputHistSugi(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception{
		return session.selectList(namespace+".readPurchaseOrderOutputHistSugi", purchaseOrderOutputHistVo);
	}
	//출고수량 0인 출하 이력 삭제
	@Override
	public void deletePurchaseOrderOutputHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		session.delete(namespace+".deletePurchaseOrderOutputHist", purchaseOrderOutputHistVo);
	}
	
	//출하 취소 PO, 수량 기록
	@Override
	public void createPurchaseCancelHist(PurchaseOrderOutputHistVo purchaseOrderOutputHistVo) throws Exception {
		session.insert(namespace+".createPurchaseCancelHist", purchaseOrderOutputHistVo);
	}
	
	//해당 PO 출하 취소수량만큼 출하수량, 미출하수량 UPDATE
	@Override
	public void updatePurchaseAdmOutputCancel(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception {
		session.update(namespace+".updatePurchaseAdmOutputCancel", purchaseOrderAdmVo);
	}
	
	//해당 PO 출하 수량만큼 출하수량, 미출하수량 UPDATE
	@Override
	public void updatePurchaseAdmOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		session.update(namespace+".updatePurchaseAdmOutput", purchaseOrderAdmVo);
	}
	
	//불량처리 
	@Override
	public void updateDtl(PurchaseOrderDtl purchaseOrderDtlVo) throws Exception{
		session.update(namespace+".updateDtl", purchaseOrderDtlVo);
	}
	
	//박스 반품 처리
	@Override
	public void boxReturnUpdate(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		session.update(namespace+".boxReturnUpdate", purchaseOrderAdmVo);
	}
	
	//파레트 이력 삭제
	@Override
	public void palletDelete(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		session.delete(namespace+".palletDelete", purchaseOrderAdmVo);
	}
	
	//PO_NO_SEQ 가져오기 
	@Override
	public String purchaseOrderPoNoSeq(PurchaseOrderDtl purchaseOrderDtlVo) throws Exception{
		return session.selectOne(namespace+".purchaseOrderPoNoSeq", purchaseOrderDtlVo);
	}
	
	//영업관리 출고집계표 거래처/품목별
	@Override
	public List<PurchaseOrderAdmVo> listDealGoodsOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoodsOutput", purchaseOrderAdmVo);
	}
	
	//영업관리 출고집계표 거래처
	@Override
	public List<PurchaseOrderAdmVo> listDealOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealOutput", purchaseOrderAdmVo);
	}
		
	//영업관리 출고집계표 오더구분별
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubunOutput(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubunOutput", purchaseOrderAdmVo);
	}
	
	//영업관리 년도별 출고집계표 거래처/품목별
	@Override
	public List<PurchaseOrderAdmVo> listDealGoodsOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoodsOutputYear", purchaseOrderAdmVo);
	}
		
	//영업관리 년도별 출고집계표 오더구분별
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubunOutputYear(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubunOutputYear", purchaseOrderAdmVo);
	}
	
	//입출고관리-제품출하 PO추적
	@Override
	public List<PurchaseOrderDtl> tracePurchaseOrderOutputHist(PurchaseOrderDtl purchaseOrderDtl) throws Exception{
		return session.selectList(namespace+".tracePurchaseOrderOutputHist", purchaseOrderDtl);
	}
	
	//입출고관리-제품출하 PO추적
	@Override
	public List<PurchaseOrderAdmVo> tracePurchaseOrderOutputHist2(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".tracePurchaseOrderOutputHist2", purchaseOrderAdmVo);
	}
	
	//출고집계표 요약본
	@Override
	public List<PurchaseOrderAdmVo> listchulgojipgye(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listchulgojipgye", purchaseOrderAdmVo);
	}
	
	//샘플판매 목록 조회
	@Override
	public List<PurchaseOrderAdmVo> purchaseOrderAdmSampleList(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".purchaseOrderAdmSampleList", purchaseOrderAdmVo);
	}
	
	
	//영업관리 출고집계표 거래처/품목별
	@Override
	public List<PurchaseOrderAdmVo> listDealGoodsOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoodsOutput_F3", purchaseOrderAdmVo);
	}
	//영업관리 출고집계표 거래처
	@Override
	public List<PurchaseOrderAdmVo> listDealOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealOutput_F3", purchaseOrderAdmVo);
	}
	//영업관리 출고집계표 오더구분별
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubunOutput_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubunOutput_F3", purchaseOrderAdmVo);
	}
	//출고집계표 요약본
	@Override
	public List<PurchaseOrderAdmVo> listchulgojipgye_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listchulgojipgye_F3", purchaseOrderAdmVo);
	}
	//샘플판매 목록 조회
	@Override
	public List<PurchaseOrderAdmVo> purchaseOrderAdmSampleList_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".purchaseOrderAdmSampleList_F3", purchaseOrderAdmVo);
	}
	
	
	//영업관리 출고집계표 거래처/품목별(년도)
	@Override
	public List<PurchaseOrderAdmVo> listDealGoodsOutputYear_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listDealGoodsOutputYear_F3", purchaseOrderAdmVo);
	}
	
	//영업관리 출고집계표 오더구분별(년도)
	@Override
	public List<PurchaseOrderAdmVo> listOrderGubunOutputYear_F3(PurchaseOrderAdmVo purchaseOrderAdmVo) throws Exception{
		return session.selectList(namespace+".listOrderGubunOutputYear_F3", purchaseOrderAdmVo);
	}
	
}