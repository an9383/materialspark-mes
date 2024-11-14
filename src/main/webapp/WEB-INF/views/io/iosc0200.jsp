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
				<li class="breadcrumb-item"><a href="#">자재입출고관리</a></li>
				<li class="breadcrumb-item active">도금두께등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				
				<div class="card mb-4">
					<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
						<button type="button" class="btn btn-primary float-left mr-1" id="checkDelete">체크 삭제</button>
	    		 		<button type="button" class="btn btn-primary float-left mr-1" id="addRow">추가 입력</button>
	    		 		
						<label for="btnExcelUpload" class="btn btn-success float-right ml-1">엑셀업로드</label>
						
						<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />
						<a href="io/platedBasicForm" id="basicFrom">
							<button type="button" class="btn btn-secondary float-right" style="border: solid 1px blue;">기본양식다운로드</button>
						</a>
						
						<button type="button" class="btn btn-primary float-right mr-1" id="btnClear">초기화</button>
					</form>
				</div>
			
				<div class="table-responsive" style="height: 75vh; border-bottom: 1px solid #e3e3e3;">
					<div id="traceTableView">
						<table id="reservationTable" class="table table-bordered" style="text-align: center">
							<thead class="thead-light">
								<tr>
									<th style="width: 3.5%">
										<input type="checkbox" style="width:20px; height:20px" id="reservation_CheckAll" name="reservation_CheckAll">
									</th>
									<th>LotNo</th>
									<th>도금두께</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				
				<div style="display: flex;justify-content: space-between;align-items: flex-end;">
					<div>
						<label>*소수점은 3자리만 입력 가능합니다.</label>
	    		 		<br>
	    		 		<label>*필드에 중복되는 LotNo는 마지막 한 건만 등록 됩니다.</label>
	    		 		<br>
	    		 		<label>*LotNo중복 방지를 위해 이전 데이터와 중복되는 경우, 항상 마지막 LotNo값만 저장됩니다.(이전 LotNo는 삭제됩니다.))</label>
    		 		</div>
					<button type="button" class="btn btn-primary float-right mr-1" id="btnSave" style="min-width: 70px;">저장</button>
				</div>
				
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->


<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'iosc0200';
	let currentHref = 'iosc0200';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","도금두께 등록");

	let serverDateFrom	= "${serverDateFrom}";   
	let serverDateTo	= "${serverDateTo}";
	let uploadType		= '001';
	
	//주석 풀면 똑같은 파일을 다시 등록할 수 있다.  
	$('#btnExcelUpload').on('click', function(){
		$('#btnExcelUpload').val("");
	});

	$.fn.dataTable.ext.errMode = 'none';
	let reservationTable = $('#reservationTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	    				return '<input type="type" id="lotNo" class="form-control" style="border:0px; max-width:100%;" name="lotNo" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="lotNo" class="form-control" name="lotNo" value="" style="max-width:100%;">' ;
	    			}
	    		}
			},
			{ data: 'thicknessQty',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="thicknessQty" class="form-control" style="border:0px; max-width:100%;" name="thicknessQty" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="thicknessQty" class="form-control" name="thicknessQty" value="" style="max-width:100%;">' ;
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
		    	url:'<c:url value="io/platedExcelUpload"/>',
		    	processData: false,
		    	contentType: false,
		    	cache: false,
		    	success: function (res) {
					if (res.result == 'ok') {
						let url = res.data;

		    			//테이블 생성(excel읽기)_ajax
						$.ajax({
		    		        url: '<c:url value="/io/platedDataList"/>',
		    		        type: 'GET',
		    		        data: {
		    		        	'menuAuth'	 	: 		menuAuth,
		    		        	'filename'		:		url,
		    		        },
		    		        success: function (res) {
								if(res.result == 'ok') {
									 reservationTable = $('#reservationTable').DataTable({
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
							    		    				return '<input type="type" id="lotNo" class="form-control text-center" style="border:0px; max-width:100%;" name="lotNo" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="lotNo" class="form-control text-center" name="lotNo" value="" style="max-width:100%;">' ;
							    		    			}
							    		    		}
							    				},
							    				{ data: 'thicknessQty',
							    		    		render: function(data, type, row, meta) {
							    		    			if(data != null && data != "false") {
							    		    				return '<input type="type" id="thicknessQty" class="form-control text-center" style="border:0px; max-width:100%;" name="thicknessQty" disabled value="'+ data + '">';
							    		    			} else {
							    							return '<input type="text" id="thicknessQty" class="form-control text-center" name="thicknessQty" value="" style="max-width:100%;">' ;
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
		if(reservationTable.data().count() != 0){
			$('#reservationTable tbody tr').each(function(){
				if($(this).find('td input[name=reservation_Chk]').is(':checked')){
					reservationTable.row(this).remove().draw();
				}
			});
			$('#reservation_CheckAll').prop('checked', false);
			toastr.success("삭제되었습니다.", '', {timeOut: 500});
		}
	});

	//입력버튼 클릭 시
	$('#addRow').on('click', function() {
		$('#reservationTable').DataTable().row.add({}).draw(false);
		if($('input:checkbox[name=reservation_Chk]:checked').length == $('input:checkbox[name=reservation_Chk]').length){
    		$("#reservation_CheckAll").prop("checked", true);
        }else{
        	$("#reservation_CheckAll").prop("checked", false);
		}
	});

	//초기화
    $('#btnClear').on('click', function(){ 
    	if(reservationTable.data().count() != 0){
   			$('#reservationTable').DataTable().clear().draw();
       		$('#btnExcelUpload').val("");
       		toastr.success("초기화 되었습니다.");
    	}
    });

	//추적 버튼
	$('#btnSave').on('click', function() {
		let dataArray	= new Array();
		let typeText 	= uploadType
		let check 		= true;
		let rowData		= null;
		let inputValue	= null;

		//데이터 담아주는 부분
		$('#reservationTable tbody tr').each(function() {
			rowData	= null;
	        rowData = new Object();
	        
	        if($(this).find('td input').eq(1).val() == ""){
	        	toastr.warning("Lot번호를 입력해주십시오.");
	        	$(this).find('td input').eq(1).focus();
	        	check = false;
	        	return false;
	        }
	        
	        inputValue = parseFloat( $(this).find('td input').eq(2).val().trim() );
	        
	        if ( $(this).find('td input').eq(2).val().trim().replace(/[^0-9.]/g, '') != $(this).find('td input').eq(2).val().trim() ) {
	        	toastr.warning("잘못된 형식의 데이터가 있습니다.<br>다시 확인해주세요.");
				$(this).find('td input').eq(2).attr('disabled', false);
	        	$(this).find('td input').eq(2).focus();
	        	check = false;
	        	return false;
	        } 
	        
	     	// 소수점 이하 3자리를 넘는 경우
	        if ($(this).find('td input').eq(2).val().trim().includes('.') && $(this).find('td input').eq(2).val().trim().split('.')[1].length > 3) {
	        	toastr.warning("잘못된 형식의 데이터가 있습니다.<br>다시 확인해주세요.");
				$(this).find('td input').eq(2).attr('disabled', false);
	        	$(this).find('td input').eq(2).focus();
	        	check = false;
	        	return false;
	        } else if (isNaN(inputValue)) {
	        	toastr.warning("잘못된 형식의 데이터가 있습니다.<br>다시 확인해주세요.");
				$(this).find('td input').eq(2).attr('disabled', false);
	        	$(this).find('td input').eq(2).focus();
	        	check = false;
	        	return false;
	        }
	        
	        rowData.menuAuth		= menuAuth;
	        rowData.lotNo			= $(this).find('td input').eq(1).val().trim();
	        rowData.thicknessQty	= parseFloat( $(this).find('td input').eq(2).val().trim() );
	        dataArray.push(rowData);
    	});
		//데이터 담아주는 부분
		
		
		//도금두께 저장 처리
		if(check == true) {
			dataArray = [...new Set(dataArray.map(JSON.stringify))].map(JSON.parse);	//중복제거
			$('#my-spinner').show();
			
			$.ajax({
				url: '<c:url value="/io/shipReportsPlatedCreate"/>',
		        type: 'POST',
		        datatype: 'json',
		        //async : true,
		        data: JSON.stringify(dataArray),
		        contentType : "application/json; charset=UTF-8",
		        success: function(result) {
		        	
			        let traceData = result.data;
			        
			        if (result.result == "ok") {
		      			toastr.success('저장 되었습니다.');
		        	} else {
		        		toastr.error(result.message, '', {timeOut: 5000});
		        	}
		        },
				complete:function(){
					$('#my-spinner').hide();
				}
	      	});
		}
		//도금두께 저장 처리
	});
	
</script>

</body>
</html>

