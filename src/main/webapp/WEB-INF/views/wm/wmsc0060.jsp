<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">LOT 추적</li>
			</ol>
		</nav>
	</header>
	<!-- #main=============================== -->
	<div class="container-fluid" id="main" style="padding-bottom:0px;">
		<!--======================== .left-list ========================-->
		<div class="col-md-12 matrl-top-list">
			<div class="card">
				<!--=========조회조건============-->
				<div class="card-body col-sm-12">
					<div class="row">
						<label class="input-label-sm">자재 BarcodeNo</label>
						<div class="form-group-100 mr-4">
							<input type="text" class="form-control mr-2" id="lotNo" style="min-width:120px;">
						</div>
						<label class="input-label-sm ml-2">작지번호</label>
						<div class="form-group-100 mr-4">
							<input type="text" class="form-control" id="workOrdNo" style="min-width:120px;">
						</div>
						<label class="input-label-sm ml-2">생산 LotNo</label>
                        <div class="form-group-100 mr-4">
                         	<input type="text" class="form-control" id="ordLotNo" style="min-width:120px;">
                        </div>
						<label class="input-label-sm ml-2">포장 번호</label>
						<div class="form-group-100 mr-4">
							<input type="text" class="form-control" id="boxNo" style="min-width:120px;">
						</div>
						<div class="form-group input-sub ml-2">
							<button type="button" class="btn btn-primary float-right mr-1" id="btnRetv">조회</button>
						</div>
					</div>
					<hr style="margin-bottom:0px;">
				</div>
				<!--==========자재입고내역테이블===========-->
				<!-- 
				<div class="mb-3 mt-3">
					<h6>자재입고내역</h6>
				</div>
				 -->
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="workOrdMatrlTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width:100px;">입고일자</th>
								<th style="min-width:100px;">자재명</th>
								<th style="min-width:100px;">자재 LotNo</th>
								<th style="min-width:50px;">입고량</th>
								<th style="min-width:100px;">입고처</th>
								<th style="min-width:100px;">작지번호</th>
								<th style="min-width:100px;">생산LotNo</th>
								<th style="min-width:50px;">주야</th>
								<th style="min-width:100px;">재작업여부</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!-- /.card -->
		</div>
		<!-- /.top-list -->
		<!--======================== .bottom - list ========================-->
		<div class="col-md-12 matrl-bottom-list" id="">
			<div class="mb-3 mt-3">
				<h6>생산진행내역(생산LotNo 기준)</h6>
			</div>
			<div class="card" id="formBox">
				<form id="form">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="workOrdMatrlDtlTable" class="table table-bordered table-td-center">
							<thead class="thead-light">
								<tr>
									<th style="min-width:80px;" class="text-center">일자</th>
									<th style="min-width:60px;" class="text-center">공정</th>
									<th style="min-width:60px;" class="text-center">설비명</th>
									<th style="min-width:30px;" class="text-center">작업조</th>
									<th style="min-width:60px;" class="text-center">작업자</th>
									<th style="min-width:80px;" class="text-center">거래처</th>
									<th style="min-width:80px;" class="text-center">제품명</th>
									<th style="min-width:120px;" class="text-center">규격</th>
									<th style="min-width:120px;" class="text-center">S-LOT</th>
									<th style="min-width:120px;" class="text-center">LOT NO</th>
									<th style="min-width:60px;" class="text-center">투입량</th>
									<th style="min-width:60px;" class="text-center">생산량</th>
									<th style="min-width:60px;" class="text-center">양품</th>
									<th style="min-width:60px;" class="text-center">불량</th>
									<th style="min-width:60px;" class="text-center">입고</th>
									<th style="min-width:60px;" class="text-center">출고</th>
									<th style="min-width:80px;" class="text-center">비고</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</form>
			</div>
			<div class="mt-2">
				<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
				<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
				</button>
			</div>
		</div>
		<!--=======end================= /.bottom - list ========================-->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'wmsc0060';
	let currentHref = 'wmsc0060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","LOT 추적");
                             
    let viewIdx;
    let sideView = 'add';
	var serverDate =  "${serverDate}"; 
	var boxNo = null;
	var workOrdNo = null;
    var ordLotNo = null;
    var lotNo = null;
    var lotNo = null;
    
	// 목록
	$.fn.dataTable.ext.errMode = 'none';
	let workOrdMatrlTable = $('#workOrdMatrlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
		searching:true,
		info: false,
		ordering: true,
		processing: true,
		autoWidth: false,
		pageLength: 6,
		ajax: {
			url: '<c:url value="/wm/workOrdMatrlList"/>',
			type: 'GET',
			data: {
				'menuAuth'	 		: 	menuAuth,
				'boxNo'				:	function() { return boxNo; },	 
				'workOrdNo'			:	function() { return workOrdNo; },
				'ordLotNo'			:	function() { return ordLotNo; },
				'lotNo'				:	function() { return lotNo; },                
			},
			/*
			success : function(res) {
			    console.log(res);
			}
			*/
		},
		rowId: '',
		columns: [
			{ data:'inWhsDate',
			 render: function(data, type, row) {	
				 if(data == "Invalid date" || data == null) {
					 return "";
				 }
					return moment(data).format("YYYY-MM-DD");
			     }
			},
			{ data: 'matrlNm' },
			{ data: 'lotNo' },
			{ data: 'inspectQty' },
			{ data: 'dealCorpNm' },
			{ data: 'workOrdNo' },
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if (row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if (row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else {
						html = data;
					}
					return html;
				}
			},
			{ data: 'gubunNm',
				render: function(data, type, row) {
					var html = '';
					if (row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">주간</p>';
					} else if (row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">야간</p>';
					} else {
						html = data;
					}
					return html;
				}
			},
			{ data: 'remakeYn',
			  	 render: function(data, type, row) {	
			   		 if(data == 'N'){
			   			 return '신규';
			   		 } else {
						return '재작업';
			         } 
			    }
			}
		],
		columnDefs: [
			{
			    //'targets': [0],
			    //'orderable': false,
			    //'searchable': false,
			},
		],
		order: [
			[ 5, 'asc' ],
			[ 6, 'asc' ],
			[ 7, 'asc' ],
		],
		buttons: [
			{
			    extend: 'copy',
			    title: 'LOT 추적',
			},
			{
			    extend: 'excel',
			    title: 'LOT 추적',
			},
			{
			    extend: 'print',
			    title: 'LOT 추적',
			}
		],
		drawCallback : function( settings ) {
			$('#workOrdMatrlTable_length').html("<h6>자재입고내역</h6>");	
		}
    });

	// 보기
    $('#workOrdMatrlTable tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
			//$(this).removeClass('selected');
		} else {
			$('#workOrdMatrlTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			workOrdNo = workOrdMatrlTable.row(this).data().workOrdNo;
			ordLotNo = workOrdMatrlTable.row(this).data().ordLotNo;
			lotNo = workOrdMatrlTable.row(this).data().lotNo;
			if (ordLotNo == null || ordLotNo == '') {
				$('#workOrdMatrlDtlTable').DataTable().clear().draw();
			} else {
				$('#workOrdMatrlDtlTable').DataTable().ajax.reload( function () {});
			}
		}
	});
    
    //목록
    let workOrdMatrlDtlTable = $('#workOrdMatrlDtlTable').DataTable({
        dom: "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/wm/workOrdMatrlDtlList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'workOrdNo'		:		function() { return workOrdNo; },
	           	'ordLotNo'		:		function() { return ordLotNo; },
	           	'lotNo'			:		function() { return lotNo; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: '',
        columns: [
            { data:'ordDate',
           	 render: function(data, type, row) {	
           		 if(data == "Invalid date" || data == null){
           			 return "";
           		 }
 					return moment(data).format("YYYY-MM-DD");
                 } 
            },             
            { data: 'prcssNm' },            
            { data: 'equipNm' },
            { data: 'workTeamNm' },
            { data: 'mainWorkChargrNm' },          
            { data: 'dealCorpNm' },
            { data: 'goodsNm' },
            { data: 'model' },
            { data: 'srLot' },
            { data: 'lotNo' },
			{ data: 'inspectQty',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
			{ data: 'outputCnt',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
			{ data: 'appearOutputCnt',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
			{ data: 'appearFaultyCnt',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
			{ data: 'inPackCnt',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
			{ data: 'outPackCnt',
				render: function(data, type, row) {
					if ((data % 1) == 0) {
						return addCommas(data);
					} else {
						return data;
					}
					
				}
			},
            { data: 'lotDesc' },                                  
        ],
        columnDefs: [
        	//{ targets: [11,12,13,14,15], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [10,11,12,13,14,15], className: 'text-right' }, 
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: 'Lot추적',
            },
            {
                extend: 'excel',
                title: 'Lot추적',
            },
            {
                extend: 'print',
                title: 'Lot추적',
            }
        ],    
    });

    // 보기
    $('#workOrdMatrlDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#workOrdMatrlDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });     
    
    var sysdate = "${serverTime}";
	
    $('#btnRetv').on('click', function() {
    	lotNo = $('#lotNo').val();
    	workOrdNo = $('#workOrdNo').val();
    	ordLotNo = $('#ordLotNo').val();
		boxNo = $('#boxNo').val();
		if ((lotNo == null || lotNo == '') && (workOrdNo == null || workOrdNo == '') && (ordLotNo == null || ordLotNo == '') && (boxNo == null || boxNo == '')) {
		    toastr.warning('자재 BarcodeNo, 작지번호, 생산 LotNo, 포장번호 중 한가지를 입력해주세요.');
		    $('#lotNo').focus();
		    return false;
		}
		
		if (lotNo != null && lotNo != '') {
		    $('#workOrdNo').val('');
		    $('#ordLotNo').val('');
		    $('#boxNo').val('');
		    workOrdNo = "";
		    ordLotNo = "";
		    boxNo = "";

		} else if (workOrdNo != null && workOrdNo != '') {
			$('#ordLotNo').val('');
			$('#boxNo').val('');
			lotNo="";
			boxNo = "";
			
		} else if (ordLotNo != null && ordLotNo != '') {
		    $('#boxNo').val('');
		    boxNo = "";
		}
		
		$('#workOrdMatrlTable').DataTable().ajax.reload(function () {});
		$('#workOrdMatrlDtlTable').DataTable().clear().draw();		
    });	


    $("#lotNo, #workOrdNo, #ordLotNo, #boxNo").keypress(function (e) {
    	if (e.which == 13){
    		$('#btnRetv').trigger('click');
    	}
    });
</script>

</body>
</html>
