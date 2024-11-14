<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/topPda.jsp"%>
<style>
body {
	overflow: hidden;
}
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex; flex-direction: column; height: 100%;">
	<header class="pda_mo_hd">
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0030"><p class="mo_main_title">파레트 포장</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">포장일</div> <!-- 입고일 -->
			<div class="form-group input-sub col-9 m-0 p-0">
				<input class="form-control-md" type="text" id="chooseDate" disabled />
				<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button" id="btnCalendar">
					<span class="oi oi-calendar"></span>
				</button>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<input type="hidden" class="form-control" id="poGubunCd" name="poGubunCd">
			<input type="hidden" class="form-control" id="goodsCd" name="goodsCd">
			<div class="col-3 mo_sort_title">PO Number</div>
			<div class="form-group input-sub col-9 m-0 p-0">
			
				<input type="hidden"	class="form-control-md" id="poSeq"		name="poSeq"		disabled>
				<input type="hidden"	class="form-control-md" id="poModelNo"	name="poModelNo"	disabled>
				<input type="text"		class="form-control-md" id="poNo"		name="poNo"			disabled>
				
				<button type="button"	class="btn btn-primary input-sub-search-md" id="btnSelpoSeqCode" onClick="selectPoCode()">
					<span class="oi oi-magnifying-glass"></span>
				</button>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">
				<label class="" for="addPallet" >파레트 추가</label>
				<input type="checkbox" class="" id="addPallet" style="width:15px; height:15px;">
			</div>
			<div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" id="poGroup" name="poGroup" disabled>
				<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelpoGroup" onClick="selectPoGroup()">
					<span class="oi oi-magnifying-glass"></span>
				</button>
			</div>
		</div>
		
		<div class="col-12 row p-1">
			<div class="col-3 mo_sort_title">Box No</div>
			
			<div class="form-group input-sub col-9 m-0 p-0">
				<div class="row">
					<input type="text" class="form-control-md" style="width: 50%;" id="boxNo" inputmode="none" placeholder="barcodeNo를 먼저스캔해주세요.">
					<input type="text" class="form-control-md" style="width: 50%;" id="secondCustomerLotNo" inputmode="none" maxlength="30" max="30" placeholder="고객사 LotNo스캔해주세요." disabled>
				</div>
			</div>
			
			<!-- <div class="form-group input-sub col-9 m-0 p-0">
				<input type="text" class="form-control-md" id="boxNo" inputmode="none">
			</div> -->
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
	<!--end버튼영역-->
	<!--end-sortbox-->
	<main style="height: calc(100vh - 50px); overflow: auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%; display: flex; flex-direction: column;">
			<div class="card mo_card" style="OVERFLOW-Y: auto; width: 100%;">
				<div class="table-responsive">
					<table id="GoodsProductInfoTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 30px">순번</th>
								<th style="min-width: 40px">제품코드</th>
								<th style="min-width: 80px">제품명</th>
								<th style="min-width: 80px">박스번호</th>
								<th style="min-width: 50px">포장 수량</th>
								<th style="min-width: 50px">입고 수량</th>
								<th style="min-width: 80px">고객사LotNo</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
	</main>
	<footer class="p-2" style="margin-top: auto;">
		<div class="mo_sumbox">
			<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
			<div class="row float-right">
				<div class="mo_roll mr-4">
					<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
				</div>
				<div class="mo_kg">
					<!-- <input type="checkbox" id="checkRestock" style="zoom:1.6; margin-top:2px; margin-right:3px;">
					<label>재입고</label> -->
					<div class="custom-control custom-control-inline custom-checkbox d-none">
						<input type="checkbox" class="custom-control-input" id="checkRestock">
						<label class="custom-control-label" for="checkRestock">재입고</label>
					</div>
				</div>
				<div class="mo_kg">
					<span class="mo_sum_font_lg" id="count">0</span><label>개수</label>
				</div>
			</div>
		</div>
	</footer>
</div>
<!-- /.app -->

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
								<th style="min-width:90px">파레트번호</th>
								<th style="min-width:60px">출고량</th>
								<th style="min-width:60px">적재 Tray 개수</th>
								<th style="min-width:60px">구분(완공&미료)</th>
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

<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title", "파레트 포장");
	
	let menuAuth	= 'pdsc0030';
	var serverDate	= "${serverDate}"
	
	var goodsCd			= null;
	var goodsNm			= null;
	var boxNo			= null;
	var packCnt			= null;
	var remainCnt 		= null;
	var locationCd		= null;
	var locationNm		= null;
	var customerLotNo	= null;
	var count 			= 0;

	let factoryCode = "<%=factoryCode%>";

	//공통코드 처리 시작
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	json.etc2 = "${info.etc2}";
	locationCode.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	$('#chooseDate').val(serverDate);
	$('#btnSelpoSeqCode').focus();

	$.fn.dataTable.ext.errMode = 'none';
	let GoodsProductInfoTable = $('#GoodsProductInfoTable').on('error.dt', function(e, settings, techNote, message) {
			if (techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut : 5000	});
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
		rowId : '',
		columns : [
			{
				render : function(data, type, row, meta) {
					var rowNo = meta.row + 1;
					if (rowNo == 1) {
						//$('#btnSave').attr('disabled', false);
					}
					return meta.row + 1;
				}
			},
			{
				data : 'goodsCd',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsCd;
					}
				}
			},
			{
				data : 'goodsNm',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsNm;
					}
				}
			},
			{
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
				data : 'packCnt',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return packCnt;
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
			{
				data : 'customerLotNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return customerLotNo;
					}
				}
			}			
		],
		columnDefs : [
			{ "className" : "text-center", "targets" : "_all" }
		],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		createdRow : function(row, data, dataIndex) {
			//$(row).attr('data-location-cd', locationCd);
		},
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');
		},
	});

	//$('#GoodsProductInfoTable').css('font-size', '12px' );

	var lineCheck = false;
	$('#GoodsProductInfoTable tbody').on( 'click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			lineCheck = false;
		} else {
			$('#GoodsProductInfoTable').DataTable().$('tr.selected')
					.removeClass('selected');
			$(this).addClass('selected');
			lineCheck = true;
		}
	});

	//박스번호 스캔 시
	$("#boxNo").keypress( function(e) {
		//alert(e.which);
		if (e.which == 13) {
			//키보드입력 말고 바코드로 스캔시 풀어주기
			if (!$.trim($('#boxNo').val())) {
				toastr.warning('바코드를 스캔해주세요!');
				$('#boxNo').focus();
				return false;
			}
			if ($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
				$('#boxNo').focus();
				$("#chooseDate").focus();
				toastr.warning("입고일을 선택해주세요!");
				return false
			}
			if ($('#boxNo').val().trim().length != "18") {
				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
				$('#boxNo').select();
				return false;
			}
			if ($("#poNo").val() == null || $("#poNo").val() == "") {
				toastr.warning('PO Number를 먼저 선택해주세요.');
				$('#btnSelpoSeqCode').select();
				return false;
			}
			if($('#addPallet').prop('checked')) {
				
			} else {
				if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
					toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
					$('#btnSelpoGroup').focus();
					return false;
				}
			}

			var cval = compareBarcodeNo($('#boxNo').val().trim());
			if (cval == false) {
				toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', { timeOut : 5000 });
				$('#boxNo').select();
				return false;
			}

			let restock = 'no';
			//체크되어있으면 재입고 가능
			if ($('#checkRestock').prop('checked')) {
				restock = 'yes';
			}

			$.ajax({
				url : '<c:url value="/pd/goodsProductInfoData"/>',
				type : 'GET',
				data : {
					'menuAuth'	: menuAuth,
					'boxNo'		: function() { return $('#boxNo').val().trim();			},
					'poModelNo'	: function() { return $('#poModelNo').val(); 			},
					'poSeq'		: function() { return $("#poSeq").val(); 				},
					'poGroup'	: function() { return $('#poGroup').val();				},
					'addPallet'	: function() { return $('#addPallet').prop('checked');	},
					'restock'	: restock,
				},
				beforeSend : function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success : function(res) {
					let data = res.data;
					
					if (res.result == 'ok') { //제품상태 포장, 제품입고

						boxNo		= data.boxNo;
						goodsCd		= data.goodsCd;
						goodsNm		= data.goodsNm;
						packCnt		= data.packCnt;
						remainCnt	= data.remainCnt;
						
						//$('#GoodsProductInfoTable').DataTable().row.add({}).draw(false);	// 고객사 LotNo 추가로 인해 주석 처리 됨
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						
						// 고객사 LotNo 추가로 인해 주석 처리 됨
						/* $('#boxNo').val(null);
						$('#boxNo').focus();
						count += 1;
						$('#count').text(count);
						toastr.success('추가되었습니다.');
						 */
						 
						$('#boxNo').attr('disabled',true);
						$('#secondCustomerLotNo').attr('disabled',false);
						$('#secondCustomerLotNo').focus();
						toastr.success('고객사 LotNo를 입력 해주세요.');
						
					} else if (res.result == 'fail') { //제품 출하
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					} else if (res.result == 'error') { // BoxNo 조회 에러
						toastr.error(res.message, '', { timeOut : 5000 });
						$('#boxNo').select();
					}
				},
				complete : function() {
					//$('#btnAddConfirm').removeClass('d-none');
					//$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
		}
	});
	
	//고객사 바코드 스캔시
	$("#secondCustomerLotNo").keypress(function(e) {
		if (e.which == 13) {
			//countPlus();
			
			count += 1;
			$('#count').text(count);
			
			exceptBoxNo += "/" + boxNo;
			customerLotNo = $('#secondCustomerLotNo').val();
			$('#GoodsProductInfoTable').DataTable().row.add({}).draw(false);

			$('#boxNo').attr('disabled', false);
			$('#secondCustomerLotNo').attr('disabled', true);
			$('#boxNo').val('');
			$('#secondCustomerLotNo').val('');
			$('#boxNo').focus();
			
			toastr.success('추가되었습니다.');
		}
	});

	// 저장 처리
	$('#btnSave').on('click', function() {
		if (!$.trim($('#chooseDate').val())) {
			toastr.warning('입고일을 선택해주세요.');
			return false;
		}
		//파레트 확인
		if($('#addPallet').prop('checked')) {
		} else {
			if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
				toastr.warning('추가로 적재할 파레트를 선택해 주세요!');
				$('#btnSelpoGroup').focus();
				return false;
			}
		}			
		if ($('#poModelNo').val() == null || $('#poModelNo').val() == '') {
			toastr.warning("해당 제품에 모델이 없습니다.<br> 제품코드관리에서 등록해주세요!");
			$('#poModelNo').focus();
			return false;
		}

		$('#my-spinner').show();

		createBarcodeNo();

		$.ajax({
			url : '<c:url value="/pd/updateProductLocation_F3"/>',
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
					
					$('#btnAllClear').attr('disabled', true);
					$('#btnLineClear').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#boxNo').attr('disabled', true);
					$('#btnSelpoSeqCode').attr('disabled', true);
					$('#btnSelpoGroup').attr('disabled', true);
					$('#addPallet').attr('disabled', true);
					
					$('#btnCancel').addClass('d-none');
					$('#btnNew').removeClass('d-none');
					
					toastr.success('파레트포장되었습니다.');
					
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {
						timeOut : 5000
					});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {
						timeOut : 5000
					});
				}
			},
			complete : function() {
				$('#my-spinner').hide();
			}
		});
	});

	var boxNoList;
	function createBarcodeNo() {
		boxNoList = new Array();
		var idx = 0;
		
		$('#GoodsProductInfoTable tbody tr').each(function() {
			var boxNo		= $(this).find('td').eq(3).html();
			var goodsInDate	= $("#chooseDate").val().replace(/-/g, '');
			
			var rowData = new Object();
			rowData.menuAuth	= menuAuth;
			rowData.boxNo		= boxNo;
			rowData.goodsInDate	= goodsInDate;
			
			//파레트 포장 시 필요한 부분
			rowData.poSeq			= $("#poSeq").val();
			rowData.poModelNo		= $("#poModelNo").val().replaceAll('-', '');
			rowData.goodsCd			= $("#goodsCd").val();
			rowData.poGroup			= $('#poGroup').val();
			rowData.addPallet		= $('#addPallet').prop('checked');
			rowData.userOutputCnt	= removeCommas($(this).find('td').eq(4).html()).replace(/,/g, '');
			rowData.packCnt			= removeCommas($(this).find('td').eq(5).html()).replace(/,/g, '');
			rowData.customerLotNo	= $(this).find('td').eq(6).text();
			
			boxNoList.push(rowData);
		});
		console.log(boxNoList);
		return idx;
	}

	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#boxNo').val('');
		$('#boxNo').focus();
		count = 0;
		$('#count').text(count);
	});

	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if (lineCheck == true) {
			$('#GoodsProductInfoTable').DataTable().rows('.selected').remove().draw();
			$("#boxNo").val("");
			$("#boxNo").focus();
			
			var rowCnt = $('#GoodsProductInfoTable').DataTable().data().count();
			
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
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);+
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		$('#boxNo').val('');
		$('#boxNo').focus();
		$('#chooseDate').val(serverDate);
		count = 0;
		$('#count').text(count);
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#boxNo').attr('disabled', false);
		
		$('#btnSelpoSeqCode').attr('disabled', false);
		$('#btnSelpoGroup').attr('disabled', false);
		$('#addPallet').attr('disabled', false);
		$('#addPallet').prop('checked', false);
		
		$('#GoodsProductInfoTable').DataTable().clear().draw();
		
		$('#boxNo').val('');
		$('#poSeq').val('');
		$('#poModelNo').val('');
		$('#poNo').val('');
		$('#poGroup').val('');

		$('#btnCalendar').focus();
		$('#chooseDate').val(serverDate);
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
	});

	//중복 예외처리 사용예정
	function compareBarcodeNo(boxNo) {
		var result = true;
		$('#GoodsProductInfoTable tbody tr').each(function() {
			var tboxNo = $(this).find('td').eq(3).html();
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
				},
				rowId : 'poSeq',
				columns : [
					{
						data : 'deliveryDate',
						render : function(data, type, row) {
							return moment(data).format('YYYY-MM-DD');
						}
					},
					{ data : 'poNo'			},
					{ data : 'goodsNm'		},
					{ data : 'poQty'		},
					{ data : 'remainQty'	},
					{ data : 'poCode'		},
				],
				columnDefs : [
					{ targets : [ 0, 1, 2, 5 ], className : "text-center" },
					{ targets : [ 3, 4 ], className : 'text-right-td' },
					{ targets : [ 3, 4 ], render : $.fn.dataTable.render.number(',') },
				],
				order : [ [ 0, 'desc' ] ]
			});
			
			$('#poPopUpTable tbody').on('click', 'tr', function() {
				var data = poPopUpTable.row(this).data();
				if (data.remainQty == 0) {
					toastr.warning("미출고수량이 0인 PO는 선택 하실 수 없습니다!")
				} else {
					
					$('#poSeq').val(data.poSeq);
					$('#poModelNo').val(data.modelNo);
					$('#poNo').val(data.poNo);
					$('#poGubunCd').val(data.poGubunCd);
					$('#goodsCd').val(data.goodsCd);
					$('#remainQty').text(addCommas(data.remainQty));
					$('#poPopUpModal').modal('hide');
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
		
		if ($('#poSeq').val() == null || $('#poSeq').val() == '') {
			toastr.warning("PO Number를 먼저 선택해 주세요!");
			$('#btnSelpoSeqCode').focus();
			return false;
		}
		
		if ($('#poModelNo').val() == null || $('#poModelNo').val() == '') {
			toastr.warning("해당 제품에 모델이 없습니다.<br> 제품코드관리에서 등록해주세요!");
			$('#poModelNo').focus();
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
				ajax : {
					url : '<c:url value="/bs/outputHistList"/>',
					type : 'GET',
					data : {
						'menuAuth'	:	menuAuth,
						'poSeq'		:	function() { return $('#poSeq').val(); },
						'exceptOutput'	:	function() { return "Y";				},
						'completeYn'	:	function() { return "'N'";				},
						'goodsStatus'	:	function() { return "'002'";			},
					},
				},
				rowId : 'poGroup',
				columns : [
					{ data : 'poGroup'		},
					{ data : 'outputQty'	},
					{ data : 'trayCnt'		},
					{ data : 'completeYn',
						render : function(data, type, row, meta) {
							if (data == "Y") {
								return "완공";
							} else if(data == "N") {
								return "미료";
							} else {
								return "error";
							}
						}
					},
				],
				columnDefs : [
					{ targets : [ 0, 3 ], className : "text-center" },
					{ targets : [ 1, 2 ], className : 'text-right-td' },
					{ targets : [ 1, 2 ], render : $.fn.dataTable.render.number(',') }
				],
				order : [ [ 0, 'asc' ] ],
				rowCallback: function (row, data) {
					if (data.completeYn == 'N') {
						$(row).addClass('skyYellow');
					}
				},
			});
			$('#poGroupPopUpTable tbody').on('click', 'tr', function() {
				
				if ( !$(this).hasClass('selected') ) {
		        	$('#poGroupPopUpTable').DataTable().$('tr.selected').removeClass('selected');
		        	$(this).addClass('selected');
		        }
				
				var data = poGroupPopUpTable.row(this).data();
				
				if( data.completeYn == "Y" ) {
					toastr.warning("해당 파레트는 완공된 상태입니다.<br>다른 파레트를 선택해주세요!", '', {timeOut : 5000});
					return false;
				}
				
				$('#poGroup').val(data.poGroup);
				$('#boxNo').focus();
				$('#poGroupPopUpModal').modal('hide');
			});
			
		} else {
			$('#poGroupPopUpTable').DataTable().ajax.reload();
			$('#poGroupPopUpTable').DataTable().$('tr.selected').removeClass('selected');
		}

		$('#poGroupPopUpModal').modal('show');
	}
	//트레이 번호(poGroup) 목록 팝업 종료
	

	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#boxNo').attr('inputmode');
		if (inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#boxNo').attr('inputmode', 'text');
		} else if (inputmode == 'text') {
			$('#btnKeyboard').text("자판 Off");
			$('#boxNo').attr('inputmode', 'none');
		}
	});
	
	//파레트 추가 checkBox 클릭 시
	$('#addPallet').on('click', function(){
		if ($(this).prop('checked')) {
			$('#poGroup').val('');
			$('#btnSelpoGroup').attr('disabled', true);
		} else {
			$('#btnSelpoGroup').attr('disabled', false);
		}
	});

	function selectBoxAppend(obj, id, sVal, flag) {
		$('#' + id).empty();

		if (flag == '1') {
			$('#' + id).append($("<option value=''>" + "전체" + "</option>"));
		} else if (flag == '2') {
			$('#' + id).append($("<option value=''>" + "선택" + "</option>"));
		}

		for (key in obj) {
			var option;
			if (obj[key].baseCd == sVal) {
				option = $("<option value=" + obj[key].baseCd + " name=" + obj[key].etc2 + " selected>"
						+ obj[key].baseCdNm + "</option>");
			} else {
				option = $("<option value=" + obj[key].baseCd + " name=" + obj[key].etc2 + ">"
						+ obj[key].baseCdNm + "</option>");
			}
			$('#' + id).append(option);
		}

	}
</script>

</body>
</html>