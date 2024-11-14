package mes.service.bm;

import java.util.List;
import mes.domain.bm.SystemCommonGroupVo;

public interface DowntimeGroupService {
	
	//공정순서그룹 전체조회
	public List<SystemCommonGroupVo> listAll() throws Exception;

	//공정순서그룹 특정 Read
	public SystemCommonGroupVo read(SystemCommonGroupVo Vo) throws Exception;
	
	//공정순서그룹 Create
	public void create(SystemCommonGroupVo Vo) throws Exception;
	
	//공정순서그룹 Update
	public void update(SystemCommonGroupVo Vo) throws Exception;
	
	//공정순서그룹 SEQ(baseGroupCd)
	public SystemCommonGroupVo readGroupSeq() throws Exception;
	
}