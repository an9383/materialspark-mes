package mes.service.sm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.sm.MatrlUserVo;
import mes.persistence.sm.MatrlUserDAO;

@Service
public class MatrlUserServiceImpl implements MatrlUserService{
	
	@Inject
	private MatrlUserDAO dao;
	
	//사용자 목록조회
	@Override
	public List<MatrlUserVo> listAll(MatrlUserVo matrlUserVo) throws Exception{
		return dao.listAll(matrlUserVo);
	}
	
	//사용자 목록조회
	@Override
	public List<MatrlUserVo> listAll2(MatrlUserVo matrlUserVo) throws Exception{
		return dao.listAll2(matrlUserVo);
	}
	
	//삭제사용자 목록조회
	@Override
	public List<MatrlUserVo> userAuthDeleteListAll_F1F2F3(MatrlUserVo matrlUserVo) throws Exception{
		return dao.userAuthDeleteListAll_F1F2F3(matrlUserVo);
	}
	
	//삭제사용자 체크
	@Override
	public MatrlUserVo userAuthDeleteCheck_F1F2F3(MatrlUserVo matrlUserVo) throws Exception{
		return dao.userAuthDeleteCheck_F1F2F3(matrlUserVo);
	}
	
	//사용자 상세조회
	@Override
	public MatrlUserVo read(MatrlUserVo matrlUserVo) throws Exception{
		return dao.read(matrlUserVo);
	}
	
	//사용자 등록
	@Override
	public void create(MatrlUserVo matrlUserVo) throws Exception{
		dao.create(matrlUserVo);
	}				
	
	//사용자 수정
	@Override
	public void update(MatrlUserVo matrlUserVo) throws Exception{
		dao.update(matrlUserVo);
	}
	
	@Override
	//사번 시퀀스
	public String selectUserNumberSeq() throws Exception{
		return dao.selectUserNumberSeq();
	}
	
	//최종검사현황(작업자목록조회 )
	@Override
	public List<MatrlUserVo> finalInspectionWorkerList(MatrlUserVo matrlUserVo) throws Exception{
		return dao.finalInspectionWorkerList(matrlUserVo);
	}
	
}
