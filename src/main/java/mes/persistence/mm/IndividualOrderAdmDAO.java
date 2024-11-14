package mes.persistence.mm;

import java.util.List;

import mes.domain.mm.IndividualOrderAdmVo;

public interface IndividualOrderAdmDAO {

	//발주관리 목록조회
	public List<IndividualOrderAdmVo> individualOrderAdmList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주관리 부품정보 목록조회
	public List<IndividualOrderAdmVo> individualOrderDtlList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주관리 등록
	public void individualOrderAdmCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//부품정보 등록
	public void purchaseOrderDtlCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주금액 수정 
	public void partAmtUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//부품정보 삭제
	public void individualOrderDtlDelete(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주번호 생성
	public String getPoNo(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//부품정보 시퀀스 생성
	public Integer getPoSeq(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주상태 수정(발주예정일<=발주수량)
	public void poStatusYUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
	//발주예정수량과 발주수량 비교
	public IndividualOrderAdmVo compareOrderQty(IndividualOrderAdmVo individualOrderAdmVo) throws Exception;
	
}
