package mes.service.qm;

import java.util.List;

import mes.domain.qm.FaultyCommonCodeVo;
import mes.domain.qm.FaultyCommonGroupVo;

public interface FaultyCommonCodeService {
	
	//불량코드 전체조회
	public List<FaultyCommonCodeVo> listAll(FaultyCommonCodeVo Vo) throws Exception;

	//불량코드 특정 Read
	public FaultyCommonCodeVo read(FaultyCommonCodeVo Vo) throws Exception;
	
	//불량코드 Create
	public void create(FaultyCommonCodeVo Vo) throws Exception;
	
	//불량코드 Update
	public void update(FaultyCommonCodeVo Vo) throws Exception;
	
	//불량코드 SEQ(baseCd)
	public FaultyCommonCodeVo readCommonSeq(FaultyCommonGroupVo Vo) throws Exception;
	
}