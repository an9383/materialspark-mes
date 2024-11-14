package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.SystemLogAdmVo;
import mes.persistence.sm.SystemLogAdmDAO;

@Service
public class SystemLogAdmServiceImpl implements SystemLogAdmService{
	
	@Inject
	private SystemLogAdmDAO dao;
	
	//시스템로그관리 - 로그인기록관리 목록조회
	@Override
	public List<SystemLogAdmVo> systemLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception {
	    return dao.systemLogAdmList(systemLogAdmVo);
	}
	
	//시스템로그관리 - 페이지접속기록관리 목록조회
	@Override
	public List<SystemLogAdmVo> pageLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception {
		return dao.pageLogAdmList(systemLogAdmVo);
	}
	
}
