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
         <a href="/pdsc0010"><p class="mo_main_title">자재상태 확인</p></a>
      </header>
      <!--====-sortbox-->
			<div class="mo_sortbox">
				<!-- 
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
				-->				
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">자재 바코드</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="barcodeNo" inputmode="none">
					</div>
				</div>
			</div>
			<!--버튼영역-->
			<div class="mo_btnbox pl-2 pr-2">
				<!-- 
				<div class="float-left">
					<button type="button" class="btn btn-danger float-right" id="btnLineClear" disabled>라인삭제</button>
					<button type="button" class="btn btn-danger float-right mr-2" id="btnAllClear" disabled>전체삭제</button>
				</div>
				 -->
				<div class="float-right">
					<button type="button" class="btn btn-secondary float-right" id="btnReset">초기화</button>
					<!-- 
					<button type="button" class="btn btn-secondary float-right d-none" id="btnNew">새로 등록</button>
					<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>저장</button>
					 -->
				</div>
			</div>
			<br>
		    <!--end버튼영역-->
	  <!--==end==-sortbox-->
	   <main style="height: calc(100vh - 50px);overflow:auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%;display: flex;flex-direction: column;padding-top: 5px;padding-left: 5px;padding-right: 5px;">
			<div class="card mb-2" style="OVERFLOW-Y:auto; width:100%;">
				<div class="table-responsive">
					<table class="table table-bordered mb-2">
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tbody class="thead-light">
							<tr>
								<th>자재코드</th>
								<td><input type="text" class="form-control" id="matrlCd" disabled></td>
								<th>자재명</th>
								<td><input type="text" class="form-control" id="matrlNm" disabled></td>
							</tr>
							<tr>
								<th>LotNo</th>
								<td><input type="text" class="form-control" id="lotNo" disabled></td>
								<th>자재 바코드</th>
								<td><input type="text" class="form-control" id="readBarcodeNo" disabled></td>
							</tr>
							<tr>
								<th>승인여부</th>
								<td><input type="text" class="form-control" id="approvalNm" disabled></td>
								<th>자재상태</th>
								<td><input type="text" class="form-control" id="statusNm" disabled></td>
							</tr>
							<tr>
								<th>가입고일</th>
								<td><input type="text" class="form-control" id="preInWhsDate" disabled></td>
								<th>입고일</th>
								<td><input type="text" class="form-control" id="inWhsDate" disabled></td>
							</tr>
							<tr>
								<th>입고량</th>
								<td><input type="text" class="form-control" id="inWhsQty" disabled></td>
								<th>수입검사일</th>
								<td><input type="text" class="form-control" id="inspctDate" disabled></td>
							</tr>
							<tr>
								<th>가출고일</th>
								<td><input type="text" class="form-control" id="preOutWhsDate" disabled></td>
								<th>가출고<br>설비</th>
								<td><input type="text" class="form-control" id="preOutEquipNm" disabled></td>
							</tr>
							<tr>
								<th>가출고<br>제품코드</th>
								<td><input type="text" class="form-control" id="preOutGoodsCd" disabled></td>
								<th>가출고<br>제품명</th>
								<td><input type="text" class="form-control" id="preOutGoodsNm" disabled></td>
							</tr>
							<tr>
								<th>출고일</th>
								<td><input type="text" class="form-control" id="outWhsDate" disabled></td>
								<th>투입<br>설비명</th>
								<td><input type="text" class="form-control" id="outEquipNm" disabled></td>
							</tr>
							<tr>
								<th>출고<br>제품코드</th>
								<td><input type="text" class="form-control" id="outGoodsCd" disabled></td>
								<th>출고<br>제품명</th>
								<td><input type="text" class="form-control" id="outGoodsNm" disabled></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	  </main>
	  <footer class="p-2" style="margin-top: auto;">
			<div class="mo_sumbox">
				<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
					</div>
					<!-- 
					<div class="mo_kg">
						<span class="mo_sum_font_lg" id="count">0</span> <label>개수</label>
					</div>
					 -->
				</div>
			</div>	
	  </footer>
</div>
<!-- /.app -->
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title","자재상태 확인");
	let menuAuth = 'pdsc0100';
	var barcodeNo = null;
	$('#barcodeNo').focus();
	
	//공통코드 처리 시작
	/* 
	var locationCode = new Array(); // 설치장소
	<c:forEach items="${locationCode}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseCdNm = "${info.baseCdNm}";
	locationCode.push(json);
	</c:forEach>
	 */
	//공통코드 처리 끝
	
	//selectBoxAppend(locationCode, "location", "", "2");
	//$('#chooseDate').val(serverDate);
	
	$("#location").change(function() {
		$('#barcodeNo').focus();
	});

	//$.fn.dataTable.ext.errMode = 'none';
	//let barcodeOutputWhsTable = $('#barcodeOutputWhsTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	//	if(techNote == 7) {
	//		toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	//		location.href = "/";
	//	}
	//}).DataTable({
	//    language: lang_kor,
	//    paging: false,
	//    info: false,
	//    ordering: true,
	//    processing: true,
	//    autoWidth: false,
	//    scrollX : false,
	//    lengthChange: false,
	//    searching: false,
	//    pageLength: 20,            
	//    ajax: {
	//        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	//        type: 'GET',
	//        data: {
	//        	'menuAuth'	 	: 		menuAuth,
	//         },
	//         success : function(res) {
	//             console.log(res);
	//             rightSide = false;
	//         }
	//    },
	//    //rowId: '',
	//    columns: [
	//    	{
	//    		render: function(data, type, row, meta) {
	//    			var rowNo = meta.row + 1;
	//    			if(rowNo == 1) {
	//    				$('#btnSave').attr('disabled', false);
	//		    	}
	//				return meta.row + 1;
	//			}
	//    	},
	//        { 
	//            data: 'barcodeNo', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  barcodeNo;
	//	    			}
	//	    		}
	//        },
	//        { 
	//            data: 'matrlCd', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  matrlCd;
	//	    			}
	//	    		}
	//        },
	//        { 
	//            data: 'matrlNm', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  matrlNm;
	//	    			}
	//	    		}
	//        },
	//        { 
	//            data: 'inWhsQty', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  inWhsQty;
	//	    			}
	//	    		}
	//        },
	//        { 
	//            data: 'locationNm', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  locationNm;
	//	    			}
	//	    		}
	//        },
	//        { 
	//            data: 'lotNo', 
	//	    		render: function(data, type, row, meta) {
	//	    			if(data != null) {
	//	    				return data;
	//	    			} else {
	//	    				return  lotNo;
	//	    			}
	//	    		}
	//        },
	//    ],
	//    columnDefs: [
	//    	{"className": "text-center", "targets": "_all"},
	//    ],
	//    order: [
	//        [ 0, 'desc' ]
	//    ],
	//    buttons: [
	//    ],
	//    createdRow: function( row, data, dataIndex ) {
	//	    $(row).attr('data-location-cd', locationCd);
    //    },
	//	drawCallback: function () {
	//		 $('.mo_card tbody').css('font-size','10px');
    //   },
	//});

	//var lineCheck = false;
    //$('#barcodeOutputWhsTable tbody').on('click', 'tr', function () {
    //    if ( $(this).hasClass('selected') ) {
    //        $(this).removeClass('selected');
    //        lineCheck = false;
    //    }	
    //    else {
    //    	$('#barcodeOutputWhsTable').DataTable().$('tr.selected').removeClass('selected');
    //        $(this).addClass('selected');
    //        lineCheck = true;
    //    }
    //});
    
	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
	    if (e.which == 13){
	    	//if($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
	        //	$("#barcodeNo").val(null);        	
	        //	$("#chooseDate").focus();
	        //	toastr.warning("입고일을 선택해주세요!");
	        //	return false
	        //}
	    	//if($("#location").val() == null || $("#location").val() == "") {
	        //	$("#barcodeNo").val(null);
	        //	toastr.warning("창고위치를 선택해주세요!");
	        //	$('#location').focus();
	        //	return false
	        //}
	    	if ( !$.trim($('#barcodeNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#barcodeNo').select();
	            return false;
	        }
	    	//if ( $('#barcodeNo').val().trim().length != "12" && $('#barcodeNo').val().trim().length != "13" ) {
	        //    toastr.warning('자재입고 바코드가 아닙니다. 확인해주세요');
	        //    $('#barcodeNo').focus();
	        //    $('#barcodeNo').val("");
	        //    return false;
	    	//}
	        //var cval = compareBarcodeNo($('#barcodeNo').val());
	        //if(cval == false) {
	        //	$('#barcodeNo').select();
			//	toastr.error('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
	        //    return false;              
	        //}
	        
			$.ajax({
	 			url: '<c:url value="/pd/matrlStatusCheck"/>',
				type: 'GET',
				data: {
					'menuAuth'		:		menuAuth,
					'barcodeNo'		:		$('#barcodeNo').val().trim(),
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
					let result = res.result;
					let data = res.data;
					if (result == 'ok') {
						
						$('#matrlCd').val(data.matrlCd);
						$('#matrlNm').val(data.matrlNm);
						$('#lotNo').val(data.lotNo);
						$('#readBarcodeNo').val(data.barcodeNo);
						$('#approvalNm').val(data.approvalNm);
						$('#statusNm').val(data.statusNm);
						$('#preInWhsDate').val(moment(data.preInWhsDate).format('YYYY-MM-DD'));
						$('#inWhsDate').val(moment(data.inWhsDate).format('YYYY-MM-DD'));
						$('#inWhsQty').val(data.inWhsQty);
						$('#inspctDate').val(moment(data.inspctDate).format('YYYY-MM-DD'));
						$('#preOutWhsDate').val(moment(data.preOutWhsDate).format('YYYY-MM-DD'));
						$('#preOutEquipNm').val(data.preOutEquipNm);
						$('#preOutGoodsCd').val(data.preOutGoodsCd);
						$('#preOutGoodsNm').val(data.preOutGoodsNm);
						$('#outWhsDate').val(moment(data.outWhsDate).format('YYYY-MM-DD'));
						$('#outEquipNm').val(data.outEquipNm);
						$('#outGoodsCd').val(data.outGoodsCd);
						$('#outGoodsNm').val(data.outGoodsNm);
						$('#barcodeNo').focus();
						toastr.success("조회되었습니다.");
						
					} else if (result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
						$('#barcodeNo').select();
					} else if (result == 'error') {
						toastr.warning(res.message, '', {timeOut: 5000});
						$('#barcodeNo').select();
					}
				},
				complete:function(){
					//$('#btnAddConfirm').removeClass('d-none');
				}
			});
	    }
	});

	$('#btnReset').on('click', function() {
		$('#matrlCd').val("");
		$('#matrlNm').val("");
		$('#lotNo').val("");
		$('#readBarcodeNo').val("");
		$('#approvalNm').val("");
		$('#statusNm').val("");
		$('#preInWhsDate').val("");
		$('#inWhsDate').val("");
		$('#inWhsQty').val("");
		$('#inspctDate').val("");
		$('#preOutWhsDate').val("");
		$('#preOutEquipNm').val("");
		$('#preOutGoodsCd').val("");
		$('#preOutGoodsNm').val("");
		$('#outWhsDate').val("");
		$('#outEquipNm').val("");
		$('#outGoodsCd').val("");
		$('#outGoodsNm').val("");
		$('#barcodeNo').val('');
		$('#barcodeNo').focus();
	});
	

	// 저장 처리
    //$('#btnSave').on('click', function() {
    //    //if ( !$.trim($('#chooseDate').val()) ) {
    //    //    toastr.warning('입고일을 선택해주세요.');
    //    //    $('#chooseDate').focus();
    //    //    return false;
    //    //}
    //	if($("#location").val() == null || $("#location").val() == "") {
    //    	$("#barcodeNo").val(null);
    //    	toastr.warning("창고위치를 선택해주세요!");
    //    	$('#location').focus();
    //    	return false
    //    }
    //
    //	$('#my-spinner').show();
    //	
    //    createBarcodeNo();
    //    
    //    $.ajax({
    //        url: '<c:url value="/pd/locationUpdate"/>',
    //        type: 'POST',
    //        data: JSON.stringify(barcodeNoList),
    //        dataType:"json",
    //        contentType : "application/json; charset=UTF-8",
    //        beforeSend: function() {
    //          //  $('#btnAddConfirm').addClass('d-none');
    //        },
    //        success: function (res) {
    //            let data = res.data;
    //    
    //            if (res.result == 'ok') {
    //            	$('#btnAllClear').attr('disabled', true);
    //            	$('#btnLineClear').attr('disabled', true);
    //            	$('#btnSave').attr('disabled', true);
    //                $('#btnSave').attr('disabled', true);
    //                $('#barcodeNo').attr('disabled', true);
    //                $('#location').attr('disabled', true);
    //                toastr.success('자재입고 위치 저장되었습니다.');
	//				$('#btnCancel').addClass('d-none');
	//				$('#btnNew').removeClass('d-none');
    //            } else {
    //            	toastr.error(res.message, '', {timeOut: 5000});
    //            }
    //        },
    //        complete:function(){
    //        	$('#my-spinner').hide();
    //        }
    //    });
    //});

	//var barcodeNoList;
	//function createBarcodeNo() {
	//	barcodeNoList = new Array();
	//	var idx = 0;
    //
	//	$('#barcodeOutputWhsTable tbody tr').each(function(index){
	//		var locationCd =($(this).data('location-cd'));
	//		var barcodeNo= $(this).find('td').eq(1).html();
	//	 	//var inWhsDate = $("#chooseDate").val().replace(/-/g, '');
	//	 	var rowData = new Object();
	//	 	rowData.menuAuth = menuAuth;
	//		rowData.barcodeNo = barcodeNo;
	//		rowData.locationCd = locationCd;
	//		//rowData.inWhsDate = inWhsDate;
	//		barcodeNoList.push(rowData);
	//	});
	//	console.log(barcodeNoList);
	//	return idx;
	//}
	
	//전체 삭제
	//$('#btnAllClear').on('click', function() {
	//	$('#barcodeOutputWhsTable').DataTable().clear().draw();
	//	$('#btnAllClear').attr('disabled', true);
	//	$('#btnLineClear').attr('disabled', true);
	//	$('#btnSave').attr('disabled', true);
	//	$('#barcodeNo').val('');
	//	$('#barcodeNo').focus();
	//	count = 0;
	//	$('#count').text(count);
	//});

	//라인 삭제
	//$('#btnLineClear').on('click', function() {
	//	if ( lineCheck == true) {
	//    	$('#barcodeOutputWhsTable').DataTable().rows('.selected').remove().draw();
	//    	$("#barcodeNo").val("");
	//    	$("#barcodeNo").focus();
	//    	var rowCnt = $('#barcodeOutputWhsTable').DataTable().data().count(); 
	//    	if(rowCnt == 0) {
	//    		$('#btnSave').attr('disabled', true);
	//    		$('#btnAllClear').attr('disabled', true);
	//    		$('#btnLineClear').attr('disabled', true);
	//    	}
    //		count -= 1;
    //		$('#count').text(count);
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
	//	$('#barcodeNo').val('');
	//	$('#location').focus();
	//	$('#chooseDate').val(serverDate);
	//	selectBoxAppend(locationCode, "location", "", "2");
	//	count = 0;
	//	$('#count').text(count);
	//});

	//저장 완료 후 새로등록
	//$('#btnNew').on('click', function() {
	//	$('#btnCalendar').attr('disabled', false);
	//	$('#location').attr('disabled', false);
	//	$('#barcodeNo').attr('disabled', false);
	//	$('#barcodeOutputWhsTable').DataTable().clear().draw();
	//	$('#barcodeNo').val('');
	//	$('#btnCalendar').focus();
	//	$('#chooseDate').val(serverDate);
	//	selectBoxAppend(locationCode, "location", "", "2");
	//	$('#btnNew').addClass('d-none');
	//	$('#btnCancel').removeClass('d-none');
	//	count = 0;
	//	$('#count').text(count);
	//});

	//중복 예외처리 사용예정
	//function compareBarcodeNo(barcodeNo) {
	//    var result = true;
	//    $('#barcodeOutputWhsTable tbody tr').each(function(){
	//		var tbarcodeNo= $(this).find('td').eq(1).html();
	//		if(barcodeNo == tbarcodeNo) {
	//			result = false;
	//			return result;
	//		}
	//	});
	//	
	//    return result;
	//}

	//모바일 자판 On/Off
	$('#btnKeyboard').on('click', function() {
		var inputmode = $('#barcodeNo').attr('inputmode');
		if ( inputmode == 'none') {
			$('#btnKeyboard').text("자판 On");
			$('#barcodeNo').attr('inputmode', 'text');
		} else if ( inputmode == 'text' ) {
			$('#btnKeyboard').text("자판 Off");
			$('#barcodeNo').attr('inputmode', 'none');
		}
	});

</script>

</body>
</html>
