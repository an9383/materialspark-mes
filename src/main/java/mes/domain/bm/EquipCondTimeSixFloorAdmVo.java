package mes.domain.bm;

import java.util.Date;
import lombok.Data;

@Data
public class EquipCondTimeSixFloorAdmVo {
	
	private String timeCondCd;           //시간조건코드
	private String timeCondNm;           //시간조건명
	private String oneStMTwaittimeCond;
	private String oneStMTwaittimePlus;
	private String oneStMTwaittimeMinus;
	private String oneStMTheattimeCond;
	private String oneStMTheattimePlus;
	private String oneStMTheattimeMinus;
	private String oneStMTpushwaittimeCond;
	private String oneStMTpushwaittimePlus;
	private String oneStMTpushwaittimeMinus;
	private String oneStMTpushheattimeCond;
	private String oneStMTpushheattimePlus;
	private String oneStMTpushheattimeMinus;
	private String twoNdMTwaittimeCond;
	private String twoNdMTwaittimePlus;
	private String twoNdMTwaittimeMinus;
	private String twoNdMTheattimeCond;
	private String twoNdMTheattimePlus;
	private String twoNdMTheattimeMinus;
	private String twoNdMTpushwaittimeCond;
	private String twoNdMTpushwaittimePlus;
	private String twoNdMTpushwaittimeMinus;
	private String twoNdMTpushheattimeCond;
	private String twoNdMTpushheattimePlus;
	private String twoNdMTpushheattimeMinus;
	private String threeRdMTwaittimeCond;
	private String threeRdMTwaittimePlus;
	private String threeRdMTwaittimeMinus;
	private String threeRdMTheattimeCond;
	private String threeRdMTheattimePlus;
	private String threeRdMTheattimeMinus;
	private String threeRdMTpushwaittimeCond;
	private String threeRdMTpushwaittimePlus;
	private String threeRdMTpushwaittimeMinus;
	private String threeRdMTpushheattimeCond;
	private String threeRdMTpushheattimePlus;
	private String threeRdMTpushheattimeMinus;
	private String filmFSH1operwaittimeCond;
	private String filmFSH1operwaittimePlus;
	private String filmFSH1operwaittimeMinus;
	private String filmFSH1operheattimeCond;
	private String filmFSH1operheattimePlus;
	private String filmFSH1operheattimeMinus;
	private String filmRSH1operwaittimeCond;
	private String filmRSH1operwaittimePlus;
	private String filmRSH1operwaittimeMinus;
	private String filmRSH1operheattimeCond;
	private String filmRSH1operheattimePlus;
	private String filmRSH1operheattimeMinus;
	//여기까지 개수 고정 후 사용(50개) 추가되면 Vo 추가 후 Controller도 추가된 만큼 늘려주기(bmsc3050 경로 메인 부분)
	
	
	private String menuAuth;             //메뉴권한 (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
	private String useYnCd;              //사용여부
	private String regId;                //등록자
	private Date regDate;                //등록일
	private String updId;                //수정자
	private Date updDate;                //수정일

	//제조조건관리에서 필요한 컬럼
	private String equipCondSeq;		//설비코드 Seq
	private String goodsCd;				
	private String goodsNm;
	private String pageGubun;			//페이지 구분자  (기초제조조건관리: bmsc3050, 제조조건관리: emsc3030)
	
}