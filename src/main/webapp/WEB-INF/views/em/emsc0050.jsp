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
				<li class="breadcrumb-item active">컨버트 모니터링</li>
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
						<col width="7%">
						<col width="7%">
						<col width="7%">
					</colgroup>
						<thead class="thead-light">
							<tr>
								<th>idx</th>
								<th>x</th>
								<th>y</th>
								<th>z</th>
								<th>equipNm</th>
								<th>등록일</th>
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

	let menuAuth = 'emsc0050';
	let currentHref = 'emsc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","컨버트 모니터링");
    
    var repairDateFrom	=  "${repairDateFrom}";
	var repairDateTo	=  "${repairDateTo}";

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
		ajax : {
			url : '<c:url value="em/memsInfoList"/>',
			type : 'GET',
			data : {
				'menuAuth'		: function() { return menuAuth; 	},
   	           	'repairDateTo'	: function() { return repairDateTo.replace(/-/g, ''); }
			},
		},
		rowId : 'idx',
		columns : [
			
			{ data : 'idx'		},
			{ data : 'x'		},
			{ data : 'y'		},
			{ data : 'z'		},
			{ data : 'equipNm'	},
			{ data : 'regDate',
				 render: function(data, type, row) {		
					 if(moment(data).format('YYYY-MM-DD') != "Invalid date"){
						return moment(data).format('YYYY-MM-DD');
					 } else{
						 return "-";
					 }
				} 
			}
		],
	    order: [
	        [ 0, 'asc' ]
	    ],
        buttons: [
            { extend: 'copy'	},
			{ extend: 'excel'	},
            { extend: 'print'	},
		],
	});
	
	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm">등록일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="To" name="To" />';
	html1 += '<button onclick="fnPopUpCalendar(To,To,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';	
	html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>'
	html1 += '</div>';
	
	$('#repairTable_length').html(html1);
	$('#To').val(repairDateTo);
	  	
    $('#btnRetv').on('click', function() {
		/*let dateFrom = new Date($('#From').val());
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
		
    	repairDateFrom = $('#From').val().replace(/-/g, '');*/
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
