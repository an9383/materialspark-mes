package mes.service.qm;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import mes.domain.qm.ShipIspListVo;
import mes.persistence.qm.ShipIspListDAO;

@Service
public class ShipIspListServiceImpl implements ShipIspListService {

	@Inject
	private ShipIspListDAO dao;
	
	//List
	@Override
	public List<ShipIspListVo> shipIspListList(ShipIspListVo shipIspListVo) throws Exception {
	    return dao.shipIspListList(shipIspListVo);
	}
	
}