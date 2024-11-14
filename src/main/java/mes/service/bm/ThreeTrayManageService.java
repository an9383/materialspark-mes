package mes.service.bm;

import java.util.List;

import mes.domain.bm.ThreeTrayManageVo;

public interface ThreeTrayManageService {
	
	//3트레이관리 전체조회
	public List<ThreeTrayManageVo> threeTrayManageList(ThreeTrayManageVo Vo) throws Exception;

	//3트레이관리 특정 Read
	public ThreeTrayManageVo threeTrayManageRead(ThreeTrayManageVo Vo) throws Exception;
	
	//3트레이관리 Create
	public void threeTrayManageCreate(ThreeTrayManageVo Vo) throws Exception;
	
	//3트레이관리일괄 Create
	public void threeTrayManageBatchCreate(ThreeTrayManageVo Vo) throws Exception;
	
	//3트레이관리 Update
	public void threeTrayManageUpdate(ThreeTrayManageVo Vo) throws Exception;
	
	//3트레이관리 SEQ(baseCd)
	public ThreeTrayManageVo threeTrayManageBaseCdSeq(ThreeTrayManageVo Vo) throws Exception;
	
	//날짜 검색조건 조회
	public List<ThreeTrayManageVo> threeTrayWeightDate() throws Exception;
	
	//3Tray 판정
	public List<ThreeTrayManageVo> threeTrayInspection(ThreeTrayManageVo Vo) throws Exception;
}