package mes.persistence.po;

import java.util.List;
import mes.domain.po.EquipSizeCondStepVo;

public interface EquipSizeCondStepDAO {

	//초중종물 검색
	public EquipSizeCondStepVo readEquipSizeCondStep(EquipSizeCondStepVo vo) throws Exception;
	
	//초,중,종물 입력 확인
	public EquipSizeCondStepVo readEquipSizeCondStepCount(EquipSizeCondStepVo vo) throws Exception;	
	
	//초중종물 등록
	public void insertEquipSizeCondStep(EquipSizeCondStepVo vo) throws Exception;
	
	//초중종물 수정
	public void updateEquipSizeCondStep(EquipSizeCondStepVo vo)  throws Exception;
	
	//초중종물 수정-(초,중)
	public void updateAgtSizeCondStep_F1(EquipSizeCondStepVo vo)  throws Exception;

	//초,중,종물 WP(좌)+PP폭(좌) 평균
	public List<EquipSizeCondStepVo> stepAverage(EquipSizeCondStepVo vo) throws Exception;
	
}