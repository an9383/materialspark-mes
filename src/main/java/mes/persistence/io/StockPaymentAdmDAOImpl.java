package mes.persistence.io;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.WorkOrderVo;

@Repository
public class StockPaymentAdmDAOImpl implements StockPaymentAdmDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.io.StockPaymentAdmMapper";
	
	//수불 이력(자재&제품
	@Override
	public List<StockPaymentAdmVo> readStockPaymentAdmList(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{		
		return session.selectList(namespace + ".readStockPaymentAdmList", stockPaymentAdmVo);
	}
	
	//수불 +
	@Override
	public void stockPaymentPlus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{		
		session.insert(namespace + ".stockPaymentPlus", stockPaymentAdmVo);
	}

	//수불 -
	@Override
	public void stockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{		
		session.insert(namespace + ".stockPaymentMinus", stockPaymentAdmVo);
	}
	
	//작지 생산 제외
	@Override
	public void workOrdStockPaymentPuls(WorkOrderVo workOrderVo) throws Exception{		
		session.insert(namespace + ".workOrdStockPaymentPuls", workOrderVo);
	}

	//작지 생산투입
	@Override
	public void workOrdStockPaymentMinus(WorkOrderVo workOrderVo) throws Exception{		
		session.insert(namespace + ".workOrdStockPaymentMinus", workOrderVo);
	}
	
	//수불 - 검사완료제품 포장대기시 사용(사용자가 포장수량 직접입력하기 때문에)
	@Override
	public void goodUnpackStockPaymentMinus(StockPaymentAdmVo stockPaymentAdmVo) throws Exception{		
		session.insert(namespace + ".goodUnpackStockPaymentMinus", stockPaymentAdmVo);
	}
	
}