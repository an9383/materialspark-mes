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
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">성적서관리</li>
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
					<table id="matrlInOutWhsTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th>체크</th>
								<th>검사일</th>
								<th>자재코드</th>
								<th>자재명</th>
								<th class="text-center">가입고량</th>
								<th class="text-center">입고량</th>
								<th class="text-center">차이</th>
								<th>공급업체</th>
								<th>가입고일</th>
								<th>비고</th>
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

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0070';
	let currentHref = 'qmsc0070';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","성적서관리");
	    
	//공통코드 처리 시작
 	var qutyCdCode=new Array(); // 승인여부
     <c:forEach items="${qutyCd}" var="info">
 		var json=new Object();
 		json.baseCd="${info.baseCd}";
 		json.baseCdNm="${info.baseCdNm}";
 		qutyCdCode.push(json);
     </c:forEach>
    //공통코드 처리 종료  

	var inWhsDateFromCal =  "${serverDateFrom}"; 
	var inWhsDateToCal =  "${serverDate}"; 
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsTable = $('#matrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 20,
        ajax: {
            url: '<c:url value="/io/matrlInOutWhsDataList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDateFrom':  function() { return inWhsDateFromCal.replace(/-/g, ''); },
	           	'inWhsDateTo':  function() { return inWhsDateToCal.replace(/-/g, ''); },
	           	'qutyCd':  function() { return $('#qutyCd').val(); },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'lotNo',
        columns: [
	    	{ 
	    		render: function(data, type, row, meta) {			    			
					return '<input type="checkbox" name="chk">' ;
	    		}
			},
        	{ 
                data: 'inspctDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'preInWhsQty',
            	render: function(data, type, row) {					
            		return parseFloat(data).toFixed(2);
            	}
            },
            { data: 'inWhsQty',
            	render: function(data, type, row) {					
            		return parseFloat(data).toFixed(2);
            	}	
            },
            { data: 'preInDiff',
            	render: function(data, type, row) {					
            		return parseFloat(data).toFixed(2);
            	}	
            },
            { data: 'spplyDealCorpNm' },
            { 
                data: 'preInWhsDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'inWhsDesc' },
        ],
        columnDefs: [
        	
            { targets: [4,5,6], render: $.fn.dataTable.render.number( ',' ) },
            { targets: [4,5,6], className: 'text-right' },                
            
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
	        {
	            extend: 'copy',
	            title: '성적서관리',
	        },
	        {
	            extend: 'excel',
	            title: '성적서관리',
	        },
	        {
	            extend: 'print',
	            title: '성적서관리',
	        },
        ],
    });

    var sysdate = "${serverTime}";
    var html1 = '<div class="row">';
		html1 += '&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="inWhsDateFrom" name="inWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(inWhsDateFrom,inWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="inWhsDateTo" name="inWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(inWhsDateTo,inWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">재질</label><select  class="custom-select" style="width:55px;" id="qutyCd" ></select>';
		html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>'
		html1 += '</div>';
		
	$('#matrlInOutWhsTable_length').html(html1);
	$('#inWhsDateFrom').val(inWhsDateFromCal);
	$('#inWhsDateTo').val(inWhsDateToCal);
	selectBoxAppend(qutyCdCode, "qutyCd", "", "1");
	
    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    // 조회
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#inWhsDateFrom').val());
		let dateTo = new Date($('#inWhsDateTo').val());
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
		
    	inWhsDateFromCal =  $('#inWhsDateFrom').val();
    	inWhsDateToCal =  $('#inWhsDateTo').val();   
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });

</script>

</body>
</html>
