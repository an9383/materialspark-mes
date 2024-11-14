package mes.service.dc;

import java.util.List;

import mes.domain.dc.DocPrnAdmVo;

public interface DocPrnAdmService {

	//문서관리 조회
	public List<DocPrnAdmVo> docPrnAdmList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;
	
	//문서관리 날짜  조회
	public List<DocPrnAdmVo> docPrnAdmDateList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;	
	
	//문서관리 상세 조회
	public DocPrnAdmVo docPrnAdmRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;
			
	//문서관리 등록
	public void docPrnAdmCreate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;
	
	//문서관리 수정
	public void docPrnAdmUpdate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;

	//문서관리 삭제
	public void docPrnAdmDelete_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;
	
	//문서관리 상세 조회
	public int docPrnAdmOnlyMaxCodeRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception;
	
}
