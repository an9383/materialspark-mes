package mes.domain.wm;

import java.util.Date;
import lombok.Data;

@Data
public class VisionDataVo {
	
	private String menuAuth;        //메뉴권한
	private String closeTime;
	private String workOrdNo;
	private String fairCnt;
	private String etcSize;
	private String filmOverlap;
	private String filmAliensbst;
	private String filmScratch;
	private String filmTornout;
	private String filmSurfceBb;
	private String filmBurrAliensbst;
	private String filmEdgeBb;
	private String filmMismatch;
	private String filmSum;
	private String metalFstab;
	private String metalSum;
	private String metalPolutn;
	private String metalScratch;
	private String metalTransform;
	private String filmTeflon;
	private String filmUnjinjeop;
	private String dataSetCloseVal[];
	private String totalFaulty;
	
	private String equipCd;           //설비코드
	private String equipNm;           //설비코드
	private String goodsCd;           //제품코드
	private String workGubunCd;       //주야구분
	private String workGubunNm;       //주야구분
	private String planRegDate;       //조건등록일
	private String regId;             //등록자
	private Date regDate;             //등록일
	private String updId;             //수정자
	private Date updDate;             //수정일
	private String equipCondSeq;	  //BOM 정보 SEQ
	
	//join시 사용
	private String goodsNm;			//제품코드관리 - 제품명
	private String model;			//제품코드관리 규격
	private String modelNo;			//제품코드관리 모델No
	private String qutyCd;			//자재코드관리 - 자재코드(A, F, N)
	private String qutyNm;			//자재코드관리 - 자재코드명 (AL, DNP, Nicu)
	private String chamferYnNm;		//자재코드관리 - 면취(압연) 유무
	private String surfaceTrtmtCd;  //자재코드관리 - 표면처리코드
	private String surfaceTrtmtNm;  //자재코드관리 - 표면처리명
	private String workStatusCd;    //작지상태코드
	private String workStatusNm;    //작지상태명
	private String alnicuMatrlCd;
	private String alnicuMatrlNm;
	private String filmMatrlNm;
	private String filmMatrlCd;
	private String dealCorpCd;
	private String dealCorpNm;
	private String serverDate;
	private String chooseDateTo;
	private String chooseDateFuture;
	private String visionGubun;
	
	private String workChargr;
	private String workChargrNm;
	private String dayNightGubun;
	private String insertDate;
	private String workerId;
	private String workerIdNm;
	private String diff;
	private String outputCnt;
	
	private String reserved1;
	private String reserved2;
	private String reserved3;
	private String reserved4;
	private String reserved5;
	private String reserved6;
	private String reserved7;
	private String reserved8;
	private String reserved9;
	private String reserved10;
	private String reserved11;
	private String reserved12;
	private String reserved13;
	private String reserved14;
	private String reserved15;
	private String reserved16;
	private String reserved17;
	private String reserved18;
	private String reserved19;
	private String reserved20;
	private String reserved21;
	private String reserved22;
	private String reserved23;
	private String reserved24;
	private String reserved25;
	private String reserved26;
	private String reserved27;
	private String reserved28;
	private String reserved29;
	private String reserved30;
	private String reserved31;
	private String reserved32;
	private String reserved33;
	private String reserved34;
	private String reserved35;
	private String reserved36;
	private String reserved37;
	private String reserved38;
	private String reserved39;
	private String reserved40;
	private String lotNo;
	private String faultyCnt;
	private String exceptCnt;
	
	private String visionTotal;
	private String appearFaultyCnt;
	private String eFaultyCnt;
	private String appearOutputCnt;
	private String shipFaultyCnt;
	private String reShipFaultyCnt;
	private String visionFaulty;
	private String faultyTotal;
	
	private String chooseDateFrom;


	

}