package mes.service.po;

import java.util.List;

import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.qm.GoodsFaultyAdmVo;

public interface WorkOrdOutputSubService {

	//전체목록 조회
	public List<WorkOrdOutputSubVo> workOrdOutputSubList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//상세목록 조회
	public WorkOrdOutputSubVo workOrdOutputSubRead(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//시퀀스 불러오기
	public String workOrdOutputSubSeq(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;	
	
	//수정
	public void workOrdOutputSubUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//트레이 외관 검사 관련  생산 실적 수정
	public void workOrdOutputSubTrayFaultyRelatedUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//workOrdLotNo 등록되어 있는지 확인
	public List<WorkOrdOutputSubVo> checkWorkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산LotNo(workOrdLotNo) 몸통 채번
	public String createWorkOrdLotNoBody(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산LotNo(workOrdLotNo) 끝 숫자 채번
	public int createWorkOrdLotNoCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산전표번호(ordLotNo) 몸통 채번
	public String createOrdLotNoBody(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산전표번호(ordLotNo) 숫자 채번
	public int createOrdLotNoCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산전표번호(ordLotNo) 끝 숫자 채번
	public int createOrdLotNoLastCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//해당 주야&전표일자&작업자로 등록된 작지LotNo가 있는지 확인
	public List<WorkOrdOutputSubVo> checkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//ordLotNo 채번
	//public String createOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;	
	
	//생성
	public void workOrdOutputSubCreate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//temp생성
	public void workOrdOutputSubCreateTemp(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//작지원장 수량업데이트
	public void updateMainWorkOrdOutput(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;	
	
	//삭제
	public void workOrdOutputSubDelete(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//작업지시 인쇄시 대상 ordLotNO 목록 조회
	public List<WorkOrdOutputSubVo> workOrdExcelDownOrdLotNoList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 작지인쇄 목록
	public List<WorkOrdOutputSubVo> workOrdExcelDownOrdLotNoList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//작지 완료시 각 주자재별로 생산실적이 최소 1개이상 입력되어있는지 체크
	public List<WorkOrdOutputSubVo> checkLotNoOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//작지 완료시 각 주자재별로 생산실적이 최소 1개이상 입력되어있는지 체크
	public int checkWorkOrdOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//선택 생산실적전표가 해당 작지의 가장 최근등록한 생산실적전표인지 확인
	public int checkWorkOrdOutputSubCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//작지&주재료로 등록된 생산실적 개수
	public int countLotNoOutput(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//제품 라벨발행 입력수량 임시저장
	public void updateWorkOrdAppearCnt(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산실적 포장 완료상태로 변경
	public void updateWorkOrdPublish(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//해당 생산LotNo 들 중 포장된 생산실적 외관검사 종료시점으로 복구
	public void updateWorkOrdLotNoUnpack(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	
	//MTP2동 비전불량수량 시퀀스 채번
	public String visionFaultyAdmSeq(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//MTP2동 생산 비전불량ADM 목록
	public List<WorkOrdOutputSubVo> readVisionFaultyAdmList_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//MTP2동 생산 비전불량ADM 목록
	public WorkOrdOutputSubVo readVisionFaultyAdm_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//MTP2동 생산 비전불량ADM 등록
	public void visionFaultyAdmInsert_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//MTP2동 생산 비전불량ADM 수정
	public void visionFaultyAdmUpdate_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//MTP2동 생산 비전불량ADM 삭제
	public void visionFaultyAdmDelete_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	
	
	//솔브레인SLD 엣지검사 목록
	public List<WorkOrdOutputSubVo> edgeCheckList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 엣지검사 등록
	public void edgeCheckInsert_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 엣지검사 수정
	public void edgeCheckUpdate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 엣지검사 코드화 삭제
	public void edgeCheckGoodsFaultyAdmCodeDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 외관검사 전표번호 등록
	public void appearCheckInsert_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 외관검사 전표번호 수정
	public void appearCheckUpdate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 외관검사 & 엣지검사 전표번호 삭제
	public void appearAndEdgeCheckDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//솔브레인SLD 외관검사 코드화 삭제
	public void appearCheckGoodsFaultyAdmCodeDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//Seq 순서대로 삭제할 수 있게 검사
	public WorkOrdOutputSubVo appearCheckSeqCount_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//삭제할 전표번호의 생산LotNo이후 채번된 생산LotNo가 존재하는지 확인
	public List<WorkOrdOutputSubVo> appearCheckWorkOrdLotNo_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	
	
	//엑셀 작지 외관검사 코드화 조회
	public List<GoodsFaultyAdmVo> excelGoodsFaultyAdmCodeList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;	
	
	//불량항목별 합계
	public GoodsFaultyAdmVo sumFaultyType(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산실적 등록자 업데이트
	public void registrantChange(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//등록자(생산작업자) 변경(수정)할 때 해당 생산전표번호가 바뀌었는지 확인
	public WorkOrdOutputSubVo checkChangeOrdLotNo_F1F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
		
}