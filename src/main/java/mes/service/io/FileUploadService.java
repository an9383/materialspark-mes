package mes.service.io;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {

	public String restore(MultipartFile multipartFile, Logger logger, String matrlUploadDir) {
		String url = null;

		try {
			// 파일 정보
			String originFilename = multipartFile.getOriginalFilename();
			String extName = originFilename;
			Long size = multipartFile.getSize();
			String path = matrlUploadDir;
			// 서버에서 저장 할 파일 이름
			String saveFileName = genSaveFileName(extName);
			logger.info("originFilename : " + originFilename);
			logger.info("extensionName : " + extName);
			logger.info("size : " + size);
			logger.info("saveFileName : " + saveFileName);
			logger.info("path : " + path);
			File Folder = new File(path);

			if (!Folder.exists()) {
				try {
					Folder.mkdirs(); //폴더 생성합니다.
					logger.info("폴더가 생성되었습니다.");
				} catch (Exception e) {
					e.getStackTrace();
				}
			} else {
				logger.info("이미 폴더가 생성되어 있습니다.");
			}

			writeFile(multipartFile, saveFileName, logger, matrlUploadDir);
			url = path + "/" + saveFileName;
		} catch (IOException e) {
			// 원래라면 RuntimeException 을 상속받은 예외가 처리되어야 하지만
			// 편의상 RuntimeException을 던진다.
			// throw new FileUploadException();	
			throw new RuntimeException(e);
		}

		return url;
	}

	//현재 시간을 기준으로 파일 이름 생성
	private String genSaveFileName(String extName) {
		String fileName = "";
		TimeZone tz = TimeZone.getTimeZone("Asia/Seoul");
		Calendar calendar = Calendar.getInstance(tz);
		fileName += calendar.get(Calendar.YEAR);
		fileName += calendar.get(Calendar.MONTH) + 1;
		fileName += calendar.get(Calendar.DATE);
		fileName += calendar.get(Calendar.HOUR);
		fileName += calendar.get(Calendar.MINUTE);
		fileName += calendar.get(Calendar.SECOND);
		fileName += "_";

		fileName += extName;

		return fileName;
	}

	//파일을 실제로 write 하는 메서드
	private boolean writeFile(MultipartFile multipartFile, String saveFileName, Logger logger, String matrlUploadDir) throws IOException {
		boolean result = false;
		String path = matrlUploadDir;
		byte[] data = multipartFile.getBytes();

		logger.info("writeFile path ===> " + path);

		FileOutputStream fos = new FileOutputStream(path + "/" + saveFileName);
		logger.info("data ==> " + data);
		fos.write(data);
		fos.close();

		return result;
	}
}