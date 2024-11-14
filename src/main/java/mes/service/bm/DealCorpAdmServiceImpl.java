package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.DealCorpAdmVo;
import mes.persistence.bm.DealCorpAdmDAO;

@Service
public class DealCorpAdmServiceImpl implements DealCorpAdmService {

	@Inject
	private DealCorpAdmDAO dao;

	//거래처정보관리 목록조회
	@Override
	public List<DealCorpAdmVo> listAll(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.listAll(dealCorpAdmVo);
	}

	//거래처정보관리 상세조회
	@Override
	public DealCorpAdmVo read(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		return dao.read(dealCorpAdmVo);	
	}
	
	//거래처정보관리 등록
	@Override
	public void create(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.create(dealCorpAdmVo);
	}
	
	//거래처정보관리 수정
	@Override
	public void update(DealCorpAdmVo dealCorpAdmVo) throws Exception {
		dao.update(dealCorpAdmVo);
	}
	
	//거래처정보관리 거래처시퀀스코드정보
	@Override
	public String selectDealCorpSeqCd() throws Exception {
		return dao.selectDealCorpSeqCd();
	}
}

	