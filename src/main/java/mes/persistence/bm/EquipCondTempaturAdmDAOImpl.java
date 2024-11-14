package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.EquipCondTempaturAdmVo;
import mes.domain.bm.EquipCondTempaturSixFloorAdmVo;

@Repository
public class EquipCondTempaturAdmDAOImpl implements EquipCondTempaturAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.equipCondTempaturAdmMapper";
	
	//Bom 온도 전체조회
	@Override
	public List<EquipCondTempaturAdmVo> listAll(EquipCondTempaturAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//Bom 온도 Read
	public EquipCondTempaturAdmVo read(EquipCondTempaturAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//Bom 온도 Create
	@Override
	public void create(EquipCondTempaturAdmVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//Bom 온도 Update
	@Override
	public void update(EquipCondTempaturAdmVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	////Bom 온도 sequence 조회s
	@Override
	public String selectTempaturSeqCd() throws Exception{
		return session.selectOne(namespace+".selectTempaturSeqCd");
	}
	
	
	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 온도 전체조회
	@Override
	public List<EquipCondTempaturSixFloorAdmVo> tempaturSixFloorList(EquipCondTempaturSixFloorAdmVo Vo) throws Exception{
		return session.selectList(namespace+".tempaturSixFloorList", Vo);
	}

	//Bom 온도 Read
	public EquipCondTempaturSixFloorAdmVo tempaturSixFloorRead(EquipCondTempaturSixFloorAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".tempaturSixFloorRead", Vo);
	}
	
	//Bom 온도 Create
	@Override
	public void tempaturSixFloorCreate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception{
		session.insert(namespace+".tempaturSixFloorCreate", Vo);
	}
	
	//Bom 온도 Update
	@Override
	public void tempaturSixFloorUpdate(EquipCondTempaturSixFloorAdmVo Vo) throws Exception{
		session.update(namespace+".tempaturSixFloorUpdate", Vo);
	}
	
	////Bom 온도 sequence 조회s
	@Override
	public String selectTempaturSixFloorSeqCd() throws Exception{
		return session.selectOne(namespace+".selectTempaturSixFloorSeqCd");
	}
}