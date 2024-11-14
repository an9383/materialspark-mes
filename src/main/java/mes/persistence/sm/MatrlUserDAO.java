package mes.persistence.sm;

import java.util.List;

import mes.domain.sm.MatrlUserVo;

public interface MatrlUserDAO {
	
	//사용자 목록조회
	public List<MatrlUserVo> listAll(MatrlUserVo matrlUserVo) throws Exception;
	
	//사용자 목록조회
	public List<MatrlUserVo> listAll2(MatrlUserVo matrlUserVo) throws Exception;
	
	//삭제사용자 목록조회
	public List<MatrlUserVo> userAuthDeleteListAll_F1F2F3(MatrlUserVo matrlUserVo) throws Exception;
	
	//삭제사용자 체크
	public MatrlUserVo userAuthDeleteCheck_F1F2F3(MatrlUserVo matrlUserVo) throws Exception;
	
	//사용자 상세조회
	public MatrlUserVo read(MatrlUserVo matrlUserVo) throws Exception;
	
	//사용자 등록
	public void create(MatrlUserVo matrlUserVo) throws Exception;
	
	//사용자 수정
	public void update(MatrlUserVo matrlUserVo) throws Exception;
	
	//사번 시퀀스
	public String selectUserNumberSeq() throws Exception;
	
	//최종검사현황(작업자목록조회 )
	public List<MatrlUserVo> finalInspectionWorkerList(MatrlUserVo matrlUserVo) throws Exception;
}
