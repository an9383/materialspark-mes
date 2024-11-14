<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">

	<!-- Modal Start-->
	<div class="modal fade" id="filePopUpModal" tabindex="-1" role="dialog" aria-labelledby="filePopUpLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="filePopUpLabel">첨부파일 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<table class="table table-sm table-bordered" id="layerPopUpTable" style="text-align: center">
						<tr>
							<td class="align-middle" style="width: 100px">제목</td>
							<td><input type="text" class="form-control mw-100" id="fileTitle" name="fileTitle"></td>
						</tr>
						<tr>
							<td class="align-middle" style="width: 100px">첨부파일</td>
							<td>
								<form id="formFile" method="post" enctype="multipart/form-data"> 
									<div class="custom-file">'
										<input type="file" class="custom-file-input" id="fileNm" name="file">
										<label class="custom-file-label" for="fileNm"></label>
									</div>
								</form>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-primary" id="filePopUpSave" data-dismiss="modal">저장</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">통합관리</a></li>
				<li class="breadcrumb-item active">프린터관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 100%;">
				<div class="card">
					<div class="table-responsive">
						<table id="docPrnAdmTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="56%">
								<col width="25%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>No.</th>
									<th>제목</th>
									<th>첨부파일</th>
									<th>등록자</th>
									<th>등록일</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!-- /.left-list -->
			</div>
			<!-- /.row -->
		</div>
		<!-- / #main  -->
	</div>
	<!-- /.page-wrapper -->
</div>

<%@include file="../layout/bottom.jsp"%>

<script>

	let currentHref = "dcsc0020";
	let currentPage = $('.' + currentHref).attr('id');
	$('#' + currentPage).closest('.has-child', 'li').addClass('has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "프린터관리");
	
	let startDate	= "${serverDateFrom}";
	let endDate		= "${serverDate}";
	let serverDate	= "${serverDate}";
	let userNm		= "${userNm}";
	
	//문서정보 상세조회
	$.fn.dataTable.ext.errMode = 'none';
   	let docPrnAdmTable = $('#docPrnAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>B>",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : 20,
		ajax : {
			url : '<c:url value="/dc/docPrnAdmList"/>',
			type : 'GET',
			data : {
			},
		},
		rowId : 'mngtCode',
		columns : [
			{ render : function(data, type, row, meta) { return meta.row + meta.settings._iDisplayStart + 1; } },
			{ data : 'documentDesc' },
			{ data : 'fileNm',
				render : function(data, type, row) {
					if (data == '') {
						return '<a href="/dc/docPrnAdmFileDownload?mngtCode=' + row['mngtCode']
							+ '&fileNm=' + row['fileNm']
							+ '&fileRegDate=' + row['fileRegDate'] + '"></a>';
					} else {
						return '<a href="/dc/docPrnAdmFileDownload?mngtCode=' + row['mngtCode']
							+ '&fileNm=' + row['fileNm']
							+ '&fileRegDate=' + row['fileRegDate'] + '">' + data + '</a>';
					}
				}
			},
			{ data : 'regNm' },
			{ render : function(data, type, row) {
					return moment(row['fileRegDate']).format('YYYY-MM-DD');
				}
			},
		],
		order : [ [ 0, 'asc' ] ],
		buttons : [],
		columnDefs : [ 
			{targets : '_all', className : 'text-center'} 
		],
		drawCallback: function() {}
	});

    let html1 = '';
    html1 += '</div>';   
   	html1 += '<button type="button" class="btn btn-primary float-left mr-1" id="btnAdd">등록</button>';
    html1 += '<button type="button" class="btn btn-danger float-left mr-1" id="btnLineDel">삭제</button>';
    html1 += '</div>';
    
	$('#docPrnAdmTable_length').html(html1);

	$(document).ready(function(){
		if (userNm != '관리자' && userNm != '관리자2') {
			$("#btnAdd").addClass("d-none");
			$("#btnLineDel").addClass("d-none");
		}
	}); 

	$("#btnAdd").on('click', function() {
		$("#filePopUpModal").modal('show');
	})
	
	//저장 버튼 클릭
	$('#filePopUpSave').on('click',function() {
		$('#my-spinner').show();
		
		if (!$.trim($('#fileNm').val())) {
			toastr.warning('파일을 선택해주세요.');
			$('#fileNm').focus();
			return false;
		}

		let formData = new FormData(document.getElementById("formFile")); 
			formData.append('documentDesc', $('#fileTitle').val());
			formData.append('fileRegDate', moment().format('YYYYMMDD'));
			
		$.ajax({
			url : '<c:url value="/dc/docPrnAdmCreate"/>',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success('등록되었습니다.');
					$('#my-spinner').hide();
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
			}
		});
	});
</script>

</body>
</html>
