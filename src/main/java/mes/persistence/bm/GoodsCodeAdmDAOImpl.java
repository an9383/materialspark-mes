package mes.persistence.bm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.bm.GoodsCodeAdmVo;


@Repository
public class GoodsCodeAdmDAOImpl implements GoodsCodeAdmDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "mes.mappers.bm.goodsCodeAdmMapper";
	
	//제품코드 목록조회
	@Override
	public List<GoodsCodeAdmVo> listAll(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return session.selectList(namespace+".listAll", goodsCodeAdmVo);
	}
	
	//제품코드 목록조회
	@Override
	public List<GoodsCodeAdmVo> listAll2(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return session.selectList(namespace+".listAll2", goodsCodeAdmVo);
	}

	//제품코드 상세조회
	@Override
	public GoodsCodeAdmVo read(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return session.selectOne(namespace+".read", goodsCodeAdmVo);
	}
	
	//제품코드 등록
	@Override
	public void create(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		session.insert(namespace+".create", goodsCodeAdmVo);
	}
	
	//제품코드 수정
	@Override
	public void update(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		session.update(namespace+".update", goodsCodeAdmVo);
	}
	
	//제품코드 제품시퀀스코드
	@Override
	public String selectGoodsSeqCd() throws Exception {
		return session.selectOne(namespace+".selectGoodsSeqCd");
	}
	
	//제품 새로 등록 시 모델NO 중복검사
	@Override
	public GoodsCodeAdmVo searchModelNo(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception {
		return session.selectOne(namespace+".searchModelNo", goodsCodeAdmVo);
	}
	
	//월별 FP 잡체인지 제품 모달
	@Override
	public List<GoodsCodeAdmVo> jobChangeGoodsModal(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return session.selectList(namespace+".jobChangeGoodsModal", goodsCodeAdmVo);
	}
	
	//기종 리스트
	@Override
	public List<GoodsCodeAdmVo> goosdCdGijonglist(GoodsCodeAdmVo goodsCodeAdmVo) throws Exception{
		return session.selectList(namespace+".goosdCdGijonglist", goodsCodeAdmVo);
	}
}