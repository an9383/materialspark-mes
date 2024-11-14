package mes.persistence.qm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.GoodsDisposeVo;
import mes.domain.qm.ShipInspectVo;

@Repository
public class GoodsDisposeDAOImpl implements GoodsDisposeDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.qm.goodsDisposeMapper";

	//폐기리스트 조회
	@Override
	public List<GoodsDisposeVo> list(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return session.selectList(namespace + ".list", goodsDisposeVo);
	}
	
	//폐기리스트 adm 조회
	@Override
	public List<GoodsDisposeVo> readAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return session.selectList(namespace + ".readAdm", goodsDisposeVo);
	}
	
	//폐기리스트 dtl 조회
	@Override
	public List<GoodsDisposeVo> readDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return session.selectList(namespace + ".readDtl", goodsDisposeVo);
	}
	
	//이상발생번호 채번
	@Override
	public String selectNoSeq(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return session.selectOne(namespace + ".selectNoSeq", goodsDisposeVo);
	}
	
	//이상발생내용 누적횟수
	@Override
	public String selectAccCnt(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return session.selectOne(namespace + ".selectAccCnt", goodsDisposeVo);
	}

	//폐기리스트 adm 생성
	@Override
	public void createAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		session.insert(namespace + ".createAdm", goodsDisposeVo);
	}
	
	//폐기리스트 dtl 생성
	@Override
	public void createDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		session.insert(namespace + ".createDtl", goodsDisposeVo);
	}
	
	//폐기리스트 adm 삭제
	@Override
	public void deleteAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		session.delete(namespace + ".deleteAdm", goodsDisposeVo);
	}
	
	//폐기리스트 dtl 삭제
	@Override
	public void deleteDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		session.delete(namespace + ".deleteDtl", goodsDisposeVo);
	}
	
	//폐기리스트 dtl 폐기구분자 수정
	@Override
	public void updateDisposeGubun(GoodsDisposeVo goodsDisposeVo) throws Exception{
		session.update(namespace + ".updateDisposeGubun", goodsDisposeVo);
	}
	
}