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
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재선입선출관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			 <div class="left-list left-sidebar" id="left-list" style="width:61%;">
				<div class="card-body col-sm-12" style="padding: 1px;">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show"
								data-toggle="tab" id="tabAlnicuMatrlTable">AL/Nicu</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								id="tabFilmMatrlTable">Film</a></li>
						</ul>
					</div>
				</div>
				<br />
				<div id="alnicuMatrlTable">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="alnicuMatrlInOutWhsTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="25%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="25%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>순번</th>
									<th class="text-center">자재명</th>
									<th>자재코드</th>
									<th>재질</th>
									<th>구분(연/경)</th>
									<th>면취(압연)</th>
									<th>표면처리</th>
									<th>규격</th>
									<th class="text-center">재고량</th>									
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="8" style="text-align:center">합계</td>
									<td id="sumAlnicu" style="text-align:right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<div id="filmMatrlTable" class="d-none">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="filmMatrlInOutWhsTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="25%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="7%">
								<col width="25%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>순번</th>
									<th class="text-center">자재명</th>
									<th>자재코드</th>
									<th>재질</th>
									<th>구분(연/경)</th>
									<th>면취(압연)</th>
									<th>표면처리</th>
									<th>규격</th>
									<th class="text-center">재고량</th>									
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="8" style="text-align:center">합계</td>
									<td id="sumFilm" style="text-align:right">0</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			 <!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 38%; padding-bottom: 0px;">
				<div class="card mb-2" id="formBox">
					<div class="rightsidebar-close">
						<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
					</div>
					
					<div class="table-responsive">
						<div style="margin-top: 27px;"></div>
						<table class="table table-bordered mb-2 text-center" id="firstInFirstOutDtlTable">
							<thead class="thead-light">
								<tr>
									<th>가입고일</th>
									<th>입고일</th>
									<th>유수명(월)</th>
									<!-- <th>LOT</th> -->
									<th class="text-center">재고량</th>
									<th>BarcodeNo</th>
									<th>Location NO</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="3" style="text-align:center">합계</td>
									<td id="sumDtl" style="text-align:right">0</td>
									<td colspan="2" style="text-align:center"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "61%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
		state = !state;
	});

	let menuAuth = 'iosc0090';
	let currentHref = 'iosc0090';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재선입선출관리");

	var inWhsDateCal =  "${serverDate}";	
	var inWhsDateCalFrom =  "${serverDateFrom}";	
	var inWhsDateCalTo =  "${serverDate}";	
	var matrlGubun = 'A';
	var matrlCd = null;
	var fifoGubun = '1';
	
	//공통코드 처리 시작
	var locationCode=new Array(); // location
    <c:forEach items="${locationCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		locationCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    var fifoGubunCode = new Array();
	var json=new Object();
	json.baseCd="1";
	json.baseCdNm="재고O";
	fifoGubunCode.push(json);
	json=new Object();
	json.baseCd="2";
	json.baseCdNm="재고X";
	fifoGubunCode.push(json);
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let alnicuMatrlInOutWhsTable = $('#alnicuMatrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 19,
        ajax: {
            url: '<c:url value="/io/firstInFirstOutDataList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDateFrom'		:		function() { return inWhsDateCalFrom.replace(/-/g, ''); },
	           	'inWhsDateTo'		:		function() { return inWhsDateCalTo.replace(/-/g, ''); },
	           	'qutyCd'		:		function() { return matrlGubun; },
	           	'fifoGubun'		:		function() { return fifoGubun;  }
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'matrlCd',
        columns: [
	    	{ 
	    		render: function(data, type, row, meta) {			    			
	    			return meta.row + 1;
	    		}
			},
			{ data: 'matrlNm'},
			{ data: 'matrlCd' },
            { data: 'qutyNm'},
            { data: 'gubunNm'},
            { data: 'chamferYnNm'},
            { data: 'surfaceTrtmtNm'},
            { data: 'model' },
            { data: 'inWhsQty',
            	render: function(data, type, row, meta) {			    			
	    			 return parseFloat(data).toFixed(2);
	    		}
            }
        ],
        columnDefs: [
			{ targets: [0,1,2,3,4,5,6,7], className: 'text-center' },
			{ targets: [8], className: 'text-right' },
			{ targets: [8], render: $.fn.dataTable.render.number( ',' ) },
        ],
        //order: [
        //    [ 8, 'desc' ]
        //],
		drawCallback: function () {
			var sumAlnicu = $('#alnicuMatrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			$('#sumAlnicu').text(addCommas(sumAlnicu.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '선입선출관리(Al/Nicu)',
            },
            {
                extend: 'excel',
                title: '선입선출관리(Al/Nicu)',
            },
            {
                extend: 'print',
                title: '선입선출관리(Al/Nicu)',
            },
        ],
    });
    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let firstInFirstOutDtlTable = $('#firstInFirstOutDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        searching : true,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 19,
        lengthChange:false,
        ajax: {
            url: '<c:url value="/io/firstInFirstOutDtlDataList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	           	'matrlCd' :  function() { return matrlCd; },
	        	'inWhsDateFrom'		:		function() { return inWhsDateCalFrom.replace(/-/g, ''); },
	           	'inWhsDateTo'		:		function() { return inWhsDateCalTo.replace(/-/g, ''); },
	           	'qutyCd' : function() { return matrlGubun; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'matrlCd',
        columns: [
        	{ data:'preInWhsDate',
	    		render: function(data, type, row, meta) {			    			
	    			 return moment(data).format('YYYY-MM-DD');
	    		}
			},
	    	{ data:'inWhsDate',
	    		render: function(data, type, row, meta) {			    			
	    			 return moment(data).format('YYYY-MM-DD');
	    		}
			},
            { data: 'lifeCycle'},                     
            //{ data: 'lotNo' },
            { data: 'inWhsQty',
            	render: function(data, type, row, meta) {			    			
	    			 return parseFloat(data).toFixed(2);
	    		}
            },
            { data: 'barcodeNo' },
            { data: 'locationNm' }     
        ],
        columnDefs: [
        	{ targets: [0,1,2,4,5], className: 'text-center' },
			{ targets: [3], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [3], className: 'text-right' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        drawCallback: function () {
			var sumDtl = $('#firstInFirstOutDtlTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			$('#sumDtl').text(addCommas(sumDtl.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '선입선출관리 상세',
            },
            {
                extend: 'excel',
                title: '선입선출관리 상세',
            },
            {
                extend: 'print',
                title: '선입선출관리 상세',
            },
        ],
    });

	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDateTo" name="alnicuInWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDateTo,alnicuInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
/* 		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDateTo"/>';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDateTo,alnicuInWhsDateTo,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>'; */
		//html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm1">기간선택</button>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">재고구분</label><select  class="custom-select" id="fifoGubunA" ></select>&nbsp';
    	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnAlnicuRetv">조회</button>';
	$('#alnicuMatrlInOutWhsTable_length').html(html1);
	$('#alnicuInWhsDateFrom').val(inWhsDateCalFrom);
	$('#alnicuInWhsDateTo').val(inWhsDateCalTo);
	selectBoxAppend(fifoGubunCode, "fifoGubunA", "1", "1");

	$.fn.dataTable.ext.errMode = 'none';
	let filmMatrlInOutWhsTable = $('#filmMatrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 19,
        ajax: {
            url: '<c:url value="/io/firstInFirstOutDataList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	        	'inWhsDateFrom'		:		function() { return inWhsDateCalFrom.replace(/-/g, ''); },
	           	'inWhsDateTo'		:		function() { return inWhsDateCalTo.replace(/-/g, ''); },
	           	'qutyCd' : function() { return matrlGubun; },
	           	'fifoGubun': function() {return fifoGubun;}
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'matrlCd',
        columns: [
        	{ 
	    		render: function(data, type, row, meta) {			    			
	    			return meta.row + 1;
	    		}
			},
			{ data: 'matrlNm'},
			{ data: 'matrlCd' },
            { data: 'qutyNm'},
            { data: 'gubunNm'},
            { data: 'chamferYnNm'},
            { data: 'surfaceTrtmtNm'},
            { data: 'model' },
            { data: 'inWhsQty',
            	render: function(data, type, row, meta) {			    			
	    			 return parseFloat(data).toFixed(2);
	    		}
            }
        ],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,6,7], className: 'text-center' },
			{ targets: [8], className: 'text-right' },
			{ targets: [8], render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
            [ 8, 'desc' ]
        ],
        drawCallback: function () {
			var sumFilm = $('#filmMatrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			$('#sumFilm').text(addCommas(sumFilm.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '선입선출관리(Film)',
            },
            {
                extend: 'excel',
                title: '선입선출관리(Film)',
            },
            {
                extend: 'print',
                title: '선입선출관리(Film)',
            },
        ],
    });

	 var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDateTo" name="filmInWhsDate" />';
		html2 += '<button onclick="fnPopUpCalendar(filmInWhsDateTo,filmInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateCalendar" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>'; 
		html2 += '</div>';
	 	/* html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>'; 
	 	html2 += '<div class="form-group input-sub m-0 row">';
		html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDateTo"/>';
		html2 += '<button onclick="fnPopUpCalendar(filmInWhsDateTo,filmInWhsDateTo,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>';
		html2 += '</div>'; */
		//html2 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm2">기간선택</button>'; 
		html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">재고구분</label><select  class="custom-select" id="fifoGubunF" ></select>&nbsp';
		html2 += '&nbsp; <button type="button" class="btn btn-primary" id="btnFilmRetv">조회</button>';
	
	$('#filmMatrlInOutWhsTable_length').html(html2);
	//$('#filmInWhsDateFrom').val(inWhsDateCalFrom);
	$('#filmInWhsDateTo').val(inWhsDateCalTo);
	selectBoxAppend(fifoGubunCode, "fifoGubunF", "1", "1");

    $('#tabAlnicuMatrlTable').on('click', function() {
    	 matrlGubun = 'A';
    	$('#alnicuMatrlTable').removeClass('d-none');
    	$('#filmMatrlTable').addClass('d-none');
    	
    	//$('#alnicuInWhsDateFrom').val($('#filmInWhsDateFrom').val());
    	$('#alnicuInWhsDateTo').val($('#filmInWhsDateTo').val());
    	$('#fifoGubunA').val($('#fifoGubunF').val());
    	
    	//inWhsDateCalFrom =  $('#filmInWhsDateFrom').val();
 		inWhsDateCalTo =   $('#filmInWhsDateTo').val();
 		fifoGubun =  $('#fifoGubunF').val();
 		
    	matrlCd = null;
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
    	$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
    $('#tabFilmMatrlTable').on('click', function() {
    	matrlGubun = 'F';
    	$('#alnicuMatrlTable').addClass('d-none');
    	$('#filmMatrlTable').removeClass('d-none');
    	
    	//$('#filmInWhsDateFrom').val($('#alnicuInWhsDateFrom').val());
    	$('#filmInWhsDateTo').val($('#alnicuInWhsDateTo').val());
    	$('#fifoGubunF').val($('#fifoGubunA').val());
    	
    	//inWhsDateCalFrom =  $('#alnicuInWhsDateFrom').val();
 		inWhsDateCalTo =   $('#alnicuInWhsDateTo').val();
 		fifoGubun =  $('#fifoGubunA').val();
 		
    	matrlCd = null;
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
    	$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
      
    // 보기
    $('#alnicuMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#alnicuMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        matrlCd = alnicuMatrlInOutWhsTable.row(this).data().matrlCd;
       // inWhsDateCalFrom =  $('#alnicuInWhsDateFrom').val();
		inWhsDateCalTo =  $('#alnicuInWhsDateTo').val();
		fifoGubun =  $('#fifoGubunA').val();
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
	});	
	    
    $('#filmMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#filmMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        matrlCd = filmMatrlInOutWhsTable.row(this).data().matrlCd;
        //inWhsDateCalFrom =  $('#filmInWhsDateFrom').val();
		inWhsDateCalTo =  $('#filmInWhsDateTo').val();
		fifoGubun =  $('#fifoGubunF').val();
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
	});	

    $('#btnAlnicuRetv').on('click', function() {
		//inWhsDateCalFrom =  $('#alnicuInWhsDateFrom').val();
		inWhsDateCalTo =  $('#alnicuInWhsDateTo').val();
		fifoGubun =  $('#fifoGubunA').val();
		$('#filmInWhsDate').val($('#alnicuInWhsDate').val());
		matrlCd = null;
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
		$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });	

    $('#btnFilmRetv').on('click', function() {
    	//inWhsDateCalFrom =  $('#filmInWhsDateFrom').val();
		inWhsDateCalTo =  $('#filmInWhsDateTo').val();
		fifoGubun =  $('#fifoGubunF').val();
		$('#alnicuInWhsDate').val($('#filmInWhsDate').val());		
		matrlCd = null;
        $('#firstInFirstOutDtlTable').DataTable().ajax.reload( function () {});
		$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });

    $('#firstInFirstOutDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#firstInFirstOutDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});

    $('#btnTerm1').on('click',function() {
		datePickFun();
	});
    $('#btnTerm2').on('click',function() {
		datePickFun();
	});

	
	$('#datePick').on('click',function() {
		var id ='';
		
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				id = $(this).attr('id');
			}
		});			
		datePick(id, 'filmInWhsDateFrom', 'filmInWhsDateTo',  $('#select-year').val());
		datePick(id, 'alnicuInWhsDateFrom', 'alnicuInWhsDateTo',  $('#select-year').val());
	});
   
    
</script>

</body>
</html>