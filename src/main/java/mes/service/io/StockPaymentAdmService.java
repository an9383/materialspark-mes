package mes.service.io;

import java.util.List;

import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.WorkOrderVo;

public interface StockPaymentAdmService {
	
	//수불 이력(자재&제품)
	public List<StockPaymentAdmVo> readStockPaymentAdmList(StockPaymentAdmVo stockPaymentAdmVo) throws Exception;
		
	//수불 Plus
	public void stockPaymentPlus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception;

	//수불 Minus
	public void stockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception;
	
    //작지 생산 제외
	public void workOrdStockPaymentPuls(WorkOrderVo workOrderVo) throws Exception;

	//작지 생산투입
	public void workOrdStockPaymentMinus(WorkOrderVo workOrderVo) throws Exception;
	
	//수불 - 검사완료제품 포장대기시 사용(사용자가 포장수량 직접입력하기 때문에)
	public void goodUnpackStockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception;
	
}