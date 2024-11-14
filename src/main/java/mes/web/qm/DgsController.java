package mes.web.qm;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.po.AgtBomVo;
import mes.service.bm.SystemCommonCodeService;
import mes.service.po.AgtService;
import mes.web.ut.DateUtil;
import mes.web.ut.Utils;

@Controller
public class DgsController {
	
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private AgtService agtService;
	
	@Value("${factoryCode}") private String facotryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(DgsController.class);
	/*------------------------엣지검사 시작------------------------*/
	//품질괄리 - 설비게더링데이터
	@RequestMapping(value = "/qmsc0120", method = RequestMethod.GET)
	public String qmsc0120(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 설비 게더링 데이터");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "qm/qmsc0120";
	}

	//품목정보 전체 조회
	@RequestMapping(value = "/po/readDgsDataList_nF1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readDgsDataList_nF1(AgtBomVo agtBomVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비&일자별 DGS 데이터 조회 : " + agtBomVo);
		try {
			String start = request.getParameter("start");
			String length = request.getParameter("length");
			String searchVal = request.getParameter("search[value]");
			String ordDir = request.getParameter("order[0][dir]");
			String ordColumnIdx = request.getParameter("order[0][column]");
			//String ordColumn = request.getParameter("columns[" + ordColumnIdx + "][data]");
			String ordColumn = "asc";

			//logger.info("start = " + start + ",length = " + length + ",searchVal = " + searchVal + ",ordColumn = " + ordColumn + ",ordDir = " + ordDir);

			//				Enumeration<String> e = request.getParameterNames(); 
			//				while(e.hasMoreElements()){
			//					String name = e.nextElement();
			//					String[] data = request.getParameterValues(name);
			//					logger.info("name = " + name);
			//					if(data!=null){
			//						int i = 0;
			//						for(String eachdata : data){
			//							logger.info(i + " ,data = " + eachdata);
			//							i++;
			//						}
			//					}
			//				}
			//				
			//itemVo.setStart(Integer.parseInt(start));
			//itemVo.setLength(Integer.parseInt(length));
			agtBomVo.setFactoryCode(facotryCode);			
			agtBomVo.setSearchVal(searchVal);
			ordColumn = Utils.convert2UnderscoreCase(ordColumn);
			agtBomVo.setOrdDir(ordDir);
			agtBomVo.setOrdColumn(ordColumn);

			List<AgtBomVo> agtBomList = agtService.readDgsDataList_nF1(agtBomVo);
			int totalCount = 0;
			if (agtBomList.size() > 0) {
				totalCount = agtBomList.get(0).getTotalCount();
			}

			logger.info("검색 후 : " + agtBomList);
			jsonData.put("recordsTotal", totalCount);
			jsonData.put("recordsFiltered", totalCount);
			jsonData.put("data", agtBomList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@RequestMapping(value = "/po/readEquipCondSeqList_nF1", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readEquipCondSeqList_nF1(AgtBomVo agtBomVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비별 DGS 제조조건 리스트 조회 : " + agtBomVo);
		try {
			List<AgtBomVo> agtEquipCondSeqList = agtService.readEquipCondSeqList_nF1(agtBomVo);

			logger.info("검색 후 : " + agtEquipCondSeqList);
			jsonData.put("data", agtEquipCondSeqList);
			jsonData.put("message", "개의 제조조건이 조회되었습니다.");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	
	
	
	
	//품질괄리 - 설비게더링데이터
	@RequestMapping(value = "/qmsc2120", method = RequestMethod.GET)
	public String qmsc2120(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 설비 게더링 데이터");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "qm/qmsc2120";
	}
	
	//품질괄리 - 설비게더링데이터
	@RequestMapping(value = "/qmsc3120", method = RequestMethod.GET)
	public String qmsc3120(Locale locale, Model model) throws Exception {
		
		logger.info("품질관리 / 설비 게더링 데이터");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroupCd", systemCommonCodeList);
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		return "qm/qmsc3120";
	}
	
	//품목정보 전체 조회
	@RequestMapping(value = "/po/readDgsDataList_F2F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readDgsDataList_F2F3(AgtBomVo agtBomVo, HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비&일자별 DGS 데이터 조회 : " + agtBomVo);
		try {
			String start = request.getParameter("start");
			String length = request.getParameter("length");
			String searchVal = request.getParameter("search[value]");
			String ordDir = request.getParameter("order[0][dir]");
			String ordColumnIdx = request.getParameter("order[0][column]");
			//String ordColumn = request.getParameter("columns[" + ordColumnIdx + "][data]");
			String ordColumn = "asc";

			//logger.info("start = " + start + ",length = " + length + ",searchVal = " + searchVal + ",ordColumn = " + ordColumn + ",ordDir = " + ordDir);

			//				Enumeration<String> e = request.getParameterNames(); 
			//				while(e.hasMoreElements()){
			//					String name = e.nextElement();
			//					String[] data = request.getParameterValues(name);
			//					logger.info("name = " + name);
			//					if(data!=null){
			//						int i = 0;
			//						for(String eachdata : data){
			//							logger.info(i + " ,data = " + eachdata);
			//							i++;
			//						}
			//					}
			//				}
			//				
			//itemVo.setStart(Integer.parseInt(start));
			//itemVo.setLength(Integer.parseInt(length));
			agtBomVo.setFactoryCode(facotryCode);
			agtBomVo.setSearchVal(searchVal);
			ordColumn = Utils.convert2UnderscoreCase(ordColumn);
			agtBomVo.setOrdDir(ordDir);
			agtBomVo.setOrdColumn(ordColumn);
			
			if( facotryCode.equals("003") ) {
				agtBomVo.setSearchAll("all");
			}

			List<AgtBomVo> agtBomList = agtService.readDgsDataList_F2F3(agtBomVo);
			int totalCount = 0;
			if (agtBomList.size() > 0) {
				totalCount = agtBomList.get(0).getTotalCount();
			}

			logger.info("검색 후 : " + agtBomList);
			jsonData.put("recordsTotal", totalCount);
			jsonData.put("recordsFiltered", totalCount);
			jsonData.put("data", agtBomList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
	//설비별 DGS 제조조건 리스트 조회
	@RequestMapping(value = "/po/readEquipCondSeqList_F2F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> readEquipCondSeqList_F2F3(AgtBomVo agtBomVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("설비별 DGS 제조조건 리스트 조회 : " + agtBomVo);
		try {
			List<AgtBomVo> agtEquipCondSeqList = agtService.readEquipCondSeqList_F2F3(agtBomVo);

			logger.info("검색 후 : " + agtEquipCondSeqList);
			jsonData.put("data", agtEquipCondSeqList);
			jsonData.put("message", "개의 제조조건이 조회되었습니다.");
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}

		return jsonData;
	}
	
}