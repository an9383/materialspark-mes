package mes.persistence.br;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.br.RawMatrlSupplyVo;

@Repository
public class RawMatrlSupplyDAOImpl implements RawMatrlSupplyDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.br.rawMatrlSupplyMapper";	

	
	//원자재수급계획 리스트
	@Override
	public List<Map<String,String>> listAll(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listAll", rawMatrlSupplyVo);
	}

	//원자재수급계획 등록
	@Override
	public void create(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.insert(namespace+".create", rawMatrlSupplyVo);
	}
	
	//원자재수급계획 수정
	@Override
	public void update(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.update(namespace+".update", rawMatrlSupplyVo);
	}
	
	//원자재수급계획 삭제
	@Override
	public void delete(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.delete(namespace+".delete", rawMatrlSupplyVo);
	}
	
	//구매량 리스트
	@Override
	public List<Map<String,String>> listAll2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listAll2", rawMatrlSupplyVo);
	}
	
	//구매량 상세조회
	@Override
	public RawMatrlSupplyVo read(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectOne(namespace+".read", rawMatrlSupplyVo);
	}

	//구매량 등록
	@Override
	public void create2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.insert(namespace+".create2", rawMatrlSupplyVo);
	}
	
	//구매량 수정
	@Override
	public void update2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.update(namespace+".update2", rawMatrlSupplyVo);
	}
	
	//구매량 삭제
	@Override
	public void delete2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.delete(namespace+".delete2", rawMatrlSupplyVo);
	}
	
	
	//원자재수급계획 탭1번
	@Override
	public List<RawMatrlSupplyVo> listTab1(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listTab1", rawMatrlSupplyVo);
	}
	
	//원자재수급계획 탭2번
	@Override
	public List<RawMatrlSupplyVo> listTab2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listTab2", rawMatrlSupplyVo);
	}
	
	//원자재수급계획 탭3번
	@Override
	public List<Map<String,String>> listTab3(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listTab3", rawMatrlSupplyVo);
	}
	
	//원자재수급계획 자재 리스트 조회
	@Override
	public List<RawMatrlSupplyVo> selectMatrlCd(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".selectMatrlCd", rawMatrlSupplyVo);
	}
	
	//원자재 수불 명세서 리스트 조회
	@Override
	public List<RawMatrlSupplyVo> listRawMartl(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listRawMartl", rawMatrlSupplyVo);
	}
	
	//단가 입력 리스트
	@Override
	public List<Map<String,String>> listMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listMatrlPrice", rawMatrlSupplyVo);
	}
	
	//단가 상세 조회
	@Override
	public RawMatrlSupplyVo readMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectOne(namespace+".readMatrlPrice", rawMatrlSupplyVo);
	}
	
	//단가 등록
	@Override
	public void createMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.insert(namespace+".createMatrlPrice", rawMatrlSupplyVo);
	}
	
	//단가 수정
	@Override
	public void updateMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.update(namespace+".updateMatrlPrice", rawMatrlSupplyVo);
	}
	
	//단가 삭제
	@Override
	public void deleteMatrlPrice(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.delete(namespace+".deleteMatrlPrice", rawMatrlSupplyVo);
	}
	
	//수율 리스트
	@Override
	public List<Map<String,String>> listAllYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listAllYield", rawMatrlSupplyVo);
	}
	
	//수율 상세조회
	@Override
	public RawMatrlSupplyVo readYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectOne(namespace+".readYield", rawMatrlSupplyVo);
	}

	//수율 등록
	@Override
	public void createYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.insert(namespace+".createYield", rawMatrlSupplyVo);
	}
	
	//수율 수정
	@Override
	public void updateYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.update(namespace+".updateYield", rawMatrlSupplyVo);
	}
	
	//수율 삭제
	@Override
	public void deleteYield(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		session.delete(namespace+".deleteYield", rawMatrlSupplyVo);
	}
	
	
	//원자재 수급관리 실적관리
	@Override
	public List<RawMatrlSupplyVo> performanceMatrl(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".performanceMatrl", rawMatrlSupplyVo);
	}
	
	//원자재 수급관리 생산대비 사용율
	@Override
	public List<RawMatrlSupplyVo> performanceMatrl2(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".performanceMatrl2", rawMatrlSupplyVo);
	}
	
	//원자재 수급관리 원자재수불명세서 누적
	@Override
	public List<RawMatrlSupplyVo> listRawMartlSum(RawMatrlSupplyVo rawMatrlSupplyVo) throws Exception{
		return session.selectList(namespace+".listRawMartlSum", rawMatrlSupplyVo);
	}
	
}