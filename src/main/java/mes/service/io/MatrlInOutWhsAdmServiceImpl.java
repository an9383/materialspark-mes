package mes.service.io;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.persistence.io.MatrlInOutWhsAdmDAO;


@Service
public class MatrlInOutWhsAdmServiceImpl implements MatrlInOutWhsAdmService {
	@Inject
	private MatrlInOutWhsAdmDAO dao;

	//입출고관리 자재가입고 목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listPreInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listPreInWhsAll(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listInWhsAll(matrlInOutWhsAdmVo);
	}
	
	//자재입고 자재명 List 조회
	@Override
	public List<MatrlInOutWhsAdmVo> matrlCdInOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.matrlCdInOutList(matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사 자재명 List 조회
	public List<MatrlInOutWhsAdmVo> inspectMatrlCodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.inspectMatrlCodeList(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 바코드 List 조회
	public List<MatrlInOutWhsAdmVo> barcodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.barcodeList(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 바코드 Read 조회
	@Override
	public MatrlInOutWhsAdmVo barcodeRead(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.barcodeRead(matrlInOutWhsAdmVo);
	}

	//입출고관리 자재입고 상세조회
	@Override
	public MatrlInOutWhsAdmVo read(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.read(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 수정
	@Override
	public void update(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.update(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 Location 수정
	@Override
	public void updateLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateLocation(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 FIFO 수정
	@Override
	public void updateFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateFifoCheck(matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사그룹목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listInWhsInspectAll(matrlInOutWhsAdmVo);
	}	
	
	//품질관리 수입검사그룹목록조회 3공장
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAllFac3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return dao.listInWhsInspectAllFac3(matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사그룹상세목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listInWhsInspectDtl(matrlInOutWhsAdmVo);
	}	
	
	//품질관리 수입검사관리 입고량 수정
	@Override
	public void updateinspectQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateinspectQty(matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사(승인/승인취소/불량)
	@Override
	public void updateApprovalStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateApprovalStatus(matrlInOutWhsAdmVo);
	}
	
	//품질관리 출하등록 poGroup 변경
	@Override
	public void updateDtlPoGroup(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateDtlPoGroup(matrlInOutWhsAdmVo);
	}
	
	//제품출하등록 동일 파레트 번호 확인
	@Override
	public Integer checkPalletNo(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return dao.checkPalletNo(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 가출고목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listPreOutWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listPreOutWhsAll(matrlInOutWhsAdmVo);
	}	
	
	//입출고관리 자재가출고수정처리
	@Override
	public void updatePreOutWhsStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updatePreOutWhsStatus(matrlInOutWhsAdmVo);
	}	
	
	//입출고관리 자재 출고 승인으로 변경
	@Override
	public void matrlPreOutWhsDataDeleteChange(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.matrlPreOutWhsDataDeleteChange(matrlInOutWhsAdmVo);
	}	
	
	//입출고관리 자재출고 선입선출체크	
	@Override
	public List<MatrlInOutWhsAdmVo> preOutWhsFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return dao.preOutWhsFifoCheck(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재출고 선입선출체
	@Override
	public List<MatrlInOutWhsAdmVo> inputFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return dao.inputFifoCheck(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 제품출하 리스트뷰
	@Override
	public List<MatrlInOutWhsAdmVo> listAllProductShipment(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listAllProductShipment(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 제품출하 상세뷰
	@Override
	public List<MatrlInOutWhsAdmVo> listAllProductShipmentDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.listAllProductShipmentDtl(matrlInOutWhsAdmVo);
	}
	
 	//입출고관리 승인구분 업데이트
	@Override
 	public void updateApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateApproval(matrlInOutWhsAdmVo);
	}
	
 	//입출고관리 반품 목록조회
	@Override
 	public List<MatrlInOutWhsAdmVo> matrlFaultyTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
 		return dao.matrlFaultyTypeList(matrlInOutWhsAdmVo);
 	}
	
 	//입출고관리 선입선출관리 목록조회
	@Override
    public List<MatrlInOutWhsAdmVo> firstInFirstOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
    	return dao.firstInFirstOutList(matrlInOutWhsAdmVo);
    }
	
 	//입출고관리 선입선출관리 상세 목록조회
 	public List<MatrlInOutWhsAdmVo> firstInFirstOutDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
 		return dao.firstInFirstOutDtlList(matrlInOutWhsAdmVo);
 	}
 	
 	//삭제 전 삭제데이터 TB_IN_OUT_WHS_ADM_TEMP로 이동
	@Override
 	public void insertMatrlInOutTemp(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.insertMatrlInOutTemp(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 제품출하 중복체크
	@Override
	public int purchaseOrderDtlRead(String boxNo) throws Exception{
		return dao.purchaseOrderDtlRead(boxNo);
	}
	
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	@Override
	public void insertMatrlHist(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.insertMatrlHist(matrlInOutWhsAdmVo);
	}
	
	//자재 입출고관리 이력 inWhsGroupSeq 기준으로삭제
	@Override
	public void deleteMatrlHistInWhsGroupSeq(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.deleteMatrlHistInWhsGroupSeq(matrlInOutWhsAdmVo);
	}
	
	//자재 입출고관리 이력 barcodeNo 기준으로삭제
	@Override
	public void deleteMatrlHistBarcode(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.deleteMatrlHistBarcode(matrlInOutWhsAdmVo);
	}
	
 	//입출고관리-자재입출고 내역 조회
 	public List<MatrlInOutWhsAdmVo> matrlInOutHistList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
 		return dao.matrlInOutHistList(matrlInOutWhsAdmVo);
 	}
	
 	//입출고관리 입고현황관리 잔량 수정
	@Override
	public void updateRemainQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.updateRemainQty(matrlInOutWhsAdmVo);
	}
	
	//승인 여부 UPDATE
	@Override
 	public void matrlInOutApprovalUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.matrlInOutApprovalUpdate(matrlInOutWhsAdmVo);
	}
	
	//파레트입출고
	@Override
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.productShipmentPalateDataList(matrlInOutWhsAdmVo);
	}
	
	//파레트입출고 상세테이블 	
	@Override
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDtlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.productShipmentPalateDtlDataList(matrlInOutWhsAdmVo);
	}
	
	//제품입출고관리 / 파레트라벨 프린트 출력 여부
	@Override
	public void productShipmentPrintUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.productShipmentPrintUpdate(matrlInOutWhsAdmVo);
	}
	
	//제품 테이블 비고란 업데이트
	@Override
	public void goodsProductDescUpdate_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.goodsProductDescUpdate_F3(matrlInOutWhsAdmVo);
	}
	
	//잔량이력관리 조회
	@Override
	public List<MatrlInOutWhsAdmVo> remainQtyHistory(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.remainQtyHistory(matrlInOutWhsAdmVo);
	}
	
	//출하검사성적서 조회
	@Override
	public List<MatrlInOutWhsAdmVo> shipReportsList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.shipReportsList(matrlInOutWhsAdmVo);
	}
	
	//출하검사성적서 조회
	@Override
	public List<MatrlInOutWhsAdmVo> shipReportsDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.shipReportsDtlList(matrlInOutWhsAdmVo);
	}
	
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	@Override
	public void shipReportsPlatedCreate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.shipReportsPlatedCreate(matrlInOutWhsAdmVo);
	}
 		
	
	//제품 테이블 비고란 업데이트
	@Override
	public void matrlInOutReportUpload(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.matrlInOutReportUpload(matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 상세조회
	@Override
	public MatrlInOutWhsAdmVo matrlInOutReporFileGroupMaxNum(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return dao.matrlInOutReporFileGroupMaxNum(matrlInOutWhsAdmVo);
	}
	
	//자재 층 구분자 업데이트
	@Override
	public void matrlInOutFloorGubunUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		dao.matrlInOutFloorGubunUpdate(matrlInOutWhsAdmVo);
	}
}