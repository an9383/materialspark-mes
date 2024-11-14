package mes.web.ut;
import java.io.DataOutputStream;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import org.springframework.web.bind.annotation.ResponseBody;

import mes.domain.po.GoodsProductInfoAdmVo;

public class MtpLabel{
	
	public static @ResponseBody Map<String, Object> barCodePrint(String ip, String portNumber, GoodsProductInfoAdmVo goodsProductInfoAdmVo, String ordLotNo1, String ordLotNo2, String ordLotNo3
																, float stepAverage, String packUnitNm, String workOrdCnt)						{
		
		Map<String, Object> jsonData = new HashMap<String, Object>();
		
		//String printerHost = "220.90.137.3";
		//int port = 9100;
		
		if (workOrdCnt == null) {
			workOrdCnt = "";
		}
		String printerHost = ip;
	    int port = Integer.parseInt(portNumber);
	    String image="";
	    String image2="";
	    
	    String matrlNm = "";
	    String matrlNmLocation = "";
	    String descLocation = "";
	    String desc = "";
	    
		//자재명 판단  	  	
  	  	if (goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("A")){
  	  		desc = "Cathode Tab";
  	  		descLocation = "0760,0375";
  	  		matrlNm = "Al";
  	  		matrlNmLocation = "0830,0425";
  	  	} else if (goodsProductInfoAdmVo.getGoodsCd().substring(0,1).equals("N")){
  	  		desc = "Anode Tab"; 
  	  		descLocation = "0775,0375";
  	  		matrlNm = "NiCu";
  	  		matrlNmLocation = "0805,0415";
  	  	}

		if (goodsProductInfoAdmVo.getGoodsNm().contains("DE/SK")) {
			//image = "{XQ;01,0,L|}\r\n";
			image2 = "{XQ;02,0,L|}\r\n";
		}
		//HE370 안에 E370이 포함되어 있기때문에 HE370인지 먼저 판단해야함.
		else if (goodsProductInfoAdmVo.getGoodsNm().contains("HE370")) {
			//image = "{XQ;97,0,L|}\r\n";
			image2 = "{XQ;98,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("E370")) {
			//image = "{XQ;03,0,L|}\r\n";
			image2 = "{XQ;04,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("H200")) {
			//image = "{XQ;09,0,L|}\r\n";
			image2 = "{XQ;10,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("P260")) {
			//image = "{XQ;11,0,L|}\r\n";
			image2 = "{XQ;12,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("P395")) {
			//image = "{XQ;13,0,L|}\r\n";
			image2 = "{XQ;14,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("E556")) {
			//image = "{XQ;15,0,L|}\r\n";
			image2 = "{XQ;16,0,L|}\r\n";
		} else if (goodsProductInfoAdmVo.getGoodsNm().contains("N60")) {
			//image = "{XQ;17,0,L|}\r\n";
			image2 = "{XQ;18,0,L|}\r\n";
		} else {
			//image = "{XQ;97,0,L|}\r\n";
			image2 = "{XQ;98,0,L|}\r\n";
		}
	   
	    //System.out.println("descLocation : " + descLocation + ", desc :" +desc + ", matrlNmLocation :" + matrlNmLocation + ", matrlNm :" + matrlNm);
	    String s  = "{D1040,1000,0500|}\r\n" //인쇄시작 사이즈(외관 포함) - 총 너비(여백포함), 인쇄지 너비, 인쇄지 세로
				+ "{AY;+05,0|}\r\n"
				+ "{AX;+000,+000,+00|}\r\n"
				+ "{C|}\r\n"
				//+ image + ""		// 위치-X:710 Y:135 이미지 크기(X:230px Y:68px)
				+ image2 + ""		// 위치-X:455 Y:230 이미지크기 (X:208px Y:208px)
				+ "{LC;0035,0035,1000,0480,1,6|}\r\n"	//라인두께 5로 네모를 그린다."
				+ "{LC;0035,0220,1000,0220,0,6|}\r\n"	//가로 긴 줄
				+ "{LC;0715,0270,1000,0270,0,6|}\r\n"	//APPROVED 밑에 가로 줄
				+ "{LC;0711,0035,0711,0480,0,4|}\r\n"	//세로줄
				+ "{PV01;0050,0070,0040,0040,01,0,+000,00,B=SPECIFICATION|}\r\n"
				+ "{PV02;0080,0150,0060,0060,01,0,+000,00,B=0□ 1□ 2□ 3□ 초□|}\r\n"
				+ "{PV13;0045,0210,0040,0040,01,0,+000,00,B=제품정보 : " + goodsProductInfoAdmVo.getGoodsNm() + "(" + packUnitNm + ") |}\r\n "
				+ "{PV11;0045,0260,0040,0040,01,0,+000,00,B=LOT NO - |}\r\n"
				+ "{PV11;0045,0300,0035,0040,01,0,+000,00,B=" + ordLotNo1 + " |}\r\n"
				+ "{PV11;0045,0340,0035,0040,01,0,+000,00,B=" + ordLotNo2 + " |}\r\n"
				+ "{PV11;0045,0380,0035,0040,01,0,+000,00,B=" + ordLotNo3 + " |}\r\n"
				+ "{PV12;0045,0425,0035,0040,01,0,+000,00,B=BOX NO : " + goodsProductInfoAdmVo.getBoxNo() +  "|}\r\n"
				+ "{PV13;0045,0470,0040,0040,01,0,+000,00,B=TYPE : " + goodsProductInfoAdmVo.getOrdGubunNm() + " |}\r\n "
				+ "{PV22;0738,0260,0050,0040,01,0,+000,00,B=APPROVED|}\r\n"
				+ "{PV22;0720,0310,0050,0040,01,0,+000,00,B=" + stepAverage + "|}\r\n"
				+ "{PV22;0740,0455,0080,0080,01,0,+000,00,B=" + workOrdCnt + "|}\r\n"
				+ "{PV23;" + descLocation + ",0035,0035,01,0,+000,00,B=" + desc + "|}\r\n"
				+ "{PV24;" + matrlNmLocation + ",0040,0040,01,0,+000,00,B=(" + matrlNm + ")|}\r\n"
				
				+ "{PV24;0730,0155,0065,0050,01,0,+000,00,B=" + goodsProductInfoAdmVo.getBoxNo().substring(0, 8) + "|}\r\n"
				+ "{PV24;0770,0210,0065,0050,01,0,+000,00,B=" + goodsProductInfoAdmVo.getBoxNo().substring(8, 13) + "|}\r\n"
				//+ "{PV25;0900,0310,0050,0050,02,0,+000,00,B=" + "↓test" + "|}\r\n"
				
				+ "{XB03;0775,0050,9,3,01,0,0060|}\r\n"	//바코드 설정 9:128	XB03;x좌표,y좌표,바코드종류(9는 128),?,바코드 폰트큭기,?,바코드 높이)
				+ "{RB03;" + goodsProductInfoAdmVo.getBoxNo() + "|}\r\n"	//바코드 출력
				+ "{XS;I,0001,0002C4001|}\r\n";
	    
       //String s = "{D0720,1010,0700|}\r\n" +  //사이즈
       //      "{AY;+04,0|}\r\n" + 
       //      "{AX;-020,+000,+00|}\r\n" + 
       //      //"{AX;-020,+000,+00|}\r\n" + 
       //      "{C|}\r\n" + 
       //      "" + 
       //      image + "" +      //이미지    x 700 y 120 가로 230px 세로 68px
       //      image2 + "" +      //이미지    x 427 y 330 가로 208px 세로 208px
       //      "{LC;0015,0035,1000,0585,1,5|}\r\n" +  //라인두께 5로 네모를 그린다.
       //      "{LC;0015,0210,1000,0210,0,2|}\r\n" + 
       //      "{LC;0690,0260,1000,0260,0,2|}\r\n" +
       //      "" +             
       //      "{LC;0690,0035,0690,0585,0,2|}\r\n" +  //세로줄
       //      "" + 
       //      "{PV01;0030,0070,0040,0040,01,0,+000,00,B=SPECIFICATION|}\r\n" + 
       //      "" + 
       //      "{PV11;0025,0300,0040,0040,01,0,+000,00,B=LOT NO : -|}\r\n" + 
       //      "{PV12;0025,0415,0040,0040,01,0,+000,00,B=BOX NO :|}\r\n" + 
       //      "{PV12;0215,0415,0030,0040,01,0,+000,00,B=" + boxNo + "|}\r\n" + 
       //      "{PV13;0025,0525,0040,0040,01,0,+000,00,B=TYPE   : " + ordGubun + "|}\r\n" +            
       //      "" +
       //      "{PV22;0725,0250,0050,0040,01,0,+000,00,B=APPROVED|}\r\n" + 
       //      "{PV23;0740,0415,0035,0035,01,0,+000,0"
       //      + "0,B=Cathode Tab|}\r\n" + 
       //      "{PV24;0825,0465,0040,0040,01,0,+000,00,B=(Al)|}\r\n" +
       //      "" +
       //      "{PV24;0740,00105,0030,0030,01,0,+000,00,B="+boxNo+"|}\r\n" +
       //      "{XB03;0755,0045,9,3,01,0,0030|}\r\n" + 
       //      "{RB03;"+boxNo+"|}\r\n" +           
       //      "" + 
       //      "{XS;I,0001,0002C4001|}\r\n";
    
       try {
          Socket prtSocket = new Socket(printerHost, port);
          DataOutputStream outToPrt = new DataOutputStream(prtSocket.getOutputStream());
          outToPrt.writeUTF(s);
          prtSocket.close();
          jsonData.put("printResult", "printSuccess");
          Thread.sleep(1000);
          
       }catch(Exception e) {
          e.printStackTrace();
          jsonData.put("printResult", "printFail");
       }
       
       return jsonData;
   }
}