package mes.domain.em;

import lombok.Data;

@Data
public class AgtSizeStep {

	private String workOrdNo;
	private String workOrdLotNo;
	private String ordLotNo;
	private String lotNo;
	private String stepCd;
	private String equipCd;
	private String goodsCd;
	private String goodsNm;
	private String regDate;			//Date 형식으로 받으면 변환되어서 나오기 때문에 String으로 받을 것.
	private String wpLeftAlwnce;
	private String wpRightAlwnce;
	private String pitchLeftAlwnce;
	private String pitchRightAlwnce;
	private String ppfWingLeftAlwnce;
	private String ppfWingRightAlwnce;
	private String ppfDepthLeftAlwnce;
	private String ppfDepthRightAlwnce;
	private String filmAlwnce;
	private String metalDepthAlwnce;
	private String metalThicknessAlwnce;
	private String thCenterAlwnce;
	private String thEdgeAlwncePlus;
	private String thStepInput;
	private String bulgeLeftupHeight;
	private String bulgeLeftdownHeight;
	private String bulgeRightupHeight;
	private String bulgeRightdownHeight;
	private String bulgeLeftupWidth;
	private String bulgeLeftdownWidth;
	private String bulgeRightupWidth;
	private String bulgeRightdownWidth;
	private String burrMetalAlwnce;
	private String burrRcutAlwnce;
	private String burrRedgeAlwnce;
	
	private double absWp;		//WP 편차
	private double absPpf;		//PP폭 편차
	
}