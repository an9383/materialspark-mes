package mes.persistence.po;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.ProductionPerfTrayVo;

@Repository
public class ProductionPerfTrayDAOImpl implements ProductionPerfTrayDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.po.productionPerfTrayMapper";

	//생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectList(namespace + ".productionPerfTrayList", productionPerfTrayVo);
	}
	//생산실적트레이 이전 행&현재 행 조회
	@Override
	public List<ProductionPerfTrayVo> trayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectList(namespace + ".trayInfoBeforeAfterList", productionPerfTrayVo);
	}
	//생산실적트레이 상세조회
	@Override
	public ProductionPerfTrayVo productionPerfTrayRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectOne(namespace + ".productionPerfTrayRead", productionPerfTrayVo);
	}
	//생산실적트레이 등록
	@Override
	public void productionPerfTrayCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		session.insert(namespace + ".productionPerfTrayCreate", productionPerfTrayVo);
	}	 
	 
	//생산실적트레이 수정
	@Override
	public void productionPerfTrayUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		session.update(namespace + ".productionPerfTrayUpdate", productionPerfTrayVo);
	}

	//생산실적 트레이 필름 수정
	@Override
	public void productionPerfTrayFilmLotUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		session.update(namespace + ".productionPerfTrayFilmLotUpdate", productionPerfTrayVo);
	}
	
	//생산실적트레이 삭제
	@Override
	public void productionPerfTrayDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.delete(namespace + ".productionPerfTrayDelete", productionPerfTrayVo);
	}
	
	//생산실적트레이 생산 개수
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeleteCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectOne(namespace + ".productionPerfTrayDeleteCheck", productionPerfTrayVo);
	}
	
	//생산실적트레이 시퀀스
	@Override
	public int productionPerfTraySeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectOne(namespace + ".productionPerfTraySeq" ,productionPerfTrayVo);
	}
	//생산실적트레이 (LABEL_LOT_NO) 시퀀스
	@Override
	public ProductionPerfTrayVo productionPerfTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectOne(namespace + ".productionPerfTrayLabelSeq", productionPerfTrayVo);
	}
	//생산실적트레이 (BOX_NO) 시퀀스
	@Override
	public ProductionPerfTrayVo goodsBoxNoTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectOne(namespace + ".goodsBoxNoTrayLabelSeq", productionPerfTrayVo);
	}
	//생산실적트레이 마지막 정보 조회
	@Override
	public ProductionPerfTrayVo productionPerfTrayLastInfo(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectOne(namespace + ".productionPerfTrayLastInfo", productionPerfTrayVo);
	}
	
	//생산실적트레이 라벨 출력 목록 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayPrintList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectList(namespace + ".productionPerfTrayPrintList", productionPerfTrayVo);
	}
	
	//제품입고 조회 트레이 라벨번호 조회
	@Override
	public List<ProductionPerfTrayVo> trayLabelSelect(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".trayLabelSelect", productionPerfTrayVo);
	}
	
	//생산실적트레이 삭제해야할 라벨번호 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayDeletedLabelRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".productionPerfTrayDeletedLabelRead", productionPerfTrayVo);
	}
	
	//생산실적트레이  삭제해야할 라벨번호 수정
	@Override
	public void productionPerfTrayDeletedLabelUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.update(namespace + ".productionPerfTrayDeletedLabelUpdate", productionPerfTrayVo);
	}
	
	//생산실적트레이  삭제해야할 라벨번호 수정2
	@Override
	public void productionPerfTrayDeletedLabelUpdate2(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.update(namespace + ".productionPerfTrayDeletedLabelUpdate2", productionPerfTrayVo);
	}
	
	
	//생산실적트레이 삭제할 트레이가 마지막 작지인지 확인
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeletedWorkOrdNoCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectOne(namespace + ".productionPerfTrayDeletedWorkOrdNoCheck", productionPerfTrayVo);
	}
	
	//생산실적트레이 삭제할 트레이가 제품생산정보관리에 등록되어있는지 확인
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeletedGoodsProductCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectOne(namespace + ".productionPerfTrayDeletedGoodsProductCheck", productionPerfTrayVo);
	}
	
	//제품 포장번호별 복원 시 ADM 삭제
	@Override
	public void deleteAllGoodsProduct(ProductionPerfTrayVo productionPerfTrayVo)  throws Exception {
		 session.delete(namespace + ".deleteAllGoodsProduct", productionPerfTrayVo);
	}
	
	//생산실적 서브 저장 시 트레이 생산데이터 조회 
	@Override
	public List<ProductionPerfTrayVo> workOrderSubCreateTrayDataAssistant(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectList(namespace + ".workOrderSubCreateTrayDataAssistant", productionPerfTrayVo);
	}
	
	//생산실적트레이 생산수량 조회 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayProductQtyList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".productionPerfTrayProductQtyList", productionPerfTrayVo);
	}
	
	//생산실적트레이_Rank
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayRankList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".productionPerfTrayRankList", productionPerfTrayVo);
	}
	
	
	//작업지시 Dtl 상세조회
	@Override
	public ProductionPerfTrayVo productResultRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectOne(namespace + ".productResultRead" , productionPerfTrayVo);
	}
	
	//LGES_관련 코드
	
	//LGES_생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> lgesProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".lgesProductionPerfTrayList", productionPerfTrayVo);
	}
	//LGES_생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> lgesEveProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".lgesEveProductionPerfTrayList", productionPerfTrayVo);
	}
	//LGES_생산실적트레이 이전 행&현재 행 조회
	@Override
	public List<ProductionPerfTrayVo> lgesTrayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".lgesTrayInfoBeforeAfterList", productionPerfTrayVo);
	}
	//LGES_생산실적트레이 (LGES_CODE) 시퀀
	@Override
	public ProductionPerfTrayVo trayLgesCodeSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return session.selectOne(namespace + ".trayLgesCodeSeq", productionPerfTrayVo);
	}
	//LGES_코드 출력 여부 확인
	@Override
	public List<ProductionPerfTrayVo> lgesCodePrintCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return session.selectList(namespace + ".lgesCodePrintCheck", productionPerfTrayVo);
	}
	//LGES_프린트 출력 여부
	@Override
	public void lgesPrintWhetherCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		session.insert(namespace + ".lgesPrintWhetherCreate", productionPerfTrayVo);
	}
	//LGES_프린트 여부 수정
	@Override
	public void lgesPrintWhetherUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.update(namespace + ".lgesPrintWhetherUpdate", productionPerfTrayVo);
	}
	//LGES_프린트 삭제
	@Override
	public void lgesPrintDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.delete(namespace + ".lgesPrintDelete", productionPerfTrayVo);
	}
	
	//개별 트레이 출력 여부 수정
	@Override
	public void trayReprintCheckUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		session.update(namespace + ".trayReprintCheckUpdate", productionPerfTrayVo);
	}
	
}