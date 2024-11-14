package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.MonitoringNoticeVo;

@Repository
public class MonitoringNoticeDAOImpl implements MonitoringNoticeDAO {
	
	@Inject
	private SqlSession session;
	private static String namespace = "mes.mappers.bm.monitoringNoticeMapper";

	//모니터링 공지사항 조회
	@Override
	public List<MonitoringNoticeVo> monitoringNoticeList(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		return session.selectList(namespace+".monitoringNoticeList", monitoringNoticeVo);
	}
	
	//모니터링 공지사항 조회
	@Override
	public MonitoringNoticeVo monitoringNoticeRead(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		return session.selectOne(namespace+".monitoringNoticeRead", monitoringNoticeVo);
	}
	
	//모니터링 공지사항 등록
	@Override
	public void monitoringNoticeCreate(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		session.insert(namespace+".monitoringNoticeCreate", monitoringNoticeVo);
	}
	
	//모니터링 공지사항 수정
	@Override
	public void monitoringNoticeUpdate(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		session.update(namespace+".monitoringNoticeUpdate", monitoringNoticeVo);
	}
	
	//모니터링 공지사항 시퀀스 조회
	@Override
	public int monitoringNoticeSelectIdx() throws Exception{
		return session.selectOne(namespace+".monitoringNoticeSelectIdx");
	}
	
}