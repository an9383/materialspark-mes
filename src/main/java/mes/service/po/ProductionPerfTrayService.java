package mes.service.po;

import java.util.List;

import mes.domain.po.ProductionPerfTrayVo;

public interface ProductionPerfTrayService {

	//생산실적트레이 조회
	public List<ProductionPerfTrayVo> productionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 이전 행&현재 행 조회
	public List<ProductionPerfTrayVo> trayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 상세조회
	public ProductionPerfTrayVo productionPerfTrayRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 등록
	public void productionPerfTrayCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 수정
	public void productionPerfTrayUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적 트레이 필름 수정
	public void productionPerfTrayFilmLotUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 삭제
	public void productionPerfTrayDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 생산 개수
	public ProductionPerfTrayVo productionPerfTrayDeleteCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 시퀀스
	public int productionPerfTraySeq(ProductionPerfTrayVo productionPerfTrayVo)throws Exception;
	
	//생산실적트레이 (LABEL_LOT_NO) 시퀀스
	public ProductionPerfTrayVo productionPerfTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 (BOX_NO) 시퀀스
	public ProductionPerfTrayVo goodsBoxNoTrayLabelSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 마지막 정보 조회
	public ProductionPerfTrayVo productionPerfTrayLastInfo(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 라벨 출력 목록 조회
	public List<ProductionPerfTrayVo> productionPerfTrayPrintList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//제품입고 조회 트레이 라벨번호 조회
	public List<ProductionPerfTrayVo> trayLabelSelect(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 삭제해야할 라벨번호 조회
	public List<ProductionPerfTrayVo> productionPerfTrayDeletedLabelRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이  삭제해야할 라벨번호 수정
	public void productionPerfTrayDeletedLabelUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이  삭제해야할 라벨번호 수정2
	public void productionPerfTrayDeletedLabelUpdate2(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 삭제할 트레이가 마지막 작지인지 확인
	public ProductionPerfTrayVo productionPerfTrayDeletedWorkOrdNoCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 삭제할 트레이가 제품생산정보관리에 등록되어있는지 확인
	public ProductionPerfTrayVo productionPerfTrayDeletedGoodsProductCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//제품생산정보관리에 등록되어있는 데이터 삭제
	public void deleteAllGoodsProduct(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적 서브 저장 시 트레이 생산데이터 조회 
	public List<ProductionPerfTrayVo> workOrderSubCreateTrayDataAssistant(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이 생산수량 조회 조회
	public List<ProductionPerfTrayVo> productionPerfTrayProductQtyList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//생산실적트레이_Rank
	public List<ProductionPerfTrayVo> productionPerfTrayRankList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;	
	
	
	//작업지시 Dtl 상세조회
	public ProductionPerfTrayVo productResultRead(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	
	//LGES_관련 코드
	
	//LGES_생산실적트레이 조회
	public List<ProductionPerfTrayVo> lgesProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_생산실적트레이 조회
	public List<ProductionPerfTrayVo> lgesEveProductionPerfTrayList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_생산실적트레이 이전 행&현재 행 조회
	public List<ProductionPerfTrayVo> lgesTrayInfoBeforeAfterList(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_생산실적트레이 (LGES_CODE) 시퀀
	public ProductionPerfTrayVo trayLgesCodeSeq(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_코드 출력 여부 확인
	public List<ProductionPerfTrayVo> lgesCodePrintCheck(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_프린트 출력 여부
	public void lgesPrintWhetherCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_프린트 여부 수정
	public void lgesPrintWhetherUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//LGES_프린트 삭제
	public void lgesPrintDelete(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
	
	//개별 트레이 출력 여부 수정
	public void trayReprintCheckUpdate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception;
}