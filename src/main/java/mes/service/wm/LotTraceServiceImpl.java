package mes.service.wm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.LotTraceVo;
import mes.persistence.wm.LotTraceDAO;

@Service
public class LotTraceServiceImpl implements LotTraceService {

	@Inject
	private LotTraceDAO dao;

	//포장별 작지투입 자재정보 조회
	@Override
	public List<LotTraceVo> workOrdMatrlList(LotTraceVo lotTraceVo) throws Exception{
		return dao.workOrdMatrlList(lotTraceVo);
	}
	
	//작지 자재투입 생산진행 상세내역 조회
	@Override
	public  List<LotTraceVo> workOrdMatrlDtlList(LotTraceVo lotTraceVo) throws Exception{
		return dao.workOrdMatrlDtlList(lotTraceVo);
	}
}
