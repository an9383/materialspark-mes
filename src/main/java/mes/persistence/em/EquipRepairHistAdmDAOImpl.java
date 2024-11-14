package mes.persistence.em;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.em.EquipRepairHistAdmVo;

@Repository
public class EquipRepairHistAdmDAOImpl implements EquipRepairHistAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.em.equipRepairHistAdmMapper";

	@Override
	public List<EquipRepairHistAdmVo> listAll(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {		
		return session.selectList(namespace + ".listAll", equipRepairHistAdmVo);
	}

	@Override
	public void create(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		session.insert(namespace + ".create",equipRepairHistAdmVo);
	}

	@Override
	public EquipRepairHistAdmVo read(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {		
		return session.selectOne(namespace + ".read",equipRepairHistAdmVo);
	}

	@Override
	public void update(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {
		session.update(namespace + ".update", equipRepairHistAdmVo);		
	}
	
	//등록번호 시퀀스
	@Override
	public String seq() throws Exception{
		return session.selectOne(namespace + ".selectRepairNoSeq");
	}

	//등록일자 시퀀스
	@Override
	public String regSeq(String time) throws Exception{
		return session.selectOne(namespace + ".repairRegDateCreate", time);
	}

	//memsInfo_조회
	@Override
	public List<EquipRepairHistAdmVo> memsInfoList(EquipRepairHistAdmVo equipRepairHistAdmVo) throws Exception {		
		return session.selectList(namespace + ".memsInfoList", equipRepairHistAdmVo);
	}
	
}