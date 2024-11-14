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
				<li class="breadcrumb-item"><a href="#">자재입출고관리</a></li>
				<li class="breadcrumb-item active">원자재수급계획</li>
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
					<div class="row col-sm-6" style="margin-bottom:5px;">
						<label class="input-label-sm mr-1">계획 월</label>
						<input type="text" class="form-control mr-2" id="inWhsDateCal" style="width:65px;"></input>
						<label class="input-label-sm mr-1">재질</label>	    
	    				<select class="custom-select float-left mr-2" id="qutyCd" style="width:100px;"></select>
	    				<button type="button" class="btn btn-primary float-left mr-2" id="btnRetv">조회</button>
	    				<input type="text" class="form-control number-float0 mr-2" id="allInputSetting"  min=0 max=99999 value="0" style="width:100px;" disabled></input>
					<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecuteAll" disabled>전체일괄입력</button>  	
					<button type="button" class="btn btn-primary ml-5" id="btnEquipInputSetting" disabled>특정 자재입력</button>
					<button type="button" class="btn btn-primary ml-5" id="btnEquipInputSetting2" disabled>특정 자재수량입력(일)</button>	
	    			</div>
	    			<div class="col-sm-6" style="margin-bottom:5px;">
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnSave" disabled>저장</button>
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnEdit">수정</button>
	    			</div>
	    		</div>
				<div class="table-responsive first-table" style="padding-bottom: 5px;">
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
<!-- 특정 자재 모달 시작 -->
<div class="modal fade" id="equipInputPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipInputModalLabel">자재별 일괄입력</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<label class="input-label-sm">자재 선택 : </label>
					<select class="custom-select mr-2" id="matrlCd" style="width:120px;"></select>					
					<input type="text" class="form-control number-float0 mr-2" id="equipInputSetting" min=0 max=99999 value="0" style="width:100px;" disabled></input>
					<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecute">입력</button>
				</div>
			</div>
			<div class="modal-footer">
				<!-- <button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button> -->
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 특정 자재 모달 끝 -->

<!-- 특정 자재 모달 시작 -->
<div class="modal fade" id="equipInputPopupModal2" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel2" aria-hidden="true">
	<div class="modal-dialog" style="min-width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipInputModalLabel2">자재별 일괄입력(일)</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<label class="input-label-sm">자재 선택 : </label>
					<select class="custom-select mr-2" id="matrlCd2" style="width:120px;"></select>					
					<input type="text" class="form-control number-float0 mr-2" id="equipInputSetting2" min=0 max=99999 value="0" style="width:100px;" disabled></input>
					<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecute2">입력</button>
				</div>
			</div>
			<div class="modal-footer">
				<!-- <button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button> -->
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 특정 자재 모달 끝 -->

<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'brsc0010';
	let currentHref = 'brsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","원자재수급계획");	
    var inWhsDateCal = "${serverDate}";  
	inWhsDateCal = inWhsDateCal.substring(0,7);
	var temp = true;
	//var aa = 0;
	var dayCount = 0;	//해당 월의 일자 수
	//var dayCount = "${dayCount}";
	//var dayCount = new Array("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30, "31");
	//var dayCount = new Array(); //배열선언
	//for(var i=0;i<31;i++){
	//	dayCount[i]=i+1;
	//}
	//공통코드 시작
	
	//$('#my-spinner').show();
	
    var equipCodeList = new Array();
    var matrlCodeList = new Array();
    var matrlCodeList2 = new Array();
    var qutyList = new Array();
    
    <c:forEach items="${qutyList}" var="info">
	    var json = new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		qutyList.push(json);
    </c:forEach>
    
    <c:forEach items="${matrlCodeList}" var="info">
		var json = new Object();
		json.matrlCd="${info.matrlCd}";
		json.matrlNm="${info.matrlNm}";
		json.baseCd="${info.matrlCd}";
		json.baseCdNm="${info.matrlNm}";
		matrlCodeList.push(json);

			$(document).on('keyup','#${info.matrlCd}count1', function(event) {
				$('#${info.matrlCd}count1').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count1').val()=="") {
					$('#${info.matrlCd}count1').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count2', function(event) {
				$('#${info.matrlCd}count2').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count2').val()=="") {
					$('#${info.matrlCd}count2').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count3', function(event) {
				$('#${info.matrlCd}count3').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count3').val()=="") {
					$('#${info.matrlCd}count3').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count4', function(event) {
				$('#${info.matrlCd}count4').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count4').val()=="") {
					$('#${info.matrlCd}count1').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count5', function(event) {
				$('#${info.matrlCd}count5').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count5').val()=="") {
					$('#${info.matrlCd}count5').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count6', function(event) {
				$('#${info.matrlCd}count6').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count6').val()=="") {
					$('#${info.matrlCd}count6').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count7', function(event) {
				$('#${info.matrlCd}count7').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count7').val()=="") {
					$('#${info.matrlCd}count7').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count8', function(event) {
				$('#${info.matrlCd}count8').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count8').val()=="") {
					$('#${info.matrlCd}count8').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count9', function(event) {
				$('#${info.matrlCd}count9').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count9').val()=="") {
					$('#${info.matrlCd}count9').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count10', function(event) {
				$('#${info.matrlCd}count10').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count10').val()=="") {
					$('#${info.matrlCd}count10').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count11', function(event) {
				$('#${info.matrlCd}count11').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count11').val()=="") {
					$('#${info.matrlCd}count11').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count12', function(event) {
				$('#${info.matrlCd}count12').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count12').val()=="") {
					$('#${info.matrlCd}count12').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count13', function(event) {
				$('#${info.matrlCd}count13').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count13').val()=="") {
					$('#${info.matrlCd}count13').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count14', function(event) {
				$('#${info.matrlCd}count14').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count14').val()=="") {
					$('#${info.matrlCd}count14').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count15', function(event) {
				$('#${info.matrlCd}count15').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count15').val()=="") {
					$('#${info.matrlCd}count15').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count16', function(event) {
				$('#${info.matrlCd}count16').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count16').val()=="") {
					$('#${info.matrlCd}count16').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count17', function(event) {
				$('#${info.matrlCd}count17').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count17').val()=="") {
					$('#${info.matrlCd}count17').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count18', function(event) {
				$('#${info.matrlCd}count18').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count18').val()=="") {
					$('#${info.matrlCd}count18').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count19', function(event) {
				$('#${info.matrlCd}count19').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count19').val()=="") {
					$('#${info.matrlCd}count19').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count20', function(event) {
				$('#${info.matrlCd}count20').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count20').val()=="") {
					$('#${info.matrlCd}count20').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count21', function(event) {
				$('#${info.matrlCd}count21').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count21').val()=="") {
					$('#${info.matrlCd}count21').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count22', function(event) {
				$('#${info.matrlCd}count22').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count22').val()=="") {
					$('#${info.matrlCd}count22').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count23', function(event) {
				$('#${info.matrlCd}count23').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count23').val()=="") {
					$('#${info.matrlCd}count23').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count24', function(event) {
				$('#${info.matrlCd}count24').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count24').val()=="") {
					$('#${info.matrlCd}count24').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count25', function(event) {
				$('#${info.matrlCd}count25').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count25').val()=="") {
					$('#${info.matrlCd}count25').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count26', function(event) {
				$('#${info.matrlCd}count26').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count26').val()=="") {
					$('#${info.matrlCd}count26').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count27', function(event) {
				$('#${info.matrlCd}count27').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count27').val()=="") {
					$('#${info.matrlCd}count27').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count28', function(event) {
				$('#${info.matrlCd}count28').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count28').val()=="") {
					$('#${info.matrlCd}count28').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count29', function(event) {
				$('#${info.matrlCd}count29').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count29').val()=="") {
					$('#${info.matrlCd}count29').val("0");
					
				}
			});
			$(document).on('keyup','#${info.matrlCd}count30', function(event) {
				$('#${info.matrlCd}count30').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count30').val()=="") {
					$('#${info.matrlCd}count30').val("0");
				
				}
			});
			$(document).on('keyup','#${info.matrlCd}count31', function(event) {
				$('#${info.matrlCd}count31').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#${info.matrlCd}count31').val()=="") {
					$('#${info.matrlCd}count31').val("0");
					
				}
			});
    </c:forEach>
  	//공통코드 종료
	var qutyCd = '';
	selectBoxAppend(qutyList, "qutyCd", "", "2");
	selectBoxAppend(matrlCodeList, "matrlCd", "", "2");
	selectBoxAppend(matrlCodeList, "matrlCd2", "", "2");
	
	//월별 일자 생성
	createHeader();
	//createBody();
	
    // 목록
    $.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#productionPlanTable').parent().html();
	let productionPlanTable = monthProductPresentTableFunc();



	$('#inWhsDateCal').val(inWhsDateCal);

	$('#qutyCd').change(function() {
		$('#btnRetv').trigger('click');
	});

	// 보기
    $('#productionPlanTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#productionPlanTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    });

    $('#btnRetv').on('click', function() {
    	qutyCd = $('#qutyCd option:selected').val();
    	if (qutyCd == null || qutyCd == '') {
			toastr.warning("재질을 선택해 주세요!");
			$('#qutyCd').focus();
			return false;
		}
		
    	$('#my-spinner').show();    	
    	
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	$('#allInputSetting').val("0");
    	$("#btnSave").attr("disabled", true);
    	$("#allInputSetting").attr("disabled", true);
    	$("#btnEquipInputExecuteAll").attr("disabled", true);   
    	$('#btnEquipInputSetting').attr('disabled',true);
    	$('#btnEquipInputSetting2').attr('disabled',true);
    	//createHeader();
    	temp = true;
		//$('#productionPlanTable').DataTable().ajax.reload( function () {});
    	$('.first-table').html(monthProductPresentTableOrigin);
        
    	
		createHeader().then(()=>{
		
			productionPlanTable = monthProductPresentTableFunc();      
   			
   		});
		
    });

    $('#btnEdit').on('click', function() {
    	$("#allInputSetting").val("0");    	
    	$("#btnSave").attr("disabled", false); 
    	$("#allInputSetting").attr("disabled", false);
    	$("#btnEquipInputExecuteAll").attr("disabled", false);    
    	$(".number-float0").attr("disabled", false);
    	$(".number-float2").attr("disabled", false);
    	$('#btnEquipInputSetting').attr('disabled',false);
    	$('#btnEquipInputSetting2').attr('disabled',false);
    });

	//특정설비 일괄입력
	$('#btnEquipInputSetting').on('click', function() {
		selectBoxAppend(matrlCodeList, "matrlCd", "", "2");
		$('#equipInputSetting').val("0");
		$('#equipInputPopupModal').modal('show');
    });

	//특정설비 일괄입력
	$('#btnEquipInputSetting2').on('click', function() {
		selectBoxAppend(matrlCodeList, "matrlCd2", "", "2");
		$('#equipInputSetting2').val("0");
		$('#equipInputPopupModal2').modal('show');
    });
    
    //저장
	$('#btnSave').on('click', function() {

		$('#my-spinner').show();
		
		var dataList = new Array();
		$.each($('#productionPlanTable tbody tr'),function(idx, itm){	 		
			var matrlCd =  productionPlanTable.row(this).data().matrlCd;
			var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");
			
			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.matrlCd =  matrlCd;
		 	rowData001.planDate = inWhsDateCal.substring(0,6).replace(/-/g,"");
		 	rowData001.gubunCd = '001';
		 	rowData001.insertTypeCd = "";
		 	//Kg
			rowData001.count1 = removeCommas($('#' + matrlCd + '001count1').val());
			rowData001.count2 = removeCommas($('#' + matrlCd + '001count2').val());
			rowData001.count3 = removeCommas($('#' + matrlCd + '001count3').val());
			rowData001.count4 = removeCommas($('#' + matrlCd + '001count4').val());
			rowData001.count5 = removeCommas($('#' + matrlCd + '001count5').val());
			rowData001.count6 = removeCommas($('#' + matrlCd + '001count6').val());
			rowData001.count7 = removeCommas($('#' + matrlCd + '001count7').val());
			rowData001.count8 = removeCommas($('#' + matrlCd + '001count8').val());
			rowData001.count9 = removeCommas($('#' + matrlCd + '001count9').val());
			rowData001.count10 = removeCommas($('#' + matrlCd + '001count10').val());
			rowData001.count11 = removeCommas($('#' + matrlCd + '001count11').val());
			rowData001.count12 = removeCommas($('#' + matrlCd + '001count12').val());
			rowData001.count13 = removeCommas($('#' + matrlCd + '001count13').val());
			rowData001.count14 = removeCommas($('#' + matrlCd + '001count14').val());
			rowData001.count15 = removeCommas($('#' + matrlCd + '001count15').val());
			rowData001.count16 = removeCommas($('#' + matrlCd + '001count16').val());
			rowData001.count17 = removeCommas($('#' + matrlCd + '001count17').val());
			rowData001.count18 = removeCommas($('#' + matrlCd + '001count18').val());
			rowData001.count19 = removeCommas($('#' + matrlCd + '001count19').val());
			rowData001.count20 = removeCommas($('#' + matrlCd + '001count20').val());
			rowData001.count21 = removeCommas($('#' + matrlCd + '001count21').val());
			rowData001.count22 = removeCommas($('#' + matrlCd + '001count22').val());
			rowData001.count23 = removeCommas($('#' + matrlCd + '001count23').val());
			rowData001.count24 = removeCommas($('#' + matrlCd + '001count24').val());
			rowData001.count25 = removeCommas($('#' + matrlCd + '001count25').val());
			rowData001.count26 = removeCommas($('#' + matrlCd + '001count26').val());
			rowData001.count27 = removeCommas($('#' + matrlCd + '001count27').val());
			rowData001.count28 = removeCommas($('#' + matrlCd + '001count28').val());
			rowData001.count29 = removeCommas($('#' + matrlCd + '001count29').val());
			rowData001.count30 = removeCommas($('#' + matrlCd + '001count30').val());
			rowData001.count31 = removeCommas($('#' + matrlCd + '001count31').val());
			
			rowData001.remainQty = removeCommas($('#' + matrlCd + 'remainQty').val());
			rowData001.sumQty = removeCommas($('#' + matrlCd + 'sumQty').val());
			rowData001.rollRemain = removeCommas($('#' + matrlCd + 'rollRemain').val());
			rowData001.rollSum = removeCommas($('#' + matrlCd + 'rollSum').val());
			dataList.push(rowData001);

			var rowData002 = new Object();
		 	rowData002.menuAuth = menuAuth;
		 	rowData002.matrlCd =  matrlCd;
		 	rowData002.planDate = inWhsDateCal.substring(0,6).replace(/-/g,"");
		 	rowData002.gubunCd = '002';
		 	rowData002.insertTypeCd = "";
		 	//롤수
			rowData002.count1 = removeCommas($('#' + matrlCd + '002count1').val());
			rowData002.count2 = removeCommas($('#' + matrlCd + '002count2').val());
			rowData002.count3 = removeCommas($('#' + matrlCd + '002count3').val());
			rowData002.count4 = removeCommas($('#' + matrlCd + '002count4').val());
			rowData002.count5 = removeCommas($('#' + matrlCd + '002count5').val());
			rowData002.count6 = removeCommas($('#' + matrlCd + '002count6').val());
			rowData002.count7 = removeCommas($('#' + matrlCd + '002count7').val());
			rowData002.count8 = removeCommas($('#' + matrlCd + '002count8').val());
			rowData002.count9 = removeCommas($('#' + matrlCd + '002count9').val());
			rowData002.count10 = removeCommas($('#' + matrlCd + '002count10').val());
			rowData002.count11 = removeCommas($('#' + matrlCd + '002count11').val());
			rowData002.count12 = removeCommas($('#' + matrlCd + '002count12').val());
			rowData002.count13 = removeCommas($('#' + matrlCd + '002count13').val());
			rowData002.count14 = removeCommas($('#' + matrlCd + '002count14').val());
			rowData002.count15 = removeCommas($('#' + matrlCd + '002count15').val());
			rowData002.count16 = removeCommas($('#' + matrlCd + '002count16').val());
			rowData002.count17 = removeCommas($('#' + matrlCd + '002count17').val());
			rowData002.count18 = removeCommas($('#' + matrlCd + '002count18').val());
			rowData002.count19 = removeCommas($('#' + matrlCd + '002count19').val());
			rowData002.count20 = removeCommas($('#' + matrlCd + '002count20').val());
			rowData002.count21 = removeCommas($('#' + matrlCd + '002count21').val());
			rowData002.count22 = removeCommas($('#' + matrlCd + '002count22').val());
			rowData002.count23 = removeCommas($('#' + matrlCd + '002count23').val());
			rowData002.count24 = removeCommas($('#' + matrlCd + '002count24').val());
			rowData002.count25 = removeCommas($('#' + matrlCd + '002count25').val());
			rowData002.count26 = removeCommas($('#' + matrlCd + '002count26').val());
			rowData002.count27 = removeCommas($('#' + matrlCd + '002count27').val());
			rowData002.count28 = removeCommas($('#' + matrlCd + '002count28').val());
			rowData002.count29 = removeCommas($('#' + matrlCd + '002count29').val());
			rowData002.count30 = removeCommas($('#' + matrlCd + '002count30').val());
			rowData002.count31 = removeCommas($('#' + matrlCd + '002count31').val());
			
			rowData002.remainQty = removeCommas($('#' + matrlCd + 'remainQty').val());
			rowData002.sumQty = removeCommas($('#' + matrlCd + 'sumQty').val());
			rowData002.rollRemain = removeCommas($('#' + matrlCd + 'rollRemain').val());
			rowData002.rollSum = removeCommas($('#' + matrlCd + 'rollSum').val());
			dataList.push(rowData002);
			//console.log(rowData001);
		});
		//console.log(dataList);

		$.ajax({
            url: '<c:url value="/br/insertMonthMatrlList"/>',
            type: 'POST',
            data: JSON.stringify(dataList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {
              //  $('#btnAddConfirm').addClass('d-none');
              //  $('#btnAddConfirmLoading').removeClass('d-none');
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                	$("#btnSave").attr("disabled", true);
                	$("#allInputSetting").attr("disabled", true);                	
                	$("#btnEquipInputExecuteAll").attr("disabled", true);   
                	//$('#productionPlanTable').DataTable().ajax.reload( function () {});
                	$('#allInputSetting').val("0");
			    	$("#btnSave").attr("disabled", true);
			    	$("#allInputSetting").attr("disabled", true);
			    	$("#btnEquipInputExecuteAll").attr("disabled", true);
			    	$('#btnEquipInputSetting').attr('disabled',true); 
			    	$('#btnEquipInputSetting2').attr('disabled',true); 
			    	$('.number-float0').attr("disabled", true);
			    	$('.number-float2').attr("disabled", true);
			    	$('#productionPlanTable').DataTable().ajax.reload( function () {});
                	toastr.success(res.message);
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
        
	});

/*     //전체 일괄입력
	$('#btnAllInputSetting').on('click', function() {
		$('#allInputSetting').val("0");
		$('#totalInputPopupModal').modal('show');		
    }); */

    //전체 일괄입력
	$('#btnEquipInputExecuteAll').on('click', function() {
		var allInputSetting = $("#allInputSetting").val().replace(/-/g,"");
		if (allInputSetting == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#allInputSetting').select();
			return false;
		}
		$('#my-spinner').show();
	
		for (var i=0; i<matrlCodeList.length; i++) {
			for (var j=0; j<dayCount; j++) {
				$('#' + matrlCodeList[i].matrlCd + '001count' + (j+1)).val(allInputSetting);			
				$('#' + matrlCodeList[i].matrlCd + '002count' + (j+1)).val(allInputSetting);		
			}
			$('#' + matrlCodeList[i].matrlCd + 'rollRemain').val(allInputSetting);
			$('#' + matrlCodeList[i].matrlCd + 'remainQty').val(allInputSetting);
			$('#' + matrlCodeList[i].matrlCd + 'rollSum').val(allInputSetting);
			$('#' + matrlCodeList[i].matrlCd + 'sumQty').val(allInputSetting);		

		}		
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
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
						//var planHeader = '<th class="text-center" style="vertical-align:middle; min-width:100px;">라인</th>';
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:130px;">자재명</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">전월재고</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">전월재고(롤수)</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적(Kg)</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적(Roll)</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								//planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:100px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:100px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:100px;">' + data[i].countDay + '</th>';
							}
						}
						planHeader += '<th class="text-center sumQty"style="vertical-align:middle; min-width:100px;">생산실재고</th>';
						planHeader += '<th class="text-center sumQty"style="vertical-align:middle; min-width:100px;">생산실재고(롤수)</th>';
						//console.log(planHeader);
						$('#planHeader').html(planHeader);
						$('#planHeader').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});		
					}
				}
			});
		});
    }


    
    //숫자만 입력, 길이, 정수만 입력
    $(document).on('keyup','.number-float0', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109)	) {
			//$('.number-float0').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			
			toastr.warning('양수(+)만 입력해주세요.');
			$(this).val("");
			$(this).val("0");
 			$(this).select();
			event.preventDefault();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}

 		var temp = $(this).val();
 		temp = removeCommas(temp);
		
 		if ($(this).attr("maxlength") < temp.length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat(temp)) {
 			toastr.warning('최대 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat(temp)) {
 			toastr.warning('최소 크기를 초과하였습니다.');
 			$(this).val("0");
 			$(this).select();
 			return false;
		}
		if ( event.which == 110 || event.which == 190 ) {
			toastr.warning('정수만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
		// .개수 세기
		if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        $(this).val(addCommas(temp));
	});

	//숫자만 입력, 길이, 소수점 두자리까지 제한
	$(document).on('keyup','.number-float2', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 190)	) {
			//$('.number-float2').on("blur keyup", function() {
			//	$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			//});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ($(this).val() == "00" || $(this).val() == "") {
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최대 크기를 초과하였습니다.');
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
 			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}

		// .개수 세기
		if ( $(this).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		}
		
 		var _pattern2 = /^\d*[.]\d{3}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
        }
	});
	
    function monthProductPresentTableFunc(){
		let tempTableData  = $('#productionPlanTable').on( 'error.dt', function ( e, settings, techNote, message ) {
			if(techNote == 7) {
				toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
				location.href = "/";
			}
		}).DataTable({
	        dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
					"<'row'<'col-sm-12'tr>>" +
					"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
																		//B
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
			scrollY: '73vh',
			scrollX: true,
			fixedColumns: {
				leftColumns: 2
			},
			ajax: {
	            url: '<c:url value="/br/readMonthPlanListAll"/>',
	            type: 'GET',
	            data: {
	            	'menuAuth'		:		menuAuth,
	            	'planDate'		:		function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},
	            	'qutyCd'		:		function(){return qutyCd;},
	            },
	            /*
	            success : function(res) {
	                console.log(res);
	            }
	            */
	        },
	        columns: [
	        	//{ data: 'equipLineNm', },
	        	{ data: 'matrlNm', },
	        	{ data: 'qutyNm'},
	        	{ data: 'remainQty',
					render: function(data, type, row) {
						let html;					
						return  '<input type="text" class="form-control number-float2" max="999999" min="0" step="0.01" id="'  + row["matrlCd"] + 'remainQty" name="remainQty" value="' + addCommas(data) + '" disabled/></input>';	
						
					}
				},
				{ data: 'rollRemain',
					render: function(data, type, row) {
						let html;					
						return  '<input type="text" class="form-control number-float0" max="9999" min="0" step="1" id="'  + row["matrlCd"] + 'rollRemain" name="rollRemain" value="' + addCommas(data) + '" disabled/></input>';	
						
					}
				},
				{ data: 'countSum',
					render: function(data, type, row) {
						let html;					
						data = parseFloat(data).toFixed(2);
						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
						
					}
				},
				{ data: 'countRollSum',
					render: function(data, type, row) {
						let html;
						data = parseFloat(data).toFixed(0);					
						return html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
						
					}
				},
				{ data: 'count1',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count1" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count1" value="' + addCommas(parseFloat(row['rollCount1']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count2',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count2" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count2" value="' + addCommas(parseFloat(row['rollCount2']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count3',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count3" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count3" value="' + addCommas(parseFloat(row['rollCount3']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count4',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count4" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count4" value="' + addCommas(parseFloat(row['rollCount4']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count5',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count5" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count5" value="' + addCommas(parseFloat(row['rollCount5']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count6',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count6" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count6" value="' + addCommas(parseFloat(row['rollCount6']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count7',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count7" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count7" value="' + addCommas(parseFloat(row['rollCount7']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count8',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count8" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count8" value="' + addCommas(parseFloat(row['rollCount8']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count9',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count9" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count9" value="' + addCommas(parseFloat(row['rollCount9']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count10',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count10" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count10" value="' + addCommas(parseFloat(row['rollCount10']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count11',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count11" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count11" value="' + addCommas(parseFloat(row['rollCount11']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count12',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count12" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count12" value="' + addCommas(parseFloat(row['rollCount12']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count13',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count13" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count13" value="' + addCommas(parseFloat(row['rollCount13']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count14',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count14" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count14" value="' + addCommas(parseFloat(row['rollCount14']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count15',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count15" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count15" value="' + addCommas(parseFloat(row['rollCount15']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count16',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count16" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count16" value="' + addCommas(parseFloat(row['rollCount16']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count17',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count17" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count17" value="' + addCommas(parseFloat(row['rollCount17']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count18',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count18" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count18" value="' + addCommas(parseFloat(row['rollCount18']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count19',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count19" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count19" value="' + addCommas(parseFloat(row['rollCount19']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count20',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count20" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count20" value="' + addCommas(parseFloat(row['rollCount20']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count21',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count21" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count21" value="' + addCommas(parseFloat(row['rollCount21']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count22',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count22" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count22" value="' + addCommas(parseFloat(row['rollCount22']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count23',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count23" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count23" value="' + addCommas(parseFloat(row['rollCount23']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count24',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count24" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count24" value="' + addCommas(parseFloat(row['rollCount24']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count25',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count25" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count25" value="' + addCommas(parseFloat(row['rollCount25']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count26',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count26" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count26" value="' + addCommas(parseFloat(row['rollCount26']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count27',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count27" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count27" value="' + addCommas(parseFloat(row['rollCount27']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count28',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count28" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count28" value="' + addCommas(parseFloat(row['rollCount28']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count29',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count29" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count29" value="' + addCommas(parseFloat(row['rollCount29']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count30',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count30" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count30" value="' + addCommas(parseFloat(row['rollCount30']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'count31',
					render: function(data, type, row) {
						let html;
						html =  '<div class="row_flex">';
						html += '	<input type="text" class="form-control number-float2 " max="99999" min="0" step="0.01" id="' + row["matrlCd"] + '001count31" value="' + addCommas(data) + '" style="width:55px; margin-right:2px;" disabled/></input>';
						html += '	<input type="text" class="form-control number-float0 " max="999" min="0" step="1" id="' + row["matrlCd"] + '002count31" value="' + addCommas(parseFloat(row['rollCount31']).toFixed(0)) + '" style="width:35px;" disabled/></input>';
						html += '</div>';
						return html;
					}
				},
				{ data: 'sumQty',
					render: function(data, type, row) {
						let html;					
						return '<input type="text" class="form-control number-float2" max="999999" min="0" step="0.01" id="' + row["matrlCd"] + 'sumQty" name="sumQty" value="' + addCommas(data) + '" disabled/></input>';
						
					}
				},
				{ data: 'rollSum',
					render: function(data, type, row) {
						let html;					
						return '<input type="text" class="form-control number-float0" max="9999" min="0" step="1" id="' + row["matrlCd"] + 'rollSum" name="rollSum" value="' + addCommas(data) + '" disabled/></input>';
						
					}
				},
	        ],
			
	        columnDefs: [        	
	        	{ targets: [4,5], className: 'text-right-td' },
	        ],      
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
						//$(this).find('th').eq(30).addClass('d-none');
						$(this).find('td').eq(32).addClass('d-none');
					}
					if($('.day28').text()==""){
						//$(this).find('th').eq(31).addClass('d-none');
						$(this).find('td').eq(33).addClass('d-none');
					}
					if($('.day29').text()==""){
						//$(this).find('th').eq(32).addClass('d-none');
						$(this).find('td').eq(34).addClass('d-none');
					}
					if($('.day30').text()==""){
						//$(this).find('th').eq(33).addClass('d-none');
						$(this).find('td').eq(35).addClass('d-none');
					}
					if($('.day31').text()==""){
						//$(this).find('th').eq(34).addClass('d-none');
						$(this).find('td').eq(36).addClass('d-none');
					}
				});
				
				$('#productionPlanTable').rowspan(0);
				$('#productionPlanTable').rowspan(1);
			
				//if (temp) {
				//	toastr.success('조회되었습니다');
				//	temp = false;
				//}

				setTimeout(function() {
					$('#my-spinner').hide();
				}, 1000);

			}
	    });

		 return tempTableData;

 }

    //특정설비 일괄입력
	$('#btnEquipInputExecute').on('click', function() {
		var matrlCd = $("#matrlCd option:selected").val();
		var btnEquipInputExecute = $("#equipInputSetting").val().replace(/,/g,"");
		if (matrlCd == null || matrlCd == "") {
			toastr.warning("자재명을 선택해 주세요!");
			$('#matrlCd').focus();
			return false;
		}
		if (btnEquipInputExecute == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#equipInputSetting').select();
			return false;
		}
		$('#my-spinner').show();
		
		for (var j=0; j<dayCount; j++) {
			$('#' + matrlCd + '001count' + (j+1)).val(btnEquipInputExecute);			
			$('#' + matrlCd + '002count' + (j+1)).val(btnEquipInputExecute);			
		}

		//$('#' + matrlCd + 'rollRemain').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'remainQty').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'rollSum').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'sumQty').val(btnEquipInputExecute);	
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
    });

    //특정설비 일괄입력
	$('#btnEquipInputExecute2').on('click', function() {
		var matrlCd = $("#matrlCd2 option:selected").val();
		var btnEquipInputExecute = $("#equipInputSetting2").val().replace(/,/g,"") / dayCount;
		btnEquipInputExecute = parseFloat(btnEquipInputExecute).toFixed(2);
		if (matrlCd == null || matrlCd == "") {
			toastr.warning("자재명을 선택해 주세요!");
			$('#matrlCd2').focus();
			return false;
		}
		if (btnEquipInputExecute == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#equipInputSetting2').select();
			return false;
		}
		$('#my-spinner').show();
		
		for (var j=0; j<dayCount; j++) {
			$('#' + matrlCd + '001count' + (j+1)).val(btnEquipInputExecute);			
		}

		//$('#' + matrlCd + 'rollRemain').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'remainQty').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'rollSum').val(btnEquipInputExecute);
		//$('#' + matrlCd + 'sumQty').val(btnEquipInputExecute);	
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
    });


</script>

</body>
</html>
