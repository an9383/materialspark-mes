package mes.service.bm;

import java.util.List;

import mes.domain.bm.LogionHistVo;
import mes.domain.bm.SystemCommonGroupVo;

public interface SystemCommonGroupService {
	
	//시스템공통그룹 전체조회
	public List<SystemCommonGroupVo> listAll(SystemCommonGroupVo systemCommonGroupVo) throws Exception;

	//시스템공통그룹 특정 Read
	public SystemCommonGroupVo read(SystemCommonGroupVo systemCommonGroupVo) throws Exception;
	
	//시스템공통그룹 Create
	public void create(SystemCommonGroupVo systemCommonGroupVo) throws Exception;
	
	//시스템공통그룹 Update
	public void update(SystemCommonGroupVo systemCommonGroupVo) throws Exception;
	
	//시스템공통그룹 SEQ(baseGroupCd)
	public SystemCommonGroupVo readGroupSeq() throws Exception;
	
	
	/*
	 * //품질정보그룹 전체조회 public List<SystemCommonGroupVo> inspectInfoListAll() throws
	 * Exception;
	 * 
	 * //품질정보그룹 특정 Read public SystemCommonGroupVo
	 * inspectInfoRead(SystemCommonGroupVo systemCommonGroupVo) throws Exception;
	 * 
	 * //품질정보그룹 Create public void inspectInfoCreate(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception;
	 * 
	 * //품질정보그룹 Update public void inspectInfoUpdate(SystemCommonGroupVo systemCommonGroupVo) throws
	 * Exception;
	 * 
	 * //품질정보그룹 SEQ(baseGroupCd) public SystemCommonGroupVo
	 * inspectInfoReadGroupSeq() throws Exception;
	 */
	
	//로그인Hist seq
	public long selectLoginNo() throws Exception;
	
	//로그인 기록 생성
	public void createLoginHist(LogionHistVo logionHistVo) throws Exception;
	
}