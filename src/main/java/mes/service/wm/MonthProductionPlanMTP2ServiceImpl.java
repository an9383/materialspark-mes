package mes.service.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.wm.MonthProductionPlanVo;
import mes.domain.wm.TestDataVo;
import mes.persistence.wm.MonthProductionPlanMTP2DAO;

@Service
public class MonthProductionPlanMTP2ServiceImpl implements MonthProductionPlanMTP2Service {

	@Inject
	private MonthProductionPlanMTP2DAO dao;

	//월별 FP 목록 조회 비가동구분(SLD)
	@Override
	public List<Map<String,String>> monthProductionPlanListGubun(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanListGubun(monthProductionPlanVo);
	}
	
	//월별 FP 목록 조회 비가동시간(SLD)
	@Override
	public List<Map<String,String>> monthProductionPlanListTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanListTime(monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 모달 조회
	@Override
	public List<MonthProductionPlanVo> jobChangeModal(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.jobChangeModal(monthProductionPlanVo);
	}
	
	//월별 FP 설비별, 제품별 테이블 조회
	@Override
	public List<MonthProductionPlanVo> readDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.readDtl(monthProductionPlanVo);
	}
	
	//월별 FP 확정여부 조회
	@Override
	public MonthProductionPlanVo checkCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.checkCompleteYn(monthProductionPlanVo);
	}
	
	//월별 FP 확정여부 수정
	@Override
	public void updateCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.updateCompleteYn(monthProductionPlanVo);
	}
	
	//월별 FP 목록 등록 (SLD)
	@Override
	public void create(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		dao.create(monthProductionPlanVo);
	}
	
	//월별 FP 목록 삭제 (SLD)
	@Override
	public void delete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.delete(monthProductionPlanVo);
	}
	
	//월별 FP 목록 상세 등록 (SLD)
	@Override
	public void createDtl(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		dao.createDtl(monthProductionPlanVo);
	}
	
	//월별 FP 목록 상세 삭제 (SLD)
	@Override
	public void deleteDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteDtl(monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 업데이트
	@Override
	public void jobChangeUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.jobChangeUpdate(monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 구분자 저장여부 조회
	@Override
	public int checkJobChange(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.checkJobChange(monthProductionPlanVo);
	}
	
	//월별 FP 듀얼케파 확정 생성
	@Override
	public void createCplDualCapa(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createCplDualCapa(monthProductionPlanVo);
	}
	
	//월별 FP 택타임 확정 생성
	@Override
	public void createCplTecTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createCplTecTime(monthProductionPlanVo);
	}
	
	//월별 FP Second 확정 생성
	@Override
	public void createCplSecond(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createCplSecond(monthProductionPlanVo);
	}
	
	//월별 FP 확정수량 확정 생성
	@Override
	public void createCplPlanCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createCplPlanCnt(monthProductionPlanVo);
	}
	
	//월별 FP 운영수량 확정 생성
	@Override
	public void createCplPlanCntModify(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createCplPlanCntModify(monthProductionPlanVo);
	}
	
	// 월별 FP 확정계획 삭제
	@Override
	public void deleteCplPlan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteCplPlan(monthProductionPlanVo);
	}
	
	// 월별 FP 확정계획 확정에 없는 잡체인지 입력할떄 삭제
	@Override
	public void deleteCplPlanEx(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteCplPlanEx(monthProductionPlanVo);
	}
	
	
	//월별 FP 요약본 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanSumList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanSumList(monthProductionPlanVo);
	}
	
	//월별 FP 작업자 조회
	@Override
	public List<Map<String,String>> monthProductionPlanMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanMan(monthProductionPlanVo);
	}
	
	//월별 FP 작업자 생성
	@Override
	public void createMan(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		dao.createMan(monthProductionPlanVo);
	}
	
	//월별 FP 작업자 삭제
	@Override
	public void deleteMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteMan(monthProductionPlanVo);
	}
	
	//월별 FP 작업자 상세 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanManList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanManList(monthProductionPlanVo);
	}
	
	//월별 FP 기종별 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanGijongList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanGijongList(monthProductionPlanVo);
	}
	
	//월별 FP 상세 요약 조회
	@Override
	public List<TestDataVo> monthProductionPlanDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthProductionPlanDtlList(monthProductionPlanVo);
	}

	// 월별 FP 확정계획 읽기
	@Override
	public List<MonthProductionPlanVo> readFpTotalComplete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.readFpTotalComplete(monthProductionPlanVo);
	}
	
	//최고수량/ 일자
	@Override
	public List<MonthProductionPlanVo> bestOutputCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.bestOutputCnt(monthProductionPlanVo);
	}
	
	//가동률 최고/ 일자
	@Override
	public List<MonthProductionPlanVo> bestCapaDay(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.bestCapaDay(monthProductionPlanVo);
	}
	
	//전일 작업자
	@Override
	public List<MonthProductionPlanVo> lastDayWorker(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.lastDayWorker(monthProductionPlanVo);
	}
	
	//전일 설비 대수
	@Override
	public List<MonthProductionPlanVo> lastDayEquipCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.lastDayEquipCnt(monthProductionPlanVo);
	}
	
	//월별 FP 목표 조회
	@Override
	public MonthProductionPlanVo monthSumData(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.monthSumData(monthProductionPlanVo);
	}
	
	//월별 FP 목표 생성
	@Override
	public void createTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createTheory(monthProductionPlanVo);
	}

	//월별 FP 목표 수정
	@Override
	public void updateTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.updateTheory(monthProductionPlanVo);
	}
	
	//월별 FP 목표 삭제
	@Override
	public void deleteTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteTheory(monthProductionPlanVo);
	}
	
	//월별 FP 수율 조회
	@Override
	public MonthProductionPlanVo readYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.readYeild(monthProductionPlanVo);
	}
	
	//월별 FP 수율 생성
	@Override
	public void createYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createYeild(monthProductionPlanVo);
	}

	//월별 FP 수율 수정
	@Override
	public void updateYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.updateYeild(monthProductionPlanVo);
	}
	
	//월별 FP 수율 삭제
	@Override
	public void deleteYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteYeild(monthProductionPlanVo);
	}
	
	//잡체인지 목록 모달 조회
	@Override
	public List<MonthProductionPlanVo> jcModalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.jcModalList(monthProductionPlanVo);
	}
	
	//기종별 일일재고 목룍 
	@Override
	public List<MonthProductionPlanVo> dailyInvenList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.dailyInvenList(monthProductionPlanVo);
	}
	
	//기종별 일일재고 생성
	@Override
	public void dailyInvenCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.dailyInvenCreate(monthProductionPlanVo);
	}
	
	//기종별 일일재고 수정
	@Override
	public void dailyInvenUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.dailyInvenUpdate(monthProductionPlanVo);
	}
	
	//기종별 일일재고 삭제
	@Override
	public void dailyInvenDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.dailyInvenDelete(monthProductionPlanVo);
	}
	
	//월별 FP 제품 생성
	@Override
	public void createGoods(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		dao.createGoods(monthProductionPlanVo);
	}

	//월별 FP 제품 삭제
	@Override
	public void deleteGoods(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.deleteGoods(monthProductionPlanVo);
	}

	//월별 FP 확정판 확정계획 0으로 입력
	@Override
	public void createFpTotalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.createFpTotalList(monthProductionPlanVo);
	}
	
	//메모 등록
	@Override
	public void memoCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.memoCreate(monthProductionPlanVo);
	}
	
	//메모 삭제
	@Override
	public void memoDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.memoDelete(monthProductionPlanVo);
	}
	
	//메모 수정
	@Override
	public void memoUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.memoUpdate(monthProductionPlanVo);
	}
	
	//월별 FP현황 조회 (메모)
	@Override
	public MonthProductionPlanVo memoList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.memoList(monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 조회 
	@Override
	public MonthProductionPlanVo dailyInvenRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.dailyInvenRead(monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 생성
	@Override
	public void dailyInvenAdmCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.dailyInvenAdmCreate(monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 삭제
	@Override
	public void dailyInvenAdmDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		dao.dailyInvenAdmDelete(monthProductionPlanVo);
	}
	
	//기종별일일재고 실데이터
	@Override
	public List<MonthProductionPlanVo> gijongDailyPlan1(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.gijongDailyPlan1(monthProductionPlanVo);
	}
	
	//기종별일일재고 입력데이터
	@Override
	public List<MonthProductionPlanVo> gijongDailyPlan2(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.gijongDailyPlan2(monthProductionPlanVo);
	}
	
	// 다음달 재고 예상 등록 (입력)
	@Override
	public void createNextMonthStock(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		 dao.createNextMonthStock(monthProductionPlanVo);
	}
	
	// 다음달 재고 예상 등록 (실데이터)
	@Override
	public void createNextMonthStockReal(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		 dao.createNextMonthStockReal(monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 리스트
	@Override
	public List<MonthProductionPlanVo> dailyInvenAdmList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return dao.dailyInvenAdmList(monthProductionPlanVo);
	}
}
