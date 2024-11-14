package mes.service.br;

import java.util.List;
import java.util.Map;

import mes.domain.br.RawMatrlSupplyVo;

public interface RawMatrlSupplyService {
	
	//원자재수급계획 리스트
	public List<Map<String,String>> listAll(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;

	//원자재수급계획 등록
	public void create(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 수정
	public void update(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 삭제
	public void delete(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//구매량 리스트
	public List<Map<String,String>> listAll2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//구매량 상세조회
	public RawMatrlSupplyVo read(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;

	//구매량 등록
	public void create2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//구매량 수정
	public void update2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//구매량 삭제
	public void delete2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 탭1번
	public List<RawMatrlSupplyVo> listTab1(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 탭2번
	public List<RawMatrlSupplyVo> listTab2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 탭3번
	public List<Map<String,String>> listTab3(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재수급계획 자재 리스트 조회
	public List<RawMatrlSupplyVo> selectMatrlCd(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재 수불 명세서 리스트 조회
	public List<RawMatrlSupplyVo> listRawMartl(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//단가 입력 리스트
	public List<Map<String,String>> listMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//단가 상세 조회
	public RawMatrlSupplyVo readMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//단가 등록
	public void createMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//단가 수정
	public void updateMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//단가 삭제
	public void deleteMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//수율 리스트
	public List<Map<String,String>> listAllYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//수율 상세조회
	public RawMatrlSupplyVo readYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;

	//수율 등록
	public void createYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//수율 수정
	public void updateYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//수율 삭제
	public void deleteYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재 수급관리 실적관리
	public List<RawMatrlSupplyVo> performanceMatrl(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;	
	
	//원자재 수급관리 생산대비 사용율
	public List<RawMatrlSupplyVo> performanceMatrl2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;
	
	//원자재 수급관리 원자재수불명세서 누적
	public List<RawMatrlSupplyVo> listRawMartlSum(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception;	

	
}