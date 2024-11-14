package mes.web.ut;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView {

	public void Download() {
		setContentType("application/download; charset=utf-8");
	}

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		File file = (File) model.get("downloadFile");
		logger.info("DownloadView --> file.getPath() : " + file.getPath());
		logger.info("DownloadView --> file.getName() : " + file.getName());

		if (file != null) {
			String fileName = null;
			String userAgent = request.getHeader("User-Agent");
			logger.info(userAgent);
			logger.info(userAgent.indexOf("Chrome"));

			boolean ie = userAgent.indexOf("MSIE") > -1;

			if (ie) {
				fileName = URLEncoder.encode(file.getName(), "utf-8");
			} else {
				fileName = new String(file.getName().getBytes("UTF-8"), "iso-8859-1");
			}
			//if(userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1){
			//    fileName = URLEncoder.encode(file.getName(), "utf-8").replaceAll("\\+", "%20");;
			//}else if(userAgent.indexOf("Chrome") > -1) {
			//	StringBuffer sb = new StringBuffer();
			//	for(int i=0; i<file.getName().length(); i++) {
			//		char c = file.getName().charAt(i);
			//		if(c > '~') {
			//			sb.append(URLEncoder.encode(""+c, "UTF-8"));
			//		}else {
			//			sb.append(c);
			//		}
			//	}
			//	fileName = sb.toString();
			//}else {
			//	fileName = new String(file.getName().getBytes("utf-8"));
			//}

			logger.info(fileName);
			response.setContentType(getContentType());
			response.setContentLength((int) file.length());
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
			response.setHeader("Content-Transfer-Encoding", "binary");

			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ServletOutputStream so = response.getOutputStream();
			BufferedOutputStream bos = new BufferedOutputStream(so);

			byte[] data = new byte[2048];
			int input = 0;
			while ((input = bis.read(data)) != -1) {
				bos.write(data, 0, input);
				bos.flush();
			}

			if (bos != null)
				bos.close();
			if (bis != null)
				bis.close();
			if (so != null)
				so.close();
			if (fis != null)
				fis.close();

			
			//해당파일 삭제
			File fileDelete = new File(file.getPath());
			logger.info(fileDelete);
			if (fileDelete.exists()) {
	    		if (fileDelete.delete()) {
	    			logger.info("작업지시 파일삭제 성공");
	    		} else {
	    			logger.info("작업지시 파일삭제 실패");
	    		}
	    	} else {
	    		logger.info("작업지시 파일이 존재하지 않습니다.");
	    	}
			
			//OutputStream out = response.getOutputStream();
			//FileInputStream fis = null;
			//try {
			//    fis = new FileInputStream(file);
			//    FileCopyUtils.copy(fis, out);
			//} catch(Exception e){
			//    e.printStackTrace();
			//}finally{
			//    if(fis != null){
			//        try{
			//            fis.close();
			//        }catch(Exception e){
			//        	e.printStackTrace();
			//        }
			//    }
			//    out.flush();
			//}

		}
	}
}
