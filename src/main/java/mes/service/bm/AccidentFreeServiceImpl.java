package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.AccidentFreeVo;
import mes.domain.bm.DealCorpAdmVo;
import mes.persistence.bm.AccidentFreeDAO;
import mes.persistence.bm.DealCorpAdmDAO;

@Service
public class AccidentFreeServiceImpl implements AccidentFreeService {

	@Inject
	private AccidentFreeDAO dao;

	//무재해정보 조회
	@Override
	public List<AccidentFreeVo> listAll(AccidentFreeVo accidentFreeVo) throws Exception{
		return dao.listAll(accidentFreeVo);
	}
	
	//현수막정보 조회
	@Override
	public List<AccidentFreeVo> listImg(AccidentFreeVo accidentFreeVo) throws Exception{
		return dao.listImg(accidentFreeVo);
	}
	
	//무재해정보 조회
	@Override
	public AccidentFreeVo read(AccidentFreeVo accidentFreeVo) throws Exception{
		return dao.read(accidentFreeVo);
	}
	
	//무재해정보 등록
	@Override
	public void create(AccidentFreeVo accidentFreeVo) throws Exception{
		dao.create(accidentFreeVo);
	}
	
	//무재해정보 수정
	@Override
	public void update(AccidentFreeVo accidentFreeVo) throws Exception{
		dao.update(accidentFreeVo);
	}
	
	//현수막 이미지 등록
	public void createImg(AccidentFreeVo accidentFreeVo) throws Exception{
		dao.createImg(accidentFreeVo);
	}
	
	//현수막 이미지 등록 수정
	public void updateImg(AccidentFreeVo accidentFreeVo) throws Exception{
		dao.updateImg(accidentFreeVo);
	}
	
	//무재해 시퀀스 조회
	@Override
	public String selectIdx() throws Exception{
		return dao.selectIdx();
	}
	
	//현수막 시퀀스 조회
	@Override
	public String selectIdxImg() throws Exception{
		return dao.selectIdxImg();
	}
}

	