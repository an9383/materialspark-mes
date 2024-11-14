<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">설비관리</a></li>
				<li class="breadcrumb-item active">설비보전이력관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="repairTable" class="table table-bordered">
					<colgroup>
						<col width="7%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="10%">
						<col width="20%">
						<col width="7%">
						<col width="7%">
						<col width="10%">
						<col width="10%">
					</colgroup>
						<thead class="thead-light">
							<tr>
								<th>수리 등록일</th>
								<th>설비그룹</th>
								<th>설비명</th>									
								<th>고장 현상</th>
								<th>고장 원인</th>
								<th>조치 및 대책</th>
								<th>수리업체</th>
								<th>수리시간</th>
								<th>사용 부품내역</th>
								<th>비고</th>									
							</tr>
						</thead>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'emsc0010';
	let currentHref = 'emsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","설비보전이력관리");
    
	//공통코드 처리 시작
// 	var approvalCode=new Array(); // 승인여부
//     <c:forEach items="${approvalCd}" var="info">
// 		var json=new Object();
// 		json.baseCd="${info.baseCd}";
// 		json.baseCdNm="${info.baseCdNm}";
// 		approvalCode.push(json);
//     </c:forEach>
    //공통코드 처리 종료  
                     
    var repairDateFrom =  "${repairDateFrom}";
	var repairDateTo =  "${repairDateTo}";

	//테이블 목록
	$.fn.dataTable.ext.errMode = 'none';
	let repairTable = $('#repairTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : 20,
		//ordering: false,
		ajax : {
			url : '<c:url value="em/repairDataList"/>',
			type : 'GET',
			data : {
				'menuAuth'	 : menuAuth,
				'repairDateFrom': function() { return repairDateFrom; },
   	           	'repairDateTo': function() { return repairDateTo; },
			},
		},
		rowId : 'equipCd',
		columns : [
				{data : 'repairRegDate',
					 render: function(data, type, row) {		
						 if(moment(data).format('YYYY-MM-DD') != "Invalid date"){
							return moment(data).format('YYYY-MM-DD');
						 } else{
							 return "";
						 }
		              } 
				}, 
				{data : 'equipGroupNm'},
				{data : 'equipNm'},
				{data : 'troubleState'},
				{data : 'troubleCause'},
				{data : 'actPlan'},
				{data : 'repairDealCorpNm'},
				{data : 'repairTime'},
				{data : 'repairMatrl'},
				{data : 'repairDesc'}	
		],
	    order: [
	        [ 0, 'asc' ]
	    ],
        buttons: [
            {
			    extend: 'copy',
			    title: '설비고장/수리이력관리',
			},
			{
			    extend: 'excel',
			    title: '설비고장/수리이력관리',
			},
			            {
			    extend: 'print',
			    title: '설비고장/수리이력관리',
			},
		],
	});
	
	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm">수리 등록일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="From" name="From" />';
	html1 += '<button onclick="fnPopUpCalendar(From,From,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="To" name="To" />';
	html1 += '<button onclick="fnPopUpCalendar(To,To,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';	
	html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>'
	html1 += '</div>';
	
	$('#repairTable_length').html(html1);
	$('#From').val(repairDateFrom);
	$('#To').val(repairDateTo);
	  	
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#From').val());
		let dateTo = new Date($('#To').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		
    	repairDateFrom = $('#From').val().replace(/-/g, '');
    	repairDateTo = $('#To').val().replace(/-/g, '');
		$('#repairTable').DataTable().ajax.reload();
	});
	
	$('#repairTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#repairTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});


</script>

</body>
</html>
