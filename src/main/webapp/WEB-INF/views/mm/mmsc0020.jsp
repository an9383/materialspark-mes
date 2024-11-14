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
				<li class="breadcrumb-item"><a href="#">일반자재관리</a></li>
				<li class="breadcrumb-item active">발주등록</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<!-- 상단 sorting part -->
		<div class="card top_sortbox p-2">
			<div class="row">
				<div class="col-5 row p-0">
                <!-- 품번 -->
					<label class="input-label-md">구분</label>
					<div class=" m-1">
						<div class="form-group-150">
							<select id="partGubun" class="custom-select custom-select-md"></select>
						</div>
					</div>
					<!-- 구분 -->
                  	<label class="input-label-md">타입</label>
                  	<div class=" m-1">
                  		<div class="form-group-150">
                  			<select id="partType" class="custom-select custom-select-md"></select>
                  		</div>
                  	</div>
                  	<!-- 조회 -->
					<button type="button"  class="btn btn-md btn-primary m-1" id="btnRetv">조회</button>
					&nbsp;&nbsp;&nbsp; <button type="button"  class="btn btn-primary m-1" id="btnAllList">전체조회</button>
				</div>
               <!-- 발주등록 -->
				<div class="col-6 row">
					<button type="button" class="btn btn-md btn-danger float-right m-1" id="btnMove">발주등록&nbsp;&nbsp;<span class="oi oi-arrow-right"></span></button>
				</div>
			</div>
		</div>
		<!-- / end 상단 sorting part -->
		<div class="row table-wrap-hid">
			<!------------------------ .left-list ----------------------->
			<div class="left-list left-sidebar" id="left-list"
				style="width: 49%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table class="table table-bordered" id="itemPartAdmTable">
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="7%">
								<col width="7%">
								<col width="20%">
								<col width="7%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light" >
								<tr>
									<th>
										<input type="checkbox" id="btnAllCheck" >
									</th>
									<th>구분</th>
									<th>TYPE</th>
									<th>CODE</th>
									<th>품명</th>
									<th>SPEC</th>
									<th>단위</th>
									<th class="text-center">안전재고</th>
									<th class="text-center">재고수량</th>
									<th class="text-center">부족수량</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->

			<!----------------------- .right-sidebar 등록,수정 ----------------------->
			<div class="right-list right-sidebar" id="myrSidenav"
				style="width: 50%;">
				<div class="card">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand"
								class="closebtn float-right" onclick="closerNav()"> <i
								class="mdi mdi-close"></i></a>
						</div>
						<button type="button" class="btn btn-primary float-right d-none"
							id="btnSave">저장</button>
						<button class="btn btn-primary d-none" id="btnSaveConfirmLoading"
							type="button" disabled>
							<span class="spinner-border spinner-border-sm" role="status"
								aria-hidden="true"></span> 처리중
						</button>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<div id="myTabContent" class="tab-content">
						<form id="form">
							<div class="table-responsive">
								<table class="table table-sm table-bordered mb-2"
									id="purchaseOrderAdmTable">
									<colgroup>
										<col width="20%">
										<col width="27%">
										<col width="25%">
										<col width="28%">
									</colgroup>
									<tr>
										<th>발주번호</th>
										<td><input class="form-control" type="text" id="poNo"
											name="poNo" style="max-width: 100%" disabled>
										<th>거래처명</th>
										<td>
											<div class="input-sub m-0" style="max-width: 100%">
												<input type="text" class="form-control"
													style="max-width: 100%" id="dealCorpNm" name="dealCorpNm"
													disabled> <input type="hidden" id="dealCorpCd"
													name="dealCorpCd">
												<button type="button"
													class="btn btn-primary input-sub-search"
													name="btnDealCorp" id="btnDealCorp"
													onClick="selectDealCorp();">
													<span class="oi oi-magnifying-glass"></span>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th>담당자</th>
										<td><input type="text" class="form-control"
											id="mainChargr" name="mainChargr" style="max-width: 100%"
											disabled /></td>
										<th>연락처</th>
										<td><input type="text" class="form-control" id="telNo"
											name="telNo" style="max-width: 100%" disabled /></td>
									</tr>
									<tr>
										<th>발주일</th>
										<td>
											<div class="form-group input-sub m-0"
												style="max-width: 100%">
												<input class="form-control" style="max-width: 100%"
													type="text" id="poDate" name="poDate" maxlength="10"
													disabled />
												<button
													onclick="fnPopUpCalendar(poDate,poDate,'yyyy-mm-dd')"
													class="btn btn-secondary input-sub-search"
													id="poDateCalendar" type="button">
													<span class="oi oi-calendar"></span>
												</button>
											</div>
										</td>
										<th>등록자</th>
										<td>
											<div class="input-sub m-0" style="max-width: 100%">
												<input type="hidden" class="form-control"
													style="max-width: 100%" id="poRegChargr"
													name="poRegChargr" disabled> <input type="text"
													class="form-control" style="max-width: 100%"
													id="poRegChargrNm" name="poRegChargrNm" disabled>
												<button type="button"
													class="btn btn-primary input-sub-search"
													name="btnPoRegChargr" id="btnPoRegChargr"
													onClick="selectPoRegChargr();">
													<span class="oi oi-magnifying-glass"></span>
												</button>
											</div>
										</td>
									</tr>
									<tr>
										<th>우선검사여부</th>
										<td><select class="custom-select" id="finspectYn"
											name="finspectYn" style="max-width: 100%"></select></td>
										<th>확정여부</th>
										<td><select class="custom-select" id="confirmYn"
											name="confirmYn" style="max-width: 100%"></select></td>
									</tr>
									<tr>
										<th>사용여부</th>
										<td><select class="custom-select" id="useYn"
											name="useYn" style="max-width: 100%"></select></td>
										<th>입고구분</th>
										<td><select class="custom-select" id="receiptGubun"
											name="receiptGubun" style="max-width: 100%"></select></td>
									</tr>
									<tr>
										<th>비고</th>
										<td colspan="3"><input class="form-control" type="text"
											id="poDesc" style="max-width: 100%" /></td>
									</tr>
								</table>
							</div>
						</form>
						<div class="card-body col-sm-12 p-1 mb-2">
							<button type="button" class="btn btn-danger float-right"
								id="btnDtlDel" disabled>삭제</button>
							<button class="btn btn-warning d-none"
								id="btnEditConfirmLoading" type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span>처리중
							</button>
							<!-- <button type="button" class="btn btn-primary float-right mr-1"
								id="btnDtlEdit" disabled>수정</button>
							<button class="btn btn-primary d-none" id="btnAddConfirmLoading"
								type="button" disabled>
								<span class="spinner-border spinner-border-sm" role="status"
									aria-hidden="true"></span> 처리중
							</button> -->
						</div>
						<form id="form2" enctype="multipart/form-data">
							<div class="table-responsive">
								<table class="table table-bordered" id="individualOrderDtlTable">
									<colgroup>
										<col width="13%">
										<col width="6%">
										<col width="15%">
										<col width="30%">
										<col width="10%">
										<col width="7%">
										<col width="9%">
										<col width="10%">
									</colgroup>
									<thead class="thead-light">
										<tr>
											<th>CODE</th>
											<th>REV</th>
											<th>ITEM</th>
											<th>SPEC</th>
											<!-- <th>수입검사</th> -->
											<th>납기요청일</th>
											<th>단위</th>
											<th>발주수량</th>
											<th>단가</th>
											<!-- <th>발주처</th> -->
										</tr>
									</thead>
								</table>
							</div>
						</form>
					</div>
				</div>
				<!-- ===/.right-sidebar 등록,수정===  -->
			</div>
			<!-- /.row -->
		</div>
		<!-- / #main  -->
	</div>
</div>
<%@include file="../layout/bottom.jsp" %>
<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "45%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
	
		state = !state;
	});

	let currentHref = "mmsc0020";
	let currentPage = $('.' + currentHref).attr('id');
	
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');    
	$(document).attr("title","발주등록"); 
	
	let viewIdx;
	let sideView = 'add';
	let btnView = '';

	var tableIdx=null;
	var tableIdx2=null;
	var poNo = null;
	var partCd = null;
	var poSeq = null;
	var partNm = null;
	var partRev = null;
	var partSpec = null;
	var partUnit = null;
	var partGubun = null;
	var partType = null;
	var partQty = null;
	var itemCd = null;
	var ordCnt = null;
	var unitCost = null;
	var index=1;
	var poSeqValue = null;
	var ordCorpCdVal=null;
	var contDtlNoVal= null;
	var mrpNoVal= null;
	var mrpSeqVal= null;
	
	var preInWhsDateFromCal =  "${serverDateFrom}";
	var preInWhsDateToCal =  "${serverDateTo}";
	var preInWhsDateCal =  "${serverDateTo}";	

	var poRegChargr =  "${userNumber}";
	var poRegChargrNm =  "${userNm}";	
	
	//공통코드 처리 시작	
	var useYnCode = new Array(); // 사용여부
	<c:forEach items="${useYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	useYnCode.push(json);
	</c:forEach>

	var finspectYnCode = new Array(); // 수입검사여부
	<c:forEach items="${finspectYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	finspectYnCode.push(json);
	</c:forEach>

	var confirmYnCode = new Array(); // 확정여부
	<c:forEach items="${confirmYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	confirmYnCode.push(json);
	</c:forEach>

	var inspectYnCode = new Array(); // 수입검사여부
	<c:forEach items="${inspectYn}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	inspectYnCode.push(json);
	</c:forEach>

	var receiptGubunCode = new Array(); // 수입검사여부
	<c:forEach items="${receiptGubun}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	receiptGubunCode.push(json);
	</c:forEach>

	var partGubunCode = new Array(); //구분
	<c:forEach items="${partGubun}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	partGubunCode.push(json);
	</c:forEach>

	var partTypeCode = new Array(); //타입
	<c:forEach items="${partType}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	partTypeCode.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	//선택박스 처리
	selectBoxAppend(useYnCode, "useYn", "", "2");
	selectBoxAppend(finspectYnCode, "finspectYn", "", "2"); 
	selectBoxAppend(confirmYnCode, "confirmYn", "", "2");  
	selectBoxAppend(inspectYnCode, "inspectYn", "", "2"); 
	selectBoxAppend(receiptGubunCode, "receiptGubun", "", "2"); 
	selectBoxAppend(partGubunCode, "partGubun", "", "2"); 
	selectBoxAppend(partTypeCode, "partType", "", "2"); 

	uiProc(true);
	uiProc2(true);
	
    $('#saveBtnModalY').on('click',function() {
    	uiProc(true);
    	$('#btnEdit').attr('disabled',false);
    	$('#btnSave').addClass('d-none');
    });


 	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let itemPartAdmTable = $('#itemPartAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		language : lang_kor,
		paging : true,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		scrollX : false,
		lengthChange : false,
		pageLength : 20,
		ajax : {
			url : '<c:url value="/mm/itemPartAdmList"/>',
			type : 'GET',
			data : {
					'partGubun'	: function(){return partGubun;},
					'partType'	: function(){return partType;}
				},
		},
		rowId : 'partCd',
		columns : [
			{ render : function(data, type, row, meta) {
					return '<input type="checkbox" name="check">';
				}
			},
			{ data : 'partGubunNm'		},	//구분
			{ data : 'partTypeNm'		},	//TYPE
			{ data : 'partCd'			},	//CODE
			{ data : 'partNm'			},	//ITEM
			{ data : 'partSpec'			},	//SPEC
			{ data : 'partUnitNm'		},	//단위 
			{ data : 'safetyStockQty',
				render : function(data, type, row, meta) {
					return addCommas(data);
				}, 'className' : 'text-right'
			},
			{ data : 'rethinkQty',
				render : function(data, type, row, meta) {
					return addCommas(data);
				}, 'className' : 'text-right'
			},
			{ data : 'lackQty',
				render : function(data, type, row, meta) {
					if(data>0){
						return addCommas(row['lackQty']);
					} else{
						return 0;
					}
				}, 'className' : 'text-right'
			}
		],
		order : [ [ 1, 'asc' ] ],
		buttons: [
            {
                extend: 'copy',
                title: '발주등록',
            },
            {
                extend: 'excel',
                title: '발주등록',
            },
            {
                extend: 'print',
                title: '발주등록',
            }
        ],
		columnDefs: [
			{ orderable: false, targets: 0 }
		],   
	});


	$('#btnRetv').on('click', function() {
		partGubun = $('#partGubun :selected').val();
		partType = $('#partType :selected').val();
		$('#itemPartAdmTable').DataTable().ajax.reload( function () {});
    });	

	$('#btnAllList').on('click', function() {
		partGubun =  "";
		partType =  "";
		$('#itemPartAdmTable').DataTable().ajax.reload( function () {});
    });   
    
	//부품정보 목록조회
	$.fn.dataTable.ext.errMode = 'none';
	let individualOrderDtlTable = $('#individualOrderDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language : lang_kor,		
		paging : false,
		searching : false,
		info : false,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		pageLength : 20,
		//ordering: false,
		ajax : {
			url : '<c:url value="mm/individualOrderDtlList"/>',
			type : 'GET',
			data : {				
				'poNo' : function(){return poNo;}
			}	
		},	
		columns : [
				{data : 'partCd',
					render : function(data,type, row, meta){
						var html="";
						if(data!=null){
							html += '<input type="text" class="form-control" style="max-width:100%; text-align:center; border:none;" name="partCd" value="'+data+'" disabled>';
							html += '<input type="hidden" name="contDtlNo" value="'+contDtlNoVal+'" disabled>';	
							html += '<input type="hidden" name="mrpNo" value="'+mrpNoVal+'" disabled>';	
							html += '<input type="hidden" name="mrpSeq" value="'+mrpSeqVal+'" disabled>';	
							html += '<input type="hidden" name="ordCorpCd" value="'+ordCorpCdVal+'"  disabled>';	
							
						} else{
							html += '<input type="text" class="form-control" style="max-width:100%; style="text-align:center;" name="partCd" value="" disabled>';
						}		
						return html;						
					}
				}, 
				{data : 'partRev',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" style="text-align:center; border:none;" name="partRev" value="'+data+'" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" style="text-align:center;" name="partRev" value="" disabled>';
						}	
					}
				},
				{data : 'partNm',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" name="partNm" value="'+data+'" style="text-align:center;border:none;" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" name="partNm" value="" style="text-align:center;" disabled>';
						}	
					}
				},
				{data : 'partSpec',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" name="partSpec" value="'+data+'" style="text-align:center; max-width:100%;border:none;" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" name="partSpec" value="" style="text-align:center; max-width:100%;" disabled>';
						}	
					}
				}, 
			/* 	{data : 'inspectYn',
					render : function(data, type, row, meta){
						var html = "";
						html = selectBoxHtml2(inspectYnCode,"inspectYn", data, row, meta);
						return html;
					}
				},	 */
				{data : 'dlvDate',
					render : function(data, type, row, meta){

						var value = "";
						
						if (data != null) {
							return value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+moment(data).format("YYYY-MM-DD")+'" name="dlvDate" disabled>';
						} else {
							return value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+preInWhsDateCal.replace(/-/g,'')+'" name="dlvDate" style="text-align:center">';
						}
						
						/* 
						if (data != null) {
							value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+moment(data).format("YYYY-MM-DD")+'" name="dlvDate" disabled>';
							value2 = '<button onclick="fnPopUpCalendar(dlvDate'+index+',dlvDate'+index+',\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="dlvDateCalendar'+index+'" name="dlvDateCalendar" type="button" disabled>';
						} else {
							value =  '<input class="form-control" type="text" id="dlvDate'+index+'" value="'+preInWhsDateCal+'" name="dlvDate" disabled>';
							value2 = '<button onclick="fnPopUpCalendar(dlvDate'+index+',dlvDate'+index+',\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="dlvDateCalendar'+index+'" name="dlvDateCalendar" type="button">';
						}
						var html = '<div class="form-group input-sub m-0">';
						html += value;
						html += value2;
						html += '<span class="oi oi-calendar"></span></button>';
						html += '</div>';

						index++;
						return html; */
						
					}
				},
				{data : 'partUnit',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" name="partUnit" value="'+data+'" style="text-align:center; border:none;" readonly>';		
							
						} else{
							return '<input type="text" class="form-control" name="partUnit" value="" style="text-align:center;" disabled>';
						}	
					}
				},
				{data : 'partQty',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" name="partQty" value="'+addCommas(data)+'" style="text-align:right;">';		
							
						} else{
							//벌쥬둥록 클릭시
							return '<input type="text" class="form-control" name="partQty" value="" style="text-align:right;">';
						}	
					}
				},
				/* {data : 'unitCost',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control" name="unitCost" value="'+addCommas(data)+'" style="text-align:right;" disabled>';		
							
						} else{
							return '<input type="text" class="form-control" name="unitCost" value="" style="text-align:right;" disabled>';
						}	
					}
				}, */
				{data : 'partUnitCost',
					render : function(data, type, row, meta){
						if(data!=null){
							return '<input type="text" class="form-control autoCal" name="partUnitCost" value="'+addCommas(data)+'" style="text-align:right;">';		
							
						} else{
							return '<input type="text" class="form-control autoCal" name="partUnitCost" value="" style="text-align:right;">';
						}	
					}
				},
				/* {data : 'ordCorpNm',
					render : function(data, type, row, meta){
						var html; 
						if(data!=null){
							html= '<input type="hidden" class="form-control" name="ordCorpCd" value="'+ordCorpCdVal+'"  disabled>';	
							html+='<input type="text" class="form-control" name="ordCorpNm" value="'+data+'" style="text-align:center;" disabled>';
							return html;		
							
						} else{
							html= '<input type="hidden" class="form-control" name="ordCorpCd" value="'+ordCorpCdVal+'" >';	
							html+='<input type="text" class="form-control" name="ordCorpNm" value="'+data+'" style="text-align:center;" >';

							return html;	
						}	
					}
				}, */
			
		],
		
		columnDefs: [
			//{ "targets": [9,10] , render: $.fn.dataTable.render.number( ',' ) , "className" : "text-right" },
        	
        ],
	    order: [
	        [ 0, 'asc' ]
	    ],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	});
	
	$('#individualOrderDtlTable tbody').on('click','tr',function(e){
		btnView = "edit";
    	
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#individualOrderDtlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		tableIdx = $('#individualOrderDtlTable').DataTable().row(this).index();

		poSeq = individualOrderDtlTable.row(this).data().poSeq;
		
	});


	// 이동버튼
	$('#btnMove').on('click', function() {
		if($('input:checkbox[name=check]').is(":checked")==false){
			toastr.warning("이동할 항목을 선택해주세요.");
			return false;
		}
		uiProc(false);
		
		if(individualOrderDtlTable.data().count()==0){
			$('#form').each(function(){
	        	this.reset();
	    	}); 

			$.ajax({
				url : '<c:url value="mm/getPoNo"/>',
				type : 'GET', 
				data : {
						'poNoGubun'  : 'P'
					},
				success : function(res){
					$('#poNo').val(res.data);
				}
			});

			$('#poDate').val(preInWhsDateCal);
			$('#poRegChargr').val(poRegChargr);
			$('#poRegChargrNm').val(poRegChargrNm);
			
			$('#btnSave').removeClass('d-none');
			$('#btnDtlEdit').attr('disabled',false);
			$('#btnDtlDel').attr('disabled',false);
			$('#finspectYn').val("001");
			$('#confirmYn').val("001");
			$('#useYn').val("001");
			$('#receiptGubun').val("001");
			
			$('#individualOrderDtlTable').DataTable().clear().draw();
		}
		dealCorpCd
		$('#itemPartAdmTable tbody tr').each(function(index, item) {		
			var data = itemPartAdmTable.row(this).data();
			if ($(this).find('td input[name=check]').is(":checked") == true) { 

				ordCorpCdVal = data.ordCorpCd==null?"-":data.ordCorpCd;
				contDtlNoVal = data.contDtlNo==null?"-":data.contDtlNo;
				mrpNoVal = data.mrpNo;
				mrpSeqVal = data.mrpSeq;
				
				$('#individualOrderDtlTable').DataTable().row.add({
					"partCd" 		: data.partCd,
					"partRev" 		: data.partRev,
					"partNm" 		: data.partNm,
					"partSpec"	 	: data.partSpec,
					"inspectYn" 	: data.inspectYn,
					"dlvDate" 		: data.dlvDate,
					"partUnit" 		: data.partUnitNm,
					"partQty" 		: data.partCnt,		
					"partUnitCost"	: Math.floor(data.unitCost),		
					"ordCorpNm" 	: data.ordCorpNm==null?"-":data.ordCorpNm
				}).draw(true);				
			}

		});

		$('#btnAllCheck').prop("checked",false);
 		$('input[name=check]').prop("checked",false);
	}); 

	//모든 체크박스 선택
	$('#btnAllCheck').on('click',function(){
		if($('#btnAllCheck').prop("checked")){
			$('input:checkbox[name=check]').prop("checked",true);
		}else{
			$('input:checkbox[name=check]').prop("checked",false);
		}
	});

	//checkBox디테일 설정
	$(document).on('click','input[name=check]',function(e){
		if($('input:checkbox[name=check]:checked').length == $('input:checkbox[name=check]').length){
			$("#btnAllCheck").prop("checked", true);
		   }else{
		   	$("#btnAllCheck").prop("checked", false);
		}
	});

	// 수정폼
	$('#btnDtlEdit').on('click', function() {

		if (btnView != 'edit') {
			toastr.warning('수정할 항목을 선택해주세요.');
			return false;
		}
		$('button[name=dlvDateCalendar]').eq(tableIdx).attr('disabled',false);
		$('button[name=btnPartCd]').eq(tableIdx).attr('disabled',false);
		$('select[name=inspectYn]').eq(tableIdx).attr('disabled',false);
		$('input[name=partUnitCost]').eq(tableIdx).attr('disabled',false);
		//$('input[name=partUnitCost]').eq(tableIdx).val("");
		//$('input[name=partAmt]').eq(tableIdx).val("");
		
		if(individualOrderDtlTable.data().count()>0){
			$('#btnDtlSave').removeClass('d-none');  // 등록버튼
		}
	});

	// 삭제폼
	$('#btnDtlDel').on('click', function() {
		if ($('#individualOrderDtlTable tbody tr').hasClass('selected') == false) {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		if (btnView != 'edit') {
			toastr.warning('삭제할 항목을 선택해주세요.');
			return false;
		}
		$.ajax({
			url : '<c:url value="mm/individualOrderDtlDelete" />',
			type : 'POST',
			data : {
				'poNo'	: function(){return poNo;},
				'poSeq'	: function(){return poSeq;}
			},
			success : function(){
				$('#individualOrderDtlTable').DataTable().rows(tableIdx).remove().draw();
			}
		})
		$('#btnDtlSave').removeClass('d-none');
	});

	//발주수량 숫자만 입력하게 처리
	$(document).on('keyup',"input[name=partQty], input[name=partUnitCost]", function(event){
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

	//발주 저장처리
	$('#btnSave').on('click',function(){

		var check=true;
		var dataArray = new Array();
		
		if (!$.trim($('#dealCorpNm').val())) {
			$('#dealCorpNm').focus();
			toastr.warning('거래처명을 선택해 주세요.');
			$('button[name=btnDealCorp]').focus();
			return false;
		}

		if(individualOrderDtlTable.data().count()!=0){
			$('#individualOrderDtlTable tbody tr').each(function(index,item){
			
			if ($(this).find('td input[name=partQty]').val()=="") {
				toastr.warning('발주수량을 입력해주세요.');
				$(this).find('td input[name=partQty]').focus();
				check = false;
				return false;
			}

			if ($(this).find('td input[name=dlvDate]').val().length != 8) {
				toastr.warning('잘못된 납기요청일입니다. 확인해주세요.');
				$(this).find('td input[name=dlvDate]').focus();
				check = false;
				return false;
			}
			
			var rowData = new Object();
			
			rowData.poNo 			= 	$('#poNo').val();
			rowData.dealCorpCd 		= 	$('#dealCorpCd').val();
			rowData.mainChargr 		= 	$('#mainChargr').val();
			rowData.telNo 			= 	$('#telNo').val();
			rowData.poDate 			= 	$('#poDate').val().replace(/-/g,'');
			rowData.poRegChargr 	=	$('#poRegChargr').val();
			rowData.finspectYn		=	$('#finspectYn option:selected').val();
			rowData.confirmYn 		=	$('#confirmYn option:selected').val();
			rowData.useYn 			=	$('#useYn option:selected').val();
			rowData.receiptGubun 	=	$('#receiptGubun option:selected').val();
			rowData.poDesc 			=	$('#poDesc').val();
			poSeqValue 				=	individualOrderDtlTable.row(index).data().poSeq;
			rowData.poSeq 			=	poSeqValue==null?"":poSeqValue;
			rowData.mrpNo 			= 	"";
			rowData.partCd 			=	$(this).find('td input[name=partCd]').val();
			rowData.partRev 		=	$(this).find('td input[name=partRev]').val();
			rowData.inspectYn  		= 	$(this).find('td select[name=inspectYn] option:selected').val();
		    rowData.partQty 		= 	$(this).find('td input[name=partQty]').val().replace(/,/g,'');
		    rowData.safyStockCnt	= 	"0";
		    rowData.partUnitCost	= 	$(this).find('td input[name=partUnitCost]').val().replace(/,/g,"");
		    rowData.dlvDate 		= 	$(this).find('td input[name="dlvDate"]').val().replace(/-/g,"");
		    rowData.ordCorpCd 		= 	$(this).find('td input[name="ordCorpCd"]').val();
	        dataArray.push(rowData);
		});

		}else {
			var rowData = new Object();
			rowData.poNo = poNo;
			rowData.partCd = "";
			dataArray.push(rowData);
		}

		if(check == true){
			$.ajax({
				url :'<c:url value="mm/individualOrderAdmCreate"/>',
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				beforeSend  : function(){
					//처리중..
					$('#my-spinner').show();
				},
				success : function(res) {
					let data = res.data;
					sideView = "edit";
					if (res.result == 'ok') {
						btnView = "";

						$('#form').each(function(){
				        	this.reset();
				    	});

						$('#individualOrderDtlTable').DataTable().clear().draw();
						
						//uiProc2(true);
						//uiProc(true);
						
						$('#btnSave').addClass('d-none');
						$('#btnDtlEdit').attr('disabled',true);
						$('#btnDtlDel').attr('disabled',true);
						$('#btnAllCheck').prop("checked",false);
						$('input[name=check]').prop("checked",false);

						
						toastr.success('등록되었습니다.');
					} else {
						toastr.error(res.message);
					}

					//처리완료..
					$('#my-spinner').hide();
				},
				complete : function() {
				}
			});
		}
	});
   

	//거래처명 팝업 시작
   	var dealCorpPopUpTable;
   	function selectDealCorp() {	   	
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined) {
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
				dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
				language : lang_kor,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				lengthChange: false,
		        pageLength: 15,
				ajax : {
					url : '<c:url value="bm/dealCorpDataList"/>',
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
					{ data : 'registNo'		}
				],
				
				columnDefs : [{
					"defaultContent": "-", "targets": "_all",	"className": "text-center"
				}],
				order : [ [ 0, 'asc' ] ],
				buttons : [],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
			    $('#dealCorpCd').val(data.dealCorpCd);
			    $('#dealCorpNm').val(data.dealCorpNm);
			    $('#telNo').val(data.telNo);
			    $('#mainChargr').val(data.bizCharger);
			    
				$('#dealCorpPopUpModal').modal('hide');		
		    });
		    
		}else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#dealCorpPopUpModal').modal('show');		
   	} 


    //담당자 팝업 시작
	var userPopUpTable;
	function selectPoRegChargr() {
		if (userPopUpTable == null || userPopUpTable == undefined) {
			userPopUpTable = $('#userPopUpTable').DataTable({
				language : lang_kor,
				lengthChange : false,
				paging : true,
				info : true,
				ordering : true,
				processing : true,
				autoWidth : false,
				pageLength : 20,
				ajax : {
					url : '/sm/matrlUserDataList',
					type : 'GET',
					data : {
						
					}
				},
				rowId : 'userNumber',
				columns : [
					 { data : 'userNm'		},
					 { data : 'departmentNm'},
					 { data : 'postNm'		},
					 { data : 'chargrDutyNm'},
					 { data : 'workplaceNm'	},
					 { data : 'userDesc'	},
				],
				columnDefs : [ {
					"targets" : '_all',"className" : "text-center"
				} ],
				order : [ [ 0, 'asc' ] ],
			});
			$('#userPopUpTable tbody').on('click', 'tr', function() {
				var data = userPopUpTable.row(this).data();
				$('#poRegChargr').val(data.userNumber);
				$('#poRegChargrNm').val(data.userNm);
				$('#userPopUpModal').modal('hide');
			});
		} else {
			$('#userPopUpTable').DataTable().ajax.reload(function() {});
		}
		$('#userPopUpModal').modal('show');
	}

	//셀렉트박스생성
	function selectBoxHtml2(obj, id, sVal, row, meta) {
		var shtml;
		if(sideView == "edit"){
			shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '" disabled>';
		}else {
			shtml = '<select class="custom-select" name="'+ id +'" data-col="' + meta.col + '">';
		}
		
		var option;
		for (key in obj) {
			var tmp;
			if (obj[key].baseCd == sVal) {
				tmp = "<option value="+ obj[key].baseCd+ " selected>"+ obj[key].baseNm +"</option>";
			} else {
				tmp = "<option value="+obj[key].baseCd+">"+ obj[key].baseNm +"</option>";
			}
			option += tmp;
		}
		var ehtml = '</select>';
		return shtml + option + ehtml;
	}
	
	function uiProc(flag) {
		$("#finspectYn").attr("disabled", flag);
		$("#confirmYn").attr("disabled", flag);
		$("#useYn").attr("disabled", flag);
		$("#receiptGubun").attr("disabled", flag);
		$("#poDesc").attr("disabled", flag);

		$('#btnDealCorp').attr('disabled',flag);
		$('#btnPoRegChargr').attr('disabled',flag);
		$('#poDateCalendar').attr('disabled',flag);
	}

	function uiProc2(flag) {
		$("input[name=partCd]").attr("disabled", flag);
		$("input[name=partRev]").attr("disabled", flag);
		$("input[name=partNm]").attr("disabled", flag);
		$("input[name=partSpec]").attr("disabled", flag);
		$("select[name=inspectYn]").attr("disabled", flag);
		$("input[name=partUnit]").attr("disabled", flag);
		$("input[name=partQty]").attr("disabled", flag);
		$("input[name=partUnitCost]").attr("disabled", flag);
		$("input[name=partAmt]").attr("disabled", flag);
		$("button[name=dlvDateCalendar]").attr("disabled", flag);
		$('button[name=btnPartCd]').attr('disabled',flag);
	}

	$('input[name=partQty]').keypress(function(e){
		var check2=true;  	
		if(e.keyCode == 9){
		}
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
