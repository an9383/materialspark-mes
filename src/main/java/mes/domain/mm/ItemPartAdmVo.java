package mes.domain.mm;

import lombok.Data;

@Data
public class ItemPartAdmVo {

	private String partCd;			//부품코드
	private String partNm;			//부품명
	private String partRev;			//리비전
	private String partGubun;		//부붐구분
	private String partType;		//부붐타입
	private String partTypeNm;		//부붐타입명
	private String partGubunNm;		//부품구분명
	private String partSpec;		//부품스펙
	private String inCorpCd;		//입고처
	private String inCorpNm;		//입고처명
	private String partUnit;		//부품단위
	private String partUnitNm;		//부품단위명
	private String tmQty;			//재고량
	private String basicDlvDate;	//기본납기일
	private Integer unitCost;		//자재단가
	private Integer standCost;		//표준단가
	private String safetyStockQty;	//안전재고량
	private String barcodeYn;		//바코드관리 여부
	private String useYn;			//사용여부
	private String useYnNm;			//사용여부
	private String partDesc;		//비고	
	private String regId;			//등록자
	private String regNm;			//등록자명
	private String regDate;			//등록일
	private String updId;			//수정자
	private String updDate;			//수정일
	
	private Integer partSeq;        //시퀀스
	private String fileNm;			//파일명
	private String inspectDate;		//일자
	private String contents;		//일자
	private String inspectYn;		//수입검사여부
	
	private String url;
	
	private int start;
	private int length;
	private int totalCount;	
	private String searchVal;
	private String ordDir;
	private String ordColumn;
	
	private String rethinkQty;		//재고수량
	private String lackQty;			//부족수량


}
