package mes.persistence.em;

import java.util.List;

import mes.domain.em.EquipPrdcInspctAdmVo;

public interface EquipPrdcInspctAdmDAO {

	//정기검사관리 목록 조회
	public List<EquipPrdcInspctAdmVo> listAll(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception;
	
	//정기검사관리 등록
	public void create(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception;
	
	//정기검사관리 삭제
	public void delete(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception;
	
	//정기검사관리 상세
	public EquipPrdcInspctAdmVo read(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception;
	
}
