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
            <li class="breadcrumb-item">
              <a href="#">재고관리</a>
            </li>
            <li class="breadcrumb-item active">품목별재고관리</li>
           </ol>
          </nav>
         </header>       
          <!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list" id="left-list" style="padding-bottom: 0px;">
					<!--
					<div class="card">
						
					</div>
					-->
				<div class="card-body col-sm-12" style="padding: 1px;">
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tabAlnicuMatrlTable">AL/Nicu</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tabFilmMatrlTable">Film</a>
							</li>
						</ul>
					</div>
				</div>
				<br/>
				<div id="alnicuMatrlTable" >                    
				 <!-- .table-responsive -->
                     <div class="table-responsive">
	                    <table id="alnicuMatrlInOutWhsTable" class="table table-bordered">
	                        <thead class="thead-light">
	                        <tr>
                              <th class="text-center"> 순번</th>
                              <th class="text-center"> 입고일 </th>                              
                              <th class="text-center"> 유수명 </th>
                              <th class="text-center"> 재질 </th>
                              <th class="text-center"> 규격 </th>
                              <th class="text-center"> 표면처리 </th>
                              <th class="text-center"> LOT</th>
                              <th class="text-center"> 입고량 </th>
                              <th class="text-center"> 출고량 </th>
                              <th class="text-center"> 재고량 </th>
                              <th> Location</th>
                            </tr>
	                        </thead>
	                        <tfoot>
								<tr>
									<td colspan="7" style="text-align: center">합계</td>																		
									<td id="sumMainMatrlInWhsQty" style="text-align: right">0</td>	
									<td id="sumMainMatrlInspectQty" style="text-align: right">0</td>	
									<td id="sumMainMatrlAdjustQty" style="text-align: right">0</td>	
									<td colspan=""></td>
								</tr>
							</tfoot>
                      </table>
                     </div>
                     <!-- /.table-responsive -->
                </div> 
				<div id="filmMatrlTable" class="d-none" >                 
				 	<!-- .table-responsive -->
                     <div class="table-responsive">
	                    <table id="filmMatrlInOutWhsTable" class="table table-bordered">
							<thead class="thead-light">
							<tr>
								<th class="text-center"> 순번</th>
								<th class="text-center"> 입고일 </th>
								<th class="text-center"> 유수명 </th>
								<th class="text-center"> 재질 </th>
								<th class="text-center"> 규격 </th>
								<th class="text-center"> 표면처리 </th>
								<th class="text-center"> sLOT</th>
								<th class="text-center"> LOT</th>
								<th class="text-center"> 입고량 </th>
								<th class="text-center"> 출고량 </th>
								<th class="text-center"> 재고량 </th>
								<th class="text-center"> Location</th>
							</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="8" style="text-align: center">합계</td>																		
									<td id="sumSubMatrlInWhsQty" style="text-align: right">0</td>	
									<td id="sumSubMatrlInspectQty" style="text-align: right">0</td>	
									<td id="sumSubMatrlAdjustQty" style="text-align: right">0</td>	
									<td colspan=""></td>
								</tr>
							</tfoot>
                      </table>
                     </div>
                     <!-- /.table-responsive -->
                 </div>                    

                  </div><!-- /.left-list -->
              </div><!-- /.row -->
            </div><!-- / #main  -->
        </div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'tmsc0030';
	let currentHref = 'tmsc0030';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","품목별재고관리");
    
	//공통코드 처리 시작
	var locationCode=new Array(); // location
    <c:forEach items="${locationCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		locationCode.push(json);
    </c:forEach>

    //공통코드 처리 종료  

	var inWhsDateCal =  "${serverDate}";
	var inWhsDateFromCal =  "${serverDateFrom}";
	var inWhsDateToCal =  "${serverDateTo}";
	
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
        pageLength: 19,
        ajax: {
            url: '<c:url value="/tm/inventoryByMatrlDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDateFrom'	:		function() { return inWhsDateFromCal.replace(/-/g, ''); },
	           	'inWhsDateTo'	:		function() { return inWhsDateToCal.replace(/-/g, ''); },
	           	'qutyCd'		:		'A',
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
					return meta.row + 1;
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
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
			   			return parseFloat(parseFloat(data).toFixed(2));
				   	} else {
					   	return data;
					}
		   		}
	    	},            
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
			   			return parseFloat(parseFloat(data).toFixed(2));
				   	} else {
					   	return "0";
					}
		   		}
	    	}, 
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
				   		return "0";
				   	} else {
					   	return parseFloat(parseFloat(data).toFixed(2));
					}
		   		}
	    	},
            { data: 'locationNm' },                       
        ],
        columnDefs: [
           	{ targets: [7,8,9], render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [7,8,9], className: 'text-right' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
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
			var sumMainMatrlInWhsQty = $('#alnicuMatrlInOutWhsTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var sumMainMatrlInspectQty = $('#alnicuMatrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumMainMatrlAdjustQty = $('#alnicuMatrlInOutWhsTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			$('#sumMainMatrlInWhsQty').text(addCommas(sumMainMatrlInWhsQty.toFixed(2)));
			$('#sumMainMatrlInspectQty').text(addCommas(sumMainMatrlInspectQty.toFixed(2)));
			$('#sumMainMatrlAdjustQty').text(addCommas(sumMainMatrlAdjustQty.toFixed(2)));
        }
    });

    var sysdate = "${serverTime}";
    
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDateFrom" name="alnicuInWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDateFrom,alnicuInWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="alnicuInWhsDateTo" name="alnicuInWhsDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(alnicuInWhsDateTo,alnicuInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="alnicuInWhsDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
    	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnAlnicuRetv">조회</button></div>';
    
	$('#alnicuMatrlInOutWhsTable_length').html(html1);
	$('#alnicuInWhsDateFrom').val(inWhsDateFromCal);
	$('#alnicuInWhsDateTo').val(inWhsDateToCal);

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
        pageLength: 19,
        ajax: {
            url: '<c:url value="/tm/inventoryByMatrlDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'inWhsDateFrom': function() { return inWhsDateFromCal.replace(/-/g, ''); },
	           	'inWhsDateTo': function() { return inWhsDateToCal.replace(/-/g, ''); },
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
					return meta.row + 1;
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
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
				   		return "0";
				   	} else {
				   		return parseFloat(parseFloat(data).toFixed(2));
					}
		   		}
	    	},            
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
			   			return parseFloat(parseFloat(data).toFixed(2));
				   	} else {
					   	return "0";
					}
		   		}
	    	}, 
	       	{
		       	data : 	'inspectQty',
		       	render: function(data, type, row, meta) {
			   		if(row['statusCd']=='O' || row['statusCd']=='P') {
				   		return "0";
				   	} else {
				   		return parseFloat(parseFloat(data).toFixed(2));
					}
		   		}
	    	}, 
            { data: 'locationNm' },                       
        ],
        columnDefs: [
        	{ targets: [8,9,10], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [8,9,10], className: 'text-right' },
        ],
        order: [
            [ 0, 'asc' ]
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
			var sumSubMatrlInWhsQty = $('#filmMatrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var sumSubMatrlInspectQty = $('#filmMatrlInOutWhsTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var sumSubMatrlAdjustQty = $('#filmMatrlInOutWhsTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			$('#sumSubMatrlInWhsQty').text(addCommas(sumSubMatrlInWhsQty.toFixed(2)));
			$('#sumSubMatrlInspectQty').text(addCommas(sumSubMatrlInspectQty.toFixed(2)));
			$('#sumSubMatrlAdjustQty').text(addCommas(sumSubMatrlAdjustQty.toFixed(2)));
        }
    });

	var html2 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDateFrom" name="filmInWhsDateFrom" />';
	html2 += '<button onclick="fnPopUpCalendar(filmInWhsDateFrom,filmInWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateFromCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>';
	html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="filmInWhsDateTo" name="filmInWhsDateTo" />';
	html2 += '<button onclick="fnPopUpCalendar(filmInWhsDateTo,filmInWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="filmInWhsDateToCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 	
	html2 += '</div>';
	html2 += '&nbsp; <button type="button" class="btn btn-primary" id="btnFilmRetv">조회</button></div>';

	$('#filmMatrlInOutWhsTable_length').html(html2);
	$('#filmInWhsDateFrom').val(inWhsDateFromCal);
	$('#filmInWhsDateTo').val(inWhsDateToCal);

    $('#tabAlnicuMatrlTable').on('click', function() {
    	$('#alnicuMatrlTable').removeClass('d-none');
    	$('#filmMatrlTable').addClass('d-none');
    	$('#alnicuInWhsDateFrom').val($('#filmInWhsDateFrom').val());
    	$('#alnicuInWhsDateTo').val($('#filmInWhsDateTo').val());
    	inWhsDateFromCal = $('#alnicuInWhsDateFrom').val();
    	inWhsDateToCal = $('#alnicuInWhsDateTo').val();
    	$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
    $('#tabFilmMatrlTable').on('click', function() {
    	$('#alnicuMatrlTable').addClass('d-none');
    	$('#filmMatrlTable').removeClass('d-none');
    	$('#filmInWhsDateFrom').val($('#alnicuInWhsDateFrom').val());
    	$('#filmInWhsDateTo').val($('#alnicuInWhsDateTo').val());
    	inWhsDateFromCal = $('#filmInWhsDateFrom').val();
    	inWhsDateToCal = $('#filmInWhsDateTo').val();
    	$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
    });
      
 	
    // 보기
    $('#alnicuMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#alnicuMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }

	});	
	    
    $('#filmMatrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#filmMatrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }

	});	
    	
    $('#btnAlnicuRetv').on('click', function() {
		let dateFrom = new Date($('#alnicuInWhsDateFrom').val());
		let dateTo = new Date($('#alnicuInWhsDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#alnicuInWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#alnicuInWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#alnicuInWhsDateFromCalendar').focus();
			return false;
		}
        
		inWhsDateFromCal =  $('#alnicuInWhsDateFrom').val();
		inWhsDateToCal =  $('#alnicuInWhsDateTo').val();
		$('#filmInWhsDateFrom').val($('#alnicuInWhsDateFrom').val());
		$('#filmInWhsDateTo').val($('#alnicuInWhsDateTo').val());
		$('#alnicuMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
     
    });	

    $('#btnFilmRetv').on('click', function() {
		let dateFrom = new Date($('#filmInWhsDateFrom').val());
		let dateTo = new Date($('#filmInWhsDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#filmInWhsDateFrom').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#filmInWhsDateFrom').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#filmInWhsDateFrom').focus();
			return false;
		}
		
		inWhsDateFromCal =  $('#filmInWhsDateFrom').val();
		inWhsDateToCal =  $('#filmInWhsDateTo').val();
		$('#alnicuInWhsDateFrom').val($('#filmInWhsDateFrom').val());
		$('#alnicuInWhsDateTo').val($('#filmInWhsDateTo').val());		
		$('#filmMatrlInOutWhsTable').DataTable().ajax.reload( function () {});
     
    });

	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});
   	
</script>

</body>
</html>
