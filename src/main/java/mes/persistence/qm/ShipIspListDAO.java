package mes.persistence.qm;

import java.util.List;

import mes.domain.qm.ShipIspListVo;

public interface ShipIspListDAO {
	
	//List
	public List<ShipIspListVo> shipIspListList(ShipIspListVo shipIspListVo) throws Exception;
	
}