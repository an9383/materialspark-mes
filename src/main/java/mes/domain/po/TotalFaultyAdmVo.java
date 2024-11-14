package mes.domain.po;

import lombok.Data;

@Data
public class TotalFaultyAdmVo {
	
	private String menuAuth;
	private String equipCd;			//설비코드
	private String workOrdNo;
	private String lotNo;			//주자재LotNo
	private String faultyRegDate;	//불량등록일
	private String dayNightCd;		//주야간구분
	private String gubun;
	
	private int dayTotalPrcssCount;
	private int nightTotalPrcssCount;
	private int dayTotalMatrlCount;
	private int nightTotalMatrlCount;
	private int dayTotalReplaceCount;
	private int nightTotalReplaceCount;
	private int dayTotalTroubleCount;
	private int nightTotalTroubleCount;
	
	private int totalPrcssCount;
	private int totalMatrlCount;
	private int totalReplaceCount;
	private int totalTroubleCount;

	private float dayTotalPrcssSum;
	private float nightTotalPrcssSum;
	private float dayTotalMatrlSum;
	private float nightTotalMatrlSum;
	private float dayTotalReplaceSum;
	private float nightTotalReplaceSum;
	private float dayTotalTroubleSum;
	private float nightTotalTroubleSum;

	private float totalPrcssSum;
	private float totalMatrlSum;
	private float totalReplaceSum;
	private float totalTroubleSum;
	
	private int dayTotal114Count;
	private int nightTotal114Count;
	private int total114_count;
	
	private int dayTotal115Count;
	private int nightTotal115Count;
	private int total115Count;
	private int dayTotal116Count;
	private int nightTotal116Count;
	private int total116Count;
	
	private float dayTotal114Sum;
	private float nightTotal114Sum;
	private float total114Sum;
	private float dayTotal115Sum;
	private float nightTotal115Sum;
	private float total115Sum;
	private float dayTotal116Sum;
	private float nightTotal116Sum;
	private float total116Sum;
	
}