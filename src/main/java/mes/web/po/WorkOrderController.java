package mes.web.po;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import mes.domain.bm.EquipCodeAdmVo;
import mes.domain.bm.GoodsCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.bm.SystemCommonGroupVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.po.AgtVo;
import mes.domain.po.AllFaultyAdmVo;
import mes.domain.po.EquipCondCombineAdmVo;
import mes.domain.po.ProductionPerfTrayVo;
import mes.domain.po.RealTimeRedisBomVo;
import mes.domain.po.RedisDataJudgmentVo;
import mes.domain.po.TotalFaultyAdmVo;
import mes.domain.po.WorkOrdOutputSubVo;
import mes.domain.po.WorkOrderVo;
import mes.domain.po.WorkerChangeVo;
import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuAuthVo;
import mes.service.bm.EquipCodeAdmService;
import mes.service.bm.GoodsCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.bm.SystemCommonGroupService;
import mes.service.em.EquipCondBomAdmService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.StockPaymentAdmService;
import mes.service.po.AgtService;
import mes.service.po.AllFaultyAdmService;
import mes.service.po.EquipFaultyAdmService;
import mes.service.po.ProductionPerfTrayService;
import mes.service.po.WorkOrdOutputSubService;
import mes.service.po.WorkOrderService;
import mes.service.qm.GoodsInspectService;
import mes.service.sm.MatrlUserService;
import mes.service.sm.MenuAuthService;
import mes.web.cm.Constants;
import mes.web.io.StockPaymentAdmController;
import mes.web.ut.DateUtil;
import mes.web.ut.Settings;
import mes.web.ut.Utils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

@Controller
public class WorkOrderController {
	
	@Inject
	private SystemCommonGroupService systemCommonGroupService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private EquipCondBomAdmService equipCondBomAdmService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private EquipCodeAdmService equipCodeAdmService;
	@Inject
	private WorkOrderService workOrderService;
	@Inject
	private EquipFaultyAdmService equipFaultyAdmService;
	@Inject
	private AgtService agtService;
	@Inject
	private WorkOrdOutputSubService workOrdOutputSubService;
	@Inject
	private AllFaultyAdmService allFaultyAdmService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	@Inject
	private MatrlUserService matrlUserService;
	@Inject
	private MenuAuthService menuAuthService;
	@Inject
	private ProductionPerfTrayService productionPerfTrayService;
	@Inject
	private GoodsCodeAdmService goodsCodeAdmService;
	@Inject
	private GoodsInspectService goodsInspectService;

	@Value("${factoryCode}") private String factoryCode;
	@Value("${dgsRedisIP}") private String dgsRedisIP;
	
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderController.class);
	
	//작업지시서 계획 목록조회(MTP-1공장)
	@RequestMapping(value = "/posc0010", method = RequestMethod.GET)
	public String posc0010(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("011");	//비가동 구분
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("replaceFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("troubleFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("090"); // 테프론 선택
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("teflonCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("062"); // 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052"); //공정불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053"); //원자재불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054"); //교체불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055"); //설비트러블불량 명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonCodeVo.setBaseGroupCd("093"); //생산비전불량 현황 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMajorCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); //생산비전불량 현황 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMinorCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		systemCommonCodeVo.setBaseGroupCd("064"); //POP 모니터링 활성화/비활성화
		systemCommonCodeVo.setEtc1("Y");
		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		
		HttpSession session = request.getSession(true);
		
		if (systemCommonCodeVo == null || "Y".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "yes");
		} else if ("N".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "no");
		}
		
		//접속자 IP가 설비그룹의 etc1에 매칭되었으면 해당코드번호로 바꿔줌
		SystemCommonCodeVo equipGroupCd = new SystemCommonCodeVo();
		String clientIp = Utils.getClientIP(request);
		logger.info("접속자 IP : " + clientIp);
		equipGroupCd.setBaseGroupCd("017"); //POP 모니터링 활성화&비활성화
		equipGroupCd.setEtc1(clientIp);
		equipGroupCd = systemCommonCodeService.read(equipGroupCd);
		if (equipGroupCd == null) {
			
		} else {
			session.setAttribute(Constants.POP_EQUIP_GROUP_CD, equipGroupCd.getBaseCd());		//각 POP IP별 설비그룹 매칭			
		}
		
		return "po/posc0010";
	}
	
	//작업지시서 계획 목록조회(MTP-2공장)
	@RequestMapping(value = "/posc2010", method = RequestMethod.GET)
	public String posc2010(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("011"); // 비가동 구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("replaceFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("troubleFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("062"); // 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052"); //공정불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053"); //원자재불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054"); //교체불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055"); //설비트러블불량 명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		systemCommonCodeVo.setBaseGroupCd("064"); //POP 모니터링 활성화/비활성화
		systemCommonCodeVo.setEtc1("Y");
		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		
		systemCommonCodeVo.setBaseGroupCd("093"); //생산비전불량 현황 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMajorCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); //생산비전불량 현황 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMinorCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		HttpSession session = request.getSession(true);
		
		if (systemCommonCodeVo == null || "Y".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "yes");
		} else if ("N".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "no");
		}
		
		//접속자 IP가 설비그룹의 etc1에 매칭되었으면 해당코드번호로 바꿔줌
		SystemCommonCodeVo equipGroupCd = new SystemCommonCodeVo();
		String clientIp = Utils.getClientIP(request);
		logger.info("접속자 IP : " + clientIp);
		equipGroupCd.setBaseGroupCd("017"); //POP 모니터링 활성화&비활성화
		equipGroupCd.setEtc1(clientIp);
		equipGroupCd = systemCommonCodeService.read(equipGroupCd);
		if (equipGroupCd == null) {
			
		} else {
			session.setAttribute(Constants.POP_EQUIP_GROUP_CD, equipGroupCd.getBaseCd());		//각 POP IP별 설비그룹 매칭			
		}
		
		String userTeamCd = (String) session.getAttribute(Constants.TEAM_CD);
		model.addAttribute("userTeamCd", userTeamCd);
		String userNumber = (String) session.getAttribute(Constants.USER_NUMBER);
		model.addAttribute("userNumber", userNumber);
		
		return "po/posc2010";
	}
	
	/*//작업지시서 계획 목록조회(SLD-3공장)_OLD
	@RequestMapping(value = "/posc3010", method = RequestMethod.GET)
	public String posc3010(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("011"); // 비가동 구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("replaceFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("troubleFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052"); //공정불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053"); //원자재불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054"); //교체불량명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055"); //설비트러블불량 명
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		systemCommonCodeVo.setBaseGroupCd("064"); //POP 모니터링 활성화/비활성화
		systemCommonCodeVo.setEtc1("Y");
		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		
		HttpSession session = request.getSession(true);
		
		if (systemCommonCodeVo == null || "Y".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "yes");
		} else if ("N".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "no");
		}
		
		//접속자 IP가 설비그룹의 etc1에 매칭되었으면 해당코드번호로 바꿔줌
		SystemCommonCodeVo equipGroupCd = new SystemCommonCodeVo();
		String clientIp = Utils.getClientIP(request);
		logger.info("접속자 IP : " + clientIp);
		equipGroupCd.setBaseGroupCd("017"); //POP 모니터링 활성화&비활성화
		equipGroupCd.setEtc1(clientIp);
		equipGroupCd = systemCommonCodeService.read(equipGroupCd);
		if (equipGroupCd == null) {
			
		} else {
			session.setAttribute(Constants.POP_EQUIP_GROUP_CD, equipGroupCd.getBaseCd());		//각 POP IP별 설비그룹 매칭			
		}
		
		String userTeamCd = (String) session.getAttribute(Constants.TEAM_CD);
		model.addAttribute("userTeamCd", userTeamCd);
		String userNumber = (String) session.getAttribute(Constants.USER_NUMBER);
		model.addAttribute("userNumber", userNumber);
		
		return "po/posc3010";
	}*/
	
	
	//작업지시서 계획 목록조회(SLD-3공장 4층)
	@RequestMapping(value = "/posc3010", method = RequestMethod.GET)
	public String posc3010(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("011"); // 비가동 구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("replaceFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("troubleFaulty", systemCommonCodeList);
		
		
		//2023.01.04 추가됨
		systemCommonCodeVo.setBaseGroupCd("114"); // Strip Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty114", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("115"); // 공정 Trouble 조치 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty115", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("116"); // 치수 불량 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty116", systemCommonCodeList);
		//2023.01.04 추가됨
		
		systemCommonCodeVo.setBaseGroupCd("117"); // 바구니 무게
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("basketWeight", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("118"); // Film 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("filmFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("062"); // 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052"); //Cutting 수량
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053"); //Metal 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054"); //Film 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055"); //Teflon 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		//2023.01.04 추가됨
		systemCommonGroupVo.setBaseGroupCd("114"); //Strip Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm114", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("115"); //공정 Trouble 조치 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm115", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("116"); //치수 불량 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm116", systemCommonGroupVo.getBaseGroupCdNm());
		//2023.01.04 추가됨
		
		
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		systemCommonCodeVo.setBaseGroupCd("064"); //POP 모니터링 활성화/비활성화
		systemCommonCodeVo.setEtc1("Y");
		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		
		systemCommonCodeVo.setBaseGroupCd("093"); //생산비전불량 현황 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMajorCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); //생산비전불량 현황 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMinorCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		HttpSession session = request.getSession(true);
		
		if (systemCommonCodeVo == null || "Y".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "yes");
		} else if ("N".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "no");
		}
		
		//접속자 IP가 설비그룹의 etc1에 매칭되었으면 해당코드번호로 바꿔줌
		SystemCommonCodeVo equipGroupCd = new SystemCommonCodeVo();
		String clientIp = Utils.getClientIP(request);
		logger.info("접속자 IP : " + clientIp);
		equipGroupCd.setBaseGroupCd("017"); //POP 모니터링 활성화&비활성화
		equipGroupCd.setEtc1(clientIp);
		equipGroupCd = systemCommonCodeService.read(equipGroupCd);
		if (equipGroupCd == null) {
			
		} else {
			session.setAttribute(Constants.POP_EQUIP_GROUP_CD, equipGroupCd.getBaseCd());		//각 POP IP별 설비그룹 매칭			
		}
		
		String userTeamCd = (String) session.getAttribute(Constants.TEAM_CD);
		model.addAttribute("userTeamCd", userTeamCd);
		String userNumber = (String) session.getAttribute(Constants.USER_NUMBER);
		model.addAttribute("userNumber", userNumber);
		
		return "po/posc3010";
	}
	
	
	//작업지시서 계획 목록조회(SLD-3공장 6 층)
	@RequestMapping(value = "/posc3120", method = RequestMethod.GET)
	public String posc3120(Locale locale, Model model, HttpServletRequest request) throws Exception {
		
		logger.info("공정실적관리 작업지시선택(터치) 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("011"); // 비가동 구분
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("downtimeCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList);

		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹코드
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("052"); // 공정불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("processFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("053"); // 원자재 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("054"); // 교체불량 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("replaceFaulty", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("055"); // 설비트러블 불량상태
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("troubleFaulty", systemCommonCodeList);
		
		
		//2023.01.04 추가됨
		systemCommonCodeVo.setBaseGroupCd("114"); // Strip Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty114", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("115"); // 공정 Trouble 조치 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty115", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("116"); // 치수 불량 Loss
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("faulty116", systemCommonCodeList);
		//2023.01.04 추가됨
		
		systemCommonCodeVo.setBaseGroupCd("117"); // 바구니 무게
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("basketWeight", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("060"); // 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("118"); // Film 자재 불량유형
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("filmFaultyType", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("062"); // 선입선출
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("matrlFifoCheck", systemCommonCodeList);
		
		SystemCommonGroupVo systemCommonGroupVo = new SystemCommonGroupVo();
		systemCommonGroupVo.setBaseGroupCd("052"); //Cutting 수량
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("processFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());

		systemCommonGroupVo.setBaseGroupCd("053"); //Metal 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("matrlFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("054"); //Film 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("replaceFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("055"); //Teflon 교체 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("troubleFaultyNm", systemCommonGroupVo.getBaseGroupCdNm());
		
		//2023.01.04 추가됨
		systemCommonGroupVo.setBaseGroupCd("114"); //Strip Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm114", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("115"); //공정 Trouble 조치 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm115", systemCommonGroupVo.getBaseGroupCdNm());
		
		systemCommonGroupVo.setBaseGroupCd("116"); //치수 불량 Loss
		systemCommonGroupVo = systemCommonGroupService.read(systemCommonGroupVo);
		model.addAttribute("faultyNm116", systemCommonGroupVo.getBaseGroupCdNm());
		//2023.01.04 추가됨
		
		
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		systemCommonCodeVo.setBaseGroupCd("064"); //POP 모니터링 활성화/비활성화
		systemCommonCodeVo.setEtc1("Y");
		systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
		
		systemCommonCodeVo.setBaseGroupCd("093"); //생산비전불량 현황 대분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMajorCd", systemCommonCodeList);
		
		systemCommonCodeVo.setBaseGroupCd("094"); //생산비전불량 현황 소분류
		systemCommonCodeList = systemCommonCodeService.listAllEtc2(systemCommonCodeVo);
		model.addAttribute("visionFaultyMinorCd", systemCommonCodeList);
		
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		model.addAttribute("yesterday", DateUtil.getDay("yyyy-mm-dd",-1));
		
		HttpSession session = request.getSession(true);
		
		if (systemCommonCodeVo == null || "Y".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "yes");
		} else if ("N".equals(systemCommonCodeVo.getBaseCd())) {
			session.setAttribute(Constants.POP_MONITORING, "no");
		}
		
		//접속자 IP가 설비그룹의 etc1에 매칭되었으면 해당코드번호로 바꿔줌
		SystemCommonCodeVo equipGroupCd = new SystemCommonCodeVo();
		String clientIp = Utils.getClientIP(request);
		logger.info("접속자 IP : " + clientIp);
		equipGroupCd.setBaseGroupCd("017"); //POP 모니터링 활성화&비활성화
		equipGroupCd.setEtc1(clientIp);
		equipGroupCd = systemCommonCodeService.read(equipGroupCd);
		if (equipGroupCd == null) {
			
		} else {
			session.setAttribute(Constants.POP_EQUIP_GROUP_CD, equipGroupCd.getBaseCd());		//각 POP IP별 설비그룹 매칭			
		}
		
		String userTeamCd = (String) session.getAttribute(Constants.TEAM_CD);
		model.addAttribute("userTeamCd", userTeamCd);
		String userNumber = (String) session.getAttribute(Constants.USER_NUMBER);
		model.addAttribute("userNumber", userNumber);
		
		return "po/posc3120";
	}
	
	
	//작업지시서 계획 목록조회
	@RequestMapping(value = "/po/showMenu", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> showMenu(String showMenu, HttpSession session) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			session.removeAttribute(Constants.SHOW_MENU);
			if (showMenu.equals("yes")) {
				session.setAttribute(Constants.SHOW_MENU, "yes");
			} else if (showMenu.equals("no")) {
				session.setAttribute(Constants.SHOW_MENU, "no");
			}
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
				logger.info("showMneu 세션 컨트롤 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//작업지시서 계획 목록조회(MTP-1공장)
	@RequestMapping(value = "/po/workOrderPlanDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderPlanDataList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		workOrderVo.setFactoryCode(factoryCode);
		logger.info("MTP-1공장 - 작업지시서 계획 목록조회");
		try {
			List<WorkOrderVo> workOrderData= workOrderService.workOrderPlanDataList(workOrderVo);
			jsonData.put("data", workOrderData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업지시서 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	 
	//작업지시서 계획 목록조회(SLD-3공장)
	@RequestMapping(value = "/po/workOrderPlanDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderPlanDataList_F3(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("SLD-3공장 - 작업지시서 계획 목록조회");
		try {
			List<WorkOrderVo> workOrderData= workOrderService.workOrderPlanDataList_F3(workOrderVo);
			jsonData.put("data", workOrderData);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("SLD-3공장 - 작업지시서 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		 
		return jsonData;
	}
	
	//솔브레인SLD - 엣지검사, 외관검사 시 작지목록 조회
	@RequestMapping(value = {"/po/workOrderList_qmsc3050", "/po/workOrderList_qmsc3060"}, method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderList_F3(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("SLD-3공장 - 작업지시서 계획 목록조회");
		try {
			workOrderVo.setFactoryCode(factoryCode);
			List<WorkOrderVo> workOrderData= workOrderService.qualityWorkOrderList_F3(workOrderVo);
			jsonData.put("data", workOrderData);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("SLD-3공장 - 작업지시서 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		 
		return jsonData;
	}
	
	
	//작업지시자재상세 목록조회
	@RequestMapping(value = "/po/workOrderMatrlDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderMatrlDataList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시자재상세 목록조회 = "+ workOrderVo);
		
		try {
		List<WorkOrderVo> workOrderData= workOrderService.workOrderMatrlDataList(workOrderVo);
		jsonData.put("data", workOrderData);
		jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}
	 
	 //작업지시 제품별 자재등록정보 바코드조회 
	 @RequestMapping(value = "/po/workOrderMatrlData", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> workOrderMatrlData(WorkOrderVo workOrderVo) throws Exception {
		 Map<String, Object> jsonData = new HashMap<String, Object>();
		 logger.info("작업지시 제품별 자재등록정보 바코드조회  = "+ workOrderVo);		 
		 try {
			//해당작지에 이미 투입된 자재인지 확인
			int workDtlCheck = workOrderService.workOrderDtlCheck(workOrderVo);
			WorkOrderVo workOrderVo2 = workOrderService.workOrderFaultyStatusCheck(workOrderVo);
			if (workDtlCheck == 0) {
				WorkOrderVo workOrderData= workOrderService.workOrderMatrlData(workOrderVo);
				if(null != workOrderVo2) {
					workOrderData.setFaultyStatus(workOrderVo2.getFaultyStatus());
					workOrderData.setFaultyStatusNm(workOrderVo2.getFaultyStatusNm());
				}
				logger.info("바코드조회  = "+ workOrderData);
				if(workOrderData != null && workOrderData.getBarcodeNo() !=null) {
					
					//층 구분자 확인 코드
					/*
					if( "003".equals(factoryCode) && (!workOrderData.getFloorGubun().equals(workOrderVo.getFloorGubun())) ) {
						jsonData.put("result", "fail");				
						jsonData.put("message", "해당 코드는 " + workOrderData.getFloorGubun() + "층에서 사용하는 Lot번호 입니다." );
						return jsonData;
					}
					*/
					
					//층 구분자 확인 코드
					if( "003".equals(factoryCode) ) {
						if( workOrderData.getFloorGubun() == null || "".equals(workOrderData.getFloorGubun()) ) {
							//층 구분자가 null이거나 빈 값인 경우 투입된 층으로 Update
							MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
							matrlInOutWhsAdmVo.setLotNo(workOrderVo.getBarcodeNo());
							matrlInOutWhsAdmVo.setFloorGubun(workOrderVo.getFloorGubun());
							matrlInOutWhsAdmVo.setUpdId(Utils.getUserId());
							matrlInOutWhsAdmService.matrlInOutFloorGubunUpdate(matrlInOutWhsAdmVo);
						} else {
							//층 구분자가 다른 경우 fail
							if( !workOrderVo.getFloorGubun().equals(workOrderData.getFloorGubun()) ) {
								jsonData.put("result", "fail");				
								jsonData.put("message", "해당 코드는 " + workOrderData.getFloorGubun() + "층에서 사용하는 Lot번호 입니다." );
								return jsonData;
							}
						}
					}
					
					
					if("O".equals(workOrderData.getStatusCd()) || "P".equals(workOrderData.getStatusCd())) { // 생산투입자재도 재투입가능
						
						//if(factoryCode.equals("001") || factoryCode.equals("002")) {
						
							SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
							systemCommonCodeVo.setBaseGroupCd("102"); //작업지시 선입선출
							systemCommonCodeVo.setEtc1("Y");
							systemCommonCodeVo = systemCommonCodeService.read(systemCommonCodeVo);
							
							if( systemCommonCodeVo != null) {
								if( systemCommonCodeVo.getBaseCd().equals("001") ) {
									//선입선출 적용
									MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
									matrlInOutWhsAdmVo.setBarcodeNo(workOrderData.getBarcodeNo());
									matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
									
									String commonFifoCheck = "";
									if( "003".equals(factoryCode) ) {
										if( "001".equals(matrlInOutWhsAdmVo.getMatrlFifoCheck()) ) {
											commonFifoCheck = "Y";
										} else {
											commonFifoCheck = "N";
										}
									} else {
										commonFifoCheck = "N";
									}
									
									//선입선출 여부 확인
									if( "Y".equals(matrlInOutWhsAdmVo.getFifoCheck()) || "Y".equals(commonFifoCheck) ) {
										matrlInOutWhsAdmVo.setMatrlCd(workOrderData.getGoodsCd());
										matrlInOutWhsAdmVo.setBarcodeNo(workOrderData.getBarcodeNo());
										
										//솔브레인만 자재 선입선출 체크 기능 추가(층 구분자)
										if( "003".equals(factoryCode) ) {
											matrlInOutWhsAdmVo.setFloorGubun(workOrderVo.getFloorGubun());
										}
										
										List<MatrlInOutWhsAdmVo> fifoCheck = matrlInOutWhsAdmService.inputFifoCheck(matrlInOutWhsAdmVo);
										
										if(fifoCheck.size() == 0) {
											jsonData.put("data", workOrderData);
											jsonData.put("result", "ok");
										} else {
											//여기 else문은 선입선출이 있는 경우 알려주는 곳 임.
											
											//입고일 기준으로 D-2일 까지는 선입 선출 대상에서 제외됨(23.08.17 추가)
											SystemCommonCodeVo systemCommonCodeVo2 = new SystemCommonCodeVo();
											systemCommonCodeVo2.setBaseGroupCd("126"); //선입선출 미 대상 기간
											List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo2);
											int fifoExceptDate = Integer.parseInt(systemCommonCodeList.get(0).getBaseCdNm());
											
											//입고일 기준으로 D-2일 까지는 선입 선출 대상에서 제외됨(23.08.17 추가)
											String dateStr = matrlInOutWhsAdmVo.getInWhsDate(); // 메서드 호출을 통해 날짜 문자열을 가져옴
											LocalDate parsedDate = LocalDate.parse(dateStr, DateTimeFormatter.ofPattern("yyyyMMdd"));
											int date1 = Integer.parseInt( parsedDate.plusDays(fifoExceptDate).toString().replaceAll("-","") );
											int date2 = Integer.parseInt( DateUtil.getToday("yyyymmdd") );
											
											
											//23.09.19(솔브레인만 자재코드에 있는 선인선출 코드 사용함)
											if( "003".equals(factoryCode) ) {
												if( date1 >= date2 ) {
													//logger.info("아직 2일 안 지남");
													matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
													jsonData.put("result", "ok");
												} else {
													//자재 코드가 우선임 (자재코드에 있는 선입선출이 미적용인 경우 그냥 출력되게 적용)
													if( "002".equals(matrlInOutWhsAdmVo.getMatrlFifoCheck()) ) {
														matrlInOutWhsAdmVo.setPreOutQty(matrlInOutWhsAdmVo.getRemainQty());
														jsonData.put("result", "ok");
													} else {
														//logger.info("2일 지남");
														jsonData.put("result", "fail");
														jsonData.put("message", "이전에 출고된 바코드가 존재합니다.<br>자재를 확인해주세요.");
													}
												}
											} else {
												//머티 1공장, 2공장은 그대로 사용
												jsonData.put("result", "fail");				
												jsonData.put("message", "이전에 출고된 바코드가 존재합니다.<br>자재를 확인해주세요.");
											}
											//23.09.19(솔브레인만 자재코드에 있는 선인선출 코드 사용함)
											
											
											/* 이전에 사용했던 조건임
											jsonData.put("result", "fail");				
											jsonData.put("message", "이전에 출고된 바코드가 존재합니다.<br>자재를 확인해주세요.");
											*/
											
											//여기 else문은 선입선출이 있는 경우 알려주는 곳 임.
										}
									} else {
										jsonData.put("data", workOrderData);
										jsonData.put("result", "ok");
									}
								} else {
									//선입선출 미적용
									jsonData.put("data", workOrderData);
									jsonData.put("result", "ok");
								}
							} else {
								//선입선출 에러
								jsonData.put("message", "시스템공통코드관리 기초코드 102번</br>체크여부를 확인해주세요.");
								jsonData.put("result", "fail");
							}
						/*} else if( factoryCode.equals("003") ) {
							jsonData.put("data", workOrderData);
							jsonData.put("result", "ok");
						} else {
							 jsonData.put("message", "가출고 또는 재투입 상태 자재 바코드가 아닙니다.</br>자재 바코드를 확인해 주세요.");
							 jsonData.put("result", "error");
						}*/
						
					} else {
						 jsonData.put("message", "가출고 또는 재투입 상태 자재 바코드가 아닙니다.</br>자재 바코드를 확인해 주세요.");
						 jsonData.put("result", "fail");					
					}
					
				} else {
					 jsonData.put("message", "제품에 투입할 자재 바코드가 아닙니다.</br>자재 바코드를 확인해 주세요.");
					 jsonData.put("result", "fail");	
			 	}
			
			} else {
				jsonData.put("message", "이미 해당작지에 투입된 자재입니다.<br>삭제 후 저장한 다음 다시 스캔하여 주세요!");
				jsonData.put("result", "fail");
			}
			
			

		 } catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "제품에 투입할 자재 바코드가 아닙니다.</br>자재 바코드를 확인해 주세요!");
			jsonData.put("result", "error");
		 }
		 return jsonData;
	}

	//작업지시 제품별 자재등록정보 바코드조회 
	@RequestMapping(value = "/po/checkWorkOrdStatus", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkWorkOrdStatus(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 현재 상태 확인 " + workOrderVo);
		try {
			String frontWorkStatusCd = workOrderVo.getWorkStatusCd();
			WorkOrderVo readWorkOrderVo = new WorkOrderVo();

			readWorkOrderVo = workOrderService.read(workOrderVo);
			
			if (frontWorkStatusCd.equals(readWorkOrderVo.getWorkStatusCd())) {
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "작업지시 상태가 변경되었습니다.<br>다시 선택해 주세요!");
				jsonData.put("result", "fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//작업지시 _엣지 & 외관 검사가 등록되어있는지 확인
	@RequestMapping(value = "/po/workOrdOutputSubCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrdOutputSubReadCheck(WorkOrdOutputSubVo workOrdOutputSubVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 현재 상태 확인 ");
		try {
			
			/*WorkOrdOutputSubVo workOrdOutputSubDtlVo = new WorkOrdOutputSubVo();
			workOrdOutputSubDtlVo =	workOrdOutputSubService.workOrdOutputSubRead(workOrdOutputSubVo);
			
			logger.info("logger.info(workOrdOutputSubDtlVo); ----------> " +workOrdOutputSubDtlVo);
			logger.info("logger.info(workOrdOutputSubDtlVo); ----------> " +workOrdOutputSubDtlVo.getOrdLotNo());
			
			if(workOrdOutputSubDtlVo.getOrdLotNo().equals("") || workOrdOutputSubDtlVo.getOrdLotNo() == null) {
				jsonData.put("result", "ok");
			}else {
				jsonData.put("message", "엣지검사 또는 외관검사가 등록되어있습니다!");
				jsonData.put("result", "fail");
			}*/
			
			List<WorkOrdOutputSubVo> workOrdOutputSubList =	workOrdOutputSubService.checkWorkOrdLotNo(workOrdOutputSubVo);
			
			logger.info("workOrdOutputSubList ----------> " +workOrdOutputSubList);
			logger.info("workOrdOutputSubList ----------> " +workOrdOutputSubList.size());
			
			if(workOrdOutputSubList.size() == 0) {
				jsonData.put("result", "ok");
			}else {
				jsonData.put("message", "생산실적(엣지or외관)이 입력되어있는 작업지시는 진행 취소하실 수 없습니다!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	

	//작업지시 자재상세 불량 등록 상태값 변경 
	@RequestMapping(value = "/po/WorkOrdDtlFaultyStatusChange", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> WorkOrdDtlFaultyStatusChange(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 현재 상태 확인 " + workOrderVo);
		try {
			WorkOrderVo workOrderVo2 = new WorkOrderVo();
//			workOrderVo2 = workOrderService.workOrderFaultyStatusCheck(workOrderVo);
			
			//불량 -> 정상 or 재불량 -> 불량재투입 (불량 취소)
			/*if ( "001".equals(workOrderVo.getFaultyStatus()) || "003".equals(workOrderVo.getFaultyStatus()) ) {
				if( workOrderVo2.getApprovalCd().equals("001") ) {
					workOrderVo.setUpdId(Utils.getUserId());
					workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
					jsonData.put("result", "ok");
				} else {
					jsonData.put("message", "자재가 이미 불량등록된 상태입니다!");
					jsonData.put("result", "fail");
					return jsonData;
				}
			} 
			//정상 -> 불량 or 불량재투입 -> 재불량 (불량 등록)
			else if( "002".equals(workOrderVo.getFaultyStatus()) || "004".equals(workOrderVo.getFaultyStatus())) {
				workOrderVo.setUpdId(Utils.getUserId());
				workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "잘못된 값 입니다. 새로고침 후 다시 시도해주세요!");
				jsonData.put("result", "fail");
			}*/
			
			//발행상태의 작지일 경우 상태확인 X
			/*if ("001".equals(workOrderVo.getFaultyStatus())) {
				workOrderVo.setUpdId(Utils.getUserId());
				workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
				jsonData.put("result", "ok");
			} else if ("002".equals(workOrderVo.getFaultyStatus())) {
				workOrderVo.setUpdId(Utils.getUserId());
				workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
				jsonData.put("result", "ok");
			} else if ("004".equals(workOrderVo.getFaultyStatus())) {
				workOrderVo.setUpdId(Utils.getUserId());
				workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
				jsonData.put("result", "ok");
			} else {
				jsonData.put("message", "자재가 이미 불량등록된 상태입니다!");
				jsonData.put("result", "fail");
			}*/
			
			workOrderVo.setUpdId(Utils.getUserId());
			workOrderService.updateWorkOrdFaultyStatus(workOrderVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	 
	 
	//작업지시 등록 또는 수정 -> 생산실적 주자재 기준으로 변경 후 수정만
	@RequestMapping(value = "/po/workOrderCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderCreate(@RequestBody List<Map<String, Object>> workOrder) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 등록 또는 수정 = "+ workOrder);
		
		try {
			//자재 상태체크 로직
			boolean matrlStatusCheck = true;
			
			JSONArray jsonArray = new JSONArray();
			JSONObject jsonObj = new JSONObject();
			
			for(Map<String, Object> m : workOrder) {
				//이미 스캔된 자재(투입된자재) 자재상태검사를 하지 않음.
				if (m.get("regDate") != null && m.get("regDate").toString().length() > 8) {
					
					
				} else {
					
					MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
					matrlInOutWhsAdmVo.setLotNo(m.get("lotNo").toString());
					matrlInOutWhsAdmVo = matrlInOutWhsAdmService.read(matrlInOutWhsAdmVo);
					
					//WorkOrderVo workOrderVo = new WorkOrderVo();
					//workOrderVo.setLotNo(m.get("lotNo").toString());
					//해당자재가 재투입된 개수
					//int count = workOrderService.workOrderDtlCount(workOrderVo);
					
					//신규투입일
					if ("N".equals(m.get("remakeYn").toString()) ) {
						if ("O".equals(matrlInOutWhsAdmVo.getStatusCd())) {	//신규투입일때 상태가 O(가출고) -> 정상
							
							//신규투입 현재자재상태 정상이면 배열에 넣기
							jsonObj = new JSONObject();
							jsonArray.add(m.get("lotNo").toString());
							
						} else {
							matrlStatusCheck = false;
							break;
						}
					
					//재투입일 경우
					} else if ("Y".equals(m.get("remakeYn").toString()) ) {	//재투입일때 상태가 P(생산투입) -> 정상
						
						//현재검사한 LotNo가 배열에 있을경우 아래 if문 안타게
						if ("P".equals(matrlInOutWhsAdmVo.getStatusCd())) {
							//
						} else {
							for(int i=0; i<jsonArray.size(); i++){
								jsonObj.put(i, jsonArray.get(i));
								
								/*logger.info("jsonData -> " +jsonObj);
								logger.info("jsonData iiii -> " +jsonObj.get(i));
								
								logger.info("jsonArray iiii -> " +jsonArray.get(i));
								
								logger.info("m lotNo -> " +m.get("lotNo").toString());*/
								
								if (jsonArray.get(i).equals("F")) {
									if(!m.get("lotNo").toString().equals(jsonArray.get(i))) {
										matrlStatusCheck = false;
										break;
									}
								}
							}
						}
					}
				}
			}
			
			//자재상태 정상
			if (matrlStatusCheck) {
				WorkOrderVo workOrderVo = new WorkOrderVo();
				//workOrderService.workOrderMatrlData(workOrderVo);
				int idx = 0;
				
				boolean factoryCodeCheck = true; 
						
				//투입자재내역 삭제 일 경우 삭제자재가 신규투입일 경우 재투입내역 먼저 삭제하라고 알려줘야 함!
				for(Map<String, Object> m : workOrder) {
					logger.debug("m ===> : " + m);
					workOrderVo.setWorkOrdNo(m.get("workOrdNo").toString());
					workOrderVo.setGoodsCd(m.get("goodsCd").toString());
					workOrderVo.setEquipCd(m.get("equipCd").toString());
					workOrderVo.setEquipCondSeq(m.get("equipCondSeq").toString());
					workOrderVo.setDealCorpCd(m.get("dealCorpCd").toString());
					workOrderVo.setOrdDate(m.get("ordDate").toString());
					workOrderVo.setWorkTeamCd(m.get("workTeamCd").toString());
					//workOrderVo.setMainWorkChargr(m.get("mainWorkChargr").toString());
					//workOrderVo.setSubWorkChargr(m.get("subWorkChargr").toString());
					workOrderVo.setOrdLotNo(m.get("ordLotNo").toString());
					
					//MTP 1공장(성남)
					if ("001".equals(factoryCode)) {
						//workOrderVo.setOrdGubun(workOrderVo.getOrdLotNo().substring(13,14));
						
					//MTP 2공장(성남)
					} else if ("002".equals(factoryCode)) {
						//미정
						
					//SLD 3공장(파주)
					} else if ("003".equals(factoryCode)) {
						//workOrderVo.setOrdGubun(workOrderVo.getOrdLotNo().substring(14,15));
					} else {
						factoryCodeCheck = false;
						break;
					}
					
					workOrderVo.setWorkStatusCd(m.get("workStatusCd").toString());
					workOrderVo.setLotNo(m.get("lotNo").toString());
					workOrderVo.setBarcodeNo(m.get("barcodeNo").toString());
					workOrderVo.setInspectQty(m.get("inspectQty").toString());
					workOrderVo.setFairQty(m.get("fairQty").toString());
					workOrderVo.setFaultyQty(m.get("faultyQty").toString());
					workOrderVo.setConnectCd(m.get("connectCd").toString());
					
					if(m.get("regDate") != null && m.get("regDate").toString().length() > 8) {
						workOrderVo.setRegDate(m.get("regDate").toString());
					} else {
						workOrderVo.setRegDate(DateUtil.getDay("yyyy-mm-dd hh:mm:ss", 0));
					}
					workOrderVo.setRemakeYn(m.get("remakeYn").toString());
					workOrderVo.setMatrlCd(m.get("matrlCd").toString());
					workOrderVo.setTargetWeight(m.get("targetWeight").toString());
					workOrderVo.setChangeLocation(m.get("changeLocation").toString());
					workOrderVo.setRegId(Utils.getUserId());
					workOrderVo.setUpdId(Utils.getUserId());
					workOrderVo.setFaultyStatus(m.get("faultyStatus").toString());
					logger.info("로그인 ID : " + Utils.getUserId());
					if("B".equals(workOrderVo.getWorkStatusCd()) || "P".equals(workOrderVo.getWorkStatusCd()) || "S".equals(workOrderVo.getWorkStatusCd()) || "C".equals(workOrderVo.getWorkStatusCd()) ) { //작지상태 P 발행 , S 진행, C 완료 저장하기전 기존데이터 라인삭제 후 저장하면 어케됨?
						if( idx == 0 ) { //자재상세 삭제 후 등록
							
							//신규투입건에 한해서 DTL삭제 시 수불테이블로 원복
							//SELECT * FROM TB_WORK_ORDER_DTL
							//WHERE WORK_ORD_NO = 'LS11S220414-001'
							//AND REMAKE_YN != 'Y'
							//->이 자재들 생산창고에 재고에 +
							stockPaymentAdmService.workOrdStockPaymentPuls(workOrderVo);	//기존 위치 재고 -
							
							workOrderService.updatePreOutWhsStatus(workOrderVo); //해당작지의 최초투입 자재는 삭제전 입고자재 가출고 상태로 변경
							workOrderService.deleteWorkOrderDtl(workOrderVo);
						}
						
						workOrderService.createWorkOrderDtl(workOrderVo);
						
						//logger.info("m---------------> " +m.size());
						
						if( m.get("workStatusCd").toString().equals("S") || m.get("workStatusCd").toString().equals("C") ) {
							//작지가 진행중에 필름이 추가 저장될때 트레이 필름 부 Update
							ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
							productionPerfTrayVo.setWorkOrdNo( m.get("workOrdNo").toString() );
							productionPerfTrayVo.setFilmLotNo( m.get("filmLotNo").toString() );
							productionPerfTrayVo.setMatrlLotNo( m.get("matrlLotNo").toString() );
							productionPerfTrayVo.setUpdId( Utils.getUserId() );
							//생산실적 트레이 필름 수정
							productionPerfTrayService.productionPerfTrayFilmLotUpdate(productionPerfTrayVo);
						}
						
					} else {
						jsonData.put("data", workOrder);
						jsonData.put("message", "작지상태가 미발행 또는 발행 상태인 경우</br> 등록 및 수정이 가능 합니다.");
						jsonData.put("result", "fail");
					}
					idx++;
				}
				
				if (factoryCodeCheck) {
					if("B".equals(workOrderVo.getWorkStatusCd())) {			//등록
						workOrderVo.setWorkStatusCd("P");					//작지 발행상태로 변경
						workOrderService.updateWorkOrder(workOrderVo);
						//workOrderService.createWorkOrder(workOrderVo);
						workOrderService.updateOutWhsStatus(workOrderVo);	//자재 출고상태로 변경
						
					} else if("P".equals(workOrderVo.getWorkStatusCd())) {	//수정
						workOrderService.updateWorkOrder(workOrderVo);
						workOrderService.updateOutWhsStatus(workOrderVo);	//자재 출고상태로 변경
						
					} else if("S".equals(workOrderVo.getWorkStatusCd()) || "C".equals(workOrderVo.getWorkStatusCd())) {	//수정
						workOrderService.updateWorkOrder(workOrderVo);
						workOrderService.updateOutWhsStatus(workOrderVo);	//자재 출고상태로 변경
					}
					
					//신규투입건에 한해서 DTL삭제 시 수불테이블로 원복
					//SELECT * FROM TB_WORK_ORDER_DTL
					//WHERE WORK_ORD_NO = 'LS11S220414-001'
					//AND REMAKE_YN != 'Y'
					//->이 자재들 생산창고에 재고에 -
					
					//수불 등록
					//StockPaymentAdmVo stockPaymentAdmVoMinus = new StockPaymentAdmVo();
					//StockPaymentAdmVo stockPaymentAdmVoPlus = new StockPaymentAdmVo();
					//stockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(matrlInOutWhsAdmVo, "O", factoryCode);
					stockPaymentAdmService.workOrdStockPaymentMinus(workOrderVo);	//기존 위치 재고 -
					//stockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
					//stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVoPlus);	//새 위치 재고 +
					
					
					jsonData.put("data", workOrder);
					jsonData.put("result", "ok");
					
				} else {
					jsonData.put("message", "공장코드 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc3010_001");
					jsonData.put("result", "fail");
				}
				
			//자재상태 이상
			} else {
				jsonData.put("message", "자재상태가 변경되었습니다.<br>다시 스캔해 주세요!");
				jsonData.put("result", "fail");
			}
			
		} catch (Exception e) {
			logger.info("작업지시 등록 또는 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	 }
	 
	//작업지시 상태수정
	@RequestMapping(value = "/po/workOrderUpdateStatus", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderUpdateStatus(WorkOrderVo workOrderVo, TotalFaultyAdmVo totalFaultyAdmVo, MatrlUserVo matrlUserVo, MenuAuthVo menuAuthVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<>();
		logger.info("작업지시 상태수정 - " + workOrderVo);
		workOrderVo.setUpdId(Utils.getUserId());
		try {
			//계정체크용
			MatrlUserVo userVo = matrlUserService.userAuthDeleteCheck_F1F2F3(matrlUserVo);
			WorkOrderVo readWorkOrderVo = new WorkOrderVo();
			readWorkOrderVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			readWorkOrderVo = workOrderService.read(readWorkOrderVo);
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo().toString());
			menuAuthVo.setLotNo(workOrderVo.getWorkOrdNo());
			menuAuthVo.setUseUserId(matrlUserVo.getUserId());
			menuAuthVo.setLoginUserId(Utils.getUserId());
			
			//2공장 트레이 생산 기능 잠금 O
			if(factoryCode.equals("002")) {
				Settings singletonSettings = Settings.getInstance();
				if( singletonSettings.lockTrayProduce ) {
					SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
					systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
					systemCommonCode.setBaseCd("002");	//제푸 포장Lock
					systemCommonCode = systemCommonCodeService.read(systemCommonCode);
					jsonData.put("message", systemCommonCode.getEtc1());
					jsonData.put("result", "lock");
					return jsonData;								
				}
			}
			
			//미발행 작업지시 삭제
			if (workOrderVo.getWorkStatusCd().equals("delete")) {
				//미발행 or 발행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("B") && !readWorkOrderVo.getWorkStatusCd().equals("P")) {
					jsonData.put("message", "미발행 또는 발행 상태의 작지만 삭제할 수 있습니다.<br>작지상태를 확인해주세요!");
					jsonData.put("result", "fail");
					
				//미발행일 경우 별도의 확인 없이 바로 삭제
				} else if (readWorkOrderVo.getWorkStatusCd().equals("B")) {
					workOrderService.deleteWorkOrdNo(readWorkOrderVo);
					jsonData.put("message", "삭제되었습니다.");
					jsonData.put("result", "ok");
				
				//발행일 경우 생산실적(초,중물), 불량중량 등록되어있는지 확인
				} else if (readWorkOrderVo.getWorkStatusCd().equals("P")) {
					//주자재별로 초,중물이 모두 입력되었는지 확인
					AgtVo agtVo = new AgtVo();
					agtVo.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
					List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck(agtVo);
					boolean checkAgtStep = false;
					String agtStepMessage = "";
					int temp = 0; //안내메시지<br> 추가여부 판단
					for (int i = 0; i < countAgtStepCheckList.size(); i++) {
						if (countAgtStepCheckList.get(i).getCountStep001() != 0) {
							if (temp > 0) {
								agtStepMessage += "<br>";
							}
							agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 초물이 입력되어 있습니다!";
							temp++;
							checkAgtStep = true;
						}
						if (countAgtStepCheckList.get(i).getCountStep002() != 0) {
							if (temp > 0) {
								agtStepMessage += "<br>";
							}
							agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 중물이 입력되어 있습니다!";
							temp++;
							checkAgtStep = true;
						}
					}
					
					//주자재별로 생산실적이 입력되었는지 확인
					List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
					boolean checkLotNoOutputSub = false;
					String outputMessage = "";
					int temp1 = 0; //안내메시지<br> 추가여부 판단
					for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
						if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() != 0) {
							if (temp1 > 0) {
								outputMessage += "<br>";
							}
							outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!";
							temp1++;
							checkLotNoOutputSub = true;
						}
					}
					
					//불량중량 입력확인
					AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
					allFaultyAdmVo.setEquipCd(totalFaultyAdmVo.getEquipCd());
					allFaultyAdmVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
					List<AllFaultyAdmVo> allFaultyAdmVoList = allFaultyAdmService.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);
					//발행 상태가 맞는지 확인
					if (!readWorkOrderVo.getWorkStatusCd().equals("P")) {
						jsonData.put("message", "미발행 또는 발행 상태의 작업지시만 삭제 하실 수 있습니다!");
						jsonData.put("result", "fail");
		
					//초,중물이 입력되었는지 확인
					} else if (checkAgtStep) {
						jsonData.put("message", agtStepMessage);
						jsonData.put("result", "fail");
						
					//생산실적이 입력되었는지 확인
					} else if (checkLotNoOutputSub) {
						jsonData.put("message", outputMessage);
						jsonData.put("result", "fail");
		
					//불량중량이 입력되었는지 확인
					} else if (!allFaultyAdmVoList.isEmpty()) {
						String message = "";
						for (int i = 0; i < allFaultyAdmVoList.size(); i++) {
							String faultyRegDate = allFaultyAdmVoList.get(i).getFaultyRegDate();
							message += faultyRegDate.substring(0, 4) + "-" + faultyRegDate.substring(4, 6) + "-" + faultyRegDate.substring(6, 8) + "<br>";
						}
						jsonData.put("message", message + "해당 날짜에 불량중량이 등록되어있습니다!<br>불량중량이 입력된 작업지시는 취소 할 수 없습니다!");
						jsonData.put("result", "fail");
		
					//작업지시 삭제 진행
					} else {
						//재투입 자재일 경우 그냥 삭제하면 되지만 신규투입 자재일 경우 다른 작업지시에 재투입되었는지 확인 후 삭제해야함
						//신규투입일 경우 삭제 후 자재상태 O로 돌려줘야함
						List<WorkOrderVo> workOrderMatrlDataList = workOrderService.workOrderMatrlDataList(readWorkOrderVo);
						boolean checkWorkOrdDlt = false;
						String failMessage = "";
						int temp2 = 0; //안내메시지<br> 추가여부 판단
						for (int i=0; i<workOrderMatrlDataList.size(); i++) {
							if ("N".equals(workOrderMatrlDataList.get(i).getRemakeYn())) {
								WorkOrderVo remakeDtl = new WorkOrderVo();
								remakeDtl.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
								remakeDtl.setLotNo(workOrderMatrlDataList.get(i).getLotNo());
								List<WorkOrderVo> remakeDtlList = workOrderService.reamkeWorkOrderDtlList(remakeDtl);
								for (int j=0; j<remakeDtlList.size(); j++) {
									if (temp2 > 0) {
										failMessage += "<br>";
									}
									failMessage += remakeDtlList.get(j).getLotNo() + " 자재가 " + remakeDtlList.get(j).getWorkOrdNo() + "에 재투입되어 있습니다!";
									temp2++;
									checkWorkOrdDlt = true;
								}
							}
						}
						
						//DTL 불량상태가 불량인 경우 삭제 불가
						for (int i=0; i<workOrderMatrlDataList.size(); i++) {
							//불량상태가 불량이면
							if ("002".equals(workOrderMatrlDataList.get(i).getFaultyStatus())) {
								if (temp2 > 0) {
									failMessage += "<br>";
								}
								failMessage += workOrderMatrlDataList.get(i).getLotNo() + "는 불량상태가 불량(자재불량 등록)한 상태입니다!";
								checkWorkOrdDlt = true;
							}
						}
						
						if (checkWorkOrdDlt) {
							jsonData.put("message", failMessage);
							jsonData.put("result", "fail");
						} else {
							//권한이 있는 사용자인지 확인
							if( userVo == null ) {
								jsonData.put("result", "fail");
								jsonData.put("message", "권한이 없는 계정입니다.");				
							} else if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {				 
								jsonData.put("result", "fail");
								jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
							//로그인 불가
							} else {							
								//삭제 권한사용 로그처리
								menuAuthVo.setUseAuthCode("001");
								menuAuthService.userAuthUseHist_F1F2F3(menuAuthVo);
								workOrderService.updatePreOutWhsStatus(readWorkOrderVo);	//해당작지의 최초투입 자재는 삭제전 입고자재 가출고 상태로 변경
								workOrderService.deleteWorkOrderDtl(readWorkOrderVo);		//자재 투입내역 삭제
								workOrderService.deleteWorkOrdNo(readWorkOrderVo);			//작업지시 삭제
								
								//신규투입일 경  생산창고로 수불 +
								for (int i=0; i<workOrderMatrlDataList.size(); i++) {
									if ("N".equals(workOrderMatrlDataList.get(i).getRemakeYn())) {
										//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
										//기존LotNo 가출고상태로 변경하였으니 자재 생산실창고(004)에 다시 + 해줌
										MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
										matrlInOutWhsAdmVo.setBarcodeNo(workOrderMatrlDataList.get(i).getBarcodeNo());
										matrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(matrlInOutWhsAdmVo);
										StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
										matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, factoryCode);
										stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
									}
								}
								jsonData.put("message", "삭제되었습니다.");
								jsonData.put("result", "ok");	
							}
						}
					}
				}
				
			//업데이트 할 상태가 진행 상태라면
			} else if (workOrderVo.getWorkStatusCd().equals("S")) {				
				//작업완료 취소일 때
				if (readWorkOrderVo.getWorkStatusCd().equals("C")) {
					//권한이 있는 사용자인지 확인
					if( userVo == null ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "권한이 없는 계정입니다.");				
					} else if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {				 
						jsonData.put("result", "fail");
						jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
					//로그인 불가
					} else {
						
						//발행 상태가 맞는지 확인
						if (readWorkOrderVo.getWorkStatusCd().equals("C")) {							
							WorkOrderVo countWorkingWorkOrd = workOrderService.checkWorkingWorkOrd(readWorkOrderVo);
							//if (countWorkingWorkOrd.getCountWorkingWorkOrd() == 0) 
							if(countWorkingWorkOrd == null) {
								//완료취소 권한사용 로그처리
								menuAuthVo.setUseAuthCode("002");
								menuAuthService.userAuthUseHist_F1F2F3(menuAuthVo);
								workOrderVo.setUpdateGubun("U");
								workOrderService.updateWorkOrderStatus(workOrderVo);
								
								//(트레이)생산 실적 삭제 시작
								//기존 생산 실적 서브 삭제
								workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
								workOrdOutputSubVo.setOrdLotNo(workOrderVo.getWorkOrdNo() + "-T");
								workOrdOutputSubService.appearAndEdgeCheckDelete_F3(workOrdOutputSubVo);
								//(트레이)생산 실적 삭제 종료
								
								jsonData.put("message", "변경되었습니다.");
								jsonData.put("result", "ok");
							} else {
								//jsonData.put("message", "해당 설비의 진행중인 작업지시가 " + countWorkingWorkOrd + "개 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
								jsonData.put("message", "해당 설비의 '" +countWorkingWorkOrd.getWorkOrdNo()+ "' 작업지시가 진행중에 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
								jsonData.put("result", "fail");
							}	
							
						} else {
							jsonData.put("message", "발행상태 작지만 시작할 수 있습니다.<br>작지상태를 확인해주세요!");
							jsonData.put("result", "fail");
						}
						
					}
				} else if ( readWorkOrderVo.getWorkStatusCd().equals("P") ) { //작지발행일 때

					//해당설비의 24시간 이내의 진행중인 작지가 있는지 확인
					WorkOrderVo countWorkingWorkOrd = workOrderService.checkWorkingWorkOrd(readWorkOrderVo);
					//if (countWorkingWorkOrd.getCountWorkingWorkOrd() == 0) 
					if(countWorkingWorkOrd == null) {
						workOrderVo.setUpdateGubun("S");
						workOrderService.updateWorkOrderStatus(workOrderVo);
						
						//1공장 트레이 생산 부분
						ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
						productionPerfTrayVo.setEquipCd(workOrderVo.getEquipCd());
						productionPerfTrayVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						productionPerfTrayVo.setArrayData(workOrderVo.getArrayData());
						productionPerfTrayCreate(productionPerfTrayVo);
						//1공장 트레이 생산 부분 끝
						
						jsonData.put("message", "시작되었습니다.");
						jsonData.put("result", "ok");
						
					} else {
						//jsonData.put("message", "해당 설비의 진행중인 작업지시가 " + countWorkingWorkOrd + "개 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("message", "해당 설비의 '" +countWorkingWorkOrd.getWorkOrdNo()+ "' 작업지시가 진행중에 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("result", "fail");
					}
				}

			//업데이트 할 상태가 진행 취소라면
			} else if (workOrderVo.getWorkStatusCd().equals("P")) {
				//주자재별로 초,중물이 모두 입력되었는지 확인
				AgtVo agtVo = new AgtVo();
				agtVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
				List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck(agtVo);
				boolean checkAgtStep = false;
				String agtStepMessage = "";
				int temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < countAgtStepCheckList.size(); i++) {
					if (countAgtStepCheckList.get(i).getCountStep001() != 0) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 초물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					}
					if (countAgtStepCheckList.get(i).getCountStep002() != 0) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 중물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					}
				}

				//주자재별로 생산실적이 입력되었는지 확인
				List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				boolean checkLotNoOutputSub = false;
				String outputMessage = "";
				temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
					if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() != 0) {
						if (temp > 0) {
							outputMessage += "<br>";
						}
						outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!";
						temp++;
						checkLotNoOutputSub = true;
					}
				}
				//WorkOrdOutputSubVo WorkOrdOutputSubVo = new WorkOrdOutputSubVo();
				//WorkOrdOutputSubVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
				//int outputSubCount = workOrdOutputSubService.checkWorkOrdOutputSub(WorkOrdOutputSubVo); 	 			

				//불량중량 입력확인
				AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
				allFaultyAdmVo.setEquipCd(totalFaultyAdmVo.getEquipCd());
				allFaultyAdmVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
				List<AllFaultyAdmVo> allFaultyAdmVoList = allFaultyAdmService.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);

				//진행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("S")) {
					jsonData.put("message", "발행상태 작업지시만 취소할 수 있습니다.<br>작업지시 상태를 확인해주세요!");
					jsonData.put("result", "fail");

				//초,중물이 입력되었는지 확인
				} else if (checkAgtStep) {
					jsonData.put("message", agtStepMessage);
					jsonData.put("result", "fail");

				//생산실적이 입력되었는지 확인
				} else if (checkLotNoOutputSub) {
					jsonData.put("message", outputMessage);
					jsonData.put("result", "fail");

				//불량중량이 입력되었는지 확인
				} else if (!allFaultyAdmVoList.isEmpty()) {
					String message = "";
					for (int i = 0; i < allFaultyAdmVoList.size(); i++) {
						String faultyRegDate = allFaultyAdmVoList.get(i).getFaultyRegDate();
						message += faultyRegDate.substring(0, 4) + "-" + faultyRegDate.substring(4, 6) + "-" + faultyRegDate.substring(6, 8) + "<br>";
					}
					jsonData.put("message", message + "해당 날짜에 불량중량이 등록되어있습니다!<br>불량중량이 입력된 작업지시는 취소 할 수 없습니다!");
					jsonData.put("result", "fail");

				//작지 진행 취소 실행
				} else {
					//작지 발행(P)로 변경, 생산실적수량 초기화
					workOrderService.updateWorkOrderStatus(workOrderVo);
					
					//검사 상태 값 Update
					if(factoryCode.equals("002")) {
						WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo(); 
						
						//빈값으로 상태값 Update
						WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
						WorkOrderStatusCheckVo.setWorkInspectionStatusCd(""); // "" -> 값 없음, S -> 진행, C-> 완료
						logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
						workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
						
						//작업자 삭제
						WorkerChangeVo workerChangeVo = new WorkerChangeVo();
						workerChangeVo.setEquipCd(workOrderVo.getEquipCd());
						workerChangeVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
						workerChangeVo.setUpdId(Utils.getUserId());
						workOrderService.workerChangeDelete(workerChangeVo);
					}
					//검사 상태 값 Update
					
					if( factoryCode.equals("001") || factoryCode.equals("002")) {
						//트레이 삭제
						ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
						productionPerfTrayVo.setEquipCd(workOrderVo.getEquipCd());
						productionPerfTrayVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
						productionPerfTrayService.productionPerfTrayDelete(productionPerfTrayVo);
					}
					
					jsonData.put("data", workOrderVo);
					jsonData.put("message", "진행 취소되었습니다.");
					jsonData.put("result", "ok");
				}

			//업데이트 할 상태가 종료 상태라면
			} else if (workOrderVo.getWorkStatusCd().equals("C")) {
				
				//주자재별로 생산실적이 입력되었는지 확인
				List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				boolean checkLotNoOutputSub = false;
				String outputMessage = "";
				int temp = 0; //안내메시지<br> 추가여부 판단
				/*for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
					if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() == 0) {
						if (temp > 0) {
							outputMessage += "<br>";
						}
						outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적을 입력해 주세요!";
						temp++;
						checkLotNoOutputSub = true;
					}
				}*/
				
				//해당 작지의 생산전표번호 모두 초or중물이 입력되었는지 확인
				AgtVo agtVo = new AgtVo();
				agtVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
				List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck(agtVo);
				boolean checkAgtStep = false;
				String agtStepMessage = "";
				temp = 0; //안내메시지<br> 추가여부 판단
				/*for (int i = 0; i < countAgtStepCheckList.size(); i++) {
					if (countAgtStepCheckList.get(i).getStepCd() == null) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += countAgtStepCheckList.get(i).getOrdLotNo() + " 생산전표번호의 초물 또는 중물을 입력해 주세요!";
						temp++;
						checkAgtStep = true;
					}
					//if (countAgtStepCheckList.get(i).getCountStep001() == 0) {
					//	if (temp > 0) {
					//		agtStepMessage += "<br>";
					//	}
					//	agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 초물을 입력해 주세요!";
					//	temp++;
					//	checkAgtStep = true;
					//}
					//if (countAgtStepCheckList.get(i).getCountStep002() == 0) {
					//	if (temp > 0) {
					//		agtStepMessage += "<br>";
					//	}
					//	agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 중물을 입력해 주세요!";
					//	temp++;
					//	checkAgtStep = true;
					//}
				}*/

				//진행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("S")) {
					jsonData.put("message", "진행상태 작지만 종료할 수 있습니다.<br>작지상태를 확인해주세요!");
					jsonData.put("result", "fail");
					
				//주자재별로 초중물 미등록시
				} else if (checkAgtStep) {
					jsonData.put("message", agtStepMessage);
					jsonData.put("result", "fail");
				
				//주자재별로 생산실적 미등록시
				} else if (checkLotNoOutputSub) {
					jsonData.put("message", outputMessage);
					jsonData.put("result", "fail");
				
				} else {
					//MTP 1공장(성남)
					if ("001".equals(factoryCode)) {
						//주간조일 때
						//if (workOrderVo.getWorkOrdNo().substring(13, 14).equals("1") || workOrderVo.getWorkOrdNo().substring(13, 14).equals("2")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//주간불량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getDayTotalPrcssSum() == 0 && totalFaultyAdmVo.getDayTotalMatrlSum() == 0 && totalFaultyAdmVo.getDayTotalReplaceSum() == 0 && totalFaultyAdmVo.getDayTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");	
							//} else {
						
						ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
						
						if( !productionPerfTrayController.trayFaultyRelatedCreate(workOrderVo.getWorkOrdNo()) ) {
							workOrderService.updateWorkOrderStatus(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("message", "종료되었습니다.");
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", "생산실적 등록&수정 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc2010_003");
							jsonData.put("result", "fail");
							return jsonData;
						}
							//}

						//야간조일 때, 야간불량 미등록 시
						//} else if (workOrderVo.getWorkOrdNo().substring(13, 14).equals("3") || workOrderVo.getWorkOrdNo().substring(13, 14).equals("4")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//야간량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getNightTotalPrcssSum() == 0 && totalFaultyAdmVo.getNightTotalMatrlSum() == 0 && totalFaultyAdmVo.getNightTotalReplaceSum() == 0 && totalFaultyAdmVo.getNightTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else {
							//workOrderService.updateWorkOrderStatus(workOrderVo);
							//jsonData.put("data", workOrderVo);
							//jsonData.put("message", "종료되었습니다.");
							//jsonData.put("result", "ok");
							//}
						//}
						
					//MTP 2공장(성남)
					} else if ("002".equals(factoryCode)) {
						workOrderService.updateWorkOrderStatus(workOrderVo);
						jsonData.put("data", workOrderVo);
						jsonData.put("message", "종료되었습니다.");
						jsonData.put("result", "ok");
						
					//SLD 3공장(파주)
					} else if ("003".equals(factoryCode)) {
						//주간조일 때
						//if (workOrderVo.getWorkOrdNo().substring(14, 15).equals("1") || workOrderVo.getWorkOrdNo().substring(14, 15).equals("2")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//주간불량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getDayTotalPrcssSum() == 0 && totalFaultyAdmVo.getDayTotalMatrlSum() == 0 && totalFaultyAdmVo.getDayTotalReplaceSum() == 0 && totalFaultyAdmVo.getDayTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");	
							//} else {
							workOrderService.updateWorkOrderStatus(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("message", "종료되었습니다.");
							jsonData.put("result", "ok");
							//}

						//야간조일 때, 양간불량 미등록 시
						//} else if (workOrderVo.getWorkOrdNo().substring(14, 15).equals("3") || workOrderVo.getWorkOrdNo().substring(14, 15).equals("4")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//야간량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getNightTotalPrcssSum() == 0 && totalFaultyAdmVo.getNightTotalMatrlSum() == 0 && totalFaultyAdmVo.getNightTotalReplaceSum() == 0 && totalFaultyAdmVo.getNightTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else {
							//workOrderService.updateWorkOrderStatus(workOrderVo);
							//jsonData.put("data", workOrderVo);
							//jsonData.put("message", "종료되었습니다.");
							//jsonData.put("result", "ok");
							//}
						//}

					//공정코드 에러
					} else {
						jsonData.put("message", "공장코드 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc3010_002");
					}
				}
			}
		} catch (Exception e) {
			logger.info("작업지시 상태수정  오류");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//작업지시 상태수정
	@RequestMapping(value = "/po/workOrderUpdateStatus_F1F2F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderUpdateStatus_F1F2F3(WorkOrderVo workOrderVo, TotalFaultyAdmVo totalFaultyAdmVo, MatrlUserVo matrlUserVo, MenuAuthVo menuAuthVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("작업지시 상태수정 - " + workOrderVo);
		workOrderVo.setUpdId(Utils.getUserId());
		try {
			
			WorkOrderVo readWorkOrderVo = new WorkOrderVo(); 
			readWorkOrderVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			readWorkOrderVo = workOrderService.read(readWorkOrderVo);
			WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
			workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo().toString());
			//비전불량현황 리스트 불러오기 - 예외처리용
			List<WorkOrdOutputSubVo> readVisionFaultyAdmList = workOrdOutputSubService.readVisionFaultyAdmList_F2(workOrdOutputSubVo);
			
			//계정 체크용
			MatrlUserVo userVo = matrlUserService.userAuthDeleteCheck_F1F2F3(matrlUserVo);
			menuAuthVo.setLotNo(workOrderVo.getWorkOrdNo());
			menuAuthVo.setUseUserId(matrlUserVo.getUserId());
			menuAuthVo.setLoginUserId(Utils.getUserId());
			
			//트레이 생산 기능 잠금 O
			Settings singletonSettings = Settings.getInstance();
			if( singletonSettings.lockTrayProduce ) {
				SystemCommonCodeVo systemCommonCode = new SystemCommonCodeVo();
				systemCommonCode.setBaseGroupCd("096");	//시스템 기능 잠금
				systemCommonCode.setBaseCd("002");	//제품 포장Lock
				systemCommonCode = systemCommonCodeService.read(systemCommonCode);
				jsonData.put("message", systemCommonCode.getEtc1());
				jsonData.put("result", "lock");
				return jsonData;								
			}
			
			//미발행 작업지시 삭제
			if (workOrderVo.getWorkStatusCd().equals("delete")) {
				
				//미발행 or 발행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("B") && !readWorkOrderVo.getWorkStatusCd().equals("P")) {
					jsonData.put("message", "미발행 또는 발행 상태의 작지만 삭제할 수 있습니다.<br>작지상태를 확인해주세요!");
					jsonData.put("result", "fail");
					
				//미발행일 경우 별도의 확인 없이 바로 삭제
				} else if (readWorkOrderVo.getWorkStatusCd().equals("B")) {
					if(readVisionFaultyAdmList.isEmpty()) {
						
						//삭제 권한 사용로그 등록
						
						workOrderService.deleteWorkOrdNo(readWorkOrderVo);
						jsonData.put("message", "삭제되었습니다.");
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "비전불량 현황을 확인해주세요!");
						jsonData.put("result", "fail");
					}
				
				//발행일 경우 생산실적(초,중물), 불량중량 등록되어있는지 확인
				} else if (readWorkOrderVo.getWorkStatusCd().equals("P")) {
					//작업지시별 초,중물이 모두 입력되었는지 확인
					AgtVo agtVo = new AgtVo();
					agtVo.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
					List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck_F3(agtVo);
					boolean checkAgtStep = false;
					String agtStepMessage = "";
					int temp = 0; //안내메시지<br> 추가여부 판단
					for (int i = 0; i < countAgtStepCheckList.size(); i++) {
						if ("001".equals(countAgtStepCheckList.get(i).getStepCd())) {
							if (temp > 0) {
								agtStepMessage += "<br>";
							}
							agtStepMessage += "초물이 입력되어 있습니다!";
							temp++;
							checkAgtStep = true;
						} else if ("002".equals(countAgtStepCheckList.get(i).getStepCd())) {
							if (temp > 0) {
								agtStepMessage += "<br>";
							}
							agtStepMessage += "중물이 입력되어 있습니다!";
							temp++;
							checkAgtStep = true;
						} else if ("003".equals(countAgtStepCheckList.get(i).getStepCd())) {
							if (temp > 0) {
								agtStepMessage += "<br>";
							}
							agtStepMessage += "종물이 입력되어 있습니다!";
							temp++;
							checkAgtStep = true;
						}
					}
					
					//주자재별로 생산실적이 입력되었는지 확인
					List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
					boolean checkLotNoOutputSub = false;
					String outputMessage = "";
					int temp1 = 0; //안내메시지<br> 추가여부 판단
					for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
						if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() != 0) {
							if (temp1 > 0) {
								outputMessage += "<br>";
							}
							outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!";
							temp1++;
							checkLotNoOutputSub = true;
						}
					}
					
					//불량중량 입력확인
					AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
					allFaultyAdmVo.setEquipCd(totalFaultyAdmVo.getEquipCd());
					allFaultyAdmVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
					List<AllFaultyAdmVo> allFaultyAdmVoList = allFaultyAdmService.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);
					//발행 상태가 맞는지 확인
					if (!readWorkOrderVo.getWorkStatusCd().equals("P")) {
						jsonData.put("message", "미발행 또는 발행 상태의 작업지시만 삭제 하실 수 있습니다!");
						jsonData.put("result", "fail");

					//초,중물이 입력되었는지 확인
					} else if (checkAgtStep) {
						jsonData.put("message", agtStepMessage);
						jsonData.put("result", "fail");
						
					//생산실적이 입력되었는지 확인
					} else if (checkLotNoOutputSub) {
						jsonData.put("message", outputMessage);
						jsonData.put("result", "fail");

					//불량중량이 입력되었는지 확인
					} else if (!allFaultyAdmVoList.isEmpty()) {
						String message = "";
						for (int i = 0; i < allFaultyAdmVoList.size(); i++) {
							String faultyRegDate = allFaultyAdmVoList.get(i).getFaultyRegDate();
							message += faultyRegDate.substring(0, 4) + "-" + faultyRegDate.substring(4, 6) + "-" + faultyRegDate.substring(6, 8) + "<br>";
						}
						jsonData.put("message", message + "해당 날짜에 불량중량이 등록되어있습니다!<br>불량중량이 입력된 작업지시는 취소 할 수 없습니다!");
						jsonData.put("result", "fail");

					//작업지시 삭제 진행
					} else {
						//재투입 자재일 경우 그냥 삭제하면 되지만 신규투입 자재일 경우 다른 작업지시에 재투입되었는지 확인 후 삭제해야함
						//신규투입일 경우 삭제 후 자재상태 O로 돌려줘야함
						List<WorkOrderVo> workOrderMatrlDataList = workOrderService.workOrderMatrlDataList(readWorkOrderVo);
						boolean checkWorkOrdDlt = false;
						String failMessage = "";
						int temp2 = 0; //안내메시지<br> 추가여부 판단
						for (int i=0; i<workOrderMatrlDataList.size(); i++) {
							if ("N".equals(workOrderMatrlDataList.get(i).getRemakeYn())) {
								WorkOrderVo remakeDtl = new WorkOrderVo();
								remakeDtl.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
								remakeDtl.setLotNo(workOrderMatrlDataList.get(i).getLotNo());
								List<WorkOrderVo> remakeDtlList = workOrderService.reamkeWorkOrderDtlList(remakeDtl);
								for (int j=0; j<remakeDtlList.size(); j++) {
									if (temp2 > 0) {
										failMessage += "<br>";
									}
									failMessage += remakeDtlList.get(j).getLotNo() + " 자재가 " + remakeDtlList.get(j).getWorkOrdNo() + "에 재투입되어 있습니다!";
									temp2++;
									checkWorkOrdDlt = true;
								}
							}
						}
						
						if (checkWorkOrdDlt) {
							jsonData.put("message", failMessage);
							jsonData.put("result", "fail");
						} else {
							if(readVisionFaultyAdmList.isEmpty()) {
								
								if( userVo == null ) {
									jsonData.put("result", "fail");
									jsonData.put("message", "권한이 없는 계정입니다.");				
								} else if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {				 
									jsonData.put("result", "fail");
									jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
								//로그인 불가
								} else {
									//삭제 권한사용 로그처리
									menuAuthVo.setUseAuthCode("001");
									menuAuthService.userAuthUseHist_F1F2F3(menuAuthVo);
									workOrderService.updatePreOutWhsStatus(readWorkOrderVo);	//해당작지의 최초투입 자재는 삭제전 입고자재 가출고 상태로 변경
									workOrderService.deleteWorkOrderDtl(readWorkOrderVo);		//자재 투입내역 삭제
									workOrderService.deleteWorkOrdNo(readWorkOrderVo);			//작업지시 삭제
									
									//트레이 삭제
									/*ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
									productionPerfTrayVo.setEquipCd(workOrderVo.getEquipCd());
									productionPerfTrayVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
									productionPerfTrayService.productionPerfTrayDelete(productionPerfTrayVo);
									
									//작업자 삭제
									WorkerChangeVo workerChangeVo = new WorkerChangeVo();
									workerChangeVo.setEquipCd(workOrderVo.getEquipCd());
									workerChangeVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
									workerChangeVo.setUpdId(Utils.getUserId());
									workOrderService.workerChangeDelete(workerChangeVo);*/
									
									jsonData.put("message", "삭제되었습니다.");
									jsonData.put("result", "ok");	
								}
							} else {
								jsonData.put("message", "비전불량 현황을 확인해주세요!");
								jsonData.put("result", "fail");
							};	
						}
					}
				}
			
			//업데이트 할 상태가 작지발행이 경우
			} else if (workOrderVo.getWorkStatusCd().equals("P")) {
				//작업지시별 초,중물이 모두 입력되었는지 확인
				AgtVo agtVo = new AgtVo();
				agtVo.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
				List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck_F3(agtVo);
				boolean checkAgtStep = false;
				String agtStepMessage = "";
				int temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < countAgtStepCheckList.size(); i++) {
					if ("001".equals(countAgtStepCheckList.get(i).getStepCd())) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += "초물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					} else if ("002".equals(countAgtStepCheckList.get(i).getStepCd())) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += "중물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					} else if ("003".equals(countAgtStepCheckList.get(i).getStepCd())) {
						if (temp > 0) {
							agtStepMessage += "<br>";
						}
						agtStepMessage += "종물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					}
				}

				//주자재별로 생산실적이 입력되었는지 확인
				List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				boolean checkLotNoOutputSub = false;
				String outputMessage = "";
				temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
					if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() != 0) {
						if (temp > 0) {
							outputMessage += "<br>";
						}
						outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!";
						temp++;
						checkLotNoOutputSub = true;
					}
				}

				//불량중량 입력확인
				AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
				allFaultyAdmVo.setEquipCd(totalFaultyAdmVo.getEquipCd());
				allFaultyAdmVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
				List<AllFaultyAdmVo> allFaultyAdmVoList = allFaultyAdmService.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);

				//진행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("S")) {
					jsonData.put("message", "발행상태 작업지시만 취소할 수 있습니다.<br>작업지시 상태를 확인해주세요!");
					jsonData.put("result", "fail");

				//초,중물이 입력되었는지 확인
				} else if (checkAgtStep) {
					jsonData.put("message", agtStepMessage);
					jsonData.put("result", "fail");

				//생산실적이 입력되었는지 확인
				} else if (checkLotNoOutputSub) {
					jsonData.put("message", outputMessage);
					jsonData.put("result", "fail");

				//불량중량이 입력되었는지 확인
				} else if (!allFaultyAdmVoList.isEmpty()) {
					String message = "";
					for (int i = 0; i < allFaultyAdmVoList.size(); i++) {
						String faultyRegDate = allFaultyAdmVoList.get(i).getFaultyRegDate();
						message += faultyRegDate.substring(0, 4) + "-" + faultyRegDate.substring(4, 6) + "-" + faultyRegDate.substring(6, 8) + "<br>";
					}
					jsonData.put("message", message + "해당 날짜에 불량중량이 등록되어있습니다!<br>불량중량이 입력된 작업지시는 취소 할 수 없습니다!");
					jsonData.put("result", "fail");

				//작지 진행 취소 실행
				} else {
					//작지 발행(P)로 변경, 생산실적수량 초기화
					workOrderService.updateWorkOrderStatus(workOrderVo);
					
					//검사 상태 값 Update
					WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo(); 
					
					//빈값으로 상태값 Update
					WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
					WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
					WorkOrderStatusCheckVo.setWorkInspectionStatusCd(""); // "" -> 값 없음, S -> 진행, C-> 완료
					logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
					workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
					
					//트레이 삭제
					ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
					productionPerfTrayVo.setEquipCd(workOrderVo.getEquipCd());
					productionPerfTrayVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
					productionPerfTrayService.productionPerfTrayDelete(productionPerfTrayVo);
					
					//작업자 삭제
					WorkerChangeVo workerChangeVo = new WorkerChangeVo();
					workerChangeVo.setEquipCd(workOrderVo.getEquipCd());
					workerChangeVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());;
					workerChangeVo.setUpdId(Utils.getUserId());
					workOrderService.workerChangeDelete(workerChangeVo);
					//검사 상태 값 Update
					
					//진행취소 시 LGES프린트 관련 테이블도 삭제 진행
					productionPerfTrayService.lgesPrintDelete(productionPerfTrayVo);
					
					jsonData.put("data", workOrderVo);
					jsonData.put("message", "진행 취소되었습니다.");
					jsonData.put("result", "ok");
				}

			//업데이트 할 상태가 작업진행 상태라면
			} else if (workOrderVo.getWorkStatusCd().equals("S")) {
				if (readWorkOrderVo.getWorkStatusCd().equals("P")) {
					//해당설비의 24시간 이내의 진행중인 작지가 있는지 확인
					WorkOrderVo countWorkingWorkOrd = workOrderService.checkWorkingWorkOrd(readWorkOrderVo);
					//if (countWorkingWorkOrd.getCountWorkingWorkOrd() == 0) 
					if(countWorkingWorkOrd == null) {
						
						//검사 상태 값 Update
							
						//제품별 생산 수량 값 확인
						int productQty = 0;	//생산 수량(한 트레이 별)
						
						GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
						goodsCodeAdmVo.setGoodsCd( workOrderVo.getGoodsCd() );
						goodsCodeAdmVo	= goodsCodeAdmService.read(goodsCodeAdmVo);
						productQty		= Integer.parseInt(goodsCodeAdmVo.getProductQty().toString());
						
						//제품 생산 수량 0인 경우 반환
						if( productQty == 0) {
							jsonData.put("result", "fail");
							jsonData.put("message", "해당 제품에 트레이생산 수량이 등록되어있지 않습니다.<br>제품코드관리에서 등록 후 다시 시도해주세요!");
							return jsonData;
						}
						//제품별 생산 수량 값 확인
						
						
						//작지 상태값 Update
						WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo(); 
						
						WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						WorkOrderStatusCheckVo = workOrderService.read(WorkOrderStatusCheckVo);
						
						if("".equals(WorkOrderStatusCheckVo.getWorkInspectionStatusCd()) || WorkOrderStatusCheckVo.getWorkInspectionStatusCd() == null) {
							//null 또는 빈값일때 상태값 Update
							WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
							WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
							WorkOrderStatusCheckVo.setWorkInspectionStatusCd("S"); // "" -> 값 없음, S -> 진행, C-> 완료
							logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
							workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
						}
						//작지 상태값 Update
						
						//트레이 생산 부분
						ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
						productionPerfTrayVo.setEquipCd(workOrderVo.getEquipCd());
						productionPerfTrayVo.setEquipNm(workOrderVo.getEquipNm());
						productionPerfTrayVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						productionPerfTrayVo.setArrayData(workOrderVo.getArrayData());
						productionPerfTrayCreate(productionPerfTrayVo);
						//1공장, 2공장 트레이 생산 부분 끝
						
						//작업자 변경 등록
						WorkerChangeVo workerChangeVo = new WorkerChangeVo();
						workerChangeVo.setEquipCd(workOrderVo.getEquipCd());
						workerChangeVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						workerChangeVo.setOrdDate(totalFaultyAdmVo.getFaultyRegDate());
						workerChangeVo.setWorkerId(workOrderVo.getWorkerId());
						workerChangeVo.setWorkStatusCd("S");
						workerChangeVo.setWorkerStatusCd("S");
						workerChangeCreate(workerChangeVo);
						//작업자 변경 등록 끝
						
						workOrderService.updateWorkOrderStatus(workOrderVo);	//시작 진행
						
						//검사 상태 값 Update							
						jsonData.put("message", "시작되었습니다.");
						jsonData.put("result", "ok");
					} else {
						//jsonData.put("message", "해당 설비의 진행중인 작업지시가 " + countWorkingWorkOrd + "개 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("message", "해당 설비의 '" +countWorkingWorkOrd.getWorkOrdNo()+ "' 작업지시가 진행중에 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("result", "fail");
					}
				} else if (readWorkOrderVo.getWorkStatusCd().equals("C")) {
					
					//권한이 있는 사용자인지 확인
					if( userVo == null ) {
						jsonData.put("result", "fail");
						jsonData.put("message", "권한이 없는 계정입니다.");				
					} else if (!(BCrypt.checkpw(matrlUserVo.getUserPw(), userVo.getUserPw()) && matrlUserVo.getUserId().equals(userVo.getUserId())) ) {				 
						jsonData.put("result", "fail");
						jsonData.put("message", "아이디 또는 비밀번호를 확인해주세요.");
					//로그인 불가
					} else {
					
					//해당설비의 24시간 이내의 진행중인 작지가 있는지 확인
						WorkOrderVo countWorkingWorkOrd = workOrderService.checkWorkingWorkOrd(readWorkOrderVo);
					//if (countWorkingWorkOrd.getCountWorkingWorkOrd() == 0) 
					if(countWorkingWorkOrd == null) {
						//완료취소 권한사용 로그처리
						menuAuthVo.setUseAuthCode("002");
						menuAuthService.userAuthUseHist_F1F2F3(menuAuthVo);
						workOrderVo.setUpdateGubun("U");
						workOrderService.updateWorkOrderStatus(workOrderVo);	//시작 진행
						
						//검사 상태 값 Update
						WorkOrderVo WorkOrderStatusCheckVo = new WorkOrderVo(); 
						
						WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						WorkOrderStatusCheckVo = workOrderService.read(WorkOrderStatusCheckVo);
						
						if("".equals(WorkOrderStatusCheckVo.getWorkInspectionStatusCd()) || WorkOrderStatusCheckVo.getWorkInspectionStatusCd() == null) {
							//null 또는 빈값일때 상태값 Update
							WorkOrderStatusCheckVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
							WorkOrderStatusCheckVo.setUpdId(Utils.getUserId());
							WorkOrderStatusCheckVo.setWorkInspectionStatusCd("S"); // "" -> 값 없음, S -> 진행, C-> 완료
							logger.info("상태값 Update 진행 됨"+WorkOrderStatusCheckVo);
							workOrderService.workOrderStatusUpdate(WorkOrderStatusCheckVo);
						}
						
						//(트레이)생산 실적 삭제 시작
						workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						workOrdOutputSubVo.setOrdLotNo(workOrderVo.getWorkOrdNo() + "-T");
						workOrdOutputSubService.appearAndEdgeCheckDelete_F3(workOrdOutputSubVo);
						//(트레이)생산 실적 삭제 종료
						
						//작업자 변경 등록
						/*
						 * WorkerChangeVo workerChangeVo = new WorkerChangeVo();
						 * workerChangeVo.setEquipCd(workOrderVo.getEquipCd());
						 * workerChangeVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
						 * workerChangeVo.setOrdDate(totalFaultyAdmVo.getFaultyRegDate());
						 * workerChangeVo.setWorkerId(workOrderVo.getWorkerId());
						 * workerChangeVo.setWorkStatusCd("S"); workerChangeVo.setWorkerStatusCd("S");
						 * workerChangeCreate(workerChangeVo);
						 */
						//작업자 변경 등록 끝
						
						
							
						//검사 상태 값 Update							
						jsonData.put("message", "변경되었습니다.");
						jsonData.put("result", "ok");
					} else {
						//jsonData.put("message", "해당 설비의 진행중인 작업지시가 " + countWorkingWorkOrd + "개 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("message", "해당 설비의 '" +countWorkingWorkOrd.getWorkOrdNo()+ "' 작업지시가 진행중에 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
						jsonData.put("result", "fail");
					} 
				}
			}	
			//발행일 경우 생산실적(초,중,종물), 불량중량 등록되어있는지 확인
			} else if (readWorkOrderVo.getWorkStatusCd().equals("P")) {
				//주자재별로 초,중물이 모두 입력되었는지 확인
				AgtVo agtVo = new AgtVo();
				agtVo.setWorkOrdNo(readWorkOrderVo.getWorkOrdNo());
				List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck_F3(agtVo);
				boolean checkAgtStep = false;
				String agtStepMessage = "";
				int temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < countAgtStepCheckList.size(); i++) {
					if (temp > 0) {
						agtStepMessage += "<br>";
					}
					if ("001".equals(countAgtStepCheckList.get(i).getStepCd())) {
						agtStepMessage += "초물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					} else if ("002".equals(countAgtStepCheckList.get(i).getStepCd())) {
						agtStepMessage += "중물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					} else if ("003".equals(countAgtStepCheckList.get(i).getStepCd())) {
						agtStepMessage += "종물이 입력되어 있습니다!";
						temp++;
						checkAgtStep = true;
					}
				}

				//주자재별로 생산실적이 입력되었는지 확인
				List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				boolean checkLotNoOutputSub = false;
				String outputMessage = "";
				temp = 0; //안내메시지<br> 추가여부 판단
				for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
					if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() != 0) {
						if (temp > 0) {
							outputMessage += "<br>";
						}
						outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!";
						temp++;
						checkLotNoOutputSub = true;
					}
				}
				
				//불량중량 입력확인
				AllFaultyAdmVo allFaultyAdmVo = new AllFaultyAdmVo();
				allFaultyAdmVo.setEquipCd(totalFaultyAdmVo.getEquipCd());
				allFaultyAdmVo.setWorkOrdNo(totalFaultyAdmVo.getWorkOrdNo());
				List<AllFaultyAdmVo> allFaultyAdmVoList = allFaultyAdmService.cancelWorkOrdTotalFaultyCheck(allFaultyAdmVo);

				//진행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("S")) {
					jsonData.put("message", "발행상태 작업지시만 취소할 수 있습니다.<br>작업지시 상태를 확인해주세요!");
					jsonData.put("result", "fail");

				//초,중물이 입력되었는지 확인
				} else if (checkAgtStep) {
					jsonData.put("message", agtStepMessage);
					jsonData.put("result", "fail");
                
				//생산실적이 입력되었는지 확인
				} else if (checkLotNoOutputSub) {
					jsonData.put("message", outputMessage);
					jsonData.put("result", "fail");

				//불량중량이 입력되었는지 확인
				} else if (!allFaultyAdmVoList.isEmpty()) {
					String message = "";
					for (int i = 0; i < allFaultyAdmVoList.size(); i++) {
						String faultyRegDate = allFaultyAdmVoList.get(i).getFaultyRegDate();
						message += faultyRegDate.substring(0, 4) + "-" + faultyRegDate.substring(4, 6) + "-" + faultyRegDate.substring(6, 8) + "<br>";
					}
					jsonData.put("message", message + "해당 날짜에 불량중량이 등록되어있습니다!<br>불량중량이 입력된 작업지시는 취소 할 수 없습니다!");
					jsonData.put("result", "fail");

				//작지 진행 취소 실행
				} else {
					//작지 발행(P)로 변경, 생산실적수량 초기화
					workOrderService.updateWorkOrderStatus(workOrderVo);
					jsonData.put("data", workOrderVo);
					jsonData.put("message", "진행 취소되었습니다.");
					jsonData.put("result", "ok");
				}

			//업데이트 할 상태가 종료 상태라면
			} else if (workOrderVo.getWorkStatusCd().equals("C")) {
				
				//주자재별로 생산실적이 입력되었는지 확인
				//List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				//boolean checkLotNoOutputSub = false;
				//String outputMessage = "";
				//int temp = 0; //안내메시지<br> 추가여부 판단
				//for (int i = 0; i < WorkOrdOutputSubList.size(); i++) {
				//	if (WorkOrdOutputSubList.get(i).getCountLotOutputSub() == 0) {
				//		if (temp > 0) {
				//			outputMessage += "<br>";
				//		}
				//		outputMessage += WorkOrdOutputSubList.get(i).getLotNo() + " 자재의 생산실적을 입력해 주세요!";
				//		temp++;
				//		checkLotNoOutputSub = true;
				//	}
				//}
				
				//해당 작지의 생산전표번호 모두 초or중물이 입력되었는지 확인
				//AgtVo agtVo = new AgtVo();
				//agtVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
				//List<AgtVo> countAgtStepCheckList = agtService.countAgtStepCheck(agtVo);
				//boolean checkAgtStep = false;
				//String agtStepMessage = "";
				//temp = 0; //안내메시지<br> 추가여부 판단
				//for (int i = 0; i < countAgtStepCheckList.size(); i++) {
				//	if (countAgtStepCheckList.get(i).getStepCd() == null) {
				//		if (temp > 0) {
				//			agtStepMessage += "<br>";
				//		}
				//		agtStepMessage += countAgtStepCheckList.get(i).getOrdLotNo() + " 생산전표번호의 초물 또는 중물을 입력해 주세요!";
				//		temp++;
				//		checkAgtStep = true;
				//	}
				//	//if (countAgtStepCheckList.get(i).getCountStep001() == 0) {
				//	//	if (temp > 0) {
				//	//		agtStepMessage += "<br>";
				//	//	}
				//	//	agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 초물을 입력해 주세요!";
				//	//	temp++;
				//	//	checkAgtStep = true;
				//	//}
				//	//if (countAgtStepCheckList.get(i).getCountStep002() == 0) {
				//	//	if (temp > 0) {
				//	//		agtStepMessage += "<br>";
				//	//	}
				//	//	agtStepMessage += countAgtStepCheckList.get(i).getLotNo() + " 자재의 중물을 입력해 주세요!";
				//	//	temp++;
				//	//	checkAgtStep = true;
				//	//}
				//}

				//진행 상태가 맞는지 확인
				if (!readWorkOrderVo.getWorkStatusCd().equals("S")) {
					jsonData.put("message", "진행상태 작지만 종료할 수 있습니다.<br>작지상태를 확인해주세요!");
					jsonData.put("result", "fail");
					
				////주자재별로 초중물 미등록시
				//} else if (checkAgtStep) {
				//	jsonData.put("message", agtStepMessage);
				//	jsonData.put("result", "fail");
				//
				////주자재별로 생산실적 미등록시
				//} else if (checkLotNoOutputSub) {
				//	jsonData.put("message", outputMessage);
				//	jsonData.put("result", "fail");
				
				} else {
					//MTP 1공장(성남)
					/*if ("001".equals(factoryCode)) {
						//주간조일 때
						//if (workOrderVo.getWorkOrdNo().substring(13, 14).equals("1") || workOrderVo.getWorkOrdNo().substring(13, 14).equals("2")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//주간불량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getDayTotalPrcssSum() == 0 && totalFaultyAdmVo.getDayTotalMatrlSum() == 0 && totalFaultyAdmVo.getDayTotalReplaceSum() == 0 && totalFaultyAdmVo.getDayTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");	
							//} else {
							workOrderService.updateWorkOrderStatus(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("message", "종료되었습니다.");
							jsonData.put("result", "ok");
							//}

						//야간조일 때, 야간불량 미등록 시
						//} else if (workOrderVo.getWorkOrdNo().substring(13, 14).equals("3") || workOrderVo.getWorkOrdNo().substring(13, 14).equals("4")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//야간량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getNightTotalPrcssSum() == 0 && totalFaultyAdmVo.getNightTotalMatrlSum() == 0 && totalFaultyAdmVo.getNightTotalReplaceSum() == 0 && totalFaultyAdmVo.getNightTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else {
							//workOrderService.updateWorkOrderStatus(workOrderVo);
							//jsonData.put("data", workOrderVo);
							//jsonData.put("message", "종료되었습니다.");
							//jsonData.put("result", "ok");
							//}
						//}
						
					//MTP 1공장(성남) || MTP 2공장(성남)
					} else*/
					/*if ("001".equals(factoryCode) || "002".equals(factoryCode)) {
						ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
						
						if( !productionPerfTrayController.trayFaultyRelatedCreate(workOrderVo.getWorkOrdNo()) ) {
							workOrderService.updateWorkOrderStatus(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("message", "종료되었습니다.");
							jsonData.put("result", "ok");
						} else {
							jsonData.put("message", "생산실적 등록&수정 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc2010_003");
							jsonData.put("result", "fail");
							return jsonData;
						}
						
					//SLD 3공장(파주)
					} else if ("003".equals(factoryCode)) {
						//주간조일 때
						//if (workOrderVo.getWorkOrdNo().substring(14, 15).equals("1") || workOrderVo.getWorkOrdNo().substring(14, 15).equals("2")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//주간불량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getDayTotalPrcssSum() == 0 && totalFaultyAdmVo.getDayTotalMatrlSum() == 0 && totalFaultyAdmVo.getDayTotalReplaceSum() == 0 && totalFaultyAdmVo.getDayTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "주간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");	
							//} else {
							workOrderService.updateWorkOrderStatus(workOrderVo);
							jsonData.put("data", workOrderVo);
							jsonData.put("message", "종료되었습니다.");
							jsonData.put("result", "ok");
							//}

						//야간조일 때, 양간불량 미등록 시
						//} else if (workOrderVo.getWorkOrdNo().substring(14, 15).equals("3") || workOrderVo.getWorkOrdNo().substring(14, 15).equals("4")) {
							//String faultyRegDate = totalFaultyAdmVo.getFaultyRegDate();
							//totalFaultyAdmVo = equipFaultyAdmService.totalFaulty(totalFaultyAdmVo);
							//야간량 미등록 시
							//if ( totalFaultyAdmVo == null) {
							//	jsonData.put("message", faultyRegDate + " 일의 야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else if ( totalFaultyAdmVo.getNightTotalPrcssSum() == 0 && totalFaultyAdmVo.getNightTotalMatrlSum() == 0 && totalFaultyAdmVo.getNightTotalReplaceSum() == 0 && totalFaultyAdmVo.getNightTotalTroubleSum() == 0 ) {
							//	jsonData.put("message", "야간 불량중량을 입력해 주세요!");
							//	jsonData.put("result", "fail");
							//} else {
							//workOrderService.updateWorkOrderStatus(workOrderVo);
							//jsonData.put("data", workOrderVo);
							//jsonData.put("message", "종료되었습니다.");
							//jsonData.put("result", "ok");
							//}
						//}

					//공정코드 에러
					} else {
						jsonData.put("message", "공장코드 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc3010_002");
					}*/
					
					//작지 종료 시 생산 실적 값 insert 후 상태값 updqte
					ProductionPerfTrayController productionPerfTrayController = new ProductionPerfTrayController(productionPerfTrayService, workOrdOutputSubService, goodsInspectService);
					if( !productionPerfTrayController.trayFaultyRelatedCreate(workOrderVo.getWorkOrdNo()) ) {
						workOrderService.updateWorkOrderStatus(workOrderVo);
						jsonData.put("data", workOrderVo);
						jsonData.put("message", "종료되었습니다.");
						jsonData.put("result", "ok");
					} else {
						jsonData.put("message", "생산실적 등록&수정 오류입니다.<br>관리자에게 문의바랍니다.<br>ERROR_CODE : posc2010_003");
						jsonData.put("result", "fail");
						return jsonData;
					}
				}
			}
		} catch (Exception e) {
			logger.info("작업지시 상태수정  오류");
			e.printStackTrace();
			jsonData.put("message", Utils.getErrorMessage());
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	 //작업지시 상태수정
	 @RequestMapping(value = "/po/workOrderUpdateChargr", method = RequestMethod.POST)
	 public @ResponseBody Map<String, Object> workOrderUpdateChargr(WorkOrderVo workOrderVo) throws Exception {

		Map<String, Object> jsonData = new HashMap<>();
		logger.info("작업지시 담당1,2 수정 = "+ workOrderVo);
		
 	 	try {
			workOrderService.updateWorkOrderChargr(workOrderVo);
			jsonData.put("data", workOrderVo);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("작업지시 담당1,2 수정  오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}

	 	 return jsonData;
	 }
	 
	//공정실적관리 작업지시 페이지
	@RequestMapping(value = "/posc0020", method = RequestMethod.GET)
	public String workOrderOutputMain(Locale locale, Model model) throws Exception {
	
		logger.info("공정실적관리 생산실적수집 메인");
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
	
		systemCommonCodeVo.setBaseGroupCd("016"); // 조편성
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("workTeamCd", systemCommonCodeList );
	
		systemCommonCodeVo.setBaseGroupCd("017"); // 설비그룹
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("equipGroup", systemCommonCodeList );
	
		systemCommonCodeVo.setBaseGroupCd("028"); // 오더구분(주/야 구분)
		systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("ordGubunCd", systemCommonCodeList );		
	
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd") );
	
		return "po/posc0020";
	}	
	
	//작업지시서 목록조회
	@RequestMapping(value = "/po/workOrderDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderDataList(WorkOrderVo workOrderVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시서 목록조회");
		
		try {
			List<WorkOrderVo> workOrderData= workOrderService.workOrderDataList(workOrderVo);
			jsonData.put("data", workOrderData);
			jsonData.put("result", "ok");
		}
		catch (Exception e) {
			logger.info("작업지시서 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");
		}
		
		return jsonData;
	}

	//작업지시 생산실적 수정
	@RequestMapping(value = "/po/updateWorkOrderResult", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> updateWorkOrderResult(WorkOrderVo workOrderVo) throws Exception {
		 
		 Map<String, Object> jsonData = new HashMap<>();
		 logger.info("작업지시 생산실적 수정 = "+ workOrderVo);
		 try {
			 workOrderVo.setWorkStatusCd("E");
		 	 workOrderService.updateWorkOrderResult(workOrderVo);
		 	 jsonData.put("data", workOrderVo);
		 	 jsonData.put("result", "ok");
		 } catch (Exception e) {
				logger.info("작업지시 생산실적 수정 오류");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }
		 
		 return jsonData; 
	}	 
	
	//작업지시 자재투입 삭제 확인
	@RequestMapping(value = "/po/deleteMatrlCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMatrlCheck(WorkOrderVo workOrderVo) throws Exception {
		 Map<String, Object> jsonData = new HashMap<>();
		 logger.info("작업지시 자재투입 삭제 확인 = "+ workOrderVo);
		 try {		
		 	 int i = workOrderService.workOrderDtlCount(workOrderVo);
		 	 
		 	WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		 	workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
		 	
		 	//주자재 인지 검사
		 	if( workOrderVo.getMatrlCd().substring(0,1).equals("A") || workOrderVo.getMatrlCd().substring(0,1).equals("N") ) {
		 		
			 	//주자재별로 생산실적이 입력되었는지 확인
				List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
				
				
				if(WorkOrdOutputSubList.size() != 0) {
					
					if (WorkOrdOutputSubList.get(0).getCountLotOutputSub() != 0) {
						jsonData.put("result", "valueExists");
						jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!"));
					} else if(WorkOrdOutputSubList.get(0).getCountLotFaultyAdm() != 0) {
						jsonData.put("result", "valueExists");
						jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 불량중량이 입력되어 있습니다!"));
					} else if(WorkOrdOutputSubList.get(0).getCountLotAgt() != 0) {
						jsonData.put("result", "valueExists");
						jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 초물이 입력되어 있습니다!"));
					} else if(WorkOrdOutputSubList.get(0).getCountTray() != 0) {
						jsonData.put("result", "valueExists");
						jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 생산실적(Tray)이 입력되어 있습니다!"));
					} else {
						
						if(i==0) {
							jsonData.put("data", "ok");
						} else {
							jsonData.put("data", "no");
						}
						jsonData.put("result", "ok");
					}
				} else {
					if(i==0) {
						jsonData.put("data", "ok");
					} else {
						jsonData.put("data", "no");
					}
					jsonData.put("result", "ok");
				}
		 	} else {
		 		if(i==0) {
					jsonData.put("data", "ok");
				} else {
					jsonData.put("data", "no");
				}
				jsonData.put("result", "ok");
		 	}
			
		 } catch (Exception e) {
				logger.info("자재투입 삭제 확인");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }
		 return jsonData; 
	}
	
	//작업지시 신규투입X 삭제 확인
	@RequestMapping(value = "/po/deleteMatrlNotNewCheck", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteMatrlNotNewCheck(WorkOrderVo workOrderVo) throws Exception {
		 Map<String, Object> jsonData = new HashMap<>();
		 logger.info("작업지시 자재투입 삭제 확인 = "+ workOrderVo);
		 try {		
		 	 
		 	WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
		 	workOrdOutputSubVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
		 	 
		 	//주자재별로 생산실적이 입력되었는지 확인
			List<WorkOrdOutputSubVo> WorkOrdOutputSubList = workOrdOutputSubService.checkLotNoOutputSub(workOrdOutputSubVo);
			
			if (WorkOrdOutputSubList.get(0).getCountLotOutputSub() != 0) {
				jsonData.put("result", "valueExists");
				jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 생산실적이 입력되어 있습니다!"));
			} else if(WorkOrdOutputSubList.get(0).getCountLotFaultyAdm() != 0) {
				jsonData.put("result", "valueExists");
				jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 불량중량이 입력되어 있습니다!"));
			} else if(WorkOrdOutputSubList.get(0).getCountLotAgt() != 0) {
				jsonData.put("result", "valueExists");
				jsonData.put("message", (WorkOrdOutputSubList.get(0).getLotNo() + " 자재의 초물이 입력되어 있습니다!"));
			} else {
				jsonData.put("data", "ok");
				jsonData.put("result", "ok");
			}
			
		 } catch (Exception e) {
				logger.info("자재투입 삭제 확인");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "fail");			 
		 }
		 return jsonData; 
	}
	
	//작지 연결 목록대상 조회
	@RequestMapping(value = "/po/workOrderConncetList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workOrderConncetList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 연결대상 목록 조회= "+ workOrderVo);
		try {
			List<WorkOrderVo> workOrderData= workOrderService.workOrderConnectList(workOrderVo);
			jsonData.put("data", workOrderData);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//불량 테프론 리스트 불러오기
	@RequestMapping(value = "/po/ptfe1DataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> ptfe1DataList(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량 테프론 리스트 불러오기 = "+ allFaultyAdmVo);
		try {
			
			List<AllFaultyAdmVo> list = allFaultyAdmService.readPtfeFaulty(allFaultyAdmVo);		
			jsonData.put("data", list);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//불량 테프론 삭제
	@RequestMapping(value = "/po/ptfeDataDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> ptfeDataDelete(AllFaultyAdmVo allFaultyAdmVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("불량 테프론 삭제 = "+ allFaultyAdmVo);
		try {			
			
			int nowFaultySeq	= allFaultyAdmVo.getFaultySeq();
			int max 			= 0;
			
			AllFaultyAdmVo listVo = allFaultyAdmVo;
			List<AllFaultyAdmVo> list = allFaultyAdmService.readPtfeFaulty(listVo);
			
			for(int i=0; i<list.size(); i++) {
				logger.info("list 값 보기 "+list.get(i).getFaultySeq());
				int comparisonValue = list.get(i).getFaultySeq();
				
				if(max <= comparisonValue) {
					
					max = comparisonValue;
				}
			}
			
			logger.info("최대 값은 ----> "+max);
			
			if(nowFaultySeq < max) {
				jsonData.put("message", "최근 값 부터 순차적으로 삭제해주세요!");
				jsonData.put("result", "fail");
				return jsonData;
			}else {
				allFaultyAdmService.deletePtfe(allFaultyAdmVo);
				
				List<AllFaultyAdmVo> list2 = allFaultyAdmService.readPrcssFaulty(allFaultyAdmVo);
				
				float sum	= 0; 
				float count	= 0; 
				
				if(list2.size() != 0) {				
					for(int i = 0; i < list2.size(); i++) {
						sum	+= Float.parseFloat(list2.get(i).getFaulty().toString());
						count++;
					}
				}
									
				if (!"empty".equals(allFaultyAdmVo.getSystemCode().toString())) {
			
					allFaultyAdmVo.setUpdId(Utils.getUserId());				
			
					int faultyCount1 = 0;
					int faultyCount2 = 0;
					int faultyCount3 = 0;
					int faultyCount4 = 0;
					
					//1, 2공장	: 실리콘 구분자 003번 / 공통코드 번호 : 003, 007번(1, 2차)
					//1, 2공장	: 테프론 구분자 003번 / 공통코드 번호 : 004, 008번(1, 2차)
					
					//3 공장		: 실리콘 구분자 004번 / 공통코드 번호 : 001, 002번(1, 2차)
					//3 공장		: 테프론 구분자 004번 / 공통코드 번호 : 003, 004번(1, 2차)
					
					if( factoryCode.equals("001") || factoryCode.equals("002") ) {
						for(AllFaultyAdmVo m : list2) {
							if("004".equals(m.getSystemCode().toString())) {
								faultyCount1++;
							}
							if("008".equals(m.getSystemCode().toString())) {
								faultyCount2++;
							}
							if("003".equals(m.getSystemCode().toString())) {
								faultyCount3++;
							}
							if("007".equals(m.getSystemCode().toString())) {
								faultyCount4++;
							}
						}
					} else if( factoryCode.equals("003") ) {
						for(AllFaultyAdmVo m : list2) {
							if("003".equals(m.getSystemCode().toString())) {
								faultyCount1++;
							}
							if("004".equals(m.getSystemCode().toString())) {
								faultyCount2++;
							}
							if("001".equals(m.getSystemCode().toString())) {
								faultyCount3++;
							}
							if("002".equals(m.getSystemCode().toString())) {
								faultyCount4++;
							}
						}
					}
					
					for(AllFaultyAdmVo m : list2) {
						m.setPrcsTotal(Float.toString(sum));
						m.setPrcsCnt(Float.toString(count));
			
						if( factoryCode.equals("001") || factoryCode.equals("002") ) {
							if("004".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount1));
							}
							if("008".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount2));
							}
							if("003".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount3));
							}
							if("007".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount4));
							}
						} else if( factoryCode.equals("003") ) {
							if("003".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount1));
							}
							if("004".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount2));
							}
							if("001".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount3));
							}
							if("002".equals(m.getSystemCode().toString())) {
								m.setFaultyCount(Integer.toString(faultyCount4));
							}
						}
						//logger.info(Integer.toString(allFaultyAdmVo.getFaultySeq()));
						//logger.info(Integer.toString(m.getFaultySeq()));
						//logger.info((allFaultyAdmVo.getSystemCode()));
						//logger.info((m.getSystemCode()));
						
						if( allFaultyAdmVo.getFaultySeq() == m.getFaultySeq() && allFaultyAdmVo.getSystemCode().equals( m.getSystemCode() )) {
							allFaultyAdmVo.setPrcsTotal(m.getPrcsTotal());
							allFaultyAdmVo.setPrcsCnt(m.getPrcsCnt());
							allFaultyAdmService.updateFaultyAll(allFaultyAdmVo);
							//logger.info("=========================================================");
						} else {
							m.setUpdId(Utils.getUserId());
							allFaultyAdmService.updateFaultyAll(m);
						}
					}
				}
				
				jsonData.put("result", "ok");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");
		}
		
		return jsonData;
	}
	
	//연걸 작업지시 등록 & 연결 자재 등록
	@RequestMapping(value = "/po/createConnectWorkOrdNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> createConnectWorkOrdNo(WorkOrderVo workOrderVo, String connectMainMatrlBarcode, String connectSubMatrlBarcode) throws Exception {
		Map<String, Object> jsonData = new HashMap<>();
		logger.info("연걸 작업지시 등록 & 연결 자재 등록 = "+ workOrderVo);
		try {
			
			//해당설비의 24시간 이내의 진행중인 작지가 있는지 확인
			WorkOrderVo countWorkingWorkOrd = workOrderService.checkWorkingWorkOrd(workOrderVo);
			//if (countWorkingWorkOrd.getCountWorkingWorkOrd() == 0) 
			if(countWorkingWorkOrd == null) {
				WorkOrderVo readWorkOrd = new WorkOrderVo();
				readWorkOrd.setWorkOrdNo(workOrderVo.getConnectWorkOrdNo());
				readWorkOrd = workOrderService.read(readWorkOrd);			//목표중량&목표수량을 알기위해 읽어옴
				
				//workOrderVo.setOrdGubun(workOrderVo.getOrdLotNo().substring(13,14));
				workOrderVo.setWorkStatusCd("P");
				workOrderVo.setTargetWeight(readWorkOrd.getTargetWeight());
				workOrderVo.setTargetCnt(readWorkOrd.getTargetCnt());
				workOrderVo.setConnectCd("Y");
				workOrderVo.setRegId(Utils.getUserId());
				workOrderService.createWorkOrder(workOrderVo);				//작지 발행
				
				workOrderVo.setConnectMatrlBarcode(connectMainMatrlBarcode);
				workOrderService.createConnectWorkOrderDtl(workOrderVo);	//연결 주자재 생성
				workOrderVo.setConnectMatrlBarcode(connectSubMatrlBarcode);
			 	workOrderService.createConnectWorkOrderDtl(workOrderVo);	//연결 부자재 생성
			 	
			 	jsonData.put("message", workOrderVo.getWorkOrdNo() + "가 " + workOrderVo.getConnectWorkOrdNo() + "로 연결되었습니다.");
			 	jsonData.put("result", "ok");
			 	
			} else {
				//jsonData.put("message", "해당 설비의 진행중인 작업지시가 " + countWorkingWorkOrd + "개 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
				jsonData.put("message", "해당 설비의 '" +countWorkingWorkOrd.getWorkOrdNo()+ "' 작업지시가 진행중에 있습니다.<br>해당 작업지시 진행 취소&종료 후 다시 시도해 주세요!");
	 	 		jsonData.put("result", "fail");
			}
			
		 } catch (Exception e) {
				logger.info("연걸 작업지시 등록 & 연결 자재 등록 에러");
				e.printStackTrace();
				jsonData.put("message", "시스템오류가 발생했습니다.");
				jsonData.put("result", "error");
		 }
		 
		 return jsonData; 
	}
	
	//각 설비별 제조조건 저장 변수
	private static List<EquipCondCombineAdmVo> equipCondCombineAdmVoList = new ArrayList<EquipCondCombineAdmVo>();
	
	//공정실적관리(POP)/작업지시선택 - 설비 제조조건 모니터링
	@RequestMapping(value = "/po/monitoring", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> monitoring(@RequestBody List<Map<String, Object>> agtEquipList) throws Exception {

		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("모니터링 대상 설비 List" + agtEquipList);

		try {
			//제조조건 비교 후 판정List
			List<RedisDataJudgmentVo> agtJudgmentList = new ArrayList<RedisDataJudgmentVo>();
			int index = 0;
			for (Map<String, Object> m : agtEquipList) {
				logger.info("설비명 ===> : " + m);
				String equipNm = (m.get("equipNm").toString());
				
				EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
				equipCodeAdmVo.setEquipNm(equipNm);
				equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
				boolean virtualMachine = false;
				
				//가상설비 일경우
				if (equipCodeAdmVo.getEtc1() != null && !"".equals(equipCodeAdmVo.getEtc1())) {
					equipNm = equipCodeAdmVo.getEtc1();
					virtualMachine = true;
				}
				
				String redisStringData = redisData(equipNm);
				
				//가상설비일 경우 equipNm을 다시 원상태(가상설비)로 돌려줌
				if (virtualMachine) {
					equipNm = equipCodeAdmVo.getEquipNm();
				}
				
				//해당설비 정보X
				if (redisStringData == null || redisStringData.equals("empty")) {
					logger.info(equipNm + " - 해당설비 측정값 없음");
					RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
					redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
					redisJudgmentVo002.setEquipNm(equipNm);
					redisJudgmentVo002.setAgtData("empty");
					redisJudgmentVo002.setMessage(equipNm + " - 설비 실시간 측정값 없음!");
					agtJudgmentList.add(index, redisJudgmentVo002);
					index++;
					
				//해당설비 정보O
				} else {
					logger.info(equipNm + ", 원본 - " + redisStringData);
					//redisStringData = redisStringData.replace("null", "\"0\"");			//null 값 0으로 치환
					//redisStringData = redisStringData.replace("\":\"\"", "\":\"0\"");	//공백 값 0으로 치환
					Gson gson = new Gson();
					RealTimeRedisBomVo realTimeRedisBomVo = gson.fromJson(redisStringData, RealTimeRedisBomVo.class);	//jsonString형식을 Vo에 맞게 변환
					//RedisBomVo readRedisAgtBomVo = gson.fromJson(redisStringData, RedisBomVo.class);	//jsonString형식을 Vo에 맞게 변환
					logger.info(equipNm + ", 변환 - " + realTimeRedisBomVo);
					
					
					//redis에 등록되어있는 시간								//YYYY랑 yyyy랑 다름 주의!
					SimpleDateFormat datetimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					
					//Redis 0번 DB는 regDate 사용
					//Redis 1번 DB는 ctime 사용
					//Date readRegDate = datetimeFormat.parse(readRedisAgtBomVo.getRegDate());
					Date readRegDate = datetimeFormat.parse(realTimeRedisBomVo.getCtime());
					
					long readRegDateToMinute = readRegDate.getTime();
					//logger.info("등록시간 가공전 : " + readRedisAgtBomVo.getRegDate());
					//logger.info("등록시간 가공 후: " + readRegDate);
					
					//현재시간
					Date currentDate = new Date();
					//logger.info("현재시간 가공전: " + currentDate);
					currentDate = datetimeFormat.parse(datetimeFormat.format(currentDate));
					//logger.info("현재시간 가공후: " + currentDate);
					long currentDateToMinute = currentDate.getTime();
					long diffMinute = (currentDateToMinute - readRegDateToMinute) / 60000;
					logger.info("현재시간 - 등록시간 = " + diffMinute);
					
					//1.해당설비의 가장 최근작지정보 불러오기
					WorkOrderVo readMonitoringWorkOrd = new WorkOrderVo();
					readMonitoringWorkOrd.setEquipNm(equipNm);
					readMonitoringWorkOrd = workOrderService.monitoringWorkOrdRead(readMonitoringWorkOrd);
					
					//해당설비의 진행중인 작지X
					if (readMonitoringWorkOrd == null) {
						//RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//redisJudgmentVo002.setEquipNm(equipNm);
						//redisJudgmentVo002.setAgtData("empty");
						//redisJudgmentVo002.setMessage(equipNm + " - 24시간 이내의 진행중인 작업지시 없음!");
						//agtJudgmentList.add(index, redisJudgmentVo002);
						//index++;
						
					//redist에서 불러온 정보가 60분이 지난 데이터임! 경교표시
					} else if (diffMinute > 10 ) {
						logger.info("수집시간이 10분 초과된 데이터!");
						RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						redisJudgmentVo002.setEquipNm(equipNm);
						redisJudgmentVo002.setAgtData("empty");
						redisJudgmentVo002.setMessage(equipNm + " - 설비정보가 수집되고 있지 않습니다! 비전 에이전트를 확인해주세요!");
						agtJudgmentList.add(index, redisJudgmentVo002);
						
					//해당설비의 진행중인 작지O
					} else {
						RedisDataJudgmentVo redisJudgmentVo001 = new RedisDataJudgmentVo();
						redisJudgmentVo001.setTypeCd("001");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						redisJudgmentVo001.setOrdLotNo(readMonitoringWorkOrd.getOrdLotNo());
						redisJudgmentVo001.setWorkOrdNo(readMonitoringWorkOrd.getWorkOrdNo());
						redisJudgmentVo001.setOrdGubun(readMonitoringWorkOrd.getOrdGubun());
						redisJudgmentVo001.setStatusCd(readMonitoringWorkOrd.getWorkStatusCd());
						redisJudgmentVo001.setStatusNm(readMonitoringWorkOrd.getWorkStatusNm());						
						redisJudgmentVo001.setEquipCd(readMonitoringWorkOrd.getEquipCd());
						redisJudgmentVo001.setEquipNm(readMonitoringWorkOrd.getEquipNm());
						redisJudgmentVo001.setGoodsCd(readMonitoringWorkOrd.getGoodsCd());
						redisJudgmentVo001.setGoodsNm(readMonitoringWorkOrd.getGoodsNm());
						redisJudgmentVo001.setMainWorkChargrNm(readMonitoringWorkOrd.getMainWorkChargrNm());
						redisJudgmentVo001.setMainWorkChargr(readMonitoringWorkOrd.getMainWorkChargr());
						agtJudgmentList.add(index, redisJudgmentVo001);
						index++;
						
						//redis(agt)에서 읽어온 값들은 작지랑 매칭이 안 될 수 있음. 따라서 MES상 해당설비 최근12시간 내에 진행중인 작지의 workOrdNo를 넣어줌. 이부분은 작업지시가 1설비장 1개 진행중이며, 현재 redis에서 올라오는 데이터가 지금 실제 설비에서 생산하는 작지의 데이터라는 가정 하에 진행됨.
						//진행중인 작지 제조조건 변경 시 변경값 반영 불가, static 제조조건 초기화 버튼 필요함.
						realTimeRedisBomVo.setEquipCd(readMonitoringWorkOrd.getEquipCd());
						realTimeRedisBomVo.setEquipNm(readMonitoringWorkOrd.getEquipNm());
						realTimeRedisBomVo.setOrdGubun(readMonitoringWorkOrd.getOrdGubun());
						realTimeRedisBomVo.setGoodsCd(readMonitoringWorkOrd.getGoodsCd());
						realTimeRedisBomVo.setGoodsNm(readMonitoringWorkOrd.getGoodsNm());
						realTimeRedisBomVo.setOrdLotNo(readMonitoringWorkOrd.getOrdLotNo());
						realTimeRedisBomVo.setWorkOrdNo(readMonitoringWorkOrd.getWorkOrdNo());
						
						//2. 해당설비 제조조건이 static 변수에 존재 X or 읽어온 제조조건이랑 최근진행중인 작지의 제조조건코드가 맞지 않을 경우 or 사용자가 제조조건 새로고침 버튼 클릭 시 -> 해당설비의 가장 최근작지정보의 제조조건(온도,시간,압력,치수) 통합검색
						//static 제조조건 변수가 비어있거나 || 설비&작지가 일치하지 않거나 || 없으면 -> 해당 설비 삭제 후 reRead 후 다시 넣어줌.
						boolean temp = true;	//true-제조조건 읽어와야함, false-읽어온 제조조건 활용
						int equipNmIndex=0;	//설비명이 같은 제조조건 위치index
						int equipNmEqualsWorkOrdNoIndex=0;	//설비명과 작지가 같은 제조조건 위치 index
						for (equipNmEqualsWorkOrdNoIndex=0; equipNmEqualsWorkOrdNoIndex<equipCondCombineAdmVoList.size(); equipNmEqualsWorkOrdNoIndex++) {
							//설비명만 동일한 위치 기억
							if (equipCondCombineAdmVoList.get(equipNmEqualsWorkOrdNoIndex).getEquipNm().equals(realTimeRedisBomVo.getEquipNm())) {
								equipNmIndex = equipNmEqualsWorkOrdNoIndex;
							}
							//설비명&작지명이 동일하면 기존에 있는 제조조건으로 측정값 비교하면 됨
							//if (equipCondCombineAdmVoList.get(equipNmEqualsWorkOrdNoIndex).getEquipNm().equals(realTimeRedisBomVo.getEquipNm()) && equipCondCombineAdmVoList.get(equipNmEqualsWorkOrdNoIndex).getWorkOrdNo().equals(realTimeRedisBomVo.getWorkOrdNo())) {
							if (equipCondCombineAdmVoList.get(equipNmEqualsWorkOrdNoIndex).getEquipNm().equals(realTimeRedisBomVo.getEquipNm()) && equipCondCombineAdmVoList.get(equipNmEqualsWorkOrdNoIndex).getWorkOrdNo().equals(readMonitoringWorkOrd.getWorkOrdNo())) {
								temp = false;
								break;
							}
						}
						
						//해당 설비&작지 위치에 새로 읽어온 제조조건 덮어쓰기
						if (temp) {
							EquipCondCombineAdmVo equipCondCombineAdmVo = new EquipCondCombineAdmVo();
							equipCondCombineAdmVo.setEquipCondSeq(readMonitoringWorkOrd.getEquipCondSeq());
							equipCondCombineAdmVo = equipCondBomAdmService.equipCondCombineRead(equipCondCombineAdmVo);
							equipCondCombineAdmVo.setEquipCd(readMonitoringWorkOrd.getEquipCd());
							equipCondCombineAdmVo.setEquipNm(readMonitoringWorkOrd.getEquipNm());
							equipCondCombineAdmVo.setGoodsCd(readMonitoringWorkOrd.getGoodsCd());
							equipCondCombineAdmVo.setGoodsNm(readMonitoringWorkOrd.getGoodsNm());
							equipCondCombineAdmVo.setOrdLotNo(readMonitoringWorkOrd.getOrdLotNo());
							equipCondCombineAdmVo.setWorkOrdNo(readMonitoringWorkOrd.getWorkOrdNo());
							
							//비어있으면 add(추가) 존재하면 set(덮어쓰기)
							if (equipCondCombineAdmVoList.isEmpty()) {
								equipCondCombineAdmVoList.add(equipNmEqualsWorkOrdNoIndex, equipCondCombineAdmVo);
							} else {
								//해당설비 위치에다가 덮어써야함.
								equipCondCombineAdmVoList.set(equipNmIndex, equipCondCombineAdmVo);	
							}
							
						//3.해당 제조조건 비교하기
						//기존 제조조건을 활용하여 측정값 비교, 제조조건 & redis 데이터들을 POP로 넘겨줘서 JSP단에서 비교해줘도 됨. 
						}
						//equipNmIndex 요위치에 있는 값하고 readRedisAgtBomVo요거랑 비교하면 됨
						EquipCondCombineAdmVo compareEquipCond = equipCondCombineAdmVoList.get(equipNmIndex);
						
						//온도
						for (int i=0; i<realTimeRedisBomVo.getDataSetTempNm().length; i++) {
							String tempNm = realTimeRedisBomVo.getDataSetTempNm()[i];
							if (null == tempNm) {
								break;
							//1차메탈상좌
							} else if ("1stMLeftUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_firstUpleftAlwnceMinus(), compareEquipCond.getA_firstUpleftCond(), compareEquipCond.getA_firstUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_firstUpleftAlwnceMinus(), compareEquipCond.getA_firstUpleftCond(), compareEquipCond.getA_firstUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차메탈상좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차메탈상우
							} else if ("1stMRightUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_firstUprightAlwnceMinus(), compareEquipCond.getA_firstUprightCond(), compareEquipCond.getA_firstUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_firstUprightAlwnceMinus(), compareEquipCond.getA_firstUprightCond(), compareEquipCond.getA_firstUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차메탈상우 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차메탈하좌
							} else if ("1stMLeftDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_firstDownleftAlwnceMinus(), compareEquipCond.getA_firstDownleftCond(), compareEquipCond.getA_firstDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_firstDownleftAlwnceMinus(), compareEquipCond.getA_firstDownleftCond(), compareEquipCond.getA_firstDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차메탈하우
							} else if ("1stMRightDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_firstDownrightAlwnceMinus(), compareEquipCond.getA_firstDownrightCond(), compareEquipCond.getA_firstDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_firstDownrightAlwnceMinus(), compareEquipCond.getA_firstDownrightCond(), compareEquipCond.getA_firstDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접1상
							} else if ("Jinjub1Up".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_jinjeop1UpAlwnceMinus(), compareEquipCond.getA_jinjeop1UpCond(), compareEquipCond.getA_jinjeop1UpAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_jinjeop1UpAlwnceMinus(), compareEquipCond.getA_jinjeop1UpCond(), compareEquipCond.getA_jinjeop1UpAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 진접1상 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접1하
							} else if ("Jinjub1Down".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_jinjeop1DownAlwnceMinus(), compareEquipCond.getA_jinjeop1DownCond(), compareEquipCond.getA_jinjeop1DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_jinjeop1DownAlwnceMinus(), compareEquipCond.getA_jinjeop1DownCond(), compareEquipCond.getA_jinjeop1DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 진접1하 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//2차메탈상좌
							} else if ("2ndMLeftUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_secondUpleftAlwnceMinus(), compareEquipCond.getA_secondUpleftCond(), compareEquipCond.getA_secondUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_secondUpleftAlwnceMinus(), compareEquipCond.getA_secondUpleftCond(), compareEquipCond.getA_secondUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 2차메탈상좌 이상!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//2차메탈상우
							} else if ("2ndMRightUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_secondUprightAlwnceMinus(), compareEquipCond.getA_secondUprightCond(), compareEquipCond.getA_secondUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_secondUprightAlwnceMinus(), compareEquipCond.getA_secondUprightCond(), compareEquipCond.getA_secondUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 2차메탈상우 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//2차메탈하좌
							} else if ("2ndMLeftDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_secondDownleftAlwnceMinus(), compareEquipCond.getA_secondDownleftCond(), compareEquipCond.getA_secondDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_secondDownleftAlwnceMinus(), compareEquipCond.getA_secondDownleftCond(), compareEquipCond.getA_secondDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 2차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//2차메탈하우
							} else if ("2ndMRightDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_secondDownrightAlwnceMinus(), compareEquipCond.getA_secondDownrightCond(), compareEquipCond.getA_secondDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_secondDownrightAlwnceMinus(), compareEquipCond.getA_secondDownrightCond(), compareEquipCond.getA_secondDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 2차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차푸셔상
							} else if ("1stMPusherUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_push1UpAlwnceMinus(), compareEquipCond.getA_push1UpCond(), compareEquipCond.getA_push1UpAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_push1UpAlwnceMinus(), compareEquipCond.getA_push1UpCond(), compareEquipCond.getA_push1UpAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차푸셔상 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차푸셔하
							} else if ("1stMPusherDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_push1DownAlwnceMinus(), compareEquipCond.getA_push1DownCond(), compareEquipCond.getA_push1DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_push1DownAlwnceMinus(), compareEquipCond.getA_push1DownCond(), compareEquipCond.getA_push1DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 1차푸셔하 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//3차메탈상좌
							} else if ("3rdMLeftUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_thirdUpleftAlwnceMinus(), compareEquipCond.getA_thirdUpleftCond(), compareEquipCond.getA_thirdUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_thirdUpleftAlwnceMinus(), compareEquipCond.getA_thirdUpleftCond(), compareEquipCond.getA_thirdUpleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 3차메탈상좌 이상!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//3차메탈상우
							} else if ("3rdMRightUp".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_thirdUprightAlwnceMinus(), compareEquipCond.getA_thirdUprightCond(), compareEquipCond.getA_thirdUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_thirdUprightAlwnceMinus(), compareEquipCond.getA_thirdUprightCond(), compareEquipCond.getA_thirdUprightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 3차메탈상우 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//3차메탈하좌
							} else if ("3rdMLeftDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_thirdDownleftAlwnceMinus(), compareEquipCond.getA_thirdDownleftCond(), compareEquipCond.getA_thirdDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_thirdDownleftAlwnceMinus(), compareEquipCond.getA_thirdDownleftCond(), compareEquipCond.getA_thirdDownleftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 3차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//3차메탈하우
							} else if ("3rdMRightDown".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_thirdDownrightAlwnceMinus(), compareEquipCond.getA_thirdDownrightCond(), compareEquipCond.getA_thirdDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_thirdDownrightAlwnceMinus(), compareEquipCond.getA_thirdDownrightCond(), compareEquipCond.getA_thirdDownrightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 3차메탈하좌 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접2상
							} else if ("Jinjub2U".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_jinjeop2UpAlwnceMinus(), compareEquipCond.getA_jinjeop2UpCond(), compareEquipCond.getA_jinjeop2UpAlwncePlus(),  Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_jinjeop2UpAlwnceMinus(), compareEquipCond.getA_jinjeop2UpCond(), compareEquipCond.getA_jinjeop2UpAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 진접2상 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접2하
							} else if ("Jinjub2D".equals(tempNm)) {
								if (compareData(compareEquipCond.getA_jinjeop2DownAlwnceMinus(), compareEquipCond.getA_jinjeop2DownCond(), compareEquipCond.getA_jinjeop2DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i]))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getA_jinjeop2DownAlwnceMinus(), compareEquipCond.getA_jinjeop2DownCond(), compareEquipCond.getA_jinjeop2DownAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetTempVal()[i])) + " - 온도 진접2하 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							} else {
								continue;
							}
						}
						
						//시간
						for (int i=0; i<realTimeRedisBomVo.getDataSetTimeNm().length; i++) {
							String timeNm = realTimeRedisBomVo.getDataSetTimeNm()[i];
							if (null == timeNm) {
								break;
							//가접1
							} else if ("gaungchakpresstime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_fitupAlwnceMinus(), compareEquipCond.getB_fitupCond(), compareEquipCond.getB_fitupAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_fitupAlwnceMinus(), compareEquipCond.getB_fitupCond(), compareEquipCond.getB_fitupAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 가접1 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차 메탈
							} else if ("1stMTheattime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_firstAlwnceMinus(), compareEquipCond.getB_firstCond(), compareEquipCond.getB_firstAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_firstAlwnceMinus(), compareEquipCond.getB_firstCond(), compareEquipCond.getB_firstAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 1차메탈 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//1차 푸셔
							} else if ("1stMTpushtime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_push1AlwnceMinus(), compareEquipCond.getB_push1Cond(), compareEquipCond.getB_push1AlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_push1AlwnceMinus(), compareEquipCond.getB_push1Cond(), compareEquipCond.getB_push1AlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 1차푸셔 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접1
							} else if ("jinjubtime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_jinjeopAlwnceMinus(), compareEquipCond.getB_jinjeopCond(), compareEquipCond.getB_jinjeopAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_jinjeopAlwnceMinus(), compareEquipCond.getB_jinjeopCond(), compareEquipCond.getB_jinjeopAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 진접1 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//2차메탈
							} else if ("2ndMTheattime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_secondAlwnceMinus(), compareEquipCond.getB_secondCond(), compareEquipCond.getB_secondAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_secondAlwnceMinus(), compareEquipCond.getB_secondCond(), compareEquipCond.getB_secondAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 2차메탈 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//냉각
							} else if ("cooltime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_coolAlwnceMinus(), compareEquipCond.getB_coolCond(), compareEquipCond.getB_coolAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_coolAlwnceMinus(), compareEquipCond.getB_coolCond(), compareEquipCond.getB_coolAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 냉각 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//진접2 = 리폼
							} else if ("reformtime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_jinjeop2AlwnceMinus(), compareEquipCond.getB_jinjeop2Cond(), compareEquipCond.getB_jinjeop2AlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_jinjeop2AlwnceMinus(), compareEquipCond.getB_jinjeop2Cond(), compareEquipCond.getB_jinjeop2AlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 진접1 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							//3차메탈
							} else if ("3rdMTheattime".equals(timeNm)) {
								if (compareData(compareEquipCond.getB_thirdAlwnceMinus(), compareEquipCond.getB_thirdCond(), compareEquipCond.getB_thirdAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i])))) {
									RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
									redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
									redisJudgmentVo002.setEquipNm(equipNm);
									//redisJudgmentVo002.setAgtData("empty");
									redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getB_thirdAlwnceMinus(), compareEquipCond.getB_thirdCond(), compareEquipCond.getB_thirdAlwncePlus(), (Double.parseDouble(realTimeRedisBomVo.getDataSetTimeVal()[i]))) + " - 시간 3차메탈 이상발생!");
									agtJudgmentList.add(index, redisJudgmentVo002);
									index++;
								}
								continue;
							} else {
								continue;
							}
						}
						
						//압력
						//for (int i=0; i<realTimeRedisBomVo.getDataSetPrssNm().length; i++) {
						//	String pressureNm = realTimeRedisBomVo.getDataSetPrssNm()[i];
						//	if (null == pressureNm) {
						//		break;
						//	//1차 푸셔
						//	} else if ("IF_Pressure_1ch".equals(pressureNm)) {
						//		if (compareData(compareEquipCond.getC_push1AlwnceMinus(), compareEquipCond.getC_push1Cond(), compareEquipCond.getC_push1AlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getC_push1AlwnceMinus(), compareEquipCond.getC_push1Cond(), compareEquipCond.getC_push1AlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i])) + " - 압력 1차푸셔 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//1차 진접
						//	} else if ("IF_Pressure_2ch".equals(pressureNm)) {
						//		if (compareData(compareEquipCond.getC_jinjeopAlwnceMinus(), compareEquipCond.getC_jinjeopCond(), compareEquipCond.getC_jinjeopAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getC_jinjeopAlwnceMinus(), compareEquipCond.getC_jinjeopCond(), compareEquipCond.getC_jinjeopAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i])) + " - 압력 1차진접 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//2차 진접
						//	} else if ("IF_Pressure_3ch".equals(pressureNm)) {
						//		if (compareData(compareEquipCond.getC_jinjeop2AlwnceMinus(), compareEquipCond.getC_jinjeop2Cond(), compareEquipCond.getC_jinjeop2AlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getC_jinjeop2AlwnceMinus(), compareEquipCond.getC_jinjeop2Cond(), compareEquipCond.getC_jinjeop2AlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetPrssVal()[i])) + " - 압력 2차진접 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	} else {
						//		continue;
						//	}
						//}
						
						//치수
						//for (int i=0; i<realTimeRedisBomVo.getDataSetVisionNm().length; i++) {
						//	String sizeNm = realTimeRedisBomVo.getDataSetVisionNm()[i];
						//	if (null == sizeNm) {
						//		break;
						//	//WP좌
						//	} else if ("HeadLength_Left".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_wpLeftAlwnceMinus(), compareEquipCond.getD_wpLeftCond(), compareEquipCond.getD_wpLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_wpLeftAlwnceMinus(), compareEquipCond.getD_wpLeftCond(), compareEquipCond.getD_wpLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 WP좌 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//Pitch좌
						//	} else if ("MetalLength_Left".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_pitchLeftAlwnceMinus(), compareEquipCond.getD_pitchLeftCond(), compareEquipCond.getD_pitchLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_pitchLeftAlwnceMinus(), compareEquipCond.getD_pitchLeftCond(), compareEquipCond.getD_pitchLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 Pitch좌 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//PPF날개좌
						//	} else if ("WingLength_Left".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_ppfWingLeftAlwnceMinus(), compareEquipCond.getD_ppfWingLeftCond(), compareEquipCond.getD_ppfWingLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_ppfWingLeftAlwnceMinus(), compareEquipCond.getD_ppfWingLeftCond(), compareEquipCond.getD_ppfWingLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 PPF날개좌 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//WP우
						//	} else if ("HeadLength_Right".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_wpRightAlwnceMinus(), compareEquipCond.getD_wpRightCond(), compareEquipCond.getD_wpRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_wpRightAlwnceMinus(), compareEquipCond.getD_wpRightCond(), compareEquipCond.getD_wpRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 WP우 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//Pitch우
						//	} else if ("MetalLength_Right".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_pitchRightAlwnceMinus(), compareEquipCond.getD_pitchRightCond(), compareEquipCond.getD_pitchRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_pitchRightAlwnceMinus(), compareEquipCond.getD_pitchRightCond(), compareEquipCond.getD_pitchRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 Pitch우 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//PPF날개우
						//	} else if ("WingLength_Right".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_ppfWingRightAlwnceMinus(), compareEquipCond.getD_ppfWingRightCond(), compareEquipCond.getD_ppfWingRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_ppfWingRightAlwnceMinus(), compareEquipCond.getD_ppfWingRightCond(), compareEquipCond.getD_ppfWingRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 PPF날개우 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//P.P Film 폭 내측 좌
						//	} else if ("FilmWidth_Left_Inside".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_ppfDepthLeftAlwnceMinus(), compareEquipCond.getD_ppfDepthLeftCond(), compareEquipCond.getD_ppfDepthLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_ppfDepthLeftAlwnceMinus(), compareEquipCond.getD_ppfDepthLeftCond(), compareEquipCond.getD_ppfDepthLeftAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 PPF날개우 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	//P.P Film 폭 내측 우
						//	} else if ("FilmWidth_Right_Inside".equals(sizeNm)) {
						//		if (compareData(compareEquipCond.getD_ppfDepthRightAlwnceMinus(), compareEquipCond.getD_ppfDepthRightCond(), compareEquipCond.getD_ppfDepthRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]))) {
						//			RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//			redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//			redisJudgmentVo002.setEquipNm(equipNm);
						//			//redisJudgmentVo002.setAgtData("empty");
						//			redisJudgmentVo002.setMessage(equipNm + compareErrorMessage(compareEquipCond.getD_ppfDepthRightAlwnceMinus(), compareEquipCond.getD_ppfDepthRightCond(), compareEquipCond.getD_ppfDepthRightAlwncePlus(), Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i])) + " - 치수 PPF우 이상발생!");
						//			agtJudgmentList.add(index, redisJudgmentVo002);
						//			index++;
						//		}
						//		continue;
						//	////돌기좌상높이
						//	//} else if ("FilmDolgi_LeftUp_Height".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeLeftupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기좌상너비
						//	//} else if ("FilmDolgi_LeftUp_Width".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeLeftupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기좌하높이
						//	//} else if ("FilmDolgi_LeftDown_Height".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeLeftdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기좌하너비
						//	//} else if ("FilmDolgi_LeftDown_Width".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeLeftdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기우상높이
						//	//} else if ("FilmDolgi_RightUp_Height".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeRightupHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기우상너비
						//	//} else if ("FilmDolgi_RightUp_Width".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeRightupWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기우하높이
						//	//} else if ("FilmDolgi_RightDown_Height".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeRightdownHeight(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//	////돌기우하너비
						//	//} else if ("FilmDolgi_RightDown_Width".equals(sizeNm)) {
						//	//	sizeAgtVo.setBulgeRightdownWidth(realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//	//	continue;
						//		
						//	//(필름상 + 필름하)/2 = 필름 폭
						//	} else if ("FilmTotalLength_Up".equals(sizeNm)) {
						//		for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
						//			String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
						//			if ("FilmTotalLength_Down".equals(sizeNm2)) {
						//				double sum = (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2;
						//				if ( sum != 0 ) {
						//					if ( (Double.parseDouble(compareEquipCond.getD_filmCond()) - Double.parseDouble(compareEquipCond.getD_filmAlwnceMinus()) > sum ) || (Double.parseDouble(compareEquipCond.getD_filmCond()) + Double.parseDouble(compareEquipCond.getD_filmAlwncePlus()) < sum ) ) {
						//						RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//						redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//						redisJudgmentVo002.setEquipNm(equipNm);
						//						//redisJudgmentVo002.setAgtData("empty");
						//						redisJudgmentVo002.setMessage(equipNm + "설비이상! 조건 : -" + compareEquipCond.getD_filmAlwnceMinus() + " [" + compareEquipCond.getD_filmCond() + "]" + " +" + compareEquipCond.getD_filmAlwncePlus() + " 측정 값 : " + String.valueOf(sum) + " - 치수 필름 폭 이상발생!");
						//						agtJudgmentList.add(index, redisJudgmentVo002);
						//						index++;
						//					}
						//					logger.info("필름 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//					logger.info("필름 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
						//				}
						//				break;
						//			}
						//		}
						//		continue;
						//	//(메탈폭상 + 메탈폭하)/2 = 메탈 폭
						//	} else if ("MetalWidth_Up".equals(sizeNm)) {
						//		for (int j=0; j<realTimeRedisBomVo.getDataSetVisionNm().length; j++) {
						//			String sizeNm2 = realTimeRedisBomVo.getDataSetVisionNm()[j];
						//			if ("MetalWidth_Down".equals(sizeNm2)) {
						//				double sum = (Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[i]) + Double.parseDouble(realTimeRedisBomVo.getDataSetVisionVal()[j])) / 2;
						//				if ( sum != 0 ) {
						//					if ( (Double.parseDouble(compareEquipCond.getD_metalDepthCond()) - Double.parseDouble(compareEquipCond.getD_metalDepthAlwnceMinus()) > sum ) || (Double.parseDouble(compareEquipCond.getD_metalDepthCond()) + Double.parseDouble(compareEquipCond.getD_metalDepthAlwncePlus()) < sum ) ) {
						//						RedisDataJudgmentVo redisJudgmentVo002 = new RedisDataJudgmentVo();
						//						redisJudgmentVo002.setTypeCd("002");	//001-> 모니터링 대상설비목록  현황 정보, 002->모니터링 이상알람 정보
						//						redisJudgmentVo002.setEquipNm(equipNm);
						//						//redisJudgmentVo002.setAgtData("empty");
						//						redisJudgmentVo002.setMessage(equipNm + "설비이상! 조건 : -" + compareEquipCond.getD_metalDepthAlwnceMinus() + " [" + compareEquipCond.getD_metalDepthCond() + "]" + " +" + compareEquipCond.getD_metalDepthAlwncePlus() + " 측정 값 : " + String.valueOf(sum) + " - 치수 메탈 폭 이상발생!");
						//						agtJudgmentList.add(index, redisJudgmentVo002);
						//						index++;
						//					}
						//					logger.info("메탈 폭 상 - " + realTimeRedisBomVo.getDataSetVisionVal()[i]);
						//					logger.info("메탈 폭 하 - " + realTimeRedisBomVo.getDataSetVisionVal()[j]);
						//					break;
						//				}
						//			}			
						//		}
						//		continue;
						//		
						//	} else {
						//		continue;
						//	}
						//}
						
						//for (int kk=0; kk<equipCondCombineAdmVoList.size(); kk++) {
						//	System.out.println("제조조건(Cond) - " + kk + " : " + equipCondCombineAdmVoList.get(kk));
						//}
						//for (int kk=0; kk<agtJudgmentList.size(); kk++) {
						//	System.out.println(equipNm + "설비 이상 - " + kk + " : " + agtJudgmentList.get(kk));
						//}
						
					}
				}
			}
			
			jsonData.put("data", agtJudgmentList);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("POP모니터링 오류");
			e.printStackTrace();
			jsonData.put("message", "모니터링 오류가 발생했습니다.");
			jsonData.put("result", "error");
		}

		return jsonData;
	}
	
	//제조조건, 측정기록 전달받아 비교, false=이상없음, true=이상
	public boolean compareData(String minus, String cond, String plus, double data) {
		boolean compare = false;
		if ((Double.parseDouble(cond) - Double.parseDouble(minus) > data) || (Double.parseDouble(cond) + Double.parseDouble(plus) < data)) {
			compare = true;
		}
		
		return compare;
	}
	
	//측정치 이상일 경우 조건과 측정치를 정리해서 message에 넣어줌.
	public String compareErrorMessage(String minus, String cond, String plus, double data) {
		String compareErrorMessage;
		compareErrorMessage = "설비이상! 조건 : -" + minus + " [" + cond + "]" + " +" + plus + " 측정 값 : " + String.valueOf(data);
		
		return compareErrorMessage;
	}

	//공정실적관리 작업지시 페이지
	@RequestMapping(value = "/po/posc0010_alarm", method = RequestMethod.GET)
	public String posc0010_alarm(Locale locale, Model model, HttpServletRequest request, HttpSession session) throws Exception {
		
		logger.info("공정실적관리(POP) - 모니터링 이상 알람");
		
		return "po/posc0010_alarm";
	}
	
	public String redisData(String equipNm) {
		String redisAgtData = "emtpy";
		try {
			if (equipNm == null || equipNm.equals("")) {

			} else {
				JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
				//JedisPool pool = new JedisPool(jedisPoolConfig, "220.90.132.250", 6379, 1000);
				//JedisPool pool = new JedisPool(jedisPoolConfig, "192.168.231.97", 6379, 1000);
				JedisPool pool = new JedisPool(jedisPoolConfig, dgsRedisIP, 6379, 1000);
				
				//Jedis풀 생성(JedisPoolConfig, host, port, timeout, password)
				Jedis jedis = pool.getResource();//thread, db pool처럼 필요할 때마다 getResource()로 받아서 쓰고 다 쓰면 close로 닫아야 한다.
				//jedis.auth("비밀번호");
				jedis.select(0); //DB 선택

				redisAgtData = jedis.get(equipNm);
				if (jedis != null) {
					jedis.close();
				}
				pool.close();

			}
		} catch (Exception e) {
			logger.info("pop 모니터링 Redis 에러");
			e.printStackTrace();
		}

		return redisAgtData;
	}
	
	
	//--------작업자 변경 관련 사항--------//
	
	//자업자 변경 조회
	@RequestMapping(value = "/po/workerChangeList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workerChangeList(WorkerChangeVo workerChangeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자업자 변경 조회 = " + workerChangeVo);
		try {
			List<WorkerChangeVo> workerChangeList = workOrderService.workerChangeList(workerChangeVo);
			jsonData.put("data", workerChangeList);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자업자 변경 목록조회 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//자업자 변경 상세조회
	@RequestMapping(value = "/po/workerChangeRead", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> workerChangeRead(WorkerChangeVo workerChangeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자업자 변경 상세조회 = " + workerChangeVo);
		try {
			WorkerChangeVo workerChangeRead = workOrderService.workerChangeRead(workerChangeVo);
			jsonData.put("data", workerChangeRead);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자업자 변경 상세조회 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//자업자 변경 등록
	@RequestMapping(value = "/po/workerChangeCreate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workerChangeCreate(WorkerChangeVo workerChangeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자업자 변경 등록 = " + workerChangeVo);
		try {
			
			String workOrdNumber	= DateUtil.getToday("yyyyMMdd").substring(2,8);
			String seq 				= workOrderService.workerChangeSeq(workOrdNumber);
			String workOrdNo		= workOrdNumber+'-'+seq;
			logger.info("workOrdNo ----> "+workOrdNo);
			
			workerChangeVo.setWorkChangSeq(workOrdNo);
			workerChangeVo.setRegId(Utils.getUserId());
			workOrderService.workerChangeCreate(workerChangeVo);

			//작업자가 변경되었을 때 _작업지시 작업조 값 Update
			if(workerChangeVo.getWorkerStatusCd().equals("H")) {
				WorkOrderVo workOrderVo = new WorkOrderVo();
				workOrderVo.setWorkTeamCd(workerChangeVo.getWorkTeamCd());
				workOrderVo.setWorkOrdNo(workerChangeVo.getWorkOrdNo());
				workOrderVo.setUpdId(Utils.getUserId());
				workOrderService.updateWorkOrder(workOrderVo);
			}
			
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자업자 변경 등록 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//자업자 변경 수정
	@RequestMapping(value = "/po/workerChangeUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workerChangeUpdate(WorkerChangeVo workerChangeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자업자 변경 수정 = " + workerChangeVo);
		try {
			workerChangeVo.setUpdId(Utils.getUserId());
			workOrderService.workerChangeUpdate(workerChangeVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자업자 변경 수정 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//자업자 변경 삭제
	@RequestMapping(value = "/po/workerChangeDelete", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workerChangeDelete(WorkerChangeVo workerChangeVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자업자 변경 삭제 = " + workerChangeVo);
		try {
			workerChangeVo.setUpdId(Utils.getUserId());
			workOrderService.workerChangeDelete(workerChangeVo);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("자업자 변경 삭제 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	//--------작업자 변경 관련 사항 끝--------//
	
	
	//--------주자재 교체 관련 사항 시작--------//
	
	//작지 주자재 교체
	@RequestMapping(value = "/po/workOrderMetalChangeAllUpdate", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> workOrderMetalChangeAllUpdate(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작지 주자재 교체 = " + workOrderVo);
		try {
			
			/*기존 lotNo 자재가 - 신규투입 -> 자재상태 O로, OUT_WHS_DATE과 같이 OUT과 관련된거 NULL로 보정
			기존 lotNo 자재가 - 재투입 -> 보정X
			바꿀 lotNo 자재가 - 신규투입이면 자재상태 P로 교체하기, OUT_WHS_DATE과 같이 OUT과 관련된거 보정 TB_IN_OUT_WHS_ADM
			바꿀 lotNo 자재가 - 재투입 -> 보정X*/
			
			//기존
			//신규 투입 lotNo교체 시 재투입된 lotNo가 있는지 값 확인 만약 재투입된 자재가 있으면 교체 못하게 적용.
			//신규 투입 lotNo교체 시 재투입된 자재가 없으면 교체할 수 있음.
			//재투입 lotNo 교체 시 불량 상태가 불량이면 교체 못함
			//재투입 lotNo 교체 시 불량 상태가 정상이면 교체 가능할 수 있게.
			
			String workOrdNo 	= workOrderVo.getWorkOrdNo();
			String lotNo		= workOrderVo.getLotNo();
			String beforeLotNo	= workOrderVo.getBeforeLotNo();
			String afterLotNo 	= workOrderVo.getAfterLotNo();
			String barcodeNo	= workOrderVo.getBarcodeNo();
			
			String ordDate		= workOrderVo.getOrdDate();
			String equipCd		= workOrderVo.getEquipCd();
			String goodsCd		= workOrderVo.getGoodsCd();
			
			//자재 상태 값 체크
			MatrlInOutWhsAdmVo newMatrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
			newMatrlInOutWhsAdmVo.setBarcodeNo(afterLotNo);
			newMatrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(newMatrlInOutWhsAdmVo);
			
			//선택한 주자재가 불량인지 검사
			workOrderVo = workOrderService.workOrderDtlRead(workOrderVo);
			
			//재투입된 자재 있는지 확인
			int workOrderDtlCount = workOrderService.workOrderDtlCount(workOrderVo);
			
			//불량 검사 (001: 정상, 002 : 불량, 003: 불량재투입, 004: 재불량)
			if( workOrderVo.getFaultyStatus().equals("001") || workOrderVo.getFaultyStatus().equals("003") ){
				
				//포장이 등록 되어있는지 값 검사
				WorkOrdOutputSubVo workOrdOutputSubVo = new WorkOrdOutputSubVo();
				workOrdOutputSubVo.setWorkOrdNo(workOrdNo);
				workOrdOutputSubVo.setLotNo(lotNo);
				List<WorkOrdOutputSubVo> workOrdOutputSubList = workOrdOutputSubService.workOrdOutputSubList(workOrdOutputSubVo);
				logger.info("포장 여부 확인" + workOrdOutputSubList);
				
				//포장 여부 확인
				for(int i = 0; i < workOrdOutputSubList.size(); i++) {
					if(workOrdOutputSubList.get(i).getPackYn() != null) {
						if(workOrdOutputSubList.get(i).getPackYn().contains("Y")) {
							jsonData.put("message", "교체 전(MetalLot)가 포장되어 있습니다.<br> 포장되어 있는 주자재는 교체할 수 없습니다.");
							jsonData.put("result", "fail");
							return jsonData;
						}
					}
				}
				//포장 여부 확인 끝
				
				//생산 실적(Tray) 저장되어 있는지 확인하는 부분
				ProductionPerfTrayVo productionPerfTrayVo = new ProductionPerfTrayVo();
				productionPerfTrayVo.setEquipCd(equipCd);
				productionPerfTrayVo.setWorkOrdNo(workOrdNo);
				productionPerfTrayVo = productionPerfTrayService.productionPerfTrayDeleteCheck(productionPerfTrayVo);
				int trayDeleteCheck = Integer.parseInt( productionPerfTrayVo.getDeleteCheck() );
				
				//생산실적(Tray)값 저장되어있는 경우(001인 경우에만 수정 가능함)
				if( trayDeleteCheck != 0 ) {
					jsonData.put("message", "교체 전(MetalLot)가 생산실적(Tray)에<br>등록되어 있습니다.<br>등록 되어 있는 주자재는 교체할 수 없습니다.");
					jsonData.put("result", "fail");
					return jsonData;
				}
				//생산 실적(Tray) 저장되어 있는지 확인하는 부분 끝
				
				
				//기존_lotNo가 신규투입인 경우
				if(workOrderVo.getRemakeYn().equals("N")) {	// N: 신규 투입, Y: 재투입
					
					//재투입 된 자재 확인_(기존_lotNo에 재투입된 lotNo가 없으 때)
					if(workOrderDtlCount == 0) {
						workOrderVo.setStatusCd("O");
						workOrderVo.setOutWhsDate(null);
						workOrderVo.setOutEquipCd(null);
						workOrderVo.setOutGoodsCd(null);
						workOrderVo.setOutQty(null);
						workOrderVo.setMetalChangeRemakeYn("Y");	//입출고관리 Update
						
						workOrderVo.setEquipCd(equipCd);
						workOrderVo.setWorkOrdNo(workOrdNo);
						workOrderVo.setBeforeLotNo(beforeLotNo);
						workOrderVo.setAfterLotNo(afterLotNo);
						
						//교체 하고자 하는 LOT_NO에 상태값 확인 /재사용인 경우 불량재사용 값으로 들어가기 위해 003으로 변경해준다.
						workOrderVo.setFaultyStatus( newMatrlInOutWhsAdmVo.getApprovalCd().equals("009") ? "003" : newMatrlInOutWhsAdmVo.getApprovalCd() );
						workOrderVo.setRegId(Utils.getUserId());
						workOrderVo.setUpdId(Utils.getUserId());
						
						if(newMatrlInOutWhsAdmVo.getStatusCd().equals("O")) {
							workOrderVo.setRemakeYn("N");
						} else {
							workOrderVo.setRemakeYn("Y");
						}
						
						workOrderService.workOrderMetalChangeAllUpdate(workOrderVo);	//묶여 있는 LotNo 전체 수정해주는 부분
						workOrderService.workOrderMetalChangeHistCreate(workOrderVo);
						
						MatrlInOutWhsAdmVo beforeMatrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
						beforeMatrlInOutWhsAdmVo.setBarcodeNo(beforeLotNo);
						matrlInOutWhsAdmService.insertMatrlHist(beforeMatrlInOutWhsAdmVo);	//자재이력등록
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						//기존LotNo 가출고상태로 변경하였으니 자재 생산실창고(004)에 다시 + 해줌
						beforeMatrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(beforeMatrlInOutWhsAdmVo);
						StockPaymentAdmVo matrlStockPaymentAdmVoPlus = new StockPaymentAdmVo();
						matrlStockPaymentAdmVoPlus = StockPaymentAdmController.matrlStockPaymentPlus(beforeMatrlInOutWhsAdmVo, factoryCode);
						stockPaymentAdmService.stockPaymentPlus(matrlStockPaymentAdmVoPlus);	//새 위치 재고 +
						
						//신규_lotNo -> 자재가 상태가 O(최초 투입일 경우)
						if(newMatrlInOutWhsAdmVo.getStatusCd().equals("O")) {
							workOrderVo.setStatusCd("P");
							workOrderVo.setOrdDate(ordDate);
							workOrderVo.setEquipCd(equipCd);
							workOrderVo.setGoodsCd(goodsCd);
							
							MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
							matrlInOutWhsAdmVo.setBarcodeNo(afterLotNo);
							workOrderService.updateOutWhsStatus(workOrderVo);				//자재 출고상태로 교체
							matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);	//자재이력등록
							
							//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
							//새LotNo 가출고->출고 상태로 변경하였으니 자재 생산실창고(004)에 다시 - 해줌
							MatrlInOutWhsAdmVo afterMatrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
							afterMatrlInOutWhsAdmVo.setBarcodeNo(afterLotNo);
							afterMatrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(afterMatrlInOutWhsAdmVo);
							StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
							matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(afterMatrlInOutWhsAdmVo, "O", factoryCode);
							stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//새 위치 재고 +
						}
						//신규_lotNo
						
					} else {
						//재투입 된 자재 확인_(기존_lotNo에 재투입된 lotNo가 있을 때)
						jsonData.put("message", "교체 전(MetalLot)에 재투입된 주자재가 존재합니다.<br> 재투입된 주자재가 있어 교체할 수 없습니다.");
						jsonData.put("result", "fail");
						return jsonData;
					}
					
				} else {
					//기존_lotNo가 재투입인 경우
					workOrderVo.setMetalChangeRemakeYn(null);	//기존_lotNo 입출고관리 Update 안함
					
					workOrderVo.setEquipCd(equipCd);
					workOrderVo.setWorkOrdNo(workOrdNo);
					workOrderVo.setBeforeLotNo(beforeLotNo);
					workOrderVo.setAfterLotNo(afterLotNo);
					
					//교체 하고자 하는 LOT_NO에 상태값 확인 /재사용인 경우 불량재사용 값으로 들어가기 위해 003으로 변경해준다.
					workOrderVo.setFaultyStatus( newMatrlInOutWhsAdmVo.getApprovalCd().equals("009") ? "003" : newMatrlInOutWhsAdmVo.getApprovalCd() );
					workOrderVo.setRegId(Utils.getUserId());
					workOrderVo.setUpdId(Utils.getUserId());
					
					if(newMatrlInOutWhsAdmVo.getStatusCd().equals("O")) {
						workOrderVo.setRemakeYn("N");
					} else {
						workOrderVo.setRemakeYn("Y");
					}
					
					workOrderService.workOrderMetalChangeAllUpdate(workOrderVo);
					workOrderService.workOrderMetalChangeHistCreate(workOrderVo);
					
					//신규_lotNo -> 자재가 상태가 O(최초 투입일 경우)
					if(newMatrlInOutWhsAdmVo.getStatusCd().equals("O")) {
						workOrderVo.setStatusCd("P");
						workOrderVo.setOrdDate(ordDate);
						workOrderVo.setEquipCd(equipCd);
						workOrderVo.setGoodsCd(goodsCd);
						
						MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
						matrlInOutWhsAdmVo.setBarcodeNo(afterLotNo);
						workOrderService.updateOutWhsStatus(workOrderVo);				//자재 출고상태로 교체
						matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);	//자재이력등록
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						MatrlInOutWhsAdmVo afterMatrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
						afterMatrlInOutWhsAdmVo.setBarcodeNo(afterLotNo);
						afterMatrlInOutWhsAdmVo = matrlInOutWhsAdmService.barcodeRead(afterMatrlInOutWhsAdmVo);
						StockPaymentAdmVo matrlStockPaymentAdmVoMinus = new StockPaymentAdmVo();
						matrlStockPaymentAdmVoMinus = StockPaymentAdmController.matrlStockPaymentMinus(afterMatrlInOutWhsAdmVo, "O", factoryCode);
						stockPaymentAdmService.stockPaymentMinus(matrlStockPaymentAdmVoMinus);	//새 위치 재고 +
						
					}
					//신규_lotNo
				}
				
			} else {
				jsonData.put("message", "교체 전(MetalLot)에 자재가 불량 입니다.<br> 불량인 주자재는 교체할 수 없습니다.");
				jsonData.put("result", "fail");
				return jsonData;
			}
			
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("작지 주자재 교체 오류");
			e.printStackTrace();
			jsonData.put("message", "오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}
		return jsonData;
	}
	
	//--------주자재 교체 관련 사항 끝--------//	
	
	
	//설비별 투입 중량 조회_wmsc0140 사용
	@RequestMapping(value = "wm/inputWeightList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> inputWeightList(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("설비별 투입 중량 조회");
		try {
			List<WorkOrderVo> inputWeightList = workOrderService.inputWeightList(workOrderVo);
			jsonData.put("data", inputWeightList);
			jsonData.put("result", "ok");
		} catch (Exception e) {
			logger.info("설비별 투입 중량 조회 실패");
			e.printStackTrace();
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 트레이 기본 데이터 20개 생성 해주는 부분
	public @ResponseBody Map<String , Object> productionPerfTrayCreate(ProductionPerfTrayVo productionPerfTrayVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산실적트레이 등록 : "+productionPerfTrayVo);
		try {
			
			JSONParser jsonParser	= new JSONParser();
			JSONObject jsonObj		= new JSONObject();
			JSONArray jsonArray		= (JSONArray) jsonParser.parse(productionPerfTrayVo.getArrayData());
			
			//고정 값이라 위에 선언 함
			jsonObj.put(0, jsonArray.get(0));
			JSONObject jsonObjDtl = (JSONObject) jsonParser.parse(jsonObj.get(0).toString());
			
			int trayCount = 21;	//이 수량 가지고 트레이 생산 수량 변경 가능
			
			//솔브레인 설비가 Cell Cutting인 경우에만 트레이 수량 수정
			if( productionPerfTrayVo.getEquipNm() != null ) {
				if( "003".equals(factoryCode) && "C".equals(productionPerfTrayVo.getEquipNm().substring(0,1)) ) {
					trayCount = 41;
				}
			}
			
			String[] trayNo			= new String[trayCount];	//트레이 번호
			String workOrdNo		= productionPerfTrayVo.getWorkOrdNo();	//작지 번호 
			int workOrdSeq 			= productionPerfTrayService.productionPerfTraySeq(productionPerfTrayVo);	//작지 순서
			int productQty			= 0;	//생산 수량(한 트레이 별)
			
			//제품별 생산 수량
			GoodsCodeAdmVo goodsCodeAdmVo = new GoodsCodeAdmVo();
			goodsCodeAdmVo.setGoodsCd( jsonObjDtl.get("goodsCd").toString() );
			goodsCodeAdmVo	= goodsCodeAdmService.read(goodsCodeAdmVo);
			productQty		= Integer.parseInt(goodsCodeAdmVo.getProductQty().toString());
			
			//생산실적트레이 마지막 정보 조회
			ProductionPerfTrayVo lastinfoVo = productionPerfTrayService.productionPerfTrayLastInfo(productionPerfTrayVo);
			
			//생산실적트레이Vo 초기화
			ProductionPerfTrayVo productionPerfTrayVoDtl = new ProductionPerfTrayVo();
			
			if( !factoryCode.equals("001") && !factoryCode.equals("003") ) {
				if( factoryCode.equals("002") ) {
					//설비 정보 확인
					EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
					equipCodeAdmVo.setEquipCd(jsonObjDtl.get("equipCd").toString());
					equipCodeAdmVo = equipCodeAdmService.read(equipCodeAdmVo);
					
					String fakeEquipNm = equipCodeAdmVo.getFakeEquipNm();
					String fakeDateCd =  equipCodeAdmVo.getFakeDateCd();
					
					//값이 둘 다 있는 경우 트레이 코드 만드는 번호 수정
					if( fakeEquipNm != null && !fakeEquipNm.equals("") && fakeDateCd != null && !fakeDateCd.equals("") ) {
						workOrdNo = fakeEquipNm.replace("-", "") + workOrdNo.charAt(5) + fakeDateCd + workOrdNo.substring(7);
					}
					//설비 정보 확인
				}
			}
			
			//트레이 라벨 20개 저장
			for(int i=0; i<(trayCount-1); i++ ) {
				
				trayNo[i] = workOrdNo + "-T" + (i+1) ;	//트레이 번호 생성
				
				productionPerfTrayVoDtl.setTrayNo(trayNo[i]);										//트레이 번호
				productionPerfTrayVoDtl.setWorkOrdNo(jsonObjDtl.get("workOrdNo").toString());		//작지 번호
				productionPerfTrayVoDtl.setLastWorkOrdNo( lastinfoVo != null ? lastinfoVo.getWorkOrdNo() : "N" );	//전 작지 번호
				
				productionPerfTrayVoDtl.setEquipCd(jsonObjDtl.get("equipCd").toString());			//설비코드
				
				productionPerfTrayVoDtl.setDayNightCd(jsonObjDtl.get("dayNightCd").toString());		//주야 구분 
				productionPerfTrayVoDtl.setProductDate(jsonObjDtl.get("productDate").toString());	//생산 날짜
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//작업자

				productionPerfTrayVoDtl.setGoodsCd(jsonObjDtl.get("goodsCd").toString());			//제품코드
				productionPerfTrayVoDtl.setMatrlCd(jsonObjDtl.get("matrlCd").toString());			//자재코드
				productionPerfTrayVoDtl.setMatrlLotNo(jsonObjDtl.get("matrlLotNo").toString());		//자재로트
				productionPerfTrayVoDtl.setFilmLotNo(jsonObjDtl.get("filmLotNo").toString());		//부자재로트
				productionPerfTrayVoDtl.setLastMatrlLotNo( lastinfoVo != null ? lastinfoVo.getMatrlLotNo() : "N" );	//전 작지 번호
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//라벨로트
//				productionPerfTrayVoDtl.setTrayNo(jsonObjDtl.get("partCd").toString());				//생산전표번호
				
				productionPerfTrayVoDtl.setProductStatus("001");									//생산상태(미완료:001, 생산완료:002, 포장:003)
				productionPerfTrayVoDtl.setProductQty( productQty );								//생산수량
				productionPerfTrayVoDtl.setIncorporationGubun("N");									//혼입구분
				productionPerfTrayVoDtl.setIncorporationVisonGubun("N");							//혼입비전구분
				productionPerfTrayVoDtl.setWorkOrdSeq(workOrdSeq);									//작지순서
				productionPerfTrayVoDtl.setTurnNumber( (i+1) );										//순번
				
				if( factoryCode.equals("003")) {
					productionPerfTrayVoDtl.setLgesGubun( jsonObjDtl.get("lgesGubun").toString() );		//lges인 경우					
				}
				
				productionPerfTrayVoDtl.setRegId( Utils.getUserId() );								//등록자
				
				//생산실적트레이테이블 등록
				productionPerfTrayService.productionPerfTrayCreate(productionPerfTrayVoDtl);
			}
			
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//생산관리 - 생산전표 수량 조회
	@RequestMapping(value = "/wmsc0200", method = RequestMethod.GET)
	public String wmsc0190GET(Locale locale, Model model) throws Exception {
		
		logger.info("생산관리 - 생산전표 수량 조회");
		
		String todate = DateUtil.getToday("yyyy-mm-dd");
		model.addAttribute("serverDateFrom", DateUtil.getDay("yyyy-mm-dd", -6));
		model.addAttribute("serverDate", DateUtil.getToday("yyyy-mm-dd"));
		
		EquipCodeAdmVo equipCodeAdmVo = new EquipCodeAdmVo();
		List<EquipCodeAdmVo> equipCodeAdmVoList= equipCodeAdmService.listAll(equipCodeAdmVo);
		model.addAttribute("equipCode", equipCodeAdmVoList );
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		systemCommonCodeVo.setBaseGroupCd("066"); // 검사상태(수입검사 합격여부)
		List<SystemCommonCodeVo>  systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("inspStatus", systemCommonCodeList );
		
		return "wm/wmsc0200";
	}
	
	//생산전표 수량 조회
	@RequestMapping(value="po/outputSubCntList" , method = RequestMethod.GET)
	public @ResponseBody Map<String , Object> outputSubCntList(WorkOrderVo workOrderVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("생산전표 수량 조회: "+workOrderVo);
		try {
			List<WorkOrderVo> list = workOrderService.outputSubCntList(workOrderVo);
			jsonData.put("data", list);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
		return jsonData;
	}
	
	//재투입 LOT 확인
	@RequestMapping(value = "/po/checkLastMatrlLotNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkLastMatrlLotNo(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("재투입 LOT 확인 " + workOrderVo);
		try {
			WorkOrderVo readVo = workOrderService.checkLastMatrlLotNo(workOrderVo);
			if(readVo != null) {
				if(workOrderVo.getBarcodeNo().equals(readVo.getLotNo())) {				
					jsonData.put("result", "dup");
				} else {					
					jsonData.put("result", "ok");
				}
			} else {
				jsonData.put("result", "ok");
			}

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	//작업지시 마지막 LOT 확인
	@RequestMapping(value = "/po/checkBefoerMatrlLotNo", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkBefoerMatrlLotNo(WorkOrderVo workOrderVo) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("작업지시 마지막 LOT 확인 " + workOrderVo);
		try {			
			AgtVo agtVo = new AgtVo();
			agtVo.setWorkOrdNo(workOrderVo.getWorkOrdNo());
			List<AgtVo> agtList = agtService.readTemp2(agtVo);
			
			if(agtList.size() == 0) {
				WorkOrderVo readVo = workOrderService.checkBefoerMatrlLotNo(workOrderVo);
				if(readVo != null) {
					if(readVo.getLotNo().equals(readVo.getLotNo())) {									
						jsonData.put("result", "dup"); // 블러오기 가능
					} else {					
						jsonData.put("result", "ok"); // 불러오기 불가능
					}
				} else {
					jsonData.put("result", "ok");
				}
			} else {
				jsonData.put("result", "ok");
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("message", "시스템 에러가 발생하였습니다.");
			jsonData.put("result", "error");
		}
		return jsonData;
	}
	
	
	
}