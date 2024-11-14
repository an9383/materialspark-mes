package mes.service.bm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import mes.domain.bm.InspectInfoAdmVo;
import mes.persistence.bm.InspectInfoAdmDAO;

@Service
public class InspectInfoAdmServiceImpl implements InspectInfoAdmService {

	@Inject
	private InspectInfoAdmDAO dao;

	//거래처정보관리 상세조회
	@Override
	public InspectInfoAdmVo read(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		return dao.read(inspectInfoAdmVo);	
	}
	
	//거래처정보관리 등록
	@Override
	public void create(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		dao.create(inspectInfoAdmVo);
	}
	
	//거래처정보관리 수정
	@Override
	public void update(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		dao.update(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public InspectInfoAdmVo read2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.read2(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.create2(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.update2(inspectInfoAdmVo);
	}
	
	//품질관리 수입검사현황(qmsc0100)
	@Override
	public List<Map<String,String>> inspectListRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.inspectListRead(inspectInfoAdmVo);
	}
	
	//품질관리 수입검사현황(qmsc0100) 3공장
	@Override
	public List<Map<String,String>> inspectListReadFac3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.inspectListReadFac3(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public List<InspectInfoAdmVo> read3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.read3(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회(SLD)
	@Override
	public List<InspectInfoAdmVo> read3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.read3New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.create3(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 (SLD)
	@Override
	public void create3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.create3New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.update3(inspectInfoAdmVo);
	}
	
	//idx조회
	@Override
	public InspectInfoAdmVo selectIdx(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.selectIdx(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public InspectInfoAdmVo read4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.read4(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회(SLD)
	@Override
	public InspectInfoAdmVo read4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.read4New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.create4(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록(SLD) 
	@Override
	public void create4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.create4New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.update4(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정(SLD)
	@Override
	public void update3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.update3New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.update4New(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 삭제(상단)
	@Override
	public void delete1(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.delete1(inspectInfoAdmVo);
	}
		
	//품질정보관리 수입검사 삭제(하단)
	@Override
	public void delete2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.delete2(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 삭제(합불판정)
	@Override
	public void deletePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.deletePass(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 등록 
	@Override
	public void createPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.createPass(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 수정
	@Override
	public void updatePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.updatePass(inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 조회
	@Override
	public List<InspectInfoAdmVo> listPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.listPass(inspectInfoAdmVo);
	}
	
	//품질관리 수입검사현황 자재명 List 조회
	@Override
	public List<InspectInfoAdmVo> inspectMatrlCodeList(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.inspectMatrlCodeList(inspectInfoAdmVo);
	}	
	
	//품질정보관리 상세조회(자재코드별 조회)
	@Override
	public InspectInfoAdmVo dtlRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.dtlRead(inspectInfoAdmVo);
	}
	
	//품질정보관리 상세조회 - 자재코드에 맞는 데이터 없는 경우에 기존 데이터 조회
	@Override
	public InspectInfoAdmVo dtlReadWithoutMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return dao.dtlReadWithoutMatrlCd(inspectInfoAdmVo);
	}
	
	//품질정보관리 상세(자재코드별) 등록 
	@Override
	public void dtlCreate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.dtlCreate(inspectInfoAdmVo);
	}
	
	//품질정보관리 상세(자재코드별) 수정
	@Override
	public void dtlUpdate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		dao.dtlUpdate(inspectInfoAdmVo);
	}
}	