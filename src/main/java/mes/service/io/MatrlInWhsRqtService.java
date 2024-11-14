package mes.service.io;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import mes.domain.io.MatrlInWhsRqtVo;

public interface MatrlInWhsRqtService {
	
	//자재입고관리 목록조회
	public List<MatrlInWhsRqtVo> listAll(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception;

	//자재입고관리 상세조회
	public MatrlInWhsRqtVo read(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception;
	
	//자재입고관리 등록
	public void create(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception;
	
	//자재입고관리 수정
	public void update(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception;
	
	//시퀀스 생성
	public String selectInWhsGroupSeq() throws Exception;
	
	//바코드 생성
	public String barcodeCreate(String time) throws Exception;

	//유효성 검사
	public String checkCode(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception;
	
	//seq 갯수 검사
	public int groupSeqCount(String seq) throws Exception;
	
	//seq별 삭제
	public void groupSeqDelete(String seq) throws Exception;
}
