package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.SystemCommonCodeDAO;

@Service
public class SystemCommonCodeServiceImpl implements SystemCommonCodeService {

	@Inject
	private SystemCommonCodeDAO dao;

	//시스템공통코드 전체조회
	@Override
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception {
		return dao.listAll(Vo);
	}

	//시스템공통코드 특정 Read
	@Override
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception {
		return dao.read(Vo);
	}
	
	//시스템공통그룹 Create
	@Override
	public void create(SystemCommonCodeVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//시스템공통코드 Update
	@Override
	public void update(SystemCommonCodeVo Vo) throws Exception {
		dao.update(Vo);
	}

	//시스템공통코드 SEQ(baseCd)
	@Override
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception {
		return dao.readCommonSeq(Vo);
	}
	
	//품질정보 관리 009 조회
	@Override
	public List<SystemCommonCodeVo> inspectList(SystemCommonCodeVo Vo) throws Exception {
		return dao.inspectList(Vo);
	}
	
	//시스템공통코드 전체조회 - etc2순
	@Override
	public List<SystemCommonCodeVo> listAllEtc2(SystemCommonCodeVo Vo) throws Exception{
		return dao.listAllEtc2(Vo);
	}
	
	//시스템공통코드 전체조회 - etc2순 - 3공장 외관불량용
	@Override
	public List<SystemCommonCodeVo> listAllEtc2Fa3(SystemCommonCodeVo Vo) throws Exception{
		return dao.listAllEtc2Fa3(Vo);
	}
	
	
	/*
	 * //품질정보코드 전체조회
	 * 
	 * @Override public List<SystemCommonCodeVo>
	 * inspectInfoListAll(SystemCommonCodeVo Vo) throws Exception { return
	 * dao.inspectInfoListAll(Vo); }
	 * 
	 * //품질정보코드 특정 Read
	 * 
	 * @Override public SystemCommonCodeVo inspectInfoRead(SystemCommonCodeVo Vo)
	 * throws Exception { return dao.inspectInfoRead(Vo); }
	 * 
	 * //품질정보코드 Create
	 * 
	 * @Override public void inspectInfoCreate(SystemCommonCodeVo Vo) throws
	 * Exception { dao.inspectInfoCreate(Vo); }
	 * 
	 * //품질정보코드 Update
	 * 
	 * @Override public void inspectInfoUpdate(SystemCommonCodeVo Vo) throws
	 * Exception { dao.inspectInfoUpdate(Vo); }
	 * 
	 * //품질정보코드 SEQ(baseCd)
	 * 
	 * @Override public SystemCommonCodeVo
	 * inspectInfoReadCommonSeq(SystemCommonGroupVo Vo) throws Exception { return
	 * dao.inspectInfoReadCommonSeq(Vo); }
	 */
}
