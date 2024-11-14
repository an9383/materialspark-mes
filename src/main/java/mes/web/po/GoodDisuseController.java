package mes.web.po;

import java.io.Console;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.GoodsProductInfoAdmVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.GoodsPackService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class GoodDisuseController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private GoodsPackService goodsPackService;
	
	private static final Logger logger = LoggerFactory.getLogger(GoodDisuseController.class);
	/*------------------------엣지검사 시작------------------------*/
	//품질괄리 -완제품검사 엣지검사
	@RequestMapping(value = "/qmsc0110", method = RequestMethod.GET)
	public String qmsc0110GET(Locale locale, Model model) throws Exception {
		
		logger.info("공정실적관리(POP)/제품(작지) 전체 폐기");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("061"); // 제품 불량유형
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("goodsFaultyType", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
		
		return "qm/qmsc0110";
	}
	
	@RequestMapping(value = "/qm/goodsDisuseListScan", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> goodsDisuseListScan(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품(작지) 전체 폐기 박스 스캔");
		try {
			//원장들boxNoList로 분할된 boxNoList를 찾아 들어가야함!
			//분할&병합이랑 반대로직임
			List<GoodsProductInfoAdmVo> goodsDisuseListScanList = goodsPackService.goodsDisuseListScan(goodsProductInfoAdmVo);
			
			String[] traceBoxList = new String[9999];
			int orignalTraceIndex = goodsDisuseListScanList.size();	//처음 원장 폐기 boxNo 수량
			int traceIndex = goodsDisuseListScanList.size();			//처음 로직 시작시 traceBoxList가 비어있는 위치
			
			//추적해야할 원장 BoxNoList
			for (int i=0; i<goodsDisuseListScanList.size(); i++) {
				traceBoxList[i] = goodsDisuseListScanList.get(i).getBoxNo();
			}
			
			for (int i=0; i<9999; i++) {
				if (traceBoxList[i] == null) {
					break;
				}
				GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
				readGoodsTrace.setBoxNo(traceBoxList[i]);
				readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
				
				//분할여부가 N이면 분할&병합 하지 않은 제품
				if ( "N".equals(readGoodsTrace.getDivisionYn()) ) {
				
				//분할&병합 하였으면 채번된 번호 찾아서 traceBoxList에 넣어줌
				} else {
					List<GoodsProductInfoAdmVo> goodsDisuseTraceList = goodsPackService.traceDisuseBoxNo(readGoodsTrace);
					for (int j=0; j<goodsDisuseTraceList.size(); j++) {
						if (null != goodsDisuseTraceList.get(j).getSelBoxNo1()) {
							//중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (traceBoxList[jj] == null) {
									break;
								}
								if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
									logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
									distinctCheck = false;
								}
							}
							
							//중복이 없으면 추적리스트에 넣어줌
							if (distinctCheck) {
								traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
								traceIndex++;	
							}
						}
						if (null != goodsDisuseTraceList.get(j).getSelBoxNo2()) {
							//중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (traceBoxList[jj] == null) {
									break;
								}
								if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
									logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
									distinctCheck = false;
								}
							}
							
							//중복이 없으면 추적리스트에 넣어줌
							if (distinctCheck) {
								traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
								traceIndex++;
							}
						}
					}
				}
			}
			
			//추적한 BoxNoList
			for (int i=orignalTraceIndex; i<9999; i++) {
				if (traceBoxList[i] == null) {
					break;
				}
				logger.info("추적 완료 boxNo " + traceBoxList[i]);
				GoodsProductInfoAdmVo readGoodsProductInfo = new GoodsProductInfoAdmVo();
				readGoodsProductInfo.setBoxNo(traceBoxList[i]);
				readGoodsProductInfo = goodsPackService.readGoodsProductInfo(readGoodsProductInfo);
				goodsDisuseListScanList.add(readGoodsProductInfo);
			}
			jsonData.put("data", goodsDisuseListScanList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("작업지시 조회 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	
	@RequestMapping(value = "/qm/goodsProductDisuse", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> goodsProductDisuse(GoodsProductInfoAdmVo goodsProductInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("제품(작지) 전체 폐기");
		try {
			
			//원장들boxNoList로 분할된 boxNoList를 찾아 들어가야함!
			//분할&병합이랑 반대로직임
			List<GoodsProductInfoAdmVo> goodsDisuseListScanList = goodsPackService.goodsDisuseListScan(goodsProductInfoAdmVo);
			
			String[] traceBoxList = new String[9999];
			int orignalTraceIndex = goodsDisuseListScanList.size();		//처음 원장 폐기 boxNo 수량
			int traceIndex = goodsDisuseListScanList.size();			//처음 로직 시작시 traceBoxList가 비어있는 위치
			
			//추적해야할 원장 BoxNoList
			for (int i=0; i<goodsDisuseListScanList.size(); i++) {
				traceBoxList[i] = goodsDisuseListScanList.get(i).getBoxNo();
			}
			
			for (int i=0; i<9999; i++) {
				if (traceBoxList[i] == null) {
					break;
				}
				GoodsProductInfoAdmVo readGoodsTrace = new GoodsProductInfoAdmVo();
				readGoodsTrace.setBoxNo(traceBoxList[i]);
				readGoodsTrace = goodsPackService.readGoodsProductInfo(readGoodsTrace);
				
				//분할여부가 N이면 분할&병합 하지 않은 제품
				if ( "N".equals(readGoodsTrace.getDivisionYn()) ) {
				
				//분할&병합 하였으면 채번된 번호 찾아서 traceBoxList에 넣어줌
				} else {
					List<GoodsProductInfoAdmVo> goodsDisuseTraceList = goodsPackService.traceDisuseBoxNo(readGoodsTrace);
					for (int j=0; j<goodsDisuseTraceList.size(); j++) {
						if (null != goodsDisuseTraceList.get(j).getSelBoxNo1()) {
							//중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (traceBoxList[jj] == null) {
									break;
								}
								if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
									logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
									distinctCheck = false;
								}
							}
							
							//중복이 없으면 추적리스트에 넣어줌
							if (distinctCheck) {
								traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
								traceIndex++;	
							}
						}
						if (null != goodsDisuseTraceList.get(j).getSelBoxNo2()) {
							//중복검사
							boolean distinctCheck = true;
							for (int jj=0; jj<9999; jj++) {
								if (traceBoxList[jj] == null) {
									break;
								}
								if (goodsDisuseTraceList.get(j).getBoxNo().equals(traceBoxList[jj])) {
									logger.info("중복 발생 - " + goodsDisuseTraceList.get(j).getBoxNo());
									distinctCheck = false;
								}
							}
							
							//중복이 없으면 추적리스트에 넣어줌
							if (distinctCheck) {
								traceBoxList[traceIndex] = goodsDisuseTraceList.get(j).getBoxNo();
								traceIndex++;
							}
						}
					}
				}
			}

			int boxNoCnt = 0;
			//추적한 boxNo 개수 세기
			for (int i=0; i<9999; i++) {
				if (traceBoxList[i] == null) {
					break;
				} else {
					boxNoCnt++;
				}
			}

			//받아온 boxNoCnt랑 추적boxNoCnt가 같으면 폐기 실행
			if (boxNoCnt == goodsProductInfoAdmVo.getBoxNoCnt()) {
				//추적한 BoxNoList
				for (int i=0; i<9999; i++) {
					if (traceBoxList[i] == null) {
						break;
					}
					logger.info("폐기시킬 boxNo " + traceBoxList[i]);
					logger.info(goodsProductInfoAdmVo.toString());
					GoodsProductInfoAdmVo disuseGoodsProductInfo = new GoodsProductInfoAdmVo();
					disuseGoodsProductInfo.setBoxNo(traceBoxList[i]);
					disuseGoodsProductInfo.setFaultyDate(goodsProductInfoAdmVo.getFaultyDate());
					disuseGoodsProductInfo.setFaultyType(goodsProductInfoAdmVo.getFaultyType());
					disuseGoodsProductInfo.setFaultyDesc(goodsProductInfoAdmVo.getFaultyDesc());
					disuseGoodsProductInfo.setUpdId(Utils.getUserId());
					disuseGoodsProductInfo.setHistId(Utils.getUserId());
					goodsPackService.goodsProductDisuse(disuseGoodsProductInfo);		//폐기 실행
					goodsPackService.insertGoodsProductHist(disuseGoodsProductInfo);	//생산제품 상태변경 기록
				}

				//jsonData.put("data", goodsProductInfoAdmVo);	//jsp에서 reload해줌
				jsonData.put("result", "ok");
				
			} else {
				jsonData.put("message", "폐기대상 수량이 변경되었습니다.<br> 작지번호를 다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}

		} catch (Exception e) {
			logger.info("제품(작지) 전체 폐기 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
}