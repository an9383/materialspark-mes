package mes.web.sm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.mm.PartReqAdmVo;
import mes.domain.mm.PartReqVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.sm.MenuInfoAdmService;
import mes.web.ut.Utils;

@Controller
public class MenuInfoAdmController {
	
	
	@Inject
	private MenuInfoAdmService menuInfoAdmService;
	
	//smsc0020 화면
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	@RequestMapping(value = "/smsc0020", method = RequestMethod.GET)
	public String matrlUserMain(ModelAndView mav) throws Exception {		
		
		return "sm/smsc0020";
	}
	
	//상위메뉴 목록 조회
	@RequestMapping(value = "/sm/menuInfoDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> menuInfoDataList(MenuInfoAdmVo menuInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("상위메뉴 목록조회");
		List<MenuInfoAdmVo> menuInfoData = menuInfoAdmService.readUpperMenu(menuInfoAdmVo);
		jsonData.put("data", menuInfoData);
		
		return jsonData;
	}
	
	//하위메뉴 목록 조회
	@RequestMapping(value = "/sm/subMenuInfoDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> subMenuInfoDataList(MenuInfoAdmVo menuInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("하위메뉴 목록조회");
		menuInfoAdmVo.setUpperMenuId(menuInfoAdmVo.getMenuId());
		List<MenuInfoAdmVo> subMenuInfoData = menuInfoAdmService.readSubMenu(menuInfoAdmVo);
				
		jsonData.put("data", subMenuInfoData);
		
		return jsonData;
	}
	
	//목록 업데이트(수정)
	@RequestMapping(value = "/sm/menuInfoUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoUpdate(MenuInfoAdmVo menuInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("업데이트");
		//menuInfoAdmVo.setMenuId(menuInfoAdmService.selectMenuIdSeq().toString());
		menuInfoAdmVo.setUpdId(Utils.getUserId());
		menuInfoAdmService.update(menuInfoAdmVo);
		
		jsonData.put("result", "ok");
		return jsonData;
	}
	
	//목록 등록
	@RequestMapping(value = "/sm/menuInfoCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuInfoCreate(MenuInfoAdmVo menuInfoAdmVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("등록");
		//menuInfoAdmVo.setMenuId(menuInfoAdmService.selectMenuIdSeq().toString());
		menuInfoAdmVo.setRegId(Utils.getUserId());
		menuInfoAdmVo.setUpdId(Utils.getUserId());
		
		menuInfoAdmService.create(menuInfoAdmVo);
		jsonData.put("result", "ok");
		return jsonData;
	
	}		
	
	//메뉴ID 생성
	@RequestMapping(value = "/sm/menuIdCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> menuIdCreate(ModelAndView mav) throws Exception {
		
		String seq = menuInfoAdmService.selectMenuIdSeq().toString();
		MenuInfoAdmVo menuInfoAdmVo = new MenuInfoAdmVo();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		menuInfoAdmVo.setMenuId(seq);
		
		jsonData.put("data", menuInfoAdmVo);	
		
		return jsonData;
	
	}
	
	//--------------------메뉴 순서 변경 및 지정하는 부분--------------------//

	//메뉴 목록 순서 변경
	@RequestMapping(value="/sm/reOrderMenuIndexUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> reOrderMenuIndexUpdate(MenuInfoAdmVo menuInfoAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("메인메뉴 목록 순서 변경 :"+menuInfoAdmVo);
		try {
			
			JSONParser jsonParser 		= new JSONParser();
			JSONObject jsonObj 			= new JSONObject();
			JSONArray jsonArray	 		= (JSONArray) jsonParser.parse(menuInfoAdmVo.getDataArray());
			
			for(int i=0;i<jsonArray.size();i++){
				jsonObj.put(i, jsonArray.get(i));
				JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(i).toString());
				
				menuInfoAdmVo.setIdx(jsonObjDtl.get("idx").toString());
				menuInfoAdmVo.setMenuId(jsonObjDtl.get("menuId").toString());
				menuInfoAdmVo.setUpdId(Utils.getUserId());
				
				//메뉴 목록 순서 변경
				menuInfoAdmService.menuIndexUpdate(menuInfoAdmVo);
			}
			
			jsonData.put("result", "ok");
			return jsonData;
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//--------------------메뉴 순서 변경 및 지정하는 부분--------------------//
	
	
	
}
