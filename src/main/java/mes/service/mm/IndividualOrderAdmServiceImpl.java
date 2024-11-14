package mes.service.mm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.mm.IndividualOrderAdmVo;
import mes.persistence.mm.IndividualOrderAdmDAO;

@Service
public class IndividualOrderAdmServiceImpl implements IndividualOrderAdmService {

	@Inject
	private IndividualOrderAdmDAO dao;
	
	//발주관리 목록조회
	@Override
	public List<IndividualOrderAdmVo> individualOrderAdmList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		return dao.individualOrderAdmList(individualOrderAdmVo);
	}
	
	//발주관리 부품정보 목록조회
	public List<IndividualOrderAdmVo> individualOrderDtlList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		return dao.individualOrderDtlList(individualOrderAdmVo);
	}
	
	//발주관리 등록
	@Override
	public void individualOrderAdmCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		dao.individualOrderAdmCreate(individualOrderAdmVo);
	}
	
	//부품정보 등록
	public void purchaseOrderDtlCreate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		dao.purchaseOrderDtlCreate(individualOrderAdmVo);
	}
	
	//발주금액 수정 
	public void partAmtUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		dao.partAmtUpdate(individualOrderAdmVo);
	}
	
	//부품정보 삭제
	public void individualOrderDtlDelete(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		dao.individualOrderDtlDelete(individualOrderAdmVo);
	}
	
	//발주번호 생성
	@Override
	public String getPoNo(IndividualOrderAdmVo individualOrderAdmVo) throws Exception {
		return dao.getPoNo(individualOrderAdmVo);
	}
	
	//부품정보 시퀀스 생성
	public Integer getPoSeq(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		return dao.getPoSeq(individualOrderAdmVo);
	}
	
	//발주예정수량과 발주수량 비교
	public IndividualOrderAdmVo compareOrderQty(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		 return dao.compareOrderQty(individualOrderAdmVo);
	}
	
	//발주상태 수정(발주예정일<=발주수량)
	public void poStatusYUpdate(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		dao.poStatusYUpdate(individualOrderAdmVo);
	}
	
}
