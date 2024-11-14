<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">출하현황(사출)</li>
			</ol>
		</nav> 
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 63%;">
				<div class="card">
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="deliveryOrderAdmTable" class="table table-bordered main_table">
							<colgroup>
								<col width="15%">
								<col width="10%">
								<col width="15%">
								<col width="20%">
								<col width="25%">
								<col width="10%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>고객사</th>
									<th>출하일자</th>
									<th>차종</th>
									<th>품번</th>
									<th>품명</th>
									<th class="text-center">출하수량</th>
									 <th class="text-center">단가</th>
									<th class="text-center">금액</th> 
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!--======================== .right-list ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 36%;">
				<!--상단 버튼 part-->
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12 p-0">
						<button type="button" class="btn btn-danger float-left mr-1" id="btnCancel">출하취소</button>
					</div>
					<div class="table-responsive" class="main_table">
						<table id="deliveryOrderDtlTable" class="table table-bordered">
							<colgroup>
								<col width="5%">
								<col width="25%">
								<col width="20%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<thead class="thead-light">
								<tr>
									<th>
										<input type="checkbox" id="checkAll" name="checkAll" style="width:1.1rem;height:1.1rem;">
									</th>
									<th>LOTNO</th>
									<th class="text-center">출하수량</th>
									<th>출하일자</th>
									<th>출하요청번호</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<style>
</style>
<%@include file="../layout/bottom.jsp" %>
<script>

//#feffd5
	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "60%"
			}, 200);
			$("#arrow-left").animate({
				display : "none"
			}, 200);
		}
	});

	let currentHref = "bssc0070";
	let currentPage = $('.' + currentHref).attr('id');
	

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","출하현황(사출)"); 
	
	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDateTo}";
	var serverDate = "${serverDateTo}";
	let mainGubunVal='';
	let itemCusVal = '';
	let outDateVal = '';
	let itemSeqVal = '';
	let dataGubunVal = '';
	let groupTypeByD="N";	//소계
	let groupTypeByM="N";	//합계
	let groupTypeByT="N";	//반출

	let dealGubunList='001';
	
	var dealGubunCode = new Array();
	<c:forEach items="${dealGubunList}" var="info">
	var json = new Object();
	json.baseCd = "${info.baseCd}";
	json.baseNm = "${info.baseNm}";
	dealGubunCode.push(json);
	</c:forEach>

	let sumAmt = 0;
	let totalAmt = 0;

	//출고의뢰등록 목록조회
	let deliveryOrderAdmTable = $('#deliveryOrderAdmTable').DataTable({
	    dom: "<'row'<'col-sm-12 col-md-9'l><'col-sm-12 col-md-3'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",
		language : lang_kor,	
		paging : true,
		info : true,
		searching : true,
		ordering : false,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY: "70vh",
		ajax : {
			url : '<c:url value="bs/deliveryOrderAdmTotalList"/>',
			type : 'GET',
			data : {				
				'startDate'		: function(){ return serverDateFrom.replace(/-/g, ''); },
	           	'endDate'		: function(){ return serverDateTo.replace(/-/g, ''); },
	           	'itemCus'		: function(){ return itemCusVal; },
	           	'doStatus003'	: function(){ return 'Y'; },
	         	'groupTypeByD'	: function(){ return groupTypeByD; },
	         	'groupTypeByM'	: function(){ return groupTypeByM; },
	         	'groupTypeByT'	: function(){ return groupTypeByT; },
	         	'mainGubun' 	: '001'
			}	
		},	
		rowId : '',
		columns : [ 
			{data :'itemCusNm'},
			{data :'outDate',
				render : function(data, type, row, meta){
					return moment(data).format("YYYY-MM-DD");
				}
			},
			{data :'itemModelNm'},
			{data :'itemCd'},
			{data :'itemNm'},
			{
				data :'outQty',
				render : function(data, type, row, meta){
					return rmDecimal(Math.round(data));
				},'className':'text-right'
			},
			{
				data :'outUnitCost',
				render : function(data, type, row, meta){
					if(row['groupType']=="기본"){
						return rmDecimal(data!=null?data:"0");
					}else{
						return '-';
					}
				},'className':'text-right'
			},
			{
				data :'outAmt',
				render : function(data, type, row, meta){
					let qty=0;
					if(row['groupType']=="기본"){
						qty = rmDecimal(Math.round(data));
						sumAmt += parseFloat(data);
						totalAmt += parseFloat(data);
					}else if(row['groupType']=="소계"){
						qty = rmDecimal(Math.round(sumAmt));
						sumAmt=0;
					}else{
						qty = rmDecimal(Math.round(totalAmt));
						totalAmt=0;
					}
					return qty;
				},'className':'text-right'
			} 
		],
		columnDefs: [
			{ "visible": false, "targets": [6,7] }
        ],
		drawCallback: function() {
			let api = this.api();
			let data = api.data();
			for(var i = 0; i < data.length; i++) {

				///합계 행
				if(deliveryOrderAdmTable.row(i).data().groupType=="합계"){
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(1).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(2).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(3).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(4).addClass('d-none');
					
					$('#deliveryOrderAdmTable tbody tr').eq(i).css('background','#a9c9f0').css('font-weight','bold').css('text-align','left');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(0).text('전체 합계')
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(0).attr('colspan','5')

				}
				
				//소계 행
				if(deliveryOrderAdmTable.row(i).data().groupType=="소계"){
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(1).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(2).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(3).addClass('d-none');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(4).addClass('d-none');
					
					$('#deliveryOrderAdmTable tbody tr').eq(i).css('background','#d9ffe4').css('font-weight','bold');
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(0).text(''+deliveryOrderAdmTable.row(i-1).data().itemNm+'  합계')
					$('#deliveryOrderAdmTable tbody tr').eq(i).find('td').eq(0).attr('colspan','5') 
				}    
			}
		},
	    buttons: [
	    	'copy', {
                extend: 'excel',
                title: '출하현황(사출)',
                className : 'btn-secondary',
            	init : function ( api, node, config ) {
					$(node).addClass('btn-secondary');
					$(node).text('Excel');
				},
                customize : function (xlsx) {
			 		let sheet = xlsx.xl.worksheets['sheet1.xml'];
			 		let col = $('col', sheet);
			 		
			 		col.each(function () {
			 	          $(this).attr('width', 20);
			 	    });

			 		let table = $('#deliveryOrderAdmTable').DataTable();
			 		let data = table.rows().data();
			 		let row,message,bgColor='';
			 		
			 	    for(var i=0; i<data.count(); i++){
			 	    	//소계
						if(table.row(i).data().groupType=="소계"){
							row=i+3;
							message = table.row(i-1).data().itemNm+' 합계';
							bgColor = '15';
							
							var mergeCells = $('mergeCells', sheet);
							mergeCells[0].appendChild( _createNode( sheet, 'mergeCell', {
		                      	attr: {
		                       		ref: ['A'+row+':E'+row]
		                       	}
		                    })); 

							 console.log("start row:+"+row)
							$('c[r=H'+(row)+'] t', sheet).text("전체금액");
							 console.log("end row:+"+row)
		                //합계    
						}else if(table.row(i).data().groupType=="합계"){
							row=i+3;
							message = '전체 합계';
							bgColor = '20';
							
							var mergeCells1 = $('mergeCells', sheet);
							mergeCells1[0].appendChild( _createNode( sheet, 'mergeCell', {
		                      	attr: {
		                       		ref: ['A'+row+':E'+row]
		                       	}
		                    })); 
						}
						$('c[r=A'+(row)+'] t', sheet).text(message);
		                $('row:eq('+(row-1)+') c', sheet).attr('s',''+bgColor+'');
					}   

				}
            }, 'print'                                
	    	
	    ],
	});

    var html1 = '<div class="row">';
    html1 += '&nbsp;&nbsp;<label class="input-label-sm">출하일자</label><div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="outDateFrom" name="outDateFrom" disabled/>';
    html1 += '<button onclick="fnPopUpCalendar(outDateFrom,outDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="outDateFromFromCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>';
    html1 += '&nbsp;&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="text" id="outDateTo" name="outDateTo" disabled />';
    html1 += '<button onclick="fnPopUpCalendar(outDateTo,outDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="outDateToToCalendar" type="button">';
    html1 += '<span class="oi oi-calendar"></span>';
    html1 += '</button>'; 
    html1 += '</div>&nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">고객사</label><div class="form-group input-sub m-0 row">';  
    html1 += '<input type="text" class="form-control" id="itemCusNm" name="itemCusNm" style="width:130px" disabled>';
    html1 += '<input type="hidden" class="form-control" id="itemCus" name="itemCus" disabled>';
    
  	html1 += '<button type="button" id="btnItemCus" class="btn btn-primary input-sub-search" onClick="itemCusSelectInCorpCd()">';
  	html1 += '<span class="oi oi-magnifying-glass"></span>';
  	html1 += '</button></div>';
  	html1 += '<button type="button" id="itemCusDelete" class="btn closeBtn" onclick="itemCusDelete();">';
    html1 += '<i class="mdi mdi-close"></i>';
    html1 += '</button>';
  	html1 += '<div class="form-check form-check-inline">';
	html1 += '  <input class="form-check-input" type="checkbox" id="groupingOption1">';
	html1 += '  <label class="form-check-label" for="groupingOption1">소계</label>';
	html1 += '</div>';
	html1 += '<div class="form-check form-check-inline">';
	html1 += '  <input class="form-check-input" type="checkbox" id="groupingOption2">';
	html1 += '  <label class="form-check-label" for="groupingOption2">합계</label>';
	html1 += '</div>';
	html1 += '<div class="form-check form-check-inline">';
	html1 += '  <input class="form-check-input" type="checkbox" id="groupingOption3">';
	html1 += '  <label class="form-check-label" for="groupingOption3">반출</label>';
	html1 += '</div>';
  	
    html1 += '<button type="button"  class="btn btn-primary" id="btnRetv">조회</button>';
    html1 += '</div>';
    
	$('#deliveryOrderAdmTable_length').html(html1);
	$('#outDateFrom').val(serverDateFrom);
	$('#outDateTo').val(serverDateTo);

	function itemCusDelete(){
		$('#itemCusNm').val('');
		$('#itemCus').val('');
		itemCusVal = '';
	}

	//조회버튼 클릭시
	$('#btnRetv').on('click', function() {
		serverDateFrom =  $('#outDateFrom').val();
		serverDateTo =  $('#outDateTo').val();
		itemCusVal =  $('#itemCus').val();

		//소계/합계 옵션
		if($('#groupingOption1').is(':checked')){
			groupTypeByD="Y"
        }else{
        	groupTypeByD="N"
        }

		if($('#groupingOption2').is(':checked')){
			groupTypeByM="Y"
        }else{
        	groupTypeByM="N"
        }

		if ( $('#groupingOption3').is(':checked') ) {
			groupTypeByT = "Y"
        } else {
        	groupTypeByT = "N"
        }

		deliveryOrderAdmTable.order( [] ).draw();
		$('#deliveryOrderAdmTable').DataTable().ajax.reload( function () {});

    });	
	
	$('#deliveryOrderAdmTable tbody').on('click','tr',function(){
		if ($(this).hasClass('selected')) {
// 			$(this).removeClass('selected');
		} else {
			$('#deliveryOrderAdmTable').DataTable().$('.selected').removeClass('selected');
			$(this).addClass('selected');
		}

		outDateVal = deliveryOrderAdmTable.row(this).data().outDate;
		itemSeqVal = deliveryOrderAdmTable.row(this).data().itemSeq;
		itemCusVal = deliveryOrderAdmTable.row(this).data().itemCus;
		dataGubunVal = deliveryOrderAdmTable.row(this).data().dataGubun == 'D' ? '!=' : '='; //부등호
		
		if ( Number(deliveryOrderAdmTable.row(this).data().outQty) >= 0 ) { //TB_DELIVERY_ORDER_DTL 에서 가져온 것이면
			$('#btnCancel').css("visibility", "visible");
		} else { //TB_TAKEOFF_ADM 에서 가져온 것이면
			$('#btnCancel').css("visibility", "hidden");
		}

		$('#deliveryOrderDtlTable').DataTable().ajax.reload(function(){});
	});


	//출고의뢰등록 상세조회
	let deliveryOrderDtlTable = $('#deliveryOrderDtlTable').DataTable({
	    dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,	
		destroy : true,	
		paging : true,
		searching : false,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		lengthChange : false,
		scrollY: "70.5vh",
		pageLength : -1,
		ajax : {
			url : '<c:url value="bs/deliveryOrderAdmDetailList"/>',
			type : 'GET',
			data : {				
	            'mainGubun'	: function(){ return "001" },
	            'outDate'	: function(){ return outDateVal; },
	            'itemSeq'	: function(){ return itemSeqVal; },
	            'itemCus'	: function(){ return itemCusVal; },
	            'dataGubun'	: function(){ return dataGubunVal; },
			}	
		},	
		rowId : '',
		columns : [ 
			{ //체크박스
				render : function(data, type, row, meta){
					return '<input type="checkbox" name="check" style="width:1.1rem;height:1.1rem;" data-doNo='+row['doNo']+' data-doSeq='+row['doSeq']+' data-doNoSub='+row['doNoSev']+' data-lotNo='+row['lotNo']+' data-outQty='+row['outQty']+' data-itemSeq='+row['itemSeq']+' />';
				}, "className" : "text-center"
			},
			{ data :'lotNo', "className" : "text-center" }, //LOTNO
			{ //출하수량
				data :'outQty', 'className':'text-right',
				render : function(data, type, row, meta){
					return data != null ? rmDecimal(data) : '';
				}
			},
			{ //출하일자
				data :'outDate', "className" : "text-center",
				render : function(data, type, row, meta){
					return data != null && data != '' ? moment(data).format('YYYY-MM-DD') : '';
				}
			},
			{ data :'doNo', "className" : "text-center" }, //출하요청번호
		],
		columnDefs : [],
	    order: [],
	    buttons: [],
	});

	//전체 선택 클릭시
	$('#checkAll').on('click',function(){
		if($('#checkAll').is(':checked')){
			$('input[name=check]').prop('checked',true);
		}else{
			$('input[name=check]').prop('checked',false);
		}
	});

	//출하취소버튼 클릭시
	$('#btnCancel').on('click',function(){
		if(deliveryOrderDtlTable.data().count()<0){
			toastr.warning("출하취소할 데이터가 없습니다.");
			return false;
		}

		if(!$('input[name=check]').is(':checked')){
			toastr.warning("출하취소할 항목을 선택해주세요.");
			return false;
		}
		
		$('#deleteSmallModal').modal('show');
	});

	//출하취소버튼 클릭시
	$('#btnDeleteY').on('click',function(){
		var dataArray = new Array();
		
		$('input[name=check]:checked').each(function(index,item){			
			
			var rowData = new Object();
			rowData.doNo = $(this).attr('data-doNo');
			rowData.doSeq = $(this).attr('data-doSeq');
			rowData.doNoSub = $(this).attr('data-doNoSub');
			rowData.lotNo = $(this).attr('data-lotNo');
			rowData.outQty = $(this).attr('data-outQty');
			rowData.itemSeq = $(this).attr('data-itemSeq');
	        dataArray.push(rowData);
	        console.log(rowData);
			
		});
		
		$.ajax({
			url : '<c:url value="bs/deliveryOrderAdmDetailDelete"/>',
			type : 'POST',
			datatype: 'json',
			data: JSON.stringify(dataArray),
			contentType : "application/json; charset=UTF-8",
			beforeSend : function(){
				$('#my-spinner').show();
			},
			success : function(res) {
				if (res.result == 'ok') {
					toastr.success("출하취소 되었습니다.");
					$('#deliveryOrderAdmTable').DataTable().ajax.reload(function(){});
					$('#deliveryOrderDtlTable').DataTable().ajax.reload(function(){});
					$('input[name=checkAll]').prop("checked",false);
				}else{
					toastr.error(res.message);
				}

				$('#my-spinner').hide();
				$('#deleteSmallModal').modal('hide');
			}
		});		
	});

	//공급사 팝업 시작
	let dealCorpPopUpTable4;
	function itemCusSelectInCorpCd() {
		if (dealCorpPopUpTable4 != null && dealCorpPopUpTable4 != 'undefined') {
			dealCorpPopUpTable4.destroy();
		}
		dealCorpPopUpTable4 = $('#dealCorpPopUpTable4').DataTable({	
			dom : "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>"
					+ "<'row'<'col-sm-12'tr>>"
					+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
			language : lang_kor,
			paging : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			scrollX : false,
			lengthChange : true,
			async : false,
			pageLength : 15,
			ajax : {
				url : '<c:url value="/bm/dealCorpDataList"/>',
				type : 'GET',
				data : {
					'dealGubun' :  function(){return dealGubunList;},
				},
			},
			rowId : 'dealCorpSeq',
			columns : [
				{ data : 'dealCorpNm' },
				{ data : 'dealCorpCd' },
				{ data : 'presidentNm' },
				{ data : 'repreItem' },
				{ data : 'corpNo' },
			],
			columnDefs : [ {
				"defaultContent" : "-",
				"targets" : "_all",
				"className" : "text-center"
			} ],
			order : [ [ 0, 'asc' ] ],
			buttons : [],
		});

		let html2 = '<div class="row">';
		html2 += '<label class="input-label-sm">거래구분</label>';
		html2 += '<div class="form-group input-sub m-0">';
		html2 += '<select class="custom-select" id="dealGubunOption" onChange="dealOnchange()">';
		html2 += '</select></div>&nbsp;&nbsp;&nbsp;';
		html2 += '</div>';

		$('#dealCorpPopUpTable4_length').html(html2);
		selectBoxAppend(dealGubunCode, "dealGubunOption", '001', "1");
		
		$('#dealCorpPopUpTable4 tbody').on('click', 'tr', function() {
			var data = dealCorpPopUpTable4.row(this).data();
			$('#itemCus').val(data.dealCorpCd);
			$('#itemCusNm').val(data.dealCorpNm);
			itemCusVal =  data.dealCorpCd;
			$('#dealCorpPopUpModal4').modal('hide');
			$('#deliveryOrderAdmTable').DataTable().ajax.reload( function () {});
		});
		
		$('#dealCorpPopUpModal4').modal('show');
	}

	function dealOnchange(){
		dealGubunList = $("#dealGubunOption option:selected").val();
		$('#dealCorpPopUpTable4').DataTable().ajax.reload(function(){});
	}

</script>

</body>
</html>
