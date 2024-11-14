package mes.service.em;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.em.EquipRepairHistAdmVo;
import mes.persistence.em.EquipRepairHistAdmDAO;

@Service
public class EquipRepairHistAdmServiceImpl implements EquipRepairHistAdmService {

	@Inject
	private EquipRepairHistAdmDAO dao;
	
	//전체 리스트
	@Override
	public List<EquipRepairHistAdmVo> listAll(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception{
		return dao.listAll(equipRepairHistAdmVo);
	}
		
	//설비 등록
	@Override
	public void create(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception{
		dao.create(equipRepairHistAdmVo);
	}
	
	//설비 읽기
	@Override
	public EquipRepairHistAdmVo read(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception{
		return dao.read(equipRepairHistAdmVo);
	}

	//설비 수정
	@Override
	public void update(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception{
		dao.update(equipRepairHistAdmVo);
	}

	//등록번호 시퀀스
	@Override
	public String seq() throws Exception{
		return dao.seq();
	}
	
	//등록일자 시퀀스
	@Override
	public String regSeq(String time) throws Exception{
		return dao.regSeq(time);
	}
	
	//memsInfo_조회
	@Override
	public List<EquipRepairHistAdmVo> memsInfoList(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception{
		return dao.memsInfoList(equipRepairHistAdmVo);
	}
}

	