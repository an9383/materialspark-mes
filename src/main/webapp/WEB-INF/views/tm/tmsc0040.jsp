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
				<li class="breadcrumb-item active">적정재고관리(자재)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 61%; padding-bottom: 0px;">
				<div class="card" style="margin-bottom:0px;">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<div class="card-body col-sm-12" style="padding: 1px; margin-bottom:10px;">
						<div class="card-header card-tab">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tabAlnicuMatrlTable">AL/Nicu</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tabFilmMatrlTable">Film</a></li>
							</ul>
						</div>
					</div>
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>					
					<div id="alnicuMatrlViewTable" >                    
					<!-- .table-responsive -->
						<div class="table-responsive">
							<table id="alnicuMatrlInOutWhsViewTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="25%">
									<col width="7%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th class="text-center">순번</th>
										<th class="text-center">자재명</th>
										<th class="text-center">자재코드</th>
										<th class="text-center">재질</th>
										<th class="text-center">구분(연/경)</th>
										<th class="text-center">면취(압연)</th>
										<th class="text-center">표면처리</th>
										<th class="text-center">재고량 </th>
										<th class="text-center">적정재고</th>
										<th class="text-center">차이 </th>                            
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="7" style="text-align: center">합계</td>
										<td id="sumMainMatrlAdm" style="text-align: right">0</td>
										<td colspan="2"></td>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- /.table-responsive -->
					</div>
					<div id="filmMatrlViewTable" class="d-none" >                 
				 	<!-- .table-responsive -->
						 <div class="table-responsive">
							<table id="filmMatrlInOutWhsViewTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="25%">
									<col width="7%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
									<col width="9%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th class="text-center">순번</th>
										<th class="text-center">자재명</th>
										<th class="text-center">자재코드</th>
										<th class="text-center">재질</th>
										<th class="text-center">구분(연/경)</th>
										<th class="text-center">면취(압연)</th>
										<th class="text-center">표면처리</th>
										<th class="text-center">재고량 </th>
										<th class="text-center">적정재고</th>
										<th class="text-center">차이 </th>                            
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="7" style="text-align: center">합계</td>																		
										<td id="sumSubMatrlAdm" style="text-align: right">0</td>	
										<td colspan="2"></td>
									</tr>
								</tfoot>
							 </table>
						 </div>
						 <!-- /.table-responsive -->
					 </div>
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav"
				style="width: 38%;">
				<div class="card mb-2" id="formBox">				
					<div class="rightsidebar-close" style="margin-top: 20px;">
						<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
					</div>
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2" id ="MatrlInOutWhsViewDtlTable" style="text-align:center;">
								<colgroup>
									<col width="15%">
									<col width="15%">
									<col width="15%">
									<col width="25%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th class="text-center">입고일</th>
										<th class="text-center">유수명</th>
										<th class="text-center">표면처리</th>
										<th class="text-center">LOT</th>
										<th class="text-center">재고량</th>
										<th class="text-center">Location NO</th>
									 </tr>
								 </thead>
								<tfoot>
									<tr>
										<td colspan="4" style="text-align: center">합계</td>																		
										<td id="sumDtl" style="text-align: right">0</td>	
										<td colspan=""></td>
									</tr>
								</tfoot>
							</table>
						</div>
					</form>
				</div>
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled>
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>처리중</button>
				</div>
			</div>
			<!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- 자재 이상 확인 모달 시작-->
<div class="modal fade" id="packCheckMatrlModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">재고 이상 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<c:forEach items="${nullList}" var="nullList">
      	<div class="row">
      		<h6>${nullList.matrlNm}&nbsp</h6>
      		<h6 style="color:red; font-weight:bold;">- 적정재고 입력 필요</h6>
      	</div>
		</c:forEach>
		<%-- 
		<c:forEach items="${zeroList}" var="zeroList">
			<div class="row">
      		<h6>${zeroList.matrlNm}&nbsp</h6>
      		<h6 style="color:red; font-weight:bold;">- 적정재고 입력 필요</h6>
      	</div>
		</c:forEach>
		 --%>
		<c:forEach items="${minusList}" var="minusList">
			<div class="row">
      		<h6>${minusList.matrlNm}&nbsp</h6>
      		<h6 style="color:blue; font-weight:bold;">- 적정재고 부족</h6>
      	</div>
		</c:forEach>
      </div>
      <div class="modal-footer">
      	<!-- <button type="button" class="btn btn-primary touch6" id="btnPackAddCheck" data-dismiss="modal" style="min-width:70px;"></button> -->
      	<button type="button" class="btn btn btn-secondary touch6" id="btnPackAddCheckCancel" data-dismiss="modal" style="min-width:70px;">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- 자재 이상 확인 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "61%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
		
		state = !state;
	});

    var diffQty = new Array();	//matrlCdList
    <c:forEach items="${matrlDiffQty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		diffQty.push(json);
    </c:forEach>
    
	let menuAuth = 'tmsc0040';
	let currentHref = 'tmsc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","적정재고관리(자재)");
	var inWhsDateCal =  "${serverDate}";
	var nullList =  "${nullList}";		//차이가 null - (적정재고 입력필요)
	var zeroList =  "${zeroList}";		//차이가 0 - (적정재고 입력필요)
	var minusList =  "${minusList}";	//차이가 - (재고부족)
	var plusList =  "${plusList}";		//차이가 + (정상)

	var alnicuDiffQtySelectBox = "";
	var filmDiffQtySelectBox = "";
	
	//적정재고 입력이 되어있지 않거나, 부족인 경우 모달 표시
	if (nullList.length > 2 || minusList.length > 2 ) {
		$('#packCheckMatrlModal').modal('show');
	}
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let alnicuMatrlInOutWhsViewTable = $('#alnicuMatrlInOutWhsViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 19,
        ajax: {
            url: '<c:url value="/tm/inventoryByPropDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
	           	'inWhsDate'		:	function() { return inWhsDateCal.replace(/-/g, ''); },
	           	'qutyCd'		:	'A',
	           	'diffQtyGubun'	:	function() { return alnicuDiffQtySelectBox; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
		//rowId: '',
		columns: [
	    	{	
	    		render: function(data, type, row, meta) {		
					return meta.row + 1;
    			}
	    	},
	    	{ data: 'matrlNm' },
	    	{ data: 'matrlCd' },
	    	{ data: 'qutyNm' },
			{ data: 'gubunNm'},
			{ data: 'chamferYnNm'},
			{ data: 'surfaceTrtmtNm'},
            { data: 'inspectQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
            { data: 'optimumStock',
		   		render: function(data, type) {
			   		if(data == null){
			   			return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">미입력</h6>';
			   		//} else if(data == 0){
				   	//		return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</h6>';
				   	} else{
				   		return parseFloat(data).toFixed(2);
					}
		   		}
            },
            { data: 'diffQty',
		   		render: function(data, type) {
			   		if(data == null){
			   			return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">-</h6>';
			   		} else if(data < 0){
				   			return '<h6 style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</h6>';
				   	} else{
				   		return parseFloat(data).toFixed(2);
					}
		   		}
            },
        ],
        columnDefs: [
           	{ targets: [7,8,9], render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [7,8,9], className: 'text-right' },
        ],
        //order: [
        //    [ 2, 'asc' ]
        //],
        buttons: [
            {
                extend: 'copy',
                title: '품목별재고관리(AL/Nicu)',
            },
            {
                extend: 'excel',
                title: '품목별재고관리(AL/Nicu)',
            },
            {
                extend: 'print',
                title: '품목별재고관리(AL/Nicu)',
            },
        ],
		drawCallback: function () {
			var sumMainMatrlAdm = $('#alnicuMatrlInOutWhsViewTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			$('#sumMainMatrlAdm').text(addCommas(sumMainMatrlAdm.toFixed(2)));
		}
    });

    var sysdate = "${serverTime}";
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDate" name="alnicuInWhsDate" />';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDate,alnicuInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
    	html1 += '&nbsp;&nbsp;<label class="input-label-sm" style="margin-right:5px;">적정 여부</label><select  class="custom-select" id="alnicuDiffQty" style="min-width:70px; margin-right: 5px;"></select>';
    	html1 += '<button type="button" class="btn btn-primary" id="btnAlnicuRetv">조회</button></div>';
        	
	$('#alnicuMatrlInOutWhsViewTable_length').html(html1);
	$('#alnicuInWhsDate').val(inWhsDateCal);
	selectBoxAppend(diffQty, "alnicuDiffQty", "", "1");
	

	$.fn.dataTable.ext.errMode = 'none';
	let filmMatrlInOutWhsViewTable = $('#filmMatrlInOutWhsViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: 19,
        ajax: {
            url: '<c:url value="/tm/inventoryByPropDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate'		:		function() { return inWhsDateCal.replace(/-/g, ''); },	           	
	           	'qutyCd'		:		'F',
	           	'diffQtyGubun'	:		function() { return filmDiffQtySelectBox; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        //rowId: 'lotNo',
        columns: [
	    	{	
	    		render: function(data, type, row, meta) {		
					return meta.row + 1;
    			}
	    	},
	    	{ data: 'matrlNm' },
	    	{ data: 'matrlCd' },
	    	{ data: 'qutyNm' },
			{ data: 'gubunNm'},
			{ data: 'chamferYnNm'},
			{ data: 'surfaceTrtmtNm'},
            { data: 'inspectQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
            { data: 'optimumStock',
		   		render: function(data, type) {
			   		if(data == null){
			   			return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">미입력</h6>';
			   		//} else if(data == 0){
				   	//		return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</h6>';
				   	} else{
				   		return parseFloat(data).toFixed(2);
					}
		   		}
            },
            { data: 'diffQty',
		   		render: function(data, type) {
			   		if(data == null){
			   			return '<h6 style="color:red; font-weight:bold; margin-bottom:0px;">-</h6>';
			   		} else if(data < 0){
				   			return '<h6 style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</h6>';
				   	} else{
				   		return parseFloat(data).toFixed(2);
					}
		   		}
            },
        ],
        columnDefs: [
           	{ targets: [7,8,9], render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [7,8,9], className: 'text-right' },
        ],
        order: [
            //[ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '품목별재고관리(Film)',
            },
            {
                extend: 'excel',
                title: '품목별재고관리(Film)',
            },
            {
                extend: 'print',
                title: '품목별재고관리(Film)',
            },
        ],
		drawCallback: function () {
			var sumSubMatrlAdm = $('#filmMatrlInOutWhsViewTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			$('#sumSubMatrlAdm').text(addCommas(sumSubMatrlAdm.toFixed(2)));
        }
    });

	var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDate" name="filmInWhsDate" />';
	html2 += '<button onclick="fnPopUpCalendar(filmInWhsDate,filmInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateFromCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>';
	html2 += '&nbsp;&nbsp;<label class="input-label-sm" style="margin-right:5px;">적정 여부</label><select  class="custom-select" id="filmDiffQty" style="min-width:70px; margin-right: 5px;"></select>';
	html2 += '<button type="button" class="btn btn-primary" id="btnFilmRetv">조회</button></div>';

	$('#filmMatrlInOutWhsViewTable_length').html(html2);
	$('#filmInWhsDate').val(inWhsDateCal);
	selectBoxAppend(diffQty, "filmDiffQty", "", "1");
	
	let clearTable = $('#MatrlInOutWhsViewDtlTable').DataTable({
		language: lang_kor,
        destroy:true,
        paging: false,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        pageLength: false,
	}); 		
	
    $('#tabAlnicuMatrlTable').on('click', function() {
    	$('#alnicuMatrlViewTable').removeClass('d-none');
    	$('#filmMatrlViewTable').addClass('d-none');
    	$('#alnicuInWhsDate').val($('#filmInWhsDate').val());    	
    	inWhsDateCal = $('#alnicuInWhsDate').val();
    
    	$('#alnicuMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});    	
    	clearTable.clear().draw();
    	
    });
    $('#tabFilmMatrlTable').on('click', function() {
    	$('#alnicuMatrlViewTable').addClass('d-none');
    	$('#filmMatrlViewTable').removeClass('d-none');
    	$('#filmInWhsDate').val($('#alnicuInWhsDate').val());
    
    	inWhsDateCal = $('#filmInWhsDate').val();
    	
    	$('#filmMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
    	clearTable.clear().draw();
    });
      
    // 보기
    $('#alnicuMatrlInOutWhsViewTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#alnicuMatrlInOutWhsViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        matrlCd = alnicuMatrlInOutWhsViewTable.row(this).data().matrlCd;
		//console.log("matrlCd = " + matrlCd);

		$.fn.dataTable.ext.errMode = 'none';
		let MatrlInOutWhsViewDtlTable = $('#MatrlInOutWhsViewDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
	        language: lang_kor,
	        destroy:true,	     
	        lengthChange: false,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        pageLength: 20,
	        ajax: {
	            url: '<c:url value="/tm/inventoryByPropDtlDataList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
		           	'inWhsDate': function() { return inWhsDateCal.replace(/-/g, ''); },	          
		           	'matrlCd': matrlCd
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        rowId: 'lotNo',
	        columns: [
	        	{ data: 'inWhsDate',
	        		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
	        	},
		    	{ data: 'lifeCycle',
		    		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
		    	},
		    	{ data: 'surfaceTrtmtNm' },
		    	{ data: 'lotNo'},
	            { data: 'inspectQty',
			   		render: function(data, type) {
			   			return parseFloat(data).toFixed(2);
			   		}
	            },
		    	{ data: 'locationNm'}
	        ],
	        columnDefs: [
            	{ targets: [4], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [4], className: 'text-right' },
	        ],
	        order: [
	            [ 0, 'asc' ]
	        ],
	        buttons: [
				{
					extend: 'copy',
					title: '품목별재고관리'
				},
				{
					extend: 'excel',
					title: '품목별재고관리'
				},
				{
					extend: 'print',
					title: '품목별재고관리'
				},
	        ],
	        drawCallback: function( settings ) {
				var sumDtl = $('#MatrlInOutWhsViewDtlTable').DataTable().column(4, { page: 'all'} ).data().sum();
				$('#sumDtl').text(addCommas(sumDtl.toFixed(2)));
		    }
	    });

	});	
	    
    $('#filmMatrlInOutWhsViewTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#filmMatrlInOutWhsViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        
        matrlCd = filmMatrlInOutWhsViewTable.row(this).data().matrlCd;
		console.log("matrlCd = " + matrlCd);

		$.fn.dataTable.ext.errMode = 'none';
		let MatrlInOutWhsViewDtlTable = $('#MatrlInOutWhsViewDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
	        language: lang_kor,
	        destroy:true,
	        paging: true,
	        lengthChange: false,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        pageLength: 20,
	        ajax: {
	            url: '<c:url value="/tm/inventoryByPropDtlDataList"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'	 	: 	menuAuth,
		           	'inWhsDate'		:	function() { return inWhsDateCal.replace(/-/g, ''); },	          
		           	'matrlCd'		:	matrlCd,
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        rowId: 'lotNo',
	        columns: [
	        	{ data: 'inWhsDate',
	        		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
	        	},
	        	{ data: 'lifeCycle',
		    		render: function(data, type, row, meta) {		
						return moment(data).format('YYYY-MM-DD') ;
	    			}
		    	},
		    	{ data: 'surfaceTrtmtNm' },
		    	{ data: 'lotNo'}, 
	            { data: 'inspectQty',
			   		render: function(data, type) {
			   			return parseFloat(data).toFixed(2);
			   		}
	            },
		    	{ data: 'locationNm'} 
	            
	        ],
	        columnDefs: [
	           	{ targets: [4], render: $.fn.dataTable.render.number( ',' ) },
	           	{ targets: [4], className: 'text-right' },
	        ],
	        order: [
	            [ 0, 'asc' ]
	        ],
	        buttons: [
	            {
	                extend: 'copy',
	                title: '품목별재고관리'
	            },
	            {
	                extend: 'excel',
	                title: '품목별재고관리'
	            },
	            {
	                extend: 'print',
	                title: '품목별재고관리'
	            },
	        ],
	        drawCallback: function( settings ) {
				var sumDtl = $('#MatrlInOutWhsViewDtlTable').DataTable().column(4, { page: 'all'} ).data().sum();
				$('#sumDtl').text(addCommas(sumDtl.toFixed(2)));
		    }
	    });

	});	
	
    $('#btnAlnicuRetv').on('click', function() {
		inWhsDateCal =  $('#alnicuInWhsDate').val();		
		$('#filmInWhsDate').val($('#alnicuInWhsDate').val());	
		clearTable.clear().draw();
		$('#alnicuMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
    });	
	
    $('#btnFilmRetv').on('click', function() {
		inWhsDateCal =  $('#filmInWhsDate').val();		
		$('#alnicuInWhsDate').val($('#filmInWhsDate').val());
		clearTable.clear().draw();		
		filmMatrlInOutWhsViewTable.ajax.reload( function () {});
    });

    $('#MatrlInOutWhsViewDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#MatrlInOutWhsViewDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
        
	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});

	
	$('#alnicuDiffQty').on('change', function() {
		alnicuDiffQtySelectBox = $("#alnicuDiffQty option:selected").val();
		$('#alnicuMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
    });


	$('#filmDiffQty').on('change', function() {
		filmDiffQtySelectBox = $("#filmDiffQty option:selected").val();
		$('#filmMatrlInOutWhsViewTable').DataTable().ajax.reload( function () {});
    });
    
	
</script>

</body>
</html>
