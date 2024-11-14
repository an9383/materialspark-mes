package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.EquipCodeAdmVo;

@Repository
public class EquipCodeAdmDAOImpl implements EquipCodeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.equipCodeAdmMapper";
	
	//설비코드 전체조회
	@Override
	public List<EquipCodeAdmVo> listAll(EquipCodeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//설비코드 특정 Read
	public EquipCodeAdmVo read(EquipCodeAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//설비코드/코드명 중복 체크
	public String equipCdNmCheck(EquipCodeAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".equipCdNmCheck", Vo);
	}
	
	//설비코드 Create
	@Override
	public void create(EquipCodeAdmVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//설비코드 Update
	@Override
	public void update(EquipCodeAdmVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//설비코드별 작지 조회(비전수집용)
	@Override
	public List<EquipCodeAdmVo> visionDataListAll(EquipCodeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".visionDataListAll", Vo);
	}
	
	//설비코드 듀얼 합 조회
	@Override
	public List<EquipCodeAdmVo> listEquipSLD(EquipCodeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listEquipSLD", Vo);
	}
	
	//설비코드 듀얼 합 조회 (MTP)
	@Override
	public List<EquipCodeAdmVo> listEquipMTP(EquipCodeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listEquipMTP", Vo);
	}
		
	//설비코드 듀얼 합 조회 (MTP2)
	@Override
	public List<EquipCodeAdmVo> listEquipMTP2(EquipCodeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listEquipMTP2", Vo);
	}
}