<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- ============================================================== -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
				<li class="breadcrumb-item active">생산제품 분할&병합</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<!--  
           <div class="card top_sortbox p-3">
                <h6>기종</h6>
             <div class="row">
             <button class="btn btn-outline-primary btn-lg mr-2">PSEV</button>
             <button class="btn btn-outline-primary btn-lg mr-2 active">LIFT</button>
             <button class="btn btn-outline-primary btn-lg mr-2">P260</button>
             <button class="btn btn-outline-primary btn-lg mr-2">H200</button>
             <button class="btn btn-outline-primary btn-lg mr-2">E370</button>
          </div> 
            </div> -->
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="" style="width: 34%">
				<div class="card mb-1">
					<div class="card-body col-sm-12" style="padding: 1px;">
						<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="divisionTab">분할</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="meargeTab">병합</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div id="divisionView" class="">
					<div class="row mb-1">
						<div class="col-md-6 p-0">
							<input class="form-control mw-100" type="text" id="divisionBoxNoScan" placeholder="포장번호 SCAN" style="height: 2.2rem; font-size: 1rem;" />
						</div>
						
						<div class="col-md-6 p-0">
							<button type="button" class="btn btn-primary float-right h-100" id="btnDivisionSave" style="font-size: 15px;" disabled>분할 저장</button>
							<button type="button" class="btn btn-primary float-right h-100 mr-1" id="btnDivisionReset" style="font-size: 15px;">초기화</button>
						</div>
					</div>
					<div class="row mb-1">
						<table class="table table-bordered mb-2" id="merge_'+obj.boxNo+'">
							<colgroup>
								<col width="20%">
								<col width="30%">
								<col width="20%">
								<col width="30%">	                            
							</colgroup>
							<tbody class="thead-light">
								<tr>
								    <th>분할 포장번호</th>
								    <td>
								    	<input class="form-control mw-100" type="text" id="divisionBoxNo" disabled/>
								    </td>
								    <th>제품명</th>
								    <td>
								    	<input type="hidden" id="orignalWorkOrdNo"/>
								    	<input type="hidden" id="divisionGoodsCd"/>
								    	<input type="hidden" id="orignalPackCnt"/>
								    	<input type="hidden" id="orignalPackDtlCnt"/>
								    	<input type="hidden" id="orignalOrdGubunCd"/>
								    	<input class="form-control mw-100" type="text" id="divisionGoodsNm" disabled/>
								    </td>
								</tr>
								<tr>
								    <th>포장수량</th>
								    <td>
								    	<input class="form-control mw-100" type="text" id="divisionPackCnt" disabled/>
								    </td>
								    <th>잔여수량</th>
								    <td>
								    	<input class="form-control mw-100" type="text" id="divisionRemainCnt" disabled/>
								    </td>
								</tr>
								<tr>
									<th>오더구분</th>
								    <td>
								    	<input class="form-control mw-100" type="text" id="divisionOrdGubun" disabled/>
								    </td>
								    <th>분할수량 합</th>
								    <td>
								    	<input class="form-control mw-100" type="text" id="divisionCnt" disabled/>
								    </td>
								</tr>
								<tr>
								    <th colspan='4' class="p-0">
								    	<button type="button" class="btn btn-primary h-100" id="btnDivisionAdd" style="font-size: 15px; width: 100%;" disabled>분할박스 추가</button>
								    </th>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="row table-responsive mb-1" id="divisionBoxList" style="height: 557px;"></div>
				</div>
				<div id="meargeView" class="d-none">
					<div class="row mb-1">
						<div class="col-md-6 p-0">
							<input class="form-control mw-100" type="text" id="mergeBoxNoScan" placeholder="포장번호 SCAN" style="height: 2.2rem; font-size: 1rem;" />
						</div>
						<div class="col-md-6 p-0">
							<button type="button" class="btn btn-primary float-right h-100" id="btnMergeSave" style="font-size: 15px;" disabled>병합 저장</button>
							<button type="button" class="btn btn-primary float-right h-100 mr-1" id="btnMergeReset" style="font-size: 15px;">초기화</button>
							<select class="custom-select custom-select-md float-right h-100 mr-1" style="width: 70px" id="selOrdGubun"></select>
						</div>
					</div>
					<div class="row mb-1">
						<div class="col-md-6 p-0">
							<label style="font-size: 15px;">병합된 포장번호 : </label>
							<label style="font-size: 15px;" id="mergedBoxNo"></label>
						</div>
						<div class="col-md-6 p-0">
							<label style="font-size: 15px;">병합수량 : </label>
							<label style="font-size: 15px;" id="mergedPackCnt">0</label>
						</div>
					</div>
					<div class="row table-responsive mb-1" id="mergeBoxList" style="height: 682px;"></div>
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-70" id="myrSidenav" style="width: 65%;">
				<div class="card" id="formBox">
					<div class="card-body col-sm-12 p-0">
						<div class="row" style="margin-bottom: 10px;">
							<div class="col-sm-8 row p-0">
								&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm touch6">분할 기간</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control touch6" style="width: 120px;" type="text" id="chooseDateFrom" />
									<button	onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button" style="width:30px; height:30px;">
										<span class="oi oi-calendar" style="font-size:15px;"></span>
									</button>
								</div>
								&nbsp;&nbsp;&nbsp;<label class="input-label-sm touch6">~</label>
								<div class="form-group input-sub m-0 row">
									<input class="form-control touch6" style="width: 120px;" type="text" id="chooseDateTo" />
									<button	onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="chooseDatToCalendar" type="button" style="width:30px; height:30px;">
										<span class="oi oi-calendar" style="font-size:15px;"></span>
									</button>
								</div>
								&nbsp;&nbsp;
								<div class="form-group input-sub col-md-1 m-0 mr-2 p-0">
								<select class="custom-select custom-select-md" style="width: 120px" id="selGoodsCd">-선택-</select>
							</div>
								<button type="button" class="btn btn-primary touch6" id="btnRetv">조회</button>
							</div>
							<div class="col-sm-4 row p-0">
								<%-- <%
									if(factoryCode.equals("002")) {
								%>
								<button type="button" class="btn btn-warning float-right touch6 mr-1" id="btnPrint">스티커 인쇄1</button>
								<button type="button" class="btn btn-warning float-right touch6 mr-1 d-none" id="btnPrint3">스티커 인쇄2</button>
								<%
									} else if(factoryCode.equals("001") || factoryCode.equals("003")) {
								%>
								<button type="button" class="btn btn-warning float-right touch6 mr-1" id="btnPrint">스티커 인쇄</button>
								<%
									}
								%> --%>
								
								<button type="button" class="btn btn-warning float-right touch6 mr-1 d-none" id="btnPrint3">스티커 인쇄2</button>
								<button type="button" class="btn btn-warning float-right touch6 mr-1" id="btnPrint">스티커 인쇄</button>
								
							</div>
						</div>
					</div>
					<div id="scrollDiv" style="overflow:auto; height:720px;"> 
						<div class="col-12 row p-0 table-td-center">
							<div class="table-responsive">
								<table id="divisionBoxNoTable" class="table table-bordered">
									<colgroup>
										<col width="3%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="8%">
										<col width="13%">
										<col width="7%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="8%">
										<col width="6%">
									</colgroup>
									<thead class="thead-light">
									<tr>
										<th class="text-center">
											<input type="checkbox" id="checkAll" name="checkAll" style="width:20px; height:20px">
										</th>
										<th class="text-center">BoxNo</th>
										<th class="text-center">원장 BoxNo</th>
										<th class="text-center">병합 BoxNo</th>
										<th class="text-center">분할/병합</th>
										<th class="text-center">제품명</th>
										<th class="text-center">오더구분</th>
										<th class="text-center">포장수량</th>
										<th class="text-center">잔여수량</th>
										<th class="text-center">제품상태</th>
										<th class="text-center">제품불량</th>
										<th class="text-center">재분할</th>
										<th class="text-center">폐기 상태</th>
									</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--// 등록, 수정 -->
		</div>
		<!-- .right-sidebar -->
	</div>
	<!-- /.row -->
</div>
<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
</div>
<!-- /.app -->
<!-- 작지 추적 모달 시작-->
<div class="modal fade" id="traceBoxNoPopupModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog  modal-lg" style="min-width:900px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="traceBoxNo"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="table-responsive">
					<table id="traceBoxNoTable" class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="15%">
							<col width="16%">
							<col width="18%">
							<col width="9%">
							<col width="9%">
							<col width="9%">
							<col width="9%">
						</colgroup>
						<thead class="thead-light">
						<tr>
							<th class="text-center">제품정보</th>
							<th class="text-center">원장 BoxNo</th>
							<th class="text-center">작지번호</th>
							<th class="text-center">생산LotNo</th>
							<th class="text-center">포장수량</th>
							<th class="text-center">오더구분</th>
							<th class="text-center">제품상태</th>
							<th class="text-center">제품불량</th>
						</tr>
						</thead>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<!-- 
				<button type="button" class="btn btn-primary" id="btnPackAddCheck" data-dismiss="modal" style="min-width: 70px;">포장</button>
				<button type="button" class="btn btn btn-secondary" id="btnPackAddCheckCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>\
				 -->
			</div>
		</div>
	</div>
</div>
<!-- 작지 추적 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<script>
	
	let menuAuth = 'posc0080';
	let currentHref = 'posc0080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","생산제품 분할/병합");
	
	//공통코드 처리 시작
	var goodsCode = new Array(); // 설비분류
    <c:forEach items="${goodsCode}" var="info">
		var json=new Object();
		json.baseCd="${info.goodsCd}";
		json.baseCdNm="${info.goodsNm}";
		goodsCode.push(json);
    </c:forEach>
    
    var ordGubunCode = new Array(); // 설비분류
    <c:forEach items="${ordGubun}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    var serverDateFrom = "${serverDateFrom}";
	var serverDate = "${serverDate}";
	var factoryCode = "<%=factoryCode%>";
	
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDate);
	
    selectBoxAppend(goodsCode, "selGoodsCd", "" , "1");
    selectBoxAppend(ordGubunCode, "selOrdGubun", "" , "");
    
    if( factoryCode == "002" || factoryCode == "003") {
    	$('#selOrdGubun').addClass('d-none');
    }

  	$.fn.dataTable.ext.errMode = 'none';
	let divisionBoxNoTable = $('#divisionBoxNoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
		//scrollY : "600px",
		//lengthChange: false,
		pageLength: 10,
		ajax: {
		    url: '<c:url value="po/readDivisionGoodsPackList"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'			: 		menuAuth,
		        'goodsCd'			:		function() { return $("#selGoodsCd option:selected").val(); }, 
		    	'chooseDateFrom'	:		function() { return $("#chooseDateFrom").val().replace(/-/g, ''); },
		    	'chooseDateTo'		:		function() { return $("#chooseDateTo").val().replace(/-/g, ''); },
		    },
		},
		rowId: 'boxNo',
		columns: [
			{ 
				data: "boxNo",
				render: function(data, type, row, meta) {
					return '<input type="checkbox" class="checkBox" name="checkBox" style="width:20px; height:20px" boxNo='+data+'>';
				} 
			},
			{
				data: "boxNo",
				render: function(data, type, row, meta) {	
					if(row['disuseYn'] == 'Y') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['printYn'] == 'Y') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
			{ data: 'selBoxNo1',
				render: function(data, type, row, meta) {	
					if(data != null && data != '') {
						let splitData = data.split('/');
						let html = '';
						for(var i=0;i<splitData.length;i++) {
							if(i+1 == splitData.length) { // 마지막행일 경우
								html += splitData[i];
							} else {
								html += splitData[i] + '<br>';
							}
						}
						return html;
					} else {
						return '';
					}
				}
			},
			{ data: 'selBoxNo2',
				render: function(data, type, row, meta) {
					if(data != null && data != '') {
						let splitData = data.split('/');
						let html = '';
						for(var i=0;i<splitData.length;i++) {
							if(i+1 == splitData.length) { // 마지막행일 경우
								html += splitData[i];
							} else {
								html += splitData[i] + '<br>';
							}
						}
						return html;
					} else {
						return '';
					}
				}
			},
			{ data: 'mergeYnNm' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
			{ data: 'packCnt' },
			{ data: 'remainCnt' },
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm' },
			{
				data: "divisionYnNm",
				render: function(data, type, row, meta) {
					if(row['divisionYn'] == 'N') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else if(row['divisionYn'] == 'D') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['divisionYn'] == 'M') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
			{
				data: "disuseYnNm",
				render: function(data, type, row, meta) {
					if(row['disuseYn'] == 'N') {
						return data;
					} else if(row['disuseYn'] == 'Y') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					}
				}
			},
		],
        columnDefs: [
        	{ targets: [6,7], className: 'text-right' },
        	{ targets: [6,7] , render: $.fn.dataTable.render.number( ',' )},
        ],		
		order: [
			[ 0, 'desc' ],
		],
		//drawCallback: function () {
        //    var sum2 = $('#boxNo2Table').DataTable().column(1,{ page: 'current'} ).data().sum();           
        //    $('#sum2').html(sum2.toLocaleString());
        //},
		//분할 상태
        rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
            $($(row).find("td")[0]).attr("onclick", "event.cancelBubble=true");
        },
    });

	var traceBoxNo = "";
	$.fn.dataTable.ext.errMode = 'none';
	let traceBoxNoTable = $('#traceBoxNoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
		pageLength: 10,
		ajax: {
		    url: '<c:url value="/po/traceBoxNo"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'		: 		menuAuth,
		        'boxNo'			:		function() { return traceBoxNo },
		    },
		},
		rowId: 'boxNo',
		columns: [
			{ data: 'goodsNm' },
			{ data: 'boxNo' },
			{ data: 'workOrdNo' },
			{ data: 'workOrdLotNo' },
			{ data: 'packDtlCnt' },
			{ data: 'ordGubunNm' },
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm' },
		],
        columnDefs: [
        	{ targets: [0,1,2,3,5,6,7], className: 'text-center' },
        	{ targets: [4], className: 'text-right' },
        	{ targets: [4] , render: $.fn.dataTable.render.number( ',' )},
        ],		
		order: [
			[ 1, 'asc' ],
		],
		drawCallback: function () {
			$('#my-spinner').hide();
        },
    });
    

	$('#divisionTab').on('click', function() {
		$('#btnDivisionReset').trigger('click');
		$('#divisionView').removeClass("d-none");
		$('#meargeView').addClass("d-none");
	});

	$('#meargeTab').on('click', function() {
		$('#btnMeargeReset').trigger('click');
		$('#divisionView').addClass("d-none");
		$('#meargeView').removeClass("d-none");
	});

	$('#selGoodsCd').change(function() {
		$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
    });

	$('#btnRetv').on('click', function(){
		$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
	});

	/* --------------------------------------분할 기능 시작-------------------------------------- */
	let divisionBoxData = {}; // 분할할 포장박스 정보
	let divisionBoxList = []; // 분할포장박스 목록
	// 분할 포장 목록 HTML
	function setDivisionHtml(obj) {
		let html = '';
			html += '';
			html += '<table class="table table-bordered mb-2" id="division_'+obj.tempBoxNo+'">';
			html += '	<colgroup>';
			html += '		<col width="4%">';
			html += '		<col width="19%">';
			html += '		<col width="29%">';
			html += '		<col width="19%">';
			html += '		<col width="29%">';	                            
			html += '	</colgroup>';
			html += '	<tbody class="thead-light">';
			html += '		<tr>';
			html += '		    <th rowspan="3" onclick="btnDivisionHtmlDel(this)" data-tempboxno="'+obj.tempBoxNo+'" style="cursor: pointer;">';
			html += '		    	<i class="mdi mdi-close"></i></th>';
			html += '		    </th>';
			html += '		    <th>분할 포장번호</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100 divisionBoxNo" type="text" value="자동채번" disabled/>';
			html += '		    </td>';
			html += '		    <th>제품명</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.goodsNm+'" disabled/>';
			html += '		    </td>';
			html += '		</tr>';
			html += '		<tr>';
			html += '		    <th>포장수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.packCnt+'" disabled/>';
			html += '		    </td>';
			html += '		    <th>잔여수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.remainCnt+'" disabled/>';
			html += '		    </td>';
			html += '		</tr>';
			html += '		<tr>';
			html += '			<th>오더구분</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.ordGubunNm+'" disabled/>';
			html += '		    </td>';
			html += '		    <th>분할수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100 calDivisionValue" type="text";';
			html += '		    		data-tempboxno="'+obj.tempBoxNo+'"';
			html += '		    		onkeyup="numberFormat(this,\'int\')"';
			html += '		    		value="'+obj.divisionCnt+'" />';
			html += '		    </td>';
			html += '		</tr>';
			html += '	</tbody>';
			html += '</table>';
		return html;
	}

	// 분할번호 행삭제
	function btnDivisionHtmlDel(node) {
		$(node).parents('table').remove();
		let tempBoxNo = $(node).data('tempboxno');
		let index = divisionBoxList.findIndex(v => v.tempBoxNo == tempBoxNo);
		let divisionCnt = divisionBoxList[index].divisionCnt;
		divisionBoxList.splice(index, 1);

		// 분할수량 계산
		let divisionCntSum = 0;
		for(var i=0;i<divisionBoxList.length;i++) {
			divisionCntSum += divisionBoxList[i].divisionCnt;
		}
		$('#divisionCnt').val(parseInt(divisionCntSum));
	}
	
	//분할 포장 대상 boxNo 스캔
	$("#divisionBoxNoScan").keypress(function (e) {
		if (e.which == 13) {
        	if ( !$.trim($('#divisionBoxNoScan').val()) ) {
				toastr.warning('분할 포장번호를 입력해 주세요!');
				$('#divisionBoxNoScan').focus();
				return false;
			}
        	
        	if( factoryCode == "001" || factoryCode == "002" ) {
				if (($('#divisionBoxNoScan').val().trim().length != "13" && $('#divisionBoxNoScan').val().trim().length != "15")) {
					toastr.warning('생산제품 바코드가 아닙니다.<br>포장번호를 확인해주세요.');
					$('#divisionBoxNoScan').select();
					return false;
	            }
			} else {
				if( ($('#divisionBoxNoScan').val().trim().length != "13" && $('#divisionBoxNoScan').val().trim().length != "18") ){
					toastr.warning('생산제품 바코드가 아닙니다.<br>포장번호를 확인해주세요.');
					$('#divisionBoxNoScan').select();
					return false;
	        	}
			}
			
			$.ajax({
				url: '<c:url value="po/readDivisionMeargeBoxNo"/>',
				type: 'GET',
				async: false,
				data: {
					'menuAuth'	 	: 		menuAuth,
					'boxNo'			: 		function() { return $('#divisionBoxNoScan').val(); },
				},
				beforeSend: function() {
					$('#my-spinner').show();
				},
				success: function (res) {
					let data = res.data;
					divisionBoxData = data;
					if (res.result == 'ok') {
						$('#divisionBoxNo').val(data.boxNo);
						$('#orignalWorkOrdNo').val(data.workOrdNo);
						$('#orignalPackCnt').val(data.packCnt);
						$('#orignalPackDtlCnt').val(data.packDtlCnt);
						$('#orignalOrdGubunCd').val(data.ordGubun);
						$('#divisionGoodsCd').val(data.goodsCd);
						$('#divisionGoodsNm').val(data.goodsNm);
						$('#divisionPackCnt').val(data.packCnt);
						$('#divisionRemainCnt').val(data.remainCnt);
						$('#divisionOrdGubun').val(data.ordGubunNm);
						$('#divisionCnt').val('0');
						
						$('#divisionBoxNoScan').attr("disabled", true); // 분할 포장번호 SCAN input
						$('#btnDivisionSave').attr('disabled', false); // 분할 저장 버튼
						$('#btnDivisionAdd').attr('disabled', false); // 분할박스 추가 버튼
						
						toastr.success("분할 가능한 포장번호입니다.");
					} else if (res.result == 'fail'){
						toastr.warning(res.message);
					} else if (res.result == 'error'){
						toastr.error(res.message, {timeOut: 5000});
					}
				},
				complete:function(){
					$('#my-spinner').hide();
				}
			});
        }
    });

	// 분할박스 초기화 버튼 click
	$('#btnDivisionReset').on('click', function() {
		$('#divisionBoxNo').val('');
		$('#divisionGoodsNm').val('');
		$('#divisionPackCnt').val('');
		$('#divisionRemainCnt').val('');
		$('#divisionOrdGubun').val('');
		$('#divisionCnt').val('');

		divisionBoxData = {};
		divisionBoxList = [];
		$('#divisionBoxList').empty();
		$('#divisionBoxNoScan').attr('disabled', false); // 분할 포장번호 SCAN input
		$('#btnDivisionSave').attr('disabled', true); // 분할 저장 버튼
		$('#btnDivisionAdd').attr('disabled', true); // 분할박스 추가 버튼

		$('#divisionBoxNoScan').select(); // 분할 포장번호 SCAN input
	});

	// 분할박스 추가 버튼 click
	$('#btnDivisionAdd').on('click', function() {
		
		if( divisionBoxList.length >= 9 ) {
			toastr.warning('9개 이상 분할할 수 없습니다.');
			return false;
		}
		
		let data = {};
		data.tempBoxNo = moment().format('YYYYMMDDHHmmssSSS');
		data.goodsNm = divisionBoxData.goodsNm;
		data.packCnt = divisionBoxData.packCnt;
		data.remainCnt = divisionBoxData.remainCnt;
		data.ordGubunNm = divisionBoxData.ordGubunNm;
		data.divisionCnt = 0;
		divisionBoxList.push(data);
		$('#divisionBoxList').append(setDivisionHtml(data));
	});

	// 분할수량 수정
	$(document).on('keyup','.calDivisionValue',function() {
		let tempBoxNo = $(this).data('tempboxno');
		let divisionCnt = parseInt($(this).val());
		let divisionRemainCnt = parseInt($('#divisionRemainCnt').val());
		let index = divisionBoxList.findIndex(v => v.tempBoxNo == tempBoxNo);

		let divisionCntSum = 0; // 분할수량 합
		for(var i=0;i<divisionBoxList.length;i++) {
			divisionCntSum += divisionBoxList[i].divisionCnt;
		}
		
		//분할수량 합 = 분할수량 합 - 현재박스의 원래 분할수량 + 현재박스의 변경 후 분할수량
		divisionCntSum = divisionCntSum - parseInt(divisionBoxList[index].divisionCnt) + divisionCnt;

		if(divisionCntSum > divisionRemainCnt) {
			toastr.warning('분할수량의 합이 잔여수량을 초과합니다.');
			let prevValue = $(this).data('prev');
			$(this).data('temp', prevValue);
			$(this).val(prevValue);
			return false;
		}
		
		divisionBoxList[index].divisionCnt = divisionCnt;
		$('#divisionCnt').val(parseInt(divisionCntSum));
	});
    
	//분할 저장
	$('#btnDivisionSave').on('click', function() {
		if(divisionBoxList.length < 2) {
			toastr.warning('분할박스를 추가해주세요.');
			$('#btnDivisionAdd').focus();
			return false;
		}
		if(divisionBoxList.findIndex(v => v.divisionCnt == 0) != -1) {
			toastr.warning('분할 포장수량을 입력해주세요.');
			let index = divisionBoxList.findIndex(v => v.divisionCnt == 0);
			let tempBoxNo = divisionBoxList[index].tempBoxNo;
			$('#division_'+tempBoxNo).find('.calDivisionValue').focus();
			return false;
		}
		let divisionCntSum = 0; // 분할수량 합
		for(var i=0;i<divisionBoxList.length;i++) {
			divisionCntSum += divisionBoxList[i].divisionCnt;
		}
		if(divisionCntSum != parseInt($('#divisionRemainCnt').val())) {
			toastr.warning('분할수량의 합이 잔여수량보다 적습니다.');
			return false;
		}

		$.ajax({
			url: '<c:url value="po/createDivisionBoxNo"/>',
			type: 'POST',
			data: {
				'menuAuth'	 		: 		menuAuth,
				'boxNo'				: 		function() { return $('#divisionBoxNo').val(); },		//원장 boxNo
				'goodsCd'			: 		function() { return $('#divisionGoodsCd').val(); },		//제품번호
				'workOrdNo'			: 		function() { return $('#orignalWorkOrdNo').val(); },	//작지번호
				'packCnt'			: 		function() { return $('#orignalPackCnt').val(); },		//해당작지 포장수량1
				'packDtlCnt'		: 		function() { return $('#orignalPackDtlCnt').val(); },	//해당작지 포장수량1
				'ordGubun'			: 		function() { return $('#orignalOrdGubunCd').val(); },	//오더구분
				'orignalPackCnt'	: 		function() { return $('#divisionCnt').val(); },			//원장 분할포장수량
				'jsonArray'			:		JSON.stringify(divisionBoxList),
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				let divisionBoxNo = res.divisionBoxNo;
				if (res.result == 'ok') {
					for(var i=0;i<divisionBoxNo.length;i++) {
						let data = divisionBoxNo[i];
						$('#division_'+data.tempBoxNo).find('.divisionBoxNo').val(data.boxNo);
						$('.calDivisionValue').attr('disabled', true);
						$('#btnDivisionSave').attr('disabled', true);
						$('#btnDivisionAdd').attr('disabled', true);
					}
					
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
					toastr.success(res.message);
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if(res.result == 'lock') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message);
				}
			},
			complete:function() {
				$('#my-spinner').hide();
			}
		});
	});



	/* --------------------------------------분할 기능 끝-------------------------------------- */
	
	/* --------------------------------------병합 기능 시작 -------------------------------------- */
	let mergeBoxList = []; // 병합포장박스 목록
	// 병합 포장 목록 HTML
	function setMergeHtml(obj) {
		let html = '';
			html += '';
			html += '<table class="table table-bordered mb-2" id="merge_'+obj.boxNo+'">';
			html += '	<colgroup>';
			html += '		<col width="4%">';
			html += '		<col width="19%">';
			html += '		<col width="29%">';
			html += '		<col width="19%">';
			html += '		<col width="29%">';	                            
			html += '	</colgroup>';
			html += '	<tbody class="thead-light">';
			html += '		<tr>';
			html += '		    <th rowspan="3" onclick="btnMergeHtmlDel(this)" data-boxno="'+obj.boxNo+'" style="cursor: pointer;">';
			html += '		    	<i class="mdi mdi-close"></i></th>';
			html += '		    </th>';
			html += '		    <th>병합 포장번호</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.boxNo+'" disabled/>';
			html += '		    </td>';
			html += '		    <th>제품명</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.goodsNm+'" disabled/>';
			html += '		    </td>';
			html += '		</tr>';
			html += '		<tr>';
			html += '			<th>오더구분</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.ordGubunNm+'" disabled/>';
			html += '		    </td>';
			html += '		    <th>제품 포장수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.packUnitNm+'" disabled/>';
			html += '		    </td>';
			html += '		</tr>';
			html += '		<tr>';
			html += '		    <th>잔여수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100" type="text" value="'+obj.remainCnt+'" disabled/>';
			html += '		    </td>';
			html += '		    <th>병합수량</th>';
			html += '		    <td>';
			html += '		    	<input class="form-control mw-100 calMergeValue"';
			html += '		    		data-boxno="'+obj.boxNo+'"';
			html += '		    		onkeyup="numberFormat(this,\'int\')"';
			html += '		    		type="text" value="'+obj.remainCnt+'"/>';
			html += '		    </td>';
			html += '		</tr>';
			html += '	</tbody>';
			html += '</table>';
		return html;
	}

	// 병합번호 행삭제
	function btnMergeHtmlDel(node) {
		$(node).parents('table').remove();
		let boxNo = $(node).data('boxno');
		let index = mergeBoxList.findIndex(v => v.boxNo == boxNo);
		let packCnt = mergeBoxList[index].packCnt
		mergeBoxList.splice(index, 1);

		// 병합수량 계산
		let mergeCntSum = 0;
		for(var i=0;i<mergeBoxList.length;i++) {
			mergeCntSum += mergeBoxList[i].mergeCnt;
		}
		$('#mergedPackCnt').text(parseInt(mergeCntSum));
		
		if(mergeBoxList.length == 0) {
			$('#btnMergeSave').attr("disabled", true);
		}
	}

	// 병합수량 수정
	$(document).on('keyup','.calMergeValue',function() {
		let boxNo = $(this).data('boxno');
		let mergeCnt = parseInt($(this).val());
		let index = mergeBoxList.findIndex(v => v.boxNo == boxNo);
		let remainCnt = mergeBoxList[index].remainCnt;

		if(mergeCnt > remainCnt) {
			toastr.warning('병합수량이 잔여수량을 초과합니다.');
			let prevValue = $(this).data('prev');
			$(this).data('temp', prevValue);
			$(this).val(prevValue);
			return false;
		}
		
		mergeBoxList[index].mergeCnt = mergeCnt;

		// 병합수량 계산
		let mergeCntSum = 0;
		for(var i=0;i<mergeBoxList.length;i++) {
			mergeCntSum += mergeBoxList[i].mergeCnt;
		}
		$('#mergedPackCnt').text(parseInt(mergeCntSum));
	});

	// 숫자 표기 
	function numberFormat(node, returnType) {
		let tempValue = $(node).data('temp');
		$(node).data('prev',tempValue); // 입력하기 전 데이터 저장
		
		node.value = node.value.replace(/[^0-9\.]/g,'');
		
		if(node.value.split('.').length > 2) { // .이 두개 이상 있을 경우
			node.value = $(node).data('temp');
		} else {
			if(node.value.length != 1) { // 첫번째 입력이 아닐 경우
				if(node.value.split('.')[0].length != 1) { // 0.몇이 아닐 경우
					if(node.value.split('.')[0].slice(0,1) == '0') {
						node.value = node.value.substring(1)
					}
				}
			}
		}
		if(node.value.slice(0, 1) == '.')  { // 제일 앞 자리가 .일경우
			node.value = "0"+node.value;
		}

		if(node.value == '') { // 빈값일 경우
			node.value = '0';
		}

		if(returnType == 'int') { // int타입으로 리턴할 경우
			node.value = node.value.split('.')[0];
		} else if(returnType == 'float') { // float타입으로 리턴할 경우
			node.value = node.value;
		}
		
		
		$(node).data('temp',node.value);
	}
	
	//병합 포장번호 boxNo 스캔
	$("#mergeBoxNoScan").keypress(function (e) {
		if (e.which == 13){
			
        	if ( !$.trim($('#mergeBoxNoScan').val()) ) {
				toastr.warning('포장번호를 입력해 주세요!');
				$('#mergeBoxNoScan').focus();
				return false;
			} else if(mergeBoxList.findIndex(v => v.boxNo == $('#mergeBoxNoScan').val()) != -1) {
				toastr.warning("이미 SCAN한 포장번호입니다.");
				$('#mergeBoxNoScan').select();
				return false;
			}
			
        	if( factoryCode == '002' ) {
				if(mergeBoxList.length != 0 && mergeBoxList[0].boxNo.length != $('#mergeBoxNoScan').val().length) {
					toastr.warning("포장번호의 길이가 다릅니다.");
					$('#mergeBoxNoScan').select();
					return false;
				}
        	}
        	
        	if( factoryCode == "001" || factoryCode == "002" ) {
				if (($('#mergeBoxNoScan').val().trim().length != "13" && $('#mergeBoxNoScan').val().trim().length != "15")) {
					toastr.warning('생산제품 바코드가 아닙니다.<br>포장번호를 확인해주세요.');
					$('#mergeBoxNoScan').select();
					return false;
	            }
			} else {
				if( ($('#mergeBoxNoScan').val().trim().length != "13" && $('#mergeBoxNoScan').val().trim().length != "18") ){
					toastr.warning('생산제품 바코드가 아닙니다.<br>포장번호를 확인해주세요.');
					$('#mergeBoxNoScan').select();
					return false;
	        	}
			}
			
			$.ajax({
				url: '<c:url value="po/readDivisionMeargeBoxNo"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'boxNo'			: 		function() { return $('#mergeBoxNoScan').val(); },
				},
				beforeSend: function() {
					$('#my-spinner').show();
				},
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						if (data.packUnitNm == data.remainCnt){
							toastr.warning("해당제품 포장단위가 잔여수량과 같습니다.");
							$('#mergeBoxNoScan').select();
						} else if(mergeBoxList.length != 0 && mergeBoxList.findIndex(v => v.goodsCd == data.goodsCd) == -1) {
							toastr.warning("제품명이 같지 않습니다.");
							$('#mergeBoxNoScan').select();
						}/*  else if(mergeBoxList.length != 0 && mergeBoxList.findIndex(v => v.ordGubun == data.ordGubun) == -1) {
							toastr.warning("오더구분이 같지 않습니다.");
							$('#mergeBoxNoScan').select();
						}  */else if(mergeBoxList.reduce((a,b) => parseInt(a)+parseInt(b.remainCnt), 0)+parseInt(data.remainCnt) > parseInt(data.packUnitNm)) {
							toastr.warning("잔여수량의 합이 포장수량을 초과합니다.");
							$('#mergeBoxNoScan').select();
						} else {
							
							/* if( factoryCode == "002" || factoryCode == "003") {
								if(mergeBoxList.length != 0 && mergeBoxList.findIndex(v => v.ordGubun == data.ordGubun) == -1) {
									toastr.warning("오더구분이 같지 않습니다.");
									$('#mergeBoxNoScan').select();
									
									return false;
								}
							} */
							
							data.mergeCnt = data.remainCnt;
							mergeBoxList.push(data);
							$('#mergeBoxList').append(setMergeHtml(data));

							// 병합수량 계산
							let mergedPackCnt = $('#mergedPackCnt').text();
							$('#mergedPackCnt').text(parseInt(mergedPackCnt) + data.packCnt);
							
							$('#mergeBoxNoScan').select();

							$('#btnMergeSave').attr("disabled", false);
							
							//$('#meargeGoodsCd3').val(data.goodsCd);
							//$('#mergeGoodsNm3').val(data.goodsNm);
							//$('#mergePackCnt3').val(data.packCnt);
							//$('#goodsPackUnitNm3').val(data.packUnitNm);
							//$('#mergeOrdGubunCd3').val(data.ordGubun);
							//$('#mergeOrdGubunNm3').val(data.ordGubunNm);
							toastr.success("병합 가능한 포장번호입니다.");
						}
					} else if (res.result == 'fail'){
						toastr.warning(res.message, {timeOut: 5000});
					} else if (res.result == 'error'){
						toastr.error(res.message, {timeOut: 5000});
					}
				},
				complete:function(){
					$('#my-spinner').hide();
				}
			});
        }
    });

	//병합 저장
	$('#btnMergeSave').on('click', function(){
		if(mergeBoxList.length < 2) {
			toastr.warning('병합할 포장번호를 추가해주세요.');
			$('#mergeBoxNoScan').focus();
			return false;
		}
		let index = mergeBoxList.findIndex(v => v.mergeCnt == 0); // 병합수량이 0인 index
		if(index != -1) { // 병합수량이 0인 항목이 존재할 경우
			toastr.warning('병합수량이 0인 항목이 존재합니다.');
			$('#merge_'+mergeBoxList[index].boxNo).find('.calMergeValue').focus();
			return false;
		}
		
		for( var i=0; i < mergeBoxList.length; i++) {
			mergeBoxList[i].changeOrdGubun = $('#selOrdGubun option:selected').val(); 
		}
		
		
		$.ajax({
			url: '<c:url value="po/createMergeBoxNo"/>',
            type: 'POST',
            data: JSON.stringify(mergeBoxList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					$('#mergedBoxNo').text(data.boxNo);
					
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});

					// 초기화 후 진핼할 수 있도록 적용
					$('#mergeBoxNoScan').attr('disabled', true); // 포장번호 SCAN input
					$('#btnMergeSave').attr("disabled", true); // 병합 저장 버튼
					$('#mergeBoxList').find('.calMergeValue').attr("disabled", true); // 병합수량 input
					
					toastr.success(res.message);
				} else if ( res.result == 'fail' ){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message);
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
	});

	//병합 초기화 버튼 click
	$('#btnMergeReset').on('click', function() {
		$('#mergedBoxNo').text(''); // 병합된 포장번호
		$('#mergedPackCnt').text('0'); // 병합수량
		$('#mergeBoxNoScan').val('');
		$('#mergeBoxList').empty(); // 병합목록 초기화
		$('#mergeBoxNoScan').attr('disabled', false); // 포장번호 SCAN input
		mergeBoxList = []; // 병합목록 초기화
	});
	
	/* --------------------------------------병합 기능 끝 -------------------------------------- */

	//스티커인쇄 1
	$('#btnPrint').on('click', function() {
		if ($('input:checkbox[name=checkBox]:checked').length == 0) {
			toastr.warning("인쇄할 포장번호를 선택해 주세요!");
			return false
		}

		var printArr = new Array();
		
		$.each($('input:checkbox[name=checkBox]:checked'), function(index, item) {
			var printBoxNo = $(this).attr("boxNo");
			$.ajax({
				url : '<c:url value="po/divisionMergePrintTest"/>',
				type : 'POST',
				async: false,
				data : {
		    		'boxNo' : function(){ return printBoxNo }
				},
				success: function (res) {
					let printData = res.data;
					if (res.result == 'ok') {
						console.log(printBoxNo);
						console.log(printData);
						printArr.push(printData);
					} else {
						toastr.error(res.message);
					}
	            },
	            complete : function() {}
			});
		});
		
		labelPrint(printArr, printArr.length);		//프린터 출력 함수
		

		/* 
		url = '';
		if (factoryCode == "001") {
			url = '<c:url value="/po/divisionMergePrint"/>';
		} else if (factoryCode == "002" || factoryCode == "003") {
			url = '<c:url value="/po/divisionMergePrint_F3"/>';
		} else {
			toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
			return false;
		}
		
		$('#my-spinner').show();
		
		$.ajax({
	        url: url,
	        type: 'POST',
	        data: {
	        	'menuAuth'				: 		menuAuth,
	        	'boxNo' 				: 		boxNo,
	        	'choosePrintLocation'	:		'001',
	        },
			success: function (res) {
				if (res.result == 'ok') {
					boxNo = "";
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
					if (factoryCode == "001") {
						toastr.success("라벨이 발행되었습니다.");
					} else if (factoryCode == "002" || factoryCode == "003") {
						labelPrint(res.printList);
					} else {
						toastr.warning('잘못된 공장코드입니다.<br>관리자에게 문의해 주세요!')
						return false;
					}
				} else if (res.result == 'fail') {
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
					toastr.warning(res.message);
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		}); */
	});


	//Do printing...
	function labelPrint(printList, count) {
		printLalCnt = count;		//몇 장 출력 하는지
		printCnt	= printLalCnt;
		
		// 0 제품이름 - 1 생산전표번호 - 2 생산전표수량
		sendJson(printList);
	}
	
	function sendJson(printList) {
		
		let printNo = "";
		let company = "";
		
		if( factoryCode == '001' || factoryCode == "002" ) {
			printNo = printList[0][7].includes('N') ? '1' : printList[0][7].includes('A') ? '2' : '3';
			company = "MTP2";
		} else if( factoryCode == '003' ) {
			printNo = "2"
			company = "SLD";
		}
		
		var obj = {
			printCnt 	: printCnt,
            printLalCnt : 1,
            data 		: printList,
            paperSize 	: "productionTray",
            printOrder 	: 1,
            company 	: company,
            printType 	: "C",
            printNo 	: printNo,
            reseverd6 	: "",
            reseverd7 	: ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send)
	}

	//스티커인쇄3
	$('#btnPrint3').on('click', function() {
		if (boxNo=="" || boxNo==null) {
			toastr.warning("인쇄할 포장번호를 선택해 주세요!");
			return false
		}
		
		$('#my-spinner').show();
		
		$.ajax({
	        url: '<c:url value="po/divisionMergePrint"/>',
	        type: 'POST',
	        data: {
	        	'menuAuth'				: 		menuAuth,
	        	'boxNo' 				: 		boxNo,
	        	'choosePrintLocation'	:		'002',
	        },
			success: function (res) {
				if (res.result == 'ok') {
					boxNo = "";
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
					toastr.success("라벨이 발행되었습니다.");
				} else if (res.result == 'fail') {
					$('#divisionBoxNoTable').DataTable().ajax.reload( function () {});
					toastr.warning(res.message);
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
	});
	
    //미포장&폐기유무 확인
    var boxNo = "";
	//$('#divisionBoxNoTable tbody').on('click', 'tr', function () {
    //    if ( $(this).hasClass('selected') ) {
	//		$(this).removeClass('selected');
	//		boxNo = "";
    //    } else {
    //    	if ( divisionBoxNoTable.row(this).data().disuseYn == 'Y' ){
	//			toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
    //    	} else if ( $(this).hasClass("skyYellow") ){
	//			toastr.warning("분할된 제품은 선택하실 수 없습니다!");
    //    	} else if ( $(this).hasClass("skyBlue") ){
	//			toastr.warning("병합된 제품은 선택하실 수 없습니다!");
	//		} else {
	//        	$('#divisionBoxNoTable').DataTable().$('tr.selected').removeClass('selected');
	//        	boxNo = divisionBoxNoTable.row(this).data().boxNo;
	//            $(this).addClass('selected');
	//		}
	//	}
    //});

	//리스트 click
	function clickEvent(row, el, field){
	   	$('#divisionBoxNoTable tbody').on('click', 'tr td:not(:last-child)', function() {
	      	location.href='#';
	  	});
	}
	
	//일반 클릭과 더블클릭 이벤트 분리
	var DELAY = 500, clicks = 0, timer = null;
	$(function(){
		$('#divisionBoxNoTable tbody').on('click', 'tr', function () {

			var temp = $(this);
			clicks++;	//count clicks
			if(clicks === 1) {
				timer = setTimeout(function() {
	            	 if ( $(this).hasClass('selected') ) {
	         			$(this).removeClass('selected');
	         			boxNo = "";
	                 } else {
	                 	if ( divisionBoxNoTable.row(temp).data().disuseYn == 'Y' ){
	         				toastr.warning("폐기된 제품은 선택하실 수 없습니다!");
	                 	} else if ( $(temp).hasClass("skyYellow") ){
	         				toastr.warning("분할된 제품은 선택하실 수 없습니다!");
	                 	} else if ( $(temp).hasClass("skyBlue") ){
	         				toastr.warning("병합된 제품은 선택하실 수 없습니다!");
	         			} else {
	         	        	$('#divisionBoxNoTable').DataTable().$('tr.selected').removeClass('selected');
	         	        	boxNo = divisionBoxNoTable.row(temp).data().boxNo;
	         	            $(temp).addClass('selected');
	         			}
	         		}
	                clicks = 0;			//after action performed, reset counter
	            }, DELAY);
			} else {
				clearTimeout(timer);	//prevent single-click action

				$('#my-spinner').show();
				traceBoxNo = divisionBoxNoTable.row(this).data().boxNo;
				$('#traceBoxNo').text(traceBoxNo);
				$('#traceBoxNoTable').DataTable().ajax.reload( function () {});
				$('#traceBoxNoPopupModal').modal('show');
				
				clicks = 0;				//after action performed, reset counter
			}
	    })
		.on("dblclick", function(e){
			e.preventDefault();			//cancel system double-click event
		});
	});

    $('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[name=checkBox]").prop("checked",true); 
		} else { 
			$("input[name=checkBox]").prop("checked",false);
		}        
    }); 

    //checkBox디테일 설정
    $(document).on('click','input[name=checkBox]',function(e){
    	if($('input:checkbox[name=checkBox]:checked').length == $('input:checkbox[name=checkBox]').length){
    		$("#checkAll").prop("checked", true);
        }else{
        	$("#checkAll").prop("checked", false);
		}
	});

	/*****************************웹소켓 프린터 인쇄 시작****************************/
	/* let labelArray = new Array();
	var paperSize = null;
	var printCnt = null;
	var printOrder = null;
	var printCnt = 1;
	var printVer = "";
	var printNo = "1";
	var strPrintText = [""]; */
	
	//Do printing...
	/* function labelPrint(printList) {
		// 0 boxNo - 1 제품정보 - 2 lotNo1 - 3 lotNo2 - 4 lotNo3 - 5 TYPE	- 6 setpAvg	- 7 desc - 8 workOrdCnt - 9 packUnitNm - 10 image
	    sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
				printCnt : printList.length,
				printLalCnt : 0,
				data : printList,
				paperSize : "97_47",
				printOrder : 0,
				company : "SLD",
				reseverd4 : "",
				reseverd5 : "",
				reseverd6 : "",
				reseverd7 : ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send);
	
		printCnt = 1;
		labelArray = [];
		printVer = "";
		printNo = "1";
		paperSize = "";
		//console.log('라벨인쇄');
	} */

	/* if (factoryCode == "002" || factoryCode == '003') {
		//웹 서버를 접속한다.
		var webSocket = new WebSocket("ws://localhost:8181");
		// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
		var messageTextArea = document.getElementById("installedPrinterName");
	}
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.success('인쇄 서버에 연결되었습니다.')
			$('#wsStateView').text('연결됨');
			$('#wsStateView').css('color','#19FF00');
		}
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.error('인쇄 서버가 종료되었습니다.')
			$('#wsStateView').text('연결끊김');
			$('#wsStateView').css('color','#FF0004');
		}
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		if (factoryCode == "002" || factoryCode == '003') {
			toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
		}
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		if (factoryCode == "002" || factoryCode == '003') {
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
	} */

	/*****************************웹소켓 프린터 인쇄 끝****************************/
</script>


<script>
	//웹 서버를 접속한다.
	var webSocket = new WebSocket("ws://localhost:8181");
	// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
	var messageTextArea = document.getElementById("installedPrinterName");
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		toastr.success('인쇄 서버에 연결되었습니다.')
		$('#wsStateView').text('연결됨');
		$('#wsStateView').css('color','#19FF00');
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		toastr.error('인쇄 서버가 종료되었습니다.')
		$('#wsStateView').text('연결끊김');
		$('#wsStateView').css('color','#FF0004');
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		console.log(message);
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
