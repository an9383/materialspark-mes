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
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">출하검사집계</li>
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
					<table id="stateTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
		                        <th>생산일</th>
		                        <th>생산작업자</th>
		                        <th>검사자</th>
		                        <th>주/야구분</th>
		                        <th>설비명</th>
		                        <th>주재료</th>
		                        <th>트레이번호</th>
		                        <th>제품</th>
		                        <th>재질</th>
		                        <th>검사수량</th>
		                        <th>양품수량</th>
		                        <th>불량수량</th>
		                        <th>부적합TRAY번호</th>
							</tr>
						</thead>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'qmsc0210';
	let currentHref = 'qmsc0210';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "출하검사집계");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${serverDateFrom}";
	let chooseDate2 	= "${serverDate}";
	let reInspStatusArr = ['001', '003'];
	let dateCheck = '001';
	let inspStatus = '';
	let equipCd = '';

	//공통코드 처리 시작
    let equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";	
		equipCode.push(json);
    </c:forEach>
    
    let inspStatusCode = new Array(); // 검사상태
    <c:forEach items="${inspStatus}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		inspStatusCode.push(json);
    </c:forEach>
    //공통코드 처리 종료 
    

	
	$('#my-spinner').show();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let stateTable = $('#stateTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
        language: lang_kor,
        paging: true,
        info: true,
        processing: true,
        autoWidth: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="/qm/shipInspStatusList"/>',
            type: 'GET',
            data: {//            
            	//'reInspStatusArr'	:	function() { return reInspStatusArr; },
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },
				'dateCheck'			:	function() { return dateCheck; },
				'equipCd'			:	function() { return equipCd; },
				'inspStatus'		:	function() { return inspStatus; },
            },
        },
        rowId: 'workOrdNo',
        columns: [
        	{
        		data: 'productDate',
        		render : function(data, type, row, meta){
        			if(data != null & data != ''){
        				return moment(data).format('YYYY-MM-DD');
        			} else {
        				return '';
        			}
        		},
				'className' : 'text-center'
        	},
        	{
        		data: 'trayWorkerId',
				'className' : 'text-center'
        	},
        	{
        		data: 'inspChargrNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'dayNightCd',
				'className' : 'text-center',
				render: function(data, type, row) {
					if(data == 'D'){
						return '주간';
					} else{
						return '야간';
					}
					
				}
			
        	},
        	{
        		data: 'equipNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'matrlLotNo',
				'className' : 'text-center'
        	},
        	{
        		data: 'labelLotNoSeq',
				'className' : 'text-center'
        	},
        	{
        		data: 'goodsNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'qutyNm',
				'className' : 'text-center'
        	},
        	{
        		data: 'productQty',
				'className' : 'text-center'
        	},
        	{
        		data: 'productQty',
				'className' : 'text-center'
        	},
        	{
        		data: 'faultyCnt',
				'className' : 'text-center'
        	},
        	{
        		data: 'faultyTrayNo',
				'className' : 'text-center'
        	},
        ],
        columnDefs: [
        	{ targets: [9,10,11], render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
             [ 0, 'asc' ], [ 6, 'asc' ]
        ],
        buttons: ['copy', 'excel', 'print'],
	});

	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});

	var html1 = '<div class="row">';
	html1 += '<select class="custom-select" id="dateCheck" style="width:80px;">';
	html1 += '<option value="001">생산일</option>';
	html1 += '<option value="002">검사일</option>';
	html1 += '</select>';
	html1 += '<div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom" name="chooseDateFrom" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateFrom,chooseDateFrom,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>';
	html1 += '<label class="input-label-sm ml-2">~</label><div class="form-group input-sub m-0 row">';
	html1 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo" name="chooseDateTo" />';
	html1 += '<button onclick="fnPopUpCalendar(chooseDateTo,chooseDateTo,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar" type="button">';
	html1 += '<span class="oi oi-calendar"></span>';
	html1 += '</button>'; 
	html1 += '</div>&nbsp;&nbsp;';
	
	html1 += '<div class="multipleSelection pos-real mr-2">';
	html1 += '<label class="input-label-sm ml-1">설비명</label>';
	html1 += '<select class="custom-select custom-select1 w-120" id="equipCd">';
	html1 += '</select>';
		html1 += '</div>';
	
	html1 += '<label class="input-label-sm ml-1">검사상태</label><select class="custom-select" id="inspStatusSelect" style="width:80px;"></select>';
	
	html1 += '&nbsp;&nbsp;<label class="input-label-sm ml-1">자재LOT</label>';
	html1 += '<div class="form-group-100 mr-4">';
	html1 += '<input type="text" class="form-control" id="matrlLotNo" style="min-width:130px;">';
	html1 += '</div>';

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '</div>';
	
	$('#stateTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	 selectBoxAppend(inspStatusCode, "inspStatusSelect", "" , "1");  
	 selectBoxAppend(equipCode, "equipCd", "" , "1");
	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {
    	
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		dateCheck = $('#dateCheck').val();
  		inspStatus = $('#inspStatusSelect').val();
  		equipCd = $('#equipCd').val();
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});
	
	
   
</script>

</body>
</html>
