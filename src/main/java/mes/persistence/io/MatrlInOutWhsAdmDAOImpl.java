package mes.persistence.io;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.web.ut.Utils;

@Repository
public class MatrlInOutWhsAdmDAOImpl implements MatrlInOutWhsAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.io.matrlInOutWhsAdmMapper";

	//입출고관리 자재가입고 목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listPreInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listPreInWhsAll", matrlInOutWhsAdmVo);
	}
	
	//입출고관리  목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listInWhsAll", matrlInOutWhsAdmVo);
	}
	
	//자재입고 자재명 List 조회
	@Override
	public List<MatrlInOutWhsAdmVo> matrlCdInOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".matrlCdInOutList", matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사 자재명 List 조회
	@Override
	public List<MatrlInOutWhsAdmVo> inspectMatrlCodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace + ".inspectMatrlCodeList", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 바코드 List 조회
	@Override
	public List<MatrlInOutWhsAdmVo> barcodeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace + ".barcodeList", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 바코드 Read 조회
	@Override
	public MatrlInOutWhsAdmVo barcodeRead(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectOne(namespace + ".barcodeRead", matrlInOutWhsAdmVo);
	}
	
	//입출고관리  상세조회	
	@Override
	public MatrlInOutWhsAdmVo read(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectOne(namespace + ".read", matrlInOutWhsAdmVo);
	}
	
	//입출고관리  수정	
	@Override
	public void update(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".update", matrlInOutWhsAdmVo);
	}
	
	//입출고관리  Location 수정	
	@Override
	public void updateLocation(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".updateLocation", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 FIFO 수정
	@Override
	public void updateFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".updateFifoCheck", matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사그룹목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listInWhsInspectAll", matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사그룹목록조회 3공장
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectAllFac3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listInWhsInspectAllFac3", matrlInOutWhsAdmVo);
	}
	
	//품질관리 수입검사그룹상세목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listInWhsInspectDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listInWhsInspectDtl", matrlInOutWhsAdmVo);
	}	
	
	//품질관리 수입검사관리 입고량 수정
	@Override
	public void updateinspectQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updateinspectQty", matrlInOutWhsAdmVo);
	}

	//품질관리 수입검사(승인/승인취소/불량) 및 입고량 상세수정
	@Override
	public void updateApprovalStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".updateApprovalStatus", matrlInOutWhsAdmVo);
	}

	//품질관리 출하등록 poGroup 변경
	@Override
	public void updateDtlPoGroup(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updateDtlPoGroup", matrlInOutWhsAdmVo);
	}
	
	//제품출하등록 동일 파레트 번호 확인
	@Override
	public Integer checkPalletNo(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectOne(namespace+".checkPalletNo" , matrlInOutWhsAdmVo);
	}
	//입출고관리 가출고목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> listPreOutWhsAll(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".listPreOutWhsAll", matrlInOutWhsAdmVo);
	}	
	
	//입출고관리 자재가출고수정처리
	@Override
	public void updatePreOutWhsStatus(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".updatePreOutWhsStatus", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재 출고 승인으로 변경
	@Override
	public void matrlPreOutWhsDataDeleteChange(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".matrlPreOutWhsDataDeleteChange", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재출고 선입선출체크	
	@Override
	public List<MatrlInOutWhsAdmVo> preOutWhsFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".preOutWhsFifoCheck", matrlInOutWhsAdmVo);
	}	
	
	//입출고관리 자재출고 선입선출체
	@Override
	public List<MatrlInOutWhsAdmVo> inputFifoCheck(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".inputFifoCheck", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 제품출하 리스트뷰
	@Override
	public List<MatrlInOutWhsAdmVo> listAllProductShipment(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		 return session.selectList(namespace + ".listAllProductShipment",matrlInOutWhsAdmVo);
	 }
	
	//입출고관리 제품출하 상세뷰
	@Override
	public List<MatrlInOutWhsAdmVo> listAllProductShipmentDtl(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		 return session.selectList(namespace + ".listAllProductShipmentDtl",matrlInOutWhsAdmVo);
	 }
	
	//입출고관리 승인구분 업데이트
	@Override
	public void updateApproval(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updateApproval",matrlInOutWhsAdmVo);
	}
	
 	//입출고관리 반품 목록조회
	@Override
 	public List<MatrlInOutWhsAdmVo> matrlFaultyTypeList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
 		return session.selectList(namespace + ".matrlFaultyTypeList", matrlInOutWhsAdmVo);
 	}
	
 	//입출고관리 선입선출관리 목록조회
	@Override
	public List<MatrlInOutWhsAdmVo> firstInFirstOutList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace + ".firstInFirstOutList", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 선입선출관리 상세 목록조회
	public List<MatrlInOutWhsAdmVo> firstInFirstOutDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace + ".firstInFirstOutDtlList", matrlInOutWhsAdmVo);
	}
	
	//수입검사관리(qmsc0020) 삭제 시 사용 총3개쿼리문 사용
	@Override
	public void insertMatrlInOutTemp(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.insert(namespace + ".insertMatrlInOutTemp",matrlInOutWhsAdmVo);			//삭제 전 삭제데이터 TB_IN_OUT_WHS_ADM_TEMP로 이동
		session.update(namespace + ".updateMatrlInOutTempDltId",matrlInOutWhsAdmVo);	//삭제자 IP, ID, 날짜 수정
		session.delete(namespace + ".deleteMatrlInOut",matrlInOutWhsAdmVo);				//입출고관리 원본 삭제
	}
	
	//입출고관리 제품출하 중복체크
	@Override
	public int purchaseOrderDtlRead(String boxNo) throws Exception{
		return  session.selectOne(namespace + ".purchaseOrderDtlRead", boxNo);
	}
	
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	@Override
	public void insertMatrlHist(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		matrlInOutWhsAdmVo = session.selectOne(namespace + ".read", matrlInOutWhsAdmVo);
		matrlInOutWhsAdmVo.setHistId(Utils.getUserId());
		session.insert(namespace + ".insertMatrlHist",matrlInOutWhsAdmVo);
	}

	//자재 입출고관리 이력 inWhsGroupSeq 기준으로삭제
	public void deleteMatrlHistInWhsGroupSeq(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.delete(namespace + ".deleteMatrlHistInWhsGroupSeq", matrlInOutWhsAdmVo);
	}

	//자재 입출고관리 이력 barcodeNo 기준으로삭제
	public void deleteMatrlHistBarcode(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.delete(namespace + ".deleteMatrlHistBarcode", matrlInOutWhsAdmVo);
	}
	
 	//입출고관리-자재입출고 내역 조회
	@Override
	public List<MatrlInOutWhsAdmVo> matrlInOutHistList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		return session.selectList(namespace + ".matrlInOutHistList", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 입고현황관리 잔량 수정
	@Override
	public void updateRemainQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".updateRemainQty", matrlInOutWhsAdmVo);
	}
	
	//승인 여부 UPDATE
	@Override
 	public void matrlInOutApprovalUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.update(namespace + ".matrlInOutApprovalUpdate", matrlInOutWhsAdmVo);
	}
	
	//파레트입출고
	@Override
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".productShipmentPalateDataList", matrlInOutWhsAdmVo);
	}
	
	//파레트입출고 상세테이블 	
	public List<MatrlInOutWhsAdmVo> productShipmentPalateDtlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".productShipmentPalateDtlDataList", matrlInOutWhsAdmVo);
	}
	
	//제품입출고관리 / 파레트라벨 프린트 출력 여부
	@Override
	public void productShipmentPrintUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".productShipmentPrintUpdate", matrlInOutWhsAdmVo);
	}
	
	//제품 테이블 비고란 업데이트
	@Override
	public void goodsProductDescUpdate_F3(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".goodsProductDescUpdate_F3", matrlInOutWhsAdmVo);
	}
	
	//잔량이력관리 조회
	public List<MatrlInOutWhsAdmVo> remainQtyHistory(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".remainQtyHistory", matrlInOutWhsAdmVo);
	}
	
	//출하검사성적서 조회
	public List<MatrlInOutWhsAdmVo> shipReportsList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".shipReportsList", matrlInOutWhsAdmVo);
	}
	
	//출하검사성적서 조회
	public List<MatrlInOutWhsAdmVo> shipReportsDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectList(namespace + ".shipReportsDtlList", matrlInOutWhsAdmVo);
	}
	
	//자재 상태,승인,중량,창고 변경시 자재이력 등록
	@Override
	public void shipReportsPlatedCreate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception{
		session.insert(namespace + ".shipReportsPlatedCreate",matrlInOutWhsAdmVo);
	}
	
	//제품 테이블 비고란 업데이트
	@Override
	public void matrlInOutReportUpload(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".matrlInOutReportUpload", matrlInOutWhsAdmVo);
	}
	
	//입출고관리 자재입고 바코드 Read 조회
	@Override
	public MatrlInOutWhsAdmVo matrlInOutReporFileGroupMaxNum(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		return session.selectOne(namespace + ".matrlInOutReporFileGroupMaxNum", matrlInOutWhsAdmVo);
	}
	
	//자재 층 구분자 업데이트
	@Override
	public void matrlInOutFloorGubunUpdate(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		session.update(namespace + ".matrlInOutFloorGubunUpdate", matrlInOutWhsAdmVo);
	}
}