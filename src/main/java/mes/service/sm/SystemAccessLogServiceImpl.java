package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.SystemAccessLogVo;
import mes.persistence.sm.SystemAccessLogDAO;

@Service
public class SystemAccessLogServiceImpl implements SystemAccessLogService{
	
	@Inject
	private SystemAccessLogDAO dao;
	
	//사용자 목록조회
	@Override
	public List<SystemAccessLogVo> systemAccessLogList_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception{
		return dao.systemAccessLogList_F1F2F3(systemAccessLogVo);
	}
	//사용자 등록
	@Override
	public void systemAccessLogCreate_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception{
		dao.systemAccessLogCreate_F1F2F3(systemAccessLogVo);
	}
	
}
