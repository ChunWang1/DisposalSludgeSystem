<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'map.jsp' starting page</title>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf8">

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico">
<link href="css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
<link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">

<link href="css/animate.css" rel="stylesheet">
<link href="css/style.css?v=4.1.0" rel="stylesheet">
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=5TmZTw10oplDe4ZehEM6UjnY6rDgocd8"></script>

<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style type="text/css">
.map {
	position: relative;
	color: #000;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.selectMenu {
	position: absolute;
	right: 20px;
	top: 5px;
}
.select {
   border: 1px solid #555;
    font-family : 微软雅黑;
    color:black;
    font-size: 15px;
    text-align: center;
    line-height: 1.2em;
	float: right;
	background: lavender;
	height:35px;
	width:80px;
	margin:auto auto 5px 10px;
}
.query_submit {
	border: 1px solid #555;
    padding: 0.5em;
    font-family : 微软雅黑;
    color:black;
    font-size: 15px;
    line-height: 1.2em;
	float: right;
	background: slateblue;
	height:35px;
	width:80px;
	text-align: center;
	margin:auto auto 5px 10px;
}
.text{
	border: 1px solid #555;
    padding: 0.5em;
    line-height: 1.2em;
	float: right;
	background: white;
	height:35px;
	width:200px;
	margin:auto auto 5px 10px;
}
.bottom_button {
	position: absolute;
	right: 2px;
	bottom: 0px;
}

.tablehead td {
	height: 10px;
	width: 10%;
	text-align: center;
	font-size: 12px;
	font-weight: 700;
	color: #4A708;
}

.tablelist td {
	height: 20px;
	width: 10%;
	text-align: center;
	font-size: 11px;
	font-weight: 600;
	color: #4A708;
}

.tablelist tr {
	cursor: pointer;
}
</style>
</head>

<body>
	<div id="allmap" class="map"></div>
	<div id="selectMenu" class="selectMenu">
			<table class="tb2" height="100%" cellspacing="0" cellpadding="0" width="100%" border="0"
				style=" margin-left: 0px;">
				<tr>
					<td>
						<select id="typeSelect" class="select">
							<option value="-1">-类型-</option>
							<option value="3">-站点-</option>
							<option value="0">-处理车-</option>
							<option value="1">-运输车-</option>
						</select>
					</td>
					<td>
						<select id="statusSelect" class="select">
							<option value="-1">-状态-</option>
						</select>
					</td>
					<td><input id="queryStr" type="text" placeholder="" class="text"> <span
						class="input-group-btn"></span>
					</td>

					<td align="center">
						<button type="button" class="query_submit" id="querysubmit">确认</button>
					</td>
				</tr>
			</table>
	</div>
	<div class="bottom_button">
	<ul class="nav navbar-top-links navbar-right">
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showSiteTable();"> <i class="fa fa-map-marker" style="color:#EE2C2C"></i> <span id="siteRedNum" class="label label-danger"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td style="width:20%;">编号</td>
							<td style="width:45%;">站点</td>
							<td style="width:15%;">污泥量</td>
							<td style="width:10%;">状态</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="siteTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showTreatmentCarTable();"> <i i class="fa fa-truck"  style="color:#FFD700"></i><span class="label label-warning" id="treatmentCarNum"></span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td>车牌号</td>
							<td>目的地</td>
							<td>状态</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="treatmentCarTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showCarrierTable();"> <i class="fa fa-truck"  style="color:#4D4D4D"></i> <span class="label label-warning" id="carrierNum">3</span> </a>
			<ul class="dropdown-menu dropdown-messages"
					style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td>车牌号</td>
							<td>目的地</td>
							<td>状态</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="carrierTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
		<li class="dropdown dropup"><a class="dropdown-toggle count-info" data-toggle="dropdown"
			href="#" onclick="showWareHouseTable();"><i i class="fa fa-cubes" style="color:#EE2C2C"></i></a>
			<ul class="dropdown-menu dropdown-messages" style="background: rgba(176,196,222,0.8);max-height:300px;overflow-y:auto;">
				<li>
					<table class="tablehead" border="0" cellspacing="0" cellpadding="0"
						style="width:100%">
						<tr>
							<td>子仓</td>
							<td>存储量</td>
							<td>剩余容量</td>
							<td>总容量</td>
						</tr>
					</table>
				</li>
				<li class="divider"></li>
				<li>
					<table id="wareHouseTable" class="tablelist" border="0" cellspacing="0" cellpadding="0"
							style="width:100%">
					</table>
				</li>
			</ul>
		</li>
	</ul>
	</div>
	
	<!-- 分配处理人Modal -->
	<div class="modal fade" id="dealSiteModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配处理人</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="dealSiteId" type="hidden"/>
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">处理人</span>
								<select	id="driverSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveSiteDealBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 分配站点Modal -->
	<div class="modal fade" id="dealCarModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">分配站点</h4>
				</div>
				<div class="modal-body">
					<!-- 用来存id -->
					<input id="dealCarId" type="hidden" />
					<form>
						<div class="form-group">
							<div class="input-group">
								<span class="input-group-addon">站点 </span>
								<select	id="siteSelect" class="form-control col-lg-4">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-l" data-dismiss="modal">取消</button>
					<button id="saveCarDealBtn" type="button" class="btn btn-primary">保存</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
	var map = new BMap.Map("allmap");
	window.map = map;
	//var point = new BMap.Point(112.971916, 28.197967);//长沙
	var point = new BMap.Point(114.126588,22.608209);//深圳

	map.addControl(new BMap.NavigationControl()); // 添加平移缩放控件
	map.addControl(new BMap.ScaleControl()); // 添加比例尺控件
	map.addControl(new BMap.OverviewMapControl()); //添加缩略地图控件
	map.enableScrollWheelZoom(); //启用滚轮放大缩小
	//	map.addControl(new BMap.MapTypeControl());          //添加地图类型控件
	map.disable3DBuilding();
	map.centerAndZoom(point, 12);
	map.setMapStyle({
		style : 'light'
	}); //设置地图样式
	var wareHouseName;
	var wareHousePoint;
	var wareHouseMarker;
	var wareHouseInfoWindow;
	var siteMarker = new Array();
	var sitePoint = new Array();
	var siteInfoWindow = new Array();
	var carMarker = new Array();
	var carPoint = new Array();
	var carInfoWindow = new Array();

	showMap(-1,-1);
	var interval=setInterval("showMap(-1,-1)",5000);
	showNum();
  	//setInterval("showMap()",3000);  //定时刷新map
  	//setInterval("showNum()",3000);  //定时刷新空闲车辆及待处理站点数量
  	
  	/***************************** 类型联动************************************* */
  	$("#typeSelect").change(function(){
  		var ts = $("#typeSelect").val();
		showMap(ts,-1);
  		if(ts == 3)
  		{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option><option value="0">正常</option><option value="1">处理中</option><option value="2">待处理</option>');
  			$("#queryStr").attr("placeholder","编号/站点名/Tel");
  		}
  		else if(ts == 0 || ts == 1)
  		{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option><option value="1">在途中</option><option value="4">返程中</option>');
  			$("#queryStr").attr("placeholder","车牌号/司机/Tel");
  		}
  		 else{
  			$("#statusSelect").empty();
  			$("#statusSelect").append('<option value="-1">-状态-</option>');
  			clearInterval(interval);
  			showMap(-1,-1);
  			interval=setInterval("showMap(-1,-1)",5000);
  		} 
  	});
    /***************************** 状态选择************************************* */
  	$("#statusSelect").change(function(){
  		if($("#typeSelect").val()==3){
  			var s=$("#statusSelect").val()
  			switch(s){
  				case '0':{
  					clearInterval(interval);
  					showMap(0,0);
  					interval=setInterval("showMap(0,0)",5000);
  					}
  					break;
  				case '1':{
  					clearInterval(interval);
  					showMap(0,1);
  					interval=setInterval("showMap(0,1)",5000);
  					}
  					break;
  				case '2':{
  					clearInterval(interval);
  					showMap(0,2);
  					interval=setInterval("showMap(0,2)",5000);
  					}
  					break;
  				default:{
  					clearInterval(interval);
  					showMap(0,-1);
  					interval=setInterval("showMap(0,-1)",5000);
  					}
  			}
  		}
  		if($("#typeSelect").val()==0 || ("#typeSelect").val()==1){
  			switch($("#statusSelect").val()){
  				case '1':{
	  				clearInterval(interval);
	  				showMap(1,1)
  					interval=setInterval("showMap(1,1)",5000);
  					}
  					break;
  				case '4':{
  					clearInterval(interval);
  					showMap(1,4);
  					interval=setInterval("showMap(1,4)",5000);
  					}
  					break;
  				default:{
  					clearInterval(interval);
  					showMap(1,-1);
  					interval=setInterval("showMap(1,-1)",5000);
  					}
  			}
  		}
  			
  	});
  	    /***************************** 输入框精确查找************************************* */
  	$("#querysubmit").click(function(){
  		var queryStr=$("#queryStr").val();
  		if($.trim(queryStr)==""){
  			clearInterval(interval);
  			showMap(-1,-1);
  			return;
  		}
  		if($("#typeSelect").val()==0){
  			//alert("站点查找:"+queryStr);
  			clearInterval(interval);
  			showMap(-1,-1);
  			$.ajax({
  				type : "POST",
  				url : "system/queryMapSite",
  				data : {"queryStr" : queryStr},
  				success : function(siteList) {
  					if(jQuery.isEmptyObject(siteList))
  						alert("查找失败");
  					else{
  						$.each(siteList,function(i, site) {
  							siteInfo(site);
  						});
  					}
  				}
  			});
  		}
  		if($("#typeSelect").val()==1){
  			//alert("车辆查找:"+queryStr);
  			clearInterval(interval);
  			showMap(-1,-1);
  			$.ajax({
  				type : "POST",
  				url : "car/queryMapCar",
  				data : {"queryStr" : queryStr},
  				success : function(carList) {
  					if(jQuery.isEmptyObject(carList))
  						alert("查找失败");
  					else{
  						$.each(carList,function(i, car) {
  							carInfo(car);
  						});
  					}
  				}
  			});
  		}
  		if($("#typeSelect").val()==-1){
  			alert("请选择类型！");
  		}
  	});
  	    
  	/***************************** 查询子智慧泥仓信息************************************* */  	
  	function queryWareHouse(){
  		var minorWareHouseList;
		$.ajax({
  			type : "POST",
  			url : "mudWareHouse/queryMinorWareHouse",
			async : false,
  			success : function(list) {
  				minorWareHouseList = list;
  			}
  		});
  		return minorWareHouseList;
  	}
  	
	/***************************** 查询站点信息************************************* */
	function queryMapSite(siteId,status){
		var sites;
		$.ajax({
  			type : "POST",
  			url : "system/querySiteMapBySiteIdAndStatus",
  			data : {
  				"siteId" : siteId,
  				"status" : status
  			},
			async : false,
  			success : function(list) {
  					sites = list;
  			}
  		});
  		return sites;
  	}
	
	/***************************** 查询站点处理进度************************************* */  	
  	function queryRateOfProcess(siteId){
  		var rate;
		$.ajax({
  			type : "POST",
  			url : "record/queryRateOfProcessBySiteId",
  			data : "siteId="+siteId,
			async : false,
  			success : function(result) {
  				rate = result;
  			}
  		});
  		return rate;
  	}
	
	/***************************** 查询站点预处理量************************************* */
  	function queryPretreatAmount(id){
  		var value;
		$.ajax({
  			type : "POST",
  			url : "record/queryCurrentPretreatAmountBySiteId",
  			data : "siteId="+id,
			async : false,
  			success : function(result) {
  				value = result;
  			}
  		});
  		return value;
  	}
  		
  	/***************************** 查询车辆************************************* */
	function queryMapCar(siteId,carType,status){
		var carList;
		$.ajax({
			type : "POST",
			url : "car/queryMapCarBySiteIdAndCarTypeAndStatus",
			data : {
				"siteId" : siteId,
				"carType" : carType,
				"status" : status
				},
			async : false,
			success : function(list) {
				carList = list;
			}
		});
		return carList;
	}
  	/***************************** 显示右下角空车及待处理站点数量************************************* */
	function showNum(){
  		$("#treatmentCarNum").text(queryMapCar(-1,0,0).length);
  		$("#carrierNum").text(queryMapCar(-1,1,0).length);
  		$("#siteRedNum").text(queryMapSite(-1,2).length);
	}
  	
  	/***************************** 显示主智慧泥仓************************************* */  	
  	function showWareHouse(){
		$.ajax({
  			type : "POST",
  			url : "mudWareHouse/queryMainWareHouse",
  			success : function(list) {
  				mainWareHouse = list[0];
  				wareHouseName = mainWareHouse.wareHouseName;
  				myIcon = new BMap.Icon("img/warehouse.png", new BMap.Size(90, 63), {
					imageSize : new BMap.Size(100, 70)});
  				wareHousePoint = new BMap.Point(mainWareHouse.longitude,mainWareHouse.latitude);
  				wareHouseMarker = new BMap.Marker(wareHousePoint,{icon:myIcon});
				
				map.addOverlay(wareHouseMarker);
				wareHouseMarker.addEventListener("mouseover",function(){
					wareHouseInfo()
				});
  			}
  		});
  	}
  	
	/***************************** 显示标注************************************* */
	function showMap(selectType,selectStatus) {
		map.clearOverlays(); //清除地图上所有覆盖物
		sitePoint=[];
		siteMarker=[];
		siteInfoWindow=[];
		carPoint=[];
		carMarker=[];
		carInfoWindow=[];
		
		showWareHouse();
		if(selectType==3||selectType==-1){
			siteList = queryMapSite(-1,selectStatus);
			if(!jQuery.isEmptyObject(siteList)){
				var myIcon;
				$.each(siteList,function(i, site) {
				if(selectStatus==site.status || selectStatus==-1){
					if (site.status== "0") {
						myIcon = new BMap.Icon("img/factory(green).png", new BMap.Size(90, 63), {
								imageSize : new BMap.Size(100, 70)});
					}
					else if (site.status== "1") {
						myIcon = new BMap.Icon("img/factory(yellow).png", new BMap.Size(90, 63), {
							imageSize : new BMap.Size(100, 70)});
					} 
					else if (site.status== "2") {
						myIcon = new BMap.Icon("img/factory(red).png", new BMap.Size(90, 63), {
							imageSize : new BMap.Size(100, 70)});
					} 
					sitePoint[site.id] = new BMap.Point(site.longitude,site.latitude);
					siteMarker[site.id] = new BMap.Marker(sitePoint[site.id],{icon:myIcon});
					
					map.addOverlay(siteMarker[site.id]);
					if(site.status=="2")
						siteMarker[site.id].setAnimation(BMAP_ANIMATION_BOUNCE);
					siteMarker[site.id].addEventListener("mouseover",function(){
					siteInfo(site)
					});
					}
				});
			}
		}
		if(selectType==0||selectType==1||selectType==-1){
			carList=queryMapCar(-1,selectType,selectStatus)
			if(!jQuery.isEmptyObject(carList)){
				$.each(carList,function(i, car) {
					if(car.carType == 0){
						var carIcon = new BMap.Icon("img/car.png", new BMap.Size(35, 24), 
										{imageSize : new BMap.Size(35, 24)});
					}else{
						var carIcon = new BMap.Icon("img/transportCar.png", new BMap.Size(35, 35), 
										{imageSize : new BMap.Size(35, 35)});
					}
					if(car.status==1||car.status==4){
						carPoint[car.id] = new BMap.Point(car.longitude,car.latitude);
						carMarker[car.id] = new BMap.Marker(carPoint[car.id],{icon:carIcon});
						
						map.addOverlay(carMarker[car.id]);
						
						//鼠标悬停动作
						carMarker[car.id].addEventListener("mouseover",function(){
							carInfo(car)
						});
					}
				});
			}
		}
	}
	
	/***************************** 泥仓信息框显示************************************* */
	function wareHouseInfo(){
		var opts = {width : 130, }// 信息窗口宽度
		minorWareHouseList = queryWareHouse();
		var lid = '<div><h5>'+wareHouseName+'</h5><table style="font-size:12px;">';
		$.each(minorWareHouseList,function(i, minorWareHouse){
			lid += '<tr><td style="width:40%;text-align: left;">'+minorWareHouse.serialNumber+'号仓:</td><td style="text-align: left;">'+minorWareHouse.remainCapacity+'/'+minorWareHouse.capacity+'</td></tr>';
		});
		lid += '</table>' + '</div>';
		wareHouseInfoWindow = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
		map.openInfoWindow(wareHouseInfoWindow, wareHousePoint);
		}
	
	/***************************** 站点信息框显示************************************* */
	function siteInfo(site){
		var value=-1;
		var opts = {width : 230, }// 信息窗口宽度
		var status;
		if (site.status== "0")
			status="正常";
		else if (site.status== "1")
			status="处理中";
		else if (site.status== "2"){
			$.ajax({
				type : "POST",
				url : "system/countRecordOfCarNullBySiteId",
				async: false,
				data : {"siteId" : site.id},
				success : function(result) {
					if(result==0)
						status="待处理(已分配)";
					else
						status="待处理(未分配)";
				}
			});
		}
		var lid = '<div><h5>'+site.siteName+'</h5><table style="font-size:12px;">';
		if(site.status=="1"){
			var rate = queryRateOfProcess(site.id);
			if(rate == -1){
				lid += '<tr><td style="width:40%;text-align: left;">处理进度：</td><td style="text-align: left;">数据异常</td></tr>';	
				}else{
				//处理进度
				rate = 100*rate;
				lid += '<tr><td style="width:40%;text-align: left;">处理进度：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">'+rate.toFixed(2)+'%</td></tr>';
			}
		}else if(site.status=="2"){
			var value = queryPretreatAmount(site.id);
			if(value == -1){
				lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left;">数据异常</td></tr>';	
				}else if(value == 0){
					lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">未设置</td></tr>';
				}else{
					//预处理量
					lid += '<tr><td style="width:40%;text-align: left;">预处理量：</td><td style="text-align: left; color: #1874CD; font-weight: bold;">'+value+'</td></tr>';
				}
		}
		lid += '<tr><td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'+site.telephone+'</td></tr>';
		if(site.status=="2")
			lid += '<tr onclick="dealSite('+site.id+');" style="color:#FF4500;cursor:pointer;"><td style="width:40%;text-align: left;">状态:</td><td style="text-align: left;">'+status+'</td></tr>'
		else
			lid += '<tr style="color:#FF4500;"><td style="width:40%;text-align: left;">状态:</td><td style="text-align: left;">'+status+'</td></tr>';
		lid += '</table>' + '</div>';
		siteInfoWindow[site.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
		map.openInfoWindow(siteInfoWindow[site.id], sitePoint[site.id]);
	}
		
	/***************************** 车辆信息框显示************************************* */
	function carInfo(car){
			var opts = {width : 230,} // 信息窗口宽度
			if(car.status==4)
				var lid = '<div><h5><a href="monitor/queryVideoByDriverId?driverId='+car.driverId+'">'+car.license+'(返程中)</a></h5><table style="font-size:12px;">';
			else
				var lid = '<div><h5><a href="monitor/queryVideoByDriverId?driverId='+car.driverId+'">'+car.license+'</a></h5><table style="font-size:12px;">';
									
			lid	+= '<tr><td style="width:40%;text-align: left;">司机：</td><td style="text-align: left;">'+car.driver.realname+'</td>'
				+ '</tr>'
				+ '<tr>'
				+ '<td style="width:40%;text-align: left;">Tel:</td><td style="text-align: left;">'+car.driver.telephone+'</td>'
				+ '</tr>';
			if(car.status==1){
				var pointSite = new BMap.Point(car.site.longitude,car.site.latitude);
				var driving = new BMap.DrivingRoute(map,
					{onSearchComplete:function(results){
						var plan=results.getPlan(0);
						lid += '<tr style="color:#FF4500;"><td style="width:40%;text-align: left;">目的地:</td><td style="text-align: left;">'+car.site.siteName+'</td></tr>';
						lid += '<tr><td style="width:40%;text-align: left;">预计到达:</td><td style="text-align: left;">'+plan.getDuration(true)+'</td></tr>';
						lid += '</table>' + '</div>';
						carInfoWindow[car.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
						map.openInfoWindow(carInfoWindow[car.id], carPoint[car.id]);
					}});		
				driving.search(carPoint[car.id],pointSite);
				//alert("目的地:"+car.site.longitude+","+car.site.latitude);
			}
			else{
				lid += '</table>' + '</div>';
				carInfoWindow[car.id] = new BMap.InfoWindow(lid,opts); // 创建信息窗口对象 
				map.openInfoWindow(carInfoWindow[car.id], carPoint[car.id]);
			}
		}
	
	/***************************** 右下角查询所有站点************************************* */
	function showSiteTable(){
	$("#siteTable").empty();
	$.ajax({
			type : "POST",
			url : "system/queryAllSite",
			dataType : "json",
			contentType : "application/json",
			success : function(siteList) {
				var table;
				$.each(siteList,function(i, site) {
					$.ajax({
						type : "POST",
						url : "system/queryUltrasonicValueBySite",
						data : {"sensorIdSet" : site.sensorIdSet},
						async: false,
						success : function(sensors) {
							var status;
							if (site.status== "0"){
								table='<tr id="'+ site.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
								status="正常";
							}
							else if (site.status== "1"){
								table='<tr id="'+ site.id +'" style="color:#FFFF00;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
								status="处理中";
							}
							else if (site.status== "2"){
								table='<tr id="'+ site.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(site).replace(/\"/g,"'")+')">';
								status="待处理";
							}				
							
							table += '<td style="width:20%;">' + site.serialNumber + '</td>';
							table += '<td style="width:45%;">' + site.siteName + '</td>';
							if(!jQuery.isEmptyObject(sensors)){
								{
									var value=-1;
									$.each(sensors,function(i, sensor) {
										if(sensor.typeId==2){
											var v=sensor.sensorValue.value;
											//alert(result.value);
											//污泥量
											value=100*(site.depth-v)/site.depth;
											table += '<td style="width:15%;">' + value.toFixed(2) + '%</td>';
											return false;
										}
									});
								}
							}
							else if(jQuery.isEmptyObject(sensors) || value==-1)
								table += '<td style="width:15%;">无数据</td>';
							table += '<td style="width:10%;">' + status + '</td>';
							table += '</tr>';
							$("#siteTable").append(table);
						}
					});
				});
			}
		});
	}
	
	/***************************** 右下角查询所有处理车************************************* */
	function showTreatmentCarTable(){
		$("#treatmentCarTable").empty();
		var table;
		carList = queryMapCar(-1,0,-1);
		$.each(carList,function(i, car){
			var status;
			if (car.status== "0"){
				table='<tr id="'+ car.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="空闲";
			}
			else if (car.status== "1"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="在途中";
			}
			else if (car.status== "2"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(car.site).replace(/\"/g,"'")+')">';
				status="处理中";
			}
			else if (car.status== "3"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="已派单";
			}
			else if (car.status== "4"){
				table='<tr id="'+ car.id +'" style="color:#FFFF00;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="返程";
			}
			table += '<td style="width:20%;">' + car.license + '</td>';
			if (!jQuery.isEmptyObject(car.site)){
				table += '<td style="width:45%;">' + car.site.siteName + '</td>';
			}
			else table += '<td style="width:45%;">' + status + '</td>';
			table += '<td style="width:25%;">' + status + '</td>';
			table += '</tr>';
			$("#treatmentCarTable").append(table);
		});
	}
	
	/***************************** 右下角查询所有运输车************************************* */
	function showCarrierTable(){
		$("#carrierTable").empty();
		var table;
		carList = queryMapCar(-1,1,-1);
		$.each(carList,function(i, car){
			var status;
			if (car.status== "0"){
				table='<tr id="'+ car.id +'" style="color:#FF0000;font-weight: 700;" onmouseover="sel(this)" onmouseout="cle(this)" onclick="wareHouseInfo();">';
				status="空闲";
			}
			else if (car.status== "1"){
				if(car.siteId != null && car.siteId != ""){
					table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
					status="在途中";
				}else{
					table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
					status="运输中";
				}
			}
			else if (car.status== "2"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showSiteInfo('+JSON.stringify(car.site).replace(/\"/g,"'")+')">';
				status="装箱中";
			}
			else if (car.status== "3"){
				table='<tr id="'+ car.id +'" onmouseover="sel(this)" onmouseout="cle(this)" onclick="showCarInfo('+JSON.stringify(car).replace(/\"/g,"'")+')">';
				status="已派单";
			}
			table += '<td style="width:20%;">' + car.license + '</td>';
			if (!jQuery.isEmptyObject(car.site)){
				table += '<td style="width:45%;">' + car.site.siteName + '</td>';
			}
			else table += '<td style="width:45%;">' + status + '</td>';
			table += '<td style="width:25%;">' + status + '</td>';
			table += '</tr>';
			$("#carrierTable").append(table);
		});
	}
	
	/***************************** 右下角智慧泥仓信息显示************************************* */
	function showWareHouseTable(){
		wareHouseInfo();
		$("#wareHouseTable").empty();
		var table;
		minorWareHouseList = queryWareHouse();
		$.each(minorWareHouseList,function(i, minorWareHouse){
			table='<tr id="'+ minorWareHouse.id +'" onmouseover="sel(this)" onmouseout="cle(this)")">';
			table += '<td>' + minorWareHouse.serialNumber + '号仓</td>';
			table += '<td>' + minorWareHouse.moistrueDegree*100 + '%</td>';
			table += '<td>' + minorWareHouse.remainCapacity + '</td>';
			table += '<td>' + minorWareHouse.capacity + '</td>';
			table += '</tr>';
			$("#wareHouseTable").append(table);
		});
	}
	
	/***************************** 列表鼠标响应************************************* */
	function showSiteInfo(site){
		clearInterval(interval);
		showMap(-1,-1);
		siteInfo(site);
	}
	function showCarInfo(car){
		clearInterval(interval);
		showMap(-1,-1);
		if(car.status== "2" || car.status== "3"){
			$.ajax({
  				type : "POST",
  				url : "system/queryMapSite",
  				data : {"queryStr" : car.site.siteName},
  				success : function(siteList) {
  					if(jQuery.isEmptyObject(siteList))
  						alert("定位失败");
  					else{
  						$.each(siteList,function(i, site) {
  							siteInfo(site);
  						});
  					}
  				}
  			});
		}
		else
			carInfo(car);
	}
	
	function sel(obj){
		obj.style.backgroundColor="rgba(70,130,180,0.3)";
	}
	function cle(obj){
		obj.style.backgroundColor="rgba(0, 0, 0, 0)";
	}
	
	/***************************** 任务分配************************************* */	
	function dealSite(siteId){
		$("#dealSiteId").val(siteId);
		$.ajax({
  				type : "POST",
  				url : "car/queryTreatmentCarUnassign",
  				success : function(carList) {
  					if(jQuery.isEmptyObject(carList))
  						alert("暂无空闲车辆");
  					else{
  						$("#driverSelect").empty();
  						$.each(carList,function(i, car) {
  							$("#driverSelect").append('<option id="'+car.id+'" value="'+car.id+'">'+car.driver.realname+'</option>')
  						});
  						$('#dealSiteModal').modal('show');
  					}
  				}
  			});
	}
	
	$("#saveSiteDealBtn").click(function (){
		var dealSiteId=$("#dealSiteId").val();
		var driverSelect=$("#driverSelect").val();
		$.ajax({
  			type : "POST",
  			url : "record/editRecordCarIdBySiteId",
  			data : {"siteId" : dealSiteId,
  					"carId" : driverSelect
  			},
  			success : function(result) {
				if(result.result=="success"){
 					alert("分配成功");
 					showNum();
 				}
  				else{
  					alert("分配失败");
				}
  			}
  		});
		$('#dealSiteModal').modal('hide');
	});
	
	function dealCar(carId){
	$("#dealCarId").val(carId);
		$.ajax({
  			type : "POST",
  			url : "record/queryRecordOfCarNull",
 			success : function(recordList) {
  				if(jQuery.isEmptyObject(recordList))
 					alert("暂无待处理站点");
  				else{
  					$("#siteSelect").empty();
  					$.each(recordList,function(i, record) {
  						$("#siteSelect").append('<option id="'+record.site.id+'" value="'+record.siteId+'">'+record.site.siteName+'</option>')
  					});
 					$('#dealCarModal').modal('show');
  				}
  			}
  		});
	}
	
	$("#saveCarDealBtn").click(function (){
		var dealSiteId=$("#siteSelect").val();
		var driverSelect=$("#dealCarId").val();
		$.ajax({
  			type : "POST",
  			url : "record/editRecordCarIdBySiteId",
  			data : {"siteId" : dealSiteId,
  					"carId" : driverSelect
  			},
  			success : function(result) {
				if(result.result=="success"){
 					alert("分配成功");
 					showNum();
 				}
  				else{
  					alert("分配失败");
				}
  			}
  		});
		$('#dealCarModal').modal('hide');
	});
	
</script>

