package mes.persistence.po;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.WorkOrderVo;
import mes.domain.po.WorkerChangeVo;

@Repository
public class WorkOrderDAOImpl implements WorkOrderDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.po.workOrderMapper";

	//작업지시서 계획 목록조회(MTP-1공장)
	@Override
	public List<WorkOrderVo> workOrderPlanDataList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".workOrderPlanDataList", workOrderVo);
	}
	
	//작업지시서 계획 목록조회(SLD-3공장)
	@Override
	public List<WorkOrderVo> workOrderPlanDataList_F3(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".workOrderPlanDataList_F3", workOrderVo);
	}
	
	//솔브레인SLD - 엣지검사, 외관검사 시 작지목록 조회
	@Override
	public List<WorkOrderVo> qualityWorkOrderList_F3(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".qualityWorkOrderList_F3", workOrderVo);
	}
	
	//작업지시서 목록조회
	@Override
	public List<WorkOrderVo> workOrderDataList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".workOrderDataList", workOrderVo);
	}
	
	//작지 연결대상 목록조회
	@Override
	public List<WorkOrderVo> workOrderConnectList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".workOrderConnectList", workOrderVo);
	}
	
	//검사대기 작지목록 조회
	@Override
	public List<WorkOrderVo> standByInspectionWorkOrdList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".standByInspectionWorkOrdList", workOrderVo);
	}
	
	//작업지시서 등록
	@Override
	public void createWorkOrder(WorkOrderVo workOrderVo) throws Exception {
		session.insert(namespace + ".createWorkOrder", workOrderVo);
	}	 
		
	//작업지시서 수정
	@Override
	public void updateWorkOrder(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".updateWorkOrder", workOrderVo);
	}
	
	//작업지시서 검사상태 수정
	@Override
	public void workOrderStatusUpdate(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".workOrderStatusUpdate", workOrderVo);
	}
		
	//작업지시서 담당1,2 수정
	@Override
	public void updateWorkOrderChargr(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".updateWorkOrderChargr", workOrderVo);
	}
	
	//작업지시서 수정
	@Override
	public void updateWorkOrderStatus(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".updateWorkOrderStatus", workOrderVo);
	}	
		
	//작업지시 제품별 자재등록정보 바코드조회 
	@Override
	public WorkOrderVo workOrderMatrlData(WorkOrderVo workOrderVo) throws Exception {
		return session.selectOne(namespace + ".workOrderMatrlData", workOrderVo);
	}
	
	//재투입 LOT 확인
	@Override
	public WorkOrderVo checkLastMatrlLotNo(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".checkLastMatrlLotNo", workOrderVo);
	}
	
	//작업지시 마지막 LOT 확인
	@Override
	public WorkOrderVo checkBefoerMatrlLotNo(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".checkBefoerMatrlLotNo", workOrderVo);
	}
		
	//작업지시자재상세 목록조회
	@Override
	public List<WorkOrderVo> workOrderMatrlDataList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".workOrderMatrlDataList", workOrderVo);
	}
	
	//재투입된 자재의 작업지시 목록조회
	@Override
	public List<WorkOrderVo> reamkeWorkOrderDtlList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".reamkeWorkOrderDtlList", workOrderVo);
	}
		
	//작업지시 자재상세 삭제전 자재가출고 상태로 변경
	@Override
	public void updatePreOutWhsStatus(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".updatePreOutWhsStatus", workOrderVo);
	}
		
	//작업지시자재상세 삭제(자재상태변경 후 삭제처리)
	 @Override
	 public void deleteWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception {
		 session.delete(namespace + ".deleteWorkOrderDtl", workOrderVo);
	 }	 
	 
	//작업지시 자재상세등록
	@Override
	public void createWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception {
		session.insert(namespace + ".createWorkOrderDtl", workOrderVo);
	}
	
	//작업지시 연결시 자재등록
	@Override
	public void createConnectWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception {
		session.insert(namespace + ".createConnectWorkOrderDtl", workOrderVo);
	}
	 
	//작업지시 자재상세 등록 후 자재출고 상태로 변경
	@Override
	public void updateOutWhsStatus(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace + ".updateOutWhsStatus", workOrderVo);
	}	 
	 
	//qmsc0041 초중물관리 view
	@Override
	public List<WorkOrderVo> workOrderRead(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".workOrderRead", workOrderVo);
	}
	 
	//qmsc0030 자주검사관리 작지 목록
	@Override
	public List<WorkOrderVo> workOrderRead2(WorkOrderVo workOrderVo) throws Exception{
		 return session.selectList(namespace + ".workOrderRead2", workOrderVo);
	}
	 
	//작업지시 생산실적 수정
	@Override
	public void updateWorkOrderResult(WorkOrderVo workOrderVo) throws Exception {
		 session.update(namespace + ".updateWorkOrderResult", workOrderVo);
	}	 
	 
	//선택조회
	@Override
	public WorkOrderVo read(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".read", workOrderVo);
	}
	
	//작업일보 목록 조회
	@Override
	public List<WorkOrderVo> operationList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".operationList", workOrderVo);
	}
	
	//실링검사 입력작지 목록 조회
	@Override
	public List<WorkOrderVo> sealingWorkOrdList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".sealingWorkOrdList", workOrderVo);
	}
	
	//실링검사 입력
	@Override
	public void updateSealingWorkOrd(WorkOrderVo workOrderVo) throws Exception{
		session.update(namespace + ".updateSealingWorkOrd", workOrderVo);
	}
	
	//불량집계현황(일자) 목록 조회
	@Override
	public List<Map<String,String>> faultyDayTotalList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".faultyDayTotalList", workOrderVo);
	}
	
	//품질관리/최종검사현황 - 생산비전불량(작업지시)
	@Override
	public List<Map<String,String>> visionWorkOrdTotalList_nF2(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".visionWorkOrdTotalList_nF2", workOrderVo);
	}
	
	//품질관리/최종검사현황 - 생산비전불량(작업자)
	@Override
	public List<Map<String,String>> visionChargerTotalList_nF2(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".visionChargerTotalList_nF2", workOrderVo);
	}
	
	//불량집계현황(일자) 엣지목록 조회
	@Override
	public List<Map<String,String>> edgeFaultyDayTotalList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".edgeFaultyDayTotalList", workOrderVo);
	}
	
	//불량집계현황(작업지시일자) 목록 조회
	@Override
	public List<Map<String,String>> workOrderTotalDataList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".workOrderTotalDataList", workOrderVo);
	}
	
	//불량집계현황(작업지시일자) 목록 조회
	@Override
	public List<Map<String,String>> workOrderTotalDataList_F3(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".workOrderTotalDataList_F3", workOrderVo);
	}
	
	//불량집계현황(종합수량) 목록 조회
	@Override
	public List<Map<String,String>> comprehensiveQtyList_F1F2(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".comprehensiveQtyList_F1F2", workOrderVo);
	}
	
	//작업지시 투입 주자재 리스트(최대4개만)
	@Override
	public List<WorkOrderVo> workOrderMainMatrlTop4(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".workOrderMainMatrlTop4", workOrderVo);
	}
	
	//작업지시 투입 부자재 리스트(최대4개만)
	@Override
	public List<WorkOrderVo> workOrderSubMatrlTop4(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".workOrderSubMatrlTop4", workOrderVo);
	}
	
	//작업지시 투입 부자재 리스트(최대2개만)
	@Override
	public WorkOrderVo checkConnectLotNo(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".checkConnectLotNo", workOrderVo);
	}
	
	//작업지시자재상세 재투입 개수 확인
	public int workOrderDtlCount(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".workOrderDtlCount", workOrderVo);
	}
	
	//스캔한 자재가 해당작지에 이미 투입되었는지 확인
	public int workOrderDtlCheck(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".workOrderDtlCheck", workOrderVo);
	}
	
	//모니터링 대상 설비의 가장 최근 시작된 진행작지 정보
	@Override
	public WorkOrderVo monitoringWorkOrdRead(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".monitoringWorkOrdRead", workOrderVo);
	}
	
	//해당설비의 12시간 이내의 진행중인 작지가 있는지 확인
	@Override
	public WorkOrderVo checkWorkingWorkOrd(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".checkWorkingWorkOrd", workOrderVo);
	}
	
	//작업지시번호 채번
	@Override
	public String workOrdNoSeq(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".workOrdNoSeq", workOrderVo);
	}
	
	//작업지시 삭제
	@Override
	public void deleteWorkOrdNo(WorkOrderVo workOrderVo) throws Exception{
		session.delete(namespace + ".deleteWorkOrdNo", workOrderVo);
	}
	
	// 가장최근에 투입한 롯트 상태값 가져오기
	@Override
	public WorkOrderVo workOrderFaultyStatusCheck(WorkOrderVo workOrderVo) throws Exception{
		return session.selectOne(namespace + ".workOrderFaultyStatusCheck", workOrderVo);
	}
	
	//작업지시 자재상세 자재 불량 상태로 변경
	@Override
	public void updateWorkOrdFaultyStatus(WorkOrderVo workOrderVo) throws Exception{
		session.update(namespace + ".updateWorkOrdFaultyStatus", workOrderVo);
	}
	
	
	//--------작업자 변경 관련 사항--------//
	
	//자업자 변경 목록조회
	@Override
	public List<WorkerChangeVo> workerChangeList(WorkerChangeVo workerChangeVo) throws Exception {
		return session.selectList(namespace +".workerChangeList", workerChangeVo);
	}
	
	//자업자 변경 상세조회
	@Override
	public WorkerChangeVo workerChangeRead(WorkerChangeVo workerChangeVo) throws Exception {
		return session.selectOne(namespace + ".workerChangeRead" , workerChangeVo);
	}
	
	//자업자 변경 등록
	@Override
	public void workerChangeCreate(WorkerChangeVo workerChangeVo) throws Exception {
		session.insert(namespace + ".workerChangeCreate", workerChangeVo);
	}

	//자업자 변경 수정
	@Override
	public void workerChangeUpdate(WorkerChangeVo workerChangeVo) throws Exception {
		session.update(namespace +".workerChangeUpdate", workerChangeVo);
	}
	
	//작업자 변경 삭제
	@Override
	public void workerChangeDelete(WorkerChangeVo workerChangeVo) throws Exception{
		session.delete(namespace + ".workerChangeDelete",workerChangeVo);
	}
	
	//작업자 변경 seq생성
	public String workerChangeSeq(String workOrdNumber) throws Exception{
		return session.selectOne(namespace +".workerChangeSeq" , workOrdNumber);
	}
	
	//--------작업자 변경 관련 사항 끝--------//
	
	
	//작업지시 Dtl 상세조회
	@Override
	public WorkOrderVo workOrderDtlRead(WorkOrderVo workOrderVo) throws Exception {
		return session.selectOne(namespace + ".workOrderDtlRead" , workOrderVo);
	}
	
	
	//--------주자재 변경 관련 사항 시작--------//
	
	//작지 주자재 변경
	@Override
	public void workOrderMetalChangeAllUpdate(WorkOrderVo workOrderVo) throws Exception {
		session.update(namespace +".workOrderMetalChangeAllUpdate", workOrderVo);
	}
	
	//작업지시 주재료 변경 내역 등록
	@Override
	public void workOrderMetalChangeHistCreate(WorkOrderVo workOrderVo) throws Exception {
		session.insert(namespace + ".workOrderMetalChangeHistCreate", workOrderVo);
	}
	
	//--------주자재 변경 관련 사항 끝--------//
	
	//설비별 투입 중량 조회
	@Override
	public List<WorkOrderVo> inputWeightList(WorkOrderVo workOrderVo) throws Exception {
		return session.selectList(namespace + ".inputWeightList", workOrderVo);
	}
	
	//생산전표 조회
	@Override
	public List<WorkOrderVo> outputSubCntList(WorkOrderVo workOrderVo) throws Exception{
		return session.selectList(namespace + ".outputSubCntList", workOrderVo);
	}
	
}