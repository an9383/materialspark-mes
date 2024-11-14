package mes.persistence.bm;

import java.util.List;
import java.util.Map;

import mes.domain.bm.InspectInfoAdmVo;


public interface InspectInfoAdmDAO {
	
	//품질정보관리 상세조회
	public InspectInfoAdmVo read(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 등록 
	public void create(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수정
	public void update(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 상세조회
	public InspectInfoAdmVo read2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 등록 
	public void create2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 수정
	public void update2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질관리 수입검사현황(qmsc0100)
	public List<Map<String,String>> inspectListRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질관리 수입검사현황(qmsc0100) 3공장
	public List<Map<String,String>> inspectListReadFac3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 상세조회
	public List<InspectInfoAdmVo> read3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 상세조회(SLD)
	public List<InspectInfoAdmVo> read3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 등록 
	public void create3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 등록(SLD) 
	public void create3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 수정
	public void update3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 수정(SLD)
	public void update3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 수정(SLD)
	public void update4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//idx조회
	public InspectInfoAdmVo selectIdx(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 상세조회
	public InspectInfoAdmVo read4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 상세조회(SLD)
	public InspectInfoAdmVo read4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 등록 
	public void create4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 등록 (SLD)
	public void create4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 수정
	public void update4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 삭제(상단)
	public void delete1(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
		
	//품질정보관리 수입검사 삭제(하단)
	public void delete2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 삭제(합불판정)
	public void deletePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;	
	
	//품질정보관리 수입검사 합격여부 등록 
	public void createPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 합격여부 수정
	public void updatePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 수입검사 합격여부 조회
	public List<InspectInfoAdmVo> listPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질관리 수입검사현황 자재명 List 조회
	public List<InspectInfoAdmVo> inspectMatrlCodeList(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 상세조회(자재코드별 조회)
	public InspectInfoAdmVo dtlRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 상세조회 - 자재코드에 맞는 데이터 없는 경우에 기존 데이터 조회
	public InspectInfoAdmVo dtlReadWithoutMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 상세(자재코드별) 등록 
	public void dtlCreate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 상세(자재코드별) 수정
	public void dtlUpdate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception;
	
	//품질정보관리 
	
}