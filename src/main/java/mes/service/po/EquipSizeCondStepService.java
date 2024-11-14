package mes.service.po;

import java.util.List;
import mes.domain.po.EquipSizeCondStepVo;

public interface EquipSizeCondStepService {
	
	//초중종물 검색
	public EquipSizeCondStepVo readEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception;
	
	//초,중,종물 입력 확인
	public EquipSizeCondStepVo readEquipSizeCondStepCount(EquipSizeCondStepVo Vo) throws Exception;
	
	//초중종물 등록
	public void insertEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception;
	
	//초중종물 수정
	public void updateEquipSizeCondStep(EquipSizeCondStepVo Vo) throws Exception;
	
	//초중종물 수정-(초,중)
	public void updateAgtSizeCondStep_F1(EquipSizeCondStepVo vo)  throws Exception;
	
	//초,중,종물 WP(좌)+PP폭(좌) 평균
	public List<EquipSizeCondStepVo> stepAverage(EquipSizeCondStepVo Vo) throws Exception;
	
}