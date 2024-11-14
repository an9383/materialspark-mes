package mes.persistence.wm;

import java.util.List;

import mes.domain.wm.LotTraceVo;

public interface LotTraceDAO {

	//포장별 작지투입 자재정보 조회
	public List<LotTraceVo> workOrdMatrlList(LotTraceVo lotTraceVo) throws Exception;
	
	//작지 자재투입 생산진행 상세내역 조회
	public List<LotTraceVo> workOrdMatrlDtlList(LotTraceVo lotTraceVo) throws Exception;
	
}
