package mes.service.sm;

import java.util.List;

import mes.domain.sm.SystemAccessLogVo;

public interface SystemAccessLogService {
	//사용자 목록조회
	public List<SystemAccessLogVo> systemAccessLogList_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception;
	//사용자 등록
	public void systemAccessLogCreate_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception;
}
