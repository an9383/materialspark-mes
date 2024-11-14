<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@ include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">

	<!-- 수정처리 -->
	<form id="checkModalForm" enctype="multipart/form-data">
	<div class="modal fade bs-example-modal-lg shadow-lg" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" data-keyboard="false">
	    <div class="modal-dialog modal-lg" role="document" style="overflow-y: max-height:85%;  margin-top: 3%;">
	        <div class="modal-content" style="width: 50%; margin-left: 90%; margin-top: 20%;">
	            <div class="modal-header">
	           		<h5 class="modal-title" id="">확인</h5>
	            </div>
	            <div class="modal-body">
			    	<h6>창고정보를 전체 수정하시겠습니까?</h6> 
			    </div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary btnCheckConfirm" id="btnY">수정</button>
	            	<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	            </div>
	        </div>
	    </div>
	</div>
	</form>
	<!--수정처리  -->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">일반자재관리</a></li>
				<li class="breadcrumb-item active">입고등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="width: 25%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn2" onclick="openrNav2()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="mainTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>발주번호</th>
									<th>거래처명</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>

			<!-- /.left-list -->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 74%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive" style="height: 410px;">
						<div class="card-body col-sm-12 pb-1">
							<button type="button" class="btn btn-primary float-right" id="btnAdd">등록</button>
<!-- 							<div class=""> -->
<!-- 								<label style="position: relative; bottom: 4px;">창고 값 전체 변경 여부</label> -->
<!-- 								<input type="checkBox" class="checkbox_sm" style="width: 18px; height: 18px;" id="allValueChange" checked> -->
<!-- 							</div> -->
						</div>
						<div style="overflow-y: auto;height: 320px;">
							<table id="individualAdmTable" class="table table-bordered">
								<colgroup>
									<col width="1%">
									<col width="2%">
									<col width="5%">
									<col width="5%">
									<col width="5%">
									<col width="3%">
									<col width="5%">
									<col width="5%">
									<col width="5%">
									<col width="5%">
									<col width="6%">
									<col width="5%">
									<col width="5%">
									<col width="5%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th><input type="checkbox" class="checkbox_sm" id="checkAll" disabled></th>
										<th>순번</th>
										<th>CODE</th>
										<th>ITEM</th>
										<th>SPEC</th>
										<th>단위</th>
										<th>발주수량</th>
										<th>입고수량</th>
										<th>미입고수량</th>
										<th>납기요청일</th>
										
										<th>개별입고일자</th>
										<th>입고수량</th>
										<th>창고코드</th>
										<th>비고</th>
									</tr>
								</thead>
							</table>
						</div>
							<br>
							<button type="button" class="btn btn-primary d-none float-right" id="btnSaveTo" onclick="saveSelect('001')">저장</button>
					</div>
					
					<div class="table-responsive" style="height: 355px">
						<div class="card-body col-sm-12 pb-1">
							<button type="button" class="btn btn-danger float-right mr-1"
								id="btnDel">삭제</button>
							<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
							<button type="button" class="btn btn-primary float-right mr-1"
								id="btnEdit">수정</button>
							<button class="btn btn-warning d-none" id="btnEditConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
<!-- 							<button type="button" class="btn btn-success float-left" -->
<!-- 								id="btnReset">초기화</button> -->
<!-- 							<button class="btn btn-primary d-none" id="btnAddConfirmLoading" -->
<!-- 								type="button" disabled> -->
<!-- 								<span class="spinner-border spinner-border-sm" role="status" -->
<!-- 									aria-hidden="true"></span> 처리중 -->
<!-- 							</button> -->
						</div>
						<div style="overflow-y: auto;height: 265px;">
							<table class="table table-lg table-bordered mb-2" id="individualDtlTable">
								<colgroup>
									<col width="2%">
									<col width="8%">
									<col width="7%">
									<col width="8%">
									<col width="9%">
									<col width="13%">
									<col width="5%">
									<col width="8%">
									<col width="7%">
									<col width="5%">
									<col width="8%">
									<col width="11%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>No.</th>
										<th>개별입고일자</th>
										<th>거래처</th>
										<th>CODE</th>
										<th>ITEM</th>
										<th>SPEC</th>
										<th>단위</th>
										<th class="text-center">입고수량</th>
										<th>바코드관리여부</th>
										<th>locationNo<br>(창고코드)</th>
										<th>비고</th>
										<th>LOT 번호 <br>/ 바코드번호</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="card-body col-sm-12 pb-1">
						<button type="button" class="btn btn-primary d-none float-right"
								id="btnSave" onclick="saveSelect('002')">저장</button>
							<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button>
						</div>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<!-- /.row -->
		</div>
		<!-- / #main  -->
	</div>
	<!-- /.page-wrapper -->
</div>
<%@include file="../layout/bottom.jsp" %>
<script>

	let currentHref = "mmsc0030";
	let currentPage = $('.' + currentHref).attr('id');
	
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');    
	$(document).attr("title","입고등록"); 
	
	let viewIdx;
	let sideView = '';
	let btnView = '';
	
	var tableIdx=null;
	var tableIdx2=null;
	var spplyCorpCdVal=null;
	var poNo;
	var poSeq;	
	var inSeq;
	var statusCd;
	var partCd;
	var notQty ='';
	
	var partQty;
	var index = 0;
	var sum=0;

	var cmd = new Array();
	var i = 0;

	let printArray = new Array();
	
	var serverDateFrom =  "${serverDateFrom}";
	var serverDateTo =  "${serverDateTo}";
	var inWhsDate =  "${serverDateTo}";
	
	$('input[name=preInWhsDate]').val(serverDateTo);
	
	//공통코드 처리 시작		
	var locationNoCode = new Array(); //창고번호
	<c:forEach items="${locationNo}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	json.etc1 = "${info.etc1}";
	json.etc2 = "${info.etc2}";
	locationNoCode.push(json);
	</c:forEach> 
	//공통코드 처리 끝		

	uiProc(true);

	//메인 목록조회
   	$.fn.dataTable.ext.errMode = 'none';
	let mainTable = $('#mainTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
    	dom:  "<'row'<l><'col-sm-12 col-md-7'>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange : true,
        pageLength : 10,
        ajax: {
            url: '<c:url value="mm/individualOrderAdmList"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	: function() { return serverDateFrom.replace(/-/g, ''); },
	           	'chooseDateTo'		: function() { return serverDateTo.replace(/-/g, ''); },
            },          
        },
        rowId: 'poNo',
        columns : [
			{ data : 'poNo'			},
			{ data : 'dealCorpNm' 	},
		],
		columnDefs: [],   
        order: [
            [1,'desc']
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	    drawCallback: function() {}
    });

	
	//메인 목록조회 행 선택
	$('#mainTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#mainTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');		
		}

		sideView = '';
		btnView = '';
		partCd='';
		
		poNo =  mainTable.row(this).data().poNo;
		spplyCorpCdVal =  mainTable.row(this).data().dealCorpCd;
		
		$("input[type=checkbox]").prop("checked",false);
		$('#individualAdmTable').DataTable().ajax.reload(function(){});
		$('#individualDtlTable').DataTable().ajax.reload(function(){});
		$('#btnSaveTo').addClass('d-none');
	});

	
	//상세 목록조회
   	$.fn.dataTable.ext.errMode = 'none';
   	let individualAdmTable = $('#individualAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
    	dom:  "<'row'<'col-sm-5 col-md-5'><'col-sm-12 col-md-7'>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange : true,
//         pageLength : 10,
        ajax: {
            url: '<c:url value="mm/individualOrderDtlList"/>',
            type: 'GET',
            data: {
	          	'poNo' : function(){ return poNo; }
            },          
        },
        rowId: 'poNo',
        columns : [
        	{ render: function(data, type, row, meta) {
					return '<input type="checkbox" class="checkbox_sm" id="checkLal-'+meta.row+'" name="checkLal" value="" disabled>';
				}, 'className' : 'text-center'
      		},
			{ data : 'poSeq'		},	//시퀀스
			{ data : 'partCd'		},	//CODE
			{ data : 'partNm'		},	//ITEM
			{ data : 'partSpec'		},	//SPEC
			{ data : 'partUnit'		},	//단위
			{ data : 'partQty'		, 'className' : 'text-right'	},	//발주수량
			{ data : 'preInWhsQty'	, 'className' : 'text-right'	},	//입고수량
			{ data : 'notQty'		, 'className' : 'text-right' 	},	//미입고량
			{ render: function(data, type, row) {
					return moment(row['dlvDate']).format('YYYY-MM-DD');
				}
			},
			{ render: function(data, type, row, meta) {		//개별입고일자
					html = '<div class="form-group input-sub m-0 row">';
					html += '<input class="form-control"  type="text" id="preInWhsDate'+index+'" name="preInWhsDate" disabled/>' 
	   				html += '<button onclick="fnPopUpCalendar(preInWhsDate'+index+',preInWhsDate'+index+',\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" name="preInWhsDateFromCalendar" type="button" disabled>';	
					html += '<span class="oi oi-calendar"></span></buton></div>';
	
					index++;
					return html;
				}		   
			},
			{ render: function(data, type, row, meta) {	//입고수량
					var html1 = '<input type="text" class="form-control" name="preInWhsQty" value="0" style="text-align:right;" disabled>';
					html1 += '<input type="hidden" class="form-control" name="notQty" value="'+row['notQty']+'" style="text-align:right;" disabled>' ;
    				return html1;
	    		}
			},
			{ render: function(data, type, row, meta) {		//창고코드
					var value = "";
					var html ="";
					html = selectBoxHtml2(locationNoCode, "locationNo", data, row, meta, "2");
					value += '<input type="hidden" name="locationCd"  disabled>';
					value += '<input type="hidden" name="areaCd"  disabled>';
					value += '<input type="hidden" name="floorCd"  disabled>';
	
					var html2 = '<div class="input-sub m-0">';
					html2 += value;
					html2 += html;
					html2 += '</div>';
					return html2;		
	    		}
			},
			{ render: function(data, type, row, meta) {		//비고
					return '<input type="text" class="form-control" name="inWhsDesc" value="" disabled>';	
	    		}
			},
		],
		columnDefs: [
			{ "targets": "_all", "className" : "text-center" },
// 			{ "targets": [6,7,8] , render: $.fn.dataTable.render.number(',')},
		],   
        order: [
            [1,'asc']
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	    drawCallback: function() {
		    if(tableIdx2!=null){
		    	$('#purchaseOrderTable tbody tr').eq(tableIdx2).addClass('selected');
		  		printArray = [];
			}
		}
    });

    var individualAdmTableIdx='';
	//상세 목록조회 행 선택
	$('#individualAdmTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#individualAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');		
		}
		
		partCd 	= individualAdmTable.row(this).data().partCd;
		poSeq 	= individualAdmTable.row(this).data().poSeq;
		inSeq 	= individualAdmTable.row(this).data().inSeq;
		notQty	= individualAdmTable.row(this).data().notQty;

		individualAdmTableIdx = $('#individualAdmTable').DataTable().row(this).index();

		$('#btnEdit').attr('disabled', false);
		$('#btnDel').attr('disabled', false);

// 		$('#btnSave').removeClass('d-none');
		$('#individualDtlTable').DataTable().ajax.reload();
		$('#btnSave').addClass('d-none');
		$('#btnAdd').attr('disabled', false);
		sideView = 'add';
	});
	

	// 세부목록
   	$.fn.dataTable.ext.errMode = 'none';
   	let individualDtlTable = $('#individualDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		if(techNote == 7) {
   			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
   			location.href = "/";
   		}
   	}).DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr> i>",
		language : lang_kor,
		destroy : true,
		paging : false,
		searching: false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		ajax : {
			url : '<c:url value="mm/preInWhsAdmList"/>',
			type : 'GET',
			data : {
				'poNo'		:  function(){ return poNo; },
				'partCd'	:  function(){ return partCd; },
			},
		},
		columns : [
			
			{ render: function(data, type, row, meta) {
					return meta.row+1;
				}, 'className' : 'text-center'
			},
			{ data : 'preInWhsDate',
				render: function(data, type, row, meta) {
						html = '<div class="form-group input-sub m-0 row">';
						html += '<input class="form-control"  type="text" id="preInWhsDate'+index+'" name="preInWhsDate" value="'+moment(data).format("YYYY-MM-DD")+'" disabled/>'  
	    				html += '<button onclick="fnPopUpCalendar(preInWhsDate'+index+',preInWhsDate'+index+',\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" name="preInWhsDateFromCalendar" type="button" disabled>';	
						html += '<span class="oi oi-calendar"></span></buton></div>';
						index++;
						return html;
				}		   
			},
			{ data : 'spplyCorpNm',
				render : function(data, type, row, meta) {
					var value = "";
					var value2 = "";
					if (data != null) {
						value = '<input type="text" class="form-control" style="max-width:100%;" name="spplyCorpNm" value="'+ data + '" disabled>';
						value2 += '<button type="button" class="btn btn-primary input-sub-search" name="btnSpplyCorp" onClick="selectSpplyCorp('+meta.row+');" disabled>';
					} else {
						value = '<input type="text" class="form-control" name="spplyCorpNm" value=""  style="max-width:100%;" disabled>';
						value2 += '<button type="button" class="btn btn-primary input-sub-search" name="btnSpplyCorp" onClick="selectSpplyCorp('+meta.row+');">';
					}
	
					var html = '<div class="input-sub m-0">';
					html += value;
					html += '<input type="hidden" name="spplyCorpCd" value="'+row['spplyCorpCd']+'">';
					html += '<input type="hidden" name="poNo" value="'+row['poNo']+'">';
					html += '<input type="hidden" name="poSeq" value="'+row['poSeq']+'">';
					html += '<input type="hidden" name="inSeq" value="'+row['inSeq']+'">';
					html += value2
					html += '<span class="oi oi-magnifying-glass"></span>';
					html += '</button>';
					html += '</div>';
					return html;
				}
			},
			{ data : 'partCd',
				render : function(data, type, row, meta) {
					return '<input type="text" class="form-control" style="text-align:center;" name="partCd" value="'+ data + '" disabled>';
				}
			},
			{ data : 'partNm',
				render: function(data, type, row, meta) {	
					if(data!=null){
	    				return '<input type="text" class="form-control" name="partNm" value="'+addCommas(data)+'" style="text-align:center;" disabled>' ;	
					} else{
						return '<input type="text" class="form-control" name="partNm" value="" style="text-align:center;" disabled>';	
					}		    			
	    		}
			},
			{ data : 'partSpec',
				render: function(data, type, row, meta) {	
					if(data!=null){
	    				return '<input type="text" class="form-control" name="partSpec" value="'+addCommas(data)+'" style="text-align:center; min-width:100%;" disabled>' ;	
					} else{
						return '<input type="text" class="form-control" name="partSpec" value="" style="text-align:center; min-width:100%;" disabled>';	
					}		    			
	    		}
			},
			{ data : 'partUnit',
				render: function(data, type, row, meta) {	
					if(data!=null){
	    				return '<input type="text" class="form-control" name="partUnit" value="'+addCommas(data)+'" style="text-align:center; min-width:100%;" disabled>' ;	
					} else{
						return '<input type="text" class="form-control" name="partUnit" value="" style="text-align:center; min-width:100%;" disabled>';	
					}		    			
	    		}
			},
			{ data : 'preInWhsQty',
				render: function(data, type, row, meta) {	
					var html1 = '<input type="text" class="form-control" name="preInWhsQty" value="'+addCommas(data)+'" style="text-align:right;" disabled>';
					var xSum = parseFloat(data)+parseInt(notQty);	//현재입고할 수 있는 수량
						html1 += '<input type="hidden" class="form-control" name="notQty" value="'+xSum+'" style="text-align:right;" disabled>';
    				return html1;
	    		}
			},
			{ data : 'barcodeYn',
				render: function(data, type, row, meta) {	
					if(data == 001){
						return '<input type="text" class="form-control" name="barcodeYn" value="관리함" style="text-align:center;" disabled>' ;
					}else{
						return '<input type="text" class="form-control" name="barcodeYn" value="안함" style="text-align:center;" disabled>' ;
					}
	    		}
			},
			
			{ data : 'locationNo',
				render: function(data, type, row, meta) {
						
					var value = "";
					var value2 = "";

					var html ="";
					html = selectBoxHtml2(locationNoCode, "locationNo", data, row, meta, "2");
// 					value = '<input type="text" class="form-control" style="max-width:100%;" name="locationNo" value="'+ data + '" disabled>';
					value += '<input type="hidden" name="locationCd"  disabled>';
					value += '<input type="hidden" name="areaCd" value='+row['areaCd']+'  disabled>';
					value += '<input type="hidden" name="floorCd" value='+row['floorCd']+'  disabled>';
					
// 					value2 += '<button type="button" class="btn btn-primary input-sub-search" name="btnLocationNo" onClick="selectLocationNo('+meta.row+');" disabled>';
	
					var html2 = '<div class="input-sub m-0">';
					html2 += value;
					html2 += html;
// 					html += '<span class="oi oi-magnifying-glass"></span>';
// 					html += '</button>';
					html2 += '</div>';
					return html2;		
	    		}
			},
			{ data : 'inWhsDesc',
				render: function(data, type, row, meta) {	
    				return '<input type="text" class="form-control" name="inWhsDesc" value="'+data+'" style="text-align:center;" disabled>' ;	
	    		}
			},
			{ data : 'lotNo',
				render: function(data, type, row, meta) {	
					var html;
    				html =  '<input type="text" class="form-control" name="lotNo" value="'+data+'" style="text-align:center;" disabled>' ;	
    				html +=  '<input type="hidden" class="form-control" name="barcodeNo" value="'+row['barcodeNo']+'" style="text-align:center;" disabled>' ;	
    				return html;
				},
			}
		],  
		columnDefs: [
			//{ targets: [2,3] , render: $.fn.dataTable.render.number( ',' ), className : 'text-right' }
		],
        order: [
	        [ 0, 'asc' ]
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	}); 

	var individualDtlTableIdx='';
	//세부목록 클릭 시
	$('#individualDtlTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			
		} else {
			$('#individualDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');		
		}
		if(btnView == "update"){
			$("#btnDel").attr("disabled", false);
			$("#btnAllDel").attr("disabled", false);
		}
		tableIdx 	= individualDtlTable.row(this).index();
		poNo 		= individualDtlTable.row(this).data().poNo;
		poSeq 		= individualDtlTable.row(this).data().poSeq;
		inSeq 		= individualDtlTable.row(this).data().inSeq;
		statusCd 	= individualDtlTable.row(this).data().statusCd;
		
		individualDtlTableIdx = $('#individualDtlTable').DataTable().row(this).index();

		if(statusCd != "I"){
			$('#btnEdit').attr('disabled', true);
			$('#btnDel').attr('disabled', true);
		}else{
			$('#btnEdit').attr('disabled', false);
			$('#btnDel').attr('disabled', false);
		}
		sideView = 'edit';
		btnView='edit';
	});

	var sysdate = "${serverTime}";
    
    var html1 = '<div class="row">';
    html1 += '&nbsp;&nbsp;<label class="input-label-sm">일자</label><div class="form-group input-sub m-0 row mr-1">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="preInWhsDateFrom" name="preInWhsDateFrom" disabled/>';
    html1 += '<button onclick="fnPopUpCalendar(preInWhsDateFrom,preInWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>';
    html1 += '&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="preInWhsDateTo" name="preInWhsDateTo" disabled/>';
    html1 += '<button onclick="fnPopUpCalendar(preInWhsDateTo,preInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>';   
   
    html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-1" id="btnRetv">조회</button>'
    html1 += '&nbsp;&nbsp;&nbsp; <button type="button"  class="btn btn-primary" id="btnAllList">전체조회</button>'
    html1 += '</div>';
    
	$('#mainTable_length').html(html1);
	$('#preInWhsDateFrom').val(serverDateFrom);
	$('#preInWhsDateTo').val(serverDateTo);
	
	$('#btnRetv').on('click', function() {
    	serverDateFrom =  $('#preInWhsDateFrom').val();
    	serverDateTo =  $('#preInWhsDateTo').val();
    	$('#mainTable').DataTable().ajax.reload( function () {});
		$('#individualAdmTable').DataTable().ajax.reload( function () {});
    });

	//전체 조회
	$('#btnAllList').on('click', function() {
		serverDateFrom =  "";
		serverDateTo =  "";
		$('#mainTable').DataTable().ajax.reload(function () {});
		poNo='';
		partCd='';
		$('#btnSaveTo').addClass('d-none');
		$('#btnSave').addClass('d-none');
		$('#checkAll').attr('disabled', true);
		$('#individualAdmTable').DataTable().ajax.reload(function() {});
		$('#individualDtlTable').DataTable().ajax.reload(function() {});
    });


	//자재 탭 전체체크
    $('#checkAll').on('click', function(){
    	$('#individualAdmTable tbody tr').each(function(index, item){
			if($(this).find('td input[name=checkLal]').attr('disabled')!='disabled'){
				if($("#checkAll").prop("checked")) {
					$(this).find('td input[name=checkLal]').prop("checked",true); 
		        } else { 
		           $("input[type=checkbox]").prop("checked",false);
		        }
				
		 	}
 		});
    });

  //checkBox디테일 설정
	$(document).on('click','input[name=checkLal]',function(e){
		if($('input:checkbox[name=checkLal]:checked').length == $('input:checkbox[name=checkLal]').length){
			$("#checkAll").prop("checked", true);
		   }else{
		   	$("#checkAll").prop("checked", false);
		}
	});

	var selectVal= '';

    //창고코드 값 변경 될 시
    function individualAdmChange(value){
//         if($("#allValueChange").prop("checked")){	변경여부
        	for(var i =0; i<locationNoCode.length; i++){
    			if(locationNoCode[i].baseCd == value){
    				$('#individualAdmTable tbody tr').eq(individualAdmTableIdx).find('td input[name=areaCd]').val(locationNoCode[i].etc1);	//구역etc1
    				$('#individualAdmTable tbody tr').eq(individualAdmTableIdx).find('td input[name=floorCd]').val(locationNoCode[i].etc2);	//위치etc2
    	        }
//     		}
    		
        	selectVal = value;
        	$('#checkModal').modal({backdrop: 'static'});
    		$('#checkModal').modal('show');
		}
    }

    function individualDtlChange(value){
//     	if($("#allValueChange").prop("checked")){	변경여부
			for(var i =0; i<locationNoCode.length; i++){
				if(locationNoCode[i].baseCd == value){
					$('#individualDtlTable tbody tr').eq(individualDtlTableIdx).find('td input[name=areaCd]').val(locationNoCode[i].etc1);	//구역etc1
					$('#individualDtlTable tbody tr').eq(individualDtlTableIdx).find('td input[name=floorCd]').val(locationNoCode[i].etc2);	//위치etc2
		        }
			}
//     	}
    }

    $('#btnY').on('click', function(){
		$('#checkModal').modal('hide');
// 		if(sideView == 'add'){
			$('#individualAdmTable tbody tr').each(function(index, item){
				$(this).find('td select[name=locationNo]').val(selectVal);
			});
			for(var i =0; i<locationNoCode.length; i++){
				if(locationNoCode[i].baseCd == selectVal){
					$('input[name=areaCd]').val(locationNoCode[i].etc1);	//구역etc1
					$('input[name=floorCd]').val(locationNoCode[i].etc2);	//위치etc2
				}
			}
// 		}else if(sideView == 'edit'){
// 			$('#individualDtlTable tbody tr').each(function(index, item){
// 				$(this).find('td select[name=locationNo]').val(selectVal);
// 			});
// 		}
   	});
    //창고코드 값 변경 될 시 끝

	
 	//등록폼
 	$('#btnAdd').on('click', function(){

 		if ($('#mainTable tbody tr').hasClass('selected') =='') {
			toastr.warning('발주번호를 선택해주세요.');	
			return false;
		}
 		var countX=0;
		if(1==1){
		 	$('#individualAdmTable tbody tr').each(function(index, item){
			 	if($(this).find('td').eq('8').text() == 0){
					countX++;					
				}
			});
		 	if($('#individualAdmTable tbody tr').length == countX){
	 			toastr.warning('모두 입고된 항목들 입니다.');
	 			return false;
		 	}
		}
		
 		if ($('#btnSave').hasClass('d-none') == false) {
			toastr.warning('수정중 입니다.');	
			return false;
		}

 		$('#btnEdit').attr('disabled', true);
 		$('#btnDel').attr('disabled', true);
		
 		$("input[type=checkbox]").prop("checked",false);
 		$('#checkAll').attr('disabled', false);
 		$('#individualAdmTable tbody tr').each(function(index, item){

 			$(this).find('td button[name=preInWhsDateFromCalendar]').attr('disabled',false);
 	 		$(this).find('td input[name=preInWhsQty]').attr('disabled',false);
 	 		$(this).find('td select[name=locationNo]').attr('disabled',false);
 	 		$(this).find('td input[name=inWhsDesc]').attr('disabled',false);
 	 		$(this).find('td input[name=preInWhsDate]').val(inWhsDate); 
 	 		
			if($(this).find("td").eq("6").text() == $(this).find("td").eq("7").text()){
				$(this).find('td input[name=checkLal]').attr('disabled',true);
				$(this).find("td button[name=preInWhsDateFromCalendar]").attr('disabled',true);
				$(this).find("td input[name=preInWhsQty]").attr('disabled',true);
				$(this).find("td select[name=locationNo]").attr('disabled',true);
				$(this).find("td input[name=inWhsDesc]").attr('disabled',true);
		 	}else{
		 		$(this).find('td input[name=checkLal]').attr('disabled',false);
			 }
 		});
 		sideView='add';
		$('#btnSaveTo').removeClass('d-none');
 	 });

 
	// 수정폼
	$('#btnEdit').on('click', function() {
		if ($('#individualDtlTable tbody tr').hasClass('selected') =='') {		
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}
		if ($('#btnSaveTo').hasClass('d-none') == false) {
			toastr.warning('등록중 입니다.');	
			return false;
		}
		if(statusCd != "I"){
			toastr.warning("출고된 항목은 수정할 수 없습니다.");
			return false;
		}
		
		$('#btnAdd').attr('disabled', true);
 		
		$('#individualDtlTable tbody tr').each(function(index, item){
			if($(this).index() == tableIdx){
				$(this).find('td button[name=preInWhsDateFromCalendar]').attr('disabled',false);
	 	 		$(this).find('td input[name=preInWhsQty]').attr('disabled',false);
	 	 		$(this).find('td select[name=locationNo]').attr('disabled',false);
	 	 		$(this).find('td input[name=inWhsDesc]').attr('disabled',false);
			}else{
				$(this).find('td button[name=preInWhsDateFromCalendar]').attr('disabled',true);
	 	 		$(this).find('td input[name=preInWhsQty]').attr('disabled',true);
	 	 		$(this).find('td select[name=locationNo]').attr('disabled',true);
	 	 		$(this).find('td input[name=inWhsDesc]').attr('disabled',true);
			}
		});
		$('#btnSave').removeClass('d-none');
		sideView='edit';
	});

	
	//삭제 버튼 클릭
	$('#btnDel').on('click', function() {
		if(btnView != 'edit') {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		if(statusCd != "I"){
			toastr.warning("출고된 항목은 삭제할 수 없습니다.");
			return false;
		}
		$.ajax({
			url : '<c:url value="mm/preInWhsAdmDelete"/>',
			type : 'GET',
			data : {
				poNo	: function(){ return poNo },
				inSeq	: function(){ return inSeq }
			},
			success : function(res){
				if(res.result == "ok"){
					toastr.success("삭제되었습니다.");
					$('#individualDtlTable').DataTable().rows(tableIdx).remove().draw();
					$('#individualAdmTable').DataTable().ajax.reload(function() {});
				}else {
					toastr.error(res.message);
				}
			}			
		});
		sideView ='';
		//btnView = "update";
	});

	
	//저장처리
	function saveSelect(value){

		if (value == '001'){
			var Tabletext = "individualAdmTable";
			$('#individualAdmTable').DataTable().$('tr.selected').removeClass('selected');
		}else if(value == '002'){
			var Tabletext = "individualDtlTable";
		}
		
		var dataArray = new Array();		
		var check=true;
		var url;
		
		$('#'+Tabletext+' tbody tr').each(function(index, item){

			if (value == '001'){
				if($('input:checkbox[name=checkLal]:checked').length == 0){
					toastr.warning('입고할 값을 체크해주세요.');
						$(this).find('td input[name=checkLal]').focus();
					check=false;
					return false;
				}
				var stateText = $(this).find('td input[name=checkLal]').is(':checked');
			}else if(value == '002'){
				var stateText = $(this).find("td input[name=preInWhsQty]").attr('disabled')!='disabled';
			}
			
			//checkBox가 선택된 것만 저장처리
			if(stateText){
				
				var X =parseInt($(this).find("td input[name=preInWhsQty]").val().replace(/,/g,''));
				var Y =parseFloat($(this).find("td input[name=notQty]").val());
				
				if (X > Y) {
					var subtract= X-Y;
					toastr.warning('발주수량('+subtract+')개를 초과합니다.');	
					$(this).find("td input[name=preInWhsQty]").focus();
					check=false;
					return false;
				}
				if ($(this).find("td input[name=preInWhsDate]").val() == "") {		
					toastr.warning('개별입고일자를 선택해주세요.');	
					$(this).find("td button[name=preInWhsDateFromCalendar]").focus();
					check=false;
					return false;
				}
				if ($(this).find("td input[name=spplyCorpNm]").val() == "") {		
					toastr.warning('거래처를 선택해주세요.');	
					$(this).find("td button[name=btnSpplyCorp]").focus();
					check=false;
					return false;
				}
				if ($(this).find("td input[name=partNm]").val() == "") {		
					toastr.warning('코드를 선택해주세요.');	
					$(this).find("td button[name=btnPartCd]").focus();
					check=false;
					return false;
				} 
				if ($(this).find("td input[name=preInWhsQty]").val() == "0") {		
					toastr.warning('입고수량을 입력해주세요.');	
					$(this).find("td input[name=preInWhsQty]").focus();
					check=false;
					return false;
				} 
				if (!$.trim($(this).find("td select[name=locationNo]").val())) {
					toastr.warning('창고를 입력해주세요.');	
					$(this).find("td select[name=locationNo]").focus();
					check=false;
					return false;
				}

				var rowData = new Object();
		
				if (value == '001'){
					url = '<c:url value="mm/individualAdmCreate"/>';
					/*발주번호*/			rowData.poNo 			= poNo;
					/*발주 시퀀스*/			rowData.poSeq 			= $(this).find("td").eq("1").text();
					/*부품코드*/			rowData.partCd			= $(this).find("td").eq("2").text();
					/*부품REV*/			rowData.partRev 		= "00";
					/*개별입고일자*/		rowData.preInWhsDate 	= $(this).find("td input[name=preInWhsDate]").val().replace(/-/g,'');
					/*가입고량*/			rowData.preInWhsQty 	= $(this).find("td input[name=preInWhsQty]").val().replace(/,/g,'');
		
					/*Location No*/		rowData.locationNo 		= $(this).find("td select[name=locationNo]").val();
					/*창고번호*/			rowData.locationCd 		= "00";
					/*구역*/				rowData.areaCd 			= $(this).find("td input[name=areaCd]").val();
					/*위치*/				rowData.floorCd 		= $(this).find("td input[name=floorCd]").val();
					/*비고*/				rowData.inWhsDesc 		= $(this).find("td input[name=inWhsDesc]").val();
					/*거래처번호*/			rowData.spplyCorpCd 	= spplyCorpCdVal;
					
			        dataArray.push(rowData);
			        
				}else if(value == '002'){
					url = '<c:url value="mm/individualAdmUpdate"/>';
					/*발주번호*/		rowData.poNo 			= $(this).find("td input[name=poNo]").val();
					/*가입고 시퀀스*/	rowData.inSeq 			= $(this).find("td input[name=inSeq]").val();
					/*가입고일*/		rowData.preInWhsDate 	= $(this).find("td input[name=preInWhsDate]").val().replace(/-/g,'');
//	 				/*거래처*/		spplyCorpCdVal 			= ($(this).find("td input[name=spplyCorpNm]").val()==null||$(this).find("td input[name=spplyCorpNm]").val()=="")?"":$(this).find("td input[name=spplyCorpCd]").val();
//	 				/*거래처*/		rowData.spplyCorpCd 	= spplyCorpCdVal;
					/*가입고량*/		rowData.preInWhsQty 	= $(this).find("td input[name=preInWhsQty]").val().replace(/,/g,'');
					/*비고*/			rowData.inWhsDesc 		= $(this).find("td input[name=inWhsDesc]").val();
					/*바코드관리여부*/	rowData.barcodeYn 		= $('select[name="barcodeYn"] option:selected').val();
					/*창고번호*/		rowData.locationNo 		= $(this).find("td select[name=locationNo]").val();
					/*구역*/			rowData.areaCd 			= $(this).find("td input[name=areaCd]").val();
					/*위치*/			rowData.floorCd 		= $(this).find("td input[name=floorCd]").val();
					
					dataArray.push(rowData);
				}
			}
		});
		console.log(dataArray);
		
		if(check == true){
			$.ajax({
				url : url,
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				success : function(res) {				
					if (res.result == 'ok') {
						
						if (value == '001'){
							btnView = "";
							sideView = '';
							$('#individualAdmTable').DataTable().ajax.reload(function() {});
							$('#individualDtlTable').DataTable().ajax.reload(function() {});
							$('#btnSave').addClass('d-none');
							toastr.success('저장되었습니다.');
							
						}else if(value == '002'){
							$('#individualAdmTable').DataTable().ajax.reload(function() {});
							$('#individualDtlTable').DataTable().ajax.reload(function() {});
							$('#btnSave').addClass('d-none');
							
							toastr.success('수정 되었습니다.');
						}
					}else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					$("input[type=checkbox]").prop("checked",false);
					
					$('button[name=preInWhsDateFromCalendar]').attr('disabled',true);
		 	 		$('input[name=preInWhsQty]').attr('disabled',true);
		 	 		$('select[name=locationNo]').attr('disabled',true);
		 	 		$('input[name=inWhsDesc]').attr('disabled',true);
		 	 		
		 	 		$('#btnAdd').attr('disabled', false);
		 	 		$('#btnEdit').attr('disabled', false);
		 	 		$('#btnDel').attr('disabled', false);
		 	 		$('#checkAll').attr('disabled', true);
		 	 		
		 	 		$('#btnSaveTo').addClass('d-none');
		 	 		$('#btnSave').addClass('d-none');
				}
			});
		}
	}
	 
	//입고처 팝업 시작
	var dealCorpPopUpTable;
	var index2;
	function selectSpplyCorp(index) {
		index2 = index;
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
					{ "defaultContent" : "-", "targets" : "_all", "className" : "text-center" }
				],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
			});

			$('#dealCorpPopUpTable tbody').on('click', 'tr', function() {
				var data = dealCorpPopUpTable.row(this).data();
				$('input[name=spplyCorpCd]').eq(index2).val(data.dealCorpCd);
				$('input[name=spplyCorpNm]').eq(index2).val(data.dealCorpNm);
				$('#dealCorpPopUpModal').modal('hide');
			});
		}
		$('#dealCorpPopUpModal').modal({backdrop: 'static'});
		$('#dealCorpPopUpModal').modal('show');
	}

	var itemPartPopUpTable;
	var index3;
	/*function selectPartCd(index) {
		index3 = index;
		if (itemPartPopUpTable == null || itemPartPopUpTable == undefined) {
			itemPartPopUpTable = $('#itemPartPopUpTable').DataTable({
				dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>"
						+ "<'row'<'col-sm-12'tr>>"
						+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : false,
				ordering : true,
				processing : true,
				autoWidth : false,
				scrollX : false,
				lengthChange : true,
				searching : true,
				serverSide : true,
				pageLength : 15,
				ajax : {
					url : '<c:url value="mm/itemPartAdmList"/>',
					type : 'GET',
					data : {},
				},
				rowId : 'partCd',
				columns : [
					{ render : function(data, type, row,
								meta) {
							return meta.row+ meta.settings._iDisplayStart+ 1;
						}
					},
					{ data : 'partCd'		},
					{ data : 'partNm'		},
					{ data : 'partGubunNm'	},
					{ data : 'partTypeNm'	},
					{ data : 'partRev'		},
					{ data : 'partSpec'		}
				],
				columnDefs : [
					{ "defaultContent" : "-", "targets" : "_all", "className" : "text-center" }
				],
				order : [ [ 1, 'asc' ] ],
				buttons : [],
			});

			$('#itemPartPopUpTable tbody').on('click', 'tr', function() {

				var data = itemPartPopUpTable.row(this).data();
			
				$('input[name=partCd]').eq(index3).val(data.partCd);
				$('input[name=partRev]').eq(index3).val(data.partRev);
				$('input[name=partNm]').eq(index3).val(data.partNm);
				$('input[name=partSpec]').eq(index3).val(data.partSpec);
				$('input[name=partUnit]').eq(index3).val(data.partUnitNm);
				$('selecbarcodeYnspectYn]').eq(index3).val(data.inspectYn);

				/* if(data.inspectYn == '001'){
					$('button[name=btnLocationNo]').attr('disabled',true);
				}else{
					$('button[name=btnLocationNo]').attr('disabled',false);
				} */
				
				/*$('#itemPartPopUpModal').modal('hide');
			});
		} else {
			$('#itemPartPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#itemPartPopUpModal').modal('show');
	};*/

	//창고정보조회 팝업 시작
	var locationPopupTable;
	/*function selectLocationNo(index) {
		index3 = index;
		locationPopupTable = $('#locationPopupTable').DataTable({
			language : lang_kor,
			lengthChange : false,
			paging : true,
			searching:true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			destroy : true,
			pageLength : 15,
			ajax : {
				url : 'bm/locationAdmList',
				type : 'GET',
				data : {
					'useYn' : '001',
					'locCd' : $('#locationCd option:selected').val()
					}
			},
			columns : [ 
				{ render : function(data, type, row,meta) {
						return meta.row+1;
					}
				}, 
				{ data : 'areaNm' 	},
				{ data : 'floorNm'	},
				{ data : 'locDesc'	},
				{ data : 'locNo' 	},
			],
			columnDefs : [ 
				{ "targets" : '_all',"className" : "text-center" }
			],
			order : [ [ 0, 'asc' ] ],
		});
		
		$('#locationPopupTable tbody').on('click', 'tr', function() {
			var data = locationPopupTable.row(this).data();
			$('input[name=locationNo]').eq(index3).val(data.locNo);
			$('input[name=locationCd]').eq(index3).val(data.locCd);
			$('input[name=areaNm]').eq(index3).val(data.areaNm);
			$('input[name=areaCd]').eq(index3).val(data.areaCd);
			$('input[name=floorCd]').eq(index3).val(data.floorNm);
			
			$('#locationPopupModal').modal('hide');
		});
		$('#locationPopupModal').modal('show');
	}*/
	

	function uiProc(flag) {
		$('input[name=lotNo]').attr('disabled',flag);
		$('input[name=srLot]').attr('disabled',flag);
		$('input[name=custItemCd]').attr('disabled',flag);
		$('input[name=custItemNm]').attr('disabled',flag);
		$('input[name=preInWhsQty]').attr('disabled',flag);
		$('input[name=inWhsDesc]').attr('disabled',flag);
		$("select[name=preInStatus]").attr("disabled", flag);
		$("button[name=inWhsDateFromCalendar]").attr("disabled",flag);
	}


	
	//셀렉트박스생성 ADM
	function selectBoxHtml2(obj, id, sVal, row, meta, flag){
		var shtml="";
			shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '" onchange="individualAdmChange($(this).val())" disabled>';

		var option2="";
		if(flag == '1') {
			option2 = "<option value='' selected>"+ "전체" +"</option>";
	   	} else if(flag == '2') {
	   		option2 = "<option value=''>"+ "선택" +"</option>";
	   	}
	   	
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option2 +option + ehtml;
	}

	//셀렉트박스생성 DTL
	function selectBoxHtml3(obj, id, sVal, row, meta, flag){
		var shtml="";
			shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '" onchange="individualDtlChange($(this).val())" disabled>';

		var option2="";
		if(flag == '1') {
			option2 = "<option value='' selected>"+ "전체" +"</option>";
	   	} else if(flag == '2') {
	   		option2 = "<option value=''>"+ "선택" +"</option>";
	   	}
	   	
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option2 +option + ehtml;
	}

 	$(document).on('keyup',"input[name=preInWhsQty]", function(event){
		var preInWhsQtyData = $(this).val();
		
		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46)	) {
			/* $('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); */
			toastr.warning('숫자만 입력해주세요.');
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		$(this).val(addCommas(uncomma($(this).val())));
	}); 

	
    //콤마(,) 생성
    function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	//콤마(,) 삭제
	function uncomma(x) {
	    x = String(x);
	    return x.replace(/[^\d]+/g, '');
	}

</script>

</body>
</html>
