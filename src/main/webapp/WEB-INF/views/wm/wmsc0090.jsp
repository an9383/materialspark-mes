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
				<li class="breadcrumb-item active">월별 생산계획등록</li>
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
						&nbsp;<label class="input-label-sm">계획 월</label>
						<input type="text" class="form-control mr-1" id="inWhsDateCal" style="width:65px;"></input>
	    				<button type="button" class="btn btn-primary float-left mr-1" id="btnRetv">조회</button>	    				
	    				<button type="button" class="btn btn-primary ml-5" id="btnAllInputSetting" disabled>전체 일괄입력</button>
	    				<button type="button" class="btn btn-primary ml-5" id="btnEquipInputSetting" disabled>특정 설비&일자 입력</button>
	    				<button type="button" class="btn btn-primary ml-5 d-none" id="btnDayInputSetting" disabled>특정 일별 입력</button>
	    			</div>
	    			<div class="col-sm-6" style="margin-bottom:5px;">
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnSave" disabled>저장</button>
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnEdit">수정</button>
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
<!-- 특정 설비입력 모달 시작 -->
<div class="modal fade" id="equipInputPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:750px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipInputModalLabel">설비&일자별 일괄입력</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">
					<label class="input-label-sm">설비 선택 : </label>
					<select class="custom-select mr-2" id="equipCd" style="width:120px;"></select>
					<label class="input-label-sm">날짜 : </label>
					<select class="custom-select mr-2" id="dayEquipInputAll" style="width:120px;"></select>
					&nbsp;
					<label class="input-label-sm">구분 : </label>
					<select class="custom-select mr-2" id="totalInput" style="width:120px;"></select>
					<input type="text" class="form-control mr-2" id="equipInputSetting" min=0 max=99999 value="0" style="width:100px;"></input>
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
<!-- 특정 설비입력 모달 끝 -->
<!-- 일괄입력 모달 시작 -->
<div class="modal fade" id="totalInputPopupModal" tabindex="-1" role="dialog" aria-labelledby="totalPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="totalInputModalLabel">전체 일괄입력</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">					
					<label class="input-label-sm">구분 : </label>
					<select class="custom-select mr-2" id="totalInputAll" style="width:120px;"></select>
					&nbsp;
	    			<input type="text" class="form-control mr-2" id="allInputSetting"  min=0 max=99999 value="0" style="width:100px;" disabled></input>
					<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecuteAll">일괄입력</button>
				</div>
			</div>
			<div class="modal-footer">
				<!--<button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button>-->
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 일괄입력 모달 끝 -->
<!-- 일별 입력 모달 시작 -->
<!-- <div class="modal fade" id="dayInputPopupModal" tabindex="-1" role="dialog" aria-labelledby="dayPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="dayInputModalLabel">특정 일별 입력</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">					
					<label class="input-label-sm">날짜 : </label>
					<select class="custom-select mr-2" id="dayInputAll" style="width:120px;"></select>
					&nbsp;
					<label class="input-label-sm">구분 : </label>
					<select class="custom-select mr-2" id="dayInput" style="width:120px;"></select>
	    			<input type="text" class="form-control mr-2" id="dayInputSetting"  min=0 max=99999 value="0" style="width:100px;"></input>
					<button type="button" class="btn btn-primary mr-2" id="btnDayInputExecuteAll">입력</button>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button>
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div> -->
<!-- 일별 입력 모달 끝 -->
<%@include file="../layout/bottom.jsp"%>

<script>

	let menuAuth = 'wmsc0090';
	let currentHref = 'wmsc0090';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","월별 생산계획등록");	
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
	
	$('#my-spinner').show();

    var equipCodeList = new Array();
    
    <c:forEach items="${equipCodeAdmList}" var="info">
		var json = new Object();
		json.equipCd="${info.equipCd}";
		json.equipNm="${info.equipNm}";
		equipCodeList.push(json);

			$(document).on('keyup','#001${info.equipCd}count1', function(event) {
				$('#002${info.equipCd}count1').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count1').val()=="" || $('#002${info.equipCd}count1').val()=="00") {
					$('#001${info.equipCd}count1').val("0");
					$('#002${info.equipCd}count1').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count2', function(event) {
				$('#002${info.equipCd}count2').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count2').val()=="" || $('#002${info.equipCd}count2').val()=="00") {
					$('#001${info.equipCd}count2').val("0");
					$('#002${info.equipCd}count2').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count3', function(event) {
				$('#002${info.equipCd}count3').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count3').val()=="" || $('#002${info.equipCd}count3').val()=="00") {
					$('#001${info.equipCd}count3').val("0");
					$('#002${info.equipCd}count3').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count4', function(event) {
				$('#002${info.equipCd}count4').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count4').val()=="" || $('#002${info.equipCd}count4').val()=="00") {
					$('#001${info.equipCd}count1').val("0");
					$('#002${info.equipCd}count4').val("0")
				}
			});
			$(document).on('keyup','#001${info.equipCd}count5', function(event) {
				$('#002${info.equipCd}count5').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count5').val()=="" || $('#002${info.equipCd}count5').val()=="00") {
					$('#001${info.equipCd}count5').val("0");
					$('#002${info.equipCd}count5').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count6', function(event) {
				$('#002${info.equipCd}count6').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count6').val()=="" || $('#002${info.equipCd}count6').val()=="00") {
					$('#001${info.equipCd}count6').val("0");
					$('#002${info.equipCd}count6').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count7', function(event) {
				$('#002${info.equipCd}count7').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count7').val()=="" || $('#002${info.equipCd}count7').val()=="00") {
					$('#001${info.equipCd}count7').val("0");
					$('#002${info.equipCd}count7').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count8', function(event) {
				$('#002${info.equipCd}count8').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count8').val()=="" || $('#002${info.equipCd}count8').val()=="00") {
					$('#001${info.equipCd}count8').val("0");
					$('#002${info.equipCd}count8').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count9', function(event) {
				$('#002${info.equipCd}count9').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count9').val()=="" || $('#002${info.equipCd}count9').val()=="00") {
					$('#001${info.equipCd}count9').val("0");
					$('#002${info.equipCd}count9').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count10', function(event) {
				$('#002${info.equipCd}count10').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count10').val()=="" || $('#002${info.equipCd}count10').val()=="00") {
					$('#001${info.equipCd}count10').val("0");
					$('#002${info.equipCd}count10').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count11', function(event) {
				$('#002${info.equipCd}count11').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count11').val()=="" || $('#002${info.equipCd}count11').val()=="00") {
					$('#001${info.equipCd}count11').val("0");
					$('#002${info.equipCd}count11').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count12', function(event) {
				$('#002${info.equipCd}count12').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count12').val()=="" || $('#002${info.equipCd}count12').val()=="00") {
					$('#001${info.equipCd}count12').val("0");
					$('#002${info.equipCd}count12').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count13', function(event) {
				$('#002${info.equipCd}count13').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count13').val()=="" || $('#002${info.equipCd}count13').val()=="00") {
					$('#001${info.equipCd}count13').val("0");
					$('#002${info.equipCd}count13').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count14', function(event) {
				$('#002${info.equipCd}count14').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count14').val()=="" || $('#002${info.equipCd}count14').val()=="00") {
					$('#001${info.equipCd}count14').val("0");
					$('#002${info.equipCd}count14').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count15', function(event) {
				$('#002${info.equipCd}count15').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count15').val()=="" || $('#002${info.equipCd}count15').val()=="00") {
					$('#001${info.equipCd}count15').val("0");
					$('#002${info.equipCd}count15').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count16', function(event) {
				$('#002${info.equipCd}count16').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count16').val()=="" || $('#002${info.equipCd}count16').val()=="00") {
					$('#001${info.equipCd}count16').val("0");
					$('#002${info.equipCd}count16').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count17', function(event) {
				$('#002${info.equipCd}count17').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count17').val()=="" || $('#002${info.equipCd}count17').val()=="00") {
					$('#001${info.equipCd}count17').val("0");
					$('#002${info.equipCd}count17').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count18', function(event) {
				$('#002${info.equipCd}count18').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count18').val()=="" || $('#002${info.equipCd}count18').val()=="00") {
					$('#001${info.equipCd}count18').val("0");
					$('#002${info.equipCd}count18').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count19', function(event) {
				$('#002${info.equipCd}count19').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count19').val()=="" || $('#002${info.equipCd}count19').val()=="00") {
					$('#001${info.equipCd}count19').val("0");
					$('#002${info.equipCd}count19').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count20', function(event) {
				$('#002${info.equipCd}count20').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count20').val()=="" || $('#002${info.equipCd}count20').val()=="00") {
					$('#001${info.equipCd}count20').val("0");
					$('#002${info.equipCd}count20').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count21', function(event) {
				$('#002${info.equipCd}count21').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count21').val()=="" || $('#002${info.equipCd}count21').val()=="00") {
					$('#001${info.equipCd}count21').val("0");
					$('#002${info.equipCd}count21').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count22', function(event) {
				$('#002${info.equipCd}count22').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count22').val()=="" || $('#002${info.equipCd}count22').val()=="00") {
					$('#001${info.equipCd}count22').val("0");
					$('#002${info.equipCd}count22').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count23', function(event) {
				$('#002${info.equipCd}count23').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count23').val()=="" || $('#002${info.equipCd}count23').val()=="00") {
					$('#001${info.equipCd}count23').val("0");
					$('#002${info.equipCd}count23').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count24', function(event) {
				$('#002${info.equipCd}count24').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count24').val()=="" || $('#002${info.equipCd}count24').val()=="00") {
					$('#001${info.equipCd}count24').val("0");
					$('#002${info.equipCd}count24').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count25', function(event) {
				$('#002${info.equipCd}count25').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count25').val()=="" || $('#002${info.equipCd}count25').val()=="00") {
					$('#001${info.equipCd}count25').val("0");
					$('#002${info.equipCd}count25').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count26', function(event) {
				$('#002${info.equipCd}count26').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count26').val()=="" || $('#002${info.equipCd}count26').val()=="00") {
					$('#001${info.equipCd}count26').val("0");
					$('#002${info.equipCd}count26').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count27', function(event) {
				$('#002${info.equipCd}count27').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count27').val()=="" || $('#002${info.equipCd}count27').val()=="00") {
					$('#001${info.equipCd}count27').val("0");
					$('#002${info.equipCd}count27').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count28', function(event) {
				$('#002${info.equipCd}count28').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count28').val()=="" || $('#002${info.equipCd}count28').val()=="00") {
					$('#001${info.equipCd}count28').val("0");
					$('#002${info.equipCd}count28').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count29', function(event) {
				$('#002${info.equipCd}count29').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count29').val()=="" || $('#002${info.equipCd}count29').val()=="00") {
					$('#001${info.equipCd}count29').val("0");
					$('#002${info.equipCd}count29').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count30', function(event) {
				$('#002${info.equipCd}count30').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count30').val()=="" || $('#002${info.equipCd}count30').val()=="00") {
					$('#001${info.equipCd}count30').val("0");
					$('#002${info.equipCd}count30').val("0");
				}
			});
			$(document).on('keyup','#001${info.equipCd}count31', function(event) {
				$('#002${info.equipCd}count31').val(addCommas(removeCommas($(this).val().replace(/[^0-9]/g,'')) ));
				if ($('#002${info.equipCd}count31').val()=="" || $('#002${info.equipCd}count31').val()=="00") {
					$('#001${info.equipCd}count31').val("0");
					$('#002${info.equipCd}count31').val("0");
				}
			});
    </c:forEach>
  	//공통코드 종료
  	var totalInputList = new Array();
 	var json = new Object();
	json.equipCd="001";
	json.equipNm="확정계획수량";
	totalInputList.push(json);
	json = new Object();
	json.equipCd="002";
	json.equipNm="운영계획수량";
	totalInputList.push(json);
	json = new Object();
	json.equipCd="003";
	json.equipNm="CAPA";
	totalInputList.push(json);
	json = new Object();
	json.equipCd="004";
	json.equipNm="수율(AL)";
	totalInputList.push(json);
	json = new Object();
	json.equipCd="005";
	json.equipNm="수율(NI)";
	totalInputList.push(json);
	
	var dayInputList = new Array();
	createDayInput();
	
	function selectBoxAppend(obj, id, sVal, flag) {
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ "전체" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ "선택" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].equipCd+ " selected>"+obj[key].equipNm+"</option>");
			} else {
				option = $("<option value="+obj[key].equipCd+">"+obj[key].equipNm+"</option>");
			}	
			$('#'+ id).append(option);
		}
	}
	
	function selectTotalBoxAppend(obj, id, sVal, flag) {
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ "전체(수율 제외)" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ "선택" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].equipCd+ " selected>"+obj[key].equipNm+"</option>");
			} else {
				option = $("<option value="+obj[key].equipCd+">"+obj[key].equipNm+"</option>");
			}
			$('#'+ id).append(option);
		}
	}
	
	//월별 일자 생성
	createHeader();
	//createBody();
	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';

	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#productionPlanTable').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();

	


/* 	if(aa==0){		
		$('#productionPlanTable').DataTable().ajax.reload( function () {$('#productionPlanTable').rowspan(0);   $('#productionPlanTable').rowspan(1); });
		aa=1;
	} */
    	
	//var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">계획 월</label><input type="text" class="form-control mr-1" id="inWhsDateCal" style="width:65px;">';
    //	html1 += '&nbsp; <button type="button" class="btn btn-primary" id="btnRetv">조회</button></div>';
	//$('#purchaseOutputInfoTable_length').html(html1);
	$('#inWhsDateCal').val(inWhsDateCal);

	// 보기
   /*  $('#productionPlanTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        } else {
        	$('#productionPlanTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
    }); */

    $('#btnRetv').on('click', function() {

    	$('#my-spinner').show();
    	
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	$('#allInputSetting').val("0");
    	$("#btnSave").attr("disabled", true);
    	$("#allInputSetting").attr("disabled", true);
    	$("#btnAllInputSetting").attr("disabled", true);
    	$("#btnEquipInputSetting").attr("disabled", true);
    	//$("#btnDayInputSetting").attr("disabled", true);
    	//createHeader();
    	createDayInput();
    	temp = true;
    	$('.table-responsive').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
			//monthProductPresentTable.destroy();
       		monthProductPresentTable = monthProductPresentTableFunc();

       		/*
    		$('#monthProductPresentTable').DataTable().ajax.reload( function () {
        	});
        	*/
        	
    		//$('#monthProductPresentTable').DataTable().ajax.reload( function () {});
        });
		//$('#productionPlanTable').DataTable().ajax.reload( function () {});
    	//$.fn.dataTable.ext.errMode = 'none';
    	//productionPlanTable = $('#productionPlanTable').on( 'error.dt', function ( e, settings, techNote, message ) {
    	//	if(techNote == 7) {
    	//		toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
    	//		location.href = "/";
    	//	}
    	//}).DataTable({
        //    dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
    	//			"<'row'<'col-sm-12'tr>>" +
    	//			"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",        
		//	language: lang_kor,
		//	paging: false,
		//	info: true,   
		//	destroy: true,    
		//	ordering: false,
		//	processing: true,
		//	autoWidth: false,
		//	scrollX : false,
		//	pageLength: false,
		//	searching: false,
		//	//header 고정
		//	scrollY: '70vh',
		//	scrollX: true,
    	//	fixedColumns: {
    	//		leftColumns: 4
    	//	},
    	//	ajax: {
        //        url: '<c:url value="/wm/readMonthPlanBody"/>',
        //        type: 'POST',
        //        data: {
        //        	'menuAuth'		:		menuAuth,
        //        	'planDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
        //        },
        //        /*
        //        success : function(res) {
        //            console.log(res);
        //        }
        //        */
        //    },
        //    columns: [
        //    	{ data: 'equipLineNm', },
        //    	{ data: 'equipNm', },
        //    	{ data: 'countTypeNm',
    	//			render: function(data, type, row) {
    	//				let html;
    	//				if( row["countTypeCd"] == "001" ){
    	//					return html = '<p style="color:purple; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    	//				} else if( row["countTypeCd"] == "002" ){
    	//					return html = '<p style="color:green; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    	//				} else if( row["countTypeCd"] == "003" ){
    	//					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'countSum',
    	//			render: function(data, type, row) {
    	//				let html;
    	//				if( row["countTypeCd"] == "001" ){
    	//					return html = '<p style="color:purple; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
    	//				} else if( row["countTypeCd"] == "002" ){
    	//					return html = '<p style="color:green; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
    	//				} else if( row["countTypeCd"] == "003" ){
    	//					return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'countSum',
    	//			render: function(data, type, row) {
    	//				return addCommas(data);
    	//			}
    	//		},
    	//		{ data: 'count1',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count1" name="count1" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count2',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count2" name="count2" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count3',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count3" name="count3" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count4',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count4" name="count4" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count5',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count5" name="count5" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count6',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count6" name="count6" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count7',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count7" name="count7" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count8',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count8" name="count8" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count9',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count9" name="count9" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count10',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count10" name="count10" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count11',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count11" name="count11" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count12',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count12" name="count12" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count13',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count13" name="count13" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count14',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count14" name="count14" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count15',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count15" name="count15" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count16',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count16" name="count16" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count17',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count17" name="count17" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count18',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count18" name="count18" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count19',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count19" name="count19" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count20',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count20" name="count20" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count21',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count21" name="count21" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count22',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count22" name="count22" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count23',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {[]
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count23" name="count23" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count24',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count24" name="count24" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count25',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count25" name="count25" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count26',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count26" name="count26" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count27',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count27" name="count27" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count28',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count28" name="count28" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count29',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count29" name="count29" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count30',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count30" name="count30" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
    	//		{ data: 'count31',
    	//			render: function(data, type, row) {
    	//				if( row["countTypeCd"] == "003" ){
    	//					return addCommas(data);
    	//				} else {
    	//					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count31" name="count31" value="' + addCommas(data) + '" disabled/></input>';
    	//				}
    	//			}
    	//		},
        //    ],
        //    //rowsGroup: [ 0,1 ],
        //    columnDefs: [
        //    	//{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], render: $.fn.dataTable.render.number( ',' ) },
        //    	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
        //    	
        //    ],
        //    //order: [
        //    //    [ 1, 'asc' ],
        //    //],
        //    //buttons: [
		//	//	{
		//	//	    extend: 'copy',
		//	//		title: '생산관리/생산계획 등록',
		//	//	},
		//	//	{
		//	//	    extend: 'excel',
		//	//	    title: '생산관리/생산계획 등록',
		//	//	},
		//	//	{
		//	//	    extend: 'print',
		//	//	    title: '생산관리/생산계획 등록',
		//	//	}
		//	//],
    	//	drawCallback:function( settings){
    	//		//var api = this.api();
    	//		//api.fixedColumns().update();
    	//		$.each($('#productionPlanTable tr'),function(index, item){
    	//			if($('.day27').text()==""){
    	//				$(this).find('th').eq(30).addClass('d-none');
    	//				$(this).find('td').eq(30).addClass('d-none');
    	//			}
    	//			if($('.day28').text()==""){
    	//				$(this).find('th').eq(31).addClass('d-none');
    	//				$(this).find('td').eq(31).addClass('d-none');
    	//			}
    	//			if($('.day29').text()==""){
    	//				$(this).find('th').eq(32).addClass('d-none');
    	//				$(this).find('td').eq(32).addClass('d-none');
    	//			}
    	//			if($('.day30').text()==""){
    	//				$(this).find('th').eq(33).addClass('d-none');
    	//				$(this).find('td').eq(33).addClass('d-none');
    	//			}
    	//			if($('.day31').text()==""){
    	//				$(this).find('th').eq(34).addClass('d-none');
    	//				$(this).find('td').eq(34).addClass('d-none');
    	//			}
    	//		});
        //
    	//		$('#productionPlanTable').rowspan(0);
    	//		$('#productionPlanTable').rowspan(1);
    	//		
    	//		if (temp) {
    	//			toastr.success('조회되었습니다');
    	//			temp = false;
    	//		}	
    	//	}
        //
        //});
		
    });

    $('#btnEdit').on('click', function() {
    	$("#allInputSetting").val("0");
    	$("#btnSave").attr("disabled", false);
    	$("#allInputSetting").attr("disabled", false);
    	$("#btnAllInputSetting").attr("disabled", false);
    	$("#btnEquipInputSetting").attr("disabled", false);
    	//$("#btnDayInputSetting").attr("disabled", false);
    	$(".number-float0").attr("disabled", false);
    	$(".number-float1").attr("disabled", false);
    });
    
    //저장
	$('#btnSave').on('click', function() {

		$('#my-spinner').show();
		
		dataList = new Array();
		for (var i=0; i<equipCodeList.length; i++){
			var equipCd = equipCodeList[i].equipCd;
			var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");
			
			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.equipCd = equipCd;
		 	rowData001.planDate = inWhsDateCal;
		 	rowData001.countTypeCd = "001";
			rowData001.count1 = removeCommas($('#001' + equipCd + 'count1').val());
			rowData001.count2 = removeCommas($('#001' + equipCd + 'count2').val());
			rowData001.count3 = removeCommas($('#001' + equipCd + 'count3').val());
			rowData001.count4 = removeCommas($('#001' + equipCd + 'count4').val());
			rowData001.count5 = removeCommas($('#001' + equipCd + 'count5').val());
			rowData001.count6 = removeCommas($('#001' + equipCd + 'count6').val());
			rowData001.count7 = removeCommas($('#001' + equipCd + 'count7').val());
			rowData001.count8 = removeCommas($('#001' + equipCd + 'count8').val());
			rowData001.count9 = removeCommas($('#001' + equipCd + 'count9').val());
			rowData001.count10 = removeCommas($('#001' + equipCd + 'count10').val());
			rowData001.count11 = removeCommas($('#001' + equipCd + 'count11').val());
			rowData001.count12 = removeCommas($('#001' + equipCd + 'count12').val());
			rowData001.count13 = removeCommas($('#001' + equipCd + 'count13').val());
			rowData001.count14 = removeCommas($('#001' + equipCd + 'count14').val());
			rowData001.count15 = removeCommas($('#001' + equipCd + 'count15').val());
			rowData001.count16 = removeCommas($('#001' + equipCd + 'count16').val());
			rowData001.count17 = removeCommas($('#001' + equipCd + 'count17').val());
			rowData001.count18 = removeCommas($('#001' + equipCd + 'count18').val());
			rowData001.count19 = removeCommas($('#001' + equipCd + 'count19').val());
			rowData001.count20 = removeCommas($('#001' + equipCd + 'count20').val());
			rowData001.count21 = removeCommas($('#001' + equipCd + 'count21').val());
			rowData001.count22 = removeCommas($('#001' + equipCd + 'count22').val());
			rowData001.count23 = removeCommas($('#001' + equipCd + 'count23').val());
			rowData001.count24 = removeCommas($('#001' + equipCd + 'count24').val());
			rowData001.count25 = removeCommas($('#001' + equipCd + 'count25').val());
			rowData001.count26 = removeCommas($('#001' + equipCd + 'count26').val());
			rowData001.count27 = removeCommas($('#001' + equipCd + 'count27').val());
			rowData001.count28 = removeCommas($('#001' + equipCd + 'count28').val());
			rowData001.count29 = removeCommas($('#001' + equipCd + 'count29').val());
			rowData001.count30 = removeCommas($('#001' + equipCd + 'count30').val());
			rowData001.count31 = removeCommas($('#001' + equipCd + 'count31').val());
			dataList.push(rowData001);

			var rowData002 = new Object();
		 	rowData002.menuAuth = menuAuth;
		 	rowData002.equipCd = equipCd;
		 	rowData002.planDate = inWhsDateCal;
		 	rowData002.countTypeCd = "002";
			rowData002.count1 = removeCommas($('#002' + equipCd + 'count1').val());
			rowData002.count2 = removeCommas($('#002' + equipCd + 'count2').val());
			rowData002.count3 = removeCommas($('#002' + equipCd + 'count3').val());
			rowData002.count4 = removeCommas($('#002' + equipCd + 'count4').val());
			rowData002.count5 = removeCommas($('#002' + equipCd + 'count5').val());
			rowData002.count6 = removeCommas($('#002' + equipCd + 'count6').val());
			rowData002.count7 = removeCommas($('#002' + equipCd + 'count7').val());
			rowData002.count8 = removeCommas($('#002' + equipCd + 'count8').val());
			rowData002.count9 = removeCommas($('#002' + equipCd + 'count9').val());
			rowData002.count10 = removeCommas($('#002' + equipCd + 'count10').val());
			rowData002.count11 = removeCommas($('#002' + equipCd + 'count11').val());
			rowData002.count12 = removeCommas($('#002' + equipCd + 'count12').val());
			rowData002.count13 = removeCommas($('#002' + equipCd + 'count13').val());
			rowData002.count14 = removeCommas($('#002' + equipCd + 'count14').val());
			rowData002.count15 = removeCommas($('#002' + equipCd + 'count15').val());
			rowData002.count16 = removeCommas($('#002' + equipCd + 'count16').val());
			rowData002.count17 = removeCommas($('#002' + equipCd + 'count17').val());
			rowData002.count18 = removeCommas($('#002' + equipCd + 'count18').val());
			rowData002.count19 = removeCommas($('#002' + equipCd + 'count19').val());
			rowData002.count20 = removeCommas($('#002' + equipCd + 'count20').val());
			rowData002.count21 = removeCommas($('#002' + equipCd + 'count21').val());
			rowData002.count22 = removeCommas($('#002' + equipCd + 'count22').val());
			rowData002.count23 = removeCommas($('#002' + equipCd + 'count23').val());
			rowData002.count24 = removeCommas($('#002' + equipCd + 'count24').val());
			rowData002.count25 = removeCommas($('#002' + equipCd + 'count25').val());
			rowData002.count26 = removeCommas($('#002' + equipCd + 'count26').val());
			rowData002.count27 = removeCommas($('#002' + equipCd + 'count27').val());
			rowData002.count28 = removeCommas($('#002' + equipCd + 'count28').val());
			rowData002.count29 = removeCommas($('#002' + equipCd + 'count29').val());
			rowData002.count30 = removeCommas($('#002' + equipCd + 'count30').val());
			rowData002.count31 = removeCommas($('#002' + equipCd + 'count31').val());
			dataList.push(rowData002);

			var rowData003 = new Object();
		 	rowData003.menuAuth = menuAuth;
		 	rowData003.equipCd = equipCd;
		 	rowData003.planDate = inWhsDateCal;
		 	rowData003.countTypeCd = "003";
			rowData003.count1 = removeCommas($('#003' + equipCd + 'count1').val());
			rowData003.count2 = removeCommas($('#003' + equipCd + 'count2').val());
			rowData003.count3 = removeCommas($('#003' + equipCd + 'count3').val());
			rowData003.count4 = removeCommas($('#003' + equipCd + 'count4').val());
			rowData003.count5 = removeCommas($('#003' + equipCd + 'count5').val());
			rowData003.count6 = removeCommas($('#003' + equipCd + 'count6').val());
			rowData003.count7 = removeCommas($('#003' + equipCd + 'count7').val());
			rowData003.count8 = removeCommas($('#003' + equipCd + 'count8').val());
			rowData003.count9 = removeCommas($('#003' + equipCd + 'count9').val());
			rowData003.count10 = removeCommas($('#003' + equipCd + 'count10').val());
			rowData003.count11 = removeCommas($('#003' + equipCd + 'count11').val());
			rowData003.count12 = removeCommas($('#003' + equipCd + 'count12').val());
			rowData003.count13 = removeCommas($('#003' + equipCd + 'count13').val());
			rowData003.count14 = removeCommas($('#003' + equipCd + 'count14').val());
			rowData003.count15 = removeCommas($('#003' + equipCd + 'count15').val());
			rowData003.count16 = removeCommas($('#003' + equipCd + 'count16').val());
			rowData003.count17 = removeCommas($('#003' + equipCd + 'count17').val());
			rowData003.count18 = removeCommas($('#003' + equipCd + 'count18').val());
			rowData003.count19 = removeCommas($('#003' + equipCd + 'count19').val());
			rowData003.count20 = removeCommas($('#003' + equipCd + 'count20').val());
			rowData003.count21 = removeCommas($('#003' + equipCd + 'count21').val());
			rowData003.count22 = removeCommas($('#003' + equipCd + 'count22').val());
			rowData003.count23 = removeCommas($('#003' + equipCd + 'count23').val());
			rowData003.count24 = removeCommas($('#003' + equipCd + 'count24').val());
			rowData003.count25 = removeCommas($('#003' + equipCd + 'count25').val());
			rowData003.count26 = removeCommas($('#003' + equipCd + 'count26').val());
			rowData003.count27 = removeCommas($('#003' + equipCd + 'count27').val());
			rowData003.count28 = removeCommas($('#003' + equipCd + 'count28').val());
			rowData003.count29 = removeCommas($('#003' + equipCd + 'count29').val());
			rowData003.count30 = removeCommas($('#003' + equipCd + 'count30').val());
			rowData003.count31 = removeCommas($('#003' + equipCd + 'count31').val());
			dataList.push(rowData003);

			var rowData004 = new Object();
		 	rowData004.menuAuth = menuAuth;
		 	rowData004.equipCd = equipCd;
		 	rowData004.planDate = inWhsDateCal;
		 	rowData004.countTypeCd = "004";
		 	rowData004.count1 = removeCommas($('#004' + equipCd + 'count1').val());
			rowData004.count2 = removeCommas($('#004' + equipCd + 'count2').val());
			rowData004.count3 = removeCommas($('#004' + equipCd + 'count3').val());
			rowData004.count4 = removeCommas($('#004' + equipCd + 'count4').val());
			rowData004.count5 = removeCommas($('#004' + equipCd + 'count5').val());
			rowData004.count6 = removeCommas($('#004' + equipCd + 'count6').val());
			rowData004.count7 = removeCommas($('#004' + equipCd + 'count7').val());
			rowData004.count8 = removeCommas($('#004' + equipCd + 'count8').val());
			rowData004.count9 = removeCommas($('#004' + equipCd + 'count9').val());
			rowData004.count10 = removeCommas($('#004' + equipCd + 'count10').val());
			rowData004.count11 = removeCommas($('#004' + equipCd + 'count11').val());
			rowData004.count12 = removeCommas($('#004' + equipCd + 'count12').val());
			rowData004.count13 = removeCommas($('#004' + equipCd + 'count13').val());
			rowData004.count14 = removeCommas($('#004' + equipCd + 'count14').val());
			rowData004.count15 = removeCommas($('#004' + equipCd + 'count15').val());
			rowData004.count16 = removeCommas($('#004' + equipCd + 'count16').val());
			rowData004.count17 = removeCommas($('#004' + equipCd + 'count17').val());
			rowData004.count18 = removeCommas($('#004' + equipCd + 'count18').val());
			rowData004.count19 = removeCommas($('#004' + equipCd + 'count19').val());
			rowData004.count20 = removeCommas($('#004' + equipCd + 'count20').val());
			rowData004.count21 = removeCommas($('#004' + equipCd + 'count21').val());
			rowData004.count22 = removeCommas($('#004' + equipCd + 'count22').val());
			rowData004.count23 = removeCommas($('#004' + equipCd + 'count23').val());
			rowData004.count24 = removeCommas($('#004' + equipCd + 'count24').val());
			rowData004.count25 = removeCommas($('#004' + equipCd + 'count25').val());
			rowData004.count26 = removeCommas($('#004' + equipCd + 'count26').val());
			rowData004.count27 = removeCommas($('#004' + equipCd + 'count27').val());
			rowData004.count28 = removeCommas($('#004' + equipCd + 'count28').val());
			rowData004.count29 = removeCommas($('#004' + equipCd + 'count29').val());
			rowData004.count30 = removeCommas($('#004' + equipCd + 'count30').val());
			rowData004.count31 = removeCommas($('#004' + equipCd + 'count31').val());
			dataList.push(rowData004);

			var rowData005 = new Object();
		 	rowData005.menuAuth = menuAuth;
		 	rowData005.equipCd = equipCd;
		 	rowData005.planDate = inWhsDateCal;
		 	rowData005.countTypeCd = "005";
			rowData005.count1 = removeCommas($('#005' + equipCd + 'count1').val());
			rowData005.count2 = removeCommas($('#005' + equipCd + 'count2').val());
			rowData005.count3 = removeCommas($('#005' + equipCd + 'count3').val());
			rowData005.count4 = removeCommas($('#005' + equipCd + 'count4').val());
			rowData005.count5 = removeCommas($('#005' + equipCd + 'count5').val());
			rowData005.count6 = removeCommas($('#005' + equipCd + 'count6').val());
			rowData005.count7 = removeCommas($('#005' + equipCd + 'count7').val());
			rowData005.count8 = removeCommas($('#005' + equipCd + 'count8').val());
			rowData005.count9 = removeCommas($('#005' + equipCd + 'count9').val());
			rowData005.count10 = removeCommas($('#005' + equipCd + 'count10').val());
			rowData005.count11 = removeCommas($('#005' + equipCd + 'count11').val());
			rowData005.count12 = removeCommas($('#005' + equipCd + 'count12').val());
			rowData005.count13 = removeCommas($('#005' + equipCd + 'count13').val());
			rowData005.count14 = removeCommas($('#005' + equipCd + 'count14').val());
			rowData005.count15 = removeCommas($('#005' + equipCd + 'count15').val());
			rowData005.count16 = removeCommas($('#005' + equipCd + 'count16').val());
			rowData005.count17 = removeCommas($('#005' + equipCd + 'count17').val());
			rowData005.count18 = removeCommas($('#005' + equipCd + 'count18').val());
			rowData005.count19 = removeCommas($('#005' + equipCd + 'count19').val());
			rowData005.count20 = removeCommas($('#005' + equipCd + 'count20').val());
			rowData005.count21 = removeCommas($('#005' + equipCd + 'count21').val());
			rowData005.count22 = removeCommas($('#005' + equipCd + 'count22').val());
			rowData005.count23 = removeCommas($('#005' + equipCd + 'count23').val());
			rowData005.count24 = removeCommas($('#005' + equipCd + 'count24').val());
			rowData005.count25 = removeCommas($('#005' + equipCd + 'count25').val());
			rowData005.count26 = removeCommas($('#005' + equipCd + 'count26').val());
			rowData005.count27 = removeCommas($('#005' + equipCd + 'count27').val());
			rowData005.count28 = removeCommas($('#005' + equipCd + 'count28').val());
			rowData005.count29 = removeCommas($('#005' + equipCd + 'count29').val());
			rowData005.count30 = removeCommas($('#005' + equipCd + 'count30').val());
			rowData005.count31 = removeCommas($('#005' + equipCd + 'count31').val());
			dataList.push(rowData005);

		}
		//console.log(dataList);

		$.ajax({
            url: '<c:url value="/wm/insertMonthPlan"/>',
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
                	$("#btnAllInputSetting").attr("disabled", true);
                	$("#btnEquipInputSetting").attr("disabled", true);
                	//$("#btnDayInputSetting").attr("disabled", true);
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

    //전체 일괄입력
	$('#btnAllInputSetting').on('click', function() {
		selectBoxAppend(equipCodeList, "equipCd", "", "2");
		selectTotalBoxAppend(totalInputList, "totalInput", "", "1");
		selectBoxAppend(totalInputList, "totalInputAll", "", "1");
		$('#allInputSetting').addClass('number-float0'); 
		$('#allInputSetting').val("0");
		$('#totalInputPopupModal').modal('show');		
    });
    
    //전체 일괄입력
	$('#btnEquipInputExecuteAll').on('click', function() {
		var allInputSetting = $("#allInputSetting").val().replace(/-/g,"");
		if (allInputSetting == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#allInputSetting').select();
			return false;
		}
		$('#my-spinner').show();
		

		if($('#totalInputAll option:selected').val() == '001'){
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {
					$('#001' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);				
				}
			}

		} else if($('#totalInputAll option:selected').val() == '002'){
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {					
					$('#002' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
				}
			}
		} else if($('#totalInputAll option:selected').val() == '003'){
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {					
					$('#003' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
				}
			}
		} else if($('#totalInputAll option:selected').val() == '004'){
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {					
					$('#004' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
				}
			}
		} else if($('#totalInputAll option:selected').val() == '005'){
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {					
					$('#005' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
				}
			}
		}  else{
			for (var i=0; i<equipCodeList.length; i++) {
				for (var j=0; j<dayCount; j++) {
					$('#001' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
					$('#002' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
					$('#003' + equipCodeList[i].equipCd + 'count' + (j+1)).val(allInputSetting);
					
					
				}
			}
		}				
		
		
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
	});

	//특정설비 일괄입력
	$('#btnEquipInputSetting').on('click', function() {
		selectBoxAppend(equipCodeList, "equipCd", "", "1");
		selectTotalBoxAppend(totalInputList, "totalInput", "", "1");
		selectBoxAppend(totalInputList, "totalInputAll", "", "1");
		selectBoxAppend(dayInputList, "dayEquipInputAll", "", "1");
		$('#equipInputSetting').addClass('number-float0'); 
		$('#equipInputSetting').val("0");
		$('#equipInputPopupModal').modal('show');
    });

    //특정설비 일괄입력
	$('#btnEquipInputExecute').on('click', function() {
		var equipCd = $("#equipCd option:selected").val();
		var btnEquipInputExecute = $("#equipInputSetting").val().replace(/-/g,"");
		var dayCd = parseInt($("#dayEquipInputAll option:selected").val()) + 1;
		/*if (equipCd == null || equipCd == "") {
			toastr.warning("설비명을 선택해 주세요!");
			$('#equipCd').focus();
			return false;
		}*/
		if (btnEquipInputExecute == "00") {
			toastr.warning("수량을 입력해 주세요!");
			$('#equipInputSetting').select();
			return false;
		}
		if ($("#dayEquipInputAll option:selected").val() == '') {
			/* toastr.warning("날짜를 선택해 주세요!");
			$('#dayInputAll').focus();
			return false; */
			dayCd = 99;						
		}
		$('#my-spinner').show();
		if(dayCd != 99){ 
			// 특정 날짜 선택한 경우
			if($('#totalInput option:selected').val() == '001'){
				if(equipCd != '' && equipCd != null){
					$('#001' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#001' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
			} else if($('#totalInput option:selected').val() == '002'){
				if(equipCd != '' && equipCd != null){
					$('#002' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#002' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
			} else if($('#totalInput option:selected').val() == '003'){
				if(equipCd != '' && equipCd != null){
					$('#003' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#003' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
			} else if($('#totalInput option:selected').val() == '004'){
				if(equipCd != '' && equipCd != null){
					$('#004' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#004' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
			} else if($('#totalInput option:selected').val() == '005'){
				if(equipCd != '' && equipCd != null){
					$('#005' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#005' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
			} else {
				if (equipCd != '' && equipCd != null) {
					$('#001' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					$('#002' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					$('#003' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
// 					$('#004' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
// 					$('#005' + equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
				} else {
					for(var i=1; i <= equipCodeList.length; i++){
						$('#001' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
						$('#002' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
						$('#003' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
// 						$('#004' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
// 						$('#005' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val(btnEquipInputExecute);
					}
				}
				
			}
		
		} else{
			// 전체 날짜를 선택한 경우
			if($('#totalInput option:selected').val() == '001'){
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#001' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#001' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							}
						}	
					}			
				}
	
			} else if($('#totalInput option:selected').val() == '002'){
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#002' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#002' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							}
						}
					}			
				}
	
			} else if($('#totalInput option:selected').val() == '003'){
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#003' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#003' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							}
						}
					}			
				}
	
			} else if($('#totalInput option:selected').val() == '004'){
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#004' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#004' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							}
						}
					}			
				}
	
			} else if($('#totalInput option:selected').val() == '005'){
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#005' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#005' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							}
						}
					}			
				}
	
			} else{
				for (var j=0; j<dayCount; j++) {
					for(var i=1; i <= equipCodeList.length; i++){
						if(equipCd != '' && equipCd != null){
							$('#001' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							$('#002' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
							$('#003' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
// 							$('#004' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
// 							$('#005' + equipCd + 'count' + (j+1) ).val(btnEquipInputExecute);
						} else {
							for(var i=1; i <= equipCodeList.length; i++){
								$('#001' + equipCodeList[i-1].equipCd + 'count' + (j+1)).val(btnEquipInputExecute);	
								$('#002' + equipCodeList[i-1].equipCd + 'count' + (j+1)).val(btnEquipInputExecute);	
								$('#003' + equipCodeList[i-1].equipCd + 'count' + (j+1)).val(btnEquipInputExecute);
// 								$('#004' + equipCodeList[i-1].equipCd + 'count' + (j+1)).val(btnEquipInputExecute);
// 								$('#005' + equipCodeList[i-1].equipCd + 'count' + (j+1)).val(btnEquipInputExecute);
							}
						}
					}			
				}
			}
		}
		
	/* 	for (var j=0; j<dayCount; j++) {
			$('#001' + equipCd + 'count' + (j+1)).val(btnEquipInputExecute);
			$('#002' + equipCd + 'count' + (j+1)).val(btnEquipInputExecute);
		} */
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
    });
	//전체 일별 입력
	//$('#btnDayInputSetting').on('click', function() {
		//selectBoxAppend(dayInputList, "dayInputAll", "", "1");
		//selectBoxAppend(totalInputList, "dayInput", "", "1");
		//$('#dayInputSetting').addClass('number-float0'); 
		//$('#dayInputSetting').val("0");
		//$('#dayInputPopupModal').modal('show');		
    //});
	//전체 일별 입력
/* 	$('#btnDayInputExecuteAll').on('click', function() {
		var dayCd = parseInt($("#dayInputAll option:selected").val()) + 1;
		if ($("#dayInputAll option:selected").val() == '') {
			dayCd = 99;						
		}
		$('#my-spinner').show();
		if(dayCd != 99){
			if($('#dayInput option:selected').val() == '001'){
				for(var i=1; i <= equipCodeList.length; i++){
					$('#001' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}else if($('#dayInput option:selected').val() == '002'){
				for(var i=1; i <= equipCodeList.length; i++){
					$('#002' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}else if($('#dayInput option:selected').val() == '003'){
				for(var i=1; i <= equipCodeList.length; i++){
					$('#003' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}else if($('#dayInput option:selected').val() == '004'){
				for(var i=1; i <= equipCodeList.length; i++){
					$('#004' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}else if($('#dayInput option:selected').val() == '005'){
				for(var i=1; i <= equipCodeList.length; i++){
					$('#005' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}else{
				for(var i=1; i <= equipCodeList.length; i++){
					$('#001' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
					$('#002' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
					$('#003' + equipCodeList[i-1].equipCd + 'count' + (dayCd)).val($('#dayInputSetting').val());
				}
			}
		}else{
			if($('#dayInput option:selected').val() == '001'){
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#001' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}else if($('#dayInput option:selected').val() == '002'){
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#002' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}else if($('#dayInput option:selected').val() == '003'){
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#003' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}else if($('#dayInput option:selected').val() == '004'){
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#004' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}else if($('#dayInput option:selected').val() == '005'){
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#005' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}else{
				for(var j=1; j<= dayInputList.length; j++){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#001' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
						$('#002' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
						$('#003' + equipCodeList[i-1].equipCd + 'count' + j).val($('#dayInputSetting').val());
					}
				}
			}
			
		}
		toastr.success("입력되었습니다.");
		$('#my-spinner').hide();
    });
     */

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
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">설비</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">누적</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
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
						//$('#planHeader').html(planHeader);
						$('#planHeader').html(planHeader).promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }
	//전체일별입력 선택박스 날짜 추가

	function createDayInput(){
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
						var data = res.data;
						dayInputList.splice(0,31);
						for (var i=0; i<data.length; i++) {
							var json = new Object();
							//존재하지 않는 날짜
							if (data[i].day == 0) {								
							}
							//토요일
							else if (data[i].day == 7) {
								json.equipCd = i; 
								json.equipNm = data[i].countDay;
								dayInputList.push(json);
							}//일요일
							else if (data[i].day == 1){
								json.equipCd = i; 
								json.equipNm = data[i].countDay;
								dayInputList.push(json);
							}
							//그외
							else {
								json.equipCd = i; 
								json.equipNm = data[i].countDay;
								dayInputList.push(json);
							}			
											
						}
						//$('#planHeader').html(planHeader);
						$('#dayInputList').promise().done(function(){
							//console.log('create header end');
							resolve();
						});
					}
				}
			});
		});
    }
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
		/* if ( $(this).val().split('.').length > 1  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$(this).val("0");
			$(this).select();
			return false;
		} */
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        $(this).val(addCommas(temp));

        
	});

    //숫자만 입력, 길이, 소수점 한자리까지 제한
    //ajax로 추가되는 부분이라 document로 해줘야 스크립트 먹힘
    $(document).on('keyup','.number-float1', function(event) {
		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float1').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			}); 
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
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
			toastr.warning('최대 크기를 초과하였습니다.');
			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).select();
			return false;
		}

 		var _pattern2 = /^\d*[.]\d{2}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 첫째 자리까지 입력 가능합니다.");
            $(this).val("0");
            $(this).select();
            return false;
        }
        
 		if($(this).val().split('.').length >= 3) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');
			$(this).val("0");
			$(this).select();
			return false;
		} 		
  	});

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
        			leftColumns: 3
        		},
        		ajax: {
                    url: '<c:url value="/wm/readMonthPlanBody"/>',
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
                	//{ data: 'equipLineNm', },
                	{ data: 'equipNm', },
                	{ data: 'countTypeNm',
        				render: function(data, type, row) {
        					let html;
        					return html = '<p style=" font-weight:bold; margin-bottom:0px;">' + data + '</p>';
        					//if( row["countTypeCd"] == "001" ){
        					//	return html = '<p style=" font-weight:bold; margin-bottom:0px;">' + data + '</p>';
        					//} else if( row["countTypeCd"] == "002" ){
        					//	return html = '<p style=" font-weight:bold; margin-bottom:0px;">' + data + '</p>';
        					//} else if( row["countTypeCd"] == "003" ){
        					//	return html = '<p style=" font-weight:bold; margin-bottom:0px;">' + data + '</p>';
        					//}
        				}
        			},
        			{ data: 'countSum',
        				render: function(data, type, row) {
        					let html;
        					return html = '<p style=" font-weight:bold; margin-bottom:0px;" >' + parseFloat(data).toFixed(1) + '</p>';
        					//if( row["countTypeCd"] == "001" ){
        					//	return html = '<p style="color:purple; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
        					//} else if( row["countTypeCd"] == "002" ){
        					//	return html = '<p style="color:green; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
        					//} else if( row["countTypeCd"] == "003" ){
        					//	return html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + addCommas(data) + '</p>';
        					//}
        				}
        			},
        			{ data: 'count1',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count1" name="count1" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count1" name="count1" value="' + addCommas(data) + '" disabled/></input>';
                			}
        					
        					
        				}
        			},
        			{ data: 'count2',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count2" name="count2" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count2" name="count2" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count3',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count3" name="count3" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count3" name="count3" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count4',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count4" name="count4" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count4" name="count4" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count5',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count5" name="count5" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count5" name="count5" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count6',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count6" name="count6" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count6" name="count6" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count7',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count7" name="count7" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count7" name="count7" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count8',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count8" name="count8" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count8" name="count8" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count9',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count9" name="count9" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count9" name="count9" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count10',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count10" name="count10" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count10" name="count10" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count11',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count11" name="count11" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count11" name="count11" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count12',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count12" name="count12" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count12" name="count12" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count13',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count13" name="count13" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count13" name="count13" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count14',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count14" name="count14" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count14" name="count14" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count15',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count15" name="count15" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count15" name="count15" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count16',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count16" name="count16" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count16" name="count16" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count17',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count17" name="count17" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count17" name="count17" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count18',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count18" name="count18" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count18" name="count18" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count19',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count19" name="count19" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count19" name="count19" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count20',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count20" name="count20" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count20" name="count20" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count21',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count21" name="count21" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count21" name="count21" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count22',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count22" name="count22" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count22" name="count22" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count23',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count23" name="count23" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count23" name="count23" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count24',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count24" name="count24" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count24" name="count24" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count25',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count25" name="count25" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count25" name="count25" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count26',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count26" name="count26" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count26" name="count26" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count27',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count27" name="count27" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count27" name="count27" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count28',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count28" name="count28" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count28" name="count28" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count29',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count29" name="count29" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count29" name="count29" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count30',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count30" name="count30" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count30" name="count30" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
        			{ data: 'count31',
        				render: function(data, type, row) {
        					if(row['countTypeNm'] == '수율(AL)' || row['countTypeNm'] == '수율(NICU)'){
        						return '<input type="text" class="form-control number-float1" id="' + row["countTypeCd"] + row["equipCd"] + 'count31" name="count31" value="' + addCommas(data) + '" min="0" max="100" disabled/></input>';
            				} else{
            					return '<input type="text" class="form-control number-float0" id="' + row["countTypeCd"] + row["equipCd"] + 'count31" name="count31" value="' + addCommas(data) + '" disabled/></input>';
                			}
        				}
        			},
                ],
        		//rowsGroup: [ 0,1 ],
                columnDefs: [
                	//{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34], render: $.fn.dataTable.render.number( ',' ) },
                	{ targets: [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
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
        			//var api = this.api();
        			//api.fixedColumns().update();
        			$.each($('#productionPlanTable tr'),function(index, item){
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
        				if(index == $('#productionPlanTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        }
        			});
					var colorStat = true;
        			$('#productionPlanTable tbody tr').each(function(index){        			 	
        			 	if(index % 5 == 0){
        			 		colorStat = !colorStat;
            			} 
            			if(colorStat){
            				$(this).css('background-color','#adb5bd');
        					
                		} else{
                			$(this).css('background-color','#ffffff');
        					
                    	}
        			});
        			
        			$('#productionPlanTable').rowspan(0);
        			$('#productionPlanTable').rowspan(1);
        			
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
    //전체일괄입력 소수점입력할 수 있도록 처리
    $('#totalInputAll').change(function(){
    	if($('#totalInputAll option:selected').val() == '004' || $('#totalInputAll option:selected').val() == '005'){
    		$('#allInputSetting').attr('max','100');
    		$('#allInputSetting').removeClass('number-float0');
    		$('#allInputSetting').addClass('number-float1'); 
    		/* var element = document.getElementById('allInputSetting');
    		element.classList.remove('number-float0');
    		element.classList.add('number-float1'); */
    	} else{
    		$('#allInputSetting').attr('max','99999');
    		$('#allInputSetting').removeClass('number-float1');
    		$('#allInputSetting').addClass('number-float0'); 
        }
    });
    //설비별일괄입력 소수점입력할 수 있도록 처리
    $('#totalInput').change(function(){
    	if($('#totalInput option:selected').val() == '004' || $('#totalInput option:selected').val() == '005'){
    		$('#equipInputSetting').attr('max','100');
    		$('#equipInputSetting').removeClass('number-float0');
    		$('#equipInputSetting').addClass('number-float1'); 
    		/* var element = document.getElementById('allInputSetting');
    		element.classList.remove('number-float0');
    		element.classList.add('number-float1'); */
    	} else{
    		$('#equipInputSetting').attr('max','99999');
    		$('#equipInputSetting').removeClass('number-float1');
    		$('#equipInputSetting').addClass('number-float0'); 
        }
    });
 	//일별 일괄입력 소수점입력할 수 있도록 처리
    $('#dayInput').change(function(){
    	if($('#dayInput option:selected').val() == '004' || $('#dayInput option:selected').val() == '005'){
    		$('#dayInputSetting').attr('max','100');
    		$('#dayInputSetting').removeClass('number-float0');
    		$('#dayInputSetting').addClass('number-float1'); 
    		/* var element = document.getElementById('allInputSetting');
    		element.classList.remove('number-float0');
    		element.classList.add('number-float1'); */
    	} else{
    		$('#dayInputSetting').attr('max','99999');
    		$('#dayInputSetting').removeClass('number-float1');
    		$('#dayInputSetting').addClass('number-float0'); 
        }
    });
</script>

</body>
</html>
