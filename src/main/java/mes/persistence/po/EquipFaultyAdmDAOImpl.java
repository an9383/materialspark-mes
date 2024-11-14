package mes.persistence.po;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.EquipMatrlFaultyAdmVo;
import mes.domain.po.EquipPrcssFaultyAdmVo;
import mes.domain.po.EquipReplaceFaultyAdmVo;
import mes.domain.po.EquipTroubleFaultyAdmVo;
import mes.domain.po.FaultyQtyVo;
import mes.domain.po.TotalFaultyAdmVo;
import mes.domain.wm.FaultyHistoryVo;

@Repository
public class EquipFaultyAdmDAOImpl implements EquipFaultyAdmDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.po.equipFaultyAdmMapper";

	/* 공정불량  */
	//공정불량 조회
	@Override
	public EquipPrcssFaultyAdmVo readPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return session.selectOne(namespace + ".readPrcssFaulty", equipPrcssFaultyAdmVo);
	}
	
	//공정불량 등록
	@Override
	public void createPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		session.insert(namespace + ".createPrcssFaulty", equipPrcssFaultyAdmVo);
	}	 
	 
	//공정불량 수정
	@Override
	public void updatePrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		session.update(namespace + ".updatePrcssFaulty", equipPrcssFaultyAdmVo);
	}
	
	
	
	/* 원자재불량  */
	//원자재불량 조회
	@Override
	public EquipMatrlFaultyAdmVo readMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		return session.selectOne(namespace + ".readMatrlFaulty", equipMatrlFaultyAdmVo);
	}
	
	//원자재불량 등록
	@Override
	public void createMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		session.insert(namespace + ".createMatrlFaulty", equipMatrlFaultyAdmVo);
	}	 
	 
	//원자재불량 수정
	@Override
	public void updateMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		session.update(namespace + ".updateMatrlFaulty", equipMatrlFaultyAdmVo);
	}
	
	
	
	/* 교체불량  */
	//교체불량 조회
	@Override
	public EquipReplaceFaultyAdmVo readReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return session.selectOne(namespace + ".readReplaceFaulty", equipReplaceFaultyAdmVo);
	}
	
	//교체불량 등록
	@Override
	public void createReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		session.insert(namespace + ".createReplaceFaulty", equipReplaceFaultyAdmVo);
	}	 
	 
	//교체불량 수정
	@Override
	public void updateReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		session.update(namespace + ".updateReplaceFaulty", equipReplaceFaultyAdmVo);
	}
	
	
	
	/* 설비 트러블 불량  */
	//설비 트러블 불량 조회
	@Override
	public EquipTroubleFaultyAdmVo readTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return session.selectOne(namespace + ".readTroubleFaulty", equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 등록
	@Override
	public void createTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		session.insert(namespace + ".createTroubleFaulty", equipTroubleFaultyAdmVo);
	}	 
	 
	//설비 트러블 불량 수정
	@Override
	public void updateTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		session.update(namespace + ".updateTroubleFaulty", equipTroubleFaultyAdmVo);
	}
	
	
	
	/* 총 합 계산   */
	//공정불량 총합
	//@Override
	//public EquipPrcssFaultyAdmVo totalPrcssFaulty(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
	//	return session.selectOne(namespace + ".totalPrcssFaulty", equipPrcssFaultyAdmVo);
	//}
	
	//원자재불량 총합
	//@Override
	//public EquipMatrlFaultyAdmVo totalMatrlFaulty(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
	//	return session.selectOne(namespace + ".totalMatrlFaulty", equipMatrlFaultyAdmVo);
	//}
	
	//교체불량 총합
	//@Override
	//public EquipReplaceFaultyAdmVo totalReplaceFaulty(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
	//	return session.selectOne(namespace + ".totalReplaceFaulty", equipReplaceFaultyAdmVo);
	//}
	
	//설비불량 총합
	//@Override
	//public EquipTroubleFaultyAdmVo totalTroubleFaulty(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
	//	return session.selectOne(namespace + ".totalTroubleFaulty", equipTroubleFaultyAdmVo);
	//}
	
	//불량 통계
	@Override
	public TotalFaultyAdmVo totalFaulty(TotalFaultyAdmVo totalFaultyAdmVo) throws Exception {
		return session.selectOne(namespace + ".totalFaulty", totalFaultyAdmVo);
	}
	
	
	
	
	/* 불량 내역조회(전체) 기간 조회(wmsc0070) */
	//불량전체 기간 조회
	public List<FaultyHistoryVo> readFaultyHistoryList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readFaultyHistoryList", faultyHistoryVo);
	}
	
	//생산실적 기종별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputGoodsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputGoodsList", faultyHistoryVo);
	}
	
	//생산실적 설비별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputEquipsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputEquipsList", faultyHistoryVo);
	}
	
	//생산실적 직원별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputPeopolesList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputPeopolesList", faultyHistoryVo);
	}
	
	//생산실적 자재별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputMatrlsList(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputMatrlsList", faultyHistoryVo);
	}
	
	
	
	//생산실적 기종별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputGoodsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputGoodsList_F3", faultyHistoryVo);
	}
	
	//생산실적 설비별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputEquipsList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputEquipsList_F3", faultyHistoryVo);
	}
	
	//생산실적 직원별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputPeopolesList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception {
		return session.selectList(namespace + ".readActualOutputPeopolesList_F3", faultyHistoryVo);
	}
	
	//생산실적 일자별(불량내역전체 포함)
	@Override
	public List<FaultyHistoryVo> readActualOutputDateList_F3(FaultyHistoryVo faultyHistoryVo) throws Exception{
		return session.selectList(namespace + ".readActualOutputDateList_F3", faultyHistoryVo);
	}
	
	
	
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	//공정불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readPrcssFaultyListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readPrcssFaultyListKg", equipPrcssFaultyAdmVo);
	}
	
	//원자재불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readMatrlFaultyListKg(EquipMatrlFaultyAdmVo equipMatrlFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readMatrlFaultyListKg", equipMatrlFaultyAdmVo);
	}
	
	//교체 불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readReplaceFaultyListKg(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readReplaceFaultyListKg", equipReplaceFaultyAdmVo);
	}
	
	//교체 불량 기간 조회 (횟수)
	@Override
	public List<Map<String,String>> readReplaceFaultyListCount(EquipReplaceFaultyAdmVo equipReplaceFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readReplaceFaultyListCount", equipReplaceFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (양)
	@Override
	public List<Map<String,String>> readTroubleFaultyListKg(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readTroubleFaultyListKg", equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (횟수)
	@Override
	public List<Map<String,String>> readTroubleFaultyListCount(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readTroubleFaultyListCount", equipTroubleFaultyAdmVo);
	}
	
	//설비 트러블 불량 기간 조회 (내용)
	@Override
	public List<Map<String,String>> readTroubleFaultyListContent(EquipTroubleFaultyAdmVo equipTroubleFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".readTroubleFaultyListContent", equipTroubleFaultyAdmVo);
	}
	
	//권취중량 일별 조회
	public List<FaultyQtyVo> readFaultyQty(FaultyQtyVo faultyQtyVo) throws Exception {
		//생산실적기준 주자재 추가 전(주야구분 O)
		if (Integer.parseInt(faultyQtyVo.getFaultyDateTo()) < 20211129) {
			return session.selectList(namespace + ".readFaultyQty", faultyQtyVo);
		
		//생산실적기준 주자재 추가 후(주야구분 X)
		} else {
			return session.selectList(namespace + ".readFaultyQtyNotOrdGubun", faultyQtyVo);
		}
	}
	/* 불량 내역조회(상세) 기간 조회(wmsc0080) */
	
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	//공정불량 통계 리스트 kg
	@Override
	public List<Map<String,String>> faultyIntegratedListKg(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".faultyIntegratedListKg", equipPrcssFaultyAdmVo);
	}
	//공정불량 통계 리스트  횟수
	@Override
	public List<Map<String,String>> faultyIntegratedListCount(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".faultyIntegratedListCount", equipPrcssFaultyAdmVo);
	}
	//공정불량  통계 리스트 내용
	@Override
	public List<Map<String,String>> faultyIntegratedListContent(EquipPrcssFaultyAdmVo equipPrcssFaultyAdmVo) throws Exception {
		return session.selectList(namespace + ".faultyIntegratedListContent", equipPrcssFaultyAdmVo);
	}
	/* 불량 내역조회(상세) 기간 조회(wmsc3080) */
	
	
	
}
