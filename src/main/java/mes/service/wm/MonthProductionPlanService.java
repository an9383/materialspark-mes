package mes.service.wm;

import java.util.List;
import java.util.Map;

import mes.domain.wm.MonthProductionPlanVo;
import mes.domain.wm.TestDataVo;

public interface MonthProductionPlanService {
	
	//월별 FP 목록 조회 비가동구분(SLD)
	public List<Map<String,String>> monthProductionPlanListGubun(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목록 조회 비가동시간(SLD)
	public List<Map<String,String>> monthProductionPlanListTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 잡체인지 모달 조회
	public List<MonthProductionPlanVo> jobChangeModal(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 설비별, 제품별 테이블 조회
	public List<MonthProductionPlanVo> readDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 확정여부 조회
	public MonthProductionPlanVo checkCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 확정여부 수정
	public void updateCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception;	
	
	//월별 FP 목록 등록 (SLD)
	public void create(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception;
	
	//월별 FP 목록 삭제 (SLD)
	public void delete(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목록 상세 등록 (SLD)
	public void createDtl(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception;
	
	//월별 FP 목록 상세 삭제 (SLD)
	public void deleteDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 잡체인지 업데이트
	public void jobChangeUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 잡체인지 구분자 저장여부 조회
	public int checkJobChange(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 듀얼케파 확정 생성
	public void createCplDualCapa(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 택타임 확정 생성
	public void createCplTecTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP Second 확정 생성
	public void createCplSecond(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 확정수량 확정 생성
	public void createCplPlanCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 운영수량 확정 생성
	public void createCplPlanCntModify(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	// 월별 FP 확정계획 삭제
	public void deleteCplPlan(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	// 월별 FP 확정계획 확정에 없는 잡체인지 입력할떄 삭제
	public void deleteCplPlanEx(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 요약본 조회
	public List<MonthProductionPlanVo> monthProductionPlanSumList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 작업자 조회
	public List<Map<String,String>> monthProductionPlanMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 작업자 생성
	public void createMan(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception;	
	
	//월별 FP 작업자 삭제
	public void deleteMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 작업자 상세 조회
	public List<MonthProductionPlanVo> monthProductionPlanManList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 기종별 조회
	public List<MonthProductionPlanVo> monthProductionPlanGijongList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 상세 요약 조회
	public List<TestDataVo> monthProductionPlanDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	// 월별 FP 확정계획 읽기
	public List<MonthProductionPlanVo> readFpTotalComplete(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//최고수량/ 일자
	public List<MonthProductionPlanVo> bestOutputCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//가동률 최고/ 일자
	public List<MonthProductionPlanVo> bestCapaDay(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//전일 작업자
	public List<MonthProductionPlanVo> lastDayWorker(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//전일 설비 대수
	public List<MonthProductionPlanVo> lastDayEquipCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목표 조회
	public MonthProductionPlanVo monthSumData(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목표 생성
	public void createTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목표 수정
	public void updateTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 목표 삭제
	public void deleteTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 수율 조회
	public MonthProductionPlanVo readYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 수율 생성
	public void createYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 수율 수정
	public void updateYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 수율 삭제
	public void deleteYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//잡체인지 목록 모달 조회
	public List<MonthProductionPlanVo> jcModalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	
	//기종별 일일재고 목룍 
	public List<MonthProductionPlanVo> dailyInvenList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 생성
	public void dailyInvenCreate(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 수정
	public void dailyInvenUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 삭제
	public void dailyInvenDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 제품 생성
	public void createGoods(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception;
	
	//월별 FP 제품 삭제
	public void deleteGoods(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP 확정판 확정계획 0으로 입력
	public void createFpTotalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//메모 등록
	public void memoCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//메모 삭제
	public void memoDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//메모 수정
	public void memoUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//월별 FP현황 조회 (메모)
	public MonthProductionPlanVo memoList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 ADM 조회 
	public MonthProductionPlanVo dailyInvenRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 ADM 생성
	public void dailyInvenAdmCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 ADM 삭제
	public void dailyInvenAdmDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별일일재고 실데이터
	public List<MonthProductionPlanVo> gijongDailyPlan1(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별일일재고 입력데이터
	public List<MonthProductionPlanVo> gijongDailyPlan2(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	// 다음달 재고 예상 등록 (입력)
	public void createNextMonthStock(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	// 다음달 재고 예상 등록 (실데이터)
	public void createNextMonthStockReal(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 ADM 리스트
	public List<MonthProductionPlanVo> dailyInvenAdmList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
	
	//기종별 일일재고 DTL 리스트
	public List<MonthProductionPlanVo> dailyInvenDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception;
}
