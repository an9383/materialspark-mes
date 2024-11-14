package mes.persistence.wm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.LotTraceVo;

@Repository
public class LotTraceDAOImpl implements LotTraceDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.lotTraceMapper";
	
	//포장별 작지투입 자재정보 조회
	@Override
	public List<LotTraceVo> workOrdMatrlList(LotTraceVo lotTraceVo) throws Exception{
		
		//자재 바코드로 검색할 경우
		if(lotTraceVo.getLotNo() != null && !"".equals(lotTraceVo.getLotNo())) {
			return session.selectList(namespace+".workOrdMatrlBarcodeNoList", lotTraceVo);
			
		//작업지시나 생산LotNo로 검색할경우
		} else if(lotTraceVo.getWorkOrdNo() != null && !"".equals(lotTraceVo.getWorkOrdNo()) || lotTraceVo.getOrdLotNo() != null && !"".equals(lotTraceVo.getOrdLotNo())) {
			return session.selectList(namespace+".matrlByWorkOrdList", lotTraceVo);
		
		//제품 박스 포장번호로 검색 할 경우
		} else {
			return session.selectList(namespace+".workOrdMatrlList", lotTraceVo);
		}
	}
	
	//작지 자재투입 생산진행 상세내역 조회
	@Override
	public  List<LotTraceVo> workOrdMatrlDtlList(LotTraceVo lotTraceVo) throws Exception{
		return session.selectList(namespace+".workOrdMatrlDtlList", lotTraceVo);
	}

}