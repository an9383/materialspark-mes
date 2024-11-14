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
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc3050"><p class="mo_main_title">미료&완공 지정</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
	
	<!-- 완공&미료 버튼 -->
		<div class="col-12 row p-1">
			<div class="col-3">
				<div class="mo_sort_title ml-1">
					<label style="font-size: 20px;line-height: 10px;background-color: lightpink;">완공취소</label>
				</div>
			</div>
			<div class="form-group input-sub col-3 m-0 p-0">
				<input type="radio" class="" style="width:100%; height:28px;" id="completeN" name="completeYn" value="N">
			</div>
			
			<div class="col-3">
				<div class="mo_sort_title ml-1">
					<label style="font-size: 20px;line-height: 10px;background-color: #b7e3ff;">완공</label>
				</div>
			</div>
			<div class="form-group input-sub col-3 m-0 p-0">
				<input type="radio" class="" style="width:100%; height:28px;" id="completeY" name="completeYn" value="Y">
			</div>
		</div>
		<!-- 완공&미료 버튼 -->
		
		<!-- 창고 번호 스캔 하는 부분 -->
		<div class="col-12 row p-1" style="display:none;">
			<div class="col-4 mo_sort_title">창고지정(스캔)</div>
			<div class="form-group input-sub col-8 m-0 p-0 row"">
				<input type="text" class="form-control-md" id="codeNum" inputmode="none">
			</div>
		</div>
		<!-- 창고 번호 스캔 하는 부분 -->
		
		<!-- poNumber 버튼 -->
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
		<!-- poNumber 버튼 -->
		
		<!-- 파레트 버튼 -->
		<div class="col-12 row p-1 d-none" id="hiddenTogglePoGroup">
			<div class="col-4 mo_sort_title">
				<label>파레트 선택</label>
			</div>
			<div class="form-group input-sub col-8 m-0 p-0">
				<input type="text" class="form-control-md" id="poGroup" name="poGroup" disabled>
				<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelpoGroup" onClick="selectPoGroup()">
					<span class="oi oi-magnifying-glass"></span>
				</button>
			</div>
		</div>
		<!-- 파레트 버튼 -->
		
		<!-- 파레트 스캔 -->
		<div class="col-12 row p-1">
			<div class="col-4 mo_sort_title">파레트 스캔</div>
			<div class="form-group input-sub col-8 m-0 p-0 row">
				<input type="text" class="form-control-md" id="poNum" inputmode="none">
			</div>
		</div>
		<!--  -->
		
	</div>
	<!--==버튼영역-->
	<div class="mo_btnbox pl-2 pr-2">
		<div class="float-left">
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
								<th style="min-width: 40px">포장 수량</th>
								<th style="min-width: 40px">고객사lotNo</th>
								<th style="min-width: 40px">구분(완공&미료)</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==end==table-->
		</div>
	</main>
	
	<footer class="p-2" style="margin-top: auto;">
		<div class="mo_sumbox">
			<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
			<div class="row float-right">
			
				<div class="mo_kg">
					<div class="custom-control custom-control-inline custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="checkGubun" disabled>
						<label class="custom-control-label" for="checkGubun">검색</label>
					</div>
				</div>
				
				<div class="mo_kg">
					<span class="mo_sum_font_lg d-none" id="remainQty">0</span><!-- <label>미출고수량</label> -->
					<span class="mo_sum_font_lg d-none" id="count">0</span><!-- <label>박스</label> -->
				</div>
			</div>
		</div>
	</footer>
</div>
<!-- /.app -->


<!-- 모달  영역 -->

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
				<h5 class="modal-title" id="poPopUpLabel">파레트 목록 조회</h5>
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
								<th style="min-width:60px">상태</th>
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

<!-- 출고 확인 모달 시작 -->
<div class="modal fade" id="goodsProductOutModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">저장 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="">저장하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnSaveCheck" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>

			</div>
		</div>
	</div>
</div>
<!-- 출고 확인 모달 끝 -->

<!-- 모달  영역 끝 -->

<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp"%>
<%@include file="../layout/bottom.jsp"%>
<!-- my-spinner 연결 -->

<script>

	$(document).attr("title","미료&완공 지정");
	let menuAuth	= 'pdsc3040';
	let serverDate	= "${serverDate}"
		
	let boxNo 				= null;	
	let goodsCd 			= null;
	let goodsNm 			= null;
	let packCnt	 			= null;
	let remainCnt 			= null;
	let userOutputCnt 		= null;
	let goodsFifoCheckNm	= null;
	let customerLotNo		= null;
	
	let completeYn	= null;
	let count 		= 0;
	let exceptBoxNo	= 'empty';	//스캔한 포장번호(선입선출에서 추가로 제외시킬애들);
	let boxNoList;				//저장할 값 담아주는 Array
	let factoryCode	= "<%=factoryCode%>";
	
	//공통코드 처리 시작
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd		= "${info.baseCd}";
	json.baseCdNm	= "${info.baseCdNm}";
	json.etc2		= "${info.etc2}";
	locationCode.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	//로딩 완료 시 disable false
	$(document).ready(function(){ 
		$('#checkGubun').attr('disabled',false);
	});
	
	//미료&완공버튼 클릭 시_UI 설정
	$('input[name="completeYn"]').on('change', function() {
		$($('input[name="completeYn"]')[0].parentNode).attr('style', '');
		$($('input[name="completeYn"]')[1].parentNode).attr('style', '');
		$(this.parentNode).attr('style', 'border: 2px #0051ae solid;border-radius: 100px;display: flex;align-items: center;');
	});
	
	$('#btnSelpoSeqCode').focus();

	$.fn.dataTable.ext.errMode = 'none';
	let boxCodeOutputWhsTable = $('#boxCodeOutputWhsTable').on('error.dt', function(e, settings, techNote, message) {
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
		columns : [
			{
				render : function(data, type, row, meta) {
					var rowNo = meta.row + 1;
					if (rowNo == 1) {
						$('#btnSave').attr('disabled', false);
					}
					return meta.row + 1;
				}
			},
			{ data : 'goodsCd',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsCd;
					}
				}
			},
			{ data : 'goodsNm',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return goodsNm;
					}
				}
			},
			{ data : 'boxNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return boxNo;
					}
				}
			},
			{ data : 'userOutputCnt',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						var html = addCommas(userOutputCnt);
						return html;
					}
				}
			},
			{ data : 'packCnt',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return packCnt;
					}
				}
			},
			{ data : 'customerLotNo',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						return customerLotNo;
					}
				}
			},
			{ data : 'completeYn',
				render : function(data, type, row, meta) {
					if (data != null) {
						return data;
					} else {
						if(completeYn == "Y") {
							return "완공";
						} else if(completeYn == "N") {
							return "미료";
						} else {
							return "error";
						}
					}
				}
			},
		],
		columnDefs : [
			{ "className" : "text-center", "targets" : "_all" }
		],
		order : [ [ 0, 'desc' ] ],
		buttons : [],
		drawCallback : function() {
			$('.mo_card tbody').css('font-size', '10px');
		},
	});

	var lineCheck = false;
	//메인 테이블 목록 클릭 시
	$('#boxCodeOutputWhsTable tbody').on('click', 'tr', function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			lineCheck = false;
		} else {
			$('#boxCodeOutputWhsTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			lineCheck = true;
		}
	});

	//저장 버튼 클릭 시
	$('#btnSave').on('click', function() {
		
		if($('input[name="completeYn"]:checked').prop('checked') == null) {
			toastr.warning('미료&완료를 선택 해주세요!');
			$('#completeN').focus();
			return false;
		}
		if ($("#poSeq").val() == null || $("#poSeq").val() == "") {
			toastr.warning("PO를 선택해주세요.");
			return false
		}
		if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
			toastr.warning('파레트를 선택해 주세요!');
			$('#btnSelpoGroup').focus();
			return false;
		}
		
		$('#goodsProductOutModal').modal('show');
	});

	//저장 모달 버튼 클릭 시
	$('#btnSaveCheck').on('click', function() {
		
		if($('input[name="completeYn"]:checked').prop('checked') == null) {
			toastr.warning('미료&완료를 선택 해주세요!');
			$('#completeN').focus();
			return false;
		}
		if ($("#poSeq").val() == null || $("#poSeq").val() == "") {
			toastr.warning("PO를 선택해주세요.");
			return false
		}
		if($('#poGroup').val() == '' || $('#poGroup').val() == null) {
			toastr.warning('파레트를 선택해 주세요!');
			$('#btnSelpoGroup').focus();
			return false;
		}
		
		$('#my-spinner').show();

		if (createBoxNo()) {
			$.ajax({
				url : '<c:url value="/pd/palletRelatedCompleteYn_F3"/>',
				type : 'POST',
				data : JSON.stringify(boxNoList),
				dataType : "json",
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						
						uiProc(true);
						$('#btnAllClear').attr('disabled', true);
						$('#btnCancel').addClass('d-none');
						$('#btnNew').removeClass('d-none');
						
						toastr.success('저장되었습니다.');
						
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', { timeOut : 5000 });
						$('#btnCancel').focus();
					} else {
						toastr.warning(res.message, '', { timeOut : 5000 });
					}
				},
				complete : function() {
					$('#my-spinner').hide();
				}
			});
		}
	});
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#btnAllClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#poGroup').val('');
		$('#poNum').val('');
		count = 0;
		exceptBoxNo = 'empty';
		$('#count').text(count);
		$('#boxCodeOutputWhsTable').DataTable().clear().draw();
	});

	//취소 버튼
	$('#btnCancel').on('click', function() {
		uiProc(false);
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		uiProc(false);
	});

	//구매주문관리조회 팝업 시작
	let poPopUpTable;
	function selectPoCode() {
		if (poPopUpTable == null || poPopUpTable == undefined) {
			poPopUpTable = $('#poPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
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
			
			//주문관리 목록 클릭 시
			$('#poPopUpTable tbody').on('click', 'tr', function() {
				var data = poPopUpTable.row(this).data();
// 				if (data.remainQty == 0) {
// 					toastr.warning("미출고수량이 0인 PO는 선택 하실 수 없습니다!")
// 				} else {
					$('#poSeq').val(data.poSeq);
					$('#poNo').val(data.poNo);
					$('#poGubunCd').val(data.poGubunCd);
					$('#goodsCd').val(data.goodsCd);
					$('#remainQty').text(addCommas(data.remainQty));
					$('#poPopUpModal').modal('hide');
					exceptBoxNo = 'empty';
// 				}
			});
		} else {
			$('#poPopUpTable').DataTable().ajax.reload();
		}
		$('#poPopUpModal').modal('show');
	}
	//구매주문관리조회 팝업 종료
	

	//트레이 번호(poGroup) 목록 팝업 시작 (파레트 목록 조회)
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
				ajax : {
					url : '<c:url value="/bs/outputHistList"/>',
					type : 'GET',
					data : {
						'menuAuth'		:	menuAuth,
						'poSeq'			:	function() { return $('#poSeq').val();	},
						'exceptOutput'	:	function() { return "Y";				},
						'completeYn'	:	function() { return "'Y', 'N'";			},
						'goodsStatus'	:	function() { return "'002', '004'";		},
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
					{ data : 'goodsStatusNm'		},
				],
				columnDefs : [
					{ targets : [ 0, 3, 4 ], className : "text-center" },
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
			
			//파레트 목록 조회 클릭 했을 때
			$('#poGroupPopUpTable tbody').on('click', 'tr', function() {
				if ( !$(this).hasClass('selected') ) {
		        	$('#poGroupPopUpTable').DataTable().$('tr.selected').removeClass('selected');
		        	$(this).addClass('selected');
		        }
				
				var data = poGroupPopUpTable.row(this).data();
				
				$('#poGroup').val(data.poGroup);
				$('#btnAllClear').attr('disabled', false);
				sudel(); 
				$('#poGroupPopUpModal').modal('hide');
			});
			
		} else {
			$('#poGroupPopUpTable').DataTable().ajax.reload();
			$('#poGroupPopUpTable').DataTable().$('tr.selected').removeClass('selected');
		}
		$('#poGroupPopUpModal').modal('show');
	}
	//트레이 번호(poGroup) 목록 팝업 종료
	
	
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
		$('#btnSave').attr('disabled', false);
		$('#btnSelpoSeqCode').attr('disabled', true);
		$('#btnAllClear').attr('disabled', false);
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
	
	//변경&저장할 값 담아주는 부분
	function createBoxNo() {
		boxNoList	= new Array();
		
		$('#boxCodeOutputWhsTable tbody tr').each(function() {
			var boxNo1			= $(this).find('td').eq(3).html();
			var poSeq			= $("#poSeq").val();
			var poGroup			= $("#poGroup").val();
			var completeYn1		= $('input[name="completeYn"]:checked').val();

			var rowData = new Object();
			rowData.menuAuth	= menuAuth;
			rowData.boxNo1		= boxNo1;
			rowData.poSeq		= poSeq;
			rowData.poGroup		= poGroup;
			rowData.completeYn1	= completeYn1;
			rowData.locationCd	= null;
			
			boxNoList.push(rowData);
		});
		
		return true;
	}

	//PDA 파레트 관련 제품  조회 함수
	function sudel() {
		$.ajax({
			url : '<c:url value="/pd/palletRelatedProductList_F3"/>',
			type : 'GET',
			data : {
				'menuAuth'		: menuAuth,
				'poSeq'			: function() { return $('#poSeq').val();	},
				'poGroup'		: function() { return $('#poGroup').val();	},
			},
			success : function(res) {
				let data = res.data;
				
				if (res.result == 'ok') {
					
					$('#boxCodeOutputWhsTable').DataTable().clear().draw();
					
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
						completeYn 			= data[i].completeYn;
						
						$('#boxCodeOutputWhsTable').DataTable().row.add({}).draw(false);
					}
					toastr.success('추가되었습니다.');
				}
			},
			complete : function() {}
		});
	}
	
	//ui_disabled
	function uiProc(flag) {
		$('input[name="completeYn"]').attr('disabled', flag);	//미료&완공
		$('#btnSelpoSeqCode').attr('disabled', flag);			//poNumber 버튼
		$('#btnSelpoGroup').attr('disabled', flag);				//파레트 버튼
		$('#btnAllClear').attr('disabled', !flag);				//전체삭제버튼
		$('#btnSave').attr('disabled', flag);					//저장버튼
		$('#checkGubun').attr('disabled', flag);				//창고 스캔 버튼
		
		count = 0;
		$('#count').text(count);
		exceptBoxNo = 'empty';
		
		if(!flag) {
			$('#poGroup').val('');
			$('#poGubunCd').val('');
			$('#goodsCd').val('');
			$('#poSeq').val('');
			$('#poNo').val('');
			$('#poNum').val('');
			
			$($('input[name="completeYn"]')[0].parentNode).attr('style', '');
			$($('input[name="completeYn"]')[1].parentNode).attr('style', '');
			$('input[name="completeYn"]:checked').prop('checked', false);
			
			$('#btnNew').addClass('d-none');
			$('#btnCancel').removeClass('d-none');
			$('#boxCodeOutputWhsTable').DataTable().clear().draw();
		}
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
					'completeYn'	:	function() { return "'Y', 'N'";			},
					'goodsStatus'	:	function() { return "'002', '004'";		},
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
	
	
	//검색 버튼 클릭 시
	$('#checkGubun').on('click', function(){
		if( $('#checkGubun').prop('checked') ) {
			$('#hiddenTogglePoGroup').removeClass('d-none');
		} else {
			$('#hiddenTogglePoGroup').addClass('d-none');
		}
	});
	
</script>

</body>
</html>
