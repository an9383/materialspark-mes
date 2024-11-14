package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.FaultyCommonGroupVo;
import mes.persistence.qm.FaultyCommonGroupDAO;

@Service
public class FaultyCommonGroupServiceImpl implements FaultyCommonGroupService {

	@Inject
	private FaultyCommonGroupDAO dao;

	//불량그룹 전체조회
	@Override
	public List<FaultyCommonGroupVo> listAll() throws Exception {
		return dao.listAll();
	}
	
	//불량그룹 특정 Read
	@Override
	public FaultyCommonGroupVo read(FaultyCommonGroupVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//불량그룹 Create
	@Override
	public void create(FaultyCommonGroupVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//불량그룹 Update
	@Override
	public void update(FaultyCommonGroupVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//불량그룹 SEQ(baseGroupCd)
	@Override
	public FaultyCommonGroupVo readGroupSeq() throws Exception {
		return dao.readGroupSeq();
	}
}
