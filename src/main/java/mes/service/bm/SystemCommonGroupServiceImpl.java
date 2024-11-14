package mes.service.bm;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;

import mes.domain.bm.LogionHistVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.SystemCommonGroupDAO;

@Service
public class SystemCommonGroupServiceImpl implements SystemCommonGroupService {

	@Inject
	private SystemCommonGroupDAO dao;

	//시스템공통그룹 전체조회
	@Override
	public List<SystemCommonGroupVo> listAll(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		return dao.listAll(systemCommonGroupVo);
	}
	
	//시스템공통그룹 특정 Read
	@Override
	public SystemCommonGroupVo read(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		return dao.read(systemCommonGroupVo);
	}
	
	//시스템공통그룹 Create
	@Override
	public void create(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		dao.create(systemCommonGroupVo);
	}
	
	//시스템공통그룹 Update
	@Override
	public void update(SystemCommonGroupVo systemCommonGroupVo) throws Exception {
		dao.update(systemCommonGroupVo);
	}
	
	//시스템공통그룹 SEQ(baseGroupCd)
	@Override
	public SystemCommonGroupVo readGroupSeq() throws Exception {
		return dao.readGroupSeq();
	}
	
	
	/*
	 * //품질정보그룹 전체조회
	 * 
	 * @Override public List<SystemCommonGroupVo> inspectInfoListAll() throws
	 * Exception { return dao.inspectInfoListAll(); }
	 * 
	 * //품질정보그룹 특정 Read
	 * 
	 * @Override public SystemCommonGroupVo inspectInfoRead(SystemCommonGroupVo systemCommonGroupVo)
	 * throws Exception { return dao.inspectInfoRead(systemCommonGroupVo); }
	 * 
	 * //품질정보그룹 Create
	 * 
	 * @Override public void inspectInfoCreate(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception { dao.inspectInfoCreate(systemCommonGroupVo); }
	 * 
	 * //품질정보그룹 Update
	 * 
	 * @Override public void inspectInfoUpdate(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception { dao.inspectInfoUpdate(systemCommonGroupVo); }
	 * 
	 * //품질정보그룹 SEQ(baseGroupCd)
	 * 
	 * @Override public SystemCommonGroupVo inspectInfoReadGroupSeq() throws
	 * Exception { return dao.inspectInfoReadGroupSeq(); }
	 */
	
	//로그인Hist seq
	@Override
	public long selectLoginNo() throws Exception {
		return dao.selectLoginNo();
	}
	
	//로그인 기록 생성
	@Override
	public void createLoginHist(LogionHistVo logionHistVo) throws Exception {
		dao.createLoginHist(logionHistVo);
	}
	
}