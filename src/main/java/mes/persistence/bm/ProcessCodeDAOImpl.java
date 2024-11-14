package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;

@Repository
public class ProcessCodeDAOImpl implements ProcessCodeDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.processCodeMapper";
	
	//공정순서코드 전체조회
	@Override
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//공정순서코드 특정 Read
	@Override
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//공정순서코드 Create
	@Override
	public void create(SystemCommonCodeVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//공정순서코드 Update
	@Override
	public void update(SystemCommonCodeVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}

	//공정순서코드 특정 Read
	@Override
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".readCommonSeq", Vo);
	}
	
}