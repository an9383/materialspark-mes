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
				<li class="breadcrumb-item active">생산 자재재고</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="table-responsive" style="padding-bottom: 10px;">
					<table id="matrlPreOutDateTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<!--
								<th style="min-width:40px" class="text-center">
									<input type="checkbox" id="checkAll" name="checkAll">
								</th>
								-->
								<th style="min-width:50px" class="text-center">승인구분</th>
								<th style="min-width:80px" class="text-center">가출고일</th>
								<!-- <th style="min-width:80px" class="text-center">가출고 설비명</th> -->
								<!-- <th style="min-width:80px" class="text-center">가출고 제품명</th> -->
								<th style="min-width:110px" class="text-center">S-LOT</th>
								<th style="min-width:110px" class="text-center">LOT NO</th>
								<th style="min-width:60px" class="text-center">자재코드</th>
								<th style="min-width:160px" class="text-center">자재명</th>
								<th style="min-width:50px" class="text-center">가입고량</th>
								<th style="min-width:50px" class="text-center">입고량</th>
								<th style="min-width:50px" class="text-center">차이</th>
								<th style="min-width:80px" class="text-center">공급업체</th>
								<th style="min-width:75px" class="text-center">가입고일</th>
								<th style="min-width:75px" class="text-center">수입 검사일</th>
								<th style="min-width:110px" class="text-center">바코드</th>
								<th style="min-width:80px" class="text-center">상태</th>
								<th style="min-width:80px" class="text-center">입고일</th>
								<!-- <th style="min-width:80px" class="text-center">검사일</th> -->
								<th style="min-width:80px" class="text-center">투입일</th>
								<th style="min-width:80px" class="text-center">창고 위치</th>
								<th style="min-width:80px" class="text-center">선입선출</th>
								<th style="min-width:150px" class="text-center">비고</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="6" style="text-align: center">합계</td>																		
								<td id="sumInWhsQty" style="text-align: right">0</td>	
								<td id="sumInspectQty" style="text-align: right">0</td>	
								<td id="sumAdjustQty" style="text-align: right">0</td>	
								<td colspan="10"></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'tmsc0090';
	let currentHref = 'tmsc0090';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산 자재재고");
	
	var serverDateFrom = "${serverDateTo}";   
	var servertDateTo = "${serverDateTo}";
	var chooseDateFrom = serverDateFrom;
	var chooseDateTo = servertDateTo;
	var qutyCd = '';
	
	//공통코드 시작
    var qutyCode=new Array();
    <c:forEach items="${qutyCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		qutyCode.push(json);
    </c:forEach>
  	//공통코드 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlPreOutDateTable = $('#matrlPreOutDateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/tm/matrlOutpoutDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 	menuAuth,
	           	'preOutWhsDateFrom'	:	function() { return chooseDateFrom.replace(/-/g, ''); },
	           	'preOutWhsDateTo'	:	function() { return chooseDateTo.replace(/-/g, ''); },
	           	'qutyCd'			:	function() { return qutyCd; },
            },
        },
        rowId: 'poNo',
        columns: [
			//{ 
			//	render: function(data, type, row, meta) {			    			
			//		return '<input type="checkbox" id="chk-' + meta.row + '" name="chk">' ;
			//	}
			//},
			{ data: 'approvalNm' },
			{
			    data: 'preOutWhsDate',
			    render: function(data, type, row) {
					if(data == "" || data == null) {
						return "-";
					} else {
						return moment(data).format("YYYY-MM-DD");
					} 
			    } 
			},
			//{
			//    data: 'preOutEquipNm',
			//    render: function(data, type, row) {					
			//		if(data == "" || data == null) {
			//			return "-";
			//		} else {
			//			return data;
			//		} 
			//    } 
			//},
			//{
			//    data: 'preOutGoodsNm',
			//    render: function(data, type, row) {					
			//		if(data == "" || data == null) {
			//			return "-";
			//		} else {
			//			return data;
			//		} 
			//    } 
			//},
			{ data: 'srLot' },
			{ data: 'lotNo' },
			{ data: 'matrlCd' },
			{ data: 'matrlNm' },
			{ data: 'preInWhsQty',
				 render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
			     }   	
			},
			{ data: 'inspectQty',
				 render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
			     }   
			},
			{ data: 'diffQty',
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
			{ data: 'barcodeNo' },
			{
				data: 'statusCd',
				render: function(data, type, row) {
					if(data == "S" || data == "I") {
						return '가입고';
					} else if(data == "A") {
						return '수입검사 완료';
					} else if(data == "O") {
						return '출고(가출고)';
					} else if(data == "P") {
						return "생산 투입";
					}
				}
			},
			{
			    data: 'inWhsDate',
			    render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
			    } 
			},
			//{
			//    data: 'inspectDate',
			//    render: function(data, type, row) {
			//		if(data != "") {
			//			return data;
			//		} else {
			//			return "-";
			//		}
			//    }
			//},
			{
			    data: 'outWhsDate',
			    render: function(data, type, row) {					
					if(data == "" || data == null) {
						return "-";
					} else {
						return moment(data).format("YYYY-MM-DD");
					} 
			    } 
			},
			{ data: 'locationNm' },
			{ 
			    data: 'fifoCheck',
			    render: function(data, type, row) {					
					if (data == "Y") {
						let html = "적용"
						return html;
					} else if (data == "N") {
						let html = "미적용"
						return html;
					} 
			    } 
			},
			{ data: 'inWhsDesc' },
        ],
        columnDefs: [
           	{ targets: [6,7,8], render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [6,7,8], className: 'text-right' },
           	//{ orderable: false, targets: [0] },
        ],
        order: [
			[ 1, 'asc' ],
			[ 14, 'asc' ],
			[ 15, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '자재 생산팀재고',
            },
            {
                extend: 'excel',
                title: '자재 생산팀재고',
            },
            {
                extend: 'print',
                title: '자재 생산팀재고',
            },
        ],
		drawCallback: function () {
			var sumInWhsQty = $('#matrlPreOutDateTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sumInspectQty = $('#matrlPreOutDateTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sumAdjustQty = $('#matrlPreOutDateTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			$('#sumInWhsQty').text(addCommas(sumInWhsQty.toFixed(2)));
			$('#sumInspectQty').text(addCommas(sumInspectQty.toFixed(2)));
			$('#sumAdjustQty').text(addCommas(sumAdjustQty.toFixed(2)));
        }
    });

	var html1 = '<div class="row">';
	html1 += '&nbsp<label class="input-label-sm">가출고일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal" name="chooseDateFromCal" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateFromCal,chooseDateFromCal,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp&nbsp&nbsp<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal" name="chooseDateToCal" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '<label class="input-label-sm ml-2 mr-2">재질</label><select  class="custom-select" id="qutyCd" ></select>&nbsp;';
	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-1" id="btnRetv">조회</button>'
	$('#matrlPreOutDateTable_length').html(html1);

	$('#chooseDateFromCal').val(serverDateFrom);
	$('#chooseDateToCal').val(servertDateTo);
	selectBoxAppend(qutyCode, "qutyCd", "", "1");

    //보기
    $('#matrlPreOutDateTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#matrlPreOutDateTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

   	//재질 변경
    $('#qutyCd').on('change', function() {
		let dateFrom = new Date($('#chooseDateFromCal').val());
		let dateTo = new Date($('#chooseDateToCal').val());
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
		
    	chooseDateFrom =  $('#chooseDateFromCal').val();
    	chooseDateTo=  $('#chooseDateToCal').val();
    	qutyCd =  $('#qutyCd').val();
    	
		$('#matrlPreOutDateTable').DataTable().ajax.reload( function () {});
    });
    
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFromCal').val());
		let dateTo = new Date($('#chooseDateToCal').val());
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
		
    	chooseDateFrom =  $('#chooseDateFromCal').val();
    	chooseDateTo=  $('#chooseDateToCal').val();
    	qutyCd =  $('#qutyCd').val();
    	
		$('#matrlPreOutDateTable').DataTable().ajax.reload( function () {});
    });
    
</script>

</body>
</html>

