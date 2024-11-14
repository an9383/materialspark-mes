package mes.service.po;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.persistence.po.GoodsPackDAO;

@Service
public class GoodsPackServiceImpl implements GoodsPackService {

	@Inject
	private GoodsPackDAO dao;

	//작업지시서 목록조회
	@Override
	public List<WorkOrderVo> workOrderPackDataList(WorkOrderVo workOrderVo) throws Exception {
		return dao.workOrderPackDataList(workOrderVo);
	}
	
	//제품미포장 목록조회
	@Override
	public List<GoodsProductInfoAdmVo> goodsUnPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsUnPackList(goodsProductInfoAdmVo);
	}
	
	//제품미포장 상세조회
	@Override
	public GoodsProductInfoAdmVo readWorkOrdLotNoGoodsUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.readWorkOrdLotNoGoodsUnPack(goodsProductInfoAdmVo);
	}
	
	//TMP의 해당 생산LotNo 전체 삭제
	@Override
	public void deleteWorkOrdLotNoGoodsProductTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		dao.deleteWorkOrdLotNoGoodsProductTmp(goodsProductInfoAdmVo);
	}
	
	//제품미포장 상세조회
	@Override
	public GoodsProductInfoAdmVo readGoodsUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.readGoodsUnPack(goodsProductInfoAdmVo);
	}
	
	//미제품포장의 특정 생산LotNo의 전표목록 조회
	@Override
	public List<GoodsProductInfoAdmVo> goodsUnPackDtlList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsUnPackDtlList(goodsProductInfoAdmVo);
	}
	
	//생산실적 작지 오더별 양품정보  수정
	@Override
	public void updateWorkOrdAppearCnt(WorkOrderVo workOrderVo)  throws Exception {
		dao.updateWorkOrdAppearCnt(workOrderVo);
	}
	
	
	 
	//제품포장 목록조회(해외1,해외2,국내)
	 @Override
	 public List<GoodsProductInfoAdmVo> goodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.goodsPackList(goodsProductInfoAdmVo);
	 }	 
	 
	//생산실적라벨발행 등록
	 @Override
	 public void createGoodsLabelPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.createGoodsLabelPublish(goodsProductInfoAdmVo);
	 }	 
	 
	//생산실적라벨발행 상세  등록
	 @Override
	 public void createGoodsLabelPublishDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.createGoodsLabelPublishDtl(goodsProductInfoAdmVo);
	 }	
	 
	//생산실적라벨발행 수정
	 @Override
	 public void updateGoodsLabelPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.updateGoodsLabelPublish(goodsProductInfoAdmVo);
	 }
	 
	//생산실적라벨발행 상세 수정
	 @Override
	 public void updateGoodsLabelPublishDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.updateGoodsLabelPublishDtl(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 미포장 목록조회(해외1,해외2,국내)
	 @Override
	 public GoodsProductInfoAdmVo goodsPackTmpInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.goodsPackTmpInfo(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 미포장 목록조회(해외1,해외2,국내)
	 @Override
	 public List<GoodsProductInfoAdmVo> goodsPackTmpInfoList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.goodsPackTmpInfoList(goodsProductInfoAdmVo);
	 }

	 //미포장수량 포장 시 DTL 생성
	 @Override
	 public void createGoodsPackTmpToDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.createGoodsPackTmpToDtl(goodsProductInfoAdmVo);
	 }
	 
	//생산실적라벨발행 미포장 정보 포장정보로 등록(해외1,해외2,국내)
	@Override
	public void createGoodsPackDtlByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		dao.createGoodsPackDtlByRemainPack(goodsProductInfoAdmVo);
	}
	 
	 //생산실적라벨발행 미포장 정보 등록
	 @Override
	 public void createGoodsLabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.createGoodsLabelTmp(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 미포장 정보 삭제
	 @Override
	 public void deleteGoodsLabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsLabelTmp(goodsProductInfoAdmVo);
	 }	 
	 
	 //생산실적라벨발행 미포장 정보 삭제
	 @Override
	 public void deleteGoodsPackTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsPackTmpByRemainPack(goodsProductInfoAdmVo);
	 }
	 
	//미포장수량 포장 시 TEMP 수정(포장 후 잔여수량 조정)
	@Override
	public void updateGoodsPackTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		dao.updateGoodsPackTmpByRemainPack(goodsProductInfoAdmVo);
	}
	
	//TEMP의 RegDate asc 순으로 boxSeq 정렬
	@Override
	public void updateBoxSeqTmpByRemainPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		dao.updateBoxSeqTmpByRemainPack(goodsProductInfoAdmVo);
	}
	 
	 //생산실적라벨발행 시퀀스 조회
	 @Override
	 public int selectGoodsPackSeqCd(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.selectGoodsPackSeqCd(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적 작지 라벨발행 상태 수정
	 @Override
	 public void updateWorkOrdPublish(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.updateWorkOrdPublish(goodsProductInfoAdmVo);
	 }
	 //생산실적라벨발행 포장 Temp 복원정보 삭제
	 @Override
	 public void deleteGoodsUnlabelTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsUnlabelTmp(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 포장 복원정보 삭제(포장단위)
	 @Override
	 public void deleteGoodsUnlabelPackUnitInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsUnlabelPackUnitInfo(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 포장 상세 복원정보 삭제(포장단위)
	 @Override
	 public void deleteGoodsUnlabelPackUnitDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsUnlabelPackUnitDtl(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 포장상세정보 미포장정보로 이동 등록(해외1,해외2,국내)
	 @Override
	 public void createGoodsPackDtlToTmp(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.createGoodsPackDtlToTmp(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 포장 복원정보 삭제(포장단위보다 작은 경우)
	 @Override
	 public void deleteGoodsUnlabelNoPackUnitInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsUnlabelNoPackUnitInfo(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 포장 상세 복원정보 삭제(포장단위보다 작은 경우)
	 @Override
	 public void deleteGoodsUnlabelNoPackUnitDtl(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsUnlabelNoPackUnitDtl(goodsProductInfoAdmVo);
	 }
	 
	 //생산실적라벨발행 복원후 마지막 작지번호 조회
	 @Override
	 public GoodsProductInfoAdmVo selectGoodsPackLastWorkOrdNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception {
		 return  dao.selectGoodsPackLastWorkOrdNo(goodsProductInfoAdmVo);
	 }

	//BoxNo에 포함된 WorkOrdNo 조회(생산라벨 발행 시 사용)
	@Override
	public List<GoodsProductInfoAdmVo> selectBoxNoInOrdLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.selectBoxNoInOrdLotNo(goodsProductInfoAdmVo);
	}
	
	//BoxNo에 포함된 WorkOrdNo 조회(생산라벨 발행 시 사용)_실시간 포장변경 후
	@Override
	public List<GoodsProductInfoAdmVo> selectBoxNoInOrdLotNo_new(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.selectBoxNoInOrdLotNo_new(goodsProductInfoAdmVo);
	}
	
	//제품라벨 최초 인쇄여부 Y로
	@Override
	public void goodsPackPrintYnUpdate(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.goodsPackPrintYnUpdate(goodsProductInfoAdmVo);
	}
	
	//제품 폐기 대상 리스트 조회
	@Override
	public List<GoodsProductInfoAdmVo> goodsDisuseListScan(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.goodsDisuseListScan(goodsProductInfoAdmVo);
	}
	
	//제품 폐기 대상 추적(Trace)
	@Override
	public List<GoodsProductInfoAdmVo> traceDisuseBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.traceDisuseBoxNo(goodsProductInfoAdmVo);
	}
	
	//제품 다중 추적(주재료)
	@Override
	public List<GoodsProductInfoAdmVo> goodsTraceByMatrlLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsTraceByMatrlLotNo(goodsProductInfoAdmVo);
	}
	
	//제품 다중 추적(생산 포장번호)
	@Override
	public List<GoodsProductInfoAdmVo> goodsTraceByBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsTraceByBoxNo(goodsProductInfoAdmVo);
	}
	
	//포장번호로 상세 주재료까지 검색
	@Override
	public List<GoodsProductInfoAdmVo> selectGoodsByMatrlLotNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.selectGoodsByMatrlLotNo(goodsProductInfoAdmVo);
	}
	
	//제품 다중 추적(PO 납기일) - 분할&병합되어서 출하
	@Override
	public List<GoodsProductInfoAdmVo> goodsTraceByPurchaseDivision(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsTraceByPurchaseDivision(goodsProductInfoAdmVo);
	}
	
	//제품 다중 추적(PO 납기일)
	@Override
	public List<GoodsProductInfoAdmVo> goodsTraceByPurchase(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsTraceByPurchase(goodsProductInfoAdmVo);
	}
	
	//제품 폐기
	@Override
	public void goodsProductDisuse(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.goodsProductDisuse(goodsProductInfoAdmVo);
	}
	
	//복원 시 제품 출하 여부 확인
	@Override
	public List<GoodsProductInfoAdmVo> checkGoodsStatus(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.checkGoodsStatus(goodsProductInfoAdmVo);
	}
	
	//제품 정보&출하주적 페이지 고객사LotNo 조회
	@Override
	public List<GoodsProductInfoAdmVo> selectCustomerLotNo_F1F2F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.selectCustomerLotNo_F1F2F3(goodsProductInfoAdmVo);
	}
	
	//--분할 & 병합 관련--
	//분할 대상 boxNo 정보 조회(혼합 작지시 top1)
	@Override
	public GoodsProductInfoAdmVo readDivisionMeargeBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.readDivisionMeargeBoxNo(goodsProductInfoAdmVo);
	}
	
	//제품포장 정보(ADM) 조회
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.readGoodsProductInfo(goodsProductInfoAdmVo);
	}
	
	//제품포장 정보(ADM) 조회
	@Override
	public GoodsProductInfoAdmVo readGoodsProductInfoByTray(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.readGoodsProductInfoByTray(goodsProductInfoAdmVo);
	}
	
	//제품 분할 포장 가능 여부 확인
	@Override
	public List<GoodsProductInfoAdmVo> divisionBoxNoListCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.divisionBoxNoListCheck(goodsProductInfoAdmVo);
	}

	//제품 분할포장 시 원본 포장정보 확인
	@Override
	public void createDivisionBoxNo(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.createDivisionBoxNo(goodsProductInfoAdmVo);
	}
	
	//분할 완료시 원장 제품번호 분할여부 Y로 업데이트
	@Override
	public void updateGoodsInfoAdmDivision(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.updateGoodsInfoAdmDivision(goodsProductInfoAdmVo);
	}
	
	//분할&병합 제품리스트 조회
	@Override
	public List<GoodsProductInfoAdmVo> readDivisionGoodsPackList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.readDivisionGoodsPackList(goodsProductInfoAdmVo);
	}
	
	//분할 포장 제품 조회
	@Override
	public GoodsProductInfoAdmVo readDivisionBoxNo(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.readDivisionBoxNo(goodsProductInfoAdmVo);
	}
	
	//분할 포장 제품 printYn 수정
	@Override
	public GoodsProductInfoAdmVo goodsDivisionPackPrintYnUpdate(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 return dao.goodsDivisionPackPrintYnUpdate(goodsProductInfoAdmVo);
	}
	
	//분할 테이블 삭제 실행
	@Override
	public void deleveDivisionBoxNo(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.deleveDivisionBoxNo(goodsProductInfoAdmVo);
	}
	
	//복원 시 분할포장 되어있는지 작지번호로 체크
	@Override
	public List<GoodsProductInfoAdmVo> divisionWorkOrdCheck(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.divisionWorkOrdCheck(goodsProductInfoAdmVo);
	}
	
	//제품 불량상태 변경
	@Override
	public void changeGoodsProductFaultyType(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.changeGoodsProductFaultyType(goodsProductInfoAdmVo);
	}
	
	//제품 불량 정상으로 변경
	@Override
	public void changeFaultyStatusGood(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		 dao.changeFaultyStatusGood(goodsProductInfoAdmVo);
	}
	
	//검사반출&불량&폐기&대기 제품상태 목록
	@Override
	public List<GoodsProductInfoAdmVo> goodsFaultyTypeDataList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsFaultyTypeDataList(goodsProductInfoAdmVo);
	}
	
	//부적합현황 대기 탭 리스트
	@Override
	public List<GoodsProductInfoAdmVo> goodsFaultyTypeDataList_F3(GoodsProductInfoAdmVo goodsProductInfoAdmVo)  throws Exception{
		return dao.goodsFaultyTypeDataList_F3(goodsProductInfoAdmVo);
	}
	
	//제품 상태변경시 기록쌓기
	@Override
	public void insertGoodsProductHist(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.insertGoodsProductHist(goodsProductInfoAdmVo);
	}
	
	//생산제품 상태이력 작지기준 삭제
	@Override
	public void deleteGoodsProductiHist(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteGoodsProductiHist(goodsProductInfoAdmVo);
	}
	
	//생산제품 입출고내역
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductInOutHistList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsProductInOutHistList(goodsProductInfoAdmVo);
	}
	
	//생산제품 입출고내역2
	@Override
	public List<GoodsProductInfoAdmVo> goodsProductInOutHistList2(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.goodsProductInOutHistList2(goodsProductInfoAdmVo);
	}
	
	
	/* 제품 포장로직 변경 후 */
	
	//해당 생산LotNo 잔여수량 0으로 모두 update
	@Override
	public void updatePackRemainCntZero(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.updatePackRemainCntZero(goodsProductInfoAdmVo);
	}
	
	//해당 생산LotNo의 제일 마지막 전표번호를 포장후 잔여수량으로 update
	@Override
	public void updatePackRemainCnt(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.updatePackRemainCnt(goodsProductInfoAdmVo);
	}
	
	//제품 포장번호별 복원 시 ADM 삭제
	@Override
	public void deleteBoxNoGoodsProductAdm(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteBoxNoGoodsProductAdm(goodsProductInfoAdmVo);
	}
	
	//제품 포장번호별 복원 시 DTL 삭제
	@Override
	public void deleteBoxNoGoodsProductDtl(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteBoxNoGoodsProductDtl(goodsProductInfoAdmVo);
	}
	
	//제품 포장번호별 복원 시 HIST 삭제
	@Override
	public void deleteBoxNoGoodsProductHist(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.deleteBoxNoGoodsProductHist(goodsProductInfoAdmVo);
	}
	
	//해당 제품 포장번호에 해당하는 Dtl 목록 조회
	@Override
	public List<GoodsProductInfoAdmVo> readBoxNoGoodsProductDtlList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.readBoxNoGoodsProductDtlList(goodsProductInfoAdmVo);
	}
	
	//해당 생산LotNo로 복원이 등록되었는지 확인
	@Override
	public GoodsProductInfoAdmVo checkWorkOrdLotNoUnPack(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.checkWorkOrdLotNoUnPack(goodsProductInfoAdmVo);
	}
	
	//해당 생산LotNo로 복원TMP 생성
	@Override
	public void createWorkOrdLotNoUnPack(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.createWorkOrdLotNoUnPack(goodsProductInfoAdmVo);
	}
	
	//해당 생산LotNo로 복원TMP 잔여수량 수정
	@Override
	public void updateWorkOrdLotNoUnPack(GoodsProductInfoAdmVo  goodsProductInfoAdmVo)  throws Exception {
		 dao.updateWorkOrdLotNoUnPack(goodsProductInfoAdmVo);
	}
	
	//창고별 제품위치 전체조회
	@Override
	public List<GoodsProductInfoAdmVo> locationList(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.locationList(goodsProductInfoAdmVo);
	}	
	
	//창고별 제품위치 박스번호가 존재하는 행 갯수 조회
	@Override
	public int readlocationRowCount(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		return dao.readlocationRowCount(goodsProductInfoAdmVo);
	}
	
	//트레이 번호로 작업지시 조회
	@Override
	public GoodsProductInfoAdmVo readTrayBoxByWorkOrdNo3(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		return dao.readTrayBoxByWorkOrdNo3(goodsProductInfoAdmVo);
	}
	
	//박스 폐기 지정
	@Override
	public void updateDisAppoint(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception{
		dao.updateDisAppoint(goodsProductInfoAdmVo);
	}
}