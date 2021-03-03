package com.dgrm.controller;

import java.io.Console;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dgrm.domain.LocaVO;
import com.dgrm.domain.SensorVO;
import com.dgrm.service.LocaServiceImpl;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
	@Autowired
	private LocaServiceImpl locaServiceImpl;

	
	/*
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	/*
	 * 위치 목록 조회 (트리)
	 */
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/tree.do", method = RequestMethod.GET)
	public String tree(HttpServletResponse response ,HttpServletRequest request ,Model model) throws Exception{
		
		PrintWriter out = response.getWriter();
        List<LocaVO> locaList = locaServiceImpl.selectLocaTree();
        
        out.print(JSONArray.fromObject(locaList));
        
        return null;
	}
	
	// 위치 정보에 해당하는 센서정보 (차트창 열기)
	@RequestMapping(value = "/loca_sensor.do", method =RequestMethod.GET)
	public String loca_sensor(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav) throws IOException {
		return "loca_sensor";
	}
	
	/*
	 * 위치정보에 해당하는 센서의 개수 (구글차트)
	 */
	@RequestMapping(value= "/loca_sensorCnt.do")
	public String loca_sensorCnt(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav) throws IOException {
		
		PrintWriter out = response.getWriter();
		List<LocaVO> loca_sensor_List = locaServiceImpl.selectLocaSensorStat();
		
		out.print(JSONArray.fromObject(loca_sensor_List));
		
		return null;
	}
	
	/*
	 * 차트 클릭시 해당 위치의 센서목록 조회 (구글차트 이벤트)
	 */
	@RequestMapping(value= "/loca_sensorList.do")
	public String loca_sensorList(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav,@RequestParam("loca_cd") String id) throws IOException {
		
		PrintWriter out = response.getWriter();
		List<SensorVO> loca_sensor_detail_list = locaServiceImpl.selectLocaSensorList(id);
		out.print(JSONArray.fromObject(loca_sensor_detail_list));

		return null;
	}	
	
	// 트리에서 값 누를때 센서 목록 조회 리스트 (그리드)
	@RequestMapping(value= "/grid_event.do")
	public String loca_sensor(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav,@RequestParam("loca_cd") String id) throws IOException {
		
		PrintWriter out = response.getWriter();
		List<SensorVO> loca_sensor_detail_list = locaServiceImpl.selectLocaGridItem(id);
		
		out.print(JSONArray.fromObject(loca_sensor_detail_list));

		return null;
	}
	
	/*
	 * 센서 목록 그리드에서 CCTV연결버튼 누를때 이벤트 (맵)
	 */
	@RequestMapping(value= "/sensor_coord.do")
	public ModelAndView sensor_info(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav,@RequestParam("val") String sensor_cd) throws IOException {
		
		PrintWriter out = response.getWriter(); 
		List<SensorVO> sensor_info = locaServiceImpl.selectSensorInfo(sensor_cd);
		
		mav.setViewName("sensor_coord");
		mav.addObject("info", sensor_info);
		
		return mav;
	}
	
	/*
	 * 센서 좌표 변경 (맵 이벤트)
	 */
	@RequestMapping(value = "/change_sensor_coord.do")
	public void update_sensor_coord(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
			, @RequestParam("coord1") String coord1, @RequestParam("coord2") String coord2, @RequestParam("sensor_cd") String sensor_cd) throws IOException {
	
		String sensor_coord = coord1+ ","+coord2;

		SensorVO vo = new SensorVO();
		
		vo.setSensor_cd(sensor_cd);
		vo.setSensor_coord(sensor_coord);
		
		//PrintWriter out = response.getWriter();
		int res = locaServiceImpl.updateSensorCoord(vo);

	}
	
	/*
	 * 위치 추가 (트리 이벤트)
	 */
	@RequestMapping(value = "/tree_add.do")
	public void insert_loca(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
				, @RequestParam("loca_nm") String loca_nm, @RequestParam("up_loca_cd") String up_loca_cd) throws IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		LocaVO vo = new LocaVO();
		vo.setLoca_nm(loca_nm);
		vo.setUp_loca_cd(up_loca_cd);
		
		int res = locaServiceImpl.insertLocaInfo(vo);
		
		PrintWriter out = response.getWriter();
		if(res == 1) {
			out.println("<script>");
			out.println("window.location.reload();");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('수정실패')");
			out.println("history.back()");
			out.println("</script>");	
		}
	}
	
	/*
	 * 위치정보 수정창 띄우기 (트리 이벤트)
	 */
	@RequestMapping(value= "/update_loca_open.do")
	public ModelAndView update_loca_open(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav,@RequestParam("val") String loca_cd) throws IOException {
		
		PrintWriter out = response.getWriter(); 
		List<LocaVO> loca_info = locaServiceImpl.selectLocaInfo(loca_cd);
		
		mav.setViewName("update_loca");
		mav.addObject("info", loca_info);
		
		return mav;
	}
	
	/*
	 * 위치정보 수정 (트리 이벤트)
	 */
	@RequestMapping(value = "/update_ok_loca.do")
	public void update_ok_loca(HttpServletResponse response ,HttpServletRequest request ,ModelAndView mav) throws IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		// 수정창에서 값을 받음
		String loca_cd = request.getParameter("loca_cd").trim();
		String loca_nm = request.getParameter("loca_nm").trim();
		String loca_sort = request.getParameter("loca_sort").trim();
		String use_yn = request.getParameter("use_yn").trim();
		//String loca_addr = request.getParameter("use_yn").trim();
		
		LocaVO vo = new LocaVO();
		
		vo.setLoca_cd(loca_cd);
		vo.setLoca_nm(loca_nm);
		vo.setLoca_sort(loca_sort);
		vo.setUse_yn(use_yn);
		
		int res = locaServiceImpl.updateLocaInfo(vo);
		System.out.println("겨ㅑㄹ과:"+res);
		
		PrintWriter out = response.getWriter();
		if(res == 1) {
			out.println("<script>");
			out.println("window.open('','_self').close();");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('수정실패')");
			out.println("history.back()");
			out.println("</script>");	
		}
	}
	
	/*
	 * 선택한 위치정보 삭제 (트리 이벤트)
	 */
	@Transactional
	@RequestMapping(value="/tree_del.do")
	public void delete_loca(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
			, @RequestParam("items[]") List<String> itemList) throws IOException {
	
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		System.out.println("삭제시도:"+itemList);
		System.out.println(itemList);
		
		for (int i=0; i<itemList.size(); i++)
		{
			String LOCA_CD = itemList.get(i);
			locaServiceImpl.deleteLocaInfo(LOCA_CD);
		}

	}
	
	/*
	 * 그리드 행 추가시 기본값들 가져오는 메서드
	 */
	@RequestMapping(value="/grid_add.do")
	public void grid_add(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
			,@RequestParam("loca_cd") String loca_cd, @RequestParam("sensor_cd") String sensor_cd) throws IOException {
	//, @RequestParam("items[]") List<String> itemList
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		PrintWriter out = response.getWriter();

		// parameter 여러개 넘기는법 1.vo에넣어서 2.Hashmap으로 !!
		HashMap<String, String> cd_list = new HashMap<String, String>(); 
		cd_list.put("loca_cd", loca_cd);
		cd_list.put("sensor_cd", sensor_cd);
		
		List<SensorVO> sensor_info = locaServiceImpl.selectSensorCd(cd_list);
		
		System.out.println("간다아"+sensor_info);
		
		out.print(JSONArray.fromObject(sensor_info));
	}
	
	/*
	 * 그리드 변경사항 저장
	 */
	@Transactional
	@RequestMapping( value="/grid_change.do")
	public void grid_change(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
			,@RequestParam("data") String gridList) throws IOException {
	//, @RequestParam("items[]") List<String> itemList
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		PrintWriter out = response.getWriter();

		System.out.println("여기가 넘어온 값:: " +gridList+ "\n , 타입:: "+gridList.getClass().getName());
		
		JSONArray arr = JSONArray.fromObject(gridList);
		
		System.out.println("형변환 :: "+arr+"\n , 타입 :: "+arr.getClass().getName());
		
		
		for(int i=0; i<arr.size(); i++)
		{
			JSONObject obj = arr.getJSONObject(i);
			System.out.println(" 마지막...확인...:"+obj+"\n , 타입:"+obj.getClass().getName());
			
			System.out.println("로우타입:"+obj.get("ROW_TYPE"));
			
			if ("U".equals(obj.get("ROW_TYPE")))
			{
				locaServiceImpl.updateSensorList(arr.get(i));
			}
			else if ("I".equals(obj.get("ROW_TYPE")))
			{
				locaServiceImpl.insertSensorList(arr.get(i));
			}
		}
	}
	
	/*
	 * 선택한 센서정보 삭제 (그리드 이벤트)
	 */
	@Transactional
	@RequestMapping(value="/grid_del.do")
	public void delete_sensor(HttpServletResponse response, HttpServletRequest request, ModelAndView mav
			, @RequestParam("items[]") List<String> itemList) throws IOException {
	
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
	
		for (int i=0; i<itemList.size(); i++)
		{
			String SENSOR_CD = itemList.get(i);
			locaServiceImpl.deleteSensorInfo(SENSOR_CD);
		}

	}

}
