<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/topPda.jsp" %>
<style>
 body{
  overflow:hidden;
 }
</style>

<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex;flex-direction: column;height: 100%;">
    <header class="pda_mo_hd">
         <a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a>
         <a href="/pdsc0060"><p class="mo_main_title">재고실사(제품)</p></a>
    </header>
<!--====-sortbox-->
	<div class="mo_sortbox">
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">입고일</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input class="form-control-md" type="text" id="chooseDate" disabled />
						<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button" id="btnCalendar">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Location NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<select class="custom-select custom-select-md" id="location"></select>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Box NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="boxNo" inputmode="none">
					</div>
				</div>
	</div>
			<!--==버튼영역-->
			<!-- 
			<div class="mo_btnbox pl-2 pr-2">
				<div class="float-left">
					<button type="button" class="btn btn-danger float-right" id="btnLineClear" disabled>라인삭제</button>
					<button type="button" class="btn btn-danger float-right mr-2" id="btnAllClear" disabled>전체삭제</button>
				</div>

				<div class="float-right">
					<button type="button" class="btn btn-secondary float-right" id="btnCancel">취소</button>
					<button type="button" class="btn btn-secondary float-right d-none" id="btnNew">새로 등록</button>
					<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>저장</button>
				</div>
			</div>
			<br>
			 -->
			<!--==end==버튼영역-->
	<!--==end==-sortbox-->
	<main style="height: calc(100vh - 50px);overflow:auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%;display: flex;flex-direction: column;">
			<!--table-->
			<!-- .table-responsive -->
			<div class="card mo_card" style="OVERFLOW-Y:auto; width:100%;">
				<div class="table-responsive">
					<table id="barcodeOutputWhsTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 30px">체크</th>
								<th style="min-width: 50px">제품코드</th>
								<th style="min-width: 50px">제품명</th>
	                            <th style="min-width: 70px">포장 NO</th>
	                            <th style="min-width: 40px">재고 수량</th>
	                            <th style="min-width: 40px">상태</th>
	                            <!-- <th style="min-width: 30px"> locationCd </th> -->
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==end==table-->

		</div>
	</main>
	<footer class="p-2" style="margin-top: auto;">
			<div class="mo_sumbox mb-3">
				<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label>
					</div>
					<div class="mo_kg">
						<span class="mo_sum_font_lg" id="sum">0</span> <label>EA</label>
					</div>
				</div>
			</div>	
	</footer>
</div>
<!-- /.app -->

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>
<script>
	$(document).attr("title","재고실사(제품)");
	let menuAuth = 'pdsc0010';
	var serverDate = "${serverDate}"
	var boxNo = null;
	
	//공통코드 처리 시작
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	locationCode.push(json);
	</c:forEach>
	//공통코드 처리 끝
	
	selectBoxAppend(locationCode, "location", "", "2");
	$('#chooseDate').val(serverDate);
	$('#location').focus();
	$("#location").change(function() {
		$('#boxNo').focus();
	});

	$.fn.dataTable.ext.errMode = 'none';
	let barcodeOutputWhsTable = $('#barcodeOutputWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
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
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	         },
	    },
	    columns: [
	    	{
	    		render: function(data, type, row, meta) {			    			
					return '<input type="checkbox" name="checkBox">' ;
	    		}
			},
        	{	data: 'matrlCd'	},
        	{	data: 'matrlNm'	},
        	{	data: 'lotNo'	},
        	{	data: 'inspectQty'	},
	    ]
	});

	$('#btnCalendar').on('click', function() {
		selectBoxAppend(locationCode, "location", "", "2");
		locationCd = "";
		$('#boxNo').val("");
	});
	
	$('#location').change(function(){
		locationCd = $("#location option:selected").val();
		if ( locationCd == "" ){
			toastr.warning("Location No을 선택해 주세요.");
			return false;
		}
		
		barcodeOutputWhsTable = $('#barcodeOutputWhsTable').DataTable({
		    language: lang_kor,
		    paging: false,
		    info: false,
		    ordering: true,
		    processing: true,
		    autoWidth: false,
		    scrollX : false,
		    lengthChange: false,
		    searching: false,
		    destroy: true,
		    ajax: {
	 			url: '<c:url value="/pd/goodsProductInfoList"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'locationCd'		:		locationCd,
					'chooseDate'		:		function() { return $('#chooseDate').val().replace(/-/g, ''); },
				},
		    },
		    columns: [
		    	{
		    		render: function(data, type, row, meta) {			    			
						return '<input type="checkbox" name="checkBox">' ;
		    		}
				},
	        	{	data: 'goodsCd'	},
	        	{	data: 'goodsNm'	},
	        	{	data: 'boxNo'	},
	        	{	data: 'remainCnt'	},
	        	{	data: 'faultyStatusNm'},
		    ],
		    columnDefs: [
		    	{"className": "text-center", "targets": "_all"},
		    	{ targets: [4] , render: $.fn.dataTable.render.number( ',' )},
		    ],
			drawCallback: function () {
	            var sum = $('#barcodeOutputWhsTable').DataTable().column(4,{ page: 'current'} ).data().sum();
	            $('#sum').text(sum.toLocaleString());
	            var rowCount = $('#barcodeOutputWhsTable tr').length;
	            if (sum=='0'){
	            	$('#rowCount').text('0');
				} else{
					$('#rowCount').text(rowCount-1);
				}
	        },
		});	
	 });

	var lineCheck = false;
    $('#barcodeOutputWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            lineCheck = false;
        }	
        else {
        	$('#barcodeOutputWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            lineCheck = true;
        }
    });

	//바코드 스캔시
	$("#boxNo").keypress(function (e) {
	    if (e.which == 13){

	    	if($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
	        	$("#boxNo").val("");        	
	        	$("#chooseDate").focus();
	        	toastr.warning("입고일을 선택해주세요!");
	        	return false
	        }
	    	if($("#location").val() == null || $("#location").val() == "") {
	        	$("#boxNo").val("");
	        	toastr.warning("입고위치를 선택해주세요!");
	        	$('#location').focus();
	        	return false
	        }
	    	//키보드입력 말고 바코드로 스캔시 풀어주기
	    	if ( !$.trim($('#boxNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#boxNo').select();
	            return false;
	        }
	    	if ( $('#boxNo').val().trim().length != "13" ) {
	            toastr.warning('BoxNo 바코드가 아닙니다. 확인해주세요');
	            $('#boxNo').select();
	            return false;
	    	}
	    	
			$.ajax({
	 			url: '<c:url value="/pd/productBoxNoScan"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'boxNo'   		:        $('#boxNo').val().trim(),
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
					let data = res.data;
					if(data == null){
						$('#boxNo').select();
						toastr.warning('검색된 값이 없습니다.');
						return false;
					}
					boxNo = data.boxNo;
			        var cval = compareBarcodeNo(boxNo);
			        if(cval == false) {
			        	//해당 열 체크하기
			        } else {
			        	toastr.error('해당 제품은 ' + data.locationNm + '에 있습니다.', '', {timeOut: 5000});
			        	toastr.error('자재 상태값에 따른 검색조건 추가 필요', '', {timeOut: 5000});
			        	return false;
					}
			        $('#boxNo').select();
				},
				complete:function(){
					//$('#btnAddConfirm').removeClass('d-none');
					//$('#btnAddConfirmLoading').addClass('d-none');
				}
			});
	    }
	});

	// 저장 처리
    //$('#btnSave').on('click', function() {
    //    if ( !$.trim($('#chooseDate').val()) ) {
    //        toastr.error('입고일을 선택해주세요.');
    //        $('#chooseDate').focus();
    //        return false;
    //    }
    //	if($("#location").val() == null || $("#location").val() == "") {
    //    	$("#boxNo").val("");
    //    	toastr.warning("입고위치를 선택해주세요!");
    //    	$('#location').focus();
    //    	return false
    //    }
    //
    //    createBarcodeNo();
    //    
    //    $.ajax({
    //        url: '<c:url value="/pd/locationUpdate"/>',
    //        type: 'POST',
    //        data: JSON.stringify(boxNoList),
    //        dataType:"json",
    //        contentType : "application/json; charset=UTF-8",
    //        beforeSend: function() {
    //          //  $('#btnAddConfirm').addClass('d-none');
    //          //  $('#btnAddConfirmLoading').removeClass('d-none');
    //        },
    //        success: function (res) {
    //            let data = res.data;
    //    
    //            if (res.result == 'ok') {
    //            	$('#btnAllClear').attr('disabled', true);
    //            	$('#btnLineClear').attr('disabled', true);
    //            	$('#btnSave').attr('disabled', true);
    //                $('#btnSave').attr('disabled', true);
    //                $('#boxNo').attr('disabled', true);
    //                toastr.success('자재입고 위치 저장되었습니다.');
	//				$('#btnCancel').addClass('d-none');
	//				$('#btnNew').removeClass('d-none');
    //            } else {
    //                toastr.error(res.message);
    //            }
    //        },
    //        complete:function(){
    //            //$('#btnAddConfirm').removeClass('d-none');
    //            //$('#btnAddConfirmLoading').addClass('d-none');
    //        }
    //    });
    //});

	var boxNoList;
	function createBarcodeNo() {
		boxNoList = new Array();
		var idx = 0;

		$('#barcodeOutputWhsTable tbody tr').each(function(index){
			//console.log($(this).data('location-cd'));
			var locationCd =($(this).data('location-cd'));
			var boxNo= $(this).find('td').eq(1).html();
		 	var inWhsDate = $("#chooseDate").val().replace(/-/g, '');
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.boxNo = boxNo;
			rowData.locationCd = locationCd;
			rowData.inWhsDate = inWhsDate;
			boxNoList.push(rowData);
		});
		console.log(boxNoList);
		return idx;
	}
	
	//전체 삭제
	//$('#btnAllClear').on('click', function() {
	//	$('#barcodeOutputWhsTable').DataTable().clear().draw();
	//	$('#btnAllClear').attr('disabled', true);
	//	$('#btnLineClear').attr('disabled', true);
	//	$('#btnSave').attr('disabled', true);
	//	$('#boxNo').val('');
	//	$('#boxNo').focus();
	//});

	//라인 삭제
	//$('#btnLineClear').on('click', function() {
	//	if ( lineCheck == true) {
	//    	$('#barcodeOutputWhsTable').DataTable().rows('.selected').remove().draw();
	//    	$("#boxNo").val("");
	//    	$("#boxNo").focus();
	//    	var rowCnt = $('#barcodeOutputWhsTable').DataTable().data().count(); 
	//    	if(rowCnt == 0) {
	//    		$('#btnSave').attr('disabled', true);
	//    		$('#btnAllClear').attr('disabled', true);
	//    		$('#btnLineClear').attr('disabled', true);
	//    	} 
	//	} else {
	//    	toastr.warning('삭제할 라인을 선택하세요.');
	//	}
	//});
	
	//취소 버튼
	//$('#btnCancel').on('click', function() {
	//	$('#btnCalendar').attr('disabled', false);
	//	$('#location').attr('disabled', false);
	//	$('#btnSave').attr('disabled', true);
	//	$('#btnAllClear').attr('disabled', true);
	//	$('#btnLineClear').attr('disabled', true);
	//	$('#barcodeOutputWhsTable').DataTable().clear().draw();
	//	$('#boxNo').val('');
	//	$('#boxNo').focus();
	//	$('#chooseDate').val(serverDate);
	//	selectBoxAppend(locationCode, "location", "", "2");
	//});

	//저장 완료 후 새로등록
	//$('#btnNew').on('click', function() {
	//	$('#btnCalendar').attr('disabled', false);
	//	$('#location').attr('disabled', false);
	//	$('#boxNo').attr('disabled', false);
	//	$('#barcodeOutputWhsTable').DataTable().clear().draw();
	//	$('#boxNo').val('');
	//	$('#boxNo').focus();
	//	$('#chooseDate').val(serverDate);
	//	selectBoxAppend(locationCode, "location", "", "2");
	//	$('#btnNew').addClass('d-none');
	//	$('#btnCancel').removeClass('d-none');
	//});
	
	//중복 예외처리 사용예정
	function compareBarcodeNo(boxNo) {
	    var result = true;
	    $('#barcodeOutputWhsTable tbody tr').each(function(){
			var tboxNo= $(this).find('td').eq(3).html();
			if( boxNo == tboxNo) {
				result = false;
				var checkbox = $(this).find('td:first-child :checkbox');
				//체크 안되어 있으면 체크하기
				if( $(this).find('td:first-child :checkbox').is(":checked") == false ){
					checkbox.attr('checked', !checkbox.is(':checked'));
				}
				return result;
			}
		});
		
	    return result;
	}

	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#boxNo').attr('inputmode');
		if ( inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#boxNo').attr('inputmode', 'text');
		} else if ( inputmode == 'text' ) {
			$('#btnKeyboard').text("자판 Off");
			$('#boxNo').attr('inputmode', 'none');
		}
	});

</script>

</body>
</html>
