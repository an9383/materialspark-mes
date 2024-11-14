package mes.web.bs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bs.SalesPlanAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bs.PurchaseOrderAdmService;
import mes.service.bs.SalesPlanAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class SalesPlanAdmController {
	
	@Inject
	private PurchaseOrderAdmService purchaseOrderAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;	
	@Inject
	private SalesPlanAdmService salesPlanAdmService;
	
	private static final Logger logger = LoggerFactory.getLogger(SalesPlanAdmController.class);

	//영업관리 판매계획등록
	@RequestMapping(value = "/bssc0080", method = RequestMethod.GET)
	public String salesPlanMain(Locale locale, Model model) throws Exception {
		
		logger.info("영업관리 판매계획등록");

		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );			

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("080"); // 기종코드
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongCd", systemCommonCodeList );		

		return "bs/bssc0080";
	}
	
	//영업관리 판매계획등록 목록조회
	@RequestMapping(value = "/bs/salesPlanAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> salesPlanDataList(SalesPlanAdmVo salesPlanAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		SalesPlanAdmVo salesPlanAdmVoNew = new SalesPlanAdmVo();
		logger.info("영업관리 판매계획등록 목록조회");		
		try {
			if(salesPlanAdmVo.getDealCorpCd() != null && !"".equals(salesPlanAdmVo.getDealCorpCd())) {
				List<SalesPlanAdmVo> dataList = salesPlanAdmService.read(salesPlanAdmVo);			
				if(dataList.size() == 0) {				
					systemCommonCodeVo.setBaseGroupCd("080"); // 기종코드
					
					List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
					for(SystemCommonCodeVo m : systemCommonCodeList) {
						salesPlanAdmVoNew = new SalesPlanAdmVo();
						salesPlanAdmVoNew.setDealCorpCd(salesPlanAdmVo.getDealCorpCd());
						salesPlanAdmVoNew.setDealCorpNm(salesPlanAdmVo.getDealCorpNm());
						
						salesPlanAdmVoNew.setPlanYear(salesPlanAdmVo.getPlanYear());
						
						salesPlanAdmVoNew.setGijongCd(m.getBaseCd());
						salesPlanAdmVoNew.setGijongNm(m.getBaseCdNm());
						
						salesPlanAdmVoNew.setGubun("001"); // 없음
						dataList.add(salesPlanAdmVoNew);
					}
				}
				jsonData.put("data", dataList);
				jsonData.put("result", "ok");
			} else {
				List<SalesPlanAdmVo> dataList = new ArrayList<SalesPlanAdmVo>();
				jsonData.put("data", dataList);
				jsonData.put("result", "ok");
			}
		
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획등록 목록조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//영업관리 판매계획 분기별조회
	@RequestMapping(value = "/bs/salesPlanAdmQuarterDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> salesPlanAdmQuarterDataList(SalesPlanAdmVo salesPlanAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 판매계획 분기별조회");		
		try {
			List<SalesPlanAdmVo> dataList = salesPlanAdmService.quarterList(salesPlanAdmVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획 분기별조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//영업관리 판매계획 월별조회
	@RequestMapping(value = "/bs/salesPlanAdmMonthDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> salesPlanAdmMonthDataList(SalesPlanAdmVo salesPlanAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 판매계획 월별조회");		
		try {
			List<SalesPlanAdmVo> dataList = salesPlanAdmService.monthList(salesPlanAdmVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획 월별조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//영업관리 판매계획 전체조회
	@RequestMapping(value = "/bs/allSalesPlanAdmDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> allSalesPlanAdmDataList(SalesPlanAdmVo salesPlanAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("영업관리 판매계획 전체조회");		
		try {
			List<SalesPlanAdmVo> dataList = salesPlanAdmService.allSalesList(salesPlanAdmVo);
			jsonData.put("data", dataList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획 전체조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//영업관리 판매계획등록 등록
	@RequestMapping(value = "/bs/salesPlanAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> salesPlanAdmCreate(@RequestBody List<Map<String, Object>> list) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();	
		SalesPlanAdmVo salesPlanAdmVo = new SalesPlanAdmVo();
		logger.info("영업관리 판매계획 등록");		
		try {
			salesPlanAdmVo.setDealCorpCd(list.get(0).get("dealCorpCd").toString());
			salesPlanAdmVo.setPlanYear(list.get(0).get("planYear").toString());
			salesPlanAdmService.delete(salesPlanAdmVo);
			for(Map<String, Object> m : list) {
				salesPlanAdmVo = new SalesPlanAdmVo();
				salesPlanAdmVo.setRegId(Utils.getUserId());
				salesPlanAdmVo.setDealCorpCd(m.get("dealCorpCd").toString());
				salesPlanAdmVo.setPlanYear(m.get("planYear").toString());
				salesPlanAdmVo.setGijongCd(m.get("gijongCd").toString());
				salesPlanAdmVo.setJanCnt(Long.parseLong(m.get("janCnt").toString()));
				salesPlanAdmVo.setJanCost(Long.parseLong(m.get("janCost").toString()));
				salesPlanAdmVo.setFebCnt(Long.parseLong(m.get("febCnt").toString())); 
				salesPlanAdmVo.setFebCost(Long.parseLong(m.get("febCost").toString()));
				salesPlanAdmVo.setMarCnt(Long.parseLong(m.get("marCnt").toString())); 
				salesPlanAdmVo.setMarCost(Long.parseLong(m.get("marCost").toString()));
				salesPlanAdmVo.setAprCnt(Long.parseLong(m.get("aprCnt").toString())); 
				salesPlanAdmVo.setAprCost(Long.parseLong(m.get("aprCost").toString()));
				salesPlanAdmVo.setMayCnt(Long.parseLong(m.get("mayCnt").toString())); 
				salesPlanAdmVo.setMayCost(Long.parseLong(m.get("mayCost").toString()));
				salesPlanAdmVo.setJunCnt(Long.parseLong(m.get("junCnt").toString())); 
				salesPlanAdmVo.setJunCost(Long.parseLong(m.get("junCost").toString()));
				salesPlanAdmVo.setJulCnt(Long.parseLong(m.get("julCnt").toString())); 
				salesPlanAdmVo.setJulCost(Long.parseLong(m.get("julCost").toString()));
				salesPlanAdmVo.setAugCnt(Long.parseLong(m.get("augCnt").toString())); 
				salesPlanAdmVo.setAugCost(Long.parseLong(m.get("augCost").toString()));
				salesPlanAdmVo.setSepCnt(Long.parseLong(m.get("sepCnt").toString())); 
				salesPlanAdmVo.setSepCost(Long.parseLong(m.get("sepCost").toString()));
				salesPlanAdmVo.setOctCnt(Long.parseLong(m.get("octCnt").toString())); 
				salesPlanAdmVo.setOctCost(Long.parseLong(m.get("octCost").toString()));
				salesPlanAdmVo.setNovCnt(Long.parseLong(m.get("novCnt").toString())); 
				salesPlanAdmVo.setNovCost(Long.parseLong(m.get("novCost").toString()));
				salesPlanAdmVo.setDecCnt(Long.parseLong(m.get("decCnt").toString())); 
				salesPlanAdmVo.setDecCost(Long.parseLong(m.get("decCost").toString()));
								
				salesPlanAdmService.create(salesPlanAdmVo);					
			}
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("영업관리 판매계획 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}


}
