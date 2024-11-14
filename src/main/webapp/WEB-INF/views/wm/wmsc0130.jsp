<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%pageContext.setAttribute("newLineChar", "\n");%>

<%@include file="../layout/body-top.jsp"%>

<!-- .page-wrapper -->
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">생산관리</a></li>
				<li class="breadcrumb-item active">월별 설비가동률</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list" id="left-list">
				<!-- .table-responsive -->
				<div class="row">
					<div class="row col-sm-12" style="margin-bottom:5px;">
						&nbsp;<label class="input-label-sm">계획 월</label>
						<input type="text" class="form-control mr-2" id="inWhsDateCal" style="width:65px;"></input>
	    				<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv">조회</button>	    				
	    			</div>
	    		</div>
				<div class="table-responsive" style="padding-bottom: 5px;">
					<table id="productionPlanTable" class="table table-bordered">
						<%-- <colgroup>
							<col width="5%">
							<col width="10%">
							<col width="7%">
							<col width="8%">
							<col width="6%">
							<col width="8%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="3%">
							<col width="6%">
							<col width="7%">
							<col width="7%">
							<col width="10%">
						</colgroup> --%>
						<thead class="thead-light">
							<tr id="planHeader"></tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<!-- 일별 입력 모달 끝 -->
<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'wmsc0130';
	let currentHref = 'wmsc0130';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","월별 설비가동률");	
	
    var inWhsDateCal = "${serverDate}";  
	inWhsDateCal = inWhsDateCal.substring(0,7);
	var temp = true;
	var dayCount = 0;	//해당 월의 일자 수
	createHeader();
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#productionPlanTable').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();
	$('#inWhsDateCal').val(inWhsDateCal);

	
    $('#btnRetv').on('click', function() {
    	//$('#my-spinner').show();
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	$('#allInputSetting').val("0");
    	$("#btnSave").attr("disabled", true);
    	$("#allInputSetting").attr("disabled", true);
    	$("#btnAllInputSetting").attr("disabled", true);
    	$("#btnEquipInputSetting").attr("disabled", true);
    	temp = true;
    	$('.table-responsive').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
       		monthProductPresentTable = monthProductPresentTableFunc();
        });
    });

	//yyyy-mm 달력
	$('#inWhsDateCal').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});

	
	function createHeader(){
		return new Promise((resolve, reject)=> {
			$.ajax({
				url: '<c:url value="wm/createMonthPlanHeader"/>',
				type: 'GET',  
				async: false,
				data: {
					'menuAuth'	:	menuAuth,
					'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				},
				success: function(res){
					var data = res.data;
					if (res.reuslt="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">설비</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:150px;">합계</th>';
							//planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
							//planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:130px;">' + data[i].countDay + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:130px;">' + data[i].countDay + '<br>가동/작업/가동률' + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:130px;">' + data[i].countDay + '<br>가동/작업/가동률' + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							} else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:130px; colspan="3">' + data[i].countDay + '<br>가동/작업/가동률' + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						$('#planHeader').html(planHeader).promise().done(function(){
							resolve();
						});
					}
				}
			});
		});
    }
    
    function monthProductPresentTableFunc(){
        //console.log("난 테이블이야")
        let tempTableData = $('#productionPlanTable').on( 'error.dt', function ( e, settings, techNote, message ) {
        		if(techNote == 7) {
        			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
        			location.href = "/";
        		}
        	}).DataTable({
        		dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
	        		"<'row'<'col-sm-12'tr>>" +
	        		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B", 
                language: lang_kor,
                paging: false,
                info: true,       
                ordering: false,
                processing: true,
                autoWidth: false,
                scrollX : false,
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '67vh',
        		scrollX: true,
        		fixedColumns: {
        			leftColumns: 2
        		},
        		ajax: {
                    url: '<c:url value="/wm/readEquipOperationBody"/>',
                    type: 'GET',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'planDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
                    },
                    /*
                    success : function(res) {
                        console.log(res);
                    }
                    */
                },
                columns: [
                	{ data: 'equipNm',
                    	render: function(data, type, row) {
                        	if (data == 'A_TOTAL') {
                        		return '총 합계';
                            } else {
                            	return data;
							}
                        	
                        }
                	},

                	//합계
                	{ data: 'percentTotal', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTimeTotal'].toFixed(1) + ' / ' + row['fullWorkTimeTotal'] + ' / ' + row['percentTotal'].toFixed(1) + '%</p>'; } },
                	
        			//{ data: 'workTime1' },
        			//{ data: 'fullWorkTime1' },
        			{ data: 'percent1', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime1'].toFixed(1) + ' / ' + row['fullWorkTime1'] + ' / ' + row['percent1'].toFixed(1) + '%</p>'; } },

        			//{ data: 'workTime2' },
        			//{ data: 'fullWorkTime2' },
        			{ data: 'percent2', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime2'].toFixed(1) + ' / ' + row['fullWorkTime2'] + ' / ' + row['percent2'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime3' },
        			//{ data: 'fullWorkTime3' },
        			{ data: 'percent3', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime3'].toFixed(1) + ' / ' + row['fullWorkTime3'] + ' / ' + row['percent3'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime4' },
        			//{ data: 'fullWorkTime4' },
        			{ data: 'percent4', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime4'].toFixed(1) + ' / ' + row['fullWorkTime4'] + ' / ' + row['percent4'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime5' },
        			//{ data: 'fullWorkTime5' },
        			{ data: 'percent5', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime5'].toFixed(1) + ' / ' + row['fullWorkTime5'] + ' / ' + row['percent5'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime6' },
        			//{ data: 'fullWorkTime6' },
        			{ data: 'percent6', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime6'].toFixed(1) + ' / ' + row['fullWorkTime6'] + ' / ' + row['percent6'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime7' },
        			//{ data: 'fullWorkTime7' },
        			{ data: 'percent7', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime7'].toFixed(1) + ' / ' + row['fullWorkTime7'] + ' / ' + row['percent7'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime8' },
        			//{ data: 'fullWorkTime8' },
        			{ data: 'percent8', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime8'].toFixed(1) + ' / ' + row['fullWorkTime8'] + ' / ' + row['percent8'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime9' },
        			//{ data: 'fullWorkTime9' },
        			{ data: 'percent9', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime9'].toFixed(1) + ' / ' + row['fullWorkTime9'] + ' / ' + row['percent9'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime10' },
        			//{ data: 'fullWorkTime10' },
        			{ data: 'percent10', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime10'].toFixed(1) + ' / ' + row['fullWorkTime10'] + ' / ' + row['percent10'].toFixed(1) + '%</p>'; } },
        			        		
        			//{ data: 'workTime11' },
        			//{ data: 'fullWorkTime11' },
        			{ data: 'percent11', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime11'].toFixed(1) + ' / ' + row['fullWorkTime11'] + ' / ' + row['percent11'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime12' },
        			//{ data: 'fullWorkTime12' },
        			{ data: 'percent12', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime12'].toFixed(1) + ' / ' + row['fullWorkTime12'] + ' / ' + row['percent12'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime13' },
        			//{ data: 'fullWorkTime13' },
        			{ data: 'percent13', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime13'].toFixed(1) + ' / ' + row['fullWorkTime13'] + ' / ' + row['percent13'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime14' },
        			//{ data: 'fullWorkTime14' },
        			{ data: 'percent14', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime14'].toFixed(1) + ' / ' + row['fullWorkTime14'] + ' / ' + row['percent14'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime15' },
        			//{ data: 'fullWorkTime15' },
        			{ data: 'percent15', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime15'].toFixed(1) + ' / ' + row['fullWorkTime15'] + ' / ' + row['percent15'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime16' },
        			//{ data: 'fullWorkTime16' },
        			{ data: 'percent16', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime16'].toFixed(1) + ' / ' + row['fullWorkTime16'] + ' / ' + row['percent16'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime17' },
        			//{ data: 'fullWorkTime17' },
        			{ data: 'percent17', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime17'].toFixed(1) + ' / ' + row['fullWorkTime17'] + ' / ' + row['percent17'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime18' },
        			//{ data: 'fullWorkTime18' },
        			{ data: 'percent18', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime18'].toFixed(1) + ' / ' + row['fullWorkTime18'] + ' / ' + row['percent18'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime19' },
        			//{ data: 'fullWorkTime19' },
        			{ data: 'percent19', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime19'].toFixed(1) + ' / ' + row['fullWorkTime19'] + ' / ' + row['percent19'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime20' },
        			//{ data: 'fullWorkTime20' },
        			{ data: 'percent20', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime20'].toFixed(1) + ' / ' + row['fullWorkTime20'] + ' / ' + row['percent20'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime21' },
        			//{ data: 'fullWorkTime21' },
        			{ data: 'percent21', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime21'].toFixed(1) + ' / ' + row['fullWorkTime21'] + ' / ' + row['percent21'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime22' },
        			//{ data: 'fullWorkTime22' },
        			{ data: 'percent22', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime22'].toFixed(1) + ' / ' + row['fullWorkTime22'] + ' / ' + row['percent22'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime23' },
        			//{ data: 'fullWorkTime23' },
        			{ data: 'percent23', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime23'].toFixed(1) + ' / ' + row['fullWorkTime23'] + ' / ' + row['percent23'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime24' },
        			//{ data: 'fullWorkTime24' },
        			{ data: 'percent24', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime24'].toFixed(1) + ' / ' + row['fullWorkTime24'] + ' / ' + row['percent24'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime25' },
        			//{ data: 'fullWorkTime25' },
        			{ data: 'percent25', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime25'].toFixed(1) + ' / ' + row['fullWorkTime25'] + ' / ' + row['percent25'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime26' },
        			//{ data: 'fullWorkTime26' },
        			{ data: 'percent26', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime26'].toFixed(1) + ' / ' + row['fullWorkTime26'] + ' / ' + row['percent26'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime27' },
        			//{ data: 'fullWorkTime27' },
        			{ data: 'percent27', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime27'].toFixed(1) + ' / ' + row['fullWorkTime27'] + ' / ' + row['percent27'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime28' },
        			//{ data: 'fullWorkTime28' },
        			{ data: 'percent28', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime28'].toFixed(1) + ' / ' + row['fullWorkTime28'] + ' / ' + row['percent28'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime29' },
        			//{ data: 'fullWorkTime29' },
        			{ data: 'percent29', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime29'].toFixed(1) + ' / ' + row['fullWorkTime29'] + ' / ' + row['percent29'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime30' },
        			//{ data: 'fullWorkTime30' },
        			{ data: 'percent30', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime30'].toFixed(1) + ' / ' + row['fullWorkTime30'] + ' / ' + row['percent30'].toFixed(1) + '%</p>'; } },
        			
        			//{ data: 'workTime31' },
        			//{ data: 'fullWorkTime31' },
        			{ data: 'percent31', render: function(data, type, row) { return '<p style="margin-bottom: 0px;">' + row['workTime31'].toFixed(1) + ' / ' + row['fullWorkTime31'] + ' / ' + row['percent31'].toFixed(1) + '%</p>'; } },
        			
                ],
        		//rowsGroup: [ 0,1 ],
                columnDefs: [
                	//{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], render: $.fn.dataTable.render.number( ',' ) },
                	//{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
                    //			,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60
                    //			,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90
                    //			,91,92,93 
                    //			], className: 'text-right-td' },
                	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32], className: 'text-right-td' },
                ],
                //order: [
                //    [ 1, 'asc' ],
                //],
        		buttons: [
        			{
        			    extend: 'copy',
        				title: '생산관리/생산계획 등록',
        			},
        			{
        			    extend: 'excel',
        			    title: '생산관리/생산계획 등록',
        			},
        			{
        			    extend: 'print',
        			    title: '생산관리/생산계획 등록',
        			}
        		],
        		drawCallback:function( settings){
        			$.each($('#productionPlanTable tr'),function(index, item){
        				if($('.day27').text()==""){
        					$(this).find('th').eq(27).addClass('d-none');
        					$(this).find('td').eq(27).addClass('d-none');
        				}
        				if($('.day28').text()==""){
        					$(this).find('th').eq(28).addClass('d-none');
        					$(this).find('td').eq(28).addClass('d-none');
        				}
        				if($('.day29').text()==""){
        					$(this).find('th').eq(29).addClass('d-none');
        					$(this).find('td').eq(29).addClass('d-none');
        				}
        				if($('.day30').text()==""){
        					$(this).find('th').eq(30).addClass('d-none');
        					$(this).find('td').eq(30).addClass('d-none');
        				}
        				if($('.day31').text()==""){
        					$(this).find('th').eq(31).addClass('d-none');
        					$(this).find('td').eq(31).addClass('d-none');
        				}
        				if(index == $('#productionPlanTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        }
        			});
					var colorStat = true;
        			$('#productionPlanTable tbody tr').each(function(index){        			 	
        			 	if(index % 1 == 0) {
        			 		colorStat = !colorStat;
            			}
            			if (colorStat) {
            				$(this).css('background-color','#f2f2f2');
                		} else{
                			$(this).css('background-color','#ffffff');
                    	}

            			if($(this).find('td').eq(0).text() == '총 합계') {
        					$(this).css('background-color','#aed3ec');
        					$(this).css('color','blue');
        			 	}
        			});
        			
        			$('#productionPlanTable').rowspan(0);
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			}
        			
        		}
            });

        return tempTableData;
    }

</script>

</body>
</html>
