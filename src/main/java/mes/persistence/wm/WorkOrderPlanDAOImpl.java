package mes.persistence.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.MonthProductPresentVo;
import mes.domain.wm.ProductionPlanVo;
import mes.domain.wm.WorkOrderPlanVo;

@Repository
public class WorkOrderPlanDAOImpl implements WorkOrderPlanDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.workOrderPlanMapper";
	
	//공정실적관리(POP)/작업지시선택 - 작업지시 동적추가
	@Override
	public WorkOrderPlanVo readWorkOrderPlan(WorkOrderPlanVo workOrderPlanVo) throws Exception{
		return session.selectOne(namespace+".readWorkOrderPlan", workOrderPlanVo);
	}
	
	//해당 설비&해당날짜 주간조 조회
	@Override
	public WorkOrderPlanVo searchDay(WorkOrderPlanVo Vo) throws Exception{
		return session.selectOne(namespace+".searchDay", Vo);
	}
	
	//해당 설비&해당날짜 야간조 조회
	@Override
	public WorkOrderPlanVo searchNight(WorkOrderPlanVo Vo) throws Exception{
		return session.selectOne(namespace+".searchNight", Vo);
	}

	//해당 설비&해당날짜 작업지시 등록
	@Override
	public void create(WorkOrderPlanVo Vo) throws Exception{
		session.insert(namespace+".create", Vo);
	}
	
	//해당 설비&해당날짜 작업지시 수정
	@Override
	public void update(WorkOrderPlanVo Vo) throws Exception{
		session.update(namespace+".update", Vo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록
	@Override
	public void workPlanAutoCreate(WorkOrderPlanVo Vo) throws Exception{
		session.insert(namespace+".workPlanAutoCreate", Vo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	@Override
	public void workPlanAutoDelete(WorkOrderPlanVo Vo) throws Exception{
		session.delete(namespace+".workPlanAutoDelete", Vo);
	}
	
	//생산계획(확정,운영 계획수량) 조회
	@Override
	public List<ProductionPlanVo> readProductionPlan(ProductionPlanVo productionPlanVo) throws Exception{
		return session.selectList(namespace+".readProductionPlan", productionPlanVo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	@Override
	public void createProductionPlan(ProductionPlanVo productionPlanVo) throws Exception{
		session.insert(namespace+".createProductionPlan", productionPlanVo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	@Override
	public void deleteProductionPlan(ProductionPlanVo productionPlanVo) throws Exception{
		session.delete(namespace+".deleteProductionPlan", productionPlanVo);
	}
	
	//월별 FP현황 조회(List)
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return session.selectList(namespace+".readMonthProductPresentBody", monthProductPresentVo);
	}

	//사용자 선택 날짜의 작지계획 생성
	@Override
	public void chooseWorkPlanAutoCreate(WorkOrderPlanVo workOrderPlanVo) throws Exception{
		session.insert(namespace+".chooseWorkPlanAutoCreate", workOrderPlanVo);
	}
	
	//사용자 선택 날짜의 작지계획 존재시 삭제
	@Override
	public void chooseWorkPlanAutoDelete(WorkOrderPlanVo workOrderPlanVo) throws Exception{
		session.delete(namespace+".chooseWorkPlanAutoDelete", workOrderPlanVo);
	}
	
	//해당설비&일자의 작지계획 목록
	@Override
	public List<WorkOrderPlanVo> equipWorkOrdPlanList(WorkOrderPlanVo workOrderPlanVo) throws Exception{
		return session.selectList(namespace+".equipWorkOrdPlanList", workOrderPlanVo);
	}
	
	//생산계획 (확정,운영,CAPA,수율(AL),수율(NI)) 조회
	@Override
	public List<Map<String,String>> readProductionPlanNew(ProductionPlanVo productionPlanVo) throws Exception{
		return session.selectList(namespace+".readProductionPlanNew", productionPlanVo);
	}
	
	//메모 등록
	@Override
	public void memoCreate(MonthProductPresentVo monthProductPresentVo) throws Exception{
		session.update(namespace+".memoCreate", monthProductPresentVo);
	}
	
	//메모 삭제
	@Override
	public void memoDelete(MonthProductPresentVo monthProductPresentVo) throws Exception{
		session.delete(namespace+".memoDelete", monthProductPresentVo);
	}
	
	//메모 수정
	@Override
	public void memoUpdate(MonthProductPresentVo monthProductPresentVo) throws Exception{
		session.insert(namespace+".memoUpdate", monthProductPresentVo);
	}
	
	//월별 FP현황 조회 (메모)
	@Override
	public MonthProductPresentVo memoList(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return session.selectOne(namespace+".memoList", monthProductPresentVo);
	}
	
	//월별 FP현황 조회(List) 요약본 1
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody2(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return session.selectList(namespace+".readMonthProductPresentBody2", monthProductPresentVo);
	}
	
	//월별 FP현황 조회(List) 요약본 2
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody3(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return session.selectList(namespace+".readMonthProductPresentBody3", monthProductPresentVo);
	}
	
	//월별 FP현황 조회 헤더만(List)
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBodyHeaderOnly(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return session.selectList(namespace+".readMonthProductPresentBodyHeaderOnly", monthProductPresentVo);
	}
	
}