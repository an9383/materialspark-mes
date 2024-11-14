package mes.domain.qm;

import java.util.Date;
import lombok.Data;

@Data
public class ReliabilityResultVo {
	
	private String menuAuth;        //메뉴권한
	
	
	//신뢰성 결과
	private String lotNo;			//자재투입LOT
	private String trustGubun;		//(실링=001, 침투액=002, 파괴=003)구분
	private String trustSeq;		//신뢰성 시퀀스
	private String testDate;		//검사일
	private String testDateDN;
	private String data1;			//
	private String data2;			//
	private String data3;			//
	private String data4;			//
	private String data5;			//
	private String data6;			//
	private String data7;			//
	private String data8;			//
	private String data9;			//
	private String data10;			//
	private String trustDesc;		//
	private String regId;			//등록자
	private Date regDate;			//등록일
	private String updId;			//수정자
	private Date updDate;			//수정일
	
	//신뢰성 사진
	private String trustPhotoSeq;
	private String imageFileNm;
	private String imageChangeFileNm;
	private byte[] imageFile;
	private String imageFileSize;
	
	//신뢰성 엑셀파일
	private String shillingResult;
	private String shillingGubun;
	private String addYear;
	private String teamCd;
	private String productDate;
	private String productDateDN;
	private String workerNm;
	private String gijongNm;
	private String qutyNm;
	private String equipNm;
	private String changeM;
	private String metalLotNo;
	private String bottomVal;
	private String bottomResult;
	private String topVal;
	private String topResult;
	private String sideLeft;
	private String sideRight;
	private String afterBottom;
	private String afterTop;
	private String insertList;
	private String deleteList;
	private String dateGubun;
	private String resultNg;
	
	//추가한 값
	private String chooseDateFrom;	//날짜
	private String chooseDateTo;	//날짜
	
	private String arrayData;

}