package mes.persistence.io;

import java.util.List;

import mes.domain.io.MatrlInOutWhsAdmVo;

public interface MatrlInOutWhsAdmDAO {

	//입출고관리 자재가입고 목록조회
	public List<MatrlInOutWhsAdmVo> listPreInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;

	//입출고관리 자재입고 목록조회
	public List<MatrlInOutWhsAdmVo> listInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//자재입고 자재명 List 조회
	public List<MatrlInOutWhsAdmVo> matrlCdInOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사 자재명 List 조회
	public List<MatrlInOutWhsAdmVo> inspectMatrlCodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 바코드 List 조회
	public List<MatrlInOutWhsAdmVo> barcodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 바코드 Read 조회
	public MatrlInOutWhsAdmVo barcodeRead(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 상세조회
	public MatrlInOutWhsAdmVo read(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 수정
	public void update(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 Location 수정
	public void updateLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 FIFO 수정
	public void updateFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사그룹목록조회
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사그룹목록조회 3공장
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAllFac3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사그룹상세목록조회
	public List<MatrlInOutWhsAdmVo> listInWhsInspectDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사관리 입고량 수정
	public void updateinspectQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사(승인/승인취소/불량) 및 입고량 상세수정
	public void updateApprovalStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 출하등록 poGroup 변경
	public void updateDtlPoGroup(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품출하등록 동일 파레트 번호 확인
	public Integer checkPalletNo(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재가출고정보조회
	public List<MatrlInOutWhsAdmVo> listPreOutWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//품질관리 수입검사(승인/승인취소/불량) 및 입고량 상세수정
	public void updatePreOutWhsStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;	
	
	//입출고관리 자재 출고 승인으로 변경
	public void matrlPreOutWhsDataDeleteChange(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;	
	
	//입출고관리 자재출고 선입선출체크
	public List<MatrlInOutWhsAdmVo> preOutWhsFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;	
	
	//입출고관리 자재출고 선입선출체
	public List<MatrlInOutWhsAdmVo> inputFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 제품출하 리스트뷰
 	public List<MatrlInOutWhsAdmVo> listAllProductShipment(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
	//입출고관리 제품출하 상세뷰
 	public List<MatrlInOutWhsAdmVo> listAllProductShipmentDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
 	//입출고관리 승인구분 업데이트
 	public void updateApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
 	//입출고관리 반품 목록조회
 	public List<MatrlInOutWhsAdmVo> matrlFaultyTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
 	//입출고관리 선입선출관리 목록조회
 	public List<MatrlInOutWhsAdmVo> firstInFirstOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	 
 	//입출고관리 선입선출관리 상세 목록조회
 	public List<MatrlInOutWhsAdmVo> firstInFirstOutDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
 	//수입검사관리(qmsc0020) 삭제 시 사용 총3개쿼리문 사용
	public void insertMatrlInOutTemp(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 제품출하 중복체크
	public int purchaseOrderDtlRead(String boxNo) throws Exception;
	
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	public void insertMatrlHist(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//자재 입출고관리 이력 inWhsGroupSeq 기준으로삭제
	public void deleteMatrlHistInWhsGroupSeq(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//자재 입출고관리 이력 barcodeNo 기준으로삭제
	public void deleteMatrlHistBarcode(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
 	//입출고관리-자재입출고 내역 조회
 	public List<MatrlInOutWhsAdmVo> matrlInOutHistList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
 	
	//입출고관리 입고현황관리 잔량 수정
	public void updateRemainQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//승인 여부 UPDATE
 	public void matrlInOutApprovalUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//파레트입출고
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;

	//파레트입출고 상세테이블 
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDtlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;

	//제품입출고관리 / 파레트라벨 프린트 출력 여부
	public void productShipmentPrintUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//제품 테이블 비고란 업데이트
	public void goodsProductDescUpdate_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//잔량이력관리 조회
	public List<MatrlInOutWhsAdmVo> remainQtyHistory(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//출하검사성적서 조회
	public List<MatrlInOutWhsAdmVo> shipReportsList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//출하검사성적서 조회
	public List<MatrlInOutWhsAdmVo> shipReportsDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
		
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	public void shipReportsPlatedCreate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 입고현황관리 잔량 수정
	public void matrlInOutReportUpload(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//입출고관리 자재입고 바코드 Read 조회
	public MatrlInOutWhsAdmVo matrlInOutReporFileGroupMaxNum(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
	
	//자재 층 구분자 업데이트
	public void matrlInOutFloorGubunUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception;
}