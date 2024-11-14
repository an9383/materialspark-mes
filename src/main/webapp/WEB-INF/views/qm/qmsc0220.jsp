<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%	pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">출하검사집계표</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; overflow: hidden;">
				<div class="card">
					<div class="row" style="margin-bottom: 10px;">
					&nbsp;&nbsp;&nbsp;&nbsp;<!-- <label class="input-label-sm"> 기간</label> -->
					<select class="custom-select mr-2" id="dateCheck" style="width:80px;">
						<option value="001">검사일</option>
						<option value="002">생산일</option>
					</select>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateFrom" />
							<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="chooseDateTo" />
							<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>							
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						<div style="margin-left: 10px;">
							<!-- <button type='button' class='btn btn-success' id='btnFakeExcel' disabled>엑셀 다운</button> -->
						</div>
						
<!-- 						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">자재명</label><select  class="custom-select" id="matrlCd" style="min-width:100px;"></select> -->
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">검색 : </label>
						<input type="search" class="form-control form-control-sm search" onsearch="textSearch($(this).val())">
					</div>
					<br>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">일자별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">설비별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">기간별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">제품별</a></li>
						</ul>
					</div>
					<!-- 일자별탭 -->
					<div class="mt-2" id="dateDiv">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="shipInsSumDateTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">일자</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">주야구분</th>							
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">검사LOT</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">검사수량</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">합격LOT</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">합격수량</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">불량LOT</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">불량수량</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">LOT합격율</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">시료수</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">불량수</th>
										<th rowspan="2" style="vertical-align: middle;min-width: 70px;" class="text-center">시료불량율</th>
				                        <th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="metalDateHd">메탈부 불량</th>
										<th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="filmDateHd">필름부 불량</th>										
					
									</tr>
									<tr id="shipDateHd">
									</tr>
								</thead>	
									<tfoot>
									<tr>
										<td>합계</td>
										<td colspan="" style="text-align: center"></td>	
										<td colspan="" id="sumCheckLot1" style="text-align: right">0</td>
										<td colspan="" id="sumCheckQty1" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessLot1" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessQty1" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyLot1" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyQty1" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessPercent1" style="text-align: right">0</td>
										<td colspan="" id="sumSyryo1" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty1" style="text-align: right">0</td>
										<td colspan="" id="sumSyryoPercent1" style="text-align: right">0</td>										
										<c:forEach var="item" begin="1" end="140" step="1">
									        <td colspan="" id="faulty${item}" style="text-align: right">0</td>	
								    	</c:forEach>
								    </tr>
									</tfoot>
								
							</table>
						</div>
					</div>
					<!-- 설비별탭 -->
					<div class="mt-2 d-none" id="equipDiv">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="shipInsSumEquipTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">설비명</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">검사LOT</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">검사수량</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">합격LOT</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">합격수량</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">불량LOT</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">불량수량</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">LOT합격율</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">시료수</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">불량수</th>
										<th rowspan="2" style="vertical-align: middle; min-width: 70px;" class="text-center">시료불량율</th>
				                        <th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="metalEquipHd">메탈부 불량</th>
										<th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="filmEquipHd">필름부 불량</th>
									</tr>
									<tr id="shipEquipHd">
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td>합계</td>									
										<td colspan="" id="sumCheckLot2" style="text-align: right">0</td>
										<td colspan="" id="sumCheckQty2" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessLot2" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessQty2" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyLot2" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyQty2" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessPercent2" style="text-align: right">0</td>
										<td colspan="" id="sumSyryo2" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty2" style="text-align: right">0</td>
										<td colspan="" id="sumSyryoPercent2" style="text-align: right">0</td>										
										<c:forEach var="item" begin="1" end="140" step="1">
									        <td colspan="" id="equipfaulty${item}" style="text-align: right">0</td>	
								    	</c:forEach>
								    </tr>
									</tfoot>
							</table>
						</div>
					</div>
					<!-- 기간별탭 -->
					<div class="mt-2 d-none" id="periodDiv">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="shipInsSumPeriodTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="vertical-align: middle;  min-width: 70px;" class="text-center">일자</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">검사LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">검사수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">합격LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">합격수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">LOT합격율</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">시료수</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량수</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">시료불량율</th>
				                        <th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="metalPeriodHd">메탈부 불량</th>
										<th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="filmPeriodHd">필름부 불량</th>
									</tr>
									<tr id="shipPeriodHd">
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td>합계</td>									
										<td colspan="" id="sumCheckLot3" style="text-align: right">0</td>
										<td colspan="" id="sumCheckQty3" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessLot3" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessQty3" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyLot3" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyQty3" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessPercent3" style="text-align: right">0</td>
										<td colspan="" id="sumSyryo3" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty3" style="text-align: right">0</td>
										<td colspan="" id="sumSyryoPercent3" style="text-align: right">0</td>										
										<c:forEach var="item" begin="1" end="140" step="1">
									        <td colspan="" id="periodfaulty${item}" style="text-align: right">0</td>	
								    	</c:forEach>
								    </tr>
									</tfoot>
							</table>							
						</div>
					</div>
					<!-- 제품별탭 -->
					<div class="mt-2 d-none" id="itemDiv">
						<div class="table-responsive" style="padding-bottom: 10px;">
							<table id="shipInsSumItemTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th rowspan="2" style="vertical-align: middle;  min-width: 70px;" class="text-center">제품명</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">검사LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">검사수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">합격LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">합격수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량LOT</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량수량</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">LOT합격율</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">시료수</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">불량수</th>
										<th rowspan="2"  style="vertical-align: middle; min-width: 70px;" class="text-center">시료불량율</th>
				                        <th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="metalGoodsHd">메탈부 불량</th>
										<th colspan="1" style="min-width: 70px;" class="text-center" class="text-center" id="filmGoodsHd">필름부 불량</th>
									</tr>
									<tr id="shipGoodsHd">
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td>합계</td>									
										<td colspan="" id="sumCheckLot4" style="text-align: right">0</td>
										<td colspan="" id="sumCheckQty4" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessLot4" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessQty4" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyLot4" style="text-align: right">0</td>
										<td colspan="" id="sumFaultyQty4" style="text-align: right">0</td>
										<td colspan="" id="sumSuccessPercent4" style="text-align: right">0</td>
										<td colspan="" id="sumSyryo4" style="text-align: right">0</td>
										<td colspan="" id="sumFaulty4" style="text-align: right">0</td>
										<td colspan="" id="sumSyryoPercent4" style="text-align: right">0</td>										
										<c:forEach var="item" begin="1" end="140" step="1">
									        <td colspan="" id="goodsfaulty${item}" style="text-align: right">0</td>	
								    	</c:forEach>
								    </tr>
								</tfoot>
							</table>
						</div>
					</div>
					
				</div>
			</div>
			<!-- /.left-list -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'qmsc0220';
	let currentHref = 'qmsc0220';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","출하검사집계표");

	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDate}";
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);

	let factoryCode = "<%=factoryCode%>";
	
	
	let shipInsSumEquipTable;
	let shipInsSumPeriodTable;
	let shipInsSumItemTable;
	let shipInsSumDateTable;
	
	let selectedTab = "date";
	let selectedTable = shipInsSumDateTable;
	
	// 공통코드 시작 -------
	var metalFaultyCd=new Array();	// (양)메탈류불량
	var filmFaultyCd=new Array();	// (양)필름류불량
    <c:forEach items="${faultyCd}" var="info">
	    if ("${info.etc1}" == "001") {
			var json=new Object();
			json.baseCd="${info.baseCd}";
			json.baseCdNm="${info.baseCdNm}";
			metalFaultyCd.push(json);
    	} else if ("${info.etc1}" == "002") {
			var json=new Object();
			json.baseCd="${info.baseCd}";
			json.baseCdNm="${info.baseCdNm}";
			filmFaultyCd.push(json);
        }
    </c:forEach>
    
    var goodsFaultyBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${goodsFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyBigNameCd.push(json);
    </c:forEach>
    
	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		json.etc4="${info.etc4}";
		json.etc5="${info.etc5}";		
		systemCommonCode.push(json);
    </c:forEach>
    
   
    $('#metalDateHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmDateHd').text(goodsFaultyBigNameCd[1].baseCdNm);

	$('#metalEquipHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmEquipHd').text(goodsFaultyBigNameCd[1].baseCdNm);

	$('#metalPeriodHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmPeriodHd').text(goodsFaultyBigNameCd[1].baseCdNm);

	$('#metalGoodsHd').text(goodsFaultyBigNameCd[0].baseCdNm);
	$('#filmGoodsHd').text(goodsFaultyBigNameCd[1].baseCdNm);
	
	dateHeaderCreate();
	equipHeaderCreate();
	periodHeaderCreate();
	goodsHeaderCreate();
	// --------- 공통코드 끝
	
	// ------------- 행 추가
	//addFaultyRow("shipInsSumDateTable");
	//addFaultyRow("shipInsSumEquipTable");
	//addFaultyRow("shipInsSumPeriodTable");
	//addFaultyRow("shipInsSumItemTable");
	
	// 행 추가 끝 ----------
	
	
	
	// 목록 시작 -----------
	// 일자별탭
 	$.fn.dataTable.ext.errMode = 'none';
 	shipInsSumDateTable = $('#shipInsSumDateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
 		if(techNote == 7) {
 			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
 			location.href = "/";
 		}
 	}).DataTable({
         dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
 		"<'row'<'col-sm-12'tr>>" +
 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
 		language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 2
        },
        
		scrollCollapse: true,
        pageLength: 16,
         ajax: {
             url: '<c:url value="/qm/shipInspTotalDateList"/>',
             type: 'GET',
             data: {
             	'menuAuth'	 		: menuAuth,
             	'chooseDateFrom'	: function() { return $('#chooseDateFrom').val().replace(/-/g,""); },
 	           	'chooseDateTo'		: function() { return $('#chooseDateTo').val().replace(/-/g,""); },
 	           	'dateCheck'			: function() { return $('#dateCheck').val(); },
             },
         },
         columns: [
         	{
             	render: function(data, type, row) {
					return moment(row['inspDate']).format('YYYY-MM-DD');
				}
			},
         	{ data: 'dayNightCd',
         		render: function(data, type, row) {
             		if(data == 'D'){
						return "주간";
                 	} else{
                 		return "야간";
                     }					
				}
			 },
         	{ data: 'checkLot' },
         	{ data: 'checkQty' },
         	{ data: 'successLot' },
         	{ data: 'successQty' },
         	
         	{ data: 'faultyLot' },
         	{ data: 'faultyQty' },
         	{ data: 'successPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },
         	/* {
         		render: function(data, type, row) {
        			return parseFloat((parseInt(row['successQty']))/row['checkQty']*100).toFixed(2) + " %";
				}
            }, */
         	{ data: 'syryo' },
         	{ data: 'faultyCnt' },
         	{ data: 'syryoFaultyPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },       
         	<c:forEach var="item" begin="1" end="140" step="1">
	         	{ data: 'faulty${item}' ,
	        		render: function(data, type, row) {
	        			if(data == 'null'){
	                		return data = 0;
	                	} else{
	                		return addCommas(data);
	                    }		
	        		}
	    		},    		
    		</c:forEach>
        
         ],
         columnDefs: [             
        	{ targets: [0,1,8,11], className: 'text-center' },
         	{ targets: "_all", className: 'text-right' }, 
         	{
         		targets: "_all"
         		, render: function(data, type, row) {
         			  if (type === "display" && typeof data === "number") {
         				 return $.fn.dataTable.render.number( ',' );
         			  } else {
         				  return data;
         			  }
         		}
         	},
			
         ],
         buttons: [
             { extend: 'copy',
                 title: '출하검사집계-일자별' },
             { extend: 'excel',
                 title: '출하검사집계-일자별'},
             { extend: 'print',
                 title: '출하검사집계-일자별' },
         ],
         drawCallback : function( settings ) {
        	$('#shipInsSumDateTable tfoot').remove();
 			$('#shipInsSumDateTable').attr('style', 'margin-top: -1px !important;');
 			//전역변수들
 			
 			let  sumCheckLot1         = $('#shipInsSumDateTable').DataTable().column(2,{ page: 'all'} ).data().sum();
 			let  sumCheckQty1         = $('#shipInsSumDateTable').DataTable().column(3,{ page: 'all'} ).data().sum();
 			let  sumSuccessLot1       = $('#shipInsSumDateTable').DataTable().column(4,{ page: 'all'} ).data().sum();
 			let  sumSuccessQty1       = $('#shipInsSumDateTable').DataTable().column(5,{ page: 'all'} ).data().sum();
 			let  sumFaultyLot1        = $('#shipInsSumDateTable').DataTable().column(6,{ page: 'all'} ).data().sum();
 			let  sumFaultyQty1        = $('#shipInsSumDateTable').DataTable().column(7,{ page: 'all'} ).data().sum(); 			
 			let  sumSyryo1            = $('#shipInsSumDateTable').DataTable().column(9,{ page: 'all'} ).data().sum();
 			let  sumFaulty1           = $('#shipInsSumDateTable').DataTable().column(10,{ page: 'all'} ).data().sum();
 		

 			let sumSuccessPercent1   = 100 * sumSuccessQty1 / sumCheckQty1;  
 			let sumSyryoPercent1      = 100 * sumFaulty1 / sumSyryo1;
			


			$('#sumCheckLot1').html(addCommas(sumCheckLot1));
			$('#sumCheckQty1').html(addCommas(sumCheckQty1));
			$('#sumSuccessLot1').html(addCommas(sumSuccessLot1));
			$('#sumSuccessQty1').html(addCommas(sumSuccessQty1));
			
			$('#sumFaultyLot1').html(addCommas(sumFaultyLot1));
			
            $('#sumFaultyQty1').html(addCommas(sumFaultyQty1));
            $('#sumSyryo1').html(addCommas(sumSyryo1));
            $('#sumFaulty1').html(addCommas(sumFaulty1));
			$('#sumSuccessPercent1').html(sumSuccessPercent1.toFixed(2) + "%");
			$('#sumSyryoPercent1').html(sumSyryoPercent1.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let shipInsSumDateArray = new Array();
			
            for(var i=0; i<140; i++){
            	shipInsSumDateArray[i] = $('#shipInsSumDateTable').DataTable().column( (12+i) ,{ page: 'all'}).data().sum();	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#faulty'+ (i+1) ).html(addCommas(shipInsSumDateArray[i]));
			}

			$('#shipInsSumDateTable_wrapper thead th').css('vertical-align','middle');

		
	   
        },
     });
 	

 	//외관검사
	columnVisibleFun('shipInsSumDateTable', systemCommonCode.length, shipInsSumDateTable);

	// 설비별탭
	$.fn.dataTable.ext.errMode = 'none';
	shipInsSumEquipTable = $('#shipInsSumEquipTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
		language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 1
        },
        
		scrollCollapse: true,
        pageLength: 16,
        ajax: {
            url: '<c:url value="/qm/shipInspTotalEquipList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: menuAuth,
            	'chooseDateFrom'	: function() { return moment($('#chooseDateFrom').val()).format("YYYYMMDD") },
	           	'chooseDateTo'		: function() { return moment($('#chooseDateTo').val()).format("YYYYMMDD"); },
	        	'dateCheck'			: function() { return $('#dateCheck').val(); },
            },
        },
        columns: [
        	{ data: 'equipNm' },        
        	{ data: 'checkLot' },         
         	{ data: 'checkQty' },
         	{ data: 'successLot' },
         	{ data: 'successQty' },
         	
         	{ data: 'faultyLot' },
         	{ data: 'faultyQty' },
         	{ data: 'successPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },         	
         	{ data: 'syryo' },
         	{ data: 'faultyCnt' },
         	{ data: 'syryoFaultyPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },     
        	
        	<c:forEach var="item" begin="1" end="140" step="1">
        	
         	{ data: 'faulty${item}' ,
        		render: function(data, type, row) {
        			if(data == 'null'){
                		return data = 0;
                	} else{
                		return addCommas(data);
                    }		
        		}
    		},    		
			</c:forEach>
        ],
        columnDefs: [             
        	{ targets: [0,7,10], className: 'text-center' },
         	{ targets: "_all", className: 'text-right' }, 
         	//{ targets: "_all", render: $.fn.dataTable.render.number( ',' ) },
         	{
         		targets: "_all"
         		, render: function(data, type, row) {
         			  if (type === "display" && typeof data === "number") {
         				 return $.fn.dataTable.render.number( ',' );
         			  } else {
         				  return data;
         			  }
         		}
         	},
			
         ],
         buttons: [
             { extend: 'copy',
                 title: '출하검사집계-설비별' },
             { extend: 'excel',
                 title: '출하검사집계-설비별'},
             { extend: 'print',
                 title: '출하검사집계-설비별' },
         ],
        drawCallback : function( settings ) {

        	$('#shipInsSumEquipTable tfoot').remove();
 			$('#shipInsSumEquipTable').attr('style', 'margin-top: -1px !important;');
 			//전역변수들
 			
 			let sumCheckLot1         = $('#shipInsSumEquipTable').DataTable().column(1,{ page: 'all'} ).data().sum();
 			let sumCheckQty1         = $('#shipInsSumEquipTable').DataTable().column(2,{ page: 'all'} ).data().sum();
 			let sumSuccessLot1       = $('#shipInsSumEquipTable').DataTable().column(3,{ page: 'all'} ).data().sum();
 			let sumSuccessQty1       = $('#shipInsSumEquipTable').DataTable().column(4,{ page: 'all'} ).data().sum();
 			let sumFaultyLot1        = $('#shipInsSumEquipTable').DataTable().column(5,{ page: 'all'} ).data().sum();
 			let sumFaultyQty1        = $('#shipInsSumEquipTable').DataTable().column(6,{ page: 'all'} ).data().sum(); 			
 			let sumSyryo1            = $('#shipInsSumEquipTable').DataTable().column(8,{ page: 'all'} ).data().sum();
 			let sumFaulty1           = $('#shipInsSumEquipTable').DataTable().column(9,{ page: 'all'} ).data().sum();
 		

 			let  sumSuccessPercent1   = 100 * sumSuccessQty1 / sumCheckQty1;  
 			let  sumSyryoPercent1      = 100 * sumFaulty1 / sumSyryo1;
			


			$('#sumCheckLot2').html(addCommas(sumCheckLot1));
			$('#sumCheckQty2').html(addCommas(sumCheckQty1));
			$('#sumSuccessLot2').html(addCommas(sumSuccessLot1));
			$('#sumSuccessQty2').html(addCommas(sumSuccessQty1));
			$('#sumFaultyLot2').html(addCommas(sumFaultyLot1));
            $('#sumFaultyQty2').html(addCommas(sumFaultyQty1));
            $('#sumSyryo2').html(addCommas(sumSyryo1));
            $('#sumFaulty2').html(addCommas(sumFaulty1));
			$('#sumSuccessPercent2').html(sumSuccessPercent1.toFixed(2) + "%");
			$('#sumSyryoPercent2').html(sumSyryoPercent1.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let shipInsSumEquipArray = new Array();
			
            for(var i=0; i<140; i++){
            	shipInsSumEquipArray[i] = $('#shipInsSumEquipTable').DataTable().column( (11+i) ,{ page: 'all'}).data().sum();	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#equipfaulty'+ (i+1) ).html(addCommas(shipInsSumEquipArray[i]));
			}

			$('#shipInsSumEquipTable_wrapper thead th').css('vertical-align','middle');

		
       	},
    });

	//외관검사
	columnVisibleFun2('shipInsSumEquipTable', systemCommonCode.length, shipInsSumEquipTable);

	// 기간별탭
 	$.fn.dataTable.ext.errMode = 'none';
 	shipInsSumPeriodTable = $('#shipInsSumPeriodTable').on( 'error.dt', function ( e, settings, techNote, message ) {
 		if(techNote == 7) {
 			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
 			location.href = "/";
 		}
 	}).DataTable({
         dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
 		"<'row'<'col-sm-12'tr>>" +
 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
 		language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 1
        },
        
		scrollCollapse: true,
        pageLength: 16,
         ajax: {
             url: '<c:url value="/qm/shipInspTotalDayList"/>',
             type: 'GET',
             data: {
             	'menuAuth'	 		: menuAuth,
             	'chooseDateFrom'	: function() { return $('#chooseDateFrom').val().replace(/-/g,""); },
 	           	'chooseDateTo'		: function() { return $('#chooseDateTo').val().replace(/-/g,""); },
 	       		'dateCheck'			: function() { return $('#dateCheck').val(); },
             },
         },
         columns: [
        	 {
              	render: function(data, type, row) {
 					return moment(row['inspDate']).format('YYYY-MM-DD');
 				}
 			},         	
         	{ data: 'checkLot' },
         	{ data: 'checkQty' },
         	{ data: 'successLot' },
         	{ data: 'successQty' },
         	
         	{ data: 'faultyLot' },
         	{ data: 'faultyQty' },
         	{ data: 'successPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },
         	/* {
         		render: function(data, type, row) {
        			return parseFloat((parseInt(row['successQty']))/row['checkQty']*100).toFixed(2) + " %";
				}
            }, */
         	{ data: 'syryo' },
         	{ data: 'faultyCnt' },
         	{ data: 'syryoFaultyPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },       
         	<c:forEach var="item" begin="1" end="140" step="1">
	         	{ data: 'faulty${item}' ,
	        		render: function(data, type, row) {
	        			if(data == 'null'){
	                		return data = 0;
	                	} else{
	                		return addCommas(data);
	                    }		
	        		}
	    		},    		
    		</c:forEach>
        
         ],
         columnDefs: [             
        	{ targets: [0,7,10], className: 'text-center' },
         	{ targets: "_all", className: 'text-right' }, 
         	//{ targets: "_all", render: $.fn.dataTable.render.number( ',' ) },
         	{
         		targets: "_all"
         		, render: function(data, type, row) {
         			  if (type === "display" && typeof data === "number") {
         				 return $.fn.dataTable.render.number( ',' );
         			  } else {
         				  return data;
         			  }
         		}
         	},
			
         ],
         buttons: [
             { extend: 'copy',
                 title: '출하검사집계-기간별' },
             { extend: 'excel',
                 title: '출하검사집계-기간별'},
             { extend: 'print',
                 title: '출하검사집계-기간별' },
         ],
         drawCallback : function( settings ) {
        	$('#shipInsSumPeriodTable tfoot').remove();
 			$('#shipInsSumPeriodTable').attr('style', 'margin-top: -1px !important;');
 			//전역변수들
 			
 			let  sumCheckLot1         = $('#shipInsSumPeriodTable').DataTable().column(1,{ page: 'all'} ).data().sum();
 			let  sumCheckQty1         = $('#shipInsSumPeriodTable').DataTable().column(2,{ page: 'all'} ).data().sum();
 			let  sumSuccessLot1       = $('#shipInsSumPeriodTable').DataTable().column(3,{ page: 'all'} ).data().sum();
 			let  sumSuccessQty1       = $('#shipInsSumPeriodTable').DataTable().column(4,{ page: 'all'} ).data().sum();
 			let  sumFaultyLot1        = $('#shipInsSumPeriodTable').DataTable().column(5,{ page: 'all'} ).data().sum();
 			let  sumFaultyQty1        = $('#shipInsSumPeriodTable').DataTable().column(6,{ page: 'all'} ).data().sum(); 			
 			let  sumSyryo1            = $('#shipInsSumPeriodTable').DataTable().column(8,{ page: 'all'} ).data().sum();
 			let  sumFaulty1           = $('#shipInsSumPeriodTable').DataTable().column(9,{ page: 'all'} ).data().sum();
 		

 			let sumSuccessPercent1   = 100 * sumSuccessQty1 / sumCheckQty1;  
 			let sumSyryoPercent1      = 100 * sumFaulty1 / sumSyryo1;
			


			$('#sumCheckLot3').html(addCommas(sumCheckLot1));
			$('#sumCheckQty3').html(addCommas(sumCheckQty1));
			$('#sumSuccessLot3').html(addCommas(sumSuccessLot1));
			$('#sumSuccessQty3').html(addCommas(sumSuccessQty1));
			$('#sumFaultyLot3').html(addCommas(sumFaultyLot1));
            $('#sumFaultyQty3').html(addCommas(sumFaultyQty1));
            $('#sumSyryo3').html(addCommas(sumSyryo1));
            $('#sumFaulty3').html(addCommas(sumFaulty1));
			$('#sumSuccessPercent3').html(sumSuccessPercent1.toFixed(2) + "%");
			$('#sumSyryoPercent3').html(sumSyryoPercent1.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let shipInsSumPeriodArray = new Array();
			
            for(var i=0; i<140; i++){
            	shipInsSumPeriodArray[i] = $('#shipInsSumPeriodTable').DataTable().column( (11+i) ,{ page: 'all'}).data().sum();	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#periodfaulty'+ (i+1) ).html(addCommas(shipInsSumPeriodArray[i]));
			}

			$('#shipInsSumPeriodTable_wrapper thead th').css('vertical-align','middle');

		
	   
        },
     });

 	//외관검사
	columnVisibleFun2('shipInsSumPeriodTable', systemCommonCode.length, shipInsSumPeriodTable);

	// 제품별탭
 	$.fn.dataTable.ext.errMode = 'none';
 	shipInsSumItemTable = $('#shipInsSumItemTable').on( 'error.dt', function ( e, settings, techNote, message ) {
 		if(techNote == 7) {
 			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
 			location.href = "/";
 		}
 	}).DataTable({
         dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
 		"<'row'<'col-sm-12'tr>>" +
 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",  
 		language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
//         scrollY : "56vh",
        lengthChange: false,

        scrollX: true,
        fixedColumns: {
        	 leftColumns: 1
        },
        
		scrollCollapse: true,
        pageLength: 16,
         ajax: {
             url: '<c:url value="/qm/shipInspTotalGoodsList"/>',
             type: 'GET',
             data: {
             	'menuAuth'	 		: menuAuth,
             	'chooseDateFrom'	: function() { return $('#chooseDateFrom').val().replace(/-/g,""); },
 	           	'chooseDateTo'		: function() { return $('#chooseDateTo').val().replace(/-/g,""); },
 	       	'dateCheck'			: function() { return $('#dateCheck').val(); },
             },
         },
         columns: [
        	{ data: 'goodsNm' },        	
         	{ data: 'checkLot' },
         	{ data: 'checkQty' },
         	{ data: 'successLot' },
         	{ data: 'successQty' },
         	
         	{ data: 'faultyLot' },
         	{ data: 'faultyQty' },
         	{ data: 'successPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },
         	/* {
         		render: function(data, type, row) {
        			return parseFloat((parseInt(row['successQty']))/row['checkQty']*100).toFixed(2) + " %";
				}
            }, */
         	{ data: 'syryo' },
         	{ data: 'faultyCnt' },
         	{ data: 'syryoFaultyPercent',
         		render: function(data, type, row) {
        			return parseFloat(data).toFixed(2) + " %";
				}
			 },       
         	<c:forEach var="item" begin="1" end="140" step="1">
	         	{ data: 'faulty${item}' ,
	        		render: function(data, type, row) {
	        			if(data == 'null'){
	                		return data = 0;
	                	} else{
	                		return addCommas(data);
	                    }		
	        		}
	    		},    		
    		</c:forEach>
        
         ],
         columnDefs: [             
        	{ targets: [0,7,10], className: 'text-center' },
         	{ targets: "_all", className: 'text-right' }, 
         	//{ targets: "_all", render: $.fn.dataTable.render.number( ',' ) },
         	{
         		targets: "_all"
         		, render: function(data, type, row) {
         			  if (type === "display" && typeof data === "number") {
         				 return $.fn.dataTable.render.number( ',' );
         			  } else {
         				  return data;
         			  }
         		}
         	},
			
         ],
         buttons: [
             { extend: 'copy',
                 title: '출하검사집계-제품별' },
             { extend: 'excel',
                 title: '출하검사집계-제품별'},
             { extend: 'print',
                 title: '출하검사집계-제품별' },
         ],
         drawCallback : function( settings ) {
        	$('#shipInsSumItemTable tfoot').remove();
 			$('#shipInsSumItemTable').attr('style', 'margin-top: -1px !important;');
 			//전역변수들
 			
 			let  sumCheckLot1         = $('#shipInsSumItemTable').DataTable().column(1,{ page: 'all'} ).data().sum();
 			let  sumCheckQty1         = $('#shipInsSumItemTable').DataTable().column(2,{ page: 'all'} ).data().sum();
 			let  sumSuccessLot1       = $('#shipInsSumItemTable').DataTable().column(3,{ page: 'all'} ).data().sum();
 			let  sumSuccessQty1       = $('#shipInsSumItemTable').DataTable().column(4,{ page: 'all'} ).data().sum();
 			let  sumFaultyLot1        = $('#shipInsSumItemTable').DataTable().column(5,{ page: 'all'} ).data().sum();
 			let  sumFaultyQty1        = $('#shipInsSumItemTable').DataTable().column(6,{ page: 'all'} ).data().sum(); 			
 			let  sumSyryo1            = $('#shipInsSumItemTable').DataTable().column(8,{ page: 'all'} ).data().sum();
 			let  sumFaulty1           = $('#shipInsSumItemTable').DataTable().column(9,{ page: 'all'} ).data().sum();
 		

 			let sumSuccessPercent1   = 100 * sumSuccessQty1 / sumCheckQty1;  
 			let sumSyryoPercent1      = 100 * sumFaulty1 / sumSyryo1;
			


			$('#sumCheckLot4').html(addCommas(sumCheckLot1));
			$('#sumCheckQty4').html(addCommas(sumCheckQty1));
			$('#sumSuccessLot4').html(addCommas(sumSuccessLot1));
			$('#sumSuccessQty4').html(addCommas(sumSuccessQty1));
			$('#sumFaultyLot4').html(addCommas(sumFaultyLot1));
            $('#sumFaultyQty4').html(addCommas(sumFaultyQty1));
            $('#sumSyryo4').html(addCommas(sumSyryo1));
            $('#sumFaulty4').html(addCommas(sumFaulty1));
			$('#sumSuccessPercent4').html(sumSuccessPercent1.toFixed(2) + "%");
			$('#sumSyryoPercent4').html(sumSyryoPercent1.toFixed(2) + "%");

			//컬럼 추가 시 for문 도 수정
			let shipInsSumGoodsArray = new Array();
			
            for(var i=0; i<140; i++){
            	shipInsSumGoodsArray[i] = $('#shipInsSumItemTable').DataTable().column( (11+i) ,{ page: 'all'}).data().sum();	//컬럼 추가될떄 column값도 늘려주기
            } 

			for(var i=0; i<140; i++){
				$('#goodsfaulty'+ (i+1) ).html(addCommas(shipInsSumGoodsArray[i]));
			}

			$('#shipInsSumItemTable_wrapper thead th').css('vertical-align','middle');

		
	   
        },
     });

 	//외관검사
	columnVisibleFun2('shipInsSumItemTable', systemCommonCode.length, shipInsSumItemTable);
	// ----------- 목록 끝
	

	// 탭 시작 ------------
	$("#tab1").on("click", function() {
		$("#"+selectedTab+"Div").addClass("d-none");
		$("#dateDiv").removeClass("d-none");
		
		selectedTab = "date";
		selectedTable = shipInsSumDateTable;
		$('#shipInsSumDateTable').DataTable().ajax.reload(function(){
		});
		
	})
	$("#tab2").on("click", function() {
		$("#"+selectedTab+"Div").addClass("d-none");
		$("#equipDiv").removeClass("d-none");
		
		selectedTab = "equip";
		selectedTable = shipInsSumEquipTable;
		selectedTable.ajax.reload();
		
	})
	$("#tab3").on("click", function() {
		$("#"+selectedTab+"Div").addClass("d-none");
		$("#periodDiv").removeClass("d-none");
		
		selectedTab = "period";
		selectedTable = shipInsSumPeriodTable;
		selectedTable.ajax.reload();
	})
	$("#tab4").on("click", function() {
		$("#"+selectedTab+"Div").addClass("d-none");
		$("#itemDiv").removeClass("d-none");
		
		selectedTab = "item";
		selectedTable = shipInsSumItemTable;
		selectedTable.ajax.reload();
	})
	// -------------- 탭 끝
	
/* 	//검색 기능
	$('.search').on('keyup', function(){
		selectedTable.search($(this).val()).draw();
	});
 */
	$("#btnRetv").on('click', function() {
		if(selectedTab == "date"){
			$('#shipInsSumDateTable').DataTable().ajax.reload(function(){
			});
		} else if(selectedTab == "equip"){
			$('#shipInsSumEquipTable').DataTable().ajax.reload(function(){
			});
		} else if(selectedTab == "period"){
			$('#shipInsSumPeriodTable').DataTable().ajax.reload(function(){
			});
		} else if(selectedTab == "item"){
			$('#shipInsSumItemTable').DataTable().ajax.reload(function(){
			});
		}

	});

	shipInsSumDateTable.on('draw.dt', function(){
		 shipInsSumDateTable.columns.adjust();
	});
	shipInsSumEquipTable.on('draw.dt', function(){
		shipInsSumEquipTable.columns.adjust();
	});
	shipInsSumPeriodTable.on('draw.dt', function(){
		shipInsSumPeriodTable.columns.adjust();
	});
	shipInsSumItemTable.on('draw.dt', function(){
		shipInsSumItemTable.columns.adjust();
	});
	
	function addFaultyRow(tableNm) {
		$("#"+tableNm).find("#metalHd").attr("colspan", metalFaultyCd.length);
		$("#"+tableNm).find("#filmHd").attr("colspan", filmFaultyCd.length);
		
		$.each(metalFaultyCd, function(item, index) {
	    	$("#"+tableNm).find("#appearFaultyWeekHd").append("<th class='text-center' style='min-width: 70px;'>"+this.baseCdNm+"</th>");
		});
		$.each(filmFaultyCd, function(item, index) {
	    	$("#"+tableNm).find("#appearFaultyWeekHd").append("<th class='text-center' style='min-width: 70px;'>"+this.baseCdNm+"</th>");
		});
	}

	//일자별

		
	function dateHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		
 
		});

    	var sudel = '';

    	let starCount = 0;

    	
    	starCount = 152 - metalIdx - filmIdx - 12;

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#metalDateHd').attr('colspan', metalIdx);   
        $('#filmDateHd').attr('colspan', filmIdx);    

        
		$('#shipDateHd').html(metal);
		$('#shipDateHd').append(sudel);
		

	}

	function equipHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		
 
		});

    	var sudel = '';

    	let starCount = 0;

    	
    	starCount = 151 - metalIdx - filmIdx - 11;

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#metalEquipHd').attr('colspan', metalIdx);   
        $('#filmEquipHd').attr('colspan', filmIdx);    

        
		$('#shipEquipHd').html(metal);
		$('#shipEquipHd').append(sudel);
		

	}

	function periodHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		
 
		});

    	var sudel = '';

    	let starCount = 0;

    	
    	starCount = 140 - metalIdx - filmIdx;

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#metalPeriodHd').attr('colspan', metalIdx);   
        $('#filmPeriodHd').attr('colspan', filmIdx);    

        
		$('#shipPeriodHd').html(metal);
		$('#shipPeriodHd').append(sudel);
		

	}
	
	function goodsHeaderCreate() {
    	var metal = '';
    	var film = '';
    	var vision = '';
    	var five = '';
    	var six = '';
		var metalIdx = 0;
		var filmIdx = 0;
		var visionIdx = 0;
		var fiveIdx = 0;
		var sixIdx = 0;
		
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '001'){
    			metal += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			metalIdx++;  
        	}
    		if(item.etc1 == '002'){
    			film += '<th  class="text-center" style="min-width:60px;"><div class="'+index+'">'+ item.baseCdNm+'</div></th>';
    			filmIdx++;  
        	}
    		
 
		});

    	var sudel = '';

    	let starCount = 0;

    	
    	starCount = 140 - metalIdx - filmIdx;

    	for(var i=0; i<starCount; i++){
    		sudel += '<th>★</th>';
		}
		
    	metal = metal + film +vision + five + six;
        $('#metalGoodsHd').attr('colspan', metalIdx);   
        $('#filmGoodsHd').attr('colspan', filmIdx);    

        
		$('#shipGoodsHd').html(metal);
		$('#shipGoodsHd').append(sudel);
		

	}
	
	//컴럼 숨김 처리 함수
  	function columnVisibleFun(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		let systemCodeLength = 0;


		$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			systemCodeLength++;
    			
        	}
    		if(item.etc1 == '002'){
    			systemCodeLength++;
    			
        	}      
		});

		let countCol = 0; 		
		countCol = systemCodeLength + 12;
		//★제거
		for( var i=(countCol); i<152; i++) {		   
		    domTableId.column( i ).visible( false );
		    
		};
		
		
	}

	//컴럼 숨김 처리 함수
  	function columnVisibleFun2(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		let systemCodeLength = 0;


		$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){
    			systemCodeLength++;
    			
        	}
    		if(item.etc1 == '002'){
    			systemCodeLength++;
    			
        	}      
		});

		let countCol = 0; 		
		countCol = systemCodeLength + 11;
		//★제거
		for( var i=(countCol); i<151; i++) {		   
		    domTableId.column( i ).visible( false );
		    
		};
		
		
	}


</script>

</body>
</html>