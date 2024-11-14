package mes.persistence.dc;

import java.util.List;

import mes.domain.dc.DocumentMngtVo;

public interface DocumentMngtDAO {
	
	//문서관리 조회
	public List<DocumentMngtVo> documentMngtList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
	
	//문서관리 날짜 조회
	public List<DocumentMngtVo> documentMngtDateList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
	
	//문서관리 상세 조회
	public DocumentMngtVo documentMngtRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
			
	//문서관리 등록
	public void documentMngtCreate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
	
	//문서관리 수정
	public void documentMngtUpdate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;

	//문서관리 삭제
	public void documentMngtDelete_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
	
	//문서관리 상세 조회
	public int documentMngtOnlyMaxCodeRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception;
		
}
