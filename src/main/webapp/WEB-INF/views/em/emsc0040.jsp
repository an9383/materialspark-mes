<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">설비관리</a></li>
				<li class="breadcrumb-item active">설비고장/수리이력관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 71%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"  class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="repairTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>등록일</th>
									<th>설비코드</th>
									<th>설비명</th>									
									<th>발생일</th>
									<th>수리일</th>
									<th>현상</th>
									<th>원인</th>
									<th>조치 및 대책</th>
									<th>수리업체</th>
									<th>수리내용</th>									
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>				
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 28%;">
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()">
							<i class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
						<button type="button" class="btn btn-primary float-right mr-1"	id="btnAdd">등록</button>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-bordered">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr>
									<th>*등록번호</th>
									<td>
										<input type="text" class="form-control" id="repairNo"	name="repairNo" disabled>										
									</td>	
									<th></th>
									<td></td>	
								</tr>
								<tr>
									<th>*설비코드</th>
									<td><input type="text" class="form-control" id="equipCd" name="equipCd" disabled></td>
										
									<th>*설비명</th>
									<td><div class="input-sub m-0">
										<input type="text" class="form-control" id="equipNm" name="equipNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search" id="btnEquipNm" >
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
									</td>
								</tr>
								<tr>
									<th>*발생일</th>
									<td><div class="form-group input-sub m-0">
										  <input class="form-control" type="text" id="troubleDate" name="troubleDate" disabled>
										  <button onclick="fnPopUpCalendar(troubleDate,troubleDate,'yyyy-mm-dd');"  class="btn btn-secondary input-sub-search" id="btnTroubleDate" name="btnTroubleDate" type="button" >
										   <span class="oi oi-calendar"></span>
										  </button> 
										</div>
									</td>
									<th>*발생시</th>
									<td><input type="text" class="form-control" id="troubleDateTime" name="troubleDateTime" placeholder="HH:MM" disabled></td>									
									
								</tr>
								<tr>
									<th>*수리일</th>
										<td><div class="form-group input-sub m-0">
											  <input class="form-control" type="text" id="repairDate" name="repairDate" disabled>
											  <button onclick="fnPopUpCalendar(repairDate,repairDate,'yyyy-mm-dd');"  class="btn btn-secondary input-sub-search" id="btnRepairDate" name="btnRepairDate" type="button" >
											   <span class="oi oi-calendar"></span>
											  </button> 
											</div>
										</td>
									<th>*수리시</th>
									<td><input type="text" class="form-control" id="repairDateTime" name="repairDateTime" placeholder="HH:MM" disabled></td>																	
								</tr>
								<tr>
									<th>*조치자</th>
									<td>
										<div class="input-sub m-0">
											<input type="text" class="form-control" id="troubleCharger" name="troubleCharger" disabled>
											<button type="button" class="btn btn-primary input-sub-search" id="btnTroubleCharger" >
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
									</td>
								<th>중단시간</th>
									<td><input type="text" class="form-control" id="stopTime" name="stopTime"></td>
								</tr>
								<tr>
									<th>현상</th>
									<td colspan="3"><input type="text" class="form-control" id="troubleState" name="troubleState" style="max-width:100%;" ></td>									
								</tr>															
								<tr>
									<th>원인</th>
									<td colspan="3"><input type="text" class="form-control" id="troubleCause" name="troubleCause" style="max-width:100%;"></td>								
								</tr>
								<tr>
									<th>조치 및 대책</th>
									<td colspan="3"><input type="text" class="form-control" id="actPlan" name="actPlan" style="max-width:100%;"></td>
								</tr>
								<tr>
									<th>수리업체명</th>
									<td><div class="input-sub m-0">
										<input type="text" class="form-control" id="repairDealCorpNm" name="repairDealCorpNm" disabled>
										<input type="hidden" id="repairDealCorpCd">
										<button type="button" class="btn btn-primary input-sub-search" id="btnRepairDealCorpNm">
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
								    </td>
									<th>수리시간</th>
									<td><input type="text" class="form-control" id="repairTime" name="repairTime"></td>
								</tr>
								<tr>
									<th>수리내용</th>
									<td colspan="3"><input type="text" class="form-control" id="repairContent" name="repairContent" style="max-width:100%;"></td>									
								</tr>
								<tr>
									<th>사용부품 내역</th>
									<td colspan="3"><input type="text" class="form-control" id="repairMatrl" name="repairMatrl" style="max-width:100%;"></td>							
								</tr>
								<tr>
									<th>비고</th>
									<td colspan="3"><input type="text" class="form-control" id="repairDesc" name="repairDesc" style="max-width:100%;"></td>
								</tr>
							</table>
						</div>
					</form>
				</div>
				<input type="hidden" id="repairNo">
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
						<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
					</button>
					
				</div>
			</div>
			
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->


<%@include file="../layout/bottom.jsp" %>


<script>

	let menuAuth = 'emsc0040';
	let currentHref = 'emsc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","설비고장/수리이력관리");

	var repairDateFrom =  "${repairDateFrom}";
	var repairDateTo =  "${repairDateTo}";
	var sideView;
	uiProc(true);
	
	//테이블 목록
	$.fn.dataTable.ext.errMode = 'none';
	let repairTable = $('#repairTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : 20,
		//ordering: false,
		ajax : {
			url : '<c:url value="em/repairDataList"/>',
			type : 'GET',
			data : {
				'menuAuth'	 : menuAuth,
				'repairDateFrom': function() { return repairDateFrom; },
   	           	'repairDateTo': function() { return repairDateTo; },
			},
		},
		rowId : 'equipCd',
		columns : 
			[ 
				{data : 'repairRegDate',
					 render: function(data, type, row) {		
						 if(moment(data).format('YYYY-MM-DD') != "Invalid date"){
							return moment(data).format('YYYY-MM-DD');
						 } else{
							 return "";
						 }
		              } 
				}, 
				{data : 'equipCd'},
				{data : 'equipNm'},
				{data : 'troubleDate'},
				{data : 'repairDate'},
				{data : 'troubleState'},
				{data : 'troubleCause'},
				{data : 'actPlan'},
				{data : 'repairDealCorpNm'},
				{data : 'repairContent'}	
			
		],
	    order: [
	        [ 0, 'asc' ]
	    ],
        buttons: [
            {
			    extend: 'copy',
			    title: '설비고장/수리이력관리',
			},
			{
			    extend: 'excel',
			    title: '설비고장/수리이력관리',
			},
			            {
			    extend: 'print',
			    title: '설비고장/수리이력관리',
			},
		],
	});
	
	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm">등록일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="From" name="From" />';
	html1 += '<button onclick="fnPopUpCalendar(From,From,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="To" name="To" />';
	html1 += '<button onclick="fnPopUpCalendar(To,To,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateToCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';	
	html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>'
	html1 += '</div>';
	
	$('#repairTable_length').html(html1);
	$('#From').val(repairDateFrom);
	$('#To').val(repairDateTo);
	  	
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#From').val());
		let dateTo = new Date($('#To').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#inWhsDateFromCalendar').focus();
			return false;
		}
		
    	repairDateFrom = $('#From').val();
    	repairDateTo = $('#To').val();
    	
		$('#repairTable').DataTable().ajax.reload();
	});
	
	//테이블 클릭
	$('#repairTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
			$('#btnSave').addClass('d-none');
		} else {
			$('#repairTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		repairNo = repairTable.row(this).data().repairNo;
		console.log("repairNo = " + repairNo);
		$('#btnSave').addClass('d-none'); // 저장버튼
		$('#btnEdit').attr('disabled', false); //수정버튼
		
		$.ajax({
			url : '<c:url value="em/repairDataView"/>',
			type : 'GET',
			data : {
				'menuAuth'	 : menuAuth,
				'repairNo' : repairNo				
			},
			success : function(res) {
				let data = res.data;
				sideView = 'edit';

				$('#repairNo').val(data.repairNo);				
				$('#equipCd').val(data.equipCd);
				$('#equipNm').val(data.equipNm);				
				$('#troubleDate').val(moment(data.troubleDate.substring(0,7)).format('YYYY-MM-DD'));
				$('#troubleDateTime').val(data.troubleDateTime);
				$('#repairDate').val(moment(data.repairDate.substring(0,7)).format('YYYY-MM-DD'));
				$('#repairDateTime').val(data.repairDateTime);
				$('#troubleCharger').val(data.troubleCharger);						
				$('#stopTime').val(data.stopTime);
				$('#troubleState').val(data.troubleState);
				$('#troubleCause').val(data.troubleCause);
				$('#actPlan').val(data.actPlan);
				$('#repairDealCorpNm').val(data.repairDealCorpNm);
				$('#repairTime').val(data.repairTime);
				$('#repairContent').val(data.repairContent);
				$('#repairMatrl').val(data.repairMatrl);
				$('#repairDesc').val(data.repairDesc);
				//화면처리
				uiProc(true);		
			}
		});
	});
	
	// 등록폼
	$('#btnAdd').on('click', function() {
		sideView = 'add';
		$('#form').each(function() {
			this.reset();
		});
		//화면처리        
		uiProc(false);
		seq();
		$('#btnEdit').attr('disabled', true); //수정버튼
		$('#btnSave').removeClass('d-none'); // 저장버튼
	});

	// 저장 처리
	$('#btnSave').on('click',function() {
		if (!$.trim($('#repairNo').val())) {
			toastr.warning('등록번호를 입력 해주세요.');
			$('#repairRegDate').focus();
			return false;
		} else if (!$.trim($('#equipCd').val())) {
			toastr.warning('설비명을 선택해 주세요.');
			$('#btnEquipNm').focus();
			return false;
		} else if (!$.trim($('#troubleDate').val())) {
			toastr.warning('발생일을 선택해주세요.');
			$('#btnTroubleDate').focus();
			return false;
		}else if (!$.trim($('#troubleDateTime').val())) {
			toastr.warning('발생시를 입력해주세요.');
			$('#troubleDateTime').focus();
			return false;
		} else if (!$.trim($('#repairDate').val())) {
			toastr.warning('수리일를 선택해주세요.');
			$('#btnRepairDate').focus();
			return false;
		} else if (!$.trim($('#repairDateTime').val())) {
			toastr.warning('수리시를 입력해주세요.');
			$('#repairDateTime').focus();
			return false;		
		}  else if (!$.trim($('#troubleCharger').val())) {
			toastr.warning('조치자를 선택해주세요.');
			$('#btnTroubleCharger').focus();
			return false;			
		} /*else if (!$.trim($('#stopTime').val())) {
			toastr.error('중단시간을 입력해주세요.');
			$('#stopTime').focus();
			return false;
		}  else if (!$.trim($('#troubleState').val())) {
			toastr.error('현상을 입력해주세요.');
			$('#troubleState').focus();
			return false;
		} else if (!$.trim($('#troubleCause').val())) {
			toastr.error('원인을 입력해주세요.');
			$('#troubleCause').focus();
			return false;
		} else if (!$.trim($('#actPlan').val())) {
			toastr.error('조치 및 대책을 입력해주세요.');
			$('#actPlan').focus();
			return false;
		} else if (!$.trim($('#repairDealCorpNm').val())) {
			toastr.error('수리업체명을 입력해주세요.');
			$('#repairDealCorpNm').focus();
			return false;
		} else if (!$.trim($('#repairTime').val())) {
			toastr.error('수리시간을 입력해주세요.');
			$('#repairTime').focus();
			return false;
		} else if (!$.trim($('#repairContent').val())) {
			toastr.error('수리내용을 입력해주세요.');
			$('#repairContent').focus();
			return false;
		} else if (!$.trim($('#repairMatrl').val())) {
			toastr.error('사용자재 내역을 입력해주세요.');
			$('#repairMatrl').focus();
			return false;
		} */
		var url = '<c:url value="em/equipRepairHistAdmCreate"/>';
		if (sideView == "edit") {
			url = '<c:url value="em/equipRepairHistAdmUpdate"/>';
		}
		$.ajax({
			url : url,
			type : 'POST',
			data : {
				'menuAuth'	 	: 		menuAuth,
				'repairNo'			: $('#repairNo').val(),			
				'equipCd' 			: $('#equipCd').val(),
				'equipNm' 			: $('#equipNm').val(),
				'troubleDate' 		: $('#troubleDate').val().replace(/-/g, '') + " " + $('#troubleDateTime').val(),			
				'repairDate' 		: $('#repairDate').val().replace(/-/g, '') + " " + $('#repairDateTime').val(),				
				'troubleCharger' 	: $('#troubleCharger').val(),
				'stopTime' 			: $('#stopTime').val(),
				'troubleState' 		: $('#troubleState').val(),
				'troubleCause' 		: $('#troubleCause').val(),
				'actPlan'			: $('#actPlan').val(),
				'repairDealCorpNm' 	: $('#repairDealCorpNm').val(),
				'repairDealCorpCd' 	: $('#repairDealCorpCd').val(),
				'repairTime' 		: $('#repairTime').val(),
				'repairContent'		: $('#repairContent').val(),
				'repairMatrl' 		: $('#repairMatrl').val(),
				'repairDesc' 		: $('#repairDesc').val()				
				
			},
			beforeSend : function() {
				// $('#btnAddConfirm').addClass('d-none');
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기					
					$('#repairTable').DataTable().ajax.reload();
					uiProc(true);					
					$('#btnSave').addClass('d-none');
					
					if (sideView == "edit") {
						toastr.success('수정되었습니다.');
					} else {
						toastr.success('등록되었습니다.');
					}
					sideView = 'edit';
				}else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete : function() {				
			
			}
		});
	});

	// 수정폼
	$('#btnEdit').on('click', function() {
		if (sideView != 'edit') {
			toastr.warning("수정할 목록을 선택해 주세요!");
			return false;
		}
		uiProc(false);
		$('#btnSave').removeClass('d-none');
	});
	
	var equipCdPopUpTable; // 설비명 모달
	$('#btnEquipNm').on('click',function(){
		if(equipCdPopUpTable == null || equipCdPopUpTable == undefined)	{
			equipCdPopUpTable = $('#equipCdPopUpTable').DataTable({
			       language: lang_kor,	        
			       lengthChange : false,
			       paging: true,
			       info: true,
			       ordering: true,
			       processing: true,
			       autoWidth: false,
			       ajax: {
			           url: '<c:url value="bm/equipCodeAdmDataList"/>',
			           type: 'GET',
			           data: {
				           'menuAuth'	 	: 		menuAuth,
						},	          
			       },	       
			       rowId: 'equipCd',
			       columns: [
						{ data: 'equipCd' },
			            { data: 'equipNm' },
			            { data: 'equipGroupNm' },
			            { data: 'equipCtrgyNm' },
			            { data: 'modelNm' },
			            { data: 'mfcDealCorpNm' }
			         
			       ],
			       columnDefs: [
			          	{"className": "text-center", "targets": "_all"},
			       ],
			       order: [
			           [ 1, 'asc' ]
			       ],	
			});
			
			$('#equipCdPopUpTable tbody').on('click', 'tr', function () {		    
			  	var data = equipCdPopUpTable.row( this ).data();	    	
				$('#equipNm').val(data.equipNm);
				$('#equipCd').val(data.equipCd);
			    $('#equipPopUpModal').modal('hide');
			});			
		} else{
			$('#equipCdPopUpTable').DataTable().ajax.reload();
		}
		
		$('#equipPopUpModal').modal('show');		  
	});
	
   	var userPopUpTable; // 조치자 모달
   	$('#btnTroubleCharger').on('click',function(){
 		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'userNumber',
		        columns: [
						{ data : 'userNm'}, 
						{ data : 'departmentNm'	}, 
						{ data : 'postNm' }, 
						{ data : 'chargrDutyNm'	}, 
						{ data : 'teamNm' }, 
						{ data : 'workplaceNm' },
		        ],
		        columnDefs: [
		        	//{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'desc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = userPopUpTable.row( this ).data();
                $('#troubleCharger').val(data.userNm);               
                $('#userPopUpModal').modal('hide');
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		
		$('#userPopUpModal').modal('show');	
   	});
	
	var dealCorpPopUpTable; //수리 업체명 모달
	$('#btnRepairDealCorpNm').on('click',function(){
		
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 : menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });
		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();	
		    	$('#repairDealCorpCd').val(data.dealCorpCd);
				$('#repairDealCorpNm').val(data.dealCorpNm);		   
				$('#dealCorpPopUpModal').modal('hide');
			});		    
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		
		$('#dealCorpPopUpModal').modal('show');		
	}); 

	function uiProc(flag) {
		$("#troubleDate").attr("disabled", flag);
		$("#repairDate").attr("disabled", flag);	
		$("button[name=btnTroubleDate]").attr("disabled", flag);
		$("button[name=btnRepairDate]").attr("disabled", flag);		
		$("#btnEquipNm").attr("disabled", flag);
		$("#btnTroubleCharger").attr("disabled", flag);
		$("#btnRepairDealCorpNm").attr("disabled", flag);							
		$("#troubleDateTime").attr("disabled", flag);
		$("#repairDateTime").attr("disabled", flag);			
		$('#stopTime').attr('disabled', flag);
		$("#troubleState").attr("disabled", flag);
		$("#troubleCause").attr("disabled", flag);
		$("#actPlan").attr("disabled", flag);		
		$("#repairTime").attr("disabled", flag);
		$("#repairContent").attr("disabled", flag);
		$("#repairMatrl").attr("disabled", flag);
		$("#repairDesc").attr("disabled", flag);
	}
	
	function seq(){ //repairNo생성 시퀀스
   		$.ajax({
   			url: '/em/repairNoCreate',
	        type: 'POST',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
			},
	        success: function (res) {
	        	$('#repairNo').val(res.data.repairNo);	        	
	        }
   		});
   	}
   	
</script>

</body>
</html>
