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
				<li class="breadcrumb-item active">비전데이터조회</li>
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
									<th style="min-width: 120px">작지번호</th>
									<th style="min-width: 70px">설비명</th>
									<th style="min-width: 70px">제품(기종)</th>
									<th style="min-width: 100px">주자재LOT</th>
									<th style="min-width: 70px">재질</th>
									<th style="min-width: 200px">규격</th>
									<th style="min-width: 70px">표면처리</th>
									<th style="min-width: 70px">생산수량</th>
									<th style="min-width: 70px">양품수량</th>
									<th style="min-width: 70px">총불량수량</th>
									<th style="min-width: 70px">주/야</th>
									<th style="min-width: 70px">작업자</th>
									<th style="min-width: 70px">수집구분</th>
									<th style="min-width: 120px">수집일시</th>
									<th style="min-width: 70px">치수         </th>
									<th style="min-width: 70px">필름겹침     </th>
									<th style="min-width: 70px">필름이물     </th>
									<th style="min-width: 70px">필름스크래치 </th>
									<th style="min-width: 70px">뜯김         </th>
									<th style="min-width: 70px">진접불량     </th>
									<th style="min-width: 70px">테프론자국   </th>
									<th style="min-width: 70px">표면기포     </th>
									<th style="min-width: 70px">필름Burr(이물</th>
									<th style="min-width: 70px">엣지기포     </th>
									<th style="min-width: 70px">필름미스매치 </th>
									<th style="min-width: 70px">필름계       </th>
									<th style="min-width: 70px">메탈찍힘     </th>
									<th style="min-width: 70px">메탈계       </th>
									<th style="min-width: 70px">메탈오염     </th>
									<th style="min-width: 70px">메탈스크래치 </th>
									<th style="min-width: 70px">메탈변형     </th>
									<th style="min-width: 70px">TEST     </th>
									

								</tr>
							</thead>
							<tfoot>
								<!-- <tr style="background-color:#edacb1; color:red"> -->
								<tr>
									<td colspan="" style="text-align: center">합계</td>
									<td colspan=""></td>
									<td colspan="" ></td>
									<td colspan="" ></td>					
									<td colspan="" ></td>					
									<td colspan="" ></td>
									<td colspan="" ></td>					
									<td colspan="" ></td>	
									<td colspan="" id="total" style="text-align: right">0</td>
									<td colspan="" id="sum" style="text-align: right">0</td>
									<td colspan="" id="faultySum" style="text-align: right" >0</td>	
									<td colspan="" ></td>
									<td colspan="" ></td>
									<td colspan="" ></td>
									<td colspan="" ></td>
									<td colspan="" id="sum1" style="text-align: right">0</td>					
									<td colspan="" id="sum2" style="text-align: right">0</td>					
									<td colspan="" id="sum3" style="text-align: right">0</td>
									<td colspan="" id="sum4" style="text-align: right">0</td>
									<td colspan="" id="sum5" style="text-align: right">0</td>
									<td colspan="" id="sum6" style="text-align: right">0</td>
									<td colspan="" id="sum7" style="text-align: right">0</td>
									<td colspan="" id="sum8" style="text-align: right">0</td>
									<td colspan="" id="sum9" style="text-align: right">0</td>
									<td colspan="" id="sum10" style="text-align: right">0</td>
									<td colspan="" id="sum11" style="text-align: right">0</td>
									<td colspan="" id="sum12" style="text-align: right">0</td>
									<td colspan="" id="sum13" style="text-align: right">0</td>
									<td colspan="" id="sum14" style="text-align: right">0</td>
									<td colspan="" id="sum15" style="text-align: right">0</td>
									<td colspan="" id="sum16" style="text-align: right">0</td>
									<td colspan="" id="sum17" style="text-align: right">0</td>
									<td colspan="" id="sum18" style="text-align: right">0</td>
												
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

	let menuAuth = 'wmsc0170';
	let currentHref = 'wmsc0170';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","비전데이터조회");
	
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
	        scrollX : true,
	        fixedColumns: {
				leftColumns: 4
	       	},	    
	        scrollCollapse: true,
	        pageLength: 20,

        ajax: {
            url: '<c:url value="/wm/visionDataAdmList"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); },		
				'equipCd'			:	function() { return equipCd; },			
				'visionGubun'		:	function() { return visionGubun; }
            },       
        },
        rowId: 'workOrdNo',
        columns: [
            { data: 'insertDate' ,
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			},
            { data: 'workOrdNo' },
            { data: 'equipNm' },
            { data: 'goodsNm' },
            { data: 'lotNo' },
            { data: 'qutyNm' },
            { data: 'model' },
            { data: 'surfaceTrtmtNm'} ,
            { data: '' ,
 				render: function(data, type, row) {
 	 				var totalCnt =  parseInt(row['fairCnt']) + parseInt(row['totalFaulty']);
 					return addCommas(totalCnt);
 				}
			},
            { data: 'fairCnt' },
            { data: 'totalFaulty' },
            { data: 'dayNightGubun',
				render: function(data, type, row) {
					if(data != null && data == 'D'){
						return "주간";
					} else{
						return "야간";
					}
					
				}
			 },
            { data: 'workChargrNm' },
            { data: 'visionGubun' ,
				render: function(data, type, row) {
					if(data != null && data == '001'){
						return "수동";
					} else{
						return "자동";
					}
					
				}
			},
            { data: 'closeTime' ,
				render: function(data, type, row) {
					
					return moment(data,'YYYYMMDDHHmmss').format("YYYY-MM-DD HH:mm:ss");
				}
			},
			{ data: 'reserved1' },
			{ data: 'reserved2' },
			{ data: 'reserved3' },
			{ data: 'reserved4' },
			{ data: 'reserved5' },
			{ data: 'reserved6' },
			{ data: 'reserved7' },
			{ data: 'reserved8' },
			{ data: 'reserved9' },
			{ data: 'reserved10' },
			{ data: 'reserved11' },
			{ data: 'reserved12' },
			{ data: 'reserved13' },
			{ data: 'reserved14' },
			{ data: 'reserved15' },
			{ data: 'reserved16' },
			{ data: 'reserved17' },
			{ data: 'reserved18' },
           
                                                   
        ],
        columnDefs: [
          
            	{ targets: [8,9,10,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [8,9,10,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32], className: 'text-right-td' },
            
           
        ],
        order: [
            [ 0, 'asc' ]
        ],
        buttons: [
            {
                extend: 'copy',
                title: '비전데이터조회',
            },
            {
                extend: 'excel',
                title: '비전데이터조회',
            },
            {
                extend: 'print',
                title: '비전데이터조회',
            }
        ],        
        drawCallback: function () {
        
        	$('#visionDataTable tfoot').remove();
			//전역변수들
			var sum = $('#visionDataTable').DataTable().column(9,{ page: 'all'} ).data().sum() ;
			var faultySum = $('#visionDataTable').DataTable().column(10,{ page: 'all'} ).data().sum() ;
			var total = sum + faultySum;

			var sum1  = $('#visionDataTable').DataTable().column(15,{ page: 'all'} ).data().sum() ;
			var sum2  = $('#visionDataTable').DataTable().column(16,{ page: 'all'} ).data().sum() ;
			var sum3  = $('#visionDataTable').DataTable().column(17,{ page: 'all'} ).data().sum() ;
			var sum4  = $('#visionDataTable').DataTable().column(18,{ page: 'all'} ).data().sum() ;
			var sum5  = $('#visionDataTable').DataTable().column(19,{ page: 'all'} ).data().sum() ;
			var sum6  = $('#visionDataTable').DataTable().column(20,{ page: 'all'} ).data().sum() ;
			var sum7  = $('#visionDataTable').DataTable().column(21,{ page: 'all'} ).data().sum() ;
			var sum8  = $('#visionDataTable').DataTable().column(22,{ page: 'all'} ).data().sum() ;
			var sum9  = $('#visionDataTable').DataTable().column(23,{ page: 'all'} ).data().sum() ;
			var sum10 = $('#visionDataTable').DataTable().column(24,{ page: 'all'} ).data().sum() ;
			var sum11 = $('#visionDataTable').DataTable().column(25,{ page: 'all'} ).data().sum() ;
			var sum12 = $('#visionDataTable').DataTable().column(26,{ page: 'all'} ).data().sum() ;
			var sum13 = $('#visionDataTable').DataTable().column(27,{ page: 'all'} ).data().sum() ;
			var sum14 = $('#visionDataTable').DataTable().column(28,{ page: 'all'} ).data().sum() ;
			var sum15 = $('#visionDataTable').DataTable().column(29,{ page: 'all'} ).data().sum() ;
			var sum16 = $('#visionDataTable').DataTable().column(30,{ page: 'all'} ).data().sum() ;
			var sum17 = $('#visionDataTable').DataTable().column(31,{ page: 'all'} ).data().sum() ;
			var sum18 = $('#visionDataTable').DataTable().column(32,{ page: 'all'} ).data().sum() ;

			
			$('#total').html(addCommas(total.toFixed(0)));
			$('#sum').html(addCommas(sum.toFixed(0)));		
			$('#faultySum').html(addCommas(faultySum.toFixed(0)));	

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
			$('#sum12').html(addCommas(sum12.toFixed(0)));		
			$('#sum13').html(addCommas(sum13.toFixed(0)));		
			$('#sum14').html(addCommas(sum14.toFixed(0)));		
			$('#sum15').html(addCommas(sum15.toFixed(0)));		
			$('#sum16').html(addCommas(sum16.toFixed(0)));		
			$('#sum17').html(addCommas(sum17.toFixed(0)));	
			$('#sum18').html(addCommas(sum18.toFixed(0)));		
	
					
		
        }
        
    });
	visionDataTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		
	});
	
	var html1 = '<div class="row">';
	html1 += '<label class="input-label-sm ml-2">수집일</label>';
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
	html1 += '<div class="multipleSelection pos-real mr-2">';
	html1 += '<label class="input-label-sm ml-1">수집구분</label>';
	html1 += '<select class="custom-select custom-select1 w-120" id="visionGubun">';
	html1 += '<option value="">전체</option>';
	html1 += '<option value="001">수동</option>';
	html1 += '<option value="002">자동</option>';
	html1 += '</select>';
	html1 += '</div>';	
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
  		visionGubun = $('#visionGubun').val();
  		$('#visionDataTable').DataTable().ajax.reload(function () {});
  		$('#my-spinner').show();
	});
	

   

   

</script>

</body>
</html>
