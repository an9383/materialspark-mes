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
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">수주등록</li>
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
							<button id="left-width-btn2" onclick="openrNav2()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
							</button>
						</div>
						<!-- .table-responsive -->
                     	<div class="table-responsive">
							<table id="purchaseOrderTable" class="table table-bordered">
								<colgroup>
									<col width="5%">
									<col width="5%">
									<col width="7%">
									<col width="8%">
									<col width="6%">
									<col width="10%">
									<col width="9%">
									<col width="4%">
									<col width="3%">
									<col width="3%">
									<col width="3%">
									<col width="3%">
									<col width="3%">
									<col width="6%">
									<col width="7%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
			                        <tr>
			                            <th>마감일</th>
			                            <th>오더구분</th>
			                            <th>거래처</th>
			                            <th>금액</th>
			                            <th>모델No</th>
			                            <th>PO Number</th>
			                            <th>제품명</th>
			                            <th>재질</th>
			                            <th>두께</th>
			                            <th>폭</th>
			                            <th>넓이</th>
			                            <th>길이</th>
			                            <th>피치</th>
			                            <th>오더량</th>
			                            <th>등록 번호</th>
			                            <!-- <th>출고처</th> -->
			                            <th>비고</th>
			                        </tr>
                        		</thead>
	                    	</table>
                     	</div>
                     	<!-- /.table-responsive -->
                    </div>
                    <!-- <button type="button" class="btn btn-success float-right">Excel</button> -->
				</div><!-- /.left-list -->
				<!--======================== .right-sidebar 등록,수정 ========================-->
				<div class="right-list right-sidebar right-sidebar-fix" id="rfSidenav" style="width:33%;">
                    <div class="card" id="formBox">
                    <!--오른쪽 등록 부분 상단 버튼 영역-->
                    <div class="card-body col-sm-12">
                        <div class="rightsidebar-close">
                            <a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2()"><i class="mdi mdi-close"></i></a>
                        </div>
                        <button type="button" class="btn btn-danger float-left mr-1 d-none" id="btnDelete">삭제</button>
                        <button type="button" class="btn btn-primary float-left mr-1" id="btnSugi">수기출하</button>
                        <button type="button" class="btn btn-primary float-right" id="btnEdit">수정</button>
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
	                            <th>*등록 번호</th>
	                            <td><input type="text" class="form-control" id="poSeq"  name="poSeq" disabled></td>
	                            <th>*오더구분</th>
	                            <td><select class="custom-select" id="poGubunCd2"></select></td>
	                        </tr>
	                        <tr>
	                            <th>*거래처</th>
	                            <input type="hidden" class="form-control" id="dealCorpCd"  name="dealCorpCd">
	                            <td>
		                            <div class="input-sub m-0">
		                            <input type="text" class="form-control" id="dealCorpNm" name="dealCorpNm">
		                            <button type="button" class="btn btn-primary input-sub-search" id="btnSelDealCorp" onClick="selectDealCorp('C')">
								          <span class="oi oi-magnifying-glass"></span>
							         </button>
		                            </div>
	                            </td>
	                            <th>ATTN</th>
	                            <td><input type="text" class="form-control" maxlength="50" id="poAttn" id="poAttn"  name="poAttn"></td>
	                        </tr>
	                        <tr>
	                            <th>*PO Number</th>
	                            <td><input type="text" class="form-control" maxlength="20" id="poNo"  name="poNo"></td>
	                            <th>모델No</th>
	                            <td><input type="text" class="form-control" maxlength="20" id="poCode"  name="poCode"></td>
	                        </tr>
	                        <tr>
	                        	<th>*마감일</th>
	                            <!-- <td><input type="date" class="form-control" id="deliveryDate"  name="deliveryDate"></td> -->
	                            <td>
									<div class="form-group input-sub m-0">
										<input class="form-control" type="text" id="deliveryDate" maxlength="10" disabled />
										<button onclick="fnPopUpCalendar(deliveryDate,deliveryDate,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="deliveryDateCalendar" type="button" disabled>
											<span class="oi oi-calendar"></span>
										</button>
									</div>
								</td>
	                            <th>*오더량</th>
	                            <td><input type="text" class="form-control" id="poQty"  name="poQty"></td>
	                        </tr>
	                        <tr>
	                            <th>*금액</th>
	                            <td><input type="text" class="form-control" id="totalPrice"  name="totalPrice" disabled></td>
	                            <th>*단가</th>
	                            <td><input type="text" class="form-control" id="costUnit"  name="costUnit"></td>
	                        </tr>
	                        <tr>
	                         	<th>*제품명</th>
	                         	<input type="hidden" class="form-control" id="goodsCd"  name="goodsCd">
	                            <td>
	                            	<div class="input-sub m-0">
	                            	<input type="text" class="form-control" id="goodsNm"  name="goodsNm">
	                            	<button type="button" class="btn btn-primary input-sub-search" id="btnSelGoods" onClick="selectGoodsCode()">
								          <span class="oi oi-magnifying-glass"></span>
							        </button>
							        </div> 
	                            </td>
	                            <th>*화폐단위</th>
	                            <td><select class="custom-select" id="moneyUnitCd" ></select></td>
	                        </tr>
	                        <tr>
	                            <th>재질</th>
	                            <td><input type="text" class="form-control" id="qutyNm"  name="qutyNm"></td>
	                            <th>두께</th>
	                            <td><input type="text" class="form-control" id="thickness"  name="thickness"></td>
	                        </tr>
	                        <tr>
	                            <th>폭</th>
	                            <td><input type="text" class="form-control" id="depth"  name="depth"></td>
	                            <th>너비</th>
	                            <td><input type="text" class="form-control" id="width"  name="width"></td>
	                        </tr>
	                        <tr>
	                            <th>길이</th>
	                            <td><input type="text" class="form-control" id="length"  name="length"></td>
	                            <th>피치</th>
	                            <td><input type="text" class="form-control" id="pitch"  name="pitch"></td>
	                        </tr> 
	                        <tr>
	                        	<th>샘플여부</th>
	                        	<td>
	                        		<select class="custom-select" id="sampleYn" disabled>
	                        			<option value="">선택</option>
	                        			<option value="Y">Y</option>
	                        			<option value="N">N</option>
	                        		</select>
	                        	</td>
	                        	<th>납기일</th>
	                        	<td>	                        		
									<div class="form-group input-sub m-0">
										<input class="form-control" type="text" id="deadLine" maxlength="10" disabled />
										<button onclick="fnPopUpCalendar(deadLine,deadLine,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="deadLineCalendar" type="button" disabled>
											<span class="oi oi-calendar"></span>
										</button>
									</div>								
								</td>
	                        	
	                        </tr>
	                        <tr>	                        	
	                        	<th class="d-none" name="sudelDnone">*파레트 수량</th>
	                        	<td class="d-none" name="sudelDnone"><input type="number" class="form-control" id="palletQty"  name="palletQty" value="0" disabled ></td>
	                        </tr>
	                        <tr>
								<!-- 
								<th>*출고처</th>
								<input type="hidden" class="form-control" id="deliveryDealCorpCd"  name="deliveryDealCorpCd">
	                            <td >
		                            <div class="input-sub m-0">
		                            <input type="text" class="form-control" id="deliveryDealCorpNm" name="deliveryDealCorpNm">
		                            <button type="button" class="btn btn-primary input-sub-search" id="btnSelDeliveryDealCorp" onClick="selectDealCorp('D')">
								          <span class="oi oi-magnifying-glass"></span>
							         </button>
		                            </div>
	                            </td>
	                             -->
	                            <th>비고</th>
	                            <td colspan="3"><input type="text" class="form-control" id="poDesc" name="poDesc" style="min-width:100%;"></td>
	                        </tr>                      	                        		                        	                        		                        	                        	                        
							<!--==========/table 내용 추가==========-->
						</table>
					</div>                	                    
				</form>
				</div>
				<!--저장 버튼-->
				<div class="mt-2">
                   <button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
                   <button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
				</div><!--/저장 버튼-->
			</div><!-- ===/.right-sidebar 등록,수정===  -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<!-- 삭제 확인 모달 시작-->
<div class="modal fade" id="deleteCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteCheckPopupModalLabel" aria-hidden="true">
  <div class="modal-dialog" >
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="">삭제 확인</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h6 id="deletePoSeq"></h6>
      	<p>삭제한 데이터는 복구 할 수 없습니다!</p>
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger" id="btnDeleteCheck" data-dismiss="modal" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn btn-secondary" id="btnDeleteCancel" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 삭제 확인 모달 종료 -->
<!-- 수기 출고 모달 시작-->
<div class="modal fade" id="sugiPopupModal" tabindex="-1" role="dialog" aria-labelledby="sugiPopupModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="min-width:700px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="sugiPopupModalLabel">수기 출하 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body">      	  	    	
	                 	
	            	<div class="card">                  
	                	<div class="table-responsive">
		                	<table id="sugiList" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr>
		                              <th style="min-width:100%;">등록 번호</th> 
		                               <th style="min-width:100%;" class="text-center">PO NUMBER</th>       
		                                                          <th style="min-width:100%;" class="text-center">날짜</th>
		                           
		                              <th style="min-width:100%;" class="text-center">출고량</th>
		                                                  
		                            </tr>
		                        </thead>
		                    </table>
		                </div>
		            </div>	
		        <!-- /.page-section -->	
				
	
     
		<table class="table table-bordered">
			<colgroup>
				<col width="50%">
				<col width="60%">				                     
				</colgroup>
				<tr>
				    <th>출고 일자</th>
				    <td class="text-center">
				    	<input type="date" id="sugiDate" class="form-control" style="min-width:100%; padding-right: 0px; padding-left:3px;">
				    </td>				 
				</tr>
				<tr>
				    <th>출고 수량</th>
				    <td class="text-center">
				    	<input maxlength="8" min="0" max="1000000000" type="number" class="form-control number-float3 touch3" id="sugiCnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr>
				<!-- <tr>
				    <th>수량</th>
				    <td class="text-center">
				    	<input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 touch3" id="ptfe1Cnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr> -->
	    </table>      	
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger mr-a" id="sugiDelete" data-dismiss="modal" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn-primary" id="sugiSave" data-dismiss="modal" style="min-width:70px;">저장</button>
      	<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 수기 출고  모달 끝-->
<%@include file="../layout/bottom.jsp" %>

<script>
	
	let menuAuth = 'bssc0010';
	let currentHref = 'bssc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","수주등록");
	
	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>

    var moneyUnitCode=new Array();
    <c:forEach items="${moneyUnitCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		moneyUnitCode.push(json);
    </c:forEach>
  	//공통코드 종료

    let viewIdx;
    let sideView = 'add';
    uiProcInit(true);
	uiProc(true);

	var serverDate = "${serverDate}";
	var poDate =  "${serverDate}";
	//var outputHistDate =  "${serverDate}";
	var replacePoDate = poDate.replace(/-/g, '');
	var purchaseOrderSeq =  "${purchaseOrderSeq}";
	var poDateSeq = replacePoDate + "-" + purchaseOrderSeq;
	var poDateFrom = "${serverDateFrom}";   
	var poDateTo = "${serverDate}";
	var toDay =  "${serverDate}";
	var poGubunCd =  "";

	var poNo = '';
	var poSeq = '';
	
	var outputQtyVal = '';
	
	let factoryCode = "<%=factoryCode%>";
	
	if(factoryCode == "003") {
		$('[name=sudelDnone]').removeClass('d-none');
	}
 	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let purchaseOrderTable = $('#purchaseOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-4'l><'col-sm-12 col-md-4'f><'col-sm-12 col-md-4'>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-4'i><'col-sm-12 col-md-4'p><'col-sm-12 col-md-4'>>B",
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/bs/purchaseOrderDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'		:		menuAuth,
	           	'poDateFrom'	:		function() { return poDateFrom.replace(/-/g, ''); },
	           	'poDateTo'		:		function() { return poDateTo.replace(/-/g, ''); },
	           	'poGubunCd'		:		function() { return poGubunCd; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [
			{ data: 'deliveryDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },
            { data: 'poGubunNm' },
            { data: 'dealCorpNm' },
			{ data: 'totalPrice' },
            { data: 'poCode' },
            { data: 'poNo' },
            { data: 'goodsNm' },
            { data: 'qutyNm' },
            { data: 'thickness',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'depth',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'width',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'length',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'pitch',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },            
            { data: 'poQty' },
            { data: 'poSeq' },
            //{ data: 'poDate',
	    	//	render: function(data, type, row) {			    			
			//		return moment(data).format('YYYY-MM-DD') ;
	    	//	}
            //},
            //{ data: 'deliveryDealCorpNm' }, 
            { data: 'poDesc' },                         
        ],
        columnDefs: [
        	{ targets: [3,8,9,10,11,12,13], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,8,9,10,11,12,13], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ],
            [ 6, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '영업관리',
            },
            {
                extend: 'excel',
                title: '영업관리',
            },
            {
                extend: 'print',
                title: '영업관리',
            },
        ],
    });
    
	var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '&nbsp;<label class="input-label-sm">마감일</label><input class="form-control" style="width:97px;" type="text" id="chooseDate3"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate3, chooseDate3, \'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate4"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate4, chooseDate4, \'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label><select class="custom-select" id="poGubunCd1" style="size:55px;"></select>&nbsp;  <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';

	$('#purchaseOrderTable_length').html(html1);
	$('#chooseDate3').val(poDateFrom);
	$('#chooseDate4').val(poDate);
	selectBoxAppend(poGubunCode, "poGubunCd1", "", "1");

    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDate3').val());
		let dateTo = new Date($('#chooseDate4').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		
		inWhsDateCal =  $('#poGubunCd1').val();
		poDateFrom = $('#chooseDate3').val();
		poDateTo = $('#chooseDate4').val();
		$('#btnDelete').addClass('d-none');
		$('#purchaseOrderTable').DataTable().ajax.reload( function () {});
    });	
    
    // 보기
    $('#purchaseOrderTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#purchaseOrderTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            $('#btnDelete').addClass('d-none');
            poSeq = purchaseOrderTable.row( this ).data().poSeq;
            //console.log("poSeq = " + poSeq);
            $('#btnSave').addClass('d-none');  // 저장버튼
            $.ajax({
                url: '<c:url value="/bs/purchaseOrderData"/>',
                type: 'GET',
                data: {
                	'menuAuth'	: menuAuth,
                    'poSeq'		: poSeq,
                },
                success: function (res) {
                    let data = res.data;
          			sideView = 'edit';
          			
                    // 보기
                    poSeq = data.poSeq;
                    outputQtyVal = data.outputQty;
                    $('#poSeq').val(data.poSeq);
                    $('#poDate').val(moment(data.poDate).format('YYYY-MM-DD'));
                    $('#goodsCd').val(data.goodsCd);
                    $('#goodsNm').val(data.goodsNm);
                    $('#dealCorpCd').val(data.dealCorpCd);
                    $('#dealCorpNm').val(data.dealCorpNm);
                    $('#poAttn').val(data.poAttn);
                    $('#poNo').val(data.poNo);
                    $('#poQty').val(addCommas(data.poQty));
                    $('#ouptputQty').val(data.ouptputQty);
                    $('#poCode').val(data.poCode);
                    $('#costUnit').val(addCommas(data.costUnit));
                    $('#totalPrice').val(addCommas(data.totalPrice.toString()));
                    $('#deliveryDate').val(moment(data.deliveryDate).format('YYYY-MM-DD'));
                    $('#deadLine').val(moment(data.deadLine).format('YYYY-MM-DD'));
                    $('#deliveryDealCorpCd').val(data.deliveryDealCorpCd);
                    $('#deliveryDealCorpNm').val(data.deliveryDealCorpNm);
                    $('#poDesc').val(data.poDesc);
                    $('#qutyNm').val(data.qutyNm);
                    $('#thickness').val(data.thickness);
                    $('#depth').val(data.depth);
                    $('#length').val(data.length);
                    $('#width').val(data.width);
                    $('#pitch').val(data.pitch);
                    $('#sampleYn').val(data.sampleYn);
                    $('#palletQty').val(data.palletQty);
                                    
                    uiProc(true);
                    selectBoxAppend(poGubunCode, "poGubunCd2", data.poGubunCd , "");
                    selectBoxAppend(moneyUnitCode, "moneyUnitCd", data.moneyUnitCd , "");                                                                                                                                                                                                        
                }
            });
        }
    });


        
    // 등록폼
    $('#btnAdd').on('click', function() {
        sideView = 'add';
        $('#form').each(function(){
            this.reset();
        });
        
        $('#poSeq').val(poDateSeq);

        $('#deliveryDate').val(poDate);
        $('#deadLine').val(poDate);
        //$('#deliveryDate').val(poDate);
        
        //if( true ) {
	    //    $('#poNo').val("4200009854");
	    //    //$('#goodsCd').val("A00001");
	    //    //$('#goodsNm').val("DE/SK");
	    //    
	    //    $('#poQty').val("1000");
	    //    $('#poCode').val("AAAA");
	    //    $('#poAttn').val("김담당");
	    //    $('#costUnit').val("1000");
	    //    $('#totalPrice').val("1000000");
	    //    $('#deliveryDate').val(poDate);
	    //    //$('#dealCorpCd').val("00018");
	    //    //$('#dealCorpNm').val("솔브레인");
		//	//$('#deliveryDealCorpCd').val("00018");
	    //    //$('#deliveryDealCorpNm').val("솔브레인");
	    //    $('#poDesc').val("PO등록테스트");
      	//}        
        uiProc(false); 
        $("#poQty").val("0");
        $("#costUnit").val("0");
        selectBoxAppend(poGubunCode, "poGubunCd2", "", "2");
        selectBoxAppend(moneyUnitCode, "moneyUnitCd", "", "2");              
        $('#btnSave').removeClass('d-none');  // 등록버튼

    });

    // 저장 처리
    $('#btnSave').on('click', function() {
        if( !$.trim($('#poSeq').val()) ) {
            toastr.warning('등록 번호를 입력해주세요.');
            $('#poSeq').focus();
            return false;
        }
        if( $("#poGubunCd2 option:selected").val() == "" ) {
            toastr.warning('오더구분을 선택해 주세요.');
            $('#poGubunCd2').focus();
            return false;
        }
        if ( !$.trim($('#dealCorpNm').val()) ) {
            toastr.warning('거래처를 선택해 주세요.');
            $('#btnSelDealCorp').focus();
            return false;
        }
        if ( !$.trim($('#poNo').val()) ) {
            toastr.warning('PO Number를 입력해 주세요.');
            $('#poNo').focus();
            return false;
        }
        //if ( !$.trim($('#poCode').val()) ) {
        //    toastr.warning('코드를 입력해 주세요.');
        //    $('#poCode').focus();
        //    return false;
        //}
        if ( !$.trim($('#deliveryDate').val()) ) {
            toastr.warning('마감일을 선택해 주세요.');
            $('#deliveryDateCalendar').focus();
            return false;
        }
        if ( !$.trim($('#deadLine').val()) ) {
            toastr.warning('납기일을 선택해 주세요.');
            $('#deadLineCalendar').focus();
            return false;
        }
        if ( $('#poQty').val() == "0" ) {
            toastr.warning('오더량을 입력해 주세요.');
            $('#poQty').select();
            return false;
        }
        //if ( !$.trim($('#totalPrice').val()) ) {
        //    toastr.warning('금액을 입력해 주세요.');
        //    $('#totalPrice').focus();
        //    return false;
        //}
        if ( $('#costUnit').val() == "" ) {
            toastr.warning('단가를 입력해 주세요.');
            $('#costUnit').select();
            return false;
        }

        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('제품명을 선택해 주세요.');
            $('#btnSelGoods').focus();
            return false;
        }                
        if( $("#moneyUnitCd option:selected").val() == "" ) {
            toastr.warning('화폐단위를 선택해 주세요.');
            $('#moneyUnitCd').focus();
            return false;            
        }        
        if( outputQtyVal > parseInt(removeCommas($('#poQty').val())) && sideView == "edit" ) {
            toastr.warning('오더량은 출하가 시작된 수량보다 적게 <br>설정할 수 없습니다!',{timeOut: 5000});
            $('#poQty').focus();
             return false;           
        }
        
        if(factoryCode == "003") {
        	if( $("#palletQty").val() == 0 || $("#palletQty").val() == "" || $("#palletQty").val() == null ) {
                toastr.warning('파레트 수량을 입력해주세요');
                $('#palletQty').focus();
                return false;            
            }
        }
        
        //if ( !$.trim($('#deliveryDealCorpNm').val()) ) {
        //    toastr.warning('출고처를 선택해 주세요.');
        //    $('#btnSelDeliveryDealCorp').focus();
        //    return false;
        //}
			
        var url = '<c:url value="/bs/purchaseOrderCreate"/>';
        if( sideView == "edit" ) {
        	url = '<c:url value="/bs/purchaseOrderUpdate"/>';
        }
        
		var poSeq = $('#poSeq').val();
		var poDate = poSeq.substring(0,8);
		
        $.ajax({
            url: url,
            type: 'POST',
            async: false,
            data: {
            	'menuAuth'	 			: 			menuAuth,
            	'poSeq'                 :           poSeq,                
            	'poNo'                  :           $('#poNo').val(), 
            	'goodsCd'               :           $('#goodsCd').val(),
            	'poDate'                :           poDate,
            	'poQty'                 :           $('#poQty').val().replace(/,/g, ''),	
            	'poGubunCd'             :           $('#poGubunCd2 option:selected').val(),
            	'poCode'                :           $('#poCode').val(),
            	'poAttn'                :           $('#poAttn').val(),
            	'moneyUnitCd'           :           $('#moneyUnitCd option:selected').val(),
            	'costUnit'              :           $('#costUnit').val().replace(/,/g, ''),
            	'totalPrice'            :           $('#totalPrice').val().replace(/,/g, ''),
            	'deliveryDate'          :           $('#deliveryDate').val().replace(/-/g, ''),
            	'dealCorpCd'            :           $('#dealCorpCd').val(),
            	'deliveryDealCorpCd'    :           $('#deliveryDealCorpCd').val(),
            	'sampleYn'	           	:           $('#sampleYn option:selected').val(),
            	'poDesc'                :           $('#poDesc').val(),
            	
            	'palletQty'             :           $('#palletQty').val().replaceAll(".", "").replaceAll(",", "").replaceAll("-", ""),
            	'deadLine'          :          		$('#deadLine').val().replace(/-/g, ''),
	            'regId'					:			'reg_id',
	            'updId'					:			'upd_id'
            },
            beforeSend: function() {
            	$('#my-spinner').show();
            },
            success: function (res) {
                let data = res.data;
				if (res.result == 'ok') {
					$('#purchaseOrderTable').DataTable().ajax.reload( function () {});
					uiProc(true);
					$('#btnSave').addClass('d-none');
					if( sideView == "edit" ) {
						toastr.success(res.message);
					} else {
						poDateSeq = data.poSeq;
						toastr.success(res.message);
					}
					sideView = 'edit';
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                $('#btnAddConfirm').removeClass('d-none');
                $('#btnAddConfirmLoading').addClass('d-none');
                $('#btnDelete').addClass('d-none');
                $('#my-spinner').hide();
            }
        });
    });


    //삭제 확인
	$('#btnDelete').on('click', function() {
		if (poSeq=='' || btnDeleteCheck == "undefined"){
			toastr.warning("삭제할 PO를 다시 선택해 주세요!");
			return false;
		}

		$('#deletePoSeq').text('등록 번호 - ' + poSeq + ' 삭제하시겠습니까?');
		
		$('#deleteCheckPopupModal').modal('show');

	});
	
	//삭제 처리
	$('#btnDeleteCheck').on('click', function() {
		if (poSeq=='' || btnDeleteCheck == "undefined"){
			toastr.warning("삭제할 PO를 다시 선택해 주세요!");
			return false;
		}
		
	    $.ajax({
			url: '<c:url value="/bs/purchaseOrderDelete"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 			: 			menuAuth,
	        	'poSeq'                 :           poSeq,                
	        },
	        beforeSend: function() {
	           // $('#btnAddConfirm').addClass('d-none');
	           // $('#btnAddConfirmLoading').removeClass('d-none');
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
					$('#purchaseOrderTable').DataTable().ajax.reload( function () {});
					$('#btnSave').addClass('d-none');
					$('#btnDelete').addClass('d-none');
					sideView = '';
					uiProcInit(true);
					uiProc(true);
					infoClear();
					toastr.success(res.message);
					
	            } else if (res.result == 'fail'){
	            	toastr.warning(res.message, '', {timeOut: 5000});
	            } else if (res.result == 'error'){
	            	toastr.error(res.message, '', {timeOut: 5000});
	            }
	            
	        },
	        complete:function(){
	            
	        }
	    });
	});

    // 수정폼
    $('#btnEdit').on('click', function() {
        if(sideView != 'edit') {
        	toastr.warning("수정할 목록을 선택해 주세요!");
            return false;
        }
        
        $.ajax({
            url: '<c:url value="/bs/purchaseOrderAdmUpdateCheck"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: menuAuth,
                'poSeq'		: poSeq,
            },
            success: function (res) {
            	if (res.result =="ok") {
                	toastr.success(res.message);
            		uiProc(false);
            		$('#btnDelete').removeClass('d-none');
                    $('#btnSave').removeClass('d-none');  
                } else if (res.result=="fail") {
                	toastr.success(res.message);
                	uiProc2(false);
            		$('#btnDelete').removeClass('d-none');
                    $('#btnSave').removeClass('d-none');
                } else if (res.result=="error") {
                	toastr.success(res.message);
                }
            }
        });
		
    });

   	function uiProcInit(flag)
   	{
   		//$("#poSeq").attr("disabled",flag);
        $("#poDate").attr("disabled",flag);
        $("#goodsNm").attr("disabled",flag); 
        $("#dealCorpNm").attr("disabled",flag);
        $("#deliveryDealCorpNm").attr("disabled",flag);                  
        $("#qutyNm").attr("disabled",flag);   
        $("#poCode").attr("disabled",flag);
        $("#thickness").attr("disabled",flag);
        $("#depth").attr("disabled",flag);
        $("#length").attr("disabled",flag);
        $("#width").attr("disabled",flag);
        $("#pitch").attr("disabled",flag);
   	}
   	    
   	function uiProc(flag)
   	{
   		//$("#poSeq").attr("disabled",flag);
        $("#poNo").attr("disabled",flag);                
		//$("#goodsNm").attr("disabled",flag);               
        $("#poQty").attr("disabled",flag);   
        $("#poGubunCd2").attr("disabled",flag);
        $("#poAttn").attr("disabled",flag);
        $("#moneyUnitCd").attr("disabled",flag);
        $("#costUnit").attr("disabled",flag);  
        //$("#totalPrice").attr("disabled",flag);
        //$("#deliveryDate").attr("disabled",flag);
        $("#deliveryDateCalendar").attr("disabled",flag);
        //$("#dealCorpNm").attr("disabled",flag);  
        //$("#deliveryDealCorpNm").attr("disabled",flag);
        $("#poDesc").attr("disabled",flag);
        $("#btnSelDealCorp").attr("disabled",flag);
        $("#btnSelGoods").attr("disabled",flag);
        $("#btnSelDeliveryDealCorp").attr("disabled",flag);
        $("#sampleYn").attr("disabled",flag);       
        $("#palletQty").attr("disabled",flag);      
        $("#deadLineCalendar").attr("disabled",flag);
   	}

   	function uiProc2(flag)
   	{
   		//$("#poSeq").attr("disabled",flag);
        $("#poNo").attr("disabled",flag);                
		//$("#goodsNm").attr("disabled",flag);               
        //$("#poQty").attr("disabled",flag);   
        $("#poGubunCd2").attr("disabled",flag);
        $("#poAttn").attr("disabled",flag);
        $("#moneyUnitCd").attr("disabled",flag);
        $("#costUnit").attr("disabled",flag);  
        //$("#totalPrice").attr("disabled",flag);
        //$("#deliveryDate").attr("disabled",flag);
        $("#deliveryDateCalendar").attr("disabled",flag);
        //$("#dealCorpNm").attr("disabled",flag);  
        //$("#deliveryDealCorpNm").attr("disabled",flag);
        $("#poDesc").attr("disabled",flag);
        $("#btnSelDealCorp").attr("disabled",flag);
        //$("#btnSelGoods").attr("disabled",flag);
        $("#btnSelDeliveryDealCorp").attr("disabled",flag);                        
   	}

	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable;
	var sFlag;
   	function selectDealCorp(flag)
   	{
   	   	sFlag = flag;
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
		            	'menuAuth'	 : menuAuth,
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
		            [ 1, 'asc' ]
		        ],

		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = dealCorpPopUpTable.row( this ).data();
		    	if(sFlag == "C") {
					$('#dealCorpCd').val(data.dealCorpCd);
					$('#dealCorpNm').val(data.dealCorpNm);
		    	} else {
					$('#deliveryDealCorpCd').val(data.dealCorpCd);
					$('#deliveryDealCorpNm').val(data.dealCorpNm);			    	
			    }	
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}

		$('#dealCorpPopUpModal').modal('show');		
   	}   	
  	//거래처정보조회 팝업 시작    
  
   	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode()
   	{
   	   	if($('#dealCorpNm').val() == '' || $('#dealCorpNm').val() == null){
			toastr.warning("거래처를 선택해주세요.");
			return false;
   	   	}
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
		            	'menuAuth'	 : menuAuth,
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
		            [ 1, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#goodsCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = goodsCdPopUpTable.row( this ).data();
                $('#goodsCd').val(data.goodsCd);
                $('#goodsNm').val(data.goodsNm);
                
		        $.ajax({
		            url: '<c:url value="/bm/goodsCodeData"/>',
		            type: 'GET',
		            async: false,
		            data: {
		            	'menuAuth'	: menuAuth,
		                'goodsCd'	: data.goodsCd
		            },
		            success: function (res) {
		                let data = res.data;
		                let alnidata = res.alnidata;
		                let filmdata = res.filmdata;

		                $('#qutyNm').val(alnidata.qutyNm);
		                $('#thickness').val(alnidata.thickness);
		                $('#depth').val(alnidata.depth);
		                $('#width').val(alnidata.width);
		                $('#length').val(alnidata.length);
		                $('#pitch').val(alnidata.pitch);

		                $('#poCode').val(data.modelNo);

		                $.ajax({
				            url: '<c:url value="bm/custCorpPrice"/>',
				            type: 'GET',
				            async: false,
				            data: {
				                'goodsCd'	: data.goodsCd,
				                'poSeq'		: $('#poSeq').val(),
				                'dealCorpCd': $('#dealCorpCd').val()
				            },
				            success: function (res) {
				                let data = res.data;

				                if(data == null){
				                	$('#costUnit').val('0');
				                	$('#moneyUnitCd').val('');
						        }else {
							        $('#costUnit').val(addCommas(data.unitCost));
							        $('#moneyUnitCd').val(data.moneyUnitCd);
						        }
				            }
				        });
		            }
		        });
                $('#goodsPopUpModal').modal('hide');
                
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}
		    
		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료  
   	
   	//콤마(,) 생성
	function addCommas(x) {
          return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
     }

    //press로 하면 꾹 누르고있는것도 예외처리 되지만 값계산이 제대로 안됨
    //keyup으로하면 값계산은 제대로 되지만 빠르게입력시 오류
    $("#poQty").keyup(function(evt) {

        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let poQty = $(this).val().replace(/,/g, '');
    	if (reg.test(poQty)) {
    		poQty = poQty.replace(reg, '');
    		$("#poQty").val(   addCommas(poQty) );
    		return false;
    	}
    	
        var charCode = (evt.which) ? evt.which : event.keyCode;
		//toastr.warning(charCode);
		if ( !(	(charCode > 47 && charCode < 58) || (charCode > 95 && charCode < 106) || ( charCode == 8 || event.which == 9 || event.which == 13 || event.which == 16 || charCode == 46 || charCode == 110 || charCode == 190)	)	){
			$(this).val(	addCommas(poQty.slice(0,-1))	);
			return false;
		}

		if ($(this).val() == "00") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		// 1000 이하의 숫자만 입력가능
		//var _pattern1 = /^\d{4}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
		//if (_pattern1.test(poQty)) {
		//	toastr.warning("1000이하로 입력가능합니다.")
	    //	$(this).val($(this).val().slice(0,-1));
	    //    return false;
		//}

		// 소수점(.)이 두번 이상 나오지 못하게
		var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		if (_pattern0.test(poQty)) {
			toastr.warning("양수만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
			return false;
		} //else {
		//	if ( charCode == 110 || charCode == 190 ) {
		//		toastr.warning(".는 한번만 입력 가능합니다.")
		//		$(this).val(	addCommas(poQty.slice(0,-1))	);
		//		return false;
        //  }
		//}
		
		// 소수점 첫째자리까지만 입력가능
		var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
		if (_pattern2.test(poQty)) {
			toastr.warning("소수점 첫째자리까지 입력가능합니다.")
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		costUnit = $("#costUnit").val().replace(/,/g, '');
		let totalPrice = (poQty * costUnit).toFixed(2);			//※ 주의사항!	​100*0.01 = 계산시 0.999999가 나올 때 -> (계산값).toFixed(0) 해주면 됨
		 $("#totalPrice").val(addCommas(totalPrice));
		$(this).val(addCommas(poQty));

    });

    $("#costUnit").keyup(function(evt) {

        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let costUnit = $(this).val().replace(/,/g, '');
    	if (reg.test(costUnit)) {
    		toastr.warning("숫자만 입력해 주세요.")
    		costUnit = costUnit.replace(reg, '');
    		$("#costUnit").val("0");
    		$(this).select();
    		return false;
    	}

    	if ($(this).val() == "00") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
		
        var charCode = (evt.which) ? evt.which : event.keyCode;
		//toastr.warning(charCode);
		if ( !(	(charCode > 47 && charCode < 58) || (charCode > 95 && charCode < 106) || ( charCode == 8 || event.which == 9 || event.which == 13 || event.which == 16 || charCode == 46 || charCode == 110 || charCode == 190)	)	){
			toastr.warning("숫자만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		// 1000 이하의 숫자만 입력가능
		//var _pattern1 = /^\d{4}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
		//if (_pattern1.test(costUnit)) {
		//	toastr.warning("1000이하로 입력가능합니다.")
	    //	$(this).val($(this).val().slice(0,-1));
	    //    return false;
		//}

		// 소수점(.)이 두번 이상 나오지 못하게
		var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		if (_pattern0.test(costUnit)) {
			//toastr.warning(". 입력")
		} else {
			if ( charCode == 110 || charCode == 190 ) {
				toastr.warning(".는 한번만 입력 가능합니다.")
				$(this).val("0");
				$(this).select();
				return false;
            }
		}
		
		// 소수점 첫째자리까지만 입력가능
		var _pattern2 = /^\d*[.]\d{3}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
		if (_pattern2.test(costUnit)) {
			toastr.warning("소수점 둘째자리까지 입력가능합니다.")
			$(this).val("0");
			$(this).select();
			return false;
		}

		let poQty = $("#poQty").val().replace(/,/g, '');
		let totalPrice = (poQty * costUnit).toFixed(2);			//※ 주의사항!	​100*0.01 = 계산시 0.999999가 나올 때 -> (계산값).toFixed(0) 해주면 됨
        $("#totalPrice").val(addCommas(totalPrice));
		$(this).val(addCommas(costUnit));
    });

	function infoClear() {
		$('#poSeq').val('');
		$('#poGubunCd2').val('');
		$('#dealCorpCd').val('');
		$('#dealCorpNm').val('');
		$('#poAttn').val('');
		$('#poNo').val('');
		$('#poCode').val('');
		$('#deliveryDate').val('');
		$('#poQty').val('');
		$('#totalPrice').val('');
		$('#costUnit').val('');
		$('#goodsCd').val('');
		$('#goodsNm').val('');
		$('#moneyUnitCd').val('');
		$('#qutyNm').val('');
		$('#thickness').val('');
		$('#depth').val('');
		$('#width').val('');
		$('#length').val('');
		$('#pitch').val('');
		$('#poDesc').val('');
	}

    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let sugiList = $('#sugiList').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
            url: '<c:url value="/bs/purchaseOutputHistListSugi"/>',
            type: 'GET',
            data: {
            	'menuAuth'		:		menuAuth,	     
	           	'poSeq'		:		function() { return poSeq; },
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'poNo',
        columns: [		
            { data: 'poSeq' },
            { data: 'poNo' },
			{ data: 'outputHistDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			 },       
            { data: 'outputQty' },
                       
        ],
        columnDefs: [
        	{ targets: [3], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ],         
        ],
      
    });
    

	$('#btnSugi').on('click',function(){
		if (poSeq == "" || poSeq == null) {
    		toastr.warning("등록할 수주를 선택해 주세요.");
			return false;
    	}
		$('#sugiDate').val(toDay);
		$('#sugiCnt').val("0");
		$('#sugiPopupModal').modal('show');
		$('#sugiList').DataTable().ajax.reload( function () {});
	});

	$('#sugiSave').on('click',function(){
		
		if (poSeq == "" || poSeq == null) {
    		toastr.warning("등록할 수주를 선택해 주세요.");
			return false;
    	}
		if ($('#sugiDate').val() == "" || $('#sugiDate').val() == null) {
    		toastr.warning("출고일자를 입력해 주세요.");
    		$('#sugiDate').focus();
			return false;
    	}

		if ($('#sugiCnt') == "0" || $('#sugiCnt') == '') {
    		toastr.warning("출고수량을 입력해주세요.");
    		$('#sugiCnt').focus();
			return false;
    	}
    	

		$('#my-spinner').show();		
		
		let url = '<c:url value="bs/purchaseOrderHistOutputGubunCreate"/>';			
		
		
		var rowData = new Object();
		rowData.poSeq = poSeq;
		rowData.poNo = $('#poNo').val();
		rowData.outputHistDate =  $('#sugiDate').val().substring(0,10).replace(/-/g,"");	
		rowData.outputQty = $('#sugiCnt').val().replace(/,/g,"");
		rowData.outputGubun = '002';
		rowData.poQty = $('#poQty').val().replace(/,/g,"");
		
		let tempSideView = sideView;			
			
		$.ajax({
			url: url,
			type: 'POST',
			async: false,
			datatype: 'json',
	        data:  {
				'poSeq'				:		function(){return rowData.poSeq;},
				'poNo'				:		function(){return rowData.poNo;},
				'outputHistDate'    :       function(){return rowData.outputHistDate;},
                'outputQty'         :       function(){return rowData.outputQty;},
                'outputGubun'     	:       function(){return rowData.outputGubun ;},
                'poQty'				:		function(){return rowData.poQty;}
                
                
	        },
			success: function (res) {
   	            let result = res.result;
   	            if (res.result == 'ok') {	   	     		
	   	     		toastr.success("저장되었습니다.");     	            	
				}
   	            else if (res.result == 'fail'){		   	     		
		   	 			toastr.error(res.message, '', {timeOut: 5000});		   	 		
				} else if(res.result == 'error'){
					toastr.error(res.message, '', {timeOut: 5000});
				}
   	        },
   	        complete:function(){   	        
   	        	$('#my-spinner').hide();
			}
		});
		
		
	});

	$('#sugiDelete').on('click',function(){
		

		if ($('#sugiList').DataTable().data().count() == 0) {
    		toastr.warning("삭제할 목록이 없습니다.");    		
			return false;
    	}
    	

		$('#my-spinner').show();		
		
		let url = '<c:url value="bs/purchaseOrderHistOutputGubunDelete"/>';			
		
		
		var rowData = new Object();
		rowData.poSeq = poSeq;

		
		let tempSideView = sideView;			
			
		$.ajax({
			url: url,
			type: 'POST',
			async: false,
			datatype: 'json',
	        data:  {
				'poSeq'				:		function(){return rowData.poSeq;},
	        },
			success: function (res) {
   	            let result = res.result;
   	            if (res.result == 'ok') {	   	     		
	   	     		toastr.success("삭제되었습니다.");     	            	
				}
   	            else if (res.result == 'fail'){		   	     		
		   	 			toastr.error(res.message, '', {timeOut: 5000});		   	 		
				} else if(res.result == 'error'){
					toastr.error(res.message, '', {timeOut: 5000});
				}
   	        },
   	        complete:function(){   	        
   	        	$('#my-spinner').hide();
			}
		});
	});
	
	//파레트 수량 입력 시
	$('#palletQty').on('keyup', function(){
		
		let value = $(this).val();
		let _pattern0 = /^\d*[.]\d*$/; 
		let _pattern1 = /^\d*[-]\d*$/;
		
		if( value<0 || value>9999999 ) {
			toastr.warning("0~9999999의 값을 입력해주새요.");
			$(this).val("");
			return false;
		} else if (_pattern0.test(value) || _pattern1.test(value)) {
			toastr.warning("정수만 입력해주세요");
			$(this).val("");
			return false;
		} else {
			$(this).val(value);
			//$(this).val(addCommas(value));
		}
	});
	

</script>

</body>
</html>