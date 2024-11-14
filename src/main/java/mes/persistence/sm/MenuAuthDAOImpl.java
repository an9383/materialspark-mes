package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.AccidentFreeVo;
import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.UserMenuAuthVo;

@Repository
public class MenuAuthDAOImpl implements MenuAuthDAO {
	
	@Inject
	private SqlSession session;
	
	private static final String namespace = "mes.mappers.sm.menuAuthMapper";
	//권한 목록조회
	@Override
	public List<MenuAuthVo> listAll(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".listAll");
	}
	//권한 상세조회
	@Override
	public MenuAuthVo read(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectOne(namespace + ".read", menuAuthVo);
	}
	//특정 부서 전체 조회
	public List<MenuAuthVo> readAll(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".read",menuAuthVo);
	}
	
	//유저권한 전체 조회
	public List<MenuAuthVo> readUserAuthAll_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".readUserAuthAll_F1F2F3",menuAuthVo);
	}
		
	//권한 등록
	@Override
	public void create(MenuAuthVo menuAuthVo) throws Exception{
		session.insert(namespace + ".create", menuAuthVo);
	}
	
	//사용자권한 등록
	@Override
	public void createUserAuth_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		session.insert(namespace + ".createUserAuth_F1F2F3", menuAuthVo);
	}
		
	//권한 수정
	@Override
	public void update(MenuAuthVo menuAuthVo) throws Exception{
		session.update(namespace + ".update", menuAuthVo);
	}
	
	//권한 삭제
	@Override
	public void delete(MenuAuthVo menuAuthVo) throws Exception{
		session.delete(namespace + ".delete", menuAuthVo);
	}
	
	//사용자 전체 조회(목록용)
	public List<MenuAuthVo> userList_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".userList_F1F2F3",menuAuthVo);
	}
		
	//사용자권한 전체 조회(목록용)
	public List<MenuAuthVo> userAuthList_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".userAuthList_F1F2F3",menuAuthVo);
	}
		
	//사용자권한 삭제
	@Override
	public void deleteUserAuth_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		session.delete(namespace + ".deleteUserAuth_F1F2F3", menuAuthVo);
	}
		
	//중복 체크
	@Override
	public MenuAuthVo check(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectOne(namespace + ".check", menuAuthVo);
	}
	
	//메뉴 권한 패스 조회
	@Override
	public String menuAuthPath(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectOne(namespace + ".menuAuthPath", menuAuthVo);
	}		
	
	//user권한 검색
	@Override
	public MenuAuthVo readCheck(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectOne(namespace + ".readCheck", menuAuthVo);
	}
	
	//권한 사용 이력 등록
	@Override
	public void userAuthUseHist_F1F2F3(MenuAuthVo menuAuthVo) throws Exception{
		session.insert(namespace+".userAuthUseHist_F1F2F3", menuAuthVo);
	}
}
