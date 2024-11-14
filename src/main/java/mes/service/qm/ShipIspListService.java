package mes.service.qm;

import java.util.List;

import mes.domain.qm.ShipIspListVo;

public interface ShipIspListService {
	
	//List
	public List<ShipIspListVo> shipIspListList(ShipIspListVo shipIspListVo) throws Exception;
	
}