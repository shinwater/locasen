<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<link rel="stylesheet" href="/resources/js/styles/jqx.base.css" type="text/css"/>
<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/resources/js/jqx-all.js"></script>
<script type="text/javascript" src="/resources/js/jqxgrid.js"></script>
<script type="text/javascript" src="/resources/js/jqxcore.js"></script>
<script type="text/javascript" src="/resources/js/jqxscrollbar.js"></script>
<script type="text/javascript" src="/resources/js/jqxpanel.js"></script>
<script type="text/javascript" src="/resources/js/jqxmenu.js"></script>
<script type="text/javascript" src="/resources/js/jqxgrid.pager.js"></script>
<script type="text/javascript" src="/resources/js/jqxgrid.selection.js"></script>
<script type="text/javascript" src="/resources/js/jqxdata.js"></script>
<script type="text/javascript" src="/resources/js/jqxgrid.aggregates.js"></script>

<script type="text/javascript">

    // Load Charts and the corechart and barchart packages.
    google.charts.load('current', {'packages':['corechart']});

    // Draw the pie chart and bar chart when Charts is loaded.
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
		var combo_data = new google.visualization.DataTable()
		var chart = new google.visualization.ColumnChart(document.getElementById("combochart_div"));
		
		var find_key_data = "";
		
	    $.ajax({
			    url: <%=request.getContextPath() %>"/loca_sensorCnt.do",
			    dataType: "json", // QQQ. 헐 근디 얘 안쓰면 왜 string으로 받아오징???
			    //contentType : "application/json; charset=UTF-8",
			    success: function (data) {
			    	
			    	find_key_data = data;
			    	
			    	combo_data.addColumn('string','loca_nm');
					combo_data.addColumn('number','sensor_cnt');
					//combo_data.addColumn('string','loca_cd')
					
					data.forEach(function (row) {
						combo_data.addRow([
						      row.loca_nm,
						      parseInt(row.sensor_cnt),
						      //QQQ 헐 숫자를int형으로 안바꿔주면 Data column(s) for axis #0 cannot be of type string에러남... 
						      //row.loca_cd
						]);
					});
					
				      var options = {
				        title: "위치별 센서현황",
				        vAxis: {title: 'Sensor_count'},
				        hAxis: {title: 'Location'},
				        width: 600,
				        height: 400,
				        bar: {groupWidth: "55%"},
				        legend: { position: "none" },
				      };
				      
				      chart.draw(combo_data, options);
				
				}
		});
		
	    // 막대기 선택시 그리드 창 띄우기 이벤트 
		google.visualization.events.addListener(chart, 'select', function(){
		 	var selection = chart.getSelection();
			
		 	// 내가 선택한 위치 명
			var select_loca_nm = combo_data.getValue(chart.getSelection()[0].row, 0);
			var loca_cd = "";
			
			// 위치명에 해당하는 위치코드를 찾아온다... QQQ loca_cd를 차트안에 어떻게 넣는지 알아볼것...
			for(var i in find_key_data)
			{
				if ( find_key_data[i].loca_nm == select_loca_nm)
				{
					loca_cd = "";
					loca_cd = find_key_data[i].loca_cd;	
				}
			}
			
			
			$.ajax({
				url: <%=request.getContextPath() %>"/loca_sensorList.do",    // ajax 요청할 url 대입
				data: {"loca_cd": loca_cd},
				//contentType : "application/json; charset=UTF-8",
				dataType: "json",
				type: "GET",
				success: function(data){
					//그리드 보여주기 
					var gridList = new Array();
					// 데이터 값 넣기
					for(var i=0; i<data.length; i++)
					{
						var row = {};
						
						row["LOCA_CD"] = data[i].loca_cd;
						row["LOCA_NM"] = data[i].loca_nm;
						row["SENSOR_CD"] = data[i].sensor_cd;
						row["SENSOR_NM"] = data[i].sensor_nm;
						gridList[i] = row;
					}
					
					// 데이터 필드 지정
					var gridSource =
				    {
				        //datatype: "json",
				        datafields: [
				        	{ name: 'LOCA_CD', type: 'string' },
				            { name: 'LOCA_NM', type: 'string' },
				            { name: 'SENSOR_CD', type: 'string' },
				            { name: 'SENSOR_NM', type: 'string' }
				        ],
				        id: 'SENSOR_CD',
				        localdata : gridList  
				    };
				        
				        $("#jqxgrid").jqxGrid(
				        {
				            source: gridSource
				        	,height: '400px'
				        	,width: '620px' 
				        	,pageable: true
				            ,pagermode: 'simple'
				            //,selectionmode: 'checkbox'
			                ,altrows: true
				                        	
						    ,columns: [
						    	{ text: '위치코드', datafield: 'LOCA_CD', width: 170},
				                { text: '위치명', datafield: 'LOCA_NM', width: 140},
				                { text: '센서코드', datafield: 'SENSOR_CD', width: 170},
				                { text: '센서명', datafield: 'SENSOR_NM', width: 140}
				            ]
				        });
			        
				}// success 끝
			});
			
		 });
    
    }
 	



    
</script>
	<title>GoogleChart</title>
</head>
<body>
	<div align="center">
		<div class="statChart">
			<!-- 콤보차트 -->
			<div id="combochart_div" style="width: 800px; height: 400px;"></div>		
		</div>
		
		<div class="sensorDetail">
		   <div id="jqxgrid" style="width: 400px; height: 400px;"></div>
		</div>
	</div>
	 
</body>
</html>