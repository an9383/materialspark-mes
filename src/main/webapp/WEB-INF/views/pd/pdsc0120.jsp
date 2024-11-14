<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% String userNm = session.getAttribute("userNm").toString(); %>
<% String userId = session.getAttribute("userId").toString(); %>
<%@include file="../layout/topPda.jsp" %>
<style>
 body{
  overflow:hidden;
 }
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex;flex-direction: column;height: 100%;">
      <header class="pda_mo_hd">
         <a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a>
         <a href="/pdsc0120"><p class="mo_main_title">자재부적합현황 확인</p></a>
      </header>
      <!--====-sortbox-->
			<div class="mo_sortbox">
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">자재 바코드</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="barcodeNo" inputmode="none">
					</div>
				</div>
			</div>
			<!--버튼영역-->
			<div class="mo_btnbox pl-2 pr-2">
				<div class="float-left">
					<button type="button" class="btn btn-warning float-right" id="btnRealReturn" disabled>실반품</button>
					<button type="button" class="btn btn-danger float-right d-none" id="btnLineClear" disabled>라인삭제</button>
					<button type="button" class="btn btn-danger float-right mr-2" id="btnAllClear" disabled>전체삭제</button>
				</div>
				<div class="float-right">
				<%
					if(factoryCode.equals("003")) {
				%>
						<button type="button" class="btn btn-primary mr-1" id="btnApprEdit" disabled>수정</button>
				<%
					}
				%>
					<button type="button" class="btn btn-primary mr-2" id="btnUnreceived" disabled>판정</button>
					<button type="button" class="btn btn-secondary float-right" id="btnReset">초기화</button>
				</div>
			</div>
			<br>
		    <!--end버튼영역-->
	  <!--==end==-sortbox-->
	   <main style="height: calc(100vh - 50px);overflow:auto;">
		
		<div class="container-fluid bg_wh" id="main" style="height: 100%;display: flex;flex-direction: column;">
			<div class="card mo_card" style="overflow-y:auto; width:100%;">
				<div class="table-responsive">
					<table class="table table-bordered table-td-center" id="matrlFaultyTable">
						<colgroup>
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<thead class="thead-light">
							<tr>
								<th>바코드 번호</th>
								<th>승인 여부</th>
								<th>자재 상태</th>
								<th>불량일</th>
								<th>잔량</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	  </main>
	  <footer class="p-2" style="margin-top: auto;">
			<div class="mo_sumbox">
				<button type="button" class="btn btn-warning float-left" style="width: 75px;" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll">
						<button type="button" class="btn btn-primary" id="btnRemainQtyCheck">잔량 저장</button>
					</div>
				</div>
				<!-- <div style="display: flex;justify-content: flex-end;align-items: center;">
					<input type="checkBox" class="mr-2" style="width:20px; height:20px" id="stackYn">
					<label for="stackYn">쌓기 여부</label>
				</div>
				 -->
			</div>	
	  </footer>
</div>
<!-- /.app -->

<!-- 수정 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="approvalCdEditPopUpModal" tabindex="-1" role="dialog" aria-labelledby="approvalCdEditPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="approvalCdEditPopUpLabel">승인여부 수정</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 20px; margin-bottom: 20px;">
				<form id="form2">
							  <table class="table table-bordered mb-2" id="">
								<colgroup>
									<col width="20%">
									<col width="80%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>승인여부</th>
										<td>
											<select class="custom-select custom-select-sd" style="min-width:100%;" id="selectapprovalCd" name="selectapprovalCd"></select>
										</td>
									</tr>
									<tr class="faultyDateTr d-none">
										<th>불량일자</th>
										<td>
											<div class="form-group input-sub m-0" style="max-width: 100%">
												<input class="form-control" style="min-width:100%;" type="date" id="faultyDate" name="faultyDate">									
											</div>
										</td>
									</tr>								
								</thead>
						       </table>						      
						       </form>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<div class="mr-5" style="display: flex;flex-direction: column-reverse;">
					<label>* <span style="background: #ffff99e3;">승인상태/생산투입상태이면</span> 수정되지 않습니다.</label>
					<label>* <span style="font-weight: bold;">일괄 수정</span>됩니다.</label>
				</div>
				<button type="button" class="btn btn-primary" id="btnApprovalSave" style="min-width: 70px;">변경</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 수정 모달 종료 -->

<!-- 판정 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="judgementPopUpModal" tabindex="-1" role="dialog" aria-labelledby="judgementPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="judgementPopUpLabel">판정 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<form id="form2">
							  <table class="table table-bordered mb-2" id="">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th colspan="4">부적합처리</th>
									</tr>
									<tr>
										<th>부적합<br>처리</th>
										<td colspan="3">
											<div class="row">
				                           	 	<input type="radio" style="width: 20px;height: 20px;" name="approvalYn" id="apr1" value="001" onclick=""> 
				                           	 	<label style="line-height: 23px;margin-left: 10px;" for="apr1">재사용</label>
				                           	 	<input type="radio" style="width: 20px; height: 20px;margin-left: 25px;" name="approvalYn" id="apr2" value="002" onclick=""> 
				                           	 	<label style="line-height: 23px;margin-left: 10px;" for="apr2">반품</label>
				                            	<input type="radio" style="width: 20px; height: 20px;margin-left: 25px;" name="approvalYn" id="apr3" value="003" onclick=""> 
				                            	<label style="line-height: 23px;margin-left: 10px;" for="apr3">폐기</label>
				                            	<%
													if(factoryCode.equals("003")) {
												%>
				                            	<br>
				                            	<input type="radio" style="width: 20px; height: 20px;margin-left: 25px;" name="approvalYn" id="apr4" value="004" onclick=""> 
				                            	<label style="line-height: 23px;margin-left: 10px;" for="apr4">폐기반품</label>
				                            	<%
													}
				                            	%>
				                          	</div>
										</td>
									</tr>
									<tr>
										<th id="changingDate">...</th>
										<td>
											<div class="form-group input-sub m-0" style="max-width: 100%">
												<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate" name="frrrdDate">									
											</div>
										</td>
										<th>부적합<br>담당자</th>
										<td>
											<div class="input-sub m-0" style="max-width: 100%">
											<input type="hidden" class="form-control" style="max-width: 100%" id="matrlChargr" name="matrlChargr" disabled>
											<input type="text" class="form-control" style="max-width: 100%" id="matrlChargrNm" name="matrlChargrNm" disabled>
											<button type="button" class="btn btn-primary input-sub-search" name="btnfaultyChargr" id="btnfaultyChargr" onClick="selectPreWorkCharger();">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
										</td>
									</tr>								
									<tr>
										<th>비고</th>
										<td colspan="3"><input type="text" class="form-control" id="frrrdDesc" name="faultyDesc" style="max-width:100%" ></td>
									</tr>
									
									<tr>
										<th>불량 유형</th>
										<td colspan="3">
										<c:forEach var="item" items="${matrlFaultyType}">
											<div class="row">
												<div class="col-6 text-center">${item.baseCdNm}</div>
												<div class="col-6 text-center">
													<input type="checkbox" id="frrrdType${item.baseCd}" style="width: 20px;height: 20px;">
												</div>	
											</div>
										</c:forEach>
										</td>
									</tr>
									
								</thead>
						       </table>						      
						       </form>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<div class="mr-5" style="display: flex;flex-direction: column-reverse;">
					<label>*재사용 시 선택된 자재는 선입선출이 <span style="font-weight: bold;">미적용</span>됩니다.</label>
					<label>*<span style="background: #ffff99e3;">불량인 자재만</span> 전체 판정됩니다.</label>
				</div>
				<button type="button" class="btn btn-primary" id="btnFaultySave" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 판정 모달 종료 -->

<!-- 잔량 변경 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="remainQtyCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="remainQtyCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">잔량 변경 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<h6>잔량을 변경 하시겠습니다까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnRemainQtySave" style="min-width: 70px;">변경</button>
				<button type="button" class="btn btn btn-secondary" id="btnRemainQtyCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 잔량 변경 확인 모달 종료 -->

<!-- 승인여부 수정 확인 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="apprSaveCheckPopUpModal" tabindex="-1" role="dialog" aria-labelledby="apprSaveCheckPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">승인여부 변경 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<h6>승인여부를 변경 하시겠습니다까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="apprSave" style="min-width: 70px;">변경</button>
				<button type="button" class="btn btn btn-secondary" id="apprSaveCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 승인여부 수정 확인 모달 종료 -->






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
				
				<!-- 실반품유형 테이블 -->
				<table id="frrrdReturnPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="frrrdDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="frrrdReturnDate" name="frrrdDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="frrrdDescLabel"></th>
							<td>
								<input type="text" id="frrrdReturnDesc" name="frrrdReturnDesc" style="max-width: 100%;" class="form-control" />
							</td>
						<tr>
						<th id="frrrdTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${matrlFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="frrrdReturnType${item.baseCd}" style="zoom:1.8;"></div>	
								</div>
							</c:forEach>
							</td>
						</tr>
					</thead>
				</table>
				<!-- 실반품유형 테이블 -->
				
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFaultyReturnSave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 보류&불량&반품&실반품&폐기 -->

<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title","자재부적합현황 확인");
	let menuAuth = 'pdsc0120';
	
	let scanBarcodeNo	= "empty";
	let serverDate		= "${serverDate}";
	let factoryCode		= "<%=factoryCode%>";
	let userNm 			= "<%=userNm%>";
	let userId 			= "<%=userId%>";
	$('#barcodeNo').focus();

	if( factoryCode == '001' || factoryCode == '002'){
		$('#changingDate').text("부적합 등록일");
	} else if( factoryCode == '003' ) {
		$('#changingDate').text("재검일자");
	} else {
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}

	//공통코드 처리 
	let matrlFaultyType = new Array(); //설비트러블 
	<c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
	</c:forEach>

	let approvalCdList = new Array(); //승인구분 
	<c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCdList.push(json);
	</c:forEach>
	
	//공통코드 처리 종료
	
	selectBoxAppend(approvalCdList, "selectapprovalCd", "", "2");
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	$.fn.dataTable.ext.errMode = 'none';
	let matrlFaultyTable = $('#matrlFaultyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom:  "<'row'<'col-sm-12 col-md-9'><'col-sm-12 col-md-3'>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'><'col-sm-12 col-md-7'>>",         
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: false,
        autoWidth: false,
        searching: false,
        pageLength: true,
        ajax: {
 			url: '<c:url value="/pd/matrlFaultyVoList"/>',
			type: 'GET',
			data: {
				'menuAuth'		:		menuAuth,
				'barcodeNo'		:		function() { return scanBarcodeNo; },
			},
        },
        columns: [
			{ data: 'barcodeNo',
				render: function(data, type, row, meta) {	
// 					data = barcodeNo;
	    			return  data;
	    		}
			},
			{ data: 'approvalNm',
				render: function(data, type, row, meta) {	
					return data;
	    		}
    		},
			{ data: 'statusNm',
				render: function(data, type, row, meta) {
		    		return  data;
		    	}
	    	},
			{ data: 'frrrdDate',
			    render: function(data, type, row) {
			    	if(data == null || data == ''){
						return "-";
					} else {
						return moment(data).format("YYYY-MM-DD");
					}
			    }
			},
	    	{ data: 'remainQty',
			    render: function(data, type, row) {
// 			    	if(row.approvalCd == '003'){
			    		if(row['statusCd'] == "P"){
				        	return '<input type="number" class="form-control number-float2 text-right" name="remainQty" style="min-width: 100%;" value="' + data + '" min="0" max="' + row.preInWhsQty + '" disabled>';
						} else {
							return '<input type="number" class="form-control number-float2 text-right" name="remainQty" style="min-width: 100%;" value="' + data + '" min="0" max="' + row.preInWhsQty + '">';
						}
// 					} else {
// 						return data;
// 					}
			    }
			}
		],
        columnDefs: [],
        order: [
            [ 0, 'asc' ],
        ],
        rowCallback: function (row, data) {
			if (data.approvalCd == '003') {
				$(row).addClass('skyYellow');
			}
		},
		drawCallback: function(){
			
		},
    });

	let lineCheck = false;
    $('#matrlFaultyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            lineCheck = false;
        }	
        else {
        	$('#matrlFaultyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            lineCheck = true;
        }
    });

	//remainQty 값 변경 시
	 $(document).on('change','input[name=remainQty]',function (e) {
		 //상위 요소를 찾아 해다 tr애 값 중 remainQty에 값을 변경한다.
		matrlFaultyTable.row(this.parentNode.parentNode).data().remainQty = $(this).val();
// 		console.log("값 변경 됨");
	});

	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
	    if (e.which == 13) {
	    	if ( !$.trim($('#barcodeNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#barcodeNo').select();
	            return false;
	        }
	    	

	    	let cval = compareBarcodeNo( $('#barcodeNo').val().trim() );
	        if(!cval) {
	        	toastr.warning('중복된 바코드 입니다.', '', {timeOut: 600});
	        	$('#barcodeNo').val('');
	        	$('#barcodeNo').select();
	            return false;              
	        }
	        
			$.ajax({
	 			url: '<c:url value="/pd/matrlFaultyCheck"/>',
				type: 'GET',
				data: {
					'menuAuth'		:		menuAuth,
					'barcodeNo'		:		function() { return $('#barcodeNo').val().trim(); },
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
					let result = res.result;
					let data = res.data;
// 					console.log(data);
					if (result == 'ok') {

						scanBarcodeNo = $('#barcodeNo').val().trim();

						uiProc(false);
						$('#matrlFaultyTable').DataTable().row.add({
							'menuAuth'			: menuAuth
							, 'barcodeNo'		: data.barcodeNo
							, 'approvalCd'		: data.approvalCd
							, 'approvalNm'		: data.approvalNm
							, 'statusCd'		: data.statusCd
							, 'statusNm'		: data.statusNm
							, 'frrrdDate'		: data.frrrdDate
							, 'frrrdType'		: data.frrrdType
							, 'frrrdDesc'		: data.frrrdDesc
							, 'approvalCd'		: data.approvalCd
							, 'matrlChargr'		: data.matrlChargr
							, 'inspectCd'		: data.inspectCd
							, 'inWhsGroupSeq'	: data.inWhsGroupSeq
							, 'lotNo'			: data.lotNo
							, 'remainQty'		: data.remainQty
							, 'preInWhsQty'		: data.preInWhsQty
						}).draw(false);
						
						$('#barcodeNo').val('');
						toastr.success("스캔 되었습니다", '', {timeOut: 500});
						
					} else if (result == 'fail') {
						scanBarcodeNo = "empty";
						toastr.warning(res.message, '', {timeOut: 500});
						$('#barcodeNo').select();
					} else if (result == 'error') {
						toastr.warning(res.message, '', {timeOut: 500});
						$('#barcodeNo').select();
					}
				},
				complete:function(){}
			});
	    }
	});

	//바코드 정보 불러오기
	function barcodeInfoRead(bcVal) {

		$.ajax({
 			url: '<c:url value="/pd/matrlFaultyCheck"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		:		menuAuth,
				'barcodeNo'		:		function() { return bcVal; },
			},
			beforeSend: function() {
				//  $('#btnAddConfirm').addClass('d-none');
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success: function (res) {
				let result = res.result;
				let data = res.data;
//					console.log(data);
				if (result == 'ok') {

					scanBarcodeNo = $('#barcodeNo').val().trim();

					uiProc(false);
					$('#matrlFaultyTable').DataTable().row.add({
						'menuAuth'			: menuAuth
						, 'barcodeNo'		: data.barcodeNo
						, 'approvalCd'		: data.approvalCd
						, 'approvalNm'		: data.approvalNm
						, 'statusCd'		: data.statusCd
						, 'statusNm'		: data.statusNm
						, 'frrrdDate'		: data.frrrdDate
						, 'frrrdType'		: data.frrrdType
						, 'frrrdDesc'		: data.frrrdDesc
						, 'approvalCd'		: data.approvalCd
						, 'matrlChargr'		: data.matrlChargr
						, 'inspectCd'		: data.inspectCd
						, 'inWhsGroupSeq'	: data.inWhsGroupSeq
						, 'lotNo'			: data.lotNo
						, 'remainQty'		: data.remainQty
						, 'preInWhsQty'		: data.preInWhsQty
					}).draw(false);
					
					$('#barcodeNo').val('');
					
				} else if (result == 'fail') {
					scanBarcodeNo = "empty";
					toastr.warning(res.message, '', {timeOut: 500});
					$('#barcodeNo').select();
				} else if (result == 'error') {
					toastr.warning(res.message, '', {timeOut: 500});
					$('#barcodeNo').select();
				}
			},
			complete:function(){}
		});
	}

	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#matrlFaultyTable').DataTable().clear().draw();
		uiProc(true);
	});

	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if ( lineCheck == true) {
	    	$('#matrlFaultyTable').DataTable().rows('.selected').remove().draw();
	    	$("#barcodeNo").val("");
	    	$("#barcodeNo").focus();
	    	
    		if( $('#matrlFaultyTable tbody tr').text() == '데이터가 없습니다.' ) {
	    		uiProc(true);
	    	}
		} else {
	    	toastr.warning('삭제할 라인을 선택하세요.');
		}
		lineCheck = false;
	});
	
	
	
	
	//실반품
	$('#btnRealReturn').on('click', function() {

		if ( matrlFaultyTable.data().length == 0 ) {
			toastr.warning("실반품 처리할 자재를 선택해주세요!");
    		return false;
        }
		
		approvalCd = '006';
		//선택해제
		for (var i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdReturnType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		
		$('#frrrdReturnDate').val(serverDate);
		$('#frrrdReturnDesc').val('');
		
		$('#frrrdPopUpLabel').text('실반품 처리');
		$('#frrrdDateLabel').text('실반품일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('실반품유형');

		//$('#frrrdPopUpModal').modal('show');
		
		frrrdType = "";
		
		updateMtrlInOutWhsInspectQty("006");
    });
	
	$('#btnFaultyReturnSave').on('click', function() {
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';
		
		//frrrdType = '';
		
		//실 반품
		frrrdDate = $('#frrrdReturnDate').val().replace(/-/g, '');
		frrrdDesc = $('#frrrdReturnDesc').val();
		
		for (let i=0; i<matrlFaultyType.length; i++) {
			if($('#frrrdReturnType' + matrlFaultyType[i].baseCd).prop("checked")) {
				frrrdType += '1';
			} else {
				frrrdType += '0';
			}
		}
		updateMtrlInOutWhsInspectQty("006");
	});
	
	
	

	//수정 버튼 클릭 시
	$('#btnApprEdit').on('click', function() {
		if ( matrlFaultyTable.data().length == 0 ) {
			toastr.warning("수정할 자재를 스캔해주세요!");
    		return false;
        }
//         $('#frrrdDate').val(serverDate);
// 		$('input[name=approvalYn]').prop('checked',false);
//     	$('#matrlChargrNm').val('');
 		$('#selectapprovalCd').val('');
 		$('#faultyDate').val('');
 		$('.faultyDateTr').addClass("d-none");
		
		$('#approvalCdEditPopUpModal').modal('show');
	});

	//승인 여부 선택 시
	$('#selectapprovalCd').on('change', function(){
		if($('#selectapprovalCd').val() == '003'){
			$('.faultyDateTr').removeClass('d-none')
			$('#faultyDate').val(serverDate);
		} else {
			$('.faultyDateTr').addClass("d-none");
			$('#faultyDate').val('');
		}
	});

	//수정 모달 확인 버튼 클릭 시
	$('#btnApprovalSave').on('click', function(){
		if($('#selectapprovalCd').val() == ''){
			toastr.warning("승인여부를 선택해주세요!");
			return false;
		}

		if($('#selectapprovalCd').val() == '003' && $('#faultyDate').val() == ''){
			toastr.warning("불량일자를 선택해주세요!");	
			return false;
		}

		$('#apprSaveCheckPopUpModal').modal('show');
	});

	//승인여부 변경 확인 모달 변경 클릭 시
	$('#apprSave').on('click', function(){

		var faultChk = 0;
		$('#apprSaveCheckPopUpModal').modal('hide');
		if($('#selectapprovalCd').val() == "003"){
			faultChk++;
			$('#btnUnreceived').attr('disabled', false);
			$('#btnRealReturn').attr('disabled', false);
		}
		let approvalArray	= new Array();
		let apprCnt 		= 0;
		let apprObj			= new Object();

		let barcodeList 	= new Array();

		// 리스트의 전체 자재 불러온다.
		$.each(matrlFaultyTable.data().splice(","), function(index, item) {	 
			barcodeList[index] = item.barcodeNo;
			apprObj = new Object();

			if(item.statusCd != 'P' || item.approvalCd != '001'){
				apprObj.menuAuth		= item.menuAuth;
				apprObj.barcodeNo		= item.barcodeNo;
//	 		    obj.remainQty		= item.remainQty;
		    	apprObj.approvalCd		= $('#selectapprovalCd').val();
		    	apprObj.faultyDate		= $('#faultyDate').val().replace(/-/g, '');

		    	approvalArray.push(apprObj);
		    	apprCnt++;
			}
		});
		
		//toastr.success("여기메세지가 보이면 통과됨!");
		
		$('#my-spinner').show();
		if( apprCnt > 0 ) {
	        $.ajax({
	            url: '<c:url value="/qm/matrlInOutApprovalUpdate"/>',
	            type: 'POST',
	            dataType: 'json',
	            async: false,
	            data : JSON.stringify(approvalArray),
	            contentType : "application/json; charset=UTF-8",
	            success: function (res) {
	                if (res.result == 'ok') {
	                	toastr.success("처리되었습니다.");
	                	uiProc(true);
	                	$('#approvalCdEditPopUpModal').modal('hide');
	                	$('#barcodeNo').attr('disabled', true);
	                	$('#matrlFaultyTable').DataTable().clear().draw();
	                	for(i = 0; i <barcodeList.length; i++){
	                		barcodeInfoRead(barcodeList[i]);
		                }
// 	                	$('input[name=remainQty]').attr('disabled', true);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            	if(faultChk == 0){
	            		$('#btnUnreceived').attr('disabled', true);
	            		$('#btnRealReturn').attr('disabled', true);
	            	}
	            }
	        });
		}  else {
			toastr.warning("수정할 자재가 없습니다!");
			$('#my-spinner').hide();
		}
	});

	//판정 버튼 클릭 시
	$('#btnUnreceived').on('click', function() {
		if ( matrlFaultyTable.data().length == 0 ) {
			toastr.warning("판정할 자재를 스캔해주세요!");
    		return false;
        }
        $('#frrrdDate').val(serverDate);
		$('input[name=approvalYn]').prop('checked',false);
    	$('#matrlChargrNm').val(userNm);
		$('#matrlChargr').val(userId);
		$('#faultyDesc').val('');

    	for (var i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		
		$('#judgementPopUpModal').modal('show');
	});


	let frrrdType = '';
	
	//판정처리모달 저장 버튼 클릭 시
	$('#btnFaultySave').on('click', function() {

		frrrdType = '';

		if($('input[name=approvalYn]:checked').val() == null){
			toastr.warning("판정할 항목을 선택해 주세요!");
			$('#apr1').focus();
			return false;
		} 

		if(!$.trim($('#frrrdDate').val())){
			toastr.warning("날짜를 선택해 주세요!");
			$('$frrrdDate').focus();
			return false;
		}
		if(!$.trim($('#matrlChargr').val())){
			toastr.warning("부적합 담당자를 선택해주세요!");
			$('#btnfaultyChargr').focus();
			return false;
		}	

		//불량유형 선택
		for (let i=0; i<matrlFaultyType.length; i++) {
			if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
				frrrdType += '1';
			} else {
				frrrdType += '0';
			}
		}
		
		//재사용
		if($('input[name=approvalYn]:checked').val() == '001'){
			updateMtrlInOutWhsInspectQty("009");
			updateInspectCd("");		
		} 
		//반품
		else if($('input[name=approvalYn]:checked').val() == '002'){
			//approvalCd	= '005';
			updateMtrlInOutWhsInspectQty("005");	
		} 
		//폐기
		else if($('input[name=approvalYn]:checked').val() == '003'){
			//approvalCd	= '007';
			updateMtrlInOutWhsInspectQty("008");				
		}
		//폐기반품
		else if($('input[name=approvalYn]:checked').val() == '004'){
			//approvalCd	= '007';
			updateMtrlInOutWhsInspectQty("010");				
		}
	});

	//저장 버튼 관련 함수
	function updateMtrlInOutWhsInspectQty(approvalCdVal) {
		
		let psgArray		= new Array();
		let checkboxCnt 	= 0;
		let obj				= new Object();
		let frrrdTypeCheck 	= frrrdType.replace(/0/gi, "");	//replaceAll 사용시 오류 남.

		let barcodeList1 	= new Array();
		
		// 리스트에 불량인 자재만 불러온다.
		$.each(matrlFaultyTable.data().splice(","), function(index, item) {	 
			barcodeList1[index] = item.barcodeNo;
			obj = new Object();
			
			//승인(001)-미승인(002)-불량(003)-보류(004)-반품(005)-실제반품(006)-자체폐기(007) -폐기(008) -재사용(009) -폐기반품(010)
		    if( item.approvalCd == '003' || item.approvalCd == '005' || item.approvalCd == '010' || item.approvalCd == '007' ) {

		    	obj.menuAuth		= item.menuAuth;
		    	obj.barcodeNo		= item.barcodeNo;
// 		    	obj.remainQty		= item.remainQty;
		    	obj.approvalCd		= approvalCdVal;
		    	if( approvalCdVal == "006" ) {
		    		obj.frrrdDate		= $('#frrrdReturnDate').val().replace(/-/g, '');
		    	} else {
		    		obj.frrrdDate		= $('#frrrdDate').val().replace(/-/g, '');
		    	}

		    	//불량 유형
		    	if( frrrdTypeCheck != '') {
		    		obj.frrrdType = frrrdType;
		    	} else {
		    		obj.frrrdType = "";
			    }
		    	
		    	if( approvalCdVal == "006" ) {
		    		obj.frrrdDesc	= $('#frrrdReturnDesc').val();
		    	} else {
		    		obj.frrrdDesc	= $('#frrrdDesc').val();
		    	}
		    	obj.matrlChargr	= $('#matrlChargr').val();
		    	
		    	psgArray.push(obj);
		    	checkboxCnt++;
		    }
		});
		
		//toastr.success("여기메세지가 보이면 통과됨!");
		
		$('#my-spinner').show();
		if( checkboxCnt > 0 ) {
	        $.ajax({
	            url: '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_qmsc0170"/>',
	            type: 'POST',
	            dataType: 'json',
	            async: false,
	            data : JSON.stringify(psgArray),
	            contentType : "application/json; charset=UTF-8",
	            success: function (res) {
	                if (res.result == 'ok') {
	                	
	                	toastr.success("처리되었습니다.");
	                	uiProc(true);
	                	
	                	$('#judgementPopUpModal').modal('hide');
	                	$('#frrrdPopUpModal').modal('hide');
	                	
	                	$('#barcodeNo').attr('disabled', true);
	                	
	                	if(factoryCode == '003'){
	                		$('#matrlFaultyTable').DataTable().clear().draw();
		                	for(i = 0; i <barcodeList1.length; i++){
		                		barcodeInfoRead(barcodeList1[i]);
			                }
		                }
	                	
// 	                	$('input[name=remainQty]').attr('disabled', true);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            	$('#btnUnreceived').attr('disabled', true);
	            	$('#btnRealReturn').attr('disabled', true);
	            }
	        });
		}  else {
			toastr.warning("판정 내릴 자재가 없습니다!");
			$('#my-spinner').hide();
		}
    }

	//불량 유형
	/* function faultyStatusUpdate(faultySender){
	       
		$.ajax({
			url: '<c:url value="po/WorkOrdDtlFaultyStatusChange"/>',
			type: 'POST',
	           
			data: {
				'menuAuth'	 		: 		menuAuth,
				'workOrdNo'			:		function() { return workOrdNo; },		//선택한 작업지시
				'lotNo'				: 		function() { return mainMatrlLotNo; },	//선택한 작업지시
				'faultyStatus'		: 		function() { return faultySender; },
			},
			beforeSend: function() {
				$('#my-spinner').show();
	   		},
			success: function (res) {
				if (res.result == 'ok') {} 
				$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
	} */

	//합격 여부 업데이트
	function updateInspectCd(inspectCd) {
    	let dataArray	= new Array();
		let obj			= new Object();
		// 리스트에 불량인 자재만 불러온다.
		$.each(matrlFaultyTable.data().splice(","), function(index, item){	 
		    if( item.approvalCd == '003'){
		    	obj.inspectCd 		= inspectCd;
		    	obj.inWhsGroupSeq	= item.inWhsGroupSeq;
		    	obj.lotNo 			= item.lotNo;
		    	dataArray.push(obj);
		    }
		});
		
        $.ajax({
            url: '<c:url value="/qm/inspectPassUpdate_F3"/>',
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
//                     $('#faultyMatrlList').DataTable().ajax.reload();
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function() {}
        }); 
	}
	
	
	//초기화 버튼 클릭 시
	$('#btnReset').on('click', function() {
		$('#barcodeNo').attr('disabled', false);
		$('#barcodeNo').val('');
		$('#matrlFaultyTable').DataTable().clear().draw();
		$('#barcodeNo').focus();
		scanBarcodeNo	= "empty";
		uiProc(true);
	});
	
	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#barcodeNo').attr('inputmode');
		if ( inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#barcodeNo').attr('inputmode', 'text');
		} else if ( inputmode == 'text' ) {
			$('#btnKeyboard').text("자판 Off");
			$('#barcodeNo').attr('inputmode', 'none');
		}
	});

	//중복 예외처리
	function compareBarcodeNo(barcodeNo) {
	    var result = true;
	    $('#matrlFaultyTable tbody tr').each(function(){
			let tbarcodeNo = $(this).find('td').eq(0).html();
			if(barcodeNo == tbarcodeNo) {  
				result = false;
				return result;
			}
		});
	    return result;
	}

	//잔량 변경 버튼 클릭 시
	$('#btnRemainQtyCheck').on('click', function() {
		
		if ( matrlFaultyTable.data().length == 0 ) {
			toastr.warning("잔량 변경할 자재를 스캔해주세요!");
			$('#barcodeNo').focus();
    		return false;
        }
        
		$('#remainQtyCheckPopUpModal').modal('show');
	});

	//모달 잔량 변경 확인 버튼 클릭 시
	$('#btnRemainQtySave').on('click', function() {
		
		if ( matrlFaultyTable.data().length == 0 ) {
			toastr.warning("잔량 변경할 자재를 스캔해주세요!");
			$('#barcodeNo').focus();
    		return false;
        }

		let array	= new Array();
		let obj		= new Object();

		//값 담아주는 부분
		$.each(matrlFaultyTable.data().splice(","), function(index, item) {
			obj = new Object();
			obj.remainQty	= item.remainQty;
			obj.lotNo		= item.lotNo;
			array.push(obj);
		});
		

		$('#my-spinner').show(function(){
			//잔량 변경 저장
			$.ajax({
	            url: '<c:url value="/pd/updateRemainQty"/>',
	            type: 'POST',
	            dataType: 'json',
	            async: false,
	            data : JSON.stringify(array),
	            contentType : "application/json; charset=UTF-8",
	            success: function (res) {
	                if (res.result == 'ok') {
	                	toastr.success("잔량이 변경 되었습니다.");
	                	uiProc(true);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function() {
	            	$('#barcodeNo').attr('disabled', true);
	            	$('#remainQtyCheckPopUpModal').modal('hide');
	             	$('#my-spinner').hide();
	            }
	        });
			//잔량 변경 저장
		},0);
	});

	//담당자조회 팝업 시작
   	let userPopUpTable;
   	function selectPreWorkCharger() {
		if( userPopUpTable == null || userPopUpTable == undefined )	{
			userPopUpTable = $('#userPopUpTable').DataTable({
				language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		        },
		        rowId: 'userNumber',
		        columns: [
					{ data : 'userNm'}, 
					{ data : 'departmentNm'	}, 
					{ data : 'postNm' }, 
					{ data : 'chargrDutyNm'	}, 
					{ data : 'teamNm' }, 
					{ data : 'workplaceNm' },
		        ],
		        columnDefs: [
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],
		        oSearch: {"sSearch": userNm},
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
                $('#matrlChargr').val(data.userNumber);
                $('#matrlChargrNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');                
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		    
		$('#userPopUpModal').modal('show');	
   	}

	//버튼 UI
	function uiProc(flag) {
		$('#btnLineClear').attr('disabled', flag);
		$('#btnAllClear').attr('disabled', flag);
		$('#btnSave').attr('disabled', flag);
		$('#btnApprEdit').attr('disabled', flag);
		$('#btnUnreceived').attr('disabled', flag);
		$('#btnRealReturn').attr('disabled', flag);
// 		$('#btnRemainQtyCheck').attr('disabled', flag);

		$('#barcodeNo').val('');
		$('#barcodeNo').focus();
	}

	//숫자만 입력, 길이, 소수점 세자리까지 제한
	$(document).on('keyup keydown','.number-float2', function(event) {
		/* if ( !(   (event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)   ) {
			//$('.number-float2').on("blur keyup", function() {
			//   $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
			$(this).select();
			return false;
		} */
		
		var temp = $(this).val();
		temp = removeCommas(temp);
		temp = temp.replace(/[^0-9]/g, "");
		
		if (temp == "") {
			temp = 0;
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
         	toastr.warning('최대 크기('+$(this).attr("max")+')를 초과하였습니다.');
			return false;
		}
		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			$(this).val("0");
			$(this).select();
         	toastr.warning('최소 크기('+$(this).attr("min")+')를 초과하였습니다.');
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

</script>

</body>
</html>
