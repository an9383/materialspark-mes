package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.SystemAccessLogVo;

@Repository
public class SystemAccessLogDAOImpl implements SystemAccessLogDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.sm.systemAccessLogMapper";
	//사용자 목록조회
	@Override
	public List<SystemAccessLogVo> systemAccessLogList_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception{
		return session.selectList(namespace + ".systemAccessLogList_F1F2F3", systemAccessLogVo);
	}
	//사용자 등록
	@Override
	public void systemAccessLogCreate_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception{
		session.insert(namespace + ".systemAccessLogCreate_F1F2F3", systemAccessLogVo);
	}
}
