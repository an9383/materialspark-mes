package mes.persistence.bm;

import java.util.List;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;

public interface SystemCommonCodeDAO {

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
	
	//시스템공통코드 전체조회 - etc2순
	public List<SystemCommonCodeVo> listAllEtc2(SystemCommonCodeVo Vo) throws Exception;
	
	//시스템공통코드 전체조회 - etc2순 - 3공장 외관불량용
	public List<SystemCommonCodeVo> listAllEtc2Fa3(SystemCommonCodeVo Vo) throws Exception;
	
	/*
	 * //품질정보 공통코드 전체조회 public List<SystemCommonCodeVo>
	 * inspectInfoListAll(SystemCommonCodeVo Vo) throws Exception;
	 * 
	 * //품질정보 공통코드 특정 Read public SystemCommonCodeVo
	 * inspectInfoRead(SystemCommonCodeVo Vo) throws Exception;
	 * 
	 * //품질정보 공통코드 Create public void inspectInfoCreate(SystemCommonCodeVo Vo)
	 * throws Exception;
	 * 
	 * //품질정보 공통코드 Update public void inspectInfoUpdate(SystemCommonCodeVo Vo)
	 * throws Exception;
	 * 
	 * //품질정보 공통코드 SEQ(baseCd) public SystemCommonCodeVo
	 * inspectInfoReadCommonSeq(SystemCommonGroupVo Vo) throws Exception;
	 */
}