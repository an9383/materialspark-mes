<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">제품입출고관리</a></li>
				<li class="breadcrumb-item active">포장대기리스트</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="productOutputDtlTable" class="table table-bordered">
						<thead class="thead-light">
							<!--==========table thead 추가==========-->
							<tr>
								<th style="min-width:100px;" class="text-center">입고일</th>
								<th style="min-width:100px;" class="text-center">검사일</th>
								<th style="min-width:100px;" class="text-center">샘플구분</th>
								<!-- <th style="min-width:100px;" class="text-center">마감일</th> -->
								<!-- <th style="min-width:100px;" class="text-center">납기일</th> -->
								<th style="min-width:50px;" class="text-center">오더구분</th>
								<!-- <th style="min-width:60px;" class="text-center">고객사</th> -->
								<th style="min-width:130px;" class="text-center">모델 NO</th>
								<!-- <th style="min-width:80px;" class="text-center">PO Number</th> -->
								<th style="min-width:80px;" class="text-center">제품명</th>
								<th style="min-width:80px;" class="text-center">제품</th>
								<th style="min-width:50px;" class="text-center">재질</th>
								<!-- <th style="min-width:100px;"class="text-center">파레트번호</th> -->
								<th style="min-width:100px;"class="text-center">박스번호</th>
								<th style="min-width:150px;" class="text-center">생산LotNo</th>
								<!-- <th style="min-width:85px;" class="text-center">고객사LOTNO</th> -->
								<th style="min-width:25px;" class="text-center">주재료LOT</th>
								<th style="min-width:25px;" class="text-center">필름LOT</th>
								<th style="min-width:60px;" class="text-center">수량</th>					
								<!-- <th style="min-width:100px;" class="text-center">작업일</th> -->
								<th style="min-width:100px;" class="text-center">직전박스번호</th>
								<th style="min-width:50px;" class="text-center">비고</th>
								<!-- <th style="min-width:50px;" class="text-center">완공상태</th> -->
								<th style="min-width:50px;" class="text-center">제품상태</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="12" class="text-center">합계</td>
								<td colspan="" id="sumOutputQty" style="text-align: right">0</td>
								<td colspan="3" class="text-center"></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 다중조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="multipleRetv_Modal" tabindex="-1" role="dialog" aria-labelledby="multipleRetv_ModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">제품 다중 추적</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body" style="overflow:auto;">
				<div class="card mb-4">
					<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
						<label for="btnExcelUpload" class="btn btn-success float-right ml-1">엑셀업로드</label>
						<input type="file" class="btn btn-success" id="btnExcelUpload" name="excelfile" style="display: none" />
						<!-- <a href="io/reservation_BasicForm" id="basicFrom">
							<button type="button" class="btn btn-secondary float-right" style="border: solid 1px blue;">기본양식다운로드</button>
						</a> -->
						<button type="button" class="btn btn-primary float-right mr-1" id="btnClear">초기화</button>
					</form>
				</div>
				<div class="table-responsive" style="height: 78vh; border-bottom: 1px solid #e3e3e3;">
					<div id="multiRetvTableView">
						<table id="multiRetvTable" class="table table-bordered" style="text-align: center">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>
										BoxNo
									</th>
									<th>
										주재료LOT
									</th>
									<th>
										필름LOT
									</th>
									<th>
										고객사LOT
									</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<label style="margin-right:3vh;">*<span style="background-color:#7FFFD4;">현재양식</span>을 다운로드 한 후 양식에 맞춰 업로드 해주십시오.</label>
					<label style="margin-right:3vh;color: blue;">*조건의 개수에 비례한 시간이 소요됩니다.</label>
					<label style="margin-right:3vh;color: red;">*중복된 값은 제거 후 조회 됩니다.</label>
					<button type="button" class="btn btn-primary float-right mr-1" id="btnInAddSave" style="min-width: 70px;">추적</button>
					<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 다중조회 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'iosc0210';
	let currentHref = 'iosc0210';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","포장대기리스트");
    let viewIdx;
    let sideView = 'add';
	let factoryCode		= "<%=factoryCode%>";
	var outputHistDateFrom = "${serverDateFrom}";   
	var outputHistDateTo = "${serverDate}";
	var approvalCd = "";
	var poGubunCd =  ""; 
	var boxNoVal= "";
	var matrlLotNoVal= "";
	var filmLotNoVal= "";
	var customerLotNoVal= "";
	var isMultiVal = "";

	//공통코드 시작
    var ordGubun=new Array();
    <c:forEach items="${ordGubun}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubun.push(json);
    </c:forEach>

    var approvalCdCode=new Array();
    <c:forEach items="${approvalCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		approvalCdCode.push(json);
    </c:forEach>

	var dateGubun = "001";
  	//공통코드 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let productOutputDtlTable = $('#productOutputDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        scrollX : true,
        scrollCollapse: true,
        lengthChange : true,
        pageLength: 20,
       ajax: {
            url: '<c:url value="/io/productOutpoutDataDtlList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 			: menuAuth,
	           	'outputHistDateFrom'	: function() { return outputHistDateFrom.replace(/-/g, ''); },
	           	'outputHistDateTo'		: function() { return outputHistDateTo.replace(/-/g, ''); },
	        	'dateGubun'				: function() { return dateGubun; },
	        	'boxNo'					: function() { return boxNoVal == 'empty' ? 'empty/' : boxNoVal; },
	        	'matrlLotNo'			: function() { return matrlLotNoVal == 'empty' ? 'empty/' : matrlLotNoVal; },
	        	'filmLotNo'				: function() { return filmLotNoVal == 'empty' ? 'empty/' : filmLotNoVal; },
	        	'customerLotNo'			: function() { return customerLotNoVal == 'empty' ? 'empty/' : customerLotNoVal; },
	        	'poGroup'				: function() { return factoryCode == '003' ? $("#searchPoGroup").val() : null; },
				'isMulti'				: function() { return isMultiVal; },
				'productGubun'			: function() { return $("#productGubun").val() == null ? "001" : $("#productGubun").val(); },
	        	'goodsStatus'			: function() { return $("#productGubun").val() == "003" ? "'006'" : "'007'"; },
	        },
        },
        rowId: 'poNo',
        columns: [
			{ data: 'inWhsDate',
				render: function(data, type, row) {
		    		if (data != null && data != '') {
						return moment(data).format('YYYY-MM-DD') ;
		    		} else {
			    		return ;
			    	}
				}
            },
            { data: 'inspDate',
				render: function(data, type, row) {
		    		if (data != null && data != '') {
						return moment(data).format('YYYY-MM-DD') ;
		    		} else {
			    		return ;
			    	}
				}
            },
            { data: 'goodsSampleYnNm'},
			/*{ data: 'deliveryDate',
				render: function(data, type, row) {
		    		if (data != null && data != '') {
						return moment(data).format('YYYY-MM-DD') ;
		    		} else {
			    		return ;
			    	}
				}
            },
        	{ data: 'deadLine',
				render: function(data, type, row) {
		    		if (data != null && data != '') {
						return moment(data).format('YYYY-MM-DD') ;
		    		} else {
			    		return ;
			    	}
				}
            },*/
            { data: 'ordGubunNm'},
            /* { data: 'dealCorpNm' }, */
            { data: 'modelNo'},
            /* { data: 'poNo' }, */
            { data: 'goodsNm' },
            { data: 'goodsCd' },
            /* { data: 'alnicuMatrlCd' }, */	//자재
            { data: 'qutyNm' },
            /* { data: 'poGroup' }, */
            { data: 'boxNo',
                render: function(data, type, row) {
	            	if (data != null) {
	            		return "<div style='white-space: nowrap;'>"+data+"</div>";
	            	} else {
	                	return ;
	                }
    			} 
    		},
    		{ data: 'workOrdLotNo' },
            /* { data: 'customerLotNo',
            	render: function(data, type, row) {
                	if (data != null) {
	                	if (factoryCode == '003') {
		                	var customerLotNoArr = data.split("/");
		                	return "<div style='white-space: nowrap;'>" + customerLotNoArr[0] + "<br>" + ((customerLotNoArr[1] == "" || customerLotNoArr[1] == undefined) ? "-" : customerLotNoArr[1]) + "</div>";
	                	} else {
	                    	return data;
	                    }
                	} else {
                    	return ;
                    }
	    		}
    		}, */
            { data: 'matrlLotNo' },
            { data: 'filmLotNo' },
            { data: 'remainCnt' },
            /* { data: 'poDate',
	    		render: function(data, type, row) {
		    		if (data != null && data != '') {
						return moment(data).format('YYYY-MM-DD') ;
		    		} else {
			    		return ;
			    	}
	    		}
            }, */
            { data: 'selBoxNo1',
	    		render: function(data, type, row) {
					if((data == null || data == '') && (row['selBoxNo2'] == null || row['selBoxNo2'] == '')) {
						return "<div style='white-space: nowrap;'></div>";
					} else if ((data != null && data != '') && (row['selBoxNo2'] == null || row['selBoxNo2'] == '')) {
						return "<div style='white-space: nowrap;'>"+data+"</div>";
					} else if ((data == null || data == '') && (row['selBoxNo2'] != null && row['selBoxNo2'] != '')) {
						return "<div style='white-space: nowrap;'>"+row['selBoxNo2']+"</div>";
					} else {
						return "<div style='white-space: nowrap;'>"+data + "," + row['selBoxNo2']+"</div>";
					}
	    		}
            },
            { data: 'poDesc' },
            /* { data: 'completeYn',
	    		render: function(data, type, row) {
	            	if(data == 'Y') {
						return "완공";
					} else if (data == 'N') {
						return "미료";
					}
	    		}
			}, */
            { data: 'goodsStatusNm' },
   
        ],
        columnDefs: [
        	{ targets: [12] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [12], className: 'text-right' }, 
        	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }
        	
        ],        
        order: [
            [ 0, 'desc' ],
            //[ 9, 'asc' ],
        ],
        buttons: [
            {
                extend: 'copy',
                title: '포장대기리스트',
            },
            {
                extend: 'excel',
                title: '포장대기리스트',
            },
            {
                extend: 'print',
                title: '포장대기리스트',
            },
        ],
        rowCallback: function (row, data) {
			if (data.disposeGubun == "003") {
				$(row).addClass('whiteRed');
			}
		},
		drawCallback: function () {
		    $('#productOutputDtlTable').find('tfoot').empty();
			//전역변수들
			var sumOutputQty = $('#productOutputDtlTable').DataTable().column(12,{ page: 'all'} ).data().sum();
			$('#sumOutputQty').text(addCommas(sumOutputQty.toFixed(0)));
        }
    });

	var html1 = '<div class="row">';
// 	if (factoryCode == '003') {
		html1 += '<input id="trackingMode" type="checkBox" style="width: 20px; height: 20px; margin-top:2px; margin-right:3px;"><label for="excludeStatusO" class="input-label-sm" checked>추적용</label> ';
// 	}
	html1 += '<div class="row" id="inputDate">';
	html1 += '<select class="custom-select" style="appearance: none !important;" id="dateGubun" disabled> <option value="301">입고일</option> <option value="302">검사일</option> </select> &nbsp;';
	html1 += '<select class="custom-select" id="productGubun"> <option value="001">양산</option> <option value="002">샘플</option><option value="003">검사완료</option>  </select> &nbsp;<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate1" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate1,chooseDate1,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar1" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate2"/>';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate2,chooseDate2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateCalendar2" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp;&nbsp; <button type="button" class="btn btn-primary d-none" id="btnTerm">기간선택</button>&nbsp;&nbsp;&nbsp;';
	html1 += '</div>';
	html1 += '<input type="text" style="width:11%" class="form-control" placeholder="박스번호를 입력해주세요." id="searchBoxNo">';
	html1 += '&nbsp;&nbsp;&nbsp;<input type="text" style="width:12%" class="form-control" placeholder="주재료LOT를 입력해주세요." id="searchMatrlLotNo">';
	html1 += '&nbsp;&nbsp;&nbsp;<input type="text" style="width:11%" class="form-control" placeholder="필름LOT를 입력해주세요." id="searchFilmLotNo">';
	html1 += '&nbsp;&nbsp;&nbsp;<input type="text" style="width:13%" class="form-control" placeholder="고객사LOTNO를 입력해주세요." id="searchCustomerLotNo">';
	if (factoryCode == '003') {
		html1 += '&nbsp;&nbsp;&nbsp;<input type="text" style="width:11%" class="form-control d-none" placeholder="파레트번호를 입력해주세요." id="searchPoGroup">';
	}
	html1 += '&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="btnRetv">조회</button>';
	if (factoryCode != '003') {
		html1 += '<button type="button" class="btn btn-success float-right ml-2" id="btnMultiRetv" disabled>다중 추적</button>';
	}
	html1 += '</div>';

	$('#productOutputDtlTable_length').html(html1);
	$('#chooseDate1').val(outputHistDateFrom);
	$('#chooseDate2').val(outputHistDateTo);
	selectBoxAppend(approvalCdCode, "approvalCd", "", "1");
	selectBoxAppend(ordGubun, "poGubunCd", "", "1");
	
	//제품 구분자 변경 시
	$('#productGubun').on('change', function(){
		if( $(this).val() == "003" ) {
			$('#dateGubun').val("302");
		} else {
			$('#dateGubun').val("301");
		}
	});

    // 보기
    $('#productOutputDtlTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        } else {
        	$('#productOutputDtlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {

    	boxNoVal = $("#searchBoxNo").val();  
    	matrlLotNoVal = $("#searchMatrlLotNo").val();
    	filmLotNoVal = $("#searchFilmLotNo").val();
    	customerLotNoVal = $("#searchCustomerLotNo").val();
        
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
		if (dateDiff > 365) {
			toastr.warning("검색 가능 기간은 최대 1년입니다!");
			$('#chooseDateCalendar1').focus();
			return false;
		}
		
    	outputHistDateFrom =  $('#chooseDate1').val();
    	outputHistDateTo=  $('#chooseDate2').val();
    	approvalCd =  $('#approvalCd').val();
		poGubunCd =  $('#poGubunCd').val();
		dateGubun = $('#dateGubun option:selected').val();

		if($("#trackingMode").prop("checked")) { // 추적용
			if(factoryCode == '003' && $("#searchBoxNo").val().trim() == '' && $("#searchMatrlLotNo").val().trim() == '' && $("#searchFilmLotNo").val().trim() == '' && $("#searchCustomerLotNo").val().trim() == '' && $("#searchPoGroup").val().trim() == '') {
				toastr.warning("한 가지 이상의 조회조건을 입력해주세요!");
				return false;
			} else if ((factoryCode == '002' || factoryCode == '001') && $("#searchBoxNo").val().trim() == '' && $("#searchMatrlLotNo").val().trim() == '' && $("#searchFilmLotNo").val().trim() == '' && $("#searchCustomerLotNo").val().trim() == '') {
				toastr.warning("한 가지 이상의 조회조건을 입력해주세요!");
				return false;
			}
	    	outputHistDateFrom =  '2000-01-01';
	    	outputHistDateTo=  '2099-12-31';
		}
		
		$('#productOutputDtlTable').DataTable().ajax.reload( function () {});
		
		/*if($('#dateGubun option:selected').val() == "001") {
			var table = $('#productOutputDtlTable').DataTable();
			table.order( [ 0, 'desc' ], [ 7, 'asc' ] ).draw();
			dateGubun = "001";
		} else if($('#dateGubun option:selected').val() == "002") {
			var table = $('#productOutputDtlTable').DataTable();
			dateGubun = "002";
			table.order( [ 1, 'desc' ], [ 7, 'asc' ] ) .draw();
		} else {
			var table = $('#productOutputDtlTable').DataTable();
			dateGubun = "003";
			table.order( [ 15, 'desc' ], [ 7, 'asc' ] ) .draw();
		}*/
    });

    $("#trackingMode").on('change', function(){
    	if($("#trackingMode").prop("checked")) { 
			$('#btnMultiRetv').attr('disabled', false);
    	} else $('#btnMultiRetv').attr('disabled', true);
    });

	$('#dateGubun').change(function() {
		dateGubun = $('#dateGubun option:selected').val();
		$('#productOutputDtlTable').DataTable().ajax.reload( function () {});
		if ($('#dateGubun option:selected').val() == "001") {
			var table = $('#productOutputDtlTable').DataTable();
			table.order( [ 0, 'desc' ], [ 7, 'asc' ] ).draw();
			dateGubun = "001";
		} else if ($('#dateGubun option:selected').val() == "002") {
			var table = $('#productOutputDtlTable').DataTable();
			table.order( [ 1, 'desc' ], [ 7, 'asc' ] ).draw();
			dateGubun = "002";
		} else {
			var table = $('#productOutputDtlTable').DataTable();
			dateGubun = "003";
			table .order( [ 15, 'desc' ], [ 7, 'asc' ] ) .draw();
		}
    });

	$('#approvalCd').change(function() {
		approvalCd =  $('#approvalCd').val();
		$('#productOutputDtlTable').DataTable().ajax.reload( function () {});
    });
	
	$('#poGubunCd').change(function() {
		poGubunCd =  $('#poGubunCd').val();
		$('#productOutputDtlTable').DataTable().ajax.reload( function () {});
    });

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
		datePick(id, 'chooseDate1', 'chooseDate2',  $('#select-year').val());
	});

    //출고용
    $("#trackingMode").on('click', function() {
        if($(this).prop("checked")) { // 체크 시
            $("#inputDate").addClass("d-none");
        } else {	// 체크해제 시
            $("#inputDate").removeClass("d-none");
        }
    })
    
    //다중조회 테이블
    let multiRetvTable = $('#multiRetvTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'B><'col-sm-12 col-md-7'>>",
	    language: lang_kor,
	    searching: false,
	    destroy: true,
	    paging: false,
	    info: true,		    
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    pageLength: false,		    		
	    columns: [
	    	{ data: 'boxNo' },
	    	{ data: 'matrlLotNo' },
	    	{ data: 'filmLotNo' },
	    	{ data: 'customerLotNo' },
	    ],
	    buttons: [
			{
                extend: 'excel',
                title: '제품 다중 추적',
                className : 'btn-secondary',
            	init : function ( api, node, config ) {
					$(node).addClass('btn-primary');
					$(node).text('현재양식');
					$(node).attr('style', 'background-color:#7FFFD4 !important;');
				},
                customize : function (xlsx) {
			 		let sheet = xlsx.xl.worksheets['sheet1.xml'];
			 		let col = $('col', sheet);
			 		
			 		col.each(function () {
			 	          $(this).attr('width', 25);
			 	    });
                },
			},
		],
	});
    
    //다중 조회 버튼 클릭 시
    $('#btnMultiRetv').on('click', function(){
    	$('#multiRetvTable').DataTable().clear().draw();
   		$('#btnExcelUpload').val("");
		$('#multipleRetv_Modal').modal('show');
    });

  //파일 선택
	$('#btnExcelUpload').change(function(){
		let formData	= new FormData($('#fileUploadForm')[0]);
		let str 		= $('#btnExcelUpload').val();
		
		if (str.substring(str.lastIndexOf(".")+1)=="xls" || str.substring(str.lastIndexOf(".")+1) == "xlsx") {
			
			//엑셀파일 업로드하는 ajax
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	data: formData,
		    	url:'<c:url value="io/multiRetv_ExcelUpload"/>',
		    	processData: false,
		    	contentType: false,
		    	cache: false,
		    	success: function (res) {
					if (res.result == 'ok') {
						let url = res.data;

		    			//테이블 생성(excel읽기)_ajax
						$.ajax({
		    		        url: '<c:url value="/io/multiRetv_DataList"/>',
		    		        type: 'GET',
		    		        data: {
		    		        	'menuAuth'	 	: 		menuAuth,
		    		        	'filename'		:		url,
		    		        },
		    		        success: function (res) {
								if(res.result == 'ok') {
									multiRetvTable = $('#multiRetvTable').DataTable({
											dom: "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>" +
											"<'row'<'col-sm-12'tr>>" +
											"<'row'<'col-sm-12 col-md-5'B><'col-sm-12 col-md-7'>>",
							    		    language: lang_kor,
							    		    searching: false,
							    		    destroy: true,
							    		    paging: false,
							    		    info: true,		    
							    		    ordering: true,
							    		    processing: true,
							    		    autoWidth: false,
							    		    pageLength: false,
							    		    data: res.data,
							    		    columns: [
							    		    	{ 
								    		    	data: 'boxNo',
								    		    	render: function(data, type, row) {
								    	            	if (data != null) {
								    	            		return data;
								    	            	} else {
								    	                	return '';
								    	                }
								        			}
								    		   	},
							    		    	{ 
								    		    	data: 'matrlLotNo',
								    		    	render: function(data, type, row) {
								    	            	if (data != null) {
								    	            		return data;
								    	            	} else {
								    	                	return '';
								    	                }
								        			} 
							        			},
							    		    	{ 
								    		    	data: 'filmLotNo',
								    		    	render: function(data, type, row) {
								    	            	if (data != null) {
								    	            		return data;
								    	            	} else {
								    	                	return '';
								    	                }
								        			}
							        			},
							    		    	{ 
									    		    data: 'customerLotNo',
								    		    	render: function(data, type, row) {
								    	            	if (data != null) {
								    	            		return data;
								    	            	} else {
								    	                	return '';
								    	                }
								        			}
							        			},
							    		    ],
							    		    order : [],
							    		    columnDefs: [
							    		    	{ "defaultContent": "-", "targets": "_all",	"className": "text-center" }		    	
							    		    ],
							    		    buttons: [
							    				{
							    	                extend: 'excel',
							    	                title: '제품 다중 추적',
							    	                className : 'btn-secondary',
							    	            	init : function ( api, node, config ) {
							    						$(node).addClass('btn-primary');
							    						$(node).text('현재양식');
							    						$(node).attr('style', 'background-color:#7FFFD4 !important;');
							    					},
							    	                customize : function (xlsx) {
							    				 		let sheet = xlsx.xl.worksheets['sheet1.xml'];
							    				 		let col = $('col', sheet);
							    				 		
							    				 		col.each(function () {
							    				 	          $(this).attr('width', 25);
							    				 	    });
							    	                },
							    				},
							    			],
								        });
								        
						    	} else if (res.result == 'fail') {
						    		toastr.warning(res.message, '', {timeOut: 5000});
						    	} else if (res.result == 'error') {
						    		toastr.error(res.message, '', {timeOut: 5000});
						    	}
							}
						});
						//테이블 생성(excel읽기)_ajax
	    			}
		    	}
	    	});
			//엑셀파일 업로드하는 ajax
		} else {
			toastr.warning("Excel파일을 선택해 주세요.");
			return false;
		}
	});

	//초기화
    $('#btnClear').on('click', function(){ 
    	if(multiRetvTable.data().count() != 0){
   			$('#multiRetvTable').DataTable().clear().draw();
       		$('#btnExcelUpload').val("");
       		toastr.success("초기화 되었습니다.");
    	}
    });

    //추적 버튼 클릭 시
    $('#btnInAddSave').on('click', function(){
//    	let dataArray	= new Array();
//    	let colData = new Object();
		let check 		= true;
		let boxArr = 'empty';
		let matrlLotNoArr = 'empty';
		let filmLotNoArr = 'empty';
		let customerLotNoArr = 'empty';
		isMultiVal = 'multi';

		for(var i=0; i < $('#multiRetvTable').DataTable().data().length; i++){

			if(i == 0){
				boxArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text();
				matrlLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text();
				filmLotNoArr +=  $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text();
				customerLotNoArr +=  $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text();
			}else if(i < $('#multiRetvTable').DataTable().data().length-1){
				boxArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text();
				matrlLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text();
				filmLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text();
				customerLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text();
			} else {
				boxArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(0).text();
				matrlLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(1).text();
				filmLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(2).text();
				customerLotNoArr += $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text() == '' ? '' : "/" + $('#multiRetvTable tbody tr').eq(i).find('td').eq(3).text();
			}
			
	        /* if(tIdx == 0){
	        	colData.boxNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(0).text() + "'";
		        rowData.matrlLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(1).text() + "'";
		        rowData.filmLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(2).text() + "'";
		        rowData.customerLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(3).text() + "'";

		        rowData.outputHistDateFrom = outputHistDateFrom.replace(/-/g, '');
				rowData.outputHistDateTo = outputHistDateTo.replace(/-/g, '');
				rowData.dateGubun = dateGubun;
		        
		        rowData.menuAuth = menuAuth;
		        dataArray.push(rowData);
		    } else {
		    	rowData.boxNo = ",'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(0).text() + "'";
		        rowData.matrlLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(1).text() + "'";
		        rowData.filmLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(2).text() + "'";
		        rowData.customerLotNo = "'" + $('#multiRetvTable tbody tr').eq(tIdx).find('td').eq(3).text() + "'";

		        rowData.outputHistDateFrom = outputHistDateFrom.replace(/-/g, '');
				rowData.outputHistDateTo = outputHistDateTo.replace(/-/g, '');
				rowData.dateGubun = dateGubun;
		        
		        rowData.menuAuth = menuAuth;
		        dataArray.push(rowData);
			} */
	        
    	};
    	boxNoVal = boxArr;
    	matrlLotNoVal = matrlLotNoArr;
    	filmLotNoVal = filmLotNoArr;
    	customerLotNoVal = customerLotNoArr;

    	if($("#trackingMode").prop("checked")) { // 추적용
	    	outputHistDateFrom =  '2000-01-01';
	    	outputHistDateTo=  '2099-12-31';
		}

    	$('#productOutputDtlTable').DataTable().ajax.reload(function(){});

    	if($('#dateGubun option:selected').val() == "001") {
			var table = $('#productOutputDtlTable').DataTable();
			table.order( [ 0, 'desc' ], [ 7, 'asc' ] ).draw();
			dateGubun = "001";
		} else if($('#dateGubun option:selected').val() == "002") {
			var table = $('#productOutputDtlTable').DataTable();
			dateGubun = "002";
			table.order( [ 1, 'desc' ], [ 7, 'asc' ] ) .draw();
		} else {
			var table = $('#productOutputDtlTable').DataTable();
			dateGubun = "003";
			table.order( [ 15, 'desc' ], [ 7, 'asc' ] ) .draw();
		}

    	isMultiVal = "";

    	$('#multipleRetv_Modal').modal('hide');
    });
</script>

</body>
</html>

