package mes.service.bm;

import java.util.List;

import mes.domain.bm.GoodsCodeAdmVo;

public interface GoodsCodeAdmService {
	
	//제품코드 목록조회
	public List<GoodsCodeAdmVo> listAll(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;
	
	//제품코드 목록조회
	public List<GoodsCodeAdmVo> listAll2(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;

	//제품코드 상세조회
	public GoodsCodeAdmVo read(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;
	
	//제품코드 등록
	public void create(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;
	
	//제품코드 수정
	public void update(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;	
	
	//제품코드 코드시퀀스조회
	public String selectGoodsSeqCd() throws Exception;		
	
	//제품 새로 등록 시 모델NO 중복검사
	public GoodsCodeAdmVo searchModelNo(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;	
	
	//월별 FP 잡체인지 제품 모달
	public List<GoodsCodeAdmVo> jobChangeGoodsModal(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;
	
	//기종 리스트
	public List<GoodsCodeAdmVo> goosdCdGijonglist(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception;
	
}