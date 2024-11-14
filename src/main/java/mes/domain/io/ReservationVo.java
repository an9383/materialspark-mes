package mes.domain.io;

import lombok.Data;

@Data
public class ReservationVo {

	private String menuAuth;              //메뉴권한	
	private String lotNo;
	private String barCodeNo;
	private String thicknessQty;
	
	private String regId;
	private String regDate;
	private String updId;
	private String updDate;

}
