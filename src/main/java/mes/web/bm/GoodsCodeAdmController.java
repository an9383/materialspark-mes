package mes.web.bm;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.GoodsMatrlDtlVo;
import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.GoodsMatrlDtlService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.web.ut.Utils;

@Controller
public class GoodsCodeAdmController {
	
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private GoodsMatrlDtlService goodsMatrlDtlService;
	
	private static final Logger logger = LoggerFactory.getLogger(GoodsCodeAdmController.class);

	//제품코드관리 메인
	@RequestMapping(value = "/bmsc0010", method = RequestMethod.GET)
	public String goodsCodeAdmMain(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("제품코드관리 메인");
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate );
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("024"); // 사용여부
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("useYnCd", systemCommonCodeList );		
		
		systemCommonCodeVo.setBaseGroupCd("080"); // 기종코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("gijongCd", systemCommonCodeList );		
		
		systemCommonCodeVo.setBaseGroupCd("008"); // 재고단위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("tmUnitCd", systemCommonCodeList );		

		systemCommonCodeVo.setBaseGroupCd("031"); // 포장단위
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("packUnitCd", systemCommonCodeList );
		
		systemCommonCodeVo.setBaseGroupCd("124"); // 제품샘플여부
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsSampleCd", systemCommonCodeList );
				
		return "bm/bmsc0010";
	}

	//제품코드관리 목록조회
	@RequestMapping(value = "/bm/goodsCodeDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsCodeDataList(GoodsCodeAdmVo goodsCodeAdmVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품코드관리 목록조회");
		 try {		
			//String searchVal = request.getParameter("search[value]");	
			List<GoodsCodeAdmVo> goodsCodeDataList = goodsCodeAdmService.listAll(goodsCodeAdmVo);
			jsonData.put("data", goodsCodeDataList);
		 } catch (Exception e) {
				logger.info("제품코드관리 목록조회 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }			 
		 return jsonData;
	}
	
	//제품코드관리 목록조회
	@RequestMapping(value = "/bm/goodsCodeData", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsCodeData(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품코드관리 상세조회");
		try {		
			goodsCodeAdmVo = goodsCodeAdmService.read(goodsCodeAdmVo);
			jsonData.put("data", goodsCodeAdmVo);
			
			// Al/Nicu 자재정보 상세조회
			MatrlCodeAdmVo alniMatrlCodeAdmVo = new MatrlCodeAdmVo();
			alniMatrlCodeAdmVo.setMatrlCd(goodsCodeAdmVo.getAlnicuMatrlCd());
			alniMatrlCodeAdmVo.setMatrlSeq(goodsCodeAdmVo.getAlnicuMatrlCd().substring(1, goodsCodeAdmVo.getAlnicuMatrlCd().length()));
			alniMatrlCodeAdmVo = matrlCodeAdmService.read(alniMatrlCodeAdmVo);
			jsonData.put("alnidata", alniMatrlCodeAdmVo);
	
			// Film 자재정보 상세조회
			MatrlCodeAdmVo filmMatrlCodeAdmVo = new MatrlCodeAdmVo();		
			filmMatrlCodeAdmVo.setMatrlCd(goodsCodeAdmVo.getFilmMatrlCd());
			filmMatrlCodeAdmVo.setMatrlSeq(goodsCodeAdmVo.getFilmMatrlCd().substring(1, goodsCodeAdmVo.getFilmMatrlCd().length()));
			filmMatrlCodeAdmVo = matrlCodeAdmService.read(filmMatrlCodeAdmVo);
			jsonData.put("filmdata", filmMatrlCodeAdmVo);
			jsonData.put("result", "ok");
	 	} catch (Exception e) {
			logger.info("제품코드관리 상세목록 조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}			 
	 return jsonData;
	}
	
	//제품코드관리 등록
	@RequestMapping(value = "/bm/goodsCdCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsCdCreate(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품코드관리 등록");
		
		try {
			//modelNm 중복검사
			//GoodsCodeAdmVo tmpGoodsCodeAdmVo = goodsCodeAdmService.searchModelNo(goodsCodeAdmVo);
			//if(tmpGoodsCodeAdmVo != null) {
			//	jsonData.put("data", goodsCodeAdmVo);
			//	jsonData.put("message", "동일 모델NO가 이미 등록 되어 있습니다.<br/>모델NO를 확인해 주세요.");
			//	jsonData.put("result", "fail");
			//} else {
				
				goodsCodeAdmVo.setRegId(Utils.getUserId());
				String goodsSeq = goodsCodeAdmService.selectGoodsSeqCd();
				goodsCodeAdmVo.setGoodsSeq(goodsSeq);
				String preGoodsCd = goodsCodeAdmVo.getAlnicuMatrlCd().substring(0, 1);
				String goodsCd = preGoodsCd.concat(goodsSeq);
				goodsCodeAdmVo.setGoodsCd(goodsCd);
				
				goodsCodeAdmService.create(goodsCodeAdmVo);
				jsonData.put("data", goodsCodeAdmVo);
				jsonData.put("message", "등록되었습니다.");
				jsonData.put("result", "ok");
			//}
		}
		catch (Exception e) {
			logger.info("제품코드 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//제품코드관리 수정
	@RequestMapping(value = "/bm/goodsCdUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsCdUpdate(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품코드관리 수정");

		try {
			//GoodsCodeAdmVo tmpGoodsCodeAdmVo = goodsCodeAdmService.searchModelNo(goodsCodeAdmVo);
			//모델NO조회 후 동일 제픔코드인 경우에 수정
			//if(tmpGoodsCodeAdmVo != null && !tmpGoodsCodeAdmVo.getGoodsCd().equals(goodsCodeAdmVo.getGoodsCd())) {
			//	jsonData.put("data", goodsCodeAdmVo);
			//	jsonData.put("message", "동일 모델NO가 이미 등록 되어 있습니다.<br/>모델NO를 확인해 주세요.");
			//	jsonData.put("result", "fail");
			//} else {
				goodsCodeAdmVo.setUpdId(Utils.getUserId());
				goodsCodeAdmService.update(goodsCodeAdmVo);
				jsonData.put("data", goodsCodeAdmVo);
				jsonData.put("message", "수정되었습니다.");
				jsonData.put("result", "ok");
			//}
		}
		catch (Exception e) {
			logger.info("제품코드 수정 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품자재상세 목록조회
	@RequestMapping(value = "/bm/goodsMatrlDtlListAll", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsMatrlDtlListAll(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품자재상세 목록조회");

		try {
			List<GoodsMatrlDtlVo> goodsMatrlDtlList = goodsMatrlDtlService.listAll(goodsMatrlDtlVo);
			jsonData.put("data", goodsMatrlDtlList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("제품자재상세 목록조회 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품자재상세 등록
	@RequestMapping(value = "/bm/goodsMatrlDtlAdd", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsMatrlDtlAdd(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품자재상세 등록");

		try {
			goodsMatrlDtlVo.setRegId(Utils.getUserId());
			goodsMatrlDtlService.create(goodsMatrlDtlVo);
			List<GoodsMatrlDtlVo> goodsMatrlDtlList = goodsMatrlDtlService.listAll(goodsMatrlDtlVo);
			jsonData.put("data", goodsMatrlDtlList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("제품자재상세 등록 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품자재상세 수정
	@RequestMapping(value = "/bm/goodsMatrlDtlEdit", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsMatrlDtlEdit(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품자재상세 수정");

		try {
			goodsMatrlDtlVo.setUpdId(Utils.getUserId());
			goodsMatrlDtlService.update(goodsMatrlDtlVo);
			List<GoodsMatrlDtlVo> goodsMatrlDtlList = goodsMatrlDtlService.listAll(goodsMatrlDtlVo);
			jsonData.put("data", goodsMatrlDtlList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("제품자재상세 수정 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//제품자재상세 삭제
	@RequestMapping(value = "/bm/goodsMatrlDtlDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsMatrlDtlDelete(GoodsMatrlDtlVo goodsMatrlDtlVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품자재상세 삭제");

		try {
			goodsMatrlDtlService.delete(goodsMatrlDtlVo);
			List<GoodsMatrlDtlVo> goodsMatrlDtlList = goodsMatrlDtlService.listAll(goodsMatrlDtlVo);
			jsonData.put("data", goodsMatrlDtlList);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("제품자재상세 삭제 에러 발생");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
}