<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<% String userNm = session.getAttribute("userNm").toString(); %>
<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">자재 부적합판정</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="padding-top:0px;">
				<!-- .table-responsive -->			
				<div id="tab1View">
					<div class="table-responsive" style="margin-top: 8px;">
						<table id="faultyMatrlList" class="table table-bordered">
							<colgroup>
							<%
								if(factoryCode.equals("003")){
							%>
								<col width="3%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="6%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="7%">
								<col width="10%">
								<col width="10%">
								<col width="9%">
							<%
								} else {
							%>	
								<col width="3%">
								<col width="7%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="5%">
								<col width="8%">
								<col width="8%">
								<col width="8%">
								<col width="5%">
								<col width="5%">
								<col width="7%">
								<col width="10%">
								<col width="9%">
							<%
								}
							%>	
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th style="min-width:10px" class="text-center">
										<input type="checkbox" id="checkAll" name="checkAll" style="min-width: 10px; width: 20px; height: 20px;">
									</th>
									<th style="min-width:40px" class="text-center">가입고일</th>
									<th style="min-width:40px" class="text-center">비고</th>
									<th style="min-width:40px" class="text-center">승인상태</th>
									<th style="min-width:40px" class="text-center">자재상태</th>
									<th style="min-width:40px" class="text-center">자재코드</th>
									<th style="min-width:160px" class="text-center">자재명</th>
									<th style="min-width:130px" class="text-center">Barcode No</th>
									<th style="min-width:50px" class="text-center">공급업체</th>
									<th style="min-width:40px" class="text-center">입고일</th>
									<th style="min-width:40px" class="text-center">수입검사일</th>
									<th style="min-width:40px" class="text-center">부적합일</th>
									<th style="min-width:40px" class="text-center">가입고량</th>
									<th style="min-width:40px" class="text-center">반품량</th>								
									<th style="min-width:40px" class="text-center">불량유형</th>
									<th style="min-width:40px" class="text-center">Film 불량유형</th>
									<th style="min-width:40px" class="text-center">불량비고</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="12" style="text-align:center">합계</td>
									<td id="sumPreInWhsQty" style="text-align:right">0</td>
									<td id="sumReturnQty" style="text-align:right">0</td>
									<td colspan="3"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->


<!-- 판정 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="judgementPopUpModal" tabindex="-1" role="dialog" aria-labelledby="judgementPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="judgementPopUpLabel">판정 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<form id="form2">
							  <table class="table table-bordered mb-2" id="">
								<colgroup>
									<col width="20%">
									<col width="30%">
									<col width="20%">
									<col width="30%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th colspan="4">부적합처리</th>
									</tr>
									<tr>
										<th>부적합처리</th>
										<td colspan="3">
											<div class="">
												<div class="custom-control custom-control-inline custom-radio row">
					                           	 	<input type="radio" class="custom-control-input" name="approvalYn" id="apr1" value="001" onclick=""> 
					                           	 	<label class="custom-control-label" for="apr1">재사용</label>
					                          	</div>	
												<div class="custom-control custom-control-inline custom-radio row">
					                           	 	<input type="radio" class="custom-control-input" name="approvalYn" id="apr2" value="002" onclick=""> 
					                           	 	<label class="custom-control-label" for="apr2">반품</label>
					                          	</div>	
					                         	 <div class="custom-control custom-control-inline custom-radio row">
					                            	<input type="radio" class="custom-control-input" name="approvalYn" id="apr3" value="003" onclick=""> 
					                            	<label class="custom-control-label" for="apr3">폐기</label>
					                          	</div>
				                          	</div>
										</td>
									</tr>
									<tr>
										<th id="changingDate">...</th>
										<td>
											<div class="form-group input-sub m-0" style="max-width: 100%">
												<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate" name="frrrdDate">									
											</div>
										</td>
										<th>부적합 담당자</th>
										<td>
											<div class="input-sub m-0" style="max-width: 100%">
											<input type="hidden" class="form-control"
												style="max-width: 100%" id="matrlChargr" name="matrlChargr"
												disabled> <input type="text" class="form-control"
												style="max-width: 100%" id="matrlChargrNm" name="matrlChargrNm"
												disabled>
											<button type="button"
												class="btn btn-primary input-sub-search" name="btnfaultyChargr"
												id="btnfaultyChargr" onClick="selectPreWorkCharger();">
												<span class="oi oi-magnifying-glass"></span>
											</button>
										</div>
										</td>
									</tr>								
									<tr>
										<th>비고</th>
										<td colspan="3"><input type="text" class="form-control" id="frrrdDesc" name="faultyDesc" style="max-width:100%" ></td>
									</tr>
									<tr>
										<th>불량 유형</th>
										<td colspan="3">
										<c:forEach var="item" items="${matrlFaultyType}">
											<div class="row">
												<div class="col-6 text-center">${item.baseCdNm}</div>
												<div class="col-6 text-center">
													<input type="checkbox" id="frrrdType${item.baseCd}" style="width: 20px;height: 20px;">
												</div>	
											</div>
										</c:forEach>
										</td>
									</tr>
								</thead>
						       </table>						      
						       </form>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<label class="mr-5">*재사용 시 선택된 자재는 선입선출이 <span style="font-weight: bold;">미적용</span>됩니다.</label>
				<button type="button" class="btn btn-primary" id="btnFaultySave" data-dismiss="modal" style="min-width: 70px;">확인</button>
				<button type="button" class="btn btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 판정 모달 종료 -->
<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0170';
	let currentHref = 'qmsc0170';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","자재 부적합판정");
	var userNm = "<%=userNm%>";
	let factoryCode = "<%=factoryCode%>";
    
	//공통코드 처리 시작
    var matrlFaultyType=new Array();	//자재불량유형
    <c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
    </c:forEach>

    if(factoryCode == '003'){
    	var filmFaultyType=new Array();	//자재불량유형
        <c:forEach items="${filmFaultyType}" var="info">
    		var json=new Object();
    		json.baseCd="${info.baseCd}";
    		json.baseCdNm="${info.baseCdNm}";
    		filmFaultyType.push(json);
        </c:forEach>
    }
    
    var faultyMatrlCdList=new Array();	//matrlCdList
    <c:forEach items="${matrlInOutWhsAdmList}" var="info">
		var json=new Object();
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		faultyMatrlCdList.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    
    faultyMatrlCdList = [...new Set(faultyMatrlCdList.map(JSON.stringify))].map(JSON.parse);
    
    var serverDateFrom =  "${serverDateFrom}"; 
    var serverDateTo =  "${serverDateTo}";
	var inWhsDateFrom =  "${serverDateFrom}"; 
	var inWhsDateTo =  "${serverDateTo}"; 
	var tapTemp = 1;
	var frrrdType = '';
	var frrrdDesc = '';
	var approvalCd = '';
	var matrlChargr = '';

	if( factoryCode == '001' || factoryCode == '002'){
		$('#changingDate').text("부적합 등록일");
	} else if( factoryCode == '003' ) {
		$('#changingDate').text("재검일자");
	} else {
		toastr.error("시스템오류입니다. 관리자에게 문의해주세요.");
	}
	

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let faultyMatrlList = $('#faultyMatrlList').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        scrollX: true,
        scrollY : "65vh",
        scrollCollapse: true,
        pageLength: 9999,
        ajax: {
            url: '<c:url value="/io/matrlFaultyTypeDataList"/>',
            type: 'GET',
            data: {
				'menuAuth'	 	:	menuAuth,
				'inWhsDateFrom'	:	function() { return inWhsDateFrom.replace(/-/g, ''); },
				'inWhsDateTo'	:	function() { return inWhsDateTo.replace(/-/g, ''); },
				'tapTemp'		:	function() { return tapTemp; },
				'matrlCd'		: 	function() { return $('#selectMatrlCd option:selected').val(); }
            },
        },
        //rowId: 'lotNo',
        columns: [
	    	{
	    		render: function(data, type, row, meta) {
					return '<input type="checkbox" id="chk-' + meta.row + '" name="chk" style="width: 20px; height: 20px;">';
	    		}
			},
            {
                data: 'preInWhsDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
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
            { data: 'spplyDealCorpNm' },
            {
                data: 'inWhsDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            {
                data: 'inspctDate',
                render: function(data, type, row) {
					if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
            },
            { 
                data: 'frrrdDate',
                render: function(data, type, row) {
                	if(data != "" && data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
                } 
            },
            
            
            { data: 'preInWhsQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
                }   
			},
			{ data: 'remainQty',
				render: function(data, type, row) {					
					return parseFloat(data).toFixed(2);
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
			{
    			data: '',
    			render: function(data, type, row) {
					if (factoryCode == '003') {
                		if (row['filmType'] != null) {
                			let fCount = 0;
        					let filmFaultyTypeNm = '';
	                		for (let jj=0; jj<row['filmType'].length; jj++) {
								if (row['filmType'].substring(jj,jj+1) == '1'){
									filmFaultyTypeNm += filmFaultyType[jj].baseCdNm + ', ';
									fCount++;
								}
							}
							if (fCount == 0) {
								filmFaultyTypeNm = '-';
							} else {
								filmFaultyTypeNm = filmFaultyTypeNm.substring(0, filmFaultyTypeNm.length-2);
								return filmFaultyTypeNm;
							}
	                	} else {
	                    	return '';
	                    }
                	} else {
                    	return '';
                    }
	    		}
    		},
            { data: 'frrrdDesc' },
        ],
        columnDefs: [
             	{ targets: [12,13], render: $.fn.dataTable.render.number( ',' )},
            	{ targets: [12,13], className: 'text-right' }, 
            	/* { targets: [15],
                	render: function(data,type,row){
						if(factoryCode != '003'){
							return searchable:false, visible:false;
						} else return className: 'text-center';
                	}
            	} */
        ],
        //order: [
        //    [ 6, 'asc' ]
        //],
		drawCallback: function () {
			if(factoryCode != '003'){
				$('#faultyMatrlList').DataTable().column(15).visible(false);
			}
			$('#faultyMatrlList tfoot').remove();
			var sumPreInWhsQty = $('#faultyMatrlList').DataTable().column(12,{ page: 'all'} ).data().sum();
			var sumReturnQty = $('#faultyMatrlList').DataTable().column(13,{ page: 'all'} ).data().sum();
			$('#sumPreInWhsQty').text(addCommas(sumPreInWhsQty.toFixed(2)));
			$('#sumReturnQty').text(addCommas(sumReturnQty.toFixed(2)));
		},
        buttons: [
            {
                extend: 'copy',
                title: '자재 부적합판정',
            },
            {
                extend: 'excel',
                title: '자재 부적합판정',
            },
            {
                extend: 'print',
                title: '자재 부적합판정',
            }
        ],
    });

	var html1 = '<div class="row">';
		html1 += '&nbsp<label class="input-label-sm">부적합일</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromCalType1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '&nbsp&nbsp&nbsp<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
		html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateToFromToType1" type="button">';
		html1 += '<span class="oi oi-calendar"></span>';
		html1 += '</button>'; 
		html1 += '</div>';
		html1 += '<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>'
		html1 += '<select class="custom-select ml-2" id="selectMatrlCd"></select>';
		html1 += '<button type="button" class="btn btn-primary ml-5" id="btnUnreceived">판정</button>';		
		html1 += '</div>';
    
	$('#faultyMatrlList_length').html(html1);
	$('#chooseDateFrom').val(serverDateFrom);
	$('#chooseDateTo').val(serverDateTo);

	selectBoxAppend_NameAdd(faultyMatrlCdList, "selectMatrlCd", "", "1", "자재명");

	$('#selectMatrlCd').on('change', function(){
		$('#faultyMatrlList').DataTable().ajax.reload( function () {});
	});
	
   /*  // 보기
    $('#matrlInOutWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#matrlInOutWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	 */

    $('#btnRetv').on('click', function() {
		let dateFrom = new Date($('#chooseDateFrom').val());
		let dateTo = new Date($('#chooseDateTo').val());
		let dateDiff = Math.ceil((dateTo.getTime()-dateFrom.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("검색기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateFrom').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateFrom').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("검색 가능 기간은 최대 한달입니다!");
			$('#chooseDateFrom').focus();
			return false;
		}
		
		inWhsDateFrom =  $('#chooseDateFrom').val();
		inWhsDateTo =  $('#chooseDateTo').val();
		$('#faultyMatrlList').DataTable().ajax.reload( function () {});

		$.ajax({
            url: '/qm/matrlFaultyTypeDataList_F3',
            type: 'GET',
            data: {
            	'menuAuth'	 	:	menuAuth,
				'inWhsDateFrom'	:	function() { return inWhsDateFrom.replace(/-/g, ''); },
				'inWhsDateTo'	:	function() { return inWhsDateTo.replace(/-/g, ''); },
				'tapTemp'		:	function() { return tapTemp; },
            },
            success: function (res) {
				let data = res.data;
                if (res.result == 'ok') {

                	var selectMatrlCdCopy = $('#selectMatrlCd option:selected').val();
                	$('#selectMatrlCd').empty();
	   				faultyMatrlCdList = new Array();	//matrlCdList
	   				
	   		        for(var i=0;  i<data.length; i++){ 
	   		         	var json = new Object();
	   		         	json.baseCd		= data[i].matrlCd;
	   		         	json.baseCdNm	= data[i].matrlNm;
	   		         	faultyMatrlCdList.push(json);
	   		         }
	   		         
	   		         faultyMatrlCdList = [...new Set(faultyMatrlCdList.map(JSON.stringify))].map(JSON.parse);
	   		         selectBoxAppend_NameAdd(faultyMatrlCdList, "selectMatrlCd", selectMatrlCdCopy, "1", "자재명");
	                
                } else {
               	 toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){}
        });
        
    });	

    $('#checkAll').on('click', function(){
		if($("#checkAll").prop("checked")) { 
			$("input[type=checkbox]").prop("checked",true); 
		} else { 
			$("input[type=checkbox]").prop("checked",false);
		}        
    });    

	//미승인
	$('#btnUnreceived').on('click', function() {
    	if ($('input[name=chk]:checked').length == 0) {
			toastr.warning("판정할 자재를 선택해주세요!");
    		return false;
        }
    	/*if ($('input[name=chk]:checked').length != 1) {
			toastr.warning("하나의 자재만 선택해주세요!");
    		return false;
        }*/
    	
    	$('#frrrdDate').val(serverDateTo);

    	
    	$('input[name=approvalYn]').prop('checked',false);
    	

    	$('#matrlChargrNm').val('');
		$('#matrlChargr').val('');
	
    	
    	/* frrrdDate = '';
    	frrrdType = '';
		frrrdDesc = '';
		updateMtrlInOutWhsInspectQty("002");
		updateInspectCd(""); */

		let rowCount		= $('input[name=chk]:checked').attr('id').replace("chk-", "");
    	let checkFrrrdType	= faultyMatrlList.row(rowCount).data().frrrdType;
    	let checkFrrrdDesc	= faultyMatrlList.row(rowCount).data().frrrdDesc;
    	$('#frrrdDesc').val(checkFrrrdDesc);

    	if (checkFrrrdType != null && checkFrrrdType != '') {
	    	for (let i=0; i<matrlFaultyType.length; i++) {
		    	
	    		if (checkFrrrdType.substring(i,i+1) == '1') {
	        		//console.log(checkFrrrdType.substring(i,i+1));	    			
	    		}
	        }
    	}

    	for (var i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
    	
		
		$('#judgementPopUpModal').modal('show');
	});    

	//불량&보류&반품등록 저장 클릭 시
	//불량유형 선택항목 1 미선택 0
	$('#btnFaultySave').on('click', function() {
		frrrdDate = '';
		frrrdType = '';
		frrrdDesc = '';

		
		if($('input[name=approvalYn]:checked').val() == null){
			toastr.warning("판정할 항목을 선택해 주세요!");
			$('#apr1').focus();
			return false;
		} 

		if(!$.trim($('#frrrdDate').val())){
			toastr.warning("날짜를 선택해 주세요!");
			$('$frrrdDate').focus();
			return false;
		}
		if(!$.trim($('#matrlChargr').val())){
			toastr.warning("부적합 담당자를 선택해주세요!");
			$('#btnfaultyChargr').focus();
			return false;
		}	
		

		if (approvalCd == '001') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!");
			return false;
		} else if (approvalCd == '002') {
			toastr.warning("일시적인 오류가 발생했습니다.<br>취소 후 다시 시도해 주세요!");
			return false;
		}


		//불량유형 선택
		for (let i=0; i<matrlFaultyType.length; i++) {
			if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
				frrrdType += '1';
			} else {
				frrrdType += '0';
			}
		}

		
		if($('input[name=approvalYn]:checked').val() == '001'){
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			matrlChargr = $('#matrlChargr').val();
			updateMtrlInOutWhsInspectQty("009");
			updateInspectCd("");		
						
		} 
		//반품
		else if($('input[name=approvalYn]:checked').val() == '002'){
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			matrlChargr = $('#matrlChargr').val();
			approvalCd = '005';
			updateMtrlInOutWhsInspectQty("005");	
						
		} 
		//폐기
		else if($('input[name=approvalYn]:checked').val() == '003'){
			frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
			frrrdDesc = $('#frrrdDesc').val();
			matrlChargr = $('#matrlChargr').val();
			approvalCd = '007';
			updateMtrlInOutWhsInspectQty("008");				
		}				
	});
	
	function updateMtrlInOutWhsInspectQty(approvalCd){
		$('#my-spinner').show();
		var dataArray = new Array();
		var checkbox = $("input[name=chk]:checked");
		var checkboxCnt = 0;
		var errorFlag = false;
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {
			var tr 			= checkbox.parent().parent().eq(i);			
			var td 			= tr.children();
			var rowData 	= new Object();
			var barcodeNo	= td.eq(7).text();
			
			rowData.menuAuth 	= menuAuth;
			rowData.barcodeNo 	= barcodeNo;
			rowData.approvalCd 	= approvalCd;
			rowData.matrlChargr = matrlChargr;
			rowData.frrrdDate 	= frrrdDate;	//불량&보류&반품 처리일
// 			rowData.frrrdType 	= faultyMatrlList.row(tr).data().frrrdType;	//불량&보류&반품 유형
			if( frrrdType.replaceAll('0', '') != '') {
				rowData.frrrdType = frrrdType;
			} else {
				rowData.frrrdType = "";
			}
			rowData.frrrdDesc 	= frrrdDesc;	//불량&보류&반품 비고
			
			dataArray.push(rowData);
			checkboxCnt += 1;
		});
		
		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010"){	
			url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_qmsc0170"/>';
		} else{ //단순 인쇄시 006
			//url = '<c:url value="/qm/matrlPrint"/>';
			//temp = approvalCd;
		}
		if(!errorFlag && checkboxCnt > 0) {
	        $.ajax({
	            url: url,
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
	                	toastr.success("처리되었습니다.");
	            		$('#faultyMatrlList').DataTable().ajax.reload( function () {});
	            		$("#checkAll").prop("checked", false);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		} else if (approvalCd == "010"){
			toastr.warning("인쇄할 바코드를 선택해주세요!");
			$('#my-spinner').hide();
		} else {
			toastr.warning("미승인 처리할 자재를 선택해 주세요!");
			$('#my-spinner').hide();
		}
    }

	$('#faultyMatrlList tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
        	$('#faultyMatrlList').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });	

	//합격 여부 업데이트
	function updateInspectCd(inspectCd) {
    	var dataArray = new Array();

   		$.each($('#faultyMatrlList tbody tr'),function(idx, itm){
	 		var rowData = new Object();
			if($(this).find('td').eq(0).find('input[name=chk]').is(":checked")){
				
				rowData.inspectCd 		= inspectCd;
	   			rowData.inWhsGroupSeq	= faultyMatrlList.row(this).data().inWhsGroupSeq;
	   			rowData.lotNo 			= faultyMatrlList.row(this).data().lotNo;
	   			dataArray.push(rowData);
			}
		});

        $.ajax({
            url: '<c:url value="/qm/inspectPassUpdate_F3"/>',
            type: 'POST',
            dataType: 'json',
            data : JSON.stringify(dataArray),
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                    // 보기
                    $('#faultyMatrlList').DataTable().ajax.reload();
//                     if(approvalCd ==''){
//                 		toastr.success("처리 되었습니다.");
//                     } 
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function() {}
        }); 
	}


   	//담당자조회 팝업 시작
   	var userPopUpTable;
   	function selectPreWorkCharger()
   	{
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
                $('#matrlChargr').val(data.userNumber);
                $('#matrlChargrNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');                
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		    
		$('#userPopUpModal').modal('show');	
   	}

</script>

</body>
</html>
