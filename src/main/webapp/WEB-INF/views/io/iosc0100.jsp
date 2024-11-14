<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!-- 재고관리정보 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="preGoodsInventoryPopUpModal" tabindex="-1" role="dialog" aria-labelledby="preGoodsInventoryPopUpModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="preGoodsInventoryPopUpLabel">재고정보조회</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table id="preGoodsInventoryPopUpTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">구분</th>
								<th class="text-center">제품명</th>
								<th class="text-center">모델NO</th>
								<th class="text-center">재질</th>
								<th class="text-center">규격</th>
								<th class="text-center">BOX</th>
								<th class="text-center">EA</th>
							</tr>
						</thead>
					</table>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 재고관리정보 모달 종료-->
	<!-- 재고관리정보 상세보기 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="preGoodsOutputDtlPopUpModal" tabindex="-1" role="dialog" aria-labelledby="preGoodsOutputDtlPopUpModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="preGoodsOutputDtlPopUpLabel">바코드출고상세조회</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<table id="preGoodsOutputDtlPopUpTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th class="text-center">구분</th>
								<th class="text-center">전표일자</th>
								<th class="text-center">제품명</th>
								<th class="text-center">재질</th>
								<th class="text-center">자사모델NO</th>
								<th class="text-center">고객사모델NO</th>
								<th class="text-center">포장수량</th>
							</tr>
						</thead>
					</table>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 재고관리정보 상세보기 모달 종료-->	
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">입출고관리</a></li>
				<li class="breadcrumb-item active">바코드출고관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width:65%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="preGoodsOutputHistTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px" class="text-center">순번</th>
									<th style="min-width: 70px" class="text-center">구분</th>
									<th style="min-width: 70px" class="text-center">전표일자</th>
									<th style="min-width: 100px" class="text-center">제품명</th>
									<th style="min-width: 120px" class="text-center">자사모델NO</th>
									<th style="min-width: 120px" class="text-center">고객사모델NO</th>
									<th style="min-width: 80px;"  class="text-center">BOX</th>
									<th style="min-width: 80px;"  class="text-center">EA</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="" id="total1" style="text-align: right">합계</td>
									<td colspan="5" id="total2" style="text-align: right"></td>
									<td colspan="" id="total7" style="text-align: right"></td>
									<td colspan="" id="total8" style="text-align: right"></td>
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div><!-- /.left-list -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width:34%;">
				<div class="card mb-2" id="formBox">
				<div class="card-body col-sm-12">
					<div class="rightsidebar-close">
						<a href="javascript:void(0)" id="left-expand" class="closebtn float-right" onclick="closerNav()"><i class="mdi mdi-close"></i></a>
					</div>
					<button type="button" class="btn btn-primary float-right mr-1" id="btnEmpty">바코드초기화</button>
				</div>		
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
					     			<th>*재고제품명</th>
					        		<td>
						       			<div class="input-sub m-0">
						        		<input type="text" class="form-control" id="goodsNm"  name="goodsNm">
						        		<button type="button" class="btn btn-primary input-sub-search" id="btnSelGoodsInventory" onClick="selectGoodsInventory()">
										<span class="oi oi-magnifying-glass"></span>
							        	</button>
						        	</td>
						        	<th>구분</th>
						        	<td><input type="text" class="form-control" id="orderGubunNm"  name="orderGubunNm"></td>	                            
					    		</tr>
							    <input type="hidden" class="form-control" id="invntryNo"  name="invntryNo">
							    <input type="hidden" class="form-control" id="goodsCd"  name="goodsCd">
							    <input type="hidden" class="form-control" id="orderGubunCd"  name="orderGubunCd">
							    <input type="hidden" class="form-control" id="model"  name="model">
							    <input type="hidden" class="form-control" id="customerModelNo"  name="customerModelNo">
							    <input type="hidden" class="form-control" id="qutyCd"  name="qutyCd">
							    <input type="hidden" class="form-control" id="dealCorpCd"  name="dealCorpCd">	                        
							    <tr>
							        <th>재고BOX</th>
							        <td><input type="text" class="form-control" id="invntryBoxCnt"  name="invntryBoxCnt"></td>
							        <th>포장수량</th>
							        <td><input type="text" class="form-control" id="packCnt"  name="packCnt"></td>
							    </tr>
							    <tr>                  
							        <th>*출고일자</th>
							        <td><!-- <input type="date" class="form-control" id="outputDate" name="outputDate"> -->
							        	<div class="form-group input-sub m-0">
											<input class="form-control" type="text" id="outputDate" name="outputDate" maxlength="10"/>
											<button onclick="fnPopUpCalendar(outputDate,outputDate,'yyyy-mm-dd')" class="btn btn-secondary input-sub-search" id="outputDateCalendar" type="button">
												<span class="oi oi-calendar"></span>
											</button>
										</div>
									</td>
									<th>*모델NO</th>
							        <td><input type="text" class="form-control" id="modelNo"  name="modelNo"></td>
							    </tr>
							    <tr>
							     	<th>*자사모델NO</th>
							        <td><input type="text" class="form-control" id="barcodeModelNo" name="barcodeModelNo" maxlength="30"></td>	                        
							        <th>*고객사모델NO</th>
							        <td ><input type="text" class="form-control" id="barcodeCustomerModelNo" name="barcodeCustomerModelNo" maxlength="30"></td>
							    </tr>	                        	                        	                        
					   		</table>
							<br/>
							<table id="barcodeOutputWhsTable" class="table table-bordered">
					        	<thead class="thead-light">
					        		<tr>
								        <th style="min-width: 50px"> 순번 </th>	                        
								        <th style="min-width: 120px"> 자사모델NO </th>
								        <th style="min-width: 120px"> 고객사모델NO </th>
								        <th style="min-width: 70px"> 구분 </th>
					        		</tr>
					        	</thead>
					    	</table>
					  	</div>                	                    
					</form>
					</div>
					<div class="mt-2">
						<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
						<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled=""><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
					</div>	
				<!--// 등록, 수정 -->
				</div><!-- .right-sidebar -->
			</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "65%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
		state = !state;
	});

	let menuAuth = 'iosc0100';
	let currentHref = 'iosc0100';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","바코드촐고관리");
    
  	//공통코드 처리 시작
    var orderGubunCode=new Array();
    <c:forEach items="${orderGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		orderGubunCode.push(json);
    </c:forEach>
	//공통코드 처리 종료
                         
	let viewIdx;
	var serverDate =  "${serverDate}";
	var outputHistDate =  serverDate;
	uiProc(true); 
		    
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let preGoodsOutputHistTable = $('#preGoodsOutputHistTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        lengthChange: true,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/tm/preGoodsOutputHistDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
	           	'outputHistDate': function() { return outputHistDate.replace(/-/g, ''); }
            },
            /*
            success : function(res) {
                console.log(res);
            }
            */
        },
        rowId: 'slipNo',
        columns: [
	    	{	
	    		render: function(data, type, row, meta) {		
	    			return meta.row + 1;;
    			},
	    	},
            { data: 'orderGubunNm' },
            { data: 'slipNo' },
            { data: 'goodsNm' },
            { data: 'modelNo' }, 
            { data: 'customerModelNo' },
            { data: 'outputBoxCnt', 'className' : 'text-right' },                       
            { data: 'outputAllCnt', 'className' : 'text-right'  }
        ],
        columnDefs: [
        	{ targets: [6,7] , render: $.fn.dataTable.render.number( ',' )},
        	{ targets: [0,1,2,3,4,5], className: 'text-center' },
        ],
        order: [
            [ 0, 'asc' ]
        ],
        drawCallback: function () {
            //alert("drawCallback");
            var sum = $('#preGoodsOutputHistTable').DataTable().column(6,{ page: 'current'} ).data().sum();
            $('#total7').html(sum.toLocaleString());
            sum = $('#preGoodsOutputHistTable').DataTable().column(7,{ page: 'current'} ).data().sum();
            $('#total8').html(sum.toLocaleString());
        },
//         drawCallback:function(){
//             var api = this.api();  
//             $( api.table().footer() ).html(api.column( [7], {page:'current'} ).data().sum());
//         },
        buttons: [
            {
                extend: 'copy',
                title: '바코드출고관리',
            },
            {
                extend: 'excel',
                title: '바코드출고관리',
            },
            {
                extend: 'print',
                title: '바코드출고관리',
            }
        ],

    });

    //var sysdate = "${serverTime}";
    //var html1 =  '출고일 &nbsp;<input type="date" style="" class="" id="outputHistDate" value="" placeholder="yyyy-MM-dd">';

	var html1 = '<div class="row">';
	html1 += '&nbsp;<label class="input-label-sm">출고일</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDate" name="calender" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDate,chooseDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>&nbsp; &nbsp; &nbsp; &nbsp; '
	html1 += '&nbsp; <button type="button"  class="btn btn-primary" id="btnDtlRetv">상세보기</button>'		
	html1 += '</div>';
	$('#workOrderTable_length').html(html1);

	$('#preGoodsOutputHistTable_length').html(html1);
	$('#chooseDate').val(serverDate);
	$('#outputDate').val(serverDate);

    // 보기
    $('#preGoodsOutputHistTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#preGoodsOutputHistTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
        slipNo = preGoodsOutputHistTable.row( this ).data().slipNo;
    });
    	
    $('#btnRetv').on('click', function() {
    	outputHistDate =  $('#chooseDate').val();
		$('#preGoodsOutputHistTable').DataTable().ajax.reload( function () {});
    });	

    $('#btnEmpty').on('click', function() {
        $('#barcodeOutputWhsTable').DataTable().clear().draw();
    	$("#barcodeModelNo").val("");
    	$("#barcodeCustomerModelNo").val("");           	
    	$("#barcodeModelNo").focus();
        $('#btnSave').addClass('d-none');
    });	   

    $("#barcodeModelNo").keypress(function (e) {
        if (e.which == 13){
        	console.log( $("#barcodeModelNo").val());
        	if($("#modelNo").val() == null || $("#modelNo").val() == "") {
            	$("#barcodeModelNo").val("");
            	$("#barcodeCustomerModelNo").val("");           	
            	$('#btnSelGoodsInventory').focus();

            	toastr.warning("출고할 재고 제품을 먼저 선택해 주세요.");
            } else if($("#modelNo").val() != $("#barcodeModelNo").val()) {
            	$("#barcodeModelNo").val("");
            	$("#barcodeCustomerModelNo").val("");           	
            	$("#barcodeModelNo").focus();
            	toastr.error("제품 모델NO와 바코드 모델NO가 맞지 않습니다.<br/> 다시 바코드 정보를 확인해 주세요", '', {timeOut: 5000});
            } else {
            	$("#barcodeCustomerModelNo").focus();
            }
        }
    });

    $("#barcodeCustomerModelNo").keypress(function (e) {
        if (e.which == 13){
        	console.log( $("#barcodeCustomerModelNo").val());
        	if( ($("#barcodeModelNo").val().length < $("#barcodeCustomerModelNo").val().length)
				&& ($("#barcodeModelNo").val() == $("#barcodeCustomerModelNo").val().substring(0,$("#modelNo").val().length))) {
               	var cval = compareBarcodeNo($("#barcodeCustomerModelNo").val());
                if(cval == false) {
	            	$("#barcodeModelNo").val("");
	            	$("#barcodeCustomerModelNo").val("");         		
	        		$("#barcodeModelNo").focus();
	        		toastr.error('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
            	} else {	
	        		$("#customerModelNo").val($("#barcodeCustomerModelNo").val());
	        		$('#barcodeOutputWhsTable').DataTable().row.add({}).draw(false);
	            	$("#barcodeModelNo").val("");
	            	$("#barcodeCustomerModelNo").val("");         		
	        		$("#barcodeModelNo").focus();
            	}
            } else {
            	$("#barcodeModelNo").val("");
            	$("#barcodeCustomerModelNo").val("");           	
            	$("#barcodeModelNo").focus();
            	toastr.error("자사모델NO와 고객사모델NO 가 맞지 않습니다.<br/> 다시 바코드 정보를 확인해 주세요", '', {timeOut: 5000});
            }
        }
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
//             success : function(res) {
//                 console.log(res);
//                 rightSide = false;
//             }
        },
        rowId: '',
        columns: [
	    	{	
	    		render: function(data, type, row, meta) {
	    			var rowNo = meta.row + 1;
	    			if(rowNo == 1) {
	    				$('#btnSave').removeClass('d-none'); 
			    	}		
					return meta.row + 1;
    			}
	    	},
        	{ 
	        	data: 'inputModelNo', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
						return  $("#barcodeModelNo").val();
	    			}
	    		}
    		},
            {
                data: 'inputCustomerModelNo', 
   	    		render: function(data, type, row, meta) {	
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   						return  $("#barcodeCustomerModelNo").val();
   	    			}
   	    		}                

            },
            { 
                data: 'compareYn', 
   	    		render: function(data, type, row, meta) {	
   	    			if(data != null) {
   	    				return data;
   	    			} else {
   						return  "OK";
   	    			}
   	    		}                

            }
        ],
        columnDefs: [
        	{"className": "text-center", "targets": "_all"}
        ],
        order: [
            [ 0, 'desc' ]
        ],
        buttons: [
        ],
    });
	
    // 보기
    $('#barcodeOutputWhsTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }
        else {
        	$('#barcodeOutputWhsTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    // 등록 처리
    $('#btnSave').on('click', function() {
        if ( !$.trim($('#goodsNm').val()) ) {
            toastr.warning('재고 제품명을 선택해 주세요.');
            $('#btnSelGoodsInventory').focus();
            return false;
        }
        if ( !$.trim($('#outputDate').val()) ) {
            toastr.warning('출고일자를 선택해 주세요.');
            $('#outputDateCalendar').focus();
            return false;
        }

        var outputBoxCnt = $('#barcodeOutputWhsTable').DataTable().data().count();
        
        createBarcodeNo(outputBoxCnt);
        
        $.ajax({
            url: '<c:url value="/tm/preGoodsOutputDtlCreate"/>',
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
                    // 보기
					$('#invntryBoxCnt').val(data.invntryBoxCnt);
                    $('#preGoodsOutputHistTable').DataTable().ajax.reload( function () {});
                    $('#barcodeOutputWhsTable').DataTable().clear().draw();
                	$("#barcodeModelNo").val("");
                	$("#barcodeCustomerModelNo").val("");           	
                	$("#barcodeModelNo").focus();
                    //uiProc(true);
                    $('#btnSave').addClass('d-none');
                    toastr.success('등록되었습니다.');

                } else if(res.result == 'over') {
                    toastr.warning('제품의 출고량이 재고량을 초과 하였습니다.<br/>재고량을 확인해 주세요');                
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                //$('#btnAddConfirm').removeClass('d-none');
                //$('#btnAddConfirmLoading').addClass('d-none');
            }
        });
       
//         var outputBoxCnt = $('#barcodeOutputWhsTable').DataTable().data().count();

//         $.ajax({
//             url: '<c:url value="/tm/preGoodsOutputHistCreate"/>',
//             type: 'POST',
//             data: {

//             	'invntryNo'   		:        $('#invntryNo').val(), 
//             	'goodsCd'   		:        $('#goodsCd').val(),                
//             	'orderGubunCd'   	:        $('#orderGubunCd').val(),
// 	            'model'      		:        $('#model').val(),
// 	            'modelNo'   		:        $('#modelNo').val(),
// 	            'customerModelNo' 	:        $('#customerModelNo').val(),
// 	            'outputBoxCnt'   	:        outputBoxCnt,
// 	            'packCnt'      		:        $('#packCnt').val(),
// 	            'dealCorpCd'    	:        $('#dealCorpCd').val(),
// 	            'qutyCd'      		:        $('#qutyCd').val(),
// 	            'dealCorpCd'  		:        $('#dealCorpCd').val(),
// 	            'outputHistDate'    :        $('#outputDate').val().replace(/-/g, ''),
// 	            'regId'				:		 'reg_id',
// 	            'updId'				:		 'upd_id'
//             },
//             beforeSend: function() {
//               //  $('#btnAddConfirm').addClass('d-none');
//               //  $('#btnAddConfirmLoading').removeClass('d-none');
//             },
//             success: function (res) {
//                 let data = res.data;
 
//                 if (res.result == 'ok') {
//                     // 보기
// 					$('#invntryBoxCnt').val(data.invntryBoxCnt);
//                     $('#preGoodsOutputHistTable').DataTable().ajax.reload( function () {});
//                     $('#barcodeOutputWhsTable').DataTable().clear().draw();
//                 	$("#barcodeModelNo").val("");
//                 	$("#barcodeCustomerModelNo").val("");           	
//                 	$("#barcodeModelNo").focus();
//                     //uiProc(true);
//                     $('#btnSave').addClass('d-none');
//                     toastr.success('등록되었습니다.');

//                 } else if(res.result == 'over') {
//                     //$('#btnSave').addClass('d-none');
//                     toastr.success('제품의 출고량이 재고량을 초과 하였습니다.<br/>재고량을 확인해 주세요');                
//                 } else {
//                     toastr.error(res.message, '', {timeOut: 5000});
//                 }
//             },
//             complete:function(){
//                 //$('#btnAddConfirm').removeClass('d-none');
//                 //$('#btnAddConfirmLoading').addClass('d-none');
//             }
//         });
    });

	var barcodeNoList;
	function createBarcodeNo(outputBoxCnt) {
		barcodeNoList = new Array();
		var idx = 0;

		$('#barcodeOutputWhsTable tbody tr').each(function(index){

			var slipSeq= $(this).find('td').eq(0).html();
			var modelNo= $(this).find('td').eq(1).html();
			var customerModelNo= $(this).find('td').eq(2).html();
			
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.invntryNo = $('#invntryNo').val();
			rowData.goodsCd = $('#goodsCd').val();
			rowData.orderGubunCd = $('#orderGubunCd').val();
			rowData.slipSeq = slipSeq;
			rowData.model = $('#model').val();
			rowData.modelNo = modelNo;
			rowData.customerModelNo = customerModelNo;
			rowData.outputBoxCnt = outputBoxCnt;
			rowData.packCnt = $('#packCnt').val();
			rowData.qutyCd = $('#qutyCd').val();
			rowData.dealCorpCd = $('#dealCorpCd').val();
			rowData.outputHistDate = $('#outputDate').val().replace(/-/g, '');
			rowData.outputDtlDate = $('#outputDate').val().replace(/-/g, '');
			rowData.regId = $('#regId').val();																				
			barcodeNoList.push(rowData);
			idx++;
		});
		//console.log(barcodeNoList);
		return idx;
	}
	    
   	function uiProc(flag)
   	{
        $("#goodsNm").attr("disabled",flag);                
        $("#orderGubunNm").attr("disabled",flag);                 
        $("#invntryBoxCnt").attr("disabled",flag);   
        $("#packCnt").attr("disabled",flag);
        $("#modelNo").attr("disabled",flag);          
   	}

	function compareBarcodeNo(barcodeNo) {
		var result = true;
		$('#barcodeOutputWhsTable tbody tr').each(function(){
		 	var tbarcodeNo= $(this).find('td').eq(2).html();
			if(barcodeNo == tbarcodeNo) {  // tr 첫라인은 헤더정보로 skip
				result = false;
				return result;
			}
		});

		return result;
	}
	  	       
   	//재고정보조회 팝업 시작
   	var preGoodsInventoryPopUpTable;
   	function selectGoodsInventory(qutyType)
   	{
   		preGoodsInventoryPopUpTable = null;
		if(preGoodsInventoryPopUpTable == null ||preGoodsInventoryPopUpTable == undefined)	{
			preGoodsInventoryPopUpTable = $('#preGoodsInventoryPopUpTable').DataTable({
		        language: lang_kor,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        lengthChange: false,
		        pageLength: 20,
		        destroy:true,
		        ajax: {
		            url: '<c:url value="/tm/preGoodsInventoryDataList"/>',
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
		        rowId: 'invntryNo',
		        columns: [
		            { data: 'orderGubunNm' },
		            { data: 'goodsNm' },
		            { data: 'modelNo' }, 
		            { data: 'qutyNm' },                      
		            { data: 'model' },
		            { data: 'invntryBoxCnt' },            
		            { data: 'invntryAllCnt' },
		        ],
		        columnDefs: [
	            	{ targets: [5,6] , render: $.fn.dataTable.render.number( ',' )},
	            	{ targets: [0,1,2,3,4], className: 'text-center' },
	            	{ targets: [5,6], className: 'text-right' },
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		    });

		    $('#preGoodsInventoryPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = preGoodsInventoryPopUpTable.row( this ).data();
 
		    	$('#invntryNo').val(data.invntryNo);
                $('#goodsCd').val(data.goodsCd);
                $('#goodsNm').val(data.goodsNm);
                $('#orderGubunCd').val(data.orderGubunCd);
                $('#orderGubunNm').val(data.orderGubunNm);                
                $('#model').val(data.model);
                $('#modelNo').val(data.modelNo);
                $('#customerModelNo').val(data.customerModelNo);
                //$('#dealCorpNm').val(data.dealCorpNm);
                $('#dealCorpCd').val(data.dealCorpCd);
                //$('#qutyNm').val(data.qutyNm);
                $('#qutyCd').val(data.qutyCd);
                $('#invntryBoxCnt').val(data.invntryBoxCnt);
                $('#packCnt').val(data.packCnt);
                $('#preGoodsInventoryPopUpModal').modal('hide');
                
            	$("#barcodeModelNo").val("");
            	$("#barcodeCustomerModelNo").val("");           	
            	$("#barcodeModelNo").focus();
            	$('#barcodeOutputWhsTable').DataTable().clear().draw();
		    });
		} else {
			$('#preGoodsInventoryPopUpTable').DataTable().ajax.reload( function () {});
		}
		
		$('#preGoodsInventoryPopUpModal').modal('show');		
   	}
  	//재고정보조회 팝업 종료

   	//출고상세보기 팝업 시작
   	var slipNo;
   	var preGoodsOutputDtlPopUpTable;

   	
    $('#btnDtlRetv').on('click', function() {
        if(slipNo == null || slipNo == "") {
        	toastr.warning("상세보기 목록을 먼저 선택해 주세요.");
            return false;
        }
		if(preGoodsOutputDtlPopUpTable == null ||preGoodsOutputDtlPopUpTable == undefined)	{
			preGoodsOutputDtlPopUpTable = $('#preGoodsOutputDtlPopUpTable').DataTable({
		        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
		        language: lang_kor,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        lengthChange: false,
		        pageLength: 20,
		        ajax: {
		            url: '<c:url value="/tm/preGoodsOutputDtlDataList"/>',
		            type: 'GET',
		            data: {
			            'menuAuth'	 	: 		menuAuth,
			            slipNo : function() { return slipNo; },
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'slipNo',
		        columns: [
		            { data: 'orderGubunNm' },
		            { data: 'slipNo' },
		            { data: 'goodsNm' }, 
		            { data: 'qutyNm' },                      
		            { data: 'modelNo' },
		            { data: 'customerModelNo' },            
		            { data: 'packCnt' },
		        ],
		        columnDefs: [
	            	{ targets: [6] , render: $.fn.dataTable.render.number( ',' )},
	            	{ targets: [6], className: 'text-right' },
	            	{ targets: [0,1,2,3,4,5], className: 'text-center' },
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		        buttons: [
		            {
		                extend: 'copy',
		                title: '바코드출고상세조회',
		            },
		            {
		                extend: 'excel',
		                title: '바코드출고상세조회',
		            },
		            {
		                extend: 'print',
		                title: '바코드출고상세조회',
		            },
		        ],		        
		    });

		} else {
			$('#preGoodsOutputDtlPopUpTable').DataTable().ajax.reload( function () {});
		}
		
		$('#preGoodsOutputDtlPopUpModal').modal('show');		
    });
  	//출고상세보기 팝업 종료
  	
  	//바코드 스캔을 위해 포커스 고정
   	$("#barcodeModelNo").val("");
   	$("#barcodeCustomerModelNo").val("");           	
   	$("#barcodeModelNo").focus();
   	
</script>

</body>
</html>
