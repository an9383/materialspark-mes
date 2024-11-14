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
				<li class="breadcrumb-item active">월별 FP현황(요약)</li>
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
					<div class="row col-sm-6">
						&nbsp;<label class="input-label-sm">계획 월</label>
						<input type="text" class="form-control mr-1" id="inWhsDateCal" style="width:65px;"></input>
	    				<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv">조회</button>
	    			</div>
	    		</div>	    		
				<br>			
				
				<div class="table-responsive first-table" style="padding-bottom:5px;">
					<table id="monthProductPresentTable" class="table table-bordered">						
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
<!-- 메모 모달 시작-->
<div class="modal fade" id="memoPopUpModal" tabindex="-1" role="dialog" data-backdrop="static" aria-labelledby="memoPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog style="min-width:650px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="memoPopUpLabel">메모</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<textarea class="form-control dayText day touch3" style="max-width:100%; height:300px; padding-bottom: 0px; resize:none; font-size: 18px;" id="memo" name="memo" maxlength="400" placeholder="최대 글자 수 400자"></textarea>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6"  id="btnSave" data-dismiss="modal" style="min-width:70px;">저장</button>
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal" style="min-width:70px;">닫기</button>				
			</div>
		</div>
	</div>
</div>
<!-- 메모 모달 종료-->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'wmsc0120';
	let currentHref = 'wmsc0120';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","월별 FP현황(요약)");

	$('#my-spinner').show();
	
    var inWhsDateCal =  "${serverDate}";
	inWhsDateCal = inWhsDateCal.substring(0,7);
	var temp = true;
	var sum1 = 0;
	var sum2 = 0;
	var sum3 = 0;
	var sum4 = 0;

	var equipCd = '';
	var planDate = '';
	var countNm = '';
	//공통코드 시작
	
    var equipCodeList = new Array();
    <c:forEach items="${equipCodeAdmList}" var="info">
		var json = new Object();
		json.baseCd="${info.equipCd}";
		json.baseCdNm="${info.equipNm}";
		equipCodeList.push(json);
    </c:forEach>
  	//공통코드 종료
	
	//월별 일자 생성
	createHeader();
	//createBody();
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#monthProductPresentTable').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();


	
    	
	//var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">계획 월</label><input type="text" class="form-control mr-1" id="inWhsDateCal" style="width:65px;">';
    //	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
	//$('#purchaseOutputInfoTable_length').html(html1);
	$('#inWhsDateCal').val(inWhsDateCal);

	// 보기
    $('#monthProductPresentTable tbody').on('click', 'tr', function () {
       /*  if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#monthProductPresentTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        } */
    });

    $('#btnRetv').on('click', function() {

    	$('#my-spinner').show();
    	
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	$('#inputSetting').val("0");
    	$("#inputSetting").attr("disabled", true);
    	$("#btnInputSetting").attr("disabled", true);

    	temp = true;
    	
    	$('.first-table').html(monthProductPresentTableOrigin);    
    	
    	createHeader().then(()=>{
			
       		monthProductPresentTable = monthProductPresentTableFunc();       		
        });

		
    });

    $('#btnEdit').on('click', function() {
    	$("#inputSetting").val("0");    	
    	$("#inputSetting").attr("disabled", false);
    	$("#btnInputSetting").attr("disabled", false);
    	$(".number-float0").attr("disabled", false);
    });
    
	//yyyy-mm 달력
	$('#inWhsDateCal').monthpicker({pattern: 'yyyy-mm', 
	    selectedYear: 2020,
	    startYear: 1900,
	    finalYear: 2212
	});

	function createHeader(){
		return new Promise((resolve, reject)=> {
			//console.log('create header');
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
						var data = res.data;
						//var planHeader = '<th class="text-center" style="vertical-align:middle; min-width:100px;">라인</th>';
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">재질</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">기종</th>';
							
							//planHeader += '<th class="text-center"style="vertical-align:middle; min-width:120px;">구분</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적</th>';
						
						for (var i=0; i<data.length; i++) {
							//console.log(i);
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center day' + (i+1) + ' d-none" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						//console.log(planHeader);
						$('#planHeader').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});						
					}
				},
				complete : function(){
				}
			});
		});
    }



    function monthProductPresentTableFunc(){
        //console.log("난 테이블이야")
        let tempTableData = $('#monthProductPresentTable').on( 'error.dt', function ( e, settings, techNote, message ) {
    		if(techNote == 7) {
    			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
    			location.href = "/";
    		}
    	}).DataTable({
            dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    				"<'row'<'col-sm-12'tr>>" +
    				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>B",        
    		destory : true,
    		language: lang_kor,
            paging: false,
            info: true,
            ordering: false,
            processing: true,
            autoWidth: false,
            scrollX : false,
            pageLength: false,
            searching: false,
          	//header 고정
    		scrollY: '71vh',
    		scrollX: true,
    		fixedColumns: {
    			leftColumns: 3
    		},
    		ajax: {
                url: '<c:url value="/wm/readMonthProductPresentBody2"/>',
                type: 'POST',
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
            	{ data: 'qutyNm' ,
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				} else {
    						return data;
    					}
     					
    				}
				},        
                { data: 'goodsNm' ,
    				render: function(data, type, row) {    					
     					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '-';
         				} else{
         					return data;
             			}
    				}
				},
                
               /*  { data: 'gubun',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					 if( row["gubun"] == "D" ){
    						return html = '<p style="font-weight:bold; margin-bottom:0px;">생산수량(주간)</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="font-weight:bold; margin-bottom:0px;">생산수량(야간)</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량"){        					
    						return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    					} else {
    						return data;
    					}
     					
    				}
    			}, */
    			{ data: 'countSum',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					 if( row["gubun"] == "D" ){
     						return html = '<p style="font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
     					} else if( row["gubun"] == "N" ){
     						return html = '<p style="font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
     					} else if( row["gubun"] == "당일 합계" ){
     						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
     					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량"){        					
     						if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
     					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
     						return addCommas(data);
     					}
    				}
    			},
    			{ data: 'count1',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				} 
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count1">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					}  else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count2',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count2">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count3',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count3">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count4',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count4">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count5',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count5">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count6',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count6">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count7',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count7">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count8',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count8">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count9',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count9">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count10',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count10">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count11',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count11">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count12',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count12">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count13',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count13">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count14',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count14">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count15',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count15">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count16',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count16">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count17',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count17">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count18',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count18">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count19',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count19">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count20',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count20">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count21',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count21">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count22',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count22">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count23',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count23">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count24',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count24">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count25',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count25">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count26',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count26">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count27',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count27">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count28',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count28">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count29',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count29">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count30',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count30">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
    			{ data: 'count31',
    				render: function(data, type, row) {
    					let html;
    					if(row["goodsCd"]=='ZZZZZZZZ0'){
     						return '';
         				}
    					if( row["gubun"] == "D" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "N" ){
    						return html = '<p style="margin-bottom:0px;font-weight:bold;">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "당일 합계" ){
    						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;" name="count31">' + addCommas(data) + '</p>';
    					} else if( row["gubun"] == "확정 차이량" ||  row["gubun"] == "운영 차이량" ){
        					if(data > -1 ){
        						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
            				} else{
            					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>'
                			}
    						
    					} else if( row["gubun"] == "가동률 (capa)" ){
    						return html = data + '%';
    					} else if( row["gubun"] == "CAPA" ){
    						return html = addCommas(data);
    					} else if( row["gubun"] == "확정판 달성률(%)" ||  row["gubun"] == "운용계획 당성 률(%)" ||  row["gubun"] == "CAPA 가동률(%)"){        					
    						return html =  data + '%';
    					} else {
    						return addCommas(data);
    					}
    				}
    			},
            ],
    		//rowsGroup: [ [0] ],
            columnDefs: [
            	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], render: $.fn.dataTable.render.number( ',' ) },
            	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
            ],
            //order: [
            //    [ 1, 'asc' ],
            //],
    		buttons: [
    			{
    			    extend: 'copy',
    				title: '생산관리/월별 FP현황(설비별)',
    			},
    			{
    			    extend: 'excel',
    			    title: '생산관리/월별 FP현황(설비별)',
    			},
    			{
    			    extend: 'print',
    			    title: '생산관리/월별 FP현황(설비별)',
    			}
    		],
    		drawCallback:function(){

    			var colorStat = false;
    			var equipCd = '';
    			$('#monthProductPresentTable').rowspan2(0);
    			$.each($('#monthProductPresentTable tbody tr'),function(index, item){
    				if($('.day27').text()==""){
    					$(this).find('th').eq(29).addClass('d-none');
    					$(this).find('td').eq(29).addClass('d-none');
    				}
    				if($('.day28').text()==""){
    					$(this).find('th').eq(30).addClass('d-none');
    					$(this).find('td').eq(30).addClass('d-none');
    				}
    				if($('.day29').text()==""){
    					$(this).find('th').eq(31).addClass('d-none');
    					$(this).find('td').eq(31).addClass('d-none');
    				}
    				if($('.day30').text()==""){
    					$(this).find('th').eq(32).addClass('d-none');
    					$(this).find('td').eq(32).addClass('d-none');
    				}
    				if($('.day31').text()==""){
    					$(this).find('th').eq(33).addClass('d-none');
    					$(this).find('td').eq(33).addClass('d-none');
    				}

    				if(index == $('#monthProductPresentTable').DataTable().data().count() - 1){
                    	$('#my-spinner').hide();
                    }    		
    				$(this).find('td').eq(1).css('font-weight','bold'); 	

    				if($(this).find('td').eq(0).text() == 'AL') {
    					$(this).css('background-color','#ddebf7');    		
    			 	}		
    				if($(this).find('td').eq(0).text() == '' && $(this).find('td').eq(1).text() == 'AL합계') {
    					$(this).css('background-color','#b1d2ed');   
    			 	}	
    				if($(this).find('td').eq(0).text() == 'Nicu') {
    					$(this).css('background-color','#fce4d6');    
    			 	}
    				if($(this).find('td').eq(0).text() == '' && $(this).find('td').eq(1).text() == 'NICU 합계') {
    					$(this).css('background-color','#f9cbb1');    	
    			 	}		
    				if($(this).find('td').eq(1).text() == '변경운영계획 Total' || $(this).find('td').eq(1).text() == '확정판 계획 Total') {
    					$(this).css('background-color','#ffffef');    					
    			 	}

    				if($(this).find('td').eq(1).text() == '확정판 계획대비 차이수량') {
    					$(this).find('td').eq(1).css('color','#5860fe');    
    									
    			 	}
    				if($(this).find('td').eq(1).text() == '변경운영계획대비 차이수량') {
    					$(this).find('td').eq(1).css('color','#7f99ff');    	
    			 	}
    				if($(this).find('td').eq(1).text() == 'CAPA') {
    					$(this).css('background-color','#ffffcc');    		
    					$(this).find('td').eq(1).css('color','blue');    	
    			 	}
    				if($(this).find('td').eq(1).text() == '확정판 계획수량') {
    					$(this).css('background-color','#d9e1f2');
    							
    			 	}
    				if($(this).find('td').eq(1).text() == '확정판 계획수량 차이수량') {
    					$(this).css('background-color','#fff2cc');
    					$(this).find('td').eq(1).css('color','#5860fe');    
    			 	}
    				if($(this).find('td').eq(1).text() == '운용계획대비 차이수량') {
    					$(this).css('background-color','#d9d9d9');
    					$(this).find('td').eq(1).css('color','#7F99FF');    
    			 	}
    				if($(this).find('td').eq(1).text() == '확정판 달성률(%)') {
    					$(this).css('background-color','#e2efda');
    					$(this).find('td').eq(1).css('color','#5860fe');    
    			 	}		
    				if($(this).find('td').eq(1).text() == '운용계획 달성률(%)') {
    					$(this).css('background-color','#e2efda');
    					$(this).find('td').eq(1).css('color','#7F99FF');    
    			 	}	
    				if($(this).find('td').eq(1).text() == 'CAPA 가동률(%)') {    		
    					$(this).find('td').eq(1).css('color','blue');    
    			 	}						
    			 	
    			});
    			 
    			
    			
    			if (temp) {
    				toastr.success('조회되었습니다');
    				temp = false;
    			}

    			/* setTimeout(function() {
    				$('#my-spinner').hide();
    			}, 2000); */
    			
    		}
        });

        return tempTableData;
    }

  
    
   /*  $(document).on('dblclick','#monthProductPresentTable tbody tr td',function(){

        if(monthProductPresentTable.row(this).data().gubun == '당일 합계' && monthProductPresentTable.row(this).data().equipCd != '111111'){
        	equipCd = monthProductPresentTable.row(this).data().equipCd;
        	planDate = monthProductPresentTable.row(this).data().planDate;    	
        	countNm = $(this).find('p').attr('name');
        	var day = countNm.substring(5);        	
        	planDate = planDate + day.padStart(2,'0');

        	$('#memo').val("");
        	
        	$.ajax({
    	   		url: '<c:url value="wm/memoDataList"/>',
    			type: 'GET',
    			async: false,
    			data: {
    				'menuAuth'	:	menuAuth,
    				'equipCd'	:	function(){return equipCd;},
    				'planDate'	:	function(){return planDate;},
    			},
    			success: function(res){
    				var data = res.data;
    				if (res.reuslt="ok"){	
        				if(data != null){
        					$('#memo').val(data.memo);
            			}				
    					
    				}    				
    			}
    		});
        	
        	$('#memoPopUpModal').modal('show');
        }
    	
    	
		
    }); */

    $('#btnSave').on('click',function(){    
   		$.ajax({
	   		url: '<c:url value="wm/createMemo"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'equipCd'	:	function(){return equipCd;},
				'planDate'	:	function(){return planDate;},
				'memo'		:	$('#memo').val(),
			},
			success: function(res){
				var data = res.data;
				if (res.reuslt="ok"){					
					toastr.success("저장되었습니다.");  			
				}
				$('#memoPopUpModal').modal('hide');
			}
		});
    });

    

	//function createBody(){
	//	$.ajax({
	//   		url: '<c:url value="wm/createMonthPlanBody"/>',
	//		type: 'POST',
	//		async: false,
	//		data: {
	//			'menuAuth'	:	menuAuth,
	//			'planDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
	//		},
	//		success: function(res){
	//			var data = res.data;
	//			if (res.reuslt="ok"){
	//				var emtpy = res.emtpy;					//등록 여부
	//				var lengthOfMonth = res.lengthOfMonth;	//해당 월의 최대일자
	//				var data = res.data;
	//				toastr.success("ok222~");
	//		
	//				//console.log(data);
	//				//조회된 데이터가 없을 경우
	//				if (emtpy == "yes"){
	//					var planBody = "";
	//					for (var i=0; i<data.length; i++) {
	//						
	//						planBody += '<th rowspan="3" class="text-center" style="vertical-align:middle;"></th>';
	//						planBody += '<tr>';
	//						planBody += 	'<td rowspan="3">' + data[i].equipNm + '</td>';
	//						planBody += 	'<td>확정계획수량</td>';
	//						planBody += 	'<td>' + data[i].decideSum + '</td>';
    //
	//						for (var j=0; j<lengthOfMonth; j++){
	//							planBody += '<td>' + data[i].decideCount1 + '</td>';
	//						}
	//						
	//						
	//						planBody += '</tr>';
	//						planBody += '<tr>';
	//						planBody += 	'<td>운영계획수량</td>';
	//						planBody += 	'<td>' + data[i].opeatrSum + '</td>';
	//						for (var j=0; j<lengthOfMonth; j++){
	//							planBody += '<td>' + i+1 + '</td>';
	//						}
	//						planBody += '</tr>';
	//						planBody += '<tr>';
	//						planBody += 	'<td>차이</td>';
	//						planBody += 	'<td>차이 누적</td>';
	//						for (var j=0; j<lengthOfMonth; j++){
	//							planBody += '<td>' + i+1 + '</td>';
	//						}
	//						planBody += '</tr>';
	//					}
	//					
	//					$('#planBody').html(planBody);
    //
    //
    //
	//				//조회된 데이터가 있을 경우
	//				} else {
    //
	//				}
    //
	//			
	//				
	//				
	//			}
	//		}
	//	});
    //}
	
</script>

</body>
</html>
