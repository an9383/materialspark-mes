package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.ProcessGroupDAO;

@Service
public class ProcessGroupServiceImpl implements ProcessGroupService {

	@Inject
	private ProcessGroupDAO dao;

	//시스템공통그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll() throws Exception {
		return dao.listAll();
	}
	
	//시스템공통그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//시스템공통그룹 Create
	@Override
	public void create(SystemCommonGroupVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//시스템공통그룹 Update
	@Override
	public void update(SystemCommonGroupVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//시스템공통그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo readGroupSeq() throws Exception {
		return dao.readGroupSeq();
	}
	
}