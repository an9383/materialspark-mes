package mes.domain.po;

import lombok.Data;

@Data
public class ProductionPerfTrayVo {
	
	private String menuAuth;				// 메뉴권한
	private String equipCd;					// 설비코드
	private String equipNm;					// 설비코드_NM
	private String workOrdNo;				// 작지번호
	private String lastWorkOrdNo;			// 전작지번호
	private String productDate;				// 생산날짜
	private String dayNightCd;				// 주야구분
	private String trayNo;					// 트레이번호
	private String changeTrayNo;			// 트레이번호(기존에 있던 트레이 번호 수정)
	private int workOrdSeq;					// 작지순서
	private String matrlCd;					// 자재코드
	private String matrlLotNo;				// 자재로트
	private String filmLotNo;				// 부자재로트
	private String lastMatrlLotNo;			// 전자재로트
	private String labelLotNo;				// 라벨로트
	private String labelLotNoSeq;			// 라벨로트시퀀스
	private String productStatus;			// 생산상태
	private String goodsCd;					// 제품코드
	private String goodsNm;					// 제품코드_NM
	private int productQty;					// 생산수량
	private int productAllQty;				// 전체 생산 수량
	private int productPartQty;				// 부분 생산 수량
	private String incorporationGubun;		// 혼입구분
	private String incorporationVisonGubun;	// 혼입비전구분
	private String ordLotNo;				// 생산전표번호
	private String trayWorkerId;			// 작업자 아이디
	private int turnNumber;					// 순번
	private String regId;					// 등록자
	private String regDate;					// 등록일
	private String updId;					// 수정자
	private String updDate;					// 수정일
	private String chooseDateFrom;			
	private String chooseDateTo;			
	
	//추가 항목
	private String qutyNm;
	private String ordDate;
	private String goodsInitial;
	private String boxNo;
	private String factoryCode;
	private String arrayData;
	private String mixGubun;
	private String deleteCheck;
	private String deleteGubun;
	private String createGubun;
	private String matrlGubunNm;
	private String gijongCd;
	private String gijongNm;
	private int deleteGoodsProsuctCheck;
	
	private String outputSubCheck;	//생산실적 Update인지 확인
	
	private String trayNo1;
	private String trayNo2;
	private String trayNo3;
	private String trayNo4;
	private String trayNo5;
	private String trayNo6;
	private String trayRank;
	
	private String workerId;
	private String ordGubun;
	
	private String lgesCode;
	private String lgesGubun;
	private String eveLgesCode;
	private String notTrayNo;
	private String printYn;
	private String trayReprintYn;
	private String cutOrdDate;
	private String labelLotNoCheck;
	private String notLgesCode;
}