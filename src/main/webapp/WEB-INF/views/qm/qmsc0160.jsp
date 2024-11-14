<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@ include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">

	<!-- 삭제여부 모달2 -->
	<div class="modal fade" id="deleteModal2" tabindex="-1" role="dialog" aria-labelledby="deleteModal2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
	        		<h5 class="modal-title">성적서관리 삭제 확인</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			        	<span aria-hidden="true">&times;</span>
			        </button>
				</div>
	      		<div class="modal-body">
	      			<h6>삭제하시겠습니까?</h6>
	      			<p></p>
	      			<label>*파일이 남아 있으면 삭제되지 않습니다.</label>
	      		</div>
      			<div class="modal-footer">
		      		<button type="button" class="btn btn-danger" style="width: 13%;" id="btnDeleteConfirmY" data-dismiss="modal">삭제</button>
		      		<button type="button" class="btn btn-secondary" style="width: 13%;" id="btnDeleteConfirmN" data-dismiss="modal">아니요</button>
		     	</div>
			</div>
		</div>
	</div>

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
			<div class="left-list left-sidebar" id="left-list" style="width: 54%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search openbtn" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					
					<!-- 날짜 조회 바 -->
					<div class="row mb-3">
						&nbsp;&nbsp;<label class="input-label-sm">일자</label>
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width:97px;" type="text" id="preInWhsDateFrom" name="preInWhsDateFrom" disabled/>
							<button onclick="fnPopUpCalendar(preInWhsDateFrom,preInWhsDateFrom,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width:97px;" type="text" id="preInWhsDateTo" name="preInWhsDateTo" disabled/>
								<button onclick="fnPopUpCalendar(preInWhsDateTo,preInWhsDateTo,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">
									<span class="oi oi-calendar"></span>
								</button>
						</div>
						&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						<select class="custom-select ml-2" style="width: 10%;" id="selectQutyCd"></select>
						<select class="custom-select ml-2 d-none" style="width: 13%;" id="selectBuyDealCorpCd"></select>
					</div>
					<!-- 날짜 조회 바 끝-->
					
					<!-- 탭 -->
					<div class="card-header card-tab p-0 mb-2">
						<!-- .nav-tabs tablist -->
						<ul class="nav nav-tabs card-header-tabs" style="margin-bottom: -16px;">
							<li class="nav-item">
								<a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">리치,ROHS</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" id="tab2Nav" data-toggle="tab" href="#tab2">원소재성적서</a>
							</li>
						</ul>
						<!-- /.nav-tabs -->
					</div>
					<!-- 탭 끝 -->
					
					<!-- .table-responsive -->
					<div class="table-responsive" id="reportMgmtAdmDiv">
						<table id="reportMgmtAdmTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>순번</th>
									<th>재질</th>
									<th>구분(연질/경질))</th>
									<th>등록자</th>
									<th>등록일자</th>
									<th>유효기간</th>
								</tr>
							</thead>
						</table>
					</div>
					
					<!-- 원소재성적서 테이블 끝 -->
					<div class="table-responsive d-none" id="reportRawMaterialAdmDiv">
						<table id="reportRawMaterialAdmTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>순번</th>
									<th>매입업체</th>
									<th>등록자</th>
									<th>등록일자</th>
									<th>유효기간</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- 원소재성적서 테이블 끝 -->
					
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 45%;">
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()">
								<i class="mdi mdi-close"></i>
							</a>
						</div>
					</div>
					<div class="card-body col-sm-12 p-1 mb-2">
						<button type="button" class="btn btn-danger float-right" id="btnDel">삭제</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<div id="myTabContent" class="tab-content">
						<div class="table-responsive mb-2">
							<form id="form">					
								<table class="table table-bordered">
									<thead class="thead-light">
										<tr class="" id="firstTr">
											<th>재질*</th>
											<td>
												<select class="custom-select" style="max-width: 100%" id="qutyCd" name="qutyCd" disabled></select>
											</td>
											<th>구분(연질/경질)*</th>
											<td>
												<select class="custom-select" style="max-width: 100%" id="gubunCd" name="gubunCd" disabled></select>
											</td>
										</tr>
										<tr class="d-none" id="secondTr">
											<th>매입 업체*</th>
											<td>
												<div class="input-sub m-0" style="max-width: 100%">
													<input type="hidden" class="form-control" style="max-width: 100%" id="buyDealCorpCd" name="buyDealCorpCd" disabled> 
													<input type="text"class="form-control" style="max-width: 100%" id="buyDealCorpNm" name="buyDealCorpNm" disabled>
													<button type="button" class="btn btn-primary input-sub-search"
														name="btnBuyDealCorp" id="btnBuyDealCorp" onClick="selectBuyDealCorp();" disabled>
														<span class="oi oi-magnifying-glass"></span>
													</button>
												</div>
											</td>
											<th></th>
											<td></td>
										</tr>
										<tr>
											<th>등록자*</th>
											<td>
												<div class="input-sub m-0" style="max-width: 100%">
													<input type="hidden" class="form-control" style="max-width: 100%" id="userAdd" name="userAdd" disabled> 
													<input type="text"class="form-control" style="max-width: 100%" id="userAddNm" name="userAddNm" disabled>
													<button type="button" class="btn btn-primary input-sub-search"
														name="btnUserChargr" id="btnUserChargr" onClick="selectUserChargr();" disabled>
														<span class="oi oi-magnifying-glass"></span>
													</button>
												</div>
											</td>
											<th>유효기간*</th>
											<td>
												<input type="date" class="form-control" style="max-width: 100%" id="validDate" name="validDate" disabled/>
											</td>
										</tr>
									</thead>
								</table>
							</form>
						</div>
						
						<!--
						<div class="table-responsive mb-2">
							<form id="form">					
								<table id="" class="table table-bordered">
									<thead class="thead-light">
										<tr>
											<th>매입 업체*</th>
											<td>
												<div class="input-sub m-0" style="max-width: 100%">
													<input type="hidden" class="form-control" style="max-width: 100%" id="buyDealCorpCd" name="buyDealCorpCd" disabled> 
													<input type="text"class="form-control" style="max-width: 100%" id="buyDealCorpNm" name="buyDealCorpNm" disabled>
													<button type="button" class="btn btn-primary input-sub-search"
														name="btnUserChargr" id="btnUserChargr" onClick="selectBuyDealCorp();" disabled>
														<span class="oi oi-magnifying-glass"></span>
													</button>
												</div>
											</td>
											<th>등록자*</th>
											<td>
												<div class="input-sub m-0" style="max-width: 100%">
													<input type="hidden" class="form-control" style="max-width: 100%" id="userAdd" name="userAdd" disabled> 
													<input type="text"class="form-control" style="max-width: 100%" id="userAddNm" name="userAddNm" disabled>
													<button type="button" class="btn btn-primary input-sub-search"
														name="btnUserChargr" id="btnUserChargr" onClick="selectUserChargr();" disabled>
														<span class="oi oi-magnifying-glass"></span>
													</button>
												</div>
											</td>
										</tr>
										<tr>
											<th>유효기간*</th>
											<td>
												<input type="date" class="form-control" style="max-width: 100%" id="validDate" name="validDate" disabled/>
											</td>
											<th></th>
											<td></td>
										</tr>
									</thead>
								</table>
							</form>
						</div>
						-->
						
						<div>
							<button type="button" class="btn btn-danger  float-right mr-1 mb-2" id="btnLineDel" disabled>문서 삭제</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="btnLineAdd" disabled>문서 추가</button>
							<button class="btn btn-warning d-none" id="btnSaveConfirmLoading" type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>처리중
							</button>
						</div>
						<div class="table-responsive">
							<form id="formFile" method="post" enctype="multipart/form-data">
								<table id="reportMgmtDtlTable" class="table table-bordered">
									<colgroup>
										<col width="3%">
										<col width="10%">
										<col width="15%">
										<col width="25%">
									</colgroup>
									<thead>
										<tr>	
											<th>No.</th>
											<th>SEQ</th>
											<th>문서제목</th>
											<th>문서</th>
										</tr>
									</thead>
								</table>
							</form>
						</div>
						<button type="button" class="btn btn-primary float-right mr-1 d-none" id="btnSave">저장</button>
					</div>
				</div>
				<!-- ===/.right-sidebar 등록,수정===  -->
			</div>
			<!-- /.row -->
		</div>
		<!-- / #main  -->
	</div>
	<!-- Modal Start-->
	<!-- /.row -->
</div>
<!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "54%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
// 			setTimeout(function(){
// 				$('table[name=reportMgmtAdmTable] thead tr th').click();
// 			},400);
		}
		state = !state;
	});

	let currentHref = "qmsc0160";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","성적서 관리"); 
// 	let sideView = '';

	var serverDateFrom	= "${serverDateFrom}";
	var serverDateTo 	= "${serverDateTo}";

	var userNm 		= "${userNm}";
	var userNumber 	= "${userNumber}";

	var idx = '';
	var temp = 0;	//순번

	var tabGubunCd ='001';
	var selectQutyCd ='';
	var selectBuyDealCorpCd ='';

	//Dtl
   	var documentSeq='';
   	var documentContents='';
	
	//공통코드 처리 시작		
	var qutyCode = new Array(); // 재질
	<c:forEach items="${qutyCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	qutyCode.push(json);
	</c:forEach>

	var gubunCode = new Array(); // 구분(연질/결질)
	<c:forEach items="${gubunCd}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	gubunCode.push(json);
	</c:forEach>

	var dealCorpCd = new Array(); // 거래처정보관리
	<c:forEach items="${dealCorpAdmList}" var="info">
	var json = new Object();
	json.baseCd = "${info.dealCorpCd}";
	json.baseCdNm = "${info.dealCorpNm}";
	dealCorpCd.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	selectBoxAppend(qutyCode, "qutyCd", "", "2");
	selectBoxAppend(gubunCode, "gubunCd", "", "2");
	selectBoxAppend_NameAdd(qutyCode, "selectQutyCd", "", "1", "재질");
	selectBoxAppend_NameAdd(dealCorpCd, "selectBuyDealCorpCd", "", "1", "매입업체");

	$('#tab1Nav').on('click', function() {
		uiProc(true);
		btnTop_UiProc(false);
		btnBottom_UiProc(true);
		tabGubunCd ='001';
		$('#form').each(function() {
			this.reset();
		});
		idx = '';
		$('#btnSave').addClass('d-none');
		$('#firstTr').removeClass('d-none');
		$('#secondTr').addClass('d-none');
		$('#reportMgmtAdmTable').DataTable().ajax.reload();
		$('#reportMgmtDtlTable').DataTable().ajax.reload();
		$('#selectQutyCd').removeClass('d-none');
		$('#selectBuyDealCorpCd').addClass('d-none');
		$('#reportMgmtAdmDiv').removeClass('d-none');
		$('#reportRawMaterialAdmDiv').addClass('d-none');
		selectBoxAppend_NameAdd(qutyCode, "selectQutyCd", "", "1", "재질");
	});

	$('#tab2Nav').on('click', function() {
		uiProc(true);
		btnTop_UiProc(false);
		btnBottom_UiProc(true);
		tabGubunCd ='002';
		$('#form').each(function() {
			this.reset();
		});
		idx = '';
		selectQutyCd='';
		selectBuyDealCorpCd='';
		$('#firstTr').addClass('d-none');
		$('#secondTr').removeClass('d-none');
		$('#btnSave').addClass('d-none');
		$('#reportRawMaterialAdmTable').DataTable().ajax.reload();
		$('#reportMgmtDtlTable').DataTable().ajax.reload();
		$('#selectQutyCd').addClass('d-none');
		$('#selectBuyDealCorpCd').removeClass('d-none');
		$('#reportMgmtAdmDiv').addClass('d-none');
		$('#reportRawMaterialAdmDiv').removeClass('d-none');
		selectBoxAppend_NameAdd(dealCorpCd, "selectBuyDealCorpCd", "", "1", "매입업체");
		
	});
	
	//문서관리Adm 목록 조회
   	$.fn.dataTable.ext.errMode = 'none';
   	let reportMgmtAdmTable = $('#reportMgmtAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
   		dom : "<'row'<'col-sm-12 col-md-7'><'col-sm-12 col-md-5'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		pageLength : 20000,
		ajax : {
			url : '<c:url value="qm/reportMgmtAdmList"/>',
			type : 'GET',
			data : {
				'startDate'		: function(){ return serverDateFrom; },
				'endDate'  		: function(){ return moment(serverDateTo).add(1,"days").format("YYYY-MM-DD"); },
				'qutyCd'  		: function(){ return selectQutyCd; },
				'buyDealCorpCd' : function(){ return selectBuyDealCorpCd; },
				'tabGubunCd'	: function(){ return tabGubunCd;},
			},
		},
		columns : [
			{ render : function(data, type, row, meta) {
				return meta.row
					+ meta.settings._iDisplayStart
					+ 1;
				}
			},
			{ data : 'qutyNm'		},
			{ data : 'gubunNm'		},
			{ data : 'userAddNm'	},
			{ data : 'regDate',		
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data : 'validDate',		
				render : function(data, type, row, meta){
					if(data < serverDateTo){
						return '<label style="color:red;">'+data+'<label>';
					}else{
						return data;
					}
					
				}
			}
		],
		order : [ [ 0, 'desc' ] ],
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
            }
        ],
	});

	//성적서관리(원소재)_Adm 목록 조회
   	$.fn.dataTable.ext.errMode = 'none';
   	let reportRawMaterialAdmTable = $('#reportRawMaterialAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
   		dom : "<'row'<'col-sm-12 col-md-7'><'col-sm-12 col-md-5'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		pageLength : 20000,
		ajax : {
			url : '<c:url value="qm/reportMgmtAdmList"/>',
			type : 'GET',
			data : {
				'startDate'		: function(){ return serverDateFrom; },
				'endDate'  		: function(){ return moment(serverDateTo).add(1,"days").format("YYYY-MM-DD"); },
				'qutyCd'  		: function(){ return selectQutyCd; },
				'buyDealCorpCd'	: function(){ return selectBuyDealCorpCd; },
				'tabGubunCd'	: function(){ return tabGubunCd;},
			},
		},
		columns : [
			{ render : function(data, type, row, meta) {
				return meta.row
					+ meta.settings._iDisplayStart
					+ 1;
				}
			},
			{ data : 'buyDealCorpNm'	},
			{ data : 'userAddNm'		},
			{ data : 'regDate',		
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data : 'validDate',		
				render : function(data, type, row, meta){
					if(data < serverDateTo){
						return '<label style="color:red;">'+data+'<label>';
					}else{
						return data;
					}
					
				}
			}
		],
		order : [ [ 0, 'desc' ] ],
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
            }
        ],
	});
	
	//성적서관리 테이블 목록 클릭 시
	$('#reportMgmtAdmTable, #reportRawMaterialAdmTable tbody').on('click', 'tr', function() {
		
		$('#reportMgmtAdmTable').DataTable().$('tr.selected').removeClass('selected');
		if (!$(this).hasClass('selected')) {
			$('#reportMgmtAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		
		$('#form').each(function() {
			this.reset();
		});
		$('#btnSave').addClass('d-none');
		uiProc(true);
		btnTop_UiProc(false);
		btnBottom_UiProc(true);
		
		if(tabGubunCd == '001'){
			idx = reportMgmtAdmTable.row(this).data().idx;
		}else{
			idx = reportRawMaterialAdmTable.row(this).data().idx;
		}

		//성적관리_Adm 상세조회
		$.ajax({
			url : '<c:url value="qm/reportMgmtAdmRead"/>',
			type : 'GET',
			data : {
				 'idx' : function(){return idx;},
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					$('#qutyCd').val(data.qutyCd);
					$('#gubunCd').val(data.gubunCd);
					$('#userAdd').val(data.userAdd);
					$('#userAddNm').val(data.userAddNm);
					$('#buyDealCorpCd').val(data.buyDealCorpCd);
					$('#buyDealCorpNm').val(data.buyDealCorpNm);
					$('#validDate').val(data.validDate);
				} else {
					toastr.error(res.message);
				}
			}
		});
		
		reportMgmtDtlTable.clear().draw();
		$('#reportMgmtDtlTable').DataTable().ajax.reload();
	});
	
	//등록버튼 클릭 시
	$('#btnAdd').on('click', function(){ 
		$('#form').each(function() {
			this.reset();
		});
		$('#userAdd').val(userNumber);
		$('#userAddNm').val(userNm);
		$('#btnSave').removeClass('d-none');
		$('#validDate').val(moment().add(1, "M").format('YYYY-MM-DD'));
		$('#reportMgmtAdmTable').DataTable().$('tr.selected').removeClass('selected');
		$('#reportRawMaterialAdmTable').DataTable().$('tr.selected').removeClass('selected');
		reportMgmtDtlTable.clear().draw();
		uiProc(false);
		btnTop_UiProc(true);
		btnBottom_UiProc(false);
		idx='';
	});

	//수정버튼 클릭 시
	$('#btnEdit').on('click', function(){
		if(tabGubunCd == '001'){
			if($('#reportMgmtAdmTable tbody tr').hasClass('selected')=='') {
				toastr.warning("수정할 항목을 선택해주세요.");
				return false;
			}
		}else{
			if($('#reportRawMaterialAdmTable tbody tr').hasClass('selected')=='') {
				toastr.warning("수정할 항목을 선택해주세요.");
				return false;
			}
		}
		
		$('#btnSave').removeClass('d-none');
		uiProc(false);
		btnTop_UiProc(true);
		btnBottom_UiProc(false);
	});

	//삭제버튼 클릭 시
	$('#btnDel').on('click', function(){
		if(tabGubunCd == '001'){
			if($('#reportMgmtAdmTable tbody tr').hasClass('selected')=='') {
				toastr.warning("삭제할 항목을 선택해주세요.");
				return false;
			}
		}else{
			if($('#reportRawMaterialAdmTable tbody tr').hasClass('selected')=='') {
				toastr.warning("삭제할 항목을 선택해주세요.");
				return false;
			}
		}

		$('#deleteModal2').modal({backdrop: 'static'});
		$('#deleteModal2').modal('show');
	});

	//삭제버튼 클릭 시
	$('#btnDeleteConfirmY').on('click', function(){
		if($('#reportMgmtDtlTable tbody tr').text() == "데이터가 없습니다."){
			//성적관리_Adm 삭제
			$.ajax({
				url : '<c:url value="qm/reportMgmtAdmDelete"/>',
				type : 'GET',
				data : {
					 'idx' 			: function(){return idx;},
					 'tabGubunCd' 	: function(){return tabGubunCd;},
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						$('#reportMgmtAdmTable').DataTable().ajax.reload();
						$('#reportRawMaterialAdmTable').DataTable().ajax.reload();
						$('#form').each(function() {
							this.reset();
						});
						toastr.success('삭제되었습니다.');
					} else {
						toastr.error(res.message);
					}
				}
			});
			$('#deleteModal2').modal('hide');
		}else{
			toastr.warning('먼저 등록되어있는 값을 삭제해주세요.');
		}
	});

	//성적서관리_Dtl 테이블 조회
	$.fn.dataTable.ext.errMode = 'none';
   	let reportMgmtDtlTable = $('#reportMgmtDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
		dom : "<'row'<'col-sm-12'><'col-sm-12 col-md-6'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="qm/reportMgmtDtlList"/>',
			type : 'GET',
			data : {
				'idx'			: function(){ return idx;},
				'tabGubunCd'	: function(){ return tabGubunCd;},
			},
		},
		rowId : 'idx',
		columns : [
			{ name : 'num',
				render : function(data, type, row, meta) {
					return '<label class="temp"disabled >'+(meta.row+1)+'</label></td>';
				}
			},
			{ data: 'documentSeq',
				render : function(data, type, row, meta) {
					if(data!=''){
						return '<td><input type="text" class="form-control text-center" style="max-width: 100%; background-color: #f6f7f9;" name="documentSeq_Rename'+meta.row+'" value="'+data+'" readonly></td>';
					}else{
						return '<td><input type="text" class="form-control text-center" style="max-width: 100%" name="documentSeq_Rename'+meta.row+'" placeholder="처리중..." readonly></td>';
					}
				}
			},
			{ data: 'documentTitle',
				render : function(data, type, row, meta) {
					if(data!=''){
						return '<td><input type="text" class="form-control text-center" style="max-width: 100%; background-color: #f6f7f9;" name="documentTitle'+meta.row+'" value="'+data+'" readonly></td>';
					}else{
						return '<td><input type="text" class="form-control text-center" style="max-width: 100%" name="documentTitle'+meta.row+'"></td>';
					}
				}
			},
			{ data: 'documentContents',
				render : function(data, type, row, meta) {
					if(data!=''){
						var rtn ='<a href="/qm/reportMgmtDtlDownloadFile?documentContents='+row['documentContents'] 
																		+'&documentSeq='+ row['documentSeq']
																		+'&idx='+ row['idx']
																		+'&tabGubunCd='+tabGubunCd+'"><span>'+row['documentContents']+'</span></a>';
						return rtn;
					}else{
							var rtn ='<div class="custom-file" style="width: 100%;" id="fileSearch'+meta.row+'" name="fileSearch'+meta.row+'">';
								rtn +='		<input type="file" class="custom-file-input" id="" name="fileNm">';
								rtn +='		<label class="custom-file-label" for="" name="fileFor"></label>';
								rtn +='</div>';
						return rtn;
					}
				}
			}
		],
		columnDefs : [
			 {  targets : [0], className: 'text-center-td' }
		],
	    order: [
	        [ 0, 'asc' ]
	    ],
	});
	
	//성적서관리_Dtl 테이블 클릭 시
	$('#reportMgmtDtlTable tbody').on('click', 'tr', function() {
		if (!$(this).hasClass('selected')) {
			$('#reportMgmtDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		if(reportMgmtDtlTable.row(this).data() != null){
			documentSeq 		= reportMgmtDtlTable.row(this).data().documentSeq;
			documentContents	= reportMgmtDtlTable.row(this).data().documentContents;
		}else{
			documentSeq ='';
		}
		
	});

	//사진 하나씩 삭제 시
	/*function deleteImg(value){
		var photoSeq = $('#trustPhotoSeq'+value).val();	//선택된 data-count에 해당하는 시퀀스 값을 가지고 온다.

		console.log("documentSeq : " +documentSeq);
		console.log("documentContents : " +documentContents);
		if($('#fileFor'+value).text() != ''){
			//삭제
			/*$.ajax({
				url : '<c:url value="qm/reportMgmtDtlDlete"/>',
				type : 'POST',
				data : {
					 'idx'				: function(){ return idx; 				},
					 'tabGubunCd'		: function(){ return '001';		},
					 'documentSeq'		: function(){ return documentSeq;		},
					 'documentContents'	: function(){ return documentContents;	}
				},
				success : function(res) {
					let data = res.result;
					
					if (res.result == 'ok') {
						toastr.success('삭제되었습니다.');
						$('#imageFile'+value).attr('src', '');
						$('#fileSearch'+value).removeClass('d-none');	//fileInputBox(div)
						$('#fileTag'+value).addClass('d-none');			//하이퍼링크 값(div)
					} else {
						toastr.error(res.message);
					}
				}
			});*/
			//삭제
	/*	}
	}*/
	
	//추가버튼 클릭 시
	$('#btnLineAdd').on('click', function(){
		reportMgmtDtlTable.row.add({
			"num"				:	temp+1,
			"documentSeq"		:	"",
			"documentTitle"		:	"",
			"documentContents"	:	""
		}).draw();

		var i = 1;
		//순번 삭제
		$('#reportMgmtDtlTable > tbody > tr > td').each(function(index, td) {
			if ((index % 4) == 0) {
				$(this).text(i);
				i++;
			}
        });
		$('input[name=documentSeq_Rename]').attr('placeholder', '처리중...');
        for(var i=0; i<$('#reportMgmtDtlTable tbody tr').length; i++){

        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(1).find('input[type=text]').attr('name', 'documentSeq_Rename'+i+'');	//SEQ
        	
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(2).find('input[type=text]').attr('name', 'documentTitle'+i+'');		//문서제목

//         	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('button[type=button]').attr('onclick', 'deleteImg('+i+')');

        	//문서 관련 아이디&이름 변경
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('input[type=file]').attr('id', 'fileNm'+i+'');			
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('label').attr('for', 'fileNm'+i+'');
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('label').attr('name', 'fileFor'+i+'');
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('input[type=file]').attr('name', 'fileNm'+i+'');
		}
	});
	
	
	//행삭제 버튼 클릭 시
	$('#btnLineDel').on('click',function() {
		if ($('#reportMgmtDtlTable  tbody tr').hasClass('selected')=='') {
			toastr.warning("삭제할 목록을 선택해 주세요");
			return false;
		}
		
		reportMgmtDtlTable.row('.selected').remove().draw();
		
		//순번 재 정의
		var i = 1;
		$('#reportMgmtDtlTable > tbody > tr > td').each(function(index, td) {
			if ((index % 4) == 0) {
				$(this).text(i);
				i++;
			}
        });
        
		temp = i;
		//순번 재 정의
        
        //ID값 재 정의
		 for(var i=0; i<$('#reportMgmtDtlTable tbody tr').length; i++){
			 
			$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(1).find('input[type=text]').attr('name', 'documentSeq_Rename'+i+'');
	        	
        	//문서제목
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(2).find('input[type=text]').attr('name', 'documentTitle'+i+'');

//         	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('button[type=button]').attr('onclick', 'deleteImg('+i+')');
			 
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('input[type=file]').attr('id', 'fileNm'+i+'');
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('label').attr('for', 'fileNm'+i+'');
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('label').attr('name', 'fileFor'+i+'');
        	$('#reportMgmtDtlTable tbody tr').eq(i).find('td').eq(3).find('input[type=file]').attr('name', 'fileNm'+i+'');
		}
		//ID값 재 정의
        
        if($('#reportMgmtDtlTable tbody tr').text() == '1'){
        	$('#reportMgmtDtlTable').DataTable().ajax.reload();
		}
        
        //삭제
        if(documentSeq != ''){
        	$.ajax({
    			url : '<c:url value="qm/reportMgmtDtlDlete"/>',
    			type : 'GET',
    			data : {
    				 'idx'				: function(){ return idx; 				},
    				 'tabGubunCd'		: function(){ return tabGubunCd;		},
    				 'documentSeq'		: function(){ return documentSeq;		},
    				 'documentContents'	: function(){ return documentContents;	}
    			},
    			success : function(res) {
    				let data = res.result;
    				
    				if (res.result == 'ok') {
    					$('#reportMgmtDtlTable').DataTable().ajax.reload();
    					toastr.success('삭제되었습니다.');
    				} else {
    					toastr.error(res.message);
    				}
    			}
    		});
		}
		//삭제
	});

	//요청수량 숫자만 입력하게 처리
	$(document).on('keyup',"input[name=reqQty]", function(event){
		var preInWhsQtyData = $(this).val();
		if (!((event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46)) {
			$('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); 
			toastr.warning('숫자만 입력해주세요.');
			$(this).val("");
			$(this).select();
			event.preventDefault();
			return false;
		}
		$(this).val(addCommas(uncomma($(this).val())));
	}); 
	
	//저장버튼 클릭 시
	$('#btnSave').on('click', function(){
		var checkYn ='Y';

		if(tabGubunCd == '001'){
			if(!$.trim($('#qutyCd').val())){
				toastr.warning('재질을 선택해주세요.');
				$('#qutyCd').focus();
				return false;
			}
			if(!$.trim($('#gubunCd').val())){
				toastr.warning('구분(연질/경질)을 선택해주세요.');
				$('#gubunCd').focus();
				return false;
			}
		}else{
			if(!$.trim($('#buyDealCorpNm').val())){
				toastr.warning('매입업체를 선택해주세요.');
				$('#buyDealCorpNm').focus();
				return false;
			}
		}
		
		if(!$.trim($('#userAddNm').val())){
			toastr.warning('등록자를 선택해주세요.');
			$('#userAddNm').focus();
			return false;
		}
		if(!$.trim($('#validDate').val())){
			toastr.warning('유효기간을 선택해주세요.');
			$('#validDate').focus();
			return false;
		}
		//조건 
		$('#reportMgmtDtlTable tbody tr').each(function(){
			/*if(!$.trim($(this).find('td').find('input[name=documentTitle]').val())){
				toastr.warning('문서 제목을 입력해주세요.');
				$(this).find('td').find('input[name=documentTitle]').focus();
				 checkYn ='N';
				return false;
			}
			if(!$.trim($(this).find('td').find('input[name=documentContents]').val())){
				toastr.warning('문서 파일을 선택해주세요.');
				$(this).find('td').find('input[name=documentContents]').focus();
				 checkYn ='N';
				return false;
			}*/
		});
		
		//저장처리
		if(checkYn !='N'){
			$('#my-spinner').show();
			
			var tableCount = 0;
				tableCount = $('#reportMgmtDtlTable tbody tr').length;

// 			for(var i=0; i<$('#reportMgmtDtlTable tbody tr').length; i++){
// 				if($('#documentSeq_Rename'+i).val() !=''){
// 					tableCount++
// 				}
// 			}
			
			var formData = new FormData(document.getElementById("formFile"));
			
				formData.append('qutyCd', $('#qutyCd option:selected').val());
				formData.append('gubunCd', $('#gubunCd option:selected').val());
				formData.append('buyDealCorpCd', $('#buyDealCorpCd').val());	//매입업체
				formData.append('userAdd', $('#userAdd').val());
				formData.append('validDate', $('#validDate').val());
				formData.append('tabGubunCd', tabGubunCd);	//탭관리
				formData.append('tableCount', tableCount);
				if(idx !=''){
					formData.append('idx', idx);
				}
			
// 			for (var pair of formData.entries()) {console.log(pair[0] +' : '+ pair[1]);}

			//저장
			$.ajax({
				url : '<c:url value="qm/reportMgmtCreate"/>',
				type : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
// 						if(sideView == 'add'){
							toastr.success('등록되었습니다.');
// 						}else{
// 							toastr.success('수정되었습니다.');
// 						}
					} else {
						toastr.error(res.message);
					}
	            },
	            complete : function() {
	            	$('#btnSave').addClass('d-none');
	            	reportMgmtDtlTable.clear().draw();
	        		$('#form').each(function() {
	        			this.reset();
	        		});
	        		uiProc(true);
	        		btnTop_UiProc(false);
	        		btnBottom_UiProc(true);
	        		$('#reportMgmtAdmTable').DataTable().ajax.reload(function(){});
	        		$('#reportRawMaterialAdmTable').DataTable().ajax.reload(function(){});
	        		$('#my-spinner').hide();
				}
			});
		}
	});

	//등록자 팝업버튼 클릭 시
	function selectUserChargr(){
		$('#userPopUpLabel').text("등록자 조회");			
		
		userPopUpTable = $('#userPopUpTable').DataTable({
			language : lang_kor,
			lengthChange : false,
			paging : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			destroy : true,
			pageLength : 15,
			ajax : {
				url : '/sm/matrlUserDataList',
				type : 'GET',
				data : {}
			},
			rowId : 'userNumber',
			columns : [ 
				{ data : 'userNm'		},
				{ data : 'departmentNm'	},
				{ data : 'postNm'		},
				{ data : 'chargrDutyNm'	},
				{ data : 'workplaceNm'	},
				{ data : 'userDesc'		},
			],
			columnDefs : [ {
				"targets" : [ 0, 1, 2, 3, 4, 5 ],
				"className" : "text-center"
			} ],
			order : [ [ 0, 'asc' ] ],
		});
		
		$('#userPopUpTable tbody').on('click', 'tr', function() {
			var data = userPopUpTable.row(this).data();
			
			$('#userAdd').val(data.userNumber);
			$('#userAddNm').val(data.userNm);
			$('#userPopUpModal').modal('hide');
		});
		$('#userPopUpModal').modal({backdrop: 'static'});
		$('#userPopUpModal').modal('show');
	}

	//매입처 조회
	function selectBuyDealCorp() {
		dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
			dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
					+ "<'row'<'col-sm-12'tr>>"
					+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,
			paging : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			lengthChange : false,
			pageLength : 15,
			ajax : {
				url : '<c:url value="/bm/dealCorpDataList"/>',
				type : 'GET',
				data : {},
			},
			rowId : 'dealCorpCd',
			columns : [
				{ data : 'dealCorpCd'	},
				{ data : 'dealCorpNm'	},
				{ data : 'initial'		},
				{ data : 'presidentNm'	},
				{ data : 'country'		},
				{ data : 'corpNo'		}
			],
			columnDefs : [
				{ "defaultContent" : "-", "targets" : "_all", "className" : "text-center"}
			],
			order : [ [ 0, 'asc' ] ],
			buttons : [],
		});

		$('#dealCorpPopUpTable tbody').on('click', 'tr', function() {
			var data = dealCorpPopUpTable.row(this).data();
			$('#buyDealCorpCd').val(data.dealCorpCd);
			$('#buyDealCorpNm').val(data.dealCorpNm);
			$('#dealCorpPopUpModal').modal('hide');
		});
		$('#dealCorpPopUpModal').modal('show');
	}

	
	var sysdate = "${serverTime}";

	/*var html1 = '<div class="row">';
	html1 += '&nbsp;&nbsp;<label class="input-label-sm">일자</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="preInWhsDateFrom" name="preInWhsDateFrom" disabled/>';
	html1 += '<button onclick="fnPopUpCalendar(preInWhsDateFrom,preInWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="preInWhsDateTo" name="preInWhsDateTo" disabled/>';
	html1 += '<button onclick="fnPopUpCalendar(preInWhsDateTo,preInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	html1 += '<select class="custom-select ml-2" id="selectQutyCd"></select>';
// 	html1 += '<select class="custom-select ml-2" id="selectBuyDealCorp"></select>';
// 	html1 += '&nbsp;&nbsp;<button type="button"  class="btn btn-primary" id="btnAllList">전체조회</button>';
	html1 += '</div>';*/

// 	$('#reportMgmtAdmTable_length').html(html1);
	$('#preInWhsDateFrom').val(serverDateFrom);
	$('#preInWhsDateTo').val(serverDateTo);

	$('#btnRetv').on('click', function() {
		serverDateFrom = $('#preInWhsDateFrom').val();
		serverDateTo = $('#preInWhsDateTo').val();
		$('#reportMgmtAdmTable').DataTable().ajax.reload();
		$('#reportRawMaterialAdmTable').DataTable().ajax.reload();
	});

	//재질조건 값 변경시
	$('#selectQutyCd').on('change', function(){
		selectQutyCd = $('#selectQutyCd option:selected').val();
		$('#reportMgmtAdmTable').DataTable().ajax.reload();
	});

	//매입업체 값 변경시
	$('#selectBuyDealCorpCd').on('change', function(){
		selectBuyDealCorpCd = $('#selectBuyDealCorpCd option:selected').val();
		$('#reportRawMaterialAdmTable').DataTable().ajax.reload();
	});
	
// 	$('#btnAllList').on('click', function() {
// 		serverDateFrom =  "";
// 		serverDateTo =  "";
// 		$('#reportMgmtAdmTable').DataTable().ajax.reload(function (){});
//     });

	//오른쪽 상단 inputBox영역
	function uiProc(flag) {
		$('#qutyCd').attr('disabled', flag);
		$('#gubunCd').attr('disabled', flag);
		$('#btnUserChargr').attr('disabled', flag);
		$('#btnBuyDealCorp').attr('disabled', flag);
		$('#validDate').attr('disabled', flag);
	}

	//but상단_영역
	function btnTop_UiProc(flag) {
		$('#btnAdd').attr('disabled', flag);
		$('#btnEdit').attr('disabled', flag);
		$('#btnDel').attr('disabled', flag);
	}
	
	//but하단_영역
	function btnBottom_UiProc(flag){
		$('#btnLineAdd').attr('disabled', flag);
		$('#btnLineDel').attr('disabled', flag);
	}
</script>

</body>
</html>
