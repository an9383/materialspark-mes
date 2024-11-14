<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">파괴 결과등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 35%; padding-bottom:0px;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="reliabilityDstryTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>생산일</th>
									<th>등록자</th>
									<th>등록시간</th>
								</tr>
							</thead>
						</table>
					</div><!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
			
			 <div class="right-list right-sidebar" id="myrSidenav" style="width:64%; padding-top:0px; padding-bottom:0px;">
				 <div class="card">
				 	<div class="card-body col-sm-12" style="padding-bottom:8px;">
				 		<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item">
									<a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">결과등록</a>
								</li>
								<li class="nav-item">
									<a class="nav-link disabled" id="tab2Nav" data-toggle="tab" href="#tab2">사진</a>
								</li>
							</ul>
						</div>
					</div>
					<!-- 비포 애프터 -->
					<div class="tab-pane fade active show" id="tab1">
						<div class="p-1 mt-1 row">
								<!-- <div style="height:3vh;">
									<label class="input-label-sm ml-1 mt-1">일자</label>
								</div>
								<div class="input-sub ml-5">
									<input class="form-control" style="width:147px;" type="text" id="leakageDate" name="leakageDate" />
									<button onclick="fnPopUpCalendar(leakageDate,leakageDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="leakageDateCalendar" type="button">
										<span class="oi oi-calendar"></span>
									</button>
								</div> -->
							<div class="row mr-6" style="width:800px;">
								<button type="button" class="btn btn-primary " id="" onclick="dstryMake()">기본생성</button>
								<button type="button" class="btn btn-primary float-right ml-2" id="leakageTestUpdate" disabled="">수정</button>
								<button type="button" class="btn btn-primary float-right ml-2 mr-6" id="leakageTestCreate" disabled="">저장</button>
							</div>
								<div class="row ml-5">
									<label>NG </label>
									<div style="background-color: red;width: 20px;height: 20px;border-radius: 50%;margin-left: 3px;"></div>
								</div>
								
								<div class="row ml-3">
									<label>無 </label>
									<div style="background-color: yellow;width: 20px;height: 20px;border-radius: 50%;margin-left: 3px;"></div>
								</div>
						</div>
						<div class="p-1 row">
							<div style="height:3vh;">
								<label class="input-label-sm ml-1 mt-1">주야간구분</label>
							</div>
							<div class="ml-3">
								<c:forEach items="${dayNGubun}" var="info">
								<input type="radio" class="mt-1" style="width:20px; height:20px;" name="dayNGubunList" id="dayNGubunList${info.baseCd}" value="${info.baseCd}" disabled/>
								<label for="dayNGubunList${info.baseCd}" class="input-label-sm" style="margin-left:3px; margin-right:5px; top:-5px; position:relative;"> ${info.baseCdNm}</label>
								</c:forEach>
								<input type="radio" class="mt-1" style="width:20px; height:20px;" name="dayNGubunList" id="dayNGubunListA" value="A" disabled/>
								<label for="dayNGubunListA" class="input-label-sm" style="margin-left:3px; margin-right:5px; top:-5px; position:relative;"> 전체</label>
							</div>
							&nbsp;
							<div class="ml-3">
								<input type="checkbox" name="okNgVal" id="okNgVal" value="001" style="width:20px; height:20px; top:3.5px; position:relative;" disabled>
								<label for="okNgVal" class="input-label-sm" style="margin-left:3px; margin-right:5px;"> NG/OK</label>
								<input type="checkbox" name="makeNothing" id="makeNothing" value="002" style="width:20px; height:20px; top:3.5px; position:relative;" disabled>
								<label for="makeNothing" class="input-label-sm mr-2" style="margin-left:3px; margin-right:5px;"> 생산無</label>
								<button type="button" class="btn btn-success float-right ml-2" id="applyLeakageTest" disabled>적용</button>
							</div>
							&nbsp;
						</div>
					
						<!-- 결과등록 -->
						<form id="form">
							<div class="table-responsive" id="tabTable1">
								<table class="table table-bordered d-none" id="tableC">
									<colgroup>
										<col width="10%">
										<col width="5%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2"><input type="checkbox" class="checkbox_sm d-none" id="checkAll" style="width:20px; height:20px;position:relative;"></th>
											<th rowspan="2">순번</th>
											<th rowspan="2">라인</th>
											<th colspan="2">주간</th>
											<th colspan="2">야간</th>
										</tr>
										<tr>
											<th>주간</th>
											<th>D0/D1</th>
											<th>야간</th>
											<th>D0/D1</th>
										</tr>
									</thead>
								</table>
							</div>
						</form>
						<form id="form1">
							<div class="table-responsive" id="tabTable2" >
								<table class="table table-bordered" id="tableD">
									<colgroup>
										<col width="10%">
										<col width="5%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th rowspan="2"><input type="checkbox" class="checkbox_sm d-none" id="checkAll" style="width:20px; height:20px;position:relative;"></th>
											<th rowspan="2">순번</th>
											<th rowspan="2">라인</th>
											<th colspan="2">주간</th>
											<th colspan="2">야간</th>
										</tr>
										<tr>
											<th>주간</th>
											<th>D0/D1</th>
											<th>야간</th>
											<th>D0/D1</th>
										</tr>
									</thead>
								</table>
							</div>
						</form>
					</div>
					<!-- 끝 -->
					
					<!-- 사진 관련 테이블 -->
					<div class="tab-pane fade d-none" id="tab2">
						<div>
							<div class="card-body col-sm-12 p-1 mb-1 mt-1">
		<!-- 						<button type="button" class="btn btn-success float-left mr-1" id="" onclick="">도움말</button> -->
								<button type="button" class="btn btn-primary float-right mr-1" id="btnDtlSave">저장</button>
								<button type="button" class="btn btn-danger float-right mr-1" id="btnDtlDel">삭제</button>
								<button type="button" class="btn btn-primary float-right mr-1 d-none" id="btnBlankAdd">추가</button>
								<button type="button" class="btn btn-primary float-right mr-1" id="btnDescEdit">비고수정</button>
								<label for="btnMultiUpload" class="btn btn-primary float-right mr-1">사진추가</label>
								<input multiple="multiple" type="file" class="btn btn-primary custom-file-input" id="btnMultiUpload" name="multifile" style="display: none"
									accept="image/png, image/jpg, image/jpeg, image/tif, image/tiff, image/raw, image/bmp, image/rle, image/heic">
							</div>
							
							<!-- 사진 테이블 -->
							<form id="photoForm" enctype="multipart/form-data">
								<div class="table-responsive" style="height: 70vh;">
									<table class="table table-bordered" id="photoDtlTable">
									<colgroup>
										<col width="15%">
										<col width="50%">
										<col width="35%">
									</colgroup>
										<thead>
											<tr>
												<th>순번</th>
												<th>사진</th>
												<th>비고</th>
											</tr>
										</thead>
									</table>
								</div>
							</form>
							<!-- 사진 테이블 끝-->
						</div>
					</div>
					<!-- 사진 관련 테이블 끝-->
				</div>
			</div><!-- /.right-list -->
		</div>
	</div><!-- /.row -->
</div><!-- / #main  -->

<!-- 삭제 모달 -->
<div class="modal modal-alert fade" id="deleteModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="deleteModal" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="exampleModalAlertWarningLabel" class="modal-title">
					<i class="fa fa-bullhorn text-warning mr-1"></i> 데이터 삭제
				</h5>
			</div>
			<div class="modal-body">
				<p>
					삭제된 데이터는 복구가 불가능합니다.<br>정말 삭제하시겠습니까?
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnDeleteConfirm">삭제</button>
				<button class="btn btn-danger d-none" id="btnDeleteConfirmLoading" type="button" disabled="">
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...
				</button>
				&nbsp;
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 삭제 모달 -->

<%@include file="../layout/bottom.jsp" %>

<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "50%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
		state = !state;
	});

	let menuAuth = 'qmsc3290';
	let currentHref = 'qmsc3290';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","파괴 결과등록");

	//공통코드 처리 시작
/* 	var photoCountCode = new Array();
	<c:forEach items="${photoCount}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdAbbr = "${info.baseCdAbbr}";
	photoCountCode.push(json);
	</c:forEach> */
	//공통코드 처리 시작
	
	var serverDateFrom = "${serverDateFrom}";
	var chooseDate1 = "${serverDateFrom}";
	var chooseDate2 = "${serverDate}";
//	var leakageDateVal = "${serverDate}";


//	$('#leakageDate').val(leakageDateVal);

	/*
		reliabilityDstryTable = 왼쪽 mainTable
		tableC = 실링 테이블
		tableD = 침투액 테이블
		tableC = 파괴 테이블
	*/

	var reliabilityDstryTableIdx = ''; 	//테이블 아이디 값
	var radioVal = '';
	var chkVal = '';
	let photoFileNo = '';
	let leakDstryFileNo = '';
	let fileSeq = '';
	let dtlFileName = '';
	
	var sideView = '';
	var dtlSideView = '';
	let updDesc = 0;
	
	// 파일 검사 (이미지 파일만)
	var checkImgType = function(filePath) {
	    var fileFormat = filePath.split(".");
	    if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
	        return true;
	    } else {
	        return false;
	    }
	}

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let reliabilityDstryTable = $('#reliabilityDstryTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-12'l><'col-sm-12 col-md-0'>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="qm/reliabilityLeakageResultCreateList"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'leakDstryGubun'	:	'002'
            },
        },
        rowId: '',
        columns: [
        	{ data: 'testDate',
        		render : function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD');
				}	
            },
        	{ data: 'userNm' },
        	{ data: 'regDate',
        		render : function(data, type, row, meta) {
					return moment(data).format('YYYY-MM-DD HH:mm');
				}	
            }
        ],
        buttons: ['copy', 'excel', 'print'],
	});
	
	reliabilityDstryTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});


	$('#reliabilityDstryTable').DataTable().$('tr.selected').removeClass('selected');
	
	//검사 테이블
	let tableD = $('#tableD').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollY : "60vh",
        scrollCollapse: false,
		async : false,
		ajax : {
			url : '<c:url value="qm/reliabilityLeakageResultList"/>',
			type : 'GET',
			data : {
				'menuAuth'			:	menuAuth
			},
		},
		rowId : '',
		columns : [
			{ 
				data : '',
				render : function(data, type, row, meta) {
					return '<input type="checkbox" class="chk d-none" id="'+(meta.row+1)+'" style="width:20px; height:20px;position:relative;"/>';
				}
			},
			{ 
				data : '',
				render : function(data, type, row, meta) {
					return meta.row+1;
				}	
			},
			{ data : 'equipNm' },
			{ data : '' ,
				render : function(data, type, row, meta) {
					return 'OK';
				}	
			},
			{ data : '' ,
					render : function(data, type, row, meta) {
						return 'Y';
					}	
			},
			{ data : '' ,
						render : function(data, type, row, meta) {
							return 'OK';
						}
			},
			{ data : '' ,
				render : function(data, type, row, meta) {
					return 'Y';
				}	
			},
		],
		columnDefs: [
			{  targets : ['_all'], className: 'text-center-td' }
		],
		order : [ [ 1, 'asc' ] ],
	});

	let leakDate = '';
	let leakSeq = '';
	let regDate = '';
	
	//왼쪽 mainTable 클릭 시
	$('#reliabilityDstryTable tbody').on('click', 'tr', function(){
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#reliabilityDstryTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		$('#tabTable2').addClass('d-none');
		$('#tabTable1').removeClass('d-none');
		$('#tableC').removeClass('d-none');
		$('#tab2Nav').removeClass('disabled');

		sideView = 'edit';
		updDesc = 0;

		$('#tableC').DataTable().destroy();		
		uiProc(true);
		$('#leakageTestUpdate').attr('disabled', false);
		
		leakDate = reliabilityDstryTable.row(this).data().testDate;
		leakSeq = reliabilityDstryTable.row(this).data().testSeq;
		regDate = reliabilityDstryTable.row(this).data().regDate;

//		$('#leakageDate').val(moment(leakDate).format("YYYY-MM-DD"));
		
		//검사 테이블
		let tableC = $('#tableC').DataTable({
			dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
					+ "<'row'<'col-sm-12'tr>>"
					+ "<'row'<'col-sm-12 col-md-5'><'col-sm-12 col-md-7'>>",
			language : lang_kor,
			paging : false,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			scrollY : "60vh",
	        scrollCollapse: true,
			async : false,
			ajax : {
				url : '<c:url value="qm/reliabilityLeakageResultReadList"/>',
				type : 'GET',
				data : {
					'menuAuth'			:	menuAuth,
					'testDate'	:	leakDate,
					'testSeq'	:	leakSeq,
					'leakDstryGubun'	:	'002',
					'regDate'	:	regDate,
				},
			},
			rowId : '',
			columns : [
				{ 
					data : '',
					render : function(data, type, row, meta) {
						return '<input type="checkbox" class="chk d-none" id="'+(meta.row+1)+'" style="width:20px; height:20px;position:relative;"/>';
					}
				},
				{ 
					data : '',
					render : function(data, type, row, meta) {
						return meta.row+1;
					}	
				},
				{ data : 'equipNm' },
				{ 
					data : 'gubunDay'
				},
				{ 
					data : 'day_0_1'
				},
				{ 
					data : 'gubunNight'
				},
				{ 
					data : 'night_0_1'
				},
			],
			columnDefs: [
				{  targets : ['_all'], className: 'text-center-td' }
			],
			order : [ [ 1, 'asc' ] ],
			drawCallback : function() {
				$('#tableC > tbody > tr').each(function(index, item) {
					var tIdx = index;
				
					if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text() == 'NG'){
						$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','background:red;');
					} else if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text() == '無'){
						$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','background:yellow;');
						$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).attr('style','background:yellow;');
					}
					if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text() == 'NG'){
						$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','background:red;');
					} else if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text() == '無') {
						$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','background:yellow;');
					$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).attr('style','background:yellow;');
					}
			
				});
			}
		});
		
		photoFileNo = leakDate+'_'+'002'+'_'+leakSeq;
		$('#photoDtlTable').DataTable().ajax.reload();

	});

	let photoDtlTable = $('#photoDtlTable').DataTable({
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
		scrollY : true,
		ajax : {
			url : '<c:url value="qm/reliabilityLeakageResultDtlList"/>',
			type : 'GET',
			async : false,
			data : {
				'leakDstryFileNo'	:	function() { return photoFileNo; },
				'admRegDate'		:	function() { return regDate; },
				'leakDstryGubun'	:	'002',
			},
		},
		rowId : '',
		columns : [ 
			{
				data : '',
				render : function(data, type, row, meta) {
					return meta.row+1;
				},
				'className' : 'text-center'
			},
			{
				data : 'fileOriginName' ,
				render : function(data, type, row, meta) {
					if (data == null) {
						var html = '<div class="form-group">';
						html += '<div class="custom-file" style="height: 150px;">';
						html += '<img alt="등록된 사진이 없습니다." id="imageFile" src="" name="imageFile1" style="width: 100%; height: 100%">';
						html += '</div>';
						html += '<div class="custom-file" style="width: 90%;">';
						html += '	<input type="file" class="custom-file-input" id="imgAdd1" name="imgAdd1""> ';
						html += '	<label id="imgName1" class="custom-file-label" for="imgAdd1"></label>';
						html += '</div>';
						html += '<div class="rightsidebar-close" style="width: 10%; padding-top: 4px;">';
						html += '	<button type="button" id="btnFileDelete" class="btn" onclick="deleteImage();">';
						html += '		<i class="mdi mdi-close"></i>';
						html += '	</button>';
						html += '</div>';
						return html;
					} else {
						
						var html = '<div class="custom-file">';
						html += '		<div class="custom-file" style="height: 150px;">';
						html += '			<img alt="등록된 사진이 없습니다." id="imageFile" src="qm/downloadDtlFile?testDate='+leakDate+'&testSeq='+leakSeq+'&admRegDate='+regDate+'&fileSeq='+row['fileSeq']+'&leakDstryGubun=002&fileOriginName='+row['fileOriginName']+'" name="imageFile1" style="width: 100%; height: 100%">';
						html += '		</div>';
						html += '		<div class="form-group" id="fileTag" name="fileTag" style="height: 20px;">';
						html += '			<a id="fpHref'+meta.row+'" href="qm/downloadDtlFile?testDate='+leakDate+'&testSeq='+leakSeq+'&fileSeq='+row['fileSeq']+'&leakDstryGubun=002&fileOriginName='+row['fileOriginName']+'"><span style="font-size: 14px;" id="fpFn"></span> <span style="font-size: 10px; vertical-align: bottom;" id="imageFileSize">'+data+'</span></a>';
						html += '		</div>';
						html += '	</div>';
						return html;
					}
				} 
			},
			{
				data : 'leakDstryDesc' ,
				render : function(data, type, row, meta) {
					if(data == null){
						return '<input type="text" class="form-control" id="leakDstryDesc'+row['fileSeq']+'" name="leakDstryDesc'+row['fileSeq']+'" style="min-width:100%"/>';
					}else{
						if(updDesc > 0){
							return '<input type="text" class="form-control" id="leakDstryDesc'+row['fileSeq']+'" name="leakDstryDesc'+row['fileSeq']+'" value="'+data+'" style="min-width:100%"/>';
							}else return data;
					}
				},
				'className' : 'text-center' 
			}, 
		], 
		buttons : [],
		columnDefs : []
		});
	
	
		//DTL테이블 상세조회
		$('#photoDtlTable tbody').on('click', 'tr', function () {
			if ($(this).hasClass('selected')) {
				$(this).removeClass('selected');
	        } else {
//				$('#photoDtlTable').DataTable().$('tr.selected').removeClass('selected');
				$(this).addClass('selected');
//				idxVal = String($('#photoTable').DataTable().row(this).data().idx);
				
	        }
			dtlSideView = 'edit';
	
			dtlFileName = $('#photoDtlTable').DataTable().row(this).data().fileName;
			leakDstryFileNo = $('#photoDtlTable').DataTable().row(this).data().leakDstryFileNo;
			fileSeq = $('#photoDtlTable').DataTable().row(this).data().fileSeq;
	
		});	

	//기본생성
	function dstryMake(){
		
		sideView = 'add';

		$('#tableD').removeClass('d-none');
		$('#tableC').addClass('d-none');
		
		$('#my-spinner').show();
		 setTimeout(function(){
			var leakageTestList = new Array();
			
			$('#tableD > tbody > tr').each(function(index, item) {
				var idxVal = index;
				var rowData = new Object();
				rowData.testDate = chooseDate2.replace(/-/g,'');
				rowData.equipNm = $('#tableD tbody tr').eq(idxVal).eq(0).find('td').eq(2).text();
				rowData.gubunDay = $('#tableD tbody tr').eq(idxVal).eq(0).find('td').eq(3).text();
				rowData.day_0_1 = $('#tableD tbody tr').eq(idxVal).eq(0).find('td').eq(4).text();
				rowData.gubunNight = $('#tableD tbody tr').eq(idxVal).eq(0).find('td').eq(5).text();
				rowData.night_0_1 = $('#tableD tbody tr').eq(idxVal).eq(0).find('td').eq(6).text();
				rowData.leakDstryGubun = '002';

				leakageTestList.push(rowData);
				});  //여기부터 시작
//				for (var pair of formData.entries()) {console.log(pair[1]); }

				//기본생성 시 저장
				$.ajax({
					url : '<c:url value="qm/reliabilityLeakageResultCreate"/>',
					type : 'POST',
					datatype : 'json',
					data : JSON.stringify(leakageTestList),
					contentType : "application/json; charset=UTF-8",
					async: false,
					success : function(res) {
						let data = res.result;
						if (data == "ok") {
							toastr.success('추가 되었습니다.');
						} else if (data == "error") {
							toastr.error(res.message);
						}
						$('#my-spinner').hide();
						$('#reliabilityDstryTable').DataTable().ajax.reload();
					}
				});
//			}); 
		}, 200); 
		 
	}

	//수정버튼
	$('#leakageTestUpdate').on('click', function(){
		if(sideView != 'edit'){
			toastr.warning("목록을 선택해주세요.");
			return false;
		}
		uiProc(false);
		$('.chk').removeClass('d-none');
		$('.checkbox_sm').removeClass('d-none');

	});

	//적용버튼
	$(document).on("click", "#applyLeakageTest", function(){
			radioVal = $('input[type=radio][name=dayNGubunList]:checked').val();
			var dd;
			var moo;
			if($('input[type=radio][name=dayNGubunList]:checked').val() == 'D'){
				dd = 3;
				moo = 4;
			} else if($('input[type=radio][name=dayNGubunList]:checked').val() == 'N'){
				dd = 5;
				moo = 6;
			}

			if(chkVal == ''){
				$('#tableC > tbody > tr').each(function(index, item) {
					var tIdx = index;
					if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(0).children().is(':checked')){
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text('OK');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).text('Y');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).attr('style','');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text('OK');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).text('Y');
							$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).attr('style','');
					}
				});
			}else if(chkVal == '001'){
				if(!($('input[type=radio][name=dayNGubunList]:checked').val() == 'A')){
					$('#tableC > tbody > tr').each(function(index, item) {
						var tIdx = index;
						if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(0).children().is(':checked')){
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).text() == 'OK'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).text('NG');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).attr('style','background:red;');
							} else {
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).text('OK');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).attr('style','');
							}
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(moo).text() == '無'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(moo).text('Y');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(moo).attr('style','');
							}
						}
					});
				} else {	//전체
					$('#tableC > tbody > tr').each(function(index, item) {
						var tIdx = index;
						if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(0).children().is(':checked')){
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text() == 'OK'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text('NG');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','background:red;');
							} else {
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text('OK');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','');
							}
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).text() == '無'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).text('Y');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).attr('style','');
							}
							
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text() == 'OK'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text('NG');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','background:red;');
							} else {
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text('OK');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','');
							}
							if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).text() == '無'){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).text('Y');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).attr('style','');
							}
						}
					});
				}
			} else if(chkVal == '002') {
				if(!($('input[type=radio][name=dayNGubunList]:checked').val() == 'A')){
					$('#tableC > tbody > tr').each(function(index, item) {
						var tIdx = index;
						if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(0).children().is(':checked')){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(moo).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(dd).attr('style','background:yellow;');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(moo).attr('style','background:yellow;');
						}
					});
				} else {	//전체
					$('#tableC > tbody > tr').each(function(index, item) {
						var tIdx = index;
						if($('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(0).children().is(':checked')){
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).text('無');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(3).attr('style','background:yellow;');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(4).attr('style','background:yellow;');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(5).attr('style','background:yellow;');
								$('#tableC tbody tr').eq(tIdx).eq(0).find('td').eq(6).attr('style','background:yellow;');
						}
					});
				} 
	
			}
		/* 	$('#tableC > tbody > tr').each(function(index, item) {
				
			}); */
	});

	
	//저장버튼 클릭 시
	$('#leakageTestCreate').on('click', function(){

		$('#my-spinner').show();

		setTimeout(function(){
			var leakageTestList = new Array();
			
			$('#tableC > tbody > tr').each(function(index, item) {
				var idxVal = index;
				var rowData = new Object();
				rowData.testDate = leakDate;
				rowData.equipNm = $('#tableC tbody tr').eq(idxVal).eq(0).find('td').eq(2).text();
				rowData.gubunDay = $('#tableC tbody tr').eq(idxVal).eq(0).find('td').eq(3).text();
				rowData.day_0_1 = $('#tableC tbody tr').eq(idxVal).eq(0).find('td').eq(4).text();
				rowData.gubunNight = $('#tableC tbody tr').eq(idxVal).eq(0).find('td').eq(5).text();
				rowData.night_0_1 = $('#tableC tbody tr').eq(idxVal).eq(0).find('td').eq(6).text();
				rowData.testSeq = leakSeq;
				rowData.leakDstryGubun = '002';
				rowData.regDate = regDate;
				
				leakageTestList.push(rowData);
				});  //여기부터 시작
//				for (var pair of formData.entries()) {console.log(pair[1]); }

				//기본생성 시 저장
				$.ajax({
					url : '<c:url value="qm/reliabilityLeakageResultUpdate"/>',
					type : 'POST',
					datatype : 'json',
					data : JSON.stringify(leakageTestList),
					contentType : "application/json; charset=UTF-8",
					async: false,
					success : function(res) {
						let data = res.result;
						if (data == "ok") {
							toastr.success('수정 되었습니다.');
						} else if (data == "error") {
							toastr.error(res.message);
						}

//						$('#leakageDate').val('');
						$('input[type=radio][name=dayNGubunList]').prop('checked',false);
						$('input[type=checkbox]').prop('checked',false);
						$('.chk').addClass('d-none');
						$('#checkAll').addClass('d-none');
						uiProc(true);
						
						$('#my-spinner').hide();
						$('#reliabilityDstryTable').DataTable().ajax.reload();
					}
				});
//			}); 
		}, 200); 
	});
	
	
// 	$('#btnBlankAdd').on('click', function(){
//		$('#leakageDstryFileModal').modal('show');
// 		$('#photoDtlTable').DataTable().row.add({}).draw(false);
// 	});

	$('#btnDescEdit').on('click', function(){
		updDesc = 1;
		$('#photoDtlTable').DataTable().ajax.reload(false);
	});
	
	//Dtl 비고 저장
	$('#btnDtlSave').on('click', function(){
		var cnt = 0;
		$('#photoDtlTable > tbody > tr').each(function(index, item){
			var dtlIndex = index;
//				  console.log($('#photoDtlTable').DataTable().row(index).data());

			if($('#photoDtlTable tbody tr').eq(dtlIndex).eq(0).find('td').eq(2).find('input').val() != '' && $('#photoDtlTable tbody tr').eq(dtlIndex).eq(0).find('td').eq(2).find('input').val() != undefined){
				var leakDstryFileNo1 = $('#photoDtlTable').DataTable().row(index).data().leakDstryFileNo;
				var fileSeq1 = $('#photoDtlTable').DataTable().row(index).data().fileSeq;
				var leakDstryDesc1 = $('#leakDstryDesc'+fileSeq1).val();
				
				//Dtl 비고 업데이트
					$.ajax({
						url : '<c:url value="qm/reliabilityLeakageDtlResultUpdate"/>',
						type : 'POST',
						data : { 
							'leakDstryFileNo'	:	leakDstryFileNo1,
							'admRegDate'		:	regDate,
							'fileSeq'			:	fileSeq1,
							'leakDstryGubun'	:	'002',
							'leakDstryDesc'		:	leakDstryDesc1
						},
						async: false,
						success : function(res) {
							let data = res.result;
							if (data == "ok") {
								if(cnt == 0){
									toastr.success('수정 되었습니다.');
									cnt++;
								}
							} else if (data == "error") {
								toastr.error(res.message);
							}
							setTimeout(function(){
								$('#tab2Nav').trigger('click');
								$('#photoDtlTable').DataTable().ajax.reload();
							},150);
							updDesc = 0;
						}
					});
			}
		});
	});

	//class로 값을 찾아서 이미지를 넣어준다. & 이미지 등록
	$(document).on('change','.custom-file-input',function(e){
		e.preventDefault();

		$('#my-spinner').show();

		var file = $(this).val();
		var fileLength = $(this)[0].files.length -1;
		
		setTimeout(function() {
			
			var file = $('#btnMultiUpload').val();
			var fileLength = $('#btnMultiUpload')[0].files.length -1;
			
			for(var i = 0; i < $('#btnMultiUpload')[0].files.length; i++){
				if (!checkImgType($('#btnMultiUpload')[0].files[i].name)) {
					toastr.warning("이미지파일만 선택해 주세요.");
					$(this).val('');
					$('#my-spinner').hide();
		       		return false;
				}
			}
		
			var formData = new FormData();
			formData.append("testDate", leakDate);
			formData.append("testSeq", leakSeq);
			formData.append("regDate", regDate);
			formData.append("leakDstryGubun", '002');

			for(var i = 0; i < $('#btnMultiUpload')[0].files.length; i ++){	
				formData.append('testPhoto', $('#btnMultiUpload')[0].files[i]);
			}

//	 		for (var pair of formData.entries()) {console.log(pair[1]); }

			//Update
			$.ajax({
				url : '<c:url value="/qm/reliabilityLeakageDstryPhotoCreate"/>',
				data : formData,
				dataType:'json',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(data) {
					if (data.result == "ok") {
						toastr.success('등록되었습니다.');
						$('#photoDtlTable').DataTable().ajax.reload();
						$('#btnMultiUpload').val('');
					} else if (data.result == "extensionError") {
						toastr.warning(res.message);
					}else{
						toastr.error('이미지 등록에 실패했습니다');
					}
				},
				complete : function(){
					$('#my-spinner').hide();
				},
			});
			//Update
		}, 0);
		
	});

	// 파일 검사 (이미지 파일만)
	var checkImgType = function(filePath) {
	    var fileFormat = filePath.split(".");
	    if ((fileFormat.indexOf("png") > -1) || (fileFormat.indexOf("jpg") > -1) || (fileFormat.indexOf("jpeg") > -1) || (fileFormat.indexOf("tif") > -1) || (fileFormat.indexOf("tiff") > -1) || (fileFormat.indexOf("raw") > -1) || (fileFormat.indexOf("bmp") > -1) || (fileFormat.indexOf("rle") > -1) || (fileFormat.indexOf("heic") > -1)) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	//삭제 버튼 클릭 시
	$('#btnDtlDel').on('click', function(){
		if(dtlSideView != 'edit' && !$('#photoDtlTable').DataTable().$('tr').is('.selected')) {
			toastr.warning("삭제할 사진을 선택해주세요");
			return false;
		}

		var checkCount = 0;
		var dtlDelList = new Array();

		for(var i = 0; i < $('#photoDtlTable').DataTable().rows('.selected').data().length; i++){
			var rowData = new Object();

			rowData.fileName = $('#photoDtlTable').DataTable().rows('.selected').data()[i].fileName;
			rowData.leakDstryFileNo = $('#photoDtlTable').DataTable().rows('.selected').data()[i].leakDstryFileNo;
			rowData.admRegDate = regDate;
			rowData.fileSeq = $('#photoDtlTable').DataTable().rows('.selected').data()[i].fileSeq;

			dtlDelList.push(rowData);
		}

		//Delete
		$.ajax({
			url : '<c:url value="qm/reliabilityLeakageDtlResultDelete"/>',
			datatype : 'json',
			data : JSON.stringify(dtlDelList),
			contentType : "application/json; charset=UTF-8",
			type : 'POST',
			success : function(data) {
				if (data.result == "ok") {
					toastr.success('삭제되었습니다.');
					$('#photoDtlTable').DataTable().ajax.reload(false);
					
				} else if (data.result == "extensionError") {
					toastr.warning(res.message);
				}else{
					toastr.error(res.message);
				}
			}
		});
		//Delete
		
	});

	var html1 = '<div class="row">';
		html1 += '<label class="input-label-sm ml-1">생산일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '<label class="input-label-sm ml-2">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '<button type="button" class="btn btn-primary ml-2 mr-6" id="btnRetv">조회</button>';
		html1 += '<button type="button" class="btn btn-danger ml-6" id="btnDel">삭제</button>';
		html1 += '</div>';
	
	$('#reliabilityDstryTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);

	//조회 클릭 시
	$('#btnRetv').on('click', function() {
		
		let dateFrom 	= new Date($('#chooseDateFrom').val());
		let dateTo 		= new Date($('#chooseDateTo').val());
		let dateDiff 	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}

  		chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		userNumber	= $('#preWorkCharger').val();

  		uiProc(false);

  		$('#my-spinner').show();
  		
  		reliabilityDstryTableIdx ='';
		$('#photoTable tbody').empty();
		countPhoto = 0;
  		$('#reliabilityDstryTable').DataTable().ajax.reload();
	});
	
	$('input[type=checkbox][name=okNgVal]').on('change', function() {
		if(!$('input[type=radio][name=dayNGubunList]').is(':checked')){
			toastr.warning("주야간구분을 선택해주세요.");
			$('input[type=checkbox][name=okNgVal]').prop('checked',false);
			return false;
		}
		if($('input[type=checkbox][name=okNgVal]').is(':checked')){
			chkVal = $('input[type=checkbox][name=okNgVal]:checked').val()
			$('input[type=checkbox][name=makeNothing]').prop('checked',false);
		}
		if(!($('input[type=checkbox][name=okNgVal]').is(':checked') || $('input[type=checkbox][name=makeNothing]').is(':checked'))){
			chkVal = '';
		}
	});
	$('input[type=checkbox][name=makeNothing]').on('change', function() {
		if(!$('input[type=radio][name=dayNGubunList]').is(':checked')){
			toastr.warning("주야간구분을 선택해주세요.");
			$('input[type=checkbox][name=makeNothing]').prop('checked',false);
			return false;
		}
		if($('input[type=checkbox][name=makeNothing]').is(':checked')){
			chkVal = $('input[type=checkbox][name=makeNothing]:checked').val()
			$('input[type=checkbox][name=okNgVal]').prop('checked',false);
		}
		if(!($('input[type=checkbox][name=okNgVal]').is(':checked') || $('input[type=checkbox][name=makeNothing]').is(':checked'))){
			chkVal = '';
		}
	});
	
	//왼쪽 테이블 삭제 버튼
	$('#btnDel').on('click', function(){
		if($('#reliabilityDstryTable').DataTable().$('tr').is('.selected')){
			$('#deleteModal').modal('show');
		} else toastr.warning('삭제할 데이터를 선택해주세요.');
	});

	//삭제 확인 모달 삭제 클릭 시
	$('#btnDeleteConfirm').on('click', function(){
		$('#my-spinner').show();
		//Delete
		$.ajax({
			url : '<c:url value="qm/reliabilityLeakageResultDelete"/>',
			data : {
				'testDate'	:	leakDate,
				'testSeq'	:	leakSeq,
				'regDate'	:	regDate,
				'leakDstryFileNo'	:	photoFileNo,
				'leakDstryGubun' : '002',
			},
			type : 'POST',
			success : function(data) {
				if (data.result == "ok") {
					toastr.success('삭제되었습니다.');
					$('#leakageTestUpdate').attr('disabled',true);
					$('#reliabilityDstryTable').DataTable().ajax.reload();
					$('#photoDtlTable').DataTable().ajax.reload();
					$('#tab2Nav').addClass('disabled');
					
				} else if (data.result == "extensionError") {
					toastr.warning(res.message);
				}else{
					toastr.error(res.message);
				}
			},
			complete : function(){
				$('#deleteModal').modal('hide');
				$('#my-spinner').hide();
			}
		});
	});

	//사진 탭
	$('#tab1Nav').on('click', function() {
		
		$('#tab2').addClass('d-none');
		$('#tab1').removeClass('d-none');

		setTimeout(function(){
			$('#tableC').DataTable().ajax.reload();
		},150);
	});

	//사진 탭
	$('#tab2Nav').on('click', function() {
		
		$('#tab1').addClass('d-none');
		$('#tab2').removeClass('d-none');

		setTimeout(function(){
			$('#photoDtlTable').DataTable().ajax.reload();
		},150);
	});

	//체크박스 전체 선택
	$('#checkAll').on('click', function(){
    	$('#tableC tbody tr').each(function(index, item){
			if($("#checkAll").prop("checked")) {
				$('.chk').prop("checked",true); 
	        } else { 
	        	$('.chk').prop("checked",false); 
	        }
 		});
    });

	//체크박스 해제
	$('.chk').on('click',function(){
		if($('input[class=chk]:checked').length == $('.chk').length){
			$('#checkAll').prop('checked', true);
		}else{
			$('#checkAll').prop('checked',false);
		}
	});

	function uiProc(flag){
		$('input[type=radio][name=dayNGubunList]').attr('disabled',flag);
		$('input[type=checkbox][name=okNgVal]').attr('disabled',flag);
		$('input[type=checkbox][name=makeNothing]').attr('disabled',flag);
		$('#leakageTestCreate').attr('disabled',flag);
		$('#applyLeakageTest').attr('disabled',flag);
		$('#leakageTestUpdate').attr('disabled', flag);
	}
	

</script>

</body>
</html>
