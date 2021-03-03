<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>OpenLayers</title>
	
	<link rel="stylesheet" href="/resources/css/ol.css" type="text/css">
	<link rel="stylesheet" href="/resources/css/map.css" type="text/css">
	<script type="text/javascript" src="/resources/js/ol.js"></script>

	<link rel="stylesheet" href="../resources/js/styles/jqx.base.css" type="text/css"/>
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/js/jqxcore.js"></script>
	<script type="text/javascript" src="/resources/js/jqxwindow.js"></script>
	<script type="text/javascript">
		$(document).ready(function () {

			/*
			* 그리드에서 센서정보 가져옴
			*/
			var map_path = `${info[0].loca_addr }`;
			var sensor_cd = `${info[0].sensor_cd }`;
			var sensor_coord = `${info[0].sensor_coord }`;
			var sensor_nm = `${info[0].sensor_nm }`;
			var sensor_onoff = `${info[0].sensor_onoff }`;
			
			var xy_coord = sensor_coord.split(",");
			
			console.log("맽경로: " +map_path +"\n 센서좌표: "+sensor_coord);
			
			
			$('#x_coord').val(xy_coord[0]);
			$('#y_coord').val(xy_coord[1]);
			
			// 좌표 값 변경
			$('#change_coord').on('click', function(){
				var coord1= $('#x_coord').val();
				var coord2= $('#y_coord').val();
				
				$.ajax({
					url: <%=request.getContextPath() %>"/change_sensor_coord.do",    // ajax 요청할 url 대입
					data: {"coord1" : coord1, "coord2" : coord2, "sensor_cd":sensor_cd},   // controller에서 파라미터로 받을 조건 데이터(조건 데이터가 없다면 이 부분은 없어도 무관)
					contentType : "application/json; charset=UTF-8",
					//dataType: "json",
					type: "GET",
					success: function(data){
						// 행 추가
					    window.location.reload();
					}
		        });
			});

			
			/*
			 * overlay
			 */
			var overlay = new ol.Overlay({
			  element: document.getElementById('overlay'),
			  positioning: 'bottom-center'
			});
			
			var iconFeature1 = new ol.Feature({
			    geometry: new ol.geom.Point([xy_coord[0],xy_coord[1]]),
			    name: sensor_nm
			});
/* 			var iconFeature2 = new ol.Feature({
			    geometry: new ol.geom.Point([876, 334]),
			    name: '보이지 않는 꿈의 섬'
			});
 */
			var iconStyle = new ol.style.Style({
				  image: new ol.style.Icon({
				    anchor: [0.5, 46],
				    anchorXUnits: 'fraction',
				    anchorYUnits: 'pixels',
				    src: '/resources/js/styles/images/star.png',
				  }),
			});

			iconFeature1.setStyle(iconStyle);
//			iconFeature2.setStyle(iconStyle);

			var vectorSource = new ol.source.Vector({
			  features: [iconFeature1],
			});

			var vectorLayer = new ol.layer.Vector({
			  source: vectorSource,
			});

			// 이미지 지도
			var extent = [0, 0, 1024, 968];
			var projection = new ol.proj.Projection({
			  code: 'xkcd-image',
			  units: 'pixels',
			  extent: extent,
			});

			var map = new ol.Map({
				layers: [
				  new ol.layer.Image({
				    source: new ol.source.ImageStatic({
				      url: map_path,
				      projection: projection,
				      imageExtent: extent,
				    })
				  }) ,vectorLayer],
				target: 'map',
				
				view: new ol.View({
				  projection: projection,
				  center: new ol.extent.getCenter(extent),
				  zoom: 2,
				  maxZoom: 8,
				}),
			});


			/*
			* 마우스 이동 이벤트 콜백함수
			*/
			var selected = null;
			
			map.on('pointermove', function (e) {
				if (selected !== null) {
					selected.setStyle(undefined);
					selected = null;
				}
				
				map.forEachFeatureAtPixel(e.pixel, function (f) {
				 
					console.log(Object.keys(f.get('geometry')));
					console.log(f.get('geometry').flatCoordinates); 
					console.log(f.get('name'));
					selected = f;
				
					return true;
				});
				
				if (selected == null)
				{
					//$("#jqxwindow").jqxWindow({ width: 0, height: 0 });
					
				}
				else
				{
					//document.getElementById("jqxgrid").style.display="block";
					
					/* $("#jqxwindow").jqxWindow({ width: 300, height: 100 });
					$("#s_coord").html("좌표 : ( "+selected.get('geometry').flatCoordinates+" ) <br/>");
					$("#s_name").html("센서명 : "+selected.get('name')+"<br/>");
					$("#s_code").html("센서코드 : "+sensor_cd);
					 */
					var element = overlay.getElement();
					element.innerHTML = "좌표 : "+selected.get('geometry').flatCoordinates
								+"<br/>센서명 : "+selected.get('name')+"<br/>센서코드 : "+sensor_cd;
					// position the element (using the coordinate in the map's projection)
					overlay.setPosition(selected.get('geometry').flatCoordinates);
					// and add it to the map
					map.addOverlay(overlay);
				}

			});
			
			/*
			 * click 이벤트 콜백함수
			 */
			//register an event handler for the click event
			map.on('click', function(event) {
				// extract the spatial coordinate of the click event in map projection units
				var coord = event.coordinate;
				// transform it to decimal degrees
				var degrees = ol.proj.transform(coord, 'EPSG:3857', 'EPSG:4326');
				// format a human readable version
				/* var hdms = ol.coordinate.toStringHDMS(degrees);
				
				
				// update the overlay element's content
				var element = overlay.getElement();
				
				element.innerHTML = "좌표 : "+coord+"<br/>센서명 : "+sensor_nm+"<br/>센서코드 : "+sensor_cd;
				// position the element (using the coordinate in the map's projection)
				overlay.setPosition(coord);
				// and add it to the map
				map.addOverlay(overlay);
				 
				//console.log(event);
				 
				var feature = map.forEachFeatureAtPixel(event.pixel, function (feature) {
					return feature;
				}); */
				
				 //var coordinates =  feature.getGeometry().getCoordinates();
				  
				  
				if (feature != undefined)
				{
					 $("#jqxwindow").jqxWindow({ width: 300, height: 100 });
				}
				else
				{
				 
				}
			});
	   });
		
	</script>
</head>
<body>
	<div>
		<div style="float:left">
			<input type="text" id="x_coord" name="x_coord">
			<input type="text" id="y_coord" name="y_coord">
			<input type="button" id="change_coord" value="변경">
		</div>
	</div>
	
	<!-- 지도 표시 영역 -->
	<div id='map' class='map'></div>
	<div id='jqxwindow'>
		<div>Sensor Information</div>
		<!-- <div>센서
			<button id="btn_on" value="on"></button>
			<button id="btn_off" value="off"></button>
		</div> -->
	</div>
	<div id="overlay" style="background-color: white; border-radius: 10px; border: 1px solid black; padding: 5px 10px;">	
	</div>

</body>
</html>