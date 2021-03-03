package com.dgrm.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.dgrm.domain.LocaVO;
import com.dgrm.domain.SensorVO;

public interface LocaDAO {
	
	public List<LocaVO> selectLocaTree();
	public List<SensorVO> selectLocaGridItem(String LOCA_CD);
	public List<SensorVO> selectLocaSensorList(String LOCA_CD);
	public List<LocaVO> selectLocaSensorStat();
	public List<SensorVO> selectSensorInfo(String SENSOR_CD);
	public List<LocaVO> selectLocaInfo(String LOCA_CD);
	public int deleteLocaInfo(String LOCA_CD);
	public int deleteSensorInfo(String SENSOR_CD);
	public int updateLocaInfo(LocaVO vo);
	public int insertLocaInfo(LocaVO vo);
	public int updateSensorCoord(SensorVO vo);
	
	public List<SensorVO> selectSensorCd(HashMap<String, String> cd_list);
	public int insertSensorList(Object list);
	public int updateSensorList(Object list);

}
