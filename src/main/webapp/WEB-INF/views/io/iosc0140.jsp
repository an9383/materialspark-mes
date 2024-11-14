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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품 입출고내역</li>
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
						<label class="input-label-sm">포장번호</label>
						<div class="form-group-100 mr-4">
							<input type="text" class="form-control" id="boxNo" style="min-width:130px;">
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
					<table id="goodsProductInOutHistTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width:120px" class="text-center">내역 일자</th>
								<th style="min-width:100px" class="text-center">포장번호</th>
								<!-- <th style="min-width:100px" class="text-center">LOT NO</th> -->
								<th style="min-width:70px" class="text-center">제품코드</th>
								<th style="min-width:120px" class="text-center">제품명</th>
								<th style="min-width:50px" class="text-center">오더구분</th>
								<th style="min-width:70px" class="text-center">입고일</th>
								<th style="min-width:60px" class="text-center">잔여수량</th>
								<th style="min-width:70px" class="text-center">제품상태</th>
								<th style="min-width:70px" class="text-center">불량상태</th>
								<th style="min-width:70px" class="text-center">불량일</th>
								<th style="min-width:80px" class="text-center">불량유형</th>
								<th style="min-width:100px" class="text-center">비고</th>
								<th style="min-width:60px" class="text-center">원장 포장번호</th>
								<th style="min-width:60px" class="text-center">병합 포장번호</th>
								<th style="min-width:60px" class="text-center">분할/병합</th>
								<th style="min-width:60px" class="text-center">재분할/재병합</th>
								<th style="min-width:60px" class="text-center">폐기 상태</th>
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

	let menuAuth = 'iosc0140';
	let currentHref = 'iosc0140';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품 입출고내역");

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//자재불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
	var boxNo = 'empty';
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let goodsProductInOutHistTable = $('#goodsProductInOutHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
            url: '<c:url value="/io/goodsProductInOutHistList"/>',
            type: 'GET',
            data: {
            	'menuAuth'		: 		menuAuth,
	           	'boxNo'			:		function() { return boxNo; },
            },
        },
        //rowId: 'lotNo',
        columns: [
			{
			    data: 'histDate',
			    render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD HH:mm:ss");
					} else {
						return "-";
					}
			    }
			},
			{ data: 'boxNo' },
			/* 
			{ data: 'lotNo' ,
				render: function(data, type, row) {
					if(row["selBoxNo1"] != "" && row["selBoxNo1"] != null) {
						return '원장번호로 검색해주세요.';
					} else {
						return data;
					}
				}
			},
			*/
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
			{ 
			    data: 'goodsInDate',
			    render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
			{ data: 'remainCnt' },
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm' },
			{
			    data: 'faultyDate',
			    render: function(data, type, row) {
			    	if (data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
			    }
			},
            {
				data: 'faultyType',
				render: function(data, type, row) {
					let count = 0;
					let faultyTypeNm = '';
					if (data != null) {
						for (let jj=0; jj<data.length; jj++) {
							if (data.substring(jj,jj+1) == '1'){
								faultyTypeNm += goodsFaultyType[jj].baseCdNm + ', ';
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
            { data: 'faultyDesc' },
			{ data: 'selBoxNo1' },
			{ data: 'selBoxNo2' },
			{ data: 'mergeYnNm' },
			{
				data: "divisionYnNm",
				render: function(data, type, row, meta) {
					if(row['divisionYn'] == 'N') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else if(row['divisionYn'] == 'D') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['divisionYn'] == 'M') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
			{
				data: "disuseYnNm",
				render: function(data, type, row, meta) {
					if(row['disuseYn'] == 'N') {
						return data;
					} else if(row['disuseYn'] == 'Y') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					}
				}
			},
            
        ],
        columnDefs: [
           	{ targets: [6] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [6], className: 'text-right' },
        ],
        order: [
            [ 0, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품 입출고 내역',
            },
            {
                extend: 'excel',
                title: '제품 입출고 내역',
            },
            {
                extend: 'print',
                title: '제품 입출고 내역',
            }
        ],
		drawCallback: function () {
			$('#goodsProductInOutHistTable_wrapper').attr('style', 'padding-bottom: 10px;');
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
	$("#boxNo").keypress(function (e) {
		if (e.which == 13) {
			boxNo = $('#boxNo').val();
			$('#goodsProductInOutHistTable').DataTable().ajax.reload( function () {});
		}
    });

	//초기화btn
	$('#btnRetv').on('click', function() {
		boxNo = $('#boxNo').val();
		$('#goodsProductInOutHistTable').DataTable().ajax.reload(function () {});
	});

	$('#goodsProductInOutHistTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }	
        else {
        	$('#goodsProductInOutHistTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    
</script>
</body>
</html>
