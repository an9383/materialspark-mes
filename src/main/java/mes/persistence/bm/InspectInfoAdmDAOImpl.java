package mes.persistence.bm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import mes.domain.bm.InspectInfoAdmVo;

@Repository
public class InspectInfoAdmDAOImpl implements InspectInfoAdmDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "mes.mappers.bm.inspectInfoAdmMapper";

	//품질정보관리  상세조회
	@Override
	public InspectInfoAdmVo read(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		return session.selectOne(namespace + ".read", inspectInfoAdmVo);
	}

	//품질정보관리  등록
	@Override
	public void create(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		session.insert(namespace + ".create", inspectInfoAdmVo);
	}

	//품질정보관리  수정
	@Override
	public void update(InspectInfoAdmVo inspectInfoAdmVo) throws Exception {
		session.update(namespace + ".update", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public InspectInfoAdmVo read2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".read2",inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".create2", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace + ".update2", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public List<Map<String,String>> inspectListRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".inspectListRead", inspectInfoAdmVo);
	}
	
	//품질관리 수입검사현황(qmsc0100) 3공장
	@Override
	public List<Map<String,String>> inspectListReadFac3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		List<Map<String, String>> result = null;
		if(inspectInfoAdmVo.getDataType().equals("old")) {
			result =  session.selectList(namespace + ".inspectListReadFac3", inspectInfoAdmVo);
		} else if(inspectInfoAdmVo.getDataType().equals("new")) {
			result =  session.selectList(namespace + ".inspectListReadFac3New", inspectInfoAdmVo);
		}
		return result;
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public List<InspectInfoAdmVo> read3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".read3", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public List<InspectInfoAdmVo> read3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".read3New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".create3", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".create3New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update3(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace + ".update3", inspectInfoAdmVo);
	}
	
	//idx조회
	@Override
	public InspectInfoAdmVo selectIdx(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".selectIdx",inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회
	@Override
	public InspectInfoAdmVo read4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".read4", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 상세조회(SLD)
	@Override
	public InspectInfoAdmVo read4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".read4New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 
	@Override
	public void create4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".create4", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 등록 (SLD)
	@Override
	public void create4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".create4New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update4(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace + ".update4", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	@Override
	public void update3New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace+".update3New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 수정
	public void update4New(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace+".update4New", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 삭제(상단)
	@Override
	public void delete1(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.delete(namespace + ".delete1", inspectInfoAdmVo);
	}
		
	//품질정보관리 수입검사 삭제(하단)
	@Override
	public void delete2(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.delete(namespace + ".delete2", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 삭제(합불판정)
	@Override
	public void deletePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.delete(namespace + ".deletePass", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 등록 
	@Override
	public void createPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace + ".createPass", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 수정
	@Override
	public void updatePass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace + ".updatePass", inspectInfoAdmVo);
	}
	
	//품질정보관리 수입검사 합격여부 조회
	@Override
	public List<InspectInfoAdmVo> listPass(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".listPass",inspectInfoAdmVo);
	}
	
	//품질관리 수입검사현황 자재명 List 조회
	@Override
	public List<InspectInfoAdmVo> inspectMatrlCodeList(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".inspectMatrlCodeList",inspectInfoAdmVo);
	}
	
	//품질정보관리 상세조회(자재코드별 조회)
	@Override
	public InspectInfoAdmVo dtlRead(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace+".dtlRead", inspectInfoAdmVo);
	}
	
	//품질정보관리 상세조회 - 자재코드에 맞는 데이터 없는 경우에 기존 데이터 조회
	@Override
	public InspectInfoAdmVo dtlReadWithoutMatrlCd(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		return session.selectOne(namespace+".dtlReadWithoutMatrlCd", inspectInfoAdmVo);
	}
	
	//품질정보관리 상세(자재코드별) 등록 
	@Override
	public void dtlCreate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.insert(namespace+".dtlCreate", inspectInfoAdmVo);
	}
	
	//품질정보관리 상세(자재코드별) 수정
	@Override
	public void dtlUpdate(InspectInfoAdmVo inspectInfoAdmVo) throws Exception{
		session.update(namespace+".dtlUpdate", inspectInfoAdmVo);
	}

}