package mes.service.em;

import mes.domain.em.AgtSizeStep;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.EquipCondCombineAdmVo;

public interface EquipCondBomAdmService {
	
	//온도 등록
	public void tempaturCreate(EquipTempaturCondAdm vo) throws Exception;
	
	//시간 등록
	public void timeCreate(EquipCondBomAdmVo vo) throws Exception;
	
	//압력 등록
	public void pressureCreate(EquipCondBomAdmVo vo) throws Exception;
	
	//치수 등록
	public void sizeCreate(EquipCondBomAdmVo vo) throws Exception;
	
	
	
	//특정 온도 읽기
	public EquipTempaturCondAdm tempaturRead(EquipTempaturCondAdm vo) throws Exception;

	//특정 시간 읽기
	public EquipCondBomAdmVo timeRead(EquipCondBomAdmVo vo) throws Exception;

	//특정 압력 읽기
	public EquipCondBomAdmVo pressureRead(EquipCondBomAdmVo vo) throws Exception;
	
	//특정 치수 읽기
	public EquipCondBomAdmVo sizeRead(EquipCondBomAdmVo vo) throws Exception;
	
	//AGT특정 온도 읽기
	public EquipTempaturCondAdm agtTempaturRead(EquipTempaturCondAdm vo) throws Exception;

	//AGT특정 시간 읽기
	public EquipCondBomAdmVo agtTimeRead(EquipCondBomAdmVo vo) throws Exception;

	//AGT특정 압력 읽기
	public EquipCondBomAdmVo agtPressureRead(EquipCondBomAdmVo vo) throws Exception;
	
	//AGT특정 치수 읽기
	public AgtSizeStep agtSizeRead(AgtSizeStep vo) throws Exception;
	
	
	
	
	
	//온도 수정
	public void tempaturUpdate(EquipTempaturCondAdm vo) throws Exception;
	
	//시간 수정
	public void timeUpdate(EquipCondBomAdmVo vo) throws Exception;
	
	//압력 수정
	public void pressureUpdate(EquipCondBomAdmVo vo) throws Exception;
	
	//치수 수정
	public void sizeUpdate(EquipCondBomAdmVo vo) throws Exception;
	
	//특정 제조조건 코드로제조조건(온도,시간,압력,치수) 통합조회
	public EquipCondCombineAdmVo equipCondCombineRead(EquipCondCombineAdmVo equipCondCombineAdmVo) throws Exception;
	
	
	//특정 치수 읽기
	public EquipCondBomAdmVo sizeSixFloorRead(EquipCondBomAdmVo vo) throws Exception;
	
}