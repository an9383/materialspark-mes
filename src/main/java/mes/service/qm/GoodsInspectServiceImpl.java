package mes.service.qm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.EdgeGoodsFaultyAdmVo;
import mes.domain.qm.GoodsFaultyAdmVo;
import mes.persistence.qm.GoodsInspectDAO;

@Service
public class GoodsInspectServiceImpl implements GoodsInspectService {

	@Inject
	private GoodsInspectDAO dao;
	
	/*-- 엣지, 외관 공통사용 --*/
	//생산실적 상세조회
	@Override
	public WorkOrdOutputSubVo readWorkOrderOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		return dao.readWorkOrderOutputSub(workOrdOutputSubVo);
	}
	
	//생산실적 주자재를 기준으로 변경 후 ordLotNo 스캔
	@Override
	public WorkOrdOutputSubVo scanWorkOrdOutputSubOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		return dao.scanWorkOrdOutputSubOrdLotNo(workOrdOutputSubVo);
	}
	
	//scanWorkOrdLotNo _사용안할때 날짜별 전체 조회
	@Override
	public List<WorkOrdOutputSubVo> dateLookupAllWorkOrdLotNoList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		return dao.dateLookupAllWorkOrdLotNoList(workOrdOutputSubVo);
	}
	
	//제품 포장시 생산LotNo 스캔
	@Override
	public WorkOrdOutputSubVo scanWorkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		return dao.scanWorkOrdLotNo(workOrdOutputSubVo);
	}
	
	/*---엣지검사---*/
	//엣지검사 완료목록
	@Override
	public List<WorkOrdOutputSubVo> workOrderOutputSubList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		return dao.workOrderOutputSubList(workOrdOutputSubVo);
	}
	
	//엣지검사 등록(작업지시 Update)
	@Override
	public void edgeCheckInsert(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		dao.edgeCheckInsert(workOrdOutputSubVo);
	}
	
	//엣지검사 수정(작업지시 Update)
	@Override
	public void edgeCheckUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		dao.edgeCheckUpdate(workOrdOutputSubVo);
	}
	
	//엣지검사 상세조회 (엣지불량 TB Read) 코드화
	@Override
	public List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCode(EdgeGoodsFaultyAdmVo vo) throws Exception{
		return dao.readEdgeGoodsFaultyAdmCode(vo);
	}
	
	//(트레이)엣지검사 상세조회 (엣지불량 TB Read) 코드화
	@Override
	public List<EdgeGoodsFaultyAdmVo> readTrayEdgeGoodsFaultyAdmCode(EdgeGoodsFaultyAdmVo vo) throws Exception{
		return dao.readTrayEdgeGoodsFaultyAdmCode(vo);
	}
	
	//엣지검사 등록(엣지불량 TB Insert) - 코드화
	@Override
	public void edgeCheckInsertCode(EdgeGoodsFaultyAdmVo vo) throws Exception{
		dao.edgeCheckInsertCode(vo);
	}
	
	//엣지검사 수정(엣지불량  TB Update) - 코드화
	@Override
	public void edgeCheckUpdateCode(EdgeGoodsFaultyAdmVo vo) throws Exception{
		dao.edgeCheckUpdateCode(vo);
	}
	
	//엣지검사 삭제 - 코드화
	@Override
	public void edgeCheckDeleteCode(EdgeGoodsFaultyAdmVo vo) throws Exception{
		dao.edgeCheckDeleteCode(vo);
	}
	
	//엣지검사 불량 리스트 조회 시퀀스화
	@Override
	public List<EdgeGoodsFaultyAdmVo> readEdgeGoodsFaultyAdmCodeList(EdgeGoodsFaultyAdmVo vo) throws Exception{
		return dao.readEdgeGoodsFaultyAdmCodeList(vo);
	}
	
	//엣지검사 불량 시퀀스 조회
	@Override
	public EdgeGoodsFaultyAdmVo selectEdgeGoodsFaultyAdmCodeSeq(EdgeGoodsFaultyAdmVo vo) throws Exception{
		return dao.selectEdgeGoodsFaultyAdmCodeSeq(vo);
	}
	
	//엣지검사 등록(외관불량 TB Insert) 코드화 및 시퀀스화
	@Override
	public void edgeCheckInsertCodeSeq(EdgeGoodsFaultyAdmVo vo) throws Exception{
		dao.edgeCheckInsertCodeSeq(vo);
	}
	
	//엣지검사 삭제 - 시퀀스화
	@Override
	public void edgeCheckDeleteSeq(EdgeGoodsFaultyAdmVo vo) throws Exception{
		dao.edgeCheckDeleteSeq(vo);
	}
		
	/*---외관검사---*/
	//날짜로 외관검사 등록한 작업지시List 조회
	@Override
	public List<WorkOrderVo> goodsFaultyAdmDataList(WorkOrderVo Vo) throws Exception {
		return dao.goodsFaultyAdmDataList(Vo);
	}
	
	//외관검사 등록(외관불량 수량 등록)
	@Override
	public void appearCheckInsert(GoodsFaultyAdmVo Vo) throws Exception {
		dao.appearCheckInsert(Vo);
	}
	
	//외관검사 생산실적등록 시 작지상태 변경(생산실적 Update)
	@Override
	public void appearWorkOrderSubInsert(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		dao.appearWorkOrderSubInsert(workOrdOutputSubVo);
	}
	
	//외관검사 수정(작업지시 Update)
	@Override
	public void appearWorkOrderUpdate(WorkOrderVo Vo) throws Exception {
		dao.appearWorkOrderUpdate(Vo);
	}
	
	//외관검사 수정(외관불량 TB Update)
	@Override
	public void appearCheckUpdate(GoodsFaultyAdmVo Vo) throws Exception {
		dao.appearCheckUpdate(Vo);
	}
	
	//외관불량 상세조회
	@Override
	public GoodsFaultyAdmVo readGoodsFaultyAdm(GoodsFaultyAdmVo Vo) throws Exception {
		return dao.readGoodsFaultyAdm(Vo);
	}
	
	//외관검사 등록(외관불량 TB Insert) - 코드화
	@Override
	public void appearCheckInsertCode(GoodsFaultyAdmVo vo) throws Exception{
		dao.appearCheckInsertCode(vo);
	}
	
	//외관검사 수정(외관불량 TB Update) - 코드화
	@Override
	public void appearCheckUpdateCode(GoodsFaultyAdmVo vo) throws Exception{
		dao.appearCheckUpdateCode(vo);
	}
	
	//외관불량 상세조회 List 조회 - 코드화
	@Override
	public List<GoodsFaultyAdmVo> readGoodsFaultyAdmCode(GoodsFaultyAdmVo vo) throws Exception{
		return dao.readGoodsFaultyAdmCode(vo);
	}
	
	//(트레이)외관불량 상세조회 List 조회 - 코드화
	@Override
	public List<GoodsFaultyAdmVo> readTrayGoodsFaultyAdmCode(GoodsFaultyAdmVo vo) throws Exception{
		return dao.readTrayGoodsFaultyAdmCode(vo);
	}
	
	//외관검사 삭제 - 코드화
	@Override
	public void appearCheckDeleteCode(GoodsFaultyAdmVo vo) throws Exception{
		dao.appearCheckDeleteCode(vo);
	}
	
	//외관검사 불량 리스트 조회 시퀀스화
	@Override
	public List<GoodsFaultyAdmVo> readGoodsFaultyAdmCodeList(GoodsFaultyAdmVo vo) throws Exception{
		return dao.readGoodsFaultyAdmCodeList(vo);
	}
	
	//외관검사 불량 시퀀스 조회
	@Override
	public GoodsFaultyAdmVo selectGoodsFaultyAdmCodeSeq(GoodsFaultyAdmVo vo) throws Exception{
		return dao.selectGoodsFaultyAdmCodeSeq(vo);
	}
	
	//외관검사 등록(외관불량 TB Insert) 코드화 및 시퀀스화
	@Override
	public void appearCheckInsertCodeSeq(GoodsFaultyAdmVo vo) throws Exception{
		dao.appearCheckInsertCodeSeq(vo);
	}
	
	//외관검사 불량전표번호 조회
	@Override
	public String selectGoodsFaultyAdmCodeOrdLotNo(GoodsFaultyAdmVo vo) throws Exception{
		return dao.selectGoodsFaultyAdmCodeOrdLotNo(vo);
	}
	
	//생산팀 비전불량수량 상세조회
	@Override
	public List<GoodsFaultyAdmVo> readVisionFaultCodeList_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.readVisionFaultCodeList_F2(goodsFaultyAdmVo);
	}
	
	//생산팀 비전불량수량 등록
	@Override
	public void visionFaultyAdmCodeInsert_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		dao.visionFaultyAdmCodeInsert_F2(goodsFaultyAdmVo);
	}
	
	//생산팀 비전불량수량 삭제
	@Override
	public void visionFaultyAdmCodeDelete_F2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		dao.visionFaultyAdmCodeDelete_F2(goodsFaultyAdmVo);
	}
	
	
	//생산전표 미포장으로 변환시의 Seq채번
	@Override
	public int packNumberSeq(String today) throws Exception {
		return dao.packNumberSeq(today);
	}
	
	//미포장 변환 젼표번호 채번 후 해당 생산전표번호들 포장여부와 같이 Update
	@Override
	public void updateOrdLotNoPackNumber(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		dao.updateOrdLotNoPackNumber(workOrdOutputSubVo);
	}
	
	/*---생산실적관리---*/
	//생산실적관리 작업지시 날짜로 상세조회
	@Override
	public List<WorkOrderVo> readActualOutputDataList(WorkOrderVo Vo) throws Exception {
		return dao.readActualOutputDataList(Vo);
	}
	
	//생산실적관리 작업지시 날짜로 상세조회 - eisc0010
	@Override
	public List<WorkOrderVo> actualOutputDataList_eisc0010(WorkOrderVo Vo) throws Exception {
		return dao.readActualOutputDataList(Vo);
	}
	
	//외관검사 삭제 - 시퀀스화
	@Override
	public void appearCheckDeleteSeq(GoodsFaultyAdmVo vo) throws Exception{
		dao.appearCheckDeleteSeq(vo);
	}
	
	
	/*---생산현황조회---*/
	//생산현황 기간으로 상세조회
	@Override
	public List<WorkOrderVo> readTotalActualOutputDataList(WorkOrderVo Vo) throws Exception {
		return dao.readTotalActualOutputDataList(Vo);
	}
	
	
	//불량집계현황(기간) 기간별 조회
	public List<Map<String,String>> faultyWeekTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyWeekTotalList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 기간별 조회-Fa2
	public List<Map<String,String>> faultyWeekTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyWeekTotalListFa2(goodsFaultyAdmVo);
	}
	
	//생산검사집계(통합)(기간) 기간별 조회-Fa2
	public List<Map<String,String>> faultyWeekTotalSumListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyWeekTotalSumListFa2(goodsFaultyAdmVo);
	}
	
	//불량집계현황(공정) 공정별 조회-Fa2
	public List<Map<String,String>> faultyProcessTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyProcessTotalListFa2(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyGoodsTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyGoodsTotalList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyGoodsTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyGoodsTotalListFa2(goodsFaultyAdmVo);
	}
	
	//생산검사집계(통합)(제품) 기간별 조회-Fa2
	public List<Map<String,String>> faultyGoodsTotalSumListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyGoodsTotalSumListFa2(goodsFaultyAdmVo);
	}
		
	//불량집계현황(기간) 유형별 조회
	public List<GoodsFaultyAdmVo> faultyTypeTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyTypeTotalList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 유형별 조회-Fa2
	public List<GoodsFaultyAdmVo> faultyTypeTotalListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyTypeTotalListFa2(goodsFaultyAdmVo);
	}
		
	//불량집계현황(기간) 불량별 조회
	public List<Map<String,String>> faultyEquipTotalDataList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipTotalDataList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 불량별 조회-Fa2
	public List<Map<String,String>> faultyEquipTotalDataListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipTotalDataListFa2(goodsFaultyAdmVo);
	}
	
	//생산검사집계(통합)(설비) 기간별 조회-Fa2
	public List<Map<String,String>> faultyEquipTotalSumDataListFa2(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipTotalSumDataListFa2(goodsFaultyAdmVo);
	}
	
	//(최종검사집계) 날짜로 설비별/주야별/제품별 리스트 조회
	public List<Map<String,String>> faultyEquipGoodsTotalListFa(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipGoodsTotalListFa(goodsFaultyAdmVo);
	}
	
	////생산검사집계(통합)(설비별 주야/제품) 기간별 조회-Fa2
	public List<Map<String,String>> faultyEquipGoodsTotalSumListFa(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipGoodsTotalSumListFa(goodsFaultyAdmVo);
	}
	
	//(최종검사집계) 날짜로 설비별/주야별/제품별 리스트 조회 3공장 SLD
	public List<Map<String,String>> faultyEquipGoodsTotalListFa3(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyEquipGoodsTotalListFa3(goodsFaultyAdmVo);
	}
		
	//일일업무실적보고 1동 Header
	@Override
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkHeader(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.goodsInspectDailyWorkHeader(goodsFaultyAdmVo);
	}
	
	//일일업무실적보고 1동 통계 현황(21.11.29 부터 생산실적 기준)
	@Override
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkContent(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception {
		return dao.goodsInspectDailyWorkContent(goodsFaultyAdmVo);
	}
	
	//일일업무실적보고 1동 통계 현황(21.11.28 까지 작업지시기준)
	@Override
	public List<GoodsFaultyAdmVo> goodsInspectDailyWorkContentOld(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception {
		return dao.goodsInspectDailyWorkContentOld(goodsFaultyAdmVo);
	}
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검포함 리스트 조회 - Fa2
	@Override
	public List<Map<String,String>> faultyWorkOrdNoReInspListFa(WorkOrderVo vo) throws Exception{
		return dao.faultyWorkOrdNoReInspListFa(vo);
	}
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검포함 집계 리스트 조회 - Fa2
	@Override
	public List<Map<String,String>> faultyWorkOrdNoReInspTotalListFa(WorkOrderVo vo) throws Exception{
		return dao.faultyWorkOrdNoReInspTotalListFa(vo);
	}
	
	//(생산검사현황) 외관검사 날짜로 작지별/주야별 재검만 리스트 조회
	@Override
	public List<Map<String,String>> faultyWorkOrdNoReInspOnlyListFa(WorkOrderVo vo) throws Exception{
		return dao.faultyWorkOrdNoReInspOnlyListFa(vo);
	}
	
	
	
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyInitialGoodsTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyInitialGoodsTotalList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyByWeekTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyByWeekTotalList(goodsFaultyAdmVo);
	}
	
	//불량집계현황(기간) 제품별 조회
	public List<Map<String,String>> faultyByMonthTotalList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return dao.faultyByMonthTotalList(goodsFaultyAdmVo);
	}
}