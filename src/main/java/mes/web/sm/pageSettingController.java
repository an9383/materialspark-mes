package mes.web.sm;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.sm.MenuInfoAdmService;
import mes.web.ut.Settings;
import mes.web.ut.Utils;

@Controller
public class pageSettingController {
	
	//smsc0040 화면
	private static final Logger logger = LoggerFactory.getLogger(MatrlCodeAdmService.class);
	@RequestMapping(value = "/smsc0040", method = RequestMethod.GET)
	public String matrlUserMain(ModelAndView mav, Model model) throws Exception {		
		
		//공정실적라벨발행
		Settings singletonSettings = Settings.getInstance();
		model.addAttribute("useMatrlInout", singletonSettings.useMatrlInout);
		model.addAttribute("useGoodsPacking", singletonSettings.useGoodsPacking);
		model.addAttribute("useTrayProduce", singletonSettings.useTrayProduce);
		model.addAttribute("useTrayProduceArray", Arrays.asList(singletonSettings.useTrayProduceArray));
		
		model.addAttribute("lockGoodsPacking", singletonSettings.lockGoodsPacking);
		model.addAttribute("lockTrayProduce", singletonSettings.lockTrayProduce);
		
		return "sm/smsc0040";
	}
	
	
	//pageSettingReset
	@RequestMapping(value="sm/pageSettingReset" , method = RequestMethod.POST)
	public @ResponseBody Map<String , Object> pageSettingReset(String pageSettingReset) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			//제품 포장기능
			if (pageSettingReset.equals("useGoodsPacking")) {
				Settings singletonSettings = Settings.getInstance();
				if (singletonSettings.useGoodsPacking == true) {
					singletonSettings.useGoodsPacking = false;
					jsonData.put("message", "제품포장 기능 초기화되었습니다!");
					jsonData.put("result", "ok");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "제품포장 기능이 사용중이 아닙니다!");
				}
				
			//가입고 등록 기능
			} else if (pageSettingReset.equals("useMatrlInout")) {
				Settings singletonSettings = Settings.getInstance();
				if (singletonSettings.useMatrlInout == false) {
					singletonSettings.useMatrlInout = true;
					jsonData.put("message", "가입고 등록 기능이 비활성화 되었습니다!");
					jsonData.put("result", "ok");
				} else if (singletonSettings.useMatrlInout == true) {
					singletonSettings.useMatrlInout = false;
					jsonData.put("result", "ok");
					jsonData.put("message", "가입고 등록 기능이 활성화 되었습니다!");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "가입고 등록 기능 - 알 수 없는 상태값입니다!");
				}
				
			//트레이 생산 기능 
			} else if (pageSettingReset.equals("useTrayProduce")) {
				Settings singletonSettings = Settings.getInstance();
				if (singletonSettings.useTrayProduce == false) {
					singletonSettings.useTrayProduce = true;
					jsonData.put("message", "트레이 생산 기능이 비활성화 되었습니다!");
					jsonData.put("result", "ok");
				} else if (singletonSettings.useTrayProduce == true) {
					singletonSettings.useTrayProduce = false;
					jsonData.put("result", "ok");
					jsonData.put("message", "트레이 생산 기능이 활성화 되었습니다!");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "트레이 생산 기능Lock - 알 수 없는 상태값입니다!");
				}
			
			//트레이 생산 기능(배열)
			} else if (pageSettingReset.equals("useTrayProduceArray")) {
				Settings singletonSettings = Settings.getInstance();
				
				 singletonSettings.useTrayProduceArray = new String[100];
				 jsonData.put("message", "트레이 생산 기능이 배열이 초기화 되었습니다!");
				 jsonData.put("result", "ok");
				 
			//제품 포장기능 Lock
			} else if (pageSettingReset.equals("lockGoodsPacking")) {
				Settings singletonSettings = Settings.getInstance();
				if (singletonSettings.lockGoodsPacking == false) {
					singletonSettings.lockGoodsPacking = true;
					jsonData.put("message", "제품포장 기능이 비활성화 되었습니다!");
					jsonData.put("result", "ok");
				} else if (singletonSettings.lockGoodsPacking == true) {
					singletonSettings.lockGoodsPacking = false;
					jsonData.put("result", "ok");
					jsonData.put("message", "제품포장 기능이 활성화 되었습니다!");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "제품 포장기능Lock - 알 수 없는 상태값입니다!");
				}
			
			//트레이 생산 기능 Lock
			} else if (pageSettingReset.equals("lockTrayProduce")) {
				Settings singletonSettings = Settings.getInstance();
				if (singletonSettings.lockTrayProduce == false) {
					singletonSettings.lockTrayProduce = true;
					jsonData.put("message", "트레이 생산 기능이 비활성화 되었습니다!");
					jsonData.put("result", "ok");
				} else if (singletonSettings.lockTrayProduce == true) {
					singletonSettings.lockTrayProduce = false;
					jsonData.put("result", "ok");
					jsonData.put("message", "트레이 생산 기능이 활성화 되었습니다!");
				} else {
					jsonData.put("result", "fail");
					jsonData.put("message", "트레이 생산 기능Lock - 알 수 없는 상태값입니다!");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	} 
	
}
