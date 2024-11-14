<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
  <!--header ============================================================== -->
	<header class="page-title-bar">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
				<li class="breadcrumb-item active">제품(작지) 전체폐기</li>
			</ol>
		</nav>
	</header>
	<!-- #main=============================== -->
    <div class="container-fluid" id="main">
    <!--======================== .left-list ========================-->
		<div class="left-list left-60">
			<div class="card">
				<!--=========조회조건============-->
				<div class="card-body col-sm-12 border-bottom pb-4">
					<div class="row">
						<label class="input-label-sm">생산LotNo</label>
						<div class="form-group-100 mr-5">
							<input type="text" class="form-control" style="width:130px;" id="workOrdLotNo">
						</div>
						<div class="form-group row">
							<button type="button" class="btn btn-primary float-right mr-1" id="btnRetv">조회</button>
							<div class="ml-6 row float-right alert-primary">
								<h6 class="p-1 mr-3 mb-0" >생산LotNo :</h6>
								<h5 class="mb-0" id="workOrdLotNoText"></h5>
							</div>
							<button type="button" class="d-none btn btn-danger float-right ml-5 " id="btnPackAdd">폐기</button>
						</div>
					</div>
				</div>
				<!--==========자재입고내역테이블===========-->
				<div class="mb-3 mt-3">
					<h6>제품 목록</h6>
				</div>
				<div class="table-responsive">
					<table id="productDisuseTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:80px;">포장일</th>
								<th class="text-center" style="min-width:120px;">작지 번호</th>
								<!-- <th class="text-center" style="min-width:120px;">생산LotNo</th> -->
								<th class="text-center" style="min-width:110px;">BOX NO</th>
								<th class="text-center" style="min-width:80px;">제품코드</th>
								<th class="text-center" style="min-width:120px;">제품명</th>
								<th class="text-center" style="min-width:70px;">오더구분</th>
								<th class="text-center" style="min-width:70px;">포장 수량</th>
								<th class="text-center" style="min-width:70px;">잔여 수량</th>
								<th class="text-center" style="min-width:70px;">포장 단위</th>
								<th class="text-center" style="min-width:100px;">제품 상태</th>
								<th class="text-center" style="min-width:100px;">불량 상태</th>
								<th class="text-center" style="min-width:100px;">재분할</th>
								<th class="text-center" style="min-width:100px;">불량일</th>
								<th class="text-center" style="min-width:200px;">불량 유형</th>
								<th class="text-center" style="min-width:100px;">비고</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<!--=======end================= /.bottom - list ========================-->
    </div><!-- / #main  -->
</div><!-- /.page-wrapper -->
<!-- 불량유형 모달 시작 -->
<div class="modal fade bd-example-modal-lg" id="faultyPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="faultyPopUpLabel"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<table id="faultyPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
					<colgroup><col width="40%"></colgroup>
					<colgroup><col width="60%"></colgroup>
					<thead class="thead-light" style="margin-top: 0px;">
						<tr>
							<th id="faultyDateLabel"></th>
							<td>
								<div class="form-group input-sub m-0 row">
									<input class="form-control" style="min-width:100%;" type="date" id="faultyDate" name="faultyDate">
								</div>
							</td>
						</tr>
						<tr>
							<th id="faultyDescLabel"></th>
							<td>
								<input type="text" id="faultyDesc" name="faultyDesc" style="max-width: 100%;" class="form-control" maxlength="255"/>
							</td>
						<tr>
						<th id="faultyTypeLabel"></th>
							<td>
							<c:forEach var="item" items="${goodsFaultyType}">
								<div class="row">
									<div class="col-6 text-center">${item.baseCdNm}</div>
									<div class="col-6 text-center"><input type="checkbox" id="faultyType${item.baseCd}" style="zoom:1.8;"></div>	
								</div>
							</c:forEach>
							</td>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="btnDisuseCheck" data-dismiss="modal" style="min-width:70px;">폐기</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 불량유형 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0110';
	let currentHref = 'qmsc0110';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품(작지) 전체폐기");

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
	//let viewIdx;
	//let sideView = 'add';
	var serverDate =  "${serverDate}";
	var workOrdLotNo = 'null';
	var boxNo = 'null';
	var btnRetvClick = false;
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let productDisuseTable = $('#productDisuseTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/goodsDisuseListScan"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 	menuAuth,
	           	'workOrdLotNo'	: 	function() { return workOrdLotNo; },
            },
        },
        rowId: '',
        columns: [
			{ data: 'packDate',
			 render: function(data, type, row) {	
				 if(data == "Invalid date" || data == null){
					 return "";
				 }
					return moment(data).format("YYYY-MM-DD");
			     }
			},
			{ data: 'workOrdNo' },
			/* { data: 'workOrdLotNo' }, */
			//{ data: 'ordLotNo',
			//	render: function(data, type, row) {
			//		var html = '';
			//		if( row['gubun'] == 'D') {
			//			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
			//		} else if( row['gubun'] == 'N') {
			//			html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
			//		}
			//		return html;
			//	}
			//},
			{ data: 'boxNo' },
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
			{
				data: "packDtlCnt",
				render: function(data, type, row, meta) {
					if(data == '0') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else {
						return addCommas(data);
					}
				}
			},
			{ data: 'remainCnt' },
			{ data: 'packCnt' },
			{ data: 'goodsStatusNm' },
			{
				data: "faultyStatusNm",
				render: function(data, type, row, meta) {
					if(data == '폐기') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else {
						return data;
					}
				}
			},
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
                data: 'faultyDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
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
        ],
        columnDefs: [
           	{ targets: [6,7,8], render: $.fn.dataTable.render.number( ',' )},
           	{ targets: [6,7,8], className: 'text-right' }, 
        ],
        order: [
            [ 1, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품(작지) 전체 폐기',
            },
            {
                extend: 'excel',
                title: '제품(작지) 전체 폐기',
            },
            {
                extend: 'print',
                title: '제품(작지) 전체 폐기',
            }
        ],
        drawCallback : function( settings ) {
            //조회시 검색된 값이 없을 시
            if ( ($('#productDisuseTable tbody tr').length == 1) && (btnRetvClick == true) ) {
            	$('#workOrdLotNoText').text('');
            	$('#btnPackAdd').addClass('d-none');
            //페이지 첫 로딩 시 초기 설정
			} else if ( ($('#productDisuseTable tbody tr').length == 1) && (btnRetvClick == false) ){
				$('#workOrdLotNoText').text($('#workOrdLotNo').val());
            	$('#workOrdLotNo').val('');
            	$('#btnPackAdd').addClass('d-none');
            //검색 값이 있을 경우 & 폐기 시켰을 경우
			} else if ( ($('#productDisuseTable tbody tr').length != 1) && (btnRetvClick == true) ) {
				$('#workOrdLotNoText').text($('#workOrdLotNo').val());
				$('#workOrdLotNo').val();
            	$('#btnPackAdd').removeClass('d-none');
			//그외
			} else {
				$('#workOrdLotNoText').text($('#workOrdLotNo').val());
            	$('#workOrdLotNo').val('');
            	$('#btnPackAdd').removeClass('d-none');
			}
       	},
        rowCallback: function (row, data) {
            if ( data.divisionYn == 'D' ) {
                $(row).addClass('skyYellow');
            } else if ( data.divisionYn == 'M' ) {
                $(row).addClass('skyBlue');
            }
        },
    });

    // 보기
    $('#productDisuseTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#productDisuseTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            //ordLotNo = productDisuseTable.row( this ).data().ordLotNo;
        }
    });

	$("#workOrdLotNo").keypress(function (e) {
		if (e.which == 13) {
			$('#btnRetv').trigger("click");
		}
	});
	
    //조회 버튼 클릭
    $('#btnRetv').on('click', function() {
    	workOrdLotNo = $('#workOrdLotNo').val();
    	if( workOrdLotNo == null || workOrdLotNo == '') {
            toastr.warning('작지번호를 또는 BoxNo 입력해주세요.');
            $('#boxNo').focus();
            return false;
        }
        
    	btnRetvClick = true;
		$('#productDisuseTable').DataTable().ajax.reload( function () {});
    });

 	// 폐기 버튼 클릭
    $('#btnPackAdd').on('click', function () {
    	
    	toastr.warning('비활성화된 기능입니다. 제품 폐기를 원하실 경우<br>제품입출고관리/제품정보&출하추적 에서 불량처리 후 폐기처리 하시기 바랍니다.', '', {timeOut: 5000});
    	
    	//$('#faultyPopUpLabel').text('폐기 처리');
		//$('#faultyDateLabel').text('폐기일');
		//$('#faultyDescLabel').text('비고');
		//$('#faultyTypeLabel').text('폐기유형');
    	//$('#faultyDate').val(serverDate);
    	//$('#faultyDesc').val('');
    	//for (let i=0; i<goodsFaultyType.length; i++) {
    	//		$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
        //}
    	//$('#faultyPopUpModal').modal('show');
    	
    });

    // 폐기 취소
    $('#btnDisuseCheckCancel').on('click', function () {
    	$('#faultyPopUpModal').modal('hide');
    });

 	// 폐기
    $('#btnDisuseCheck').on('click', function () {

    	$('#my-spinner').show();
    	
       	workOrdLotNo = $('#workOrdLotNoText').text();
		boxNoCnt = productDisuseTable.data().count();

		let faultyType = '';
		
		for (let i=0; i<goodsFaultyType.length; i++) {
			if($('#faultyType' + goodsFaultyType[i].baseCd).prop("checked")) {
				faultyType += '1';
			} else {
				faultyType += '0';
			}
		}
       	
   		$.ajax({
   			url	: '<c:url value="/qm/goodsProductDisuse"/>',
   			type : 'POST',
   			data : {
   				
   				'menuAuth'		:	menuAuth,
   				'workOrdLotNo'	:	function() { return workOrdLotNo; },
   				'boxNoCnt'		:	function() { return boxNoCnt; },
   				'faultyDate'	:	function() { return $('#faultyDate').val().replace(/-/g, ''); },
   				'faultyType'	:	function() { return faultyType; },
   				'faultyDesc'	:	function() { return $('#faultyDesc').val(); },
   			},
   			beforeSend : function() {
   				// $('#btnAddConfirm').addClass('d-none');
   			},
   			success : function(res) {
   				if (res.result == 'ok') {
   					toastr.success('폐기되었습니다.');
   					$('#productDisuseTable').DataTable().ajax.reload( function () {});
   					$('#faultyPopUpModal').modal('hide');
   				} else if (res.result == 'fail') {
   					toastr.warning(res.message, '', {timeOut: 5000});
   				} else if (res.result == 'error') {
   					toastr.error(res.message, '', {timeOut: 5000});
   				}
   			},
   			complete : function() {
   				$('#my-spinner').hide();
   			}
   		});
    });

    //toastr.warning('폐기 기능이 비활성화된 페이지입니다.<br>생산LotNo로 추적만 가능합니다.', '', {timeOut: 5000});
    
</script>

</body>
</html>
