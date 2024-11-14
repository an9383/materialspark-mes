package mes.service.em;

import java.util.List;

import mes.domain.em.ManufacturerVo;
import mes.domain.em.EquipCondCommonAdmVo;

public interface ManufacturerService {
	
	//제조조건관리 설비 클릭시 계획 목록 조회
	public List<ManufacturerVo> listAll(ManufacturerVo vo) throws Exception;

	//해당설비 계획 목록 조회
	public List<ManufacturerVo> listRead(EquipCondCommonAdmVo vo) throws Exception;
	
	//설비조건공통관리 생성
	public void equipCondCommonAdmcreate(EquipCondCommonAdmVo vo) throws Exception;
	
	//제품코드 조회 팝업의 목록에서 특정 제품 클릭 시 제품코드에 대한 재질,규격,두께등을 가져옴
	public ManufacturerVo read(ManufacturerVo vo) throws Exception;
	
	/*
	 * // public void update(ManufacturerVo vo) throws Exception;
	 */
	//설비코드 시퀀스
	public String selectEquipCondSeq() throws Exception;
	
	//제조조건 fp사용, 메인구분, 수정
	public void equipCondCommonAdmUpdate(EquipCondCommonAdmVo vo) throws Exception;
	
	//제조조건 FP 메인구분 전체삭제
	public void deleteFpMainGubun(EquipCondCommonAdmVo vo) throws Exception;
	
	
	//4Line 설비조건공통관리 생성
	public void equipCondCommonSixFloorAdmCreate(EquipCondCommonAdmVo vo) throws Exception;
	
	//4Line 설비코드 시퀀스
	public String selectEquipCondSixFloorSeq() throws Exception;
	
	//4Line 제조조건 수정
	public void equipCondCommonSixFloorAdmUpdate(EquipCondCommonAdmVo vo) throws Exception;
}
