package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.GoodsDisposeVo;
import mes.persistence.qm.GoodsDisposeDAO;

@Service
public class GoodsDisposeServiceImpl implements GoodsDisposeService {

	@Inject
	private GoodsDisposeDAO dao;

	//폐기리스트 조회
	@Override
	public List<GoodsDisposeVo> list(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return dao.list(goodsDisposeVo);
	}
	
	//폐기리스트 adm 조회
	@Override
	public List<GoodsDisposeVo> readAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return dao.readAdm(goodsDisposeVo);
	}
	
	//폐기리스트 dtl 조회
	@Override
	public List<GoodsDisposeVo> readDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return dao.readDtl(goodsDisposeVo);
	}
	
	//이상발생번호 채번
	@Override
	public String selectNoSeq(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return dao.selectNoSeq(goodsDisposeVo);
	}
	
	//이상발생내용 누적횟수
	@Override
	public String selectAccCnt(GoodsDisposeVo goodsDisposeVo) throws Exception{
		return dao.selectAccCnt(goodsDisposeVo);
	}

	//폐기리스트 adm 생성
	@Override
	public void createAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		dao.createAdm(goodsDisposeVo);
	}
	
	//폐기리스트 dtl 생성
	@Override
	public void createDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		dao.createDtl(goodsDisposeVo);
	}
	
	//폐기리스트 adm 삭제
	@Override
	public void deleteAdm(GoodsDisposeVo goodsDisposeVo) throws Exception{
		dao.deleteAdm(goodsDisposeVo);
	}
	
	//폐기리스트 dtl 삭제
	@Override
	public void deleteDtl(GoodsDisposeVo goodsDisposeVo) throws Exception{
		dao.deleteDtl(goodsDisposeVo);
	}
	
	//폐기리스트 dtl 폐기구분자 수정
	@Override
	public void updateDisposeGubun(GoodsDisposeVo goodsDisposeVo) throws Exception{
		dao.updateDisposeGubun(goodsDisposeVo);
	}

	
}