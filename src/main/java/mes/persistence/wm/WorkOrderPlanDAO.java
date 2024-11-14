package mes.persistence.wm;

import mes.domain.wm.WorkOrderPlanVo;

import java.util.List;
import java.util.Map;

import mes.domain.br.RawMatrlSupplyVo;
import mes.domain.wm.MonthProductPresentVo;
import mes.domain.wm.ProductionPlanVo;

public interface WorkOrderPlanDAO {
	
	//선택 제조조건 조회
	public WorkOrderPlanVo readWorkOrderPlan(WorkOrderPlanVo workOrderPlanVo) throws Exception;
	
	//해당 설비&해당날짜 주간조 조회
	public WorkOrderPlanVo searchDay(WorkOrderPlanVo Vo) throws Exception;
	
	//해당 설비&해당날짜 야간조 조회
	public WorkOrderPlanVo searchNight(WorkOrderPlanVo Vo) throws Exception;
	
	//해당 설비&해당날짜 작업지시 등록
	public void create(WorkOrderPlanVo Vo) throws Exception;
	
	//해당 설비&해당날짜 작업지시 수정
	public void update(WorkOrderPlanVo Vo) throws Exception;
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록
	public void workPlanAutoCreate(WorkOrderPlanVo Vo) throws Exception;
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	public void workPlanAutoDelete(WorkOrderPlanVo Vo) throws Exception;
	
	//생산계획(확정,운영 계획수량) 조회
	public List<ProductionPlanVo> readProductionPlan(ProductionPlanVo productionPlanVo) throws Exception;
	
	//생산계획 월별 등록
	public void createProductionPlan(ProductionPlanVo productionPlanVo) throws Exception;
	
	//생산계획 월별 삭제
	public void deleteProductionPlan(ProductionPlanVo productionPlanVo) throws Exception;
	
	//월별 FP현황 조회(List)
	public List<MonthProductPresentVo> readMonthProductPresentBody(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//사용자 선택 날짜의 작지계획 생성
	public void chooseWorkPlanAutoCreate(WorkOrderPlanVo workOrderPlanVo) throws Exception;
	
	//사용자 선택 날짜의 작지계획 존재시 삭제
	public void chooseWorkPlanAutoDelete(WorkOrderPlanVo workOrderPlanVo) throws Exception;
	
	//해당설비&일자의 작지계획 목록
	public List<WorkOrderPlanVo> equipWorkOrdPlanList(WorkOrderPlanVo Vo) throws Exception;
	
	//생산계획 (확정,운영,CAPA,수율(AL),수율(NI)) 조회
	public List<Map<String,String>> readProductionPlanNew(ProductionPlanVo productionPlanVo) throws Exception;
	
	//메모 등록
	public void memoCreate(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//메모 삭제
	public void memoDelete(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//메모 수정
	public void memoUpdate(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//월별 FP현황 조회 (메모)
	public MonthProductPresentVo memoList(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//월별 FP현황 조회(List) 요약본 1
	public List<MonthProductPresentVo> readMonthProductPresentBody2(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//월별 FP현황 조회(List) 요약본 2
	public List<MonthProductPresentVo> readMonthProductPresentBody3(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	//월별 FP현황 조회 헤더만(List)
	public List<MonthProductPresentVo> readMonthProductPresentBodyHeaderOnly(MonthProductPresentVo monthProductPresentVo) throws Exception;
	
	
	
}