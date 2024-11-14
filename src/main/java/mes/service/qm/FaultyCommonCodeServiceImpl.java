package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.FaultyCommonCodeVo;
import mes.domain.qm.FaultyCommonGroupVo;
import mes.persistence.qm.FaultyCommonCodeDAO;

@Service
public class FaultyCommonCodeServiceImpl implements FaultyCommonCodeService {

	@Inject
	private FaultyCommonCodeDAO dao;

	//불량코드 전체조회
	@Override
	public List<FaultyCommonCodeVo> listAll(FaultyCommonCodeVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//불량코드 특정 Read
	@Override
	public FaultyCommonCodeVo read(FaultyCommonCodeVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//불량그룹 Create
	@Override
	public void create(FaultyCommonCodeVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//불량코드 Update
	@Override
	public void update(FaultyCommonCodeVo Vo) throws Exception {
		dao.update(Vo);
	}

	//불량코드 SEQ(baseCd)
	@Override
	public FaultyCommonCodeVo readCommonSeq(FaultyCommonGroupVo Vo) throws Exception {
		return dao.readCommonSeq(Vo);
	}
	
}
