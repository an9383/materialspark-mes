package mes.web.io;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.ObjectMapper;

import mes.domain.bm.DealCorpAdmVo;
import mes.domain.bm.MatrlCodeAdmVo;
import mes.domain.bm.SystemCommonCodeVo;
import mes.domain.io.MatrlInOutWhsAdmVo;
import mes.domain.io.MatrlInWhsRqtVo;
import mes.domain.io.StockPaymentAdmVo;
import mes.domain.mm.ItemPartAdmVo;
import mes.service.bm.DealCorpAdmService;
import mes.service.bm.MatrlCodeAdmService;
import mes.service.bm.SystemCommonCodeService;
import mes.service.io.FileUploadService;
import mes.service.io.MatrlInOutWhsAdmService;
import mes.service.io.MatrlInWhsRqtService;
import mes.service.io.StockPaymentAdmService;
import mes.web.ut.DateUtil;
import mes.web.ut.Settings;
import mes.web.ut.Utils;
import mes.web.io.StockPaymentAdmController;

@Controller
public class MatrlInWhsRqtController {
	
	@Inject
	private DealCorpAdmService dealCorpAdmService;
	@Inject 
	private MatrlInWhsRqtService matrlInWhsRqtService;
	@Inject
	private MatrlCodeAdmService matrlCodeAdmService;
	@Inject
	private FileUploadService fileUploadService;
	@Inject
	private MatrlInOutWhsAdmService matrlInOutWhsAdmService;
	@Inject
	private SystemCommonCodeService systemCommonCodeService;
	@Inject
	private StockPaymentAdmService stockPaymentAdmService;
	
	@Value("${matrlUploadDir}") private String matrlUploadDir;
	@Value("${file.matrlInWhsRqtBasicForm}") private String matrlInWhsRqtBasicForm;
	@Value("${file.matrlInWhsRqtBasicForm_F3}") private String matrlInWhsRqtBasicForm_F3;
	@Value("${factoryCode}") private String facotryCode;
	
	private static final Logger logger = LoggerFactory.getLogger(MatrlInWhsRqtController.class);
	
	//자재입고관리 메인
	@RequestMapping(value = "/iosc0010", method = RequestMethod.GET)
	public String matrlInWhsRqMain(Locale locale, Model model) throws Exception {
		
		logger.info("자재입고관리 메인");
		
		SystemCommonCodeVo systemCommonCodeVo = new SystemCommonCodeVo();
		
		systemCommonCodeVo.setBaseGroupCd("033"); // 승인구분
		List<SystemCommonCodeVo> systemCommonCodeList = systemCommonCodeService.listAll(systemCommonCodeVo);
		model.addAttribute("factoryCd", systemCommonCodeList );
		
		return "io/iosc0010";
	}
	
	//자재입고 목록조회
	@RequestMapping(value = "/io/matrlInWhsRqtDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInWhsRqtDataList(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception {
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("자재코드관리 목록조회");
		List<MatrlInWhsRqtVo> matrlInWhsRqtData = matrlInWhsRqtService.listAll(matrlInWhsRqtVo);
		jsonData.put("data", matrlInWhsRqtData);
		
		return jsonData;
	}
	
//	@RequestMapping(value = "/iosc0010", method = RequestMethod.GET)
//	public String matrlInWhsRqpop() throws Exception {
//		
//		logger.info("자재입고관리 팝업");				
//		return "io/iosc0010";
//	}
	
	@RequestMapping(value = "/io/matrlInWhsRqtPopDataList", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInWhsRqtpopDataList(String filename) throws Exception {
		CustomerExcelReader excelReader = new CustomerExcelReader();
		Map<String, Object> jsonData = new HashMap<String, Object>();
		List<MatrlInWhsRqtVo> matrlInWhsRqtData = excelReader.fileload(filename, logger);
		logger.info("자재입고관리 엑셀조회");
		File file = new File(filename);
		logger.info(filename);
		jsonData.put("data", matrlInWhsRqtData);
		if (file.exists()) {
    		if (file.delete()) {
    			logger.info("파일삭제 성공");
    		} else {
    			logger.info("파일삭제 실패");
    		}
    	} else {
    		logger.info("파일이 존재하지 않습니다.");
    	}
		
		return jsonData;
	}
	
	//3공장 파일 읽기
	@RequestMapping(value = "/io/matrlInWhsRqtPopDataList_F3", method = RequestMethod.GET)
	public @ResponseBody Map<String, Object> matrlInWhsRqtPopDataList_F3(String filename) throws Exception {
		CustomerExcelReader excelReader 		= new CustomerExcelReader();
		Map<String, Object> jsonData 			= new HashMap<String, Object>();
		List<MatrlInWhsRqtVo> matrlInWhsRqtData = excelReader.fileload_F3(filename, logger);
		logger.info("자재입고관리 엑셀조회(3공장)");
		File file = new File(filename);
		logger.info("filename : "+filename);
		logger.info("matrlInWhsRqtData : "+matrlInWhsRqtData);
		
		if(matrlInWhsRqtData.size() != 0) {
			jsonData.put("data", matrlInWhsRqtData);
			jsonData.put("result", "ok");
		}else {
			jsonData.put("message", "입고량(KG)규칙에 맞지 않는 값이 있습니다.");
			jsonData.put("result", "fail");
		}
		
		if (file.exists()) {
    		if (file.delete()) {
    			logger.info("파일삭제 성공");
    		} else {
    			logger.info("파일삭제 실패");
    		}
    	} else {
    		logger.info("파일이 존재하지 않습니다.");
    	}
		return jsonData;
	}
	
	//drawCall
	@RequestMapping(value = "/io/matrlInWhsRqtSQ", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInWhsRqtSQ() throws Exception {
	
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("시퀀스 생성");
		try {		
			String whsGroupSeq = matrlInWhsRqtService.selectInWhsGroupSeq();
			logger.info(whsGroupSeq);
			jsonData.put("data", whsGroupSeq);
			jsonData.put("result", "ok");	
		} catch (Exception e) {
			logger.info("시퀀스 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		
		return jsonData;
	}
	
	//
	@RequestMapping(value= "io/matrlInOutExcelUpload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInOutExcelUpload(Model model,@RequestParam("excelfile") MultipartFile file) {
			
		Map<String, Object> jsonData = new HashMap<String, Object>();
		MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
		
		try {		
			String url = fileUploadService.restore(file, logger, matrlUploadDir);
			logger.info(url);
			model.addAttribute("url", url);
			matrlInWhsRqtVo.setUrl(url);
			jsonData.put("data", matrlInWhsRqtVo);
			jsonData.put("result", "ok");
			
		} catch (Exception e) {
			logger.info("matrlInOutExcelUpload 오류");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "error");			 
		}

		return jsonData;
			
	}
	
	//엑셀 업로드(신규)
	@RequestMapping(value = "/io/matrlInWhsRqtSaveDataList", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInWhsRqtSaveDataList(@RequestBody List<Map<String, Object>> matrlInWhsRqtList, RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("size >>> " +matrlInWhsRqtList.size());
			logger.info("matrlInWhsRqtList >>> " +matrlInWhsRqtList);
			
//			String sudelCheck ="N";
			
			//저장시 사용 할 변수들 정의-----------------
			List<MatrlInWhsRqtVo> InWhsRqtList = new ArrayList<MatrlInWhsRqtVo>();
			String groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();
			boolean ret	 = true;
			
			String systemToDay = DateUtil.getToday("yyyymmdd");
			String seqSt;
			int seqStart = 0;
			
			ret 		= true;
			seqSt 		= matrlInWhsRqtService.barcodeCreate(matrlInWhsRqtList.get(0).get("preInWhsDate").toString());
			seqStart 	= Integer.valueOf(seqSt);
			boolean checkNumeric = true;
			//저장시 사용 할 변수들 정의 끝-----------------
			
			//값 문제 있는지 한번에 확인하는 부분------------
			for(Map<String, Object> m : matrlInWhsRqtList) {
				
				MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
				MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
				DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();				
				matrlInWhsRqtVo.setLotNo			(m.get("lotNo").toString().replace(" ", ""));
				matrlInWhsRqtVo.setSrLot			(m.get("srLot").toString());			
				matrlInWhsRqtVo.setMatrlCd			(m.get("matrlCd").toString());				
				matrlInWhsRqtVo.setPreInWhsQty		(m.get("preInWhsQty").toString());
				matrlInWhsRqtVo.setInWhsQty			(m.get("preInWhsQty").toString());
				matrlInWhsRqtVo.setInspectQty		(m.get("preInWhsQty").toString());
				matrlInWhsRqtVo.setWeightUnit		(m.get("weightUnit").toString());
				matrlInWhsRqtVo.setRollCnt			(m.get("rollCnt").toString());
				matrlInWhsRqtVo.setDiffQty			("0");
				matrlInWhsRqtVo.setInWhsLength		(m.get("inWhsLength").toString());
				matrlInWhsRqtVo.setSpplyDealCorpCd	(m.get("spplyDealCorpCd").toString());
				matrlInWhsRqtVo.setSpplyDealCorpNm	(m.get("spplyDealCorpNm").toString());
				matrlInWhsRqtVo.setPreInWhsDate		(m.get("preInWhsDate").toString());
				matrlInWhsRqtVo.setApprovalCd		("002");			
				matrlInWhsRqtVo.setStatusCd			("S");						
				matrlInWhsRqtVo.setInWhsDesc		(m.get("inWhsDesc").toString());
				matrlInWhsRqtVo.setFifoCheck		("Y");
				matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
				matrlInWhsRqtVo.setUpdId			(Utils.getUserId());			
				matrlCodeAdmVo.setMatrlCd			(m.get("matrlCd").toString());
				dealCorpAdmVo.setDealCorpCd			(m.get("spplyDealCorpCd").toString());
				matrlInWhsRqtVo.setPaidGubun		(m.get("paidGubun").toString());
			
				if (isNumberic(m.get("preInWhsQty").toString())) {
					checkNumeric = true;	//입고량이 null이 아니면 true를 반환한다.
				} else {
					checkNumeric = false;	//입고량이 null이면 false를 반환한다. 
				}
				
				if(matrlInWhsRqtVo.getMatrlCd().substring(0, 1).equals("F") && m.get("barcodeNo").toString().equals("")) { //필름이고 barcodeNo가 없으면 시스템이 채번을 해줌.
					String tmp= String.format("%03d", seqStart);
					String barcodeNo = matrlInWhsRqtVo.getPreInWhsDate().toString() + "-" + tmp;
					matrlInWhsRqtVo.setBarcodeNo(barcodeNo);
					seqStart++;
				} else {
					matrlInWhsRqtVo.setBarcodeNo(m.get("barcodeNo").toString().replace(" ", ""));
				}
				
				String checkCode = matrlInWhsRqtService.checkCode(matrlInWhsRqtVo);		//jsp에서 전달한 값을 담아서 값이 있는지 없는지 check한다. check한 값을 checkCode에 담아 둔다.
				logger.info("checkCode 값 확인하는 부분 >>> " +checkCode);
				
				if(checkCode.equals("Y") && checkNumeric==true) {	//Mapper에서 처리해줬던 코드들 중에서 Y가 있으면, Y값을 반화해서 받았으면 아래를 실해해준다. +checkNumeric는 위에서  값을 받아온 값(입고량이 null이 아닐 때 true를 반환한다.)
					jsonData.put("result", "ok");					//jsp에서 저장됐다는 message를 보내준다.
					matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);		//Vo안에 InWhsGroupSeq한테 groupSeq를 지정해준다.
					InWhsRqtList.add(matrlInWhsRqtVo);				//InWhsRqtList는  ArrayList이다. ArrayList에 지정해줬던 값 전부를 보내준다.
				} else {											//Y가 아닐 때 실행 Mapper에서 조건을 봤을때 값이 하나라도 있으면 Y를 반환해준다.
					if (checkNumeric == true) {						//입고량이 null이 아닐때 실행 시킨다.
						jsonData.put("result", "error");			//jsp에 errorMessage를 출력 시킨다.
						logger.info("checkCode2 >>> " +checkCode);
						jsonData.put("message", checkCode);			//Mapper에서 출력한 결과 값을 여기로 뿌려준다.
					} else {										//만약 입고량이 null이면 아래 값을 반환해준다.
						jsonData.put("result", "error");
						jsonData.put("message","입고량 데이터를 확인 후 다시 시도해 주세요!");	
					}
					ret = false;	//위에 조건이 실해이 안되면 빠져나오는 코드
					break;
				}
				//겹치는 LotNo 값 확인
				logger.info("lotNo 값 확인하기 >>> "+m.get("lotNo").toString().replace(" ", ""));
				int lineNum = matrlInWhsRqtService.groupSeqCount(m.get("lotNo").toString().replace(" ", ""));	//라인 번호를 가지고 온다.? -> groupSeq로 등록 되어있는 애들에 카운트를 세가지고 lineNum에 담아둔다.
				logger.info("lineNum 값 확인하기 >>> "+lineNum);
				if(ret) {							//지정한 코드가 알맞게 잘 돌아갔을 경우 여기로 들어온다.
					if(0<lineNum) {					// 똑같은 값이 하나라도 있으면 실행시킨다.
						jsonData.put("message", (lineNum + 1) + "번 라인과 겹치는 LotNo - " + matrlInWhsRqtList.get(lineNum).get("lotNo").toString() +" 가 있습니다! <br> 확인 후 다시 시도해 주세요.");
						jsonData.put("result", "fail");
					}
				}
				//겹치는 LotNo 값 확인
			}
			//값 문제 있는지 한번에 확인하는 부분 끝------------
			
			//검사 끝나고 실행하는 부분
			if(ret) {
				
				//값을 나누거나 check 할 때 필요한 변수들 정의-----------------
				int countA 		= 0;	//for문 돌리 값
				countA 			= matrlInWhsRqtList.size();
				
				String matrlCdCompareValA		= null;			// 자재코드를 비교할 값 첫번째
				String matrlCdCompareValB 		= null; 		// 비자재코드를 교할 값 첫번째 다음 으로 오는 값
				
				String preInWhsDateCompareValA	= null;			// 가입고일을 비교할 값 첫번째
				String preInWhsDateCompareValB	= null; 		// 가입고일을 비교할 값 첫번째 다음 으로 오는 값
				String jsonStr 					= null;			// jsonObjDtl을 parser할 때 도움을 주기 위해 사용
				
				JSONArray jsonArray 		= new JSONArray();		// 재정의 한 값을 담을 Array
				JSONObject jsonObj 		= new JSONObject();		// parser할 값을 담음(jsonParser에 값을 보냄)
				ObjectMapper objMapper 	= new ObjectMapper();	// parser을 위해 도움을 주는  값(jsonObj에서 jsonParser으로 값을 보낼때 도와줌)
				JSONParser jsonParser 	= new JSONParser();		// 실제 parser할 값(jsonObj에서 값을 받음)
				JSONObject jsonObjDtl	= new JSONObject();		// parser한 값을 담음(jsonParser에서 값을 받음)
				//값을 나누거나 check 할 때 필요한 변수들 정의 끝-----------------
					
				//값 확인해서 나누는 부분  -> 여기서 나누면서 맞는 값인지 확인 해준다.
				for(int t=0; t<=countA; t++){
					logger.info("matrlInWhsRqtList값 확인하는 부분 : "+matrlInWhsRqtList);
					logger.info("matrlInWhsRqtList 값 사이즈 확인하는 부분 : "+matrlInWhsRqtList.size());
					jsonArray 	= new JSONArray();
					jsonObj = new JSONObject();
					
					for(int i=0; i<matrlInWhsRqtList.size(); i++) {
						
						//자재코드 담아주는 값
						matrlCdCompareValA = matrlInWhsRqtList.get(i).get("matrlCd").toString();
						if(i != matrlInWhsRqtList.size()-1){
							matrlCdCompareValB = matrlInWhsRqtList.get(i+1).get("matrlCd").toString();
						}
						
						//가입고일 담아주는 값
						preInWhsDateCompareValA = matrlInWhsRqtList.get(i).get("preInWhsDate").toString();
						if(i != matrlInWhsRqtList.size()-1){
							preInWhsDateCompareValB = matrlInWhsRqtList.get(i+1).get("preInWhsDate").toString();
						}
						
						if(matrlCdCompareValA.equals(matrlCdCompareValB) && preInWhsDateCompareValA.equals(preInWhsDateCompareValB)) {
							jsonArray.add(matrlInWhsRqtList.get(i));
							jsonObj.put(i, matrlInWhsRqtList.get(i));
						}else {
							jsonArray.add(matrlInWhsRqtList.get(i));
							jsonObj.put(i, matrlInWhsRqtList.get(i));
							break;
						}
					}
					//값 확인해서 나누는 부분 끝
					
					groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();	//groupSeq 부여
					
					//여기 안에서 저장 처리 시켜줌
					for(int i=0; i < jsonObj.size(); i++) {
						
						objMapper 	= new ObjectMapper();
						
						jsonStr 	= objMapper.writeValueAsString(jsonObj.get(i));	// 밑(jsonObjDtl)에서 바로 parser(파싱)이 안되서 ObjectMapper에서 한번 거친 다음 jsonStr에 담아서 보내준다. 
						jsonObjDtl	= (JSONObject) jsonParser.parse(jsonStr);		// jsonStr을 parser해준다.
						seqSt 		= matrlInWhsRqtService.barcodeCreate(jsonObjDtl.get("preInWhsDate").toString());
						seqStart 	= Integer.valueOf(seqSt);
						
						logger.info("JSON > jsonObjDtl > 자재코드 값 확인하기 > " +jsonObjDtl.get("matrlCd").toString());
						logger.info("JSON > jsonObjDtl > 가입고일 값 확인하기 > " +jsonObjDtl.get("preInWhsDate").toString());
						
						
						MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
						MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
						DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();
						
						//값 담아주는 부분
						matrlInWhsRqtVo.setLotNo			(jsonObjDtl.get("lotNo").toString().replace(" ", ""));
						matrlInWhsRqtVo.setSrLot			(jsonObjDtl.get("srLot").toString());			
						matrlInWhsRqtVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());				
						matrlInWhsRqtVo.setPreInWhsQty		(jsonObjDtl.get("preInWhsQty").toString());
						matrlInWhsRqtVo.setInWhsQty			(jsonObjDtl.get("preInWhsQty").toString());
						matrlInWhsRqtVo.setInspectQty		(jsonObjDtl.get("preInWhsQty").toString());
						matrlInWhsRqtVo.setRemainQty		(jsonObjDtl.get("preInWhsQty").toString());			//잔여량
						matrlInWhsRqtVo.setWeightUnit		(jsonObjDtl.get("weightUnit").toString());
						matrlInWhsRqtVo.setRollCnt			(jsonObjDtl.get("rollCnt").toString());
						matrlInWhsRqtVo.setDiffQty			("0");
						matrlInWhsRqtVo.setInWhsLength		(jsonObjDtl.get("inWhsLength").toString());
						matrlInWhsRqtVo.setSpplyDealCorpCd	(jsonObjDtl.get("spplyDealCorpCd").toString());
						matrlInWhsRqtVo.setSpplyDealCorpNm 	(jsonObjDtl.get("spplyDealCorpNm").toString());
						matrlInWhsRqtVo.setPreInWhsDate		(jsonObjDtl.get("preInWhsDate").toString());
						matrlInWhsRqtVo.setApprovalCd		("002");			
						matrlInWhsRqtVo.setStatusCd			("S");						
						matrlInWhsRqtVo.setInWhsDesc		(jsonObjDtl.get("inWhsDesc").toString());
						matrlInWhsRqtVo.setFifoCheck		("Y");
						matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
						matrlInWhsRqtVo.setUpdId			(Utils.getUserId());	
						matrlInWhsRqtVo.setPaidGubun		(jsonObjDtl.get("paidGubun").toString()); //기본 유상 입력
						matrlCodeAdmVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());
						dealCorpAdmVo.setDealCorpCd			(jsonObjDtl.get("spplyDealCorpCd").toString());
						//값 담아주는 부분 끝
						
						if(matrlInWhsRqtVo.getMatrlCd().substring(0, 1).equals("F") && jsonObjDtl.get("barcodeNo").toString().equals("")) { //필름이고 barcodeNo가 없으면 시스템이 채번을 해줌.
							String tmp= String.format("%03d", seqStart);
							String barcodeNo = matrlInWhsRqtVo.getPreInWhsDate().toString() + "-" + tmp;
							matrlInWhsRqtVo.setBarcodeNo(barcodeNo);
							seqStart++;
						} else {
							matrlInWhsRqtVo.setBarcodeNo(jsonObjDtl.get("barcodeNo").toString().replace(" ", ""));
						}
						
						matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);
						
						logger.info("dealCorpAdmVo에 값 확인하기		>>>	" +dealCorpAdmVo);
						logger.info("matrlInWhsRqtVo에 값 확인하기 	>>>	" +matrlInWhsRqtVo);
						logger.info("matrlCodeAdmVo에 값 확인하기		>>>	" +matrlCodeAdmVo);
						
						logger.info("↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓한 개 값이 저장됨↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
						logger.info("groupSeqrk 값 확인		>>> " +groupSeq);
						logger.info("자재코드, 가입고일 확인하기	>>> " +jsonObjDtl.get("matrlCd").toString()+ ", " + jsonObjDtl.get("preInWhsDate").toString());
						logger.info("barcodeNo 값 확인하는 부분	>>> " +matrlInWhsRqtVo.getBarcodeNo());
						logger.info("전체 값 확인하는 부분입니다. 	>>> " +jsonObjDtl);
						matrlInWhsRqtService.create(matrlInWhsRqtVo);
						MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
						matrlInOutWhsAdmVo.setBarcodeNo(matrlInWhsRqtVo.getBarcodeNo());
						matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
						
						
						//수불 등록■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
						StockPaymentAdmVo stockPaymentAdmVo = new StockPaymentAdmVo();
						matrlInOutWhsAdmVo.setMatrlCd(jsonObjDtl.get("matrlCd").toString());
						matrlInOutWhsAdmVo.setLotNo(jsonObjDtl.get("lotNo").toString().replace(" ", ""));
						matrlInOutWhsAdmVo.setStatusCd("S");
						matrlInOutWhsAdmVo.setApprovalCd("002");
						matrlInOutWhsAdmVo.setRemainQty(jsonObjDtl.get("preInWhsQty").toString());
						stockPaymentAdmVo = StockPaymentAdmController.matrlStockPaymentPlus(matrlInOutWhsAdmVo, facotryCode);
						stockPaymentAdmService.stockPaymentPlus(stockPaymentAdmVo);
						logger.info("↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑"+ t +"번째 "+ (i+1) +"개 값이 저장됨↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑");
					}
					//여기 안에서 저장 처리 시켜줌 끝
					
					//저장된 값은 삭제 시켜줌
					for(int i=0; i<jsonArray.size(); i++) {
						matrlInWhsRqtList.remove(0);				
					}
					//저장된 값은 삭제 시켜줌
					
					countA = countA-jsonArray.size();	//돌리 값을 다시 재정이 해준다.
					t=0;
				}
				jsonData.put("result", "ok");
			}
			//검사 끝나고 실행하는 부분 끝
			
		} catch (Exception e) {
			logger.info("시퀀스 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	
	//솔브레인 엑셀 업로드(20220113추가 _신규2)_제 3공장 *롤수 만큼 저장X
	@RequestMapping(value = "/io/matrlInWhsRqtNotRollCountSave_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInWhsRqtNotRollCountSave_F3(@RequestBody List<Map<String, Object>> matrlInWhsRqtList, RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("size >>> " +matrlInWhsRqtList.size());
			logger.info("matrlInWhsRqtList >>> " +matrlInWhsRqtList);
			
			Settings singletonSettings = Settings.getInstance();
			
			System.out.println("가입고 싱글톤 겁사 상태 ----> "+singletonSettings.useMatrlInout);
			
			//싱글톤 가입고등록이 사용중이 아니라면
			if (singletonSettings.useMatrlInout == false) {
				
				//진짜 싱글톤 가입고등록이 사용중이 아니라면
				if (singletonSettings.useMatrlInout == false) {
					//가입고 등록 진행할 때 가입고 등록 싱글톤 사용중이라고 변경
					//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
					singletonSettings.useMatrlInout = true;
					//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
					
					//------------------------------------------------------가입고 등록 로직 진행------------------------------------------------------//
					
					//저장시 사용 할 변수들 정의-----------------
					List<MatrlInWhsRqtVo> InWhsRqtList = new ArrayList<MatrlInWhsRqtVo>();
					String groupSeq 		= matrlInWhsRqtService.selectInWhsGroupSeq().toString();
					boolean ret	 			= true;
					boolean checkNumeric	= true;
					//저장시 사용 할 변수들 정의 끝-----------------
					
					//값 문제 있는지 한번에 확인하는 부분------------
					for(Map<String, Object> m : matrlInWhsRqtList) {
						
						MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
						MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
						DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();				
						int rollCount 					= Integer.parseInt(m.get("rollCount").toString());
						logger.info("하나씩 저장할 값 개수는 ? -----> "+rollCount);
						
						//검사 값
							
						matrlInWhsRqtVo.setPreInWhsDate		(m.get("preInWhsDate").toString());						//가입고일
						matrlInWhsRqtVo.setInWhsDate		(m.get("preInWhsDate").toString());						//입고일(가입고일 하고 동일하게 처리)
						matrlInWhsRqtVo.setLifeTime			(m.get("lifeTime").toString());							//유수명
						matrlInWhsRqtVo.setSurfaceDate		(m.get("surfaceDate").toString());						//표면처리일
						matrlInWhsRqtVo.setData1			(m.get("data1").toString());							//구매
						matrlInWhsRqtVo.setData2			(m.get("data2").toString());							//위치
						matrlInWhsRqtVo.setInWhsDesc		(m.get("inWhsDesc").toString());						//비고
						matrlInWhsRqtVo.setMatrlCd			(m.get("matrlCd").toString());							//자재코드
						matrlInWhsRqtVo.setMotherRollLot	(m.get("motherRollLot").toString());					//마더롤
						matrlInWhsRqtVo.setMotherRollLotNo	(m.get("motherRollLotNo").toString().replace(" ", ""));	//LotNo
						matrlInWhsRqtVo.setStandard			(m.get("standard").toString());							//규격
						matrlInWhsRqtVo.setRollCount		(m.get("rollCount").toString());						//롤수
						matrlInWhsRqtVo.setDiffQty			("0");
						matrlInWhsRqtVo.setApprovalCd		("002");
						matrlInWhsRqtVo.setStatusCd			("S");
						matrlInWhsRqtVo.setFifoCheck		("Y");
						matrlInWhsRqtVo.setPreInWhsQty		(m.get("preInWhsQty").toString());						//나중에 값 변경해주기
						matrlInWhsRqtVo.setRemainQty		(m.get("preInWhsQty").toString());
						matrlInWhsRqtVo.setInWhsQty			(m.get("preInWhsQty").toString());						//나중에 값 변경해주기
						matrlInWhsRqtVo.setInspectQty		(m.get("preInWhsQty").toString());						//나중에 값 변경해주기
						matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");												//나중에 값 변경해주기
						matrlInWhsRqtVo.setLotNo 			(m.get("motherRollLotNo").toString().replace(" ", ""));	//마더롤LotNo값
						matrlInWhsRqtVo.setBarcodeNo 		(m.get("motherRollLotNo").toString().replace(" ", ""));	//마더롤LotNo값
						matrlInWhsRqtVo.setInWhsTime		(m.get("inWhsTime").toString());						//입고시간
						matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
						matrlInWhsRqtVo.setUpdId			(Utils.getUserId());
					
						matrlCodeAdmVo.setMatrlCd			(m.get("matrlCd").toString());							//자재코드
						
					
					
						//입고량 추가됐을 때 주석 풀어주기(null체크)
						/*if (isNumberic(m.get("preInWhsQty").toString())) {
							checkNumeric = true;	//입고량이 null이 아니면 true를 반환한다.
						} else {
							checkNumeric = false;	//입고량이 null이면 false를 반환한다. 
						}*/
						
						logger.info("LotNo 값 확인하기------------------------------> "+matrlInWhsRqtVo.getLotNo());
						String checkCode = matrlInWhsRqtService.checkCode(matrlInWhsRqtVo);
						logger.info("checkCode 값 확인하는 부분 >>> " +checkCode);
						
						if(checkCode.equals("Y") && checkNumeric==true) {
							jsonData.put("result", "ok");
							matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);
							InWhsRqtList.add(matrlInWhsRqtVo);
						} else {
							if (checkNumeric == true) {
								jsonData.put("result", "fail");
								logger.info("checkCode2 >>> " +checkCode);
								jsonData.put("message", checkCode);
								//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
								singletonSettings.useMatrlInout = false;
								//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
								return jsonData;
							} else {
								jsonData.put("result", "error");
								jsonData.put("message","입고량 데이터를 확인 후 다시 시도해 주세요!");	
							}
							ret = false;
							break;
						}
						//겹치는 motherRollLotNo 값 확인
						logger.info("lotNo 값 확인하기 >>> "+matrlInWhsRqtVo.getLotNo());
						int lineNum = matrlInWhsRqtService.groupSeqCount(matrlInWhsRqtVo.getLotNo());	//라인 번호를 가지고 온다.? -> groupSeq로 등록 되어있는 애들에 카운트를 세가지고 lineNum에 담아둔다.
						logger.info("lineNum 값 확인하기 >>> "+lineNum);
						if(ret) {							//지정한 코드가 알맞게 잘 돌아갔을 경우 여기로 들어온다.
							if(0<lineNum) {					// 똑같은 값이 하나라도 있으면 실행시킨다.
								jsonData.put("message", (lineNum + 1) + "번 라인과 겹치는 LotNo - " + matrlInWhsRqtList.get(lineNum).get("lotNo").toString() +" 가 있습니다! <br> 확인 후 다시 시도해 주세요.");
								jsonData.put("result", "fail");
							}
						}
						//겹치는 LotNo 값 확인
					}
					//값 문제 있는지 한번에 확인하는 부분 끝------------
					
					//검사 끝나고 실행하는 부분
					if(ret) {
						
						//값을 나누거나 check 할 때 필요한 변수들 정의-----------------
						int countA 		= 0;	//for문 돌리 값
							countA 		= matrlInWhsRqtList.size();
							
						String matrlCdCompareValA		= null;			// 자재코드를 비교할 값 첫번째
						String matrlCdCompareValB 		= null; 		// 자재코드를 비교할 값 첫번째 다음 으로 오는 값
						
						String preInWhsDateCompareValA	= null;			// 가입고일을 비교할 값 첫번째
						String preInWhsDateCompareValB	= null; 		// 가입고일을 비교할 값 첫번째 다음 으로 오는 값
						String jsonStr 					= null;			// jsonObjDtl을 parser할 때 도움을 주기 위해 사용
						
						JSONArray jsonArray 	= new JSONArray();		// 재정의 한 값을 담을 Array
						JSONObject jsonObj 		= new JSONObject();		// parser할 값을 담음(jsonParser에 값을 보냄)
						ObjectMapper objMapper 	= new ObjectMapper();	// parser을 위해 도움을 주는  값(jsonObj에서 jsonParser으로 값을 보낼때 도와줌)
						JSONParser jsonParser 	= new JSONParser();		// 실제 parser할 값(jsonObj에서 값을 받음)
						JSONObject jsonObjDtl	= new JSONObject();		// parser한 값을 담음(jsonParser에서 값을 받음)
						//값을 나누거나 check 할 때 필요한 변수들 정의 끝-----------------
							
						//값 확인해서 나누는 부분  -> 여기서 나누면서 맞는 값인지 확인 해준다.
						for(int t=0; t<=countA; t++){
							logger.info("matrlInWhsRqtList값 확인하는 부분 : "+matrlInWhsRqtList);
							logger.info("matrlInWhsRqtList 값 사이즈 확인하는 부분 : "+matrlInWhsRqtList.size());
							jsonArray 	= new JSONArray();
							jsonObj = new JSONObject();
							
							for(int i=0; i<matrlInWhsRqtList.size(); i++) {
								
								//자재코드 담아주는 값
								matrlCdCompareValA = matrlInWhsRqtList.get(i).get("matrlCd").toString();
								if(i != matrlInWhsRqtList.size()-1){
									matrlCdCompareValB = matrlInWhsRqtList.get(i+1).get("matrlCd").toString();
								}
								
								//가입고일 담아주는 값
								preInWhsDateCompareValA = matrlInWhsRqtList.get(i).get("preInWhsDate").toString();
								if(i != matrlInWhsRqtList.size()-1){
									preInWhsDateCompareValB = matrlInWhsRqtList.get(i+1).get("preInWhsDate").toString();
								}
								
								if(matrlCdCompareValA.equals(matrlCdCompareValB) && preInWhsDateCompareValA.equals(preInWhsDateCompareValB)) {
									jsonArray.add(matrlInWhsRqtList.get(i));
									jsonObj.put(i, matrlInWhsRqtList.get(i));
								}else {
									jsonArray.add(matrlInWhsRqtList.get(i));
									jsonObj.put(i, matrlInWhsRqtList.get(i));
									break;
								}
							}
							//값 확인해서 나누는 부분 끝
							
							groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();	//그룹시퀀스 부여
							
							//여기 안에서 저장 처리 시켜줌
							for(int i=0; i < jsonObj.size(); i++) {
								
								objMapper 	= new ObjectMapper();
								jsonStr 	= objMapper.writeValueAsString(jsonObj.get(i));	// 밑(jsonObjDtl)에서 바로 parser(파싱)이 안되서 ObjectMapper에서 한번 거친 다음 jsonStr에 담아서 보내준다. 
								jsonObjDtl	= (JSONObject) jsonParser.parse(jsonStr);		// jsonStr을 parser해준다.
								
								MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
								MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
								DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();
								
									//값 담아주는 부분
									matrlInWhsRqtVo.setPreInWhsDate		(jsonObjDtl.get("preInWhsDate").toString());	//가입고일
									matrlInWhsRqtVo.setInWhsDate		(jsonObjDtl.get("preInWhsDate").toString());	//입고일(가입고일 하고 동일하게 처리)
									matrlInWhsRqtVo.setLifeTime			(jsonObjDtl.get("lifeTime").toString());		//유수명
									matrlInWhsRqtVo.setSurfaceDate		(jsonObjDtl.get("surfaceDate").toString());		//표면처리일
									matrlInWhsRqtVo.setData1			(jsonObjDtl.get("data1").toString());			//구매
									matrlInWhsRqtVo.setData2			(jsonObjDtl.get("data2").toString());			//위치
									matrlInWhsRqtVo.setInWhsDesc		(jsonObjDtl.get("inWhsDesc").toString());		//비고
									matrlInWhsRqtVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());			//자재코드
									matrlInWhsRqtVo.setMotherRollLot	(jsonObjDtl.get("motherRollLot").toString());	//마더롤
									matrlInWhsRqtVo.setMotherRollLotNo	(jsonObjDtl.get("motherRollLotNo").toString().replace(" ", ""));	//LotNo
									matrlInWhsRqtVo.setStandard			(jsonObjDtl.get("standard").toString());		//규격
									matrlInWhsRqtVo.setRollCount		(jsonObjDtl.get("rollCount").toString());		//롤수
									matrlInWhsRqtVo.setDiffQty			("0");
									matrlInWhsRqtVo.setApprovalCd		("002");
									matrlInWhsRqtVo.setStatusCd			("S");
									matrlInWhsRqtVo.setFifoCheck		("Y");
									matrlInWhsRqtVo.setPreInWhsQty		(jsonObjDtl.get("preInWhsQty").toString());		//가입고량
									matrlInWhsRqtVo.setRemainQty		(jsonObjDtl.get("preInWhsQty").toString());		//잔량
									matrlInWhsRqtVo.setInWhsQty			(jsonObjDtl.get("preInWhsQty").toString());		//입고량
									matrlInWhsRqtVo.setInspectQty		(jsonObjDtl.get("preInWhsQty").toString());		//실사량
									
									//matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//나중에 값 변경해주기
									if( jsonObjDtl.get("matrlCd").toString().contains("NS") ) {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//솔브레인
									} else if( jsonObjDtl.get("matrlCd").toString().contains("AT") ) {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00003");	//TPS
									} else if( jsonObjDtl.get("matrlCd").toString().contains("AS") ) {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//솔브레인
									} else if( jsonObjDtl.get("matrlCd").toString().contains("FN") || jsonObjDtl.get("matrlCd").toString().contains("FH") ) {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00016");	//DNP
									} else if( jsonObjDtl.get("matrlCd").toString().contains("FM") || jsonObjDtl.get("matrlCd").toString().contains("FR") ) {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00007");	//OKURA
									} else {
										matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//솔브레인
									}
									
									matrlInWhsRqtVo.setLotNo 			(jsonObjDtl.get("motherRollLotNo").toString().replace(" ", ""));	//마더롤LotNo값
									matrlInWhsRqtVo.setBarcodeNo 		(jsonObjDtl.get("motherRollLotNo").toString().replace(" ", ""));	//마더롤LotNo값
									matrlInWhsRqtVo.setInWhsTime		(jsonObjDtl.get("inWhsTime").toString());		//입고 시간
									matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
									matrlInWhsRqtVo.setUpdId			(Utils.getUserId());
								
									matrlCodeAdmVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());			//자재코드
//									dealCorpAdmVo.setDealCorpCd			(jsonObjDtl.get("spplyDealCorpCd").toString());
									//값 담아주는 부분 끝
									
									matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);
									
//									logger.info("dealCorpAdmVo에 값 확인하기		>>>	" +dealCorpAdmVo);
//									logger.info("matrlInWhsRqtVo에 값 확인하기 	>>>	" +matrlInWhsRqtVo);
//									logger.info("matrlCodeAdmVo에 값 확인하기		>>>	" +matrlCodeAdmVo);
									
									logger.info("↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓한 개 값 저장시작↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
									matrlInWhsRqtService.create(matrlInWhsRqtVo);
									MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
									matrlInOutWhsAdmVo.setBarcodeNo(matrlInWhsRqtVo.getBarcodeNo());
									matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
									logger.info("↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑"+ t +"번째 "+ (i+1) +"개 값이 저장됨↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑");
							}
							//여기 안에서 저장 처리 시켜줌 끝
							
							//저장된 값은 삭제 시켜줌
							for(int i=0; i<jsonArray.size(); i++) {
								matrlInWhsRqtList.remove(0);				
							}
							//저장된 값은 삭제 시켜줌
							
							countA = countA - jsonArray.size();	//돌리 값을 다시 재정이 해준다.
							t = 0;
						}
						jsonData.put("result", "ok");
					}
					//검사 끝나고 실행하는 부분 끝
					
					//------------------------------------------------------가입고 등록 로직 진행 끝------------------------------------------------------//
					
					//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
					singletonSettings.useMatrlInout = false;
					//☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★
				} else {
					jsonData.put("message", "현재 가입고등록 시스템이 사용중입니다.");
					jsonData.put("result", "using");
					return jsonData;
				}
			} else {
				jsonData.put("message", "현재 가입고등록 시스템이 사용중입니다.");
				jsonData.put("result", "using");
				return jsonData;
			}
			
		} catch (Exception e) {
			logger.info("시퀀스 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	//솔브레인 엑셀 업로드(20220113추가 _신규2)_제 3공장 끝
	
	
	
	
	//엑셀 업로드(신규)_제 3공장
	@RequestMapping(value = "/io/matrlInWhsRqtSaveDataList_F3", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> matrlInWhsRqtSaveDataList_F3(@RequestBody List<Map<String, Object>> matrlInWhsRqtList, RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			logger.info("size >>> " +matrlInWhsRqtList.size());
			logger.info("matrlInWhsRqtList >>> " +matrlInWhsRqtList);
			
			//저장시 사용 할 변수들 정의-----------------
			List<MatrlInWhsRqtVo> InWhsRqtList = new ArrayList<MatrlInWhsRqtVo>();
			String groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();
			boolean ret	 = true;
			
			/*String time1 = DateUtil.getToday("yyyymmdd");
			String seqSt;
			int seqStart = 0;
			
			ret 		= true;
			seqSt 		= matrlInWhsRqtService.barcodeCreate(matrlInWhsRqtList.get(0).get("preInWhsDate").toString());
			seqStart 	= Integer.valueOf(seqSt);*/
			boolean checkNumeric = true;
			//저장시 사용 할 변수들 정의 끝-----------------
			
			//값 문제 있는지 한번에 확인하는 부분------------
			for(Map<String, Object> m : matrlInWhsRqtList) {
				
				MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
				MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
				DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();				
				int rollCount 					= Integer.parseInt(m.get("rollCount").toString());
				logger.info("하나씩 저장할 값 개수는 ? -----> "+rollCount);
				String motherrollLotNo = m.get("motherRollLotNo").toString().replace(" ", "");	//마더롤LotNo값
				
				String orderCount;	//LotNo값 채번 시켜주는 값
				
				//검사 값
				for(int i=0; i<rollCount; i++) {
					
					orderCount = (String) ((i+1)>9 ? Integer.toString((i+1)) : "0"+(i+1));
					
					matrlInWhsRqtVo.setPreInWhsDate		(m.get("preInWhsDate").toString());		//가입고일
					matrlInWhsRqtVo.setInWhsDate		(m.get("preInWhsDate").toString());		//입고일(가입고일 하고 동일하게 처리)
					matrlInWhsRqtVo.setLifeTime			(m.get("lifeTime").toString());			//유수명
					matrlInWhsRqtVo.setSurfaceDate		(m.get("surfaceDate").toString());		//표면처리일
					matrlInWhsRqtVo.setData1			(m.get("data1").toString());			//구매
					matrlInWhsRqtVo.setData2			(m.get("data2").toString());			//위치
					matrlInWhsRqtVo.setInWhsDesc		(m.get("inWhsDesc").toString());		//비고
					matrlInWhsRqtVo.setMatrlCd			(m.get("matrlCd").toString());			//자재코드
					matrlInWhsRqtVo.setMotherRollLot	(m.get("motherRollLot").toString());	//마더롤
					matrlInWhsRqtVo.setMotherRollLotNo	(m.get("motherRollLotNo").toString().replace(" ", ""));	//LotNo
					matrlInWhsRqtVo.setStandard			(m.get("standard").toString());			//규격
					matrlInWhsRqtVo.setRollCount		(m.get("rollCount").toString());		//롤수
					matrlInWhsRqtVo.setDiffQty			("0");
					matrlInWhsRqtVo.setApprovalCd		("002");
					matrlInWhsRqtVo.setStatusCd			("S");
					matrlInWhsRqtVo.setFifoCheck		("Y");
					matrlInWhsRqtVo.setPreInWhsQty		("20");		//나중에 값 변경해주기
					matrlInWhsRqtVo.setRemainQty		(matrlInWhsRqtVo.getPreInWhsQty());
					matrlInWhsRqtVo.setInWhsQty			("20");		//나중에 값 변경해주기
					matrlInWhsRqtVo.setInspectQty		("20");		//나중에 값 변경해주기
					matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//나중에 값 변경해주기
					matrlInWhsRqtVo.setLotNo			(motherrollLotNo + orderCount);	//마더롤LotNo에 01~N(롤수)번까지 채번 시켜준다.
					matrlInWhsRqtVo.setBarcodeNo		(motherrollLotNo + orderCount);
					matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
					matrlInWhsRqtVo.setUpdId			(Utils.getUserId());
				
					matrlCodeAdmVo.setMatrlCd			(m.get("matrlCd").toString());			//자재코드
				
				
					//입고량 추가됐을 때 주석 풀어주기(null체크)
					/*if (isNumberic(m.get("preInWhsQty").toString())) {
						checkNumeric = true;	//입고량이 null이 아니면 true를 반환한다.
					} else {
						checkNumeric = false;	//입고량이 null이면 false를 반환한다. 
					}*/
					
	//				if(matrlInWhsRqtVo.getMatrlCd().substring(0, 1).equals("F") && m.get("barcodeNo").toString().equals("")) { //필름이고 barcodeNo가 없으면 시스템이 채번을 해줌.
	//					String tmp= String.format("%03d", seqStart);
	//					String barcodeNo = matrlInWhsRqtVo.getPreInWhsDate().toString() + "-" + tmp;
	//					matrlInWhsRqtVo.setBarcodeNo(barcodeNo);
	//					seqStart++;
	//				} else {
	//					matrlInWhsRqtVo.setBarcodeNo(m.get("barcodeNo").toString().replace(" ", ""));
	//				}
					logger.info("LotNo 값 확인하기------------------------------> "+matrlInWhsRqtVo.getLotNo());
					String checkCode = matrlInWhsRqtService.checkCode(matrlInWhsRqtVo);		//jsp에서 전달한 값을 담아서 값이 있는지 없는지 check한다. check한 값을 checkCode에 담아 둔다.
					logger.info("checkCode 값 확인하는 부분 >>> " +checkCode);
					
					if(checkCode.equals("Y") && checkNumeric==true) {	//Mapper에서 처리해줬던 코드들 중에서 Y가 있으면, Y값을 반화해서 받았으면 아래를 실해해준다. +checkNumeric는 위에서  값을 받아온 값(입고량이 null이 아닐 때 true를 반환한다.)
						jsonData.put("result", "ok");					//jsp에서 저장됐다는 message를 보내준다.
						matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);		//Vo안에 InWhsGroupSeq한테 groupSeq를 지정해준다.
						InWhsRqtList.add(matrlInWhsRqtVo);				//InWhsRqtList는  ArrayList이다. ArrayList에 지정해줬던 값 전부를 보내준다.
					} else {											//Y가 아닐 때 실행 Mapper에서 조건을 봤을때 값이 하나라도 있으면 Y를 반환해준다.
						if (checkNumeric == true) {						//입고량이 null이 아닐때 실행 시킨다.
							jsonData.put("result", "error");			//jsp에 errorMessage를 출력 시킨다.
							logger.info("checkCode2 >>> " +checkCode);
							jsonData.put("message", checkCode);			//Mapper에서 출력한 결과 값을 여기로 뿌려준다.
							return jsonData;
						} else {										//만약 입고량이 null이면 아래 값을 반환해준다.
							jsonData.put("result", "error");
							jsonData.put("message","입고량 데이터를 확인 후 다시 시도해 주세요!");	
						}
						ret = false;	//위 조건이 실행안되면 빠져나오는 코드
						break;
					}
					//겹치는 motherRollLotNo 값 확인
					logger.info("lotNo 값 확인하기 >>> "+matrlInWhsRqtVo.getLotNo());
					int lineNum = matrlInWhsRqtService.groupSeqCount(matrlInWhsRqtVo.getLotNo());	//라인 번호를 가지고 온다.? -> groupSeq로 등록 되어있는 애들에 카운트를 세가지고 lineNum에 담아둔다.
					logger.info("lineNum 값 확인하기 >>> "+lineNum);
					if(ret) {							//지정한 코드가 알맞게 잘 돌아갔을 경우 여기로 들어온다.
						if(0<lineNum) {					// 똑같은 값이 하나라도 있으면 실행시킨다.
							jsonData.put("message", (lineNum + 1) + "번 라인과 겹치는 LotNo - " + matrlInWhsRqtList.get(lineNum).get("lotNo").toString() +" 가 있습니다! <br> 확인 후 다시 시도해 주세요.");
							jsonData.put("result", "fail");
						}
					}
					//겹치는 LotNo 값 확인
				}
			}
			//값 문제 있는지 한번에 확인하는 부분 끝------------
			
			//검사 끝나고 실행하는 부분
			if(ret) {
				
				//값을 나누거나 check 할 때 필요한 변수들 정의-----------------
				int countA 		= 0;	//for문 돌리 값
					countA 		= matrlInWhsRqtList.size();
					
				String matrlCdCompareValA		= null;			// 자재코드를 비교할 값 첫번째
				String matrlCdCompareValB 		= null; 		// 자재코드를 비교할 값 첫번째 다음 으로 오는 값
				
				String preInWhsDateCompareValA	= null;			// 가입고일을 비교할 값 첫번째
				String preInWhsDateCompareValB	= null; 		// 가입고일을 비교할 값 첫번째 다음 으로 오는 값
				String jsonStr 					= null;			// jsonObjDtl을 parser할 때 도움을 주기 위해 사용
				
				JSONArray jsonArray 		= new JSONArray();	// 재정의 한 값을 담을 Array
				JSONObject jsonObj 		= new JSONObject();		// parser할 값을 담음(jsonParser에 값을 보냄)
				ObjectMapper objMapper 	= new ObjectMapper();	// parser을 위해 도움을 주는  값(jsonObj에서 jsonParser으로 값을 보낼때 도와줌)
				JSONParser jsonParser 	= new JSONParser();		// 실제 parser할 값(jsonObj에서 값을 받음)
				JSONObject jsonObjDtl	= new JSONObject();		// parser한 값을 담음(jsonParser에서 값을 받음)
				//값을 나누거나 check 할 때 필요한 변수들 정의 끝-----------------
					
				//값 확인해서 나누는 부분  -> 여기서 나누면서 맞는 값인지 확인 해준다.
				for(int t=0; t<=countA; t++){
					logger.info("matrlInWhsRqtList값 확인하는 부분 : "+matrlInWhsRqtList);
					logger.info("matrlInWhsRqtList 값 사이즈 확인하는 부분 : "+matrlInWhsRqtList.size());
					jsonArray 	= new JSONArray();
					jsonObj = new JSONObject();
					
					for(int i=0; i<matrlInWhsRqtList.size(); i++) {
						
						//자재코드 담아주는 값
						matrlCdCompareValA = matrlInWhsRqtList.get(i).get("matrlCd").toString();
						if(i != matrlInWhsRqtList.size()-1){
							matrlCdCompareValB = matrlInWhsRqtList.get(i+1).get("matrlCd").toString();
						}
						
						//가입고일 담아주는 값
						preInWhsDateCompareValA = matrlInWhsRqtList.get(i).get("preInWhsDate").toString();
						if(i != matrlInWhsRqtList.size()-1){
							preInWhsDateCompareValB = matrlInWhsRqtList.get(i+1).get("preInWhsDate").toString();
						}
						
						if(matrlCdCompareValA.equals(matrlCdCompareValB) && preInWhsDateCompareValA.equals(preInWhsDateCompareValB)) {
							jsonArray.add(matrlInWhsRqtList.get(i));
							jsonObj.put(i, matrlInWhsRqtList.get(i));
						}else {
							jsonArray.add(matrlInWhsRqtList.get(i));
							jsonObj.put(i, matrlInWhsRqtList.get(i));
							break;
						}
					}
					//값 확인해서 나누는 부분 끝
					
					groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();	//그룹시퀀스 부여
					
					String orderCount;	//LotNo 채번 시켜주는 값
					
					//여기 안에서 저장 처리 시켜줌
					for(int i=0; i < jsonObj.size(); i++) {
						
						objMapper 	= new ObjectMapper();
						jsonStr 	= objMapper.writeValueAsString(jsonObj.get(i));	// 밑(jsonObjDtl)에서 바로 parser(파싱)이 안되서 ObjectMapper에서 한번 거친 다음 jsonStr에 담아서 보내준다. 
						jsonObjDtl	= (JSONObject) jsonParser.parse(jsonStr);		// jsonStr을 parser해준다.
						/*seqSt 		= matrlInWhsRqtService.barcodeCreate(jsonObjDtl.get("preInWhsDate").toString());
						seqStart 	= Integer.valueOf(seqSt);
						logger.info("JSON > jsonObjDtl > 자재코드 값 확인하기 > " +jsonObjDtl.get("matrlCd").toString());
						logger.info("JSON > jsonObjDtl > 가입고일 값 확인하기 > " +jsonObjDtl.get("preInWhsDate").toString());*/
						
						MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
						MatrlCodeAdmVo matrlCodeAdmVo 	= new MatrlCodeAdmVo();
						DealCorpAdmVo dealCorpAdmVo 	= new DealCorpAdmVo();
						
						String motherrollLotNo = jsonObjDtl.get("motherRollLotNo").toString().replace(" ", "");	//마더롤LotNo값
						
						int rollCount = Integer.parseInt(jsonObjDtl.get("rollCount").toString());
						
						for(int k=0; k<rollCount; k++) {
							orderCount = (String) ((k+1)>9 ? Integer.toString((k+1)) : "0"+(k+1));	//lotNo 채번해주는 값
							logger.info("orderCount : "+orderCount);
							logger.info("orderCount : "+motherrollLotNo + orderCount);
							
							//값 담아주는 부분
							matrlInWhsRqtVo.setPreInWhsDate		(jsonObjDtl.get("preInWhsDate").toString());	//가입고일
							matrlInWhsRqtVo.setInWhsDate		(jsonObjDtl.get("preInWhsDate").toString());	//입고일(가입고일 하고 동일하게 처리)
							matrlInWhsRqtVo.setLifeTime			(jsonObjDtl.get("lifeTime").toString());		//유수명
							matrlInWhsRqtVo.setSurfaceDate		(jsonObjDtl.get("surfaceDate").toString());		//표면처리일
							matrlInWhsRqtVo.setData1			(jsonObjDtl.get("data1").toString());			//구매
							matrlInWhsRqtVo.setData2			(jsonObjDtl.get("data2").toString());			//위치
							matrlInWhsRqtVo.setInWhsDesc		(jsonObjDtl.get("inWhsDesc").toString());		//비고
							matrlInWhsRqtVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());			//자재코드
							matrlInWhsRqtVo.setMotherRollLot	(jsonObjDtl.get("motherRollLot").toString());	//마더롤
							matrlInWhsRqtVo.setMotherRollLotNo	(jsonObjDtl.get("motherRollLotNo").toString().replace(" ", ""));	//LotNo
							matrlInWhsRqtVo.setStandard			(jsonObjDtl.get("standard").toString());		//규격
							matrlInWhsRqtVo.setRollCount		(jsonObjDtl.get("rollCount").toString());		//롤수
							matrlInWhsRqtVo.setDiffQty			("0");
							matrlInWhsRqtVo.setApprovalCd		("002");
							matrlInWhsRqtVo.setStatusCd			("S");
							matrlInWhsRqtVo.setFifoCheck		("Y");
							matrlInWhsRqtVo.setPreInWhsQty		("20");		//나중에 값 변경해주기
							matrlInWhsRqtVo.setRemainQty		(matrlInWhsRqtVo.getPreInWhsQty());
							matrlInWhsRqtVo.setInWhsQty			("20");		//나중에 값 변경해주기
							matrlInWhsRqtVo.setInspectQty		("20");		//나중에 값 변경해주기
							matrlInWhsRqtVo.setSpplyDealCorpCd	("00001");	//나중에 값 변경해주기
							matrlInWhsRqtVo.setLotNo			(motherrollLotNo + orderCount);	//마더롤LotNo에 01~N(롤수)번까지 채번 시켜준다.
							matrlInWhsRqtVo.setBarcodeNo		(motherrollLotNo + orderCount);
							matrlInWhsRqtVo.setRegId			(Utils.getUserId());			
							matrlInWhsRqtVo.setUpdId			(Utils.getUserId());
						
							matrlCodeAdmVo.setMatrlCd			(jsonObjDtl.get("matrlCd").toString());			//자재코드
//							dealCorpAdmVo.setDealCorpCd			(jsonObjDtl.get("spplyDealCorpCd").toString());
							//값 담아주는 부분 끝
							
	//						if(matrlInWhsRqtVo.getMatrlCd().substring(0, 1).equals("F") && jsonObjDtl.get("barcodeNo").toString().equals("")) { //필름이고 barcodeNo가 없으면 시스템이 채번을 해줌.
	//							String tmp= String.format("%03d", seqStart);
	//							String barcodeNo = matrlInWhsRqtVo.getPreInWhsDate().toString() + "-" + tmp;
	//							matrlInWhsRqtVo.setBarcodeNo(barcodeNo);
	//							seqStart++;
	//						} else {
	//							matrlInWhsRqtVo.setBarcodeNo(jsonObjDtl.get("barcodeNo").toString().replace(" ", ""));
	//						}
							
							matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);
							
							logger.info("dealCorpAdmVo에 값 확인하기		>>>	" +dealCorpAdmVo);
							logger.info("matrlInWhsRqtVo에 값 확인하기 	>>>	" +matrlInWhsRqtVo);
							logger.info("matrlCodeAdmVo에 값 확인하기		>>>	" +matrlCodeAdmVo);
							
							logger.info("↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓한 개 값 저장시작↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓");
							logger.info("groupSeqrk 값 확인		>>> " +groupSeq);
							logger.info("자재코드, 가입고일 확인하기		>>> " +jsonObjDtl.get("matrlCd").toString()+ ", " + jsonObjDtl.get("preInWhsDate").toString());
							logger.info("barcodeNo 값 확인하는 부분	>>> " +matrlInWhsRqtVo.getBarcodeNo());
							logger.info("전체 값 확인하는 부분입니다. 	>>> " +jsonObjDtl);
							matrlInWhsRqtService.create(matrlInWhsRqtVo);
							MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
							matrlInOutWhsAdmVo.setBarcodeNo(matrlInWhsRqtVo.getBarcodeNo());
							matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
							logger.info("↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑"+ t +"번째 "+ (i+1) +"개 값이 저장됨↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑");
						}
					}
					//여기 안에서 저장 처리 시켜줌 끝
					
					//저장된 값은 삭제 시켜줌
					for(int i=0; i<jsonArray.size(); i++) {
						matrlInWhsRqtList.remove(0);				
					}
					//저장된 값은 삭제 시켜줌
					
					countA = countA-jsonArray.size();	//돌리 값을 다시 재정이 해준다.
					t=0;
				}
				jsonData.put("result", "ok");
			}
			//검사 끝나고 실행하는 부분 끝
			
		} catch (Exception e) {
			logger.info("시퀀스 생성 실패");
			e.printStackTrace();
			jsonData.put("message", "시스템오류가 발생했습니다.");
			jsonData.put("result", "fail");			 
		}
		return jsonData;
	}
	
	
	
	//엑셀 업로드(기존)
//	@RequestMapping(value = "/io/matrlInWhsRqtSaveDataList", method = RequestMethod.POST)
//	public @ResponseBody Map<String, Object> matrlInWhsRqtSaveDataList(@RequestBody List<Map<String, Object>> matrlInWhsRqtList, RedirectAttributes rttr,HttpServletRequest request) throws Exception {
//		
//		Map<String, Object> jsonData = new HashMap<String, Object>();
//		logger.info("자재정보 엑셀등 = "+ matrlInWhsRqtList);
//		
//		List<MatrlInWhsRqtVo> InWhsRqtList = new ArrayList<MatrlInWhsRqtVo>();	
//		String groupSeq = matrlInWhsRqtService.selectInWhsGroupSeq().toString();
//		boolean ret = true;
//		//SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
//		//SimpleDateFormat format2 = new SimpleDateFormat ("yyyy-MM-dd");
//		//Date time = new Date();		
//		//String time1 = format1.format(time);
//		//String time2 = format2.format(time);
//		
//		try {
//			
//			logger.info(groupSeq);
//			jsonData.put("data", groupSeq);
//
//			String time1 = DateUtil.getToday("yyyymmdd");
//			String seqSt;
//			int seqStart = 0;
//			
//			ret = true;
//			seqSt = matrlInWhsRqtService.barcodeCreate(matrlInWhsRqtList.get(0).get("preInWhsDate").toString());
//			seqStart = Integer.valueOf(seqSt);
//			boolean checkNumeric = true;
//			for(Map<String, Object> m : matrlInWhsRqtList) {
//	
//				logger.debug("matrlInOutWhsAdmVo : " + m);
//				MatrlInWhsRqtVo matrlInWhsRqtVo = new MatrlInWhsRqtVo();
//				MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
//				DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();				
//				matrlInWhsRqtVo.setLotNo(m.get("lotNo").toString().replace(" ", ""));
//				matrlInWhsRqtVo.setSrLot(m.get("srLot").toString());			
//				matrlInWhsRqtVo.setMatrlCd(m.get("matrlCd").toString());				
//				matrlInWhsRqtVo.setPreInWhsQty(m.get("preInWhsQty").toString());
//				matrlInWhsRqtVo.setInWhsQty(m.get("preInWhsQty").toString());
//				matrlInWhsRqtVo.setInspectQty(m.get("preInWhsQty").toString());
//				matrlInWhsRqtVo.setDiffQty("0");
//				matrlInWhsRqtVo.setInWhsLength(m.get("inWhsLength").toString());
//				matrlInWhsRqtVo.setSpplyDealCorpCd(m.get("spplyDealCorpCd").toString());
//				matrlInWhsRqtVo.setSpplyDealCorpNm(m.get("spplyDealCorpNm").toString());
//				matrlInWhsRqtVo.setPreInWhsDate(m.get("preInWhsDate").toString());
//				matrlInWhsRqtVo.setApprovalCd("002");			
//				matrlInWhsRqtVo.setStatusCd("S");						
//				matrlInWhsRqtVo.setInWhsDesc(m.get("inWhsDesc").toString());
//				matrlInWhsRqtVo.setFifoCheck("Y");
//				matrlInWhsRqtVo.setRegId(Utils.getUserId());			
//				matrlInWhsRqtVo.setUpdId(Utils.getUserId());			
//				matrlCodeAdmVo.setMatrlCd(m.get("matrlCd").toString());
//				dealCorpAdmVo.setDealCorpCd(m.get("spplyDealCorpCd").toString());
//				
//				if (isNumberic(m.get("preInWhsQty").toString()) /* && isNumberic(m.get("inWhsLength").toString()) */) {
//					checkNumeric = true;
//				} else {
//					checkNumeric = false;
//				}
//			
//				
//				//logger.info("1111111111111111111111111111 : " + m.get("barcodeNo").toString());
//
//				if(matrlInWhsRqtVo.getMatrlCd().substring(0, 1).equals("F") && m.get("barcodeNo").toString().equals("")) { //필름이고 barcodeNo가 없으면 시스템이 채번을 해줌.
//					
//					String tmp= String.format("%03d", seqStart);
//					String barcodeNo = matrlInWhsRqtVo.getPreInWhsDate().toString() + "-" + tmp;
//					matrlInWhsRqtVo.setBarcodeNo(barcodeNo);
//					seqStart++;
//					
//				} else {
//					matrlInWhsRqtVo.setBarcodeNo(m.get("barcodeNo").toString().replace(" ", ""));
//				}
//				String checkCode = matrlInWhsRqtService.checkCode(matrlInWhsRqtVo);
//				
//				if(checkCode.equals("Y") && checkNumeric==true) {				
//					jsonData.put("result", "ok");
//					matrlInWhsRqtVo.setInWhsGroupSeq(groupSeq);
//					InWhsRqtList.add(matrlInWhsRqtVo);
//					
//				} else {
//					if (checkNumeric == true) {
//						jsonData.put("result", "error");
//						jsonData.put("message", checkCode);
//					} else {
//						jsonData.put("result", "error");
//						jsonData.put("message","입고량 데이터를 확인 후 다시 시도해 주세요!");	
//					}
//					ret = false;
//					break;
//				}
//				
//				
//				/*
//				 * if(matrlInWhsRqtService.read(matrlInWhsRqtVo) != null) {
//				 * jsonData.put("result", "error"); jsonData.put("message",
//				 * "LOT NO가 올바르지 않습니다."); break; } if(matrlCodeAdmService.read(matrlCodeAdmVo)
//				 * == null) { jsonData.put("result", "error"); jsonData.put("message",
//				 * "자재코드가 올바르지 않습니다."); logger.info(matrlCodeAdmVo); break; }
//				 * if(dealCorpAdmService.read(dealCorpAdmVo) == null) { jsonData.put("result",
//				 * "error"); jsonData.put("message", "업체코드가 올바르지 않습니다.");
//				 * logger.info(dealCorpAdmVo); break; }
//				 */
//			}		
//			
//			if(ret) {
//				for(MatrlInWhsRqtVo m : InWhsRqtList) {	
//					logger.info("InWhsRqtList = "+ m);
//					matrlInWhsRqtService.create(m);
//					MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
//					matrlInOutWhsAdmVo.setBarcodeNo(m.getBarcodeNo());
//					matrlInOutWhsAdmService.insertMatrlHist(matrlInOutWhsAdmVo);		//자재이력등록
//				}			
//			}
//			
//
//		} catch (Exception e) {
//			logger.info("시퀀스 생성 실패");
//			e.printStackTrace();
//			jsonData.put("message", "시스템오류가 발생했습니다.");
//			jsonData.put("result", "fail");			 
//		} finally {
//			int lineNum = matrlInWhsRqtService.groupSeqCount(groupSeq);
//			if(ret) {
//				if(InWhsRqtList.size() != lineNum) {
//					matrlInWhsRqtService.groupSeqDelete(groupSeq);
//					MatrlInOutWhsAdmVo matrlInOutWhsAdmVo = new MatrlInOutWhsAdmVo();
//					matrlInOutWhsAdmVo.setInWhsGroupSeq(groupSeq);
//					matrlInOutWhsAdmService.deleteMatrlHistInWhsGroupSeq(matrlInOutWhsAdmVo);	//이력 삭제
//					jsonData.put("message", (lineNum + 1) + "번 라인과 겹치는 LotNo - " + matrlInWhsRqtList.get(lineNum).get("lotNo").toString() +" 가 있습니다! <br> 확인 후 다시 시도해 주세요.");
//					jsonData.put("result", "fail");
//				}
//			}			
//		}
//		return jsonData;
//	}
	
	/*
	//자재코드관리 목록조회
		@RequestMapping(value = "/io/matrlInWhsRqtpopDataList", method = RequestMethod.GET)
		public @ResponseBody Map<String, Object> matrlInWhsRqtpopDataList(MatrlInWhsRqtVo matrlInWhsRqtVo, String path) throws Exception {
			
			CustomerExcelReader excelReader = new CustomerExcelReader();
			Map<String, Object> jsonData = new HashMap<String, Object>();
			DealCorpAdmVo dealCorpAdmVo = new DealCorpAdmVo();
			MatrlCodeAdmVo matrlCodeAdmVo = new MatrlCodeAdmVo();
			
			List<MatrlInWhsRqtVo> matrlInWhsRqtData = excelReader.fileload(path);
			logger.info("자재입고관리 엑셀조회");
			
			for(int i = 0; i <  )
			matrlInWhsRqtVo = matrlInWhsRqtData.get(0);	
			matrlCodeAdmVo.setMatrlCd(matrlInWhsRqtVo.getMatrlCd());
			matrlCodeAdmVo = matrlCodeAdmService.read(matrlCodeAdmVo);
			matrlCodeAdmVo.getMatrlNm();
			matrlCodeAdmVo.getLength();
			
			dealCorpAdmVo.setDealCorpCd(matrlInWhsRqtVo.getDealCorpCd());
			dealCorpAdmVo = dealCorpAdmService.read(dealCorpAdmVo);
			dealCorpAdmVo.getDealCorpNm();
			
		
			jsonData.put("data", matrlInWhsRqtData);
			
			return jsonData;
		}*/
	
	
	// Controller 

	static boolean isNumberic(String s) { //숫자 판별 함수
		try {
	     	Double.parseDouble(s);
	    	return true;
	    } catch(NumberFormatException e) {  //문자열이 나타내는 숫자와 일치하지 않는 타입의 숫자로 변환 시 발생
	    	return false;
	    }
	}
	
	//기본양식 다운로드
	 @RequestMapping(value="io/matrlInWhsRqtBasicForm", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> matrlInWhsRqtBasicForm(HttpServletResponse res , HttpServletRequest req, ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			  String saveFile = "가입고_기본양식(MP).xlsx"; 
			  String filePath = matrlInWhsRqtBasicForm+"가입고_기본양식(MP).xlsx";
			  fileDownload(res, req, saveFile, filePath);
			logger.info("파일 다운");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	 
	//추가양식 다운로드
	 @RequestMapping(value="io/matrlInWhsRqtBasicForm_F3", method = RequestMethod.GET)
	 public @ResponseBody Map<String, Object> matrlInWhsRqtBasicForm_F3(HttpServletResponse res , HttpServletRequest req, ItemPartAdmVo itemPartAdmVo) throws Exception{
		Map<String, Object> jsonData = new HashMap<String, Object>();
		try {
			  String saveFile = "가입고_기본양식(SLD).xlsx"; 
			  String filePath = matrlInWhsRqtBasicForm_F3+"가입고_기본양식(SLD).xlsx";
			  fileDownload(res, req, saveFile, filePath);
			logger.info("파일 다운");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonData;
	}
	 
	 //파일 다운로드
	 public void fileDownload( HttpServletResponse res , HttpServletRequest req, String saveFile, String filePath) throws Exception{
		try {
			
			String dFile 	= saveFile;
			String path 	= filePath;
			File file 		= new File(path);
		
			String userAgent = req.getHeader("User-Agent");

			boolean ie = (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1);

			if (ie) {
				logger.info("익스");
				dFile = URLEncoder.encode(dFile, "UTF-8").replaceAll("\\+", "%20");
			} else {
				logger.info("크롬");
				dFile = new String(dFile.getBytes("UTF-8"), "ISO-8859-1");
			}
			
			res.setContentType("application/octet-stream");
			res.setHeader("Content-Disposition", "attachment; fileName=\"" + dFile + "\";");

			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = res.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	 
	
}
