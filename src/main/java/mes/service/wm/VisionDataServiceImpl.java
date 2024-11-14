package mes.service.wm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.VisionDataVo;
import mes.persistence.wm.VisionDataDAO;

@Service
public class VisionDataServiceImpl implements VisionDataService {

	@Inject
	private VisionDataDAO dao;

	//비전데이터 조회
	@Override
	public List<VisionDataVo> list(VisionDataVo visionDataVo) throws Exception{
		return dao.list(visionDataVo);
	}
	
	//비전데이터 날짜별 집계 조회
	@Override
	public List<VisionDataVo> listTotal(VisionDataVo visionDataVo) throws Exception{
		return dao.listTotal(visionDataVo);
	}
	
	//비전데이터 Lot별 집계 조회
	@Override
	public List<VisionDataVo> listLot(VisionDataVo visionDataVo) throws Exception{
		return dao.listLot(visionDataVo);
	}
	
	//비전데이터 일자별 집계 조회
	@Override
	public List<VisionDataVo> listDay(VisionDataVo visionDataVo) throws Exception{
		return dao.listDay(visionDataVo);
	}
	
	//비전 데이터 이력 입력
	@Override
	public void create(VisionDataVo visionDataVo) throws Exception{
		dao.create(visionDataVo);
	}
	
	//비전데이터 셋 조회
	@Override
	public List<VisionDataVo> visionDataSet(VisionDataVo visionDataVo) throws Exception{
		return dao.visionDataSet(visionDataVo);
	}
	
	//MES비전데이터 조회
	@Override
	public List<VisionDataVo> mesVisionDataRead(VisionDataVo visionDataVo) throws Exception{
		return dao.mesVisionDataRead(visionDataVo);
	}
	
}
