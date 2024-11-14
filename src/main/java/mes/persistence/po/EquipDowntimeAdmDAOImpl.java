package mes.persistence.po;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.EquipDowntimeAdmVo;

@Repository
public class EquipDowntimeAdmDAOImpl implements EquipDowntimeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.po.equipDowntimeAdmMapper";

	//비가동 사유 등록 목록 조회
	@Override
	public List<EquipDowntimeAdmVo> listAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return session.selectList(namespace + ".listAll",equipDowntimeAdmVo);
	}
	
	//비가동 사유 등록
	@Override
	public void create(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		session.insert(namespace + ".create",equipDowntimeAdmVo);
	}
	
	//비가동 사유 수정
	@Override
	public void update(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		session.update(namespace + ".update",equipDowntimeAdmVo);
	}
	
	//비가동 사유 삭제
	@Override
	public void delete(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		session.delete(namespace + ".delete",equipDowntimeAdmVo);
	}
	
	//비가동 사유 불러오기
	@Override
	public EquipDowntimeAdmVo listChecked(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return session.selectOne(namespace + ".listChecked",equipDowntimeAdmVo);
	}
	
	//비가동 날짜 조회
	@Override
	public List<EquipDowntimeAdmVo> operationListAll(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return session.selectList(namespace + ".operationListAll", equipDowntimeAdmVo);
	}
	
	//비가동 idx 생성
	public String downtimeIdx(String date) throws Exception{
		return session.selectOne(namespace +".downtimeIdx" , date);
	}
	
	//설비 가동현황 조회
	public List<Map<String,String>> equipOperationBody(EquipDowntimeAdmVo equipDowntimeAdmVo) throws Exception{
		return session.selectList(namespace +".equipOperationBody" , equipDowntimeAdmVo);
	}
	
}