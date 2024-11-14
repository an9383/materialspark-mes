<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">LOT현황관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"style="overflow: hidden;">
				<div class="card">
					<div class="row">
						<div class="form-group row pb-3">
							<label for="staticEmail" class="col-sm-3 col-form-label p-1">작지번호</label>
							<div class="col-sm-9">
								<div class="input-sub m-0">
									<input type="text" class="form-control" id="workOrdNoScan" placeholder="스캐너만 입력">
									<button type="button" class="btn btn-primary input-sub-search"
										onClick="selectWorkOrd();">
										<span class="oi oi-magnifying-glass"></span>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<h6>생산진행내역</h6>
						<div class="table-responsive" style="overflow: hidden;">
							<table id="workOrderTable" class="table table-bordered">
								<colgroup>
									<col width="10%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>생산일자</th>
										<th>소공정</th>
										<th>설비명</th>
										<th>작업자</th>
										<th>품명(Type)</th>
										<th>투입수량</th>
										<th>생산수량</th>
										<th>불량수량</th>
										<th>입고</th>
										<th>출고</th>
										<th>비고</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div class="row">
						<h6>자재투입내역</h6>
						<div class="table-responsive">
							<table id="workOrderMatrlTable" class="table table-bordered">
								<colgroup>
									<col width="14%">
									<col width="20%">
									<col width="20%">
									<col width="26%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>입고일자</th>
										<th>CODE</th>
										<th>ITEM</th>
										<th>SPEC</th>
										<th>입고량</th>
										<th>작지번호</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- / #main  -->
</div>
<!-- Modal1 End-->
<%@include file="../layout/bottom.jsp" %>

<script>
	let currentHref = "wmsc0080";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","LOT현황관리"); 
	
	let workOrdNoVal = '';
	var middlePrcssCd = null;
	var minorPrcssCd = null;

	// 생산진행내역 테이블
	let workOrderTable = $('#workOrderTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>"
				+ "<'row'<'col-sm-12 p-0'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : false,
		info : false,
		searching : false,
		ordering : false,
		processing : false,
		autoWidth : false,
		lengthChange : false,
		scrollY : '250px',
		pageLength : 100,
		select : {
			style : 'single',
			toggleable : false,
			items : 'row'
		},
		ajax : {
			url : '<c:url value="wm/lotTrackingList"/>',
			type : 'POST',
			data : {
				'workOrdNo' : function() {
					return workOrdNoVal;
				}
			},
		},
		columns : [ {
			data : 'ordDate',
			render : function(data, type, row, meta) {
				if (data == '' || data == null) {
					return '';
				} else {
					return moment(data).format('YYYY-MM-DD');
				}
			}
		}, {
			data : 'minorPrcssNm'
		}, {
			data : 'equipNm'
		}, {
			data : 'workChargrNm'
		}, {
			data : 'itemNm'
		}, {
			data : 'targetQty'
		}, {
			data : 'outputQty'
		}, {
			data : 'faultyQty'
		}, {
			data : 'inQty'
		}, {
			data : 'outQty'
		}, {
			data : 'lotDesc'
		} ],
		columnDefs : [ {
			targets : [ 0, 1, 2, 3, 4, 10 ],
			className : 'text-center-td'
		}, {
			targets : [ 5, 6, 7, 8, 9 ],
			className : 'text-right-td',
			render : $.fn.dataTable.render.number(',')
		} ],
		order : [ [ 0, 'asc' ] ],
		buttons : []
	});

	//보기
	$('#workOrderTable tbody').on('click','tr',function() {

	
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		middlePrcssCd = workOrderTable.row(this).data().middlePrcssCd;
		minorPrcssCd = workOrderTable.row(this).data().minorPrcssCd;

		$("#workOrderMatrlTable").DataTable().ajax.reload(function(){});
	});
	
	// 자재투입내역 테이블
	let workOrderMatrlTable = $('#workOrderMatrlTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>"
				+ "<'row'<'col-sm-12 p-0'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : false,
		info : false,
		searching : false,
		ordering : false,
		processing : false,
		autoWidth : false,
		lengthChange : false,
		scrollY : '300px',
		pageLength : 100,
		select : {
			style : 'single',
			toggleable : false,
			items : 'row'
		},
		ajax : {
			url : '<c:url value="wm/lotTrackingMatrlList"/>',
			type : 'POST',
			data : {
				'workOrdNo' : function() {return workOrdNoVal;},
				'middlePrcssCd' : function() {return middlePrcssCd;},
				'minorPrcssCd' : function() {return minorPrcssCd;},
			},
		},
		columns : [ {
			data : 'ordDate',
			render : function(data, type, row, meta) {
				if (data == '' || data == null) {
					return '';
				} else {
					return moment(data).format('YYYY-MM-DD');
				}
			}
		}, {
			data : 'itemNm'
		}, {
			data : 'partNm'
		}, {
			data : 'partSpec'
		}, {
			data : 'inQty'
		}, {
			data : 'workOrdNo'
		} ],
		columnDefs : [ {
			targets : [ 0, 1, 2, 3, 5 ],
			className : 'text-center-td'
		}, {
			targets : [ 4 ],
			className : 'text-right-td',
			render : $.fn.dataTable.render.number(',')
		} ],
		order : [ [ 0, 'asc' ] ],
		buttons : []
	});

	
	//작지번호 SCAN
	$('#workOrdNoScan').keypress(function(e) {
		if (e.which == 13) {
			if ($('#workOrdNoScan').val() == ""
					|| $('#workOrdNoScan').val() == null) {
				toastr.warning("바코드번호를 입력 후 다시 시도해주세요.");
				$(this).val(korTypeToEng($(this).val()).toUpperCase());
				$('#workOrdNoScan').select();
				return false;
			}
// 			if ($('#workOrdNoScan').val().length != 12) {
// 				toastr.warning("잘못된 바코드번호입니다.");
// 				$('#workOrdNoScan').select();
// 				return false;
// 			}

			toastr.success("작지번호를 스캔헀습니다.");
			workOrdNoVal = $('#workOrdNoScan').val();

			$('#workOrderMatrlTable').DataTable().ajax
					.reload(function() {
					}); // 자재투입내역
			$('#workOrderTable').DataTable().ajax.reload(function() {
			}); // 생산진행내역
		}
	});
	

	//작업지시번호 목록 조회 팝업
	var workOrdPopUpTable;
	function selectWorkOrd() {
		if (workOrdPopUpTable == null || workOrdPopUpTable == undefined) {
			//작지상세 테이블 
			workOrdPopUpTable = $('#workOrdPopUpTable').DataTable({
				language : lang_kor,
				paging : true,
				searching : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange : false,
				pageLength : 10,
				//ordering: false,
				ajax : {
					url : '<c:url value="po/workOrderModalDataList"/>',
					type : 'GET',
					data : {
						'menuAuth' : 'wmsc0080'
					},
				},
				rowId : 'workOrdNo',
				columns : [ {
					data : 'workOrdNo'
				}, {
					data : 'itemGubunNm'
				}, {
					data : 'itemNm'
				}, {
					data : 'ordLotNo'
				}, {
					data : 'workOrdQty'
				}, ],
				columnDefs : [ {
					targets : [ 4 ],
					render : $.fn.dataTable.render.number(',')
				}, {
					targets : [ 0, 1, 2, 3 ],
					className : 'text-center-td'
				}, {
					targets : [ 4 ],
					className : 'text-right-td'
				} ],
				order : [ [ 0, 'desc' ] ]
			});

			$('#workOrdPopUpTable tbody').on('click', 'tr', function() {
				var data = workOrdPopUpTable.row(this).data();

				$('#workOrdNoScan').val(data.workOrdNo);

				workOrdNoVal = $('#workOrdNoScan').val();
				$('#workOrderMatrlTable').DataTable().ajax.reload(function() {
				}); // 자재투입내역
				$('#workOrderTable').DataTable().ajax.reload(function() {
				}); // 생산진행내역

				$('#workOrdPopUpModal').modal('hide');

			});
		} else {
			$('#workOrdPopUpTable').DataTable().ajax.reload(function() {
			});
		}
		$('#workOrdPopUpModal').modal('show');
	}
</script>

</body>
</html>
