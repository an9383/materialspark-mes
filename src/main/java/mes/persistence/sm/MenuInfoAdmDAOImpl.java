package mes.persistence.sm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoAdmVo;
import mes.domain.sm.UserMenuAuthVo;

@Repository
public class MenuInfoAdmDAOImpl implements MenuInfoAdmDAO {
	
	@Inject
	private SqlSession session;
	
	
	private static final String namespace = "mes.mappers.sm.menuInfoAdmMapper";
	//메뉴 목록조회
	@Override
	public List<MenuInfoAdmVo> listAll(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".listAll");
	}

	//메뉴 상세조회
	@Override
	public MenuInfoAdmVo read(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectOne(namespace + ".read", menuInfoAdmVo);
	}
	
	//상위메뉴 조회
	@Override
	public List<MenuInfoAdmVo> readUpperMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".readUpperMenu", menuInfoAdmVo);
	}
	
	//상위권한 조회
	@Override
	public List<MenuInfoAdmVo> readUpperAuth_F1F2F3(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".readUpperAuth_F1F2F3", menuInfoAdmVo);
	}
	
	//상위메뉴의 하위메뉴 조회
	@Override
	public List<MenuInfoAdmVo> readSubMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".readSubMenu", menuInfoAdmVo);
	}
	
	//메뉴 등록
	@Override
	public void create(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		session.insert(namespace + ".create",menuInfoAdmVo);
	}
	
	//메뉴 수정
	@Override
	public void update(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		session.update(namespace + ".update",menuInfoAdmVo);
	}

	//메뉴ID 시퀀스
	@Override
	public String selectMenuIdSeq() throws Exception{
		return session.selectOne(namespace + ".selectMenuIdSeq");
	}
	
	//하위메뉴 전체 조회
	@Override
	public List<MenuInfoAdmVo> subMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".subMenu", menuInfoAdmVo);
	}
	
	//하위권한 전체 조회
	@Override
	public List<MenuInfoAdmVo> subAuth_F1F2F3(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		return session.selectList(namespace + ".subAuth_F1F2F3", menuInfoAdmVo);
	}
	
	//메뉴 불러오기
	@Override
	public List<MenuInfoAdmVo> menuInfo(MenuAuthVo menuAuthVo) throws Exception{
		return session.selectList(namespace + ".menuInfo", menuAuthVo);
	}
	
	
	//메인메뉴 목록 순서 변경
	@Override
	public void menuIndexUpdate(MenuInfoAdmVo menuInfoAdmVo) throws Exception{
		session.update(namespace + ".menuIndexUpdate",menuInfoAdmVo);
	}
	
}
