<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="description" content="JavaScript Grid with checkboxes selection" />
	<link rel="stylesheet" href="/resources/js/styles/jqx.base.css" type="text/css"/>
	
	<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/resources/js/jqx-all.js"></script>
   	<script type="text/javascript" src="/resources/js/jqxgrid.js"></script>
    <script type="text/javascript" src="/resources/js/jqxcore.js"></script>
    <script type="text/javascript" src="/resources/js/jqxbuttons.js"></script>
    <script type="text/javascript" src="/resources/js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="/resources/js/jqxpanel.js"></script>
    <script type="text/javascript" src="/resources/js/jqxtree.js"></script>
   	<script type="text/javascript" src="/resources/js/jqxmenu.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="/resources/js/jqxgrid.selection.js"></script>
    <script type="text/javascript" src="/resources/js/jqxdata.js"></script>
	<script type="text/javascript" src="/resources/js/jqxlistbox.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.sort.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.grouping.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.filter.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.aggregates.js"></script>
	<script type="text/javascript" src="/resources/js/jqxdata.export.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.export.js"></script>
	<script type="text/javascript" src="/resources/js/jqxdropdownlist.js"></script>
	<script type="text/javascript" src="/resources/js/jqxgrid.edit.js"></script>
	<script type="text/javascript" src="/resources/js/jqxcheckbox.js"></script>
	<script type="text/javascript" src="/resources/js/jqxcalendar.js"></script>
	<script type="text/javascript" src="/resources/js/jqxdatetimeinput.js"></script>
	<script type="text/javascript" src="/resources/js/jqxexport.js"></script>
	<script type="text/javascript" src="/resources/js/jszip.min.js"></script>
	
	
<!-- 	<script type="text/javascript" src="../../scripts/demos.js"></script>
	JSZip
     -->
	
	<script type="text/javascript">
		$(document).ready(function () {
			
			var jqxTree = $('#jqxTree');
	        var treeData = null;
			var jqxGrid = $('#jqxgrid');
			var gridData = new Array();
			
			// ROW_TYPE????????? ????????? ???????????????..
			var changeData = new Array();
			
			// ?????? ???????????? ????????? ?????? ??????
			var loca_cd = null;
			
	        
	        // ?????? ??????,?????????
	        jqxTree.jqxTree({
				checkboxes: true
				,source: treeData
				,height: '800px'
				,width: '98%' 
			});	
	        
	        jqxGrid.jqxGrid({
	            source: gridData
	        	,height: '800px'
	        	,width: '950px' 
	        	,pageable: true
	        	,sortable: true
            	,selectionmode : 'multiplerows'
	            //,editable: true
	            //,pagermode: 'simple'
	            ,selectionmode: 'checkbox'
                ,altrows: true
	                        	
			    ,columns: [
			    	//{ text: '????????????', datafield: 'LOCA_CD', width: 170 ,editable: false},	                
			    	{ text: ' ', datafield: 'ROW_TYPE', width: 15},
			    	{ text: '?????????', datafield: 'LOCA_NM', width: 140},
	                { text: '????????????', datafield: 'SENSOR_CD', width: 170 ,editable: false},
	                { text: '?????????', datafield: 'SENSOR_NM', width: 140},
	                { text: '????????????', datafield: 'SENSOR_TYPE', width: 100},
	                { text: '???????????????', datafield: 'ALARM_IMPTANCE', columntype: 'dropdownlist', width: 100 ,editable: true},
	                { text: '????????????', datafield: 'ALARM_YN', width: 80, cellsalign: 'right' },
	                { text: '????????????', datafield: 'FNL_MDFC_DTM', columntype: 'datetimeinput', width: 90, cellsalign: 'right', cellsformat: 'yyyy-MM-dd' },
	                { text: 'CCTV??????', datafield: 'SENSOR_COORD', columntype:'button', width: 100, cellsalign: 'right', cellsformat: 'c2' , editable: false
	                	,buttonclick: function (row) {  
							// select??? row??? ????????? ????????? index ?????? ????????????.  
							var data = $("#jqxgrid").jqxGrid('getrowdata', row);
							console.log(data["SENSOR_CD"]);
							window.open("/sensor_coord.do?val="+data["SENSOR_CD"], "????????????", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
	                	}
	                }
	            ]
	        });
	        
	        // Tree ????????? ???????????? 
			$.ajax({
					url: <%=request.getContextPath() %>"/tree.do",    // ajax ????????? url ??????
					//data: param,   // controller?????? ??????????????? ?????? ?????? ?????????(?????? ???????????? ????????? ??? ????????? ????????? ??????)
					contentType : "application/json; charset=UTF-8",
					dataType: "json",
					type: "GET",
					success: function(data){
						//source = jQuery.parseJSON(data);
						treeData = data;
						
						// ????????? ?????????
						var source =
						{
						    datatype: "json",
						    datafields: [
						        { name: 'loca_cd' },
						        { name: 'up_loca_cd' },
						        { name: 'loca_nm' }
						    ],
						    id: 'loca_cd',
						    localdata: treeData
						};
						
						var dataAdapter = new $.jqx.dataAdapter(source);
						dataAdapter.dataBind();
					
						var records = dataAdapter.getRecordsHierarchy('loca_cd', 'up_loca_cd', 'items'
										, [{ name: 'loca_nm', map: 'label'},{name: 'loca_cd', map: 'id'},{name:'up_loca_cd', map:'parentid'}]);
						
						// ?????? ?????????
						$('#jqxTree').jqxTree({
							checkboxes: true
							,source: records
							,height: '800px'
							,width: '98%' 
						});	
						
						$('#jqxTree').jqxTree('expandAll');
					}
			});
	        
	        // ????????? ?????? ?????? ?????????
	        $('#loca_sensor').on('click', function (){
	        	 window.open("/loca_sensor.do", "????????? ????????????", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  

	        });
	        
	        
	        // ?????? ????????? ?????????
	        $('#jqxTree').on('itemClick',function (event)
      		{
      		    var args = event.args;
      		    var item = $('#jqxTree').jqxTree('getItem', args.element);
      		    loca_cd = item.id;
      		    
      			// grid
    			$.ajax({
    					url: <%=request.getContextPath() %>"/grid_event.do",    // ajax ????????? url ??????
    					data: {"loca_cd": loca_cd},
    					//contentType : "application/json; charset=UTF-8",
    					dataType: "json",
    					type: "GET",
    					success: function(data){
    						
    						gridData = new Array();
    						
    						
    						// ????????? ??? ??????
    						for(var i=0; i<data.length; i++)
    						{
    							var row = {};
    							
    							/* var dtm = data[i].fnl_mdfc_dtm["year"]+1900+
    										(data[i].fnl_mdfc_dtm["month"]+1).toString().padStart(2,'0')+
    										("%02d", data[i].fnl_mdfc_dtm["date"]).toString().padStart(2,'0');
    							console.log("??????: "+dtm);
    							 */
    							row["LOCA_CD"] = data[i].loca_cd;
    							row["LOCA_NM"] = data[i].loca_nm;
    							row["SENSOR_CD"] = data[i].sensor_cd;
    							row["SENSOR_NM"] = data[i].sensor_nm;
    							row["SENSOR_TYPE"] = data[i].sensor_type;
    							row["ALARM_IMPTANCE"] = data[i].alarm_imptance;
    							row["ALARM_YN"] = data[i].alarm_yn;
    							
    							/* String -> date */
    							var y = data[i].fnl_mdfc_dtm.substr(0, 4);
    							var m = data[i].fnl_mdfc_dtm.substr(4, 2);
    							var d = data[i].fnl_mdfc_dtm.substr(6, 2);
    							row["FNL_MDFC_DTM"] = new Date(y,m-1,d);

    							row["SENSOR_COORD"] = data[i].sensor_coord;
    							//row["SENSOR_ONOFF"] = data[i].sensor_onoff;
    							gridData[i] = row;
    						}
    						
    						// ????????? ?????? ??????
    						var gridSource =
    					    {
    					        datatype: "json",
    					        updaterow: function (rowid, rowdata, commit) {
    					        	
    					        	
    					        	if (rowdata.ROW_TYPE!="I")
    					        	{ 
										$("#jqxgrid").jqxGrid('setcellvaluebyid', rowid, "ROW_TYPE", "U");
	    			                   
    					        	}
    					        	commit(true);
    			                }, 
    			                deleterow: function (rowid, rowdata, commit) {
    			                	// ROW_TYPE?????? D??? ????????? ID??? ??????
									var row = {};
									
									/* var dtm = data[i].fnl_mdfc_dtm["year"]+1900+
												(data[i].fnl_mdfc_dtm["month"]+1).toString().padStart(2,'0')+
												("%02d", data[i].fnl_mdfc_dtm["date"]).toString().padStart(2,'0');
									console.log("??????: "+dtm);
									 */
									row["ROW_TYPE"] = rowdata.row_type;
									row["LOCA_CD"] = rowdata.loca_cd;
									row["LOCA_NM"] = rowdata.loca_nm;
									row["SENSOR_CD"] = rowdata.sensor_cd;
									row["SENSOR_NM"] = rowdata.sensor_nm;
									row["SENSOR_TYPE"] = rowdata.sensor_type;
									row["ALARM_IMPTANCE"] = rowdata.alarm_imptance;
									row["ALARM_YN"] = rowdata.alarm_yn;
									row["FNL_MDFC_DTM"] = rowdata.fnl_mdfc_dtm;
									row["SENSOR_COORD"] = rowdata.sensor_coord;
									//row["SENSOR_ONOFF"] = data[i].sensor_onoff;
									
									changeData[changeData.length] = row;
    					        	
									//alert(changeData.length);
    					        	//$("#jqxgrid").jqxGrid('setcellvalue', id, "ROW_TYPE", "U");
    					        	
    			                    commit(true);
    			                	
    			                },
    					        datafields: [
    					        	{ name: 'ROW_TYPE', type: 'string' },
    					        	{ name: 'LOCA_CD', type: 'string' },
    					            { name: 'LOCA_NM', type: 'string' },
    					            { name: 'SENSOR_CD', type: 'string' },
    					            { name: 'SENSOR_NM', type: 'string' },
    					            { name: 'SENSOR_TYPE', type: 'string' },
    					            { name: 'ALARM_IMPTANCE', type: 'string' },
    					            { name: 'ALARM_YN', type: 'string' },
    					            { name: 'FNL_MDFC_DTM', type: 'string' },
    					            { name: 'SENSOR_COORD', type: 'string' },
    					            { name: 'SENSOR_ONOFF', type: 'string' }
    					        ],
    					        id: 'SENSOR_CD',
    					        localdata : gridData  
    					    };
    						
    						var dataAdapter = new $.jqx.dataAdapter(gridSource);
   					        
 					        $("#jqxgrid").jqxGrid(
 					        {
 					            source: dataAdapter
 					        	,height: '800px'
 					        	,width: '950px' 
 					        	,pageable: true
 					        	,sortable: true
 				            	,selectionmode : 'multiplerows'
 					            ,editable: true
 					            //,pagermode: 'simple'
 					            ,selectionmode: 'checkbox'
 				                ,altrows: true
 					                        	
 							    ,columns: [
 							    	//{ text: '????????????', datafield: 'LOCA_CD', width: 170 ,editable: false},
  					                { text: 't', datafield: 'ROW_TYPE', width: 15, editable: false},
  					                { text: '?????????', datafield: 'LOCA_NM', columntype: 'dropdownlist', width: 140},
 					                { text: '????????????', datafield: 'SENSOR_CD', width: 170 ,editable: false},
 					                { text: '?????????', datafield: 'SENSOR_NM', width: 140},
 					                { text: '????????????', datafield: 'SENSOR_TYPE', width: 100},
 					                { text: '???????????????', datafield: 'ALARM_IMPTANCE', columntype: 'dropdownlist', width: 100 ,editable: true},
 					                { text: '????????????', datafield: 'ALARM_YN', width: 80, cellsalign: 'right' },
 					                { text: '????????????', datafield: 'FNL_MDFC_DTM', columntype: 'datetimeinput', width: 90, cellsalign: 'right', cellsformat: 'yyyy-MM-dd' },
/*  					                { text: 'CCTV??????', datafield: 'SENSOR_COORD', width: 100, cellsalign: 'right', cellsformat: 'c2' , editable: false,
 					                	createwidget: function (row, column, value, htmlElement) {
											var image = $('<button></button>');
											$(htmlElement).append(value);
											$(htmlElement).append(image);
											
											
											image.jqxButton({ width: 25
														      ,height: 25
														      ,template: 'default'
														      ,imgWidth: 16
														      ,imgSrc: 'resources/js/styles/images/gogo.png'   
											});
											image.click(function(){
												alert('');
											});
 	 				                      },
 	 				                      initwidget: function (row, column, value, htmlElement) {
 	 				                      }
 	 				                 }  */
 	 				               { text: 'CCTV??????', datafield: 'SENSOR_COORD', columntype:'button', width: 100, cellsalign: 'right', cellsformat: 'c2' , editable: false
 	 				                	 
 	 				                	,buttonclick: function (row) {  
 	 										// select??? row??? ????????? ????????? index ?????? ????????????.  
 	 										//var loca_cd = row.args.loca_cd;
 	 										var data = $("#jqxgrid").jqxGrid('getrowdata', row);
 	 										console.log(data["SENSOR_CD"]);
 	 										
 	 										window.open("/sensor_coord.do?val="+data["SENSOR_CD"], "????????????", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
 	 				                	}
 	 				               }
 					            ]
 					        });
    				        
 					       //document.getElementById("btn_friends").style.display="block";
 					       document.getElementById("btn_friends").style.visibility="visible";
    					}// success ???
    			});
      		    
      		
      		});
	        
	        // ?????? ?????????
	        $('#btn_TreeE').on('click', function(){
	        	
	        	$('#jqxTree').jqxTree('expandAll');
	        	
	        });
	    	// ?????? ??????
	        $('#btn_TreeC').on('click', function(){
	        	
	        	$('#jqxTree').jqxTree('collapseAll');
	        });
	    	 
	    	
	        // ?????? ????????? ?????? ?????? ??? ?????? 
	        $('#btn_TreeAdd').on('click', function(){
	        	
	        	var item = $('#jqxTree').jqxTree('getCheckedItems');
	        	
                // ????????? ???????????? ?????? ?????? ??????
	        	if (item.length == "1")
	        	{
		        	var parentItem = item[0];
			        var parentItemElement = parentItem.element;
			        
					$('#jqxTree').jqxTree('addTo', { label: 'New Location', id:'asdasdadsasddasa', parentid:parentItemElement.id }, parentItemElement);
			       
			        $.ajax({
						url: <%=request.getContextPath() %>"/tree_add.do",    // ajax ????????? url ??????
						data: {"loca_nm":'New Location',"up_loca_cd":parentItemElement.id},   // controller?????? ??????????????? ?????? ?????? ?????????(?????? ???????????? ????????? ??? ????????? ????????? ??????)
						contentType : "application/json; charset=UTF-8",
						//dataType: "json",
						type: "GET",
						success: function(data){
							// ??? ??????
						    window.location.reload();
						}
			        });
			        
	        	}
	        	// ????????? ???????????? ????????? ?????? ?????? 
	        	else
	        	{
	        		/* if (item.length == "0"){
	        			alert("????????? ????????? ?????? ???????????? ?????????.");
	        		} else{
	        			alert("????????? ?????? ???????????? ?????????.");
	        		} */
	        		
	        	}
	        	
	        });
	        
	        // ?????? ????????? ??? ??????
	        $('#btn_TreeUpdate').on('click', function(){
				
	        	var item = $('#jqxTree').jqxTree('getCheckedItems');
				// ????????? ???????????? ?????? ?????? ??????
	        	if (item.length == "1")
	        	{
	        		var selectItem = item[0].element;
	        		window.open("/update_loca_open.do?val="+selectItem.id,
	        				"???????????? ??????", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
					
	        	}
	        });
	        
	    	 // ?????? ??????
	        $('#btn_TreeDel').on('click', function()
	        {
	        	
	        	var item = $('#jqxTree').jqxTree('getCheckedItems');
	        	
	        	// ????????? ???????????? ?????? ??????
	        	if (item.length != 0)
	        	{
	        		
	        		if (confirm("????????? ????????? ????????????????????????? \n ?????? ????????? ???????????????!!!!")){
	        			
	        			var item_loca_cd = [];
	        			for(var i in item)
	        			{
	        				item_loca_cd.push(item[i].id);
	        			}
	        			
	        			$.ajax({
							url: <%=request.getContextPath() %>"/tree_del.do",    // ajax ????????? url ??????
							data: {"items": item_loca_cd},   // controller?????? ??????????????? ?????? ?????? ?????????(?????? ???????????? ????????? ??? ????????? ????????? ??????)
							contentType : "application/json; charset=UTF-8",
							//dataType: "json",
							type: "GET",
							success: function(data){
								// ??? ??????
							    window.location.reload();
							}
				        });
	        		}
	        		
	        		/* for (var i=item.length-1 ; i>-1; i--)
		        	{
		        		var ItemElement = item[i].element; 
			        	$('#jqxTree').jqxTree('removeItem', ItemElement);
			        } */	
	        	}
	        });
	        
		     $('#btn_GridAdd').on('click', function(){
		    	//$("#jqxgrid").jqxGrid("addrow", null, rows, 'first');
		    	
		    	// addrow?????? ??? ?????? ?????????
		    	var id = $('#jqxgrid').jqxGrid('getrowid', 0);
		    	
		    	// ?????? ?????? loca_cd ???????????? sensor_cd, loca_cd,loca_nm ????????????
	        	$.ajax({
   					url: <%=request.getContextPath() %>"/grid_add.do",
   					data: {"loca_cd": loca_cd, "sensor_cd": id},
   					//contentType : "application/json; charset=UTF-8",
   					dataType: "json",
   					type: "GET",
   					success: function(data){
						
   						
   						console.log(data);
   						var a = data[0].loca_cd;
   						var b = data[0].loca_nm;
   						var c = data[0].fnl_mdfc_dtm;
   						var e = data[0].sensor_cd;
   						
   						
   						
   						var y = c.substr(0, 4);
						var m = c.substr(4, 2);
						var d = c.substr(6, 2);
						var c = new Date(y,m-1,d);
						
						// ??? ?????????
						var rows = {
				    		LOCA_CD : a
				    		,LOCA_NM : b
				    		,SENSOR_CD : e
				    		,FNL_MDFC_DTM : c
				    		,ROW_TYPE : "I"
				            ,SENSOR_TYPE : ""
				            ,ALARM_IMPTANCE : ""
						} 
		            	
		             	$("#jqxgrid").jqxGrid("addrow", null, rows, 'first');
						//$("#jqxgrid").jqxGrid('setcellvalue', 'first', "ROW_TYPE", "I"); 
		             	$("#jqxgrid").jqxGrid('endupdate');
   						
   					}// success ???
    			});
		     });		     
		     
		     $('#btn_GridDel').on('click', function(){
		    	var rowindexes = $('#jqxgrid').jqxGrid('getselectedrowindexes');
		    	
		    	var delete_sensor_cd = [];
		    	
		    	for ( var i=0; i<rowindexes.length; i++)
		    	{
		    		delete_sensor_cd.push($('#jqxgrid').jqxGrid('getrowid', rowindexes[i]));
		    	}
		    	
		    	if (confirm('????????? ?????? ?????? ?????????????????????????'))
		    	{
		    		$.ajax({
						url: <%=request.getContextPath() %>"/grid_del.do",    // ajax ????????? url ??????
						data: {"items": delete_sensor_cd},   // controller?????? ??????????????? ?????? ?????? ?????????(?????? ???????????? ????????? ??? ????????? ????????? ??????)
						contentType : "application/json; charset=UTF-8",
						//dataType: "json",
						type: "GET",
						success: function(data){
							// ??? ??????
						    window.location.reload();
						}
			        });
			    	
		    	}
		    	
		     });

		     $('#btn_GridExcel').click( function(){
		    	 $("#jqxgrid").jqxGrid('exportdata', 'xlsx', 'jqxgrid');
		    	 
		     });
		     
		     
		    /*  $('#jqxgrid').on('rowclick',function(event){
      			var getRowData = $('#jqxgrid').jqxGrid('getrows')[event.args.rowindex];
 				
				
		     });
		     */
		     
<%-- 		     $("#jqxgrid").on('cellvaluechanged', function (event) 
    		 {
				// event arguments.
				var args = event.args;
				// column data field.
				var datafield = event.args.datafield;
				// row's bound index.
				var rowBoundIndex = args.rowindex;
				// new cell value.
				var value = args.newvalue;
				// old cell value.
				//var oldvalue = args.oldvalue;
				
				var getRowData = $('#jqxgrid').jqxGrid('getrows')[rowBoundIndex];
				
				if (datafield == "LOCA_NM")
				{
					$.ajax({
    					url: <%=request.getContextPath() %>"/grid_add.do",    // ajax ????????? url ??????
    					data: {"loca_nm": value},
    					//contentType : "application/json; charset=UTF-8",
    					dataType: "json",
    					type: "GET",
    					success: function(data){
    						
    						alert("");
    						location.reload();
    					}// success ???
    				});
				}
    		 }); --%>
		     
		     
		     // ?????? ?????? ?????? ?????????
		     $('#btn_Save').on('click', function(){
		    	 
		    	 var rows = $('#jqxgrid').jqxGrid('getrows');
		    	 
		    	 for (var i=0; i<rows.length; i++)
		    	 {
		    	
		    		// ROW_TYPE??? undefined??? ????????? 
		    		if ( rows[i].ROW_TYPE != undefined )
		    		{
		    			var row = {};
						
						 
						row["ROW_TYPE"] = rows[i].ROW_TYPE;
						row["LOCA_CD"] = rows[i].LOCA_CD;
						row["LOCA_NM"] = rows[i].LOCA_NM;
						row["SENSOR_CD"] = rows[i].SENSOR_CD;
						row["SENSOR_NM"] = rows[i].SENSOR_NM;
						row["SENSOR_TYPE"] = rows[i].SENSOR_TYPE;
						row["ALARM_IMPTANCE"] = rows[i].ALARM_IMPTANCE;
						row["ALARM_YN"] = rows[i].ALARM_YN;
						row["FNL_MDFC_DTM"] = rows[i].FNL_MDFC_DTM;
						row["SENSOR_COORD"] = rows[i].SENSOR_COORD;
						//row["SENSOR_ONOFF"] = data[i].sensor_onoff;
						
						changeData[changeData.length] = row;
						
						//changeData.push[row];
		    		}
		    	 }
		    	 var jsonData = JSON.stringify(changeData);
		    	 
		    	 $.ajax({
 					url: <%=request.getContextPath() %>"/grid_change.do",    // ajax ????????? url ??????
 					data: {"data": jsonData},
 					//contentType : "application/json; charset=UTF-8",
 					dataType: "json",
 					type: "GET",
 					success: function(data) {
 						alert("??");
 						
 					}// success ???
 				});
		     });
	    }); 

	</script>
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tree/Grid</title>
</head>
<body>

<!-- 
	1. ?????? tree : +,-
	2. ????????? grid : ??? ??????, ??? ??????, ?????? export
				????????? ????????? edit, checkbox(????????????,?????? ??????), combo, edit???????... ????????????, ????????? ??????
				????????? ?????? ??? ?????? ????????? ??????.. ?????? ??? ??? ????????? ??????
				????????? ??? 1,2,3 ???  , 1/10 ??????

 -->
<div>
	<div style = "float:left; width:66%">	
		????????????
		<input type="Button" id="loca_sensor" value='????????????' />
	</div>
	<div style = "float:right; width:34%">
		<input type="Button" id="btn_Save" value='??????'/>
		<input type="Button" id="refresh" value='????????????' onclick="location.reload()"/>
	</div>	
</div>
	
<div style="clear:left; width:100%; background:#ccc;">

	<div style="float:left; width:20%; height:500px;">
		<div style="float:left; width:98%;">
			<div style="float:left">
				<input type="Button" id="btn_TreeE" value='+'/>
		   		<input type="Button" id="btn_TreeC" value='-'/>
			</div>
			<div style="float:right">
				<input type="Button" id="btn_TreeAdd" value='??????'/>
				<input type="Button" id="btn_TreeUpdate" value='??????'/>
		   		<input type="Button" id="btn_TreeDel" value='??????'/>
			</div>
		</div>
		<br/>
		<div id='jqxTree'></div>
	</div>
	
	<div style="float:right; width:80%; height:500px;">
		<div id="btn_friends" style="visibility:hidden">
			<div style="float:left">
				<input type="Button" id="btn_GridAdd" value='?????????'/>
				<input type="Button" id="btn_GridDel" value='?????????'/>
				<input type="Button" id="btn_GridExcel" value='btn_Excel'/>
				
			</div>
			<div style="float:right; width:42.6%">
				
			</div>
			
			<br/>
		</div>
	    <!-- ????????? -->
	    <div id='jqxWidget' style="clear:left; font-size: 13px; font-family: Verdana; float: left;">
	    	<div id="jqxgrid"></div>
	    </div>
	</div>
</div>
	

	
	
</body>
</html>