package mes.web.bm;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.CustCorpPriceVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.CustCorpPriceService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class CustCorpPriceController {

    private static final Logger logger = LoggerFactory.getLogger(CustCorpPriceController.class);
    
    @Inject
    private CustCorpPriceService custCorpPriceService;
    @Inject
    private SystemCommonCodeService systemCommonCodeService;
    
    
    
    //고객사별단가등록 페이지
	@RequestMapping(value = "/bmsc0140", method = RequestMethod.GET)
	public String bmsc0140(Locale locale, Model model) throws Exception {
	    model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
	    model.addAttribute("serverDateTo", DateUtil.getToday("yyyy-mm-dd"));
	    model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
	    
	    SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("032"); // 화폐단위
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("moneyUnitCd", systemCommonCodeList );		
	
	    return "bm/bmsc0140";
	}
    
    
	//고객사별단가등록 조회
	@RequestMapping(value="bm/custCorpPriceList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> custCorpPriceList(CustCorpPriceVo custCorpPriceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("단가등록 목록 조회 : "+ custCorpPriceVo);
		try {
			List<CustCorpPriceVo> list = custCorpPriceService.custCorpPriceList(custCorpPriceVo);
			
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	
	//단가등록 상세조회
	@RequestMapping(value = "bm/custCorpPriceRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> custCorpPriceRead(CustCorpPriceVo custCorpPriceVo) throws Exception{
		Map<String,Object> jsonData = new HashMap<>();
		try {
			custCorpPriceVo = custCorpPriceService.custCorpPriceRead(custCorpPriceVo);
		
			jsonData.put("data", custCorpPriceVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//단가등록 등록
	@RequestMapping(value="/bm/custCorpPriceCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> custCorpPriceCreate(CustCorpPriceVo custCorpPriceVo,
			@RequestParam(value = "goodsCd") String goodsCd,
			@RequestParam(value = "goodsSeq") String goodsSeq,
			@RequestParam(value = "dealCorpCd") String dealCorpCd,
			@RequestParam(value = "unitCost") String unitCost) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("단가 등록 읽기 : "+custCorpPriceVo);
		try {
			
			if(custCorpPriceService.pkCheck(custCorpPriceVo) == null) {
				custCorpPriceVo.setRegId(Utils.getUserId().toString());
				custCorpPriceService.custCorpPriceCreate(custCorpPriceVo);
				
				logger.info("단가 등록 등록 = "+ custCorpPriceVo);
				
				jsonData.put("result", "ok");
			} else jsonData.put("result", "no");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//단가등록 수정
	@RequestMapping(value = "/bm/custCorpPriceUpdate", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> custCorpPriceUpdate(CustCorpPriceVo custCorpPriceVo,
			@RequestParam(value = "goodsCd") String goodsCd,
			@RequestParam(value = "goodsSeq") String goodsSeq,
			@RequestParam(value = "dealCorpCd") String dealCorpCd,
			@RequestParam(value = "unitCost") String unitCost) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {
			custCorpPriceVo.setUpdId(Utils.getUserId().toString());			
			custCorpPriceService.custCorpPriceUpdate(custCorpPriceVo);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//단가등록 삭제
	@RequestMapping(value = "/bm/custCorpPriceDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> custCorpPriceDelete(CustCorpPriceVo custCorpPriceVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		try {

			//단가등록 삭제
			custCorpPriceService.custCorpPriceDelete(custCorpPriceVo);
			
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
	
	//고객사-제품 단가 조회
	@RequestMapping(value = "bm/custCorpPrice", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> custCorpPrice(CustCorpPriceVo custCorpPriceVo) throws Exception{
		Map<String,Object> jsonData = new HashMap<>();
		try {
			custCorpPriceVo = custCorpPriceService.custCorpPrice(custCorpPriceVo);
		
			jsonData.put("data", custCorpPriceVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		
		return jsonData;
	}
}