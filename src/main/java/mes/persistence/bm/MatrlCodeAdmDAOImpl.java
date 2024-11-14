package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.MatrlCodeAdmVo;

@Repository
public class MatrlCodeAdmDAOImpl implements MatrlCodeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.bm.matrlCodeAdmMapper";

	//자재코드관리 목록조회
	@Override
	public List<MatrlCodeAdmVo> listAll(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		return session.selectList(namespace + ".listAll", matrlCodeAdmVo);
	}
	
	//자재코드&명 리스트
	@Override
	public List<MatrlCodeAdmVo> matrlCdList(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		return session.selectList(namespace + ".matrlCdList", matrlCodeAdmVo);
	}
	
	//자재코드관리 상세조회
	@Override
	public MatrlCodeAdmVo read(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {		
		return session.selectOne(namespace + ".read", matrlCodeAdmVo);
	}
		
	//자재코드관리 등록
	@Override
	public void create(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		session.insert(namespace + ".create", matrlCodeAdmVo);
	}

	//자재코드관리 수정	
	@Override
	public void update(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {
		session.update(namespace + ".update", matrlCodeAdmVo);
	}

	//자재코드관리 코드시퀀스조회	
	@Override
	public String selectMatrlSeqCd() throws Exception{
		return session.selectOne(namespace + ".selectMatrlSeqCd");
	}	
	
	//자재코드관리 중복검사진행
	@Override
	public MatrlCodeAdmVo matrlCodeDupliCheck(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception {		
		return session.selectOne(namespace + ".matrlCodeDupliCheck", matrlCodeAdmVo);
	}

}
