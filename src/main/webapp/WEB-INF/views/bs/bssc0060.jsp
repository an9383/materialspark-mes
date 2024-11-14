<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">출고집계표</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card"  style="margin-bottom:0px;">
					<div class="row" style="margin-bottom:5px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">마감일</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 150px;" type="month" id="chooseDate1" />							
						</div> 						
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm utilTag">~</label>
						<div class="form-group input-sub m-0 row utilTag">
							<input class="form-control" style="width: 150px;" type="month" id="chooseDate2" />
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm utilTag">오더구분</label>
						<select class="custom-select utilTag" style="width:70px;" id="orderGubun"> </select>
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">거래처/품목별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">거래처별</a></li>			
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">오더구분별</a></li>	
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">판매계획</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">샘플판매</a></li>			
						</ul>
					</div>
				<!-- .table-responsive -->
				<div id="View1" style="margin-top: 6px">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>년월</th>
									<th>거래처</th>
									<th>제품명</th>
									<th>재질</th>		
									<th>수주수량</th>
									<th>수주금액</th>
									<th>출고수량</th>
									<th>출고금액</th>
									<th>미출고수량</th>
									<th>미출고금액</th>
									<th>달성율(%)</th>
																					
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="4" style="text-align: center">합계</td>					
									<td colspan="" id="sumPoQty" style="text-align: right">0</td>															
									<td colspan="" id="sumPoTotalPrice" style="text-align: right">0</td>
									<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
									<td colspan="" id="sumOutputTotalPrice" style="text-align: right">0</td>
									<td colspan="" id="sumReaminQty" style="text-align: right">0</td>
									<td colspan="" id="sumReaminTotalPrice" style="text-align: right">0</td>
									<td colspan="" id="sumAc" style="text-align: right">0%</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- .table-responsive -->
				<div id="View2" class="d-none" style="margin-top: 6px">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable2" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>년월</th>
									<th>거래처</th>								
									<th>수주수량</th>
									<th>수주금액</th>
									<th>출고수량</th>
									<th>출고금액</th>
									<th>미출고수량</th>
									<th>미출고금액</th>
									<th>달성율(%)</th>			
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="2" style="text-align: center">합계</td>					
									<td colspan="" id="sumPoQty2" style="text-align: right">0</td>															
									<td colspan="" id="sumPoTotalPrice2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputQty2" style="text-align: right">0</td>
									<td colspan="" id="sumOutputTotalPrice2" style="text-align: right">0</td>
									<td colspan="" id="sumReaminQty2" style="text-align: right">0</td>
									<td colspan="" id="sumReaminTotalPrice2" style="text-align: right">0</td>
									<td colspan="" id="sumAc2" style="text-align: right">0%</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div id="View3" class="d-none" style="margin-top: 6px">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable3" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>년월</th>
									<th>오더구분</th>
									<th>수주수량</th>
									<th>수주금액</th>
									<th>출고수량</th>
									<th>출고금액</th>
									<th>미출고수량</th>
									<th>미출고금액</th>
									<th>달성율(%)</th>		
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
								<td colspan="2" style="text-align: center">합계</td>					
									<td colspan="" id="sumPoQty3" style="text-align: right">0</td>															
									<td colspan="" id="sumPoTotalPrice3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputQty3" style="text-align: right">0</td>
									<td colspan="" id="sumOutputTotalPrice3" style="text-align: right">0</td>
									<td colspan="" id="sumReaminQty3" style="text-align: right">0</td>
									<td colspan="" id="sumReaminTotalPrice3" style="text-align: right">0</td>
									<td colspan="" id="sumAc3" style="text-align: right">0%</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div id="View4" class="d-none" style="margin-top: 6px">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable4" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>고객사</th>
									<th>기종</th>
									<th>당월(기준)</th>
									<th>당월(순수)</th>
									<th>이월</th>
									<th>총 수량</th>
									<th>고객사</th>
									<th>기종</th>
									<th>set 가격(₩)</th>
									<th>MP(순수)</th>
									<th>이월</th>
									<th>총 매출</th>	
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
								<td colspan="2" style="text-align: center">합계</td>					
									<td colspan="" id="sum1" style="text-align: right">0</td>															
									<td colspan="" id="sum2" style="text-align: right">0</td>
									<td colspan="" id="sum3" style="text-align: right">0</td>
									<td colspan="" id="sum4" style="text-align: right">0</td>
									<td colspan="3" id="sumTotal" class="text-center" style="text-align:center">합계</td>	
									<td colspan="" id="sum5" style="text-align: right">0</td>
									<td colspan="" id="sum6" style="text-align: right">0</td>
									<td colspan="" id="sum7" style="text-align: right">0</td>									
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- 샘플판매 -->
				<div id="View5" class="d-none" style="margin-top: 6px">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable5" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>고객사</th>
									<th>기종</th>
									<th>당월(기준)</th>
									<th>당월(순수)</th>
									<th>이월</th>
									<th>총 수량</th>
									<th>고객사</th>
									<th>기종</th>
									<th>set 가격(₩)</th>
									<th>MP(순수)</th>
									<th>이월</th>
									<th>총 매출</th>	
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="2"	style="text-align: center">합계</td>					
									<td colspan=""	id="sampleSum1" style="text-align: right">0</td>															
									<td colspan=""	id="sampleSum2" style="text-align: right">0</td>
									<td colspan=""	id="sampleSum3" style="text-align: right">0</td>
									<td colspan=""	id="sampleSum4" style="text-align: right">0</td>
									<td colspan="3"	id="sampleSumTotal" class="text-center" style="text-align:center">합계</td>	
									<td colspan=""	id="sampleSum5" style="text-align: right">0</td>
									<td colspan=""	id="sampleSum6" style="text-align: right">0</td>
									<td colspan=""	id="sampleSum7" style="text-align: right">0</td>									
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'bssc0060';
	let currentHref = 'bssc0060';
	let currentPage = $('.'+currentHref).attr('id');	
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","출고집계표");
    let viewIdx;
    let sideView = 'add';
	var outputHistDate =  "${serverDate}";
	var outputHistDateFrom = "${serverDateFrom}";   
	var outputHistDateTo = "${serverDate}";
	var salesPlanDate = "${serverDate}";
	var poGubunCd =  ""; 
	var tapTemp = 1;
	 
	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>
    
    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>
	selectBoxAppend(poGubunCode, "orderGubun", "", "1");
  	//공통코드 종료
	pageCountArray.sort(function(a, b) {
	  return a.baseCd - b.baseCd;
	});
	
	var pageCd = new Array();
	var pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0){
			pageCd.push(-1);
			pageNm.push("All");
		}else{
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable = $('#purchaseOutputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",           
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
 //       pageLength: 18,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/bs/purchaseOrderDealGoodsOutput"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },
	           	'outputHistDateTo': function() { return outputHistDateTo.substring(0,7).replace(/-/g, ''); },
	           	'poGubunCd': function() { return poGubunCd; },                
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
            { data: 'poDate',
				render: function(data, type, row) {
						data = data + "01";
						return moment(data).format("YYYY-MM");
										
				}
            },
            { data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpCd']=='99999'){	
						return "<span class='font-blue' >월소계</span>";
					} else{
						return data;
					}
					
				}
			 },
			{ data: 'goodsNm' },
	        { data: 'qutyNm' },	        
            { data: 'poQty' }, 
            { data: 'totalPrice1' },
            { data: 'outputQty' }, 
            { data: 'totalPrice2' },
            { data: 'remainQty' }, 
            { data: 'totalPrice3' },
            {             	          	
				render: function(data, type, row) {					
					var result = row['outputQty'] / row['poQty'] * 100;
					return addCommas(result.toFixed(1)) + '%';
				}
			 },          
			//{ data: 'deliveryDealCorpNm' },
                   
        ],
        columnDefs: [
        	{ targets: [4,5,6,7,8,9], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5,6,7,8,9,10], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '출고집계표(거래처/품목)',
            },
            {
                extend: 'excel',
                title: '출고집계표(거래처/품목)',
            },
            {
                extend: 'print',
                title: '출고집계표(거래처/품목)',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputHistTable tfoot').remove();
			//전역변수들		 	
			var sumPoTotalPrice      = 0 ;
			var sumOutputTotalPrice  = 0 ;
			var sumReaminTotalPrice	= 0	 ;	
			var sumPoQty             = 0 ;
			var sumOutputQty         = 0 ;
			var sumReaminQty         = 0 ;
			var sumAc                = 0 ;
	
			sumPoTotalPrice =  ($('#purchaseOutputHistTable').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
			sumOutputTotalPrice =  ($('#purchaseOutputHistTable').DataTable().column(7,{ page: 'all'} ).data().sum() / 2);
			sumReaminTotalPrice =  ($('#purchaseOutputHistTable').DataTable().column(9,{ page: 'all'} ).data().sum() / 2);

			sumPoQty =  ($('#purchaseOutputHistTable').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);  
			sumOutputQty =  ($('#purchaseOutputHistTable').DataTable().column(6,{ page: 'all'} ).data().sum() / 2);  			
			sumReaminQty =  ($('#purchaseOutputHistTable').DataTable().column(8,{ page: 'all'} ).data().sum() / 2);  

			sumAc = parseFloat(sumOutputQty) / parseFloat(sumPoQty) * 100;
			sumAc = addCommas(sumAc.toFixed(1)) + "%";
			
			$('#sumPoTotalPrice').text(addCommas(sumPoTotalPrice.toFixed(0)));	
			$('#sumOutputTotalPrice').text(addCommas(sumOutputTotalPrice.toFixed(0)));	
			$('#sumReaminTotalPrice').text(addCommas(sumReaminTotalPrice.toFixed(0)));	
			$('#sumPoQty').text(addCommas(sumPoQty.toFixed(0)));
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumReaminQty').text(addCommas(sumReaminQty.toFixed(0)));
			$('#sumAc').text(sumAc);


			$('#purchaseOutputHistTable tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(1).text() == '월소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});

			
        }
    });

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable2 = $('#purchaseOutputHistTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",           
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
 //       pageLength: 18,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/bs/purchaseOrderDealOutput"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },
	           	'outputHistDateTo': function() { return outputHistDateTo.substring(0,7).replace(/-/g, ''); },
	           	'poGubunCd': function() { return poGubunCd; },                
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
            { data: 'poDate',
				render: function(data, type, row) {
						data = data + "01";
						return moment(data).format("YYYY-MM");
										
				}
            },
            { data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpCd']=='99999'){	
						return "<span class='font-blue' >월소계</span>";
					} else{
						return data;
					}
					
				}
			 },
            { data: 'poQty' }, 
            { data: 'totalPrice1' },
            { data: 'outputQty' }, 
            { data: 'totalPrice2' },
            { data: 'remainQty' }, 
            { data: 'totalPrice3' },
            {             	          	
				render: function(data, type, row) {					
					var result = row['outputQty'] / row['poQty'] * 100;
					return addCommas(result.toFixed(1)) + '%';
				}
			 },  
			//{ data: 'deliveryDealCorpNm' },
                   
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7,8], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '출고집계표(거래처)',
            },
            {
                extend: 'excel',
                title: '출고집계표(거래처)',
            },
            {
                extend: 'print',
                title: '출고집계표(거래처)',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputHistTable2 tfoot').remove();
			//전역변수들
			var sumTotalPrice = 0;				
			var sumPoTotalPrice      = 0 ;
			var sumOutputTotalPrice  = 0 ;
			var sumReaminTotalPrice	= 0	 ;	
			var sumPoQty             = 0 ;
			var sumOutputQty         = 0 ;
			var sumReaminQty         = 0 ;
			var sumAc                = 0 ;
	
			sumPoTotalPrice =  ($('#purchaseOutputHistTable2').DataTable().column(3,{ page: 'all'} ).data().sum() / 2);
			sumOutputTotalPrice =  ($('#purchaseOutputHistTable2').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
			sumReaminTotalPrice =  ($('#purchaseOutputHistTable2').DataTable().column(7,{ page: 'all'} ).data().sum() / 2);

			sumPoQty =  ($('#purchaseOutputHistTable2').DataTable().column(2,{ page: 'all'} ).data().sum() / 2);  
			sumOutputQty =  ($('#purchaseOutputHistTable2').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);  			
			sumReaminQty =  ($('#purchaseOutputHistTable2').DataTable().column(6,{ page: 'all'} ).data().sum() / 2);  

			sumAc = parseFloat(sumOutputQty) / parseFloat(sumPoQty) * 100;
			sumAc = addCommas(sumAc.toFixed(1)) + "%";
			
			$('#sumPoTotalPrice2').text(addCommas(sumPoTotalPrice.toFixed(0)));	
			$('#sumOutputTotalPrice2').text(addCommas(sumOutputTotalPrice.toFixed(0)));	
			$('#sumReaminTotalPrice2').text(addCommas(sumReaminTotalPrice.toFixed(0)));	
			$('#sumPoQty2').text(addCommas(sumPoQty.toFixed(0)));
			$('#sumOutputQty2').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumReaminQty2').text(addCommas(sumReaminQty.toFixed(0)));
			$('#sumAc2').text(sumAc);

			$('#purchaseOutputHistTable2 tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(1).text() == '월소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});
		
        }
    });
    
	  $.fn.dataTable.ext.errMode = 'none';
		let purchaseOutputHistTable3 = $('#purchaseOutputHistTable3').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
			dom:"<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",           
	        language: lang_kor,
	        paging: true,
	        info: true,
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,
	        lengthChange : true,
	        scrollY : "58vh",
	        scrollCollapse: true,
	 //       pageLength: 18,
	        lengthMenu : [ pageCd, pageNm ],
	        ajax: {
	            url: '<c:url value="/bs/purchaseOrderOrderGubunOutput"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 : menuAuth,
		           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },
		           	'outputHistDateTo': function() { return outputHistDateTo.substring(0,7).replace(/-/g, ''); },
		           	'poGubunCd': function() { return poGubunCd; },                
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        rowId: 'poNo',
	        columns: [
	             { data: 'poDate',
					render: function(data, type, row) {
						if(row['poGubunCd'] != '9999999'){
							data = data + "01";
							return moment(data).format("YYYY-MM");
						} else{
							data = data + "01";
							return moment(data).format("YYYY-MM");
						}
							
											
					}
	            },
	            { data: 'poGubunNm',            	
					render: function(data, type, row) {
						if(row['poGubunCd']=='9999999'){	
							return "<span class='font-blue' >월소계</span>";
						} else{
							return data;
						}
						
					}
				 },
		            { data: 'poQty' }, 
		            { data: 'totalPrice1' },
		            { data: 'outputQty' }, 
		            { data: 'totalPrice2' },
		            { data: 'remainQty' }, 
		            { data: 'totalPrice3' },
		            {             	          	
						render: function(data, type, row) {					
							var result = row['outputQty'] / row['poQty'] * 100;
							return addCommas(result.toFixed(1)) + '%';
						}
					 },  
				//{ data: 'deliveryDealCorpNm' },
	                   
	        ],
	        columnDefs: [
	        	{ targets: [2,3,4,5,6,7], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [2,3,4,5,6,7,8], className: 'text-right-td' },
	        ],
	       
	        buttons: [
	            {
	                extend: 'copy',
	                title: '출고집계표(오더구분별)',
	            },
	            {
	                extend: 'excel',
	                title: '출고집계표(오더구분별)',
	            },
	            {
	                extend: 'print',
	                title: '출고집계표(오더구분별)',
	            },
	        ],
	        drawCallback: function () {
	        	$('#purchaseOutputHistTable3 tfoot').remove();
				//전역변수들
	        	sumPoTotalPrice =  ($('#purchaseOutputHistTable3').DataTable().column(3,{ page: 'all'} ).data().sum() / 2);
				sumOutputTotalPrice =  ($('#purchaseOutputHistTable3').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
				sumReaminTotalPrice =  ($('#purchaseOutputHistTable3').DataTable().column(7,{ page: 'all'} ).data().sum() / 2);

				sumPoQty =  ($('#purchaseOutputHistTable3').DataTable().column(2,{ page: 'all'} ).data().sum() / 2);  
				sumOutputQty =  ($('#purchaseOutputHistTable3').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);  			
				sumReaminQty =  ($('#purchaseOutputHistTable3').DataTable().column(6,{ page: 'all'} ).data().sum() / 2);  

				sumAc = parseFloat(sumOutputQty) / parseFloat(sumPoQty) * 100;
				sumAc = addCommas(sumAc.toFixed(1)) + "%";
				
				$('#sumPoTotalPrice3').text(addCommas(sumPoTotalPrice.toFixed(0)));	
				$('#sumOutputTotalPrice3').text(addCommas(sumOutputTotalPrice.toFixed(0)));	
				$('#sumReaminTotalPrice3').text(addCommas(sumReaminTotalPrice.toFixed(0)));	
				$('#sumPoQty3').text(addCommas(sumPoQty.toFixed(0)));
				$('#sumOutputQty3').text(addCommas(sumOutputQty.toFixed(0)));
				$('#sumReaminQty3').text(addCommas(sumReaminQty.toFixed(0)));
				$('#sumAc3').text(sumAc);

				$('#purchaseOutputHistTable3 tbody tr').each(function(){
				 	
				 	if($(this).find('td').eq(1).text() == '월소계') {
						$(this).css('background-color','#aed3ec');
						$(this).css('color','blue');
				 	}	
				});
	        }
	    });

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable4 = $('#purchaseOutputHistTable4').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",           
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
 //       pageLength: 18,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/bs/purchaseOrderListchulgojipgye"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },	          
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
        	{ data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpNm']=='999999'){	
						return "<span class='font-blue' >소계</span>";
					} else{
						return data;
					}
					
				}
			 },
            
			{ data: 'goodsNm' },
	        { data: 'poQty' },	        
            { data: 'outputQty' }, 
            { data: 'remainQty' },
            { data: 'totalPrice1' },
            { data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpNm']=='999999'){	
						return "<span class='font-blue' >소계</span>";
					} else{
						return data;
					}
					
				}
			 },
            
			{ data: 'goodsNm' }, 
            { data: 'costUnit' },
            { data: 'outputPri' }, 
            { data: 'notOutputPri' }, 
            { data: 'totalPrice2' },                   
		
                   
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,8,9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,8,9,10,11], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '출고집계표(거래처/품목)',
            },
            {
                extend: 'excel',
                title: '출고집계표(거래처/품목)',
            },
            {
                extend: 'print',
                title: '출고집계표(거래처/품목)',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputHistTable4 tfoot').remove();
			//전역변수들		 	
			var sum1  = 0 ;
			var sum2  = 0 ;
			var sum3  = 0 ;	
			var sum4  = 0 ;
			var sum5  = 0 ;
			var sum6  = 0 ;
			var sum7  = 0 ;
	
			sum1 =  ($('#purchaseOutputHistTable4').DataTable().column(2,{ page: 'all'} ).data().sum() / 2);
			sum2 =  ($('#purchaseOutputHistTable4').DataTable().column(3,{ page: 'all'} ).data().sum() / 2);
			sum3 =  ($('#purchaseOutputHistTable4').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);
			sum4 =  ($('#purchaseOutputHistTable4').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
			sum5 =  ($('#purchaseOutputHistTable4').DataTable().column(9,{ page: 'all'} ).data().sum() / 2);
			sum6 =  ($('#purchaseOutputHistTable4').DataTable().column(10,{ page: 'all'} ).data().sum() / 2);
			sum7 =  ($('#purchaseOutputHistTable4').DataTable().column(11,{ page: 'all'} ).data().sum() / 2);
		
			$('#sum1').text(addCommas(sum1.toFixed(0)));	
			$('#sum2').text(addCommas(sum2.toFixed(0)));	
			$('#sum3').text(addCommas(sum3.toFixed(0)));	
			$('#sum4').text(addCommas(sum4.toFixed(0)));
			$('#sum5').text(addCommas(sum5.toFixed(0)));
			$('#sum6').text(addCommas(sum6.toFixed(0)));
			$('#sum7').text(addCommas(sum7.toFixed(0)));


			$('#purchaseOutputHistTable4 tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(0).text() == '소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});

			$('#sumTotal').removeClass('text-right-td');

			
        }
    });

	//샘플판매 목록
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable5 = $('#purchaseOutputHistTable5').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",           
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
 //       pageLength: 18,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/bs/purchaseOrderAdmSampleList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.substring(0,7).replace(/-/g, ''); },	          
            },
        },
        rowId: 'poNo',
        columns: [
        	{ data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpNm']=='999999'){	
						return "<span class='font-blue' >소계</span>";
					} else{
						return data;
					}
					
				}
			 },
			{ data: 'goodsNm' },
	        { data: 'poQty' },	        
            { data: 'outputQty' }, 
            { data: 'remainQty' },
            { data: 'totalPrice1' },
            { data: 'dealCorpNm',            	
				render: function(data, type, row) {
					if(row['dealCorpNm']=='999999'){	
						return "<span class='font-blue' >소계</span>";
					} else{
						return data;
					}
					
				}
			 },
			{ data: 'goodsNm' }, 
            { data: 'costUnit' },
            { data: 'outputPri' }, 
            { data: 'notOutputPri' }, 
            { data: 'totalPrice2' },                   
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,8,9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,8,9,10,11], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '샘플판매',
            },
            {
                extend: 'excel',
                title: '샘플판매',
            },
            {
                extend: 'print',
                title: '샘플판매',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputHistTable5 tfoot').remove();
			//전역변수들		 	
			let sampleSum1  = 0 ;
			let sampleSum2  = 0 ;
			let sampleSum3  = 0 ;	
			let sampleSum4  = 0 ;
			let sampleSum5  = 0 ;
			let sampleSum6  = 0 ;
			let sampleSum7  = 0 ;
	
			sampleSum1 =  ($('#purchaseOutputHistTable5').DataTable().column(2,{ page: 'all'} ).data().sum() / 2);
			sampleSum2 =  ($('#purchaseOutputHistTable5').DataTable().column(3,{ page: 'all'} ).data().sum() / 2);
			sampleSum3 =  ($('#purchaseOutputHistTable5').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);
			sampleSum4 =  ($('#purchaseOutputHistTable5').DataTable().column(5,{ page: 'all'} ).data().sum() / 2);
			sampleSum5 =  ($('#purchaseOutputHistTable5').DataTable().column(9,{ page: 'all'} ).data().sum() / 2);
			sampleSum6 =  ($('#purchaseOutputHistTable5').DataTable().column(10,{ page: 'all'} ).data().sum() / 2);
			sampleSum7 =  ($('#purchaseOutputHistTable5').DataTable().column(11,{ page: 'all'} ).data().sum() / 2);
		
			$('#sampleSum1').text(addCommas(sampleSum1.toFixed(0)));	
			$('#sampleSum2').text(addCommas(sampleSum2.toFixed(0)));	
			$('#sampleSum3').text(addCommas(sampleSum3.toFixed(0)));	
			$('#sampleSum4').text(addCommas(sampleSum4.toFixed(0)));
			$('#sampleSum5').text(addCommas(sampleSum5.toFixed(0)));
			$('#sampleSum6').text(addCommas(sampleSum6.toFixed(0)));
			$('#sampleSum7').text(addCommas(sampleSum7.toFixed(0)));


			$('#purchaseOutputHistTable5 tbody tr').each(function(){
			 	if($(this).find('td').eq(0).text() == '소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});

			$('#sampleSumTotal').removeClass('text-right-td');
        }
    });
			
	$('#chooseDate1').val(moment(outputHistDateFrom).format("YYYY-MM"));
	$('#chooseDate2').val(moment(outputHistDateTo).format("YYYY-MM"));

    // 보기
    $('#purchaseOutputHistTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#purchaseOutputHistTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
    	outputHistDateFrom 	=  $('#chooseDate1').val();
    	outputHistDateTo	=  $('#chooseDate2').val();    
		poGubunCd 			=  $('#orderGubun').val();   
		/*$('#purchaseOutputHistTable').DataTable().ajax.reload( function () {});
		$('#purchaseOutputHistTable2').DataTable().ajax.reload( function () {});
		$('#purchaseOutputHistTable3').DataTable().ajax.reload( function () {});
		$('#purchaseOutputHistTable4').DataTable().ajax.reload( function () {});
		$('#purchaseOutputHistTable5').DataTable().ajax.reload( function () {});*/

		if (tapTemp == 1) {
			$('#purchaseOutputHistTable').DataTable().ajax.reload();
		} else if(tapTemp == 2) {
			$('#purchaseOutputHistTable2').DataTable().ajax.reload();
		} else if(tapTemp == 3) {
			$('#purchaseOutputHistTable3').DataTable().ajax.reload();
		} else if(tapTemp == 4){
			$('#purchaseOutputHistTable4').DataTable().ajax.reload();
		} else if(tapTemp == 5){
			$('#purchaseOutputHistTable5').DataTable().ajax.reload();	
		}
    });	

	$('#tab1').click(function() {		
		$('#View1').removeClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		$('.utilTag').removeClass('d-none');		
		tapTemp = 1;
		$('#purchaseOutputHistTable').DataTable().ajax.reload();
	});
	
	$('#tab2').click(function() {
		
		$('#View1').addClass("d-none");		
		$('#View2').removeClass("d-none");	
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		$('.utilTag').removeClass('d-none');		
		tapTemp = 2;
		$('#purchaseOutputHistTable2').DataTable().ajax.reload();
		
	});

	$('#tab3').click(function() {

		$('#View1').addClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').removeClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		tapTemp = 3;	
		$('.utilTag').removeClass('d-none');		
		$('#purchaseOutputHistTable3').DataTable().ajax.reload();
	});

	$('#tab4').click(function() {
			
		$('#View1').addClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').addClass("d-none");
		$('#View4').removeClass("d-none");
		$('#View5').addClass("d-none");
		tapTemp = 4;	
		$('.utilTag').addClass('d-none');		
		$('#purchaseOutputHistTable4').DataTable().ajax.reload();
	});

	$('#tab5').click(function() {
		
		$('#View1').addClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').removeClass("d-none");
		tapTemp = 5;	
		$('.utilTag').addClass('d-none');		
		$('#purchaseOutputHistTable5').DataTable().ajax.reload();
	})

	$('#orderGubun').change(function() {
		poGubunCd =  $('#orderGubun').val();
		if (tapTemp == 1) {
			$('#purchaseOutputHistTable').DataTable().ajax.reload();
			$('#purchaseOutputHistTable2').DataTable().clear().draw();
			$('#purchaseOutputHistTable3').DataTable().clear().draw();
			$('#purchaseOutputHistTable4').DataTable().clear().draw();
			$('#purchaseOutputHistTable5').DataTable().clear().draw();
		} else if(tapTemp == 2) {
			$('#purchaseOutputHistTable').DataTable().clear().draw();
			$('#purchaseOutputHistTable2').DataTable().ajax.reload();
			$('#purchaseOutputHistTable3').DataTable().clear().draw();
			$('#purchaseOutputHistTable4').DataTable().clear().draw();
			$('#purchaseOutputHistTable5').DataTable().clear().draw();
		} else if(tapTemp == 3) {
			$('#purchaseOutputHistTable').DataTable().clear().draw();
			$('#purchaseOutputHistTable2').DataTable().clear().draw();
			$('#purchaseOutputHistTable3').DataTable().ajax.reload();
			$('#purchaseOutputHistTable4').DataTable().clear().draw();
			$('#purchaseOutputHistTable5').DataTable().clear().draw();
		} else if(tapTemp == 4){
			$('#purchaseOutputHistTable').DataTable().clear().draw();
			$('#purchaseOutputHistTable2').DataTable().clear().draw();
			$('#purchaseOutputHistTable3').DataTable().clear().draw();
			$('#purchaseOutputHistTable4').DataTable().ajax.reload();
			$('#purchaseOutputHistTable5').DataTable().clear().draw();
		} else if(tapTemp == 5){
			$('#purchaseOutputHistTable').DataTable().clear().draw();
			$('#purchaseOutputHistTable2').DataTable().clear().draw();
			$('#purchaseOutputHistTable3').DataTable().clear().draw();
			$('#purchaseOutputHistTable4').DataTable().clear().draw();
			$('#purchaseOutputHistTable5').DataTable().ajax.reload();	
		}
		
    });
    
</script>

</body>
</html>

