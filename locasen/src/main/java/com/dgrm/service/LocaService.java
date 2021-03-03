package com.dgrm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dgrm.domain.LocaVO;
import com.dgrm.domain.SensorVO;

public interface LocaService {
	
	/*
	 * 위치정보 트리 메서드
	 */
	// 트리
	public List<LocaVO> selectLocaTree();
	// 위치정보 수정창 
	public List<LocaVO> selectLocaInfo(String LOCA_CD);
	public int deleteLocaInfo(String LOCA_CD);
	public int updateLocaInfo(LocaVO vo);
	public int insertLocaInfo(LocaVO vo);

	/*
	 * 센서정보 
	 */
	public List<SensorVO> selectLocaGridItem(String LOCA_CD);
	public List<SensorVO> selectLocaSensorList(String LOCA_CD);
	public List<SensorVO> selectSensorInfo(String SENSOR_CD);
	
	public int deleteSensorInfo(String SENSOR_CD);

	public int updateSensorCoord(SensorVO vo);
	public List<LocaVO> selectLocaSensorStat();
	public List<SensorVO> selectSensorCd(HashMap<String, String> cd_list);
	public int insertSensorList(Object list);
	public int updateSensorList(Object list);
	

}
