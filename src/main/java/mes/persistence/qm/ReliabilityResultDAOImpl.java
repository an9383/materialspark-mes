package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ReliabilityResultVo;

@Repository
public class ReliabilityResultDAOImpl implements ReliabilityResultDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.qm.reliabilityResultMapper";
	
	//신뢰성 결과 전체조회
	@Override
	public List<ReliabilityResultVo> reliabilityResultList(ReliabilityResultVo reliabilityResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityResultList", reliabilityResultVo);
	}
	
	//신뢰성 실링 전체조회
	@Override
	public List<ReliabilityResultVo> reliabilityResultShillingList(ReliabilityResultVo reliabilityResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityResultShillingList", reliabilityResultVo);
	}
	
	//신뢰성 결과 특정 Read(List)
	@Override
	public List<ReliabilityResultVo> reliabilityResultSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityResultSelectList", reliabilityResultVo);
	}
	
	//신뢰성결과 전체 등록
	@Override
	public void reliabilityResultCreate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.insert(namespace+".reliabilityResultCreate", reliabilityResultVo);
	}

	//신뢰성결과 (실링) 등록
	@Override
	public void reliabilityResultShillingCreate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.insert(namespace+".reliabilityResultShillingCreate", reliabilityResultVo);
	}
	
	//신뢰성결과 (실링) 삭제
	@Override
	public void reliabilityResultShillingDelete(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.delete(namespace+".reliabilityResultShillingDelete", reliabilityResultVo);
	}
	
	//신뢰성 결과 전체 수정
	@Override
	public void reliabilityResultUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.update(namespace+".reliabilityResultUpdate", reliabilityResultVo);
	}
	
	//신뢰성 결과 삭제
	@Override
	public void reliabilityResultDelete(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.update(namespace+".reliabilityResultDelete", reliabilityResultVo);
	}
	
	//신뢰성 결과 시퀀스 생성
	public String getTrustSeq(String date) throws Exception{
		return session.selectOne(namespace +".getTrustSeq" , date);
	}
	
	
	//신뢰성 결과 특정 사진 Read(List)
	@Override
	public List<ReliabilityResultVo> reliabilityPhotoSelectList(ReliabilityResultVo reliabilityResultVo) throws Exception{
		return session.selectList(namespace+".reliabilityPhotoSelectList", reliabilityResultVo);
	}
	
	//신뢰성 결과 특정 사진 Read
	@Override
	public ReliabilityResultVo reliabilityPhotoRead(ReliabilityResultVo reliabilityResultVo) throws Exception{
		return session.selectOne(namespace+".reliabilityPhotoRead", reliabilityResultVo);
	}
	
	//신뢰성 사진 전체 등록
	@Override
	public void reliabilityPhotoCreate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.insert(namespace+".reliabilityPhotoCreate", reliabilityResultVo);
	}
	
	//신뢰성 결과 사진 수정
	@Override
	public void reliabilityPhotoUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.update(namespace+".reliabilityPhotoUpdate", reliabilityResultVo);
	}
	
	//신뢰성 결과 공백 사진 삭제시 SEQ 다시 채번
	@Override
	public void trustPhotoSeqUpdate(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.update(namespace+".trustPhotoSeqUpdate", reliabilityResultVo);
	}
	
	//신뢰성 결과 사진 삭제
	@Override
	public void reliabilityPhotoDelete(ReliabilityResultVo reliabilityResultVo) throws Exception{
		session.update(namespace+".reliabilityPhotoDelete", reliabilityResultVo);
	}
	
	//신뢰성 사진 시퀀스 생성
	public String getTrustPhotoSeq(String searchCondition) throws Exception{
		return session.selectOne(namespace +".getTrustPhotoSeq" , searchCondition);
	}
	
}