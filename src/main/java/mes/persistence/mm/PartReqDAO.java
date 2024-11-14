package mes.persistence.mm;

import java.util.List;

import mes.domain.mm.PartReqAdmVo;
import mes.domain.mm.PartReqVo;

public interface PartReqDAO {
	
	//ADM
	//부품요청 조회
	public List<PartReqVo> partReqAdmList(PartReqVo partReqVo) throws Exception;
	
	//부품요청ADM 등록
	public void partReqAdmCreate(PartReqAdmVo partReqAdmVo) throws Exception;
	
	//부품요청ADM 수정
	public void partReqAdmUpdate(PartReqAdmVo partReqAdmVo) throws Exception;

	//부품요청ADM 삭제
	public void partReqAdmDelete(PartReqAdmVo partReqAdmVo) throws Exception;
	
	
	//DTL
	//부품요청 조회
	public List<PartReqVo> partReqList(PartReqVo partReqVo) throws Exception;
	
	//요청출고 DTL 목록조회
	public List<PartReqVo> partReqDtlOutList(PartReqVo partReqVo) throws Exception;
	
	//부품요청 상세 조회
	public PartReqVo partReqRead(PartReqVo partReqVo) throws Exception;
			
	//부품요청 등록
	public void partReqCreate(PartReqVo partReqVo) throws Exception;
	
	//부품요청 수정
	public void partReqUpdate(PartReqVo partReqVo) throws Exception;

	//부품요청 삭제
	public void partReqDelete(PartReqVo partReqVo) throws Exception;
	
	//부품요청번호 생성
	public int partReqNo(String date) throws Exception;
	
	//시퀀스 생성
	public int partReqSeq(String date) throws Exception;
	
	//출고요청
	//바코드 목록 조회
	public List<PartReqVo> partReqBarcodeList(PartReqVo partReqVo) throws Exception;
	
	//바코드 상세조회
	public PartReqVo partReqBarcodeRead(PartReqVo partReqVo) throws Exception;
	
	
	
	
	//재작업관리
	//재작업공정별 요청내역 조회
	public List<PartReqVo> reworkPrcssPartReqLIst(PartReqVo partReqVo) throws Exception;
	
	

}
