package mes.persistence.tm;

import java.util.List;

import mes.domain.tm.PreGoodsInventoryAdmVo;

public interface PreGoodsInventoryAdmDAO {

	//선처리재고관리정보 목록조회
	public List<PreGoodsInventoryAdmVo> listPreInvntryAll(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 상세조회
	public PreGoodsInventoryAdmVo preRead(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 등록
	public void preCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 수정
	public void preUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;	
	
	//제품(초기재고) Dtl 특정BoxNo 삭제
	public void preDtlDelete(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;	
	
	//선처리재고관리정보 출고전문시퀀스
	public String selectSlipSeq(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;	
	
	//선처리재고관리정보 출고이력목록조회 
	public List<PreGoodsInventoryAdmVo> listInvntryOutputHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 출고이력상세조회
	public PreGoodsInventoryAdmVo preReadOutputHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 출고이력등록
	public void preOutputHistCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 출고이력수정
	public void preOutputHistUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;	
	
	//선처리재고관리정보 목록조회
	public List<PreGoodsInventoryAdmVo> listGoodsInvntryInfo(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 출고정보수정
	public void preOutputUpdate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;	
	
	//선처리재고관리정보 출고이력상세목록조회 
	public List<PreGoodsInventoryAdmVo> listInvntryOutputDtl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//선처리재고관리정보 출고이력상세등록
	public void preOutputDtlCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//초기재고관리 제품 시퀀스 조회
	public int selectPreGoodsPackSeqAl(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//초기재고관리 Al제품 시퀀스 조회
	public int selectPreGoodsPackSeqNicu(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//초기재고 제품 DTL 등록
	public void preGoodsPackDtlCreate(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//초기재고 제품 DTL 삭제
	public void preGoodsPackDtlDelete(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//재고제품DTL 목록조회
	public List<PreGoodsInventoryAdmVo> preGoodsInventoryDtlList(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//boxNo로 재고제품 조회
	public List<PreGoodsInventoryAdmVo> tracePurchaseBoxNo(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//재고제품 불량상태 변경
	public void changePreGoodsProductFaultyType(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//재고제품 Hist 생성
	public void insertPreGoodsProductHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
	//재고제품이력 삭제
	public void deletePreGoodsProductHist(PreGoodsInventoryAdmVo preGoodsInventoryAdmVo) throws Exception;
	
}