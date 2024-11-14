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
						<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">대기</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">불량</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">폐기이동</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">폐기</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">처리이력</a></li>
					</ul>
				</div>
				<div id="tab1View">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyGoodsProductList" class="table table-bordered">
							<thead class="thead-light">							
								<tr>
									<th style="min-width: 10px" class="text-center"> <input type="checkbox" id="checkAll" name="checkAll" style="width: 20px; height: 20px;"></th>
									<th class="text-center" style="min-width:20px;" id="procDay">처리일</th>
									<th class="text-center" style="min-width:20px;">입출고상태</th>
									<th class="text-center" style="min-width:20px;">제품상태</th>
									<th class="text-center" style="min-width:20px;">포장No</th>
									<th class="text-center" style="min-width:20px;">LotNo</th>
									<th class="text-center" style="min-width:20px;">제품코드</th>
									<th class="text-center" style="min-width:20px;">제품명</th>
									<th class="text-center" style="min-width:20px;">재질</th>
									<th class="text-center" style="min-width:20px;">오더구분</th>
									<th class="text-center" style="min-width:20px;">입고일</th>
									<th class="text-center" style="min-width:20px;">잔여수량</th>
									<th class="text-center" style="min-width:20px;" id="faultyDateSet">불량일</th>
									<th class="text-center" style="min-width:20px;">불량일</th>
									<th class="text-center" style="min-width:20px;">폐기일</th>
									<th class="text-center" style="min-width:20px;">불량유형</th>
									<th class="text-center" style="min-width:20px;">비고</th>
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
						<tr id="faultyTypeDisplay">
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
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 2px;">
				<label class="d-none" id="outputChk">*출하검사 의뢰된 박스는 <span style="color:blue;"><b>공정기술-재검등록</b></span>으로 이동합니다.</label>
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

	let menuAuth = 'iosc3130';
	let currentHref = 'iosc3130';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품 검사&부적합 현황");

	var chkGoodsStatus = ["006", "007", "008", "009", "010"];
    
	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>

    var faultyStatusList=new Array();	//제품불량유형
    <c:forEach items="${faultyStatusList}" var="info">
    if($.inArray("${info.baseCd}", chkGoodsStatus) == -1){
    	var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		faultyStatusList.push(json);
    }
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
		$('#faultyStatusLabel').addClass('d-none');
		$('#selFaultyStatus').addClass('d-none');
		$('#btnNormal').removeClass('d-none');
		$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnReturn').addClass('ml-3');
		$('#btnReturn').removeClass('ml-5');
		$('#btnDisuse').addClass('d-none');
		$('#btnDisuseCancel').addClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab2').click(function() {
		tapTemp = 2;
		$("#checkAll").prop("checked", false);
		$('#faultyStatusLabel').addClass('d-none');
		$('#selFaultyStatus').addClass('d-none');
		$('#btnNormal').removeClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnHold').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnDisuse').removeClass('d-none');
		$('#btnDisuseCancel').addClass('d-none');
		$('#btnRetv').trigger('click');
	});
	
	$('#tab3').click(function() {
		tapTemp = 3;
		$("#checkAll").prop("checked", false);
		//$('#btnNormal').removeClass('d-none');
		//$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		//$('#btnReturn').removeClass('d-none');
		//$('#btnReturn').removeClass('ml-3');
		//$('#btnReturn').removeClass('ml-5');
		$('#faultyStatusLabel').addClass('d-none');
		$('#selFaultyStatus').addClass('d-none');
		$('#btnNormal').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnDisuseCancel').removeClass('d-none');
		$('#btnRetv').trigger('click');
	});

	$('#tab4').click(function() {
		tapTemp = 4;
		$("#checkAll").prop("checked", false);
		//$('#btnNormal').removeClass('d-none');
		//$('#btnFaulty').removeClass('d-none');
		$('#btnHold').addClass('d-none');
		//$('#btnReturn').removeClass('d-none');
		//$('#btnReturn').removeClass('ml-3');
		//$('#btnReturn').removeClass('ml-5');
		$('#faultyStatusLabel').removeClass('d-none');
		$('#selFaultyStatus').removeClass('d-none');
		$('#btnNormal').addClass('d-none');
		$('#btnReturn').addClass('d-none');
		$('#btnFaulty').addClass('d-none');
		$('#btnDisuse').addClass('d-none');
		$('#btnDisuseCancel').addClass('d-none');
		$('#btnRetv').trigger('click');
	});

	$('#tab5').click(function() {
		tapTemp = 5;
		$("#checkAll").prop("checked", false);
		//$('#btnNormal').removeClass('d-none');
		//$('#btnFaulty').removeClass('d-none');
		$('#btnHold').removeClass('d-none');
		//$('#btnReturn').removeClass('d-none');
		//$('#btnReturn').removeClass('ml-3');
		//$('#btnReturn').removeClass('ml-5');
		$('#faultyStatusLabel').addClass('d-none');
		$('#selFaultyStatus').addClass('d-none');
	
		$('#btnFaulty').addClass('d-none');
		$('#btnDisuseCancel').addClass('d-none');		
		$('#btnNormal').removeClass('d-none');
		$('#btnReturn').removeClass('d-none');
		$('#btnDisuse').removeClass('d-none');
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
        dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
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
            url: '<c:url value="/io/goodsFaultyTypeDataList_F3"/>',
            type: 'GET',
            data: {
				'menuAuth'	 		:	menuAuth,
				'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
				'faultyDateTo'		:	function() { return faultyDateTo.replace(/-/g, ''); },
				'tapTemp'			:	function() { return tapTemp; },
				'faultyStatus'		:	function() { return tapTemp == 4 ? $('#selFaultyStatus').val() : ''; },
				'boxNo'				:	function() { return tapTemp == 4 ? $('#searchBoxNo').val() : ''; },
            },
        },
        //rowId: 'lotNo',
        columns: [
	    	{
	    		render: function(data, type, row, meta) {
					return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;">';
	    		}
			},
			{
				data: '',
				render: function(data, type, row) {
                	if(row['faultyStatus'] == '003' || row['faultyStatus'] == '004' || row['faultyStatus'] == '011' || row['faultyStatus'] == '012' || row['faultyStatus'] == '014'){
                		if(row['faultyStatusDate'] != "" && row['faultyStatusDate'] != null) {
                    		return row['faultyStatusDate'];
                        } else return "-";
					} else {
						if(row['faultyDate'] != "" && row['faultyDate'] != null) {
							return row['faultyDate'];
						} else return "-";
					} 
                } 
			},
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm',
				render: function(data, type, row) {
					var html = '';
					if( row['faultyStatus'] == '005') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if(row['faultyStatus'] == '002' && tapTemp == 4){
						html = '<p style="color:#FFA500; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if(row['faultyStatus'] == '001' && tapTemp == 4) {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if(row['faultyStatus'] == '006' && tapTemp == 5) {
						html = '<p style="margin-bottom:0px;">' + '폐기이동' + '</p>';
					} else {
						html = '<p style="margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'boxNo' },
			{ 
				data: '',
				render: function(data, type, row) {
					if(row['matrlLotNo'] != "" && row['matrlLotNo'] != null){
						return row['matrlLotNo'];
					} else "";
				}
			},
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{
				data: '',
				render: function(data, type, row) {
					if(row['qutyNm'] != "" && row['qutyNm'] != null){
						return row['qutyNm'];
					} else "";
				}
			},
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
                data: '',
                render: function(data, type, row) {
                	if(row['faultyStatus'] == '003' || row['faultyStatus'] == '004' || row['faultyStatus'] == '011' || row['faultyStatus'] == '012' || row['faultyStatus'] == '014'){
                		if(row['faultyStatusDate'] != "" && row['faultyStatusDate'] != null) {
                    		return row['faultyStatusDate'];
                        } else return "-";
					} else {
						if(row['faultyDate'] != "" && row['faultyDate'] != null) {
							return row['faultyDate'];
						} else return "-";
					} 
                } 
            },
            {
            	data: '',
                render: function(data, type, row) {
                	if(row['faultyStatus'] == '002'){
                		if(row['faultyDate'] != "" && row['faultyDate'] != null) {
							return row['faultyDate'];
						} else return "-";
					}
                } 
            },
            {
            	data: '',
                render: function(data, type, row) {
                	if(row['faultyStatus'] == '005'){
                		if(row['faultyDate'] != "" && row['faultyDate'] != null) {
							return row['faultyDate'];
						} else return "-";
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
							faultyTypeNm = '';
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
            { targets: [11], render: $.fn.dataTable.render.number( ',' )},
           	{ targets: [11], className: 'text-right' }, 
        ],
        order: [
           [1,'asc'],
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
        rowCallback: function (row, data) {
		 	if (data.disposeGubun == '003') {
				$(row).addClass('whiteRed');
		 	}
		},
        drawCallback: function () {
			if(tapTemp == 1){
				$('#faultyGoodsProductList').DataTable().column(0).visible(true);
				$('#faultyGoodsProductList').DataTable().column(1).visible(false);
				$('#faultyGoodsProductList').DataTable().column(5).visible(false);
				$('#faultyGoodsProductList').DataTable().column(6).visible(true);
				$('#faultyGoodsProductList').DataTable().column(8).visible(false);
				$('#faultyGoodsProductList').DataTable().column(9).visible(true);
				$('#faultyGoodsProductList').DataTable().column(10).visible(true);
				$('#faultyGoodsProductList').DataTable().column(11).visible(true);
				$('#faultyGoodsProductList').DataTable().column(12).visible(true);
				$('#faultyGoodsProductList').DataTable().column(13).visible(false);
				$('#faultyGoodsProductList').DataTable().column(14).visible(false);
				$('#faultyGoodsProductList').DataTable().column(15).visible(false);

				$('#searchBoxNo').addClass('d-none');
				$('#trackingYn').addClass('d-none');
				$("#inputDate").removeClass("d-none");
				$("#trackingMode").prop('checked',false);
				$('#faultyDateSet').text('부적합 판정일');
				$('#retvLabel').text('부적합 판정일');
			} else if(tapTemp == 2) {
				$('#faultyGoodsProductList').DataTable().column(0).visible(true);
				$('#faultyGoodsProductList').DataTable().column(1).visible(false);
				$('#faultyGoodsProductList').DataTable().column(5).visible(false);
				$('#faultyGoodsProductList').DataTable().column(6).visible(true);
				$('#faultyGoodsProductList').DataTable().column(8).visible(false);
				$('#faultyGoodsProductList').DataTable().column(9).visible(true);
				$('#faultyGoodsProductList').DataTable().column(10).visible(true);
				$('#faultyGoodsProductList').DataTable().column(11).visible(true);
				$('#faultyGoodsProductList').DataTable().column(12).visible(true);
				$('#faultyGoodsProductList').DataTable().column(13).visible(false);
				$('#faultyGoodsProductList').DataTable().column(14).visible(false);
				$('#faultyGoodsProductList').DataTable().column(15).visible(true);

				$('#searchBoxNo').addClass('d-none');
				$('#trackingYn').addClass('d-none');
				$("#inputDate").removeClass("d-none");
				$("#trackingMode").prop('checked',false);
				$('#faultyDateSet').text('불량일');
				$('#retvLabel').text('불량일');
			} else if(tapTemp == 3) {
				$('#faultyGoodsProductList').DataTable().column(0).visible(true);
				$('#faultyGoodsProductList').DataTable().column(1).visible(false);
				$('#faultyGoodsProductList').DataTable().column(5).visible(false);
				$('#faultyGoodsProductList').DataTable().column(6).visible(true);
				$('#faultyGoodsProductList').DataTable().column(8).visible(false);
				$('#faultyGoodsProductList').DataTable().column(9).visible(true);
				$('#faultyGoodsProductList').DataTable().column(10).visible(true);
				$('#faultyGoodsProductList').DataTable().column(11).visible(true);
				$('#faultyGoodsProductList').DataTable().column(12).visible(true);
				$('#faultyGoodsProductList').DataTable().column(13).visible(false);
				$('#faultyGoodsProductList').DataTable().column(14).visible(false);
				$('#faultyGoodsProductList').DataTable().column(15).visible(true);

				$('#searchBoxNo').addClass('d-none');
				$('#trackingYn').addClass('d-none');
				$("#inputDate").removeClass("d-none");
				$("#trackingMode").prop('checked',false);
				$('#faultyDateSet').text('폐기일');
				$('#retvLabel').text('폐기일');
			} else if(tapTemp == 5) {
				$('#faultyGoodsProductList').DataTable().column(0).visible(true);
				$('#faultyGoodsProductList').DataTable().column(1).visible(false);
				$('#faultyGoodsProductList').DataTable().column(5).visible(false);
				$('#faultyGoodsProductList').DataTable().column(6).visible(true);
				$('#faultyGoodsProductList').DataTable().column(8).visible(false);
				$('#faultyGoodsProductList').DataTable().column(9).visible(true);
				$('#faultyGoodsProductList').DataTable().column(10).visible(true);
				$('#faultyGoodsProductList').DataTable().column(11).visible(true);
				$('#faultyGoodsProductList').DataTable().column(12).visible(true);
				$('#faultyGoodsProductList').DataTable().column(13).visible(false);
				$('#faultyGoodsProductList').DataTable().column(14).visible(false);
				$('#faultyGoodsProductList').DataTable().column(15).visible(true);

				$('#searchBoxNo').addClass('d-none');
				$('#trackingYn').addClass('d-none');
				$("#inputDate").removeClass("d-none");
				$("#trackingMode").prop('checked',false);
				$('#faultyDateSet').text('폐기일');
				$('#retvLabel').text('폐기일');
			} else {
				$('#faultyGoodsProductList').DataTable().column(0).visible(false);
				$('#faultyGoodsProductList').DataTable().column(1).visible(true);
				$('#faultyGoodsProductList').DataTable().column(5).visible(true);
				$('#faultyGoodsProductList').DataTable().column(6).visible(false);
				$('#faultyGoodsProductList').DataTable().column(8).visible(true);
				$('#faultyGoodsProductList').DataTable().column(9).visible(false);
				$('#faultyGoodsProductList').DataTable().column(10).visible(false);
				$('#faultyGoodsProductList').DataTable().column(11).visible(false);
				$('#faultyGoodsProductList').DataTable().column(12).visible(false);
				$('#faultyGoodsProductList').DataTable().column(13).visible(true);
				$('#faultyGoodsProductList').DataTable().column(14).visible(true);
				$('#faultyGoodsProductList').DataTable().column(15).visible(true);

				$('#searchBoxNo').removeClass('d-none');
				$('#trackingYn').removeClass('d-none');
				$("#trackingMode").prop('checked',false);
				$('#faultyDateSet').text('처리일');
				$('#retvLabel').text('처리일');
			}
		},
    });

	var html1 = '<div class="row">';
		html1 += '<div class="row d-none" id="trackingYn"><label for="trackingMode" class="input-label-sm">추적용</label><input id="trackingMode" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-right:3px;" checked></div> ';
		html1 += '<div class="row" id="inputDate">';
		html1 += '&nbsp<label class="input-label-sm ml-1" id="retvLabel">부적합 판정일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input type="date" class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '</div>';
		html1 += '&nbsp&nbsp&nbsp<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input type="date" class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
		html1 += '</div>';	
		html1 += '</div>';	
		html1 += '<input type="text" style="width:11%" class="form-control ml-2 d-none" placeholder="박스번호를 입력해주세요." id="searchBoxNo">';
		html1 += '<label class="input-label-sm ml-3 d-none" id="faultyStatusLabel">입출고상태</label>';
		html1 += '<select class="custom-select d-none" id="selFaultyStatus"></select>';
		html1 += '<button type="button"  class="btn btn-primary ml-3" id="btnRetv">조회</button>';
		html1 += '<button type="button" class="btn btn-primary ml-5" id="btnNormal">정상</button>';
		html1 += '<button type="button" class="btn btn-primary ml-2 d-none" style="display: none;" id="btnHold">대기</button>';
		html1 += '<button type="button" class="btn btn-primary ml-2 " id="btnFaulty">불량</button>';
		html1 += '<button type="button" class="btn btn-warning ml-2" id="btnReturn">재검사</button>';
		html1 += '<button type="button" class="btn btn-danger ml-2 d-none" id="btnDisuse">폐기</button>';
		html1 += '<button type="button" class="btn btn-primary ml-5 d-none" id="btnDisuseCancel">폐기취소</button>';
		html1 += '</div>';
    
	$('#faultyGoodsProductList_length').html(html1);
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);
	selectBoxAppend(faultyStatusList, 'selFaultyStatus', '', '1');

	$("#trackingMode").on('click', function() {
        if($(this).prop("checked")) { // 체크 시
            $("#inputDate").addClass("d-none");
        } else {	// 체크해제 시
            $("#inputDate").removeClass("d-none");
        }
    })
	
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
		if (dateDiff > 92) {
			toastr.warning("검색 가능 기간은 최대 세달입니다!");
			$('#chooseDateFrom').focus();
			return false;
		}
		
		faultyDateFrom =  $('#chooseDateFrom').val();
		faultyDateTo =  $('#chooseDateTo').val();

		if($("#trackingMode").prop("checked")) { // 추적용
			if($("#searchBoxNo").val().trim() == '') {
				toastr.warning("한 가지 이상의 조회조건을 입력해주세요!");
				return false;
			}
			faultyDateFrom =  '2000-01-01';
			faultyDateTo=  '2099-12-31';
			$('#faultyGoodsProductList').DataTable().ajax.reload( function () { $("#trackingMode").prop("checked", true); });
		}else $('#faultyGoodsProductList').DataTable().ajax.reload( function () {});
    });	

    $('#selFaultyStatus').on('change',function(){
    	$('#btnRetv').trigger('click');
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
    	approvalCd = '001';
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

    	$('#faultyTypeDisplay').removeClass('d-none');
    	$('#outputChk').addClass('d-none');
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
    	
    	$('#faultyTypeDisplay').removeClass('d-none');
    	$('#outputChk').addClass('d-none');
        $('#faultyPopUpModal').modal('show');
    });
    
    //출하검사의뢰
    $('#btnReturn').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("출하검사를 의뢰할 제품을 선택해주세요!");
			return false;
		}
		if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("출하검사 의뢰는 한건씩만 가능합니다!");
			return false;
		}
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDateTo);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('출하검사 의뢰');
		$('#faultyDateLabel').text('검사의뢰일');
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
	        		console.log(checkFaultyType.substring(i,i+1));
	    			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", true);
	    		}
	        }
    	}

    	approvalCd = '013';

    	$('#faultyTypeDisplay').addClass('d-none');
    	$('#outputChk').removeClass('d-none');
		$('#faultyPopUpModal').modal('show');
    });

	//폐기
	$('#btnDisuse').on('click', function() {
		if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("폐기 처리할 제품을 선택해주세요!");
			return false;
		}
		/* if ($('input[name=chk]:checked').length > 1) {
			toastr.warning("폐기제품 상태변경은 한건씩만 가능합니다!");
			return false;
		} */
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

    	$('#faultyTypeDisplay').removeClass('d-none');
    	$('#outputChk').addClass('d-none');
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
		//검사반품(출하검사의뢰)
		} else if (approvalCd == '013') {
			updateGoodsFaultyStatus("013");
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
		let mergeCheck = true;

		
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
				rowData.faultyDate = getTodayDateTime();
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
			//폐기일경우
			if (faultyStatus == '005') {
				disposeGubun = '004';
			}
			checkbox.each(function(i) {
				var tr		= checkbox.parent().parent().eq(i);
				var td		= tr.children();
				var rowData = new Object();
				var boxNo	= td.eq(3).text();
				
				let mergeData = faultyGoodsProductList.row(this.parentNode.parentNode).data().mergeYn;
				
				rowData.menuAuth		= menuAuth;
				rowData.boxNo			= boxNo;
				rowData.faultyStatus	= faultyStatus;
				rowData.faultyDate		= $('#faultyDate').val() + ' ' + getTodayTime();
				rowData.faultyType		= faultyType;
				rowData.faultyDesc		= faultyDesc;
				rowData.disposeGubun	= disposeGubun;				

				if( mergeData == "D" || mergeData == "M" ) {
					mergeCheck = false;
					//return false;
				}
				
				dataArray.push(rowData);
				checkboxCnt += 1;
			});
		}
		
		if( approvalCd == '013' && !mergeCheck ){
			toastr.warning('분할&병합된 제품은 출하검사의뢰를 진행할 수 없습니다.<br>관리자에게 문의해주세요.');
			$('#my-spinner').hide();
			return false;
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
                    	toastr.success("불량 처리되었습니다.");
					} else if ( approvalCd == '013' ){
                    	toastr.success("출하검사가 의뢰되었습니다.");
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

	//폐기 취소
    $('#btnDisuseCancel').on('click',function(){
        if($('input[type=checkbox][name=chk]:checked').length != 1){
			toastr.warning('폐기취소할 제품을 하나 선택해주세요.');
			return false;
        }
        
    	$('#my-spinner').show();
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		approvalCd == '002'
		let disposeGubun = '';
		checkbox.each(function(i) {
			var rowCnt = $('input[name=chk]:checked').attr('id').replace("chk-", "");
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			var rowData = new Object();
			var boxNo = td.eq(3).text();
			rowData.menuAuth = menuAuth;
			rowData.boxNo = boxNo;
			rowData.faultyStatus = '002'
			rowData.faultyDate = getTodayDateTime();
			rowData.faultyType = $('#faultyGoodsProductList').DataTable().row(rowCnt).data().faultyType;
			rowData.faultyDesc = $('#faultyGoodsProductList').DataTable().row(rowCnt).data().faultyDesc;
			rowData.disposeGubun = disposeGubun;
			dataArray.push(rowData);
			checkboxCnt += 1;
		});

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
                    
                   	toastr.success("폐기취소 되었습니다.");
					
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
    });

    function getTodayDateTime(){
		var today = new Date();

		var year = today.getFullYear();
		var month = ('0' + (today.getMonth() + 1)).slice(-2);
		var day = ('0' + today.getDate()).slice(-2);

		var dateString = year + '-' + month  + '-' + day;
		
		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 

		var timeString = hours + ':' + minutes  + ':' + seconds;

		return dateString + " " + timeString;
	}

    function getTodayTime(){
		var today = new Date();

		var hours = ('0' + today.getHours()).slice(-2); 
		var minutes = ('0' + today.getMinutes()).slice(-2);
		var seconds = ('0' + today.getSeconds()).slice(-2); 

		var timeString = hours + ':' + minutes  + ':' + seconds;

		return timeString;
	}
    
</script>

</body>
</html>
