package mes.service.wm;

import java.util.List;

import mes.domain.wm.VisionDataVo;

public interface VisionDataService {
	
	//비전데이터 조회
	public List<VisionDataVo> list(VisionDataVo visionDataVo) throws Exception;
	
	//비전데이터 날짜별 집계 조회
	public List<VisionDataVo> listTotal(VisionDataVo visionDataVo) throws Exception;
	
	//비전데이터 Lot별 집계 조회
	public List<VisionDataVo> listLot(VisionDataVo visionDataVo) throws Exception;
	
	//비전데이터 일자별 집계 조회
	public List<VisionDataVo> listDay(VisionDataVo visionDataVo) throws Exception;
	
	//비전 데이터 이력 입력
	public void create(VisionDataVo visionDataVo) throws Exception;
	
	//비전데이터 셋 조회
	public List<VisionDataVo> visionDataSet(VisionDataVo visionDataVo) throws Exception;
	
	//MES비전데이터 조회
	public List<VisionDataVo> mesVisionDataRead(VisionDataVo visionDataVo) throws Exception;
	

}
