package mes.service.mm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.mm.OutWhsAdmVo;
import mes.persistence.mm.OutWhsAdmDAO;

@Service
public class OutWhsAdmServiceImpl implements OutWhsAdmService {
	
	@Inject
	private OutWhsAdmDAO dao;

	//자재출고 목록조회
	public List<OutWhsAdmVo> preOutWhsAdmList(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.preOutWhsAdmList(outWhsAdmVo);
	}
	
	//자재출고 상세조회
	public List<OutWhsAdmVo> preOutWhsAdmRead(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.preOutWhsAdmRead(outWhsAdmVo);
	}
	
	//출고량과 총소요량 비교조회
	public List<OutWhsAdmVo> compareConsumptPreOutQty(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.compareConsumptPreOutQty(outWhsAdmVo);
	}
	
	//자재출고 등록
	public void preOutWhsAdmCreate(OutWhsAdmVo outWhsAdmVo) throws Exception{
		dao.preOutWhsAdmCreate(outWhsAdmVo);
	}
	
	//자재출고 출고량 수정
	public void updatePreOutQty(OutWhsAdmVo outWhsAdmVo) throws Exception{
		dao.updatePreOutQty(outWhsAdmVo);
	}
	
	//자재출고 확정여부 수정
	public void updateConfirmYn(OutWhsAdmVo outWhsAdmVo) throws Exception{
		dao.updateConfirmYn(outWhsAdmVo);
	}
	
	//자재출고 출고시퀀스 생성
	public Integer getOutSeq(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.getOutSeq(outWhsAdmVo);
	}
	
	//입출고관리 남은수량 값 수정
	public void updateRemainQty(OutWhsAdmVo outWhsAdmVo) throws Exception{
		dao.updateRemainQty(outWhsAdmVo);
	}
	
	//작지번호에 해당하는 바코드인지 여부확인
	public Integer checkBarcodeNo(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.checkBarcodeNo(outWhsAdmVo);
	}
	
	//자재출고현황 목록조회
	public List<OutWhsAdmVo> workOrdNoList(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.workOrdNoList(outWhsAdmVo);
	}
	
	//작지에 해당하는 품번 소모량 값 가져오기
	public Integer getConsumpt(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.getConsumpt(outWhsAdmVo);
	}
	
	
	
	//작업지시 자재투입 ---------------------------------------------------------------
	
	//barcode No 존재 확인
	@Override
	public int barcodeExsitCheck(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodeExsitCheck(outWhsAdmVo);
	}
	
	//barcode No 출고경로 상태 확인
	public String barcodeStatusCheck(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodeStatusCheck(outWhsAdmVo);
	}
	
	//작지번호에 투입되는 자재가 맞는지 확인
	@Override
	public int barcodeWorkordNoCheck(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodeWorkordNoCheck(outWhsAdmVo);
	}
	
	//barcode No 투입유무 확인
	@Override
	public String barcodeOutStatusCheck(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodeOutStatusCheck(outWhsAdmVo);
	}
	
	
	//해당 공정에 투입되는 자재가 맞는지 확인
	@Override
	public int barcodePrcssCdCheck(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodePrcssCdCheck(outWhsAdmVo);
	}
	
	//자재투입 barcode Scan
	@Override
	public List<OutWhsAdmVo> barcodeNoScan(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.barcodeNoScan(outWhsAdmVo);
	}
	
	//자재투입 자재 출고처리
	@Override
	public void outWhsOutQtyEdit(OutWhsAdmVo outWhsAdmVo) throws Exception{
		dao.outWhsOutQtyEdit(outWhsAdmVo);
	}
	
	//수주상세별 출고 모니터링 조회
	public List<OutWhsAdmVo> outMonitoringList(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.outMonitoringList(outWhsAdmVo);
	}
	
	//수불 부품 바코드 상세조회
	public OutWhsAdmVo itemPartRead(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.itemPartRead(outWhsAdmVo);
	}
	
	//재공창고현항
	//재공창고 기본조회
	public List<OutWhsAdmVo> wareHouseList(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.wareHouseList(outWhsAdmVo);
	}
	
	//재공창고 상세조회
	public List<OutWhsAdmVo> wareHouseRead(OutWhsAdmVo outWhsAdmVo) throws Exception{
		return dao.wareHouseRead(outWhsAdmVo);
	}
}
