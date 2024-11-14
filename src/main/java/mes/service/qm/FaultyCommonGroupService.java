package mes.service.qm;

import java.util.List;

import mes.domain.qm.FaultyCommonGroupVo;

public interface FaultyCommonGroupService {
	
	//불량그룹 전체조회
	public List<FaultyCommonGroupVo> listAll() throws Exception;

	//불량그룹 특정 Read
	public FaultyCommonGroupVo read(FaultyCommonGroupVo Vo) throws Exception;
	
	//불량그룹 Create
	public void create(FaultyCommonGroupVo Vo) throws Exception;
	
	//불량그룹 Update
	public void update(FaultyCommonGroupVo Vo) throws Exception;
	
	//불량그룹 SEQ(baseGroupCd)
	public FaultyCommonGroupVo readGroupSeq() throws Exception;
}
