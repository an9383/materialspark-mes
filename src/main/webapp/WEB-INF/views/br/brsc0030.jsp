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
				<li class="breadcrumb-item"><a href="#">자재입출고관리</a></li>
				<li class="breadcrumb-item active">원자재수불명세서</li>
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
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">기간</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 150px;" type="month" id="chooseDate1" />				
						</div>

						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>			
						<button type="button" class="btn btn-primary float-right ml-1 " id="priceButton">단가 입력</button>			

					</div> 
					<div class="card-header card-tab" style="margin-bottom: 10px;">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">월별</a></li>
							<li class="nav-item"><a class="nav-link " data-toggle="tab" id="tab2">누적</a></li>									
						</ul>
					</div>
				<!-- .table-responsive -->			
				<div id="View1" class="">
					<table id="purchaseOutputHistTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th style="vertical-align : middle;min-width:100px;" rowspan ="2" >품명</th>
								<th style="vertical-align : middle;min-width:100px;" rowspan ="2" >규격</th>
								<th style="vertical-align : middle;min-width:50px;" rowspan ="2" >유/무상</th>
								<th colspan="3">전기이월</th>
								<th colspan="3">당월입고</th>
								<th colspan="3">당월출고</th>		
								<th colspan="3">기말재고</th>
								<!-- <th colspan="3">생산실재고</th>				 -->
							</tr>
							<tr>								
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>		
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	
							<!-- 	<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	 -->
										
							</tr>
						</thead>		
						<tfoot>
							<tr style="background-color:#edacb1; color:red">
							<td colspan="3" style="text-align: center">합계</td>					
								<td colspan="" id="sum1" style="text-align: right">0</td>															
								<td colspan="" id="sum2" style="text-align: right"></td>			
								<td colspan="" id="sum3"style="text-align: right">0</td>			
								<td colspan="" id="sum4" style="text-align: right">0</td>
								<td colspan="" id="sum5" style="text-align: right"></td>
								<td colspan="" id="sum6" style="text-align: right">0</td>															
								<td colspan="" id="sum7" style="text-align: right">0</td>			
								<td colspan="" id="sum8" style="text-align: right"></td>			
								<td colspan="" id="sum9" style="text-align: right">0</td>
								<td colspan="" id="sum10" style="text-align: right">0</td>
								<td colspan="" id="sum11" style="text-align: right"></td>															
								<td colspan="" id="sum12" style="text-align: right">0</td>			
								<!-- <td colspan="" id="sum13" style="text-align: right">0</td>			
								<td colspan="" id="sum14" style="text-align: right"></td>
								<td colspan="" id="sum15" style="text-align: right">0</td> -->
							</tr>							
						</tfoot>					
					</table>
				</div>
				<div id="View2" class="d-none">
					<table id="purchaseOutputHistTable2" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th style="vertical-align : middle;min-width:100px;" rowspan ="2" >품명</th>
								<th style="vertical-align : middle;min-width:100px;" rowspan ="2" >규격</th>
								<th style="vertical-align : middle;min-width:50px;" rowspan ="2" >유/무상</th>
								<th colspan="3">전기이월</th>
								<th colspan="3">당월누적입고</th>
								<th colspan="3">당월누적출고</th>		
								<th colspan="3">기말재고</th>
								<!-- <th colspan="3">생산실재고</th>				 -->
							</tr>
							<tr>								
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>		
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>	
								<th style="min-width:100px;">수량(Kg)</th>
								<th style="min-width:100px;">단가</th>
								<th style="min-width:100px;">금액</th>					
										
							</tr>
						</thead>		
						<tfoot>
							<tr style="background-color:#edacb1; color:red">
							<td colspan="3" style="text-align: center">합계</td>					
								<td colspan="" id="sumAcc1" style="text-align: right">0</td>															
								<td colspan="" id="sumAcc2" style="text-align: right"></td>			
								<td colspan="" id="sumAcc3"style="text-align: right">0</td>			
								<td colspan="" id="sumAcc4" style="text-align: right">0</td>
								<td colspan="" id="sumAcc5" style="text-align: right"></td>
								<td colspan="" id="sumAcc6" style="text-align: right">0</td>															
								<td colspan="" id="sumAcc7" style="text-align: right">0</td>			
								<td colspan="" id="sumAcc8" style="text-align: right"></td>			
								<td colspan="" id="sumAcc9" style="text-align: right">0</td>
								<td colspan="" id="sumAcc10" style="text-align: right">0</td>
								<td colspan="" id="sumAcc11" style="text-align: right"></td>															
								<td colspan="" id="sumAcc12" style="text-align: right">0</td>			
								
							</tr>							
						</tfoot>					
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 구매량입력 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="pricePopupModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="pricePopupModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="min-width:1500px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pricePopupModalLabel">단가입력 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body"> 
           	<div class="card">                  
               	<div class="table-responsive first-table">
                	<table id="priceList" class="table table-bordered" style="text-align:center">
                        <thead class="thead-light">
	                        <tr id="planHeader2">
	                        
                            </tr>
                        </thead> 
                    </table>
                </div>
            </div>	
      </div>
      <div class="modal-footer">
      	<!-- <button type="button" class="btn btn-danger mr-a touch6" id="priceDelete"  style="min-width:70px;">삭제</button> -->
      	<button type="button" class="btn btn-primary" id="priceSave"  style="min-width:70px;">저장</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 구매량입력 모달 끝-->

<%@include file="../layout/bottom.jsp"%>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'brsc0030';
	let currentHref = 'brsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","원자재 수불 명세서");
    let viewIdx;
    let sideView = 'add';
	var outputHistDate =  "${serverDate}";
	var outputHistDate2 =  "${serverDate}";
	var matrlCd = '';
	var temp = true;

    var qutyList = new Array();
    var matrlCodeList = new Array();
    
    <c:forEach items="${qutyList}" var="info">
	    var json = new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		qutyList.push(json);

    </c:forEach>
    
    <c:forEach items="${matrlCodeList}" var="info">
		var json = new Object();
		json.matrlCd="${info.matrlCd}";
		json.matrlNm="${info.matrlNm}";
		matrlCodeList.push(json);
	</c:forEach>
	
    var qutyCd = '';
	
	
	createHeader();

	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#priceList').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();	

	
    // 목록1
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
        paging: false,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
      
        lengthChange : false,
        pageLength: 99999,
        ajax: {
            url: '<c:url value="/br/readRawMatrlInOutList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate.substring(0,7).replace(/-/g, ''); },        	
	           	 
            },
           
        },
        rowId: 'poNo',
        columns: [
			{ data: 'matrlNm'},
			{ data: 'thickness' },
			{
			    data: 'paidGubun',
			    render: function(data, type, row) {
					if(data == "" || data == null) {
						return "-";
					} else {
						if(data == '001'){
							return "유상";
						} else{
							return "무상";
						}
						
					} 
			    } 
			},
			{ data: 'remainQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price' },	        
			{ data: 'remainQtyTotal'},
			{ data: 'preInWhsQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price',
				 render: function(data, type, row) {			
					if(row['gubunja'] == '4'){
						return 0;
					} else{
						return addCommas(parseFloat(data).toFixed(1));
					}
						
				 }
		      },
			{ data: 'preInWhsQtyTotal'},
			{ data: 'preOutWhsQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price',
				 render: function(data, type, row) {			
						if(row['gubunja'] == '3'){
							return 0;
						} else{
							return addCommas(parseFloat(data).toFixed(1));
						}
							
					 }
			},
			{ data: 'preOutWhsQtyTotal'},
			{ data: 'resultQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price' },
			{ data: 'resultQtyTotal'},
		/* 	{ data: 'sumQty',
				 render: function(data, type, row) {					
					return parseFloat(data).toFixed(1);
			     }
			},
			{ data: 'price' },
			{ data: 'sumQtyTotal'}, */
                   
        ],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수불 명세서',
            },
            {
                extend: 'excel',
                title: '원자재 수불 명세서',
            },
            {
                extend: 'print',
                title: '원자재 수불 명세서',
            },
        ],
       /*  order: [
			[ 0, 'asc' ],
		], */
        drawCallback: function () {
			//전역변수들
        	var sum1  = 0 ;
			var sum2  = 0 ;
			var sum3  = 0 ;	
			var sum4  = 0 ;
			var sum5  = 0 ;
        	var sum6  = 0 ;
			var sum7  = 0 ;
			var sum8  = 0 ;	
			var sum9  = 0 ;
			var sum10  = 0 ;
        	var sum11  = 0 ;
			var sum12  = 0 ;
			var sum13  = 0 ;	
			var sum14  = 0 ;
			var sum15  = 0 ;
     
		

			sum1 = ($('#purchaseOutputHistTable').DataTable().column(3,{ page: 'all'} ).data().sum())/2;
			//sum2 = ($('#purchaseOutputHistTable').DataTable().column(3,{ page: 'all'} ).data().sum());
			sum3 = ($('#purchaseOutputHistTable').DataTable().column(5,{ page: 'all'} ).data().sum()/2);
			sum4 = ($('#purchaseOutputHistTable').DataTable().column(6,{ page: 'all'} ).data().sum()/2);
			//sum5 = ($('#purchaseOutputHistTable').DataTable().column(6,{ page: 'all'} ).data().sum());
			sum6 = ( $('#purchaseOutputHistTable').DataTable().column(8,{ page: 'all'} ).data().sum() /2);
			sum7 = ($('#purchaseOutputHistTable').DataTable().column(9,{ page: 'all'} ).data().sum()/2);
			//sum8 = ($('#purchaseOutputHistTable').DataTable().column(9,{ page: 'all'} ).data().sum());
			sum9 = ($('#purchaseOutputHistTable').DataTable().column(11,{ page: 'all'} ).data().sum()/2);
			sum10 = ($('#purchaseOutputHistTable').DataTable().column(12,{ page: 'all'} ).data().sum()/2);
			//sum11 = ($('#purchaseOutputHistTable').DataTable().column(12,{ page: 'all'} ).data().sum());
			sum12 = ($('#purchaseOutputHistTable').DataTable().column(14,{ page: 'all'} ).data().sum()/2);
			//sum13 = ($('#purchaseOutputHistTable').DataTable().column(14,{ page: 'all'} ).data().sum()/2);
			//sum14 = ($('#purchaseOutputHistTable').DataTable().column(15,{ page: 'all'} ).data().sum());
			//sum15 = ($('#purchaseOutputHistTable').DataTable().column(16,{ page: 'all'} ).data().sum()/2);

			$('#sum1').text(addCommas(sum1.toFixed(1)));	
			$('#sum3').text(addCommas(sum3.toFixed(0)));	
			$('#sum4').text(addCommas(sum4.toFixed(1)));	
			$('#sum6').text(addCommas(sum6.toFixed(0)));
			$('#sum7').text(addCommas(sum7.toFixed(1)));
			$('#sum9').text(addCommas(sum9.toFixed(0)));	
			$('#sum10').text(addCommas(sum10.toFixed(1)));	
			$('#sum12').text(addCommas(sum12.toFixed(0)));	
			//$('#sum13').text(addCommas(sum13.toFixed(1)));
//			$('#sum15').text(addCommas(sum15.toFixed(0)));


			$('#purchaseOutputHistTable tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(0).text() == '소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});

        }
    });

	  // 목록1
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
        lengthChange : false,
        pageLength: 99999,
        ajax: {
            url: '<c:url value="/br/readRawMatrlInOutListSum"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate.substring(0,7).replace(/-/g, ''); },        	
	           	 
            },
           
        },
        rowId: 'poNo',
        columns: [
			{ data: 'matrlNm'},
			{ data: 'thickness' },
			{
			    data: 'paidGubun',
			    render: function(data, type, row) {
					if(data == "" || data == null) {
						return "-";
					} else {
						if(data == '001'){
							return "유상";
						} else{
							return "무상";
						}
						
					} 
			    } 
			},
			{ data: 'remainQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price' },	        
			{ data: 'remainQtyTotal'},
			{ data: 'preInWhsQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price',
				 render: function(data, type, row) {			
					if(row['gubunja'] == '4'){
						return 0;
					} else{
						return addCommas(parseFloat(data).toFixed(1));
					}
						
				 }
		      },
			{ data: 'preInWhsQtyTotal'},
			{ data: 'preOutWhsQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price',
				 render: function(data, type, row) {			
						if(row['gubunja'] == '3'){
							return 0;
						} else{
							return addCommas(parseFloat(data).toFixed(1));
						}
							
					 }
			},
			{ data: 'preOutWhsQtyTotal'},
			{ data: 'resultQty',
				 render: function(data, type, row) {					
					return addCommas(parseFloat(data).toFixed(1));
			     }
			},
			{ data: 'price' },
			{ data: 'resultQtyTotal'},
		/* 	{ data: 'sumQty',
				 render: function(data, type, row) {					
					return parseFloat(data).toFixed(1);
			     }
			},
			{ data: 'price' },
			{ data: 'sumQtyTotal'}, */
                   
        ],
        columnDefs: [
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수불 명세서(누적)',
            },
            {
                extend: 'excel',
                title: '원자재 수불 명세서(누적)',
            },
            {
                extend: 'print',
                title: '원자재 수불 명세서(누적)',
            },
        ],
       /*  order: [
			[ 0, 'asc' ],
		], */
        drawCallback: function () {
			//전역변수들
        	var sum1  = 0 ;
			var sum2  = 0 ;
			var sum3  = 0 ;	
			var sum4  = 0 ;
			var sum5  = 0 ;
        	var sum6  = 0 ;
			var sum7  = 0 ;
			var sum8  = 0 ;	
			var sum9  = 0 ;
			var sum10  = 0 ;
        	var sum11  = 0 ;
			var sum12  = 0 ;
			var sum13  = 0 ;	
			var sum14  = 0 ;
			var sum15  = 0 ;
     
		

			sum1 = ($('#purchaseOutputHistTable2').DataTable().column(3,{ page: 'all'} ).data().sum())/2;
			//sum2 = ($('#purchaseOutputHistTable').DataTable().column(3,{ page: 'all'} ).data().sum());
			sum3 = ($('#purchaseOutputHistTable2').DataTable().column(5,{ page: 'all'} ).data().sum()/2);
			sum4 = ($('#purchaseOutputHistTable2').DataTable().column(6,{ page: 'all'} ).data().sum()/2);
			//sum5 = ($('#purchaseOutputHistTable').DataTable().column(6,{ page: 'all'} ).data().sum());
			sum6 = ( $('#purchaseOutputHistTable2').DataTable().column(8,{ page: 'all'} ).data().sum() /2);
			sum7 = ($('#purchaseOutputHistTable2').DataTable().column(9,{ page: 'all'} ).data().sum()/2);
			//sum8 = ($('#purchaseOutputHistTable').DataTable().column(9,{ page: 'all'} ).data().sum());
			sum9 = ($('#purchaseOutputHistTable2').DataTable().column(11,{ page: 'all'} ).data().sum()/2);
			sum10 = ($('#purchaseOutputHistTable2').DataTable().column(12,{ page: 'all'} ).data().sum()/2);
			//sum11 = ($('#purchaseOutputHistTable').DataTable().column(12,{ page: 'all'} ).data().sum());
			sum12 = ($('#purchaseOutputHistTable2').DataTable().column(14,{ page: 'all'} ).data().sum()/2);
			//sum13 = ($('#purchaseOutputHistTable').DataTable().column(14,{ page: 'all'} ).data().sum()/2);
			//sum14 = ($('#purchaseOutputHistTable').DataTable().column(15,{ page: 'all'} ).data().sum());
			//sum15 = ($('#purchaseOutputHistTable').DataTable().column(16,{ page: 'all'} ).data().sum()/2);

			$('#sumAcc1').text(addCommas(sum1.toFixed(1)));	
			$('#sumAcc3').text(addCommas(sum3.toFixed(0)));	
			$('#sumAcc4').text(addCommas(sum4.toFixed(1)));	
			$('#sumAcc6').text(addCommas(sum6.toFixed(0)));
			$('#sumAcc7').text(addCommas(sum7.toFixed(1)));
			$('#sumAcc9').text(addCommas(sum9.toFixed(0)));	
			$('#sumAcc10').text(addCommas(sum10.toFixed(1)));	
			$('#sumAcc12').text(addCommas(sum12.toFixed(0)));	
			//$('#sum13').text(addCommas(sum13.toFixed(1)));
//			$('#sum15').text(addCommas(sum15.toFixed(0)));


			/* $('#purchaseOutputHistTable2 tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(0).text() == '소계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			}); */

        }
    });


	var html1 ='<div class="row" style="margin-bottom:5px;">';
	 html1 +='<label class="input-label-sm">기간</label>';
	 html1 +='<div class="form-group input-sub m-0 row">';
	 html1 +='<input class="form-control mr-2" style="width: 150px;" type="month" id="chooseDate1" />';				
	 html1 +='</div>';
	 html1 +='<button type="button" class="btn btn-primary mr-2" id="btnRetv">조회</button>';			
	 html1 +='<button type="button" class="btn btn-primary float-right ml-2 " id="priceButton">단가 입력</button>';			

	 html1 +='</div>';
	 //$('#purchaseOutputHistTable_length').html(html1);

	 $('#chooseDate1').val(moment(outputHistDate).format("YYYY-MM"));



	 var html2 ='<div class="row" style="margin-bottom:5px;">';
	 html2 +='&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">기간</label>';
	 html2 +='<div class="form-group input-sub m-0 row">';
	 html2 +='<select class="custom-select" style="width: 150px;" id="chooseDate2" ></select>';				
	 html2 +='</div>';
     html2 +='';
	 html2 +='&nbsp;&nbsp;';
	 html2 += '<select class="custom-select float-left mr-1" id="qutyCd" style="width:100px;"></select>';
	 html2 +='&nbsp;&nbsp;';				
	 html2 +='<button type="button" class="btn btn-primary" id="btnRetv2">조회</button>';
	 html2 +='&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control number-float0 mr-2" id="allInputSetting"  min=0 max=99999 value="0" style="width:100px;" ></input>';
	 html2 +='<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecuteAll" >전체일괄입력</button> ';

	 html2 +='</div>';

	 $('#priceList_length').html(html2);

	 $('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
	 
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
    	outputHistDate =  $('#chooseDate1').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable').DataTable().ajax.reload( function () {});	
		$('#purchaseOutputHistTable2').DataTable().ajax.reload( function () {});	
		
    });	

    $(document).on('click','#btnRetv2', function() {
    	outputHistDate2 =  $('#chooseDate2').val().replace(/-/g,"");	
    	qutyCd = $('#qutyCd option:selected').val();
    	$('.first-table').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
		
       		monthProductPresentTable = monthProductPresentTableFunc();
       		$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
        	selectBoxAppend(qutyList, "qutyCd", qutyCd , "");        
        });
    	
    });	

    //전체 일괄입력
	$(document).on('click','#btnEquipInputExecuteAll', function() {
		var allInputSetting = $("#allInputSetting").val().replace(/-/g,"");
		if (allInputSetting == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#allInputSetting').select();
			return false;
		}
		$('#my-spinner').show();
	
		for (var i=0; i<matrlCodeList.length; i++) {
			for (var j=0; j<12; j++) {
				$('#' + matrlCodeList[i].matrlCd + 'count' + (j+1)).val(allInputSetting);				
			}
		}		
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
	});

	$('#priceButton').on('click',function(){
		//$('#priceDate').val(outputHistDate2.substring(0,7));
		//$('#price').val("0");
		$('#pricePopupModal').modal('show');
		qutyCd = '';
		outputHistDate2  = "${serverDate}";
		$('.first-table').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
		
       		monthProductPresentTable = monthProductPresentTableFunc();
            $('#priceList_length').html(html2);
            setDateBox();
       	 	$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
         	selectBoxAppend(qutyList, "qutyCd", "", "2");    
       		
        });
		
	});
		


    // 보기
    $('#priceList tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#priceList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');

			matrlCd = priceList.row(this).data().matrlCd;
    		var planDate = priceList.row(this).data().planDate;

          /*   $.ajax({
    			url: '<c:url value="br/readMatrlCodeListWithPriceRead"/>',
    			type: 'GET',
    			async: false,
    			datatype: 'json',
    	        data:  {
    				'menuAuth'			:		function(){return menuAuth;},
    				'matrlCd'			:		function(){return matrlCd;},
    				'planDate'			:		function(){return planDate;},
    			
    					
    	        },
    			success: function (res) {
       	            let result = res.result;
       	            let data = res.data;
       	            if (res.result == 'ok') {	   	     		
    	   	     		if(data == null){
    	   	     			$('#priceDate').val(outputHistDate.substring(0,7));
    	   	 				$('#price').val("0");
        	   	     	} else{
        	   	     	data.planDate = data.planDate + '01';
						
        	   	     		$('#priceDate').val( moment(data).format("YYYY-MM-dd").substring(0,7));
        	   				$('#price').val(data.price);
            	   	     }        	
    				}
       	            else if(res.result == 'error'){
    					toastr.error(res.message, '', {timeOut: 5000});
    				}
       	        },
       	        complete:function(){   	        
       	        	
    			}
    		}); */
        }
    });

	$('#priceSave').on('click',function(){ 
		/* if($("#priceList").find(".selected").length != 1){
        	toastr.warning("리스트에서 추가할 항목을 선택해주세요!");
			return false;
        }
		if ($('#priceDate').val() == "" ) {
    		toastr.warning("년월을 입력해주세요.");
    		$('#priceDate').focus();
			return false;
    	}
		if ($('#price').val() == "" || $('#price').val() == '0') {
    		toastr.warning("구매량을 입력해주세요.");
    		$('#price').focus();
			return false;
    	} */

		if($("#chooseDate2 option:selected").val() == ''){
        	toastr.warning("날짜를 선택해 주세요.");
			return false;
        }

		var dataList = new Array();
		$.each($('#priceList tbody tr'),function(idx, itm){	 
			var matrlCd		= $('#priceList').DataTable().row(this).data().matrlCd;
			var planDate	= $("#chooseDate2 option:selected").val();				
			var rowData001	= new Object();
			
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.matrlCd	=  matrlCd;
		 	rowData001.planDate	= planDate;
		 	
			rowData001.count1 = removeCommas($('#' + matrlCd + 'count1').val());
			rowData001.count2 = removeCommas($('#' + matrlCd + 'count2').val());
			rowData001.count3 = removeCommas($('#' + matrlCd + 'count3').val());
			rowData001.count4 = removeCommas($('#' + matrlCd + 'count4').val());
			rowData001.count5 = removeCommas($('#' + matrlCd + 'count5').val());
			rowData001.count6 = removeCommas($('#' + matrlCd + 'count6').val());
			rowData001.count7 = removeCommas($('#' + matrlCd + 'count7').val());
			rowData001.count8 = removeCommas($('#' + matrlCd + 'count8').val());
			rowData001.count9 = removeCommas($('#' + matrlCd + 'count9').val());
			rowData001.count10 = removeCommas($('#' + matrlCd + 'count10').val());
			rowData001.count11 = removeCommas($('#' + matrlCd + 'count11').val());
			rowData001.count12 = removeCommas($('#' + matrlCd + 'count12').val());		
			
			dataList.push(rowData001);	
		});
		   	

		$('#my-spinner').show();		
		
		let url = '<c:url value="br/readMatrlCodeListWithPriceCreate"/>';
			
		$.ajax({
			url: url,
			type: 'POST',
            data: JSON.stringify(dataList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
			success: function (res) {
   	            let result = res.result;
   	            if (res.result == 'ok') {	   	     		
	   	     		toastr.success("구매량 저장되었습니다.");     	            	
				}
   	            else if (res.result == 'fail'){		   	     		
		   	 			toastr.error("구매량 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
				} else if(res.result == 'error'){
					toastr.error(res.message, '', {timeOut: 5000});
					
				}
   	        },
   	        complete:function(){   	        
   	        	$('#my-spinner').hide();   	        	
			}
		});
		
		
	});

	$('#priceDelete').on('click',function(){
        if($("#priceList").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }

        var planDate = $('#priceDate').val();
		
    	$.ajax({
	           url: '<c:url value="br/readMatrlCodeListWithPriceDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'			: 	menuAuth,
	        	   'matrlCd'			:		function(){return matrlCd;},
				    'price'				:		function(){return $('#price').val();},
					'planDate'       	:       function(){return planDate.replace(/-/g,"");},
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#priceList').DataTable().ajax.reload( function () {});
					toastr.success("삭제되었습니다.");
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
			}
		});
    });

	function createHeader(){
		return new Promise((resolve, reject)=> {
			var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">자재명</th>';							
			
				for (var i=1; i<13; i++) {
					
					planHeader += '<th class="text-center" style="vertical-align:middle;  min-width:70px;">' + i + '월' + '</th>';
					
				}
				//console.log(planHeader);
				$('#planHeader2').html(planHeader).promise().done(function(){						
					resolve();
				});	
								
			
		});
    }

    function monthProductPresentTableFunc(){
        //console.log("난 테이블이야")
        let tempTableData = $('#priceList').DataTable({
        		language: lang_kor,
        		paging: true,
        		info: false,
        		ordering: false,
        		processing: true,
        		lengthChange: true,
        		searching: true,
        		autoWidth: false,
        		pageLength: 10000,
                ajax: {
        			url: '<c:url value="/br/readMatrlCodeListWithPrice"/>',
        			type: 'GET',
        			async: false,
        			data: {
        				'menuAuth'		: 	menuAuth,		
        				'planDate'		: function() { return outputHistDate2.substring(0,7).replace(/-/g, ''); },  
        				'qutyCd'		: function() { return qutyCd; },        	
        			},
        	    },
        	    rowId: '',
        		columns: [
        			{ data: 'matrlNm'},
        			{ data: 'count1',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count1" name="count1" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count2',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count2" name="count2" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count3',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count3" name="count3" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count4',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count4" name="count4" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count5',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count5" name="count5" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count6',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count6" name="count6" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count7',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count7" name="count7" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count8',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count8" name="count8" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count9',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count9" name="count9" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count10',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count10" name="count10" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count11',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count11" name="count11" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        			{ data: 'count12',
        				render: function(data, type, row) {
        					return '<input type="text" class="form-control number-float0" max="999999" min="0" id="' + row["matrlCd"] + 'count12" name="count12" value="' + addCommas(data) + '" /></input>';
        				}
        			},
        		],
        	    columnDefs: [
        	    	{ targets: [0], className: 'text-center' },        	    	
        	    
        	    ],
        		order: [
        			[ 0, 'asc' ],
        		],
        	
        		drawCallback: function(settings) {
        		}
            });

        $('#priceList_length').html(html2);
        setDateBox();
   	 	$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
     	selectBoxAppend(qutyList, "qutyCd", "", "2");    

        return tempTableData;
    }

    function setDateBox(){
        var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();     
   
        for(var y = (com_year-3); y <= (com_year+5); y++){
            $("#chooseDate2").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
        }
   
        $("#chooseDate2").val(com_year);
    }

    //숫자만 입력, 길이, 정수만 입력
    $(document).on('keyup','.number-float0', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109)	) {
			//$('.number-float0').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("");
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}

 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		// .개수 세기
		if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        $(this).val(addCommas(temp));
        
	});

    $('#tab1').click(function() {
		$('#View1').removeClass("d-none");
		$('#View2').addClass("d-none");	
		
		outputHistDate =  $('#chooseDate1').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable').DataTable().ajax.reload();
	
	});

    $('#tab2').click(function() {
		$('#View1').addClass("d-none");
		$('#View2').removeClass("d-none");
	
		outputHistDate =  $('#chooseDate1').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable2').DataTable().ajax.reload();
		
	});


</script>

</body>
</html>
