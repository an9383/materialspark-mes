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
		<a href="/pdsc0070" class="float-left"><img class="p-2" src="/resources/assets/images/mo_home_wh.png"></a> <a href="/pdsc3100"><p class="mo_main_title">자재 상태 변경</p></a>
	</header>
	<!--====-sortbox-->
	<div class="mo_sortbox">
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
	<!--==버튼영역-->
			
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
			</div>
		</div>
	</main>
	<!--==end==-sortbox-->
	
	<footer class="p-2" style="margin-top: auto;">
		<div class="mo_sumbox">
			<button type="button" class="btn btn-warning float-left" id="btnKeyboard">자판 Off</button>
			<div class="row float-right">
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
	$(document).attr("title","자재 상태 변경");
	let menuAuth = 'pdsc3100';
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
	var goodsFifoCheckBarcodeNo='';
    
    let sudelCheck = false;
    let barcodeNoList;
	
	$('#barcodeNo').focus();

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

	//바코드 스캔시
	$("#barcodeNo").keypress(function (e) {
		
		if (sudelCheck) {
			return false;
		}
		
	    if (e.which == 13){
	    	
	    	sudelCheck = true;
	    	//키보드입력 말고 바코드로 스캔시 풀어주기
	    	if ( !$.trim($('#barcodeNo').val()) ) {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#barcodeNo').focus();
	            sudelCheck = false;
	            return false;
	        }
	        
	    	var cval = compareBarcodeNo($('#barcodeNo').val().trim());
	        if(cval == false) {
	        	toastr.warning('중복된 바코드 입니다.', '', {timeOut: 600});
	        	$('#barcodeNo').val('');
	        	$('#barcodeNo').select();
	        	sudelCheck = false;
	            return false;              
	        }
	        
			$.ajax({
	 			url: '<c:url value="/io/matrlStatusChangeRead"/>',
				type: 'GET',
				async: false,
				data: {
					'menuAuth'	 		: 		menuAuth,
					'barcodeNo'   		:       $('#barcodeNo').val().trim(),
					'exceptBarcodeNo'	:		function() { return exceptBarcodeNo; }
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
						$('#btnLineClear').attr('disabled', false);
						$('#btnAllClear').attr('disabled', false);
						$('#barcodeNo').val("");
						$('#barcodeNo').focus();
						count += 1;
						$('#count').text(count);
						exceptBarcodeNo += "/" + data.barcodeNo;	//스캔한 바코드 값 담아주기.
						toastr.success('추가되었습니다.', '', {timeOut: 500});
						sudelCheck = false;
					} else if (res.result == 'fail') {
                    	toastr.warning(res.message, '', {timeOut: 5000});
                    	sudelCheck = false;
                    } else {
                    	toastr.error(res.message, '', {timeOut: 5000});
						sudelCheck = false;
					}
				},
				complete:function(){
					$('#barcodeNo').val('');
           	     	$('#barcodeNo').focus();
				}
			});
	    }
	});


	// 저장 처리
    $('#btnSave').on('click', function() {

    	$('#my-spinner').show();
    	
        createBarcodeNo();
        
        $.ajax({
            url: '<c:url value="/pd/matrlStatusChange"/>',
            type: 'POST',
            data: JSON.stringify(barcodeNoList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
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

	function createBarcodeNo() {
		barcodeNoList = new Array();
		var idx = 0;
		$('#barcodeOutputWhsTable tbody tr').each(function(){
		 	var barcodeNo	= $(this).find('td').eq(1).html();
		 	var preOutQtyTo	= $(this).find('td').eq(5).html();
		 	var rowData	 	= new Object();
		 	
		 	rowData.menuAuth 		= menuAuth;
			rowData.barcodeNo	 	= barcodeNo;
			rowData.preOutWhsDate 	= inWhsDate;
			rowData.preOutQty 		= preOutQtyTo;
			
			barcodeNoList.push(rowData);
		});
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
		$('#barcodeNo').val('');
		count = 0;
		$('#count').text(count);
		exceptBarcodeNo='empty';
	});

	//저장 완료 후 새로등록
	$('#btnNew').on('click', function() {
		$('#btnCalendar').attr('disabled', false);
		$('#barcodeNo').attr('disabled', false);
		$('#barcodeOutputWhsTable').DataTable().clear().draw();
		$('#barcodeNo').val('');
		$('#btnCalendar').focus();
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
			rtn += '<input type="checkBox" style="zoom:1.6; margin-top:2px; margin-left:15px; margin-right:3px;" id="barcodeAllPopUpRetv" checked><label class="input-label-sm">전체 조회</label>';
			rtn += '</div>';
	  	$('#barcodePopUpTable_length').html(rtn);
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
	
</script>

</body>
</html>
