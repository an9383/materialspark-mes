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
				<li class="breadcrumb-item"><a href="#">재고관리</a></li>
				<li class="breadcrumb-item active">재고실사및조정</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="padding-bottom: 0px;">
				<div class="card-body col-sm-12" style="padding: 1px; margin-bottom: 10px;">
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show"
								data-toggle="tab" id="tabAlnicuMatrlTable">AL/Nicu</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab"
								id="tabFilmMatrlTable">Film</a></li>
						</ul>
					</div>
				</div>
				<div id="alnicuMatrlTable">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="alnicuMatrlInOutWhsTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center">보류</th>
									<th class="text-center">입고일</th>
									<th class="text-center">유수명</th>
									<th class="text-center">재질</th>
									<th class="text-center">규격</th>
									<th class="text-center">표면처리</th>
									<th class="text-center">LOT</th>
									<th class="text-center">BarcodeNo</th>
									<th class="text-center">전산재고</th>
									<th class="text-center" width="100px">실사재고</th>
									<th class="text-center">조정중량</th>
									<th class="text-center">Location</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<div id="filmMatrlTable" class="d-none">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="filmMatrlInOutWhsTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center">보류</th>
									<th class="text-center">입고일</th>
									<th class="text-center">유수명</th>
									<th class="text-center">재질</th>
									<th class="text-center">규격</th>
									<th class="text-center">표면처리</th>
									<th class="text-center">sLOT</th>
									<th class="text-center">LOT</th>
									<th class="text-center">BarcodeNo</th>
									<th class="text-center">전산재고</th>
									<th class="text-center" width="100px">실사재고</th>
									<th class="text-center">조정중량</th>
									<th class="text-center">Location</th>
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
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<!-- 보류&반품&실반품&폐기 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="frrrdPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="frrrdPopUpLabel">보류 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<table id="frrrdPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="frrrdDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate" name="frrrdDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="frrrdDescLabel"></th>
							<td>
								<input type="text" id="frrrdDesc" name="frrrdDesc" style="max-width: 100%;" class="form-control" />
							</td>
						<tr>
						<th id="frrrdTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${matrlFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="frrrdType${item.baseCd}" style="zoom:1.8;"></div>	
								</div>
							</c:forEach>
							</td>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFaultySave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 보류&불량&반품&실반품&폐기 -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'tmsc0010';
	let currentHref = 'tmsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","재고실사및조정");
	
	var inWhsDateCal = "${serverDate}";
	var serverDate = "${serverDate}";
	var faultyMatrlType = '';

	var frrrdDate = '';
	var frrrdType = '';
	var frrrdDesc = '';
	
	//공통코드 처리 시작
	var locationCode=new Array(); // location
    <c:forEach items="${locationCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		locationCode.push(json);
    </c:forEach>
    
    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료  
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let alnicuMatrlInOutWhsTable = $('#alnicuMatrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        autoWidth: false,
        pageLength: 17,
        ajax: {
            url: '<c:url value="/tm/inventoryInspectAdjustList"/>',
            type: 'GET',
            data: {
	           	//'inWhsDate': $('#inWhsDate').val()
	           	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate': function() { return inWhsDateCal.replace(/-/g, ''); },
	           	'qutyCd': 'A',
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'lotNo',
        columns: [
	    	{ 
	    		render: function(data, type, row, meta) {			    			
					return '<input type="checkbox" name="alnicuChk">' ;
	    		}
			},
            { 
                data: 'inWhsDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { 
                data: 'lifeCycle',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },            
            { data: 'qutyNm' },
            { data: 'model' },
            { data: 'surfaceTrtmtNm' },
            { data: 'lotNo' },
            { data: 'barcodeNo' },
            { data: 'inWhsQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
	       	{
		       	data : 	'inspectQty',
		   		render: function(data, type, row) {
		       		return '<input type="number" maxlength="6" min="0" max="' + row['inWhsQty'] + '" type="number" step="0.1" class="form-control number-float1" id="inspectQty" name="inWhsQty" value="'+data+'">';
		   		}
	    	}, 
	    	{ data: 'adjustQty',
		   		render: function(data, type) {
			   		if (data != null){
			   			return parseFloat(data).toFixed(1);
				   	} else{
					   	return "-";
					}
		   		}
            },
            { data: 'locationNm' },                       
        ],
        columnDefs: [
           	{ targets: [8,9], render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [8,9], className: 'text-right' },
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '재고실사및조정(Al/Nicu)',
            },
            {
                extend: 'excel',
                title: '재고실사및조정(Al/Nicu)',
            },
            {
                extend: 'print',
                title: '재고실사및조정(Al/Nicu)',
            },
        ],
    });

	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label> &nbsp;<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDate" name="alnicuInWhsDate" />';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDate,alnicuInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
    	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnAlnicuRetv">조회</button>';
    	html1 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnAlnicuHold">보류</button></div>';
    
	$('#alnicuMatrlInOutWhsTable_length').html(html1);
	$('#alnicuInWhsDate').val(inWhsDateCal);

	$.fn.dataTable.ext.errMode = 'none';
	let filmMatrlInOutWhsTable = $('#filmMatrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        autoWidth: false,
        pageLength: 15,
        ajax: {
            url: '<c:url value="/tm/inventoryInspectAdjustList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDate': function() { return inWhsDateCal.replace(/-/g, ''); },
	           	'qutyCd': 'F',
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'lotNo',
        columns: [
	    	{ 
	    		render: function(data, type, row, meta) {			    			
					return '<input type="checkbox" name="filmChk">' ;
	    		}
			},
            { 
                data: 'inWhsDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { 
                data: 'lifeCycle',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },            
            { data: 'qutyNm' },
            { data: 'model' },
            { data: 'surfaceTrtmtNm' },
            { data: 'srLot' },            
            { data: 'lotNo' },
            { data: 'barcodeNo' },
            { data: 'inWhsQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
	       	{
		       	data : 	'inspectQty',
		   		render: function(data, type, row) {
		       		return '<input type="number" maxlength="6" min="0" max="' + row['inWhsQty'] + '" type="number" step="0.1" class="form-control number-float1" id="inspectQty" name="inspectQty" value="'+data+'">';
		   		}
	    	},
	    	{ data: 'adjustQty',
		   		render: function(data, type) {
			   		if (data != null){
			   			return parseFloat(data).toFixed(1);
				   	} else{
					   	return "-";
					}
		   		}
            },
            { data: 'locationNm' },                       
        ],
        columnDefs: [
			{ targets: [9,10], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [9,10], className: 'text-right' },
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '재고실사및조정(Film)',
            },
            {
                extend: 'excel',
                title: '재고실사및조정(Film)',
            },
            {
                extend: 'print',
                title: '재고실사및조정(Film)',
            },
        ],
    });

	var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDate" name="filmInWhsDate" />';
		html2 += '<button onclick="fnPopUpCalendar(filmInWhsDate,filmInWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateCalendar" type="button">';
		html2 += '<span class="oi oi-calendar"></span>';
		html2 += '</button>'; 
		html2 += '</div>';
		html2 += '&nbsp; <button type="button" class="btn btn-primary" id="btnFilmRetv">조회</button>';
		html2 += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnFilmHold">보류</button></div>';
	$('#filmMatrlInOutWhsTable_length').html(html2);
	$('#filmInWhsDate').val(inWhsDateCal);

    $('#tabAlnicuMatrlTable').on('click', function() {
    	$('#alnicuMatrlTable').removeClass('d-none');
    	$('#filmMatrlTable').addClass('d-none');
    	$('#alnicuInWhsDate').val($('#filmInWhsDate').val());
    	inWhsDateCal = $('#alnicuInWhsDate').val();
    	$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
    $('#tabFilmMatrlTable').on('click', function() {
    	$('#alnicuMatrlTable').addClass('d-none');
    	$('#filmMatrlTable').removeClass('d-none');
    	$('#filmInWhsDate').val($('#alnicuInWhsDate').val());
    	inWhsDateCal = $('#filmInWhsDate').val();
    	$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
      
    // 보기
    $('#alnicuMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#alnicuMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});	
	    
    $('#filmMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#filmMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});	

    $('#btnAlnicuRetv').on('click', function() {
		inWhsDateCal =  $('#alnicuInWhsDate').val();
		$('#filmInWhsDate').val($('#alnicuInWhsDate').val());
		$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });	

    $('#btnFilmRetv').on('click', function() {
		inWhsDateCal =  $('#filmInWhsDate').val();
		$('#alnicuInWhsDate').val($('#filmInWhsDate').val());		
		$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });

	$('#alnicuMatrlInOutWhsTable').on('keyup', 'input#inspectQty', function(e) {
		if(e.which == 13) {
			 var $row = $(this).closest( "tr" );
             var inspectQty = $row.find('#inspectQty').val().replace(/[^\.0-9]/g,""); 
             var inWhsQty = lotNo = $row.find('td').eq(8).html(); 
             if(inspectQty == null || inspectQty == "" || inspectQty == "0") {
            	 toastr.warning('실사재고량을 입력해 주세요.');
            	 $row.find('#inspectQty').focus();
            	 return false;
             }
             if(parseFloat(inspectQty) > parseFloat(inWhsQty)) {
            	 toastr.warning('실사재고량이 전산재고량을 초과할 수 없습니다.<br/> 실사재고량을 다시 입력해 주세요.');
            	 $row.find('#inspectQty').focus(); 
            	 return false;
             }
             var adjustQty = parseFloat(inWhsQty)-parseFloat(inspectQty); 
             var lotNo = $row.find('td').eq(6).html();
	    	 //alert("lotNo = "+lotNo + " ," +inWhsQty + " ," +inspectQty + " ," +adjustQty);
			
             $.ajax({
                 url: '<c:url value="/tm/updateInventoryInspectQty"/>',
                 type: 'POST',
                 data: {
                	 'menuAuth'	 	: 		menuAuth,
                 	'lotNo'   		:       lotNo,
                 	'inWhsQty'		: 		inWhsQty,
                 	'inspectQty'	: 		inspectQty,                
                 	'adjustQty'   	:       adjustQty.toFixed(1),
                 },
                 beforeSend: function() {
                 },
                 success: function (res) {
                     let data = res.data;
                     if (res.result == 'ok') {
                    	 $('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
                   	   	toastr.success('수정되었습니다.');
                     } else {
                    	 toastr.error(res.message, '', {timeOut: 5000});
                     }
                 },
                 complete:function(){
                 }
			});
		}
	});	

	$('#filmMatrlInOutWhsTable').on('keyup', 'input#inspectQty', function(e) {
		//alert("filmMatrlInOutWhsTable = "+e.which);
		if(e.which == 13) {
			 var $row = $(this).closest( "tr" );
             var inspectQty = $row.find('#inspectQty').val().replace(/[^\.0-9]/g,""); 
             var inWhsQty = lotNo = $row.find('td').eq(9).html(); 
             if(inspectQty == null || inspectQty == "") {
            	 toastr.warning('실사재고량을 입력해 주세요.');
            	 $row.find('#inspectQty').focus();
            	 return false;
             }
             if(parseFloat(inspectQty) > parseFloat(inWhsQty)) {
            	 toastr.warning('실사재고량이 전산재고량을 초과할 수 없습니다.<br/> 실사재고량을 다시 입력해 주세요.');
            	 $row.find('#inspectQty').focus(); 
            	 return false;
             }
             var adjustQty = parseFloat(inWhsQty)-parseFloat(inspectQty); 
             var lotNo = $row.find('td').eq(7).html();
	    	 //alert("lotNo = "+lotNo + " ," +inWhsQty + " ," +inspectQty + " ," +adjustQty);
			
             $.ajax({
                 url: '<c:url value="/tm/updateInventoryInspectQty"/>',
                 type: 'POST',
                 data: {
                	 'menuAuth'	 	: 		menuAuth,
                 	'lotNo'   		:       lotNo,
                 	'inWhsQty'		: 		inWhsQty,
                 	'inspectQty'	: 		inspectQty,                
                 	'adjustQty'   	:       adjustQty.toFixed(1),
                 },
                 beforeSend: function() {
                 },
                 success: function (res) {
                     let data = res.data;
                     if (res.result == 'ok') {
                    	 $('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
                   	   	toastr.success('수정되었습니다.');
                     } else {
                    	 toastr.error(res.message, '', {timeOut: 5000});
                     }
                 },
                 complete:function(){
                 }
             });
		}		
    });	

    $('#btnAlnicuHold').on('click', function() {
		if ($('input[name=alnicuChk]:checked').length == 0) {
			toastr.warning("보류 처리할 자재를 선택해주세요!");
			return false;
		}
		faultyMatrlType = 'alnicu';
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDate);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('보류 처리');
		$('#frrrdDateLabel').text('보류일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('보류유형');
		$('#frrrdPopUpModal').modal('show');
	});

    $('#btnFilmHold').on('click', function() {
		if ($('input[name=filmChk]:checked').length == 0) {
			toastr.warning("보류 처리할 자재를 선택해주세요!");
			return false;
		}
		faultyMatrlType = 'film';
		
		//선택해제
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#frrrdDate').val(serverDate);
		$('#frrrdDesc').val('');
		$('#frrrdPopUpLabel').text('보류 처리');
		$('#frrrdDateLabel').text('보류일');
		$('#frrrdDescLabel').text('비고');
		$('#frrrdTypeLabel').text('보류유형');
		$('#frrrdPopUpModal').modal('show');
	});

    $('#btnFaultySave').on('click', function() {
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';
		
		frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
		frrrdDesc = $('#frrrdDesc').val();
		for (let i=0; i<matrlFaultyType.length; i++) {
			if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
				frrrdType += '1';
			} else {
				frrrdType += '0';
			}
		}
		updateMtrlInOutWhsInspectQty("004");
    });
    
    //자재 불량&반품등록 상태로 update
	function updateMtrlInOutWhsInspectQty(approvalCd)
    {
		$('#my-spinner').show();
		var dataArray = new Array();

		var checkbox;
		if (faultyMatrlType == 'alnicu') {
			checkbox = $("input[name=alnicuChk]:checked");
		} else if (faultyMatrlType == 'film') {
			checkbox = $("input[name=filmChk]:checked");
		}
		
		var checkboxCnt = 0;
		var errorFlag = false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			var rowData = new Object();
			var barcode = td.eq(7).text();
			rowData.menuAuth = menuAuth;
			rowData.barcode = barcode;
			rowData.approvalCd = approvalCd;
			rowData.frrrdDate = frrrdDate;	//불량&보류&반품 처리일
			rowData.frrrdType = frrrdType;	//불량&보류&반품 유형
			rowData.frrrdDesc = frrrdDesc;	//불량&보류&반품 비고
			rowData.fautlyByProductionTeam	= 'N';		//생산팀 불량 구분자
			dataArray.push(rowData);
			checkboxCnt += 1;
		});

		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010"){	
			url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_iosc0080_F3"/>';
		} else{ //단순 인쇄시 006
			//url = '<c:url value="/qm/matrlPrint"/>';
			//temp = approvalCd;
		}
		if(!errorFlag && checkboxCnt > 0) {
			//console.log(dataArray);
	        $.ajax({
	            url: url,
	            type: 'POST',
	            dataType: 'json',
	            data : JSON.stringify(dataArray),
	            contentType : "application/json; charset=UTF-8",
	            //beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	            //},
	            success: function (res) {
	                //let data = res.data;
	                if (res.result == 'ok') {
	                	toastr.success("처리되었습니다.");
	            		if (faultyMatrlType == 'alnicu') {
	            			
	            		} else if (faultyMatrlType == 'film') {
	            			$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
	            		}
	            		//$("#checkAll").prop("checked", false);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		} else if (approvalCd == "010"){
			toastr.warning("인쇄할 바코드를 선택해주세요!");
			$('#my-spinner').hide();
		} else {
			toastr.warning("미승인 처리할 자재를 선택해 주세요!");
			$('#my-spinner').hide();
		}
    }
    
    $('#btnFilmHold').on('click', function() {
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");

		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {

			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			var lotNo = td.eq(6).text();
			var rowData = new Object();
			rowData.menuAuth = menuAuth;
			rowData.lotNo = lotNo;
			rowData.statusCd = "I";
			rowData.approvalCd = "004";
			dataArray.push(rowData);
		});
		
		if(dataArray.length > 0) {
			//alert(JSON.stringify(dataArray));
	        $.ajax({
	            url: '<c:url value="/tm/updateInventoryHoldStatus"/>',
	            type: 'POST',
	           	data : JSON.stringify(dataArray),
	            dataType:"json",
	            contentType : "application/json; charset=UTF-8",
	            beforeSend: function() {
	            },
	            success: function (res) {
	                let data = res.data;
	                if (res.result == 'ok') {
	                    // 보기
	                	toastr.success("보류처리 되었습니다.");
	            		$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            }
	        });
			
		} else {
			toastr.warning("보류처리 목록을 선택해 주세요!");
		}
    });

	//숫자만 입력, 길이, 소수점 한자리까지 제한
	$(document).on('keyup','.number-float1', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float1').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			$(this).val($(this).val().substring(0, $(this).attr("maxlength")));
			toastr.warning('최대 입력 글자를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최대 크기를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최소 크기를 초과하였습니다.');
		}
		if ($(this).val().split('.')[1].length > 1) {
			toastr.warning('소수점 한자리까지 입력 가능합니다.');
			$(this).val($(this).val().slice(0,-1));
		}
		if($(this).val().split('.').length >= 3) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');	//크롬 작동X, 익스플로러 작동O
			$(this).val($(this).val().slice(0,-1));
		}
	});

	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
	
</script>

</body>
</html>