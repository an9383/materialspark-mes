package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.StateVo;
import mes.persistence.qm.StateDAO;

@Service
public class StateServiceImpl implements StateService {

	@Inject
	private StateDAO dao;

	//초중종물 검사현황 목로조회
	@Override
	public List<StateVo> stateList(StateVo stateVo) throws Exception {
		return dao.stateList(stateVo);
	}
	
	//초중종물 검사현황 목로조회
	@Override
	public List<StateVo> stateListF3(StateVo stateVo) throws Exception{
		return dao.stateListF3(stateVo);
	}
}
