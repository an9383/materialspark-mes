package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.DealCorpAdmVo;


@Repository
public class DealCorpAdmDAOImpl implements DealCorpAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.dealCorpAdmMapper";
	
	//거래처정보관리 목록조회
	@Override
	public List<DealCorpAdmVo> listAll(DealCorpAdmVo dealCorpAdmVo) throws Exception{
		return session.selectList(namespace+".listAll", dealCorpAdmVo);
	}

	//거래처정보관리 상세조회
	@Override
	public DealCorpAdmVo read(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return session.selectOne(namespace+".read", dealCorpAdmVo);
	}
	
	//거래처정보관리 등록
	@Override
	public void create(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.insert(namespace+".create", dealCorpAdmVo);
	}
	
	//거래처정보관리 수정
	@Override
	public void update(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		session.update(namespace+".update", dealCorpAdmVo);
	}
	
	//거래처정보관리 거래처시퀀스코드
	@Override
	public String selectDealCorpSeqCd() throws Exception {
		return session.selectOne(namespace+".selectDealCorpSeqCd");
	}	
	
}