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
				<li class="breadcrumb-item active">FP일지</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
		<div class="container-fluid" id="main">
			<div class="row table-wrap-hid">	
				<!--======================== .left-list ========================-->
				<div class="left-list" id="left-list">
					<div class="card">	
						
						<div class="row">
							 <div class="col-sm-12" style="margin-bottom:5px;">
								 <div class="row">
								 &nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label-sm">일자</label>
								 
								 	<input type="date" class="form-control"  id="chooseDateTo">	
								
								 &nbsp;&nbsp;				
								 <button type="button" class="btn btn-primary" id="btnRetv">조회</button>
								 </div>
							 </div>
							
						<div class="col-sm-6">
							
							<table class="table table-bordered" style="margin-top:6px;">
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th colspan="2">전체 (<span id="month">${month}</span>월)</th>
										<th>누적실적</th>
										<th><span id="monthDay">${yesterday}</span>일 생산</th>
									</tr>
								</thead>
								<tbody id="tbodyMain">
								
								</tbody>
							</table>
							
						</div>
						<div class="col-sm-6">
						<table id="fpDailyTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th>납품처</th>
										<th>기종명</th>
										<th><span id="month2">${month}</span>월 계획</th>	
										<th>누적실적</th>								
										<th><span id="month3">${month}</span>월<span id="monthDay2">${day}</span>일</th>		
										<th>진척률(%)</th>	
									</tr>
								</thead>
								<tfoot id="tfoot">
									<tr>
										<td colspan="2" id="">Total</td>										
										<td id ="sum1"></td>
										<td id ="sum2"></td>
										<td id ="sum3"></td>
										<td id ="sum4"></td>
									</tr>
								</tfoot>
						</table>
						</div>
						</div>
                     	<!-- /.table-responsive -->
                    </div>
                    <!-- <button type="button" class="btn btn-success float-right">Excel</button> -->
				</div><!-- /.left-list -->		
				
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->

<%@include file="../layout/bottom.jsp" %>

<script>
	
	let menuAuth = 'wmsc0250';
	let currentHref = 'wmsc0250';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","FP일지");


	var serverDate = "${serverDate}";
	var chooseDateFrom = "${serverDateFrom}";   
	var chooseDateTo = "${serverDate}";

	$('#chooseDateTo').val(chooseDateTo);	
	dataLoad();
	//$('#btnRetv').trigger('click');
	 $.fn.dataTable.ext.errMode = 'none';
		let fpDailyTable = $('#fpDailyTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",        
	        language: lang_kor,
	        paging: false,
	        info: false,
	        searching : false,
	        ordering: false,
	        processing: true,
	        autoWidth: false,
	        scrollX : false,	   
	        lengthChange : false,
	        pageLength: 10000,
	        ajax: {
	            url: '<c:url value="/wm/fpDailyList3"/>',
	            type: 'POST',
	            data: {
	            	'menuAuth'	 : menuAuth,
		           	'chooseDateTo': function() { return chooseDateTo.replace(/-/g, ''); },        	
		         		           	 
	            },	           
	        },	       
	        columns: [
	        	{ data: 'dealCorpNm'},
	            { data: 'gijongNm'},
	            { data: 'poQty',
	            	render: function(data, type, row) {	                			
	            		var result = data;               			
						if(data != 0 && data != null){
							result = parseFloat(data).toFixed(0);
							result = addCommas(result);
						} else{
							result = '0';
						}
						return result;
						
					}
				 },
				{ data: 'sumOutputCnt',
	            	render: function(data, type, row) {	                			
	            		var result = data;               			
						if(data != 0 && data != null){
							result = parseFloat(data).toFixed(0);
							result = addCommas(result);
						} else{
							result = '0';
						}
						return result;
						
					}
				 },
		        { data: 'outputCnt',
	            	render: function(data, type, row) {	 
	            		var result = data;               			
						if(data != 0 && data != null){
							result = parseFloat(data).toFixed(0);
							result = addCommas(result);
						} else{
							result = '0';
						}
						return result;
					}
				 },
				 { data: 'maxValue',
		            	render: function(data, type, row) {	 
		            		var result = data;               			
							if(data != 0 && data != null){
								result = parseFloat(data).toFixed(1);
								result = result + '%';
							} else{
								result = '0%';
							}
							return result;
						}
					 },
	       
	        ],
	        columnDefs: [
	        	{ targets: [2,3,4,5], render: $.fn.dataTable.render.number( ',' ) },
	        	{ targets: [2,3,4,5], className: 'text-right-td' },
	        ],
	        rowsGroup: ['ggg:name'],
	       
	        drawCallback: function () {

		        
				//전역변수들
				var sum1 = 0;
				var sum2 = 0;
				var sum3 = 0;
				var sum4 = 0;
				
	        	sum1 = ($('#fpDailyTable').DataTable().column(2,{ page: 'all'} ).data().sum());
				sum2 = ($('#fpDailyTable').DataTable().column(3,{ page: 'all'} ).data().sum());
				sum3 = ($('#fpDailyTable').DataTable().column(4,{ page: 'all'} ).data().sum());
				sum4 = sum2*100/sum1;

				$('#sum1').text(addCommas(sum1));
				$('#sum2').text(addCommas(sum2));
				$('#sum3').text(addCommas(sum3));
				$('#sum4').text(parseFloat(sum4).toFixed(2) + '%');

	        }
	});

	$('#btnRetv').on('click',function(){
		$('#my-spinner').show();
		chooseDateTo = $('#chooseDateTo').val().replace(/-/g,"");
		var date = new Date($('#chooseDateTo').val());	
		var yesterDate = new Date(date.setDate(date.getDate()- 1));
		yesterDate = moment(yesterDate).format('YYYY-MM-DD');		
		var day = yesterDate.split('-');
		$('#month').text(day[1]);
		$('#monthDay').text(day[2]);
		
		
		
		dataLoad();
		$('#fpDailyTable').DataTable().ajax.reload(
				function(){
					var day2 = $('#chooseDateTo').val().split('-');
					$('#month2').text(day2[1]);
					$('#month3').text(day2[1]);
					$('#monthDay2').text(day2[2]);
					$('#my-spinner').hide();
				});
	});
		
	function dataLoad(){
			return new Promise((resolve, reject)=> {
				$.ajax({
					url: '<c:url value="wm/fpDailyList"/>',
					type: 'POST',  
					async: false,
					data: {
						'menuAuth'			:	menuAuth,						
						'chooseDateTo'		:	function(){return chooseDateTo.replace(/-/g,"");},
					},
					success: function(res){
						var data = res.data;
						if (res.result="ok"){
							var data = res.data;
							var planHeader = '';
							for (var i=0; i<data.length; i++) {								
								planHeader += '<tr>';
								if(i == 0 || i == 1){
									planHeader += '<td colspan="2">'+ data[i].gubunNm +'</td>';
								} 
								if(i == 2)
								{
									planHeader += '<td rowspan="2">'+ data[i].gubunNm +'</td>';
									planHeader += '<td>'+ data[i].goodsCd +'</td>';
								}
								if(i == 3)
								{								
									planHeader += '<td>'+ data[i].goodsCd +'</td>';
								}								
								if(i == 4){
									planHeader += '<td colspan="2">'+ data[i].gubunNm +'</td>';
								}
								if(i == 5)
								{
									planHeader += '<td rowspan="2">'+ data[i].gubunNm +'</td>';
									planHeader += '<td>'+ data[i].goodsCd +'</td>';
								} 
								if(i == 6)
								{								
									planHeader += '<td>'+ data[i].goodsCd +'</td>';
								}
								var sumOutputCnt = (data[i].sumOutputCnt != null) ? (data[i].sumOutputCnt) : "0";
								var outputCnt = (data[i].outputCnt != null) ? (data[i].outputCnt) : "0";
								
								planHeader += '<td class="text-right">'+ addCommas(sumOutputCnt) +'</td>';
								planHeader += '<td class="text-right">'+ addCommas(outputCnt) +'</td>';							
								planHeader += '</tr>';								
							}			
							$('#tbodyMain').html(planHeader).promise().done(function(){								
								resolve();
							});
						}
					}
				});
			});		
	    }

	
	

</script>

</body>
</html>