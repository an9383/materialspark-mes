package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.SystemAccessLogVo;

public interface SystemAccessLogDAO {
	
	//시스템로그 조회
	public List<SystemAccessLogVo> systemAccessLogList_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception;
	
	//시스템로그 등록
	public void systemAccessLogCreate_F1F2F3(SystemAccessLogVo systemAccessLogVo) throws Exception;
}
