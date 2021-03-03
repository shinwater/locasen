package com.dgrm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dgrm.dao.LocaDAOImpl;
import com.dgrm.domain.LocaVO;
import com.dgrm.domain.SensorVO;

@Service
public class LocaServiceImpl implements LocaService{

	@Autowired private LocaDAOImpl LocaDAOImpl;

	@Override
	public List<LocaVO> selectLocaTree() {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectLocaTree();
	}

	@Override
	public List<LocaVO> selectLocaSensorStat() {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectLocaSensorStat();
	}

	@Override
	public List<SensorVO> selectLocaGridItem(String LOCA_CD) {
		// TODO Auto-generated method stub
		System.out.println("여기는 ServiceImpl:"+(LOCA_CD!=""));

		return LocaDAOImpl.selectLocaGridItem(LOCA_CD);
	}

	@Override
	public List<SensorVO> selectSensorInfo(String SENSOR_CD) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectSensorInfo(SENSOR_CD);
	}
	
	@Override
	public List<LocaVO> selectLocaInfo(String LOCA_CD) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectLocaInfo(LOCA_CD);
	}
	
	@Override
	public int updateLocaInfo(LocaVO vo) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.updateLocaInfo(vo);
	}

	@Override
	public int insertLocaInfo(LocaVO vo) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.insertLocaInfo(vo);
	}

	@Override
	public int updateSensorCoord(SensorVO vo) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.updateSensorCoord(vo);
	}

	@Override
	public List<SensorVO> selectLocaSensorList(String LOCA_CD) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectLocaSensorList(LOCA_CD);
	}

	@Override
	public int deleteLocaInfo(String LOCA_CD) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.deleteLocaInfo(LOCA_CD);
	}

	@Override
	public List<SensorVO> selectSensorCd(HashMap<String, String> cd_list) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.selectSensorCd(cd_list);
	}

	@Override
	public int deleteSensorInfo(String SENSOR_CD) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.deleteSensorInfo(SENSOR_CD);
	}

	@Override
	public int insertSensorList(Object list) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.insertSensorList(list);
	}

	@Override
	public int updateSensorList(Object list) {
		// TODO Auto-generated method stub
		return LocaDAOImpl.updateSensorList(list);

	}
	
	


}
