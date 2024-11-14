package mes.service.qm;

import java.util.List;

import mes.domain.qm.StateVo;

public interface StateService {
	
	//초중종물 검사현황 목로조회
	public List<StateVo> stateList(StateVo stateVo) throws Exception;
	
	//초중종물 검사현황 목로조회
	public List<StateVo> stateListF3(StateVo stateVo) throws Exception;

}