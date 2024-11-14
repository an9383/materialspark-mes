package mes.domain.po;

import java.util.Date;
import lombok.Data;

@Data
public class EquipSizeCondStepVo {
	
	private String menuAuth;
	private String workOrdNo;                //작업지시번호
	private String ordLotNo;				//생산 LotNo
	private String oldOrdLotNo;				//예전 생산 LotNo
	private String lotNo;                //주자재 lotNo
	private String stepCd;                   //초중물단계코드
	private String equipCd;                  //설비명
	private String regTime;					 //사용자 입력 등록시간
	private String wpLeftAlwnce;             //Welding Park (좌) 공차
	private String wpRightAlwnce;            //Welding Park (우) 공차
	private String pitchLeftAlwnce;          //Pitch (좌) 공차
	private String pitchRightAlwnce;         //Pitch (우) 공차
	private String ppfWingLeftAlwnce;        //P.P Film  날개 (좌) 공차
	private String ppfWingRightAlwnce;       //P.P Film  날개 (우) 공차
	private String ppfDepthLeftAlwnce;       //P.P Film  폭 (좌) 공차
	private String ppfDepthRightAlwnce;      //P.P Film  폭 (우) 공차
	private String filmAlwnce;               //필름 공차
	private String metalDepthAlwnce;         //Metal(폭) 공차
	private String metalThicknessAlwnce;     //Metal(두께) 공차
	private String thCenterAlwnce;           //총두께(Center) 공차
	private String thEdgeAlwncePlus;         //총두께(Edge) 공차
	private String thStepInput;              //총두께 초물,중말,종물 입력
	private String thEdgeCnt;             	 //엣지검사 검사수
	private String thEdgeResult;             //엣지검사 합불판정
	private String burrMetalAlwnce;          //BURR Metal 공차
	private String burrRcutAlwnce;           //BURR R-Cut 공차
	private String burrRedgeAlwnce;          //BURR R끝단 공차
	private String ppfDepthCenterAlwnce;
	private String wpCenterAlwnce;
	private String wpDeviationAlwnce;
	private String x1X2Alwnce;
	private String thEdgeRightAlwnce;
	private String bendingAlwnce;
	private String gapOfLayer;				  //레이어 간격
	private String bulgeLeftupHeight;		//돌기크기 좌상 높이
	private String bulgeLeftdownHeight;		//돌기크기 좌하 높이
	private String bulgeRightupHeight;		//돌기크기 우상 높이
	private String bulgeRightdownHeight;	//돌기크기 우하 높이
	private String bulgeLeftupWidth;		//돌기크기 좌상 너비
	private String bulgeLeftdownWidth;		//돌기크기 좌하 너비
	private String bulgeRightupWidth;		//돌기크기 우상 너비
	private String bulgeRightdownWidth;		//돌기크기 우하 너비
	
	private String regId;                    //등록자
	private Date regDate;                    //등록일
	private String updId;                    //수정자
	private Date updDate;                    //수정일
	
	private double absWp;					//WP 편차
	private double absPpf;					//PP폭 편차
		
	//데이터를 받아서 insert나 update에 사용
	private String firstRegTime;
	private String firstWpLeftAlwnce;
	private String firstWpRightAlwnce;
	private String firstPitchLeftAlwnce;
	private String firstPitchRightAlwnce;
	private String firstPpfWingLeftAlwnce;
	private String firstPpfWingRightAlwnce;
	private String firstPpfDepthLeftAlwnce;
	private String firstPpfDepthRightAlwnce;
	private String firstFilmAlwnce;
	private String firstMetalDepthAlwnce;
	private String firstMetalThicknessAlwnce;
	private String firstThCenterAlwnce;
	private String firstThEdgeAlwncePlus;
	private String firstThStepInput;
	private String firstBurrMetalAlwnce;
	private String firstBurrRcutAlwnce;
	private String firstBurrRedgeAlwnce;
	private String firstBulgeLeftupHeight;
	private String firstBulgeLeftdownHeight;
	private String firstBulgeRightupHeight;
	private String firstBulgeRightdownHeight;
	private String firstBulgeLeftupWidth;
	private String firstBulgeLeftdownWidth;
	private String firstBulgeRightupWidth;
	private String firstBulgeRightdownWidth;
	
	private String secondRegTime;
	private String secondWpLeftAlwnce;
	private String secondWpRightAlwnce;
	private String secondPitchLeftAlwnce;
	private String secondPitchRightAlwnce;
	private String secondPpfWingLeftAlwnce;
	private String secondPpfWingRightAlwnce;
	private String secondPpfDepthLeftAlwnce;
	private String secondPpfDepthRightAlwnce;
	private String secondFilmAlwnce;
	private String secondMetalDepthAlwnce;
	private String secondMetalThicknessAlwnce;
	private String secondThCenterAlwnce;
	private String secondThEdgeAlwncePlus;
	private String secondThStepInput;
	private String secondBurrMetalAlwnce;
	private String secondBurrRcutAlwnce;
	private String secondBurrRedgeAlwnce;
	private String secondBulgeLeftupHeight;
	private String secondBulgeLeftdownHeight;
	private String secondBulgeRightupHeight;
	private String secondBulgeRightdownHeight;
	private String secondBulgeLeftupWidth;
	private String secondBulgeLeftdownWidth;
	private String secondBulgeRightupWidth;
	private String secondBulgeRightdownWidth;
	
	private String thirdRegTime;
	private String thirdWpLeftAlwnce;
	private String thirdWpRightAlwnce;
	private String thirdPitchLeftAlwnce;
	private String thirdPitchRightAlwnce;
	private String thirdPpfWingLeftAlwnce;
	private String thirdPpfWingRightAlwnce;
	private String thirdPpfDepthLeftAlwnce;
	private String thirdPpfDepthRightAlwnce;
	private String thirdFilmAlwnce;
	private String thirdMetalDepthAlwnce;
	private String thirdMetalThicknessAlwnce;
	private String thirdThCenterAlwnce;
	private String thirdThEdgeAlwncePlus;
	private String thirdThStepInput;
	private String thirdBurrMetalAlwnce;
	private String thirdBurrRcutAlwnce;
	private String thirdBurrRedgeAlwnce;
	private String thirdBulgeLeftupHeight;
	private String thirdBulgeLeftdownHeight;
	private String thirdBulgeRightupHeight;
	private String thirdBulgeRightdownHeight;
	private String thirdBulgeLeftupWidth;
	private String thirdBulgeLeftdownWidth;
	private String thirdBulgeRightupWidth;
	private String thirdBulgeRightdownWidth;
	
	private int count;							//초,중,종물 개수
	private String firstStepSearch;
	private String secondStepSearch;
	
	private String lineGubun;
}