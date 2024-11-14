package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.ThreeTrayManageVo;

@Repository
public class ThreeTrayManageDAOImpl implements ThreeTrayManageDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.threeTrayManageMapper";
	
	//3트레이관리 전체조회
	@Override
	public List<ThreeTrayManageVo> threeTrayManageList(ThreeTrayManageVo Vo) throws Exception{
		return session.selectList(namespace+".threeTrayManageList", Vo);
	}

	//3트레이관리 특정 Read
	@Override
	public ThreeTrayManageVo threeTrayManageRead(ThreeTrayManageVo Vo) throws Exception{
		return session.selectOne(namespace+".threeTrayManageRead", Vo);
	}
	
	//3트레이관리 Create
	@Override
	public void threeTrayManageCreate(ThreeTrayManageVo Vo) throws Exception{
		session.insert(namespace+".threeTrayManageCreate", Vo);
	}
	
	//3트레이관리일괄 Create
	@Override
	public void threeTrayManageBatchCreate(ThreeTrayManageVo Vo) throws Exception{
		session.insert(namespace+".threeTrayManageBatchCreate", Vo);
	}
	
	//3트레이관리 Update
	@Override
	public void threeTrayManageUpdate(ThreeTrayManageVo Vo) throws Exception{
		session.update(namespace+".threeTrayManageUpdate", Vo);
	}

	//3트레이관리 특정 Read
	@Override
	public ThreeTrayManageVo threeTrayManageBaseCdSeq(ThreeTrayManageVo Vo) throws Exception{
		return session.selectOne(namespace+".threeTrayManageBaseCdSeq", Vo);
	}
	
	//날짜 검색조건 조회
	@Override
	public List<ThreeTrayManageVo> threeTrayWeightDate() throws Exception{
		return session.selectList(namespace+".threeTrayWeightDate");
	}
	
	//3Tray 판정
	@Override
	public List<ThreeTrayManageVo> threeTrayInspection(ThreeTrayManageVo Vo) throws Exception{
		return session.selectList(namespace+".threeTrayInspection", Vo);
	}
	
}