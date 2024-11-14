package mes.persistence.em;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.em.EquipPrdcInspctAdmVo;


@Repository
public class EquipPrdcInspctAdmDAOImpl implements EquipPrdcInspctAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.em.equipPrdcInspctAdmMapper";
	
	//정기검사관리 목록 조회
	@Override
	public List<EquipPrdcInspctAdmVo> listAll(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		return session.selectList(namespace + ".listAll",equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 등록
	@Override
	public void create(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		session.insert(namespace + ".create",equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 삭제
	@Override
	public void delete(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		session.delete(namespace + ".delete",equipPrdcInspctAdmVo);
	}
	
	//정기검사관리 상세
	public EquipPrdcInspctAdmVo read(EquipPrdcInspctAdmVo equipPrdcInspctAdmVo) throws Exception{
		return session.selectOne(namespace + ".read",equipPrdcInspctAdmVo);
	}
	
}