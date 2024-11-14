<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품 다중 추적</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<button type="button" class="btn btn-success float-right mr-1" id="btnExcel">추적 대상목록 입력</button>
				<div class="table-responsive" id="traceType001002">
					<table id="goodsTraceTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:80px;">자재LotNo</th>
								<th class="text-center" style="min-width:120px;">생산LotNo</th>
								<th class="text-center" style="min-width:110px;">BoxNo</th>
								<th class="text-center" style="min-width:110px;">원장BoxNo</th>
								<th class="text-center" style="min-width:110px;">병합BoxNo</th>
								<th class="text-center" style="min-width:110px;">분할/병합</th>
								<th class="text-center" style="min-width:80px;">포장일</th>
								<th class="text-center" style="min-width:120px;">제품명</th>
								<th class="text-center" style="min-width:70px;">오더구분</th>
								<th class="text-center" style="min-width:70px;">포장 수량</th>
								<th class="text-center" style="min-width:70px;">잔여 수량</th>
								<th class="text-center" style="min-width:100px;">제품 상태</th>
								<th class="text-center" style="min-width:100px;">불량 상태</th>
								<th class="text-center" style="min-width:100px;">재분할</th>
								<th class="text-center" style="min-width:100px;">불량일</th>
								<th class="text-center" style="min-width:200px;">불량 유형</th>
								<th class="text-center" style="min-width:100px;">비고</th>
								<th class="text-center" style="min-width:100px;">PO_SEQ</th>
								<th class="text-center" style="min-width:100px;">PO_NO</th>
								<th class="text-center" style="min-width:100px;">거래처</th>
								<th class="text-center" style="min-width:100px;">납기일</th>
							</tr>
						</thead>
					</table>
				</div>
				
				<div class="table-responsive d-none" id="traceType003">
					<table id="purchaseTraceTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:80px;">자재LotNo</th>
								<th class="text-center" style="min-width:120px;">생산LotNo</th>
								<th class="text-center" style="min-width:110px;">BoxNo</th>
								<th class="text-center" style="min-width:110px;">원장BoxNo</th>
								<th class="text-center" style="min-width:110px;">병합BoxNo</th>
								<th class="text-center" style="min-width:110px;">분할/병합</th>
								<th class="text-center" style="min-width:80px;">포장일</th>
								<th class="text-center" style="min-width:120px;">제품명</th>
								<th class="text-center" style="min-width:70px;">오더구분</th>
								<th class="text-center" style="min-width:70px;">포장 수량</th>
								<th class="text-center" style="min-width:70px;">잔여 수량</th>
								<th class="text-center" style="min-width:100px;">제품 상태</th>
								<th class="text-center" style="min-width:100px;">불량 상태</th>
								<th class="text-center" style="min-width:100px;">재분할</th>
								<th class="text-center" style="min-width:100px;">불량일</th>
								<th class="text-center" style="min-width:200px;">불량 유형</th>
								<th class="text-center" style="min-width:100px;">비고</th>
								<th class="text-center" style="min-width:100px;">PO_SEQ</th>
								<th class="text-center" style="min-width:100px;">PO_NO</th>
								<th class="text-center" style="min-width:100px;">거래처</th>
								<th class="text-center" style="min-width:100px;">납기일</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<!-- LOT&Barcode 업로드 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="reservation_Modal" tabindex="-1" role="dialog" aria-labelledby="reservation_ModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">제품 다중 추적</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body" style="overflow:auto;">
				<div class="card mb-4">
					<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
						<button type="button" class="btn btn-primary float-left mr-1" id="checkDelete">체크 삭제</button>
	    		 		<button type="button" class="btn btn-primary float-left mr-1" id="addRow">추가 입력</button>
	    		 		<div style="display: flex;align-items: flex-start;width: 40vh;justify-content: center;position: absolute;left: 17vh;" >
	    		 			<label class="touch6 ml-2 mr-1" for="selectLot">자재LotNo</label>
	    		 			<input type="radio" style="width:20px; height:20px" id="selectLot" name="uploadType" value="001" checked>
	    		 			<label class="touch6 ml-3 mr-1 d-none" for="selectBoxNo">생산 포장번호</label>
   		 					<input class="d-none" type="radio" style="width:20px; height:20px" id="selectBoxNo" name="uploadType" value="002" disabled>
   		 					<label class="touch6 ml-3 mr-1" for="selectPurchase">PO 납기일</label>
   		 					<input type="radio" style="width:20px; height:20px" id="selectPurchase" name="uploadType" value="003">
	    		 		</div>
						<label for="btnExcelUpload" class="btn btn-success float-right ml-1">엑셀업로드</label>
						<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />
						<a href="io/reservation_BasicForm" id="basicFrom">
							<button type="button" class="btn btn-secondary float-right" style="border: solid 1px blue;">기본양식다운로드</button>
						</a>
						<button type="button" class="btn btn-primary float-right mr-1" id="btnClear">초기화</button>
					</form>
				</div>
			
				<div class="table-responsive" style="height: 78vh; border-bottom: 1px solid #e3e3e3;">
					<div id="traceTableView">
						<table id="reservation_Table" class="table table-bordered" style="text-align: center">
							<thead class="thead-light">
								<tr>
									<th style="width: 3.5%">
										<input type="checkbox" style="width:20px; height:20px" id="reservation_CheckAll" name="reservation_CheckAll">
									</th>
									<th>자재LotNo</th>
								</tr>
							</thead>
						</table>
					</div>
					<div id="tracePurchaseView" class="d-none">
						<br><br>
						<div class="row">
							<label class="input-label-sm">납기일</label>
								<input type="date" class="form-control touch6" id="chooseDateFromCal">
								<!-- 
								<input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal"/>
								<button onclick="fnPopUpCalendar(chooseDateFromCal,chooseDateFromCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">
									<span class="oi oi-calendar"></span>
								</button>
								-->
							<label class="input-label-sm ml-2">~</label>
								<input type="date" class="form-control touch6" id="chooseDateToCal">
								<!-- 
								<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal"/>
								<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">
									<span class="oi oi-calendar"></span>
								</button>
								-->
							<!-- <button type="button" class="btn btn-primary" id="btnTerm">기간선택</button> -->
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<label style="margin-right:5vh;">*추적에 평군 5분정도 소요됩니다.</label>
					<label style="margin-right:5vh;color: red;">*중복된 값은 제거 후 조회 됩니다.</label>
					<label style="margin-right:5vh;color: blue;">*필름일 경우 추적에 더 많은 시간이 소요됩니다.</label>
					<button type="button" class="btn btn-primary float-right mr-1" id="btnInAddSave" style="min-width: 70px;">추적</button>
					<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- LOT&Barcode 업로드 모달 종료 -->
<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'iosc0150';
	let currentHref = 'iosc0150';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품 다중 추적");

	let serverDateFrom	= "${serverDateFrom}";   
	let serverDateTo	= "${serverDateTo}";
	let uploadType = '001';
	
	$('#chooseDateFromCal').val(serverDateFrom);
	$('#chooseDateToCal').val(serverDateTo);

	//엑셀 버튼 클릭 시
	$('#btnExcel').on('click', function(){
		$('#reservation_Table').DataTable().clear().draw();
		$('#reservation_Modal').modal({backdrop: 'static'});
		$('#reservation_Modal').modal('show');
	});

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
	//주석 풀면 똑같은 파일을 다시 등록할 수 있다.  
	$('#btnExcelUpload').on('click', function(){
		$('#btnExcelUpload').val("");
	});

	$.fn.dataTable.ext.errMode = 'none';
	let reservation_Table = $('#reservation_Table').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    'ajax' : {
	        url: '<c:url value="/io/reservation_List"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: menuAuth,
// 	        	'filename'		: url,
	        }		       
	    },
	    columns: [
	    	 {
	    		render: function(data, type, row, meta) {    			
					return '<input type="checkbox" style="width:20px; height:20px" name="reservation_Chk">' ;
	    		}
			},
	    	{ data: 'lotNo',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="lifeTimeId" class="form-control" style="border:0px; max-width:100%;" name="lifeTimeId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="lifeTimeId" class="form-control" name="lifeTimeId" value="" style="max-width:100%;">' ;
	    			}
	    		}
			}
	    ],
	    columnDefs: [
	    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
	    ],
	});
	
	//파일 선택
	$('#btnExcelUpload').change(function(){
		let formData	= new FormData($('#fileUploadForm')[0]);
		let str 		= $('#btnExcelUpload').val();
		
		if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
			
			//엑셀파일 업로드하는 ajax
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	data: formData,
		    	url:'<c:url value="io/reservation_ExcelUpload"/>',
		    	processData: false,
		    	contentType: false,
		    	cache: false,
		    	success: function (res) {
					if (res.result == 'ok') {
						let url = res.data;

		    			//테이블 생성(excel읽기)_ajax
						$.ajax({
		    		        url: '<c:url value="/io/reservation_DataList"/>',
		    		        type: 'GET',
		    		        data: {
		    		        	'menuAuth'	 	: 		menuAuth,
		    		        	'filename'		:		url,
		    		        },
		    		        success: function (res) {
								if(res.result == 'ok') {
									 reservation_Table = $('#reservation_Table').DataTable({
							    		    language: lang_kor,
							    		    searching: false,
							    		    destroy: true,
							    		    paging: false,
							    		    info: true,		    
							    		    ordering: true,
							    		    processing: true,
							    		    autoWidth: false,
							    		    pageLength: false,
							    		    data: res.data,
							    		    columns: [
							    		    	 { 
						    			    		render: function(data, type, row, meta) {    			
						    							return '<input type="checkbox" style="width:20px; height:20px" name="reservation_Chk">' ;
						    			    		}
						    					},
							    		    	{ data: 'lotNo',
							    		    		render: function(data, type, row, meta) {
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="lotNoId" class="form-control text-center" style="border:0px; max-width:100%;" name="lotNoId" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="lotNoId" class="form-control text-center" name="lotNoId" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    				}
							    		    ],
							    		    order : [],
							    		    columnDefs: [
							    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
							    		    ],
								        });
								        
						    	} else if (res.result == 'fail') {
						    		toastr.warning(res.message, '', {timeOut: 5000});
						    	} else if (res.result == 'error') {
						    		toastr.error(res.message, '', {timeOut: 5000});
						    	}
							}
						});
						//테이블 생성(excel읽기)_ajax
	    			}
		    	}
	    	});
			//엑셀파일 업로드하는 ajax
		} else {
			toastr.warning("Excel파일을 선택해 주세요.");
			return false;
		}
	});

	//전체 체크버튼 클릭 시
	$('#reservation_CheckAll').on('click', function(){
		if($("#reservation_CheckAll").prop("checked")) { 
			$("input[name=reservation_Chk]").prop("checked",true); 
		} else { 
			$("input[name=reservation_Chk]").prop("checked",false);
		}        
    });

	//checkBox디테일 설정
    $(document).on('click','input[name=reservation_Chk]',function(e){
    	if($('input:checkbox[name=reservation_Chk]:checked').length == $('input:checkbox[name=reservation_Chk]').length){
    		$("#reservation_CheckAll").prop("checked", true);
        }else{
        	$("#reservation_CheckAll").prop("checked", false);
		}
	});

	//체크 삭제 버튼 클릭 시 
	$('#checkDelete').on('click', function() {
		if(reservation_Table.data().count() != 0){
			$('#reservation_Table tbody tr').each(function(){
				if($(this).find('td input[name=reservation_Chk]').is(':checked')){
					reservation_Table.row(this).remove().draw();
				}
			});
			$('#reservation_CheckAll').prop('checked', false);
			toastr.success("삭제되었습니다.", '', {timeOut: 500});
		}
	});

	//입력버튼 클릭 시
	$('#addRow').on('click', function() {
		$('#reservation_Table').DataTable().row.add({}).draw(false);
		if($('input:checkbox[name=reservation_Chk]:checked').length == $('input:checkbox[name=reservation_Chk]').length){
    		$("#reservation_CheckAll").prop("checked", true);
        }else{
        	$("#reservation_CheckAll").prop("checked", false);
		}
	});

	//라디오 버튼 클릭 시
	$('input[name=uploadType]').on('click', function(){
		uploadType = $('input[name=uploadType]:checked').val();
		if (uploadType == "001") {
			$('#reservation_Table thead tr th').eq(1).text("자재LotNo");
			$('#traceTableView').removeClass('d-none');
			$('#tracePurchaseView').addClass('d-none');
			
		} else if (uploadType == "002") {
			$('#reservation_Table thead tr th').eq(1).text("생산 포장번호");
			$('#traceTableView').removeClass('d-none');
			$('#tracePurchaseView').addClass('d-none');
			
		} else if (uploadType == "003") {
			$('#traceTableView').addClass('d-none');
			$('#tracePurchaseView').removeClass('d-none');
			
		}
	});
	
	//초기화
    $('#btnClear').on('click', function(){ 
    	if(reservation_Table.data().count() != 0){
   			$('#reservation_Table').DataTable().clear().draw();
       		$('#btnExcelUpload').val("");
       		toastr.success("초기화 되었습니다.");
    	}
    });

	//추적 버튼
	$('#btnInAddSave').on('click', function() {
		let dataArray	= new Array();
		let typeText 	= uploadType
		let check 		= true;
		let url = null;
		if (typeText == '001') {
			url = '<c:url value="/po/goodsTraceByMatrlLotNo"/>';
			$('#traceType001002').removeClass('d-none');
			$('#traceType003').addClass('d-none');
			
		} else if (typeText == '002') {
			url = '<c:url value="/po/goodsTraceByBoxNo"/>';
			$('#traceType001002').removeClass('d-none');
			$('#traceType003').addClass('d-none');
			            
		} else if (typeText == '003') {

			let dateFrom	= new Date($('#chooseDateFromCal').val());
			let dateTo		= new Date($('#chooseDateToCal').val());
			let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
			dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
			if (isNaN(dateDiff)) {
				toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
				$('#chooseDateFromCal').focus();
				return false;
			}
			if (dateDiff <= 0) {
				toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
				$('#chooseDateFromCal').focus();
				return false;
			}
			if (dateDiff > 31) {
				toastr.warning("검색 가능 기간은 최대 한달입니다!");
				$('#chooseDateFromCal').focus();
				return false;
			}
			
			url = '<c:url value="/po/goodsTraceByPurchase"/>';
			$('#traceType001002').addClass('d-none');
			$('#traceType003').removeClass('d-none');
			
		} else {
			toastr.warning('제품을 추적할 추적옵션을 선택해 주세요');
		}

		//자재LotNo, 생산 포장번호 기준 제품추적
		if (typeText == '001' || typeText == '002') {
			$('#reservation_Table tbody tr').each(function() {
		        let rowData = new Object();
		        if($(this).find('td input').eq(1).val() == ""){
		        	toastr.warning(typeText+"을 입력해주십시오.");
		        	$(this).find('td input').eq(1).focus();
		        	check = false;
		        	return false;
		        }
		        
		        rowData.menuAuth	= menuAuth;
		        rowData.typeText	= $(this).find('td input').eq(1).val().replace(/-/g, '');
		        dataArray.push(rowData);
	    	});
		
		//납기일 기준 제품추적
		} else if (typeText == '003') {
			let rowData = new Object();
			rowData.menuAuth	= menuAuth;
			rowData.chooseDateFrom	= $('#chooseDateFromCal').val().replace(/-/g, '');
			rowData.chooseDateTo	= $('#chooseDateToCal').val().replace(/-/g, '');
			dataArray.push(rowData);
		}
		
		if(check == true){
			dataArray = [...new Set(dataArray.map(JSON.stringify))].map(JSON.parse);	//중복제거
		    //console.log(dataArray);
			$('#goodsTraceTable').DataTable().clear().draw();
			$('#purchaseTraceTable').DataTable().clear().draw();
		    $('#reservation_Modal').modal('hide');
			$('#my-spinner').show();
			
			$.ajax({
				url: url,
		        type: 'POST',
		        datatype: 'json',
		        async : true,
		        data: JSON.stringify(dataArray),
		        contentType : "application/json; charset=UTF-8",
		        success: function(result){
			        let traceData = result.data;
			        if (result.result == "ok") {
			        	$('#reservation_Modal').modal('hide');
		      			toastr.success('조회 되었습니다.');

		      			//자재, 포장번호로 추적 시
		      			if (typeText == '001' || typeText == '002') {
		      				functionGoodsTraceTable(traceData);
		      				
		      			//PO 납기일로 추적 시
		      			} else if (typeText == '003') {
		      				functionPurchaseTraceTable(traceData);
				      	}
			      			
		      			

		      			
		      			
		      		
		      		
		        	} else if (result.result == "fail") {
		        		toastr.warning(result.message, '', {timeOut: 5000});
		        	} else{
		        		toastr.error(result.message, '', {timeOut: 5000});
		        	}
		        },
				complete:function(){
					$('#my-spinner').hide();
				}
	      	});
		}
	});

	let goodsTraceTable = $('#goodsTraceTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    columns: [
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    	{ data: 'boxNo' },
	    ],
	    buttons: [
			{
				extend: 'copy',
				title: '제품 다중 추적',
			},
			{
				extend: 'excel',
				title: '제품 다중 추적',
			},
			{
				extend: 'print',
				title: '제품 다중 추적',
			},
		],
	});

	function functionGoodsTraceTable(traceData) {
		goodsTraceTable = $('#goodsTraceTable').on( 'error.dt', function ( e, settings, techNote, message ) {
				if(techNote == 7) {
					toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
					location.href = "/";
				}
			}).DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			    language: lang_kor,
			    searching: false,
			    destroy: true,
			    paging: false,
			    info: true,		    
			    ordering: false,
			    processing: true,
			    autoWidth: false,
			    pageLength: false,		   
			    data :  traceData,
			columns: [
			{ data: 'lotNo',
  				 render: function(data, type, row) {	
  					if (data == null) {
  						return "-";
  					} else {
  						return data;
      				}
				    }
				},
				{ data: 'workOrdLotNo' },
				{ data: 'boxNo' },
				{ data: 'selBoxNo1' },
				{ data: 'selBoxNo2' },
				{ data: 'mergeYnNm' },
				{ data: 'packDate',
				 render: function(data, type, row) {	
					 if(data == "Invalid date" || data == null){
						 return "";
					 }
						return moment(data).format("YYYY-MM-DD");
				     }
				},
				{ data: 'goodsNm' },
				{ data: 'ordGubunNm' },
				{ data: 'packCnt' },
				{ data: 'remainCnt' },
				{ data: 'goodsStatusNm' },
				{
					data: "faultyStatusNm",
					render: function(data, type, row, meta) {
						if(data == '폐기') {
							let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else {
							return data;
						}
					}
				},
				{
					data: "divisionYnNm",
					render: function(data, type, row, meta) {
						if(row['divisionYn'] == 'N') {
							let html = '<p style="margin-bottom: 0px;">-</p>';
							return html;
						} else if(row['divisionYn'] == 'D') {
							let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else if(row['divisionYn'] == 'M') {
							let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else {
							return data;
						}
					}
				},
	            {
	                data: 'faultyDate',
	                render: function(data, type, row) {
	                	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						} 
	                } 
	            },
	            {
					data: 'faultyType',
					render: function(data, type, row) {
						let count = 0;
						let faultyTypeNm = '';
						if (data != null) {
							for (let jj=0; jj<data.length; jj++) {
								if (data.substring(jj,jj+1) == '1'){
									faultyTypeNm += goodsFaultyType[jj].baseCdNm + ', ';
									count++;
								}
							}
							if (count == 0) {
								faultyTypeNm = '-';
							} else {
								faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
							}
						} else {
							faultyTypeNm = '';
						}
						return faultyTypeNm;
					}
	            },
	            { data: 'faultyDesc' },
	            { data: 'poSeq' },
	            { data: 'poNo' },
	            { data: 'dealCorpNm' },
	            {
	                data: 'deliveryDate',
	                render: function(data, type, row) {
	                	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						} 
	                } 
	            },
	        ],
	        columnDefs: [
	           	{ targets: [9,10], render: $.fn.dataTable.render.number( ',' )},
	           	{ targets: [9,10], className: 'text-right' }, 
	        ],
	        rowCallback: function (row, data) {
	            if ( data.divisionYn == 'D' ) {
	                $(row).addClass('skyYellow');
	            } else if ( data.divisionYn == 'M' ) {
	                $(row).addClass('skyBlue');
	            }
	        },
		buttons: [
			{
				extend: 'copy',
				title: '제품 다중 추적',
			},
			{
				extend: 'excel',
				title: '제품 다중 추적',
			},
			{
				extend: 'print',
				title: '제품 다중 추적',
			},
	        ],
		});
	}

	function functionPurchaseTraceTable(traceData) {
		purchaseTraceTable = $('#purchaseTraceTable').on( 'error.dt', function ( e, settings, techNote, message ) {
				if(techNote == 7) {
					toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
					location.href = "/";
				}
			}).DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			    language: lang_kor,
			    searching: false,
			    destroy: true,
			    paging: false,
			    info: true,		    
			    ordering: false,
			    processing: true,
			    autoWidth: false,
			    pageLength: false,		   
			    data :  traceData,
			columns: [
			{ data: 'lotNo',
  				 render: function(data, type, row) {	
  					if (data == null) {
  						return "-";
  					} else {
  						return data;
      				}
				    }
				},
				{ data: 'workOrdLotNo' },
				{ data: 'boxNo' },
				{ data: 'selBoxNo1' },
				{ data: 'selBoxNo2' },
				{ data: 'mergeYnNm' },
				{ data: 'packDate',
				 render: function(data, type, row) {	
					 if(data == "Invalid date" || data == null){
						 return "";
					 }
						return moment(data).format("YYYY-MM-DD");
				     }
				},
				{ data: 'goodsNm' },
				{ data: 'ordGubunNm' },
				{ data: 'packCnt' },
				{ data: 'remainCnt' },
				{ data: 'goodsStatusNm' },
				{
					data: "faultyStatusNm",
					render: function(data, type, row, meta) {
						if(data == '폐기') {
							let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else {
							return data;
						}
					}
				},
				{
					data: "divisionYnNm",
					render: function(data, type, row, meta) {
						if(row['divisionYn'] == 'N') {
							let html = '<p style="margin-bottom: 0px;">-</p>';
							return html;
						} else if(row['divisionYn'] == 'D') {
							let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else if(row['divisionYn'] == 'M') {
							let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
							return html;
						} else {
							return data;
						}
					}
				},
	            {
	                data: 'faultyDate',
	                render: function(data, type, row) {
	                	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						} 
	                } 
	            },
	            {
					data: 'faultyType',
					render: function(data, type, row) {
						let count = 0;
						let faultyTypeNm = '';
						if (data != null) {
							for (let jj=0; jj<data.length; jj++) {
								if (data.substring(jj,jj+1) == '1'){
									faultyTypeNm += goodsFaultyType[jj].baseCdNm + ', ';
									count++;
								}
							}
							if (count == 0) {
								faultyTypeNm = '-';
							} else {
								faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
							}
						} else {
							faultyTypeNm = '';
						}
						return faultyTypeNm;
					}
	            },
	            { data: 'faultyDesc' },
	            { data: 'poSeq' },
	            { data: 'poNo' },
	            { data: 'dealCorpNm' },
	            {
	                data: 'deliveryDate',
	                render: function(data, type, row) {
	                	if(data != "" && data != null) {
							return moment(data).format("YYYY-MM-DD");
						} else {
							return "-";
						} 
	                } 
	            },
	        ],
	        columnDefs: [
	           	{ targets: [9,10], render: $.fn.dataTable.render.number( ',' )},
	           	{ targets: [9,10], className: 'text-right' }, 
	        ],
	        rowCallback: function (row, data) {
	            if ( data.divisionYn == 'D' ) {
	                $(row).addClass('skyYellow');
	            } else if ( data.divisionYn == 'M' ) {
	                $(row).addClass('skyBlue');
	            }
	        },
		buttons: [
			{
				extend: 'copy',
				title: '제품 다중 추적',
			},
			{
				extend: 'excel',
				title: '제품 다중 추적',
			},
			{
				extend: 'print',
				title: '제품 다중 추적',
			},
	        ],
		});
	}
	
</script>

</body>
</html>

