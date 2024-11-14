package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.AccidentFreeVo;


@Repository
public class AccidentFreeDAOImpl implements AccidentFreeDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.accidentFreeMapper";


	//무재해정보 조회
	@Override
	public List<AccidentFreeVo> listAll(AccidentFreeVo accidentFreeVo) throws Exception{
		return session.selectList(namespace+".listAll", accidentFreeVo);
	}
	
	//현수막정보 조회
	@Override
	public List<AccidentFreeVo> listImg(AccidentFreeVo accidentFreeVo) throws Exception{
		return session.selectList(namespace+".listImg", accidentFreeVo);
	}
	
	//무재해정보 조회
	@Override
	public AccidentFreeVo read(AccidentFreeVo accidentFreeVo) throws Exception{
		return session.selectOne(namespace+".read", accidentFreeVo);
	}
	
	//무재해정보 등록
	@Override
	public void create(AccidentFreeVo accidentFreeVo) throws Exception{
		session.insert(namespace+".create", accidentFreeVo);
	}
	
	//무재해정보 수정
	@Override
	public void update(AccidentFreeVo accidentFreeVo) throws Exception{
		session.update(namespace+".update", accidentFreeVo);
	}
	
	//현수막 이미지 등록
	@Override
	public void createImg(AccidentFreeVo accidentFreeVo) throws Exception{
		session.insert(namespace+".createImg", accidentFreeVo);
	}
	
	//현수막 이미지 등록 수정
	@Override
	public void updateImg(AccidentFreeVo accidentFreeVo) throws Exception{
		session.delete(namespace+".updateImg", accidentFreeVo);
	}
	
	//무재해 시퀀스 조회
	@Override
	public String selectIdx() throws Exception{
		return session.selectOne(namespace+".selectIdx");
	}
	
	//현수막 시퀀스 조회
	@Override
	public String selectIdxImg() throws Exception{
		return session.selectOne(namespace+".selectIdxImg");
	}
	
}
	
