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
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">작업일보관리</li>
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
					<table id="workDayTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">생산일</th>
								<th class="text-center">설비명</th>
								<th class="text-center">작지번호</th>
								<th class="text-center">생산 LotNo</th>
								<th class="text-center">주야</th>
								<th class="text-center">작지상태</th>
								<th class="text-center">제품</th>
								<th class="text-center">규격</th>
								<th class="text-center">재질</th>
								<th class="text-center">생산량</th>
								<th class="text-center">작업자</th>
								<th class="text-center">거래처</th>
								<th class="text-center">Film</th>
								<th class="text-center">면취(압연)</th>
								<th class="text-center">구분(연질,경질)</th>
								<!-- <th class="text-center">작업조</th> -->
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="8" style="text-align:center"></td>
								<td colspan="1" style="text-align:center">합계</td>
								<td colspan="" id="sumOutputCnt" style="text-align: right">0</td>
								<td colspan="5"></td>
							</tr>
						</tfoot>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0030';
	let currentHref = 'wmsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","작업일보관리");
	
	//공통코드 처리 시작
	var approvalCode=new Array(); // 승인여부
	<c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
	</c:forEach>
    //공통코드 처리 종료  
    
    var ordFromDate =  "${serverDateFrom}"                 
	var ordToDate =  "${serverDate}"
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let workDayTable = $('#workDayTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/wm/workDayDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: 	menuAuth,
            	'ordDate1'	:	function() { return ordFromDate.replace(/-/g, ''); },
	           	'ordDate2'	:	function() { return ordToDate.replace(/-/g, ''); },	           	
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'workOrdNo',
        columns: [
            { data: 'workOrdDate',
            	render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'equipNm' },
            { data: 'workOrdNo' },
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if (row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if (row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'ordGubunNm',
				render: function(data, type, row) {
					var html = '';
					if (row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if (row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'subWorkStatusNm' },
            { data: 'goodsNm' },
            { data: 'model' },
            { data: 'qutyNm' },
            { data: 'outputCnt' },
            { data: 'mainWorkChargrNm' },
            { data: 'dealCorpNm' },
            { data: 'filmMatrlNm' },   
            { data: 'chamferYnNm' }, 
            { data: 'gubunNm' },
        ],
        columnDefs: [
        	{ targets: [9] , render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [9], className: 'text-right' }, 
        ],
        order: [
            [ 1, 'asc' ]
        ],
        drawCallback: function () {
        	sumOutputCnt = $('#workDayTable').DataTable().column(9, { page: 'all'} ).data().sum();
        	$('#sumOutputCnt').html(addCommas(sumOutputCnt));
        },
        buttons: [
            {
                extend: 'copy',
                title: '작업일보관리',
            },
            {
                extend: 'excel',
                title: '작업일보관리',
            },
            {
                extend: 'print',
                title: '작업일보관리',
            }
        ],
    });
   
	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '&nbsp;<label class="input-label-sm">생산일</label>';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="ordDate1"/>';
	html1 += '<button onclick="fnPopUpCalendar(ordDate1,ordDate1,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="ordFromDate1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="ordDate2"/>';
	html1 += '<button onclick="fnPopUpCalendar(ordDate2,ordDate2,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="ordToDate2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
    
	$('#workDayTable_length').html(html1);
	$('#ordDate1').val(ordFromDate);
	$('#ordDate2').val(ordToDate);

	/* 
    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	 */

    $('#btnRetv').on('click', function() {
    	let dateFrom	= new Date($('#ordDate1').val());
		let dateTo		= new Date($('#ordDate2').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#ordDate1').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#ordDate1').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#ordDate1').focus();
			return false;
		}
		
		$('#my-spinner').show();
        
    	ordFromDate	= $('#ordDate1').val(); 
    	ordToDate	= $('#ordDate2').val();   
		$('#workDayTable').DataTable().ajax.reload( function () {
			$('#my-spinner').hide();
		});
    });	

    $('#workDayTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#workDayTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});
  	
</script>

</body>
</html>
