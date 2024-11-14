package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.CustCorpPriceVo;

public interface CustCorpPriceDAO {
	
	//단가등록 조회
	public List<CustCorpPriceVo> custCorpPriceList(CustCorpPriceVo Vo) throws Exception;
	
	//단가등록 상세조회
	public CustCorpPriceVo custCorpPriceRead(CustCorpPriceVo Vo) throws Exception;
	
	//단가등록 등록
	public int custCorpPriceCreate(CustCorpPriceVo Vo) throws Exception;
	
	//단가등록 수정
	public int custCorpPriceUpdate(CustCorpPriceVo Vo) throws Exception;
	
	//단가등록 삭제
	public int custCorpPriceDelete(CustCorpPriceVo Vo) throws Exception;
	
	//단가등록 중복체크
	public CustCorpPriceVo pkCheck(CustCorpPriceVo Vo) throws Exception;

	//고객사-제품 단가 조회
	public CustCorpPriceVo custCorpPrice(CustCorpPriceVo Vo) throws Exception;
}