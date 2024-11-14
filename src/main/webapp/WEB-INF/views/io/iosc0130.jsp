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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품 검사&부적합 현황</li>
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
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">대기&검사반품</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">불량</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">폐기</a></li>
					</ul>
				</div>
				<div id="tab1View">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyGoodsProductList" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="7%">
								<col width="7%">
								<col width="10%">
								<col width="5%">
								<col width="10%">
								<col width="5%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="15%">
								<col width="20%">
							</colgroup>
							<thead class="thead-light">							
								<tr>
									<th style="min-width: 10px" class="text-center"> <input type="checkbox" id="checkAll" name="checkAll" style="width: 20px; height: 20px;"></th>
									<th class="text-center">입출고상태</th>
									<th class="text-center">제품상태</th>
									<th class="text-center">포장No</th>
									<th class="text-center">제품코드</th>
									<th class="text-center">제품명</th>
									<th class="text-center">오더구분</th>
									<th class="text-center">입고일</th>
									<th class="text-center">잔여수량</th>
									<th class="text-center">불량일</th>
									<th class="text-center">불량유형</th>
									<th class="text-center">비고</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->
<!-- 대기&반품&실반품&폐기 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="faultyPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="faultyPopUpLabel">불량 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<table id="faultyPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="faultyDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="faultyDate" name="faultyDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="faultyDescLabel"></th>
							<td>
								<input type="text" id="faultyDesc" name="faultyDesc" style="max-width: 100%;" class="form-control" maxlength="255"/>
							</td>
						<tr>
						<th id="faultyTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${goodsFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="faultyType${item.baseCd}" style="zoom:1.8;"></div>	
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
<!-- 대기&불량&반품&실반품&폐기 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0130';
	let currentHref = 'iosc0130';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품 검사&부적합 현황");
    
	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료 
                     
    var serverDateFrom =  "${serverDateFrom}"; 
    var serverDateTo =  "${serverDateTo}";
	var faultyDateFrom =  "${serverDateFrom}"; 
	var faultyDateTo =  "${serverDateTo}"; 
	var tapTemp = 1;
	var faultyType = '';
	var faultyDesc = '';
	var approvalCd = '';

	$('#tab1').click(function() {
		tapTemp = 1;
		$("#checkAll").prop("checked", false);
		$('#btnNormal').removeClass('d-none');
		$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').removeClass('ml-5');
		$('#btnDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab2').click(function() {
		tapTemp = 2;
		$("#checkAll").prop("checked", false);
		$('#btnNormal').removeClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnDisuse').removeClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab3').click(function() {
		tapTemp = 3;
		$("#checkAll").prop("checked", false);
		$('#btnNormal').removeClass('d-none');
		$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnReturn').removeClass('ml-3');
		$('#btnReturn').removeClass('ml-5');
		$('#btnDisuse').addClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyGoodsProductList = $('#faultyGoodsProductList').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/io/goodsFaultyTypeDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		:	menuAuth,
				'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
				'faultyDateTo'		:	function() { return faultyDateTo.replace(/-/g, ''); },
				'tapTemp'			:	function() { return tapTemp; },
            },
        },
        //rowId: 'lotNo',
        columns: [
	    	{
	    		render: function(data, type, row, meta) {
					return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;">';
	    		}
			},
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm',
				render: function(data, type, row) {
					var html = '';
					if( row['faultyStatus'] == '005') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else {
						html = '<p style="margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'boxNo' },
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
            {
                data: 'goodsInDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'remainCnt' },
            {
                data: 'faultyDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            {
				data: 'faultyType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += goodsFaultyType[jj].baseCdNm + ', ';
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
            { data: 'faultyDesc' },
        ],
        columnDefs: [
            { targets: [8], render: $.fn.dataTable.render.number( ',' )},
           	{ targets: [8], className: 'text-right' }, 
        ],
        order: [
            [ 9, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품 검사&부적합 현황',
            },
            {
                extend: 'excel',
                title: '제품 검사&부적합 현황',
            },
            {
                extend: 'print',
                title: '제품 검사&부적합 현황',
            }
        ],
    });

	var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm" id="label">검사반품일</label><div class="form-group input-sub m-0 row">';
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
		html1 += '<button type="button" class="btn btn-primary ml-5" id="btnNormal">정상</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 " id="btnHold">대기</button>';
		html1 += '<button type="button" class="btn btn-warning ml-4" id="btnReturn">검사 반품</button>';
		html1 += '<button type="button" class="btn btn-primary ml-4 " id="btnFaulty">불량</button>';
		html1 += '<button type="button" class="btn btn-danger ml-4 d-none" id="btnDisuse">폐기</button>';
		html1 += '</div>';
    
	$('#faultyGoodsProductList_length').html(html1);
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);
	
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
		
		faultyDateFrom =  $('#chooseDateFrom').val();
		faultyDateTo =  $('#chooseDateTo').val();
		$('#faultyGoodsProductList').DataTable().ajax.reload( function () {});
    });	

    $('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}
    });    

	//정상
	$('#btnNormal').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("정상처리할 제품을 선택해주세요!");
    		return false;
        }
        
		updateGoodsFaultyStatus("001");
	});

    //불량
    $('#btnFaulty').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("불량 처리할 제품을 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("불량제품 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDateTo);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('불량 처리');
		$('#faultyDateLabel').text('불량일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('불량유형');

        //선택한 제품 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFaultyType = faultyGoodsProductList.row(rowCount).data().faultyType;
    	let checkFaultyDesc = faultyGoodsProductList.row(rowCount).data().faultyDesc;
    	$('#faultyDesc').val(checkFaultyDesc);
    	if (checkFaultyType != null && checkFaultyType != '') {
	    	for (let i=0; i<goodsFaultyType.length; i++) {
	    		if (checkFaultyType.substring(i,i+1) == '1') {
	        		//console.log(checkFaultyType.substring(i,i+1));
	    			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}

    	approvalCd = '002';
        	
		$('#faultyPopUpModal').modal('show');
    });

    //대기
    $('#btnHold').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("대기 처리할 제품을 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("대기제품 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		//선택해제
    	for (let i=0; i<goodsFaultyType.length; i++) {
    		$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
        }
    	
    	$('#faultyDate').val(serverDateTo);
    	$('#faultyDesc').val('');
        $('#faultyPopUpLabel').text('대기 처리');
        $('#faultyDateLabel').text('대기일');
        $('#faultyDescLabel').text('비고');
        $('#faultyTypeLabel').text('대기유형');

        //선택한 제품 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFaultyType = faultyGoodsProductList.row(rowCount).data().faultyType;
    	let checkFaultyDesc = faultyGoodsProductList.row(rowCount).data().faultyDesc;
    	$('#faultyDesc').val(checkFaultyDesc);
    	if (checkFaultyType != null && checkFaultyType != '') {
	    	for (let i=0; i<goodsFaultyType.length; i++) {
	    		if (checkFaultyType.substring(i,i+1) == '1') {
	        		console.log(checkFaultyType.substring(i,i+1));
	    			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}

    	approvalCd = '004';
        
        $('#faultyPopUpModal').modal('show');
    });
    
    //검사 반품
    $('#btnReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("검사 반품 처리할 제품을 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("검사 반품 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDateTo);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('반품 처리');
		$('#faultyDateLabel').text('반품일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('반품유형');

        //선택한 제품 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFaultyType = faultyGoodsProductList.row(rowCount).data().faultyType;
    	let checkFaultyDesc = faultyGoodsProductList.row(rowCount).data().faultyDesc;
    	$('#faultyDesc').val(checkFaultyDesc);
    	if (checkFaultyType != null && checkFaultyType != '') {
	    	for (let i=0; i<goodsFaultyType.length; i++) {
	    		if (checkFaultyType.substring(i,i+1) == '1') {
	        		console.log(checkFaultyType.substring(i,i+1));
	    			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}

    	approvalCd = '003';
    	
		$('#faultyPopUpModal').modal('show');
    });

	//폐기
	$('#btnDisuse').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("폐기 처리할 제품을 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("폐기제품 상태변경은 한건씩만 가능합니다!");
			return false;
		}
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDateTo);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('폐기 처리');
		$('#faultyDateLabel').text('폐기일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('폐기유형');

        //선택한 제품 불량유형, 비고 자동세팅
        let rowCount =$('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFaultyType = faultyGoodsProductList.row(rowCount).data().faultyType;
    	let checkFaultyDesc = faultyGoodsProductList.row(rowCount).data().faultyDesc;
    	$('#faultyDesc').val(checkFaultyDesc);
    	if (checkFaultyType != null && checkFaultyType != '') {
	    	for (let i=0; i<goodsFaultyType.length; i++) {
	    		if (checkFaultyType.substring(i,i+1) == '1') {
	        		console.log(checkFaultyType.substring(i,i+1));
	    			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}

    	approvalCd = '005';
        
		$('#faultyPopUpModal').modal('show');
    });

	//불량&대기&반품등록 저장 클릭 시
	//불량유형 선택항목 1 미선택 0
	$('#btnFaultySave').on('click', function() {
		//정상
		if (approvalCd == '001') {
			updateGoodsFaultyStatus("001");
		//불량
		} else if (approvalCd == '002') {
			updateGoodsFaultyStatus("002");
		//검사반품
		} else if (approvalCd == '003') {
			updateGoodsFaultyStatus("003");
		//대기
		} else if (approvalCd == '004') {
			updateGoodsFaultyStatus("004");
		//폐기
		} else if (approvalCd == '005') {
			updateGoodsFaultyStatus("005");
		}
	});
	
	//$('#faultyGoodsProductList tbody').on('click', 'tr', function () {
    //    if ( $(this).hasClass('selected') ) {
    //        $(this).removeClass('selected');
    //    }
    //    else {
    //    	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
    //        $(this).addClass('selected');
    //    }
    //});

	function updateGoodsFaultyStatus(faultyStatus)
    {
		$('#my-spinner').show();
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var faultyDate = $('#faultyDate').val().replace(/-/g, '');
		var faultyDesc = $('#faultyDesc').val();
		var faultyType = '';
		let disposeGubun = '';

		//정상제품일경우
		if (faultyStatus == '001') {
			checkbox.each(function(i) {
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				var rowData = new Object();
				var boxNo = td.eq(3).text();
				rowData.menuAuth = menuAuth;
				rowData.boxNo = boxNo;
				rowData.faultyStatus = faultyStatus;
				rowData.faultyDate = '';
				rowData.faultyType = '';
				rowData.faultyDesc = '';
				rowData.disposeGubun	= disposeGubun;
				dataArray.push(rowData);
				checkboxCnt += 1;
			});

		//정상처리 외
		} else {
			for (let i=0; i<goodsFaultyType.length; i++) {
				if($('#faultyType' + goodsFaultyType[i].baseCd).prop("checked")) {
					faultyType += '1';
				} else {
					faultyType += '0';
				}
			}
			
			checkbox.each(function(i) {
				var tr = checkbox.parent().parent().eq(i);
				var td = tr.children();
				var rowData = new Object();
				var boxNo = td.eq(3).text();
				rowData.menuAuth = menuAuth;
				rowData.boxNo = boxNo;
				rowData.faultyStatus = faultyStatus;
				rowData.faultyDate = faultyDate;
				rowData.faultyType = faultyType;
				rowData.faultyDesc = faultyDesc;
				rowData.disposeGubun	= disposeGubun;
				dataArray.push(rowData);
				checkboxCnt += 1;
			});
		}
		
		//console.log(dataArray);
		
        $.ajax({
        	url : '<c:url value="/po/changeGoodsProductFaultyType"/>',
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
                    if ( approvalCd == '001' ){
                    	toastr.success("정상제품으로 처리되었습니다.");
					} else if ( approvalCd == '002' ){
                    	toastr.success("검사 반품 처리되었습니다.");
					} else if ( approvalCd == '003' ){
                    	toastr.success("불량 처리되었습니다.");
					} else if ( approvalCd == '004' ){
                    	toastr.success("대기 처리되었습니다.");
					} else if ( approvalCd == '005' ){
                    	toastr.success("폐기 처리되었습니다.");
					}
            		$('#faultyGoodsProductList').DataTable().ajax.reload( function () {
            			$("#checkAll").prop("checked", false);
                	});
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
    }

    $('#faultyGoodsProductList tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#faultyGoodsProductList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
    
</script>

</body>
</html>
