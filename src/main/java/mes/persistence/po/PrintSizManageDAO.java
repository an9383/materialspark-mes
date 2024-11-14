package mes.persistence.po;

import java.util.List;

import mes.domain.po.PrintSizManageVo;
import mes.domain.po.WorkOrderVo;

public interface PrintSizManageDAO {
	
	//프린트사이즈규격 조회
	public List<PrintSizManageVo> printSizManageList(PrintSizManageVo printSizManageVo) throws Exception;
	
	//프린트사이즈규격 읽기
	public PrintSizManageVo printSizManageRead(PrintSizManageVo printSizManageVo) throws Exception;
	
	//프린트사이즈규격 등록
	public void printSizManageCreate(PrintSizManageVo printSizManageVo) throws Exception;
	
	//프린트사이즈규격 수정
	public void printSizManageUpdate(PrintSizManageVo printSizManageVo) throws Exception;
}