package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.EquipCondPressureAdmVo;

@Repository
public class EquipCondPressureAdmDAOImpl implements EquipCondPressureAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.equipCondPressureAdmMapper";
	
	//Bom 압력 전체조회
	@Override
	public List<EquipCondPressureAdmVo> listAll(EquipCondPressureAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//Bom 압력 Read
	public EquipCondPressureAdmVo read(EquipCondPressureAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//Bom 압력 Create
	@Override
	public void create(EquipCondPressureAdmVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//Bom 압력 Update
	@Override
	public void update(EquipCondPressureAdmVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//Bom 압력 sequence 조회s
	@Override
	public String selectPressureSeqCd() throws Exception{
		return session.selectOne(namespace+".selectPressureSeqCd");
	}
	
}