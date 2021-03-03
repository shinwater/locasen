package com.dgrm.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.StaticApplicationContext;
import org.springframework.stereotype.Repository;

import com.dgrm.domain.LocaVO;
import com.dgrm.domain.SensorVO;

@Repository
public class LocaDAOImpl implements LocaDAO{

	@Inject
	private SqlSessionTemplate sqlSession;
	
	private static String namespace = "mapper.LocaMapper.";
	
	@Override
	public List<LocaVO> selectLocaTree() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectLocaTreeItem");
	}

	@Override
	public List<SensorVO> selectLocaGridItem(String LOCA_CD) {
		// TODO Auto-generated method stub
		System.out.println("여기는 DAOImpl:"+(LOCA_CD!=""));
		return sqlSession.selectList(namespace+"selectLocaGridItem", LOCA_CD);
	}
	
	@Override
	public List<LocaVO> selectLocaSensorStat() {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectLocaSensorStat");
	}

	@Override
	public List<SensorVO> selectSensorInfo(String SENSOR_CD) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectSensorInfo", SENSOR_CD);
	}
	@Override
	public List<LocaVO> selectLocaInfo(String LOCA_CD) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectLocaInfo", LOCA_CD);
	}

	@Override
	public int updateLocaInfo(LocaVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+"updateLocaInfo", vo);
	}

	@Override
	public int insertLocaInfo(LocaVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+"insertLocaInfo", vo);
	}

	@Override
	public int updateSensorCoord(SensorVO vo) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+"updateSensorCoord", vo);
	}

	@Override
	public List<SensorVO> selectLocaSensorList(String LOCA_CD) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectLocaSensorList", LOCA_CD);
	}

	@Override
	public int deleteLocaInfo(String LOCA_CD) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+"deleteLocaInfo", LOCA_CD);
	}

	@Override
	public List<SensorVO> selectSensorCd(HashMap<String, String> cd_list) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"selectSensorCd", cd_list);
	}

	@Override
	public int deleteSensorInfo(String SENSOR_CD) {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+"deleteSensorInfo", SENSOR_CD);
	}

	@Override
	public int insertSensorList(Object list) {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+"insertSensorList", list);
	}

	@Override
	public int updateSensorList(Object list) {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+"updateSensorList", list);
	}




}
