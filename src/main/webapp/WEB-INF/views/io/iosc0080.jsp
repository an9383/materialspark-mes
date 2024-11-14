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
				<div class="card-header card-tab">
					<ul class="nav nav-tabs card-header-tabs">
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">보류&불량</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">반품</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">실반품&자체폐기</a></li>
					</ul>
				</div>
				<div id="tab1View">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyMatrlList" class="table table-bordered">
							<colgroup>
								<col width="3%">
								<col width="7%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="5%">
								<col width="5%">
								<col width="7%">
								<col width="10%">
								<col width="9%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th style="min-width:10px" class="text-center">
										<input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10px">
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
									<th style="min-width:40px" class="text-center">가입고량</th>
									<th style="min-width:40px" class="text-center">반품량</th>								
									<th style="min-width:40px" class="text-center">불량유형</th>
									<th style="min-width:40px" class="text-center">불량비고</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="12" style="text-align:center">합계</td>
									<td id="sumPreInWhsQty" style="text-align:right">0</td>
									<td id="sumReturnQty" style="text-align:right">0</td>
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

	let menuAuth = 'iosc0080';
	let currentHref = 'iosc0080';
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
    //공통코드 처리 종료 
                     
    var serverDateFrom =  "${serverDateFrom}"; 
    var serverDateTo =  "${serverDateTo}";
	var inWhsDateFrom =  "${serverDateFrom}"; 
	var inWhsDateTo =  "${serverDateTo}"; 
	var tapTemp = 1;
	var frrrdType = '';
	var frrrdDesc = '';
	var approvalCd = '';

	$('#tab1').click(function() {
		tapTemp = 1;
		$("#checkAll").prop("checked", false);
		$('#btnUnreceived').removeClass('d-none');
		$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').removeClass('ml-5');
		$('#btnRealReturn').addClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab2').click(function() {
		tapTemp = 2;
		$("#checkAll").prop("checked", false);
		$('#btnUnreceived').removeClass('d-none');
		$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnRealReturn').removeClass('d-none');
		$('#btnDisuse').removeClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab3').click(function() {
		tapTemp = 3;
		$("#checkAll").prop("checked", false);
		$('#btnUnreceived').addClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').addClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnReturn').removeClass('ml-3');
		$('#btnReturn').addClass('ml-5');
		$('#btnRealReturn').removeClass('d-none');
		$('#btnDisuse').removeClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyMatrlList = $('#faultyMatrlList').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX: true,
        scrollY : "63vh",
        scrollCollapse: true,
        pageLength: 9999,
        ajax: {
            url: '<c:url value="/io/matrlFaultyTypeDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 	:	menuAuth,
				'inWhsDateFrom'	:	function() { return inWhsDateFrom.replace(/-/g, ''); },
				'inWhsDateTo'	:	function() { return inWhsDateTo.replace(/-/g, ''); },
				'tapTemp'		:	function() { return tapTemp; },
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
			$('#faultyMatrlList tfoot').remove();
			var sumPreInWhsQty = $('#faultyMatrlList').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumReturnQty = $('#faultyMatrlList').DataTable().column(13,{ page: 'all'} ).data().sum();
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
            },
            {
                extend: 'print',
                title: '자재 부적합현황',
            }
        ],
    });

	var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm">부적합일</label><div class="form-group input-sub m-0 row">';
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
		html1 += '<button type="button" class="btn btn-primary ml-5" id="btnUnreceived">미승인</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 " id="btnFaulty">불량</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 " id="btnHold">보류</button>';
		html1 += '<button type="button" class="btn btn-warning ml-4" id="btnReturn">반품</button>';
		html1 += '<button type="button" class="btn btn-warning ml-4 d-none" id="btnRealReturn">실반품</button>';
		html1 += '<button type="button" class="btn btn-danger ml-4 d-none" id="btnDisuse">자체폐기</button>';
		html1 += '</div>';
    
	$('#faultyMatrlList_length').html(html1);
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);
	
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

    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
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
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFrom').focus();
			return false;
		}
		
		inWhsDateFrom =  $('#chooseDateFrom').val();
		inWhsDateTo =  $('#chooseDateTo').val();
		$('#faultyMatrlList').DataTable().ajax.reload( function () {});
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
	        		console.log(checkFrrrdType.substring(i,i+1));
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
	        		console.log(checkFrrrdType.substring(i,i+1));
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
	        		console.log(checkFrrrdType.substring(i,i+1));
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
	        		console.log(checkFrrrdType.substring(i,i+1));
	    			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}
    	
		$('#frrrdPopUpModal').modal('show');
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
	        		console.log(checkFrrrdType.substring(i,i+1));
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
			rowData.menuAuth = menuAuth;
			rowData.barcode = barcode;
			rowData.approvalCd = approvalCd;
			rowData.frrrdDate = frrrdDate;	//불량&보류&반품 처리일
			rowData.frrrdType = frrrdType;	//불량&보류&반품 유형
			rowData.frrrdDesc = frrrdDesc;	//불량&보류&반품 비고
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
    
</script>

</body>
</html>
