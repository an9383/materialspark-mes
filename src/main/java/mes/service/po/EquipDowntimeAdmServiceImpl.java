package mes.service.po;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.EquipDowntimeAdmVo;
import mes.persistence.po.EquipDowntimeAdmDAO;


@Service
public class EquipDowntimeAdmServiceImpl implements EquipDowntimeAdmService {
	@Inject
	private EquipDowntimeAdmDAO dao;

	//비가동 사유 등록 목록 조회
	@Override
	public List<EquipDowntimeAdmVo> listAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return dao.listAll(equipDowntimeAdmVo);
	}
	
	//비가동 사유 등록
	@Override
	public void create(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		dao.create(equipDowntimeAdmVo);		
	}
	
	//비가동 사유 수정
	@Override
	public void update(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		dao.update(equipDowntimeAdmVo);		
	}
	
	//비가동 사유 삭제
	@Override
	public void delete(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		dao.delete(equipDowntimeAdmVo);		
	}
	
	//비가동 사유 불러오기
	@Override
	public EquipDowntimeAdmVo listChecked(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return dao.listChecked(equipDowntimeAdmVo);
	}
	
	//비가동 날짜 조회
	@Override
	public List<EquipDowntimeAdmVo> operationListAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return dao.operationListAll(equipDowntimeAdmVo);
	}
	
	//비가동 idx 생성
	public String downtimeIdx(String date) throws Exception{
		return dao.downtimeIdx(date);
	}
	
	//설비 가동현황 조회
	@Override
	public List<Map<String,String>> equipOperationBody(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return dao.equipOperationBody(equipDowntimeAdmVo);
	}
	
}