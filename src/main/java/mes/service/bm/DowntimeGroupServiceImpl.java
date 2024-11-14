package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.DowntimeGroupDAO;

@Service
public class DowntimeGroupServiceImpl implements DowntimeGroupService {

	@Inject
	private DowntimeGroupDAO dao;

	//비가동그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll() throws Exception {
		return dao.listAll();
	}
	
	//비가동그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//비가동그룹 Create
	@Override
	public void create(SystemCommonGroupVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//비가동그룹 Update
	@Override
	public void update(SystemCommonGroupVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//비가동그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo readGroupSeq() throws Exception {
		return dao.readGroupSeq();
	}
	
}