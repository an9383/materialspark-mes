package mes.service.po;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.po.EquipSizeCondStepVo;
import mes.persistence.po.EquipSizeCondStepDAO;

@Service
public class EquipSizeCondStepServiceImpl implements EquipSizeCondStepService {

	@Inject
	private EquipSizeCondStepDAO dao;
	
	//초중종물 검색
	@Override
	public EquipSizeCondStepVo readEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception {
		return dao.readEquipSizeCondStep(Vo);
	}
	
	//초,중,종물 입력 확인
	@Override
	public EquipSizeCondStepVo readEquipSizeCondStepCount(EquipSizeCondStepVo Vo) throws Exception {
		return dao.readEquipSizeCondStepCount(Vo);
	}
	
	//초중종물 등록
	@Override
	public void insertEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception {
		dao.insertEquipSizeCondStep(Vo);
	}
	
	//초중종물 수정
	@Override
	public void updateEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception {
		dao.updateEquipSizeCondStep(Vo);
	}

	//초중종물 수정-(초,중)
	@Override
	public void updateAgtSizeCondStep_F1(EquipSizeCondStepVo Vo) throws Exception {
		dao.updateAgtSizeCondStep_F1(Vo);
	}
		
	//초,중,종물 WP(좌)+PP폭(좌) 평균
	@Override
	public List<EquipSizeCondStepVo> stepAverage(EquipSizeCondStepVo Vo) throws Exception {
		return dao.stepAverage(Vo);
	}
	
}	