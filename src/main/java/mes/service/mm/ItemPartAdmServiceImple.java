package mes.service.mm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.mm.ItemPartAdmVo;
import mes.persistence.mm.ItemPartAdmDAO;

@Service
public class ItemPartAdmServiceImple implements ItemPartAdmService {

	@Inject
	private ItemPartAdmDAO dao;
	
	//품목정보관리(부품) 목록조회
	@Override
	public List<ItemPartAdmVo> itemPartAdmList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAdmList(itemPartAdmVo);
	}
	
	//품목정보관리(부품) 상세조회
	@Override
	public ItemPartAdmVo itemPartDtlList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartDtlList(itemPartAdmVo);
	}

	//품목정보관리(부품)	등록
	@Override
	public int itemPartAdmCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAdmCreate(itemPartAdmVo);
	}
	
	//품목정보관리(부품)	수정
	@Override
	public int itemPartAdmUpdate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAdmUpdate(itemPartAdmVo);
	}

	//partCd값 가져오기
	/*
	 * @Override public String getPartCd() throws Exception { return
	 * dao.getPartCd(); }
	 */
	
	//partCd값 중복확인
	public Integer overlapPartCd(ItemPartAdmVo itemPartAdmVo) throws Exception{
		return dao.overlapPartCd(itemPartAdmVo);
	}
	
	//partRev값 가져오기
	@Override
	public ItemPartAdmVo getPartRev(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.getPartRev(itemPartAdmVo);
	}

	//자재단가 수정
	public void updateUnitCost(ItemPartAdmVo itemPartAdmVo) throws Exception{
		dao.updateUnitCost(itemPartAdmVo);
	}
	
	
	
	
	//수입검사기준서
	
	//부품수입검사기준서 조회
	@Override
	public List<ItemPartAdmVo> itemPartInspectList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartInspectList(itemPartAdmVo);
	}
	
	//부품수입검사기준서 상세조회
	@Override
	public ItemPartAdmVo itemPartInspectRead(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartInspectRead(itemPartAdmVo);
	}
	
	//부품수입검사기준서	등록
	@Override
	public int itemPartInspectCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartInspectCreate(itemPartAdmVo);
	}
	
	//부품수입검사기준서 삭제
	@Override
	public int itemPartInspectDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartInspectDelete(itemPartAdmVo);
	}
	
		
	//partSeq값 가져오기
	@Override
	public int getInspectPartSeq(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.getInspectPartSeq(itemPartAdmVo);
	}
	
	//파일명 가져오기
	@Override
	public String getFileNm(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.getFileNm(itemPartAdmVo);
	}
	
	//등록자 가져오기
	@Override
	public String getUserNm(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.getUserNm(itemPartAdmVo);
	}
	
	
	//관련자료
	
	//부품수입검사기준서 조회
	@Override
	public List<ItemPartAdmVo> itemPartAttachDataList(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAttachDataList(itemPartAdmVo);
	}
	
	//부품수입검사기준서	등록
	@Override
	public int itemPartAttachDataCreate(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAttachDataCreate(itemPartAdmVo);
	}
	
	//부품수입검사기준서 삭제
	@Override
	public int itemPartAttachDataDelete(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.itemPartAttachDataDelete(itemPartAdmVo);
	}
	
	//partSeq값 가져오기
	@Override
	public int getAttachPartSeq(ItemPartAdmVo itemPartAdmVo) throws Exception {
		return dao.getAttachPartSeq(itemPartAdmVo);
	}
	
	//파일명 가져오기
	public String getAttachFileNm(ItemPartAdmVo itemPartAdmVo)throws Exception{
		return dao.getAttachFileNm(itemPartAdmVo);
	}
	
}
