package mes.persistence.po;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.AgtBomVo;
import mes.domain.po.AgtSixFloorVo;
import mes.domain.po.AgtVo;
import mes.domain.po.WorkOrderVo;

@Repository
public class AgtDAOImpl implements AgtDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.po.agtMapper";
	
	//에이전트 온도 ------------------------------------------------------------------------------------------
	//에이젼트 온도 데이터 읽기
	@Override
	public AgtVo readTemp(AgtVo agtVo) throws Exception {
		return session.selectOne(namespace + ".readTemp", agtVo);
	}
	
	//에이젼트 온도 조건 읽기
	@Override
	public EquipTempaturCondAdm readTempCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception {
		return session.selectOne(namespace + ".readTempCond", equipTempaturCondAdm);
	}
	
	//에이젼트 온도 데이터 수정
	@Override
	public void updateTemp(AgtVo agtVo) throws Exception {
		session.update(namespace + ".updateTemp", agtVo);
	}
	
	//에이젼트 온도 데이터 존재여부 확인
	@Override
	public int checkTemp(AgtVo agtVo) throws Exception {
		return session.selectOne(namespace + ".checkTemp", agtVo);
	}
	
	//에이전트 치수 ------------------------------------------------------------------------------------------
	//에이젼트 치수 데이터 읽기
	@Override
	public AgtVo readSize(AgtVo agtVo) throws Exception {
		return session.selectOne(namespace + ".readSize", agtVo);
	}
	
	//에이젼트 치수 데이터 읽기
	@Override
	public List<AgtSixFloorVo> agtSizeSixFloorList(AgtSixFloorVo agtSixFloorVo) throws Exception {
		return session.selectList(namespace + ".agtSizeSixFloorList", agtSixFloorVo);
	}
	
	//에이젼트 치수 조건 읽기
	@Override
	public EquipTempaturCondAdm readSizeCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception {
		return session.selectOne(namespace + ".readSizeCond", equipTempaturCondAdm);
	}
	
	//에이젼트 치수 데이터 수정
	@Override
	public void updateSize(AgtVo agtVo) throws Exception {
		session.update(namespace + ".updateSize", agtVo);
	}
	
	//에이젼트 치수 데이터 수정
	@Override
	public void agtSizeSixFloorUpdate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.update(namespace + ".agtSizeSixFloorUpdate", agtSixFloorVo);
	}
	
	//에이젼트 치수 추가 데이터 수정
	@Override
	public void updateSizeMore(AgtVo agtVo) throws Exception {
		session.update(namespace + ".updateSizeMore", agtVo);
	}

	//에이젼트 치수 데이터 존재여부 확인
	@Override
	public int checkSize(AgtVo agtVo) throws Exception {
		return session.selectOne(namespace + ".checkSize", agtVo);
	}
	
	//에이젼트 ViewBom 데이터 존재여부 확인
	@Override
	public int checkViewBomData(AgtBomVo agtBomVo) throws Exception {
		return session.selectOne(namespace + ".checkViewBomData", agtBomVo);
	}

	//에이젼트 ViewBom 작지 조회
	@Override
	public AgtBomVo readViewBomData(AgtBomVo agtBomVo) throws Exception {
		return session.selectOne(namespace + ".readViewBomData", agtBomVo);
	}
	
	//AGT 시간 등록
	@Override
	public void createTime(AgtVo agtVo) throws Exception {
		session.insert(namespace + ".createTime", agtVo);
	}
	
	//AGT 압력 등록
	@Override
	public void createPressure(AgtVo agtVo) throws Exception {
		session.insert(namespace + ".createPressure", agtVo);
	}
	
	//AGT 온도 등록
	@Override
	public void createTempature(AgtVo agtVo) throws Exception {
		session.insert(namespace + ".createTempature", agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void createSize(AgtVo agtVo) throws Exception {
		session.insert(namespace + ".createSize", agtVo);
	}
	
	//설비별 DGS 데이터 조회
	@Override
	public List<AgtBomVo> readDgsDataList_nF1(AgtBomVo agtBomVo) throws Exception {
		return session.selectList(namespace + ".readDgsDataList_nF1", agtBomVo);
	}
	
	//설비별 DGS 데이터 조회
	@Override
	public List<AgtBomVo> readDgsDataList_F2F3(AgtBomVo agtBomVo) throws Exception {
		return session.selectList(namespace + ".readDgsDataList_F2F3", agtBomVo);
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@Override
	public List<AgtBomVo> readEquipCondSeqList_nF1(AgtBomVo agtBomVo) throws Exception {
		return session.selectList(namespace + ".readEquipCondSeqList_nF1", agtBomVo);
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@Override
	public List<AgtBomVo> readEquipCondSeqList_F2F3(AgtBomVo agtBomVo) throws Exception {
		return session.selectList(namespace + ".readEquipCondSeqList_F2F3", agtBomVo);
	}
	
	//AGT 압력 삭제
	@Override
	public void deletePress(AgtVo agtVo) throws Exception{
		session.delete(namespace + ".deletePress", agtVo);
	}
	
	//AGT 치수 삭제
	@Override
	public void deleteSize(AgtVo agtVo) throws Exception{
		session.delete(namespace + ".deleteSize", agtVo);
	}
	
	//AGT 온도 삭제
	@Override
	public void deleteTemp(AgtVo agtVo) throws Exception{
		session.delete(namespace + ".deleteTemp", agtVo);
	}
	
	//AGT 시간 삭제
	@Override
	public void deleteTime(AgtVo agtVo) throws Exception{
		session.delete(namespace + ".deleteTime", agtVo);
	}
	
	//에이전트 삭제 기록----------------------------------------------------------------------------------------
	
	//AGT 시간 등록
	@Override
	public void createTimeTemp(AgtVo agtVo) throws Exception{
		session.insert(namespace + ".createTimeTemp", agtVo);
	}
	
	//AGT 압력 등록
	@Override
	public void createPressureTemp(AgtVo agtVo) throws Exception{
		session.insert(namespace + ".createPressureTemp", agtVo);
	}
	
	//AGT 온도 등록
	@Override
	public void createTempatureTemp(AgtVo agtVo) throws Exception{
		session.insert(namespace + ".createTempatureTemp", agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void createSizeTemp(AgtVo agtVo) throws Exception{
		session.insert(namespace + ".createSizeTemp", agtVo);
	}
	
	
	//에이전트 시간 읽기
	@Override
	public AgtVo readTime(AgtVo agtVo) throws Exception{
		return session.selectOne(namespace + ".readTime", agtVo);
	}
	
	//에이전트 압력 읽기
	@Override
	public AgtVo readPress(AgtVo agtVo) throws Exception{
		return session.selectOne(namespace + ".readPress", agtVo);
	}
	
	//주자재별로 초,중물이 모두 입력되었는지 확인
	@Override
	public List<AgtVo> countAgtStepCheck(AgtVo agtVo) throws Exception {
		return session.selectList(namespace + ".countAgtStepCheck", agtVo);
	}
	
	//작업지시별로 초,중,종물이 입력되었는지 확인
	@Override
	public List<AgtVo> countAgtStepCheck_F3(AgtVo agtVo) throws Exception {
		return session.selectList(namespace + ".countAgtStepCheck_F3", agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void dataLoadSize(WorkOrderVo workOrderVo) throws Exception{
		session.insert(namespace + ".dataLoadSize", workOrderVo);
	}
	
	//AGT 온도 등록
	@Override
	public void dataLoadTemp(WorkOrderVo workOrderVo) throws Exception{
		session.insert(namespace + ".dataLoadTemp", workOrderVo);
	}
	
	//AGT 압력 등록
	@Override
	public void dataLoadPress(WorkOrderVo workOrderVo) throws Exception{
		session.insert(namespace + ".dataLoadPress", workOrderVo);
	}
	
	//AGT 시간 등록
	@Override
	public void dataLoadTime(WorkOrderVo workOrderVo) throws Exception{
		session.insert(namespace + ".dataLoadTime", workOrderVo);
	}
	
	//에이젼트 온도 데이터 읽기
	@Override
	public List<AgtVo> readTemp2(AgtVo agtVo) throws Exception{
		return session.selectList(namespace + ".readTemp2", agtVo);
	}
	
	
	
	
	//---------------------------AGT 6측 관련---------------------------
	//AGT 온도 등록
	@Override
	public void agtTempatureSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtTempatureSixFloorCreate", agtSixFloorVo);
	}
	
	//AGT 시간 등록
	@Override
	public void agtTimeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtTimeSixFloorCreate", agtSixFloorVo);
	}
	
	//AGT 치수 등록
	@Override
	public void agtSizeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtSizeSixFloorCreate", agtSixFloorVo);
	}
	
	
	//AGT 온도 내역 등록
	@Override
	public void agtTempaturTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtTempaturTempCreate", agtSixFloorVo);
	}
	
	//AGT 시간 내역 등록
	@Override
	public void agtTimeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtTimeTempCreate", agtSixFloorVo);
	}
	
	//AGT 치수 내역 등록
	@Override
	public void agtSizeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.insert(namespace + ".agtSizeTempCreate", agtSixFloorVo);
	}
	
	
	//AGT 온도 내역 삭제
	@Override
	public void agtTempaturTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.delete(namespace + ".agtTempaturTempDelete", agtSixFloorVo);
	}
	
	//AGT 시간 내역 삭제
	@Override
	public void agtTimeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.delete(namespace + ".agtTimeTempDelete", agtSixFloorVo);
	}
	
	//AGT 치수 내역 삭제
	@Override
	public void agtSizeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		session.delete(namespace + ".agtSizeTempDelete", agtSixFloorVo);
	}
	
	//에이젼트 치수 데이터 존재여부 확인
	@Override
	public int agtCheckSizeSixFloor(AgtSixFloorVo agtSixFloorVo) throws Exception {
		return session.selectOne(namespace + ".agtCheckSizeSixFloor", agtSixFloorVo);
	}
	
}