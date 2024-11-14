package mes.service.io;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import mes.domain.io.MatrlInWhsRqtVo;
import mes.persistence.io.MatrlInWhsRqtDAO;

@Service
public class MatrlInWhsRqtServiceImpl implements MatrlInWhsRqtService{
	
	@Inject
	private MatrlInWhsRqtDAO dao;
	
	//자재입고관리 목록조회
	@Override
	public List<MatrlInWhsRqtVo> listAll(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		return dao.listAll(matrlInWhsRqtVo);
	}

	//자재입고관리 상세조회
	@Override
	public MatrlInWhsRqtVo read(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		return dao.read(matrlInWhsRqtVo);
	}
	
	//자재입고관리 등록
	@Override
	public void create(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		dao.create(matrlInWhsRqtVo);
	}
	
	//자재입고관리 수정
	@Override
	public void update(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		dao.update(matrlInWhsRqtVo);
	}
	
	//시퀀스 생성
	@Override
	public String selectInWhsGroupSeq() throws Exception{
		return dao.selectInWhsGroupSeq();
	}
	
	//바코드 생성
	@Override
	public String barcodeCreate(String time) throws Exception{
		return dao.barcodeCreate(time);
	}
	
	//유효성 검사
	@Override
	public String checkCode(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		return dao.checkCode(matrlInWhsRqtVo);
	}
	
	//seq 갯수 검사
	@Override
	public int groupSeqCount(String seq) throws Exception{
		return dao.groupSeqCount(seq);
	}
	
	//seq별 삭제
	@Override
	public void groupSeqDelete(String seq) throws Exception{
		dao.groupSeqDelete(seq);
	}
	
	
}
