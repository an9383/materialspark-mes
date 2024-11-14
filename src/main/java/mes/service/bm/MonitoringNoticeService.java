package mes.service.bm;

import java.util.List;

import mes.domain.bm.MonitoringNoticeVo;

public interface MonitoringNoticeService {
	
	//모니터링 공지사항 조회
	public List<MonitoringNoticeVo> monitoringNoticeList(MonitoringNoticeVo monitoringNoticeVo) throws Exception;
	
	//모니터링 공지사항 조회
	public MonitoringNoticeVo monitoringNoticeRead(MonitoringNoticeVo monitoringNoticeVo) throws Exception;
	
	//모니터링 공지사항 등록
	public void monitoringNoticeCreate(MonitoringNoticeVo monitoringNoticeVo) throws Exception;
	
	//모니터링 공지사항 수정
	public void monitoringNoticeUpdate(MonitoringNoticeVo monitoringNoticeVo) throws Exception;
	
	//모니터링 공지사항 시퀀스 조회
	public int monitoringNoticeSelectIdx() throws Exception;	
	
}