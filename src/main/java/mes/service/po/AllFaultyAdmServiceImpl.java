package mes.service.po;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.AllFaultyAdmVo;
import mes.persistence.po.AllFaultyAdmDAO;

@Service
public class AllFaultyAdmServiceImpl implements AllFaultyAdmService {

	@Inject
	private AllFaultyAdmDAO dao;
	
	/* 공정불량 */
	//공정불량 조회
	@Override
	public List<AllFaultyAdmVo> readPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return dao.readPrcssFaulty(allFaultyAdmVo);
	}
	
	//공정불량 조회(업데이트용)
	@Override
	public List<AllFaultyAdmVo> readUpdPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return dao.readUpdPrcssFaulty(allFaultyAdmVo);
	}
	
	//공정불량 상세조회
	@Override
	public AllFaultyAdmVo readDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return dao.readDtlPrcssFaulty(allFaultyAdmVo);
	}
	
	//공정불량 상세조회(업데이트용)
	@Override
	public AllFaultyAdmVo readUpdDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return dao.readUpdDtlPrcssFaulty(allFaultyAdmVo);
	}
		
	//테프론 목록 조회
	@Override
	public List<AllFaultyAdmVo> readPtfeFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return dao.readPtfeFaulty(allFaultyAdmVo);
	}
	
	//공정불량등록
	 @Override
	 public void createFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		 dao.createFaultyAll(allFaultyAdmVo);
	 }	 
		
	//공정불량 수정
	@Override
	public void updateFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		dao.updateFaultyAll(allFaultyAdmVo);
	}
	
	//공정불량 삭제
	@Override
	public void deleteFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		dao.deleteFaultyAll(allFaultyAdmVo);
	}
	
	//테프론 삭제
	public void deletePtfe(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		dao.deletePtfe(allFaultyAdmVo);
	}
	
	
	/*불량중량*/
	//불량중량  조회
	@Override
	public List<AllFaultyAdmVo> badWeightList(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return dao.badWeightList(allFaultyAdmVo);
	}
	
	//작지 취소 시 등록된 불량중량이 있는지 확인
	@Override
	public List<AllFaultyAdmVo> cancelWorkOrdTotalFaultyCheck(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		return dao.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);
	}
	
	//테프론 시퀀스
	@Override
	public AllFaultyAdmVo ptfeSeq(AllFaultyAdmVo allFaultyAdmVo) throws Exception{
		return dao.ptfeSeq(allFaultyAdmVo);
	}

}