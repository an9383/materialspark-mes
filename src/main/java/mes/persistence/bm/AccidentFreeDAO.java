package mes.persistence.bm;

import java.util.List;

import mes.domain.bm.AccidentFreeVo;


public interface AccidentFreeDAO {

	//무재해정보 조회
	public List<AccidentFreeVo> listAll(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//현수막정보 조회
	public List<AccidentFreeVo> listImg(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//무재해정보 조회
	public AccidentFreeVo read(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//무재해정보 등록
	public void create(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//무재해정보 수정
	public void update(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//현수막 이미지 등록
	public void createImg(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//현수막 이미지 등록 수정
	public void updateImg(AccidentFreeVo accidentFreeVo) throws Exception;
	
	//무재해 시퀀스 조회
	public String selectIdx() throws Exception;	
	
	//현수막 시퀀스 조회
	public String selectIdxImg() throws Exception;	
}
