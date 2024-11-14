package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipPrcssFaultyAdmVo {
	
	private String menuAuth;
	private String equipCd;             //설비코드
	private String faultyRegDate;       //불량등록일
	private String dayNightCd;          //주야간구분
	private int prcsCnt;				//공정불량수
	private float prcsTotal;			//공정불량총량
	private float prcsPms;              //PMS
	private float prcsPfs;              //PFS
	private float prcsPstab;            //P찍힘
	private float prcsPaliensbst;       //P이물
	private float prcsPpolutn;          //P오염
	private float prcsGilt;             //도금박리
	private float prcsFbreak;           //F꺽임
	private float prcsFagglomt;         //F뭉침
	private float prcsFpress;           //F눌림
	private float prcsFtornout;         //F뜯김
	private float prcsTeflon;           //필름자국(테프론)
	private float prcsMargnDvat;        //마진편차
	private float prcsThickness;        //총두께(M+F)
	private float prcsSurfceBb;         //표면기포
	private float prcsEdgeBb;           //엣지기포
	private float prcsMburr;            //메탈-Burr
	private float prcsRburr;            //R-Burr
	private float prcsSize;             //치수
	private float prcsLayer;            //레이어
	private float prcsUnjinjeop;        //미진접
	private float prcsUnattch;          //미부착
	private float prcsFilmDepth;        //필름폭
	private String regId;               //등록자
	private Date regDate;               //등록일
	private String updId;               //수정자
	private Date updDate;               //수정일
	private String gubun;
	private String workOrdNo;
	private String systemCode;

	//private String dayTotalPrcssSum;
	//private String nightTotalPrcssSum;
	//private String totalPrcssSum;
	
	private String equipNm;
	private String dayNightNm;
	private String faultyDateFrom;	//검색기간 1
	private String faultyDateTo;	//검색기간 2

	private String ordDate;
	private String goodsCd;          //제품코드
	private String goodsNm;          //제품명
	private String qutyCd;           //재질코드
	private String alnicuMatrlNm;    //재질명
	private String ordGubun;         //주야
	private int prcsTotalEa;	     //수량(EA)
	private int prcsPmsEa;           //
	private int prcsPfsEa;           //
	private int prcsPstabEa;         //
	private int prcsPaliensbstEa;    //
	private int prcsPpolutnEa;       //
	private int prcsGiltEa;          //
	private int prcsFbreakEa;        //
	private int prcsFagglomtEa;      //
	private int prcsFpressEa;        //
	private int prcsFtornoutEa;      //
	private int prcsTeflonEa;        //
	private int prcsMargnDvatEa;     //
	private int prcsThicknessEa;     //
	private int prcsSurfceBbEa;      //
	private int prcsEdgeBbEa;        //
	private int prcsMburrEa;         //
	private int prcsRburrEa;         //
	private int prcsSizeEa;          //
	private int prcsLayerEa;         //
	private int prcsUnjinjeopEa;     //
	private int prcsUnattchEa;       //
	private int prcsFilmDepthEa;     //
	private String workTeamCd;       //작업조코드
	private String workTeamNm;       //작업조명
	private String mainWorkChargr;   //메인담당
	private String userNm;            //메인담당이름
	private String faulty;
	private String gravity;
	
}