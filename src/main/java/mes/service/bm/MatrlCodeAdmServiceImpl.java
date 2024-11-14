package mes.service.bm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bm.MatrlCodeAdmVo;
import mes.persistence.bm.MatrlCodeAdmDAO;


@Service
public class MatrlCodeAdmServiceImpl implements MatrlCodeAdmService {
	@Inject
	private MatrlCodeAdmDAO dao;

	//자재코드관리 목록조회
	@Override
	public List<MatrlCodeAdmVo> listAll(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		return dao.listAll(matrlCodeAdmVo);
	}
	
	//자재코드&명 리스트
	@Override
	public List<MatrlCodeAdmVo> matrlCdList(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		return dao.listAll(matrlCodeAdmVo);
	}
	
	//자재코드관리 상세조회
	@Override
	public MatrlCodeAdmVo read(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		return dao.read(matrlCodeAdmVo);
	}
	
	//자재코드관리 등록	
	@Override
	public void create(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		dao.create(matrlCodeAdmVo);
	}
	
	//자재코드관리 수정
	@Override
	public void update(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		dao.update(matrlCodeAdmVo);
	}
	
	//자재코드관리 코드시퀀스조회	
	@Override
	public String selectMatrlSeqCd() throws Exception{
		return dao.selectMatrlSeqCd();
	}
	
	//자재코드관리 중복검사진행
	@Override
	public MatrlCodeAdmVo matrlCodeDupliCheck(MatrlCodeAdmVo matrlCodeAdmVo) throws Exception{
		return dao.matrlCodeDupliCheck(matrlCodeAdmVo);
	}
}
