package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class GoodsProductInfoAdmVo {
	
	private String menuAuth;              //메뉴권한
	private String boxNo;
	private String tmpBoxNo;	
	private String goodsCd;
	private String goodsNm;	
	private String ordGubun;
	private String ordGubunNm;
	private int packCnt;
	private String packNumber;
	private int remainCnt;
	private int mergeCnt;
	private String packDate;
	private String locationCd;
	private String locationNm;
	private String goodsInDate;
	private String goodsStatus;
	private String goodsStatusNm;
	private String faultyStatusDate;
	private String faultyStatus;
	private String faultyStatusNm;
	private String faultyDate;
	private String faultyType;
	private String faultyDesc;
	private String faultyDateFrom;
	private String faultyDateTo;
	private String tapTemp;
	private String completeYn;
	private String disposeGubun;
	private String disposeGubunNm;
	private String appointDate;
	
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String histId;			//기록자
	private Date histDate;			//기록일
	private int boxSeq;
	private String ordLotNo;
	private String workOrdNo;		//작업지시 번호
	private String workOrdLotNo;
	private String lotNo;			//주재료 lotNo
	private String gubun;			//생산실적 주야구분
	private int packDtlCnt;
	private int packRemainCnt;
	private String packYn;
	
	private String divisionYn;			//제품분할 여부
	private String divisionYnNm;		//제품분할 여부명
	
	private String printYn;				//최초 프린트 여부
	private String disuseYn;			//제품 폐기 여부
	private String disuseYnNm;			//제품 폐기 여부명
	private String packUnitCd;			//포장단위코드
	private String packUnitNm;			//포장단위명
	
	private String selBoxNo1;			//대상(분할,병합) 포장번호
	private String selBoxNo2;			//대상(변합) 포장번호
	private String mergeYn;				//분할,병합 여부(M:병합, D:분할)
	private String mergeYnNm;	
	private int orignalPackCnt;			//원장 포장수량
	private int divisionPackCnt;		//분할 포장수량
	private String choosePrintLocation;	//분할포장 인쇄 위치 선택
	
	private String chooseDateFrom;
	private String chooseDateTo;
	private int boxNoCnt;				//작지폐기시 폐기수량 예외처리에 사용
	private float sealing1;				//실링1값
	private float sealing2;				//실링2값
	private String filmFaultyCheck;		//필름이상유무
	private String sealingDate;			//실링검사일
	private String mainMatrlList;		//실링검사 입력시 boxNo로 작지번호 찾기
	private String mainMatrl1;			//주자재1
	private String mainMatrl2;			//주자재2
	private String mainMatrl3;			//주자재3
	
	private String boxNoData;
	private String factoryCode;
	
	private String boxNoCount;
	
	private String customerLotNo;
	private String checkLikeCustomerLotNo;
	
	private String poNo;
	
	private String deliveryDate;
	private String dealCorpCd;
	private String dealCorpNm;
	private String labelLotNo;
	private String matrlLotNo;
	private String filmLotNo;
	private String matrlGubunNm;
	private String addPallet;
	private String poGroup;
	private String poSeq;
	private String goodsOutDate;
	private String poModelNo;
	
	private String equipCd;
	private String equipNm;
	
	private String tempBoxNo;
	private int divisionCnt;
	
	private String changeOrdGubun;
	private String gijongCd;
	
	private String noPrintLabelSudel;
	private String locationInputDate;
	
	private String qutyCd;
	private String qutyNm;
}
