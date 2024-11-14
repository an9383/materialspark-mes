package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;

public interface DowntimeCodeDAO {

	//비가동코드 전체조회
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception;
	
	//비가동코드 특정 Read
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception;
	
	//비가동코드 Create
	public void create(SystemCommonCodeVo Vo) throws Exception;
	
	//비가동코드 Update
	public void update(SystemCommonCodeVo Vo) throws Exception;
	
	//비가동코드 SEQ(baseCd)
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception;

}