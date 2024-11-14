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
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">불량내역조회(상세)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 99%; padding-bottom:0px;">
				<div class="card" style="margin-bottom: 10px;">
					<div class="row" style="margin-bottom: 10px;">
						&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">불량일자</label>
						
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="faultyDateFromCal" />
							<button	onclick="fnPopUpCalendar(faultyDateFromCal,faultyDateFromCal,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="faultyDateFromCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
						
						 
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width: 97px;" type="text" id="faultyDateToCal" />
							<button	onclick="fnPopUpCalendar(faultyDateToCal,faultyDateToCal,'yyyy-mm-dd')"	class="btn btn-secondary input-sub-search" id="faultyDateToCalendar" type="button">
								<span class="oi oi-calendar"></span>
							</button>
						</div>
						&nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
						
						<div style="margin-right: 5%; display: flex; flex-direction: column;">
							<!-- <label class="ml-2" style="line-height: 10px;">*선택한 날짜의 07:00 ~ 다음날 06:59 까지 조회됩니다.</label> -->
							<label class="ml-2" style="line-height: 14px;">*가로 스크롤: Shift+마우스 스크롤</label>
						</div>
						
						<div style="/* margin-right: 40%; */">
							<button type='button' class='btn btn-success' id='btnFakeExcel' disabled>엑셀 다운</button>
						</div>
						
						<div style="margin-right: 40%;"></div>
						
						<div style="display: flex; flex-wrap: nowrap;width: 265px;flex-direction: row;">
							<label style="width: 45px; line-height: 24px;" id="searchLabel">검색 :</label>
						</div>
					</div>
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="allFaulQty">전체 조회</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="faultyQty">권취잔량</a></li>
						</ul>
					</div>
				</div>
				
				<div class="table-responsive" style="padding-bottom: 5px;">
				
					<!-- 전체 값 합치기 -->
					<div id="allFaultView">
						<table id="allFaultTable" class="table table-bordered" >
							<thead class="thead-light">
								<tr id="gubunHeader"></tr>
								<tr id="allFaultHeader"> </tr>
								<tr id="allFaultHeader2"> </tr>
							</thead>
							
							<tfoot>
								<tr id="allFaultFooter"></tr>
							</tfoot>
						</table>
					</div>
					<!-- 전체 값 합치기 -->
				
					
					
					<!-- 권취잔량 교체 -->
					<div id="faultyQtyView" class="d-none">
						<table id="faultyQtyTable" class="table table-bordered" >
							<colgroup>
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th style="min-width:25px" class="text-center">일자</th>
									<th style="min-width:25px" class="text-center">주야</th>
									<th style="min-width:25px" class="text-center">설비명</th>
									<th style="min-width:25px" class="text-center">제품</th>
									<th style="min-width:25px" class="text-center">재질</th>
									<th style="min-width:25px" class="text-center">주자재 귄취잔량 합</th>
									<th style="min-width:25px" class="text-center">부자재 귄취잔량 합</th>
									<th style="min-width:25px" class="text-center">작업조</th>
									<th style="min-width:25px" class="text-center">작업자</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="5" style="text-align: center">합계</td>
									<td colspan="" id="mainFaultyQtySum" style="text-align:right">0</td>
									<td colspan="" id="subFaultyQtySum" style="text-align:right">0</td>
									<td colspan="2" style="text-align: center"></td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					
					
					
				</div>
			</div>
		</div>
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc3080';
	let currentHref = 'wmsc3080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","불량내역조회(상세)");

	
	let notHiddenArray = '';	//columns 값 지정 Array
	let factoryCode = "<%=factoryCode%>";
	
	
	let faultyDateFrom = "${serverDateFrom}";
// 	let faultyDateFrom = '2023-01-09';
	$('#faultyDateFromCal').val(faultyDateFrom);
	let faultyDateTo = "${serverDate}";
// 	let faultyDateTo = '2023-01-09';
	$('#faultyDateToCal').val(faultyDateTo);
	
	let processFaultyNm =  "${processFaultyNm}";
	let matrlFaultyNm 	=  "${matrlFaultyNm}";
	let replaceFaultyNm =  "${replaceFaultyNm}";
	let troubleFaultyNm =  "${troubleFaultyNm}";
	
	let faultyNm114 =  "${faultyNm114}";
	let faultyNm115 =  "${faultyNm115}";
	let faultyNm116 =  "${faultyNm116}";
	
	let code052Count =  "${code052Count}";
	let code053Count =  "${code053Count}";
	let code054Count =  "${code054Count}";
	let code055Count =  "${code055Count}";
	let code114Count =  "${code114Count}";
	let code115Count =  "${code115Count}";
	let code116Count =  "${code116Count}";

	
	let tapTemp = 5;	//탭별 구분
	let renderYn = false;
	
	//공통코드 처리 시작
	var equipGroupCode = new Array();	//설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>

	var ordGubunCode = new Array();		//오더구분(주/야 구분)
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>    
    //공통코드 처리 종료 
    
	var processFaulty = new Array(); //Cutting 수량(processFaulty)
    <c:forEach items="${processFaulty}" var="info">
		var json=new Object();
		json.id="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		json.baseCd="${info.baseCd}";
		json.useYnCd="${info.useYnCd}";
		processFaulty.push(json);
	</c:forEach>    

    var matrlFaulty = new Array(); //Metal 교체 Loss(matrlFaulty)
    <c:forEach items="${matrlFaulty}" var="info">
		var json=new Object();
		json.id="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		json.baseCd="${info.baseCd}";
		json.useYnCd="${info.useYnCd}";
		matrlFaulty.push(json);
	</c:forEach>

    var changeFaulty = new Array(); //Film 교체 Loss(changeFaulty)
    <c:forEach items="${changeFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.useYnCd="${info.useYnCd}";
		changeFaulty.push(json);
	</c:forEach>
	
    var equipTroubleFaulty = new Array(); //Teflon 교체 Loss(equipTroubleFaulty)
	<c:forEach items="${equipTroubleFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.useYnCd="${info.useYnCd}";
		equipTroubleFaulty.push(json);
	</c:forEach>
	
	
	
	var faulty114Code = new Array(); //trip Loss 
	<c:forEach items="${faulty114}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.useYnCd="${info.useYnCd}";
		faulty114Code.push(json);
	</c:forEach>
	
    var faulty115Code = new Array(); //공정 Trouble 조치 Loss 
	<c:forEach items="${faulty115}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.useYnCd="${info.useYnCd}";
		faulty115Code.push(json);
	</c:forEach>

    var faulty116Code = new Array(); //치수 불량 Loss 
	<c:forEach items="${faulty116}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.useYnCd="${info.useYnCd}";
		faulty116Code.push(json);
	</c:forEach>
	//공통코드 처리 종료

	//조회
	$('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#faultyDateFromCal').val());
		let dateTo = new Date($('#faultyDateToCal').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#faultyDateFromCalendar').focus();
			return false;
		}
		
		faultyDateFrom	= $('#faultyDateFromCal').val();
		faultyDateTo	= $('#faultyDateToCal').val();
		
		if (tapTemp == 0) {
			$("#prcssFaulty").trigger("click");
		} else if (tapTemp == 1) {
			$("#matrlFaulty").trigger("click");
		} else if (tapTemp == 2) {
			$("#replaceFaulty").trigger("click");
		} else if (tapTemp == 3) {
			$("#troubleFaulty").trigger("click");
		} else if (tapTemp == 4) {
			$("#faultyQty").trigger("click");
		} else if (tapTemp == 5) {
			$("#allFaulQty").trigger("click");
		}
	});
	
	//권취잔량
	$('#faultyQty').on('click', function() {
		$('#faultyQtyView').removeClass('d-none');
		$('#allFaultView').addClass('d-none');
		$('#faultyQtyTable').DataTable().ajax.reload();

		$('#pageSerch1').addClass('d-none');
		$('#pageSerch6').removeClass('d-none');

		$('#btnFakeExcel').addClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 4;
	});
	
	//전체 조회
	$('#allFaulQty').on('click', function() {
		$('#faultyQtyView').addClass('d-none');
		$('#allFaultView').removeClass('d-none');
		$('#allFaultTable').DataTable().ajax.reload();

		$('#pageSerch1').removeClass('d-none');
		$('#pageSerch6').addClass('d-none');

		$('#btnFakeExcel').removeClass('d-none');
		
		$('#my-spinner').show();
		tapTemp = 5;
	});
	
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	allFaultFooterCreate();
	
	allFaultHderCreate1(); // - paymentHderCreate3();	//--필름(1)--//	
	allFaultHderCreate2(); // - paymentHderCreate();	//--Cutting 수량(2)--//
	allFaultHderCreate3(); // - paymentHderCreate2();	//--Metal 교체 Loss(3)--//
	allFaultHderCreate4(); // - paymentHderCreate4();	//--Teflon 교체 Loss(4)--//
	allFaultHderCreate5(); // - paymentHderCreate5();	//--Strip Loss(4)--//
	allFaultHderCreate6(); // - paymentHderCreate6();	//--공정 Trouble 조치 Loss(4)--//
	allFaultHderCreate7(); // - paymentHderCreate7();	//--치수 불량 Loss(4)--//
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	let sudeltotalSum = 0;
	
	$.fn.dataTable.ext.errMode = 'none';
	let allFaultTable = $('#allFaultTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: true,
        processing: true,
        //autoWidth: false,
        lengthChange: true,
        pageLength: 15,
        buttons: true,
        //scrollY : "56vh",
        autoWidth: false,
        scrollX : true,
        fixedColumns: {
			leftColumns: 5
       	},
        ajax: {
            url: '<c:url value="wm/allFaultList_F3"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
            	'faultyDateTo'		:	function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
		columns: [
			{
				render: function(data, type, row) {
					if(row['faultyRegDate'] == null || row['faultyRegDate'] == ''){
						return '';
					} else{
						return moment(row['faultyRegDate']).format('YYYY-MM-DD');
					}
					
				}, className : "text-center"
			},
			{ data: 'dayNightNm', className : "text-center"		},
			{ data: 'equipNm', className : "text-center" 		},
			
			{ data: 'goodsNm',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
	            	   return data;
					} else {
						return "-";
					}
	            }, className : "text-center"
			},
			{ data: 'alnicuMatrlNm',
				render : function(data, type, row, meta) {
					if(data != null && data != '') {
	            	   return data;
					} else {
						return "-";
					}
	            }, className : "text-center"
			},
			
			//--------------Cutting 수량--------------//
			<c:forEach var="i" begin="1" end="${code052NormalCount}">
				{
					render : function(data, type, row, meta) {
						if( processFaulty.filter( item => item['baseCd'] === row['baseCd'+(parseInt("${i}"))] )[0].useYnCd == "001" ){
							let chData = row['kg'+(parseInt("${i}"))];
							return chData;
						} else {
							return "<label class='destroyThis'></label>";
						}
		            },
		        },
			</c:forEach>
			//--------------Cutting 수량--------------//
			
			//--------------Metal 교체 Loss 수량--------------//
			<c:forEach var="i" begin="1" end="${code053NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_2'];
						return chData;
		            }   
		        },
		        {
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_2'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {  
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_2'];
						if(chData == null || chData == '') {
		            	   return '';
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
			</c:forEach>
			//--------------Metal 교체 Loss 수량--------------//
			
			//--------------Film 교체 Loss--------------//
			<c:forEach var="i" begin="1" end="${code054NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_3'];
						return chData;
		            }   
		        },
		        {
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_3'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {  
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_3'];
						if(chData == null || chData == '') {
		            	   return '';
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
			</c:forEach>
			//--------------Film 교체 Loss--------------//
			
			//--------------Teflon 교체 Loss--------------//
			<c:forEach var="i" begin="1" end="${code055NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_4'];
						return chData;
		            }   
		        },
		        {
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_4'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {  
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_4'];
						if(chData == null || chData == '') {
		            	   return '';
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
			</c:forEach>
			//--------------Teflon 교체 Loss--------------//
		        
			//--------------Strip Loss--------------//
	        <c:forEach var="i" begin="1" end="${code114NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_5'];
						return chData;
		            }   
		        },
		        {
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_5'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {  
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_5'];
						if(chData == null || chData == '') {
		            	   return '';
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
			</c:forEach>
			//--------------Strip Loss--------------//
		        
			//--------------공정 Trouble 조치 Loss--------------//
	        <c:forEach var="i" begin="1" end="${code115NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_6'];
						return chData;
		            }   
		        },
				{
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_6'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_6'];
						if(chData == null || chData == '') {
		            	   return 0;
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
		        {
					render : function(data, type, row, meta) {
						return row['content'+(parseInt("${i}"))+'_6'];
		            }, className : "text-center"
		        },
			</c:forEach>
			//--------------공정 Trouble 조치 Loss--------------//
		        
			//--------------치수 불량 Loss--------------//
	        <c:forEach var="i" begin="1" end="${code116NormalCount}">
				{  
					render : function(data, type, row, meta) {
						let chData = row['count'+(parseInt("${i}"))+'_7'];
						return chData;
		            }   
		        },
		        {
		            render : function(data, type, row, meta) {
		            	let chData = row['kg'+(parseInt("${i}"))+'_7'];
		            	
		            	if( chData == "" || chData == null ) {
		            		return 0;
		            	} else {
		            		if (chData % 1 == 0) {
								return chData;
							} else {
								return parseFloat( chData ).toFixed(3);
							}		            		
		            	}
		            }   
		        },
		        {  
					render : function(data, type, row, meta) {
						let chData = row['ea'+(parseInt("${i}"))+'_7'];
						if(chData == null || chData == '') {
		            	   return '';
						} else {
							return addCommas(parseFloat(chData).toFixed(0));
						}
		            }   
		        },
		        {
					render : function(data, type, row, meta) {
						return row['content'+(parseInt("${i}"))+'_7'];
		            }, className : "text-center"
		        },
			</c:forEach>
			//--------------치수 불량 Loss--------------//
			
			
		],
        columnDefs: [
        	{ targets: "_all", className: 'text-right' }
        ],
		order: [
			[ 0, 'asc' ],
		],
		buttons: [
            {
                extend: 'copy',
                title: replaceFaultyNm,
            },
            {
            	extend: 'excel',
                title: replaceFaultyNm,
                exportOptions: {
                 	columns: notHiddenArray	//원하는 값 지정
                },
                footer: true,
                //excelCss
			    customize: function ( xlsx ) {
			        var sheet = xlsx.xl.worksheets['sheet1.xml'];
			        
			        //Bold Header Row
			        $('row[r=3] c', sheet).attr( 's', '2' );
			        $('row[r=4] c', sheet).attr( 's', '2' );
			        $('row[r=5] c', sheet).attr( 's', '2' );
			        
			        //Make Cells Bold
			        $('c[r=A1]', sheet).attr( 's', '2' );
			        $('c[r=A3]', sheet).attr( 's', '2' );

			        //가운데
			        $('row[r=1] c', sheet).attr( 's', '51' );
			        $('row[r=3] c', sheet).attr( 's', '51' );

			        //배경 색
			        /*$('row[r=3] c', sheet).attr( 's', '30' );
			        $('row[r=4] c', sheet).attr( 's', '30' );
			        $('row[r=5] c', sheet).attr( 's', '30' );*/

			        $('row[r=2] c', sheet).remove();	//2번째 행 데이터 삭제

			      	//병합 하고자 하는 셀 지정 
			      	var mergeCells = $('mergeCells', sheet);

			      	//rowspan
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'A3:A5'} } )
					);
					mergeCells[0].appendChild( 
							createNode( sheet, 'mergeCell', { attr: {ref: 'B3:B5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'C3:C5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'D3:D5'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'E3:E5'} } )
					);
					//rowspan

					//colspan
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'G3:I3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'J3:L3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'M3:X3'} } )
					);
					
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'Y3:AA3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'AB3:BS3'} } )
					);
					mergeCells[0].appendChild( 
						createNode( sheet, 'mergeCell', { attr: {ref: 'BT3:BW3'} } )
					);
					//colspan
					
// 					mergeCells[0].appendChild(
// 						createNode( sheet, 'mergeCell', { attr: {ref: 'F4:H4'} } )
// 					);
					
					//병합 하고자 하는 셀 지정 끝

	                mergeCells.attr( 'count', mergeCells.attr( 'count' )+1 );

	                function createNode( doc, nodeName, opts ) {
						var tempNode = doc.createElement( nodeName );
	                    if ( opts ) {
							if ( opts.attr ) {
	                        	$(tempNode).attr( opts.attr );
	                      	}
	   
	                      	if ( opts.children ) {
	                        	$.each( opts.children, function ( key, value ) {
	                          		tempNode.appendChild( value );
	                        	} );
	                      	}
	   
	                      	if ( opts.text !== null && opts.text !== undefined ) {
	                        	tempNode.appendChild( doc.createTextNode( opts.text ) );
	                      	}
	                    }
	                    return tempNode;
					}
			    },
			  	//excelCssEnd

			    //헤더 추가하는 부분
			    customizeData: function(data){
				   
				    let gapCell = new Array();	//header만큼에 공백을 추가 해주는 부분
				    for(var i=0; i<data.header.length; i++){
				    	gapCell.push(' ');
		        	}

				 	//첫 번째 tr
				 	let arrayTr1 = colspanGroupArray('allFaultTable', 0, 'th', $('#allFaultTable thead tr').eq(0).find('th').length, 5, 'Y');
				 	//두 번째 tr
				 	let arrayTr2 = colspanGroupArray('allFaultTable', 1, 'th', $('#allFaultTable thead tr').eq(1).find('th').length, 5, 'N');
				 	//세 번째 tr
				   	let arrayTr3 = colspanGroupArray('allFaultTable', 2, 'th', $('#allFaultTable thead tr').eq(2).find('th').length, 5, 'empty');
					
					//첫 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow1 = alignToTableSize( data.header.length, arrayTr1  );
					//두 번째 행에 헤더 부분 header개수만큼 늘리기 끝
					let arrayRow2 = alignToTableSize( data.header.length, arrayTr2  );
					//세 번째 행에 헤더 부분 이미 header 개수만큼되어있음.
					   
				    //거꾸로 감, 제일 위에가 제일 밑으로 감
			        let desc = [
			        	arrayRow2	//두 번째 행
				        , arrayRow1	//첫 번째 행
					];

			        //data.body.unshift(data.header);	//헤더 맨 아래 부분
			        data.body.unshift(arrayTr3);		//헤더 맨 아래 부분 (세 번째 행)
			        for (var i = 0; i < desc.length; i++) {
			            data.body.unshift(desc[i]);
			        };
			    }
            },
            {
                extend: 'print',
                title: replaceFaultyNm,
            }
        ],
		drawCallback:function() {
			let api = this.api();
			let data = api.data();
			
			$('#allFaultTable tfoot').remove();
			$('#allFaultTable tbody tr td').attr("style","min-width:60px; white-space: pre-wrap;");
			$('.dataTables_scrollFoot tfoot tr td').removeClass('text-center')
			
			//컬럼 삭제
			$.each($("#allFaultTable tbody").find(".destroyThis"), function(index, item) {
			    $(item.parentNode).remove();
			})
			
			if(data[0] != null) {
				//Cutting 수량
				footerSum(data, 0, "052", processFaulty);
				//Metal 교체 Loss
				footerSum(data, 2, "053", matrlFaulty);
				//Film 교체 Loss
				footerSum(data, 3, "054", changeFaulty);
				//Teflon 교체 Loss
				footerSum(data, 4, "055", equipTroubleFaulty);
				//Strip Loss
				footerSum(data, 5, "114", faulty114Code);
				//공정 Trouble 조치 Loss
				footerSum(data, 6, "115", faulty115Code);
				//치수 불량 Loss
				footerSum(data, 7, "116", faulty116Code);
			}
		 	
		 	$('#my-spinner').hide();
		}
	});
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	allFaultTable.on('draw.dt', function(){
		allFaultTable.columns.adjust();
		$('#btnFakeExcel').attr('disabled', false);
	});
	
	let rowSudel = new Array();
	
	$('#allFaultTable_length').html('');
	$('#allFaultTable_paginate').addClass("float-left");

	$('#allFaultTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch1');
	$("#pageSerch1").insertAfter("#searchLabel");
	$('#allFaultTable_filter').eq(0).find('label').remove();
	
	$('#allFaultTable_wrapper').find('.buttons-excel').attr('id','btnRealExcel');
	$('#btnRealExcel').attr('style', 'display: none;');

    $('#allFaultTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#allFaultTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
	//가짜 엑셀 버튼 클릭 시
	$('#btnFakeExcel').on('click', function() {
// 		console.log("excelButton Click Check");
		allFaultTable.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = '';	//c 초기화
		$('#my-spinner').show();
		notHiddenArray = new Array();
		
		for( var i=0; i<$('#allFaultTable tbody tr').eq(0).find('td').length; i++){
    	    if(!$('#allFaultTable tbody tr').eq(0).find('td').eq(i).hasClass('d-none')){
    	        notHiddenArray.push(i);
    	    }
    	}

		//c, s 값 columns를  notHiddenArray에 있는 배열로 교체
		allFaultTable.buttons(1)[0].inst.c.buttons[1].exportOptions.columns = notHiddenArray;
// 		allFaultTable.buttons(1)[0].inst.s.buttons[1].conf.exportOptions.columns = notHiddenArray;

		$('#btnRealExcel').click();
		$('#my-spinner').hide();
	});
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ전체 값 합치는 코드끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
	
	
	
	
	//권취잔량
    $.fn.dataTable.ext.errMode = 'none';
	let faultyQtyTable = $('#faultyQtyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",  
    	language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        scrollY : "60vh",
        scrollCollapse: true,
        lengthChange: false,
        pageLength: -1,
        ajax: {
            url: '<c:url value="/wm/readFaultyQty"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'faultyDateTo'	:	function() { return faultyDateTo.replace(/-/g, ''); },
            	'faultyDateFrom'	:	function() { return faultyDateFrom.replace(/-/g, ''); },
            },
        },
        //rowId: 'workOrdNo',
        columns: [
        	{ data: 'ordDate',
				render: function(data, type, row) {
					if(data == null || data == ''){
						return '';
					} else{
						return moment(data).format('YYYY-MM-DD');
					}
					
				}
			},
			{ data: 'ordGubun',
	    		render: function(data, type, row, meta) {	
	    			if(data == "D") {
	    				return "주간";
	    			} else if(data == "N") {
						return "야간";
	    			} else {
	    				return "주야 통합";
		    		}
	    		}
	    	},
        	{ data: 'equipNm' },		//설비명
        	{ data: 'goodsNm' },		//제품명
        	{ data: 'qutyNm' },			//재질
        	{ data: 'mainFaultyQty' },
        	{ data: 'subFaultyQty' },
        	{ data: 'workTeamNm' },
        	{ data: 'userNm' },
        ],
        columnDefs: [
        	//{ targets: [5,6], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5,6], className: 'text-right' }, 
        ],
        buttons: [
            {
                extend: 'copy',
                title: '권취중량',
            },
            {
                extend: 'excel',
                title: '권취중량',
            },
            {
                extend: 'print',
                title: '권취중량',
            },
        ],
        drawCallback:function() {
        	$('#faultyQtyTable tfoot').remove();
			let mainFaultyQtySum	=	$('#faultyQtyTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let subFaultyQtySum		=	$('#faultyQtyTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			$('#mainFaultyQtySum').text(mainFaultyQtySum.toFixed(3));
			$('#subFaultyQtySum').text(subFaultyQtySum.toFixed(3));
		}
    });

    $('#faultyQtyTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#faultyQtyTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
	
    
    $('#faultyQtyTable_filter').eq(0).find('input[type=search]').attr('id', 'pageSerch6');
	$("#pageSerch6").insertAfter("#searchLabel");
	$('#faultyQtyTable_filter').eq(0).find('label').remove();
	
	$('#pageSerch2').addClass('d-none');
	$('#pageSerch3').addClass('d-none');
	$('#pageSerch4').addClass('d-none');
	$('#pageSerch5').addClass('d-none');
	$('#pageSerch6').addClass('d-none');
	
	faultyQtyTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		faultyQtyTable.columns.adjust();
	});
	
	//전체 값 합치는 코드 hder만드는 곳
	function allFaultHderCreate1() {

		let gubunRowspan = parseInt(processFaulty.filter(item => item['useYnCd'] === "001").length * 1);
		//let gubunRowspan = parseInt(processFaulty.length * 1);
		
		let gubunHd = '<th rowspan="3" style="min-width: 100px" class="text-center">일자</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 90px" class="text-center">주야</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 90px" class="text-center">설비명</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 170px" class="text-center">제품</th>';
			gubunHd +=  '<th rowspan="3" style="min-width: 40px" class="text-center">재질</th>';
			gubunHd += '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+processFaultyNm+'</th>';

		var paymentHd ='';		 
		
		$.each(processFaulty, function(index,item) {
			if(item.useYnCd == "001") {
				 paymentHd += ' <th colspan="1" style="min-width: 30px" class="text-center"><div class="'+index+'">'+item.baseCdNm+'</div></th>';
			}
		});
			
		var paymentHd2 ='';
		$.each(processFaulty, function(index,item) {
			if(item.useYnCd == "001") {
				paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';
				//paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+index+'">KG</div></th>';			 
				//paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+index+'">EA</div></th>';
			}
		});
		
		let sudel = '';
		
		/* for(var i=0; i<90 - (processFaulty.length * 3); i++){
    		sudel += '<th>★</th>';
		} */
		
		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
		
		/* $('#gubunHeader').append(sudel);
		$('#allFaultHeader').append(sudel);
		$('#allFaultHeader2').append(sudel); */
		
	}
	
	function allFaultHderCreate2() {

		let gubunRowspan = parseInt(matrlFaulty.length * 3);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+matrlFaultyNm+'</th>';
		var paymentHd ='';
		
		 $.each(matrlFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+parseInt(50 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});
		 
		var paymentHd2 ='';
		$.each(matrlFaulty, function(index,item) {
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(50 + index)+'">횟수</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(50 + index)+'">KG</div></th>';			 
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+parseInt(50 + index)+'">EA</div></th>';			 
		});
		
		$('#gubunHeader').append(gubunHd); 	
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2);
	}

	function allFaultHderCreate3() {
		
		let gubunRowspan = parseInt(changeFaulty.length * 3);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+replaceFaultyNm+'</th>';  
			
		var paymentHd ='';
		
		$.each(changeFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+parseInt(100 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});
		var paymentHd2 ='';
		$.each(changeFaulty, function(index,item) {
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(100 + index)+'">횟수</div></th>';
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(100 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; width: 60px" class="text-center"><div class="'+parseInt(100 + index)+'">EA</div></th>';			 
		});
		 
		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2);
	}
	
	function allFaultHderCreate4() {

		let gubunRowspan = parseInt(equipTroubleFaulty.length * 3);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+troubleFaultyNm+'</th>';
		
		var paymentHd =''; 
		
		 $.each(equipTroubleFaulty, function(index,item) {				
			 paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+parseInt(150 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});		
		 var paymentHd2 ='';
		 $.each(equipTroubleFaulty, function(index,item) {				
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">횟수</div></th>';
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(150 + index)+'">EA</div></th>';	
		});
		 
		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
	}

	function allFaultHderCreate5() {

		let gubunRowspan = parseInt(faulty114Code.length * 3);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+faultyNm114+'</th>';
		
		var paymentHd =''; 
		
		$.each(faulty114Code, function(index,item) {				
			paymentHd += ' <th colspan="3" style="min-width: 30px" class="text-center"><div class="'+parseInt(200 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});		
		var paymentHd2 ='';
		$.each(faulty114Code, function(index,item) {				
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(200 + index)+'">횟수</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(200 + index)+'">KG</div></th>';			 
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(200 + index)+'">EA</div></th>';	
		});
		
		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
	}
	
	function allFaultHderCreate6() {

		let gubunRowspan = parseInt(faulty115Code.length * 4);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+faultyNm115+'</th>';
		
		var paymentHd =''; 
		
		 $.each(faulty115Code, function(index,item) {				
			 paymentHd += ' <th colspan="4" style="min-width: 30px" class="text-center"><div class="'+parseInt(250 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});		
		 var paymentHd2 ='';
		 $.each(faulty115Code, function(index,item) {				
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(250 + index)+'">횟수</div></th>';
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(250 + index)+'">KG</div></th>';			 
			 paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(250 + index)+'">EA</div></th>';	
			 paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; min-width: 250px;" class="text-center"><div class="'+parseInt(250 + index)+'">내용</div></th>';			 
		});

		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
	}
	
	function allFaultHderCreate7() {

		let gubunRowspan = parseInt(faulty116Code.length * 4);
		let gubunHd = '<th colspan="'+gubunRowspan+'" style="min-width: 100px" class="text-center">'+faultyNm116+'</th>';
		
		var paymentHd =''; 
		
		$.each(faulty116Code, function(index,item) {				
			paymentHd += ' <th colspan="4" style="min-width: 30px" class="text-center"><div class="'+parseInt(300 + index)+'">'+item.baseCdNm+'</div></th>';			 
		});		
		var paymentHd2 ='';
		$.each(faulty116Code, function(index,item) {				
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(300 + index)+'">횟수</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(300 + index)+'">KG</div></th>';
			paymentHd2 += '  <th style="width: 60px" class="text-center"><div class="'+parseInt(300 + index)+'">EA</div></th>';
			paymentHd2 += '  <th style="border-right:solid #d6d8e1 1px; min-width: 250px;" class="text-center"><div class="'+parseInt(250 + index)+'">내용</div></th>';
		});

		$('#gubunHeader').append(gubunHd);
		$('#allFaultHeader').append(paymentHd); 
		$('#allFaultHeader2').append(paymentHd2); 
	}
	//전체 값 합치는 코드 hder만드는 끝
	
	function allFaultFooterCreate() {
		
		let footerHtml = '';
		
		//합계
		footerHtml += '<td colspan="5" style="text-align: center">합계</td>';
		
		let count = 1;
		
		//Cutting 수량
		$.each(processFaulty, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum052Kg'+count+'" style="text-align:right">0</td>';
			}
			count ++;
		});
		count = 1;
		
		//Metal 교체 Loss
		$.each(matrlFaulty, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum053Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum053Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum053Ea'+count+'" style="text-align:right">0</td>';
			}
			count ++;
		});
		count = 1;
		
		//Film 교체 Loss
		$.each(changeFaulty, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum054Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum054Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum054Ea'+count+'" style="text-align:right">0</td>';
			}
			count ++;
		});
		count = 1;
		
		//Teflon 교체 Loss
		$.each(equipTroubleFaulty, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum055Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum055Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum055Ea'+count+'" style="text-align:right">0</td>';
			}
			count ++;
		});
		count = 1;
		
		//Strip Loss
		$.each(faulty114Code, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum114Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum114Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum114Ea'+count+'" style="text-align:right">0</td>';
			}
			count ++;
		});
		count = 1;
		
		//공정 Trouble 조치 Loss
		$.each(faulty115Code, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum115Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum115Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum115Ea'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum115Content'+count+'" style="text-align:right"></td>';
			}
			count ++;
		});
		count = 1;
		
		//치수 불량 Loss
		$.each(faulty116Code, function(index, item) {
			if(item.useYnCd == "001") {
				footerHtml += '<td colspan="" id="allFaultSum116Count'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum116Kg'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum116Ea'+count+'" style="text-align:right">0</td>';
				footerHtml += '<td colspan="" id="allFaultSum116Content'+count+'" style="text-align:right"></td>';
			}
			count ++;
		});
		count = 1;
		
		$('#allFaultFooter').append(footerHtml);
	}
	
	//data : apiData, 순위, 공통코드 번호
	function footerSum(data, st, codeNum, faultyCode) {
		
		let count		= 1;
		let countSum	= 0;
		let kgSum		= 0;
		let eaSum		= 0;
		
		$.each(faultyCode, function(index, item) {
			if(item.useYnCd == "001") {
				
				//합계 구하기
				for(var k=0; k<data.length; k++) {
					
					let countNm; 
					let kgNm;
					let eaNm;
					
					if( 0 != st ) {
						countNm = 'count'+count+'_'+st;
						kgNm	= 'kg'+count+'_'+st;
						eaNm	= 'ea'+count+'_'+st;
					} else if( st == 0 ) {
						countNm = 'count'+count;
						kgNm	= 'kg'+count;
						eaNm	= 'ea'+count;
					}
					
					countSum	+= parseInt(data[k][countNm] == "" ? 0 : data[k][countNm] == null ? 0 : data[k][countNm]);
					kgSum		+= parseInt(data[k][kgNm] == "" ? 0 : data[k][kgNm] == null ? 0 : data[k][kgNm]);
					eaSum		+= parseInt(data[k][eaNm] == "" ? 0 : data[k][eaNm] == null ? 0 : data[k][eaNm]);
				}
				//합계 구하기
				
				//합계 넣기
				$('#allFaultSum'+codeNum+'Count'+count).text(addCommas(countSum));
				$('#allFaultSum'+codeNum+'Kg'+count).text(addCommas(kgSum));
				$('#allFaultSum'+codeNum+'Ea'+count).text(addCommas(Math.round(eaSum)));
				//합계 넣기
				
				countSum	= 0;
				kgSum		= 0;
				eaSum		= 0;
			}
			count ++;
		});
	}

    
	
	
	
	
	
	
	
	
	
	//colspan 배열에 담기
	function colspanGroupArray( tableName, row, tDivision, trSize, notExistColspanValue, ghostYn){
	 	//tableName: 테이블 명
	 	//row: 계산하고자 하는  행(0번 부터)
	 	//tDivision: th or td 선택자
	 	//trSize: 계산하고자하는 행 크기
	 	//notExistColspanValue: 계산하고자 하는 행에 calspan이 존재하지 않는 컬럼 개수(앞에서 값으로만 판단, 중간 값은 사용 못함)
	 	//ghostYn: rowspan으로 합쳐진 값이 존재하는지 여부( Y, N ) / 추가로 empty는 colspan, rowspan없이 쭉 이어진 값 

	 	let dt;
	 	let temporaryArray = new Array();
	 	let exceptionArray = new Array();	//empty에서만 사용
  		let temporaryObj = new Object();
    	let temporaryColspanSum = 0; 
	 	
	 	if( ghostYn == 'Y'){
	 		for(var i = 0; i < trSize; i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq(i);
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
	 		return temporaryArray;
		} else if( ghostYn == 'N' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
	 			dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
		   	    temporaryObj = new Object();
		   	    if( i < notExistColspanValue ){
		   	        temporaryObj.name = '';
		   	        temporaryObj.colspan = i;
		   	        colspanSum = i;
		   	    } else {
		   	        if( i == notExistColspanValue ) {
		   	            colspanSum += 1;
		   	        }
		   	        temporaryObj.name = dt.text();
		   	        temporaryObj.colspan = colspanSum;
		   	        colspanSum += parseInt(  dt.attr('colspan') );
		   	    }
		   	 temporaryArray.push(temporaryObj);
		   	}
			return temporaryArray;
		} else if( ghostYn == 'empty' ) {
			for(var i=0; i < ( trSize + notExistColspanValue ); i++) {
				dt = $('#'+tableName+' thead tr').eq( row ).find( tDivision ).eq( (i-notExistColspanValue)  );
				if( i < notExistColspanValue ){
					exceptionArray[i] = '';
			    } else {
			    	exceptionArray[i] = dt.text();
			    }
			}
			return exceptionArray;
		} else {
			toastr.error("시스템 오류가 발생했습니다. - excelGhostError-A001");
			return false;
		}
	}


	//가공하고자 하는 행에 헤더 부분 header개수만큼 늘리기 끝
	function alignToTableSize( allDatalength, receivedArray ){
		//colspan된 배열을 가지고, 만들고자하는 길이 만클 데이터를 가공하는 곳
		//allDatalength: 전체 데이터 길이(이 개수만큼 배열이 생성됨)
		//receivedArray: 가공하고자하는 배열 값
		
		let temporaryIsCheck = true;	// brek 역할
		let temporaryArrayRow = new Array();
		
		for(var i=0; i<allDatalength; i++){
			temporaryIsCheck = true;
			
		    for(var j=0; j<receivedArray.length; j++){
		        switch (i){
		        case receivedArray[j].colspan:
		        	temporaryArrayRow.push(receivedArray[j].name);
		        temporaryIsCheck = false;
		            break;
		        default:
		            break;
		        }
		        
		    }
		    if(temporaryIsCheck){
		    	temporaryArrayRow.push(' ');
		    }
		}
		return temporaryArrayRow;
	}

	// 컴럼 숨김 처리 함수
  	function columnVisibleFun(tableNm, codeLength, domTableId) {
		let frontTdNum = 0;	//전체 테이블 개수
		
		for( var i=0; i<$('#'+tableNm+' thead tr').eq(0).find('th').length; i++) {
	   		if( $('#'+tableNm+' thead tr').eq(0).find('th').eq(i).attr('rowspan') == 2) {
	   			frontTdNum++;
	   		}
		}
		
		frontTdNum += $('#'+tableNm+' thead tr').eq(1).find('th').length;

		let codeNum = $('#'+tableNm+' thead tr').eq(1).find('th').length - codeLength;

		codeNum = frontTdNum - codeNum;
		
		//★제거
		for( var i=0; i<frontTdNum; i++) {
		    if( i >= codeNum ) {
		    	domTableId.column( i ).visible( false );
		    }
		};
	}
	
	
</script>
</body>
</html>
