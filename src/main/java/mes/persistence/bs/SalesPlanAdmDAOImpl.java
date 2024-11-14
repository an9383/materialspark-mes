package mes.persistence.bs;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bs.SalesPlanAdmVo;


@Repository
public class SalesPlanAdmDAOImpl implements SalesPlanAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bs.salesPlanAdmMapper";
	
	//판매계획 목록조회
	@Override
	public List<SalesPlanAdmVo> listAll(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".listAll", salesPlanAdmVo);
	}
	
	//판매계획 상세조회
	@Override
	public List<SalesPlanAdmVo> read(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".read", salesPlanAdmVo);
	}
	
	//판매계획 분기별 조회
	@Override
	public List<SalesPlanAdmVo> quarterList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".quarterList", salesPlanAdmVo);
	}
	
	//판매계획 월별 조회
	@Override
	public List<SalesPlanAdmVo> monthList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".monthList", salesPlanAdmVo);
	}
	
	//판매계획 전체 조회
	@Override
	public List<SalesPlanAdmVo> allSalesList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".allSalesList", salesPlanAdmVo);
	}
	
	//판매계획 등록
	@Override
	public void create(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		session.insert(namespace+".create", salesPlanAdmVo);
	}
	
	//판매계획 수정
	@Override
	public void update(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		session.update(namespace+".update", salesPlanAdmVo);
	}
	
	//판매계획 삭제
	@Override
	public void delete(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		session.delete(namespace+".delete", salesPlanAdmVo);
	}
	
	//판매계획 분기별 조회
	@Override
	public List<SalesPlanAdmVo> quarterListNew(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return session.selectList(namespace+".quarterListNew", salesPlanAdmVo);
	}
	
	
}