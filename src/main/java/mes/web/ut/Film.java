package mes.web.ut;

import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;
import java.io.DataOutputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.LoggerFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lombok.extern.log4j.Log4j;
import mes.web.em.EquipPrdcInspctAdmController;


public class Film{

	private static final Logger logger = LoggerFactory.getLogger(Film.class);
	
	public static void filmPrint(String ip, String portNumber, String matrlInitial, String lotNo, String barcode, String matrlNm, String inspectQty, boolean delayTime){
		
		//String printerHost = "220.90.137.3";
		//int port = 9100;
		
		String printerHost = ip;
	    int port = Integer.parseInt(portNumber);
	    
		// 바코드 로그
		//long time = System.currentTimeMillis();
		//SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		//String str = dayTime.format(new Date(time));
		//logger.error("BarCode : "+barcode+" - "+str);
		// 바코드 로그
	    
	    String s = "{D0220,0995,0195|}\r\n" +  //사이즈
             "{AY;+05,0|}\r\n" +
             "{AX;+000,+000,+00|}\r\n" +
             "{C|}\r\n" +
             "{PV01;0010,0045,0035,0035,01,0,+000,00,B=제품코드:|}\r\n" +  //x시작,y시작,폰트 크기,폰트 크기, 폰트, ?, 회전방향 11,22,33 90도씩
             "{PV01;0155,0050,0040,0040,01,0,+000,00,B=" + matrlInitial + "|}\r\n" +
             "{PV01;0320,0045,0035,0035,01,0,+000,00,B=제품사양:|}\r\n" +
             "{PV01;0465,0050,0045,0045,01,0,+000,00,B=" + matrlNm + "|}\r\n" +
             "{PV01;0010,0100,0035,0035,01,0,+000,00,B=로트번호:|}\r\n" +
             "{PV01;0140,0100,0035,0035,01,0,+000,00,B= " + lotNo + "|}\r\n" +
             "{PV01;0600,0100,0035,0035,01,0,+000,00,B=중량:" + inspectQty + "|}\r\n" +
             "{PV01;0600,0172,0035,0035,01,0,+000,00,B= " + barcode + "|}\r\n" +
             "{XB03;0040,0130,9,3,02,0,0060|}\r\n" +
             "{RB03;" + barcode + "|}\r\n" +
             "\r\n" +
             "{XS;I,0001,0002C4001|}";
		try {
			Socket prtSocket = new Socket(printerHost, port);
			DataOutputStream outToPrt = new DataOutputStream(prtSocket.getOutputStream());
			//System.out.println(s);
			outToPrt.writeUTF(s);
			prtSocket.close();
			//logger.error("delayTime : " + delayTime);
			if (delayTime) {
				Thread.sleep(3500);
			} else {
				Thread.sleep(1000);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
   }
}