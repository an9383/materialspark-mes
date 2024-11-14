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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품출고현황</li>
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
					<table id="productOutputTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th style="minwidth:60px;" class="text-center">마감일</th>
								<th style="minwidth:60px;" class="text-center">납기일</th>
<!-- 								<th style="minwidth:50px;" class="text-center">승인구분</th> -->
								<th style="minwidth:50px;" class="text-center">오더구분</th>
								<th style="minwidth:60px;" class="text-center">거래처</th>
								<th style="minwidth:80px;" class="text-center">모델 No</th>
								<th style="minwidth:80px;" class="text-center">PO Number</th>
								<th style="minwidth:80px;" class="text-center">파레트번호</th>
								<th style="minwidth:80px;" class="text-center">제품</th>
								<th style="minwidth:50px;" class="text-center">재질</th>
								<th style="minwidth:100px;"class="text-center">규격</th>
								<th style="minwidth:25px;" class="text-center">두께</th>
								<th style="minwidth:25px;" class="text-center">폭</th>
								<th style="minwidth:25px;" class="text-center">길이</th>
								<th style="minwidth:25px;" class="text-center">피치</th>
								<th style="minwidth:50px;" class="text-center">화폐단위</th>
								<th style="minwidth:40px;" class="text-center">출고량</th>					
								<th style="minwidth:50px;" class="text-center">단가</th>
								<th style="minwidth:60px;" class="text-center">금액</th>
								<th style="minwidth:60px;" class="text-center">작업일</th>
								<!-- <th style="minwidth:50px;" class="text-center">출고처</th> -->
								<th style="minwidth:50px;" class="text-center">비고</th>
								<th style="minwidth:50px;" class="text-center">등록번호</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="15" class="text-center">합계</td>
								<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
								<td colspan=""></td>
								<td colspan="" id="sumTotalPrice" style="text-align: right">0</td>
								<td colspan="3"></td>
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

	let menuAuth = 'iosc0070';
	let currentHref = 'iosc0070';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품출고현황");
    let viewIdx;
    let sideView = 'add';
	var outputHistDateFrom = "${serverDateFrom}";   
	var outputHistDateTo = "${serverDate}";
	var approvalCd = "";
	var poGubunCd =  ""; 

	//공통코드 시작
    var ordGubun=new Array();
    <c:forEach items="${ordGubun}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubun.push(json);
    </c:forEach>

    var approvalCdCode=new Array();
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCdCode.push(json);
    </c:forEach>

	var dateGubun = "001";
  	//공통코드 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let productOutputTable = $('#productOutputTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        //scrollX : false,
        pageLength: 20,
       ajax: {
            url: '<c:url value="/io/productOutpoutDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'outputHistDateFrom': function() { return outputHistDateFrom.replace(/-/g, ''); },
	           	'outputHistDateTo': function() { return outputHistDateTo.replace(/-/g, ''); },
// 	           	'approvalCd': function() { return approvalCd; },
	           	'poGubunCd': function() { return poGubunCd; },
	        	'dateGubun': function() {return dateGubun;}
            },
        },
        rowId: 'poNo',
        columns: [
			{ data: 'deliveryDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },
            { data: 'deadLine',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },
//             { data: 'approvalNm' },
            { data: 'poGubunNm' },
            { data: 'dealCorpNm' },
            { data: 'poCode'},
            { data: 'poNo' },
            { data: 'poGroup' },
            { data: 'goodsNm' },
            { data: 'qutyNm' },
            { data: 'model' },
            { data: 'thickness' },
            { data: 'depth' }, 
            { data: 'length' }, 
            { data: 'pitch' }, 
            { data: 'moneyUnitNm' },  
            { data: 'outputQty' },             
            { data: 'costUnit',
	    		render: function(data, type, row) {
					return parseFloat(data);
	    		}
            },
            { data: 'outputPrice' },
            { data: 'outputHistDate',
	    		render: function(data, type, row) {
					return moment(data).format('YYYY-MM-DD') ;
	    		}
            },
			//{ data: 'deliveryDealCorpNm' },
            { data: 'poDesc' },
            { data: 'poSeq' },
        ],
        columnDefs: [
        	{ targets: [9,10,11,12,14,15,16,17] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [9,10,11,12,14,15,16,17], className: 'text-right' }, 
        	
        ],
        order: [
            [ 0, 'desc' ],
            [ 7, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '출고현황',
            },
            {
                extend: 'excel',
                title: '출고현황',
            },
            {
                extend: 'print',
                title: '출고현황',
            },
        ],
        rowCallback: function (row, data) {
			if (data.disposeGubun > 0) {
				$(row).addClass('whiteRed');
			}
		},
		drawCallback: function () {
			//전역변수들
			var sumOutputQty = $('#productOutputTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sumTotalPrice = $('#productOutputTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumTotalPrice').text(addCommas(sumTotalPrice.toFixed(0)));
        }
    });

	var html1 = '<div class="row">';
	html1 += '&nbsp;<select class="custom-select" id="dateGubun"> <option value="001">마감일</option> <option value="002">작업일</option> </select> &nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate1" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate1,chooseDate1,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate2"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate2,chooseDate2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm">기간선택</button>';
// 	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">승인구분</label><select  class="custom-select" id="approvalCd"></select>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label><select  class="custom-select" id="poGubunCd" ></select> &nbsp;';
	html1 += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	html1 += '</div>';

	$('#productOutputTable_length').html(html1);
	$('#chooseDate1').val(outputHistDateFrom);
	$('#chooseDate2').val(outputHistDateTo);
	selectBoxAppend(approvalCdCode, "approvalCd", "", "1");
	selectBoxAppend(ordGubun, "poGubunCd", "", "1");

    // 보기
    $('#productOutputTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#productOutputTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDate1').val());
		let dateTo = new Date($('#chooseDate2').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff > 365) {
			toastr.warning("검색 가능 기간은 최대 1년입니다!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		
    	outputHistDateFrom =  $('#chooseDate1').val();
    	outputHistDateTo=  $('#chooseDate2').val();
    	approvalCd =  $('#approvalCd').val();
		poGubunCd =  $('#poGubunCd').val();
		dateGubun = $('#dateGubun option:selected').val();
		$('#productOutputTable').DataTable().ajax.reload( function () {});
		if($('#dateGubun option:selected').val() == "002") {
			var table = $('#productOutputTable').DataTable();
			table.order( [ 16, 'desc' ], [ 5, 'asc' ] ).draw();
			dateGubun = "002";
		} else {
			var table = $('#productOutputTable').DataTable();
			dateGubun = "001";
			table.order( [ 0, 'desc' ], [ 5, 'asc' ] ) .draw();
		}
    });

	$('#dateGubun').change(function() {
		dateGubun = $('#dateGubun option:selected').val();
		$('#productOutputTable').DataTable().ajax.reload( function () {});
		if($('#dateGubun option:selected').val() == "002") {
			var table = $('#productOutputTable').DataTable();
			table.order( [ 16, 'desc' ], [ 5, 'asc' ] ).draw();
			dateGubun = "002";
		} else {
			var table = $('#productOutputTable').DataTable();
			dateGubun = "001";
			table .order( [ 0, 'desc' ], [ 5, 'asc' ] ) .draw();
		}
    });

	$('#approvalCd').change(function() {
		approvalCd =  $('#approvalCd').val();
		$('#productOutputTable').DataTable().ajax.reload( function () {});
    });
	
	$('#poGubunCd').change(function() {
		poGubunCd =  $('#poGubunCd').val();
		$('#productOutputTable').DataTable().ajax.reload( function () {});
    });

	//기간조회~
	$('#btnTerm').on('click',function() {
		datePickFun();
	});

	
	$('#datePick').on('click',function() {
		var id ='';
		
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				id = $(this).attr('id');
			}
		});			
		datePick(id, 'chooseDate1', 'chooseDate2',  $('#select-year').val());
	});
    
</script>

</body>
</html>

