package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.EquipCondTempaturAdmVo;
import mes.domain.bm.EquipCondTempaturSixFloorAdmVo;

public interface EquipCondTempaturAdmDAO {

	//Bom 온도 전체조회
	public List<EquipCondTempaturAdmVo> listAll(EquipCondTempaturAdmVo Vo) throws Exception;
	
	//Bom 온도 Read
	public EquipCondTempaturAdmVo read(EquipCondTempaturAdmVo Vo) throws Exception;
	
	//Bom 온도 Create
	public void create(EquipCondTempaturAdmVo Vo) throws Exception;
	
	//Bom 온도 Update
	public void update(EquipCondTempaturAdmVo Vo) throws Exception;
	
	//Bom 온도 sequence 조회
	public String selectTempaturSeqCd() throws Exception;
	
	
	
	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 온도 전체조회
	public List<EquipCondTempaturSixFloorAdmVo> tempaturSixFloorList(EquipCondTempaturSixFloorAdmVo Vo) throws Exception;
	
	//Bom 온도 Read
	public EquipCondTempaturSixFloorAdmVo tempaturSixFloorRead(EquipCondTempaturSixFloorAdmVo Vo) throws Exception;
	
	//Bom 온도 Create
	public void tempaturSixFloorCreate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception;
	
	//Bom 온도 Update
	public void tempaturSixFloorUpdate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception;
	
	//Bom 온도 sequence 조회
	public String selectTempaturSixFloorSeqCd() throws Exception;
	
}
