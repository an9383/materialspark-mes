package mes.service.po;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.ProductionPerfTrayVo;
import mes.persistence.po.ProductionPerfTrayDAO;

@Service
public class ProductionPerfTrayServiceImpl implements ProductionPerfTrayService {

	@Inject
	private ProductionPerfTrayDAO dao;
	
	//생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.productionPerfTrayList(productionPerfTrayVo);
	}
	//생산실적트레이 이전 행&현재 행 조회
	@Override
	public List<ProductionPerfTrayVo> trayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.trayInfoBeforeAfterList(productionPerfTrayVo);
	}
	//생산실적트레이 상세조회
	@Override
	public ProductionPerfTrayVo productionPerfTrayRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayRead(productionPerfTrayVo);
	}
	//생산실적트레이등록
	 @Override
	 public void productionPerfTrayCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		 dao.productionPerfTrayCreate(productionPerfTrayVo);
	}	 
	//생산실적트레이 수정
	@Override
	public void productionPerfTrayUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		dao.productionPerfTrayUpdate(productionPerfTrayVo);
	}
	//생산실적 트레이 필름 수정
	@Override
	public void productionPerfTrayFilmLotUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		dao.productionPerfTrayFilmLotUpdate(productionPerfTrayVo);
	}
	//생산실적트레이 삭제
	@Override
	public void productionPerfTrayDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.productionPerfTrayDelete(productionPerfTrayVo);
	}
	//생산실적트레이 생산 개수
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeleteCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayDeleteCheck(productionPerfTrayVo);
	}
	//생산실적트레이 시퀀스
	@Override
	public int productionPerfTraySeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.productionPerfTraySeq(productionPerfTrayVo);
	}
	//생산실적트레이 (LABEL_LOT_NO) 시퀀스
	@Override
	public ProductionPerfTrayVo productionPerfTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayLabelSeq(productionPerfTrayVo);
	}
	//생산실적트레이 (BOX_NO) 시퀀스
	@Override
	public ProductionPerfTrayVo goodsBoxNoTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.goodsBoxNoTrayLabelSeq(productionPerfTrayVo);
	}
	//생산실적트레이 마지막 정보 조회
	@Override
	public ProductionPerfTrayVo productionPerfTrayLastInfo(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayLastInfo(productionPerfTrayVo);
	}
	//생산실적트레이 라벨 출력 목록 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayPrintList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.productionPerfTrayPrintList(productionPerfTrayVo);
	}
	//제품입고 조회 트레이 라벨번호 조회
	@Override
	public List<ProductionPerfTrayVo> trayLabelSelect(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.trayLabelSelect(productionPerfTrayVo);
	}
	//생산실적트레이 삭제해야할 라벨번호 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayDeletedLabelRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayDeletedLabelRead(productionPerfTrayVo);
	}
	//생산실적트레이  삭제해야할 라벨번호 수정
	@Override
	public void productionPerfTrayDeletedLabelUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.productionPerfTrayDeletedLabelUpdate(productionPerfTrayVo);
	}
	//생산실적트레이  삭제해야할 라벨번호 수정2
	@Override
	public void productionPerfTrayDeletedLabelUpdate2(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.productionPerfTrayDeletedLabelUpdate2(productionPerfTrayVo);
	}
	//생산실적트레이 삭제할 트레이가 마지막 작지인지 확인
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeletedWorkOrdNoCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayDeletedWorkOrdNoCheck(productionPerfTrayVo);
	}
	//생산실적트레이 삭제할 트레이가 제품생산정보관리에 등록되어있는지 확인
	@Override
	public ProductionPerfTrayVo productionPerfTrayDeletedGoodsProductCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayDeletedGoodsProductCheck(productionPerfTrayVo);
	}
	//제품 포장번호별 복원 시 ADM 삭제
	@Override
	public void deleteAllGoodsProduct(ProductionPerfTrayVo  productionPerfTrayVo)  throws Exception {
		 dao.deleteAllGoodsProduct(productionPerfTrayVo);
	}
	//생산실적 서브 저장 시 트레이 생산데이터 조회 
	@Override
	public List<ProductionPerfTrayVo> workOrderSubCreateTrayDataAssistant(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.workOrderSubCreateTrayDataAssistant(productionPerfTrayVo);
	}
	//생산실적트레이 생산수량 조회 조회
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayProductQtyList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayProductQtyList(productionPerfTrayVo);
	}
	//생산실적트레이_Rank
	@Override
	public List<ProductionPerfTrayVo> productionPerfTrayRankList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.productionPerfTrayRankList(productionPerfTrayVo);
	}
	
	
	//작업지시 Dtl 상세조회
	@Override
	public ProductionPerfTrayVo productResultRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		return dao.productResultRead(productionPerfTrayVo);
	}
	
	
	//LGES_관련 코드
	
	//LGES_생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> lgesProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.lgesProductionPerfTrayList(productionPerfTrayVo);
	}
	//LGES_생산실적트레이 조회
	@Override
	public List<ProductionPerfTrayVo> lgesEveProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.lgesEveProductionPerfTrayList(productionPerfTrayVo);
	}
	//LGES_생산실적트레이 이전 행&현재 행 조회
	@Override
	public List<ProductionPerfTrayVo> lgesTrayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.lgesTrayInfoBeforeAfterList(productionPerfTrayVo);
	}
	//LGES_생산실적트레이 (LGES_CODE) 시퀀
	@Override
	public ProductionPerfTrayVo trayLgesCodeSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.trayLgesCodeSeq(productionPerfTrayVo);
	}
	//LGES_코드 출력 여부 확인
	@Override
	public List<ProductionPerfTrayVo> lgesCodePrintCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		return dao.lgesCodePrintCheck(productionPerfTrayVo);
	}
	//LGES_프린트 출력 여부
	 @Override
	 public void lgesPrintWhetherCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception {
		 dao.lgesPrintWhetherCreate(productionPerfTrayVo);
	}
	//LGES_프린트 여부 수정
	@Override
	public void lgesPrintWhetherUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.lgesPrintWhetherUpdate(productionPerfTrayVo);
	}
	//LGES_프린트 삭제
	@Override
	public void lgesPrintDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.lgesPrintDelete(productionPerfTrayVo);
	}
	
	//개별 트레이 출력 여부 수정
	@Override
	public void trayReprintCheckUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		dao.trayReprintCheckUpdate(productionPerfTrayVo);
	}

}