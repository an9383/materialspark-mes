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
				<li class="breadcrumb-item active">원자재수급관리</li>
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
					 	<label class="input-label-sm ml-1 tab1SelectCond">기간</label> 
						<div class="form-group input-sub m-0 row tab1SelectCond">
							<input class="form-control mr-2" style="width: 150px;" type="month" id="chooseDate1" />						
						</div>
						<label class="input-label-sm d-none tab3SelectCond">일자</label>
						<div class="form-group input-sub mr-2 row d-none tab3SelectCond">
							<input class="form-control " style="width:97px;" type="text" id="chooseDate3" name="inWhsDateCal" />
							<button onclick="fnPopUpCalendar(chooseDate3,chooseDate3, 'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseDate3Cendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						<div class="form-group input-sub mr-2 row d-none tab4SelectCond">
							<label class="input-label-sm">년도</label>							
							<select class="custom-select" style="width: 150px;" id="chooseDate5" ></select>											
						</div>
						<label class="input-label-sm mr-2 tab3SelectCond d-none">자재명</label>
						<!--<select class="custom-select mr-2 tab3SelectCond d-none" id="matrlCodeList"></select>-->
						<div class="multipleSelection pos-real mr-2 d-none" id="showMatrlList">
							<div class="selectBox selectBox1" onclick="showmatrlCheckboxes()">
								<select class="custom-select custom-select1 w-120" id="selectMatrlCodeList">
									<option>자재 목록</option>
								</select>
								<div class="overSelect"></div>
							</div>
							<div id="checkBoxes1" class="checkBoxes1 selectBoxOverFlow" style="height:300px;"></div>
						</div>
						<label class="input-label-sm tab1SelectCond ml-2"> 조회 대상 </label>
						<select class="custom-select mr-2 ml-2 tab1SelectCond" id="dateGubun" style="width:100px;">
							<option value="1">전체</option>
							<option value="2">오늘까지</option>						
						</select>
						<button type="button" class="btn btn-primary mr-2" id="btnRetv">조회</button>			
						<button type="button" class="btn btn-primary float-right ml-2 " id="buyButton">구매량 입력</button>			
						<button type="button" class="btn btn-primary float-right ml-2 " id="yieldButton">수율 입력</button>			
						<!-- <label class="input-label-sm d-none tab3SelectCond ml-2" style="float:right;">*MP 사용일수 계산식 : (전월재고 - 생산불출량 + 가입고량 ) / (생산불출량 - 생산실재고) / 날짜</label> -->
						<label class="input-label-sm d-none tab3SelectCond ml-2" style="float:right;">*MP 사용일수 계산식 :  필요량 / 30 / 재고량 </label>
					</div>
					<div class="card-header card-tab" style="margin-bottom: 10px;">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab3">수급계획현황</a></li>
							<li class="nav-item"><a class="nav-link " data-toggle="tab" id="tab1">기종별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">기종별 생산계획대비</a></li>	
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">실적관리</a></li>	
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">생산대비사용율</a></li>				
										
						</ul>
					</div>
				<!-- .table-responsive -->
				<div id="View1" class="d-none">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable" class="table table-bordered">
							<colgroup>
									<col width="30%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="6%">
									<col width="6%">
									<col width="14%">
							</colgroup>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>자재</th>
									<th>입고계획</th>
									<th>실 입고량</th>	
									<th>불량</th>								
									<th>차이량</th>		
									<th>입고율</th>
									<th>불량자재입고율</th>
									<th>비고</th>
								</tr>
							</thead>							
						</table>
					</div>
					<div class="table-responsive">
						<table id="purchaseOutputHistTableSub" class="table table-bordered">
							<colgroup>
									<col width="30%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="6%">
									<col width="6%">
									<col width="14%">
							</colgroup>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>자재</th>
									<th>입고계획</th>
									<th>실 입고량</th>
									<th>불량</th>
									<th>차이량</th>		
									<th>입고율</th>
									<th>불량자재입고율</th>
									<th>비고</th>
								</tr>
							</thead>							
						</table>
					</div>
				</div>
				<!-- .table-responsive -->
				<div id="View2" class="d-none">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable2" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>기종별 구분</th>
									<th>자재</th>
									<th>생산 계획</th>								
									<th>출하 계획</th>
									<th>필요 자재량</th>
									<th>구매량</th>
									<th>월말 재고량</th>	
									<th>월말 재고일수</th>
											
								</tr>
							</thead>
							<tfoot>
								<tr style="background-color:#edacb1; color:red">
									<td colspan="2" style="text-align: center">종합</td>
											
									<td colspan="" id="sum21" style="text-align: right">0</td>															
									<td colspan="" id="sum22" style="text-align: right">0</td>			
									<td colspan="" id="sum23" style="text-align: right">0</td>			
									<td colspan="" id="sum24" style="text-align: right">0</td>
									<td colspan="" id="sum25" style="text-align: right">0</td>
									<td colspan="" id="sum26" style="text-align: right">0</td>
								</tr>							
							</tfoot>
						</table>
					</div>
				</div>
				<div id="View3" class="">
					<div class="table-responsive first-table">
						<table id="purchaseOutputHistTable3" class="table table-bordered">
							<thead class="thead-light">
								<tr id="planHeader"></tr>
							</thead>
						</table>
					</div>
				</div>
				<div id="View4" class="">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable4" class="table table-bordered">
							<colgroup>
								<col width="9%">
								<col width="9%">
								<col width="9%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">									
							</colgroup>				
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>자재</th>
									<th>구분</th>
									<th>누계</th>
									<th>1월</th>
									<th>2월</th>		
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
									
								</tr>
							</thead>	
						</table>
					</div>
				</div>
				<div id="View5" class="d-none">
					<div class="table-responsive">
						<table id="purchaseOutputHistTable5" class="table table-bordered">
							<colgroup>
								<col width="9%">
								<col width="9%">
								<col width="9%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">
								<col width="6%">									
							</colgroup>				
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>자재</th>
									<th>구분</th>
									<th>누계</th>
									<th>1월</th>
									<th>2월</th>		
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>
									
								</tr>
							</thead>	
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


<!-- 구매량입력 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="buyPopupModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="buyPopupModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="min-width:1500px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="buyPopupModalLabel">구매량입력 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body"> 
	            	<div class="card">                  
	                	<div class="table-responsive second-table">
		                	<table id="buyList" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr id="planHeader2">
		                           		                                                
		                            </tr>
		                        </thead> 
		                    </table>
		                </div>
		            </div>	
		        <!-- /.page-section -->			
      </div>
      <div class="modal-footer">
      	<!-- <button type="button" class="btn btn-danger mr-a touch6" id="priceDelete"  style="min-width:70px;">삭제</button> -->
      	<button type="button" class="btn btn-primary" id="buySave"  style="min-width:70px;">저장</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 구매량입력 모달 끝-->

<!-- 수율 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="yieldPopupModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="yieldPopupModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="min-width:1500px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="yieldPopupModalLabel">수율입력 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body"> 
	            	<div class="card">                  
	                	<div class="table-responsive third-table">
		                	<table id="yieldList" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr id="planHeader3">
		                           		                                                
		                            </tr>
		                        </thead> 
		                    </table>
		                </div>
		            </div>	
		        <!-- /.page-section -->			
      </div>
      <div class="modal-footer">
      	<!-- <button type="button" class="btn btn-danger mr-a touch6" id="priceDelete"  style="min-width:70px;">삭제</button> -->
      	<button type="button" class="btn btn-primary" id="yieldSave"  style="min-width:70px;">저장</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 수율 모달 끝-->

<%@include file="../layout/bottom.jsp"%>
<style>
.redClass {
    border-bottom : solid 2px black !important;
}
table.dataTable{

	border-collapse: collapse !important;
}
</style>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'brsc0020';
	let currentHref = 'brsc0020';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","원자재 수급 관리");
    let viewIdx;
    let sideView = 'add';
	var outputHistDate =  "${serverDate}";
	var outputHistDate5 = "${serverDate}";
	var thisDay = outputHistDate.substring(8)- 1;
	var outputHistDate3 = outputHistDate.substring(0,8) + thisDay;	
	var outputHistDate2 =  "${serverDate}";
	var outputHistDate4 =  "${serverDate}";
	var qutyCd = '';
	var matrlCd = '';
	var temp = true;
	let dateGubun = '1';

	setDateBox3();
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
		json.matrlSelectYn = "${info.matrlSelectYn}";
		matrlCodeList.push(json);
	</c:forEach>

	selectMatrlBoxAppend(matrlCodeList, "matrlCodeList", "", "1");   
	
	createHeader();

	createHeader2(); //구매량

	createHeader3(); //수율

	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin2 = $('#buyList').parent().html();
	let monthProductPresentTableOrigin3 = $('#yieldList').parent().html();
	let monthProductPresentTable2 = monthProductPresentTableFunc2();	
	let monthProductPresentTable3 = monthProductPresentTableFunc3();	

	
    // 목록1
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable = $('#purchaseOutputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        //scrollY: '67.5vh',
        lengthChange : false,
        pageLength: 18,
        ajax: {
            url: '<c:url value="/br/readMonthPlanListTab11"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate' : function() { return outputHistDate.substring(0,7).replace(/-/g, ''); },        
	           	'dateGubun' :  function() { return dateGubun;}	
	           	 
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
             { data: 'matrlNm'},
            { data: 'cnt',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },
            { data: 'preInWhsQty',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },			
			 { data: 'faultyQty',
	            	render: function(data, type, row) {	
						return addCommas(parseFloat(data).toFixed(1));
					}
				 },
            { data: 'diffQty',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },
            { data: 'ibgo',
            	render: function(data, type, row) {	
                	var result = data;				
					if(data != 0 && data != null){
						return addCommas(parseFloat(result).toFixed(1)) + '%';;
					} else{
						return '0%';
					}
					
				}
			 }, 
            { data: 'gyul',
            	render: function(data, type, row) {		
            		var result = data;					
            		if(data != 0 && data != null){
						return addCommas(parseFloat(result).toFixed(1)) + '%';;
					} else{
						return '0%';
					}
				}
			 },
            { data: 'bigo' },           			        			
                   
        ],
        columnDefs: [
        	{ targets: [1,2,3,4], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수급 관리/기종별',
            },
            {
                extend: 'excel',
                title: '원자재 수급 관리/기종별',
            },
            {
                extend: 'print',
                title: '원자재 수급 관리/기종별',
            },
        ],
        drawCallback: function () {
			$('#purchaseOutputHistTable tbody tr').each(function() {
			 	if ($(this).find('td').eq(0).text() == 'AL 합계' || $(this).find('td').eq(0).text() == 'NICU 합계' || $(this).find('td').eq(0).text() == 'FILM 합계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}
			});
		}
	});

	let html1 = '';
		html1 = '<label class="float-left">당월로 조회됩니다.</label>';
	$('#purchaseOutputHistTable_wrapper').prepend(html1);

	let purchaseOutputHistTableSub = $('#purchaseOutputHistTableSub').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        //scrollY: '67.5vh',
        lengthChange : false,
        pageLength: 18,
        ajax: {
            url: '<c:url value="/br/readMonthPlanListTab12"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate.substring(0,7).replace(/-/g, ''); },     
	           	'dateGubun' :  function() { return dateGubun;}	   	
	           	 
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
           { data: 'matrlNm'},
            { data: 'cnt',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },
            { data: 'preInWhsQty',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },			
			 { data: 'faultyQty',
	            	render: function(data, type, row) {	
						return addCommas(parseFloat(data).toFixed(1));
					}
				 },
            { data: 'diffQty',
            	render: function(data, type, row) {	
					return addCommas(parseFloat(data).toFixed(1));
				}
			 },
            { data: 'ibgo',
            	render: function(data, type, row) {	
                	var result = data;				
					if(data != 0 && data != null){
						return addCommas(parseFloat(result).toFixed(1)) + '%';;
					} else{
						return '0%';
					}
					
				}
			 }, 
            { data: 'gyul',
            	render: function(data, type, row) {		
            		var result = data;					
            		if(data != 0 && data != null){
						return addCommas(parseFloat(result).toFixed(1)) + '%';;
					} else{
						return '0%';
					}
				}
			 },
            { data: 'bigo' },           			
                   
        ],
        columnDefs: [
        	{ targets: [1,2,3,4], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4], className: 'text-right-td' },
        ],
       
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수급 관리/기종별',
            },
            {
                extend: 'excel',
                title: '원자재 수급 관리/기종별',
            },
            {
                extend: 'print',
                title: '원자재 수급 관리/기종별',
            },
        ],
        drawCallback: function () {
			$('#purchaseOutputHistTableSub tbody tr').each(function() {
			 	if ($(this).find('td').eq(0).text() == 'AL 합계' || $(this).find('td').eq(0).text() == 'NICU 합계' || $(this).find('td').eq(0).text() == 'FILM 합계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}
			});
		}
	});

	html1 = '';
	html1 = '<label class="float-left">전일로 조회됩니다.</label>';
	$('#purchaseOutputHistTableSub_wrapper').addClass('mt-2');
	$('#purchaseOutputHistTableSub_wrapper').prepend(html1);
	
    // 목록2
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable2 = $('#purchaseOutputHistTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        //scrollY: '67.5vh',
        lengthChange : false,
        pageLength: 18,
        ajax: {
            url: '<c:url value="/br/readMonthPlanListTab2"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate.substring(0,7).replace(/-/g, ''); },        	
	           	'dateGubun' :  function() { return dateGubun; }	
	           	 
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
        	{ data: 'goodsNm'},
            { data: 'matrlNm'},
            { data: 'countSum',
            	render: function(data, type, row) {	                			
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
					
				}
			 },
			{ data: 'poQty',
            	render: function(data, type, row) {	                			
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
					
				}
			 },
	        { data: 'cnt',
            	render: function(data, type, row) {	 
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
				}
			 },
            { data: 'countSum2',name:'ggg',
            	render: function(data, type, row) {	                			
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
					
				}
			 },
			 { data: 'sumRemain',name:'ggg',
	            	render: function(data, type, row) {	 
	            		var result = data;               			
						if(data != 0 && data != null){
							result = parseFloat(data).toFixed(1);
							result = addCommas(result);
						} else{
							result = '0';
						}
						return result;
					}
			},
			 { data: 'stockDate',name:'ggg',
            	render: function(data, type, row) {	 
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
				}
			},
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7], className: 'text-right-td' },
        ],
        rowsGroup: ['ggg:name'],
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수급 관리/기종별 생산계획대비',
            },
            {
                extend: 'excel',
                title: '원자재 수급 관리/기종별 생산계획대비',
            },
            {
                extend: 'print',
                title: '원자재 수급 관리/기종별 생산계획대비',
            },
        ],
        drawCallback: function () {
			//전역변수들
        	var sum21  = 0 ;
			var sum22  = 0 ;
			var sum23  = 0 ;	
			var sum24  = 0 ;
			var sum25  = 0 ;
        	var sum26  = 0 ;
			var sum27  = 0 ;
			var sum28  = 0 ;	
			var sum29  = 0 ;
			var sum30  = 0 ;
		

			sum21 = ($('#purchaseOutputHistTable2').DataTable().column(2,{ page: 'all'} ).data().sum()/2);
			sum22 = ($('#purchaseOutputHistTable2').DataTable().column(3,{ page: 'all'} ).data().sum()/2);

			
		/* 	sum26 = ($('#purchaseOutputHistTable2').DataTable().column(1,{ page: 'all'} ).data().sum());
			sum27 = ($('#purchaseOutputHistTable2').DataTable().column(2,{ page: 'all'} ).data().sum());
			
			sum28 = ($('#purchaseOutputHistTable2').DataTable().column(1,{ page: 'all'} ).data().sum()*2.2599/0.8263/1000 );
			sum29 = ($('#purchaseOutputHistTable2').DataTable().column(4,{ page: 'all'} ).data().sum() / 2);
			sum30 = ($('#purchaseOutputHistTable2').DataTable().column(5,{ page: 'all'} ).data().sum() / 2); */
			

			
			$('#sum21').text(addCommas(sum21.toFixed(1)));	
			$('#sum22').text(addCommas(sum22.toFixed(1)));	

		/* 	$('#sum26').text(addCommas(sum26.toFixed(0)));
			$('#sum27').text(addCommas(sum27.toFixed(0)));
			$('#sum28').text(addCommas(sum28.toFixed(0))); */

			$('#purchaseOutputHistTable2 tbody tr').each(function(){
			 	
			 	if($(this).find('td').eq(0).text() == 'AL 합계' || $(this).find('td').eq(0).text() == 'NICU 합계') {
					$(this).css('background-color','#aed3ec');
					$(this).css('color','blue');
			 	}	
			});

        }
    });

	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#purchaseOutputHistTable3').parent().html();
	let purchaseOutputHistTable3 = monthProductPresentTableFunc();


	let tab4Gubun = '';
	let tab4colorStat = false;
	   // 목록2
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable4 = $('#purchaseOutputHistTable4').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: false,
        info: true,
        searching: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        scrollY: '57vh',
        lengthChange : false,
        pageLength: 999999,
        
        ajax: {
            url: '<c:url value="/br/performanceMatrl"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate5.replace(/-/g, ''); }, 
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
        	{ data: 'matrlNm',name:'ggg'},
            { data: 'gubunNm'},
            { data: 'countSum',
            	render: function(data, type, row) {	                			
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
					} else{
						result = '0';
					}
					return result;
					
				}
			 },
			 <c:forEach var="item" begin="1" end="12" step="1">
	         	{ data: 'count${item}',
	            	render: function(data, type, row) {	                			
	            		var result = data;               			
						if(data != 0 && data != null){
							result = parseFloat(data).toFixed(2);
							result = addCommas(result);
						} else{
							result = '0';
						}
						return result;
						
					}
			},    		
 			</c:forEach>
			
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14], className: 'text-right-td' },
        ],
        rowsGroup: ['ggg:name'],
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수급 관리/실적관리',
            },
            {
                extend: 'excel',
                title: '원자재 수급 관리/실적관리',
            },
            {
                extend: 'print',
                title: '원자재 수급 관리/실적관리',
            },
        ],
        createdRow: function (row, data, dataIndex) {
			
			
    		if(tab4Gubun != data["matrlNm"]){
    			tab4Gubun = data["matrlNm"];
    			tab4colorStat = !tab4colorStat;
			}
    		if(tab4colorStat){
				$(row).css('background-color','#F2F2F2');
    		} else{
    			$(row).css('background-color','#ffffff');	            			
        	}
    	
		},
        drawCallback: function () {
			
        }
    });

	let tab5Gubun = '';
	let tab5colorStat = false;
	   // 목록2
    $.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputHistTable5 = $('#purchaseOutputHistTable5').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: false,
        info: true,
        searching: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        scrollY: '57vh',
        lengthChange : false,
        pageLength: 999999,
        
        ajax: {
            url: '<c:url value="/br/performanceMatrl2"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return outputHistDate5.replace(/-/g, ''); }, 
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
        	{ data: 'matrlNm',name:'gg'},
            { data: 'gubunNm'},
            { data: 'countSum',
            	render: function(data, type, row) {	                			
            		var result = data;               			
					if(data != 0 && data != null){
						result = parseFloat(data).toFixed(1);
						result = addCommas(result);
						if(row['gubun']=='5'){
							result = result + '%';
						}
					} else{
						result = '0';
					}
					return result;
					
				}
			 },
			 <c:forEach var="item" begin="1" end="12" step="1">
	         	{ data: 'count${item}',
	            	render: function(data, type, row) {	                			
	            		var result = data;               			
						if(data != 0 && data != null){							
							result = parseFloat(data).toFixed(2);
							result = addCommas(result);
							if(row['gubun']=='5'){
								result = result + '%';
							}
							
						} else{
							result = '0';
						}
						return result;
						
					}
			},    		
 			</c:forEach>
			
        ],
        columnDefs: [
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14], className: 'text-right-td' },
        ],
        rowsGroup: ['gg:name'],
        buttons: [
            {
                extend: 'copy',
                title: '원자재 수급 관리/생산대비사용율',
            },
            {
                extend: 'excel',
                title: '원자재 수급 관리/생산대비사용율',
            },
            {
                extend: 'print',
                title: '원자재 수급 관리/생산대비사용율',
            },
        ],
        createdRow: function (row, data, dataIndex) {
			
			
    		if(tab5Gubun != data["matrlNm"]){
    			tab5Gubun = data["matrlNm"];
    			tab5colorStat = !tab5colorStat;
			}
    		if(tab5colorStat){
				$(row).css('background-color','#F2F2F2');
    		} else{
    			$(row).css('background-color','#ffffff');	            			
        	}
    	
		},
        drawCallback: function () {
        	$('#purchaseOutputHistTable5').rowspan(0);
        }
    });
	

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

	$('#buyList_length').html(html2);

	$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
	 
	$('#chooseDate1').val(moment(outputHistDate).format("YYYY-MM"));
	$('#chooseDate3').val(moment(outputHistDate3).format("YYYY-MM-DD"));

	 var html4 ='<div class="row" style="margin-bottom:5px;">';
	 html4 +='&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">기간</label>';
	 html4 +='<div class="form-group input-sub m-0 row">';
	 html4 +='<select class="custom-select" style="width: 150px;" id="chooseDate4" ></select>';				
	 html4 +='</div>';
     html4 +='';
	 html4 +='&nbsp;&nbsp;';
	 html4 += '<select class="custom-select float-left mr-1" id="qutyCd2" style="width:100px;"></select>';
	 html4 +='&nbsp;&nbsp;';				
	 html4 +='<button type="button" class="btn btn-primary" id="btnRetv3">조회</button>';
	 html4 +='&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" class="form-control number-float0 mr-2" id="allInputSettingYield"  min=0 max=999 value="0" style="width:100px;" ></input>';
	 html4 +='<button type="button" class="btn btn-primary mr-2" id="btnMatrlInputExecuteAll" >전체일괄입력</button> ';
	 html4 +='</div>';

	$('#yieldList_length').html(html4);

	$('#chooseDate4').val(moment(outputHistDate4).format("YYYY"));
	

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
    	outputHistDate3 =  $('#chooseDate3').val().replace(/-/g,"");
    	outputHistDate5 =  $('#chooseDate5').val().replace(/-/g,"");	
    	dateGubun = $('#dateGubun').val();
    	if(tapTemp == '1'){
    		$('#purchaseOutputHistTable').DataTable().ajax.reload( function () {});	
    		$('#purchaseOutputHistTableSub').DataTable().ajax.reload( function () {});	
        }
    	if(tapTemp == '2'){
    		$('#purchaseOutputHistTable2').DataTable().ajax.reload( function () {});
        }
    
    	if(tapTemp == '4'){
    		$('#purchaseOutputHistTable4').DataTable().ajax.reload( function () {});
        }

    	if(tapTemp == '5'){
    		$('#purchaseOutputHistTable5').DataTable().ajax.reload( function () {});
        }
        
        
		
		
		
		
		//createHeader();
		//$('#purchaseOutputHistTable3').DataTable().ajax.reload( function () {});		

		$('.first-table').html(monthProductPresentTableOrigin);
    	//showmatrlCheckboxes();
    	document.getElementById("checkBoxes1").style.display = "none";
    	createHeader().then(()=>{
			
       		monthProductPresentTable = monthProductPresentTableFunc();      
       			
        });

    });	

    $(document).on('click','#btnRetv2', function() {
    	outputHistDate2 =  $('#chooseDate2').val().replace(/-/g,"");	
    	qutyCd = $('#qutyCd option:selected').val();


		$('.second-table').html(monthProductPresentTableOrigin2);    
    	
    	createHeader2().then(()=>{
			
       		monthProductPresentTable2 = monthProductPresentTableFunc2();     
       		$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
        	selectBoxAppend(qutyList, "qutyCd", qutyCd , "1");
       			
        });

    });	

    $(document).on('click','#btnRetv3', function() {
    	outputHistDate4 =  $('#chooseDate4').val().replace(/-/g,"");	
    	qutyCd = $('#qutyCd2 option:selected').val();


		$('.third-table').html(monthProductPresentTableOrigin3);    
    	
    	createHeader3().then(()=>{
			
       		monthProductPresentTable3 = monthProductPresentTableFunc3();     
       		$('#chooseDate4').val(moment(outputHistDate4).format("YYYY"));
        	selectBoxAppend(qutyList, "qutyCd2", qutyCd , "1");
       			
        });

    });	
    
	$('#tab1').click(function() {
		$('#View1').removeClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		$('#showMatrlList').addClass("d-none");
		$('.tab3SelectCond').addClass("d-none");
		$('.tab1SelectCond').removeClass("d-none");
		$('.tab4SelectCond').addClass("d-none");
		tapTemp = 1;
		outputHistDate =  $('#chooseDate1').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable').DataTable().ajax.reload();
		$('#purchaseOutputHistTableSub').DataTable().ajax.reload();
	});
	
	$('#tab2').click(function() {
		$('#View1').addClass("d-none");		
		$('#View2').removeClass("d-none");	
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		$('#showMatrlList').addClass("d-none");
		$('.tab3SelectCond').addClass("d-none");
		$('.tab1SelectCond').removeClass("d-none");
		$('.tab4SelectCond').addClass("d-none");
		tapTemp = 2;
		outputHistDate =  $('#chooseDate1').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable2').DataTable().ajax.reload();
	});

	$('#tab3').click(function() {
		$('#View1').addClass("d-none");
		$('#View2').addClass("d-none");
		$('#View3').removeClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').addClass("d-none");
		$('.tab1SelectCond').addClass("d-none");
		$('#showMatrlList').removeClass("d-none");
		$('.tab3SelectCond').removeClass("d-none");
		$('.tab4SelectCond').addClass("d-none");
		tapTemp = 3;	
		outputHistDate3 =  $('#chooseDate3').val().replace(/-/g,"");	
		//createHeader();
		//$('#purchaseOutputHistTable3').DataTable().ajax.reload();
		$('.first-table').html(monthProductPresentTableOrigin);
    
    	
    		createHeader().then(()=>{
			
       		monthProductPresentTable = monthProductPresentTableFunc();      
       			
        });
	});

	$('#tab4').click(function() {
		$('#View1').addClass("d-none");		
		$('#View2').addClass("d-none");	
		$('#View3').addClass("d-none");
		$('#View4').removeClass("d-none");
		$('#View5').addClass("d-none");
		$('#showMatrlList').addClass("d-none");
		$('.tab3SelectCond').addClass("d-none");
		$('.tab1SelectCond').addClass("d-none");
		$('.tab4SelectCond').removeClass("d-none");
		
		tapTemp = 4;
		outputHistDate5 =  $('#chooseDate5').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable4').DataTable().ajax.reload();
		$('#purchaseOutputHistTable4').DataTable().draw(false).columns.adjust();
	});

	$('#tab5').click(function() {
		$('#View1').addClass("d-none");		
		$('#View2').addClass("d-none");	
		$('#View3').addClass("d-none");
		$('#View4').addClass("d-none");
		$('#View5').removeClass("d-none");
		$('#showMatrlList').addClass("d-none");
		$('.tab3SelectCond').addClass("d-none");
		$('.tab1SelectCond').addClass("d-none");
		$('.tab4SelectCond').removeClass("d-none");
		
		tapTemp = 5;
		outputHistDate5 =  $('#chooseDate5').val().replace(/-/g,"");	
		$('#purchaseOutputHistTable5').DataTable().ajax.reload();
		$('#purchaseOutputHistTable5').DataTable().draw(false).columns.adjust();
	});
	
	$('#buyButton').on('click',function(){
		
		$('#buyPopupModal').modal('show');		
		qutyCd = '';
		outputHistDate2  = "${serverDate}";
		$('.second-table').html(monthProductPresentTableOrigin2);
    	createHeader2().then(()=>{
		
       		monthProductPresentTable2 = monthProductPresentTableFunc2();
            $('#buyList_length').html(html2);
            setDateBox();
       	 	$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
         	selectBoxAppend(qutyList, "qutyCd", "", "1");    
       		
        });
	});

	$('#yieldButton').on('click',function(){
		
		$('#yieldPopupModal').modal('show');		
		qutyCd = '';
		outputHistDate4  = "${serverDate}";
		$('.third-table').html(monthProductPresentTableOrigin3);
    	createHeader3().then(()=>{
		
       		monthProductPresentTable3 = monthProductPresentTableFunc3();
            $('#yieldList_length').html(html4);
            setDateBox2();
       	 	$('#chooseDate4').val(moment(outputHistDate4).format("YYYY"));
         	selectBoxAppend(qutyList, "qutyCd2", "", "1");    
       		
        });
	});
		


    // 보기
    $('#buyList tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#buyList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');

			matrlCd = buyList.row(this).data().matrlCd;
    		var planDate = buyList.row(this).data().planDate;

           /*  $.ajax({
    			url: '<c:url value="br/readMatrlCodeListWithBuyCntRead"/>',
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
    	   	     			$('#buyDate').val(outputHistDate.substring(0,7));
    	   	 				$('#cnt').val("0");
        	   	     	} else{
        	   	     	data.planDate = data.planDate + '01';
						
        	   	     		$('#buyDate').val( moment(data).format("YYYY-MM-dd").substring(0,7));
        	   				$('#cnt').val(data.cnt);
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

	$('#buySave').on('click',function(){
/* 		if($("#buyList").find(".selected").length != 1){
        	toastr.warning("리스트에서 추가할 항목을 선택해주세요!");
			return false;
        }
		if ($('#buyDate').val() == "" ) {
    		toastr.warning("년월을 입력해주세요.");
    		$('#buyDate').focus();
			return false;
    	}
		if ($('#cnt').val() == "" || $('#cnt').val() == '0') {
    		toastr.warning("구매량을 입력해주세요.");
    		$('#cnt').focus();
			return false;
    	} */
    	
		if($("#chooseDate2 option:selected").val() == ''){
        	toastr.warning("날짜를 선택해 주세요.");
			return false;
        }
        
    	var dataList = new Array();
		$.each($('#buyList tbody tr'),function(idx, itm){	 
			var planDate =  $("#chooseDate2 option:selected").val();		
			var matrlCd = $('#buyList').DataTable().row(this).data().matrlCd;				
			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.matrlCd =  matrlCd;
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
			rowData001.planDate = planDate;
			dataList.push(rowData001);	
		});

	   	
		$('#my-spinner').show();		
		
		let url = '<c:url value="br/readMatrlCodeListWithBuyCntCreate"/>';			
		
		var planDate = $('#buyDate').val();
			
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
   	        	//$('#buyList').DataTable().ajax.reload( function () {});
			}
		});
		
		
	});

	$('#yieldSave').on('click',function(){
		/* 		if($("#buyList").find(".selected").length != 1){
		        	toastr.warning("리스트에서 추가할 항목을 선택해주세요!");
					return false;
		        }
				if ($('#buyDate').val() == "" ) {
		    		toastr.warning("년월을 입력해주세요.");
		    		$('#buyDate').focus();
					return false;
		    	}
				if ($('#cnt').val() == "" || $('#cnt').val() == '0') {
		    		toastr.warning("구매량을 입력해주세요.");
		    		$('#cnt').focus();
					return false;
		    	} */
		    	
				if($("#chooseDate4 option:selected").val() == ''){
		        	toastr.warning("날짜를 선택해 주세요.");
					return false;
		        }
		        
		    	var dataList = new Array();
				$.each($('#yieldList tbody tr'),function(idx, itm){	 
					var planDate =  $("#chooseDate4 option:selected").val();		
					var matrlCd = $('#yieldList').DataTable().row(this).data().matrlCd;				
					var rowData001 = new Object();
				 	rowData001.menuAuth = menuAuth;
				 	rowData001.matrlCd =  matrlCd;
					rowData001.count1 = removeCommas($('#' + matrlCd + 'countYield1').val());
					rowData001.count2 = removeCommas($('#' + matrlCd + 'countYield2').val());
					rowData001.count3 = removeCommas($('#' + matrlCd + 'countYield3').val());
					rowData001.count4 = removeCommas($('#' + matrlCd + 'countYield4').val());
					rowData001.count5 = removeCommas($('#' + matrlCd + 'countYield5').val());
					rowData001.count6 = removeCommas($('#' + matrlCd + 'countYield6').val());
					rowData001.count7 = removeCommas($('#' + matrlCd + 'countYield7').val());
					rowData001.count8 = removeCommas($('#' + matrlCd + 'countYield8').val());
					rowData001.count9 = removeCommas($('#' + matrlCd + 'countYield9').val());
					rowData001.count10 = removeCommas($('#' + matrlCd + 'countYield10').val());
					rowData001.count11 = removeCommas($('#' + matrlCd + 'countYield11').val());
					rowData001.count12 = removeCommas($('#' + matrlCd + 'countYield12').val());		
					rowData001.planDate = planDate;
					dataList.push(rowData001);	
				});

			   	
				$('#my-spinner').show();		
				
				let url = '<c:url value="br/readMatrlCodeListWithYieldCntCreate"/>';			
				
				var planDate = $('#yieldDate').val();
					
				$.ajax({
					url: url,
					type: 'POST',
					 data: JSON.stringify(dataList),
		            dataType:"json",
		            contentType : "application/json; charset=UTF-8",
					success: function (res) {
		   	            let result = res.result;
		   	            if (res.result == 'ok') {	   	     		
			   	     		toastr.success("수율 저장되었습니다.");     	            	
						}
		   	            else if (res.result == 'fail'){		   	     		
				   	 			toastr.error("수율 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
						} else if(res.result == 'error'){
							toastr.error(res.message, '', {timeOut: 5000});
							
						}
		   	        },
		   	        complete:function(){   	        
		   	        	$('#my-spinner').hide();
		   	        	//$('#buyList').DataTable().ajax.reload( function () {});
					}
				});
				
				
	});

	$('#buyDelete').on('click',function(){
        if($("#buyList").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }

        var planDate = $('#buyDate').val();
		
    	$.ajax({
	           url: '<c:url value="br/readMatrlCodeListWithBuyCntDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'			: 	menuAuth,
	        	   'matrlCd'			:		function(){return matrlCd;},
				    'cnt'				:		function(){return $('#cnt').val();},
					'planDate'       	 :       function(){return planDate.replace(/-/g,"");},
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#buyList').DataTable().ajax.reload( function () {});
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
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return outputHistDate3.substring(0,7).replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.reuslt="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						//var planHeader = '<th class="text-center" style="vertical-align:middle; min-width:100px;">라인</th>';
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">자재명</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:130px;">항목</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:130px;">누계</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:130px;">전월재고</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:130px;">생산실재고(전월)</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">불량(실반품)</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">생산실재고(당월)</th>';
						planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">당월재고 합계</th>';
						
						$('#planHeader').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});		
					}
				}
			});
		});
    }

	 function monthProductPresentTableFunc(){
	 		 let matrlList = '';
			 let j = 0;
			for (var i=0; i<matrlCodeList.length; i++) {
				if($('#' + matrlCodeList[i].matrlCd).is(":checked") == true) {
					if (j == 0) {
						matrlList += '\'' + $('#' + matrlCodeList[i].matrlCd).val() + '\'' +',';
					} else{
						matrlList += '\'' + $('#' + matrlCodeList[i].matrlCd).val() + '\'' +',';
					}			
					j++;		
				}
			}
			matrlList = matrlList.slice(0, matrlList.length-1);
 			if (matrlList == '' || matrlList == null){
 				matrlList += '\'' + '\'';
 	 		}


			let colorChange = true;
			let lineBold = true;
 	 		
			let tempTableData = $('#purchaseOutputHistTable3').on( 'error.dt', function ( e, settings, techNote, message ) {
				if(techNote == 7) {
					toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
					location.href = "/";
				}
			}).DataTable({
		        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
						"<'row'<'col-sm-12'tr>>" +
						"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
																			//B
		        language: lang_kor,
		        paging: false,
		        info: true,       
		        ordering: false,
		        processing: true,
		        autoWidth: false,
		        scrollX : false,
		        pageLength: false,
		        searching: false,
		        //destroy: true, 
				scrollY: '67.5vh',
	    		scrollX: true,
				fixedColumns: {
					leftColumns: 4
				},
				ajax: {
		            url: '<c:url value="/br/readMonthPlanListTab3"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'		:		menuAuth,
		            	'planDate'		:		function() { return outputHistDate3.replace(/-/g, ''); },    
		            	'matrlCd'		:		function() { return matrlList; },
		            },
		        },
		        columns: [        	
		        	{ data: 'matrlNm', },
		        	{ data: 'gubunja2'},
					{ data: 'countSum',
						render: function(data, type, row) {
							let html;				
							data = parseFloat(data).toFixed(1);	
							/* if(row['gubunja'] == '8' ||  row['gubunja'] == '91') {
								html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">-</p>';
							} else if(row['gubunja'] == '9'){
								html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">'+'생산재고 : '+data+'</p>';
							}
							 else{ */
								html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
							//}
							return html;
						}
					},
					{ data: 'remainQtyTotal',
						render: function(data, type, row) {
							let html;				
							data = parseFloat(data).toFixed(1);							
							return data;
						}
					},
					{ data: 'sumRemain',
						render: function(data, type, row) {
							let html;				
							data = parseFloat(data).toFixed(1);							
							return data;
						}
					},
					{ data: 'count1',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count2',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}},
					{ data: 'count3',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count4',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count5',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count6',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count7',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count8',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count9',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count10',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count11',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count12',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count13',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count14',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count15',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count16',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count17',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count18',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count19',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count20',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count21',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count22',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count23',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count24',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count25',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count26',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count27',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count28',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count29',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count30',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},
					{ data: 'count31',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},							
				/* 	{ data: 'sumRemain',
						render: function(data, type, row) {
							var result = data;
							if(data == null || data == "null"){
								result = '0.0';
							} else{
								result = parseFloat(data).toFixed(1);
								result = addCommas(result);
							}
							return result;
						}
					},			 */
					{ data: 'faultyQty',
						render: function(data, type, row) {
							let html;	
							if(data == null){
								return "0.0";
							} else{
								data = parseFloat(data).toFixed(1);							
								return data;
							}	
							
						}
					},
					{ data: 'sumQtyTotal',
						render: function(data, type, row) {
							let html;				
							data = parseFloat(data).toFixed(1);							
							return data;
						}
					},
					{ data: 'totalQty',
						render: function(data, type, row) {
							let html;				
							data = parseFloat(data).toFixed(1);							
							return data;
						}
					},
		        ],
				
		        columnDefs: [        	
		        	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38], className: 'text-right-td' },
		        ],      
				buttons: [
					{
					    extend: 'copy',
						title: '생산관리/생산계획 등록',
					},
					{
					    extend: 'excel',
					    title: '생산관리/생산계획 등록',
					},
					{
					    extend: 'print',
					    title: '생산관리/생산계획 등록',
					}
				],				
				 createdRow: function( row, data, dataIndex){
		               // if( data['gubunja2'] ==  '롤수(가입고량)'){
		               //     $(row).addClass('redClass');
		               // }
		               // if( data.gubunja2 ==  '롤수(불량)'){
		               //     $(row).addClass('redClass');
		               // }
		               // if( data.gubunja2 ==  '롤수(불출량)'){
		               //     $(row).addClass('redClass');
		               // }
		               // if( data.gubunja2 ==  '롤수(재고)'){
		               //     $(row).addClass('redClass');
		               // }
		               if( data['gubunja2'] ==  'MP 사용일수'){
		            	   var cnt = 5;
		            	   <c:forEach var="item" begin="1" end="31" step="1">
		           			
	           				if(data['count${item}'] != null ){               				
	           					if(parseInt(data['count${item}']) == 1 || parseInt(data['count${item}']) == 2 ){    
	           						$(row).find('td').eq(cnt).css('color', "red");	         
	           					}
	           					if(parseInt(data['count${item}']) >= 3 && parseInt(data['count${item}']) <= 6){
	           						$(row).find('td').eq(cnt).css('color', "black");	             
	           					}
	           					if(parseInt(data['count${item}']) >= 7 ){  
	           						$(row).find('td').eq(cnt).css('color', "blue");	           
	           					}
           						     			          	
	
	               			}
	           				
	           			            			
	            			cnt ++;
	           			</c:forEach>
		                    $(row).addClass('redClass');
		                }
		               
		            }
	            ,
				drawCallback:function(settings){
                   	let colorStat = false;
   	    			let matrlNm = $(this).find('td').eq(0).text();;
   	    			$('.col-sm-12').css("padding", "0px");   	    		
   	    			let api = this.api();
   	 				let data = api.data();

   	 			
					$.each($('#purchaseOutputHistTable3 tr'),function(index, item) {
    					if($(this).find('td').eq(0).text() != matrlNm){
    						matrlNm = $(this).find('td').eq(0).text();
    						colorStat = !colorStat;
	        			} 
	        			if (colorStat) {
	        				$(this).css('background-color','#ffffff');
	        				
	            		} else {
	            			$(this).css('background-color','#F2F2F2');
	                	}

	                    //if(index == $('#purchaseOutputHistTable3').DataTable().data().count() - 1) {
	                    //	$('#my-spinner').hide();
	                    //}

		    				
						if($('.day27').text()==""){
							//$(this).find('th').eq(29).addClass('d-none');
							$(this).find('td').eq(31).addClass('d-none');
						}
						if($('.day28').text()==""){
							//$(this).find('th').eq(30).addClass('d-none');
							$(this).find('td').eq(32).addClass('d-none');
						}
						if($('.day29').text()==""){
							//$(this).find('th').eq(31).addClass('d-none');
							$(this).find('td').eq(33).addClass('d-none');
						}
						if($('.day30').text()==""){
							//$(this).find('th').eq(32).addClass('d-none');
							$(this).find('td').eq(34).addClass('d-none');
						}
						if($('.day31').text()==""){
							//$(this).find('th').eq(33).addClass('d-none');
							$(this).find('td').eq(35).addClass('d-none');
						}
						
					});
					//$(this).find('td').eq(1).css('border-top','solid 3px red');
					
					$('#purchaseOutputHistTable3').rowspan(0);
					
					if (temp) {
						toastr.success('조회되었습니다');
						temp = false;
					}

					setTimeout(function() {
						$('#my-spinner').hide();
					}, 2000);

				}
		    });

			 return tempTableData;
	
	 }

	function createHeader2(){
		return new Promise((resolve, reject)=> {
			var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">자재명</th>';							
			
				for (var i=1; i<13; i++) {
					
					planHeader += '<th class="text-center" style="vertical-align:middle; min-width:70px;">' + i + '월' + '</th>';
					
				}
				//console.log(planHeader);
				$('#planHeader2').html(planHeader).promise().done(function(){						
					resolve();
				});	
								
			
		});
    }

	function createHeader3(){
		return new Promise((resolve, reject)=> {
			var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">자재명</th>';							
			
				for (var i=1; i<13; i++) {
					
					planHeader += '<th class="text-center" style="vertical-align:middle; min-width:70px;">' + i + '월' + '</th>';
					
				}
				//console.log(planHeader);
				$('#planHeader3').html(planHeader).promise().done(function(){						
					resolve();
				});	
								
			
		});
    }

    function monthProductPresentTableFunc2(){
        //console.log("난 테이블이야")
        let tempTableData =$('#buyList').DataTable({
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
    			url: '<c:url value="/br/readMatrlCodeListWithBuyCnt"/>',
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
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count1" name="count1" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count2',
    				render: function(data, type, row) {
    					
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count2" name="count2" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    					
    				}
    			},
    			{ data: 'count3',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count3" name="count3" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count4',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count4" name="count4" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count5',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count5" name="count5" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count6',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count6" name="count6" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count7',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count7" name="count7" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count8',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count8" name="count8" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count9',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count9" name="count9" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count10',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count10" name="count10" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count11',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count11" name="count11" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count12',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'count12" name="count12" min=0 max=99999 value="' + addCommas(data) + '" /></input>';
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


        $('#buyList_length').html(html2);
        setDateBox();
   	 	$('#chooseDate2').val(moment(outputHistDate2).format("YYYY"));
     	selectBoxAppend(qutyList, "qutyCd", "", "1");    

        return tempTableData;
    }

    function monthProductPresentTableFunc3(){
        //console.log("난 테이블이야")
        let tempTableData =$('#yieldList').DataTable({
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
    			url: '<c:url value="/br/readMatrlCodeListWithYieldCnt"/>',
    			type: 'GET',
    			async: false,
    			data: {
    				'menuAuth'		: 	menuAuth,		
    				'planDate'		: function() { return outputHistDate4.substring(0,7).replace(/-/g, ''); },  
    				'qutyCd'		: function() { return qutyCd; },        	
    			},
    	    },
    	    rowId: '',
    		columns: [
    			{ data: 'matrlNm'},
    			{ data: 'count1',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield1" name="countYield1" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count2',
    				render: function(data, type, row) {
    					
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield2" name="countYield2" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    					
    				}
    			},
    			{ data: 'count3',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield3" name="countYield3" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count4',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield4" name="countYield4" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count5',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield5" name="countYield5" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count6',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield6" name="countYield6" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count7',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield7" name="countYield7" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count8',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield8" name="countYield8" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count9',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield9" name="countYield9" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count10',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield10" name="countYield10" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count11',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield11" name="countYield11" min=0 max=999 value="' + addCommas(data) + '" /></input>';
    				}
    			},
    			{ data: 'count12',
    				render: function(data, type, row) {
    					return '<input type="text" class="form-control number-float2" id="' + row["matrlCd"] + 'countYield12" name="countYield12" min=0 max=999 value="' + addCommas(data) + '" /></input>';
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


        $('#yieldList_length').html(html4);
        setDateBox2();
   	 	$('#chooseDate4').val(moment(outputHistDate4).format("YYYY"));
     	selectBoxAppend(qutyList, "qutyCd2", "", "1");    

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

    function setDateBox2(){
        var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();     
   
        for(var y = (com_year-3); y <= (com_year+5); y++){
            $("#chooseDate4").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
        }
   
        $("#chooseDate4").val(com_year);
    }

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

	  //전체 일괄입력
	$(document).on('click','#btnMatrlInputExecuteAll', function() {
		var allInputSetting = $("#allInputSettingYield").val().replace(/-/g,"");
		if (allInputSetting == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#allInputSettingYield').select();
			return false;
		}
		$('#my-spinner').show();
	
		for (var i=0; i<matrlCodeList.length; i++) {
			for (var j=0; j<12; j++) {
				$('#' + matrlCodeList[i].matrlCd + 'countYield' + (j+1)).val(allInputSetting);				
			}
		}		
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
	});

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
	
//숫자만 입력, 길이, 소수점 세자리까지 제한
	$(document).on('keyup','.number-float2', function(event) {
		if ( !(   (event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)   ) {
			//$('.number-float2').on("blur keyup", function() {
	        //   $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	        //});
	        toastr.warning('양수(+)만 입력해주세요.');
	        event.preventDefault();
	        $(this).val("0");
	        $(this).select();
	        return false;
		}
		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
	        $(this).select();
	        return false;
		}
	    if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			$(this).val("0");
			$(this).select();
			toastr.warning('최대 크기를 초과하였습니다.');
			return false;
		}
		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			$(this).val("0");
			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
		   toastr.warning('소수점은 한번만 입력해주세요.');
		   $(this).val("0");
		   $(this).select();
		   return false;
		}
	      
	    var _pattern2 = /^\d*[.]\d{3}$/;
		if (_pattern2.test( $(this).val())) {
			toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
			$(this).val("0");
			$(this).select();
		    return false;
		}
	});
	let html3 = '';
	html3 += '<label for="matrlListCheckAll" style="margin-right: 0px;"><input type="checkbox" style="margin-right:6px;" id="matrlListCheckAll" checked/>전체 선택/해제</label>';
	for (var i=0; i<matrlCodeList.length; i++) {
		html3 += '<label for="' + matrlCodeList[i].matrlCd + '" style="margin-right: 0px;"><input type="checkbox" value="' + matrlCodeList[i].matrlCd + '" style="margin-right:6px;" id="' + matrlCodeList[i].matrlCd + '" checked/>' + matrlCodeList[i].matrlNm + '</label>';
	}
	
	$('#checkBoxes1').html(html3);
	for (var i=0; i<matrlCodeList.length; i++) {
		if( matrlCodeList[i].matrlSelectYn == "Y" ){
			$('#' + matrlCodeList[i].matrlCd).prop("checked", true);
		} else{
			$('#' + matrlCodeList[i].matrlCd).prop("checked", false); 
		}
	}

	$('#matrlListCheckAll').on('click', function () {
		if($('#matrlListCheckAll').is(":checked") == true) {
			for (var i=0; i<matrlCodeList.length; i++) {
				$('#' + matrlCodeList[i].matrlCd).prop("checked", true); 
			}
		} else {
			for (var i=0; i<matrlCodeList.length; i++) {
				$('#' + matrlCodeList[i].matrlCd).prop("checked", false); 
			}
		}
	});

	// 자재 목록
	let matrlListshow = true;
	function showmatrlCheckboxes() {
		let matrlCheckBox = document.getElementById("checkBoxes1");
		if (matrlListshow) {
			matrlCheckBox.style.display = "block";
			matrlListshow = false;
		} else {
			matrlCheckBox.style.display = "none";
			matrlListshow = true;
		}
	}

	$('#chooseDate3').val(outputHistDate2);
	$('#tab3').trigger('click');

	function setDateBox3(){
	       var dt = new Date();
	       var year = "";
	       var com_year = dt.getFullYear();
	       // 발행 뿌려주기
	      // $("#chooseDate1").val(com_year);
	       // 올해 기준으로 -1년부터 +5년을 보여준다.
	       for(var y = (com_year-5); y <= (com_year+5); y++){
	           $("#chooseDate5").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
	       }
	      // $("#chooseDate2").append("<option value=''>년도</option>");
	       // 올해 기준으로 -1년부터 +5년을 보여준다.
	      
	       // 월 뿌려주기(1월부터 12월)
	       $("#chooseDate5").val(com_year);
	       
	     
	}
	

</script>

</body>
</html>