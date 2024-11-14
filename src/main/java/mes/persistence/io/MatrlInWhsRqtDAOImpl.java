package mes.persistence.io;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.io.MatrlInWhsRqtVo;

@Repository
public class MatrlInWhsRqtDAOImpl implements MatrlInWhsRqtDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.io.matrlInWhsRqtMapper";
	
	 //자재입고관리 목록조회
	@Override
	public List<MatrlInWhsRqtVo> listAll(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{		
		return session.selectList(namespace + ".listAll");
	}

	//자재입고관리 상세조회
	@Override
	public MatrlInWhsRqtVo read(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{		
		return session.selectOne(namespace + ".read", matrlInWhsRqtVo);
	}
	
	//자재입고관리 등록
	@Override
	public void create(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{		
		session.insert(namespace + ".create", matrlInWhsRqtVo);
	}
	
	//자재입고관리 수정
	@Override
	public void update(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{		
		session.update(namespace + ".update", matrlInWhsRqtVo);
	}
	
	@Override
	public String selectInWhsGroupSeq() throws Exception{
		return session.selectOne(namespace + ".selectInWhsGroupSeq");
	}
	
	//바코드 생성
	@Override
	public String barcodeCreate(String time) throws Exception{
		return session.selectOne(namespace + ".barcodeCreate", time);
	}
	
	//유효성 검사
	@Override
	public String checkCode(MatrlInWhsRqtVo matrlInWhsRqtVo) throws Exception{
		return session.selectOne(namespace + ".checkCode", matrlInWhsRqtVo);
	}
	
	//seq 갯수 검사
	@Override
	public int groupSeqCount(String seq) throws Exception{
		return session.selectOne(namespace + ".groupSeqCount", seq);
	}
	
	//seq별 삭제
	@Override
	public void groupSeqDelete(String seq) throws Exception{
		session.delete(namespace + ".groupSeqDelete",seq);
	}

}
