
package mes.service.po;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.AgtBomVo;
import mes.domain.po.AgtSixFloorVo;
import mes.domain.po.AgtVo;
import mes.domain.po.WorkOrderVo;
import mes.persistence.po.AgtDAO;


@Service
public class AgtServiceImpl implements AgtService {
	@Inject
	private AgtDAO dao;
	
	//에이전트 온도 ------------------------------------------------------------------------------------------
	//에이젼트 온도 데이터 읽기
	@Override
	public AgtVo readTemp(AgtVo agtVo) throws Exception {
		return dao.readTemp(agtVo);
	}
	
	//에이젼트 온도 조건 읽기
	@Override
	public EquipTempaturCondAdm readTempCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception {
		return dao.readTempCond(equipTempaturCondAdm);
	}
	
	//에이젼트 온도 데이터 수정
	@Override
	public void updateTemp(AgtVo agtVo) throws Exception {
		dao.updateTemp(agtVo);
	}
	
	//에이젼트 온도 데이터 존재여부 확인
	@Override
	public int checkTemp(AgtVo agtVo) throws Exception {
		return dao.checkTemp(agtVo);
	}
	
	//에이전트 치수 ------------------------------------------------------------------------------------------
	//에이젼트 치수 데이터 읽기
	@Override
	public AgtVo readSize(AgtVo agtVo) throws Exception {
		return dao.readSize(agtVo);
	}
	
	//에이젼트 치수 데이터 읽기
	@Override
	public List<AgtSixFloorVo> agtSizeSixFloorList(AgtSixFloorVo agtSixFloorVo) throws Exception {
		return dao.agtSizeSixFloorList(agtSixFloorVo);
	}
	
	//에이젼트 치수 조건 읽기
	@Override
	public EquipTempaturCondAdm readSizeCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception {
		return dao.readSizeCond(equipTempaturCondAdm);
	}
	
	//에이젼트 치수 데이터 수정
	@Override
	public void updateSize(AgtVo agtVo) throws Exception {
		dao.updateSize(agtVo);
	}
	
	//에이젼트 치수 데이터 수정
	@Override
	public void agtSizeSixFloorUpdate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtSizeSixFloorUpdate(agtSixFloorVo);
	}
	
	//에이젼트 치수 추가 데이터 수정
	@Override
	public void updateSizeMore(AgtVo agtVo) throws Exception {
		dao.updateSizeMore(agtVo);
	}

	//에이젼트 치수 데이터 존재여부 확인
	@Override
	public int checkSize(AgtVo agtVo) throws Exception {
		return dao.checkSize(agtVo);
	}
	
	//에이젼트 ViewBom 데이터 존재여부 확인
	@Override
	public int checkViewBomData(AgtBomVo agtBomVo) throws Exception {
		return dao.checkViewBomData(agtBomVo);
	}
	
	//에이젼트 ViewBom 작지 조회
	@Override
	public AgtBomVo readViewBomData(AgtBomVo agtBomVo) throws Exception {
		return dao.readViewBomData(agtBomVo);
	}
	
	//AGT 시간 등록
	@Override
	public void createTime(AgtVo agtVo) throws Exception {
		dao.createTime(agtVo);
	}
	
	//AGT 압력 등록
	@Override
	public void createPressure(AgtVo agtVo) throws Exception {
		dao.createPressure(agtVo);
	}
	
	//AGT 온도 등록
	@Override
	public void createTempature(AgtVo agtVo) throws Exception {
		dao.createTempature(agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void createSize(AgtVo agtVo) throws Exception {
		dao.createSize(agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public List<AgtBomVo> readDgsDataList_nF1(AgtBomVo agtBomVo) throws Exception {
		return dao.readDgsDataList_nF1(agtBomVo);
	}
	
	//AGT 치수 등록
	@Override
	public List<AgtBomVo> readDgsDataList_F2F3(AgtBomVo agtBomVo) throws Exception {
		return dao.readDgsDataList_F2F3(agtBomVo);
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@Override
	public List<AgtBomVo> readEquipCondSeqList_nF1(AgtBomVo agtBomVo) throws Exception {
		return dao.readEquipCondSeqList_nF1(agtBomVo);
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@Override
	public List<AgtBomVo> readEquipCondSeqList_F2F3(AgtBomVo agtBomVo) throws Exception {
		return dao.readEquipCondSeqList_F2F3(agtBomVo);
	}
	
	//AGT 압력 삭제
	@Override
	public void deletePress(AgtVo agtVo) throws Exception{
		dao.deletePress(agtVo);
	}

	//AGT 치수 삭제
	@Override
	public void deleteSize(AgtVo agtVo) throws Exception{
		dao.deleteSize(agtVo);
	}
	
	//AGT 온도 삭제
	@Override
	public void deleteTemp(AgtVo agtVo) throws Exception{
		dao.deleteTemp(agtVo);
	}
	
	//AGT 시간 삭제
	@Override
	public void deleteTime(AgtVo agtVo) throws Exception{
		dao.deleteTime(agtVo);
	}
	
	//에이전트 삭제 기록----------------------------------------------------------------------------------------
	
	//AGT 시간 등록
	@Override
	public void createTimeTemp(AgtVo agtVo) throws Exception{
		dao.createTimeTemp(agtVo);
	}
	
	//AGT 압력 등록
	@Override
	public void createPressureTemp(AgtVo agtVo) throws Exception{
		dao.createPressureTemp(agtVo);
	}
	
	//AGT 온도 등록
	@Override
	public void createTempatureTemp(AgtVo agtVo) throws Exception{
		dao.createTempatureTemp(agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void createSizeTemp(AgtVo agtVo) throws Exception{
		dao.createSizeTemp(agtVo);
	}
	
	
	//에이전트 시간 읽기
	@Override
	public AgtVo readTime(AgtVo agtVo) throws Exception{
		return dao.readTime(agtVo);
	}
	
	//에이전트 압력 읽기
	@Override
	public AgtVo readPress(AgtVo agtVo) throws Exception{
		return dao.readPress(agtVo);
	}
	
	//주자재별로 초,중물이 모두 입력되었는지 확인
	@Override
	public List<AgtVo> countAgtStepCheck(AgtVo agtVo) throws Exception {
		return dao.countAgtStepCheck(agtVo);
	}
	
	//작업지시별로 초,중,종물이 입력되었는지 확인
	@Override
	public List<AgtVo> countAgtStepCheck_F3(AgtVo agtVo) throws Exception {
		return dao.countAgtStepCheck_F3(agtVo);
	}
	
	//AGT 치수 등록
	@Override
	public void dataLoadSize(WorkOrderVo workOrderVo) throws Exception{
		dao.dataLoadSize(workOrderVo);
	}
	
	//AGT 온도 등록
	@Override
	public void dataLoadTemp(WorkOrderVo workOrderVo) throws Exception{
		dao.dataLoadTemp(workOrderVo);
	}
	
	//AGT 압력 등록
	@Override
	public void dataLoadPress(WorkOrderVo workOrderVo) throws Exception{
		dao.dataLoadPress(workOrderVo);
	}
	
	//AGT 시간 등록
	@Override
	public void dataLoadTime(WorkOrderVo workOrderVo) throws Exception{
		dao.dataLoadTime(workOrderVo);
	}
	
	//에이젼트 온도 데이터 읽기
	@Override
	public List<AgtVo> readTemp2(AgtVo agtVo) throws Exception{
		return dao.readTemp2(agtVo);
	}
	
	
	
	//---------------------------AGT 6측 관련---------------------------
	
	//AGT 온도 등록
	@Override
	public void agtTempatureSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTempatureSixFloorCreate(agtSixFloorVo);
	}
	
	//AGT 시간 등록
	@Override
	public void agtTimeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTimeSixFloorCreate(agtSixFloorVo);
	}
	
	//AGT 치수 등록
	@Override
	public void agtSizeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtSizeSixFloorCreate(agtSixFloorVo);
	}
	
	
	//AGT 온도 내역 등록
	@Override
	public void agtTempaturTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTempaturTempCreate(agtSixFloorVo);
	}
	
	//AGT 시간 내역 등록
	@Override
	public void agtTimeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTimeTempCreate(agtSixFloorVo);
	}
	
	//AGT 치수 내역 등록
	@Override
	public void agtSizeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtSizeTempCreate(agtSixFloorVo);
	}
	
	
	//AGT 온도 내역 삭제
	@Override
	public void agtTempaturTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTempaturTempDelete(agtSixFloorVo);
	}
	
	//AGT 시간 내역 삭제
	@Override
	public void agtTimeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtTimeTempDelete(agtSixFloorVo);
	}
	
	//AGT 치수 내역 삭제
	@Override
	public void agtSizeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception {
		dao.agtSizeTempDelete(agtSixFloorVo);
	}
	
	//에이젼트 치수 데이터 존재여부 확인
	@Override
	public int agtCheckSizeSixFloor(AgtSixFloorVo agtSixFloorVo) throws Exception {
		return dao.agtCheckSizeSixFloor(agtSixFloorVo);
	}
}