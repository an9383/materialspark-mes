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
				<li class="breadcrumb-item active">제품(일재고현황)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 61%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>					
					<div id="alnicuMatrlViewTable" >                    
						<!-- .table-responsive -->
						<div class="table-responsive">
							<table id="goodsInventoryTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<!-- <th>순번</th> -->
										
										<!-- <th>구분</th> -->
										<th>거래처</th>
										<th>제품(기종)</th>
										<th>재질</th>
										<th>규격</th>
										<th>이일량</th>
										<th>입고량</th>
										<th>출고량</th>
										<th>재고량</th>
										<!-- <th>제품별 합계</th> -->
									</tr>                          
								</thead>
								<tfoot>
									<tr>
										<td colspan="4">합계</td>
										<td colspan="" id="sumPreInWhsQty" style="text-align: right">0</td>
										<td colspan="" id="sumInWhsQty" style="text-align: right">0</td>
										<td colspan="" id="sumOutQty" style="text-align: right">0</td>
										<td colspan="" id="sumDiffQty" style="text-align: right">0</td>
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
					
					<!--/오른쪽 등록 부분 상단 버튼 영역-->
					<form id="form">
						<div class="table-responsive">
							<table class="table table-sm table-bordered mb-2" id ="goodsInventoryDtlTable" style="text-align:center;">
								<colgroup>
									<col width="10%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
									<col width="18%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th>순번</th>
										<th>포장번호</th>  
										<th>표면처리</th>
										<th>재고량</th>
										<th>입고일</th>
										<th>창고위치</th>                            
									</tr>
								</thead>
								<tfoot>
									<tr>
										<td colspan="3">합계</td>
										<td colspan="" id="sumGoodsDtl" style="text-align: right">0</td>
										<td colspan="2"></td>
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
<!-- Excel다운 확인모달 시작-->
<div class="modal fade" id="excelDownPopupModal" tabindex="-1" role="dialog" aria-labelledby="excelDownPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="excelDownPopupModalLabel">Excel 다운 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">      	
      	<h6 id="excelDownLabel"></h6> 
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-success mr-2" id="btnDailyGoodsProductDownCheck">Excel 다운</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- Excel다운 확인모달 끝 -->

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
	
	let menuAuth = 'tmsc0080';
	let currentHref = 'tmsc0080';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품(일재고현황)");
	var inWhsDateCal =  "${serverDate}";	
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let goodsInventoryTable = $('#goodsInventoryTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        pageLength: 20,
        ajax: {
            url: '<c:url value="/tm/tmByGoodsInventoryListChecked"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'packDate': function() { return inWhsDateCal.replace(/-/g, '').substring(0,8); },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'goodsCd',
        columns: [
	    /* 	{	
	    		render: function(data, type, row, meta) {
					return meta.row + 1;
    			}
	    	}, */
	    	
	    	//{ data: 'statusNm' },
	    	{ data: 'dealCorpNm' },
	    	{ data: 'goodsNm' },
	    	{ data: 'qutyNm' },
	    	{ data: 'model' },
	    	{ data: 'preInWhsQty'}, 
	    	{ data: 'inWhsQty'},   
	    	{ data: 'outQty'}, 	    	   
	    	{ data: 'diffQty'},
	    	//{ data: 'goodsRemainSum'},
        ],
        //rowsGroup: [ [1], [10] ],
        columnDefs: [
        	{ targets: [4,5,6,7], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5,6,7], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '재고현황관리(총집계)',
            },
            {
                extend: 'excel',
                title: '재고현황관리(총집계)',
            },
            {
                extend: 'print',
                title: '재고현황관리(총집계)',
            },
        ],
		drawCallback: function () {
			let sumPreInWhsQty	=	$('#goodsInventoryTable').DataTable().column(4, {page:'all'}).data().sum();
			let sumInWhsQty		=	$('#goodsInventoryTable').DataTable().column(5, {page:'all'}).data().sum();
			let sumOutQty		=	$('#goodsInventoryTable').DataTable().column(6, {page:'all'}).data().sum();
			let sumDiffQty		=	$('#goodsInventoryTable').DataTable().column(7, {page:'all'}).data().sum();
			$('#sumPreInWhsQty').html(addCommas(sumPreInWhsQty));
			$('#sumInWhsQty').html(addCommas(sumInWhsQty));
			$('#sumOutQty').html(addCommas(sumOutQty));
			$('#sumDiffQty').html(addCommas(sumDiffQty));
        },
    });

    var sysdate = "${serverTime}";
	var html1 = '<div class="row">&nbsp;<label class="input-label-sm">입고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="inWhsDate" name="inWhsDate" />';
		html1 += '<button onclick="fnPopUpCalendar(inWhsDate,inWhsDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="inWhsDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';	
    	html1 += '&nbsp; <button type="button" class="btn btn-primary mr-5" id="btnRetv">조회</button>';
    	html1 += '<button type="button" class="btn btn-success mr-2" id="btnDailyGoodsProductDown">Excel 다운</button>';
    	html1 += '<div>';
    
	$('#goodsInventoryTable_length').html(html1);
	$('#inWhsDate').val(inWhsDateCal);
	
    var goodsCd = 'emtpy';
    var ordGubun;
    
	$('#goodsInventoryTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
           // $(this).removeClass('selected');
        } else {
        	$('#goodsInventoryTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            goodsCd = goodsInventoryTable.row(this).data().goodsCd;
    		ordGubun = goodsInventoryTable.row(this).data().statusCd;
    		$('#goodsInventoryDtlTable').DataTable().ajax.reload( function () {});
        }
	});

    $.fn.dataTable.ext.errMode = 'none';
	let goodsInventoryDtlTable = $('#goodsInventoryDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/tm/tmByGoodsInventoryDtlListChecked"/>',
            type: 'GET',
            data: {
            	'menuAuth'	:	menuAuth,
	           	'packDate'	:	function() { return inWhsDateCal.replace(/-/g, ''); },	          
	           	'goodsCd'	:	function() { return goodsCd; },
	           	'statusCd'	:	function() { return ordGubun; },
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
	    	{ data: 'boxNo'},
	    	{ data: 'surfaceTrtmtNm' },
	    	{ data: 'remainCnt' },
	    	{ data:'goodsInDate',
	           	 render: function(data, type, row) {	
	 				return moment(data).format("YYYY-MM-DD");
	           	 }
			},
	    	{ data: 'locationNm'}  
        ],
        columnDefs: [
        	{ targets: [3], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '재고현황관리(세부)',
            },
            {
                extend: 'excel',
                title: '재고현황관리(세부)',
            },
            {
                extend: 'print',
                title: '재고현황관리(세부)',
            },
        ],
		drawCallback: function () {
			let sumGoodsDtl	=	$('#goodsInventoryDtlTable').DataTable().column(3, {page:'all'}).data().sum();
			$('#sumGoodsDtl').html(addCommas(sumGoodsDtl));
        },
    });
	
	$('#goodsInventoryDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#goodsInventoryDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	});
	
	$('#btnRetv').on('click', function() {
		inWhsDateCal =  $('#inWhsDate').val();
		$('#goodsInventoryTable').DataTable().ajax.reload();
		$('#goodsInventoryDtlTable').DataTable().clear().draw();
    });

	$('#btnDailyGoodsProductDown').on('click', function() {
		$('#excelDownLabel').text($('#inWhsDate').val() + ' 기준으로 모든 제품재고를 다운합니다.');
		$('#excelDownPopupModal').modal('show');
	});
	
	$('#btnDailyGoodsProductDownCheck').on('click', function() {
  	  	
		$('#my-spinner').show();
		
		$.ajax({
			url: '<c:url value="tm/dailyGoodsProductionExcel"/>',
			type: 'GET',
			datatype: 'json',
			data:  {
				'menuAuth'	 	: 	menuAuth,
				'packDate'		:	function() { return inWhsDateCal.replace(/-/g, ''); },	      
			},
			beforeSend: function() {
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},            
			success: function (res) {
				let data = res.data
				//console.log(data);
			    if (res.result == 'ok') {
			        location.href = '/tm/dailyGoodsProductionExcelDownload?id=dailyProduct_' + data.packDate;
			    } else if (res.result == 'fail') {
			    	toastr.warning(res.message);
			    } else if (res.result == 'error') {
					toastr.error("오류가 발생하였습니다. - dailyExcel/download-001");
				}
			},
			complete:function(){
				$('#excelDownPopupModal').modal('hide');
				$('#my-spinner').hide();
			}
        });
	});

</script>

</body>
</html>
