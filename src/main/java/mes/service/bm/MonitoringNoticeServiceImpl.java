package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import mes.domain.bm.MonitoringNoticeVo;
import mes.persistence.bm.MonitoringNoticeDAO;

@Service
public class MonitoringNoticeServiceImpl implements MonitoringNoticeService {

	@Inject
	private MonitoringNoticeDAO dao;

	//모니터링 공지사항 조회
	@Override
	public List<MonitoringNoticeVo> monitoringNoticeList(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		return dao.monitoringNoticeList(monitoringNoticeVo);
	}
	
	//모니터링 공지사항 조회
	@Override
	public MonitoringNoticeVo monitoringNoticeRead(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		return dao.monitoringNoticeRead(monitoringNoticeVo);
	}
	
	//모니터링 공지사항 등록
	@Override
	public void monitoringNoticeCreate(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		dao.monitoringNoticeCreate(monitoringNoticeVo);
	}
	
	//모니터링 공지사항 수정
	@Override
	public void monitoringNoticeUpdate(MonitoringNoticeVo monitoringNoticeVo) throws Exception{
		dao.monitoringNoticeUpdate(monitoringNoticeVo);
	}
	
	//모니터링 공지사항 시퀀스 조회
	@Override
	public int monitoringNoticeSelectIdx() throws Exception{
		return dao.monitoringNoticeSelectIdx();
	}
}

	