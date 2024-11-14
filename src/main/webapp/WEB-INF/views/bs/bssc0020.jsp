<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%pageContext.setAttribute("newLineChar", "\n");%>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">수주대비 출고현황</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<!-- <div class="row">
					<div class="form-group input-sub m-0 row">
						&nbsp;<label class="input-label-sm">마감일</label>
					 	<input class="form-control" style="width:97px;" type="text" id="chooseDate1"/>
							<button onclick="fnPopUpCalendar(chooseDate1, chooseDate1, 'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
					&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>
					<div class="form-group input-sub m-0 row">
						<input class="form-control" style="width:97px;" type="text" id="chooseDate2"/>		
							<button onclick="fnPopUpCalendar(chooseDate2, chooseDate2, 'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
					&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label>
					<select  class="custom-select" id="poGubunCd" style="size=55px;"></select>
					&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>
				</div> -->
				<div class="open-arrow" id="arrowLeft">
					<button id="left-width-btn2" onclick="openrNav2()"
						class="btn btn-primary input-sub-search" type="button">
						<i class="mdi mdi-arrow-left"></i>
					</button>
				</div>
				<div class="table-responsive">
				
					<table id="purchaseOutputInfoTable" class="table table-bordered">
				<%-- 		<colgroup>
							<col width="5%">
							<col width="10%">
							<col width="7%">
							<col width="8%">
							<col width="6%">
							<col width="8%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="6%">
							<col width="7%">
							<col width="7%">
							<col width="10%">
						</colgroup> --%>
						<thead class="thead-light">
							<tr>
								<th>마감일</th>
								<th>납기일</th>
								<th>거래처</th>
								<th>모델 No</th>
								<th>PO Number</th>
								<th>제품명</th>
								<th>재질</th>
								<th>두께</th>
								<th>폭</th>
								<th>넓이</th>
								<th>길이</th>
								<th>피치</th>
								<th>수주수량</th>
								<th>수주금액</th>
								<th>출고수량</th>
								<th>출고금액</th>
								<th>미출고량</th>
								<th>미출고금액</th>
								<th>작업일</th>
								<th>등록 번호</th>
								<th>오더구분</th>
								<th>비고</th>
								
							</tr>
						</thead>
						<tfoot>
							<tr style="background-color:#edacb1; color:red">
								<td colspan="2" style="text-align: center">합계</td>
								<td colspan="10"></td>
								<td colspan="" id="sumInputQty" style="text-align: right">0</td>
								<td colspan="" id="sumInputPrice" style="text-align: right">0</td>
								<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
								<td colspan="" id="sumOutputPrice" style="text-align: right">0</td>
								<td colspan="" id="sumNotOutputQty" style="text-align: right">0</td>
								<td colspan="" id="sumNotOutputPrice" style="text-align: right">0</td>
								<td colspan="4"></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="right-list right-sidebar right-sidebar-fix" id="rfSidenav" style="width:40%;">
                    <div class="card" id="formBox">
                    <div class="card-body col-sm-12">
                        <div class="rightsidebar-close">                        	
                            <a href="javascript:void(0)" id="left-expand2" class="closebtn float-right" onclick="closerNav2()"><i class="mdi mdi-close"></i></a>
                        </div>
                    </div>	
                    <form id="form">
                          <div class="table-responsive">
	                    	<table id="outputHistTable" class="table table-bordered">
		                    	<colgroup>
		                            <col width="10%">
		                            <%-- <col width="15%"> --%>
		                            <col width="15%">
		                            <%-- <col width="15%"> --%>
		                            <col width="15%">
		                            <col width="8%">
		                            <col width="12%">
		                            <col width="10%">	                            
		                        </colgroup>
		                        <thead class="thead-light">
			                        <tr>
		                              <th id="outputHistOrderColumn">...</th>
		                              <!-- <th>기출고량</th> -->
		                              <th>출고량</th>
		                              <!-- <th>미출고량</th> -->
		                              <th>작업일</th>
		                              <th>승인여부</th>
		                              <th>수기출고여부</th>
		                              <th>BOX_NO</th>
		                            </tr>
		                        </thead>
                            </table>
						</div>                	                    
					</form>
				</div>
			</div><!-- ===/.right-sidebar 등록,수정===  -->
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 수입검사 가공원자재 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="procMatrlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="procMatrlPopUpModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
     <div class="modal-content">
	      <div class="modal-header" style="padding-bottom: 0px;">
	        <h5 class="modal-title" id="procMatrlPopUpLabel">제품 출하 내역</h5>
	        <!--<h5 class="modal-title" style="margin-left: 60%;">출하순서 : <label id="realMatrlDay"></label></h5>  -->
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div> 
	      
	      <div class="mb-2" style="border-bottom: 1px solid #e8e8ea; width: 81vh; margin-left: 2vh;margin-top: 1vh;"></div>
	      
	      <div class="modal-body" style="height: 72.5vh; overflow: auto;" id="scorllId">
                <table id="procMatrlPopUpTable" class="table table-bordered">
                     <thead class="thead-light text-center">
	                    <tr> 
	                    	<th>제품번호(BOX_NO)</th>
	                    	<th>출하순서</th>
	                    	<th>포장수량</th> 
	                    	<th>출고수량</th> 
	                    	<th>출고일자</th>                    	                  
	                    </tr>
                    </thead>
				</table>
	      </div>
	      
	      <div class="mb-2" style="border-bottom: 1px solid #e8e8ea; width: 81vh; margin-left: 2vh;margin-top: 1vh;"></div>
	      
	      <div class="modal-footer" style="padding-top: 0px;">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnBarcodeClase">닫기</button>
	      </div>
	    </div> 
	  </div>
	</div>
<!-- 수입검사 가공원자재 모달 종료 -->
<%@include file="../layout/bottom.jsp"%>

<script>

	let getParam = "<c:out value="${param.id}" />";
	let menuAuth = 'bssc0020';
	let currentHref = 'bssc0020';
	let currentPage = $('.'+currentHref).attr('id');
	if(getParam != ""){
		currentPage = $('#${param.id}').attr('id');
	}
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","수주대비 출고현황");
	
    let viewIdx;
    let sideView = 'add';
	var poDateFrom =  "${serverDateFrom}";
	var poDateTo =  "${serverDate}";
	var poGubunCd =  "";	
	var poVal = "";
	
	let factoryCode = "<%=factoryCode%>";
	
	//공통코드 시작
    var poGubunCode=new Array();
    <c:forEach items="${poGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		poGubunCode.push(json);
    </c:forEach>
    var pageCountArray=new Array();	//pageCount
    <c:forEach items="${pageCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		pageCountArray.push(json);
    </c:forEach>
    
    var approvalCode=new Array(); //승인여부
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
    </c:forEach>
    
    var outputCode=new Array();//수기출고여부
    <c:forEach items="${outputCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCode.push(json);
    </c:forEach>
  	//공통코드 종료
	pageCountArray.sort(function(a, b) {
	  return a.baseCd - b.baseCd;
	});
	
	var pageCd = new Array();
	var pageNm = new Array();
	
	for(var i=0; i<=pageCountArray.length; i++){
		if(i==0){
			pageCd.push(-1);
			pageNm.push("All");
		}else{
			pageCd.push(pageCountArray[(i-1)].baseCd);
			pageNm.push(pageCountArray[(i-1)].baseCdNm);
		}
	}
	
	if( factoryCode == "003" ) {
		$('#outputHistOrderColumn').text('파레트번호');
	} else {
		$('#outputHistOrderColumn').text('출하순서');
	}
	
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let purchaseOutputInfoTable = $('#purchaseOutputInfoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        lengthChange : true,
        scrollY : "58vh",
        scrollCollapse: true,
        lengthMenu : [ pageCd, pageNm ],
      //  pageLength: 20,
    //    lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
		ajax: {
            url: '<c:url value="/bs/purchaseOutputList"/>',
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
            },//마감일
            { data: 'deadLine',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },//납기일
            { data: 'dealCorpNm' },//거래처
            { data: 'poCode' },//모델NO
            { data: 'poNo' },//PO NUMBER
            { data: 'goodsNm' },//제품명
            { data: 'qutyNm' },//재질
            { data: 'thickness',//두께
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'depth',//폭
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'width',//넓이
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'length',//길이
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'pitch',//피치
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(1);
		   		}
            },
            { data: 'poQty'				},//수주수량
            { data: 'totalPrice'		}, //수주금액
            { data: 'outputCnt'			},//발주(출고)수량
            
            { data: 'outputPri'			}, //출고금액
            { data: 'remainQty'			},//미출고량
            { data: 'notOutputPri'		},//미출고금액
            { data: 'outputHistDate'	},//출고일
            { data: 'poSeq'				},//등록번호
            { data: 'poGubunNm'			},//오더구분
            { data: 'poDesc'			},//비고
            
            
            //{ data: 'poDate',
	    	//	render: function(data, type, row) {			    			
			//		return moment(data.poDate).format('YYYY-MM-DD') ;
	    	//	}
            //},
			//{ data: 'deliveryDealCorpNm' },
			
		
        ],
        columnDefs: [
        	{ targets: [7,8,9,10,11,12,13,14,15,16,17], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [7,8,9,10,11,12,13,14,15,16,17], className: 'text-right-td' },
        ],
        order: [
            [ 0, 'desc' ],
            [ 4, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '수주대비 출고현황',
            },
            {
                extend: 'excel',
                title: '수주대비 출고현황',
            },
            {
                extend: 'print',
                title: '수주대비 출고현황',
            },
        ],
        drawCallback: function () {
        	$('#purchaseOutputInfoTable tfoot').remove();
			//전역변수들
			var sumInputQty = $('#purchaseOutputInfoTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumInputPrice = $('#purchaseOutputInfoTable').DataTable().column(13,{ page: 'all'} ).data().sum();
			var sumOutputQty = $('#purchaseOutputInfoTable').DataTable().column(14,{ page: 'all'} ).data().sum();
			var sumOutputPrice = $('#purchaseOutputInfoTable').DataTable().column(15,{ page: 'all'} ).data().sum();
			var sumNotOutputQty = $('#purchaseOutputInfoTable').DataTable().column(16,{ page: 'all'} ).data().sum();
			var sumNotOutputPrice = $('#purchaseOutputInfoTable').DataTable().column(17,{ page: 'all'} ).data().sum();
			
			$('#sumInputQty').text(addCommas(sumInputQty.toFixed(0)));
			$('#sumInputPrice').text(addCommas(sumInputPrice.toFixed(0)));
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
			$('#sumOutputPrice').text(addCommas(sumOutputPrice.toFixed(0)));
			$('#sumNotOutputQty').text(addCommas(sumNotOutputQty.toFixed(0)));
			$('#sumNotOutputPrice').text(addCommas(sumNotOutputPrice.toFixed(0)));
		
        }
    });

	//상세이력
	$.fn.dataTable.ext.errMode = 'none';
	let outputHistTable = $('#outputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'f>>" +
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
        searching: true,
        pageLength: 16,
		ajax: {
            url: '<c:url value="/bs/outputHistList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	:		menuAuth,
	           	'poSeq'		:		function() { return poVal; },
            },
        },
        columns: [
            { data: 'poGroup'		},//출하순서
            //{ data: 'preOutputQty'	},//기출고량
            { data: 'outputQty'		},//출고량
            //{ data: 'remainQty'		},//미출고량
            { data: 'outputHistDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
            },//마감일
            { data: 'approvalCd',
				render: function(data, type, row){
					<c:forEach items="${approvalCd}" var="info">
					if("${info.baseCd}" == data){
						 var json = new Object();
						json.baseCdNm = "${info.baseCdNm}";
					}
					</c:forEach>
					return json.baseCdNm;
				}
            },//승인여부
            { data: 'outputGubun',
            	render: function(data, type, row){
					<c:forEach items="${outputCd}" var="info">
					if("${info.baseCd}" == data){
						 var json = new Object();
						json.baseCdNm = "${info.baseCdNm}";
					}
					</c:forEach>
					return json.baseCdNm;
				}
            },//수기출고여부
            { 
            	render: function(data, type, row, meta) {
// 					var html = '<button type="button" class="btn btn-primary" onClick="inspectionSelect('+meta.row+');" style="height: 14px;"><span>보기</span></button>';
					var html = '<label onClick="inspectionSelect('+meta.row+');" style=" border-radius: 10%;';
						html +='border: solid 1px;';
						html +='width: 100%; height: 17px; font-size:11px;';
						html +='background-color: #346cb0; color: white;">보기</label>';
					return html;
				}
            },//버튼칸
        ],
        columnDefs: [
        	{ targets: [1], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [1], className: 'text-right-td' },
        	{ targets: [0,2,3,4,5], className: 'text-center-td' },
        ],
        order: [
            [ 0, 'asc' ],
        ],
        buttons: [

        ],

    });

	let procMatrlPopUpTable;
	let poGroup = 0;
	function inspectionSelect(value){	
		poGroup = outputHistTable.row(value).data().poGroup;
		
		if(procMatrlPopUpTable == null || procMatrlPopUpTable == undefined)	{
			procMatrlPopUpTable = $('#procMatrlPopUpTable').DataTable({
		        dom : "<'row'<'col-sm-12 col-md-8'><'col-sm-12 col-md-2'>>"
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
		        //scrollY: '55vh', 
				ajax: {
					url: '<c:url value="/bs/inspectList"/>',
					type: 'GET',
					data : {
						'poSeq'	: function(){return poVal;},
						'poGroup' : function(){return poGroup;},
					},	    
				},
				columns: [
		        	{ data: 'boxNo'		},	//제품번호
		        	{ data: 'poGroup'	},	//출하순서
		        	{ data: 'packCnt'	},	//포장수량
		        	{ data: 'outputCnt'	},	//출고수량
		        	{ data: 'poDate',
						render: function(data, type, row) {
							return moment(data).format("YYYY-MM-DD");
						}
		            },
		        ],
		        columnDefs: [
		        	{ targets: [2,3], render: $.fn.dataTable.render.number( ',' ) },
		        	{ "targets": [2,3],  "className": "text-right"},
		        	{ "targets": ['_all'],  "className": "text-center"}
		        ],
		        order: [
		            //[ 0, 'asc' ]
		        ],
		        buttons: [],
		        drawCallback: function () {
					if(factoryCode == "003"){
						$('#procMatrlPopUpTable').DataTable().column(1).visible(false);
						$('#procMatrlPopUpTable').DataTable().column(2).visible(false);
					}
				},
		       
			});
		}else{
			$('#procMatrlPopUpTable').DataTable().ajax.reload();	
		}				
	    $('#realMatrlDay').text(poGroup);	
		$('#procMatrlPopUpModal').modal({backdrop: 'static'});
		$('#procMatrlPopUpModal').modal('show');
		
		//모달 닫기 버튼 클릭 시
	    $('#btnBarcodeClase').on('click', function(){
	    	$('#procMatrlPopUpModal').modal('hide');
		});
	    
	}
	//모달의 열림이 끝나고 스크롤 위치 맨위로 고정
	$('#procMatrlPopUpModal').on('shown.bs.modal',function(e){
		$('#scorllId').scrollTop(0);
	});
	

	
	
    var html1 = '<div class="row"><div class="form-group input-sub m-0 row">';
	html1 += '&nbsp;<label class="input-label-sm">마감일</label><input class="form-control" style="width:97px;" type="text" id="chooseDate1"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate1, chooseDate1, \'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate2"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate2, chooseDate2, \'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>';
	html1 += '</div>';
    html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">오더구분</label><select  class="custom-select" id="poGubunCd" style="margin-right: 5px;size=55px;"></select>&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	html1 += '</div>';
	
	 
	$('#purchaseOutputInfoTable_length').append(html1);
	$('#chooseDate1').val(poDateFrom);
	$('#chooseDate2').val(poDateTo);
	selectBoxAppend(poGubunCode, "poGubunCd", "", "1");
	
	$('#purchaseOutputInfoTable_length').find('select[name=purchaseOutputInfoTable_length]').eq(0).attr('id', 'pageCount');
	$("#pageCount").insertAfter("#btnRetv");
	$('#purchaseOutputInfoTable_length').find('label').eq(0).remove();
	$("#pageCount").removeClass('custom-select custom-select-sm form-control form-control-sm');
	$("#pageCount").addClass('custom-select ml-2'); 
	
	// 보기
    $('#purchaseOutputInfoTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#purchaseOutputInfoTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            poVal = purchaseOutputInfoTable.row(this).data().poSeq;
            $('#outputHistTable').DataTable().ajax.reload( function () {});
        }
        
    });
 	//오른쪽 창 열릴 때 리로드
    $('#left-width-btn2').on('click', function () {
		$('#outputHistTable').DataTable().ajax.reload( function () {});
    });	
    //dataTable lengthChange
	$(document).on('click','#pageCount',function(e){
		var poGubunCdFix	= $('#poGubunCd option:selected').val();
		$(document).on('change','#pageCount',function(e){
			selectBoxAppend_NameAdd2(poGubunCode, "poGubunCd", poGubunCdFix, "1","");
		});
	});
	
    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDate1').val());
		let dateTo = new Date($('#chooseDate2').val());
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
		
    	poDateFrom =  $('#chooseDate1').val();
    	poDateTo =  $('#chooseDate2').val();
		poGubunCd =  $('#poGubunCd').val();   
		$('#purchaseOutputInfoTable').DataTable().ajax.reload( function () {});
    });	

</script>

</body>
</html>