package mes.service.bm;

import java.util.List;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;

public interface WorkPlaceCodeService {
	
	//시스템공통코드 전체조회
	public List<SystemCommonCodeVo> listAll(SystemCommonCodeVo Vo) throws Exception;

	//시스템공통코드 특정 Read
	public SystemCommonCodeVo read(SystemCommonCodeVo Vo) throws Exception;
	
	//시스템공통코드 Create
	public void create(SystemCommonCodeVo Vo) throws Exception;
	
	//시스템공통코드 Update
	public void update(SystemCommonCodeVo Vo) throws Exception;
	
	//시스템공통코드 SEQ(baseCd)
	public SystemCommonCodeVo readCommonSeq(SystemCommonGroupVo Vo) throws Exception;
		
	//품질정보 관리 009 조회
	public List<SystemCommonCodeVo> inspectList(SystemCommonCodeVo Vo) throws Exception;
	
	/*
	 * //품질정보코드 전체조회 public List<SystemCommonCodeVo>
	 * inspectInfoListAll(SystemCommonCodeVo Vo) throws Exception;
	 * 
	 * //품질정보코드 특정 Read public SystemCommonCodeVo inspectInfoRead(SystemCommonCodeVo
	 * Vo) throws Exception;
	 * 
	 * //품질정보코드 Create public void inspectInfoCreate(SystemCommonCodeVo Vo) throws
	 * Exception;
	 * 
	 * //품질정보코드 Update public void inspectInfoUpdate(SystemCommonCodeVo Vo) throws
	 * Exception;
	 * 
	 * //품질정보코드 SEQ(baseCd) public SystemCommonCodeVo
	 * inspectInfoReadCommonSeq(SystemCommonGroupVo Vo) throws Exception;
	 */
}