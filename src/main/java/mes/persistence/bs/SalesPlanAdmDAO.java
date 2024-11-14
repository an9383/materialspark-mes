package mes.persistence.bs;

import java.util.List;

import mes.domain.bs.SalesPlanAdmVo;



public interface SalesPlanAdmDAO {

	//판매계획 목록조회
	public List<SalesPlanAdmVo> listAll(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 상세조회
	public List<SalesPlanAdmVo> read(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 분기별 조회
	public List<SalesPlanAdmVo> quarterList(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 월별 조회
	public List<SalesPlanAdmVo> monthList(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 전체 조회
	public List<SalesPlanAdmVo> allSalesList(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 등록
	public void create(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 수정
	public void update(SalesPlanAdmVo salesPlanAdmVo) throws Exception;	
	
	//판매계획 삭제
	public void delete(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	//판매계획 분기별 조회
	public List<SalesPlanAdmVo> quarterListNew(SalesPlanAdmVo salesPlanAdmVo) throws Exception;
	
	

	
	
}