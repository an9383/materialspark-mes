package mes.web.home;

import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import mes.web.cm.Constants;

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	// home
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView root(ModelAndView mav, HttpServletRequest request) {

		String userAgent = request.getHeader("user-agent");
		logger.info("userAgent(PDA확인하기) : " + userAgent);
		if (userAgent.indexOf("iPhone") != -1 || userAgent.indexOf("iPad") != -1 || userAgent.indexOf("Android") != -1 || userAgent.indexOf("BlackBerry") != -1 || userAgent.indexOf("symbian") != -1 || userAgent.indexOf("sony") != -1 || userAgent.indexOf("Mobile") != -1) {
			logger.info("Mobile 접속 pdsc0070(PDA Main)으로 이동");
			mav.setViewName("redirect:/pdsc0070");
		} else {
			logger.info("PC 접속 main으로 이동");
			mav.setViewName("redirect:/main");
		}

		return mav;
	}
	
	//404 에러처리
	@RequestMapping(value = "/auth/page404", method = RequestMethod.GET)
	public ModelAndView page404(ModelAndView mav) {
		mav.setViewName("auth/page404");
		return mav;
	}
	
	//500 에러처리
	@RequestMapping(value = "/auth/page500", method = RequestMethod.GET)
	public ModelAndView page500(ModelAndView mav) {
		mav.setViewName("auth/page500");
		return mav;
	}
	
	//그외 에러처리
	@RequestMapping(value = "/auth/pageError", method = RequestMethod.GET)
	public ModelAndView pageError(ModelAndView mav) {
		mav.setViewName("auth/pageError");
		return mav;
	}

	// dashboard
	//@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	//public ModelAndView dashboard(ModelAndView mav) {
	//	mav.setViewName("home/dashboard");
	//	return mav;
	//}

	// commingsoon
	//@RequestMapping(value = "/commingsoon", method = RequestMethod.GET)
	//public ModelAndView commingsoon(ModelAndView mav) {
	//	mav.setViewName("etc/commingsoon");
	//	return mav;
	//}

	// default
	//@RequestMapping(value = "/defaultpage", method = RequestMethod.GET)
	//public ModelAndView defaultpage(ModelAndView mav) {
	//	mav.setViewName("etc/defaultpage");
	//	return mav;
	//}

	// pagesidebar
	//@RequestMapping(value = "/pagesidebar", method = RequestMethod.GET)
	//public ModelAndView pagesidebar(ModelAndView mav) {
	//	mav.setViewName("etc/pagesidebar");
	//	return mav;
	//}

	// eaars
	//@RequestMapping(value = "/eaars", method = RequestMethod.GET)
	//public ModelAndView eaars(ModelAndView mav) {
	//	mav.setViewName("etc/eaars");
	//	return mav;
	//}

	// attend
	//@RequestMapping(value = "/attend", method = RequestMethod.GET)
	//public ModelAndView attend(ModelAndView mav) {
	//	mav.setViewName("etc/attend");
	//	return mav;
	//}
	

	/*---------------------------------------- 테스트 페이지 ----------------------------------------*/
	@RequestMapping(value = "/test_bm_011", method = RequestMethod.GET)
	public ModelAndView test_bm_011(ModelAndView mav) {
		mav.setViewName("testPage/test_bm_011");
		return mav;
	}
	
	@RequestMapping(value = "/test_bm_011_1", method = RequestMethod.GET)
	public ModelAndView test_bm_011_1(ModelAndView mav) {
		mav.setViewName("testPage/test_bm_011_1");
		return mav;
	}
	
	@RequestMapping(value = "/test_basiclayout_011", method = RequestMethod.GET)
	public ModelAndView test_basiclayout_011(ModelAndView mav) {
		mav.setViewName("testPage/test_basiclayout_011");
		return mav;
	}
	
	@RequestMapping(value = "/test_basiclayout_011_1", method = RequestMethod.GET)
	public ModelAndView test_basiclayout_011_1(ModelAndView mav) {
		mav.setViewName("testPage/test_basiclayout_011_1");
		return mav;
	}
	
	@RequestMapping(value = "/test_basiclayout_009", method = RequestMethod.GET)
	public ModelAndView test_basiclayout_009(ModelAndView mav) {
		mav.setViewName("testPage/test_basiclayout_009");
		return mav;
	}
	
	@RequestMapping(value = "/test_bm_009(tab)", method = RequestMethod.GET)
	public ModelAndView test_bm_009 (ModelAndView mav) {
		mav.setViewName("testPage/test_bm_009(tab)");
		return mav;
	}
	
	
	
	/* ---------------------------------------- PDA 테스트 페이지 ----------------------------------------  */
	//pda012
	@RequestMapping(value = "/pda011", method = RequestMethod.GET)
	public String pda011GET(Locale locale, Model model) throws Exception {
		
		logger.info("pda011 페이지");

		return "testPage/pda011";
	}
	
	//pda012
	@RequestMapping(value = "/pda012", method = RequestMethod.GET)
	public String pda012GET(Locale locale, Model model) throws Exception {
		
		logger.info("pda012 페이지");

		return "testPage/pda012";
	}
	
	//pda013
	@RequestMapping(value = "/pda013", method = RequestMethod.GET)
	public String pda013GET(Locale locale, Model model) throws Exception {
		
		logger.info("pda013 페이지");

		return "testPage/pda013";
	}
	
	//pda013_1
	@RequestMapping(value = "/pda013_1", method = RequestMethod.GET)
	public String pda013_1GET(Locale locale, Model model) throws Exception {
		
		logger.info("pda013_1 페이지");

		return "testPage/pda013_1";
	}
	
	//pda014
	@RequestMapping(value = "/pda014", method = RequestMethod.GET)
	public String pda014GET (Locale locale, Model model) throws Exception {
		
		logger.info("pda014 페이지");

		return "testPage/pda014";
	}
	
	
	/* ---------------------------------------- 미개발 페이지 ----------------------------------------  */

	//eisc0040
	@RequestMapping(value = "/eisc0040", method = RequestMethod.GET)
	public String ei_sc0040 (Locale locale, Model model) throws Exception {
		
		logger.info("eisc0040 페이지");

		return "testPage/notPage";
	}
	
	//Main
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main (Locale locale, Model model, HttpServletRequest request) throws Exception {
		logger.info("main 페이지 - 생산팀이면 posc0010으로, 그외 main으로");
		HttpSession session = request.getSession(true);
		String userDepartemntCd = (String) session.getAttribute(Constants.USER_DEPARTMENT_CD);
		String factoryCode = (String) session.getAttribute(Constants.FACTORY_CODE);
		String teamPageMoveYn = "";
		if(factoryCode.equals("003")) {
			teamPageMoveYn = (String) session.getAttribute(Constants.TEAM_PAGE_MOVE_YN);
		} else {
			teamPageMoveYn = "002";
		}
		//생산팀이면 작업지시선택(posc0010)
		if (userDepartemntCd.equals("001"))
			if (factoryCode.equals("001")) {
            return "redirect:/posc2010";   
		} else if (factoryCode.equals("002")){ 
			return "redirect:/posc2010";   
		} else if (factoryCode.equals("003") && teamPageMoveYn.equals("001")) {
			return "redirect:/posc3090";
			//return "redirect:/posc3010";
		} else {
			return "cm/main";
			
		//생상팀 외
		} else {
			return "cm/main";
		}
	}
	
	//posc3090
	@RequestMapping(value = "/posc3090", method = RequestMethod.GET)
	public String posc3090GET (Locale locale, Model model) throws Exception {
		
		logger.info("posc3090 페이지");

		return "po/posc3090";
	}
	
	//모바일 권한없음 PDA 메인
	@RequestMapping(value = "/mainPDA", method = RequestMethod.GET)
	public String mainPDA (Locale locale, Model model) throws Exception {
		
		logger.info("mainPDA 페이지");

		return "cm/mainPDA";
	}
	
}