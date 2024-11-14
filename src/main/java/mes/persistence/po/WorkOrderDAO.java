package mes.persistence.po;

import java.util.List;
import java.util.Map;

import mes.domain.po.WorkOrderVo;
import mes.domain.po.WorkerChangeVo;

public interface WorkOrderDAO {

	//작업지시서 계획 목록조회(MTP-1공장)
	public List<WorkOrderVo> workOrderPlanDataList(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 계획 목록조회(SLD-3공장)
	public List<WorkOrderVo> workOrderPlanDataList_F3(WorkOrderVo workOrderVo) throws Exception;
	
	//솔브레인SLD - 엣지검사, 외관검사 시 작지목록 조회
	public List<WorkOrderVo> qualityWorkOrderList_F3(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 목록조회
	public List<WorkOrderVo> workOrderDataList(WorkOrderVo workOrderVo) throws Exception;
	
	//작지 연결대상 목록조회
	public List<WorkOrderVo> workOrderConnectList(WorkOrderVo workOrderVo) throws Exception;
	
	//검사대기 작지목록 조회
	public List<WorkOrderVo> standByInspectionWorkOrdList(WorkOrderVo workOrderVo) throws Exception;	

	//작업지시서 등록
	public void createWorkOrder(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 수정
	public void updateWorkOrder(WorkOrderVo workOrderVo) throws Exception;	
	
	//작업지시서 상태수정
	public void updateWorkOrderStatus(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 담당1,2 수정
	public void updateWorkOrderChargr(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 제품별 자재등록정보 바코드조회 
	public WorkOrderVo workOrderMatrlData(WorkOrderVo workOrderVo) throws Exception;	
	
	//재투입 LOT 확인
	public WorkOrderVo checkLastMatrlLotNo(WorkOrderVo workOrderVo) throws Exception;	
	
	//작업지시 마지막 LOT 확인
	public WorkOrderVo checkBefoerMatrlLotNo(WorkOrderVo workOrderVo) throws Exception;		
	
	//작업지시 자재상세 목록조회
	public List<WorkOrderVo> workOrderMatrlDataList(WorkOrderVo workOrderVo) throws Exception;
	
	//재투입된 자재의 작업지시 목록조회
	public List<WorkOrderVo> reamkeWorkOrderDtlList(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 자재상세 삭제전 자재가출고 상태로 변경
	public void updatePreOutWhsStatus(WorkOrderVo workOrderVo) throws Exception;	
	
	//작업지시자재상세 삭제(자재상태변경 후 삭제처리)
	public void deleteWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 자재상세등록
	public void createWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 연결시 자재등록
	public void createConnectWorkOrderDtl(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 자재상세 등록 후 자재출고 상태로 변경 
	public void updateOutWhsStatus(WorkOrderVo workOrderVo) throws Exception;	
	
	//qmsc0041 초중물관리 view
	public List<WorkOrderVo> workOrderRead(WorkOrderVo workOrderVo) throws Exception;
	
	//qmsc0030 자주검사관리 작지 목록
	public List<WorkOrderVo> workOrderRead2(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 생산실적 수정
	public void updateWorkOrderResult(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시서 검사상태 수정
	public void workOrderStatusUpdate(WorkOrderVo workOrderVo) throws Exception;
	
	//선택조회
	public WorkOrderVo read(WorkOrderVo workOrderVo) throws Exception;
	
	//작업일보 목록 조회
	public List<WorkOrderVo> operationList(WorkOrderVo workOrderVo) throws Exception;
	
	//실링검사 입력작지 목록 조회
	public List<WorkOrderVo> sealingWorkOrdList(WorkOrderVo workOrderVo) throws Exception;
	
	//실링검사 입력
	public void updateSealingWorkOrd(WorkOrderVo workOrderVo) throws Exception;
	
	//불량집계현황(일자) 목록 조회
	public List<Map<String,String>> faultyDayTotalList(WorkOrderVo workOrderVo) throws Exception;
	
	//품질관리/최종검사현황 - 생산비전불량(작업지시)
	public List<Map<String,String>> visionWorkOrdTotalList_nF2(WorkOrderVo workOrderVo) throws Exception;
	
	//품질관리/최종검사현황 - 생산비전불량(작업자)
	public List<Map<String,String>> visionChargerTotalList_nF2(WorkOrderVo workOrderVo) throws Exception;
	
	//불량집계현황(일자) 엣지목록 조회
	public List<Map<String,String>> edgeFaultyDayTotalList(WorkOrderVo workOrderVo) throws Exception;
	
	//불량집계현황(작지번호별) 목록 조회
    public List<Map<String,String>> workOrderTotalDataList(WorkOrderVo workOrderVo) throws Exception;
    
    //불량집계현황(작지별) 목록 조회
  	public List<Map<String,String>> workOrderTotalDataList_F3(WorkOrderVo workOrderVo) throws Exception;
    
	//불량집계현황(종합수량) 목록 조회
    public List<Map<String,String>> comprehensiveQtyList_F1F2(WorkOrderVo workOrderVo) throws Exception;
    
	//작업지시 투입 주자재 리스트(최대4개만)
	public List<WorkOrderVo> workOrderMainMatrlTop4(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 투입 부자재 리스트(최대4개만)
	public List<WorkOrderVo> workOrderSubMatrlTop4(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 양식 인쇄 시 직전 작지와 연결된 자재인지 확인
	public WorkOrderVo checkConnectLotNo(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시자재상세 재투입 개수 확인
	public int workOrderDtlCount(WorkOrderVo workOrderVo) throws Exception;
	
	//스캔한 자재가 해당작지에 이미 투입되었는지 확인
	public int workOrderDtlCheck(WorkOrderVo workOrderVo) throws Exception;
	
	//모니터링 대상 설비의 가장 최근 시작된 진행작지 정보
	public WorkOrderVo monitoringWorkOrdRead(WorkOrderVo workOrderVo) throws Exception;

	//해당설비의 12시간 이내의 진행중인 작지가 있는지 확인
	public WorkOrderVo checkWorkingWorkOrd(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시번호 채번
	public String workOrdNoSeq(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 삭제
	public void deleteWorkOrdNo(WorkOrderVo workOrderVo) throws Exception;	
	
	// 가장최근에 투입한 롯트 상태값 가져오기
	public WorkOrderVo workOrderFaultyStatusCheck(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 자재상세 자재 불량 상태로 변경
	public void updateWorkOrdFaultyStatus(WorkOrderVo workOrderVo) throws Exception;
	
	//--------작업자 변경 관련 사항--------//
	
	//자업자 변경 목록조회
	public List<WorkerChangeVo> workerChangeList(WorkerChangeVo workerChangeVo) throws Exception;
	
	//자업자 변경 상세조회
	public WorkerChangeVo workerChangeRead(WorkerChangeVo workerChangeVo) throws Exception;
	
	//자업자 변경 등록
	public void workerChangeCreate(WorkerChangeVo workerChangeVo) throws Exception;
	
	//자업자 변경 수정
	public void workerChangeUpdate(WorkerChangeVo workerChangeVo) throws Exception;
	
	//작업자변경 삭제
	public void workerChangeDelete(WorkerChangeVo workerChangeVo) throws Exception;
	
	//작업자 변경 seq생성
	public String workerChangeSeq(String workOrdNumber) throws Exception;
	
	//--------작업자 변경 관련 사항 끝--------//
	
	
	//작업지시 Dtl 상세조회
	public WorkOrderVo workOrderDtlRead(WorkOrderVo workOrderVo) throws Exception;

	
	//--------주자재 변경 관련 사항 시작--------//
	
	//작지 주자재 변경
	public void workOrderMetalChangeAllUpdate(WorkOrderVo workOrderVo) throws Exception;
	
	//작업지시 주재료 변경 내역 등록
	public void workOrderMetalChangeHistCreate(WorkOrderVo workOrderVo) throws Exception;
	
	//--------주자재 변경 관련 사항 끝--------//
	
	//설비별 투입 중량 조회
	public List<WorkOrderVo> inputWeightList(WorkOrderVo workOrderVo) throws Exception;
	
	//생산전표 조회
	public List<WorkOrderVo> outputSubCntList(WorkOrderVo workOrderVo) throws Exception;
	
	
	
}