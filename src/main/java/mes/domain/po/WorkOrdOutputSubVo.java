package mes.domain.po;

import lombok.Data;

@Data
public class WorkOrdOutputSubVo {
	
	private String menuAuth;			//메뉴권한
	private String equipCd;
	private String equipNm;
	private String equipCondSeq;
	private String workOrdNo;
	private String workOrdLotNo;
	private String splitWorkOrdNo;
	private String splitWorkOrdLotNo;
	private String workOrdSeq;
	private String ordLotNo;
	private String lotNo;
	private String stepCd;
	private String subWorkStatusCd;		//생산수량 작업상태코드
	private String subWorkStatusNm;		//생산수량 작업상태명
	private String outputWeight;
	private int outputCnt;
	private int outputTotalCnt;
	private String visionEdgeWeight;	//비전엣지검사무게
	private int visionEdgeCnt;			//비전에싲검사수량
	private float sumOutputWeight;		//생산무게 합
	private int sumOutputCnt;			//생산수량 합
	private float sumVisionEdgeWeight;	//비전무게 합
	private int sumVisionEdgeCnt;		//비전수량 합
	private float totalWeight;			//총 생산무게 + 총 비전무게
	private int totalCnt;				//총 생산수량 + 총  비전수량
	private int userInputInspctCnt;		//실 검사수량
	private int workOrdLotNoTotalCnt;	//생산LotNo기준 총 생산수량 합
	private int countLotOutputSub;		//작업지시 종료 시 각 주자재마다 생산실적이 최소1개 이상 입력되었는지 확인할때 사용
	
	private int countLotFaultyAdm;		//불량중량에 값이 있는지
	private int countLotAgt;			//초중종물에 값이 있는지
	
	private String targetCnt;
	private String gubun;
	private String gubunNm;
	private String workOrdDate;
	private String mainWorkChargr;
	private String mainWorkChargrNm;
	private String mainWorkChargrNm2;
	private String teamCd;
	private String teamNm;
	private int edgeOutputCnt;
	private int edgeFaultyCnt;
	private int edgeSampleCnt;
	private float edgeRollFaultySize;
	private float edgeSymbolFaultySize;
	private float edgeBurFaultySize;
	private String edgeInspctCharger;
	private String edgeInspctChargerNm;
	private String edgeInspctDate;
	private int appearOutputCnt;
	private int appearFaultyCnt;
	private String appearInspctCharger;
	private String appearInspctChargerNm;
	private String appearInspctDate;
	private int totalFaultyCnt;
	private int userOutputCnt;
	private int appearAbrfCnt;
	private int appearAbrsCnt;
	private int appearDmsCnt;
	private String packYn;
	private String packNumber;
	private String packOrdLotNoList;
	private int packTotalCnt;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;
	private String ordDate;
	private String mainMatrlCd;
	private String userId;
	private String userNm;
	private String ipAddress;
	private String dltId;
	private String dltDate;
	
	private String goodsCd;
	private String goodsNm; 
	private String qutyCd;
	private String qutyNm;
	private String packUnitCd;
	private String packUnitNm;
	
	private int packCnt;
	private String packDate;
	private String model;
	private float faultyPercent;
	
	private String workOrdSeqCount;
	
	private String appearOutputRatio; // 양품률
	private String appearFaultyRatio; // 불량률
	
	private String workerId;
	private String workerIdNm;
	private String workTeamCd;
	private String workTeamNm;
	
	private String checkWorkOrdLotNoOption;	//기초코드 081의 특정 작지 주재료의 주&야간이 변경 될시 새로운 생산LotNo채번 옵션 여부
	private int bodyLength;					//생산LotNo & 생산전표번호 중 D or N(주야구분) 까지의 길이 -> 설비명의 길이가 달라질것을 대비해 동적으로 대응되도록 만듬
	
	private String inspctCharger;
	private String inspctChargerNm;
	private String dayNightCd;
	private String dayNightNm;
	private String faultyRegDate;
	private String seq;
	private int faultyCntSum;
	
	private String changeUserNumber;
	private String subOrdLotNo; //생산전표번호
	private String productionperFormanceRegDate; //해당생산전표번호의 RegDate
	private int countTray;	//트레이 등록되어있는지 확인하는 값
	private String faultyTrayCheckNum;
	
	private String visionInspCnt; //비전검사수량 (외관검사)
	private String workOrdEndTime;
	
}