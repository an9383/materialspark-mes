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
				<li class="breadcrumb-item"><a href="#">재고관리</a></li>
				<li class="breadcrumb-item active">현재고현황(사출)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 50%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id="inventoryTable">
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="20%">
								<col width="30%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th class="text-center">구분</th>
									<th class="text-center">차종</th>
									<th class="text-center">품번</th>
									<th class="text-center">품명</th>
									<th class="text-center">단위</th>
									<th class="text-center">현재고</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 49%;">
				<div class="card" id="formBox">
					<div class="table-responsive">
						<table class="table table-lg table-bordered mb-2" id="barcodeListTable">
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="25%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th class="text-center-th"><input type="checkbox" class="form-control" id="checkAll" name="checkAll"></th>
									<th class="text-center-th">입고일자</th>
									<th class="text-center-th">바코드</th>
									<th class="text-center-th">단위</th>
									<th class="text-center-th">수량</th>
									<th class="text-center-th">창고</th>
									<th class="text-center-th">구역</th>
								</tr>
							</thead>
						</table>
					</div>
					<hr>
					<div class="table-responsive">
						<table class="table table-lg table-bordered mb-2" id="inventoryDtlTable">
							<colgroup>
								<col width="5%">
								<col width="10%">
								<col width="15%">
								<col width="25%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th class="text-center-th">No.</th>
									<th class="text-center-th">구분</th>
									<th class="text-center-th">일자</th>
									<th class="text-center-th">바코드</th>
									<th class="text-center-th">수량</th>
									<th class="text-center-th">창고</th>
									<th class="text-center-th">구역</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<style>
	.bg-1 {
	  background-color: #F5DDAD !important;
	}
	.bg-2 {
	  background-color: #F1BCAE !important;
	}
	.bg-3 {
	  background-color: #C9DECF !important;
	}
	.bg-4 {
	  background-color: #A9CBD7 !important;
	}
</style>

<script>
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "55%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}

		state = !state;
	});

	let currentHref = "tmsc0050";
	let currentPage = $('.' + currentHref).attr('id');
	$(document).attr("title", "현재고현황(사출)");
	
	$('#' + currentPage).closest('.has-child', 'li').addClass('has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');

	let serverDateTo = "${serverDateTo}";
	let serverDate = "${serverDateTo}";
	let serverMonthTo = serverDate.substring(0, 7);

	let sideView = "";
	let spCd = null;
	let spType = "";
	let locationCd = '';
	let dateRangeVal = "";
	let itemCd = "";
	let itemNm = "";
	let itemCus = "";
	let spUnit = "";
	let selectSpType = "";
	
	//공통코드 처리 시작
	let itemGubunList = new Array(); 
	<c:forEach items="${itemGubunList}" var="info">
	if ( "${info.baseCd}" != '002' ) {
		var json = new Object();
		json.baseCd = "${info.baseCd}";
		json.baseNm = "${info.baseNm}";
		itemGubunList.push(json);
	}
	</c:forEach>
	
	let locCdCode = new Array(); // 창고코드
	<c:forEach items="${locCd}" var="info">
	if ( "${info.etc1}" == '사출' ) {
		var json = new Object();
		json.baseCd = "${info.baseCd}";
		json.baseNm = "${info.baseNm}";
		locCdCode.push(json);
	}
	</c:forEach>
	//공통코드 처리 끝

	//재고현황 목록조회
	let inventoryTable = $('#inventoryTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row mt-2'<'col-sm-12 col-md-9'i><'col-sm-12 col-md-3'B>>",
		language : lang_kor,
		paging : true,
		info : true,
		searching : true,
		ordering : true,
		processing : false,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY : "70vh",
		rowId : 'poNo',
		ajax : {
			url : '<c:url value="tm/stockPaymentAdmList"/>',
			type : 'GET',
			data : {
				'tmMon' : function(){ return serverMonthTo.replace(/-/g, ''); },
				'tmDate' : function(){ return serverDateTo.replace(/-/g, ''); },
				'mainGubun' : function(){ return '001'; },
				'spType' : function(){ return spType; },
				'realQtyOption' : function(){ return "Y"; },
				'locationCd' : function(){ return locationCd; },
				'realStockPage' : function(){ return 'Y';},
			}
		},
		rowId : 'partCd',
		columns : [ 
			{//구분
				data : 'spTypeNm'
			},
			{//차종
				data : 'itemModelNm'
			},
			{//품번
				data : 'spCd'
			},
			{//품명
				data : 'spNm'
			},
			{//단위
				data : 'spUnit'
			},
			{//현재고
				data : 'realQty',
				render : function(data, type, row, meta){
					if ( data != null ) {
						return rmDecimal(data);
					} else {
						return '';
					}
				},
				"className" : "text-right"
			},
		],
		order : [ [ 0, 'asc' ] ],
		buttons : [ 'copy', 'excel', 'print' ],
	});

	// 세부 목록 보기
	$('#inventoryTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
 			$(this).removeClass('selected');
 			return false;
		} else {
			$('#inventoryTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		
		$("#checkAll").prop("checked", false);

		spCd = inventoryTable.row(this).data().itemSeq;
		itemCd = inventoryTable.row(this).data().spCd;
		itemNm = inventoryTable.row(this).data().spNm;
		itemCus = inventoryTable.row(this).data().itemCus;
		spUnit = inventoryTable.row(this).data().spUnit;
		selectSpType = inventoryTable.row(this).data().spType; // 구분 (001 : 제품, 003 : 반제품, 004 : 원자재)
		
		sideView = "edit";
		dateRangeVal = '';

		$('#barcodeListTable').DataTable().ajax.reload(function(){
			rowDateColorChange();
		},true);
		
		$('#inventoryDtlTable').DataTable().ajax.reload(function(){});

		if ( inventoryTable.row(this).data().spType == "004" || inventoryTable.row(this).data().spType == "005" ) {
			$('#topDiv').removeClass('d-none');	//입고일자 범례표시
			
			let tr = $(this).closest('tr');
			let row = inventoryTable.row( tr );
			let idx = $.inArray( tr.attr('id'), detailRows );

	        if ( row.child.isShown() ) {
	            tr.removeClass( 'details' );
	            row.child.hide();
	 
	            // Remove from the 'open' array
	            detailRows.splice( idx, 1 );
	        } else {
	            tr.addClass( 'details' );
	            row.child( format( row.data() ) ).show();
	 
	            // Add to the 'open' array
	            if ( idx === -1 ) {
	                detailRows.push( tr.attr('id') );
	            }
	        }
		} else {
			$('#topDiv').addClass('d-none');	//입고일자 범례표시
		}
	});

	let html1 = '<div class="row">&nbsp;<label class="input-label-sm">기간 조회</label>';
	html1 += '<input class="form-control mtz-monthpicker-widgetcontainer" type="text" id="demo-2" style="max-width:70px;">';
	html1 += '&nbsp;&nbsp&nbsp;&nbsp<label class="input-label-sm">구분</label>';
    html1 += '<select id="itemGubunSelect" class="custom-select custom-select-sm" style="max-width:70px;"></select>';
    html1 += '&nbsp;&nbsp&nbsp;&nbsp<label class="input-label-sm">창고</label>';
	html1 += '<div class="form-group input-sub m-0">';
	html1 += '<select class="custom-select mr-1" id="locCdSelect">';
	html1 += '</select></div>&nbsp;&nbsp;';
    html1 += '<button type="button" class="btn btn-primary" id="btnRefresh">새로고침</button>'
	html1 += '</div>';

	$('#inventoryTable_length').html(html1);
	$('#demo-2').val(serverMonthTo);
	
	selectBoxAppend(itemGubunList, "itemGubunSelect", "", "1");
	selectBoxAppend(locCdCode, "locCdSelect", "", "1");
	
	//기간 조회 설정
	let nowYear = serverDate.substr(0,4) * 1;
	$('#demo-2').monthpicker({
		pattern : 'yyyy-mm',
		selectedYear : nowYear,
		startYear : nowYear - 100,
		finalYear : nowYear + 100,
	});
	
	//기간조회 선택조건
	$('#demo-2').on('change', function() {
		serverMonthTo = $('#demo-2').val();
		spCd = "";
		$('#inventoryTable').DataTable().ajax.reload(function(){});
		$('#barcodeListTable').DataTable().clear().draw();
		$('#inventoryDtlTable').DataTable().clear().draw();
	});

	//구분,품목구분 선택조건
	$('#itemGubunSelect, #locCdSelect').on('change', function() {
		spType = $('#itemGubunSelect option:selected').val();
		locationCd = $('#locCdSelect option:selected').val();
		spCd = "";
		$('#inventoryTable').DataTable().ajax.reload(function(){});
		$('#barcodeListTable').DataTable().clear().draw();
		$('#inventoryDtlTable').DataTable().clear().draw();
    });

	//새로고침 버튼
	$('#btnRefresh').on('click',function(){
		spCd = "";
		$('#inventoryTable').DataTable().ajax.reload(function() {});
		$('#barcodeListTable').DataTable().clear().draw();
		$('#inventoryDtlTable').DataTable().clear().draw();
	});

	//창고 상세내역 시작
	let detailRows = [];
	function format (d) {
		let locHtml = '';
		$.ajax({
			url : '<c:url value="tm/stockPaymentAdmLocList"/>',
			type : 'GET',
            async: false,
			data : {
				'tmMon' : function(){ return serverMonthTo.replace(/-/g, ''); },
				'mainGubun' : function(){ return '001'; },
				'realQtyOption' : function(){ return "Y"; },
				'itemSeq' : function(){ return spCd },
				'locationCd' : function(){ return locationCd; },
				'realStockPage' : function(){ return 'Y';},
			},
            success: function (res) {
                let data = res.data;
                if ( res.result == 'ok' ) {
                	locHtml	 = '<table class="table table-bordered">';
                	locHtml	+= '	<thead class="thead-light">';
                	locHtml	+= '		<tr>';
        			locHtml	+= '			<th style="">창고</th>';
        			locHtml	+= '			<th style="">현재고</th>';
        			locHtml	+= '		</tr>';
        			locHtml	+= '	</thead>';
        			locHtml	+= '	<tbody>';
                    for ( var i=0; i < data.length; i++ ) {
                    	locHtml	+= '		<tr>';
            			locHtml	+= '			<td class="text-center-td">'+data[i].locationNm+'</td>';
            			locHtml	+= '			<td class="text-center-td">'+rmDecimal(data[i].realQty)+'</td>';
            			locHtml	+= '		</tr>';
                    }
                    locHtml	+= '	</tbody>';
                    locHtml	+= '</table>';
                } else {
                	toastr.error(res.message);
                }
            }
		});
		return locHtml;
	}
	//창고 상세내역 끝
	
	//우측 상단 목록조회
	let barcodeListTable = $('#barcodeListTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-7'l><'col-sm-12 col-md-5'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row mt-2'<'col-sm-12 col-md-9'i><'col-sm-12 col-md-3'B>>",
		language : lang_kor,
		paging : true,
		info : true,
		searching : true,
		ordering : true,
		processing : false,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY : "27vh",
		ajax : {
			url : '<c:url value="tm/stockPaymentAdmBarcodeList"/>',
			type : 'GET',
			data : {
				'realQtyOption' : "Y",
				'mainGubun' : function(){ return '001'; },
				'tmMon' : function(){ return serverMonthTo.replace(/-/g, ''); },
				'itemSeq' : function(){ return spCd; },
				'locationCd' : function(){ return $('#locCdSelect option:selected').val(); },
				'dateRange' : function(){ return dateRangeVal; },
				'realStockPage' : function(){ return 'Y';},
			},
		},
		rowId : 'rowId',
		columns : [
			{//체크박스
				render : function(data, type, row, meta) {
					return '<input class="form-control" type="checkbox" name="printList" id="'+meta.row+'"/>';
				}
			},
			{//입고일자
				data : 'inDate',
				render : function(data, type, row, meta) {
					if ( data != null && data != '' ) {
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			},
			{//바코드
				data : 'barcodeNo'
			},
			{//단위
				data : 'spUnit',
			}, 
			{//수량
				data : 'realQty',
				render : function (data, type, row, meta) {
					if ( data != null ) {
						return rmDecimal(data);
					} else {
						return '';
					}
				},
				"className" : "text-right"
			},
			{//창고
				data : 'locationNm',
			}, 
			{//구역
				data : 'areaNm',
				render : function (data, type, row, meta) {
					if ( data != null && data != '' ) {
						return data + " / " + row['floorNm'];
					} else {
						return '';
					}
				}
			},
		],
			columnDefs : [
			{ targets : '_all', className : 'text-center'} 
		],
		order : [ [ 0, 'asc' ] ],
		buttons : [ 'copy', 'excel', 'print' ],
		drawCallback : function(){
	    	let api = this.api();

	    	/* //자재일경우 해당
    		for ( var i = 0; i < api.data().count(); i++ ) {
    			if ( api.row(i).data().spType == "004" || api.row(i).data().spType == "005" ) {
			    	if ( api.row(i).data().inDate != null ) {
				    	
				    	let inDateVal = api.row(i).data().inDate;
				    	console.log(inDateVal);
				    	
			    		if(moment().subtract('6','M').format('YYYYMMDD')<inDateVal){
			    			$('#barcodeListTable tbody tr').eq(i).find('td').eq(1).css('background','white');
						}else if(moment().subtract('12','M').format('YYYYMMDD')<inDateVal){
							$('#barcodeListTable tbody tr').eq(i).find('td').eq(1).css('background','#fff2007d');
						}else if(moment().subtract('24','M').format('YYYYMMDD')<inDateVal){
							$('#barcodeListTable tbody tr').eq(i).find('td').eq(1).css('background','#ffa263b0');
						}else{
							$('#barcodeListTable tbody tr').eq(i).find('td').eq(1).css('background','#ed1c2461');
						}   
			    	}
		    	}//if문 끝
		    }//for문 끝 */
		}//drawCallback 끝
	});

	let html2 = '<div class="float-left mt-1" id="rightTopLabel" style="display: inline;">';
	html2 += '<div class="float-left" id="topDiv"><label class="mr-1 btn" style="background-color: #eeeeee;font-weight: 500;">범례</label>';
	html2 += '<button class="mr-1 btn" id="6MonPass" style="background-color:#fff2007d; width:65px; font-size: 0.725rem; font-weight: 500;height: 24px;">6개월</button>';
	//html2 += '<span class="oi oi-arrow-right mr-1"></span>';
	html2 += '<button class="mr-1 btn" id="12MonPass" style="background-color:#ffa263b0; width:65px; font-size: 0.725rem; font-weight: 500;height: 24px;">12개월</button>';
	//html2 += '<span class="oi oi-arrow-right mr-1"></span>';
	html2 += '<button class="mr-1 btn" id="24MonPass" style="background-color:#ed1c2461; width:65px; font-size: 0.725rem;color: black;font-weight: 500;height: 24px;">24개월</button>';
	html2 += '<button type="button" class="btn btn-primary" id="btnRefresh2">새로고침</button>';
	html2 += '</div>';
	html2 += '<button type="button" class="btn btn-success ml-1" id="printBarcode">바코드출력</button>';
	$('#barcodeListTable_length').html(html2);

	//새로고침 선택시
	$('#btnRefresh2').on('click', function() {
		if ( sideView != "edit" ) {
			toastr.warning("품목을 선택해주세요.");
			return false;
		}
		dateRangeVal = "";
		$('#barcodeListTable').DataTable().ajax.reload(function(){
			rowDateColorChange();
		},true);
	});

	//6개월 범례 클릭시
	$('#6MonPass').on('click', function() {
		if ( sideView != "edit" ) {
			toastr.warning("품목을 선택해주세요.");
			return false;
		}
		dateRangeVal = "6";
		$('#barcodeListTable').DataTable().ajax.reload(function(){
			rowDateColorChange();
		},true);
	});

	//12개월 범례 클릭시
	$('#12MonPass').on('click', function() {
		if ( sideView != "edit" ) {
			toastr.warning("품목을 선택해주세요.");
			return false;
		}
		dateRangeVal = "12";
		$('#barcodeListTable').DataTable().ajax.reload(function(){
			rowDateColorChange();
		},true);
	});

	//24개월 범례 클릭시
	$('#24MonPass').on('click', function() {
		if ( sideView != "edit" ) {
			toastr.warning("품목을 선택해주세요.");
			return false;
		}
		dateRangeVal = "24";
		$('#barcodeListTable').DataTable().ajax.reload(function(){
			rowDateColorChange();
		},true);
	});

	//범례
	function rowDateColorChange(){
		if(selectSpType=='004'){	//자재만
			$('#barcodeListTable tbody tr').each(function(index, item) {
	    		let inDateVal = $(this).find('td').eq(1).text().replace(/-/g,'');
	    		if(inDateVal!=''){
	    			if(moment().subtract('6','M').format('YYYYMMDD')<inDateVal){
			    		console.log('ok')
		    			$(this).find('td').eq(1).css('background','white');
					}else if(moment().subtract('12','M').format('YYYYMMDD')<inDateVal){
						console.log('6개월 넘었음')
						$(this).find('td').eq(1).css('background','#fff2007d');
					}else if(moment().subtract('24','M').format('YYYYMMDD')<inDateVal){
						console.log('12개월 넘었음')
						$(this).find('td').eq(1).css('background','#ffa263b0');
					}else{
						console.log('24개월 넘었음')
						$(this).find('td').eq(1).css('background','#ed1c2461');
					}   
		    	}
		    });
		}
	}
	
	//우측 하단 목록조회
	let inventoryDtlTable = $('#inventoryDtlTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-7'><'col-sm-12 col-md-5'f>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row mt-2'<'col-sm-12 col-md-9'i><'col-sm-12 col-md-3'B>>",
		language : lang_kor,
		paging : true,
		info : true,
		searching : true,
		ordering : false,
		processing : false,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY : "27vh",
		ajax : {
			url : '<c:url value="tm/stockPaymentAdmRead"/>',
			type : 'GET',
			data : {
				'mainGubun' : function(){ return '001'; },
				'spCd' : function(){ return spCd; },
				'startDate' : function(){ return serverMonthTo.replace(/-/g, ''); },
				'locationCd' : function(){ return locationCd; },
				'spSubGubunYn' : 'Y',
			},
		},
		rowId : 'rowId',
		columns : [ 
			{//No.
				render : function(data, type, row, meta) {
					return meta.row + 1;
				}
			},
			{//구분
				data : 'spSubGubun'
			}, 
			{//일자
				data : 'spDate',
				render : function (data, type, row, meta) {
					if ( data != null && data != '' ) {
						return moment(data).format('YYYY-MM-DD');
					} else {
						return '';
					}
				}
			}, 
			{//바코드
				data : 'barcodeNo'
			},
			{//수량
				data : 'spQty',
				render : function(data, type, row, meta){
					if ( data != null ) {
						return rmDecimal(data);
					} else {
						return '';
					}
				},
				"className" : "text-right"
			},
			{//창고
				data : 'locationCdNm',
			}, 
			{//구역
				data : 'areaCdNm',
				render : function(data, type, row, meta){
					if ( data != null && data != '' ) {
						return data + " / " + row['floorCd'];
					} else {
						return '';
					}
				}
			}, 
		],
		columnDefs : [
			{ targets : '_all', className : 'text-center'} 
		],
		order : [ [ 0, 'asc' ] ],
		buttons : [ 'copy', 'excel', 'print' ],
		drawCallback : function(){
		}
	});
	
	//전체선택클릭
	$('#checkAll').on('click',function(){
		if ( $('#checkAll').prop("checked") ) {
			$('#barcodeListTable tbody tr').each(function(index, item) {
				if ( !$(this).find('input:checkbox[name=printList]').is(':disabled') ) {
					$(this).find('input:checkbox[name=printList]').prop("checked", true);
				}
			});
		} else {
			$('#barcodeListTable tbody tr').each(function(index, item) {	
				if ( !$(this).find('input:checkbox[name=printList]').is(':disabled') ) {
					$(this).find('input:checkbox[name=printList]').prop("checked", false);
				}
			});
		}
	});
	
</script>
<script>
	// ************************************************************ 라벨출력 ************************************************************
	$('#printBarcode').on('click', function() {
		let labelToday = new Date();
		console.log("라벨출력 printBarcode onClick 시작시간: " + labelToday);
		
		let trPrintList = new Array(); 	// 통합된 프린트할 데이터 배열
		let columnList = new Array();	// 통합된 프린트할 컬럼 배열
		let columnArr = new Array();	// 각 용지의 컬럼 배열
		let paperSize = "";				// 용지 사이즈
		
		//예외처리
		if ( !$('input[name=printList]').is(':checked') ) {
			toastr.warning("인쇄할 항목을 선택해주세요.");
			return false;
		}
		
		$('input[name=printList]:checked').each(function(index, item) {
			let subTrData = barcodeListTable.row($(this).attr("id")).data(); // 바코드 테이블 행	
			let trPrintArr = new Array(); // 각 용지의 데이터 배열

			let workChargrNm = "";	// 작업자
			let outputQty = "";		// 생산량
			let ordDate = "";		// 생산일자
			let gongjungChk = "합격";	// 공정검사 확인
			let jajuChk = "합격";		// 자주검사 확인
			let okNgChk = "";		// 합불판정/출하검사확인
			
			//합불판정/출하검사확인
		    if (subTrData.qaEval == "001" ) {
		    	okNgChk = "합격";
			} else if (subTrData.qaEval == "002" ) {
				okNgChk = "불합격";
			} else if (subTrData.qaEval == null ){
				okNgChk = "미판정";
			}

			// 자재 바코드가 아닐 때만 실행
			if (selectSpType != '004') {
				$.ajax({
			        url : '<c:url value="tm/listForLabel"/>',
			        async : false,
			        type : 'GET',
			        data : {
				        'barcodeNo' : function(){return subTrData.barcodeNo;},
			        },
			        success: function(res){
				        let data = res.data;

				        if (data != null) {
					        workChargrNm = data.workChargrNm; //작업자
					        outputQty = data.outputQty; //생산량
					        ordDate = data.ordDate; //생산일자
					        gongjungChk = (data.gongjungChk=='002') ? "불합격" : "합격"; //공정검사확인
					        jajuChk = (data.jajuChk=='002') ? "불합격" : "합격"; //자주검사확인
				        }
				    }
			    });
			}
		    
			// 양식에 맞추어 컬럼 집어넣기
			if ( selectSpType == '001' || selectSpType == '002' || selectSpType == '003' ) { // 제품, 상품, 반제품
				paperSize = "productLabel";
				columnArr = ["품목번호", "차종", "품명", "생산일자", "자주검사", "생산수량", "작업자", "공정검사 확인"];
				
				trPrintArr[0] = itemCd;
				trPrintArr[1] = subTrData.itemModelNm;
				trPrintArr[2] = itemNm;
				trPrintArr[3] = moment(subTrData.inDate).format("YY/MM/DD");
				trPrintArr[4] = jajuChk;
				trPrintArr[5] = parseFloat(subTrData.realQty) + " " + spUnit;
				trPrintArr[6] = workChargrNm;
				trPrintArr[7] = gongjungChk;
				trPrintArr[8] = subTrData.barcodeNo;
			} else if (selectSpType == '004' && subTrData.locationCd == '006') { // 자재 바코드이면서 원자재 창고 라벨 
				paperSize = "materialLabel";
				columnArr = ["차종", "품목번호", "품명", "입고일자", "합부판정", "위치", "입고수량", "업체로트", "입고처"];

				trPrintArr[9] = subTrData.itemModelNm;
				trPrintArr[0] = itemCd;
				trPrintArr[1] = itemNm;
				trPrintArr[2] = moment(subTrData.inDate).format("YY/MM/DD");
				trPrintArr[3] = okNgChk;
				trPrintArr[4] = subTrData.areaNm + " / " + subTrData.floorNm;
				trPrintArr[5] = parseFloat(subTrData.realQty) + " " + spUnit;
				trPrintArr[6] = subTrData.lotNo;
				trPrintArr[7] = subTrData.itemCusNm;
				trPrintArr[8] = subTrData.barcodeNo;
			} else if (selectSpType == '004') { // 자재 바코드이면서 공정 창고 라벨
				paperSize = "materialLabel";
				columnArr = ["차종", "품목번호", "품명", "입고일자", "합부판정", "위치", "잔량", "업체로트", "입고처"];

				trPrintArr[9] = subTrData.itemModelNm;
				trPrintArr[0] = itemCd;
				trPrintArr[1] = itemNm;
				trPrintArr[2] = moment(subTrData.inDate).format("YY/MM/DD");
				trPrintArr[3] = okNgChk;
				trPrintArr[4] = subTrData.floorNm;
				trPrintArr[5] = parseFloat(subTrData.realQty) + " " + spUnit;
				trPrintArr[6] = subTrData.lotNo;
				trPrintArr[7] = subTrData.itemCusNm;
				trPrintArr[8] = subTrData.barcodeNo;
	        } 

			trPrintList.push(trPrintArr);
			columnList.push(columnArr);
		})
		
		if (trPrintList.length > 0) {
	    	labelPrint(trPrintList, columnList, paperSize);
		}
	});

	
	//Do printing...
// 	function labelPrint(printList, columnList, paperSize) {
// 	    sendJson(printList, columnList, paperSize);
// 	}
	
// 	function sendJson(printList, columnList, paperSize) {
	
// 		var obj = {
// 			printNo 	: 1,				// 출력할 프린터 번호
// 			printCnt 	: printList.length, // 출력될 장수
//             printLalCnt : 1,				// 출력될 라벨 수
//             printOrder 	: 1,				// 남은 라벨 수
//             data 		: printList,		// 데이터
//             column		: columnList,		// 컬럼
//             paperSize 	: paperSize,		// 용지 양식 이름
//             company 	: "Daerim",			// 기업 이름
//             reseverd6 	: "",
//             reseverd7 	: ""
// 		};
// 		var send = JSON.stringify(obj);
// 		//console.log(send);
// 		sendMessage(send)
// 	}

	function labelPrint(printList, columnList, paperSize) {
		for (var i = 0; i < printList.length; i++) {
		    let cmds = {};
		    let cmd = "";
	
			// 제품
			if (paperSize == 'productLabel') {
				cmd += "{D0520,0980,0500|}";
				cmd += "{AY;+04,0|}";
				cmd += "{AX;-020,+000,+00|}";
				cmd += "{C|}";
		
				cmd += "{LC;0010,0035,0980,0110,1,5|}";
				cmd += "{LC;0010,0035,0980,0180,1,5|}";
				cmd += "{LC;0010,0035,0980,0250,1,5|}";
				cmd += "{LC;0010,0035,0980,0320,1,5|}";
				cmd += "{LC;0010,0035,0980,0485,1,5|}";
				cmd += "{LC;0659,0184,0980,0380,1,5|}";
		
				cmd += "{LC;0155,0035,0155,0320,0,5|}";
				cmd += "{LC;0655,0035,0655,0110,0,5|}";
				cmd += "{LC;0480,0035,0480,0110,0,5|}";
				cmd += "{LC;0480,0180,0480,0320,0,5|}";
				cmd += "{LC;0655,0180,0655,0485,0,5|}";
		
				cmd += "{PV23;0015,0090,0040,0040,01,0,00,B="+columnList[i][0]+"|}";
				cmd += "{PV23;0165,0090,0040,0040,01,0,00,B="+printList[i][0]+"|}";
				cmd += "{PV23;0500,0090,0040,0040,01,0,00,B="+columnList[i][1]+"|}";
				cmd += "{PV23;0670,0090,0040,0040,01,0,00,B="+printList[i][1]+"|}";
				cmd += "{PV23;0015,0160,0040,0040,01,0,00,B="+columnList[i][2]+"|}";
				cmd += "{PV23;0165,0160,0040,0040,01,0,00,B="+printList[i][2]+"|}";
				cmd += "{PV23;0015,0230,0040,0040,01,0,00,B="+columnList[i][3]+"|}";
				cmd += "{PV23;0165,0230,0040,0040,01,0,00,B="+printList[i][3]+"|}";
				cmd += "{PV23;0500,0230,0040,0040,01,0,00,B="+columnList[i][4]+"|}";
				cmd += "{PV23;0670,0230,0040,0040,01,0,00,B="+printList[i][4]+"|}";
				cmd += "{PV23;0015,0300,0040,0040,01,0,00,B="+columnList[i][5]+"|}";
				cmd += "{PV23;0165,0300,0040,0040,01,0,00,B="+printList[i][5]+"|}";
				cmd += "{PV23;0500,0300,0040,0040,01,0,00,B="+columnList[i][6]+"|}";
				cmd += "{PV23;0670,0300,0040,0040,01,0,00,B="+printList[i][6]+"|}";
				cmd += "{PV23;0710,0365,0040,0040,01,0,00,B="+columnList[i][7]+"|}";
				cmd += "{PV23;0770,0450,0040,0040,01,0,00,B="+printList[i][7]+"|}";
				cmd += "{XB03;0120,0350,9,3,02,0,0100,+0000000001,000,1,00|}";
				cmd += "{RB03;"+printList[i][8]+"|}";
					
				cmd += "{XS;I,0001,0002C4001|}";
			};
	
			//자재
			if (paperSize == 'materialLabel') {
				cmd += "{AY;+04,0|}";
				cmd += "{AX;-020,+000,+00|}";
				cmd += "{C|}";
				
				cmd += "{LC;0010,0035,0980,0110,1,5|}";
				cmd += "{LC;0010,0035,0980,0180,1,5|}";
				cmd += "{LC;0010,0035,0980,0250,1,5|}";
				cmd += "{LC;0010,0035,0980,0320,1,5|}";
				cmd += "{LC;0010,0035,0980,0485,1,5|}";
				
				cmd += "{LC;0155,0035,0155,0320,0,5|}";
				cmd += "{LC;0335,0180,0335,0320,0,5|}";
				cmd += "{LC;0490,0035,0490,0110,0,5|}";
				cmd += "{LC;0490,0180,0490,0320,0,5|}";
				cmd += "{LC;0640,0035,0640,0110,0,5|}";
				cmd += "{LC;0640,0180,0640,0320,0,5|}";
				cmd += "{LC;0795,0180,0795,0320,0,5|}";
				
				cmd += "{PV23;0015,0090,0040,0040,01,0,00,B="+columnList[i][0]+"|}";
				cmd += "{PV23;0165,0090,0040,0040,01,0,00,B="+printList[i][9]+"|}";
				cmd += "{PV23;0500,0090,0040,0040,01,0,00,B="+columnList[i][1]+"|}";
				cmd += "{PV23;0670,0090,0040,0040,01,0,00,B="+printList[i][0]+"|}";
				cmd += "{PV23;0015,0160,0040,0040,01,0,00,B="+columnList[i][2]+"|}";
				cmd += "{PV23;0170,0160,0040,0040,01,0,00,B="+printList[i][1]+"|}";
				cmd += "{PV23;0015,0230,0040,0040,01,0,00,B="+columnList[i][3]+"|}";
				cmd += "{PV23;0170,0230,0035,0035,01,0,00,B="+printList[i][2]+"|}";
				cmd += "{PV23;0345,0230,0040,0040,01,0,00,B="+columnList[i][4]+"|}";
				cmd += "{PV23;0517,0230,0040,0040,01,0,00,B="+printList[i][3]+"|}";
				cmd += "{PV23;0650,0230,0040,0040,01,0,00,B="+columnList[i][5]+"|}";
				cmd += "{PV23;0810,0230,0035,0035,01,0,00,B="+printList[i][4]+"|}";
				cmd += "{PV23;0015,0300,0040,0040,01,0,00,B="+columnList[i][6]+"|}";
				cmd += "{PV23;0170,0300,0035,0035,01,0,00,B="+printList[i][5]+"|}";
				cmd += "{PV23;0345,0300,0040,0040,01,0,00,B="+columnList[i][7]+"|}";
				cmd += "{PV23;0505,0300,0035,0035,01,0,00,B="+printList[i][6]+"|}";
				cmd += "{PV23;0650,0300,0040,0040,01,0,00,B="+columnList[i][8]+"|}";
				cmd += "{PV23;0810,0300,0035,0035,01,0,00,B="+printList[i][7]+"|}";
				cmd += "{XB03;0160,0350,9,3,03,0,0100,+0000000001,000,1,00|}";
				cmd += "{RB03;"+printList[i][8]+"|}";
					    
				cmd += "{XS;I,0001,0002C4001|}";
			};
			
		    cmds.cmd = cmd; // 인쇄 명령어
			cmds.action = ""; // 동작
		    
		    sendMessage(JSON.stringify(cmds)); // 전송
		}
	}
	
	//웹 서버를 접속한다.
	var webSocket = new WebSocket("ws://localhost:9998");
	// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
	var messageTextArea = document.getElementById("installedPrinterName");
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		toastr.success('인쇄 서버에 연결되었습니다.')
		$('#wsStateView').text('연결됨');
		$('#wsStateView').css('color','#19FF00');
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		toastr.error('인쇄 서버가 종료되었습니다.')
		$('#wsStateView').text('연결끊김');
		$('#wsStateView').css('color','#FF0004');
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		console.log(message);
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(webSocket.readyState == 1) {
			let labelToday = new Date();
			console.log("라벨출력 sendMessage() 시작시간: " + labelToday);
			
			webSocket.send(cmd);
		} else {
			toastr.error('인쇄 서버와의 연결을 확인해주세요.');
			//webSocket = new WebSocket("ws://localhost:8181");
		}
	}

</script>


</body>
</html>
