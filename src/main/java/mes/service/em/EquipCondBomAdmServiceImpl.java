package mes.service.em;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.em.AgtSizeStep;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.EquipCondCombineAdmVo;
import mes.persistence.em.EquipCondBomAdmDAO;

@Service
public class EquipCondBomAdmServiceImpl implements EquipCondBomAdmService {

	@Inject
	private EquipCondBomAdmDAO dao;
	
	//온도 등록
	@Override
	public void tempaturCreate(EquipTempaturCondAdm vo) throws Exception {
		dao.tempaturCreate(vo);
	}
	
	//시간 등록
	@Override
	public void timeCreate(EquipCondBomAdmVo vo) throws Exception {
		dao.timeCreate(vo);
	}
	
	//압력 등록
	@Override
	public void pressureCreate(EquipCondBomAdmVo vo) throws Exception {
		dao.pressureCreate(vo);
	}
	
	//치수 등록
	@Override
	public void sizeCreate(EquipCondBomAdmVo vo) throws Exception {
		dao.sizeCreate(vo);
	}
	
	
	
	
	//특정 온도 읽기
	@Override
	public EquipTempaturCondAdm tempaturRead(EquipTempaturCondAdm vo) throws Exception {
		return dao.tempaturRead(vo);
	}
	
	//특정 시간 읽기
	@Override
	public EquipCondBomAdmVo timeRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.timeRead(vo);
	}
	
	//특정 압력 읽기
	@Override
	public EquipCondBomAdmVo pressureRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.pressureRead(vo);
	}
	
	//특정 수치 읽기
	@Override
	public EquipCondBomAdmVo sizeRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.sizeRead(vo);
	}
	
	//AGT특정 온도 읽기
	@Override
	public EquipTempaturCondAdm agtTempaturRead(EquipTempaturCondAdm vo) throws Exception {
		return dao.agtTempaturRead(vo);
	}
	
	//AGT특정 시간 읽기
	@Override
	public EquipCondBomAdmVo agtTimeRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.agtTimeRead(vo);
	}
	
	//AGT특정 압력 읽기
	@Override
	public EquipCondBomAdmVo agtPressureRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.agtPressureRead(vo);
	}
	
	//AGT특정 수치 읽기
	@Override
	public AgtSizeStep agtSizeRead(AgtSizeStep vo) throws Exception {
		return dao.agtSizeRead(vo);
	}
	
	
	
	//온도 수정
	@Override
	public void tempaturUpdate(EquipTempaturCondAdm vo) throws Exception {
		dao.tempaturUpdate(vo);
	}
	
	//시간 수정
	@Override
	public void timeUpdate(EquipCondBomAdmVo vo) throws Exception {
		dao.timeUpdate(vo);
	}
	
	//압력 수정
	@Override
	public void pressureUpdate(EquipCondBomAdmVo vo) throws Exception {
		dao.pressureUpdate(vo);
	}
	
	//치수 수정
	@Override
	public void sizeUpdate(EquipCondBomAdmVo vo) throws Exception {
		dao.sizeUpdate(vo);
	}
	
	//특정 제조조건 코드로제조조건(온도,시간,압력,치수) 통합조회
	@Override
	public EquipCondCombineAdmVo equipCondCombineRead(EquipCondCombineAdmVo equipCondCombineAdmVo) throws Exception {
		return dao.equipCondCombineRead(equipCondCombineAdmVo);
	}
	
	/*
	 * //
	 * 
	 * @Overrided public List<ManufacturerVo> listAll(ManufacturerVo vo) throws
	 * Exception { return dao.listAll(vo); }
	 * 
	 * //
	 * 
	 * @Override public ManufacturerVo read(ManufacturerVo vo) throws Exception {
	 * return dao.read(vo); }
	 * 
	 * //
	 * 
	 * @Override public void update(ManufacturerVo vo) throws Exception {
	 * dao.update(vo); }
	 */
	
	//
	//@Override
	//public String selectDealCorpSeqCd() throws Exception {
	//	return dao.selectDealCorpSeqCd();
	//}
	
	
	//특정 치수 조건 읽기
	@Override
	public EquipCondBomAdmVo sizeSixFloorRead(EquipCondBomAdmVo vo) throws Exception {
		return dao.sizeSixFloorRead(vo);
	}
}

	