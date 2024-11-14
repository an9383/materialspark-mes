package mes.service.dc;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.dc.DocPrnAdmVo;
import mes.persistence.dc.DocPrnAdmDAO;

@Service
public class DocPrnAdmServiceImpl implements DocPrnAdmService {

	@Inject
	private DocPrnAdmDAO dao;
	
	//문서관리 조회
	@Override
	public List<DocPrnAdmVo> docPrnAdmList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return dao.docPrnAdmList_F1F2F3(docPrnAdmVo);
	}
	
	//문서관리 날짜  조회
	@Override
	public List<DocPrnAdmVo> docPrnAdmDateList_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return dao.docPrnAdmDateList_F1F2F3(docPrnAdmVo);
	}
	
	//문서관리 상세 조회
	@Override
	public DocPrnAdmVo docPrnAdmRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return dao.docPrnAdmRead_F1F2F3(docPrnAdmVo);
	}
			
	//문서관리 등록
	@Override
	public void docPrnAdmCreate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		dao.docPrnAdmCreate_F1F2F3(docPrnAdmVo);
	}
	
	//문서관리 수정
	@Override
	public void docPrnAdmUpdate_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		dao.docPrnAdmUpdate_F1F2F3(docPrnAdmVo);
	}
	
	//문서관리 삭제
	public void docPrnAdmDelete_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		dao.docPrnAdmDelete_F1F2F3(docPrnAdmVo);
	}
	
	//문서관리 상세 조회
	@Override
	public int docPrnAdmOnlyMaxCodeRead_F1F2F3(DocPrnAdmVo docPrnAdmVo) throws Exception{
		return dao.docPrnAdmOnlyMaxCodeRead_F1F2F3(docPrnAdmVo);
	}
	
}
