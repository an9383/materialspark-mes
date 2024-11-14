package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondTempaturSixFloorAdmVo {
	
	private String tempaturCondCd;       //온도조건코드
	private String tempaturCondNm;       //온도조건명
	private String upTabHeatCond;
	private String upTabHeatPlus;
	private String upTabHeatMinus;
	private String downTabHeatCond;
	private String downTabHeatPlus;
	private String downTabHeatMinus;
	private String upRollHeatCond;
	private String upRollHeatPlus;
	private String upRollHeatMinus;
	private String downRollHeatCond;
	private String downRollHeatPlus;
	private String downRollHeatMinus;
	private String upFilmJoinTopCond;
	private String upFilmJoinTopPlus;
	private String upFilmJoinTopMinus;
	private String upFilmJoinBottomCond;
	private String upFilmJoinBottomPlus;
	private String upFilmJoinBottomMinus;
	private String downFilmJoinTopCond;
	private String downFilmJoinTopPlus;
	private String downFilmJoinTopMinus;
	private String downFilmJoinBottomCond;
	private String downFilmJoinBottomPlus;
	private String downFilmJoinBottomMinus;
	private String downTabHeatKeepCond;
	private String downTabHeatKeepPlus;
	private String downTabHeatKeepMinus;
	private String fup1stMTsidCond;
	private String fup1stMTsidPlus;
	private String fup1stMTsidMinus;
	private String fdown1stMTsidCond;
	private String fdown1stMTsidPlus;
	private String fdown1stMTsidMinus;
	private String fup1stMTmidCond;
	private String fup1stMTmidPlus;
	private String fup1stMTmidMinus;
	private String fdown1stMTmidCond;
	private String fdown1stMTmidPlus;
	private String fdown1stMTmidMinus;
	private String fup1stMTpushCond;
	private String fup1stMTpushPlus;
	private String fup1stMTpushMinus;
	private String fdown1stMTpushCond;
	private String fdown1stMTpushPlus;
	private String fdown1stMTpushMinus;
	private String bup1stMTsidCond;
	private String bup1stMTsidPlus;
	private String bup1stMTsidMinus;
	private String bdown1stMTsidCond;
	private String bdown1stMTsidPlus;
	private String bdown1stMTsidMinus;
	private String bup1stMTmidCond;
	private String bup1stMTmidPlus;
	private String bup1stMTmidMinus;
	private String bdown1stMTmidCond;
	private String bdown1stMTmidPlus;
	private String bdown1stMTmidMinus;
	private String bup1stPushCond;
	private String bup1stPushPlus;
	private String bup1stPushMinus;
	private String bdown1stPushCond;
	private String bdown1stPushPlus;
	private String bdown1stPushMinus;
	private String fupFilmFuseCond;
	private String fupFilmFusePlus;
	private String fupFilmFuseMinus;
	private String fdownFilmFuseCond;
	private String fdownFilmFusePlus;
	private String fdownFilmFuseMinus;
	private String bupFilmFuseCond;
	private String bupFilmFusePlus;
	private String bupFilmFuseMinus;
	private String bdownFilmFuseCond;
	private String bdownFilmFusePlus;
	private String bdownFilmFuseMinus;
	private String fup2ndMTsidCond;
	private String fup2ndMTsidPlus;
	private String fup2ndMTsidMinus;
	private String fdown2ndMTsidCond;
	private String fdown2ndMTsidPlus;
	private String fdown2ndMTsidMinus;
	private String fup2ndMTmidCond;
	private String fup2ndMTmidPlus;
	private String fup2ndMTmidMinus;
	private String fdown2ndMTmidCond;
	private String fdown2ndMTmidPlus;
	private String fdown2ndMTmidMinus;
	private String bup2ndMTsidCond;
	private String bup2ndMTsidPlus;
	private String bup2ndMTsidMinus;
	private String bdown2ndMTsidCond;
	private String bdown2ndMTsidPlus;
	private String bdown2ndMTsidMinus;
	private String bup2ndMTmidCond;
	private String bup2ndMTmidPlus;
	private String bup2ndMTmidMinus;
	private String bdown2ndMTmidCond;
	private String bdown2ndMTmidPlus;
	private String bdown2ndMTmidMinus;
	private String fup3rdMTsidCond;
	private String fup3rdMTsidPlus;
	private String fup3rdMTsidMinus;
	private String fdown3rdMTsidCond;
	private String fdown3rdMTsidPlus;
	private String fdown3rdMTsidMinus;
	private String fup3rdMTmidCond;
	private String fup3rdMTmidPlus;
	private String fup3rdMTmidMinus;
	private String fdown3rdMTmidCond;
	private String fdown3rdMTmidPlus;
	private String fdown3rdMTmidMinus;
	private String bup3rdMTsidCond;
	private String bup3rdMTsidPlus;
	private String bup3rdMTsidMinus;
	private String bdown3rdMTsidCond;
	private String bdown3rdMTsidPlus;
	private String bdown3rdMTsidMinus;
	private String bup3rdMTmidCond;
	private String bup3rdMTmidPlus;
	private String bup3rdMTmidMinus;
	private String bdown3rdMTmidCond;
	private String bdown3rdMTmidPlus;
	private String bdown3rdMTmidMinus;
	private String fupFilmRfmCoolCond;
	private String fupFilmRfmCoolPlus;
	private String fupFilmRfmCoolMinus;
	private String fdownFilmRfmCoolCond;
	private String fdownFilmRfmCoolPlus;
	private String fdownFilmRfmCoolMinus;
	private String bupFilmRfmCoolCond;
	private String bupFilmRfmCoolPlus;
	private String bupFilmRfmCoolMinus;
	private String bdownFilmRfmCoolCond;
	private String bdownFilmRfmCoolPlus;
	private String bdownFilmRfmCoolMinus;
	//여기까지 개수 고정 후 사용(137개) 추가되면 Vo 추가 후 Controller도 추가된 만큼 늘려주기(bmsc3050 경로 메인 부분)
	
	private String menuAuth;            //메뉴권한 (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
	private String useYnCd;             //사용여부
	private String regId;               //등록자
	private Date regDate;               //등록일
	private String updId;               //수정자
	private Date updDate;               //수정일
	
	//제조조건관리에서 필요한 컬럼
	private String equipCondSeq;		//설비코드 Seq
	private String goodsCd;				
	private String goodsNm;
	private String pageGubun;			//페이지 구분자  (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)

}