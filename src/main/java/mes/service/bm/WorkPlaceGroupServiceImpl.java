package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.SystemCommonGroupVo;
import mes.persistence.bm.WorkPlaceGroupDAO;

@Service
public class WorkPlaceGroupServiceImpl implements WorkPlaceGroupService {

	@Inject
	private WorkPlaceGroupDAO dao;

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
	
	
	/*
	 * //품질정보그룹 전체조회
	 * 
	 * @Override public List<SystemCommonGroupVo> inspectInfoListAll() throws
	 * Exception { return dao.inspectInfoListAll(); }
	 * 
	 * //품질정보그룹 특정 Read
	 * 
	 * @Override public SystemCommonGroupVo inspectInfoRead(SystemCommonGroupVo Vo)
	 * throws Exception { return dao.inspectInfoRead(Vo); }
	 * 
	 * //품질정보그룹 Create
	 * 
	 * @Override public void inspectInfoCreate(SystemCommonGroupVo Vo) throws
	 * Exception { dao.inspectInfoCreate(Vo); }
	 * 
	 * //품질정보그룹 Update
	 * 
	 * @Override public void inspectInfoUpdate(SystemCommonGroupVo Vo) throws
	 * Exception { dao.inspectInfoUpdate(Vo); }
	 * 
	 * //품질정보그룹 SEQ(baseGroupCd)
	 * 
	 * @Override public SystemCommonGroupVo inspectInfoReadGroupSeq() throws
	 * Exception { return dao.inspectInfoReadGroupSeq(); }
	 */
}
