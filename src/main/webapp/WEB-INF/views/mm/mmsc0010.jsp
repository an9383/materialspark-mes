<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">

	<!-- 부품조회 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="partPopUpModal" tabindex="-1" role="dialog" aria-labelledby="printPopUpModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="margin-right: 40%;">
			<div class="modal-content" style="width: 150%;">
				<div class="modal-header">
					<h5 class="modal-title">품목정보관리(부품) 조회</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				<hr class="text-secondary">
				<div class="table-responsive">
					<table id="itemPartAdmPopUpTable" class="table table-bordered">
						<colgroup>
							<col width="5%">
							<col width="15%">
							<col width="20%">
							<col width="10%">
							<col width="10%">
							<col width="30%">
						</colgroup>
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th>No.</th>
								<th>CODE</th>
								<th>ITEM</th>
								<th>구분</th>
								<th>Revision</th>
								<th>SPEC</th>
							</tr>
						</thead>
					</table>
				</div>
				<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 부품조회 모달 종료-->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">일반자재관리</a></li>
				<li class="breadcrumb-item active">품목정보(일반자재)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 59%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="table-responsive">
						<table id="itemPartAdmTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="30%">
								<col width="10%">
								<col width="30%">
							</colgroup>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>No.</th>
									<th>CODE</th>
									<th>ITEM</th>
									<th>구분</th>
									<th>SPEC</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!--                       <button type="button" class="btn btn-success float-right">Excel</button> -->
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav"
				style="width: 40%;">
				<div class="card mb-2" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12 p-1">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand"
								class="closebtn float-right" onclick="closerNav()"><i
								class="mdi mdi-close"></i></a>
						</div>
						<div class="card-header card-tab p-0 mb-2">
							<!-- .nav-tabs tablist -->
							<ul class="nav nav-tabs card-header-tabs m-0">
								<li class="nav-item"><a class="nav-link active show"
									id="tab1Nav" data-toggle="tab" href="#tab1">기본정보</a></li>
								<li class="nav-item"><a class="nav-link disabled"
									id="tab2Nav" data-toggle="tab" href="#tab2">수입검사기준서</a></li>
								<li class="nav-item"><a class="nav-link disabled"
									id="tab3Nav" data-toggle="tab" href="#tab3">관련자료</a></li>
							</ul>
							<!-- /.nav-tabs -->
						</div>
					</div>
					<div id="myTabContent" class="tab-content">
						<div class="tab-pane fade active show" id="tab1">
							<div class="card-body col-sm-12 p-1 mb-2">
								<button type="button" class="btn btn-primary float-left"
									id="btnCall">불러오기</button>
								<button type="button" class="btn btn-primary float-right"
									id="btnEdit">수정</button>
								<button class="btn btn-warning d-none"
									id="btnEditConfirmLoading" type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span>처리중
								</button>
<!-- 								<button type="button" class="btn btn-primary float-right mr-1" -->
<!-- 									id="btnRevAdd">Revision등록</button> -->
<!-- 								<button class="btn btn-primary d-none" id="btnAddConfirmLoading" -->
<!-- 									type="button" disabled> -->
<!-- 									<span class="spinner-border spinner-border-sm" role="status" -->
<!-- 										aria-hidden="true"></span> 처리중 -->
<!-- 								</button> -->
								<button type="button" class="btn btn-primary float-right mr-1"
									id="btnAdd">신규등록</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
							<form id="form">
								<div class="table-responsive">
									<table class="table table-bordered" id="itemPartInfoTable">
										<colgroup>
											<col width="20%">
											<col width="30%">
											<col width="20%">
											<col width="30%">
										</colgroup>
										<tr>
											<th>*CODE</th>
											<td>
												<input type="text" class="form-control" id="partCd" name="partCd" maxlength="25" disabled>
											</td>
											<th>*ITEM</th>
											<td>
												<input type="text" class="form-control" id="partNm" name="partNm" maxlength="25">
											</td>
										</tr>
										<tr>
<!-- 											<th>*Revision</th> -->
<!-- 											<td> -->
<!-- 												<input type="text" class="form-control" id="partRev" name="partRev" disabled> -->
<!-- 											</td> -->
											<th>*단위</th>
											<td>
												<select class="custom-select" id="partUnit"></select>
											</td>
											<th>*안전재고량</th>
											<td>
												<input type="text" class="form-control" id="safetyStockQty" name="safetyStockQty" maxlength="16" disabled>
											</td>
										</tr>
										<tr>
											<th>*SPEC</th>
											<td colspan="3">
												<input type="text" class="form-control" style="max-width: 100%;" id="partSpec" name="partSpec" maxlength="90">
											</td>
										</tr>
										<tr>
											<th>*구분</th>
											<td>
												<select class="custom-select" id="partGubun"></select>	
											</td>
											<th>*Type</th>
											<td>
												<select class="custom-select" id="partType"></select>
											</td>
										</tr>
										<tr>
											<th>입고처</th>
											<td>
												<div class="row">
													<div class="input-sub m-0" style="width: 80%;">
														<input type="hidden" class="form-control" id="inCorpCd" name="inCorpCd">
														<input type="text" class="form-control" id="inCorpNm" name="inCorpNm" disabled>
														<button type="button" class="btn btn-primary input-sub-search" id="btnInCorpCd" onClick="selectInCorpCd()">
															<span class="oi oi-magnifying-glass"></span>
														</button>
													</div>
													<div class="ml-1" style="width: 5%;">
														<button type="button" class="btn closeBtn" onclick="$('#inCorpNm, #inCorpCd').val('')">
															<i class="mdi mdi-close"></i>
														</button>
													</div>
												</div>
											</td>
											<th>기본납기일</th>
											<td>
												<input class="form-control" id="basicDlvDate" name="basicDlvDate" maxlength="10">
											</td>
										</tr>
										<tr>
											<th>*자재단가</th>
											<td>
												<input class="form-control" id="unitCost" name="unitCost" style="text-align: right;" maxlength="18">
											</td>
											<th>표준단가</th>
											<td>
												<input class="form-control" id="standCost" name="standCost" style="text-align: right;" maxlength="18">
											</td>
										</tr>
										<tr>
											<th>*사용여부</th>
											<td>
												<select class="custom-select" id="useYn"></select>
											</td>
											<th>수입검사여부</th>
											<td>
												<select class="custom-select" id="inspectYn"></select>
											</td>
										</tr>
										<tr>
											<th>바코드관리여부</th>
											<td>
												<select class="custom-select" id="barcodeYn">
													<option value=''>선택</option>
													<option value="001">관리함</option>
													<option value="002">안함</option>
												</select>
											</td>
											<th>비고</th>
											<td>
												<input type="text" class="form-control" id="partDesc" name="partDesc" style="max-width: 100%;" maxlength="56">
											</td>
										</tr>
										<!--==========/table 내용 추가==========-->
									</table>
								</div>
							</form>
							<div class="mt-2">
								<button type="button"
									class="btn btn-primary d-none float-right d-none" id="btnSave">저장</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
								
								
							</div>
						</div>
						<!--====end====tab2 part=====-->
						<div class="tab-pane fade" id="tab2">
							<div class="card-body col-sm-12 p-1 mb-2">
								<button type="button" class="btn btn-warning float-right mr-1"
									id="btnInspectDel">삭제</button>
								<button class="btn btn-primary d-none"
									id="btnInspectDelConfirmLoading" type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
								<button type="button" class="btn btn-primary float-right mr-1"
									id="btnInspectAdd">추가</button>
								<button class="btn btn-primary d-none"
									id="btnInspectAddConfirmLoading" type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
							<form id="form2" enctype="multipart/form-data">
								<div class="table-responsive">
									<table class="table table-bordered" id="itemPartInspectTable">
										<colgroup>
											<col width="7%">
											<col width="18%">
											<col width="10%">
											<col width="64%">
										</colgroup>
										<thead class="thead-light">
											<!-- <tr>
												<th colspan="4">수입검사기준서 등록</th>
											</tr> -->
											<tr>
												<th>No.</th>
												<th>일자</th>
												<th>등록자</th>
												<th>수입검사기준서</th>
											</tr>
										</thead>
										<tbody id="dataList"></tbody>
										<tbody id="dataInsert"></tbody>
									</table>
								</div>
							</form>
							<div class="mt-2">
								<button type="button"
									class="btn btn-primary d-none float-right d-none"
									id="btnInspectSave">저장</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
						</div>
						<div class="tab-pane fade" id="tab3">
							<div class="card-body col-sm-12 p-1 mb-2">
								<button type="button" class="btn btn-warning float-right mr-1"
									id="btnAttachDel">삭제</button>
								<button class="btn btn-primary d-none"
									id="btnAttachDelConfirmLoading" type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
								<button type="button" class="btn btn-primary float-right mr-1"
									id="btnAttachAdd">추가</button>
								<button class="btn btn-primary d-none"
									id="btnAttachAddConfirmLoading" type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
							<form id="form3" enctype="multipart/form-data">
								<div class="table-responsive">
									<table class="table table-bordered"
										id="itemPartAttachDataTable">
										<colgroup>
											<col width="7%">
											<col width="10%">
											<col width="33%">
											<col width="50%">
										</colgroup>
										<thead>
											<tr>
												<th>No.</th>
												<th>등록자</th>
												<th>내용</th>
												<th>첨부파일</th>
											</tr>
										</thead>
										<tbody>

										</tbody>
										<!--==========/table 내용 추가==========-->
									</table>
								</div>
							</form>
							<div class="mt-2">
								<button type="button"
									class="btn btn-primary d-none float-right d-none"
									id="btnAttachSave">저장</button>
								<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
									type="button" disabled>
									<span class="spinner-border spinner-border-sm" role="status"
										aria-hidden="true"></span> 처리중
								</button>
							</div>
						</div>
					</div>
				</div>
				<!-- ===/.right-sidebar 등록,수정===  -->
			</div>
			<!-- /.row -->
		</div>
		<!-- / #main  -->
	</div>
	<!-- /.page-wrapper -->
	<div class="modal fade bd-example-modal-lg" id="inModal" tabindex="-1"
		role="dialog" aria-labelledby="inModalLabel2" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="inLabel">품목정보관리 엑셀조회</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<div class="table-responsive" style="height: 700px;">
					<table id="inTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th>No.</th>
								<th>CODE</th>
								<th>ITEM</th>
								<th>구분</th>
								<th>Type</th>
								<th>SPEC</th>
								<th>입고처</th>
								<th>단위</th>
								<th>기본납기일</th>
								<th>자재단가</th>
								<th>안전재고</th>
								<th>바코드관리여부</th>
								<th>사용여부</th>
								<th>수입검사여부</th>
								<th>비고</th>
							</tr>
						</thead>
					</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						id="btnApply">적용</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!--=======모달영역====================================================-->
</div>

<%@include file="../layout/bottom.jsp"%>

<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "59%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}

		state = !state;
	});

	let currentHref = "mmsc0010";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "품목정보(일반자재)");

	let sideView = 'add';
	let btnView = '';
	$("#tab2Nav").addClass('disabled');
	var serverDate = "${serverDate}";
	var userNm = "${userNm}";
	var dealCorpCd = "${dealCorpCd}";
	var activeTab = '기본정보';
	var partCd;
	var partSeq;
	var partRev = '00';
	var urlData=null;
	var partCdArr = [];
	
	//공통코드 처리 시작
	var partGubunCode = new Array();
	<c:forEach items="${partGubun}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	partGubunCode.push(json);
	</c:forEach>

	var partUnitCode = new Array();
	<c:forEach items="${partUnit}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	partUnitCode.push(json);
	</c:forEach>

	var partTypeCode = new Array();
	<c:forEach items="${partType}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	partTypeCode.push(json);
	</c:forEach>

	
	var useYnCode = new Array();
	<c:forEach items="${useYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	useYnCode.push(json);
	</c:forEach>

 	var inspectYnCode = new Array(); // 상태유무
	<c:forEach items="${inspectYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	inspectYnCode.push(json);
	</c:forEach> 

	//공통코드 처리 끝

	//선택박스 처리
	selectBoxAppend(partGubunCode, "partGubun", "", "2");
	selectBoxAppend(partUnitCode, "partUnit", "", "2");
	selectBoxAppend(partTypeCode, "partType", "", "2");
	selectBoxAppend(useYnCode, "useYn", "", "2");
	selectBoxAppend(inspectYnCode, "inspectYn", "", "2");

	$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
		activeTab = $(e.target).text();
	});

	$('#saveBtnModalY').on('click', function() {
		uiProc(true);
		$('#tab1Nav').tab('show');
		$('#btnSave').addClass('d-none');
		$('#btnInspectSave').addClass('d-none');
		$('#btnAttachSave').addClass('d-none');
		$('#btnEdit').attr('disabled', false);
		$('#btnInspectAdd').attr('disabled', false);
		$('#btnInspectDel').attr('disabled', false);
		$("#createValue").remove();
		$('#itemPartInspectTable').DataTable().ajax.reload();
	});

	uiProc(true);

	// 목록
	$.fn.dataTable.ext.errMode = 'none';
		let itemPartAdmTable = $('#itemPartAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	  dom: "<'row'<'col-sm-12 col-md-9'l><'col-sm-12 col-md-3'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
      language: lang_kor,
      paging: true,
      info: false,
      ordering: true,
      processing: true,
      autoWidth: false,
      scrollX : false,
      lengthChange: true,
      pageLength: 20,
		ajax : {
			url : '<c:url value="/mm/itemPartAdmList"/>',
			type : 'GET',
			data : {},
		},
		rowId : 'partCd',
		columns : [
			
			{ render : function(data, type, row, meta) {
					return meta.row
							+ meta.settings._iDisplayStart
							+ 1;
				}
			},
			{ data : 'partCd'		},
			{ data : 'partNm'		},
			{ data : 'partGubunNm'	},
			{ data : 'partSpec'		}
		],
		order : [ [ 1, 'asc' ] ],
		buttons: [
            {
                extend: 'copy',
                title: '품목정보(일반자재)',
            },
            {
                extend: 'excel',
                title: '품목정보(일반자재)',
            },
            {
                extend: 'print',
                title: '품목정보(일반자재)',
            }
        ],
	});

	// 보기
	$('#itemPartAdmTable tbody').on('click','tr',function() {

		$('#tab1Nav').tab('show');

		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#itemPartAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		partCd = itemPartAdmTable.row(this).data().partCd;
		partRev = itemPartAdmTable.row(this).data().partRev;
		$('#btnInspectAdd').addClass('d-none'); // 추가버튼
		$('#btnInspectDel').addClass('d-none'); // 삭제버튼
		$('#btnSave').addClass('d-none'); // 저장버튼
		$('#btnEdit').attr('disabled', false);
		$('#tab2Nav').removeClass('disabled');
		$('#tab3Nav').removeClass('disabled');

		$.ajax({
			url : '<c:url value="/mm/itemPartDtlList"/>',
			type : 'GET',
			data : {
				'partCd'	: partCd,
				'partRev'	: partRev
			},
			success : function(res) {
				let data = res.data;
				let statusYn = res.statusYn;

				if (res.result == 'ok') {
					sideView = 'edit';

					$('#partCd').val(data.partCd);
					$('#partNm').val(data.partNm);
// 					$('#partRev').val(data.partRev);
					$('#partSpec').val(data.partSpec);
					$('#inCorpCd').val(data.inCorpCd);
					$('#inCorpNm').val(data.inCorpNm);
					$('#partDesc').val(data.partDesc);
					$('#basicDlvDate').val(data.basicDlvDate);

					$('#safetyStockQty').val(data.safetyStockQty);
					$('#barcodeYn').val(data.barcodeYn);

					$('#unitCost').val(data.unitCost == null ? data.unitCost: addCommas(data.unitCost));
					$('#standCost').val(data.standCost == null ? data.standCost: addCommas(data.standCost));

					$('#partGubun').val(data.partGubun);
					$('#partType').val(data.partType);
					$('#partUnit').val(data.partUnit);
					$('#useYn').val(data.useYn);
					$('#inspectYn').val(data.inspectYn);

					uiProc(true);
				} else {
					toastr.error(res.message);
				}
			}
		});
	});

	var html1 = '<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">';
	html1 += '<label for="btnExcelUpload" class="btn btn-success mr-1">엑셀업로드</label>'
	html1 += '<input type="file" id="btnExcelUpload" name="excelfile" style="display: none" />';
	html1 += '<a href="/mm/itemPartBasicForm"><button type="button" class="btn btn-secondary" id="btnFileDownload">기본양식다운로드</button></a></form>';

	$('#itemPartAdmTable_length').html(html1);

	// 등록폼
	$('#btnAdd').on('click', function() {
		sideView = 'add';

		$('#form').each(function() {
			this.reset();
		});

		$('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
		
		selectBoxAppend(useYnCode, "useYn", "", "");

		uiProc(false);
// 		$('#partRev').val('00');
		$('#btnSave').removeClass('d-none'); // 저장버튼
		$('#btnInspectAdd').addClass('d-none'); // 추가버튼
		$('#btnInspectDel').addClass('d-none'); // 삭제버튼
		$('#btnEdit').attr('disabled', true);
	});

	// 리비전 등록폼
	/*$('#btnRevAdd').on('click', function() {

		if (sideView != 'edit') {
			toastr.warning("Revision등록할 항목을 선택해주세요.");
			return false;
		}

		/* $('#form').each(function() {
			this.reset();
		}); */

		/*$('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
		
		//Revision값 가져오기
		$.ajax({
			url : '<c:url value="mm/getPartRev"/>',
			type : 'GET',
			data : {
				'partCd' : partCd,
				'partRev' : partRev
			},
			success : function(res) {
				var data = res.data;
				$('#partCd').val(partCd);
				$('#partRev').val(data.partRev);
			}
		});

		uiProc(false);
		$('#partCd').attr('disabled', true);

		$('#btnInspectAdd').addClass('d-none'); // 추가버튼
		$('#btnInspectDel').addClass('d-none'); // 삭제버튼

		$('#btnEdit').attr('disabled', true);
		$('#btnSave').removeClass('d-none');

		sideView = 'rev';
	});*/

	// 수정폼
	$('#btnEdit').on('click', function() {
		if (sideView != 'edit') {
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}

		$('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
		
		uiProc(false);
		$("#partCd").attr("disabled", true);
		$('#btnInspectAdd').addClass('d-none'); // 추가버튼
		$('#btnInspectDel').addClass('d-none'); // 삭제버튼
		$('#btnSave').removeClass('d-none');
	});

	// 저장 처리
	$('#btnSave').on('click',function() {
		if (activeTab == "기본정보") {

			if (!$.trim($('#partCd').val())) {
				toastr.warning('코드를 입력해주세요.');
				$('#partCd').focus();
				return false;
			}
			if (!$.trim($('#partNm').val())) {
				toastr.warning('ITEM을 입력해주세요.');
				$('#partNm').focus();
				return false;
			}
			if ($("#partUnit option:selected").val() == "") {
				toastr.warning('단위를 선택해 주세요.');
				$('#partUnit').focus();
				return false;
			}
			if (!$.trim($('#partSpec').val())) {
				toastr.warning('SPEC을 입력해 주세요.');
				$('#partSpec').focus();
				return false;
			}
			if ($("#safetyStockQty").val() == "") {
				toastr.warning('안전재고량을 입력해주세요.');
				$('#safetyStockQty').focus();
				return false;
			}
			if ($("#partGubun option:selected").val() == "") {
				toastr.warning('구분을 선택해 주세요.');
				$('#partGubun').focus();
				return false;
			}
			if ($("#partType option:selected").val() == "") {
				toastr.warning('Type을 선택해 주세요.');
				$('#partType').focus();
				return false;
			}
			/* if (!$.trim($('#inCorpNm').val())) {
				toastr.warning('입고처를 선택해주세요.');
				$('#btnInCorpCd').focus();
				return false;
			} */
			if ($("#unitCost").val() == "") {
				toastr.warning('자재단가를 입력해 주세요.');
				$('#unitCost').focus();
				return false;
			}
			if ($("#useYn option:selected").val() == "") {
				toastr.warning('사용여부를 선택해 주세요.');
				$('#useYn').focus();
				return false;
			}
			if ($("#inspectYn option:selected").val() == "") {
				toastr.warning('수입검사여부를 선택해 주세요.');
				$('#inspectYn').focus();
				return false;
			}
			var url = '/mm/itemPartAdmCreate';
			if (sideView == "edit") {
				url = '/mm/itemPartAdmUpdate';
			} else if (sideView == "rev") {
				url = '/mm/itemPartRevCreate';
			}

			$.ajax({
				url : url,
				type : 'POST',
				data : {
					'partCd' 			: $('#partCd').val(),
					'partNm' 			: $('#partNm').val(),
					'partRev'	 		: "00",
					'partUnit' 			: $("#partUnit option:selected").val(),
					'partSpec' 			: $('#partSpec').val(),
					'safetyStockQty'	: $('#safetyStockQty').val().replace(/,/g, ''),
					'partGubun' 		: $("#partGubun option:selected").val(),
					'partType' 			: $("#partType option:selected").val(),
					'inCorpCd' 			: $('#inCorpCd').val(),
					'basicDlvDate'		: $('#basicDlvDate').val(),
					'unitCost' 			: $('#unitCost').val().replace(/,/g, ''),
					'standCost' 		: $('#standCost').val().replace(/,/g, ''),
					'useYn' 			: $("#useYn option:selected").val(),
					'inspectYn' 		: $("#inspectYn option:selected").val(),
					'barcodeYn' 		: $('#barcodeYn option:selected').val(),
					'partDesc' 			: $('#partDesc').val()
				},
				beforeSend : function() {
					// $('#btnAddConfirm').addClass('d-none');
					// $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success : function(res) {
					let data = res.data;
					if (res.result == 'ok') {
						// 보기
						$('#itemPartAdmTable').DataTable().ajax.reload(function() {});
						uiProc(true);
						$('#btnSave').addClass('d-none');
						$('#btnEdit').attr('disabled',false);
						$('#tab2Nav').removeClass('disabled');
						$('#tab3Nav').removeClass('disabled');
						
						if (sideView == "edit") {
							toastr.success('수정되었습니다.');

						} else if (sideView == "add") {
							toastr.success('신규 등록되었습니다.');

						} else if (sideView == "rev") {
							toastr.success('리비전 등록되었습니다.');
						}

						partCd = $('#partCd').val();
						partRev = "00";

						sideView = 'edit';
					} else if (res.result == "exist") {
						toastr.error("이미 등록된 코드입니다. 확인해주세요.");
					} else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
		}
	});

	$('#tab1Nav').on('click', function() {
		uiProc(true);
		$('#btnInspectAdd').addClass('d-none');
		$('#btnInspectDel').addClass('d-none');
		$('#btnSave').addClass('d-none');
		$('#itemPartInspectTable').DataTable().ajax.reload();
		//$('#itemPartInfoTable').DataTable().ajax.reload();

	});

	$('#tab2Nav').on('click', function() {
		$('#btnInspectAdd').removeClass('d-none');
		$('#btnInspectDel').removeClass('d-none');
		$('#btnInspectSave').addClass('d-none');
		$('#btnInspectAdd').attr('disabled', false);
		$('#btnInspectDel').attr('disabled', false);
		$("#createValue").remove();
		$('#itemPartInspectTable').DataTable().ajax.reload();
	});

	$('#tab3Nav').on('click', function() {
		$('#btnAttachAdd').removeClass('d-none');
		$('#btnAttachDel').removeClass('d-none');
		$('#btnAttachSave').addClass('d-none');
		$('#btnAttachAdd').attr('disabled', false);
		$('#btnAttachDel').attr('disabled', false);
		$('#itemPartAttachDataTable').DataTable().ajax.reload();
	});

	status = '';
	let itemPartInspectTable = $('#itemPartInspectTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		destroy : true,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		paging : false,
		searching : false,
		ajax : {
			url : '<c:url value="/mm/itemPartInspectList"/>',
			type : 'GET',
			data : {
				'partCd'	: function() { return partCd },
				'partRev'	: function() { return partRev },
			},
		},
		columns : [
				{
					render : function(data, type, row, meta) {
						return meta.row
								+ meta.settings._iDisplayStart
								+ 1;
					},
					'className' : 'text-center'
				},
				{
					render : function(data, type, row) {
						return moment(row['inspectDate'])
								.format('YYYY-MM-DD');
					},
					'className' : 'text-center'
				},
				{
					data : 'regNm',
					'className' : 'text-center'
				},
				{
					data : 'fileNm',
					render : function(data, type, row) {

						if (data == '') {
							return '<a href="/mm/itemPartInspectFileDownload?partCd='
									+ row['partCd']
									+ '&partRev='
									+ row['partRev']
									+ '&partSeq='
									+ row['partSeq'] + '"></a>';
						} else {
							return '<a href="/mm/itemPartInspectFileDownload?partCd='
									+ row['partCd']
									+ '&partRev='
									+ row['partRev']
									+ '&partSeq='
									+ row['partSeq']
									+ '">'
									+ data + '</a>';
						}
					}
				} ],
		buttons : []
	});

	//데이터 클릭 시
	$('#itemPartInspectTable tbody').on('click','tr',function() {
		if (status == "updating") {
			return;
		}
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#itemPartInspectTable').DataTable().$('tr.selected').removeClass('selected');
			$('#dataInsert').find('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		if(itemPartInspectTable.data().count() != 0){
			partSeq = itemPartInspectTable.row(this).data().partSeq;
		}
		status = "choice";
	});

	//추가버튼
	$('#btnInspectAdd').on('click',function() {

		var count = itemPartInspectTable.data().count();
		if (count == 0) {
			$('#itemPartInspectTable tbody').empty();
		}

		$('#itemPartInspectTable > #dataInsert').append(
				'<tr id="createValue"><td style="text-align:center;">'
					+ (count + 1)
					+ '</td>'
					+ '<td>'
					+ '<div class="form-group input-sub m-0 row">'
					+ '<input class="form-control" type="text" id="inspectDate" value="'+serverDate+'"name="inspectDate" disabled/>'
					+ '<button onclick="fnPopUpCalendar(inspectDate,inspectDate,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search"'
					+ 'id="inspectDateCalendar" type="button">'
					+ '<span class="oi oi-calendar"></span>'
					+ '</button>'
					+ '</div>'
					+ '</td>'
					+ '<td style="text-align:center;">'
					+ userNm
					+ '</td>'
					+ '<td><form id="formFile" method="post" enctype="multipart/form-data"> <div class="custom-file">'
					+ '<input type="file" class="custom-file-input" id="fileNm" name="file">'
					+ '<label class="custom-file-label" for="fileNm"></label>'
					+ '</div></form></td>'
				+ '</tr>'
		);

		$('#btnCheck').attr("disabled", false);
		$('#viewBox').addClass('d-none');
		$('#btnInspectSave').removeClass('d-none');
		$('#btnInspectAdd').attr('disabled', true); //추가버튼
		$('#btnInspectDel').attr('disabled', true); //삭제버튼		
	});

	//저장 버튼 클릭
	$('#btnInspectSave').on('click',function() {
		if (activeTab == "수입검사기준서") {

			if (!$.trim($('#fileNm').val())) {
				toastr.warning('파일을 선택해주세요.');
				$('#fileNm').focus();
				return false;
			}

			var formData = new FormData(document.getElementById("formFile")); 
			formData.append('partCd', $('#partCd').val());
			formData.append('partRev', "00");
			formData.append('inspectDate', $('#inspectDate').val().replace(/-/g, ''));

			$.ajax({
				url : '<c:url value="/mm/itemPartInspectCreate"/>',
				type : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				success : function(res) {
					if (res.result == 'ok') {
						// 보기
						toastr.success('등록되었습니다.');
						status = '';
					} else {
						toastr.error(res.message);
					}
					$('#itemPartInspectTable').DataTable().ajax.reload();
				}
			});

			$('#itemPartInspectTable').DataTable().ajax.reload();
			$('#formBox').removeClass('d-none');
			$('#equipCodeTable').DataTable().ajax.reload();
			$('#btnInspectSave').addClass('d-none');
			$('#btnInspectAdd').attr('disabled', false);
			$("#btnInspectDel").attr("disabled", false);
			$("#createValue").remove();
		}
	});

	//삭제 버튼 클릭
	$('#btnInspectDel').on('click', function() {
		if (status != 'choice') {
			toastr.warning("삭제할 항목을 선택해주세요. ");
			return false;
		}
		$.ajax({
			url : '<c:url value="/mm/itemPartInspectDelete"/>',
			type : 'POST',
			data : {
				'partCd'	: function() { return partCd;  },
				'partRev'	: function() { return partRev; },
				'partSeq' 	: function() { return partSeq; }
			},
			success : function(res) {
				// 보기
				$('#itemPartInspectTable').DataTable().ajax.reload();
				$('#btnSave').addClass('d-none');
				toastr.success('삭제되었습니다.');
				status = '';
				$('#formBox').removeClass('d-none');
			},
			complete : function() {
				$('#itemPartInspectTable').DataTable().ajax.reload();

			}
		});
	});

	//관련자료 목록조회
	let itemPartAttachDataTable = $('#itemPartAttachDataTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		destroy : true,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		paging : false,
		searching : false,
		ajax : {
			url : '<c:url value="/mm/itemPartAttachDataList"/>',
			type : 'GET',
			data : {
				'partCd'	: function() { return partCd  },
				'partRev'	: function() { return partRev },
			},
		},
		columns : [
				{
					render : function(data, type, row, meta) {
						return meta.row
								+ meta.settings._iDisplayStart
								+ 1;
					}
				},
				{
					data : 'regNm',
					render : function(data, type, row, meta) {
						if (data != null) {
							return data;
						} else {
							return userNm;
						}
					}
				},
				{
					data : 'contents',
					render : function(data, type, row, meta) {
						if (data != null) {
							return data;
						} else {
							return '<input class="form-control" type="text" id="contents" name="contents" />';
						}
					}
				},
				{
					data : 'fileNm',
					render : function(data, type, row, meta) {

						var html;

						if (data != null) {
							html = '<a href="/mm/itemPartAttachFileDownload?partCd='
									+ row['partCd']
									+ '&partRev='
									+ row['partRev']
									+ '&partSeq='
									+ row['partSeq']
									+ '">'
									+ data + '</a>';
						} else {
							html = '<div class="custom-file" disabled>'
							html += '<input type="file" class="custom-file-input" id="fileNm_'
									+ meta.row
									+ '" name="file" onchange=uploadWorkStandard("'
									+ meta.row + '"); />'
							html += '<label class="custom-file-label" for="fileNm_'+meta.row+'">파일을 선택해주세요.</label></div>'
						}

						return html;
					}
				} ],
		columnDefs : [ {
			"targets" : [ 0, 1 ],
			"className" : "text-center"
		},

		],
		buttons : []
	});

	//데이터 클릭 시
	$('#itemPartAttachDataTable tbody').on('click','tr',function() {

		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#itemPartAttachDataTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		partSeq = itemPartAttachDataTable.row(this).data().partSeq;
		status = "choice";
	});

	//추가버튼
	$('#btnAttachAdd').on('click', function() {
		/* if(status != "choice"){
			toastr.warning("관련자료 항목을 선택해주세요.");
		} */
		$('#itemPartAttachDataTable').DataTable().row.add({}).draw(false);

		$('#btnAttachAdd').attr('disabled', true);
		$('#btnAttachDel').attr('disabled', true);

		$('#btnAttachSave').removeClass('d-none');
	});

	//삭제버튼
	$('#btnAttachDel').on('click', function() {
		if (status != "choice") {
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}
		$.ajax({
			url : '<c:url value="mm/itemPartAttachDataDelete" />',
			type : 'POST',
			data : {
				'partCd'	: function() { return partCd;  },
				'partRev'	: function() { return partRev; },
				'partSeq'	: function() { return partSeq; },
			},
			success : function(res) {
				if (res.result == 'ok') {
					// 보기
					toastr.success('삭제되었습니다.');
					status = '';
				} else {
					toastr.error(res.message);
				}
				$('#itemPartAttachDataTable').DataTable().ajax.reload();
			}
		});
	});

	//저장 버튼 클릭
	$('#btnAttachSave').on('click', function() {
		if (activeTab == "관련자료") {

			if (!$.trim($('input[name=file]').val())) {
				toastr.warning('파일을 선택해주세요.');
				$('#file').focus();
				return false;
			}

			var formData = new FormData(document.getElementById("form3"));
			formData.append('partCd', $('#partCd').val());
			formData.append('partRev', "00");

			$.ajax({
				url : '<c:url value="mm/itemPartAttachDataCreate" />',
				type : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				success : function(res) {
					if (res.result == 'ok') {
						// 보기
						toastr.success('등록되었습니다.');
						status = '';
					} else {
						toastr.error(res.message);
					}
					$('#itemPartAttachDataTable').DataTable().ajax.reload();
					$('#btnAttachSave').addClass('d-none');
					$('#btnAttachAdd').attr('disabled', false);
					$('#btnAttachDel').attr('disabled', false);
				}
			});

		}
	});

	//입고처 팝업 시작
	var dealCorpPopUpTable;
	function selectInCorpCd() {
		if (dealCorpPopUpTable == null || dealCorpPopUpTable == undefined) {
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
				dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
						+ "<'row'<'col-sm-12'tr>>"
						+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange : false,
				serverSide : true,
				pageLength : 15,
				ajax : {
					url : '<c:url value="/bm/dealCorpDataList"/>',
					type : 'GET',
					data : {},
				},
				rowId : 'dealCorpCd',
				columns : [
					{ data : 'dealCorpCd'	},
					{ data : 'dealCorpNm'	},
					{ data : 'initial'		},
					{ data : 'presidentNm'	},
					{ data : 'country'		},
					{ data : 'corpNo'		}
				],
				columnDefs : [
					{ "defaultContent" : "-", "targets" : "_all", "className" : "text-center"}
				],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
			});

			$('#dealCorpPopUpTable tbody').on('click', 'tr', function() {
				var data = dealCorpPopUpTable.row(this).data();
				$('#inCorpCd').val(data.dealCorpCd);
				$('#inCorpNm').val(data.dealCorpNm);
				$('#dealCorpPopUpModal').modal('hide');
			});
		}
		$('#dealCorpPopUpModal').modal('show');
	}

	//자재단가,표준단가 콤마생성
	$(document).on('keyup', "#unitCost, #standCost, #safetyStockQty", function(evt) { //입력시 콤마 추가
		var costSum = 0;
		if ($(this).val() == "") {
			$(this).val("0");
			$(this).select();
		}
		//입력 정규식 0~9 .
		reg = /[^0-9.]/gi;
		let poQty = $(this).val().replace(/,/g, '');
		if (reg.test(poQty)) {
			poQty = poQty.replace(reg, '');
			$(this).val(addCommas(poQty));
			return false;
		}
		$(this).val(addCommas(poQty));
	});


	//엑셀업로드 모달
	let inTable = $('#inTable').DataTable({
		language : lang_kor,
		paging : false,
		destroy : true,
		info : false,
		ordering : false,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="mm/itemPartExcelDataList"/>',
			type : 'GET',
			data : {
				'url' : function(){return urlData;}
			}
		},
		rowId : 'partCd',
		columns : [
			{  
				render : function(data, type, row, meta) {
					return meta.row
							+ meta.settings._iDisplayStart
							
							+ 1;
				}
			},
			{ data : 'partCd'			},
			{ data : 'partNm'			},	
			{ data : 'partGubun'		},
			{ data : 'partType'			},
			{ data : 'partSpec'			},
			{ data : 'inCorpCd'			},
			{ data : 'partUnit'			},
			{ data : 'basicDlvDate'		},
			{ data : 'unitCost'			},
			{ data : 'safetyStockQty'	},
			{ data : 'barcodeYn'		},
			{ data : 'useYn',
				render : function(data, type, row, meta){
					if(data!=null){
						return data;
					}else{
						return "001";
					}
				}
			},
			{ data : 'inspectYn',
				render : function(data, type, row, meta){
					if(data!=null){
						return data;
					}else{
						return "001";
					}
				}
			},
			{ data : 'partDesc'}, 
		],
		columnDefs: [
			{ targets: [9] , render: $.fn.dataTable.render.number( ',' ), className : 'text-right' },
        	{"targets": "_all" , "className": "text-center"},
        ],
	});

	//파일 선택
	$('#btnExcelUpload').change( function() {
		var formData = new FormData($('#fileUploadForm')[0]);

		var str = $('#btnExcelUpload').val();
		index = 0;
		
		if (str.substring(str.lastIndexOf(".") + 1) == "xls"
				|| str.substring(str.lastIndexOf(".") + 1) == "xlsx") {
			$.ajax({
				type : "POST",
				enctype : 'multipart/form-data',
				data : formData,
				url : '<c:url value="mm/itemPartExcelUpload"/>',
				processData : false,
				contentType : false,
				cache : false,
				beforeSend : function(){
					//처리중..
					$('#my-spinner').show();
				},
				success : function(res) {
					urlData = res.data;
					$('#inTable').DataTable().ajax.reload(function(){});
					$('#inModal').modal('show');
					$('#btnExcelUpload').val("");
					//처리완료..
					$('#my-spinner').hide();
				},
				error : function(e) {
				}
			});
		} else {
			//toastr.warning("excel파일을 선택해 주세요.");
			return false;
		}
	});

	
	$('#btnApply').on('click',function(){
		var dataArray = new Array();		
		var check=true;
		//처리중..

		//코드 중복 검사
		for(var i=0; i<$('#inTable tbody tr').length; i++){
			var checkVal = $('#inTable tbody tr').eq(i).find('td').eq(1).text();
			for(var k=(i+1); k<$('#inTable tbody tr').length; k++){
				if(checkVal == $('#inTable tbody tr').eq(k).find('td').eq(1).text()){
					toastr.warning((i+1)+"번째, "+(k+1)+"번째 코드 값이 중복됩니다. <br> 중복된 값은 '"+checkVal+"' 입니다.");
					check=false;
					return false;
				}
			}
		}

		$('#my-spinner').show();
		
		$('#inTable tbody tr').each(function(index, item){
			 
			var rowData = new Object();
			rowData.partCd= inTable.row(index).data().partCd==null?"":inTable.row(index).data().partCd;
			rowData.partNm= inTable.row(index).data().partNm==null?"":inTable.row(index).data().partNm;
			rowData.partGubun= inTable.row(index).data().partGubun==null?"":inTable.row(index).data().partGubun;
			rowData.partType= inTable.row(index).data().partType==null?"":inTable.row(index).data().partType;
			//rowData.partGubunNm= $('#partGubunNm').val();
// 			rowData.partRev= inTable.row(index).data().partRev==null?"":inTable.row(index).data().partRev;
			rowData.partRev= "00";
			rowData.partSpec= inTable.row(index).data().partSpec==null?"":inTable.row(index).data().partSpec;
			rowData.inCorpCd= inTable.row(index).data().inCorpCd==null?"":inTable.row(index).data().inCorpCd;
			//rowData.partInCorpNm= $('#parpartInCorpNmtCd').val();
			rowData.partUnit= inTable.row(index).data().partUnit==null?"":inTable.row(index).data().partUnit;
			//rowData.partUnitNm= $('#partUnitNm').val();
			rowData.basicDlvDate= inTable.row(index).data().basicDlvDate==null?"":inTable.row(index).data().basicDlvDate;
			rowData.unitCost= inTable.row(index).data().unitCost==null?"":inTable.row(index).data().unitCost;
			rowData.safetyStockQty= inTable.row(index).data().safetyStockQty==null?"":inTable.row(index).data().safetyStockQty;
			rowData.barcodeYn= inTable.row(index).data().barcodeYn==null?"":inTable.row(index).data().barcodeYn;
			rowData.useYn= inTable.row(index).data().useYn==null?"001":inTable.row(index).data().useYn;
			rowData.inspectYn= inTable.row(index).data().inspectYn==null?"001":inTable.row(index).data().inspectYn;
			//rowData.useYnNm= $('#useYnNm').val();
			rowData.partDesc= inTable.row(index).data().partDesc==null?"":inTable.row(index).data().partDesc;
			
	        dataArray.push(rowData);
		});
			
		if(check == true){
			$.ajax({
				url : '<c:url value="mm/itemPartAdmExcelCreate"/>',
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {
					//처리중..
// 					$('#my-spinner').show();
				},
				success : function(res) {				
					if (res.result == 'ok') {
						$('#itemPartAdmTable').DataTable().ajax.reload(function(){});
						$('#inModal').modal('hide');
						
						toastr.success('저장되었습니다.');
					}else if(res.result == 'exist') {
						// '/' 짤라서 동일한 부품 행 색깔 채워주기
						/* partCdArr= res.partCdList.split("/");

						for(var i=0;i<inTable.data().count();i++) {
							for(var j=0;j<partCdArr.length; j++){
							    if(api.row(i).data().partCd == partCdArr[j]) {
							    	$('#'+api.row(i).data().partCd).addClass('bg-warning');
								} else {
									$('#'+api.row(i).data().partCd).removeClass('bg-warning');
								}
							}
						} */
// 						setTimeout(function() {
							toastr.warning("동일한 부품코드("+res.partCd+")가 존재합니다.");
// 						},1000);
						
					}else {
						toastr.error(res.message);
					}
					//처리완료..
					$('#my-spinner').hide();
				},
				complete : function() {
					$('#inOutWhsTable').DataTable().ajax.reload();
					$('#btnAddConfirm').removeClass('d-none');
					$('#btnAddConfirmLoading').addClass('d-none');				
				}
			});
		}
	});

	function uiProc(flag) {
		$("#partCd").attr("disabled", flag);
		$("#partNm").attr("disabled", flag);
		$("#partGubun").attr("disabled", flag);
		$("#partType").attr("disabled", flag);
		$("#partSpec").attr("disabled", flag);
		$("#partUnit").attr("disabled", flag);
		$("#basicDlvDate").attr("disabled", flag);
		$("#unitCost").attr("disabled", flag);
		$("#standCost").attr("disabled", flag);
		$("#btnInCorpCd").attr("disabled", flag);
		$("#useYn").attr("disabled", flag);
		$("#inspectYn").attr("disabled", flag);
		$("#partDesc").attr("disabled", flag);
		$("#safetyStockQty").attr("disabled", flag);
		$("#barcodeYn").attr("disabled", flag);
		$('.closeBtn').attr("disabled", flag);
	}
	

	//불러오기 버튼을 클릭 시
	$('#btnCall').on('click', function(){
		$('#partPopUpModal').modal('show');

		$('#itemPartAdmPopUpTable').DataTable().ajax.reload(function(){});

		//팝업테이블 클릭 시
		$('#itemPartAdmPopUpTable tbody').on('click', 'tr', function () {

			//event
			if ($(this).hasClass('selected')) {
				//$(this).removeClass('selected');
			} else {
				$('#itemMotorTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
			}

// 			$('#itemMotorTable').DataTable().$('tr.selected').removeClass('selected');
			$('#form').each(function(){
	        	this.reset();
	    	});
			sideView = 'add';
		  	var data = itemPartAdmPopUpTable.row( this ).data();
			//화면처리
			$('#form').each(function() {
				this.reset();
			});

			$('#tab2Nav').addClass('disabled');
			$('#tab3Nav').addClass('disabled');
			
			uiProc(false);
			$('#partRev').val('00');
			$('#btnSave').removeClass('d-none'); // 저장버튼
			$('#btnInspectAdd').addClass('d-none'); // 추가버튼
			$('#btnInspectDel').addClass('d-none'); // 삭제버튼
			$('#btnEdit').attr('disabled', true);
		  	
			$('#partNm').val(data.partNm);					//ITEM
			$('#partRev').val(data.partRev);				//Revision
			$('#partUnit').val(data.partUnit);				//단위
			$('#partSpec').val(data.partSpec);				//SPEC
			$('#partGubun').val(data.partGubun);			//구분
			$('#partType').val(data.partType);				//Type

			$('#inCorpCd').val(data.inCorpCd);				//입고처**
			$('#inCorpNm').val(data.inCorpNm);				//입고처**
			
			$('#basicDlvDate').val(data.basicDlvDate);		//기본납기일
			$('#unitCost').val(data.unitCost);				//자재단가
			$('#standCost').val(data.standCost != null ? addCommas(data.standCost):'');	//표준단가
			$('#inspectYn').val(data.inspectYn);			//수입검사여부
			$('#partDesc').val(data.partDesc);				//비고
			
		    $('#partPopUpModal').modal('hide');
		});
	});

	// 목록
	let itemPartAdmPopUpTable = $('#itemPartAdmPopUpTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6l><'col-sm-12 col-md-6'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
		language : lang_kor,
		paging : true,
		info : false,
		destroy : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : false,
		serverSide : true,
		pageLength : 20,
		ajax : {
			url : '<c:url value="/mm/itemPartAdmList"/>',
			type : 'GET',
			data : {},
		},
		rowId : 'partCd',
		columns : [
			{ render : function(data, type, row, meta) {
					return meta.row + meta.settings._iDisplayStart + 1;
				}
			},
			{ data : 'partCd'		},
			{ data : 'partNm'		},
			{ data : 'partGubunNm'	},
			{ data : 'partRev'		},
			{ data : 'partSpec' 	}
		],
		columnDefs : [ {
			"defaultContent": "-", "targets": "_all",	"className": "text-center"
		}],
		order : [ [ 1, 'asc' ] ],
	});

</script>

</body>
</html>
