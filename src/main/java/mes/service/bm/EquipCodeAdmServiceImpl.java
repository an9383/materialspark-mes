package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.EquipCodeAdmVo;
import mes.persistence.bm.EquipCodeAdmDAO;

@Service
public class EquipCodeAdmServiceImpl implements EquipCodeAdmService {

	@Inject
	private EquipCodeAdmDAO dao;
	
	//설비코드 전체조회
	@Override
	public List<EquipCodeAdmVo> listAll(EquipCodeAdmVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//설비코드 특정 Read
	@Override
	public EquipCodeAdmVo read(EquipCodeAdmVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//설비코드/코드명 중복체크
	@Override
	public String equipCdNmCheck(EquipCodeAdmVo Vo) throws Exception {
		return dao.equipCdNmCheck(Vo);
	}
	
	//설비코드 Create
	@Override
	public void create(EquipCodeAdmVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//설비코드 Update
	@Override
	public void update(EquipCodeAdmVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//설비코드별 작지 조회(비전수집용)
	@Override
	public List<EquipCodeAdmVo> visionDataListAll(EquipCodeAdmVo Vo) throws Exception{
		return dao.visionDataListAll(Vo);
	}
	
	//설비코드 듀얼 합 조회 (SLD)
	public List<EquipCodeAdmVo> listEquipSLD(EquipCodeAdmVo Vo) throws Exception{
		return dao.listEquipSLD(Vo);
	}
	
	//설비코드 듀얼 합 조회 (MTP)
	public List<EquipCodeAdmVo> listEquipMTP(EquipCodeAdmVo Vo) throws Exception{
		return dao.listEquipMTP(Vo);
	}
		
	//설비코드 듀얼 합 조회 (MTP2)
	public List<EquipCodeAdmVo> listEquipMTP2(EquipCodeAdmVo Vo) throws Exception{
		return dao.listEquipMTP2(Vo);
	}
	
	
}
