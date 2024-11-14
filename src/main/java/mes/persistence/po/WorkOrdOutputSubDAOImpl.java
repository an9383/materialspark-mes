package mes.persistence.po;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.qm.GoodsFaultyAdmVo;

@Repository
public class WorkOrdOutputSubDAOImpl implements WorkOrdOutputSubDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.po.workOrdOutputSubMapper";
		
	//전체목록 조회
	@Override
	public List<WorkOrdOutputSubVo> workOrdOutputSubList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".workOrdOutputSubList",workOrdOutputSubVo);
	}
	
	//상세목록 조회
	@Override
	public WorkOrdOutputSubVo workOrdOutputSubRead(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".workOrdOutputSubRead",workOrdOutputSubVo);
	}
	
	//시퀀스 불러오기
	@Override
	public String workOrdOutputSubSeq(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".workOrdOutputSubSeq",workOrdOutputSubVo);
	}

	//수정
	@Override
	public void workOrdOutputSubUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".workOrdOutputSubUpdate",workOrdOutputSubVo);
	}
	
	//트레이 외관 검사 관련  생산 실적 수정
	@Override
	public void workOrdOutputSubTrayFaultyRelatedUpdate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".workOrdOutputSubTrayFaultyRelatedUpdate",workOrdOutputSubVo);
	}
	
	//workOrdLotNo 등록되어 있는지 확인
	@Override
	public List<WorkOrdOutputSubVo> checkWorkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".checkWorkOrdLotNo", workOrdOutputSubVo);
	}
	
	//생산LotNo(workOrdLotNo) 몸통 채번
	@Override
	public String createWorkOrdLotNoBody(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".createWorkOrdLotNoBody", workOrdOutputSubVo);
	}
	
	//생산LotNo(workOrdLotNo) 끝 숫자 채번
	@Override
	public int createWorkOrdLotNoCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".createWorkOrdLotNoCount", workOrdOutputSubVo);
	}
	
	//생산전표번호(ordLotNo) 몸통 채번
	@Override
	public String createOrdLotNoBody(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".createOrdLotNoBody", workOrdOutputSubVo);
	}
	
	//생산전표번호(ordLotNo) 숫자 채번
	@Override
	public int createOrdLotNoCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".createOrdLotNoCount", workOrdOutputSubVo);
	}
	
	//생산전표번호(ordLotNo) 끝 숫자 채번
	@Override
	public int createOrdLotNoLastCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".createOrdLotNoLastCount", workOrdOutputSubVo);
	}
	
	//해당 주야&전표일자&작업자로 등록된 작지LotNo가 있는지 확인
	@Override
	public List<WorkOrdOutputSubVo> checkOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".checkOrdLotNo",workOrdOutputSubVo);
	}
	
	//ordLotNo 채번
	//@Override
	//public String createOrdLotNo(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
	//	return session.selectOne(namespace + ".createOrdLotNo",workOrdOutputSubVo);
	//}
	
	//생성
	@Override
	public void workOrdOutputSubCreate(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.insert(namespace + ".workOrdOutputSubCreate",workOrdOutputSubVo);
	}
	
	//temp생성
	@Override
	public void workOrdOutputSubCreateTemp(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.insert(namespace + ".workOrdOutputSubCreateTemp",workOrdOutputSubVo);
	}
	
	//작지원장 수량업데이트
	@Override
	public void updateMainWorkOrdOutput(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".updateMainWorkOrdOutput",workOrdOutputSubVo);
	}
	
	//삭제
	@Override
	public void workOrdOutputSubDelete(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.delete(namespace + ".workOrdOutputSubDelete",workOrdOutputSubVo);
	}
	
	//작업지시 인쇄시 대상 ordLotNO 목록 조회
	@Override
	public List<WorkOrdOutputSubVo> workOrdExcelDownOrdLotNoList(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".workOrdExcelDownOrdLotNoList",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 작지인쇄 목록
	@Override
	public List<WorkOrdOutputSubVo> workOrdExcelDownOrdLotNoList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".workOrdExcelDownOrdLotNoList_F3",workOrdOutputSubVo);
	}
	
	//작지 완료시 각 주자재별로 생산실적이 최소 1개이상 입력되어있는지 체크
	@Override
	public List<WorkOrdOutputSubVo> checkLotNoOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".checkLotNoOutputSub",workOrdOutputSubVo);
	}
	
	//작지 진행취소 시 생산실적이 입력되어있는지 확인
	@Override
	public int checkWorkOrdOutputSub(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".checkWorkOrdOutputSub", workOrdOutputSubVo);
	}
	
	//선택 생산실적전표가 해당 작지의 가장 최근등록한 생산실적전표인지 확인
	@Override
	public int checkWorkOrdOutputSubCount(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".checkWorkOrdOutputSubCount", workOrdOutputSubVo);
	}
	
	//작지&주재료로 등록된 생산실적 개수
	@Override
	public int countLotNoOutput(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".countLotNoOutput", workOrdOutputSubVo);
	}
	
	//제품 라벨발행 입력수량 임시저장
	@Override
	public void updateWorkOrdAppearCnt(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".updateWorkOrdAppearCnt", workOrdOutputSubVo);
	}
	
	//생산실적 포장 완료상태로 변경
	@Override
	public void updateWorkOrdPublish(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".updateWorkOrdPublish", workOrdOutputSubVo);
	}
	
	//해당 생산LotNo 들 중 포장된 생산실적 외관검사 종료시점으로 복구
	@Override
	public void updateWorkOrdLotNoUnpack(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".updateWorkOrdLotNoUnpack", workOrdOutputSubVo);
	}
	
	
	//MTP2동 비전불량수량 시퀀스 채번
	@Override
	public String visionFaultyAdmSeq (WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".visionFaultyAdmSeq", workOrdOutputSubVo);
	}
	
	//MTP2동 생산 비전불량ADM 목록
	@Override
	public List<WorkOrdOutputSubVo> readVisionFaultyAdmList_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".readVisionFaultyAdmList_F2",workOrdOutputSubVo);
	}
	
	//MTP2동 생산 비전불량ADM 조회
	@Override
	public WorkOrdOutputSubVo readVisionFaultyAdm_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".readVisionFaultyAdm_F2",workOrdOutputSubVo);
	}
	
	//MTP2동 생산 비전불량ADM 등록
	@Override
	public void visionFaultyAdmInsert_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.insert(namespace + ".visionFaultyAdmInsert_F2",workOrdOutputSubVo);
	}
	
	//MTP2동 생산 비전불량ADM 수정
	@Override
	public void visionFaultyAdmUpdate_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".visionFaultyAdmUpdate_F2",workOrdOutputSubVo);
	}
	
	//MTP2동 생산 비전불량ADM 삭제
	@Override
	public void visionFaultyAdmDelete_F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.delete(namespace + ".visionFaultyAdmDelete_F2",workOrdOutputSubVo);
	}
	
	
	
	//솔브레인SLD 엣지검사 목록
	@Override
	public List<WorkOrdOutputSubVo> edgeCheckList_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".edgeCheckList_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 엣지검사 등록
	@Override
	public void edgeCheckInsert_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.insert(namespace + ".edgeCheckInsert_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 엣지검사 수정
	@Override
	public void edgeCheckUpdate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".edgeCheckUpdate_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 엣지검사 코드화 삭제
	@Override
	public void edgeCheckGoodsFaultyAdmCodeDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.delete(namespace + ".edgeCheckGoodsFaultyAdmCodeDelete_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 외관검사 전표번호 등록
	@Override
	public void appearCheckInsert_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.insert(namespace + ".appearCheckInsert_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 외관검사 전표번호  수정
	@Override
	public void appearCheckUpdate_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".appearCheckUpdate_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 외관검사 & 엣지검사 전표번호 삭제
	@Override
	public void appearAndEdgeCheckDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.delete(namespace + ".appearAndEdgeCheckDelete_F3",workOrdOutputSubVo);
	}
	
	//솔브레인SLD 외관검사 코드화 삭제
	@Override
	public void appearCheckGoodsFaultyAdmCodeDelete_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.delete(namespace + ".appearCheckGoodsFaultyAdmCodeDelete_F3",workOrdOutputSubVo);
	}
	
	//Seq 순서대로 삭제할 수 있게 검사
	@Override
	public WorkOrdOutputSubVo appearCheckSeqCount_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".appearCheckSeqCount_F3", workOrdOutputSubVo);
	}
	
	//삭제할 전표번호의 생산LotNo이후 채번된 생산LotNo가 존재하는지 확인
	@Override
	public List<WorkOrdOutputSubVo> appearCheckWorkOrdLotNo_F3(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectList(namespace + ".appearCheckWorkOrdLotNo_F3", workOrdOutputSubVo);
	}
	
	//엑셀 작지 외관검사 코드화 조회
	@Override
	public List<GoodsFaultyAdmVo> excelGoodsFaultyAdmCodeList(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return session.selectList(namespace + ".excelGoodsFaultyAdmCodeList", goodsFaultyAdmVo);
	}
	
	//불량항목별 합계
	@Override
	public GoodsFaultyAdmVo sumFaultyType(GoodsFaultyAdmVo goodsFaultyAdmVo) throws Exception{
		return session.selectOne(namespace + ".sumFaultyType", goodsFaultyAdmVo);
	}
	
	//생산실적 등록자 업데이트
	@Override
	public void registrantChange(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		session.update(namespace + ".registrantChange",workOrdOutputSubVo);
	}
	
	//등록자(생산작업자) 변경(수정)할 때 해당 생산전표번호가 바뀌었는지 확인
	@Override
	public WorkOrdOutputSubVo checkChangeOrdLotNo_F1F2(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception{
		return session.selectOne(namespace + ".checkChangeOrdLotNo_F1F2", workOrdOutputSubVo);
	}
}