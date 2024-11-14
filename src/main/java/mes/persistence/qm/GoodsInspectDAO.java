package mes.persistence.qm;

import java.util.List;
import java.util.Map;

import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.EdgeGoodsFaultyAdmVo;
import mes.domain.qm.GoodsFaultyAdmVo;

public interface GoodsInspectDAO {

	/*-- 엣지, 외관 공통사용 --*/
	//생산실적 상세조회
	public WorkOrdOutputSubVo readWorkOrderOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//생산실적 주자재를 기준으로 변경 후 ordLotNo 스캔
	public WorkOrdOutputSubVo scanWorkOrdOutputSubOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//scanWorkOrdLotNo _사용안할때 날짜별 전체 조회
	public List<WorkOrdOutputSubVo> dateLookupAllWorkOrdLotNoList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//제품 포장시 생산LotNo 스캔
	public WorkOrdOutputSubVo scanWorkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	/*---엣지검사---*/
	//엣지검사 완료목록
	public List<WorkOrdOutputSubVo> workOrderOutputSubList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//엣지검사 등록(생산실적 Update)
	public void edgeCheckInsert(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//엣지검사 수정(생산실적 Update)
	public void edgeCheckUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//엣지검사 상세조회 (엣지불량 TB Read) 코드화
	public List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCode(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 상세조회 (엣지불량 TB Read) 코드화
	public List<EdgeGoodsFaultyAdmVo> readTrayEdgeGoodsFaultyAdmCode(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//(트레이)엣지검사 등록(엣지불량  TB Insert) - 코드화
	public void edgeCheckInsertCode(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 수정(엣지불량  TB Update) - 코드화
	public void edgeCheckUpdateCode(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 삭제(엣지불량  TB delete) - 코드화
	public void edgeCheckDeleteCode(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 불량 리스트 조회 시퀀스화
	public List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCodeList(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 불량 시퀀스 조회
	public EdgeGoodsFaultyAdmVo selectEdgeGoodsFaultyAdmCodeSeq(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 등록(외관불량 TB Insert) 코드화 및 시퀀스화
	public void edgeCheckInsertCodeSeq(EdgeGoodsFaultyAdmVo vo) throws Exception;
	
	//엣지검사 삭제 - 시퀀스화
	public void edgeCheckDeleteSeq(EdgeGoodsFaultyAdmVo vo) throws Exception;
		
		
	
	/*----외관검사----*/
	//날짜로 외관검사 등록한 작업지시List 조회
	public List<WorkOrderVo> goodsFaultyAdmDataList(WorkOrderVo vo) throws Exception;
	
	//외관검사 등록(외관불량 수량 등록)
	public void appearCheckInsert(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 생산실적등록 시 작지상태 변경(생산실적 Update)
	public void appearWorkOrderSubInsert(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	//외관검사 수정(작업지시 Update)
	public void appearWorkOrderUpdate(WorkOrderVo vo) throws Exception;
	
	//외관검사 수정(외관불량 TB Update)
	public void appearCheckUpdate(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관불량 상세조회
	public GoodsFaultyAdmVo readGoodsFaultyAdm(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 등록(외관불량 TB Insert) - 코드화
	public void appearCheckInsertCode(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 수정(외관불량 TB Update) - 코드화
	public void appearCheckUpdateCode(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관불량 상세조회 List 조회 - 코드화
	public List<GoodsFaultyAdmVo> readGoodsFaultyAdmCode(GoodsFaultyAdmVo vo) throws Exception;
	
	//(트레이)외관불량 상세조회 List 조회 - 코드화
	public List<GoodsFaultyAdmVo> readTrayGoodsFaultyAdmCode(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 삭제 - 코드화
	public void appearCheckDeleteCode(GoodsFaultyAdmVo vo) throws Exception;
	
	

	//외관검사 불량 리스트 조회 시퀀스화
	public List<GoodsFaultyAdmVo> readGoodsFaultyAdmCodeList(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 불량 시퀀스 조회
	public GoodsFaultyAdmVo selectGoodsFaultyAdmCodeSeq(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 등록(외관불량 TB Insert) 코드화 및 시퀀스화
	public void appearCheckInsertCodeSeq(GoodsFaultyAdmVo vo) throws Exception;
	
	//외관검사 불량전표번호 조회
	public String selectGoodsFaultyAdmCodeOrdLotNo(GoodsFaultyAdmVo vo) throws Exception;	
	
	//외관검사 삭제 - 시퀀스화
	public void appearCheckDeleteSeq(GoodsFaultyAdmVo vo) throws Exception;
	
	//생산팀 비전불량수량 상세조회
	public List<GoodsFaultyAdmVo> readVisionFaultCodeList_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산팀 비전불량수량 등록
	public void visionFaultyAdmCodeInsert_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산팀 비전불량수량 삭제
	public void visionFaultyAdmCodeDelete_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	
	
	//생산전표 미포장으로 변환시의 Seq채번
	public int packNumberSeq(String today) throws Exception;
	
	//미포장 변환 젼표번호 채번 후 해당 생산전표번호들 포장여부와 같이 Update
	public void updateOrdLotNoPackNumber(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception;
	
	/*---생산실적관리---*/
	//생산실적관리 작업지시 날짜로 상세조회
	public List<WorkOrderVo> readActualOutputDataList(WorkOrderVo vo) throws Exception;
	
	//생산실적관리 작업지시 날짜로 상세조회 - eisc0010
	public List<WorkOrderVo> actualOutputDataList_eisc0010(WorkOrderVo vo) throws Exception;
	
	/*---생산현황조회---*/
	//생산현황 기간으로 상세조회
	public List<WorkOrderVo> readTotalActualOutputDataList(WorkOrderVo vo) throws Exception;
	
	//불량집계현황(기간) 기간별 조회
	public List<Map<String,String>> faultyWeekTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 기간별 조회-Fa2
	public List<Map<String,String>> faultyWeekTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산검사집계(통합)(기간) 기간별 조회-Fa2
	public List<Map<String,String>> faultyWeekTotalSumListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(공정) 공정별 조회-Fa2
	public List<Map<String,String>> faultyProcessTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
		
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyGoodsTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 제품별 조회-Fa2
	public List<Map<String,String>> faultyGoodsTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산검사집계(통합)(제품) 기간별 조회-Fa2
	public List<Map<String,String>> faultyGoodsTotalSumListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
		
	//불량집계현황(기간) 유형별 조회
	public List<GoodsFaultyAdmVo> faultyTypeTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 유형별 조회-Fa2
	public List<GoodsFaultyAdmVo> faultyTypeTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 불량별 조회
	public List<Map<String,String>> faultyEquipTotalDataList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 불량별 조회 Fa2
	public List<Map<String,String>> faultyEquipTotalDataListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산검사집계(통합)(설비) 기간별 조회-Fa2
	public List<Map<String,String>> faultyEquipTotalSumDataListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//(최종검사집계) 날짜로 설비별/주야별/제품별 리스트 조회
	public List<Map<String,String>> faultyEquipGoodsTotalListFa(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//생산검사집계(통합)(설비별 주야/제품) 기간별 조회-Fa2
	public List<Map<String,String>> faultyEquipGoodsTotalSumListFa(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//(최종검사집계) 날짜로 설비별/주야별/제품별 리스트 조회 3공장 SLD
	public List<Map<String,String>> faultyEquipGoodsTotalListFa3(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//일일업무실적보고 1동 Header
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkHeader(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//일일업무실적보고 1동 통계 현황(21.11.29 부터 생산실적 기준)
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkContent(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//일일업무실적보고 1동 통계 현황(21.11.28 까지 작업지시기준)
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkContentOld(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검포함 리스트 조회 - Fa2
	public List<Map<String,String>> faultyWorkOrdNoReInspListFa(WorkOrderVo vo) throws Exception;
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검포함 집계 리스트 조회 - Fa2
	public List<Map<String,String>> faultyWorkOrdNoReInspTotalListFa(WorkOrderVo vo) throws Exception;
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검만 리스트 조회
	public List<Map<String,String>> faultyWorkOrdNoReInspOnlyListFa(WorkOrderVo vo) throws Exception;
	
	
	
	//불량집계현황(기간) 제품별 조회-Fa2
	public List<Map<String,String>> faultyInitialGoodsTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 제품별 조회-Fa2
	public List<Map<String,String>> faultyByWeekTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
	//불량집계현황(기간) 제품별 조회-Fa2
	public List<Map<String,String>> faultyByMonthTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception;
	
}