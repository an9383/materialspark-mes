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
         <a href="/pdsc0010"><p class="mo_main_title">자재 불량&반품 처리</p></a>
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
				 -->
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">불량 & 반품 상태</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<select class="custom-select custom-select-md" id="approval"></select>
					</div>
				</div>
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Barcode NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="barcodeNo" inputmode="none">
					</div>
				</div>
			</div>
			<!--버튼영역-->
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
		    <!--end버튼영역-->
	  <!--==end==-sortbox-->
	   <main style="height: calc(100vh - 50px);overflow:auto;">
		<div class="container-fluid bg_wh" id="main" style="height: 100%;display: flex;flex-direction: column;">
			<div class="card mo_card" style="OVERFLOW-Y:auto; width:100%;">
				<div class="table-responsive">
					<table id="matrlFaultyReturnTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 40px">순번</th>
								<th style="min-width: 120px">바코드NO</th>
								<th style="min-width: 50px">자재코드</th>
	                            <th style="min-width: 120px">자재명</th>
	                            <th style="min-width: 40px">입고량 </th>
	                            <th style="min-width: 40px">현재 상태</th>
	                            <th style="min-width: 40px">불량 & 반품처리</th>
	                            <th style="min-width: 120px">LOT NO</th>
	                            <!-- <th style="min-width: 30px"> approvalCd </th> -->
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
			<div class="mo_sumbox">
				<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
					</div>
					<div class="mo_kg">
						<span class="mo_sum_font_lg" id="count">0</span> <label>개수</label>
					</div>
				</div>
			</div>	
	  </footer>
</div>
<!-- /.app -->
<script type="text/javascript" src="/resources/assets/javascript/pages/calendar.js"></script>

<%@include file="../layout/script.jsp" %>
<%@include file="../layout/bottom.jsp" %>

<script>

	$(document).attr("title","자재 반품&폐기 처리");
	let menuAuth = 'pdsc0090';
	var serverDate = "${serverDate}"
	var barcodeNo = null;
	var matrlCd = null;
	var matrlNm = null;
	var preOutQty = null;
	var lotNo = null;
	var inWhsQty = null;
	//var approvalCd = null;
	var approvalNm = null;
	var count = 0;
	$('#approval').focus();
	
	//공통코드 처리 시작
	var approvalCode = new Array(); // 설치장소
	var json1 = new Object();
	json1.baseCd = "003";
	json1.baseCdNm = "불량";
	approvalCode.push(json1);
	var json2 = new Object();
	json2.baseCd = "005";
	json2.baseCdNm = "반품";
	approvalCode.push(json2);
	//공통코드 처리 끝
	
	selectBoxAppend(approvalCode, "approval", "", "2");
	$('#chooseDate').val(serverDate);
	
	$("#approval").change(function() {
		$('#barcodeNo').focus();
	});

	$.fn.dataTable.ext.errMode = 'none';
	let matrlFaultyReturnTable = $('#matrlFaultyReturnTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	    autoWidth: false,
	    scrollX : false,
	    lengthChange: false,
	    searching: false,
	    pageLength: 20,            
	    ajax: {
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	         },
	//         success : function(res) {
	//             console.log(res);
	//             rightSide = false;
	//         }
	    },
	    //rowId: '',
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
	        { 
	            data: 'barcodeNo', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  barcodeNo;
		    			}
		    		}
	        },
	        { 
	            data: 'matrlCd', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  matrlCd;
		    			}
		    		}
	        },
	        { 
	            data: 'matrlNm', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  matrlNm;
		    			}
		    		}
	        },
	        { 
	            data: 'inWhsQty', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  inWhsQty;
		    			}
		    		}
	        },
	        { 
	            data: 'approvalNm', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  approvalNm;
		    			}
		    		}
	        },
	        { 
	            data: '', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  chooseApprovalNm;
		    			}
		    		}
	        },
	        { 
	            data: 'lotNo', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  lotNo;
		    			}
		    		}
	        },
	    ],
	    columnDefs: [
	    	{"className": "text-center", "targets": "_all"},
	    ],
	    order: [
	        [ 0, 'desc' ]
	    ],
	    buttons: [
	    ],
	    createdRow: function( row, data, dataIndex ) {
		    $(row).attr('data-chooseApprovalCd-cd', chooseApprovalCd);
        },
		drawCallback: function () {
			 $('.mo_card tbody').css('font-size','10px');
       },
	});

	var lineCheck = false;
    $('#matrlFaultyReturnTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            lineCheck = false;
        }	
        else {
        	$('#matrlFaultyReturnTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            lineCheck = true;
        }
    });
    
	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
	    if (e.which == 13){
	    	//if($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
	        //	$("#barcodeNo").val(null);        	
	        //	$("#chooseDate").focus();
	        //	toastr.warning("입고일을 선택해주세요!");
	        //	return false
	        //}
	    	if($("#approval").val() == null || $("#approval").val() == "") {
	        	$("#barcodeNo").val(null);
	        	toastr.warning("자재 상태를 선택해주세요!");
	        	$('#approval').focus();
	        	return false
	        }
	    	if ( !$.trim($('#barcodeNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#barcodeNo').focus();
	            return false;
	        }
	    	//if ( $('#barcodeNo').val().trim().length != "12" && $('#barcodeNo').val().trim().length != "13" ) {
	        //    toastr.warning('자재입고 바코드가 아닙니다. 확인해주세요');
	        //    $('#barcodeNo').focus();
	        //    $('#barcodeNo').val("");
	        //    return false;
	    	//}
	        var cval = compareBarcodeNo($('#barcodeNo').val());
	        if(cval == false) {
	        	$('#barcodeNo').val("");
				$('#barcodeNo').focus();
				toastr.error('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
	            return false;
	        }
	        
			$.ajax({
	 			url: '<c:url value="/io/matrlFaultyReturnCheck"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'barcodeNo'   	:        $('#barcodeNo').val().trim(),
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
					let result = res.result;
					let data = res.data;
					if (result == 'ok') {
						barcodeNo = data.barcodeNo;
						matrlCd = data.matrlCd;
						matrlNm = data.matrlNm;
						lotNo = data.lotNo;
						inWhsQty = data.inWhsQty;
						approvalNm = data.approvalNm;
						chooseApprovalCd = $("#approval option:selected").val();
						chooseApprovalNm = $("#approval option:selected").text();
						
						$('#matrlFaultyReturnTable').DataTable().row.add({}).draw(false);
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						//$('#approval').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
						count += 1;
						$('#count').text(count);
						toastr.success('추가되었습니다.');
					} else if (result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
					} else if (result == 'error') {
						toastr.warning(res.message, '', {timeOut: 5000});
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
					}
				},
				complete:function(){
					//$('#btnAddConfirm').removeClass('d-none');
				}
			});
	    }
	});

	// 저장 처리
    $('#btnSave').on('click', function() {
        //if ( !$.trim($('#chooseDate').val()) ) {
        //    toastr.warning('입고일을 선택해주세요.');
        //    $('#chooseDate').focus();
        //    return false;
        //}
    	if($("#approval").val() == null || $("#approval").val() == "") {
        	$("#barcodeNo").val(null);
        	toastr.warning("처리할 자재 상태를 선택해주세요!");
        	$('#approval').focus();
        	return false
        }

    	$('#my-spinner').show();
    	
        createBarcodeNo();
        
        //$.ajax({
        //    url: '<c:url value="/pd/approvalUpdate"/>',
        //    type: 'POST',
        //    data: JSON.stringify(barcodeNoList),
        //    dataType:"json",
        //    contentType : "application/json; charset=UTF-8",
        //    beforeSend: function() {
        //      //  $('#btnAddConfirm').addClass('d-none');
        //    },
        //    success: function (res) {
        //        let data = res.data;
        //
        //        if (res.result == 'ok') {
        //        	$('#btnAllClear').attr('disabled', true);
        //        	$('#btnLineClear').attr('disabled', true);
        //        	$('#btnSave').attr('disabled', true);
        //            $('#btnSave').attr('disabled', true);
        //            $('#barcodeNo').attr('disabled', true);
        //            $('#approval').attr('disabled', true);
        //            toastr.success('자재입고 위치 저장되었습니다.');
		//			$('#btnCancel').addClass('d-none');
		//			$('#btnNew').removeClass('d-none');
        //        } else {
        //        	toastr.error(res.message, '', {timeOut: 5000});
        //        }
        //    },
        //    complete:function(){
        //    	$('#my-spinner').hide();
        //    }
        //});
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
		
		$('#matrlFaultyReturnTable tbody tr').each(function(index){
			//주의 //주의 //주의 //주의 //주의 //주의 
			var approvalCd =($(this).data('chooseapprovalcdCd'));		//주의 : $(this).data('chooseApprovalCd-cd')를 못쓰는 이유 : cd로 데이터 구분하는것 같음. 콘솔로 $(this).data() 처보면 이름이 chooseapprovalcdCd 로 표시됨
			var barcodeNo= $(this).find('td').eq(1).html();
		 	//var inWhsDate = $("#chooseDate").val().replace(/-/g, '');
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.barcodeNo = barcodeNo;
			rowData.approvalCd = approvalCd;
			//rowData.inWhsDate = inWhsDate;
			barcodeNoList.push(rowData);
		});
		console.log(barcodeNoList);
		return idx;
	}
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#matrlFaultyReturnTable').DataTable().clear().draw();
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
		$('#barcodeNo').val('');
		$('#barcodeNo').focus();
		count = 0;
		$('#count').text(count);
	});

	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if ( lineCheck == true) {
	    	$('#matrlFaultyReturnTable').DataTable().rows('.selected').remove().draw();
	    	$("#barcodeNo").val("");
	    	$("#barcodeNo").focus();
	    	var rowCnt = $('#matrlFaultyReturnTable').DataTable().data().count(); 
	    	if(rowCnt == 0) {
	    		$('#btnSave').attr('disabled', true);
	    		$('#btnAllClear').attr('disabled', true);
	    		$('#btnLineClear').attr('disabled', true);
	    	}
    		count -= 1;
    		$('#count').text(count);
		} else {
	    	toastr.warning('삭제할 라인을 선택하세요.');
		}
	});
	
	//취소 버튼
	$('#btnCancel').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#approval').attr('disabled', false);
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#matrlFaultyReturnTable').DataTable().clear().draw();
		$('#barcodeNo').val('');
		$('#approval').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(approvalCode, "approval", "", "2");
		count = 0;
		$('#count').text(count);
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#approval').attr('disabled', false);
		$('#barcodeNo').attr('disabled', false);
		$('#matrlFaultyReturnTable').DataTable().clear().draw();
		$('#barcodeNo').val('');
		$('#btnCalendar').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(approvalCode, "approval", "", "2");
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
	});
	
	//중복 예외처리 사용예정
	function compareBarcodeNo(barcodeNo) {
	    var result = true;
	    $('#matrlFaultyReturnTable tbody tr').each(function(){
			var tbarcodeNo= $(this).find('td').eq(1).html();
			if(barcodeNo == tbarcodeNo) {
				result = false;
				return result;
			}
		});
		
	    return result;
	}

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
