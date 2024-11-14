package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.EquipCondSizeAdmVo;

public interface EquipCondSizeAdmDAO {

	//Bom 치수 전체조회
	public List<EquipCondSizeAdmVo> listAll(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Read
	public EquipCondSizeAdmVo read(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Create
	public void create(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Update
	public void update(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 sequence 조회
	public String selectSizeSeqCd() throws Exception;
	
	
	
	//6층 온도 정보(Bom온도조건관리)
	
	//Bom 치수 전체조회
	public List<EquipCondSizeAdmVo> sizeSixFloorList(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Read
	public EquipCondSizeAdmVo sizeSixFloorRead(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Create
	public void sizeSixFloorCeate(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 Update
	public void sizeSixFloorUpdate(EquipCondSizeAdmVo Vo) throws Exception;
	
	//Bom 치수 sequence 조회
	public String selectSizeSixFloorSeqCd() throws Exception;
	
}
