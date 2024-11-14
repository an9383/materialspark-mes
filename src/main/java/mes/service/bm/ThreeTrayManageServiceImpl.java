package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.ThreeTrayManageVo;
import mes.persistence.bm.ThreeTrayManageDAO;

@Service
public class ThreeTrayManageServiceImpl implements ThreeTrayManageService {

	@Inject
	private ThreeTrayManageDAO dao;

	//3트레이관리 전체조회
	@Override
	public List<ThreeTrayManageVo> threeTrayManageList(ThreeTrayManageVo Vo) throws Exception {
		return dao.threeTrayManageList(Vo);
	}

	//3트레이관리 특정 Read
	@Override
	public ThreeTrayManageVo threeTrayManageRead(ThreeTrayManageVo Vo) throws Exception {
		return dao.threeTrayManageRead(Vo);
	}
	
	//3트레이관리 Create
	@Override
	public void threeTrayManageCreate(ThreeTrayManageVo Vo) throws Exception {
		dao.threeTrayManageCreate(Vo);
	}
	
	//3트레이관리일괄 Create
	@Override
	public void threeTrayManageBatchCreate(ThreeTrayManageVo Vo) throws Exception {
		dao.threeTrayManageBatchCreate(Vo);
	}
	
	//3트레이관리 Update
	@Override
	public void threeTrayManageUpdate(ThreeTrayManageVo Vo) throws Exception {
		dao.threeTrayManageUpdate(Vo);
	}

	//3트레이관리 SEQ(baseCd)
	@Override
	public ThreeTrayManageVo threeTrayManageBaseCdSeq(ThreeTrayManageVo Vo) throws Exception {
		return dao.threeTrayManageBaseCdSeq(Vo);
	}
	
	//날짜 검색조건 조회
	@Override
	public List<ThreeTrayManageVo> threeTrayWeightDate() throws Exception {
		return dao.threeTrayWeightDate();
	}
	
	//3Tray 판정
	@Override
	public List<ThreeTrayManageVo> threeTrayInspection(ThreeTrayManageVo Vo) throws Exception {
		return dao.threeTrayInspection(Vo);
	}
	
}
