package mes.persistence.qm;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import mes.domain.qm.ShipIspListVo;

@Repository
public class ShipIspListDAOImpl implements ShipIspListDAO {

	@Inject
	private SqlSession session;

	private static final String namespace = "mes.mappers.qm.shipIspListMapper";

	//List
	@Override
	public List<ShipIspListVo> shipIspListList(ShipIspListVo shipIspListVo) throws Exception {
	    return session.selectList(namespace + ".shipIspListList", shipIspListVo);
	}
	
}