package mes.service.tm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.persistence.tm.InventoryAdmDAO;

@Service
public class InventoryAdmServiceImpl implements InventoryAdmService {

	@Inject
	private InventoryAdmDAO dao;

	//재고관리 재고실사및조정(창고위치별) 목록조회 
	@Override
	public List<MatrlInOutWhsAdmVo> tmInspectAdjustList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmInspectAdjustList(matrlInOutWhsAdmVo);
	}

	//재고관리 재고실사및조정(창고위치별) 목록조회 
	@Override
	public List<MatrlInOutWhsAdmVo> tmByMatrlTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByMatrlTypeList(matrlInOutWhsAdmVo);
	}
	
	//재고관리 입고량조정 수정
	@Override
	public void updateInspectAdjust(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		dao.updateInspectAdjust(matrlInOutWhsAdmVo);
	}
	
	
	//재고관리 자재보류상태 수정
	@Override
	public void updateHoldStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		dao.updateHoldStatus(matrlInOutWhsAdmVo);
	}
	
	//재고관리 적정재고관리
	@Override
	public  List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByMatrlBaseInventoryList(matrlInOutWhsAdmVo);
	}
	
	//재고관리 적정재고관리 상세
	@Override
	public  List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByMatrlBaseInventoryDtlList(matrlInOutWhsAdmVo);
	}
	
	//재고관리 재고현황관리(자재)
	public  List<MatrlInOutWhsAdmVo> tmByMatrlInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByMatrlInventoryList(matrlInOutWhsAdmVo);
	}
	
	//재고관리 재고현황관리(자재상세)
	public  List<MatrlInOutWhsAdmVo> tmByMatrlInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByMatrlInventoryDtlList(matrlInOutWhsAdmVo);
	}	
	
	//재고관리 전체재고 excel다운
	public  List<MatrlInOutWhsAdmVo> matrlInventorylList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.matrlInventorylList(matrlInOutWhsAdmVo);
	}
	
	//제품(월재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsMonthInventoryList(matrlInOutWhsAdmVo);
	}
	
	//제품(월재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsMonthInventoryDtlList(matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsInventoryList(matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsInventoryDtlList(matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsInventoryListChecked(matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.tmByGoodsInventoryDtlListChecked(matrlInOutWhsAdmVo);
	}
}

	