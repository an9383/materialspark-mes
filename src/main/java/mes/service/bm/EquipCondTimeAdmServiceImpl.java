package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.EquipCondTimeAdmVo;
import mes.domain.bm.EquipCondTimeSixFloorAdmVo;
import mes.persistence.bm.EquipCondTimeAdmDAO;

@Service
public class EquipCondTimeAdmServiceImpl implements EquipCondTimeAdmService {

	@Inject
	private EquipCondTimeAdmDAO dao;

	//Bom 시간 전체조회
	@Override
	public List<EquipCondTimeAdmVo> listAll(EquipCondTimeAdmVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//Bom 시간 Read
	@Override
	public EquipCondTimeAdmVo read(EquipCondTimeAdmVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//Bom 시간 Create
	@Override
	public void create(EquipCondTimeAdmVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//Bom 시간 Update
	@Override
	public void update(EquipCondTimeAdmVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//Bom 시간 sequence 조회
	@Override
	public String selectTimeSeqCd() throws Exception {
		return dao.selectTimeSeqCd();
	}

	
	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 시간 전체조회
	@Override
	public List<EquipCondTimeSixFloorAdmVo> timeSixFloorList(EquipCondTimeSixFloorAdmVo Vo) throws Exception {
		return dao.timeSixFloorList(Vo);
	}

	//Bom 시간 Read
	@Override
	public EquipCondTimeSixFloorAdmVo timeSixFloorRead(EquipCondTimeSixFloorAdmVo Vo) throws Exception {
		return dao.timeSixFloorRead(Vo);
	}
	
	//Bom 시간 Create
	@Override
	public void timeSixFloorCreate(EquipCondTimeSixFloorAdmVo Vo) throws Exception {
		dao.timeSixFloorCreate(Vo);
	}
	
	//Bom 시간 Update
	@Override
	public void timeSixFloorUpdate(EquipCondTimeSixFloorAdmVo Vo) throws Exception {
		dao.timeSixFloorUpdate(Vo);
	}
	
	//Bom 시간 sequence 조회
	@Override
	public String selectTimeSixFloorSeqCd() throws Exception {
		return dao.selectTimeSixFloorSeqCd();
	}
}
