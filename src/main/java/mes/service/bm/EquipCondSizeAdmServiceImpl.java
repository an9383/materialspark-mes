package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.EquipCondSizeAdmVo;
import mes.persistence.bm.EquipCondSizeAdmDAO;

@Service
public class EquipCondSizeAdmServiceImpl implements EquipCondSizeAdmService {

	@Inject
	private EquipCondSizeAdmDAO dao;

	//Bom 치수 전체조회
	@Override
	public List<EquipCondSizeAdmVo> listAll(EquipCondSizeAdmVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//Bom 치수 Read
	@Override
	public EquipCondSizeAdmVo read(EquipCondSizeAdmVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//Bom 치수 Create
	@Override
	public void create(EquipCondSizeAdmVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//Bom 치수 Update
	@Override
	public void update(EquipCondSizeAdmVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//Bom 치수 sequence 조회
	@Override
	public String selectSizeSeqCd() throws Exception {
		return dao.selectSizeSeqCd();
	}
	
	
	
	//6층 온도 정보(Bom온도조건관리)
	
	//Bom 치수 전체조회
	@Override
	public List<EquipCondSizeAdmVo> sizeSixFloorList(EquipCondSizeAdmVo Vo) throws Exception {
		return dao.sizeSixFloorList(Vo);
	}

	//Bom 치수 Read
	@Override
	public EquipCondSizeAdmVo sizeSixFloorRead(EquipCondSizeAdmVo Vo) throws Exception {
		return dao.sizeSixFloorRead(Vo);
	}
	
	//Bom 치수 Create
	@Override
	public void sizeSixFloorCeate(EquipCondSizeAdmVo Vo) throws Exception {
		dao.sizeSixFloorCeate(Vo);
	}
	
	//Bom 치수 Update
	@Override
	public void sizeSixFloorUpdate(EquipCondSizeAdmVo Vo) throws Exception {
		dao.sizeSixFloorUpdate(Vo);
	}
	
	//Bom 치수 sequence 조회
	@Override
	public String selectSizeSixFloorSeqCd() throws Exception {
		return dao.selectSizeSixFloorSeqCd();
	}
	
}