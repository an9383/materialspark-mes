package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.MatrlUserVo;

@Repository
public class MatrlUserDAOImpl implements MatrlUserDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.sm.matrlUserMapper";
	//사용자 목록조회
	@Override
	public List<MatrlUserVo> listAll(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectList(namespace + ".listAll", matrlUserVo);
	}
	
	//사용자 목록조회
	@Override
	public List<MatrlUserVo> listAll2(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectList(namespace + ".listAll2", matrlUserVo);
	}
	
	//삭제권한사용자 목록조회
	@Override
	public List<MatrlUserVo> userAuthDeleteListAll_F1F2F3(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectList(namespace + ".userAuthDeleteListAll_F1F2F3", matrlUserVo);
	}
	
	//삭제사용자 체크
	@Override
	public MatrlUserVo userAuthDeleteCheck_F1F2F3(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectOne(namespace + ".userAuthDeleteCheck_F1F2F3", matrlUserVo);
	}
	
	//사용자 상세조회
	@Override
	public MatrlUserVo read(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectOne(namespace + ".read", matrlUserVo);
	}
	
	//사용자 등록
	@Override
	public void create(MatrlUserVo matrlUserVo) throws Exception{
		session.insert(namespace + ".create", matrlUserVo);
	}
	
	//사용자 수정
	@Override
	public void update(MatrlUserVo matrlUserVo) throws Exception{
		session.update(namespace + ".update", matrlUserVo);
	}
	
	//사번 시퀀스
	@Override
	public String selectUserNumberSeq() throws Exception{
		return session.selectOne(namespace + ".selectUserNumberSeq");
	}
	
	//최종검사현황(작업자목록조회 )
	@Override
	public List<MatrlUserVo> finalInspectionWorkerList(MatrlUserVo matrlUserVo) throws Exception{
		return session.selectList(namespace + ".finalInspectionWorkerList", matrlUserVo);
	}
}
