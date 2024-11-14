package mes.persistence.em;

import java.util.List;

import mes.domain.em.EquipRepairHistAdmVo;

public interface EquipRepairHistAdmDAO {
	
	//전체 리스트
	public List<EquipRepairHistAdmVo> listAll(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
		
	//설비 등록
	public void create(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//설비 읽기
	public EquipRepairHistAdmVo read(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;

	//설비 수정
	public void update(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
	
	//등록번호 시퀀스
	public String seq() throws Exception;
	
	//등록일자 시퀀스
	public String regSeq(String time) throws Exception;
	
	//memsInfo_조회
	public List<EquipRepairHistAdmVo> memsInfoList(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception;
		
}
