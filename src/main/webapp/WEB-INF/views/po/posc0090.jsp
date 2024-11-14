<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- ============================================================== -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
				<li class="breadcrumb-item active">실링검사 입력</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="" style="width: 50%">
				<div class="card">
				
					<div class="table-responsive">
						<table id="ordLotNoTraceTable" class="table table-bordered">
							<%-- 
							<colgroup>
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="11%">
								<col width="10%">
								<col width="10%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
							</colgroup>
							 --%>
							<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:120px">포장번호</th>
								<th class="text-center" style="min-width:120px">LotNo</th>
								<th class="text-center" style="min-width:120px">작지번호</th>
								<th class="text-center" style="min-width:80px">주자재1</th>
								<th class="text-center" style="min-width:80px">주자재2</th>
								<th class="text-center" style="min-width:80px">주자재3</th>
								<th class="text-center" style="min-width:80px">포장수량</th>
								<th class="text-center" style="min-width:80px">제품코드</th>
								<th class="text-center" style="min-width:100px">제품명</th>
								<th class="text-center" style="min-width:60px">실효 1</th>
								<th class="text-center" style="min-width:60px">실효 2</th>
								<th class="text-center" style="min-width:60px">외관이상</th>
							</tr>
							</thead>
						</table>
					</div>
					<br>
					<br>
					
					<div class="table-responsive">
						<table class="table table-bordered" id="">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tbody class="thead-light">
								<tr>
								    <th>작지번호</th>
								    <td>
								    	<input class="form-control" style="min-width:100%" type="text" id="workOrdNo" />
								    </td>
								    <th>LOT NO</th>
								    <td>
								    	<input type="text" style="min-width:100%" class="form-control" id="ordLotNo" disabled>
								    </td>
								</tr>
								<tr>
									<th>제품명</th>
								    <td>
								    	<input type="text" style="min-width:100%" class="form-control" id="goodsNm" disabled>
								    </td>
								    <th>포장수량</th>
								    <td>
								    	<input type="text" style="min-width:100%" class="form-control text-right" id="userOutputCnt" disabled>
								    </td>
								</tr>
								<tr>
								    <th>실효 1번</th>
								    <td><input type="text" style="min-width:100%" class="form-control number-float3" id="sealing1" disabled></td>
								    <th>실효 2번</th>
								    <td><input type="text" style="min-width:100%" class="form-control number-float3" id="sealing2" disabled></td>
								</tr>
								<tr>
									<th>필름 외관 이상</th>
								    <td>
								    	<input type="checkbox" id="filmFaultyCheck" style="zoom:1.9;" disabled>
								    </td>
								    <th></th>
								    <td></td>
								</tr>
							</tbody>
						</table>
						<button type="button" class="btn btn-primary float-right touch6" id="btnSave" style="margin-top: 16px; margin-right: 10px; margin-bottom: 16px;" disabled>저장</button>
						<button type="button" class="btn btn-primary float-right touch6" id="btnReset" style="margin-top: 16px; margin-right: 10px; margin-bottom: 16px;">초기화</button>
						<div class="table-responsive">
							<table id="productiDtlTable" class="table table-bordered">
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
								<tr>
									<th class="text-center">포장번호</th>
									<th class="text-center">LOT NO</th>
									<th class="text-center">작지 번호</th>
									<th class="text-center">제품상태</th>
									<th class="text-center">불량상태</th>
									<th class="text-center">포장수량</th>
									<th class="text-center">폐기 상태</th>
									<th class="text-center">분할&병합</th>
								</tr>
								</thead>
								<!-- 
								<tfoot>
									<tr>
										<td colspan="5">합계</td>
										<td colspan="" id="sumUserOutputCnt" style="text-align: right">0</td>
										<td colspan="2"></td>
									</tr>
								</tfoot>
								 -->
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-70" id="myrSidenav" style="width: 49%;">
				<div id="scrollDiv" style="overflow:auto; height:720px;">
					<div class="col-12 row p-0 table-td-center">
						<div class="table-responsive">
							<!-- 
							<div class="row" style="margin-bottom: 10px;">
								&nbsp;&nbsp;<label class="input-label-sm touch6">실링검사일</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control touch6" style="width:120px;" type="text" id="chooseDateFrom" />
									<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button" style="width:30px; height:30px;">
										<span class="oi oi-calendar" style="font-size: 15px;"></span>
									</button>
								</div>
								&nbsp;&nbsp;&nbsp;<label class="input-label-sm touch6">~</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control touch6" style="width:120px;" type="text" id="chooseDateTo" />
									<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button" style="width:30px; height:30px;">
										<span class="oi oi-calendar" style="font-size: 15px;"></span>
									</button>
								</div>
								<button type="button" class="btn btn-primary float-right touch6 ml-2" id="btnRetv">조회</button>
							</div>
							 -->
							<table id="sealingWorkOrdList" class="table table-bordered">
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
								<tr>
									<th class="text-center">실링검사일</th>
									<th class="text-center">LOT NO</th>
									<th class="text-center">작지 번호</th>
									<th class="text-center">제품명</th>
									<th class="text-center">포장수량</th>
									<th class="text-center">실효 1</th>
									<th class="text-center">실효 2</th>
									<th class="text-center">외관이상</th>
								</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!--// 등록, 수정 -->
		</div>
		<!-- .right-sidebar -->
	</div>
	<!-- /.row -->
</div>
<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
</div>
<!-- /.app -->
<!-- 작지 추적 모달 시작-->
<div class="modal fade" id="traceBoxNoPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog  modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="traceBoxNo"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table id="traceBoxNoTable" class="table table-bordered">
						<colgroup>
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<thead class="thead-light">
						<tr>
							<th class="text-center">제품명</th>
							<th class="text-center">원장 BoxNo</th>
							<th class="text-center">작지번호</th>
							<th class="text-center">포장수량</th>
							<th class="text-center">오더구분</th>
							<th class="text-center">제품상태</th>
							<th class="text-center">제품불량</th>
						</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer">
			</div>
		</div>
	</div>
</div>
<!-- 작지 추적 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<script>
	
	let menuAuth = 'posc0090';
	let currentHref = 'posc0090';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","실링검사 입력");

	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDateTo}";
	sealingDateFrom = serverDateFrom;
	sealingDateTo = serverDateTo;
	var workOrdNo = 'emtpy';
	var boxNo = 'empty'
	
	//포장번호로 생산LotNo 추적
	$.fn.dataTable.ext.errMode = 'none';
	let ordLotNoTraceTable = $('#ordLotNoTraceTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-5'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'>>",
		language: lang_kor,
		paging: true,
		info: false,
		ordering: true,
		processing: true,
		searching: true,
		autoWidth: false,
		pageLength: 20,
		ajax: {
		    url: '<c:url value="po/boxNoWorkOrdTrace"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'		: 		menuAuth,
		        'boxNo'			:		function() { return boxNo; },
		    },
		},
		columns: [
			{ data: 'boxNo' },
			{ data: 'ordLotNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	               		html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'mainMatrl1' },
			{ data: 'mainMatrl2' },
			{ data: 'mainMatrl3' },
			{ data: 'packDtlCnt' },
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{
				data: "sealing1",
				render: function(data, type, row, meta) {
					if(data == '0') {
						return "-";
					} else {
						return data;
					}
				}
			},
			{
				data: "sealing2",
				render: function(data, type, row, meta) {
					if(data == '0') {
						return "-";
					} else {
						return data;
					}
				}
			},
			{
				data: "filmFaultyCheck",
				render: function(data, type, row, meta) {
					if(data == 'Y') {
						return "O";
					} else {
						return "X";
					}
				}
			},
		],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,7,8,9,10,11], className: 'text-center' },
        	{ targets: [6], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [6], className: 'text-right-td' },
        ],		
		order: [
			[ 2, 'asc' ],
		],
    });

	let html1 = '<div class="row">';
	html1 += '&nbsp;&nbsp;<label class="input-label-sm touch6">포장번호 :</label>';
	html1 += '<input class="form-control" style="max-width:120px;" type="text" id="boxNo" />';
	html1 += '<button type="button" class="btn btn-primary float-right touch6 ml-2" id="btnWorkOrdTraceRetv">조회</button>';
	html1 += '<p class="ml-2">*분할&병합되지 않은 포장번호</p>';
	html1 += '</div>';
	$('#ordLotNoTraceTable_length').html(html1);

	//포장번호 스캔
	$("#boxNo").keypress(function (e) {
		if (e.which == 13) {
			if (($('#boxNo').val().length != "13")) {
				toastr.warning('포장번호가 아닙니다.<br>입력정보를 확인해주세요.');
				$('#boxNo').select();
				return false;
            }
			boxNo = $('#boxNo').val();
			$('#ordLotNoTraceTable').DataTable().ajax.reload( function () {});
		}
    });

	//포장번호 스캔
	$('#btnWorkOrdTraceRetv').on('click', function() {
		if (($('#boxNo').val().length != "13")) {
			toastr.warning('포장번호가 아닙니다.<br>입력정보를 확인해주세요.');
			$('#boxNo').select();
			return false;
		}
		boxNo = $('#boxNo').val();
		$('#ordLotNoTraceTable').DataTable().ajax.reload( function () {});
    });
    
	//검색 작지번호 자동입력
    $('#ordLotNoTraceTable tbody').on('dblclick', 'tr', function() {
        if ( $(this).hasClass('selected') ) {
        	$(this).removeClass('selected');
        } else {
        	$('#ordLotNoTraceTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			var workOrdNo = ordLotNoTraceTable.row(this).data().workOrdNo;
			$("#workOrdNo").val(workOrdNo);

			/*var press = jQuery.Event("keypress");
			press.ctrlKey = false;
			press.which = 13;
			$("#workOrdNo").trigger(press);*/
			
			keypress("workOrdNo", "13");
        }
    });

	//실림검사 입력작지목록
	$.fn.dataTable.ext.errMode = 'none';
	let sealingWorkOrdList = $('#sealingWorkOrdList').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>",
		language: lang_kor,
		paging: true,
		info: true,
		ordering: true,
		processing: true,
		searching: true,
		autoWidth: false,
		pageLength: 20,
		ajax: {
		    url: '<c:url value="po/sealingWorkOrdList"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'			: 		menuAuth,
		        'chooseDateFrom'	:		function() { return sealingDateFrom.replace(/-/g, ''); },
		        'chooseDateTo'		:		function() { return sealingDateTo.replace(/-/g, ''); },
		    },
		},
		columns: [
            { data: 'sealingDate',
	    		render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD') ;
	    		}
            },
			{ data: 'ordLotNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	               		html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'goodsNm' },
			{ data: 'userOutputCnt' },
			{ data: 'sealing1' },
			{ data: 'sealing2' },
			{
				data: "filmFaultyCheck",
				render: function(data, type, row, meta) {
					if(data == 'Y') {
						return "O";
					} else {
						return "X";
					}
				}
			},
		],
        columnDefs: [
        	{ targets: [0,1,2,3,5,6,7], className: 'text-center' },
        	{ targets: [4], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4], className: 'text-right-td' },
        ],		
		order: [
			[ 1, 'asc' ],
		],
    });

	let html2 = '<div class="row">';
	html2 += '&nbsp;&nbsp;<label class="input-label-sm touch6">실링검사일</label>';
	html2 += '<div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control touch6" style="width:120px;" type="text" id="chooseDateFrom" />';
	html2 += '<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button" style="width:30px; height:30px;">';
	html2 += '<span class="oi oi-calendar" style="font-size: 15px;"></span>';
	html2 += '</button>';
	html2 += '</div>';
	html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm touch6">~</label>';
	html2 += '<div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control touch6" style="width:120px;" type="text" id="chooseDateTo" />';
	html2 += '<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"	class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button" style="width:30px; height:30px;">';
	html2 += '<span class="oi oi-calendar" style="font-size: 15px;"></span>';
	html2 += '</button>';
	html2 += '</div>';
	html2 += '<button type="button" class="btn btn-primary float-right touch6 ml-2" id="btnRetv">조회</button>';
	html2 += '</div>';
	$('#sealingWorkOrdList_length').html(html2);
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);
	

    //실링검사작지 제품 포장번호목록
	$.fn.dataTable.ext.errMode = 'none';
	let productDtlTable = $('#productiDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: true,
		info: true,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
		pageLength: 10,
		ajax: {
		    url: '<c:url value="qm/goodsDisuseListScan"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'		: 		menuAuth,
		        'workOrdNo'		:		function() { return workOrdNo },
		    },
		},
		columns: [
			{ data: 'boxNo' },
			{ data: 'ordLotNo',
	       		render: function(data, type, row, meta) {
					html = '';
					if (row['workOrdNo'] == null || row['workOrdNo'] == "") {
						html = '-';
					} else {
						if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
							html = '<p id="ordLotNoText'+row['workNo']+'" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
						} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
							html = '<p id="ordLotNoText'+row['workNo']+'" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
						}
					}
					return html;
	       		}
			},
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
					html = '';
					if (row['workOrdNo'] == null || row['workOrdNo'] == "") {
						html = '-';
					} else {
						if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
							html = '<p id="ordLotNoText'+row['workNo']+'" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
						} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
							html = '<p id="ordLotNoText'+row['workNo']+'" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
						}
					}
					return html;
	       		}
			},
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm' },

			{ data: 'packDtlCnt',
	       		render: function(data, type, row, meta) {
					html = '';
					if (row['workOrdNo'] == null || row['workOrdNo'] == "") {
						html = row['remainCnt'];
					} else {
						html = data;
					}
					return html;
	       		}
			},
			
			{
				data: "disuseYnNm",
				render: function(data, type, row, meta) {
					if(row['disuseYn'] == 'N') {
						return data;
					} else if(row['disuseYn'] == 'Y') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					}
				}
			},
			{
				data: "divisionYnNm",
				render: function(data, type, row, meta) {
					if(row['divisionYn'] == 'N') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else if(row['divisionYn'] == 'D') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['divisionYn'] == 'M') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
		],
        columnDefs: [
        	{ targets: [0,1,2,4,6,7], className: 'text-center' },
        	{ targets: [5], className: 'text-right' },
        	{ targets: [5] , render: $.fn.dataTable.render.number( ',' )},
        ],		
		order: [
			[ 1, 'desc' ],
		],
		//drawCallback: function () {
		//	let sumUserOutputCnt	=	$('#productiDtlTable').DataTable().column(5, {page:'all'}).data().sum();
		//	$('#sumUserOutputCnt').html(addCommas(sumUserOutputCnt));
        //},
    });

	$('#productiDtlTable_length').html('');
	
	//작지 스캔
	$("#workOrdNo").keypress(function (e) {
		console.log(e);
		if (e.which == 13) {
			if (($('#workOrdNo').val().length != "14")) {
				toastr.warning('작지번호가 아닙니다.<br>입력정보를 확인해주세요.');
				$('#mergeBoxNo1').select();
				return false;
            }
			workOrdNo = $('#workOrdNo').val()
			
			$.ajax({
				url: '<c:url value="po/readWorkOrdSealing"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'workOrdNo'		: 		function() { return workOrdNo; },
				},
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						toastr.success(res.message);
						$('#ordLotNo').val(data.ordLotNo);
						$('#goodsNm').val(data.goodsNm);
						$('#userOutputCnt').val(addCommas(data.userOutputCnt));
						$('#sealing1').val(data.sealing1);
						$('#sealing2').val(data.sealing2);
						if (data.filmFaultyCheck == 'Y') {
							$("input:checkbox[id='filmFaultyCheck']").prop("checked", true);
						} else {
							$("input:checkbox[id='filmFaultyCheck']").prop("checked", false);
						}
						$('#workOrdNo').attr('disabled', true);
						$('#sealing1').attr('disabled', false);
						$('#sealing2').attr('disabled', false);
						$('#filmFaultyCheck').attr('disabled', false);
						$('#btnSave').attr('disabled', false);
					} else if (res.result == 'fail') {
						toastr.warning(res.message, {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, {timeOut: 5000});
					}
				},
				complete:function(){
					$('#productiDtlTable').DataTable().ajax.reload(function () {});
				}
			});
        }
    });

	//초기화btn
	$('#btnSave').on('click', function() {
		if (($('#sealing1').val() == 0)) {
			toastr.warning('실효 1번 값을 입력해주세요!');
			$('#sealing1').select();
			return false;
        }
		if (($('#sealing2').val() == 0)) {
			toastr.warning('실효 2번 값을 입력해주세요!');
			$('#sealing2').select();
			return false;
        }

		filmFaultyCheck = 'N';
		if($("input:checkbox[id='filmFaultyCheck']").is(":checked") == true) {
			filmFaultyCheck = 'Y';
		}
		
		$.ajax({
			url: '<c:url value="po/updateSealingWorkOrd"/>',
			type: 'GET',
			data: {
				'menuAuth'	 		: 		menuAuth,
				'workOrdNo'			:		function() { return $('#workOrdNo').val(); },
				'sealing1'			: 		function() { return $('#sealing1').val(); },
				'sealing1'			: 		function() { return $('#sealing1').val(); },
				'sealing2'			: 		function() { return $('#sealing2').val(); },
				'filmFaultyCheck'	: 		function() { return filmFaultyCheck; },
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success(res.message);
					$('#ordLotNoTraceTable').DataTable().ajax.reload( function () {});
					$('#sealing1').attr('disabled', true);
					$('#sealing2').attr('disabled', true);
					$('#filmFaultyCheck').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
				} else if (res.result == 'fail') {
					toastr.warning(res.message, {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, {timeOut: 5000});
				}
			},
			complete:function(){
				$('#sealingWorkOrdList').DataTable().ajax.reload(function () {});
			}
		});
	});

	//초기화btn
	$('#btnRetv').on('click', function() {

		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		
		sealingDateFrom = $('#chooseDateFrom').val()
		sealingDateTo = $('#chooseDateTo').val()
		$('#sealingWorkOrdList').DataTable().ajax.reload(function () {});
	});
	
	//초기화btn
	$('#btnReset').on('click', function() {
		reset();
	});

	//초기화
	function reset() {
		$('#workOrdNo').val("");
		$('#ordLotNo').val("");
		$('#goodsNm').val("");
		$('#userOutputCnt').val("");
		$('#sealing1').val("");
		$('#sealing2').val("");
		$("input:checkbox[id='filmFaultyCheck']").prop("checked", false);
		$('#workOrdNo').attr('disabled', false);
		$('#sealing1').attr('disabled', true);
		$('#sealing2').attr('disabled', true);
		$('#filmFaultyCheck').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#productiDtlTable').DataTable().clear().draw();
	}

    $('#sealingWorkOrdList tbody').on('dblclick', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
        	$(this).removeClass('selected');
        } else {
        	$('#sealingWorkOrdList').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			reset();
			workOrdNo = sealingWorkOrdList.row(this).data().workOrdNo;
			$('#workOrdNo').val(workOrdNo);
			$('#workOrdNo').trigger({type: 'keypress', which : 13});
        }
	});
	
    $('#productiDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
        	$(this).removeClass('selected');
        } else {
        	$('#productiDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
        }
	});

</script>

</body>
</html>