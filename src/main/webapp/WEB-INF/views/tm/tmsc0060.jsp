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
				<li class="breadcrumb-item active">제품(초기재고)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-sidebar" id="left-list" style="width:61%;">
                      <div class="card">
                        <div class="open-arrow" id="arrowLeft">
                            <button  id="left-width-btn" onclick="openrNav();openrNav2After()"  class="btn btn-primary input-sub-search" type="button">
                            <i class="mdi mdi-arrow-left"></i>
                            </button>
                        </div>
                        <div class="table-responsive">
		                    <table id="preGoodsInventoryTable" class="table table-bordered">
		                        <thead class="thead-light">
			                        <tr>
			                        	<th>재고년월</th>
			                            <th>구분</th>	                        
			                            <th>제품명</th>
			                            <th>모델NO</th>
			                            <th>재질</th>
			                            <th>규격</th>
			                            <th>BOX</th>
			                            <th>EA</th>
			                        </tr>
		                        </thead>
		                        <tfoot>
									<tr>
										<td colspan="6" style="text-align: center">합계</td>
										<td id="sumBox" style="text-align: right">0</td>
										<td id="sumEa" style="text-align: right">0</td>
									</tr>
								</tfoot>
		                    </table>
                        </div>
                      </div>
                  </div><!-- /.left-list -->
                  <!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="right-list right-sidebar" id="myrSidenav" style="width:38%;">
					<div id="formBox">
                   		<!--오른쪽 등록 부분 상단 버튼 영역-->
                        <div class="card-body col-sm-12">
                              <div class="rightsidebar-close">
                                   <a href="javascript:void(0)"  id="left-expand" class="closebtn float-right" onclick="closerNav();closerNav2After()"><i class="mdi mdi-close"></i></a>
                              </div>
                            <!-- <button type="button" class="btn btn-primary float-right" id="btnForword">마감</button>  -->                             
                            <button type="button" class="btn btn-danger float-right mr-1" id="btnMinus" disabled>삭제</button>
                            <button type="button" class="btn btn-warning float-right mr-1" id="btnPlus" disabled>추가</button>
                            <button type="button" class="btn btn-primary float-left mr-1" id="btnPrint" disabled>인쇄</button>
                            <button type="button" class="btn btn-primary float-right mr-1" id="btnAdd">등록</button>
                        </div>	
                   		<!--/오른쪽 등록 부분 상단 버튼 영역-->
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
		                            <th>*재고년월</th>
		                            <!-- <td><input type="month" class="form-control" id=invntryNo name="invntryNo" ></td> -->
		                        	<td><input class="form-control" type="text" id="invntryNo" disabled></td>
		                        	<th>*구분</th>
		                            <td><select class="custom-select" id="orderGubunCd" ></select></td>
		                        </tr>
		                        <tr>
		                            <th>제품코드</th>
		                            <td><input type="text" class="form-control" id="goodsCd"  name="goodsCd"></td>
		                            <th>모델NO</th>
		                            <td ><input type="text" class="form-control" id="modelNo" name="modelNo"></td>
		                        </tr>
		                        <tr>
		                         	<th>*제품명</th>
		                            <td>
		                            	<div class="input-sub m-0">
			                            	<input type="text" class="form-control" id="goodsNm"  name="goodsNm">
			                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelGoods" onClick="selectGoodsCode()">
										          <span class="oi oi-magnifying-glass"></span>
									        </button>
								        </div> 
		                            </td>	                        
		                            <th>규격</th>
		                            <td ><input type="text" class="form-control" id="model" name="model"></td>
		                        </tr>
		                        <tr>
		                         	<th>재질</th>
		                         	<input type="hidden" class="form-control" id="qutyCd"  name="qutyCd">
		                            <td><input type="text" class="form-control" id="qutyNm"  name="qutyNm"></td>	                        
		                            <th>포장 수량</th>
		                            <td ><input type="text" class="form-control" id="packCnt" name="packCnt"></td>
		                        </tr>
		                        <tr>
		                         	<th>*BOX 수량</th>
		                            <td><input type="number" max="5000" min="0" maxlength="5" step="1" class="form-control number-float0" id="inputBoxCnt"  name="inputBoxCnt" onpaste="return false;" oncopy="return false;"></td>	                        
		                            <th>*거래처</th>
		                            <input type="hidden" class="form-control" id="dealCorpCd"  name="dealCorpCd">
		                            <td>
		                            	<div class="input-sub m-0">
			                            	<input type="text" class="form-control" id="dealCorpNm"  name="dealCorpNm" disabled>
			                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelDeal" onClick="selectDealCorp()">
										          <span class="oi oi-magnifying-glass"></span>
									        </button>
								        </div> 
		                            </td>
		                        </tr>	                        	                        	                        
	                            <!--==========/table 내용 추가==========-->
	                            </table>
							</div>
						</form>
					</div>
					<div class="row">
						<div class="col-sm-6">
<!-- 							<div class="row float-left alert-primary d-none" id="addForm"> -->
<!-- 								<h6 class="p-1 mr-3 mb-0">추가 생성</h6> -->
<!-- 								<input class="form-control number-float0" min="0" max="5000" step="1" type="text" id="boxPlus" style="width:150px;"> -->
<!-- 							</div> -->
							<p class="d-none" id="deleteLabel">*삭제시 해당제품 입출고내역도 같이삭제됩니다!</p>
						</div>
						<div class="col-sm-6">
	                    	<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
	                    	<button type="button" class="btn btn-primary d-none float-right mr-2" id="btnReset">초기화</button>
	                    	
	                    	<button type="button" class="btn btn-primary d-none float-right mr-2 d-none" id="btnSaveEa">개별단위 추가</button>
	                    	<button type="button" class="btn btn-primary d-none float-right mr-2 d-none" id="btnBundle">묶음단위 추가</button>
	                    </div>
					</div>
					<!--
					<div>
	                    <button type="button" class="btn btn-primary float-right" id="btnCheck">확인</button>
					</div>
					-->
					<div class="table-responsive"> <!-- style="max-height:490px;" -->
						<table id="preGoodsInventoryDtlTable" class="table table-bordered">
							<colgroup><col width="7%"></colgroup>
							<%-- <colgroup><col width="10%"></colgroup> --%>
							<colgroup><col width="20%"></colgroup>
							<colgroup><col width="11%"></colgroup>
							<colgroup><col width="11%"></colgroup>
							<colgroup><col width="16%"></colgroup>
							<colgroup><col width="10%"></colgroup>
							<colgroup><col width="10%"></colgroup>
							<colgroup><col width="15%"></colgroup>
							<thead class="thead-light">
								<tr>
									<th>순번</th>
									<!-- <th>삭제<input type="checkbox" id="chkAll" name="chkAll"></th> -->
									<th>Box No</th>
									<th>포장 수량</th>
									<th>잔여 수량</th>
									<th>입고일</th>
									<th>제품 상태</th>
									<th>불량 상태</th>
									<th>비고</th>
								</tr>
							</thead>
							<!-- 
							<tfoot>
								<tr>
									<td colspan="3" style="text-align: center">합계</td>
									<td id="sumEaDtl" style="text-align: right">0</td>
									<td colspan="2" style="text-align: center"></td>
								</tr>
							</tfoot>
							 -->
						</table>
					</div>
				</div><!-- ===/.right-sidebar 등록,수정===  -->
			</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->
<!-- 식별표(1)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> -->
<div class="modal fade" id="firstInventoryModal" tabindex="-1" aria-labelledby="firstInventoryModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content" style="/*overflow:auto;*/">
			<div class="modal-header">
				<h5 class="modal-title" id="firstInventoryModalLabel">초기재고 인쇄 준비중입니다. 잠시만 기다려주세요...</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" id="printFirstInventoryModal">
				<div class="container" style="padding:0px;">
					<div class="row" style="padding:0px;">
						<div class="col" style="height:100%;">
							<table class="" style="border: 8px solid black; width:100%; max-width:100%; margin-bottom:1rem; background-color:transparent; text-indent:initial; border-spacing:2px; border-collapse:collapse;">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<tr style="border: 2px solid black;">
									<td class="text-center-td" colspan='4' style="font-size:50px; font-weight: bold; border: 2px solid black; text-align:center;">초 기 재 고 목 록</td>
								</tr>
								<tr style="border: 2px solid black; font-size:40px;">
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">재고년월</td>
									<td id="invntryNoPrt" 		style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">구분</td>
									<td id="orderGubunCdPrt"	style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
								</tr>
								<tr style="border: 2px solid black; font-size:40px;">
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">제품코드</td>
									<td id="goodsCdPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">모델NO</td>
									<td id="modelNoPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
								</tr>
								<tr style="border: 2px solid black; font-size:40px;">
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">제품명</td>
									<td id="goodsNmPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">규격</td>
									<td id="modelPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
								</tr>
								<tr style="border: 2px solid black; font-size:40px;">
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">재질</td>
									<td id="qutyNmPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">수량</td>
									<td id="packCntPrt"			style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
								</tr>
								<tr style="border: 2px solid black; font-size:40px;">
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">BOX</td>
									<td id="inputBoxCntPrt"		style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
									<td class="text-center-td"	style="min-width:20%; font-size:25px; height:50px; border: 2px solid black; text-align:center;">거래처</td>
									<td id="dealCorpNmPrt"		style="min-width:30%; font-size:25px; height:50px; border: 2px solid black; text-align:center;"></td>
								</tr>
							</table>
						</div>
					</div>
					<div class="row" style="padding:10px; min-width:100%;">
					</div>
					<div class="col" style="/*min-width:100%; height:375px;*/">
						<table class="" id="firstInventoryList" style="border: 8px solid black; width:100%; max-width: 100%; margin-bottom: 1rem; background-color: transparent;    text-indent: initial;
   																		border-spacing: 2px; border-collapse:collapse; font-size: 20px">
							<colgroup>
								<col width="10%">
								<col width="20%">
								<col width="10%">
								<col width="10%">
								<col width="50%">
							</colgroup>
							<tr style="min-width:100%; border: 2px solid black; font-size:40px; text-align:center;">
								<td class="" style="min-width:10%; height:50px; border: 3px solid black; text-align:center;">순번</td>
								<td class="" style="min-width:20%; height:50px; border: 3px solid black; text-align:center;">Box No</td>
								<td class="" style="min-width:10%; height:50px; border: 3px solid black; text-align:center;">수량</td>
								<td class="" style="min-width:10%; height:50px; border: 3px solid black; text-align:center;">잔여수량</td>
								<td class="" style="min-width:50%; height:50px; border: 3px solid black; text-align:center;">Barcode</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			<!-- 
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="A4Print();">Save changes</button>
			</div>
			 -->
		</div>
	</div>
</div>
<!-- 묶음단위 추가 모달 시작 -->
<div class="modal fade" id="bundlePopupModal" tabindex="-1" role="dialog" aria-labelledby="bundlePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="bundlePopupModalLabel">묶음단위 추가</h5>				
			</div>
			<div class="modal-body">
				<div class="row">
					<table class="table table-bordered">
						<colgroup>
						    <col width="30%">
						    <col width="30%">
						    <col width="40%">			                                           
						</colgroup>
						<tr>
						    <th>묶음개수</th>
						    <th>입고일</th>	
							<th>비고</th>		                          
						</tr>
						<tr>
							<td><input class="form-control number-float0" min="0" max="5000" step="1" type="text" id="boxPlus" style="width:150px;"></td>
						    <td><input class="form-control" min="0" type="date" id="bundleDate"  name="bundleDate" style="min-width:100%"></td>
						    <td><input class="form-control" min="0" type="text" id="bundleDateDesc"  name="bundleDateDesc" style="min-width:100%"></td>	                         
						</tr>
		            </table>
				</div>				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnSaveBundle" data-dismiss="modal" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnCancelBundle" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 묶음단위 추가 모달 끝 -->
<!-- 개별단위 추가 모달 시작 -->
<div class="modal fade" id="saveEaPopupModal" tabindex="-1" role="dialog" aria-labelledby="saveEaPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveEaPopupModalLabel">개별단위 추가</h5>				
			</div>
			<div class="modal-body">
				<div class="row">
					<table class="table table-bordered">
						<colgroup>
						    <col width="25%">
						    <col width="25%">
						    <col width="25%">
						    <col width="25%">
						</colgroup>
						<tr>
						    <th>무게(KG)</th>
							<th>개수</th>	
							<th>입고일</th>	
							<th>비고</th>		                          
						</tr>
						<tr>
						    <td><input class="form-control text-right " min="0" type="text" max="100" id="gram"  name="gram" style="min-width:100%"></td>		                         
						    <td ><input type="text" class="form-control text-right " min="0" max="100000"  id="ea" name="ea" style="min-width:100%"></td>
						    <td><input class="form-control" min="0" type="date" id="pieceEaDate"  name="pieceEaDate" style="min-width:100%"></td>
						    <td><input class="form-control" min="0" type="text" id="pieceEaDesc"  name="pieceEaDesc" style="min-width:100%"></td>	
						</tr>
		            </table>
				</div>				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnSaveEaCheck" data-dismiss="modal" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnSaveCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 개별단위 추가 모달 끝 -->
<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<식별표(1) -->
<!-- 재고 등록 확인 모달 시작 -->
<!-- 
<div class="modal fade" id="workOrdEndCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">저장 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<h6 id="goodsProductCheck1"></h6>
					&nbsp<h6> - </h6>&nbsp
					<h6 id="goodsProductCheck2"></h6>
				</div>
				<p>*등록시 해당제품의 입력 수량만큼 BoxNo가 채번되며 취소/삭제가 불가능 합니다.<br>다시한번 확인해주세요!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnSaveCheck" data-dismiss="modal" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnSaveCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
-->
<!-- 재고 등록 확인 모달 끝 -->
 
<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "66%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
		state = !state;
	});

	let menuAuth = 'tmsc0060';
	let currentHref = 'tmsc0060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품(초기재고)");
    let sideView = 'add';

    var invntryNo = null;
    var goodsCd = null;
    var model = null;
    var modelNo = null;
    var qutyCd = null;
    var dealCorpCd = null;
    var orderGubunCd = null;
    var inputBoxCnt = null;
    var packCnt = null;
    var gravity = 0;
    var secondView = null;
  	//공통코드 처리 시작
    var orderGubunCode=new Array();
    <c:forEach items="${orderGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		orderGubunCode.push(json);
    </c:forEach>
	//공통코드 처리 종료

  	uiInitProc(true);
	uiProc(true);
	var serverToday =  "${serverDate}";
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let preGoodsInventoryTable = $('#preGoodsInventoryTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/tm/preGoodsInventoryDataList"/>',
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
        rowId: 'invntryNo',
        columns: [
        	{ data: 'invntryNo',
        		render: function(data, type, row) {
        			return data.substring(0,4) + "-" + data.substring(4,6);
        		}
        	},
			{ data: 'orderGubunNm' },
			{ data: 'goodsNm' },
			{ data: 'modelNo' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: 'invntryBoxCnt' },
			{ data: 'invntryAllCnt' },
        ],
        columnDefs: [
           	{ targets: [6,7] , render: $.fn.dataTable.render.number( ',' ) },
           	{ targets: [6,7],  className: 'text-right-td'},
        	{ targets: [0,1,2,3,4],  className: "text-center"},
        ],
        order: [
            [ 0, 'desc' ],
            [ 2, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '초기재고관리-제품',
            },
            {
                extend: 'excel',
                title: '초기재고관리-제품',
            },
            {
                extend: 'print',
                title: '초기재고관리-제품',
            },
        ],
		drawCallback: function () {
			var sumBox = $('#preGoodsInventoryTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			var sumEa = $('#preGoodsInventoryTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			$('#sumBox').text(addCommas(sumBox));
			$('#sumEa').text(addCommas(sumEa));
		}
    });

    // 보기
    $('#preGoodsInventoryTable tbody').on('click', 'tr', function () {
    	$('#deleteLabel').addClass('d-none');
    	$('#btnPrint').attr('disabled', true);
        if ( $(this).hasClass('selected') ) {
           $(this).removeClass('selected');
        }
        else {
        	$('#preGoodsInventoryTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');

            invntryNo = preGoodsInventoryTable.row( this ).data().invntryNo;
            goodsCd = preGoodsInventoryTable.row( this ).data().goodsCd;
            orderGubunCd = preGoodsInventoryTable.row( this ).data().orderGubunCd;
            gravity = preGoodsInventoryTable.row( this ).data().gravity;
            //lastYn = preGoodsInventoryTable.row( this ).data().lastYn;
            $('#btnSave').addClass('d-none');
            $('#btnReset').addClass('d-none');
            $('#addForm').addClass("d-none");
            $('#btnSaveEa').addClass('d-none');
            $('#btnBundle').addClass('d-none');
            //console.log("goodsCd = " + goodsCd);
           
            $.ajax({
                url: '<c:url value="/tm/preGoodsInventoryData"/>',
                type: 'GET',
                async: false,
                data: {
                	'menuAuth'	 	:	menuAuth,
                    'invntryNo'		:	invntryNo,
                    'goodsCd'		:	goodsCd,
                    'orderGubunCd'	:	orderGubunCd,
                    //'lastYn': lastYn
                },
                success: function (res) {
                    let data = res.data;

                    if ( res.result == "ok" ){
                    	sideView = 'edit';
                        invntryNoTmp = data.invntryNo.substring(0,4) + "-" + data.invntryNo.substring(4,6);
                        // 보기
                        $('#goodsCd').val(data.goodsCd);
                        $('#goodsNm').val(data.goodsNm);
                        $('#model').val(data.model);
                        $('#modelNo').val(data.modelNo);
                        $('#qutyCd').val(data.qutyCd);
                        $('#qutyNm').val(data.qutyNm);
                        $('#dealCorpNm').val(data.dealCorpNm);
                        $('#dealCorpCd').val(data.dealCorpCd);                                                               
                        $('#invntryNo').val(invntryNoTmp);
                        $('#inputBoxCnt').val(data.invntryBoxCnt);               
                        $('#packCnt').val(data.packCnt);

                        //인쇄 데이터 입력
                        $('#goodsCdPrt').text(data.goodsCd);
                        $('#goodsNmPrt').text(data.goodsNm);
                        $('#modelPrt').text(data.model);
                        $('#modelNoPrt').text(data.modelNo);
                        $('#qutyCdPrt').text(data.qutyCd);
                        $('#qutyNmPrt').text(data.qutyNm);
                        $('#dealCorpNmPrt').text(data.dealCorpNm);
                        $('#dealCorpCdPrt').text(data.dealCorpCd);                                                               
                        $('#invntryNoPrt').text(invntryNoTmp);
                        $('#inputBoxCntPrt').text(data.invntryBoxCnt);               
                        $('#packCntPrt').text(data.packCnt);
                        
        				//화면처리
                        uiProc(true);
                        $('#chkAll').attr('disabled', true);
                        $("#chkAll").prop("checked", false);
                        
                        //선택박스 처리
                        selectBoxAppend(orderGubunCode, "orderGubunCd", data.orderGubunCd , "");
                        $('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
                        	$('#btnPrint').attr('disabled', false); // 인쇄버튼
                        	$("#btnPlus").attr("disabled", false);
                        	$("#btnMinus").attr("disabled", false);
                        	//$("input[type=checkbox]").attr('disabled', true);
                        });

                        if(openrNav2Flag) {
		    				$('#completTable1').DataTable().ajax.reload( function () {});
		    			} else {
		    				sideViewFlag = true;
		    			}
    				} else {
    					toastr.error(res.message, '', {timeOut: 5000});
    				}
                },
	            complete:function(){
		            
	            }
            });
        }
    });

    // 등록폼
    $('#btnAdd').on('click', function() {
        sideView = 'add';
        secondView ='';
        $('#form').each(function(){
            this.reset();
        });
		$('#invntryNo').val(serverToday.substring(0,7));

		//화면처리
		uiProc(false);
		$('#inputBoxCnt').val('0');
		$('#preGoodsInventoryTable').find('tr.selected').removeClass('selected');
		$('#preGoodsInventoryDtlTable').DataTable().clear().draw();
		//선택박스 처리
		selectBoxAppend(orderGubunCode, "orderGubunCd", "" , "2");
		$('#deleteLabel').addClass('d-none');
		$('#btnSave').removeClass('d-none');	// 등록버튼
		$('#btnReset').addClass('d-none');
		$('#addForm').addClass('d-none');
		$('#btnSaveEa').addClass('d-none');
		$('#btnBundle').addClass('d-none');
		$('#btnPrint').attr('disabled', true);	// 인쇄버튼
		$("#btnPlus").attr("disabled", true);
		$('#btnMinus').attr('disabled', true);
		$('#chkAll').attr('disabled', true);
		$("#chkAll").prop("chked", false);
    });

    //Box 추가
    $('#btnPlus').on('click', function() {
        if(sideView != 'edit') {
        	toastr.warning("수정할 목록을 선택해 주세요!");
            return false;
        }
        secondView = 'plus';
		uiProc2(false);
		$('#deleteLabel').addClass('d-none');
		$('#boxPlus').val("0");
		$('#btnPlus').removeClass('d-none');
// 		$('#btnSave').removeClass('d-none');
		$('#btnSave').addClass('d-none');
		$('#addForm').removeClass('d-none');
		$('#btnSaveEa').removeClass('d-none');
		$('#btnBundle').removeClass('d-none');
		$('#btnReset').addClass('d-none');
		$('#btnPrint').attr('disabled', true); // 인쇄버튼
		$('#boxPlus').attr('disabled', false); // 인쇄버튼
		//$("input[type=checkbox]").prop("checked", false);
		//$("input[type=checkbox]").attr('disabled', true);
    });

    //Box 삭제
	$('#btnMinus').on('click', function() {
	    if(sideView != 'edit') {
	    	toastr.warning("수정할 목록을 선택해 주세요!");
	        return false;
	    }
	    secondView = 'minus';
	    $('#preGoodsInventoryDtlTable tbody tr').each(function(){
	    	$(this).removeClass("selected");
	    });
		uiProc2(false);
		$('#deleteLabel').removeClass('d-none');
	    $('#btnSave').removeClass('d-none');
	    $('#btnReset').removeClass('d-none');
	    $('#addForm').addClass('d-none');
	    $('#btnSaveEa').addClass('d-none');
	    $('#btnBundle').addClass('d-none');
	    $("#btnSave").attr("disabled", true);
	    $('#btnPrint').attr('disabled', true); // 인쇄버튼
	    //$("input[type=checkbox]").prop("checked", false);
	    //$("input[type=checkbox]").attr('disabled', false);
	});

	//개별단위 추가
	$('#btnSaveEa').on('click', function() {
		$('#ea').val("0");
		$('#gram').val("0");
		$('#pieceEaDate').val(serverToday);
		$('#pieceEaDesc').val('');
		$('#saveEaPopupModal').modal('show');
	});
	
	//묶음단위 추가
	$('#btnBundle').on('click', function() {
		$('#boxPlus').val("0");
		$('#bundleDate').val(serverToday);
		$('#bundleDateDesc').val('');
		$('#bundlePopupModal').modal('show');
	});

	/* 
    //저장 모달 확인
    $('#btnSave').on('click', function() {
        if ( !$.trim($('#invntryNo').val()) ) {
            toastr.warning('재고년월을 선택해 주세요.');
            $('#invntryNo').focus();
            return false;
        }
        if ( $("#orderGubunCd option:selected").val() == "" ) {
            toastr.warning('구분을 선택해 주세요.');
            $('#orderGubunCd').focus();
            return false;
        }
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품명을 선택해 주세요.');
            $('#btnSelGoods').focus();
            return false;
        }
        //if ( !$.trim($('#model').val()) ) {
        //    toastr.warning('규격을 입력해 주세요.');
        //    $('#model').focus();
        //    return false;
        //}
        //if ( !$.trim($('#modelNo').val()) ) {
        //    toastr.warning('모델번호를 입력해 주세요.');
        //    $('#modelNo').focus();
        //    return false;
        //}
        if ( !$.trim($('#inputBoxCnt').val()) || $('#inputBoxCnt').val()==0) {
            toastr.warning('Box 수량을 입력해주세요.');
            $('#inputBoxCnt').select();
            return false;
        }
        if ( !$.trim($('#dealCorpCd').val()) ) {
            toastr.warning('거래처를 선택해주세요.');
            $('#btnSelDeal').focus();
            return false;
        }
        
    	$('#goodsProductCheck1').text( $('#invntryNo').val() + ' / ' + $('#goodsNm').val());
    	$('#goodsProductCheck2').text( $('#inputBoxCnt').val() + '개(Box) 등록하시겠습니까?');
    	$('#workOrdEndCheckPopupModal').modal('show');
    });
	*/

	$('#btnReset').on('click', function() {
        $('#preGoodsInventoryDtlTable > tbody > tr').each(function(index, tr) {
        	$(this).removeClass('selected');
		});
	});
	
	
    //등록&수정 처리
    $('#btnSave').on('click', function() {
        if ( !$.trim($('#invntryNo').val()) ) {
            toastr.warning('재고년월을 선택해 주세요.');
            $('#invntryNo').focus();
            return false;
        }
        if ( $("#orderGubunCd option:selected").val() == "" ) {
            toastr.warning('구분을 선택해 주세요.');
            $('#orderGubunCd').focus();
            return false;
        }
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품명을 선택해 주세요.');
            $('#btnSelGoods').focus();
            return false;
        }
        //if ( !$.trim($('#model').val()) ) {
        //    toastr.warning('규격을 입력해 주세요.');
        //    $('#model').focus();
        //    return false;
        //}
        //if ( !$.trim($('#modelNo').val()) ) {
        //    toastr.warning('모델번호를 입력해 주세요.');
        //    $('#modelNo').focus();
        //    return false;
        //}
        if ( sideView == 'add' ){
        	if ( $('#inputBoxCnt').val() == "" || $('#inputBoxCnt').val() == "0" ) {
                toastr.warning('Box 수량을 입력해주세요.');
                $('#inputBoxCnt').select();
                return false;
            }
		}
        if ( !$.trim($('#dealCorpCd').val()) ) {
            toastr.warning('거래처를 선택해주세요.');
            $('#btnSelDeal').focus();
            return false;
        }
        if ( secondView == 'plus' ){
        	if ( !$.trim($('#boxPlus').val()) || $('#boxPlus').val()==0) {
                toastr.warning('Box 수량을 입력해주세요.');
                $('#boxPlus').select();
                return false;
            }
		}
        
        let url = null;

        $('#my-spinner').show();

        invntryNo 		= $('#invntryNo').val().replace(/-/g, '');
        goodsCd 		= $('#goodsCd').val();
        model 			= $('#model').val();
        modelNo 		= $('#modelNo').val();
        qutyCd 			= $('#qutyCd').val();
        dealCorpCd 		= $('#dealCorpCd').val();
        orderGubunCd	= $("#orderGubunCd option:selected").val();
        inputBoxCnt 	= $('#inputBoxCnt').val();
        packCnt 		= $('#packCnt').val();
        
        //재고ADM 등록 & Box채번
		if( sideView == "add" ) {
	        url = '/tm/preGoodsInventoryCreate';
	        $.ajax({
	            url: url,
	            type: 'POST',
	            data: {
	            	'menuAuth'	 	:		menuAuth,
	            	'invntryNo'   	:		function() { return invntryNo; 		},
	            	'goodsCd'   	:		function() { return goodsCd; 		},
		            'model'      	:		function() { return model; 			},
		            'modelNo'   	:		function() { return modelNo; 		},
		            'qutyCd'      	:		function() { return qutyCd; 		},
		            'dealCorpCd'    :		function() { return dealCorpCd; 	},
		            'orderGubunCd'  :		function() { return orderGubunCd; 	},
		            'inputBoxCnt'  	:		function() { return inputBoxCnt; 	},
		            'packCnt'   	:		function() { return packCnt; 		},
	            },
	            beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	            },
	            success: function (res) {
	                let data = res.data;
	                if (res.result == 'ok' || res.result == 'fail') {
						// 보기
						$('#goodsCd').val(data.goodsCd);
						$('#preGoodsInventoryTable').DataTable().ajax.reload( function () {});
						$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
							//$("input[type=checkbox]").attr('disabled', true);
						});
						uiProc(true);
						$('#btnSave').addClass('d-none');
						if (res.result == 'ok'){
							toastr.success(res.message);
						} else if (res.result == 'fail'){
							toastr.warning(res.message, '', {timeOut: 5000});
						}
	                   	sideView = 'edit';
	                   	$("#btnPlus").attr("disabled", false);
                    	$("#btnMinus").attr("disabled", false);
	                } else if(res.result == 'exist') {
	                	toastr.warning('이미 해당 제품 재고정보가 등록 되어 있습니다.<br/> 재고정보를 확인해 주세요.');
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            	$('#btnPrint').attr('disabled',false); // 인쇄버튼
	            }
	        });
			
		//수정 처리
		} else if( sideView == "edit" ) {
			//재고ADM 수정 & BoxNo 채번
			if ( secondView == 'plus') {
				url = '/tm/preGoodsInventoryPlus'
				$.ajax({
		            url: url,
		            type: 'POST',
		            data: {
		            	'menuAuth'	 	:		menuAuth,
		            	'invntryNo'   	:		function() { return invntryNo; },
		            	'goodsCd'   	:		function() { return goodsCd; },
		            	'orderGubunCd'  :		function() { return orderGubunCd; },
			            'packCnt'   	:		function() { return packCnt; },
			            'boxPlus'   	:		function() { return $('#boxPlus').val(); }, 
		            },
		            beforeSend: function() {
		              //  $('#btnAddConfirm').addClass('d-none');
		            },
		            success: function (res) {
		                let data = res.data;
		                if (res.result == 'ok' || res.result == 'fail') {
							$('#inputBoxCnt').val(data.inputBoxCnt);
							$('#preGoodsInventoryTable').DataTable().ajax.reload( function () {});
							$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
								//$("input[type=checkbox]").attr('disabled', true);
							});
							uiProc(true);
							$('#btnSave').addClass('d-none');
							$('#btnSaveEa').addClass('d-none');
							$('#btnBundle').addClass('d-none');
							if (res.result == 'ok'){
								toastr.success(res.message);
							} else if (res.result == 'fail'){
								toastr.warning(res.message, '', {timeOut: 5000});
							}
		                   	sideView = 'edit';
		                   	$("#btnPlus").attr("disabled", false);
	                    	$("#btnMinus").attr("disabled", false);
	                    	$("#boxPlus").attr("disabled", true);
		                } else {
		                	toastr.error(res.message, '', {timeOut: 5000});
		                }
		            },
		            complete:function(){
		            	$('#btnPrint').attr('disabled',false); // 인쇄버튼
		            	$('#my-spinner').hide();
		            }
		        });
			
			//재고ADM 수정 & Box삭제
			} else if ( secondView == 'minus' ){
				if ( boxArray == "" ){
					toastr.warning("삭제할 BoxNo를 선택해 주세요.");
					$('#my-spinner').hide();
				} else {
					url = '/tm/preGoodsInventoryMinus'
						
					$.ajax({
			            url: url,
			            type: 'POST',
			            data: {
			            	'menuAuth'	 	:		menuAuth,
			            	'invntryNo'   	:		function() { return invntryNo; },
			            	'goodsCd'   	:		function() { return goodsCd; },
			            	'orderGubunCd'  :		function() { return orderGubunCd; },
				            'boxMinus'   	:		function() { return boxArray; },	//삭제할 BoxNo묶음
			            },
			            beforeSend: function() {
			              //  $('#btnAddConfirm').addClass('d-none');
			            },
			            success: function (res) {
			                let data = res.data;
			                if (res.result == 'ok') {
			                	$('#inputBoxCnt').val(data.inputBoxCnt);
								uiProc(true);
								$('#btnReset').addClass('d-none');
								$('#btnSave').addClass('d-none');
								toastr.success('삭제되었습니다.');
			                   	sideView = 'edit';
			                   	$("#btnPlus").attr("disabled", false);
		                    	$("#btnMinus").attr("disabled", false);
		                    	$("#boxPlus").attr("disabled", true);
			                } else if (res.result == 'fail'){
			                	toastr.warning(res.message, '', {timeOut: 5000});
			                } else {
			                	toastr.error(res.message, '', {timeOut: 5000});
			                }
			            },
			            complete:function() {
			            	$('#preGoodsInventoryTable').DataTable().ajax.reload( function () {});
							$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
								//$("input[type=checkbox]").prop("checked", false);
								//$("input[type=checkbox]").attr('disabled', true);
								boxArray = "";
							});
			            	$('#btnPrint').attr('disabled',false); // 인쇄버튼
			            	$('#deleteLabel').addClass('d-none');
			            	$('#my-spinner').hide();
						},
					});
				}
			}
		}
    });

	//개별 저장버튼 클릭 시
    $('#btnSaveEaCheck').on('click',function(){

    	var url = '/tm/preGoodsInventoryPlusEa';

    	if($('#gram').val() == 0 && $('#ea').val() == 0){
			toastr.warning("무게나 개수를 입력해주세요.")
			return false;			
		}
    	if ( !$.trim($('#pieceEaDate').val()) || $('#pieceEaDate').val()==0) {
            toastr.warning('입고일을 선택해주세요.');
            $('#pieceEaDate').select();
            return false;
        }
		packCnt = $('#packCnt').val();
		
    	$.ajax({
            url: '<c:url value="/tm/preGoodsInventoryPlusEa"/>',
            type: 'POST',
            data: {
            	'menuAuth'	 	:	menuAuth,
            	'invntryNo'   	:	function() { return invntryNo; 							},
            	'goodsCd'   	:	function() { return goodsCd; 							},
            	'orderGubunCd'  :	function() { return orderGubunCd; 						},
	            'packCnt'   	:	function() { return packCnt;							},
	            'boxPlus'   	:	function() { return $('#ea').val().replace(/,/g,"");	},
	            'goodsInDate'  	:	function() { return $('#pieceEaDate').val().replace(/-/g,"");	}, 
	            'inventoryDesc'	:	function() { return $('#pieceEaDesc').val();		}, 
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok' || res.result == 'fail') {
					$('#inputBoxCnt').val(data.inputBoxCnt);
					$('#preGoodsInventoryTable').DataTable().ajax.reload( function () {});
					$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
						//$("input[type=checkbox]").attr('disabled', true);
					});
					uiProc(true);
					$('#saveEaPopupModal').modal('hide');
					$('#btnSave').addClass('d-none');
					if (res.result == 'ok'){
						toastr.success(res.message);
					} else if (res.result == 'fail'){
						toastr.warning(res.message, '', {timeOut: 5000});
					}
                   	sideView = 'edit';
                   	$("#btnPlus").attr("disabled", false);
                	$("#btnMinus").attr("disabled", false);
                	$("#boxPlus").attr("disabled", true);
                	$('#btnSaveEa').addClass('d-none');
                	$('#btnBundle').addClass('d-none');
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#btnPrint').attr('disabled',false); // 인쇄버튼
            	$('#my-spinner').hide();
            }
        });
    });

    //묶음 저장버튼 클릭 시
    $('#btnSaveBundle').on('click', function(){
    	if ( !$.trim($('#boxPlus').val()) || $('#boxPlus').val()==0) {
            toastr.warning('Box 수량을 입력해주세요.');
            $('#boxPlus').select();
            return false;
        }
    	if ( !$.trim($('#bundleDate').val()) || $('#bundleDate').val()==0) {
            toastr.warning('입고일을 선택해주세요.');
            $('#bundleDate').select();
            return false;
        }
    	packCnt = $('#packCnt').val();
		$.ajax({
            url: '<c:url value="/tm/preGoodsInventoryPlus"/>',
            type: 'POST',
            data: {
            	'menuAuth'	 	:	menuAuth,
            	'invntryNo'   	:	function() { return invntryNo; 					},
            	'goodsCd'   	:	function() { return goodsCd; 					},
            	'orderGubunCd'  :	function() { return orderGubunCd; 				},
	            'packCnt'   	:	function() { return packCnt; 					},
	            'boxPlus'   	:	function() { return $('#boxPlus').val();		}, 
	            'goodsInDate'  	:	function() { return $('#bundleDate').val().replace(/-/g,"");;		}, 
	            'inventoryDesc'	:	function() { return $('#bundleDateDesc').val();	}, 
            },
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok' || res.result == 'fail') {
					$('#inputBoxCnt').val(data.inputBoxCnt);
					$('#preGoodsInventoryTable').DataTable().ajax.reload( function () {});
					$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {
						//$("input[type=checkbox]").attr('disabled', true);
					});
					uiProc(true);
					$('#btnSave').addClass('d-none');
					$('#btnSaveEa').addClass('d-none');
					$('#btnBundle').addClass('d-none');
					if (res.result == 'ok'){
						toastr.success(res.message);
					} else if (res.result == 'fail'){
						toastr.warning(res.message, '', {timeOut: 5000});
					}
                   	sideView = 'edit';
                   	$("#btnPlus").attr("disabled", false);
                   	$("#btnMinus").attr("disabled", false);
                   	$("#boxPlus").attr("disabled", true);
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#btnPrint').attr('disabled',false); // 인쇄버튼
            	$('#my-spinner').hide();
            }
        });
	});
    
	// 목록
    $.fn.dataTable.ext.errMode = 'none';
	let preGoodsInventoryDtlTable = $('#preGoodsInventoryDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        searching: false,
		//header 고정
		scrollY: '42vh',
		scrollX: true,
        select: {
			style: 'os',
			info: false,
			toggleable : true,	//false시 초기화 후 선택안됨
        },
        ajax: {
            url: '<c:url value="/tm/preGoodsInventoryDtlList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	:		menuAuth,
            	'invntryNo'   	:		function() { return invntryNo; 		},
            	'goodsCd'   	:		function() { return goodsCd; 		},
            	'orderGubunCd'  :		function() { return orderGubunCd; 	},
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        columns: [
        	{
	    		render: function(data, type, row, meta) {
	    			var rowNo = meta.row + 1;
	    			if(rowNo == 1) {
	    				$('#btnSave').attr('disabled', false);
			    	}
					return meta.row + 1;
				}
	    	},
	    	//{ 
	    	//	render: function(data, type, row, meta) {
	    	//		return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width:15px; height:15px;">' ;
		    		//if( row['packCnt'] == row['remainCnt'] ){
		    		//	return '<input type="checkbox" id="chk-' + meta.row + '" name="chk">' ;
			    	//} else {
			    	//	return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" disabled>' ;
				    //}
	    	//	}
			//},
			{ data: 'boxNo' 			},
			{ data: 'packCnt'	 		},
			{ data: 'remainCnt' 		},
			{ data: 'goodsInDate',
				render: function(data, type, row) {					
						return moment(data).format("YYYY-MM-DD");
                } 
			},
			{ data: 'goodsStatusNm' 	},
			{ data: 'faultyStatusNm'	},
			{ data: 'inventoryDesc'		},
        ],
        columnDefs: [
        	{ targets: [0,1,4,5,6,7],  className: "text-center"},
        	{ targets: [2,3],  className: 'text-right-td'},
           	{ targets: [2,3] , render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '초기재고관리-제품상세',
            },
            {
                extend: 'excel',
                title: '초기재고관리-제품상세',
            },
            {
                extend: 'print',
                title: '초기재고관리-제품상세',
            },
		],
        //drawCallback : function( settings ) {
		//	var sumEaDtl = $('#preGoodsInventoryDtlTable').DataTable().column(3,{ page: 'all'} ).data().sum();
		//	$('#sumEaDtl').text(addCommas(sumEaDtl));
       	//} 
    });

	// Dtl 클릭이벤트
	$('#preGoodsInventoryDtlTable tbody').on('click', 'tr', function () {

		if (secondView == 'minus') {
			$("#btnSave").attr("disabled", true);
			$('#my-spinner').show();
			setTimeout(function() {
				boxArray = "";
				$('#preGoodsInventoryDtlTable tbody tr').each(function(){
				 	if ( $(this).hasClass("selected") ){
						if( $(this).children().eq(2).text() != $(this).children().eq(3).text() ){
							$(this).removeClass("selected");
							toastr.warning($(this).children().eq(1).text() + "는 출하된 제품이라 선택 해제되었습니다.");
						} else {
							boxArray += "/" + $(this).children().eq(1).text();
						}
						$("#btnSave").attr("disabled", false);
						//console.log(boxArray);
					 }
				});
			}, 700);
			
			$('#my-spinner').hide();
		}
    });
    
	/*
    $('#btnCheck').on('click', function() {
    	if ( !$.trim($('#invntryNo').val()) ) {
            toastr.warning('재고년월을 선택해 주세요.');
            $('#invntryNo').focus();
            return false;
        }
        if ( $("#orderGubunCd option:selected").val() == "" ) {
            toastr.warning('구분을 선택해 주세요.');
            $('#orderGubunCd').focus();
            return false;
        }
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품명을 선택해 주세요.');
            $('#btnSelGoods').focus();
            return false;
        }
        //if ( !$.trim($('#model').val()) ) {
        //    toastr.warning('규격을 입력해 주세요.');
        //    $('#model').focus();
        //    return false;
        //}
        //if ( !$.trim($('#modelNo').val()) ) {
        //    toastr.warning('모델번호를 입력해 주세요.');
        //    $('#modelNo').focus();
        //    return false;
        //}
        if ( !$.trim($('#inputBoxCnt').val()) ) {
            toastr.warning('Box 수량을 입력해주세요.');
            $('#inputBoxCnt').focus();
            return false;
        }
        if ( !$.trim($('#dealCorpCd').val()) ) {
            toastr.warning('거래처를 선택해주세요.');
            $('#btnSelDeal').focus();
            return false;
        }
        
	    $.ajax({
	        url: '<c:url value="/tm/preGoodsInventoryDtlCheck"/>',
	        type: 'GET',
	        data: {
            	'menuAuth'	 	:		menuAuth,
            	'invntryNo'   	:		$('#invntryNo').val().replace(/-/g, ''), 
            	'goodsCd'   	:		$('#goodsCd').val(),                
	            'orderGubunCd'  :		$("#orderGubunCd option:selected").val(),
				'inputBoxCnt'  	:		$('#inputBoxCnt').val(),	
	            'packCnt'   	:		$('#packCnt').val(),	            
	        },
	        success: function (res) {
	            let data = res.data;
	            if ( res.result == "ok" ){
	            	sideView = 'edit';
	                // 보기
	                $('#goodsCd').val(data.goodsCd);

				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
	        }
		});
    });
	*/
    
   	function uiProc(flag)
   	{
        //$("#invntryNo").attr("disabled",flag);                
        $("#inputBoxCnt").attr("disabled",flag);
        $("#btnSelGoods").attr("disabled",flag);
        $("#orderGubunCd").attr("disabled",flag);
        $("#btnSelDeal").attr("disabled",flag);
   	}

   	function uiProc2(flag)
   	{
        //$("#inputBoxCnt").attr("disabled",flag);
   	}
   	   	
   	function uiInitProc(flag)
   	{
        $("#goodsCd").attr("disabled",flag);
        $("#goodsNm").attr("disabled",flag);
        $("#model").attr("disabled",flag);                
        $("#modelNo").attr("disabled",flag);               
        $("#qutyNm").attr("disabled",flag); 
        $("#packCnt").attr("disabled",flag);                          
   	}   	

   	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode(qutyType)
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
		            [ 0, 'desc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#goodsCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = goodsCdPopUpTable.row( this ).data();
                $('#goodsCd').val(data.goodsCd);
                $('#goodsNm').val(data.goodsNm);
                $('#model').val(data.model);
                $('#modelNo').val(data.modelNo);
                $('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpCd').val(data.dealCorpCd);
                $('#qutyNm').val(data.qutyNm);
                $('#qutyCd').val(data.qutyCd);
                $('#packCnt').val(data.packUnitNm);
                $('#goodsPopUpModal').modal('hide');
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}
		
		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료
  	
  	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable;
   	function selectDealCorp()
   	{
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
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
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });
		    
		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('#dealCorpCd').val(data.dealCorpCd);
				$('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		
		$('#dealCorpPopUpModal').modal('show');		
   	}   	
	//거래처정보조회 팝업 종료  
	
	//yyyy-mm 달력
	$('#invntryNo').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});

	function firstInventoryTableMaker(index, boxNo, boxCnt, remainCnt) {
		var FIThtml = '<tr style="min-width:100%; border: 3px solid black; font-size:20px;">'+
							'<td class="" style="min-width:10%; height:100px; border: 2px solid black; text-align:center;">' + index +'</td>'+
							'<td class="" style="min-width:20%; height:100px; border: 2px solid black; text-align:center;">' + boxNo +'</td>'+
							'<td class="" style="min-width:10%; height:100px; border: 2px solid black; text-align:center;">' + boxCnt +'</td>'+
							'<td class="" style="min-width:10%; height:100px; border: 2px solid black; text-align:center;">' + remainCnt + '</td>'+
							'<td class="" style="min-width:50%; height:100px; border: 2px solid black; text-align:center;">' +
								'<svg id="barcode-'+index+'"></svg>'+
							'</td>'+
						'</tr>';
		return FIThtml;
	}

	//초기재고목록표 인쇄 click
	$('#btnPrint').on('click',function() {
		$('#btnPrint').attr('disabled', true);
		$('#firstInventoryModal').modal('show');
		$('#my-spinner').show();
		$('#orderGubunCdPrt').text($('#orderGubunCd option:selected').text());
		$('#firstInventoryList').empty();

		for(var i=0;i<preGoodsInventoryDtlTable.data().count();i++) {
			$('#firstInventoryList').append(firstInventoryTableMaker(i+1,
																	preGoodsInventoryDtlTable.row(i).data().boxNo,
																	preGoodsInventoryDtlTable.row(i).data().packCnt,
																	preGoodsInventoryDtlTable.row(i).data().remainCnt));
			
			JsBarcode("#barcode-"+(i+1), preGoodsInventoryDtlTable.row(i).data().boxNo, {
				width		: 2,
				height		: 20,
				textMargin	: 1,
				fontSize	: 10,
				margin		: 1
			});
		}
		
		setTimeout(function() {
			$('#printFirstInventoryModal').print();
			$('#my-spinner').hide();
			$('#firstInventoryModal').modal('hide');
			$('#btnPrint').attr('disabled', false);
		}, preGoodsInventoryDtlTable.data().count() * 20);
	});

	//$('#chkAll').on('click', function(){
	//	if($("#chkAll").prop("checked")) {
	//		$("input[type=checkbox]").prop("checked", true);
	//	} else {
	//		$("input[type=checkbox]").prop("checked", false);
	//	}
	//});

	var boxArray = "";
	//$(document).ready(function () {
	//    $(document).on('change', 'input[name="chk"]', function (e) {
	//    	var tr = $(this).parent().parent().eq(0);
	//		var td = tr.children();
	//    	if ( $(this).is(":checked") ) {
	//			//포장수량이랑 잔여수량이 일치하지 않다면
	//			if ( td.eq(3).text() != td.eq(4).text() ) {
	//				$(this).prop("checked", false);
	//				toastr.warning("출하된 제품은 삭제하실 수 없습니다.");
	//				return false;
	//			}
	//			boxArray += "/" + td.eq(2).text();
	//	    } else {
	//	    	boxArray = boxArray.replace("/" + td.eq(2).text(), "");
	//		}
	//    });
	//});

	var viewTemp = true;	//Dtl Celar 판단
   	var openrNav2Flag = true;
   	var sideViewFlag = true;
	function openrNav2After() 
	{
		//같은항목 열었다 닫았다 반복시 Dtl Clear 판단
		if ( viewTemp ){
			$('#preGoodsInventoryDtlTable').DataTable().clear().draw(false);
		}

    	if (sideView == "edit" && sideViewFlag == true) {
			$('#preGoodsInventoryDtlTable').DataTable().ajax.reload( function () {});
    	}
    	openrNav2Flag = true;
	}

	function closerNav2After()
	{
		openrNav2Flag = false;
		sideViewFlag = false;
	}

	$(document).on('keyup',"input[name=ea]",function(evt) {  // 콤마 추가
        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let poQty = $(this).val().replace(/,/g, '');
    	if (reg.test(poQty)) {
    		poQty = poQty.replace(reg, '');
    		$(this).val(   addCommas(poQty) );
    		return false;
    	}	
    	
    	$('#gram').val(parseFloat(poQty*gravity/ 1000).toFixed(3));
		
    });

	$(document).on('keyup',"input[name=gram]",function(evt) {  // 콤마 추가
        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let poQty = $(this).val().replace(/,/g, '');
    	if (reg.test(poQty)) {
    		poQty = poQty.replace(reg, '');
    		$(this).val(   addCommas(poQty) );
    		return false;
    	}	
    	
    	$('#ea').val(addCommas(parseInt(parseFloat(poQty/gravity)* 1000)));
		
    });

	$('#ea').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109)	) {
			//$('.number-float0').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("");
			$('#gram').val("0");
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$('#gram').val("0");
			$(this).select();
			return false;
		}

 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$('#gram').val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$('#gram').val("0");
 			$(this).select();
 			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$('#gram').val("0");
 			$(this).select();
 			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
			$('#gram').val("0");
 			$(this).select();
			return false;
		}
		// .개수 세기
		if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$('#gram').val("0");
			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
        	$('#gram').val("0");
 			$(this).select();
            return false;
		}

        //$(this).val() = addCommas(temp);
	});

	$('#gram').keyup(function (event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109 || event.which == 110 || event.which == 190)	) {
			//$('.number-float3').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();			
			$('#ea').val("0");
 			$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$('#ea').val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$(this).val("0");
			$('#ea').val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
			$('#ea').val("0");
 			$(this).select();
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$('#ea').val("0");
			$(this).select();
			return false;
		}
		
 		var _pattern3 = /^\d*[.]\d{4}$/;	//누르고있는 키는 예외처리 안됨
        if (_pattern3.test( $(this).val())) {
        	toastr.warning("소수점 셋째 자리까지 입력 가능합니다.");
        	$(this).val("0");
        	$('#ea').val("0");
 			$(this).select();
            return false;
		}
	});


</script>

</body>
</html>
