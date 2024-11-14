package mes.service.qm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.ReliabilityLeakageResultVo;
import mes.persistence.qm.ReliabilityLeakageResultDAO;

@Service
public class ReliabilityLeakageResultServiceImpl implements ReliabilityLeakageResultService {

	@Inject
	private ReliabilityLeakageResultDAO dao;

	//Leakage Dstry 결과 전체조회
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		return dao.reliabilityLeakageResultList(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 등록 목록
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultCreateList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		return dao.reliabilityLeakageResultCreateList(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 목록 상세
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultReadList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		return dao.reliabilityLeakageResultReadList(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 목록조회
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultDtlList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return dao.reliabilityLeakageResultDtlList(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 비고 수정
	@Override
	public void reliabilityLeakageDtlResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		dao.reliabilityLeakageDtlResultUpdate(reliabilityLeakageResultVo);
	}

	//Leakage Dstry 전체 등록
	@Override
	public void reliabilityLeakageResultCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		dao.reliabilityLeakageResultCreate(reliabilityLeakageResultVo);
	}

	//Leakage Dstry 수정
	@Override
	public void reliabilityLeakageResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		dao.reliabilityLeakageResultUpdate(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 삭제
	@Override
	public void reliabilityLeakageResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		dao.reliabilityLeakageResultDelete(reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 삭제
	@Override
	public void reliabilityLeakageDtlResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		dao.reliabilityLeakageDtlResultDelete(reliabilityLeakageResultVo);
	}
		
	//Leakage Dstry File Dtl 사진 등록
	@Override
	public void reliabilityPhotoCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		dao.reliabilityPhotoCreate(reliabilityLeakageResultVo);
	}
	
	
	//Leakage 결과 시퀀스 생성
	public int reliabilityLeakageResultSeq(String searchCondition) throws Exception{
		return dao.reliabilityLeakageResultSeq(searchCondition);
	}
	
	// Dstry 결과 시퀀스 생성
	public int reliabilityDstryResultSeq(String searchCondition) throws Exception{
		return dao.reliabilityDstryResultSeq(searchCondition);
	}
	
	//REG_SEQ 시퀀스 생성
	public int regSeq(String searchCondition) throws Exception{
		return dao.regSeq(searchCondition);
	}
	
	//LeakageDtl 시퀀스 생성
	public int reliabilityLeakageDtlResultSeq(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return dao.reliabilityLeakageDtlResultSeq(reliabilityLeakageResultVo);
	}
	
}
