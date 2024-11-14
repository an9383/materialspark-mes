package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.DowntimeCodeDAO;

@Service
public class DowntimeCodeServiceImpl implements DowntimeCodeService {

	@Inject
	private DowntimeCodeDAO dao;

	//공정순서코드 전체조회
	@Override
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//공정순서코드 특정 Read
	@Override
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//공정순서그룹 Create
	@Override
	public void create(SystemCommonCodeVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//공정순서코드 Update
	@Override
	public void update(SystemCommonCodeVo Vo) throws Exception {
		dao.update(Vo);
	}

	//공정순서코드 SEQ(baseCd)
	@Override
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception {
		return dao.readCommonSeq(Vo);
	}
	
}