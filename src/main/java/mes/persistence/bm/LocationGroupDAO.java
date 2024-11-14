package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.SystemCommonGroupVo;

public interface LocationGroupDAO {

	//시스템공통그룹 전체조회
	public List<SystemCommonGroupVo> listAll() throws Exception;
	
	//시스템공통그룹 특정 Read
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception;
	
	//시스템공통그룹 Create
	public void create(SystemCommonGroupVo Vo) throws Exception;
	
	//시스템공통그룹 Update
	public void update(SystemCommonGroupVo Vo) throws Exception;
	
	//시스템공통그룹 SEQ(baseGroupCd)
	public SystemCommonGroupVo readGroupSeq() throws Exception;
	
	
	//품질정보그룹 전체조회
	public List<SystemCommonGroupVo> inspectInfoListAll() throws Exception;
	
	//품질정보그룹 특정 Read
	public SystemCommonGroupVo inspectInfoRead(SystemCommonGroupVo Vo) throws Exception;
	
	//품질정보그룹 Create
	public void inspectInfoCreate(SystemCommonGroupVo Vo) throws Exception;
	
	//품질정보그룹 Update
	public void inspectInfoUpdate(SystemCommonGroupVo Vo) throws Exception;
	
	//품질정보그룹 SEQ(baseGroupCd)
	public SystemCommonGroupVo inspectInfoReadGroupSeq() throws Exception;
	
}