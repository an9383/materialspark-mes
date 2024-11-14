<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("newLineChar", "\n");
%>

<%@include file="../layout/topPda.jsp"%>
<style>
body {
	overflow: hidden;
}
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex; flex-direction: column; height: 100%;">
	<header class="pda_mo_hd">
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0040"><p class="mo_main_title">제품출고</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
		<div class="col-12 row p-1">
			<div class="col-4 mo_sort_title">출고일</div>
			<div class="form-group input-sub col-8 m-0 p-0">
				<input class="form-control-md" type="text" id="chooseDate" disabled />
				<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button" id="btnCalendar">
					<span class="oi oi-calendar"></span>
				</button>
			</div>
		</div>
		<div class="col-12 row p-1">
			<input type="hidden" class="form-control" id="poGubunCd" name="poGubunCd">
			<input type="hidden" class="form-control" id="goodsCd" name="goodsCd">
			<div class="col-4 mo_sort_title">PO Number</div>
			<div class="form-group input-sub col-8 m-0 p-0">
				<input type="hidden" class="form-control-md" id="poSeq" name="poSeq" disabled>
				<input type="text" class="form-control-md" id="poNo" name="poNo" disabled>
				<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelpoSeqCode" onClick="selectPoCode()">
					<span class="oi oi-magnifying-glass"></span>
				</button>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-4 mo_sort_title">
				<label class="" for="addPallet" >파레트 추가</label>
				<input type="checkbox" class="" id="addPallet" style="width:15px; height:15px;">
			</div>
			<div class="form-group input-sub col-8 m-0 p-0">
				<input type="text" class="form-control-md" id="poGroup" name="poGroup" disabled>
				<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelpoGroup" onClick="selectPoGroup()">
					<span class="oi oi-magnifying-glass"></span>
				</button>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-2 mo_sort_title">Box No</div>
			<div class="form-group input-sub col-10 m-0 p-0">
			
				<div class="row">
					<input type="text" class="form-control-md" style="width: 50%;" id="firstBoxNo" inputmode="none" placeholder="barcodeNo를 먼저스캔해주세요.">
					<input type="text" class="form-control-md" style="width: 50%;" id="secondCustomerLotNo" inputmode="none" maxlength="30" max="30" placeholder="고객사 LotNo스캔해주세요." disabled>
				</div>
				<input type="text" class="form-control-md d-none" id="boxNo" inputmode="none">
				
				<%-- <%
				if (factoryCode.equals("001") || factoryCode.equals("002")) {
				%>
				<div class="row">
					<input type="text" class="form-control-md" style="width: 50%;" id="firstBoxNo" inputmode="none" placeholder="barcodeNo를 먼저스캔해주세요.">
					<input type="text" class="form-control-md" style="width: 50%;" id="secondCustomerLotNo" inputmode="none" maxlength="30" max="30" placeholder="고객사 LotNo스캔해주세요." disabled>
				</div>
				<%
				} else if (factoryCode.equals("003")) {
				%>
				<input type="text" class="form-control-md" id="boxNo" inputmode="none">
				<%
				}
				%> --%>

			</div>
		</div>
	</div>
	<!--==버튼영역-->
	<div class="mo_btnbox pl-2 pr-2">
		<div class="float-left">
			<button type="button" class="btn btn-danger float-right" id="btnLineClear" disabled>라인삭제</button>
			<button type="button" class="btn btn-danger float-right mr-2" id="btnAllClear" disabled>전체삭제</button>
		</div>
		<div class="float-right">
			<button type="button" class="btn btn-secondary float-right" id="btnCancel">취소</button>
			<button type="button" class="btn btn-secondary float-right d-none" id="btnNew">새로 등록</button>
			<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>저장</button>
		</div>
	</div>
	<br>
	<!--==end==버튼영역-->
	<!--==end==-sortbox-->
	<main style="height: calc(100vh - 50px); overflow: auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%; display: flex; flex-direction: column;">
			<!--table-->
			<!-- .table-responsive -->
			<div class="card mo_card" style="OVERFLOW-Y: auto; width: 100%;">
				<div class="table-responsive">
					<table id="boxCodeOutputWhsTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 25px">순번</th>
								<th style="min-width: 50px">제품코드</th>
								<th style="min-width: 80px">제품명</th>
								<th style="min-width: 90px">Box No</th>
								<th style="min-width: 60px">출하 수량</th>
								<!-- <th style="min-width: 40px">잔여 수량</th> -->
								<th style="min-width: 40px">포장 수량</th>
								<th style="min-width: 40px">선입선출</th>
								
								<th style="min-width: 40px">고객사lotNo</th>
								
								<%-- <%
								if (factoryCode.equals("001") || factoryCode.equals("002")) {
								%>
								<th style="min-width: 40px">고객사lotNo</th>

								<%
								} else if (factoryCode.equals("003")) {
								%>
								<th class="d-none" style="min-width: 40px">고객사lotNo</th>
								<%
								}
								%> --%>
						</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==end==table-->
		</div>
		<!-- PO 모달 시작-->
		<div class="modal fade bd-example-modal-lg" id="poPopUpModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header" style="padding-bottom: 0px;">
						<h5 class="modal-title" id="poPopUpLabel">주문관리조회</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
						<div class="table-responsive">
							<table id="poPopUpTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width: 70px">마감일</th>
										<th style="min-width: 70px">납기일</th>
										<th style="min-width: 140px">PO Number</th>
										<th style="min-width: 120px">제품명</th>
										<th style="min-width: 90px">오더량</th>
										<th style="min-width: 90px">미출고량</th>
										<th style="min-width: 90px">코드</th>
									</tr>
								</thead>
							</table>
						</div>
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
					</div>
					<div class="modal-footer" style="padding-top: 0px;">
						<button type="button" class="btn btn-secondary touch5" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- PO 모달 종료-->
		<!-- 트레이 번호(poGroup) 모달 시작-->
		<div class="modal fade bd-example-modal-lg" id="poGroupPopUpModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header" style="padding-bottom: 0px;">
						<h5 class="modal-title" id="poPopUpLabel">주문관리조회</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
						<div class="table-responsive">
							<table id="poGroupPopUpTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width:60px">출하순서</th>
										<th style="min-width:70px">출고량</th>
										<th style="min-width:90px">적재 Tray 개수</th>
									</tr>
								</thead>
							</table>
						</div>
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
					</div>
					<div class="modal-footer" style="padding-top: 0px;">
						<button type="button" class="btn btn-secondary touch5" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 트레이 번호(poGroup) 모달 종료-->
	</main>
	<footer class="p-2" style="margin-top: auto;">
		<div class="mo_sumbox">
			<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
			<div class="row float-right">
				<div class="mo_roll mr-4">
					<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
				</div>
				<div class="mo_kg">
					<!--  
					<div class="custom-control custom-control-inline custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="goodsFifoCheckCd" disabled>
						<label class="custom-control-label" for="goodsFifoCheckCd">선입선출</label>
					</div>
					 -->
				</div>
				<div class="mo_kg">
					<span class="mo_sum_font_lg" id="remainQty">0</span><label>미출고수량</label>
					<!-- <span class="mo_sum_font_lg" id="outputQty">0</span><label>개수</label> -->
					<span class="mo_sum_font_lg" id="count">0</span><label>박스</label>
				</div>
			</div>
		</div>
	</footer>
</div>
<!-- /.app -->
<!-- 생산제품 선입선출 확인 모달 시작 -->
<div class="modal fade" id="goodsFifoCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">생산제품 선입선출</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="goodsFifoCheckLabel1"></h6>
				<h6 id="goodsFifoCheckLabel2"></h6>
				<h6 id="goodsFifoCheckLabel3"></h6>

				<!-- 선입선출 목록 -->
				<div>
					<table class="table table-sm table-bordered mb-0" style="width: 99%">
						<colgroup>
							<col width="18%">
							<col width="25%">
							<col width="15%">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th>제품명</th>
								<th>BoxNo</th>
								<th>입고일</th>
								<th>잔여수량</th>
						</tr>
						</thead>
					</table>

					<div style="height: 300px; overflow: auto;">
						<table class="table table-sm table-bordered" style="width: 100%" id="goodsFifoCheckTable">
							<colgroup>
								<col width="18%">
								<col width="25%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<tbody></tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnGoodsFifoCheck" data-dismiss="modal" style="min-width: 70px;">출하</button>
				<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" id="btnGoodsFifoCheckCancel" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산제품 선입선출 확인 모달 끝 -->
<!-- 출고 확인 모달 시작 -->
<div class="modal fade" id="goodsProductOutModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">출하 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="">출하하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnSaveCheck" data-dismiss="modal" style="min-width: 70px;">출하 확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>

			</div>
		</div>
	</div>
</div>
<!-- 출고 확인 모달 끝 -->

<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp"%>
<%@include file="../layout/bottom.jsp"%>
<!-- my-spinner 연결 -->

<script>

	$(document).attr("title","제품출고");
	let menuAuth = 'pdsc0010';
	var serverDate = "${serverDate}"
		
	var boxNo 				= null;	
	var goodsCd 			= null;
	var goodsNm 			= null;
	var packCnt	 			= null;
	var remainCnt 			= null;
	var userOutputCnt 		= null;
	var goodsFifoCheckNm	= null;
	var customerLotNo		= null;
	
	var count = 0;
	var exceptBoxNo = 'empty';		//스캔한 포장번호(선입선출에서 추가로 제외시킬애들);
	
	let factoryCode = "<%=factoryCode%>";

	$('#chooseDate').val(serverDate);
	$('#btnSelpoSeqCode').focus();

	$.fn.dataTable.ext.errMode = 'none';
	let boxCodeOutputWhsTable = $('#boxCodeOutputWhsTable').on('error.dt',
			function(e, settings, techNote, message) {
				if (techNote == 7) {
					toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {
						timeOut : 5000
					});
					location.href = "/";
				}
			}).DataTable({
		language : lang_kor,
		paging : false,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : false,
		searching : false,
		pageLength : 20,
		ajax : {
			url : '<c:url value="/tm/preGoodsOutputEmptyList"/>',
			type : 'GET',
			data : {
				'menuAuth' : menuAuth,
			},
		//         success : function(res) {
		//             console.log(res);
		//             rightSide = false;
		//         }
		},
		rowId : 'boxNo',
		columns : [ {
			render : function(data, type, row, meta) {
				var rowNo = meta.row + 1;
				if (rowNo == 1) {
					$('#btnSave').attr('disabled', false);
				}
				return meta.row + 1;
			}
		}, {
			data : 'goodsCd',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return goodsCd;
				}
			}
		}, {
			data : 'goodsNm',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return goodsNm;
				}
			}
		}, {
			data : 'boxNo',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return boxNo;
				}
			}
		}, {
			data : 'userOutputCnt',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					var html = addCommas(userOutputCnt);
					//var html = '<input type="text" class="form-control number-float0 text-right" min="0" max="' + remainCnt.replace(/,/g, '') + '" step="1" id="userOutputCnt" name="userOutputCnt" value="'+ userOutputCnt +'" style="min-width:98%;">';
					return html;
				}
			}
		},
		// 	        { 
		// 	            data: 'remainCnt', 
		// 		    		render: function(data, type, row, meta) {	
		// 		    			if(data != null) {
		// 		    				return data;
		// 		    			} else {
		// 		    				return  remainCnt;
		// 		    			}
		// 		    		}
		// 	        },
		{
			data : 'packCnt',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return packCnt;
				}
			}
		}, {
			data : 'goodsFifoCheckNm',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return goodsFifoCheckNm;
				}
			}
		}, {
			data : 'customerLotNo',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return customerLotNo;
				}
			}
		}, ],
		columnDefs : [ {
			"className" : "text-center",
			"targets" : "_all"
		} ],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');

			/* if (factoryCode == '003') {
				$(this).find('td').eq(8).addClass('d-none');
			} */
		},
	});

	var lineCheck = false;
	$('#boxCodeOutputWhsTable tbody').on(
			'click',
			'tr',
			function() {
				if ($(this).hasClass('selected')) {
					$(this).removeClass('selected');
					lineCheck = false;
				} else {
					$('#boxCodeOutputWhsTable').DataTable().$('tr.selected')
							.removeClass('selected');
					$(this).addClass('selected');
					lineCheck = true;
				}
			});

	//바코드 스캔시
	$("#boxNo").keypress(function(e) {
		// Promise
		//new Promise((resolve, reject) => {
		if (e.which == 13) {

			$("#boxNo").attr('disabled', true);

			if ($("#chooseDate").val() == null
					|| $("#chooseDate").val() == "") {
				$("#boxNo").attr('disabled', false);
				$("#boxNo").val("");
				$('#btnCalendar').focus();
				$("#chooseDate").focus();
				toastr.warning("출고일을 선택해주세요!");
				return false
			}
			if ($("#poSeq").val() == null
					|| $("#poSeq").val() == "") {
				$("#boxNo").attr('disabled', false);
				$("#boxNo").val("");
				$('#btnSelpoSeqCode').focus();
				toastr.warning("PO를 선택해주세요!");
				return false
			}
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#boxNo').val())) {
				toastr.warning('Box No를 스캔해주세요!');
				$("#boxNo").attr('disabled', false);
				$('#boxNo').focus();
				return false;
			}
			
			if (($('#boxNo').val().trim().length != "13")
					&& ($('#boxNo').val().trim().length != "14")) {
				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
				$("#boxNo").attr('disabled', false);
				$('#boxNo').select();
				return false;
			}

			var cval = compareBoxNo($('#boxNo').val().trim());
			if (cval == false) {
				toastr.warning('이미 추가된 박스번호 입니다.<br/> 박스정보를 확인해 주세요.','', {timeOut : 5000});
				$("#boxNo").attr('disabled', false);
				$('#boxNo').select();
				return false;
			}

			//let goodsFifoCheck = 'yes';
			//체크되어있으면 재입고 가능
			//if($('#goodsFifoCheckCd').prop('checked')) {
			//	goodsFifoCheckCd = 'yes';
			//} else {
			//	goodsFifoCheckCd = 'no';
			//}

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoAdmData"/>',
				type : 'GET',
				async : false,
				data : {
					'menuAuth' : menuAuth,
					'poSeq'			: function() { return $('#poSeq').val();		},
					'boxNo'			: function() { return $('#boxNo').val().trim();	},
					'goodsCd'		: function() { return $('#goodsCd').val();		},
					'exceptBoxNo'	: function() { return exceptBoxNo;				},
					//'ordGubun'	: function() { return $('#poGubunCd').val(); },
					//'goodsFifoCheckCd'	:		goodsFifoCheckCd,
					
				},
				beforeSend : function() {
					// Box No 박스 비활성화
					//$('#boxNo').prop('disabled',true); 
				},
				success : function(res) {
					
					let data = res.data;
					
					if (res.result == 'ok') {
						
						boxNo				= data.boxNo;
						goodsCd				= data.goodsCd;
						goodsNm				= data.goodsNm;
						packCnt				= addCommas(data.packCnt);
						remainCnt			= addCommas(data.remainCnt);
						userOutputCnt		= addCommas(data.userOutputCnt);
						goodsFifoCheckNm	= data.goodsFifoCheckNm;

						//선입선출 통제
						if (data.goodsFifoCheckCd == "001") {
							if (res.fifoCheck == "yes") {
								countPlus();
								exceptBoxNo += "/"+ boxNo;
								$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
								toastr.success(res.message);
							} else if (res.fifoCheck == "no") {
								$('#btnGoodsFifoCheck').addClass("d-none");
								$('#goodsFifoCheckLabel1').text(res.message1);
								$('#goodsFifoCheckLabel2').text(res.message2);
								$('#goodsFifoCheckLabel3').text(res.message3);
								$('#goodsFifoCheckTable tbody').empty();
								
								for (var i = 0; i < res.checkList.length; i++) {
									var rtn = '<tr><td style="text-align: center;">'
											+ res.checkList[i].goodsNm
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].boxNo
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].goodsInDate
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].remainCnt
											+ '</td></tr>';
									$('#goodsFifoCheckTable tbody').append(rtn);
								}

								$('#goodsFifoCheckPopupModal').modal({backdrop : 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
							}

						//선입선출 통제(확인)
						} else if (data.goodsFifoCheckCd == "002") {
							if (res.fifoCheck == "yes") {
								countPlus();
								exceptBoxNo += "/"+ boxNo;
								$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
								toastr.success(res.message);
							} else if (res.fifoCheck == "no") {
								$('#btnGoodsFifoCheck').removeClass("d-none");
								$('#goodsFifoCheckLabel1').text(res.message1);
								$('#goodsFifoCheckLabel2').text(res.message2);
								$('#goodsFifoCheckLabel3').text(res.message3);
								$('#goodsFifoCheckTable tbody').empty();
								
								for (var i = 0; i < res.checkList.length; i++) {
									var rtn = '<tr><td style="text-align: center;">'
											+ res.checkList[i].goodsNm
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].boxNo
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ moment(res.checkList[i].goodsInDate).format('YYYY-MM-DD');
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].remainCnt
											+ '</td></tr>';
									$('#goodsFifoCheckTable tbody').append(rtn);
								}

								$('#goodsFifoCheckPopupModal').modal({backdrop : 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
							}

						//선입선출 미적용
						} else if (data.goodsFifoCheckCd == "003") {
							countPlus();
							exceptBoxNo += "/" + boxNo;
							$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
							toastr.success(res.message);
							$('#boxNo').select();
						}

					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					}
				},
				complete : function() {
					$('#boxNo').prop('disabled', false).focus()
				}
			});
		}
		//    resolve();
		//})
		//.then(function(){
		//0.5초후 Box No 박스 활성화
		/*
		setTimeout(function(){
		    $('#boxNo').prop('disabled',false).focus();
		}, 500);
		 */
		//})
	});

	//1, 2공장 바코드 스캔시
	$("#firstBoxNo").keypress(function(e) {
		// Promise
		//new Promise((resolve, reject) => {
		if (e.which == 13) {
	
			$("#firstBoxNo").attr('disabled', true);
	
			if ($("#chooseDate").val() == null
					|| $("#chooseDate").val() == "") {
				$("#firstBoxNo").attr('disabled', false);
				$("#firstBoxNo").val("");
				$('#btnCalendar').focus();
				$("#chooseDate").focus();
				toastr.warning("출고일을 선택해주세요!");
				return false
			}
			if ($("#poSeq").val() == null
					|| $("#poSeq").val() == "") {
				$("#firstBoxNo").attr('disabled', false);
				$("#firstBoxNo").val("");
				$('#btnSelpoSeqCode').focus();
				toastr.warning("PO를 선택해주세요!");
				return false
			}
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#firstBoxNo').val())) {
				toastr.warning('Box No를 스캔해주세요!');
				$("#firstBoxNo").attr('disabled', false);
				$('#firstBoxNo').focus();
				return false;
			}
			if ($('#firstBoxNo').val().trim().length != "13"
					&& $('#firstBoxNo').val().trim().length != "14"
					&& $('#firstBoxNo').val().trim().length != "15") {
				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
				$("#firstBoxNo").attr('disabled', false);
				$('#firstBoxNo').select();
				return false;
			}
			
			/* if($('#addPallet').prop('checked')) {
				
			} else {
				if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
					toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
					$('#btnSelpoGroup').focus();
					return false;
				}
			} */
			
			var cval = compareBoxNo($('#firstBoxNo').val().trim());
			if (cval == false) {
				toastr.warning('이미 추가된 박스번호 입니다.<br/> 박스정보를 확인해 주세요.', '', { timeOut : 5000 });
				$("#firstBoxNo").attr('disabled', false);
				$('#firstBoxNo').select();
				return false;
			}

			//let goodsFifoCheck = 'yes';
			//체크되어있으면 재입고 가능
			//if($('#goodsFifoCheckCd').prop('checked')) {
			//	goodsFifoCheckCd = 'yes';
			//} else {
			//	goodsFifoCheckCd = 'no';
			//}

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoAdmData"/>',
				type : 'GET',
				async : false,
				data : {
					'menuAuth'		: menuAuth,
					'poSeq'			: function() { return $('#poSeq').val();			},
					'boxNo'			: function() { return $('#firstBoxNo').val().trim();},
					'goodsCd'		: function() { return $('#goodsCd').val();			},
					'exceptBoxNo'	: function() { return exceptBoxNo;					},
					'poGroup'		: function() { $('#poGroup').val();					},
					'addPallet'		: function() { $('#addPallet').prop('checked'); 	},
					
					//'ordGubun'		:		function() { return $('#poGubunCd').val(); },
					//'goodsFifoCheckCd':		goodsFifoCheckCd,
				},
				beforeSend : function() {
					// Box No 박스 비활성화
					//$('#firstBoxNo').prop('disabled',true); 
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') {
						
						boxNo 				= data.boxNo;
						goodsCd				= data.goodsCd;
						goodsNm				= data.goodsNm;
						packCnt				= addCommas(data.packCnt);
						remainCnt			= addCommas(data.remainCnt);
						userOutputCnt		= addCommas(data.userOutputCnt);
						goodsFifoCheckNm	= data.goodsFifoCheckNm;

						//console.log(data.goodsFifoCheckCd);

						//선입선출 통제
						if (data.goodsFifoCheckCd == "001") {
							if (res.fifoCheck == "yes") {
								/*countPlus();
								exceptBoxNo += "/" + boxNo;
								$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);*/

								setTimeout(function() {
									$('#firstBoxNo').attr('disabled', true);
									$('#secondCustomerLotNo').attr('disabled', false);
									$('#secondCustomerLotNo').focus();
								}, 300);

								//toastr.success(res.message);
							} else if (res.fifoCheck == "no") {
								$('#btnGoodsFifoCheck').addClass("d-none");
								$('#goodsFifoCheckLabel1').text(res.message1);
								$('#goodsFifoCheckLabel2').text(res.message2);
								$('#goodsFifoCheckLabel3').text(res.message3);
								$('#goodsFifoCheckTable tbody').empty();
								
								for (var i = 0; i < res.checkList.length; i++) {
									var rtn = '<tr><td style="text-align: center;">'
											+ res.checkList[i].goodsNm
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].boxNo
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].goodsInDate
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].remainCnt
											+ '</td></tr>';
									$('#goodsFifoCheckTable tbody').append(rtn);
								}
	
								$('#goodsFifoCheckPopupModal').modal({backdrop : 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
							}

								//선입선출 통제(확인)
						} else if (data.goodsFifoCheckCd == "002") {
							
							if (res.fifoCheck == "yes") {
								/*countPlus();
								exceptBoxNo += "/" + boxNo;
								$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
								toastr.success(res.message);*/

								setTimeout(function() {
									$('#firstBoxNo').attr('disabled',true);
									$('#secondCustomerLotNo').attr('disabled',false);
									$('#secondCustomerLotNo').focus();
								}, 300);

							} else if (res.fifoCheck == "no") {
								$('#btnGoodsFifoCheck').removeClass("d-none");
								$('#goodsFifoCheckLabel1').text(res.message1);
								$('#goodsFifoCheckLabel2').text(res.message2);
								$('#goodsFifoCheckLabel3').text(res.message3);
								$('#goodsFifoCheckTable tbody').empty();
								
								for (var i = 0; i < res.checkList.length; i++) {
									var rtn = '<tr><td style="text-align: center;">'
											+ res.checkList[i].goodsNm
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].boxNo
											+ '</td>';
									rtn += '<td style="text-align: center;">'
											+ moment(res.checkList[i].goodsInDate).format('YYYY-MM-DD');
											+'</td>';
									rtn += '<td style="text-align: center;">'
											+ res.checkList[i].remainCnt
											+ '</td></tr>';
									$('#goodsFifoCheckTable tbody').append(rtn);
								}

								$('#goodsFifoCheckPopupModal').modal({backdrop : 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
							}

								//선입선출 미적용
						} else if (data.goodsFifoCheckCd == "003") {
							/*countPlus();
							exceptBoxNo += "/" + boxNo;
							// 								$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
							toastr.success(res.message);
							$('#firstBoxNo').select();*/

							setTimeout(function() {
								$('#firstBoxNo').attr('disabled',true);
								$('#secondCustomerLotNo').attr('disabled',false);
								$('#secondCustomerLotNo').focus();
							}, 300);
						}

					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#firstBoxNo').select();
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#firstBoxNo').select();
					}
				},
				complete : function() {
					$('#firstBoxNo').prop('disabled', false).focus()
				}
			});
		}
		//    resolve();
		//})
		//.then(function(){
		//0.5초후 Box No 박스 활성화
		/*
		setTimeout(function(){
		    $('#firstBoxNo').prop('disabled',false).focus();
		}, 500);
		 */
		//})
	});

	//1, 2공장 바코드 스캔시
	$("#secondCustomerLotNo").keypress(function(e) {
		if (e.which == 13) {
			countPlus();
			exceptBoxNo += "/" + boxNo;
			customerLotNo = $('#secondCustomerLotNo').val();
			$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
			toastr.success("추가되었습니다.");

			$('#firstBoxNo').attr('disabled', false);
			$('#secondCustomerLotNo').attr('disabled', true);
			$('#firstBoxNo').val('');
			$('#secondCustomerLotNo').val('');
			$('#firstBoxNo').focus();
		}
	});

	//002 선입선출경고에도 확인버튼 클릭 시 
	$('#btnGoodsFifoCheck').on('click', function() {

		if (factoryCode == "001" || factoryCode == "002") {
			$('#goodsProductOutModal').modal('hide');
			$('#firstBoxNo').attr('disabled', true);
			$('#secondCustomerLotNo').attr('disabled', false);
			$('#secondCustomerLotNo').focus();
		} else if (factoryCode == "003") {
			countPlus();
			exceptBoxNo += "/" + boxNo;
			$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
		} else {
			toastr.error("시스템 오류가 발생했습니다.", '', {
				timeOut : 5000
			});
		}

	});

	$('#btnSave').on('click', function() {
		if($('#addPallet').prop('checked')) {
	
		} else {
			if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
				toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
				$('#btnSelpoGroup').focus();
				return false;
			}
		}

		$('#goodsProductOutModal').modal('show');
		
	});

	//저장 처리
	$('#btnSaveCheck').on('click', function() {
		if (!$.trim($('#chooseDate').val())) {
			toastr.warning('출고일을 선택해주세요.');
			return false;
		}
		if ($("#poSeq").val() == null || $("#poSeq").val() == "") {
			$("#boxNo").val(null);
			$("#firstBoxNo").val(null);
			toastr.warning("PO를 선택해주세요.");
			return false
		}

		if($('#addPallet').prop('checked')) {
			
		} else {
			if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
				toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
				$('#btnSelpoGroup').focus();
				return false;
			}
		}
		$('#my-spinner').show();

		if (createBoxNo()) {
			$.ajax({
				url : '<c:url value="/pd/outWhsPOST"/>',
				type : 'POST',
				data : JSON.stringify(boxNoList),
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						$('.number-float0').attr('disabled', true);
						$('#btnAllClear').attr('disabled', true);
						$('#btnLineClear').attr('disabled', true);
						$('#btnSave').attr('disabled', true);
						$('#boxNo').attr('disabled', true);
						$('#firstBoxNo').attr('disabled', true);
						$('#btnSelpoGroup').attr('disabled', true);
						$('#btnCancel').addClass('d-none');
						$('#btnNew').removeClass('d-none');
						toastr.success('제품출고 처리되었습니다.');
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#btnCancel').focus();
						//$('#boxNo').select();
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
						if (factoryCode == "001" || factoryCode == "002") {
							$('#firstBoxNo').focus();
						} else {
							$('#boxNo').focus();
						}
					}
				},
				complete : function() {
					$('#my-spinner').hide();
				}
			});
		}
	});

	var boxNoList;
	var valueCheck = true;
	
	function createBoxNo() {
		boxNoList = new Array();
		valueCheck = true;
		$('#boxCodeOutputWhsTable tbody tr').each(function() {
			//출하수량 0인지 체크
			//if ($(this).find('td input[name=userOutputCnt]').val() == "0" ) {
			//	toastr.warning('출하수량을 입력해주세요!');
			//	$(this).find('td input[name=userOutputCnt]').select();
			//	valueCheck = false;
			//	return false;
			//}
			var poSeq			= $("#poSeq").val();
			var goodsCd			= $("#goodsCd").val();
			var goodsOutDate	= $("#chooseDate").val().replace(/-/g, '');
			var boxNo1			= $(this).find('td').eq(3).html();
			var userOutputCnt	= removeCommas($(this).find('td').eq(4).html());
			var packCnt			= removeCommas($(this).find('td').eq(5).html());
			var number			= removeCommas($(this).find('td').eq(0).text());

			//var userOutputCnt	= removeCommas($(this).find('td input[name=userOutputCnt]').val());
			//var remainCnt		= removeCommas($(this).find('td').eq(5).html());

			var rowData = new Object();
			rowData.menuAuth		= menuAuth;
			rowData.poSeq			= poSeq;
			rowData.poGroup			= $('#poGroup').val();
			rowData.addPallet		= $('#addPallet').prop('checked');
			rowData.goodsCd			= goodsCd;
			rowData.packCnt			= packCnt.replace(/,/g, '');
			rowData.goodsOutDate	= goodsOutDate;
			rowData.boxNo1			= boxNo1;
			rowData.remainCnt		= remainCnt;
			rowData.number			= number;
			rowData.userOutputCnt	= userOutputCnt;
			rowData.customerLotNo	= $(this).find('td').eq(7).text();
			boxNoList.push(rowData);
		});
		// 		console.log(boxNoList);
		return valueCheck;
	}

	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#boxNo').val('');
		$('#firstBoxNo').val('');
		
		if (factoryCode == "001" || factoryCode == "002") {
			$('#firstBoxNo').focus();
		} else {
			$('#boxNo').focus();
		}
		
		count = 0;
		exceptBoxNo = 'empty';
		$('#count').text(count);
	});

	//라인 삭제ddd
	$('#btnLineClear').on('click', function() {
		
		if (lineCheck == true) {
			//선택한 boxNo 선입선출 제외명단에서 제외
			let selectBoxNo = $("#boxCodeOutputWhsTable").find(".selected").find("td:eq(3)").text();
			exceptBoxNo		= exceptBoxNo.replace("/" + selectBoxNo, "");
	
			$('#boxCodeOutputWhsTable').DataTable().rows('.selected').remove().draw();
			$("#boxNo").val("");
			$("#firstBoxNo").val("");
	
			if (factoryCode == "001" || factoryCode == "002") {
				$('#firstBoxNo').focus();
			} else {
				$('#boxNo').focus();
			}
	
			var rowCnt = $('#boxCodeOutputWhsTable').DataTable().data().count();
			
			if (rowCnt == 0) {
				$('#btnSave').attr('disabled', true);
				$('#btnAllClear').attr('disabled', true);
				$('#btnLineClear').attr('disabled', true);
			}
			count -= 1;
			$('#count').text(count);
		} else {
			toastr.warning('삭제할 라인을 선택하세요.');
		}
	});

	//취소 버튼
	$('#btnCancel').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#btnSelpoSeqCode').attr('disabled', false);
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);

		$('#firstBoxNo').attr('disabled', false);
		$('#secondCustomerLotNo').attr('disabled', true);
		$('#firstBoxNo').val('');
		$('#secondCustomerLotNo').val('');

		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		$('#boxNo').val('');
		$('#firstBoxNo').val('');

		if (factoryCode == "001" || factoryCode == "002") {
			$('#firstBoxNo').focus();
		} else {
			$('#boxNo').focus();
		}

		$('#chooseDate').val(serverDate);
		count = 0;
		$('#count').text(count);
		exceptBoxNo = 'empty';
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#btnSelpoSeqCode').attr('disabled', false);
		$('#boxNo').attr('disabled', false);
		$('#firstBoxNo').attr('disabled', false);
		$('#btnSelpoGroup').attr('disabled', false);
		$("#addPallet").prop("checked", false); 
		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		$('#poGroup').val('');
		$('#poGubunCd').val('');
		$('#goodsCd').val('');
		$('#poSeq').val('');
		$('#poNo').val('');
		$('#boxNo').val('');
		$('#firstBoxNo').val('');
		if (factoryCode == "001" || factoryCode == "002") {
			$('#firstBoxNo').focus();
		} else {
			$('#boxNo').focus();
		}
		$('#chooseDate').val(serverDate);
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
		exceptBoxNo = 'empty';
	});

	//중복 예외처리 사용예정
	function compareBoxNo(boxNo) {
		var result = true;
		$('#boxCodeOutputWhsTable tbody tr').each(function() {
			var tboxNo = $(this).find('td').eq(3).text();
			if (boxNo == tboxNo) {
				result = false;
				return result;
			}
		});

		return result;
	}

	//구매주문관리조회 팝업 시작
	var poPopUpTable;
	function selectPoCode() {
		if (poPopUpTable == null || poPopUpTable == undefined) {
			// 목록
			poPopUpTable = $('#poPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				//scrollY : 500,
				//responsive: true,
				ajax : {
					url : '<c:url value="/bs/purchaseOrderDataList"/>',
					type : 'GET',
					data : {
						'menuAuth' : menuAuth,
					},
				/*
				success : function(res) {
				    console.log(res);
				}
				 */
				},
				rowId : 'poSeq',
				columns : [ {
					data : 'deliveryDate',
					render : function(data, type, row) {
						return moment(data).format('YYYY-MM-DD');
					}
				}, {
					data : 'deadLine',
					render : function(data, type, row) {
						return moment(data).format('YYYY-MM-DD');
					}
				},{
					data : 'poNo'
				}, {
					data : 'goodsNm'
				}, {
					data : 'poQty'
				}, {
					data : 'remainQty'
				}, {
					data : 'poCode'
				}, ],
				columnDefs : [ {
					targets : [ 0, 1, 2, 3,6 ],
					className : "text-center"
				}, {
					targets : [ 4, 5 ],
					className : 'text-right-td'
				}, {
					targets : [ 4, 5 ],
					render : $.fn.dataTable.render.number(',')
				}, ],
				order : [ [ 0, 'desc' ] ]

			});
			$('#poPopUpTable tbody').on('click', 'tr', function() {
				var data = poPopUpTable.row(this).data();
				if (data.remainQty == 0) {
					toastr.warning("미출고수량이 0인 PO는 선택 하실 수 없습니다!")
				} else {
					$('#poSeq').val(data.poSeq);
					$('#poNo').val(data.poNo);
					$('#poGubunCd').val(data.poGubunCd);
					$('#goodsCd').val(data.goodsCd);
					$('#remainQty').text(addCommas(data.remainQty));
					$('#poPopUpModal').modal('hide');
					if (factoryCode == "001") {
						$('#firstBoxNo').focus();
					} else if (factoryCode == "002") {
						$('#btnSelpoGroup').focus();
					} else {
						$('#boxNo').focus();
					}
					exceptBoxNo = 'empty';
				}
			});
		} else {
			$('#poPopUpTable').DataTable().ajax.reload();
		}

		$('#poPopUpModal').modal('show');
	}
	//구매주문관리조회 팝업 종료

	//트레이 번호(poGroup) 목록 팝업 시작
	var poGroupPopUpTable;
	function selectPoGroup() {
		if ($('#poSeq').val == null || $('#poSeq').val() == '') {
			toastr.warning("PO Number를 먼저 선택해 주세요!");
			$('#btnSelpoSeqCode').focus();
			return false;
		}
		if (poGroupPopUpTable == null || poGroupPopUpTable == undefined) {
			// 목록
			poGroupPopUpTable = $('#poGroupPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				//scrollY : 500,
				//responsive: true,
				ajax : {
					url : '<c:url value="/bs/outputHistList"/>',
					type : 'GET',
					data : {
						'menuAuth'	:	menuAuth,
						'poSeq'		:	function() { return $('#poSeq').val(); },	
					},
				/*
				success : function(res) {
				    console.log(res);
				}
				 */
				},
				rowId : 'poGroup',
				columns : [
				{
					data : 'poGroup'
				}, {
					data : 'outputQty'
				}, {
					data : 'trayCnt'
				},
				],
				columnDefs : [{
					targets : [ 0 ],
					className : "text-center"
				},
				{
					targets : [ 1, 2 ],
					className : 'text-right-td'
				}, {
					targets : [ 1, 2 ],
					render : $.fn.dataTable.render.number(',')
				}, ],
				order : [ [ 0, 'asc' ] ]
			});
			$('#poGroupPopUpTable tbody').on('click', 'tr', function() {
				var data = poGroupPopUpTable.row(this).data();
				$('#poGroup').val(data.poGroup);
				$('#firstBoxNo').focus();
				$('#poGroupPopUpModal').modal('hide');
			});
			
		} else {
			$('#poGroupPopUpTable').DataTable().ajax.reload();
		}

		$('#poGroupPopUpModal').modal('show');
	}
	//트레이 번호(poGroup) 목록 팝업 종료
	
	//콤마(,) 생성
	function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	//콤마(,) 생성
	function countPlus() {
		$('#btnSave').attr('disabled', false);
		$('#btnCalendar').attr('disabled', true);
		$('#btnSelpoSeqCode').attr('disabled', true);
		$('#btnLineClear').attr('disabled', false);
		$('#btnAllClear').attr('disabled', false);
		$('#boxNo').val("");
		$('#firstBoxNo').val("");
		if (factoryCode == "001" || factoryCode == "002") {
			$('#firstBoxNo').focus();
		} else {
			$('#boxNo').focus();
		}
		count += 1;
		$('#count').text(count);
	}

	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {

		if (factoryCode == "001" || factoryCode == "002") {
			var inputmode = $('#firstBoxNo').attr('inputmode');
			if (inputmode == 'none') {
				$('#btnKeyboard').text("자판 On");
				$('#firstBoxNo').attr('inputmode', 'text');
			} else if (inputmode == 'text') {
				$('#btnKeyboard').text("자판 Off");
				$('#firstBoxNo').attr('inputmode', 'none');
			}
			
			var inputmode = $('#secondCustomerLotNo').attr('inputmode');
			if (inputmode == 'none') {
				$('#btnKeyboard').text("자판 On");
				$('#secondCustomerLotNo').attr('inputmode', 'text');
			} else if (inputmode == 'text') {
				$('#btnKeyboard').text("자판 Off");
				$('#secondCustomerLotNo').attr('inputmode', 'none');
			}
			
		} else {
			var inputmode = $('#boxNo').attr('inputmode');
			if (inputmode == 'none') {
				$('#btnKeyboard').text("자판 On");
				$('#boxNo').attr('inputmode', 'text');
			} else if (inputmode == 'text') {
				$('#btnKeyboard').text("자판 Off");
				$('#boxNo').attr('inputmode', 'none');
			}
		}
	});

	$('#addPallet').on('click', function(){
		if ($(this).prop('checked')) {
			$('#poGroup').val('');
			$('#btnSelpoGroup').attr('disabled', true);
		} else {
			$('#btnSelpoGroup').attr('disabled', false);
		}
	});
	
	//숫자만 입력, 길이, 소수점 한자리까지 제한
	$(document).on('keyup', '.number-float0', function(event) {

		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}

		var temp = $(this).val();
		temp = removeCommas(temp);
		temp = temp.replace(/[^0-9]/g, "");

		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		if (parseFloat($(this).attr("max")) < parseFloat(temp)) {
			toastr.warning('잔여수량보다 큰 수를 입력 하실 수 없습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		if (parseFloat($(this).attr("min")) > parseFloat(temp)) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		if (temp == "") {
			temp = 0;
		}

		$(this).val(addCommas(parseFloat(temp)));
	});
	/* 
	 $(document).on('keyup','.number-float0', function(event) {
	 if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 189)	) {
	 $('.number-float0').on("blur keyup", function() {
	 $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	 });
	 toastr.warning('양수(+)만 입력해주세요.');
	 $(this).val("");
	 $(this).val("0");
	 $(this).select();
	 event.preventDefault();
	 return false;
	 }
	 if ($(this).val() == "00" || $(this).val() == "") {
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }

	 var temp = $(this).val();
	 temp = removeCommas(temp);
	
	 if ($(this).attr("maxlength") < temp.length) {
	 toastr.warning('최대 입력 글자를 초과하였습니다.');
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }
	 if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
	 toastr.warning('잔여수량보다 큰 수를 입력 하실 수 없습니다.');
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }
	 if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
	 toastr.warning('최소 크기를 초과하였습니다.');
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }
	 if ( event.which == 110 || event.which == 190 ) {
	 toastr.warning('정수만 입력 가능합니다.');
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }
	 // .개수 세기
	 //if ( $(this).val().split('.').length > 1  ) {
	 //	toastr.warning('소수점은 한번만 입력해주세요.');
	 //	$(this).val("0");
	 //	$(this).select();
	 //	return false;
	 //}
	 var _pattern2 = /^\d*[.]\d{1}$/;
	 if (_pattern2.test( temp)) {
	 toastr.warning("정수만 입력 가능합니다.");
	 $(this).val("0");
	 $(this).select();
	 return false;
	 }

	 $(this).val(addCommas(temp));
	 });
	 */
	$(document).on('click', '.form-control', function(event) {
		$(this).select();
	});

	$('#btnGoodsFifoCheckCancel').on('click', function() {
		$('#goodsFifoCheckPopupModal').modal('hide');
		if (factoryCode == "001" || factoryCode == "002") {
			$('#firstBoxNo').focus();
		} else {
			$('#boxNo').focus();
		}
	});
</script>

</body>
</html>
