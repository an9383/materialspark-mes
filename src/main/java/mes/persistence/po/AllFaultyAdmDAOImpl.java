package mes.persistence.po;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.AllFaultyAdmVo;

@Repository
public class AllFaultyAdmDAOImpl implements AllFaultyAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.po.allFaultyAdmMapper";

	/* 공정불량  */
	//공정불량 조회
	@Override
	public List<AllFaultyAdmVo> readPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readPrcssFaulty", allFaultyAdmVo);
	}
	
	//공정불량 조회(업데이트용)
	@Override
	public List<AllFaultyAdmVo> readUpdPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readUpdPrcssFaulty", allFaultyAdmVo);
	}
	
	//공정불량 상세조회
	@Override
	public AllFaultyAdmVo readDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return session.selectOne(namespace + ".readDtlPrcssFaulty", allFaultyAdmVo);
	}
	
	//공정불량 상세조회(업뎃용)
	@Override
	public AllFaultyAdmVo readUpdDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return session.selectOne(namespace + ".readUpdDtlPrcssFaulty", allFaultyAdmVo);
	}
	
	//테프론 목록 조회
	@Override
	public List<AllFaultyAdmVo> readPtfeFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return session.selectList(namespace + ".readPtfeFaulty", allFaultyAdmVo);
	}
	
	//공정불량 등록
	@Override
	public void createFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		session.insert(namespace + ".createFaultyAll", allFaultyAdmVo);
	}	 
	 
	//공정불량 수정
	@Override
	public void updateFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		session.update(namespace + ".updateFaultyAll", allFaultyAdmVo);
	}
	
	//공정불량 삭제
	@Override
	public void deleteFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		session.delete(namespace + ".deleteFaultyAll", allFaultyAdmVo);
	}
	
	//테프론 삭제
	@Override
	public void deletePtfe(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		session.delete(namespace + ".deletePtfe", allFaultyAdmVo);
	}

	
	/* 불량중량*/
	//불량중량 조회
	@Override
	public List<AllFaultyAdmVo> badWeightList(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".badWeightList", allFaultyAdmVo);
	}
	
	//작지 취소 시 등록된 불량중량이 있는지 확인
	@Override
	public List<AllFaultyAdmVo> cancelWorkOrdTotalFaultyCheck(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".cancelWorkOrdTotalFaultyCheck", allFaultyAdmVo);
	}
	
	//테프론 시퀀스
	@Override
	public AllFaultyAdmVo ptfeSeq(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return session.selectOne(namespace + ".ptfeSeq", allFaultyAdmVo);
	}
}