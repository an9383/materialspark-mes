<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<% String userNm = session.getAttribute("userNm").toString(); %>
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">엣지검사</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid" id="mainCard">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width:60%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="workOrderOutputSub" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">검사일</th>
									<th style="min-width: 50px">설비명</th>
									<th style="min-width: 80px">규격</th>
									<th style="min-width: 100px">생산전표번호</th>
									<!-- <th style="min-width: 100px">작지번호</th> -->
									<th style="min-width: 40px" class="text-center">검사량</th>
									<th style="min-width: 55px" class="text-center">샘플링수량</th>
									<th style="min-width: 50px" class="text-center">불량수량</th>
									<th style="min-width: 40px" class="text-center">불량률</th>
									<th style="min-width: 40px">검사자</th>
								</tr>
							</thead>
							<tfoot>
								<!-- <tr class="thead-light"> -->
								<tr>
									<th colspan="4" style="text-align: center">합계</th>
									<td id="userInputInspctCntSum" style="text-align: right">0</td>
									<td id="sampleCntSum" style="text-align: right">0</td>
									<td id="edgeFaultyCntSum" style="text-align: right">0</td>
									<td id="faultyPercent" style="text-align: right">0%</td>
									<th></th>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 39%;">
				<div class="card">
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="rightCardClose" class="closebtn float-right"><i class="mdi mdi-close"></i></a>
						</div>
						<!-- 
						<button type="button" class="btn btn-primary float-left touch6" id="openFullScreen">전체화면</button>
						<button type="button" class="btn btn-primary float-left touch6" id="closeFullScreen">전체화면 해제</button>
						 -->
						<button type="button" class="btn btn-primary float-right touch6" id="btnEdit" disabled>수정</button>
						<button type="button" class="btn btn-primary float-right touch6" id="btnAdd">등록</button>
					</div>
					<form id="form">
						<table class="table table-bordered">
							<colgroup>
								<col width="22%">
								<col width="28%">
								<col width="22%">
								<col width="28%">
							</colgroup>
							<tr>
								<th class="touch6">검사일</th>
								<td><input type="date" class="form-control touch6" id="edgeInspctDate" name="edgeInspctDate" disabled></td>
								<th class="touch6">생산작업자<!-- 생산 근무조 --></th>
								<td>
									<!-- 
									<input type="hidden" class="form-control touch6" id="workTeamCd" disabled>
									<input type="text" class="form-control touch6" id="workTeamNm" disabled>
									 -->
									 <input type="text" class="form-control touch6" id="mainWorkChargrNm" disabled>
								</td>
							</tr>
							<tr>
								<th class="touch6">제품(기종)</th>
								<td><input type="text" class="form-control touch6" id="goodsNm" name="goodsNm" disabled></td>
								<th class="touch6">검사담당</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" id="userNumber" name="edgeInspctCharger">
										<input type="text" class="form-control touch6" id="userNm" name="userNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search-md" id="searchUser" onClick="selectPreWorkCharger()" disabled>
											<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
										</button>
									</div>
								</td>
							</tr>
							<tr>
							<tr>
								<th class="touch6">재질</th>
								<td><input type="text" class="form-control touch6" id="qutyNm" name="qutyNm" disabled></td>
								<th class="touch6">생산수량</th>
								<td><input type="text" class="form-control text-right touch6" id="outputCnt" name="outputCnt" disabled></td>
							</tr>
							<tr>
								<th class="touch6">작지 번호</th>
								<td><input type="text" class="form-control touch6" id="workOrdNo" name="workOrdNo" disabled></td>
								<th class="touch6">실 검사수량</th>
								<td><input type="text" class="form-control number text-right touch6" id="userInputInspctCnt" name="userInputInspctCnt" disabled></select></td>
							</tr>
							<tr>
								<th class="touch6">주재료(MetalLot)</th>
								<td><input type="text" class="form-control touch6" id="lotNo" name="lotNo" disabled></td>
								<th class="touch6">Sample 수량</th>
								<td><select class="custom-select custom-select-lg touch6" id="edgeSampleCnt" disabled></select></td>
								<!-- <td><input maxlength="7" type="text" class="form-control number text-right touch6" id="edgeSampleCnt" 	name="edgeSampleCnt" min="0" disabled></td> -->
							</tr>
							<tr>
								<th class="touch6">생산전표번호 상태</th>
								<td><select class="custom-select custom-select-lg touch6" id="subWorkStatusCd" disabled></select></td>
								<th class="touch6">불량수량</th>
								<td><input maxlength="7" type="text" class="form-control number text-right touch6" id="edgeFaultyCnt" name="edgeFaultyCnt" min="0" disabled></td>
							</tr>
							<!-- <tr>
								<th colspan="3" class="touch6">엣지홀 불량</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeRollFaultySize" name="edgeRollFaultySize" style="max-width: 100%" disabled></td>
							</tr>
							<tr>
								<th colspan="3" class="touch6">엣지기포 불량</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeSymbolFaultySize" name="edgeSymbolFaultySize" style="max-width: 100%" disabled></td>
							</tr>
							<tr>
								<th colspan="3" class="touch6">Bur 불량</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeBurFaultySize" name="edgeBurFaultySize" style="max-width: 100%" disabled></td>
							</tr> -->
							<tr>
								<input type="hidden" id="subWorkStatusCd" name="subWorkStatusCd">
								<input type="hidden" id="packYn" name="packYn">
								<th colspan="2" class="touch6">생산전표번호</th>
								<td colspan="2"><input type="text" class="form-control touch6" id="ordLotNo" name="ordLotNo" style="max-width: 100%" disabled></td>
							</tr>
						</table>
						
						<!--엣지 불량 테이블 -->
						<div class="row col-sm-12">
							<div class="card-header card-tab col-md-9">
								<ul class="nav nav-tabs card-header-tabs">
									<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="tab1">...</a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">...</a></li>
								</ul>
							</div>
						</div>
						
						<!-- (대) 불량 1 -->
						<div id="faultyDiv1">
							<table class="table table-bordered exam">
								<colgroup>
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="faultyTbody1">
									
								</tbody>
							</table>
						</div>
						<!-- (대) 불량 1 끝 -->
						<!-- (대) 불량 2 -->
						<div id="faultyDiv2" class="d-none">
							<table class="table table-bordered exam">
								<colgroup>
									
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
									<col width="11%">
								</colgroup>
								<tbody id="faultyTbody2">
									
								</tbody>
							</table>
						</div>
						<!-- (대) 불량 2 끝 -->						
						<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnSave" disabled>저장</button>
						<br>
						<br>
						<div class="col-12 num_keypad">
							<table class="table table-bordered" >                                
								<tr>
									<td id="number5" style="height:1px; width:100px;">5</td>
									<td id="number6" style="height:1px; width:100px;">6</td>
									<td id="number7" style="height:1px; width:100px;">7</td>
									<td id="number8" style="height:1px; width:100px;">8</td>
									<td id="number9" style="height:1px; width:100px;">9</td>
									<td id="backSpace" style="height:1px; width:100px;">←<br>(BS)</td>
								</tr>
								<tr>
									<td id="number0" style="height:59px; width:100px;">0</td>
									<td id="number1" style="height:59px; width:100px;">1</td>
									<td id="number2" style="height:59px; width:100px;">2</td>
									<td id="number3" style="height:59px; width:100px;">3</td>
									<td id="number4" style="height:59px; width:100px;">4</td>
									<td id="enter" style="height:59px; width:100px;">ENT</td>
								</tr>
							</table>
						</div>
					
					</form>
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

<!-- 담당자조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="userPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width: 1300px">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="userPopUpLabel">검사 담당</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="overflow: auto;">
				<hr class="text-secondary">
				<table id="userPopUpTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th style="min-width: 50px">담당자</th>
							<th style="min-width: 50px">부서명</th>
							<th style="min-width: 50px">직위</th>
							<th style="min-width: 50px">담당업무</th>
							<th style="min-width: 50px">근무조</th>
							<th style="min-width: 50px">사업장</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 담당자조회 모달 종료-->
<!-- 입력 취소 확인 모달 시작 -->
<div class="modal fade" id="closePopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">진행정보 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>입력하던 정보가 있습니다. 닫으시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnCloseCheck" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				<button type="button" class="btn btn btn-secondary" id="btnCloseCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 입력 취소 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "60%"
			}, 200);
			$("#myrSidenav").animate({
				width : "39%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'qmsc0050';
	let currentHref = 'qmsc0050';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","엣지검사");

  	//공통코드 처리 시작
    var workStatusCode=new Array();
    <c:forEach items="${workStatusCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workStatusCode.push(json);
    </c:forEach>

    var sampleCountCode=new Array();
    <c:forEach items="${sampleCount}" var="info">
	var json=new Object();
	json.baseCd="${info.baseCd}";
	json.baseCdNm="${info.baseCdNm}";
	sampleCountCode.push(json);
	</c:forEach>

	var edgeBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${edgeBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		edgeBigNameCd.push(json);
    </c:forEach>
  	
	var edgeSmallName=new Array();	//엣지검사 소분류
    <c:forEach items="${edgeSmallName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		edgeSmallName.push(json);
    </c:forEach>
	//공통코드 처리 종료
	
	$('#tab1').text(edgeBigNameCd[0].baseCdNm);
	$('#tab2').text(edgeBigNameCd[1].baseCdNm);
	
	$('#tab1').click(function(){	
		$('#faultyDiv1').removeClass("d-none");
		$('#faultyDiv2').addClass("d-none");
	});
	
	$('#tab2').click(function(){
		$('#faultyDiv1').addClass("d-none");
		$('#faultyDiv2').removeClass("d-none");
	});

	metalFaultyHdCreate();
    filmFaultyHdCreate();
	
	$('#openFullScreen').css('margin-right','5px');
	$('#closeFullScreen').css('margin-right','5px');
	$('#btnAdd').css('margin-right','5px');
	$('#btnEdit').css('margin-right','5px');

	//전체화면(f11)감지
    $(window).resize(function () {
        if ((screen.availHeight || screen.height - 30) <= window.innerHeight) {
        	$('#mainCard').css('height','915px');
        	//$('#rightList').css('min-height','915px');
        }
        else {
        	$('#mainCard').css('height','775px');
        	//$('#rightList').css('min-height','765px');
        }
    });

    var userNm = "<%=userNm%>";
	var serverDate = "${serverDate}"	//서버 날짜
	var chooseDate =  serverDate;		//선택 날짜
	var sideView = null;
	var readCheck = true;	//작지 클릭여부 상태갑
	$('#btnSave').attr('disabled', true);
	$('#btnedit').attr('disabled', true);
	selectBoxAppend(workStatusCode, "subWorkStatusCd", "" , "1");
	selectBoxAppend(sampleCountCode, "edgeSampleCnt", "" , "2");
	
    // 목록
    // 엣지검사일 기준으로 검색
    $.fn.dataTable.ext.errMode = 'none';
	let workOrderOutputSub = $('#workOrderOutputSub').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/qm/workOrderOutputSubList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 	menuAuth,
	           	'edgeInspctDate'	: 	function() { return chooseDate.replace(/-/g, ''); },
            },
        },
        rowId: 'ordLotNo',
        columns: [
			{
				render: function(data, type, row) {
					return moment(row['edgeInspctDate']).format("YYYY-MM-DD");
				}
			},
            { data: 'equipNm' },
            { data: 'model' },
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
            { data: 'userInputInspctCnt' },
            { data: 'edgeSampleCnt' },
            { data: 'edgeFaultyCnt' },
            {
				render: function(data, type, row) {
					return row['faultyPercent'] + ' %';
				}
			},
            { data: 'edgeInspctChargerNm' },
        ],
        columnDefs: [
        	{ targets: [4,5,6,7] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [4,5,6,7] , "className": "text-right"}
        ],
        buttons: [
            {
                extend: 'copy',
                title: '엣지검사',
            },
            {
                extend: 'excel',
                title: '엣지검사',
                exportOptions: {
					format: {
						body: function(data, column, row, node) {
							if (row == 7) {
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
                title: '엣지검사',
            },
        ],
		drawCallback: function () {
			let userInputInspctCntSum = $('#workOrderOutputSub').DataTable().column(4,{ page: 'all'} ).data().sum();
			let sampleCntSum = $('#workOrderOutputSub').DataTable().column(5,{ page: 'all'} ).data().sum();
			let edgeFaultyCntSum = $('#workOrderOutputSub').DataTable().column(6,{ page: 'all'} ).data().sum();
			let faultyPercent = edgeFaultyCntSum / sampleCntSum * 100.0;
			$('#userInputInspctCntSum').text(addCommas(userInputInspctCntSum));
			$('#sampleCntSum').text(addCommas(sampleCntSum));
			$('#edgeFaultyCntSum').text(addCommas(edgeFaultyCntSum));
			$('#faultyPercent').text(faultyPercent.toFixed(2) + ' %');
		},
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
    });

    var sysdate = "${serverTime}";
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm touch6">엣지검사일</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control touch6" style="width:120px;" type="text" id="calender" name="calender" />';
	html1 += '<button onclick="fnPopUpCalendar(calender,calender,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button" style="width:30px; height:30px;">';
	html1 += '<span class="oi oi-calendar" style="font-size: 15px;"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary touch6" id="btnRetv">조회</button>'
	html1 += '</div>';
	$('#workOrderOutputSub_length').html(html1);
	$('.dataTables_filter').addClass("touch6");		//검색필터 크기조정
	
	$('#calender').val(serverDate);
	$("#ordLotNo").focus();

	//조회 버튼 클릭시
	$('#btnRetv').on('click', function() {
		chooseDate = $('#calender').val();
		//alert(chooseDate);
		//function() { return equipCd; }
		$('#workOrderOutputSub').DataTable().ajax.reload();
	});

	//작지번호 스캔시
	$("#ordLotNo").keypress(function (e) {
        if (e.which == 13){
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng($.trim($('#ordLotNo').val()));
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#ordLotNo').val(engToKor.toUpperCase());

	    	if (!$.trim($('#ordLotNo').val())) {
	            toastr.warning('생산전표번호를 스캔해 주세요!');
	            $('#edgeInspctCharger').focus();
	            return false;
	        }

        	$.ajax({
            	//url: '<c:url value="qm/barcodeScan"/>',
            	url: '<c:url value="qm/scanWorkOrdOutputSubOrdLotNo"/>',
                type: 'GET',
                data: {
                	'menuAuth'	 	: 		menuAuth,
                	'ordLotNo'		:		function() { return $('#ordLotNo').val(); },
                },
                success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						if (data == null) {
							toastr.warning("검색 결과가 없습니다.");
							$('#btnSave').attr('disabled', true);
						//} else if (data.subWorkStatusCd == 'B') {
						//	toastr.warning("해당 작지는 미발행 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						//} else if (data.subWorkStatusCd == 'P') {
						//	toastr.warning("해당 작지는 발행 상태 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						//} else if (data.subWorkStatusCd == 'S') {
						//	toastr.warning("해당 작지는 진행 상태 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						} else if (data.subWorkStatusCd == 'C' || data.subWorkStatusCd == 'S') {
							$('#workOrdNo').val(data.workOrdNo);
							$('#goodsNm').val(data.goodsNm);
							$('#qutyNm').val(data.qutyNm);
							$('#workTeamCd').val(data.workTeamCd);
							$('#workTeamNm').val(data.workTeamNm);
							$('#outputCnt').val(addCommas(data.totalCnt));
							$('#userInputInspctCnt').val(addCommas(data.workOrdLotNoTotalCnt));
							$('#subWorkStatusCd').val(data.subWorkStatusCd);
							$('#mainWorkChargrNm').val(data.mainWorkChargrNm);
							$('#lotNo').val(data.lotNo);
							if (readCheck) {
								$('#searchUser').focus();
						    } else {
						    	$('#userInputInspctCnt').focus();
						    }
							$('#edgeFaultyCnt').val("0");
							/*$('#edgeRollFaultySize').val("0");
							$('#edgeSymbolFaultySize').val("0");
							$('#edgeBurFaultySize').val("0");*/
							//$('#workStatusCd').val("G");
							$('#btnSave').attr('disabled', false);
							$('#ordLotNo').attr('disabled', true);
							$('#edgeSampleCnt').attr('disabled', false);
							$('#edgeFaultyCnt').attr('disabled', false);
							/*$('#edgeRollFaultySize').attr('disabled', false);
							$('#edgeSymbolFaultySize').attr('disabled', false);
							$('#edgeBurFaultySize').attr('disabled', false);*/
							$('#userInputInspctCnt').attr('disabled', false);
							$('#edgeFaultyCnt').attr('disabled', true);

							$('.num_only').attr('disabled', false);
							$(".num_only").val("0");
							if ($('#userNumber').val() == '') {
								$('#searchUser').focus();
							} else {
								$('#edgeFaultyCnt').select();
							}
							
							toastr.success("스캔되었습니다.<br>실 검사수량을 확인해주세요!");
						} else if (data.subWorkStatusCd == 'E') {
							toastr.warning("해당 작지는 외관검사 대상 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						} else if (data.subWorkStatusCd == 'G') {
							//toastr.warning("해당 작지는 외관검사 대상 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						} else if (data.subWorkStatusCd == 'A') {
							toastr.warning("해당 작지는 종료(외관검사 완료) 작지입니다. 생산전표번호를 확인해주세요!", '', {timeOut: 5000});
						} else {
							toastr.warning("알수없는 생산전표번호 상태값입니다. 관리자에게 문의해주세요!<br>ErrorType-qmsc0050_001-" + data.subWorkStatusCd, '', {timeOut: 5000});
						}
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				}
			});
		}
    });

	//엣지검사 상세보기
	$('#workOrderOutputSub tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('.num_only').attr('disabled', true);
			$('#workOrderOutputSub').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			sideView = "";
			var data = workOrderOutputSub.row(this).data();
			let ordLotNo = data.ordLotNo;
			$('#edgeInspctDate').attr('disabled', true);
			
			$.ajax({
				url: '<c:url value="/qm/readWorkOrderOutputSub"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'ordLotNo'		:		ordLotNo,
				},
				success: function (res) {
					let data = res.data;
					if( res.result == 'ok' ){
						$('#edgeInspctDate').val(moment(data.edgeInspctDate).format('YYYY-MM-DD'));
						$('#goodsNm').val(data.goodsNm);
						$('#userNm').val(data.edgeInspctChargerNm);
						$('#userNumber').val(data.edgeInspctCharger);
						$('#qutyNm').val(data.qutyNm);
						$('#edgeSampleCnt').val(data.edgeSampleCnt);
						$('#ordLotNo').val(data.ordLotNo);
						$('#lotNo').val(data.lotNo);
						$('#workOrdNo').val(data.workOrdNo);
						$('#lotNo').val(data.lotNo);
						$('#userInputInspctCnt').val(addCommas(data.userInputInspctCnt));
						$('#edgeFaultyCnt').val(addCommas(data.edgeFaultyCnt));
						$('#workOrdNo').val(data.workOrdNo);
						$('#outputCnt').val(addCommas(data.totalCnt));
						$('#mainWorkChargrNm').val(data.mainWorkChargrNm);
						/*$('#edgeRollFaultySize').val(addCommas(data.edgeRollFaultySize));
						$('#edgeSymbolFaultySize').val(addCommas(data.edgeSymbolFaultySize));
						$('#edgeBurFaultySize').val(addCommas(data.edgeBurFaultySize));
						*/
						//작업상태가 엣지가 G, 외관검사가 A -> 이미 외관검사가 끝난 제품을 엣지검사 수정할때 A로 고정하기 위해
						$('#subWorkStatusCd').val(data.subWorkStatusCd);
						$('#packYn').val(data.packYn);
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					//외관불량 TB 상세조회
	 		        $.ajax({
	 		        	url: '<c:url value="qm/readEdgeGoodsFaultyAdmCode"/>',
	 		            type: 'GET',
	 		            data: {
	 		            	'menuAuth'	 	: 		menuAuth,
	 		            	//'workOrdNo'		:		workOrdNo,		//작업지시
	 		            	'ordLotNo'		:		$('#ordLotNo').val(),		//생산LorNo
	 		            },
	 		            success: function (res) {
	 		                let data = res.data;
	 		                if (res.result == 'ok') {
	 		                	$(".num_only").val("0");
	 		                	var i = 0;
	 		                	$.each($('.num_only'), function(index1,item1) {
	 		                		if(data.length > i) {
	 		                			$.each(data, function(index2,item2) {
		 		                			if ($(item1).parent().find('input[type=hidden]').val() == item2.minorCd) {
		 		                				$(item1).val(item2.faultyCnt);
			 		                			i++;
				 		                	}
			 		                	});      		
	 		                		}
	    	   					});	    	   							 		                              	
	 		                	searchData = true;
	 						} else if (res.result == 'fail') {
	 		                	toastr.warning(res.message, '', {timeOut: 5000});
	 		                	searchData = false;
	 						} else if (res.result == 'error') {
	 		                	toastr.error(res.message, '', {timeOut: 5000});
	 		                	searchData = false;
	 						}
	 					},
	 					complete:function() {
	 						$('#btnSave').attr('disabled', true);
	 						$('#btnEdit').attr('disabled', false);
	 						$('#ordLotNo').attr('disabled', true);
	 						$('#searchUser').attr('disabled', true);
	 						$('#edgeSampleCnt').attr('disabled', true);
	 						$('#edgeFaultyCnt').attr('disabled', true);
	 						$('#searchUser').attr('edgeFaultyCnt', true);
	 						//$('#edgeRollFaultySize').attr('disabled', true);
	 						//$('#edgeSymbolFaultySize').attr('disabled', true);
	 						//$('#edgeBurFaultySize').attr('disabled', true);
	 						$('#userInputInspctCnt').attr('disabled', true);
	 						$('#subWorkStatusCd').val(data.subWorkStatusCd);
	 						if ($('#packYn').val() == 'Y') {
	 							$('#btnEdit').attr('disabled', true);
	 							toastr.warning('포장된 제품으로 조회만 가능합니다!','', {timeOut: 2000});
	 						} else if ($('#subWorkStatusCd').val() == 'A') {
	 							toastr.warning('외관검사가 진행된 제품입니다!','', {timeOut: 2000});
	 						}
	 						readCheck = true;					
	 					}
	 				});
	 				
				}
			});
		}
	});
	
	//저장 버튼 클릭시
	$('#btnSave').on('click', function() {
		totalDefectiveChange();
        if ( !$.trim($('#ordLotNo').val()) ) {
            toastr.warning('생산전표번호를 스캔하세요.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#ordLotNo').val()) ) {
            toastr.warning('생산전표번호가 검색되지 않았습니다.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#qutyNm').val()) ) {
            toastr.warning('재질이 검색되지 않았습니다.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품(기종)이 검색되지 않았습니다.');
            $('#ordLotNo').focus();
            return false;
        }
        if ( !$.trim($('#userNumber').val()) ) {
            toastr.warning('검사담당을 선택해 주세요!');
            $('#searchUser').focus();
            return false;
        }
        if (!$.trim($('#userInputInspctCnt').val()) || $('#userInputInspctCnt').val() == '0' || $('#userInputInspctCnt').val() == '00') {
            toastr.warning('실 검사수량을 입력해 주세요!');
            $('#userInputInspctCnt').select();
            return false;
        }
        if ( !$.trim($('#edgeFaultyCnt').val()) ) {
            toastr.warning('불량수량을 입력하세요.');
            $('#edgeFaultyCnt').select();
            return false;
        }
		if ( !$.trim($('#edgeSampleCnt').val()) ) {
            toastr.warning('Sample 수량을 선택해주세요.');
            $('#edgeSampleCnt').focus();
            return false;
        }
		//if ( parseInt($('#edgeSampleCnt option:selected').val()) < parseInt($('#edgeFaultyCnt').val()) ) {
        //    toastr.warning('불량수량이 Sample수량보다 클 수 없습니다.');
        //    $('#edgeFaultyCnt').select();
        //    return false;
        //}
        //if ( parseInt($('#outputCnt').val().replace(/,/g, '')) < parseInt($('#edgeSampleCnt').val().replace(/,/g, '')) ) {
        //    toastr.warning('Sample수량이 생산수량보다 많습니다 확인해주세요.');
        //    $('#edgeSampleCnt').select();
        //    return false;
        //}
        if ( parseInt($('#userInputInspctCnt').val().replace(/,/g, '')) < parseInt($('#edgeFaultyCnt').val().replace(/,/g, '')) ) {
            toastr.warning('불량수량이 실 검사수량보다 많습니다. 확인해주세요!');
            $('#edgeFaultyCnt').select();
            return false;
        }/*
        if ( !$.trim($('#edgeRollFaultySize').val()) ) {
            toastr.warning('엣지홀 불량에 0이상 입력해주세요.');
            $('#edgeRollFaultySize').select();
            return false;
        }
        if ( !$.trim($('#edgeSymbolFaultySize').val()) ) {
            toastr.warning('엣지기호 불량에 0이상 입력해주세요.');
            $('#edgeSymbolFaultySize').select();
            return false;
        }
        if ( !$.trim($('#edgeBurFaultySize').val()) ) {
            toastr.warning('Bur 불량에 0이상 입력해주세요.');
            $('#edgeBurFaultySize').select();
            return false;
        }*/
		var numCheck = false;
        
		$.each($('input.num_only'), function(index,item) {
			if (!$.trim($(this).val())) {
				$(this).focus();
				numCheck = true;
				return false;
			}
		});
		
		if (numCheck) {
			toastr.warning('수량을 입력하세요.');
			return false;
		}
		

        $('#my-spinner').show();
		
		var dataArray = new Array();

		//불량 1
		$.each($('#faultyTbody1 .num_only'), function() {
			if($(this).val() != '0' && $(this).val() != '00') {
				var rowData = new Object();				
				rowData.menuAuth             = menuAuth;
				rowData.edgeInspctDate       = $('#edgeInspctDate').val().replace(/-/g,"");
				rowData.ordLotNo             = $('#ordLotNo').val();							//작지번호스캔(작업지시)
				//rowData.edgeRollFaultySize   = $('#edgeRollFaultySize').val();					//엣지홀 불량 치수
				//rowData.edgeSymbolFaultySize = $('#edgeSymbolFaultySize').val(),				//엣지기호 불량 치수
				//rowData.edgeBurFaultySize    = $('#edgeBurFaultySize').val(),					//Bur불량 치수
				rowData.edgeInspctCharger    = $('#userNumber').val(),							//검사담당(사번코드)
            	rowData.userInputInspctCnt   = removeCommas($('#userInputInspctCnt').val()); 				//실 검사수량
            	rowData.edgeSampleCnt        = $('#edgeSampleCnt option:selected').val();		//샘플 수량
            	rowData.edgeFaultyCnt        = $('#edgeFaultyCnt').val().replace(/,/g, '');	//불량 수량
            	rowData.subWorkStatusCd	     = $('#subWorkStatusCd').val();		

				rowData.workOrdNo            = $('#workOrdNo').val();
				rowData.lotNo                = $('#lotNo').val();

            	
            	rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");
            	rowData.majorCd 				= '001';												//	대분류 코드
				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
				dataArray.push(rowData);
			}
		});

		//불량 2
		$.each($('#faultyTbody2 .num_only'), function() {
			if($(this).val() != '0' && $(this).val() != '00'){	
				var rowData = new Object();
				rowData.menuAuth             = menuAuth;
				rowData.edgeInspctDate       = $('#edgeInspctDate').val().replace(/-/g,"");
				rowData.ordLotNo             = $('#ordLotNo').val();							//작지번호스캔(작업지시)
				//rowData.edgeRollFaultySize   = $('#edgeRollFaultySize').val();					//엣지홀 불량 치수
				//rowData.edgeSymbolFaultySize = $('#edgeSymbolFaultySize').val(),				//엣지기호 불량 치수
				//rowData.edgeBurFaultySize    = $('#edgeBurFaultySize').val(),					//Bur불량 치수
				rowData.edgeInspctCharger    = $('#userNumber').val(),							//검사담당(사번코드)
            	rowData.userInputInspctCnt   = removeCommas($('#userInputInspctCnt').val()); 				//실 검사수량
            	rowData.edgeSampleCnt        = $('#edgeSampleCnt option:selected').val();		//샘플 수량
            	rowData.edgeFaultyCnt        = $('#edgeFaultyCnt').val().replace(/,/g, '');	//불량 수량
            	rowData.subWorkStatusCd	     = $('#subWorkStatusCd').val();		

            	rowData.workOrdNo            = $('#workOrdNo').val();
				rowData.lotNo                = $('#lotNo').val();
            	
            	rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");
            	rowData.majorCd 				= '002';												//	대분류 코드
				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
				dataArray.push(rowData);
			}
		});
		if(dataArray.length == 0){
			var rowData = new Object();
			rowData.menuAuth             = menuAuth;
			rowData.edgeInspctDate       = $('#edgeInspctDate').val().replace(/-/g,"");
			rowData.ordLotNo             = $('#ordLotNo').val();							//작지번호스캔(작업지시)
			//rowData.edgeRollFaultySize   = $('#edgeRollFaultySize').val();					//엣지홀 불량 치수
			//rowData.edgeSymbolFaultySize = $('#edgeSymbolFaultySize').val(),				//엣지기호 불량 치수
			//rowData.edgeBurFaultySize    = $('#edgeBurFaultySize').val(),					//Bur불량 치수
			rowData.edgeInspctCharger    = $('#userNumber').val(),							//검사담당(사번코드)
        	rowData.userInputInspctCnt   = removeCommas($('#userInputInspctCnt').val()); 				//실 검사수량
        	rowData.edgeSampleCnt        = $('#edgeSampleCnt option:selected').val();		//샘플 수량
        	rowData.edgeFaultyCnt        = $('#edgeFaultyCnt').val().replace(/,/g, '');	//불량 수량
        	rowData.subWorkStatusCd	     = $('#subWorkStatusCd').val();		

        	rowData.workOrdNo            = $('#workOrdNo').val();
			rowData.lotNo                = $('#lotNo').val();
        	
        	rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");
        	rowData.majorCd = '001';
			rowData.minorCd = '001';
			rowData.faultyCnt = '0';			
			dataArray.push(rowData);
		}

        var url = null;
        if (sideView == "add") {
        	url = '<c:url value="/qm/edgeCheckInsert"/>';
		} else if ( sideView == "edit" ){
			url = '<c:url value="/qm/edgeCheckUpdate"/>';
		}

        $('#my-spinner').show();
		
        $.ajax({
        	url: url,
            type: 'POST',
            data: JSON.stringify(dataArray),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",	
            /* data: {
            	'menuAuth'	 			: 		menuAuth,
            	'edgeInspctDate'		:		$('#edgeInspctDate').val().replace(/-/g,""),
            	'ordLotNo'				:		$('#ordLotNo').val(),							//작지번호스캔(작업지시)
            	'edgeRollFaultySize'	:		$('#edgeRollFaultySize').val(),					//엣지홀 불량 치수
            	'edgeSymbolFaultySize'	:		$('#edgeSymbolFaultySize').val(),				//엣지기호 불량 치수
            	'edgeBurFaultySize'		:		$('#edgeBurFaultySize').val(),					//Bur불량 치수
            	'edgeInspctCharger'		:		$('#userNumber').val(),							//검사담당(사번코드)
            	'userInputInspctCnt'	:		function() { return removeCommas($('#userInputInspctCnt').val()); },					//실 검사수량
            	'edgeSampleCnt'			:		$('#edgeSampleCnt option:selected').val(),		//샘플 수량
            	'edgeFaultyCnt'			:		$('#edgeFaultyCnt').val().replace(/,/g, ''),	//불량 수량
            	'subWorkStatusCd'		:		$('#subWorkStatusCd').val(),					
            }, */
            success: function (res) {
                let data = res.data;
                if( res.result == 'ok' ){
    				$('#workOrderOutputSub').DataTable().ajax.reload();
    				$('#edgeSampleCnt').attr('disabled', true);
    				$('#edgeFaultyCnt').attr('disabled', true);
    				$('#tempaturBtnSave').attr('disabled', true);
    				$('#ordLotNo').attr('disabled', true);
    				$('#searchUser').attr('disabled', true);
    				$('#btnSave').attr('disabled', true);
    				$('#edgeInspctDate').attr('disabled',true);
    				/*$('#edgeRollFaultySize').attr('disabled', true);
    				$('#edgeSymbolFaultySize').attr('disabled', true);
    				$('#edgeBurFaultySize').attr('disabled', true);*/
    				$('#userInputInspctCnt').attr('disabled', true);
    				$('.num_only').attr('disabled', true);
    				toastr.success(res.message);
	            } else if ( res.result == 'fail' ){
                	toastr.warning(res.message, '', {timeOut: 5000});
	            } else if ( res.result == 'error' ){
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			},
			complete:function(){
				//if($('#subWorkStatusCd').val() == 'A'){
				//	toastr.warning('!','외관검사도 수정해 주세요', {timeOut: 5000});
				//}
				totalDefectiveChange();
				readCheck = false;
				$('#my-spinner').hide();
			}
		});
	});

	//등록 버튼 클릭시
	$('#btnAdd').on('click', function() {
		viewDisabled(false);
		viewValueClear();
		//$('#edgeInspctDate').val(serverDate);
		$('#edgeSampleCnt').attr('disabled', true);
		$('#edgeFaultyCnt').attr('disabled', true);
		/*$('#edgeRollFaultySize').attr('disabled', true);
		$('#edgeSymbolFaultySize').attr('disabled', true);
		$('#edgeBurFaultySize').attr('disabled', true);*/
		$('#tempaturBtnSave').attr('disabled', false);
		$('#edgeInspctDate').attr('disabled',false);
		$("#btnEdit").attr("disabled",true);
		$('#ordLotNo').focus();
		$("#userInputInspctCnt").attr("disabled",true);
		sideView = "add";
		$(".num_only").val("0");
		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#edgeInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#edgeInspctDate').val(yesterday);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#edgeInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "edgeInspctDate", "D", "");
		}
	});
	
	//수정 버튼 클릭시
	$('#btnEdit').on('click', function() {
		if($('#subWorkStatusCd').val() == 'A'){
			toastr.warning('해당 제품은 외관검사가 완료된 제품입니다!', '', {timeOut: 5000});
		}
		viewDisabled(false);
		$("#btnSave").attr("disabled",false);
		$("#ordLotNo").attr("disabled",true);
		$('#edgeInspctDate').attr('disabled',false);
		$('#edgeFaultyCnt').attr('disabled',true);
		$('.num_only').attr('disabled', false);
		sideView = "edit";
	});

	$('#edgeSampleCnt').keypress(function (event) { 
		if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8 && event.which != 13) {
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
		}
		if ( event.which == 13 ){
			$('#edgeFaultyCnt').focus();
		}
	});
	$('#edgeFaultyCnt').keypress(function (event) { 
		if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8 && event.which != 13) {
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
		}
		//if ( event.which == 13 ){
		//	$("#btnSave").trigger("click");
		//}
	});

	//담당자조회 팝업 시작
	var userPopUpTable;
	function selectPreWorkCharger()
	{
	     if(userPopUpTable == null || userPopUpTable == undefined)   {
	        userPopUpTable = $('#userPopUpTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/matrlUserDataList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                },
	                /*
	                success : function(res) {
	                    console.log(res);
	                }
	                */
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'}, 
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			$('#userPopUpTable tbody').on('click', 'tr', function () {
	            var data = userPopUpTable.row( this ).data();
	            $('#userNm').val(data.userNm);	//사원명
	            $('#userNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userPopUpModal').modal('hide');  
	            $('#edgeSampleCnt').focus();
			});
		} else {
			$('#userPopUpTable').DataTable().ajax.reload( function () {});
		}
			
     	$('#userPopUpModal').modal('show');   
     }
    //담당자조회 팝업 종료

    //View값 초기화
    function viewValueClear(){
		$('#edgeInspctDate').val(null);
		$('#workTeamCd').val(null);
		$('#goodsNm').val(null);
		if ( readCheck ) {
			$('#userNumber').val(null);
			$('#userNm').val(null);
		}
		$('#qutyNm').val(null);
		$('#edgeSampleCnt').val(null);
		$('#ordLotNo').val(null);
		$('#edgeFaultyCnt').val(null);
		$('#ordLotNo').val(null);
		$('#outputCnt').val(null);
		$('#workOrdNo').val(null);
		$('#lotNo').val(null);
		$('#userInputInspctCnt').val('0');
		$('#subWorkStatusCd').val(null);
		/*$('#edgeRollFaultySize').val(null);
		$('#edgeSymbolFaultySize').val(null);
		$('#edgeBurFaultySize').val(null);*/
	}

	//버튼 클릭 제한
	function viewDisabled(flag)
	{
		$("#searchUser").attr("disabled",flag);
		$("#searchUser").attr("disabled",flag);
		$("#edgeSampleCnt").attr("disabled",flag);
		$("#edgeFaultyCnt").attr("disabled",flag);
		//$("#edgeRollFaultySize").attr("disabled",flag);
		//$("#edgeSymbolFaultySize").attr("disabled",flag);
		//$("#edgeBurFaultySize").attr("disabled",flag);
		$("#edgeRollFaultySize").attr("disabled",flag);
		$("#edgeSymbolFaultySize").attr("disabled",flag);
		$("#edgeBurFaultySize").attr("disabled",flag);
		$("#ordLotNo").attr("disabled",flag);
		$("#userInputInspctCnt").attr("disabled",flag);
	}

	$(".number").keyup(function(evt) {
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			$(this).select();
			toastr.warning('최대 수치를 초과하였습니다.');
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}
		
        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let temp = $(this).val().replace(/,/g, '');
    	if (reg.test(temp)) {
    		toastr.warning("숫자만 입력해 주세요.")
    		$(this).val("0");
			$(this).select();
    		return false;
    	}
    	
        var charCode = (evt.which) ? evt.which : event.keyCode;
		//toastr.warning(charCode);
		if ( !(	(charCode > 36 && charCode < 41) || (charCode > 47 && charCode < 58) || (charCode > 95 && charCode < 106) || ( charCode == 8 || charCode == 9 || charCode == 13 || charCode == 46 || charCode == 110 || charCode == 190)	)	){
			toastr.warning("숫자만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		// 1000 이하의 숫자만 입력가능
		//var _pattern1 = /^\d{4}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
		//if (_pattern1.test(costUnit)) {
		//	toastr.warning("1000이하로 입력가능합니다.")
	    //	$(this).val($(this).val().slice(0,-1));
	    //    return false;
		//}

		// 소수점(.)이 두번 이상 나오지 못하게
		var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		if (_pattern0.test(temp)) {
			toastr.warning("정수만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
		}
		//else {
		//	if ( charCode == 110 || charCode == 190 ) {
		//		toastr.warning(".는 한번만 입력 가능합니다.")
		//		$(this).val(	addCommas(temp.slice(0,-1))	);
		//		return false;
        //    }
		//}
		
		// 소수점 첫째자리까지만 입력가능
		//var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
		//if (_pattern2.test(costUnit)) {
		//	toastr.warning("소수점 첫째자리까지 입력가능합니다.")
		//	$(this).val(	addCommas(costUnit.slice(0,-1))	);
		//	return false;
		//}
		
		//if( parseInt(temp) > parseInt($("#outputCnt").val().replace(/,/g, ''))){
		//	toastr.warning("입력값이 생산수량을 초과 할 수 없습니다.");
		//	$(this).val("0");
		//	$(this).select();
		//	return false;
		//}
		
		$(this).val(addCommas(temp));
    });

	//전체화면	
    $('#openFullScreen').on('click', function(){
    	openFullScreenMode();
    });

	//전체화면 해제
    $('#closeFullScreen').on('click', function(){
    	closeFullScreenMode();
    });

	$('#btnCloseCheck').on('click', function(){
		$('#closePopupModal').modal('hide');
		{
			$("#left-list").animate({
				width : "99%"
			}, 0);
			$("#myrSidenav").animate({
				width : "0%"
			}, 0, function(){
				$('#arrowLeft').css('display', 'block');
			});
		}
	});

	//rightList 닫기 버튼
	$('#rightCardClose').on('click', function(){
		if( sideView == 'add' || sideView == 'edit' ){
			$('#closePopupModal').modal('show');
			return false;
		}
  	  	$("#left-list").animate({
			width : "99%"
		}, 200);
		$("#myrSidenav").animate({
			width : "0%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'block');
		});
	});

	$('#arrowLeft').on('click', function(){
  	  	$("#left-list").animate({
			width : "60%"
		}, 200);
		$("#myrSidenav").animate({
			width : "39%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'none');
		});
	});

	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}
	// 불량 테이블 생성
	function metalFaultyHdCreate(){   			
    	var Hd_metal	= '';  
    	var Hd_metal1	= '<tr>';
    	var Hd_metal2	= '<tr>';
		var arrayLength = 0;
    	
    	$.each(edgeSmallName, function(index,item){				
    		if(item.etc1 == '001'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metal'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="metalCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	}
        	}
		});
		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

		$('#faultyTbody1').html(Hd_metal); 	
	}

	//불량 테리블 2 생성
	function filmFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(edgeSmallName, function(index,item){				
    		if(item.etc1 == '002'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

           
		$('#faultyTbody2').html(Hd_metal); 	
	}
	//총 불량품
	function totalDefectiveChange(){
		var badTotal1 = 0;
		var badTotal2 = 0;
		for(var i=0; i<$('#faultyTbody1 tr td').length; i++){
		    if($('#faultyTbody1 tr td').eq(i).find('input').val() != 0){
		    	badTotal1 = parseInt(badTotal1) + parseInt($('#faultyTbody1 tr td').eq(i).find('input').val());
		    }
		}
		/*for(var i=0; i<$('#faultyTbody2 tr td').length; i++){
		    if($('#faultyTbody2 tr td').eq(i).find('input').val() != 0){
		    	badTotal2 = parseInt(badTotal2) + parseInt($('#faultyTbody2 tr td').eq(i).find('input').val());
		    }
		}*/
		//$('#badTotal1').text(addCommas(badTotal1));
		//$('#badTotal2').text(addCommas(badTotal2));
		$('#edgeFaultyCnt').val( addCommas( parseInt(badTotal1) ) );
    }
	//외관불량수량 입력 키보드
	let tagId = "";
	let temp = "";
	$('.num_only').focusout(function() {
		tagId = $(this).attr('id');
	});

	$('#number0').on('click', function () {
		let temp = $('#'+tagId).val();		
		if (temp == "0"){
			$('#'+tagId).val("0");
		} else{
			$('#'+tagId).val(temp.concat("0"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number1').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("1");
		} else{
			$('#'+tagId).val(temp.concat("1"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number2').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("2");
		} else{
			$('#'+tagId).val(temp.concat("2"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number3').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("3");
		} else{
			$('#'+tagId).val(temp.concat("3"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number4').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("4");
		} else{
			$('#'+tagId).val(temp.concat("4"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number5').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("5");
		} else{
			$('#'+tagId).val(temp.concat("5"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number6').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("6");
		} else{
			$('#'+tagId).val(temp.concat("6"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number7').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("7");
		} else{
			$('#'+tagId).val(temp.concat("7"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number8').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("8");
		} else{
			$('#'+tagId).val(temp.concat("8"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number9').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("9");
		} else{
			$('#'+tagId).val(temp.concat("9"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number0, #number1, #number2, #number3, #number4, #number5, #number6, #number7, #number8, #number9').on('click', function(){
		if ($('#edgeOutputCnt').attr("maxlength") < $('#edgeOutputCnt').val().length) {
			$('#edgeOutputCnt').val($('#edgeOutputCnt').val().substring(0, $('#edgeOutputCnt').attr("maxlength")));
			$('#edgeOutputCnt').val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			event.preventDefault();
		}
 		if ( parseFloat($('#edgeOutputCnt').attr("max")) < parseFloat($('#edgeOutputCnt').val())) {
 			$('#edgeOutputCnt').val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
			event.preventDefault();
		}
	});
	//백스페이스
	$('#backSpace').on('click', function () {
		let temp = $('#'+tagId).val();
		temp = temp.slice(0,-1); //문자
		$('#'+tagId).val(temp);
		$(".num_only").trigger("keyup");
	});

	$('.num_only').on('click', function() {
		$(this).select();
	});
	let idStr = '';
	//엔터
	$('#enter').on('click', function () {
		//해당아이디 엔터 강제이벤트로 가기
			$.each($('#faultyTbody1 .num_only'), function(index, item) {
				if ( tagId ==  $(this).attr('id') ){
					try{
						idStr = '#' + $('#faultyTbody1').find('td').eq(index+1).html().substring($('#faultyTbody1').find('td').eq(index+1).html().search('id')+4,$('#faultyTbody1').find('td').eq(index+1).html().search('id')+12);
						$(idStr).select();
					} 
					catch {
						idStr = '#' + $('#faultyTbody1').find('td').eq(0).html().substring($('#faultyTbody1').find('td').eq(0).html().search('id')+4,$('#faultyTbody1').find('td').eq(0).html().search('id')+12);
						$(idStr).select();
					}
				}	
			});
			$.each($('#faultyTbody2 .num_only'), function(index, item) {

				if ( tagId == $(this).attr('id') ){
					try{
						idStr = '#' + $('#faultyTbody2').find('td').eq(index+1).html().substring($('#faultyTbody2').find('td').eq(index+1).html().search('id')+4,$('#faultyTbody2').find('td').eq(index+1).html().search('id')+11);
						$(idStr).select();
					}
					catch {
						idStr = '#' + $('#faultyTbody2').find('td').eq(0).html().substring($('#faultyTbody2').find('td').eq(0).html().search('id')+4,$('#faultyTbody2').find('td').eq(0).html().search('id')+11);
						$(idStr).select();
					}
				}
			});
		

		
		/* 
		if (tagId == "metalMmb"){
			$('#metalMms').select();
		} else 	if (tagId == "metalMms"){
			$('#metalPms').select();
		} else 	if (tagId == "metalPms"){
			$('#metalFstab').select();
		} else 	if (tagId == "metalFstab"){
			$('#metalPstab').select();
		} else 	if (tagId == "metalPstab"){
			$('#metalAliensbst').select();
		} else 	if (tagId == "metalAliensbst"){
			$('#metalBreak').select();
		} else 	if (tagId == "metalBreak"){
			$('#metalPolutn').select();
		} else 	if (tagId == "metalPolutn"){
			$('#metalBrowning').select();
		} else 	if (tagId == "metalBrowning"){
			$('#metalPpolutn').select();
		} else 	if (tagId == "metalPpolutn"){
			$('#metalGilt').select();
		} else 	if (tagId == "metalGilt"){
			$('#metalThickness').select();
		} else 	if (tagId == "metalThickness"){
			$('#metalEtc').select();
		} else 	if (tagId == "metalEtc"){
			$('#filmPfs').select();
		} else 	if (tagId == "filmPfs"){
			$('#filmBreak').select();
		} else 	if (tagId == "filmBreak"){
			$('#filmTornout').select();
		} else 	if (tagId == "filmTornout"){
			$('#filmSurfceBb').select();
		} else 	if (tagId == "filmSurfceBb"){
			$('#filmEdgeBb').select();
		} else 	if (tagId == "filmEdgeBb"){
			$('#filmTeflon').select();
		} else 	if (tagId == "filmTeflon"){
			$('#filmAliensbst').select();
		} else 	if (tagId == "filmAliensbst"){
			$('#filmPolutn').select();
		} else 	if (tagId == "filmPolutn"){
			$('#filmAgglomt').select();
		} else 	if (tagId == "filmAgglomt"){
			$('#filmOverlap').select();
		} else 	if (tagId == "filmOverlap"){
			$('#filmUnjinjeop').select();
		} else 	if (tagId == "filmUnjinjeop"){
			$('#filmUnattch').select();
		} else 	if (tagId == "filmUnattch"){
			$('#filmWing').select();
		} else 	if (tagId == "filmWing"){
			$('#filmMf').select();
		} else 	if (tagId == "filmMf"){
			$('#filmEtc').select();
		} else 	if (tagId == "filmEtc"){
			$('#etcSize').select();
		} else 	if (tagId == "etcSize"){
			$('#etcCutting').select();
		} else 	if (tagId == "etcCutting"){
			$('#etcFilmPress').select();
		} else 	if (tagId == "etcFilmPress"){
			$('#etcFilmDepth').select();
		} else 	if (tagId == "etcFilmDepth"){
			$('#etcLayer').select();
		} else 	if (tagId == "etcLayer"){
			$('#etcWashboard').select();
		} else 	if (tagId == "etcWashboard"){
			$('#etcWhitetape').select();
		} else 	if (tagId == "etcWhitetape"){
			$('#etcPattem').select();
		} else 	if (tagId == "etcPattem"){
			$('#etcStabbed').select();
		} else 	if (tagId == "etcStabbed"){
			$('#etcHaze').select();
		} else 	if (tagId == "etcHaze"){
			$('#etcSurface').select();
		} else 	if (tagId == "etcSurface"){
			$('#etcSwelling').select();
		} else 	if (tagId == "etcSwelling"){
			$('#etcFeeding').select();

		} else 	if (tagId == "etcFeeding"){
			$('#etcFilm').select();

			
		} else 	if (tagId == "etcFilm"){
			$('#etcSlash').select();
		} else 	if (tagId == "etcSlash"){
			$('#etcJinjeop').select();
		} else 	if (tagId == "etcJinjeop"){
			$('#etcCrack').select();
		} else 	if (tagId == "etcCrack"){
			$('#etcCrease').select();
		} else 	if (tagId == "etcCrease"){
			$('#etcEtc').select();
		} else 	if (tagId == "etcEtc"){
			$('#btnSave').focus();
		} */
			
		$(".num_only").trigger("keyup");
	});
</script>

</body>
</html>
