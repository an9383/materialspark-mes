package mes.service.mm;

import java.util.List;

import mes.domain.mm.ItemPartAdmVo;

public interface ItemPartAdmService {

	//품목정보관리(부품) 목록조회
	public List<ItemPartAdmVo> itemPartAdmList(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//품목정보관리(부품) 상세조회
	public ItemPartAdmVo itemPartDtlList(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//품목정보관리(부품)	등록
	public int itemPartAdmCreate(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//품목정보관리(부품)	수정
	public int itemPartAdmUpdate(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//partCd값 가져오기
	//public String getPartCd() throws Exception;
	
	//partCd값 중복확인
	public Integer overlapPartCd(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//partRev값 가져오기
	public ItemPartAdmVo getPartRev(ItemPartAdmVo itemPartAdmVo) throws Exception;

	//자재단가 수정
	public void updateUnitCost(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	
	//수입검사기준서
	
	//부품수입검사기준서 조회
	public List<ItemPartAdmVo> itemPartInspectList(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//부품수입검사기준서 상세조회
	public ItemPartAdmVo itemPartInspectRead(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//부품수입검사기준서	등록
	public int itemPartInspectCreate(ItemPartAdmVo itemPartAdmVo) throws Exception;
		
	//부품수입검사기준서 삭제
	public int itemPartInspectDelete(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//partSeq값 가져오기
	public int getInspectPartSeq(ItemPartAdmVo itemPartAdmVo)throws Exception;
	
	//파일명 가져오기
	public String getFileNm(ItemPartAdmVo itemPartAdmVo)throws Exception;
	
	//등록자 가져오기
	public String getUserNm(ItemPartAdmVo itemPartAdmVo)throws Exception;
	
	
	
	//관련자료
	
	//부품수입검사기준서 조회
	public List<ItemPartAdmVo> itemPartAttachDataList(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//부품수입검사기준서	등록
	public int itemPartAttachDataCreate(ItemPartAdmVo itemPartAdmVo) throws Exception;
		
	//부품수입검사기준서 삭제
	public int itemPartAttachDataDelete(ItemPartAdmVo itemPartAdmVo) throws Exception;
	
	//partSeq값 가져오기
	public int getAttachPartSeq(ItemPartAdmVo itemPartAdmVo)throws Exception;
	
	//파일명 가져오기
	public String getAttachFileNm(ItemPartAdmVo itemPartAdmVo)throws Exception;
	
}
