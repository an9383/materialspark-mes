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
				<li class="breadcrumb-item"><a href="#">시스템관리</a></li>
				<li class="breadcrumb-item active">시스템로그관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; padding-bottom: 0px;">
				<div class="card-header card-tab" style="margin-bottom: 7px;">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">로그인기록관리</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">페이지접속기록관리</a></li>
					</ul>
				</div>
				<div class="table-responsive" style="padding-bottom:5px;">
					<div id="tabContent1">
						<table id="outputTable1" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>아이디</th>
									<th>성명</th>
									<th>접속/종료 일시</th>
									<th>구분(접속,로그아웃)</th>
									<th>IP</th>
								</tr>
							</thead>
						</table>
					</div>
					<div id="tabContent2" class="d-none">
						<table id="outputTable2" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>아이디</th>
									<th>성명</th>
									<th>부서</th>
									<th>메뉴명</th>
									<th>메뉴경로</th>
									<th>접속일</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>
	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'smsc0060';
	let currentHref = 'smsc0060';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');	
	$(document).attr("title","시스템로그관리");

	var serverDateFrom = "${serverDateFrom}";
	var serverDate = "${serverDate}";
	var chooseDateFrom = serverDateFrom;
	var chooseDateTo = serverDate;

	let tabTemp = 1;
    
    //로그인기록관리
	$.fn.dataTable.ext.errMode = 'none';
	let outputTable1 = $('#outputTable1').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        scrollY : "56vh",
        scrollCollapse: true,
        pageLength: -1,
        ajax: {
            url: '<c:url value="sm/systemLogAdmList"/>',
            type: 'GET',
            data: {
            	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            },
        },
		columns: [
			{ data: 'userId' },
			{ data: 'userNm' },
			{ data: 'logDate' },
			{ data: 'gubun' },
			{ data: 'ipAddress' },
		],
        columnDefs: [
        	
        ],
		order: [
			[ 2, 'desc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '시스템로그관리 - 로그인기록관리',
            },
            {
                extend: 'excel',
                title: '시스템로그관리 - 로그인기록관리',
            },
            {
                extend: 'print',
                title: '시스템로그관리 - 로그인기록관리',
            },
        ],
		drawCallback: function () {
			
		},
	});

	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html1 += '&nbsp;<label class="input-label-sm">접속/종료 일시</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal1"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFromCal1,chooseDateFromCal1,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal1"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal1,chooseDateToCal1,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
//		html1 += '<div>';
// 		html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm1">기간선택</button>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv1">조회</button>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-secondary" id="btnLogSend">로그전송</button>';	
		html1 += '</div>';
	$('#outputTable1_length').html(html1);
	$('#chooseDateFromCal1').val(chooseDateFrom);
	$('#chooseDateToCal1').val(chooseDateTo);
	
	//페이지접속기록관리 테이블
	$.fn.dataTable.ext.errMode = 'none';
	let outputTable2 = $('#outputTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        scrollY : "56vh",
        scrollCollapse: true,
        pageLength: -1,
        ajax: {
            url: '<c:url value="sm/pageLogAdmList"/>',
            type: 'GET',
            data: {
//             	'chooseDate1'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            },
        },
		columns: [
			{ data: 'userId' },
			{ data: 'userNm' },
			{ data: 'departmentCdNm' },
			{ data: 'menuPathNm' },
			{ data: 'menuPath' },
			{ data: 'accessDate' },
		],
        columnDefs: [
        	
        ],
		order: [
			[ 5, 'desc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: '시스템로그관리 - 페이지접속기록관리',
            },
            {
                extend: 'excel',
                title: '시스템로그관리 - 페이지접속기록관리',
            },
            {
                extend: 'print',
                title: '시스템로그관리 - 페이지접속기록관리',
            },
        ],
		drawCallback: function () {
			
		},
	});

	var html2 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html2 += '&nbsp;<label class="input-label-sm">접속일</label><input class="form-control d-none" style="width:97px;" type="text" id="chooseDateFromCal2"/>';
		html2 += '<button onclick="fnPopUpCalendar(chooseDateFromCal2,chooseDateFromCal2,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search d-none" id="chooseDateFromCalendar2" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>';
		html2 += '</div>';
		html2 += '<label class="input-label-sm d-none">~</label>';
		html2 += '<div class="form-group input-sub m-0 row">';
		html2 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal2"/>';
		html2 += '<button onclick="fnPopUpCalendar(chooseDateToCal2,chooseDateToCal2,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar2" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>';
		html2 += '</div>';
		html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm2">기간선택</button>';
		html2 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv2">조회</button></div>';
	$('#outputTable2_length').html(html2);
	$('#chooseDateFromCal2').val(chooseDateFrom);
	$('#chooseDateToCal2').val(chooseDateTo);
	
	$('#tab1, #tab2').on('click', function() { 
		let dateFrom = '';
		let dateTo = '';
		if (tabTemp == 1) {
			dateFrom = new Date($('#chooseDateFromCal1').val());
			dateTo = new Date($('#chooseDateToCal1').val());
		} else if (tabTemp == 2) {
			dateFrom = new Date($('#chooseDateFromCal2').val());
			dateTo = new Date($('#chooseDateToCal2').val());
		}
		
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}
		if (tabTemp == 1 && dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}
		if (tabTemp == 1 && dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}
		
		if ( 1 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 1;
// 			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
// 			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv1").trigger("click");
			$('#tabContent1').removeClass('d-none');
			$('#tabContent2').addClass('d-none');
			$('#tabContent3').addClass('d-none');
			$('#tabContent4').addClass('d-none');
		} else if ( 2 == right($(this).attr('id'), 1)) {
			chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
			chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
			tabTemp = 2;
// 			$('#chooseDateFromCal' + tabTemp).val(chooseDateFrom);
// 			$('#chooseDateToCal' + tabTemp).val(chooseDateTo);
			$("#btnRetv2").trigger("click");
			$('#tabContent1').addClass('d-none');
			$('#tabContent2').removeClass('d-none');
			$('#tabContent3').addClass('d-none');
			$('#tabContent4').addClass('d-none');
		}
		
    });

	$('#btnRetv1, #btnRetv2').on('click', function() {
		let dateFrom = '';
		let dateTo = '';
		if (tabTemp == 1) {
			dateFrom = new Date($('#chooseDateFromCal1').val());
			dateTo = new Date($('#chooseDateToCal1').val());
		} else if (tabTemp == 2) {
			dateFrom = new Date($('#chooseDateFromCal2').val());
			dateTo = new Date($('#chooseDateToCal2').val());
		}
		
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}
		if (tabTemp == 1 && dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}
		if (tabTemp == 1 && dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			if (tabTemp == 1) {
				$('#chooseDateFromCal1').focus();
			} else if (tabTemp == 2) {
				$('#chooseDateFromCal2').focus();
			}
			return false;
		}

		chooseDateFrom = $('#chooseDateFromCal' + tabTemp).val();
		chooseDateTo = $('#chooseDateToCal' + tabTemp).val();
		
		$('#outputTable' + tabTemp).DataTable().ajax.reload();
	});

	
    $('#outputTable1 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable1').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#outputTable2 tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#outputTable2').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
    //기간조회~
// 	$('#btnTerm1, #btnTerm2').on('click',function() {
// 		datePickFun();
// 	});

	
// 	$('#datePick').on('click',function() {
// 		var id ='';
		
// 		$.each($('.calender ul li'), function(){
// 			if( $(this).hasClass('clicked') ){
// 				id = $(this).attr('id');
// 			}
// 		});			
// 		datePick(id, 'chooseDateFromCal1', 'chooseDateToCal1',  $('#select-year').val());
// 		datePick(id, 'chooseDateFromCal2', 'chooseDateToCal2',  $('#select-year').val());
// 	});


	outputTable1.on('draw.dt', function(){
		outputTable1.columns.adjust();
	});
	
	outputTable2.on('draw.dt', function(){
		outputTable2.columns.adjust();
	});

	$('#btnLogSend').on('click', function() {
		let dateFrom = '';
		let dateTo = '';
		//alert("btnLogSend");
		$.ajax({
			url : '<c:url value="/sm/systemLogSend"/>',
			type : 'POST',
			data : {
				'menuAuth' 			: menuAuth,
            	'chooseDate1'	:	function() { return chooseDateTo.replace(/-/g, ''); },
            	'chooseDate2'	:	function() { return chooseDateTo.replace(/-/g, ''); },				
 			},
			beforeSend : function() {
			},
			success : function(res) {
				let data = res.data;

				if (res.result == 'ok') {
					toastr.success('로그정보가 정상 전송 되었습니다.');
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete : function() {
			}
		});		
	}); 
</script>
</body>
</html>
