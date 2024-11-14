package mes.service.po;

import java.util.List;

import mes.domain.po.AllFaultyAdmVo;

public interface AllFaultyAdmService {

	/* 공정불량  */
	//공정불량 조회
	public List<AllFaultyAdmVo> readPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 조회(업데이트용)
	public List<AllFaultyAdmVo> readUpdPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 상세조회
	public AllFaultyAdmVo readDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 상세조회(업데이트용)
	public AllFaultyAdmVo readUpdDtlPrcssFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//테프론 목록 조회
	public List<AllFaultyAdmVo> readPtfeFaulty(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 등록
	public void createFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 수정
	public void updateFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//공정불량 삭제
	public void deleteFaultyAll(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//테프론 삭제
	public void deletePtfe(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	
	/* 불량중량  */
	//불량중량 조회
	public List<AllFaultyAdmVo> badWeightList(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//작지 취소 시 등록된 불량중량이 있는지 확인
	public List<AllFaultyAdmVo> cancelWorkOrdTotalFaultyCheck(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
	
	//테프론 시퀀스
	public AllFaultyAdmVo ptfeSeq(AllFaultyAdmVo allFaultyAdmVo) throws Exception;
}