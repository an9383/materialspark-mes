package mes.service.em;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.em.ManufacturerVo;
import mes.domain.em.EquipCondCommonAdmVo;
import mes.persistence.em.ManufacturerDAO;

@Service
public class ManufacturerServiceImpl implements ManufacturerService {

	@Inject
	private ManufacturerDAO dao;

	//제조조건관리 설비 클릭시 계획 목록 조회
	@Override
	public List<ManufacturerVo> listAll(ManufacturerVo vo) throws Exception {
		return dao.listAll(vo);
	}

	//해당설비 계획 목록 조회
	@Override
	public List<ManufacturerVo> listRead(EquipCondCommonAdmVo vo) throws Exception {
		return dao.listRead(vo);	
	}
	
	//제품코드 조회 팝업의 목록에서 특정 제품 클릭 시 제품코드에 대한 재질,규격,두께등을 가져옴
	@Override
	public ManufacturerVo read(ManufacturerVo vo) throws Exception {
		return dao.read(vo);	
	}

	//특정 설비 계획 생성
	@Override
	public void equipCondCommonAdmcreate(EquipCondCommonAdmVo vo) throws Exception {
		dao.equipCondCommonAdmcreate(vo);
	}
	
	//
	/*
	 * @Override public void update(ManufacturerVo vo) throws Exception {
	 * dao.update(vo); }
	 */
	//설비코드 시퀀스
	@Override
	public String selectEquipCondSeq() throws Exception {
		return dao.selectEquipCondSeq();
	}
	
	//제조조건 fp사용, 메인구분, 수정
	@Override
	public void equipCondCommonAdmUpdate(EquipCondCommonAdmVo vo) throws Exception{
		dao.equipCondCommonAdmUpdate(vo);
	}
	
	//제조조건 FP 메인구분 전체삭제
	@Override
	public void deleteFpMainGubun(EquipCondCommonAdmVo vo) throws Exception{
		dao.deleteFpMainGubun(vo);
	}
	
	
	
	//4Line 설비조건공통관리 생성
	@Override
	public void equipCondCommonSixFloorAdmCreate(EquipCondCommonAdmVo vo) throws Exception {
		dao.equipCondCommonSixFloorAdmCreate(vo);
	}
	
	//4Line 설비코드 시퀀스
	@Override
	public String selectEquipCondSixFloorSeq() throws Exception {
		return dao.selectEquipCondSixFloorSeq();
	}
	
	//4Line 제조조건 수정
	@Override
	public void equipCondCommonSixFloorAdmUpdate(EquipCondCommonAdmVo vo) throws Exception{
		dao.equipCondCommonSixFloorAdmUpdate(vo);
	}
}

	