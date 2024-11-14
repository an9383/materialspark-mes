package mes.web.tm;

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
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.po.WorkOrderService;
import mes.service.tm.InventoryAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class InventoryAdmController {
	
	
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private InventoryAdmService inventoryAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(InventoryAdmController.class);

	//재고관리정보 재고실사및조정(창고위치별) 메인
	@RequestMapping(value = "/tmsc0010", method = RequestMethod.GET)
	public String inventoryInspectAdmMain(Locale locale, Model model) throws Exception {
		logger.info("재고관리정보 재고실사및조정( 메인");
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList );
		
		return "tm/tmsc0010";
	}
	
	//재고관리정보 재고실사및조정(창고위치별) 메인
	@RequestMapping(value = "/tmsc0020", method = RequestMethod.GET)
	public String inventoryByLocationAdmMain(Locale locale, Model model) throws Exception {
		logger.info("재고관리정보 재고실사및조정(창고위치별) 메인");
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );		
		
		return "tm/tmsc0020";
	}

	//재고관리정보 재고실사및조정(품목별) 메인
	@RequestMapping(value = "/tmsc0030", method = RequestMethod.GET)
	public String inventoryByMatrlAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("재고관리정보 재고실사및조정(품목별) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("004"); // Location
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("locationCd", systemCommonCodeList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );		
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	
		
		return "tm/tmsc0030";
	}
	
	//재고관리정보 적정재고관리 메인
	@RequestMapping(value = "/tmsc0040", method = RequestMethod.GET)
	public String inventoryByPropAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("재고관리정보 적정재고관리 메인");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("048"); //적정재고 여부
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		matrlInOutWhsAdmVo.setInWhsDate(DateUtil.getToday("yyyymmdd"));
		List<MatrlInOutWhsAdmVo> propByMatrlTypeList = inventoryAdmService.tmByMatrlBaseInventoryList(matrlInOutWhsAdmVo);
		
		int a=0, b=0, c=0, d=0;
		List<MatrlInOutWhsAdmVo> nullList = new ArrayList<>();	//널
		List<MatrlInOutWhsAdmVo> zeroList = new ArrayList<>();	//0
		List<MatrlInOutWhsAdmVo> minusList = new ArrayList<>();	//비정상
		List<MatrlInOutWhsAdmVo> plusList = new ArrayList<>();	//정상
		
		for (int i=0; i<propByMatrlTypeList.size(); i++) {
			//차이가 null - (적정재고 입력필요)
			if ( null == propByMatrlTypeList.get(i).getDiffQty() ) {
				nullList.add(a, propByMatrlTypeList.get(i));
				a++;
				
			//차이가 0 - (적정재고 입력필요)
			} else if( Float.parseFloat(propByMatrlTypeList.get(i).getDiffQty()) == 0 ) {
				zeroList.add(b, propByMatrlTypeList.get(i));
				b++;
				
			//차이가 - (재고부족)
			} else if( Float.parseFloat(propByMatrlTypeList.get(i).getDiffQty()) < 0 ) {
				minusList.add(c, propByMatrlTypeList.get(i));
				c++;
				
			//차이가 + (정상)
			} else {
				plusList.add(d, propByMatrlTypeList.get(i));
				d++;
			}
		}
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("matrlDiffQty", systemCommonCodeList );	//적정재고 여부 selectBox
		model.addAttribute("nullList", nullList);
		model.addAttribute("zeroList", zeroList);
		model.addAttribute("minusList", minusList);
		model.addAttribute("plusList", plusList);
		
		return "tm/tmsc0040";
	}
	
	//재고관리정보 재고실사및조정(창고위치별) 목록조회
	@RequestMapping(value = "/tm/inventoryInspectAdjustList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmInspectAdjustList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고실사및조정(창고위치별) 목록조회 = "+matrlInOutWhsAdmVo);
		
		try {
			List<MatrlInOutWhsAdmVo> tmInspectAdjustList = inventoryAdmService.tmInspectAdjustList(matrlInOutWhsAdmVo);
			jsonData.put("data", tmInspectAdjustList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고실사및조정(창고위치별) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	
	//재고관리정보 재고실사및조정(품목별) 목록조회
	@RequestMapping(value = "/tm/inventoryByMatrlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inventoryByMatrlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고실사및조정(품목별) 목록조회");
		List<MatrlInOutWhsAdmVo> tmByMatrlTypeList = inventoryAdmService.tmByMatrlTypeList(matrlInOutWhsAdmVo);
		jsonData.put("data", tmByMatrlTypeList);
		return jsonData;
	}	
	
	//재고관리정보 적정재고관리 목록조회
	@RequestMapping(value = "/tm/inventoryByPropDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inventoryByPropDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 적정재고관리 목록조회");
		
		try {
			List<MatrlInOutWhsAdmVo> propByMatrlTypeList = inventoryAdmService.tmByMatrlBaseInventoryList(matrlInOutWhsAdmVo);
			jsonData.put("data", propByMatrlTypeList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 적정재고관리 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}

		return jsonData;
	}	
	
	//재고관리 입고량조정 수정
	@RequestMapping(value = "/tm/updateInventoryInspectQty", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateInventoryInspectQty(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리 입고량조정 수정");
		
		 try {
			 inventoryAdmService.updateInspectAdjust(matrlInOutWhsAdmVo);
			 matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
			 jsonData.put("data", matrlInOutWhsAdmVo);
			 jsonData.put("result", "ok");
		 }
		 catch (Exception e) {
			e.printStackTrace();
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("result", "실사재고 수정중 오류가 발생했습니다.<br/>데이터를 확인해 주세요.");
			jsonData.put("result", "fail");				 
		 }
		 return jsonData;		
	}
	
	//재고관리 자재보류상태 수정 
	@RequestMapping(value = "/tm/updateInventoryHoldStatus", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateInventoryHoldStatus(@RequestBody List<Map<String, Object>> matrlInOutWhsAdmList) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리 자재보류상태 수정 ");
		MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
		
		try {
				for(Map<String, Object> m : matrlInOutWhsAdmList) {
					logger.debug("matrlInOutWhsAdmVo : " + m);
					matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
					matrlInOutWhsAdmVo.setApprovalCd(m.get("approvalCd").toString());
					matrlInOutWhsAdmVo.setStatusCd(m.get("statusCd").toString());
					matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
					//logger.info("품질관리 수입검사상세수정(승인/승인취소/불량) = "+ matrlInOutWhsAdmVo);
					inventoryAdmService.updateHoldStatus(matrlInOutWhsAdmVo);
				}
				
				jsonData.put("data", matrlInOutWhsAdmVo);
				jsonData.put("result", "ok");			 
		}
		catch (Exception e) {
			
			e.printStackTrace();
			jsonData.put("data", matrlInOutWhsAdmVo);
			jsonData.put("message", "자재보류상태 수정중 오류가 발생했습니다.<br/>데이타를 확인해 주세요.");
			jsonData.put("result", "fail");				 
		}
		
		return jsonData;
	}	
	
	//재고관리정보 적정재고관리 목록조회
	@RequestMapping(value = "/tm/inventoryByPropDtlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inventoryByPropDtlDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 적정재고관리 목록 상세조회");
		
		try {
			List<MatrlInOutWhsAdmVo> propByMatrlTypeList = inventoryAdmService.tmByMatrlBaseInventoryDtlList(matrlInOutWhsAdmVo);
			jsonData.put("data", propByMatrlTypeList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 적정재고관리 목록 상세조회");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}	
	
	//재고관리정보 재고현황관리 메인
	@RequestMapping(value = "/tmsc0050", method = RequestMethod.GET)
	public String matrlInventoryByPropAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("재고관리정보 재고현황관리(자재) 메인");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	
		
		return "tm/tmsc0050";
	}	

	//재고관리정보 재고현황관리 메인
	@RequestMapping(value = "/tmsc0080", method = RequestMethod.GET)
	public String goodsInventoryByPropAdmMain(Locale locale, Model model) throws Exception {
		
		logger.info("재고관리정보 재고현황관리(제품) 메인");
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );	
		
		return "tm/tmsc0080";
	}	
	
	//재고관리정보 재고현황관리(자재)
	@RequestMapping(value = "/tm/tmByMatrlInventoryList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByMatrlInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(자재) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByMatrlInventoryList = inventoryAdmService.tmByMatrlInventoryList(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByMatrlInventoryList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(자재) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(자재) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}

	//재고관리정보 재고현황관리(자재상세)
	@RequestMapping(value = "/tm/tmByMatrlInventoryDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByMatrlInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(자재상세) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByMatrlInventoryDtlList = inventoryAdmService.tmByMatrlInventoryDtlList(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByMatrlInventoryDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(자재상세) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(자재상세) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}	
	
	//재고관리정보 재고현황관리(제품)
	@RequestMapping(value = "/tm/tmByGoodsInventoryList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsInventoryList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(제품) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByGoodsInventoryList = inventoryAdmService.tmByGoodsInventoryList(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByGoodsInventoryList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(제품) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(제품) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}
	
	//재고관리정보 재고현황관리(제품)체크
	@RequestMapping(value = "/tm/tmByGoodsInventoryListChecked", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsInventoryListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(제품) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByGoodsInventoryList = inventoryAdmService.tmByGoodsInventoryListChecked(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByGoodsInventoryList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(제품) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(제품) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}

	//재고관리정보 재고현황관리(제품상세)
	@RequestMapping(value = "/tm/tmByGoodsInventoryDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsInventoryDtlList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(제품상세) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList = inventoryAdmService.tmByGoodsInventoryDtlList(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByGoodsInventoryDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(제품상세) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(제품상세) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}
	
	//재고관리정보 재고현황관리(제품상세) 체크
	@RequestMapping(value = "/tm/tmByGoodsInventoryDtlListChecked", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> tmByGoodsInventoryDtlListChecked(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(제품상세) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> tmByGoodsInventoryDtlList = inventoryAdmService.tmByGoodsInventoryDtlListChecked(matrlInOutWhsAdmVo);
			jsonData.put("data", tmByGoodsInventoryDtlList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(제품상세) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(제품상세) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}
	
	
	//영업관리 년도별 수주집계표
	@RequestMapping(value = "/tmsc0090", method = RequestMethod.GET)
	public String tmsc0090(Locale locale, Model model) throws Exception {
		
		logger.info("자재 생산팀재고");		
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("007"); // 자재재질
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("qutyCd", systemCommonCodeList );
		
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6) );
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd") );
		
		return "tm/tmsc0090";
	}
	
	//재고관리정보 재고현황관리(제품상세)
	@RequestMapping(value = "/tm/matrlOutpoutDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlOutpoutDataList(MatrlInOutWhsAdmVo matrlInOutWhsAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재고관리정보 재고현황관리(제품상세) 목록조회");
		try {
			List<MatrlInOutWhsAdmVo> matrlOutpoutDataList = matrlInOutWhsAdmService.listInWhsAll(matrlInOutWhsAdmVo);
			jsonData.put("data", matrlOutpoutDataList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("재고관리정보 재고현황관리(제품상세) 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "재고관리정보 재고현황관리(제품상세) 목록 조회중 오류가 발생했습니다.<br/> 재고정보를 확인해 주세요.");
			jsonData.put("result", "fail");			 
		}			 
		return jsonData;	
	}
	
	@RequestMapping(value = "/tmsc0100", method = RequestMethod.GET)
	public String tmsc0100(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 제품검사 대기현황");
		//SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		//systemCommonCodeVo.setBaseGroupCd("034"); // 작지상태
		//List<SystemCommonCodeVo>  workStatusCd = systemCommonCodeService.listAll(systemCommonCodeVo);
		//systemCommonCodeVo.setBaseGroupCd("046"); // Sample수량
		//List<SystemCommonCodeVo>  sampleCount = systemCommonCodeService.listAll(systemCommonCodeVo);
		//model.addAttribute("workStatusCd", workStatusCd );
		//model.addAttribute("sampleCount", sampleCount );
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		
		return "tm/tmsc0100";
	}
	
	//검사대기 작지목록 조회
	@RequestMapping(value = "qm/standByInspectionWorkOrdList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> standByInspection(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("검사대기 작지목록 조회");
		try {
			List<WorkOrderVo> WorkOrderVoList = workOrderService.standByInspectionWorkOrdList(workOrderVo);
			jsonData.put("data", WorkOrderVoList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("검사대기 작지목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
		
		
}