package mes.domain.pd;

import java.util.Date;
import lombok.Data;

@Data
public class GoodsProductInfoAdmVo {
	
	private String menuAuth;
	private String boxNo;           //포장번호
	private String goodsCd;         //제품코드
	private String ordGubun;        //오더구분
	private String ordGubunNm;        //오더구분명
	private String packCnt;         //포장수량
	private String packDate;        //포장일자
	private String locationCd;      //Location
	private String goodsInDate;     //제품입고일
	//private String goodsOutDate;	//제품출고일
	private String goodsStatus;     //제품상태
	private String goodsStatusNm;     //제품상태명
	private String disuseYn;		//제품 폐기 여부
	private String disuseYnNm;		//제품 폐기 여부명
	private String completeYn;
	private String regId;           //등록자
	private Date regDate;			//등록일
	private String updId;           //수정자
	private Date updDate;			//수정일
	private String histId;          //기록자
	private Date histDate;			//기록일
	private String divisionYn;		//분할&병합 여부
	private String divisionYnNm;	//분할&병합 명
	private String faultyStatusDate;
	private String faultyStatus;	//제품상태코드
	private String faultyStatusNm;	//제품상태명
	private String faultyDate;
	private String faultyType;
	private String faultyDesc;
	private String tapTemp;			//입출고관리-검사&부적합 제품현황 탭 판별
	private String mergeYn;
	private String mergeYnNm;
	
	private String disposeGubun;
	private String disposeGubunNm;
	private String appointDate;
	
	private String modelNo;
	private String boxNoOld;		//switching 불량 boxNo
	private int remainCntOld;	//switching	불량 출하수량
	
	private String poNoSeq;
	/* join시 사용 */
	private String goodsNm;			//제품명
	private String locationNm;		//저장 창고명
	private String chooseDate;		//조회시 선택 날짜
	private String chooseDateTo;		//조회시 선택 날짜
	private String chooseDateFrom;		//조회시 선택 날짜
	private String restock;			//제품입고시 재입고 가능여부
	
	private int remainCnt;		//출고 후 남은 수량
	private int userOutputCnt;	//사용자 입력 출고수량
	private String workOrdNo;
	private String ordLotNo;
	private float sealing1;				//실링1값
	private float sealing2;				//실링2값
	private String filmFaultyCheck;		//필름이상유무
	private String sealingDate;			//실링검사일
	private String goodsFifoCheckCd;	//생산제품 선입선출 적용여부
	private String goodsFifoCheckNm;	//생산제품 선입선출 적용여부명
	private int goodsFifoCount;			//생산제품 선입선출해야 할 개수
	private String exceptBoxNo;
	
	private String customerLotNo;
	private String matrlLotNo;
	private String filmLotNo;
	private String addPallet;
	private String poGroup;
	private String poSeq;
	private String goodsOutDate;
	private String poModelNo;
	
	private String equipCd;
	private String equipNm;
	private String locationInputDate;
	
	private String inWhsDate;

	private String qutyCd;
	private String qutyNm;
}