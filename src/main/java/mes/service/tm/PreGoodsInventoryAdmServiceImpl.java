package mes.service.tm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.tm.PreGoodsInventoryAdmVo;
import mes.persistence.tm.PreGoodsInventoryAdmDAO;

@Service
public class PreGoodsInventoryAdmServiceImpl implements PreGoodsInventoryAdmService {

	@Inject
	private PreGoodsInventoryAdmDAO dao;

	//선처리재고관리정보 목록조회
	@Override
	public List<PreGoodsInventoryAdmVo> listPreInvntryAll(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.listPreInvntryAll(preGoodsInventoryAdmVo);
	}

	//선처리재고관리정보 상세조회
	@Override
	public PreGoodsInventoryAdmVo preRead(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.preRead(preGoodsInventoryAdmVo);	
	}
	
	//선처리재고관리정보 등록
	@Override
	public void preCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preCreate(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 수정
	@Override
	public void preUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preUpdate(preGoodsInventoryAdmVo);
	}
	
	//제품(초기재고) Dtl 특정BoxNo 삭제
	@Override
	public void preDtlDelete(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preDtlDelete(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 출고전문시퀀스
	@Override
	public String selectSlipSeq(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.selectSlipSeq(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 출고이력목록조회
	@Override
	public List<PreGoodsInventoryAdmVo> listInvntryOutputHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.listInvntryOutputHist(preGoodsInventoryAdmVo);
	}

	//선처리재고관리정보 출고이력상세조회
	@Override
	public PreGoodsInventoryAdmVo preReadOutputHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.preReadOutputHist(preGoodsInventoryAdmVo);	
	}
	
	//선처리재고관리정보 출고이력등록
	@Override
	public void preOutputHistCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preOutputHistCreate(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 출고이력수정
	@Override
	public void preOutputHistUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preOutputHistUpdate(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 제품재고정보목록조회
	@Override
	public List<PreGoodsInventoryAdmVo> listGoodsInvntryInfo(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.listGoodsInvntryInfo(preGoodsInventoryAdmVo);	
	}
	
	//선처리재고관리정보 출고정보수정
	@Override
	public void preOutputUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preOutputUpdate(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 출고이력상세조회
	@Override
	public List<PreGoodsInventoryAdmVo> listInvntryOutputDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.listInvntryOutputDtl(preGoodsInventoryAdmVo);
	}
	
	//선처리재고관리정보 출고이력등록
	@Override
	public void preOutputDtlCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preOutputDtlCreate(preGoodsInventoryAdmVo);
	}
	
	//초기재고관리 Al제품 시퀀스 조회
	@Override
	public int selectPreGoodsPackSeqAl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.selectPreGoodsPackSeqAl(preGoodsInventoryAdmVo);
	}
	
	//초기재고관리 Nicu제품 시퀀스 조회
	@Override
	public int selectPreGoodsPackSeqNicu(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.selectPreGoodsPackSeqNicu(preGoodsInventoryAdmVo);
	}
	
	//초기재고 제품 DTL 등록
	@Override
	public void preGoodsPackDtlCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preGoodsPackDtlCreate(preGoodsInventoryAdmVo);
	}
	
	//초기재고 제품 DTL 삭제
	@Override
	public void preGoodsPackDtlDelete(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.preGoodsPackDtlDelete(preGoodsInventoryAdmVo);
	}
	
	//재고제품DTL 목록조회
	@Override
	public List<PreGoodsInventoryAdmVo> preGoodsInventoryDtlList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception{
		return dao.preGoodsInventoryDtlList(preGoodsInventoryAdmVo);
	}
	
	//boxNo로 재고제품 조회
	@Override
	public List<PreGoodsInventoryAdmVo> tracePurchaseBoxNo(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		return dao.tracePurchaseBoxNo(preGoodsInventoryAdmVo);	
	}
	
	//재고제품 불량상태 변경
	@Override
	public void changePreGoodsProductFaultyType(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.changePreGoodsProductFaultyType(preGoodsInventoryAdmVo);
	}
	
	//재고제품 Hist 생성
	@Override
	public void insertPreGoodsProductHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.insertPreGoodsProductHist(preGoodsInventoryAdmVo);
	}
	
	//재고제품이력 삭제
	@Override
	public void deletePreGoodsProductHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception {
		dao.deletePreGoodsProductHist(preGoodsInventoryAdmVo);
	}
	
}