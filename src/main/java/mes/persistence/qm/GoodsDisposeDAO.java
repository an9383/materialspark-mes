package mes.persistence.qm;

import java.util.List;

import mes.domain.qm.GoodsDisposeVo;


public interface GoodsDisposeDAO {
	
	//폐기리스트 조회
	public List<GoodsDisposeVo> list(GoodsDisposeVo goodsDisposeVo) throws Exception;	
	
	//폐기리스트 adm 조회
	public List<GoodsDisposeVo> readAdm(GoodsDisposeVo goodsDisposeVo) throws Exception;
	
	//폐기리스트 dtl 조회
	public List<GoodsDisposeVo> readDtl(GoodsDisposeVo goodsDisposeVo) throws Exception;	
	
	//이상발생번호 채번
	public String selectNoSeq(GoodsDisposeVo goodsDisposeVo) throws Exception;
	
	//이상발생내용 누적횟수		
	public String selectAccCnt(GoodsDisposeVo goodsDisposeVo) throws Exception;	

	//폐기리스트 adm 생성
	public void createAdm(GoodsDisposeVo goodsDisposeVo) throws Exception;
	
	//폐기리스트 dtl 생성
	public void createDtl(GoodsDisposeVo goodsDisposeVo) throws Exception;
	
	//폐기리스트 adm 삭제
	public void deleteAdm(GoodsDisposeVo goodsDisposeVo) throws Exception;
	
	//폐기리스트 dtl 삭제
	public void deleteDtl(GoodsDisposeVo goodsDisposeVo) throws Exception;	
	
	//폐기리스트 dtl 폐기구분자 수정
	public void updateDisposeGubun(GoodsDisposeVo goodsDisposeVo) throws Exception;	
	
	

	
}