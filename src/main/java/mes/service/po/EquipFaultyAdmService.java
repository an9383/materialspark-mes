package mes.service.po;

import java.util.List;
import java.util.Map;

import mes.domain.po.EquipMatrlFaultyAdmVo;
import mes.domain.po.EquipPrcssFaultyAdmVo;
import mes.domain.po.EquipReplaceFaultyAdmVo;
import mes.domain.po.EquipTroubleFaultyAdmVo;
import mes.domain.po.FaultyQtyVo;
import mes.domain.po.TotalFaultyAdmVo;
import mes.domain.wm.FaultyHistoryVo;

public interface EquipFaultyAdmService {

	/* 공정불량 */
	//공정불량 조회
	public EquipPrcssFaultyAdmVo readPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	
	//공정불량 등록
	public void createPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	
	//공정불량 수정
	public void updatePrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	
	
	/* 원자재불량 */
	//원자재불량 조회
	public EquipMatrlFaultyAdmVo readMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception;	
	
	//원자재불량 등록
	public void createMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception;
	
	//원자재불량 수정
	public void updateMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception;
	
	
	/* 교체불량 */
	//교체불량 조회
	public EquipReplaceFaultyAdmVo readReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;	
	
	//교체불량 등록
	public void createReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;
	
	//교체불량 수정
	public void updateReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;
	
	
	/* 설비 트러블 불량 */
	//설비 트러블 불량 조회
	public EquipTroubleFaultyAdmVo readTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;	
	
	//설비 트러블 불량 등록
	public void createTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;
	
	//설비 트러블 불량 수정
	public void updateTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;
	
	
	/* 총 합 계산   */
	//공정불량 총합
	//public EquipPrcssFaultyAdmVo totalPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	
	//원자재불량 총합
	//public EquipMatrlFaultyAdmVo totalMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception;
		
	//교체불량 총합
	//public EquipReplaceFaultyAdmVo totalReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;
	
	//설비불량 총합
	//public EquipTroubleFaultyAdmVo totalTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;
	
	//불량 통계
	public TotalFaultyAdmVo totalFaulty(TotalFaultyAdmVo totalFaultyAdmVo) throws Exception;
	
	
	/* 불량 내역조회(전체) 기간 조회(wmsc0070) */
	//불량전체 기간 조회
	public List<FaultyHistoryVo> readFaultyHistoryList(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 기종별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputGoodsList(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 설비별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputEquipsList(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 직원별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputPeopolesList(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 자재별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputMatrlsList(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	
	//생산실적 기종별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputGoodsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 설비별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputEquipsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 직원별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputPeopolesList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	//생산실적 일자별(불량내역전체 포함)
	public List<FaultyHistoryVo> readActualOutputDateList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception;
	
	
	
	
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	//공정 불량 기간 조회 (양)
	public List<Map<String,String>> readPrcssFaultyListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	
	//원자재불량 기간 조회 (양)
	public List<Map<String,String>> readMatrlFaultyListKg(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception;
	
	//교체불량 조회 (양)
	public List<Map<String,String>> readReplaceFaultyListKg(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;
	
	//교체불량 조회 (횟수)
	public List<Map<String,String>> readReplaceFaultyListCount(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception;
	
	//설비 트러블 불량 조회 (양)
	public List<Map<String,String>> readTroubleFaultyListKg(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;
	
	//설비 트러블 불량 조회 (횟수)
	public List<Map<String,String>> readTroubleFaultyListCount(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;
		
	//설비 트러블 불량 조회 (내용)
	public List<Map<String,String>> readTroubleFaultyListContent(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception;	
	
	//설비 트러블 불량 조회 (내용)
	public List<FaultyQtyVo> readFaultyQty(FaultyQtyVo faultyQtyVo) throws Exception;
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	
	
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	//공정불량 통계 리스트 kg
	public List<Map<String,String>> faultyIntegratedListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	//공정불량 통계 리스트  횟수
	public List<Map<String,String>> faultyIntegratedListCount(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	//공정불량  통계 리스트 내용
	public List<Map<String,String>> faultyIntegratedListContent(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception;
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	
	
}
