package mes.persistence.qm;

import java.util.List;
import java.util.Map;

import mes.domain.qm.ShipInspectTempListVo;
import mes.domain.qm.ShipInspectVo;


public interface ShipInspectDAO {
	
	//출하검사 트레이조회
	public List<ShipInspectVo> shipInspSelectList(ShipInspectVo shipInspectVo) throws Exception;	
	
	//출하재검사 트레이조회
	public List<ShipInspectVo> reShipInspSelectList2(ShipInspectVo shipInspectVo) throws Exception;	
	
	//출하검사 메인 조회
	public List<ShipInspectVo> shipInspAdmRead(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 세부내역 조회
	public List<ShipInspectVo> shipInspDtlRead(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 메인 생성
	public void shipAdmCreate(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 서브 생성
	public void shipDtlCreate(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 메인 삭제
	public void shipAdmDelete(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 서브 삭제
	public void shipDtlDelete(ShipInspectVo shipInspectVo) throws Exception;

	//출하검사 메인 수정
	public void shipAdmUpdate(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 메탈, 필름 로트 추가
	public void shipAdmLotNoUpdate(ShipInspectVo shipInspectVo) throws Exception;

	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기 (재검)
	public ShipInspectVo getAddLotNo(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 현 설비에서 가장 가까운 시일의 metal,film lot가져오기 (출하검사)
	public List<ShipInspectVo> getAddLotNoList(ShipInspectVo shipInspectVo) throws Exception;
	
	//솔브레인 재검사 Lot_No 불러오기
	public ShipInspectVo getReTestAddLotNoReadt_F3(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 재검상태 업데이트
	public void shipAdmReInspStatUpdate(ShipInspectVo shipInspectVo) throws Exception;
	
	//시퀀스가져오기
	public String selectTraySeq(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 폐기상태 업데이트
	public void shipAdmDisStatusUpdate(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사현황 리스트
	public List<Map<String,String>> shipInspStatusList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사현황 리스트 SLD
	public List<Map<String,String>> shipInspStatusList_fa3(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 현황(상세) 조회
	public List<ShipInspectTempListVo> shipInspStatusDetailList(ShipInspectTempListVo shipInspectTempListVo) throws Exception;
	
	//출하검사 트레이 이력조회
	public List<ShipInspectVo> shipListRecord(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하재검사 트레이 이력조회
	public List<ShipInspectVo> shipListRecordDtl(ShipInspectVo shipInspectVo) throws Exception;
	
	//3공장 트레이 스캔  출하검사/재검/출하재검
	public List<ShipInspectVo> shipInspSelectListFn3(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 트레이조회
	public List<ShipInspectVo> shipInspTotalList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (일자별) 검사일
	public List<Map<String,String>> shipInspTotalDateList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (기간별) 검사일
	public List<Map<String,String>> shipInspTotalDayList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (제품별) 검사일
	public List<Map<String,String>> shipInspTotalGoodsList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (설비별) 검사일
	public List<Map<String,String>> shipInspTotalEquipList(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (일자별) 검사일자 SLD
	public List<Map<String,String>> shipInspTotalDateList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (기간별) 검사일자 SLD
	public List<Map<String,String>> shipInspTotalDayList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (제품별) 검사일자 SLD
	public List<Map<String,String>> shipInspTotalGoodsList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (설비별) 검사일자 SLD
	public List<Map<String,String>> shipInspTotalEquipList_fa3_insp(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (일자별) 생산일자 SLD
	public List<Map<String,String>> shipInspTotalDateList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (기간별) 생산일자 SLD
	public List<Map<String,String>> shipInspTotalDayList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (제품별) 생산일자 SLD
	public List<Map<String,String>> shipInspTotalGoodsList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception;
	
	//출하검사 집계표 (설비별) 생산일자 SLD
	public List<Map<String,String>> shipInspTotalEquipList_fa3_prod(ShipInspectVo shipInspectVo) throws Exception;

	
	

	
	//------------------------------------------------------------------------------------------재검등록------------------------------------------------------------------------
	
	//재검등록 트레이조회
	public List<ShipInspectVo> reShipInspSelectList(ShipInspectVo shipInspectVo) throws Exception;
	
	//제품입고시 출하검사 확인
	public ShipInspectVo shipInspectAdmSelByGoodsIn(ShipInspectVo shipInspectVo) throws Exception;
	
	//재검현황 조회
	public List<ShipInspectVo> shipInspStatusListReInsp(ShipInspectVo shipInspectVo) throws Exception;
	
	//재검 등록 안되어 있으면 재검 요청 취소
	public ShipInspectVo reInspectRequestCancel(ShipInspectVo shipInspectVo) throws Exception;
	
	
	//재검 등록 안되어 있으면 재검 요청 취소
	public ShipInspectVo shipInspectMaxIdxRead(ShipInspectVo shipInspectVo) throws Exception;
	
	
	
}