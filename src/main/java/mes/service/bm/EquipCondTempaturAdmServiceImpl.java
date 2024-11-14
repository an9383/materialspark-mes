package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.EquipCondTempaturAdmVo;
import mes.domain.bm.EquipCondTempaturSixFloorAdmVo;
import mes.persistence.bm.EquipCondTempaturAdmDAO;

@Service
public class EquipCondTempaturAdmServiceImpl implements EquipCondTempaturAdmService {

	@Inject
	private EquipCondTempaturAdmDAO dao;

	//Bom 온도 전체조회
	@Override
	public List<EquipCondTempaturAdmVo> listAll(EquipCondTempaturAdmVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//Bom 온도 Read
	@Override
	public EquipCondTempaturAdmVo read(EquipCondTempaturAdmVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//Bom 온도 Create
	@Override
	public void create(EquipCondTempaturAdmVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//Bom 온도 Update
	@Override
	public void update(EquipCondTempaturAdmVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//Bom 온도 sequence 조회
	@Override
	public String selectTempaturSeqCd() throws Exception {
		return dao.selectTempaturSeqCd();
	}

	
	
	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 온도 전체조회
	@Override
	public List<EquipCondTempaturSixFloorAdmVo> tempaturSixFloorList(EquipCondTempaturSixFloorAdmVo Vo) throws Exception {
		return dao.tempaturSixFloorList(Vo);
	}

	//Bom 온도 Read
	@Override
	public EquipCondTempaturSixFloorAdmVo tempaturSixFloorRead(EquipCondTempaturSixFloorAdmVo Vo) throws Exception {
		return dao.tempaturSixFloorRead(Vo);
	}
	
	//Bom 온도 Create
	@Override
	public void tempaturSixFloorCreate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception {
		dao.tempaturSixFloorCreate(Vo);
	}
	
	//Bom 온도 Update
	@Override
	public void tempaturSixFloorUpdate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception {
		dao.tempaturSixFloorUpdate(Vo);
	}
	
	//Bom 온도 sequence 조회
	@Override
	public String selectTempaturSixFloorSeqCd() throws Exception {
		return dao.selectTempaturSixFloorSeqCd();
	}
}
