package mes.persistence.tm;

import java.util.List;

import mes.domain.io.MatrlInOutWhsAdmVo;

public interface InventoryAdmDAO {

	//재고관리 재고실사및조정(창고위치별) 목록조회 
	public List<MatrlInOutWhsAdmVo> tmInspectAdjustList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;

	//재고관리 품목별 목록조회
	public List<MatrlInOutWhsAdmVo> tmByMatrlTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 입고량조정 수정
	public void updateInspectAdjust(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 자재보류상태 수정
	public void updateHoldStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 적정재고관리
	public List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 적정재고관리 상세
	public List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 재고현황관리(자재)
	public List<MatrlInOutWhsAdmVo> tmByMatrlInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 재고현황관리(자재상세)
	public List<MatrlInOutWhsAdmVo> tmByMatrlInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//재고관리 전체재고 excel다운
	public List<MatrlInOutWhsAdmVo> matrlInventorylList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품(월재고현황)
	public List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품(월재고현황) 상세
	public List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
		
	//제품(일재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품(일재고현황) 체크
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	
}