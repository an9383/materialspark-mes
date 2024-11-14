package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.GoodsMatrlDtlVo;

@Repository
public class GoodsMatrlDtlDAOImpl implements GoodsMatrlDtlDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.goodsMatrlDtlMapper";
	
	//제품자재상세 전체조회
	@Override
	public List<GoodsMatrlDtlVo> listAll(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		return session.selectList(namespace+".listAll", goodsMatrlDtlVo);
	}
	
	//제품자재상세 Create
	@Override
	public void create(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		session.insert(namespace+".create", goodsMatrlDtlVo);
	}
	
	//제품자재상세 Update
	@Override
	public void update(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		session.update(namespace+".update", goodsMatrlDtlVo);
	}
	
	//제품자재상세 Delete
	@Override
	public void delete(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception{
		session.insert(namespace+".delete", goodsMatrlDtlVo);
	}
	
}