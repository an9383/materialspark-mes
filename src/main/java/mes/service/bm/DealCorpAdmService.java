package mes.service.bm;

import java.util.List;

import mes.domain.bm.DealCorpAdmVo;

public interface DealCorpAdmService {
	
	//거래처정보관리 목록조회
	public List<DealCorpAdmVo> listAll(DealCorpAdmVo dealCorpAdmVo) throws Exception;

	//거래처정보관리 상세조회
	public DealCorpAdmVo read(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	//거래처정보관리 등록
	public void create(DealCorpAdmVo dealCorpAdmVo) throws Exception;
	
	//거래처정보관리 수정
	public void update(DealCorpAdmVo dealCorpAdmVo) throws Exception;	
	
	//거래처정보관리 거래처시퀀스코드정보
	public String selectDealCorpSeqCd() throws Exception;	
	
}
