package mes.persistence.wm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.VisionDataVo;

@Repository
public class VisionDataDAOImpl implements VisionDataDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.visionDataMapper";
	
	//비전데이터 조회
	@Override
	public  List<VisionDataVo> list(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".list", visionDataVo);
	}
	
	//비전데이터 날짜별 집계 조회
	@Override
	public List<VisionDataVo> listTotal(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".listTotal", visionDataVo);
	}
	
	//비전데이터 Lot별 집계 조회
	@Override
	public List<VisionDataVo> listLot(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".listLot", visionDataVo);
	}
	
	//비전데이터 일자별 집계 조회
	@Override
	public List<VisionDataVo> listDay(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".listDay", visionDataVo);
	}
	
	//비전 데이터 이력 입력
	@Override
	public void create(VisionDataVo visionDataVo) throws Exception{
		session.insert(namespace+".create", visionDataVo);
	}
	
	//비전데이터 셋 조회
	@Override
	public List<VisionDataVo> visionDataSet(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".visionDataSet", visionDataVo);
	}
	
	//MES비전데이터 조회
	@Override
	public List<VisionDataVo> mesVisionDataRead(VisionDataVo visionDataVo) throws Exception{
		return session.selectList(namespace+".mesVisionDataRead", visionDataVo);
	}
}