package mes.service.bm;

import java.util.List;
import mes.domain.bm.EquipCondPressureAdmVo;

public interface EquipCondPressureAdmService {
	
	//Bom 압력 전체조회
	public List<EquipCondPressureAdmVo> listAll(EquipCondPressureAdmVo Vo) throws Exception;

	//Bom 압력 Read
	public EquipCondPressureAdmVo read(EquipCondPressureAdmVo Vo) throws Exception;
	
	//Bom 압력 Create
	public void create(EquipCondPressureAdmVo Vo) throws Exception;
	
	//Bom 압력 Update
	public void update(EquipCondPressureAdmVo Vo) throws Exception;
	
	//Bom 압력 sequence 조회
	public String selectPressureSeqCd() throws Exception;
	
}