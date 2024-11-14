package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.GoodsMatrlDtlVo;
import mes.persistence.bm.GoodsMatrlDtlDAO;

@Service
public class GoodsMatrlDtlServiceImpl implements GoodsMatrlDtlService {

	@Inject
	private GoodsMatrlDtlDAO dao;

	//제품자재상세 전체조회
	@Override
	public List<GoodsMatrlDtlVo> listAll(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		return dao.listAll(goodsMatrlDtlVo);
	}
	
	//제품자재상세 Create
	@Override
	public void create(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		dao.create(goodsMatrlDtlVo);
	}
	
	//제품자재상세 Update
	@Override
	public void update(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		dao.update(goodsMatrlDtlVo);
	}
	
	//제품자재상세 Delete
	@Override
	public void delete(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		dao.delete(goodsMatrlDtlVo);
	}
	
}