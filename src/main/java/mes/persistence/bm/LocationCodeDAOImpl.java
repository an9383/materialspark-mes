package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;

@Repository
public class LocationCodeDAOImpl implements LocationCodeDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.locationCodeMapper";
	
	//시스템공통코드 전체조회
	@Override
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//시스템공통코드 특정 Read
	@Override
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//시스템공통코드 Create
	@Override
	public void create(SystemCommonCodeVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//시스템공통코드 Update
	@Override
	public void update(SystemCommonCodeVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}

	//시스템공통코드 특정 Read
	@Override
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".readCommonSeq", Vo);
	}

	//품질정보 관리 009 조회
	@Override
	public List<SystemCommonCodeVo> inspectList(SystemCommonCodeVo Vo) throws Exception{
		return session.selectList(namespace+".inspectList", Vo);
	}
	
	/*
	 * //시스템공통코드 전체조회
	 * 
	 * @Override public List<SystemCommonCodeVo>
	 * inspectInfoListAll(SystemCommonCodeVo Vo) throws Exception{ return
	 * session.selectList(namespace+".inspectInfoListAll", Vo); }
	 * 
	 * //시스템공통코드 특정 Read public SystemCommonCodeVo
	 * inspectInfoRead(SystemCommonCodeVo Vo) throws Exception{ return
	 * session.selectOne(namespace+".inspectInfoRead", Vo); }
	 * 
	 * //시스템공통코드 Create
	 * 
	 * @Override public void inspectInfoCreate(SystemCommonCodeVo Vo) throws
	 * Exception{ session.insert(namespace+".inspectInfoCreate", Vo); }
	 * 
	 * //시스템공통코드 Update
	 * 
	 * @Override public void inspectInfoUpdate(SystemCommonCodeVo Vo) throws
	 * Exception{ session.update(namespace+".inspectInfoUpdate", Vo); }
	 * 
	 * //시스템공통코드 특정 Read public SystemCommonCodeVo
	 * inspectInfoReadCommonSeq(SystemCommonGroupVo Vo) throws Exception{ return
	 * session.selectOne(namespace+".inspectInfoReadCommonSeq", Vo); }
	 */
}