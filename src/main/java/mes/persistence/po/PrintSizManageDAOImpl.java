package mes.persistence.po;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.po.PrintSizManageVo;

@Repository
public class PrintSizManageDAOImpl implements PrintSizManageDAO{
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.po.printSizManageMapper";
	

	//프린트사이즈규격 조회
	@Override
	public List<PrintSizManageVo> printSizManageList(PrintSizManageVo printSizManageVo) throws Exception{
		return session.selectList(namespace + ".printSizManageList", printSizManageVo);
	}
	
	//프린트사이즈규격 읽기
	@Override
	public PrintSizManageVo printSizManageRead(PrintSizManageVo printSizManageVo) throws Exception{
		return session.selectOne(namespace + ".printSizManageRead", printSizManageVo);
	}

	//프린트사이즈규격 등록
	@Override
	public void printSizManageCreate(PrintSizManageVo printSizManageVo) throws Exception{
		session.insert(namespace + ".printSizManageCreate", printSizManageVo);
	}
	
	//프린트사이즈규격 수정
	@Override
	public void printSizManageUpdate(PrintSizManageVo printSizManageVo) throws Exception {
		session.update(namespace + ".printSizManageUpdate", printSizManageVo);
	}


	
	


	
}