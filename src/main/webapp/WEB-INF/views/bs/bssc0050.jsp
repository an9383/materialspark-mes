<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!-- Modal Start-->
	<div class="modal fade" id="itemPopupModal" tabindex="-1" role="dialog" aria-labelledby="itemPopupLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="itemPopupLabel">품목추가</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="table-responsive" style="height: 650px">
						<table id="itemPopupTable" class="table table-sm table-bordered">
							<colgroup>
								<col width="4%">
								<col width="10%">
								<col width="20%">
								<col width="20%">
								<col width="8%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th><input type="checkbox" id="checkboxAll2" name="checkboxAll2" value=""></th>
									<th>차종</th>
									<th>품번</th>
									<th>품명</th>
									<th>LH/RH</th>
									<th>색상</th>
									<th class="text-center">포장수량</th>
									<th class="text-center">현재고수량</th>
									<th>단위</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="modal-footer">
						<input type="hidden" class="form-control" id="puFlag" name="puFlag" >
						<button type="button" class="btn btn-primary" id="btnGetAll">가져오기</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal End-->
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">출고의뢰등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="overflow: hidden;">
				<div class="card">
					<div class="row" style="height : 420px">
						<div class="table-responsive">
							<table id="deliveryOrderAdmTable" class="table table-bordered">
								<colgroup>
									<col width="9%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="12%">
									<col width="9%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>발주처</th>
										<th>차종</th>
										<th>품번</th>
										<th>품명</th>
										<th class="text-center">출고지시량</th>
										<th class="text-center">출고량</th>
										<th class="text-center">미출고량</th>
										<th>출고지시일</th>
										<th>납품장소</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-4">
							<!--오른쪽 등록 부분 상단 버튼 영역-->
							<div class="card-body col-sm-12 p-1">
								<button type="button" class="btn btn-warning float-right mr-1" id="btnDel">삭제</button>
								<button type="button" class="btn btn-primary float-right mr-1" id="btnEdit">수정</button>
								<button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
							</div>
							<!--/오른쪽 등록 부분 상단 버튼 영역-->
							<form id="form">
								<div class="table-responsive">
									<table class="table table-bordered">
										<colgroup>
											<col width="25%">
											<col width="25%">
											<col width="25%">
											<col width="25%">
										</colgroup>
										<thead class="thead-light">
											<tr>
												<th>출고지시일</th>
												<td>
													<div class="form-group input-sub m-0 row">
														<input class="form-control" style="width: 100%;" type="text"
															id="doDate" name="doDate" disabled />
														<button onclick="fnPopUpCalendar(doDate,doDate,'yyyy-mm-dd')"
															class="btn btn-secondary input-sub-search"
															id="doDateCalendar" type="button">
															<span class="oi oi-calendar"></span>
														</button>
													</div>
												</td>
												<th></th>
												<td></td>
											</tr>
											<tr>
												<th>발주처</th>
												<td>
													<div class="input-sub m-0" style="width: 100%">
														<input type="hidden" class="form-control" id="poCorpCd" name="poCorpCd" disabled/> 
														<input type="text" class="form-control" id="poCorpNm" name="poCorpNm" disabled/>
														<button type="button" class="btn btn-primary input-sub-search" id="btnPoCorpCd" onclick="selectPoCorpCd()">
															<span class="oi oi-magnifying-glass"></span>
														</button>
													</div>
												</td>
												<th>납품장소</th>
												<td>
													<div class="input-sub m-0" style="width: 100%">
														<input type="hidden" class="form-control" id="doCorpCd" name="doCorpCd" disabled /> 
														<input type="text" class="form-control" id="doCorpNm" name="doCorpNm" disabled />
														<button type="button" class="btn btn-primary input-sub-search" id="btnDoCorpCd" onclick="selectDoCorpCd()">
															<span class="oi oi-magnifying-glass"></span>
														</button>
													</div>
												</td>
											</tr>
										</thead>
									</table>
								</div>
							</form>
						</div>
						<div class="col-8">
							<div class="card-body col-sm-12 pb-0">
								<button type="button" class="btn btn-info float-left mr-3" id="btnSelectItem" onclick="selectItem()" disabled>품목추가</button>
								<div class="form-group input-sub float-left mr-1 row">
									<input class="form-control" style="width: 100%;" type="text" id="allDoDate" name="allDoDate" disabled />
									<button onclick="fnPopUpCalendar(allDoDate, allDoDate, 'yyyy-mm-dd')"
										class="btn btn-secondary input-sub-search" id="allDoDateCalendar" type="button" disabled>
										<span class="oi oi-calendar"></span>
									</button>
								</div>
								<button type="button" class="btn btn-info float-left" id="btnAllDoDate" disabled>납기일 적용</button>
								<button type="button" class="btn btn-primary float-right d-none" id="btnSave">저장</button>
								<button type="button" class="btn btn-warning float-right mr-1" id="btnItemDel" disabled>품목삭제</button>
							</div>
							<table class="table table-bordered" id="deliveryOrderDtlTable">
								<colgroup>
									<col width="4%">
									<col width="10%">
									<col width="15%">
									<col width="15%">
									<col width="8%">
									<col width="9%">
									<col width="9%">
									<col width="8%">
									<col width="12%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th><input type="checkbox" id="checkboxAll3" name="checkboxAll3" value=""></th>
										<th>차종</th>
										<th>품번</th>
										<th>품명</th>
										<th>LH/RH</th>
										<th>색상</th>
										<th class="text-center">포장수량</th>
										<th>단위</th>
										<th>납기일</th>
										<th class="text-center">출고지시량</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
			</div>
			<!-- /.left-list -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>
	
	let currentHref = "bssc0050";
	let currentPage = $('.' + currentHref).attr('id');
	
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');  
	$(document).attr("title","출고의뢰등록"); 
	
	let viewIdx;
	let sideView = 'add';
	let btnView = 'add';
	uiProc(true);
	uiProc2(true);
	
	var doNo;
	var doSeq;
	var doDate;
	var doCorpCd;
	var doCorpNm;
	var poCorpCd;
	var poCorpNm;
	var index=0;
	var tableIdx;
	var itemSeq;
	var poCorpCd = '';
	
	var serverDateFrom =  "${serverDateFrom}";
	var serverDateTo=  "${serverDateTo}";
	var serverDate =  "${serverDateTo}";
	
	$('#doDate').val(serverDate);
	$('#allDoDate').val(serverDate);
	
	var poCorpNmgubun = new Array();
	<c:forEach items="${poCorpNmgubun}" var="info">
	var json = new Object();
	json.baseCd = "${info.dealCorpCd}";
	json.baseNm = "${info.dealCorpNm}";
	poCorpNmgubun.push(json);
	</c:forEach>

	$('#saveBtnModalY').on('click', function() {
		$('#form').each(function() {
	         this.reset();
	         $('input[type=hidden]').val('');
	    });
	    sideView = 'add';
		uiProc(true);
		uiProc2(true);
		
		$('#doDate').val(serverDate);
		$('#btnSave').addClass('d-none');
		$('#btnAdd').attr('disabled', false);
		$('#btnEdit').attr('disabled', false);
		$('#btnDel').attr('disabled', false);
		$('#btnSelectItem').attr('disabled', true);
		$('#allDoDateCalendar').attr('disabled', true);
		$('#btnAllDoDate').attr('disabled', true);
		$('#btnItemDel').attr('disabled', true);
		deliveryOrderDtlTable.clear().draw();
		$('#deliveryOrderAdmTable').dataTable().$('tr.selected').removeClass('selected');
	});
	
	//출고의뢰등록 목록조회
	let deliveryOrderAdmTable = $('#deliveryOrderAdmTable').DataTable({
	    dom: "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-5'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,	
			destroy : true,	
			paging : true,
			searching : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			lengthChange : true,
			pageLength : 10,
		ajax : {
			url : '<c:url value="bs/deliveryOrderAdmList"/>',
			type : 'GET',
			data : {				
				'startDate': function() { return serverDateFrom.replace(/-/g, ''); },
	           	'endDate': function() { return serverDateTo.replace(/-/g, ''); },
	           	'poCorpCd': function() { return poCorpCd; },
			}	
		},	
		rowId : '',
		columns : [ 
				{data :'poCorpNm'},
				{data :'itemModelNm'},
				{data :'itemCd'},
				{data :'itemNm'},
				{data: 'targetQty',
					render: function(data, type, row, meta) {
						if(data != null){
							return addCommas(data);
						} 
					}, "className": "text-right" 	
				},
				{data: 'outputQty',
					render: function(data, type, row, meta) {
						if(data != null){
							return addCommas(data);
						} 
					}, "className": "text-right" 	
				},
				{data: 'remainQty',
					render: function(data, type, row, meta) {
						if(data != null){
							return addCommas(data);
						} 
					}, "className": "text-right" 	
				},
				{data :'doDate',
					render : function(data, type, row, meata){
						return moment(data).format("YYYY-MM-DD");
					}
				},
// 				{data :'dlvDate',
// 					render : function(data, type, row, meata){
// 						return moment(data).format("YYYY-MM-DD");
// 					}
// 				},
				{data :'doCorpNm'},
		],
	    order: [
	        [ 0, 'desc' ]
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	});

	var itemNm;
	$('#deliveryOrderAdmTable tbody').on('click','tr',function(){
		sideView = "edit";
		
		if($('#btnSave').attr('class') == 'btn btn-primary float-right') {
    		$('#saveBtnModal').modal('show');
    		console.log("등록중입니다.");
    		return false;
    	}
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#deliveryOrderAdmTable').DataTable().$('.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		
		var tempPoCorpCd = deliveryOrderAdmTable.row(this).data().poCorpCd;
		var tempItemSeq = deliveryOrderAdmTable.row(this).data().itemSeq;
		
		$.ajax({
			url : '<c:url value="bs/deliveryOrderAdmRead"/>',
			type : 'GET',
			async : false,
			data :{
				'poCorpCd' : function(){return tempPoCorpCd;},
				'itemSeq' : function(){return tempItemSeq;},
			},
			success : function(res) {
				let data = res.data;
				if (res.result == 'ok') {
					doNo = data[0].doNo;
					doSeq = data[0].doSeq;
				}else {
					toastr.error(res.message);
				}
			}
		});
		
// 		doNo = deliveryOrderAdmTable.row( this ).data().doNo;
// 		doSeq = deliveryOrderAdmTable.row( this ).data().doSeq;
		itemSeq = deliveryOrderAdmTable.row( this ).data().itemSeq;
		itemNm = deliveryOrderAdmTable.row( this ).data().itemNm;
		
		doDate = deliveryOrderAdmTable.row( this ).data().doDate;
		doCorpCd = deliveryOrderAdmTable.row( this ).data().doCorpCd;
		doCorpNm = deliveryOrderAdmTable.row( this ).data().doCorpNm;
		poCorpCd = deliveryOrderAdmTable.row( this ).data().poCorpCd;
		poCorpNm = deliveryOrderAdmTable.row( this ).data().poCorpNm;

		$('#doDate').val(moment(doDate).format('YYYY-MM-DD'));
		$('#doCorpCd').val(doCorpCd);
 		$('#doCorpNm').val(doCorpNm);
		$('#poCorpCd').val(poCorpCd);
 		$('#poCorpNm').val(poCorpNm);

		//$('#btnSave').addClass('d-none');
		$('#btnEdit').attr('disabled', false);
		$('#btnDtlAdd').attr('disabled', true);
		$('#btnDtlDel').attr('disabled', true);
		$('#btnSelectItem').attr('disabled', true);
		$('#btnAllDoDate').attr('disabled', true);
		$('#btnItemDel').attr('disabled', true);
		
		$('#deliveryOrderDtlTable').DataTable().ajax.reload();
	});
	

	//출고의뢰등록 상세조회
	let deliveryOrderDtlTable = $('#deliveryOrderDtlTable').DataTable({
		dom: "",
			language : lang_kor,	
			destroy : true,	
			paging : false,
			searching : false,
			info : false,
			ordering : true,
			processing : true,
			autoWidth : false,
			lengthChange : true,
			pageLength : 5,
		ajax : {
			url : '<c:url value="bs/deliveryOrderAdmRead"/>',
			type : 'GET',
			data : {
				'poCorpCd' : function(){return poCorpCd;},
				'itemSeq' : function(){return itemSeq;},
				'doNo' : function(){return doNo;},
			}	
		},
		columns : [ 
				{
					render: function(data, type, row, meta) {
						return '<input type="checkbox" name="check3">';
					}
				},
				{data :'itemModelNm',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center;" name="itemModelNm" value="'+data+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="itemModelNm" value="" disabled>';
						}	
					}
				}, 
				{data :'itemCd',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center;" name="itemCd" value="'+data+'" disabled>';
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="itemCd" value="" disabled>';
						}	
					}
				}, 
				{data : 'itemNm',
					render : function(data,type, row, meta){
						var html ="";
						if(data!=null){
							html += '<input type="text" class="form-control" style="max-width:100%; text-align:center;" name="itemNm" value="'+data+'" disabled>';	
							html += '<input type="hidden" name="itemSeq" value="'+row['itemSeq']+'" style="max-width:100%;">';
							html += '<input type="hidden" name="doNo" value="'+row['doNo']+'" style="max-width:100%;">';
							html += '<input type="hidden" name="doSeq" value="'+row['doSeq']+'" style="max-width:100%;">';
							
						} else{
							html += '<input type="text" class="form-control" style="max-width:100%; text-align:center;" name="itemNm" value="" disabled>';
							html += '<input type="hidden" name="itemSeq" value="'+itemSeq+'" style="max-width:100%;">';
							html += '<input type="hidden" name="doNo" value="'+doNo+'" style="max-width:100%;">';
							html += '<input type="hidden" name="doSeq" value="'+doSeq+'" style="max-width:100%;">';
						}								
						
						return html;
					}
				}, 
				{data :'lhrhCdNm',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center;" name="lhrhCdNm" value="'+data+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="lhrhCdNm" value="" disabled>';
						}	
					}
				},
				{data :'itemColor',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center;" name="itemColor" value="'+data+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="itemColor" value="" disabled>';
						}	
					}
				},
				{data :'boxCount',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control number-float0" style="text-align:right;" name="boxCount" value="'+addCommas(data)+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control number-float0" style="text-align:right;" name="boxCount" value="" disabled>';
						}	
					}
				},
				{data :'itemUnitNm',
					render : function(data,type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center;" name="itemUnitNm" value="'+data+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="itemUnitNm" value="" disabled>';
						}	
					}
				},
				{data :'dlvDate',
					render : function(data, type, row, meta){
						var value = "";
						if (data != null) {
							value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+moment(data).format("YYYY-MM-DD")+'" name="dlvDate" disabled>';
							value2 = '<button onclick="fnPopUpCalendar(dlvDate'+index+',dlvDate'+index+',\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="dlvDateCalendar'+index+'" name="dlvDateCalendar" type="button" disabled>';
						} else {
							value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+serverDate+'" name="dlvDate" disabled>';
							value2 = '<button onclick="fnPopUpCalendar(dlvDate'+index+',dlvDate'+index+',\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="dlvDateCalendar'+index+'" name="dlvDateCalendar" type="button">';
						}
						var html = '<div class="form-group input-sub m-0">';
						html += value;
						html += value2;
						html += '<span class="oi oi-calendar"></span></button>';
						html += '</div>';

						index++;
						return html;
					}	
				},
				{data :'targetQty',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control number-float0" style="text-align:right;" name="targetQty" value="'+addCommas(data)+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control number-float0" style="text-align:right;" name="targetQty" value="0">';
						}	
					}
				},
		],
		columnDefs : [ {
			"defaultContent" : "-",
			"targets" : "_all",
			"className" : "text-center"
		} ],
	    order: [
	        [ 0, 'asc' ]
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	});


	$('#deliveryOrderDtlTable tbody').on('click','tr',function(){
		
// 		if($('#btnSave').attr('class') == 'btn btn-primary float-right') {
//     		$('#saveBtnModal').modal('show');
//     		console.log("등록중입니다.");
//     		return false;
//     	}
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#deliveryOrderDtlTable').DataTable().$('.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		tableIdx = $('#deliveryOrderDtlTable').DataTable().row(this).index();
		btnView == "edit";
	});

	
	//등록버튼 클릭시 
	$('#btnAdd').on('click',function(){
		sideView = 'add';
		
		$('#deliveryOrderAdmTable').DataTable().$('.selected').removeClass('selected');		
		$('#form').each(function(){
        	this.reset();
        	$('input[type=hidden]').val('');
    	});
		
		uiProc(false);
		$('#doDate').val(serverDate);
		$('#btnEdit').attr('disabled', true);
		$('#btnDel').attr('disabled', true);
		$('#btnDtlAdd').attr('disabled', false);
		$('#btnDtlDel').attr('disabled', false);
		$('#btnSelectItem').attr('disabled', false);
		$('#allDoDateCalendar').attr('disabled', false);
		$('#btnAllDoDate').attr('disabled', false);
		$('#btnItemDel').attr('disabled', false);
		
	
		$('#deliveryOrderDtlTable').DataTable().clear().draw();

		$('#btnSave').removeClass('d-none');
	});

	//수정버튼 클릭시 
	$('#btnEdit').on('click',function(){
		if(sideView != "edit"){
			toastr.warning("수정할 항목을 선택해주세요.");
			return false;
		}
		
		uiProc(false);
		uiProc2(false);
		
		//$('#doDate').val(serverDate);
		$('#btnAdd').attr('disabled', true);
		$('#btnDel').attr('disabled', true);
		$('#btnDtlAdd').attr('disabled', true);
		$('#btnDtlDel').attr('disabled', true);
		$('#btnSelectItem').attr('disabled', false);
		$('#allDoDateCalendar').attr('disabled', false);
		$('#btnAllDoDate').attr('disabled', false);
		$('#btnItemDel').attr('disabled', false);
		
		//doNo = "";
		//$('#deliveryOrderDtlTable').DataTable().ajax.reload(function() {});
		
		if(deliveryOrderDtlTable.data().count()>0){
			$('#btnSave').removeClass('d-none');  // 등록버튼
		}
	});


	//모든 체크박스 선택
	$('#checkboxAll2').on('click',function(){
		if($('#checkboxAll2').is(":checked")){
			$('input:checkbox[name=check2]').prop("checked",true);
		}else{
			$('input:checkbox[name=check2]').prop("checked",false);
		}
	});
	
	//모든 체크박스 선택
	$('#checkboxAll3').on('click',function(){
		if($('#checkboxAll3').is(":checked")){
			$('input:checkbox[name=check3]').prop("checked",true);
		}else{
			$('input:checkbox[name=check3]').prop("checked",false);
		}
	});
	
	// 추가폼
	$('#btnDtlAdd').on('click', function() {

		sideView = "add";
		if($('#doCorpNm').val()==""){
			toastr.warning("납품장소를 입력해주세요.");
			return false;
		}
		$('#deliveryOrderDtlTable').DataTable().row.add({}).draw(false);
	});

	// 삭제폼
	$('#btnDtlDel').on('click', function() {

		if(btnView == "edit"){
			toastr.warning("삭제할 항목을 선택해주세요.");
			return false;
		}
		
		$('#deliveryOrderDtlTable').DataTable().rows(tableIdx).remove().draw();
	});

	//출고지시량 숫자만 입력하게 처리
	$(document).on('keyup',"input[name=targetQty]", function(event){
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

	// 저장 처리
	$('#btnSave').on('click',function() {

		var check = true;
		var dataArray = new Array();	


		if ($('#poCorpCd').val() == "") {
			toastr.warning("발주처를 입력해주세요.");
			$('#btnPoCorpCd').focus();
			check = false;
			return false;
		}
		
		if ($('#doCorpCd').val() == "") {
			toastr.warning("납품장소를 입력해주세요.");
			$('#btnDoCorpCd').focus();
			check = false;
			return false;
		}
		
		$('#deliveryOrderDtlTable tbody tr').each(function(index, item){
			
			if(deliveryOrderDtlTable.data().count() != 0){
				if ($(this).find('td input[name=check3]').is(":checked") == true) {
					
					if ($(this).find('td input[name=targetQty]').val() == "0") {
						toastr.warning('출고지시량을 입력해주세요.');
						$(this).find('td input[name=targetQty]').focus();
						check = false;
						return false;
					}
					
					var rowData = new Object();
					rowData.doNo = $(this).find('td input[name=doNo]').val();
					rowData.ordGubun = '';
					rowData.doSeq = $(this).find('td input[name=doSeq]').val();
					rowData.doDate = $('#doDate').val().replace(/-/g,'');
					rowData.doCorpCd = $('#doCorpCd').val();
					
					rowData.poCorpCd = $('#poCorpCd').val();
					rowData.itemSeq = $(this).find('td input[name=itemSeq]').val();
					rowData.dlvDate = $(this).find('td input[name=dlvDate]').val().replace(/-/g,'');
					rowData.targetQty = $(this).find('td input[name=targetQty]').val().replace(/,/g,'');
					
			        dataArray.push(rowData);
				}
			} else {
				toastr.warning('저장할 품목을 추가해주세요.');
				check = false;
				return false;
				
			}
			
		});

		var url;
		if (sideView == "add") {
		    url = '<c:url value="/bs/deliveryOrderAdmCreate"/>';
		} else if (sideView == "edit") {
			url = '<c:url value="/bs/deliveryOrderAdmUpdate"/>';
		}
		
		if(check){
			if(dataArray.length == 0){
				toastr.warning('저장할 품목을 선택해주세요.');
				check = false;
				return false;
			}
			
			$.ajax({
				url : url,
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				beforeSend : function() {
					//처리중..
					$('#my-spinner').show();
				},
				success : function(res) {
					if (res.result == 'ok') {
						
						if( sideView == "edit" ) {
		                	toastr.success('수정되었습니다.');
	                    }else{
	                        toastr.success('등록되었습니다.');
	                    } 
	                    
						poCorpCd = '';
						$('#deliveryOrderAdmTable').DataTable().ajax.reload(null, false);
						$('#deliveryOrderDtlTable').DataTable().ajax.reload(function() {});

						$('#btnSave').addClass('d-none');
						$('#btnAdd').attr('disabled', false);
						$('#btnEdit').attr('disabled', false);
						$('#btnDel').attr('disabled', false);
						$('#btnDtlAdd').attr('disabled', true);
						$('#btnDtlDel').attr('disabled', true);
						$('#btnSelectItem').attr('disabled', true);
						$('#allDoDateCalendar').attr('disabled', true);
						$('#btnAllDoDate').attr('disabled', true);
						$('#btnItemDel').attr('disabled', true);
						$('#checkboxAll3').prop('checked', false);
						
						uiProc(true);						
						uiProc2(true);
						
						sideView = 'add';
					
					} else if(res.result == 'notPoCorpCd') {
						toastr.error("발주처를 추가해주세요.");	
					} else {
						toastr.error(res.message);
					}
				},
				complete : function() {
					//처리완료..
					$('#my-spinner').hide();
				}
			});
		}
	});

	   
    var html1 = '<div class="row">';
    html1 += '&nbsp;&nbsp;<label class="input-label-sm">출고지시일</label><div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="doDateFrom" name="doDateFrom" disabled/>';
    html1 += '<button onclick="fnPopUpCalendar(doDateFrom,doDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="doDateFromFromCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>';
    html1 += '&nbsp;&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="doDateTo" name="doDateTo" disabled />';
    html1 += '<button onclick="fnPopUpCalendar(doDateTo,doDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="doDateToToCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>&nbsp;&nbsp;&nbsp;';   
    html1 += '<label class="input-label-sm">발주처</label>';
	html1 += '<div class="form-group input-sub m-0">';
	html1 += '<select id="poCorpNmgubun" name="poCorpNmgubun" title="" class="select w80 col-12 custom-select">';
	html1 += '</select></div>&nbsp;&nbsp;&nbsp;';
    html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>&nbsp;&nbsp;&nbsp;'
    html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnAllRetv">전체조회</button>&nbsp;&nbsp;&nbsp;'
    html1 += '</div>';
    
	$('#deliveryOrderAdmTable_length').html(html1);
	$('#doDateFrom').val(serverDateFrom);
	$('#doDateTo').val(serverDateTo);
	
	selectBoxAppend(poCorpNmgubun, "poCorpNmgubun", "", "1");
	
	$('#btnRetv').on('click', function() {
		serverDateFrom =  $('#doDateFrom').val();
		serverDateTo =  $('#doDateTo').val();
		poCorpCd = $('#poCorpNmgubun').val();
		$('#deliveryOrderAdmTable').DataTable().ajax.reload(function () {});
    });	
	
	$('#btnAllRetv').on('click', function() {
		serverDateFrom =  '';
		serverDateTo =  '';
		poCorpCd = '';
		selectBoxAppend(poCorpNmgubun, "poCorpNmgubun", "", "1");
		$('#deliveryOrderAdmTable').DataTable().ajax.reload(function () {});
    });	

	////////////////////////////////////////////////////////////////////////////////////////
	//팝업
	///////////////////////////////////////////////////////////////////////////////////////
	
	
	//팝업 시작
//    	var dealCorpPopUpTable2;
//    	function selectPoCorpCd()
//    	{	   	
// 		if(dealCorpPopUpTable2 == null || dealCorpPopUpTable2 == undefined)	{
// 			dealCorpPopUpTable2 = $('#dealCorpPopUpTable2').DataTable({
// 				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
// 				"<'row'<'col-sm-12'tr>>" +
// 				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
// 				language : lang_kor,
// 				paging : true,
// 				info : true,
// 				ordering : true,
// 				processing : true,
// 				autoWidth : false,
// 				lengthChange: false,
// 				serverSide  :true,
// 		        pageLength: 15,
// 				ajax : {
// 					url : '<c:url value="/bm/dealCorpDataList"/>',
// 					type : 'GET',
// 					data : {},
// 				},
// 				rowId : 'dealCorpCd',
// 				columns : [{
// 					data : 'dealCorpCd'
// 				}, {
// 					data : 'dealCorpNm'
// 				}, {
// 					data : 'initial'
// 				}, {
// 					data : 'presidentNm'
// 				}, {
// 					data : 'country'
// 				}, {
// 					data : 'corpNo'
// 				}
// 				],
// 				columnDefs : [ {
// 					"defaultContent": "-", "targets": "_all",	"className": "text-center"
// 				}],
// 				order : [ [ 0, 'asc' ] ],
// 				buttons : [],
// 		    });

// 		    $('#dealCorpPopUpTable2 tbody').on('click', 'tr', function () {
			    
// 		    	var data = dealCorpPopUpTable2.row( this ).data();
// 		    	$('input[name=poCorpCd]').eq(tableIdx).val(data.dealCorpCd);
// 				$('input[name=poCorpNm]').eq(tableIdx).val(data.dealCorpNm);
//                 $('#dealCorpPopUpModal2').modal('hide');
	
// 				});
// 		}
// 		$('#dealCorpPopUpModal2').modal('show');		
//    	}

  	//품목추가 팝업 시작
   	var itemPopupTable;
   	function selectItem() {
   		if(!$.trim($('#poCorpNm').val())){
   			toastr.warning('발주처를 선택해주세요.');
			return false;
   		}
   		$('input[name=check]').prop('checked', false);
   		$('input[name=checkboxAll2]').prop('checked', false);
   		if (itemPopupTable != null && itemPopupTable != 'undefined') {
   			itemPopupTable.destroy();
		}
		itemPopupTable = $('#itemPopupTable').DataTable({
			dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,
			paging : false,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			lengthChange: false,
	        pageLength: 20,
			ajax : {
				url : '<c:url value="/bm/itemPartAdmList"/>',
				type : 'GET',
				async : false,
				data : {
					'itemCus' : function(){return poCorpCd;},
				},
			},
			columns : [
				{
					render: function(data, type, row, meta) {
						return '<input type="checkbox" name="check2">';
					}, "className": "text-center" 
				},
				{
					data : 'itemModelNm',
					"className": "text-center" 
				}, 
				{
					data : 'itemCd'
					, "className": "text-center" 
				}, 
				{
					data : 'itemNm'
					, "className": "text-center" 
				}, 
				{
					data : 'lhrhCdNm',
					"className": "text-center" 
				}, 
				{
					data : 'itemColor',
					"className": "text-center" 
				}, 
				{
					data : 'boxCount',
					render: function(data, type, row, meta) {
						if(data != null){
							return addCommas(data);
						} else {
							return '0';
						}
					}, "className": "text-right" 
				},
				{
					data : 'tmQty',
					render: function(data, type, row, meta) {
						if(data != null){
							return addCommas(data);
						} else {
							return '0';
						}
					}, "className": "text-right" 
				},
				{
					data : 'itemUnitNm',
					"className": "text-center" 
				}
			],
			order : [ [ 0, 'asc' ] ],
			buttons : [],
			drawCallback: function() {
			   var api = this.api();
			   
			   for(var i=0;i<api.data().count();i++) {
				   if(api.row(i).data().shipReqDate == serverDateTo.replace(/-/g,'')) {
				   		$('#'+api.row(i).data().shipReqDate).addClass('bg-warning');
					} else {
						$('#'+api.row(i).data().shipReqDate).removeClass('bg-warning');
					}
				}
			}
	    });
		$('#itemPopupModal').modal('show');		
   	}

	$('#btnGetAll').on('click',function(){
	
		$('#itemPopupTable tbody tr').each(function(index, item) {		
			var data = itemPopupTable.row(this).data();
			if ($(this).find('td input[name=check2]').is(":checked") == true) {

				itemSeq = data.itemSeq == null ? "-" : data.itemSeq;

				$('#deliveryOrderDtlTable').DataTable().row.add({
					"itemSeq" : data.itemSeq,
					"itemModelNm" : data.itemModelNm,
					"itemCd" : data.itemCd,
					"itemNm" : data.itemNm,
					"lhrhCdNm" : data.lhrhCdNm,
					"itemColor" : data.itemColor,
					"boxCount" : data.boxCount,
					"itemUnitNm" : data.itemUnitNm,
				}).draw(true);				
			}

		});

		$('#itemPopupModal').modal('hide');		
	});
	
  	//발주처 팝업 시작
  	var popUpCheck = '';
   	var dealCorpPopUpTable4;
   	function selectPoCorpCd() {	  
   		popUpCheck = '발주처';
   		if (dealCorpPopUpTable4 != null && dealCorpPopUpTable4 != 'undefined') {
			dealCorpPopUpTable4.destroy();
		}
		dealCorpPopUpTable4 = $('#dealCorpPopUpTable4').DataTable({
			dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,
			paging : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			scrollX : false,
			lengthChange : true,
			async : false,
			pageLength : 10,
			ajax : {
				url : '<c:url value="/bm/dealCorpDataList"/>',
				type : 'GET',
				data : {
					'dealGubun' : function(){return '001';}
				},
			},
			rowId : 'dealCorpSeq',
			columns : [ 
			{
				data : 'dealCorpNm'
			}, 
			{
				data : 'dealCorpCd'
			}, 
			{
				data : 'presidentNm'
			}, 
			{
				data : 'repreItem'
			}, 
			{
				data : 'corpNo'
			} 
			],
			columnDefs : [ {
				"defaultContent" : "-",
				"targets" : "_all",
				"className" : "text-center"
			} ],
			order : [ [ 0, 'asc' ] ],
			buttons : [],
	    });

	    $('#dealCorpPopUpTable4 tbody').on('click', 'tr', function () {
		    if(popUpCheck == '발주처'){
		    	var data = dealCorpPopUpTable4.row( this ).data();
		    	poCorpCd = data.dealCorpCd;
		    	$('#poCorpCd').val(data.dealCorpCd);
				$('#poCorpNm').val(data.dealCorpNm);
	            $('#dealCorpPopUpModal4').modal('hide');
		    }
		});
		$('#dealCorpPopUpModal4').modal('show');		
   	}
   	
  	//납품장소 팝업 시작
   	var dealCorpPopUpTable4;
   	function selectDoCorpCd() {
   		popUpCheck = '납품장소';
   		if (dealCorpPopUpTable4 != null && dealCorpPopUpTable4 != 'undefined') {
			dealCorpPopUpTable4.destroy();
		}
		dealCorpPopUpTable4 = $('#dealCorpPopUpTable4').DataTable({
			dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,
			paging : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			scrollX : false,
			lengthChange : true,
			async : false,
			pageLength : 10,
			ajax : {
				url : '<c:url value="/bm/dealCorpDataList"/>',
				type : 'GET',
				data : {
					'dealGubun' : function(){return '001';}
				},
			},
			rowId : 'dealCorpSeq',
			columns : [ 
			{
				data : 'dealCorpNm'
			}, 
			{
				data : 'dealCorpCd'
			}, 
			{
				data : 'presidentNm'
			}, 
			{
				data : 'repreItem'
			}, 
			{
				data : 'corpNo'
			} 
			],
			columnDefs : [ {
				"defaultContent": "-", "targets": "_all",	"className": "text-center"
			}],
			order : [ [ 0, 'asc' ] ],
			buttons : [],
	    });

	    $('#dealCorpPopUpTable4 tbody').on('click', 'tr', function () {
	    	if(popUpCheck == '납품장소'){
	    	var data = dealCorpPopUpTable4.row( this ).data();
	    	$('#doCorpCd').val(data.dealCorpCd);
			$('#doCorpNm').val(data.dealCorpNm);
            $('#dealCorpPopUpModal4').modal('hide');
	    	}
		});
		$('#dealCorpPopUpModal4').modal('show');		
   	}
   	

   	function uiProc(flag){
		$('#doDateCalendar').attr('disabled',flag);
		$('#btnDoCorpCd').attr('disabled',flag);
		$('#btnPoCorpCd').attr('disabled',flag);		
   	}
   	
   	function uiProc2(flag){
		$('button[name=btnPoCorpCd]').attr('disabled',flag);
		$('button[name=btnitemSeq]').attr('disabled',flag);
		$('button[name=dlvDateCalendar]').attr('disabled',flag);
		
		$('input[name=targetQty]').attr('disabled',flag);
		
   	}
   	
	//삭제
	$('#btnDel').on('click', function() {
		if (sideView == 'add') {
			toastr.warning("삭제할 목록을 선택해 주세요.");
			return false;
		}
		
		sideView = 'add';
		
		$('#form').each(function(){
			this.reset();
			$('input[type=hidden]').val('');
		});
		
		$.ajax({
			url : '<c:url value="bs/deliveryOrderDtlDelete"/>',
			type : 'POST',
			data :{
				'doNo' : function() {return doNo;},
			},
			success : function(res) {
				let data = res.result;
				if (res.result == 'ok') {
					toastr.success('삭제되었습니다.');
					$('#deliveryOrderAdmTable').DataTable().ajax.reload(function() {});
					$('#deliveryOrderDtlTable').DataTable().ajax.reload(function() {});
				}else {
					toastr.error(res.message);
				}
			}
		});
		
	});
	
	//품목 삭제
	$('#btnItemDel').on('click', function() {
		var itemDelCheck = true;
		$('#deliveryOrderDtlTable tbody tr').each(function(index, item){
			if ($(this).find('td input[name=check3]').is(":checked") == true) {
				itemDelCheck = false;
				var doNo = $(this).find('td input[name=doNo]').val();
				var doSeq = $(this).find('td input[name=doSeq]').val();
				
				var tableIdx = $('#deliveryOrderDtlTable').DataTable().row(this).index();
				$.ajax({
					url : '<c:url value="bs/deliveryOrderDtlDelete"/>',
					type : 'POST',
					async : false,
					data :{
						'doNo' : function() {return doNo;},
						'doSeq' : function() {return doSeq;},
						'doSeqCheck' : function() {return 'doSeqCheck';},
					},
					success : function(res) {
						let data = res.result;
						if (res.result == 'ok') {
						}else {
							toastr.error(res.message);
						}
					}
				});
				$('#deliveryOrderDtlTable').DataTable().rows(tableIdx).remove().draw();
			}
			
		});
		
		if (itemDelCheck) {
			toastr.warning("삭제할 품목을 선택해 주세요.");
			return false;
		}
		
// 		$('#form').each(function(){this.reset();});
		toastr.success('삭제되었습니다.');
		$('#checkboxAll3').prop('checked', false);
// 		$('#deliveryOrderAdmTable').DataTable().ajax.reload(null, false);
// 		$('#deliveryOrderDtlTable').DataTable().ajax.reload(function() {});
		
	});
	
	//납기일 전체적용 버튼 클릭시 
	$('#btnAllDoDate').on('click',function(){
		var checkBoxCheck = true;
		$('#deliveryOrderDtlTable tbody tr').each(function(index, item){
			if ($(this).find('td input[name=check3]').is(":checked") == true) {
				$(this).find('td input[name=dlvDate]').val($('#allDoDate').val());
				checkBoxCheck = false;
			}
		});
		if(checkBoxCheck){
			toastr.warning("납기일을 적용할 품목을 선택해 주세요.");
			return false;
		}
		
	});
   	
</script>

</body>
</html>
