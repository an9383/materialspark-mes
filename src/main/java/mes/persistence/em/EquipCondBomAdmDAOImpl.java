package mes.persistence.em;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.em.AgtSizeStep;
import mes.domain.em.EquipCondBomAdmVo;
import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.EquipCondCombineAdmVo;

@Repository
public class EquipCondBomAdmDAOImpl implements EquipCondBomAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.em.equipCondBomAdmMapper";
	
	//온도 등록
	@Override
	public void tempaturCreate(EquipTempaturCondAdm vo) throws Exception {
		session.insert(namespace+".tempaturCreate", vo);
	}
	
	//시간 등록
	@Override
	public void timeCreate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".timeCreate", vo);
	}
	
	//압력 등록
	@Override
	public void pressureCreate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".pressureCreate", vo);
	}
	
	//치수 등록
	@Override
	public void sizeCreate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".sizeCreate", vo);
	}
	
	

	//특정 온도 읽기
	@Override
	public EquipTempaturCondAdm tempaturRead(EquipTempaturCondAdm vo) throws Exception {
		return session.selectOne(namespace+".tempaturRead", vo);
	}
	
	//특정 시간 읽기
	@Override
	public EquipCondBomAdmVo timeRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".timeRead", vo);
	}
	
	//특정 압력 읽기
	@Override
	public EquipCondBomAdmVo pressureRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".pressureRead", vo);
	}
	
	//특정 치수 읽기
	@Override
	public EquipCondBomAdmVo sizeRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".sizeRead", vo);
	}
	
	//AGT특정 온도 읽기
	@Override
	public EquipTempaturCondAdm agtTempaturRead(EquipTempaturCondAdm vo) throws Exception {
		return session.selectOne(namespace+".agtTempaturRead", vo);
	}
	
	//AGT특정 시간 읽기
	@Override
	public EquipCondBomAdmVo agtTimeRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".agtTimeRead", vo);
	}
	
	//AGT특정 압력 읽기
	@Override
	public EquipCondBomAdmVo agtPressureRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".agtPressureRead", vo);
	}
	
	//AGT특정 치수 읽기
	@Override
	public AgtSizeStep agtSizeRead(AgtSizeStep vo) throws Exception {
		return session.selectOne(namespace+".agtSizeRead", vo);
	}	
	
	
	
	//온도 수정
	@Override
	public void tempaturUpdate(EquipTempaturCondAdm vo) throws Exception {
		session.insert(namespace+".tempaturUpdate", vo);
	}
	
	//시간 수정
	@Override
	public void timeUpdate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".timeUpdate", vo);
	}
	
	//압력 수정
	@Override
	public void pressureUpdate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".pressureUpdate", vo);
	}
	
	//치수 수정
	@Override
	public void sizeUpdate(EquipCondBomAdmVo vo) throws Exception {
		session.insert(namespace+".sizeUpdate", vo);
	}

	//특정 제조조건 코드로제조조건(온도,시간,압력,치수) 통합조회
	@Override
	public EquipCondCombineAdmVo equipCondCombineRead(EquipCondCombineAdmVo equipCondCombineAdmVo) throws Exception {
		return session.selectOne(namespace+".equipCondCombineRead", equipCondCombineAdmVo);
	}
	
	//특정 치수 조건 읽기
	@Override
	public EquipCondBomAdmVo sizeSixFloorRead(EquipCondBomAdmVo vo) throws Exception {
		return session.selectOne(namespace+".sizeSixFloorRead", vo);
	}
	
}