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
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재 입고요청(가입고)</li>
			</ol>
		</nav>
	</header> 
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card">
					<!-- title and toolbar -->
					<c:if test="${not empty error}">
						<div class="alert alert-danger" role="alert">${error}</div>
					</c:if>
					<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
						<button type="button" class="btn btn-primary float-left mr-1" id="checkDelete">체크 삭제</button>
	    		 		&nbsp;
	    		 		<button type="button" class="btn btn-primary float-left mr-1" id="addRow">입력</button>
	    		 		&nbsp;
	    		 		<select class="custom-select d-none" id="selectFactoryCode" disabled></select>
	    		 		<label id="labelFactoryCode"></label>
	    		 		
						<label for="btnExcelUpload" class="btn btn-success float-right ml-1"> 엑셀업로드 </label>
						<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />
						
						&nbsp;
						<a href="" id="basicFrom">
							<button type="button" class="btn btn-secondary float-right" style="border: solid 1px blue;">기본양식다운로드</button>
						</a>
						&nbsp;
						<button type="button" class="btn btn-primary float-right mr-1" id="btnSave">저장</button>
						&nbsp;
						<button type="button" class="btn btn-primary float-right mr-1" id="btnClear">초기화</button>
					</form>
				</div>
				<!-- .table-responsive -->
				<div class="table-responsive d-none" id="inDiv">			
					<table id="inTable" class="table table-bordered" style="text-align: center">
						<thead class="thead-light">
							<tr>
								<th style="width: 3.5%"><input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10px"></th>
								<th>S-Lot</th>
								<th style="width: 11%">LOT NO</th>
								<th class='d-none'>자재코드2</th>
								<th>자재코드</th>
								<th style="width: 15.8%">자재명</th>
								<th>입고량</th>
								<th>길이</th>
								<th>업체코드</th>
								<th>공급업체</th>
								<th class='d-none'>가입고일2</th>
								<th>가입고일</th>
								<th>Barcode NO</th>
								<th>비고</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
				
				<!-- .table-responsive -->
				<div class="table-responsive d-none" id="inDiv_F3">
					<table id="inTable_F3" class="table table-bordered" style="text-align: center">
						<thead class="thead-light">
							<tr>
								<th style="width: 3.5%"><input type="checkbox" id="checkAll_F3" name="checkAll_F3" style="min-width: 10px"></th>
								<th>가입고일</th>
								<th>유수명</th>
								<th>표면처리일</th>
								<th>구매</th>
								<th>위치</th>
								<th>비고1</th>
								<th>자재코드(재질)</th>
								<th>Lot(motherRoll)</th>
								<th>LotNo</th>
								<th>규격</th>
								<th>롤수</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
				
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0010';
	let currentHref = 'iosc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","자재 입고요청(가입고)");


	//공통코드 처리 시작
	var factoryCd=new Array();	//승인여부
    <c:forEach items="${factoryCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdAbbr}";
		factoryCd.push(json);
    </c:forEach>
    //공통코드 처리 종료
    
	var factoryCode = "<%=factoryCode%>";
	selectBoxAppend(factoryCd, "selectFactoryCode", factoryCode, "2");

	$('#labelFactoryCode').text($("#selectFactoryCode option:selected").text());

	if(factoryCode == '001'){
		//1공장 코드
		$('#inDiv').removeClass('d-none');
		$('#inDiv_F3').addClass('d-none');
		$('#basicFrom').attr('href', 'io/matrlInWhsRqtBasicForm');
	}else if(factoryCode == '002'){
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}else if(factoryCode == '003'){
		//3공장 코드
		$('#inDiv').addClass('d-none');
		$('#inDiv_F3').removeClass('d-none');
		$('#basicFrom').attr('href', 'io/matrlInWhsRqtBasicForm_F3');
	}
	else{
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}

	var url = "";
	//초기화 버튼
    $('#btnClear').on('click', function(){ 
    	if(factoryCode == '001'){
    		$('#inTable').DataTable().ajax.reload();
        	$('#btnExcelUpload').val("");
        	toastr.success("초기화 되었습니다. 파일을 다시 선택해주세요");
    	}
    	else if(factoryCode == '002'){
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    	else if(factoryCode == '003'){
    		$('#inTable_F3').DataTable().ajax.reload();
        	$('#btnExcelUpload').val("");
        	toastr.success("초기화 되었습니다. 파일을 다시 선택해주세요");
    	}
    	else{
    		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
    	}
    });


    $.fn.dataTable.ext.errMode = 'none';
	let inTable = $('#inTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	        	'filename' : url,
	        }		       
	    },
	    columns: [
	    	{ 
	    		render: function(data, type, row, meta) {    			
					return '<input type="checkbox"  name="chk">' ;
	    		}
			},
	    	{ 
	    		render: function(data, type, row, meta) {	
	    			if(row['srLot'] != null && row['srLot'] != "false") {
	    				return '<input type="type" id="srLotId" class="form-control" style="border:0px; max-width:100%;" name="srLotId" disabled value="'+row['srLot'] + '">';
	    			} else {
						return '<input type="text" id="srLotId" class="form-control" name="srLotId" value=""  style="max-width:100%;">' ;
	    			}
	    		}
			},		    	
	    	{ data: 'lotNo',
	    		render: function(data, type, row, meta) {
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="lotNoId" class="form-control" style="border:0px; max-width:100%;" name="lotNoId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="lotNoId" class="form-control" name="lotNoId" value="" style="max-width:100%;">' ;
	    			}
	    		}
			},
	    	{ data: 'matrlCd',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type"  id="matrlCdId" class="form-control" style="border:0px; max-width:100%;" name="matrlCdId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="matrlCdId" class="form-control" name="matrlCdId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'matrlNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="matrlNmId" class="form-control" style="border:0px; max-width:100%;" name="matrlNmId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="matrlNmId" class="form-control" name="matrlNmId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},	    	
	    	{ data: 'preInWhsQty',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="preInWhsQty" class="form-control" style="border:0px; max-width:100%;" name="preInWhsQty" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="preInWhsQty" class="form-control" name="preInWhsQty" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'inWhsLength',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="inWhsLength" class="form-control" style="border:0px; max-width:100%;" name="inWhsLength" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="inWhsLength" class="form-control" name="inWhsLength" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'spplyDealCorpCd',
	    		render: function(data, type, row, meta) {			    			
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="spplyDealCorpCd" class="form-control" style="border:0px; max-width:100%;" name="spplyDealCorpCd" disabled value="'+ pad(data, 5) + '">';
	    				//pad(data, 5);
	    			} else {
						return '<input type="text" id="spplyDealCorpCd" class="form-control" name="spplyDealCorpCd" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'spplyDealCorpNm',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="spplyDealCorpNm" class="form-control" style="border:0px; max-width:100%;" name="spplyDealCorpNm" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="spplyDealCorpNm" class="form-control" name="spplyDealCorpNm" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'preInWhsDate',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="preInWhsDateId" class="form-control" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="preInWhsDateId" class="form-control" name="preInWhsDateId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'barcodeNo',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="barcodeNoId" class="form-control" style="border:0px; max-width:100%;" name="barcodeNoId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="barcodeNoId" class="form-control" name="barcodeNoId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	},
	    	{ data: 'inWhsDesc',
	    		render: function(data, type, row, meta) {	
	    			if(data != null && data != "false") {
	    				return '<input type="type" id="inWhsDescId" class="form-control" style="border:0px; max-width:100%;" name="inWhsDescId" disabled value="'+ data + '">';
	    			} else {
						return '<input type="text" id="inWhsDescId" class="form-control" name="inWhsDescId" value="" style="max-width:100%;">' ;
	    			}
	    		}
	    	}
	    ],
	    columnDefs: [
	    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center"
	    	}		    	
	    ],
	    initComplete: function( settings, json ) {
	    	//var html1 =  '&nbsp; <button type="button" class="btn btn-primary" id="checkDelete">체크 삭제</button>';
	 		//var html2 =  '&nbsp;  &nbsp; <button type="button" class="btn btn-primary" id="addRow">입력</button>';
	 	    //
			//$('#inTable_length').html(html1 + html2);
			//$('#checkDelete').on('click', function(){
			//	var checkRows = $("[name='chk']:checked");	                    
			//	var tb = $('#inTable').DataTable();
			//	for(var i = checkRows.length-1; i > -1; i--){	                    	
			//	  	checkRows.eq(i).closest('tr').addClass('selected');
			//	  }
			//	  tb.rows('.selected').remove().draw(false);
			//  });
			//  $('#addRow').on('click',function(){
			//  	$('#inTable').DataTable().row.add({}).draw(false);
			//  });
			//  $('#inTable_filter').css('margin','10px');
	    }
	    /*	     
        buttons: [
       	 	{
            	text: '체크 삭제',
                action: function ( e, dt, node, config ) {
                    var checkRows = $("[name='chk']:checked");	                    
                    var tb = $('#inTable').DataTable();
                    for(var i = checkRows.length-1; i > -1; i--){	                    	
                    	checkRows.eq(i).closest('tr').addClass('selected');
                    }
                    tb.rows('.selected').remove().draw(false);
                                       
                }		            	
	        },
            {
                text: '입력',
                action: function ( e, dt, node, config ) {
                	$('#inTable').DataTable().row.add({}).draw(false);                    
                }
            },	            
        ]
       	*/
	});

	//제 3공장 관련 테이블
	 $.fn.dataTable.ext.errMode = 'none';
		let inTable_F3 = $('#inTable_F3').on( 'error.dt', function ( e, settings, techNote, message ) {
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
		        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
		        type: 'GET',
		        data: {
		        	'menuAuth'	 	: menuAuth,
		        	'filename'		: url,
		        }		       
		    },
		    columns: [
		    	{ 
		    		render: function(data, type, row, meta) {    			
						return '<input type="checkbox"  name="chk_F3">' ;
		    		}
				},
		    	{ 
		    		render: function(data, type, row, meta) {	
		    			if(row['preInWhsDate'] != null && row['preInWhsDate'] != "false") {
		    				return '<input type="type" id="preInWhsDateId" class="form-control" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+row['preInWhsDate'] + '">';
		    			} else {
							return '<input type="text" id="preInWhsDateId" class="form-control" name="preInWhsDateId" value=""  style="max-width:100%;">' ;
		    			}
		    		}
				},		    	
		    	{ data: 'lifeTime',
		    		render: function(data, type, row, meta) {
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="lifeTimeId" class="form-control" style="border:0px; max-width:100%;" name="lifeTimeId" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="lifeTimeId" class="form-control" name="lifeTimeId" value="" style="max-width:100%;">' ;
		    			}
		    		}
				},
		    	{ data: 'surfaceDate',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type"  id="surfaceDateId" class="form-control" style="border:0px; max-width:100%;" name="surfaceDateId" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="surfaceDateId" class="form-control" name="surfaceDateId" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'data1',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="data1Id" class="form-control" style="border:0px; max-width:100%;" name="data1Id" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="data1Id" class="form-control" name="data1Id" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},	    	
		    	{ data: 'data2',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="data2" class="form-control" style="border:0px; max-width:100%;" name="data2" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="data2" class="form-control" name="data2" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'inWhsDesc',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="inWhsDesc" class="form-control" style="border:0px; max-width:100%;" name="inWhsDesc" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="inWhsDesc" class="form-control" name="inWhsDesc" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'matrlcd',
		    		render: function(data, type, row, meta) {			    			
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="matrlcd" class="form-control" style="border:0px; max-width:100%;" name="matrlcd" disabled value="'+ pad(data, 5) + '">';
		    				//pad(data, 5);
		    			} else {
							return '<input type="text" id="matrlcd" class="form-control" name="matrlcd" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'motherRollLot',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="motherRollLot" class="form-control" style="border:0px; max-width:100%;" name="motherRollLot" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="motherRollLot" class="form-control" name="motherRollLot" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'motherRollLotNo',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="motherRollLotNoId" class="form-control" style="border:0px; max-width:100%;" name="motherRollLotNoId" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="motherRollLotNoId" class="form-control" name="motherRollLotNoId" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'standard',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="standardId" class="form-control" style="border:0px; max-width:100%;" name="standardId" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="standardId" class="form-control" name="standardId" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	},
		    	{ data: 'rollCount',
		    		render: function(data, type, row, meta) {	
		    			if(data != null && data != "false") {
		    				return '<input type="type" id="rollCountId" class="form-control" style="border:0px; max-width:100%;" name="rollCountId" disabled value="'+ data + '">';
		    			} else {
							return '<input type="text" id="rollCountId" class="form-control" name="rollCountId" value="" style="max-width:100%;">' ;
		    			}
		    		}
		    	}
		    ],
		    columnDefs: [
		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center"
		    	}		    	
		    ],
		});


	//롤수 숫자만 입력하게 처리_F3
	$(document).on('keyup',"input[name=rollCountId]", function(event){
		var preInWhsQtyData = $(this).val();
		if (!((event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46)) {
			$('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); 
			toastr.warning('숫자만 입력해주세요.');
			$(this).val("");
			$(this).select();
			event.preventDefault();
			return false;
		}
		$(this).val(addCommas(uncomma($(this).val())));
	}); 
		
	
    //저장 버튼
	$('#btnSave').on('click', function(){
		if(factoryCode == '001'){
	    	var dataArray = new Array();
	    	var check=true;

	    	//코드 중복 검사
			for(var i=0; i<$('#inTable tbody tr').length; i++){
				var checkVal = $('#inTable tbody tr').eq(i).find('td').eq(2).find('input').val();
				for(var k=(i+1); k<$('#inTable tbody tr').length; k++){
					if(checkVal == $('#inTable tbody tr').eq(k).find('td').eq(2).find('input').val()){
						toastr.warning((i+1)+"번째, "+(k+1)+"번째 LotNo 값이 중복됩니다. <br> 중복된 값은 '"+checkVal+"' 입니다.");
						check=false;
						return false;
					}
				}
			}

	    	$('#inTable tbody tr').each(function(){
		        var rowData = new Object();	        
		        //if($(this).find('td input').eq(1).val() == ""){
		        //	toastr.warning("S-Lot를 입력해주십시오.");
		        //	$(this).find('td input').eq(1).focus();	
		        //	check=false;
		        //	return false;
		        //}
		        if($(this).find('td input').eq(2).val() == ""){
		        	toastr.warning("LOT NO를 입력해주십시오.");
		        	$(this).find('td input').eq(2).focus();
		        	check=false;
		        	return false;
		        }	        
		        if($(this).find('td input').eq(3).val() == ""){
		        	toastr.warning("자재코드를 입력해주십시오.");
		        	$(this).find('td input').eq(3).focus();
		        	check=false;
		        	return false;
		        }       
		        if($(this).find('td input').eq(5).val() == ""){
		        	toastr.warning("입고량을 입력해주십시오.");
		        	$(this).find('td input').eq(5).focus();
		        	check=false;
		        	return false;
		        }
		        //if($(this).find('td input').eq(6).val() == ""){
		        //	toastr.warning("길이를 입력해주십시오.");
		        //	$(this).find('td input').eq(6).focus();
		        //	check=false;
		        //	return false;
		        //}
		        if($(this).find('td input').eq(7).val() == ""){
		        	toastr.warning("업체코드를 입력해주십시오.");
		        	$(this).find('td input').eq(7).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(9).val() == ""){
		        	toastr.warning("가입고일을 입력해주십시오.");
		        	$(this).find('td input').eq(9).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(9).val().length != 10){
		        	toastr.warning("가입고일을 정확히 입력해주십시오.");
		        	$(this).find('td input').eq(9).focus();
		        	check=false;
		        	return false;
		        }
				if($(this).find('td input').eq(10).val() == ""){
				   if($(this).find('td input').eq(3).val().substring(0,1) != "F"){
						toastr.warning("Barcode No를 입력해주십시오.");
	        			$(this).find('td input').eq(10).focus();
			        	check=false;
			        	return false;
		    	   }
		        }

				rowData.menuAuth		= menuAuth;
		        rowData.srLot			= $(this).find('td input').eq(1).val();	//S-Lot
		        rowData.lotNo 			= $(this).find('td input').eq(2).val();	//LOT-NO
		        rowData.matrlCd 		= $(this).find('td input').eq(3).val(); //자재코드
		        rowData.matrlNm 		= $(this).find('td input').eq(4).val(); //자재명
		        rowData.preInWhsQty 	= $(this).find('td input').eq(5).val();	//입고량
		        rowData.inWhsLength 	= $(this).find('td input').eq(6).val(); //길이
		        rowData.spplyDealCorpCd	= $(this).find('td input').eq(7).val();	//업체코드
		        rowData.spplyDealCorpNm	= $(this).find('td input').eq(8).val();	//공급업체
		        rowData.preInWhsDate	= $(this).find('td input').eq(9).val().replace(/-/g, '');	//가입고일

		        //바코드No
		        rowData.barcodeNo		= ($(this).find('td input').eq(10).val()==null||$(this).find('td input').eq(10).val()=='')?'':$(this).find('td input').eq(10).val();
		        //rowData.barcodeNo		= $(this).find('td input').eq(10).val();
		        rowData.inWhsDesc		= $(this).find('td input').eq(11).val();	//비고
		        
		        dataArray.push(rowData);
	    	});
			
			if(check == true){
				$('#my-spinner').show();

				/*//array가 빠져나갈때마다 값 변경되게 설정
				var countA = 0;	//for문 돌리 값
				var totalB = 0;	//sudelArray에 들어간 값
				var sudel = new Array();	//전체 값을 나눠서 저장 시켜줌
				
				countA = dataArray.length;
				
				for(var t=0; t < countA; t++){
					//자재코드가 일치하는 항목만 다시 sudelAttay에 값을 넣어줌

					sudel[t] = new Array();
			        
					for(var i=0; i < dataArray.length; i++){
						 if(i != parseInt(dataArray.length-1)){
							var xSum = parseInt(i+1);
						}
						if(dataArray[i].matrlCd == dataArray[xSum].matrlCd){
							sudel[t].push(dataArray[i]);
						} else {
							sudel[t].push(dataArray[i]);
							break;
						}
					}
					console.log("↓↓↓↓ sudel["+t+"] 값 확인 하는 부분 ↓↓↓↓");
					console.log(sudel[t]);
					dataArray.splice(0, sudel[t].length);	//저장 시킨 데이터가 있으면 재배열로 담아줬던 길이 만큼 삭제 시켜준다.
					console.log("↓↓↓↓ 지워지고 있는 dataArray 값 확인 하는 부분 ↓↓↓↓");
					console.log(dataArray);
					totalB = sudel[t].length;
					countA = parseInt(countA-totalB);	//돌리 값을 다시 재정이 해줌.
					console.log("countA : "+countA);
				}
			
			console.log("↓↓↓↓ sudel 전체 값 확인 하는 부분 ↓↓↓↓");
			console.log(sudel);*/

			setTimeout(function(){
				$.ajax({
					url: '<c:url value="/io/matrlInWhsRqtSaveDataList"/>',
			        type: 'POST',
			        datatype: 'json',
			        async : false,
			        data: JSON.stringify(dataArray),
			        contentType : "application/json; charset=UTF-8",
			        success: function(result){
				        if(result.result == "ok"){
					        var table = $('#inTable').DataTable(); 		
			      			table.clear().draw();
			      			$('#btnExcelUpload').val("");
			      			toastr.success('저장되었습니다.');
			        	} else if(result.result == "fail"){
			        		toastr.error(result.message, '', {timeOut: 5000});
			        	}
			        	else{
			        		toastr.error(result.message, '', {timeOut: 5000});
			        	}
			        },
					complete:function(){
						$('#my-spinner').hide();
					}
		      	});
			}, 100);
		}
	    	
	       	/*for(j = 1; j < $('#inTable tr').length; j++){
	       		
	       		var rowData = new Object();
	       		if($('#inTable tr:nth-child('+ j + ') td:nth-child(' + 2 + ')').text() != ""){	    
		       		rowData.srLot 			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 2 + ')').text();
		        	rowData.lotNo 			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 3 + ')').text();
		        	rowData.matrlCd			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 4 + ')').text();
		        	rowData.matrlNm			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 5 + ')').text();
		        	rowData.preInWhsQty 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 6 + ')').text();
		        	rowData.inWhsLength 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 7 + ')').text();	
		        	rowData.spplyDealCorpCd = $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 8 + ')').text();	
		        	rowData.spplyDealCorpNm = $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 9 + ')').text();	
		        	rowData.preInWhsDate 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 10 + ')').text();
		        	rowData.barcodeNo 		= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 11 + ')').text();	
		        	rowData.inWhsDesc 		= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 12 + ')').text();	
		        	
	       		} else{
	       			rowData.srLot 			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 2 + ') input').val();
		        	rowData.lotNo 			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 3 + ') input').val();
		        	rowData.matrlCd			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 4 + ') input').val();
		        	rowData.matrlNm			= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 5 + ') input').val();
		        	rowData.preInWhsQty 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 6 + ') input').val();
		        	rowData.inWhsLength 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 7 + ') input').val();
		        	rowData.spplyDealCorpCd = $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 8 + ') input').val();
		        	rowData.spplyDealCorpNm = $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 9 + ') input').val();
		        	rowData.preInWhsDate 	= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 10 + ') input').val();
		        	rowData.barcodeNo 		= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 11 + ') input').val();
		        	rowData.inWhsDesc 		= $('#inTable tr:nth-child('+ j + ') td:nth-child(' + 12 + ') input').val();   
	       			
	       		}
	        	dataArray.push(rowData);
	       	} */
		}else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}else if(factoryCode == '003'){
			//3공장 코드
			var dataArray = new Array();
	    	var check=true;   

	    	//코드 중복 검사
			for(var i=0; i<$('#inTable_F3 tbody tr').length; i++){
				var checkVal = $('#inTable_F3 tbody tr').eq(i).find('td').eq(9).find('input').val();
				for(var k=(i+1); k<$('#inTable_F3 tbody tr').length; k++){
					if(checkVal == $('#inTable_F3 tbody tr').eq(k).find('td').eq(9).find('input').val()){
						toastr.warning((i+1)+"번째, "+(k+1)+"번째 LotNo 값이 중복됩니다. <br> 중복된 값은 '"+checkVal+"' 입니다.");
						check=false;
						return false;
					}
				}
			}
	    	
	    	$('#inTable_F3 tbody tr').each(function(){
		        var rowData = new Object();
		        if($(this).find('td input').eq(1).val() == ""){
		        	toastr.warning("가입고일을 입력해주십시오.");
		        	$(this).find('td input').eq(1).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(1).val().length != 10){
		        	toastr.warning("가입고일을 정확히 입력해주십시오.");
		        	$(this).find('td input').eq(1).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(2).val() == ""){
		        	toastr.warning("유수명을 입력해주십시오.");
		        	$(this).find('td input').eq(2).focus();
		        	check=false;
		        	return false;
		        }	        
		        if($(this).find('td input').eq(3).val() == ""){
		        	toastr.warning("표면처리일 입력해주십시오.");
		        	$(this).find('td input').eq(3).focus();
		        	check=false;
		        	return false;
		        }       
		        if($(this).find('td input').eq(4).val() == ""){
		        	toastr.warning("구매를 입력해주십시오.");
		        	$(this).find('td input').eq(4).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(5).val() == ""){
		        	toastr.warning("위치를 입력해주십시오.");
		        	$(this).find('td input').eq(5).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(7).val() == ""){
		        	toastr.warning("자재코드(재질)를 입력해주십시오.");
		        	$(this).find('td input').eq(7).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(8).val() == ""){
		        	toastr.warning("Lot(motherRoll)을 입력해주십시오.");
		        	$(this).find('td input').eq(8).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(9).val() == ""){
		        	toastr.warning("LotNo 입력해주십시오.");
		        	$(this).find('td input').eq(9).focus();
		        	check=false;
		        	return false;
		        }
		        if($(this).find('td input').eq(10).val() == ""){
		        	toastr.warning("규격을 입력해주십시오.");
		        	$(this).find('td input').eq(10).focus();
		        	check=false;
		        	return false;
		        }
		        /*if($(this).find('td input').eq(13).val() == ""){
		        	toastr.warning("롤수를 입력해주십시오.");
		        	$(this).find('td input').eq(13).focus();
		        	check=false;
		        	return false;
		        }*/

		        //담아주는 값
		        rowData.menuAuth		= menuAuth;
		        rowData.preInWhsDate	= $(this).find('td input').eq(1).val().replace(/-/g, '');	//가입고일
		        rowData.lifeTime		= $(this).find('td input').eq(2).val();						//유수명
		        rowData.surfaceDate		= $(this).find('td input').eq(3).val();						//표면처리일
		        rowData.data1			= $(this).find('td input').eq(4).val();						//구매
		        rowData.data2			= $(this).find('td input').eq(5).val();						//위치
		        rowData.inWhsDesc		= $(this).find('td input').eq(6).val();						//비고
		        rowData.matrlCd			= $(this).find('td input').eq(7).val();						//자재코드(재질)
		        rowData.motherRollLot	= $(this).find('td input').eq(8).val();						//Lot(motherRoll)
		        rowData.motherRollLotNo	= $(this).find('td input').eq(9).val();						//LotNo
		        rowData.standard		= $(this).find('td input').eq(10).val();					//규격
// 		        rowData.rollCount		= $(this).find('td input').eq(11).val();					//롤수

		        if($(this).find('td input').eq(11).val() == ""){
		        	rowData.rollCount	= '1';														//롤수
		        }else{
		        	rowData.rollCount	= $(this).find('td input').eq(11).val();					//롤수
				}
		        
		        dataArray.push(rowData);
	    	});
			
			if(check == true){
				$('#my-spinner').show();

				setTimeout(function(){
					$.ajax({
						url: '<c:url value="/io/matrlInWhsRqtSaveDataList_F3"/>',
				        type: 'POST',
				        datatype: 'json',
				        async : false,
				        data: JSON.stringify(dataArray),
				        contentType : "application/json; charset=UTF-8",
				        success: function(result){
					        if(result.result == "ok"){
						        var table = $('#inTable_F3').DataTable(); 		
				      			table.clear().draw();
				      			$('#btnExcelUpload').val("");
				      			toastr.success('저장되었습니다.');
				        	} else if(result.result == "fail"){
				        		toastr.error(result.message, '', {timeOut: 5000});
				        	}
				        	else{
				        		toastr.error(result.message, '', {timeOut: 5000});
				        	}
				        },
						complete:function(){
							$('#my-spinner').hide();
						}
			      	});
				}, 100);
			}
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	});

    //주석 풀면 똑같은 파일을 다시 등록할 수 있다.  
// 	$('#btnExcelUpload').on('click', function(){
// 		$('#btnExcelUpload').val("");
// 	});
	
    //파일 선택
	$('#btnExcelUpload').change(function(){

		if(factoryCode == '001'){
			//1공장 코드
			var formData = new FormData($('#fileUploadForm')[0]);
			var str = $('#btnExcelUpload').val();
			//console.log(str.substring(str.lastIndexOf(".")+1));
			if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
				$.ajax({
			    	type: "POST",
			    	enctype: 'multipart/form-data',
			    	data: formData,
			    	url:'<c:url value="io/matrlInOutExcelUpload"/>',
			    	processData: false,
			    	contentType: false,
			    	cache: false,
			    	success: function (res) {
			    		if (res.result == 'ok') {
			    			url = res.data.url;
			    			let data = res.data;
			    			
							inTable = $('#inTable').DataTable({
				    		    language: lang_kor,
				    		    searching: false,
				    		    destroy: true,
				    		    paging: false,
				    		    info: true,		    
				    		    ordering: true,
				    		    processing: true,
				    		    autoWidth: false,
				    		    pageLength: false,		    		
				    		    'ajax' : {		    	
				    		        url: '<c:url value="/io/matrlInWhsRqtPopDataList"/>',
				    		        type: 'GET',
				    		        data: {
				    		        	'menuAuth'	 	: 		menuAuth,
				    		        	'filename'		:		url,
				    		        }		       
				    		    },
				    		    columns: [
				    		    	{ 
				    		    		render: function(data, type, row, meta) {    			
				    						return '<input type="checkbox"  name="chk" checked="checked">' ;
				    		    		}
				    				},
				    		    	{ 
				    		    		render: function(data, type, row, meta) {	
				    		    			if(row['srLot'] != null && row['srLot'] != "false") {
				    		    				return '<input type="type" id="srLotId" class="form-control text-center" style="border:0px; max-width:100%;" name="srLotId" disabled value="'+row['srLot'] + '">';
				    		    			} else {
				    							return '<input type="text" id="srLotId" class="form-control text-center" name="srLotId" value=""  style="max-width:100%;">' ;
				    		    			}
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
				    				},
				    				{ data: 'matrlCd', 'className' : 'd-none' },
				    		    	{ data: 'matrlCd' ,
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type"  id="matrlCdId" class="form-control text-center" style="border:0px; max-width:100%;" name="matrlCdId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="matrlCdId" class="form-control text-center" name="matrlCdId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'matrlNm',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="matrlNmId" class="form-control text-center" style="border:0px; max-width:100%;" name="matrlNmId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="matrlNmId" class="form-control text-center" name="matrlNmId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},	    	
				    		    	{ data: 'preInWhsQty',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="preInWhsQty" class="form-control text-right" style="border:0px; max-width:100%;" name="preInWhsQty" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="preInWhsQty" class="form-control text-right" name="preInWhsQty" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'inWhsLength',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="inWhsLength" class="form-control text-right" style="border:0px; max-width:100%;" name="inWhsLength" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="inWhsLength" class="form-control text-right" name="inWhsLength" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'spplyDealCorpCd',
				    		    		render: function(data, type, row, meta) {			    			
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="spplyDealCorpCd" class="form-control text-center" style="border:0px; max-width:100%;" name="spplyDealCorpCd" disabled value="'+ pad(data, 5) + '">';
				    		    				//pad(data, 5);
				    		    			} else {
				    							return '<input type="text" id="spplyDealCorpCd" class="form-control text-center" name="spplyDealCorpCd" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'spplyDealCorpNm',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="spplyDealCorpNm" class="form-control text-center" style="border:0px; max-width:100%;" name="spplyDealCorpNm" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="spplyDealCorpNm" class="form-control text-center" name="spplyDealCorpNm" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'preInWhsDate', 'className' : 'd-none' },
				    		    	{ data: 'preInWhsDate',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="preInWhsDateId" class="form-control text-center" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="preInWhsDateId" class="form-control text-center" name="preInWhsDateId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'barcodeNo',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="barcodeNoId" class="form-control text-center" style="border:0px; max-width:100%;" name="barcodeNoId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="barcodeNoId" class="form-control text-center" name="barcodeNoId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'inWhsDesc',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="inWhsDescId" class="form-control text-center" style="border:0px; max-width:100%;" name="inWhsDescId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="inWhsDescId" class="form-control text-center" name="inWhsDescId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	}
				    		    ],
				    		    order : [
					    		    [3, 'desc'], [10, 'asc']
								],
				    		    columnDefs: [
				    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
				    		    ],
				    		    initComplete: function( settings, json ) {
				    		    	$("#checkAll").prop("checked",true); 
				    		    	//var html1 =  '&nbsp; <button type="button" class="btn btn-primary" id="checkDelete">체크 삭제</button>';
				    		 		//var html2 =  '&nbsp;  &nbsp; <button type="button" class="btn btn-primary" id="addRow">입력</button>';
				    		 	    //
									//$('#inTable_length').html(html1 + html2);
									//$('#checkDelete').on('click', function(){
									//	var checkRows = $("[name='chk']:checked");	                    
									//	var tb = $('#inTable').DataTable();
									//	for(var i = checkRows.length-1; i > -1; i--){	                    	
									//	  	checkRows.eq(i).closest('tr').addClass('selected');
									//	  }
									//	  tb.rows('.selected').remove().draw(false);
									//  });
									//  $('#addRow').on('click',function(){
									//  	$('#inTable').DataTable().row.add({}).draw(false);
									//  });
									//  $('#inTable_filter').css('margin','10px');
				    		    }
	
				    		    /*	     
				    	        buttons: [
				            	 	{
				    	            	text: '체크 삭제',
				    	                action: function ( e, dt, node, config ) {
				    	                    var checkRows = $("[name='chk']:checked");	                    
				    	                    var tb = $('#inTable').DataTable();
				    	                    for(var i = checkRows.length-1; i > -1; i--){	                    	
				    	                    	checkRows.eq(i).closest('tr').addClass('selected');
				    	                    }
				    	                    tb.rows('.selected').remove().draw(false);
				    	                                       
				    	                }		            	
				    		        },
				    	            {
				    	                text: '입력',
				    	                action: function ( e, dt, node, config ) {
				    	                	$('#inTable').DataTable().row.add({}).draw(false);                    
				    	                }
				    	            },	            
				    	        ]
					        	*/
					        });
			    		} else if (res.result == 'fail') {
			    			toastr.warning(res.message, '', {timeOut: 5000});
			    		} else if (res.result == 'error') {
			    			toastr.error(res.message, '', {timeOut: 5000});
			    		}
					},
				});
			} else {
				toastr.warning("Excel파일을 선택해 주세요.");
				return false;
			}
		}
		else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
		else if(factoryCode == '003'){
			//3공장 코드
			var formData = new FormData($('#fileUploadForm')[0]);
			var str = $('#btnExcelUpload').val();
// 			console.log(str.substring(str.lastIndexOf(".")+1));
			if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
				$.ajax({
			    	type: "POST",
			    	enctype: 'multipart/form-data',
			    	data: formData,
			    	url:'<c:url value="io/matrlInOutExcelUpload"/>',
			    	processData: false,
			    	contentType: false,
			    	cache: false,
			    	success: function (res) {
			    		if (res.result == 'ok') {
			    			url = res.data.url;
			    			let data = res.data;
							inTable_F3 = $('#inTable_F3').DataTable({
				    		    language: lang_kor,
				    		    searching: false,
				    		    destroy: true,
				    		    paging: false,
				    		    info: true,		    
				    		    ordering: true,
				    		    processing: true,
				    		    autoWidth: false,
				    		    pageLength: false,		    		
				    		    'ajax' : {
				    		        url: '<c:url value="/io/matrlInWhsRqtPopDataList_F3"/>',
				    		        type: 'GET',
				    		        data: {
				    		        	'menuAuth'	 	: 		menuAuth,
				    		        	'filename'		:		url,
				    		        }		       
				    		    },
				    		    columns: [
				    		    	{
				    		    		render: function(data, type, row, meta) {    			
				    						return '<input type="checkbox"  name="chk_F3" checked="checked">' ;
				    		    		}
				    				},
				    		    	{
				    		    		render: function(data, type, row, meta) {	
				    		    			if(row['preInWhsDate'] != null && row['preInWhsDate'] != "false") {
				    		    				return '<input type="type" id="preInWhsDateId" class="form-control text-center" style="border:0px; max-width:100%;" name="preInWhsDateId" disabled value="'+row['preInWhsDate'] + '">';
				    		    			} else {
				    							return '<input type="text" id="preInWhsDateId" class="form-control text-center" name="preInWhsDateId" value=""  style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    				},		    	
				    		    	{ data: 'lifeTime',
				    		    		render: function(data, type, row, meta) {
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="lifeTimeId" class="form-control text-center" style="border:0px; max-width:100%;" name="lifeTimeId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="lifeTimeId" class="form-control text-center" name="lifeTimeId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    				},
// 				    				{ data: 'matrlCd', 'className' : 'd-none' },	
				    		    	{ data: 'surfaceDate' ,
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type"  id="surfaceDateId" class="form-control text-center" style="border:0px; max-width:100%;" name="surfaceDateId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="surfaceDateId" class="form-control text-center" name="surfaceDateId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'data1',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="data1Id" class="form-control text-center" style="border:0px; max-width:100%;" name="data1Id" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="data1Id" class="form-control text-center" name="data1Id" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},	    	
				    		    	{ data: 'data2',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="data2" class="form-control text-center" style="border:0px; max-width:100%;" name="data2" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="data2" class="form-control text-center" name="data2" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'inWhsDesc',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="inWhsDesc" class="form-control text-right" style="border:0px; max-width:100%;" name="inWhsDesc" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="inWhsDesc" class="form-control text-right" name="inWhsDesc" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'matrlCd',
				    		    		render: function(data, type, row, meta) {			    			
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="matrlCd" class="form-control text-center" style="border:0px; max-width:100%;" name="matrlCd" disabled value="'+ pad(data, 5) + '">';
				    		    				//pad(data, 5);
				    		    			} else {
				    							return '<input type="text" id="matrlCd" class="form-control text-center" name="matrlCd" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'motherRollLot',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="motherRollLot" class="form-control text-center" style="border:0px; max-width:100%;" name="motherRollLot" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="motherRollLot" class="form-control text-center" name="motherRollLot" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
// 				    		    	{ data: 'preInWhsDate', 'className' : 'd-none' },
				    		    	{ data: 'motherRollLotNo',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="motherRollLotNoId" class="form-control text-center" style="border:0px; max-width:100%;" name="motherRollLotNoId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="motherRollLotNoId" class="form-control text-center" name="motherRollLotNoId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'standard',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="standardId" class="form-control text-center" style="border:0px; max-width:100%;" name="standardId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="standardId" class="form-control text-center" name="standardId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	},
				    		    	{ data: 'rollCount',
				    		    		render: function(data, type, row, meta) {	
				    		    			if(data != null && data != "false") {
				    		    				return '<input type="type" id="rollCountId" class="form-control text-center" style="border:0px; max-width:100%;" name="rollCountId" disabled value="'+ data + '">';
				    		    			} else {
				    							return '<input type="text" id="rollCountId" class="form-control text-center" name="rollCountId" value="" style="max-width:100%;">' ;
				    		    			}
				    		    		}
				    		    	}
				    		    ],
				    		    order : [
					    		    [3, 'desc'], [10, 'asc']
								],
				    		    columnDefs: [
				    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }
				    		    ],
				    		    initComplete: function( settings, json ) {
				    		    	$("#checkAll_F3").prop("checked",true); 
				    		    }
					        });
			    		} else if (res.result == 'fail') {
			    			toastr.warning(res.message, '', {timeOut: 5000});
			    		} else if (res.result == 'error') {
			    			toastr.error(res.message, '', {timeOut: 5000});
			    		}
					},
				});
			} else {
				toastr.warning("Excel파일을 선택해 주세요.");
				return false;
			}
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	}); 

    $('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}        
    });

    $('#checkAll_F3').on('click', function(){
		if($("#checkAll_F3").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}        
    });

  //checkBox디테일 설정
    $(document).on('click','input[name=chk]',function(e){
    	if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length){
    		$("#checkAll").prop("checked", true);
        }else{
        	$("#checkAll").prop("checked", false);
		}
	});

	//checkBox디테일 설정_F3
    $(document).on('click','input[name=chk_F3]',function(e){
    	if($('input:checkbox[name=chk_F3]:checked').length == $('input:checkbox[name=chk_F3]').length){
    		$("#checkAll_F3").prop("checked", true);
        }else{
        	$("#checkAll_F3").prop("checked", false);
		}
	});
	
	$('#checkDelete').on('click', function() {
		if(factoryCode == '001'){
			//신규코드
			$('#inTable tbody tr').each(function(){
		        if($(this).find('td input[name=chk]').is(':checked')){
		        	inTable.row(this).remove().draw();
		        }
			});
			$('#checkAll').prop('checked', false);
		}
		else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
		else if(factoryCode == '003'){
			$('#inTable_F3 tbody tr').each(function(){
		        if($(this).find('td input[name=chk_F3]').is(':checked')){
		        	inTable_F3.row(this).remove().draw();
		        }
			});
			$('#checkAll_F3').prop('checked', false);
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	});
	
	$('#addRow').on('click', function() {
		if(factoryCode == '001'){
			inTable.row.add({}).draw();
			$('#inTable_filter').css('margin', '10px');
			if($('input:checkbox[name=chk]:checked').length == $('input:checkbox[name=chk]').length){
	    		$("#checkAll").prop("checked", true);
	        }else{
	        	$("#checkAll").prop("checked", false);
			}
		}else if(factoryCode == '002'){
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}else if(factoryCode == '003'){
			$('#inTable_F3').DataTable().row.add({}).draw(false);
			$('#inTable_F3_filter').css('margin', '10px');
			if($('input:checkbox[name=chk_F3]:checked').length == $('input:checkbox[name=chk_F3]').length){
	    		$("#checkAll_F3").prop("checked", true);
	        }else{
	        	$("#checkAll_F3").prop("checked", false);
			}
		}
		else{
			toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
		}
	});
	
	//자릿수
	function pad(n, width) {
		n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}
</script>

</body>
</html>
