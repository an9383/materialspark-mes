package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.EquipCondPressureAdmVo;
import mes.persistence.bm.EquipCondPressureAdmDAO;

@Service
public class EquipCondPressureAdmServiceImpl implements EquipCondPressureAdmService {

	@Inject
	private EquipCondPressureAdmDAO dao;

	//Bom 압력 전체조회
	@Override
	public List<EquipCondPressureAdmVo> listAll(EquipCondPressureAdmVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//Bom 압력 Read
	@Override
	public EquipCondPressureAdmVo read(EquipCondPressureAdmVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//Bom 압력 Create
	@Override
	public void create(EquipCondPressureAdmVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//Bom 압력 Update
	@Override
	public void update(EquipCondPressureAdmVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//Bom 압력 sequence 조회
	@Override
	public String selectPressureSeqCd() throws Exception {
		return dao.selectPressureSeqCd();
	}
	
}