package mes.persistence.mm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.mm.IndividualOrderAdmVo;

@Repository
public class IndividualOrderAdmDAOImpl implements IndividualOrderAdmDAO {

	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.mm.individualOrderAdmMapper";
	
	//발주관리 목록조회
	@Override
	public List<IndividualOrderAdmVo> individualOrderAdmList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		return session.selectList(namespace + ".individualOrderAdmList",individualOrderAdmVo);
	}
	
	//발주관리 부품정보 목록조회
	public List<IndividualOrderAdmVo> individualOrderDtlList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		return session.selectList(namespace +".individualOrderDtlList" , individualOrderAdmVo);
	}
	
	//발주관리 등록
	@Override
	public void individualOrderAdmCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		session.insert(namespace+".individualOrderAdmCreate" , individualOrderAdmVo);
	}
	
	//부품정보 등록
	public void purchaseOrderDtlCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		session.insert(namespace+".purchaseOrderDtlCreate",individualOrderAdmVo);
	}
	
	//발주금액 수정 
	public void partAmtUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		session.update(namespace+".partAmtUpdate" , individualOrderAdmVo);
	}
	
	//부품정보 삭제
	public void individualOrderDtlDelete(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		session.delete(namespace+".individualOrderDtlDelete",individualOrderAdmVo);
	}
	
	@Override
	public String getPoNo(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		return session.selectOne(namespace+".getPoNo", individualOrderAdmVo);
	}
	
	//부품정보 시퀀스 생성
	public Integer getPoSeq(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		return session.selectOne(namespace+".getPoSeq", individualOrderAdmVo);
	}
	
	//발주예정수량과 발주수량 비교
	public IndividualOrderAdmVo compareOrderQty(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		return session.selectOne(namespace+".compareOrderQty" , individualOrderAdmVo);
	}

	//발주상태 수정(발주예정일<=발주수량)
	public void poStatusYUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		session.update(namespace+".poStatusYUpdate" , individualOrderAdmVo);
	}

}
