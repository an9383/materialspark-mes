package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.GoodsCodeAdmVo;
import mes.persistence.bm.GoodsCodeAdmDAO;

@Service
public class GoodsCodeAdmServiceImpl implements GoodsCodeAdmService {

	@Inject
	private GoodsCodeAdmDAO dao;

	//제품코드 목록조회
	@Override
	public List<GoodsCodeAdmVo> listAll(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return dao.listAll(goodsCodeAdmVo);
	}

	//제품코드 목록조회
	@Override
	public List<GoodsCodeAdmVo> listAll2(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return dao.listAll2(goodsCodeAdmVo);
	}
	
	//제품코드 상세조회
	@Override
	public GoodsCodeAdmVo read(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return dao.read(goodsCodeAdmVo);	
	}
	
	//제품코드 등록
	@Override
	public void create(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		dao.create(goodsCodeAdmVo);
	}
	
	//제품코드 수정
	@Override
	public void update(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		dao.update(goodsCodeAdmVo);
	}
	
	//제품코드 코드시퀀스조회
	@Override
	public String selectGoodsSeqCd() throws Exception{
		return dao.selectGoodsSeqCd();
	}
	
	//제품코드 수정
	@Override
	public GoodsCodeAdmVo searchModelNo(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return dao.searchModelNo(goodsCodeAdmVo);
	}
	
	//월별 FP 잡체인지 제품 모달
	@Override
	public List<GoodsCodeAdmVo> jobChangeGoodsModal(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return dao.jobChangeGoodsModal(goodsCodeAdmVo);
	}
	
	//기종 리스트
	@Override
	public List<GoodsCodeAdmVo> goosdCdGijonglist(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return dao.goosdCdGijonglist(goodsCodeAdmVo);
	}
	
}