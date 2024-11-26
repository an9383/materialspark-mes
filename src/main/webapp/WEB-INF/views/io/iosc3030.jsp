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
		<div style="margin-right: 40%;">
			<nav aria-label="breadcrumb" class="breadcrumb-padding">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
					<li class="breadcrumb-item active">자재 입고현황관리</li>
				</ol>
			</nav>
		</div>
		<div style="background-color: white; width: 47%; line-height: 30px;">
			<button type="button" class="btn btn-primary mr-1 ml-2" id="btnInAdd">가입고 등록</button>
			<button type="button" class="btn btn-primary mr-1" id="btnLocation">자재 위치이동</button>
			<button type="button" class="btn btn-primary mr-1" id="btnFifoCheck">선입선출 적용</button>
			<button type="button" class="btn btn-primary mr-3" id="btnInHistory">자재 이력관리</button>
			
			<button type="button"  class="btn btn-primary mr-1" id="btnRePrint">바코드 인쇄</button>
			<button type="button"  class="btn btn-primary mr-1" id="btnFaulty">불량</button>
			<button type="button"  class="btn btn-warning mr-6" id="btnReturn">반품 등록</button>
			<button type="button" class="btn btn-danger" style="width: 55px;" id="btnDelete">삭제</button>
		</div>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive" style="padding-bottom: 5px;">
					<table id="matrlInOutWhsTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="min-width:40px" class="text-center">
									<input type="checkbox" style="width:20px; height:20px" id="checkAll" name="checkAll">
								</th>
								<th style="min-width:75px" class="text-center">가입고일</th>
								<th style="min-width:130px" class="text-center">비고</th>
								<th style="min-width:50px" class="text-center">승인상태</th>
								<th style="min-width:50px" class="text-center">자재상태</th>
								<th style="min-width:50px" class="text-center">합격여부</th>
								<th style="min-width:70px" class="text-center">자재코드</th>
								
								<th style="min-width:70px" class="text-center">표면처리일</th>
								
								<th style="min-width:160px" class="text-center">자재명</th>
								<th style="min-width:160px" class="text-center">MotherRoll</th>
								<th style="min-width:50px" class="text-center">롤수</th>
								<th style="min-width:110px" class="text-center">바코드</th>
								<!-- <th style="min-width:110px" class="text-center">S-LOT</th> -->
								<!-- <th style="min-width:110px" class="text-center">LOT NO</th> -->
								<th style="min-width:50px" class="text-center">가입고량</th>
								<th style="min-width:50px" class="text-center">입고량</th>
								<th style="min-width:50px" class="text-center">차이</th>
									<th style="min-width:50px" class="text-center">잔량</th>
								<th style="min-width:80px" class="text-center">공급업체</th>
								<th style="min-width:80px" class="text-center">입고일</th>
								<th style="min-width:80px" class="text-center">수입검사일</th>
								<!-- <th style="min-width:80px" class="text-center">가출고 설비명</th> -->
								<!-- <th style="min-width:80px" class="text-center">제품명</th> -->
								<th style="min-width:80px" class="text-center">출고일</th>
								<th style="min-width:80px" class="text-center">투입일</th>
								<th style="min-width:80px" class="text-center">창고 위치</th>
								<th style="min-width:80px" class="text-center">선입선출</th>
								<th style="min-width:80px" class="text-center">불량일</th>
								<th style="min-width:150px" class="text-center">불량유형</th>
								<th style="min-width:200px" class="text-center">불량비고</th>
								<th style="min-width:200px" class="text-center">층구분자</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="10" style="text-align: center">합계</td>
								<td id="sumInWhsQty" style="text-align: right">0</td>
								<td id="sumInspectQty" style="text-align: right">0</td>
								<td id="sumAdjustQty" style="text-align: right">0</td>
								<td colspan="12"></td>
							</tr>
						</tfoot>
					</table>
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

<!-- 자재 창고이동 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="locationPopUpModal" tabindex="-1" role="dialog" aria-labelledby="locationPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">자재 창고이동</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<h6>이동하시겠습니까?</h6>
				이동위치 : <select class="custom-select" style="width:150px;" id="locationCd"></select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnLocationSave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="btnLocationCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 자재 창고이동 모달 종료 -->

<!-- 자재 선입선출 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="fifoCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="fifoCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">선입선출 적용</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<h6>선입선출을 적용 하시겠습니까?</h6>
				선입선출 : <select class="custom-select" style="width:150px;" id="selectFifoCheck"></select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFifoCheckSave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="btnFifoCheckCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 자재 선입선출 모달 종료 -->

<!-- 가입고 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="inAddPopUpModal" tabindex="-1" role="dialog" aria-labelledby="inAddPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 315%;">
			<div class="modal-header">
				<h5 class="modal-title">가입고 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<div class="card">
					<!-- title and toolbar -->
					<c:if test="${not empty error}">
						<div class="alert alert-danger" role="alert">${error}</div>
					</c:if>
					<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
						<button type="button" class="btn btn-primary float-left mr-1" id="checkDelete">체크 삭제</button>
	    		 		&nbsp;
	    		 		<button type="button" class="btn btn-primary float-left mr-1" id="addRow">입력</button>
	    		 		&nbsp;
	    		 		<select class="custom-select d-none" id="selectFactoryCode" disabled></select>
	    		 		<label id="labelFactoryCode"></label>
	    		 		
    		 			<label class="ml-2">입고 시간: </label>
    		 			<input type="Time" class="form-control d-none" style="display:inline; width: 100px;" name="inWhsTime" id="inWhsTime"/>
    		 			<button type="button" class="btn btn-primary ml-2 d-none" id="btnInWheTimeNow">지금</button>
	    		 		
						<label for="btnExcelUpload" class="btn btn-success float-right ml-1"> 엑셀업로드 </label>
						<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />
						
						&nbsp;
						<a href="" id="basicFrom">
							<button type="button" class="btn btn-secondary float-right" style="border: solid 1px blue;">기본양식다운로드</button>
						</a>
						&nbsp;
<!-- 							<button type="button" class="btn btn-primary float-right mr-1" id="btnSave">저장</button> -->
						&nbsp;
						<button type="button" class="btn btn-primary float-right mr-1" id="btnClear">초기화</button>
					</form>
				</div>
				<!-- .table-responsive -->
				<div class="table-responsive d-none" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="inDiv">			
					<table id="inTable" class="table table-bordered" style="text-align: center">
						<thead class="thead-light">
							<tr>
								<th style="width: 3.5%">
									<input type="checkbox" style="width:20px; height:20px" id="inCheckAll" name="inCheckAll">
								</th>
								<th>S-Lot</th>
								<th style="width: 11%">LOT NO</th>
								<th class='d-none'>자재코드2</th>
								<th>자재코드</th>
								<th style="width: 15.8%">자재명</th>
								<th>입고량</th>
								<th>길이</th>
								<th>업체코드</th>
								<th>공급업체</th>
								<th class='d-none'>가입고일2</th>
								<th>가입고일</th>
								<th>Barcode NO</th>
								<th>비고</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
				
				<!-- .table-responsive -->
				<div class="table-responsive d-none" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="inDiv_F3">
					<table id="inTable_F3" class="table table-bordered" style="text-align: center">
						<thead class="thead-light">
							<tr>
								<th style="width: 3.5%">
									<input type="checkbox" style="width:20px; height:20px" id="inCheckAll_F3" name="inCheckAll_F3">
								</th>
								<th>가입고일</th>
								<th>유수명</th>
								<th>표면처리일</th>
								<th>구매</th>
								<th>위치</th>
								<th>비고1</th>
								<th>자재코드(재질)</th>
								<th>MotherRoll</th>
								<th>LotNo</th>
								<th>규격</th>
								<th>롤수</th>
								<th>입고량(KG)</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary float-right mr-1" id="btnInAddSave" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 가입고 등록 모달 종료 -->

<!-- 자재 이력관리 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="inHistoryPopUpModal" tabindex="-1" role="dialog" aria-labelledby="inHistoryPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 300%;">
			<div class="modal-header">
				<h5 class="modal-title">자재 이력관리 조회</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<div class="table-responsive">
					<table id="matrlInOutWhsAdmHistTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width:130px" class="text-center">내역 일자</th>
								<th style="min-width:70px" class="text-center">가입고일</th>
								<th style="min-width:50px" class="text-center">비고</th>
								<th style="min-width:50px" class="text-center">승인상태</th>
								<th style="min-width:50px" class="text-center">자재상태</th>
								<th style="min-width:50px" class="text-center">자재코드</th>
								<th style="min-width:150px" class="text-center">자재명</th>
								<th style="min-width:110px" class="text-center">Barcode</th>
								<th style="min-width:50px" class="text-center">입고량</th>
								<th style="min-width:50px" class="text-center">실사량</th>
								<th style="min-width:50px" class="text-center">조정량</th>
								<th style="min-width:50px" class="text-center">차이</th>
								<th style="min-width:50px" class="text-center">잔량</th>							
								<th style="min-width:60px" class="text-center">창고 위치</th>
								<th style="min-width:50px" class="text-center">선입선출</th>
								<th style="min-width:70px" class="text-center">입고일</th>
								<th style="min-width:70px" class="text-center">수입검사일</th>
								<th style="min-width:70px" class="text-center">출고일</th>
								<!-- <th style="min-width:80px" class="text-center">가출고 설비명</th> -->
								<!-- <th style="min-width:80px" class="text-center">가출고 제품명</th> -->
								<th style="min-width:70px" class="text-center">투입일</th>
								<th style="min-width:80px" class="text-center">투입 설비명</th>
								<th style="min-width:80px" class="text-center">투입 제품명</th>
								<th style="min-width:70px" class="text-center">불량일</th>
								<th style="min-width:120px" class="text-center">불량유형</th>
								<th style="min-width:60px" class="text-center">불량비고</th>
								<th style="min-width:100px" class="text-center">투입작지</th>
								<th style="min-width:50px" class="text-center">투입중량</th>
								<th style="min-width:50px" class="text-center">불량중량</th>
								<th style="min-width:50px" class="text-center">재투입</th>
								<th style="min-width:70px" class="text-center">교체위치</th>
								<th style="min-width:50px" class="text-center">연결 여부</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer mt-2" style="border-top: 1px solid #e3e3e3;">
				<button type="button" class="btn btn btn-secondary" id="btnInHistoryCancel" data-dismiss="modal" style="min-width: 70px; margin-top: 15px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 자재 이력관리 모달 종료 -->

<!-- 삭제 확인 모달 시작-->
<div class="modal fade" id="deleteCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">삭제 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6 id="deleteLotNo"></h6>
      	<p>경고! 삭제한 데이터는 복구 할 수 없습니다!</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger" id="btnDeleteCheck" data-dismiss="modal" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn btn-secondary" id="btnDeleteCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 삭제 확인 모달 종료 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc3030';
	let currentHref = 'iosc3030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 입고현황관리");

	//공통코드 처리 시작
	var locationCode=new Array();		//location
    <c:forEach items="${locationCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		locationCode.push(json);
    </c:forEach>

    var matrlFifoCheck=new Array();	//선입선출
    <c:forEach items="${matrlFifoCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFifoCheck.push(json);
    </c:forEach>

    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>

    var agreeCdArray=new Array();	//승인상태
    <c:forEach items="${agreeCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		agreeCdArray.push(json);
    </c:forEach>

    var statusCdArray=new Array();	//자재 상태
    <c:forEach items="${statusCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		statusCdArray.push(json);
    </c:forEach>
    
    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>

    var matrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlCdList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		matrlCdList.push(json);
    </c:forEach>
    //공통코드 처리 종료  
	
	var factoryCode = "<%=factoryCode%>";
	var inWhsDateFromCal =  "${serverDateFrom}"; 
	var inWhsDateToCal =  "${serverDateTo}"; 
	var excludeStatusO = "";
	var excludeStatusP = "";
	if (factoryCode == '003') {
		excludeStatusO = 'check';
		excludeStatusP = 'check';
	}
	var frrrdType = '';
	var frrrdDesc = '';
	var approvalCd = '';
	var matrlBarcodeNo='';	//자재이력관리 바코드 조회
	selectBoxAppend(locationCode, "locationCd", "", "2");			//창고이동
	selectBoxAppend(matrlFifoCheck, "selectFifoCheck", "", "2");	//선입선출
	var serverDateTo =  "${serverDateTo}";
	$('#faultyDate').val(serverDateTo);
	
	$('#my-spinner').show();
	
	pageCountArray.sort(function(a, b) {
	  return a.baseCd - b.baseCd;
	});
	
	var pageCd = new Array();
	var pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0){
			pageCd.push(-1);
			pageNm.push("묶음보기(전체)");
		}else{
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsTable = $('#matrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",         
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
		scrollX: true,
        scrollY : "66vh",
        scrollCollapse: true,
        lengthChange : true,
        lengthMenu : [ pageCd, pageNm ],
        ajax: {
            url: '<c:url value="/io/matrlInOutWhsDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'			: 		menuAuth,
	           	'inWhsDateFrom'		:		function() { return inWhsDateFromCal.replace(/-/g, ''); },
	           	'inWhsDateTo'		:		function() { return inWhsDateToCal.replace(/-/g, ''); },
	           	'excludeStatusO'	:		function() { return excludeStatusO; },
	           	'excludeStatusP'	:		function() { return excludeStatusP; },
	           	//'excludeStatusO'	:		function() { return factoryCode=='003'?'check':excludeStatusO; },
	           	//'excludeStatusP'	:		function() { return factoryCode=='003'?'check':excludeStatusP; },
	           	'approvalCd'		:		function() { return $('#selectAgreeCd option:selected').val();	},
	           	'statusCd'			:		function() { return $('#selectstatusCd option:selected').val();	},
	           	'matrlCd'			:		function() { return $('#selectMatrlCd option:selected').val();	}
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
					return '<input type="checkbox" style="width:20px; height:20px" id="chk-' + meta.row + '" name="chk">' ;
				}
			},
			{
			    data: 'preInWhsDate',
			    render: function(data, type, row) {
					if(data != "" && data !=null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{ data: 'inWhsDesc'		},
			{ data: 'approvalNm'	},
            { data: 'statusNm'		},
            { data: 'inspectNm'		},
			//{ data: 'srLot'		},
			{ data: 'matrlCd'		},

			{
			    data: 'surfaceDate',
			    render: function(data, type, row) {
					if(data != "" && data !=null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			
			{ data: 'matrlNm'		},
			
			{ data: 'motherRollLot',
				 render: function(data, type, row) {
						if(data != "" && data !=null) {
							return data;
						} else {
							return "-";
						} 
				    } 
		    },
			{ data: 'rollCount',
				render: function(data, type, row) {
					if(data != "" && data !=null) {
						return data;
					} else {
						return "-";
					} 
			    } 
	    	},
			
			{ data: 'barcodeNo' },
			//{ data: 'lotNo' },
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
			{ data: 'preInDiff',
	    		render: function(data, type, row, meta) {	
					return row['preInWhsQty'] - row['inspectQty'];
	    		}
			},
			{ data: 'remainQty',
			     render: function(data, type, row, meta) {   
			        if (data == null) {
			         return '<input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:50px;" value="0" min="0" max="100">';
			        } else{
			        	if(row['statusCd'] == "P"){
				        	return '<input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:70px;" value="' + data + '" min="0" max="' + row.preInWhsQty + '" disabled>';
						} else {
							return '<input type="text" class="form-control number-float2 text-right" name="remainQty" style="width:70px;" value="' + data + '" min="0" max="' + row.preInWhsQty + '">';
						}
			        }
			    } 
			},
			//{ data: 'preInDiff',
			// render: function(data, type, row) {					
			//		return parseFloat(data).toFixed(2);
			//    }   
			//},
			{ data: 'spplyDealCorpNm' },
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
			//{
			//	data: 'statusCd',
			//	render: function(data, type, row) {
			//		if(data == "S" || data == "I") {
			//			return '가입고';
			//		} else if(data == "A") {
			//			return '수입검사 완료';
			//		} else if(data == "O") {
			//			return '출고(가출고)';
			//		} else if(data == "P") {
			//			return "생산 투입";
			//		}
			//	}
			//},
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
            { 
                data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "";
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
            { data: 'floorGubun' },
        ],
        columnDefs: [
           	{ targets: [12,13,14] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [12,13,14], className: 'text-right' },
           	{ orderable: false, targets: [0] },
//            	{ targets: "_all", "defaultContent": "-" },
        ],
        order: [
            [ 0, 'asc' ],
            [ 6, 'asc' ],
            [ 3, 'asc' ],
            [ 4, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '입출고관리/입고현황관리',
            },
            {
                extend: 'excel',
                title: '입출고관리/입고현황관리',
            },
            {
                extend: 'print',
                title: '입출고관리/입고현황관리',
            }
        ],
		drawCallback: function () {
			$('#matrlInOutWhsTable tfoot').remove();
			$("#checkAll").prop("checked",false);
			var sumInWhsQty		= $('#matrlInOutWhsTable').DataTable().column(12,{ page: 'current'} ).data().sum();
			var sumInspectQty	= $('#matrlInOutWhsTable').DataTable().column(13,{ page: 'current'} ).data().sum();
			var sumAdjustQty	= sumInWhsQty - sumInspectQty;
			//var sumAdjustQty	= $('#matrlInOutWhsTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			$('#sumInWhsQty').text(addCommas(sumInWhsQty.toFixed(2)));
			$('#sumInspectQty').text(addCommas(sumInspectQty.toFixed(2)));
			$('#sumAdjustQty').text(addCommas(sumAdjustQty.toFixed(2)));
        },
    });
	
	//페이지가 다 끝난 후 실행
	matrlInOutWhsTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});
	
    var sysdate = "${serverTime}";
	var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="inWhsDateFrom" name="inWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(inWhsDateFrom,inWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp&nbsp&nbsp<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="inWhsDateTo" name="inWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(inWhsDateTo,inWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';	
		html1 += '&nbsp;<button type="button"  class="btn btn-primary" id="btnRetv">조회</button>';
		html1 += '<select class="custom-select ml-2" id="selectAgreeCd"></select>';
		html1 += '<select class="custom-select ml-2" id="selectstatusCd"></select>';
		html1 += '<select class="custom-select ml-2" id="selectMatrlCd"></select>';
		//솔브레인SLD인 경우에만 출고&생산투입 제외 체크 기본설정
		if (factoryCode == '001' || factoryCode == '002') {
			html1 += '<input id="excludeStatusO" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-right:3px;"><label for="excludeStatusO" class="input-label-sm">출고 제외</label> ';
			html1 += '<input id="excludeStatusP" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-top:2px;margin-left: 0px; margin-right:3px;"><label for="excludeStatusP" class="input-label-sm">생산투입 제외</label> ';
		} else if (factoryCode == '003') {
			html1 += '<input id="excludeStatusO" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-right:3px;" checked><label for="excludeStatusO" class="input-label-sm" checked>출고 제외</label> ';
			html1 += '<input id="excludeStatusP" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-top:2px; margin-left: 0px; margin-right:3px;" checked><label for="excludeStatusP" class="input-label-sm">생산투입 제외</label> ';
		}
// 		html1 += '<label>🔄</label><label>초기화 </label>'
		html1 += '&nbsp;<button type="button"  class="btn" style="color: white; background-color: #04a304;" id="btnReset">검색조건 초기화</button>';
		html1 += '</div>';
    
	$('#matrlInOutWhsTable_length').append(html1);
	$('#inWhsDateFrom').val(inWhsDateFromCal);
	$('#inWhsDateTo').val(inWhsDateToCal);

	selectBoxAppend_NameAdd(agreeCdArray, "selectAgreeCd", "", "1", "승인상태");
	selectBoxAppend_NameAdd(statusCdArray, "selectstatusCd", "", "1", "자재상태");
	selectBoxAppend_NameAdd(matrlCdList, "selectMatrlCd", "", "1", "자재명");
	
	$('#matrlInOutWhsTable_length').find('select[name=matrlInOutWhsTable_length]').eq(0).attr('id', 'pageCount');
	$("#pageCount").insertAfter("#btnRetv");
	$('#matrlInOutWhsTable_length').find('label').eq(0).remove();
	$("#pageCount").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pageCount").addClass('custom-select ml-2');
	
	$('#selectAgreeCd, #selectstatusCd, #selectMatrlCd').on('change', function(){
		$('#my-spinner').show();
		$('#matrlInOutWhsTable').DataTable().ajax.reload(function(){
			$('my-spinner').hide();
		});
	});

	//검색 조건 초기화
	$('#btnReset').on('click', function(){
		selectBoxAppend_NameAdd(agreeCdArray, "selectAgreeCd", "", "1", "승인상태");
		selectBoxAppend_NameAdd(statusCdArray, "selectstatusCd", "", "1", "자재상태");
		selectBoxAppend_NameAdd(matrlCdList, "selectMatrlCd", "", "1", "자재명");
		$('#pageCount').val('-1');

		if ($('#excludeStatusP').prop('checked')) {
			excludeStatusP = 'check';
			$('#excludeStatusP').prop('checked', true);
		}
		if ($('#excludeStatusO').prop('checked')) {
			excludeStatusO = 'check';
			$('#excludeStatusO').prop('checked', true);
		}

		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
	});
	
	//dataTable lengthChange
	$(document).on('click','#pageCount',function(e){
		var selectAgreeCdFix	= $('#selectAgreeCd option:selected').val();
		var selectstatusCdFix	= $('#selectstatusCd option:selected').val();
		var selectMatrlCdFix	= $('#selectMatrlCd option:selected').val();
		
		$(document).on('change','#pageCount',function(e){
			selectBoxAppend_NameAdd(agreeCdArray, "selectAgreeCd", selectAgreeCdFix, "1", "승인상태");
			selectBoxAppend_NameAdd(statusCdArray, "selectstatusCd", selectstatusCdFix, "1", "자재상태");
			selectBoxAppend_NameAdd(matrlCdList, "selectMatrlCd", selectMatrlCdFix, "1", "자재명");
		});
	});

	let mainTableTrId = '';
	
    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
//             $(this).removeClass('selected');
        }else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        matrlBarcodeNo = matrlInOutWhsTable.row(this).data().barcodeNo;
        
        mainTableTrId = $(this).attr('id');
    });	
    
    //삭제
    $('#btnDelete').on('click', function() {
        var count = 0;
    	var checkbox = $("input[name=chk]:checked");    	
    	
    	if (checkbox.length==0){
    		toastr.warning("삭제할 자재를 선택해주세요.");
    		return false;
        } 

         else {
        	 $('#deleteLotNo').text("해당 LOT들을 삭제하시겠습니까?");
     		$('#deleteCheckPopupModal').modal('show');
        } 
	});
    
	//삭제 취소
    $('#btnDeleteCancel').on('click', function() {
		$('#deleteCheckPopupModal').modal('hide');
	});
	
	//삭제 실행
/* //     $('#btnDeleteCheck').on('click', function(){
//         var count = 0;
//     	var checkbox = $("input[name=chk]:checked");
//     	var dataArray = new Array();
//     	$('#my-spinner').show(); 	
//     	$.ajax({
// 			url: '<c:url value="io/deleteMatrlInOut"/>',
// 			type: 'POST',
// 			data: JSON.stringify(dataArray),
// 			dataType:"json",
// 			contentType : "application/json; charset=UTF-8",
// 			success: function (res) {
// 				let data = res.data;
// 				if( res.result == 'ok' ) {
// 					matrlCd = null;
// 				   	$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
// 				   	$("#checkAll").prop("checked",false);
// 				   	toastr.success("삭제되었습니다.");
// 				} else if(res.result =='statError') {
// 					toastr.warning(res.message, '', {timeOut: 5000});
// 					$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
// 				}
// 				else if(res.result =='error') {
// 					toastr.error(res.message, '', {timeOut: 5000});
// 					$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
// 				}
// 			},
// 			complete:function() {
// 				$('#my-spinner').hide();
// 			}
//         });
// 	}); */

    //조회
	$('#btnRetv').on('click', function() {
		$('#my-spinner').show();
		let dateFrom	= new Date($('#inWhsDateFrom').val());
		let dateTo		= new Date($('#inWhsDateTo').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		
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
		if (dateDiff > 366) {
			toastr.warning("검색 가능 기간은 최대 일년입니다!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}

		//자재명 SelectBox 담아주기
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
        });
	});

    
    var dataArray = "";
    var lotNo = "";
	//$('#matrlInOutWhsTable').on('change', 'input:checkbox[name="chk"]', function() {
    //	var rowCount = $(this).attr('id').split('-');
	//	lotNo = matrlInOutWhsTable.row(rowCount[1]).data().lotNo;
    //	if( $(this).is(":checked") ) {
    //		//console.log('add'+lotNo);
    //		dataArray += "/" + lotNo;
    //    } else{
    //        //console.log('remove'+lotNo);
    //    	dataArray = dataArray.replace("/" + lotNo, "");
	//	}
	//	
    //});
	
	//가출고 제외
	$('#excludeStatusO').click(function() {
		if ($(this).prop('checked')) {
			excludeStatusO = 'check';
			//console.log(excludeStatusP);
		} else {
			excludeStatusO = '';
			//console.log(excludeStatusP);
		}
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
	});
	
	//생산투입 제외
	$('#excludeStatusP').click(function() {
		if ($(this).prop('checked')) {
			excludeStatusP = 'check';
			//console.log(excludeStatusP);
		} else {
			excludeStatusP = '';
			//console.log(excludeStatusP);
		}
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
	});
	
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
		} else if (factoryCode == "002") {
			
		} else if (factoryCode == "003") {
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
		   	 		} else if (factoryCode == "002") {
		   	 			
		   	 		} else if (factoryCode == "003") {
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

    //불량
    $('#btnFaulty').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("불량 처리할 자재를 선택해주세요!");
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
		$('#frrrdPopUpModal').modal('show');
    });
    
    //반품
    $('#btnReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("반품 처리할 자재를 선택해주세요!");
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
/* 		//} else if (approvalCd == '004') {
		//	frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
		//	frrrdDesc = $('#frrrdDesc').val();
		//	for (let i=0; i<matrlFaultyType.length; i++) {
		//		if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
		//			frrrdType += '1';
		//		} else {
		//			frrrdType += '0';
		//		}
		//	}
		//	updateMtrlInOutWhsInspectQty("004");
        // */
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
		//} else if (approvalCd == '006') {
		//	frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
		//	frrrdDesc = $('#frrrdDesc').val();
		//	for (let i=0; i<matrlFaultyType.length; i++) {
		//		if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
		//			frrrdType += '1';
		//		} else {
		//			frrrdType += '0';
		//		}
		//	}
		//	updateMtrlInOutWhsInspectQty("006");
		//	
		////폐기
		//} else if (approvalCd == '007') {
		//	frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
		//	frrrdDesc = $('#frrrdDesc').val();
		//	for (let i=0; i<matrlFaultyType.length; i++) {
		//		if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
		//			frrrdType += '1';
		//		} else {
		//			frrrdType += '0';
		//		}
		//	}
		//	updateMtrlInOutWhsInspectQty("007");
		}
	});
	
	$(document).on('keypress','input[name=remainQty]',function (e) {
		//엔터키
    	if (e.which == 13){
			//toastr.warning($(this).val());
			$('#my-spinner').show();
			var remainQty = $(this).val();
			var barcodeNo = $(this).closest('tr').find('td').eq(11).html();
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

					//reload된 행 스크롤 다시 잡아주기.
					/*let top = $(matrlInOutWhsTable.settings()[0].nScrollBody).scrollTop();
   			        
	       			$('#matrlInOutWhsTable').DataTable().ajax.reload(function(){
	       				$(matrlInOutWhsTable.settings()[0].nScrollBody).scrollTop( top );
	       				$('#'+mainTableTrId).addClass('selected');
		       		});*/
		       		
		       		$('#matrlInOutWhsTable').DataTable().ajax.reload(function(){});
					$('#my-spinner').hide();
				 }
			}); 
    	}
    });
	
    $('#checkAll').on('click', function() {
		if($("#checkAll").prop("checked")) {
			$("input[name=chk]").prop("checked",true);
		} else {
			$("input[name=chk]").prop("checked",false);
		}
	});

    //checkBox디테일 설정
    $(document).on('click','input[name=chk]',function(e){
    	if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length){
    		$("#checkAll").prop("checked", true);
        }else{
        	$("#checkAll").prop("checked", false);
		}
	});

    //자재 창고이동
    $('#btnLocation').on('click', function() {
    	matrlLotNo();
		if ( dataArray == "" ){
			toastr.warning("이동할 자재를 체크해 주세요.");
			return false;
		}
		
		$('#locationPopUpModal').modal('show');
    });

	//자재 창고이동 실행
    $('#btnLocationSave').on('click', function() {
    	matrlLotNo();
		if ( dataArray == "" ) {
			toastr.warning("이동할 자재를 체크해 주세요.");
			return false;
		}

		if($('#locationCd option:selected').val() == "" ) {
			toastr.warning("이동위치를 선택해 주세요.");
			$('#locationCd').focus();
			return false;
		}
		
		$('#my-spinner').show();
		
		$.ajax({
			url: '<c:url value="/qm/matrlLocation_iosc0030"/>',
			type: 'POST',
			data: {
				'menuAuth'		: 	menuAuth,
				'slashLotNo'	: 	function() { return dataArray; },
				'locationCd'	: 	function() { return $('#locationCd option:selected').val(); },
			},
			success: function (res) {
				let result = res.result;
				if (res.result == 'ok') {
					toastr.success("이동 처리되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			 },
			complete:function(){
				dataArray = "";
				$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
				$('#my-spinner').hide();
			 }
		});

       $('#returnPopUpModal').modal('hide');
	});

	//선입선출 적용 버튼 클릭 시
	$('#btnFifoCheck').on('click', function(){
		matrlLotNo();
		if ( dataArray == "" ){
			toastr.warning("선입선출할 자재를 체크해 주세요.");
			return false;
		}
		$('#fifoCheckPopUpModal').modal('show');
	});

	//선입선출 적용 모달 확인 버튼 클릭 시
	$('#btnFifoCheckSave').on('click', function(){
		matrlLotNo();
		if ( dataArray == "" ) {
			toastr.warning("선입선출할 자재를 체크해 주세요.");
			return false;
		}

		if($('#selectFifoCheck option:selected').val() == "" ) {
			toastr.warning("선입선출을 선택해 주세요.");
			$('#selectFifoCheck').focus();
			return false;
		}
		
		$('#my-spinner').show();
		$.ajax({
			url: '<c:url value="/qm/matrlFifoCheck_iosc0030"/>',
			type: 'POST',
			data: {
				'menuAuth'		: 	menuAuth,
				'slashLotNo'	: 	function() { return dataArray; },
				'fifoCheck'		: 	function() { return $('#selectFifoCheck option:selected').val(); },
			},
			success: function (res) {
				let result = res.result;
				if (res.result == 'ok') {
					toastr.success("선입선출이 처리되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			 },
			complete:function(){
				dataArray = "";
				$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
				$('#my-spinner').hide();
			 }
		});
		$('#returnPopUpModal').modal('hide');
	});

	//자재이력관리 버튼 클릭 시
	$('#btnInHistory').on('click', function(){
		if($('#matrlInOutWhsTable tbody tr').hasClass('selected')=='') {
			toastr.warning("확인할 항목을 선택해주세요.");
			return false;
		}
		
		$('#matrlInOutWhsAdmHistTable').DataTable().ajax.reload();	//자재이력관리 테이블
		$('#inHistoryPopUpModal').modal('show');
	});

	//matrlInOutWhsTable dblclick click
	//$('#matrlInOutWhsTable tbody').on('dblclick', 'tr', function () {
	//	$('#matrlInOutWhsAdmHistTable').DataTable().ajax.reload();	//자재이력관리 테이블
	//	$('#inHistoryPopUpModal').modal('show');
	//});

// 	function matrlInOutWhsAdmHistTableReload(){
		// 목록
	    $.fn.dataTable.ext.errMode = 'none';
		let matrlInOutWhsAdmHistTable = $('#matrlInOutWhsAdmHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-9'l><'col-sm-12 col-md-3'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",         
	        language: lang_kor,
	        paging: false,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        searching: false,
	        pageLength: false,
	        ajax: {
	            url: '<c:url value="/io/matrlInOutHistList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'		: 		menuAuth,
		           	'barcodeNo'		:		function() { return matrlBarcodeNo; },
	            },
	        },
	        //rowId: 'lotNo',
	        columns: [
				{
				    data: 'regDate',
				    render: function(data, type, row) {
						if(data != "") {
							return moment(data).format("YYYY-MM-DD HH:mm:ss");
						} else {
							return "-";
						}
				    }
				},
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
				{ data: 'approvalNm' },
				{ data: 'statusNm' },
				{ data: 'matrlCd' },
				{ data: 'matrlNm' },
				{ data: 'barcodeNo' },
				{ data: 'inWhsQty',
					 render: function(data, type, row) {
						if (data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return '';
						}
					}
				},
				{ data: 'inspectQty',
					 render: function(data, type, row) {
						if (data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return '';
						}
					}
				},
				{ data: 'adjustQty',
					 render: function(data, type, row) {
						if (data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return '';
						}
					}
				},
				{ data: 'diffQty',
					 render: function(data, type, row) {
						if (data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return '';
						}
					}
				},
				{ data: 'remainQty',
					 render: function(data, type, row) {
						if (data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return '';
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
				{ 
				    data: 'inWhsDate',
				    render: function(data, type, row) {
						if (data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						}
				    }
				},
				{
				    data: 'inspctDate',
				    render: function(data, type, row) {
				    	if (data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						}
				    }
				},
				{
				    data: 'preOutWhsDate',
				    render: function(data, type, row) {
						if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						}
				    }
				},
				//{ data: 'preOutEquipNm' },
				//{ data: 'preOutGoodsNm' },
				{
				    data: 'outWhsDate',
				    render: function(data, type, row) {
				    	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						}
				    }
				},
				{ data: 'outEquipNm' },
				{ data: 'outGoodsNm' },
				{
				    data: 'frrrdDate',
				    render: function(data, type, row) {
				    	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "";
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
				{ data: 'workOrdNo' },
				{ data: 'fairQty',
					render: function(data, type, row) {
						if(data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return "";
						}
					}   
				},
				{ data: 'faultyQty',
					render: function(data, type, row) {
						if(data != "" && data != null) {
							return parseFloat(data).toFixed(2);
						} else {
							return "";
						}
					}
				},
				{ data: 'remakeYn',
		    		render: function(data, type, row) {	
		    			if(data != null) {
			    			let remakeNm = '';
			    			if(data == 'Y') {
			    				remakeNm = "재투입";
				    		} else if (data == 'N'){
				    			remakeNm = "신규투입";
					    	}
		    				return remakeNm;
		    			}
		    		}				
				},
				{ data: 'changeLocation' },
				{ data: 'connectNm' },
	        ],
	        columnDefs: [
	           	{ targets: [8,9,10,11, 12, 24,25] , render: $.fn.dataTable.render.number( ',' ) },
	           	{ targets: [8,9,10,11, 12, 24,25], className: 'text-right' },
	        ],
	        order: [
	            [ 0, 'asc' ],
	        ],
	        buttons: [],
			drawCallback: function () {
				$('#matrlInOutWhsAdmHistTable_wrapper').attr('style', 'padding-bottom: 10px; width: 275vh;');
	        },
	    });
// 	}

	//자재이력관리 테이블 클릭 시
	$('#matrlInOutWhsAdmHistTable tbody').on('click', 'tr', function(){
		if ( $(this).hasClass('selected') ) {
          //$(this).removeClass('selected');
		}else {
			$('#matrlInOutWhsAdmHistTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});


	//?
	$('#matrlInOutWhsTable').on('page.dt', function () {
		$("#checkAll").prop("checked", false); 
	});

    function matrlLotNo() {
		dataArray = "";
		var checkbox = $("input[name=chk]:checked");
		checkbox.each(function(i) {
			var rowCount = $(this).attr('id').split('-');
			lotNo = matrlInOutWhsTable.row(rowCount[1]).data().lotNo;
			dataArray += "/" + lotNo;
		});

		//console.log(dataArray);
	}

    //자재 불량&반품등록 상태로 update
	function updateMtrlInOutWhsInspectQty(approvalCd){
		$('#my-spinner').show();
		var dataArray 	= new Array();
		var checkbox 	= $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag 	= false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr 		= checkbox.parent().parent().eq(i);
			var td 		= tr.children();
			var rowData = new Object();
			var barcode = td.eq(11).text();
			
			rowData.menuAuth 	= menuAuth;
			rowData.barcode 	= barcode;
			rowData.approvalCd 	= approvalCd;
			rowData.frrrdDate 	= frrrdDate;	//불량&보류&반품 처리일
			rowData.frrrdType 	= frrrdType;	//불량&보류&반품 유형
			rowData.frrrdDesc 	= frrrdDesc;	//불량&보류&반품 비고
			rowData.fautlyByProductionTeam	= 'N';		//생산팀 불량 구분자
			dataArray.push(rowData);
			checkboxCnt += 1;
		});

		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010"){	
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
	                	$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
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



    
    //------------------------------------자재 입고요청(가입고)_iosc0010 모달 시작------------------------------------
    //가입고 버튼 클릭 시
    $('#btnInAdd').on('click', function() {
    	if(factoryCode == '001'){
    		$('#inTable').DataTable().ajax.reload();
        	$('#btnExcelUpload').val("");
    	}
    	else if(factoryCode == '002'){
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    	else if(factoryCode == '003'){
//     		$('#inTable_F3').DataTable().ajax.reload(); 
    		$('#inTable_F3').DataTable().clear().draw();
        	$('#btnExcelUpload').val("");
        	$('#inWhsTime').removeClass('d-none');
        	$('#btnInWheTimeNow').removeClass('d-none');
    	}
    	else{
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    	
    	inWhsTimeSetFun();
    	
    	$('#inAddPopUpModal').modal({backdrop: 'static'});
		$('#inAddPopUpModal').modal('show');
    });
    
    //입고 시간 지금 버튼 클릭 시 가입고 시간 현재로 변경
    $('#btnInWheTimeNow').on('click', function(){
    	inWhsTimeSetFun();
    });
    
    //빈 값인 경우 check
    $('#inWhsTime').on('change', function(){
    	if( $(this).val() == "" ) {
    		inWhsTimeSetFun();
    	}
    });
    
    function inWhsTimeSetFun(){
    	let now		= new Date();
    	let hours	= ("0" + now.getHours()).slice(-2);		// 시간
    	let minutes	= ("0" + now.getMinutes()).slice(-2);	// 분
    	
    	$('#inWhsTime').val( hours + ":" + minutes );
    }
    
   	//공통코드 처리 시작
	var factoryCd=new Array();	//승인여부
    <c:forEach items="${factoryCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdAbbr}";
		factoryCd.push(json);
    </c:forEach>
    //공통코드 처리 종료
    
	selectBoxAppend(factoryCd, "selectFactoryCode", factoryCode, "2");

	$('#labelFactoryCode').text($("#selectFactoryCode option:selected").text());

	if(factoryCode == '001'){
		//1공장 코드
		$('#inDiv').removeClass('d-none');
		$('#inDiv_F3').addClass('d-none');
		$('#basicFrom').attr('href', 'io/matrlInWhsRqtBasicForm');
	}else if(factoryCode == '002'){
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}else if(factoryCode == '003'){
		//3공장 코드
		$('#inDiv').addClass('d-none');
		$('#inDiv_F3').removeClass('d-none');
		$('#basicFrom').attr('href', 'io/matrlInWhsRqtBasicForm_F3');
	}
	else{
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}

	var url = "";
	//초기화 버튼
    $('#btnClear').on('click', function(){ 
    	if(factoryCode == '001'){
    		$('#inTable').DataTable().ajax.reload();
        	$('#btnExcelUpload').val("");
        	toastr.success("초기화 되었습니다. 파일을 다시 선택해주세요");
    	}
    	else if(factoryCode == '002'){
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    	else if(factoryCode == '003'){
//     		$('#inTable_F3').DataTable().ajax.reload();
    		$('#inTable_F3').DataTable().clear().draw();
        	$('#btnExcelUpload').val("");
        	toastr.success("초기화 되었습니다. 파일을 다시 선택해주세요");
    	}
    	else{
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    });


	//1공장관련 테이블
    $.fn.dataTable.ext.errMode = 'none';
	let inTable = $('#inTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    'ajax' : {		    	
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	        	'filename' : url,
	        }		       
	    },
	    columns: [
	    	{ 
	    		render: function(data, type, row, meta) {    			
					return '<input type="checkbox" style="width:20px; height:20px" name="inChk">' ;
	    		}
			},
	    	{ 
	    		render: function(data, type, row, meta) {	
	    			if(row['srLot'] != null && row['srLot'] != "false") {
	    				return '<input type="type" id="srLotId" class="form-control" style="border:0px; max-width:100%;" name="srLotId" disabled value="'+row['srLot'] + '">';
	    			} else {
						return '<input type="text" id="srLotId" class="form-control" name="srLotId" value=""  style="max-width:100%;">' ;
	    			}
	    		}
			},		    	
	    	{ data: 'lotNo',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="lotNoId" class="form-control" style="border:0px; max-width:100%;" name="lotNoId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="lotNoId" class="form-control" name="lotNoId" value="" style="max-width:100%;">' ;
	    			}
	    		}
			},
	    	{ data: 'matrlCd',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type"  id="matrlCdId" class="form-control" style="border:0px; max-width:100%;" name="matrlCdId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="matrlCdId" class="form-control" name="matrlCdId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'matrlNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="matrlNmId" class="form-control" style="border:0px; max-width:100%;" name="matrlNmId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="matrlNmId" class="form-control" name="matrlNmId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},	    	
	    	{ data: 'preInWhsQty',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="preInWhsQty" class="form-control" style="border:0px; max-width:100%;" name="preInWhsQty" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="preInWhsQty" class="form-control" name="preInWhsQty" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'inWhsLength',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="inWhsLength" class="form-control" style="border:0px; max-width:100%;" name="inWhsLength" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="inWhsLength" class="form-control" name="inWhsLength" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'spplyDealCorpCd',
	    		render: function(data, type, row, meta) {			    			
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="spplyDealCorpCd" class="form-control" style="border:0px; max-width:100%;" name="spplyDealCorpCd" disabled value="'+ pad(data, 5) + '">';
	    				//pad(data, 5);
	    			} else {
						return '<input type="text" id="spplyDealCorpCd" class="form-control" name="spplyDealCorpCd" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'spplyDealCorpNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="spplyDealCorpNm" class="form-control" style="border:0px; max-width:100%;" name="spplyDealCorpNm" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="spplyDealCorpNm" class="form-control" name="spplyDealCorpNm" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'preInWhsDate',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="preInWhsDateId" class="form-control" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="preInWhsDateId" class="form-control" name="preInWhsDateId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'barcodeNo',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="barcodeNoId" class="form-control" style="border:0px; max-width:100%;" name="barcodeNoId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="barcodeNoId" class="form-control" name="barcodeNoId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'inWhsDesc',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="inWhsDescId" class="form-control" style="border:0px; max-width:100%;" name="inWhsDescId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="inWhsDescId" class="form-control" name="inWhsDescId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	}
	    ],
	    columnDefs: [
	    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center"
	    	}		    	
	    ],
	    initComplete: function( settings, json ) {
	    	//var html1 =  '&nbsp; <button type="button" class="btn btn-primary" id="checkDelete">체크 삭제</button>';
	 		//var html2 =  '&nbsp;  &nbsp; <button type="button" class="btn btn-primary" id="addRow">입력</button>';
	 	    //
			//$('#inTable_length').html(html1 + html2);
			//$('#checkDelete').on('click', function(){
			//	var checkRows = $("[name='chk']:checked");	                    
			//	var tb = $('#inTable').DataTable();
			//	for(var i = checkRows.length-1; i > -1; i--){	                    	
			//	  	checkRows.eq(i).closest('tr').addClass('selected');
			//	  }
			//	  tb.rows('.selected').remove().draw(false);
			//  });
			//  $('#addRow').on('click',function(){
			//  	$('#inTable').DataTable().row.add({}).draw(false);
			//  });
			//  $('#inTable_filter').css('margin','10px');
	    }
	    /*	     
        buttons: [
       	 	{
            	text: '체크 삭제',
                action: function ( e, dt, node, config ) {
                    var checkRows = $("[name='chk']:checked");	                    
                    var tb = $('#inTable').DataTable();
                    for(var i = checkRows.length-1; i > -1; i--){	                    	
                    	checkRows.eq(i).closest('tr').addClass('selected');
                    }
                    tb.rows('.selected').remove().draw(false);
                                       
                }		            	
	        },
            {
                text: '입력',
                action: function ( e, dt, node, config ) {
                	$('#inTable').DataTable().row.add({}).draw(false);                    
                }
            },	            
        ]
       	*/
	});

	//제 3공장 관련 테이블
	$.fn.dataTable.ext.errMode = 'none';
	let inTable_F3 = $('#inTable_F3').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    'ajax' : {
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: menuAuth,
	        	'filename'		: url,
	        }		       
	    },
	    columns: [
		    { 
	    		render: function(data, type, row, meta) {    			
					return '<input type="checkbox" style="width:20px; height:20px" name="inChk_F3">' ;
	    		}
			},
	    	{ 
	    		render: function(data, type, row, meta) {	
	    			if(row['preInWhsDate'] != null && row['preInWhsDate'] != "false") {
	    				return '<input type="type" id="preInWhsDateId" class="form-control" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+row['preInWhsDate'] + '">';
	    			} else {
						return '<input type="text" id="preInWhsDateId" class="form-control" name="preInWhsDateId" value=""  style="max-width:100%;">' ;
	    			}
	    		}
			},		    	
	    	{ data: 'lifeTime',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="lifeTimeId" class="form-control" style="border:0px; max-width:100%;" name="lifeTimeId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="lifeTimeId" class="form-control" name="lifeTimeId" value="" style="max-width:100%;">' ;
	    			}
	    		}
			},
	    	{ data: 'surfaceDate',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type"  id="surfaceDateId" class="form-control" style="border:0px; max-width:100%;" name="surfaceDateId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="surfaceDateId" class="form-control" name="surfaceDateId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'data1',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="data1Id" class="form-control" style="border:0px; max-width:100%;" name="data1Id" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="data1Id" class="form-control" name="data1Id" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},	    	
	    	{ data: 'data2',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="data2" class="form-control" style="border:0px; max-width:100%;" name="data2" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="data2" class="form-control" name="data2" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'inWhsDesc',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="inWhsDesc" class="form-control" style="border:0px; max-width:100%;" name="inWhsDesc" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="inWhsDesc" class="form-control" name="inWhsDesc" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'matrlcd',
	    		render: function(data, type, row, meta) {			    			
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="matrlcd" class="form-control" style="border:0px; max-width:100%;" name="matrlcd" disabled value="'+ pad(data, 5) + '">';
	    				//pad(data, 5);
	    			} else {
						return '<input type="text" id="matrlcd" class="form-control" name="matrlcd" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'motherRollLot',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="motherRollLot" class="form-control" style="border:0px; max-width:100%;" name="motherRollLot" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="motherRollLot" class="form-control" name="motherRollLot" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'motherRollLotNo',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="motherRollLotNoId" class="form-control" style="border:0px; max-width:100%;" name="motherRollLotNoId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="motherRollLotNoId" class="form-control" name="motherRollLotNoId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'standard',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="standardId" class="form-control" style="border:0px; max-width:100%;" name="standardId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="standardId" class="form-control" name="standardId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'rollCount',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="rollCountId" class="form-control" style="border:0px; max-width:100%;" name="rollCountId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="rollCountId" class="form-control" name="rollCountId" value="" style="max-width:100%;" disabled>' ;
	    			}
	    		}
	    	},
	    	{ data: 'preInWhsQty',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="preInWhsQtyId" class="form-control text-right number-float2" style="border:0px; max-width:100%;" name="preInWhsQtyId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" class="form-control text-right number-float2" style="max-width:100%;" id="preInWhsQtyId" name="preInWhsQtyId" maxlength="8" value="">' ;
	    			}
	    		}
	    	}
	    ],
	    columnDefs: [
	    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
	    ],
	});

	//롤수 숫자만 입력하게 처리_F3
	$(document).on('keyup',"input[name=rollCountId]", function(event){
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

	//숫자만 입력, 길이, 소수점 세자리까지 제한
	$(document).on('keyup keydown','.number-float2', function(event) {
		if ( !(   (event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)   ) {
			//$('.number-float2').on("blur keyup", function() {
			//   $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
			$(this).select();
			return false;
		}
		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
          	$(this).val("0");
         	$(this).select();
         	toastr.warning('최대 크기를 초과하였습니다.');
			return false;
		}
		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			$(this).val("0");
			$(this).select();
         	toastr.warning('최소 크기를 초과하였습니다.');
         	return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		//소수점은 뒤에다가 적어야징
		let pointerPosition = $(this).val().split('.');
		if ( pointerPosition[0].length == 0  ) {
			toastr.warning('양수 뒤에 소수점을 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
      
		var _pattern2 = /^\d*[.]\d{3}$/;
		if (_pattern2.test( $(this).val())) {
			toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
			$(this).val("0");
			$(this).select();
		    return false;
		}
   });
	
    //저장 버튼
	$('#btnInAddSave').on('click', function() {
		if(factoryCode == '001') {
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요. <br> <에러코드: matarlInAdd-factoryCode-001>");
		} else if(factoryCode == '002') {
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요. <br> <에러코드: matarlInAdd-factoryCode-002>");
		} else if(factoryCode == '003') {
			//3공장 코드
			var dataArray = new Array();
			var lotNoArray = new Array();	//lotNo중복 검사
	    	var check=true;
	    	let dateCompare = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;

	    	//코드 중복 검사
 			/*for(var i=0; i<$('#inTable_F3 tbody tr').length; i++){
				var checkVal = $('#inTable_F3 tbody tr').eq(i).find('td').eq(9).find('input').val();
				for(var k=(i+1); k<$('#inTable_F3 tbody tr').length; k++){
					if(checkVal == $('#inTable_F3 tbody tr').eq(k).find('td').eq(9).find('input').val()){
						toastr.warning((i+1)+"번째, "+(k+1)+"번째 LotNo 값이 중복됩니다. <br> 중복된 값은 '"+checkVal+"' 입니다.");
						check=false;
						return false;
					}
				}
			} */
	    	
	    	$('#inTable_F3 tbody tr').each(function(){
		        var rowData = new Object();
		        if($(this).find('td input').eq(1).val() == ""){
		        	toastr.warning("가입고일을 입력해주십시오.");
		        	$(this).find('td input').eq(1).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(1).val().length != 10){
		        	toastr.warning("가입고일을 정확히 입력해주십시오.");
		        	$(this).find('td input').eq(1).focus();
		        	check=false;
		        	return false;
		        }
		        if( !dateCompare.test( $(this).find('td input').eq(1).val() ) ) {
		        	toastr.warning("(가입고일)날짜 형식은 YYYY-MM-DD입니다.<br>형식에 맞게 입력해주세요.");
		        	$(this).find('td input').eq(1).focus();
		        	check=false;
		        	return false;
		        }

		        if( $(this).find('td input').eq(3).val() != '' ) {
		        	if( $(this).find('td input').eq(3).val().length != 10 ){
			        	toastr.warning("표면처리일을 정확히 입력해주십시오.");
			        	$(this).find('td input').eq(3).focus();
			        	check=false;
			        	return false;
			        }
		        	if( !dateCompare.test( $(this).find('td input').eq(3).val() ) ) {
			        	toastr.warning("(표면처리일)날짜 형식은 YYYY-MM-DD입니다.<br>형식에 맞게 입력해주세요.");
			        	$(this).find('td input').eq(3).focus();
			        	check=false;
			        	return false;
			        }
				}
		        
		        /*if($(this).find('td input').eq(2).val() == ""){
		        	toastr.warning("유수명을 입력해주십시오.");
		        	$(this).find('td input').eq(2).focus();
		        	check=false;
		        	return false;
		        }	        
		        if($(this).find('td input').eq(3).val() == ""){
		        	toastr.warning("표면처리일 입력해주십시오.");
		        	$(this).find('td input').eq(3).focus();
		        	check=false;
		        	return false;
		        }       
		        if($(this).find('td input').eq(4).val() == ""){
		        	toastr.warning("구매를 입력해주십시오.");
		        	$(this).find('td input').eq(4).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(5).val() == ""){
		        	toastr.warning("위치를 입력해주십시오.");
		        	$(this).find('td input').eq(5).focus();
		        	check=false;
		        	return false;
		        }*/
		        if($(this).find('td input').eq(7).val() == ""){
		        	toastr.warning("자재코드(재질)를 입력해주십시오.");
		        	$(this).find('td input').eq(7).focus();
		        	check=false;
		        	return false;
		        }
		        
		        if($(this).find('td input').eq(7).val().substring(0,1) =="F"){
		        	$(this).find('td input').eq(8).val($(this).find('td input').eq(8).val().replace(' ',''));
		        	if($(this).find('td input').eq(8).val() == ""){
			        	toastr.warning("Lot(motherRoll)을 입력해주십시오.");
			        	$(this).find('td input').eq(8).focus();
			        	check=false;
			        	return false;
			        }
				}
		        
		        if($(this).find('td input').eq(9).val() == ""){
		        	toastr.warning("LotNo 입력해주십시오.");
		        	$(this).find('td input').eq(9).focus();
		        	check=false;
		        	return false;
		        }
		       /*if($(this).find('td input').eq(10).val() == ""){
		        	toastr.warning("규격을 입력해주십시오.");
		        	$(this).find('td input').eq(10).focus();
		        	check=false;
		        	return false;
		        }*/
		        /*if($(this).find('td input').eq(7).val().substring(0,1) =="F"){
		        	$(this).find('td input').eq(11).val($(this).find('td input').eq(11).val().replace(' ',''));
			        if($(this).find('td input').eq(11).val() == ""){
			        	toastr.warning("롤수를 입력해주십시오.");
			        	$(this).find('td input').eq(11).focus();
			        	check=false;
			        	return false;
			        }
		        }*/
		        
		        //담아주는 값
		        rowData.menuAuth		= menuAuth;
		        rowData.preInWhsDate	= $(this).find('td input').eq(1).val().replace(/-/g, '');	//가입고일
		        rowData.lifeTime		= $(this).find('td input').eq(2).val();						//유수명
		        rowData.surfaceDate		= $(this).find('td input').eq(3).val();						//표면처리일
		        rowData.data1			= $(this).find('td input').eq(4).val();						//구매
		        rowData.data2			= $(this).find('td input').eq(5).val();						//위치
		        rowData.inWhsDesc		= $(this).find('td input').eq(6).val();						//비고
		        rowData.matrlCd			= $(this).find('td input').eq(7).val();						//자재코드(재질)
		        rowData.motherRollLot	= $(this).find('td input').eq(8).val();						//Lot(motherRoll)
		        rowData.motherRollLotNo	= $(this).find('td input').eq(9).val();						//LotNo
		        rowData.standard		= $(this).find('td input').eq(10).val();					//규격
 		        //rowData.rollCount		= $(this).find('td input').eq(11).val();					//롤수

 		        rowData.rollCount	= '0';															//롤수
				rowData.inWhsTime	= $(this).find('td input').eq(1).val() + 'T' + $('#inWhsTime').val();															//롤수
 		        
		        /*if($(this).find('td input').eq(11).val() == ""){
		        	rowData.rollCount	= '1';														//롤수
		        }else{
		        	rowData.rollCount	= $(this).find('td input').eq(11).val();					//롤수
				}*/

				//가입고량(KG)
				if( $(this).find('td input').eq(12).val().replace(/(\s*)/g, "") == '' || $(this).find('td input').eq(12).val().replace(/(\s*)/g, "").replaceAll(/0{2,}/g, "0") == '0' ){
					rowData.preInWhsQty		= '20';															
				}else{
					rowData.preInWhsQty		= $(this).find('td input').eq(12).val().replace(/,/g,'');
				}
				
		        dataArray.push(rowData);

		        lotNoArray.push($(this).find('td input').eq(9).val());
	    	});

	    	var set = new Set();
	    		set = new Set(lotNoArray);

	    	if(lotNoArray.length != set.size){
	    		toastr.warning("중복되는 값이 존재합니다. 확인해주세요!");
	    		check=false;
	    		return false;
		    }
			
			if(check == true){
				$('#my-spinner').show();

				setTimeout(function(){
					$.ajax({
						url: '<c:url value="/io/matrlInWhsRqtNotRollCountSave_F3"/>',
				        type: 'POST',
				        datatype: 'json',
				        async : false,
				        data: JSON.stringify(dataArray),
				        contentType : "application/json; charset=UTF-8",
				        success: function(result){
					        if(result.result == "ok"){
						        var table = $('#inTable_F3').DataTable(); 		
				      			table.clear().draw();
				      			$('#btnExcelUpload').val("");
				      			$('#matrlInOutWhsTable').DataTable().ajax.reload();
				      			toastr.success('저장되었습니다.');
				        	} else if(result.result == "fail"){
				        		toastr.warning(result.message, '', {timeOut: 5000});
				        	} else if (result.result == 'using') {
				        		toastr.warning(result.message, '', {timeOut: 5000});
				        	} else{
				        		toastr.error(result.message, '', {timeOut: 5000});
				        		
				        	}
				        },
						complete:function(){
							$('#my-spinner').hide();
						}
			      	});
				}, 100);
			}
		} else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요. <br> <에러코드: matarlInAdd-factoryCode>");
		}
	});

    //주석 풀면 똑같은 파일을 다시 등록할 수 있다.  
// 	$('#btnExcelUpload').on('click', function(){
// 		$('#btnExcelUpload').val("");
// 	});
	
    //파일 선택
	$('#btnExcelUpload').change(function(){

		if(factoryCode == '001'){
			//1공장 코드
			var formData = new FormData($('#fileUploadForm')[0]);
			var str = $('#btnExcelUpload').val();
			//console.log(str.substring(str.lastIndexOf(".")+1));
			if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
				$.ajax({
			    	type: "POST",
			    	enctype: 'multipart/form-data',
			    	data: formData,
			    	url:'<c:url value="io/matrlInOutExcelUpload"/>',
			    	processData: false,
			    	contentType: false,
			    	cache: false,
			    	success: function (res) {
			    		if (res.result == 'ok') {
			    			url = res.data.url;
			    			let data = res.data;
			    			
							inTable = $('#inTable').DataTable({
				    		    language: lang_kor,
				    		    searching: false,
				    		    destroy: true,
				    		    paging: false,
				    		    info: true,		    
				    		    ordering: true,
				    		    processing: true,
				    		    autoWidth: false,
				    		    pageLength: false,		    		
				    		    'ajax' : {		    	
				    		        url: '<c:url value="/io/matrlInWhsRqtPopDataList"/>',
				    		        type: 'GET',
				    		        data: {
				    		        	'menuAuth'	 	: 		menuAuth,
				    		        	'filename'		:		url,
				    		        }		       
				    		    },
				    		    columns: [
				    		    	{ 
				    		    		render: function(data, type, row, meta) {    			
				    						return '<input type="checkbox" style="width:20px; height:20px" name="chk" checked="checked">' ;
				    		    		}
				    				},
				    		    	{ 
				    		    		render: function(data, type, row, meta) {	
				    		    			if(row['srLot'] != null && row['srLot'] != "false") {
				    		    				return '<input type="type" id="srLotId" class="form-control text-center" style="border:0px; max-width:100%;" name="srLotId" disabled value="'+row['srLot'] + '">';
				    		    			} else {
				    							return '<input type="text" id="srLotId" class="form-control text-center" name="srLotId" value=""  style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    				},		    	
				    		    	{ data: 'lotNo',
				    		    		render: function(data, type, row, meta) {
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="lotNoId" class="form-control text-center" style="border:0px; max-width:100%;" name="lotNoId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="lotNoId" class="form-control text-center" name="lotNoId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    				},
				    				{ data: 'matrlCd', 'className' : 'd-none' },
				    		    	{ data: 'matrlCd' ,
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type"  id="matrlCdId" class="form-control text-center" style="border:0px; max-width:100%;" name="matrlCdId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="matrlCdId" class="form-control text-center" name="matrlCdId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'matrlNm',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="matrlNmId" class="form-control text-center" style="border:0px; max-width:100%;" name="matrlNmId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="matrlNmId" class="form-control text-center" name="matrlNmId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},	    	
				    		    	{ data: 'preInWhsQty',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="preInWhsQty" class="form-control text-right" style="border:0px; max-width:100%;" name="preInWhsQty" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="preInWhsQty" class="form-control text-right" name="preInWhsQty" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'inWhsLength',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="inWhsLength" class="form-control text-right" style="border:0px; max-width:100%;" name="inWhsLength" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="inWhsLength" class="form-control text-right" name="inWhsLength" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'spplyDealCorpCd',
				    		    		render: function(data, type, row, meta) {			    			
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="spplyDealCorpCd" class="form-control text-center" style="border:0px; max-width:100%;" name="spplyDealCorpCd" disabled value="'+ pad(data, 5) + '">';
				    		    				//pad(data, 5);
				    		    			} else {
				    							return '<input type="text" id="spplyDealCorpCd" class="form-control text-center" name="spplyDealCorpCd" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'spplyDealCorpNm',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="spplyDealCorpNm" class="form-control text-center" style="border:0px; max-width:100%;" name="spplyDealCorpNm" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="spplyDealCorpNm" class="form-control text-center" name="spplyDealCorpNm" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'preInWhsDate', 'className' : 'd-none' },
				    		    	{ data: 'preInWhsDate',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="preInWhsDateId" class="form-control text-center" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="preInWhsDateId" class="form-control text-center" name="preInWhsDateId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'barcodeNo',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="barcodeNoId" class="form-control text-center" style="border:0px; max-width:100%;" name="barcodeNoId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="barcodeNoId" class="form-control text-center" name="barcodeNoId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'inWhsDesc',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="inWhsDescId" class="form-control text-center" style="border:0px; max-width:100%;" name="inWhsDescId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="inWhsDescId" class="form-control text-center" name="inWhsDescId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	}
				    		    ],
				    		    order : [
					    		    [3, 'desc'], [10, 'asc']
								],
				    		    columnDefs: [
				    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
				    		    ],
				    		    initComplete: function( settings, json ) {
				    		    	$("#inCheckAll").prop("checked",true); 
				    		    }
					        });
			    		} else if (res.result == 'fail') {
			    			toastr.warning(res.message, '', {timeOut: 5000});
			    		} else if (res.result == 'error') {
			    			toastr.error(res.message, '', {timeOut: 5000});
			    		}
					},
				});
			} else {
				toastr.warning("Excel파일을 선택해 주세요.");
				return false;
			}
		}
		else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
		else if(factoryCode == '003'){
			//3공장 코드
			var formData = new FormData($('#fileUploadForm')[0]);
			var str = $('#btnExcelUpload').val();
// 			console.log(str.substring(str.lastIndexOf(".")+1));
			if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
				$.ajax({
			    	type: "POST",
			    	enctype: 'multipart/form-data',
			    	data: formData,
			    	url:'<c:url value="io/matrlInOutExcelUpload"/>',
			    	processData: false,
			    	contentType: false,
			    	cache: false,
			    	success: function (res) {
			    		if (res.result == 'ok') {
			    			url 		= res.data.url;
			    			let data 	= res.data;


			    			$.ajax({
			    		        url: '<c:url value="/io/matrlInWhsRqtPopDataList_F3"/>',
			    		        type: 'GET',
			    		        data: {
			    		        	'menuAuth'	 	: 		menuAuth,
			    		        	'filename'		:		url,
			    		        },
			    		        success: function (res) {
									if(res.result == 'ok'){
										inTable_F3 = $('#inTable_F3').DataTable({
							    		    language: lang_kor,
							    		    searching: false,
							    		    destroy: true,
							    		    paging: false,
							    		    info: true,		    
							    		    ordering: true,
							    		    processing: true,
							    		    autoWidth: false,
							    		    pageLength: false,
							    		    data: res.data,
							    		    columns: [
							    		    	{
							    		    		render: function(data, type, row, meta) {    			
							    						return '<input type="checkbox" style="width:20px; height:20px" name="inChk_F3" checked="checked">' ;
							    		    		}
							    				},
							    		    	{
							    		    		render: function(data, type, row, meta) {	
							    		    			if(row['preInWhsDate'] != null && row['preInWhsDate'] != "false") {
							    		    				return '<input type="type" id="preInWhsDateId" class="form-control text-center" style="max-width:100%;" name="preInWhsDateId" disabled value="'+row['preInWhsDate'] + '">';
							    		    			} else {
							    							return '<input type="text" id="preInWhsDateId" class="form-control text-center" name="preInWhsDateId" value=""  style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    				},		    	
							    		    	{ data: 'lifeTime',
							    		    		render: function(data, type, row, meta) {
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="lifeTimeId" class="form-control text-center" style="max-width:100%;" name="lifeTimeId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="lifeTimeId" class="form-control text-center" name="lifeTimeId" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    				},
	//		 				    				{ data: 'matrlCd', 'className' : 'd-none' },	
							    		    	{ data: 'surfaceDate' ,
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type"  id="surfaceDateId" class="form-control text-center" style="max-width:100%;" name="surfaceDateId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="surfaceDateId" class="form-control text-center" name="surfaceDateId" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'data1',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="data1Id" class="form-control text-center" style="max-width:100%;" name="data1Id" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="data1Id" class="form-control text-center" name="data1Id" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},	    	
							    		    	{ data: 'data2',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="data2" class="form-control text-center" style="max-width:100%;" name="data2" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="data2" class="form-control text-center" name="data2" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'inWhsDesc',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="inWhsDesc" class="form-control text-right" style="max-width:100%;" name="inWhsDesc" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="inWhsDesc" class="form-control text-right" name="inWhsDesc" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'matrlCd',
							    		    		render: function(data, type, row, meta) {			    			
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="matrlCd" class="form-control text-center" style="max-width:100%;" name="matrlCd" disabled value="'+ pad(data, 5) + '">';
							    		    				//pad(data, 5);
							    		    			} else {
							    							return '<input type="text" id="matrlCd" class="form-control text-center" name="matrlCd" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'motherRollLot',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="motherRollLot" class="form-control text-center" style="max-width:100%;" name="motherRollLot" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="motherRollLot" class="form-control text-center" name="motherRollLot" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
	//		 				    		    	{ data: 'preInWhsDate', 'className' : 'd-none' },
							    		    	{ data: 'motherRollLotNo',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="motherRollLotNoId" class="form-control text-center" style="max-width:100%;" name="motherRollLotNoId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="motherRollLotNoId" class="form-control text-center" name="motherRollLotNoId" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'standard',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="standardId" class="form-control text-center" style="max-width:100%;" name="standardId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="standardId" class="form-control text-center" name="standardId" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'rollCount',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="rollCountId" class="form-control text-center" style="max-width:100%;" name="rollCountId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="rollCountId" class="form-control text-center" name="rollCountId" value="" style="max-width:100%;" disabled>' ;
							    		    			}
							    		    		}
							    		    	},
							    		    	{ data: 'preInWhsQty',
							    		    		render: function(data, type, row, meta) {	
							    		    			if(data != null && data != "false" && data != "") {
							    		    				return '<input type="type" id="preInWhsQtyId" class="form-control text-right number-float2" style="max-width:100%;" name="preInWhsQtyId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" class="form-control text-right number-float2" style="max-width:100%;" id="preInWhsQtyId" name="preInWhsQtyId" maxlength="8" value="">' ;
							    		    			}
							    		    		}
							    		    	}
							    		    ],
							    		    order : [
								    		    [3, 'desc'], [10, 'asc']
											],
							    		    columnDefs: [
							    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }
							    		    ],
							    		    initComplete: function( settings, json ) {
							    		    	$("#inCheckAll_F3").prop("checked",true); 
							    		    }
								        });
									}else if(res.result == 'fail'){
										toastr.warning(res.message, '', {timeOut: 5000});
										$('#btnExcelUpload').val('');
									}else{
										toastr.error(res.message, '', {timeOut: 5000});
										$('#btnExcelUpload').val('');
									}
								}
			    		    });
			    		    
			    		} else if (res.result == 'fail') {
			    			toastr.warning(res.message, '', {timeOut: 5000});
			    		} else if (res.result == 'error') {
			    			toastr.error(res.message, '', {timeOut: 5000});
			    		}
					},
				});
			} else {
				toastr.warning("Excel파일을 선택해 주세요.");
				return false;
			}
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	}); 

    $('#inCheckAll').on('click', function(){
		if($("#inCheckAll").prop("checked")) { 
			$("input[name=inChk]").prop("checked",true); 
		} else { 
			$("input[name=inChk]").prop("checked",false);
		}        
    });

    $('#inCheckAll_F3').on('click', function(){
		if($("#inCheckAll_F3").prop("checked")) { 
			$("input[name=inChk_F3]").prop("checked",true); 
		} else { 
			$("input[name=inChk_F3]").prop("checked",false);
		}        
    });

  //checkBox디테일 설정
    $(document).on('click','input[name=inChk]',function(e){
    	if($('input:checkbox[name=inChk]:checked').length == $('input:checkbox[name=inChk]').length){
    		$("#inCheckAll").prop("checked", true);
        }else{
        	$("#inCheckAll").prop("checked", false);
		}
	});

	//checkBox디테일 설정_F3
    $(document).on('click','input[name=inChk_F3]',function(e){
    	if($('input:checkbox[name=inChk_F3]:checked').length == $('input:checkbox[name=inChk_F3]').length){
    		$("#inCheckAll_F3").prop("checked", true);
        }else{
        	$("#inCheckAll_F3").prop("checked", false);
		}
	});
	
	$('#checkDelete').on('click', function() {
		if(factoryCode == '001'){
			//신규코드
			$('#inTable tbody tr').each(function(){
		        if($(this).find('td input[name=inChk]').is(':checked')){
		        	inTable.row(this).remove().draw();
		        }
			});
			$('#inCheckAll').prop('checked', false);
		}
		else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
		else if(factoryCode == '003'){
			$('#inTable_F3 tbody tr').each(function(){
		        if($(this).find('td input[name=inChk_F3]').is(':checked')){
		        	inTable_F3.row(this).remove().draw();
		        }
			});
			$('#inCheckAll_F3').prop('checked', false);
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	});
	
	$('#addRow').on('click', function() {
		if(factoryCode == '001'){
			inTable.row.add({}).draw();
			$('#inTable_filter').css('margin', '10px');
			if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length){
	    		$("#checkAll").prop("checked", true);
	        }else{
	        	$("#checkAll").prop("checked", false);
			}
		}else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}else if(factoryCode == '003'){
			$('#inTable_F3').DataTable().row.add({}).draw(false);
			$('#inTable_F3_filter').css('margin', '10px');
			if($('input:checkbox[name=chk_F3]:checked').length == $('input:checkbox[name=chk_F3]').length){
	    		$("#checkAll_F3").prop("checked", true);
	        }else{
	        	$("#checkAll_F3").prop("checked", false);
			}
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	});
	
	//자릿수
	function pad(n, width) {
		n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}

	//------------------------------------자재 입고요청(가입고)_iosc0010 모달 끝------------------------------------
	
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
	
	if (factoryCode == '003') {
		//웹 서버를 접속한다.
		var webSocket = new WebSocket("ws://localhost:8181");
		// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
		var messageTextArea = document.getElementById("installedPrinterName");
	}
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		if (factoryCode == '003') {
			toastr.success('인쇄 서버에 연결되었습니다.')
			$('#wsStateView').text('연결됨');
			$('#wsStateView').css('color','#19FF00');
		}
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		if (factoryCode == '003') {
			toastr.error('인쇄 서버가 종료되었습니다.')
			$('#wsStateView').text('연결끊김');
			$('#wsStateView').css('color','#FF0004');
		}
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		if (factoryCode == '003') {
			toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
		}
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		if (factoryCode == '003') {
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
