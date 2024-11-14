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
					<li class="breadcrumb-item"><a href="#">재고관리</a></li>
					<li class="breadcrumb-item active">제품검사 대기현황</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
		<div class="container-fluid" id="main">
			<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width:99%;">
				<div class="card">
				<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="standByInspectionWorkOrdList" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width:50px" class="text-center">생산일</th>
									<th style="min-width:40px" class="text-center">설비명</th>
									<th style="min-width:100px" class="text-center">작지번호</th>
									<th style="min-width:100px" class="text-center">생산 LotNo</th>
									<th style="min-width:25px" class="text-center">주야</th>
									<th style="min-width:50px" class="text-center">작지상태</th>
									<th style="min-width:40px" class="text-center">제품</th>
									<th style="min-width:40px" class="text-center">재질</th>
									<th style="min-width:110px"class="text-center">규격</th>
									<th style="min-width:55px" class="text-center">목표 수량</th>
									<th style="min-width:65px" class="text-center">생산팀 생산량</th>
									<th style="min-width:65px" class="text-center">달성률(%)</th>
									<th style="min-width:40px" class="text-center">생산자</th>
									<th style="min-width:50px" class="text-center">Film</th>
									<th style="min-width:60px" class="text-center">면취(압연)</th>
									<th style="min-width:85px" class="text-center">구분(연질,경질)</th>
									<!-- <th style="min-width:50px" class="text-center">작업조</th> -->
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="9" style="text-align: center">합계</td>
									<td colspan="" id="sumTargetCnt" style="text-align: right">0</td>
									<td colspan="" id="sumOutputCnt" style="text-align: right">0</td>
									<td colspan="" id="sumOutputPercent" style="text-align: right">0</td>
									<td colspan="4" style="text-align: center"></td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
		</div><!-- /.row -->
    </div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'tmsc0100';
	let currentHref = 'tmsc0100';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품검사 대기현황");

	//공통코드 처리 시작   	
	//var equipGroupCode=new Array(); // 설비그룹
    //<c:forEach items="${equipGroup}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	equipGroupCode.push(json);
    //</c:forEach>
    //
    //var qutyCdCode=new Array(); // 재질
    //<c:forEach items="${qutyCd}" var="info">
	//	var json=new Object();
	//	json.baseCd="${info.baseCd}";
	//	json.baseCdNm="${info.baseCdNm}";
	//	qutyCdCode.push(json);
    //</c:forEach>
    //공통코드 처리 종료
    
	var serverDateFrom =  "${serverDateFrom}";
	var serverDateTo =  "${serverDateTo}";
	var chooseDateFrom = serverDateFrom.replace(/-/g, '');;
    var chooseDateTo = serverDateTo.replace(/-/g, '');;
    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let standByInspectionWorkOrdList = $('#standByInspectionWorkOrdList').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        ajax: {
   	        url: '<c:url value="/qm/standByInspectionWorkOrdList"/>',
   	        type: 'GET',
   	        data: {
   	        	'menuAuth'	 		: 	menuAuth,
   	           	'chooseDateFrom'	:	function() { return chooseDateFrom; },
   	           	'chooseDateTo'		:	function() { return chooseDateTo; },
   	        },
   	    },
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['workOrdDate']).format('YYYY-MM-DD');
				}
			},
			{ data: 'equipNm' },		//설비명
			{ data: 'workOrdNo'},		//작지번호
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
        	{ data: 'subWorkStatusNm' },//작지 상태
        	{ data: 'goodsNm' },		//제품명
        	{ data: 'qutyNm' },			//재질
        	{ data: 'model' },			//규격
        	{ data: 'targetCnt' },		//목표수량
        	{ data: 'outputCnt' },		//생산팀 생산수량
        	{ data: 'outputCnt',	//달성률
	    		render: function(data, type, row, meta) {
	    			if (row['outputCnt'] == 0) {
		    			let html = "0 %";
						return html;
		    		} else {
		    			return ((parseFloat(data)/parseFloat(row['targetCnt']))*100).toFixed(2) + " %";
			    	}
	    		}
	    	},
	    	{ data: 'userNm'},			//작업자
        	{ data: 'filmNm'},			//Film
        	{ data: 'chamferYnNm'},		//면취
        	{ data: 'gubunNm'},			//구분
        	//{ data: 'workTeamNm'},		//작업조
        ],
        columnDefs: [
        	{ targets: [9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [9,10,11], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품검사 대기현황',
            },
			{
                extend: 'excel',
                title: '제품검사 대기현황',
				exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 3 || row == 4) {
								data = data.replace('<p style="color:red; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('<p style="color:blue; font-weight:bold; margin-bottom:0px;">', '');
								data = data.replace('</p>', '');
								return data;
							}
							if (row == 11) {
								return data.replace(" %", "");
							} else {
								return data;
							}
						}
					}
			    }
            },
            {
                extend: 'print',
                title: '제품검사 대기현황',
            }
        ],
        drawCallback: function () {
			//전역변수들
			let sumTargetCnt = $('#standByInspectionWorkOrdList').DataTable().column(9,{ page: 'all'} ).data().sum();
			let sumOutputCnt = $('#standByInspectionWorkOrdList').DataTable().column(10,{ page: 'all'} ).data().sum();
			let sumOutputPercent = 100 * sumOutputCnt / sumTargetCnt;
			
			$('#sumTargetCnt').html(addCommas(sumTargetCnt));
			$('#sumOutputCnt').html(addCommas(sumOutputCnt));
			$('#sumOutputPercent').html(sumOutputPercent.toFixed(2) + "%");
        },
    });

	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '&nbsp;<label class="input-label-sm">생산기간</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateFromCal,chooseDateFromCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '<button type="button" class="btn btn-primary" id="btnRetv" style="margin-left: 10px;">조회</button></div>';
	$('#standByInspectionWorkOrdList_length').html(html1);
	$('#chooseDateFromCal').val(serverDateFrom);
	$('#chooseDateToCal').val(serverDateTo);

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
		
		chooseDateFrom = $('#chooseDateFromCal').val().replace(/-/g, '');
		chooseDateTo = $('#chooseDateToCal').val().replace(/-/g, '');
		$('#standByInspectionWorkOrdList').DataTable().ajax.reload();
	});

  	$('#standByInspectionWorkOrdList tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#standByInspectionWorkOrdList').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
  	});
     
</script>

</body>
</html>
