package mes.persistence.mm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.mm.InWhsAdmVo;

@Repository
public class InWhsAdmDAOImpl implements InWhsAdmDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.mm.inWhsAdmMapper";
	
	//가입고등록
	
	//가입고등록,개별입고등록 상세조회
	public List<InWhsAdmVo> preInWhsAdmList(InWhsAdmVo inWhsAdmVo) throws Exception{
		return session.selectList(namespace +".preInWhsAdmList" , inWhsAdmVo); 
	}

	//가입고등록 등록
	public void preInWhsAdmCreate(InWhsAdmVo inWhsAdmVo) throws Exception{
		session.insert(namespace +".preInWhsAdmCreate" , inWhsAdmVo);
	}
	
	//가입고등록 수정
	public void preInWhsAdmUpdate(InWhsAdmVo inWhsAdmVo) throws Exception{
		session.update(namespace +".preInWhsAdmUpdate", inWhsAdmVo);
	}


	//가입고등록 삭제
	public void preInWhsAdmDelete(InWhsAdmVo inWhsAdmVo) throws Exception{
		session.delete(namespace+".preInWhsAdmDelete" ,inWhsAdmVo );
	}
	
	//가입고 시퀀스 생성
	public String getInSeq(String dateTo) throws Exception{
		return session.selectOne(namespace +".getInSeq" , dateTo);
	}

	//바코드 시퀀스 가져오기
	public String getBarcodeSeq(String date) throws Exception{
		return session.selectOne(namespace+".getBarcodeSeq" , date);
	}
	
	//자재상태 확인
	public String statusCdCheck(InWhsAdmVo inWhsAdmVo) throws Exception{
		return session.selectOne(namespace +".statusCdCheck" , inWhsAdmVo);
	}
	
	
	//입고등록
	
	//입고등록 상세조회
	public InWhsAdmVo inWhsAdmRead(InWhsAdmVo inWhsAdmVo) throws Exception{
		return session.selectOne(namespace +".inWhsAdmRead" , inWhsAdmVo);
	}
	
	//입고등록 바코드 상세조회
	public InWhsAdmVo inWhsAdmBarcodeRead(InWhsAdmVo inWhsAdmVo) throws Exception{
		return session.selectOne(namespace +".inWhsAdmBarcodeRead" , inWhsAdmVo);
	}
	
	//입고등록 등록(가입고테이블 수정)
	public void inWhsAdmCreate(InWhsAdmVo inWhsAdmVo) throws Exception{
		session.update(namespace +".inWhsAdmCreate" , inWhsAdmVo);
	}

	
	//개별입고
	
	//개별입고 목록조회
	public List<InWhsAdmVo> individualAdmList(InWhsAdmVo inWhsAdmVo) throws Exception{
		return session.selectList(namespace+".individualAdmList" , inWhsAdmVo);
	}

	//개별입고 가상발주번호 생성
	public String getPoNo(String today) throws Exception{
		return session.selectOne(namespace+".getPoNo" ,today );
	}
}
