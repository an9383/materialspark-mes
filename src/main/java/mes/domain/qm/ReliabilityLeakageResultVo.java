package mes.domain.qm;

import java.util.Date;
import lombok.Data;

@Data
public class ReliabilityLeakageResultVo {
	
	private String menuAuth;        //메뉴권한
	
	//Leakage Test 결과
	private String testDate;	//생산일
	private int testSeq;	//순번
	private String equipNm;			//설비명
	private String gubunDay;		//주간
	private String day_0_1;			//주간D0/D1
	private String gubunNight;		//야간
	private String night_0_1;		//야간D0/D1
	private String regId;			//등록자
	private String regDate;			//등록일
	private String updId;			//수정자
	private Date updDate;			//수정일
	
	private int regSeq;
	
	private String chooseDateFrom;	//날짜
	private String chooseDateTo;	//날짜
	
	private String userNm;
	private String leakDstryGubun;
	
	private String leakDstryFileNo;
	private String admRegDate;
	private String fileSeq;
	private String fileName;
	private String filePath;
	private String leakDstryDesc;
	private String fileOriginName;
}