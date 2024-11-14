package mes.domain.tm;

import java.util.Date;
import lombok.Data;

@Data
public class PreGoodsInventoryAdmVo {

	private String menuAuth;              //메뉴권한
	private String invntryNo;
	private String slipNo;
	private int slipSeq;	
	private String goodsCd;
	private String goodsNm;
	private String orderGubun;
	private String orderGubunCd;
	private String orderGubunNm;
	private String ordGubunCd;
	private String ordGubunNm;
	private String model;
	private String modelNo;
	private String customerModelNo;
	private int forwordBoxCnt;
	private int inputBoxCnt;
	private int invntryBoxCnt;
	private int invntryAllCnt;	
	private int outputBoxCnt;
	private int outputAllCnt;
	private int packCnt;
	private String packDate;
	private String goodsInDate;
	private String qutyCd;
	private String qutyNm;
	private String dealCorpCd;
	private String dealCorpNm;
	private String invntryDesc;
	private String outputHistDate;
	private String outputDtlDate;		
	private String lastYn;
	private String inventoryDesc;
	private String regId;
	private Date regDate;
	private String updId;
	private Date updDate;
	private String histId;
	private Date histDate;
	private String faultyStatusDate;
	private String faultyStatus;
	private String faultyStatusNm;
	private String faultyDate;
	private String faultyType;
	private String faultyDesc;
	private String packUnitCd;
	private String packUnitNm;
	private String workOrdNo;
	
	private String boxNo;			//박스번호 Dtl에서 사용
	private int remainCnt;			//출고 후 남은수량 Dtl에서 사용
	private int userOutputCnt;		//사용자 입력 출고수량
	private String goodsStatus;     //제품상태 Dtl에서 사용
	private String goodsStatusNm;	//제품상태 Dtl에서 사용
	
	private int boxPlus;			//초기재고 Box 추가 생성
	private String boxMinus;		//초기재고 삭제할 BoxNo
	private String gravity;
	private String goodsFifoCheckCd;
	private String goodsFifoCheckNm;
	
	private int goodsFifoCount;			//생산제품 선입선출해야 할 개수
	private String exceptBoxNo;
	
	private String lifeTime;
	private String surfaceDate;
	private String data1;
	private String data2;
	private String motherRollLot;
	private String motherRollLotNo;
	private String standard;
	private String rollCount;
	private String customerLotNo;
}