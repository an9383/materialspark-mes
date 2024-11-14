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
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재 부적합현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div>
					<div class="row" style="margin-bottom: 5px;">

						&nbsp<label class="input-label-sm"  id="searchDateNm">...</label>					
						<div class="d-none" style="display: flex;flex-wrap: nowrap;" id="dateDiv_F1F2">
							<!--<div class="form-group input-sub m-0 row">
								<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom">
								<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromCalType1" type="button">
									<span class="oi oi-calendar"></span>
								</button>
							</div> -->
							<input class="form-control" type="month" id="chooseDateFrom" name="chooseDateFrom"/>
							&nbsp&nbsp&nbsp<label class="input-label-sm">~</label>
							<!--<div class="form-group input-sub m-0 row">
								 <input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo">
								<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromToType1" type="button">
									<span class="oi oi-calendar"></span>
								</button> 
							</div> -->
							<input class="form-control" type="month" id="chooseDateTo" name="chooseDateTo"/>
						</div>
						
						<div class="d-none" style="display: flex;flex-wrap: nowrap;" id="dateDiv_F3">
							<input class="form-control" type="month" id="chooseDateFrom_F3" name="chooseDateFrom_F3"/>
							&nbsp&nbsp&nbsp<label class="input-label-sm">~</label>
							<input class="form-control" type="month" id="chooseDateTo_F3" name="chooseDateTo_F3"/>
						</div>
						
						<select class="custom-select ml-2" id="selectMatrlCd"></select>
						<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>
						
						<label class="ml-2 d-none printSel" style="font-size:1rem;">프린터1</label>
						<input type="radio" class="ml-1 d-none printSel" name="printNo" value="1" checked="checked">
						<label class="ml-1 d-none printSel" style="font-size:1rem;">프린터2</label>
						<input type="radio" class="ml-1 d-none printSel" name="printNo" value="2">
						<button type="button" class="btn btn-primary ml-2 d-none" id="btnRePrint">바코드 인쇄</button>
						
						<div style="display: flex;align-items: flex-end;" id="changeDateDiv">
							<input type="checkbox" class="ml-3" style="width:20px; height:20px" id="changeDateCheck" name="changeDateCheck">
							<label class="input-label-sm ml-1" style="line-height: 20px;" for="changeDateCheck">검색 날짜 변경</label>
						</div>
						
						<button type="button" class="btn btn-primary ml-5 d-none" id="btnUnreceived">미승인</button>
						<button type="button" class="btn btn-primary ml-4 d-none" id="btnFaulty">불량</button>
						<button type="button" class="btn btn-primary ml-4 d-none" id="btnHold">보류</button>
						<button type="button" class="btn btn-warning ml-4 d-none" id="btnReturn">반품</button>
						<button type="button" class="btn btn-warning ml-4 d-none" id="btnRealReturn">실반품</button>
						<button type="button" class="btn btn-danger ml-4 d-none" id="btnDisuse">자체폐기</button>
						<button type="button" class="btn btn-warning ml-4 d-none" id="btnRealDisuse">실폐기</button>
						
						<!-- <label id="filterInsert">검색 : </label> -->
					</div>
				</div>
				<div class="card-header card-tab">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab4">불량현황</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab1">재사용</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">반품</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">폐기</a></li>
						<li class="nav-item"><a class="nav-link d-none" data-toggle="tab" id="tab5">폐기 반품</a></li>
					</ul>
				</div>
				<div id="tab1View" class="d-none">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyMatrlList" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width:10px" class="text-center">
										<input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10pxl; width:20px; height:20px;">
									</th>
									<th style="min-width:40px" class="text-center">가입고일</th>
									<th style="min-width:40px" class="text-center">비고</th>
									<th style="min-width:40px" class="text-center">승인상태</th>
									<th style="min-width:40px" class="text-center">자재상태</th>
									<th style="min-width:40px" class="text-center">자재코드</th>
									<th style="min-width:160px" class="text-center">자재명</th>
									<th style="min-width:130px" class="text-center">Barcode No</th>
									<th style="min-width:50px" class="text-center">공급업체</th>
									<th style="min-width:40px" class="text-center">입고일</th>
									<th style="min-width:40px" class="text-center">수입검사일</th>
									<th style="min-width:40px" class="text-center">부적합일</th>
									
									<th style="min-width:40px" class="text-center">재검일</th>
									
									<th style="min-width:40px" class="text-center">가입고량</th>
									<th style="min-width:40px" class="text-center" id="textRemainQty">반품량</th>								
									<th style="min-width:40px" class="text-center">불량유형</th>
									<th style="min-width:40px" class="text-center">불량비고</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="13" style="text-align:center">합계</td>
									<td id="sumPreInWhsQty" style="text-align:right">0</td>
									<td id="sumReturnQty" style="text-align:right">0</td>
									<td colspan="2"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<div id="tab4View">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyMatrlAllList" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width:40px" class="text-center">가입고일</th>
									<th style="min-width:40px" class="text-center">비고</th>
									<th style="min-width:40px" class="text-center">승인상태</th>
									<th style="min-width:40px" class="text-center">자재상태</th>
									<th style="min-width:40px" class="text-center">자재코드</th>
									<th style="min-width:160px" class="text-center">자재명</th>
									<th style="min-width:130px" class="text-center">Barcode No</th>
									<th style="min-width:50px" class="text-center">공급업체</th>
									<th style="min-width:40px" class="text-center">입고일</th>
									<th style="min-width:40px" class="text-center">수입검사일</th>
									<th style="min-width:40px" class="text-center">부적합일</th>
									
									<th style="min-width:40px" class="text-center">재검일</th>
									
									<th style="min-width:40px" class="text-center">가입고량</th>
									<th style="min-width:40px" class="text-center">반품량</th>								
									<th style="min-width:40px" class="text-center">불량유형</th>
									<th style="min-width:40px" class="text-center">불량비고</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="12" style="text-align:center">합계</td>
									<td id="sumPreInWhsAllQty" style="text-align:right">0</td>
									<td id="sumReturnAllQty" style="text-align:right">0</td>
									<td colspan="2"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->
<!-- 보류&반품&실반품&폐기 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="frrrdPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="frrrdPopUpLabel">불량 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<table id="frrrdPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="frrrdDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate" name="frrrdDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="frrrdDescLabel"></th>
							<td>
								<input type="text" id="frrrdDesc" name="frrrdDesc" style="max-width: 100%;" class="form-control" />
							</td>
						<tr>
						<th id="frrrdTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${matrlFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="frrrdType${item.baseCd}" style="zoom:1.8;"></div>	
								</div>
							</c:forEach>
							</td>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFaultySave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 보류&불량&반품&실반품&폐기 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc3080';
	let currentHref = 'iosc3080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 부적합현황");
    
	//공통코드 처리 시작
    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>

    var faultyMatrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlInOutWhsAdmList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		faultyMatrlCdList.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
    
    
    //배열 중복제거
	faultyMatrlCdList = [...new Set(faultyMatrlCdList.map(JSON.stringify))].map(JSON.parse);
    
    selectBoxAppend_NameAdd(faultyMatrlCdList, "selectMatrlCd", "", "1", "자재명");

    let factoryCode 		= "<%=factoryCode%>";
    var serverDateFrom		=  "${serverDateFrom}"; 
    var serverDateTo 		=  "${serverDateTo}";
    
	var inWhsDateFrom		= "";
	var inWhsDateTo			= "";
	let inWhsDateFrom_F3	= "";
	let inWhsDateTo_F3		= "";
	
	var tapTemp 	= 7;
	var frrrdType 	= '';
	var frrrdDesc 	= '';
	var approvalCd	= '';

	//공장 구분 짓기
	if( factoryCode == '001' || factoryCode == '002'){
		$('#searchDateNm').text("부적합일");
		
		$('#dateDiv_F1F2').removeClass('d-none');
		$('#dateDiv_F3').addClass('d-none');
		$('#changeDateDiv').addClass('d-none');
		
		$('#chooseDateFrom').val(serverDateTo.substring(0,7));
		$('#chooseDateTo').val(serverDateTo.substring(0,7)); 

		inWhsDateFrom		= serverDateTo.substring(0,7);
		inWhsDateTo			= serverDateTo.substring(0,7);
		
		$('#textRemainQty').text("실제중량");
		
		$('#btnRePrint').attr('style', '');
		$('.printSel').attr('style', '');
		
		$('#btnRealReturn').attr('style', 'display: none;');	//1,2공장은 실폐기 사용안함
		
	} else if( factoryCode == '003' ) {

		//체크되어있으면 부적합일 기준으로 조회
		if($("#changeDateCheck").prop("checked")) {

			$('#searchDateNm').text("부적합일");
			
			$('#dateDiv_F1F2').removeClass('d-none');
			$('#dateDiv_F3').addClass('d-none');

			$('#chooseDateFrom').val(serverDateTo.substring(0,7));
			$('#chooseDateTo').val(serverDateTo.substring(0,7)); 
			$('#chooseDateFrom_F3').val("");
			$('#chooseDateTo_F3').val("");

			inWhsDateFrom		= serverDateTo.substring(0,7);
			inWhsDateTo			= serverDateTo.substring(0,7);
			inWhsDateFrom_F3	= ""
			inWhsDateTo_F3		= ""
			
		} else {
			$("input[name=chk]").prop("checked",false);

			$('#searchDateNm').text("재검사일");
			
			$('#dateDiv_F1F2').addClass('d-none');
			$('#dateDiv_F3').removeClass('d-none');
			
			$('#chooseDateFrom').val("");
			$('#chooseDateTo').val(""); 
			$('#chooseDateFrom_F3').val(serverDateTo.substring(0,7));
			$('#chooseDateTo_F3').val(serverDateTo.substring(0,7));

			inWhsDateFrom		= "";
			inWhsDateTo			= "";
			inWhsDateFrom_F3	= serverDateTo.substring(0,7);
			inWhsDateTo_F3		= serverDateTo.substring(0,7);
		}
		
		$('#tab5').removeClass('d-none');
		$('#textRemainQty').text("반품량");
		$('#btnRePrint').attr('style', 'display:none');
		$('.printSel').attr('style', 'display:none');
		
// 		$('#changeDateDiv').addClass('d-none');
	} else {
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}
	

	//검색 날짜 변경 시_F3
	$('#changeDateCheck').on('click', function(){

		//체크되어있으면 부적합일 기준으로 조회
		if($("#changeDateCheck").prop("checked")) {

			$('#searchDateNm').text("부적합일");
			
			$('#dateDiv_F1F2').removeClass('d-none');
			$('#dateDiv_F3').addClass('d-none');
			
			$('#chooseDateFrom').val(inWhsDateFrom_F3);
			$('#chooseDateTo').val(inWhsDateTo_F3); 

			inWhsDateFrom		= inWhsDateFrom_F3;
			inWhsDateTo			= inWhsDateTo_F3;
			inWhsDateFrom_F3	= ""
			inWhsDateTo_F3		= ""
			
		} else {
			$("input[name=chk]").prop("checked",false);

			$('#searchDateNm').text("재검사일");
			
			$('#dateDiv_F1F2').addClass('d-none');
			$('#dateDiv_F3').removeClass('d-none');
			
			$('#chooseDateFrom_F3').val(inWhsDateFrom);
			$('#chooseDateTo_F3').val(inWhsDateTo);

			inWhsDateFrom		= "";
			inWhsDateTo			= "";
			inWhsDateFrom_F3	= inWhsDateFrom
			inWhsDateTo_F3		= inWhsDateTo
		}
		
		$('#btnRetv').trigger('click');
	});
	
	$('#tab1').click(function() {
		tapTemp = 4;
// 		$('#searchDateNm').text("부적합일");
		$("#checkAll").prop("checked", false);
		$('#btnUnreceived').addClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnRealReturn').addClass('d-none');
		
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').addClass('ml-5');
		$('#btnDisuse').addClass('d-none');
		$('#btnRealDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
		$('#tab4View').addClass('d-none');
		$('#tab1View').removeClass('d-none');
		
		$('#btnRePrint').removeClass('d-none');
		$('.printSel').removeClass('d-none');
		
	});
	
	$('#tab2').click(function() {
		tapTemp = 5;
// 		$('#searchDateNm').text("부적합일");
		$("#checkAll").prop("checked", false);
// 		$('#btnUnreceived').addClass('d-none');
		$('#btnUnreceived').removeClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnRealReturn').removeClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnRealDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
		$('#tab4View').addClass('d-none');
		$('#tab1View').removeClass('d-none');
		
		$('#btnRePrint').addClass('d-none');
		$('.printSel').addClass('d-none');
	});
	
	$('#tab3').click(function() {
		tapTemp = 6;
// 		$('#searchDateNm').text("부적합일");
		$("#checkAll").prop("checked", false);
// 		$('#btnUnreceived').addClass('d-none');
		$('#btnUnreceived').removeClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').addClass('ml-5');
		$('#btnRealReturn').addClass('d-none');
		$('#btnDisuse').removeClass('d-none');
		$('#btnRealDisuse').removeClass('d-none');
		$('#btnRetv').trigger('click');
		$('#tab4View').addClass('d-none');
		$('#tab1View').removeClass('d-none');
		
		$('#btnRePrint').addClass('d-none');
		$('.printSel').addClass('d-none');
	});

	$('#tab4').click(function() {
		tapTemp = 7;
// 		$('#searchDateNm').text("부적합일");
		$("#checkAll").prop("checked", false);
 		$('#btnUnreceived').addClass('d-none');
//		$('#btnUnreceived').removeClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').addClass('ml-5');
		$('#btnRealReturn').addClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnRealDisuse').addClass('d-none');
//		$('#btnDisuse').removeClass('d-none');
		$('#btnRetv').trigger('click');
		$('#tab1View').addClass('d-none');
		$('#tab4View').removeClass('d-none');
		$('#faultyMatrlAllList').DataTable().ajax.reload( function () {});
		
		$('#btnRePrint').addClass('d-none');
		$('.printSel').addClass('d-none');
	});
	
	$('#tab5').click(function() {
		tapTemp = 8;
		$('#searchDateNm').text("부적합일");
		$("#checkAll").prop("checked", false);
		
		$('#btnUnreceived').addClass('d-none');
		
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnRealReturn').removeClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnRealDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
		$('#tab4View').addClass('d-none');
		$('#tab1View').removeClass('d-none');
		
		$('#btnRePrint').addClass('d-none');
		$('.printSel').addClass('d-none');
	});

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyMatrlList = $('#faultyMatrlList').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
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
            url: '<c:url value="/qm/matrlFaultyTypeDataList_F3"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		:	menuAuth,
				'inWhsDateFrom'		:	function() { return inWhsDateFrom.replace(/-/g, '');	},
				'inWhsDateTo'		:	function() { return inWhsDateTo.replace(/-/g, '');		},
				'inWhsDateFrom_F3'	:	function() { return inWhsDateFrom_F3.replace(/-/g, '');	},
				'inWhsDateTo_F3'	:	function() { return inWhsDateTo_F3.replace(/-/g, '');	},
				'tapTemp'			:	function() { return tapTemp; },
				'matrlCd'			: 	function() { return $('#selectMatrlCd option:selected').val(); }
            },
        },
        //rowId: 'lotNo',
        columns: [
	    	{
	    		render: function(data, type, row, meta) {
					return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width:20px; height:20px;">';
	    		}
			},
            {
                data: 'preInWhsDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			{ data: 'inWhsDesc' },
			{ data: 'approvalNm' },
            { data: 'statusNm' },
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'barcodeNo' },
            { data: 'spplyDealCorpNm' },
            {
                data: 'inWhsDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            {
                data: 'inspctDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            { 
                data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            {
                data: 'retestDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'preInWhsQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }   
			},
// 			{ data: 'remainQty',
// 				render: function(data, type, row) {					
// 					return parseFloat(data).toFixed(2);
//                 }   
// 			},


			{ data: 'remainQty',
				render: function(data, type, row, meta) {   
					if (data == null) {
						return '<div style="display: flex;justify-content: center;"><input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:70px;" value="0" min="0" max="100"></div>';
			        } else{
				        if(row['statusCd'] == "P"){
				        	return '<td><span style="display: none;">'+data+'</span><div style="display: flex;justify-content: center;"><input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:70px;" value="' + data + '" min="0" max="' + row.preInWhsQty + '" disabled></div> </td>';
						} else {
							return '<td><span style="display: none;">'+data+'</span><div style="display: flex;justify-content: center;"><input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:70px;" value="' + data + '" min="0" max="' + row.preInWhsQty + '"></div> </td>';
						}
			        }
			    } 
			},
            {
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
            { data: 'frrrdDesc' },
        ],
        columnDefs: [
             	{ targets: [13,14], render: $.fn.dataTable.render.number( ',' )},
            	{ targets: [13], className: 'text-right' }, 
            	{ targets: [14], className: 'text-center' }, 
        ],
        //order: [
        //    [ 6, 'asc' ]
        //],
		drawCallback: function () {
			var sumPreInWhsQty	= $('#faultyMatrlList').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sumReturnQty	= $('#faultyMatrlList').DataTable().column(14,{ page: 'all'} ).data().sum();
			$('#sumPreInWhsQty').text(addCommas(sumPreInWhsQty.toFixed(2)));
			$('#sumReturnQty').text(addCommas(sumReturnQty.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '자재 부적합현황',
            },
            {
                extend: 'excel',
                title: '자재 부적합현황',
                exportOptions: {
                    columns: ':visible'
                },
            },
            {
                extend: 'print',
                title: '자재 부적합현황',
            }
        ],
    });

	/* var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm"  id="searchDateNm">가입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromCalType1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp&nbsp&nbsp<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromToType1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';	
		html1 += '<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>'
		html1 += '<button type="button" class="btn btn-primary ml-5 d-none" id="btnUnreceived">미승인</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 d-none" id="btnFaulty">불량</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 d-none" id="btnHold">보류</button>';
		html1 += '<button type="button" class="btn btn-warning ml-4 d-none" id="btnReturn">반품</button>';
		html1 += '<button type="button" class="btn btn-warning ml-4 d-none" id="btnRealReturn">실반품</button>';
		html1 += '<button type="button" class="btn btn-danger ml-4 d-none" id="btnDisuse">자체폐기</button>';
		html1 += '</div>';
    
	$('#faultyMatrlList_length').html(html1); */
	
	//$('#chooseDateFrom').val(serverDateFrom);
	//$('#chooseDateTo').val(serverDateTo);
	
   /*  // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	 */

	//숨길 컬럼_재검일자
	if( factoryCode == '001' || factoryCode == '002') {
		faultyMatrlList.column( 12 ).visible( false );
	}
    
    // 불량현황 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyMatrlAllList = $('#faultyMatrlAllList').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
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
            url: '<c:url value="/qm/matrlFaultyTypeDataList_F3"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		:	menuAuth,
				'inWhsDateFrom'		:	function() { return inWhsDateFrom.replace(/-/g, '');	},
				'inWhsDateTo'		:	function() { return inWhsDateTo.replace(/-/g, '');		},
				'inWhsDateFrom_F3'	:	function() { return inWhsDateFrom_F3.replace(/-/g, '');	},
				'inWhsDateTo_F3'	:	function() { return inWhsDateTo_F3.replace(/-/g, '');	},
				'tapTemp'			:	function() { return tapTemp; },
				'matrlCd'			: 	function() { return $('#selectMatrlCd option:selected').val(); }
            },
        },
        //rowId: 'lotNo',
        columns: [
            {
                data: 'preInWhsDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
			{ data: 'inWhsDesc' },
			{ data: 'approvalNm' },
            { data: 'statusNm' },
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'barcodeNo' },
            { data: 'spplyDealCorpNm' },
            {
                data: 'inWhsDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            {
                data: 'inspctDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            { 
                data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },

            {
                data: 'retestDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            
            
            { data: 'preInWhsQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }   
			},
			{ data: 'remainQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }   
			},
            {
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
            { data: 'frrrdDesc' },
        ],
        columnDefs: [
             	{ targets: [12,13], render: $.fn.dataTable.render.number( ',' )},
            	{ targets: [12,13], className: 'text-right' }, 
        ],
        //order: [
        //    [ 6, 'asc' ]
        //],
		drawCallback: function () {
			var sumPreInWhsAllQty	= $('#faultyMatrlAllList').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumReturnAllQty		= $('#faultyMatrlAllList').DataTable().column(13,{ page: 'all'} ).data().sum();
			$('#sumPreInWhsAllQty').text(addCommas(sumPreInWhsAllQty.toFixed(2)));
			$('#sumReturnAllQty').text(addCommas(sumReturnAllQty.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '자재 부적합현황',
            },
            {
                extend: 'excel',
                title: '자재 부적합현황',
                exportOptions: {
                    columns: ':visible'
                },
            },
            {
                extend: 'print',
                title: '자재 부적합현황',
            }
        ],
    });
	/* $('#faultyMatrlAllList_filter').find('input[type=search]').eq(0).attr('id', 'pagefilter');
	$("#pagefilter").insertAfter("#filterInsert");
	$('#faultyMatrlAllList_filter').find('label').eq(0).remove();
	$("#pagefilter").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pagefilter").addClass('custom-select ml-2');
	$('#pagefilter').attr('style', 'margin-top: 12px; width: 18vh;'); */
	//$('#faultyMatrlAllList_length').html(html1);

	//숨길 컬럼_재검일자
	if( factoryCode == '001' || factoryCode == '002') {
		faultyMatrlAllList.column( 11 ).visible( false );
	}
	
    $('#btnRetv').on('click', function() {

    	let dateFrom;
    	let dateTo;

    	if( factoryCode == '001' || factoryCode == '002'){
    		dateFrom 	= new Date($('#chooseDateFrom').val());
    		dateTo 		= new Date($('#chooseDateTo').val());  
    	} else if( factoryCode == '003' ) {

    		if($("#changeDateCheck").prop("checked")) {
	    		dateFrom 	= new Date($('#chooseDateFrom').val());
        		dateTo 		= new Date($('#chooseDateTo').val());  
    		} else {
    			dateFrom 	= new Date($('#chooseDateFrom_F3').val());
	    		dateTo 		= new Date($('#chooseDateTo_F3').val());
        	}
    		  
    	} else {
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
        
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFrom').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFrom').focus();
			return false;
		}
		if (dateDiff > 63) {
			toastr.warning("검색 가능 기간은 최대 세달입니다!");
			$('#chooseDateFrom').focus();
			return false;
		}

    	if( factoryCode == '001' || factoryCode == '002'){
    		inWhsDateFrom		=  $('#chooseDateFrom').val();
    		inWhsDateTo			=  $('#chooseDateTo').val();
    	} else if( factoryCode == '003' ) {
    		if($("#changeDateCheck").prop("checked")) {
    			inWhsDateFrom		=  $('#chooseDateFrom').val();
        		inWhsDateTo			=  $('#chooseDateTo').val();
    		} else {
    			inWhsDateFrom_F3	=  $('#chooseDateFrom_F3').val();
        		inWhsDateTo_F3		=  $('#chooseDateTo_F3').val();
        	}
    	} else {
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    	
		/*//자재명 SelectBox 담아주기
		$.ajax({
            url: '/io/matrlCdInOutList',
            type: 'GET',
            data: {
           		'menuAuth'	 	: 		menuAuth,
	           	'inWhsDateFrom'	: 		function() { return $('#inWhsDateFrom').val().replace(/-/g, ''); },
	           	'inWhsDateTo'	: 		function() { return $('#inWhsDateTo').val().replace(/-/g, ''); },
	           	'approvalCd'	: 		function() { return approvalCd; },
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {	
                    $('#selectMatrlCd').empty();
                    matrlCdList = new Array();	//matrlCdList
                    for(var i=0; i<data.length; i++){
                    	var json=new Object();
                    	json.baseCd=data[i].matrlCd;
                    	json.baseCdNm=data[i].matrlNm;
                    	matrlCdList.push(json);
                    }
                    selectBoxAppend_NameAdd(matrlCdList, "selectMatrlCd", "", "1", "자재명");
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	inWhsDateFromCal	=  $('#inWhsDateFrom').val();
        		inWhsDateToCal		=  $('#inWhsDateTo').val();   
        		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
            }
        });*/

        //reload 후 selectBoxUpdate
		if( tapTemp != 7 ){
			$('#faultyMatrlList').DataTable().ajax.reload( function () {});
		}

		if(tapTemp == 7){
			$('#faultyMatrlAllList').DataTable().ajax.reload( function () {});
		}

		$.ajax({
            url: '/qm/matrlFaultyTypeDataList_F3',
            type: 'GET',
            data: {
            	'menuAuth'	 		:	menuAuth,
            	'inWhsDateFrom'		:	function() { return inWhsDateFrom.replace(/-/g, '');	},
				'inWhsDateTo'		:	function() { return inWhsDateTo.replace(/-/g, '');		},
				'inWhsDateFrom_F3'	:	function() { return inWhsDateFrom_F3.replace(/-/g, '');	},
				'inWhsDateTo_F3'	:	function() { return inWhsDateTo_F3.replace(/-/g, '');	},
				'tapTemp'			:	function() { return tapTemp; },
            },
            success: function (res) {
				let data = res.data;
                if (res.result == 'ok') {

                	var selectMatrlCdCopy = $('#selectMatrlCd option:selected').val();
                	$('#selectMatrlCd').empty();
	   				faultyMatrlCdList = new Array();	//matrlCdList
	   				
	   		        for(var i=0;  i<data.length; i++){ 
	   		         	var json = new Object();
	   		         	json.baseCd		= data[i].matrlCd;
	   		         	json.baseCdNm	= data[i].matrlNm;
	   		         	faultyMatrlCdList.push(json);
	   		         }
	   		         
	   		         faultyMatrlCdList = [...new Set(faultyMatrlCdList.map(JSON.stringify))].map(JSON.parse);
	   		         selectBoxAppend_NameAdd(faultyMatrlCdList, "selectMatrlCd", selectMatrlCdCopy, "1", "자재명");
	                
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){}
        });
        
    });	

    $('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}        
    });    

	//미승인
	$('#btnUnreceived').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("미승인할 자재를 선택해주세요!");
    		return false;
        }
    	frrrdDate = '';
    	frrrdType = '';
		frrrdDesc = '';
		updateMtrlInOutWhsInspectQty("002");
		updateInspectCd("");
	});

    //불량
    $('#btnFaulty').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("불량 처리할 자재를 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("자재 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		approvalCd = '003';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDateTo);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('불량 처리');
		$('#frrrdDateLabel').text('불량일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('불량유형');

        //선택한 자재 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFrrrdType = faultyMatrlList.row(rowCount).data().frrrdType;
    	let checkFrrrdDesc = faultyMatrlList.row(rowCount).data().frrrdDesc;
    	$('#frrrdDesc').val(checkFrrrdDesc);
    	if (checkFrrrdType != null && checkFrrrdType != '') {
	    	for (let i=0; i<matrlFaultyType.length; i++) {
	    		if (checkFrrrdType.substring(i,i+1) == '1') {
	        		//console.log(checkFrrrdType.substring(i,i+1));
	    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}
    	
		$('#frrrdPopUpModal').modal('show');
    });

    //보류
    $('#btnHold').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("보류 처리할 자재를 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("자재 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		approvalCd = '004';
		//선택해제
    	for (let i=0; i<matrlFaultyType.length; i++) {
    		$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
        }
    	
    	$('#frrrdDate').val(serverDateTo);
    	$('#frrrdDesc').val('');
        $('#frrrdPopUpLabel').text('보류 처리');
        $('#frrrdDateLabel').text('보류일');
        $('#frrrdDescLabel').text('비고');
        $('#frrrdTypeLabel').text('보류유형');

        //선택한 자재 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFrrrdType = faultyMatrlList.row(rowCount).data().frrrdType;
    	let checkFrrrdDesc = faultyMatrlList.row(rowCount).data().frrrdDesc;
    	$('#frrrdDesc').val(checkFrrrdDesc);
    	if (checkFrrrdType != null && checkFrrrdType != '') {
	    	for (let i=0; i<matrlFaultyType.length; i++) {
	    		if (checkFrrrdType.substring(i,i+1) == '1') {
	        		//console.log(checkFrrrdType.substring(i,i+1));
	    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}
        
        $('#frrrdPopUpModal').modal('show');
    });
    
    //반품
    $('#btnReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("반품 처리할 자재를 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("자재 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		approvalCd = '005';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDateTo);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('반품 처리');
		$('#frrrdDateLabel').text('반품일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('반품유형');

        //선택한 자재 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFrrrdType = faultyMatrlList.row(rowCount).data().frrrdType;
    	let checkFrrrdDesc = faultyMatrlList.row(rowCount).data().frrrdDesc;
    	$('#frrrdDesc').val(checkFrrrdDesc);
    	if (checkFrrrdType != null && checkFrrrdType != '') {
	    	for (let i=0; i<matrlFaultyType.length; i++) {
	    		if (checkFrrrdType.substring(i,i+1) == '1') {
	        		//console.log(checkFrrrdType.substring(i,i+1));
	    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}
    	
		$('#frrrdPopUpModal').modal('show');
    });

	//실반품
	$('#btnRealReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("실반품 처리할 자재를 선택해주세요!");
			return false;
		}
		
		
		//1,2공장 처리
		if( factoryCode != "003" ) {
			
			if ($('input[name=chk]:checked').length > 1) {
				toastr.warning("자재 상태변경은 한건씩만 가능합니다!");
				return false;
			}
			
			approvalCd = '006';
			//선택해제
			for (let i=0; i<matrlFaultyType.length; i++) {
				$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
			}
			$('#frrrdDate').val(serverDateTo);
			$('#frrrdDesc').val('');
			$('#frrrdPopUpLabel').text('실반품 처리');
			$('#frrrdDateLabel').text('실반품일');
			$('#frrrdDescLabel').text('비고');
			$('#frrrdTypeLabel').text('실반품유형');

	        //선택한 자재 불량유형, 비고 자동세팅
	        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
	    	let checkFrrrdType = faultyMatrlList.row(rowCount).data().frrrdType;
	    	let checkFrrrdDesc = faultyMatrlList.row(rowCount).data().frrrdDesc;
	    	$('#frrrdDesc').val(checkFrrrdDesc);
	    	if (checkFrrrdType != null && checkFrrrdType != '') {
		    	for (let i=0; i<matrlFaultyType.length; i++) {
		    		if (checkFrrrdType.substring(i,i+1) == '1') {
		        		//console.log(checkFrrrdType.substring(i,i+1));
		    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
		    		}
		        }
	    	}
	    	
			$('#frrrdPopUpModal').modal('show');			
		} else {
			approvalCd = '006';
			
			//선택해제
			for (let i=0; i<matrlFaultyType.length; i++) {
				$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
			}
			
			frrrdType = "";
			//frrrdDate = serverDateTo;
			frrrdDate = "";
			frrrdDesc = "";
			
			updateMtrlInOutWhsInspectQty("006");
		}
    });

	//폐기
	$('#btnDisuse').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("폐기 처리할 자재를 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("자재 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		approvalCd = '007';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDateTo);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('폐기 처리');
		$('#frrrdDateLabel').text('폐기일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('폐기유형');

        //선택한 자재 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFrrrdType = faultyMatrlList.row(rowCount).data().frrrdType;
    	let checkFrrrdDesc = faultyMatrlList.row(rowCount).data().frrrdDesc;
    	$('#frrrdDesc').val(checkFrrrdDesc);
    	if (checkFrrrdType != null && checkFrrrdType != '') {
	    	for (let i=0; i<matrlFaultyType.length; i++) {
	    		if (checkFrrrdType.substring(i,i+1) == '1') {
	        		//console.log(checkFrrrdType.substring(i,i+1));
	    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}
    	
		$('#frrrdPopUpModal').modal('show');
    });


	//불량&보류&반품등록 저장 클릭 시
	//불량유형 선택항목 1 미선택 0
	$('#btnFaultySave').on('click', function() {
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';
		if (approvalCd == '001') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!")
			return false;
		} else if (approvalCd == '002') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!")
			return false;
			
		//불량
		} else if (approvalCd == '003') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("003");
		
		//보류
		} else if (approvalCd == '004') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("004");

		//반품
		} else if (approvalCd == '005') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("005");
		
		//실반품
		} else if (approvalCd == '006') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("006");
			
		//폐기
		} else if (approvalCd == '007') {
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			for (let i=0; i<matrlFaultyType.length; i++) {
				if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
					frrrdType += '1';
				} else {
					frrrdType += '0';
				}
			}
			updateMtrlInOutWhsInspectQty("007");
		}
	});
	
	//실제폐기 버튼 클릭 했을 때
	$('#btnRealDisuse').on('click', function() {
		
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("실폐기 처리할 자재를 선택해주세요!");
			return false;
		}
		
		approvalCd = '011';
		
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		
		frrrdType = "";
		//frrrdDate = serverDateTo;
		frrrdDate = "";
		frrrdDesc = "";
		
		updateMtrlInOutWhsInspectQty("011");
	});
	
	
	
	function updateMtrlInOutWhsInspectQty(approvalCd){
		$('#my-spinner').show();
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag = false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			var rowData = new Object();
			var barcode = td.eq(7).text();
			
			rowData.menuAuth				= menuAuth;
			rowData.barcode					= barcode;
			rowData.approvalCd				= approvalCd;
			rowData.frrrdDate				= frrrdDate;	//불량&보류&반품 처리일
			rowData.frrrdType				= frrrdType;	//불량&보류&반품 유형
			rowData.frrrdDesc				= frrrdDesc;	//불량&보류&반품 비고
			rowData.fautlyByProductionTeam	= 'N';			//생산팀 불량 구분자
			
			dataArray.push(rowData);
			checkboxCnt += 1;
		});

		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010") {
			url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_iosc0080_F3"/>';
		} else{ //단순 인쇄시 006
			//url = '<c:url value="/qm/matrlPrint"/>';
			//temp = approvalCd;
		}
		if(!errorFlag && checkboxCnt > 0) {
	        $.ajax({
	            url: url,
	            type: 'POST',
	            dataType: 'json',
	            data : JSON.stringify(dataArray),
	            contentType : "application/json; charset=UTF-8",
	            //beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	            //},
	            success: function (res) {
	                //let data = res.data;
	                if (res.result == 'ok') {
	                	toastr.success("처리되었습니다.");
	            		$('#faultyMatrlList').DataTable().ajax.reload( function () {});
	            		$("#checkAll").prop("checked", false);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		} else if (approvalCd == "010"){
			toastr.warning("인쇄할 바코드를 선택해주세요!");
			$('#my-spinner').hide();
		} else {
			toastr.warning("미승인 처리할 자재를 선택해 주세요!");
			$('#my-spinner').hide();
		}
    }

	$('#faultyMatrlList tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#faultyMatrlList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	

	//합격 여부 업데이트
	function updateInspectCd(inspectCd) {
    	var dataArray = new Array();

   		$.each($('#faultyMatrlList tbody tr'),function(idx, itm){
	 		var rowData = new Object();
			if($(this).find('td').eq(0).find('input[name=chk]').is(":checked")){
				
				rowData.inspectCd 		= inspectCd;
	   			rowData.inWhsGroupSeq	= faultyMatrlList.row(this).data().inWhsGroupSeq;
	   			rowData.lotNo 			= faultyMatrlList.row(this).data().lotNo;

	   			dataArray.push(rowData);
			}
		});

        $.ajax({
            url: '<c:url value="/qm/inspectPassUpdate"/>',
            type: 'POST',
            dataType: 'json',
            data : JSON.stringify(dataArray),
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                    // 보기
                    $('#faultyMatrlList').DataTable().ajax.reload();
//                     if(approvalCd ==''){
//                 		toastr.success("처리 되었습니다.");
//                     } 
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function() {}
        }); 
	}

	$('#selectMatrlCd').on('change', function(){
		if( tapTemp != 7 ){
			$('#faultyMatrlList').DataTable().ajax.reload( function () {});
		}

		if(tapTemp == 7){
			$('#faultyMatrlAllList').DataTable().ajax.reload( function () {});
		}
	});


	$(document).on('keypress','input[name=remainQty]',function (e) {
		//엔터키
    	if (e.which == 13){
			//toastr.warning($(this).val());
			$('#my-spinner').show();
			var remainQty = $(this).val();
			var barcodeNo = $(this).closest('tr').find('td').eq(7).html();
			//toastr.warning(barcodeNo);
		 	$.ajax({
				url: '<c:url value="/io/remainQtyUpdate"/>',
				type: 'POST',
				data: {
					'menuAuth'		: 	menuAuth,
					'barcodeNo'		: 	function() { return barcodeNo; },
					'remainQty'		: 	function() { return remainQty; },
				},
				success: function (res) {
					let result = res.result;
					if (res.result == 'ok') {
						toastr.success("잔량이 변경되었습니다.");
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				 },
				complete:function(){
					dataArray = "";
		       		$('#faultyMatrlList').DataTable().ajax.reload(function(){});
					$('#my-spinner').hide();
				 }
			}); 
    	}
    });
	
	
	let dataArray = "";
	
    //자재 인쇄
    $('#btnRePrint').on('click', function() {
    	matrlLotNo();
    	if ( dataArray == "" ){
    		toastr.warning("인쇄할 자재를 선택해 주세요.");
    		return false;
    	}

    	var url = '';
		if (factoryCode == "001") {
			url = '<c:url value="/qm/matrlPrint_iosc0030"/>';
		} else if (factoryCode == "002" || factoryCode == "003") {
			url = '<c:url value="/qm/matrlPrint_iosc0030_F3"/>';
		} else {
			toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
			return false;
		}
		
    	$('#my-spinner').show();
    	
        $.ajax({
            url: url,
            type: 'POST',
            data: {
            	'menuAuth'		: 	menuAuth,
            	'slashLotNo'	: 	function() { return dataArray; },
            },
   	        success: function (res) {
   	            let result = res.result;
   	            if (res.result == 'ok') {
	   	     		if (factoryCode == "001") {
	   	            	toastr.success("재발행 되었습니다.");
		   	 		} else if (factoryCode == "002" || factoryCode == "003") {
	                	labelPrint(res.printList);
		   	 		} else {
		   	 			toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
		   	 		}
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
   	        },
            complete:function() {
            	dataArray = "";
            	$('#my-spinner').hide();
             }
        });
    });
    
    function matrlLotNo() {
		dataArray = "";
		var checkbox = $("input[name=chk]:checked");
		checkbox.each(function(i) {
			var rowCount = $(this).attr('id').split('-');
			lotNo = faultyMatrlList.row(rowCount[1]).data().lotNo;
			dataArray += "/" + lotNo;
		});

		//console.log(dataArray);
	}
    

    let printNo = "1";
    let printCnt = 1;
    let printLalCnt = 1;
    
  	//Do printing...
	function labelPrint(printList) {
		printLalCnt = printList.length;		//몇 장 출력 하는지
		printCnt	= printLalCnt;
		printNo 	= $('input[name="printNo"]:checked').val();
		
		// 0 제품이름 - 1 생산전표번호 - 2 생산전표수량
		sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
			printCnt 	: printCnt,
            printLalCnt : printLalCnt,
            data 		: printList,
            paperSize 	: "materialLabel",
            printOrder 	: 1,
            company 	: "MTP2",
            printType 	: "C",
            printNo 	: printNo,
            reseverd6 	: "",
            reseverd7 	: ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send)
	}
    
    /*
    let labelArray = new Array();
	var paperSize = null;
	var printCnt = null;
	var printOrder = null;
	var printCnt = 1;
	var printVer = "";
	var printNo = "1";
	var strPrintText = [""];
	
	//Do printing...
	function labelPrint(printList) {	
		// 0 제품코드 - 1 lotNo - 2 바코드 - 3 제품사양 - 4 중량 - 5 체크1(출력) - 6 딜레이시간
	    sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
				printCnt : printList.length,
				printLalCnt : 0,
				data : printList,
				paperSize : "100_20",
				printOrder : 0,
				company : "SLD",
				reseverd4 : "",
				reseverd5 : "",
				reseverd6 : "",
				reseverd7 : ""
		};
	
		
		var send = JSON.stringify(obj);
		
// 		console.log(send);
	    
		sendMessage(send);
	
		printCnt = 1;
		labelArray = [];
		printVer = "";
		printNo = "1";
		paperSize = "";
// 		console.log('라벨인쇄');
	}
	
	*/
	
	if (factoryCode == '002' || factoryCode == '003') {
		//웹 서버를 접속한다.
		var webSocket = new WebSocket("ws://localhost:8181");
		// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
		var messageTextArea = document.getElementById("installedPrinterName");
	}
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		if (factoryCode == '002' || factoryCode == '003') {
			toastr.success('인쇄 서버에 연결되었습니다.')
			$('#wsStateView').text('연결됨');
			$('#wsStateView').css('color','#19FF00');
		}
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		if (factoryCode == '002' || factoryCode == '003') {
			toastr.error('인쇄 서버가 종료되었습니다.')
			$('#wsStateView').text('연결끊김');
			$('#wsStateView').css('color','#FF0004');
		}
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		if (factoryCode == '002' || factoryCode == '003') {
			toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
		}
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		if (factoryCode == '002' || factoryCode == '003') {
			if(message.data == "이 문자열이 보이면 성공!") {
				toastr.success("라벨이 발행되었습니다.");
			} else {
				toastr.warning("오류가 발생하였습니다.");
			}
		}
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(webSocket.readyState == 1) {
			webSocket.send(cmd);
		} else {
			toastr.error('인쇄 서버와의 연결을 확인해주세요.');
			//webSocket = new WebSocket("ws://localhost:9998");
		}
	}
</script>

</body>
</html>
