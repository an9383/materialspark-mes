package mes.web.mm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.openxml4j.opc.PackagingURIHelper;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.mm.IndividualOrderAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.mm.IndividualOrderAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class IndividualOrderAdmController {
	
	private static final Logger logger = LoggerFactory.getLogger(IndividualOrderAdmController.class);

	@Inject
	private SystemCommonCodeService systemcommonCodeService;

	@Inject
	private IndividualOrderAdmService individualOrderAdmService;

	
	//개별발주발주관리 메인
	@RequestMapping(value = "/mmsc0020", method = RequestMethod.GET)
	public String mmsc0020(Locale locale, Model model) throws Exception {
		logger.info("개별발주 메인");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));

		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo> useYnList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYn", useYnList);

		systemCommonCodeVo.setBaseGroupCd("073"); // 우선검사여부
		List<SystemCommonCodeVo> finspectYnList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("finspectYn", finspectYnList);

		systemCommonCodeVo.setBaseGroupCd("074"); // 확정여부
		List<SystemCommonCodeVo> confirmYnList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("confirmYn", confirmYnList);

//		systemCommonCodeVo.setBaseGroupCd("050"); // 수입검사여부
//		List<SystemCommonCodeVo> inspectYnList = systemcommonCodeService.listAll(systemCommonCodeVo);
//		model.addAttribute("inspectYn", inspectYnList);
		
		systemCommonCodeVo.setBaseGroupCd("075"); // 입고구분
		List<SystemCommonCodeVo> receiptGubunList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("receiptGubun", receiptGubunList);
		
		//부품구분 공통코드
		systemCommonCodeVo.setBaseGroupCd("069"); // 부품구분
		List<SystemCommonCodeVo> partGubunList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("partGubun", partGubunList );
		
		//부품단위 공통코드
		systemCommonCodeVo.setBaseGroupCd("070"); // 부품타입
		List<SystemCommonCodeVo> partTypeList = systemcommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("partType", partTypeList );
		
		
		model.addAttribute("userNumber", Utils.getUserNumber());
		model.addAttribute("userNm", Utils.getUserNm());

		return "mm/mmsc0020";
	}
	
	
	//발주관리 목록조회
	@RequestMapping(value="mm/individualOrderAdmList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> individualOrderAdmList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("발주관리 목록조회 : "+individualOrderAdmVo);
			List<IndividualOrderAdmVo> individualOrderAdmList = individualOrderAdmService.individualOrderAdmList(individualOrderAdmVo);
			jsonData.put("result", "ok");
			jsonData.put("data", individualOrderAdmList);
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//발주관리 부품정보 목록조회
	@RequestMapping(value="mm/individualOrderDtlList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> individualOrderDtlList(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("발주관리 목록조회:"+individualOrderAdmVo);
			if(individualOrderAdmVo.getPoNo()==null || individualOrderAdmVo.getPoNo().equals("")) {
				List<IndividualOrderAdmVo> list = new ArrayList<IndividualOrderAdmVo>();
				jsonData.put("data", list);
			}else {
				List<IndividualOrderAdmVo> individualOrderDtlList = individualOrderAdmService.individualOrderDtlList(individualOrderAdmVo);
				jsonData.put("data", individualOrderDtlList);
			}
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//부품정보 등록
	@RequestMapping(value="mm/individualOrderAdmCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> individualOrderAdmCreate(@RequestBody List<Map<String, Object>> individualOrderDtlList) throws Exception{
		IndividualOrderAdmVo individualOrderAdmVo = new IndividualOrderAdmVo();
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("발주정보 등록 ");
			
			//발주등록
			individualOrderAdmVo.setPoNo(individualOrderDtlList.get(0).get("poNo").toString());
			individualOrderAdmVo.setDealCorpCd(individualOrderDtlList.get(0).get("dealCorpCd").toString());
			individualOrderAdmVo.setMainChargr(individualOrderDtlList.get(0).get("mainChargr").toString());
			individualOrderAdmVo.setTelNo(individualOrderDtlList.get(0).get("telNo").toString());
			individualOrderAdmVo.setPoDate(individualOrderDtlList.get(0).get("poDate").toString());
			individualOrderAdmVo.setPoRegChargr(individualOrderDtlList.get(0).get("poRegChargr").toString());
			individualOrderAdmVo.setFinspectYn(individualOrderDtlList.get(0).get("finspectYn").toString());
			individualOrderAdmVo.setConfirmYn(individualOrderDtlList.get(0).get("confirmYn").toString());
			individualOrderAdmVo.setUseYn(individualOrderDtlList.get(0).get("useYn").toString());
			individualOrderAdmVo.setReceiptGubun(individualOrderDtlList.get(0).get("receiptGubun").toString());
			individualOrderAdmVo.setPoDesc(individualOrderDtlList.get(0).get("poDesc").toString());
			individualOrderAdmVo.setRegId(Utils.getUserId());
			
			individualOrderAdmService.individualOrderAdmCreate(individualOrderAdmVo);
			
			for(Map<String, Object> m :individualOrderDtlList) {
				
				individualOrderAdmVo.setPartCd(m.get("partCd").toString());
				individualOrderAdmVo.setPartRev(m.get("partRev").toString());
				individualOrderAdmVo.setPartQty(m.get("partQty").toString());
				individualOrderAdmVo.setSafyStockCnt(m.get("safyStockCnt").toString());
				individualOrderAdmVo.setPartUnitCost(m.get("partUnitCost").toString());
				individualOrderAdmVo.setDlvDate(m.get("dlvDate").toString());
				//individualOrderAdmVo.setOrdCorpCd(m.get("ordCorpCd").toString());
				
				
				if(m.get("mrpNo").toString()!=null && !m.get("mrpNo").toString().equals("")) {	//발주관리일 경우
					individualOrderAdmVo.setMrpNo(m.get("mrpNo").toString());
				    individualOrderAdmVo.setContDtlNo(m.get("contDtlNo").toString());
				    
				    //발주예정수량과 발주수량 비교 -> 발주예정수량 <= 발주수량 : Y / 발주예정수량 > 발주수량 : N
				    //Y인 경우 같은 (소요량,수주상세번호,코드)발주항목에 Y로 변경
				    IndividualOrderAdmVo compareVo = individualOrderAdmService.compareOrderQty(individualOrderAdmVo);
				    
				    float preOrderQty = compareVo.getPreOrderQty();									//발주예정수량
				    float orderQty = compareVo.getOrderQty();										//이전 총 발주수량(발주수량+안전재고)
				    float partQty = Float.parseFloat(individualOrderAdmVo.getPartQty());				//현재 발주수량
				    float safyStockCnt = Float.parseFloat(individualOrderAdmVo.getSafyStockCnt());	//현재 안전재고수량
				    
				    
				    if(preOrderQty <=(orderQty+partQty+safyStockCnt)) {
				    	individualOrderAdmVo.setPoStatus("002");
				    	
				    	//발주예정수량<=발주수량 : Y로 변경
				    	individualOrderAdmService.poStatusYUpdate(individualOrderAdmVo);
				    	
				    	
				    }else {
				    	individualOrderAdmVo.setPoStatus("001");
				    }
				}
	
				logger.info("발주등록vo"+individualOrderAdmVo);
				individualOrderAdmVo.setPoSeq(individualOrderAdmService.getPoSeq(individualOrderAdmVo));
				individualOrderAdmService.purchaseOrderDtlCreate(individualOrderAdmVo);
				individualOrderAdmService.partAmtUpdate(individualOrderAdmVo);
				
				/*
				 * //새로 추가될것(등록) if(m.get("poSeq").toString()==null ||
				 * m.get("poSeq").toString().equals("")) { int poSeq =
				 * individualOrderAdmService.getPoSeq(individualOrderAdmVo);
				 * individualOrderAdmVo.setPoSeq(poSeq);
				 * individualOrderAdmService.purchaseOrderDtlCreate(individualOrderAdmVo);
				 * individualOrderAdmService.partAmtUpdate(individualOrderAdmVo); }else {
				 * individualOrderAdmVo.setPoSeq(Integer.parseInt(m.get("poSeq").toString()));
				 * individualOrderAdmService.purchaseOrderDtlUpdate(individualOrderAdmVo);
				 * individualOrderAdmService.partAmtUpdate(individualOrderAdmVo); }
				 */
			}
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
	//부품정보 삭제
	@RequestMapping(value="mm/individualOrderDtlDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> individualOrderDtlDelete(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("발주관리 삭제");
			individualOrderAdmService.individualOrderDtlDelete(individualOrderAdmVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
		
	//발주번호 생성
	@RequestMapping(value="mm/getPoNo", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> getPoNo(IndividualOrderAdmVo individualOrderAdmVo) throws Exception{
		Map<String , Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("발주관리 발주번호생성");
			String toDay = DateUtil.getToday("YYMMdd");
			individualOrderAdmVo.setToday(toDay);
			String poNoSeq = individualOrderAdmService.getPoNo(individualOrderAdmVo);
			String poNo = "P"+toDay+"-"+poNoSeq;
			logger.info(poNo);
			jsonData.put("result", "ok");
			jsonData.put("data", poNo);
		} catch (Exception e) {
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}

}
