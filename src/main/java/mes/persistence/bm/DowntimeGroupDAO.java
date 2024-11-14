package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.SystemCommonGroupVo;

public interface DowntimeGroupDAO {

	//비가동그룹 전체조회
	public List<SystemCommonGroupVo> listAll() throws Exception;
	
	//비가동그룹 특정 Read
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception;
	
	//비가동그룹 Create
	public void create(SystemCommonGroupVo Vo) throws Exception;
	
	//비가동그룹 Update
	public void update(SystemCommonGroupVo Vo) throws Exception;
	
	//비가동그룹 SEQ(baseGroupCd)
	public SystemCommonGroupVo readGroupSeq() throws Exception;
	
}