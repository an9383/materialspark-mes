package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.CustCorpPriceVo;
import mes.persistence.bm.CustCorpPriceDAO;

@Service
public class CustCorpPriceServiceImpl implements CustCorpPriceService {
	
	@Inject
	private CustCorpPriceDAO dao;
	
	//단가등록 조회
	@Override
	public List<CustCorpPriceVo> custCorpPriceList(CustCorpPriceVo Vo) throws Exception {
		return dao.custCorpPriceList(Vo);
	}
	
	//단가등록 상세조회
	@Override
	public CustCorpPriceVo custCorpPriceRead(CustCorpPriceVo Vo) throws Exception {
		return dao.custCorpPriceRead(Vo);
	}
	
	@Override
	//단가등록 등록
	public int custCorpPriceCreate(CustCorpPriceVo Vo) throws Exception {
		return dao.custCorpPriceCreate(Vo);
	}
	
	//단가등록 수정
	@Override
	public int custCorpPriceUpdate(CustCorpPriceVo Vo) throws Exception {
		return dao.custCorpPriceUpdate(Vo);
	}
	
	//단가등록 삭제
	@Override
	public int custCorpPriceDelete(CustCorpPriceVo Vo) throws Exception {
		return dao.custCorpPriceDelete(Vo);
	}
	
	//단가등록 중복체크
	@Override
	public CustCorpPriceVo pkCheck(CustCorpPriceVo Vo) throws Exception {
		return dao.pkCheck(Vo);
	}
	
	//고객사-제품 단가 조회
	@Override
	public CustCorpPriceVo custCorpPrice(CustCorpPriceVo Vo) throws Exception{
		return dao.custCorpPrice(Vo);
	}
}