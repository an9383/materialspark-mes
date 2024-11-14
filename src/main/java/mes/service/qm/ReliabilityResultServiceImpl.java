package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.ReliabilityResultVo;
import mes.persistence.qm.ReliabilityResultDAO;

@Service
public class ReliabilityResultServiceImpl implements ReliabilityResultService {

	@Inject
	private ReliabilityResultDAO dao;

	//신뢰성 결과 전체조회
	@Override
	public List<ReliabilityResultVo> reliabilityResultList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		return dao.reliabilityResultList(reliabilityResultVo);
	}
	
	//신뢰성 실링 전체조회
	@Override
	public List<ReliabilityResultVo> reliabilityResultShillingList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		return dao.reliabilityResultShillingList(reliabilityResultVo);
	}
	
	//신뢰성 결과 특정 Read(List)
	@Override
	public List<ReliabilityResultVo> reliabilityResultSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		return dao.reliabilityResultSelectList(reliabilityResultVo);
	}

	//신뢰성결과 전체 등록
	@Override
	public void reliabilityResultCreate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityResultCreate(reliabilityResultVo);
	}

	//신뢰성결과 (실링) 등록
	@Override
	public void reliabilityResultShillingCreate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityResultShillingCreate(reliabilityResultVo);
	}

	//신뢰성결과 (실링) 삭제
	@Override
	public void reliabilityResultShillingDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityResultShillingDelete(reliabilityResultVo);
	}

	//신뢰성 결과 전체 수정
	@Override
	public void reliabilityResultUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityResultUpdate(reliabilityResultVo);
	}
	
	//신뢰성 결과 삭제
	@Override
	public void reliabilityResultDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityResultDelete(reliabilityResultVo);
	}

	//가입고 시퀀스 생성
	public String getTrustSeq(String date) throws Exception{
		return dao.getTrustSeq(date);
	}
	
	
	//신뢰성 결과 특정 사진 Read(List)
	@Override
	public List<ReliabilityResultVo> reliabilityPhotoSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception {
		return dao.reliabilityPhotoSelectList(reliabilityResultVo);
	}
	
	//신뢰성 결과 특정 사진 Read
	@Override
	public ReliabilityResultVo reliabilityPhotoRead(ReliabilityResultVo reliabilityResultVo) throws Exception {
		return dao.reliabilityPhotoRead(reliabilityResultVo);
	}
	
	//신뢰성 사진 전체 등록
	@Override
	public void reliabilityPhotoCreate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityPhotoCreate(reliabilityResultVo);
	}
	
	//신뢰성 결과 사진 수정
	@Override
	public void reliabilityPhotoUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityPhotoUpdate(reliabilityResultVo);
	}
	
	//신뢰성 결과 공백 사진 삭제시 SEQ 다시 채번
	@Override
	public void trustPhotoSeqUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.trustPhotoSeqUpdate(reliabilityResultVo);
	}
	
	//신뢰성 결과 사진 삭제
	@Override
	public void reliabilityPhotoDelete(ReliabilityResultVo reliabilityResultVo) throws Exception {
		dao.reliabilityPhotoDelete(reliabilityResultVo);
	}
	
	//신뢰성 사진 시퀀스 생성
	public String getTrustPhotoSeq(String searchCondition) throws Exception{
		return dao.getTrustPhotoSeq(searchCondition);
	}
	
}
