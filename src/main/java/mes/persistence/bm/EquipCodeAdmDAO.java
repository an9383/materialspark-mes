package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.EquipCodeAdmVo;

public interface EquipCodeAdmDAO {
	
	//설비코드 전체조회
	public List<EquipCodeAdmVo> listAll(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드 특정 Read
	public EquipCodeAdmVo read(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드/코드명 중복 체크
	public String equipCdNmCheck(EquipCodeAdmVo Vo) throws Exception;

	//설비코드 Create
	public void create(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드 Update
	public void update(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드별 작지 조회(비전수집용)
	public List<EquipCodeAdmVo> visionDataListAll(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드 듀얼 합 조회 (SLD)
	public List<EquipCodeAdmVo> listEquipSLD(EquipCodeAdmVo Vo) throws Exception;
	
	//설비코드 듀얼 합 조회 (MTP)
	public List<EquipCodeAdmVo> listEquipMTP(EquipCodeAdmVo Vo) throws Exception;
		
	//설비코드 듀얼 합 조회 (MTP2)
	public List<EquipCodeAdmVo> listEquipMTP2(EquipCodeAdmVo Vo) throws Exception;
	
	
}