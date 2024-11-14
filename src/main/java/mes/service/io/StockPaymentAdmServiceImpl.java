package mes.service.io;

import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.persistence.io.StockPaymentAdmDAO;

@Service
public class StockPaymentAdmServiceImpl implements StockPaymentAdmService{
	
	@Inject
	private StockPaymentAdmDAO dao;
	
	//수불 이력(자재&제품)
	@Override
	public List<StockPaymentAdmVo> readStockPaymentAdmList(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{
		return dao.readStockPaymentAdmList(stockPaymentAdmVo);
	}
	
	//수불 Insert
	@Override
	public void stockPaymentPlus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{
		dao.stockPaymentPlus(stockPaymentAdmVo);
	}
	
	//수불 Insert
	@Override
	public void stockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{
		dao.stockPaymentMinus(stockPaymentAdmVo);
	}
	
	//작지 생산 제외
	@Override
	public void workOrdStockPaymentPuls(WorkOrderVo workOrderVo) throws Exception{
		dao.workOrdStockPaymentPuls(workOrderVo);
	}
	
	//작지 생산투입
	@Override
	public void workOrdStockPaymentMinus(WorkOrderVo workOrderVo) throws Exception{
		dao.workOrdStockPaymentMinus(workOrderVo);
	}
	
	//수불 - 검사완료제품 포장대기시 사용(사용자가 포장수량 직접입력하기 때문에)
	@Override
	public void goodUnpackStockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{
		dao.goodUnpackStockPaymentMinus(stockPaymentAdmVo);
	}
	
}