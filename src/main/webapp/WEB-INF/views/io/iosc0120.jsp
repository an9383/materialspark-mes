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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품 정보&출하추적</li>
			</ol>
		</nav>
	</header>
	<!-- #main=============================== -->
    <div class="container-fluid" id="main" style="overflow-x: hidden;">
    	<!--======================== .left-list ========================-->
		<div class="col-md-12 matrl-top-list">
			<div class="card">
				<div class="card-body col-sm-12 border-bottom pt-0 pb-1">
					<div class="row">
						<label class="input-label-sm">포장 번호</label>
						<div class="form-group-100 mr-4">
							<input type="text" id="boxNo" class="form-control" style="min-width:120px;">
						</div>
						<button type="button" class="btn btn-primary ml-2" id="btnRetv" style="height: 25px;">조회</button>
						<%
							if(!factoryCode.equals("003")) {
						%>
						<label class="input-label-sm" style="margin-left:12px;" id="customerLotLabel">고객사 LotNo</label>
						<div class="form-group-100 mr-4" id="customerLotdiv">
							<input type="text" id="customerLotNo" class="form-control" style="min-width:120px;border: 1px solid blue;">
						</div>
						<div>
							<input type="checkBox" style="width:25px; height:25px" id="checkLikeCustomerLotNo" name="checkLikeCustomerLotNo" checked>
							<label style="border: 1px solid blue;display: inline-block; width: 25px; height: 25px;border-radius: 2px;cursor: pointer;position: absolute; left: 50vh;" for="checkLikeCustomerLotNo"></label>
						</div>
						<label style="width: 44px;line-height: 12px;margin-left: 3px;" for="checkLikeCustomerLotNo">정확한값조회</label>
						<button type="button" class="btn btn-primary ml-2" id="btnCustomerLotNoSearch" style="height: 25px;">조회</button>
						<%
							}
						%>
						<div class="form-group">
							<button type="button" class="btn btn-primary ml-5" id="btnHold" disabled>대기</button>
							<button type="button" class="btn btn-warning ml-3" id="btnReturn" disabled>검사 반품</button>
							<button type="button" class="btn btn-primary ml-3" id="btnFaulty" disabled>불량</button>
						</div>
					</div>
				</div>
				<div class="mt-1">
					<h6 style="margin: 0px;">제품정보</h6>
				</div>
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="traceBoxNoTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:70px;">포장일</th>
								<th class="text-center" style="min-width:70px;">입고일</th>
								<th class="text-center" style="min-width:100px;">포장 번호</th>
								<th class="text-center" style="min-width:60px;">고객사 LotNo</th>
								<th class="text-center" style="min-width:110px;">작지 번호</th>
								<th class="text-center" style="min-width:120px;">생산LotNo</th>
								<th class="text-center" style="min-width:80px;">LOT NO</th>								
								<th class="text-center" style="min-width:80px;">제품코드</th>
								<th class="text-center" style="min-width:120px;">제품명</th>
								<th class="text-center" style="min-width:80px;">오더구분</th>
								<th class="text-center" style="min-width:80px;">포장 수량</th>
								<th class="text-center" style="min-width:80px;">잔여 수량</th>
								<th class="text-center" style="min-width:80px;">포장 단위</th>
								<th class="text-center" style="min-width:100px;">제품 상태</th>
								<th class="text-center" style="min-width:100px;">제품 불량상태</th>
								<th class="text-center" style="min-width:100px;">원장 포장번호</th>
								<th class="text-center" style="min-width:100px;">분할 포장번호</th>
								<th class="text-center" style="min-width:100px;">분할&병합 여부</th>
								<th class="text-center" style="min-width:110px;">재분할&재병합 여부</th>
								<th class="text-center" style="min-width:80px;">폐기 상태</th>
								
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
            <div class="col-md-12 matrl-bottom-list" id="" style="min-height: 40vh;">
              	<div class="mt-1">
					<h6 style="margin: 0px;">출하 PO정보</h6>
				</div>
                <div class="card" id="formBox">
                    <form id="form">
                      <!-- .table-responsive -->
					<div class="table-responsive">
						<table id="tracePurchaseOrderOutputHist" class="table table-bordered table-td-center">
							<thead class="thead-light">
								<tr>
									<!-- <th style="min-width: 80px;" class="text-center">출하일</th> -->
									<th style="min-width:80px;" class="text-center">등록번호</th>
									<th style="min-width:60px;" class="text-center">PO Number</th>
									<th style="min-width:60px;" class="text-center">포장 번호</th>
									<th style="min-width:100px;" class="text-center">제품명</th>
									<th style="min-width:100px;" class="text-center">모델No</th>
									<th style="min-width:60px;" class="text-center">오더구분</th>
									<th style="min-width:100px;" class="text-center">BOX 출하수량</th>
									<th style="min-width:100px;" class="text-center">거래처</th>
									<th style="min-width:80px;" class="text-center">단가</th>
									<th style="min-width:100px;" class="text-center">오더량</th>
									<th style="min-width:100px;" class="text-center">금액</th>
									<th style="min-width:100px;" class="text-center">출고량</th>
									<th style="min-width:100px;" class="text-center">미출고량</th>
									<th style="min-width:100px;" class="text-center">마감일</th>
									<th style="min-width:100px;" class="text-center">납기일</th>
									<th style="min-width:120px;" class="text-center">비고</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->               	                    
                    </form>
                </div>
                <div class="mt-2">
                    <button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
                    <button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
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
				<button type="button" class="btn btn-primary" id="btnFaultySave" data-dismiss="modal" style="min-width:70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 불량유형 모달 끝 -->
<!-- 검사반품 모달 -->
 <div class="modal fade" id="faultyPopUpModal1" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel1">검사 반품 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<p>*선택된 제품들이 포장&검사반품 상태로 변경되며 출하 취소됩니다.</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-warning" id="btnReturnCheck" data-dismiss="modal" style="min-width: 70px;">검사 반품</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 검사반품 모달 끝-->
<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0120';
	let currentHref = 'iosc0120';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품 정보&출하추적");

	//공통코드 처리 시작
    var goodsFaultyType=new Array();	//제품불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
	var boxNo = 'empty';
	var serverDate =  "${serverDate}";
	let customerLotNo = 'empty';
	let checkLikeCustomerLotNo = "001";

	//제품정보
	$.fn.dataTable.ext.errMode = 'none';
	let traceBoxNoTable = $('#traceBoxNoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
		//pageLength: 10,
		scrollX: true,
        scrollY : "34vh",
        scrollCollapse: true,
		ajax: {
		    url: '<c:url value="/po/tracePurchaseBoxNo"/>',
		    type: 'GET',
		    data: {
		    	'menuAuth'					:	menuAuth,
		        'boxNo'						:	function() { return boxNo },
		        'customerLotNo' 			:   function() { return customerLotNo },
		        'checkLikeCustomerLotNo'	:   function() { return checkLikeCustomerLotNo }
		    },
		},
		rowId: 'boxNo',
		columns: [
        	{ data:'packDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			},
			{ data:'goodsInDate',
				render: function(data, type, row) {
					if (data == '' || data == null){
						return '-';
					} else {
						return moment(data).format("YYYY-MM-DD");
					}
				}
			},
			{ data: 'boxNo' },
			{ data: 'customerLotNo' },
			{ data: 'workOrdNo' },
			{ data: 'workOrdLotNo' },
			//{ data: 'ordLotNo' },
			{ data: 'lotNo' },
			{ data: 'goodsCd' },
			{ data: 'goodsNm' },
			{ data: 'ordGubunNm' },
			{ data: 'packDtlCnt' },
			{ data: 'remainCnt' },
			{ data: 'packCnt' },
			{ data: 'goodsStatusNm' },
			{ data: 'faultyStatusNm' },
			{ data: 'selBoxNo1' },
			{ data: 'selBoxNo2' },
			{
				data: "mergeYnNm",
				render: function(data, type, row, meta) {
					if(row['mergeYn'] == '') {
						let html = '<p style="margin-bottom: 0px;">-</p>';
						return html;
					} else if(row['mergeYn'] == 'D') {
						let html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
						return html;
					} else if(row['mergeYn'] == 'M') {
						let html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
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
        	{ targets: [0,1,2,3,4,5,6,7,8,9,13], className: 'text-center' },
        	{ targets: [10,11,12], className: 'text-right' },
        	{ targets: [10,11,12] , render: $.fn.dataTable.render.number( ',' )},
        ],		
		order: [
			[ 1, 'asc' ],
		],
    });
    
    // 보기
    $('#traceBoxNoTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#traceBoxNoTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $('#boxNo').val($(this).find('td').eq(2).html());
        }
    });
    
    //출하 PO정보
    let tracePurchaseOrderOutputHist = $('#tracePurchaseOrderOutputHist').DataTable({
        dom: "<'row'<'col-sm-12'tr>>" +
			 "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        //pageLength: 20,
        scrollX: true,
        scrollY : "27vh",
        scrollCollapse: true,
        ajax: {
            url: '<c:url value="/io/tracePurchaseOrderOutputHist"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 				: 	menuAuth,
	           	'boxNo'						:	function() { return boxNo; },
	           	'customerLotNo' 			: 	function() { return customerLotNo; },	
	           	'checkLikeCustomerLotNo'	:   function() { return checkLikeCustomerLotNo }
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: '',
        columns: [
        	//{ data:'poDate',
			//	render: function(data, type, row) {
			//		return moment(data).format("YYYY-MM-DD");
			//   }
			//},
        	{ data: 'poSeq' },
        	{ data: 'poNo' },
        	{ data: 'boxNo' },
        	{ data: 'goodsNm' },
        	{ data: 'modelNo' },
        	{ data: 'poGubunNm' },
        	{ data: 'outputCnt' },
        	{ data: 'dealCorpNm' },
        	{ data:'costUnit',
				render: function(data, type, row) {
					return parseFloat(data).toFixed(1);
			   }
			},
        	{ data: 'poQty' },
        	{ data: 'totalPrice' },
        	{ data: 'outputQty' },
        	{ data: 'remainQty' },
        	{ data:'deliveryDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
			   }
			},
			{ data:'deadLine',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
			   }
			},
        	{ data: 'poDesc' },
        ],
        columnDefs: [
        	{ targets: [6,8,9,10,11,12], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [6,8,9,10,11,12], className: 'text-right' }, 
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
    $('#tracePurchaseOrderOutputHist tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#tracePurchaseOrderOutputHist').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });     

	$("#boxNo").keypress(function (e) {
	    if (e.which == 13) {
	    	$('#btnRetv').trigger('click');
	    }
	});

	$("#customerLotNo").keypress(function (e) {
	    if (e.which == 13) {
	    	$('#btnCustomerLotNoSearch').trigger('click');
	    }
	});
	
    $('#btnRetv').on('click', function() {
		/* if ($('#boxNo').val().trim().length != "13" && $('#boxNo').val().trim().length != "14") {
		    toastr.warning('제품 포장번호가 아닙니다!');
		    $('#boxNo').select();
		    $('#btnHold').attr('disabled', true);
			$('#btnReturn').attr('disabled', true);
			$('#btnFaulty').attr('disabled', true);
		    return false;
		}
 */
		$('#my-spinner').show();
		
		$('#btnHold').attr('disabled', false);
		$('#btnReturn').attr('disabled', false);
		$('#btnFaulty').attr('disabled', false);
		
		boxNo = $('#boxNo').val().trim();
		customerLotNo = '';
		$('#traceBoxNoTable').DataTable().ajax.reload( function () {
			$('#tracePurchaseOrderOutputHist').DataTable().ajax.reload( function () {
				$('#my-spinner').hide();
			});
		});
		
    });

    //정확한 값 조회 버튼 클릭 시
    $('#checkLikeCustomerLotNo').on('click', function(){
    	if($("#checkLikeCustomerLotNo").prop("checked")) {
    		checkLikeCustomerLotNo = "001";
    		toastr.success('입력된 문자와 일치하는 값으로 조회됩니다.');
		} else {
			checkLikeCustomerLotNo = "002";
			toastr.success('입력된 문자가 포함된 값으로 조회됩니다.');
		}
    	$('#checkLikeCustomerLotNo').blur();
    	$('#customerLotNo').focus();
	});
    
	//고객사 LOTNO 조회
    $('#btnCustomerLotNoSearch').on('click', function() {

    	if ($('#customerLotNo').val().trim().length == "0" || $('#customerLotNo').val().trim() == '') {
		    toastr.warning('고객사 LotNo를 입력해 주세요!');
		    $('#customerLotNo').select();
		    $('#btnHold').attr('disabled', true);
			$('#btnReturn').attr('disabled', true);
			$('#btnFaulty').attr('disabled', true);
		    return false;
		}

		if(checkLikeCustomerLotNo == "002"){
			if($('#customerLotNo').val().trim().length <= 5){
				toastr.warning('포함된 글자 조회 시 최소 5글자 이상을 적어주세요!');
				return false;
			}
		}

    	$('#my-spinner').show();
    	
		$('#btnHold').attr('disabled', true);
		$('#btnReturn').attr('disabled', true);
		$('#btnFaulty').attr('disabled', true);

		boxNo = '';
		customerLotNo = $('#customerLotNo').val().trim();
		$('#traceBoxNoTable').DataTable().ajax.reload( function () {
			$('#tracePurchaseOrderOutputHist').DataTable().ajax.reload( function () {
				$('#my-spinner').hide();
			});
		});
    });
    
    //불량
    $('#btnFaulty').on('click', function() {
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDate);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('불량 처리');
		$('#faultyDateLabel').text('불량일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('불량유형');

    	approvalCd = '002';
    	
		$('#faultyPopUpModal').modal('show');
    });

    //검사 반품
/*     $('#btnReturn').on('click', function() {
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDate);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('검사반품 처리');
		$('#faultyDateLabel').text('검사반품일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('검사반품 유형');

    	approvalCd = '003';
    	
		$('#faultyPopUpModal').modal('show');
    }); */
    
    //검사 대기
    $('#btnHold').on('click', function() {
		//선택해제
		for (let i=0; i<goodsFaultyType.length; i++) {
			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
		}
		$('#faultyDate').val(serverDate);
		$('#faultyDesc').val('');
		$('#faultyPopUpLabel').text('대기 처리');
		$('#faultyDateLabel').text('대기일');
		$('#faultyDescLabel').text('비고');
		$('#faultyTypeLabel').text('대기유형');

    	approvalCd = '004';
    	
		$('#faultyPopUpModal').modal('show');
    });

	$('#btnFaultySave').on('click', function() {
		//불량
		if (approvalCd == '002') {
			updateGoodsFaultyStatus("002");
		//검사 반품
		} else if (approvalCd == '003') {
			updateGoodsFaultyStatus("003");
		//대기
		} else if (approvalCd == '004') {
			updateGoodsFaultyStatus("004");
		}
	});

	function updateGoodsFaultyStatus(faultyStatus)
    {
		$('#my-spinner').show();
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var faultyDate = $('#faultyDate').val().replace(/-/g, '');
		var faultyDesc = $('#faultyDesc').val();
		var faultyType = '';

		//정상제품일경우
		if (faultyStatus == '001') {
			//checkbox.each(function(i) {
			//	var tr = checkbox.parent().parent().eq(i);
			//	var td = tr.children();
			//	var rowData = new Object();
			//	var boxNo = td.eq(3).text();
			//	rowData.menuAuth = menuAuth;
			//	rowData.boxNo = boxNo;
			//	rowData.faultyStatus = faultyStatus;
			//	rowData.faultyDate = '';
			//	rowData.faultyType = '';
			//	rowData.faultyDesc = '';
			//	dataArray.push(rowData);
			//	checkboxCnt += 1;
			//});

		//정상처리 외
		} else {
			for (let i=0; i<goodsFaultyType.length; i++) {
				if($('#faultyType' + goodsFaultyType[i].baseCd).prop("checked")) {
					faultyType += '1';
				} else {
					faultyType += '0';
				}
			}
			
			//checkbox.each(function(i) {
				//var tr = checkbox.parent().parent().eq(i);
				//var td = tr.children();
				var rowData = new Object();
				//var boxNo = td.eq(3).text();
				rowData.menuAuth = menuAuth;
				rowData.boxNo = boxNo;
				rowData.faultyStatus = faultyStatus;
				rowData.faultyDate = faultyDate;
				rowData.faultyType = faultyType;
				rowData.faultyDesc = faultyDesc;
				rowData.disposeGubun = '';
				dataArray.push(rowData);
				//checkboxCnt += 1;
			//});
		}
		
		//console.log(dataArray);
		
        $.ajax({
			url : '<c:url value="/po/changeGoodsProductFaultyType"/>',
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
                    if ( approvalCd == '001' ) {
                    	toastr.success("정상제품 처리되었습니다.");
					} else if ( approvalCd == '002' ) {
                    	toastr.success("불량 처리되었습니다.");
					} else if ( approvalCd == '003' ) {
                    	toastr.success("검사 반품 처리되었습니다.");
					} else if ( approvalCd == '004' ) {
                    	toastr.success("대기 처리되었습니다.");
					} else if ( approvalCd == '005' ) {
                    	toastr.success("폐기 처리되었습니다.");
					}
            		$('#traceBoxNoTable').DataTable().ajax.reload( function () {});
                } else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
    }


	//제품 검사반품
   	$('#btnReturn').on('click', function () {
//    		let countTemp = 0;
// 		$('#productShipmentTableDtl tbody tr').each(function(){
// 		 	if ( $(this).hasClass("selected") ){
// 		 		countTemp++;
// 			}
// 		});
// 		if (countTemp == 0) {
// 			toastr.warning("검사반품 할 제품을 선택해주세요!");
// 			return false;
// 		}

// 		faultyDate = '';
// 		faultyDesc = '';
// 		faultyType = '';
// 		for (let i=0; i<goodsFaultyType.length; i++) {
// 			$('#faultyType' + goodsFaultyType[i].baseCd).prop("checked", false);
// 		}
		
// 		$('#faultyPopUpLabel').text('검사반품 처리');
// 		$('#faultyDateLabel').text('*검사반품일');
// 		$('#faultyDescLabel').text('비고');
// 		$('#faultyTypeLabel').text('검사반품 유형');
// 		$('#faultyDate').val(serverDateTo);
// 		$('#faultyDesc').val("");


   		i = 0;
		$('#traceBoxNoTable tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){
				i++;
			}
		});
    	if (i == 0) {
			toastr.warning("검사 반품할 포장 No를 선택해 주세요!");
			return false;
		}
		
		$('#faultyPopUpModal1').modal('show');
		
   	});

	

	//제품 검사반품 상태변경
   	$('#btnReturnCheck').on('click', function () {
//    		let countTemp = 0;
// 		$('#productShipmentTableDtl tbody tr').each(function(){
// 		 	if ( $(this).hasClass("selected") ){
// 		 		countTemp++;
// 			}
// 		});
// 		if (countTemp == 0) {
// 			toastr.warning("검사반품 할 제품을 선택해주세요!");
// 			return false;
// 		}

// 		//불량상태Update
// 		updateGoodsFaultyStatus('003')

   		i = 0;
		$('#traceBoxNoTable tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){
				i++;
			}
		});
    	if (i == 0) {
			toastr.warning("검사 반품할 포장 No를 선택해 주세요!");
			return false;
		}
		
    	$('#my-spinner').show();
    	
    	boxArray = new Array();
    	var dtlCount = $('#traceBoxNoTable').DataTable().data().count();
    	
		$('#traceBoxNoTable tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){
				var boxNo =($(this).children().eq(2).text());
				var ouputCnt= removeCommas($(this).children().eq(10).text());
			 	var rowData = new Object();			 	
			 	rowData.menuAuth = menuAuth;
				rowData.boxNo = boxNo;
				rowData.ouputCnt = ouputCnt;				
				rowData.dtlCount = dtlCount;			
				rowData.removeTrayGubun = 'returnReInspect';
				boxArray.push(rowData);
			}
		});
				
        $.ajax({
            url: '<c:url value="/io/productOutputCancel2"/>',
            type: 'POST',
            data: JSON.stringify(boxArray),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if ( res.result == "ok" ){
                   
                    toastr.success(res.message);
                } else if ( res.reuslt == "fail" ){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}               				
				
                $('#traceBoxNoTable').DataTable().ajax.reload( function () {});
                $('#tracePurchaseOrderOutputHist').DataTable().ajax.reload( function () {});
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });


   	});
    
	

</script>

</body>
</html>
