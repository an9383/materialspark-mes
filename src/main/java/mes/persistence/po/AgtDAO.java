package mes.persistence.po;

import java.util.List;

import mes.domain.em.EquipTempaturCondAdm;
import mes.domain.po.AgtBomVo;
import mes.domain.po.AgtSixFloorVo;
import mes.domain.po.AgtVo;
import mes.domain.po.WorkOrderVo;

public interface AgtDAO {
	
	//에이전트 온도 ------------------------------------------------------------------------------------------
	//에이젼트 온도 데이터 읽기
	public AgtVo readTemp(AgtVo agtVo) throws Exception;
	
	//에이젼트 온도 조건 읽기
	public EquipTempaturCondAdm readTempCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception;
	
	//에이젼트 온도 데이터 수정
	public void updateTemp(AgtVo agtVo) throws Exception;

	//에이젼트 온도 데이터 존재여부 확인
	public int checkTemp(AgtVo agtVo) throws Exception;
	
	//에이전트 치수 ------------------------------------------------------------------------------------------
	//에이젼트 치수 데이터 읽기
	public AgtVo readSize(AgtVo agtVo) throws Exception;
	
	//에이젼트 치수 데이터 읽기
	public List<AgtSixFloorVo> agtSizeSixFloorList(AgtSixFloorVo agtSixFloorBomVo) throws Exception;
	
	//에이젼트 치수 조건 읽기
	public EquipTempaturCondAdm readSizeCond(EquipTempaturCondAdm equipTempaturCondAdm) throws Exception;
	
	//에이젼트 치수 데이터 수정
	public void updateSize(AgtVo agtVo) throws Exception;
	
	//에이젼트 치수 데이터 수정
	public void agtSizeSixFloorUpdate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//에이젼트 치수 추가 데이터 수정
	public void updateSizeMore(AgtVo agtVo) throws Exception;

	//에이젼트 치수 데이터 존재여부 확인
	public int checkSize(AgtVo agtVo) throws Exception;
	
	//에이젼트 ViewBom 데이터 존재여부 확인
	public int checkViewBomData(AgtBomVo agtBomVo) throws Exception;
	
	//에이젼트 ViewBom 작지 조회
	public AgtBomVo readViewBomData(AgtBomVo agtBomVo) throws Exception;
	
	//AGT 시간 등록
	public void createTime(AgtVo agtVo) throws Exception;
	
	//AGT 압력 등록
	public void createPressure(AgtVo agtVo) throws Exception;
	
	//AGT 온도 등록
	public void createTempature(AgtVo agtVo) throws Exception;
	
	//AGT 치수 등록
	public void createSize(AgtVo agtVo) throws Exception;
	
	//설비별 DGS 데이터 조회
	public List<AgtBomVo> readDgsDataList_nF1(AgtBomVo agtBomVo) throws Exception;
	
	//설비별 DGS 데이터 조회
	public List<AgtBomVo> readDgsDataList_F2F3(AgtBomVo agtBomVo) throws Exception;
	
	//설비별 DGS 제조조건 리스트 조회
	public List<AgtBomVo> readEquipCondSeqList_nF1(AgtBomVo agtBomVo) throws Exception;
	
	//설비별 DGS 제조조건 리스트 조회
	public List<AgtBomVo> readEquipCondSeqList_F2F3(AgtBomVo agtBomVo) throws Exception;
	
	//에이전트 삭제 ------------------------------------------------------------------------------------------
	
	//AGT 압력 삭제
	public void deletePress(AgtVo agtVo) throws Exception;
	
	//AGT 치수 삭제
	public void deleteSize(AgtVo agtVo) throws Exception;
	
	//AGT 온도 삭제
	public void deleteTemp(AgtVo agtVo) throws Exception;
	
	//AGT 시간 삭제
	public void deleteTime(AgtVo agtVo) throws Exception;
	
	//에이전트 삭제 기록----------------------------------------------------------------------------------------
	
	//AGT 시간 등록
	public void createTimeTemp(AgtVo agtVo) throws Exception;
	
	//AGT 압력 등록
	public void createPressureTemp(AgtVo agtVo) throws Exception;
	
	//AGT 온도 등록
	public void createTempatureTemp(AgtVo agtVo) throws Exception;
	
	//AGT 치수 등록
	public void createSizeTemp(AgtVo agtVo) throws Exception;	
	
	//에이전트 시간 읽기
	public AgtVo readTime(AgtVo agtVo) throws Exception;
	
	//에이전트 압력 읽기
	public AgtVo readPress(AgtVo agtVo) throws Exception;
	
	//--------------------------------------
	//주자재별로 초,중물이 모두 입력되었는지 확인
	public List<AgtVo> countAgtStepCheck(AgtVo agtVo) throws Exception;
	
	//작업지시별로 초,중,종물이 입력되었는지 확인
	public List<AgtVo> countAgtStepCheck_F3(AgtVo agtVo) throws Exception;
	
	//AGT 치수 등록
	public void dataLoadSize(WorkOrderVo workOrderVo) throws Exception;	
	
	//AGT 온도 등록
	public void dataLoadTemp(WorkOrderVo workOrderVo) throws Exception;
	
	//AGT 압력 등록
	public void dataLoadPress(WorkOrderVo workOrderVo) throws Exception;	
	
	//AGT 시간 등록
	public void dataLoadTime(WorkOrderVo workOrderVo) throws Exception;
	
	//에이젼트 온도 데이터 읽기
	public List<AgtVo> readTemp2(AgtVo agtVo) throws Exception;
	

	
	
	
	//---------------------------AGT 6측 관련---------------------------
	
	//AGT 온도 등록
	public void agtTempatureSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 시간 등록
	public void agtTimeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 치수 등록
	public void agtSizeSixFloorCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	
	//AGT 온도 내역 등록
	public void agtTempaturTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 시간 내역 등록
	public void agtTimeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 치수 내역 등록
	public void agtSizeTempCreate(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	
	//AGT 온도 내역 삭제
	public void agtTempaturTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 시간 내역 삭제
	public void agtTimeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//AGT 치수 내역 삭제
	public void agtSizeTempDelete(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	//에이젼트 치수 데이터 존재여부 확인
	public int agtCheckSizeSixFloor(AgtSixFloorVo agtSixFloorVo) throws Exception;
	
	
	
		
}