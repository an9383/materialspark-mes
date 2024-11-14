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
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">MES VISION 실적 비교 조회</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">	
			<!--======================== .left-list ========================-->
			<div class="left-list left-sidebar" id="left-list" style="width: 99%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" onclick="openrNav()" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					<!-- .table-responsive -->
					<div class="table-responsive">
						<table id="visionDataTable" class="table table-bordered">
							<thead class="thead-light">
								<!--==========table thead 추가==========-->
								<tr>
									<th style="min-width: 70px">일자</th>
									<th style="min-width: 70px">설비명</th>
									<th style="min-width: 70px">MES총합수량</th>
									<th style="min-width: 70px">양품수량</th>
									<th style="min-width: 70px">불량합계수량</th>
									<th style="min-width: 70px">외관불량</th>
									<th style="min-width: 70px">엣지불량</th>
									<th style="min-width: 70px">출하불량</th>
									<th style="min-width: 70px">재검불량</th>									
									<th style="min-width: 70px">VISION총합수량</th>
									<th style="min-width: 70px">VISION양품수량</th>
									<th style="min-width: 70px">VISION불량수량</th>
									<th style="min-width: 70px">차이수량<br>(VISION총합수량 - MES총합수량)</th>
								</tr>
							</thead>
							<tfoot>
								<!-- <tr style="background-color:#edacb1; color:red"> -->
								<tr>
									<td colspan="" style="text-align: center">합계</td>
									<td colspan=""></td>
									<td id="sum1" colspan="" ></td>
									<td id="sum2" colspan="" ></td>					
									<td id="sum3" colspan="" ></td>
									<td id="sum4" colspan="" ></td>
									<td id="sum5" colspan="" ></td>					
									<td id="sum6" colspan="" ></td>
									<td id="sum7" colspan="" ></td>
									<td id="sum8" colspan="" ></td>					
									<td id="sum9" colspan="" ></td>
									<td id="sum10" colspan="" ></td>
									<td id="sum11" colspan="" ></td>					
								
								</tr>
							</tfoot>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0240';
	let currentHref = 'wmsc0240';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","MES VISION 실적 비교 조회");
	
	let serverDateFrom 	= "${serverDateFrom}";
	let chooseDate1 	= "${yesterday}";
	let chooseDate2 	= "${serverDate}";
	let equipCd = '';
	let visionGubun = '';

	//공통코드 처리 시작
    let equipCode = new Array(); // 설비코드
    <c:forEach items="${equipCode}" var="info">
		var json=new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";	
		equipCode.push(json);
    </c:forEach>

    //공통코드 처리 시작
    var useYnCode=new Array();
    <c:forEach items="${useYnCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		useYnCode.push(json);
    </c:forEach>
	//공통코드 처리 종료

    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let visionDataTable = $('#visionDataTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
			dom: "<'row'<'col-sm-12 col-md-8'l><'col-sm-12 col-md-4'f>>" +
			"<'row'<'col-sm-12'tr>>" +
			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",
	        language: lang_kor,
	        paging: true,
	        info: true,
	        processing: true,
	        autoWidth: false,	        
	        scrollCollapse: true,
	        pageLength: 20,

        ajax: {
            url: '<c:url value="/wm/mesVisionDataAdmList"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },		
				'equipCd'			:	function() { return equipCd; },			
				'visionGubun'		:	function() { return visionGubun; }
            },       
        },
        columns: [
            { data: 'insertDate' ,
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			},
            { data: 'equipNm' },
            { data: 'outputCnt' },
            { data: 'appearOutputCnt' },
            { data: 'faultyTotal' },
            { data: 'appearFaultyCnt' },
            { data: 'efaultyCnt' },
            { data: 'shipFaultyCnt' },
            { data: 'reShipFaultyCnt' },
            { data: 'visionTotal' },
            { data: 'fairCnt' },
            { data: 'visionFaulty' },
            { data: 'diff' },
                             
        ],
        columnDefs: [
          
            	{ targets: [2,3,4,5,6,7,8,9,10,11,12], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [2,3,4,5,6,7,8,9,10,11,12], className: 'text-right-td' },
            
           
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: 'MES비전데이터조회',
            },
            {
                extend: 'excel',
                title: 'MES비전데이터조회',
            },
            {
                extend: 'print',
                title: 'MES비전데이터조회',
            }
        ],        
        drawCallback: function () {
        
        	
			//전역변수들
			var sum1  = $('#visionDataTable').DataTable().column(2,{ page: 'all'} ).data().sum() ;
			var sum2  = $('#visionDataTable').DataTable().column(3,{ page: 'all'} ).data().sum() ;
			var sum3  = $('#visionDataTable').DataTable().column(4,{ page: 'all'} ).data().sum() ;
			var sum4  = $('#visionDataTable').DataTable().column(5,{ page: 'all'} ).data().sum() ;
			var sum5  = $('#visionDataTable').DataTable().column(6,{ page: 'all'} ).data().sum() ;
			var sum6  = $('#visionDataTable').DataTable().column(7,{ page: 'all'} ).data().sum() ;	
			var sum7  = $('#visionDataTable').DataTable().column(8,{ page: 'all'} ).data().sum() ;
			var sum8  = $('#visionDataTable').DataTable().column(9,{ page: 'all'} ).data().sum() ;
			var sum9  = $('#visionDataTable').DataTable().column(10,{ page: 'all'} ).data().sum() ;	
			var sum10  = $('#visionDataTable').DataTable().column(11,{ page: 'all'} ).data().sum() ;
			var sum11  = $('#visionDataTable').DataTable().column(12,{ page: 'all'} ).data().sum() ;
			
			
			$('#sum1').html(addCommas(sum1.toFixed(0)));		
			$('#sum2').html(addCommas(sum2.toFixed(0)));		
			$('#sum3').html(addCommas(sum3.toFixed(0)));	
			$('#sum4').html(addCommas(sum4.toFixed(0)));		
			$('#sum5').html(addCommas(sum5.toFixed(0)));		
			$('#sum6').html(addCommas(sum6.toFixed(0)));	
			$('#sum7').html(addCommas(sum7.toFixed(0)));		
			$('#sum8').html(addCommas(sum8.toFixed(0)));		
			$('#sum9').html(addCommas(sum9.toFixed(0)));	
			$('#sum10').html(addCommas(sum10.toFixed(0)));		
			$('#sum11').html(addCommas(sum11.toFixed(0)));		
			
        }
        
    });
	visionDataTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		
	});
	
	var html1 = '<div class="row">';
	html1 += '<label class="input-label-sm ml-2">일자</label>';
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
	html1 += '<label class="input-label-sm ml-1" style="padding-bottom:5px;">차이량1000이상</label>';
	html1 += '<input type="checkBox" id="visionGubun" style="width:25px;height:25px;">';

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '</div>';
	
	$('#visionDataTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);
	 selectBoxAppend(equipCode, "equipCd", "" , "1");
	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {    	
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();  		
  		equipCd = $('#equipCd').val();
  		visionGubun = ($('#visionGubun').is(":checked") == true) ? '001' : '';
  		if(dateCalc(chooseDate1,chooseDate2) < 7){
  			$('#visionDataTable').DataTable().ajax.reload(function () {});
  			$('#my-spinner').show();
		} else{
			toastr.warning("조회기간은 1주일을 초과할 수 없습니다.");
		}
  		
  		
	});
	

	function dateCalc(poDateFrom,poDateTo){
		
		var stDate = new Date(poDateFrom);
		var endDate = new Date(poDateTo);		
		 
		var btMs = endDate.getTime() - stDate.getTime() ;
		var btDay = btMs / (1000*60*60*24) ;
		console.log(btDay);
		return btDay;

	}

   

</script>

</body>
</html>
