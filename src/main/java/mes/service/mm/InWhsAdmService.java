package mes.service.mm;

import java.util.List;

import mes.domain.mm.InWhsAdmVo;

public interface InWhsAdmService {
	
	//가입고등록
	
	//가입고등록,개별입고등록 상세조회
	public List<InWhsAdmVo> preInWhsAdmList(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//가입고등록 등록
	public void preInWhsAdmCreate(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//가입고등록 수정
	public void preInWhsAdmUpdate(InWhsAdmVo inWhsAdmVo) throws Exception;

	//가입고등록 삭제
	public void preInWhsAdmDelete(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//가입고 시퀀스 생성
	public String getInSeq(String dateTo) throws Exception;
	
	//바코드 시퀀스 가져오기
	public String getBarcodeSeq(String date) throws Exception;
	
	//자재상태 확인
	public String statusCdCheck(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	
	//입고등록
	
	//입고등록 상세조회
	public InWhsAdmVo inWhsAdmRead(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//입고등록 바코드 상세조회
	public InWhsAdmVo inWhsAdmBarcodeRead(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//입고등록 등록(가입고테이블 수정)
	public void inWhsAdmCreate(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	
	//개별입고
	
	//개별입고 목록조회
	public List<InWhsAdmVo> individualAdmList(InWhsAdmVo inWhsAdmVo) throws Exception;
	
	//개별입고 가상발주번호 생성
	public String getPoNo(String today) throws Exception;
}
