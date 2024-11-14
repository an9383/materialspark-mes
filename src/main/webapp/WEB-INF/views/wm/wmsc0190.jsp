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
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">트레이생산현황</li>
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
		                        <th>설비명</th>
		                        <th>작지번호</th>
		                        <th>제품명</th>
		                        <th>수량</th>		              
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td ></td>
								<td ></td>
								<td ></td>
								<td id="sum">0</td>
							</tr>
						</tfoot>
					</table>
				</div>
			<!-- /.table-responsive -->
			</div>
		</div><!-- /.left-list -->
	</div><!-- /.row -->
</div><!-- / #main  -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0190';
	let currentHref = 'wmsc0190';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "트레이생산현황(상세)");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${serverDateFrom}";
	let chooseDate2 	= "${serverDate}";
	let reInspStatusArr = ['001', '003'];
	let dateCheck = '001';
	let inspStatus = '';
	let equipCd = '';
	let factoryCode = "<%=factoryCode%>";

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
        scrollY: "58vh",
        pageLength: -1,
        ajax: {
            url: '<c:url value="/po/productionPerfTrayProductQtyList"/>',
            type: 'GET',
            data: {//            
            	//'reInspStatusArr'	:	function() { return reInspStatusArr; },
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },				
            },
        },
        rowId: 'workOrdNo',
        columns: [        	
        	{ data: 'equipNm'		},
        	{ data: 'workOrdNo'	,
        		render : function(data, type, row, meta){
        			if(data == "XX99999999-999"){
        				return '';
        			} else {
        				return data;
        			}
        		}
    		},
        	{ data: 'goodsNm'		},
        	{ data: 'productQty'	},
      
       
        ],
        columnDefs: [
        	{ targets: "_all", className: 'text-center' },
        	{ targets: [3], className: 'text-right' },
        	{ targets: [3], render: $.fn.dataTable.render.number( ',' ) },
        ],
        order: [
            
        ],
        buttons: ['copy', 'excel', 'print'],
        rowCallback: function (row, data) {
			if (data.workOrdNo.includes("XX99999999-999")) {
				$(row).addClass('skyBlue');
			}
		},
		 drawCallback: function () {
	        	$('#stateTable tfoot').remove();	
	        	let sum	= $('#stateTable').DataTable().column(3,{ page: 'all'} ).data().sum()/2;		
				$('#sum').text(addCommas(sum));
		 }		
	});

	stateTable.on('draw.dt', function(){
		$('#my-spinner').hide();
	});

	var html1 = '<div class="row">';
	html1 += '<select class="custom-select mr-2" id="dateCheck" style="width:80px;">';
	html1 += '<option value="001">생산일</option>';
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
	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '</div>';




	

	$('#stateTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	
	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();
  		
  		
  		$('#stateTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});

	

   
</script>

</body>
</html>
