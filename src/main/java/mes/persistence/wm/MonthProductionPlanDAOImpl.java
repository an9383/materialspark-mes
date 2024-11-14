package mes.persistence.wm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.wm.MonthProductionPlanVo;
import mes.domain.wm.TestDataVo;

@Repository
public class MonthProductionPlanDAOImpl implements MonthProductionPlanDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.wm.monthProductionPlanMapper";

	//월별 FP 목록 조회 비가동구분(SLD)
	@Override
	public List<Map<String,String>> monthProductionPlanListGubun(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanListGubun", monthProductionPlanVo);
	}
	
	//월별 FP 목록 조회 비가동시간(SLD)
	@Override
	public List<Map<String,String>> monthProductionPlanListTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanListTime", monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 모달 조회
	@Override
	public List<MonthProductionPlanVo> jobChangeModal(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".jobChangeModal", monthProductionPlanVo);
	}
	
	//월별 FP 설비별, 제품별 테이블 조회
	@Override
	public List<MonthProductionPlanVo> readDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".readDtl", monthProductionPlanVo);
	}
	
	//월별 FP 확정여부 조회
	@Override
	public MonthProductionPlanVo checkCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".checkCompleteYn", monthProductionPlanVo);
	}
	
	//월별 FP 확정여부 수정
	@Override
	public void updateCompleteYn(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".updateCompleteYn", monthProductionPlanVo);
	}
	
	//월별 FP 목록 등록 (SLD)
	@Override
	public void create(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".create", monthProductionPlanVo);
	}
	
	//월별 FP 목록 삭제 (SLD)
	@Override
	public void delete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".delete", monthProductionPlanVo);
	}
	
	//월별 FP 목록 상세 등록 (SLD)
	@Override
	public void createDtl(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createDtl", monthProductionPlanVo);
	}
	
	//월별 FP 목록 상세 삭제 (SLD)
	@Override
	public void deleteDtl(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteDtl", monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 업데이트
	@Override
	public void jobChangeUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".jobChangeUpdate", monthProductionPlanVo);
	}
	
	//월별 FP 잡체인지 구분자 저장여부 조회
	@Override
	public int checkJobChange(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".checkJobChange", monthProductionPlanVo);
	}
	
	//월별 FP 듀얼케파 확정 생성
	@Override
	public void createCplDualCapa(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createCplDualCapa", monthProductionPlanVo);
	}
	
	//월별 FP 택타임 확정 생성
	@Override
	public void createCplTecTime(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createCplTecTime", monthProductionPlanVo);
	}
	
	//월별 FP Second 확정 생성
	@Override
	public void createCplSecond(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createCplSecond", monthProductionPlanVo);
	}
	
	//월별 FP 확정수량 확정 생성
	@Override
	public void createCplPlanCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createCplPlanCnt", monthProductionPlanVo);
	}
	
	//월별 FP 운영수량 확정 생성
	@Override
	public void createCplPlanCntModify(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createCplPlanCntModify", monthProductionPlanVo);
	}
	
	// 월별 FP 확정계획 삭제
	@Override
	public void deleteCplPlan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteCplPlan", monthProductionPlanVo);
	}
	
	//월별 FP 요약본 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanSumList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanSumList", monthProductionPlanVo);
	}
	
	//월별 FP 작업자 조회
	@Override
	public List<Map<String,String>> monthProductionPlanMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanMan", monthProductionPlanVo);
	}
	
	//월별 FP 작업자 생성
	@Override
	public void createMan(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createMan", monthProductionPlanVo);
	}
	
	//월별 FP 작업자 삭제
	@Override
	public void deleteMan(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteMan", monthProductionPlanVo);
	}
	
	// 월별 FP 확정계획 확정에 없는 잡체인지 입력할떄 삭제
	@Override
	public void deleteCplPlanEx(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteCplPlanEx", monthProductionPlanVo);
	}
	
	//월별 FP 작업자 상세 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanManList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanManList", monthProductionPlanVo);
	}
	
	//월별 FP 기종별 조회
	@Override
	public List<MonthProductionPlanVo> monthProductionPlanGijongList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanGijongList", monthProductionPlanVo);
	}
	
	//월별 FP 상세 요약 조회
	@Override
	public List<TestDataVo> monthProductionPlanDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".monthProductionPlanDtlList", monthProductionPlanVo);
	}
	
	// 월별 FP 확정계획 읽기
	@Override
	public List<MonthProductionPlanVo> readFpTotalComplete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".readFpTotalComplete", monthProductionPlanVo);
	}
	
	//최고수량/ 일자
	@Override
	public List<MonthProductionPlanVo> bestOutputCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".bestOutputCnt", monthProductionPlanVo);
	}
	
	//가동률 최고/ 일자
	@Override
	public List<MonthProductionPlanVo> bestCapaDay(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".bestCapaDay", monthProductionPlanVo);
	}
	
	//전일 작업자
	@Override
	public List<MonthProductionPlanVo> lastDayWorker(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".lastDayWorker", monthProductionPlanVo);
	}
	
	//전일 설비 대수
	@Override
	public List<MonthProductionPlanVo> lastDayEquipCnt(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".lastDayEquipCnt", monthProductionPlanVo);
	}
	
	//월별 FP 목표 조회
	@Override
	public MonthProductionPlanVo monthSumData(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".monthSumData", monthProductionPlanVo);
	}
	
	//월별 FP 목표 생성
	@Override
	public void createTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createTheory", monthProductionPlanVo);
	}

	//월별 FP 목표 수정
	@Override
	public void updateTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".updateTheory", monthProductionPlanVo);
	}
	
	//월별 FP 목표 삭제
	@Override
	public void deleteTheory(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteTheory", monthProductionPlanVo);
	}
	
	//월별 FP 수율 조회
	@Override
	public MonthProductionPlanVo readYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".readYeild", monthProductionPlanVo);
	}
	
	//월별 FP 수율 생성
	@Override
	public void createYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createYeild", monthProductionPlanVo);
	}

	//월별 FP 수율 수정
	@Override
	public void updateYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".updateYeild", monthProductionPlanVo);
	}
	
	//월별 FP 수율 삭제
	@Override
	public void deleteYeild(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteYeild", monthProductionPlanVo);
	}
	
	//잡체인지 목록 모달 조회
	@Override
	public List<MonthProductionPlanVo> jcModalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".jcModalList", monthProductionPlanVo);
	}
	
	//기종별 일일재고 목룍 
	@Override
	public List<MonthProductionPlanVo> dailyInvenList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".dailyInvenList", monthProductionPlanVo);
	}
	
	//기종별 일일재고 생성
	@Override
	public void dailyInvenCreate(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".dailyInvenCreate", monthProductionPlanVo);
	}
	
	//기종별 일일재고 수정
	@Override
	public void dailyInvenUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".dailyInvenUpdate", monthProductionPlanVo);
	}
	
	//기종별 일일재고 삭제
	@Override
	public void dailyInvenDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".dailyInvenDelete", monthProductionPlanVo);
	}
	
	//월별 FP 제품 생성
	@Override
	public void createGoods(List<MonthProductionPlanVo> monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createGoods", monthProductionPlanVo);
	}

	//월별 FP 제품 삭제
	@Override
	public void deleteGoods(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".deleteGoods", monthProductionPlanVo);
	}
	
	//월별 FP 확정판 확정계획 0으로 입력
	@Override
	public void createFpTotalList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createFpTotalList", monthProductionPlanVo);
	}
	
	//메모 등록
	@Override
	public void memoCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".memoCreate", monthProductionPlanVo);
	}
	
	//메모 삭제
	@Override
	public void memoDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".memoDelete", monthProductionPlanVo);
	}
	
	//메모 수정
	@Override
	public void memoUpdate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.update(namespace + ".memoUpdate", monthProductionPlanVo);
	}
	
	//월별 FP현황 조회 (메모)
	@Override
	public MonthProductionPlanVo memoList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".memoList", monthProductionPlanVo); 
	}
	
	//기종별 일일재고 ADM 조회 
	@Override
	public MonthProductionPlanVo dailyInvenRead(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectOne(namespace + ".dailyInvenRead", monthProductionPlanVo); 
	}
	
	//기종별 일일재고 ADM 생성
	@Override
	public void dailyInvenAdmCreate(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".dailyInvenAdmCreate", monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 삭제
	@Override
	public void dailyInvenAdmDelete(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.delete(namespace + ".dailyInvenAdmDelete", monthProductionPlanVo);
	}
	
	//기종별일일재고 실데이터
	@Override
	public List<MonthProductionPlanVo> gijongDailyPlan1(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".gijongDailyPlan1", monthProductionPlanVo); 
	}
	
	//기종별일일재고 입력데이터
	@Override
	public List<MonthProductionPlanVo> gijongDailyPlan2(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".gijongDailyPlan2", monthProductionPlanVo); 
	}
	
	// 다음달 재고 예상 등록 (입력)
	@Override
	public void createNextMonthStock(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createNextMonthStock", monthProductionPlanVo);
	}
	
	// 다음달 재고 예상 등록 (실데이터)
	@Override
	public void createNextMonthStockReal(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		session.insert(namespace + ".createNextMonthStockReal", monthProductionPlanVo);
	}
	
	//기종별 일일재고 ADM 리스트
	@Override
	public List<MonthProductionPlanVo> dailyInvenAdmList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".dailyInvenAdmList", monthProductionPlanVo); 
	}
	
	//기종별 일일재고 DTL 리스트
	@Override
	public List<MonthProductionPlanVo> dailyInvenDtlList(MonthProductionPlanVo monthProductionPlanVo) throws Exception{
		return session.selectList(namespace + ".dailyInvenDtlList", monthProductionPlanVo); 
	}

}