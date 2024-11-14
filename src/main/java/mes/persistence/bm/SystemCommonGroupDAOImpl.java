package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.LogionHistVo;
import mes.domain.bm.SystemCommonGroupVo;

@Repository
public class SystemCommonGroupDAOImpl implements SystemCommonGroupDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.systemCommonGroupMapper";
	
	//시스템공통그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		return session.selectList(namespace+".listAll", systemCommonGroupVo);
	}
	
	//시스템공통그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		return session.selectOne(namespace+".read", systemCommonGroupVo);
	}
	
	//시스템공통그룹 Create
	@Override
	public void create(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		session.insert(namespace+".create", systemCommonGroupVo);
	}
	
	//시스템공통그룹 Update
	@Override
	public void update(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		session.update(namespace+".update", systemCommonGroupVo);
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
	public SystemCommonGroupVo inspectInfoRead(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		return session.selectOne(namespace+".inspectInfoRead", systemCommonGroupVo);
	}
	
	//품질정보그룹 Create
	@Override
	public void inspectInfoCreate(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		session.insert(namespace+".inspectInfoCreate", systemCommonGroupVo);
	}
	
	//품질정보그룹 Update
	@Override
	public void inspectInfoUpdate(SystemCommonGroupVo systemCommonGroupVo) throws Exception{
		session.update(namespace+".inspectInfoUpdate", systemCommonGroupVo);
	}
	
	//품질정보그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo inspectInfoReadGroupSeq() throws Exception{
		return session.selectOne(namespace+".inspectInfoReadGroupSeq");
	}

	//로그인Hist seq
	@Override
	public long selectLoginNo() throws Exception{
		return session.selectOne(namespace+".selectLoginNo");
	}
	
	//로그인 기록 생성
	@Override
	public void createLoginHist(LogionHistVo logionHistVo) throws Exception{
		session.insert(namespace + ".createLoginHist", logionHistVo);
	}
	
}