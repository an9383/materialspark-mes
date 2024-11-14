package mes.persistence.po;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.po.EquipSizeCondStepVo;

@Repository
public class EquipSizeCondStepDAOImpl implements EquipSizeCondStepDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.po.equipSizeCondStepMapper";

	//초중종물 검색
	@Override
	public EquipSizeCondStepVo readEquipSizeCondStep(EquipSizeCondStepVo vo) throws Exception {
		return session.selectOne(namespace + ".readEquipSizeCondStep", vo);
	}
	
	//초,중,종물 입력 확인
	@Override
	public EquipSizeCondStepVo readEquipSizeCondStepCount(EquipSizeCondStepVo vo) throws Exception {
		return session.selectOne(namespace + ".readEquipSizeCondStepCount", vo);
	}
	
	//초중종물 등록
	@Override
	public void insertEquipSizeCondStep(EquipSizeCondStepVo vo) throws Exception {
		session.selectOne(namespace + ".insertEquipSizeCondStep", vo);
	}
	
	//초중종물 수정
	@Override
	public void updateEquipSizeCondStep(EquipSizeCondStepVo vo) throws Exception {
		session.selectOne(namespace + ".updateEquipSizeCondStep", vo);
	}
	
	//초중종물 수정-(초,중)
	@Override
	public void updateAgtSizeCondStep_F1(EquipSizeCondStepVo vo) throws Exception {
		session.selectOne(namespace + ".updateAgtSizeCondStep_F1", vo);
	}
		
	//초,중,종물 WP(좌)+PP폭(좌) 평균
	@Override
	public List<EquipSizeCondStepVo> stepAverage(EquipSizeCondStepVo vo) throws Exception {
		return session.selectList(namespace + ".stepAverage", vo);
	}
	
}