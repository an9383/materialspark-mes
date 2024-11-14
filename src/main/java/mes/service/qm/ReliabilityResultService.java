package mes.service.qm;

import java.util.List;

import mes.domain.qm.ReliabilityResultVo;

public interface ReliabilityResultService {
	
	//신뢰성 결과 전체조회
	public List<ReliabilityResultVo> reliabilityResultList(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 실링 전체조회
	public List<ReliabilityResultVo> reliabilityResultShillingList(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 특정 Read(List)
	public List<ReliabilityResultVo> reliabilityResultSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception;

	//신뢰성결과 전체 등록
	public void reliabilityResultCreate(ReliabilityResultVo reliabilityResultVo) throws Exception;

	//신뢰성결과 (실링) 등록
	public void reliabilityResultShillingCreate(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성결과 (실링) 삭제
	public void reliabilityResultShillingDelete(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 전체 수정
	public void reliabilityResultUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 삭제
	public void reliabilityResultDelete(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 시퀀스 생성
	public String getTrustSeq(String date) throws Exception;
	
	
	//신뢰성 결과 특정 사진 Read(List)
	public List<ReliabilityResultVo> reliabilityPhotoSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 특정 사진 Read
	public ReliabilityResultVo reliabilityPhotoRead(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 사진 전체 등록
	public void reliabilityPhotoCreate(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 사진 수정
	public void reliabilityPhotoUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 공백 사진 삭제시 SEQ 다시 채번
	public void trustPhotoSeqUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 결과 사진 삭제
	public void reliabilityPhotoDelete(ReliabilityResultVo reliabilityResultVo) throws Exception;
	
	//신뢰성 사진 시퀀스 생성
	public String getTrustPhotoSeq(String searchCondition) throws Exception;
	
}
