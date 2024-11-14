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

	<!-- 전체이동내역 확인 모달 시작 -->
	<div class="modal fade" id="sudelModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="">전체 이동내역</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" style="overflow-y: auto;height: 300px;">
					<table class="table table-sm table-bordered" id="sudelTable">
						<thead>
							<tr>
								<th>바코드 번호</th>
								<th>승인상태</th>
								<th>자재상태</th>
								<th>현재 위치</th>
							</tr>
						</thead>
						<tbody></tbody>
						<tfoot></tfoot>
					</table>
				</div>
				<div class="modal-footer">
					<label>※승인이 완료되고, 자재상태가 승인인것만 창고 이동 가능</label>
					<button type="button" class="btn btn-primary touch6" data-dismiss="modal" id="btnAdd" style="min-width: 70px;">추가</button>
					<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" id="btnGoodsFifoCheckCancel" style="min-width: 70px;">닫기</button>
	
				</div>
			</div>
		</div>
	</div>
	<!-- 전체이동내역 확인 모달 끝 -->
	
	<!--checkBox클릭 시 경고창 -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="">확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h5 id="textSudel"></h5>
					<h6>기존에 있던 데이터는 초기화됩니다.</h6>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary touch6" data-dismiss="modal" id="btnYes" style="min-width: 70px;">예</button>
					<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" id="btnNo" style="min-width: 70px;">닫기</button>
	
				</div>
			</div>
		</div>
	</div>
	<!-- checkBox클릭 시 경고창 모달 끝 -->
	
      <header class="pda_mo_hd">
         <a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a>
         <a href="/pdsc0010"><p class="mo_main_title">자재 창고 이동</p></a>
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
					<div class="col-3 mo_sort_title">Location NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<select class="custom-select custom-select-md" id="location"></select>
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
					<table id="barcodeOutputWhsTable" class="table table-bordered table-td-center">
						<thead class="thead-light">
							<tr>
								<th style="min-width: 40px">순번</th>
								<th style="min-width: 120px">바코드NO</th>
								<th style="min-width: 50px">자재코드</th>
	                            <th style="min-width: 120px">자재명</th>
	                            <th style="min-width: 40px">입고량 </th>
	                            <th style="min-width: 40px">이동 위치</th>
	                            <th style="min-width: 120px">LOT NO</th>
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
			<div class="mo_sumbox">
				<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
				<div class="row float-right">
					<div class="mo_roll mr-4">
						<!-- <label>합계</label><span class="mo_sum_font_lg" id="rowCount">0</span> <label>Roll</label> -->
					</div>
					<div class="row">
						<label class="mt-1">전체 이동</label>
						<input type="checkbox" class="form-check ml-2 mr-2" id="allLookupCheck" style="width: 25px; height:25px;">
						<div class="mo_kg">
							<span class="mo_sum_font_lg" id="count">0</span> <label>개수</label>
						</div>
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
	$(document).attr("title","자재 창고 이동");
	let menuAuth = 'pdsc0010';
	var serverDate = "${serverDate}"
	var barcodeNo = null;
	var matrlCd = null;
	var matrlNm = null;
	var preOutQty = null;
	var lotNo = null;
	var inWhsQty = null;
	var locationCd = null;
	var locationNm = null;

	var allLookup ='002';

	var count = 0;
	$('#location').focus();
	
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
	
	$("#location").change(function() {
		$('#barcodeNo').focus();
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
	            data: 'locationNm', 
		    		render: function(data, type, row, meta) {
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  locationNm;
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
		    $(row).attr('data-location-cd', locationCd);
        },
		drawCallback: function () {
			 $('.mo_card tbody').css('font-size','10px');
       },
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

    $('#btnYes').on('click', function(){
    	if(allLookup == '002'){
        	//개별 선택 -> 전체 선택
    		$('#barcodeOutputWhsTable').DataTable().clear().draw();
    		$('#btnAllClear').attr('disabled', true);
    		$('#btnLineClear').attr('disabled', true);
    		$('#btnSave').attr('disabled', true);
    		$('#barcodeNo').val('');
    		$('#barcodeNo').focus();
    		count = 0;
    		$('#count').text(count);

    		allLookup='001';
    		$('#barcodeNo').focus();
    		$("#allLookupCheck").prop("checked", true);
        }else if(allLookup =='001'){
        	//전체 선택 -> 개별 선택 
        	$('#barcodeOutputWhsTable').DataTable().clear().draw();
    		$('#btnAllClear').attr('disabled', true);
    		$('#btnLineClear').attr('disabled', true);
    		$('#btnSave').attr('disabled', true);
    		$('#barcodeNo').val('');
    		$('#barcodeNo').focus();
    		count = 0;
    		$('#count').text(count);

    		allLookup='002';
    		$('#barcodeNo').focus();
    		$("#allLookupCheck").prop("checked", false);
        }
    	
	});

    $('#btnNo').on('click', function(){
    	$("#allLookupCheck").prop("checked", false);
    	if(allLookup == '002') {
    		//개별 선택 -> 개별선택
    		$('#barcodeNo').focus();
    		$("#allLookupCheck").prop("checked", false);
        }else if(allLookup =='001') {
        	//전체선택-> 전체선택
    		$('#barcodeNo').focus();
    		$("#allLookupCheck").prop("checked", true);
        }
	});
    
    $('#allLookupCheck').on('click', function(){
		if($("#allLookupCheck").prop("checked")) {
			if(count!=0) {
				$('#textSudel').text("전체 이동으로 바꾸시겠습니까?");
				$('#checkModal').modal({backdrop: 'static'});
				$('#checkModal').modal('show');
			}else {
				allLookup='001';
				$('#barcodeNo').focus();
			}
        }else {
        	if(count!=0) {
        		$('#textSudel').text("개별 이동으로 바꾸시겠습니까?");
        		$('#checkModal').modal({backdrop: 'static'});
            	$('#checkModal').modal('show');
			}else {
				allLookup='002';
				$('#barcodeNo').focus();
			}
        }
    });


    var dataObj = new Object();
    var allDataObj = new Object();
	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
	    if (e.which == 13){
	    	//if($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
	        //	$("#barcodeNo").val(null);        	
	        //	$("#chooseDate").focus();
	        //	toastr.warning("입고일을 선택해주세요!");
	        //	return false
	        //}
	    	if($("#location").val() == null || $("#location").val() == "") {
	        	$("#barcodeNo").val(null);
	        	toastr.warning("창고위치를 선택해주세요!");
	        	$('#location').focus();
	        	return false
	        }
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
	        var cval = compareBarcodeNo($('#barcodeNo').val());
	        if(cval == false) {
	        	$('#barcodeNo').select();
				toastr.warning('추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
	            return false;              
	        }
	        
			$.ajax({
	 			url: '<c:url value="/io/matrlLocationCheck"/>',
				type: 'GET',
				data: {
					'menuAuth'	 	: 		menuAuth,
					'barcodeNo'   	:       $('#barcodeNo').val().trim(),
					'allLookup'	 	: 		allLookup
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
					let result = res.result;
					let data 	= res.data;
// 					let data2	= res.data2;
					allDataObj	= res.data3; 
					console.log(res);
					dataObj = res.data;
					if (result == 'ok') {
						if(allLookup == '001'){
							//001 == 전체 이동일때 값 확인히는 부분. 
							$('#sudelTable tbody').empty();
							$('#sudelTable tfoot').empty();

							var html1 = '<tr>';
								html1 +='<th colspan="4">이동 항목</th>';
								html1 +='</tr>';
							$('#sudelTable tbody').append(html1);
							
							//승인 내역
							for(var i=0; i<data.length; i++){
								if(data[i].statusCd == "A" && data[i].approvalCd == "001"){
									var html = '<tr>';
									html +='<td>'+data[i].barcodeNo+'</td>';
									html +='<td>'+data[i].approvalNm+'</td>';
									html +='<td>'+data[i].statusNm+'</td>';
									data[i].locationNm != null ? html +='<td>'+ data[i].locationNm +'</td>' :  html +='<td>-</td>';
									html +='</tr>';
									$('#sudelTable tbody').append(html);
								}
							}
							
							var html2 = '<tr>';
							html2 +='<th colspan="4">미 이동 항목</th>';
							html2 +='</tr>';
							$('#sudelTable tfoot').append(html2);

							for(var i=0; i<data.length; i++){
								if(data[i].statusCd != "A" && data[i].approvalCd != "001"){
									var html = '<tr>';
										html +='<td>'+data[i].barcodeNo+'</td>';
										html +='<td>'+data[i].approvalNm+'</td>';
										html +='<td>'+data[i].statusNm+'</td>';
										html +='<td>'+data[i].locationNm != null ?data[i].locationNm : '-'+'</td>';
										data[i].locationNm != null ? html +='<td>'+ data[i].locationNm +'</td>' :  html +='<td>-</td>';
										html +='</tr>';
									$('#sudelTable tfoot').append(html);
								}
							}
							
							$('#sudelTable tbody tr td').attr('style','text-align:center;');
							$('#sudelTable tfoot tr td').attr('style','text-align:center;');
							$('#sudelModal').modal({backdrop: 'static'});
							$('#sudelModal').modal('show');
							
						//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ001 == 전체 이동일때 값 확인히는 부분. 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
						}else if(allLookup == '002') {
							barcodeNo	= data.barcodeNo;
							matrlCd		= data.matrlCd;
							matrlNm		= data.matrlNm;
							lotNo		= data.lotNo;
							inWhsQty	= data.inWhsQty;

							locationCd	= $("#location option:selected").val();
							locationNm	= $("#location option:selected").text();
							
							$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);

							count += 1;
							$('#count').text(count);
							toastr.success('추가되었습니다.');
						}
						
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						//$('#location').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
						
						
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

	
	//추가버튼 클릭 시
	$('#btnAdd').on('click',function(){
		$('#my-spinner').show();
		var newDataCheckArray = new Array();
		for(var i=0; i<allDataObj.length; i++){
			$.ajax({
	 			url: '<c:url value="/io/matrlLocationCheck"/>',
				type: 'GET',
				async: false,
				data: {
					'menuAuth'	 	: 	menuAuth,
					'barcodeNo'   	:	allDataObj[i].barcodeNo,
					'allLookup'	 	: 	"003"
				},
				async: false,
				success: function (res) {
					let data = res.data;
					newDataCheckArray.push(data);
				}
			});
		}
		var array = new Array();
		var stateCheck = 'Y';
		for(var i=0; i<allDataObj.length; i++){
			if(allDataObj[i].approvalCd != newDataCheckArray[i].approvalCd){
				$('#my-spinner').hide();
				array.push(allDataObj[i].barcodeNo);
				stateCheck = 'N';
			}
		}
		if(stateCheck =='N') {
			var aText= array+"<br>상태 값이 변경되었습니다. 다시 스캔해주세요.";
			aText = aText.replace(/,/g, '<br>');
			toastr.warning(aText);
		} else {
			var tableLength = $('#barcodeOutputWhsTable tbody tr').length;
			for(var i=0; i<dataObj.length; i++){
				for(var j=0; j<tableLength; j++){
					if(dataObj[i].barcodeNo == $('#barcodeOutputWhsTable tbody tr').eq(j).find('td').eq(1).text()){
						delete dataObj[i];
						break;
					}
				}
			}
			for(var i=0; i<dataObj.length; i++){
				if(dataObj[i]!=null){
					if(dataObj[i].statusCd == "A" && dataObj[i].approvalCd == "001"){
						barcodeNo 	= dataObj[i].barcodeNo;
						matrlCd 	= dataObj[i].matrlCd;
						matrlNm 	= dataObj[i].matrlNm;
						lotNo 		= dataObj[i].lotNo;
						inWhsQty 	= dataObj[i].inWhsQty;
						locationCd 	= $("#location option:selected").val();
						locationNm 	= $("#location option:selected").text();
						
						$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
						count += 1;
						$('#count').text(count);
					}
				}
			}
			toastr.success('추가되었습니다.');
			$('#my-spinner').hide();
		}
	});

	// 저장 처리
    $('#btnSave').on('click', function() {
    	var newDataCheckArray = new Array();
    	
        if(allLookup == '001'){
        	newDataCheckArray = new Array();
    		for(var i=0; i<allDataObj.length; i++){
    			$.ajax({
    	 			url: '<c:url value="/io/matrlLocationCheck"/>',
    				type: 'GET',
    				data: {
    					'menuAuth'	 	: 	menuAuth,
    					'barcodeNo'   	:	allDataObj[i].barcodeNo,
    					'allLookup'	 	: 	"003"
    				},
    				async: false,
    				success: function (res) {
    					let data = res.data;
    					if(res.result == 'ok'){
    						newDataCheckArray.push(data);
        				} else {
    	                	toastr.error(res.message, '', {timeOut: 5000});
    	                }
    				}
    			});
    		}
    		var array = new Array();
    		var stateCheck = 'Y';
    		for(var i=0; i<allDataObj.length; i++){
    			if(allDataObj[i].approvalCd != newDataCheckArray[i].approvalCd){
    				$('#my-spinner').hide();
    				array.push(allDataObj[i].barcodeNo);
    				stateCheck = 'N';
    			}
    		}
        }else{
            var barcodeOutputWhsTableArray	= new Array();
            var obj		= new Object();

       		for(var i=0; i<$('#barcodeOutputWhsTable tbody tr').length; i++){
       			obj = new Object();
       			
       			obj.barcodeNo	= $('#barcodeOutputWhsTable tbody tr').eq(i).find('td').eq(1).text();
       			obj.locationCd	= $('#barcodeOutputWhsTable tbody tr').eq(i).attr('data-location-cd');
       			obj.approvalCd	= '001';
       			
       			barcodeOutputWhsTableArray.push(obj);
       		}
       		
            console.log(barcodeOutputWhsTableArray);

        	newDataCheckArray = new Array();
        	for(var i=0; i<barcodeOutputWhsTableArray.length; i++){
    			$.ajax({
    	 			url: '<c:url value="/io/matrlLocationCheck"/>',
    				type: 'GET',
    				data: {
    					'menuAuth'	 	: 	menuAuth,
    					'barcodeNo'   	:	function(){return barcodeOutputWhsTableArray[i].barcodeNo;},
    					'allLookup'	 	: 	"003"
    				},
    				async: false,
    				success: function (res) {
    					let data = res.data;
    					if(res.result == 'ok'){
    						newDataCheckArray.push(data);
        				} else {
    	                	toastr.error(res.message, '', {timeOut: 5000});
    	                }
    					
    				}
    			});
    		}
    		var array = new Array();
    		var stateCheck = 'Y';
    		for(var i=0; i<barcodeOutputWhsTableArray.length; i++){
    			if(barcodeOutputWhsTableArray[i].approvalCd != newDataCheckArray[i].approvalCd){
    				$('#my-spinner').hide();
    				array.push(barcodeOutputWhsTableArray[i].barcodeNo);
    				stateCheck = 'N';
    			}
    		}
		}
    	
		if(stateCheck =='N') {
			var aText= array+"<br>상태 값이 변경되었습니다. 다시 스캔해주세요.";
			aText = aText.replace(/,/g, '<br>');
			toastr.warning(aText);
		}else {
			
			//if ( !$.trim($('#chooseDate').val()) ) {
	        //    toastr.warning('입고일을 선택해주세요.');
	        //    $('#chooseDate').focus();
	        //    return false;
	        //}
	    	if($("#location").val() == null || $("#location").val() == "") {
	        	$("#barcodeNo").val(null);
	        	toastr.warning("창고위치를 선택해주세요!");
	        	$('#location').focus();
	        	return false
	        }

	    	$('#my-spinner').show();
	    	
	        createBarcodeNo();
	        
	        $.ajax({
	            url: '<c:url value="/pd/locationUpdate"/>',
	            type: 'POST',
	            data: JSON.stringify(barcodeNoList),
	            dataType:"json",
	            contentType : "application/json; charset=UTF-8",
	            beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	            },
	            success: function (res) {
	                let data = res.data;
	        
	                if (res.result == 'ok') {
	                	$('#btnAllClear').attr('disabled', true);
	                	$('#btnLineClear').attr('disabled', true);
	                	$('#btnSave').attr('disabled', true);
	                    $('#btnSave').attr('disabled', true);
	                    $('#barcodeNo').attr('disabled', true);
	                    $('#location').attr('disabled', true);
	                    toastr.success('자재입고 위치 저장되었습니다.');
						$('#btnCancel').addClass('d-none');
						$('#btnNew').removeClass('d-none');
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
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
	
	//전체 삭제
	$('#btnAllClear').on('click', function() {
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
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
	    	$('#barcodeOutputWhsTable').DataTable().rows('.selected').remove().draw();
	    	$("#barcodeNo").val("");
	    	$("#barcodeNo").focus();
	    	var rowCnt = $('#barcodeOutputWhsTable').DataTable().data().count(); 
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
		$('#location').attr('disabled', false);
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
		$('#barcodeNo').val('');
		$('#location').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(locationCode, "location", "", "2");
		count = 0;
		$('#count').text(count);
	});

	//저장 완료 후 새 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#location').attr('disabled', false);
		$('#barcodeNo').attr('disabled', false);
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
		$('#barcodeNo').val('');
		$('#btnCalendar').focus();
		$('#chooseDate').val(serverDate);
		selectBoxAppend(locationCode, "location", "", "2");
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
		$('#allLookupCheck').prop("checked", false);
		allLookup='002';
	});
	
	//중복 예외처리 사용예정
	function compareBarcodeNo(barcodeNo) {
	    var result = true;
	    $('#barcodeOutputWhsTable tbody tr').each(function(){
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
