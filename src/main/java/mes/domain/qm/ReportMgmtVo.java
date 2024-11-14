package mes.domain.qm;

import java.util.Date;

import lombok.Data;

@Data
public class ReportMgmtVo {
	
	private String idx;    	  				//인덱스
	private String qutyCd;    		 	   	//재질
	private String qutyNm;    		 	   	//
	private String gubunCd;    	  	 	 	//구분(연질/경질)
	private String gubunNm;    	  	 	 	//
	private String buyDealCorpCd;    	    //매입업체
	private String buyDealCorpNm;
	private String validDate;				//유효기간
	private String documentSeq;    	    	//문서관련 시퀀스  
	private String documentTitle;    	    //문서제목      
	private String documentContents;		//문서 내용
	private String tabGubunCd;				//탭 구분
	private String userAdd;					//등록자(사용자 추가)
	private String userAddNm;				
	private String regId;                	//등록자
	private String regNm;                	//
	private Date regDate;                	//등록일
	private String updId;                	//수정자
	private Date updDate;               	//수정일
	private String chooseDateFrom;
	private String chooseDateTo;
	
	//추가항목
	private String arrayData;
	private String tableCount;
	private String startDate;
	private String endDate;
	

}