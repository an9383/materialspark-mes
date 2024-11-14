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
		<div class="row col-sm-6">
			<nav aria-label="breadcrumb" class="breadcrumb-padding">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">생산관리</a></li>
					<li class="breadcrumb-item active">월별 설비 JC 및 PM 일정(확정판)</li>
				</ol>
			</nav>
		</div>
		<div class="col-sm-6" style=" width: 20%; line-height: 30px;">
			<label style="font-size:14px; color: pink;" class="float-right input-label-sm mr-3">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">잡체인지</label>	
  				<!-- <label style="font-size:14px; color: green;" class="float-right input-label-sm">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">자석 장착</label>	-->
  				<label style="font-size:14px; color: red;" class="float-right input-label-sm">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">기타</label>	
  				<!-- <label style="font-size:14px; color: yellow;" class="float-right input-label-sm">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">12시간 생산</label>					 -->
			<label style="font-size:14px; color: gray;" class="float-right input-label-sm">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">설비 PM</label>
		    <label style="font-size:14px; color: skyblue;" class="float-right input-label-sm">&nbsp;●</label>
		    <label style="font-size:14px;" class="float-right input-label-sm mr-0">&nbsp;샘플생산</label>
		</div>
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
	    				
	    				    				
	    				<!-- <button type="button" class="btn btn-primary ml-5" id="btnAllInputSetting" disabled>전체 일괄입력</button> -->
	    			 	<label class="input-label-sm ml-2">비가동구분</label>
	    				<select class="custom-select" style="width:120px;" id="npGubun" ></select> 
	    				<label class="input-label-sm ml-2">비가동시간</label>
	    				<input type="text" class="form-control" style="width:120px;" id="npTimeVal" value="0"> 
	    				<button type="button" class="btn btn-primary ml-1" id="btnFaultyGubun" disabled >적용</button>
	    				<button type="button" class="btn btn-primary ml-1" id="btnEquipInputSetting" disabled>특정 설비&일자 입력</button>
	    				<button type="button" class="btn btn-primary ml-1" id="btnPlanMan">작업자</button>
	    				
	    			</div>
	    			<div class="col-sm-6" style="margin-bottom:5px;">	    			
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnSave" disabled>저장</button>
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnComplete">확정</button>
	    				<button type="button" class="btn btn-primary mr-1 float-right" id="btnEdit">입력</button>
	    				<button type="button" class="float-right btn btn-primary mr-1" id="btnJobChange" >잡체인지</button>
	    				<button type="button" class="float-right btn btn-primary mr-1" id="btnYeild" >수율</button>
	    				<button type="button" class="float-right btn btn-dark mr-1" id="btnInfo" >설명</button>
	    				<button type="button" class="btn btn-success float-right mr-1" id="btnOption1">전월제품</button>	
	    				<button type="button" class="btn btn-success float-right mr-1" id="btnOption2">제조조건</button>	
	    				<button type="button" class="float-right btn btn-danger mr-1" id="btnDeleteAll" >삭제</button>

	    			</div>
	    			
	    		</div>	    	
				<div class="table-responsive" style="padding-bottom: 5px;">
					<table id="productionPlanTable" class="table table-bordered tr_highlight_row">				
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
					&nbsp;
					<label class="input-label-sm">비가동시간 :  </label>
					<input type="text" class="form-control mr-2" id="equipInputSetting" min=0 max=24 value="0" style="width:100px;"></input>
					<!-- <button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecute">입력</button> -->
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-2" id="btnEquipInputExecute"  style="min-width: 70px;">입력</button>
				<!-- <button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button> -->
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 특정 설비입력 모달 끝 -->
<!-- 수정 확인 모달 시작 -->
<div class="modal fade" id="editCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="editCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="editCheckModalLabel">수정확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row">					
					<label class="input-label-sm">이미 확정된 계획입니다. 수정하시면 재확정을 해야합니다.
					수정하시겠습니까? </label>
					
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnEditCheck" data-dismiss="modal" style="min-width: 70px;">수정</button>
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 수정 확인 모달 끝 -->
<!-- 잡체인지 모달 시작 -->
<div class="modal fade" id="jobChangePopupModal" tabindex="-1" role="dialog" aria-labelledby="jobChangePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="jobChangeModalLabel">잡체인지</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				
					<div class="">	
						<label class="input-label-sm float-left ml-3">설비명</label>
	    				<select class="custom-select float-left ml-1" style="width:120px;" id="equipSelect" ></select>	    				
	    				<label class="input-label-sm float-left ml-3">잡체인지일자</label>
	    				<input type="date" class="form-control float-left ml-3"  style="width:120px;" id="jobChangeDate" value="" >	    	
	    				<button type="button" class="btn btn-primary float-left ml-1" name="modalRetv" id="modalRetv">조회</button>
	    				
						<button type="button" class="btn btn-warning float-right mr-1" name="rowDelete" id="rowDelete" value="">열삭제</button>
						<button type="button" class="btn btn-primary float-right mr-1" name="rowAdd" id="rowAdd" value="">열추가</button>
						<button type="button" class="btn btn-primary float-right mr-1" name="jobChangeList" id="jobChangeList" value="">목록</button>
				</div>
			<!-- 	<button type="button" class="btn btn-danger float-right mr-1" name="allDelete" id="allDelete" disabled>전체삭제</button> -->
					
					<br>
					<br>
					<div class="">							
					
						<table class="table table-bordered" id="jobChangeTable">
							<colgroup>
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="19%">
					
							</colgroup>
							<thead>
								<tr>
									<th>설비명</th>
									<th>제품명</th>
									<th>가동시간</th>																
									<th>시작일</th>									
									<th>종료일</th>										
								</tr>
							</thead>
						</table>
					</div>
				
				<br>			
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary mr-1" id="btnSaveJobChange" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				
			</div>
		</div>
	</div>
</div>
<!-- 잡체인지 모달 끝 -->

<!-- 작업자 등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="planManPopUpModal" tabindex="-1" role="dialog" aria-labelledby="planManPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="margin-right: 60%;">
		<div class="modal-content" style="width: 315%;">
			<div class="modal-header">
				<h5 class="modal-title">작업자 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<div class="row" style="justify-content: center;">

				    <form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="" class="col-sm-12 col-md">
					     <label for="fileUpload" class="btn btn-success float-right" style="min-width: 70px;">
					        액셀 업로드
					    </label>
					    <input type="file" id="fileUpload" name="excelfile" style="display: none;">
				    </form>
				</div>
				<!-- .table-responsive -->
				<div class="planManModal" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="planManDiv">
					<table id="planManTable" class="table table-bordered" style="text-align: center">						
						<thead class="thead-light">
							<tr id="planHeaderMan"></tr>
						</thead>						
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary float-right mr-1" id="btnPlanSave" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary" id="btnInAddCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 작업자 등록 모달 종료 -->
<!-- 잡체인지 목록 모달 시작-->
<div class="modal fade " id="jcListPopUpModal" tabindex="-1" role="dialog" aria-labelledby="jcListPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:750px;">
		<div class="modal-content" >
			<div class="modal-header">
				<h5 class="modal-title">잡체인지 목록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<div class="card">
					
				</div>
				<!-- .table-responsive -->
				<div class="jcListModal" style="height: 78vh; border-bottom: 1px solid #e3e3e3;" id="jcListDiv">
					<label class="input-label-sm ml-2">설비명</label>
					<select id="jcEquipCd" class="custom-select ml-1"></select>
					<button type="button" class="btn btn-warning ml-2" name="jobChangeDelete" id="jobChangeDelete">삭제</button>
					<br>
					
					<table id="jcListTable" class="table table-bordered" style="text-align: center">						
						<thead class="thead-light">
							<tr>
								<th>호기</th>
								<th>제품명</th>
								<th>재질</th>
								<th>잡체인지 일자</th>
								<th>잡체인지 시작일</th>
								<th>잡체인지 종료일</th>
							</tr>
						</thead>						
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">			
				<button type="button" class="btn btn btn-secondary" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 잡체인지 목록 모달 종료 -->

<!-- 수율 모달 시작 -->
<div class="modal fade" id="yeildPopupModal" tabindex="-1" role="dialog" aria-labelledby="yeildPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:750px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="yeildModalLabel">수율입력</h5>			
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"></button>
			</div>
			
			<div class="modal-body">				
						
						<button type="button" class="btn btn-primary float-right" id="btnLoading"  style="min-width: 70px; margin-bottom:5px;">불러오기</button>	
					
					<table id="yeildTable" class="table table-bordered">
						<tr>
							<th>가동률 목표</th>
							<th>검사수율 목표</th>												
						</tr>
						<tr>
							<td><input type="text" class="form-control text-right number-float3" style="min-width:100%;" id="yeild1" value="0"></td>
							<td><input type="text" class="form-control text-right number-float3" style="min-width:100%;" id="yeild2" value="0"></td>												
						</tr>
						
					</table>					
				
			</div>
			<div class="modal-footer">
				
				<button type="button" class="btn btn-primary mr-2" id="btnYeildSave"   data-dismiss="modal" style="min-width: 70px;">저장</button>				
				<button type="button" class="btn btn btn-secondary" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 수율 모달 끝 -->

<!-- 설명 모달 시작-->
<div class="modal fade " id="infoPopUpModal" tabindex="-1" role="dialog" aria-labelledby="infoPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1200px;">
		<div class="modal-content" >
			<div class="modal-header">
				<h5 class="modal-title">사용법</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<br>
			<div class="modal-body">
				<div class="card">
					
				</div>
				<!-- .table-responsive -->
				<div class="infoModal" style="height: 78vh; border-bottom: 1px solid #e3e3e3; overflow:scroll;" id="jcListDiv">
					<h5>1. 최초등록전 기준정보관리에 제조조건관리에서 각 <span style="color:red">A호기</span>들에 <span style="color:red">메인구분과 FP사용유무</span>를 설정한다.<br>
						 &nbsp;1-1 ) 메인구분에 메인체크는 호기당 하나만 한다.<br>
						 &nbsp;1-2 ) FP사용유무는 B호기에 체크된것도 포함된다.<br><br>
						
						2. 최초등록전 기준정보관리에 제품코드관리에서 각 제품들의 <span style="color:red">TAC_TIME</span>과 기종을 설정한다.<br><br>
						
						3. 본 화면에서 수율버튼을 클릭하여 해당월의 수율을 입력한다.<br><br>
						
						4. <span style="color:red">*제품란이 공란일 경우*</span> 제조조건 / 전월제품 버튼을 클릭하여 제품들을 불러온다.<br><br>						
						
						5. 입력버튼을 누르고 비가동구분과 시간을 입력한다.<br><br>
						
						6. 저장 버튼을 클릭한다.<br><br>
						
						7. 잡체인지 버튼을 눌러 잡체인지를 등록한다.<br><br>
						
						8. 잡체인지를 입력할때 완전비가동이 아닌 날짜를 잡체인지 일자에 넣고 잡체인지를 입력한다. <br>
						 &nbsp;7-1) 해당 날짜의 잡체인지로 인한 비가동 시간이 24시간이 아닐경우를 뜻하며, 보통의 경우 시작날 또는 마지막날 일것<br>
						 &nbsp;7-2) 해당기간 완전비가동일 경우 시작날을 기준으로 잡체인지 일자를 등록 <br>
						  &nbsp; &nbsp; &nbsp; &nbsp;(편의에 따라 마지막날로 해도 괜찮지만 추후 수정시 헷갈릴 수 있음)<br><br>
						
						9. 잡체인지까지 입력이 완료되면 확정버튼을 누른다.<br>
						&nbsp;&nbsp;(확정을 하게되면 수정이 어려우니 확정버튼을 누르기전에 확인을 정확히 할 것)<br><br>
						
						&nbsp;**입력버튼을 클릭하여 입력이 활성화 되었을때 x키를 누르면 자동 드래그 모드가 활성화 됩니다.<br><br>
						
						X키를 클릭 할 때 마다 모드가 변경됩니다. <br>
						&nbsp;1.&nbsp; 기본 모드 (칸을 클릭할때 선택)<br>
						&nbsp;2.&nbsp; 드래그 모드 (칸 위를 마우스로 움직이게 되면 마우스가 지나간 자리모두 선택)<br>
						&nbsp;3.&nbsp; 드래그 해제 모드 (칸 위를 마우스로 움직이게 되면 마우스가 지나간 자리모두 선택해제)<br>
					</h5>
					
				</div>
				<!-- /.table-responsive -->
			</div>
			<div class="modal-footer">			
				<button type="button" class="btn btn btn-secondary" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 설명 모달 종료 -->

<%@include file="../layout/bottom.jsp"%>

<style>
td.red{
	background-color : red;
}
td.yellow{
	background-color : yellow;
}
td.gray{
	background-color : gray;
}
td.skyblue{
	background-color : skyblue;
}
td.green{
	background-color : green;
}
td.pink{
	background-color : pink;
}
.highlight {
	background-color: #ECFFB3;
}
.tr_highlight_row tr:hover {
	background-color: #ECFFB3;
}

#productionPlanTable_wrapper{
	font-size: 14px !important;
}

#productionPlanTable_wrapper td{
	height: 20px !important;
	padding : 0.1px !important;
	
}

#productionPlanTable_wrapper input[type=text]{
	font-size: 14px !important;
	height: 20px !important;
	padding : 0.1px !important;
}

</style>

<script>

	let menuAuth = 'wmsc0210';
	let currentHref = 'wmsc0210';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active'); 
	$(document).attr("title","월별 설비 JC 및 PM 일정(확정판)");	
    var inWhsDateCal = "${serverDate}";  
	inWhsDateCal = inWhsDateCal.substring(0,7);
	var temp = true;
	let editGubun = false;
	let fpGubunja = "001";
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
    let tableIdx = '';

    
    <c:forEach items="${equipCodeAdmList}" var="info">
		var json = new Object();
		json.equipCd="${info.equipCd}";
		json.equipNm="${info.equipNm}";
		equipCodeList.push(json);
	
    </c:forEach>

    var npGubunList = new Array();
    <c:forEach items="${npGubunList}" var="info">
	var json = new Object();
	json.baseCd="${info.baseCd}";
	json.baseCdNm="${info.baseCdNm}";
	json.etc1="${info.etc1}";
	json.etc2="${info.etc2}";
	npGubunList.push(json);

	</c:forEach>
  	//공통코드 종료
  	
  	var jobCh = new Object();
  	jobCh.baseCd="999";
  	jobCh.baseCdNm="잡체인지";  	
  	jobCh.etc2="pink";
  	npGubunList.push(jobCh);
  	
  	
  	
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

	selectBoxAppendFaulty(npGubunList, "npGubun", "", "2");
	selectBoxAppend(equipCodeList, "jcEquipCd", "", "2");
	selectTotalBoxAppend(equipCodeList, "equipSelect", "", "2");
	
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

	function selectBoxAppendFaulty(obj, id, sVal, flag) {
		$('#'+ id).empty();

		if(flag == '1') {
			$('#'+ id).append($("<option value=''>"+ "전체" +"</option>"));
	   	} else if(flag == '2') {
	   		$('#'+ id).append($("<option value=''>"+ "선택" +"</option>"));
	   	}
	   		
		for(key in obj) {
			var option;
			if(obj[key].baseCd == sVal ) {
				option = $("<option value="+ obj[key].baseCd+ " selected>"+obj[key].baseCdNm+"</option>");
			} else {
				option = $("<option value="+obj[key].baseCd+">"+obj[key].baseCdNm+"</option>");
			}	
			$('#'+ id).append(option);
		}
	}
	//월별 일자 생성
	createHeader();
	createHeaderMan();

	
    // 목록
	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin = $('#productionPlanTable').parent().html();
	let monthProductPresentTable = monthProductPresentTableFunc();

	$.fn.dataTable.ext.errMode = 'none';
	let monthProductPresentTableOrigin2 = $('#planManTable').parent().html();
	let monthProductPresentTable2 = monthProductPresentTableFunc2();
	


	$('#inWhsDateCal').val(inWhsDateCal);



    $('#btnRetv').on('click', function() {

    	$('#my-spinner').show();
    	fpGubunja = "001";
    	inWhsDateCal =  $('#inWhsDateCal').val();
    	$('#allInputSetting').val("0");
    	$("#btnSave").attr("disabled", true);
    	$("#allInputSetting").attr("disabled", true);  
    	$("#btnEquipInputSetting").attr("disabled", true);
    	$("#btnFaultyGubun").attr("disabled", true);
    	editGubun = false;
    	createDayInput();
    	temp = true;
    	$('.table-responsive').html(monthProductPresentTableOrigin);
    	createHeader().then(()=>{
		
       		monthProductPresentTable = monthProductPresentTableFunc();       	
        });

    	
		
    });

    //전월제품 버튼 클릭시
    $('#btnOption1').on('click', function() {
    	
   		$.ajax({
       		url: '<c:url value="wm/readMonthPlanBodySLDCheck"/>',
   			type: 'POST',  
   			async: false,
   			data: {
   				'menuAuth'	:	menuAuth,
   				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
   				'cplGubun'	:	function(){return "001";},		
   				
   			},
               success: function (res) {
                   let data = res.data;
                   if (res.result == 'ok') { //미확정시
                	   $('#my-spinner').show();    	
                	   fpGubunja = "002"
                	   inWhsDateCal =  $('#inWhsDateCal').val();
                       $('#allInputSetting').val("0");
                       $("#btnSave").attr("disabled", true);
                      	$("#allInputSetting").attr("disabled", true);  
                      	$("#btnEquipInputSetting").attr("disabled", true);
                      	$("#btnFaultyGubun").attr("disabled", true);
                      	editGubun = false;
                      	createDayInput();
                      	temp = true;
                      	$('.table-responsive').html(monthProductPresentTableOrigin);
                      	createHeader().then(()=>{
                  		
                         		monthProductPresentTable = monthProductPresentTableFunc();       	
                         });
                      	
                   } else if(res.result == 'fail'){ //확정시                     
                		toastr.warning("이미 등록된 FP가 있습니다.");                   	
                   	
                   } else{ //에러
                   	toastr.error(res.message, '', {timeOut: 5000});
                   }
               },
               complete:function(){
            	   $('#my-spinner').hide();
               }
           });
        
    	

    });

    // 제조조건 버튼 클릭시
    $('#btnOption2').on('click', function() {
    	
   		$.ajax({
       		url: '<c:url value="wm/readMonthPlanBodySLDCheck"/>',
   			type: 'POST',  
   			async: false,
   			data: {
   				'menuAuth'	:	menuAuth,
   				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
   				'cplGubun'	:	function(){return "001";},		
   				
   			},
               success: function (res) {
                   let data = res.data;
                   if (res.result == 'ok') { //미확정시
                	   $('#my-spinner').show();    	
                	   fpGubunja = "003"
                	   inWhsDateCal =  $('#inWhsDateCal').val();
                       $('#allInputSetting').val("0");
                       $("#btnSave").attr("disabled", true);
                      	$("#allInputSetting").attr("disabled", true);  
                      	$("#btnEquipInputSetting").attr("disabled", true);
                      	$("#btnFaultyGubun").attr("disabled", true);
                      	editGubun = false;
                      	createDayInput();
                      	temp = true;
                      	$('.table-responsive').html(monthProductPresentTableOrigin);
                      	createHeader().then(()=>{
                  		
                         		monthProductPresentTable = monthProductPresentTableFunc();       	
                         });
                   } else if(res.result == 'fail'){ //확정시                     
                	   toastr.warning("이미 등록된 FP가 있습니다.");                   	
                   	
                   } else{ //에러
                   	toastr.error(res.message, '', {timeOut: 5000});
                   }
               },
               complete:function(){
            	   $('#my-spinner').hide();    	
               }
           });
    });
    

    //수정버튼
    $('#btnEdit').on('click', function() {        	
    	
    	$.ajax({
    		url: '<c:url value="wm/checkCompleteYn"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				'cplGubun'	:	function(){return "001";},				
			},
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') { //미확정시
                	$("#btnSave").attr("disabled", false);
                	$("#btnFaultyGubun").attr("disabled", false);      
                	
                	$("#btnEquipInputSetting").attr("disabled", false);
                
                	editGubun = true;
                	//$('.touchTd').attr("disabled", false);
                	//$('.touchTdNone').attr("disabled", false);
                } else if(res.result == 'error'){ //확정시
                    //모달추가해서 확인절차후 수정가능하게 해줘야함
                    $('#editCheckPopupModal').modal('show');
                	toastr.warning(res.message, '', {timeOut: 5000});
                	
                } else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                
            }
        });

        
    });

	//수정확인버튼
	$('#btnEditCheck').on('click', function() {  
		$("#btnSave").attr("disabled", false);
    	$("#btnFaultyGubun").attr("disabled", false);      
    	//$('.touchTd').attr("disabled", false);
    	//$('.touchTdNone').attr("disabled", false);
    	
    	$("#btnEquipInputSetting").attr("disabled", false);
    	editGubun = true;
	});



	//확정버튼
    $('#btnComplete').on('click', function() {  
        
    	$.ajax({
    		url: '<c:url value="wm/updateCompleteYn"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				'cplGubun'	:	function(){return "001";},
				'completeYn'	:	function(){return "001";},				
			},
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') { 
                	$('#btnRetv').click();
                	toastr.success("확정되었습니다.", '', {timeOut: 5000});
                	
                } else if(res.result == 'error'){ //저장이 안되어있을시
                
                	toastr.warning(res.message, '', {timeOut: 5000});
                	
                } else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                
            }
        });


        
    });

    
    //저장
	$('#btnSave').on('click', function() {

		$('#my-spinner').show();
		
		dataList = new Array();
		$('#productionPlanTable tbody tr').each(function(index,item){
			var equipCd = $('#productionPlanTable').DataTable().row(this).data().equipCd;
			var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");

			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.equipCd = equipCd;
		 	rowData001.goodsCd = ($('#productionPlanTable').DataTable().row(this).data().goodsCd == null) ? "" : $('#productionPlanTable').DataTable().row(this).data().goodsCd;
		 	rowData001.fpDate = inWhsDateCal;
		 	rowData001.cplGubun = "001";
		 	rowData001.completeYn = "002";
	
	
			rowData001.count1 = ($('#' + equipCd + 'count1').val()!=null && $('#' + equipCd + 'count1').val()!="") ? $('#' + equipCd + 'count1').val() : "0";
			rowData001.count2 = ($('#' + equipCd + 'count2').val()!=null && $('#' + equipCd + 'count2').val()!="") ? $('#' + equipCd + 'count2').val() : "0";
			rowData001.count3 = ($('#' + equipCd + 'count3').val()!=null && $('#' + equipCd + 'count3').val()!="") ? $('#' + equipCd + 'count3').val() : "0";
			rowData001.count4 = ($('#' + equipCd + 'count4').val()!=null && $('#' + equipCd + 'count4').val()!="") ? $('#' + equipCd + 'count4').val() : "0";
			rowData001.count5 = ($('#' + equipCd + 'count5').val()!=null && $('#' + equipCd + 'count5').val()!="") ? $('#' + equipCd + 'count5').val() : "0";
			rowData001.count6 = ($('#' + equipCd + 'count6').val()!=null && $('#' + equipCd + 'count6').val()!="") ? $('#' + equipCd + 'count6').val() : "0";
			rowData001.count7 = ($('#' + equipCd + 'count7').val()!=null && $('#' + equipCd + 'count7').val()!="") ? $('#' + equipCd + 'count7').val() : "0";
			rowData001.count8 = ($('#' + equipCd + 'count8').val()!=null && $('#' + equipCd + 'count8').val()!="") ? $('#' + equipCd + 'count8').val() : "0";
			rowData001.count9 = ($('#' + equipCd + 'count9').val()!=null && $('#' + equipCd + 'count9').val()!="") ? $('#' + equipCd + 'count9').val() : "0";
			rowData001.count10 = ($('#' + equipCd + 'count10').val()!=null && $('#' + equipCd + 'count10').val()!="") ? $('#' + equipCd + 'count10').val() : "0";
			rowData001.count11 = ($('#' + equipCd + 'count11').val()!=null && $('#' + equipCd + 'count11').val()!="") ? $('#' + equipCd + 'count11').val() : "0";
			rowData001.count12 = ($('#' + equipCd + 'count12').val()!=null && $('#' + equipCd + 'count12').val()!="") ? $('#' + equipCd + 'count12').val() : "0";
			rowData001.count13 = ($('#' + equipCd + 'count13').val()!=null && $('#' + equipCd + 'count13').val()!="") ? $('#' + equipCd + 'count13').val() : "0";
			rowData001.count14 = ($('#' + equipCd + 'count14').val()!=null && $('#' + equipCd + 'count14').val()!="") ? $('#' + equipCd + 'count14').val() : "0";
			rowData001.count15 = ($('#' + equipCd + 'count15').val()!=null && $('#' + equipCd + 'count15').val()!="") ? $('#' + equipCd + 'count15').val() : "0";
			rowData001.count16 = ($('#' + equipCd + 'count16').val()!=null && $('#' + equipCd + 'count16').val()!="") ? $('#' + equipCd + 'count16').val() : "0";
			rowData001.count17 = ($('#' + equipCd + 'count17').val()!=null && $('#' + equipCd + 'count17').val()!="") ? $('#' + equipCd + 'count17').val() : "0";
			rowData001.count18 = ($('#' + equipCd + 'count18').val()!=null && $('#' + equipCd + 'count18').val()!="") ? $('#' + equipCd + 'count18').val() : "0";
			rowData001.count19 = ($('#' + equipCd + 'count19').val()!=null && $('#' + equipCd + 'count19').val()!="") ? $('#' + equipCd + 'count19').val() : "0";
			rowData001.count20 = ($('#' + equipCd + 'count20').val()!=null && $('#' + equipCd + 'count20').val()!="") ? $('#' + equipCd + 'count20').val() : "0";
			rowData001.count21 = ($('#' + equipCd + 'count21').val()!=null && $('#' + equipCd + 'count21').val()!="") ? $('#' + equipCd + 'count21').val() : "0";
			rowData001.count22 = ($('#' + equipCd + 'count22').val()!=null && $('#' + equipCd + 'count22').val()!="") ? $('#' + equipCd + 'count22').val() : "0";
			rowData001.count23 = ($('#' + equipCd + 'count23').val()!=null && $('#' + equipCd + 'count23').val()!="") ? $('#' + equipCd + 'count23').val() : "0";
			rowData001.count24 = ($('#' + equipCd + 'count24').val()!=null && $('#' + equipCd + 'count24').val()!="") ? $('#' + equipCd + 'count24').val() : "0";
			rowData001.count25 = ($('#' + equipCd + 'count25').val()!=null && $('#' + equipCd + 'count25').val()!="") ? $('#' + equipCd + 'count25').val() : "0";
			rowData001.count26 = ($('#' + equipCd + 'count26').val()!=null && $('#' + equipCd + 'count26').val()!="") ? $('#' + equipCd + 'count26').val() : "0";
			rowData001.count27 = ($('#' + equipCd + 'count27').val()!=null && $('#' + equipCd + 'count27').val()!="") ? $('#' + equipCd + 'count27').val() : "0";
			rowData001.count28 = ($('#' + equipCd + 'count28').val()!=null && $('#' + equipCd + 'count28').val()!="") ? $('#' + equipCd + 'count28').val() : "0";
			rowData001.count29 = ($('#' + equipCd + 'count29').val()!=null && $('#' + equipCd + 'count29').val()!="") ? $('#' + equipCd + 'count29').val() : "0";
			rowData001.count30 = ($('#' + equipCd + 'count30').val()!=null && $('#' + equipCd + 'count30').val()!="") ? $('#' + equipCd + 'count30').val() : "0";
			rowData001.count31 = ($('#' + equipCd + 'count31').val()!=null && $('#' + equipCd + 'count31').val()!="") ? $('#' + equipCd + 'count31').val() : "0";

			rowData001.npTime1 = ($('#' + equipCd + 'npTime1').val()!=null && $('#' + equipCd + 'npTime1').val()!="") ? $('#' + equipCd + 'npTime1').val() : "0";
			rowData001.npTime2 = ($('#' + equipCd + 'npTime2').val()!=null && $('#' + equipCd + 'npTime2').val()!="") ? $('#' + equipCd + 'npTime2').val() : "0";
			rowData001.npTime3 = ($('#' + equipCd + 'npTime3').val()!=null && $('#' + equipCd + 'npTime3').val()!="") ? $('#' + equipCd + 'npTime3').val() : "0";
			rowData001.npTime4 = ($('#' + equipCd + 'npTime4').val()!=null && $('#' + equipCd + 'npTime4').val()!="") ? $('#' + equipCd + 'npTime4').val() : "0";
			rowData001.npTime5 = ($('#' + equipCd + 'npTime5').val()!=null && $('#' + equipCd + 'npTime5').val()!="") ? $('#' + equipCd + 'npTime5').val() : "0";
			rowData001.npTime6 = ($('#' + equipCd + 'npTime6').val()!=null && $('#' + equipCd + 'npTime6').val()!="") ? $('#' + equipCd + 'npTime6').val() : "0";
			rowData001.npTime7 = ($('#' + equipCd + 'npTime7').val()!=null && $('#' + equipCd + 'npTime7').val()!="") ? $('#' + equipCd + 'npTime7').val() : "0";
			rowData001.npTime8 = ($('#' + equipCd + 'npTime8').val()!=null && $('#' + equipCd + 'npTime8').val()!="") ? $('#' + equipCd + 'npTime8').val() : "0";
			rowData001.npTime9 = ($('#' + equipCd + 'npTime9').val()!=null && $('#' + equipCd + 'npTime9').val()!="") ? $('#' + equipCd + 'npTime9').val() : "0";
			rowData001.npTime10 = ($('#' + equipCd + 'npTime10').val()!=null && $('#' + equipCd + 'npTime10').val()!="") ? $('#' + equipCd + 'npTime10').val() : "0";
			rowData001.npTime11 = ($('#' + equipCd + 'npTime11').val()!=null && $('#' + equipCd + 'npTime11').val()!="") ? $('#' + equipCd + 'npTime11').val() : "0";
			rowData001.npTime12 = ($('#' + equipCd + 'npTime12').val()!=null && $('#' + equipCd + 'npTime12').val()!="") ? $('#' + equipCd + 'npTime12').val() : "0";
			rowData001.npTime13 = ($('#' + equipCd + 'npTime13').val()!=null && $('#' + equipCd + 'npTime13').val()!="") ? $('#' + equipCd + 'npTime13').val() : "0";
			rowData001.npTime14 = ($('#' + equipCd + 'npTime14').val()!=null && $('#' + equipCd + 'npTime14').val()!="") ? $('#' + equipCd + 'npTime14').val() : "0";
			rowData001.npTime15 = ($('#' + equipCd + 'npTime15').val()!=null && $('#' + equipCd + 'npTime15').val()!="") ? $('#' + equipCd + 'npTime15').val() : "0";
			rowData001.npTime16 = ($('#' + equipCd + 'npTime16').val()!=null && $('#' + equipCd + 'npTime16').val()!="") ? $('#' + equipCd + 'npTime16').val() : "0";
			rowData001.npTime17 = ($('#' + equipCd + 'npTime17').val()!=null && $('#' + equipCd + 'npTime17').val()!="") ? $('#' + equipCd + 'npTime17').val() : "0";
			rowData001.npTime18 = ($('#' + equipCd + 'npTime18').val()!=null && $('#' + equipCd + 'npTime18').val()!="") ? $('#' + equipCd + 'npTime18').val() : "0";
			rowData001.npTime19 = ($('#' + equipCd + 'npTime19').val()!=null && $('#' + equipCd + 'npTime19').val()!="") ? $('#' + equipCd + 'npTime19').val() : "0";
			rowData001.npTime20 = ($('#' + equipCd + 'npTime20').val()!=null && $('#' + equipCd + 'npTime20').val()!="") ? $('#' + equipCd + 'npTime20').val() : "0";
			rowData001.npTime21 = ($('#' + equipCd + 'npTime21').val()!=null && $('#' + equipCd + 'npTime21').val()!="") ? $('#' + equipCd + 'npTime21').val() : "0";
			rowData001.npTime22 = ($('#' + equipCd + 'npTime22').val()!=null && $('#' + equipCd + 'npTime22').val()!="") ? $('#' + equipCd + 'npTime22').val() : "0";
			rowData001.npTime23 = ($('#' + equipCd + 'npTime23').val()!=null && $('#' + equipCd + 'npTime23').val()!="") ? $('#' + equipCd + 'npTime23').val() : "0";
			rowData001.npTime24 = ($('#' + equipCd + 'npTime24').val()!=null && $('#' + equipCd + 'npTime24').val()!="") ? $('#' + equipCd + 'npTime24').val() : "0";
			rowData001.npTime25 = ($('#' + equipCd + 'npTime25').val()!=null && $('#' + equipCd + 'npTime25').val()!="") ? $('#' + equipCd + 'npTime25').val() : "0";
			rowData001.npTime26 = ($('#' + equipCd + 'npTime26').val()!=null && $('#' + equipCd + 'npTime26').val()!="") ? $('#' + equipCd + 'npTime26').val() : "0";
			rowData001.npTime27 = ($('#' + equipCd + 'npTime27').val()!=null && $('#' + equipCd + 'npTime27').val()!="") ? $('#' + equipCd + 'npTime27').val() : "0";
			rowData001.npTime28 = ($('#' + equipCd + 'npTime28').val()!=null && $('#' + equipCd + 'npTime28').val()!="") ? $('#' + equipCd + 'npTime28').val() : "0";
			rowData001.npTime29 = ($('#' + equipCd + 'npTime29').val()!=null && $('#' + equipCd + 'npTime29').val()!="") ? $('#' + equipCd + 'npTime29').val() : "0";
			rowData001.npTime30 = ($('#' + equipCd + 'npTime30').val()!=null && $('#' + equipCd + 'npTime30').val()!="") ? $('#' + equipCd + 'npTime30').val() : "0";
			rowData001.npTime31 = ($('#' + equipCd + 'npTime31').val()!=null && $('#' + equipCd + 'npTime31').val()!="") ? $('#' + equipCd + 'npTime31').val() : "0";
	        
			dataList.push(rowData001);

		});
		//console.log(dataList);

		$.ajax({
            url: '<c:url value="/wm/insertMonthProductionPlan"/>',
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
                let rescheckJobChange = res.checkJobChange;
                if (res.result == 'ok') {
                	$("#btnSave").attr("disabled", true);                	
                	$("#allInputSetting").attr("disabled", true);  
                	$("#btnEquipInputSetting").attr("disabled", true);
                	$("#btnFaultyGubun").attr("disabled", true);
                	$('.touchTd').attr("disabled", true);
                	$('.touchTdNone').attr("disabled", true);
                	editGubun = false;
                	
                	$('#productionPlanTable').DataTable().ajax.reload( function () {$('#productionPlanTable').DataTable().columns.adjust();});
					
                	
                	toastr.success(res.message);
					if(rescheckJobChange == "001"){
						toastr.success("잡체인지를 다시 등록하여 주세요");
					}
                } else {
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	$('#my-spinner').hide();
            }
        });
        
	});
	 

  
	//특정설비 일괄입력
	$('#btnEquipInputSetting').on('click', function() {
		selectBoxAppend(equipCodeList, "equipCd", "", "1");
		selectBoxAppendFaulty(npGubunList, "totalInput", "", "2");
		selectBoxAppend(totalInputList, "totalInputAll", "", "1");
		selectBoxAppend(dayInputList, "dayEquipInputAll", "", "1");
		$('#equipInputSetting').addClass('number-float0'); 
		$('#equipInputSetting').val("0");
		$('#equipInputPopupModal').modal('show');
    });

    //특정설비 일괄입력
	$('#btnEquipInputExecute').on('click', function() {
		var equipCd = $("#equipCd option:selected").val();
		let npTime = '0';


		if($('#equipInputSetting').val() > 24){			
			toastr.warning("입력시간이 24시간을 넘을 수 없습니다.");
			$('#equipInputSetting').focus();
			return false;			
		}
		if($('#equipInputSetting').val() == "0"){			
			toastr.warning("비가동시간을 입력해 주세요.");
			$('#equipInputSetting').focus();
			return false;			
		}
		
		var dayCd = parseInt($("#dayEquipInputAll option:selected").val()) + 1;
		
		if ($("#dayEquipInputAll option:selected").val() == '') {
		
			dayCd = 99;						
		}

		if($('#totalInput').val() == ''){
			toastr.warning('구분을 선택해 주세요.');
			return false;
		} 

/* 		$.each(npGubunList,function(index,item){
        	if(item.baseCd == $('#totalInput').val()){            	
            	npTime = item.etc1;       		
    		}
        }); */

        npTime = $('#equipInputSetting').val();
	
		$('#my-spinner').show();
		if(dayCd != 99){ 
			// 특정 날짜 선택한 경우
			
			if(equipCd != '' && equipCd != null){
				if($('#totalInput').val() == ''){
					$('#' + equipCd + 'count' + dayCd ).closest('td').attr('class','');	
					$('#' + equipCd + 'count' + dayCd ).val("0");
					$('#' + equipCd + 'npTime' + dayCd ).val("0");
				} else{				
					$('#' + equipCd + 'count' + dayCd ).closest('td').attr('class',colorChange('totalInput'));		
					$('#' + equipCd + 'count' + dayCd ).val($('#totalInput').val());
					$('#' + equipCd + 'npTime' + dayCd ).val(npTime);
				}
					
			} else{
				if($('#totalInput').val() == ''){
					for(var i=1; i <= equipCodeList.length; i++){
						$('#' + equipCodeList[i-1].equipCd + 'count' + dayCd ).closest('td').attr('class','');
						$('#' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val("0");
						$('#' + equipCodeList[i-1].equipCd + 'npTime' + dayCd ).val("0");
					}
				} else{
					for(var i=1; i <= equipCodeList.length; i++){
						$('#' + equipCodeList[i-1].equipCd + 'count' + dayCd ).closest('td').attr('class',colorChange('totalInput'));
						$('#' + equipCodeList[i-1].equipCd + 'count' + dayCd ).val($('#totalInput').val());
						$('#' + equipCodeList[i-1].equipCd + 'npTime' + dayCd ).val(npTime);
					}	
				}
				
			}
						
		
		} else{
			// 전체 날짜를 선택한 경우
			
			for (var j=0; j<dayCount; j++) {
				for(var i=1; i <= equipCodeList.length; i++){
					if(equipCd != '' && equipCd != null){
						if($('#totalInput').val() == ''){
							$('#' + equipCd + 'count' + (j+1) ).closest('td').attr('class','');			
							$('#' + equipCd + 'count' + (j+1) ).val("0");			
							$('#' + equipCd + 'npTime' + (j+1) ).val("0");
						} else{
							$('#' + equipCd + 'count' + (j+1) ).closest('td').attr('class',colorChange('totalInput'));			
							$('#' + equipCd + 'count' + (j+1) ).val($('#totalInput').val());			
							$('#' + equipCd + 'npTime' + (j+1) ).val(npTime);
						}
					} else{
						if($('#totalInput').val() == ''){
							for(var i=1; i <= equipCodeList.length; i++){
								$('#' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).closest('td').attr('class','');
								$('#' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val("0");
								$('#' + equipCodeList[i-1].equipCd + 'npTime' + (j+1) ).val("0");
							}
						} else{
							for(var i=1; i <= equipCodeList.length; i++){
								$('#' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).closest('td').attr('class',colorChange('totalInput'));
								$('#' + equipCodeList[i-1].equipCd + 'count' + (j+1) ).val($('#totalInput').val());
								$('#' + equipCodeList[i-1].equipCd + 'npTime' + (j+1) ).val(npTime);
							}
						}
						
						
					}	
				}			
			}
	
			
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
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						//var planHeader = '<th class="text-center" style="vertical-align:middle; min-width:100px;">라인</th>';
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:70px;">설비</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:100px;">제품명</th>';
							planHeader += '<th class="text-center"style="vertical-align:middle; min-width:70px;">재질</th>';
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:50px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:50px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; color:red; min-width:50px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center day' + (i+1) + '" style="vertical-align:middle; min-width:50px;">' + data[i].countDay + '</th>';
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

	function createHeaderMan(){
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
					if (res.result="ok"){
						dayCount = res.dayCount;
						//toastr.success(dayCount);
						var data = res.data;
						var planHeader = '<th class="text-center"style="vertical-align:middle; min-width:100px;">구분</th>';
					
						for (var i=0; i<data.length; i++) {
							//존재하지 않는 날짜
							if (data[i].day == 0) {
								planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:orange; min-width:70px;">' + data[i].countDay + '</th>';
							//토요일
							} else if (data[i].day == 7) {
								planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:blue; min-width:70px;">' + data[i].countDay + '</th>';
							//일요일
							} else if (data[i].day == 1)
								planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; color:red; min-width:70px;">' + data[i].countDay + '</th>';
							//그외
							else {
								planHeader += '<th class="text-center mday' + (i+1) + '" style="vertical-align:middle; min-width:70px;">' + data[i].countDay + '</th>';
							}
						}
						//$('#planHeader').html(planHeader);
						$('#planHeaderMan').html(planHeader).promise().done(function(){
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
					if (res.result="ok"){
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
        				"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>"+'B',
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
        		scrollY: '68vh',
        		scrollX: true,
        		fixedColumns: {
        			leftColumns: 3
        		},
        		ajax: {
                    url: '<c:url value="/wm/readMonthPlanBodySLD"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
                    	'cplGubun'		:		function(){return "001";},
                    	'fpGubunja'		:		function(){return fpGubunja;}
                    },
                    /*
                    success : function(res) {
                        console.log(res);
                    }
                    */
                },
                columns: [
                	//{ data: 'equipLineNm', },
                	{ data: 'equipNm' ,
    	        		render: function(data, type, row) {
    	        				let html = data + '<input type="hidden" id="jobEquipCd" value="SBSLD-M-01">';
								return html;
    	                }
    	                    
    	        		
	        		},
                	{ data: 'goodsNm' },
                	{ data: 'qutyNm'  },
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         	{ data: 'planDate${item}' ,
    	        		render: function(data, type, row) {
    	        			if(data == 'null'){        	        			
    	                		let html = '<input type="hidden" class="form-control text-center touchTdNone" disabled id="'+ row["equipCd"] + 'count${item}" name="count' + '${item}'+ '" value = ' + "0" + '>';
    	                			html += '<input type="text" class="form-control text-center touchTdNone" disabled style="background-color:transparent;border:none;pointer-events: none;" id="'+ row["equipCd"] + 'npTime${item}" name="npTime' + '${item}'+ '" value = ' + "" + '>';
								return html;    	                			
    	                	} else{    	                	
        	                	
    	                		let html = '<input type="hidden" class="form-control text-center touchTd" disabled id="'+ row["equipCd"] + 'count${item}" name="count' + '${item}'+ '" value = ' + row["gubun${item}"] + '>';
    	                    		html += '<input type="text" class="form-control text-center touchTd"  disabled style="background-color:transparent;border:none;pointer-events: none;" id="'+ row["equipCd"] + 'npTime${item}" name="npTime' + '${item}'+ '" value = ' + data + '>';
								return html;
    	                	}
    	                    
    	        		}
    	    		},    		
        		</c:forEach>
                ],
        		
                columnDefs: [
                	
                	{ targets: [3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33], className: 'text-right-td' },
                ],
                //order: [
                //    [ 1, 'asc' ],
                //],
        		buttons: [
        			{
        			    extend: 'copy',
        				title: '월별 설비 JC 및 PM 일정(확정판)',
        			},
        			{
       				 extend: 'excel',        		         
       			    title: '월별 설비 JC 및 PM 일정(확정판)',
       			   
       			    exportOptions: {
           			    format: {
           			    	columns: ':visible',
       			    		body: function ( data, row, column, node ) {
		        			    	// jquery를 사용하여 type이 입력되었는지 확인
		        			    	let aa = data.split('<');
		        			    	let bb = (aa[0]=='')?'<'+aa[2]:aa[0];

		        			    	return $(bb).is("input") ? $(bb).val() : bb;
       			    		}
           			    }
       			    },
   			    	 customize: function( xlsx ) {
       	                var sheet = xlsx.xl.worksheets['sheet1.xml'];
       	                var charCode = "A".charCodeAt(0);
       	                //String.fromCharCode(charCode + i)
       	                
       	                let tableA = $('#productionPlanTable').DataTable();
       			 		let data = tableA.rows().data();
       			 		let dataC = tableA.columns().data();
       			 		let row,message,bgColor='';
       			 		

       			 	
       			 	    for(var i=0; i<data.count(); i++){
       			 	    	//for(var j=3; j<=25; j++){
       			 	    		let ii = 0;
       			 	    		row=i+3; 
       			 	    		
       			 	    		//if(tableA.row(i).data().gubun+j=="999"){
           						//	row=i+3;        							
           						//	bgColor = '15';        							       		                
           						//}
           						<c:forEach var="item" begin="1" end="23" step="1">
           							
	            						if(tableA.row(i).data().gubun${item}=="999"){ //잡체인지 분홍
												
	               							bgColor = '15';        							       		                
	               						}
		           			 	    	if(tableA.row(i).data().gubun${item}=="001"){ //샘플생산 파랑
		           														
		           							bgColor = '20';        							       		                
		           						}
			           			 	    if(tableA.row(i).data().gubun${item}=="002"){ //설비PM 회색
		           														
		           							bgColor = '5';        							       		                
		           						}
				           			 	if(tableA.row(i).data().gubun${item}=="004"){ //기타 빨강
		           							      							
		           							bgColor = '10';        							       		                
		           						}
		           					
		           				
		           						$('row:eq('+(row-1)+') c[r^='+String.fromCharCode(charCode + ${item} + 2)+']', sheet).attr( 's', '' + bgColor + '' );
			           				
           						</c:forEach>
           						

			           			
           						<c:forEach var="item" begin="24" end="31" step="1">
	        							
	            						if(tableA.row(i).data().gubun${item}=="999"){ //잡체인지 분홍
												
	               							bgColor = '15';        							       		                
	               						}
		           			 	    	if(tableA.row(i).data().gubun${item}=="001"){ //샘플생산 파랑
		           														
		           							bgColor = '20';        							       		                
		           						}
			           			 	    if(tableA.row(i).data().gubun${item}=="002"){ //설비PM 회색
		           														
		           							bgColor = '5';        							       		                
		           						}
				           			 	if(tableA.row(i).data().gubun${item}=="004"){ //기타 빨강
		           							      							
		           							bgColor = '10';        							       		                
		           						}
		           					
			           				
			           					$('row:eq('+(row-1)+') c[r^='+"A"+String.fromCharCode(charCode + ii)+']', sheet).attr( 's', '' + bgColor + '' );
				           				ii++;
	        						</c:forEach>

       			 	    	//}
      			 	    	/* 	for(var j=0; j<=7; j++){
          			 	    		row=i+3; 
          			 	    		
          			 	    		
          			 	    		if(tableA.row(i).data().gubun=="999"){ //잡체인지 초록
              														
              							bgColor = '20';        							       		                
              						}
	           			 	    	if(tableA.row(i).data().gubun=="001"){ //샘플생산 파랑
	           													
	           							bgColor = '15';        							       		                
	           						}
		           			 	    if(tableA.row(i).data().gubun=="002"){ //설비PM 회색
	           							    							
	           							bgColor = '5';        							       		                
	           						}
			           			 	if(tableA.row(i).data().gubun=="004"){ //기타 빨강
	           							    							
	           							bgColor = '10';        							       		                
	           						}

			           			 $('row:eq('+(row-1)+') c[r^='+"A"+String.fromCharCode(charCode + j)+']', sheet).attr( 's', '' + bgColor + '');
              						
              		               

          			 	    	} */
       			 	    	//row=i+3;        							
           					//bgColor = '15';  
       			 	    	// $('row:eq('+(row-1)+') c', sheet).attr('s',''+bgColor+'');
       						
       					}     
       	            } 
       			    	
       			    	        			    
       			},
        			{
        			    extend: 'print',
        			    title: '월별 설비 JC 및 PM 일정(확정판)',
        			}
        		],
        		drawCallback:function( settings){
        			//var api = this.api();
        			//api.fixedColumns().update();
        			$.each($('#productionPlanTable tr'),function(index, item){
        				if($('.day27').text()==""){
        					$('#productionPlanTable').DataTable().column( 29 ).visible( false );
        					$(this).find('th').eq(29).addClass('d-none');
        					$(this).find('td').eq(29).addClass('d-none');
        				}
        				if($('.day28').text()==""){
        					$('#productionPlanTable').DataTable().column( 30).visible( false );
        					$(this).find('th').eq(30).addClass('d-none');
        					$(this).find('td').eq(30).addClass('d-none');
        				}
        				if($('.day29').text()==""){
        					$('#productionPlanTable').DataTable().column( 31).visible( false );
        					$(this).find('th').eq(31).addClass('d-none');
        					$(this).find('td').eq(31).addClass('d-none');
        				}
        				if($('.day30').text()==""){
        					$('#productionPlanTable').DataTable().column( 32).visible( false );
        					$(this).find('th').eq(32).addClass('d-none');
        					$(this).find('td').eq(32).addClass('d-none');
        				}
        				if($('.day31').text()==""){
        					$('#productionPlanTable').DataTable().column( 33).visible( false );
        					$(this).find('th').eq(33).addClass('d-none');
        					$(this).find('td').eq(33).addClass('d-none');
        				}
        				
        				if(index == $('#productionPlanTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        }
        			});
        			

					$('.touchTd').each(function(index,item2){
						let thisData = $(this).val();
						let color = '';
						 $.each(npGubunList,function(index,item){
				        	if(item.baseCd == thisData){
				            	color = item.etc2;				            	
				        	}
						});				
						 $(this).closest('td').addClass(color);
						
					});
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				
        				temp = false;
        			}
        			table = $('#productionPlanTable').DataTable();
        		
        		}
            });
        
        return tempTableData;
    }

    function monthProductPresentTableFunc2(){
        //console.log("난 테이블이야")
        let tempTableData = $('#planManTable').on( 'error.dt', function ( e, settings, techNote, message ) {
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
                info: false,       
                ordering: false,
                processing: true,
                autoWidth: false,             
                pageLength: false,
                searching: false,
                //destroy: true, 
        		//header 고정
        		scrollY: '73vh',
        		scrollX: true,
        		fixedColumns: {
        			leftColumns: 1
        		},
        		ajax: {
                    url: '<c:url value="/wm/monthProductionMan"/>',
                    type: 'POST',
                    data: {
                    	'menuAuth'		:		menuAuth,
                    	'fpDate'		:		function(){return inWhsDateCal.replace(/-/g,"");},
                    	'cplGubun'		:		function(){return "001";},
                    },
                    /*
                    success : function(res) {
                        console.log(res);
                    }
                    */
                },
                columns: [
                	//{ data: 'equipLineNm', },
                	{ data: 'dayNightGubun' ,
    	        		render: function(data, type, row) {
    	        				if(data == 'D'){
									return '생산 조(주간)';
        	        			} else{
        	        				return '생산 조(야간)';
            	        		}								
    	                }
	        		},
        			<c:forEach var="item" begin="1" end="31" step="1">
    	         	{ data: 'planDate${item}' ,
    	        		render: function(data, type, row) {
        	       
    	        			if(data == null || data == 'null'){        	        			
    	                		let html = '<input type="text" class="form-control text-center" id="'+row["dayNightGubun"]+'planMan${item}" name="planMan' + '${item}'+ '" value = ' + "" + '>';
								return html;    	                			
    	                	} else{ 
    	                		let html = '<input type="text" class="form-control text-center" id="'+row["dayNightGubun"]+'planMan${item}" name="'+row["dayNightGubun"]+'planMan' + '${item}'+ '" value = ' + data + '>';    	                    		
								return html;
    	                	}
    	                    
    	        		}
    	    		},    		
        		</c:forEach>
                ],
        		
                columnDefs: [
                	
                	{ targets: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31], className: 'text-right-td' },
                ],
               
        	
        		drawCallback:function( settings){
        			//var api = this.api();
        			//api.fixedColumns().update();
        			$.each($('#planManTable tr'),function(index, item){
        				if($('.mday27').text()==""){
        					$(this).find('th').eq(27).addClass('d-none');
        					$(this).find('td').eq(27).addClass('d-none');
        				}
        				if($('.mday28').text()==""){
        					$(this).find('th').eq(28).addClass('d-none');
        					$(this).find('td').eq(28).addClass('d-none');
        				}
        				if($('.mday29').text()==""){
        					$(this).find('th').eq(29).addClass('d-none');
        					$(this).find('td').eq(29).addClass('d-none');
        				}
        				if($('.mday30').text()==""){
        					$(this).find('th').eq(30).addClass('d-none');
        					$(this).find('td').eq(30).addClass('d-none');
        				}
        				if($('.mday31').text()==""){
        					$(this).find('th').eq(31).addClass('d-none');
        					$(this).find('td').eq(31).addClass('d-none');
        				}
        				
        				if(index == $('#planManTable').DataTable().data().count() - 1){
                        	$('#my-spinner').hide();
                        }
        			});					
        			
        			if (temp) {
        				toastr.success('조회되었습니다');
        				temp = false;
        			}


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

    	} else{
    		$('#dayInputSetting').attr('max','99999');
    		$('#dayInputSetting').removeClass('number-float1');
    		$('#dayInputSetting').addClass('number-float0'); 
        }
    });

    let hoverstat= 0;
     $(document).on('click','#productionPlanTable tbody tr td', function(event) {   

		if(!editGubun){
			return editGubun;
		}
        
    	if ( $(this).hasClass('selected') ) {
    		$(this).removeClass('selected'); 	
    		 
            //$(this).removeClass('selected');
        }
        else {               	
            $(this).addClass('selected');
        }
    }); 

     $(document).keydown(function(event) {
    	
    	    if ( event.keyCode == 88 || event.which == 88 ) {
    	    	 if(!editGubun){
    	  			return editGubun;
    	  		 }
    	    	 hoverstat++;
    	    	 if(hoverstat == 1){
    	    		 toastr.success("마우스를 올리면 선택됩니다.");
    	    	 } else if(hoverstat == 2){
    	    		 toastr.success("마우스를 올리면 선택이 해제됩니다.");
    	    	 } else if(hoverstat == 3){
    	    		 toastr.success("입력할 곳을 클릭해주세요.");
    	    		 hoverstat = 0;
    	    	 }    	       	 
    	        
    	    }
    	});

     $(document).on('mouseenter','#productionPlanTable tbody tr td', function(event) {   

 		if(!editGubun){
 			return editGubun;
 		}

 		if(hoverstat == 1){ //색칠 			      	         	
	         $(this).addClass('selected');	         
 		} else if(hoverstat == 2){ //지우기
 			$(this).removeClass('selected');
 		}   
         
     }); 
      

     $('#btnFaultyGubun').on('click',function(){
        let color = '';
        let npTimeVal = '';

		if($('#npTimeVal').val() > 24){
			toastr.warning("입력시간이 24시간을 넘을 수 없습니다.");
			$('#npTimeVal').focus();
			return false;
		}
		
		if($('#npGubun').val() == ''){
			$('.selected').each(function(index,item){  
	       		$(this).find("input").eq(0).val("0");
	       		$(this).find("input").eq(1).val("0");    		
	        });
			$('.selected').attr('class','');
			return false;
		}

		$.each(npGubunList,function(index,item){
        	if(item.baseCd == $('#npGubun').val()){
            	color = item.etc2;
            	npTime = item.etc1;       		
    		}
        });
        
        $('.selected').each(function(index,item){   //비가동구분 넣기
       		$(this).find("input").eq(0).val($('#npGubun').val()); 
       		$(this).find("input").eq(1).val($('#npTimeVal').val());     		
        });
        
        $('.selected').attr('class',color);
        

    }); 

	function colorChange(id){
		let color = '';
		if($('#'+id).val() != ''){
			 $.each(npGubunList,function(index,item){
	        	if(item.baseCd == $('#'+id).val()){
	            	color = item.etc2;
	        		return false;
	    		}
		     });
		} else{
			color = '';
		}

	     return color;
	}

	
	$('#btnJobChange').on('click',function(){


		
        		$.ajax({
            		url: '<c:url value="wm/checkJobChange"/>',
        			type: 'POST',  
        			async: false,
        			data: {
        				'menuAuth'	:	menuAuth,
        				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
        				'cplGubun'	:	function(){return "001";},				
        			},
                    success: function (res) {
                        let data = res.data;
                        if (res.result == 'ok') { //비가동구분이 저장되어 있을때
                        	$('#jobChangePopupModal').modal('show');
                    		equipCd = '';
                    		$('#equipSelect').val('');
                    		$('#jobChangeDate').val('');
                    		jobChangeTable.ajax.reload();
                        	
                        } else if(res.result == 'error'){ //비가동구분이 저장되어 있지 않을때
                               
                        	toastr.warning(res.message, '', {timeOut: 5000});
                        	
                        } else{ //에러
                        	toastr.error(res.message, '', {timeOut: 5000});
                        }
                    },
                    complete:function(){
                        
                    }
                });       

	});

	$('#modalRetv').on('click',function(){
		equipCd = $('#equipSelect').val();

		if($('#equipSelect').val() == ""){
			toastr.warning("설비를 선택해 주세요.");
			$('#equipSelect').focus();
			return false;
		}
		if($('#jobChangeDate').val() == ""){
			toastr.warning("잡체인지 일자를 선택해 주세요.");
			$('#jobChangeDate').focus();
			return false;
		}
		
		jobChangeTable.ajax.reload();

		
	});

	$(document).on('click','#jobChangeTable tbody tr' ,function() {
 		if ( $(this).hasClass('selected') ) {
     		$(this).removeClass('selected');          
     		//tableIdx = $('#jobChangeTable').DataTable().row(this).index();
         }
         else {               	
        	 $('#jobChangeTable').DataTable().$('tr.selected').removeClass('selected');
             $(this).addClass('selected');
             $('#rowDelete').attr('disabled',false);
             tableIdx = $('#jobChangeTable').DataTable().row(this).index();
             
         }
  }); 

    
	// 테이블초기화
	$('#allDelete').on('click', function() {
		$('#jobChangeTable').DataTable().clear().draw();
    	toastr.success("초기화 되었습니다.");
	});

	// 열삭제
	$('#rowDelete').on('click', function() {
		$('#jobChangeTable').DataTable().rows('.selected').remove().draw();
		$('#rowDelete').attr('disabled',true);
		
	});

	let goodsCdJob = '';
	let goodsNmJob = '';
	// 열추가
	$('#rowAdd').on('click', function() {
		if ($('#jobChangeTable').DataTable().rows().count() == 0) {				 
			toastr.warning('먼저 조회를 해주세요');			
			return false;
		}

		$('#jobChangeTable').DataTable().row.add({
			"equipNm"		:	$('#equipSelect option:checked').text(),
			"equipCd"		:	$('#equipSelect').val(),
		
			
		}).draw();
		
		
	});

	$('#btnSaveJobChange').on('click', function() {
		$('#my-spinner').show();
		let dataList = new Array();
		let dataCheck = new Array();
		let check = true;

  		//확정된 계획인지 확인
   		$.ajax({
       		url: '<c:url value="wm/checkCompleteYn"/>',
   			type: 'POST',  
   			async: false,
   			data: {
   				'menuAuth'	:	menuAuth,
   				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
   				'cplGubun'	:	function(){return "001";},				
   			},
            success: function (res) {
                   let data = res.data;
                if (res.result == 'ok') { //미확정시
                       	//비가동사유에 잡체인지를 입력했는지 확인.
                	check = true;       
                } else if(res.result == 'error'){ //확정시
                    //모달추가해서 확인절차후 수정가능하게 해줘야함
                    check = false;                 
                    $('#my-spinner').hide();
                	toastr.warning(res.message, '', {timeOut: 5000});                	
                } else{ //에러
                	check = false;
                	$('#my-spinner').hide();
                	toastr.error(res.message, '', {timeOut: 5000});
                }
      		  },
            complete:function(){
                
    	        }
  	  	});

  	  	if(!check){
			return false;
  	  	}

		if($('#jobChangeDate').val()==""){
			toastr.warning('잡체인지 일자를 선택해주세요.');
			return false;
		}

		if($('#equipSelect').val()==""){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
	
		$('#jobChangeTable tbody tr').each(function(index,item){
			var equipCd = equipCodeList[index].equipCd;
			var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");

			if($(this).find('td').eq(0).find('input').val()==""){
				toastr.warning('설비명을 선택해주세요.');
				check = false;
				$('#my-spinner').hide();
				return false;
			}
			if($(this).find('td').eq(1).find('input[name=goodsNm]').val()==""){
				toastr.warning('제품을 선택해주세요.');
				check = false;
				$('#my-spinner').hide();
				return false;
			}
			if($(this).find('td').eq(2).find('input').val()==""){
				toastr.warning('가동시간을 입력 해주세요.');
				check = false;
				$('#my-spinner').hide();
				return false;
			}
			if($(this).find('td').eq(3).find('input').val()==""){
				toastr.warning('시작일자를 입력해주세요.');
				check = false;
				$('#my-spinner').hide();
				return false;
			}
			if($(this).find('td').eq(4).find('input').val()==""){
				toastr.warning('종료일자를 입력해주세요.');
				check = false;
				$('#my-spinner').hide();
				return false;
			}
			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.equipCd = $(this).find('td').eq(0).find('input').val();
		 	rowData001.goodsCd = $(this).find('td').eq(1).find('input[name=goodsCd]').val();
		 	rowData001.opTime = $(this).find('td').eq(2).find('input').val();		

		 	rowData001.fpDate = $('#jobChangeDate').val().replace(/-/g,"");
		 	rowData001.jobChangeDate = $('#jobChangeDate').val().replace(/-/g,"");
		 	rowData001.jobChangeStartDate = $(this).find('td').eq(3).find('input').val().replace(/-/g,"");
		 	rowData001.jobChangeEndDate = $(this).find('td').eq(4).find('input').val().replace(/-/g,"");
		 
		 	rowData001.cplGubun = "001";
		 	
		 	dataCheck.push($(this).find('td').eq(1).find('input[name=goodsCd]').val());

			dataList.push(rowData001);

		});

		if(hasDuplicates(dataCheck)){ //제품이 중복이 있다면.
			toastr.warning('중복된 제품이 있습니다.');
			$('#my-spinner').hide();
			return false;
		}

		
		if(check){
			$.ajax({
	            url: '<c:url value="/wm/insertMonthProductionPlanJobChange"/>',
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
	                	$("#btnEquipInputSetting").attr("disabled", true);
	                	$("#btnFaultyGubun").attr("disabled", true);                	
	                	editGubun = false;
	                	$('#productionPlanTable').DataTable().columns.adjust();
	                	//$('#productionPlanTable').DataTable().ajax.reload( function () {$('#productionPlanTable').DataTable().columns.adjust();});
	                	toastr.success(res.message);
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		}
	});
	
   	let jobChangeTable =$('#jobChangeTable').on( 'error.dt', function ( e, settings, techNote, message ) {
   		        if(techNote == 7) {
   		            toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.");
   		            setTimeout(function() {
   		            	location.href = "/wmsc0210";
   		            	}, 1000);    
   		        }
   		     } ).DataTable({ 
   				language : lang_kor,
   				paging : true,
   				searching: false,
   				info : false,   			
   				ordering : false,
   				processing : true,
   				autoWidth : false,
   				lengthChange : false,
   				pageLength : 20,
   				ajax : {
   					url : '<c:url value="wm/jobChangeModal"/>',
   					type : 'GET',
   					data : {
   						'equipCd' :  function(){return equipCd;},
   						'fpDate'  :	 function(){return $('#jobChangeDate').val().replace(/-/g,"");},
   						'cplGubun':	 function(){return '001';},
   						'menuAuth'	: 	menuAuth,
   					},
   				},
   			
   				columns : [ 
   					{data : 'equipNm',
   						render: function(data, type, row, meta) {
							return data + '<input type="hidden" id="jobEquipCd" value=' + row['equipCd'] + '>';
   						}
					},	
   					{data : 'goodsNm',
   						render: function(data, type, row, meta) {	   				
   							var value ="";
   							if(data!=null){
   								value = '<input type="text" class="form-control" style="border:none; max-width:100%;" name="goodsNm" value="'+data+'" disabled>';		
   								
   							} else{
   								value = '<input type="text" class="form-control" name="goodsNm" value=""  style="border:none; width:100%; " disabled>';
   							}								
   							
   			    			var html = '<div class="input-sub m-0">';
   			    				 html += value;
   			    				 html += '<input type="hidden"  name="goodsCd" value="'+row['goodsCd']+'">';
   			    				 html += '<button type="button" class="btn btn-primary input-sub-search" name="btnSelBuyCorp" onClick="selectGoodsCode();" >';
   			    				 html += '<span class="oi oi-magnifying-glass"></span>';
   			    				 html += '</button>' ;
   			    				 html += '</div>' ;
   							return html;
   						}
   					},	
   				
   					{data : 'opTime',
   						render: function(data, type, row, meta) {	
   							var value ="";
   							if(data!=null){
   								value = '<input type="text" class="form-control number-float0" style="border:none; max-width:100%;" name="opTime" value="'+data+'" >';		
   								
   							} else{
   								value = '<input type="text" class="form-control number-float0" name="opTime" value="0"  style="border:none; width:100%; " >';
   							}								
   							
   			    			var html = '<div class="input-sub m-0">';
   			    				 html += value;   			    		    				
   			    				 html += '</div>' ;
   							return html;
   		    			}
   					},	

   					
   					{data : 'jobChangeStartDate',
   						render: function(data, type, row, meta) {	
   							let jobChangeDateVal = $('#jobChangeDate').val();
   							if(data!=null){
   			    				return '<input type="date" class="form-control" name="jobChangeStartDate" value="'+moment(data).format('YYYY-MM-DD')+'"  style="border:none; width:100%;" >' ;	
   							} else{
   								return '<input type="date" class="form-control" name="jobChangeStartDate" value="' + jobChangeDateVal + '"  style="border:none; width:100%;">';	
   							}		    			
   			    		}
   					},
   					{data : 'jobChangeEndDate',
   						render: function(data, type, row, meta) {	
   							let jobChangeDateVal = $('#jobChangeDate').val();
   							if(data!=null){
   			    				return '<input type="date" class="form-control" name="jobChangeEndDate" value="'+moment(data).format('YYYY-MM-DD')+'"  style="border:none; width:100%;" >' ;	
   							} else{
   								return '<input type="date" class="form-control" name="jobChangeEndDate" value="' + jobChangeDateVal + '"  style="border:none; width:100%;">';	
   							}		    			
   			    		}
   					}
   				],
   		        order: [
   		            [ 0, 'asc' ]
   		        ],
   		        drawCallback: function(){   		        	
	   		      
   				}
   			});	


 	

   	//제품코드조회 팝업 시작
   	var goodsCdPopUpTable;
   	function selectGoodsCode()
   	{
		if(goodsCdPopUpTable == null || goodsCdPopUpTable == undefined)	{
			goodsCdPopUpTable = $('#goodsCdPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        pageLength: 15,
		        ajax: {
		            url: '<c:url value="/wm/jobChangeGoodsModal"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            	'equipCd'		:	function(){return $('#equipSelect').val();}
		            },		    
		        },
		        rowId: 'goodsCd',
		        columns: [
		            { data: 'goodsCd' },
		            { data: 'goodsNm' },
		            { data: 'model' },
		            { data: 'modelNo' },
		            { data: 'alnicuMatrlNm' },
		            { data: 'alnicuMatrlCd' },
		            { data: 'filmMatrlCd' },
		        ],
		        columnDefs: [
		        	{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4,5,6],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [
		            
		        ],
		    });

		    $('#goodsCdPopUpTable tbody').on('click', 'tr', function () {
		    	var data = goodsCdPopUpTable.row( this ).data();
		    	$('input[name=goodsCd]').eq(tableIdx).val(data.goodsCd);
		    	$('input[name=goodsNm]').eq(tableIdx).val(data.goodsNm);              
                $('#goodsPopUpModal').modal('hide');               
		    });
		} else{
			$('#goodsCdPopUpTable').DataTable().ajax.reload();
		}

		$('#goodsPopUpModal').modal('show');		
   	}
  	//제품코드조회 팝업 종료

	//중복체크
    function hasDuplicates(array) {
    	return (new Set(array)).size !== array.length;
	}

    $('#btnPlanMan').on('click', function() {
    	$('.planManModal').html(monthProductPresentTableOrigin2);
    	createHeaderMan().then(()=>{
    		
       		monthProductPresentTable2 = monthProductPresentTableFunc2();       	
        });

		
    	$('#planManPopUpModal').modal('show');
    });

    //작업자 저장
    $('#btnPlanSave').on('click', function() {
		$('#my-spinner').show();
			
		dataList = new Array();
		$('#planManTable tbody tr').each(function(index,item){
		
			var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");

			var rowData001 = new Object();
		 	rowData001.menuAuth = menuAuth;
		 	rowData001.fpDate = inWhsDateCal;
		 	rowData001.cplGubun = "001";
		 	if(index == '0'){
		 		rowData001.dayNightGubun = "D";
		 		rowData001.count1 = ($('#DplanMan1').val()!=null && $('#DplanMan1').val()!="") ? $('#DplanMan1').val() : "";   
				rowData001.count2 = ($('#DplanMan2').val()!=null && $('#DplanMan2').val()!="") ? $('#DplanMan2').val() : "";   
				rowData001.count3 = ($('#DplanMan3').val()!=null && $('#DplanMan3').val()!="") ? $('#DplanMan3').val() : "";   
				rowData001.count4 = ($('#DplanMan4').val()!=null && $('#DplanMan4').val()!="") ? $('#DplanMan4').val() : "";   
				rowData001.count5 = ($('#DplanMan5').val()!=null && $('#DplanMan5').val()!="") ? $('#DplanMan5').val() : "";   
				rowData001.count6 = ($('#DplanMan6').val()!=null && $('#DplanMan6').val()!="") ? $('#DplanMan6').val() : "";   
				rowData001.count7 = ($('#DplanMan7').val()!=null && $('#DplanMan7').val()!="") ? $('#DplanMan7').val() : "";   
				rowData001.count8 = ($('#DplanMan8').val()!=null && $('#DplanMan8').val()!="") ? $('#DplanMan8').val() : "";   
				rowData001.count9 = ($('#DplanMan9').val()!=null && $('#DplanMan9').val()!="") ? $('#DplanMan9').val() : "";   
				rowData001.count10 = ($('#DplanMan10').val()!=null && $('#DplanMan10').val()!="") ? $('#DplanMan10').val() : "";   
				rowData001.count11 = ($('#DplanMan11').val()!=null && $('#DplanMan11').val()!="") ? $('#DplanMan11').val() : "";   
				rowData001.count12 = ($('#DplanMan12').val()!=null && $('#DplanMan12').val()!="") ? $('#DplanMan12').val() : "";   
				rowData001.count13 = ($('#DplanMan13').val()!=null && $('#DplanMan13').val()!="") ? $('#DplanMan13').val() : "";   
				rowData001.count14 = ($('#DplanMan14').val()!=null && $('#DplanMan14').val()!="") ? $('#DplanMan14').val() : "";   
				rowData001.count15 = ($('#DplanMan15').val()!=null && $('#DplanMan15').val()!="") ? $('#DplanMan15').val() : "";   
				rowData001.count16 = ($('#DplanMan16').val()!=null && $('#DplanMan16').val()!="") ? $('#DplanMan16').val() : "";   
				rowData001.count17 = ($('#DplanMan17').val()!=null && $('#DplanMan17').val()!="") ? $('#DplanMan17').val() : "";   
				rowData001.count18 = ($('#DplanMan18').val()!=null && $('#DplanMan18').val()!="") ? $('#DplanMan18').val() : "";   
				rowData001.count19 = ($('#DplanMan19').val()!=null && $('#DplanMan19').val()!="") ? $('#DplanMan19').val() : "";   
				rowData001.count20 = ($('#DplanMan20').val()!=null && $('#DplanMan20').val()!="") ? $('#DplanMan20').val() : "";   
				rowData001.count21 = ($('#DplanMan21').val()!=null && $('#DplanMan21').val()!="") ? $('#DplanMan21').val() : "";   
				rowData001.count22 = ($('#DplanMan22').val()!=null && $('#DplanMan22').val()!="") ? $('#DplanMan22').val() : "";   
				rowData001.count23 = ($('#DplanMan23').val()!=null && $('#DplanMan23').val()!="") ? $('#DplanMan23').val() : "";   
				rowData001.count24 = ($('#DplanMan24').val()!=null && $('#DplanMan24').val()!="") ? $('#DplanMan24').val() : "";   
				rowData001.count25 = ($('#DplanMan25').val()!=null && $('#DplanMan25').val()!="") ? $('#DplanMan25').val() : "";   
				rowData001.count26 = ($('#DplanMan26').val()!=null && $('#DplanMan26').val()!="") ? $('#DplanMan26').val() : "";   
				rowData001.count27 = ($('#DplanMan27').val()!=null && $('#DplanMan27').val()!="") ? $('#DplanMan27').val() : "";   
				rowData001.count28 = ($('#DplanMan28').val()!=null && $('#DplanMan28').val()!="") ? $('#DplanMan28').val() : "";   
				rowData001.count29 = ($('#DplanMan29').val()!=null && $('#DplanMan29').val()!="") ? $('#DplanMan29').val() : "";   
				rowData001.count30 = ($('#DplanMan30').val()!=null && $('#DplanMan30').val()!="") ? $('#DplanMan30').val() : "";   
				rowData001.count31 = ($('#DplanMan31').val()!=null && $('#DplanMan31').val()!="") ? $('#DplanMan31').val() : "";   
			} else{
				rowData001.dayNightGubun = "N";
		
		 		rowData001.count1 = ($('#NplanMan1').val()!=null && $('#NplanMan1').val()!="") ? $('#NplanMan1').val() : "";   
				rowData001.count2 = ($('#NplanMan2').val()!=null && $('#NplanMan2').val()!="") ? $('#NplanMan2').val() : "";   
				rowData001.count3 = ($('#NplanMan3').val()!=null && $('#NplanMan3').val()!="") ? $('#NplanMan3').val() : "";   
				rowData001.count4 = ($('#NplanMan4').val()!=null && $('#NplanMan4').val()!="") ? $('#NplanMan4').val() : "";   
				rowData001.count5 = ($('#NplanMan5').val()!=null && $('#NplanMan5').val()!="") ? $('#NplanMan5').val() : "";   
				rowData001.count6 = ($('#NplanMan6').val()!=null && $('#NplanMan6').val()!="") ? $('#NplanMan6').val() : "";   
				rowData001.count7 = ($('#NplanMan7').val()!=null && $('#NplanMan7').val()!="") ? $('#NplanMan7').val() : "";   
				rowData001.count8 = ($('#NplanMan8').val()!=null && $('#NplanMan8').val()!="") ? $('#NplanMan8').val() : "";   
				rowData001.count9 = ($('#NplanMan9').val()!=null && $('#NplanMan9').val()!="") ? $('#NplanMan9').val() : "";   
				rowData001.count10 = ($('#NplanMan10').val()!=null && $('#NplanMan10').val()!="") ? $('#NplanMan10').val() : "";   
				rowData001.count11 = ($('#NplanMan11').val()!=null && $('#NplanMan11').val()!="") ? $('#NplanMan11').val() : "";   
				rowData001.count12 = ($('#NplanMan12').val()!=null && $('#NplanMan12').val()!="") ? $('#NplanMan12').val() : "";   
				rowData001.count13 = ($('#NplanMan13').val()!=null && $('#NplanMan13').val()!="") ? $('#NplanMan13').val() : "";   
				rowData001.count14 = ($('#NplanMan14').val()!=null && $('#NplanMan14').val()!="") ? $('#NplanMan14').val() : "";   
				rowData001.count15 = ($('#NplanMan15').val()!=null && $('#NplanMan15').val()!="") ? $('#NplanMan15').val() : "";   
				rowData001.count16 = ($('#NplanMan16').val()!=null && $('#NplanMan16').val()!="") ? $('#NplanMan16').val() : "";   
				rowData001.count17 = ($('#NplanMan17').val()!=null && $('#NplanMan17').val()!="") ? $('#NplanMan17').val() : "";   
				rowData001.count18 = ($('#NplanMan18').val()!=null && $('#NplanMan18').val()!="") ? $('#NplanMan18').val() : "";   
				rowData001.count19 = ($('#NplanMan19').val()!=null && $('#NplanMan19').val()!="") ? $('#NplanMan19').val() : "";   
				rowData001.count20 = ($('#NplanMan20').val()!=null && $('#NplanMan20').val()!="") ? $('#NplanMan20').val() : "";   
				rowData001.count21 = ($('#NplanMan21').val()!=null && $('#NplanMan21').val()!="") ? $('#NplanMan21').val() : "";   
				rowData001.count22 = ($('#NplanMan22').val()!=null && $('#NplanMan22').val()!="") ? $('#NplanMan22').val() : "";   
				rowData001.count23 = ($('#NplanMan23').val()!=null && $('#NplanMan23').val()!="") ? $('#NplanMan23').val() : "";   
				rowData001.count24 = ($('#NplanMan24').val()!=null && $('#NplanMan24').val()!="") ? $('#NplanMan24').val() : "";   
				rowData001.count25 = ($('#NplanMan25').val()!=null && $('#NplanMan25').val()!="") ? $('#NplanMan25').val() : "";   
				rowData001.count26 = ($('#NplanMan26').val()!=null && $('#NplanMan26').val()!="") ? $('#NplanMan26').val() : "";   
				rowData001.count27 = ($('#NplanMan27').val()!=null && $('#NplanMan27').val()!="") ? $('#NplanMan27').val() : "";   
				rowData001.count28 = ($('#NplanMan28').val()!=null && $('#NplanMan28').val()!="") ? $('#NplanMan28').val() : "";   
				rowData001.count29 = ($('#NplanMan29').val()!=null && $('#NplanMan29').val()!="") ? $('#NplanMan29').val() : "";   
				rowData001.count30 = ($('#NplanMan30').val()!=null && $('#NplanMan30').val()!="") ? $('#NplanMan30').val() : "";   
				rowData001.count31 = ($('#NplanMan31').val()!=null && $('#NplanMan31').val()!="") ? $('#NplanMan31').val() : "";
			}		 		
			

			dataList.push(rowData001);

		});

		$.ajax({
            url: '<c:url value="/wm/createMan"/>',
            type: 'POST',
            data: JSON.stringify(dataList),
            dataType:"json",
            contentType : "application/json; charset=UTF-8",
            beforeSend: function() {

            },
            success: function (res) {
                let data = res.data;           
                if (res.result == 'ok') { 
                	$('#planManTable').DataTable().ajax.reload( function () {});
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

    $('#btnYeild').on('click', function() {
    	$.ajax({
			url: '<c:url value="wm/monthProductionPlanYeildRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'cplGubun'	:	function(){return "001";},
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},
				
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					
					 $('#yeild1').val((data == null) ? "0" : (data.yeild1));
					 $('#yeild2').val((data == null) ? "0" : (data.yeild2));					
					
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
    	$('#yeildPopupModal').modal('show');
    });

    $('#btnYeildSave').on('click', function() {
    	$.ajax({
			url: '<c:url value="wm/monthProductionPlanYeildCreate"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"").substring(0,6);},				
				'cplGubun'	:	function(){return "001";},
				'yeild1'	:	function(){return $('#yeild1').val();},
				'yeild2'	:	function(){return $('#yeild2').val();},
				'yeildTotal'	:	function(){return (parseFloat($('#yeild1').val()) * parseFloat($('#yeild2').val()));},
				
			},
			success: function(res){			
				if (res.result="ok"){
					toastr.success("저장되었습니다");
					theoryDataRead();
				} else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
			}
		});
    });

   $('#btnLoading').on('click', function() {
		
		let d = new Date($('#inWhsDateCal').val());
		let sel_month = -1; // 월을 조절하시면 됩니다. -1이면 전달을 +1이면 다음달을..
		d.setMonth(d.getMonth() + sel_month ); 

		let year    = d.getFullYear();
		let month   = ('0' + (d.getMonth() +  1 )).slice(-2);
		let day     = ('0' + d.getDate()).slice(-2);
		dt = year+"-"+month+"-"+day;
		
	   
	    $.ajax({
			url: '<c:url value="wm/monthProductionPlanYeildRead"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'cplGubun'	:	function(){return "001";},
				'fpDate'	:	function(){return year+month;},
			},
			success: function(res){	
				var data = res.data; 		
				if (res.result="ok"){
					toastr.success("지난달 데이터를 불러왔습니다.");
				
					 $('#yeild1').val((data == null) ? "0" : (data.yeild1));
					 $('#yeild2').val((data == null) ? "0" : (data.yeild2));

					
					
				} else{ //에러
               	toastr.error(res.message, '', {timeOut: 5000});
               }
			}
		});
   });

   //잡체인지 목록 테이블
 	let jcListTable =$('#jcListTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	        if(techNote == 7) {
	            toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.");
	            setTimeout(function() {
	            	location.href = "/wmsc0220";
	            	}, 1000);    
	        }
	     } ).DataTable({ 
			language : lang_kor,
			paging : true,
			searching: false,
			info : false,   			
			ordering : false,
			processing : true,
			autoWidth : false,
			lengthChange : false,
			pageLength : 20,
			ajax : {
				url : '<c:url value="wm/jcModalList"/>',
				type : 'GET',
				data : {				
					'fpDate'  :	 function(){return $('#inWhsDateCal').val().replace(/-/g,"");},
					'cplGubun':	 function(){return '001';},
					'menuAuth'	: 	menuAuth,
				},
			},
		
			columns : [ 
				{data : 'equipNm'},	
				{data : 'goodsNm'},				
				{data : 'qutyNm'},
				{data : 'jobChangeDate',
					render: function(data, type, row, meta) {							
						if(data!=null){
		    				return moment(data).format('YYYY-MM-DD');	
						} else{
							return '-';
						}		    			
		    		}
	    		},							
				{data : 'jobChangeStartDate',
					render: function(data, type, row, meta) {							
						if(data!=null){
		    				return moment(data).format('YYYY-MM-DD');	
						} else{
							return '-';
						}		    			
		    		}
				},
				{data : 'jobChangeEndDate',
					render: function(data, type, row, meta) {							
						if(data!=null){
		    				return moment(data).format('YYYY-MM-DD');	
						} else{
							return '-';
						}		    			
		    		}
				}
			],
	        order: [
	            [ 0, 'asc' ]
	        ],
	        drawCallback: function(){   		        	
		      
			}
		});	


	//잡체인지 목록 모달
	$('#jobChangeList').on('click', function() {
		selectBoxAppend(equipCodeList, "jcEquipCd", "", "2");
		$('#jcListTable').DataTable().ajax.reload( function () {
			$('#jcListPopUpModal').modal('show');
		});
		
  });

	  //잡체인지 삭제
	$('#jobChangeDelete').on('click', function() {

		let equipStat = false;
		let fixStat = false;
		if($('#jcEquipCd').val() == ''){
			toastr.warning('설비를 선택해주세요.');
			$('#jcEquipCd').focus();
			return false;
		}
		$('#jcListTable tbody tr').each(function(index,item){
			var equipCd = $('#jcListTable').DataTable().row(this).data().equipCd;
			if(equipCd == $('#jcEquipCd').val()){
				equipStat = true;
				return false;
			}
		});

		$.ajax({
    		url: '<c:url value="wm/checkCompleteYn"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				'cplGubun'	:	function(){return "001";},				
			},
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') { //미확정시      
                	fixStat = false;          
                } else if(res.result == 'error'){ //확정시
                    //모달추가해서 확인절차후 수정가능하게 해줘야함                   
                    fixStat = true;
                	toastr.warning(res.message, '', {timeOut: 5000});                	
                } else{ //에러
                	fixStat = true;
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
            	
            }
        });

		if(fixStat){
			toastr.warning('확정된 계획은 삭제할 수 없습니다.');
			return false;
		}
		
		if(equipStat){
			$('#my-spinner').show();
			
			dataList = new Array();
			$('#productionPlanTable tbody tr').each(function(index,item){
				var equipCd = $('#productionPlanTable').DataTable().row(this).data().equipCd;
				if(equipCd == $('#jcEquipCd').val()){
					var inWhsDateCal = $('#inWhsDateCal').val().replace(/-/g,"");
		
					var rowData001 = new Object();
				 	rowData001.menuAuth = menuAuth;
				 	rowData001.equipCd = equipCd;
				 	rowData001.goodsCd = ($('#productionPlanTable').DataTable().row(this).data().goodsCd == null) ? "" : $('#productionPlanTable').DataTable().row(this).data().goodsCd;
				 	rowData001.fpDate = inWhsDateCal;
				 	rowData001.cplGubun = "001";
				 	rowData001.completeYn = "002";		
			
					rowData001.count1 =  ($('#' + equipCd + 'count1').val()!=null && $('#' + equipCd + 'count1').val()!="") ? $('#' + equipCd + 'count1').val() : "0";
					rowData001.count2 =  ($('#' + equipCd + 'count2').val()!=null && $('#' + equipCd + 'count2').val()!="") ? $('#' + equipCd + 'count2').val() : "0";
					rowData001.count3 =  ($('#' + equipCd + 'count3').val()!=null && $('#' + equipCd + 'count3').val()!="") ? $('#' + equipCd + 'count3').val() : "0";
					rowData001.count4 =  ($('#' + equipCd + 'count4').val()!=null && $('#' + equipCd + 'count4').val()!="") ? $('#' + equipCd + 'count4').val() : "0";
					rowData001.count5 =  ($('#' + equipCd + 'count5').val()!=null && $('#' + equipCd + 'count5').val()!="") ? $('#' + equipCd + 'count5').val() : "0";
					rowData001.count6 =  ($('#' + equipCd + 'count6').val()!=null && $('#' + equipCd + 'count6').val()!="") ? $('#' + equipCd + 'count6').val() : "0";
					rowData001.count7 =  ($('#' + equipCd + 'count7').val()!=null && $('#' + equipCd + 'count7').val()!="") ? $('#' + equipCd + 'count7').val() : "0";
					rowData001.count8 =  ($('#' + equipCd + 'count8').val()!=null && $('#' + equipCd + 'count8').val()!="") ? $('#' + equipCd + 'count8').val() : "0";
					rowData001.count9 =  ($('#' + equipCd + 'count9').val()!=null && $('#' + equipCd + 'count9').val()!="") ? $('#' + equipCd + 'count9').val() : "0";
					rowData001.count10 = ($('#' + equipCd + 'count10').val()!=null && $('#' + equipCd + 'count10').val()!="") ? $('#' + equipCd + 'count10').val() : "0";
					rowData001.count11 = ($('#' + equipCd + 'count11').val()!=null && $('#' + equipCd + 'count11').val()!="") ? $('#' + equipCd + 'count11').val() : "0";
					rowData001.count12 = ($('#' + equipCd + 'count12').val()!=null && $('#' + equipCd + 'count12').val()!="") ? $('#' + equipCd + 'count12').val() : "0";
					rowData001.count13 = ($('#' + equipCd + 'count13').val()!=null && $('#' + equipCd + 'count13').val()!="") ? $('#' + equipCd + 'count13').val() : "0";
					rowData001.count14 = ($('#' + equipCd + 'count14').val()!=null && $('#' + equipCd + 'count14').val()!="") ? $('#' + equipCd + 'count14').val() : "0";
					rowData001.count15 = ($('#' + equipCd + 'count15').val()!=null && $('#' + equipCd + 'count15').val()!="") ? $('#' + equipCd + 'count15').val() : "0";
					rowData001.count16 = ($('#' + equipCd + 'count16').val()!=null && $('#' + equipCd + 'count16').val()!="") ? $('#' + equipCd + 'count16').val() : "0";
					rowData001.count17 = ($('#' + equipCd + 'count17').val()!=null && $('#' + equipCd + 'count17').val()!="") ? $('#' + equipCd + 'count17').val() : "0";
					rowData001.count18 = ($('#' + equipCd + 'count18').val()!=null && $('#' + equipCd + 'count18').val()!="") ? $('#' + equipCd + 'count18').val() : "0";
					rowData001.count19 = ($('#' + equipCd + 'count19').val()!=null && $('#' + equipCd + 'count19').val()!="") ? $('#' + equipCd + 'count19').val() : "0";
					rowData001.count20 = ($('#' + equipCd + 'count20').val()!=null && $('#' + equipCd + 'count20').val()!="") ? $('#' + equipCd + 'count20').val() : "0";
					rowData001.count21 = ($('#' + equipCd + 'count21').val()!=null && $('#' + equipCd + 'count21').val()!="") ? $('#' + equipCd + 'count21').val() : "0";
					rowData001.count22 = ($('#' + equipCd + 'count22').val()!=null && $('#' + equipCd + 'count22').val()!="") ? $('#' + equipCd + 'count22').val() : "0";
					rowData001.count23 = ($('#' + equipCd + 'count23').val()!=null && $('#' + equipCd + 'count23').val()!="") ? $('#' + equipCd + 'count23').val() : "0";
					rowData001.count24 = ($('#' + equipCd + 'count24').val()!=null && $('#' + equipCd + 'count24').val()!="") ? $('#' + equipCd + 'count24').val() : "0";
					rowData001.count25 = ($('#' + equipCd + 'count25').val()!=null && $('#' + equipCd + 'count25').val()!="") ? $('#' + equipCd + 'count25').val() : "0";
					rowData001.count26 = ($('#' + equipCd + 'count26').val()!=null && $('#' + equipCd + 'count26').val()!="") ? $('#' + equipCd + 'count26').val() : "0";
					rowData001.count27 = ($('#' + equipCd + 'count27').val()!=null && $('#' + equipCd + 'count27').val()!="") ? $('#' + equipCd + 'count27').val() : "0";
					rowData001.count28 = ($('#' + equipCd + 'count28').val()!=null && $('#' + equipCd + 'count28').val()!="") ? $('#' + equipCd + 'count28').val() : "0";
					rowData001.count29 = ($('#' + equipCd + 'count29').val()!=null && $('#' + equipCd + 'count29').val()!="") ? $('#' + equipCd + 'count29').val() : "0";
					rowData001.count30 = ($('#' + equipCd + 'count30').val()!=null && $('#' + equipCd + 'count30').val()!="") ? $('#' + equipCd + 'count30').val() : "0";
					rowData001.count31 = ($('#' + equipCd + 'count31').val()!=null && $('#' + equipCd + 'count31').val()!="") ? $('#' + equipCd + 'count31').val() : "0";
		
					rowData001.npTime1 = ($('#' + equipCd + 'npTime1').val()!=null && $('#' + equipCd + 'npTime1').val()!="") ? $('#' + equipCd + 'npTime1').val() : "0";
					rowData001.npTime2 = ($('#' + equipCd + 'npTime2').val()!=null && $('#' + equipCd + 'npTime2').val()!="") ? $('#' + equipCd + 'npTime2').val() : "0";
					rowData001.npTime3 = ($('#' + equipCd + 'npTime3').val()!=null && $('#' + equipCd + 'npTime3').val()!="") ? $('#' + equipCd + 'npTime3').val() : "0";
					rowData001.npTime4 = ($('#' + equipCd + 'npTime4').val()!=null && $('#' + equipCd + 'npTime4').val()!="") ? $('#' + equipCd + 'npTime4').val() : "0";
					rowData001.npTime5 = ($('#' + equipCd + 'npTime5').val()!=null && $('#' + equipCd + 'npTime5').val()!="") ? $('#' + equipCd + 'npTime5').val() : "0";
					rowData001.npTime6 = ($('#' + equipCd + 'npTime6').val()!=null && $('#' + equipCd + 'npTime6').val()!="") ? $('#' + equipCd + 'npTime6').val() : "0";
					rowData001.npTime7 = ($('#' + equipCd + 'npTime7').val()!=null && $('#' + equipCd + 'npTime7').val()!="") ? $('#' + equipCd + 'npTime7').val() : "0";
					rowData001.npTime8 = ($('#' + equipCd + 'npTime8').val()!=null && $('#' + equipCd + 'npTime8').val()!="") ? $('#' + equipCd + 'npTime8').val() : "0";
					rowData001.npTime9 = ($('#' + equipCd + 'npTime9').val()!=null && $('#' + equipCd + 'npTime9').val()!="") ? $('#' + equipCd + 'npTime9').val() : "0";
					rowData001.npTime10 = ($('#' + equipCd + 'npTime10').val()!=null && $('#' + equipCd + 'npTime10').val()!="") ? $('#' + equipCd + 'npTime10').val() : "0";
					rowData001.npTime11 = ($('#' + equipCd + 'npTime11').val()!=null && $('#' + equipCd + 'npTime11').val()!="") ? $('#' + equipCd + 'npTime11').val() : "0";
					rowData001.npTime12 = ($('#' + equipCd + 'npTime12').val()!=null && $('#' + equipCd + 'npTime12').val()!="") ? $('#' + equipCd + 'npTime12').val() : "0";
					rowData001.npTime13 = ($('#' + equipCd + 'npTime13').val()!=null && $('#' + equipCd + 'npTime13').val()!="") ? $('#' + equipCd + 'npTime13').val() : "0";
					rowData001.npTime14 = ($('#' + equipCd + 'npTime14').val()!=null && $('#' + equipCd + 'npTime14').val()!="") ? $('#' + equipCd + 'npTime14').val() : "0";
					rowData001.npTime15 = ($('#' + equipCd + 'npTime15').val()!=null && $('#' + equipCd + 'npTime15').val()!="") ? $('#' + equipCd + 'npTime15').val() : "0";
					rowData001.npTime16 = ($('#' + equipCd + 'npTime16').val()!=null && $('#' + equipCd + 'npTime16').val()!="") ? $('#' + equipCd + 'npTime16').val() : "0";
					rowData001.npTime17 = ($('#' + equipCd + 'npTime17').val()!=null && $('#' + equipCd + 'npTime17').val()!="") ? $('#' + equipCd + 'npTime17').val() : "0";
					rowData001.npTime18 = ($('#' + equipCd + 'npTime18').val()!=null && $('#' + equipCd + 'npTime18').val()!="") ? $('#' + equipCd + 'npTime18').val() : "0";
					rowData001.npTime19 = ($('#' + equipCd + 'npTime19').val()!=null && $('#' + equipCd + 'npTime19').val()!="") ? $('#' + equipCd + 'npTime19').val() : "0";
					rowData001.npTime20 = ($('#' + equipCd + 'npTime20').val()!=null && $('#' + equipCd + 'npTime20').val()!="") ? $('#' + equipCd + 'npTime20').val() : "0";
					rowData001.npTime21 = ($('#' + equipCd + 'npTime21').val()!=null && $('#' + equipCd + 'npTime21').val()!="") ? $('#' + equipCd + 'npTime21').val() : "0";
					rowData001.npTime22 = ($('#' + equipCd + 'npTime22').val()!=null && $('#' + equipCd + 'npTime22').val()!="") ? $('#' + equipCd + 'npTime22').val() : "0";
					rowData001.npTime23 = ($('#' + equipCd + 'npTime23').val()!=null && $('#' + equipCd + 'npTime23').val()!="") ? $('#' + equipCd + 'npTime23').val() : "0";
					rowData001.npTime24 = ($('#' + equipCd + 'npTime24').val()!=null && $('#' + equipCd + 'npTime24').val()!="") ? $('#' + equipCd + 'npTime24').val() : "0";
					rowData001.npTime25 = ($('#' + equipCd + 'npTime25').val()!=null && $('#' + equipCd + 'npTime25').val()!="") ? $('#' + equipCd + 'npTime25').val() : "0";
					rowData001.npTime26 = ($('#' + equipCd + 'npTime26').val()!=null && $('#' + equipCd + 'npTime26').val()!="") ? $('#' + equipCd + 'npTime26').val() : "0";
					rowData001.npTime27 = ($('#' + equipCd + 'npTime27').val()!=null && $('#' + equipCd + 'npTime27').val()!="") ? $('#' + equipCd + 'npTime27').val() : "0";
					rowData001.npTime28 = ($('#' + equipCd + 'npTime28').val()!=null && $('#' + equipCd + 'npTime28').val()!="") ? $('#' + equipCd + 'npTime28').val() : "0";
					rowData001.npTime29 = ($('#' + equipCd + 'npTime29').val()!=null && $('#' + equipCd + 'npTime29').val()!="") ? $('#' + equipCd + 'npTime29').val() : "0";
					rowData001.npTime30 = ($('#' + equipCd + 'npTime30').val()!=null && $('#' + equipCd + 'npTime30').val()!="") ? $('#' + equipCd + 'npTime30').val() : "0";
					rowData001.npTime31 = ($('#' + equipCd + 'npTime31').val()!=null && $('#' + equipCd + 'npTime31').val()!="") ? $('#' + equipCd + 'npTime31').val() : "0";
			        
					dataList.push(rowData001);
					return false;
				}
	
			});
			//console.log(dataList);
	
			$.ajax({
	            url: '<c:url value="/wm/deleteMonthProductionPlan"/>',
	            type: 'POST',
	            data: JSON.stringify(dataList),
	            dataType:"json",
	            contentType : "application/json; charset=UTF-8",
	            beforeSend: function() {
	              //  $('#btnAddConfirm').addClass('d-none');
	              //  $('#btnAddConfirmLoading').removeClass('d-none');
	            },
	            success: function (res) {              
	                if (res.result == 'ok') { 
	                	$('#jcListTable').DataTable().ajax.reload( function () {});                	
	                	toastr.success(res.message);
						
	                } else {
	                	toastr.error(res.message, '', {timeOut: 5000});
	                }
	            },
	            complete:function(){
	            	$('#my-spinner').hide();
	            }
	        });
		} else{
			toastr.warning('목록에 없는 설비입니다.');			
			return false;
		}
       
	});

	$('#btnInfo').on('click', function() {
		$('#infoPopUpModal').modal('show');
	});

	$('#btnDeleteAll').on('click', function() {
		$('#deleteModal').modal('show');
	});

	$('#btnDeleteConfirm').on('click', function() {
		$.ajax({
    		url: '<c:url value="wm/deleteMonthProductionPlanMain"/>',
			type: 'POST',  
			async: false,
			data: {
				'menuAuth'	:	menuAuth,
				'fpDate'	:	function(){return inWhsDateCal.replace(/-/g,"");},
				'cplGubun'	:	function(){return "001";},
				'gubun'		:	function(){return "001";},						
			},
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {                     
                	  toastr.success("삭제되었습니다.");  
                      $('#deleteModal').modal('hide');              
                      $('#productionPlanTable').DataTable().draw(false).columns.adjust();        	
                } else{ //에러
                	toastr.error(res.message, '', {timeOut: 5000});
                }
            },
            complete:function(){
                
            }
        });
		
	});

    var lastIdx = null;
    var table = $('#productionPlanTable').DataTable();
	
	 $(document) .on( '#productionPlanTable tbody mouseover','td',function () {
	      var colIdx = table.cell(this).index().column;
	      if ( colIdx !== lastIdx ) {
	         $( table.cells().nodes() ).removeClass( 'highlight' );
	         $( table.column( colIdx ).nodes() ).addClass( 'highlight' );
	      }
	   }) .on( 'mouseleave',function () {
	      $( table.cells().nodes() ).removeClass( 'highlight' );
	  });

    let resizeTimer = false;    
    $(window).on('resize', function(e) {
         if( !resizeTimer ) {
          $(window).trigger('resizestart');     
       }
       clearTimeout(resizeTimer);
       resizeTimer = setTimeout(function() {
          resizeTimer = false;
          $(window).trigger('resizeend');
       }, 50);
    }).on('resizeend', function(){
       dataTableDrawAll(); 
    });
    
	 function dataTableDrawAll() {
		  $('#productionPlanTable').DataTable().draw(false).columns.adjust();
	 }

	//엑셀파일 선택
	$('#fileUpload').change(function(){
		let formData = new FormData($('#fileUploadForm')[0]);

		let str = $('#fileUpload').val();

		//엑셀 파일인지 확인
		if(str.substring(str.lastIndexOf(".")+1)=="xls"||str.substring(str.lastIndexOf(".")+1)=="xlsx"){
			//엑셀파일 업로드하는 ajax
			$.ajax({
		    	type: "POST",
		    	enctype: 'multipart/form-data',
		    	data: formData,
		    	url:'<c:url value="/wm/monthExcelUpload"/>',
		    	processData: false,
		    	contentType: false,
		    	cache: false,
		    	success: function (res) {
					if (res.result == 'ok') {
						let url = res.data;

		    			//테이블 생성(excel읽기)_ajax
						$.ajax({
							url : '<c:url value="/wm/readMonthPlanByExcel"/>',
		    		        type: 'GET',
		    		        data: {
		    		        	//'menuAuth'	 	: 		menuAuth,
		    		        	'filename'		:		url,
		    		        },
		    		        success: function (res) {
								if(res.result == 'ok') {
									toastr.success('파일읽기 성공');
								    $('#fileUpload').val('');
								    let data = res.data;

								    let half = data.length/2;
								    let dayNum = 1;
								    let nightNum = 1;
								    for(var i=0; i<=data.length; i++){
									    if(i<half){ //주간
										    $('#DplanMan'+dayNum).val(data[i]);
										    dayNum++;
										} else { //야간
											$('#NplanMan'+nightNum).val(data[i]);
											nightNum++;
										}
									}

									//$('#btnPlanSave').trigger('click');
						    	} else if (res.result == 'fail') {
						    		toastr.warning(res.message, '', {timeOut: 5000});
						    	} else if (res.result == 'error') {
						    		toastr.error(res.message, '', {timeOut: 5000});
						    	}
							}
						});
						//테이블 생성(excel읽기)_ajax
	    			}
		    	}
	    	});
		} else {
			toastr.warning('excel파일을 선택해주세요.');
			return false;
		}
	})	
</script>

</body>
</html>
