<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% String userNm = session.getAttribute("userNm").toString(); %>

<%@include file="../layout/body-top.jsp" %>
<div class="page-wrapper" id="page-wrapper">

	<!-- 삭제 확인 모달 시작-->
	<div class="modal fade" id="deleteCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteCheckPopupModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="saveBtnModalLabel">출고 취소 확인</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<h6>출고 취소 처리 하시겠습니까?</h6>
	      	<p>*출고된 자재만 취소할 수 있습니다.</p>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-danger" id="btnDeleteCheck" style="min-width:70px;">삭제</button>
	      	<button type="button" class="btn btn btn-secondary" id="btnDeleteCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 삭제 확인 모달 종료 -->

	<!-- 자재입고(바코드)관련 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="barcodePopUpModal" tabindex="-1" role="dialog" aria-labelledby="barcodePopUpModalLabel" aria-hidden="true">
		<div class="row ">
			<div class="modal-dialog modal-lg">
				<!-- 자재입고 목록 보기 -->
				<div class="modal-content" style="margin-left: 20%;width: 82vh;" id="barcodePopUpContent">
					<div class="modal-header" style="padding-bottom:0px;">
						<h5 class="modal-title" id="userPopUpLabel">자재입고 조회</h5>
<!-- 						<button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
<!-- 							<span aria-hidden="true">&times;</span> -->
<!-- 						</button> -->
						<button type="button" class="close" style="display: none;" id="barcodeFifoCheckOpen">
							<span aria-hidden="true">→</span>
						</button>
					</div>
					
					<div class="row mb-2">
						<label class="input-label-sm mr-0" style="margin-left: 20px; margin-top: 12px;">입고일</label>
							<input type="date" class="form-control ml-2 mr-2" style="width: 130px;margin-top: 10px;" id="startDate">
							<label class="input-label-sm mr-0" style="line-height: 30px;">~</label>
							<input type="date" class="form-control ml-2 mr-2" style="width: 130px;margin-top: 10px;" id="barcodePopUpDate">
							<button type="button" class="btn btn-primary" id="barcodePopUpRetv" style="margin-top: 10px;">조회 </button>
							<input type="checkBox" style="margin-top:12px;margin-right:3px;width: 20px;height: 20px; margin-left:15px;" id="barcodeAllPopUpRetv">
							<label class="input-label-sm">전체<br>조회</label>
							<input type="checkBox" style="margin-top:12px;margin-right:3px;width: 20px;height: 20px;" id="barcodePopUpBundleOut" checked>
							<label class="input-label-sm">묶음<br>출하</label>
							<button type="button" class="btn" style="color: white; background-color: #04a304;margin-top: 10px;" id="btnReset">초기화</button>
<!-- 							<label id="btnSer" style="margin-left: 10px;margin-top: 12px;">검색 : </label> -->
					</div>		
					
					<div class="mb-2" style="border-bottom: 1px solid #e8e8ea; width: 78vh; margin-left: 2vh;"></div>
								
					<div class="modal-body" style="height: 72.5vh; overflow: auto;">
<!-- 						<hr class="text-secondary"> -->
						<table id="barcodePopUpTable" class="table table-bordered" style="padding-bottom: 0px;">
							<thead class="thead-light">
								<tr>
									<th>가입고일</th>
									<th>자재상태</th>
									<th>자재코드</th>
									<th>자재명</th>
									<th>바코드</th>
									<th>공급업체</th>
									<th>입고일</th>
									<th style="max-width:15px">비고</th>
								</tr>
							</thead>
						</table>
<!-- 						<hr class="text-secondary"> -->
					</div>
					
					<div class=" mt-2 mb-2" style="border-bottom: 1px solid #e8e8ea; width: 78vh; margin-left: 2vh;"></div>
					
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="btnBarcodeAdd">출하</button>
						<button type="button" class="btn btn-secondary" id="btnBarcodeClase">닫기</button>
					</div>
				</div>
			</div>
			<!-- 자재입고 목록 보기 끝 -->
				
			<!-- 선입선출 대상 목록 보기 -->
			<div class="modal-dialog modal-lg">
				<div class="modal-content" id="barcodeFifoCheckContent" style ="margin-left: -25%;width: 55vh;">
					<div class="modal-header">
						<h5 class="modal-title" id="">선입선출 대상 목록 조회</h5>
						<button type="button" class="close" id="barcodeFifoCheckClose">
							<span aria-hidden="true">←</span>
						</button>
					</div>
					<div class="modal-body">
						<label id="barcodeFifoCheckLabel"></label>
						
						<!-- 선입선출 목록 -->
						<div style="height: 700px; overflow: auto;">
							<table class="table table-sm table-bordered" id="barcodeFifoCheckTable" >
								<colgroup>
									<col width="10%">
									<col width="15%">
									<col width="20%">
									<col width="10%">
								</colgroup>
								<thead>
									<tr>
										<th>자재코드</th>
										<th>자재명</th>
										<th>바코드</th>
										<th>입고일</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<hr>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="btnBarcodeFifoCheckSearch" disabled>찾기</button>
					</div>
				</div>
				<!-- 선입선출 대상 목록 보기 끝-->
			</div>
		</div>
	</div>
	<!-- 자재입고(바코드)관련 모달 종료-->

	<!-- 생산제품 선입선출 확인 모달 시작 -->
	<div class="modal fade" id="goodsFifoCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="">선입선출 대상 목록 조회</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<label id="goodsFifoCheckLabel1"></label>
					<h6 id="goodsFifoCheckLabel2"></h6>
					<h6 id="goodsFifoCheckLabel3"></h6>
					
					<!-- 선입선출 목록 -->
					<div style="height: 700px; overflow: auto;">
						<table class="table table-sm table-bordered" id="goodsFifoCheckTable" >
							<colgroup>
								<col width="8%">
								<col width="15%">
								<col width="15%">
								<col width="10%">
							</colgroup>
							<thead>
								<tr>
									<th>자재코드</th>
									<th>자재명</th>
									<th>바코드</th>
									<th>입고일</th>
								</tr>
							</thead>
							<tbody></tbody>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="btnGoodsFifoAdd" data-dismiss="modal">출하</button>
					<button type="button" class="btn btn btn-secondary" data-dismiss="modal" id="btnGoodsFifoCancel">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 생산제품 선입선출 확인 모달 끝 -->

	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">자재투입(재고 출고량)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn2" onclick="openrNav2()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="matrlInOutWhsTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px;" class="text-center">가입고일</th>
									<th style="min-width: 50px;" class="text-center">출고일</th>
									<th style="min-width: 50px;" class="text-center">승인상태</th>
									<th style="min-width: 50px;" class="text-center">자재상태</th>
									<th style="min-width: 50px;" class="text-center">자재코드</th>
									<th style="min-width: 50px;" class="text-center">BacodeNo</th>
									<!-- <th style="min-width: 70px;" class="text-center">설비명</th> -->
									<th style="min-width: 50px;" class="text-center">재질</th>
									<th style="min-width: 80px;" class="text-center">제품</th>
									<!-- <th style="min-width: 120px;"class="text-center">규격</th> -->
									<th style="min-width: 40px;" class="text-center">출고량</th>
									<th style="min-width: 40px;" class="text-center">두께</th>
									<th style="min-width: 40px;" class="text-center">폭</th>
									<th style="min-width: 40px;" class="text-center">길이</th>
									<th style="min-width: 40px;" class="text-center">피치</th>
									<th style="min-width: 50px;" class="text-center">입고일</th>
									<th style="min-width: 50px;" class="text-center">담당</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="8" style="text-align:center">합계</td>
									<td id="sumOutputQty" style="text-align:right">0</td>
									<td colspan="6"></td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="right-list right-sidebar right-sidebar-fix" id="rfSidenav" style="width:40%;">
                    <div class="card" id="formBox">
                    <div class="card-body col-sm-12">
                        <div class="rightsidebar-close">
                            <a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2()"><i class="mdi mdi-close"></i></a>
                        </div>
                        <button type="button" class="btn btn-primary float-right" id="btnLineDelete">라인삭제</button>
                        <button type="button" class="btn btn-primary float-right mr-1" id="btnAllDelete">전체삭제</button>
                    </div>	
                    <form id="form">
                          <div class="table-responsive">
                            <table class="table table-bordered">
                            <colgroup>
	                            <col width="20%">
	                            <col width="30%">
	                            <col width="20%">
	                            <col width="30%">	                            
	                        </colgroup>
	                        <tr>
	                            <th>출고일</th>
	                            <td>
	                            	<input class="form-control touch6" style="width:150px;" type="date" id="preOutWhsDate" name="preOutWhsDate" type="year"/>
	                            </td>		                        
	                         	<th>*담당</th>
	                            <td>
	                           		<input type="hidden" class="form-control" id="preWorkCharger"  name="preWorkCharger">
	                           		<div class="input-sub m-0">
		                            	<input type="text" class="form-control" id="preWorkChargerNm"  name="preWorkChargerNm">
		                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelPreWorkCharger" onClick="selectPreWorkCharger()">
											<span class="oi oi-magnifying-glass"></span>
								        </button>
							        </div>
							        
	                            </td>
	                        </tr>
	                        <!-- 
	                        <tr>
	                            <th>*설비명</th>
	                            <td>
	                           		<input type="hidden" class="form-control" id="preOutEquipCd"  name="preOutEquipCd">
	                           		<div class="input-sub m-0">
		                            	<input type="text" class="form-control" id="preOutEquipNm"  name=preOutEquipNm>
		                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelEquipCode" onClick="selectEquipCode()">
										<span class="oi oi-magnifying-glass"></span>
								        </button>
									</div>
	                            </td>
	                         	<th>*제품(기종)</th>
	                            <td>
	                           		 <input type="hidden" class="form-control" id="preOutGoodsCd"  name="preOutGoodsCd">
	                            	<div class="input-sub m-0">
		                            	<input type="text" class="form-control" id="preOutGoodsNm"  name="preOutGoodsNm">
		                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelGoods" onClick="selectGoodsCode()">
									          <span class="oi oi-magnifying-glass"></span>
								        </button>
							        </div> 
	                            </td>	
	                        </tr>
	                         -->
	                        <tr>
	                         	<th>*바코드</th>
	                            <td>
	                            	<div class="input-sub m-0">
		                            	<input type="text" class="form-control" id="barcodeNo"  name="barcodeNo" maxlength="30">
		                            	<button type="button" class="btn btn-primary input-sub-search" id="btnBarcode" onClick="selectBarcode()">
											<span class="oi oi-magnifying-glass"></span>
								        </button>
							        </div>	
	                            </td>
	                            <th>자재</th>
	                            <td><span class="float-left  mr-2"  id="matrlCdText" ></span></td>
	                            <input type="hidden" class="form-control" id="matrlCd"  name="matrlCd">                    
	                            <input type="hidden" class="form-control" id="matrlNm"  name="matrlNm">	
	                            <input type="hidden" class="form-control" id="goodsNm"  name="goodsNm">
	                            <input type="hidden" class="form-control" id="goodsNmList"  name="goodsNmList">
	                            <input type="hidden" class="form-control" id="qutyNm"  name="qutyNm">
	                            <input type="hidden" class="form-control" id="inspectQty"  name="inspectQty">  
	                            <input type="hidden" class="form-control" id="preOutQty"  name="preOutQty">
	                            <input type="hidden" class="form-control" id="preBarcodeNo"  name="preBarcodeNo">
	                        </tr>
	                        <tr class="d-none" id="floorDiv">
	                        	<th>층 구분자</th>
	                        	<td>
	                        		<select class="custom-select" style="width:150px;" id="floorGubun"></select>
	                        	</td>
	                        	<th></th>
	                        	<td></td>
	                        </tr>
                            </table>
							<p>*제품명은 투입자재 추가 기능을 제외한 목록이 표시됩니다.</p>
	                    	<table id="barcodeOutputWhsTable" class="table table-bordered">
		                    	<colgroup>
		                            <col width="8%">
		                            <col width="20%">
		                            <col width="15%">
		                            <col width="9%">
		                            <col width="35%">
		                            <col width="7%">
		                            <col width="7%">	                            
		                        </colgroup>
		                        <thead class="thead-light">
			                        <tr>
		                              <!-- <th style="width: 50px">설비명 </th> -->
		                              <!-- <th style="width: 80px">제품(기종) </th> -->
		                              <th>자재코드</th>
		                              <th>자재명</th>
		                              <th>바코드</th>
		                              <th>재질</th>
		                              <th>제품</th>
		                              <th>입고량</th>
		                              <th>출고량</th>
		                            </tr>
		                        </thead>
                            </table>
						</div>                	                    
					</form>
				</div>
				<!--저장 버튼-->
				<div class="mt-2">
					<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
					<button type="button" class="btn btn-primary d-none float-right mr-1" id="btnCancel">취소</button>
					<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
				</div><!--/저장 버튼-->
			</div><!-- ===/.right-sidebar 등록,수정===  -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc0040';
	let currentHref = 'iosc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 투입(재고 출고량)");

	let viewIdx;
	var userNm = "<%=userNm%>";
	var preOutWhsDateFromCal	=  "${serverDateFrom}";
	var preOutWhsDateToCal		=  "${serverDateTo}";
	var preOutWhsDate 			=  "${serverDateTo}";	
	var inWhsDate 				='';
	var equipGroup 				= null;
	var exceptBarcodeNo 		= 'empty';		//스캔한 포장번호(선입선출에서 추가로 제외시킬애들);
	var barcodeArray			= new Array();	//바코드 담을 값
	let deliveryStatusCheck		= 'O'			//가출고 상태 check
	let factoryCode				= "<%=factoryCode%>";
	
	//3공장인 경우에만 사용
	if( factoryCode == "003" ) {
		$('#floorDiv').removeClass('d-none');
	}
		
	uiProc(true); 

	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설치장소
    <c:forEach items="${equipGroupCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    
	var floorCode = new Array(); // 층구분자
    <c:forEach items="${floorCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		floorCode.push(json);
    </c:forEach>
    //공통코드 처리 종료
    
    selectBoxAppend(floorCode, "floorGubun", "", "2");	//층구분자
    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let matrlInOutWhsTable = $('#matrlInOutWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-5'l><'col-sm-12 col-md-2'f><'col-sm-12 col-md-5'>>" +
        	"<'row'<'col-sm-12'tr>>" +
        	"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        buttons: true,
        ajax: {
            url: '<c:url value="/io/matrlPreOutWhsDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
	           	'preOutWhsDateFrom'	:		function() { return preOutWhsDateFromCal.replace(/-/g, ''); },
	           	'preOutWhsDateTo'	:		function() { return preOutWhsDateToCal.replace(/-/g, ''); 	},
	           	'equipGroup'		:		function() { return equipGroup; 							},
	           	'statusCd'			:		function() { return deliveryStatusCheck; 					},
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'lotNo',
        columns: [
            { data: 'preInWhsDate', 
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            { data: 'preOutWhsDate',
                render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            { data: 'approvalNm' },
            { data: 'statusNm' },
            { data: 'matrlCd' },
            { data: 'barcodeNo' },
            { data: 'qutyNm' }, 
            { data: 'goodsNmList' },
            //{ data: 'preOutEquipNm' },
            //{ data: 'preOutGoodsNm' },
            //{ data: 'model' },
            { data: 'preOutQty',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
            { data: 'thickness',
            	render: function(data, type) {
					if (data == '' || data == null) {
						return '-';
					} else {
						return parseFloat(data).toFixed(1);
					}
		   		}
            },
            { data: 'depth',
		   		render: function(data, type) {
					if (data == '' || data == null) {
						return '-';
					} else {
						return parseFloat(data).toFixed(1);
					}
		   		}
            },
            { data: 'length',
            	render: function(data, type) {
					if (data == '' || data == null) {
						return '-';
					} else {
						return parseFloat(data).toFixed(1);
					}
		   		}
            },
            { data: 'pitch',
            	render: function(data, type) {
					if (data == '' || data == null) {
						return '-';
					} else {
						return parseFloat(data).toFixed(1);
					}
		   		}
            },
            { data: 'inWhsDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                }
            },
            { data: 'preWorkChargerNm' }
        ],
        columnDefs: [
        	{ targets: [8,9,10,11,12], className: 'text-right' },
        	{ targets: [8,9,10,11,12], render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        drawCallback: function () {
			var sumOutputQty = $('#matrlInOutWhsTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(2)));
        },
        buttons: [
        	{
                extend: 'copy',
                title: '입출고관리/자재투입(재고 출고량)',
            },
            {
                extend: 'excel',
                title: '입출고관리/자재투입(재고 출고량)',
            },
            {
                extend: 'print',
                title: '입출고관리/자재투입(재고 출고량)',
            },
        ],
    });

    var sysdate = "${serverTime}";
	var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm">출고일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="preOutWhsDateFrom" name="preOutWhsDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(preOutWhsDateFrom,preOutWhsDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="preOutWhsDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="preOutWhsDateTo" name="preOutWhsDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(preOutWhsDateTo,preOutWhsDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="preOutWhsDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';	
		//html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>'
		html1 += '<input type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-left:15px; margin-right:3px;" id="chkDeliveryStatus" checked><label for="chkDeliveryStatus" class="input-label-sm">출고 조회</label>';
		html1 += '&nbsp;&nbsp;<button type="button" class="btn btn-danger ml-6" id="btnDel">출고 취소</button>'
		html1 += '</div>';
	$('#matrlInOutWhsTable_length').html(html1);
	$('#preOutWhsDateFrom').val(preOutWhsDateFromCal);
	$('#preOutWhsDateTo').val(preOutWhsDateToCal);
	selectBoxAppend(equipGroupCode, "equipGroupCd", "", "1");

	//출고 조회 클릭 시
	$('#chkDeliveryStatus').click(function(){
		if ($(this).prop('checked')) {
			deliveryStatusCheck = 'O';
		}else{
			deliveryStatusCheck = '';
		}
		$('#matrlInOutWhsTable').DataTable().ajax.reload();
	});

    // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });
    	
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#preOutWhsDateFrom').val());
		let dateTo = new Date($('#preOutWhsDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		
    	preOutWhsDateFromCal =  $('#preOutWhsDateFrom').val();
    	preOutWhsDateToCal =  $('#preOutWhsDateTo').val();
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
		equipGroup = "";
    });

    var goodsFifoCheckBarcodeNo='';
    //바코드 스캔 시 & 바코드 선택 시
    $("#barcodeNo").keypress(function (e) {
        if (e.which == 13){
            if ( !$.trim($('#preOutWhsDate').val()) ) {
                toastr.warning('출고일을 확인해 주세요.');
                return false;
            }
            if ( !$.trim($('#preWorkCharger').val()) ) {
                toastr.warning('담당자를 선택해 주세요.');
                $('#btnSelPreWorkCharger').focus();
                return false;
            }
            //if ( !$.trim($('#preOutEquipCd').val()) ) {
            //    toastr.warning('설비명를 선택해 주세요.');
            //    $('#btnSelEquipCode').focus();
            //    return false;
            //}
            //if ( !$.trim($('#preOutGoodsCd').val()) ) {
            //	$('#btnSelGoods').focus();            	
            //    toastr.warning('제품을 선택해 주세요.');
            //    return false;
            //}
            if ( !$.trim($('#barcodeNo').val()) ) {
                toastr.warning('바코드를 입력해 주세요.');
                return false;
            }
            
            var cval = compareBarcodeNo($.trim($('#barcodeNo').val()));
            if(cval == false) {
            	toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
                return false;              
            }

            $.ajax({
            	url: '<c:url value="/io/matrlPreOutWhsData"/>',
                type: 'GET',
                data: {
                	'menuAuth'	 		: 		menuAuth,
                	'barcodeNo'   		:       $.trim($('#barcodeNo').val()),
                	'exceptBarcodeNo'	:		function() { return exceptBarcodeNo; }
                },
                beforeSend: function() {
                  //  $('#btnAddConfirm').addClass('d-none');
                },
                success: function (res) {
                    let data = res.data;
                    if (res.result == 'ok') {
						//보기
						$('#matrlCd').val(data.matrlCd);
						$('#matrlNm').val(data.matrlNm);
						$('#goodsNmList').val(data.goodsNmList);
						$('#qutyNm').val(data.qutyNm);
						$('#inspectQty').val(data.inspectQty);
						$('#preOutQty').val(data.preOutQty);		//컨트롤단에서 입고량->잔여수량으로 변경해줬음 2022.4.27
						$('#preBarcodeNo').val(data.barcodeNo);
						$('#barcodeNo').val('');
						$('#barcodeNo').focus();
						$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
						$('#btnSave').removeClass('d-none');
						$("#btnSave").attr("disabled", false);
						$('#btnCancel').removeClass('d-none');
						$('#btnSelPreWorkCharger').attr('disabled', true);
						$('#btnSelEquipCode').attr('disabled', true);
						$('#btnSelGoods').attr('disabled', true);						
						exceptBarcodeNo += "/" + data.barcodeNo;	//스캔한 바코드 값 담아주기.
						
						twelveTimeCalc(data.inWhsTime);
						
						toastr.success("추가되었습니다.");
						
                    } else if (res.result == 'fail') {
                    	toastr.warning(res.message, '', {timeOut: 5000});
                    } else if (res.result == 'error') {
                    	toastr.error(res.message, '', {timeOut: 5000});
                    } else {
                        if(res.result == 'before') {
	                       	if(!compareBarcodeNo(res.barcode)) { //이전 바코드가 추가 되어 있는지 체크
	    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
    	                        $('#barcodeNo').val('');
    	                        $('#barcodeNo').focus();
	                		} else {
// 	                			toastr.warning(res.message, '', {timeOut: 5000});
								$('#goodsFifoCheckLabel1').text("*선출하 대상은 "+res.barcode.length+"개 입니다.");

								
								goodsFifoCheckBarcodeNo = data.barcodeNo;	//goodsFifoCheckTable에 보내줄 바코드 값
								$('#goodsFifoCheckTable').DataTable().ajax.reload();
								
								$('#goodsFifoCheckPopupModal').modal({backdrop: 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
								//선입선출 대상 모달 끝
	                			
		                        $('#barcodeNo').val('');
		                        $('#barcodeNo').focus();
	                		}
	                    } else {
	                    	toastr.error(res.warning, '', {timeOut: 5000});
	                        $('#barcodeNo').val('');
	                        $('#barcodeNo').focus();   
	                    }
                    }    
	             },
	             complete:function(){
	                    //$('#btnAddConfirm').removeClass('d-none');
	             }
	        });
        }
    });

	let barcodeOutputWhsTable = $('#barcodeOutputWhsTable').DataTable({
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        searching: false,
        ajax: {
            url: '<c:url value="/io/matrlPreOutWhsEmptyList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
             },
        },
        //rowId: '',
        columns: [
        	//{
	        //	data: 'preOutEquipNm',
	    	//	render: function(data, type, row, meta) {
	    	//		if(data != null) {
	    	//			return data;
	    	//		} else {
			//			return  $("#preOutEquipNm").val();
	    	//		}
	    	//	}
    		//},
            //{
            //    data: 'preOutGoodsNm',
   	    	//	render: function(data, type, row, meta) {
   	    	//		if(data != null) {
   	    	//			return data;
   	    	//		} else {
   			//			return  $("#preOutGoodsNm").val();
   	    	//		}
   	    	//	}
            //},
            {
                data: 'matrlCd',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   	    				return $("#matrlCd").val();
   	    			}
   	    		}
            },
            {
                data: 'matrlNm',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   	    				return $("#matrlNm").val();
   	    			}
   	    		}
            },
            {
                data: 'barcodeNo',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   	    				return $("#preBarcodeNo").val();
   	    			}
   	    		}
            },
            {
                data: 'qutyNm',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   	    				return $("#qutyNm").val();
   	    			}
   	    		}
            },
            {
                data: 'goodsNmList',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   	    				return $("#goodsNmList").val();
   	    			}
   	    		}
            },
            {
                data: 'inspectQty',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return parseFloat(data).toFixed(2);
   	    			} else {
   	    				return $("#inspectQty").val();
   	    			}
   	    		}
            },
            {
                data: 'preOutQty',
   	    		render: function(data, type, row, meta) {
   	    			if(data != null) {
   	    				return parseFloat(data).toFixed(2);
   	    			} else {
   	    				return $("#preOutQty").val();
   	    			}
   	    		}
            }
        ],
        columnDefs: [
        	{ targets: [0,1,2,3,4], className: 'text-center' },
        	{ targets: [5,6], className: 'text-right-td' },
        	{ targets: [5,6], render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
            [ 0, 'asc' ]
        ],
    });

	var selectExceptBarcodeNo ='';
	
    // 보기
    $('#barcodeOutputWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#barcodeOutputWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        var outputBoxCnt = $('#barcodeOutputWhsTable').DataTable().data().count();

       	selectExceptBarcodeNo =  $(this).find('td').eq(2).text();
        //this_row = $('#barcodeOutputWhsTable').DataTable().row(this).index();
        //alert(this_row[0][0]);
        //alert(this_row);
    });

  	//전체 삭제 버튼 클릭 시
    $('#btnAllDelete').on('click', function() {
        $('#barcodeOutputWhsTable').DataTable().clear().draw();
    	$("#barcodeNo").val("");
    	$("#barcodeNo").focus();
    	$("#btnSave").attr("disabled", true);
        //$('#btnSave').addClass('d-none');
        //$('#btnCancel').addClass('d-none');
    	exceptBarcodeNo='empty';
    });	

	//라인삭제버튼 클릭 시
    $('#btnLineDelete').on('click', function() {
    	$('#barcodeOutputWhsTable').DataTable().rows( '.selected' ).remove().draw();
    	$("#barcodeNo").val("");
    	$("#barcodeNo").focus();
    	exceptBarcodeNo = exceptBarcodeNo.replace('/'+selectExceptBarcodeNo,'');
    	var rowCnt = $('#barcodeOutputWhsTable').DataTable().data().count(); 
    	if(rowCnt == 0) {
    		 $('#btnSave').addClass('d-none');
        }
    });	
       
    $('#preOutWhsDate').val(preOutWhsDate);	
//     $("#preOutWhsDate").attr("disabled",true);

    //취소 처리
    $('#btnCancel').on('click', function() {
    	exceptBarcodeNo='empty';
        $('#btnSelPreWorkCharger').attr('disabled', false);
        $('#btnSelEquipCode').attr('disabled', false);
        $('#btnSelGoods').attr('disabled', false);
		$('#preOutWhsDate').attr('disabled',false);
        $('#barcodeOutputWhsTable').DataTable().clear().draw();
    	$("#barcodeNo").val("");
    	$("#barcodeNo").focus();
		$('#btnSave').addClass('d-none');
		$('#btnCancel').addClass('d-none');
    });	
    
    // 등록 처리
    $('#btnSave').on('click', function() {
    	if ( !$.trim($('#preOutWhsDate').val()) ) {
            toastr.warning('출고일을 확인해 주세요.');
            return false;
        }
        if ( !$.trim($('#preWorkCharger').val()) ) {
            toastr.warning('담당자를 선택해 주세요.');
            $('#btnSelPreWorkCharger').focus();
            return false;
        }
        //if ( !$.trim($('#preOutEquipCd').val()) ) {
        //    toastr.warning('설비명를 선택해 주세요.');
        //    $('#btnSelEquipCode').focus();
        //    return false;
        //}
        //if ( !$.trim($('#preOutGoodsCd').val()) ) {
        //	$('#btnSelGoods').focus();            	
        //    toastr.warning('제품을 선택해 주세요.');
        //    return false;
        //}
        var outputBoxCnt = $('#barcodeOutputWhsTable').DataTable().data().count();
        if(outputBoxCnt == 0) {
            toastr.warning('바코드정보를 입력해 주세요.');
            $('#barcodeNo').focus();        
            return false;			
        }
        
        if ( factoryCode == "003" && $('#floorGubun').val() == "" ) {
            toastr.warning('층 구분자를 선택해주세요.');
            $('#floorGubun').focus();
            return false;
        }

        $('#my-spinner').show();
        
    	createBarcodeNo();
    	
		$.ajax({
			url: '<c:url value="/io/matrlPreOutWhsDataUpdate"/>',
			type: 'POST',
			data: JSON.stringify(barcodeNoList),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			beforeSend: function() {
				//$('#btnAddConfirm').addClass('d-none');
				//$('#btnAddConfirmLoading').removeClass('d-none');
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기
					$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
					$('#barcodeOutputWhsTable').DataTable().clear().draw();
					$('#preOutWhsDate').val(moment(data.preOutWhsDate).format("YYYY-MM-DD"));
					$("#barcodeNo").val("");
					$("#barcodeNo").focus();
					$('#preOutWhsDate').attr('disabled',false);
					$('#btnSave').addClass('d-none');
					$('#floorGubun').val("");
					toastr.success('출고 처리 되었습니다.');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
    });


    //삭제 버튼 클릭 시
	$('#btnDel').on('click', function(){

		if($('#matrlInOutWhsTable tbody tr').hasClass('selected') == '') {
			toastr.warning("출고 취소할 항목을 선택해주세요.");
			return false;
		}

		$('#deleteCheckPopupModal').modal('show');
	});


    //삭제모달 확인 버튼 클릭 시
	$('#btnDeleteCheck').on('click', function(){
		if($('#matrlInOutWhsTable tbody tr').hasClass('selected') == '') {
			toastr.warning("출고 취소할 항목을 선택해주세요.");
			return false;
		}
		var deleteBarcodeNo = matrlInOutWhsTable.rows('.selected').data()[0].barcodeNo;
		
		$.ajax({
			url: '<c:url value="/io/matrlPreOutWhsDataDelete_Change"/>',
			type: 'POST',
			data: {
				'barcodeNo' : function(){ return deleteBarcodeNo; }
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					// 보기
					$('#matrlInOutWhsTable').DataTable().ajax.reload(function(){});
					$("#barcodeNo").val("");
					$("#barcodeNo").focus();

					exceptBarcodeNo = exceptBarcodeNo.replace('/'+deleteBarcodeNo,'');
					
					toastr.success('출고 취소되었습니다.');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
				$('#deleteCheckPopupModal').modal('hide');
			}
		});
	});

	

    
    
   	function uiProc(flag)
   	{
        $("#goodsNm").attr("disabled",flag);                
        $("#preWorkChargerNm").attr("disabled",flag);                 
        $("#preOutEquipNm").attr("disabled",flag);   
        $("#preOutGoodsNm").attr("disabled",flag);
   	}

	function compareBarcodeNo(barcodeNo) {
		var result = true;
		$('#barcodeOutputWhsTable tbody tr').each(function(){
		 	var tbarcodeNo= $(this).find('td').eq(2).html();
			if(barcodeNo == tbarcodeNo) {
				result = false;
				return result;
			}
		});

		return result;
	} 

	var barcodeNoList;
	function createBarcodeNo() {
		barcodeNoList = new Array();
		var idx = 0;
		$('#barcodeOutputWhsTable tr').each(function() {
		 	var tbarcodeNo= $(this).find('td').eq(2).html();
		 	var rowData = new Object();
			if(idx > 0) { // tr 첫라인은 헤더정보로 skip
				rowData.menuAuth = menuAuth;
				rowData.preOutWhsDate = $("#preOutWhsDate").val().replace(/-/g, '');
				rowData.preWorkCharger = $("#preWorkCharger").val();
				rowData.preOutEquipCd = $("#preOutEquipCd").val();
				rowData.preOutGoodsCd = $("#preOutGoodsCd").val();
				rowData.matrlCd = $(this).find('td').eq(0).html();
				rowData.preOutQty = $(this).find('td').eq(6).html();
				rowData.barcodeNo = tbarcodeNo;
				
				if( factoryCode == "003" ) {
					rowData.floorGubun = $("#floorGubun").val();	
				}
				
				//rowData.updId = 'upd_id';	
				barcodeNoList.push(rowData);								
			}
			idx++;
		});
		
		return idx;
	}
	
   	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode()
   	{
		if(goodsCdPopUpTable == null || goodsCdPopUpTable == undefined)	{
			goodsCdPopUpTable = $('#goodsCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        pageLength: 15,
		        ajax: {
		            url: '<c:url value="/bm/goodsCodeDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'goodsCd',
		        columns: [
		            { data: 'goodsCd' },
		            { data: 'goodsNm' },
		            { data: 'model' },
		            { data: 'modelNo' },
		            { data: 'alnicuMatrlNm' },
		            { data: 'alnicuMatrlCd' },
		            { data: 'filmMatrlCd' },
		        ],
		        columnDefs: [
		        	{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4,5,6],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#goodsCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = goodsCdPopUpTable.row( this ).data();
                $('#preOutGoodsCd').val(data.goodsCd);
                $('#preOutGoodsNm').val(data.goodsNm);
                $('#goodsPopUpModal').modal('hide');
                var matrlText = "자재코드 : "  +  data.alnicuMatrlCd + " / " + data.filmMatrlCd;
            	$('#matrlCdText').text(matrlText) 
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}

		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료

   	//설비코드조회 팝업 시작
   	var equipCdPopUpTable;
   	function selectEquipCode()
   	{
		if(equipCdPopUpTable == null || equipCdPopUpTable == undefined)	{
			equipCdPopUpTable = $('#equipCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="bm/equipCodeAdmDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'equipCd',
		        columns: [
		            { data: 'equipCd' },
		            { data: 'equipNm' },
		            { data: 'equipGroupNm' },
		            { data: 'equipCtrgyNm' },
		            { data: 'modelNm' },
		            { data: 'mfcDealCorpNm' },		            
		        ],
		        columnDefs: [
		        	//{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4],  "className": "text-center"}
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#equipCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = equipCdPopUpTable.row( this ).data();
                $('#preOutEquipCd').val(data.equipCd);
                $('#preOutEquipNm').val(data.equipNm);
                $('#equipPopUpModal').modal('hide');
		    });
		} else{
			$('#equipCdPopUpTable').DataTable().ajax.reload();
		}

		$('#equipPopUpModal').modal('show');		
   	}
  	//설비코드조회 팝업 종료

   	//담당자조회 팝업 시작
   	var userPopUpTable;
   	function selectPreWorkCharger() {
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'userNumber',
		        columns: [
						{ data : 'userNm'}, 
						{ data : 'departmentNm'	}, 
						{ data : 'postNm' }, 
						{ data : 'chargrDutyNm'	}, 
						{ data : 'teamNm' }, 
						{ data : 'workplaceNm' },
		        ],
		        columnDefs: [
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],
		        oSearch: {"sSearch": userNm},
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
                $('#preWorkCharger').val(data.userNumber);
                $('#preWorkChargerNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');
                $('#barcodeNo').select();
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		$('#userPopUpModal').modal('show');	
   	}

   	var exceptSelectModalBarcodeNo ='empty';	//모달 바코드 선택 시
   	var barcodePopUpTableRowId ='';				//모달 바코드 값 담아줌
   	var barcodeFifoCheckTableInWhsDate = '';	//바코드 관련 선입선출 날짜 담아주는 값(찾기 버튼에 사용되는 값)
   	var barcodeFifoCheckTableCount = 0;			//바코드 관련 선입선출 테이블 개수

   	var startDate	= '${serverDateFrom}';
 	var endDate		= '${serverDateTo}';
   	
  	//바코드관련 조회
  	var barcodePopUpTable;	
  	var saveClickDataArray = new Array();	//데이터 값 클릭 시 담아주는 값
  	
	function selectBarcode(){
		if ( !$.trim($('#preWorkCharger').val()) ) {
             toastr.warning('담당자를 선택해 주세요.');
             $('#btnSelPreWorkCharger').focus();
             return false;
		}

		startDate = "${serverDateFrom}";
        inWhsDate = "${serverDateTo}";

		/*if ($('#barcodeAllPopUpRetv').prop('checked')) {
			inWhsDate = '';
		} else {
			inWhsDate = "${serverDateTo}";
		}*/
				
        barcodeFifoCheckTableInWhsDate='';
        $('#btnBarcodeFifoCheckSearch').attr('disabled', true);
  	  	 
		if(barcodePopUpTable == null || barcodePopUpTable == undefined)	{
			barcodePopUpTable = $('#barcodePopUpTable').DataTable({
		        dom : "<'row'<'col-sm-12 col-md-8'><'col-sm-12 col-md-2'f>>"
	        		+ "<'row'<'col-sm-12'tr>>"
	        		+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		        language: lang_kor,
		        lengthChange : true,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        pageLength: -1,
		        /*select: {
		            style: 'multi',
		            toggleable: true,
		            items: 'row'
		        },*/
		        ajax: {
		            url: '<c:url value="/io/matrlInOutWhsPreDataList"/>',
		            type: 'GET',
		            data: {
			           	'menuAuth'	 		: 		menuAuth,
// 			           	'inWhsDate'			: 		function() { return inWhsDate.replace(/-/g, ''); },
						'startDate'			: 		function() { return startDate.replace(/-/g, '');	},
						'endDate'			: 		function() { return inWhsDate.replace(/-/g, '');	},
			           	'inApprovalCd'		: 		function() { return "001/009";			},
			           	'statusCd'			: 		function() { return "A";				},
			           	'exceptBarcodeNo'	:		function() { return exceptBarcodeNo;	}
		            },
		        },
		        rowId: 'barcodeNo',
		        columns: [
		        	{ data: 'preInWhsDate',
		                render: function(data, type, row) {
		                	if(data != "" && data != null) {
								return moment(data).format("YYYY-MM-DD");
							} else {
								return "-";
							}
		                }
		            },	//가입고일
		        	{ data: 'statusNm'			},	//자재상태
		        	{ data: 'matrlCd' 			},	//자재코드
		        	{ data: 'matrlNm' 			},	//자재명
		        	{ data: 'barcodeNo' 		},	//바코드
		        	{ data: 'spplyDealCorpNm'	},	//공급업체
		        	{ data: 'inWhsDate',
		                render: function(data, type, row) {
		                	if(data != "" && data != null) {
								return moment(data).format("YYYY-MM-DD");
							} else {
								return "-";
							}
		                }
		            },	//입고일
		            { data: 'inWhsDesc'	},	//비고
		        	
		        ],
		        columnDefs: [
		        	{ "targets": ['_all'],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });

			var data ='';
			barcodePopUpTableRowId ='';

			saveClickDataArray = new Array();
			
			//자재입고 조회 목록 클릭 시
		    $('#barcodePopUpTable tbody').on('click', 'tr', function () {
		    	obj = new Object();

		    	barcodePopUpTableRowId = $(this).attr('id');
		    	
		    	//묶음출하 버튼 클릭되어있을 때 예외처리
				if ($('#barcodePopUpBundleOut').prop('checked')) {
					//선택이 안되어있을 때 실행-----------------------
// 					if(!$('#barcodePopUpTable tbody tr').hasClass('selected')==''){
// 					console.log(saveClickDataArray);
					if(saveClickDataArray != ''){
						//선택되어있는 row가 아닐때
						if(!$('#'+barcodePopUpTableRowId).hasClass('selected')){
							//기존 값과 다른 값을 클릭했을 때
							if(data.inWhsDate != barcodePopUpTable.row(this).data().inWhsDate || data.matrlCd != barcodePopUpTable.row(this).data().matrlCd){
								$('#'+barcodePopUpTableRowId).attr('style','background-color: red; color: white;');
								$('#barcodePopUpTable').attr('style', 'pointer-events : none;');
								
								toastr.warning("동일한 입고일과 자재코드를 선택해주세요.", {timeOut: 5000});
								
								setTimeout(function(){
									$('#'+barcodePopUpTableRowId).attr('style','');
									$('#barcodePopUpTable').attr('style', '');
								},150);
								return false;
							}else{
								saveClickDataArray.push(barcodePopUpTableRowId);
							}
						}else{
							for(let i = 0; i < saveClickDataArray.length; i++) {
								if(saveClickDataArray[i] === barcodePopUpTableRowId)  {
									saveClickDataArray.splice(i, 1);
								    i--;
							  	}
							}
						}
					}else{
						//페이징 넘어 갔을 경우 처리
						saveClickDataArray.push(barcodePopUpTableRowId);
					}
				}
				//묶음출하 버튼 클릭되어있을 때 예외처리 끝
				
				barcodeFifoCheckTableInWhsDate = '';
				data = barcodePopUpTable.row(this).data();
				bundleOutSelect(barcodePopUpTableRowId);
				
				if($('#'+barcodePopUpTableRowId).hasClass('selected')){
					//사용시간 권고 함수
					twelveTimeCalc(barcodePopUpTable.row(this).data().inWhsTime);
				}
				
				$('#btnBarcodeFifoCheckSearch').attr('disabled', true);

				//선입선출 상세보기
				$.ajax({
					url : '<c:url value="/io/matrlPreOutWhsData"/>',
					type : 'GET',
					data : {
						'menuAuth'	 		: 		menuAuth,
	                	'barcodeNo'   		:       function() { return data.barcodeNo;		},
	                	'exceptBarcodeNo'	:		function() { return exceptBarcodeNo;	}
					},
					success : function(res) {
// 						console.log(res)
						let data = res.data;

						if (res.result == 'ok') {
							barcodeFifoCheckTableReload();
							barcodeFifoCheckTableCount = 0;

							//선입선출 대상이 없어도 모달 나오게 설정 해주는 코드
							/*$('#barcodeFifoCheckContent').fadeIn(300);
    						$('#barcodePopUpContent').attr('style', 'margin-left: 20%;width: 77vh;');
    						$('#barcodeFifoCheckContent').attr('style', 'margin-left: -25%;width: 55vh;');*/
							
	                    } else if (res.result == 'fail') {
	                    	toastr.warning(res.message, '', {timeOut: 5000});
	                    } else if (res.result == 'error') {
	                    	toastr.error(res.message, '', {timeOut: 5000});
	                    } else {
	                        if(res.result == 'before') {
		                       	if(!compareBarcodeNo(res.barcode)) { //이전 바코드가 추가 되어 있는지 체크
		    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
	    	                        $('#barcodeNo').val('');
	    	                        $('#barcodeNo').focus();
		                		} else {

									if(!$("#"+barcodePopUpTableRowId).hasClass('selected')){
			                			barcodeFifoCheckTableReload();
				                	}else{
				                		barcodeFifoCheckTableCount = res.barcode.length;
				                		//선입선출 대상 모달
										$('#barcodeFifoCheckTable tbody').empty();
			                			$('#barcodeFifoCheckLabel').text("*선출하 대상은 "+res.barcode.length+"개 입니다.");
			    						for(var i=0; i<res.barcode.length; i++){
			    							var rtn = '<tr><td style="text-align: center;">'+res.barcode[i].matrlCd+'</td>';
			    								rtn += '<td style="text-align: center;">'+res.barcode[i].matrlNm+'</td>';
			    								rtn += '<td style="text-align: center;">'+res.barcode[i].barcodeNo+'</td>';
			    								rtn += '<td style="text-align: center;">'+moment(res.barcode[i].inWhsDate).format('YYYY-MM-DD');'</td></tr>';
			    							$('#barcodeFifoCheckTable tbody').append(rtn);
			    						}
			    						
// 			    						$('#barcodeFifoCheckContent').fadeIn(300);
// 			    						$('#barcodePopUpContent').attr('style', 'margin-left: 20%;width: 82vh;');
// 			    						$('#barcodeFifoCheckContent').attr('style', 'margin-left: -25%;width: 55vh;');
			    						//선입선출 대상 모달 끝
					                }
		                		}
		                    } else {
		                    	toastr.error(res.warning, '', {timeOut: 5000});
		                    }
	                    }
					}
// 					complete : function() {
// 						$('#itemPartInspectTable').DataTable().ajax.reload();
// 					}
				});
				
		    });

		    //팝업 출하버튼 클릭 시
		    $(document).on('click','#btnBarcodeAdd',function(e){
		    	if($('#barcodePopUpTable tbody tr').hasClass('selected') == '') {
					toastr.warning("출하할 항목을 선택해주세요.");
					return false;
				}

		    	//선입 선출이 존재할 때 실행
		    	if ($('#barcodePopUpBundleOut').prop('checked')) {
		    		//묶음출고
		    		if(barcodeFifoCheckTableCount !=0){
						toastr.warning("선입선출된 자재를 먼저 출하해주세요!");
						return false;
		    		}else{
		    			//선입 항목 클릭 시
		    			var array	= new Array();
		    			var obj		= new Object();
		    			let data	= barcodePopUpTable.rows('.selected').data();
// 		    			console.log(data);
		    			
						for(var i=0; i<data.length; i++){
							obj	= new Object();
							obj.barcodeNo	= data[i].barcodeNo;
							obj.approvalCd	= data[i].approvalCd;	//승인 상태
							obj.statusCd	= data[i].statusCd;		//자재 상태
							obj.fifoCheck	= data[i].fifoCheck;	//선입선출 여부
							array.push(obj);
						}
// 						console.log(array);
						
						var arrayData = JSON.stringify(array);

						//ajax
						$.ajax({
			            	url: '<c:url value="/io/matrlPreOutWhsDataSuwan"/>',
			                type: 'GET',
			                data: {
			                	'menuAuth'	 		: 	menuAuth,
			                	'arrayData' 		:	function() { return arrayData; 			},
			                	'exceptBarcodeNo'	:	function() { return exceptBarcodeNo;	}
			                },
			                beforeSend: function() {
			                  //  $('#btnAddConfirm').addClass('d-none');
			                },
			                success: function (res) {
			                	$('#my-spinner').show();
// 			                	let data = res.data;
			                    let data = res.receiveValue;
			                    if (res.result == 'ok') {
									//보기
									for(var i=0; i<data.length; i++){
										$('#matrlCd').val(data[i].matrlCd);
										$('#matrlNm').val(data[i].matrlNm);
										$('#goodsNmList').val(data[i].goodsNmList);
										$('#qutyNm').val(data[i].qutyNm);
										$('#inspectQty').val(data[i].inspectQty);
										$('#preOutQty').val(data[i].remainQty);
										$('#preBarcodeNo').val(data[i].barcodeNo);
										$('#barcodeNo').val('');
										$('#barcodeNo').focus();
										$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
										exceptBarcodeNo += "/" + data[i].barcodeNo;	//스캔한 바코드 값 담아주기.
									}

									$('#btnSave').removeClass('d-none');
									$("#btnSave").attr("disabled", false);
									$('#btnCancel').removeClass('d-none');
									$('#btnSelPreWorkCharger').attr('disabled', true);
									$('#btnSelEquipCode').attr('disabled', true);
									$('#btnSelGoods').attr('disabled', true);
									$('#preOutWhsDate').attr('disabled',true);
									$('#barcodePopUpModal').modal('hide');
									toastr.success("추가되었습니다.");
									
			                    } else if (res.result == 'fail') {
			                    	toastr.warning(res.message, '', {timeOut: 5000});
			                    } else if (res.result == 'error') {
			                    	toastr.error(res.message, '', {timeOut: 5000});
			                    } else if(res.result == 'changeData'){
			                    	toastr.warning(res.message, '', {timeOut: 5000});
			                    }else {
			                    	if(res.result == 'before') {
				                       	if(!compareBarcodeNo(res.barcode)) {
				    	                    toastr.warning("선입선출된 자재를 먼저 출하해주세요!", '', {timeOut: 5000});
			    	                        $('#barcodeNo').val('');
			    	                        $('#barcodeNo').focus();
				                		} else {
			 	                			toastr.warning(res.message, '', {timeOut: 5000});
				                		}
				                    } else {
				                    	toastr.error(res.warning, '', {timeOut: 5000});
				                    }
								}
				             },
				            complete:function(){
				            	$('#my-spinner').hide();
							}
				        });
						//ajax
			    	}
					
			    }else{
				    //개별출고
					if(barcodeFifoCheckTableCount !=0){
						toastr.warning("선입선출 대상이 존재합니다.");
						return false;
					}else{
						$('#barcodeNo').val(data.barcodeNo);
		                $('#barcodePopUpModal').modal('hide');
					}
			    }
		    });

		    //모달 닫기 버튼 클릭 시
		    $('#btnBarcodeClase').on('click', function(){
		    	data ='';
		    	saveClickDataArray = new Array();
		    	$('#barcodeNo').val('');
		    	$("#barcodeNo").focus();
		    	$('#barcodePopUpModal').modal('hide');
			});

		    $('#barcodePopUpModal').on('hidden.bs.modal', function (e) {
			    if($('#barcodeNo').val().replaceAll(' ', '') != ''){
			    	$("#barcodeNo").focus();
					keypress("barcodeNo", "13");
				}else{
					$('#barcodeNo').val('');
				}
			    saveClickDataArray = new Array();
			});
		    
		} else{
			$('#barcodePopUpTable').DataTable().ajax.reload();
		}
		/* var rtn = '<div class="row">';
			rtn += '<label class="input-label-sm mr-0">입고일</label><input type="date" class="form-control ml-2 mr-2" style="width: 130px;" id="barcodePopUpDate">';
			rtn += '<button type="button" class="btn btn-primary" id="barcodePopUpRetv">조회 </button>';
			rtn += '<input type="checkBox" style="margin-top:2px;margin-right:3px;width: 20px;height: 20px; margin-left:15px;" id="barcodeAllPopUpRetv" checked><label class="input-label-sm">전체 조회</label>';
			rtn += '<input type="checkBox" style="margin-top:2px;margin-right:3px;width: 20px;height: 20px;" id="barcodePopUpBundleOut" checked><label class="input-label-sm">묶음 출하</label>';
			rtn += '<button type="button" class="btn" style="color: white; background-color: #04a304;" id="btnReset">선택 초기화</button>';
			rtn += '</div>';
	  	$('#barcodePopUpTable_length').html(rtn); */
	  	$('#startDate').val(startDate);
	  	$('#barcodePopUpDate').val(inWhsDate);

	  	$('#barcodePopUpTable_filter').find('input[type=search]').eq(0).attr('id', 'pagefilter');
		$("#pagefilter").insertAfter("#btnReset");
		$('#barcodePopUpTable_filter').find('label').eq(0).remove();
		$("#pagefilter").removeClass('custom-select custom-select-sm form-control form-control-sm');
		$("#pagefilter").addClass('custom-select ml-2');
		$('#pagefilter').attr('style', 'margin-top: 12px; width: 18vh;');
	  	
		$('#barcodePopUpContent').attr('style', 'margin-left: 20%;width: 82vh;');
		$('#barcodeFifoCheckContent').attr('style', 'margin-left: -25%;width: 55vh;');
		
		barcodeFifoCheckTableReload();
		
		$('#barcodePopUpModal').modal({backdrop: 'static'});
	  	$('#barcodePopUpModal').modal('show');
   	}

   	//조회
	$(document).on('click','#barcodePopUpRetv',function(e){

		if($('#startDate').val() == ""){
			toastr.warning("입고일을 입력해주십시오.");
			$('#startDate').focus();
			return false;
		}
		if($('#barcodePopUpDate').val() == ""){
			toastr.warning("입고일을 입력해주십시오.");
			$('#barcodePopUpDate').focus();
			return false;
		}

		let dateFrom	= new Date($('#startDate').val());
		let dateTo		= new Date($('#barcodePopUpDate').val());
		let dateDiff	= Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#preOutWhsDateFromCalendar').focus();
			return false;
		}
		
    	/*preOutWhsDateFromCal =  $('#preOutWhsDateFrom').val();
    	preOutWhsDateToCal	=  $('#preOutWhsDateTo').val();
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#matrlInOutWhsTable').DataTable().ajax.reload( function () {});
		equipGroup = "";*/


		
		saveClickDataArray = new Array();
		if($('#barcodePopUpDate').val() != ''){
			inWhsDate = $('#barcodePopUpDate').val();
			startDate = $('#startDate').val();
			$("#barcodeAllPopUpRetv").prop("checked", false);
	   		$('#barcodePopUpTable').DataTable().ajax.reload();
		}else{
			$("#barcodeAllPopUpRetv").prop("checked", true);
		}
   	});

   	//전체 조회
	$(document).on('click','#barcodeAllPopUpRetv',function(e){
		if ($(this).prop('checked')) {
			inWhsDate = '';
			$('#barcodePopUpDate').val('');
			$('#startDate').val('');
		} else {
			$('#barcodePopUpDate').val("${serverDateTo}");
			$('#startDate').val("${serverDateFrom}");
			inWhsDate = $('#barcodePopUpDate').val();
			startDate = $('#startDate').val();
		}
		saveClickDataArray = new Array();
   		$('#barcodePopUpTable').DataTable().ajax.reload();
   	});

   	//묶음 출하 Check 여부에 따라 선택할 수 있게 적용
   	function bundleOutSelect(name){
   	   	//묶음이 선택 되어있을 때
		if ($('#barcodePopUpBundleOut').prop('checked')) {
			//barcodePopUpTable tr이 클릭 되어있지 않을때
			if(!$("#"+name).hasClass('selected')){
				$("#"+name).addClass('selected');
			}else{
				$("#"+name).removeClass('selected');
			}
		} else {
			//묶음이 선택되어있지 않을 때
			$('#barcodePopUpTable tbody').find($('tr.selected')).removeClass('selected');
			$("#"+name).addClass('selected');
		}
	}
	
   	//묶음 출하 checkBox 클릭 시
	$(document).on('change','#barcodePopUpBundleOut',function(e){
		saveClickDataArray = new Array();
		$('#barcodePopUpTable tbody').find($('tr.selected')).removeClass('selected');
		barcodeFifoCheckTableReload();
   	});

   	//선택 초기화 버튼 클릭 시
	$(document).on('click','#btnReset',function(e){
		$('#barcodePopUpTable tbody').find($('tr.selected')).removeClass('selected');
		$('#btnBarcodeFifoCheckSearch').attr('disabled', true);
		saveClickDataArray = new Array();
		barcodeFifoCheckTableReload();
	});
	

   	//barcodeFifoCheckTable 새로고침
   	function barcodeFifoCheckTableReload() {
		$('#barcodeFifoCheckTable tbody').empty();
		$('#barcodeFifoCheckLabel').text("*선출하 대상은 0개 입니다.");
		
		var rtn = '<tr><td colspan="4" style="text-align: center;">데이터가 없습니다.</td></tr>';
		$('#barcodeFifoCheckTable tbody').append(rtn);
	}

   	//바코드 관련 선입선출모달 열기버튼 클릭 시
	$(document).on('click','#barcodeFifoCheckOpen',function(e){
		barcodeFifoCheckTableInWhsDate='';
		$('#btnBarcodeFifoCheckSearch').attr('disabled', true);
		$('#barcodeFifoCheckOpen').fadeOut(150);
		$('#barcodeFifoCheckContent').fadeIn(300, function(){});
		$('#barcodePopUpContent').attr('style', 'margin-left: 20%;width: 82vh;');
		$('#barcodeFifoCheckContent').attr('style', 'margin-left: -25%;width: 55vh;');
	});

	//바코드 관련 선입선출모달 닫기버튼 클릭 시
	$(document).on('click','#barcodeFifoCheckClose',function(e){
		barcodeFifoCheckTableInWhsDate='';
// 		$('#barcodeFifoCheckOpen').attr('style', 'display: none;');
		$('#barcodeFifoCheckOpen').fadeIn(200);
		$('#btnBarcodeFifoCheckSearch').attr('disabled', true);
		$('#barcodeFifoCheckContent').fadeOut(300, function(){
			$('#barcodeFifoCheckContent').attr('style', 'display: none;');
			$('#barcodePopUpContent').attr('style', 'margin-left: 40%;width: 82vh;');
		});
	});

	//선입선출 대상 목록 클릭 시
   	$('#barcodeFifoCheckTable tbody').on('click', 'tr', function(){
   		$('#barcodeFifoCheckTable tbody tr').attr('style','');
		$(this).attr('style', "background-color: #0275d8; color: white;");
		$('#btnBarcodeFifoCheckSearch').attr('disabled', false);
		
		barcodeFifoCheckTableInWhsDate =  $(this).find('td').eq(3).text();
   	});

   	//바코드 관련 선입선출모달 찾기 버튼 클릭 시
	$(document).on('click','#btnBarcodeFifoCheckSearch',function(e){
		saveClickDataArray = new Array();
		inWhsDate = barcodeFifoCheckTableInWhsDate;
		startDate = barcodeFifoCheckTableInWhsDate;
	  	$('#barcodePopUpDate').val(inWhsDate);
	  	$('#startDate').val(startDate);
		$("#barcodeAllPopUpRetv").prop("checked", false);
   		$('#barcodePopUpTable').DataTable().ajax.reload();
	});

	
	//선입선출 테이블 조회
	let goodsFifoCheckTable = $('#goodsFifoCheckTable').DataTable({
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        searching: false,
        ajax: {
            url: '<c:url value="/io/preOutWhsFifoCheck"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
            	'barcodeNo'			:	function() {return goodsFifoCheckBarcodeNo;	},
            	'exceptBarcodeNo'	:	function() { return exceptBarcodeNo; 		}
             },
        },
        rowId: 'barcodeNo',
        columns: [
            { data: 'matrlCd'	},
            { data: 'matrlNm'	},
            { data: 'barcodeNo'	},
            { data : 'inWhsDate',
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			}
        ],
        columnDefs: [
        	{ targets: [0,1,2,3], className: 'text-center' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
    });
   	
	var goodsFifoCheckTableBarcodeNo ='';
	var goodsFifoCheckTableMatrCd='';
	var goodsFifoCheckTableInWhsDate='';
	var goodsFifoCheckTableCount=0;
	
	//선입선출 대상 목록 클릭 시
   	$('#goodsFifoCheckTable tbody').on('click', 'tr', function(){

		var fifoCheckRowId = $(this).attr('id');

		//선택이 안되어있을 때 실행
		if(!$('#goodsFifoCheckTable tbody tr').hasClass('selected')=='') {
			//선택되어있는 row가 아닐때
			if(!$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
				//기존 값과 다른 값을 클릭했을 때
				if(goodsFifoCheckTableMatrCd != $(this).find('td').eq(0).text() || goodsFifoCheckTableInWhsDate != $(this).find('td').eq(3).text()){
					
					$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).attr('style','background-color: red; color: white;');
					$('#goodsFifoCheckTable').attr('style', 'pointer-events : none;');
					
					toastr.warning("동일한 입고일과 자재코드를 선택해주세요.", {timeOut: 5000});
					
					setTimeout(function(){
						$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).attr('style','');
						$('#goodsFifoCheckTable').attr('style', '');
					},150);
					return false;
				}
			}
		}

		//선입선출 검사
		$.ajax({
			url : '<c:url value="/io/matrlPreOutWhsData"/>',
			type : 'GET',
			data : {
				'menuAuth'	 		: 		menuAuth,
            	'barcodeNo'   		:       function() { return $('#goodsFifoCheckTable').find('#'+fifoCheckRowId).find('td').eq(2).text();	},
            	'exceptBarcodeNo'	:		function() { return exceptBarcodeNo;	}
			},
			success : function(res) {
				let data = res.data;
// 				console.log(data);

				if (res.result == 'ok') {
					goodsFifoCheckTableCount = 0;			//선입선출 대상이 존재하는지 검사
                } else if (res.result == 'fail') {
                	toastr.warning(res.message, '', {timeOut: 5000});
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                } else {
                    if(res.result == 'before') {
                       	if(!compareBarcodeNo(res.barcode)) { //이전 바코드가 추가 되어 있는지 체크
    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
	                        $('#barcodeNo').val('');
	                        $('#barcodeNo').focus();
                		} else {
							if($('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
								toastr.warning("선입선출된 자재("+res.barcode[0].barcodeNo+")를 먼저 선택해주세요", {timeOut: 5000});
		                		goodsFifoCheckTableCount = res.barcode.length;	//선입선출 대상이 존재하는지 검사
			                }
                		}
                    } else {
                    	toastr.error(res.warning, '', {timeOut: 5000});
                    }
                }
			}
		});
		//선입선출 검사

		goodsFifoCheckTableMatrCd		=  $(this).find('td').eq(0).text();	// 자재코드
		goodsFifoCheckTableInWhsDate	=  $(this).find('td').eq(3).text();	//입고일
		
		if(!$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
			$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).addClass('selected');
			twelveTimeCalc(goodsFifoCheckTable.row(this).data().inWhsTime);
		}else{
			$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).removeClass('selected');
		}

   	   goodsFifoCheckTableBarcodeNo =  $(this).find('td').eq(2).text();
   	});

   	//선입선출 출하버튼 클릭 시
	$('#btnGoodsFifoAdd').on('click', function(){
		if(!$('#goodsFifoCheckTable tbody tr').hasClass('selected')) {
			toastr.warning("출하할 항목을 선택해주세요.");
			return false;
		}

		//묶음출고
		if(goodsFifoCheckTableCount !=0){
			toastr.warning("선입선출 대상이 존재합니다.");
			return false;
			
		}else{
			
			//선입 항목 클릭 시
			var array	= new Array();
			var obj		= new Object();
			let data	= goodsFifoCheckTable.rows('.selected').data();
// 			console.log(data);
			
			for(var i=0; i<data.length; i++){
				obj		= new Object();
				obj.barcodeNo = data[i].barcodeNo;
				array.push(obj);
			}
			
			var arrayData = JSON.stringify(array);

			//ajax
			$.ajax({
            	url: '<c:url value="/io/matrlPreOutWhsDataSuwan"/>',
                type: 'GET',
                data: {
                	'menuAuth'	 		: 	menuAuth,
                	'arrayData' 		:	function() { return arrayData; 			},
                	'exceptBarcodeNo'	:	function() { return exceptBarcodeNo;	}
                },
                beforeSend: function() {
                  //  $('#btnAddConfirm').addClass('d-none');
                },
                success: function (res) {
                	$('#my-spinner').show();
//	                	let data = res.data;
                    let data = res.receiveValue;
                    if (res.result == 'ok') {
						//보기
						for(var i=0; i<data.length; i++){
							$('#matrlCd').val(data[i].matrlCd);
							$('#matrlNm').val(data[i].matrlNm);
							$('#goodsNmList').val(data[i].goodsNmList);
							$('#qutyNm').val(data[i].qutyNm);
							$('#inspectQty').val(data[i].inspectQty);
							$('#preOutQty').val(data[i].remainQty);
							$('#preBarcodeNo').val(data[i].barcodeNo);
							$('#barcodeNo').val('');
							$('#barcodeNo').focus();
							$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
							exceptBarcodeNo += "/" + data[i].barcodeNo;	//스캔한 바코드 값 담아주기.
						}

						$('#btnSave').removeClass('d-none');
						$("#btnSave").attr("disabled", false);
						$('#btnCancel').removeClass('d-none');
						$('#btnSelPreWorkCharger').attr('disabled', true);
						$('#btnSelEquipCode').attr('disabled', true);
						$('#btnSelGoods').attr('disabled', true);
						$('#barcodePopUpModal').modal('hide');
						toastr.success("추가되었습니다.");
						
                    } else if (res.result == 'fail') {
                    	toastr.warning(res.message, '', {timeOut: 5000});
                    } else if (res.result == 'error') {
                    	toastr.error(res.message, '', {timeOut: 5000});
                    } else {
                    	if(res.result == 'before') {
	                       	if(!compareBarcodeNo(res.barcode)) {
	    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
    	                        $('#barcodeNo').val('');
    	                        $('#barcodeNo').focus();
	                		} else {
 	                			toastr.warning(res.message, '', {timeOut: 5000});
	                		}
	                    } else {
	                    	toastr.error(res.warning, '', {timeOut: 5000});
	                    }
					}
	             },
	            complete:function(){
	            	$('#my-spinner').hide();
				}
	        });
			//ajax
    	}
		
//    		$('#barcodeNo').val(goodsFifoCheckTableBarcodeNo);
   		$('#goodsFifoCheckPopupModal').modal('hide');
	});

	$('#goodsFifoCheckPopupModal').on('hidden.bs.modal', function (e) {
		if($('#barcodeNo').val().replaceAll(' ', '') != ''){
	    	$("#barcodeNo").focus();
			keypress("barcodeNo", "13");
		}else{
			$('#barcodeNo').val('');
		}
	});
  	
   	//바코드 스캔을 위해 포커스 고정
   	$("#barcodeNo").val("");
   	$("#barcodeNo").focus();
   	
   	
   	
   	
   	//12시간 더한 시간 구하는 코드
   	function twelveTimeCalc(inWhsDate) {
   		
   		if( inWhsDate == "" || inWhsDate == null ) {
			return false;
		}
   		
   		let date	= new Date()
   		let year	= date.getFullYear();
   		let month	= ('0' + (date.getMonth() + 1)).slice(-2);
   		let day		= ('0' + date.getDate()).slice(-2);
   		let hours	= ('0' + date.getHours()).slice(-2);
   		let minutes	= ('0' + date.getMinutes()).slice(-2);
   		let nowDate = year + '-' + month + '-' + day + 'T' + hours  + ':' + minutes;

   		// Date 객체를 생성하여 주어진 시간 문자열을 파싱
   		let dateTime = new Date(inWhsDate);

   		// 시간을 12시간 더함
   		dateTime.setHours(dateTime.getHours() + 12);

   		// 시간과 분을 문자열로 변환하여 2자리로 맞춤
   		let newHour = dateTime.getHours().toString().padStart(2, '0');
   		let newMinute = dateTime.getMinutes().toString().padStart(2, '0');

   		// 날짜를 문자열로 변환하여 2자리로 맞춤
   		let newMonth = (dateTime.getMonth() + 1).toString().padStart(2, '0');
   		let newDay = dateTime.getDate().toString().padStart(2, '0');

   		// 최종 결과 문자열 생성
   		let resultTimeStr = dateTime.getFullYear() + '-' + newMonth + '-' + newDay + 'T' + newHour + ':' + newMinute;
   		
   		
   		//시간 판별
   		let a = nowDate;
		let b = resultTimeStr;
		let minDiff = moment.duration(moment(a).diff(moment(b))).asMinutes();
		
		/*if (minDiff >= 0) {
			//console.log(b + '의 시간이 '+ a +'를 기준으로 "'+ timeChange(minDiff) +'" 분이 지났습니다.');
			toastr.success(timeChange(minDiff) +' 지났습니다.');
		} else {
			//console.log(b + '의 시간이 '+ a +'를 기준으로 "'+ timeChange(Math.abs(minDiff)) +'" 분이 남았습니다.');
			//toastr.warning(timeChange(Math.abs(minDiff)) +' 남았습니다.');
			toastr.warning(timeChange(Math.abs(minDiff)) +' 후 사용을 권고합니다.');
		}*/
		
		if (minDiff < 0) {
			toastr.warning(timeChange(Math.abs(minDiff)) +' 후 사용을 권고합니다.');
		}
   	}
   	
   	//분 -> 시간/일자로 변환
	function timeChange(min) {
   	    let days = Math.floor(min / 60 / 24);
   	    let hours = Math.floor((min - (days * 60 * 24 )) / 60);
   	    let mins = min - (days * 60 * 24) - (hours * 60);
   	 
   	    let daysStr = days;
   	    let hourStr = (hours > 9)? hours : '0' + hours;
		let minStr = (mins > 9)? mins : '0' + mins;
   	    
   		if( daysStr > 0 ) {
   			return daysStr + ' 일 ' + hourStr + '시간 ' + minStr + '분';
   		} else if( hourStr > 0 ) {
   			return hourStr + '시간 ' + minStr + '분';
   		} else {
   			return minStr + '분';
   		}
   	}
   	
   	
  	
</script>

</body>
</html>