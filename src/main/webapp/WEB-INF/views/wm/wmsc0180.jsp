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
				<li class="breadcrumb-item active">비전데이터집계</li>
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
					<div class="card-header card-tab" style="padding-bottom:5px;">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tab1">Shift별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">주자재별</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">일자별</a></li>
						</ul>
					</div>
					<div id="dateTab">
						<div class="table-responsive" style="padding-top:10px;">
							<table id="visionDataTable" class="table table-bordered">
								<thead class="thead-light">
									<!--==========table thead 추가==========-->
									<tr>
										<th style="min-width: 70px">일자</th>		
										<th style="min-width: 70px">설비명</th>			
										<th style="min-width: 70px">주/야</th>	
										<th style="min-width: 70px">제품(기종)</th>			
										<th style="min-width: 70px">재질</th>
										<th style="min-width: 200px">규격</th>
										<th style="min-width: 70px">표면처리</th>	
										<th style="min-width: 70px">생산수량</th>
										<th style="min-width: 70px">양품수량</th>
										<th style="min-width: 70px">총 불량수량</th>
										<th style="min-width: 110px">불량수량<br>(치수,엣지기포제외)</th>
										<th style="min-width: 70px">(비)메탈/필름불량</th>
										<th style="min-width: 70px">양품 수</th>
										<th style="min-width: 70px">과검율</th>
										<!-- <th style="min-width: 70px">작업자</th>		 -->													
										<th style="min-width: 70px">치수         </th>
										<th style="min-width: 70px">필름겹침     </th>
										<th style="min-width: 70px">필름이물     </th>
										<th style="min-width: 70px">필름스크래치 </th>
										<th style="min-width: 70px">뜯김         </th>
										<th style="min-width: 70px">진접불량     </th>
										<th style="min-width: 70px">테프론자국   </th>
										<th style="min-width: 70px">표면기포     </th>
										<th style="min-width: 100px">필름Burr(이물)</th>
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
										<td colspan="" ></td>				
										<td colspan="" ></td>
										<td colspan="" ></td>				
										<td colspan="" ></td>
										<td colspan="" ></td>				
										<td colspan="" ></td>		
										<td colspan="" id="total" style="text-align: right">0</td>									
										<td colspan="" id="sum" style="text-align: right">0</td>
										<td colspan="" id="faultySum" style="text-align: right" >0</td>
										<td colspan="" id="exceptSum" style="text-align: right" >0</td>	
										<td colspan="" id="faultyCntSum" style="text-align: right" >0</td>	
										<td colspan="" id="visionFairCnt" style="text-align: right" >0</td>	
										<td colspan="" id="notFaultyRate" style="text-align: right" >0</td>	
												
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
					<div id="lotTab" class="d-none">
						<div class="table-responsive" style="padding-top:10px;">
							<table id="visionDataTabTable" class="table table-bordered">
								<thead class="thead-light">
									<!--==========table thead 추가==========-->
									<tr>
										<th style="min-width: 70px">주자재</th>	
										<th style="min-width: 70px">생산수량</th>											
										<th style="min-width: 70px">양품수량</th>
										<th style="min-width: 70px">총 불량수량</th>
										<th style="min-width: 110px">불량수량<br>(치수,엣지기포제외)</th>
										<th style="min-width: 70px">(비)메탈/필름불량</th>	
										<th style="min-width: 70px">양품 수</th>
										<th style="min-width: 70px">과검율</th>																					
										<th style="min-width: 70px">치수         </th>
										<th style="min-width: 70px">필름겹침     </th>
										<th style="min-width: 70px">필름이물     </th>
										<th style="min-width: 70px">필름스크래치 </th>
										<th style="min-width: 70px">뜯김         </th>
										<th style="min-width: 70px">진접불량     </th>
										<th style="min-width: 70px">테프론자국   </th>
										<th style="min-width: 70px">표면기포     </th>
										<th style="min-width: 100px">필름Burr(이물)</th>
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
									<tr>
										<td colspan="" style="text-align: center">합계</td>			
										<td colspan="" id="totalLot" style="text-align: right">0</td>																
										<td colspan="" id="sumLot" style="text-align: right">0</td>
										<td colspan="" id="faultySumLot" style="text-align: right" >0</td>
										<td colspan="" id="exceptCntSumLot" style="text-align: right" >0</td>
										<td colspan="" id="faultyCntSumLot" style="text-align: right" >0</td>	
										<td colspan="" id="visionFairCntLot" style="text-align: right" >0</td>	
										<td colspan="" id="notFaultyRateLot" style="text-align: right" >0</td>														
										<td colspan="" id="sum1Lot" style="text-align: right">0</td>					
										<td colspan="" id="sum2Lot" style="text-align: right">0</td>					
										<td colspan="" id="sum3Lot" style="text-align: right">0</td>
										<td colspan="" id="sum4Lot" style="text-align: right">0</td>
										<td colspan="" id="sum5Lot" style="text-align: right">0</td>
										<td colspan="" id="sum6Lot" style="text-align: right">0</td>
										<td colspan="" id="sum7Lot" style="text-align: right">0</td>
										<td colspan="" id="sum8Lot" style="text-align: right">0</td>
										<td colspan="" id="sum9Lot" style="text-align: right">0</td>
										<td colspan="" id="sum10Lot" style="text-align: right">0</td>
										<td colspan="" id="sum11Lot" style="text-align: right">0</td>
										<td colspan="" id="sum12Lot" style="text-align: right">0</td>
										<td colspan="" id="sum13Lot" style="text-align: right">0</td>
										<td colspan="" id="sum14Lot" style="text-align: right">0</td>
										<td colspan="" id="sum15Lot" style="text-align: right">0</td>
										<td colspan="" id="sum16Lot" style="text-align: right">0</td>
										<td colspan="" id="sum17Lot" style="text-align: right">0</td>
										<td colspan="" id="sum18Lot" style="text-align: right">0</td>
													
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- /.table-responsive -->
					</div>
					<div id="dayTab" class="d-none">
						<div class="table-responsive" style="padding-top:10px;">
							<table id="visionDataDayTabTable" class="table table-bordered">
								<thead class="thead-light">
									<!--==========table thead 추가==========-->
									<tr>
										<th style="min-width: 70px">일자</th>		
										<th style="min-width: 70px">설비명</th>			
										<th style="min-width: 70px">제품(기종)</th>			
										<th style="min-width: 70px">재질</th>
										<th style="min-width: 200px">규격</th>
										<th style="min-width: 70px">표면처리</th>	
										<th style="min-width: 70px">생산수량</th>
										<th style="min-width: 70px">양품수량</th>
										<th style="min-width: 70px">총 불량수량</th>
										<th style="min-width: 110px">불량수량<br>(치수,엣지기포제외)</th>
										<th style="min-width: 70px">(비)메탈/필름불량</th>
										<th style="min-width: 70px">양품 수</th>
										<th style="min-width: 70px">과검율</th>
										<!-- <th style="min-width: 70px">작업자</th>		 -->													
										<th style="min-width: 70px">치수         </th>
										<th style="min-width: 70px">필름겹침     </th>
										<th style="min-width: 70px">필름이물     </th>
										<th style="min-width: 70px">필름스크래치 </th>
										<th style="min-width: 70px">뜯김         </th>
										<th style="min-width: 70px">진접불량     </th>
										<th style="min-width: 70px">테프론자국   </th>
										<th style="min-width: 70px">표면기포     </th>
										<th style="min-width: 100px">필름Burr(이물)</th>
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
										<td colspan="" ></td>				
										<td colspan="" ></td>				
										<td colspan="" ></td>
										<td colspan="" ></td>				
										<td colspan="" ></td>		
										<td colspan="" id="totalDay" style="text-align: right">0</td>									
										<td colspan="" id="sumDay" style="text-align: right">0</td>
										<td colspan="" id="faultySumDay" style="text-align: right" >0</td>
										<td colspan="" id="exceptSumDay" style="text-align: right" >0</td>	
										<td colspan="" id="faultyCntSumDay" style="text-align: right" >0</td>	
										<td colspan="" id="visionFairCntDay" style="text-align: right" >0</td>	
										<td colspan="" id="notFaultyRateDay" style="text-align: right" >0</td>	
												
										<td colspan="" id="sum1Day" style="text-align: right">0</td>					
										<td colspan="" id="sum2Day" style="text-align: right">0</td>					
										<td colspan="" id="sum3Day" style="text-align: right">0</td>
										<td colspan="" id="sum4Day" style="text-align: right">0</td>
										<td colspan="" id="sum5Day" style="text-align: right">0</td>
										<td colspan="" id="sum6Day" style="text-align: right">0</td>
										<td colspan="" id="sum7Day" style="text-align: right">0</td>
										<td colspan="" id="sum8Day" style="text-align: right">0</td>
										<td colspan="" id="sum9Day" style="text-align: right">0</td>
										<td colspan="" id="sum10Day" style="text-align: right">0</td>
										<td colspan="" id="sum11Day" style="text-align: right">0</td>
										<td colspan="" id="sum12Day" style="text-align: right">0</td>
										<td colspan="" id="sum13Day" style="text-align: right">0</td>
										<td colspan="" id="sum14Day" style="text-align: right">0</td>
										<td colspan="" id="sum15Day" style="text-align: right">0</td>
										<td colspan="" id="sum16Day" style="text-align: right">0</td>
										<td colspan="" id="sum17Day" style="text-align: right">0</td>
										<td colspan="" id="sum18Day" style="text-align: right">0</td>
													
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- /.table-responsive -->
					</div>
				</div>
			</div>
			<!-- /.left-list -->
			
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0180';
	let currentHref = 'wmsc0180';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","비전데이터집계");
	
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
	        autoWidth: true,
	        scrollX : true,
	        fixedColumns: {
				leftColumns: 7
	       	},	    
	        scrollCollapse: true,
	        pageLength: 20,

        ajax: {
            url: '<c:url value="/wm/visionDataAdmListTotal"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); }
            },       
        },
        rowId: 'workOrdNo',
        columns: [
        	 { data: 'insertDate' ,
  				render: function(data, type, row) {
  					return moment(data).format("YYYY-MM-DD");
  				}
  			 },
        	 { data: 'equipNm' },        	
 			 { data: 'dayNightGubun',
 				render: function(data, type, row) {
 					if(data != null && data == 'D'){
 						return "주간";
 					} else{
 						return "야간";
 					}
 					
 				}
 			 },
            { data: 'goodsNm' },           
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
            { data: 'exceptCnt' },
            { data: 'faultyCnt' },
            { data: '' ,
                render: function(data, type, row){
                    if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						return addCommas(visionFairCnt);
                    } else return parseInt(row['totalFaulty']);
                }
            },
            { data: '' ,
				render: function(data, type, row){
					if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						var overDetecion = visionFairCnt/parseInt(row['totalFaulty']);
						return addCommas(parseFloat(overDetecion*100).toFixed(2)) + '%';
                    } else return '';
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
          
            	{ targets: [7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], className: 'text-right-td' },
            
           
        ],
        order: [
        	 [0, 'asc'],[1, 'asc']
         
        ],
        buttons: [
            {
                extend: 'copy',
                title: '비전데이터집계(날짜별)',
            },
            {
                extend: 'excel',
                title: '비전데이터집계(날짜별)',
            },
            {
                extend: 'print',
                title: '비전데이터집계(날짜별)',
            }
        ],        
        drawCallback: function () {
        
        	$('#visionDataTable tfoot').remove();
			//전역변수들
			var sum = $('#visionDataTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var faultySum = $('#visionDataTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var exceptSum = $('#visionDataTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			var faultyCntSum = $('#visionDataTable').DataTable().column(11,{ page: 'all'} ).data().sum();
			var visionFairCnt = faultySum - faultyCntSum;
			var totalCnt = sum + faultySum;
			var notFaultyRate = visionFairCnt / faultySum;
			if(visionFairCnt == 0 && faultySum == 0) {
				notFaultyRate = 0;
			}

			var sum1  = $('#visionDataTable').DataTable().column(14,{ page: 'all'} ).data().sum() ;
			var sum2  = $('#visionDataTable').DataTable().column(15,{ page: 'all'} ).data().sum() ;
			var sum3  = $('#visionDataTable').DataTable().column(16,{ page: 'all'} ).data().sum() ;
			var sum4  = $('#visionDataTable').DataTable().column(17,{ page: 'all'} ).data().sum() ;
			var sum5  = $('#visionDataTable').DataTable().column(18,{ page: 'all'} ).data().sum() ;
			var sum6  = $('#visionDataTable').DataTable().column(19,{ page: 'all'} ).data().sum() ;
			var sum7  = $('#visionDataTable').DataTable().column(20,{ page: 'all'} ).data().sum() ;
			var sum8  = $('#visionDataTable').DataTable().column(21,{ page: 'all'} ).data().sum() ;
			var sum9  = $('#visionDataTable').DataTable().column(22,{ page: 'all'} ).data().sum() ;
			var sum10 = $('#visionDataTable').DataTable().column(23,{ page: 'all'} ).data().sum() ;
			var sum11 = $('#visionDataTable').DataTable().column(24,{ page: 'all'} ).data().sum() ;
			var sum12 = $('#visionDataTable').DataTable().column(25,{ page: 'all'} ).data().sum() ;
			var sum13 = $('#visionDataTable').DataTable().column(26,{ page: 'all'} ).data().sum() ;
			var sum14 = $('#visionDataTable').DataTable().column(27,{ page: 'all'} ).data().sum() ;
			var sum15 = $('#visionDataTable').DataTable().column(28,{ page: 'all'} ).data().sum() ;
			var sum16 = $('#visionDataTable').DataTable().column(29,{ page: 'all'} ).data().sum() ;
			var sum17 = $('#visionDataTable').DataTable().column(30,{ page: 'all'} ).data().sum() ;
			var sum18 = $('#visionDataTable').DataTable().column(31,{ page: 'all'} ).data().sum() ;
                                                              
			
			$('#total').html(addCommas(totalCnt.toFixed(0)));
			$('#sum').html(addCommas(sum.toFixed(0)));		
			$('#faultySum').html(addCommas(faultySum.toFixed(0)));	
			$('#exceptSum').html(addCommas(exceptSum.toFixed(0)));	
			$('#faultyCntSum').html(addCommas(faultyCntSum.toFixed(0)));
			$('#visionFairCnt').html(addCommas(visionFairCnt.toFixed(0)));	
			$('#notFaultyRate').html(addCommas(parseFloat(notFaultyRate*100).toFixed(2)) + "%");	

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
			var colorStat = false;
			let equipNm = '';
			$.each($('#visionDataTable tbody tr'),function(index, item, array){
				if(equipNm != $(this).find('td').eq(1).text()){
					equipNm = $(this).find('td').eq(1).text();	
					colorStat = !colorStat;
				}
				
				if(colorStat){
    				$(this).css('background-color','#F2F2F2');
					
        		} else{
        			$(this).css('background-color','#ffffff');
					
            	}
			});
			
			
					
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

	html1 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv">조회</button>';
	html1 += '</div>';
	
	$('#visionDataTable_length').html(html1);
	$('#chooseDateFrom').val(chooseDate1);
	$('#chooseDateTo').val(chooseDate2);

	   // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let visionDataTabTable = $('#visionDataTabTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	        autoWidth: true,
	        scrollX : true,
	        fixedColumns: {
				leftColumns: 1
	       	},	    
	        scrollCollapse: true,
	        pageLength: 20,

        ajax: {
            url: '<c:url value="/wm/visionDataAdmListLot"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); }
            },       
        },
        rowId: 'lotNo',
        columns: [
        	{ data: 'lotNo' },   
        	{ data: '' ,
 				render: function(data, type, row) {
 	 				var totalCnt =  parseInt(row['fairCnt']) + parseInt(row['totalFaulty']);
 					return addCommas(totalCnt);
 				}
			},     	
            { data: 'fairCnt' },
            { data: 'totalFaulty' },
            { data: 'exceptCnt' },
            { data: 'faultyCnt' },
            { data: '',
                render: function(data,type,row){
                	if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						return addCommas(visionFairCnt);
                    } else return parseInt(row['totalFaulty']);
                }
            },
            { data: '' ,
				render: function(data, type, row){
					if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						var overDetecion = visionFairCnt/parseInt(row['totalFaulty']);
						return addCommas(parseFloat(overDetecion*100).toFixed(2)) + '%';
                    } else return '';
				}},
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
            	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], className: 'text-right-td' },          
        ],
        order: [
        	 [0, 'asc']
         
        ],
        buttons: [
            {
                extend: 'copy',
                title: '비전데이터집계(LOT별)',
            },
            {
                extend: 'excel',
                title: '비전데이터집계(LOT별)',
            },
            {
                extend: 'print',
                title: '비전데이터집계(LOT별)',
            }
        ],        
        drawCallback: function () {
        
        	$('#visionDataTabTable tfoot').remove();
			//전역변수들
			var sumLot = $('#visionDataTabTable').DataTable().column(2,{ page: 'all'} ).data().sum();
			var faultySumLot = $('#visionDataTabTable').DataTable().column(3,{ page: 'all'} ).data().sum();
			var exceptCntSumLot = $('#visionDataTabTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			var faultyCntSumLot = $('#visionDataTabTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			var visionFairCntLot = faultySumLot - faultyCntSumLot;
			var totalLot = sumLot + faultySumLot;
			var notFaultyRateLot = visionFairCntLot / faultySumLot;
			if(visionFairCntLot == 0 && faultySumLot == 0) {
				notFaultyRateLot = 0;
			}

			var sum1Lot  = $('#visionDataTabTable').DataTable().column(8,{ page: 'all'} ).data().sum() ;
			var sum2Lot  = $('#visionDataTabTable').DataTable().column(9,{ page: 'all'} ).data().sum() ;
			var sum3Lot  = $('#visionDataTabTable').DataTable().column(10,{ page: 'all'} ).data().sum() ;
			var sum4Lot  = $('#visionDataTabTable').DataTable().column(11,{ page: 'all'} ).data().sum() ;
			var sum5Lot  = $('#visionDataTabTable').DataTable().column(12,{ page: 'all'} ).data().sum() ;
			var sum6Lot  = $('#visionDataTabTable').DataTable().column(13,{ page: 'all'} ).data().sum() ;
			var sum7Lot  = $('#visionDataTabTable').DataTable().column(14,{ page: 'all'} ).data().sum() ;
			var sum8Lot  = $('#visionDataTabTable').DataTable().column(15,{ page: 'all'} ).data().sum() ;
			var sum9Lot  = $('#visionDataTabTable').DataTable().column(16,{ page: 'all'} ).data().sum() ;
			var sum10Lot = $('#visionDataTabTable').DataTable().column(17,{ page: 'all'} ).data().sum() ;
			var sum11Lot = $('#visionDataTabTable').DataTable().column(18,{ page: 'all'} ).data().sum() ;
			var sum12Lot = $('#visionDataTabTable').DataTable().column(19,{ page: 'all'} ).data().sum() ;
			var sum13Lot = $('#visionDataTabTable').DataTable().column(20,{ page: 'all'} ).data().sum() ;
			var sum14Lot = $('#visionDataTabTable').DataTable().column(21,{ page: 'all'} ).data().sum() ;
			var sum15Lot = $('#visionDataTabTable').DataTable().column(22,{ page: 'all'} ).data().sum() ;
			var sum16Lot = $('#visionDataTabTable').DataTable().column(23,{ page: 'all'} ).data().sum() ;
			var sum17Lot = $('#visionDataTabTable').DataTable().column(24,{ page: 'all'} ).data().sum() ;
			var sum18Lot = $('#visionDataTabTable').DataTable().column(25,{ page: 'all'} ).data().sum() ;
                                                              
			
			$('#totalLot').html(addCommas(totalLot.toFixed(0)));			
			$('#sumLot').html(addCommas(sumLot.toFixed(0)));		
			$('#faultySumLot').html(addCommas(faultySumLot.toFixed(0)));
			$('#exceptCntSumLot').html(addCommas(exceptCntSumLot.toFixed(0)));	
			$('#faultyCntSumLot').html(addCommas(faultyCntSumLot.toFixed(0)));	
			$('#visionFairCntLot').html(addCommas(visionFairCntLot.toFixed(0)));
			$('#notFaultyRateLot').html(addCommas(parseFloat(notFaultyRateLot*100).toFixed(2)) + "%");

			$('#sum1Lot').html(addCommas(sum1Lot.toFixed(0)));		
			$('#sum2Lot').html(addCommas(sum2Lot.toFixed(0)));		
			$('#sum3Lot').html(addCommas(sum3Lot.toFixed(0)));		
			$('#sum4Lot').html(addCommas(sum4Lot.toFixed(0)));		
			$('#sum5Lot').html(addCommas(sum5Lot.toFixed(0)));		
			$('#sum6Lot').html(addCommas(sum6Lot.toFixed(0)));		
			$('#sum7Lot').html(addCommas(sum7Lot.toFixed(0)));		
			$('#sum8Lot').html(addCommas(sum8Lot.toFixed(0)));		
			$('#sum9Lot').html(addCommas(sum9Lot.toFixed(0)));		
			$('#sum10Lot').html(addCommas(sum10Lot.toFixed(0)));		
			$('#sum11Lot').html(addCommas(sum11Lot.toFixed(0)));		
			$('#sum12Lot').html(addCommas(sum12Lot.toFixed(0)));		
			$('#sum13Lot').html(addCommas(sum13Lot.toFixed(0)));		
			$('#sum14Lot').html(addCommas(sum14Lot.toFixed(0)));		
			$('#sum15Lot').html(addCommas(sum15Lot.toFixed(0)));		
			$('#sum16Lot').html(addCommas(sum16Lot.toFixed(0)));		
			$('#sum17Lot').html(addCommas(sum17Lot.toFixed(0)));	
			$('#sum18Lot').html(addCommas(sum18Lot.toFixed(0)));		
	
					
		
        }
        
    });
	visionDataTabTable.on('draw.dt', function(){
		$('#my-spinner').hide();
		
	});
	
	var html2 = '<div class="row">';
	html2 += '<label class="input-label-sm ml-2">수집일</label>';
	html2 += '<div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom2" name="chooseDateFrom2" />';
	html2 += '<button onclick="fnPopUpCalendar(chooseDateFrom2,chooseDateFrom2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFromCalendar2" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>';
	html2 += '<label class="input-label-sm ml-2">~</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo2" name="chooseDateTo2" />';
	html2 += '<button onclick="fnPopUpCalendar(chooseDateTo2,chooseDateTo2,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar2" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>'; 
	html2 += '</div>&nbsp;&nbsp;';	

	html2 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv2">조회</button>';
	html2 += '</div>';
	
	$('#visionDataTabTable_length').html(html2);
	$('#chooseDateFrom2').val(chooseDate1);
	$('#chooseDateTo2').val(chooseDate2);


	// 목록
    $.fn.dataTable.ext.errMode = 'none';
	let visionDataDayTabTable = $('#visionDataDayTabTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
	        autoWidth: true,
	        scrollX : true,
	        fixedColumns: {
				leftColumns: 6
	       	},	    
	        scrollCollapse: true,
	        pageLength: 20,

        ajax: {
            url: '<c:url value="/wm/visionDataAdmListDay"/>',
            type: 'GET',
            data: {
            	'chooseDateFrom'	:	function() { return chooseDate1.replace(/-/g, ''); },
				'chooseDateTo'		:	function() { return chooseDate2.replace(/-/g, ''); }
            },       
        },
        rowId: 'workOrdNo',
        columns: [
        	 { data: 'insertDate' ,
  				render: function(data, type, row) {
  					return moment(data).format("YYYY-MM-DD");
  				}
  			 },
        	{ data: 'equipNm' },        	
            { data: 'goodsNm' },           
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
            { data: 'exceptCnt' },
            { data: 'faultyCnt' },
            { data: '' ,
                render: function(data, type, row){
                    if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						return addCommas(visionFairCnt);
                    } else return parseInt(row['totalFaulty']);
                }
            },
            { data: '' ,
				render: function(data, type, row){
					if(row['faultyCnt'] != null){
						var visionFairCnt = parseInt(row['totalFaulty']) - parseInt(row['faultyCnt']);
						var overDetecion = 0;
						if(parseInt(row['faultyCnt']) != 0){
							overDetecion = visionFairCnt/parseInt(row['totalFaulty']);
						} else overDetecion = 0;
						return addCommas(parseFloat(overDetecion*100).toFixed(2)) + '%';
                    } else return '';
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
          
            	{ targets: [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], className: 'text-right-td' },
            
           
        ],
        order: [
        	 [0, 'asc'],[1, 'asc']
         
        ],
        buttons: [
            {
                extend: 'copy',
                title: '비전데이터집계(일자별)',
            },
            {
                extend: 'excel',
                title: '비전데이터집계(일자별)',
            },
            {
                extend: 'print',
                title: '비전데이터집계(일자별)',
            }
        ],        
        drawCallback: function () {
        
        	$('#visionDataDayTabTable tfoot').remove();
			//전역변수들
			var sumDay = $('#visionDataDayTabTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			var faultySumDay = $('#visionDataDayTabTable').DataTable().column(8,{ page: 'all'} ).data().sum();
			var exceptSumDay = $('#visionDataDayTabTable').DataTable().column(9,{ page: 'all'} ).data().sum();
			var faultyCntSumDay = $('#visionDataDayTabTable').DataTable().column(10,{ page: 'all'} ).data().sum();
			var visionFairCntDay = faultySumDay - faultyCntSumDay;
			var totalCntDay = sumDay + faultySumDay;
			var notFaultyRateDay = visionFairCntDay / faultySumDay;
			if(visionFairCntDay == 0 && faultySumDay == 0) {
				notFaultyRateDay = 0;
			}

			var sum1Day  = $('#visionDataDayTabTable').DataTable().column(13,{ page: 'all'} ).data().sum() ;
			var sum2Day  = $('#visionDataDayTabTable').DataTable().column(14,{ page: 'all'} ).data().sum() ;
			var sum3Day  = $('#visionDataDayTabTable').DataTable().column(15,{ page: 'all'} ).data().sum() ;
			var sum4Day  = $('#visionDataDayTabTable').DataTable().column(16,{ page: 'all'} ).data().sum() ;
			var sum5Day  = $('#visionDataDayTabTable').DataTable().column(17,{ page: 'all'} ).data().sum() ;
			var sum6Day  = $('#visionDataDayTabTable').DataTable().column(18,{ page: 'all'} ).data().sum() ;
			var sum7Day  = $('#visionDataDayTabTable').DataTable().column(19,{ page: 'all'} ).data().sum() ;
			var sum8Day  = $('#visionDataDayTabTable').DataTable().column(20,{ page: 'all'} ).data().sum() ;
			var sum9Day  = $('#visionDataDayTabTable').DataTable().column(21,{ page: 'all'} ).data().sum() ;
			var sum10Day = $('#visionDataDayTabTable').DataTable().column(22,{ page: 'all'} ).data().sum() ;
			var sum11Day = $('#visionDataDayTabTable').DataTable().column(23,{ page: 'all'} ).data().sum() ;
			var sum12Day = $('#visionDataDayTabTable').DataTable().column(24,{ page: 'all'} ).data().sum() ;
			var sum13Day = $('#visionDataDayTabTable').DataTable().column(25,{ page: 'all'} ).data().sum() ;
			var sum14Day = $('#visionDataDayTabTable').DataTable().column(26,{ page: 'all'} ).data().sum() ;
			var sum15Day = $('#visionDataDayTabTable').DataTable().column(27,{ page: 'all'} ).data().sum() ;
			var sum16Day = $('#visionDataDayTabTable').DataTable().column(28,{ page: 'all'} ).data().sum() ;
			var sum17Day = $('#visionDataDayTabTable').DataTable().column(29,{ page: 'all'} ).data().sum() ;
			var sum18Day = $('#visionDataDayTabTable').DataTable().column(30,{ page: 'all'} ).data().sum() ;
                                                              
			
			$('#totalDay').html(addCommas(totalCntDay.toFixed(0)));
			$('#sumDay').html(addCommas(sumDay.toFixed(0)));		
			$('#faultySumDay').html(addCommas(faultySumDay.toFixed(0)));	
			$('#exceptSumDay').html(addCommas(exceptSumDay.toFixed(0)));	
			$('#faultyCntSumDay').html(addCommas(faultyCntSumDay.toFixed(0)));
			$('#visionFairCntDay').html(addCommas(visionFairCntDay.toFixed(0)));	
			$('#notFaultyRateDay').html(addCommas(parseFloat(notFaultyRateDay*100).toFixed(2)) + "%");	

			$('#sum1Day').html(addCommas(sum1Day.toFixed(0)));		
			$('#sum2Day').html(addCommas(sum2Day.toFixed(0)));		
			$('#sum3Day').html(addCommas(sum3Day.toFixed(0)));		
			$('#sum4Day').html(addCommas(sum4Day.toFixed(0)));		
			$('#sum5Day').html(addCommas(sum5Day.toFixed(0)));		
			$('#sum6Day').html(addCommas(sum6Day.toFixed(0)));		
			$('#sum7Day').html(addCommas(sum7Day.toFixed(0)));		
			$('#sum8Day').html(addCommas(sum8Day.toFixed(0)));		
			$('#sum9Day').html(addCommas(sum9Day.toFixed(0)));		
			$('#sum10Day').html(addCommas(sum10Day.toFixed(0)));		
			$('#sum11Day').html(addCommas(sum11Day.toFixed(0)));		
			$('#sum12Day').html(addCommas(sum12Day.toFixed(0)));		
			$('#sum13Day').html(addCommas(sum13Day.toFixed(0)));		
			$('#sum14Day').html(addCommas(sum14Day.toFixed(0)));		
			$('#sum15Day').html(addCommas(sum15Day.toFixed(0)));		
			$('#sum16Day').html(addCommas(sum16Day.toFixed(0)));		
			$('#sum17Day').html(addCommas(sum17Day.toFixed(0)));	
			$('#sum18Day').html(addCommas(sum18Day.toFixed(0)));
			var colorStat = false;
			let equipNm = '';
			$.each($('#visionDataDayTabTable tbody tr'),function(index, item, array){
				if(equipNm != $(this).find('td').eq(1).text()){
					equipNm = $(this).find('td').eq(1).text();	
					colorStat = !colorStat;
				}
				
				if(colorStat){
    				$(this).css('background-color','#F2F2F2');
					
        		} else{
        			$(this).css('background-color','#ffffff');
					
            	}
			});
			
			
					
        }        
    });
	visionDataDayTabTable.on('draw.dt', function(){		
		$('#my-spinner').hide();
		
	});
	
	var html3 = '<div class="row">';
	html3 += '<label class="input-label-sm ml-2">수집일</label>';
	html3 += '<div class="form-group input-sub m-0 row">';
	html3 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateFrom3" name="chooseDateFrom3" />';
	html3 += '<button onclick="fnPopUpCalendar(chooseDateFrom3,chooseDateFrom3,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="chooseDateFrom3Calendar" type="button">';
	html3 += '<span class="oi oi-calendar"></span>';
	html3 += '</button>'; 
	html3 += '</div>';
	html3 += '<label class="input-label-sm ml-2">~</label><div class="form-group input-sub m-0 row">';
	html3 += '<input class="form-control" style="width:97px;" type="text" id="chooseDateTo3" name="chooseDateTo3" />';
	html3 += '<button onclick="fnPopUpCalendar(chooseDateTo3,chooseDateTo3,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnChooseDateCalendar" type="button">';
	html3 += '<span class="oi oi-calendar"></span>';
	html3 += '</button>'; 
	html3 += '</div>&nbsp;&nbsp;';	

	html3 += '&nbsp;<button type="button"  class="btn btn-primary ml-2" id="btnRetv3">조회</button>';
	html3 += '</div>';
	
	$('#visionDataDayTabTable_length').html(html3);
	$('#chooseDateFrom3').val(chooseDate1);
	$('#chooseDateTo3').val(chooseDate2);

	 
	//조회 버튼 클릭
	$('#btnRetv').on('click', function() {    	
    	chooseDate1 = $('#chooseDateFrom').val();
  		chooseDate2 = $('#chooseDateTo').val();  		
  		
  		$('#visionDataTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});	

	//조회 버튼 클릭
	$('#btnRetv2').on('click', function() {    	
    	chooseDate1 = $('#chooseDateFrom2').val();
  		chooseDate2 = $('#chooseDateTo2').val();  		
  		
  		$('#visionDataTabTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});

	//조회 버튼 클릭
	$('#btnRetv3').on('click', function() {    	
    	chooseDate1 = $('#chooseDateFrom3').val();
  		chooseDate2 = $('#chooseDateTo3').val();  		
  		
  		$('#visionDataDayTabTable').DataTable().ajax.reload();
  		$('#my-spinner').show();
	});

	$('#tab1').click(function() {
		$('#chooseDateFrom').val(chooseDate1);
  		$('#chooseDateTo').val(chooseDate2);
		$('#visionDataTable').DataTable().ajax.reload();
		$('#lotTab').addClass('d-none');
		$('#dateTab').removeClass('d-none');
		$('#dayTab').addClass('d-none');
	});

	$('#tab2').click(function() {
		$('#chooseDateFrom2').val(chooseDate1);
		$('#chooseDateTo2').val(chooseDate2);
		$('#visionDataTabTable').DataTable().ajax.reload();
		$('#dateTab').addClass('d-none');
		$('#lotTab').removeClass('d-none');
		$('#dayTab').addClass('d-none');
	});
   
	$('#tab3').click(function() {
		$('#chooseDateFrom3').val(chooseDate1);
		$('#chooseDateTo3').val(chooseDate2);
		$('#visionDataDayTabTable').DataTable().ajax.reload();
		$('#dateTab').addClass('d-none');
		$('#lotTab').addClass('d-none');
		$('#dayTab').removeClass('d-none');
	});
   

</script>

</body>
</html>
