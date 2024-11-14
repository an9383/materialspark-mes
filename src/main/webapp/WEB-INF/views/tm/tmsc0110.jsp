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
				<li class="breadcrumb-item active">창고별제품위치</li>
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
						<table id="locationTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center" nowrap>창고위치</th>
									<th class="text-center" nowrap>총개수</th>
									<th class="text-left" id="boxNoHead">BOX_NO</th>
								</tr>
								<!-- <tr id="boxNoNubmer">
										<th style="min-width: 50px" class="text-center">BOX_NO1</th>
								</tr> -->
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

	let menuAuth = "tmsc0110";
	let currentHref = "tmsc0110";
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","창고별제품위치");
	
	//공통코드 처리 시작
	//let locationPos=new Array();	//창고위치
    //<c:forEach items="${location}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	locationPos.push(json);
    //</c:forEach>
    //공통코드 처리 종료  

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let locationTable = $('#locationTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",         
		language: lang_kor,
        paging: false,
        info: true,       
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        pageLength: false,
        searching: true,
        //destroy: true, 
        //header 고정
        scrollY: '70vh',
        scrollX: true,
        fixedColumns: {
        	leftColumns: 2
        },
        ajax: {
            url: '<c:url value="/tm/locationList"/>',
            type: 'GET',
            data: { 	
            },
        },
        columns: [
            { data : 'locationNm' },
            { data : 'boxNoCount'},
            { data : 'boxNo' },
        ],
        columnDefs : [
        	{ targets: [2], className: 'text-left' },
        ],
        order: [
            //[ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '창고별제품위치',
            },
            {
                extend: 'excel',
                title: '창고별제품위치',
            },
            {
                extend: 'print',
                title: '창고별제품위치',
            }
        ],
        drawCallback: function () {
        	$('#locationTable tbody').find('td').attr('style','white-space: nowrap');
        },
    }); 
</script>

</body>
</html>