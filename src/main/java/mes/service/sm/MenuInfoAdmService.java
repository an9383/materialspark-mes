package mes.service.sm;

import java.util.List;

import mes.domain.sm.MatrlUserVo;
import mes.domain.sm.MenuAuthVo;
import mes.domain.sm.MenuInfoAdmVo;

public interface MenuInfoAdmService {
	//메뉴 목록조회
	public List<MenuInfoAdmVo> listAll(MenuInfoAdmVo menuInfoAdmVo) throws Exception;

	//메뉴 상세조회
	public MenuInfoAdmVo read(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//상위메뉴 조회
	public List<MenuInfoAdmVo> readUpperMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//상위권한 조회
	public List<MenuInfoAdmVo> readUpperAuth_F1F2F3(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
		
	//하위메뉴 조회
	public List<MenuInfoAdmVo> readSubMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//메뉴 등록
	public void create(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//메뉴 수정
	public void update(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//메뉴ID 시퀀스
	public String selectMenuIdSeq() throws Exception;
	
	//하위메뉴 조회
	public List<MenuInfoAdmVo> subMenu(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
	
	//하위권한 조회
	public List<MenuInfoAdmVo> subAuth_F1F2F3(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
		
	//메뉴 불러오기
	public List<MenuInfoAdmVo> menuInfo(MenuAuthVo menuAuthVo) throws Exception;
	
	
	//메인메뉴 목록 순서 변경
	public void menuIndexUpdate(MenuInfoAdmVo menuInfoAdmVo) throws Exception;
}
