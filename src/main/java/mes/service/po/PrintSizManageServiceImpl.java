
package mes.service.po;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.po.PrintSizManageVo;
import mes.persistence.po.PrintSizManageDAO;


@Service
public class PrintSizManageServiceImpl implements PrintSizManageService {
	@Inject
	private PrintSizManageDAO dao;
	
	//프린트사이즈규격 조회
	@Override
	public List<PrintSizManageVo> printSizManageList(PrintSizManageVo printSizManageVo) throws Exception{
		return dao.printSizManageList(printSizManageVo);
	}
	
	//프린트사이즈규격 읽기
	@Override
	public PrintSizManageVo printSizManageRead(PrintSizManageVo printSizManageVo) throws Exception{
		return dao.printSizManageRead(printSizManageVo);
	}
	
	//프린트사이즈규격 등록
	@Override
	public void printSizManageCreate(PrintSizManageVo printSizManageVo) throws Exception{
		dao.printSizManageCreate(printSizManageVo);
	}
	
	//프린트사이즈규격 수정
	@Override
	public void printSizManageUpdate(PrintSizManageVo printSizManageVo) throws Exception {
		dao.printSizManageUpdate(printSizManageVo);
	}
}