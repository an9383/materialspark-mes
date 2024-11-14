package mes.service.po;

import java.util.List;
import java.util.Map;

import mes.domain.po.EquipDowntimeAdmVo;

public interface EquipDowntimeAdmService {

	//비가동 사유 등록 목록 조회
	public List<EquipDowntimeAdmVo> listAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 사유 등록
	public void create(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 사유 수정
	public void update(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 사유 삭제
	public void delete(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 사유 불러오기
	public EquipDowntimeAdmVo listChecked(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 날짜 조회
	public List<EquipDowntimeAdmVo> operationListAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
	//비가동 idx 생성
	public String downtimeIdx(String date) throws Exception;
	
	//설비 가동현황 조회
	public List<Map<String,String>> equipOperationBody(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception;
	
}