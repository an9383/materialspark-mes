package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipReplaceFaultyAdmVo {
	
	private String menuAuth;
	private String equipCd;           //설비코드
	private String faultyRegDate;     //불량등록일
	private String dayNightCd;        //주야간구분
	private int rpcCnt;				  //설비교체불량수
	private float rpcTotal;			  //설비교체불량총량
	private float rpcMetal1;          //메탈교체1회
	private float rpcMetal2;          //메탈교체2회
	private float rpcMetal3;          //메탈교체3회
	private float rpcMetal4;          //메탈교체4회
	private float rpcMetal5;          //메탈교체5회
	private float rpcFilm1;           //필름교체1회
	private float rpcFilm2;           //필름교체2회
	private float rpcFilm3;           //필름교체3회
	private float rpcFilm4;           //필름교체4회
	private float rpcFilm5;           //필름교체5회
	private float rpcSilicon1;        //실리콘교체1회
	private float rpcSilicon2;        //실리콘교체2회
	private float rpcSilicon3;        //실리콘교체3회
	private float rpcSilicon4;        //실리콘교체4회
	private float rpcSilicon5;        //실리콘교체5회
	private float rpcTeflon1;         //테프론교체1회
	private float rpcTeflon2;         //테프론교체2회
	private float rpcTeflon3;         //테프론교체3회
	private float rpcTeflon4;         //테프론교체4회
	private float rpcTeflon5;         //테프론교체5회
	private float rpcJc1;             //J/C교체1회
	private float rpcJc2;             //J/C교체2회
	private float rpcJc3;             //J/C교체3회
	private float rpcJc4;             //J/C교체4회
	private float rpcJc5;             //J/C교체5회
	private String regId;             //등록자
	private Date regDate;             //등록일
	private String updId;             //수정자
	private Date updDate;             //수정일
	private String workOrdNo;
	private String systemCode;
	private String ordDate;

	//private String dayTotalReplaceCount;
	//private String nightTotalReplaceCount;
	//private String totalReplaceCount;
	//private String dayTotalReplaceSum;
	//private String nightTotalReplaceSum;
	//private String totalReplaceSum;

	private String dayNightNm;
	private String faultyDateFrom;	//검색기간 1
	private String faultyDateTo;	//검색기간 2
	
	private String equipNm;			//설비명
	private String goodsCd;          //제품코드
	private String goodsNm;          //제품명
	private String qutyCd;           //재질코드
	private String alnicuMatrlNm;    //재질명
	private String ordGubun;         //주야
	private int metalCnt;
	private float metalSum;
	private int metalSumEa;
	private int filmCnt;
	private float filmSum;
	private int filmSumEa;
	private int siliconCnt;
	private float siliconSum;
	private int siliconSumEa;
	private int teflonCnt;
	private float teflonSum;
	private int teflonSumEa;
	private String workTeamCd;       //작업조코드
	private String workTeamNm;       //작업조명
	private String mainWorkChargr;   //메인담당
	private String userNm;           //메인담당이름
	
	private String faulty;
	private String gravity;
	
}