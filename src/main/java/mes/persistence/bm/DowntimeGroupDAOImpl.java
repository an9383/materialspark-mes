package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.SystemCommonGroupVo;

@Repository
public class DowntimeGroupDAOImpl implements DowntimeGroupDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.downtimeGroupMapper";
	
	//비가동그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll() throws Exception{
		return session.selectList(namespace+".listAll");
	}
	
	//비가동그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//비가동그룹 Create
	@Override
	public void create(SystemCommonGroupVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//비가동그룹 Update
	@Override
	public void update(SystemCommonGroupVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//비가동그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo readGroupSeq() throws Exception{
		return session.selectOne(namespace+".readGroupSeq");
	}
	
}