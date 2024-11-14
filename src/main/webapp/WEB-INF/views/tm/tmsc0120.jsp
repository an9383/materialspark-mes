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
				<li class="breadcrumb-item"><a href="#">재고관리</a></li>
				<li class="breadcrumb-item active">예약(수불이력자재&제품)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="padding-bottom: 0px;">
				<div id="alnicuMatrlTable">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="stockPaymentAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center" nowrap>일련번호</th>
									<th class="text-center" nowrap>자재&제품 코드</th>
									<th class="text-center" nowrap>자재&제품 명</th>
									<th class="text-center" nowrap>자재&제품 고유번호</th>
									<th class="text-center" nowrap>품목명</th>
									<th class="text-center" nowrap>입출고 구분</th>
									<th class="text-center" nowrap>일자</th>
									<th class="text-center" nowrap>무게</th>
									<th class="text-center" nowrap>개수</th>
									<th class="text-center" nowrap>위치</th>
									<th class="text-center" nowrap>공장명</th>
									<th class="text-center" nowrap>비고</th>
									<th class="text-center" nowrap>등록자</th>
									<th class="text-center" nowrap>등록일시</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
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

	let menuAuth = "tmsc0120";
	let currentHref = "tmsc0120";
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","예약(수불이력자재&제품)");
	
	//공통코드 처리 시작
	//let locationPos=new Array();	//창고위치
	//<c:forEach items="${location}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	locationPos.push(json);
	//</c:forEach>
	//공통코드 처리 종료  
	
	let lotNo = null;
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let stockPaymentAdmTable = $('#stockPaymentAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",     
		language: lang_kor,
		language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
		//select: true,
        pageLength: 99999,
		ajax: {
			url: '<c:url value="/io/readStockPaymentAdmList"/>',
			type: 'GET',
			data: {
				'menuAuth'		: 	menuAuth,
				'lotNo'			:	function() { return lotNo; },
			},
		},
		columns: [
			{ data : 'spSeq' },
			{ data : 'spCd' },
			{ data : 'spNm' },
			{ data : 'lotNo' },
			{ data : 'spTypeNm' },
			{ data : 'spGubunNm' },
			{ 
				data: 'spDate',
				render: function(data, type, row) {					
					return moment(data).format("YYYY-MM-DD");
				} 
			},
			{ 
				data: 'spQty',
				render: function(data, type, row) {
					return data.toFixed(2);
				} 
			},
			{ data : 'spCount' },
			{ data : 'locationNm' },
			{ data : 'factoryNm' },
			{ data : 'spDesc' },
			{ data : 'regId' },
			{ 
				data: 'regDate',
				render: function(data, type, row) {					
					return moment(data).format("YYYY-MM-DD HH:mm:ss");
				} 
			},
		],
		columnDefs : [
			{ targets: [7,8], className: 'text-right' },
			{ targets: [7,8], render: $.fn.dataTable.render.number( ',' ) },
		],
		//order: [
		//    [ 0, 'desc' ]
		//],
		buttons: [
			{
				extend: 'copy',
				title: '예약(수불이력자재&제품)',
			},
			{
				extend: 'excel',
				title: '예약(수불이력자재&제품)',
			},
			{
				extend: 'print',
				title: '예약(수불이력자재&제품)',
			}
		],
		drawCallback: function () {
			$('#stockPaymentAdmTable tbody').find('td').attr('style','white-space: nowrap');
		},
    });
	
	let html1 = '<div class="row">';
		html1 += '<label class="input-label-sm ml-1">자재or제품 고유번호 : </label><input class="form-control" style="width:150px;" type="text" id="lotNo"/>';
		html1 += '<button type="button" class="btn btn-primary ml-2" id="btnRetv">조회</button></div>';
		html1 += '</div>';
	$('#stockPaymentAdmTable_length').html(html1);

	// 보기
    $('#stockPaymentAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#stockPaymentAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
	$('#btnRetv').on('click', function() {
		lotNo = $.trim($('#lotNo').val());
		$('#stockPaymentAdmTable').DataTable().ajax.reload();
	});
	
	$("#lotNo").keypress(function (e) {
		if (e.which == 13){
			$('#btnRetv').trigger('click');
		}
	});
	
</script>

</body>
</html>