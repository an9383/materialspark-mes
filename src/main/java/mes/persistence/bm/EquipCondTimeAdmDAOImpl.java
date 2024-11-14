package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.EquipCondTimeAdmVo;
import mes.domain.bm.EquipCondTimeSixFloorAdmVo;

@Repository
public class EquipCondTimeAdmDAOImpl implements EquipCondTimeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.equipCondTimeAdmMapper";
	
	//Bom 시간 전체조회
	@Override
	public List<EquipCondTimeAdmVo> listAll(EquipCondTimeAdmVo Vo) throws Exception{
		return session.selectList(namespace+".listAll", Vo);
	}

	//Bom 시간 Read
	public EquipCondTimeAdmVo read(EquipCondTimeAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".read", Vo);
	}
	
	//Bom 시간 Create
	@Override
	public void create(EquipCondTimeAdmVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//Bom 시간 Update
	@Override
	public void update(EquipCondTimeAdmVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	////Bom 시간 sequence 조회
	@Override
	public String selectTimeSeqCd() throws Exception{
		return session.selectOne(namespace+".selectTimeSeqCd");
	}
	

	//6층 온도 정보(Bom온도조건관리)_23.10.24 추가
	//Bom 시간 전체조회
	@Override
	public List<EquipCondTimeSixFloorAdmVo> timeSixFloorList(EquipCondTimeSixFloorAdmVo Vo) throws Exception{
		return session.selectList(namespace+".timeSixFloorList", Vo);
	}

	//Bom 시간 Read
	public EquipCondTimeSixFloorAdmVo timeSixFloorRead(EquipCondTimeSixFloorAdmVo Vo) throws Exception{
		return session.selectOne(namespace+".timeSixFloorRead", Vo);
	}
	
	//Bom 시간 Create
	@Override
	public void timeSixFloorCreate(EquipCondTimeSixFloorAdmVo Vo) throws Exception{
		session.insert(namespace+".timeSixFloorCreate", Vo);
	}
	
	//Bom 시간 Update
	@Override
	public void timeSixFloorUpdate(EquipCondTimeSixFloorAdmVo Vo) throws Exception{
		session.update(namespace+".timeSixFloorUpdate", Vo);
	}
	
	////Bom 시간 sequence 조회
	@Override
	public String selectTimeSixFloorSeqCd() throws Exception{
		return session.selectOne(namespace+".selectTimeSixFloorSeqCd");
	}
}