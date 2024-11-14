package mes.service.qm;

import java.util.List;
import java.util.Map;

import mes.domain.qm.ReliabilityLeakageResultVo;

public interface ReliabilityLeakageResultService {
	
	//Leakage Dstry 결과 전체조회
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
	
	//Leakage Dstry 등록 목록
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultCreateList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
	
	//Leakage Dstry 목록 상세
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultReadList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;

	//Leakage Dstry File Dtl 목록조회
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultDtlList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
		
	//Leakage Dstry File Dtl 비고 수정
	public void reliabilityLeakageDtlResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
	
	//Leakage Dstry 전체 등록
	public void reliabilityLeakageResultCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;

	//Leakage Dstry File Dtl 삭제
	public void reliabilityLeakageDtlResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
		
	//Leakage Dstry 수정
	public void reliabilityLeakageResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
	
	//Leakage Dstry 삭제
	public void reliabilityLeakageResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;

	//Leakage Dstry File Dtl 사진 등록
	public void reliabilityPhotoCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception;
	
	//Leakage  결과 시퀀스 생성
	public int reliabilityLeakageResultSeq(String searchCondition) throws Exception;
	
	// Dstry 결과 시퀀스 생성
	public int reliabilityDstryResultSeq(String searchCondition) throws Exception;
	
	//REG_SEQ 시퀀스 생성
	public int regSeq(String searchCondition) throws Exception;
	
	//LeakageDtl 시퀀스 생성
	public int reliabilityLeakageDtlResultSeq(ReliabilityLeakageResultVo reliabilityLeakageResultVon) throws Exception;
	
}
