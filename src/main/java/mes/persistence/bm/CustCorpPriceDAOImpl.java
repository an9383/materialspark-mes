package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.CustCorpPriceVo;

@Repository
public class CustCorpPriceDAOImpl implements CustCorpPriceDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.custCorpPriceMapper";
	
	@Override
	public List<CustCorpPriceVo> custCorpPriceList(CustCorpPriceVo Vo) throws Exception {
		return session.selectList(namespace + ".custCorpPriceList", Vo);
	}
	
	@Override
	public CustCorpPriceVo custCorpPriceRead(CustCorpPriceVo Vo) throws Exception {
		return session.selectOne(namespace + ".custCorpPriceRead", Vo);
	}
	
	@Override
	public int custCorpPriceCreate(CustCorpPriceVo Vo) throws Exception {
		return session.insert(namespace + ".custCorpPriceCreate", Vo);
	}
	
	@Override
	public int custCorpPriceUpdate(CustCorpPriceVo Vo) throws Exception {
		return session.update(namespace + ".custCorpPriceUpdate", Vo);
	}
	
	@Override
	public int custCorpPriceDelete(CustCorpPriceVo Vo) throws Exception {
		return session.delete(namespace + ".custCorpPriceDelete" ,Vo );
	}

	@Override
	public CustCorpPriceVo pkCheck(CustCorpPriceVo Vo) throws Exception {
		return session.selectOne(namespace + ".pkCheck", Vo);
	}
	
	@Override
	public CustCorpPriceVo custCorpPrice(CustCorpPriceVo Vo) throws Exception{
		return session.selectOne(namespace + ".custCorpPrice", Vo);
	}
}