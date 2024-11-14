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
				<li class="breadcrumb-item active">제품(월재고현황)</li>
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
					<table id="preGoodsInventoryInfoTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th>구분</th>
								<th>제품명</th>
								<th>모델NO</th>
								<th>재질</th>
								<th>규격</th>
								<th>이월량</th>
								<th>입고량</th>
								<th>출고량</th>
								<th>재고량</th>
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

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'tmsc0070';
	let currentHref = 'tmsc0070';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품(월재고현황)");
    let viewIdx;
    let sideView = 'add';
    
  	//공통코드 처리 시작
    var orderGubunCode=new Array();
    <c:forEach items="${orderGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		orderGubunCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
                     
    //alert("test ="+JSON.stringify(useYnCode));
    //$("#matrlCd").attr("disabled",true);
    //$("#dealCorpNm").attr("disabled",true);
	//uiProc(true);
	
	var invntryNo =  "${serverDate}"; 
	invntryNo = invntryNo.substring(0,7)
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let preGoodsInventoryInfoTable = $('#preGoodsInventoryInfoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ajax: {
            url: '<c:url value="/tm/preGoodsInventoryInfoDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'invntryNo': function() { return invntryNo.replace(/-/g, ''); }
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'invntryNo',
        columns: [
            { data: 'orderGubunNm' },
            { data: 'goodsNm' },
            { data: 'modelNo' },
            { data: 'qutyNm' },
            { data: 'model' },
            { data: 'forwordBoxCnt' },
            { data: 'inputBoxCnt' },
            { data: 'outputBoxCnt' },
            { data: 'invntryAllCnt' },                          
        ],
        columnDefs: [
           	{ targets: [5,6,7,8] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [5,6,7,8],  className: 'text-right-td'},
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품재고관리',
            },
            {
                extend: 'excel',
                title: '제품재고관리',
            },
            {
                extend: 'print',
                title: '제품재고관리',
            },
        ],
    });

    //var sysdate = "${serverTime}";
    var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">조회일자</label><input type="text" class="form-control" id="invntryNo" style="width:65px;">';
       //html1 += '<button class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button" disabled><span class="oi oi-calendar"></span></button>'
	var html2 =  '&nbsp; <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
	$('#preGoodsInventoryInfoTable_length').html(html1 + html2);
	$('#invntryNo').val(invntryNo);
	//selectBoxAppend(approvalCode, "approvalCd", "", "1");
	
    // 보기
    $('#preGoodsInventoryInfoTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#preGoodsInventoryInfoTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});	
	
	//조회
    $('#btnRetv').on('click', function() {
    	invntryNo =  $('#invntryNo').val();
		$('#preGoodsInventoryInfoTable').DataTable().ajax.reload( function () {});
    });	

	//yyyy-mm 달력
	$('#invntryNo').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});	
	
</script>
</body>
</html>