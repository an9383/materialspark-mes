package mes.service.em;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.em.EquipPrdcInspctAdmVo;
import mes.persistence.em.EquipPrdcInspctAdmDAO;

@Service
public class EquipPrdcInspctAdmServiceImpl implements EquipPrdcInspctAdmService {

	@Inject
	private EquipPrdcInspctAdmDAO dao;

	//정기검사관리 목록 조회
	@Override
	public List<EquipPrdcInspctAdmVo> listAll(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		return dao.listAll(equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 등록
	@Override
	public void create(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		dao.create(equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 삭제
	@Override
	public void delete(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		dao.delete(equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 상세
	@Override
	public EquipPrdcInspctAdmVo read(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		return dao.read(equipPrdcInspctAdmVo);
	}
}

	