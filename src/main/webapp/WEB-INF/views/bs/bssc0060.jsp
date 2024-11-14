<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<%@include file="../layout/body-top.jsp" %>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">영업관리</a></li>
				<li class="breadcrumb-item active">출하요청현황(사출)</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list" style="width: 67%;">
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table id="deliveryOrderAdmTable" class="table table-bordered tr_highlight_row">
						<colgroup>		
							<col width="10%">						
							<col width="12%">
							<col width="10%">
							<col width="12%">
							<col width="18%">
							<col width="25%">
							<col width="7%">					
							<col width="7%">	
						</colgroup>
						<thead class="thead-light">
							<tr>
								<th>출하요청번호</th>
								<th>고객사</th>
								<th>출하일자</th>
								<th>차종</th>
								<th>품번</th>
								<th>품명</th>
								<th class="text-center">출하수량</th>
								<th>출하상태</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>

		
		<!-- /.left-list -->
				<!--======================== .right-list ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width: 32%;">
				<!--상단 버튼 part-->
				<div class="card" id="formBox">
					<!--오른쪽 등록 부분 상단 버튼 영역-->
					<div class="card-body col-sm-12 p-0">
						<button type="button"  class="btn btn-warning" id="btnEdit">출하요청수정</button>
                    	<button type="button"  class="btn btn-danger" id="btnDel">출하(요청)취소</button>
                   		<button type="button"  class="btn btn-primary float-right d-none" id="btnSave">출하요청저장</button>
					</div>
					<form id="form">
					
					<div class="table-responsive" class="main_table">
						<table id="deliveryOrderDtlTable" class="table table-bordered">
							<colgroup>
	                           <col width="5%"> 
	                           <col width="32%"> 
	                           <col width="13%">
	                           <col width="20%">
	                           <col width="13%">
	                           <col width="17%">
							</colgroup>
							<thead>
							<tr>
								<th><input type="checkbox" id="checkAll" name="checkAll" style="width:1.1rem;height:1.1rem"></th>
								<th>생산 LOT</th>
								<th>출하일자</th>
								<th>출하수량</th>
								<th>검사일자</th>
								<th>출하상태</th>
							</tr>
							<thead>
						</table>
					</div>
					</form>
					
					<!-- /.table-responsive -->
					
				</div>
			</div>
		</div>
		
	</div>
	<!-- /.row -->
</div>
<!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>
<style>
.tr_highlight_row tr:hover {
	background-color: #ECFFB3;
}
</style>
<script>
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

	let currentHref = "bssc0060";
	let currentPage = $('.' + currentHref).attr('id');

	$('#' + currentPage).closest('.has-child', 'li').addClass(
			'has-open has-active');
	$('#' + currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","출하요청현황(사출)"); 
	let viewIdx;
	let sideView = 'add';
	var dealCorpCdOption = '';
	var doStatusOption = '';

	var serverDateFrom = "${serverDateFrom}";
	var serverDateTo = "${serverDateTo}";

	let doNo = '';
	let itemSeq = '';
	
	var poCorpNmgubun = new Array();
	<c:forEach items="${poCorpNmgubun}" var="info">
	var json = new Object();
	json.baseCd = "${info.dealCorpCd}";
	json.baseNm = "${info.dealCorpNm}";
	poCorpNmgubun.push(json);
	</c:forEach>

	//출하의뢰등록 목록조회
	let deliveryOrderAdmTable = $('#deliveryOrderAdmTable').DataTable({
	    dom: "<'row'<'col-sm-12 col-md-9'l><'col-sm-12 col-md-3'f>>" +
				"<'row'<'col-sm-12'tr>>" +
				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>B",
			language : lang_kor,	
			destroy : true,	
			paging : true,
			searching : true,
			info : true,
			ordering : true,
			processing : true,
			autoWidth : false,
			lengthChange : true,
			scrollY: "70vh",
			pageLength : 100000,
		ajax : {
			url : '<c:url value="bs/deliveryOrderAdmListNew"/>',
			type : 'GET',
			data : {				
				'startDate': function() { return serverDateFrom.replace(/-/g, ''); },
	           	'endDate': function() { return serverDateTo.replace(/-/g, ''); },
	           	'doStatus': function() { return doStatusOption },
	           	'dealCorpCd': function() { return dealCorpCdOption; },
	           	'mainGubun': function() { return "001" },
			}	
		},	
		rowId : '',
		columns : [ 			
			{
				data : 'doNo'
			},
			{data :'dealCorpNm'},
			{data :'doDate',
				render : function(data, type, row, meata){
					return moment(data).format("YYYY-MM-DD");
				}
			},		
			{data :'itemModelNm'},
			{data :'itemCd'},
			{data :'itemNm'},
			{
				data : 'doStatus',
				render: function(data, type, row, meta) {
					if(data !="003"){
						return addCommas(row['targetQty']);
					} else {
						return addCommas(row['outputQty']);
					}
				},'className' : 'text-right'
			},
			{data :'doStatusNm',
				render: function(data, type, row, meta) {
					if(data != null){
						if(data == "출하완료"){
							return '<span style="background-color:#ffec00a8;">'+data+'</span>';
						}else{
							return data;
						}
					} else {
						return '';
					}
				},
			},
			
		],
	    order: [],
	    buttons: [
	    	'copy', 'excel', 'print'                                
	    ],
	    drawCallback : function() {
	    }
	});

    var html1 = '<div class="row">';
    html1 += '&nbsp;&nbsp;<label class="input-label-sm">출하일자</label><div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="date" id="doDateFrom" name="doDateFrom"/>';
    html1 += '</div>';
    html1 += '&nbsp;&nbsp;~ &nbsp;<div class="form-group input-sub m-0 row">';
    html1 += '<input class="form-control" style="width:97px;" type="date" id="doDateTo" name="doDateTo" />'; 
    html1 += '</div>&nbsp;&nbsp;&nbsp;';   
    html1 += '<label class="input-label-sm">발주처</label>';
	html1 += '<div class="form-group input-sub m-0">';
	html1 += '<select id="poCorpNmgubun" name="poCorpNmgubun" title="" class="select w80 col-12 custom-select">';
	html1 += '</select></div>&nbsp;&nbsp;&nbsp;';

	html1 += '<label class="input-label-sm">출하상태</label>'; 
	html1 += '<select class="custom-select" id="doStatusOption">';
	html1 += '<option value="" selected>전체</option>';
	html1 += '<option value="001">출하요청</option>';
	html1 += '<option value="002">검사완료</option>';
	html1 += '<option value="003">출하완료</option>';
	html1 += '</select>';
    html1 += '&nbsp;&nbsp;&nbsp; <button type="button"  class="btn btn-primary" id="btnRetv">조회</button>';
    html1 += '</div>';
    
	$('#deliveryOrderAdmTable_length').html(html1);
	$('#doDateFrom').val(serverDateFrom);
	$('#doDateTo').val(serverDateTo);
	
	selectBoxAppend(poCorpNmgubun, "poCorpNmgubun", "", "1");
	
	//조회 버튼 클릭시
	$('#btnRetv').on('click', function() {
		if($('#doDateFrom').val()==''||$('#doDateTo').val()==''){
			toastr.warning('날짜를 입력해주세요.');
			return false;
		}
		$('#btnSave').addClass('d-none');
		
		serverDateFrom = $('#doDateFrom').val();
		serverDateTo = $('#doDateTo').val();
		dealCorpCdOption = $('#poCorpNmgubun option:selected').val();
		doStatusOption = $('#doStatusOption option:selected').val();
		$('input[name=checkAll]').prop("checked",false);
		$('#deliveryOrderAdmTable').DataTable().ajax.reload(function(){});
    });

	//전체조회 버튼 클릭시
	$('#btnAllRetv').on('click', function() {
		serverDateFrom =  "";
		serverDateTo = "";
		dealCorpCdOption =  "";
		doStatusOption = "";
		$('input[name=checkAll]').prop("checked",false);
		$('#deliveryOrderAdmTable').DataTable().ajax.reload( function () {});
    });
	
	//메인 테이블 행 클릭시
	$('#deliveryOrderAdmTable tbody').on('click', 'tr', function(){

		if ($(this).hasClass('selected')) {
 			$(this).removeClass('selected');
		} else {
			$('#deliveryOrderAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		
		if ( deliveryOrderAdmTable.row(this).data() != null && deliveryOrderAdmTable.row(this).data() != undefined ) {
			doNo = deliveryOrderAdmTable.row(this).data().doNo;
			itemSeq =  deliveryOrderAdmTable.row(this).data().itemSeq;
		}

		$('input[name=checkAll]').prop("checked",false);
		$('#deliveryOrderDtlTable').DataTable().ajax.reload(function(){});
	});
	
	//전체선택클릭
	$('#checkAll').on('click', function() {
		if ( $('#checkAll').prop("checked") ) {
			$('#deliveryOrderDtlTable tbody tr').each(function(index, item) {	
				if ( !$(this).find('input[name=check]').is(':disabled') ) {
					$(this).find('input:checkbox[name=check]').prop("checked", true);
				}
			});
		} else {
			$('#deliveryOrderDtlTable tbody tr').each(function(index, item) {	
				if ( !$(this).find('input[name=check]').is(':disabled') ) {
					$(this).find('input:checkbox[name=check]').prop("checked", false);
				}
			});
		}
	})

	//수정버튼 클릭시
	$('#btnEdit').on('click', function(){
		if ( $('input[name=check]:checked').is(':checked') ) {
			$('input[name=check]:checked').each(function(index,item){
				var tr = $(this).closest('tr');

				if($(this).attr('data-doStatus')=="001"){
					tr.find('td input[name=outputDate]').attr('disabled',false);
					tr.find('td input[name=outputQty]').attr('disabled',false);
					tr.find('td input[name=inspectDate][type=date]').attr('disabled',true);
				}else if($(this).attr('data-doStatus')=="002"){
					tr.find('td input[name=outputDate]').attr('disabled',true);
					tr.find('td input[name=outputQty]').attr('disabled',true);
					tr.find('td input[name=inspectDate][type=date]').attr('disabled',false);
				}
				
			});
			
			$('#btnSave').removeClass('d-none');
		} else {
			toastr.warning('수정할 항목을 선택해주세요.');
		}
		
	})
	
	//취소버튼 클릭시
	$('#btnDel').on('click', function() {
		if ( $('input[name=check]:checked').is(':checked') ) {
			var check = true;
			var dataArray = new Array();

			if (check) {
				$('input[name=check]:checked').each(function(index,item){			
					
					var rowData = new Object();
					rowData.doNo = $(this).attr('data-doNo');
					rowData.doSeq = $(this).attr('data-doSeq');
					rowData.doStatus = $(this).attr('data-doStatus');

					rowData.doNoSub = $(this).attr('data-doNoSub');
					rowData.lotNo = $(this).attr('data-lotNo');
					rowData.outQty = $(this).attr('data-outQty');
					
			        dataArray.push(rowData);
			        console.log(rowData);
					
				});
				
				$.ajax({
					url : '<c:url value="bs/deliveryOrderDtlDeleteList"/>',
					type : 'POST',
					datatype: 'json',
					data: JSON.stringify(dataArray),
					contentType : "application/json; charset=UTF-8",
					beforeSend : function(){
						$('#my-spinner').show();
					},
					success : function(res) {
						if (res.result == 'ok') {
							toastr.success("출하(요청)취소되었습니다.");
							
							$('#deliveryOrderAdmTable').DataTable().ajax.reload(function(){});
							$('#deliveryOrderDtlTable').DataTable().ajax.reload(function(){});
							$('input[name=checkAll]').prop("checked",false);
						}else{
							toastr.error(res.message);
						}

						$('#my-spinner').hide();
					}
				});		
			}
		} else {
			toastr.warning('출하(요쳥)취소할 항목을 선택해주세요.');
		}
		
	})
	
	//저장버튼 클릭시
	$('#btnSave').on('click', function() {
		if ( $('input[name=check]:checked').is(':checked') ) {
			var dataArray = new Array();
			
			$('input[name=check]:checked').each(function(index,item){
				var tr = $(this).closest('tr');	
				
				var rowData = new Object();
				rowData.doNo = $(this).attr('data-doNo');
				rowData.doSeq = $(this).attr('data-doSeq');

				if($(this).attr('data-doStatus')=="001"){
					rowData.doDate = tr.find("td input[name=outputDate]").val()==null?"":tr.find("td input[name=outputDate]").val().replace(/-/g,'');
					rowData.targetQty = tr.find("td input[name=outputQty]").val()==null?"":tr.find("td input[name=outputQty]").val();
					rowData.inspectDate = "";
					rowData.outputQty = "";
					rowData.outputDate = tr.find("td input[name=outputDate]").val()==null?"":tr.find("td input[name=outputDate]").val().replace(/-/g,'');
					
				}else if($(this).attr('data-doStatus')=="002"){
					rowData.doDate = "";
					rowData.targetQty = "";
					rowData.inspectDate = tr.find("td input[name=inspectDate]").val()==null?"":tr.find("td input[name=inspectDate]").val().replace(/-/g,'');
					rowData.outputQty = "";
					rowData.outputDate = "";
				}else{
					rowData.doDate = "";
					rowData.targetQty = "";
					rowData.inspectDate = "";
					rowData.outputQty = tr.find("td input[name=outputQty]").val()==null?"":tr.find("td input[name=outputQty]").val();
					rowData.outputDate = tr.find("td input[name=outputDate]").val()==null?"":tr.find("td input[name=outputDate]").val().replace(/-/g,'');
				}

		        dataArray.push(rowData);
		        console.log(rowData);
				
			});

			$.ajax({
				url : '<c:url value="bs/deliveryOrderDtlUpdate"/>',
				type : 'POST',
				datatype: 'json',
				data: JSON.stringify(dataArray),
				contentType : "application/json; charset=UTF-8",
				success : function(res) {
					if (res.result == 'ok') {
						toastr.success("수정되었습니다.");
						
						$('#deliveryOrderAdmTable').DataTable().ajax.reload(function(){});
						$('#deliveryOrderDtlTable').DataTable().ajax.reload(function(){});
						$('input[name=checkAll]').prop("checked",false);
						$('td input[name=doDate]').attr('disabled',true);
						$('td input[name=targetQty]').attr('disabled',true);
						$('td input[name=inspectDate][type=date]').attr('disabled',true);
						$('td input[name=outputDate][type=date]').attr('disabled',true);
						$('td input[name=outputQty]').attr('disabled',true);
						$('#btnSave').addClass('d-none');
					}else{
						toastr.error(res.message);
					}
				}
			});	
		} else {
			toastr.warning('저장할 항목을 선택해주세요.');
		}
	
	});

	$(document).on('change','[name=doDate]',function(){
		var doDateValue = $(this).val();
		var tb = $(this).closest('table').find('tbody tr');
		console.log(tb);		
		$(tb).each(function(index,item){				
			
			$(this).find('td input[name=doDate]').val(doDateValue);
		});				

	});


	let deliveryOrderDtlTable = $('#deliveryOrderDtlTable').DataTable({
		dom : "<'row'<'col-sm-12 col-md-6'><'col-sm-12 col-md-6'>>"
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'>>",
		language : lang_kor,
		paging : false,
		info : true,
		ordering : false,
		processing : true,
		autoWidth : false,
		lengthChange : true,
		pageLength : -1,
		scrollY: "70.5vh",
	ajax : {
		url: '<c:url value="/bs/deliveryOrderAdmListDtl"/>',
        type: 'GET',
        data: {
        	'doNo'	: function(){ return doNo; },
        	'itemSeq': function(){ return itemSeq; },          
        },
	},
	rowId : '',
	columns : [
		{	
			render : function(data, type, row, meata){
				return '<input type="checkbox" style="width:1.1rem;height:1.1rem" name="check" data-doNo='+row['doNo']+' data-doSeq='+row['doSeq']+' data-doStatus='+row['doStatus']+' data-doNoSub='+row['doNoSev']+' data-lotNo='+row['lotNo']+' data-outQty='+row['outputQty']+' />';
			},'className' : 'text-center'
		},
		{
			data : 'lotNo'
			,'className' : 'text-center'
		},
		{	
			data : 'outputDate',
			render : function(data, type, row, meata){
				return '<input type="date" class="form-control" name="outputDate" value="'+moment(data).format("YYYY-MM-DD")+'" style="text-align:center;" disabled/>';
			}
		},
		{
			data : 'doStatus',
			render: function(data, type, row, meta) {
				if(data !="003"){
					return '<input type="text" class="form-control" name="outputQty" value="'+addCommas(row['targetQty'])+'" style="text-align:right;" disabled/>';
				} else {
					return '<input type="text" class="form-control" name="outputQty" value="'+addCommas(row['outputQty'])+'" style="text-align:right;" disabled/>';
				}
			}
		},
		{
			data : 'inspectDate',
			render : function(data, type, row, meata){
				return '<input type="date" class="form-control" name="inspectDate" value="'+moment(data).format("YYYY-MM-DD")+'" style="text-align:center;" disabled/>';
			}
		},
		{
			data : 'doStatusNm'
			,'className' : 'text-center'
		},
	],

	order: [],
	buttons: [],
	});
	
</script>

</body>
</html>
