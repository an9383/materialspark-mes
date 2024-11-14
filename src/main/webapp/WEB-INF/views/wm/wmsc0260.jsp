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
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">매출계획대비실적조회</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
		<div class="container-fluid" id="main">
			<div class="row table-wrap-hid">	
				<!--======================== .left-list ========================-->
				<div class="left-list" id="left-list" style="overflow-y:hidden;">
					<div class="card">	
						<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">월별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">분기별</a></li>
						</ul>
						</div>
						<br>
						<div class="row">
							 <div class="col-sm-6" style="margin-bottom:5px;">
								 <div class="row">
								 &nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">년도</label>
							
								 <select class="custom-select" style="width: 150px;" id="chooseDateTo" ></select>			
								
								 &nbsp;&nbsp;				
								 <select class="custom-select d-none" id="quarter" style="width:105px;">
									<option value="0">전체</option>
									<option value = "1">1분기</option>
									<option value = "2">2분기</option>
									<option value = "3">3분기</option>
									<option value = "4">4분기</option>
								</select>
								 <button type="button" class="btn btn-primary" id="btnRetv">조회</button>
								 
								 </div>
							 </div>
							 <div class="col-sm-6" style="margin-bottom:5px;">
								<button type="button" class="btn btn-primary float-right" id="btnInsert">입력</button>
							 </div>
							
						
						<div class="table-responsive" id="view1" style="padding-bottom: 5px;" >
							<table class="table table-bordered" id="firstTable" style="margin-top:6px;">
								<colgroup>
										<col width="9%">
										<col width="9%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="9%">									
								</colgroup>							
								<thead class="thead-light">
									<tr>
										<th>고객</th>
										<th>합계</th>
										<th>1월</th>
										<th>2월</th>
										<th>3월</th>
										<th>4월</th>
										<th>5월</th>
										<th>6월</th>
										<th>7월</th>
										<th>8월</th>
										<th>9월</th>
										<th>10월</th>
										<th>11월</th>
										<th>12월</th>
										<th>매출평균</th>
									</tr>
								</thead>
								
							</table>
								
							
							<%-- <table id="secondTable" class="table table-bordered">
								<colgroup>
										<col width="9%">
										<col width="9%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="6%">
										<col width="9%">									
								</colgroup>	
								<thead class="thead-light">
									<tr>
										<th>고객</th>
										<th>합계</th>
										<th>1월</th>
										<th>2월</th>
										<th>3월</th>
										<th>4월</th>
										<th>5월</th>
										<th>6월</th>
										<th>7월</th>
										<th>8월</th>
										<th>9월</th>
										<th>10월</th>
										<th>11월</th>
										<th>12월</th>
										<th>매출평균</th>	
									</tr>
								</thead>
									
							</table> --%>
						</div>
						<div id="view2" class="d-none">
							<div class="table-responsive">
							 
								<table id="salesPlanInfoTable2" class="table table-bordered">
									<thead class="thead-light">
										<!--==========table thead 추가==========-->
										<tr>
											<th rowspan="3" style="min-width:100px; vertical-align:middle;" >고객사</th>											
											<th colspan="6">1분기</th>
											<th colspan="6">2분기</th>
											<th colspan="6">3분기</th>									
											<th colspan="6">4분기</th>									
										</tr>
										<tr>									
											<th colspan="2">계획</th>
											<th colspan="2">실적</th>
											<th colspan="2">달성율(%)</th>
											<th colspan="2">계획</th>
											<th colspan="2">실적</th>
											<th colspan="2">달성율(%)</th>	
											<th colspan="2">계획</th>
											<th colspan="2">실적</th>
											<th colspan="2">달성율(%)</th>	
											<th colspan="2">계획</th>
											<th colspan="2">실적</th>
											<th colspan="2">달성율(%)</th>		
										</tr>
										<tr>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
											<th style="min-width:100px;">수량</th>
											<th style="min-width:100px;">금액</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<td colspan="" style="text-align: center">합계</td>
											<td colspan="" id="sum1" style="text-align: right">0</td>									
											<td colspan="" id="sum2" style="text-align: right">0</td>
											<td colspan="" id="sum3" style="text-align: right">0</td>
											<td colspan="" id="sum4" style="text-align: right">0</td>
											<td colspan="" id="sum5" style="text-align: right">0</td>
											<td colspan="" id="sum6" style="text-align: right">0</td>
											<td colspan="" id="sum7" style="text-align: right">0</td>
											<td colspan="" id="sum8" style="text-align: right">0</td>
											<td colspan="" id="sum9" style="text-align: right">0</td>
											<td colspan="" id="sum10" style="text-align: right">0</td>
											<td colspan="" id="sum11" style="text-align: right">0</td>
											<td colspan="" id="sum12" style="text-align: right">0</td>
											<td colspan="" id="sum13" style="text-align: right">0</td>
											<td colspan="" id="sum14" style="text-align: right">0</td>
											<td colspan="" id="sum15" style="text-align: right">0</td>
											<td colspan="" id="sum16" style="text-align: right">0</td>
											<td colspan="" id="sum17" style="text-align: right">0</td>
											<td colspan="" id="sum18" style="text-align: right">0</td>
											<td colspan="" id="sum19" style="text-align: right">0</td>
											<td colspan="" id="sum20" style="text-align: right">0</td>
											<td colspan="" id="sum21" style="text-align: right">0</td>
											<td colspan="" id="sum22" style="text-align: right">0</td>
											<td colspan="" id="sum23" style="text-align: right">0</td>
											<td colspan="" id="sum24" style="text-align: right">0</td>
											
										</tr>
									</tfoot>
								</table>
							</div>
						</div>
                     	<!-- /.table-responsive -->
                    </div>
                    <!-- <button type="button" class="btn btn-success float-right">Excel</button> -->
				</div><!-- /.left-list -->		
				
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<!-- 작업자 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="performancePlanPopUpModal" tabindex="-1" data-backdrop="static" role="dialog" aria-labelledby="performancePlanPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 315%;">
			<div class="modal-header">
				<h5 class="modal-title">매출계획대비실적</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">				
				<!-- .table-responsive -->
				<div class="">							
    				<label class="input-label-sm float-left ml-3">일자</label>
    				<select class="custom-select float-left" style="width: 150px;" id="chooseDateToModal" ></select>				    	
    				<button type="button" class="btn btn-primary float-left ml-1" name="modalRetv" id="modelRetv">조회</button>    				
					<button type="button" class="btn btn-warning float-right mr-1" name="rowDelete" id="rowDelete" value="">열삭제</button>
					<button type="button" class="btn btn-primary float-right mr-1" name="rowAdd" id="rowAdd" value="">열추가</button>	
						
				</div>
					<br>
					<br>
				
					<div class="table-responsive" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" >
						<table class="table table-bordered" id="performanceAginstPlanTable" style="margin-top:6px;">
							<colgroup>
									<col width="10%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
									<col width="7.6%">
																	
							</colgroup>							
							<thead class="thead-light">
								<tr>
									<th>구분</th>									
									<th>1월</th>
									<th>2월</th>
									<th>3월</th>
									<th>4월</th>
									<th>5월</th>
									<th>6월</th>
									<th>7월</th>
									<th>8월</th>
									<th>9월</th>
									<th>10월</th>
									<th>11월</th>
									<th>12월</th>									
								</tr>
							</thead>
							
						</table>						
					</div>
				
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary float-right mr-1" id="btnSave" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 작업자 등록 모달 종료 -->
<%@include file="../layout/bottom.jsp" %>

<script>
	
	let menuAuth = 'wmsc0260';
	let currentHref = 'wmsc0260';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","매출계획대비실적조회");


	var serverDate = "${serverDate}";
	var chooseDateFrom = "${serverDateFrom}";   
	var chooseDateTo = "${serverDate}";
	var chooseDateToModal = "${serverDate}";

	let colorStat = false;
	let gijongGubun = '';
	let tabStat = 'tab1';
	setDateBox();
	$('#chooseDateTo').val(chooseDateTo.substring(0,4));
	$('#chooseDateToModal').val(chooseDateToModal.substring(0,4));	

	var gubunCode = new Array();
	var json = new Object();
	json.baseCd="001";
	json.baseNm="국내샘플";
	gubunCode.push(json);
	json = new Object();
	json.baseCd="002";
	json.baseNm="매출액";
	gubunCode.push(json);
	json = new Object();
	json.baseCd="003";
	json.baseNm="스크랩";
	gubunCode.push(json);
	json = new Object();
	json.baseCd="004";
	json.baseNm="금액";
	gubunCode.push(json);
	json = new Object();
	json.baseCd="005";
	json.baseNm="샘플/스크랩 매출액";
	gubunCode.push(json);

	

	$('#tab1').on('click', function() {
		$('#my-spinner').show();
		$('#view2').addClass('d-none');
		$('#view1').removeClass('d-none');
		$('#quarter').addClass('d-none');	
		tabStat = 'tab1';
		chooseDateTo = $('#chooseDateTo').val();
		$('#firstTable').DataTable().ajax.reload();
		//$('#secondTable').DataTable().ajax.reload();
		$('#firstTable').DataTable().draw(false).columns.adjust();
		//$('#secondTable').DataTable().draw(false).columns.adjust();
	}); 	   

	$('#tab2').on('click', function() {
		$('#my-spinner').show();
		$('#view1').addClass('d-none');
		$('#view2').removeClass('d-none');
		$('#quarter').removeClass('d-none');		
		tabStat = 'tab2';	
		chooseDateTo = $('#chooseDateTo').val();
		$('#salesPlanInfoTable2').DataTable().ajax.reload();
	});

	//$('#btnRetv').trigger('click');
	 $.fn.dataTable.ext.errMode = 'none';
		let firstTable = $('#firstTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
	        language: lang_kor,
	        paging: false,
	        info: true,
	        searching : false,
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,	   
	        lengthChange : false,
	        pageLength: 10000,
	        scrollY: '58vh',
	        ajax: {
	            url: '<c:url value="/wm/performanceAginstPlanMonth"/>',
	            type: 'POST',
	            data: {
	            	'menuAuth'	 : menuAuth,
		           	'fpDate': function() { return chooseDateTo.substring(0,4); },        	
		         		           	 
	            },	           
	        },	       
	        columns: [
	        	{ data: 'dealCorpNm'},
	            { data: 'outputCnt',
   	        	 render: function(data, type, row) {
    	        	 if(data != null){
    	        		 if(row['dealCorpNm'] == '달성율'){
 							return parseFloat(data).toFixed(0) + '%';
             	       	 }
    	        		 else{
    	        			return addCommas(data);
                	     }
    	        		 
        	       	 }
    	        	  
	        	 }
	        	 },
	            <c:forEach var="item" begin="1" end="12" step="1">
           			{ data: 'fpDate${item}',
    	        	 render: function(data, type, row) {
        	        	 if(data != null){
        	        		 if(row['dealCorpNm'] == '달성율'){
     							return parseFloat(data).toFixed(0) + '%';
                 	       	 } else if(row['dealCorpNm'] == '전달대비 매출증감율'){
     							return parseFloat(data).toFixed(0) + '%';
                 	       	 }
        	        		 else{
        	        			return addCommas(data);
                    	     }
        	        		 
            	       	 }
        	        	  
    	        	 }
   	        	 },
    			</c:forEach>
    	         { data: 'outputCnt',
    	        	 render: function(data, type, row) {
        	        	 if(row['dealCorpNm'] == '매출액'){
							return addCommas(parseFloat(data / 12).toFixed(0));
            	         }
    	        	 }
        	     },
	       
	        ],
	        columnDefs: [
	        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13], className: 'text-right-td' },
	        ],       
	        buttons: [
	            {
	                extend: 'copy',
	                title: '월별 매출계획대비 실적',
	            },
	            {
	                extend: 'excel',
	                title: '월별 매출계획대비 실적',
	            },
	            {
	                extend: 'print',
	                title: '월별 매출계획대비 실적',
	            },
	        ],
	        createdRow: function (row, data, dataIndex) {
    			
    			
        		if(gijongGubun != data["dealCorpCd"]){
					gijongGubun = data["dealCorpCd"];
					colorStat = !colorStat;
				}
        		if(colorStat){
    				$(row).css('background-color','#F2F2F2');
        		} else{
        			$(row).css('background-color','#ffffff');	            			
            	}
        	
    		},
	        drawCallback: function () {
	        	
	        	$('#my-spinner').hide();
	        }
	});

		
	 /* $.fn.dataTable.ext.errMode = 'none';
		let secondTable = $('#secondTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",        
	        language: lang_kor,
	        paging: false,
	        info: false,
	        searching : false,
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,	   
	        lengthChange : false,
	        pageLength: 10000,
	        scrollY: '25vh',
	        ajax: {
	            url: '<c:url value="/wm/performanceAginstPlanTotal"/>',
	            type: 'POST',
	            data: {
	            	'menuAuth'	 : menuAuth,
		           	'fpDate': function() { return chooseDateTo.substring(0,4); },        	
		         		           	 
	            },	           
	        },	       
	        columns: [
	        	{ data: 'dealCorpNm'},
	            { data: 'outputCnt',
   	        	 render: function(data, type, row) {
    	        	 if(data != null){
    	        		 if(row['gubun'] == '5'){
 							return parseFloat(data).toFixed(0) + '%';
             	       	 }
    	        		 else{
    	        			return addCommas(data);
                	     }
    	        		 
        	       	 }
    	        	  
	        	 }},
	            <c:forEach var="item" begin="1" end="12" step="1">
           			{ data: 'fpDate${item}',
    	        	 render: function(data, type, row) {
        	        	 if(data != null){
        	        		 if(row['gubun'] == '5'){
     							return parseFloat(data).toFixed(0) + '%';
                 	       	 }
        	        		 else{
        	        			return addCommas(data);
                    	     }
        	        		 
            	       	 }
        	        	  
    	        	 }
   	        	 },
    			</c:forEach>
    	         { data: 'outputCnt',
    	        	 render: function(data, type, row) {
        	        	 if(row['gubun'] == '6' || row['gubun'] == '7'){
							return addCommas(parseFloat(data / 12).toFixed(0));
            	         }
    	        	 }
        	     },
	       
	        ],
	        columnDefs: [
	        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13], className: 'text-right-td' },
	        ],       
	        createdRow: function (row, data, dataIndex) {	
    			
        		
        	
    		},
	        drawCallback: function () {
	        	
	        	$('#my-spinner').hide();
	        }
	}); */

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let salesPlanInfoTable2 = $('#salesPlanInfoTable2').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: false,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false, 
        searching: false,      
        ajax: {
            url: '<c:url value="/wm/salesPlanAdmQuarterDataListNew"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planYear': function() {return chooseDateTo.substring(0,4); },	           	   
            },            
        },
        rowId: 'rowId',
        columns: [
            { data: 'dealCorpNm' },           
            { data: 'quarterCnt1' },
            { data: 'quarterCost1' },
            { data: 'qty1' },
            { data: 'cost1' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty1']) / parseFloat(row['quarterCnt1'])) * 100;
                	if(row['qty1'] == '0' || row['quarterCnt1'] == null){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['cost1']) / parseFloat(row['quarterCost1']))  * 100;
            		if(row['cost1'] == '0' || row['quarterCost1'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
					
				}
			},
			{ data: 'quarterCnt2' },
            { data: 'quarterCost2' },
            { data: 'qty2' },
            { data: 'cost2' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty2']) / parseFloat(row['quarterCnt2'])) * 100;
            		if(row['qty2'] == '0' || row['quarterCnt2'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost2']) / parseFloat(row['quarterCost2']) )  * 100;
            		if(row['cost2'] == '0' || row['quarterCost2'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'quarterCnt3' },
            { data: 'quarterCost3' },
            { data: 'qty3' },
            { data: 'cost3' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty3']) / parseFloat(row['quarterCnt3'])) * 100;
            		if(row['qty3'] == '0' || row['quarterCnt3'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost3'] /parseFloat(row['quarterCost3']) )) * 100;
            		if(row['cost3'] == '0' || row['quarterCost3'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
			{ data: 'quarterCnt4' },
            { data: 'quarterCost4' },
            { data: 'qty4' },
            { data: 'cost4' },
            {
            	render: function(data, type, row) {
            		var result = (parseFloat(row['qty4']) / parseFloat(row['quarterCnt4'])) * 100;
            		if(row['qty4'] == '0' || row['quarterCnt4'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			 },
		    {
            	render: function(data, type, row) {
            		var result = ( parseFloat(row['cost4']) / parseFloat(row['quarterCost4']))  * 100;
            		if(row['cost4'] == '0' || row['quarterCost4'] == '0'){
                		return '0%';                    	
                   	} else{
                   		return result.toFixed(2) + '%';                   		
                    }
				}
			},
                
        ],
        columnDefs: [
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ]           
        ],
        buttons: [
            {
                extend: 'copy',
                title: '분기별 매출계획대비 실적',
            },
            {
                extend: 'excel',
                title: '분기별 매출계획대비 실적',
            },
            {
                extend: 'print',
                title: '분기별 매출계획대비 실적',
            },
        ],
        drawCallback: function () {
			//전역변수들
			var sum1 = $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).data().sum();
			var sum2 = $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).data().sum();
			var sum3 = $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).data().sum();
			var sum4 = $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).data().sum();
			var sum5 = $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).data().sum();
			var sum6 = $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sum7 = $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sum8 = $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sum9 = $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sum10 = $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).data().sum();
			var sum11 = $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).data().sum();
			var sum12 = $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sum13 = $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sum14 = $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sum15 = $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sum16 = $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).data().sum();
			var sum17 = $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).data().sum();
			var sum18 = $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).data().sum();
			var sum19 = $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).data().sum();
			var sum20 = $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).data().sum();
			var sum21 = $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).data().sum();
			var sum22 = $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).data().sum();
			var sum23 = $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).data().sum();
			var sum24 = $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).data().sum();			
			
			$('#sum1').text(addCommas(sum1.toFixed(0)));
			$('#sum2').text(addCommas(sum2.toFixed(0)));
			$('#sum3').text(addCommas(sum3.toFixed(0)));
			$('#sum4').text(addCommas(sum4.toFixed(0)));

			if(sum1 == '0' || sum3 == '0'){
				$('#sum5').text('0.00%');                    	
           	} else{
           		$('#sum5').text(addCommas((sum3/sum1*100).toFixed(2)) + '%');                  		
            }
			if(sum2 == '0' || sum4 == '0'){
				$('#sum6').text('0.00%');                    	
           	} else{
           		$('#sum6').text(addCommas((sum4/sum2*100).toFixed(2)) + '%');              		
            }
			
			
			$('#sum7').text(addCommas(sum7.toFixed(0)));
			$('#sum8').text(addCommas(sum8.toFixed(0)));
			$('#sum9').text(addCommas(sum9.toFixed(0)));
			$('#sum10').text(addCommas(sum10.toFixed(0)));

			if(sum7 == '0' || sum9 == '0'){
				$('#sum11').text('0.00%');                    	
           	} else{
           		$('#sum11').text(addCommas((sum9/sum7*100).toFixed(2)) + '%');                  		
            }
			if(sum8 == '0' || sum10 == '0'){
				$('#sum12').text('0.00%');                    	
           	} else{
           		$('#sum12').text(addCommas((sum10/sum8*100).toFixed(2)) + '%');              		
            }            
		
			
			$('#sum13').text(addCommas(sum13.toFixed(0)));			
			$('#sum14').text(addCommas(sum14.toFixed(0)));
			$('#sum15').text(addCommas(sum15.toFixed(0)));
			$('#sum16').text(addCommas(sum16.toFixed(0)));

			if(sum13 == '0' || sum15 == '0'){
				$('#sum17').text('0.00%');                    	
           	} else{
           		$('#sum17').text(addCommas((sum15/sum13*100).toFixed(2)) + '%');                  		
            }
			if(sum14 == '0' || sum16 == '0'){
				$('#sum18').text('0.00%');                    	
           	} else{
           		$('#sum18').text(addCommas((sum16/sum14*100).toFixed(2)) + '%');              		
            }
    
			$('#sum19').text(addCommas(sum19.toFixed(0)));			
			$('#sum20').text(addCommas(sum20.toFixed(0)));
			$('#sum21').text(addCommas(sum21.toFixed(0)));
			$('#sum22').text(addCommas(sum22.toFixed(0)));

			if(sum19 == '0' || sum21 == '0'){
				$('#sum23').text('0.00%');                    	
           	} else{
           		$('#sum23').text(addCommas((sum21/sum19*100).toFixed(2)) + '%');                  		
            }
			if(sum20 == '0' || sum22 == '0'){
				$('#sum24').text('0.00%');                    	
           	} else{
           		$('#sum24').text(addCommas((sum22/sum20*100).toFixed(2)) + '%');              		
            }
			$('#my-spinner').hide();	
            
            

        }
    });

	$.fn.dataTable.ext.errMode = 'none';
	let performanceAginstPlanTable = $('#performanceAginstPlanTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",        
        language: lang_kor,
        paging: false,
        info: true,
        searching : false,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,	   
        lengthChange : false,
        pageLength: 10000,
        scrollY: '58vh',
        ajax: {
            url: '<c:url value="/wm/readPerformanceAgainstPlan"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
	           	'planDate': function() { return chooseDateToModal.substring(0,4); },        	
	         		           	 
            },	           
        },	       
        columns: [
        	{ data: 'gubun',
        		render: function(data, type, row, meta) {	       
        			let html = '';						
					return selectBoxHtml2(gubunCode,"gubun", data, row, meta);				
                    
        		}
    		},          
        	<c:forEach var="item" begin="1" end="12" step="1">
         	{ data: 'fpDate${item}' ,
        		render: function(data, type, row) {
	       
        			if(data == null || data == 'null'){        	        			
                		let html = '<input type="text" class="form-control text-center" id="'+row["gubun"]+'fpDate${item}" name="fpDate' + '${item}'+ '" value = ' + "" + '>';
						return html;    	                			
                	} else{ 
                		let html = '<input type="text" class="form-control text-center" id="'+row["gubun"]+'fpDate${item}" name="fpDate' + '${item}'+ '" value = ' + addCommas(Math.floor(data)) + '>';    	                    		
						return html;
                	}
                    
        		}
    		},    		
		</c:forEach>
	       
       
        ],
        columnDefs: [
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12], className: 'text-right-td' },
        ],
        drawCallback: function () {
        	
        	//$('#performanceAginstPlanTable').DataTable().draw(false).columns.adjust();
        }
	});

	$('#btnRetv').on('click',function(){
		$('#my-spinner').show();		
		chooseDateTo = $('#chooseDateTo').val().substring(0,4);
		if(tabStat == 'tab1'){
			$('#firstTable').DataTable().ajax.reload();
			//$('#secondTable').DataTable().ajax.reload();
			$('#firstTable').DataTable().draw(false).columns.adjust();
			//$('#secondTable').DataTable().draw(false).columns.adjust();
		} else{
			$('#salesPlanInfoTable2').DataTable().ajax.reload();		
		}
		
		
	});

	function setDateBox(){
       var dt = new Date();
       var year = "";
       var com_year = dt.getFullYear();
       // 발행 뿌려주기
      // $("#chooseDate1").val(com_year);
       // 올해 기준으로 -1년부터 +5년을 보여준다.
       for(var y = (com_year-5); y <= (com_year+5); y++){
           $("#chooseDateTo").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
           $("#chooseDateToModal").append("<option value='"+ y +"'>"+ y + " 년" +"</option>");
       }
      // $("#chooseDate2").append("<option value=''>년도</option>");
       // 올해 기준으로 -1년부터 +5년을 보여준다.
      
       // 월 뿌려주기(1월부터 12월)
       $("#chooseDateTo").val(com_year);
       $("#chooseDateToModal").val(com_year);
     
	}
	

	
	$('#quarter').on('change',function(){
		if($('#quarter').val() == "1"){
			 $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "2"){
			 $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "3"){
			 $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(false);	
		} else if($('#quarter').val() == "4"){
			 $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(false);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(true);	
		} else{
			 $('#salesPlanInfoTable2').DataTable().column(1,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(2,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(3,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(4,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(5,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(6,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(7,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(8,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(9,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(10,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(11,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(12,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(13,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(14,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(15,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(16,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(17,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(18,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(19,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(20,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(21,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(22,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(23,{ page: 'all'} ).visible(true);
			 $('#salesPlanInfoTable2').DataTable().column(24,{ page: 'all'} ).visible(true);	
		}
		
	});

	let resizeTimer = false;    
	   $(window).on('resize', function(e) {
	        if( !resizeTimer ) {
	         $(window).trigger('resizestart');     
	      }
	      clearTimeout(resizeTimer);
	      resizeTimer = setTimeout(function() {
	         resizeTimer = false;
	         $(window).trigger('resizeend');
	      }, 50);
	   }).on('resizeend', function(){
	      dataTableDrawAll(); 
	   });

	 function dataTableDrawAll() {
		 $('.dataTables_wrapper').each(function(index, node) {
	         let datatableId = $(node).attr('id').split('_')[0];
	         $('#'+datatableId).DataTable().draw(false).columns.adjust();
	      });
	 }

	 $('#btnInsert').on('click',function(){		
		$('#chooseDateToModal').val(chooseDateToModal.substring(0,4));
		$('#performancePlanPopUpModal').modal('show');
		$('#performanceAginstPlanTable').DataTable().ajax.reload( function () {});
		
	});

	 $('#performancePlanPopUpModal').on('shown.bs.modal', function (e) {
		 $('#performanceAginstPlanTable').DataTable().draw(false).columns.adjust();
	});

	$('#btnSave').on('click', function () {
		let dataList = new Array();
		let check = true;
		let duple = [];

		if ( !$.trim($('#chooseDateToModal').val()) ) {
	            toastr.warning('일자를 입력해 주세요.');
	            $('#chooseDateToModal').focus();
	            return false;
	    }  	
        	
		if($('#performanceAginstPlanTable').DataTable().data().count() != 0){
			$('#performanceAginstPlanTable tbody tr').each(function(index,item){
				var rowData = new Object();
				if ( !$.trim($(this).find('select[name=gubun]').val()) ) {
		            toastr.warning('구분을 선택해 주세요.');
		            $(this).find('select[name=gubun]').focus();
		            check=false;
		            return false;
		   		 }				
				rowData.planDate = $('#chooseDateToModal').val();
				rowData.gubun = $(this).find('select[name=gubun]').val();
				duple[index] = $(this).find('select[name=gubun]').val();
				rowData.count1 = ($(this).find('input[name=fpDate1]').val()!=null && $(this).find('input[name=fpDate1]').val()!="") ? $(this).find('input[name=fpDate1]').val().replace(/,/g,"") : "0";   
				rowData.count2 = ($(this).find('input[name=fpDate2]').val()!=null && $(this).find('input[name=fpDate2]').val()!="") ? $(this).find('input[name=fpDate2]').val().replace(/,/g,"") : "0";   
				rowData.count3 = ($(this).find('input[name=fpDate3]').val()!=null && $(this).find('input[name=fpDate3]').val()!="") ? $(this).find('input[name=fpDate3]').val().replace(/,/g,"") : "0";   
				rowData.count4 = ($(this).find('input[name=fpDate4]').val()!=null && $(this).find('input[name=fpDate4]').val()!="") ? $(this).find('input[name=fpDate4]').val().replace(/,/g,"") : "0";   
				rowData.count5 = ($(this).find('input[name=fpDate5]').val()!=null && $(this).find('input[name=fpDate5]').val()!="") ? $(this).find('input[name=fpDate5]').val().replace(/,/g,"") : "0";   
				rowData.count6 = ($(this).find('input[name=fpDate6]').val()!=null && $(this).find('input[name=fpDate6]').val()!="") ? $(this).find('input[name=fpDate6]').val().replace(/,/g,"") : "0";   
				rowData.count7 = ($(this).find('input[name=fpDate7]').val()!=null && $(this).find('input[name=fpDate7]').val()!="") ? $(this).find('input[name=fpDate7]').val().replace(/,/g,"") : "0";   
				rowData.count8 = ($(this).find('input[name=fpDate8]').val()!=null && $(this).find('input[name=fpDate8]').val()!="") ? $(this).find('input[name=fpDate8]').val().replace(/,/g,"") : "0";   
				rowData.count9 = ($(this).find('input[name=fpDate9]').val()!=null && $(this).find('input[name=fpDate9]').val()!="") ? $(this).find('input[name=fpDate9]').val().replace(/,/g,"") : "0";   
				rowData.count10 = ($(this).find('input[name=fpDate10]').val()!=null && $(this).find('input[name=fpDate10]').val()!="") ? $(this).find('input[name=fpDate10]').val().replace(/,/g,"") : "0";   
				rowData.count11 = ($(this).find('input[name=fpDate11]').val()!=null && $(this).find('input[name=fpDate11]').val()!="") ? $(this).find('input[name=fpDate11]').val().replace(/,/g,"") : "0";   
				rowData.count12 = ($(this).find('input[name=fpDate12]').val()!=null && $(this).find('input[name=fpDate12]').val()!="") ? $(this).find('input[name=fpDate12]').val().replace(/,/g,"") : "0";   
	
				 
				dataList.push(rowData);
			});
		} else{
			toastr.warning('데이터를 입력해 주세요.');
			return false;
		}

		if(check){
			const set = new Set(duple);
			if(set.size != duple.length){
				check = false;
				toastr.warning('중복된 구분을 선택하실 수 없습니다.');
				return false;
			}
		}
		console.log(duple);	
		
		
		if(check){
			$('#my-spinner').show();
			$.ajax({
	            url: '<c:url value="/wm/createPerformanceAgainstPlan"/>',
	            type: 'POST',
	            data: JSON.stringify(dataList),
	            dataType:"json",
	            contentType : "application/json; charset=UTF-8",      
	   
	            success: function (res) {
	                let data = res.data;      
	                if (res.result == 'ok') {
	                	$('#performanceAginstPlanTable').DataTable().ajax.reload( function () {});
	                	$('#firstTable').DataTable().ajax.reload( function () {});    
	                	
	                	            	
	                	toastr.success("저장되었습니다.");
						
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		}
		

		
	});

	$('#rowAdd').on('click', function() {		
		if($('#performanceAginstPlanTable').DataTable().data().count() >= 5){
			toastr.warning("5라인이 최대입니다.");
			return false;
		}
		
		$('#performanceAginstPlanTable').DataTable().row.add({}).draw();
		
	});

 	let diIdx = '';
 	$(document).on('click','#performanceAginstPlanTable_wrapper tbody tr', function(event) {   
 		if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');           
        }
        else {
        	$('#performanceAginstPlanTable').DataTable().$('tr.selected').removeClass('selected');
        	$('#performanceAginstPlanTable_wrapper tr.selected').removeClass('selected');
            $(this).addClass('selected');
            diIdx = $('#performanceAginstPlanTable').DataTable().row(this).index();		
        }
        
 		
	  });

 	$('#rowDelete').on('click', function () {
 		$('#performanceAginstPlanTable').DataTable().rows(diIdx).remove().draw();
 		 diIdx = '';
 	});

 	$('#modelRetv').on('click', function () {	
 	 	
 		$('#performanceAginstPlanTable').DataTable().ajax.reload( function () {});     	
 		             
 	});

 	function selectBoxHtml2(obj, id, sVal, row, meta)
	{
	
		var shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '"><option value="">선택</option>';
		
		
		var option;
		for(key in obj) {
			var tmp; 
			if(obj[key].baseCd == sVal ) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseNm+"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+obj[key].baseNm+"</option>";
			}	
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option + ehtml;
	}
		

</script>

</body>
</html>