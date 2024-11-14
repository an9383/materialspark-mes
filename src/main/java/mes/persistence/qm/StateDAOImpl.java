package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.StateVo;

@Repository
public class StateDAOImpl implements StateDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.stateMapper";
	
	//초중종물 검사현황 목로조회
	@Override
	public List<StateVo> stateList(StateVo stateVo) throws Exception{
		return session.selectList(namespace+".stateList", stateVo);
	}
	
	//초중종물 검사현황 목로조회
	@Override
	public List<StateVo> stateListF3(StateVo stateVo) throws Exception{
		return session.selectList(namespace+".stateListF3", stateVo);
	}
	
}