package mes.persistence.bs;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.ItemInfoAdmVo;
import mes.domain.bs.BizOrderVo;

@Repository
public class BizOrderDAOImpl implements BizOrderDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bs.bizOrderMapper";
	
	// =========================== 수주관리 메인 ==========================================
	// 수주관리 메인 목록조회
	@Override
	public List<BizOrderVo> bizOrderAdmLst(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderAdmLst", bizOrderVo);
	}
	
	// 수주관리 메인 목록조회-GROUP BY 고객사
	@Override
	public List<BizOrderVo> bizOrderAdmLstGroupByDealCorp(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderAdmLstGroupByDealCorp", bizOrderVo);
	}
	
	// 수주관리 메인 목록조회-GROUP BY 자재
	@Override
	public List<BizOrderVo> bizOrderDtlLstGroupByMatrl(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderDtlLstGroupByMatrl", bizOrderVo);
	}
	
	// 수주관리 메인 상세조회
	@Override
	public BizOrderVo bizOrderAdmSel(BizOrderVo bizOrderVo) throws Exception {
		return session.selectOne(namespace+".bizOrderAdmSel", bizOrderVo);
	}
	
	// 수주관리 메인 등록
	@Override
	public String bizOrderAdmIns(BizOrderVo bizOrderVo) throws Exception {
		session.insert(namespace+".bizOrderAdmIns", bizOrderVo);
		String idx = bizOrderVo.getIdx();
		return idx;
	}
	
	// 수주관리 메인 수정
	@Override
	public void bizOrderAdmUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderAdmUpd", bizOrderVo);
	}
	
	// 수주관리 번들링 업데이트
	@Override
	public void bizOrderAdmBundleUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderAdmBundleUpd", bizOrderVo);
	}
	
	// 수주관리 메인 삭제
	@Override
	public void bizOrderAdmDel(BizOrderVo bizOrderVo) throws Exception {
		session.delete(namespace+".bizOrderAdmDel", bizOrderVo);
	}
	
	// 수주관리 메인 목형코드 중복확인
	@Override
	public BizOrderVo bizOrderAdmIdDupCheck(BizOrderVo bizOrderVo) throws Exception {
		return session.selectOne(namespace+".bizOrderAdmIdDupCheck", bizOrderVo);
	}
	
	// =========================== 수주관리 상세 ==========================================
	// 수주관리 상세 등록할 때 현재고체크
	@Override
	public List<BizOrderVo> bizOrderSpQtySel(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderSpQtySel", bizOrderVo);
	}
	
	// 수주관리 상세 목록조회
	@Override
	public List<BizOrderVo> bizOrderDtlLst(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderDtlLst", bizOrderVo);
	}
	
	// 수주관리 상세 상세조회
	@Override
	public BizOrderVo bizOrderDtlSel(BizOrderVo bizOrderVo) throws Exception {
		return session.selectOne(namespace+".bizOrderDtlSel", bizOrderVo);
	}
	
	// 수주관리 상세 등록
	@Override
	public void bizOrderDtlIns(BizOrderVo bizOrderVo) throws Exception {
		session.insert(namespace+".bizOrderDtlIns", bizOrderVo);
	}
	
	// 수주관리 상세 수정
	@Override
	public void bizOrderDtlUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlUpd", bizOrderVo);
	}
	
	// 수주관리 상세 관리내역서출력
	@Override
	public void bizOrderDtlUpdByEditHistoryPrint(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlUpdByEditHistoryPrint", bizOrderVo);
	}
	
	// 수주관리 상세 번들링출력
	@Override
	public void bizOrderDtlUpdByBundlePrint(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlUpdByBundlePrint", bizOrderVo);
	}
	
	// 수주관리 상세 수주 상태 수정
	@Override
	public void bizOrderDtlStatusUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlStatusUpd", bizOrderVo);
	}
	
	// 수주관리 상세 수정 - 팀별일정조정표
	@Override
	public void bizOrderDtlUpdByTeamSchedule(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlUpdByTeamSchedule", bizOrderVo);
	}
	
	// 수주관리 수주중지
	@Override
	public void bizOrderDtlStop(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlStop", bizOrderVo);
	}
	
	// 출고시 수주 상태값 수정
	@Override
	public void bizOrderDtlStatusUpdWithItemOut(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlStatusUpdWithItemOut", bizOrderVo);
	}
	
	// 수주관리 상세 수정
	@Override
	public void bizOrderDtlStockYnUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlStockYnUpd", bizOrderVo);
	}
	
	// 수주관리 상세 삭제
	@Override
	public void bizOrderDtlDel(BizOrderVo bizOrderVo) throws Exception {
		session.delete(namespace+".bizOrderDtlDel", bizOrderVo);
	}
	
	// 수주관리 상세 취소처리
	@Override
	public void bizOrderDtlCancel(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlCancel", bizOrderVo);
	}
	
	// 수주관리 상세 PO완료 처리
	@Override
	public void bizOrderDtlPoEnd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlPoEnd", bizOrderVo);
	}
	
	// 수주관리 상세 PO완료처리 - 여러건 한번에 처리
	@Override
	public void bizOrderDtlPoEndByBizOrdDtlIdxString(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlPoEndByBizOrdDtlIdxString", bizOrderVo);
	}
	
	// 수주관리 상세 버전 최신화(업데이트)
	@Override
	public void bizOrderDtlItemVersionUpd(BizOrderVo bizOrderVo) throws Exception {
		session.update(namespace+".bizOrderDtlItemVersionUpd", bizOrderVo);
	}
	
	// =========================== 수주현황 ==========================================
	// 수주관리 전체 목록조회(수주별발주미포함)
	@Override
	public List<BizOrderVo> bizOrderStatusLst(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderStatusLst", bizOrderVo);
	}
	
	// 수주관리 전체 목록조회(수주별발주포함)
	@Override
	public List<BizOrderVo> bizOrderStatusLstWithPO(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderStatusLstWithPO", bizOrderVo);
	}
	
	// =========================== 공정정보 ==========================================
	//수주관리 제품공정 목록
	@Override
	public List<ItemInfoAdmVo> bizOrderItemPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".bizOrderItemPrcssList" ,itemInfoAdmVo );
	}

	//수주관리 작지공정 목록
	@Override
	public List<ItemInfoAdmVo> bizOrderWorkOrderPrcssList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".bizOrderWorkOrderPrcssList" ,itemInfoAdmVo );
	}
	
	//수주관리 제품공정 작업계획확정 전 작업지시 체크
	@Override
	public List<ItemInfoAdmVo> bizOrderWorkOrderCheckList(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		return session.selectList(namespace+".bizOrderWorkOrderCheckList" ,itemInfoAdmVo );
	}
		
	//수주관리 제품공정 작업계획확정
	@Override
	public void bizOrderWorkOrderInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderWorkOrderInsert", itemInfoAdmVo);
	}
	
	//수주관리 제품공정 작업계획취소
	@Override
	public void bizOrderWorkOrderDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception{
		session.delete(namespace+".bizOrderWorkOrderDelete", itemInfoAdmVo);
	}
	
	//수주관리 제품공정 복사
	@Override
	public void bizOrderItemPrcssCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderItemPrcssCopy", itemInfoAdmVo);
	}
	
	//수주관리 제품공정 등록
	@Override
	public void bizOrderItemPrcssInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderItemPrcssInsert", itemInfoAdmVo);
	}
	
	//수주관리 제품공정 삭제
	@Override
	public void bizOrderItemPrcssDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".bizOrderItemPrcssDelete", itemInfoAdmVo);
	}
	
	// =========================== 투입자재 ==========================================
	//수주관리 투입자재 목록
	@Override
	public List<ItemInfoAdmVo> bizOrderItemBomList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return session.selectList(namespace+".bizOrderItemBomList" ,itemInfoAdmVo );
	}
	
	//수주관리 투입자재 등록
	@Override
	public void bizOrderItemBomInsert(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderItemBomInsert", itemInfoAdmVo);
	}
	
	//수주관리 투입자재 복사
	@Override
	public void bizOrderItemBomCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderItemBomCopy", itemInfoAdmVo);
	}
	
	//수주관리 투입자재 삭제
	@Override
	public void bizOrderItemBomDelete(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".bizOrderItemBomDelete", itemInfoAdmVo);
	}
	
	// =========================== 번들링 ==========================================
	//수주관리 번들링 목록
	@Override
	public List<ItemInfoAdmVo> bizOrderDtlBundleList(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		return session.selectList(namespace+".bizOrderDtlBundleList" ,itemInfoAdmVo );
	}
	
	//수주관리 번들링 등록
	@Override
	public void bizOrderDtlBundleIns(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderDtlBundleIns", itemInfoAdmVo);
	}
	
	//수주관리 번들링 복사
	@Override
	public void bizOrderDtlBundleCopy(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.insert(namespace+".bizOrderDtlBundleCopy", itemInfoAdmVo);
	}
	
	//수주관리 번들링 삭제
	@Override
	public void bizOrderDtlBundleDel(ItemInfoAdmVo itemInfoAdmVo) throws Exception {
		session.delete(namespace+".bizOrderDtlBundleDel", itemInfoAdmVo);
	}
	
	// =========================== 수주집계표 ==========================================
	// 수주관리 수주집계표 수주기간별 수주처 목록조회
	@Override
	public List<BizOrderVo> bizOrderAdmLstAsDealCorp(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderAdmLstAsDealCorp" ,bizOrderVo );
	}
	
	// 수주관리 수주집계표 수주처별 목록조회
	@Override
	public List<BizOrderVo> bizOrderDtlLstByDealCorp(BizOrderVo bizOrderVo) throws Exception {
		return session.selectList(namespace+".bizOrderDtlLstByDealCorp" ,bizOrderVo );
	}
	
	// ===========================출고관리/ 거래명세서 ==========================================
	// 거래명세서 번들링 구성품 목록
	public List<BizOrderVo> bizItemBundleList(BizOrderVo bizOrderVo) throws Exception{
		return session.selectList(namespace+".bizItemBundleList" ,bizOrderVo );
	}
	
	// ===========================영업관리 / FSC제품 ==========================================
	// FSC제품 조회
	public List<BizOrderVo> fscItemList(BizOrderVo bizOrderVo) throws Exception{
		return session.selectList(namespace+".fscItemList" ,bizOrderVo);
	}
}
