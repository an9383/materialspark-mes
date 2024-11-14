package mes.service.po;

import java.util.List;

import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.WorkOrderVo;

public interface GoodsPackService {
	
	//작업지시서 계획 목록조회
	public List<WorkOrderVo> workOrderPackDataList(WorkOrderVo workOrderVo) throws Exception;
	
	//제품미포장 목록조회
	public List<GoodsProductInfoAdmVo> goodsUnPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품미포장 상세조회
	public GoodsProductInfoAdmVo readWorkOrdLotNoGoodsUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//TMP의 해당 생산LotNo 전체 삭제
	public void deleteWorkOrdLotNoGoodsProductTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;

	//제품미포장 상세조회
	public GoodsProductInfoAdmVo readGoodsUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//미제품포장의 특정 생산LotNo의 전표목록 조회
	public List<GoodsProductInfoAdmVo> goodsUnPackDtlList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산실적 작지 오더별 양품정보  수정
	public void updateWorkOrdAppearCnt(WorkOrderVo workOrderVo)  throws Exception;	
	
	//제품포장 목록조회(해외1,해외2,국내)
	public List<GoodsProductInfoAdmVo> goodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산실적라벨발행 등록
	public void createGoodsLabelPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
		
	//생산실적라벨발행 상세  등록
	public void createGoodsLabelPublishDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
		
	//생산실적라벨발행 수정
	public void updateGoodsLabelPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
		
	//생산실적라벨발행 상세 수정
	public void updateGoodsLabelPublishDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
		
	//생산실적라벨발행 미포장 목록조회(해외1,해외2,국내)
	public GoodsProductInfoAdmVo goodsPackTmpInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산실적라벨발행 미포장 목록조회(해외1,해외2,국내)
	public List<GoodsProductInfoAdmVo> goodsPackTmpInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산실적라벨발행 미포장 정보 포장정보로 등록(해외1,해외2,국내)
	public void createGoodsPackTmpToDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//미포장수량 포장 시 DTL 생성
	public void createGoodsPackDtlByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
		
	//생산실적라벨발행 미포장 정보 등록
	public void createGoodsLabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 미포장 정보 삭제
	public void deleteGoodsLabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//미포장수량 포장 시 TEMP 삭제
	public void deleteGoodsPackTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//미포장수량 포장 시 TEMP 수정(포장 후 잔여수량 조정)
	public void updateGoodsPackTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//TEMP의 RegDate asc 순으로 boxSeq 정렬
	public void updateBoxSeqTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 시퀀스 조회
	public int selectGoodsPackSeqCd(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적 작지 라벨발행 상태 수정
	public void updateWorkOrdPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장 Temp 복원정보 삭제
	public void deleteGoodsUnlabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장 복원정보 삭제(포장단위)
	public void deleteGoodsUnlabelPackUnitInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장 상세 복원정보 삭제(포장단위)
	public void deleteGoodsUnlabelPackUnitDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장상세정보 미포장정보로 이동 등록(해외1,해외2,국내)
	public void createGoodsPackDtlToTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장 복원정보 삭제(포장단위보다 작은 경우)
	public void deleteGoodsUnlabelNoPackUnitInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 포장 상세 복원정보 삭제(포장단위보다 작은 경우)
	public void deleteGoodsUnlabelNoPackUnitDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산실적라벨발행 복원후 마지막 작지번호 조회
	public GoodsProductInfoAdmVo selectGoodsPackLastWorkOrdNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//BoxNo에 포함된 WorkOrdNo 조회(생산라벨 발행 시 사용)
	public List<GoodsProductInfoAdmVo> selectBoxNoInOrdLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//BoxNo에 포함된 WorkOrdNo 조회(생산라벨 발행 시 사용)_실시간 포장변경 후
	public List<GoodsProductInfoAdmVo> selectBoxNoInOrdLotNo_new(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품라벨 최초 인쇄여부 Y로
	public void goodsPackPrintYnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//제품 폐기 대상 리스트 조회
	public List<GoodsProductInfoAdmVo> goodsDisuseListScan(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 폐기 대상 추적(Trace)
	public List<GoodsProductInfoAdmVo> traceDisuseBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 다중 추적(주재료)
	public List<GoodsProductInfoAdmVo> goodsTraceByMatrlLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 다중 추적(생산 포장번호)
	public List<GoodsProductInfoAdmVo> goodsTraceByBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//포장번호로 상세 주재료까지 검색
	public List<GoodsProductInfoAdmVo> selectGoodsByMatrlLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 다중 추적(PO 납기일) - 분할&병합되어서 출하
	public List<GoodsProductInfoAdmVo> goodsTraceByPurchaseDivision(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 다중 추적(PO 납기일)
	public List<GoodsProductInfoAdmVo> goodsTraceByPurchase(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 폐기
	public void goodsProductDisuse(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	///복원 시 제품 출하 여부 확인
	public List<GoodsProductInfoAdmVo> checkGoodsStatus(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 정보&출하주적 페이지 고객사LotNo 조회
	public List<GoodsProductInfoAdmVo> selectCustomerLotNo_F1F2F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;	
	
	//--분할 & 병합 관련--

	//분할 대상 boxNo 정보 조회(혼합 작지시 top1)
	public GoodsProductInfoAdmVo readDivisionMeargeBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품포장 정보(ADM) 조회
	public GoodsProductInfoAdmVo readGoodsProductInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품포장 정보(ADM) Tray 조회
	public GoodsProductInfoAdmVo readGoodsProductInfoByTray(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 분할 포장 가능 여부 확인
	public List<GoodsProductInfoAdmVo> divisionBoxNoListCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//제품 분할포장 시 원본 포장정보 확인
	public void createDivisionBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//분할 완료시 원장 제품번호 분할여부 Y로 업데이트
	public void updateGoodsInfoAdmDivision(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//분할&병합 제품리스트 조회
	public List<GoodsProductInfoAdmVo> readDivisionGoodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//분할 포장 제품 조회
	public GoodsProductInfoAdmVo readDivisionBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//분할 포장 제품 printYn 수정
	public GoodsProductInfoAdmVo goodsDivisionPackPrintYnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;

	//분할 테이블 삭제 실행
	public void deleveDivisionBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//복원 시 분할포장 되어있는지 작지번호로 체크
	public List<GoodsProductInfoAdmVo> divisionWorkOrdCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//제품 불량상태 변경
	public void changeGoodsProductFaultyType(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 불량 정상으로 변경
	public void changeFaultyStatusGood(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//복원 시 분할포장 되어있는지 작지번호로 체크
	public List<GoodsProductInfoAdmVo> goodsFaultyTypeDataList(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//부적합현황 대기 탭 리스트
	public List<GoodsProductInfoAdmVo> goodsFaultyTypeDataList_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//제품 상태변경시 기록쌓기
	public void insertGoodsProductHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산제품 상태이력 작지기준 삭제
	public void deleteGoodsProductiHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//생산제품 입출고내역
	public List<GoodsProductInfoAdmVo> goodsProductInOutHistList(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//생산제품 입출고내역2
	public List<GoodsProductInfoAdmVo> goodsProductInOutHistList2(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	
	/* 제품 포장로직 변경 후 */
	
	//해당 생산LotNo 잔여수량 0으로 모두 update
	public void updatePackRemainCntZero(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//해당 생산LotNo의 제일 마지막 전표번호를 포장후 잔여수량으로 update
	public void updatePackRemainCnt(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 포장번호별 복원 시 ADM 삭제
	public void deleteBoxNoGoodsProductAdm(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 포장번호별 복원 시 DTL 삭제
	public void deleteBoxNoGoodsProductDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//제품 포장번호별 복원 시 HIST 삭제
	public void deleteBoxNoGoodsProductHist(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//해당 제품 포장번호에 해당하는 Dtl 목록 조회
	public List<GoodsProductInfoAdmVo> readBoxNoGoodsProductDtlList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//해당 생산LotNo로 복원이 등록되었는지 확인
	public GoodsProductInfoAdmVo checkWorkOrdLotNoUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;

	//해당 생산LotNo로 복원TMP 생성
	public void createWorkOrdLotNoUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;

	//해당 생산LotNo로 복원TMP 잔여수량 수정
	public void updateWorkOrdLotNoUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//창고별 제품위치 전체조회
	public List<GoodsProductInfoAdmVo> locationList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//창고별 제품위치 박스번호가 존재하는 행 갯수 조회
	public int readlocationRowCount(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception;
	
	//트레이 번호로 작업지시 조회
	public GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
	
	//박스 폐기 지정
	public void updateDisAppoint(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception;
}