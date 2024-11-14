<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">

	<!-- 삭제처리 -->
	<form id="checkModalForm" enctype="multipart/form-data">
	<div class="modal fade bs-example-modal-lg shadow-lg" id="deleteReliabilityModal" tabindex="-1" role="dialog" aria-labelledby="deleteReliabilityModalLabel" aria-hidden="true" data-keyboard="false">
	    <div class="modal-dialog modal-lg" role="document" style="overflow-y: max-height:85%;  margin-top: 3%;">
	        <div class="modal-content" style="width: 60%; margin-left: 90%; margin-top: 45%;">
	            <div class="modal-header">
	           		<h5 class="modal-title" id="deleteReliabilityModalLabel">신뢰성 결과 삭제 확인</h5>
	            </div>
	            <div class="modal-body">
	            	<br>
			    	<h6>입력하던 정보가 있습니다. 계속 진행하시겠습니까?</h6>
			    	<p id="deleteReliabilityModalAfter">123</p>
			    </div>
	            <div class="modal-footer" id="divSudel">
<!-- 	            	<button type="button" class="btn btn btn-danger btnCheckConfirm" style="width: 16%;" id="btnModelDel">삭제</button> -->
<!-- 	            	<button type="button" class="btn btn-secondary" style="width: 16%;" data-dismiss="modal">닫기</button> -->
	            </div>
	        </div>
	    </div>
	</div>
	</form>
	<!--//삭제처리 -->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">신뢰성 결과</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 50%; padding-bottom:0px;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="reliabilityTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>LotNo</th>
								</tr>
							</thead>
						</table>
					</div><!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
			
			 <div class="right-list right-sidebar" id="myrSidenav" style="width:49%; padding-top:0px; padding-bottom:0px;">
				 <div class="card">
				 	<div class="card-body col-sm-12" style="padding-bottom:8px;">
				 		<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item">
									<a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">실링</a>
								</li>
								<li class="nav-item">
									<a class="nav-link disabled" id="tab2Nav" data-toggle="tab" href="#tab2">침투액</a>
								</li>
								<li class="nav-item">
									<a class="nav-link disabled" id="tab3Nav" data-toggle="tab" href="#tab3">파괴</a>
								</li>
								<li>
									<div class="rightsidebar-close">
							 			<a href="javascript:void(0)" id="rightCardClose" class="closebtn float-right" onclick="closerNav()">
							 				<i class="mdi mdi-close" style="margin-left: 2300%;"></i>
							 			</a>
									</div>
								</li>
							</ul>
							
						
						
						</div>
						
					</div>
					
					
					<div class="card-body col-sm-12 p-1 mb-2 mt-2">
						<button type="button" class="btn btn-primary float-left" id="btnEdit">수정</button>
						<button type="button" class="btn btn-danger float-right mr-1" id="" onclick="tapDelete()">삭제</button>
						<button type="button" class="btn btn-primary float-right mr-1" id="" onclick="lineSelected()">추가</button>
					</div>
					
					<!-- 실링 -->
					<div class="tab-pane fade active show" id="tab1">
						<form id="form">
							<div class="table-responsive" style="height: 28vh;">
								<table class="table table-bordered" id="tableA">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th>순번</th>
											<th>입력일자</th>
											<th>실효1번</th>
											<th>실효2번</th>
											<th>수치</th>
											<th>OK / NG</th>
											<th>비고</th>
										</tr>
									</thead>
								</table>
							</div>
						</form>
					</div>
					<!-- 실링 끝 -->
					
					<!-- 침투액 -->
					<div class="tab-pane fade d-none" id="tab2">
						<form id="form2" enctype="multipart/form-data">
							<div class="table-responsive" style="height: 28vh;">
								<table class="table table-bordered" id="tableB">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th>순번</th>
											<th>입력일자</th>
											<th>실효1번</th>
											<th>실효2번</th>
											<th>수치</th>
											<th>OK/NG</th>
											<th>비고</th>
										</tr>
									</thead>
								</table>
							</div>
						</form>
					</div>
					<!-- 침투액 끝 -->
					
					<!-- 파괴 -->
					<div class="tab-pane fade d-none" id="tab3">
						<form id="form3" enctype="multipart/form-data">
							<div class="table-responsive" style="height: 28vh;">
								<table class="table table-bordered" id="tableC">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th>순번</th>
											<th>입력일자</th>
											<th>실효1번</th>
											<th>실효2번</th>
											<th>수치</th>
											<th>OK/NG</th>
											<th>비고</th>
										</tr>
									</thead>
								</table>
							</div>
						</form>
					</div>
					<!-- 파괴 끝 -->
					
					<div>
						<button type="button" class="btn btn-primary float-right mb-3 mt-1 d-none" id="btnSave">저장</button>
					</div>
					
					<!-- 사진 관련 테이블 -->
					<div>
						<div class="card-body col-sm-12 p-1 mb-2 mt-2">
	<!-- 						<button type="button" class="btn btn-success float-left mr-1" id="" onclick="">도움말</button> -->
							<button type="button" class="btn btn-danger float-right mr-1 d-none" id="btnPhotoAllDel">전체 사진 삭제</button>
							<button type="button" class="btn btn-danger float-right mr-1" id="btnBlankDel">공백 삭제</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="" onclick="photoSelect()">사진 추가</button>
						</div>
						
						<!-- 사진 테이블 -->
						<form id="photoForm" enctype="multipart/form-data">
							<div class="table-responsive" style="/*height: 33vh; border-bottom: double 4px black;*/">
								<table class="table table-bordered" id="photoTable">
									<thead>
										<tr>
											<th colspan="2">실링 사진</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
						</form>
						<!-- 사진 테이블 끝-->
					</div>
					<!-- 사진 관련 테이블 끝-->
				</div>
			</div><!-- /.right-list -->
		</div>
	</div><!-- /.row -->
</div><!-- / #main  -->

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

	let menuAuth = 'qmsc0150';
	let currentHref = 'qmsc0150';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","신뢰성 결과");

	//공통코드 처리 시작
	var photoCountCode = new Array();
	<c:forEach items="${photoCount}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdAbbr = "${info.baseCdAbbr}";
	photoCountCode.push(json);
	</c:forEach>
	//공통코드 처리 시작
	
	var serverDateFrom = "${serverDateFrom}";
	var chooseDate1 = "${serverDateFrom}";
	var chooseDate2 = "${serverDate}";

	/*
		reliabilityTable = 왼쪽 mainTable
		tableA = 실링 테이블
		tableB = 침투액 테이블
		tableC = 파괴 테이블
	*/

	var lotNo ='';					//자재투입LOT번호
	var trustGubun = '001';			//구분 값
	var trustSeq ='';				//A, B, C Table 시퀀스
	var countPhoto = 0;				//사진관련 테이블 개수
	var trustPhotoSeq = '';			//사진 관련 시퀀스
	var reliabilityTableIdx = ''; 	//테이블 아이디 값
	var temp = 0;					//추가 버튼 클릭 시 순번 Check
	

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
	let reliabilityTable = $('#reliabilityTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/reliabilityResultList"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
            },
        },
        rowId: 'lotNo',
        columns: [
        	{ data: 'lotNo'	},
        ],
        buttons: ['copy', 'excel', 'print'],
	});
	
	reliabilityTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});

	//왼쪽 mainTable 클릭 시
	$('#reliabilityTable tbody').on('click', 'tr', function(){
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#reliabilityTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		$('#btnSave').addClass('d-none');

		lotNo = reliabilityTable.row(this).data().lotNo;

		reliabilityTableIdx = $(this).attr('id');

		tableA.clear().draw();
		tableB.clear().draw();
		tableC.clear().draw();
		$('#photoTable tbody').empty();

		countPhoto = 0;

		$('#tableA').DataTable().ajax.reload(function(){
			if($('#tableA tbody tr').text() == '데이터가 없습니다.'){
				$('#btnEdit').attr('disabled', true);
			}else{
				$('#btnEdit').attr('disabled', false);
			}
			$('#tableA tbody').find('input').attr('disabled', true);
		});

		$('#tableB').DataTable().ajax.reload(function(){
			if($('#tableB tbody tr').text() == '데이터가 없습니다.'){
				$('#btnEdit').attr('disabled', true);
			}else{
				$('#btnEdit').attr('disabled', false);
			}
			$('#tableB tbody').find('input').attr('disabled', true);
		});

		$('#tableC').DataTable().ajax.reload(function(){
			if($('#tableC tbody tr').text() == '데이터가 없습니다.'){
				$('#btnEdit').attr('disabled', true);
			}else{
				$('#btnEdit').attr('disabled', false);
			}
			$('#tableC tbody').find('input').attr('disabled', true);
		});

		$('#tab2Nav').removeClass('disabled');
		$('#tab3Nav').removeClass('disabled');

		//선택 행 사진 데이터 불러오기
		$.ajax({
			url : '<c:url value="/qm/reliabilityPhotoSelectList"/>',
			type : 'GET',
			data : {
				'lotNo'			:	function(){ return lotNo;		},
				'trustGubun'	:	function(){ return trustGubun;	},
			},
			async: false,
			success : function(res) {
				let imageFile 			= res.imageFile;			//Base64
				let imageFileNm 		= res.imageFileNm;			//파일명
				let imageChangeFileNm 	= res.imageChangeFileNm;	//바뀐 파일명
				let imageFileSize		= res.imageFileSize;		//파일 사이즈
				let photoSize	 		= res.photoSize;			//데이터 갯수
				let trustPhotoSeq		= res.trustPhotoSeq;		//사진관련 시퀀스
				
				for(var i=1; i<=photoSize; i++){
					photoSelect(i, trustPhotoSeq[i-1]);

					if(imageFileNm != null){
						$('#imageFileNm_'+i).text(imageFileNm[(i-1)]);
						$('#fpFn'+i).text(imageFileNm[(i-1)]);
						
						$('#imageFileSize'+i).text( imageFileSize[(i-1)]);

						$('#fpHref'+i).attr('href','qm/downloadFile?lotNo='+lotNo
																			+'&trustGubun='+trustGubun
																			+'&trustPhotoSeq='+trustPhotoSeq[i-1]
																			+'&imageFileNm='+imageFileNm[(i-1)]
																			+'&imageChangeFileNm='+imageChangeFileNm[(i-1)]);
					}

					if($('#fpFn'+i).text() != ''){
						$('#imageFile'+i).attr('src','qm/downloadFile?lotNo='+lotNo
																			+'&trustGubun='+trustGubun
																			+'&trustPhotoSeq='+trustPhotoSeq[i-1]
																			+'&imageFileNm='+imageFileNm[(i-1)]
																			+'&imageChangeFileNm='+imageChangeFileNm[(i-1)]);

						$('#fileSearch'+i).addClass('d-none');		//fileInputBox(div)
						$('#fileTag'+i).removeClass('d-none');		//하이퍼링크 값(div)
					}
				}
			}
		});
		tableCheck();
	});

	//실링 테이블
	let tableA = $('#tableA').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="/qm/reliabilityResultSelectList"/>',
			type : 'GET',
			data : {
				'lotNo'			:	function(){ return lotNo;		},
				'trustGubun'	:	function(){ return trustGubun;	},
			},
		},
		rowId : 'partCd',
		columns : [
			{ name : 'num',
				render : function(data, type, row, meta) {
					return '<label class="temp"disabled >'+(meta.row+1)+'</label></td>';
				}
			},
			{ data : 'testDate',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="'+row['trustSeq']+'" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment(data).format('YYYY-MM-DD')+'" disabled>';
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment().format('YYYY-MM-DD')+'">';
						return html1;
					}
				}	
			},
			{ data : 'data1',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data1" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data1" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data2',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data2" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data2" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data3',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data3" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data3" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data4',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" id="data4Val1_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						if(data == '1'){
							html1+='<input type="radio" class="mr-3" name="data4_1_'+meta.row+'" disabled checked value="1">';
							html1+='<input type="radio" class="" name="data4_1_'+meta.row+'" disabled value="2">';
						}else if(data == '2'){
							html1+='<input type="radio" class="mr-3" name="data4_1_'+meta.row+'" disabled value="1">';
							html1+='<input type="radio" class="" name="data4_1_'+meta.row+'" disabled checked value="2">';
						}
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" id="data4Val1_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						html1+='<input type="radio" class="mr-3" name="data4_1_'+meta.row+'" value="1">';
						html1+='<input type="radio" class="" name="data4_1_'+meta.row+'" value="2">';
						return html1;
					}
				}	
			},
			{ data : 'trustDesc',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="">';
						return html1;
					}
				}	
			},
		],
		columnDefs: [
			{  targets : ['_all'], className: 'text-center-td' }
		],
		order : [ [ 1, 'asc' ] ],
	});

	//실링 테이블 클릭 시
	$('#tableA tbody').on('click', 'tr', function(){
		
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#tableA').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		trustSeq = tableA.row(this).data().trustSeq;	// 실링 시퀀스
// 		console.log("trustSeq_A : "+trustSeq);
	});


	//침투액 테이블
	let tableB = $('#tableB').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="/qm/reliabilityResultSelectList"/>',
			type : 'GET',
			data : {
				'lotNo'			:	function(){ return lotNo;		},
				'trustGubun'	:	function(){ return trustGubun;	},
			},
		},
		rowId : 'partCd',
		columns : [
			{ name : 'num',
				render : function(data, type, row, meta) {
					return '<label class="temp"disabled >'+(meta.row+1)+'</label></td>';
				}
			},
			{ data : 'testDate',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="'+row['trustSeq']+'" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment(data).format('YYYY-MM-DD')+'" disabled>';
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment().format('YYYY-MM-DD')+'">';
						return html1;
					}
				}	
			},
			{ data : 'data1',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data1" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data1" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data2',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data2" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data2" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data3',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data3" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data3" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data4',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" id="data4Val2_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						if(data == '1'){
							html1+='<input type="radio" class="mr-3" name="data4_2_'+meta.row+'" disabled checked value="1">';
							html1+='<input type="radio" class="" name="data4_2_'+meta.row+'" disabled value="2">';
						}else if(data == '2'){
							html1+='<input type="radio" class="mr-3" name="data4_2_'+meta.row+'" disabled value="1">';
							html1+='<input type="radio" class="" name="data4_2_'+meta.row+'" disabled checked value="2">';
						}
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" id="data4Val2_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						html1+='<input type="radio" class="mr-3" name="data4_2_'+meta.row+'" value="1">';
						html1+='<input type="radio" class="" name="data4_2_'+meta.row+'" value="2">';
						return html1;
					}
				}	
			},
			{ data : 'trustDesc',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="">';
						return html1;
					}
				}	
			},
		],
		columnDefs: [
			{  targets : ['_all'], className: 'text-center-td' }
		],
		order : [ [ 1, 'asc' ] ],
	});
	//침투액 테이블 끝
	
	//침투액 테이블 클릭 시
	$('#tableB tbody').on('click', 'tr', function(){
		
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#tableB').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		trustSeq = tableB.row(this).data().trustSeq;	// 침투액 시퀀스
// 		console.log("trustSeq_B : "+trustSeq);	
	});
	//침투액 테이블 클릭 시 끝
	
	//파괴 테이블
	let tableC = $('#tableC').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="/qm/reliabilityResultSelectList"/>',
			type : 'GET',
			data : {
				'lotNo'			:	function(){ return lotNo;		},
				'trustGubun'	:	function(){ return trustGubun;	},
			},
		},
		rowId : 'partCd',
		columns : [
			{ name : 'num',
				render : function(data, type, row, meta) {
					return '<label class="temp"disabled >'+(meta.row+1)+'</label></td>';
				}
			},
			{ data : 'testDate',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="'+row['trustSeq']+'" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment(data).format('YYYY-MM-DD')+'" disabled>';
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" name="trustSeq" value="" disabled>';
						html1+='<input type="date" class="form-control text-center" name="testDate" value="'+moment().format('YYYY-MM-DD')+'">';
						return html1;
					}
				}	
			},
			{ data : 'data1',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data1" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data1" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data2',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data2" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data2" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data3',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="data3" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="data3" value="">';
						return html1;
					}
				}	
			},
			{ data : 'data4',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="hidden" class="form-control text-center" id="data4Val3_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						if(data == '1'){
							html1+='<input type="radio" class="mr-3" name="data4_3_'+meta.row+'" disabled checked value="1">';
							html1+='<input type="radio" class="" name="data4_3_'+meta.row+'" disabled value="2">';
						}else if(data == '2'){
							html1+='<input type="radio" class="mr-3" name="data4_3_'+meta.row+'" disabled value="1">';
							html1+='<input type="radio" class="" name="data4_3_'+meta.row+'" disabled checked value="2">';
						}
						return html1;
					}else {
						html1+='<input type="hidden" class="form-control text-center" id="data4Val3_'+meta.row+'" name="data4Val" value="">';
						html1+='<label>OK　NG</label><br>';
						html1+='<input type="radio" class="mr-3" name="data4_3_'+meta.row+'" value="1">';
						html1+='<input type="radio" class="" name="data4_3_'+meta.row+'" value="2">';
						return html1;
					}
				}	
			},
			{ data : 'trustDesc',
				render : function(data, type, row, meta) {
					var html1='';
					if(data!=''){
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="'+data+'" disabled>';
						return html1;
					}else {
						html1+='<input type="text" class="form-control text-center" name="trustDesc" value="">';
						return html1;
					}
				}	
			},
		],
		columnDefs: [
			{  targets : ['_all'], className: 'text-center-td' }
		],
		order : [ [ 1, 'asc' ] ],
	});
	//파괴 테이블 끝

	//파괴 테이블 클릭 시
	$('#tableC tbody').on('click', 'tr', function(){
		
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#tableC').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		trustSeq = tableC.row(this).data().trustSeq;	//	파괴 시퀀스
// 		console.log("trustSeq_C : "+trustSeq);
	});
	//파괴 테이블 클릭 시 끝
	

	//저장 버튼클릭 시
	$('#btnSave').on('click', function(){
		
		var checkYn ='Y';
		
        if(trustGubun == '001'){
			for(var i=0; i<$('#tableA tbody tr').length; i++){
				//checked 된 라디오버튼 값
				$("input[name=data4_1_"+i+"]:checked").each(function(){
					$('#data4Val1_'+i+'').val($(this).val());
				});
			}

			$('#tableA tbody tr').each(function(){
				//조건_A
				if(!$.trim($(this).find('td').find('input[name=testDate]').val())){
					toastr.warning('날짜를 선택해주세요.');
					$(this).find('td').find('input[name=testDate]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data1]').val())){
					toastr.warning('실효 1번을 입력해주세요.');
					$(this).find('td').find('input[name=data1]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data2]').val())){
					toastr.warning('실효 2번을 입력해주세요.');
					$(this).find('td').find('input[name=data2]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('수치를 입력해주세요.');
					$(this).find('td').find('input[name=data3]').focus();
					 checkYn ='N';
					return false;
				}

				/* if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('OK/NG를 선택해주세요.');
					$(this).find('td').find('button[name=data3]').focus();
					 checkYn ='N';
					return false;
				} */
			});
			if(checkYn !='N'){
				for(var i=0; i<$('#tableA tbody tr').length; i++){
					if($('input[name=data4_1_'+i+']').is(':checked') == false){
						toastr.warning('OK/NG를 선택해주세요.');
						checkYn ='N';
						return false;
					}
				}
			}
			//조건_A 끝
			
			var array = new Array();
			
			//저장처리_A
			if(checkYn !='N'){
				$('#tableA tbody tr').each(function(){
		 			$('#my-spinner').show();
					var obj = new Object();
					
					obj.lotNo		= lotNo;
					obj.trustGubun 	= trustGubun;
					obj.trustSeq 	= $(this).find('td').find('input[name=trustSeq]').val();	//시퀀스(히든 값)
					obj.testDate 	= $(this).find('td').find('input[name=testDate]').val();	//입력일자
					obj.data1 		= $(this).find('td').find('input[name=data1]').val();		//실효1번 .replace(/,/g,'')
					obj.data2 		= $(this).find('td').find('input[name=data2]').val();		//실효2번
					obj.data3 		= $(this).find('td').find('input[name=data3]').val();		//수치
					obj.data4 		= $(this).find('td').find('input[name=data4Val]').val();	//OK/NG
					obj.trustDesc	= $(this).find('td').find('input[name=trustDesc]').val();	//비고
					
					array.push(obj);
				});
// 				console.log(array);
				var data = JSON.stringify(array);
			}//저장처리_A 끝
		}else if(trustGubun =='002'){
			for(var i=0; i<$('#tableB tbody tr').length; i++){
				//checked 된 라디오버튼 값
				$("input[name=data4_2_"+i+"]:checked").each(function(){
					$('#data4Val2_'+i+'').val($(this).val());
				});
			}

			var checkYn ='Y';
			$('#tableB tbody tr').each(function(){
				//조건_B
				if(!$.trim($(this).find('td').find('input[name=testDate]').val())){
					toastr.warning('날짜를 선택해주세요.');
					$(this).find('td').find('button[name=testDate]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data1]').val())){
					toastr.warning('실효 1번을 입력해주세요.');
					$(this).find('td').find('input[name=data1]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data2]').val())){
					toastr.warning('실효 2번을 입력해주세요.');
					$(this).find('td').find('input[name=data2]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('수치를 입력해주세요.');
					$(this).find('td').find('input[name=data3]').focus();
					 checkYn ='N';
					return false;
				}

				/* if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('OK/NG를 선택해주세요.');
					$(this).find('td').find('button[name=data3]').focus();
					 checkYn ='N';
					return false;
				} */
			});
			if(checkYn !='N'){
				for(var i=0; i<$('#tableB tbody tr').length; i++){
					if($('input[name=data4_2_'+i+']').is(':checked') == false){
						toastr.warning('OK/NG를 선택해주세요.');
						checkYn ='N';
						return false;
					}
				}
			}
			//조건_B 끝

			var array = new Array();
			
			//저장처리_B
			if(checkYn !='N'){
				$('#tableB tbody tr').each(function(){
		 			$('#my-spinner').show();
					var obj = new Object();
					
					obj.lotNo		= lotNo;
					obj.trustGubun 	= trustGubun;
					obj.trustSeq 	= $(this).find('td').find('input[name=trustSeq]').val();	//시퀀스(히든 값)
					obj.testDate 	= $(this).find('td').find('input[name=testDate]').val();	//입력일자
					obj.data1 		= $(this).find('td').find('input[name=data1]').val();		//실효1번 .replace(/,/g,'')
					obj.data2 		= $(this).find('td').find('input[name=data2]').val();		//실효2번
					obj.data3 		= $(this).find('td').find('input[name=data3]').val();		//수치
					obj.data4 		= $(this).find('td').find('input[name=data4Val]').val();	//OK/NG
					obj.trustDesc	= $(this).find('td').find('input[name=trustDesc]').val();	//비고
					
					array.push(obj);
				});
// 				console.log(array);
				var data = JSON.stringify(array);
			}//저장처리_B
			
		}else{
			for(var i=0; i<$('#tableC tbody tr').length; i++){
				//checked 된 라디오버튼 값
				$("input[name=data4_3_"+i+"]:checked").each(function(){
					$('#data4Val3_'+i+'').val($(this).val());
				});
			}

			$('#tableC tbody tr').each(function(){
				//조건_C
				if(!$.trim($(this).find('td').find('input[name=testDate]').val())){
					toastr.warning('날짜를 선택해주세요.');
					$(this).find('td').find('input[name=testDate]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data1]').val())){
					toastr.warning('실효 1번을 입력해주세요.');
					$(this).find('td').find('input[name=data1]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data2]').val())){
					toastr.warning('실효 2번을 입력해주세요.');
					$(this).find('td').find('input[name=data2]').focus();
					 checkYn ='N';
					return false;
				}
				if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('수치를 입력해주세요.');
					$(this).find('td').find('input[name=data3]').focus();
					 checkYn ='N';
					return false;
				}

				/* if(!$.trim($(this).find('td').find('input[name=data3]').val())){
					toastr.warning('OK/NG를 선택해주세요.');
					$(this).find('td').find('button[name=data3]').focus();
					 checkYn ='N';
					return false;
				} */
			});
			if(checkYn !='N'){
				for(var i=0; i<$('#tableC tbody tr').length; i++){
					if($('input[name=data4_3_'+i+']').is(':checked') == false){
						toastr.warning('OK/NG를 선택해주세요.');
						checkYn ='N';
						return false;
					}
				}
			}
			//조건_C 끝
			var array = new Array();
			//저장처리_C
			if(checkYn !='N'){
				$('#tableC tbody tr').each(function(){
		 			$('#my-spinner').show();
					var obj = new Object();
					
					obj.lotNo		= lotNo;
					obj.trustGubun 	= trustGubun;
					obj.trustSeq 	= $(this).find('td').find('input[name=trustSeq]').val();	//시퀀스(히든 값)
					obj.testDate 	= $(this).find('td').find('input[name=testDate]').val();	//입력일자
					obj.data1 		= $(this).find('td').find('input[name=data1]').val();		//실효1번 .replace(/,/g,'')
					obj.data2 		= $(this).find('td').find('input[name=data2]').val();		//실효2번
					obj.data3 		= $(this).find('td').find('input[name=data3]').val();		//수치
					obj.data4 		= $(this).find('td').find('input[name=data4Val]').val();	//OK/NG
					obj.trustDesc	= $(this).find('td').find('input[name=trustDesc]').val();	//비고
					
					array.push(obj);
				});
// 				console.log(array);
				var data = JSON.stringify(array);
			}//저장처리_C 끝
		}


		if(checkYn != "N"){
			var url = '<c:url value="qm/reliabilityResultCreate"/>';
	        //저장
	        $.ajax({
				url : url,
				type : 'POST',
				data : {
					'arrayData' : function(){ return data; }
				},
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						toastr.success('입력 되었습니다.');
					} else {
						toastr.error(res.message);
					}
	            },
	            complete : function() {
	            	$('#btnSave').addClass('d-none');
	            	
					$('#'+reliabilityTableIdx).click();	//reload 대체
						
	        		$('#my-spinner').hide();
				}
			});
	      //저장
		}
	});

	//우측 탭 클릭 시
	$('#tab1Nav').on('click', function() {
		trustGubun = '001';
		$('#'+reliabilityTableIdx).click();	//reload 대체
		$('#tab1').removeClass('d-none');
		$('#btnSave').addClass('d-none');

		$('#tab1').removeClass('d-none');
		$('#tab2').addClass('d-none');
		$('#tab3').addClass('d-none');

		$('#photoTable thead tr').empty();
		$('#photoTable thead tr').append('<th colspan="2">실링 사진</th>');
		
    	tableB.clear().draw();
    	tableC.clear().draw();
    	
		$('#tableA').DataTable().ajax.reload();
	});

	$('#tab2Nav').on('click', function() {
		trustGubun = '002';
		$('#'+reliabilityTableIdx).click();	//reload 대체
		$('#tab1').addClass('d-none');
		$('#tab2').removeClass('d-none');
		$('#tab3').addClass('d-none');

		$('#photoTable thead tr').empty();
		$('#photoTable thead tr').append('<th colspan="2">침투액 사진</th>');	

		$('#btnSave').addClass('d-none');

		tableA.clear().draw();
    	tableC.clear().draw();
		
		$('#tableB').DataTable().ajax.reload();
	});

	$('#tab3Nav').on('click', function() {
		trustGubun = '003';
		$('#'+reliabilityTableIdx).click();	//reload 대체
		$('#tab1').addClass('d-none');
		$('#tab2').addClass('d-none');
		$('#tab3').removeClass('d-none');

		$('#photoTable thead tr').empty();
		$('#photoTable thead tr').append('<th colspan="2">파괴 사진</th>');
		
		$('#btnSave').addClass('d-none');

		tableA.clear().draw();
    	tableB.clear().draw();

		$('#tableC').DataTable().ajax.reload();
	});
	//우측 탭 클릭 시 끝
	
	//추가버튼 클릭 시
	function lineSelected(){
		
		if($('#reliabilityTable tbody tr').hasClass('selected')=='') {
			toastr.warning("항목을 선택해주세요.");
			return false;
		}

		$('#btnSave').removeClass('d-none');
		
		if(trustGubun == '001'){
			//실링
			tableA.row.add({
				"num"		:	temp+1,
				"testDate"	:	"",
				"data1"		:	"",
				"data2"		:	"",
				"data3"		:	"",
				"data4"		:	"",
				"trustDesc"	:	"",
			}).draw();

			var i = 1;
			//순번 삭제
			$('#tableA > tbody > tr > td').each(function(index, td) {
				if ((index % 7) == 0) {
					$(this).text(i);
					i++;
				}
	        });
			
		} else if(trustGubun == '002'){
			//침투액
			tableB.row.add({
				"num"		:	temp+1,
				"testDate"	:	"",
				"data1"		:	"",
				"data2"		:	"",
				"data3"		:	"",
				"data4"		:	"",
				"trustDesc"	:	"",
			}).draw();

			var i = 1;
			//순번 삭제
			$('#tableB > tbody > tr > td').each(function(index, td) {
				if ((index % 7) == 0) {
					$(this).text(i);
					i++;
				}
	        });
			
		} else{
			//파괴
			tableC.row.add({
				"num"		:	temp+1,
				"testDate"	:	"",
				"data1"		:	"",
				"data2"		:	"",
				"data3"		:	"",
				"data4"		:	"",
				"trustDesc"	:	"",
			}).draw();

			var i = 1;
			//순번 삭제
			$('#tableC > tbody > tr > td').each(function(index, td) {
				if ((index % 7) == 0) {
					$(this).text(i);
					i++;
				}
	        });
		}
	}

	//수정 버튼 클릭 시
	$('#btnEdit').on('click', function(){
		if($('#reliabilityTable tbody tr').hasClass('selected')=='') {
			toastr.warning("항목을 선택해주세요.");
			return false;
		}
		
		if(trustGubun == '001'){
			$('#form input').attr('disabled', false);
		}else if(trustGubun == '002'){
			$('#form2 input').attr('disabled', false);
		} else{
			$('#form3 input').attr('disabled', false);
		}
		
		$('#btnSave').removeClass('d-none');
	});

	//삭제버튼 클릭 시
	function tapDelete(){
        if(trustGubun == '001'){
        	//실링
        	if ($('#tableA  tbody tr').hasClass('selected')=='') {
    			toastr.warning("삭제할 목록을 선택해 주세요");
    			return false;
    		}
    		
    		tableA.row('.selected').remove().draw();
    		var i = 1;
    		$('#tableA > tbody > tr > td').each(function(index, td) {
    			if ((index % 7) == 0) {
    				$(this).text(i);
    				i++;
    			}
            });
            temp = i;

            tableA.row('.selected').remove().draw();
		}else if(trustGubun =='002'){
			//침투액
			if ($('#tableB  tbody tr').hasClass('selected')=='') {
    			toastr.warning("삭제할 목록을 선택해 주세요");
    			return false;
    		}
    		
    		tableB.row('.selected').remove().draw();
    		var i = 1;
    		$('#tableB > tbody > tr > td').each(function(index, td) {
    			if ((index % 7) == 0) {
    				$(this).text(i);
    				i++;
    			}
            });
            temp = i;

            tableB.row('.selected').remove().draw();
            	
		}else{
			//파괴 
			if ($('#tableC  tbody tr').hasClass('selected')=='') {
    			toastr.warning("삭제할 목록을 선택해 주세요");
    			return false;
    		}
    		
    		tableC.row('.selected').remove().draw();
    		var i = 1;
    		$('#tableC > tbody > tr > td').each(function(index, td) {
    			if ((index % 7) == 0) {
    				$(this).text(i);
    				i++;
    			}
            });
            temp = i;

            tableC.row('.selected').remove().draw();
		}

        //삭제
        $.ajax({
			url : '<c:url value="qm/reliabilityResultDelete"/>',
			type : 'POST',
			data : {
				 'lotNo'		: function(){ return lotNo; 		},
				 'trustGubun'	: function(){ return trustGubun;	},
				 'trustSeq'		: function(){ return trustSeq;		}
			},
			success : function(res) {
				let data = res.result;
				
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');
					tableA.row('.selected').remove().draw();
					tableB.row('.selected').remove().draw();
					tableC.row('.selected').remove().draw();
					trustSeq ='';
				} else {
					toastr.error(res.message);
				}
			}
		});
		//삭제
	}

	//사진 추가 버튼 클릭 시
	function photoSelect(value, trustPhotoSeq){
		
		if($('#reliabilityTable tbody tr').hasClass('selected')=='') {
			toastr.warning("항목을 선택해주세요.");
			return false;
		}

		if($('#photoTable tbody tr').text() == '데이터가 없습니다.') {
			$('#photoTable tbody').empty();
		}

// 		console.log("값 들어왔담 : "+value);
// 		console.log("사진관련 시퀀스는 : "+trustPhotoSeq);
		
		if(value != null){
			countPhoto = value;
		}else{

	 		//시스템 공콩코드로 사진 추가 개수 설정
// 	 		console.log(photoCountCode[0].baseCdAbbr);
			if(photoCountCode[0].baseCdAbbr == null || photoCountCode[0].baseCdAbbr == ""){
				toastr.warning("시스템 공통 코드관리(084)에서 값을 입력해주세요!");
				return false;
			}
			
			if(photoCountCode[0].baseCdAbbr <= countPhoto){
				toastr.warning("최대 개수는 "+photoCountCode[0].baseCdAbbr+"개입니다.");
				return false;
			}
			
			countPhoto++;
		}
// 		console.log("값은 ? : "+countPhoto);

		//공백 저장 하기
		if(value == null){
			$.ajax({
				url : '<c:url value="/qm/reliabilityPhotoBlankCreate"/>',
				data : {
					'lotNo' 		: function(){return lotNo;},
					'trustGubun' 	: function(){return trustGubun;},
				},
				type : 'POST',
				async: false,
				success : function(res) {
					let data = res.result;
					if (data == "ok") {
						toastr.success('추가 되었습니다.');
						trustPhotoSeq = res.trustPhotoSeq;
					} else if (data == "error") {
						toastr.error(res.message);
					}
				}
			});
		}
		//공백 저장 하기 끝


		if(countPhoto %2 == 0) {
			var rtn_1 ='<div class="custom-file" style="height: 150px;">';
				rtn_1 +='<img alt="등록된 사진이 없습니다." id="imageFile'+countPhoto+'" src="" name="imageFile1" style="width: 100%; height: 100%">';
				rtn_1 +='</div>';

			$('#photoTable tbody tr').eq((countPhoto-2)).find('td').eq(1).append(rtn_1);

			var rtn_2 ='<div class="form-group">';
				rtn_2 +='<div class="custom-file" style="width: 90%;" id="fileSearch'+countPhoto+'" name="fileSearch">';
				//rtn_2 +='<input type="file" class="custom-file-input" data-count="'+countPhoto+'" id="imgAdd1" name="imgAdd1" onchange="">';
				rtn_2 +='<input type="file" class="custom-file-input" data-count="'+countPhoto+'">';
				rtn_2 +='<label class="custom-file-label" data-count="'+countPhoto+'" id="imageFileNm_'+countPhoto+'"></label>';
				rtn_2 +='</div>';
				rtn_2 +='<input type="hidden" class="form-control text-center" data-count="'+countPhoto+'" id="trustPhotoSeq'+countPhoto+'" value="'+trustPhotoSeq+'">';	//사진 관련 시퀀스 hidden값
				rtn_2 +='<div class="rightsidebar-close" style="width: 10%; padding-top: 4px;" id="btnFpFileDel'+countPhoto+'" name="btnFpFileDel">';
				rtn_2 +='<button type="button" class="btn" onclick="deleteImg('+countPhoto+');">';
				rtn_2 +='<i class="mdi mdi-close"></i>';
				rtn_2 +='</button>';
				rtn_2 +='</div>';
				rtn_2 +='</div>';

				rtn_2 +='<div class="form-group" id="fileTag'+countPhoto+'" name="fileTag">';
				rtn_2 +='<a id="fpHref'+countPhoto+'"><span style="font-size: 14px;" id="fpFn'+countPhoto+'"></span> <span style="font-size: 10px; vertical-align: bottom;" id="imageFileSize'+countPhoto+'"></span></a>';
				rtn_2 +='</div>';

			$('#photoTable tbody tr').eq((countPhoto-1)).find('td').eq(1).append(rtn_2);
		}else {
			var rtn_1  = '<tr>';
				rtn_1 +='<td style="width: 50%;">';
				rtn_1 +='<div class="custom-file" style="height: 150px;">';
				rtn_1 +='<img alt="등록된 사진이 없습니다." id="imageFile'+countPhoto+'" src="" name="imageFile1" style="width: 100%; height: 100%">';
				rtn_1 +='</div>';
				rtn_1 +='</td>';
				rtn_1 +='<td>';
				rtn_1 +='</td>';
				rtn_1 +='</tr>';
				
			$('#photoTable tbody').append(rtn_1);

			var rtn_2 ='<tr>';
				rtn_2 +='<td>';
				rtn_2 +='<div class="form-group">';
				rtn_2 +='<div class="custom-file" style="width: 90%;" id="fileSearch'+countPhoto+'" name="fileSearch">';
				rtn_2 +='<input type="file" class="custom-file-input" data-count="'+countPhoto+'">';
				rtn_2 +='<label class="custom-file-label" data-count="'+countPhoto+'" id="imageFileNm_'+countPhoto+'"></label>';
				rtn_2 +='</div>';
				rtn_2 +='<input type="hidden" class="form-control text-center" data-count="'+countPhoto+'" id="trustPhotoSeq'+countPhoto+'" value="'+trustPhotoSeq+'">';	//사진 관련 시퀀스 hidden값
				rtn_2 +='<div class="rightsidebar-close" style="width: 10%; padding-top: 4px;" id="btnFpFileDel'+countPhoto+'" name="btnFpFileDel">';
				rtn_2 +='<button type="button" class="btn" onclick="deleteImg('+countPhoto+');">';
				rtn_2 +='<i class="mdi mdi-close"></i>';
				rtn_2 +='</button>';
				rtn_2 +='</div>';
				rtn_2 +='</div>';
				
				rtn_2 +='<div class="form-group" id="fileTag'+countPhoto+'" name="fileTag">';
				rtn_2 +='<a id="fpHref'+countPhoto+'"><span style="font-size: 14px;" id="fpFn'+countPhoto+'"></span> <span style="font-size: 10px; vertical-align: bottom;" id="imageFileSize'+countPhoto+'"></span></a>';
				rtn_2 +='</div>';
								
				rtn_2 +='</td>';
				rtn_2 +='<td>';
				rtn_2 +='</td>';
				rtn_2 +='</tr>';
				
			$('#photoTable tbody').append(rtn_2);
		}
	}
	
	//Browse(검색)버튼 클릭 시
	$(document).on('click','.custom-file-label',function(e){
		e.preventDefault();
		let countPhoto = $(this).data('count');
		$('.custom-file-input[data-count="'+countPhoto+'"]').trigger('click');
		return false;
	});

	//class로 값을 찾아서 이미지를 넣어준다. & 이미지 등록
	$(document).on('change','.custom-file-input',function(e){
		e.preventDefault();

		var file = $(this).val();
// 		console.log("file : "+file);
		
		if (!checkImgType(file)) {
			toastr.warning("이미지파일을 선택해 주세요.");
			$(this).val('');
       		return false;
		}
		
		let count = $(this).data('count');	//data-count에서 count된 값을 가지고 온다.
// 		console.log(count);
		
		var files = $(this)[0].files[0];

		var photoSeq = $('#trustPhotoSeq'+count).val();	//선택된 data-count에 해당하는 시퀀스 값을 가지고 온다.
// 		console.log("시퀀스 값은 : "+photoSeq);

		var formData = new FormData();
		formData.append("lotNo", lotNo);
		formData.append("trustGubun", trustGubun);
		formData.append("trustPhotoSeq", photoSeq);
		formData.append('trustPhoto', files);

// 		for (var pair of formData.entries()) {console.log(pair[1]); }

		//Update
		$.ajax({
			url : '<c:url value="/qm/reliabilityPhotoUpdate"/>',
			data : formData,
			processData : false,
			contentType : false,
			type : 'POST',
			success : function(data) {
				if (data.result == "ok") {
					toastr.success('등록되었습니다.');
					$('#'+reliabilityTableIdx).click();	//reload 대체
				} else if (data.result == "extensionError") {
					toastr.warning(res.message);
				}else{
					toastr.error(res.message);
				}
			}
		});
		//Update
	});

	//사진 하나씩 삭제 시
	function deleteImg(value){
		var photoSeq = $('#trustPhotoSeq'+value).val();	//선택된 data-count에 해당하는 시퀀스 값을 가지고 온다.

		if($('#imageFileNm_'+value).text() != ''){
			//삭제
			$.ajax({
				url : '<c:url value="qm/reliabilityPhotoDelete"/>',
				type : 'POST',
				data : {
					 'lotNo'			: function(){ return lotNo; 		},
					 'trustGubun'		: function(){ return trustGubun;	},
					 'trustPhotoSeq'	: function(){ return photoSeq;		}
				},
				success : function(res) {
					let data = res.result;
					
					if (res.result == 'ok') {
						toastr.success('삭제되었습니다.');
						$('#imageFileNm_'+value).text('');
						$('#fpFn'+value).text('');
						$('#imageFile'+value).attr('src', '');
						$('#fileSearch'+value).removeClass('d-none');	//fileInputBox(div)
						$('#fileTag'+value).addClass('d-none');			//하이퍼링크 값(div)
					} else {
						toastr.error(res.message);
					}
				}
			});
			//삭제
		}
	}

	//공백 삭제 버튼 클릭 시
	$('#btnBlankDel').on('click', function(){
		if($('#reliabilityTable tbody tr').hasClass('selected')=='') {
			toastr.warning("항목을 선택해주세요.");
			return false;
		}
		if($('#photoTable tbody tr').length == 0 || $('#photoTable tbody tr').text() == '데이터가 없습니다.') {
			toastr.warning("삭제할 값이 없습니다.");
			return false;
		}

		var checkCount = 0;
		
		for(var i=1; i<=countPhoto; i++){
			
		    if($('#imageFileNm_'+i).text() != ''){
		    	//값 있는 테이블
		    	checkCount++
		    }

		    if(countPhoto == i){
			    if(checkCount == i){
				    toastr.warning('공백이 없습니다.');
				} else{
					$('#deleteReliabilityModal').modal({backdrop: 'static'});
					$('#deleteReliabilityModal').modal('show');
					$('#deleteReliabilityModalLabel').text("신뢰성 결과 공백 삭제 확인");
					$('#deleteReliabilityModalAfter').text("* 공백이 들어간 부분이 삭제되며, 순서가 재정의 됩니다.");

					var rtn ='<button type="button" class="btn btn btn-danger btnCheckConfirm" style="width: 16%;" id="btnModelBlankDel">삭제</button>';
						rtn += '<button type="button" class="btn btn-secondary" style="width: 16%;" data-dismiss="modal">닫기</button>';
					$('#divSudel').empty();
					$('#divSudel').append(rtn);
				}
			}
		}
	});

	//공백 사진 삭제
	$(document).on('click','#btnModelBlankDel',function(e){
		$('#my-spinner').show();

		var array = new Array();

		var checkCount = 0;
		
		for(var i=1; i<=countPhoto; i++){
			
		    if($('#imageFileNm_'+i).text() == ''){
				//값 없는 테이블
		        $('#trustPhotoSeq'+i).val();
		        array.push($('#trustPhotoSeq'+i).val());

		    }else{
		    	//값 있는 테이블
		    	checkCount++
		    }

		    if(countPhoto == i){
			    if(checkCount != i){
					//삭제
					$.ajax({
						url : '<c:url value="qm/reliabilityBlankPhotoDelete"/>',
						type : 'POST',
						data : {
							 'lotNo'		: function(){ return lotNo; 		},
							 'trustGubun'	: function(){ return trustGubun;	},
							 'array'		: function(){ return array;			}
						},
						success : function(res) {
							let data = res.result;
							if (res.result == 'ok') {
								toastr.success('공백이 삭제되었습니다.');
								$('#'+reliabilityTableIdx).click();	//reload 대체
								$('#my-spinner').hide();
							} else {
								toastr.error(res.message);
							}
						}
					});
					//삭제
				}
			}
		}
		$('#deleteReliabilityModal').modal('hide');
	});

	//전체 사진 삭제
	$('#btnPhotoAllDel').on('click', function(){

		if($('#reliabilityTable tbody tr').hasClass('selected')=='') {
			toastr.warning("항목을 선택해주세요.");
			return false;
		}
		if($('#photoTable tbody tr').length == 0 || $('#photoTable tbody tr').text() == '데이터가 없습니다. ') {
			toastr.warning("삭제할 값이 없습니다.");
			return false;
		}
		$('#deleteReliabilityModal').modal({backdrop: 'static'});
		$('#deleteReliabilityModal').modal('show');
		$('#deleteReliabilityModalLabel').text("신뢰성 결과 전체 삭제 확인");
		$('#deleteReliabilityModalAfter').text("* 공백을 포함한 모든 사진이 삭제됩니다.");

		var rtn = '<button type="button" class="btn btn btn-danger btnCheckConfirm" style="width: 16%;" id="btnModelAllDel">삭제</button>';
			rtn += '<button type="button" class="btn btn-secondary" style="width: 16%;" data-dismiss="modal">닫기</button>';
		$('#divSudel').empty();
		$('#divSudel').append(rtn);
	});

	//전체 사진 삭제
	$(document).on('click','#btnModelAllDel',function(e){
		$('#my-spinner').show();
		$.ajax({
			url : '<c:url value="qm/reliabilityPhotoAllDelete"/>',
			type : 'POST',
			data : {
				 'lotNo'		: function(){ return lotNo; 		},
				 'trustGubun'	: function(){ return trustGubun;	},
			},
			success : function(res) {
				let data = res.result;
				if (res.result == 'ok') {
					toastr.success('전체 삭제되었습니다.');
					$('#'+reliabilityTableIdx).click();	//reload 대체
					$('#my-spinner').hide();
				} else {
					toastr.error(res.message);
				}
			}
		});
		$('#deleteReliabilityModal').modal('hide');
	});
	
	var html1 = '<div class="row">';
		html1 += '<label class="input-label-sm ml-1">작지일</label><div class="form-group input-sub m-0 row">';
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
		html1 += '<div class="multipleSelection pos-real ml-2">';
		html1 += '<div id="checkBoxes" class="checkBoxes1 selectBoxOverFlow" style="height:300px;">';
		html1 += '</div>';
		html1 += '</div>';
		html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-1" id="btnRetv">조회</button>';
		html1 += '</div>';
	
	$('#reliabilityTable_length').html(html1);
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

  		$('#my-spinner').show();
  		
  		reliabilityTableIdx ='';
  		tableA.clear().draw();
		tableB.clear().draw();
		tableC.clear().draw();
		$('#photoTable tbody').empty();
		countPhoto = 0;
		$('#tab2Nav').addClass('disabled');
		$('#tab3Nav').addClass('disabled');
  		$('#reliabilityTable').DataTable().ajax.reload();
	});

	//X표시 클릭 시 
	function closerNav() {
		$('#reliabilityTable_filter').attr('style', 'margin-right: 5%;');
		$("#left-list").animate({
			width : "100%"
		}, 200);
		document.getElementById("myrSidenav").style.display = "none";
		document.getElementById("arrowLeft").style.display = "block";
		document.getElementById("main").style.marginRight = "10px";
	}
	//페이지 오픈 시
	function openrNav() {
		$('#reliabilityTable_filter').attr('style', '');
		document.getElementById("myrSidenav").style.display = "block";
		document.getElementById("arrowLeft").style.display = "none";
		document.getElementById("main").style.marginRight = "0";
	}
	tableCheck();
	//사진 관련 테이블 데이터가 없을 때
	function tableCheck(){
		var count = $('#photoTable tbody tr').length;
		var text = $('#photoTable tbody tr').text();
		
		if(count == 0 || text == '데이터가 없습니다.'){
			var html = '<tr><td style="text-align: center;">데이터가 없습니다.</td></tr>';
			$('#photoTable').append(html);
		}
	}

</script>

</body>
</html>
