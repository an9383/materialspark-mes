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
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재 입출고내역</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card-body col-sm-12 border-bottom pb-3">
					<div class="row">
						<label class="input-label-sm">자재 Barcode No</label>
						<div class="form-group-100 mr-4">
							<input type="text" class="form-control" id="matrlBarcodeNo" style="min-width:130px;">
						</div>
						<div class="form-group input-sub">
							<button type="button" class="btn btn-primary float-right ml-3" id="btnRetv">조회</button>
						</div>
					</div>
				</div>
				<br>
				<!-- 
				<div class="mb-3 mt-3">
					<h6>자재 입출고 내역</h6>
				</div>
				 -->
				<div class="table-responsive">
					<table id="matrlInOutWhsAdmHistTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width:130px" class="text-center">내역 일자</th>
								<th style="min-width:70px" class="text-center">가입고일</th>
								<th style="min-width:50px" class="text-center">비고</th>
								<th style="min-width:50px" class="text-center">승인상태</th>
								<th style="min-width:50px" class="text-center">자재상태</th>
								<th style="min-width:50px" class="text-center">자재코드</th>
								<th style="min-width:150px" class="text-center">자재명</th>
								<th style="min-width:110px" class="text-center">Barcode</th>
								<th style="min-width:50px" class="text-center">입고량</th>
								<th style="min-width:50px" class="text-center">실사량</th>
								<th style="min-width:50px" class="text-center">조정량</th>
								<th style="min-width:50px" class="text-center">차이</th>
								<th style="min-width:60px" class="text-center">창고 위치</th>
								<th style="min-width:50px" class="text-center">선입선출</th>
								<th style="min-width:70px" class="text-center">입고일</th>
								<th style="min-width:70px" class="text-center">수입검사일</th>
								<th style="min-width:70px" class="text-center">가출고일</th>
								<!-- <th style="min-width:80px" class="text-center">가출고 설비명</th> -->
								<!-- <th style="min-width:80px" class="text-center">가출고 제품명</th> -->
								<th style="min-width:70px" class="text-center">투입일</th>
								<th style="min-width:80px" class="text-center">투입 설비명</th>
								<th style="min-width:80px" class="text-center">투입 제품명</th>
								<th style="min-width:70px" class="text-center">불량일</th>
								<th style="min-width:120px" class="text-center">불량유형</th>
								<th style="min-width:60px" class="text-center">불량비고</th>
								<th style="min-width:100px" class="text-center">투입작지</th>
								<th style="min-width:50px" class="text-center">투입중량</th>
								<th style="min-width:50px" class="text-center">불량중량</th>
								<th style="min-width:50px" class="text-center">재투입</th>
								<th style="min-width:70px" class="text-center">교체위치</th>
								<th style="min-width:50px" class="text-center">연결 여부</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0110';
	let currentHref = 'iosc0110';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 입출고내역");

	//공통코드 처리 시작
    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
	var matrlBarcodeNo = 'empty';
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsAdmHistTable = $('#matrlInOutWhsAdmHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-9'l><'col-sm-12 col-md-3'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",         
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        searching: false,
        pageLength: false,
        ajax: {
            url: '<c:url value="/io/matrlInOutHistList"/>',
            type: 'GET',
            data: {
            	'menuAuth'		: 		menuAuth,
	           	'barcodeNo'		:		function() { return matrlBarcodeNo; },
            },
        },
        //rowId: 'lotNo',
        columns: [
			{
			    data: 'regDate',
			    render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD HH:mm:ss");
					} else {
						return "-";
					}
			    }
			},
			{
			    data: 'preInWhsDate',
			    render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{ data: 'inWhsDesc' },
			{ data: 'approvalNm' },
			{ data: 'statusNm' },
			{ data: 'matrlCd' },
			{ data: 'matrlNm' },
			{ data: 'barcodeNo' },
			{ data: 'inWhsQty',
				 render: function(data, type, row) {
					if (data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return '';
					}
				}
			},
			{ data: 'inspectQty',
				 render: function(data, type, row) {
					if (data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return '';
					}
				}
			},
			{ data: 'adjustQty',
				 render: function(data, type, row) {
					if (data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return '';
					}
				}
			},
			{ data: 'diffQty',
				 render: function(data, type, row) {
					if (data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return '';
					}
				}
			},
			{ data: 'locationNm' },
			{
				data: 'fifoCheck',
				render: function(data, type, row) {
					if (data == "Y") {
						let html = "적용"
						return html;
					} else if (data == "N") {
						let html = "미적용"
						return html;
					}
			    }
			},
			{ 
			    data: 'inWhsDate',
			    render: function(data, type, row) {
					if (data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{
			    data: 'inspctDate',
			    render: function(data, type, row) {
			    	if (data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{
			    data: 'preOutWhsDate',
			    render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			//{ data: 'preOutEquipNm' },
			//{ data: 'preOutGoodsNm' },
			{
			    data: 'outWhsDate',
			    render: function(data, type, row) {
			    	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{ data: 'outEquipNm' },
			{ data: 'outGoodsNm' },
			{
			    data: 'frrrdDate',
			    render: function(data, type, row) {
			    	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "";
					}
			    }
			},
            {
				data: 'frrrdType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += matrlFaultyType[jj].baseCdNm + ', ';
								count++;
							}
						}
						if (count == 0) {
							faultyTypeNm = '-';
						} else {
							faultyTypeNm = faultyTypeNm.substring(0, faultyTypeNm.length-2);
						}
					} else {
						faultyTypeNm = '';
					}
					return faultyTypeNm;
				}
            },
			{ data: 'frrrdDesc' },
			{ data: 'workOrdNo' },
			{ data: 'fairQty',
				render: function(data, type, row) {
					if(data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return "";
					}
				}   
			},
			{ data: 'faultyQty',
				render: function(data, type, row) {
					if(data != "" && data != null) {
						return parseFloat(data).toFixed(2);
					} else {
						return "";
					}
				}
			},
			{ data: 'remakeYn',
	    		render: function(data, type, row) {	
	    			if(data != null) {
		    			let remakeNm = '';
		    			if(data == 'Y') {
		    				remakeNm = "재투입";
			    		} else if (data == 'N'){
			    			remakeNm = "신규투입";
				    	}
	    				return remakeNm;
	    			}
	    		}				
			},
			{ data: 'changeLocation' },
			{ data: 'connectNm' },
        ],
        columnDefs: [
           	{ targets: [8,9,10,11,24,25] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [8,9,10,11,24,25], className: 'text-right' },
        ],
        order: [
            [ 0, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '자재 입출고 내역',
            },
            {
                extend: 'excel',
                title: '자재 입출고 내역',
            },
            {
                extend: 'print',
                title: '자재 입출고 내역',
            }
        ],
		drawCallback: function () {
			$('#matrlInOutWhsAdmHistTable_wrapper').attr('style', 'padding-bottom: 10px;');
        },
    });

    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

	//포장번호 스캔
	$("#matrlBarcodeNo").keypress(function (e) {
		if (e.which == 13) {
			matrlBarcodeNo = $('#matrlBarcodeNo').val();
			$('#matrlInOutWhsAdmHistTable').DataTable().ajax.reload( function () {});
		}
    });

	//초기화btn
	$('#btnRetv').on('click', function() {
		matrlBarcodeNo = $('#matrlBarcodeNo').val();
		$('#matrlInOutWhsAdmHistTable').DataTable().ajax.reload(function () {});
	});

	$('#matrlInOutWhsAdmHistTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }	
        else {
        	$('#matrlInOutWhsAdmHistTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
</script>
</body>
</html>
