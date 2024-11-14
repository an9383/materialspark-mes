package mes.web.qm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.qm.ShipInspectVo;
import mes.domain.qm.ShipIspListVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.InspectInfoAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.GoodsPackService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.qm.ShipInspectService;
import mes.service.qm.ShipIspListService;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class ShipIspListController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private ShipIspListService shipIspListService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	
	@Value("${factoryCode}") private String factoryCode;
	
	int appearFaultyCnt = 0;
	private static final Logger logger = LoggerFactory.getLogger(ShipIspListController.class);	
	

	//품질관리 - 출하검사 현황 / 출하검사 집계표
	@RequestMapping(value = "/qmsc0190", method = RequestMethod.GET)
	public String qmsc0190(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 출하검사 현황 / 출하검사 집계표");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("066"); // 검사상태(수입검사 합격여부)
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspStatus", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("013"); // 부서
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("departmentCode", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("121"); // 이상발생부서
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("abnormalPrcssCode", systemCommonCodeList);

		
		return "qm/qmsc0190";
	}
	
	//품질관리 - 출하검사 현황 / 출하검사 집계표
	@RequestMapping(value = "/qmsc0200", method = RequestMethod.GET)
	public String qmsc0200(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 출하검사 현황 / 출하검사 집계표");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("066"); // 검사상태(수입검사 합격여부)
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspStatus", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("083"); // 투입자재 불량여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faultyStatusCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("085"); // pageCount
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("pageCount", systemCommonCodeList);
		
		return "qm/qmsc0200";
	}

	//품질관리 - 출하검사집계표
	@RequestMapping(value = "/qmsc0220", method = RequestMethod.GET)
	public String qmsc0220(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 - 출하검사집계표");
		String todate = DateUtil.getToday("yyyy-mm-dd");
		if("003".equals(factoryCode)) {
			model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -1));
		} else model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("066"); // 검사상태(수입검사 합격여부)
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspStatus", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("068"); // 외관검사 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("systemCommonCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("067"); // 외관검사 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("goodsFaultyBigName", systemCommonCodeList);
		return "qm/qmsc0220";
	}
	
	//생산관리 - 재검현황 / 재검집계표
	@RequestMapping(value = "/wmsc0160", method = RequestMethod.GET)
	public String wmsc0160(Locale locale, Model model) throws Exception {
		
		logger.info("생산관리 - 재검현황 / 재검집계표");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "wm/wmsc0160";
	}
	
	//List
	@RequestMapping(value="qm/shipIspListList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> shipIspListList(ShipIspListVo shipIspListVo) throws Exception{
	    Map<String, Object> jsonData = new HashMap<String, Object>();
	    try {
	    	String equipCdList = shipIspListVo.getEquipCd();
			equipCdList = equipCdList.replace("/", "', '");
			equipCdList = equipCdList.substring(3, equipCdList.length());
			equipCdList += "'";
			shipIspListVo.setEquipCd(equipCdList);
			
	        List<ShipIspListVo> shipIspListList = shipIspListService.shipIspListList(shipIspListVo);
	        jsonData.put("data", shipIspListList);
	        jsonData.put("result", "ok");
	    } catch (Exception e) {
	        e.printStackTrace();
	        jsonData.put("result", "error");
	        jsonData.put("message", Utils.getErrorMessage());
	    }
	    return jsonData;
	}
	
	
}