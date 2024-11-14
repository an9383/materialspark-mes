package mes.service.sm;

import java.util.List;

import mes.domain.sm.SystemLogAdmVo;

public interface SystemLogAdmService {
	
	//시스템로그관리 - 로그인기록관리 목록조회
	public List<SystemLogAdmVo> systemLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception;
	
	//시스템로그관리 - 페이지접속기록관리 목록조회
	public List<SystemLogAdmVo> pageLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception;
	
}
