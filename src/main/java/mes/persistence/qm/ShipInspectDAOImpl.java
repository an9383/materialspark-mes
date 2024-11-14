package mes.persistence.qm;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ShipInspectTempListVo;
import mes.domain.qm.ShipInspectVo;

@Repository
public class ShipInspectDAOImpl implements ShipInspectDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.qm.shipInspectMapper";

	//출하검사 트레이조회
	@Override
	public List<ShipInspectVo> shipInspSelectList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspSelectList", shipInspectVo);
	}
	
	//출하재검사 트레이조회
	@Override
	public List<ShipInspectVo> reShipInspSelectList2(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".reShipInspSelectList2", shipInspectVo);
	}
	
	//출하검사 메인 조회
	@Override
	public List<ShipInspectVo> shipInspAdmRead(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspAdmRead", shipInspectVo);
	}
	
	//출하검사 세부내역 조회
	@Override
	public List<ShipInspectVo> shipInspDtlRead(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspDtlRead", shipInspectVo);
	}

	//출하검사 메인 생성
	@Override
	public void shipAdmCreate(ShipInspectVo shipInspectVo) throws Exception{
		session.insert(namespace + ".shipAdmCreate", shipInspectVo);
	}
	
	//출하검사 서브 생성
	@Override
	public void shipDtlCreate(ShipInspectVo shipInspectVo) throws Exception{
		session.insert(namespace + ".shipDtlCreate", shipInspectVo);
	}
	
	//출하검사 메인 삭제
	@Override
	public void shipAdmDelete(ShipInspectVo shipInspectVo) throws Exception{
		session.delete(namespace + ".shipAdmDelete", shipInspectVo);
	}
	
	//출하검사 서브 삭제
	@Override
	public void shipDtlDelete(ShipInspectVo shipInspectVo) throws Exception{
		session.delete(namespace + ".shipDtlDelete", shipInspectVo);
	}

	//출하검사 메인 수정
	@Override
	public void shipAdmUpdate(ShipInspectVo shipInspectVo) throws Exception{
		session.update(namespace + ".shipAdmUpdate", shipInspectVo);
	}
	
	//출하검사 메탈, 필름 로트 추가
	@Override
	public void shipAdmLotNoUpdate(ShipInspectVo shipInspectVo) throws Exception{
		session.update(namespace + ".shipAdmLotNoUpdate", shipInspectVo);
	}
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기
	@Override
	public ShipInspectVo getAddLotNo(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".getAddLotNo", shipInspectVo);
	}
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기 (출하검사)
	@Override
	public List<ShipInspectVo> getAddLotNoList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".getAddLotNoList", shipInspectVo);
	}
	
	//솔브레인 재검사 Lot_No 불러오기
	@Override
	public ShipInspectVo getReTestAddLotNoReadt_F3(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".getReTestAddLotNoReadt_F3", shipInspectVo);
	}
	
	
	//출하검사 재검상태 업데이트
	@Override
	public void shipAdmReInspStatUpdate(ShipInspectVo shipInspectVo) throws Exception{
		session.update(namespace + ".shipAdmReInspStatUpdate", shipInspectVo);
	}
	
	//시퀀스가져오기
	@Override
	public String selectTraySeq(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".selectTraySeq", shipInspectVo);
	}
	
	//출하검사 폐기상태 업데이트
	@Override
	public void shipAdmDisStatusUpdate(ShipInspectVo shipInspectVo) throws Exception{
		session.update(namespace + ".shipAdmDisStatusUpdate", shipInspectVo);
	}
	
	//출하검사현황 리스트
	@Override
	public List<Map<String,String>> shipInspStatusList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspStatusList", shipInspectVo);
	}
	
	//출하검사현황 리스트 SLD
	@Override
	public List<Map<String,String>> shipInspStatusList_fa3(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspStatusList_fa3", shipInspectVo);
	}
	
	//출하검사 현황(상세) 조회
	@Override
	public List<ShipInspectTempListVo> shipInspStatusDetailList(ShipInspectTempListVo shipInspectTempListVo) throws Exception{
		return session.selectList(namespace + ".shipInspStatusDetailList", shipInspectTempListVo);
	}

	//출하검사 트레이 이력조회
	@Override
	public List<ShipInspectVo> shipListRecord(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipListRecord", shipInspectVo);
	}
	
	//출하재검사 트레이 이력조회
	@Override
	public List<ShipInspectVo> shipListRecordDtl(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipListRecordDtl", shipInspectVo);
	}
	
	//3공장 트레이 스캔  출하검사/재검/출하재검
	@Override
	public List<ShipInspectVo> shipInspSelectListFn3(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspSelectListFn3", shipInspectVo);
	}

	//출하검사집계표 트레이조회
	@Override
	public List<ShipInspectVo> shipInspTotalList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalList", shipInspectVo);
	}
	
	//출하검사 집계표 (일자별)
	@Override
	public List<Map<String,String>> shipInspTotalDateList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDateList", shipInspectVo);
	}
	
	//출하검사 집계표 (기간별)
	@Override
	public List<Map<String,String>> shipInspTotalDayList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDayList", shipInspectVo);
	}
	
	//출하검사 집계표 (제품별)
	@Override
	public List<Map<String,String>> shipInspTotalGoodsList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalGoodsList", shipInspectVo);
	}
	
	//출하검사 집계표 (설비별)
	@Override
	public List<Map<String,String>> shipInspTotalEquipList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalEquipList", shipInspectVo);
	}
	
	
	
	//출하검사 집계표 (일자별) 검사일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalDateList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDateList_fa3_insp", shipInspectVo);
	}
	
	//출하검사 집계표 (기간별) 검사일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalDayList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDayList_fa3_insp", shipInspectVo);
	}
	
	//출하검사 집계표 (제품별) 검사일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalGoodsList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalGoodsList_fa3_insp", shipInspectVo);
	}
	
	//출하검사 집계표 (설비별) 검사일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalEquipList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalEquipList_fa3_insp", shipInspectVo);
	}
	
	//출하검사 집계표 (일자별) 생산일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalDateList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDateList_fa3_prod", shipInspectVo);
	}
	
	//출하검사 집계표 (기간별) 생산일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalDayList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalDayList_fa3_prod", shipInspectVo);
	}
	
	//출하검사 집계표 (제품별) 생산일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalGoodsList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalGoodsList_fa3_prod", shipInspectVo);
	}
	
	//출하검사 집계표 (설비별) 생산일자 SLD
	@Override
	public List<Map<String,String>> shipInspTotalEquipList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspTotalEquipList_fa3_prod", shipInspectVo);
	}
	//------------------------------------------------------------------------------------------재검등록------------------------------------------------------------------------
	
	//재검등록 트레이조회
	@Override
	public List<ShipInspectVo> reShipInspSelectList(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".reShipInspSelectList", shipInspectVo);
	}
	
	//제품입고시 출하검사 확인
	@Override
	public ShipInspectVo shipInspectAdmSelByGoodsIn(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".shipInspectAdmSelByGoodsIn", shipInspectVo);
	}
	
	//재검현황 조회
	@Override
	public List<ShipInspectVo> shipInspStatusListReInsp(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectList(namespace + ".shipInspStatusListReInsp", shipInspectVo);
	}
	
	
	//재검 등록 안되어 있으면 재검 요청 취소
	@Override
	public ShipInspectVo reInspectRequestCancel(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".reInspectRequestCancel", shipInspectVo);
	}
	
	//재검 등록 안되어 있으면 재검 요청 취소
	@Override
	public ShipInspectVo shipInspectMaxIdxRead(ShipInspectVo shipInspectVo) throws Exception{
		return session.selectOne(namespace + ".shipInspectMaxIdxRead", shipInspectVo);
	}
	
}