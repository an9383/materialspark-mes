package mes.service.bm;

import java.util.List;

import mes.domain.bm.GoodsMatrlDtlVo;

public interface GoodsMatrlDtlService {
	
	//제품자재상세 전체조회
	public List<GoodsMatrlDtlVo> listAll(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception;
	
	//제품자재상세 Create
	public void create(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception;
	
	//제품자재상세 Update
	public void update(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception;
	
	//제품자재상세 Delete
	public void delete(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception;
	
}