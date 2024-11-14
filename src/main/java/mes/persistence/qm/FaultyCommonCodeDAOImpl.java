package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.FaultyCommonCodeVo;
import mes.domain.qm.FaultyCommonGroupVo;

@Repository
public class FaultyCommonCodeDAOImpl implements FaultyCommonCodeDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.faultyCommonCodeMapper";
	
	//불량코드 전체조회
	@Override
	public List<FaultyCommonCodeVo> listAll(FaultyCommonCodeVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//불량코드 특정 Read
	public FaultyCommonCodeVo read(FaultyCommonCodeVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//불량코드 Create
	@Override
	public void create(FaultyCommonCodeVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//불량코드 Update
	@Override
	public void update(FaultyCommonCodeVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}

	//불량코드 특정 Read
	public FaultyCommonCodeVo readCommonSeq(FaultyCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".readCommonSeq", Vo);
	}
	
}