package mes.service.dc;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.dc.DocumentMngtVo;
import mes.persistence.dc.DocumentMngtDAO;

@Service
public class DocumentMngtServiceImple implements DocumentMngtService {

	@Inject
	private DocumentMngtDAO dao;
	
	//문서관리 조회
	@Override
	public List<DocumentMngtVo> documentMngtList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return dao.documentMngtList_F1F2F3(documentMngtVo);
	}
	
	//문서관리 날짜  조회
	@Override
	public List<DocumentMngtVo> documentMngtDateList_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return dao.documentMngtDateList_F1F2F3(documentMngtVo);
	}
	
	//문서관리 상세 조회
	@Override
	public DocumentMngtVo documentMngtRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return dao.documentMngtRead_F1F2F3(documentMngtVo);
	}
			
	//문서관리 등록
	@Override
	public void documentMngtCreate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		dao.documentMngtCreate_F1F2F3(documentMngtVo);
	}
	
	//문서관리 수정
	@Override
	public void documentMngtUpdate_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		dao.documentMngtUpdate_F1F2F3(documentMngtVo);
	}
	
	//문서관리 삭제
	public void documentMngtDelete_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		dao.documentMngtDelete_F1F2F3(documentMngtVo);
	}
	
	//문서관리 상세 조회
	@Override
	public int documentMngtOnlyMaxCodeRead_F1F2F3(DocumentMngtVo documentMngtVo) throws Exception{
		return dao.documentMngtOnlyMaxCodeRead_F1F2F3(documentMngtVo);
	}
	
}
