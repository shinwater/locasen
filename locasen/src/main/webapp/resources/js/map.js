/*
 * overlay
 */
var overlay = new ol.Overlay({
  element: document.getElementById('overlay'),
  positioning: 'bottom-center'
});


var iconFeature1 = new ol.Feature({
    geometry: new ol.geom.Point([516, 472.5]),
    name: '보이지 않는 꿈의 섬'
});
var iconFeature2 = new ol.Feature({
    geometry: new ol.geom.Point([876, 334]),
    name: '보이지 않는 꿈의 섬'
});

var iconStyle = new ol.style.Style({
	  image: new ol.style.Icon({
	    anchor: [0.5, 46],
	    anchorXUnits: 'fraction',
	    anchorYUnits: 'pixels',
	    src: '/resources/js/styles/images/pointdot.png',
	  }),
});

iconFeature1.setStyle(iconStyle);
iconFeature2.setStyle(iconStyle);

var vectorSource = new ol.source.Vector({
  features: [iconFeature1,iconFeature2],
});

var vectorLayer = new ol.layer.Vector({
  source: vectorSource,
});

/*
 * 지도 생성
 */ 
/*var map = new ol.Map({
	// target: 지도를 표시할 영역의 id
	target:'map', 
	
	// layers: 표시할 내용이 담기는 부분
	layers: [
		new ol.layer.Tile({
			source: new ol.source.OSM()
		})
		//,vectorlayer
	],
	
	// 지도의 어느 영역을 보여줄것인지 설정
	view: new ol.View({
		
		//center: 지도의 중심좌표 설정 -> 지도가 화면에 표시될때 중심좌표 기준으로 표시 경도/위도
		center: ol.proj.fromLonLat([126.68, 37.54]),
		zoom: 13
	})
});*/



//import {getCenter} from 'ol/extent';

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
        url: '/resources/js/styles/images/star.png',
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
 * click 이벤트 콜백함수
 */
//register an event handler for the click event
map.on('click', function(event) {
  // extract the spatial coordinate of the click event in map projection units
  var coord = event.coordinate;
  // transform it to decimal degrees
  var degrees = ol.proj.transform(coord, 'EPSG:3857', 'EPSG:4326');
  // format a human readable version
  var hdms = ol.coordinate.toStringHDMS(degrees);
  // update the overlay element's content
  var element = overlay.getElement();
  
  element.innerHTML = hdms;
  // position the element (using the coordinate in the map's projection)
  overlay.setPosition(coord);
  // and add it to the map
  map.addOverlay(overlay);
	  
  //console.log(event);
 
var feature = map.forEachFeatureAtPixel(event.pixel, function (feature) {
	return feature;
});

 //var coordinates =  feature.getGeometry().getCoordinates();
  
  
  if (feature != undefined)
  {
	  document.getElementById("jqxgrid").style.display="block";
  }
  else
  {
	  document.getElementById("jqxgrid").style.display="none";
  }
});




