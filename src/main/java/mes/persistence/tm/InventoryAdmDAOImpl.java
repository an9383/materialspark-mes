package mes.persistence.tm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.io.MatrlInOutWhsAdmVo;


@Repository
public class InventoryAdmDAOImpl implements InventoryAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.tm.InventoryAdmMapper";
	
	//재고관리 재고실사및조정(창고위치별) 목록조회 
	@Override
	public List<MatrlInOutWhsAdmVo> tmInspectAdjustList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmInspectAdjustList", matrlInOutWhsAdmVo);
	}

	//재고관리 품목별 목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> tmByMatrlTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByMatrlTypeList", matrlInOutWhsAdmVo);
	}
	
	//재고관리 입고량조정 수정
	@Override
	public void updateInspectAdjust(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace+".updateInspectAdjust", matrlInOutWhsAdmVo);
	}
	
	//재고관리 자재보류상태 수정
	@Override
	public void updateHoldStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace+".updateHoldStatus", matrlInOutWhsAdmVo);
	}
	
	//재고관리 적정재고관리
	@Override
	public List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByMatrlBaseInventoryList", matrlInOutWhsAdmVo);
	}
	
	//재고관리 적정재고관리 상세
	@Override
	public List<MatrlInOutWhsAdmVo> tmByMatrlBaseInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByMatrlBaseInventoryDtlList", matrlInOutWhsAdmVo);
	}
	
	//재고관리 재고현황관리(자재)
	public List<MatrlInOutWhsAdmVo> tmByMatrlInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByMatrlInventoryList", matrlInOutWhsAdmVo);
	}
	
	//재고관리 재고현황관리(자재상세)
	public List<MatrlInOutWhsAdmVo> tmByMatrlInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByMatrlInventoryDtlList", matrlInOutWhsAdmVo);
	}

	//재고관리 전체재고 excel다운
	public List<MatrlInOutWhsAdmVo> matrlInventorylList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".matrlInventorylList", matrlInOutWhsAdmVo);
	}
	
	//제품(월재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsMonthInventoryList", matrlInOutWhsAdmVo);
	}
	
	//제품(월재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsMonthInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsMonthInventoryDtlList", matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황)
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsInventoryList", matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsInventoryDtlList", matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황) 체크
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsInventoryListChecked", matrlInOutWhsAdmVo);
	}
	
	//제품(일재고현황) 상세
	public  List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace+".tmByGoodsInventoryDtlListChecked", matrlInOutWhsAdmVo);
	}
	
}