<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% String userNm = session.getAttribute("userNm").toString(); %>

<%@include file="../layout/topPda.jsp" %>
<style>
 body{
  overflow:hidden;
 }
 
</style>
<!-- .app -->
<div class="app pda_mo_wrap" style="display: flex;flex-direction: column;height: 100%;">
	<header class="pda_mo_hd">
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc0020"><p class="mo_main_title">자재출고</p></a>
	</header>
			<!--====-sortbox-->
			<div class="mo_sortbox">
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">출고일</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input class="form-control-md" type="text" id="chooseDate" disabled />
						<button onclick="fnPopUpCalendar(chooseDate,chooseDate,'yyyy-mm-dd');" class="btn btn-secondary input-sub-search-md" type="button" id="btnCalendar">
							<span class="oi oi-calendar"></span>
						</button>
					</div>
				</div>
				
				
				<div class="col-12 row p-1 d-none">
					<input type="hidden" class="form-control" id="equipCd" name="equipCd">
					<div class="col-3 mo_sort_title">설비명</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="equipNm" name="equipNm" disabled>
						<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelEquipCode" onClick="selectEquipCode()">
							<span class="oi oi-magnifying-glass"></span>
						</button>
					</div>
				</div>
				<div class="col-12 row p-1 d-none">
					<input type="hidden" class="form-control" id="goodsCd" name="goodsCd">
					<div class="col-3 mo_sort_title">제품명</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="goodsNm" name="goodsNm" disabled>
						<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelGoodsCode" onClick="selectGoodsCode()">
							<span class="oi oi-magnifying-glass"></span>
						</button>
					</div>
				</div>
				
				<div class="col-12 row p-1">
					<input type="hidden" class="form-control" id="preWorkCharger"  name="preWorkCharger">
					<div class="col-3 mo_sort_title">담당자</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="preWorkChargerNm"  name="preWorkChargerNm">
						<button type="button" class="btn btn-primary input-sub-search-md" id="btnSelPreWorkCharger" onClick="selectPreWorkCharger()">
							<span class="oi oi-magnifying-glass"></span>
			        	</button>
		        	</div>
		       </div>
				
				<div class="col-12 row p-1 d-none" id="floorDiv">
					<div class="col-3 mo_sort_title">층 구분자</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<select class="custom-select custom-select-md" id="floorGubun"></select>
		        	</div>
		       </div>
				
				<div class="col-12 row p-1">
					<div class="col-3 mo_sort_title">Barcode NO</div>
					<div class="form-group input-sub col-9 m-0 p-0">
						<input type="text" class="form-control-md" id="barcodeNo" inputmode="none">
						<button type="button" class="btn btn-primary input-sub-search-md d-none" id="btnBarcode" onClick="selectBarcode()">
							<span class="oi oi-magnifying-glass"></span>
				        </button>
					</div>
				</div>
			</div>
			<!--==버튼영역-->
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
								<th style="min-width: 20px">순번</th>
								<th style="min-width: 90px">바코드NO</th>
								<th style="min-width: 40px">자재코드</th>
								<th style="min-width: 120px">자재명</th>
								<th style="min-width: 110px">LOT NO</th>
								<th style="min-width: 40px">가출고량</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!--==end==card-->
			<!--==end==table-->

		</div>
		<!-- 제품 모달 시작-->
		<div class="modal fade bd-example-modal-lg" id="goodsPopUpModal" tabindex="-1" role="dialog" aria-labelledby="goodsPopUpModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header" style="padding-bottom: 0px;">
						<h5 class="modal-title" id="goodsPopUpLabel">제품코드조회</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
						<table id="goodsCdPopUpTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>제품코드</th>
									<th>제품명</th>
									<th>모델NO</th>
								</tr>
							</thead>
						</table>
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary touch5" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 제품 모달 종료-->
		<!-- 설비 모달 시작-->
		<div class="modal fade bd-example-modal-lg" id="equipPopUpModal" tabindex="-1" role="dialog" aria-labelledby="equipPopUpModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header" style="padding-bottom: 0px;">
						<h5 class="modal-title" id="equipPopUpLabel">설비코드조회</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
						<table id="equipCdPopUpTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th>설비코드</th>
									<th>설비명</th>
									<th>설비그룹</th>
								</tr>
							</thead>
						</table>
						<hr class="text-secondary" style="margin-top: 8px; margin-bottom: 8px;">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 설비 모달 종료-->
		<!-- 생산제품 선입선출 확인 모달 시작 -->
		<div class="modal fade" id="goodsFifoCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="">선입선출 대상 목록 조회</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<label id="goodsFifoCheckLabel1"></label>
						<h6 id="goodsFifoCheckLabel2"></h6>
						<h6 id="goodsFifoCheckLabel3"></h6>
						
						<!-- 선입선출 목록 -->
						<div style="height: 450px; overflow: auto;">
							<table class="table table-sm table-bordered" id="goodsFifoCheckTable" style="width: 100vh;">
								<thead>
									<tr>
										<th>자재코드</th>
										<th>자재명</th>
										<th>바코드</th>
										<th>입고일</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
<!-- 						<button type="button" class="btn btn-primary" id="btnGoodsFifoAdd" style="min-width: 70px;">출하</button> -->
<!-- 						<button type="button" class="btn btn btn-secondary" data-dismiss="modal" id="btnGoodsFifoCancel" style="min-width: 70px;">닫기</button> -->
						<button type="button" class="btn btn-primary" id="btnGoodsFifoAdd">출하</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 생산제품 선입선출 확인 모달 끝 -->
		
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
	$(document).attr("title","자재투입");
	let menuAuth = 'pdsc0020';
	var userNm = "<%=userNm%>";
	let factoryCode = "<%=factoryCode%>";
	
	var serverDate = "${serverDate}"
	var barcodeNo = null;
	var equipCd = null;
	var equipNm = null;
	var goodsCd = null;
	var goodsNm = null;
	var preOutQty = null;
	var lotNo = null;
	var inspectQty = null;
	var count = 0;
	var inWhsDate ='';

	var exceptBarcodeNo = 'empty';		//스캔한 포장번호(선입선출에서 추가로 제외시킬애들);
	
	//3공장인 경우에만 사용
	if( factoryCode == "003" ) {
		$('#floorDiv').removeClass('d-none');
	}
	
	$('#chooseDate').val(serverDate);
	$('#btnSelEquipCode').focus();
	
	//공통코드 처리 시작
	var floorCode = new Array(); // 층구분자
    <c:forEach items="${floorCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCdAbbr}";
		json.baseCdNm="${info.baseCdNm}";
		floorCode.push(json);
    </c:forEach>
    //공통코드 처리 종료
    
    selectBoxAppend(floorCode, "floorGubun", "", "2");	//층구분자

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
	    rowId: '',
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
	            data: 'lotNo', 
		    		render: function(data, type, row, meta) {	
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  lotNo;
		    			}
		    		}
	        },
	        { 
	            data: 'preOutQty', 
		    		render: function(data, type, row, meta) {	
		    			if(data != null) {
		    				return data;
		    			} else {
		    				return  preOutQty;
		    			}
		    		}
	        },
	    ],
	    columnDefs: [
	    	{"className": "text-center", "targets": "_all"}
	    ],
	    order: [
	        [ 0, 'desc' ]
	    ],
	    buttons: [
	    ],
		drawCallback: function () {
			 $('.mo_card tbody').css('font-size','10px');
		},
	});

	var selectExceptBarcodeNo ='';
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
        selectExceptBarcodeNo =  $(this).find('td').eq(1).text();
    });

    var goodsFifoCheckBarcodeNo='';
    
    let sudelCheck = false;
    let bacodeNoCheck = false;
    
    
	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
		
		if (sudelCheck) {
			return false;
		}
		
	    if (e.which == 13){
	    	
	    	sudelCheck = true;
	    	
	    	if($("#chooseDate").val() == null || $("#chooseDate").val() == "") {
	        	$("#barcodeNo").val("");
	        	$("#chooseDate").focus();
	        	toastr.warning("출고일을 선택해주세요!");
	        	sudelCheck = false;
	        	return false
	        }
	    	if ( !$.trim($('#preWorkCharger').val()) ) {
                toastr.warning('담당자를 선택해 주세요.');
                $('#btnSelPreWorkCharger').focus();
                sudelCheck = false;
                return false;
            }
	    	/*if($("#equipCd").val() == null || $("#equipCd").val() == "") {
	    		$("#barcodeNo").val("");
	    		$("#btnSelEquipCode").focus();
	        	toastr.warning("설비명를 선택해주세요!");
	        	return false
	        }
	    	if($("#goodsCd").val() == null || $("#goodsCd").val() == "") {
	    		$("#barcodeNo").val("");
	    		$("#btnSelGoodsCode").focus();
	        	toastr.warning("제품명를 선택해주세요!");
	        	return false
	        } */
	        
	    	//if ( $('#barcodeNo').val().trim().length != "12" && $('#barcodeNo').val().trim().length != "13" ) {
	        //    toastr.warning('자재입고 바코드가 아닙니다. 확인해주세요');
	        //    $('#barcodeNo').val("");
	        //    $('#barcodeNo').focus();
	        //    return false;
	    	//}
	    	//키보드입력 말고 바코드로 스캔시 풀어주기
	    	if ( !$.trim($('#barcodeNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#barcodeNo').focus();
	            sudelCheck = false;
	            return false;
	        }
	        
	    	var cval = compareBarcodeNo($('#barcodeNo').val().trim());
	        if(cval == false) {
// 	        	toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
	        	toastr.warning('중복된 바코드 입니다.', '', {timeOut: 600});
	        	$('#barcodeNo').val('');
	        	$('#barcodeNo').select();
	        	sudelCheck = false;
	            return false;              
	        }
	        
			$.ajax({
	 			url: '<c:url value="/io/matrlPreOutWhsData"/>',
				type: 'GET',
				async: false,
				data: {
					'menuAuth'	 		: 		menuAuth,
					'barcodeNo'   		:       $('#barcodeNo').val().trim(),
					'exceptBarcodeNo'	:		function() { return exceptBarcodeNo; }
				},
				beforeSend: function() {
					//  $('#btnAddConfirm').addClass('d-none');
					//  $('#btnAddConfirmLoading').removeClass('d-none');
				},
				success: function (res) {
				let data = res.data;
					if (res.result == 'ok') {
						barcodeNo	= data.barcodeNo;
						matrlCd		= data.matrlCd;
						matrlNm		= data.matrlNm;
						lotNo		= data.lotNo;
						preOutQty	= data.preOutQty;
						inspectQty	= data.inspectQty;
						
						$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
						$('#btnSave').attr('disabled', false);
						$('#btnCalendar').attr('disabled', true);
						$('#equipNm').attr('disabled', true);
						$('#btnSelEquipCode').attr('disabled', true);
						$('#btnSelGoodsCode').attr('disabled', true);						
						$('#goodsNm').attr('disabled', true);
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
						count += 1;
						$('#count').text(count);
						exceptBarcodeNo += "/" + data.barcodeNo;	//스캔한 바코드 값 담아주기.
						
						twelveTimeCalc(data.inWhsTime);
						
						toastr.success('추가되었습니다.', '', {timeOut: 500});
						sudelCheck = false;
					} else if (res.result == 'fail') {
                    	toastr.warning(res.message, '', {timeOut: 5000});
                    	sudelCheck = false;
                    } else if (res.result == 'error') {
                    	toastr.error(res.message, '', {timeOut: 5000});
                    	sudelCheck = false;
                    } else {
                    	if(res.result == 'before') {
	                       	if(!compareBarcodeNo(res.barcode)) { //이전 바코드가 추가 되어 있는지 체크
	    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
	                		} else {
// 	                			toastr.warning('선입선출 대상이 '+res.barcode.length+'개 존재합니다. <br>'+res.barcode[0].barcodeNo, '', {timeOut: 5000});
								/*$('#goodsFifoCheckLabel1').text("*선출하 대상은 "+res.barcode.length+"개 입니다.");*/

								//선입선출 대상 모달
	                			/*$('#goodsFifoCheckTable tbody').empty();
								for(var i=0; i<res.barcode.length; i++){
									var rtn = '<tr><td style="text-align: center;">'+res.barcode[i].matrlCd+'</td>';
										rtn += '<td style="text-align: center;">'+res.barcode[i].matrlNm+'</td>';
										rtn += '<td style="text-align: center;">'+res.barcode[i].barcodeNo+'</td>';
										rtn += '<td style="text-align: center;">'+moment(res.barcode[i].inWhsDate).format('YYYY-MM-DD');'</td></tr>';
									$('#goodsFifoCheckTable tbody').append(rtn);
								}

								$('#goodsFifoCheckPopupModal').modal({backdrop: 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');*/
								//선입선출 대상 모달 끝
								
								$('#goodsFifoCheckLabel1').text("*선출하 대상은 "+res.barcode.length+"개 입니다.");
								goodsFifoCheckBarcodeNo = data.barcodeNo;	//goodsFifoCheckTable에 보내줄 바코드 값
								$('#goodsFifoCheckTable').DataTable().ajax.reload();
								$('#goodsFifoCheckPopupModal').modal({backdrop: 'static'});
								$('#goodsFifoCheckPopupModal').modal('show');
								sudelCheck = false;
	                		}
	                    } else {
							toastr.error(res.message, '', {timeOut: 5000});
							sudelCheck = false;
                        }
					}
				},
				complete:function(){
					$('#barcodeNo').val('');
           	     	$('#barcodeNo').focus();
				}
			});
	    }
	});

	//선입선출 테이블 조회
	let goodsFifoCheckTable = $('#goodsFifoCheckTable').DataTable({
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
            url: '<c:url value="/io/preOutWhsFifoCheck"/>',
            type: 'GET',
            data: {
            	'menuAuth'			:	menuAuth,
            	'barcodeNo'			:	function() {return goodsFifoCheckBarcodeNo;	},
            	'exceptBarcodeNo'	:	function() { return exceptBarcodeNo; 		}
             },
        },
        rowId: 'barcodeNo',
        columns: [
            { data: 'matrlCd'	},
            { data: 'matrlNm'	},
            { data: 'barcodeNo'	},
            { data : 'inWhsDate',
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			}
        ],
        columnDefs: [
        	{ targets: [0,1,2,3], className: 'text-center' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
    });

	var goodsFifoCheckTableBarcodeNo ='';
	var goodsFifoCheckTableMatrCd='';
	var goodsFifoCheckTableInWhsDate='';
	var goodsFifoCheckTableCount=0;

	//선입선출 대상 목록 클릭 시
   	$('#goodsFifoCheckTable tbody').on('click', 'tr', function(){

		var fifoCheckRowId = $(this).attr('id');

		//선택이 안되어있을 때 실행
		if(!$('#goodsFifoCheckTable tbody tr').hasClass('selected')==''){
			//선택되어있는 row가 아닐때
			if(!$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
				//기존 값과 다른 값을 클릭했을 때
				if(goodsFifoCheckTableMatrCd != $(this).find('td').eq(0).text() || goodsFifoCheckTableInWhsDate != $(this).find('td').eq(3).text()){
					
					$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).attr('style','background-color: red; color: white;');
					$('#goodsFifoCheckTable').attr('style', 'pointer-events : none;');
					
					toastr.warning("동일한 입고일과 자재코드를 선택해주세요.", {timeOut: 5000});
					
					setTimeout(function(){
						$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).attr('style','');
						$('#goodsFifoCheckTable').attr('style', '');
					},150);
					return false;
				}
			}
		}

		//선입선출 검사
		$.ajax({
			url : '<c:url value="/io/matrlPreOutWhsData"/>',
			type : 'GET',
			data : {
				'menuAuth'	 		: 		menuAuth,
            	'barcodeNo'   		:       function() { return $('#goodsFifoCheckTable').find('#'+fifoCheckRowId).find('td').eq(2).text();	},
            	'exceptBarcodeNo'	:		function() { return exceptBarcodeNo;	}
			},
			success : function(res) {
				let data = res.data;
// 				console.log(data);

				if (res.result == 'ok') {
					goodsFifoCheckTableCount = 0;			//선입선출 대상이 존재하는지 검사
                } else if (res.result == 'fail') {
                	toastr.warning(res.message, '', {timeOut: 5000});
                } else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                } else {
                    if(res.result == 'before') {
                       	if(!compareBarcodeNo(res.barcode)) { //이전 바코드가 추가 되어 있는지 체크
    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
	                        $('#barcodeNo').val('');
	                        $('#barcodeNo').focus();
                		} else {
							if($('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
								toastr.warning("선입선출된 자재("+moment(res.barcode[0].inWhsDate).format('YYYY-MM-DD')+")를 먼저 선택해주세요", {timeOut: 5000});
		                		goodsFifoCheckTableCount = res.barcode.length;	//선입선출 대상이 존재하는지 검사
			                }
                		}
                    } else {
                    	toastr.error(res.warning, '', {timeOut: 5000});
                    }
                }
			}
		});
		//선입선출 검사

		goodsFifoCheckTableMatrCd		=  $(this).find('td').eq(0).text();	// 자재코드
		goodsFifoCheckTableInWhsDate	=  $(this).find('td').eq(3).text();	//입고일
		
		if(!$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).hasClass('selected')){
			$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).addClass('selected');
			
			//사용시간 권고 함수
			twelveTimeCalc(goodsFifoCheckTable.row(this).data().inWhsTime);
		}else{
			$('#goodsFifoCheckTable').find('#'+fifoCheckRowId).removeClass('selected');
		}

   	   goodsFifoCheckTableBarcodeNo =  $(this).find('td').eq(2).text();
   	});
   	
  //선입선출 출하버튼 클릭 시
	$('#btnGoodsFifoAdd').on('click', function(){
		if(!$('#goodsFifoCheckTable tbody tr').hasClass('selected')) {
			toastr.warning("출하할 항목을 선택해주세요.");
			return false;
		}

		//묶음출고
		if(goodsFifoCheckTableCount !=0){
			toastr.warning("선입선출 대상이 존재합니다.");
			return false;
			
		}else{
			
			//선입 항목 클릭 시
			var array	= new Array();
			var obj		= new Object();
			let data	= goodsFifoCheckTable.rows('.selected').data();
// 			console.log(data);
			
			for(var i=0; i<data.length; i++){
				obj		= new Object();
				obj.barcodeNo = data[i].barcodeNo;
				array.push(obj);
			}
			
			var arrayData = JSON.stringify(array);

			//ajax
			$.ajax({
            	url: '<c:url value="/io/matrlPreOutWhsDataSuwan"/>',
                type: 'GET',
                data: {
                	'menuAuth'	 		: 	menuAuth,
                	'arrayData' 		:	function() { return arrayData; 			},
                	'exceptBarcodeNo'	:	function() { return exceptBarcodeNo;	}
                },
                beforeSend: function() {
                  //  $('#btnAddConfirm').addClass('d-none');
                },
                success: function (res) {
                	$('#my-spinner').show();
//	                	let data = res.data;
                    let data = res.receiveValue;
                    if (res.result == 'ok') {
						//보기
						for(var i=0; i<data.length; i++){

							barcodeNo	= data[i].barcodeNo;
							matrlCd		= data[i].matrlCd;
							matrlNm		= data[i].matrlNm;
							lotNo		= data[i].lotNo;
							preOutQty	= data[i].inspectQty;
							inspectQty	= data[i].inspectQty;
							
							$('#barcodeNo').val('');
							$('#barcodeNo').focus();
							$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
							exceptBarcodeNo += "/" + data[i].barcodeNo;	//스캔한 바코드 값 담아주기.
						}

						$('#btnSave').removeClass('d-none');
						$("#btnSave").attr("disabled", false);
						$('#btnCancel').removeClass('d-none');
						$('#btnSelPreWorkCharger').attr('disabled', true);
						$('#btnSelEquipCode').attr('disabled', true);
						$('#btnSelGoods').attr('disabled', true);
						$('#barcodePopUpModal').modal('hide');
						toastr.success("추가되었습니다.");
						
                    } else if (res.result == 'fail') {
                    	toastr.warning(res.message, '', {timeOut: 5000});
                    } else if (res.result == 'error') {
                    	toastr.error(res.message, '', {timeOut: 5000});
                    } else {
                    	if(res.result == 'before') {
	                       	if(!compareBarcodeNo(res.barcode)) {
	    	                    toastr.warning("선입선출된 자재를 먼저 저장해주세요!", '', {timeOut: 5000});
    	                        $('#barcodeNo').val('');
    	                        $('#barcodeNo').focus();
	                		} else {
 	                			toastr.warning(res.message, '', {timeOut: 5000});
	                		}
	                    } else {
	                    	toastr.error(res.warning, '', {timeOut: 5000});
	                    }
					}
	             },
	            complete:function(){
	            	$('#my-spinner').hide();
				}
	        });
			//ajax
    	}
   		$('#goodsFifoCheckPopupModal').modal('hide');
	});

  	//선입선출 모달이 닫혔을 때
	$('#goodsFifoCheckPopupModal').on('hidden.bs.modal', function (e) {
		if($('#barcodeNo').val().replaceAll(' ', '') != ''){
	    	$("#barcodeNo").focus();
			keypress("barcodeNo", "13");
		}else{
			$('#barcodeNo').val('');
		}
	});

	// 저장 처리
    $('#btnSave').on('click', function() {
        if ( !$.trim($('#chooseDate').val()) ) {
            toastr.warning('출고일을 선택해주세요.');
            return false;
        }
    	/*if($("#equipCd").val() == null || $("#equipCd").val() == "") {
        	$("#barcodeNo").val(null);
        	toastr.warning("설비명을 선택해주세요!");
        	return false
        }
    	if($("#goodsCd").val() == null || $("#goodsCd").val() == "") {
        	$("#barcodeNo").val(null);
        	toastr.warning("제품명을 선택해주세요!");
        	return false
        }*/
        
        if ( factoryCode == "003" && $('#floorGubun').val() == "" ) {
            toastr.warning('층 구분자를 선택해주세요.');
            $('#floorGubun').focus();
            return false;
        }

    	$('#my-spinner').show();
    	
        createBarcodeNo();
        
        $.ajax({
            url: '<c:url value="/pd/goodsEquipUpdatePOST"/>',
            type: 'POST',
            data: JSON.stringify(barcodeNoList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
              //  $('#btnAddConfirmLoading').removeClass('d-none');
            },
            success: function (res) {
                let data = res.data;
 
                if (res.result == 'ok') {
                	$('#btnAllClear').attr('disabled', true);
                	$('#btnLineClear').attr('disabled', true);
                	$('#btnSave').attr('disabled', true);                    
                    $('#barcodeNo').attr('disabled', true);
                    toastr.success('자재출고 저장되었습니다.');
					$('#btnCancel').addClass('d-none');
					$('#btnNew').removeClass('d-none');
                }  else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
    });

	var barcodeNoList;
	
	function createBarcodeNo() {
		barcodeNoList = new Array();
		var idx = 0;
		$('#barcodeOutputWhsTable tbody tr').each(function(){
		 	var barcodeNo	= $(this).find('td').eq(1).html();
		 	var equipCd	 	= $("#equipCd").val();
			var goodsCd	 	= $("#goodsCd").val();
		 	var inWhsDate 	= $("#chooseDate").val().replace(/-/g, '');
		 	var preOutQtyTo	= $(this).find('td').eq(5).html();
		 	var rowData	 	= new Object();
		 	
		 	rowData.menuAuth 		= menuAuth;
			rowData.barcodeNo	 	= barcodeNo;
			rowData.preOutGoodsCd 	= goodsCd;
			rowData.preOutEquipCd 	= equipCd;
			rowData.preOutWhsDate 	= inWhsDate;
			rowData.preOutQty 		= preOutQtyTo;
			
			if( factoryCode == "003" ) {
				rowData.floorGubun = $("#floorGubun").val();	
			}
			
			barcodeNoList.push(rowData);
		});
// 		console.log(barcodeNoList);
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
		exceptBarcodeNo='empty';
	});

	//라인 삭제
	$('#btnLineClear').on('click', function() {
		if ( lineCheck == true) {
	    	$('#barcodeOutputWhsTable').DataTable().rows('.selected').remove().draw();
	    	$("#barcodeNo").val("");
	    	$("#barcodeNo").focus();
	    	var rowCnt = $('#barcodeOutputWhsTable').DataTable().data().count();
	    	exceptBarcodeNo = exceptBarcodeNo.replace('/'+selectExceptBarcodeNo,'');
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
		$('#btnSave').attr('disabled', true);
		$('#btnAllClear').attr('disabled', true);
		$('#btnLineClear').attr('disabled', true);
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
		$('#equipCd').val('');
		$('#equipNm').val('');
		$('#goodsCd').val('');
		$('#goodsNm').val('');
		$('#barcodeNo').val('');
		$('#btnSelEquipCode').focus();
		//$('#chooseDate').val(serverDate);
		count = 0;
		$('#count').text(count);
		exceptBarcodeNo='empty';
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#goodsNm').attr('disabled', false);
		$('#equipNm').attr('disabled', false);
		$('#barcodeNo').attr('disabled', false);
		$('#btnSelEquipCode').attr('disabled', false);
		$('#btnSelGoodsCode').attr('disabled', false);
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
		$('#equipCd').val('');
		$('#equipNm').val('');
		$('#goodsCd').val('');
		$('#goodsNm').val('');
		$('#barcodeNo').val('');
		$('#btnCalendar').focus();

		$('#floorGubun').val('');
		
		//$('#chooseDate').val(serverDate);
		$('#btnNew').addClass('d-none');
		$('#btnCancel').removeClass('d-none');
		count = 0;
		$('#count').text(count);
		exceptBarcodeNo='empty';
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

   	//설비코드조회 팝업 시작
   	var equipCdPopUpTable;
   	function selectEquipCode()
   	{
		if(equipCdPopUpTable == null || equipCdPopUpTable == undefined)	{
			equipCdPopUpTable = $('#equipCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="bm/equipCodeAdmDataList"/>',
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
		        rowId: 'equipCd',
		        columns: [
		            { data: 'equipCd' },
		            { data: 'equipNm' },
		            { data: 'equipGroupNm' }
		        
		        ],
		        columnDefs: [
		        	//{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2],  "className": "text-center"}
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		
		        buttons: [
		            
		        ],
		    });

		    $('#equipCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = equipCdPopUpTable.row( this ).data();
		    	$('#equipCd').val(data.equipCd);
	            $('#equipNm').val(data.equipNm);
                $('#equipPopUpModal').modal('hide');
                $('#btnSelGoodsCode').focus();
		    });
		} else{
			$('#equipCdPopUpTable').DataTable().ajax.reload();
		}

		$('#equipPopUpModal').modal('show');		
   	}
  	//설비코드조회 팝업 종료
  	
	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode()
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
		            { data: 'modelNo' }
		      
		        ],
		        columnDefs: [
		        	{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2],  "className": "text-center"}
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
                $('#goodsPopUpModal').modal('hide');
                $('#barcodeNo').focus();
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}

		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료
  	
	//담당자조회 팝업 시작
   	var userPopUpTable;
   	function selectPreWorkCharger() {
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
		            	'menuAuth'		: 	menuAuth,
		            	'departmentCd'	:	factoryCode == "003" ? null : "005",
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'userNumber',
		        columns: [
			        { data : 'userNm'		}, 
					{ data : 'departmentNm'	}, 
					{ data : 'postNm'		}, 
					{ data : 'chargrDutyNm'	}, 
					{ data : 'teamNm' 		}, 
					{ data : 'workplaceNm'	},
		        ],
		        columnDefs: [
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],
		        oSearch: {"sSearch": userNm},
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
                $('#preWorkCharger').val(data.userNumber);
                $('#preWorkChargerNm').val(data.userNm);
                $('#userPopUpModal').modal('hide');
                $('#barcodeNo').select();
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		$('#userPopUpModal').modal('show');	
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

	//바코드관련 조회
  	var barcodePopUpTable;
	function selectBarcode(){
		if ( !$.trim($('#preWorkCharger').val()) ) {
             toastr.warning('담당자를 선택해 주세요.');
             $('#btnSelPreWorkCharger').focus();
             return false;
		}
		
        inWhsDate='';
  	  	 
		if(barcodePopUpTable == null || barcodePopUpTable == undefined)	{
			barcodePopUpTable = $('#barcodePopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : true,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		     	/*select: {
		            style: 'multi',
		            toggleable: true,
		            items: 'row'
		        },*/
		        ajax: {
		            url: '<c:url value="/io/matrlInOutWhsPreDataList"/>',
		            type: 'GET',
		            data: {
			           	'menuAuth'	 	: 		menuAuth,
			           	'inWhsDate'		: 		function() { return inWhsDate.replace(/-/g, ''); },
			           	'approvalCd'	: 		function() { return "001";	},
			           	'statusCd'		: 		function() { return "A";	}
		            },
		        },
		        rowId: 'userNumber',
		        columns: [
		        	{
		                data: 'preInWhsDate',
		                render: function(data, type, row) {
		                	if(data != "" && data != null) {
								return moment(data).format("YYYY-MM-DD");
							} else {
								return "-";
							}
		                }
		            },	//가입고일
		        	{ data: 'statusNm'			},	//자재상태
		        	{ data: 'matrlCd' 			},	//자재코드
		        	{ data: 'matrlNm' 			},	//자재명
		        	{ data: 'barcodeNo' 		},	//바코드
		        	{ data: 'spplyDealCorpNm'	},	//공급업체
		        	{ data: 'inWhsDate',
		                render: function(data, type, row) {
		                	if(data != "" && data != null) {
								return moment(data).format("YYYY-MM-DD");
							} else {
								return "-";
							}
		                }
		            }	//입고일
		        	
		        ],
		        columnDefs: [
		        	{ "targets": ['_all'],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });

			var data ='';
		    $('#barcodePopUpTable tbody').on('click', 'tr', function () {
		    	$('#barcodePopUpTable tbody tr').attr('style','');
				$(this).attr('style', "background-color: #0275d8; color: white;");
				data = barcodePopUpTable.row(this).data();
		    	/*var data = barcodePopUpTable.row( this ).data();
                $('#barcodeNo').val(data.barcodeNo);
                $('#barcodePopUpModal').modal('hide');
            	$("#barcodeNo").focus();
            	keypress("barcodeNo", "13");*/
		    });

		    //팝업 출하버튼 클릭 시
		    $(document).on('click','#btnBarcodeAdd',function(e){
		    	if($('#barcodePopUpTable tbody tr').attr('style') == null) {
					toastr.warning("출하할 항목을 선택해주세요.");
					return false;
				}
				
                $('#barcodeNo').val(data.barcodeNo);
                $('#barcodePopUpModal').modal('hide');
            	$("#barcodeNo").focus();
            	keypress("barcodeNo", "13");
		    });
		    
		} else{
			$('#barcodePopUpTable').DataTable().ajax.reload();
		}
		var rtn = '<div class="row">';
			rtn += '<label class="input-label-sm mr-0">입고일</label><input type="date" class="form-control ml-2 mr-2" style="width: 130px;" id="barcodePopUpDate">';
			rtn += '<button type="button" class="btn btn-primary" id="barcodePopUpRetv">조회 </button>';
// 			rtn += '<button type="button" class="btn btn-primary ml-1" id="barcodeAllPopUpRetv">전체 조회 </button>';				
			rtn += '<input type="checkBox" style="zoom:1.6; margin-top:2px; margin-left:15px; margin-right:3px;" id="barcodeAllPopUpRetv" checked><label class="input-label-sm">전체 조회</label>';
			rtn += '</div>';
	  	$('#barcodePopUpTable_length').html(rtn);
// 	  	$('#barcodePopUpDate').val(inWhsDate);
	  	$('#barcodePopUpModal').modal('show');
   	}

   	//조회
	$(document).on('click','#barcodePopUpRetv',function(e){
		if($('#barcodePopUpDate').val() == ""){
			toastr.warning("입고일을 입력해주십시오.");
			$('#barcodePopUpDate').focus();
			return false;
		}
		inWhsDate = $('#barcodePopUpDate').val();
   		$('#barcodePopUpTable').DataTable().ajax.reload();
   	});

   	//전체 조회
	$(document).on('click','#barcodeAllPopUpRetv',function(e){
		if ($(this).prop('checked')) {
			inWhsDate = '';
			$('#barcodePopUpDate').val('');
		} else {
			$('#barcodePopUpDate').val("${serverDate}");
			inWhsDate = $('#barcodePopUpDate').val();
		}
   		$('#barcodePopUpTable').DataTable().ajax.reload();
   	});
   	
   	
   	
   	
   	
   	
	//12시간 더한 시간 구하는 코드
   	function twelveTimeCalc(inWhsDate) {
		
   		if( inWhsDate == "" || inWhsDate == null ) {
			return false;
		}
   		
   		let date	= new Date()
   		let year	= date.getFullYear();
   		let month	= ('0' + (date.getMonth() + 1)).slice(-2);
   		let day		= ('0' + date.getDate()).slice(-2);
   		let hours	= ('0' + date.getHours()).slice(-2);
   		let minutes	= ('0' + date.getMinutes()).slice(-2);
   		let nowDate = year + '-' + month + '-' + day + 'T' + hours  + ':' + minutes;

   		// Date 객체를 생성하여 주어진 시간 문자열을 파싱
   		let dateTime = new Date(inWhsDate);

   		// 시간을 12시간 더함
   		dateTime.setHours(dateTime.getHours() + 12);

   		// 시간과 분을 문자열로 변환하여 2자리로 맞춤
   		let newHour = dateTime.getHours().toString().padStart(2, '0');
   		let newMinute = dateTime.getMinutes().toString().padStart(2, '0');

   		// 날짜를 문자열로 변환하여 2자리로 맞춤
   		let newMonth = (dateTime.getMonth() + 1).toString().padStart(2, '0');
   		let newDay = dateTime.getDate().toString().padStart(2, '0');

   		// 최종 결과 문자열 생성
   		let resultTimeStr = dateTime.getFullYear() + '-' + newMonth + '-' + newDay + 'T' + newHour + ':' + newMinute;
   		
   		
   		//시간 판별
   		let a = nowDate;
		let b = resultTimeStr;
		let minDiff = moment.duration(moment(a).diff(moment(b))).asMinutes();
		
		if (minDiff < 0) {
			toastr.warning(timeChange(Math.abs(minDiff)) +' 후 사용을 권고합니다.');
		}
   	}
   	
   	//분 -> 시간/일자로 변환
	function timeChange(min) {
   	    let days = Math.floor(min / 60 / 24);
   	    let hours = Math.floor((min - (days * 60 * 24 )) / 60);
   	    let mins = min - (days * 60 * 24) - (hours * 60);
   	 
   	    let daysStr = days;
   	    let hourStr = (hours > 9)? hours : '0' + hours;
		let minStr = (mins > 9)? mins : '0' + mins;
   	    
   		if( daysStr > 0 ) {
   			return daysStr + ' 일 ' + hourStr + '시간 ' + minStr + '분';
   		} else if( hourStr > 0 ) {
   			return hourStr + '시간 ' + minStr + '분';
   		} else {
   			return minStr + '분';
   		}
   	}
	
</script>

</body>
</html>
