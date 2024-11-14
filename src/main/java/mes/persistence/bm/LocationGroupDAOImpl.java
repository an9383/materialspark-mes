package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.SystemCommonGroupVo;

@Repository
public class LocationGroupDAOImpl implements LocationGroupDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.locationGroupMapper";
	
	//시스템공통그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll() throws Exception{
		return session.selectList(namespace+".listAll");
	}
	
	//시스템공통그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//시스템공통그룹 Create
	@Override
	public void create(SystemCommonGroupVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//시스템공통그룹 Update
	@Override
	public void update(SystemCommonGroupVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//시스템공통그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo readGroupSeq() throws Exception{
		return session.selectOne(namespace+".readGroupSeq");
	}
	
	
	
	//품질정보그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> inspectInfoListAll() throws Exception{
		return session.selectList(namespace+".inspectInfoListAll");
	}
	
	//품질정보그룹 특정 Read
	@Override
	public SystemCommonGroupVo inspectInfoRead(SystemCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".inspectInfoRead", Vo);
	}
	
	//품질정보그룹 Create
	@Override
	public void inspectInfoCreate(SystemCommonGroupVo Vo) throws Exception{
		session.insert(namespace+".inspectInfoCreate", Vo);
	}
	
	//품질정보그룹 Update
	@Override
	public void inspectInfoUpdate(SystemCommonGroupVo Vo) throws Exception{
		session.update(namespace+".inspectInfoUpdate", Vo);
	}
	
	//품질정보그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo inspectInfoReadGroupSeq() throws Exception{
		return session.selectOne(namespace+".inspectInfoReadGroupSeq");
	}

}