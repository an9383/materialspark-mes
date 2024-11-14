package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.SystemLogAdmVo;


@Repository
public class SystemLogAdmDAOImpl implements SystemLogAdmDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.sm.systemLogAdmMapper";
	
	//시스템로그관리 - 로그인기록관리 목록조회
	@Override
	public List<SystemLogAdmVo> systemLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception {
	    return session.selectList(namespace + ".systemLogAdmList", systemLogAdmVo);
	}
	
	//시스템로그관리 - 페이지접속기록관리 목록조회
	@Override
	public List<SystemLogAdmVo> pageLogAdmList(SystemLogAdmVo systemLogAdmVo) throws Exception {
		return session.selectList(namespace + ".pageLogAdmList", systemLogAdmVo);
	}
	
}
