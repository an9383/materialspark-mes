package mes.domain.mm;

import lombok.Data;

@Data
public class IndividualOrderAdmVo {

	//발주 ADM
	private String contDtlNo;
	private String poNo;
	private String dealCorpCd;
	private String dealCorpNm;
	private String poDate;
	private String mainChargr;
	private String telNo;
	private String poRegChargr;
	private String poRegChargrNm;
	private String finspectYn;
	private String finspectYnNm;
	private String confirmYn;
	private String confirmYnNm;
	private String receiptGubun;
	private String receiptGubunNm;
	private String useYn;
	private String useYnNm;
	private String poDesc;
	
	//발주 DTL
	private Integer poSeq;
	private String mrpNo;
	private String mrpSeq;
	private String partCd;
	private String partNm;
	private String partRev;
	private String partSpec;
	private String partUnit;
	private String partUnitNm;
	private String inspectYn;
	private String partQty;
	private String safyStockCnt;
	private String addQty;
	private String diffQty;
	private String partUnitCost;
	private String partAmt;
	private String dlvDate;
	private String dlvChangeDate;
	private String poStatus;
	private String poStatusNm;
	private String poEndDate;
	private String barcodeNo;
	private String lotNo;
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;

	private String chooseDateFrom;
	private String chooseDateTo;
	private String today;
	
	private String ordCorpCd;
	private String ordCorpNm;
	private String preInWhsQty; 			//가입고량
	private String preInWhsDate; 			//가입고일
	private String inWhsDate;				//입고일
	private String inWhsQty; 				//입고량
	private String diffCnt; 				//미입고량
	private String unitCost; 				//단가
	
	//발주DTL(발주서 출력 수정)부분 추가
	private String documentSubmitted; 		//제출서류
	private String paymentWay; 				//결제방법
	private String deliveryPlace; 			//납품장소
	private String reference; 				//참조
	private String runDate; 				//시행일자
	private String reception; 				//수신
	private String designation; 			//명칭
	private String title; 					//제목
	private String cooperationDepartment;	//협조부서
	private String purchaseHistory; 		//구매내역
	private String printWhether; 			//출력여부
	private String tmQty; 					//현재고
	private String itemNm;
	private String dtlOrdCnt;
	private String faxNo;
	private String officeCharger;
	
	private String arrayData;
	private String poNoGubun;
	private String searchOption;
	
	private String value;

	private String itemCd;
	private String itemRev;

	private float preOrderQty;
	private float orderQty;
	private float unOrderQty;
	
	private String[] mrpNoArr;	
	private String[] partCdArr;	
	private String maxContDtlNo;	//최대 수주상세번호
	private String minContDtlNo;	//최소 수주상세번호
	private String poStatusOption;	//발주상태 옵션
	
	private String notQty;	//발주상태 옵션
}
