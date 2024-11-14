package mes.persistence.qm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ReliabilityLeakageResultVo;

@Repository
public class ReliabilityLeakageResultDAOImpl implements ReliabilityLeakageResultDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.reliabilityLeakageResultMapper";
	
	//Leakage Dstry 결과 전체조회
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityLeakageResultList", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 등록 목록
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultCreateList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityLeakageResultCreateList", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 목록 상세
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultReadList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityLeakageResultReadList", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 목록조회
	@Override
	public List<ReliabilityLeakageResultVo> reliabilityLeakageResultDtlList(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityLeakageResultDtlList", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 비고 수정
	@Override
	public void reliabilityLeakageDtlResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception {
		session.update(namespace+".reliabilityLeakageDtlResultUpdate", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 삭제
	@Override
	public void reliabilityLeakageDtlResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		session.delete(namespace+".reliabilityLeakageDtlResultDelete", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 전체 등록
	@Override
	public void reliabilityLeakageResultCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		session.insert(namespace+".reliabilityLeakageResultCreate", reliabilityLeakageResultVo);
	}

	//Leakage Dstry 수정
	@Override
	public void reliabilityLeakageResultUpdate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		session.update(namespace+".reliabilityLeakageResultUpdate", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry 삭제
	@Override
	public void reliabilityLeakageResultDelete(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		session.delete(namespace+".reliabilityLeakageResultDelete", reliabilityLeakageResultVo);
	}
	
	//Leakage Dstry File Dtl 사진 등록
	@Override
	public void reliabilityPhotoCreate(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		session.insert(namespace+".reliabilityPhotoCreate", reliabilityLeakageResultVo);
	}
	
	//Leakage 시퀀스 생성
	public int reliabilityLeakageResultSeq(String searchCondition) throws Exception{
		return session.selectOne(namespace +".reliabilityLeakageResultSeq" , searchCondition);
	}
	
	//Dstry 시퀀스 생성
	public int reliabilityDstryResultSeq(String searchCondition) throws Exception{
		return session.selectOne(namespace +".reliabilityDstryResultSeq" , searchCondition);
	}
	
	//REG_SEQ 시퀀스 생성
	public int regSeq(String searchCondition) throws Exception{
		return session.selectOne(namespace +".regSeq" , searchCondition);
	}
	
	//LeakageDtl 시퀀스 생성
	public int reliabilityLeakageDtlResultSeq(ReliabilityLeakageResultVo reliabilityLeakageResultVo) throws Exception{
		return session.selectOne(namespace +".reliabilityLeakageDtlResultSeq" , reliabilityLeakageResultVo);
	}
	
}