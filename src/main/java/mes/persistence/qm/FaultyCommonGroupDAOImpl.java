package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.FaultyCommonGroupVo;

@Repository
public class FaultyCommonGroupDAOImpl implements FaultyCommonGroupDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.faultyCommonGroupMapper";
	
	//불량그룹 전체조회
	@Override
	public List<FaultyCommonGroupVo> listAll() throws Exception{
		return session.selectList(namespace+".listAll");
	}
	
	//불량그룹 특정 Read
	@Override
	public FaultyCommonGroupVo read(FaultyCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//불량그룹 Create
	@Override
	public void create(FaultyCommonGroupVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//불량그룹 Update
	@Override
	public void update(FaultyCommonGroupVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//불량그룹 SEQ(baseGroupCd)
	@Override
	public FaultyCommonGroupVo readGroupSeq() throws Exception{
		return session.selectOne(namespace+".readGroupSeq");
	}
}