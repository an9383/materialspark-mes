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
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc3040"><p class="mo_main_title">폐기등록</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
	
		<!-- 파레트 스캔 -->
		<div class="col-12 row p-1">
			<div class="col-4 mo_sort_title">박스 스캔</div>
			<div class="form-group input-sub col-8 m-0 p-0 row">
				<input type="text" class="form-control-md" id="boxNo" inputmode="none">
			</div>
		</div>
		<!--  -->
		

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
			<button type="button" class="btn btn-primary float-right mr-2" id="btnDisuse" disabled>저장</button>
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
								<th style="min-width: 40px">포장 수량</th>						
								
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
						<div class="row">
							<label class="mt-1">납기일</label>
							<div class="form-group input-sub ml-2 mb-1 row" style="min-width: 65%">
								<input class="form-control" style="max-width:54%;" type="date" id="deliveryDate" name="deliveryDate">
								<button type="button" class="btn btn-primary touch4 ml-2" id="allRetv" name="allRetv">전체조회</button>
							</div>
						</div>
						<div class="table-responsive">
							<table id="poPopUpTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width: 70px">납기일</th>
										<th style="min-width: 140px">PO Number</th>
										<th style="min-width: 120px">제품명</th>
										<th style="min-width: 90px">오더량</th>
										<th style="min-width: 90px">미출고량</th>
										<th style="min-width: 90px">코드</th>
										<th style="min-width: 90px">거래처</th>
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
										<th style="min-width:50px">
											<input type="checkbox" style="width:20px; height:20px; margin-top:5px;" id="checkAll" name="checkAll">
										</th>
										<th style="min-width:90px">파레트번호</th>
										<th style="min-width:60px">출고량</th>
										<th style="min-width:60px">적재 Tray 개수</th>
										<th style="min-width:60px">구분(완공&미료)</th>
										<th style="min-width:60px">상태</th>
									</tr>
								</thead>
							</table>
						</div>
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
					</div>
					<div class="modal-footer" style="padding-top: 0px;">
						<button type="button" class="btn btn-primary touch5" id="poGroupSel" name="poGroupSel">확정</button>
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
					<div class="custom-control custom-control-inline custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="checkGubun" disabled>
						<label class="custom-control-label" for="checkGubun">검색</label>
					</div>
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
					<!-- <span class="mo_sum_font_lg" id="remainQty">0</span><label>미출고수량</label> -->
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
<!-- 출고 확인 모달 시작 -->
<div class="modal fade" id="goodsProductOutModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id=""> 확인</h5>
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

	$(document).attr("title","폐기등록");
	let menuAuth = 'pdsc3020';
	var serverDate = "${serverDate}";
	var serverDateFrom =  "${serverDateFrom}"; 
    var serverDateTo =  "${serverDateTo}";
		
	var boxNo 				= null;	
	var goodsCd 			= null;
	var goodsNm 			= null;
	var packCnt	 			= null;
	var remainCnt 			= null;
	var userOutputCnt 		= null;
	var goodsFifoCheckNm	= null;
	var customerLotNo		= null;
	var disposeGubun		= null;

	var count = 0;
	var exceptBoxNo = 'empty';		//스캔한 포장번호(선입선출에서 추가로 제외시킬애들);
	var exceptPallet = 'empty';
	
	let factoryCode = "<%=factoryCode%>";

	$('#chooseDate').val(serverDate);
	$('#deliveryDate').val(serverDate);
	$('#btnSelpoSeqCode').focus();
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

	$(document).ready(function(){ 
		$('#checkGubun').attr('disabled',false);
	});

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
		},
		rowId : 'boxNo',
		columns : [ {
			render : function(data, type, row, meta) {
				var rowNo = meta.row + 1;
				if (rowNo == 1) {
					$('#btnDisuse').attr('disabled', false);
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
		},
		{
			data : 'remainCnt',
			render : function(data, type, row, meta) {
				if (data != null) {
					return data;
				} else {
					return remainCnt;
				}
			}
		},
		
		 ],
		columnDefs : [ {
			"className" : "text-center",
			"targets" : "_all"
		} ],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		rowCallback: function (row, data) {
			if (data.disposeGubun=="003") {
				$(row).addClass('whiteRed');
			}
		},			
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

				
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#boxNo').val())) {
				toastr.warning('Box No를 스캔해주세요!');
				$("#boxNo").attr('disabled', false);
				$('#boxNo').focus();
				return false;
			}
			
			if (($('#boxNo').val().trim().length != "18")) {
				toastr.warning('Box No가 아닙니다. 확인해주세요');
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

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoAdmData3"/>',
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
						
						countPlus();
						exceptBoxNo += "/" + boxNo;
						$('#boxCodeOutputWhsTable').DataTable().row.add({
							'disposeGubun'	:	data.disposeGubun
						}).draw(false);
						toastr.success(res.message);
						$('#boxNo').select();
						

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


	var boxNoList;
	var valueCheck = true;
	


	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnDisuse').attr('disabled', true);
		$('#boxNo').val('');
		$('#firstBoxNo').val('');
		
		
		$('#boxNo').focus();
		
		
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
	
		
			$('#boxNo').focus();
			
	
			var rowCnt = $('#boxCodeOutputWhsTable').DataTable().data().count();
			
			if (rowCnt == 0) {
				$('#btnDisuse').attr('disabled', true);
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
		$('#btnDisuse').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);

		$('#firstBoxNo').attr('disabled', false);
		$('#secondCustomerLotNo').attr('disabled', true);
		$('#firstBoxNo').val('');
		$('#secondCustomerLotNo').val('');

		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		$('#boxNo').val('');
		$('#firstBoxNo').val('');
	
		$('#boxNo').focus();
		

		$('#chooseDate').val(serverDate);
		count = 0;
		$('#count').text(count);
		exceptBoxNo = 'empty';
		exceptPallet = 'empty';
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

	
	let chkCnt = 0;


	//콤마(,) 생성
	function addCommas(x) {
		if( x != null && x != "" &&  x != 0 ) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");		
		} else {
			return x;
		}
	}

	//콤마(,) 생성
	function countPlus() {
		$('#btnDisuse').attr('disabled', false);
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

	$(document).on('click', '.form-control', function(event) {
		$(this).select();
	});


	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구분체크시 분류선택 히든처리ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	$('#checkGubun').change(function(){
		if ($('#checkGubun').prop('checked')) {
			$('#poNum').val("");
			$('#boxNo').val("");
			$('#hiddenToggle').show();
		$('#poNum').focus();
		} else {
			$('#boxNo').val("");
			$('#hiddenToggle').hide();
		}
	});
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ구분체크시 분류선택 히든처리ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ //
	
	//PDA 파레트 관련 제품  조회 함수
	function sudel() {
		
		$.ajax({
			url : '<c:url value="/pd/palletRelatedProductList_F3"/>',
			type : 'GET',
			async : false,
			data : {
				'menuAuth'		: menuAuth,
				'poSeq'			: function() { return $('#poSeq').val();	},
				'poGroup'		: function() { return $('#poGroup').val();	},
			},
			success : function(res) {
				let data = res.data;
				
				if (res.result == 'ok') {
					
					for(var i=0; i< data.length; i++) {
					    boxNo 				= data[i].boxNo;
						goodsCd				= data[i].goodsCd;
						goodsNm				= data[i].goodsNm;
						packCnt				= addCommas(data[i].packCnt);
						remainCnt			= addCommas(data[i].remainCnt);
						//userOutputCnt		= addCommas(data[i].userOutputCnt);
						userOutputCnt		= addCommas(data[i].packCnt);
						goodsFifoCheckNm	= data[i].goodsFifoCheckNm;
						customerLotNo 		= data[i].customerLotNo;
						disposeGubun		= data[i].disposeGubun;
						$('#boxCodeOutputWhsTable').DataTable().row.add({
							'disposeGubun'	:	data[i].disposeGubun
						}).draw(false);

						
					}

					if(chkCnt == 0){
						toastr.success('추가되었습니다.');
					}
					
					
				}
				
			},
			complete : function() {}
		});
	}
	
	//파레트 바코드 스캔시
	$("#poNum").keydown(function() {
		if(event.keyCode == 13){
			let poNumVal = $('#poNum').val();

			if( poNumVal == "" ) {
				toastr.warning("올바르지 않은 코드입니다.", '', {timeOut : 5000});
				return false;
			}
			
			//PO정보 불러오는 부분
			$.ajax({
				url : '<c:url value="/pd/poSeqSerchRead"/>',
				type : 'GET',
				data : {
					'menuAuth'		: menuAuth,
					'poGroup'		: function() { return $('#poNum').val();	},
					'completeYn'	:	function() { return "'Y'";				},
					'goodsStatus'	:	function() { return "'004'";			},
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') {
						$('#poNo').val(data.poNo);
						$('#poSeq').val(data.poSeq);
						$('#poGroup').val($('#poNum').val());
						
						$('#btnAllClear').attr('disabled', false); 
						sudel();
					} else if ( res.result == 'fail' ) {
						$('#poNo').val("");
						$('#poSeq').val("");
						$('#poGroup').val($('#poNum').val());
						$('#boxCodeOutputWhsTable').DataTable().clear().draw();
						toastr.warning(res.message, '', { timeOut : 5000 });
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {}
			});
			//PO정보 불러오는 부분
			
			event.preventDefault();	//enterEventend
		}
	});
	


	//폐기
	$('#btnDisuse').on('click', function() {
		if ($('#boxCodeOutputWhsTable').DataTable().data().length == 0) {
			toastr.warning("폐기 처리할 제품을 선택해주세요!");
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
    	$('#faultyDesc').val("");    	    	

    	approvalCd = '005';

    	$('#faultyTypeDisplay').removeClass('d-none');
    	$('#outputChk').addClass('d-none');
		$('#faultyPopUpModal').modal('show');
    });

	function updateGoodsFaultyStatus(faultyStatus)
    {
		$('#my-spinner').show();
		var dataArray = new Array();

		var faultyDate = $('#faultyDate').val().replace(/-/g, '');
		var faultyDesc = $('#faultyDesc').val();
		var faultyType = '';
		let disposeGubun = '';
		let mergeCheck = true;

		for (let i=0; i<goodsFaultyType.length; i++) {
			if($('#faultyType' + goodsFaultyType[i].baseCd).prop("checked")) {
				faultyType += '1';
			} else {
				faultyType += '0';
			}
		}
		
		$('#boxCodeOutputWhsTable tbody tr').each(function() {	
			var rowData = new Object();	
			var boxNo	= $(this).find('td').eq(3).text();	
			
			rowData.menuAuth		= menuAuth;
			rowData.boxNo			= boxNo;
			rowData.faultyStatus	= faultyStatus;
			rowData.faultyDate		= $('#faultyDate').val() + ' ' + getTodayTime();
			rowData.faultyType		= faultyType;
			rowData.faultyDesc		= faultyDesc;
			rowData.disposeGubun	= '004';		
			dataArray.push(rowData);
			
		});
		
		
		
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
                	$('.number-float0').attr('disabled', true);
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					$('#btnDisuse').attr('disabled', true);
					$('#boxNo').attr('disabled', true);
					$('#firstBoxNo').attr('disabled', true);
					$('#btnSelpoGroup').attr('disabled', true);
					$('#btnCancel').addClass('d-none');
					$('#btnNew').removeClass('d-none');
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
            		$('#boxCodeOutputWhsTable').DataTable().ajax.reload( function () {
            			
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

	$('#btnFaultySave').on('click', function() {	
		updateGoodsFaultyStatus("005");		
	});

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
