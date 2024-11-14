package mes.persistence.bm;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.EquipCondSizeAdmVo;

@Repository
public class EquipCondSizeAdmDAOImpl implements EquipCondSizeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.equipCondSizeAdmMapper";
	
	//Bom 치수 전체조회
	@Override
	public List<EquipCondSizeAdmVo> listAll(EquipCondSizeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//Bom 치수 Read
	public EquipCondSizeAdmVo read(EquipCondSizeAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//Bom 치수 Create
	@Override
	public void create(EquipCondSizeAdmVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//Bom 치수 Update
	@Override
	public void update(EquipCondSizeAdmVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//Bom 치수 sequence 조회s
	@Override
	public String selectSizeSeqCd() throws Exception{
		return session.selectOne(namespace+".selectSizeSeqCd");
	}
	
	
	
	//6층 온도 정보(Bom온도조건관리)
	
	//Bom 치수 전체조회
	@Override
	public List<EquipCondSizeAdmVo> sizeSixFloorList(EquipCondSizeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".sizeSixFloorList", Vo);
	}

	//Bom 치수 Read
	public EquipCondSizeAdmVo sizeSixFloorRead(EquipCondSizeAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".sizeSixFloorRead", Vo);
	}
	
	//Bom 치수 Create
	@Override
	public void sizeSixFloorCeate(EquipCondSizeAdmVo Vo) throws Exception{
		session.insert(namespace+".sizeSixFloorCeate", Vo);
	}
	
	//Bom 치수 Update
	@Override
	public void sizeSixFloorUpdate(EquipCondSizeAdmVo Vo) throws Exception{
		session.update(namespace+".sizeSixFloorUpdate", Vo);
	}
	
	//Bom 치수 sequence 조회s
	@Override
	public String selectSizeSixFloorSeqCd() throws Exception{
		return session.selectOne(namespace+".selectSizeSixFloorSeqCd");
	}
	
}