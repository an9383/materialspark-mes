<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">재고관리</a></li>
				<li class="breadcrumb-item active">재고현황관리(자재)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 66%; padding-bottom:0px; padding-top:5px;">
				<div class="card" style="margin-bottom: 0px;">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="card-body col-sm-12" style="padding:1px; margin-bottom:10px;">
						<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tabAlnicuMatrlTable">AL/Nicu</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tabFilmMatrlTable">Film</a></li>
							</ul>
						</div>
					</div>
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>					
					<div id="alnicuMatrlViewTable" >                    
					<!-- .table-responsive -->
						<div class="table-responsive">
							<table id="alnicuMatrlInOutWhsViewTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="19%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="8%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>순번</th>
										<th>자재명</th>
										<th>자재코드</th>
										<th>재질</th>
										<th>구분(연/경)</th>
										<th>면취(압연)</th>
										<th>표면처리</th>
										<th>이월량</th>
										<th>입고량</th>
										<th>출고량</th>
										<th>재고량</th>
										<th id="mainInspectWaitQtyTitle">수입검수 대기</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="7" style="text-align: center">합계</td>
										<td id="sumMainPreInWhsQty" style="text-align: right">0</td>
										<td id="sumMainInWhsQty" style="text-align: right">0</td>
										<td id="sumMainPreOutQty" style="text-align: right">0</td>
										<td id="sumMainDiffQty" style="text-align: right">0</td>
										<td id="sumMainInspectWaitQty" style="text-align: right">0</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- /.table-responsive -->
					</div>
					<div id="filmMatrlViewTable" class="d-none" >                 
				 	<!-- .table-responsive -->
						 <div class="table-responsive">
							<table id="filmMatrlInOutWhsViewTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="19%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="8%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>순번</th>
										<th>자재명</th>
										<th>자재코드</th>
										<th>재질</th>
										<th>구분(연/경)</th>
										<th>면취(압연)</th>
										<th>표면처리</th>
										<th>이월량</th>
										<th>입고량</th>
										<th>출고량</th>
										<th>재고량</th>
										<th id="subInspectWaitQtyTitle">수입검수 대기</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="7" style="text-align: center">합계</td>
										<td id="sumSubPreInWhsQty" style="text-align: right">0</td>
										<td id="sumSubInWhsQty" style="text-align: right">0</td>
										<td id="sumSubPreOutQty" style="text-align: right">0</td>
										<td id="sumSubDiffQty" style="text-align: right">0</td>
										<td id="sumSubInspectWaitQty" style="text-align: right">0</td>
									</tr>
								</tfoot>
							 </table>
						 </div>
						 <!-- /.table-responsive -->
					 </div>
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width:33%; padding-top:5px;">
				<div class="card mb-2" id="formBox">
					<div class="rightsidebar-close" style="margin-top: 20px;">
						<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2" id ="matrlInOutWhsViewDtlTable" style="text-align:center;">
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="15%">
									<col width="25%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>순번</th>
										<th>가입고일</th>
										<th>표면처리</th>
										<th>LOT</th>
										<th>재고량</th>
										<th>자재창고</th>
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="4" style="text-align: center">합계</td>
										<td id="sumDtl" style="text-align: right">0</td>
										<td colspan="" style="text-align: center"></td>
									</tr>
								</tfoot>
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>처리중</button>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- Excel다운 확인모달 시작-->
<div class="modal fade" id="excelDownPopupModal" tabindex="-1" role="dialog" aria-labelledby="excelDownPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="excelDownPopupModalLabel">Excel 다운</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="excelDownLabel"></h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success mr-2" id="btnMatrlDownTabCheck">Excel 다운</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- Excel다운 확인모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "66%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
	
		state = !state;
	});
	
	let menuAuth = 'tmsc0050';
	let currentHref = 'tmsc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","재고현황관리(자재)");
	var serverDate =  "${serverDate}";	
	var inWhsDateCal = serverDate.substring(0,7);
	var matrlCd = 'empty';
	var tapTemp = 0;
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let alnicuMatrlInOutWhsViewTable = $('#alnicuMatrlInOutWhsViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/tm/tmByMatrlInventoryList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate': function() { return inWhsDateCal.replace(/-/g, '').substring(0,6); },
	           	'qutyCd': 'A'	          
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
			{ data: 'matrlNm' },
			{ data: 'matrlCd' },
			{ data: 'qutyNm' },
			{ data: 'gubunNm'},
			{ data: 'chamferYnNm'},
			{ data: 'surfaceTrtmtNm'},
			{ data: 'preInWhsQty',
				render: function(data, type) {
					return parseFloat(data).toFixed(2);
				}
			},
			{ data: 'inWhsQty',
				render: function(data, type) {
					return parseFloat(data).toFixed(2);
				}
			},
			{ data: 'preOutQty',
				render: function(data, type) {
					return parseFloat(data).toFixed(2);
				}
			},
			{ data: 'diffQty',
				render: function(data, type) {
					return parseFloat(data).toFixed(2);
				}
			},
			{ data: 'inspectWaitQty',
				render: function(data, type) {
					return parseFloat(data).toFixed(2);
				}
			},
        ],
        columnDefs: [
        	{ targets: [7,8,9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [7,8,9,10,11], className: 'text-right-td' },
        ],
        order: [
            //[ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '재고현황관리(주자재)',
            },
            {
                extend: 'excel',
                title: '재고현황관리(주자재)',
            },
            {
                extend: 'print',
                title: '재고현황관리(주자재)',
            },
        ],
		drawCallback: function () {
			var sumMainPreInWhsQty = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sumMainInWhsQty = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumMainPreOutQty = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sumMainDiffQty = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sumMainInspectWaitQty = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			$('#sumMainPreInWhsQty').text(addCommas(sumMainPreInWhsQty.toFixed(2)));
			$('#sumMainInWhsQty').text(addCommas(sumMainInWhsQty.toFixed(2)));
			$('#sumMainPreOutQty').text(addCommas(sumMainPreOutQty.toFixed(2)));
			$('#sumMainDiffQty').text(addCommas(sumMainDiffQty.toFixed(2)));
			$('#sumMainInspectWaitQty').text(addCommas(sumMainInspectWaitQty.toFixed(2)));
			var text = parseInt(inWhsDateCal.replace(/-/g, '').substring(4,6)) + '월<br/>수입검수 대기';
			$('#mainInspectWaitQtyTitle').html(text);
		}
    });

    var sysdate = "${serverTime}";
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label>';
		html1 += '<input type="text" class="form-control" id="alnicuInWhsDate" style="width:65px;">';
	//var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		//html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDate" name="alnicuInWhsDate" />';
		//html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDate,alnicuInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateFromCalendar" type="button">';
		//html1 += '<span class="oi oi-calendar"></span>';
		//html1 += '</button>';
    	html1 += '&nbsp; <button type="button" class="btn btn-primary mr-5" id="btnAlnicuRetv">조회</button>';
    	html1 += '<button type="button" class="btn btn-success mr-2" id="btnMatrlDownTab1">Excel 다운</button>';
    	html1 += '<div>';
    
	$('#alnicuMatrlInOutWhsViewTable_length').html(html1);
	$('#alnicuInWhsDate').val(inWhsDateCal);

	$.fn.dataTable.ext.errMode = 'none';
	let filmMatrlInOutWhsViewTable = $('#filmMatrlInOutWhsViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/tm/tmByMatrlInventoryList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate': function() { return inWhsDateCal.replace(/-/g, '').substring(0,6); },	           	
	           	'qutyCd': 'F'
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
	    	{ data: 'matrlNm' },
	    	{ data: 'matrlCd' },
	    	{ data: 'qutyNm' },
	    	{ data: 'gubunNm'},
			{ data: 'chamferYnNm'},
			{ data: 'surfaceTrtmtNm'},
		    { data: 'preInWhsQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
		    { data: 'inWhsQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
		    { data: 'preOutQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
		    { data: 'diffQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
            { data: 'inspectWaitQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
        ],
        columnDefs: [
        	{ targets: [7,8,9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [7,8,9,10,11], className: 'text-right-td' },
		],
		//order: [
		//    [ 0, 'asc' ]
		//],
		buttons: [
		    {
		        extend: 'copy',
		        title: '적정재고관리(부자재)',
		    },
		    {
		        extend: 'excel',
		        title: '적정재고관리(부자재)',
		    },
		    {
		        extend: 'print',
		        title: '적정재고관리(부자재)',
		    },
		],
		drawCallback: function () {
			var sumSubPreInWhsQty = $('#filmMatrlInOutWhsViewTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sumSubInWhsQty = $('#filmMatrlInOutWhsViewTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumSubPreOutQty = $('#filmMatrlInOutWhsViewTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sumSubDiffQty = $('#filmMatrlInOutWhsViewTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sumSubInspectWaitQty = $('#filmMatrlInOutWhsViewTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			$('#sumSubPreInWhsQty').text(addCommas(sumSubPreInWhsQty.toFixed(2)));
			$('#sumSubInWhsQty').text(addCommas(sumSubInWhsQty.toFixed(2)));
			$('#sumSubPreOutQty').text(addCommas(sumSubPreOutQty.toFixed(2)));
			$('#sumSubDiffQty').text(addCommas(sumSubDiffQty.toFixed(2)));
			$('#sumSubInspectWaitQty').text(addCommas(sumSubInspectWaitQty.toFixed(2)));
			var text = parseInt(inWhsDateCal.replace(/-/g, '').substring(4,6)) + '월<br/>수입검수 대기';
			$('#subInspectWaitQtyTitle').html(text);
		}
    });
	
	var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label>';
		html2 += '<input type="text" class="form-control" id="filmInWhsDate" style="width:65px;">';
	//var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		//html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDate" name="filmInWhsDate" />';
		//html2 += '<button onclick="fnPopUpCalendar(filmInWhsDate,filmInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateFromCalendar" type="button">';
		//html2 += '<span class="oi oi-calendar"></span>';
		//html2 += '</button>';
		html2 += '&nbsp; <button type="button" class="btn btn-primary mr-5" id="btnFilmRetv">조회</button>';
    	html2 += '<button type="button" class="btn btn-success mr-2" id="btnMatrlDownTab2">Excel 다운</button>';
    	html2 += '<div>';

	$('#filmMatrlInOutWhsViewTable_length').html(html2);
	$('#filmInWhsDate').val(inWhsDateCal);

	$.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsViewDtlTable = $('#matrlInOutWhsViewDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
        destroy:true,
        paging: false,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: false,
	}); 		
	
    $('#tabAlnicuMatrlTable').on('click', function() {
    	$('#alnicuMatrlViewTable').removeClass('d-none');
    	$('#filmMatrlViewTable').addClass('d-none');
    	$('#alnicuInWhsDate').val($('#filmInWhsDate').val());    	
    	inWhsDateCal = $('#alnicuInWhsDate').val();
    	tapTemp = 0;
    	$('#alnicuMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});    	
    });
    
    $('#tabFilmMatrlTable').on('click', function() {
    	$('#alnicuMatrlViewTable').addClass('d-none');
    	$('#filmMatrlViewTable').removeClass('d-none');
    	$('#filmInWhsDate').val($('#alnicuInWhsDate').val());
    	inWhsDateCal = $('#filmInWhsDate').val();
    	tapTemp = 1;
    	$('#filmMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
    });
      
    // 보기
    $('#alnicuMatrlInOutWhsViewTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#alnicuMatrlInOutWhsViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        matrlCd = alnicuMatrlInOutWhsViewTable.row(this).data().matrlCd;

		$.fn.dataTable.ext.errMode = 'none';
		let matrlInOutWhsViewDtlTable = $('#matrlInOutWhsViewDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
	        language: lang_kor,
	        destroy:true,	     
	        lengthChange: false,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        pageLength: 20,
	        ajax: {
	            url: '<c:url value="/tm/tmByMatrlInventoryDtlList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'		:		menuAuth,
		           	'inWhsDate'		:		function() { return inWhsDateCal.replace(/-/g, '').substring(0,6); },
		           	'matrlCd'		:		matrlCd,
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        //rowId: 'lotNo',
	        columns: [
	        	//{ data: 'inWhsDate',
	        	//	render: function(data, type, row, meta) {		
				//		return moment(data).format('YYYY-MM-DD') ;
	    		//	}
	        	//},
		    	//{ data: 'lifeCycle'},
		    	//{ data: 'inspctDate',
	        	//	render: function(data, type, row, meta) {		
				//		return moment(data).format('YYYY-MM-DD') ;
	    		//	}
	        	//},
	           	{	
		    		render: function(data, type, row, meta) {		
						return meta.row + 1;
	    			}
		    	},
	     		{ data: 'preInWhsDate',
	        		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
	        	},
		    	{ data: 'surfaceTrtmtNm' },
		    	{ data: 'lotNo'}, 
		    	{ data: 'inspectQty',
			   		render: function(data, type) {
			   			return parseFloat(data).toFixed(2);
			   		}
	            }, 
		    	{ data: 'locationNm'}
	            
	        ],
	        columnDefs: [
	        	{ targets: [4], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [4], className: 'text-right-td' },
	        ],
	        order: [
	            //[ 0, 'asc' ]
	        ],
	        buttons: [
	            {
	                extend: 'copy',
	                title: '적정재고관리'
	            },
	            {
	                extend: 'excel',
	                title: '적정재고관리'
	            },
	            {
	                extend: 'print',
	                title: '적정재고관리'
	            },
	        ],
			drawCallback: function () {
				var sumDtl = $('#matrlInOutWhsViewDtlTable').DataTable().column(4, { page: 'all'} ).data().sum();
				$('#sumDtl').text(addCommas(sumDtl.toFixed(2)));
			}
	    });

	});	
	    
    $('#filmMatrlInOutWhsViewTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#filmMatrlInOutWhsViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        matrlCd = filmMatrlInOutWhsViewTable.row(this).data().matrlCd;

		$.fn.dataTable.ext.errMode = 'none';
		let matrlInOutWhsViewDtlTable = $('#matrlInOutWhsViewDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
	        language: lang_kor,
	        destroy:true,	     
	        lengthChange: false,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        pageLength: 20,
	        ajax: {
	            url: '<c:url value="/tm/tmByMatrlInventoryDtlList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'		:		menuAuth,
		           	'inWhsDate'		:		function() { return inWhsDateCal.replace(/-/g, '').substring(0,6); },
		           	'matrlCd'		:		matrlCd,
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        //rowId: 'lotNo',
	        columns: [
	        	//{ data: 'inWhsDate',
	        	//	render: function(data, type, row, meta) {		
				//		return moment(data).format('YYYY-MM-DD') ;
	    		//	}
	        	//},
		    	//{ data: 'lifeCycle'},
		    	//{ data: 'inspctDate',
	        	//	render: function(data, type, row, meta) {		
				//		return moment(data).format('YYYY-MM-DD') ;
	    		//	}
	        	//},
	           	{	
		    		render: function(data, type, row, meta) {		
						return meta.row + 1;
	    			}
		    	},
	     		{ data: 'preInWhsDate',
	        		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
	        	},
		    	{ data: 'surfaceTrtmtNm' },
		    	{ data: 'lotNo'}, 
		    	{ data: 'inspectQty',
			   		render: function(data, type) {
			   			return parseFloat(data).toFixed(2);
			   		}
	            }, 
		    	{ data: 'locationNm'}
	            
	        ],
	        columnDefs: [
	        	{ targets: [4], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [4], className: 'text-right-td' },
	        ],
	        order: [
	            //[ 0, 'asc' ]
	        ],
	        buttons: [
	            {
	                extend: 'copy',
	                title: '적정재고관리'
	            },
	            {
	                extend: 'excel',
	                title: '적정재고관리'
	            },
	            {
	                extend: 'print',
	                title: '적정재고관리'
	            },
	        ],
			drawCallback: function () {
				var sumDtl = $('#matrlInOutWhsViewDtlTable').DataTable().column(4, { page: 'all'} ).data().sum();
				$('#sumDtl').text(addCommas(sumDtl.toFixed(2)));
			}
	    });

	});	
    	
    $('#btnAlnicuRetv').on('click', function() {
		inWhsDateCal =  $('#alnicuInWhsDate').val();		
		$('#filmInWhsDate').val($('#alnicuInWhsDate').val());	
		$('#alnicuMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
		$('#matrlInOutWhsViewDtlTable').DataTable().clear().draw();
    });	

    $('#btnFilmRetv').on('click', function() {
		inWhsDateCal =  $('#filmInWhsDate').val();		
		$('#alnicuInWhsDate').val($('#filmInWhsDate').val());
		filmMatrlInOutWhsViewTable.ajax.reload( function () {});
		$('#matrlInOutWhsViewDtlTable').DataTable().clear().draw();
    });
    
	$('#btnMatrlDownTab1, #btnMatrlDownTab2').on('click', function() {
		if (tapTemp == 0){
			$('#excelDownLabel').text($('#alnicuInWhsDate').val() + ' 기준으로 모든 자재재고를 다운합니다.');
		} else if (tapTemp == 1) {
			$('#excelDownLabel').text($('#filmInWhsDate').val() + ' 기준으로 모든 자재재고를 다운합니다.');
		}
		
		$('#excelDownPopupModal').modal('show');
	});
	
    $(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});

    $('#matrlInOutWhsViewDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#matrlInOutWhsViewDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});

	$('#btnMatrlDownTabCheck').on('click', function() {
  	  	
		$('#my-spinner').show();

		if (tapTemp == 0){
			inWhsDateCal = $('#alnicuInWhsDate').val();
		} else if (tapTemp == 1) {
			inWhsDateCal = $('#filmInWhsDate').val();
		}
		
		$.ajax({
			url: '<c:url value="tm/matrlInventoryExcel"/>',
			type: 'GET',
			datatype: 'json',
			data:  {
				'menuAuth'	 	: 	menuAuth,
				'inWhsDate'		:	function() { return inWhsDateCal.replace(/-/g, ''); },
			},
			beforeSend: function() {
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success: function (res) {
				let data = res.data
				//console.log(data);
			    if (res.result == 'ok') {
			        location.href = '/tm/matrlInventoryExcelDownload?id=matrlInventory_' + data.inWhsDate;
			    } else if (res.result == 'fail') {
			    	toastr.warning(res.message);
			    } else if (res.result == 'error') {
					toastr.error("오류가 발생하였습니다. - matrlExcel/download-001");
				}
			},
			complete:function(){
				$('#excelDownPopupModal').modal('hide');
				$('#my-spinner').hide();
			}
        });
	});
	
	//yyyy-mm 달력
	$('#alnicuInWhsDate').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});
	
	$('#filmInWhsDate').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});

	
</script>

</body>
</html>
