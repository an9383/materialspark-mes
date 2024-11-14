package mes.service.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;

import mes.domain.wm.MonthProductPresentVo;
import mes.domain.wm.ProductionPlanVo;
import mes.domain.wm.WorkOrderPlanVo;
import mes.persistence.wm.WorkOrderPlanDAO;

@Service
public class WorkOrderPlanServiceImpl implements WorkOrderPlanService {

	@Inject
	private WorkOrderPlanDAO dao;

	//해당 설비&해당날짜 주간조 조회
	@Override
	public WorkOrderPlanVo readWorkOrderPlan(WorkOrderPlanVo workOrderPlanVo) throws Exception {
		return dao.readWorkOrderPlan(workOrderPlanVo);
	}
	
	//해당 설비&해당날짜 주간조 조회
	@Override
	public WorkOrderPlanVo searchDay(WorkOrderPlanVo Vo) throws Exception {
		return dao.searchDay(Vo);
	}
	
	//해당 설비&해당날짜 야간조 조회
	@Override
	public WorkOrderPlanVo searchNight(WorkOrderPlanVo Vo) throws Exception {
		return dao.searchNight(Vo);
	}
	
	//해당 설비&해당날짜 작업지시 등록
	@Override
	public void create(WorkOrderPlanVo Vo) throws Exception {
		dao.create(Vo);
	}
	
	//해당 설비&해당날짜 작업지시 수정
	@Override
	public void update(WorkOrderPlanVo Vo) throws Exception {
		dao.update(Vo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록
	@Override
	public void workPlanAutoCreate(WorkOrderPlanVo Vo) throws Exception {
		dao.workPlanAutoDelete(Vo);
		dao.workPlanAutoCreate(Vo);
	}
	
	//해당날짜의 모든 설비 최근 제조조건 자동등록 삭제
	@Override
	public void workPlanAutoDelete(WorkOrderPlanVo Vo) throws Exception {
		dao.workPlanAutoDelete(Vo);
	}
	
	//생산계획(확정,운영 계획수량) 조회
	@Override
	public List<ProductionPlanVo> readProductionPlan(ProductionPlanVo productionPlanVo) throws Exception {
		return dao.readProductionPlan(productionPlanVo);
	}
	
	//생산계획 월별 등록
	@Override
	public void createProductionPlan(ProductionPlanVo productionPlanVo) throws Exception {
		dao.createProductionPlan(productionPlanVo);
	}
	
	
	//생산계획 월별 삭제
	@Override
	public void deleteProductionPlan(ProductionPlanVo productionPlanVo) throws Exception {
		dao.deleteProductionPlan(productionPlanVo);
	}
	
	//월별 FP현황 조회(List)
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody(MonthProductPresentVo monthProductPresentVo) throws Exception {
		return dao.readMonthProductPresentBody(monthProductPresentVo);
	}
	
	//사용자 선택 날짜의 작지계획 생성
	@Override
	public void chooseWorkPlanAutoCreate(WorkOrderPlanVo workOrderPlanVo) throws Exception {
		dao.chooseWorkPlanAutoDelete(workOrderPlanVo);
		dao.chooseWorkPlanAutoCreate(workOrderPlanVo);
	}
	
	//사용자 선택 날짜의 작지계획 존재시 삭제
	@Override
	public void chooseWorkPlanAutoDelete(WorkOrderPlanVo workOrderPlanVo) throws Exception {
		dao.chooseWorkPlanAutoDelete(workOrderPlanVo);
	}
	
	//해당설비&일자의 작지계획 목록
	@Override
	public List<WorkOrderPlanVo> equipWorkOrdPlanList(WorkOrderPlanVo workOrderPlanVo) throws Exception {
		return dao.equipWorkOrdPlanList(workOrderPlanVo);
	}
	
	//생산계획 (확정,운영,CAPA,수율(AL),수율(NI)) 조회
	@Override
	public List<Map<String,String>> readProductionPlanNew(ProductionPlanVo productionPlanVo) throws Exception{
		return dao.readProductionPlanNew(productionPlanVo);
	}
	
	//메모 등록
	@Override
	public void memoCreate(MonthProductPresentVo monthProductPresentVo) throws Exception{
		dao.memoCreate(monthProductPresentVo);
	}
	
	//메모 삭제
	@Override
	public void memoDelete(MonthProductPresentVo monthProductPresentVo) throws Exception{
		dao.memoDelete(monthProductPresentVo);
	}
	
	//메모 수정
	@Override
	public void memoUpdate(MonthProductPresentVo monthProductPresentVo) throws Exception{
		dao.memoUpdate(monthProductPresentVo);
	}
	
	//월별 FP현황 조회 (메모)
	@Override
	public MonthProductPresentVo memoList(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return dao.memoList(monthProductPresentVo);
	}
	
	//월별 FP현황 조회(List) 요약본 1
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody2(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return dao.readMonthProductPresentBody2(monthProductPresentVo);
	}
	
	//월별 FP현황 조회(List) 요약본 2
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBody3(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return dao.readMonthProductPresentBody3(monthProductPresentVo);
	}
	
	//월별 FP현황 조회 헤더만(List)
	@Override
	public List<MonthProductPresentVo> readMonthProductPresentBodyHeaderOnly(MonthProductPresentVo monthProductPresentVo) throws Exception{
		return dao.readMonthProductPresentBodyHeaderOnly(monthProductPresentVo);
	}
}