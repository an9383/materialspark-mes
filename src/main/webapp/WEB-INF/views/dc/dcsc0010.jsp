<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">문서관리</a></li>
				<li class="breadcrumb-item active">문서관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 30%;">
				<div class="card">
<!-- 					<div class="open-arrow" id="arrowLeft"> -->
<!-- 						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button"> -->
<!-- 							<i class="mdi mdi-arrow-left"></i> -->
<!-- 						</button> -->
<!-- 					</div> -->
					<div class="table-responsive">
						<table id="documentMngtTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th>No.</th>
									<th>년도</th>
									<th>월</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" style="width: 69%;">
				<div class="card mb-2" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12 p-1">
<!-- 						<div class="rightsidebar-close"> -->
<!-- 							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"> -->
<!-- 								<i class="mdi mdi-close"></i> -->
<!-- 							</a> -->
<!-- 						</div> -->
					</div>
					<div class="tab-content">
						<!--====end====tab2 part=====-->
						<div class="card-body col-sm-12 p-1 mb-2">
							<button type="button" class="btn btn-danger float-right mr-1" id="btnLineDel">삭제</button>
<!-- 							<button type="button" class="btn btn-primary float-right mr-1" id="btnLineAdd">추가</button> -->
							<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
						</div>
						<form id="form" enctype="multipart/form-data">
							<div class="table-responsive">
								<table class="table table-bordered" id="documentMngtDtlTable">
									<colgroup>
										<col width="7%">
										<col width="15%">
										<col width="10%">
										<col width="30%">
										<col width="20%">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th>No.</th>
											<th>일자</th>
											<th>등록자</th>
											<th>문서</th>
											<th>비고</th>
										</tr>
									</thead>
									<tbody id="dataList"></tbody>
									<tbody id="dataInsert"></tbody>
								</table>
							</div>
						</form>
						<div class="mt-2">
							<button type="button" class="btn btn-primary d-none float-right d-none" id="btnSave">저장</button>
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
</div>

<%@include file="../layout/bottom.jsp"%>

<script>

	let currentHref = "dcsc0010";
	let currentPage = $('.' + currentHref).attr('id');
	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "문서관리");

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
	
	let startDate	= "${serverDateFrom}";
	let endDate		= "${serverDate}";
	let serverDate	= "${serverDate}"; 
	let userNm		= "${userNm}"; 
			
	let yearReceived = new Array();
	<c:forEach items="${documentMngtList}" var="info">
		yearReceived.push("${info.fileRegYear}");
	</c:forEach> 

	let set = new Set();
		set = new Set(yearReceived);
	let documentMngtYear = new Array();
		documentMngtYear = [...set];

	let fileRegYear	='0000';
	let fileRegDay	='0000';

	//문서정보 상세조회
	$.fn.dataTable.ext.errMode = 'none';
   	let documentMngtTable = $('#documentMngtTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
			url : '<c:url value="dc/documentMngtDateList"/>',
			type : 'GET',
			data : {
				'fileRegYear'	: function(){ return fileRegYear.replace(/-/g,''); },
// 				'endDate'	: function(){ return endDate.replace(/-/g,'')+1; }
			},
		},
		rowId : 'mngtCode',
		columns : [
			{ render : function(data, type, row, meta) { return meta.row + meta.settings._iDisplayStart + 1; } },
			{ data : 'fileRegYear'		},
			{ data : 'fileRegDay'		},
			/*{ render : function(data, type, row) {
					return moment(row['fileRegDay']).format('YYYY-MM-DD');
				}
			},*/
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
    html1 += '<select class="custom-select" style="width: 150px;" id="selectFileRegYear" onChange="yearChange($(this).val())" >';
    html1 += '<option selected>선택</option>';
	documentMngtYear.forEach(function(element){
		html1 += '<option>'+element+'</option>';
	});
	html1 += '</select>';
    html1 += '</div>';
    
	$('#documentMngtTable_length').html(html1);

	//main 클릭 시
	$('#documentMngtTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			
		} else {
			$('#documentMngtTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');

// 			fileRegYear	= documentMngtTable.row(this).data().fileRegYear;
			fileRegDay	= documentMngtTable.row(this).data().fileRegDay;

			$('#documentMngtDtlTable tbody').empty();
			$('#documentMngtDtlTable').DataTable().ajax.reload();

			$('#btnAdd').attr('disabled', false);
			$('#btnLineDel').attr('disabled', false);
			$('#btnSave').addClass('d-none');
		}
	});


   	//상세 조회
	let documentMngtDtlTable = $('#documentMngtDtlTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		destroy : true,
		info : false,
		ordering : false,
		processing : true,
		autoWidth : false,
		paging : false,
		searching : false,
		ajax : {
			url : '<c:url value="/dc/documentMngtList"/>',
			type : 'GET',
			data : {
				'fileRegYear'	: function() { return fileRegYear	},
				'fileRegDay'	: function() { return fileRegDay	}
			},
		},
		columns : [
			{ render : function(data, type, row, meta) { return meta.row + meta.settings._iDisplayStart + 1; } },
			{ render : function(data, type, row) {
					return moment(row['fileRegDate']).format('YYYY-MM-DD');
				}
			},
			{ data : 'regNm' },
			{ data : 'fileNm',
				render : function(data, type, row) {
					if (data == '') {
						return '<a href="/dc/documentMngtFileDownload?mngtCode='
							+ row['mngtCode']
							+ '&fileNm='
							+ row['fileNm']
							+ '&fileRegDate='
							+ row['fileRegDate'] + '"></a>';
					} else {
						return '<a href="/dc/documentMngtFileDownload?mngtCode='
							+ row['mngtCode']
							+ '&fileNm='
							+ row['fileNm']
							+ '&fileRegDate='
							+ row['fileRegDate']
							+ '">'
							+ data + '</a>';
					}
				}
			},
			{ data : 'documentDesc' }
		],
		buttons : [],
		columnDefs : [ 
			{targets : '_all', className : 'text-center'} 
		]
	});


   	$('#documentMngtDtlTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {

		} else {
			$('#documentMngtDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
	});


 	//등록버튼
	$('#btnAdd').on('click',function() {

		let count	= documentMngtDtlTable.data().count();
		let date	= '';
		
		if (count == 0) {
			$('#documentMngtDtlTable tbody').empty();
		}

		count = 0;

		$('#documentMngtDtlTable').DataTable().clear().draw();
		$('#documentMngtDtlTable tbody').empty();

		if(fileRegYear == '0000' || fileRegYear == '' || fileRegYear == '선택'){
			date = serverDate;
		} else {
			date = fileRegYear + serverDate.substring(4,10);
		}

		$('#documentMngtDtlTable > #dataInsert').append(
			'<tr id="createValue"><td style="text-align:center;">'
			+ (count + 1)
			+ '</td>'
			+ '<td>'
			+ '<div class="form-group input-sub m-0 row">'
			+ '<input class="form-control" type="text" id="fileRegDate" value="'+date+'"name="fileRegDate" disabled/>'
			+ '<button onclick="fnPopUpCalendar(fileRegDate,fileRegDate,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search"'
			+ 'id="fileRegDateCalendar" type="button">'
			+ '<span class="oi oi-calendar"></span>'
			+ '</button>'
			+ '</div>'
			+ '</td>'
			+ '<td style="text-align:center;">'+userNm+'</td>'
			+ '<td><form id="formFile" method="post" enctype="multipart/form-data"> <div class="custom-file">'
			+ '<input type="file" class="custom-file-input" id="fileNm" name="file">'
			+ '<label class="custom-file-label" for="fileNm"></label>'
			+ '</div></form></td>'
			+ '<td> <input type="text" class="form-control touch6" style="max-width: 100%;" id="documentDesc" name="documentDesc"/> </td>' 
			+ '</tr>'
		);

		fileRegYear ='';
		fileRegDay = '';

		$('#documentMngtTable').DataTable().$('tr.selected').removeClass('selected');
		
		$('#btnAdd').attr('disabled', true);		//추가버튼
		$('#btnLineDel').attr('disabled', true);	//삭제버튼		
		$('#btnSave').removeClass('d-none');		//저장버튼	
	});


 	//파일 값 변경 되었을 때
	$(document).on('change', '#fileNm', function(e){
		let str = $('#fileNm').val();
			str = str.substring(str.lastIndexOf(".") + 1).toLowerCase();

		if (str != "xls" && str != "xlsx"
			&& str != "doc" && str != "docm" && str != "docx"
			&& str != "hwp" && str != "hwpx" && str != "hwt" && str != "hml"
			&& str != "jpeg" && str != "jpg" && str != "png"
			&& str != "bmp" && str != "rle" && str != "dib" ) {
			
			toastr.warning('엑셀 & 한글 & 워드 &이미지만 등록이 가능합니다.');
			$(this).val('');
			return false;
		} 
	});

	//저장 버튼 클릭
	$('#btnSave').on('click',function() {

		$('#my-spinner').show();
		
		if (!$.trim($('#fileNm').val())) {
			toastr.warning('파일을 선택해주세요.');
			$('#fileNm').focus();
			return false;
		}

		let formData = new FormData(document.getElementById("formFile")); 
			formData.append('documentDesc', $('#documentDesc').val());
			formData.append('fileRegDate', $('#fileRegDate').val().replace(/-/g, ''));

		$.ajax({
			url : '<c:url value="/dc/documentMngtCreate"/>',
			type : 'POST',
			data : formData,
			processData : false,
			contentType : false,
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success('등록되었습니다.');

					fileRegYear = $('#fileRegDate').val().substring(0,4);
					fileRegDay = $('#fileRegDate').val().substring(5,7);
					
					$('#documentMngtTable').DataTable().ajax.reload(function(){
						$(documentMngtTable.row(documentMngtTable.data().toArray().findIndex(d => d.fileRegDay == fileRegDay)).node()).click();
					});
					
					$('#documentMngtDtlTable tbody').empty();
					$('#documentMngtDtlTable').DataTable().ajax.reload();
					selectYearUpdate();

					$('#btnAdd').attr('disabled', false);
					$('#btnLineDel').attr('disabled', false);
					$('#btnSave').addClass('d-none');
					$('#my-spinner').hide();
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
			}
		});
		
		
	});


	//라인 삭제 버튼 클릭 시
	$('#btnLineDel').on('click', function(){
		
		if ( $('#documentMngtDtlTable tbody tr').hasClass('selected') =='' ||  $('#documentMngtDtlTable tbody tr').text() == '데이터가 없습니다.' ) {
			toastr.warning('삭제할 항목을 선택해주세요.');	
			return false;
		}

		let selectDtlData = documentMngtDtlTable.rows('.selected').data()[0];
		
		//삭제
		$.ajax({
			url : '<c:url value="dc/documentMngtDelete"/>',
			type : 'POST',
			data : {
				 'mngtCode'		: function(){ return selectDtlData.mngtCode; 						},
				 'fileRegDate'	: function(){ return selectDtlData.fileRegDate.replace(/-/g, '');	},
				 'fileNm'		: function(){ return selectDtlData.fileNm;							}
			},
			success : function(res) {
				let data = res.result;
				
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');

					selectYearUpdate();

					$('#documentMngtTable').DataTable().ajax.reload(function(){
						$(documentMngtTable.row(documentMngtTable.data().toArray().findIndex(d => d.fileRegDay == fileRegDay)).node()).click();
					});
					$('#documentMngtDtlTable tbody').empty();
					$('#documentMngtDtlTable').DataTable().ajax.reload();
				} else {
					toastr.error(res.message);
				}
			}
		});
		//삭제
	});

	//년도 Update
	function selectYearUpdate(){
		$.ajax({
			url : '<c:url value="/dc/documentMngtDateList"/>',
			type : 'GET',
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {

					yearReceived = new Array();

					data.forEach(function(element){
					    yearReceived.push(element.fileRegYear);
					});

					set = new Set(yearReceived);
					documentMngtYear = [...set];

					html1 = ''; 
				    html1 += '</div>';   
					html1 += '<select class="custom-select" style="width: 150px;" id="selectFileRegYear" onChange="yearChange($(this).val())" >';
					html1 += '<option>선택</option>';
					documentMngtYear.forEach(function(element){
						if(element == fileRegYear){
							html1 += '<option selected>'+element+'</option>';
						}else {
							html1 += '<option>'+element+'</option>';
						}
					});
					html1 += '</select>';
				    html1 += '</div>';

				    $('#documentMngtTable_length').html(html1);

// 					console.log(documentMngtYear);
				} else {
					toastr.error(res.message);
				}
			}
		});
	}

	//년도 selectBox 바꼈을 때
	function yearChange(val){
		fileRegYear = val;
		fileRegDay  = '';
		$('#documentMngtTable').DataTable().ajax.reload();
		$('#documentMngtDtlTable tbody').empty();
		$('#documentMngtDtlTable').DataTable().clear().draw();

		$('#btnAdd').attr('disabled', false);
		$('#btnLineDel').attr('disabled', false);		
		$('#btnSave').addClass('d-none');
	}


</script>

</body>
</html>
