package mes.persistence.mm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.mm.ItemPartAdmVo;

@Repository
public class ItemPartAdmDAOImple implements ItemPartAdmDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.mm.itemPartAdmMapper";
	
	//품목정보관리(부품) 목록조회
	@Override
	public List<ItemPartAdmVo> itemPartAdmList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectList(namespace +".itemPartAdmList", itemPartAdmVo);
	}
	
	//품목정보관리(부품) 상세조회
	@Override
	public ItemPartAdmVo itemPartDtlList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".itemPartDtlList" , itemPartAdmVo);
	}
	
	//품목정보관리(부품)	등록
	@Override
	public int itemPartAdmCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.insert(namespace + ".itemPartAdmCreate", itemPartAdmVo);
	}

	//품목정보관리(부품)	수정
	@Override
	public int itemPartAdmUpdate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.update(namespace +".itemPartAdmUpdate", itemPartAdmVo);
	}

	//partCd값 가져오기
	/*
	 * @Override public String getPartCd() throws Exception { return
	 * session.selectOne(namespace + ".getPartCd"); }
	 */
	
	//partCd값 중복확인
	public Integer overlapPartCd(ItemPartAdmVo itemPartAdmVo) throws Exception{
		return session.selectOne(namespace +".overlapPartCd", itemPartAdmVo);
	}
	
	//partRev값 가져오기
	@Override
	public ItemPartAdmVo getPartRev(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".getPartRev" , itemPartAdmVo);
	}
	
	//자재단가 수정
	public void updateUnitCost(ItemPartAdmVo itemPartAdmVo) throws Exception{
		session.update(namespace+".updateUnitCost" ,itemPartAdmVo );
	}
	
	
	//수입검사기준서
	
	//부품수입검사기준서 조회
	@Override
	public List<ItemPartAdmVo> itemPartInspectList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectList(namespace + ".itemPartInspectList" ,itemPartAdmVo);
	}
	
	//부품수입검사기준서 상세조회
	@Override
	public ItemPartAdmVo itemPartInspectRead(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".itemPartInspectRead" , itemPartAdmVo);
	}
	
	//부품수입검사기준서	등록
	@Override
	public int itemPartInspectCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.insert(namespace + ".itemPartInspectCreate", itemPartAdmVo);
	}
	
	//부품수입검사기준서 삭제
	@Override
	public int itemPartInspectDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.delete(namespace + ".itemPartInspectDelete" , itemPartAdmVo);
	}
	
	//partSeq값 가져오기
	@Override
	public int getInspectPartSeq(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".getInspectPartSeq" ,itemPartAdmVo);
	}
	
	//파일명 가져오기
	@Override
	public String getFileNm(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".getFileNm", itemPartAdmVo);
	}
	
	//등록자 가져오기
	@Override
	public String getUserNm(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectOne(namespace + ".getUserNm", itemPartAdmVo);
	}
		
	
	
	//관련자료
	
	//관련자료	조회
	@Override
	public List<ItemPartAdmVo> itemPartAttachDataList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return session.selectList(namespace +".itemPartAttachDataList",itemPartAdmVo);
	}
	
	//관련자료	등록
    @Override
    public int itemPartAttachDataCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
    	return session.insert(namespace + ".itemPartAttachDataCreate", itemPartAdmVo);
    }
    
    //관련자료	삭제
    @Override
    public int itemPartAttachDataDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
    	return session.delete(namespace + ".itemPartAttachDataDelete" , itemPartAdmVo);
    }
    
    @Override
    public int getAttachPartSeq(ItemPartAdmVo itemPartAdmVo) throws Exception {
    	return session.selectOne(namespace + ".getAttachPartSeq" ,itemPartAdmVo);
    }
    
	//파일명 가져오기
	public String getAttachFileNm(ItemPartAdmVo itemPartAdmVo)throws Exception{
		return session.selectOne(namespace+".getAttachFileNm" ,itemPartAdmVo );
	}
	
}
