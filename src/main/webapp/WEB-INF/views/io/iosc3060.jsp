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
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">제품출하등록</li>
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
						<button id="left-width-btn2" onclick="openrNav2();openrNav2After()"
							class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="productShipmentViewTable" class="table table-bordered">
							<colgroup>
<%-- 								<col width="5%"> --%>
								<col width="5%">
								<col width="5%">
								<col width="7%">
								<col width="3%">
								<col width="5%">
								<col width="7%">
								<col width="5%">
								<col width="10%">
								<col width="19%">
								<col width="5%">
								<col width="3%">
								<col width="3%">
								<col width="3%">
								<col width="3%">
								<col width="5%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead class="thead-light">
								<tr>
<!-- 									<th class="text-center">승인구분</th> -->
									<th class="text-center">마감일</th>
									<th class="text-center">납기일</th>
									<th class="text-center">PO Number</th>
									<th class="text-center">파레트번호</th>
									<th class="text-center">오더구분</th>
									<th class="text-center">거래처</th>
									<th class="text-center">담당</th>
									<th class="text-center">등록번호(PO)</th>
									<th class="text-center">제품</th>
									<th class="text-center">재질</th>
									<th class="text-center">두께</th>
									<th class="text-center">폭</th>
									<th class="text-center">길이</th>
									<th class="text-center">피치</th>
									<th class="text-center">출고BOX</th>
									<th class="text-center">출고수량</th>
									<th class="text-center">작업일</th>
									<!-- <th class="text-center" class="text-center">출고처</th> -->
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
                  <div class="right-list right-sidebar right-sidebar-fix" id="rfSidenav" style="width:65%; padding-bottom:0px;">
                    <div class="card" id="formBox">
                    <div class="card-body col-sm-12">
                    
                    <div class="row">
	                    <div class="col-md-2">
	                    	<button type="button" class="btn btn-warning float-center mr-2 d-none" id="btnReturn" disabled>검사 반품</button>                    
	                    </div>
	                    <div class="col-md-5">
	                    	<button type="button" class="btn btn-primary float-center mr-2 btnSwitching d-none" id="btnReturnSwitching" disabled>교체(검사 반품)</button>
	                    	<button type="button" class="btn btn-primary float-center mr-2 btnSwitching d-none" id="btnCommonSwitching" disabled>교체(일반)</button>
	                    </div>
	                    <div class="col-md-5">
	                    	<div class="rightsidebar-close">
                            <a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2();closerNav2After()"><i class="mdi mdi-close"></i></a>
							</div>
							<button type="button" class="btn btn-primary float-right mr-1" id="btnSave" disabled>저장</button>
						</div>
					</div>
                    </div>	
                    <form id="form">
                          <div class="table-responsive">
                            <table class="table table-bordered" id="productShipmentTable">
                            <colgroup>
	                            <col width="20%">
	                            <col width="30%">
	                            <col width="20%">
	                            <col width="30%">	                            
	                        </colgroup>
	                        <tr>
	                            <th>작업일</th>
	                            <td><input type="text" class="form-control" id="goodsOutDate"  name="goodsOutDate" style="min-width:100%;" disabled></td>
	                            <th>PO NUMBER</th>
	                            <td> <input type="text" class="form-control" id="poNo"  name="poNo" style="min-width:100%;" disabled> </td>
	                        </tr>
	                        <tr>
                        <%
							if(factoryCode.equals("001") || factoryCode.equals("002")) {
						%>
                        		<th>출하순서(파레트번호)</th>
                       	<%
							}else {
                       	%>
                       			<th>출하순서</th>
                       	<%
							}
                       	%>
	                            <td><input type="text" class="form-control" id="poGroup"  name="poGroup" style="min-width:100%;" maxlength="3" disabled></td>
	                            
	                            <th>거래처</th>
	                            <td><input type="text" class="form-control" id="dealCorpNm"  name="dealCorpNm" style="min-width:100%;" disabled></td>
	                            <!-- 
	                        	<th>출고처</th>
	                            <td><input type="text" class="form-control" id="deliveryDealCorpNm"  name="deliveryDealCorpNm" disabled></td>
	                             -->
	                        </tr>
<!-- 	                        <tr> -->
<!-- 	                            <th>승인구분</th> -->
<!-- 	                            <td> -->
<!-- 	                            	<input type="hidden" id="approvalCd"> -->
<!-- 	                            	<select class="custom-select" id="approvalNm" disabled></select> -->
<!-- 	                            </td> -->
<!-- 	                            <th></th> -->
<!-- 	                            <td></td> -->
                            </table>
							<!-- <table class="table table-bordered">
								<tr>								
		                            <th>합계</th>
		                            <td><div class="row"><input type="text" class="form-control text-right" id="box"  name="box"  style="border:none;" disabled>&nbsp; BOX</div></td>		                           
		                            <td><div class="row"><input type="text" class="form-control text-right" id="pcs"  name="pcs"  style="border:none;" disabled>&nbsp; PCS</div></td>     		
	                        	</tr>	    
							</table> -->
						</div>
							<div class="row" style="margin-bottom: 7px;">
								<div class="col-sm-4 row">
									<h6 class="mr-2">전체선택 :</h6>
									<input type="checkbox" id="checkAll" name="checkAll" style="width:20px; height:20px;" disabled>
								</div>
								<div class="col-sm-8">
									<div class="row float-right alert-primary">
										<h6 class="p-1 mr-3 mb-0">합계</h6>
										<h5 class="mr-3 mb-0" id="box"></h5>
										<h5 class="mb-0" id="pcs"></h5>
									</div>
	                            </div>
							</div>
                            <div class="table-responsive" style="max-height:560px;">
	                    	<table id="productShipmentTableDtl" class="table table-bordered">
	                    		<colgroup>
									<col width="4%">
									<col width="13%">
									<col width="15%">
									<col width="20%">
									<col width="10%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="7%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
		                        <tr>
	                              <th style="min-width:40px;" class="text-center">순번</th>	    
	                              <th style="min-width:40px;" class="text-center">고객사LotNo</th>	                       
	                              <th style="min-width:110px;" class="text-center">포장 NO</th>
	                              <th style="min-width:70px;" class="text-center">제품</th>
	                              <th style="min-width:60px;" class="text-center">입출고 상태</th>
	                              <th style="min-width:70px;" class="text-center">불량 상태</th>
	                              <th style="min-width:70px;" class="text-center">재질</th>
	                              <th style="min-width:40px;" class="text-center">두께</th>
	                              <th style="min-width:40px;" class="text-center">폭</th>
	                              <th style="min-width:40px;" class="text-center">길이</th>
	                              <th style="min-width:40px;" class="text-center">피치</th>
	                              <th style="min-width:70px;" class="text-center">출고량</th>
	                            </tr>
		                        </thead>
                            </table>
						</div>                	                    
					</form>
				</div>				
				
			</div><!-- ===/.right-sidebar 등록,수정===  -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->
<!-- 제품 불량 처리 확인 모달 시작-->
<div class="modal fade" id="faultyStatusPopupModal" tabindex="-1" role="dialog" aria-labelledby="faultyStatusPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="faultyStatusPopupModalLabel">교체 등록</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">      	
      	<p id="reloadText">*기존 포장NO는 자동으로 검사반품처리 됩니다.</p>
      	<p>*불합격 트레이나 이기종 제품은 교체할 수 없습니다.</p> 
		<table class="table table-bordered">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">	                            
				</colgroup>
				<tr>
				    <th>포장 NO</th>
				    <td class="text-center" id="boxNoGuide" ></td>
				    <th>제품</th>
				    <td class="text-center" id="goodsNmGuide"></td>
				</tr>
				<tr>
				    <th>순번</th>
				    <td class="text-center" id="poNoSeq" ></td>
				    <th>출고량</th>
				    <td class="text-center" id="outputCnt"></td>
				</tr>
	    </table>
      	<input type="text" class="form-control" style="min-width:100%" id="newBox">
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-primary" id="btnFaulty" data-dismiss="modal" style="min-width:70px;">변경</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 제품 불량 처리 확인 모달 끝 -->
<!-- 제품 검사반품 등록 모달 시작-->
<%-- 
<div class="modal fade bd-example-modal-lg" id="faultyPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="faultyPopUpLabel">불량 처리</h5>
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
				<button type="button" class="btn btn-warning" id="btnReturnCheck" data-dismiss="modal" style="min-width: 70px;">검사 반품</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
 --%>
 <div class="modal fade" id="faultyPopUpModal" tabindex="-1" role="dialog" aria-labelledby="packCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">검사 반품 확인</h5>
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
<!-- 보류&불량&반품&실반품&폐기 -->
<!-- 저장 여부 모달 -->
<div class="modal fade" id="saveBtnModal" tabindex="-1" role="dialog" aria-labelledby="saveBtnModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="saveBtnModalLabel">주의</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6>저장하시겠습니까?</h6> 
      </div>
      <div class="modal-footer">
     	<button type="button" class="btn btn-primary" id="saveBtnModalY" data-dismiss="modal">예</button>
		<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'iosc3060';
	let currentHref = 'iosc3060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","제품출하등록");

	let viewIdx;	
	let switchType; // 교체 방식 (검사반품/일반)
	let isBoxNoScan = false; // NewBoxNo 스캔 여부
	var serverDateFrom =  "${serverDateFrom}";
	var serverDateTo =  "${serverDateTo}";
	var chooseDateFrom = serverDateFrom;
	var chooseDateTo = serverDateTo;
	var factoryCode = "<%=factoryCode%>";
	var poSeq = 0;
	var poGroup = null;
	var boxArray;
	var customerLotNo = null;
	var boxNoOld = null;
	var poNoSeq = null;
	var returnBoxNo = null;

	//공통코드 처리 시작
	var approvalCode=new Array();	//승인여부
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
    </c:forEach>

    var goodsFaultyType=new Array();	//자재불량유형
    <c:forEach items="${goodsFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyType.push(json);
    </c:forEach>
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let productShipmentViewTable = $('#productShipmentViewTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-4'l><'col-sm-12 col-md-4'f><'col-sm-12 col-md-4'>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-3'i><'col-sm-12 col-md-3'p><'col-sm-12 col-md-6'>>B",
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
            url: '<c:url value="/io/productShipmentDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 		: 		menuAuth,
	           	'chooseDateFrom'	:		function() { return chooseDateFrom.replace(/-/g, ''); },
            	'chooseDateTo'		:		function() { return chooseDateTo.replace(/-/g, ''); },
            	'approvalCd'	    :	    function() { return $("#approvalGubun option:selected").val(); } ,
            	'completeYn'	   	:	    function() { return 'Y' } ,
            	'goodsStatus'	    :	    function() { return '003' } ,
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: '',
        columns: [
//             { data: 'approvalNm'},
            { data: 'deliveryDate',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                }
            },
            { data: 'deadLine',
                render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                }
            },
            { data: 'poNo' },   
            { data: 'poGroup'},
            { data: 'poGubunNm' },
            { data: 'dealCorpNm' }, 
            { data: 'poAttn' },
            { data: 'poSeq'},                    
            { data: 'goodsNm'  },
            { data: 'qutyNm'  },
            { data: 'thickness' },
            { data: 'depth'  },
            { data: 'length'  },
            { data: 'pitch'  },
            { data: 'boxCount'  },
            { data: 'outputQty'  },              
            { data: 'outputHistDate',
            	render: function(data, type, row) {					
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "";
					} 
                }
            },
			//{ data: 'deliveryDealCorpNm'}
        ],
        columnDefs: [
        	{ targets: [11,12,13,14,15] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [11,12,13,14,15], className: 'text-right' },
        ],
        rowCallback: function (row, data) {
			if (data.disposeGubun > 0) {
				$(row).addClass('whiteRed');
			}
		},
        //order: [
        //    [ 1, 'desc' ],
        //    [ 6, 'asc' ],
        //],
        buttons: [
            {
                extend: 'copy',
                title: '제품출하등록',
            },
            {
                extend: 'excel',
                title: '제품출하등록',
            },
            {
                extend: 'print',
                title: '제품출하등록',
            }
        ],
    });
    
    let productShipmentTableDtl = $('#productShipmentTableDtl').DataTable({
    	dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    	"<'row'<'col-sm-12'tr>>" +
    	"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: false,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: false,
        searching: false,
        pageLength: 20,
		scrollY: "50vh",
        select: {
			style: 'os',
			info: false,
			toggleable : true,	//false시 초기화 후 선택안됨
        },            
        ajax: {
            url: '<c:url value="/io/productShipmentDtlDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: menuAuth,
            	'poSeq' 	: function() { return poSeq; },
            	'poGroup' 	: function() { return poGroup; },
             },             
        },
        rowId: '',
        columns: [
        	{ data: 'poNoSeq'},
        	{ data: 'customerLotNo'},
            { data: 'boxNo'},
            { data: 'goodsNm'},
            { data: 'goodsStatusNm'},
            { data: 'faultyStatusNm'},
            { data: 'qutyNm'},
            { data: 'thickness'},
            { data: 'depth'},
            { data: 'length'},
            { data: 'pitch'},
            { data: 'outputCnt'},
        ],
        columnDefs: [
        ],
        order: [
            [ 0, 'asc' ]
        ],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,6], className: 'text-center' },
        	{ targets: [7,8,9,10,11], className: 'text-right' },
        	{ targets: [11] , render: $.fn.dataTable.render.number( ',' )},
        ],
        buttons: [
            {
                extend: 'copy',
                title: '제품출하(상세)',
            },
            {
                extend: 'excel',
                title: '제품출하(상세)',
            },
            {
                extend: 'print',
                title: '제품출하(상세)',
            }
        ],
        drawCallback : function( settings ) { //데이터 테이블 모두 호출후 실행 유사 complete       		
        	$('#box').text($('#productShipmentTableDtl').DataTable().data().count() + " BOX");
    		
        	if( isNaN( calc() ) ){
        		$('#pcs').text("0" + " PCS");        		
        	} else{
        		$('#pcs').text(addCommas(calc()) + " PCS"); 
        	}
       	}
    });
    var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
		html1 += '&nbsp;<label class="input-label-sm">마감일</label><input class="form-control" style="width:97px;" type="text" id="chooseDateFromCal"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFromCal,chooseDateFromCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateToCal"/>';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateToCal,chooseDateToCal,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="chooseDateToCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>';
		html1 += '</div>';
		html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary" id="btnTerm">기간선택</button>';
		html1 += '&nbsp;&nbsp;<select class="custom-select mr-2" id="approvalGubun" style="width:120px;"></select>';
		html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>';
		html1 += '</div>';
	$('#productShipmentViewTable_length').html(html1);
	$('#chooseDateFromCal').val(serverDateFrom);
	$('#chooseDateToCal').val(serverDateTo);
	selectBoxAppend(approvalCode, "approvalGubun", "" , 1);
    // 보기
    $('#productShipmentViewTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#productShipmentViewTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
       
        poSeq = productShipmentViewTable.row(this).data().poSeq;
        poGroup = productShipmentViewTable.row(this).data().poGroup;
		//console.log("poSeq = " + poSeq);
		//console.log("poGroup = javascript:void(0)" + poGroup);
		//$('#productShipmentTableDtl').DataTable().ajax.reload( function () {});	
		$('#approvalNm').attr('disabled', false);
		$('#btnSave').attr('disabled', false);
		$('#btnReturnSwitching').attr('disabled', true);
		$('#btnCommonSwitching').attr('disabled', true);
		$('#checkAll').attr('disabled', false);
		$("#checkAll").prop("checked", false);
		$('#goodsOutDate').val($(this).find('td').eq(16).html());
		$('#dealCorpNm').val($(this).find('td').eq(5).html());
		$('#poNo').val($(this).find('td').eq(7).html());
		$('#poGroup').val(poGroup);
		if(factoryCode == '001' || factoryCode == '002'){
			$('#poGroup').attr('disabled', false);
		}
		//$('#deliveryDealCorpNm').val($(this).find('td').eq(15).html());
		selectBoxAppend(approvalCode, "approvalNm", productShipmentViewTable.row(this).data().approvalCd , "");

		if(openrNav2Flag) {
			$('#productShipmentTableDtl').DataTable().ajax.reload( function () {});
		} else {
			sideViewFlag = true;
		}
		/*
   		$('#pcs').val(calc());
		$('#box').val($('#productShipmentTableDtl').DataTable().data().count());
		*/
    });
    
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFromCal').val());
		let dateTo = new Date($('#chooseDateToCal').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		if (dateDiff > 365) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFromCalendar').focus();
			return false;
		}
		
    	chooseDateFrom =  $('#chooseDateFromCal').val();
    	chooseDateTo =  $('#chooseDateToCal').val();
    	$('#poGroup').attr('disabled', true);
    	
	   	if (openrNav2Flag == true) {
	    	$('#productShipmentTableDtl').DataTable().clear().draw(false);
	    }
		$('#productShipmentViewTable').DataTable().ajax.reload( function () {});
		
    });
    
    // 등록 처리
    $('#btnSave').on('click', function() {  
		$('#saveBtnModal').modal('show');
    });   

    $('#saveBtnModalY').on('click',function() {
    	$.ajax({
            url: '<c:url value="/io/productShipmentDataUpdate"/>',
            type: 'POST',
            data: {
            	'menuAuth'	 	: 	menuAuth,
            	'poSeq'			:	function() { return poSeq; },
            	'poGroup'		:	function() { return poGroup; },
            	'approvalCd'	:	$("#approvalNm option:selected").val(),
				'factoryCode'	:	factoryCode,
            	'newPoGroup'	:	$('#poGroup').val(),
            },
            dataType:"json",         

            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
              //  $('#btnAddConfirmLoading').removeClass('d-none');
            },
            success: function (res) {               
                if (res.result == 'ok') {
                    $('#productShipmentViewTable').DataTable().ajax.reload( function () {});
                    toastr.success('처리완료 되었습니다.');  
                    $('#poGroup').attr('disabled', true);                  
                } else if(res.result == 'exist') {
					toastr.warning("존재하는 번호입니다.")
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                //$('#btnAddConfirm').removeClass('d-none');
                //$('#btnAddConfirmLoading').addClass('d-none');
            	$('#saveBtnModal').modal('hide');
            }
        });
    }) 

    var i = 0;	//출하취소 제품 선택여부 판단

 	//출하 취소할 제품을 선택하였는지 판단
   	$('#productShipmentTableDtl tbody').on('click', 'tr', function () {
   		customerLotNo = $(this).find('td').eq(1).text();
   		boxNoOld = $(this).find('td').eq(2).text();
   		poNoSeq = $(this).find('td').eq(0).text();   		
   		goodsCd = productShipmentTableDtl.row(this).data().goodsCd;
   		outputCnt = productShipmentTableDtl.row(this).data().outputCnt;
   		goodsNmGuide = productShipmentTableDtl.row(this).data().goodsNm;
		setTimeout(function() {
			i = 0;
			$('#productShipmentTableDtl tbody tr').each(function(){
			 	if ( $(this).hasClass("selected") ){
					i++;
				}
			});
			if (i == 0) {
				$('#btnReturn').attr('disabled', true);
				$('#btnReturnSwitching').attr('disabled', true);
				$('#btnCommonSwitching').attr('disabled', true);
			} else {
				$('#btnReturn').attr('disabled', false);
				$('#btnReturnSwitching').attr('disabled', false);
				$('#btnCommonSwitching').attr('disabled', false);
			}
			
		}, 700);
    });

 	var goodsCd = null;
 	var outputCnt = null;
    //제품불량상태로 변경
//    	$('#productShipmentTableDtl tbody').on('dblclick', 'tr', function () {
//    	   	boxNoOld = $(this).find('td').eq(2).text();
//    		poNoSeq = $(this).find('td').eq(0).text();   		
//    		goodsCd = productShipmentTableDtl.row(this).data().goodsCd;
//    		outputCnt = productShipmentTableDtl.row(this).data().outputCnt;
		
//    		$('#boxNoGuide').text(boxNoOld);
//    		$('#goodsNmGuide').text(productShipmentTableDtl.row(this).data().goodsNm);
//    		$('#poNoSeq').text(poNoSeq);
//    		$('#outputCnt').text(addCommas(outputCnt));
   		
//    		$('#newBox').val("");
//    		$('#newBox').focus();        
//    	   	$('#btnFaulty').attr('disabled',true);
//    	 	$('#newBox').attr('disabled',false);
//    		$('#faultyStatusPopupModal').modal('show');
//     });
 	//제품불량상태로 변경(스위칭버튼 클릭)
   	$('.btnSwitching').on('click', function() {   		
   	   	if ($(this).attr("id") == 'btnReturnSwitching') {
   	   	   	switchType = "returnSwitch";
   	   	   	$("#reloadText").removeClass("d-none");
   	   	} else {
   	   	   	switchType = "commonSwitch";
   	   	   	$("#reloadText").addClass("d-none");
   	   	}
   		$('#boxNoGuide').text(boxNoOld);
   		$('#goodsNmGuide').text(goodsNmGuide);
   		$('#poNoSeq').text(poNoSeq);
   		$('#outputCnt').text(addCommas(outputCnt));
   		
   		$('#newBox').val("");
   		$('#newBox').focus();        
   	   	$('#btnFaulty').attr('disabled',false);
   	 	$('#newBox').attr('disabled',false);
   	 	isBoxNoScan = false;
   		$('#faultyStatusPopupModal').modal('show');
    });
    //승인여부 변경시 조회 클릭
   	$('#approvalGubun').change(function() {
    	$('#btnRetv').trigger('click');

    });
	//제품 Switching
   	$('#btnFaulty').on('click', function () {
   	   	let goodsStatus = null;
   	   	let faultyStatus = null;
		let locationCd = null;
   	   	if ($("#newBox").val() == '' || $("#newBox").val() == null) { // BoxNo가 없을 때
            toastr.warning("BoxNo가 입력되지 않았습니다!");
            $('#newBox').focus();
            return false;
   	   	}
   		if (!isBoxNoScan) { // BoxNo를 스캔하지 않았을 때
   	   		keypress('newBox', 13);
   	   	}
   		if (!isBoxNoScan) {
   	   		return false;
   	   	}

   	   	if (switchType == "returnSwitch") { // 교체(검사반품)
   	   		goodsStatus = '001';
   	   		faultyStatus = '003';
   	   		locationCd = '010';
   	   	} else if (switchType = "commonSwitch") { // 교체(일반)
   	   		goodsStatus = '002';
   	   		faultyStatus = '001';
   	   		locationCd = '008';
   	   	}

   	   	$.ajax({	   	   	 	
	         url: '<c:url value="/io/purchaseDtlSwitching"/>',
	         type: 'POST',
	         async: false,
	         data: {
					'menuAuth'		:		menuAuth,
					'poSeq'			:		function() { return poSeq; },
					'boxNo'			:		function() { return $('#newBox').val().trim(); },
					'boxNoOld'		:		function() { return boxNoOld; },
					'remainCntOld'	:		function() { return removeCommas($('#outputCnt').text()) },
					'customerLotNo'	:		function() { return customerLotNo; },
					'goodsCd'		:		function() { return goodsCd; },
					'goodsStatus'	:		function() { return goodsStatus; },
					'faultyStatus'	:		function() { return faultyStatus; },
					'locationCd'	:		function() { return locationCd; }
	         },
	         beforeSend: function() {
	             // Box No 박스 비활성화
	             //$('#boxNo').prop('disabled',true); 
	         },
	         success: function (res) {
	             let data = res.data;
	             if (res.result == 'ok') {							
						//$('#newBox').val("");							
						toastr.success(data.boxNoOld + '(검사대기) - ' + data.boxNo + '(정상) 으로 Switching 되었습니다.', '', {timeOut: 5000});
						$('#btnFaulty').attr('disabled',false);
						$('#newBox').attr('disabled',true);
						$('#btnReturn').attr('disabled', true);
						$('#btnReturnSwitching').attr('disabled', true);
						$('#btnCommonSwitching').attr('disabled', true);
						$('#productShipmentTableDtl').DataTable().ajax.reload( function () {});	
						isBoxNoScan = false;
	             } else if (res.result == 'fail') {
	                 toastr.warning(res.message, '', {timeOut: 5000});
	                 $('#newBox').focus();
	             } else {
	                 toastr.error(res.message, '', {timeOut: 5000});
	                 $('#newBox').focus();
	             }
	             
	         },
	         complete:function() {
	         	
	         }
     	});
   	});


	var faultyDate = '';
	var faultyDesc = '';
	var faultyType = '';
	
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
		$('#productShipmentTableDtl tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){
				i++;
			}
		});
    	if (i == 0) {
			toastr.warning("검사 반품할 포장 No를 선택해 주세요!");
			return false;
		}
		
		$('#faultyPopUpModal').modal('show');
		
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
		$('#productShipmentTableDtl tbody tr').each(function(){
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
    	var dtlCount = $('#productShipmentTableDtl').DataTable().data().count();
    	
		$('#productShipmentTableDtl tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){
				var boxNo =($(this).children().eq(2).text());
				var ouputCnt= removeCommas($(this).children().eq(11).text());
			 	var rowData = new Object();
			 	var poNoSeq = removeCommas($(this).children().eq(0).text());
			 	rowData.menuAuth = menuAuth;
				rowData.boxNo = boxNo;
				rowData.ouputCnt = ouputCnt;
				rowData.poSeq = poSeq;
				rowData.poGroup = poGroup;
				rowData.dtlCount = dtlCount;
				rowData.poNoSeq = poNoSeq;
				rowData.removeTrayGubun = 'returnReInspect';
				boxArray.push(rowData);
			}
		});
				
        $.ajax({
            url: '<c:url value="/io/productOutputCancel"/>',
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
				$('#btnReturn').attr('disabled', true);
				$('#btnReturnSwitching').attr('disabled', true);
				$('#btnCommonSwitching').attr('disabled', true);
                $('#productShipmentViewTable').DataTable().ajax.reload( function () {});
                $('#productShipmentTableDtl').DataTable().ajax.reload( function () {});
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });


   	});

   	

    $("#newBox").keypress(function (e) {
        // Promise
        //new Promise((resolve, reject) => {
            if (e.which == 13){

            	$("#newBox").attr('disabled', true);
               
                if(poSeq == null || poSeq == "") {
                	$("#newBox").attr('disabled', false);
                    $("#newBox").val("");
                    $('#newBox').focus();
                    toastr.warning("포장NO를 다시 선택해주세요.");
                    return false
                }          
                //키보드입력 말고 바코드로 스캔시 풀어주기
                if ( !$.trim($('#newBox').val()) ) {
                    toastr.warning('Box No를 스캔해주세요!');
                    $("#newBox").attr('disabled', false);
                    $('#newBox').focus();
                    return false;
                }
                if( factoryCode == "001" || factoryCode == "002" ) {
	                if (($('#newBox').val().trim().length != "13") && ($('#newBox').val().trim().length != "14") && ($('#newBox').val().trim().length != "15")) {
	                    toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
	                    $("#newBox").attr('disabled', false);        
	                    $('#newBox').focus();           
	                    return false;
	                }
                } else {
                	if (($('#newBox').val().trim().length != "13") && $('#newBox').val().trim().length != "18") {
	    				toastr.warning('제품 바코드가 아닙니다. 확인해주세요');
	    				$('#newBox').focus();
	    				return false;
	    			}
                }

                $.ajax({
                    url: '<c:url value="/pd/goodsProductInfoAdmData2"/>',
                    type: 'GET',
                    async: false,
                    data: {
						'menuAuth'		:		menuAuth,
						'poSeq'			:		function() { return poSeq; },
						'boxNo'			:		function() { return $('#newBox').val().trim(); },					
						'goodsCd'		:		function() { return goodsCd; },
                    },
                    beforeSend: function() {
                        // Box No 박스 비활성화
                        //$('#boxNo').prop('disabled',true); 
                    },
                    success: function (res) {
						let data = res.data;
						if (res.result == 'ok') {	
							if (data.remainCnt != removeCommas($('#outputCnt').text())) {
								toastr.warning("스캔한 박스의 잔여수량은 " + addCommas(data.remainCnt) + " 입니다.<br>잔여수량을 확인해 주세요!");
								$("#newBox").attr('disabled', false);
						    } else {
						    	//$('#newBox').val("");
								toastr.success('확인 되었습니다.');
								$('#btnFaulty').attr('disabled',false);
								$('#newBox').attr('disabled',true);
								isBoxNoScan = true;
							}
						} else if (res.result == 'fail') {
						    toastr.warning(res.message, '', {timeOut: 5000});
						    $('#newBox').attr('disabled',false);
						    $('#newBox').focus();
						} else {
						    toastr.error(res.message, '', {timeOut: 5000});
						    $('#newBox').attr('disabled',false);
						    $('#newBox').focus();
						}
						
                    },
                    complete:function(){
                    	
                    }
                });
            }   
    });

	var barcodeNoList;
	function createBarcodeNo() {
		barcodeNoList = new Array();
		var idx = 0;

		$('#barcodeOutputWhsTable tbody tr').each(function(index){
			var locationCd =($(this).data('location-cd'));
			var barcodeNo= $(this).find('td').eq(1).html();
		 	//var inWhsDate = $("#chooseDate").val().replace(/-/g, '');
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.barcodeNo = barcodeNo;
			rowData.locationCd = locationCd;
			//rowData.inWhsDate = inWhsDate;
			barcodeNoList.push(rowData);
		});
		console.log(barcodeNoList);
		return idx;
	}
	
	function calc(){
		var sum=0;
		$('#productShipmentTableDtl tbody tr').each(function(){
		 	sum =  parseInt(($(this).find('td').eq(11).text()).replace(/,/g, '')) + sum;			
		});
		return sum;
	}

	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});

	$('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$('#productShipmentTableDtl tbody tr').each(function(){
			 	$(this).addClass("selected");
			});
			$('#btnReturn').attr('disabled', false);
			
		} else { 
			$('#productShipmentTableDtl tbody tr').each(function(){
			 	$(this).removeClass("selected");
			});
			$('#btnReturn').attr('disabled', true);
			$('#btnReturnSwitching').attr('disabled', true);
			$('#btnCommonSwitching').attr('disabled', true);
		}        
    });

	
	function updateGoodsFaultyStatus(faultyStatus)
    {
		$('#my-spinner').show();
		
		var dataArray = new Array();
		var faultyDate = $('#faultyDate').val().replace(/-/g, '');
		var faultyDesc = $('#faultyDesc').val();
		var faultyType = '';
		for (let i=0; i<goodsFaultyType.length; i++) {
			if($('#faultyType' + goodsFaultyType[i].baseCd).prop("checked")) {
				faultyType += '1';
			} else {
				faultyType += '0';
			}
		}

		$('#productShipmentTableDtl tbody tr').each(function(){
		 	if ( $(this).hasClass("selected") ){

		 		var rowData = new Object();
		 		rowData.menuAuth = menuAuth;
				rowData.boxNo = $(this).find('td').eq(2).html();
				rowData.faultyStatus = faultyStatus;
				rowData.faultyDate = faultyDate;	//정상&불량&검사반품&대기 일자
				rowData.faultyType = faultyType;	//정상&불량&검사반품&대기 유형
				rowData.faultyDesc = faultyDesc;	//정상&불량&검사반품&대기 비고
				dataArray.push(rowData); 	
			}
		});

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
                	toastr.success("검사반품으로 변경되었습니다.");
    				$('#btnReturn').attr('disabled', true);
    				$('#btnReturnSwitching').attr('disabled', true);
    				$('#btnCommonSwitching').attr('disabled', true);
            		$('#productShipmentTableDtl').DataTable().ajax.reload( function () {});
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
    }

    var viewTemp = true;	//Dtl Clear 판단
   	var openrNav2Flag = true;
   	var sideViewFlag = true;
	function openrNav2After() 
	{
		
		if ( viewTemp ){
			$('#productShipmentTableDtl').DataTable().clear().draw(false);
		}
		
    	if (sideViewFlag == true) {
			$('#productShipmentTableDtl').DataTable().ajax.reload( function () {});
    	}
    	openrNav2Flag = true;
	}

	function closerNav2After()
	{
		openrNav2Flag = false;
		sideViewFlag = false;
	}

	//기간조회~
	$('#btnTerm').on('click',function() {
		datePickFun();
	});

	
	$('#datePick').on('click',function() {
		var id ='';
		
		$.each($('.calender ul li'), function(){
			if( $(this).hasClass('clicked') ){
				id = $(this).attr('id');
			}
		});			
		datePick(id, 'chooseDateFromCal', 'chooseDateToCal',  $('#select-year').val());
	});


	//숫자만 입력하게 처리
	$(document).on('keyup keydown',"#poGroup", function(event){
		var poGroupData = $(this).val();
		   
		if (!((event.which >= 96 && event.which <= 105) || (event.which >= 48 && event.which <= 57) || event.which == 110 || event.which == 188 || event.which == 190 || event.which == 8 || event.which == 9)) {

			$('.number-float0').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); 

			toastr.warning('숫자만 입력해주세요.');
			$(this).val(poGroup);
			$(this).select();
			event.preventDefault();
			return false;
		}

		if (event.which == 110) {
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("");
			$(this).select();
			return false;
		}

		if ( !(   (event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)   ) {
			//$('.number-float2').on("blur keyup", function() {
			//   $(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("");
			$(this).select();
			return false;
		}
		
		$(this).val(addCommas($(this).val().replace(/,/g,'')));
	}); 
    
    
</script>

</body>
</html>
