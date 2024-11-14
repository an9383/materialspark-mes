package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.EquipCondTimeAdmVo;
import mes.domain.bm.EquipCondTimeSixFloorAdmVo;

public interface EquipCondTimeAdmDAO {

	//Bom 시간 전체조회
	public List<EquipCondTimeAdmVo> listAll(EquipCondTimeAdmVo Vo) throws Exception;
	
	//Bom 시간 Read
	public EquipCondTimeAdmVo read(EquipCondTimeAdmVo Vo) throws Exception;
	
	//Bom 시간 Create
	public void create(EquipCondTimeAdmVo Vo) throws Exception;
	
	//Bom 시간 Update
	public void update(EquipCondTimeAdmVo Vo) throws Exception;
	
	//Bom 시간 sequence 조회
	public String selectTimeSeqCd() throws Exception;
	
	
	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 시간 전체조회
	public List<EquipCondTimeSixFloorAdmVo> timeSixFloorList(EquipCondTimeSixFloorAdmVo Vo) throws Exception;
	
	//Bom 시간 Read
	public EquipCondTimeSixFloorAdmVo timeSixFloorRead(EquipCondTimeSixFloorAdmVo Vo) throws Exception;
	
	//Bom 시간 Create
	public void timeSixFloorCreate(EquipCondTimeSixFloorAdmVo Vo) throws Exception;
	
	//Bom 시간 Update
	public void timeSixFloorUpdate(EquipCondTimeSixFloorAdmVo Vo) throws Exception;
	
	//Bom 시간 sequence 조회
	public String selectTimeSixFloorSeqCd() throws Exception;
	
}
