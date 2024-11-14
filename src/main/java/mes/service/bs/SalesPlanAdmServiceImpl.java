package mes.service.bs;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.bs.SalesPlanAdmVo;
import mes.persistence.bs.SalesPlanAdmDAO;

@Service
public class SalesPlanAdmServiceImpl implements SalesPlanAdmService {

	@Inject
	private SalesPlanAdmDAO dao;
	
	//판매계획 목록조회
	@Override
	public List<SalesPlanAdmVo> listAll(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.listAll(salesPlanAdmVo);
	}	
	
	//판매계획 상세조회
	@Override
	public List<SalesPlanAdmVo> read(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.read(salesPlanAdmVo);
	}
	
	//판매계획 분기별조회
	@Override
	public List<SalesPlanAdmVo> quarterList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.quarterList(salesPlanAdmVo);
	}
	
	//판매계획 월별 조회
	@Override
	public List<SalesPlanAdmVo> monthList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.monthList(salesPlanAdmVo);
	}
	
	//판매계획 전체 조회
	@Override
	public List<SalesPlanAdmVo> allSalesList(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.allSalesList(salesPlanAdmVo);
	}
	
	//판매계획 등록
	@Override
	public void create(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		dao.create(salesPlanAdmVo);
	}
	
	//판매계획 수정
	@Override
	public void update(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		dao.update(salesPlanAdmVo);
	}
	
	//판매계획 삭제
	@Override
	public void delete(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		dao.delete(salesPlanAdmVo);
	}
	
	//판매계획 분기별 조회
	@Override
	public List<SalesPlanAdmVo> quarterListNew(SalesPlanAdmVo salesPlanAdmVo) throws Exception{
		return dao.quarterListNew(salesPlanAdmVo);
	}
	
}