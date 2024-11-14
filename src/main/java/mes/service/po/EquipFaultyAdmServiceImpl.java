package mes.service.po;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.EquipMatrlFaultyAdmVo;
import mes.domain.po.EquipPrcssFaultyAdmVo;
import mes.domain.po.EquipReplaceFaultyAdmVo;
import mes.domain.po.EquipTroubleFaultyAdmVo;
import mes.domain.po.FaultyQtyVo;
import mes.domain.po.TotalFaultyAdmVo;
import mes.domain.wm.FaultyHistoryVo;
import mes.persistence.po.EquipFaultyAdmDAO;

@Service
public class EquipFaultyAdmServiceImpl implements EquipFaultyAdmService {

	@Inject
	private EquipFaultyAdmDAO dao;
	
	/* 공정불량 */
	//공정불량 조회
	@Override
	public EquipPrcssFaultyAdmVo readPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return dao.readPrcssFaulty(equipPrcssFaultyAdmVo);
	}
	
	//공정불량등록
	 @Override
	 public void createPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		 dao.createPrcssFaulty(equipPrcssFaultyAdmVo);
	 }	 
		
	//공정불량 수정
	@Override
	public void updatePrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		dao.updatePrcssFaulty(equipPrcssFaultyAdmVo);
	}


	/* 원자재불량 */
	//원자재불량 조회
	@Override
	public EquipMatrlFaultyAdmVo readMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		return dao.readMatrlFaulty(equipMatrlFaultyAdmVo);
	}
	
	//원자재불량등록
	 @Override
	 public void createMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		 dao.createMatrlFaulty(equipMatrlFaultyAdmVo);
	 }	 
		
	//원자재불량 수정
	@Override
	public void updateMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		dao.updateMatrlFaulty(equipMatrlFaultyAdmVo);
	}
	
	
	/* 교체불량 */
	//교체불량 조회
	@Override
	public EquipReplaceFaultyAdmVo readReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return dao.readReplaceFaulty(equipReplaceFaultyAdmVo);
	}
	
	//교체불량 등록
	 @Override
	 public void createReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		 dao.createReplaceFaulty(equipReplaceFaultyAdmVo);
	 }	 
		
	//교체불량 수정
	@Override
	public void updateReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		dao.updateReplaceFaulty(equipReplaceFaultyAdmVo);
	}
	
	
	/* 설비 트러블 불량 */
	//설비 트러블 불량 조회
	@Override
	public EquipTroubleFaultyAdmVo readTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return dao.readTroubleFaulty(equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 등록
	 @Override
	 public void createTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		 dao.createTroubleFaulty(equipTroubleFaultyAdmVo);
	 }	 
		
	//설비 트러블 불량 수정
	@Override
	public void updateTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		dao.updateTroubleFaulty(equipTroubleFaultyAdmVo);
	}
	
	
	/* 총 합 계산   */
	//공정불량 총합
	//@Override
	//public EquipPrcssFaultyAdmVo totalPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
	//	return dao.totalPrcssFaulty(equipPrcssFaultyAdmVo);
	//}
	
	//원자재불량 총합
	//@Override
	//public EquipMatrlFaultyAdmVo totalMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
	//	return dao.totalMatrlFaulty(equipMatrlFaultyAdmVo);
	//}
	
	//교체불량 총합
	//@Override
	//public EquipReplaceFaultyAdmVo totalReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
	//	return dao.totalReplaceFaulty(equipReplaceFaultyAdmVo);
	//}
	
	//설비 트러블 불량 총합
	//@Override
	//public EquipTroubleFaultyAdmVo totalTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
	//	return dao.totalTroubleFaulty(equipTroubleFaultyAdmVo);
	//}
	
	//불량 통계
	@Override
	public TotalFaultyAdmVo totalFaulty(TotalFaultyAdmVo totalFaultyAdmVo) throws Exception {
		return dao.totalFaulty(totalFaultyAdmVo);
	}
	
	/* 불량 내역조회(전체) 기간 조회(wmsc0070) */
	//불량전체 기간 조회
	@Override
	public List<FaultyHistoryVo> readFaultyHistoryList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readFaultyHistoryList(faultyHistoryVo);
	}
	
	//생산실적 기종별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputGoodsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputGoodsList(faultyHistoryVo);
	}
	
	//생산실적 설비별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputEquipsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputEquipsList(faultyHistoryVo);
	}
	
	//생산실적 직원별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputPeopolesList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputPeopolesList(faultyHistoryVo);
	}
	
	//생산실적 자재별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputMatrlsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputMatrlsList(faultyHistoryVo);
	}
	

	
	
	//생산실적 기종별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputGoodsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputGoodsList_F3(faultyHistoryVo);
	}
	
	//생산실적 설비별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputEquipsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputEquipsList_F3(faultyHistoryVo);
	}
	
	//생산실적 직원별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputPeopolesList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return dao.readActualOutputPeopolesList_F3(faultyHistoryVo);
	}
	
	//생산실적 일자별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputDateList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception{
		return dao.readActualOutputDateList_F3(faultyHistoryVo);
	}
	
	
	
	
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	//공정불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readPrcssFaultyListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return dao.readPrcssFaultyListKg(equipPrcssFaultyAdmVo);
	}
	
	//원자재불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readMatrlFaultyListKg(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		return dao.readMatrlFaultyListKg(equipMatrlFaultyAdmVo);
	}
	
	//교체 불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readReplaceFaultyListKg(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return dao.readReplaceFaultyListKg(equipReplaceFaultyAdmVo);
	}
	
	//교체 불량 기간 조회 (횟수)
	@Override
	public List<Map<String,String>> readReplaceFaultyListCount(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return dao.readReplaceFaultyListCount(equipReplaceFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readTroubleFaultyListKg(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return dao.readTroubleFaultyListKg(equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (횟수)
	@Override
	public List<Map<String,String>> readTroubleFaultyListCount(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return dao.readTroubleFaultyListCount(equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (내용)
	@Override
	public List<Map<String,String>> readTroubleFaultyListContent(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return dao.readTroubleFaultyListContent(equipTroubleFaultyAdmVo);
	}
	
	//권취중량 일별 조회
	@Override
	public List<FaultyQtyVo> readFaultyQty(FaultyQtyVo faultyQtyVo) throws Exception {
		return dao.readFaultyQty(faultyQtyVo);
	}
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	
	
	
	
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	//공정불량 통계 리스트 kg
	@Override
	public List<Map<String,String>> faultyIntegratedListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return dao.faultyIntegratedListKg(equipPrcssFaultyAdmVo);
	}
	
	//공정불량 통계 리스트  횟수
	@Override
	public List<Map<String,String>> faultyIntegratedListCount(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return dao.faultyIntegratedListCount(equipPrcssFaultyAdmVo);
	}
	
	//공정불량  통계 리스트 내용
	@Override
	public List<Map<String,String>> faultyIntegratedListContent(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return dao.faultyIntegratedListContent(equipPrcssFaultyAdmVo);
	}
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	
}