
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@ page session= "true" %>

<%@include file="../layout/top.jsp" %>
<%@include file="../layout/header.jsp" %>

<!--
<body data-spy="scroll" data-target="page" data-offset="76">
-->
<body>
<%
	String menu = session.getAttribute("showMenu").toString();
	String userNm = session.getAttribute("userNm").toString();
	String userNumber = session.getAttribute("userNumber").toString();
	if(menu.equals("no")) {
	} else if(menu.equals("yes")) {
%>
		<%-- <%@include file="../layout/header.jsp" %> --%>
		<%@include file="../layout/aside.jsp" %>
<%
	}
%>
<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정실적관리(POP)</a></li>
				<li class="breadcrumb-item active">작업지시선택</li>
			</ol>
		</nav>
		<h5 class="monitor-status">
			<span class="monitor-status" id="monitoringLoder" style="margin-left:auto;" >
				<img src="<c:url value='/resources/assets/images/loader2.gif'/>" style="width: 26px;">&nbsp;&nbsp;
			</span>
		</h5>
		<h5 id="agtEquipListTitle" class="">
		</h5>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main" style="padding-right:0px;">
		<div class="row table-wrap-hid" id="mainCard" style="min-height:835px;">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="leftList" style="width:13%; margin-right:3px; padding-bottom:0px;">
				<div class="card" style="margin-bottom: 0px;">
					<!-- .table-responsive -->
					<input type="search" class="form-control touch6" style="max-width: 100%;" id="equipCdScan" placeholder="설비코드를 스캔해주세요." onsearch="equipScanFunction(this)">
<!-- 					<div id="equipScanDiv"></div> -->
					<div class="table-responsive">
						<table id="equipCodeAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px">설비명</th>
								</tr>
							</thead>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
			</div>
			<!-- /.left-list -->
			<!-- ---------------------------------------------------------------------------------- mainView 시작 ---------------------------------------------------------------------------------- -->
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list workOrder-left-list" id="middleList" style="width:77%; margin-right: 3px;">
				<!-- 작업지시 정보 시작-->
				<div class="card-body p-3">
					<!-- 
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="row">
								&nbsp; <label class="input-label-sm touch6">작지일</label>
								<input class="form-control touch6" style="width: 150px;" type="date" id="ordDate" name="ordDate" />
								
									<div class="form-group input-sub m-0 row">
										<input class="form-control" style="width:97px;" type="text" id="ordDate" name="ordDate" />
										<button onclick="fnPopUpCalendar(ordDate,ordDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button">
										<span class="oi oi-calendar"></span>
										</button>
									</div>
									
								<div id="workSearchCond">
									&nbsp;&nbsp;&nbsp; <label class="input-label-sm touch6">주야</label>
									<select class="custom-select custom-select-lg touch6" id="ordGubunCd" style="width: 70px;"></select>
								</div>
								&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-primary touch6" id="btnWorkOrdRetv">조회</button>
							</div>
						</div>
						<div class="col-sm-12 col-md-6 float-right">
							&nbsp;&nbsp;
							<button type="button" class="btn btn-primary float-right touch6" id="btnMain" onclick="location.href='/main'">메인 화면</button>
							&nbsp;&nbsp;
							<button type="button" class="btn btn-primary float-right touch6" id="closeFullScreen">전체화면 해제</button>
							&nbsp;&nbsp;
							<button type="button" class="btn btn-primary float-right touch6" id="openFullScreen">전체화면</button>
							&nbsp;&nbsp;
							
							<button type="button" class="btn btn-primary float-right" id="btnEnd">종료</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="btnStart">시작</button>
							<button type="button" class="btn btn-primary float-right mr-1" id="btnPrint">인쇄(엑셀 다운)</button>
							
						</div>
					</div>
					 -->
					
					<div class="row" style="position:relative">
						&nbsp;
						<div class="row p-1" id="ordDateDiv" >
							<label class="input-label-sm touch6">작지일</label>
							<input class="form-control touch6" style="width:150px;" type="date" id="ordDate" name="ordDate" type="year"/>
						</div>
						<!-- 
						<div class="form-group input-sub m-0 row">
							<input class="form-control" style="width:97px;" type="text" id="ordDate" name="ordDate" />
							<button onclick="fnPopUpCalendar(ordDate,ordDate,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button">
							<span class="oi oi-calendar"></span>
							</button>
						</div>
						 -->
						<div id="workSearchCond">
							&nbsp;&nbsp;&nbsp;
							<label class="input-label-sm touch6" style="margin-top:5px;		display: none;">주야</label>
							<select class="custom-select custom-select-md touch6" id="ordGubunCd" style="width:70px;		display: none;"></select>
						</div>
						&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary float-right mr-4 touch6" id="btnWorkOrdRetv" style="margin-top:3px;">조회</button>
						
						
						<div class="row">
							<div style="display: flex; flex-direction: column;">
								<button type="button" class="btn btn-primary ml-3 touch6 mt-1"	id="btnAddWorkOrder">작업지시 추가</button>
								<button type="button" class="btn btn-danger ml-3 touch6 mt-1"	id="btnDeleteWorkOrder">작업지시 삭제</button>
							</div>
						
							<div style="display: flex; flex-wrap: wrap; width: 15rem; align-content: flex-start;">
								<button type="button" class="btn btn-primary touch6 ml-4" 			id="btnStart" 				style="margin-top: 3px;width: 100px;height: 47px;">작업 시작</button>
								<button type="button" class="btn btn-primary touch6 ml-4 d-none" 	id="btnCancel" 				style="margin-top: 3px;width: 100px;height: 47px;">진행 취소</button>								
								<button type="button" class="btn btn-success touch6 ml-1" 			id="btnEnd" 				style="margin-top: 3px;width: 100px;height: 47px;">작업 종료</button>
								<button type="button" class="btn btn-primary touch6 ml-1 d-none"	id="btnReStart"				style="margin-top: 3px;width: 100px;height: 47px;background-color: sienna;color: white;border-color: #a0522d;">완료 취소</button>
								<button type="button" class="btn btn-danger touch6 ml-4" 			id="btnNotRunning_start"	style="margin-top: 3px;width: 100px;height: 47px;">비가동 시작</button>
								<button type="button" class="btn btn-warning touch6 ml-1"			id="btnNotRunning_end"		style="margin-top: 3px;width: 100px;height: 47px;background-color: #EC935E;color: white;border-color: #db6e2d;">비가동 종료</button>
							</div>
							
							<div style="display: flex; flex-direction: column;">
								<button type="button" class="btn btn-primary ml-3 touch6" id="btnOrdLotNoFirstStepNew" style="margin-top:3px;">초물</button>						
								<button type="button" class="btn btn-primary ml-3 touch6" id="btnOrdLotNoSecondStepNew" style="margin-top:3px;">중물</button>
								<button type="button" class="btn btn-primary ml-3 touch6" id="btnOrdLotNoThirdStepNew" style="margin-top:3px;">종물</button>
							</div>
							
							<div style="display: flex; flex-direction: column;">
								<button type="button" class="btn btn-primary ml-4 touch6" id="btnPtfe1Faulty" style="margin-top:3px;">1차 진접 테프론 교체</button>
								<button type="button" class="btn btn-primary ml-4 touch6" id="btnPtfe2Faulty" style="margin-top:3px;">2차 진접 테프론 교체</button>
							</div>
							
						</div>
						
						<div style="position:absolute;right:0 ">
							<select class="custom-select custom-select-md touch6" id="showMenu" style="width:100px; margin-right: 9px;">
								<option value="no">메뉴 숨김</option>
								<option value="yes">메뉴 표시</option>
							</select>
							<!-- <button type="button" class="btn btn-primary float-right touch6" id="btnMain" onclick="location.href='/main'">메인 화면</button> -->
							<button type="button" class="btn btn-primary float-right touch6" id="closeFullScreen" style="margin-right: 5px;">전체화면 해제</button>
							<button type="button" class="btn btn-primary float-right touch6" id="openFullScreen" style="margin-right: 5px;">전체화면</button>
	                    </div>
	                    
	                    
					</div>
				</div>
				<div class="card" id="workOrderTableCard">
					<div class="col-md-12 matrl-top-list" style="overflow:scroll; min-height:285px; max-height:285px;">
						<div class="table-responsive">
							<table id="workOrderTable" class="table table-bordered">
								<colgroup>
									<col width="15%">
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								<thead class="thead-light">
									<tr>
										<th style="width:160px">제품(기종)</th>
										<th style="width:50px">재질</th>
										<th style="width:170px">규격</th>
										<th style="width:50px">표면처리</th>
										<th style="width:100px">출고처</th>
										<!-- <th style="width:120px">LOT NO</th> -->
										<th style="width:105px">작지번호</th>
										<th style="width:70px">상태</th>
										<th style="width:40px">근무조</th>
										<!-- <th style="width:70px">담당1</th> -->
										<!-- <th style="width:70px">담당2</th> -->
									</tr>
								</thead>
							</table>
						</div>
					</div>
					<br>
					<div class="card-body col-sm-12" style="padding: 1px;">
						<h6>자재투입내역</h6>
					</div>
					<div class="col-md-12 matrl-bottom-list" style="min-height: 320px;">
						<div>
							<label class="input-label-sm float-left touch6">바코드</label>
							<input type="text" class="form-control float-left touch6" id="barcodeNo" name="barcodeNo">
							<span class="float-left  mr-2">&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control float-left touch6" style="border: 0px;" id="matrlCdText" name="matrlCdText" disabled>
							<button type="button" class="btn btn-primary float-left touch6" id="btnMatrlList" disabled>추가 투입자재</button>
							<button type="button" class="btn btn-primary float-left touch6 ml-2" id="btnFifoCheck">선입선출 여부</button>
							<button type="button" class="btn btn-primary float-right touch6" id="btnSave">저장</button>
							<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnDelete">라인삭제</button>
							<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnMetalChange">주자재 교체</button>
						</div>
						<div class="table-responsive">
							<table id="workOrderMatrlTable" class="table table-bordered">
								<colgroup><col width="7%"></colgroup>
								<colgroup><col width="13%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="9%"></colgroup>
								<colgroup><col width="8%"></colgroup>
								<thead class="thead-light">
									<tr>
										<th class="text-center">재질</th>
										<th class="text-center">자재명</th>
										<th class="text-center">표면처리</th>
										<th class="text-center">LOT</th>
										<th class="text-center">투입중량</th>
										<th class="text-center">권취잔량</th>
										<th class="text-center">바코드</th>
										<th class="text-center">투입일</th>
										<th class="text-center">상태</th>
										<th class="text-center">교체위치</th>
										<th class="text-center">불량 상태</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<!-- 작업지시 정보 끝 -->
				
				<!-- 불량 통계 정보 시작 -->
				<div class="d-none" id="equipFaultyTableCard">
					<table class="table table-bordered" id="equipFaultyTable">
						<tr>
							<th class="touch6" colspan="2">구분</th>
							<th class="touch6">주간</th>
							<th class="touch6">야간</th>
							<th class="touch6">소계(KG)</th>
						</tr>
						
						<tr class="select_prcssFaulty">
							<td class="touch6" rowspan="2">${processFaultyNm}</td>
							<td class="touch6">횟수</td>
							<td class="touch6" align="right"><span id="dayTotalPrcssCount"></span></td>
							<td class="touch6" align="right"><span id="nightTotalPrcssCount"></span></td>
							<td class="touch6" align="right"><span id="totalPrcssCount"></span></td>
						</tr>
						<tr class="select_prcssFaulty">
							<td class="touch6">불량(KG)</td>
							<td class="touch6" align="right"><span id="dayTotalPrcssSum" class="dayTotalFaulty"></span></td>
							<td class="touch6" align="right"><span id="nightTotalPrcssSum" class="nightTotalFaulty"></span></td>
							<td class="touch6" align="right"><span id="totalPrcssSum" class="totalFaulty"></span></td>
						</tr>
						<tr class="select_matrlFaulty">
							<td class="touch6" rowspan="2">${matrlFaultyNm}</td>
							<td class="touch6">횟수</td>
							<td class="touch6" align="right"><span id="dayTotalMatrlCount"></span></td>
							<td class="touch6" align="right"><span id="nightTotalMatrlCount"></span></td>
							<td class="touch6" align="right"><span id="totalMatrlCount"></span></td>
						</tr>
						<tr class="select_matrlFaulty">
							<td class="touch6">불량(KG)</td>
							<td class="touch6" align="right"><span id="dayTotalMatrlSum"></span></td>
							<td class="touch6" align="right"><span id="nightTotalMatrlSum"></span></td>
							<td class="touch6" align="right"><span id="totalMatrlSum"></span></td>
						</tr>
						<tr class="select_replaceFaulty">
							<td class="touch6" rowspan="2">${replaceFaultyNm}</td>
							<td class="touch6">횟수</td>
							<td class="touch6" align="right"><span id="dayTotalReplaceCount"></span></td>
							<td class="touch6" align="right"><span id="nightTotalReplaceCount"></span></td>
							<td class="touch6" align="right"><span id="totalReplaceCount"></span></td>
						</tr>
						<tr class="select_replaceFaulty">
							<td class="touch6">불량(KG)</td>
							<td class="touch6" align="right"><span id="dayTotalReplaceSum"></span></td>
							<td class="touch6" align="right"><span id="nightTotalReplaceSum"></span></td>
							<td class="touch6" align="right"><span id="totalReplaceSum"></span></td>
						</tr>
						<tr class="select_troubleFaulty">
							<td class="touch6" rowspan="2">${troubleFaultyNm}</td>
							<td class="touch6">횟수</td>
							<td class="touch6" align="right"><span id="dayTotalTroubleCount"></span></td>
							<td class="touch6" align="right"><span id="nightTotalTroubleCount"></span></td>
							<td class="touch6" align="right"><span id="totalTroubleCount"></span></td>
						</tr>
						<tr class="select_troubleFaulty">
							<td class="touch6">불량(KG)</td>
							<td class="touch6" align="right"><span id="dayTotalTroubleSum"></span></td>
							<td class="touch6" align="right"><span id="nightTotalTroubleSum"></span></td>
							<td class="touch6" align="right"><span id="totalTroubleSum"></span></td>
						</tr>
						<tr>
							<th class="touch6" rowspan="2" style="color:blue">소계</th>
							<th class="touch6" style="color:blue">총 횟수</th>
							<th class="touch6" align="right"><span id="dayCountSum" style="color:blue"></span></th>
							<th class="touch6" align="right"><span id="nightCountSum" style="color:blue"></span></th>
							<th class="touch6" align="right"><span id="totalCountSum" style="color:blue"></span></th>
						</tr>
						<tr>
							<th class="touch6" style="color:blue">총 불량(KG)</th>
							<th class="touch6"><span id="dayTotalSum" style="color:blue"></span></th>
							<th class="touch6"><span id="nightTotalSum" style="color:blue"></span></th>
							<th class="touch6"><span id="totalSum" style="color:blue"></span></th>
						</tr>
					</table>
				</div>
				<!-- 불량 통계 정보 끝 -->
				
				<!-- 비가동사유 정보 시작 -->
				<div class="d-none" id="equipDowntimeTableCard">
					<div class="table-responsive">
					<form id="fromEquipDowntime">
						<table class="table table-bordered" id="equipDowntimeAdmTable">
						 	 <thead class="thead-light">
								<tr>
									<th class="touch6">구분</th>
									<th class="touch6">시작시간</th>
									<th class="touch6">종료시간</th>
									<th class="touch6">중단시간</th>
								</tr>
							</thead>
								<tr id="001">
									<th class="touch6">설비문제</th>	
									<td><input type="time" class="form-control touch6" id="equipStartTime"	style="text-align:center; width:100%;  height:40px;" name="equipStartTime"  pattern="([1]?[0-9]|2[0-3]):[0-5][0-9]"></td>	
									<td><input type="time" class="form-control touch6" id="equipEndTime"	style=" width:100%; text-align:center; height:40px;" name="equipEndTime"	pattern="([1]?[0-9]|2[0-3]):[0-5][0-9]"></td>
									<td><input type="text" class="form-control touch6" id="equipStopTime"	style=" width:100%; text-align:center; height:40px;" name="equipStopTime"	maxlength="7" placeholder="HH:MM"></td>					
								</tr>
								<tr id="002">
									<th class="touch6">자재부족</th>
									<td><input type="time" class="form-control touch6" id="matrlStartTime" style=" width:100%; text-align:center; height:40px;" name="matrlStartTime"  value="" maxlength="5" placeholder="HH:MM"></td>	
									<td><input type="time" class="form-control touch6" id="matrlEndTime"	style=" width:100%; text-align:center; height:40px;" name="matrlEndTime"  value="" maxlength="5" placeholder="HH:MM"></td>
									<td><input type="text" class="form-control touch6" id="matrlStopTime"	style=" width:100%; text-align:center; height:40px;" name="matrlStopTime"  value="" maxlength="4" placeholder="HH:MM"></td>										
								</tr>
								<tr id="003">
									<th class="touch6">계획정지</th>			
									<td><input type="time" class="form-control touch6" id="planStartTime"	style=" width:100%; text-align:center; height:40px;" name="planStartTime"  value="" maxlength="5" placeholder="HH:MM"></td>	
									<td><input type="time" class="form-control touch6" id="planEndTime"	style=" width:100%; text-align:center; height:40px;" name="planEndTime"  value="" maxlength="5" placeholder="HH:MM"></td>
									<td><input type="text" class="form-control touch6" id="planStopTime"	style=" width:100%; text-align:center; height:40px;" name="planStopTime"  value="" maxlength="4" placeholder="HH:MM"></td>				
								</tr>
								<tr id="004">
									<th class="touch6">인원부족</th>	
									<td><input type="time" class="form-control touch6" id="humanStartTime" style=" width:100%; text-align:center; height:40px;" name="humanStartTime"  value="" maxlength="5" placeholder="HH:MM"></td>	
									<td><input type="time" class="form-control touch6" id="humanEndTime"	style=" width:100%; text-align:center; height:40px;" name="humanEndTime"  value="" maxlength="5" placeholder="HH:MM"></td>
									<td><input type="text" class="form-control touch6" id="humanStopTime"	style=" width:100%; text-align:center; height:40px;" name="humanStopTime"  value="" maxlength="4" placeholder="HH:MM"></td>								
								</tr>
								<tr id="005">
									<th class="touch6">기타</th>								
									<td><input type="time" class="form-control touch6" id="startTime"	style=" width:100%; text-align:center; height:40px;" name="startTime"  value="" maxlength="5" placeholder="HH:MM"></td>	
									<td><input type="time" class="form-control touch6" id="endTime"	style=" width:100%; text-align:center; height:40px;" name="endTime"  value="" maxlength="5" placeholder="HH:MM"></td>
									<td><input type="text" class="form-control touch6" id="stopTime"	style=" width:100%; text-align:center; height:40px;" name="stopTime"  value="" maxlength="4" placeholder="HH:MM"></td>						
								</tr>
							</table>
						</form>
							<br>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnDowntimeSave" disabled >저장</button>
					</div>
				</div>
				<!-- 비가동사유 정보 끝 -->
			</div>
			<!-- ---------------------------------------------------------------------------------- mainView 끝 ---------------------------------------------------------------------------------- -->

			
			
			
			
			
			
			
			<!-- ---------------------------------------------------------------------------------- sideView 시작 ---------------------------------------------------------------------------------- -->
			<div class="right-list right-70" id="rightList" style="width:9.5%; min-height:825px;">
				<!-- 닫기 버튼 -->
				<!-- <h5 class="float-left" id="stepWorkOrdNo"></h5> -->
				<div class="card-body d-none row" id="closeLeftView" style="padding-top: 8px; padding-bottom: 13px;">
					<div class="col-10 row">
						<div class="row d-none" id="faultyRegDateDiv">
							<label class="input-label-sm touch6">불량등록일</label>
							<input class="form-control touch6 mr-2" style="width:150px;" type="date" id="faultyRegDate" name="faultyRegDate" disabled>
							<select class="custom-select custom-select-md touch6" id="nowTime" onchange="nowTimeChange()" style="width:70px;">
								<option value="001">주간</option>
								<option value="002">야간</option>
							</select>
							<button type="button" class="btn btn-primary float-right touch6 ml-2" id="btnFaultyRetv">조회</button>
						</div>
						<h4 class="p-1 ml-3 mr-3 mb-0" id="mainMatrlLotNo">주자재 LotNo</h4>
					</div>
					<div class="col-2">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right closePlan"><i class="mdi mdi-close closePlan"></i></a>
						</div>
					</div>
				</div>
				<div class="btn-group-vertical" id="btnCard" style="width: 100%;">
					<button type="button" class="btn btn-success btn-lg btnRight" id="btnPrint">인쇄(엑셀 다운)</button>
					<span><br></span>
					<!--
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnFirstStep" disabled>초물 입력</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnSecondStep" disabled>중물 입력</button>
					<span><br></span>
					-->
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnOutput">생산실적 입력</button>
					<span><br></span>
					<!-- 
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnVisionOutput">비전 검사량 입력</button>
					<span><br></span>
					 -->
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnFaulty">불량중량 입력</button>
					<span><br></span>
					
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnVisionFaulty">비전불량 현황</button>
					<span><br></span>
					
					<button type="button" class="btn btn-danger btn-lg btnRight" id="btnDowntime">비가동 조회</button>
					<span><br></span>
					<button type="button" class="btn btn-purple btn-lg btnRight" id="btnMonitoring">POP 모니터링</button>
					<span><br></span>
					<button type="button" class="btn btn-orange btn-orange_color btn-lg btnRight" id="btnMonitoringHistory">모니터링 기록</button>
					<span><br></span>
					<button type="button" class="btn btn-outline-secondary btn-lg btnRight btn-primary" id="btnMonitoringOnOff" style="color:white;">모니터링 ON</button>
					<span><br></span>
					<button type="button" class="btn btn-dark btn-lg btnRight" id="btnMatrlFaulty">자재 불량 등록</button>
					<span><br></span>
					<button type="button" class="btn btn btn-lg btnRight" style="background-color: slateblue; color: white;" id="btnMatrlFaultyCancel" >자재 불량 취소</button>
					<span><br></span>
					
					<!-- <button type="button" class="btn btn-primary btn-lg btnRight" id="btnPtfe1Faulty">1차 진접 테프론 교체</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnPtfe2Faulty">2차 진접 테프론 교체</button>
					<span><br></span>-->
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnSil1Faulty">1차 진접 실리콘 교체</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnSil2Faulty">2차 진접 실리콘 교체</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnTray">생산실적(Tray)</button>
					<span><br></span>
					<!-- 
					<button type="button" class="btn btn-warning btn-lg btnRight d-none" id="btnWorkOrdConnect">작지 연결</button>
					<span><br></span>
					 -->
				</div>
				
				<!-- 초,중물 입력 시작 -->
				<%-- 
				<!-- 머티리얼즈파크 1공장(성남)은 생산실적 등록 시 자동 등록 후 팝업으로 조회! -->
				<div class="d-none" id="equipSizeCondStepCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
					<ul class="nav nav-tabs card-header-tabs m-0">
						<li class="nav-item"><a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">온도</a></li>
						<li class="nav-item"><a class="nav-link" id="tab2Nav" data-toggle="tab" href="#tab2">치수</a></li>
						<li class="nav-item ml-auto">
							<button type="button" class="btn btn-danger float-left mr-2 touch5" id="btnStepDelete">삭제</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepSave">저장</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepEdit">수정</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnFirstStepInsert" disabled>초물 등록</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnSecondStepInsert" disabled>중물 등록</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepReload">조회</button>
						</li>
					</ul>
					<div class="card-body p-0">
						<div id="myTabContent" class="tab-content">
							<div class="tab-pane fade active show" id="tab1">
								<table class="table table-bordered">
									<colgroup><col width="15%"></colgroup>
									<colgroup><col width="12%"></colgroup>
									<colgroup><col width="40%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<tr>
										<th rowspan="3" class="touch3">위치</th>
				                        <th rowspan="3" class="touch3">시료</th>
				                        <th rowspan="3" class="touch3">조건</th>
				                        <th colspan="3" class="touch3">측정시간</th>
									</tr>
									<tr>
										<th class="touch3">초물</th>
				                        <th class="touch3">중물</th>
				                        <th class="touch3">종물</th>
									</tr>
									<tr>
										<td><input type="time" maxlength="5" class="form-control text-center touch3" id="firstRegTime" placeholder="HH:MM" disabled></td>
				                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="secondRegTime" placeholder="HH:MM" disabled></td>
				                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="thirdRegTime" placeholder="HH:MM" disabled></td>
									</tr>
									<tr>
										<th class="touch3">예열</th>
										<th class="touch3"></th>
										<th class="touch3"><span id="warmupCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWarmupCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWarmupCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWarmupCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="2">가접1</th>
										<th class="touch3">(상)</th>
										<th class="touch3"><span id="fitup1UpCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup1UpCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하)</th>
										<th class="touch3"><span id="fitup1DownCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup1DownCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="4">가접2</th>
										<th class="touch3">(상좌)</th>
										<th class="touch3"><span id="fitup2UpleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2UpleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하좌)</th>
										<th class="touch3"><span id="fitup2DownleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2DownleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(상우)</th>
										<th class="touch3"><span id="fitup2UprightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2UprightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하우)</th>
										<th class="touch3"><span id="fitup2DownrightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2DownrightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="2">롤히터</th>
										<th class="touch3">(상)</th>
										<th class="touch3"><span id="rollheatUpCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatUpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatUpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdRollheatUpCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하)</th>
										<th class="touch3"><span id="rollheatDownCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatDownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatDownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdRollheatDownCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="4">1차</th>
										<th class="touch3">(상좌)</th>
										<th class="touch3"><span id="firstUpleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstUpleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하좌)</th>
										<th class="touch3"><span id="firstDownleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstDownleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(상우)</th>
										<th class="touch3"><span id="firstUprightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstUprightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하우)</th>
										<th class="touch3"><span id="firstDownrightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstDownrightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="2">1차 푸셔</th>
										<th class="touch3">(상)</th>
										<th class="touch3"><span id="push1UpCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPush1UpCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하)</th>
										<th class="touch3"><span id="push1DownCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPush1DownCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="4">2차</th>
										<th class="touch3">(상좌)</th>
										<th class="touch3"><span id="secondUpleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondUpleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하좌)</th>
										<th class="touch3"><span id="secondDownleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondDownleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(상우)</th>
										<th class="touch3"><span id="secondUprightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondUprightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하우)</th>
										<th class="touch3"><span id="secondDownrightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondDownrightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="4">3차</th>
										<th class="touch3">(상좌)</th>
										<th class="touch3"><span id="thirdUpleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUpleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdUpleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하좌)</th>
										<th class="touch3"><span id="thirdDownleftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownleftCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdDownleftCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(상우)</th>
										<th class="touch3"><span id="thirdUprightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUprightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdUprightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하우)</th>
										<th class="touch3"><span id="thirdDownrightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownrightCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdDownrightCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="2">진접1</th>
										<th class="touch3">(상)</th>
										<th class="touch3"><span id="jinjeop1UpCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop1UpCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하)</th>
										<th class="touch3"><span id="jinjeop1DownCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop1DownCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3" rowspan="2">진접2</th>
										<th class="touch3">(상)</th>
										<th class="touch3"><span id="jinjeop2UpCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2UpCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop2UpCond" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(하)</th>
										<th class="touch3"><span id="jinjeop2DownCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2DownCond"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop2DownCond" disabled></td>
									</tr>
								</table>
							</div>
							<div class="tab-pane fade" id="tab2">
								<table class="table table-bordered">
									<colgroup><col width="15%"></colgroup>
									<colgroup><col width="12%"></colgroup>
									<colgroup><col width="40%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<colgroup><col width="10%"></colgroup>
									<tr>
										<th rowspan="3" class="touch3">위치</th>
				                        <th rowspan="3" class="touch3">시료</th>
				                        <th rowspan="3" class="touch3">조건</th>
				                        <th colspan="3" class="touch3">측정시간</th>
									</tr>
									<tr>
										<th class="touch3">초물</th>
				                        <th class="touch3">중물</th>
				                        <th class="touch3">종물</th>
									</tr>
									<tr>
										<td><input type="time" maxlength="5" class="form-control text-center touch3" id="firstRegTime" placeholder="HH:MM" disabled></td>
				                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="secondRegTime" placeholder="HH:MM" disabled></td>
				                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="thirdRegTime" placeholder="HH:MM" disabled></td>
									</tr>
									<tr>
										<input type="hidden" id="workOrdNo">
										<input type="hidden" id="equipCondSeq">
										<input type="hidden" id="firstStepSearch">
										<input type="hidden" id="secondStepSearch">
										<input type="hidden" id="thirdStepSearch">
										<th rowspan="2" class="touch3">Welding Part</th>
										<th class="touch3">(좌)</th>
										<th><span class="cond touch3" id="wpLeftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWpLeftAlwnce" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(우)</th>
										<th class="touch3"><span id="wpRightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWpRightAlwnce" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">Pitch</th>
										<th class="touch3">(좌)</th>
										<th class="touch3"><span class="cond" id="pitchLeftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPitchLeftAlwnce" disabled></td>
									</tr>                                                                                       
									<tr>
										<th class="touch3">(우)</th>
										<th class="touch3"><span class="cond" id="pitchRightCond"></span></th>                                                                         
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchRightAlwnce" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchRightAlwnce" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPitchRightAlwnce" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">P.P Film 날개</th>
										<th class="touch3">(좌)</th>
										<th class="touch3"><span class="cond" id="ppfWingLeftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingLeftAlwnce" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingLeftAlwnce" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfWingLeftAlwnce" disabled></td>
									</tr>
									<tr>
										<th class="touch3">(우)</th>
										<th class="touch3"><span class="cond" id="ppfWingRightCond"></span></th>                                                                         
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfWingRightAlwnce" disabled></td>
									</tr>
									<tr>                                
										<th rowspan="2" class="touch3">P.P Film 폭</th>
										<th class="touch3">(좌)</th>
										<th><span class="cond" id="ppfDepthLeftCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthLeftAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfDepthLeftAlwnce" disabled></td>
									</tr>
									<tr>                                                                                        
										<th class="touch3">(우)</th>
										<th class="touch3"><span class="cond" id="ppfDepthRightCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthRightAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfDepthRightAlwnce" disabled></td>
									</tr>
									<tr>                                
										<th class="touch3">Film</th>
										<th class="touch3">총길이</th>
										<th class="touch3"><span class="cond" id="filmCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFilmAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFilmAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFilmAlwnce" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">METAL</th>
										<th class="touch3">폭</th>
										<th class="touch3"><span class="cond" id="metalDepthCond"></span></th>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalDepthAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalDepthAlwnce"></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdMetalDepthAlwnce" disabled></td>
									</tr>
									<tr>
										<th class="touch3">두께</th>
										<th class="touch3"><span class="cond" id="metalThicknessCond"></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalThicknessAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalThicknessAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdMetalThicknessAlwnce" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">총두께</th>
										<th class="touch3">Center</th>
										<th class="touch3"><span class="cond" id="thCenterCond"></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThCenterAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThCenterAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThCenterAlwnce" disabled></td>
									</tr>                                                                                       
									<tr>
										<th class="touch3">Edge</th>
										<th class="touch3"><span class="cond" id="thEdgeCond"></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThEdgeAlwncePlus"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThEdgeAlwncePlus"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThEdgeAlwncePlus" disabled></td>
									</tr>
									<tr>
										<th rowspan="3" class="touch3">Burr (MAX)</th>
										<th class="touch3">Metal</th>
										<th class="touch3"><span class="cond" id="burrCond"></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrMetalAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrMetalAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrMetalAlwnce" disabled></td>
									</tr>
									<tr>
										<th class="touch3">R-Cut</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRcutAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRcutAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrRcutAlwnce"disabled></td>
									</tr>
									<tr>
										<th class="touch3">R끝단</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRedgeAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRedgeAlwnce"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrRedgeAlwnce" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">돌기크기<br>좌상</th>
										<th class="touch3">높이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftupHeight" disabled></td>
									</tr>
									<tr>
										<th class="touch3">넓이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftupWidth" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">돌기크기<br>좌하</th>
										<th class="touch3">높이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftdownHeight" disabled></td>
									</tr>
									<tr>
										<th class="touch3">넓이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftdownWidth" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">돌기크기<br>우상</th>
										<th class="touch3">높이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightupHeight" disabled></td>
									</tr>
									<tr>
										<th class="touch3">넓이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightupWidth" disabled></td>
									</tr>
									<tr>
										<th rowspan="2" class="touch3">돌기크기<br>우하</th>
										<th class="touch3">높이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownHeight"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightdownHeight" disabled></td>
									</tr>
									<tr>
										<th class="touch3">넓이</th>
										<th class="touch3"><span class="cond" id=""></span></th>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownWidth"></td>
										<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightdownWidth" disabled></td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<!-- <div class="table-responsive"> -->
				</div>
				<!-- 머티리얼즈파크 1공장(성남)은 생산실적 등록 시 자동 등록 후 팝업으로 조회! -->
				--%>
				<!-- 초,중물 입력 끝 -->
				
				<!-- 생산실적 입력 시작 -->
				<div class="d-none" id="outPutCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
					<!-- <div class="table-responsive"> -->
						<table class="table table-bordered float-left mr-1" style="width:49%;">
							<colgroup><col width="50%"></colgroup>
							<colgroup><col width="50%"></colgroup>							
							<tr>
								<th class="touch6">주간/야간</th>
								<td><select class="custom-select custom-select-lg touch6" id="gubun" style="height:30px;" disabled></select></td>
							</tr>
							<tr>
								<th class="touch6">전표일자</th>
								<td><input type="date" maxlength="7" class="form-control touch6" id="workOrdDate" disabled ></td>
							</tr>
							<tr>
								<th class="touch6">등록일시</th>
								<td><input type="text" class="form-control text-left touch6" id="workOrdRegDate" disabled></td>
							</tr>		
							
						</table>
						<table class="table table-bordered float-right mr-1" style="width:49%; padding-left: 0px; padding-right: 0px;">
							<colgroup><col width="30%"></colgroup>
							<colgroup><col width="35%"></colgroup>
							<colgroup><col width="35%"></colgroup>
							<tr>
								<th class="touch6" style="height:41px;">구분</th>
		                        <th class="touch6" style="height:41px;">중량(Kg)</th>
		                        <th class="touch6" style="height:41px;">수량(Ea)</th>
							</tr>
							<tr>
								<th class="touch6">투입</th>
								<td><input type="text" maxlength="7" class="form-control text-right number-float3 touch6" id="targetWeight" disabled></td>
								<td><input type="text" maxlength="7" class="form-control text-right touch6" id="targetCnt" disabled></td>
							</tr>
							<tr>
								<th class="touch6">생산</th>
								<td><input type="text" maxlength="7" min="0" max="100" class="form-control text-right number-float3 touch6" id="firstWeight" disabled></td>
								<td><input type="text" maxlength="7" class="form-control text-right touch6" id="firstCount" disabled></td>
							</tr>
							<tr>
								<th class="touch6">비전 검사량</th>
								<td><input type="text" style="color:orange" maxlength="7" min="0" max="100" class="form-control text-right number-float3 touch6" id="visionEdgeWeight" disabled></td>
								<td><input type="text" style="color:orange" maxlength="7" class="form-control text-right touch6" id="visionEdgeCnt" disabled></td>
							</tr>
						</table>
					<!-- </div> -->
					<div class="card-body col-md-12 row p-2">
						<div class="col-md-3">
							<button type="button" class="btn btn-danger float-left mr-2 touch6" id="btnOutputDelete">삭제</button>
						</div>
						<div class="col-md-9">						
							<button type="button" class="btn btn-primary float-left mr-2 touch6" id="btnRegistrantChange">등록자 변경</button>
							<button type="button" class="btn btn-primary float-left mr-2 d-none touch6" id="btnOrdLotNoFristStep">초물 확인</button>
							<button type="button" class="btn btn-primary float-left mr-2 d-none touch6" id="btnOrdLotNoSecondStep">중물 확인</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnOutputSave" disabled>저장</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnOutputEdit" >수정</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnOutputAdd">등록</button>
						</div>						
					</div>
					<hr>
					<table class="table table-bordered" id="outputCardTable" style="padding-left:0px; padding-right:0px;">
						<thead class="thead-light">
							<tr>
								<th rowspan="2" class="text-center" style="min-width:30px;">순번</th>
		                        <th rowspan="2" class="text-center" style="min-width:70px;">전표일자</th>
		                        <th rowspan="2" class="text-center" style="min-width:130px;">생산 전표번호</th>
		                        <th colspan="2" class="text-center" style="min-width:65px;">생산</th>
		                        <th colspan="2" class="text-center" style="min-width:65px;">비전 검사량</th>
		                        <!-- <th rowspan="2" class="text-center" style="min-width:120px;">등록일시</th> -->
		                        <th rowspan="2" class="text-center" style="min-width:35px;">주야</th>
		                        <th rowspan="2" class="text-center" style="min-width:40px;">등록자</th>
		                        <th rowspan="2" class="text-center" style="min-width:65px;">상태</th>
							</tr>
							<tr>
								<th class="text-center" style="min-width:50px;">중량(KG)</th>
		                        <th class="text-center" style="min-width:50px;">수량(Ea)</th>
		                        <th class="text-center" style="min-width:50px;">중량(KG)</th>
		                        <th class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px;">수량(Ea)</th>
							</tr>
						</thead>
					</table>
					<!-- 
					<p style="margin-bottom: 0px;">*생산실적 삭제시 발생하는 공백LotNo는 복구되지 않습니다!</p>
					<p style="margin-bottom: 0px;">ex1)생산실적 D0,D1,D2 입력 후 D1 삭제 & 생산실적 추가 입력 시 D3으로 생성</p>
					<p style="margin-bottom: 0px;">ex2)생산실적 D0,D1,D2 입력 후 D2 삭제 & 생산실적 추가 입력 시 D2으로 생성</p>
					 -->
				</div>
				<!-- 생산실적 입력 끝 -->
				
				<!-- 불량등록 입력 시작 -->
				<div class="d-none" id="faultyCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
					<div id="weeklyRange">		
						<!-- 주간 입력&저장 버튼 -->
						<div class="card-body col-sm-12 p-2 d-none" id="cardDay">
							<button type="button" class="btn btn-primary float-left touch6" id="inputDay">주간 입력</button>	
							<button type="button" class="btn btn-primary float-right day ml-4 touch6" id="dayBtnSave">저장</button>
							<label class="input-label-sm float-right touch6" id="faultyRegNm" style="font-weight: 500;font-size: 20px;color: black;">등록자가 없습니다.</label>		
						</div>
						<form id="formDay1">
						<!-- ----- 주간 공정불량 상세정보 시작-----  -->
						<div id="dayPrcssFaultyView" class="d-none">
							<div class="table-responsive">
								<table class="table table-bordered">
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<tbody id="dayTbody">
										<!-- 
										<tr>
											<input type="hidden" id="dayPrcssFaultySearchData">
											<th class="touch4">PMS</th>
					                        <th class="touch4">PFS</th>
					                        <th class="touch4">P찍힘</th>
					                        <th class="touch4">P이물</th>
					                        <th class="touch4">P오염</th>
					                        <th class="touch4">도금박리</th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsPms" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsPfs" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsPstab" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsPaliensbst" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsPpolutn" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsGilt" min="0" ></td>
										</tr>
										<tr>
											<th class="touch4">F꺽임</th>
					                        <th class="touch4">F뭉침</th>
					                        <th class="touch4">F눌림</th>
					                        <th class="touch4">F뜯김</th>
					                        <th class="touch4">필름자국<br>(테프론)</th>
					                        <th class="touch4">마진편차</th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsFbreak" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsFagglomt" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsFpress" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsFtornout" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsTeflon" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsMargnDvat" min="0" ></td>
										</tr>
										<tr>
											<th class="touch4">총두께(M+F)</th>
					                        <th class="touch4">표면기포</th>
					                        <th class="touch4">엣지기포</th>
					                        <th class="touch4">메탈-Burr</th>
					                        <th class="touch4">R-Burr</th>
					                        <th class="touch4">치수</th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsThickness" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsSurfceBb" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsEdgeBb" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsMburr" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsRburr" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsSize" min="0" ></td>
										</tr>
										<tr>
											<th class="touch4">레이어</th>
					                        <th class="touch4">미진접</th>
					                        <th class="touch4">미부착</th>
					                        <th class="touch4">필름폭</th>
					                        <th class="touch4"></th>
					                        <th class="touch4"></th>
										</tr>
										<tr>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsLayer" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsUnjinjeop" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsUnattch" min="0" ></td>
											<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch5" id="dayPrcsFilmDepth" min="0" ></td>
											<td></td>
											<td></td>
										</tr>
										 -->
									</tbody>
								</table>
							</div>
						</div>
						</form>
						<!-- ----- 주간 공정불량 상세정보 끝-----  -->
						
						<!-- ----- 주간 원자재불량 상세정보 시작 ----- -->
						<form id="formDay2">
						<div id="dayMatrlFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="dMatrlTbody">
								<!--
								<tr>
									<input type="hidden" id="dayMatrlFaultySearchData">
									<th>MMB</th>
			                        <th>MMS</th>
			                        <th>M이물</th>
			                        <th>M휨</th>
			                        <th>M오염</th>
			                        <th>도금박리</th>
								</tr>
								<tr>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMmb" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMms" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMaliensbst" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMflex" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMpolutn" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlGilt" min="0" ></td>
								</tr>
								<tr>
									<th>찍힘</th>
			                        <th>권취</th>
			                        <th>얼룩</th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
								</tr>
								<tr>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlMstab" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlFagglomt" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch6" id="dayMatrlSpot" min="0" ></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th>&nbsp</th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
								</tr>
								<tr>
									<td>&nbsp</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								-->
								</tbody>							
							</table>
						</div>
						</form>
						<!-- ----- 주간 원자재불량 상세정보 끝 ----- -->
						
						<!-- ----- 주간 교체불량 상세정보 시작 ----- -->
						<form id="formDay3">
						<div id="dayReplaceFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="day3Tbody">
								<!-- 
								<tr>
									<input type="hidden" id="dayReplaceFaultySearchData">
									<th class="touch3">메탈교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch1">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcMetal1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcMetal2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcMetal3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcMetal4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcMetal5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">필름교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcFilm1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcFilm2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcFilm3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcFilm4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcFilm5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">실리콘교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcSilicon1" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcSilicon2" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcSilicon3" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcSilicon4" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcSilicon5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">메탈교테프론교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcTeflon1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcTeflon2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcTeflon3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcTeflon4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcTeflon5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">J/C</th>
			                        <th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcJc1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcJc2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcJc3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcJc4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayRpcJc5" min="0" ></td>
								</tr>
								 -->
								</tbody>
							</table>
						</div>
						</form>
						<!-- ----- 주간 교체불량 상세정보 끝 ----- -->
						
						<!-- ----- 주간 설비 트러블 불량 상세정보 시작 ----- -->
						<form id="formDay4">
						<div id="dayTroubleFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="day4Tbody">
								<!-- 
								<tr>
									<input type="hidden" id="dayTroubleFaultySearchData">
									<th class="touch3">서보(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbServo1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbServo2" min="0" ></td>
			                        <th class="touch3">융착부(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbFuse1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbFuse2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbServoContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbFuseContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">기어모터(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbGearmotor1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbGearmotor2" min="0" ></td>
			                        <th class="touch3">온도(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbTempatur1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbTempatur2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbGearmotorContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbTempaturContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">공압(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbPnumt1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbPnumt2" min="0" ></td>
			                        <th class="touch3">커팅부(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbCutting1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbCutting2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbPnumtContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbCuttingContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">센서(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbSensor1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbSensor2" min="0" ></td>
			                        <th class="touch3">실린더(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbCylinder1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbCylinder2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbSensorContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbCylinderContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">비전(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbVision1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbVision2" min="0" ></td>
			                        <th class="touch3">기타(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbEtc1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 day touch3" id="dayTrbEtc2" min="0" ></td>
								</tr>
								<tr>
									<th>내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbVisionContent" style="max-width:100%"></td>
			                        <th>내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control dayText day touch3" id="dayTrbEtcContent" style="max-width:100%"></td>
								</tr>
								 -->
								</tbody>
							</table>
						</div>
					</form>
				</div>
					<!-- ----- 주간 설비 트러블 불량 상세정보 끝 ----- -->

					<!-- 야간 입력&저장 버튼 -->
					<div id="NighttimeRange">
						<div class="card-body col-sm-12 p-2 d-none" id="cardNight">
							<button type="button" class="btn btn-primary float-left touch6" id="inputNight">야간 입력</button>
							<button type="button" class="btn btn-primary float-right night touch6" id="nightBtnSave">저장</button>
						</div>
						<!-- ----- 야간 공정불량 상세정보 시작 ----- -->
						<form id="formNight1">
						<div id="nightPrcssFaultyView" class="d-none">
							<div class="table-responsive">
								<table class="table table-bordered">
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<colgroup><col width="16%"></colgroup>
									<tbody id="nightTbody">
									<!-- 
									<tr>
										<input type="hidden" id="nightPrcssFaultySearchData">
										<th class="touch4">PMS</th>
				                        <th class="touch4">PFS</th>
				                        <th class="touch4">P찍힘</th>
				                        <th class="touch4">P이물</th>
				                        <th class="touch4">P오염</th>
				                        <th class="touch4">도금박리</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsPms" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsPfs" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsPstab" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsPaliensbst" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsPpolutn" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsGilt" min="0" ></td>
									</tr>
									<tr>
										<th class="touch4">F꺽임</th>
				                        <th class="touch4">F뭉침</th>
				                        <th class="touch4">F눌림</th>
				                        <th class="touch4">F뜯김</th>
				                        <th class="touch4">필름자국<br>(테프론)</th>
				                        <th class="touch4">마진편차</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsFbreak" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsFagglomt" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsFpress" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsFtornout" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsTeflon" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsMargnDvat" min="0" ></td>
									</tr>
																<tr>
										<th class="touch4">총두께(M+F)</th>
				                        <th class="touch4">표면기포</th>
				                        <th class="touch4">엣지기포</th>
				                        <th class="touch4">메탈-Burr</th>
				                        <th class="touch4">R-Burr</th>
				                        <th class="touch4">치수</th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsThickness" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsSurfceBb" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsEdgeBb" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsMburr" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsRburr" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsSize" min="0" ></td>
									</tr>
									<tr>
										<th class="touch4">레이어</th>
				                        <th class="touch4">미진접</th>
				                        <th class="touch4">미부착</th>
				                        <th class="touch4">필름폭</th>
				                        <th></th>
				                        <th></th>
									</tr>
									<tr>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsLayer" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsUnjinjeop" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsUnattch" min="0" ></td>
										<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch5" id="nightPrcsFilmDepth" min="0" ></td>
										<td></td>
										<td></td>
									</tr>
									</tbody>
									 -->
									</table>
								</div>
							</div>
						</form>
						<!-- ----- 야간 공정불량 상세정보 끝 ----- -->
						
						<!-- ----- 야간 원자재불량 상세정보 시작 ----- -->
						<form id="formNight2">
						<div id="nightMatrlFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="nMatrlTbody">
								<!-- 
								<tr>
									<input type="hidden" id="nightMatrlFaultySearchData">
									<th>MMB</th>
			                        <th>MMS</th>
			                        <th>M이물</th>
			                        <th>M휨</th>
			                        <th>M오염</th>
			                        <th>도금박리</th>
								</tr>
								<tr>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMmb" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMms" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMaliensbst" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMflex" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMpolutn" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlGilt" min="0" ></td>
								</tr>
								<tr>
									<th>찍힘</th>
			                        <th>권취</th>
			                        <th>얼룩</th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
								</tr>
								<tr>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlMstab" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlFagglomt" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch6" id="nightMatrlSpot" min="0" ></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<th>&nbsp</th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
			                        <th></th>
								</tr>
								<tr>
									<td>&nbsp</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								 -->
								</tbody>
							</table>
						</div>
						</form>
						<!-- ----- 야간 원자재불량 상세정보 끝 ----- -->
						
						<!-- ----- 야간 교체불량 상세정보 시작 ----- -->
						<form id="formNight3">
						<div id="nightReplaceFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="night3Tbody">
								<!-- 
								<tr>
									<input type="hidden" id="nightReplaceFaultySearchData">
									<th class="touch3">메탈교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcMetal1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcMetal2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcMetal3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcMetal4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcMetal5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">필름교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcFilm1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcFilm2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcFilm3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcFilm4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcFilm5" min="0" ></td>
								</tr>
								<tr>
									<th>실리콘교체</th>
			                        <th>1회</th>
			                        <th>2회</th>
			                        <th>3회</th>
			                        <th>4회</th>
			                        <th>5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcSilicon1" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcSilicon2" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcSilicon3" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcSilicon4" min="0" ></td>
									<td><input  maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcSilicon5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">메탈교테프론교체</th>
			                        <th class="touch3">1회</th>
			                        <th class="touch3">2회</th>
			                        <th class="touch3">3회</th>
			                        <th class="touch3">4회</th>
			                        <th class="touch3">5회</th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcTeflon1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcTeflon2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcTeflon3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcTeflon4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcTeflon5" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">J/C</th>
			                        <th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
									<th class="touch3"></th>
								</tr>
								<tr>
									<th class="touch3">KG</th>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcJc1" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcJc2" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcJc3" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcJc4" min="0" ></td>
									<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightRpcJc5" min="0" ></td>
								</tr>
								 -->
								</tbody>
							</table>
						</div>
						</form>
						<!-- ----- 야간 교체불량 상세정보 끝 ----- -->
						
						<!-- ----- 야간 설비 트러블 불량 상세정보 시작 ----- -->
						<form id="formNight4">
						<div id="nightTroubleFaultyView" class="d-none">
							<table class="table table-bordered">
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<colgroup><col width="16%"></colgroup>
								<tbody id="night4Tbody">
								<!-- 
								<tr>
									<input type="hidden" id="nightTroubleFaultySearchData">
									<th class="touch3">서보(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbServo1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbServo2" min="0" ></td>
			                        <th class="touch3">융착부(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbFuse1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbFuse2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbServoContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbFuseContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">기어모터(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbGearmotor1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbGearmotor2" min="0" ></td>
			                        <th class="touch3">온도(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbTempatur1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbTempatur2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbGearmotorContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbTempaturContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">공압(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbPnumt1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbPnumt2" min="0" ></td>
			                        <th class="touch3">커팅부(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbCutting1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbCutting2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbPnumtContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbCuttingContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">센서(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbSensor1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbSensor2" min="0" ></td>
			                        <th class="touch3">실린더(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbCylinder1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbCylinder2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbSensorContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbCylinderContent" style="max-width:100%"></td>
								</tr>
								<tr>
									<th class="touch3">비전(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbVision1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbVision2" min="0" ></td>
			                        <th class="touch3">기타(KG)</th>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbEtc1" min="0" ></td>
			                        <td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 night touch3" id="nightTrbEtc2" min="0" ></td>
								</tr>
								<tr>
									<th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbVisionContent" style="max-width:100%"></td>
			                        <th class="touch3">내용</th>
			                        <td colspan="2"><input maxlength="32" type="text" class="form-control nightText night touch3" id="nightTrbEtcContent" style="max-width:100%"></td>
								</tr>
								 -->
								</tbody>
							</table>
						</div>
						</form>
					</div>
					<!-- ----- 야간 설비 트러블 불량 상세정보 끝 ----- -->
				</div>
				<!-- 불량등록 입력 끝 -->
				
				<!-- 비가동사유 입력 시작 -->
				<div class="d-none" id="downtimeCard">
					<div class="table-responsive">
						<table class="table table-bordered text-center" id="downtimeDtl">
							<colgroup><col width="15%"></colgroup>
							<colgroup><col width="14%"></colgroup>
							<colgroup><col width="70%"></colgroup>		
							<thead class="thead-light">															
							<tr>										
								<th class="touch6">순번</th>
		                        <th class="touch6">체크</th>
		                        <th class="text-center touch6">사유</th>				                       
							</tr>
							</thead>	
						</table>
					</div>
				</div>
				<!-- 비가동사유 입력 끝 -->
				
				<!-- 비가동사유 입력 시작 new-->
				<div class="d-none" id="notRunningCard">
					<div class="table-responsive">
						<table class="table table-bordered text-center" id="notRunningTable">
							<thead class="thead-light">															
							<tr>										
								<th class="touch6">설비명</th>
								<th class="touch6">비가동<br>등록일</th>
								<th class="touch6">비가동<br>시작 시간</th>
								<th class="touch6">비가동<br>종료 시간</th>
								<th class="touch6">비가동<br>정지 시간</th>
								<th class="touch6">비가동 구분</th>
								<th class="touch6">비가동 사유</th>
								<th class="touch6">사유</th>
							</tr>
							</thead>	
						</table>
					</div>
				</div>
				<!-- 비가동사유 입력 끝 new-->
				
				
				<!-- 비전불량 현황 입력 시작 -->
				<div class="d-none" id="visionFaultyCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
					<table class="table table-bordered" id="visionFaultyCardTable" style="padding-left:0px; padding-right:0px;">
						<thead class="thead-light">
							<tr>
								<th class="text-center" style="min-width:50px;">순서</th>
								<th class="text-center" style="min-width:120px;">작지번호</th>
								<th class="text-center" style="min-width:100px;">주재료(LotNo)</th>
		                        <th class="text-center" style="min-width:65px;">비전불량 총 수량</th>
		                        <th class="text-center" style="min-width:120px;">생산 검사일</th>
		                        <th class="text-center" style="min-width:40px;">등록자</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="3" style="text-align: center">합계</td>
								<td colspan="" id="visionFaultySum" style="text-align:right;">0</td>
								<td colspan="2" style="text-align: center"></td>
							</tr>
						</tfoot>
					</table>
					<table class="table table-bordered float-left mr-1">
						<colgroup>
							<col width="22%">
							<col width="28%">
							<col width="22%">
							<col width="28%">
						</colgroup>
						<tr>
							<th class="touch6">생산 검사일자</th>
							<td><input type="date" maxlength="7" class="form-control touch6" id="visionFaultyOrdDate" disabled ></td>
							<th class="touch6">주간/야간</th>
							<td><select class="custom-select custom-select-lg touch6" id="visionFaultyDayNightCd" style="height:30px;" disabled></select></td>
						<tr>
							<th class="touch6">총 비전 불량수량</th>
							<td><input maxlength="7" type="text" class="form-control number text-right touch6" id="visionFaultySumyCnt" min="0" max="99999" disabled></td>
							<th class="touch6">등록일시</th>
							<td><input type="text" class="form-control text-left touch6" id="visionFaultyRegDate" disabled></td>
						</tr>		
						<tr>
						 	<th class="" id="badTotalName1">...</th>
							<td id="visionBadTotal1" style="text-align: right">0</td>
							<th class="" id="badTotalName2">...</th>
							<td id="visionBadTotal2" style="text-align: right">0</td>
						</tr>
					</table>
					<div class="card-body col-md-12 row p-2">
						<div class="col-md-6">
							<button type="button" class="btn btn-danger float-left mr-2 touch6" id="btnVisionFaultyDelete">삭제</button>
						</div>
						<div class="col-md-6">
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnVisionFaultySave" disabled>저장</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnVisionFaultyEdit">수정</button>
							<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnVisionFaultyAdd">등록</button>
						</div>
					</div>
					<hr>
					
					<!--비전불량 테이블 -->
					<div class="row col-sm-12">
						<div class="card-header card-tab col-md-12">
							<ul class="nav nav-tabs card-header-tabs">
								<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="visionFaultyTab1">...</a></li>
								<li class="nav-item"><a class="nav-link" data-toggle="tab" id="visionFaultyTab2">...</a></li>
							</ul>
						</div>
					</div>
					<br>
					<div id="visionUpFaultyDiv">
						<table class="table table-bordered exam">
							<colgroup>
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
							</colgroup>
							<tbody id="visionUpFaultyTbody">
								
							</tbody>
						</table>
					</div>
					<div id="visionDownFaultyDiv" class="d-none">
						<table class="table table-bordered exam">
							<colgroup>
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
								<col width="11%">
							</colgroup>
							<tbody id="visionDownFaultyTbody">
								
							</tbody>
						</table>
					</div>
				</div>
				<!-- 비전불량 현황 입력 끝 -->
				
				<!-- ---------------------------------------------------------------------------------- sideView 끝 ---------------------------------------------------------------------------------- -->
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->
<!-- 제조조건관리 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="equipCondCommonAdmModal" tabindex="-1" role="dialog" aria-labelledby="equipCondCommonAdmModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipCondCommonAdmPopUpLabel">제조조건 계획 정보</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="equipCondCommonAdmTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th style="min-width: 50px">설비명</th>
							<th style="min-width: 50px">제품명</th>
							<th style="min-width: 50px">규격</th>
							<th style="min-width: 50px">등록일</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 제조조건관리 모달 종료-->
<!-- 작업지시 추가 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="equipWorkOrdPlanListModal" tabindex="-1" role="dialog" aria-labelledby="equipCondCommonAdmModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="equipWorkOrdPlanListLabel">작업지시 추가</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary">
				<table id="equipWorkOrdPlanList" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th style="min-width:50px">제조조건코드</th>
							<th style="min-width:50px">제품명</th>
							<th style="min-width:50px">재질</th>
							<th style="min-width:50px">규격</th>
							<th style="min-width:50px">표면처리</th>
							<th style="min-width:50px">주야</th>
							<th style="min-width:50px">계획일</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnAddWorkOrderCheck" style="width:80px;" data-dismiss="modal">추가</button>
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 작업지시 추가 모달 종료-->
<!-- 미발행작지 삭제 모달 -->
<div class="modal fade" id="deleteWorkOrdCheckUnpublishedPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-modal="true" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deleteWorkOrdModalLabel">작업지시 삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제하시겠습니까?</h6>
				<p>*삭제로 발생하는 작업지시 번호 공백은 채워지지 않습니다!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnDeleteWorkOrdCheckUnpublished" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 미발행작지 삭제 모달 끝 -->
<!-- 작업지시 삭제 확인모달 시작-->
<div class="modal fade" id="deleteWorkOrdCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deleteWorkOrdModalLabel">작업지시 삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제하시겠습니까?</h6>
				<p>*삭제로 발생하는 작업지시 번호 공백은 채워지지 않습니다!</p>
				<h6>관리자&조장 확인</h6>
				아이디 :
				<div class="input-sub m-0">
					<input type="text" id="deleteCheckId" class="form-control touch6" disabled>
					<button type="button" class="btn btn-primary input-sub-search-md" id="searchUser" onClick="userAuthModal('001')">
							<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
						</button>
				</div>
				비밀번호 :
				<input type="password" id="deleteCheckPassword" class="form-control touch6" disabled>
				<!-- 담당자 : -->
				<!-- <div class="input-sub m-0 d-none">
					<input type="hidden" id="userNumber" name="edgeInspctCharger">
					<input type="text" class="form-control touch6" id="userNm" name="userNm" disabled>	
					button type="button" class="btn btn-primary input-sub-search-md" id="searchUser">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				 </div> -->
				
			</div>
			<div class="modal-footer">			
				<button type="button" class="btn btn-danger touch6" id="btnDeleteWorkOrdCheck" data-dismiss="modal" style="min-width: 70px;" disabled>삭제</button>
				<button type="button" class="btn btn-success touch6" id="btnDeleteCheck" style="min-width: 70px;">계정확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!--  작업지시 삭제 확인모달 끝 -->

<!-- 등록자변경 확인모달 시작-->
<div class="modal fade" id="changeRegistrantPopUp" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true" style="z-index:1049;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changeRegistrantLabel">등록자 변경 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>변경하시겠습니까?</h6>
				<h6>관리자&조장 확인</h6>
				아이디 :
				<div class="input-sub m-0 ">	
					<input type="text" id="changeRegistrantId" class="form-control touch6" disabled>
					<button type="button" class="btn btn-primary input-sub-search-md" id="changeRegistrantSearchAuthUser" onClick="userAuthModal('003')">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				</div>
				비밀번호 :
				<input type="password" id="changeRegistrantPassword" class="form-control touch6" disabled>
				변경할 등록자 : 
				<div class="input-sub m-0 ">
					<input type="hidden" id="changeRegistrantUserNumber" name="changeRegistrantUserNumber">
					<input type="text" class="form-control touch6" id="changeRegistrantUserNm" name="changeRegistrantUserNm" disabled>	
					<button type="button" class="btn btn-primary input-sub-search-md" id="changeRegistrantSearchUser">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				 </div>
				
			</div>
			<div class="modal-footer">			
				<button type="button" class="btn btn-danger touch6" id="bntchangeRegistrant" data-dismiss="modal" style="min-width: 70px;" disabled>등록자 변경</button>
				<button type="button" class="btn btn-success touch6" id="btnchangeRegistrantCheck" style="min-width: 70px;">계정확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!--  등록자변경 확인모달 끝 -->
<!-- 변경할등록자 변경담당 조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="changeRegistranUserListAllPopUp" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width: 1300px">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="changeRegistranUserAllLabel">변경 가능한 등록자 목록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="overflow: auto;">
				<hr class="text-secondary">
				<table id="changeRegistranUserAllTable" class="table table-bordered">
					<thead class="thead-light">
						<tr>
							<th style="min-width: 50px">담당자</th>
							<th style="min-width: 50px">부서명</th>
							<th style="min-width: 50px">직위</th>
							<th style="min-width: 50px">담당업무</th>
							<th style="min-width: 50px">근무조</th>
							<th style="min-width: 50px">사업장</th>
						</tr>
					</thead>
				</table>
				<hr class="text-secondary">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 변경할등록자 변경담당자 조회 모달 종료-->
<!-- 작지 종료 확인 모달 시작 -->
<div class="modal fade" id="workOrdEndCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCheckPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">작업지시 종료 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>종료하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="btnWorkOrdEndCheck" data-dismiss="modal" style="min-width: 70px;">종료</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnWorkOrdEndCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 작지 종료 확인 모달 끝 -->
<!-- 작지 취소 확인 모달 시작 -->
<div class="modal fade" id="workOrdCancelPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">작업지시 진행 취소 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>취소 하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnWorkOrdCancelCheck" data-dismiss="modal" style="min-width: 70px;">진행 취소</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnWorkOrdCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>

			</div>
		</div>
	</div>
</div>
<!-- 작지 취소 확인 모달 끝 -->
<!-- 작지 진행상태 변경 확인 모달 시작 -->
<div class="modal fade" id="workOrdReStartPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true" style = "z-index:1049;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">작업지시 진행 상태 변경 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>변경 하시겠습니까?</h6>
				<h6>관리자&조장 확인</h6>
				아이디 :
				<div class="input-sub m-0">
					<input type="text" id="deleteCheckWorkOrderUserId" class="form-control touch6" disabled>
					<button type="button" class="btn btn-primary input-sub-search-md" id="searchWorkOrderChangeUser" onClick="userAuthModal('002')">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				</div>
				비밀번호 :
				<input type="password" id="deleteCheckWorkOrderUserPassword" class="form-control touch6" disabled>
				<!-- 담당자 :-->
				<!-- <div class="input-sub m-0 d-none">
					<input type="hidden" id="workOrderChangeUserNumber" name="edgeInspctCharger">
					<input type="text" class="form-control touch6" id="workOrderChangeUserNm" name="userNm" disabled>	
					<button type="button" class="btn btn-primary input-sub-search-md" id="searchWorkOrderChangeUser">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				</div> -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnWorkOrdReStartCheck" data-dismiss="modal" style="min-width: 70px;" disabled>진행 상태로 변경</button>
				<button type="button" class="btn btn-success touch6" id="btnDeleteCheckWorkOrdRestart" style="min-width: 70px;">계정확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnWorkOrdCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>

			</div>
		</div>
	</div>
</div>
<!-- 작지 진행상태 변경 확인 모달 끝 -->
<!-- 생산실적 삭제 확인 모달 시작 -->
<div class="modal fade" id="deleteOutputSubPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">생산실적 삭제</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제 하시겠습니까?</h6>
				<p style="margin-bottom:0px;">*가장 최근 생산 전표번호만 삭제 하실 수 있습니다!</p>
				<p style="margin-bottom:0px;">*삭제시 선택한 생산전표번호에 대한 초물 또는 중물도 삭제됩니다!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnDeleteOutputSubCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적 삭제 확인 모달 끝 -->

<!-- 생산 비전불량 수량 삭제 확인 모달 시작 -->
<div class="modal fade" id="deleteVisionFaultyPopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">비전불량수량 삭제</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제 하시겠습니까?</h6>
				<!-- <p style="margin-bottom:0px;">*가장 최근 생산 전표번호만 삭제 하실 수 있습니다!</p> -->
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnDeleteVisionFaultyCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산 비전불량 수량 확인 모달 끝 -->

<!-- 초중물 삭제 확인 모달 시작 -->
<div class="modal fade" id="deleteStepPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteStep1PopupModalLabel" aria-hidden="true" style="z-index:99999">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제 하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="deleteStepCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 초중물 삭제 확인 모달 끝 -->
<!-- 투입자재 추가 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="matrlDtlTableModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="matrlDtlTableTitle" style="padding-left:10px;"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<table id="matrlDtlTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th class="text-center-th">자재코드</th>
									<th class="text-center-th">자재명</th>
									<th class="text-center-th">이니셜</th>
									<th class="text-center-th">재질</th>
									<th class="text-center-th">구분(연질/경질)</th>
									<th class="text-center-th">비고</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 투입자재 추가 모달 끝 -->
<!-- 작지 연결 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="connectWorkOrdNoModal" tabindex="-1" role="dialog" aria-labelledby="connectWorkOrdNoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:1500px;" style="padding-bottom: 0px;">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<button type="button" class="close" data-dismiss="modal" id="connectWorkOrdNoCheckModalClose" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<h5 class="modal-title" id="connectWorkOrdNoTableTitle" style="padding-left:10px;">연결대상 작업지시 목록</h5>
						<table id="connectWorkOrdNoTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="width: 60px">작지일</th>
									<th style="width: 130px">제품(기종)</th>
									<th style="width: 50px">재질</th>
									<th style="width: 150px">규격</th>
									<th style="width: 50px">표면처리</th>
									<th style="width: 100px">출고처</th>
									<th style="width: 115px">LOT NO</th>
									<th style="width: 105px">작지번호</th>
									<th style="width: 70px">상태</th>
									<th style="width: 40px">근무조</th>
									<th style="width: 60px">담당1</th>
									<th style="width: 60px">담당2</th>
								</tr>
							</thead>
						</table>
						<div class="row">
							<div class="sm-6">
								<h5 class="modal-title" id="connectWorkOrdNoTableTitle" style="padding-left:10px;">자재 투입내역</h5>
							</div>
							<div class="sm-6">
								<input type="text" class="form-control float-right touch6 ml-1" id="connectBarcodeNo">
								<label class="input-label-sm float-right touch6 ml-5">바코드</label>
							</div>
						</div>
						<table id="connectWorkOrdNoDtlTable" class="table table-bordered">
							<colgroup><col width="7%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="9%"></colgroup>
							<colgroup><col width="8%"></colgroup>
							<thead class="thead-light">
								<tr>
									<th class="text-center">재질</th>
									<th class="text-center">자재명</th>
									<th class="text-center">표면처리</th>
									<th class="text-center">LOT</th>
									<th class="text-center">투입중량</th>
									<th class="text-center">불량중량</th>
									<th class="text-center">바코드</th>
									<th class="text-center">투입일</th>
									<th class="text-center">상태</th>
									<th class="text-center">교체위치</th>
									<th class="text-center">연결 여부</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<p class="mr-a">*12시간 이내의 생산완료된 작업지시 목록이 최대 4개 표시됩니다.</p>
				<div class="row">
					<button type="button" class="btn btn-warning touch6 mr-2" data-dismiss="modal" id="btnWorkOrdConncetCheck" style="min-width:100px;" disabled>작지 연결</button>
				<button type="button" class="btn btn-secondary touch6" id="connectWorkOrdNoCheckColse" data-dismiss="modal" style="min-width:80px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 작지 연결 확인 모달 시작 -->
<div class="modal fadebd-example-modal-lg" id="connectWorkOrdNoCheckModal" tabindex="-1" role="dialog" aria-labelledby="connectWorkOrdNoCheckModalLabel" aria-hidden="false">
	<div class="modal-dialog" style="min-width:600px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">연결 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h5 id="connectWorkOrdNoCheckTitle"></h5>
				<h6 id="connectMainMatrlCheckTitle"></h6>
				<h6 id="connectSubMatrlCheckTitle"></h6>
				<p>*연결시 해당작지는 발행상태가 되며 선택한 작지의 자재가 연결로 등록됩니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning touch6" id="btnWorkOrdConnectRealFinalCheck" data-dismiss="modal" style="min-width: 70px;">작지 연결 확인</button>
				<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 모니터링 대상 설비 없음 경고 모달 시작 -->
<div class="modal fadebd-example-modal-lg" id="agtEquipListWarningModal" tabindex="-1" role="dialog" aria-labelledby="connectWorkOrdNoCheckModalLabel" aria-hidden="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">POP 모니터링 </h5>
				<button type=`"button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 style="color:red;">POP 모니터링 대상 설비가 없습니다!</h6>
				<p>*모니터링 대상설비 설정은 기본으로 사용자정보의 설비그룹, 가장 최근 진행중인 작지로 매칭되며, 추가 설정&삭제 시 해당 설정은 일회성이며 현재페이지를 벗어나면 다시 설정해야 합니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 모니터링 대상 설비 없음 경고 모달 끝 -->
<!-- POP 대상 설비 설정&확인 모달 시작 -->
<div class="modal fade bd-example-modal-lg" id="agtEquipListModal" tabindex="-1" role="dialog" aria-labelledby="connectWorkOrdNoModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:1500px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">POP 모니터링</h5>
				<button type="button" class="close" data-dismiss="modal"  id="" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-2">
						<h5 style="margin-bottom: 0px;">설비 목록</h5>
						<table id="agtEquipCdListTable" class="table table-bordered">
							<colgroup><col width="100%"></colgroup>
							<thead class="thead-light">
								<tr>
									<th class="text-center">설비명</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="col-10">
						<h5>모니터링 대상 설비 목록</h5>
						<div>
							<table id="localAgtEquipCdListTable" class="table table-bordered" style="margin-top: 6px;">
								<colgroup><col width="15%"></colgroup>
								<colgroup><col width="15%"></colgroup>
								<%-- <colgroup><col width="20%"></colgroup> --%>
								<colgroup><col width="20%"></colgroup>
								<colgroup><col width="15%"></colgroup>
								<%-- <colgroup><col width="15%"></colgroup> --%>
								<thead class="thead-light">
									<tr>
										<th class="text-center">설비명</th>
										<th class="text-center">제품</th>
										<!-- <th class="text-center">LOT NO</th> -->
										<th class="text-center">작지번호</th>
										<th class="text-center">상태</th>
										<!-- <th class="text-center">담당1</th> -->
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
						
						<textarea class="form-control text-left d-none" style="min-width:600px; height:800px; resize:none;" id="pMonitoringAlarm" disabled></textarea>
						
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<p class="mr-a">*추가&삭제는 해당설비 더블클릭! *모니터링 주기는 1분입니다.</p>
				<div class="row">
					<button type="button" class="btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width:80px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- POP 대상 설비 설정&확인 모달 끝 -->
<!-- 불량등록 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="faultyPopUpModal" tabindex="-1" role="dialog" aria-labelledby="faultyPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="min-width:1400px;">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="matrlFaultyModalLabel">불량 처리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body row">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				<div class="col-8">
					<table id="matrlFaultytable" class="table table-bordered" style="margin-bottom: 8px;">
						<colgroup><col width="12%"></colgroup>
						<colgroup><col width="18%"></colgroup>
						<colgroup><col width="7%"></colgroup>
						<colgroup><col width="18%"></colgroup>
						<colgroup><col width="18%"></colgroup>
						<colgroup><col width="9%"></colgroup>
						<colgroup><col width="9%"></colgroup>
						<colgroup><col width="9%"></colgroup>
						<thead class="thead-light">
							<!-- 
							<tr>
								<th colspan="4">바코드</th>
								<td colspan="4"><input type="text" class="form-control float-left touch6" id="faultyBarcodeNo" style="min-width:100%"></td>
							</tr>
							-->
							<tr>
								<th class="text-center">재질</th>
								<th class="text-center">자재명</th>
								<th class="text-center">표면처리</th>
								<th class="text-center">LOT</th>
								<th class="text-center">바코드</th>
								<th class="text-center">실사량</th>
								<th class="text-center">상태</th>
								<th class="text-center">승인여부</th>
							</tr>
						</thead>
					</table>
					<!-- <button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnFaultyMatrlDelete">라인삭제</button> -->
				</div>
				<div class="col-4">
					<table id="faultyPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
						<colgroup><col width="40%"></colgroup>
						<colgroup><col width="60%"></colgroup>
						<thead class="thead-light" style="margin-top: 0px;">
							<tr>
								<th>불량일</th>
								<td>
									<div class="form-group input- m-0 row">
										<input class="form-control" style="min-width:100%;" type="date" id="frrrdDate">
									</div>
								</td>
							</tr>
							<tr>
								<th>불량 비고</th>
								<td>
									<input type="text" id="frrrdDesc" style="max-width: 100%;" class="form-control" />
								</td>
							<tr>
							<th>불량 유형</th>
								<td>
								<c:forEach var="item" items="${matrlFaultyType}">
									<div class="row">
										<div class="col-6 text-center">${item.baseCdNm}</div>
										<div class="col-6 text-center"><input type="checkbox" id="frrrdType${item.baseCd}" style="zoom:1.8;"></div>	
									</div>
								</c:forEach>
								</td>
							</tr>
						</thead>
					</table>
				</div>
				<!-- <h6>불량 처리하시겠습니까?</h6> -->
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<p class="mr-a">*생산팀에서의 자재불량처리는 실투입 할 수 있는 자재들에 한해서만 가능합니다. 또한 불량처리한 자재는 자재팀에서 가출고처리를 하여야 투입할 수 있습니다.</p>
				<button type="button" class="btn btn-primary touch6" id="btnFrrrdSave" data-dismiss="modal" style="min-width: 70px;" disabled>불량 처리</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 불량등록 모달 종료 -->
<!-- 작업지시 인쇄 ordLotNo 선택 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="workOrdSubOrdLotNoModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:1200px;">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
				<h5 class="modal-title" id="workOrdNoTitle" style="padding-left:10px;"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<table class="table table-bordered" id="workOrdSubOrdLotNoTable" style="padding-left:0px; padding-right:0px;">
							<thead class="thead-light">
								<tr>
									<th rowspan="2" class="text-center" style="min-width:120px;">주자재 LotNo</th>
			                        <th rowspan="2" class="text-center" style="min-width:120px;">생산LotNo</th>
			                        <th rowspan="2" class="text-center" style="min-width:120px;">생산전표번호</th>
			                        <th rowspan="2" class="text-center" style="min-width:70px;">전표일자</th>
			                        <th colspan="2" class="text-center" style="min-width:65px;">생산</th>
			                        <th colspan="2" class="text-center" style="min-width:65px;">비전 검사량</th>
			                        <th colspan="2" class="text-center" style="min-width:65px;">총 합</th>
			                        <th rowspan="2" class="text-center" style="min-width:40px;">등록자</th>
			                        <th rowspan="2" class="text-center" style="min-width:50px;">상태</th>
								</tr>
								<tr>
									<th class="text-center" style="min-width:50px;">중량(KG)</th>
			                        <th class="text-center" style="min-width:50px;">수량(Ea)</th>
			                        <th class="text-center" style="min-width:50px;">중량(KG)</th>
			                        <th class="text-center" style="min-width:50px;">수량(Ea)</th>
			                        <th class="text-center" style="min-width:50px;">중량(KG)</th>
			                        <th class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px;">수량(Ea)</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center">합계</td>
									<td colspan="" id="excelSumOutputKg" style="text-align:right;">0</td>
									<td colspan="" id="excelSumOutputCnt" style="text-align:right;">0</td>
									<td colspan="" id="excelSumVisionKg" style="text-align:right; color:orange">0</td>
									<td colspan="" id="excelSumVisionCnt" style="text-align:right; color:orange">0</td>
									<td colspan="" id="excelTotalOutputKg" style="text-align:right;">0</td>
									<td colspan="" id="excelTotalOutputCnt" style="text-align:right;">0</td>
									<td colspan="2" style="text-align: center"></td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success touch6 btnRight" id="btnPrintCheck" data-dismiss="modal" style="min-width:100px;">인쇄(액셀 다운)</button>
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 작업지시 인쇄 ordLotNo 선택 모달 종료-->
<!-- 생산실적전표번호 초,중물 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="ordLotNoStepModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:800px;">
		<div class="modal-content" style="height: 90vh; overflow-y: scroll; overflow-x: hidden;">
			<div class="modal-header" style="padding:12px;">
				<h5 class="modal-title" id="ordLotNoStepTitle" style="padding-left:10px;"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<!-- 초,중물 입력 시작 -->
						<div id="equipSizeCondStepOrdLotNoCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
							<ul class="nav nav-tabs card-header-tabs m-0">
								<li class="nav-item"><a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">온도</a></li>
								<li class="nav-item"><a class="nav-link" id="tab2Nav" data-toggle="tab" href="#tab2">치수</a></li>
								<li class="nav-item ml-auto">
									<button type="button" class="btn btn-danger float-left mr-2 touch5" id="btnStepDelete">삭제</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepSave">저장</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepEdit">수정</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnFirstStepInsert" disabled>초물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnSecondStepInsert" disabled>중물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepReload">조회</button>
								</li>
							</ul>
							<div class="card-body p-0">
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade active show" id="tab1">
										<table class="table table-bordered">
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="12%"></colgroup>
											<colgroup><col width="40%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<tr>
												<th rowspan="3" class="touch3">위치</th>
						                        <th rowspan="3" class="touch3">시료</th>
						                        <th rowspan="3" class="touch3">조건</th>
						                        <th colspan="3" class="touch3">측정시간</th>
											</tr>
											<tr>
												<th class="touch3">초물</th>
						                        <th class="touch3">중물</th>
						                        <th class="touch3">종물</th>
											</tr>
											<tr>
												<td><input type="time" maxlength="5" class="form-control text-center touch3" id="firstRegTime" placeholder="HH:MM" disabled></td>
						                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="secondRegTime" placeholder="HH:MM" disabled></td>
						                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="thirdRegTime" placeholder="HH:MM" disabled></td>
											</tr>
											<tr>
												<th class="touch3">예열</th>
												<th class="touch3"></th>
												<th class="touch3"><span id="warmupCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWarmupCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWarmupCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWarmupCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">가접1</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="fitup1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="fitup1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">가접2</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="fitup2UpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2UpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="fitup2DownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2DownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="fitup2UprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2UprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="fitup2DownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFitup2DownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">롤히터</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="rollheatUpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatUpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatUpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdRollheatUpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="rollheatDownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatDownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatDownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdRollheatDownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">1차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="firstUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="firstDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="firstUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="firstDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFirstDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">1차 푸셔</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="push1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPush1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="push1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPush1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">2차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="secondUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="secondDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="secondUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="secondDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdSecondDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">3차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="thirdUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="thirdDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="thirdUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="thirdDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThirdDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">진접1</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="jinjeop1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="jinjeop1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">진접2</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="jinjeop2UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop2UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="jinjeop2DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdJinjeop2DownCond" disabled></td>
											</tr>
										</table>
									</div>
									<div class="tab-pane fade" id="tab2">
										<table class="table table-bordered">
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="12%"></colgroup>
											<colgroup><col width="40%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<colgroup><col width="10%"></colgroup>
											<tr>
												<th rowspan="3" class="touch3">위치</th>
						                        <th rowspan="3" class="touch3">시료</th>
						                        <th rowspan="3" class="touch3">조건</th>
						                        <th colspan="3" class="touch3">측정시간</th>
											</tr>
											<tr>
												<th class="touch3">초물</th>
						                        <th class="touch3">중물</th>
						                        <th class="touch3">종물</th>
											</tr>
											<tr>
												<td><input type="time" maxlength="5" class="form-control text-center touch3" id="firstRegTime" placeholder="HH:MM" disabled></td>
						                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="secondRegTime" placeholder="HH:MM" disabled></td>
						                        <td><input type="time" maxlength="5" class="form-control text-center touch3" id="thirdRegTime" placeholder="HH:MM" disabled></td>
											</tr>
											<tr>
												<input type="hidden" id="workOrdNo">
												<input type="hidden" id="equipCondSeq">
												<input type="hidden" id="firstStepSearch">
												<input type="hidden" id="secondStepSearch">
												<input type="hidden" id="thirdStepSearch">
												<th rowspan="2" class="touch3">Welding Part</th>
												<th class="touch3">(좌)</th>
												<th><span class="cond touch3" id="wpLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWpLeftAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span id="wpRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdWpRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">Pitch</th>
												<th class="touch3">(좌)</th>
												<th class="touch3"><span class="cond" id="pitchLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPitchLeftAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="pitchRightCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPitchRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">P.P Film 날개</th>
												<th class="touch3">(좌)</th>
												<th class="touch3"><span class="cond" id="ppfWingLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingLeftAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingLeftAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfWingLeftAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="ppfWingRightCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfWingRightAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th rowspan="2" class="touch3">P.P Film 폭</th>
												<th class="touch3">(좌)</th>
												<th><span class="cond" id="ppfDepthLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfDepthLeftAlwnce" disabled></td>
											</tr>
											<tr>                                                                                        
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="ppfDepthRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdPpfDepthRightAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th class="touch3">Film</th>
												<th class="touch3">총길이</th>
												<th class="touch3"><span class="cond" id="filmCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdFilmAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">METAL</th>
												<th class="touch3">폭</th>
												<th class="touch3"><span class="cond" id="metalDepthCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdMetalDepthAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">두께</th>
												<th class="touch3"><span class="cond" id="metalThicknessCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdMetalThicknessAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="3" class="touch3">총두께</th>
												<th class="touch3">Center</th>
												<th class="touch3"><span class="cond" id="thCenterCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThCenterAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th class="touch3">Edge</th>
												<th class="touch3"><span class="cond" id="thEdgeCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThEdgeAlwncePlus"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThEdgeAlwncePlus"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdThEdgeAlwncePlus" disabled></td>
											</tr>
											<tr>
												<th colspan="2" class="touch3">초물 중물 종물</th>
												
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstInput"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondInput"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdInput" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">Burr (MAX)</th>
												<th class="touch3">Metal</th>
												<th class="touch3"><span class="cond" id="burrCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrMetalAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrMetalAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrMetalAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">R-Cut</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrRcutAlwnce"disabled></td>
											</tr>
											<!-- <tr>
												<th class="touch3">R끝단</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBurrRedgeAlwnce" disabled></td>
											</tr> -->
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>좌상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftupHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftupWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>좌하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftdownHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeLeftdownWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>우상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightupHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightupWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>우하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightdownHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thridStep touch3" id="thirdBulgeRightdownWidth" disabled></td>
											</tr>
										</table>
									</div>
								</div>
							</div>
							<!-- <div class="table-responsive"> -->
						</div>
						<!-- 초,중물 입력 끝 -->
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적전표번호 초,중물 모달 끝-->
<!-- 1차 테프론 교체 모달 시작-->

<div class="modal fade" id="ptfe1PopupModal" tabindex="-1" role="dialog" aria-labelledby="ptfe1PopupModalLabel" aria-hidden="true" >
  <div class="modal-dialog" style="min-width:650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ptfe1PopupModalLabel">1차 진접 테프론 교체 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body">      	  	    	
	                 	
	            	<div class="card">                  
	                	<div class="table-responsive">
		                	<table id="ptfe1List" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr>
		                              <th style="min-width:100%;">일자</th> 
		                              <th style="min-width:100%;">주야구분</th>     
		                              <th style="min-width:100%;" class="text-center">횟수</th>                            
		                            </tr>
		                        </thead>
		                    </table>
		                </div>
		            </div>	
		        <!-- /.page-section -->	
				
	
     
		<table class="table table-bordered">
			<colgroup>
				<col width="50%">
				<col width="60%">				                     
				</colgroup>
				<tr>
				    <th>교체 일자</th>
				    <td class="text-center">
				    	<input type="datetime-local" id="ptfe1Date" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control touch6" style="min-width:100%; padding-right: 0px; padding-left:3px;" disabled>
				    </td>				 
				</tr>
				<tr>
				    <th>주야 구분</th>
				    <td class="text-center">
				    	<select class="custom-select custom-select-md" id="ptfe1DayNight" style="min-width:100%;" disabled>
				    		<option value="D">주간</option>
				    		<option value="N">야간</option>
				    	 </select>
				    </td>				 
				</tr>
				<!-- <tr>
				    <th>수량</th>
				    <td class="text-center">
				    	<input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 touch3" id="ptfe1Cnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr> -->
				<tr>
				    <th class='d-none'>테프론 선택</th>
				    <td class="text-center d-none">
				    	<select class="custom-select custom-select-md" style="min-width:100%;" id="selectTeflon1"></select>
				    </td>
				</tr>
				<tr>
				    <th>불량(KG)</th>
				    <td class="text-center">
				    	<input type="number" class="form-control number-float3 touch6" style="min-width:100%;" maxlength="6" min="0" max="1000" step="0.001" id="ptfe1Weight" value="0" disabled>
				    </td>
				</tr>				
	    </table>      	
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger mr-a touch6" id="ptfe1Delete" data-dismiss="modal" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn-primary touch6" id="ptfe1Add" data-dismiss="modal" style="min-width:70px;">등록</button>
      	<button type="button" class="btn btn-primary touch6" id="ptfe1Edit" data-dismiss="modal" style="min-width:70px;" disabled>수정</button>
      	<button type="button" class="btn btn-primary touch6" id="ptfe1Save" data-dismiss="modal" style="min-width:70px;" disabled>저장</button>
      	<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 1차 테프론 교체 모달 끝-->

<!-- 2차 테프론 교체 모달 시작-->
<div class="modal fade" id="ptfe2PopupModal" tabindex="-1" role="dialog" aria-labelledby="ptfe2PopupModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="min-width:650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="ptfe2PopupModalLabel">2차 진접 테프론 교체 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body">      	      
      	<div class="card">                  
	                	<div class="table-responsive">
		                	<table id="ptfe2List" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr>
		                              <th style="min-width:100%;">일자</th> 
		                              <th style="min-width:100%;">주야구분</th>     
		                              <th style="min-width:100%;" class="text-center">홧수</th>                            
		                            </tr>
		                        </thead>
		                    </table>
		                </div>
           </div>	
		<table class="table table-bordered">
			<colgroup>
				<col width="40%">
				<col width="60%">				                     
				</colgroup>
				<tr>
				    <th>교체 일자</th>
				    <td class="text-center">
				    	<input type="datetime-local" id="ptfe2Date" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control touch6" style="min-width:100%; padding-right: 0px; padding-left:3px;" disabled>
				    </td>				 
				</tr>
				<tr>
				    <th>주야 구분</th>
				    <td class="text-center">
				    	<select class="custom-select custom-select-md" id="ptfe2DayNight" style="min-width:100%;" disabled>				    	
				    		<option value="D">주간</option>
				    		<option value="N">야간</option>
				    	 </select>
				    </td>				 
				</tr>
				<!-- <tr>
				    <th>수량</th>
				    <td class="text-center">
				    	<input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 touch3" id="ptfe1Cnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr> -->
				<tr>
				    <th>불량(KG)</th>
				    <td class="text-center">
				    	<input type="number" class="form-control number-float3 touch6" style="min-width:100%;" maxlength="6" min="0" max="1000" step="0.001" id="ptfe2Weight" value="0" disabled>
				    </td>
				</tr>
	    </table>      	
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-danger mr-a touch6" id="ptfe2Delete" style="min-width:70px;">삭제</button>
      <button type="button" class="btn btn-primary touch6" id="ptfe2Add" data-dismiss="modal" style="min-width:70px;">등록</button>
      	<button type="button" class="btn btn-primary touch6" id="ptfe2Edit" data-dismiss="modal" style="min-width:70px;" disabled>수정</button>
      	<button type="button" class="btn btn-primary touch6"  id="ptfe2Save" data-dismiss="modal" style="min-width:70px;" disabled>저장</button>
      	<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 2차 테프론 교체 모달 끝-->

<!-- 1차 실리콘 교체 모달 시작-->
<div class="modal fade" id="sil1PopupModal" tabindex="-1" role="dialog" aria-labelledby="sil1PopupModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="min-width:650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="sil1PopupModalLabel">1차 진접 실리콘 교체 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body">      	  	    	
	                 	
	            	<div class="card">                  
	                	<div class="table-responsive">
		                	<table id="sil1List" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr>
		                              <th style="min-width:100%;">일자</th> 
		                              <th style="min-width:100%;">주야구분</th>     
		                              <th style="min-width:100%;" class="text-center">홧수</th>                            
		                            </tr>
		                        </thead>
		                    </table>
		                </div>
		            </div>	
		        <!-- /.page-section -->	
				
		<table class="table table-bordered">
			<colgroup>
				<col width="50%">
				<col width="60%">				                     
				</colgroup>
				<tr>
				    <th>교체 일자</th>
				    <td class="text-center">
				    	<input type="datetime-local" id="sil1Date" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control touch6" style="min-width:100%; padding-right: 0px; padding-left:3px;" disabled>
				    </td>				 
				</tr>
				<tr>
				    <th>주야 구분</th>
				    <td class="text-center">
				    	<select class="custom-select custom-select-md" id="sil1DayNight" style="min-width:100%;" disabled>				    	
				    		<option value="D">주간</option>
				    		<option value="N">야간</option>
				    	 </select>
				    </td>				 
				</tr>
				<!-- <tr>
				    <th>수량</th>
				    <td class="text-center">
				    	<input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 touch3" id="ptfe1Cnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr> -->
				<tr>
				    <th>불량(KG)</th>
				    <td class="text-center">
				    	<input type="number" class="form-control number-float3 touch6" style="min-width:100%;" maxlength="6" min="0" max="1000" step="0.001" id="sil1Weight" value="0" disabled>
				    </td>
				</tr>
	    </table>      	
      </div>
      <div class="modal-footer">
      	<button type="button" class="btn btn-danger mr-a touch6" id="sil1Delete" style="min-width:70px;">삭제</button>
      	<button type="button" class="btn btn-primary touch6" id="sil1Add" data-dismiss="modal" style="min-width:70px;">등록</button>
      	<button type="button" class="btn btn-primary touch6" id="sil1Edit" data-dismiss="modal" style="min-width:70px;" disabled>수정</button>
      	<button type="button" class="btn btn-primary touch6" id="sil1Save" data-dismiss="modal" style="min-width:70px;" disabled>저장</button>
      	<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 1차 실리콘 교체 모달 끝-->

<!-- 2차 실리콘 교체 모달 시작-->
<div class="modal fade" id="sil2PopupModal" tabindex="-1" role="dialog" aria-labelledby="sil2PopupModalLabel" aria-hidden="true">
  <div class="modal-dialog"  style="min-width:650px;">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="sil2PopupModalLabel">2차 진접 실리콘 교체 </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <br>
      <div class="modal-body">      	      
      	<div class="card">                  
	                	<div class="table-responsive">
		                	<table id="sil2List" class="table table-bordered" style="text-align:center">
		                        <thead class="thead-light">
			                        <tr>
		                              <th style="min-width:100%;">일자</th> 
		                              <th style="min-width:100%;">주야구분</th>     
		                              <th style="min-width:100%;" class="text-center">홧수</th>                            
		                            </tr>
		                        </thead>
		                    </table>
		                </div>
           </div>	
		<table class="table table-bordered">
			<colgroup>
				<col width="40%">
				<col width="60%">				                     
				</colgroup>
				<tr>
				    <th>교체 일자</th>
				    <td class="text-center">
				    	<input type="datetime-local" id="sil2Date" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control touch6" style="min-width:100%; padding-right: 0px; padding-left:3px;" disabled>
				    </td>				 
				</tr>
				<tr>
				    <th>주야 구분</th>
				    <td class="text-center">
				    	<select class="custom-select custom-select-md" id="sil2DayNight" style="min-width:100%;" disabled>				    	
				    		<option value="D">주간</option>
				    		<option value="N">야간</option>
				    	 </select>
				    </td>				 
				</tr>
				<!-- <tr>
				    <th>수량</th>
				    <td class="text-center">
				    	<input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 touch3" id="ptfe1Cnt" min="0" style="min-width:100%;" value="0">
				    </td>				 
				</tr> -->
				<tr>
				    <th>불량(KG)</th>
				    <td class="text-center">
				    	<input type="number" class="form-control number-float3 touch6" style="min-width:100%;" maxlength="6" min="0" max="1000" step="0.001" id="sil2Weight" value="0" disabled>
				    </td>
				</tr>
	    </table>      	
      </div>
      <div class="modal-footer">
		<button type="button" class="btn btn-danger mr-a touch6" id="sil2Delete" style="min-width:70px;">삭제</button>
		<button type="button" class="btn btn-primary touch6" id="sil2Add" data-dismiss="modal" style="min-width:70px;">등록</button>
      	<button type="button" class="btn btn-primary touch6" id="sil2Edit" data-dismiss="modal" style="min-width:70px;" disabled>수정</button>
      	<button type="button" class="btn btn-primary touch6" id="sil2Save" data-dismiss="modal" style="min-width:70px;" disabled>저장</button>
      	<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width:70px;">취소</button>
      </div>
    </div>
  </div>
</div>
<!-- 2차 실리콘 교체 모달 끝-->

<!-- 불량 취소 모달 -->
<div class="modal modal-alert fade" id="matrlFaultyCancelModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="matrlFaultyCancelModal" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 id="exampleModalAlertWarningLabel" class="modal-title">
					<i class="fa fa-bullhorn text-warning mr-1"></i> 불량등록 취소
				</h5>
			</div>
			<div class="modal-body">
				<br>			
				<p>
					선택한 자재를 정상상태로 변경하시겠습니까?
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnFaultyCancelSave">불량 취소 처리</button>
				<button class="btn btn-danger d-none" id="btnDeleteConfirmLoading" type="button" disabled="">
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Loading...
				</button>
				&nbsp;
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 불량 취소 모달 -->

<!-- 주자재 교체 모달-->
<div class="modal fade bs-example-modal-lg shadow-lg" id="metalChangeModal" tabindex="-1" role="dialog" aria-labelledby="metalChangeModalModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg" role="document" style="margin-top: 3%;">
        <div class="modal-content" style="width: 70%; margin-left: 20%; margin-top: 20%;">
            <div class="modal-header">
           		<h5 class="modal-title" id="metalChangeHeader">주자재 교체 확인</h5>
            </div>
            <div class="modal-body">
            	<br>
            	
            	<button type="button" class="btn btn-primary mb-2 touch6 d-none" style="position: absolute;right: 4%; bottom: 88%;" id="btnMetalChangEdit">수정</button>
            	
            	<table class="table table-sm table-bordered">
            		<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
							
			 		<thead>
			 			<tr>
			 				<th>교체 전(MetalLot)</th>
			 				<th>교체 후(MetalLot)</th>
			 			</tr>
			 		</thead>
			 		<tbody>
            			<tr> 
            				<td class=" text-center" id="beforeLotNo" style="font-size: 18px; font-weight: 100;"></td>
            				<td>
            					<input type="text" class="form-control touch6" style="font-size: 18px; font-weight: 100; margin-left: 10%; text-align: center;" id="afterLotNo" placeholder="바코드를 스캔해주세요.">
            				</td>
            			</tr>
            		</tbody>
			 	</table>
            	
            	<h6>기존 lotNo가 교체됩니다. 계속 진행하시겠습니까?</h6>
				<label>*교체 전(MetalLot)가 신규투입인 경우 다른 작지에 해당 MetalLot가 등록되어있으면 교체가 불가합니다.</label>
				<label>*교체 전(MetalLot)가 불량인 경우 교체가 불가합니다.</label>
				<label>*교체 전(MetalLot)가 포장되어있는 경우 교체가 불가합니다.</label>
				
		    </div>
            <div class="modal-footer" id="divSudel">
            	<button type="button" class="btn btn btn-primary touch6" style="width: 16%;" id="btnModelMetalChang">교체</button>
            	<button type="button" class="btn btn-secondary touch6" style="width: 16%;" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!--주자재 교체 모달 -->

<!-- 삭제처리 모달-->
<div class="modal fade bs-example-modal-lg shadow-lg" id="deleteReliabilityModal" tabindex="-1" role="dialog" aria-labelledby="deleteReliabilityModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg" role="document" style="overflow-y: max-height:85%;  margin-top: 3%;">
        <div class="modal-content" style="width: 60%; margin-left: 30%; margin-top: 20%;">
            <div class="modal-header">
           		<h5 class="modal-title" id="deleteReliabilityModalLabel">비가동 삭제 확인</h5>
            </div>
            <div class="modal-body">
            	<br>
		    	<h6>입력하던 정보가 있습니다. 계속 진행하시겠습니까?</h6>
		    	<p id="deleteReliabilityModalAfter"></p>
		    </div>
            <div class="modal-footer" id="divSudel">
            	<button type="button" class="btn btn btn-danger touch6" style="width: 16%;" id="btnModelDel">삭제</button>
            	<button type="button" class="btn btn-secondary touch6" style="width: 16%;" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!--//삭제처리 모달 -->

<!-- 비가동 시작 모달-->
<div class="modal fade bd-example-modal-lg" id="notRunningPopUpModal" tabindex="-1" role="dialog" aria-labelledby="notRunningPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog" id="notRunningModalDialog" style="margin-right: 82vh;">
		<div class="modal-content" id="notRunningModalContent" style="width: 78vh;">
			<div class="modal-header">
				<h5 class="modal-title" id="notRunningPopUpLabel">비가동 시작 사유</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 8px;">
				
				<div class="row">
				
					<div class="mr-3 d-none" id="equipDowntimeAdmTableDiv">
						<table class="table table-sm table-bordered" id="equipDowntimeAdmDataTable">
							<thead>
								<tr>
									<th>설비명</th>
									<th>비가동 등록일</th>
									<th>비가동 시작 시간</th>
									<th>비가동 종료 시간</th>
									<th>비가동 정지 시간</th>
								</tr>
							</thead>
						</table>
					</div>
				
					<div>
						<table id="notRunningPopUpTable" class="table table-bordered" style="margin-bottom: 8px;">
							<colgroup><col width="40%"></colgroup>
							<colgroup><col width="60%"></colgroup>
							<thead class="thead-light" style="margin-top: 0px;">
								<tr>
									<th class="touch6" id="notRunningDateLabel">비가동<br>시작 시간</th>
									<td>
										<div class="form-group m-0 row" style="width: 25vh;">
											<input type="datetime-local" class="form-control touch6" style="min-width:100%;" id="notRunning_startDate" name="notRunning_startDate">
											<input type="datetime-local" class="form-control touch6 d-none" style="min-width:100%;" id="notRunning_endDate" name="notRunning_endDate">
										</div>
									</td>
								</tr>
								<tr>
									<th class="touch6" id="notRunningDescLabel">사유</th>
									<td>
										<textarea class="form-control dayText day touch3" 
												style="max-width:100%; height:145px; padding-bottom: 0px; resize:none; font-size: 18px;"
												id="notRunningDesc" name="notRunningDesc" maxlength="60" placeholder="최대 글자 수 60자"></textarea>
									</td>
								</tr>
								<tr style="height: 15vh;">
									<th id="notRunningTypeLabel touch6">비가동 <br> 구분 선택</th>
									<td>
										<c:forEach var="item" items="${downtimeCd}">
											<div class="row mt-2">
												<div class="col-9 text-center"> <label class="touch6" for="notRunningType_${item.baseCd}">${item.baseCdNm}</label></div>
												<div class="col-3 text-center">
													<input type="radio" style="width:25px; height:25px" value="${item.baseCd}" id="notRunningType_${item.baseCd}" name="notRunningType">
												</div>	
											</div>
										</c:forEach>
									</td>
								</tr>
							</thead>
						</table>
					</div>
					
					<div class="ml-3" style="width: 32vh;">
						<label class="input-label-sm touch6">비가동 사유 선택</label>
						<div style="border: 1px solid #dee2e6;padding: 2px;width: 100%; padding-bottom: 3px;">
							<table class="">
								<thead>
									<tr id="selectNotRunningReason_tr">
										<th>불량 내역</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				<hr class="text-secondary" style="margin-top: 0px; margin-bottom: 0px;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnNotRunning_startSave" style="min-width: 70px;">시작</button>
				<button type="button" class="btn btn-primary touch6 d-none" id="btnNotRunning_endSave" style="min-width: 70px; color: #ffffff; background-color: #EC935E; border-color: #db6e2d;">종료</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnNotRunningCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 비가동 시작 모달 -->

<!-- 선입선출 변경 모달-->
<div class="modal fade bs-example-modal-lg shadow-lg" id="fifoCheckModal" tabindex="-1" role="dialog" aria-labelledby="fifoCheckModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog modal-lg" role="document" style="margin-top: 3%;">
        <div class="modal-content" style="width: 100%; margin-left: 0%; margin-top: 20%;">
            <div class="modal-header">
           		<h5 class="modal-title" id="fifoCheckHeader">선입선출 변경 확인</h5>
            </div>
            <div class="modal-body">
            	<div style="display: flex;flex-wrap: nowrap;">
            	<!-- 바코드 스캔 테이블 -->
	            	<table class="table table-sm table-bordered" style="width: 40%;margin-top: 6px;">
				 		<thead>
				 			<tr>
				 				<th>바코드 스캔</th>
				 			</tr>
				 		</thead>
				 		<tbody>
	            			<tr> 
	            				<td>
	            					<input type="text" class="form-control touch6" style="font-size: 18px; font-weight: 100; text-align: center;" id="fifoCheckBarcodeNo" placeholder="바코드를 스캔해주세요.">
	            				</td>
	            			</tr>
	            		</tbody>
				 	</table>
				 	
				 	<!-- 스캔으로 조회된 값 -->
				 	<table class="table table-sm table-bordered" style="width: 57vh;" id="fifoCheckTable">
	            		<colgroup>
							<col width="11%">
							<col width="13%">
							<col width="8%">
							<col width="8%">
							<col width="8%">
						</colgroup>
				 		<thead>
				 			<tr>
				 				<th>바코드</th>
				 				<th>자재</th>
				 				<th>출고일</th>
				 				<th>선입선출</th>
				 				<th>변경</th>
				 			</tr>
				 		</thead>
				 	</table>
            	</div>
            	
				<h6>선입선출 내역 조회</h6>
				
				<div style="display: flex;flex-direction: column;position: absolute;top: 80px;right: 260px;">
					<label>*권한이 있는 사용자만 선입선출 여부를 변경할 수 있습니다.</label>
					<label>*선출은 자재 바코드 투입 시 적용됩니다.</label>
				</div>
            	
            	<div style="display: flex;flex-wrap: nowrap;">
					<!-- 스캔으로 나온 내역 들 -->
					<table class="table table-sm table-bordered" style="width: 81vh;margin-left: -11px;" id="fifoCheckHistoryTable">
	            		<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="8%">
							<col width="8%">
						</colgroup>
				 		<thead>
				 			<tr>
				 				<th>바코드</th>
				 				<th>자재</th>
				 				<th>출고일</th>
				 				<th>선입선출</th>
				 			</tr>
				 		</thead>
				 	</table>
				</div>
				
				<div style="display: flex;flex-direction: column;position: absolute;bottom: 0px;left: 20px;">
					<label>*승인이면서  가출고(선입선출 적용)인 자재만 조회됩니다.</label>
					<label>*현재 스캔된 자재 이전 데이터만 조회됩니다.</label>
				</div>
				
		    </div>
		    <div class="mt-2 mb-2" style="border-bottom: 1px solid #e8e8ea;width: 84vh;margin-left: 6px;"></div>
            <div class="modal-footer" id="divSudel">
            	<button type="button" class="btn btn-secondary touch6" data-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<!-- 선입선출 변경 모달-->

<!-- 선입선출 변경 확인 모달 시작 -->
<div class="modal fade" id="fifoAuthorityCheckModal" tabindex="-1" role="dialog" aria-labelledby="fifoAuthorityCheckModalLabel" aria-hidden="true" style = "z-index:1050; background: #3a3a4330;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">선입선출 상태 변경 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>변경 하시겠습니까?</h6>
				<h6>관리자&조장 확인</h6>
				아이디 :
				<div class="input-sub m-0">
					<input type="text" id="fifoAuthorityCheckUserId" class="form-control touch6" disabled>
					<button type="button" class="btn btn-primary input-sub-search-md" id="searchWorkOrderChangeUser" onClick="userAuthModal('004')">
						<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
					</button>
				</div>
				비밀번호 :
				<input type="password" id="fifoAuthorityCheckUserPassword" class="form-control touch6" disabled>
				선입선출 :<br>
				<select class="custom-select custom-select-sm touch6" style="width:150px;" id="selectFifoCheck"></select>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnFifoChange" data-dismiss="modal" style="min-width: 70px;" disabled>선입선출 변경</button>
				<button type="button" class="btn btn-success touch6" id="btnFifoAuthorityCheck" style="min-width: 70px;">계정확인</button>
				<button type="button" class="btn btn btn-secondary touch6" id="btnFifoAuthorityCheckCancel" data-dismiss="modal" style="min-width: 70px;">닫기</button>

			</div>
		</div>
	</div>
</div>
<!-- 선입선출 변경 확인 모달 시작 -->


<!-- 생산실적(Tray) -->
<div class="modal fade bd-example-modal-lg" id="trayPopUpModal" tabindex="-1" role="dialog" aria-labelledby="trayPopUpModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<!-- <div class="modal-content" style="width: 190vh;margin-left: -52vh;"> -->
		<div class="modal-content" style="width: 1870px;position: absolute;left: 50%;transform: translate(-50%, -0%);">
			<div class="modal-header">
				<h5 class="modal-title" id="trayPopUpLabel">생산실적(Tray)</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<br>
			
			<div class="modal-body">
			
				<!-- 기본지정 값 -->
				<div class="row mb-2">
					<div class="row col-5">
						<h5>작지 번호: <span style="background-color: lightyellow;" id="trayWorkOrderNo"></span> </h5>
						<h5 class="ml-3">현 LotNo: <span style="background-color: lightyellow;" id="trayLotNo"></span></h5>
					</div>
					
					<div class="table-responsive col-7" style="display: flex;justify-content: flex-end;">
						<div class="mr-5" style="display: flex;flex-direction: column;">
							<button type="button" class="btn btn-primary touch6 mb-2" id="btnVisorIncorporationGubun" value="V">(비전)혼입구분 변경</button>
							<button type="button" class="btn btn-primary touch6 mb-2" id="btnIncorporationGubun" value="M">(메탈)혼입구분 변경</button>
						</div>
						<div class="mr-5" style="display: flex;flex-direction: column;">
							<button type="button" class="btn btn-danger touch6 mb-2" id="btnTrayDelete">삭제</button>
							<button type="button" class="btn btn-success touch6 mb-2" id="btnTrayReset" disabled>초기화</button>
						</div>
						<table class="table table-sm table-bordered" style="width: 65vh;">
							<tbody>
								<tr>
									<th>주야 구분</th>
									<td>
										<select class="custom-select custom-select-md touch6" id="trayDayNight" style="min-width:100%;">				    	
								    		<option value="D">주간</option>
								    		<option value="N">야간</option>
								    	 </select>
									</td>
									<th>생산 날짜</th>
									<td>
										<input type="date" min="1900-01-01" max="2100-12-31" class="form-control dayTime touch6" style="min-width:100%;" id="trayProductDate">
									</td>
									<th>작업자</th>
									<td>
										<input type="hidden" class="form-control" id="trayWorkerIdCd"  name="trayWorkerIdCd">
					                    <div class="input-sub m-0">
											<input type="text" class="form-control touch6" id="trayWorkerIdNm"  name="trayWorkerIdNm" readonly>
					                 	  	<button type="button" class="btn btn-primary input-sub-search" style="height: 30px;" id="btnSelectTrayWorkerId" onClick="selectPreWorkCharger('trayWorker')">
												<span class="oi oi-magnifying-glass" style="font-size: 20px;"></span>
									        </button>
								        </div>
									</td>
								</tr>
							</tbody>					
						</table>
					</div>
				</div>
				<!-- 기본지정 값 -->
				<hr>
				<!-- Tray 번호 20개 -->
				<div id="trayCard">
					<div id="trayButtonRange"></div>
				</div>
				
				<br>
				
				<!-- 트레이 작업 내역-->
				<div class="table-responsive">
					<table class="table table-sm table-bordered" style="font-size: 13px;text-align: center;" id="trayLabelTable">
						<thead>
							<tr>
								<th colspan="6" style="background-color: skyblue;font-size: 15px;" id="trayNumber">Tray Number</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<hr>
			</div>
			<div class="col-sm-12 modal-footer" style="flex-wrap: nowrap;">
				<div class="row col-6">
					<!-- <button type="button" class="btn btn-success touch6 mr-3" id="btnTrayAllRePrint">전체 재출력</button> -->
					<button type="button" class="btn btn-success touch6 mr-3" id="btnTrayPartRePrint">개별 재출력</button>
					<h5 class="ml-3">박스 번호: <span id="trayLabelLotNo" style="background-color: lightyellow;"></span></h5>
				</div>
				<div class="col-6" style="display: flex; justify-content: flex-end;">
					<button type="button" class="btn btn-danger touch6 d-none" id="btnTrayLabelDelete">삭제 저장</button>
					<button type="button" class="btn btn-primary touch6" id="trayLabelSave">저장</button>
					<button type="button" class="btn btn-secondary touch6 ml-2" id="trayPopUpModalCancel" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적(Tray)끝 -->

<!-- 생산실적(Tray)_혼입구분 -->
<div class="modal fade bd-example-modal-lg" id="trayIncorporationGubunPopUpModal" tabindex="-1" role="dialog" aria-labelledby="trayIncorporationGubunPopUpModal" aria-hidden="true" style="background-color: #0000003d;">
	<div class="modal-dialog modal-lg">
		<!-- <div class="modal-content" style="width: 190vh;margin-left: -52vh;"> -->
		<div class="modal-content" style="width: 1780px;position: absolute;left: 50%;transform: translate(-50%, -0%);">
			<div class="modal-header">
				<input type="hidden" id="minGubunValue">
				<h5 class="modal-title" id="trayIncorporationGubunPopUpLabel">생산실적(Tray)_혼입구분</h5>
				
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			
			<br>
			
			<div class="modal-body">
			
				<h5>혼입으로 변경하고자 하는 트레이 번호를 선택해주세요.</h5>
				<div class="mt-1 mb-3" style="display: flex;border: 1px solid black;width: 30vh;align-items: center;justify-content: center;flex-wrap: nowrap;">
						<div style="width: 30px;height: 30px;background-color: #ff8d8d;border-radius: 50px;" id="mixColor"></div>
						<h5 class="ml-2" style="line-height: 30px;">혼입</h5>
						<div class="ml-5" style="width: 30px;height: 30px;background-color: white;border-radius: 50px;border: 1px solid black;"></div>
						<h5 class="ml-2" style="line-height: 30px;">미 혼입</h5>
				</div>
				<!-- 혼입 구분 내역-->
				<div class="table-responsive">
					<table class="table table-sm table-bordered" style="font-size: 13px;text-align: center;" id="incorporationGubunTable">
						<thead>
							<tr>
								<th colspan="6" style="background-color: skyblue;font-size: 15px;" id="">Tray Number</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<!-- 혼입 구분 내역 끝-->
				<div id="trayIncorporationGubunGuideMessage">
					<label>*기존에 혼입이 저장되어있는 경우 붉은 색으로 표시 됩니다.</label>
					<br>
					<label>*기존에 비전혼입이 저장되어있는 경우 푸른 색으로 표시 됩니다.</label>
					<br>
					<label>*비전혼입이 저장되는 경우 "트레이 번호+_V"로 변경 됩니다.</label>
				</div>
			</div>
			<div class="modal-footer" style="flex-wrap: nowrap;">
				<button type="button" class="btn btn-primary touch6" id="trayIncorporationSave">저장</button>
				<button type="button" class="btn btn-secondary touch6 ml-2" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적(Tray)_혼입구분 끝 -->

<!-- 생산실적(Tray) 삭제 확인 모달 시작 -->
<div class="modal fade" id="trayDeleteCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="trayDeleteCheckPopupModalLabel" aria-hidden="true" style="background-color: #2a2a2a2f;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="">생산실적(Tray) 삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>삭제 하시겠습니까?</h6>
				<p style="margin-bottom:0px;">*삭제된 값은 복원할 수 없습니다.</p>
				<p style="margin-bottom:0px;">*포장된 값 삭제 시 출하검사&출하재검에 등로되어 있는 값도 같이 삭제 됩니다.</p>
				<p style="margin-bottom:0px;">*제품 입고&출고된 트레이는 삭제할 수 없습니다.</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnTrayDeleteCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적(Tray) 삭제 확인 모달 끝 -->

<%@include file="../layout/bottom.jsp"%>

<style>
	/*선택 안된 신규 트레이*/
	.on {
		border: 1px solid blue;
		background-color: white;
		color: black;
		height: 6vh;
		width: 18vh;
	}
	/*선택 된 트레이*/
	.off {
		border: 1px solid black;
		background-color: lightgray;
		color: black;
		height: 6vh;
		width: 18vh;
	}
	/*선택 된 트레이 삭제*/
	.trayBtnSlDelete {
		border: 1px solid black;
		background-color: red;
		color: white;
		height: 6vh;
		width: 18vh;
	}
	
	/*미완료 Tray&저장안된 트레이*/
	.imperfectTray {
		background-color: #f8cbad;
		color: black;
		height: 5vh;
    	font-size: 15px;
	}
	/*완료 Tray&저장된 트레이*/
	.perfectTray {
		background-color: darkgrey;
		color: black;
		height: 5vh;
    	font-size: 15px;
	}
	
	/*(메탈)혼입인  td 선택*/
	.mixMetalTd {
		height: 5vh;
		font-size: 15px;
	    background-color: #ff8d8d;
	    color: white;
	}
	/*(비전)혼입인 td 선택*/
	.mixVisorTd {
		height: 5vh;
		font-size: 15px;
	    background-color: #85b0ff;
	    color: white;
	}
	/*혼입이 아닌 td 선택*/
	.notMixTd {
		height: 5vh;
		font-size: 15px;
    	background-color: white;
    	color: black;
	}
	/*트레이 라인 tr 클릭시  */
	.clickedTrayLine{
		border: 5px solid #0275d8;
	
	}
</style>


<script>

	let menuAuth = 'posc0010';
	let currentHref = 'posc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","작업지시선택");
	uiProc(true);
	
	let matrlAddListWorkOrdNo = ''; // 투입자재목록 작지번호
	let matrlAddListGoodsCd = ''; // 투입자재목록 제품코드
	let matrlAddListGoodsNm = ''; // 투입자재목록 제품명

	//세션에서 가져와 menu변수에 넣었음.
	var menu = "<%=menu%>";
	var userNm = "<%=userNm%>";
	let trayUserNumber = "<%=userNumber%>";
	let trayUserNm = "<%=userNm%>";
	$('#showMenu').val(menu);
	if (menu == "yes"){
		$('#page-wrapper').addClass("page-wrapper");
		$(".page-title-bar").css('margin-top','0px');
		
	} else if (menu == "no"){
		$('#page-wrapper').removeClass("page-wrapper");
		$(".page-title-bar").css('margin-top','40px');
	}

	$('#equipCdScan').focus();

	//모니터링 일괄 on/off 기능 확인
	<% String popMonitoring = session.getAttribute("popMonitoring").toString(); %>
	var popMonitoring = "<%=popMonitoring%>";
	var monitoringOnOff = '';

	//모니터링 전체ON
	if (popMonitoring == 'yes') {
		monitoringOnOff = 'on';
		$('#btnMonitoringOnOff').text("모니터링 ON");
		$('#btnMonitoringOnOff').removeClass("btn-light");
		$('#btnMonitoringOnOff').addClass("btn-primary");
		$('#btnMonitoringOnOff').css("color","white");

	//모니터링 전체OFF	
	} else if (popMonitoring == 'no') {
		monitoringOnOff = 'off';
		$('#btnMonitoringOnOff').text("모니터링 OFF");
		$('#btnMonitoringOnOff').removeClass("btn-info");
		$('#btnMonitoringOnOff').addClass("btn-light");
		$('#btnMonitoringOnOff').css("color","black");
	}
	
	var equipNm = "";

	$('#showMenu').change(function() {
		var showMenu = $('#showMenu option:selected').val();
		$.ajax({
	           url: '<c:url value="po/showMenu"/>',
	           type: 'GET',
	           async: false,
	           data: {
	           	'menuAuth'	 	: 		menuAuth,
	           	'showMenu'		: 		function() { return showMenu; },
	           },
			success: function (res) {
				//let data = res.data;
				//if (res.result == 'ok') {
				//	barcodeData = data;
				//	$('#barcodeNo').val("");
				//	$('#workOrderMatrlTable').DataTable().row.add({}).draw(false);
				//	toastr.success("추가되었습니다.");
				//} else {
				//	toastr.error(res.message, '', {timeOut: 5000});
				//}
			},
			complete:function(){
				//$('#searchDay').val("true")
			}
		});
		
		location.reload();
    });
	
	//공통코드 처리 시작
	var downtimeCode = new Array(); // 비가동
    <c:forEach items="${downtimeCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		downtimeCode.push(json);
    </c:forEach>
    
	var workTeamCode = new Array(); // 설치장소
    <c:forEach items="${workTeamCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workTeamCode.push(json);
    </c:forEach>

	var equipGroupCode = new Array(); // 설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>

	var ordGubunCode = new Array(); // 주야구분
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>    

    var processFaulty = new Array(); //공정불량
    <c:forEach items="${processFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		processFaulty.push(json);
	</c:forEach>    

    var matrlFaulty = new Array(); //원자재불량
    <c:forEach items="${matrlFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaulty.push(json);
	</c:forEach>

    var replaceFaultyCode = new Array(); //교체불량
    <c:forEach items="${replaceFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		replaceFaultyCode.push(json);
	</c:forEach>

    var troubleFaultyCode = new Array(); //설비트러블 
	<c:forEach items="${troubleFaulty}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		troubleFaultyCode.push(json);
	</c:forEach>

    var matrlFaultyType = new Array(); //설비트러블 
	<c:forEach items="${matrlFaultyType}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFaultyType.push(json);
	</c:forEach>

    var visionFaultyMajorCode = new Array(); //생산 비전불량 대분류
    <c:forEach items="${visionFaultyMajorCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		visionFaultyMajorCode.push(json);
    </c:forEach>

    var visionFaultyMinorCode = new Array(); //생산 비전불량 소분류
    <c:forEach items="${visionFaultyMinorCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		visionFaultyMinorCode.push(json);
    </c:forEach>

    var matrlFifoCheck=new Array();	//선입선출
    <c:forEach items="${matrlFifoCheck}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		matrlFifoCheck.push(json);
    </c:forEach>
    //공통코드 처리 종료
	
	var equipCd = null;		//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)
    var equipGroup = "<%=session.getAttribute("popEquipGroupCd") %>";
	if( equipGroup == 'null' || equipGroup == ""){
		equipGroup = null;
	}

	$('#visionFaultyTab1').text(visionFaultyMajorCode[0].baseCdNm);
	$('#visionFaultyTab2').text(visionFaultyMajorCode[1].baseCdNm);
	$('#badTotalName1').text(visionFaultyMajorCode[0].baseCdNm);
	$('#badTotalName2').text(visionFaultyMajorCode[1].baseCdNm);
	visionUpFaultyHdCreate();
	visionDownFaultyHdCreate();
	

	var processFaultyNm =  "${processFaultyNm}";
	var matrlFaultyNm =  "${matrlFaultyNm}";
	var replaceFaultyNm =  "${replaceFaultyNm}";
	var troubleFaultyNm =  "${troubleFaultyNm}";
	
    var ordDateCal =  "${serverDate}";
    var sToday =  "${serverDate}";
    var yesterday =  "${yesterday}";
	var ordGubunCd = null;
	var equipCondSeq = null;
	var sideView = null;		//오른쪽 View
	var mainView = "workOrder";	//가운데 View
	var workOrdSeq = null;
	var subWorkStatusCd = null;
	var outputBtnStat = 'add';
	var mainMatrlLotNo = null;			//rightButton 클릭 예외처리 시 or 주자재 데이터 보낼때 사용
	var mainMatrlCd = null;			//rightButton 클릭 예외처리 시 or 주자재 데이터 보낼때 사용

	let = searchEquipCd = '';

	equipCd = "empty";
 	workOrdNo = "empty";
	
	$('#faultyRegDate').val(sToday);
	$('#frrrdDate').val("${serverDate}");

	var agtEquipList = new Array(); //모니터링 대상 설비리스트
	//if (equipGroup != null && equipGroup != '') {
		$.ajax({
			url: '<c:url value="bm/monitoringEquipCodeList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'	 	: 		menuAuth,
				//'equipGroup'	: 		'popMonitoring',
				//'equipGroup'	: 		function() {return equipGroup;},
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if (data.length == 0 && monitoringOnOff == 'on') {
						//POP 모니터링 대상이 없다고 팝업 띄워주기
						//$('#agtEquipListWarningModal').modal({backdrop: 'static'});
						//$('#agtEquipListWarningModal').modal('show');
					} else {
						for (var i=0; i<data.length; i++){
							var json=new Object();
							json.equipCd = data[i].equipCd;
							json.equipNm = data[i].equipNm;
							json.goodsNm = '-';
							json.ordLotNo = '-';
							json.workOrdNo = '-';
							json.ordGubun = '-';
							json.statusNm = '-';
							json.mainWorkChargrNm= '-';
							agtEquipList.push(json);
						}
					}
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				
			}
		});
	//} else {
		//POP 모니터링 대상이 없다고 팝업 띄워주기
		//$('#agtEquipListWarningModal').modal({backdrop: 'static'});
		//$('#agtEquipListWarningModal').modal('show');
	//}

	$.fn.dataTable.ext.errMode = 'none';
	var agtEquipCdListTable = $('#agtEquipCdListTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
        dom: "<'row'<''l>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'		:	menuAuth,
            },
        },
		columns: [
			{ data: 'equipNm' },
		],
		columnDefs: [
			{ targets: [0], className: 'text-center' },
		],
		order: [
			[ 0, 'asc' ],
		],
	    drawCallback: function( settings ) {
	    	$('#agtEquipCdListTable_previous').html('');
			$('#agtEquipCdListTable_next').html('');
	    	$('#agtEquipCdListTable tbody tr td').css('height','47px');
	    }
    });
	
    //POP 모니터링 btn 클릭
	$('#btnMonitoring').on('click', function() {
		$('#agtEquipCdListTable').DataTable().ajax.reload( function () {});
		
		$('#localAgtEquipCdListTable > tbody').empty();	//초기화
		for (let i=0; i<agtEquipList.length; i++) {
			let html = "<tr id=agt" + agtEquipList[i].equipNm + " style='height:55px;'>";
				html += "<td class='text-center'>" + agtEquipList[i].equipNm + "</td>";
				html += "<td class='text-center'>" + agtEquipList[i].goodsNm + "</td>";
				if (agtEquipList[i].ordGubun == 'D') {
					/* html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>"; */
					html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
				} else if (agtEquipList[i].ordGubun == 'N') {
					/* html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>"; */
					html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
				} else {
					/* html += "<td class='text-center'>" + agtEquipList[i].ordLotNo + "</td>"; */
					html += "<td class='text-center'>" + agtEquipList[i].workOrdNo + "</td>";
				}
				html += "<td class='text-center'>" + agtEquipList[i].statusNm + "</td>";
				//html += "<td class='text-center'>" + agtEquipList[i].mainWorkChargrNm + "</td>";
				html += "</tr>" 
			$('#localAgtEquipCdListTable').append(html);
		}
		$('#agtEquipCdListTable_length').html('');
		$('#agtEquipListModal').modal({backdrop: 'static'});
		$('#agtEquipListModal').modal('show');
	});
	
    //모니터링 대상목록 추가 시
    $('#agtEquipCdListTable tbody').on('dblclick', 'tr', function() {
		var agtEquipCd = agtEquipCdListTable.row(this).data().equipCd;
		var agtEquipNm = agtEquipCdListTable.row(this).data().equipNm;

		if ($("#localAgtEquipCdListTable > tbody > tr").length >= 5) {
			toastr.warning("모니터링 가능 최대설비는 5개입니다!");
			return false;
		
		//더블클릭 설비가 대상 설비목록에 있으면
		} else if ($("#agt" + agtEquipNm).length > 0) {
			toastr.warning("이미 추가된 설비목록입니다.");
			return false;
		
		//더블클릭 설비가 대상 설비목록에 없으면
		} else {
			var json=new Object();
			json.equipCd = agtEquipCd;
			json.equipNm = agtEquipNm;
			json.goodsNm = '-';
			json.ordLotNo = '-';
			json.workOrdNo = '-';
			json.statusNm = '-';
			json.mainWorkChargrNm= '-';
			agtEquipList.push(json);

			let html = "<tr id=agt" + agtEquipNm + " style='height:55px;'>";
				html += "<td class='text-center'>" + agtEquipNm + "</td>";
				/* html += "<td class='text-center'>-</td>"; */
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
				//html += "<td class='text-center'>-</td>";
				html += "</tr>" 
			$('#localAgtEquipCdListTable').append(html);
			toastr.success(agtEquipNm + "설비 추가되었습니다.");
		}
    });

    //모니터링 대상목록 삭제시
    $('#localAgtEquipCdListTable tbody').on('dblclick', 'tr', function() {
        //삭제할 설비명
		var deleteEquipNm = $(this).attr('id').substring(3,($(this).attr('id').length));
		var index = -1;
		
        //배열에 저장된 위치를 알아냄
		for (var i=0; i<agtEquipList.length; i++) {
			if (deleteEquipNm == agtEquipList[i].equipNm) {
				index = i;
			}
		}
		
		if (index == -1) {
			toastr.warning("모니터링 대상 삭제 오류");	
		} else {
			agtEquipList.splice(index, 1);		//해당위치 설비 삭제
			$('#agt' + deleteEquipNm).remove()	//대상 설비목록 표에서 삭제
			toastr.success(deleteEquipNm + "설비 삭제되었습니다.");
		}
    });
	
	$.fn.dataTable.ext.errMode = 'none';
	let equipCodeAdmTable = $('#equipCodeAdmTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		}).DataTable({
        dom: "<'row'<''l>>" +
		"<'row'<'col-sm-12'tr>>" +
		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",
        language: lang_kor,
        paging: true,
        info: false,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'		:	menuAuth,
            	'equipGroup'	:	function() { return equipGroup; 	},
            	'equipCd'		:	function() { return searchEquipCd;	}
            },
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'equipNm' },
		],
		order: [
			[ 0, 'asc' ],
		],
	    drawCallback: function( settings ) {
			$('#equipCodeAdmTable_previous').html('');
			$('#equipCodeAdmTable_next').html('');
			$('#equipCodeAdmTable tbody tr td').css('height','52px');
	    }
    });

	/*$('#equipCodeAdmTable_filter').eq(0).find('input[type=search]').attr('id', 'equipCdScan');
	$("#equipCdScan").insertAfter("#equipScanDiv");
	$("#equipCdScan").removeClass();
	$("#equipCdScan").addClass("form-control touch6");
	$("#equipCdScan").attr('style', 'max-width: 100%;');
	$("#equipCdScan").attr('placeholder', '설비명을 스캔해주세요.');
	$('#equipCodeAdmTable_filter').eq(0).find('label').remove();*/

	//설비명 검색
	function equipScanFunction(receive){
		let text = receive.value.trim();
		/*searchEquipCd = text;
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});*/

		var pageLength = equipCodeAdmTable.page.info().pages;

		var serchRowNumber = equipCodeAdmTable.data().toArray().findIndex(d => d.equipCd == text);

		if(serchRowNumber == -1){
			if(text != ''){
				toastr.warning('유호하지않은 설비호기입니다.', '', {timeOut: 5000});
				$('#equipCdScan').focus();
				return false;
			}
		}

		//pageLength => 11
		var pageInfo = parseInt(serchRowNumber/11);

		$("#equipCodeAdmTable tbody tr").removeClass('selected');

		equipCodeAdmTable.page(pageInfo).draw(false);
		$(equipCodeAdmTable.row(equipCodeAdmTable.data().toArray().findIndex(d => d.equipCd == text)).node()).click();
	}

	//생산실적상세 테이블
    let outputCardTable = $('#outputCardTable').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/po/outputCntDataList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		: 	menuAuth,
			    'workOrdNo'		:	function() { return workOrdNo; },
			    'lotNo'			:	function() { return mainMatrlLotNo; },
			},
	    },
	    rowId: '',
		columns: [
			{ data: 'workOrdSeq' },
			{ data: 'workOrdDate',
				render: function(data, type, row) {
					if(data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
				}
			},
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'outputWeight',
		   		render: function(data, type, row) {
		   			return parseFloat(data).toFixed(3);
		   		}
            },
			{ data: 'outputCnt' },
			{ data: 'visionEdgeWeight',
		   		render: function(data, type, row) {
		   			return '<p style="color:orange;margin-bottom: 0px;">' + parseFloat(data).toFixed(3) + '</p>';
		   		}
            },
            { data: 'visionEdgeCnt',
		   		render: function(data, type, row) {
		   			return '<p style="color:orange;margin-bottom: 0px;">' + addCommas(data) + '</p>';
		   		}
            },
			//{ data: 'regDate',
			//	render: function(data, type, row) {					
			//		return moment(data).format("YYYY-MM-DD HH:mm:ss");
			//	}
			//},
			{ data: 'gubunNm',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'userNm' },
			{ data: 'subWorkStatusNm' },
		],
	    columnDefs: [
	    	{ targets: [0,1,2,7,8,9], className: 'text-center' },
	    	{ targets: [3,4,5,6], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [3,4,5,6], className: 'text-right sum' },
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
			$('#outputCardTable').parent().css('padding-left','0px');
			$('#outputCardTable').parent().css('padding-right','0px');
			if($('#outputCardTable').DataTable().data().count() > 0) {
				var outputKg = 0;
				var outputEa = 0;
				var visionKg = 0;
				var visionEa = 0;
				$('#outputCardTable tbody tr').each(function(){
					outputKg += parseFloat(parseFloat($(this).find('td').eq(3).text().replace(/,/g,"")).toFixed(3));
					outputEa += parseInt($(this).find('td').eq(4).text().replace(/,/g,""));
					visionKg += parseFloat(parseFloat($(this).find('td').eq(5).text().replace(/,/g,"")).toFixed(5));
					visionEa += parseInt($(this).find('td').eq(6).text().replace(/,/g,""));
				});
				totalKg = outputKg + visionKg;
				totalEa = outputEa + visionEa;
				
				var lineAdd = '';
				lineAdd += '<tr>';
				lineAdd += '<td colspan="3" class="text-center">합계</td>';
				lineAdd += '<td class="text-right">' + addCommas(parseFloat(outputKg).toFixed(3)) + '</td>';
				lineAdd += '<td class="text-right">' + addCommas(outputEa) + '</td>';
				lineAdd += '<td class="text-right" style="color:orange">' + addCommas(parseFloat(visionKg).toFixed(3)) + '</td>';
				lineAdd += '<td class="text-right" style="color:orange">' + addCommas(visionEa) + '</td>';
				lineAdd += '<td class="text-center">총 합계</td>';
				lineAdd += '<td class="text-right">' + parseFloat(totalKg).toFixed(3) + '</td>';
				lineAdd += '<td class="text-right">' + addCommas(totalEa) + '</td>';
				lineAdd += '</tr>';
				$('#outputCardTable').append(lineAdd);
			}
		},
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
	});

    var subOrdLotNo = null;
    var outputCardTableIndex = null;
    let productionperformanceRegDate;
	$('#outputCardTable tbody').on('click', 'tr', function () {
        if ($(this).find('td').eq(0).text() == '합계') {
			return false;
        }
        if ($(this).find('td').eq(0).text() == "데이터가 없습니다.") {
			return false;
        }

        var outputGubun = null;
        var outputRegDate = null;
		var outputWorkOrdDate = null;
		var outputWeight = null;
		var outputCnt = null;
		var visionEdgeWeight = null;
		var visionEdgeCnt = null;
		
        if ($(this).hasClass('selected')) {
           
        } else {
			$('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			outputCardTableIndex = $('#outputCardTable').DataTable().row(this).index();
			//outputCardTableIndex = outputCardTable.DataTable().row(this).index();
			workOrdSeq = outputCardTable.row(this).data().workOrdSeq;
			ordLotNo = outputCardTable.row(this).data().ordLotNo;
			subWorkStatusCd = outputCardTable.row(this).data().subWorkStatusCd;
			outputGubun = outputCardTable.row(this).data().gubun;
			outputRegDate = outputCardTable.row(this).data().regDate;
			outputWorkOrdDate = outputCardTable.row(this).data().workOrdDate;
			outputWeight = outputCardTable.row(this).data().outputWeight;
			outputCnt = outputCardTable.row(this).data().outputCnt;
			visionEdgeWeight = outputCardTable.row(this).data().visionEdgeWeight;
			visionEdgeCnt = outputCardTable.row(this).data().visionEdgeCnt;
			subOrdLotNo = outputCardTable.row(this).data().ordLotNo;
			productionperformanceRegDate = outputCardTable.row(this).data().regDate;
			if (outputCardTableIndex == 0) {
				ordLotNoStepCd = '001';
				$('#btnOrdLotNoFristStep').removeClass('d-none');
				$('#btnOrdLotNoSecondStep').addClass('d-none');
			} else if (outputCardTableIndex == 1) {
				ordLotNoStepCd = '002';
				$('#btnOrdLotNoFristStep').addClass('d-none');
				$('#btnOrdLotNoSecondStep').removeClass('d-none');
			} else {
				$('#btnOrdLotNoFristStep').addClass('d-none');
				$('#btnOrdLotNoSecondStep').addClass('d-none');
			}
			$('#gubun').val(outputGubun);
			$('#workOrdDate').val(moment(outputWorkOrdDate).format("YYYY-MM-DD"));
			$('#workOrdRegDate').val(moment(outputRegDate).format("YYYY-MM-DD HH:mm:ss"));
			$('#firstWeight').val(outputWeight);
			$('#firstCount').val(outputCnt);
			$('#visionEdgeWeight').val(visionEdgeWeight);
			$('#visionEdgeCnt').val(visionEdgeCnt);
        }
        
        outputBtnStat = 'edit';
        $('#btnOutputSave').attr('disabled',true);
    	$('#gubun').attr('disabled',true);
    	$('#firstWeight').attr('disabled',true);
    	$('#visionEdgeWeight').attr('disabled',true);
    	$('#workOrdDate').attr('disabled',true);
    	

		
    	//이거 왜하는지 몰라서 지움
        //if(workOrdSeq != null) {
	    //    $.ajax({
	    //        url: '<c:url value="po/outputCntDataRead"/>',
	    //        type: 'GET',
	    //        async: false,
	    //        data: {
	    //        	'menuAuth'	 	: 	menuAuth,
	    //        	'workOrdNo'		: 	function() { return workOrdNo; },
	    //        	'lotNo'			:	function() { return mainMatrlLotNo; },
	    //        	'workOrdSeq'	: 	function() { return workOrdSeq; },
	    //        },
		//		success: function (res) {
		//			let data = res.data;
		//			if (res.result == 'ok') {
		//				$('#gubun').val(data.gubun);
		//				$('#workOrdDate').val(moment(data.workOrdDate).format("YYYY-MM-DD"));
		//				$('#workOrdRegDate').val(moment(data.regDate).format("YYYY-MM-DD HH:mm:ss"));
		//				$('#firstWeight').val(data.outputWeight);
		//				$('#firstCount').val(data.outputCnt);
		//				$('#visionEdgeWeight').val(data.visionEdgeWeight);
		//				$('#visionEdgeCnt').val(data.visionEdgeCnt);
		//			} else {
		//				toastr.error(res.message, '', {timeOut: 5000});
		//			}
		//		},
		//		complete:function(){
		//			//$('#searchDay').val("true")
		//		}
		//	});
        //}
    });
    
	//var html1 =  '&nbsp;<label class="input-label-sm touch6">설비그룹</label><select class="custom-select custom-select-lg" id="equipGroupCd" ></select>';
	var html1 =  '';
	$('#equipCodeAdmTable_length').html(html1)
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	$('#workOrderTable').DataTable().clear().draw();
	 	$('#workOrderMatrlTable').DataTable().clear().draw();
	 	matrlIndex = "";
	 	matrlRowCnt = "";
	 	equipCd = null;
	 	workOrdNo = null;
	 	workStatusCd = null;
	 	uiProc(true);
	});
	
	$('#equipCodeAdmTable tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
			//$(this).removeClass('selected');
			//equipNm = "";
		} else {
			$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			//$('#btnWorkOrdConnect').addClass('d-none');
			equipNm = equipCodeAdmTable.row(this).data().equipNm;
		}
		
		ordDateCal =  $('#ordDate').val();
		//mainView 작업지시 컨트롤	
		if (mainView == "workOrder") {
			uiProc(true);
			$('#matrlCdText').val("");
			equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			ordGubunCd =  $('#ordGubunCd option:selected').val();
			$('#workOrderTable').DataTable().ajax.reload( function () {}); 
			$('#workOrderMatrlTable').DataTable().clear().draw(); 
			matrlIndex = ""; 
			matrlRowCnt = "";
			workOrdNo = null;
			btnFirstStep = false;
			btnSecondStep = false;
			$('#showMenu').removeClass("d-none");
			$('#btnMatrlList').attr('disabled',true); // 투입자재목록 버튼
		
		//mainView 불량등록 통계 컨트롤
		} else if(mainView == "faulty"){
			equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			prcssTemp = 0;
			matrlTemp = 0;
			replaceTemp = 0;
			troubleTemp = 0;
			$('.day').attr('disabled', true);
			$('.night').attr('disabled', true);
			readTotal();
			
			//$('tr.tableSelected').removeClass('tableSelected');
			$('#cardSelect').addClass('d-none');			
			$('#cardDay').addClass('d-none');				//주간 상단 버튼 숨김
			$('#cardNight').addClass('d-none');				//야간 상단 버튼 숨김
			$('#dayPrcssFaultyView').addClass('d-none');	//공정불량 주간입력
			$('#nightPrcssFaultyView').addClass('d-none');	//공정불량 야간입력
			$('#dayMatrlFaultyView').addClass('d-none');	//자재불량 주간입력
			$('#nightMatrlFaultyView').addClass('d-none');	//자재불량 야간입력
			$('#dayReplaceyView').addClass('d-none');		//교체불량 주간입력
			$('#nightReplaceFaultyView').addClass('d-none');//교체불량 야간입력
			$('#dayTroubleFaultyView').addClass('d-none');	//트러블불량 주간입력
			$('#nightTroubleFaultyView').addClass('d-none');//트러블불량 야간입력
			
			$('#showMenu').addClass("d-none");
		//mainView 비가동관리 컨트롤
		} else if (mainView == "downtime"){
			$('#fromEquipDowntime').each(function(){
				 this.reset();
			});
			$('#equipDowntimeAdmTable tbody tr').removeClass('selected');
			equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			ordGubunCd = $('#ordGubunCd').val();
			chooseDate = $('#downtimeRegDate').val();
			baseGroupCd = null;
			$('#btnDowntimeSave').attr('disabled', true);
			$('#downtimeDtl').DataTable().clear().draw();
			//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
			
			reloadDowntimeAdm();
				
			$('#showMenu').addClass("d-none");
		}
    });

	//작업지시 추가btn
	$('#btnAddWorkOrder').on('click', function () {
		if (equipCd == null || equipCd == '') {
			toastr.warning('작업지시를 추가할 설비를 선택해주세요!', '', {timeOut: 5000});
			return false;
		}
		if (ordDateCal == null || ordDateCal == '') {
			toastr.warning('작업지시를 추가할 일자를 선택해주세요!', '', {timeOut: 5000});
			$('#ordDate').focus();
			return false;
		}

		$('#equipWorkOrdPlanListLabel').text('작업지시 추가 ' + ordDateCal);
		$('#equipWorkOrdPlanList').DataTable().ajax.reload( function () {});
		$('#equipWorkOrdPlanListModal').modal('show');
    });

	//var addAlnicuMatrlCd = '';
	//var addFilmMatrlCd = '';
	//var addEquipCondSeq = '';
	//var addOrdLotNo = '';
	//var addWorkOrdNo = '';
	//var addWorkStatusCd = '';
	//var addWorkStatusNm = '';
	//var addGoodsCd = '';
	//var addGoodsNm = '';
	//var addQutyCd = '';
	//var addQutyNm = '';
	//var addSurfaceTrtmtNm = '';
	//var addSurfaceTrtmtCd = '';
	//var addModel = '';
	//var addDealCorpCd = '';
	//var addDealCorpNm = '';
	//var addOldWorkTeamCd = '';
	//var addWorkNo = 0;
	//선택한 제조조건으로 작업지시 생성
	$('#btnAddWorkOrderCheck').on('click', function () {
		if (equipCondSeq == '' || equipCondSeq == null) {
			toastr.warning("추가할 제조조건을 선택해주세요!");
			return false;
		}
		if ($('#equipWorkOrdPlanList').DataTable().data().count() == 0) {
			toastr.warning("추가할 제조조건을 선택해주세요!");
			return false;
		}
		if ($("#equipWorkOrdPlanList").find(".selected").length != 1) {
			toastr.warning("추가할 제조조건을 선택해주세요!");
			return false;
		}
		
		$('#my-spinner').show();
		
		$.ajax({
            url: '<c:url value="wm/createWorkOrder"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipCondSeq'	: 		function() { return equipCondSeq; },
            	'equipCd'		: 		function() { return equipCd; },
            	'ordDate'		:		function() { return ordDateCal.replace(/-/g, ''); },
            	'ordGubun'		:		function() { return planOrderGubun; },
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//addAlnicuMatrlCd = data.alnicuMatrlCd;
					//addFilmMatrlCd = data.filmMatrlCd;
					//addEquipCondSeq = data.equipCondSeq;
					//addOrdLotNo = data.ordLotNo;
					//addWorkOrdNo = data.workOrdNo;
					//addWorkStatusCd = data.workStatusCd;
					//addWorkStatusNm = data.workStatusNm;
					//addGoodsCd = data.goodsCd;
					//addGoodsNm = data.goodsNm;
					//addSurfaceTrtmtCd = data.surfaceTrtmtCd;
					//addSurfaceTrtmtNm = data.surfaceTrtmtNm;
					//addModel = data.model;
					//addWorkTeamCd = data.workTeamCd;
					//addQutyCd = data.qutyCd;
					//addQutyNm = data.qutyNm;
					//addDealCorpCd = data.dealCorpCd;
					//addDealCorpNm = data.dealCorpNm;
					//addWorkNo = $('#workOrderTable').DataTable().rows().count() + 1;
					//$('#workOrderTable').DataTable().row.add({}).draw(false);
					workOrdNo = null;
					$('#left-expand').trigger('click');
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#workOrderMatrlTable').DataTable().clear().draw();
					toastr.success("추가되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
	});
	
	$.fn.dataTable.ext.errMode = 'none';
    let equipWorkOrdPlanList = $('#equipWorkOrdPlanList').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
//         dom: "<'row'<''l>>" +
// 		"<'row'<'col-sm-12'tr>>" +
// 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",          
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: false,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        async: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="wm/equipWorkOrdPlanList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipCd'		:		function() { return equipCd; },
           		'planRegDate'	:		function() { return ordDateCal.replace(/-/g, ''); },
            },
        },
        //rowId: '',
		columns: [
			{ data: 'equipCondSeq',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'goodsNm',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'qutyNm',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'model',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'surfaceTrtmtNm',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'workGubunNm',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'planRegDate',
				render: function(data, type, row) {
					var html = '';
					if( row['workGubunCd'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + moment(data).format("YYYY-MM-DD") + '</p>';
					} else if( row['workGubunCd'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + moment(data).format("YYYY-MM-DD") + '</p>';
					}
					return html;
				}
			},
		],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,6], className: 'text-center' },
        ],
 	    drawCallback: function( settings ) {
 	    	$('#equipWorkOrdPlanList tbody tr td').css('height','50px');
 	    }
    });

    var equipCondSeq = '';
    var planOrderGubun = '';
	$('#equipWorkOrdPlanList tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
			
		} else {
			$('#equipWorkOrdPlanList').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			equipCondSeq = equipWorkOrdPlanList.row(this).data().equipCondSeq;
			planOrderGubun = equipWorkOrdPlanList.row(this).data().workGubunCd;
		}
	});
    
    //작업지시 테이블
    $.fn.dataTable.ext.errMode = 'none';
    let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	       	location.href = "/";
		} ).DataTable({
		language: lang_kor,
		//fixedHeader: true,
		paging: true,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 20,
        ajax: {
            url: '<c:url value="po/workOrderPlanDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	: 	menuAuth,
                'equipCd'	:	function() { return equipCd; }, 
            	'ordDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
            	'ordGubun'	:	function() { return ordGubunCd; },
            },
// 			success: function (res) {
// 				let data = res.data;
// 				if (res.result != 'ok') {
// 					toastr.error(res.message);
// 				}
// 			},
// 			complete:function(){
// 			}            
	    },
	    rowId: 'equipCd',
		columns: [
			{ data: 'goodsNm', 
	    		render: function(data, type, row, meta) {
	    			var sFlag = uiProcFlag(ordDateCal, row['workStatusCd']);
					var goodsNm_html = '<div class="input-sub m-0">';
						goodsNm_html += '<input type="hidden" id="alnicuMatrlCd' + row['workNo'] + '" name="alnicuMatrlCd' + row['workNo'] + '" value="' + row['alnicuMatrlCd'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="filmMatrlCd' + row['workNo'] + '" name="filmMatrlCd' + row['workNo'] + '" value="' + row['filmMatrlCd'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="equipCondSeq' + row['workNo'] + '" name="equipCondSeq' + row['workNo'] + '" value="' + row['equipCondSeq'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="ordLotNo' + row['workNo'] + '" name="ordLotNo' + row['workNo'] + '" value="' + row['ordLotNo'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="workOrdNo' + row['workNo'] + '" name="workOrdNo' + row['workNo'] + '" value="' + row['workOrdNo'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="workStatusCd' + row['workNo'] + '" name="workStatusCd' + row['workNo'] + '" value="' + row['workStatusCd'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="goodsCd' + row['workNo'] + '" name="goodsCd' + row['workNo'] + '" value="' + row['goodsCd'] + '" disabled>';
						goodsNm_html += '<input type="text" class="form-control touch6" id="goodsNm' + row['workNo'] + '" name="goodsNm' + row['workNo'] + '" value="' + row['goodsNm'] + '" disabled>';
						goodsNm_html += '<input type="hidden" id="oldWorkTeamCd' + row['workNo'] + '" name="oldWorkTeamCd' + row['workNo'] + '" value="' + row['workTeamCd']  +  '" disabled>';																		
						if (sFlag == "") {
							goodsNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm1' + row['workNo'] + '" onClick="selectEquipCondCommonList(\'' + row["workNo"] + '\')">';
							goodsNm_html += '<span class="oi oi-magnifying-glass"></span>';
							goodsNm_html += '</button>';
						}
						goodsNm_html += '</div>';
					return goodsNm_html;
	    		}
			},
			{ data: 'qutyNm',
	    		render: function(data, type, row, meta) {
    				return '<span id="qutyNm' + row['workNo'] + '">' + data + '</span>';
	    		}
			},
			{ data: 'model',
	    		render: function(data, type, row, meta) {
    				return '<span id="model' + row['workNo'] + '">' + data + '</span>';
	    		}
			},
			{ data: 'surfaceTrtmtNm', 
	    		render: function(data, type, row, meta) {
    				return '<span id="surfaceTrtmtNm' + row['workNo'] + '">' + data + '</span>';
	    		}
			},
			{ data: 'customDealCorpNm',
	    		render: function(data, type, row, meta) {
	    			var sFlag = uiProcFlag(ordDateCal, row['workStatusCd']);	
		    		var dealCorpNm = data;
		    		if(dealCorpNm == null) dealCorpNm ="";
					var dealCorpNm_html = '<div class="input-sub m-0">';
						dealCorpNm_html += '<input type="hidden" class="form-control" id="dealCorpCd' + row['workNo'] + '" name=dealCorpCd' + row['workNo'] + '" value="' + row['customDealCorpCd'] + '" disabled>';
						dealCorpNm_html += '<input type="text" class="form-control touch6" id="dealCorpNm' + row['workNo'] + '" name="dealCorpNm' + row['workNo'] + '" value="' + dealCorpNm + '" style="width:98%;" disabled>';
						if(sFlag == "") {
							//dealCorpNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm2' + row['workNo'] + '" onClick="selectDealCorp(\'' + row["workNo"]  + '\')">';
							//dealCorpNm_html += '<span class="oi oi-magnifying-glass"></span>';
							//dealCorpNm_html += '</button>';
						}
						dealCorpNm_html += '</div>';
					return dealCorpNm_html ;
	    		}
			},
			//{ data: 'ordLotNo',
	       	//	render: function(data, type, row, meta) {
			//		html = '';
			//		if( row['ordGubun'] == 'D') {
			//			html = '<p id="ordLotNoText' + row['workNo'] + '" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
			//		} else if( row['ordGubun'] == 'N') {
			//			html = '<p id="ordLotNoText' + row['workNo'] + '" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
			//		}
			//		return html;
	       	//	}
			//},
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
    				html = '';
	           		//console.log(row['workOrdNo'].substring(13,1));
	           		if( row['ordGubun'] == 'D') {
	           			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	           		} else if( row['ordGubun'] == 'N') {
	               		html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workStatusNm',
	       		render: function(data, type, row, meta) {
	           		return data;
	       		}
			},
			{ data: 'workTeamCd',
				render: function(data, type, row, meta) {
    				html = 	selectBoxHtml(workTeamCode, 'workTeamCd' + row['workNo'], data, row, meta);
	           		if (uiProcFlag(ordDateCal, row['workStatusCd']) == "disabled") {
	           			html = row['workTeamNm'];
	           		}
	           		return html;
	       		}
			},
			/* 
			{ data: 'mainWorkChargrNm',
	    		render: function(data, type, row, meta) {
    				var sFlag = uiProcFlag3(ordDateCal, row['workStatusCd']);
		    		var mainWorkChargrNm = data;
		    		if (mainWorkChargrNm == null) mainWorkChargrNm ="";
					var mainWorkChargrNm_html = '<div class="input-sub m-0">';
						mainWorkChargrNm_html += '<input type="hidden" class="form-control" id="mainWorkChargr' + row["workNo"] + '" name="mainWorkChargr' + row["workNo"] + '" value="' + row['mainWorkChargr'] + '" disabled>';
						mainWorkChargrNm_html += '<input type="text" class="form-control touch6" id="mainWorkChargrNm' + row["workNo"] + '" name="mainWorkChargrNm' + row["workNo"] + '" value="' + mainWorkChargrNm + '" style="width:98%;" disabled>';
						if(sFlag == "") {
							mainWorkChargrNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm3' + row["workNo"] + '" onClick="selectWorkCharger(\'main\',\'' + row["workNo"]  + '\')">';
							mainWorkChargrNm_html += '<span class="oi oi-magnifying-glass"></span>';
							mainWorkChargrNm_html += '</button>';
						}
					mainWorkChargrNm_html += '</div>';
					return mainWorkChargrNm_html;
	    		}
			},
			{ data: 'subWorkChargrNm',
	    		render: function(data, type, row, meta) {
    				var sFlag = uiProcFlag3(ordDateCal, row['workStatusCd']);
	    			var subWorkChargrNm = data;
		    		if (subWorkChargrNm == null) subWorkChargrNm ="";
					var subWorkChargrNm_html = '<div class="input-sub m-0">';
						subWorkChargrNm_html += '<input type="hidden" class="form-control" id="subWorkChargr' + row['workNo'] + '" name="subWorkChargr' + row['workNo'] + '" value="' + row['subWorkChargr'] + '" disabled>';
						subWorkChargrNm_html += '<input type="text" class="form-control touch6" id="subWorkChargrNm' + row['workNo'] + '" name="subWorkChargrNm' + row['workNo'] + '" value="' + subWorkChargrNm + '" style="width:98%;" disabled>';
						if(sFlag == "") {
							subWorkChargrNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm4' + row['workNo'] + '" onClick="selectWorkCharger(\'sub\',\'' + row["workNo"]  + '\')">';
							subWorkChargrNm_html += '<span class="oi oi-magnifying-glass"></span>';
							subWorkChargrNm_html += '</button>';
						}
						subWorkChargrNm_html += '</div>';
					return subWorkChargrNm_html ;
	    		}
			},
			*/																	
		],
	    columnDefs: [
	    	{ targets: [0,1,2,3,4,5,6,7], className: 'text-center' },
	    ],		
		order: [
			[ 0, 'asc' ],
		],
	    drawCallback: function( settings ) {
	    	$('#workOrderTable_paginate').html("&nbsp;");
	    	$('#workOrderTable tbody tr td').css('height','40px');
	    	$(".custom-select-sm").css("font-size", "15px");
	    	$(".custom-select-sm").css("height", "30px");
	    	$(".oi-magnifying-glass").css("font-size", "15px");
	    	$('#workOrderTable_paginate').html("");	//작지테이블 밑 공백 제거
	    }
	});
	
	//var html3 = '<div class="row">&nbsp;<label class="input-label-sm">작지일</label><div class="form-group input-sub m-0 row">';
	//	html3 += '<input class="form-control" style="width:97px;" type="text" id="ordDate" name="ordDate" />';
	//	html3 += '<button onclick="fnPopUpCalendar(ordDate,ordDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button">';
	//	html3 += '<span class="oi oi-calendar"></span>';
	//	html3 += '</button>'; 
	//	html3 += '</div>';
	//	html3 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">주야</label><select  class="custom-select" id="ordGubunCd" ></select>&nbsp;  <button type="button" class="btn btn-primary" id="btnWorkOrdRetv">조회</button></div>';
	//$('#workOrderTable_length').html(html3);
		
// 	$('#ordDate').val(ordDateCal);

	//작지일 공장기준으로 변경
	var date 		= new Date(new Date().setHours(0,0,0,0));	//오늘날짜 00:00:00
	var secondDiff	= parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
	var today 		= new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today 		= getDateType(today);						//YYYY-MM-DD 형식으로 변환

	//현재시간이 07:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘 날짜로 표시
	if (secondDiff >= 25200 && secondDiff <= 86399) {
		$('#ordDate').val(today);
		ordDateCal = today;
	}

	//현재시간이 00:00:00 ~ 06:59:59 이면 전표(생산)일자는 전 날짜로 표시
	if (secondDiff >= 0 && secondDiff <= 25199) {
		let minusOneday = new Date(new Date().setHours(0,0,0,0));
			minusOneday.setDate(minusOneday.getDate()-1);
			minusOneday = getDateType(minusOneday);
		$('#ordDate').val(minusOneday);
		ordDateCal = minusOneday;
	}
	//작지일 공장기준으로 변경 
	
	$('#ordDate').on('change', function(){
    	//작업지시 reload
		if(equipCd != null && equipCd != "" ) {
	    	ordDateCal =  $('#ordDate').val();
	    	ordGubunCd =  $('#ordGubunCd option:selected').val();
			$('#workOrderTable').DataTable().ajax.reload( function () {});
			$('#workOrderMatrlTable').DataTable().clear().draw();
			//$('#btnWorkOrdConnect').addClass('d-none');
			$('#matrlCdText').val("");
			matrlIndex = "";
			matrlRowCnt = "";
			uiProc(true);
			workOrdNo = null;
			
			$('#left-expand').trigger('click');
        } else {
        	$('#ordDate').val(ordDateCal);
        	toastr.warning("설비정보를 선택해 주세요");
        }
	});

	selectBoxAppend(ordGubunCode, "ordGubunCd", "", "1");
	$('#workOrderTable_paginate').html("&nbsp;");
		
	var workOrdNo = null;
	var workOrdIndex;
	var workStatusCd = null;
	var gravity = null;
	var targetWeight = null;
	var targetCount = null;
	var targetCnt = null;		//작지에서 읽어온 원본데이터
	var tempTargetCnt = null;	//생산실적이 입력되었는지 아닌지 판단
	
	tempWorkStatus = null;	//오른쪽 버튼들을 클릭하여 활성화 되기 전 작지 상태체크 변수
	$('#workOrderTable tbody').on('click', 'tr', function () {
 		tempWorkStatus = workOrderTable.row(this).data().workStatusCd;
		let tempWorkOrdNo = workOrderTable.row(this).data().workOrdNo;
		
		$('#my-spinner').show();
		//작업지시 상태 
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(tempWorkOrdNo, tempWorkStatus);
		if (checkWorkOrdStatusTemp) {
			tempWorkOrdNo = null;
			tempWorkStatus = null;
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
			
		} else {
			////작지 연결 버튼 활성화&비활성화
			//if (tempWorkStatus == 'B' && (tempWorkOrdNo.substring(13,14) == 1 || tempWorkOrdNo.substring(13,14) == 3)) {
			//	$('#btnWorkOrdConnect').removeClass('d-none');
			//} else {
			//	$('#btnWorkOrdConnect').addClass('d-none');
			//}
			
	  	  	if (sideView == "firstStep" && tempWorkStatus == "B") {
	        	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	  	
			} else if ( sideView == "secondStep" && tempWorkStatus == "B") {
	        	toastr.warning("미발행 작업지시는 중물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	  	
			} else {
				if ( $(this).hasClass("selected") ) {
					//이미 선택된 행 선택 시에는 아무것도 하지 않음
					
				} else {

					//right-side가 펼쳐져 있을 때에는 작업지시 선택 변경 불가!
					/* if (!(sideView == null) && !(sideView == '')) {
						toastr.warning("입력창이 열려있는 경우에는 작업지시를 변경하실 수 없습니다!");
						$('#left-expand').focus();
						return false;
						
					} else { */
						var sideviewstatus = '';

						if(sideView == 'output'){
							sideviewstatus = sideView;
						}
			        	$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			            $(this).addClass('selected');
			            
			            workStatusCd = workOrderTable.row(this).data().workStatusCd;
			            workOrdNo = workOrderTable.row(this).data().workOrdNo;
			            equipCondSeq = workOrderTable.row(this).data().equipCondSeq;
			            gravity = workOrderTable.row(this).data().gravity;
			            targetWeight = workOrderTable.row(this).data().targetWeight;
			            equipCapa = parseInt(workOrderTable.row(this).data().capa/2);
			            targetCnt = workOrderTable.row(this).data().targetCnt;
			        	//outputWeight1 = workOrderTable.row(this).data().outputWeight1;
			        	//outputWeight2 = workOrderTable.row(this).data().outputWeight2;
			        	//outputWeight3 = workOrderTable.row(this).data().outputWeight3;
			        	//outputWeight4 = workOrderTable.row(this).data().outputWeight4;
			        	//outputCnt = workOrderTable.row(this).data().outputCnt;
			            workOrdIndex = workOrderTable.row(this).index() + 1;
			            
			        	var matrlText = "[자재코드 : " + $('#alnicuMatrlCd' + workOrdIndex).val() + "/" + $('#filmMatrlCd' + workOrdIndex).val() + "]";
			        	$('#matrlCdText').val(matrlText);
			        	matrlIndex = "";
			        	matrlRowCnt = "";

						//작지 삭제&시작&진행취소 버튼 활성화&비활성화
						if (workStatusCd == 'B') {
							$('#btnDeleteWorkOrder').removeClass("d-none");
							$('#btnStart').removeClass("d-none");
							$('#btnCancel').removeClass("d-none");

							$('#btnReStart').addClass("d-none");
						} else if (workStatusCd == 'S') {
							$('#btnDeleteWorkOrder').addClass("d-none");
							$('#btnStart').addClass("d-none");
							$('#btnCancel').removeClass("d-none");

							$('#btnReStart').addClass("d-none");
				        } else if ( workStatusCd == 'C' ) {
				        	$('#btnDeleteWorkOrder').removeClass("d-none");
				        	$('#btnStart').removeClass("d-none");
							$('#btnCancel').addClass("d-none");

							$('#btnReStart').removeClass("d-none");
							$('#btnEnd').addClass("d-none");
					    } else {
				        	$('#btnDeleteWorkOrder').addClass("d-none");
							$('#btnStart').removeClass("d-none");
							$('#btnCancel').addClass("d-none");

							$('#btnReStart').addClass("d-none");
						}
						
			        	$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});

			        	if($('#workOrderMatrlTable').DataTable().data().count() != 0){				        	
							$('#workOrderMatrlTable tbody tr').each(function() {								
								//상태가 불량인거 빼고 넣을 예정
								if($(this).find("#matrlCd").val() != null || $(this).find("#matrlCd").val() == ""){
									if (($(this).find("#matrlCd").val().substring(0,1) == 'A') || ($(this).find("#matrlCd").val().substring(0,1) == 'N')) {
										//$(this).addClass('selected');
										if($(this).find('td').eq(10).html() == '정상'){
											$(this).click();
											return false;
										}
										
									}						
								}
								
							});
			        	}
			        	if(uiProcFlag2(ordDateCal ,workStatusCd) == "") {
			        		uiProc(false);
			            } else {
			        		uiProc(true);
			            }			        	
						//여기서 right-list 버튼들 예외처리 잘 해놨으면 
						$('#left-expand').trigger('click');	//모든 변수 값 초기화
						//하기만 하면 모든게 잘 될것임.
			    		
			        	////sideView 초물 처리
						//if (sideView == "firstStep") {
						//	stepViewClear();
						//	agtTempDataRead(); // 에이젼트 온도 데이터 읽기
						//	agtTempCondRead(); // 에이전트 온도 조건 읽기
						//	agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
						//	agtSizeCondRead(); // 에이전트 치수 조건 읽기
						//	$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
						//	//btnFirstStep = true;
						//	
						////sideView 중물 처리
						//} else if (sideView == "secondStep") {
						//	stepViewClear();
						//	agtTempDataRead(); // 에이젼트 온도 데이터 읽기
						//	agtTempCondRead(); // 에이전트 온도 조건 읽기
						//	agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
						//	agtSizeCondRead(); // 에이전트 치수 조건 읽기
						//	$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
						//	//btnSecondStep = true;
			            //
						////sideView 생산실적 입력 처리
						//} else if (sideView == "output") {
					  	//  	if (workStatusCd != "S" && workStatusCd != "C"){
						//		toastr.warning("진행중이거나 완료된 작업지시만 생산실적을 입력 할 수 있습니다!");
						//		$('#btnOutputDelete').attr('disabled', true);
						//		$('#btnOutputAdd').attr('disabled', true);
						//		$('#btnOutputEdit').attr('disabled', true);
						//		$('#btnOutputSave').attr('disabled',true);
						//	} else {
						//		$('#btnOutputDelete').attr('disabled', false);
						//		$('#btnOutputAdd').attr('disabled', false);
						//		$('#btnOutputEdit').attr('disabled', false);
						//	}
						//	$('#gubun').attr('disabled', true);
						//	$('#firstWeight').attr('disabled', true);
						//	$('#visionEdgeWeight').attr('disabled', true);
						//	$('#workOrdDate').attr('disabled', true);
						//	
						//	outputRead();
						//	outputBtnStat = 'add';
						//}
					//}
					
					matrlAddListWorkOrdNo = workOrderTable.row(this).data().workOrdNo;
					matrlAddListGoodsCd = workOrderTable.row(this).data().goodsCd;
					matrlAddListGoodsNm = workOrderTable.row(this).data().goodsNm;

					$('#btnMatrlList').attr('disabled', false);		//투입자재목록 버튼
					$('#my-spinner').hide();

					if(sideviewstatus == 'output'){
						$('#btnOutput').trigger('click');
					}
					
	        	}
	        }
		}
    });

	//작지 주야선택
	$('#ordGubunCd').change(function() {
		//작업지시
		ordDateCal =  $('#ordDate').val();
		if (mainView == "workOrder") {
			ordGubunCd =  $('#ordGubunCd option:selected').val();
			if(ordGubunCd == ""){
				ordGubunCd = null;
			}
			$('#workOrderTable').DataTable().ajax.reload( function () {});
			$('#workOrderMatrlTable').DataTable().clear().draw();
			//$('#btnWorkOrdConnect').addClass('d-none');
			workOrdNo = null;
			$('#left-expand').trigger('click');
			
		//비가동관리
		} else if (mainView == "downtime") {
			ordGubunCd =  $('#ordGubunCd option:selected').val();
			//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
			$('#fromEquipDowntime').each(function(){
				 this.reset();
			});
			if (ordGubunCd == "") {
				toastr.warning("주야를 선택해주세요.");
				$('#ordGubunCd').focus();
				return false;
			}
			$('#btnDowntimeSave').attr('disabled', true);
			$('#downtimeDtl').DataTable().clear().draw();
			
			reloadDowntimeAdm();
			
		}
		
    });

    $('#btnWorkOrdRetv').on('click', function() {
    	//작업지시 reload
        if ( mainView =="workOrder" ) {
			if(equipCd != null && equipCd != "" ) {
		    	ordDateCal =  $('#ordDate').val();
		    	ordGubunCd =  $('#ordGubunCd option:selected').val();
				$('#workOrderTable').DataTable().ajax.reload( function () {});
				$('#workOrderMatrlTable').DataTable().clear().draw();
				//$('#btnWorkOrdConnect').addClass('d-none');
				$('#matrlCdText').val("");
				matrlIndex = "";
				matrlRowCnt = "";
				uiProc(true);
				workOrdNo = null;
				
				$('#left-expand').trigger('click');
	        } else {
	        	toastr.warning("설비정보를 선택해 주세요");
	        }

		//불량통계 reload
        } else if ( mainView =="faulty" ) {
            ordDateCal = $('#ordDate').val();
            //equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			prcssTemp = 0;
			matrlTemp = 0;
			replaceTemp = 0;
			troubleTemp = 0;
			$('.day').attr('disabled', true);
			$('.night').attr('disabled', true);
			faultyRegDate = $('#faultyRegDate').val();
			readTotal();

	        $('tr.tableSelected').removeClass('tableSelected');
	        $('#cardSelect').addClass('d-none');
	        $('#cardDay').addClass('d-none');				//주간 상단 버튼 숨김
	        $('#cardNight').addClass('d-none');				//야간 상단 버튼 숨김
	        $('#dayPrcssFaultyView').addClass('d-none');	//공정불량 주간입력
	        $('#nightPrcssFaultyView').addClass('d-none');	//공정불량 야간입력
	        $('#dayMatrlFaultyView').addClass('d-none');	//자재불량 주간입력
	        $('#nightMatrlFaultyView').addClass('d-none');	//자재불량 야간입력
	        $('#dayReplaceFaultyView').addClass('d-none');	//교체불량 주간입력
	        $('#nightReplaceFaultyView').addClass('d-none');//교체불량 야간입력
	        $('#dayTroubleFaultyView').addClass('d-none');	//트러블불량 주간입력
	        $('#nightTroubleFaultyView').addClass('d-none');//트러블불량 야간입력

		////비가동관리 reload	        
        } else if ( mainView =="downtime" ) {
        	if( equipCd == null ){
    			toastr.warning('설비명을 선택해주세요.');
    			return false;
    		}
        	if( ordGubunCd == null || ordGubunCd == "" ){
    			toastr.warning('주야를 선택해주세요.');
    			$('#ordGubunCd').focus();
    			return false;
    		}
			$('#fromEquipDowntime').each(function(){
				 this.reset();
			});
			$('#btnDowntimeSave').attr('disabled', true);
			ordDateCal = $('#ordDate').val();
			ordGubunCd = $('#ordGubunCd').val();
			//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
			
			reloadDowntimeAdm();

        }
    });

    //작지 조회버튼과 통합해서 사용하다가 UI를 분리해야되서 버튼도 분리하였음
    $('#btnFaultyRetv').on('click', function() {
		//불량통계 reload
    	if ( mainView =="faulty" ) {
	        ordDateCal = $('#ordDate').val();
	        //equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			prcssTemp = 0;
			matrlTemp = 0;
			replaceTemp = 0;
			troubleTemp = 0;
			$('.day').attr('disabled', true);
			$('.night').attr('disabled', true);
			faultyRegDate = $('#faultyRegDate').val();
			readTotal();
	
	        $('tr.tableSelected').removeClass('tableSelected');
	        $('#cardSelect').addClass('d-none');
	        $('#cardDay').addClass('d-none');					//주간 상단 버튼 숨김
	        $('#cardNight').addClass('d-none');					//야간 상단 버튼 숨김
	        $('#dayPrcssFaultyView').addClass('d-none');		//공정불량 주간입력
	        $('#nightPrcssFaultyView').addClass('d-none');		//공정불량 야간입력
	        $('#dayMatrlFaultyView').addClass('d-none');		//자재불량 주간입력
	        $('#nightMatrlFaultyView').addClass('d-none');		//자재불량 야간입력
	        $('#dayReplaceFaultyView').addClass('d-none');		//교체불량 주간입력
	        $('#nightReplaceFaultyView').addClass('d-none');	//교체불량 야간입력
	        $('#dayTroubleFaultyView').addClass('d-none');		//트러블불량 주간입력
	        $('#nightTroubleFaultyView').addClass('d-none');	//트러블불량 야간입력
    	}
	});
	
	$.fn.dataTable.ext.errMode = 'none';
	let workOrderMatrlTable = $('#workOrderMatrlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
//         dom: "<'row'<''l>>" +
// 		"<'row'<'col-sm-12'tr>>" +
// 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",          
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: false,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        async: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="po/workOrderMatrlDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'workOrdNo' : function() { return workOrdNo; }
            },
        },
        //rowId: 'workOrdNo',
		columns: [
			{ data: 'qutyNm', 
	    		render: function(data, type, row) {
	    			if(data != null) {
	    				return data;
	    			} else {
						return barcodeData.qutyNm;
	    			}
	    		}	
			},
			{ data: 'matrlNm',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				//return data;
	    				return '<input type="hidden" id="matrlCd" name="matrlCd" value="'+row["matrlCd"]+'" /><span>'+data+'</span>';
	    			} else {
						//return barcodeData.matrlNm;
	    				return '<input type="hidden" id="matrlCd" name="matrlCd" value="'+barcodeData.matrlCd+'" /><span>'+barcodeData.matrlNm+'</span>';
	    			}
	    		}
			},
			{ data: 'surfaceTrtmtNm',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				return data;
	    			} else {
		    			if(row["matrlCd"] != null) {
							return '';
		    			} else {
			    			return barcodeData.surfaceTrtmtNm;
		    			}	
	    			}
	    		}				
			},
			{ data: 'lotNo',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				return data;
	    			} else {
						return  barcodeData.lotNo;
	    			}
	    		}
			},
			{ data: 'inspectQty',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				return data;
	    			} else {
						return  barcodeData.inspectQty;
	    			}
	    		}				
			},
			{ data: 'faultyQty',
	    		render: function(data, type, row) {	
// 	    			if(data != null) {
// 	    				return data;
// 	    			} else {
// 						return  "0";
// 	    			}
		    		var faultyQty = data;
		    		if(data == null || data == "") faultyQty = "0";
		    		if(workStatusCd == 'S' || workStatusCd == 'C') {
			    		var	html = '<input type="number" maxlength="7" min="0" max="' + row['inspectQty'] + '" step="0.001"  class="form-control number-float3 workOrderMatrlInput" id="faultyQty" name="faultyQty" value="'+ parseFloat(faultyQty).toFixed(3) +'" onpaste="return false;" oncopy="return false;">';
			    			return html;
		    		} else {
		    			return  parseFloat(faultyQty).toFixed(3);
				    }
	    		}
			},			
			{ data: 'barcodeNo',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				return data;
	    			} else {
						return  barcodeData.barcodeNo;
	    			}
	    		}
			},
			{ data: 'regDate',
	    		render: function(data, type, row) {	
	    			if(data != null) {
	    				return data;
	    			} else {
						return  barcodeData.regDate;
	    			}
	    		}
			},
			{ data: 'remakeYn',
	    		render: function(data, type, row) {
	    			var remakeNm = "신규투입";	
	    			
	    			if(data != null) { //reload했을때
		    			if(data == 'Y') {
							remakeNm = "재투입";
						}
	    			} else { //첫 스캔했을때
		    			if(barcodeData.remakeYn == null){
		    				remakeNm = "신규투입";
			    		}
		    			if(barcodeData.statusCd == 'P') {
		    				remakeNm = "재투입";
						}
		    			if(barcodeData.statusCd == 'O' && barcodeData.faultyStatus == '002') {
		    				remakeNm = "재투입";
						}
		    			if(barcodeData.remakeYn == 'Y') {
		    				remakeNm = "재투입";
						}
	    			}

	    			return remakeNm;
	    		}				
			},
			 { data: 'changeLocation',
	    		render: function(data, type, row, meta) {
	    			if(data != null) {
	    				return '<input type="text" class="form-control mw-100 workOrderMatrlInput" name="changeLocation" id="changeLocation-' + meta.row + '" value="' + data + '">';
		    		} else {
		    			return '<input type="text" class="form-control mw-100 workOrderMatrlInput" name="changeLocation" id="changeLocation-' + meta.row + '">';
			    	}
			    	
	    		}
			}, 
			{ data: 'faultyStatusNm' ,
	    		render: function(data, type, row) {
	    			let faultyStatusNm = "";	
	    			if (data != null) { //reload했을때
	    				faultyStatusNm  = data;
	    			} else { //첫 스캔했을때		    					    				    			
	    				if ((barcodeData.statusCd == 'O' && barcodeData.approvalCd == '009') || (barcodeData.statusCd == 'P' && barcodeData.approvalCd == '009')) {
	    					faultyStatusNm = "불량재투입";
						} else {
							faultyStatusNm = '정상';
						}
	    			}
	    			return faultyStatusNm;
	    		}
			},
			//{ data: 'connectNm' }, 연결여부
		],
        columnDefs: [
        	{ targets: [0,1,2,3,6,7,8,10], className: 'text-center' },
        	{ targets: [4,5], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5], className: 'text-right pt-0 pb-0' },
        ],
		//order: [
		//	[ 7, 'asc' ],
		//],
// 	    "drawCallback": function( settings ) {
// 	    	$('#workOrderMatrlTable tbody tr td').css('height','40px');
// 	    }
// 	    "complete": function( settings ) {
// 	    	matrlRowCnt = $('#workOrderMatrlTable').DataTable().data().count();
// 	    }
    });

    var matrlIndex;
    $('#workOrderMatrlTable tbody').on('click', 'tr', function () {
    	matrlIndex = $('#workOrderMatrlTable').DataTable().row(this).index();
        if ($(this).hasClass('selected')) {
            //$(this).removeClass('selected');
        } else {
            
			//입력창이 열려있는상태에서 자재 선택 변경시 주자재인지 판별
        	if (!(sideView == null) && !(sideView == '')) {
        		var matrlSaveCheck = true;
        		if (sideView == "firstStep") {
					//자재행 선택하였는지 확인
					//if ($("#workOrderMatrlTable").find(".selected").length != 1) {
					//	toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
					//	return false;
					//}
					//goodsCd 첫글자가 A도아니면서 N도 아니면 true
					if (!($(this).find("#matrlCd").val().substring(0,1) == 'A') && !($(this).find("#matrlCd").val().substring(0,1) == 'N')) {
						toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
						return false;
					}
					if ($(this).find('td').eq(3).html() == null || $(this).find('td').eq(3).html() == '') {
						toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
						return false;
					}
					//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
					matrlSaveCheck = checkWorkOrderMatrlSave($(this).find('td').eq(3).html());
					if (matrlSaveCheck) {
						toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
						return false;
					}
					
				} else if (sideView == "secondStep") {
            		//자재행 선택하였는지 확인
            		//if ($("#workOrderMatrlTable").find(".selected").length != 1) {
            		//	toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
            		//	return false;
            		//}
            		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
            		if (!($(this).find("#matrlCd").val().substring(0,1) == 'A') && !($(this).find("#matrlCd").val().substring(0,1) == 'N')) {
            			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
            			return false;
            		}
            		if ($(this).find('td').eq(3).html() == null || $(this).find('td').eq(3).html() == '') {
            			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
            			return false;
            		}
            		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
					matrlSaveCheck = checkWorkOrderMatrlSave($(this).find('td').eq(3).html());
					if (matrlSaveCheck) {
						toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
						return false;
					}
					
				} else if (sideView == "output") {
            		//자재행 선택하였는지 확인
            		//if ($("#workOrderMatrlTable").find(".selected").length != 1) {
            		//	toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
            		//	return false;
            		//}
            		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
            		if (!($(this).find("#matrlCd").val().substring(0,1) == 'A') && !($(this).find("#matrlCd").val().substring(0,1) == 'N')) {
            			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
            			return false;
            		}
            		if ($(this).find('td').eq(3).html() == null || $(this).find('td').eq(3).html() == '') {
            			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
            			return false;
            		}
            		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
					matrlSaveCheck = checkWorkOrderMatrlSave($(this).find('td').eq(3).html());
					if (matrlSaveCheck) {
						toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
						return false;
					}

					ordLotNo = null;
					ordLotNoStepCd = null;
                }
                //불량중량 입력창을 연 상태에서는 자재를 선택할수가 없어 예외처리에서 제외하였음
                //else if (sideView == "output") {
        	}
			
        	$('#workOrderMatrlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            
            mainMatrlLotNo = $(this).find('td').eq(3).html();
            mainMatrlCd = $(this).find("#matrlCd").val();
			
        	//sideView 초물 처리
			if (sideView == "firstStep") {
				stepViewClear();
				agtTempDataRead(); // 에이젼트 온도 데이터 읽기
				agtTempCondRead(); // 에이전트 온도 조건 읽기
				agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
				agtSizeCondRead(); // 에이전트 치수 조건 읽기
				$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
				//btnFirstStep = true;
				$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
				uiProc(true);
				
			//sideView 중물 처리
			} else if (sideView == "secondStep") {
				stepViewClear();
				agtTempDataRead(); // 에이젼트 온도 데이터 읽기
				agtTempCondRead(); // 에이전트 온도 조건 읽기
				agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
				agtSizeCondRead(); // 에이전트 치수 조건 읽기
				$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
				//btnSecondStep = true;
				$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
				uiProc(true);
				
			//sideView 생산실적 입력 처리
			} else if (sideView == "output") {
		  	  	if (workStatusCd != "S" && workStatusCd != "C"){
					toastr.warning("진행중이거나 완료된 작업지시만 생산실적을 입력 할 수 있습니다!");
					$('#btnOutputDelete').attr('disabled', true);
					$('#btnOutputAdd').attr('disabled', true);
					$('#btnOutputEdit').attr('disabled', true);
					$('#btnOutputSave').attr('disabled',true);
				} else {
					$('#btnOutputDelete').attr('disabled', false);
					$('#btnOutputAdd').attr('disabled', false);
					$('#btnOutputEdit').attr('disabled', false);
				}
				$('#gubun').attr('disabled', true);
				$('#firstWeight').attr('disabled', true);
				$('#visionEdgeWeight').attr('disabled', true);
				$('#workOrdDate').attr('disabled', true);

				$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
				outputRead();
				outputBtnStat = 'add';
			}
        }
    });

    var barcodeData;
    $("#barcodeNo").keypress(function (e) {
		//엔터키
    	if (e.which == 13){
	        if( $('#barcodeNo').val() == "" ) {
	            toastr.warning('바코드를 먼저 스캔해주세요!');
	            return false;
	        }
	        if( workOrdNo == null || workOrdNo == "" ) {
	            toastr.warning('작업지시를 선택해주세요!');
	            return false;
	        }
	        
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng($('#barcodeNo').val());
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#barcodeNo').val(engToKor.toUpperCase());
	    	
	    	//자재투입내역 중복검사
	        var cval = compareBarcodeNo($('#barcodeNo').val());
	        
	        if(cval == false) {
	        	$('#barcodeNo').val("");
	            toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.');
	            return false;
	        }
	        
	        if(matrlRowCnt == null || matrlRowCnt == '') {
	    		matrlRowCnt = $('#workOrderMatrlTable').DataTable().data().count();
	    	}
    	
	  	  	$.ajax({
	            url: '<c:url value="po/workOrderMatrlData"/>',
	            type: 'GET',
	            async: false,
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'workOrdNo'		: 		function() { return workOrdNo; },
	            	'barcodeNo'		: 		$("#barcodeNo").val(),
	            	'goodsCd'		: 		$("#goodsCd" + workOrdIndex).val(),
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						//1작지 1주자재 투입여부 확인
						if (data.baseCdAbbr != 'F') {
							if (compareMetalLotNo()) {
								toastr.warning("작업지시 1개당 주재료(MetalLot)를 1개만  투입 할 수 있습니다!<br>새 작업지시를 발행해 주세요!", '', {timeOut: 5000});
								$('#btnAddWorkOrder').focus();
								return false;
							} else {
								barcodeData = data;
								$('#barcodeNo').val("");
								$('#workOrderMatrlTable').DataTable().row.add({}).draw(false);
								toastr.success("추가되었습니다.");
							}
						} else {

							//최초 투입을 중복 투입 시 재투입으로 변경
							$('#workOrderMatrlTable tbody tr').each(function(){
								var tbarcodeNo = $(this).find('td').eq(6).html();			
								if(data.barcodeNo == tbarcodeNo) {  
									data.remakeYn = 'Y';
								}
							});

							barcodeData = data;
							$('#barcodeNo').val("");
							$('#workOrderMatrlTable').DataTable().row.add({}).draw(false);
							toastr.success("추가되었습니다.");
						}
						
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					//$('#searchDay').val("true")
				}
			});
        }
    });

    var matrlRowCnt;
    $('#btnDelete').on('click', function() {
    	
        //alert($("#workStatusCd"+workOrdIndex).val());
        if(matrlRowCnt == null || matrlRowCnt == '') {
    		matrlRowCnt = $('#workOrderMatrlTable').DataTable().data().count();
    	}

        var checkState = true;
        
		let selectBarcode	= $('#workOrderMatrlTable .selected').find('td').eq(6).text();
		let selectState		= $('#workOrderMatrlTable .selected').find('td').eq(8).text();

		if(selectState == "신규투입"){
			$('#workOrderMatrlTable tbody tr').each(function(){
				var tbarcodeNo	= $(this).find('td').eq(6).html();
				var tstate		= $(this).find('td').eq(8).html();

				if(tstate == "재투입"){
					if( tbarcodeNo == selectBarcode ) {  
						toastr.warning("재투입된 자재를 먼저 삭제해주세요.", '', {timeOut: 5000});
						checkState = false;
						return false;
					}
				}
				
			});
		}

		
		if(checkState){
	    	if($('#workOrderMatrlTable .selected').find('td').eq(8).text() == '신규투입') {
			//if ((mainMatrlCd.substring(0,1) == 'A') || (mainMatrlCd.substring(0,1) == 'N')) {
	    		$.ajax({
	    			url: '<c:url value="/po/deleteMatrlCheck"/>',
	    			type: 'POST',
	    			async: false,
	    			data: {
	    				'menuAuth'	 	:	function() { return menuAuth;	},
	    				'workOrdNo'   	:	function() { return workOrdNo;	},
	    				'lotNo' 		:	function() { return $('#workOrderMatrlTable .selected').find('td').eq(3).text(); },
	    				'matrlCd'		:	function() { return mainMatrlCd; }
	    			},
	    			beforeSend: function() {
	    			//  $('#btnAddConfirm').addClass('d-none');
	    			},            
	    			success: function (res) {
	    				let data = res.data;
	    				if (res.result == 'ok') {    				
	        				if(data=="ok"){
	        					$('#workOrderMatrlTable').DataTable().rows('.selected' ).remove().draw();
	            			} else{
	            				toastr.warning("신규투입자재는 재투입된 자재 삭제후 삭제가 가능합니다.");
	                		}
	    					
	    				} else if (res.result == 'fail') {
	    					toastr.warning(res.message, '', {timeOut: 5000});
	    				} else if (res.result == 'valueExists') {
	    					toastr.warning(res.message, '', {timeOut: 5000});
	    				} else if(res.result == 'error'){
	    					toastr.error(res.message, '', {timeOut: 5000});
	        			} else{
	        				toastr.error(res.message, '', {timeOut: 5000});
	            		}
	    			},
	    			complete:function(){
	    			
	    			}
	    		});
	        } else {
	        	//작업지시 신규투입X 삭제 확인 ajax
	        	$.ajax({
	    			url: '<c:url value="/po/deleteMatrlCheck"/>',
	    			type: 'POST',
	    			async: false,
	    			data: {
	    				'menuAuth'	 	:	function() { return menuAuth;	},
	    				'workOrdNo'   	:	function() { return workOrdNo;	},
	    				'lotNo' 		:	function() { return $('#workOrderMatrlTable .selected').find('td').eq(3).text(); },
	    				'matrlCd'		:	function() { return mainMatrlCd; }
	    			},
	    			beforeSend: function() {
	    			//  $('#btnAddConfirm').addClass('d-none');
	    			},            
	    			success: function (res) {
	    				let data = res.data;
	    				if (res.result == 'ok') {    				
	       					$('#workOrderMatrlTable').DataTable().rows('.selected' ).remove().draw();
	    				} else if (res.result == 'fail') {
	    					toastr.warning(res.message, '', {timeOut: 5000});
	    				} else if (res.result == 'valueExists') {
	    					toastr.warning(res.message, '', {timeOut: 5000});
	    				} else if(res.result == 'error'){
	    					toastr.error(res.message, '', {timeOut: 5000});
	        			} else{
	        				toastr.error(res.message, '', {timeOut: 5000});
	            		}
	    			},
	    			complete:function(){}
	    		});
	        	//작업지시 신규투입X 삭제 확인 ajax
	        }
    	}
        
       /*  if($("#workStatusCd"+workOrdIndex).val() == 'S') {
        	if(matrlIndex == null || matrlIndex == "" || matrlIndex < matrlRowCnt ) {
        		toastr.warning('진행 상태 작지는 추가된 자재만 삭제 가능합니다.');
            } else {
        		$('#workOrderMatrlTable').DataTable().rows( '.selected' ).remove().draw();
            }
        } else {
    		$('#workOrderMatrlTable').DataTable().rows( '.selected' ).remove().draw();
        } */
    });	    

	//작지 삭제
	$('#btnDeleteWorkOrder').on('click', function() {
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning("삭제할 작업지시를 선택해 주세요!")
			return false;
		}
		if (workStatusCd == null || workStatusCd == '') {
			toastr.warning("삭제할 작업지시를 선택해 주세요!")
			return false;
		}
		
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}
		if ( $("#workStatusCd" + workOrdIndex).val() == "B" ){
			$('#deleteWorkOrdCheckUnpublishedPopupModal').modal('show');
		} else if ($("#workStatusCd" + workOrdIndex).val() == "P") {
			$('#deleteWorkOrdCheckPopupModal').modal('show');
			$('#deleteCheckId').attr('disabled',false);
            $('#deleteCheckPassword').attr('disabled',false);
            $('#deleteCheckId').val('');
            $('#deleteCheckPassword').val('');
            $('#btnDeleteCheck').attr('disabled',false);
			$('#btnDeleteWorkOrdCheck').attr('disabled',true);
			$('#searchUser').attr('disabled',false);
			$('#userNm').val('');
		} else {
			toastr.warning('미발행 또는 발행 상태의 작지만 삭제 할 수 있습니다!', '', {timeOut: 5000});
		}
    });

	$('#btnDeleteWorkOrdCheck,#btnDeleteWorkOrdCheckUnpublished').on('click', function() {
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			$('#workOrdCancelPopupModal').modal('hide');
			$('#btnDeleteCheck').attr('disabled',false);
			$('#btnDeleteWorkOrdCheck').attr('disabled',true);
			$('#deleteCheckId').val('');
	        $('#deleteCheckPassword').val('');
			$('#userNm').val('');
			return false;
		}
		updateGubun = '001';
		workOrderStatus("delete");
	});
    
    //작지 시작
	$('#btnStart').on('click', function() {
		if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("작업지시서를 선택해주세요.");
			return false;
		}
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}
		if($("#workStatusCd"+workOrdIndex).val() == "P") {
			workOrderStatus("S");
		} else {
			toastr.warning('발행 상태 작지만 시작 할 수 있습니다!');
		}
    });

    //작지 진행 취소
    $('#btnCancel').on('click', function() {
    	var visionCnt;
    	$.ajax({
	           url: '<c:url value="po/readVisionFaultyAdmList_F2"/>',
	           type: 'GET',
	           async: false,
	           data: {
					'menuAuth'	: 	menuAuth,
	             	'workOrdNo'	:	function() { return workOrdNo; }, 
	           },
			success: function (res) {
				visionCnt = res.data.length ;
			},
		});
		
    	if( visionCnt != 0){
			toastr.warning("비전불량 현황을 확인해주세요!");
			return false;
		}
    	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
    		toastr.warning("작업지시서를 선택해주세요.");
			return false;
		}
		
    	$('#my-spinner').show();
    	
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}

		//생산실적트레이 삭제
		$.ajax({
			url : '<c:url value="po/productionPerfTrayDelete"/>',
			type : 'POST',
			async: false,
			data : {
				'menuAuth'	 		: 		menuAuth,
				'equipCd'			:		function() { return equipCd;	},
            	'workOrdNo'			:		function() { return workOrdNo;	},
            	'deleteGubun'		:		function() { return "002";		}
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					checkWorkOrdStatusTemp = false;
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
					checkWorkOrdStatusTemp = true;
					return false;
				} else {
					toastr.error(res.message);
					checkWorkOrdStatusTemp = true;
					return false;
				}
            },
            complete : function() {}
		});
		//생산실적트레이 삭제
		
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		} else {
			if($("#workStatusCd" + workOrdIndex).val() == "S") {
				$('#workOrdCancelPopupModal').modal('show');
			} else {
				toastr.warning('진행 상태 작지만 취소할 수 있습니다!');
			}	
		}
    });

  	//작지 진행 상태로 변경
    $('#btnReStart').on('click', function() {
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}
		if($("#workStatusCd" + workOrdIndex).val() == "C") {
			$('#workOrdReStartPopupModal').modal('show');
			$('#btnDeleteCheckWorkOrdRestart').attr('disabled',false);
			$('#btnWorkOrdReStartCheck').attr('disabled',true);
			$('#searchWorkOrderChangeUser').attr('disabled',false);
			$('#deleteCheckWorkOrderUserId').attr('disabled',false);
			$('#deleteCheckWorkOrderUserPassword').attr('disabled',false);
			$('#deleteCheckWorkOrderUserId').val('');
	        $('#deleteCheckWorkOrderUserPassword').val('');
			$('#workOrderChangeUserNm').val('');
		} else {
			toastr.warning('생산 완료 상태 작지만 취소할 수 있습니다!');
		}
    });
    
	//작지 진행 취소 확인
	$('#btnWorkOrdCancelCheck').on('click', function() {
    	var visionCnt;
    	$.ajax({
	           url: '<c:url value="po/readVisionFaultyAdmList_F2"/>',
	           type: 'GET',
	           async: false,
	           data: {
					'menuAuth'	: 	menuAuth,
	             	'workOrdNo'	:	function() { return workOrdNo; }, 
	           },
			success: function (res) {
				visionCnt = res.data.length ;
			},
		});
    	if( visionCnt != 0){
			toastr.warning("비전불량 현황을 확인해주세요!");
			return false;
		}

		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			$('#workOrdCancelPopupModal').modal('hide');
			return false;
		}

		//생산실적트레이 삭제 확인
		$.ajax({
			url : '<c:url value="po/productionPerfTrayDelete"/>',
			type : 'POST',
			async: false,
			data : {
				'menuAuth'	 		: 		menuAuth,
				'equipCd'			:		function() { return equipCd;	},
            	'workOrdNo'			:		function() { return workOrdNo;	},
            	'deleteGubun'		:		function() { return "002";		}
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					checkWorkOrdStatusTemp = false;
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
					checkWorkOrdStatusTemp = true;
					return false;
				} else {
					toastr.error(res.message);
					checkWorkOrdStatusTemp = true;
					return false;
				}
            },
            complete : function() {}
		});
		//생산실적트레이 삭제 확인
		
		if(checkWorkOrdStatusTemp){
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			$('#workOrdCancelPopupModal').modal('hide');
			return false;
		} else {
			workOrderStatus("P");
		}
		
	});
	
	let updateGubun;
	//작지 진행 변경
	$('#btnWorkOrdReStartCheck').on('click', function() {
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			$('#workOrdCancelPopupModal').modal('hide');
			$('#btnDeleteCheckWorkOrdRestart').attr('disabled',false);
			$('#btnWorkOrdReStartCheck').attr('disabled',true);
			$('#deleteCheckWorkOrderUserId').val('');
	        $('#deleteCheckWorkOrderUserPassword').val('');
			$('#workOrderChangeUserNm').val('');
			return false;
		}
		updateGubun = '002';
		workOrderStatus("S");
	});
	
	//작지종료 모달 확인 취소
	$('#btnWorkOrdEndCancel').on('click', function() {
		$('#btnWorkOrdEndCancel').modal('hide');
	});

	//작지종료 버튼
	$('#btnEnd').on('click', function() {
		if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("작업지시서를 선택해주세요.");
			return false;
		}
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}
    	if($("#workStatusCd" + workOrdIndex).val() == "S") {
			$('#workOrdEndCheckPopupModal').modal('show');
		} else {
			toastr.warning('진행 상태 작지만 종료 할 수 있습니다!', '', {timeOut: 5000});
		}
    });

	//작지종료 모달 확인
	$('#btnWorkOrdEndCheck').on('click', function() {
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			$('#workOrdEndCheckPopupModal').modal('hide');
			return false;
		}
		workOrderStatus("C");
	});

	//작지 상태 변경
    function workOrderStatus(status) {
    	var workOrdNo = $("#workOrdNo" + workOrdIndex).val();
    	if( $('#deleteWorkOrdCheckPopupModal').hasClass('show') ){
    		userId = $('#deleteCheckId').val();
			userPw = $('#deleteCheckPassword').val();
    	} else if( $('#workOrdReStartPopupModal').hasClass('show') ){
    		userId = $('#deleteCheckWorkOrderUserId').val();
			userPw = $('#deleteCheckWorkOrderUserPassword').val();
        }

    	let trayArrayData;

    	$('#my-spinner').show();
    	if( status == "S" && workStatusCd == "P" ) {
    		$('#my-spinner').before('<div id="trayLodingLabel" style="top: 55vh;font-size: 25px;color: black;background: #ffffffc4;text-align: center;z-index: 10000;position: absolute;left: 50%;transform: translate(-50%, 0%);padding: 0px 50px 0px 50px;"><label>현재 생산 실적 트레이도 생성하고 있습니다.</label><br><label>잠시만 기다려 주세요...( ﾉ ﾟｰﾟ)ﾉ</label></div>');
    		trayArrayData = trayLabelCreateFun(); //생산실적트레이 발행(등록)
    		//console.log(dataSudel);
        } else {
        	$('#my-spinner').before('<div id="trayLodingLabel" style="position: fixed;"></div>');
		}
        
  		$.ajax({
			url: '<c:url value="/po/workOrderUpdateStatus"/>',
			type: 'POST',
			//async: false,
			data: {
				'menuAuth'			:	menuAuth,
				'workOrdNo'			:	workOrdNo,
				'workStatusCd'		:	status,
				'equipCd'			:	function() { return equipCd; },
				//'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return ordDateCal.replace(/-/g, ''); },
  	        	'userNumber'        :   function() { return userNumber; },
  	        	'userId'            :   function() { return userId; },
  	        	'userPw'            :   function() { return userPw; },
  	        	'gubun' 			:   function() { return updateGubun; },
  	        	'arrayData'       	:   function() { return trayArrayData; },
			},
			beforeSend: function() {
			//  $('#btnAddConfirm').addClass('d-none');
			},
			success: function (res) {
				let data = res.data;
				workOrdNo = null;
				if (res.result == 'ok') {
					toastr.success(res.message);
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#workOrderMatrlTable').DataTable().clear().draw();
					matrlIndex = "";
					matrlRowCnt = "";
				} else if (res.result == 'fail') {
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#workOrderMatrlTable').DataTable().clear().draw();
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#workOrderMatrlTable').DataTable().clear().draw();
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				if ( status == 'C' || status == 'P' ){
					$('#btnDeleteWorkOrder').addClass("d-none");
					$('#btnCancel').addClass("d-none");
		        	$('#btnStart').removeClass("d-none");
				}
				//작지 진행취소 성공시 무조건 sideView 닫기
				//if ( status == 'P' ){
					workOrdNo = '';
					workStatusCd = '';
					$('#left-expand').trigger('click');
				//}
					document.getElementById('trayLodingLabel').remove();
					$('#my-spinner').hide();
			}
		});
	}

    function workOrderChargr() {
  		$.ajax({
           url: '<c:url value="/po/workOrderUpdateChargr"/>',
           type: 'POST',
           async: false,
           data: {
				'menuAuth'			:		menuAuth,
				'workOrdNo'			:		workOrdNo,                 
				'mainWorkChargr'	:		$('#mainWorkChargr'+userIdx).val(),
				'subWorkChargr'		:		$('#subWorkChargr'+userIdx).val(),
           },
           beforeSend: function() {
               //  $('#btnAddConfirm').addClass('d-none');
               //  $('#btnAddConfirmLoading').removeClass('d-none');
             },            
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success('담당자가 변경되었습니다.');
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					workOrdNo = null;
					$('#workOrderMatrlTable').DataTable().clear().draw();
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
           complete:function(){
               //$('#btnAddConfirm').removeClass('d-none');
               //$('#btnAddConfirmLoading').addClass('d-none');
			}
		});
    }


  	//등록 btn 클릭 시
	$('#btnSave').on('click', function() {

		if(workOrdIndex != null){
	 		var checkWorkOrdStatusTemp = checkWorkOrdStatus($("#workOrdNo" + workOrdIndex).val(), $("#workStatusCd" + workOrdIndex).val());
			if (checkWorkOrdStatusTemp) {
				workOrdNo		= null;
				workStatusCd	= null;
				workOrdIndex	= null;
				$('#workOrderMatrlTable').DataTable().clear().draw();
				return false;
			}
		} else {
			toastr.warning('작지를 선택해주세요.', '', {timeOut: 5000});
			return false;
		}
  		
  	 	var workStatusCd = $("#workStatusCd" + workOrdIndex).val();
  	 	if(workStatusCd != 'B' && workStatusCd != 'P' && workStatusCd != 'S' && workStatusCd != 'C') {
  	 		toastr.warning('작지 상태가 미발행, 발행 또는 진행중 인 경우와 </br> 당일 이후 작지만 등록 및 수정 가능 합니다.', '', {timeOut: 5000});
  	 		return false;
  	 	}
  	  	
  	 	var goodsCd = $("#goodsCd" + workOrdIndex).val();
        if ( !$.trim(goodsCd) ) {
        	$("#goodsCd" + workOrdIndex).focus();
            toastr.warning('제품(기종)을 선택해 주세요.');
            return false;
        }

        var dealCorpCd = $("#dealCorpCd" + workOrdIndex).val();
        if ( !$.trim(dealCorpCd) ) {
            toastr.warning('거래처를 선택해 주세요.');
            $("#addForm2"+workOrdIndex).focus();
            return false;
        }
        
        //작지상태가 S(진행)에서 자재 추가시 workTeamCd를 가져옴
        if (workStatusCd == 'S' || workStatusCd == 'C'){
			//var workTeamCd = $('#workOrderTable tbody .selected').find('td').eq(8).find('select').val();
			var workTeamCd = $("#oldWorkTeamCd" + workOrdIndex).val();
			//alert($('#workOrderTable tbody .selected').find('td').eq(8).find('select').val());
			if ( !$.trim(workTeamCd) ) {
			//$("#workTeamCd"+workOrdIndex).focus();
			//$('#workOrderTable tbody .selected').find('td').eq(8).find('select').focus();
				toastr.warning('근무조를 선택해 주세요.');
				return false;
			}
		} else {
			var workTeamCd = $("#workTeamCd" + workOrdIndex).val();
	        //alert($('#workOrderTable tbody .selected').find('td').eq(8).find('select').val());
	        //var workTeamCd = $('#workOrderTable tbody .selected').find('td').eq(8).find('select').val()
	        if ( !$.trim(workTeamCd) ) {
	        	$("#workTeamCd"+workOrdIndex).focus();
	        	//$('#workOrderTable tbody .selected').find('td').eq(8).find('select').focus();
	            toastr.warning('근무조를 선택해 주세요.');
	            return false;
	        }
		}

        //var mainWorkChargr = $("#mainWorkChargr" + workOrdIndex).val();
        //if ( !$.trim(mainWorkChargr) ) {
        //	$("#addForm3" + workOrdIndex).focus();
        //    toastr.warning('담당1을 선택해 주세요.');
        //    return false;
        //}
        //var subWorkChargr = $("#subWorkChargr"+workOrdIndex).val();
        equipCondSeq = $("#equipCondSeq" + workOrdIndex).val();
        var ordLotNo = $("#ordLotNo" + workOrdIndex).val();
        var workOrdNo = $("#workOrdNo" + workOrdIndex).val();

        var matrlCnt = $('#workOrderMatrlTable').DataTable().data().count();
        if(matrlCnt < 1) {
        	toastr.warning('자재 바코드를 등록해 주세요.', '', {timeOut: 5000});
            return false;            
        }

        //주,부자재 하나씩 들어갔는지 코드번호로 비교하였지만 코드 앞글자만따서 부,주자재 하나씩만 들어가면 되도록 변경하였음
        //var alnicuMatrlCd = $("#alnicuMatrlCd"+workOrdIndex).val();
        //var filmMatrlCd = $("#filmMatrlCd"+workOrdIndex).val();

        //if(!compareMatrlCd(alnicuMatrlCd)) {
        if(!compareMainMatrlCd()) {
        	toastr.warning('주자재 AL/Nicu을 등록해 주세요.', '', {timeOut: 5000});
        	$('#barcodeNo').focus();
            return false;  
        }

        //if(!compareMatrlCd(filmMatrlCd)) {
        if(!compareSubMatrlCd()) {
        	toastr.warning('부자재 Film을 등록해 주세요.', '', {timeOut: 5000});
        	$('#barcodeNo').focus();
            return false;  
        }        
                      
        var workOrdDtl = new Array();
        
        targetWeight = 0;
        var each_exit = true;
		$('#workOrderMatrlTable tbody tr').each(function() {
			//var rowMatrlData = new Object();
			var rowData = new Object();
		 	var lotNo = $(this).find('td').eq(3).html();
		 	var inspectQty = $(this).find('td').eq(4).html();
		 	var faultyQty = $(this).find('input[name=faultyQty]').val();
			if(workStatusCd == 'S' || workStatusCd == 'C') {
				faultyQty = $(this).find('input[name=faultyQty]').val();
			}

		 	if(faultyQty == null || faultyQty == "" ) {
			 	faultyQty = "0";
		 		$(this).find('input[name=faultyQty]').val(faultyQty);
		 	}

		 	if (faultyQty.indexOf('.') >= 0) {
            	dectext = faultyQty.substring(faultyQty.indexOf('.')+1, faultyQty.length);
	            if (dectext.length > 3)
	            {
	            	//$(this).find('td input').eq(1).val(parseFloat(faultyQty).toFixed(3));
		        	toastr.warning("권취중량은 소수점 셋째 자리까지 입력 가능합니다.");
		        	$(this).find('input[name=faultyQty]').focus();
		        	each_exit = false;
		            return false;
	            }
		 	}
		 	
// 	 		var _pattern2 = /^\d*[.]\d{1}$/;
// 	        if (_pattern2.test(faultyQty)) {
// 	        	toastr.warning("불량중량은 소수점 첫째 자리까지 입력 가능합니다.");
// 	        	each_exit = false;
// 	            return false;
// 	        }

	        if (parseFloat(inspectQty) < parseFloat(faultyQty)) {
	        	toastr.warning("불량중량은 투입중량을  초과할 수 없습니다.");
	        	$(this).find('input[name=faultyQty]').focus();
	        	each_exit = false;
	            return false;
	        }
	        
		 	var fairQty = (parseFloat(inspectQty) - parseFloat(faultyQty)).toFixed(2);
		 	var barcodeNo= $(this).find('td').eq(6).html();
		 	var regDate= $(this).find('td').eq(7).html();
		 	var status= $(this).find('td').eq(8).html();
		 	var connectNm = $(this).find('td').eq(10).html();
		 	var remakeYn = 'N';
		 	
		 	if(status == '재투입') {
		 		remakeYn = "Y";
			}
		 	var connectCd = 'N';
		 	if(connectNm == '연결') {
		 		connectCd = "Y";
			}
		 	var matrlCd= $(this).find("#matrlCd").val();
		 	var matrlCdPrefix = matrlCd.substring(0,1);
		 	if(remakeYn == 'N' && (matrlCdPrefix == 'A' || matrlCdPrefix == 'N')) {
		 		targetWeight = (parseFloat(targetWeight) + parseFloat(inspectQty)).toFixed(3);
			}
			var changeLocation = $(this).find('input[name=changeLocation]').val();
			rowData.menuAuth = menuAuth;
			rowData.equipCd = equipCd;
	        rowData.goodsCd = goodsCd;
	        rowData.dealCorpCd = dealCorpCd;
	        rowData.workTeamCd = workTeamCd;
	        //rowData.mainWorkChargr = mainWorkChargr;
	        //rowData.subWorkChargr = subWorkChargr;
	        rowData.equipCondSeq = equipCondSeq;
	        rowData.ordLotNo = '';
	        //rowData.ordLotNo = ordLotNo;
	        rowData.workOrdNo = workOrdNo;
	        rowData.workStatusCd = workStatusCd;
	        rowData.ordDate = ordDateCal.replace(/-/g, '');
	        rowData.lotNo = lotNo;
	        rowData.barcodeNo = barcodeNo;
	        rowData.remakeYn = remakeYn;
	        rowData.connectCd = connectCd;
	        rowData.inspectQty = inspectQty;
	        rowData.fairQty = fairQty;
	        rowData.faultyQty = faultyQty;
	        rowData.regDate = regDate;
	        rowData.matrlCd = matrlCd; 
	        rowData.targetWeight = targetWeight;
	        rowData.changeLocation = changeLocation;
	        if($(this).find('td').eq(10).html() == '' ||  $(this).find('td').eq(10).html() == '정상'){
	        	 rowData.faultyStatus = "001";
		    } else if($(this).find('td').eq(10).html() == '불량'){
		    	rowData.faultyStatus = "002";
			} else if($(this).find('td').eq(10).html() == '불량재투입'){
				rowData.faultyStatus = "003";
			}
	        workOrdDtl.push(rowData);
		});
		
		if(!each_exit) {
			return false;
		}

		$('#my-spinner').show();
		
 		$.ajax({
			url: '<c:url value="/po/workOrderCreate"/>',
			type: 'POST',
			async: false,
			data: JSON.stringify(workOrdDtl),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",
			beforeSend: function() {
				//  $('#btnAddConfirm').addClass('d-none');
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success('작지가 등록되었습니다.');
					$('#barcodeNo').attr('disabled', true);
					$('#btnDelete').attr('disabled', true);
					$('#btnSave').attr('disabled', true);
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					workOrdNo = null;
					$('#workOrderMatrlTable').DataTable().clear().draw();
					matrlIndex = "";
					matrlRowCnt = "";
				} else if (res.result == 'fail') {
					$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#left-expand').trigger('click');
				$('#my-spinner').hide();
			}
		});
    });
	/* 
	function compareMatrlCd(matrlCd) {
		var result = false;
		$('#workOrderMatrlTable tbody tr').each(function(){
		 	tMatrlCd= $(this).find("#matrlCd").val();
		 	if(matrlCd == tMatrlCd) {
				result = true;
				return result
		 	}	
		});

		return result;
	}
	*/

	function compareMainMatrlCd() {
		var result = false;
		$('#workOrderMatrlTable tbody tr').each(function() {
		 	tMatrlCd= $(this).find("#matrlCd").val().substring(0,1);
		 	if( "N" == tMatrlCd || "A" == tMatrlCd ) {
				result = true;
				//console.log(tMatrlCd);
				return result;
		 	}
		});

		return result;
	}

	function compareSubMatrlCd() {
		var result = false;
		$('#workOrderMatrlTable tbody tr').each(function(){
		 	tMatrlCd= $(this).find("#matrlCd").val().substring(0,1);
		 	if( "F" == tMatrlCd ) {
				result = true;
				//console.log(tMatrlCd);
				return result;
		 	}
		});

		return result;
	}
	
	//제조조건 계획정보 모달 시작
   	var equipCondCommonAdmTable;
   	var equipCondIdx;
   	function selectEquipCondCommonList(idx)
   	{
   		equipCondIdx = idx;
		if(equipCondCommonAdmTable == null || equipCondCommonAdmTable == undefined)	{

			//해당설비 제조조건 계획List 검색
			equipCondCommonAdmTable = $('#equipCondCommonAdmTable').DataTable({
	        language: lang_kor,
	        paging: true,
	        info: true,
	        ordering: true,
	        processing: true,
	        autoWidth: false,
	        lengthChange: false,
	        pageLength: 20,
	        destroy : true,
			ajax : {
					url: '<c:url value="em/manufacturerPlanListRead"/>',
					type: 'GET',
					async: false,
					data: {
						'menuAuth'	 	: 		menuAuth,
						'equipCd'		:		function() { return equipCd; }
					},
				},
				rowId: 'equipCondSeq',
				columns: [
					{ data: 'equipNm' },
					{ data: 'goodsNm' },
					{ data: 'model' },
					{ 
						data: 'condRegDate',
						render: function(data, type, row) {					
							if(data != "") {
								return moment(data).format("YYYY-MM-DD");
							} else {
								return "-";
							} 
						} 
					},
		  		],
		        columnDefs: [
		        	{ "targets": [0,1,2,3],  "className": "text-center"}
		        ],
		  		order: [
		  			[ 1, 'DESC' ],
		  		],
		    });

			$('#equipCondCommonAdmTable tbody').on('click', 'tr', function () {
				data = equipCondCommonAdmTable.row( this ).data();
				//goodsCd = equipCondCommonAdmTable.row( this ).data().goodsCd;
				//goodsNm = equipCondCommonAdmTable.row( this ).data().goodsNm;
				//equipCondSeq = equipCondCommonAdmTable.row( this ).data().equipCondSeq;
				$('#goodsCd' + equipCondIdx).val(data.goodsCd);
				$('#goodsNm' + equipCondIdx).val(data.goodsNm);
				$('#alnicuMatrlCd' + equipCondIdx).val(data.alnicuMatrlCd);
				$('#filmMatrlCd' + equipCondIdx).val(data.filmMatrlCd);				
				$('#equipCondSeq' + equipCondIdx).val(data.equipCondSeq);
				$('#qutyNm' + equipCondIdx).text(data.alniQutyNm);
				$('#surfaceTrtmtNm' + equipCondIdx).text(data.surfaceTrtmtNm);
				$('#model' + equipCondIdx).text(data.model);
				
				var orgLotNo = $('#ordLotNo'+equipCondIdx).val();
				var orgLotQuty = orgLotNo.substring(4,6);
				var selQuty = 'AL';
				if(data.alniQutyNm != 'AL')
				{
					selQuty = 'NC';
				}

				var newOrgLotNo;
				if( orgLotQuty != selQuty )
				{
					newOrgLotNo = orgLotNo.substring(0,4) + selQuty + orgLotNo.substring(6,15);
					$('#ordLotNo'+equipCondIdx).val(newOrgLotNo);
					$('#ordLotNoText'+equipCondIdx).text(newOrgLotNo);
				}	

	        	var matrlText = "[자재코드:" +$('#alnicuMatrlCd'+equipCondIdx).val()+"/"+$('#filmMatrlCd'+equipCondIdx).val()+"]";
	        	$('#matrlCdText').val(matrlText) 				
				$('#equipCondCommonAdmModal').modal('hide');
				
		    });
		}
		else {
			$('#equipCondCommonAdmTable').DataTable().ajax.reload();
		}
		
		$('#equipCondCommonAdmModal').modal('show');
   	}
	//제조조건 계획정보 모달 시작 종료
  	
	//거래처정보조회 팝업 시작
   	var dealCorpPopUpTable;
   	var dealCorpIdx;
   	function selectDealCorp(idx)
   	{
   	   	dealCorpIdx = idx; 
		if(dealCorpPopUpTable == null || dealCorpPopUpTable == undefined)	{
			dealCorpPopUpTable = $('#dealCorpPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/bm/dealCorpDataList"/>',
		            type: 'GET',
		            async: false,
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            	//'dealGubun1'	:		'1',
		            	//'dealGubun2'	:		'1',
		            	//'dealGubun3'	:		'1',
		            	//'dealGubun4'	:		'1',
		            	//'dealGubun5'	:		'1',
		            	//'dealGubun6'	:		'1',
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'dealCorpCd',
		        columns: [
		            { data: 'dealCorpCd' },
		            { data: 'dealCorpNm' },
		            { data: 'initial' },
		            { data: 'presidentNm' },
		            { data: 'country' },
		            { data: 'corpNo' },
		        ],
		        columnDefs: [
	            	{"className": "text-center", "targets": "_all"},
		        ],
		        order: [
		            [ 1, 'asc' ]
		        ],
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ],
		    });

		    $('#dealCorpPopUpTable tbody').on('click', 'tr', function () {
			    
		    	var data = dealCorpPopUpTable.row( this ).data();
				$('#dealCorpCd'+dealCorpIdx).val(data.dealCorpCd);
				$('#dealCorpNm'+dealCorpIdx).val(data.dealCorpNm);
                $('#dealCorpPopUpModal').modal('hide');
		    });
		} else{
			$('#dealCorpPopUpTable').DataTable().ajax.reload();
		}
		
		$('#dealCorpPopUpModal').modal('show');		
   	}   	
 	//거래처정보조회 팝업 종료    
  	
   	//담당자조회 팝업 시작
   	//var userPopUpTable;
   	var userFlag;
   	var userIdx;
   	function selectWorkCharger(flag, idx)
   	{
   		userFlag = flag;
   		userIdx = idx;
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            async: false,
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		            /*
		            success : function(res) {
		                console.log(res);
		            }
		            */
		        },
		        rowId: 'userNumber',
		        columns: [
						{ data : 'userNm'}, 
						{ data : 'departmentNm'	}, 
						{ data : 'postNm' }, 
						{ data : 'chargrDutyNm'	}, 
						{ data : 'teamNm' }, 
						{ data : 'workplaceNm' },
		        ],
		        columnDefs: [
		        	//{ "targets": [0], "visible" : true },
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],
		        order: [
		            [ 0, 'desc' ]
		        ],
		        buttons: [
		            
		        ],
				//검색 조건 자동설정
		        oSearch: {"sSearch": userNm}
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
		    	//담당1
				if(userFlag == 'main') {
	                $('#mainWorkChargr'+userIdx).val(data.userNumber);
	                $('#mainWorkChargrNm'+userIdx).val(data.userNm);
				//담당2
				} else {
	                $('#subWorkChargr'+userIdx).val(data.userNumber);
	                $('#subWorkChargrNm'+userIdx).val(data.userNm);
				}
                //진행,완료 상태일 경우 담당 자동저장
                if ( workStatusCd == "S" || workStatusCd == "C" ) {
                	workOrderChargr();
                }
                
                $('#userPopUpModal').modal('hide');
		    });
		} else {
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		
		$('#userPopUpModal').modal('show');
			
   	}
  	//담당자조회 팝업 종료
  	
  	//인쇄(엑셀 다운) 대상 OrdLotNo목록
  	let workOrdSubOrdLotNoTable = $('#workOrdSubOrdLotNoTable').DataTable({
		language: lang_kor,
		lengthChange : false,
		paging: true,
		info: true,
		ordering: false,
		processing: false,
		autoWidth: false,
		pageLength: 15,
		ajax: {
			url: '<c:url value="/po/workOrdExcelDownOrdLotNoList"/>',
			type: 'get',
			async: false,
			data: {
				'workOrdNo'	:	function(){ return workOrdNo; },
			},
		},
		columns: [
			{ data: 'lotNo' },
			{ data: 'workOrdLotNo' },
			{ data: 'ordLotNo',
				render: function(data, type, row) {
					var html = '';
					if( row['gubun'] == 'D') {
						html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					} else if( row['gubun'] == 'N') {
						html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
					}
					return html;
				}
			},
			{ data: 'workOrdDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			},
			{ data: 'outputWeight',
		   		render: function(data, type, row) {
		   			return parseFloat(data).toFixed(3);
		   		}
            },
			{ data: 'outputCnt' },
			{ data: 'visionEdgeWeight',
		   		render: function(data, type, row) {
		   			return '<p style="color:orange;margin-bottom: 0px;">' + parseFloat(data).toFixed(3) + '</p>';
		   		}
            },
            { data: 'visionEdgeCnt',
		   		render: function(data, type, row) {
		   			return '<p style="color:orange;margin-bottom: 0px;">' + data + '</p>';
		   		}
            },
            { data: 'totalWeight',
		   		render: function(data, type, row) {
		   			return parseFloat(data).toFixed(3);
		   		}
            },
			{ data: 'totalCnt' },
			{ data: 'userNm'},			
			//{ data: 'gubunNm',
			//	render: function(data, type, row) {
			//		var html = '';
			//		if( row['gubun'] == 'D') {
			//			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
			//		} else if( row['gubun'] == 'N') {
			//			html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + data + '</p>';
			//		}
			//		return html;
			//	}
			//},
			{ data: 'subWorkStatusNm' },
		],
		columnDefs: [
			{ targets: [0,1,2,3,10,11], className: 'text-center' },
			{ targets: [4,5,6,7,8,9], className: 'text-right' },
			{ targets: [4,5,6,7,8,9], render: $.fn.dataTable.render.number( ',' ) },
		],
		order: [
			[ 3, 'asc' ],
		],
		rowsGroup: [ [0], [1] ],
		buttons: [
		    'copy', 'excel', 'print'
		],
		drawCallback: function( settings ) {
			$('#workOrdSubOrdLotNoTable tbody tr td').css('height','30px');
			//전역변수들
			let excelSumOutputKg = $('#workOrdSubOrdLotNoTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let excelSumOutputCnt = $('#workOrdSubOrdLotNoTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let excelSumVisionKg = $('#workOrdSubOrdLotNoTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let excelSumVisionCnt = $('#workOrdSubOrdLotNoTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let excelTotalOutputKg = excelSumOutputKg + excelSumVisionKg;
			let excelTotalOutputCnt = excelSumOutputCnt + excelSumVisionCnt;
			$('#excelSumOutputKg').html(excelSumOutputKg.toFixed(3));
			$('#excelSumOutputCnt').html(addCommas(excelSumOutputCnt));
			$('#excelSumVisionKg').html(excelSumVisionKg.toFixed(3));
			$('#excelSumVisionCnt').html(addCommas(excelSumVisionCnt));
			$('#excelTotalOutputKg').html(excelTotalOutputKg.toFixed(3));
			$('#excelTotalOutputCnt').html(addCommas(excelTotalOutputCnt));
			
		},
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
        //rowCallback: function (row, data) {
        //	$('#workOrdSubOrdLotNoTable').rowspan(0);
		//	$('#workOrdSubOrdLotNoTable').rowspan(1);
        //},
    });

	$('#workOrdSubOrdLotNoTable tbody').on('click', 'tr', function () {
		//스캔 barcode가  부자재이면 기존selected 해제 후 스캔 barcode selectd
		if ($(this).hasClass('selected')) {
            //$(this).removeClass('selected');
        } else {
            $('#workOrdSubOrdLotNoTable').DataTable().$('td.selected').removeClass('selected');
            for (var i=0; i<=1; i++) {
    		//for (var i=2; i<=11; i++) {
    			$(this).find('td').eq(i).addClass('selected');
    		}
    		workOrdLotNo = workOrdSubOrdLotNoTable.row(this).data().workOrdLotNo;
            //workOrdSubOrdLotNo = workOrdSubOrdLotNoTable.row(this).data().ordLotNo;
            workOrdSubLotNo = workOrdSubOrdLotNoTable.row(this).data().lotNo;
		}
    });
    
  	$('#btnPrintCheck').on('click', function() {
  	  	if (workOrdNo == null) {
  	  	  	toastr.warning("인쇄(엑셀 다운)할 작업지시를 선택해주세요!");
  	  	  	return false;
  	  	}
		if (workStatusCd == "B") {
  	  	  	toastr.warning("미발행 작업지시는 인쇄(엑셀 다운)할 수 없습니다!");
  	  	  	return false;
  	  	}
		if (workStatusCd == "P") {
  	  	  	toastr.warning("발행 작업지시는 인쇄(엑셀 다운)할 수 없습니다!");
  	  	  	return false;
  	  	}
		if (workOrdLotNo == null || workOrdLotNo == '') {
  	  	  	toastr.warning("인쇄할 생산LotNo를 선택해 주세요!");
  	  	  	return false;
  	  	}
		
		//var tempCount = 0;
		////선택한 행이 있는지 확인
		//$('#workOrdSubOrdLotNoTable tbody tr').each(function(){
		//	var tr = $(this);
		//	var td = tr.children();
		//	console.log(td.eq(1).hasClass('selected'));
		//	if (td.eq(0).hasClass('selected')) {
		//		tempCount++;
		//	}
		//});
		////선택한 행이 있는지 확인
		//if (tempCount == 0) {
  	  	//  	toastr.warning("인쇄할 생산LotNo를 선택해 주세요!<br>생산 전표번호는 선택 하실 수 없습니다!");
  	  	//  	return false;
  	  	//}
  	  	
		//if (workOrdSubOrdLotNo == null || workOrdSubOrdLotNo == '') {
  	  	//  	toastr.warning("인쇄할 생산전표번호를 선택해 주세요!");
  	  	//  	return false;
  	  	//}
		if (workOrdSubLotNo == null || workOrdSubLotNo == '') {
			toastr.warning("인쇄할 LotNo를 선택해주세요!");
  	  	  	return false;
  	  	}
  	  	
        $.ajax({
	        url: '<c:url value="/po/workOrdExcelDown"/>',
	        type: 'GET',
	        //async: false,
	        datatype: 'json',
	        data:  {
	        	'menuAuth'	 			: 	menuAuth,
	        	'equipCd'		 	: 	function() { return equipCd; },
		        'alnicuMatrlCd'			: 	$('#alnicuMatrlCd' + workOrdIndex).val(),
				'filmMatrlCd'			: 	$('#filmMatrlCd' + workOrdIndex).val(),
				'equipCondSeq'			: 	$('#equipCondSeq' + workOrdIndex).val(),
				//'ordLotNo'				:	$('#ordLotNo' + workOrdIndex).val(),
				'workOrdNo' 			: 	$('#workOrdNo' + workOrdIndex).val(),
				'workStatusCd' 			: 	$('#workStatusCd' + workOrdIndex).val(),
				'goodsCd'				: 	$('#goodsCd' + workOrdIndex).val(),
				'goodsNm'				: 	$('#goodsNm' + workOrdIndex).val(),
				'qutyNm'				: 	$('#qutyNm' + workOrdIndex).text(),
				'model'					: 	$('#model' + workOrdIndex).text(),
				'surfaceTrtmtNm'		: 	$('#surfaceTrtmtNm' + workOrdIndex).text(),
				'dealCorpCd' 			:	$('#dealCorpCd' + workOrdIndex).val(),
				'dealCorpNm' 			:	$('#dealCorpNm' + workOrdIndex).val(),
				'workTeamCd' 			: 	$('#workTeamCd' + workOrdIndex).val(),
				'mainWorkChargr' 		: 	$('#mainWorkChargr' + workOrdIndex).val(),
				'mainWorkChargrNm'		: 	$('#mainWorkChargrNm' + workOrdIndex).val(),
				'subWorkChargr' 		: 	$('#subWorkChargr' + workOrdIndex).val(),
				'subWorkChargrNm' 		: 	$('#subWorkChargrNm' + workOrdIndex).val(),
				'workOrdLotNo'		 	: 	function() { return workOrdLotNo; },
				//'workOrdSubOrdLotNo' 	: 	function() { return workOrdSubOrdLotNo; },
				'workOrdSubLotNo' 		: 	function() { return workOrdSubLotNo; },
			},
			beforeSend: function() {
				$('#my-spinner').show();
			},
			success: function (res) {
				if (res.result == 'ok') {
					//서버 파일까지 삭제하고싶은데 완료됬다는걸 어떻게봑인하지
					//location.href = '<c:url value="/po/workOrdExcelDownload?id="/>' + workOrdSubOrdLotNo;
					location.href = '<c:url value="/po/workOrdExcelDownload?id="/>' + workOrdLotNo;
					
				} else if (res.result == 'fail') {
					toastr.error(res.message);
				} else {
					toastr.error("오류가 발생하였습니다. - excel/print-001");
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
	});
  	
  	$('#btnPrint').on('click', function() {
  	  	if( workOrdNo == null){
  	  	  	toastr.warning("인쇄(엑셀 다운)할 작업지시를 선택해주세요!");
  	  	  	return false;
  	  	}
		if( workStatusCd == "B"){
  	  	  	toastr.warning("미발행 작업지시는 인쇄(엑셀 다운)할 수 없습니다!");
  	  	  	return false;
  	  	}
		if( workStatusCd == "P"){
  	  	  	toastr.warning("발행 작업지시는 인쇄(엑셀 다운)할 수 없습니다!");
  	  	  	return false;
  	  	}
		workOrdLotNo = null;
		workOrdSubOrdLotNo = null;
  		$('#workOrdSubOrdLotNoTable').DataTable().ajax.reload( function () {});
  		$('#workOrdNoTitle').html(workOrdNo);
  		$('#workOrdSubOrdLotNoModal').modal('show');
	});

   	function uiProc(flag)
   	{
        $("#barcodeNo").attr("disabled", flag);
        $("#btnDelete").attr("disabled", flag);
        $("#btnSave").attr("disabled", flag);
        //$("#btnAddWorkOrder").attr("disabled", flag);
        //$("#btnDeleteWorkOrder").attr("disabled", flag);
        $("#barcodeNo").val("");
        $(".workOrderMatrlInput").attr("disabled", flag);
   	}

   	function uiProcFlag(sDate, status)
   	{
   	   	var sFlag = "";
   		//if(sDate.replace(/-/g, '') < sToday.replace(/-/g, '')) {
   		if(sDate.replace(/-/g, '') < yesterday.replace(/-/g, '')) {	
   			sFlag = "disabled";
   	   	} else if(status != "B" && status != "P") {
   	   		sFlag = "disabled";
   	   	}

   	   	return	sFlag;
   	}

   	function uiProcFlag2(sDate, status)
   	{
   	   	var sFlag = "";
   		//if(sDate.replace(/-/g, '') < sToday.replace(/-/g, '')) {
   		if(sDate.replace(/-/g, '') < yesterday.replace(/-/g, '')) {	
   			sFlag = "disabled";
   	   	} else if(status != "B" && status != "P" && status != "S" && status != "C") {
   	   		sFlag = "disabled";
   	   	}
   	   	
   	   	if(status == "S") {
   	   		sFlag = "";
   	   	}

   	   	return	sFlag;
   	}

	//담당1, 담당2 버튼 활성화&비활성화
   	function uiProcFlag3(sDate, status)
   	{
   	   	var sFlag = "";
   		//if(sDate.replace(/-/g, '') < sToday.replace(/-/g, '')) {
   		if(sDate.replace(/-/g, '') < yesterday.replace(/-/g, '')) {	
   			sFlag = "disabled";
   	   	} else if(status != "B" && status != "P" && status != "S" && status != "C") {
   	   		sFlag = "disabled";
   	   	}

   	   	return	sFlag;
   	}
   	
	//자재투입내역 중복검사
	function compareBarcodeNo(barcodeNo) {
	    var result = true;
	    if('F' == barcodeNo.substring(0,1)){
	    	return result;
	    }
	    $('#workOrderMatrlTable tbody tr').each(function(){
			var tbarcodeNo= $(this).find('td').eq(6).html();			
			if(barcodeNo == tbarcodeNo) {  
				result = false;
				return result;
			}
						
		});
		
	    return result;
	}

	//1작지 1주자재 투입여부 확인
	function compareMetalLotNo(barcodeNo) {
	    var result = false;
	    $('#workOrderMatrlTable tbody tr').each(function(){
			var baseCdAbbr = $(this).find('td input[type=hidden]').val();
// 			console.log(baseCdAbbr);
			if (baseCdAbbr != null && baseCdAbbr != '') {
				baseCdAbbr = baseCdAbbr.substring(0,1);
				if (baseCdAbbr == 'A' || baseCdAbbr == 'N') {
					result = true;
					return result;
				/* 	if($(this).find('td').eq(10).html() != '불량'){				
						result = true;
						return result;
					}	 */
				}
			}
		});
		
	    return result;
	}
	
	//rightList 닫기 버튼
	$('#left-expand').on('click', function(){
		$('#workOrderTableCard').removeClass('d-none');		//작업지시
		$('#equipSizeCondStepCard').addClass('d-none');		//불량 등록 입력
		$('#equipDowntimeTableCard').addClass("d-none");	//비가동사유 입력
		//$('#btnWorkOrdConnect').addClass('d-none');		//작지연결 숨김
		$('#leftList').removeClass("d-none");				//오른쪽 버튼 모음
		$('#btnWorkOrdRetv').removeClass("d-none");
		
  	  	$("#leftList").animate({
			width : "13%"
		}, 0);
		$("#middleList").animate({
			width : "77%"
		}, 0);
		$("#rightList").animate({
			width : "9.5%"
		}, 0, function(){
			$('#leftList').removeClass("d-none");				//설비리스트
			$("#leftList").css("display", true);
			$('#closeLeftView').addClass("d-none");				//오른쪽 화면 닫기 버튼
			$('#btnCard').removeClass("d-none");				//오른쪽 버튼 공간
			$('.btnRight').removeClass("d-none");				//오른쪽 버튼 모음
			$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
			$('#outPutCard').addClass("d-none");				//생산실적 입력
			$('#faultyCard').addClass("d-none");				//생산실적 입력
			$('#downtimeCard').addClass("d-none");				//비가동사유 입력
			$('#visionFaultyCard').addClass("d-none");			//비전불량 현황

			$('#downtimeCard').addClass("d-none");				//비가동사유 입력
			$('#notRunningCard').addClass("d-none");			//비가동사유 입력
			$('#btnNotRunning_start').removeClass('d-none');	//비가동 시작 버튼
			$('#btnNotRunning_end').removeClass('d-none');		//비가동 종료 버튼
			
			//$('#btnWorkOrdConnect').addClass("d-none");		//작지 연결
			$('#btnAddWorkOrder').removeClass('d-none');		//작지 추가 버튼
			$('#btnDeleteWorkOrder').removeClass('d-none');		//작지 삭제 버튼
			if (workStatusCd == "S") {
				$('#btnCancel').removeClass('d-none');
				$('#btnStart').addClass('d-none');
			} else {
				$('#btnCancel').addClass('d-none');
				$('#btnStart').removeClass('d-none');
			}

			if ( workStatusCd != 'C'){
				$('#btnEnd').removeClass('d-none');
				$('#btnReStart').addClass("d-none");
			} else {
				$('#btnEnd').addClass('d-none');
				$('#btnReStart').removeClass('d-none');
			}
			
		});
		//console.log(mainView);
		//if(mainView != "workOrder" && mainView != "faulty" && mainView != "downtime") {
		//	workOrdNo = null;
		//	ordGubunCd = null;
		//	ordDateCal =  $('#ordDate').val();
		//	$('#ordGubunCd').val("");
		//	//$('#workOrderTable').DataTable().ajax.reload( function () {});
		//}
		
		if(uiProcFlag2(ordDateCal ,workStatusCd) == "") {
			uiProc(false);
		} else {
			uiProc(true);
		}
		//if (workStatusCd == 'S' || workStatusCd == 'C'){
		//	uiProc(false);
		//} else {
		//	uiProc(true);
		//}
		
		btnFirstStep = false;
		btnSecondStep = false;
		sideView = null;
		mainView = "workOrder";
		ordLotNo = null;
		ordLotNoStepCd = null;
		$('#btnOrdLotNoSecondStep').addClass("d-none");
		$('#btnOrdLotNoFristStep').addClass("d-none");
		//mainMatrlLotNo = null;
		//mainMatrlCd = null;
		//$('#ordGubunCd').val(tempDowntimeOrdGubunCd);
		//ordGubunCd = tempDowntimeOrdGubunCd;
		$('#equipFaultyTableCard').addClass("d-none");		//불량통계
		$('#workSearchCond').removeClass("d-none");			//작업지시 검색조건
		$('#showMenu').removeClass("d-none");
		tempTargetCnt = 0;	//생산실적 목표수량 계산 초기화
		$('#ordDateDiv').removeClass('d-none');
		$('#faultyRegDateDiv').addClass('d-none');
	});

	//초,중,종물 재조회
	$('#btnStepReload').on('click', function(){
		agtTempDataRead(); // 에이젼트 온도 데이터 읽기
		agtTempCondRead(); // 에이전트 온도 조건 읽기
		agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
		agtSizeCondRead(); // 에이전트 치수 조건 읽기

		$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
	});

	var btnFirstStep = false;
	var btnSecondStep = false;
	
	//초물 입력 버튼
	$('#btnFirstStep').on('click', function() {
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning("초물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (subWorkStatusCd != "S" && subWorkStatusCd != "C") {
			if(ordLotNoStepCd == '001') {
				toastr.warning("생산완료된 생산실적만 초물을 입력 할 수 있습니다!");
			} else if(ordLotNoStepCd == '002') {
				toastr.warning("생산완료된 생산실적만 중물을 입력 할 수 있습니다!");
			}
			return false;
		}
		
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}
		
		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		} else {
	  	  	if (workStatusCd == "B") {
	  	  	  	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 초물을 입력 할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			
	  	  	$("#leftList").animate({
				width : "0%"
			}, 0, function(){
				setTimeout(function() {
					$('#leftList').addClass("d-none");				//오른쪽 버튼 모음
					//$("#leftList").css("display","");
				}, 150);
			});
			$("#middleList").animate({
				width : "65%"
			}, 0);
			$("#rightList").animate({
				width : "34.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				$('#equipSizeCondStepCard').removeClass("d-none");	//초,중물 입력
				$('#outPutCard').addClass("d-none");				//생산실적 입력
				$('#faultyCard').addClass("d-none");				//생산실적 입력
				$('#btnStepReload').removeClass('d-none');			//초,중,종물 재조회 버튼
				$('#btnFirstStepInsert').removeClass('d-none');		//초물 등록 버튼
				$('#btnSecondStepInsert').addClass('d-none');		//중물 등록 버튼
				$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
				$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
			});
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);
			uiProc(true);
			
			sideView = "firstStep";
			stepViewClear();
			$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
			btnFirstStep = true;
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
		}
	});
	
	//중물 입력 버튼
	$('#btnSecondStep').on('click', function() {
		if (workOrdNo == null) {
			toastr.warning("중물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}

		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		
		} else {
	  	  	if (workStatusCd == "B") {
	  	  	  	toastr.warning("미발행 작업지시는 중물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 중물을 입력 할 수 없습니다!");
	  	  	  	return false;
	  	  	}
	  	  	
	  	  	$("#leftList").animate({
				width : "0%"
			}, 0, function(){
				setTimeout(function() {
					$('#leftList').addClass("d-none");				//오른쪽 버튼 모음
					//$("#leftList").css("display","");
				}, 150);
			});
			$("#middleList").animate({
				width : "65%"
			}, 0);
			$("#rightList").animate({
				width : "34.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				$('#equipSizeCondStepCard').removeClass("d-none");	//초,중물 입력
				$('#outPutCard').addClass("d-none");				//생산실적 입력
				$('#faultyCard').addClass("d-none");				//생산실적 입력
				$('#btnStepReload').removeClass('d-none');			//초,중,종물 재조회 버튼
				$('#btnFirstStepInsert').addClass('d-none');		//초물 등록 버튼
				$('#btnSecondStepInsert').removeClass('d-none');	//중물 등록 버튼
				$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
				$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
			});
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);
			uiProc(true);
			
			sideView = "secondStep";
			stepViewClear();
			$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
			btnSecondStep = true;
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
		}
	});

	//생산 전표번호당 초물입력btn
	$('#btnOrdLotNoFristStep').on('click', function() {
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning("초물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("초물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (outputCardTableIndex == null) {
			toastr.warning("초물을 확인할 생산전표번호를 선택해 주세요!");
			return false;
		}
		if (outputCardTableIndex != 0) {
			toastr.warning("해당 자재의 첫번째 생산전표번호만 초물을 확인 하실 수 있습니다!");
			return false;
		}
		if (ordLotNo == null || ordLotNo == '' || ordLotNoStepCd == null || ordLotNoStepCd == '') {
			toastr.warning("초물을 확인할 생산전표번호를 선택해 주세요!");
			return false;
		}
		
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}
		
		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		} else {
	  	  	if (workStatusCd == "B") {
	  	  	  	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 초물을 입력 할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			//$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
			//$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
			//$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
			//$('#equipSizeCondStepCard').removeClass("d-none");	//초,중물 입력
			//$('#outPutCard').addClass("d-none");				//생산실적 입력
			//$('#faultyCard').addClass("d-none");				//생산실적 입력
			$('#btnStepReload').removeClass('d-none');			//초,중,종물 재조회 버튼
			$('#btnFirstStepInsert').removeClass('d-none');		//초물 등록 버튼
			$('#btnSecondStepInsert').addClass('d-none');		//중물 등록 버튼
			//$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
			//$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
			
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);
			uiProc(true);
			
			stepViewClear();
			btnFirstStep = true;

			$('#ordLotNoStepTitle').text(ordLotNo + ' / 초물');
			
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기*
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
			
			$('#ordLotNoStepModal').modal({backdrop: 'static'});
			$('#ordLotNoStepModal').modal('show');
		}
	});
	
	//생산 전표번호당 중물입력btn
	$('#btnOrdLotNoSecondStep').on('click', function() {
		if (workOrdNo == null) {
			toastr.warning("중물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("중물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}
		if (outputCardTableIndex == null) {
			toastr.warning("중물을 확인할 생산전표번호를 선택해 주세요!");
			return false;
		}
		if (outputCardTableIndex == 0) {
			toastr.warning("중물은 두번째 생산전표번호부터 확인 하실 수 있습니다!");
			return false;
		}
		if (ordLotNo == null || ordLotNo == '' || ordLotNoStepCd == null || ordLotNoStepCd == '') {
			toastr.warning("중물을 확인할 생산전표번호를 선택해 주세요!");
			return false;
		}
		
		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		
		} else {
	  	  	if (workStatusCd == "B") {
	  	  	  	toastr.warning("미발행 작업지시는 중물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 중물을 입력 할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			//$('#closeLeftView').removeClass("d-none");		//오른쪽 화면 닫기 버튼
			//$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
			//$('.btnRight').addClass("d-none");				//오른쪽 버튼 모음
			//$('#equipSizeCondStepCard').removeClass("d-none");//초,중물 입력
			//$('#outPutCard').addClass("d-none");				//생산실적 입력
			//$('#faultyCard').addClass("d-none");				//생산실적 입력
			$('#btnStepReload').removeClass('d-none');			//초,중,종물 재조회 버튼
			$('#btnFirstStepInsert').addClass('d-none');		//초물 등록 버튼
			$('#btnSecondStepInsert').removeClass('d-none');	//중물 등록 버튼
			//$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
			//$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
			
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);
			uiProc(true);
			
			stepViewClear();
			btnSecondStep = true;
			$('#ordLotNoStepTitle').text(ordLotNo + ' / 중물');
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
			$('#ordLotNoStepModal').modal({backdrop: 'static'});
			$('#ordLotNoStepModal').modal('show');
		}
	});
	
	//초중종물 버튼별 활성화 함수
	function selectStepBtn(step) {
		if(step == 'firstStep') {
			$('.firstStep').attr('disabled',false);
			$('.secondStep').attr('disabled',true);
			$('.thridStep').attr('disabled',true);
		} else if(step == 'secondStep') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',false);
			$('.thridStep').attr('disabled',true);
		} else if(step == 'thirdStep') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',true);
			$('.thridStep').attr('disabled',false);
		} else {
			//console.log('??');
		}
	}

	//초중종물 수정 버튼 click
	$('#btnStepEdit').on('click',function() {
		//selectStepBtn(sideView);
		if (ordLotNoStepCd == '001') {
			$('.firstStep').attr('disabled',false);
			$('.secondStep').attr('disabled',true);
			$('.thridStep').attr('disabled',true);
		} else if (ordLotNoStepCd == '002') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',false);
			$('.thridStep').attr('disabled',true);
		} else if (ordLotNoStepCd == '003') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',true);
			$('.thridStep').attr('disabled',false);
		} else {
			//console.log('??');
		}
		$('#btnStepSave').attr('disabled',false);
	});
	
	//초중종물 등록 버튼 click
	$('#btnFirstStepInsert, #btnSecondStepInsert').on('click',function() {
		var stepCd = '';
		if (sideView == 'firstStep') {
			stepCd = '001';
		} else {
			stepCd = '002'
		}
		
		$('#my-spinner').show();

		//DGS Redis사용
		$.ajax({
			url: '<c:url value="po/workOrderStepInsertRedis_DB0"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	:	menuAuth,
				'workOrdNo'		:	function() { return workOrdNo; },
				'ordLotNo'		:	function() { return ordLotNo; },
				'equipCd'		:	function() { return equipCd; },
				'lotNo'			:	function() { return mainMatrlLotNo; },
				'stepCd'		:	function() { return ordLotNoStepCd; },//function() { return stepCd; },
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success(res.message, '', {timeOut: 5000});
					$('#btnStepReload').trigger('click');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#btnStepReload').trigger('click');
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				$('#my-spinner').hide();
			}
		});
	});

	  //초물 삭제 버튼
    $('#btnStepDelete').on('click', function() {    	
    	var stepCd = '';
		if (sideView == 'firstStep') {
			stepCd = '001';
		} else {
			stepCd = '002'
		}
		$('#deleteStepPopupModal').modal({backdrop: 'static'});
    	$('#deleteStepPopupModal').modal('show');
    });

   //초물 삭제 확인
    $('#deleteStepCheck').on('click', function() {    

//     	$('#my-spinner').show();

    	var stepCd = '';
		if (sideView == 'firstStep') {
			stepCd = '001';
		} else {
			stepCd = '002'
		}
		$.ajax({
			url: '<c:url value="po/agtFirstDelete"/>',
			type: 'POST',
			async: false,
			data: {
   	        	'menuAuth'	 	:	menuAuth,
	   	        'workOrdNo'		:	function() { return workOrdNo; },
	   	     	'ordLotNo'		:	function() { return ordLotNo; },
	   	     	'ifEquipCd'		:	function() { return equipNm; },
	   	     	'lotNo'			:	function() { return mainMatrlLotNo; },
	   	        'stepCd'		:	function() { return ordLotNoStepCd; },//function() { return stepCd; },
   	        },
//    	     	beforesend: function(){
//    	     		$('#my-spinner').show();
//   	   	    },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//if (sideView == 'firstStep') {
					if (ordLotNoStepCd == '001') {
	   	        		$('#firstWarmupCond').val("0");
	   					$('#firstFitup1UpCond').val("0");
	   					$('#firstFitup1DownCond').val("0");
	   					$('#firstFitup2UpleftCond').val("0");
	   					$('#firstFitup2DownleftCond').val("0");
	   					$('#firstFitup2UprightCond').val("0");
	   					$('#firstFitup2DownrightCond').val("0");
	   					$('#firstRollheatUpCond').val("0");
	   					$('#firstRollheatDownCond').val("0");
	   					$('#firstFirstUpleftCond').val("0");
	   					$('#firstFirstDownleftCond').val("0");
	   					$('#firstFirstUprightCond').val("0");
	   					$('#firstFirstDownrightCond').val("0");
	   					$('#firstPush1UpCond').val("0");
	   					$('#firstPush1DownCond').val("0");
	   					$('#firstFirstUpleftCond').val("0");
	   					$('#firstSecondUpleftCond').val("0");
	   					$('#firstSecondDownleftCond').val("0");
	   					$('#firstSecondUprightCond').val("0");
	   					$('#firstSecondDownrightCond').val("0");
	   					$('#firstThirdUpleftCond').val("0");
	   					$('#firstThirdDownleftCond').val("0");
	   					$('#firstThirdUprightCond').val("0");
	   					$('#firstThirdDownrightCond').val("0");
	   					$('#firstJinjeop1UpCond').val("0");
	   					$('#firstJinjeop1DownCond').val("0");
	   					$('#firstJinjeop2UpCond').val("0");
	   					$('#firstJinjeop2DownCond').val("0");


	   					$('#firstWpLeftAlwnce').val("0");
	   					$('#firstWpRightAlwnce').val("0");
	   					$('#firstPitchLeftAlwnce').val("0");
	   					$('#firstPitchRightAlwnce').val("0");
	   					$('#firstPpfWingLeftAlwnce').val("0");
	   					$('#firstPpfWingRightAlwnce').val("0");
	   					$('#firstPpfDepthLeftAlwnce').val("0");
	   					$('#firstPpfDepthRightAlwnce').val("0");
	   					$('#firstFilmAlwnce').val("0");
	   					$('#firstMetalDepthAlwnce').val("0");
	   					$('#firstMetalThicknessAlwnce').val("0");
	   					$('#firstThCenterAlwnce').val("0");
	   					$('#firstThEdgeAlwncePlus').val("0");
	   					$('#firstBurrMetalAlwnce').val("0");
	   					$('#firstBurrRcutAlwnce').val("0");
	   					//$('#firstBurrRedgeAlwnce').val("0");
	   					$('#firstBulgeLeftupHeight').val("0");
	   					$('#firstBulgeLeftdownHeight').val("0");
	   					$('#firstBulgeRightupHeight').val("0");
	   					$('#firstBulgeRightdownHeight').val("0");
	   					$('#firstBulgeLeftupWidth').val("0");
	   					$('#firstBulgeLeftdownWidth').val("0");
	   					$('#firstBulgeRightupWidth').val("0");
	   					$('#firstBulgeRightdownWidth').val("0");

	   					$('#btnFirstStepInsert').attr("disabled",false);
	   				
		   	 		} else {
	   	        		$('#secondWarmupCond').val("0");
	   					$('#secondFitup1UpCond').val("0");
	   					$('#secondFitup1DownCond').val("0");
	   					$('#secondFitup2UpleftCond').val("0");
	   					$('#secondFitup2DownleftCond').val("0");
	   					$('#secondFitup2UprightCond').val("0");
	   					$('#secondFitup2DownrightCond').val("0");
	   					$('#secondRollheatUpCond').val("0");
	   					$('#secondRollheatDownCond').val("0");
	   					$('#secondFirstUpleftCond').val("0");
	   					$('#secondFirstDownleftCond').val("0");
	   					$('#secondFirstUprightCond').val("0");
	   					$('#secondFirstDownrightCond').val("0");
	   					$('#secondPush1UpCond').val("0");
	   					$('#secondPush1DownCond').val("0");
	   					$('#secondFirstUpleftCond').val("0");
	   					$('#secondSecondUpleftCond').val("0");
	   					$('#secondSecondDownleftCond').val("0");
	   					$('#secondSecondUprightCond').val("0");
	   					$('#secondSecondDownrightCond').val("0");
	   					$('#secondThirdUpleftCond').val("0");
	   					$('#secondThirdDownleftCond').val("0");
	   					$('#secondThirdUprightCond').val("0");
	   					$('#secondThirdDownrightCond').val("0");
	   					$('#secondJinjeop1UpCond').val("0");
	   					$('#secondJinjeop1DownCond').val("0");
	   					$('#secondJinjeop2UpCond').val("0");
	   					$('#secondJinjeop2DownCond').val("0");

	   					$('#secondWpLeftAlwnce').val("0");
	   					$('#secondWpRightAlwnce').val("0");
	   					$('#secondPitchLeftAlwnce').val("0");
	   					$('#secondPitchRightAlwnce').val("0");
	   					$('#secondPpfWingLeftAlwnce').val("0");
	   					$('#secondPpfWingRightAlwnce').val("0");
	   					$('#secondPpfDepthLeftAlwnce').val("0");
	   					$('#secondPpfDepthRightAlwnce').val("0");
	   					$('#secondFilmAlwnce').val("0");
	   					$('#secondMetalDepthAlwnce').val("0");
	   					$('#secondMetalThicknessAlwnce').val("0");
	   					$('#secondThCenterAlwnce').val("0");
	   					$('#secondThEdgeAlwncePlus').val("0");
	   					$('#secondBurrMetalAlwnce').val("0");
	   					$('#secondBurrRcutAlwnce').val("0");
	   					//$('#secondBurrRedgeAlwnce').val("0");
	   					$('#secondBulgeLeftupHeight').val("0");
	   					$('#secondBulgeLeftdownHeight').val("0");
	   					$('#secondBulgeRightupHeight').val("0");
	   					$('#secondBulgeRightdownHeight').val("0");
	   					$('#secondBulgeLeftupWidth').val("0");
	   					$('#secondBulgeLeftdownWidth').val("0");
	   					$('#secondBulgeRightupWidth').val("0");
	   					$('#secondBulgeRightdownWidth').val("0");
	   					
	   					$('#btnSecondStepInsert').attr("disabled",false);
		   	 		}
					toastr.success(res.message, '', {timeOut: 5000});
					$('#btnStepDelete').attr("disabled", true);
					$('#btnStepReload').trigger('click');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#btnStepReload').trigger('click');
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
   	        complete:function(){
   	        	$('#my-spinner').hide();
			}
		});
    });

	//생산실적 입력 버튼
	$('#btnOutput').on('click', function() {
		if (workOrdNo == null) {
			toastr.warning("생산실적을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}

		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
			
		} else {
			if( workStatusCd != "S" && workStatusCd != "C") {
			  	toastr.warning("진행중이거나 완료된 작업지시만 생산실적을 입력 할 수 있습니다!");
				$('#btnOutputDelete').attr('disabled', true);
				$('#btnOutputAdd').attr('disabled', true);
				$('#btnOutputEdit').attr('disabled', true);
				$('#btnOutputSave').attr('disabled', true);
			} else {
				//생산실적 버튼들 활성화
				$('#btnOutputDelete').attr('disabled', false);
				$('#btnOutputAdd').attr('disabled', false);
				$('#btnOutputEdit').attr('disabled', false);
			}
			$('#gubun').attr('disabled', true);
			$('#firstWeight').attr('disabled', true);
			$('#visionEdgeWeight').attr('disabled', true);
			$('#workOrdDate').attr('disabled', true);
			
	  	  	$("#leftList").animate({
				width : "0%"
			}, 0, function(){
				setTimeout(function() {
					$('#leftList').addClass("d-none");				//오른쪽 버튼 모음
					//$("#leftList").css("display","");
				}, 150);
			});
			$("#middleList").animate({
				width : "58%"
			}, 0);
			$("#rightList").animate({
				width : "41.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
				$('#outPutCard').removeClass("d-none");				//생산실적 입력
				$('#faultyCard').addClass("d-none");				//생산실적 입력
				$('#btnStepReload').addClass('d-none');				//초,중,종물 재조회 버튼
				$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
				$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
				$('#btnStart').addClass('d-none');					//작업 시작
				$('#btnCancel').addClass('d-none');					//진행 취소
				$('#btnReStart').addClass('d-none');				//완료 취소
				$('#btnEnd').addClass('d-none');					//작업 종료
				$('#btnNotRunning_start').addClass('d-none');		//비가동 시작 버튼
				$('#btnNotRunning_end').addClass('d-none');			//비가동 종료 버튼
				
			});

			sideView = "output";
			uiProc(true);
			$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
			//$('.firstStep').attr('disabled', true);
			//$('.secondStep').attr('disabled', false);

			//output 수량 계산
			outputRead();
		}
        
	});

	//불량중량 입력 입력 버튼
	$('#btnFaulty').on('click', function() {
		if(workOrdNo == null) {
		  	toastr.warning("불량중량을 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("불량중량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("불량중량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("불량중량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}
		
		//작업지시 상태 
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
			
		} else {
			if (workStatusCd != "S" && workStatusCd != "C") {
		  	  	toastr.warning("진행중이거나 완료된 작업지시만 불량중량을 입력 할 수 있습니다!");
				$('#inputDay').attr('disabled', true);
				$('#inputNight').attr('disabled', true);
			} else {
				$('#inputDay').attr('disabled', false);
				$('#inputNight').attr('disabled', false);

			}

		  	$("#leftList").animate({
				width : "0%"
			}, 0, function(){
				setTimeout(function() {
					$('#leftList').addClass("d-none");
				}, 150);
			});
			$("#middleList").animate({
				width : "43%"
			}, 0, function(){
				setTimeout(function() {
					$('#workOrderTableCard').addClass("d-none");	//작업지시 테이블
					$('#equipFaultyTableCard').removeClass("d-none");	//불량통계 테이블
				}, 150);
			});
			$("#rightList").animate({
				width : "56.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
				$('#outPutCard').addClass("d-none");				//생산실적 입력
				$('#faultyCard').removeClass("d-none");				//불량중량 입력
				$('#btnStepReload').addClass('d-none');				//초,중,종물 재조회 버튼
				$('#btnCancel').addClass('d-none');
				$('#btnStart').addClass('d-none');
				$('#btnEnd').addClass('d-none');
				$('#btnReStart').addClass('d-none');
				$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
				$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
				$('#btnNotRunning_start').addClass('d-none');		//비가동 시작 버튼
				$('#btnNotRunning_end').addClass('d-none');			//비가동 종료 버튼
			});
			$('#btnWorkOrdRetv').addClass("d-none");
			$('.firstStep').attr('disabled', false);
			$('.secondStep').attr('disabled', true);
			$('#workSearchCond').addClass("d-none");			//작업지시 검색조건
			$('#showMenu').addClass("d-none");
			sideView = "faulty";
			mainView = "faulty";
			faultyTime();
			
	        //불량중량 입력 통계 컨트롤
// 	        ordDateCal = $('#ordDate').val();
	        $('#faultyRegDate').val(ordDateCal);
	        
	        //equipCd = equipCodeAdmTable.row( this ).data().equipCd;
			$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
			prcssTemp = 0;
			matrlTemp = 0;
			replaceTemp = 0;
			troubleTemp = 0;
			$('.day').attr('disabled', true);
			$('.night').attr('disabled', true);
			readTotal();

	        $('tr.tableSelected').removeClass('tableSelected');
	        $('#cardSelect').addClass('d-none');
	        $('#cardDay').addClass('d-none');				//주간 상단 버튼 숨김
	        $('#cardNight').addClass('d-none');				//야간 상단 버튼 숨김
	        $('#dayPrcssFaultyView').addClass('d-none');	//공정불량 주간입력
	        $('#nightPrcssFaultyView').addClass('d-none');	//공정불량 야간입력
	        $('#dayMatrlFaultyView').addClass('d-none');	//자재불량 주간입력
	        $('#nightMatrlFaultyView').addClass('d-none');	//자재불량 야간입력
	        $('#dayReplaceFaultyView').addClass('d-none');	//교체불량 주간입력
	        $('#nightReplaceFaultyView').addClass('d-none');//교체불량 야간입력
	        $('#dayTroubleFaultyView').addClass('d-none');	//트러블불량 주간입력
	        $('#nightTroubleFaultyView').addClass('d-none');//트러블불량 야간입력

	        $('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
	        $('#ordDateDiv').addClass('d-none');
	        $('#faultyRegDateDiv').removeClass('d-none');
		}
	});

	//비가동시간 입력 버튼
	var tempDowntimeOrdGubunCd = null;
	$('#btnDowntime').on('click', function() {
	  	if( equipCd == null) {
	  	  	toastr.warning("비가동사유를 조회할 설비명을 선택해주세요!");
	  	  	return false;
	  	}
	  	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("작업지시서를 선택해주세요.");
			return false;
		}
	  	$("#leftList").animate({
			width : "0%"
	  	}, 0, function(){
			setTimeout(function() {
				$('#leftList').addClass("d-none");				//오른쪽 버튼 모음
			}, 150);
		});
		$("#middleList").animate({
			width : "58%"
		}, 0, function(){
			/*setTimeout(function() {
				$('#workOrderTableCard').addClass("d-none");	//작업지시 테이블
				$('#equipFaultyTableCard').addClass("d-none");	//불량통계 테이블
				$('#equipDowntimeTableCard').removeClass("d-none");	//불량통계 테이블
			}, 150);*/
		});
		$("#rightList").animate({
			width : "41.5%"
		}, 0, function(){
			$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
			$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
			$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
			$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
			$('#outPutCard').addClass("d-none");				//생산실적 입력
			$('#faultyCard').addClass("d-none");				//생산실적 입력
// 			$('#downtimeCard').removeClass("d-none");			//비가동사유 입력
			$('#notRunningCard').removeClass("d-none");			//비가동사유 입력
			$('#notRunningTable').DataTable().ajax.reload();
			$('#mainMatrlLotNo').text('비가동 조회');
			$('#btnNotRunning_start').addClass('d-none');		//비가동 시작 버튼
			$('#btnNotRunning_end').addClass('d-none');			//비가동 종료 버튼
			$('#btnStepReload').addClass('d-none');				//초,중,종물 재조회 버튼
			$('#btnStart').addClass('d-none');					//작지 추가 버튼
			$('#btnEnd').addClass('d-none');					//작지 추가 버튼
			$('#btnCancel').addClass('d-none');					//작지 추가 버튼
			$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
			$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
		});
		$('.firstStep').attr('disabled', false);
		$('.secondStep').attr('disabled', true);
		//$('#workSearchCond').addClass("d-none");			//작업지시 검색조건
		$('#showMenu').addClass("d-none");
		sideView = "downtime";
		mainView = "downtime";
		$('#equipDowntimeAdmTable tbody tr').removeClass('selected');
		//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
		$('#fromEquipDowntime').each(function(){
			 this.reset();
		});

		//주야 구분을 작지테이블과 비가동사유등록에서 같이사용중임
		tempDowntimeOrdGubunCd = $('#ordGubunCd option:selected').val();


		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#ordGubunCd').val("D");
			ordGubunCd = "D";
		}
		
		baseGroupCd = null;
		chooseDate = $('#downtimeRegDate').val();
		reloadDowntimeAdm();
	});

	var connectWorkOrdNo = null;
    //작지 연결대상 목록조회
    $.fn.dataTable.ext.errMode = 'none';
    let connectWorkOrdNoTable = $('#connectWorkOrdNoTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	       	location.href = "/";
		} ).DataTable({
		language: lang_kor,
		paging: true,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: true,
		autoWidth: false,
		pageLength: 20,
        ajax: {
            url: '<c:url value="po/workOrderConncetList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	: 	menuAuth,
            	'equipCd'	:	function() { return equipCd; }, 
            },
	    },
	    rowId: 'equipCd',
		columns: [
			{ data: 'ordDate',
	       		render: function(data, type, row, meta) {
	           		return moment(data).format("YYYY-MM-DD");
	       		}
			},			
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: 'surfaceTrtmtNm' },
			{ data: 'dealCorpNm' },
			{ data: 'ordLotNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		//console.log(row['workOrdNo'].substring(13,1));
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:red; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	           			html = '<p id="ordLotNoText'+row['workNo']+'" style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['ordLotNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
	           		html = '';
	           		//console.log(row['workOrdNo'].substring(13,1));
	           		if( row['workOrdNo'].substring(13,14) == 1 || row['workOrdNo'].substring(13,14) == 2 ) {
	           			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	           		} else if( row['workOrdNo'].substring(13,14) == 3 || row['workOrdNo'].substring(13,14) == 4 ) {
	               		html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workStatusNm' },
			{ data: 'workTeamNm' },
			{ data: 'mainWorkChargrNm' },	
			{ data: 'subWorkChargrNm' },																		
		],
	    columnDefs: [
	    	{ targets: [0,1,2,3,4,5,6,7,8,9,10], className: 'text-center' },
	    ],		
		//order: [
		//	[ 0, 'asc' ],
		//],
	    drawCallback: function( settings ) {
	    	$('#connectWorkOrdNoTable tbody tr td').css('height','40px');
	    }
	});

    //연결대상 작지 투입내역 조회
    $.fn.dataTable.ext.errMode = 'none';
    let connectWorkOrdNoDtlTable = $('#connectWorkOrdNoDtlTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
//         dom: "<'row'<''l>>" +
// 		"<'row'<'col-sm-12'tr>>" +
// 		"<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",          
        language: lang_kor,
        paging: false,
        info: false,
        ordering: false,
        processing: false,
        autoWidth: false,
        lengthChange: true,
        searching: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="po/workOrderMatrlDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'workOrdNo' 	:		function() { return connectWorkOrdNo; }
            },
        },
        rowId: 'workOrdNo',
		columns: [
			{ data: 'qutyNm' },
			{ data: 'matrlNm' },
			{ data: 'surfaceTrtmtNm' },
			{ data: 'lotNo' },
			{ data: 'inspectQty' },
			{ data: 'faultyQty' },			
			{ data: 'barcodeNo' },
			{ data: 'regDate' },			
			{ data: 'remakeYn',
	    		render: function(data, type, row) {	
	    			var remakeNm = "신규투입";
	    			if(data == 'Y') {
	    				remakeNm = "재투입";
	   				
	   				}
	    			return remakeNm;
	    		}
			},
			{ data: 'changeLocationNm' },
			{ data: 'connectNm' },
		],
        columnDefs: [
        	{ targets: [0,1,2,3,6,7,8,10], className: 'text-center' },
        	{ targets: [4,5], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5], className: 'text-right pt-0 pb-0' },
        ],		
		order: [
			//[ 7, 'asc' ],
		],
// 	    "drawCallback": function( settings ) {
// 	    	$('#workOrderMatrlTable tbody tr td').css('height','40px');
// 	    }
// 	    "complete": function( settings ) {
// 	    	matrlRowCnt = $('#workOrderMatrlTable').DataTable().data().count();
// 	    }        
    });

    var connectBarcodeNo = '';
    var connectMainMatrlBarcode = '';
    var connectSubMatrlBarcode = '';
    var connectMainMatrlCheck = false;
    var connectSubMatrlCheck = false;
    $("#connectBarcodeNo").keypress(function (e) {
		//엔터키
    	if (e.which == 13){
	        if( $('#connectBarcodeNo').val() == "" ) {
	            toastr.warning('바코드를 먼저 스캔해주세요!');
	            return false;
	        }
	        
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng($('#connectBarcodeNo').val());
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#connectBarcodeNo').val(engToKor.toUpperCase());

	    	connectBarcodeNo = $('#connectBarcodeNo').val();

	    	//스캔자재 존재여부 확인
			$('#connectWorkOrdNoDtlTable tbody tr').each(function() {
				var tbarcodeNo= $(this).find('td').eq(6).html();
				if(connectBarcodeNo == tbarcodeNo) {
					//스캔 barcode가 주자재이면 기존selected 해제 후 스캔 barcode selectd
					if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "A" || connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "N") {
						$('#connectWorkOrdNoDtlTable tbody tr').each(function(){
							if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "A" || connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "N") {
								$(this).removeClass("selected");
							}
						});
						$(this).addClass("selected");
						connectMainMatrlBarcode = connectWorkOrdNoDtlTable.row(this).data().barcodeNo;
						connectMainMatrlCheck = true;
						toastr.success("확인되었습니다.");

					//스캔 barcode가  부자재이면 기존selected 해제 후 스캔 barcode selectd
					} else if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "F") {
						$('#connectWorkOrdNoDtlTable tbody tr').each(function(){
							if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "F") {
								$(this).removeClass("selected");
							}
						});
						$(this).addClass("selected");
						connectSubMatrlBarcode = connectWorkOrdNoDtlTable.row(this).data().barcodeNo;
						connectSubMatrlCheck = true;
						toastr.success("확인되었습니다.");
					}

					if (connectMainMatrlCheck == true && connectSubMatrlCheck == true) {
						$('#btnWorkOrdConncetCheck').attr('disabled', false);
					}
				}
			});
			
			$('#connectBarcodeNo').select();
        }
    });

	$('#connectWorkOrdNoDtlTable tbody').on('click', 'tr', function () {
		if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "A" || connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "N") {
			$('#connectWorkOrdNoDtlTable tbody tr').each(function() {
				if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "A" || connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "N") {
					$(this).removeClass("selected");
				}
			});
			$(this).addClass("selected");
			connectMainMatrlBarcode = connectWorkOrdNoDtlTable.row(this).data().barcodeNo;
			connectMainMatrlCheck = true;
			toastr.success("확인되었습니다.");

		//스캔 barcode가  부자재이면 기존selected 해제 후 스캔 barcode selectd
		} else if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "F") {
			$('#connectWorkOrdNoDtlTable tbody tr').each(function() {
				if (connectWorkOrdNoDtlTable.row(this).data().baseCdAbbr == "F") {
					$(this).removeClass("selected");
				}
			});
			$(this).addClass("selected");
			connectSubMatrlBarcode = connectWorkOrdNoDtlTable.row(this).data().barcodeNo;
			connectSubMatrlCheck = true;
			toastr.success("확인되었습니다.");
		}

		if (connectMainMatrlCheck == true && connectSubMatrlCheck == true) {
			$('#btnWorkOrdConncetCheck').attr('disabled', false);
		}
		
    });
    
	//스캔자재 존재여부 확인
	//function compareConnectBarcodeNo(barcodeNo) {
	//    var result = false;
	//    $('#connectWorkOrdNoDtlTable tbody tr').each(function(){
	//		var tbarcodeNo= $(this).find('td').eq(6).html();
	//		if(barcodeNo == tbarcodeNo) {  
	//			result = true;
	//			return result;
	//		}
	//	});
	//	
	//    return result;
	//}
	var workOrdLotNo = null;
	var workOrdSubOrdLotNo = null;
	var workOrdSubLotNo = null;
    $('#connectWorkOrdNoTable tbody').on('click', 'tr', function () {
		if ( $(this).hasClass('selected') ) {
			//$(this).removeClass('selected');
		} else {
        	$('#connectWorkOrdNoTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            connectWorkOrdNo = connectWorkOrdNoTable.row(this).data().workOrdNo;
            connectMainMatrlBarcode = '';
            connectSubMatrlBarcode = '';
            connectMainMatrlCheck = false;
            connectSubMatrlCheck = false;
            $('#btnWorkOrdConncetCheck').attr('disabled', true);
            $('#connectWorkOrdNoDtlTable').DataTable().ajax.reload( function () {});
        }
    });
    
	//작업지시 연결모달
	//$('#btnWorkOrdConnect').on('click', function() {
  	// 	var goodsCd = $("#goodsCd"+workOrdIndex).val();
    //    if ( !$.trim(goodsCd) ) {
	//		$("#goodsCd"+workOrdIndex).focus();
	//		toastr.warning('제품(기종)을 선택해 주세요!');
	//		return false;
    //    }
    //    var dealCorpCd = $("#dealCorpCd"+workOrdIndex).val();
    //    if ( !$.trim(dealCorpCd) ) {
	//		toastr.warning('거래처를 선택해 주세요!');
	//		$("#addForm2"+workOrdIndex).focus();
	//		return false;
    //    }
	//	var workTeamCd = $("#workTeamCd"+workOrdIndex).val();
    //    if ( !$.trim(workTeamCd) ) {
	//		$("#workTeamCd"+workOrdIndex).focus();
	//		toastr.warning('근무조를 선택해 주세요!');
	//		return false;
    //    }
	//	var mainWorkChargr = $("#mainWorkChargr"+workOrdIndex).val();
    //    if ( !$.trim(mainWorkChargr) ) {
	//		$("#addForm3"+workOrdIndex).focus();
	//		toastr.warning('담당1을 선택해 주세요!');
	//		return false;
    //    }
    //    
	//	connectWorkOrdNo = '';
	//	connectMainMatrlBarcode = '';
	//    connectSubMatrlBarcode = '';
	//	connectMainMatrlCheck = false;
	//    connectSubMatrlCheck = false;
	//	$('#connectBarcodeNo').val('');
	//	$('#btnWorkOrdConncetCheck').attr('disabled', true);
	//	$('#connectWorkOrdNoDtlTable').DataTable().clear().draw();
	//	//$('#connectWorkOrdNoModal').modal({backdrop: 'static'});
	//	$('#connectWorkOrdNoTable').DataTable().ajax.reload( function () {});
	//	$('#connectWorkOrdNoModal').modal('show');
	//	
	//});

	$('#btnWorkOrdConncetCheck').on('click', function() {
		if (connectWorkOrdNo == null || connectWorkOrdNo == '') {
			toastr.warning("연결할 작업지시를 선택해 주세요!");
			return false;
		}
		//$('#connectWorkOrdNoCheckModal').modal({backdrop: 'static'});
		$('#connectWorkOrdNoCheckTitle').text(workOrdNo + '가 ' + connectWorkOrdNo + '로 연결하시겠습니까?');
		$('#connectMainMatrlCheckTitle').text('연결 주자재 : ' + connectMainMatrlBarcode);
		$('#connectSubMatrlCheckTitle').text('연결 부자재 : ' + connectSubMatrlBarcode);
		$('#connectWorkOrdNoCheckModal').modal('show');
	});

	var modalStatus=false;
	$('#connectWorkOrdNoModal').on('hide.bs.modal', function (event) {
		if(!modalStatus){			
			event.preventDefault();
			$('#connectWorkOrdNoModal').modal('show');			
		} 		
		modalStatus=false;
	});

	//작지 연결 수행
	$('#btnWorkOrdConnectRealFinalCheck').on('click', function() {
        $.ajax({
            url: '<c:url value="po/createConnectWorkOrdNo"/>',
            type: 'POST',
            async: false,
            data: {
            	'menuAuth'	 				: 		menuAuth,
            	'workOrdNo'					: 		function() { return workOrdNo; },			//발행할 작지
            	'connectWorkOrdNo'			: 		function() { return connectWorkOrdNo; },	//생산완료 작지
            	'ordLotNo'					:		function() { return $("#ordLotNo"+workOrdIndex).val(); },
            	'equipCd'					: 		function() { return equipCd; },
            	'goodsCd'					:		function() { return $("#goodsCd"+workOrdIndex).val(); },
            	'dealCorpCd'				:		function() { return $("#dealCorpCd"+workOrdIndex).val(); },
            	'ordDate'					: 		function() { return ordDateCal.replace(/-/g, ''); },
            	'equipCondSeq'				: 		function() { return $("#equipCondSeq"+workOrdIndex).val(); },
            	'workTeamCd'				: 		function() { return $("#workTeamCd"+workOrdIndex).val(); },
            	'mainWorkChargr'			: 		function() { return $("#mainWorkChargr"+workOrdIndex).val(); },
            	'subWorkChargr'				: 		function() { return $("#subWorkChargr"+workOrdIndex).val(); },
            	'connectMainMatrlBarcode'	:		function() { return connectMainMatrlBarcode; },
            	'connectSubMatrlBarcode'	:		function() { return connectSubMatrlBarcode; },
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					modalStatus=true;
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					workOrdNo = null;
					toastr.success(res.message, '', {timeOut: 5000});
					$('#connectWorkOrdNoModal').modal('hide');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
			}
		});
	});
	
	//작지 연결모달 닫기
	$('#connectWorkOrdNoCheckModalClose, #connectWorkOrdNoCheckColse').on('click', function() {
		modalStatus=true;
		$('#connectWorkOrdNoModal').modal('hide');
	});

	//output 수량 계산
	function outputRead()
	{
		$('#outputCardTable').DataTable().ajax.reload( function () {});
		//생산실적을 아직 입력하지않아 targetCnt가 0이면 targetWeight 가지고 직접 계산	->	투입자재가 모두 재투입자재여서 투입중량이 0인 경우에도 발동되고 있음.. 어떻게 해야할까?
		/* if (targetCnt == 0 && outputWeight1 == null && outputWeight2 == null){
			//tempTargetCnt = parseInt(parseFloat(targetWeight)/parseFloat(gravity)*1000);
			//$('#targetCnt').val(tempTargetCnt);
			$('#firstWeight').val("0");
			$('#secondWeight').val("0");
			$('#thirdWeight').val("0");
			$('#fourthWeight').val("0");
			$('#firstCount').val("0");
			$('#secondCount').val("0");
			$('#thirdCount').val("0");
			$('#fourthCount').val("0");
			$('#totalOutputWeight').val("0");
			$('#totatlOutputCount').val("0");
			
		//생산실적을 이미 입력한 경우
		} else{
			//여기 AJX READ		
			
			$('#firstWeight').val(outputWeight1);
			$('#secondWeight').val(outputWeight2);
			$('#thirdWeight').val(outputWeight3);
			$('#fourthWeight').val(outputWeight4);
			$('#firstCount').val( parseInt(parseFloat($('#firstWeight').val())/parseFloat(gravity)*1000) );
			$('#secondCount').val( parseInt(parseFloat($('#secondWeight').val())/parseFloat(gravity)*1000) );
			$('#thirdCount').val( parseInt(parseFloat($('#thirdWeight').val())/parseFloat(gravity)*1000) );
			$('#fourthCount').val( parseInt(parseFloat($('#fourthWeight').val())/parseFloat(gravity)*1000) );
	
			//소계
			$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
			$('#totatlOutputCount').val(outputCnt);
			$('#targetCnt').val(targetCnt);
		} */

		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#workOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#workOrdDate').val(yesterday);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#workOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "D", "");
		}
		
		//var date = getTodayType1();
		//$('#workOrdDate').val(date);
		//if(workOrdNo.substring(11,14) == "001" || workOrdNo.substring(11,14) == "002"){
		//	selectBoxAppend(ordGubunCode, "gubun", "D", "");
		//} else{
		//	selectBoxAppend(ordGubunCode, "gubun", "N", "");	
		//}
		$('#firstWeight').val("0");
		$('#firstCount').val("0");
		$('#visionEdgeWeight').val("0");
		$('#visionEdgeCnt').val("0");
		$('#workOrdRegDate').val("");
		$('#targetWeight').val(targetWeight);
		$('#targetCnt').val(equipCapa);
	}
	
	/* -------------------------------------------------- 초,중물 입력 기능 시작 -------------------------------------------------- */
	//에이전트 치수 데이터 조회
	function agtSizeDataRead() {
		$('#my-spinner').show();
		
   	    $.ajax({
   	    	url: '<c:url value="/po/agtReadSize"/>',
			type: 'POST',
			async: false,
			data: {
   	        	'menuAuth'	 	:	menuAuth,
	   	        'workOrdNo'		:	function() { return workOrdNo; },
	   	     	//'ordLotNo'		:	function() { return ordLotNo; },
				//'stepCd'		: 	function() { return ordLotNoStepCd; },
	   	        'lotNo'			:	function() { return mainMatrlLotNo; },
   	        },
   	        success: function (res) {
   	        	var data = res.data;
				if(res.result == 'ok') {
					
					//초물x중물o, 초물 보기상태일 경우 초물등록btn 활성화
					let temp = true;
					if (ordLotNoStepCd == '001') {
						for(var i=0;i<data.length;i++) {
							if (data[i].stepCd == '001') {
								temp = false;
							}
						}
					}
					if (temp) {
						$('#btnFirstStepInsert').attr('disabled', false);
					}
					
					//초,중물 데이터가 없는 경우
					if(data == null || data == ''){
						//if(sideView == 'firstStep') { // 초물보기 상태일 경우
						//	$('#btnFirstStepInsert').attr('disabled', false);
						//	$('#btnStepEdit').attr('disabled', true);
						//}
						//if(sideView == 'secondStep') { // 중물보기 상태일 경우
						//	$('#btnSecondStepInsert').attr('disabled', true);
						//	$('#btnStepEdit').attr('disabled', true);
						//}
						if (ordLotNoStepCd == '001') {
							$('#btnFirstStepInsert').attr('disabled', false);
							$('#btnStepEdit').attr('disabled', true);
						} else if (ordLotNoStepCd == '002') {
							$('#btnSecondStepInsert').attr('disabled', false);
							$('#btnStepEdit').attr('disabled', true);
						}
						$('#btnStepEdit').attr('disabled', true);
						$('#btnStepDelete').attr('disabled', true);

					//초,중물 데이터가 있는 경우
					} else {
						for(var i=0;i<data.length;i++) {
							if (data[i].stepCd == '001') {
								var stepNm = 'first';
								//if (sideView == 'firstStep') { // 초물보기 상태일 경우
								if (ordLotNoStepCd == '001') {
									$('#btnFirstStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
								}
								//초물만 있을경우 중물 등록버튼활성화, 초물을 등록하지 않으면 중물을 등록 할 수 없도록 중물등록 버튼 비활성화
								if (data.length == 1 && data[0].stepCd == '001'){
									$('#btnSecondStepInsert').attr('disabled', false);
									//$('#btnStepEdit').attr('disabled', true);
								}
							} else if (data[i].stepCd == '002') {
								var stepNm = 'second';
								//if(sideView == 'secondStep') { // 중물보기 상태일 경우
								if (ordLotNoStepCd == '002') {
									$('#btnSecondStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
								}
							} else if(data[i].stepCd == '003') {
								var stepNm = 'third';
							}
							
							$('#'+stepNm+'WpLeftAlwnce').val(data[i].wpLeftAlwnce);
							$('#'+stepNm+'WpRightAlwnce').val(data[i].wpRightAlwnce);
							$('#'+stepNm+'PitchLeftAlwnce').val(data[i].pitchLeftAlwnce);
							$('#'+stepNm+'PitchRightAlwnce').val(data[i].pitchRightAlwnce);
							$('#'+stepNm+'PpfWingLeftAlwnce').val(data[i].ppfWingLeftAlwnce);
							$('#'+stepNm+'PpfWingRightAlwnce').val(data[i].ppfWingRightAlwnce);
							$('#'+stepNm+'PpfDepthLeftAlwnce').val(data[i].ppfDepthLeftAlwnce);
							$('#'+stepNm+'PpfDepthRightAlwnce').val(data[i].ppfDepthRightAlwnce);
							$('#'+stepNm+'FilmAlwnce').val(data[i].filmAlwnce);
							$('#'+stepNm+'MetalDepthAlwnce').val(data[i].metalDepthAlwnce);
							$('#'+stepNm+'MetalThicknessAlwnce').val(data[i].metalThicknessAlwnce);
							$('#'+stepNm+'ThCenterAlwnce').val(data[i].thCenterAlwnce);
							$('#'+stepNm+'ThEdgeAlwncePlus').val(data[i].thEdgeAlwncePlus);
							$('#'+stepNm+'Input').val(data[i].thStepInput);
							$('#'+stepNm+'BurrMetalAlwnce').val(data[i].burrMetalAlwnce);
							$('#'+stepNm+'BurrRcutAlwnce').val(data[i].burrRcutAlwnce);
							//$('#'+stepNm+'BurrRedgeAlwnce').val(data[i].burrRedgeAlwnce);
							$('#'+stepNm+'BulgeLeftupHeight').val(data[i].bulgeLeftupHeight);
							$('#'+stepNm+'BulgeLeftdownHeight').val(data[i].bulgeLeftdownHeight);
							$('#'+stepNm+'BulgeRightupHeight').val(data[i].bulgeRightupHeight);
							$('#'+stepNm+'BulgeRightdownHeight').val(data[i].bulgeRightdownHeight);
							$('#'+stepNm+'BulgeLeftupWidth').val(data[i].bulgeLeftupWidth);
							$('#'+stepNm+'BulgeLeftdownWidth').val(data[i].bulgeLeftdownWidth);
							$('#'+stepNm+'BulgeRightupWidth').val(data[i].bulgeRightupWidth);
							$('#'+stepNm+'BulgeRightdownWidth').val(data[i].bulgeRightdownWidth);
							//console.log(data[i]);
						}
					}

				} else {
					toastr.error(res.message, '(에이전트 치수 데이터 조회)', {timeOut: 5000});
				}
   	        },
			complete:function(){
				//엣지검사완료/외관검사완료/종료 시 등록된 정보 표시만
 				//if (workStatusCd != "S" && workStatusCd != "C") {
 				//	$('#btnStepDelete').attr('disabled', true);
 				//	$('#btnFirstStepInsert').attr('disabled', true);
 				//	$('#btnSecondStepInsert').attr('disabled', true);
 				//	$('#btnStepEdit').attr('disabled', true);
 				//	$('#btnStepSave').attr('disabled', true);
 				//}
 				if (subWorkStatusCd != "S" && subWorkStatusCd != "C") {
 	 				//온도에서 이미 했음
 					//if (ordLotNoStepCd == '001') {
 					//	toastr.warning("생산 완료된 생산전표번호만 초물을 입력 할 수 있습니다!");
 					//} else if (ordLotNoStepCd == '002') {
 					//	toastr.warning("생산 완료된 생산전표번호만 중물을 입력 할 수 있습니다!");
 					//}
 					$('#btnStepDelete').attr('disabled', true);
 					$('#btnFirstStepInsert').attr('disabled', true);
 					$('#btnSecondStepInsert').attr('disabled', true);
 					$('#btnStepEdit').attr('disabled', true);
 					$('#btnStepSave').attr('disabled', true);
 				}
			}
		});
		
	} 
	//에이전트 치수 조건 조회
	function agtSizeCondRead() {
		$('#my-spinner').show();
		
   	    $.ajax({
			url: '<c:url value="/po/workOrderStepData"/>',
			type: 'GET',
			async: false,
			data: {
   	        	'menuAuth'	 	:	menuAuth,
	   	        'workOrdNo'		:	workOrdNo,
   				'equipCondSeq' 	:	equipCondSeq,
   	        },
   	        success: function (res) {
   	         	let condStepData = res.condStepData;

				//치수 조건
   	            if (res.result == 'ok') {
   	            	$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
   	            	$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
   	            	$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
   	            	$('#pitchRightCond').text('-'+condStepData.pitchRightAlwnceMinus + ' [' + condStepData.pitchRightCond + '] +' + condStepData.pitchRightAlwncePlus);
   	            	$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
   	            	$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
   	            	$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
   	            	$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
   	            	$('#filmCond').text('-'+condStepData.filmAlwnceMinus + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
   	            	$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
   	            	$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
   	            	$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
   	            	$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
   	            	$('#burrCond').text('-'+condStepData.burrAlwnceMinus + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);
				}
				else {
					toastr.error(res.message, '(에이전트 치수 조건 조회)', {timeOut: 5000});
				}
   	        },
   	        complete:function(){
   	        	$('#my-spinner').hide();
			}
		});
	}

	//초,중물 입력 저장btn
	$('#btnStepSave').on('click', function() {
		
		$('#my-spinner').show();
		
		let sideView = null;
		if (ordLotNoStepCd == '001') {
			sideView = 'firstStep';
		} else if (ordLotNoStepCd == '002') {
			sideView = 'secondStep';
		}
		
		//온도
		$.ajax({
			url: '<c:url value="/po/agtUpdateTemp"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				'ordLotNo'				:	function() { return ordLotNo; },
				'stepCd'				:	function() { return ordLotNoStepCd; },//sideView == 'firstStep'?'001':'002',
				'lotNo'					:	function() { return mainMatrlLotNo; },
				'warmupCond'			:	$('#' + sideView.replace('Step', '') + 'WarmupCond').val(),
				'fitup1UpCond'			:	$('#' + sideView.replace('Step', '') + 'Fitup1UpCond').val(),
				'fitup1DownCond'		:	$('#' + sideView.replace('Step', '') + 'Fitup1DownCond').val(),
				'fitup2UpleftCond'		:	$('#' + sideView.replace('Step', '') + 'Fitup2UpleftCond').val(),
				'fitup2DownleftCond'	:	$('#' + sideView.replace('Step', '') + 'Fitup2DownleftCond').val(),
				'fitup2UprightCond'		:	$('#' + sideView.replace('Step', '') + 'Fitup2UprightCond').val(),
				'fitup2DownrightCond'	:	$('#' + sideView.replace('Step', '') + 'Fitup2DownrightCond').val(),
				'rollheatUpCond'		:	$('#' + sideView.replace('Step', '') + 'RollheatUpCond').val(),
				'rollheatDownCond'		:	$('#' + sideView.replace('Step', '') + 'RollheatDownCond').val(),
				'firstUpleftCond'		:	$('#' + sideView.replace('Step', '') + 'FirstUpleftCond').val(),
				'firstDownleftCond'		:	$('#' + sideView.replace('Step', '') + 'FirstDownleftCond').val(),
				'firstUprightCond'		:	$('#' + sideView.replace('Step', '') + 'FirstUprightCond').val(),
				'firstDownrightCond'	:	$('#' + sideView.replace('Step', '') + 'FirstDownrightCond').val(),
				'push1UpCond'			:	$('#' + sideView.replace('Step', '') + 'Push1UpCond').val(),
				'push1DownCond'			:	$('#' + sideView.replace('Step', '') + 'Push1DownCond').val(),
				'firstUpleftCond'		:	$('#' + sideView.replace('Step', '') + 'FirstUpleftCond').val(),
				'secondUpleftCond'		:	$('#' + sideView.replace('Step', '') + 'SecondUpleftCond').val(),
				'secondDownleftCond'	:	$('#' + sideView.replace('Step', '') + 'SecondDownleftCond').val(),
				'secondUprightCond'		:	$('#' + sideView.replace('Step', '') + 'SecondUprightCond').val(),
				'secondDownrightCond'	:	$('#' + sideView.replace('Step', '') + 'SecondDownrightCond').val(),
				'thirdUpleftCond'		:	$('#' + sideView.replace('Step', '') + 'ThirdUpleftCond').val(),
				'thirdDownleftCond'		:	$('#' + sideView.replace('Step', '') + 'ThirdDownleftCond').val(),
				'thirdUprightCond'		:	$('#' + sideView.replace('Step', '') + 'ThirdUprightCond').val(),
				'thirdDownrightCond'	:	$('#' + sideView.replace('Step', '') + 'ThirdDownrightCond').val(),
				'jinjeop1UpCond'		:	$('#' + sideView.replace('Step', '') + 'Jinjeop1UpCond').val(),
				'jinjeop1DownCond'		:	$('#' + sideView.replace('Step', '') + 'Jinjeop1DownCond').val(),
				'jinjeop2UpCond'		:	$('#' + sideView.replace('Step', '') + 'Jinjeop2UpCond').val(),
				'jinjeop2DownCond'		:	$('#' + sideView.replace('Step', '') + 'Jinjeop2DownCond').val(),
			},
			success: function (res) {
				let result = res.result;
				if (res.result == 'ok') {
					toastr.success('에이전트 온도값이 수정되었습니다.');
					$('.'+sideView.replace('Step','')+'Step').attr('disabled',true);
				} else if (res.result == 'fail') {
				} else {
					toastr.error(res.message, '(에이전트 온도 수정)', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
				$('#btnStepSave').attr('disabled',true);
			}
		});

		//치수
		$.ajax({
			url: '<c:url value="/po/agtUpdateSize"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				'ordLotNo'				:	function() { return ordLotNo; },
				'stepCd'				:	function() { return ordLotNoStepCd; },//sideView == 'firstStep'?'001':'002',
				'lotNo'					:	function() { return mainMatrlLotNo; },
				'wpLeftAlwnce'			:	$('#' + sideView.replace('Step', '') + 'WpLeftAlwnce').val(),
				'wpRightAlwnce'			:	$('#' + sideView.replace('Step', '') + 'WpRightAlwnce').val(),
				'pitchLeftAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PitchLeftAlwnce').val(),
				'pitchRightAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PitchRightAlwnce').val(),
				'ppfWingLeftAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PpfWingLeftAlwnce').val(),
				'ppfWingRightAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfWingRightAlwnce').val(),
				'ppfDepthLeftAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfDepthLeftAlwnce').val(),
				'ppfDepthRightAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfDepthRightAlwnce').val(),
				'filmAlwnce'			:	$('#' + sideView.replace('Step', '') + 'FilmAlwnce').val(),
				'metalDepthAlwnce'		:	$('#' + sideView.replace('Step', '') + 'MetalDepthAlwnce').val(),
				'metalThicknessAlwnce'	:	$('#' + sideView.replace('Step', '') + 'MetalThicknessAlwnce').val(),
				'thCenterAlwnce'		:	$('#' + sideView.replace('Step', '') + 'ThCenterAlwnce').val(),
				'thEdgeAlwncePlus'		:	$('#' + sideView.replace('Step', '') + 'ThEdgeAlwncePlus').val(),
				'thStepInput'	        :	$('#' + sideView.replace('Step', '') + 'Input').val(),
				'bulgeLeftupHeight'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupHeight').val(),
				'bulgeLeftdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownHeight').val(),
				'bulgeRightupHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightupHeight').val(),
				'bulgeRightdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownHeight').val(),
				'bulgeLeftupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupWidth').val(),
				'bulgeLeftdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownWidth').val(),
				'bulgeRightupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeRightupWidth').val(),
				'bulgeRightdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownWidth').val(),
				'burrMetalAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrMetalAlwnce').val(),
				'burrRcutAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRcutAlwnce').val(),
				'burrRedgeAlwnce'		:	'0',
				//'burrRedgeAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRedgeAlwnce').val(),
			},
			success: function (res) {
				let result = res.result;
				if (res.result == 'ok') {
					toastr.success('에이전트 치수값이 수정되었습니다.');
					$('.'+sideView.replace('Step','')+'Step').attr('disabled',true);
				} else if (res.result == 'fail') {
				} else {
					toastr.error(res.message, '(에이전트 치수 수정)', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
				$('#btnStepSave').attr('disabled',true);
			}
		});
	});
    
	//초,중물 입력 초기화
  	function stepViewClear()
	{
  		$(".cond, .firstStep, .secondStep, .thridStep").val("");
  		//if (ordLotNoStepCd == '001') {
  			$(".firstStep").val("0");
  	  	//} else if (ordLotNoStepCd == '002') {
  	  		$(".secondStep").val("0");
  	  	//} else if (ordLotNoStepCd == '003') {
  	  	//	$(".thridStep").val("0");
  	  	//}
		$("#firstRegTime, #secondRegTime, #thirdRegTime").val("");
	}

	//에이젼트 온도 데이터 읽기
	function agtTempDataRead() {
		$('#btnStepDelete').attr('disabled', true);
		$('#btnStepEdit').attr('disabled', true);
		$('#btnStepSave').attr('disabled', true);
		$.ajax({
			url: '<c:url value="po/agtReadTemp"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'		:	menuAuth,
				'workOrdNo'		:	function() { return workOrdNo; },
				//'ordLotNo'		:	function() { return ordLotNo; },
				//'stepCd'		: 	function() { return ordLotNoStepCd; },
				'lotNo'			:	function() { return mainMatrlLotNo; },
			},
			success: function (res) {
				var data = res.data;
				if(res.result == 'ok') {

					var checkText = $('#ordLotNoStepTitle').text();
					var checkStep = checkText.substring((checkText.indexOf('/')+2), checkText.length); 
					
					var first_check_disabled	= true;
					var second_check_disabled	= true;

					for(var i=0;i<data.length;i++) {
						if(data[i].stepCd == '001') {
							var stepNm = 'first';
							//if (sideView == 'firstStep') { // 초물보기 상태일 경우
							if (ordLotNoStepCd == '001') {
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
							$('#btnStepEdit').attr('disabled',false);
							$('#btnStepDelete').attr('disabled',false);

							first_check_disabled = false;
							
						} else if (data[i].stepCd == '002') {
							var stepNm = 'second';
							//if (sideView == 'secondStep') { // 중물보기 상태일 경우
							if (ordLotNoStepCd == '002') {
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
							$('#btnStepEdit').attr('disabled',false);
							$('#btnStepDelete').attr('disabled',false);

							second_check_disabled = false;
							
						} else if(data[i].stepCd == '003') {
							var stepNm = 'third';
						} 
						$('#' + stepNm + 'WarmupCond').val(data[i].warmupCond);
						$('#' + stepNm + 'Fitup1UpCond').val(data[i].fitup1UpCond);
						$('#' + stepNm + 'Fitup1DownCond').val(data[i].fitup1DownCond);
						$('#' + stepNm + 'Fitup2UpleftCond').val(data[i].fitup2UpleftCond);
						$('#' + stepNm + 'Fitup2DownleftCond').val(data[i].fitup2DownleftCond);
						$('#' + stepNm + 'Fitup2UprightCond').val(data[i].fitup2UprightCond);
						$('#' + stepNm + 'Fitup2DownrightCond').val(data[i].fitup2DownrightCond);
						$('#' + stepNm + 'RollheatUpCond').val(data[i].rollheatUpCond);
						$('#' + stepNm + 'RollheatDownCond').val(data[i].rollheatDownCond);
						$('#' + stepNm + 'FirstUpleftCond').val(data[i].firstUpleftCond);
						$('#' + stepNm + 'FirstDownleftCond').val(data[i].firstDownleftCond);
						$('#' + stepNm + 'FirstUprightCond').val(data[i].firstUprightCond);
						$('#' + stepNm + 'FirstDownrightCond').val(data[i].firstDownrightCond);
						$('#' + stepNm + 'Push1UpCond').val(data[i].push1UpCond);
						$('#' + stepNm + 'Push1DownCond').val(data[i].push1DownCond);
						$('#' + stepNm + 'FirstUpleftCond').val(data[i].firstUpleftCond);
						$('#' + stepNm + 'SecondUpleftCond').val(data[i].secondUpleftCond);
						$('#' + stepNm + 'SecondDownleftCond').val(data[i].secondDownleftCond);
						$('#' + stepNm + 'SecondUprightCond').val(data[i].secondUprightCond);
						$('#' + stepNm + 'SecondDownrightCond').val(data[i].secondDownrightCond);
						$('#' + stepNm + 'ThirdUpleftCond').val(data[i].thirdUpleftCond);
						$('#' + stepNm + 'ThirdDownleftCond').val(data[i].thirdDownleftCond);
						$('#' + stepNm + 'ThirdUprightCond').val(data[i].thirdUprightCond);
						$('#' + stepNm + 'ThirdDownrightCond').val(data[i].thirdDownrightCond);
						$('#' + stepNm + 'Jinjeop1UpCond').val(data[i].jinjeop1UpCond);
						$('#' + stepNm + 'Jinjeop1DownCond').val(data[i].jinjeop1DownCond);
						$('#' + stepNm + 'Jinjeop2UpCond').val(data[i].jinjeop2UpCond);
						$('#' + stepNm + 'Jinjeop2DownCond').val(data[i].jinjeop2DownCond);
					}

					if(checkStep == "초물"){
						if(first_check_disabled){
							$('#btnStepDelete').attr('disabled', true);
							$('#btnStepEdit').attr('disabled', true);
						}
					}
					if(checkStep == "종물"){
						if(second_check_disabled){
							$('#btnStepDelete').attr('disabled', true);
							$('#btnStepEdit').attr('disabled', true);
						}
					}
					
				} else {
					toastr.error('(에이전트 온도 데이터 조회)' + res.message, '', {timeOut: 5000});
				}
			},
 			complete:function(res){
 				//엣지검사완료/외관검사완료/종료 시 등록된 정보 표시만
 				//if (workStatusCd != "S" && workStatusCd != "C") {
 				//	if(sideView == 'firstStep') {
 				//		toastr.warning("진행중이거나 완료된 작업지시만 초물을 입력 할 수 있습니다!");
 				//	} else if(sideView == 'secondStep') {
 				//		toastr.warning("진행중이거나 완료된 작업지시만 중물을 입력 할 수 있습니다!");
 				//	}
 				//	$('#btnStepDelete').attr('disabled', true);
 				//	$('#btnFirstStepInsert').attr('disabled', true);
 				//	$('#btnSecondStepInsert').attr('disabled', true);
 				//	$('#btnStepEdit').attr('disabled', true);
 				//	$('#btnStepSave').attr('disabled', true);
 				//}
 				if (subWorkStatusCd != "S" && subWorkStatusCd != "C") {
 					if (ordLotNoStepCd == '001') {
 						toastr.warning("생산 완료된 생산전표번호만 초물을 입력 할 수 있습니다!");
 					} else if (ordLotNoStepCd == '002') {
 						toastr.warning("생산 완료된 생산전표번호만 중물을 입력 할 수 있습니다!");
 					}
 					$('#btnStepDelete').attr('disabled', true);
 					$('#btnFirstStepInsert').attr('disabled', true);
 					$('#btnSecondStepInsert').attr('disabled', true);
 					$('#btnStepEdit').attr('disabled', true);
 					$('#btnStepSave').attr('disabled', true);
 				}
			}
		});
	}

	//에이젼트 온도 조건 읽기
	function agtTempCondRead() {
		$.ajax({
			url: '<c:url value="po/readTempCond"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	:	menuAuth,
				'workOrdNo'		:	workOrdNo,
			},
			success: function (res) {
				var data = res.data;
				if(res.result == 'ok') {
					//console.log(data);
					$('#warmupCond').text('-'+data.warmupAlwnceMinus+' [' + data.warmupCond + '] ' + '+' + data.warmupAlwncePlus);
					$('#fitup1UpCond').text('-'+data.fitup1UpAlwnceMinus+' [' + data.fitup1UpCond + '] ' + '+' + data.fitup1UpAlwncePlus);
					$('#fitup1DownCond').text('-'+data.fitup1DownAlwnceMinus+' [' + data.fitup1DownCond + '] ' + '+' + data.fitup1DownAlwncePlus);
					$('#fitup2UpleftCond').text('-'+data.fitup2UpleftAlwnceMinus+' [' + data.fitup2UpleftCond + '] ' + '+' + data.fitup2UpleftAlwncePlus);
					$('#fitup2DownleftCond').text('-'+data.fitup2DownleftAlwnceMinus+' [' + data.fitup2DownleftCond + '] ' + '+' + data.fitup2DownleftAlwncePlus);
					$('#fitup2UprightCond').text('-'+data.fitup2UprightAlwnceMinus+' [' + data.fitup2UprightCond + '] ' + '+' + data.fitup2UprightAlwncePlus);
					$('#fitup2DownrightCond').text('-'+data.fitup2DownrightAlwnceMinus+' [' + data.fitup2DownrightCond + '] ' + '+' + data.fitup2DownrightAlwncePlus);
					$('#rollheatUpCond').text('-'+data.rollheatUpAlwnceMinus+' [' + data.rollheatUpCond + '] ' + '+' + data.rollheatUpAlwncePlus);
					$('#rollheatDownCond').text('-'+data.rollheatDownAlwnceMinus+' [' + data.rollheatDownCond + '] ' + '+' + data.rollheatDownAlwncePlus);
					$('#firstUpleftCond').text('-'+data.firstUpleftAlwnceMinus+' [' + data.firstUpleftCond + '] ' + '+' + data.firstUpleftAlwncePlus);
					$('#firstDownleftCond').text('-'+data.firstDownleftAlwnceMinus+' [' + data.firstDownleftCond + '] ' + '+' + data.firstDownleftAlwncePlus);
					$('#firstUprightCond').text('-'+data.firstUprightAlwnceMinus+' [' + data.firstUprightCond + '] ' + '+' + data.firstUprightAlwncePlus);
					$('#firstDownrightCond').text('-'+data.firstDownrightAlwnceMinus+' [' + data.firstDownrightCond + '] ' + '+' + data.firstDownrightAlwncePlus);
					$('#push1UpCond').text('-'+data.push1UpAlwnceMinus+' [' + data.push1UpCond + '] ' + '+' + data.push1UpAlwncePlus);
					$('#push1DownCond').text('-'+data.push1DownAlwnceMinus+' [' + data.push1DownCond + '] ' + '+' + data.push1DownAlwncePlus);
					$('#firstUpleftCond').text('-'+data.firstUpleftAlwnceMinus+' [' + data.firstUpleftCond + '] ' + '+' + data.firstUpleftAlwncePlus);
					$('#secondUpleftCond').text('-'+data.secondUpleftAlwnceMinus+' [' + data.secondUpleftCond + '] ' + '+' + data.secondUpleftAlwncePlus);
					$('#secondDownleftCond').text('-'+data.secondDownleftAlwnceMinus+' [' + data.secondDownleftCond + '] ' + '+' + data.secondDownleftAlwncePlus);
					$('#secondUprightCond').text('-'+data.secondUprightAlwnceMinus+' [' + data.secondUprightCond + '] ' + '+' + data.secondUprightAlwncePlus);
					$('#secondDownrightCond').text('-'+data.secondDownrightAlwnceMinus+' [' + data.secondDownrightCond + '] ' + '+' + data.secondDownrightAlwncePlus);
					$('#thirdUpleftCond').text('-'+data.thirdUpleftAlwnceMinus+' [' + data.thirdUpleftCond + '] ' + '+' + data.thirdUpleftAlwncePlus);
					$('#thirdDownleftCond').text('-'+data.thirdDownleftAlwnceMinus+' [' + data.thirdDownleftCond + '] ' + '+' + data.thirdDownleftAlwncePlus);
					$('#thirdUprightCond').text('-'+data.thirdUprightAlwnceMinus+' [' + data.thirdUprightCond + '] ' + '+' + data.thirdUprightAlwncePlus);
					$('#thirdDownrightCond').text('-'+data.thirdDownrightAlwnceMinus+' [' + data.thirdDownrightCond + '] ' + '+' + data.thirdDownrightAlwncePlus);
					$('#jinjeop1UpCond').text('-'+data.jinjeop1UpAlwnceMinus+' [' + data.jinjeop1UpCond + '] ' + '+' + data.jinjeop1UpAlwncePlus);
					$('#jinjeop1DownCond').text('-'+data.jinjeop1DownAlwnceMinus+' [' + data.jinjeop1DownCond + '] ' + '+' + data.jinjeop1DownAlwncePlus);
					$('#jinjeop2UpCond').text('-'+data.jinjeop2UpAlwnceMinus+' [' + data.jinjeop2UpCond + '] ' + '+' + data.jinjeop2UpAlwncePlus);
					$('#jinjeop2DownCond').text('-'+data.jinjeop2DownAlwnceMinus+' [' + data.jinjeop2DownCond + '] ' + '+' + data.jinjeop2DownAlwncePlus);
				} else {
					toastr.error(res.message, '(에이전트 온도 조건 조회)', {timeOut: 5000});
				}
			}
		});
	}
	/* -------------------------------------------------- 초,중물 입력 기능 끝 -------------------------------------------------- */

	/* -------------------------------------------------- 생산실적 기능 시작 -------------------------------------------------- */
	//비전1 입력
	$('#visionEdgeWeight').keyup(function (event) {
		$('#visionEdgeCnt').val(parseInt(parseFloat($('#visionEdgeWeight').val()) / parseFloat(gravity) * 1000));
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	});
	
	//생산1 입력
	$('#firstWeight').keyup(function (event) {
		$('#firstCount').val(parseInt(parseFloat($('#firstWeight').val()) / parseFloat(gravity) * 1000));
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	});
	
	//생산2 입력
	//$('#secondWeight').keyup(function (event) {
		//$('#secondCount').val( parseInt(parseFloat($('#secondWeight').val())/parseFloat(gravity)*1000) );
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	//});

	//생산3 입력
	//$('#thirdWeight').keyup(function (event) {
		//$('#thirdCount').val( parseInt(parseFloat($('#thirdWeight').val())/parseFloat(gravity)*1000) );
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	//});

	//생산4 입력
	//$('#fourthWeight').keyup(function (event) {
		//$('#fourthCount').val( parseInt(parseFloat($('#fourthWeight').val())/parseFloat(gravity)*1000) );
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	//});

	//생산실적 저장
	var ordLotNo = null;
	var ordLotNoStepCd = null;
    $('#btnOutputSave').on('click', function() {
    	if (workOrdNo == '' || workOrdNo == null) {
    		toastr.warning("생산실적을 입력할 작업지시를 선택해주세요!");
			return false;
    	}
    	if (mainMatrlLotNo == '' || mainMatrlLotNo == null) {
    		toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
        }
		if ($('#gubun option:selected').val() == "") {
			toastr.warning("주야구분을 선택해주세요.");
			$('#gubun').focus();
			return false;
		}
		if ($('#firstWeight').val() == "0" && $('#visionEdgeWeight').val() == "0") {
			toastr.warning("생산중량 또는 비전 검사량을 입력해 주세요.");
			$('#firstWeight').select();
			return false;
		}
		if ($('#workOrdDate').val() == "") {
			toastr.warning("전표일자를 선택해주세요.");
			$('#workOrdDate').focus();
			return false;
		}

		$('#visionEdgeCnt').val(parseInt(parseFloat($('#visionEdgeWeight').val()) / parseFloat(gravity) * 1000) );
		$('#firstCount').val(parseInt(parseFloat($('#firstWeight').val()) / parseFloat(gravity) * 1000) );

		if($('#firstCount').val() == 'NaN') {
			toastr.warning("생산중량을 다시 입력해주세요!");
			$('#firstWeight').select();
			return false;
		}
		if($('#visionEdgeCnt').val() == 'NaN') {
			toastr.warning("생산중량을 다시 입력해주세요!");
			$('#visionEdgeWeight').select();
			return false;
		}
		
    	tempTargetCnt = $('#targetCnt').val();
    	outputWeight1 = $('#firstWeight').val();
		
    	let visionEdgeWeight = $('#visionEdgeWeight').val();
    	let visionEdgeCnt = $('#visionEdgeCnt').val();
    	
    	//outputWeight2 = $('#secondWeight').val();
    	//outputWeight3 = $('#thirdWeight').val();
    	//outputWeight4 = $('#fourthWeight').val();
    	//outputCnt = $('#totatlOutputCount').val();
    	
    	$('#my-spinner').show();
    	
		var url;
		if(outputBtnStat == 'add') {
			url = '<c:url value="/po/outputCntDataCreate"/>';
		} else{
			url = '<c:url value="/po/outputCntDataUpdate"/>';
		}
    	
    	$.ajax({
    		url: url,
   	        type: 'POST',
			async: false,
            data: {
            	'menuAuth'			:		menuAuth,
            	'equipCd'			:		function() { return equipCd; },
            	'equipNm'			:		function() { return equipNm; },
             	'workOrdNo'			:		function() { return workOrdNo; },
             	'ordLotNo'			:		function() { return subOrdLotNo; },
             	'ordDate'			:		function() { return ordDateCal.replace(/-/g,""); },
             	'gubun'				:		$('#gubun').val(),
             	'lotNo'				:		function() { return mainMatrlLotNo; },
             	'mainMatrlCd'		:		function() { return mainMatrlCd; },
             	'workOrdDate'		:		$('#workOrdDate').val().replace(/-/g,""),
             	'outputWeight'		:		$('#firstWeight').val(),
             	'outputCnt'			:		$('#firstCount').val(),
             	'visionEdgeWeight'	:		$('#visionEdgeWeight').val(),
             	'visionEdgeCnt'   	:       $('#visionEdgeCnt').val(),
             	'workOrdSeq'		:       workOrdSeq,
				'targetCnt'			:       tempTargetCnt,
 	    		//'workStatusCd'	:       'E',		//컨트롤단에서 설정
             },
             success: function (res) {
				if (res.result == 'ok') {
					let data = res.data;
					ordLotNoStepCd = res.stepCd;
					ordLotNo = res.data.ordLotNo;
					$('#workOrdRegDate').val(moment(data.regDate).format("YYYY-MM-DD HH:mm:ss"));
					$('#btnOutputSave').attr('disabled',true);
					//$('#btnOutputEdit').attr('disabled',true);
					$('#gubun').attr('disabled',true);
					$('#firstWeight').attr('disabled',true);
					$('#visionEdgeWeight').attr('disabled',true);
					$('#workOrdDate').attr('disabled',true);
					if (outputBtnStat == 'add') {
						toastr.success(res.message);
						//console.log(data.regDate);
						//console.log(ordLotNoStepCd);
						//console.log(ordLotNo);
						//ordLotNoStepCd이 001 또는 002이면 초중물 등록
						//DGS Redis사용
						if (ordLotNoStepCd == '001' || ordLotNoStepCd == '002') {
							$.ajax({
								url: '<c:url value="/po/workOrderStepInsertRedis_DB0"/>',
								type: 'POST',
								async: false,
								data: {
									'menuAuth'	 	:	menuAuth,
									'workOrdNo'		:	function() { return workOrdNo; },
									'equipCd'		:	function() { return equipCd; },
									'lotNo'			:	function() { return mainMatrlLotNo; },
									'stepCd'		:	function() { return ordLotNoStepCd; },
									'ordLotNo'		:	function() { return ordLotNo; },
								},
								success: function (res) {
									let data = res.data;
									if (res.result == 'ok') {
										toastr.success(res.message, '', {timeOut: 5000});
										$('#btnOrdLotNoFristStep').addClass('d-none');
										$('#btnOrdLotNoSecondStep').addClass('d-none');
										//$('#btnStepReload').trigger('click');
										//$('#ordLotNoStepModal').modal({backdrop: 'static'});
										//$('#ordLotNoStepModal').modal('show');
									} else if (res.result == 'fail') {
										toastr.warning(res.message, '', {timeOut: 5000});
										//$('#btnStepReload').trigger('click');
									} else {
										toastr.error(res.message, '', {timeOut: 5000});
									}
								},
								complete:function() {
									$('#my-spinner').hide();
								}
							});
							
						//000이면 초중물등록X
						} else if (ordLotNoStepCd == '000') {
						}
						
					} else {
						toastr.success(res.message);
					}
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 10000});
					$('#btnOrdLotNoFristStep').addClass('d-none');
					$('#btnOrdLotNoSecondStep').addClass('d-none');
					$('#firstWeight').attr('disabled', true);
					$('#visionEdgeWeight').attr('disabled', true);
					$('#btnOutputSave').attr('disabled', true);
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function() {
				$('#outputCardTable').DataTable().ajax.reload( function () {});
				$('#my-spinner').hide();
			}
   	    });
    });

    $('#btnOutputEdit').on('click', function() {
    	if ( !$('#outputCardTable tr').hasClass('selected') ) {
			toastr.warning("수정할 라인을 선택해주세요.");
            return false;
        }
    	if (subWorkStatusCd != 'C' && subWorkStatusCd != 'S') {
			toastr.warning("생산완료 상태의 생산실적만 수정하실 수 있습니다!");
            return false;
        }
    	outputBtnStat = 'edit';
    	//$('#gubun').attr('disabled',false);
    	$('#firstWeight').attr('disabled',false);
    	$('#visionEdgeWeight').attr('disabled',false);
    	//$('#workOrdDate').attr('disabled',false);
    	$('#btnOutputSave').attr('disabled',false);
    });

	//생산실적 삭제 확인
    $('#btnOutputDelete').on('click', function() {
    	if ( !$('#outputCardTable tr').hasClass('selected') ) {
			toastr.warning("삭제할 라인을 선택해주세요.");
            return false;
        }
    	if ( workStatusCd=='C' && outputCardTable.rows().count() == 1 ) {
			toastr.warning("생산 완료 상태의 작지는 생산실적이 최소 한개 등록되어 있어야 합니다!");
            return false;
        }
        
    	$('#deleteOutputSubPopupModal').modal('show');
    });
        
	//생산실적 삭제처리
	$('#btnDeleteOutputSubCheck').on('click', function() {
    	if ( !$('#outputCardTable tr').hasClass('selected') ) {
			toastr.warning("삭제할 라인을 선택해주세요.");
            return false;
        }
    	if ( workStatusCd=='C' && outputCardTable.rows().count() == 1 ) {
			toastr.warning("생산 완료 상태의 작지는 생산실적이 최소 한개 등록되어 있어야 합니다!");
            return false;
        }
    	
    	tempTargetCnt = $('#targetCnt').val();

    	$.ajax({
			url: '<c:url value="po/outputCntDataDelete"/>',
			type: 'POST',
			async: false,
			data: {
            	'menuAuth'	 	: 		menuAuth,
             	'workOrdNo'   	:       function() { return workOrdNo; },
             	'ordLotNo'		:		function() { return ordLotNo; },
             	'lotNo'			:		function() { return mainMatrlLotNo; },
             	'stepCd'		:		function() { return ordLotNoStepCd; },
             	'workOrdSeq'   	:       function() { return workOrdSeq; },
             	'ordDate'		:		function() { return ordDateCal.replace(/-/g,""); },
            	'targetCnt'     :       function() { return tempTargetCnt; },
 	    		//'workStatusCd'  :       'E',		//컨트롤단에서 설정
             },
             success: function (res) {
                 if (res.result == 'ok') {
					$('#btnOrdLotNoFristStep').addClass('d-none');
					$('#btnOrdLotNoSecondStep').addClass('d-none');
					$('#firstWeight').val("0");
					$('#firstCount').val("0");
					$('#visionEdgeWeight').val("0");
					$('#visionEdgeCnt').val("0");
					$('#workOrdRegDate').val("");
					$('#btnOutputSave').attr('disabled',true);
					$('#gubun').attr('disabled',true);
    				$('#firstWeight').attr('disabled',true);
    				$('#workOrdDate').attr('disabled',true);
    				ordLotNo = null;
    				ordLotNoStepCd = null;
               	   	toastr.success(res.message);
                 } else if (res.result == 'fail') {
                	 toastr.warning(res.message, '', {timeOut: 5000});
                 } else {
                	 toastr.error(res.message, '', {timeOut: 5000});
                 }
             },
   	        complete:function(){
   	        	$('#outputCardTable').DataTable().ajax.reload( function () {});
   	        }
   	    });
    });

    $('#btnOutputAdd').on('click', function() {
    	$('#outputCardTable tbody tr').removeClass('selected');
    	outputBtnStat = 'add';
		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#workOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#workOrdDate').val(yesterday);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#workOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "D", "");
		}
		
    	//var date = getTodayType1();
		//$('#workOrdDate').val(date);    
		//if(workOrdNo.substring(11,14) == "001" || workOrdNo.substring(11,14) == "002"){
		//	selectBoxAppend(ordGubunCode, "gubun", "D", "");
		//} else{
		//	selectBoxAppend(ordGubunCode, "gubun", "N", "");	
		//}
		$('#workOrdRegDate').val("");
		$('#firstWeight').val("0");
		$('#firstCount').val("0");
		$('#visionEdgeWeight').val("0");
		$('#visionEdgeCnt').val("0");
    	$('#gubun').attr('disabled',false);
    	$('#firstWeight').attr('disabled',false);
    	$('#visionEdgeWeight').attr('disabled',false);
    	$('#workOrdDate').attr('disabled',false);
    	$('#btnOutputSave').attr('disabled',false);
    });
    

	/* -------------------------------------------------- 생산실적 기능 끝 -------------------------------------------------- */

	/* -------------------------------------------------- 불량중량 입력 기능 시작 -------------------------------------------------- */

	var serverDate =  "${serverDate}";
	var url = null;
	var prcssTemp = 0;
	var matrlTemp = 0;
	var replaceTemp = 0;
	var troubleTemp = 0;

	//불량 통계 조회
	function readTotal() {
		$.ajax({
			url: '<c:url value="po/readTotalFaulty"/>',
			type: 'GET',
			//async: false, --너무느려서 제외시킴
			data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'workOrdNo'			:		function() { return workOrdNo; },
  	        	'lotNo'				:		function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:		function() { return $('#faultyRegDate').val().replace(/-/g, ''); },	        	
  	        },
			beforeSend: function() {
				$('#my-spinner').show();
			},
  	        success: function (res) {
  	            let result = res.result;
  	          	let totatFaultyData = res.totatFaultyData;
				if (res.result == 'ok') {
	  	            	if(totatFaultyData == null) {
		  	            	$('#dayTotalPrcssCount').text("0");
		  	            	$('#nightTotalPrcssCount').text("0");
		  	            	$('#dayTotalMatrlCount').text("0");
		  	            	$('#nightTotalMatrlCount').text("0");
		  	            	$('#dayTotalReplaceCount').text("0");
		  	            	$('#nightTotalReplaceCount').text("0");
		  	            	$('#dayTotalTroubleCount').text("0");
		  	            	$('#nightTotalTroubleCount').text("0");

		  	            	$('#totalPrcssCount').text("0");
		  	            	$('#totalMatrlCount').text("0");
		  	            	$('#totalReplaceCount').text("0");
		  	            	$('#totalTroubleCount').text("0");

	  	            		$('#dayTotalPrcssSum').text("0");
		  	            	$('#nightTotalPrcssSum').text("0");
		  	            	$('#dayTotalMatrlSum').text("0");
		  	            	$('#nightTotalMatrlSum').text("0");
		  	            	$('#dayTotalReplaceSum').text("0");
		  	            	$('#nightTotalReplaceSum').text("0");
		  	            	$('#dayTotalTroubleSum').text("0");
		  	            	$('#nightTotalTroubleSum').text("0");
		  	            	
		  	            	$('#totalPrcssSum').text("0");
		  	            	$('#totalMatrlSum').text("0");
		  	            	$('#totalReplaceSum').text("0");
		  	            	$('#totalTroubleSum').text("0");
		  	            	
		  	            } else {
		  	            	$('#dayTotalPrcssCount').text(parseFloat(totatFaultyData.dayTotalPrcssCount));
		  	            	$('#nightTotalPrcssCount').text(parseFloat(totatFaultyData.nightTotalPrcssCount));
		  	            	$('#dayTotalMatrlCount').text(parseFloat(totatFaultyData.dayTotalMatrlCount));
		  	            	$('#nightTotalMatrlCount').text(parseFloat(totatFaultyData.nightTotalMatrlCount));
		  	            	$('#dayTotalReplaceCount').text(parseFloat(totatFaultyData.dayTotalReplaceCount));
		  	            	$('#nightTotalReplaceCount').text(parseFloat(totatFaultyData.nightTotalReplaceCount));
		  	            	$('#dayTotalTroubleCount').text(parseFloat(totatFaultyData.dayTotalTroubleCount));
		  	            	$('#nightTotalTroubleCount').text(parseFloat(totatFaultyData.nightTotalTroubleCount));

		  	            	$('#totalPrcssCount').text(parseFloat(totatFaultyData.totalPrcssCount));
		  	            	$('#totalMatrlCount').text(parseFloat(totatFaultyData.totalMatrlCount))
		  	            	$('#totalReplaceCount').text(parseFloat(totatFaultyData.totalReplaceCount));
		  	            	$('#totalTroubleCount').text(parseFloat(totatFaultyData.totalTroubleCount));
		  	            	
		  	            	$('#dayTotalPrcssSum').text(parseFloat(totatFaultyData.dayTotalPrcssSum));
		  	            	$('#nightTotalPrcssSum').text(parseFloat(totatFaultyData.nightTotalPrcssSum));
		  	            	$('#dayTotalMatrlSum').text(parseFloat(totatFaultyData.dayTotalMatrlSum));
		  	            	$('#nightTotalMatrlSum').text(parseFloat(totatFaultyData.nightTotalMatrlSum));
		  	            	$('#dayTotalReplaceSum').text(parseFloat(totatFaultyData.dayTotalReplaceSum));
		  	            	$('#nightTotalReplaceSum').text(parseFloat(totatFaultyData.nightTotalReplaceSum));
		  	            	$('#dayTotalTroubleSum').text(parseFloat(totatFaultyData.dayTotalTroubleSum));
		  	            	$('#nightTotalTroubleSum').text(parseFloat(totatFaultyData.nightTotalTroubleSum));
		  	            	
		  	            	$('#totalPrcssSum').text(parseFloat(totatFaultyData.totalPrcssSum));
		  	            	$('#totalMatrlSum').text(parseFloat(totatFaultyData.totalMatrlSum));
		  	            	$('#totalReplaceSum').text(parseFloat(totatFaultyData.totalReplaceSum));
		  	            	$('#totalTroubleSum').text(parseFloat(totatFaultyData.totalTroubleSum));		  	            	
						}
					} else if (res.result == 'fail') {
						toastr.warning("불량통계조회 실패하였습니다.", '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
  	            
					faultyTotal();	//합산 계산하기
					
				},
  	        complete:function(){
  	        	$('#my-spinner').hide();
			}
		});
	};

	$('#equipFaultyTable tbody').on('click', 'tr', function () {
		if (workOrdNo == null) {
			toastr.warning('작업지시를 선택해주세요.');
			return false;
		} else {
			if ($(this).hasClass('tableSelected')) {
				//$(this).removeClass('tableSelected');
			} else {
				equipFaultyTable = $(this).closest('tr').attr('id');
				faultyTime();
	        }
		}
	});

	/* -----------------------------------------------------------------공정불량 시작----------------------------------------------------------------- */

	//공정불량 행 클릭
  	$('.select_prcssFaulty').on('click', function() {
		if( workOrdNo != null){
			$('#cardSelect').removeClass('d-none');
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시
			$('#matrlFaultyView').addClass('d-none');
			$('#replaceFaultyView').addClass('d-none');
			$('#troubleFaultyView').addClass('d-none');
			
			$('#dayPrcssFaultyView').removeClass('d-none');
			$('#nightPrcssFaultyView').removeClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (prcssTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('#dayTbody').html(faultyTableDay());
				$('#nightTbody').html(faultyTableNight());
				prcssTemp = 1;
				matrlTemp = 0;
				replaceTemp = 0;
				troubleTemp = 0;
				sideView = "prcss";
				$('.day').attr('disabled', true);
				$('.dayTime').attr('disabled', true);
				$('.night').attr('disabled', true);
				$('.nightTime').attr('disabled', true);
							
				readPrcssFaulty();
			}
			else if (prcssTemp == 1) {
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				prcssTemp = 0;
			}
		}
	});

	//공정불량 주야 조회
	function readPrcssFaulty() {

		$('#faultyRegNm').text("등록자가 없습니다.");
  		//주간 공정불량
		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo; },
  	        	'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,""); },
  	        	'dayNightCd'		:	"D",
  	        	'gubun'				:	"001",  	        	
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayPrcssFaultySearchData').val("fail");
  	   	            } else {
						let data2 = res.readData;
						$.each(data2, function(i, it){
							$('#formDay1 table tbody tr td input[type=number]').each(function(index,item) {
								if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index % 2) + 1)) {
						  			$(this).val(it.faulty);
						  			$(this).closest('tr').find('td textarea').val(it.faultyDesc);
						  			//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
						  			//시간
						  			$('#prcssDay-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
						  		}
							});
						});
						$('#formDay1 table tbody tr td input[type=number]').each(function(index,item) {
							if($(this).val() == "") {
								$(this).val("0");
						 	}
						});
	  	   	           
	 	            	$('#dayPrcssFaultySearchData').val("success");
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				}
				else {
					toastr.error("주간 " + processFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayPrcssFaultySearchData').val() == "fail"){
  	  	  			$('.day').val("0");
  	  	  			$('.dayTime').val("");
  	  	  			$('.dayText').val("-");
  	  			}
			}
		});

		//야간 공정불량
		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'	 		: 	menuAuth,
				'equipCd'			:	function() { return equipCd; },
				'workOrdNo'			:	function() { return workOrdNo; },
				'lotNo'				:	function() { return mainMatrlLotNo; },
				'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,""); },
				'dayNightCd'		:	"N",
				'gubun'				:	"001",
			},
			success: function (res) {
			    let result = res.result;
			    let data = res.readData;
			    if (res.result == 'ok') {
			    	if ( data == null) {
			    		$('#nightPrcssFaultySearchData').val("fail");
			        } else {
			        	let data2 = res.readData;
						$.each(data2, function(i, it) {
								$('#formNight1 table tbody tr td input[type=number]').each(function(index,item) {
									if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
						  			$(this).val(it.faulty);
						  			$(this).closest('tr').find('td textarea').val(it.faultyDesc);
						  			//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
						  			//시간
						  			$('#prcssNight-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
						  		}
							});
						});
		  	   	    	$('#formNight1 table tbody tr td input[type=number]').each(function(index,item) {
		   	         		if($(this).val() == "") {
		   	         			$(this).val("0");
		  	   	        	}
						});
			        	$('#nightPrcssFaultySearchData').val("success");
			        	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} else {
					toastr.error("주간 " + processFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				}
			},
			complete:function(){
  	        	if ($('#nightPrcssFaultySearchData').val() == "fail"){
  	        		$('.night').val("0");
  	        		$('.nightTime').val("");
  	  	  			$('.nightText').val("-");
  	  			}
			}
		});
	};

	/* -----------------------------------------------------------------공정불량 끝----------------------------------------------------------------- */
	
	function faultyDataCheck(dayNightNm, dayNightCd, tempSideView)
	{
		//var faultyArray = new Array();
		var dataCheck = false;
		var faultyType;
		var gubun;
		//var count = 0;
		
		if (tempSideView == 'prcss') {
			faultyType = '1';
			gubun = '001';
		} else if (tempSideView == 'matrl') {
			faultyType = '2';
			gubun = '002';
		} else if (tempSideView == 'replace') {
			faultyType = '3';
			gubun = '003';
		} else if (tempSideView == 'trouble') {
			faultyType = '4';
			gubun = '004';
		} else {
			faultyType = 'error';
		}
		
		//에러발생
		if (faultyType == 'error') {
			//아직안했음
		} else {

			//if (gubun == '001' || gubun == '002') {
			//	$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
			//		if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
			//			var rowData = new Object();
			//			rowData.equipCd = equipCd;
			//			rowData.workOrdNo = workOrdNo;
			//			rowData.ordDate	= ordDateCal.replace(/-/g, '');
			//			rowData.dayNightCd = dayNightCd;
			//			rowData.faulty = $(this).val();
			//			rowData.gubun = gubun;
			//			rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
			//			rowData.systemCode = index + 1;
			//			rowData.faultySeq = 1;
			//			rowData.faultyDesc = '';
			//			count++;
			//			faultyArray.push(rowData);
			//		}
			//	});
			//} else
			if (gubun == '003') {
				$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
					if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
						var rowData = new Object();
						//rowData.equipCd = equipCd;
						//rowData.workOrdNo = workOrdNo;
						//rowData.ordDate	= ordDateCal.replace(/-/g, '');
						//rowData.dayNightCd = dayNightCd;
						//rowData.faulty = $(this).val();
						//rowData.gubun = '003';
						//rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						//rowData.workOrdNo = workOrdNo;
						//rowData.systemCode = (parseInt(index/5)+1);
						//rowData.faultySeq =  (parseInt(index%5)+1);
						//rowData.faultyDesc = '';
						//시간
						//rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).val();

						if ($('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).val() == '') {
							$('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).focus();
							toastr.warning("불량 시간을 선택해주세요!");
							dataCheck = true;
							return false;
						}
						
						//count++;
						//faultyArray.push(rowData);
					}
				});
			//} else if (gubun == '004') {
			} else if (gubun == '001' || gubun == '002' || gubun == '004') {
				$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
					if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
						//var rowData = new Object();
						//rowData.equipCd = equipCd;
						//rowData.workOrdNo = workOrdNo;
						//rowData.ordDate	= ordDateCal.replace(/-/g, '');
						//rowData.dayNightCd = dayNightCd;
						//rowData.faulty = $(this).val();
						//rowData.gubun = gubun;
						//rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						//rowData.systemCode = (parseInt(index / 2) + 1);
						//rowData.faultySeq = (parseInt(index % 2) + 1);
						////rowData.faultyDesc = $(this).closest('tr').find('td input[type=text]').val();
						//rowData.faultyDesc = $(this).closest('tr').find('td textarea').val();
						//시간
						//rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).val();
						if ($('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).val() == '') {
							$('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).focus();
							toastr.warning("불량 시간을 선택해주세요!");
							dataCheck = true;
							return false;
						}
						
						//count++;
						//faultyArray.push(rowData);
					}
				});
			}

			//1개이상 등록 후 전체삭제시 통계에서 join시 미표시 방지
			//if (count == 0) {
			//	var rowData = new Object();
			//	rowData.equipCd = equipCd;
			//	rowData.workOrdNo = workOrdNo;
			//	rowData.dayNightCd = dayNightCd;
			//	rowData.gubun = gubun;
			//	rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
			//	rowData.systemCode = 'empty';
			//	faultyArray.push(rowData);
			//}
		}

		//console.log(faultyArray);
		return dataCheck;
	}
	
	//불량중량 데이터 묶음 생성
	function createFaultyArray(dayNightNm, dayNightCd, tempSideView, mainMatrlLotNo)
	{
		var faultyArray = new Array();
		var faultyType;
		var gubun;
		var count = 0;
		var tbodyText ='';
		var check = false;
		
		if (tempSideView == 'prcss') {
			//생산-공정 조정			
			faultyType = '1';
			gubun = '001';
			tbodyText ='dayTbody';
		} else if (tempSideView == 'matrl') {
			//생산-원자재불량 교체
			faultyType = '2';
			gubun = '002';
			tbodyText = 'dMatrlTbody';
		} else if (tempSideView == 'replace') {
			//생산-교체 Loss
			faultyType = '3';
			gubun = '003';
			tbodyText='day3Tbody';
		} else if (tempSideView == 'trouble') {
			//생산-설비 부품 교체
			faultyType = '4';
			gubun = '004';
			tbodyText = 'day4Tbody';
		} else {
			faultyType = 'error';
		}
		
		//에러발생
		if (faultyType == 'error') {
			//아직안했음
		} else {

			//if (gubun == '001' || gubun == '002') {
			//	$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
			//		if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
			//			var rowData = new Object();
			//			rowData.equipCd = equipCd;
			//			rowData.workOrdNo = workOrdNo;
			//			rowData.lotNo = mainMatrlLotNo;
			//			rowData.ordDate	= ordDateCal.replace(/-/g, '');
			//			rowData.dayNightCd = dayNightCd;
			//			rowData.faulty = $(this).val();
			//			rowData.gubun = gubun;
			//			rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
			//			rowData.systemCode = index + 1;
			//			rowData.faultySeq = 1;
			//			rowData.faultyDesc = '';
			//			count++;
			//			faultyArray.push(rowData);
			//		}
			//	});
			//} else
			
			if (gubun == '003') {
				//faultyCount 값 계산하는 부분
				var faultyCount =0;
				var faultyCountArray = new Array();
				for(var j=1; j<=replaceFaultyCode.length; j++){
				    faultyCount = 0;
				    j<10 ? j = '00'+j : j = '0'+j;
				    if(dayNightCd == "D"){
				    	var text = tbodyText+"TrDay-"+j;
					}else if(dayNightCd == "N"){
						var text = tbodyText+"TrNight-"+j;
					}
				    for(var i=0; i<=4; i++){
					    if($('#'+text+' td').eq(i).find('input').val() != 0){
				            faultyCount = faultyCount+1;
				        }
				        if(i==4){
				            faultyCountArray.push(faultyCount);
				        }
				    }
				}
				//faultyCount 값 계산하는 부분 끝
				$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
					if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {

						var rowData = new Object();
						rowData.equipCd = equipCd;
						rowData.workOrdNo = workOrdNo;
						rowData.lotNo = mainMatrlLotNo;
						rowData.ordDate	= ordDateCal.replace(/-/g, '');
						rowData.dayNightCd = dayNightCd;
						rowData.faulty = $(this).val();
						rowData.gubun = '003';
						rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						rowData.workOrdNo = workOrdNo;
						rowData.systemCode = $(this).closest('tr').attr('id').split('-')[1];
						rowData.faultySeq =  (parseInt(index%5)+1);
						rowData.faultyDesc = '';

						//faultyCount 값 넣어주는 부분
						
					 	for(var j=1; j<=replaceFaultyCode.length; j++){
							if(rowData.systemCode == replaceFaultyCode[j-1].baseCd){
								rowData.faultyCount = faultyCountArray[j-1];
							}
						} 
						
						//faultyCount 값 넣어주는 부분
						/*
						 for(var i=0; i<=Math.round($('#'+tbodyText+' tr').length/3)-1; i++){
							if(rowData.systemCode == i){
								rowData.faultyCount = faultyCountArray[i-1];
							}
						} */
						//faultyCount 값 넣어주는 부분 끝
						
						//시간
						rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).val();
						rowData.faultyId = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).attr('id');
						count++;
						faultyArray.push(rowData);
					}
				});							
				
			//} else if (gubun == '004') {
			} else if (gubun == '001' || gubun == '002' || gubun == '004') {
				//faultyCount 값 계산하는 부분
				var faultyCount =0;
				var faultyCountArray = new Array();
				for(var j=1; j<=$('#'+tbodyText+' tr').length/2-1; j++){
				    faultyCount = 0;
				    j<10 ? j = '00'+j : j = '0'+j;
				    
				    if(dayNightCd == "D"){
				    	var text = tbodyText+"TrDay-"+j;
					} else if(dayNightCd == "N"){
						var text = tbodyText+"TrNight-"+j;
					}
				    
				    for(var i=0; i<=1; i++){
				        if($('#'+text+' td').eq(i).find('input').val() != 0){
				            faultyCount = faultyCount+1;
				        }
				        if(i==1){
				            faultyCountArray.push(faultyCount);
				        }
				    }
				}
				//faultyCount 값 계산하는 부분 끝
				$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
					if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
						var rowData = new Object();
						rowData.equipCd = equipCd;
						rowData.workOrdNo = workOrdNo;
						rowData.lotNo = mainMatrlLotNo;
						rowData.ordDate	= ordDateCal.replace(/-/g, '');
						rowData.dayNightCd = dayNightCd;
						rowData.faulty = $(this).val();
						rowData.gubun = gubun;
						rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						rowData.systemCode = $(this).closest('tr').attr('id').split('-')[1];
						rowData.faultySeq = (parseInt(index % 2) + 1);
						//rowData.faultyDesc = $(this).closest('tr').find('td input[type=text]').val();
						rowData.faultyDesc = $(this).closest('tr').find('td textarea').val();
						//시간
						rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).val();
						rowData.faultyId = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).attr('id');

						if(gubun == '001'){
							//faultyCount 값 넣어주는 부분
							for(var i=1; i<=processFaulty.length; i++){
								if(rowData.systemCode ==  processFaulty[i-1].baseCd){
									rowData.faultyCount = faultyCountArray[i-1];
								}
							}
							//faultyCount 값 넣어주는 부분 끝
							 
						} else if(gubun == '002'){
							//faultyCount 값 넣어주는 부분
							for(var i=1; i<=matrlFaulty .length; i++){
								if(rowData.systemCode == matrlFaulty[i-1].baseCd){
									rowData.faultyCount = faultyCountArray[i-1];
								}
							}
							//faultyCount 값 넣어주는 부분 끝
							
						} else if(gubun == '004'){
							//faultyCount 값 넣어주는 부분
							for(var i=1; i<=troubleFaultyCode.length; i++){
								if(rowData.systemCode == troubleFaultyCode[i-1].baseCd){
									rowData.faultyCount = faultyCountArray[i-1];
								}
							}
							//faultyCount 값 넣어주는 부분 끝
							
						}

						/*
						for(var i=0; i<=$('#'+tbodyText+' tr').length/2-1; i++){
							if(rowData.systemCode == i){
								rowData.faultyCount = faultyCountArray[i-1];
							}
						} */
						//faultyCount 값 넣어주는 부분 끝
						count++;
						faultyArray.push(rowData);
					}
				});
			}

			$.each(faultyArray,function(index, item) {
				if(index != 0){
					if(faultyArray[index].systemCode == faultyArray[index-1].systemCode){ //같은 라인일 때
						if(faultyArray[index-1].faultyDatetime > faultyArray[index].faultyDatetime){
							$('#' + faultyArray[index].faultyId).focus();
							toastr.warning("전 회차의 시간보다 빠를 수 없습니다.");	
							check = true;							
							return false;
						}							
					}
				}
			});

			//1개이상 등록 후 전체삭제시 통계에서 join시 미표시 방지
			if (count == 0) {
				var rowData = new Object();
				rowData.equipCd = equipCd;
				rowData.workOrdNo = workOrdNo;
				rowData.lotNo = mainMatrlLotNo;
				rowData.dayNightCd = dayNightCd;
				rowData.gubun = gubun;
				rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
				rowData.systemCode = 'empty';
				faultyArray.push(rowData);
			}			
		}

		//console.log(faultyArray);
		if(check){
			faultyArray = new Array();
			return faultyArray;
		} else{
			return faultyArray;
		}
		
	}
	
	//주간 저장 버튼
	$('#dayBtnSave').on('click', function() {
    	if (workOrdNo == "" || workOrdNo == null) {
    		toastr.warning("불량중량을 입력할 작업지시를 선택해주세요!");
			return false;
    	}
    	if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("불량중량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if ($('#nowTime option:selected').val() == "") {
			toastr.warning("주야구분을 선택해주세요.");
			$('#gubun').focus();
			return false;
		}
		if ($('#faultyRegDate').val() == "") {
			toastr.warning("전표일자를 선택해주세요.");
			$('#faultyRegDate').focus();
			return false;
		}
		
		$('#my-spinner').show();
		
		//let dayPrcssFaultySearchData = $('#dayPrcssFaultySearchData').val();
		//if ( dayPrcssFaultySearchData == "success" ){
		//	url = '<c:url value="po/updateFaultyAll"/>';
		//} else if ( dayPrcssFaultySearchData == "fail" ) {
			let url = '<c:url value="po/createFaultyAll"/>';
		//}
		
		var faultyArray = new Array();
		let tempSideView = sideView;

		//중량 입력 후 시간선택 X
		if (faultyDataCheck('Day', 'D', tempSideView)) {
			$('#my-spinner').hide();
			
		//중량 입력 후 시간선택 O - 정상
		} else {
			faultyArray = createFaultyArray('Day', 'D', tempSideView, mainMatrlLotNo);
			if(faultyArray.length == 0){
				$('#my-spinner').hide();
				return false;
			} else{
				$.ajax({
					url: url,
					type: 'POST',
					async: false,
					data: JSON.stringify(faultyArray),
					contentType : "application/json; charset=UTF-8",
					success: function (res) {
		   	            let result = res.result;
		   	            if (res.result == 'ok') {
			   	     		if (sideView == 'prcss') {
			   	     			readPrcssFaulty();
			   	     			toastr.success("주간 " + processFaultyNm + " 저장되었습니다.");
				   	 		} else if (sideView == 'matrl') {
				   	 			readMatrlFaulty();
				   	 			toastr.success("주간 " + matrlFaultyNm + " 저장되었습니다.");
				   	 		} else if (sideView == 'replace') {
				   	 			readReplaceFaulty();
					   	 		toastr.success("주간 " + replaceFaultyNm + " 저장되었습니다.");
				   	 		} else if (sideView == 'trouble') {
				   	 			readTroubleFaulty();
				   	 			toastr.success("주간 " + troubleFaultyNm + " 저장되었습니다.");
				   	 		}
		 	            	//$('#dayPrcssFaultySearchData').val("success");
		   	        		readTotal();
						}
		   	            else if (res.result == 'fail'){
			   	     		if (sideView == 'prcss') {
			   	     			toastr.error("주간 " + processFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
				   	 		} else if (sideView == 'matrl') {
				   	 			toastr.error("주간 " + matrlFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
				   	 		} else if (sideView == 'replace') {
					   	 		toastr.error("주간 " + replaceFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
				   	 		} else if (sideView == 'trouble') {
				   	 			toastr.error("주간 " + troubleFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
				   	 		}
						} else if(res.result == 'duplicate'){
		   	            	toastr.warning("동시에 다른 사용자가 등록을 시도했습니다.", '', {timeOut: 5000});
		   	            	toastr.warning("다시 시도해주세요.", '', {timeOut: 5000});
		   	            	readTotal();
		   	            	
						} else if(res.result == 'error'){
							toastr.error(res.message, '', {timeOut: 5000});
						}
		   	        },
		   	        complete:function(){
		   	        	$('.day').attr('disabled', true);
		   	        	$('.dayTime').attr('disabled', true);
		   	        	$('#my-spinner').hide();
					}
				});
			}
		}
		

	});


	//야간 저장 버튼
	$('#nightBtnSave').on('click', function() {
		
		$('#my-spinner').show();
		
		//let dayPrcssFaultySearchData = $('#dayPrcssFaultySearchData').val();
		//if ( dayPrcssFaultySearchData == "success" ){
		//	url = '<c:url value="po/updateFaultyAll"/>';
		//} else if ( dayPrcssFaultySearchData == "fail" ) {
			let url = '<c:url value="po/createFaultyAll"/>';
		//}
		
		var faultyArray = new Array();
		let tempSideView = sideView;

		//중량 입력 후 시간선택 X
		if (faultyDataCheck('Night', 'N', tempSideView)) {
			$('#my-spinner').hide();
			
		//중량 입력 후 시간선택 O - 정상
		} else {
			faultyArray = createFaultyArray('Night', 'N', tempSideView, mainMatrlLotNo); //Night 시 n 반드시 대문자 N
			
			$.ajax({
				url: url,
				type: 'POST',
				async: false,
				data: JSON.stringify(faultyArray),
				contentType : "application/json; charset=UTF-8",
				success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
		   	     		if (sideView == 'prcss') {
		   	     			readPrcssFaulty();
		   	     			toastr.success("야간 " + processFaultyNm + " 저장되었습니다.");
			   	 		} else if (sideView == 'matrl') {
			   	 			readMatrlFaulty();
			   	 			toastr.success("야간 " + matrlFaultyNm + " 저장되었습니다.");
			   	 		} else if (sideView == 'replace') {
			   	 			readReplaceFaulty();
				   	 		toastr.success("야간 " + replaceFaultyNm + " 저장되었습니다.");
			   	 		} else if (sideView == 'trouble') {
			   	 			readTroubleFaulty();
			   	 			toastr.success("야간 " + troubleFaultyNm + " 저장되었습니다.");
			   	 		}
	 	            	//$('#dayPrcssFaultySearchData').val("success");
	 	            	
					} else if (res.result == 'fail'){
		   	     		if (sideView == 'prcss') {
		   	     			toastr.error("야간 " + processFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if (sideView == 'matrl') {
			   	 			toastr.error("야간 " + matrlFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if (sideView == 'replace') {
				   	 		toastr.error("야간 " + replaceFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		} else if (sideView == 'trouble') {
			   	 			toastr.error("야간 " + troubleFaultyNm + " 저장 실패하였습니다.", '', {timeOut: 5000});
			   	 		}
					} else if(res.result == 'duplicate'){
	   	            	toastr.error("동시에 다른 사용자가 등록을 시도했습니다.", '', {timeOut: 5000});
	   	            	toastr.error("다시시도해주세요.", '', {timeOut: 5000});
	   	            	
		   	     	} else if(res.result == 'error'){
		   	     		toastr.error(res.message, '', {timeOut: 5000});
		   	     	}
		   	     	readTotal();
	   	        },
	   	        complete:function(){
	   	        	$('.night').attr('disabled', true);
	   	        	$('.nightTime').attr('disabled', true);
	   	        	$('#my-spinner').hide();
				}
			});
		}
	});

	/* -----------------------------------------------------------------원자재불량 시작----------------------------------------------------------------- */
	//원자재불량 행 클릭
	$('.select_matrlFaulty').on('click', function() {
		if( equipCd != null){
			$('#cardSelect').removeClass('d-none');
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시
			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').removeClass('d-none');
			$('#nightMatrlFaultyView').removeClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (matrlTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
		        $('#dMatrlTbody').html(matrlFaultyTableDay());
		        $('#nMatrlTbody').html(matrlFaultyTableNight());
				prcssTemp = 0;
				matrlTemp = 1;
				replaceTemp = 0;
				troubleTemp = 0;
				sideView = "matrl";
						
				$('.day').attr('disabled', true);
				$('.dayTime').attr('disabled', true);
				$('.night').attr('disabled', true);
				$('.nightTime').attr('disabled', true);
				readMatrlFaulty();
			}
			else if (matrlTemp == 1) {
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				matrlTemp = 0;
			}
		}
	});

	//원자재불량 주야 조회
	function readMatrlFaulty() {
		$('#faultyRegNm').text("등록자가 없습니다.");
		//원자재 주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo;},
  	        	'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,""); },
  	        	'dayNightCd'		:	"D",
  	        	'gubun'				:	"002",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayMatrlFaultySearchData').val("fail");	
  	   	            } else {
  	   	           		let data2 = res.readData;
						$.each(data2, function(i, it){
		         			$('#formDay2 table tbody tr td input[type=number]').each(function(index,item) {
		         				if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%2)+1)){
		  	   	         			$(this).val(it.faulty);
		  	   	         			$(this).closest('tr').find('td textarea').val(it.faultyDesc);
					  				//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
					  				//시간
					  				$('#matrlDay-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
		  	   	         		}
							});
						});
			  	   	  	$('#formDay2 table tbody tr td input[type=number]').each(function(index,item) {
			         		if($(this).val() == "") {
			         			$(this).val("0");
			   	         	}
						});
	 	            	$('#dayMatrlFaultySearchData').val("success"); 
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} 
				else {
					toastr.error("주간 " + matrlFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayMatrlFaultySearchData').val() == "fail"){
  	        		$('.day').val("0");
  	        		$('.dayTime').val("");
  	        		$('.dayText').val("-");
  	  	  		}
			}
		});

 		//원자재 야간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo;},
  	        	'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,""); },
  	        	'dayNightCd'		:	"N",
  	        	'gubun'				:	"002",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#nightMatrlFaultySearchData').val("fail");
  	   	            } else {
						let data2 = res.readData;
						$.each(data2, function(i, it) {
							$('#formNight2 table tbody tr td input[type=number]').each(function(index,item) {
								if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
					  				$(this).val(it.faulty);
					  				$(this).closest('tr').find('td textarea').val(it.faultyDesc);
					  				//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
					  				//시간
					  				$('#matrlNight-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
					  			}
							});
						});
		  	   	    	$('#formNight2 table tbody tr td input[type=number]').each(function(index,item) {
		   	         		if($(this).val() == "") {
		   	         			$(this).val("0");
		  	   	        	}
						});
	  	        		$('#nightMatrlFaultySearchData').val("success");
	  	        		$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
  	            } else {
					toastr.error("야간 " + matrlFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#nightMatrlFaultySearchData').val() == "fail"){
  	        		$('.night').val("0");
//   	        		$('.nightTime').val("");
  	        		$('.nightText').val("-");
  	  	  		}
			}
		});
	};

	/* -----------------------------------------------------------------원자재불량 끝----------------------------------------------------------------- */


	/* -----------------------------------------------------------------교체불량 시작----------------------------------------------------------------- */
	//교체불량 행 클릭
	$('.select_replaceFaulty').on('click', function() {
		if( equipCd != null){
			$('#cardSelect').removeClass('d-none');
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시

			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').removeClass('d-none');
			$('#nightReplaceFaultyView').removeClass('d-none');
			$('#dayTroubleFaultyView').addClass('d-none');
			$('#nightTroubleFaultyView').addClass('d-none');
			
			if (replaceTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('#day3Tbody').html(replaceFaultyCodeTableDay());
				$('#night3Tbody').html(replaceFaultyCodeTableNight());
				prcssTemp = 0;
				matrlTemp = 0;
				replaceTemp = 1;
				troubleTemp = 0;
				sideView = "replace";
						
				$('.day').attr('disabled', true);
				$('.dayTime').attr('disabled', true);
				$('.night').attr('disabled', true);
				$('.nightTime').attr('disabled', true);
				readReplaceFaulty();
				
			} else if (replaceTemp == 1) {
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				replaceTemp = 0;
			}			
		}
	});

	//교체불량 주야 조회
	function readReplaceFaulty()	{
		$('#faultyRegNm').text("등록자가 없습니다.");
		//주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'workOrdNo'			:		function() { return workOrdNo;},
  	        	'lotNo'				:		function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:		function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
  	        	'dayNightCd'		:		"D",
  	        	'gubun'				:		"003",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if (data == null) {
  	            		$('#dayReplaceFaultySearchData').val("fail");
  	   	            } else {
		  	   	       	let data2 = res.readData;
		        		$.each(data2, function(i, it){
		   	         		$('#formDay3 table tbody tr td input[type=number]').each(function(index,item) {
		   	         		if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%5)+1)) {
			  	   	         		$(this).val(it.faulty);
					  				//시간
					  				$('#replaceDay-' + String(parseInt($(this).attr('id').split('-')[1]) + 5)).val(it.faultyDatetime);
			  	   	         	}
  	 						});
        				});
		        		$('#formDay3 table tbody tr td input[type=number]').each(function(index,item) {
	  	   	         		if($(this).val()=="") {
	  	   	         			$(this).val("0");
		  	   	         	}
 	 					});
	 	            	$('#dayReplaceFaultySearchData').val("success"); 
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} else if (res.result == 'fail') {
					toastr.warning("주간 " + replaceFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayReplaceFaultySearchData').val() == "fail") {
  	        		$('.day').val("0");
  	        		$('.dayTime').val("");
  	  	  		}
			}
		});

		//야간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'workOrdNo'			:		function() { return workOrdNo;},
  	        	'lotNo'				:		function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:		function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
  	        	'dayNightCd'		:		"N",
  	        	'gubun'				:		"003",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if (data == null) {
  	            		$('#nightReplaceFaultySearchData').val("fail");
  	   	            } else {
	  	   	         	let data2 = res.readData;
			  	   	      
	  	   	     		$.each(data2, function(i, it){		  	   	        	
	   	         			$('#formNight3 table tbody tr td input[type=number]').each(function(index,item){
	   	         			if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%5)+1)){
		  	   	         			$(this).val(it.faulty);
		  	   	         			//시간
		  	   	         			$('#replaceNight-' + String(parseInt($(this).attr('id').split('-')[1]) + 5)).val(it.faultyDatetime);
		  	   	         		}
	 						});
   						});
	  	   	     		$('#formNight3 table tbody tr td input[type=number]').each(function(index,item){
	  	   	         		if($(this).val()==""){
	  	   	         			$(this).val("0");
		  	   	         	}
						});	     	   	        
	 	            	$('#nightReplaceFaultySearchData').val("success"); 
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} else if (res.result == 'fail') {
					toastr.warning("야간 " + replaceFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			
  	        },
  	        complete:function(){
  	        	if ($('#nightReplaceFaultySearchData').val() == "fail"){
  	        		$('.night').val("0");
  	        		$('.nightTime').val("");
  	  	  		}
			}
		});
	};

	/* -----------------------------------------------------------------교체불량 끝----------------------------------------------------------------- */

	/* -----------------------------------------------------------------설비 트러블 불량 시작----------------------------------------------------------------- */
	//설비 트러블 행 클릭
	$('.select_troubleFaulty').on('click', function() {
		if( equipCd != null){
			$('#cardSelect').removeClass('d-none');
	        $('#cardDay').removeClass('d-none');	//주간 상단 버튼 표시
	        $('#cardNight').removeClass('d-none');	//야간 상단 버튼 표시
			$('#dayPrcssFaultyView').addClass('d-none');
			$('#nightPrcssFaultyView').addClass('d-none');
			$('#dayMatrlFaultyView').addClass('d-none');
			$('#nightMatrlFaultyView').addClass('d-none');
			$('#dayReplaceFaultyView').addClass('d-none');
			$('#nightReplaceFaultyView').addClass('d-none');
			$('#dayTroubleFaultyView').removeClass('d-none');
			$('#nightTroubleFaultyView').removeClass('d-none');

			if (troubleTemp == 0){
				$('.select_prcssFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_matrlFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				$('.select_troubleFaulty').css({ "background-color": "#0275D8", "color": "#ffffff" });
				$('#day4Tbody').html(troubleFaultyCodeTableDay());
				$('#night4Tbody').html(troubleFaultyCodeTableNight());
				prcssTemp = 0;
				matrlTemp = 0;
				replaceTemp = 0;
				troubleTemp = 1;
				sideView = "trouble";
				$('.day').attr('disabled', true);
				$('.dayTime').attr('disabled', true);
				$('.night').attr('disabled', true);
				$('.nightTime').attr('disabled', true);
						
				readTroubleFaulty();
			}
			else if (troubleTemp == 1) {
				$('.select_troubleFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				troubleTemp = 0;
			}			
		}
	});
	
	//설비 트러불 불량 주야 조회
	function readTroubleFaulty() {
		$('#faultyRegNm').text("등록자가 없습니다.");
		//주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo; },
  	        	'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,""); },
  	        	'dayNightCd'		:	"D",
  	        	'gubun'				:	"004",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if (data == null) {
  	            		$('#dayTroubleFaultySearchData').val("fail");
  	   	            } else {
						let data2 = res.readData;
	  	  				$.each(data2, function(i, it) {
	 	         			$('#formDay4 table tbody tr td input[type=number]').each(function(index,item) {
	 	         				if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%2)+1)){
		  	   	         			$(this).val(it.faulty);
			  	   	         		$(this).closest('tr').find('td textarea').val(it.faultyDesc);
					  				//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
					  				//시간
					  				$('#troubleDay-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
		  	   	         		}
							});
						});
			  	   	  	$('#formDay4 table tbody tr td input[type=number]').each(function(index,item) {
			         		if($(this).val() == "") {
			         			$(this).val("0");
			   	         	}
						});
	 	            	$('#dayTroubleFaultySearchData').val("success"); 
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} 
				else {
   	            	toastr.error("설비 트러불 불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
  	        },
  	        complete:function(){
  	        	if ($('#dayTroubleFaultySearchData').val() == "fail"){
  	  	  			$('.day').val("0");
  	  	  			$('.dayText').val("-");
  	  	  		}
			}
		});

		//야간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo;},
  	        	'lotNo'				:	function() { return mainMatrlLotNo; },
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
  	        	'dayNightCd'		:	"N",
  	        	'gubun'				:	"004",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#nightTroubleFaultySearchData').val("fail");
  	            		//viewClear();
  	   	            } else {
						let data2 = res.readData;
						$.each(data2, function(i, it) {
								$('#formNight4 table tbody tr td input[type=number]').each(function(index,item) {
									if(parseInt(it.systemCode) == $(this).closest('tr').attr('id').split('-')[1] && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
						  			$(this).val(it.faulty);
						  			$(this).closest('tr').find('td textarea').val(it.faultyDesc);
					  				//$(this).closest('tr').find('td input[type=text]').val(it.faultyDesc);
					  				//시간
					  				$('#troubleNight-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(it.faultyDatetime);
						  		}
							});
						});
		  	   	    	$('#formNight4 table tbody tr td input[type=number]').each(function(index,item) {
		   	         		if($(this).val() == "") {
		   	         			$(this).val("0");
		  	   	        	}
						});
	 	            	$('#nightTroubleFaultySearchData').val("success");
	 	            	$('#faultyRegNm').text("등록자 " +data[0].regNm+ "님");
					}
				} else {
					toastr.error("설비 트러불 불량 조회 실패하였습니다.", '', {timeOut: 5000});
				}
			},
			complete:function(){
				if ($('#nightTroubleFaultySearchData').val() == "fail") {
					$('.night').val("0");
					$('.nightText').val("-");
				}
			}
		});
	};
	
	/* -----------------------------------------------------------------설비 트러불 불량 끝----------------------------------------------------------------- */
    
	$('#inputDay').on('click', function() {
// 		$('#faultyRegDate').attr('disabled', false);
		$('.day').attr('disabled', false);
		$('.dayTime').attr('disabled', false);
		$('.night').attr('disabled', true);
		$('.nightTime').attr('disabled', true);
	});

	$('#inputNight').on('click', function() {
// 		$('#faultyRegDate').attr('disabled', false);
		$('.day').attr('disabled', true);
		$('.dayTime').attr('disabled', true);
		$('.night').attr('disabled', false);
		$('.nightTime').attr('disabled', false);
	});

	//주간 야간 SelectBox값이 변경되었을 떄
	function nowTimeChange() {
		var X = $('#nowTime').val();
		//console.log(X);
		//001 : 주간
		//002 : 야간
		if (X == "001") {
			$("#weeklyRange").removeClass('d-none');	//주간
			$("#NighttimeRange").addClass('d-none');	//야간 
		} else {
			$("#weeklyRange").addClass('d-none');	//주간
			$("#NighttimeRange").removeClass('d-none');	//야간
		}
	}

	function faultyTime(){
		//console.log("값 들어옴");
		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		var yesterday = new Date(new Date().setHours(0,0,0,0));
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#nowTime').val("002");
			$("#weeklyRange").addClass('d-none');
			$("#NighttimeRange").removeClass('d-none');
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#nowTime').val("002");
			$("#weeklyRange").addClass('d-none');
			$("#NighttimeRange").removeClass('d-none');

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#nowTime').val("001");
			$("#weeklyRange").removeClass('d-none');
			$("#NighttimeRange").addClass('d-none');
		}
	}
	
	function faultyTotal()
	{
		var countSum1 = parseFloat($("#dayTotalPrcssCount").text() || 0);
		var countSum2 = parseFloat($("#dayTotalMatrlCount").text() || 0);
		var countSum3 = parseFloat($("#dayTotalReplaceCount").text() || 0);
		var countSum4 = parseFloat($("#dayTotalTroubleCount").text() || 0);
		var daySum = (countSum1 + countSum2 + countSum3 + countSum4).toFixed(3);
		$("#dayCountSum").text(parseFloat(daySum));
		
		var countSum5 = parseFloat($("#nightTotalPrcssCount").text() || 0);
		var countSum6 = parseFloat($("#nightTotalMatrlCount").text() || 0);
		var countSum7 = parseFloat($("#nightTotalReplaceCount").text() || 0);
		var countSum8 = parseFloat($("#nightTotalTroubleCount").text() || 0);
		var nightSum = (countSum5 + countSum6 + countSum7 + countSum8).toFixed(3);
		$("#nightCountSum").text(parseFloat(nightSum));
		
		var countSum9 = parseFloat($("#totalPrcssCount").text() || 0);
		var countSum10 = parseFloat($("#totalMatrlCount").text() || 0);
		var countSum11 = parseFloat($("#totalReplaceCount").text() || 0);
		var countSum12 = parseFloat($("#totalTroubleCount").text() || 0);
		var countSum = (countSum9 + countSum10 + countSum11 + countSum12).toFixed(3);
		$("#totalCountSum").text(parseFloat(countSum));
		
		var totalSum1 = parseFloat($("#dayTotalPrcssSum").text() || 0);
		var totalSum2 = parseFloat($("#dayTotalMatrlSum").text() || 0);
		var totalSum3 = parseFloat($("#dayTotalReplaceSum").text() || 0);
		var totalSum4 = parseFloat($("#dayTotalTroubleSum").text() || 0);
		var daySum = (totalSum1 + totalSum2 + totalSum3 + totalSum4).toFixed(3);
		$("#dayTotalSum").text(parseFloat(daySum));
		
		var totalSum5 = parseFloat($("#nightTotalPrcssSum").text() || 0);
		var totalSum6 = parseFloat($("#nightTotalMatrlSum").text() || 0);
		var totalSum7 = parseFloat($("#nightTotalReplaceSum").text() || 0);
		var totalSum8 = parseFloat($("#nightTotalTroubleSum").text() || 0);
		var nightSum = (totalSum5 + totalSum6 + totalSum7 + totalSum8).toFixed(3);
		$("#nightTotalSum").text(parseFloat(nightSum));
		
		var totalSum9 = parseFloat($("#totalPrcssSum").text() || 0);
		var totalSum10 = parseFloat($("#totalMatrlSum").text() || 0);
		var totalSum11 = parseFloat($("#totalReplaceSum").text() || 0);
		var totalSum12 = parseFloat($("#totalTroubleSum").text() || 0);
		var totalSum = (totalSum9 + totalSum10 + totalSum11 + totalSum12).toFixed(3);
		$("#totalSum").text(parseFloat(totalSum));
	}

 /* -------------------------------------------------- 불량중량 입력 기능 끝 -------------------------------------------------- */

 /* -------------------------------------------------- 비가동사유 기능 시작 -------------------------------------------------- */
 	var baseGroupCd = null;

 	//비가동 newTable
 	$.fn.dataTable.ext.errMode = 'none';
	let notRunningTable = $('#notRunningTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        paging: true,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        searching: false,
        pageLength: 10,
        ajax: {
        	url: '<c:url value="/po/equipDowntimeAdmDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'			:	function () { return menuAuth; 						},
            	'equipCd'			:	function () { return equipCd; 						},
            	'downtimeRegDate'	:	function () { return ordDateCal.replace(/-/g, '');	},
            	'workOrdNo'			:	function () { return workOrdNo; 					}
            },
        },
		columns: [
			{ data: 'equipNm' 			},
			{ data: 'downtimeRegDate',
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data: 'startTime'	},
			{ data: 'endTime'	},
			{ data: 'stopTime',
				render : function(data, type, row, meta){
					if(data == null || data == ''){
						return '-';
					}else{
						return data.replace(' ', '일 ').replace(':', '시간 ') + '분';
					}
					
				}
			},
			{ data: 'downtimeNm'	},
			{ data: 'code1Nm'		},
// 			{ data: 'code2'			}
			{ data: 'code2',
	       		render: function(data, type, row, meta) {
	           		var html = '';
           				html = '<textarea>'+data+'</textarea>';
	           		return html;
	       		}
			}
			
		],
		order: [
			[ 0, 'asc' ],
		],
	  columnDefs: [
		  { targets: '_all', className: 'text-center touch6', "defaultContent": "-" } 
        ],
        order: [
			[ 0, 'asc' ],
		],
		rowCallback: function (row, data) {
			if (data.endTime == null) {
				$(row).addClass('skyYellow');
			}
		},
	    drawCallback: function( settings ) {
	    	$('#notRunningTable tbody tr td').css('height','40px');
	    	$('#notRunningTable tbody tr td').addClass("touch6");
	    }
    });

 	//비가동 oldTable
 	$.fn.dataTable.ext.errMode = 'none';
	let downtimeDtl = $('#downtimeDtl').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        paging: true,
        info: false,
        ordering: false,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        searching: false,
        pageLength: 20,
        ajax: {
            url: '<c:url value="bm/systemCommonCodeDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'		:		menuAuth,
            	'baseGroupCd'	:		function(){ return baseGroupCd; },
            },
        },
		columns: [
			{ 
				render: function(data, type, row, meta) {	    			
					return  meta.row + 1;
    			}
			},
			{
				render: function(data, type, row, meta) {						
					return  '<input type="checkbox" class="form-control touch6" name= "chk">';
    			}
			 },
			{ data : 'baseCdNm'}
		],
		order: [
			[ 0, 'asc' ],
		],
	  columnDefs: [
           { targets: 2, className: 'text-left' }         
        ],
	    drawCallback: function( settings ) {
	    	$('#downtimeDtl tbody tr td').css('height','40px');
	    	$('#downtimeDtl tbody tr td').addClass("touch6");
	    }
    });
 	    
 	$('#equipDowntimeAdmTable tbody').on('click', 'tr', function () {
		if( equipCd == null ){
			toastr.warning('설비명을 선택해주세요.');
			return false;
		}
		if ($('#ordGubunCd option:selected').val() == ""){
			toastr.warning("주야를 선택해주세요!");
			$('#ordGubunCd').focus();
			return false;
		}
		else{
			if ( $(this).hasClass('tableSelected') ) {
				
			}
	        else {
	        	$('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
	        	$(this).addClass('tableSelected');      
	        	
	        	//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);	
				//$(this).find('td').find('input').prop('disabled',false);
				
	        	startTime = $(this).find('td').find('input').eq(0).val();				
				endTime = $(this).find('td').find('input').eq(1).val();				
				stopTime = $(this).find('td').find('input').eq(2).val();
				downtimeCd = $(this).closest('tr').attr('id');			
				$('#btnDowntimeSave').attr('disabled',false);
				
				baseGroupCd = '012';
				$('#downtimeDtl').DataTable().ajax.reload(function() {
					$.ajax({
						url: '<c:url value="po/equipDowntimeAdmRead"/>',
						type: 'GET',
						async: false,
						data: {
			   	        	'menuAuth'	 		: 	menuAuth,
			   	        	'equipCd'			:	function() { return equipCd; }, 
			   	        	'downtimeRegDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
			   	        	'dayNightCd'		:	function() { return ordGubunCd; },
			   	        	'downtimeCd'		:   downtimeCd,
			   	        },
			   	        success: function (res) {
			   	        	var data = res.data;
			   	        	if (res.result == "ok"){
				   	        	if(data != null){
					   	        	if(data.code1 == "Y"){
					   	        		$('input[type=checkbox]').eq(0).attr("checked", true);
					   	        	}
					   	        	if(data.code2 == "Y"){
					   	        		$('input[type=checkbox]').eq(1).attr("checked", true);
					   	        	}
					   	        	if(data.code3 == "Y"){
					   	        		$('input[type=checkbox]').eq(2).attr("checked", true);
					   	        	}
					   	        	if(data.code4 == "Y"){
					   	        		$('input[type=checkbox]').eq(3).attr("checked", true);
					   	        	}
					   	        	if(data.code5 == "Y"){
					   	        		$('input[type=checkbox]').eq(4).attr("checked", true);
					   	        	}
					   	        	if(data.code6 == "Y"){
					   	        		$('input[type=checkbox]').eq(5).attr("checked", true);
					   	        	}
					   	        	if(data.code7 == "Y"){
					   	        		$('input[type=checkbox]').eq(6).attr("checked", true);
					   	        	}
				   	        	}
				   	        } else {
				   	        	toastr.error(res.message, '', {timeOut: 5000});
							}
			   	        }
					});
				});
	        }
		}
	});

 	var downtimeCd = null;
 	
	function reloadDowntimeAdm()
	{
	 	$.ajax({
    	    	url: '<c:url value="po/equipDowntimeAdmDataList"/>',
    	        type: 'GET',
    	        async: false,
    	        data: {
    	        	'menuAuth'	 		: 	menuAuth,
	   	        	'equipCd'			:	function() { return equipCd; }, 
	   	        	'downtimeRegDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
	   	        	'dayNightCd'		:   function() { return ordGubunCd; },
    	        },
    	        success: function (res) {
    	            var data = res.data;
	   	   	        $('#form').each(function(){
						 this.reset();				 
					});
    	       		$.each(data, function(index, item){
 					if(item.downtimeCd=="001" && item.startTime != null){								
 						$('#equipStartTime').val(item.startTime);
 						$('#equipEndTime').val(item.endTime);
 						$('#equipStopTime').val(item.stopTime);
 					} else if(item.downtimeCd=="002" && item.startTime != null){
 						$('#matrlStartTime').val(item.startTime);
 						$('#matrlEndTime').val(item.endTime);
 						$('#matrlStopTime').val(item.stopTime);
 					} else if(item.downtimeCd=="003" && item.startTime != null){
 						$('#planStartTime').val(item.startTime);
 						$('#planEndTime').val(item.endTime);
 						$('#planStopTime').val(item.stopTime);
 					} else if(item.downtimeCd=="004" && item.startTime != null){
 						$('#humanStartTime').val(item.startTime);
 						$('#humanEndTime').val(item.endTime);
 						$('#humanStopTime').val(item.stopTime);
 					} else if(item.downtimeCd=="005" && item.startTime != null){
 						$('#startTime').val(item.startTime);
 						$('#endTime').val(item.endTime);
 						$('#stopTime').val(item.stopTime);
 					}
    	         	});
       	       	baseGroupCd = null;
       	       	//$('#btnSave').attr('disabled',true);
       	        $('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
       	        //$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
				$('#downtimeDtl').DataTable().clear().draw();
       	        chooseDate = $('#downtimeRegDate').val();
			}
 		});
	}

	var downtimeCd = null;
	
	//비가동사유 저장
	$('#btnDowntimeSave').on('click', function(){
		if ($('#ordGubunCd option:selected').val() == ""){
			toastr.warning("주야를 선택해주세요!");
			$('#ordGubunCd').focus();
			return false;
		}
		var code = null;
		var code1Stat = null;
		var code2Stat = null;
		var code3Stat = null;
		var code4Stat = null;
		var code5Stat = null;
		var code6Stat = null;
		var code7Stat = null;
				
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(0).val() == "" ) {
	        toastr.warning('시작시간을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(0).focus();
			return false;
		}
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(1).val() == "" ) {
	        toastr.warning('종료시간을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(1).focus();
			return false;
		}
		if ( $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(2).val() == "" ) {
	        toastr.warning('중단시간을 입력해주세요');
	        $("#equipDowntimeAdmTable").find(".tableSelected").find('input').eq(2).focus();
			return false;
		}

		$("#equipDowntimeAdmTable").find(".selected").find('input').eq(0).val()
			$("[name='chk']:checked").each(function(){
				code = $(this).closest('tr').find('td').eq(0).html();
				
				if(code == 1){
					code1Stat = 'Y';
				} else if(code == 2){
					code2Stat = 'Y';
				} else if(code == 3){
					code3Stat = 'Y';
				} else if(code == 4){
					code4Stat = 'Y';
				} else if(code == 5){
					code5Stat = 'Y';
				} else if(code == 6){
					code6Stat = 'Y';
				} else if(code == 7){
					code7Stat = 'Y';
				}
			});

			$('#my-spinner').show();
		
		    $.ajax({
    	    	url: '<c:url value="po/equipDowntimeAdmCreate"/>',
    	        type: 'POST',
    	        async: false,
    	        data: {
    	        	'menuAuth'	 		: 	menuAuth,
    	        	'equipCd'			:	function() { return equipCd; }, 
    	        	'downtimeRegDate'	:	function() { return ordDateCal.replace(/-/g, ''); },
    	        	'dayNightCd'		:   function() { return ordGubunCd; },
    	        	'downtimeCd'  		:   downtimeCd,
    	        	'startTime'			:	$('#'+downtimeCd).find('td').find('input').eq(0).val(),
   	        		'endTime'			:	$('#'+downtimeCd).find('td').find('input').eq(1).val(),
        			'stopTime'			:	$('#'+downtimeCd).find('td').find('input').eq(2).val(),
    	        	'code1'  			:   code1Stat,
    	        	'code2'  			:   code2Stat,
    	        	'code3'  			:   code3Stat,
    	        	'code4'  			:   code4Stat,
    	        	'code5'  			:   code5Stat,
    	        	'code6'  			:   code6Stat,
    	        	'code7'  			:   code7Stat,
    	        },
    	        success: function (res) {
    	            var data = res.data;
    	       		if(res.result == "ok"){
    	       			toastr.success("비가동 사유등록 저장되었습니다.");
    	       			//$('#equipDowntimeAdmTable tbody tr').find('td').find('input').prop('disabled',true);
    	       			//$('#equipDowntimeAdmTable tbody tr').removeClass('tableSelected');
    	       			//$('#btnDowntimeSave').attr('disabled', true);
    	       			//$("input:checkbox[name='chk']").attr('disabled', true);
    	       			baseGroupCd = null;
    	       			//$('#downtimeDtl').DataTable().ajax.reload(function() {});
    	       		} else{
    	       			toastr.error(res.message, '', {timeOut: 5000});
    	       		}
    	       		$('#my-spinner').hide();
    	        }
          });
	});

	$('#equipStartTime, #equipEndTime, #matrlStartTime, #matrlEndTime, #planStartTime, #planEndTime, #humanStartTime, #humanEndTime, #startTime, #endTime').on('click', function() {
		if( $(this).val() == "" ){
			let Now = new Date();
			$(this).val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		}
	});
	
	//설비문제 시간계산
	$('#equipStartTime').change(function() {
		if ( $('#equipStartTime').val() != "" && $('#equipEndTime').val() != "" ) {
			let startTime = $('#equipStartTime').val();
			let endTime = $('#equipEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#equipStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	$('#equipEndTime').change(function() {
		if ( $('#equipStartTime').val() != "" && $('#equipEndTime').val() != "" ) {
			let startTime = $('#equipStartTime').val();
			let endTime = $('#equipEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#equipStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	//자재부족 시간계산
	$('#matrlStartTime').change(function() {
		if ( $('#matrlStartTime').val() != "" && $('#matrlEndTime').val() != "" ) {
			let startTime = $('#matrlStartTime').val();
			let endTime = $('#matrlEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#matrlStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	$('#matrlEndTime').change(function() {
		if ( $('#matrlStartTime').val() != "" && $('#matrlEndTime').val() != "" ) {
			let startTime = $('#matrlStartTime').val();
			let endTime = $('#matrlEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#matrlStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	//계획정지 시간계산
	$('#planStartTime').change(function() {
		if ( $('#planStartTime').val() != "" && $('#planEndTime').val() != "" ) {
			let startTime = $('#planStartTime').val();
			let endTime = $('#planEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#planStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	$('#planEndTime').change(function() {
		if ( $('#planStartTime').val() != "" && $('#planEndTime').val() != "" ) {
			let startTime = $('#planStartTime').val();
			let endTime = $('#planEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#planStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	//인원부족 시간계산
	$('#humanStartTime').change(function() {
		if ( $('#humanStartTime').val() != "" && $('#humanEndTime').val() != "" ) {
			let startTime = $('#humanStartTime').val();
			let endTime = $('#humanEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#humanStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	$('#humanEndTime').change(function() {
		if ( $('#humanStartTime').val() != "" && $('#humanEndTime').val() != "" ) {
			let startTime = $('#humanStartTime').val();
			let endTime = $('#humanEndTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#humanStopTime').val( hour + "시간 " + minute + "분");
		}
	});

	//기타 시간계산
	$('#startTime').change(function() {
		if ( $('#startTime').val() != "" && $('#endTime').val() != "" ) {
			let startTime = $('#startTime').val();
			let endTime = $('#endTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#stopTime').val( hour + "시간 " + minute + "분");
		}
	});

	$('#endTime').change(function() {
		if ( $('#startTime').val() != "" && $('#endTime').val() != "" ) {
			let startTime = $('#startTime').val();
			let endTime = $('#endTime').val();
			let startTimeToMinute = timeToMinute(startTime);
			let endTimeToMinute = timeToMinute(endTime);
			let hour = parseInt((endTimeToMinute - startTimeToMinute) / 60);
			let minute = (endTimeToMinute - startTimeToMinute) % 60;
			$('#stopTime').val( hour + "시간 " + minute + "분");
		}
	});

	//시분 -> 분으로 변환
	function timeToMinute(time) {
		time = time.split(/:/);
	    let hour = time[0]
	    let minute = time[1];
	    let changeMinute = (parseInt(hour) * 60 ) + parseInt(minute);
	    return changeMinute;
	}
	
 	/* -------------------------------------------------- 비가동사유 기능 끝 -------------------------------------------------- */

 	$(document).on('keyup','.number-float2', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float2').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
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
		
 		var _pattern2 = /^\d*[.]\d{3}$/;
        if (_pattern2.test( $(this).val())) {
        	toastr.warning("소수점 둘째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
        }
		if($(this).val().split('.').length >= 10) {
			toastr.warning('소수점기호는 한번만 입력 가능합니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}
	});


	$(document).on('click','.form-control', function(event) {
   		$(this).select();
   	});

	//$('#closeLeftView').css('padding','9px');
	//$('#btnEnd').css('margin-right','5px');
	//$('#btnStart').css('margin-right','5px');
	//$('#btnStart').css('margin-right','5px');
	//$('#openFullScreen').css('margin-right','5px');
	//$('#closeFullScreen').css('margin-right','5px');

	//전체화면(f11)감지
	$(window).resize(function () {
	    if ((screen.availHeight || screen.height - 30) <= window.innerHeight) {
	    	$('#mainCard').css('height','970px');
	    	$('#rightList').css('min-height','915px');
	    } else {
	    	$('#mainCard').css('height','835px');
	    	$('#rightList').css('min-height','825px');
	    }
	});

	//전체화면	
    $('#openFullScreen').on('click', function(){
    	openFullScreenMode();
    });

	//전체화면 해제
    $('#closeFullScreen').on('click', function(){
    	closeFullScreenMode();
    });
    
	//숫자만 입력, 길이, 소수점 세자리까지 제한
	$(document).on('keyup','.number-float3', function(event) {
 		if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
			$('.number-float3').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
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
			toastr.warning("최대 크기를 초과하였습니다.");
			$(this).val("0");
 			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$(this).val("0");
 			$(this).select();
			return false;
		}

 		var _pattern3 = /^\d*[.]\d{4}$/;	//누르고있는 키는 예외처리 안됨
        if (_pattern3.test( $(this).val())) {
        	toastr.warning("소수점 셋째 자리까지 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}
	});


	/* //투입자재 추가 > 투입할 자재목록 테이블
	let matrlTable = $('#matrlTable').DataTable({
        language: lang_kor,
        lengthChange : false,
        paging: true,
        info: true,
        ordering: true,
        processing: false,
        autoWidth: false,
        pageLength: 15,
        select: {
		    style: 'single',
		    toggleable: false,
		    items: 'row',
		    info: false
		},
        ajax: {
            url: '<c:url value="/bm/matrlCdDataList"/>',
            type: 'GET',
            async: false,
            data: {
            },
        },
        rowId: 'matrlSeq',
        columns: [
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'matrlInitial' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
        ],
        columnDefs: [
        	{ "targets": [0], "visible" : true },
        	{"className": "text-center p-2", "targets": "_all"}
        ],
        order: [
            [ 0, 'asc' ]
        ],

        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ],
    }); */

	//투입자재 추가 > 투입한 자재목록 테이블
	let matrlDtlTable = $('#matrlDtlTable').DataTable({
        language: lang_kor,
        lengthChange : false,
        paging: true,
        info: true,
        ordering: true,
        processing: false,
        autoWidth: false,
        pageLength: 10,
        select: {
		    style: 'single',
		    toggleable: false,
		    items: 'row',
		    info: false
		},
        ajax: {
            url: '<c:url value="/bm/goodsMatrlDtlListAll"/>',
            type: 'POST',
            async: false,
            data: {
                'goodsCd'	:	function(){ return matrlAddListGoodsCd; }
            },
        },
        columns: [
            { data: 'matrlCd' },
            { data: 'matrlNm' },
            { data: 'matrlInitial' },
            { data: 'qutyNm' },
            { data: 'gubunNm' },
            { data: 'goodsMatrlDesc', className: 'p-1',
           		render : function(data, type, row, meta) {
           			return '<input type="text" class="form-control mw-100" name="goodsMatrlDesc" id="goodsMatrlDesc-' + meta.row + '" value="' + data + '" disabled>';
				}
            }
        ],
        columnDefs: [
        	{ "targets": [0], "visible" : true },
        	{"className": "text-center p-2", "targets": "_all"}
        ],
        order: [
            [ 0, 'asc' ]
        ],

        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ] 
    });
	
	//투입자재 목록 버튼 click
	$('#btnMatrlList').on('click', function() {
		$('#matrlDtlTableTitle').text('추가 투입자재목록 (' + matrlAddListGoodsCd + '/' + matrlAddListGoodsNm + ')');
		$('#matrlDtlTableModal').modal('show');
		$('#matrlDtlTable').DataTable().ajax.reload( function () {});
	});

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ자재 투입 선입선출 여부ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ// 
	let fifoCheckBarcodeNo = "empty";
	let fifoCheckTable;
	let fifoCheckHistoryTable;
	fifoCheckTFuck();
	fifoCheckTHistoryFuck();
	
	//선입선출 여부 버튼 클릭 시
	$('#btnFifoCheck').on('click', function() {
		$('#fifoCheckTable').DataTable().clear().draw();
		$('#fifoCheckHistoryTable').DataTable().clear().draw();
		$('#fifoCheckBarcodeNo').val("");
		$('#fifoCheckBarcodeNo').focus();
		fifoCheckBarcodeNo = "empty";

		$('#fifoCheckModal').modal('show');
	});

	//선입선출여부 바코드 스캔 시
	$("#fifoCheckBarcodeNo").keypress(function (e) {
	    if (e.which == 13) {
	    	if ($('#fifoCheckBarcodeNo').val() == "") {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#fifoCheckBarcodeNo').focus();
	            return false;
	        }
	    	fifoCheckBarcodeNo = $('#fifoCheckBarcodeNo').val().trim();
	    	fifoCheckTFuck();
	    	fifoCheckTHistoryFuck();
	    }
	});

	//선입선출 테이블 함수
	function fifoCheckTFuck(){
		if(fifoCheckTable == null || fifoCheckTable == undefined) {
			//선입선출 자재 조회
			$.fn.dataTable.ext.errMode = 'none';
			fifoCheckTable = $('#fifoCheckTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		    	if(techNote == 7) {
			    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			       	location.href = "/";
				}
			}).DataTable({
				dom: "<'row'<'col-sm-12 col-md-10'><'col-sm-12 col-md-2'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'><'col-sm-12 col-md-7'>>",           
		        language: lang_kor,
		        paging: false,
		        lengthChange: false,
		        pageLength: 20,
		        ajax: {
		            url: '<c:url value="io/matrlInOutWhsDataList"/>',
		            type: 'GET',
		            async: false,
		            data: {
		            	'menuAuth'	 	: 	menuAuth,
		            	'barcodeNo' 	:	function() { return fifoCheckBarcodeNo; }
		            },
		        },
		        //rowId: 'workOrdNo',
				columns: [
					{ data: 'barcodeNo'			}
					, { data: 'matrlNm' 		}
					, { data: 'preOutWhsDate',
						 render: function(data, type, row) {
								if(data != "") {
									return moment(data).format("YYYY-MM-DD");
								} else {
									return "-";
								}
						    }
					}
					, { data: 'fifoCheck',
						 render: function(data, type, row) {
							if (data == "Y") {
								return "적용";
							} else if (data == "N") {
								return "미적용";
							}
						}
					}
					, { render: function(data, type, row, meta) {
	    					return '<button type="button" class="btn btn-primary touch6" id="btnFifoChangeCheck">변경</button>';
		    			}
		    		}
				],
		        columnDefs: [
		        	{ targets: "_all", className: 'text-center' },
				],
				drawCallback: function( settings ) {
					$('#fifoCheckTable').attr('style', 'width: 57vh;');
			    },
		        rowCallback: function (row, data) {
					if (data.fifoCheck == 'N') {
						$(row).addClass('skyYellow');
					}
				},
		    });
		} else {
			$('#fifoCheckTable').DataTable().ajax.reload();
		}
		$('#fifoCheckTable').attr('style', 'width: 57vh;');
	}

	
	//선입선출 내역
	function fifoCheckTHistoryFuck(){
		if(fifoCheckHistoryTable == null || fifoCheckHistoryTable == undefined) {
			//선입선출 자재 조회
			$.fn.dataTable.ext.errMode = 'none';
			fifoCheckHistoryTable = $('#fifoCheckHistoryTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		    	if(techNote == 7) {
			    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			       	location.href = "/";
				}
			}).DataTable({
				 dom: "<'row'<'col-sm-12 col-md-10'l><'col-sm-12 col-md-2'>>"
				+ "<'row'<'col-sm-12'tr>>"
				+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>",           
				language: lang_kor,
				paging: true,
				info: false,
				ordering: true,
				processing: true,
				lengthChange: false,
				pageLength: 10,
		        ajax: {
		            url: '<c:url value="io/inputFifoCheck"/>',
		            type: 'GET',
		            async: false,
		            data: {
		            	'menuAuth'	 	: 	menuAuth,
		            	'barcodeNo' 	:	function() { return fifoCheckBarcodeNo; }
		            },
		        },
		        //rowId: 'workOrdNo',
				columns: [
					{ data: 'barcodeNo'			}
					, { data: 'matrlNm' 		}
					, { data: 'preOutWhsDate',
						 render: function(data, type, row) {
								if(data != "") {
									return moment(data).format("YYYY-MM-DD");
								} else {
									return "-";
								}
						    }
					}
					, { data: 'fifoCheck',
						 render: function(data, type, row) {
							if (data == "Y") {
								return "적용";
							} else if (data == "N") {
								return "미적용";
							}
						}
					}
				],
		        columnDefs: [
		        	{ targets: "_all", className: 'text-center' },
				],
				drawCallback: function( settings ) {
					$('#fifoCheckHistoryTable').attr('style', 'width: 81vh;margin-left: -11px;');
			    },
		    });
		} else {
			$('#fifoCheckHistoryTable').DataTable().ajax.reload();
		}
		$('#fifoCheckHistoryTable').attr('style', 'width: 81vh;margin-left: -11px;');
	}

	//테이블 변경 버튼 클릭시
	$(document).on('click', "#btnFifoChangeCheck", function(event){
		$('#fifoAuthorityCheckUserId').attr('disabled',false);
        $('#fifoAuthorityCheckUserPassword').attr('disabled',false);
		$('#btnFifoAuthorityCheck').attr('disabled',false);
		$('#selectFifoCheck').attr('disabled',false);
		$('#btnFifoChange').attr('disabled',true);
		$('#fifoAuthorityCheckUserId').val("");
        $('#fifoAuthorityCheckUserPassword').val("");

        selectBoxAppend(matrlFifoCheck, "selectFifoCheck", "", "2");	//선입선출
        
		$('#fifoAuthorityCheckModal').modal('show');
	});

	//모달 선입선출  변경 버튼 클릭시
	$('#btnFifoChange').on('click', function(){

		let fifoCheckDataArray = "";

		$.each(fifoCheckTable.data().splice(","), function(index,item){
			fifoCheckDataArray += "/" + item.barcodeNo;
		});

		if($('#selectFifoCheck option:selected').val() == "" ) {
			toastr.warning("선입선출을 선택해 주세요.");
			$('#selectFifoCheck').focus();
			return false;
		}

		$.ajax({
			url: '<c:url value="/qm/matrlFifoCheck_iosc0030"/>',
			type: 'POST',
			data: {
				'menuAuth'		: 	menuAuth,
				'slashLotNo'	: 	function() { return fifoCheckDataArray; },
				'fifoCheck'		: 	function() { return $('#selectFifoCheck option:selected').val(); },
			},
			success: function (res) {
				let result = res.result;
				if (res.result == 'ok') {
					toastr.success("선입선출이 처리되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			 },
			complete:function(){
				$('#fifoCheckTable').DataTable().ajax.reload();
				$('#my-spinner').hide();
			 }
		});
		
	});
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ자재 투입 선입선출 여부ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//

	//function getTodayType1() {
	//	var date = new Date();
	//	return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	//}
	
	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}

	//공정불량 주간 동적생성
	function faultyTableDay() {
		var html='<tr><input type="hidden" id="dayPrcssFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var body = null;
		var idx = 0;
		var namugi = 0;
		$.each(processFaulty, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day prcssDay touch3" value="0" id="prcssDay-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day prcssDay touch3" value="0" id="prcssDay-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="100" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="prcssDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="prcssDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="prcssDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="dayTbodyTrDay-'+item.baseCd+'">' + header1 + '</tr>';	//주간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		//$.each(processFaulty, function (index, item){
		//	header	+= '<th class="touch4">'+item.baseCdNm+'</th>';
		//	body	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch5" id="dayPrcs'+index+'" value="0" ></td>';
		//	if ((index+1) % 6 == 0){
		//		html += '<tr>' + header + '</tr>';
		//		html += '<tr>' + body + '</tr>';
		//		header = null;
		//		body = null;
		//	}
		//	
		//	idx++;
		//});
		//
		//namugi = 6 - (idx%6);
		//if(namugi != 6){
		//	for(var i=0 ; i<namugi; i++){
		//		header += '<th class="touch4"></th>';
		//		body += '<td></td>';
		//	}
		//}
		//html += '<tr>' + header + '</tr>';
		//html += '<tr>' + body + '</tr>';
		return html;
	}


	//공정불량 야간 동적생성
	function faultyTableNight() {
		var html='<tr><input type="hidden" id="nightPrcssFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var body = null;
		var idx = 0;
		var namugi = 0;
		$.each(processFaulty, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 prcssNight" value="0" id="prcssNight-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 prcssNight" value="0" id="prcssNight-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control nightText night touch3" id="prcssNight-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control nightText night touch3" id="nightTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="prcssNight-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="prcssNight-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="dayTbodyTrNight-'+item.baseCd+'">' + header1 + '</tr>';	//야간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		//$.each(processFaulty, function (index, item){
		//	header	+= '<th class="touch4">'+item.baseCdNm+'</th>';
		//	body	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch5" id="nightPrcs'+index+'" value="0" ></td>';
		//	if ((index+1) % 6 == 0){
		//		html += '<tr>' + header + '</tr>';
		//		html += '<tr>' + body + '</tr>';
		//		header = null;
		//		body = null;
		//	}
		//	
		//	idx++;
		//});
		//
		//namugi = 6 - (idx%6);
		//if(namugi != 6){
		//	for(var i=0 ; i<namugi; i++){
		//		header += '<th class="touch4"></th>';
		//		body += '<td></td>';
		//	}
		//}
		//html += '<tr>' + header + '</tr>';
		//html += '<tr>' + body + '</tr>';
		//
		return html;
	}

	//원자재불량 주간 동적생성
	function matrlFaultyTableDay() {
		var html='<tr><input type="hidden" id="dayMatrlFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var body = null;
		var idx = 0;
		var namugi = 0;
		$.each(matrlFaulty, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 matrlDay" value="0" id="matrlDay-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 matrlDay" value="0" id="matrlDay-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="100" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="matrlDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="matrlDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="matrlDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="dMatrlTbodyTrDay-'+item.baseCd+'">' + header1 + '</tr>';	//주간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		//$.each(matrlFaulty, function (index, item){
		//	header	+= '<th class="touch4">'+item.baseCdNm+'</th>';
		//	body	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch5" id="dayMatrl'+index+'" value="0" ></td>';
		//	if ((index+1) % 6 == 0){
		//		html += '<tr>' + header + '</tr>';
		//		html += '<tr>' + body + '</tr>';
		//		header = null;
		//		body = null;
		//	}
		//	
		//	idx++;
		//});
		//
		//namugi = 6 - (idx%6);
		//if(namugi != 6){
		//	for(var i=0 ; i<namugi; i++){
		//		header += '<th class="touch4"></th>';
		//		body += '<td></td>';
		//	}
		//}
		//html += '<tr>' + header + '</tr>';
		//html += '<tr>' + body + '</tr>';
		return html;
	}

	//원자재불량 야간 동적생성
	function matrlFaultyTableNight() {
		var html='<tr><input type="hidden" id="nightMatrlFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var idx = 0;
		var namugi = 0;

		$.each(matrlFaulty, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 matrlNight" value="0" id="matrlNight-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 matrlNight" value="0" id="matrlNight-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control nightText night touch3" id="matrlNight-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control nightText night touch3" id="nightTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="matrlNight-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="matrlNight-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="dMatrlTbodyTrNight-'+item.baseCd+'">' + header1 + '</tr>';	//야간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		//$.each(matrlFaulty, function (index, item){
		//	header	+= '<th class="touch4">'+item.baseCdNm+'</th>';
		//	body	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch5" id="nightMatrl'+index+'" value="0" ></td>';
		//	if ((index+1) % 6 == 0){
		//		html += '<tr>' + header + '</tr>';
		//		html += '<tr>' + body + '</tr>';
		//		header = null;
		//		body = null;
		//	}
		//	
		//	idx++;
		//});
		//
		//namugi = 6 - (idx%6);
		//if(namugi != 6){
		//	for(var i=0 ; i<namugi; i++){
		//		header += '<th class="touch4"></th>';
		//		body += '<td></td>';
		//	}
		//}
		//html += '<tr>' + header + '</tr>';
		//html += '<tr>' + body + '</tr>';
		return html;
	}

	//교체불량 주간 동적생성
	function replaceFaultyCodeTableDay() {
		var html='<tr><input type="hidden" id="dayReplaceFaultySearchData"><tr>';
		var header = null;
		var body1 = null;
		var body2 = null;
		var idx = 0;
		var namugi = 0;
		$.each(replaceFaultyCode, function (index, item) {
			if((item.baseCd != "004" && item.baseCd != "008") && (item.baseCd != "003" && item.baseCd != "007")){
				header	+= '<th class="touch4" style="min-width:80px;">'+item.baseCdNm+'</th>';
				header  += '<th class="touch4">1회</th>';
				header  += '<th class="touch4">2회</th>';
				header  += '<th class="touch4">3회</th>';
				header  += '<th class="touch4">4회</th>';
				header  += '<th class="touch4">5회</th>';
				body1	+= '<th rowspan="2">KG</th>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 replaceDay" id="replaceDay-' + ((index + 1) * 10 - 9) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 replaceDay" id="replaceDay-' + ((index + 1) * 10 - 8) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 replaceDay" id="replaceDay-' + ((index + 1) * 10 - 7) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 replaceDay" id="replaceDay-' + ((index + 1) * 10 - 6) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 replaceDay" id="replaceDay-' + ((index + 1) * 10 - 5) + '"></td>';
				
				body2 += '<td><input type="datetime-local" id="replaceDay-' + ((index + 1 ) * 10 - 4) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceDay-' + ((index + 1 ) * 10 - 3) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceDay-' + ((index + 1 ) * 10 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceDay-' + ((index + 1 ) * 10 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceDay-' + ((index + 1 ) * 10) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime replaceDay" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				
				html += '<tr>' + header + '</tr>';
	// 			html += '<tr>' + body1 + '</tr>';
				html += '<tr id="day3TbodyTrDay-'+item.baseCd+'">' + body1 + '</tr>';	//주간 아이디 값
				html += '<tr>' + body2 + '</tr>';
				
				header = null;
				body1 = null;
				body2 = null;
			}
			idx++;
		});
		
		return html;
	}

	//교체불량 야간 동적생성
	function replaceFaultyCodeTableNight() {
		var html='<tr><input type="hidden" id="nightReplaceFaultySearchData"><tr>';
		var header = null;
		var body1 = null;
		var body2 = null;
		var idx = 0;
		var namugi = 0;
		$.each(replaceFaultyCode, function (index, item) {
			if((item.baseCd != "004" && item.baseCd != "008") && (item.baseCd != "003" && item.baseCd != "007")){
				header	+= '<th class="touch4" style="min-width:80px;">'+item.baseCdNm+'</th>';
				header  += '<th class="touch4">1회</th>';
				header  += '<th class="touch4">2회</th>';
				header  += '<th class="touch4">3회</th>';
				header  += '<th class="touch4">4회</th>';
				header  += '<th class="touch4">5회</th>';
				body1	+= '<th rowspan="2">KG</th>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 replaceNight" id="replaceNight-' + ((index + 1) * 10 - 9) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 replaceNight" id="replaceNight-' + ((index + 1) * 10 - 8) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 replaceNight" id="replaceNight-' + ((index + 1) * 10 - 7) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 replaceNight" id="replaceNight-' + ((index + 1) * 10 - 6) + '"></td>';
				body1	+= '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 replaceNight" id="replaceNight-' + ((index + 1) * 10 - 5) + '"></td>';
				
				body2 += '<td><input type="datetime-local" id="replaceNight-' + ((index + 1 ) * 10 - 4) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceNight-' + ((index + 1 ) * 10 - 3) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceNight-' + ((index + 1 ) * 10 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceNight-' + ((index + 1 ) * 10 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				body2 += '<td><input type="datetime-local" id="replaceNight-' + ((index + 1 ) * 10) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime replaceDay" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
				
				html += '<tr>' + header + '</tr>';
	// 			html += '<tr>' + body1 + '</tr>';
				html += '<tr  id="day3TbodyTrNight-'+item.baseCd+'">' + body1 + '</tr>';		//야간 아이디 값
				html += '<tr>' + body2 + '</tr>';
				
				header = null;
				body1 = null;
				body2 = null;
			}
			idx++;
		});

		
		return html;
	}

	//설비트러블 불량 주간 동적생성
	function troubleFaultyCodeTableDay() {
		var html='<tr><input type="hidden" id="dayTroubleFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var body = null;
		var idx = 0;
		var namugi = 0;
		$.each(troubleFaultyCode, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 troubleDay" value="0" id="troubleDay-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 day touch3 troubleDay" value="0" id="troubleDay-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="100" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="troubleDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="troubleDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="troubleDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="day4TbodyTrDay-'+item.baseCd+'">' + header1 + '</tr>';	//주간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		
		return html;
	}

	//설비트러블 불량 야간 동적생성
	function troubleFaultyCodeTableNight() {
		var html='<tr><input type="hidden" id="nightTroubleFaultySearchData"><tr>';
		var header1 = null;
		var header2 = null;
		var body = null;
		var idx = 0;
		var namugi = 0;
		$.each(troubleFaultyCode, function (index, item) {
			header1 += '<th rowspan="2" class="touch4">'+item.baseCdNm+'</th>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 troubleNight" value="0" id="troubleNight-' + ((index + 1) * 5 - 4) + '"></td>';
			header1 += '<td><input maxlength="6" type="number" step="0.001" max="10" min="0" class="form-control number-float3 night touch3 troubleNight" value="0" id="troubleNight-' + ((index + 1) * 5 - 3) + '"></td>';
			header1 += '<th rowspan="2">내용</th>';
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control nightText night touch3" id="troubleNight-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control nightText night touch3" id="nightTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="troubleNight-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="troubleNight-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control nightTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
// 			html += '<tr>' + header1 + '</tr>';
			html += '<tr id="day4TbodyTrNight-'+item.baseCd+'">' + header1 + '</tr>';	//야간 아이디 값
			html += '<tr>' + header2 + '</tr>';			
			header1 = null;
			header2 = null;
			body = null;
			
			idx++;
		});
		
		return html;
	}

	$('#faultyRegDate').on('changer', function() {
		readPrcssFaulty();
	});


	//모니터링 On/Off 버튼
	$('#btnMonitoringOnOff').on('click', function() {
		//OFF
		if (monitoringOnOff == 'off') {
			monitoringOnOff = 'on';
			$('#btnMonitoringOnOff').text("모니터링 ON");
			$('#btnMonitoringOnOff').removeClass("btn-light");
			$('#btnMonitoringOnOff').addClass("btn-primary");
			$('#btnMonitoringOnOff').css("color","white");

		//ON
		} else if (monitoringOnOff == 'on') {
			monitoringOnOff = 'off';
			$('#btnMonitoringOnOff').text("모니터링 OFF");
			$('#btnMonitoringOnOff').removeClass("btn-info");
			$('#btnMonitoringOnOff').addClass("btn-light");
			$('#btnMonitoringOnOff').css("color","black");
		}
	});
	
	
	var openWin;
	//모니터링 현황기능
	setInterval( function()
	{
		//모니터링 On
		if (monitoringOnOff == 'on') {
			$('#monitoringLoder').removeClass("d-none");
			$('#agtEquipListTitle').text(agtEquipList.length + "개 설비 모니터링 중입니다.");
			//if (agtEquipList.length == 0) {
			//	$('#agtEquipListWarningModal').modal('show');
			//}
			//console.log("모니터링 할 설비 List" + agtEquipList);
			
        	$.ajax({
                url: '<c:url value="/po/monitoring"/>',
                type: 'POST',
                async: false,
                data: JSON.stringify(agtEquipList),
                dataType:"json",
                contentType : "application/json; charset=UTF-8",
                beforeSend: function() {
                  //  $('#btnAddConfirm').addClass('d-none');
                },
                success: function (res) {
                    let data = res.data;
                    if (res.result == 'ok') {
                    	//모니터링 작지정보(typCd==001)      
						for (let i=0; i<data.length; i++) {
                        	if (data[i].typeCd == '001') {
                        		for (let j=0; j<agtEquipList.length; j++) {
                        			if (data[i].equipNm == agtEquipList[j].equipNm) {
                        				agtEquipList[j].goodsNm = data[i].goodsNm;
                        				agtEquipList[j].mainWorkChargrNm = data[i].mainWorkChargrNm;
                        				agtEquipList[j].workOrdNo = data[i].workOrdNo;
                        				agtEquipList[j].ordLotNo = data[i].ordLotNo;
                        				agtEquipList[j].ordGubun = data[i].ordGubun;
                        				agtEquipList[j].statusNm = data[i].statusNm;
                            		}
                            	}
                            }
                        }
                        //현재 진행중인 모니터링 현황 Update
                        $('#localAgtEquipCdListTable > tbody').empty();	//초기화
						for (let i=0; i<agtEquipList.length; i++) {
							let html = "<tr id=agt" + agtEquipList[i].equipNm + " style='height:55px;'>";
								html += "<td class='text-center'>" + agtEquipList[i].equipNm + "</td>";
								html += "<td class='text-center'>" + agtEquipList[i].goodsNm + "</td>";
								if (agtEquipList[i].ordGubun == 'D') {
									//html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>";
									html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
								} else if (agtEquipList[i].ordGubun == 'N') {
									/* html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>"; */
									html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
								} else {
									/* html += "<td class='text-center'>" + agtEquipList[i].ordLotNo + "</td>"; */
									html += "<td class='text-center'>" + agtEquipList[i].workOrdNo + "</td>";
								}
								html += "<td class='text-center'>" + agtEquipList[i].statusNm + "</td>";
								//html += "<td class='text-center'>" + agtEquipList[i].mainWorkChargrNm + "</td>";
								html += "</tr>" 
							$('#localAgtEquipCdListTable').append(html);
						}
							
							//모니터링 이상알람(typCd==002)
							let dataType002 = false;
							let dateTemp = getRealDate();
							if ($('#pMonitoringAlarm').val() == "" || $('#pMonitoringAlarm').val() == null) {
								$('#pMonitoringAlarm').val($('#pMonitoringAlarm').val() + '--------------------------------------------- ' + dateTemp + '---------------------------------------------');
							} else {
								$('#pMonitoringAlarm').val($('#pMonitoringAlarm').val() + '\n' + '--------------------------------------------- ' + dateTemp + '---------------------------------------------');
							}
							for (let i=0; i<data.length; i++) {
								if (data[i].typeCd == '002') {
									$('#pMonitoringAlarm').val(($('#pMonitoringAlarm').val() + '\n' + dateTemp + ' :  ' + data[i].message));
									dataType002 = true;
							    }
								//console.log(data[i]);
							}
							if (dataType002) {
								toastr.warning("POP 모니터링 - 이상발생!", '', {timeOut: 60000});
								// 팝업창 열려 있는지 확인
								if(openWin==null || openWin.closed) {
									//console.log("팝업창 X 팝업 생성");
									//처음 팝업 생성 시 팝업스크립트단에서 알림정보를 가져옴
									openWin = window.open('<c:url value="/po/posc0010_alarm"/>', 'POP 모니털링 알림', 'width=800px, height=1000px, scrollbars=yes');
								} else {
									//console.log("팝업창  O 팝업생성 X");
									openWin.document.getElementById("cMonitoringAlarm").value = document.getElementById("pMonitoringAlarm").value;
									openWin.document.getElementById("cMonitoringAlarm").scrollTop = openWin.document.getElementById("cMonitoringAlarm").scrollHeight;
									openWin.focus();
								}
							}
							
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					
					} else {
						let dateTemp = getRealDate();
						if ($('#pMonitoringAlarm').val() == "" || $('#pMonitoringAlarm').val() == null) {
							$('#pMonitoringAlarm').val($('#pMonitoringAlarm').val() + '--------------------------------------------- ' + dateTemp + '---------------------------------------------');
						} else {
							$('#pMonitoringAlarm').val($('#pMonitoringAlarm').val() + '\n' + '--------------------------------------------- ' + dateTemp + '---------------------------------------------');
						}
						$('#pMonitoringAlarm').val($('#pMonitoringAlarm').val() + '\n' + dateTemp + ' : 모니터링 오류가 발생했습니다.');                        
						toastr.error(res.message, '', {timeOut: 5000});
						if(openWin==null || openWin.closed) {
							//console.log("팝업창 X 팝업 생성");
							//처음 팝업 생성 시 팝업스크립트단에서 알림정보를 가져옴
							openWin = window.open('<c:url value="/po/posc0010_alarm"/>', 'POP 모니털링 알림', 'width=800px, height=1000px, scrollbars=yes');
						} else {
							//console.log("팝업창  O 팝업생성 X");
							openWin.document.getElementById("cMonitoringAlarm").value = document.getElementById("pMonitoringAlarm").value;
							openWin.document.getElementById("cMonitoringAlarm").scrollTop = openWin.document.getElementById("cMonitoringAlarm").scrollHeight;
							openWin.focus();
						}
					}
                },
                complete:function(){
                    
                }
            });
		
		//모니터링 Off
		} else if (monitoringOnOff == 'off') {
			$('#monitoringLoder').addClass("d-none");
			$('#agtEquipListTitle').text("모니터링 Off 상태입니다.");
		}
	}, 60000);

	//모니터링 기록보기
	$('#btnMonitoringHistory').on('click', function() {
		if(!openWin || openWin.closed) {
			//console.log("팝업창 X 팝업 생성");
			//처음 팝업 생성 시 팝업스크립트단에서 알림정보를 가져옴
			openWin = window.open('<c:url value="/po/posc0010_alarm"/>', 'POP 모니털링 알림', 'width=780px, height=1000px, scrollbars=yes');
		} else {
			//console.log("팝업창  O 팝업생성 X");
			openWin.document.getElementById("cMonitoringAlarm").value = document.getElementById("pMonitoringAlarm").value;
			openWin.document.getElementById("cMonitoringAlarm").scrollTop = openWin.document.getElementById("cMonitoringAlarm").scrollHeight;
			openWin.focus();
		}
	});

	//자재 불량등록
	$('#btnMatrlFaulty').on('click', function() {
		if(workOrdNo == null) {
		  	toastr.warning("불량 등록할 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("불량 등록할 입력할 자재를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("불량 등록할 자재를 선택해주세요!");
			return false;
		}
				
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}

		var barcodeNoMatrlScan = '';
		var faultyStatusScan = '';
		$('#workOrderMatrlTable tbody tr').each(function(){
		 	if($(this).hasClass('selected')){
		 		barcodeNoMatrlScan = $(this).find('td').eq(6).html();
		 		faultyStatusScan = $(this).find('td').eq(10).html();
			}	 	
		});

		if(barcodeNoMatrlScan == '' || barcodeNoMatrlScan == null){
			toastr.warning("불량 등록할 자재를 선택해주세요!");
			return false;
		}

		if (faultyStatusScan != '정상') {
			toastr.warning("정상상태인 자재가 아닙니다.");
			return false;
		}
		
		$('#faultyBarcodeNo').val('');
		$('#frrrdDate').val(sToday);
		$('#frrrdDesc').val('');
		for (let i=0; i<matrlFaultyType.length; i++) {
			$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
		}
		$('#matrlFaultytable').DataTable().clear().draw();
		$('#faultyPopUpModal').modal({backdrop: 'static'});
		$('#faultyPopUpModal').modal('show');

	

		matrlFaultyScanFnc(barcodeNoMatrlScan);
		
	});

	//자재 불량취소
	$('#btnMatrlFaultyCancel').on('click', function() {
		if(workOrdNo == null) {
		  	toastr.warning("불량 등록할 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("불량 등록할 입력할 자재를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("불량 등록할 자재를 선택해주세요!");
			return false;
		}
				
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}

		var barcodeNoMatrlScan = '';
		var faultyStatusScan = '';
		$('#workOrderMatrlTable tbody tr').each(function(){
		 	if($(this).hasClass('selected')){
		 		barcodeNoMatrlScan = $(this).find('td').eq(6).html();
		 		faultyStatusScan = $(this).find('td').eq(10).html();
			}	 	
		});

		if(barcodeNoMatrlScan == '' || barcodeNoMatrlScan == null){
			toastr.warning("불량 등록할 자재를 선택해주세요!");
			return false;
		}

		if (faultyStatusScan != '불량') {
			toastr.warning("불량상태인 자재가 아닙니다.");
			return false;
		}

		//불량취소 모달
		$('#matrlFaultyCancelModal').modal('show');
		
	});

	$('#btnFaultyCancelSave').on('click', function() {
		
		/* 	if($('#matrlFaultytable').DataTable().data().count() == 0){
				$('#faultyBarcodeNo').focus();
				toastr.warning('불량처리할 바코드를 스캔해주세요!');
				return false;
			}
			 */
			updateMtrlInOutWhsInspectQty2("001");
			faultyStatusUpdate("001");

			$('#matrlFaultyCancelModal').modal('hide');

		});
	
	//자재불량처리 스캔테이블
	$.fn.dataTable.ext.errMode = 'none';
	let matrlFaultytable = $('#matrlFaultytable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    paging: false,
	    info: false,
	    ordering: false,
	    processing: true,
	    autoWidth: false,
	    scrollX : false,
	    lengthChange: false,
	    searching: false,
	    pageLength: 20,            
	    ajax: {
	        url: '<c:url value="/tm/preGoodsOutputEmptyList"/>',
	        type: 'GET',
	        async: false,
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	         },
	//         success : function(res) {
	//             console.log(res);
	//             rightSide = false;
	//         }
	    },
	    rowId: '',
	    columns: [
	    	//{
	    	//	render: function(data, type, row, meta) {
	    	//		var rowNo = meta.row + 1;
			//		return meta.row + 1;
			//	}
	    	//},
	        {
	            data: 'faultyQutyNm', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyQutyNm;
	    			}
	    		}
	        },
	        {
	            data: 'faultyMatrlNm', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyMatrlNm;
	    			}
	    		}
	        },
	        {
	            data: 'faultySurfaceTrtmtNm', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultySurfaceTrtmtNm;
	    			}
	    		}
	        },
	        { 
	            data: 'faultyLotNo', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyLotNo;
	    			}
	    		}
	        },
	        {
	            data: 'faultyBarcodeNo', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyBarcodeNo;
	    			}
	    		}
	        },
			{ 
				data: 'faultyInspectQty', 
				render: function(data, type, row, meta) {
					if(data != null) {
						return data;
	    			} else {
						return '<input type="text" class="form-control text-right number-float2" max="' + faultyInspectQty + '" min= "0"style="min-width:40px max-width:50px" name="faultyInspectQty" value="' + faultyInspectQty + '">';
					}
				}
			},
	        {
	            data: 'faultyStatusNm', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyStatusNm;
	    			}
	    		}
	        },
	        {
	            data: 'approvalNm', 
	    		render: function(data, type, row, meta) {	
	    			if(data != null) {
	    				return data;
	    			} else {
	    				return faultyApprovalNm;
	    			}
	    		}
	        },
	    ],
        columnDefs: [
        	{ targets: [0,1,2,3,4,6,7], className: 'text-center' },
        	{ targets: [5], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [5], className: 'text-right' },
        ],
	    order: [
	        [ 0, 'desc' ]
	    ],
	    buttons: [
	    ],
		drawCallback: function () {
			 //$('.mo_card tbody').css('font-size','10px');
		},
	});

    $('#matrlFaultytable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');
		} else {
			$('#matrlFaultytable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
		}
    });

	$('#btnFaultyMatrlDelete').on('click', function() {
    	if ( !$('#matrlFaultytable tr').hasClass('selected') ) {
			toastr.warning("삭제할 라인을 선택해주세요.");
            return false;
        }
		$('#matrlFaultytable').DataTable().rows('.selected').remove().draw();
		if ($('#matrlFaultytable').DataTable().rows().count()==0) {
			$('#btnFrrrdSave').attr('disabled',true);
		}
	});

	var faultyQutyNm = '';
	var faultyMatrlNm = '';
	var faultySurfaceTrtmtNm = '';
	var faultyBarcodeNo = '';
	var faultyLotNo = '';
	var faultyInspectQty = '';
	var faultyStatusNm = '';
	var faultyApprovalNm = '';
	
	//불량처리할 바코드 스캔시
	$("#faultyBarcodeNo").keypress(function (e) {
	    if (e.which == 13) {
	    	if ($('#faultyBarcodeNo').val() == "") {
	            toastr.warning('바코드를 스캔해주세요!');
	            $('#faultyBarcodeNo').focus();
	            return false;
	        }
	        
	        var cval = compareFaultyBarcodeNo($('#faultyBarcodeNo').val());
	        if(cval == false) {
	        	toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.', '', {timeOut: 5000});
	        	$('#faultybarcodeNo').select();
	            return false;
	        }
	        matrlFaultyScanFnc($('#faultyBarcodeNo').val());	        
			
	    }
	});

	function matrlFaultyScanFnc(barcodeNo){
		$.ajax({
 			url: '<c:url value="/io/matrlFaultyScan"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'	 	:	menuAuth,
				'barcodeNo'		:	function(){return barcodeNo;}
			},
			beforeSend: function() {
				//  $('#btnAddConfirmLoading').removeClass('d-none');
			},
			success: function (res) {
			let data = res.data;
				if (res.result == 'ok') {
					faultyQutyNm = data.qutyNm;
					faultyMatrlNm = data.matrlNm;
					faultySurfaceTrtmtNm = data.surfaceTrtmtNm;
					faultyBarcodeNo = data.barcodeNo;
					faultyLotNo = data.lotNo;
					faultyInspectQty = data.inspectQty;
					faultyStatusNm = data.statusNm;
					faultyApprovalNm = data.approvalNm;
					$('#matrlFaultytable').DataTable().row.add({}).draw(false);
					$('#faultyBarcodeNo').val("");
					$('#faultyBarcodeNo').focus();
					$('#btnFrrrdSave').attr('disabled', false);
					toastr.success('추가되었습니다.');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#faultyBarcodeNo').select();
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
					$('#faultyBarcodeNo').select();
				}
			},
			complete:function(){
				//$('#btnAddConfirm').removeClass('d-none');
				//$('#btnAddConfirmLoading').addClass('d-none');
			}
		});
	}

	
	//자재불량 스캔 중복 예외처리
	function compareFaultyBarcodeNo(barcodeNo) {
	    var result = true;
	    $('#matrlFaultytable tbody tr').each(function(){
			var tbarcodeNo= $(this).find('td').eq(4).html();
			if(barcodeNo == tbarcodeNo) {  
				result = false;
				return result;
			}
		});
	    return result;
	}

	var frrrdDate = '';
	var frrrdType = '';
	var frrrdDesc = '';
	//자재불량 등록(저장) 처리
    $('#btnFrrrdSave').on('click', function() {
    	frrrdDate = '';
    	frrrdType = '';
    	frrrdDesc = '';
		if ( !$.trim($('#frrrdDate').val()) ) {
		    toastr.warning('불량일을 선택해주세요.');
		    return false;
		}
		if($('#matrlFaultytable').DataTable().data().count() == 0){
			$('#faultyBarcodeNo').focus();
			toastr.warning('불량처리할 바코드를 스캔해주세요!');
			return false;
		}
		frrrdDate = $('#frrrdDate').val().replace(/-/g, '');
		frrrdDesc = $('#frrrdDesc').val();
		for (let i=0; i<matrlFaultyType.length; i++) {
			if($('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked")) {
				frrrdType += '1';
			} else {
				frrrdType += '0';
			}
		}
		updateMtrlInOutWhsInspectQty("003");
		faultyStatusUpdate("002");
    });


 function faultyStatusUpdate(faultySender){
        
    	$.ajax({
            url: '<c:url value="po/WorkOrdDtlFaultyStatusChange"/>',
            type: 'POST',
            
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'workOrdNo'			:		function() { return workOrdNo; },		//선택한 작업지시
            	'lotNo'				: 		function() { return mainMatrlLotNo; },	//선택한 작업지시
            	'faultyStatus'		: 		function() { return faultySender; },
            },
            beforeSend: function() {
            	$('#my-spinner').show();
    		},
			success: function (res) {
				if (res.result == 'ok') {					
				} 
				$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});
    }
    

	function updateMtrlInOutWhsInspectQty(approvalCd)
    {
		//$('#my-spinner').show();
		var faultyBarcodeList = new Array();
		$('#matrlFaultytable tbody tr').each(function(){
		 	var barcodeNo= $(this).find('td').eq(4).html();
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.barcode = barcodeNo;
			rowData.approvalCd = approvalCd;
			rowData.frrrdDate = frrrdDate;
			rowData.frrrdType = frrrdType;
			rowData.frrrdDesc = frrrdDesc;
			rowData.faultyStatus = '002';
			rowData.faultyInspectQty = $(this).find('input[name=faultyInspectQty]').val();
			faultyBarcodeList.push(rowData);
		});
		//console.log(faultyBarcodeList);
		
		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010"){	
			url = '<c:url value="/qm/workOrdMatrlFaultyOut"/>';
		} else{ //단순 인쇄시 006
			//url = '<c:url value="/qm/matrlPrint"/>';
			//temp = approvalCd;
		}
		
        $.ajax({
			url: url,
			type: 'POST',
			async: false,
			dataType: 'json',
			data : JSON.stringify(faultyBarcodeList),
			contentType : "application/json; charset=UTF-8",
			//beforeSend: function() {
			//  $('#btnAddConfirm').addClass('d-none');
			//},
			success: function (res) {
				//let data = res.data;
				if (res.result == 'ok') {
					toastr.success("불량 처리되었습니다.");
					$('#faultyMatrlList').DataTable().ajax.reload( function () {});
					$("#checkAll").prop("checked", false);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
        });
    }

	function updateMtrlInOutWhsInspectQty2(approvalCd)
    {
		//$('#my-spinner').show();
		var faultyBarcodeList = new Array();
		if(approvalCd == "001"){
			var barcodeNo= $(this).find('td').eq(4).html();
		 	var rowData = new Object();
			var barcodeNoMatrlScan = '';		 
		 	
		 	rowData.menuAuth = menuAuth;		 
		 	$('#workOrderMatrlTable tbody tr').each(function(){
			 	if($(this).hasClass('selected')){
			 		barcodeNoMatrlScan = $(this).find('td').eq(6).html();			 		
				}	 	
			});		 	
			rowData.barcode = barcodeNoMatrlScan;
			rowData.approvalCd = approvalCd;
			rowData.frrrdDate = '';
			rowData.frrrdType = '';
			rowData.frrrdDesc = '';
			rowData.faultyStatus = '001';			
			faultyBarcodeList.push(rowData);
		
			//인쇄 명령인지 판단
			var url = null;
			var temp = null;
			if(approvalCd != "010"){	
				url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_iosc0080_faultyCancel"/>';
			} else{ //단순 인쇄시 006
				//url = '<c:url value="/qm/matrlPrint"/>';
				//temp = approvalCd;
			}
			
	        $.ajax({
				url: url,
				type: 'POST',
				async: false,
				dataType: 'json',
				data : JSON.stringify(faultyBarcodeList),
				contentType : "application/json; charset=UTF-8",
				//beforeSend: function() {
				//  $('#btnAddConfirm').addClass('d-none');
				//},
				success: function (res) {
					//let data = res.data;
					if (res.result == 'ok') {
						toastr.success("불량 취소 처리되었습니다.");
						//$('#faultyMatrlList').DataTable().ajax.reload( function () {});
						$("#checkAll").prop("checked", false);
					} else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					$('#my-spinner').hide();
				}
	        });
		}
    }
    
	var faultyBarcodeList;
	function createfaultyBarcodeList() {
		barcodeNoList = new Array();
		var idx = 0;
		$('#matrlFaultytable tbody tr').each(function(){
		 	var barcodeNo= $(this).find('td').eq(4).html();
		 	var rowData = new Object();
		 	rowData.menuAuth = menuAuth;
			rowData.barcodeNo = barcodeNo;
			faultyBarcodeList.push(rowData);
		});
		//console.log(barcodeNoList);
		return idx;
	}

	//각종 버튼 클릭 시 jsp 상 작지상태와 db 상 작지상태가 일치하는지 확인
	function checkWorkOrdStatus(workOrdNo, workStatusCd)
	{
		var checkWorkOrdStatus = true;
		$.ajax({
            url: '<c:url value="po/checkWorkOrdStatus"/>',
            type: 'POST',
            async: false,
            data: {
            	'menuAuth'	 		: 		menuAuth,
            	'workOrdNo'			:		function() { return workOrdNo; },		//선택한 작업지시
            	'workStatusCd'		: 		function() { return workStatusCd; },	//선택한 작업지시
            },
            beforeSend: function() {
            	$('#my-spinner').show();
    		},
			success: function (res) {
				if (res.result == 'ok') {
					checkWorkOrdStatus = false;
				} else if (res.result == 'fail') {
					checkWorkOrdStatus = true;
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					workOrdNo = null;
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					checkWorkOrdStatus = true;
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					workOrdNo = null;
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
			}
		});

		return checkWorkOrdStatus;
	}
	
	//jquery 실시간 시간구하기
	function getRealDate()
	{
		var date = new Date();
		var year = date.getFullYear().toString();
		var month = date.getMonth() + 1;
		month = month < 10 ? '0' + month.toString() : month.toString();
		var day = date.getDate();
		day = day < 10 ? '0' + day.toString() : day.toString();
		var hour = date.getHours();
		hour = hour < 10 ? '0' + hour.toString() : hour.toString();
		var minites = date.getMinutes();
		minites = minites < 10 ? '0' + minites.toString() : minites.toString();
		var seconds = date.getSeconds();
		seconds = seconds < 10 ? '0' + seconds.toString() : seconds.toString();
		//return year + month + day + hour + minites + seconds;
		return month + "월 " + day + "일 " + hour + "시 " + minites + "분 " + seconds + "초 ";
	}

	//Prcss, Matrl, Trouble 불량중량 kg 클릭 시 시간 자동세팅
	//$('.prcssDay, .prcssNight, .matrlDay, .matrlNight, .troubleDay, .troubleNight').on('click', function() {
	$(document).on("click", ".prcssDay, .prcssNight, .matrlDay, .matrlNight, .troubleDay, .troubleNight", function () {
		//비어있을 경우 클릭 시간대를 세팅
		if (//$(this).val() == '0'		||
			//$(this).val() == '0.'		||
			//$(this).val() == '0.0'	||
			//$(this).val() == '0.00'	||
			//$(this).val() == '0.000'	||
			$('#' + $(this).attr('id').split('-')[0] + '-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val() == '') {
			
			$('#' + $(this).attr('id').split('-')[0] + '-' + String(parseInt($(this).attr('id').split('-')[1]) + 2)).val(moment(Date()).format("YYYY-MM-DDTHH:mm"));
			
		//시간이 이미 세팅되어 있는 경우 아무것도 하지 않음
		} else {
			
		}
	});
	
	//Replace 불량중량 kg 클릭 시 시간 자동세팅
	$(document).on("click", ".replaceDay, .replaceNight", function () {
		//비어있을 경우 클릭 시간대를 세팅
		if (//$(this).val() == '0'		||
			//$(this).val() == '0.'		||
			//$(this).val() == '0.0'	||
			//$(this).val() == '0.00'	||
			//$(this).val() == '0.000'	||
			$('#' + $(this).attr('id').split('-')[0] + '-' + String(parseInt($(this).attr('id').split('-')[1]) + 5)).val() == '') {
			
			$('#' + $(this).attr('id').split('-')[0] + '-' + String(parseInt($(this).attr('id').split('-')[1]) + 5)).val(moment(Date()).format("YYYY-MM-DDTHH:mm"));
			
		//시간이 이미 세팅되어 있는 경우 아무것도 하지 않음
		} else {
			
		}
	});
	 
	//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
	function checkWorkOrderMatrlSave(mainMatrlLotNo)
	{
		var matrlSaveCheck = true;
		
		//해당 주자재가 workOrdDtl에 등록되어있는지 확인
		for (i=0; i<workOrderMatrlTable.data().length; i++) {
			//사용자가 바코드 추가 후 저장버튼을 아직 누르지 않은 자재LotNo
			if ((typeof(workOrderMatrlTable.row(i).data().lotNo) == "undefined")) {
				
			//사용자가 바코드 추가후 저장버튼을 누른 자재LotNo(DB에서 읽어온 자재들)
			} else {
				//선택한 제품은 저장버튼을 클릭한 자재LotNo임
				if (workOrderMatrlTable.row(i).data().lotNo == mainMatrlLotNo) {
					matrlSaveCheck = false;
					break;
				}
			}
		}

		return matrlSaveCheck;
	}

	$('#btnPtfe1Faulty').on('click',function(){
		if(workOrdNo == null) {
		  	toastr.warning("테프론교체를 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}

		var curDate = new Date();
		var curTime = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate() + " " + curDate.getHours() + ":" + curDate.getMinutes() + ":" + curDate.getSeconds();		
		if(curDate.getHours() >= 7 && curDate.getHours() < 19){
			$('#ptfe1DayNight').val("D");
		} else{
			$('#ptfe1DayNight').val("N");
		}		
		
		$('#ptfe1Weight').val('0');
		
		$('#ptfe1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#ptfe1PopupModal').modal('show');
		$('#ptfe1List').DataTable().ajax.reload( function () {});
	});

	$('#btnPtfe2Faulty').on('click',function(){
		if(workOrdNo == null) {
		  	toastr.warning("테프론교체를 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("테프론교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}

		var curDate = new Date();
		var curTime = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate() + " " + curDate.getHours() + ":" + curDate.getMinutes() + ":" + curDate.getSeconds();		
		if(curDate.getHours() >= 7 && curDate.getHours() < 19){
			$('#ptfe2DayNight').val("D");
		} else{
			$('#ptfe2DayNight').val("N");
		}		
		
		$('#ptfe2Weight').val('0');
		
		$('#ptfe2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#ptfe2PopupModal').modal('show');
		$('#ptfe2List').DataTable().ajax.reload( function () {});
	});

	$('#btnSil1Faulty').on('click',function(){
		if(workOrdNo == null) {
		  	toastr.warning("실리콘교체를 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}

		var curDate = new Date();
		var curTime = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate() + " " + curDate.getHours() + ":" + curDate.getMinutes() + ":" + curDate.getSeconds();		
		if(curDate.getHours() >= 7 && curDate.getHours() < 19){
			$('#sil1DayNight').val("D");
		} else{
			$('#sil1DayNight').val("N");
		}		
		
		$('#sil1Weight').val('0');
		
		$('#sil1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#sil1PopupModal').modal('show');
		$('#sil1List').DataTable().ajax.reload( function () {});
	});

	$('#btnSil2Faulty').on('click',function(){
		if(workOrdNo == null) {
		  	toastr.warning("실리콘교체를 입력할 작업지시를 선택해주세요!");
		  	return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("실리콘교체를 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}

		var curDate = new Date();
		var curTime = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate() + " " + curDate.getHours() + ":" + curDate.getMinutes() + ":" + curDate.getSeconds();		
		if(curDate.getHours() >= 7 && curDate.getHours() < 19){
			$('#sil2DayNight').val("D");
		} else{
			$('#sil2DayNight').val("N");
		}		
		
		$('#sil2Weight').val('0');
		
		$('#sil2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#sil2PopupModal').modal('show');
		$('#sil2List').DataTable().ajax.reload( function () {});
	});
	

	$('#ptfe1Save').on('click',function(){
		if(sideView2 == "add"){
			if (workOrdNo == "" || workOrdNo == null) {
	    		toastr.warning("입력할 작업지시를 선택해주세요!");
				return false;
	    	}
	    	if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
				toastr.warning("입력할 주자재(MetalLot)를 선택해주세요!");
				return false;
			}		
			if($('#ptfe1Date').val() == '') {
				toastr.warning("교체 시간을 선택해주세요!");
			  	return false;
			}
			if($('#ptfe1DayNight option:selected').val() == '') {
				toastr.warning("주야 구분을 선택해주세요!");
			  	return false;
			}
	
			$('#my-spinner').show();		
			
			let url = '<c:url value="po/createFaultyAll_F3"/>';	
			
			var rowData = new Object();
			rowData.equipCd 		= equipCd;
			rowData.workOrdNo 		= workOrdNo;
			rowData.dayNightCd 		= $('#ptfe1DayNight option:selected').val();
			rowData.gubun 			= '003';
			rowData.faultyRegDate 	= $('#ordDate').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#ptfe1Date').val();
			rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
			rowData.lotNo	 		= mainMatrlLotNo;
			rowData.faultyCount 	= '1';
	// 		rowData.faulty 			= '0.001';
			rowData.systemCode 		= '004';
			
			if($('#ptfe1Weight').val() != ''){
				rowData.faulty = $('#ptfe1Weight').val();
			}else{
				rowData.faulty = '0';
			}
			
			let tempSideView = sideView;			
				
			$.ajax({
				url: url,
				type: 'POST',
				async: false,
				datatype: 'json',
		        data:  {
					'equipCd'			:		function() { return rowData.equipCd;		},
					'workOrdNo'			:		function() { return rowData.workOrdNo;		},
					'dayNightCd'        :       function() { return rowData.dayNightCd;		},
	                'gubun'             :       function() { return rowData.gubun;			},
	                'faultyRegDate'     :       function() { return rowData.faultyRegDate;	},
	                'faultyDatetime'    :       function() { return rowData.faultyDatetime;	},
	                'ordDate'           :       function() { return rowData.ordDate;		},
	                'lotNo'             :       function() { return rowData.lotNo;			},
	                'faultyCount'       :       function() { return rowData.faultyCount;	},
	                'faulty'            :       function() { return rowData.faulty;			},
	                'systemCode'        :       function() { return rowData.systemCode;		}
		        },
				success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {	   	     		
		   	     		toastr.success("1차 진접 테프론 교체 저장되었습니다.");     	            	
					}
	   	            else if (res.result == 'fail'){		   	     		
			   	 			toastr.error("1차 진접 테프론 교체 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
					} else if(res.result == 'error'){
						toastr.error(res.message, '', {timeOut: 5000});
					}
	   	        },
	   	        complete:function(){   	        
	   	        	$('#my-spinner').hide();
				}
			});
		} else if (sideView2 == "edit"){
			faultySubstitute("teflon", 1, "edit");
		}
	});

	$('#ptfe2Save').on('click',function(){
		if(sideView2 == "add"){
			if (workOrdNo == "" || workOrdNo == null) {
	    		toastr.warning("입력할 작업지시를 선택해주세요!");
				return false;
	    	}
	    	if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
				toastr.warning("입력할 주자재(MetalLot)를 선택해주세요!");
				return false;
			}		
			if($('#ptfe2Date').val() == '') {
				toastr.warning("교체 시간을 선택해주세요!");
			  	return false;
			}
			if($('#ptfe2DayNight option:selected').val() == '') {
				toastr.warning("주야 구분을 선택해주세요!");
			  	return false;
			}
	
			$('#my-spinner').show();		
			
			let url = '<c:url value="po/createFaultyAll_F3"/>';	
			
			var rowData = new Object();
			rowData.equipCd 		= equipCd;
			rowData.workOrdNo 		= workOrdNo;
			rowData.dayNightCd 		= $('#ptfe2DayNight option:selected').val();
			rowData.gubun 			= '003';
			rowData.faultyRegDate 	= $('#ordDate').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#ptfe2Date').val();
			rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
			rowData.lotNo 			= mainMatrlLotNo;
			rowData.faultyCount 	= '1';
	// 		rowData.faulty 			= '0.001';
			rowData.systemCode 		= '008';
			
			if($('#ptfe2Weight').val() != ''){
				rowData.faulty = $('#ptfe2Weight').val();
			}else{
				rowData.faulty = '0';
			}
			
			let tempSideView = sideView;			
				
			$.ajax({
				url: url,
				type: 'POST',
				async: false,
				datatype: 'json',
		        data:  {
					'equipCd'			:		function() { return rowData.equipCd;		},
					'workOrdNo'			:		function() { return rowData.workOrdNo;		},
					'dayNightCd'        :       function() { return rowData.dayNightCd;		},
	                'gubun'             :       function() { return rowData.gubun;			},
	                'faultyRegDate'     :       function() { return rowData.faultyRegDate;	},
	                'faultyDatetime'    :       function() { return rowData.faultyDatetime;	},
	                'ordDate'           :       function() { return rowData.ordDate;		},
	                'lotNo'             :       function() { return rowData.lotNo;			},
	                'faultyCount'       :       function() { return rowData.faultyCount;	},
	                'faulty'            :       function() { return rowData.faulty;			},
	                'systemCode'        :       function() { return rowData.systemCode;		}			
		        },
				success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {	   	     		
		   	     		toastr.success("2차 진접 테프론 교체 저장되었습니다.");     	            	
					}
	   	            else if (res.result == 'fail'){		   	     		
			   	 			toastr.error("2차 진접 테프론 교체 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
					} else if(res.result == 'error'){
						toastr.error(res.message, '', {timeOut: 5000});
					}
	   	        },
	   	        complete:function(){   	        
	   	        	$('#my-spinner').hide();
				}
			});
		} else if (sideView2 == "edit"){
			faultySubstitute("teflon", 2, "edit");
		}
	});

	$('#sil1Save').on('click',function(){
		if(sideView2 == "add"){
			if (workOrdNo == "" || workOrdNo == null) {
	    		toastr.warning("입력할 작업지시를 선택해주세요!");
				return false;
	    	}
	    	if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
				toastr.warning("입력할 주자재(MetalLot)를 선택해주세요!");
				return false;
			}		
			if($('#sil1Date').val() == '') {
				toastr.warning("교체 시간을 선택해주세요!");
			  	return false;
			}
			if($('#sil1DayNight option:selected').val() == '') {
				toastr.warning("주야 구분을 선택해주세요!");
			  	return false;
			}
	
			$('#my-spinner').show();		
			
			let url = '<c:url value="po/createFaultyAll_F3"/>';	
			
			var rowData = new Object();
			rowData.equipCd 		= equipCd;
			rowData.workOrdNo 		= workOrdNo;
			rowData.dayNightCd 		= $('#sil1DayNight option:selected').val();
			rowData.gubun 			= '003';
			rowData.faultyRegDate 	= $('#ordDate').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#sil1Date').val();
			rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
			rowData.lotNo 			= mainMatrlLotNo;
			rowData.faultyCount 	= '1';
	// 		rowData.faulty 			= '0.001';
			rowData.systemCode 		= '003';
			
			if($('#sil1Weight').val() != ''){
				rowData.faulty = $('#sil1Weight').val();
			}else{
				rowData.faulty = '0';
			}
			
			let tempSideView = sideView;			
				
			$.ajax({
				url: url,
				type: 'POST',
				async: false,
				datatype: 'json',
		        data:  {
					'equipCd'			:		function() { return rowData.equipCd;		},
					'workOrdNo'			:		function() { return rowData.workOrdNo;		},
					'dayNightCd'        :       function() { return rowData.dayNightCd;		},
	                'gubun'             :       function() { return rowData.gubun;			},
	                'faultyRegDate'     :       function() { return rowData.faultyRegDate;	},
	                'faultyDatetime'    :       function() { return rowData.faultyDatetime;	},
	                'ordDate'           :       function() { return rowData.ordDate;		},
	                'lotNo'             :       function() { return rowData.lotNo;			},
	                'faultyCount'       :       function() { return rowData.faultyCount;	},
	                'faulty'            :       function() { return rowData.faulty;			},
	                'systemCode'        :       function() { return rowData.systemCode;		}			
		        },
				success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {	   	     		
		   	     		toastr.success("1차 진접 실리콘 교체 저장되었습니다.");     	            	
					}
	   	            else if (res.result == 'fail'){		   	     		
			   	 			toastr.error("1차 진접 실리콘 교체 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
					} else if(res.result == 'error'){
						toastr.error(res.message, '', {timeOut: 5000});
					}
	   	        },
	   	        complete:function(){   	        
	   	        	$('#my-spinner').hide();
				}
			});
		} else if (sideView2 == "edit"){
			faultySubstitute("silicon", 1, "edit");
		}
	});
	
	$('#sil2Save').on('click',function(){
		if(sideView2 == "add"){
			if (workOrdNo == "" || workOrdNo == null) {
	    		toastr.warning("입력할 작업지시를 선택해주세요!");
				return false;
	    	}
	    	if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
				toastr.warning("입력할 주자재(MetalLot)를 선택해주세요!");
				return false;
			}		
			if($('#sil2Date').val() == '') {
				toastr.warning("교체 시간을 선택해주세요!");
			  	return false;
			}
			if($('#sil2DayNight option:selected').val() == '') {
				toastr.warning("주야 구분을 선택해주세요!");
			  	return false;
			}
	
			$('#my-spinner').show();		
			
			let url = '<c:url value="po/createFaultyAll_F3"/>';	
			
			var rowData = new Object();
			rowData.equipCd 		= equipCd;
			rowData.workOrdNo 		= workOrdNo;
			rowData.dayNightCd 		= $('#sil2DayNight option:selected').val();
			rowData.gubun 			= '003';
			rowData.faultyRegDate 	= $('#ordDate').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#sil2Date').val();
			rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
			rowData.lotNo 			= mainMatrlLotNo;
			rowData.faultyCount 	= '1';
	// 		rowData.faulty 			= '0.001';
			rowData.systemCode 		= '007';
			
			if($('#sil2Weight').val() != ''){
				rowData.faulty = $('#sil2Weight').val();
			}else{
				rowData.faulty = '0';
			}
			
			let tempSideView = sideView;			
				
			$.ajax({
				url: url,
				type: 'POST',
				async: false,
				datatype: 'json',
		        data:  {
					'equipCd'			:		function() { return rowData.equipCd;		},
					'workOrdNo'			:		function() { return rowData.workOrdNo;		},
					'dayNightCd'        :       function() { return rowData.dayNightCd;		},
	                'gubun'             :       function() { return rowData.gubun;			},
	                'faultyRegDate'     :       function() { return rowData.faultyRegDate;	},
	                'faultyDatetime'    :       function() { return rowData.faultyDatetime;	},
	                'ordDate'           :       function() { return rowData.ordDate;		},
	                'lotNo'             :       function() { return rowData.lotNo;			},
	                'faultyCount'       :       function() { return rowData.faultyCount;	},
	                'faulty'            :       function() { return rowData.faulty;			},
	                'systemCode'        :       function() { return rowData.systemCode;		}			
		        },
				success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {	   	     		
		   	     		toastr.success("2차 진접 실리콘 교체 저장되었습니다.");     	            	
					}
	   	            else if (res.result == 'fail'){		   	     		
			   	 			toastr.error("2차 진접 실리콘 교체 저장 실패하였습니다.", '', {timeOut: 5000});		   	 		
					} else if(res.result == 'error'){
						toastr.error(res.message, '', {timeOut: 5000});
					}
	   	        },
	   	        complete:function(){   	        
	   	        	$('#my-spinner').hide();
				}
			});
		} else if (sideView2 == "edit"){
			faultySubstitute("silicon", 2, "edit");
		}	
	});
	
	//테프론 테이블1
    let ptfe1List = $('#ptfe1List').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/po/ptfe1DataList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		: 	menuAuth,
			    'workOrdNo'		:	function() { return workOrdNo; },
			    'lotNo'			:	function() { return mainMatrlLotNo; },
			    'equipCd'		:	function() { return equipCd; },
			    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'faultyRegDate' :	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'gubun'			:	'003',
			    'systemCode'	:	'004',
			},
	    },
	    rowId: '',
		columns: [
			{ data: 'faultyDatetime',
				render: function(data, type, row, meta) {	    			
					return  moment(data).format("YYYY-MM-DD HH:mm");
				}
			},
			{ data: 'dayNightCdNm'},
			{ data: 'faultySeq'},
		],
	    columnDefs: [
	    	{ targets: [0,1,2], className: 'text-center' },
	    
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
		}
    });

	//테프론 테이블2
    let ptfe2List = $('#ptfe2List').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/po/ptfe1DataList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		: 	menuAuth,
			    'workOrdNo'		:	function() { return workOrdNo; },
			    'lotNo'			:	function() { return mainMatrlLotNo; },
			    'equipCd'		:	function() { return equipCd; },
			    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'faultyRegDate' :	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'gubun'			:	'003',
			    'systemCode'	:	'008',
			},
	    },
	    rowId: '',
		columns: [
			{ data: 'faultyDatetime',
				render: function(data, type, row, meta) {	    			
					return  moment(data).format("YYYY-MM-DD HH:mm");
				}
			},
			{ data: 'dayNightCdNm'},
			{ data: 'faultySeq'},
		],
	    columnDefs: [
	    	{ targets: [0,1,2], className: 'text-center' },
	    
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
		}
    });

	//실리콘 테이블1
    let sil1List = $('#sil1List').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/po/ptfe1DataList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		: 	menuAuth,
			    'workOrdNo'		:	function() { return workOrdNo; },
			    'lotNo'			:	function() { return mainMatrlLotNo; },
			    'equipCd'		:	function() { return equipCd; },
			    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'faultyRegDate' :	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'gubun'			:	'003',
			    'systemCode'	:	'003',
			},
	    },
	    rowId: '',
		columns: [
			{ data: 'faultyDatetime',
				render: function(data, type, row, meta) {	    			
					return  moment(data).format("YYYY-MM-DD HH:mm");
				}
			},
			{ data: 'dayNightCdNm'},
			{ data: 'faultySeq'},
		],
	    columnDefs: [
	    	{ targets: [0,1,2], className: 'text-center' },
	    
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
		}
    });

	//실리콘 테이블2
    let sil2List = $('#sil2List').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/po/ptfe1DataList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'		: 	menuAuth,
			    'workOrdNo'		:	function() { return workOrdNo; },
			    'lotNo'			:	function() { return mainMatrlLotNo; },
			    'equipCd'		:	function() { return equipCd; },
			    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'faultyRegDate' :	function() { return $('#ordDate').val().replace(/-/g,"");},
			    'gubun'			:	'003',
			    'systemCode'	:	'007',
			},
	    },
	    rowId: '',
		columns: [
			{ data: 'faultyDatetime',
				render: function(data, type, row, meta) {	    			
					return  moment(data).format("YYYY-MM-DD HH:mm");
				}
			},
			{ data: 'dayNightCdNm'},
			{ data: 'faultySeq'},
		],
	    columnDefs: [
	    	{ targets: [0,1,2], className: 'text-center' },
	    
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
		}
    });

	var faultySeq = '';
	var faultyRegDate = '';
	var dayNightCd = '';

	$('#ptfe1Add').on('click', function(){
		$('#ptfe1Date').attr('disabled',false);
		$('#ptfe1DayNight').attr('disabled',false);
		$('#ptfe1Weight').attr('disabled',false);

		$('#ptfe1Add').attr('disabled',true);
		$('#ptfe1Edit').attr('disabled',true);
		$('#ptfe1Save').attr('disabled',false);

		$('#ptfe1Weight').val('0');
		$('#ptfe1DayNight').val('D')    		
		$('#ptfe1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#ptfe1List').DataTable().$('tr.selected').removeClass('selected');

		sideView2 = 'add';
	});
    $('#ptfe1Edit').on('click', function () {
    	$('#ptfe1Date').attr('disabled',false);
		$('#ptfe1DayNight').attr('disabled',true);
		$('#ptfe1Weight').attr('disabled',false);

		$('#ptfe1Add').attr('disabled',true);
		$('#ptfe1Edit').attr('disabled',true);
		$('#ptfe1Save').attr('disabled',false);
		
		sideView2 = 'edit';
    });

    $('#ptfe2Add').on('click', function(){
		$('#ptfe2Date').attr('disabled',false);
		$('#ptfe2DayNight').attr('disabled',false);
		$('#ptfe2Weight').attr('disabled',false);

		$('#ptfe2Add').attr('disabled',true);
		$('#ptfe2Edit').attr('disabled',true);
		$('#ptfe2Save').attr('disabled',false);

		$('#ptfe2Weight').val('0');
		$('#ptfe2DayNight').val('D')    		
		$('#ptfe2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#ptfe2List').DataTable().$('tr.selected').removeClass('selected');

		sideView2 = 'add';
	});
    $('#ptfe2Edit').on('click', function () {
    	$('#ptfe2Date').attr('disabled',false);
		$('#ptfe2DayNight').attr('disabled',true);
		$('#ptfe2Weight').attr('disabled',false);

		$('#ptfe2Add').attr('disabled',true);
		$('#ptfe2Edit').attr('disabled',true);
		$('#ptfe2Save').attr('disabled',false);
		
		sideView2 = 'edit';
    });

    $('#sil1Add').on('click', function(){
		$('#sil1Date').attr('disabled',false);
		$('#sil1DayNight').attr('disabled',false);
		$('#sil1Weight').attr('disabled',false);

		$('#sil1Add').attr('disabled',true);
		$('#sil1Edit').attr('disabled',true);
		$('#sil1Save').attr('disabled',false);

		$('#sil1Weight').val('0');
		$('#sil1DayNight').val('D')    		
		$('#sil1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#sil1List').DataTable().$('tr.selected').removeClass('selected');

		sideView2 = 'add';
	});
    $('#sil1Edit').on('click', function () {
    	$('#sil1Date').attr('disabled',false);
		$('#sil1DayNight').attr('disabled',true);
		$('#sil1Weight').attr('disabled',false);

		$('#sil1Add').attr('disabled',true);
		$('#sil1Edit').attr('disabled',true);
		$('#sil1Save').attr('disabled',false);
		
		sideView2 = 'edit';
    });

    $('#sil2Add').on('click', function(){
		$('#sil2Date').attr('disabled',false);
		$('#sil2DayNight').attr('disabled',false);
		$('#sil2Weight').attr('disabled',false);

		$('#sil2Add').attr('disabled',true);
		$('#sil2Edit').attr('disabled',true);
		$('#sil2Save').attr('disabled',false);

		$('#sil2Weight').val('0');
		$('#sil2DayNight').val('D')    		
		$('#sil2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		
		$('#sil2List').DataTable().$('tr.selected').removeClass('selected');

		sideView2 = 'add';
	});
    $('#sil2Edit').on('click', function () {
    	$('#sil2Date').attr('disabled',false);
		$('#sil2DayNight').attr('disabled',true);
		$('#sil2Weight').attr('disabled',false);

		$('#sil2Add').attr('disabled',true);
		$('#sil2Edit').attr('disabled',true);
		$('#sil2Save').attr('disabled',false);
		
		sideView2 = 'edit';
    });
	let oldFaultyRegDate;
    $('#ptfe1List tbody').on('click', 'tr', function () {
    	if ($(this).hasClass('selected')) {
    		//1차 진접
    		$('#ptfe1Add').attr('disabled',false);
    		$('#ptfe1Edit').attr('disabled',true);
            $('#ptfe1Save').attr('disabled',true);
    		$('#ptfe1List').DataTable().$('tr.selected').removeClass('selected');

    		$('#ptfe1Weight').val('0');
    		$('#ptfe1DayNight').val('D')    		
    		$('#ptfe1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		

    		$('#ptfe1Date').attr('disabled',true);
    		$('#ptfe1DayNight').attr('disabled',true);
    		$('#ptfe1Weight').attr('disabled',true);	
        } else {
        	$('#ptfe1Date').attr('disabled',true);
    		$('#ptfe1DayNight').attr('disabled',true);
    		$('#ptfe1Weight').attr('disabled',true);

    		$('#ptfe1Add').attr('disabled',false);
            $('#ptfe1Edit').attr('disabled',false);
            $('#ptfe1Save').attr('disabled',true);
            
			$('#ptfe1List').DataTable().$('tr.selected').removeClass('selected');
			
			$(this).addClass('selected');
	    	faultySeq = ptfe1List.row(this).data().faultySeq;
	    	faultyRegDate = ptfe1List.row(this).data().faultyRegDate;
	    	faultyDatetime = ptfe1List.row(this).data().faultyDatetime;
	    	dayNightCd = ptfe1List.row(this).data().dayNightCd;
	    	oldFaultyRegDate = ptfe1List.row(this).data().faultyRegDate;
	    	
	    	$.ajax({
	    		url: '<c:url value="po/readDtlPrcssFaulty"/>',
		        type: 'GET',
		        data:{
					'equipCd' : equipCd,
					'lotNo'   : mainMatrlLotNo,
					'faultyRegDate' : faultyRegDate,
					'dayNightCd'    : dayNightCd,
					'gubun'         : '003',
					'systemCode'    : '004',
					'faultySeq'     : faultySeq,
					'workOrdNo'     : workOrdNo,
			    },
			    success: function (res) {
			    	let data = res.data;
			    	$('#ptfe1Date').val(data.faultyDatetime);
			    	$('#ptfe1DayNight').val(data.dayNightCd);
			    	$('#ptfe1Weight').val(data.faulty);

				},
		    });
        }
    });

    $('#ptfe2List tbody').on('click', 'tr', function () {
    	if ($(this).hasClass('selected')) {
			//2차 진접
    		$('#ptfe2Add').attr('disabled',false);
    		$('#ptfe2Edit').attr('disabled',true);
            $('#ptfe2Save').attr('disabled',true);
    		$('#ptfe2List').DataTable().$('tr.selected').removeClass('selected');

    		$('#ptfe2Weight').val('0');
    		$('#ptfe2DayNight').val('D')    		
    		$('#ptfe2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		

    		$('#ptfe2Date').attr('disabled',true);
    		$('#ptfe2DayNight').attr('disabled',true);
    		$('#ptfe2Weight').attr('disabled',true);	
    		
        } else {
        	$('#ptfe2Date').attr('disabled',true);
    		$('#ptfe2DayNight').attr('disabled',true);
    		$('#ptfe2Weight').attr('disabled',true);

    		$('#ptfe2Add').attr('disabled',false);
            $('#ptfe2Edit').attr('disabled',false);
            $('#ptfe2Save').attr('disabled',true);
            
        	$('#ptfe2List').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			faultySeq = ptfe2List.row(this).data().faultySeq;
	    	faultyRegDate = ptfe2List.row(this).data().faultyRegDate;
	    	faultyDatetime = ptfe2List.row(this).data().faultyDatetime;
	    	dayNightCd = ptfe2List.row(this).data().dayNightCd;
	    	oldFaultyRegDate = ptfe2List.row(this).data().faultyRegDate;
	    	
	    	$.ajax({
	    		url: '<c:url value="po/readDtlPrcssFaulty"/>',
		        type: 'GET',
		        data:{
					'equipCd' : equipCd,
					'lotNo'   : mainMatrlLotNo,
					'faultyRegDate' : faultyRegDate,
					'dayNightCd'    : dayNightCd,
					'gubun'         : '003',
					'systemCode'    : '008',
					'faultySeq'     : faultySeq,
					'workOrdNo'     : workOrdNo,
			    },
			    success: function (res) {
			    	let data = res.data;
			    	$('#ptfe2Date').val(data.faultyDatetime);
				    $('#ptfe2DayNight').val(data.dayNightCd);
				    $('#ptfe2Weight').val(data.faulty);
				    
				},
		    });
        }
    });

    $('#ptfe1Delete').on('click',function(){
        if($("#ptfe1List").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }
    	$.ajax({
	           url: '<c:url value="po/ptfeDataDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'		: 	menuAuth,
				    'workOrdNo'		:	function() { return workOrdNo; },
				    'lotNo'			:	function() { return mainMatrlLotNo; },
				    'equipCd'		:	function() { return equipCd; },
				    'faultySeq'		:	function() { return faultySeq;},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    //'dayNightCd'	:	function() { return dayNightCd;},
				    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    'gubun'			:	'003',
				    'systemCode'	:	'004',
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#ptfe1List').DataTable().ajax.reload( function () {});
					toastr.success("삭제되었습니다.");
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
				$('#ptfe1Add').attr('disabled',false);
    			$('#ptfe1Edit').attr('disabled',true);
           		$('#ptfe1Save').attr('disabled',true);
				$('#ptfe1Weight').val('0');
	    		$('#ptfe1DayNight').val('D')    		
	    		$('#ptfe1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));
	    		$('#ptfe1List').DataTable().$('tr.selected').removeClass('selected');
			}
		});
    });

    $('#ptfe2Delete').on('click',function(){
        if($("#ptfe2List").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }
    	$.ajax({
	           url: '<c:url value="po/ptfeDataDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'		: 	menuAuth,
				    'workOrdNo'		:	function() { return workOrdNo; },
				    'lotNo'			:	function() { return mainMatrlLotNo; },
				    'equipCd'		:	function() { return equipCd; },
				    'faultySeq'		:	function() { return faultySeq;},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    //'dayNightCd'	:	function() { return dayNightCd;},
				    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    'gubun'			:	'003',
				    'systemCode'	:	'008',
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#ptfe2List').DataTable().ajax.reload( function () {});
					toastr.success("삭제되었습니다.");
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
				$('#ptfe2Add').attr('disabled',false);
    			$('#ptfe2Edit').attr('disabled',true);
           		$('#ptfe2Save').attr('disabled',true);
				$('#ptfe2Weight').val('0');
	    		$('#ptfe2DayNight').val('D')    		
	    		$('#ptfe2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));
	    		$('#ptfe2List').DataTable().$('tr.selected').removeClass('selected');
			}
		});
    });
    
    $('#sil1List tbody').on('click', 'tr', function () {
    	if ($(this).hasClass('selected')) {
    		$('#sil1Add').attr('disabled',false);
    		$('#sil1Edit').attr('disabled',true);
            $('#sil1Save').attr('disabled',true);
    		$('#sil1List').DataTable().$('tr.selected').removeClass('selected');

    		$('#sil1Weight').val('0');
    		$('#sil1DayNight').val('D')    		
    		$('#sil1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		

    		$('#sil1Date').attr('disabled',true);
    		$('#sil1DayNight').attr('disabled',true);
    		$('#sil1Weight').attr('disabled',true);
        } else {
        	$('#sil1Date').attr('disabled',true);
    		$('#sil1DayNight').attr('disabled',true);
    		$('#sil1Weight').attr('disabled',true);

    		$('#sil1Add').attr('disabled',false);
            $('#sil1Edit').attr('disabled',false);
            $('#sil1Save').attr('disabled',true);
            
			$('#sil1List').DataTable().$('tr.selected').removeClass('selected');
			
			$(this).addClass('selected');
	    	faultySeq = sil1List.row(this).data().faultySeq;
	    	faultyRegDate = sil1List.row(this).data().faultyRegDate;
	    	faultyDatetime = sil1List.row(this).data().faultyDatetime;
	    	dayNightCd = sil1List.row(this).data().dayNightCd;
	    	oldFaultyRegDate = sil1List.row(this).data().faultyRegDate;
	    	$.ajax({
	    		url: '<c:url value="po/readDtlPrcssFaulty"/>',
		        type: 'GET',
		        data:{
					'equipCd' : equipCd,
					'lotNo'   : mainMatrlLotNo,
					'faultyRegDate' : faultyRegDate,
					'dayNightCd'    : dayNightCd,
					'gubun'         : '003',
					'systemCode'    : '003',
					'faultySeq'     : faultySeq,
					'workOrdNo'     : workOrdNo,
			    },
			    success: function (res) {
			    	let data = res.data;
			    	$('#sil1Date').val(data.faultyDatetime);
			    	$('#sil1DayNight').val(data.dayNightCd);
			    	$('#sil1Weight').val(data.faulty);

				},
		    });
        }
    });

    $('#sil2List tbody').on('click', 'tr', function () {
    	if ($(this).hasClass('selected')) {
			$('#sil2Add').attr('disabled',false);
    		$('#sil2Edit').attr('disabled',true);
            $('#sil2Save').attr('disabled',true);
    		$('#sil2List').DataTable().$('tr.selected').removeClass('selected');

    		$('#sil2Weight').val('0');
    		$('#sil2DayNight').val('D')    		
    		$('#sil2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));		

    		$('#sil2Date').attr('disabled',true);
    		$('#sil2DayNight').attr('disabled',true);
    		$('#sil2Weight').attr('disabled',true);
		} else {
        	$('#sil2Date').attr('disabled',true);
    		$('#sil2DayNight').attr('disabled',true);
    		$('#sil2Weight').attr('disabled',true);

    		$('#sil2Add').attr('disabled',false);
            $('#sil2Edit').attr('disabled',false);
            $('#sil2Save').attr('disabled',true);
            
			$('#sil2List').DataTable().$('tr.selected').removeClass('selected');
			
			$(this).addClass('selected');
	    	faultySeq = sil2List.row(this).data().faultySeq;
	    	faultyRegDate = sil2List.row(this).data().faultyRegDate;
	    	faultyDatetime = sil2List.row(this).data().faultyDatetime;
	    	dayNightCd = sil2List.row(this).data().dayNightCd;
	    	oldFaultyRegDate = sil2List.row(this).data().faultyRegDate;
	    	$.ajax({
	    		url: '<c:url value="po/readDtlPrcssFaulty"/>',
		        type: 'GET',
		        data:{
					'equipCd' : equipCd,
					'lotNo'   : mainMatrlLotNo,
					'faultyRegDate' : faultyRegDate,
					'dayNightCd'    : dayNightCd,
					'gubun'         : '003',
					'systemCode'    : '007',
					'faultySeq'     : faultySeq,
					'workOrdNo'     : workOrdNo,
			    },
			    success: function (res) {
			    	let data = res.data;
			    	$('#sil2Date').val(data.faultyDatetime);
			    	$('#sil2DayNight').val(data.dayNightCd);
			    	$('#sil2Weight').val(data.faulty);

				},
		    });
        }
    });

    $('#sil1Delete').on('click',function(){
        if($("#sil1List").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }
    	$.ajax({
	           url: '<c:url value="po/ptfeDataDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'		: 	menuAuth,
				    'workOrdNo'		:	function() { return workOrdNo; },
				    'lotNo'			:	function() { return mainMatrlLotNo; },
				    'equipCd'		:	function() { return equipCd; },
				    'faultySeq'		:	function() { return faultySeq;},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    //'dayNightCd'	:	function() { return dayNightCd;},
				    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    'gubun'			:	'003',
				    'systemCode'	:	'003',
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#sil1List').DataTable().ajax.reload( function () {});
					toastr.success("삭제되었습니다.");
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
				$('#sil1Add').attr('disabled',false);
    			$('#sil1Edit').attr('disabled',true);
           		$('#sil1Save').attr('disabled',true);
				$('#sil1Weight').val('0');
	    		$('#sil1DayNight').val('D')    		
	    		$('#sil1Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));
	    		$('#sil1List').DataTable().$('tr.selected').removeClass('selected');
			}
		});
    });

    $('#sil2Delete').on('click',function(){
        if($("#sil2List").find(".selected").length != 1){
        	toastr.warning("리스트에서 삭제할 항목을 선택해주세요!");
			return false;
        }
    	$.ajax({
	           url: '<c:url value="po/ptfeDataDelete"/>',
	           type: 'POST',
	           async: false,
	           data: {
	        	   'menuAuth'		: 	menuAuth,
				    'workOrdNo'		:	function() { return workOrdNo; },
				    'lotNo'			:	function() { return mainMatrlLotNo; },
				    'equipCd'		:	function() { return equipCd; },
				    'faultySeq'		:	function() { return faultySeq;},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    //'dayNightCd'	:	function() { return dayNightCd;},
				    'ordDate'		:	function() { return $('#ordDate').val().replace(/-/g,"");},
				    'faultyRegDate' :	function() { return faultyRegDate;},
				    'gubun'			:	'003',
				    'systemCode'	:	'007',
	           },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {		
					$('#sil2List').DataTable().ajax.reload( function () {});
					toastr.success("삭제되었습니다.");
				} else if(res.result == 'fail'){
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				//$('#searchDay').val("true")
				$('#sil2Add').attr('disabled',false);
    			$('#sil2Edit').attr('disabled',true);
           		$('#sil2Save').attr('disabled',true);
				$('#sil2Weight').val('0');
	    		$('#sil2DayNight').val('D')    		
	    		$('#sil2Date').val(new Date(new Date().toString().split('GMT')[0]+' UTC').toISOString().substring(0,16));
	    		$('#sil2List').DataTable().$('tr.selected').removeClass('selected');
			}
		});
    });
    $('#ptfe1PopupModal').on('hidden.bs.modal',function (e){
		$('#ptfe1Add').attr('disabled',false);
		$('#ptfe1Edit').attr('disabled',true);
		$('#ptfe1Save').attr('disabled',true);

		$('#ptfe1Date').attr('disabled',true);
		$('#ptfe1DayNight').attr('disabled',true);
		$('#ptfe1Weight').attr('disabled',true);

		$('#ptfe1Date').val(0);
		$('#ptfe1Weight').val(0);
	});
    $('#ptfe2PopupModal').on('hidden.bs.modal',function (e){
		$('#ptfe2Add').attr('disabled',false);
		$('#ptfe2Edit').attr('disabled',true);
		$('#ptfe2Save').attr('disabled',true);

		$('#ptfe2Date').attr('disabled',true);
		$('#ptfe2DayNight').attr('disabled',true);
		$('#ptfe2Weight').attr('disabled',true);
		
		$('#ptfe2Date').val(0);
		$('#ptfe2Weight').val(0);
	});

    $('#sil1PopupModal').on('hidden.bs.modal',function (e){
		$('#sil1Add').attr('disabled',false);
		$('#sil1Edit').attr('disabled',true);
		$('#sil1Save').attr('disabled',true);

		$('#sil1Date').attr('disabled',true);
		$('#sil1DayNight').attr('disabled',true);
		$('#sil1Weight').attr('disabled',true);

		$('#sil1Date').val(0);
		$('#sil1Weight').val(0);
	});
    $('#sil2PopupModal').on('hidden.bs.modal',function (e){
		$('#sil2Add').attr('disabled',false);
		$('#sil2Edit').attr('disabled',true);
		$('#sil2Save').attr('disabled',true);

		$('#sil2Date').attr('disabled',true);
		$('#sil2DayNight').attr('disabled',true);
		$('#sil2Weight').attr('disabled',true);

		$('#sil2Date').val(0);
		$('#sil2Weight').val(0);
	});
  //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ테프론,실리콘교체 수정 함수ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    let sideView2 = '';
	let systemCode = '';
	let faulty = '';
	function faultySubstitute(name, seq, gubun){
		var url = '';
		if(gubun == "edit"){
			url = '<c:url value="po/updateFaultyAll"/>';	
		} else if(gubun == "add"){
			url = '<c:url value="/po/"/>' //add하는 url을 입력해줘야함.
		}

		if ( name == "teflon" && seq == 1 ) {
			systemCode = '004';
		} else if ( name == "teflon" && seq == 2 ) {
			systemCode = '008';
		} else if ( name == "silicon" && seq == 1 ) {
			systemCode = '003';
		} else if ( name == "silicon" && seq == 2 ) {
			systemCode = '007';
		}

		var rowData = new Object();
		rowData.equipCd 		= equipCd;
		rowData.workOrdNo	 	= workOrdNo;
		rowData.gubun 			= '003';
		rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
		rowData.lotNo 			= mainMatrlLotNo;
		rowData.faultyCount 	= '1';
		rowData.systemCode      = systemCode;
		rowData.faultySeq       = faultySeq;
		if( $('#ptfe1Weight').val() != '' && $('#ptfe1PopupModal').hasClass('show') ){
			rowData.faulty = $('#ptfe1Weight').val();
		} else if ( $('#ptfe1Weight').val() == '' && $('#ptfe1PopupModal').hasClass('show') ) {
			rowData.faulty = '0';
		} 
		if( $('#ptfe2Weight').val() != '' && $('#ptfe2PopupModal').hasClass('show') ){
			rowData.faulty = $('#ptfe2Weight').val();
		} else if ( $('#ptfe2Weight').val() == '' && $('#ptfe2PopupModal').hasClass('show') ) {
			rowData.faulty = '0';
		} 		
		if( $('#sil1Weight').val() != '' && $('#sil1PopupModal').hasClass('show') ){
			rowData.faulty = $('#sil1Weight').val();
		} else if ( $('#sil1Weight').val() == '' && $('#sil1PopupModal').hasClass('show') ) {
			rowData.faulty = '0';
		} 
		if( $('#sil2Weight').val() != '' && $('#sil2PopupModal').hasClass('show') ){
			rowData.faulty = $('#sil2Weight').val();
		} else if ( $('#sil2Weight').val() == '' && $('#sil2PopupModal').hasClass('show') ) {
			rowData.faulty = '0';
		} 	
		
		if( $('#ptfe1PopupModal').hasClass('show') ) {
			rowData.faultyRegDate 	= $('#ptfe1Date').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#ptfe1Date').val();
			rowData.dayNightCd	 	= $('#ptfe1DayNight option:selected').val();
		} else if ( $('#ptfe2PopupModal').hasClass('show') ) {
			rowData.faultyRegDate 	= $('#ptfe2Date').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#ptfe2Date').val();
			rowData.dayNightCd	 	= $('#ptfe2DayNight option:selected').val();
		} else if ( $('#sil1PopupModal').hasClass('show') ) {
			rowData.faultyRegDate 	= $('#sil1Date').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#sil1Date').val();
			rowData.dayNightCd	 	= $('#sil1DayNight option:selected').val();
		} else if ( $('#sil2PopupModal').hasClass('show') ) {
			rowData.faultyRegDate 	= $('#sil2Date').val().substring(0,10).replace(/-/g,"");
			rowData.faultyDatetime 	= $('#sil2Date').val();
			rowData.dayNightCd	 	= $('#sil2DayNight option:selected').val();
		}
		
		$('#my-spinner').show();
		$.ajax({
			url: url,
			type: 'POST',
			datatype: 'json',
	        data:  {
	        	'equipCd'			:		function(){return rowData.equipCd;},
				'workOrdNo'			:		function(){return rowData.workOrdNo;},
				'dayNightCd'        :       function(){return rowData.dayNightCd;},
                'gubun'             :       function(){return rowData.gubun;},
                'faultyRegDate'     :       function(){return rowData.faultyRegDate ;},
                'faultyDatetime'    :       function(){return rowData.faultyDatetime;},
                'ordDate'           :       function(){return rowData.ordDate;},
                'lotNo'             :       function(){return rowData.lotNo;},
                'faultyCount'       :       function(){return rowData.faultyCount;},
                'faulty'            :       function(){return rowData.faulty;},
                'systemCode'        :       function(){return rowData.systemCode;},			
				'faultySeq'         :       function(){return rowData.faultySeq;},
				'oldFaultyRegDate'  :       function(){return oldFaultyRegDate;},
      		},
			success: function (res) {
   	            let result = res.result;
   	            if (res.result == 'ok') {	  
   	   	            
   	   	            if(name == "teflon" && gubun == "add"){
   	   	           	    toastr.success(seq+"차 진접 테프론 교체 저장되었습니다.");   		
   	   	   	        } else if(name == "teflon" && gubun == "edit"){
   	   	   	   			toastr.success(seq+"차 진접 테프론 교체 수정되었습니다.");
   	   	   	   	    }	     
   	   	   	   	    
   	   	   	        if(name == "silicon" && gubun == "add"){
   	   	   	        	toastr.success(seq+"차 진접 실리콘 교체 저장되었습니다.");
   	   	   	        } else if(name == "silicon" && gubun == "edit"){
   	   	   	   			toastr.success(seq+"차 진접 실리콘 교체 수정되었습니다.");
   	   	   	   	    }	 	
	   	     	  	            	
				}
   	            else if (res.result == 'fail'){		   
   	   	            	     	
   	            	if(name == "teflon" && gubun == "add"){
   	            		toastr.error(seq+"진접 테프론 교체 저장 실패하였습니다.", '', {timeOut: 5000});   		
   	   	   	        } else if(name == "teflon" && gubun == "edit"){
   	   	   	   			toastr.error(seq+"진접 테프론 교체 수정 실패하였습니다.", '', {timeOut: 5000}); 
   	   	   	   	    }	    
   	   	   	   	     
   	   	   	        if(name == "silicon" && gubun == "add"){
   	   	   	  			toastr.error(seq+"진접 실리콘 교체 저장 실패하였습니다.", '', {timeOut: 5000});   		
   	   	   	        } else if(name == "silicon" && gubun == "edit"){
   	   	   	   			toastr.error(seq+"차 진접 실리콘 교체 수정 실패하였습니다.", '', {timeOut: 5000});
   	   	   	   	    }		   	 
   	   	   	
				} else if(res.result == 'error'){
					toastr.error(res.message, '', {timeOut: 5000});
				}
   	        },
   	        complete:function(){   	        
   	        	$('#my-spinner').hide();
			}
		});
	}



	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ주자재 교체 관련 코드시작ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    
    $('#btnMetalChange').on('click', function(){ 

		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("교체할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("교체할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("교체할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}

		$('#afterLotNo').val('');
		$('#afterLotNo').attr('disabled', false);
		$('#btnModelMetalChang').attr('disabled', false);
		$('#btnMetalChangEdit').addClass('d-none');

		$('#beforeLotNo').text(mainMatrlLotNo);
		$('#afterLotNo').focus();

    	$('#metalChangeModal').modal('show');

	});

	$("#afterLotNo").keypress(function (e) {

		//엔터키
    	if (e.which == 13){
	        if( $('#afterLotNo').val() == "" ) {
	            toastr.warning('바코드를 먼저 스캔해주세요!');
	            return false;
	        }
	        if( workOrdNo == null || workOrdNo == "" ) {
	            toastr.warning('작업지시를 선택해주세요!');
	            return false;
	        }
	        
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng($('#afterLotNo').val());
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#afterLotNo').val(engToKor.toUpperCase());
	    	
	    	//자재투입내역 중복검사
	        var cval = compareBarcodeNo($('#afterLotNo').val());
	        
	        if(cval == false) {
	        	$('#afterLotNo').val("");
	            toastr.warning('이미 추가된 바코드 입니다.<br/> 바코드정보를 확인해 주세요.');
	            return false;
	        }
	        
	  	  	$.ajax({
	            url: '<c:url value="po/workOrderMatrlData"/>',
	            type: 'GET',
	            async: false,
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'workOrdNo'		: 		function() { return workOrdNo; },
	            	'barcodeNo'		: 		$("#afterLotNo").val(),
	            	'goodsCd'		: 		$("#goodsCd" + workOrdIndex).val(),
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						//1작지 1주자재 투입여부 확인
						if (data.baseCdAbbr != 'F') {
							
							/*if (compareMetalLotNo()) {
								toastr.warning("작업지시 1개당 주재료(MetalLot)를 1개만  투입 할 수 있습니다!<br>새 작업지시를 발행해 주세요!", '', {timeOut: 5000});
								return false;
							} else {								
								barcodeData = data;
								$('#workOrderMatrlTable').DataTable().row.add({}).draw(false);
								toastr.success("추가되었습니다.");
							}*/
							$('#afterLotNo').attr('disabled', true);
							$('#btnMetalChangEdit').removeClass('d-none');
							toastr.success("추가되었습니다.");
						} else {
							$('#afterLotNo').attr('disabled', true);
							$('#btnMetalChangEdit').removeClass('d-none');
							toastr.success("추가되었습니다.");
						}
						
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){}
			});
        }
	});

	//모달 주자재 교체 수정 버튼 클릭 시
	$('#btnMetalChangEdit').on('click', function(){
		$('#afterLotNo').val('');
		$('#afterLotNo').attr('disabled', false);
		$('#afterLotNo').focus();
		$('#btnMetalChangEdit').addClass('d-none');
	});
	
    //주자재 교체모달 확인 클릭 시
	$('#btnModelMetalChang').on('click', function(){

		if( $('#afterLotNo').attr('disabled') == null ) {
            toastr.warning('바코드를 먼저 스캔해주세요!');
            return false;
		}
		
		if( $('#afterLotNo').val() == "" ) {
            toastr.warning('바코드를 먼저 스캔해주세요!');
            return false;
		}

		$('#my-spinner').show();
		
		//작지 주자재 교체 ajax
		$.ajax({
			url : '<c:url value="/po/workOrderMetalChangeAllUpdate"/>',
			type : 'POST',
			data : {
				'lotNo' 		: function() { return $('#beforeLotNo').text();				},
				'beforeLotNo'	: function() { return $('#beforeLotNo').text();				},
				'afterLotNo'	: function() { return $('#afterLotNo').val();				},
				'barcodeNo	'	: function() { return $('#afterLotNo').val();				},
				'workOrdNo'		: function() { return workOrdNo;							},
				'ordDate'		: function() { return ordDateCal.replace(/-/g, '');			},
				'equipCd'		: function() { return equipCd;								},
				'goodsCd'		: function() { return $("#goodsCd" + workOrdIndex).val();	}
			},
			success : function(res) {
				let result = res.result;
				if ( result == 'ok' ) {
					toastr.success("교체되었습니다.", '', {timeOut: 3000});
				} else if( result == 'fail' ) {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				$('#workOrderMatrlTable').DataTable().ajax.reload();
				$('#btnModelMetalChang').attr('disabled', true);
				$('#btnMetalChangEdit').addClass('d-none');
				$('#my-spinner').hide();
			}
		});
		//작지 주자재 교체 ajax
	});
    
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ주자재 교체 관련 코드 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    //var userPopUpTable;
    let userNumber;
  
    //작지변경 담당자 팝업
    let userPopUpWorkOrderTable;
    $('#searchWorkOrderChangeUser').on('click', function(){
    	if(userPopUpWorkOrderTable == null || userPopUpWorkOrderTable == undefined)   {
    		userPopUpWorkOrderTable = $('#userPopUpWorkOrderTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/userAuthDeleteList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                	'gubun'         :       '002',
	                },
	                /*
	                success : function(res) {
	                    console.log(res);
	                }
	                */
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'}, 
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			$('#userPopUpWorkOrderTable tbody').on('click', 'tr', function () {
	            var data = userPopUpWorkOrderTable.row( this ).data();
	            $('#workOrderChangeUserNm').val(data.userNm);	//사원명
	            $('#workOrderChangeUserNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userPopUpWorkOrderModal').modal('hide'); 
	            $('#deleteCheckWorkOrderUserId').val(data.userId);
	            $('#deleteCheckWorkOrderUserId').attr('disabled',false);
	            $('#deleteCheckWorkOrderUserPassword').attr('disabled',false);
	            userNumber = userPopUpWorkOrderTable.row(this).data().userNumber;
			});
		} else {
			$('#userPopUpWorkOrderTable').DataTable().ajax.reload( function () {});
		}
        
    	$('#userPopUpWorkOrderModal').modal('show');

    });
    let userId;
    let userPw;
    var gubun;
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ작지 삭제,변경, 등록자 변경 시 계정 체크 코드 시작 ㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    $('#btnDeleteCheck,#btnDeleteCheckWorkOrdRestart,#btnchangeRegistrantCheck,#btnFifoAuthorityCheck').on('click', function(){
		if( $('#deleteWorkOrdCheckPopupModal').hasClass('show') ){
			/* if( $('#userNm').val() == "" || $('#userNm').val() == null ) {
	            toastr.warning('담당자를 선택해 주세요!');
	            return false;
			} */
	    	
			if( $('#deleteCheckId').val() == "" || $('#deleteCheckId').val() == null ) {
	            toastr.warning('아이디를 입력해 주세요!');
	            $('#deleteCheckId').focus();
	            return false;
			}
			
			if( $('#deleteCheckPassword').val() == "" || $('#deleteCheckPassword').val() == null ) {
	            toastr.warning('비밀번호를 입력해 주세요!');
	            $('#deleteCheckPassword').focus();
	            return false;
			}
			userId = $('#deleteCheckId').val();
			userPw = $('#deleteCheckPassword').val();
			gubun = '001';
		} else if( $('#workOrdReStartPopupModal').hasClass('show') ){
			/* if( $('#workOrderChangeUserNm').val() == "" || $('#workOrderChangeUserNm').val() == null ) {
	            toastr.warning('담당자를 선택해 주세요!');
	            return false;
			} */
	    	
			if( $('#deleteCheckWorkOrderUserId').val() == "" || $('#deleteCheckWorkOrderUserId').val() == null ) {
	            toastr.warning('아이디를 입력해 주세요!');
	            $('#deleteCheckWorkOrderUserId').focus();
	            return false;
			}
			
			if( $('#deleteCheckWorkOrderUserPassword').val() == "" || $('#deleteCheckWorkOrderUserPassword').val() == null ) {
	            toastr.warning('비밀번호를 입력해 주세요!');
	            $('#deleteCheckWorkOrderUserPassword').focus();
	            return false;
			}
			userId = $('#deleteCheckWorkOrderUserId').val();
			userPw = $('#deleteCheckWorkOrderUserPassword').val();
			gubun = '002';
		} else if ( $('#changeRegistrantPopUp').hasClass('show') ){
			if( $('#changeRegistrantUserNm').val() == "" || $('#changeRegistrantUserNm').val() == null ) {
	            toastr.warning('등록자를 선택해 주세요!');
	            return false;
			}
	    	
			if( $('#changeRegistrantId').val() == "" || $('#changeRegistrantId').val() == null ) {
	            toastr.warning('아이디를 입력해 주세요!');
	            $('#changeRegistrantId').focus();
	            return false;
			}
			
			if( $('#changeRegistrantPassword').val() == "" || $('#changeRegistrantPassword').val() == null ) {
	            toastr.warning('비밀번호를 입력해 주세요!');
	            $('#changeRegistrantPassword').focus();
	            return false;
			}
			userId = $('#changeRegistrantId').val();
			userPw = $('#changeRegistrantPassword').val();
			gubun = '003';
		} else if ( $('#fifoAuthorityCheckModal').hasClass('show') ){ //선입선출 권한 확인
	    	
			if( $('#fifoAuthorityCheckUserId').val() == "" || $('#fifoAuthorityCheckUserId').val() == null ) {
	            toastr.warning('아이디를 입력해 주세요!');
	            $('#fifoAuthorityCheckUserId').focus();
	            return false;
			}
			if( $('#fifoAuthorityCheckUserPassword').val() == "" || $('#fifoAuthorityCheckUserPassword').val() == null ) {
	            toastr.warning('비밀번호를 입력해 주세요!');
	            $('#fifoAuthorityCheckUserPassword').focus();
	            return false;
			}
			if($('#selectFifoCheck option:selected').val() == "" ) {
				toastr.warning("선입선출을 선택해 주세요.");
				$('#selectFifoCheck').focus();
				return false;
			}
			userId		= $('#fifoAuthorityCheckUserId').val();
			userPw		= $('#fifoAuthorityCheckUserPassword').val();
			gubun		= '004';
		}
		
		$('#my-spinner').show();
		
		//계정체크
		$.ajax({
			url : '<c:url value="/sm/authIdCheck"/>',
			type : 'POST',
			data : {
				'userNumber'    : function() { return userNumber;},
				'userId'        : function() { return userId;},
				'userPw'        : function() { return userPw;},
				'gubun'         : function() { return gubun;},
			},
			success : function(res) {
				let result = res.result;
				if ( result == 'ok' ) {
					toastr.success("확인되었습니다.");			
					if( $('#deleteWorkOrdCheckPopupModal').hasClass('show') ){
						$('#deleteCheckId').attr('disabled',true);
						$('#deleteCheckPassword').attr('disabled',true);
						$('#btnDeleteCheck').attr('disabled',true);
						$('#btnDeleteWorkOrdCheck').attr('disabled',false);
						$('#searchUser').attr('disabled',true);
					} else if( $('#workOrdReStartPopupModal').hasClass('show') ){
						$('#deleteCheckWorkOrderUserId').attr('disabled',true);
						$('#deleteCheckWorkOrderUserPassword').attr('disabled',true);
						$('#btnDeleteCheckWorkOrdRestart').attr('disabled',true);
						$('#btnWorkOrdReStartCheck').attr('disabled',false);
						$('#searchWorkOrderChangeUser').attr('disabled',true);
					} else if ( $('#changeRegistrantPopUp').hasClass('show') ){
						$('#changeRegistrantId').attr('disabled',true);
						$('#changeRegistrantPassword').attr('disabled',true);
						$('#btnchangeRegistrantCheck').attr('disabled',true);
						$('#bntchangeRegistrant').attr('disabled',false);
						$('#changeRegistrantSearchUser').attr('disabled',true);
						$('#changeRegistrantSearchAuthUser').attr('disabled',true);
					}  else if ( $('#fifoAuthorityCheckModal').hasClass('show') ){
						$('#fifoAuthorityCheckUserId').attr('disabled',true);
						$('#fifoAuthorityCheckUserPassword').attr('disabled',true);
						$('#btnFifoAuthorityCheck').attr('disabled',true);
						$('#selectFifoCheck').attr('disabled',true);
						$('#btnFifoChange').attr('disabled',false);
					}
				} else if( result == 'fail' ) {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message);
				}
			},
			complete : function() {
				
				$('#my-spinner').hide();
			}
		});
		
	});
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ작지 삭제 시 계정 체크 코드 끝 ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ등록자 변경 코드ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    
    $('#btnRegistrantChange').on('click', function() {
		if(!$('#outputCardTable Tbody tr').hasClass('selected')){
			toastr.warning('등록자를 변경할 순번을 선택 해주세요!');
			return false;
		}
		$('#changeRegistrantPopUp').modal('show');
		$('#bntchangeRegistrant').attr('disabled',true);
		$('#btnchangeRegistrantCheck').attr('disabled',false);
		$('#changeRegistrantSearchAuthUser').attr('disabled',false);
		$('#changeRegistrantSearchUser').attr('disabled',false);
		$('#changeRegistrantId').attr('disabled',false);
		$('#changeRegistrantPassword').attr('disabled',false);
		$('#changeRegistrantId').val('');
	    $('#changeRegistrantPassword').val('');
		$('#changeRegistrantUserNm').val('');

    });
	//등록자변경 권한유저 모달
	let changeRegistranUserTable;
    $('#changeRegistrantSearchAuthUser').on('click', function(){
    	if(changeRegistranUserTable == null || changeRegistranUserTable == undefined)   {
    		changeRegistranUserTable = $('#changeRegistranUserTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/userAuthDeleteList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                	'gubun'         :       '003',
	                },
	                /*
	                success : function(res) {
	                    console.log(res);
	                }
	                */
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'}, 
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			$('#changeRegistranUserTable tbody').on('click', 'tr', function () {
	            var data = changeRegistranUserTable.row( this ).data();
	            $('#changeRegistranUserListPopUp').modal('hide'); 
	            $('#changeRegistrantId').val(data.userId);
	            $('#changeRegistrantId').attr('disabled',false);
	            $('#changeRegistrantPassword').attr('disabled',false);
	            userNumber = changeRegistranUserTable.row(this).data().userNumber;
			});
		} else {
			$('#changeRegistranUserTable').DataTable().ajax.reload( function () {});
		}
        
    	$('#changeRegistranUserListPopUp').modal('show');

    });
    
    let changeRegistranUserAllTable;
    let changeUserNumber;
    $('#changeRegistrantSearchUser').on('click', function(){
    	if(changeRegistranUserAllTable == null || changeRegistranUserAllTable == undefined)   {
    		changeRegistranUserAllTable = $('#changeRegistranUserAllTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/matrlUserDataList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                },
	                /*
	                success : function(res) {
	                    console.log(res);
	                }
	                */
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'}, 
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			$('#changeRegistranUserAllTable tbody').on('click', 'tr', function () {
	            var data = changeRegistranUserAllTable.row( this ).data();
	            $('#changeRegistrantUserNm').val(data.userNm);	//사원명
	            $('#changeRegistrantUserNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#changeRegistranUserListAllPopUp').modal('hide'); 
	            changeUserNumber = changeRegistranUserAllTable.row(this).data().userNumber; 
			});
		} else {
			$('#changeRegistranUserAllTable').DataTable().ajax.reload( function () {});
		}
        
    	$('#changeRegistranUserListAllPopUp').modal('show');

    });
    $('#bntchangeRegistrant').on('click', function() {
    	userId = $('#changeRegistrantId').val();
		userPw = $('#changeRegistrantPassword').val();
		
		$('#my-spinner').show();
		
		$.ajax({
            url: '<c:url value="po/registrantChange"/>',
            type: 'POST', 
            async: false,
            data: {
            	'ordLotNo' : ordLotNo,
            	'changeUserNumber'  :   function() { return changeUserNumber; },
            	'userNumber'        :   function() { return userNumber; },
  	        	'userId'            :   function() { return userId; },
  	        	'userPw'            :   function() { return userPw; },
  	        	'gubun'             :   function() { return '003'; },
  	        	'subOrdLotNo'       :   function() { return subOrdLotNo; },
  	        	'productionperFormanceRegDate'  : function() { return productionperformanceRegDate; },
  	        	
            },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success("변경되었습니다.");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();
// 				$('#outputCardTable').DataTable().clear().draw(function(){});
				$('#outputCardTable').DataTable().ajax.reload(function () {});
			}
		});

    	
    });
    
    let authGubunVal = '';
    let userAuthPopUpTable = null;
	function userAuthModal(gubunVal){
		authGubunVal = gubunVal;
// 		userPopUpTable = null;
		if(userAuthPopUpTable == null || userAuthPopUpTable == undefined)   {
			userAuthPopUpTable = $('#userAuthPopUpTable').DataTable({
				language: lang_kor,
				lengthChange : false,
				paging: true,
				info: true,
				ordering: true,
				processing: true,
				autoWidth: false,
				pageLength: 20,
	            ajax: {
	                url: '<c:url value="/sm/userAuthDeleteList"/>',
	                type: 'GET',
	                data: {
	                	'menuAuth'	 	: 		menuAuth,
	                	'gubun'         :       function () { return authGubunVal; }
	                },
	                /*
	                success : function(res) {
	                    console.log(res);
	                }
	                */
	            },
	            rowId: 'userNumber',
	            columns: [
	                { data : 'userNm'}, 
	                { data : 'departmentNm'   }, 
	                { data : 'postNm' }, 
	                { data : 'chargrDutyNm'   }, 
	                { data : 'teamNm' }, 
	                { data : 'workplaceNm' },
	            ],
	            columnDefs: [
	               //{ "targets": [0], "visible" : true },
	               { "targets": [0,1,2,3,4,5],  "className": "text-center"}
	            ],
	            oSearch: {"sSearch": userNm},
	            order: [
	                [ 0, 'asc' ]
	            ],
			});
			
			$('#userAuthPopUpTable tbody').on('click', 'tr', function () {
				var data = userAuthPopUpTable.row(this).data();
				if( authGubunVal == '001' ){
					$('#userNm').val(data.userNm);	//사원명
		            $('#userNumber').val(data.userNumber);	//사원코드(hidden)
		            $('#userAuthPopUpModal').modal('hide'); 
		            $('#deleteCheckId').val(data.userId);
		            $('#deleteCheckId').attr('disabled',false);
		            $('#deleteCheckPassword').attr('disabled',false);
		            userNumber = userAuthPopUpTable.row(this).data().userNumber;

				} else if( authGubunVal == '002'){
		            $('#workOrderChangeUserNm').val(data.userNm);	//사원명
		            $('#workOrderChangeUserNumber').val(data.userNumber);	//사원코드(hidden)
		            $('#userAuthPopUpWorkOrderModal').modal('hide'); 
		            $('#deleteCheckWorkOrderUserId').val(data.userId);
		            $('#deleteCheckWorkOrderUserId').attr('disabled',false);
		            $('#deleteCheckWorkOrderUserPassword').attr('disabled',false);
		            userNumber = userAuthPopUpTable.row(this).data().userNumber;
				} else if ( authGubunVal == '003'){
					 $('#changeRegistranUserListPopUp').modal('hide'); 
			         $('#changeRegistrantId').val(data.userId);
			         $('#changeRegistrantId').attr('disabled',false);
			         $('#changeRegistrantPassword').attr('disabled',false);
			         userNumber = userAuthPopUpTable.row(this).data().userNumber;
			    } else if ( authGubunVal == '004'){
					 $('#changeRegistranUserListPopUp').modal('hide'); 
			         $('#fifoAuthorityCheckUserId').val(data.userId);
			         $('#fifoAuthorityCheckUserId').attr('disabled',false);
			         $('#fifoAuthorityCheckUserPassword').attr('disabled',false);
			         userNumber = userAuthPopUpTable.row(this).data().userNumber;
			    }
				$('#userAuthPopUpModal').modal('hide');
			});
		} else {
			//console.log(gubunVal);
			//console.log(authGubunVal);
			authGubunVal = gubunVal;
			$('#userAuthPopUpTable').DataTable().ajax.reload( function () {});
		}
        
    	$('#userAuthPopUpModal').modal('show');
    	
    	if(gubunVal == '001'){
    		$('#userAuthPopUpLabel').text("작업지시 삭제 상태 변경 관리자&조장 목록 ");
        } else if (gubunVal == '002'){
    		$('#userAuthPopUpLabel').text("작업지시 진행 상태 변경 관리자&조장 목록 ");
    	} else if (gubunVal == '003'){
    		$('#userAuthPopUpLabel').text("생산작업자 변경 관리자&조장 목록 ");
        } else {
        	$('#userAuthPopUpLabel').text("담당자 조회");
        }
	}
	
	$('#userAuthPopUpModal').on('hidden.bs.modal', function(){
		authGubunVal = '';
	});


 //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ비가동 관련 코드ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    
	$.fn.dataTable.ext.errMode = 'none'; 
	var equipDowntimeAdmDataTable = $('#equipDowntimeAdmDataTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	if(techNote == 7) {
		    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
		       	location.href = "/";
			}
		} ).DataTable({
		 dom: "<'row'<'col-sm-12 col-md-5'f><'col-sm-12 col-md-7'l>>" 
			+ "<'row'<'col-sm-12'tr>>"
			+ "<'row'<'col-sm-12 col-md-5'i><'col-sm-12 col-md-7'p>>", 	
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        lengthChange: true,
        searching: true,
        pageLength: 7,
        ajax: {
            url: '<c:url value="/po/equipDowntimeAdmDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'			:	function () { return menuAuth; 						},
            	'equipCd'			:	function () { return equipCd; 						},
            	'downtimeRegDate'	:	function () { return ordDateCal.replace(/-/g, '');	},
            	'workOrdNo'			:	function () { return workOrdNo; 					}
            },
        },
		columns: [
			{ data: 'equipNm' 			},
			{ data: 'downtimeRegDate',
				render : function(data, type, row, meta){
					return moment(data).format('YYYY-MM-DD');
				}
			},
			{ data: 'startTime'	},
			{ data: 'endTime'	},
			{ data: 'stopTime',
				render : function(data, type, row, meta){
					if(data == null || data == ''){
						return '-';
					}else{
						return data.replace(' ', '일 ').replace(':', '시간 ') + '분';
					}
					
				}
			}
		],
		columnDefs: [
			{ targets: '_all', className: 'text-center touch6', "defaultContent": "-" },
		],
		order: [
			[ 0, 'asc' ],
		],
		rowCallback: function (row, data) {
			if (data.endTime == null) {
				$(row).addClass('skyYellow');
			}
		}
    });

    var html2 = '';
    	html2 += '<button type="button" class="btn btn-danger float-right touch6" id="btnNotRunningDelete">삭제</button>';
    $('#equipDowntimeAdmDataTable_length').html(html2)

    
    let notRunningToday 			= new Date();	//현재 시간
    
    var notRunningCode1 			='';			//비가동 사유 선택 (Radio)변수
	var notRunningEquipCd 			='';			//설비명
	var notRunningDowntimeRegDate 	='';			//비가동 등록일
	var notRunningStartTime 		='';			//비가동 시작일
	var notRunningDayNightCd		='';			//비가동 주야구분
	var notRunningWorkOrdNo			='';			//비가동 작업지시 번호
	
	var notRunningDowntimeIdx		='';			//비가동 인덱스
	
	
	//비가동 시작 테이블에 들어있는 값 선택 시
    $('#equipDowntimeAdmDataTable tbody').on('click', 'tr', function () {

    	if($('#equipDowntimeAdmDataTable tbody').text() == '데이터가 없습니다.'){
			return false;
		}

		if ( $(this).hasClass('selected') ) {
		} else {
			$('#equipDowntimeAdmDataTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			notRunningEquipCd 			= equipDowntimeAdmDataTable.row(this).data().equipCd;
			notRunningDowntimeRegDate 	= equipDowntimeAdmDataTable.row(this).data().downtimeRegDate;
			notRunningStartTime 		= equipDowntimeAdmDataTable.row(this).data().startTime;
			notRunningDayNightCd 		= equipDowntimeAdmDataTable.row(this).data().dayNightCd;
			notRunningWorkOrdNo 		= equipDowntimeAdmDataTable.row(this).data().workOrdNo;

			notRunningDowntimeIdx 		= equipDowntimeAdmDataTable.row(this).data().downtimeIdx;

			var endTime = equipDowntimeAdmDataTable.row(this).data().endTime;

			if(endTime == null){
				$('#btnNotRunning_endSave').attr('disabled', false);
				$('#notRunning_endDate').attr('disabled', false);
				$('#notRunningDesc').attr('disabled', false);
			}else{
				$('#notRunning_endDate').attr('disabled', true);
				$('#notRunningDesc').attr('disabled', true);
				$('#btnNotRunning_endSave').attr('disabled', true);
			}

			//상세조회
			$.ajax({
				url : '<c:url value="/po/equipDowntimeAdmRead"/>',
				type : 'GET',
				data : {
					 'downtimeIdx'		: function () { return notRunningDowntimeIdx; 	},
					 'equipCd' 			: function () { return notRunningEquipCd; 		},
					 'workOrdNo'		: function () { return notRunningWorkOrdNo; 	}
				},
				success : function(res) {
					let data = res.data;
// 					console.log(data);
					
					if (res.result == 'ok') {

						//비가동 종료 시간
						if(data.endTime != null){
							$('#notRunning_endDate').val(data.endTime.replace(' ','T'));
						}else{
							$('#notRunning_endDate').val('');
						}

						//사유
						if(data.code2 != null){
							$('#notRunningDesc').val(data.code2);
						}else{
							$('#notRunningDesc').val('');
						}
							
						$('input[name=notRunningType]').attr('disabled', true);

						var notRunningTypeId = $("input:radio[name='notRunningType']:input[value='"+data.downtimeCd+"']").attr('id');
						$("#"+notRunningTypeId).attr('disabled', false);
						$("#"+notRunningTypeId).click();
						$("#"+notRunningTypeId).prop("checked", true);

// 						$("input:radio[name='notRunningReason']:input[value='"+data.code1+"']").prop("checked", true);

						notRunningCode1  = data.code1;
						
						toastr.success('조회 되었습니다.');
					} else {
						toastr.error(res.message);
					}
				}
			});
		}
	});
    
    //비가동 시작 버튼 클릭 시
    $('#btnNotRunning_start').on('click', function(){

    	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("비가동을 시작할 항목을 선택해주세요.");
			return false;
		}
		
		/*var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			$('#btnDeleteWorkOrder').addClass("d-none");
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
		}
		
    	if($("#workStatusCd" + workOrdIndex).val() == "S") {*/

    		notRunningNowDate();
			
			$('#btnNotRunningDelete').addClass('d-none');
        	$('#notRunningModalDialog').attr('style', 'margin-right: 82vh;');
        	$('#notRunningModalContent').attr('style', 'width: 78vh;');

    		$('#notRunningPopUpLabel').text('비가동 시작 사유');
    		$('#notRunningDateLabel').text('비가동\r시작 시간');
    		$('#notRunning_startDate').val('');
        	$('#notRunningDesc').val('');
        	$('input[name=notRunningType]').attr('disabled', false);
        	$('input[name=notRunningReason]').attr('disabled', false);
			$('#notRunningDesc').attr('disabled', false);
			
    		$('input[name=notRunningType]').prop('checked', false);
    		$('input[name=notRunningReason]').prop('checked', false);
    		$('#selectNotRunningReason_tr').empty();
			/* var rtn = '<th>비가동 사유 선택</th>';
			$('#selectNotRunningReason_tr').append(rtn); */

			$('#notRunning_startDate').removeClass('d-none');
			$('#notRunning_endDate').addClass('d-none');

			$('#btnNotRunning_startSave').removeClass('d-none');
			$('#btnNotRunning_endSave').addClass('d-none');

			$('#equipDowntimeAdmTableDiv').addClass('d-none');

			$('#notRunning_startDate').val(notRunningToday);
			
			$('#notRunningPopUpModal').modal('show');
		/*} else {
			toastr.warning('진행 상태인 작지만 비가동을 시작할 수 있습니다!', '', {timeOut: 5000});
		}*/
	});

    //비가동 시작 시간 더블 클릭 시
	$('#notRunning_startDate').on('dblclick', function () {
		notRunningNowDate();
		$('#notRunning_startDate').val(notRunningToday);
	});

    //비가동 종료 버튼 클릭 시
    $('#btnNotRunning_end').on('click', function(){

    	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("비가동을 종료할 항목을 선택해주세요.");
			return false;
		}

		$('#equipDowntimeAdmDataTable').DataTable().ajax.reload();

		$('#btnNotRunningDelete').removeClass('d-none');
    	$('#notRunningModalDialog').attr('style', 'margin-right: 113vh;');
    	$('#notRunningModalContent').attr('style', 'width: 138vh;');
    	
		$('#notRunningPopUpLabel').text('비가동 종료 확인');
    	$('#notRunningDateLabel').text('비가동  종료 시간');
		$('#notRunning_startDate').val('');
		$('#notRunning_endDate').val('');
    	$('#notRunningDesc').val('');
    	$('input[name=notRunningType]').attr('disabled', true);
    	
		$('input[name=notRunningType]').prop('checked', false);
		$('#selectNotRunningReason_tr').empty();
		/* var rtn = '<th>비가동 사유 선택</th>';
		$('#selectNotRunningReason_tr').append(rtn); */

		$('#notRunning_startDate').addClass('d-none');
		$('#btnNotRunning_startSave').addClass('d-none');
		$('#notRunning_endDate').removeClass('d-none');
		$('#btnNotRunning_endSave').removeClass('d-none');

		$('#equipDowntimeAdmTableDiv').removeClass('d-none');

// 		$('#notRunning_endDate').val(notRunningToday);
		
		$('#notRunningPopUpModal').modal('show');
	});

    //비가동 종료 시간 더블 클릭 시
	$('#notRunning_endDate').on('dblclick', function () {
		notRunningNowDate();
		/*if(notRunningStartTime != ''){
			$('#notRunning_endDate').attr('min', notRunningStartTime.replace(' ','T'));
		}*/
		$('#notRunning_endDate').val(notRunningToday);
	});

    //비가동 구분 값 변경되었을 때
    $('input[name=notRunningType]').on('change', function(){

        let baseGroupCd = $(this).val();

		$.ajax({
			url: '<c:url value="bm/systemCommonCodeDataList"/>',
			type: 'GET',
			data: {
				'menuAuth'	 	: menuAuth,
				'baseGroupCd'	: function() { return '012'; },
				'etc1'			: function() { return baseGroupCd; }
			},
			success : function(res) {
				let data = res.data;
// 				console.log(data.length);
// 				console.log(data);

				if (res.result == 'ok') {

					$('#selectNotRunningReason_tr').empty();
					
// 					var rtn_sTd = '<td>';
// 					var rtn_ETd = '</td>';
					
					var rtn = '';
// 						rtn += '<th style="width: 60px;">비가동<br>원인 선택</th>';
						rtn += '<td>';
// 						rtn += '';

					for(var i=0; i<data.length; i++){
// 						rtn += '<label for="notRunningReason_'+data[i].baseCd+'">';
						rtn += '<div class="row mt-2"">';	//style="display: flex; align-items: center;
						rtn += '	<div class="col-9 text-center touch6">'+data[i].baseCdNm+'</div>';
						rtn += '	<div class="col-3 text-center">';
						rtn += '		<input type="radio" style="width:25px; height:25px; display: flex; align-items: center;" value="'+data[i].baseCd+'" id="notRunningReason_'+data[i].baseCd+'" name="notRunningReason">';
						rtn += '	</div>';
						rtn += '</div>';
// 						rtn += '</label>';
// 						rtn += '<br>';
					}

					rtn += '</td>';

					$('#selectNotRunningReason_tr').append(rtn);

					if(notRunningCode1 != ''){
						$("input:radio[name='notRunningReason']:input[value='"+notRunningCode1+"']").prop("checked", true);
						$('input[name=notRunningReason]').attr('disabled', true);
						$("input:radio[name='notRunningReason']:input[value='"+notRunningCode1+"']").attr('disabled', false);
					}
					
				} else {
					toastr.error(res.message);
				}
			}
		});
	});

    //비가동 시작 사유 저장 버튼 클릭 시
    $('#btnNotRunning_startSave').on('click', function(){

    	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("비가동을 시작할 항목을 먼저 선택해주세요.");
			return false;
		}
		if ($('#notRunning_startDate').val() == '' || $('#notRunning_startDate').val() == null) {
    		toastr.warning("비가동 시작 시간을 입력해주세요!");
			return false;
    	}
    	if (!$('input[name=notRunningType]:checked').is(":checked")) {
    		toastr.warning("비가동 구분을 선택해주세요!");
			return false;
    	}
    	if (!$('input[name=notRunningReason]:checked').is(":checked")) {
    		toastr.warning("비가동 사유을 선택해주세요!");
			return false;
    	}

		/*var date 		= new Date(new Date().setHours(0,0,0,0));	//오늘날짜 00:00:00
		var secondDiff 	= parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today 		= new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today 			= getDateType(today);						//YYYY-MM-DD 형식으로 변환
		var yesterday 	= new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday 		= getDateType(yesterday);					//YYYY-MM-DD 형식으로 변환

		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#ordGubunCd').val("D");
			ordGubunCd = "D";
		}*/

    	//비가동 저장
		$.ajax({
	    	url: '<c:url value="po/equipDowntimeAdmCreate_F3"/>',
	        type: 'POST',
	        async: false,
	        data: {
	        	'menuAuth'	 		: 	menuAuth,
	        	'equipCd'			:	function() { return equipCd; }, 						//설비코드
	        	'downtimeRegDate'	:	function() { return ordDateCal.replace(/-/g, ''); },	//비가동 등록일
// 	        	'dayNightCd'		:   function() { return ordGubunCd; },						//주야간 구분
	        	'workOrdNo'			:   function() { return workOrdNo; },						//작업지시 번호
	        	'downtimeCd'  		:   $('input[name=notRunningType]:checked').val(),			//비가동 구분	--> 시스템 공통코드(011번에 클릭한 코드 번호)
	        	'startTime'			:	moment($('#notRunning_startDate').val()).format('YYYY-MM-DD HH:mm'),	//시작 시간
	        	'code1'  			:   $('input[name=notRunningReason]:checked').val(),		//코드 1		--> 시스템 공통코드(012번에 클릭한 코드 번호)
	        	'code2'  			:   $('#notRunningDesc').val(),								//코드 2		--> 사유
	        },
	        success: function (res) {
	            var data = res.data;
	       		if(res.result == "ok"){
	       			$('#notRunningPopUpModal').modal('hide');
	       			toastr.success("비가동 확인 시작되었습니다.");
	       		} else{
	       			toastr.error(res.message, '', {timeOut: 5000});
	       		}
	       		$('#my-spinner').hide();
	        }
      	});
		//비가동 저장
	});

    //비가동 종료  저장 버튼 클릭 시
    $('#btnNotRunning_endSave').on('click', function(){

    	if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning("비가동을 시작할 항목을 먼저 선택해주세요.");
			return false;
		}

    	if($('#equipDowntimeAdmDataTable tbody tr').hasClass('selected')=='') {
			toastr.warning("비가동을 시작할 항목을 선택해주세요.");
			return false;
		}

    	if(notRunningWorkOrdNo=='') {
			toastr.warning("비가동을 시작할 항목을 선택해주세요.");
			return false;
		}

		if ($('#notRunning_endDate').val() == '' || $('#notRunning_endDate').val() == null) {
    		toastr.warning("비가동 종료 시간을 입력해주세요!");
			return false;
    	}
    	if (!$('input[name=notRunningType]:checked').is(":checked")) {
    		toastr.warning("비가동 구분을 선택해주세요!");
			return false;
    	}
    	if (!$('input[name=notRunningReason]:checked').is(":checked")) {
    		toastr.warning("비가동 사유을 선택해주세요!");
			return false;
    	}

		/*var date 		= new Date(new Date().setHours(0,0,0,0));	//오늘날짜 00:00:00
		var secondDiff 	= parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today 		= new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today 			= getDateType(today);						//YYYY-MM-DD 형식으로 변환
		var yesterday 	= new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday 		= getDateType(yesterday);					//YYYY-MM-DD 형식으로 변환

		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#ordGubunCd').val("N");
			ordGubunCd = "N";
		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#ordGubunCd').val("D");
			ordGubunCd = "D";
		}*/

		//중단 시간 계산
		let startTime 	= notRunningStartTime;
		let endTime 	= $('#notRunning_endDate').val();
		var seconds 	= (Date.parse(endTime) - Date.parse(startTime)) / 1000;
		var min			= parseInt(seconds/60);

	    var days		= Math.floor(min / 60 / 24)
	    var hours		= Math.floor((min - (days * 60 * 24 )) / 60);
	    var mins		= min - (days * 60 * 24) - (hours * 60);
	 
	    var daysStr 	= days;
	    var hourStr 	= (hours > 9)? hours : '0' + hours
	    var minStr 		= (mins > 9)? mins : '0' + mins

   		let timeDiff 	= daysStr+' '+hourStr+':'+minStr;
// 		console.log(daysStr+'일 '+hourStr+'시간 '+minStr+'분 ');
		//중단 시간 계산	

    	//비가동 저장
		$.ajax({
	    	url: '<c:url value="po/equipDowntimeAdmaUpdate"/>',
	        type: 'POST',
	        async: false,
	        data: {
	        	'menuAuth'	 		: 	menuAuth,
	        	'downtimeIdx'		: 	function() { return notRunningDowntimeIdx; 		},
	        	'equipCd'			:	function() { return equipCd; 					},					//설비코드
	        	'downtimeRegDate'	:	function() { return notRunningDowntimeRegDate;	},					//비가동 등록일
	        	'dayNightCd'		:   function() { return notRunningDayNightCd; 		},					//주야간 구분
	        	'workOrdNo'			:   function() { return notRunningWorkOrdNo; 		},					//주야간 구분
	        	'startTime'			:	notRunningStartTime,												//시작 시간
	        	'endTime'			:	moment($('#notRunning_endDate').val()).format('YYYY-MM-DD HH:mm'),	//종료 시간
    			'stopTime'			:	function() { return timeDiff; 					},					//중단 시간
	        	'code2'  			:   $('#notRunningDesc').val(),											//코드 2		--> 사유
	        },
	        success: function (res) {
	            var data = res.data;
	       		if(res.result == "ok"){
// 	       			$('#notRunningPopUpModal').modal('hide');

					$('#notRunning_endDate').attr('disabled', true);
					$('#notRunningDesc').attr('disabled', true);
					$('#btnNotRunning_endSave').attr('disabled', true);
					notRunningCode1='';
					notRunningEquipCd 			='';	//설비명
					notRunningDowntimeRegDate 	='';	//비가동 등록일
					notRunningStartTime 		='';	//비가동 시작일
					notRunningDayNightCd		='';	//비가동 주야구분
					notRunningWorkOrdNo			='';	//비가동 작업지시 번호
					notRunningCode1 			='';	//비가동 사유 선택 (Radio)변수
					
					notRunningDowntimeIdx		='';
					$('#equipDowntimeAdmDataTable').DataTable().ajax.reload();
	       			toastr.success("비가동 확인 종료되었습니다.");
	       		} else{
	       			toastr.error(res.message, '', {timeOut: 5000});
	       		}
	       		$('#my-spinner').hide();
	        }
      	});
		//비가동 저장
	});

    //비가동 종료 확인 삭제 버튼 클릭 시
	$('#btnNotRunningDelete').on('click', function(){

    	if($('#equipDowntimeAdmDataTable tbody tr').hasClass('selected')=='') {
			toastr.warning("삭제할 비가동 항목을 선택해주세요.");
			return false;
		}

    	if(notRunningWorkOrdNo=='') {
    		toastr.warning("삭제할 비가동 항목을 선택해주세요.");
			return false;
		}

		$('#deleteReliabilityModal').attr('style', 'z-index: 1060; display: block; background-color: #14141f52;');
    	$('#deleteReliabilityModal').modal({backdrop: 'static'});
    	$('#deleteReliabilityModal').modal('show');
	});

    //비가동 삭제 모달이 hide이 됐을 때
	$('#btnNotRunningDelete').on('hidden.bs.modal', function (e) {
		$('#deleteReliabilityModal').attr('style', '');
	});

    //비가동 삭제 모달 - 삭제 버튼 클릭 시
	$('#btnModelDel').on('click', function(){
		
    	if($('#equipDowntimeAdmDataTable tbody tr').hasClass('selected')=='') {
    		toastr.warning("삭제할 비가동 항목을 선택해주세요.");
			return false;
		}

    	if(notRunningWorkOrdNo=='') {
    		toastr.warning("삭제할 비가동 항목을 선택해주세요.");
			return false;
		}
		
		//삭제 ajax
		$.ajax({
			url : '<c:url value="/po/equipDowntimeAdmaDelete"/>',
			type : 'POST',
			data : {
				'downtimeIdx'		: 	function() { return notRunningDowntimeIdx; 			},
				'equipCd' 			: 	function() { return notRunningEquipCd; 				},
				'workOrdNo'			:   function() { return notRunningWorkOrdNo; 			}
			},
			success : function(res) {
				let data = res.data;
// 				console.log(data);
				if (res.result == 'ok') {
					$('#equipDowntimeAdmDataTable').DataTable().ajax.reload();

					$('#notRunning_endDate').val('');
			    	$('#notRunningDesc').val('');
			    	$('input[name=notRunningType]').attr('disabled', true);
					$('input[name=notRunningType]').prop('checked', false);
					$('#btnNotRunning_endSave').attr('disabled', false);
					$('#selectNotRunningReason_tr').empty();
					
					notRunningCode1='';
					notRunningEquipCd 			='';	//설비명
					notRunningDowntimeRegDate 	='';	//비가동 등록일
					notRunningStartTime 		='';	//비가동 시작일
					notRunningDayNightCd		='';	//비가동 주야구분
					notRunningWorkOrdNo			='';	//비가동 작업지시 번호
					notRunningCode1 			='';	//비가동 사유 선택 (Radio)변수

					notRunningDowntimeIdx		='';
					$('#deleteReliabilityModal').modal('hide');
					toastr.success('삭제되었습니다.');
				} else {
					toastr.error(res.message);
				}
			}
		});
		//삭제 ajax
	});

    //비가동 사유 취소 버튼 클릭 시
	/*$('#btnNotRunningCancel').on('click', function(){
		notRunningCode1='';
		$('#notRunningPopUpModal').modal('hide');
	});*/

    //비가동 사유 모달이 hide이 됐을 때
	$('#notRunningPopUpModal').on('hidden.bs.modal', function (e) {
		notRunningCode1				='';
		notRunningEquipCd 			='';	//설비명
		notRunningDowntimeRegDate 	='';	//비가동 등록일
		notRunningStartTime 		='';	//비가동 시작일
		notRunningDayNightCd		='';	//비가동 주야구분
		notRunningWorkOrdNo			='';	//비가동 작업지시 번호
		notRunningCode1 			='';	//비가동 사유 선택 (Radio)변수

		notRunningDowntimeIdx		='';
	});

	//현재 시간 구하기
	function notRunningNowDate(){
		//날짜
		notRunningToday 	= new Date();  
		let year 		= notRunningToday.getFullYear(); 						// 년
		let month 		= ("0" + (1 + notRunningToday.getMonth())).slice(-2);	// 월
		let date 		= ("0" + notRunningToday.getDate()).slice(-2);			// 일
		let hours 		= ("0" + notRunningToday.getHours()).slice(-2);			// 시
		let minutes 	= ("0" + notRunningToday.getMinutes()).slice(-2);		// 분
		notRunningToday = year+'-'+month+'-'+date+'T'+hours+':'+minutes			// 합

// 		notRunningToday = moment(notRunningToday).format('YYYY-MM-DD HH:mm').replace(' ','T');	//날짜 넣어줄때 'T'가 있어야 값이  들어감
		//날짜
	}
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ비가동 관련 코드 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
    
    
    
    
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ비전 불량 현환    ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
    
    
   	//비전불량 현황 입력 버튼
	$('#btnVisionFaulty').on('click', function() {
		if (workOrdNo == null) {
			toastr.warning("생산실적을 조회할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("비전부량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("비전부량을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}
	
		//불량중량
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
			
		} else {
			if( workStatusCd != "S" && workStatusCd != "C") {
			  	toastr.warning("진행중이거나 완료된 작업지시만 비전불량을 입력 할 수 있습니다!");
				/*$('#btnOutputDelete').attr('disabled', true);
				$('#btnOutputAdd').attr('disabled', true);
				$('#btnOutputEdit').attr('disabled', true);
				$('#btnOutputSave').attr('disabled', true);*/
				$('#btnVisionFaultyAdd').attr('disabled',true);
				$('#btnVisionFaultyEdit').attr('disabled',true);
				$('#btnVisionFaultySave').attr('disabled',true);
				$('#btnVisionFaultyDelete').attr('disabled',true);
				$('.visionFaulty_num_only').attr('disabled',true);
				
			} else {
				//생산실적 버튼들 활성화
				//$('#btnOutputDelete').attr('disabled', false);
				//$('#btnOutputAdd').attr('disabled', false);
				//$('#btnOutputEdit').attr('disabled', false);
				$('#btnVisionFaultyAdd').attr('disabled',false);
				$('#btnVisionFaultyEdit').attr('disabled',false);
				$('#btnVisionFaultySave').attr('disabled',false);
				$('#btnVisionFaultyDelete').attr('disabled',false);
				$('.visionFaulty_num_only').attr('disabled',false);
			}
			//$('#gubun').attr('disabled', true);
			//$('#firstWeight').attr('disabled', true);
			//$('#visionEdgeWeight').attr('disabled', true);
			//$('#workOrdDate').attr('disabled', true);
			
	  	  	$("#leftList").animate({
				width : "0%"
			}, 0, function(){
				setTimeout(function() {
					$('#leftList').addClass("d-none");				//오른쪽 버튼 모음
					//$("#leftList").css("display","");
				}, 150);
			});
			$("#middleList").animate({
				width : "58%"
			}, 0);
			$("#rightList").animate({
				width : "41.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				//$('#equipSizeCondStepCard').addClass("d-none");	//초,중물 입력
				$('#visionFaultyCard').removeClass("d-none");		//생산실적 입력
				//$('#faultyCard').addClass("d-none");				//생산실적 입력
				//$('#btnStepReload').addClass('d-none');			//초,중,종물 재조회 버튼
				$('#btnAddWorkOrder').addClass('d-none');			//작지 추가 버튼
				$('#btnDeleteWorkOrder').addClass('d-none');		//작지 삭제 버튼
				//$('#btnOrdLotNoFirstStepNew').addClass('d-none');	//초물 버튼
				//$('#btnOrdLotNoSecondStepNew').addClass('d-none');//중물 버튼
				//$('#btnOrdLotNoThirdStepNew').addClass('d-none');	//종물 버튼
	
				$('#btnNotRunning_start').addClass('d-none');		//비가동 시작 버튼
				$('#btnNotRunning_end').addClass('d-none');			//비가동 종료 버튼
				$('#btnOrdLotNoFirstStepNew').addClass('d-none');	//초물 버튼
				$('#btnOrdLotNoSecondStepNew').addClass('d-none');	//중물 버튼
				$('#btnOrdLotNoThirdStepNew').addClass('d-none');	//종물 버튼
				$('#btnPtfe1Faulty').addClass('d-none');			//1차 진접 테프론 교체
				$('#btnPtfe2Faulty').addClass('d-none');			//2차 진접 테프론 교체
				$('#btnStart').addClass('d-none');					//작지 추가 버튼
				$('#btnEnd').addClass('d-none');					//작지 추가 버튼
				$('#btnReStart').addClass("d-none");
				$('#btnCancel').addClass('d-none');					//작지 추가 버튼
				$('#workUserNm').addClass('d-none');

				$('#visionUpFaultyTbody tr td input').attr('disabled', true);
				$('#visionDownFaultyTbody tr td input').attr('disabled', true);
			});
			
			$('#visionFaultyOrdDate').val('0');
			$('#visionFaultySumyCnt').val('0');
			$('#visionFaultyRegDate').val('');
			$('#visionBadTotal1').text('0');
			$('#visionBadTotal2').text('0');
			$('.visionFaulty_num_only').val('0');
			sideView = "visionFaulty";
			//uiProc(true);
			
			$('#visionFaultyCardTable').DataTable().ajax.reload();
			$('#mainMatrlLotNo').text('선택 주자재 : ' + mainMatrlLotNo);
	
		}
	});
    
    
    
    //비전불량 수량목록 테이블
	let visionFaultyCardTable = $('#visionFaultyCardTable').DataTable({
		language: lang_kor,
		lengthChange : false,
		paging: true,
		info: true,
		ordering: false,
		processing: false,
		autoWidth: false,
		pageLength: 5,
        ajax: {
        	url: '<c:url value="/po/readVisionFaultyAdmList_F2"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: 	menuAuth,
             	'workOrdNo'	:	function() { return workOrdNo; }, 
            },
		},
		columns: [
			{ data: 'seq' },
			{ data: 'workOrdNo' },
			{ data: 'lotNo' },
			{ data: 'faultyCntSum' },
			{
				data: 'faultyRegDate',
				render: function(data, type, row) {
					return moment(data).format("YYYY-MM-DD");
				}
			},
			{ data: 'inspctChargerNm' },
		],
		columnDefs: [
			{ targets: [0,1,2,4,5], className: 'text-center' },
			{ targets: [3], className: 'text-right' },
			{ targets: [3], render: $.fn.dataTable.render.number( ',' ) },
		],
		//order: [
		//	[ 0, 'asc' ],
		//],
		drawCallback: function () {
			let visionFaultySum = $('#visionFaultyCardTable').DataTable().column(3, {page: 'all'} ).data().sum();
			$('#visionFaultySum').text(addCommas(visionFaultySum));
        },
    });
    
	//비전불량 테이블 생성
	function visionUpFaultyHdCreate() {
    	let Hd_metal	= '';  
    	let Hd_metal1	= '<tr>';
    	let Hd_metal2	= '<tr>';
		let arrayLength = 0;
    	
    	$.each(visionFaultyMinorCode, function(index,item) {				
    		if(item.etc1 == '001') {
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control visionFaulty_num_only visionFualty_num_sum text-right touch6" id="visionUp'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="visionUp'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	}
        	}
		});
		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;

		$('#visionUpFaultyTbody').html(Hd_metal); 	
	}

	//불량 테리블 2 생성
	function visionDownFaultyHdCreate() {   			
    	let Hd_metal = '';  
    	let Hd_metal1 = '<tr>';
    	let Hd_metal2 = '<tr>';
		let arrayLength = 0;
    	
    	$.each(visionFaultyMinorCode, function(index,item) {				
    		if(item.etc1 == '002'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control visionFaulty_num_only visionFualty_num_sum text-right touch6" id="visionDown'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="visionDown'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_metal1 += '</tr>';
	    			Hd_metal2 += '</tr>';
	    			Hd_metal += Hd_metal1;
	    			Hd_metal += Hd_metal2;
	    			Hd_metal1 = '';
	    			Hd_metal2 = '';
	    			Hd_metal1 += '<tr>';
        			Hd_metal2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_metal += Hd_metal1;
		Hd_metal += Hd_metal2;
		$('#visionDownFaultyTbody').html(Hd_metal); 	
	}

	//비전불량탭1
	$('#visionFaultyTab1').click(function(){	
		$('#visionUpFaultyDiv').removeClass("d-none");
		$('#visionDownFaultyDiv').addClass("d-none");
	});

	//비전불량탭1
	$('#visionFaultyTab2').click(function(){
		$('#visionUpFaultyDiv').addClass("d-none");
		$('#visionDownFaultyDiv').removeClass("d-none");
	});

	//비전불량 등록 버튼 클릭시
	$('#btnVisionFaultyAdd').on('click', function() {
		mainView == "visionFaulty"
		visionFaultyView = 'add';
		$("#btnVisionFualtyEdit").attr("disabled", true);
		$("#btnVisionFaultySave").attr("disabled", false);
		$("#visionFaultyOrdDate").attr("disabled", false);
		$("#visionFaultyDayNightCd").attr("disabled", false);
		$(".visionFaulty_num_only").attr("disabled", false);
		$('#visionFaultyCardTable').DataTable().$('tr.selected').removeClass('selected');
		
		$('#visionBadTotal1').text('0');
		$('#visionBadTotal2').text('0');
		$("#visionFaultySumyCnt").val("0");
		$(".visionFaulty_num_only").val("0");
		$("#visionFaultyRegDate").val("0");
		
		var date = new Date(new Date().setHours(0,0,0,0));			//오늘날짜 00:00:00
		var secondDiff = parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today = new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);			//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);	//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#visionFaultyOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "visionFaultyDayNightCd", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#visionFaultyOrdDate').val(yesterday);
			selectBoxAppend(ordGubunCode, "visionFaultyDayNightCd", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#visionFaultyOrdDate').val(today);
			selectBoxAppend(ordGubunCode, "visionFaultyDayNightCd", "D", "");
		}
	});

	//비전불량 수정 버튼
	$('#btnVisionFaultyEdit').on('click', function() {
    	if (workOrdNo == null || workOrdNo == '') {
			toastr.warning("수정할 작업지시를 선택해주세요!");
            return false;
        }
    	if (!$('#visionFaultyCardTable tr').hasClass('selected')) {
			toastr.warning("수정할 라인을 선택해주세요!");
            return false;
        }
        
		visionFaultyView = 'edit';
		$("#btnVisionFualtyEdit").attr("disabled", false);
		$("#btnVisionFaultySave").attr("disabled", false);
		$("#visionFaultyOrdDate").attr("disabled", true);
		$("#visionFaultyDayNightCd").attr("disabled", true);
		$(".visionFaulty_num_only").attr("disabled", false);
	});
	
	let visionFaultySum = 0;
	let visionFautlyTemp = '';
	//비전불량수량 총합계
	function visionFaultyCntCheck() {
		visionFaultySum = 0;
		$.each($('input.visionFaulty_num_only'), function(index,item){				
			visionFaultySum += parseInt($(this).val() || 0);
		});
		
		visionFautlyTemp = true
		return visionFautlyTemp;
	}
	
	//비전불량 저장
	$('#btnVisionFaultySave').on('click', function() {
	 	if (workOrdNo == null || workOrdNo == '') {
  	 		toastr.warning('작업지시를 선택해 주세요!');
  	 		return false;
  	 	}

	 	var numCheck = false;
  		$.each($('input.visionFaulty_num_only'), function(index,item) {
  			if (!$.trim($(this).val())) {
  				$(this).focus();
  				numCheck = true;
  				return false;
  			}
  		});
  		
  		if (numCheck) {
  			toastr.warning('잘못 입력된 불량수량이 존재합니다.<br>각 불량항목들을 확인해주세요!');
  			return false;
  		}

  		//비전불량수량 총합 계산
		visionFaultyCntCheck();

  		$('#my-spinner').show();

  		var dataArray = new Array();
  		//var edgeOutputCnt = 0;

  		//불량 1
  		$.each($('#visionUpFaultyTbody .visionFaulty_num_only'), function() {
  			if($(this).val() != '0' && $(this).val() != '00') {
  				var rowData = new Object();
  				rowData.workOrdNo 				= workOrdNo;											//	작업지시번호
  				rowData.lotNo 					= mainMatrlLotNo;										//	주재료
  				rowData.visionFaultySeq 		= visionFaultySeq;										//
  				rowData.dayNightCd 				= $('#visionFaultyDayNightCd').val();					//
  				rowData.faultyRegDate 			= $('#visionFaultyOrdDate').val().replace(/-/g,"");		//
  				rowData.majorCd 				= '001';												//	대분류 코드
  				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
  				rowData.visionFaultySum 		= visionFaultySum										//	총 불량 개수
  				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
  				dataArray.push(rowData);
  			}
  		});

  		//불량 2
  		$.each($('#visionDownFaultyTbody .visionFaulty_num_only'), function() {
  			if($(this).val() != '0' && $(this).val() != '00'){	
  				var rowData = new Object();
  				rowData.workOrdNo 				= workOrdNo;											//	작업지시번호
  				rowData.lotNo 					= mainMatrlLotNo;										//	주재료
  				rowData.visionFaultySeq 		= visionFaultySeq;										//
  				rowData.dayNightCd 				= $('#visionFaultyDayNightCd').val();					//
  				rowData.faultyRegDate 			= $('#visionFaultyOrdDate').val().replace(/-/g,"");		//
  				rowData.majorCd 				= '002';												//	대분류 코드
  				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
  				rowData.visionFaultySum 		= visionFaultySum										//	총 불량 개수
  				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
  				dataArray.push(rowData);
  			}
  		});

  		if (dataArray.length == 0) {
  			toastr.warning('비전불량수량을 입력해주세요.');
  			$('#my-spinner').hide();
  			return false;
  		}

  		//console.log(dataArray);
  		
  		var url = null;
  		if (visionFaultyView == "add") {
  			url = '<c:url value="/po/visionFaultyInsert_F2"/>';
  		} else if (visionFaultyView == "edit") {
  			url = '<c:url value="/po/visionFaultyUpdate_F2"/>';
  		}

  		$.ajax({
  			url: url,
  			type: 'POST',
  			data: JSON.stringify(dataArray),
  			dataType:"json",
  			contentType : "application/json; charset=UTF-8",		                                                                                    				
  			success: function (res) {                                                                  				
  				let data = res.data;
  				if(res.result == 'ok') {
  					$('#visionFaultySumyCnt').val(data.faultyCntSum);
  					$('#visionFaultyRegDate').val(moment(data.regDate).format("YYYY-MM-DD HH:mm:ss"));
  					$('#visionFaultyOrdDate').attr('disabled', true);
  					$('#visionFaultyDayNightCd').attr('disabled', true);
  					$('#btnVisionFaultySave').attr('disabled', true);
  					$('.visionFaulty_num_only').attr('disabled', true);
  					$('#visionFaultySumyCnt').val(visionFaultySum);
  					totalVisionFaultyChange();	//합계수량 계산
  					$('#visionFaultyCardTable').DataTable().ajax.reload();
  					toastr.success(res.message);
  					
  				} else if (res.result == 'fail') {
  					toastr.warning(res.message, '', {timeOut: 5000});
  				} else if (res.result == 'error') {
  					toastr.error(res.message, '', {timeOut: 5000});
  				}
  			},
  			complete:function(){
  				$('#my-spinner').hide();
  			}
  		});
	 	
  	});


	let visionFaultyView = '';
	//불량중량 삭제
    $('#btnVisionFaultyDelete').on('click', function() {
    	if ( !$('#visionFaultyCardTable tr').hasClass('selected') ) {
			toastr.warning("삭제할 라인을 선택해주세요.");
            return false;
        }
        
    	$('#deleteVisionFaultyPopupModal').modal('show');
    });

	//불량중량 삭제
    $('#btnDeleteVisionFaultyCheck').on('click', function() {
    	if ( !$('#visionFaultyCardTable tr').hasClass('selected') ) {
			toastr.warning("삭제할 라인을 선택해주세요.");
            return false;
        }

		$.ajax({
			url: '<c:url value="/po/visionFaultyDelete_F2"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'		: 		menuAuth,
				'workOrdNo'		: 		function() { return workOrdNo; },
				'seq'			: 		function() { return visionFaultySeq; },
			},	                                                                                    				
  			success: function (res) {                                                                  				
  				if(res.result == 'ok') {
  					$('#visionFaultyOrdDate').val('0');
  					$('#visionFaultySumyCnt').val('0');
  					$('#visionFaultyRegDate').val('');
  					$('#visionBadTotal1').text('0');
  					$('#visionBadTotal2').text('0');
  					$('.visionFaulty_num_only').val('0');
  					$('#visionFaultyCardTable').DataTable().ajax.reload();
  					toastr.success(res.message);
  				} else if (res.result == 'fail') {
  					toastr.warning(res.message, '', {timeOut: 5000});
  				} else if (res.result == 'error') {
  					toastr.error(res.message, '', {timeOut: 5000});
  				}
  			},
  			complete:function(){
  				$('#my-spinner').hide();
  			}
  		});
  		
    });
    
    

    $('#visionFaultyCardTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			//equipNm = "";
		} else {
			$('#visionFaultyCardTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			//$('#btnWorkOrdConnect').addClass('d-none');
			visionFaultySeq = visionFaultyCardTable.row(this).data().seq;
			$('#visionFaultyOrdDate').val(moment(visionFaultyCardTable.row(this).data().faultyRegDate).format("YYYY-MM-DD"));
			selectBoxAppend(ordGubunCode, "visionFaultyDayNightCd", visionFaultyCardTable.row(this).data().dayNightCd, "");
			$('#visionFaultySumyCnt').val(visionFaultyCardTable.row(this).data().faultyCntSum);
			$('#visionFaultyRegDate').val(moment(visionFaultyCardTable.row(this).data().regDate).format("YYYY-MM-DD HH:mm:ss"));
		
			//비전 불량수량 조회
			readVisionFaultyAdmCodeList()
		}

    });


	let visionFaultySeq = '';
	//비전 불량수량 조회
	function readVisionFaultyAdmCodeList() {
		$.ajax({
        	url: '<c:url value="/po/readVisionFaultCodeList_F2"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'workOrdNo'		:		function() { return workOrdNo; },
            	'lotNo'			:		function() { return mainMatrlLotNo; },
            	'seq'			:		function() { return visionFaultySeq; },
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                	$(".visionFaulty_num_only").val("0");
                	$(".visionFaulty_num_only").attr('disabled', true);
                	var i = 0;
                	$.each($('.visionFaulty_num_only'), function(index1, item1) {
                		if(data.length > i) {
                			$.each(data, function(index2, item2) {
	                			if ($(item1).parent().find('input[type=hidden]').val() == item2.minorCd) {
	                				$(item1).val(item2.faultyCnt);
		                			i++;
 		                		}
		                	});
                		}
 	   				});
                	searchData = true;
				} else if (res.result == 'fail') {
                	toastr.warning(res.message, '', {timeOut: 5000});
                	searchData = false;
				} else if (res.result == 'error') {
                	toastr.error(res.message, '', {timeOut: 5000});
                	searchData = false;
				}
			},
			complete:function() {
 				$('#visionFaultyOrdDate').attr('disabled', true);
 				$('#visionFaultyDayNightCd').attr('disabled', true);
				$("#visionFaulty_num_only").attr("disabled", true);
				$("#btnVisionFaultySave").attr("disabled", true);
				totalVisionFaultyChange();	//합계수량 계산
				$('#my-spinner').hide();	 						
			}
		});
	}


	//총 불량품
	function totalVisionFaultyChange() {
		var badTotal1 = 0;
		var badTotal2 = 0;
		for(var i=0; i<$('#visionUpFaultyTbody tr td').length; i++){
		    if($('#visionUpFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	badTotal1 = parseInt(badTotal1) + parseInt($('#visionUpFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#visionDownFaultyTbody tr td').length; i++){
		    if($('#visionDownFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	badTotal2 = parseInt(badTotal2) + parseInt($('#visionDownFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		$('#visionBadTotal1').text(addCommas(badTotal1));
		$('#visionBadTotal2').text(addCommas(badTotal2));
		$('#visionFaultySumyCnt').val(addCommas(parseInt(badTotal1) + parseInt(badTotal2)));
    }
    
	//숫자만 입력, 길이, 정수만 입력
	$('.visionFaulty_num_only').keyup(function (event) {
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
		var _pattern2 = /^\d*[.]\d{1}$/;
        if (_pattern2.test( temp)) {
        	toastr.warning("정수만 입력 가능합니다.");
        	$(this).val("0");
 			$(this).select();
            return false;
		}

        //$(this).val() = addCommas(temp);
	});
    
    
    //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ비전 불량 현환 끝ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ//
    
    
    
    let userPopUpTable = null;
   	//let userAuthPopUpTable = null;
   	
   	function selectPreWorkCharger(gubun) {
   	   	$('#userPopUpModal').attr('style', 'display: block; background-color: #14141f52;');
   	    
		if(userPopUpTable == null || userPopUpTable == undefined)	{
			userPopUpTable = $('#userPopUpTable').DataTable({
		        language: lang_kor,
		        lengthChange : false,
		        paging: true,
		        info: true,
		        ordering: true,
		        processing: true,
		        autoWidth: false,
		        ajax: {
		            url: '<c:url value="/sm/matrlUserDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 		menuAuth,
		            },
		        },
		        rowId: 'userNumber',
		        columns: [
						{ data : 'userNm'		}, 
						{ data : 'departmentNm'	}, 
						{ data : 'postNm'		}, 
						{ data : 'chargrDutyNm'	}, 
						{ data : 'teamNm' 		}, 
						{ data : 'workplaceNm'	},
		        ],
		        columnDefs: [
		        	{ "targets": [0,1,2,3,4,5],  "className": "text-center"}
		        ],
		        oSearch: {"sSearch": userNm},
		        order: [
		            [ 0, 'asc' ]
		        ],
		        buttons: [],
		    });

		    $('#userPopUpTable tbody').on('click', 'tr', function () {
		    	var data = userPopUpTable.row( this ).data();
		    	if( gubun == "prodWorker" ) {
	                $('#workerIdCd').val(data.userNumber);
	                $('#workerIdNm').val(data.userNm);
//	                 $('#workTeamCd').val(data.teamCd);
			    } else if( gubun == "trayWorker") {
			    	$('#trayWorkerIdCd').val(data.userNumber);
	                $('#trayWorkerIdNm').val(data.userNm);
				}
		    	$('#userPopUpModal').modal('hide');
		    });
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
		$('#userPopUpLabel').text("담당자 조회");
		$('#userPopUpModal').modal('show');	
   	}
    
    
    
    
	//Tray 관련 코드 작성
	//---------------------------------------------------------------------------------------------------------//
	//---------------------------------------------------------------------------------------------------------//
	
	//메인 생산실적(Tray) 클릭 시
	$('#btnTray').on('click', function(){
		if (workOrdNo == null) {
			toastr.warning("생산실적을 조회할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderMatrlTable").find(".selected").length != 1) {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (mainMatrlLotNo == null || mainMatrlLotNo == '') {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		//goodsCd 첫글자가 A도아니면서 N도 아니면 true
		if (!(mainMatrlCd.substring(0,1) == 'A') && !(mainMatrlCd.substring(0,1) == 'N')) {
			toastr.warning("생산실적을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		
		var matrlSaveCheck = true;
		//해당작지에 투입 한 자재인지 확인(바코드 스캔만 하고 저장을 클릭하지 않았을 경우의 예외처리)
		matrlSaveCheck = checkWorkOrderMatrlSave(mainMatrlLotNo);
		if (matrlSaveCheck) {
			toastr.warning("해당 작업지시에 투입된 자재가 아닙니다!<br>저장버튼을 클릭해 주세요!");
			return false;
		}

		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
			
		} else {
			if( workStatusCd != "S" && workStatusCd != "C") {
			  	toastr.warning("진행중이거나 완료된 작업지시만 생산실적(Tray)을 입력 할 수 있습니다!");
				return false;
			}
		}
		$('#my-spinner').show();
		$('#trayWorkOrderNo').text(workOrdNo);
		$('#trayLotNo').text(mainMatrlLotNo);
		
		$('#trayLabelTable tbody').empty();
		$('#trayLabelLotNo').text('');

		trayButtonAdd();	//트레이 라벨 20개 생성 함수

		//디폴트 값 지정
		var date 		= new Date(new Date().setHours(0,0,0,0));	//오늘날짜 00:00:00
		var secondDiff 	= parseInt(Date.now()/1000) - (date/1000);	//현재시간 - 오늘날짜
		var today 		= new Date(new Date().setHours(0,0,0,0));
		today.setDate(today.getDate());
		today = getDateType(today);									//YYYY-MM-DD 형식으로 변환
		var yesterday = new Date(new Date().setHours(0,0,0,0));
		yesterday.setDate(yesterday.getDate() - 1);
		yesterday = getDateType(yesterday);							//YYYY-MM-DD 형식으로 변환
			 
		//현재시간이 19:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘, 야간으로 표시
		if (secondDiff >= 68400 && secondDiff <= 86400) {
			$('#trayDayNight').val("N");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#trayDayNight').val("N");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#trayDayNight').val("D");
		}

		//날짜 표시
		//현재시간이 07:00:00 ~ 23:59:59 이면 전표(생산)일자는 오늘 날짜로 표시
		if (secondDiff >= 25200 && secondDiff <= 86399) {
			$('#trayProductDate').attr('min', $('#ordDate').val());
			$('#trayProductDate').val(today);	//생산 날짜
		}

		//현재시간이 00:00:00 ~ 06:59:59 이면 전표(생산)일자는 전 날짜로 표시
		if (secondDiff >= 0 && secondDiff <= 25199) {
			let minusOneday = new Date(new Date().setHours(0,0,0,0));
				minusOneday.setDate(minusOneday.getDate()-1);
				minusOneday = getDateType(minusOneday);
				
			$('#trayProductDate').attr('min', $('#ordDate').val());
			$('#trayProductDate').val(minusOneday);	//생산 날짜
		}
		//날짜 표시 끝
		
		/* $('#trayWorkerIdCd').val($('#workUserCd').val());	
		$('#trayWorkerIdNm').val( $('#workUserNm').text().replace('작업자 ', '' ).substring(0, $('#workUserNm').text().replace('작업자 ', '' ).length-1) );
		*/
		$('#trayWorkerIdCd').val(trayUserNumber);	
		$('#trayWorkerIdNm').val(trayUserNm);
		
		//디폴트 값 지정 끝

		$('#my-spinner').hide();
		
		if ( document.getElementsByName('trayLabel').length == 0 ) {
			toastr.warning('현재 트레이가 생성되어 있지 않은 작지 입니다.!', '', {timeOut: 5000});
			return false;
		}


		if(workStatusCd == "C"){
			$('#trayLabelSave').attr('disabled', true);					//저장 버튼
			$('#btnTrayDelete').attr('disabled', false);				//삭제 버튼
			$('#btnTrayReset').attr('disabled', true);					//초기화 버튼
			
		} else {
			$('#trayLabelSave').attr('disabled', false);				//저장 버튼
			$('#btnTrayDelete').attr('disabled', false);				//삭제 버튼
			$('#btnTrayReset').attr('disabled', true);					//초기화 버튼
		}
		
		//모달 띄우는 부분
		$('#trayPopUpModal .modal-content').outerWidth( window.innerWidth - 50 );	//화면 비율에 맞게 모달 띄우기
		$('#trayPopUpModal').modal({backdrop: 'static'});
		$('#trayPopUpModal').modal('show');
		
	});

	let trayCheckView = false;
	
	//트리에 라벨 번호 클릭 시(테이블에 추가될 값 들)
	$(document).on('click','button[name=trayLabel]',function(e){
// 		console.log("트레이 라벨 번호 : " + $(this).html());

		let html1 = '';
		let html2 = '';
		
		let countTr = 0;
			countTr = $('#trayLabelTable tbody tr').length == 0 ? 0 : $('#trayLabelTable tbody tr').length -1;
		
		let countTd = 0;
			countTd = $('#trayLabelTable tbody tr').eq(countTr).find('td').length == 0 ? 0 : $('#trayLabelTable tbody tr').eq(countTr).find('td').length +1;

		//선택에 따른 CSS 변경
		if( $(this).hasClass('on') ) {
			
			//순서대로 선택할 수 있게
			if( $(this).val() != "1" ) {
				if( $('button[name=trayLabel]')[($(this).val()-2)].classList.contains('on') && !$('button[name=trayLabel]')[($(this).val()-2)].disabled ) {
					toastr.warning("이전 트레이번호를 먼저 선택해주세요. ");
					$(this).blur();
					return false;
				}
			}

			$(this).removeClass('on');
			$(this).addClass('off');
// 			$(this).attr('disabled', true);

			//행 추가하는 부분
			if( countTr == 0 || countTr == 1 ) {

				if(countTd == 0){
					//처음 시작하는 부분
					html1 += '<tr>';
					html1 += '<td name="'+$(this).text()+'">#1</td>';
					html1 += '</tr>';
					html1 += '<tr>';
					html1 += '<td class="imperfectTray" name="'+$(this).text()+'">'+$(this).html()+'</td>';
					html1 += '</tr>';
					$('#trayLabelTable tbody').append(html1);
				} else {
					if(countTd % 7 != 0){
						html2 += '<td name="'+$(this).text()+'">#'+countTd+'</td>';
						html1 += '<td class="imperfectTray" name="'+$(this).text()+'">'+$(this).html()+'</td>';
						$('#trayLabelTable tbody tr').eq(countTr-1).append(html2);
						$('#trayLabelTable tbody tr').eq(countTr).append(html1);
//	 					$('#trayNumber').attr('colspan', countTd);
					} else {
						html1 = '';
						html2 += '<tr>';
						html2 += '<td name="'+$(this).text()+'">#1</td>';
						html2 += '</tr>';
						$('#trayLabelTable tbody').append(html2);

						html1 += '<tr>';
						html1 += '<td class="imperfectTray" name="'+$(this).text()+'">'+$(this).html()+'</td>';
						html1 += '</tr>';
						$('#trayLabelTable tbody').append(html1);
					}
				}
			} else {
				if(countTd % 7 != 0){
					html2 += '<td name="'+$(this).text()+'">#'+countTd+'</td>';
					html1 += '<td class="imperfectTray" name="'+$(this).text()+'">'+$(this).html()+'</td>';
					$('#trayLabelTable tbody tr').eq(countTr-1).append(html2);
					$('#trayLabelTable tbody tr').eq(countTr).append(html1);
				} else {
					html1 = '';
					html2 += '<tr>';
					html2 += '<td name="'+$(this).text()+'">#1</td>';
					html2 += '</tr>';
					$('#trayLabelTable tbody').append(html2);

					html1 += '<tr>';
					html1 += '<td class="imperfectTray" name="'+$(this).text()+'">'+$(this).html()+'</td>';
					html1 += '</tr>';
					$('#trayLabelTable tbody').append(html1);
				}
			}
			//행 추가하는 부분 끝
			
		} else {

			if( $(this).val() != "20" ) {
				if( $('button[name=trayLabel]')[parseInt($(this).val())].classList.contains('off')  || $('button[name=trayLabel]')[parseInt($(this).val())].disabled ) {
					toastr.warning("이후 트레이번호를 먼저 취소 해주세요. ");
					$(this).blur();
					return false;
				}
			}
			
			$(this).addClass('on');
			$(this).removeClass('off');
			$('td[name="'+$(this).text()+'"]').remove();

			if( countTd == 2) {
				$('#trayLabelTable tbody tr').eq(countTr).remove();
				$('#trayLabelTable tbody tr').eq(countTr-1).remove();
			} else if( countTd == 6 ){
				$('#trayLabelTable tbody tr').eq(countTr+1).remove();
			}
		}


		if( $('button[name=trayLabel]').hasClass('off') ) {
			trayCheckView = true;
		} else {
			trayCheckView = false;
		}
		//console.log("trayCheckView : " + trayCheckView);	
		
		$(this).blur();
		
	});

	let usingTrayCheckCount = '1';

	//트레이모달 저장 버튼 클릭 시
	$('#trayLabelSave').on('click', function() {

		if ( $('#trayLabelTable tbody tr').length == 0 ) {
			toastr.warning('생산한 트레이를 선택해주세요!', '', {timeOut: 5000});
			$('#trayLabel0').focus();
			return false;
		}

		if ( $('button[name=trayLabel].off').length == 0 ) {
			toastr.warning('저장할 트레이를 선택해주세요!', '', {timeOut: 5000});
			return false;
		}

		if ($('#trayDayNight option:selected').val() == null || $('#trayDayNight option:selected').val() == '') {
			toastr.warning('트레이 주야 구분을 선택해주세요!', '', {timeOut: 5000});
			$('#trayDayNight').focus();
			return false;
		}

		if ($('#trayProductDate').val() == null || $('#trayProductDate').val() == '') {
			toastr.warning('생산 날짜를 선택해주세요!', '', {timeOut: 5000});
			$('#trayProductDate').focus();
			return false;
		}

		if ($('#trayWorkerIdCd').val() == null || $('#trayWorkerIdCd').val() == '') {
			toastr.warning('작업자를 선택해주세요!', '', {timeOut: 5000});
			$('#trayWorkerIdCd').focus();
			return false;
		}

		let dataArray = new Array();
		let rowData = new Object();

		let trayLabelTableTrCount = 0;
		
		//생산 실적(Tray) 테이블 값 담아주는 부분
		$('#trayLabelTable tbody tr').each(function() {

			trayLabelTableTrCount++;
			//값 담아주는 부분 시작
			if( trayLabelTableTrCount % 2 == 0 ) {
				for(var i=0; i<10; i++){
					if( $(this).find('td').eq(i).length ) {
						rowData = new Object();
						rowData.menuAuth				= menuAuth;
						rowData.trayNo					= $(this).find('td').eq(i).text();					//트레이 번호
						rowData.dayNightCd				= $('#trayDayNight option:selected').val();			//주야 구분
						rowData.productDate				= $('#trayProductDate').val().replace(/-/g, '');	//생산 날짜
						rowData.trayWorkerId			= $('#trayWorkerIdCd').val();						//작업자
						rowData.workOrdNo				= workOrdNo;										//작지 번호
//				 		rowData.lastWorkOrdNo			= lastWorkOrdNo;									//전 작지 번호
						rowData.equipCd					= equipCd;											//설비코드
//				 		rowData.trayNo					= trayNo;											//트레이번호
//				 		rowData.workOrdSeq				= workOrdSeq;										//작지순서
						rowData.matrlCd					= $("#alnicuMatrlCd"+workOrdIndex).val();			//자재코드
						rowData.matrlLotNo				= mainMatrlLotNo;									//자재로트
//				 		rowData.lastMatrlLotNo			= lastMatrlLotNo;									//전 자재로트
//				 		rowData.labelLotNo				= labelLotNo;										//라벨로트
				 		rowData.productStatus			= $(this).find('td input').eq(i).val() == null ? "001" : $(this).find('td input').eq(i).val();	//생산상태
						rowData.goodsCd					= $("#goodsCd"+workOrdIndex).val();					//제품코드
//				 		rowData.productQty				= productQty;										//생산수량
				 		rowData.incorporationGubun		= $(this).find('td').eq(i).text().indexOf("_M") > 0 ? "Y" : "N";	//혼입구분
				 		rowData.incorporationVisonGubun	= $(this).find('td').eq(i).text().indexOf("V") > 0 ? "Y" : "N";	//혼입구분
//				 		rowData.ordLotNo				= ordLotNo;											//생산전표번호
						dataArray.push(rowData);
					}
				}
			}
			// 값 담아주는 부분 종료
		});

		//console.table(dataArray);
		let data = JSON.stringify(dataArray);

		$('#my-spinner').show();
		$('#my-spinner').before('<div id="trayLodingLabel" style="top: 55vh;font-size: 25px;color: black;background: #ffffffc4;text-align: center;z-index: 10000;position: absolute;left: 50%;transform: translate(-50%, 0%);padding: 0px 50px 0px 50px;"><label>데이터 상태 검사와 함께 값을 저장하고 있습니다.</label><br><label>잠시만 기다려 주세요...( ﾉ ﾟｰﾟ)ﾉ</label></div>');
		
		//수정
		$.ajax({
			url : '<c:url value="po/productionPerfTrayUpdate"/>',
			type : 'POST',
			data : {
				'arrayData'		:	function(){ return data;		},
				'equipCd'		:	function(){ return equipCd;		},
				'workOrdNo'		:	function(){ return workOrdNo;	},
				'productDate'	:	function(){ return $('#trayProductDate').val().replace(/-/g, '');	}
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//정상 수정 처리
					var set = [...new Set(data)];
					if( set != "" ) {
						trayLabelPrint("002", set);
					}
					toastr.success('저장되었습니다.');
					$('#my-spinner').hide();
				} else if (res.result == 'fail') {
					// 실패
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				} else if (res.result == 'lock') {
					//시스템 잠금
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				} else if (res.result == 'using') {
					// 현재 다른사용자가 사용 중인 경우
					$('#my-spinner').show();
					usingTrayCheckCount = '1';
					toastr.warning('현재 트레이 생산 시스템이 사용중입니다.<br>잠시만 기다려주세요! (' + usingTrayCheckCount + '/3)', '', {timeOut: 5000});
					//현재 싱글 톤 확인 하는 부분
					nowSingleTonCheck();
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
            },
            complete : function() {
            	trayCheckView = false;
            	$('#trayLabelTable tbody').empty();
            	trayButtonAdd();
            	$('#btnTrayReset').attr('disabled', true);
            	document.getElementById('trayLodingLabel').remove();
        		//$('#my-spinner').hide();
			}
		});
	});

	//트레이 테이블 Row(Tr) 클릭 시
	$(document).on('click','tr[name=trayTableRow]',function(e) {

		//$(this).attr('style','border: 5px solid #0275d8;pointer-events : none;');		
	
		if($(this).hasClass('clickedTrayLine')){
			
			//console.log('왜안되노');
			$(this).removeClass('clickedTrayLine');
			
		} else{
			var rows = document.getElementById("trayLabelTable").getElementsByTagName("tr");
			for( var r=0; r<rows.length; r++ ){
				$('#trayLabelTable tbody tr').eq(r).removeClass('clickedTrayLine');
			}
			
			$(this).addClass('clickedTrayLine');
		}
		
/* 		setTimeout(function(){
			$(this).attr('style','');
		},150); */
		
        $('#trayLabelLotNo').text('');
        var boxNo = $(this).attr('id') == "null" ? "포장 상태가 아닙니다." : $(this).attr('id');
		$('#trayLabelLotNo').text( boxNo );
	});

	//혼입 구분 버튼 클릭 시
	$('#btnVisorIncorporationGubun, #btnIncorporationGubun').on('click', function(){
		//console.log( $(this).val() );
		let mixGubun = $(this).val();	//혼입 버튼 구분
		
		if ( $('#trayLabelTable tbody tr').length == 0 ) {
			toastr.warning('생산한 트레이를 선택해주세요!', '', {timeOut: 5000});
			$('#trayLabel0').focus();
			return false;
		}

		if(trayCheckView) {
			toastr.warning('생산실적트레이가 저장 되지 않았습니다.<br>저장 후 다시 시도해주세요!', '', {timeOut: 5000});
			$('#trayLabelSave').focus();
			return false;
		}

		$('#incorporationGubunTable tbody').empty();

		//기존 테이블을 copy&paste
		$('#incorporationGubunTable').append($('#trayLabelTable tbody').html());

		//이름 정리
		$('#incorporationGubunTable tbody').find('td.perfectTray, td.imperfectTray').attr('name', 'incorporationTd');
		$('#incorporationGubunTable tbody tr').attr('id', '');
		$('#incorporationGubunTable tbody tr').attr('name', '');

		//이름 변경 후 클래스 제거
		$('td[name=incorporationTd]').removeClass('perfectTray');
		$('td[name=incorporationTd]').removeClass('imperfectTray');

		//클래스 제거 후 신규 클래스 추가
		$('td[name=incorporationTd]').addClass('notMixTd');

		//Tr Class 제거
		$('#incorporationGubunTable tbody tr').removeClass();

		let html1 = '';
		
		if(mixGubun == "M") {
			//메탈 혼입인 애들 표시
			for(var i=0; i<$('td[name=incorporationTd]').length; i++){
			    //if( $('td[name=incorporationTd]')[i].style.color == 'red' ) {
		    	if( $('td[name=incorporationTd]')[i].textContent.includes("_M") ) {
			        $('td[name=incorporationTd]')[i].classList.remove("notMixTd");
			        $('td[name=incorporationTd]')[i].classList.add("mixMetalTd");
			        
			        if( !$('td[name=incorporationTd]')[i].textContent.includes("V") ){
			        	$('td[name=incorporationTd]')[i].style.color = null;
					}
			    }
			}
			$('#trayIncorporationGubunPopUpLabel').text('생산실적(Tray)_혼입구분');
			$('#mixColor')[0].style.backgroundColor = '#ff8d8d';
			$('#minGubunValue').val('M');
			/* html1 += '<label>*기존에 혼입이 저장되어있는 경우 붉은 색으로 표시 됩니다.</label><br>';
			html1 += '<label>*기존에 비전혼입이 저장되어있는 경우 글자가 푸른색으로 표시 됩니다.</label><br> ';
			html1 += '<label>*메탈혼입이 저장되어 있는 경우 "트레이 번호+_M"로 보입니다.</label><br> ';
			html1 += '<label>*비전혼입이 저장되어 있는 경우 "트레이 번호+_V"로 보입니다.</label><br> '; */
			
		} else if(mixGubun == "V") {
			//비전 혼입인 애들 표시
			for(var i=0; i<$('td[name=incorporationTd]').length; i++){
			    if( $('td[name=incorporationTd]')[i].textContent.includes("V") ) {
			        $('td[name=incorporationTd]')[i].classList.remove("notMixTd");
			        $('td[name=incorporationTd]')[i].classList.add("mixVisorTd");
			        
			        if( !$('td[name=incorporationTd]')[i].textContent.includes("M") ){
			        	$('td[name=incorporationTd]')[i].style.color = null;
					}
			    }
			}
			$('#trayIncorporationGubunPopUpLabel').text('생산실적(Tray)_비전혼입구분');
			$('#mixColor')[0].style.backgroundColor = '#85b0ff'
			$('#minGubunValue').val('V');
			/* html1 += '<label>*기존에 비전혼입이 저장되어있는 경우 푸른 색으로 표시 됩니다.</label><br> ';
			html1 += '<label>*기존에 메탈혼입이 저장되어있는 경우 글자가 붉은 색으로 표시 됩니다.</label><br> ';
			html1 += '<label>*메탈혼입이 저장되어 있는 경우 "트레이 번호+_M"로 보입니다.</label><br> ';
			html1 += '<label>*비전혼입이 저장되는 경우 "트레이 번호+_V"로 변경 됩니다.</label><br> '; */
		} else {
			toastr.error('시스템 오류가 발생했습니다.!', '', {timeOut: 5000});	
		}

		html1 += '<label>*메탈 혼입은 "붉은 색"으로 비전 혼입은 "푸른 색"으로 글자 또는 색상으로 표시됩니다.</label><br> ';
		html1 += '<label>*메탈&비전혼입인 경우 글자가 "연두색"으로 표시 됩니다. </label><br> ';
		html1 += '<label>*메탈혼입이 저장되는 경우 "트레이 번호+_M"로 변경 됩니다.</label><br> ';
		html1 += '<label>*비전혼입이 저장되는 경우 "트레이 번호+_V"로 변경 됩니다.</label><br> ';
		html1 += '<label>*메탈&비전혼입이 저장되는 경우 "트레이 번호+_MV"로 변경 됩니다.</label><br> ';

		$('#trayIncorporationGubunGuideMessage').empty();
		$('#trayIncorporationGubunGuideMessage').append(html1);

		$('#trayIncorporationGubunPopUpModal .modal-content').outerWidth( window.innerWidth - 140 );	//화면 비율에 맞게 모달 띄우기
		$('#trayIncorporationGubunPopUpModal').modal('show');
	});

	//혼입 테이블 Td 클릭 시
	$(document).on('click','td[name=incorporationTd]',function(e){
		if( $('#minGubunValue').val() == "M" ){
			if( $(this).hasClass('mixMetalTd') ) {
				$(this).removeClass('mixMetalTd');
				$(this).addClass('notMixTd');
			} else {
				$(this).removeClass('notMixTd');
				$(this).addClass('mixMetalTd');
			}
		} else if( $('#minGubunValue').val() == "V" ){
			if( $(this).hasClass('mixVisorTd') ) {
				$(this).removeClass('mixVisorTd');
				$(this).addClass('notMixTd');
			} else {
				$(this).removeClass('notMixTd');
				$(this).addClass('mixVisorTd');
			}
		} else {
			toastr.error('시스템 오류가 발생했습니다.!', '', {timeOut: 5000});	
		}
	});

	//혼입 모달 저장 버튼 클릭 시
	$('#trayIncorporationSave').on('click', function(){

		$('#my-spinner').show();
		
		let dataArray = new Array();
		let obj = new Object();

		//혼입인 메탈 애기들
		if( $('#minGubunValue').val() == "M" ){
			for(var i=0; i<$('td.mixMetalTd').length; i++){
				obj = new Object();
				obj.trayNo					= $('td.mixMetalTd')[i].textContent;	//트레이 번호
				obj.incorporationGubun		= "Y";									//혼입 여부
				obj.incorporationVisonGubun	= "";									//혼입 비전 여부
				obj.mixGubun				= "M";									//구분자
				obj.productStatus			= $('td.mixMetalTd').find('input')[i].value;
				
				//obj.afterIncorporationGubun			= $('td.mixMetalTd')[i].style.color == "red" ? "Y" : "N";
				obj.afterIncorporationGubun			= $('td.mixMetalTd').eq(i).text().indexOf("_M") > 0 ? "Y" : "N";
				obj.afterIncorporationVisonGubun 	= $('td.mixMetalTd').eq(i).text().indexOf("V") > 0 ? "Y" : "N";
				dataArray.push(obj);
			}
			//혼입이 아닌 못난 애기들
			for(var i=0; i<$('td.notMixTd').length; i++){
				obj = new Object();
				obj.trayNo					= $('td.notMixTd')[i].textContent;	//트레이 번호
				obj.incorporationGubun		= "N";								//혼입 여부
				obj.incorporationVisonGubun	= "";								//혼입 여부
				obj.mixGubun				= "M";								//구분자
				obj.productStatus			= $('td.notMixTd').find('input')[i].value;

				//obj.afterIncorporationGubun			= $('td.notMixTd')[i].style.color == "red" ? "Y" : "N";
				obj.afterIncorporationGubun			= $('td.notMixTd').eq(i).text().indexOf("_M") > 0 ? "Y" : "N";
				obj.afterIncorporationVisonGubun 	= $('td.notMixTd').eq(i).text().indexOf("V") > 0 ? "Y" : "N";
				dataArray.push(obj);
			}
		}

		//혼입인 비전 애기들
		if( $('#minGubunValue').val() == "V" ){
			for(var i=0; i<$('td.mixVisorTd').length; i++){
				obj = new Object();
				obj.trayNo					= $('td.mixVisorTd')[i].textContent;	//트레이 번호
				obj.incorporationGubun		= "";									//혼입 여부
				obj.incorporationVisonGubun	= "Y";									//혼입 비전 여부
				obj.mixGubun				= "V";									//구분자
				obj.productStatus			= $('td.mixVisorTd').find('input')[i].value;

				//obj.afterIncorporationGubun			= $('td.mixVisorTd')[i].style.color == "red" ? "Y" : "N";
				obj.afterIncorporationGubun			= $('td.mixVisorTd').eq(i).text().indexOf("_M") > 0 ? "Y" : "N";
				obj.afterIncorporationVisonGubun 	= $('td.mixVisorTd').eq(i).text().indexOf("V") > 0 ? "Y" : "N";
				dataArray.push(obj);
			}
			//혼입이 아닌 못난 애기들
			for(var i=0; i<$('td.notMixTd').length; i++){
				obj = new Object();
				obj.trayNo					= $('td.notMixTd')[i].textContent;	//트레이 번호
				obj.incorporationGubun		= "";								//혼입 여부
				obj.incorporationVisonGubun	= "N";								//혼입 여부
				obj.mixGubun				= "V";								//구분자
				obj.productStatus			= $('td.notMixTd').find('input')[i].value;

				//obj.afterIncorporationGubun			= $('td.notMixTd')[i].style.color == "red" ? "Y" : "N";
				obj.afterIncorporationGubun			= $('td.notMixTd').eq(i).text().indexOf("_M") > 0 ? "Y" : "N";
				obj.afterIncorporationVisonGubun 	= $('td.notMixTd').eq(i).text().indexOf("V") > 0 ? "Y" : "N";
				dataArray.push(obj);
			}
		}

 		//console.table(dataArray);
		let data = JSON.stringify(dataArray);

		//생산실적트레이 혼입 여부 수정
		$.ajax({
			url : '<c:url value="po/trayMixUpdate"/>',
			type : 'POST',
			data : {
				'equipCd'	: function(){ return equipCd;	},
				'workOrdNo'	: function(){ return workOrdNo;	},
				'arrayData' : function(){ return data;		},
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success('혼입구분이 변경되었습니다.', '', {timeOut: 5000});
					$('#my-spinner').hide();
				}  else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				} else if (res.result == 'lock') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				} else if (res.result == 'using') {
					// 현재 다른사용자가 사용 중인 경우
					$('#my-spinner').show();
					usingTrayCheckCount = '1';
					toastr.warning('현재 트레이 생산 시스템이 사용중입니다.<br>잠시만 기다려주세요! (' + usingTrayCheckCount + '/3)', '', {timeOut: 5000});
					//현재 싱글 톤 확인 하는 부분
					nowSingleTonCheck();
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
            },
            complete : function() {
            	trayCheckView = false;
            	trayButtonAdd();
        		//$('#my-spinner').hide();
        		$('#trayIncorporationGubunPopUpModal').modal('hide');
			}
		});
		//생산실적트레이 혼입 여부 수정 끝
	});


	//트레이 모달 닫힐 때 실행
	$('#trayPopUpModal').on('hidden.bs.modal', function (e) {
		trayCheckView = false;
		trayUiProc(false);
		$('#trayLabelSave').removeClass('d-none');
		$('#btnTrayLabelDelete').addClass('d-none');
	});

	//생산실적(Tray) 삭제 버튼 클릭 시
	$('#btnTrayDelete').on('click', function(){
		let checkDelete = false;
		/* var checkCode = 0;
		
		for(var i=0; i<20; i++) {
			if(!$('button[name=trayLabel]')[i].disabled){
				checkCode++;
			}
		}

		if( checkCode == 0 ){
			toastr.warning('삭제할 생산 트레이가 존재하지 않습니다.!', '', {timeOut: 5000});
			return false;
		} */

		//삭제 전 마지막 작지인지 확인_ajax
		$.ajax({
			url : '<c:url value="po/productionPerfTrayListCheckDelete"/>',
			type : 'GET',
			async: false,
			data : {
				'equipCd'	:	function(){ return equipCd;		},
				'workOrdNo'	:	function(){ return workOrdNo;	}
			},
			success: function (res) {
				let data = res.data;

				if (res.result == 'ok') {
					checkDelete = false;
				} else if (res.result == 'fail') {
					checkDelete = true;
					toastr.warning(res.message);
				}  else {
					checkDelete = true;
					toastr.error(res.message);
				}
            },
            complete : function() {}
		});
		//삭제 전 마지막 작지인지 확인_ajax
		
		if(checkDelete){			
			return false;
		}
		
		$('#trayLabelSave').addClass('d-none');
		$('#btnTrayLabelDelete').removeClass('d-none');

		$('#my-spinner').show();
		$.ajax({
			url : '<c:url value="po/productionPerfTrayList"/>',
			type : 'GET',
			async: false,
			data : {
				'equipCd'	:	function(){ return equipCd; },
				'workOrdNo'	:	function(){ return workOrdNo; }
			},
			success: function (res) {
				let data = res.data;

				if (res.result == 'ok') {

					$('#trayButtonRange').empty();
					
					let html3 = '';
					for(var i=0; i<20; i++){
						if(i == 0) {
							html3 += '<div style="display: flex;flex-wrap: nowrap;justify-content: center;">';
						}
						if(i == 10) {
							html3 += '</div> <div class="mt-2" style="display: flex;flex-wrap: nowrap;justify-content: center;">';
						}
						if( data[i].productStatus == "001") {
							html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="deleteTrayLabel" value="'+data[i].turnNumber+'" disabled >'+data[i].trayNo+'</button>';
						} else {
// 							if(workStatusCd == "C"){
// 								html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="deleteTrayLabel" value="'+data[i].turnNumber+'" disabled>'+data[i].trayNo+'</button>';
// 							} else {
								html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="deleteTrayLabel" value="'+data[i].turnNumber+'">'+data[i].trayNo+'</button>';
// 							}
						}
						if(i == 19) {
							html3 += '</div>';
						}
					}
					$('#trayButtonRange').append(html3);

					$('#trayLabelTable tbody').empty();
					createTableTd();
					trayUiProc(true);
					toastr.success('삭제할 항목을 선택 해주세요.');
					
				} else {
					toastr.error(res.message);
				}
            },
            complete : function() {}
		});
		$('#my-spinner').hide();
	});

	//삭제하는 트레이 버튼 클릭 시
	$(document).on('click','button[name=deleteTrayLabel]',function(e) {
		if( $(this).hasClass('on') ) {
			//순서대로 선택할 수 있게
			if( $(this).val() != "20" ) {
				if( $('button[name=deleteTrayLabel]')[($(this).val())].classList.contains('on') && !$('button[name=deleteTrayLabel]')[($(this).val())].disabled ) {
					toastr.warning("이후 트레이번호를 먼저 선택 해주세요. ");
					$(this).blur();
					return false;
				}
			}
			$(this).removeClass('on');
			$(this).addClass('trayBtnSlDelete');
		} else {
			//순서대로 선택할 수 있게
			if( $(this).val() != "1" ) {
				if( $('button[name=deleteTrayLabel]')[(parseInt($(this).val()-2))].classList.contains('trayBtnSlDelete') && !$('button[name=deleteTrayLabel]')[(parseInt($(this).val()-2))].disabled ) {//여기 수정해주기
					toastr.warning("이전 트레이번호를 먼저 취소해주세요. ");					
					$(this).blur();
					return false;
				}
			}
			$(this).addClass('on');
			$(this).removeClass('trayBtnSlDelete');
		}
		if( $('button[name=deleteTrayLabel]').hasClass('trayBtnSlDelete') ) {
			trayCheckView = true;
		} else {
			trayCheckView = false;
		}
		$(this).blur();
	});

	// 초기화 버튼 클릭 시
	$('#btnTrayReset').on('click', function(){
		$('#my-spinner').show();
		$('#trayLabelSave').removeClass('d-none');
		$('#btnTrayLabelDelete').addClass('d-none');
		$('#trayLabelTable tbody').empty();
		trayCheckView = false;
		trayButtonAdd();

		trayUiProc(false);
		$('#my-spinner').hide();
	});

	//트레이 삭제 저장 버튼 클릭 시
	$('#btnTrayLabelDelete').on('click', function(){
		if( $('button[name=deleteTrayLabel].trayBtnSlDelete').length == 0 ) {
			toastr.warning("삭제할 데이터가 없습니다 <br>삭제할 값을 선택해주세요.");		
			$(this).blur();
			return false;
		}
		$('#trayDeleteCheckPopupModal').modal('show');
	});

	//트레이 모달 삭제 버튼 클릭 시
	$('#btnTrayDeleteCheck').on('click', function(){
		
		if( $('button[name=deleteTrayLabel].trayBtnSlDelete').length == 0 ) {
			toastr.warning("삭제할 데이터가 없습니다 <br>삭제할 값을 선택해주세요.");		
			$(this).blur();
			return false;
		}
		
		let dataArray	= new Array();
		let rowData		= new Object();
		let trayNo 		= "";

		$('#my-spinner').show();
		
		//생산 실적(Tray) 테이블 값 담아주는 부분
		for(var i=parseInt($('button[name=deleteTrayLabel].trayBtnSlDelete').length)-1; i>=0; i--){
			obj = new Object();
			obj.trayNo						= $('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent;	//트레이 번호
			//obj.incorporationGubun		= "N";									//혼입 여부
			//obj.incorporationVisonGubun	= "N";									//혼입 비전 여부
			obj.trayWorkId					= "";
			obj.productStatus				= $('td[name='+$('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent+']').find('input').val();

			//obj.incorporationGubun			= $('td[name='+$('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent+']')[1].style.color == "red" ? "Y" : "N";		//혼입구분
			obj.incorporationGubun			= $('td[name='+$('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent+']').eq(1).text().indexOf("_M") > 0 ? "Y" : "N";	//혼입구분
			obj.incorporationVisonGubun		= $('td[name='+$('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent+']').eq(1).text().indexOf("V") > 0 ? "Y" : "N";		//혼입구분
	 		
			dataArray.push(obj);

			//트레이 정보 담아주기
			trayNo += "\'" + $('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent + "\',";
// 			trayNo += "\'[" + $('button[name=deleteTrayLabel].trayBtnSlDelete')[i].textContent + "\]',";
            if( i==0 ) {
            	trayNo = trayNo.substring(0, (trayNo.length -1) );
            }
		}

		let data = JSON.stringify(dataArray);

		//수정
		$.ajax({
			url : '<c:url value="po/productionPerfTrayDeleteupdate"/>',
			type : 'POST',
			data : {
				'trayNo'		:	function(){ return trayNo;			},
				'arrayData'		:	function(){ return data;			},
				'equipCd'		:	function(){ return equipCd;			},
				'workOrdNo'		:	function(){ return workOrdNo;		},
				'workStatusCd'	:	function(){ return workStatusCd;	},
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					//버튼 및 테이블 리로드
					//$('#trayLabelTable tbody').empty();
	            	//trayButtonAdd();
	        		
					toastr.success('삭제되었습니다.');
					$('#my-spinner').hide();
				} else if (res.result == 'fail') {
					toastr.warning(res.message);
					$('#my-spinner').hide();
				} else if (res.result == 'lock') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#my-spinner').hide();
				} else if (res.result == 'using') {
					// 현재 다른사용자가 사용 중인 경우
					$('#my-spinner').show();
					usingTrayCheckCount = '1';
					toastr.warning('현재 트레이 생산 시스템이 사용중입니다.<br>잠시만 기다려주세요! (' + usingTrayCheckCount + '/3)', '', {timeOut: 5000});
					//현재 싱글 톤 확인 하는 부분
					nowSingleTonCheck();
				} else {
					toastr.error(res.message);
					$('#my-spinner').hide();
				}
            },
            complete : function() {
            	//$('#my-spinner').hide();
            	trayCheckView = false;
            	//버튼 및 테이블 리로드
				$('#trayLabelTable tbody').empty();
            	trayButtonAdd();
            	$('#trayLabelSave').removeClass('d-none');
				$('#btnTrayLabelDelete').addClass('d-none');
            	trayUiProc(false);
			}
		});
		
	});


	//전체 재출력 버튼 클릭 시
	$('#btnTrayAllRePrint').on('click',function(){
		trayLabelPrint("001", "");
	});

	//개별 재출력 버튼 클릭 시
	$('#btnTrayPartRePrint').on('click', function(){
		if( $('#trayLabelLotNo').text() == "" ) {
			toastr.warning("프린터하고자 하는 행을 클릭 해주세요.");
			return false;
		}
		if( $('#trayLabelLotNo').text() == "포장 상태가 아닙니다." ) {
			toastr.warning("포장 상태가 아닙니다.");
			return false;
		}
		trayLabelPrint("002", [$('#trayLabelLotNo').text()] );
	});

	function trayLabelPrint(type, data){
		var array	= new Array();
	    var obj		= new Object();
	    var count	= 0;

	    if( type == "001" ) {
			$('#trayLabelTable tbody tr').each(function(){
				if( $(this)[0].id != null && $(this)[0].id != "" && $(this)[0].id != "null" ){
			   		obj = new Object();
			    	obj.labelLotNo = $(this)[0].id;
				    array.push(obj);
			    }
			});
	    } else if( type == "002" ) {
		    for(var i=0; i<data.length; i++) {
	    		obj = new Object();
	    		obj.labelLotNo = data[i];
		   		array.push(obj);
	    	}
		}

		let trayData = JSON.stringify(array);
		
		$.ajax({
			url : '<c:url value="po/productionPerfTrayPrintList_F2"/>',
			type : 'GET',
			async: false,
			data : {
	    		'arrayData' : function(){ return trayData; }
			},
			success: function (res) {
				let printData = res.data;

				if (res.result == 'ok') {
// 					console.log(printData);
					
					count = printData.length;
					labelPrint(printData, count);		//프린터 출력 함수
// 					toastr.success('조회되었습니다.');
				} else {
					toastr.error(res.message);
				}
            },
            complete : function() {}
		});
	}
	



	
	//트레이 관련 함수 시작 하는 부분
	
	
	//Do printing...
	function labelPrint(printList, count) {
		printLalCnt = count;		//몇 장 출력 하는지
		printCnt	= printLalCnt;
		
		// 0 제품이름 - 1 생산전표번호 - 2 생산전표수량
		sendJson(printList);
	}
	function sendJson(printList) {
		var obj = {
			printCnt 	: printCnt,
            printLalCnt : printLalCnt,
            data 		: printList,
            paperSize 	: "productionTray",
            printOrder 	: 1,
            company 	: "MTP2",
            printType 	: "C",
            printNo 	: "1",
            reseverd6 	: "",
            reseverd7 	: ""
		};
		var send = JSON.stringify(obj);
		//console.log(send);
		sendMessage(send)
	}
	
	//트레이 관련 UI 처리
	function trayUiProc(flag) {
		if(workStatusCd == "C") {
// 			$('#btnVisorIncorporationGubun').attr('disabled', flag);	//(비전)혼입 버튼
// 			$('#btnIncorporationGubun').attr('disabled', flag);			//(메탈)혼입 버튼
			$('#btnTrayDelete').attr('disabled', false);				//삭제 버튼
			$('#btnTrayReset').attr('disabled', true);					//초기화 버튼
			$('#trayLabelSave').attr('disabled', true);					//초기화 버튼
		} else {
// 			$('#btnVisorIncorporationGubun').attr('disabled', flag);	//(비전)혼입 버튼
// 			$('#btnIncorporationGubun').attr('disabled', flag);			//(메탈)혼입 버튼
			$('#btnTrayDelete').attr('disabled', flag);					//삭제 버튼
			$('#btnTrayReset').attr('disabled', flag);					//초기화 버튼
		}
	}

	//트레이 라벨 20개 생성 함수
	function trayButtonAdd(){
// 		$('#my-spinner').show();

		var checkCount = 0;
		$('#trayLabelTable tbody').empty();
		$.ajax({
			url : '<c:url value="po/productionPerfTrayList"/>',
			type : 'GET',
			async: false,
			data : {
				'equipCd'	:	function(){ return equipCd; },
				'workOrdNo'	:	function(){ return workOrdNo; }
			},
			success: function (res) {
				let data = res.data;
// 				console.log(data);
// 				console.log(data[0]);

				if (res.result == 'ok') {

					$('#trayButtonRange').empty();

					if( data != "" && data != null ){
						let html3 = '';
						for(var i=0; i<20; i++){
							if(i == 0) {
								html3 += '<div style="display: flex;flex-wrap: nowrap;justify-content: center;">';
							}
							if(i == 10) {
								html3 += '</div> <div class="mt-2" style="display: flex;flex-wrap: nowrap;justify-content: center;">';
							}
							if( data[i].productStatus != "001" ) {
								html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="trayLabel" value="'+data[i].turnNumber+'" disabled >'+data[i].trayNo+'</button>';
							} else {
								if(workStatusCd == "C"){
									html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="trayLabel" value="'+data[i].turnNumber+'" disabled>'+data[i].trayNo+'</button>';
								} else {
									html3 += '<button type="button" class="btn btn-secondary mr-1 on" id="trayLabel'+i+'" name="trayLabel" value="'+data[i].turnNumber+'">'+data[i].trayNo+'</button>';
								}
							}
							if(i == 19) {
								html3 += '</div>';
							}
							if( data[i].productStatus == "001" || data[i].productStatus == "002" ) {
								checkCount++;
							}
						}
						$('#trayButtonRange').append(html3);
					}
					

					if( checkCount == 0 ) {
						$('#btnTrayDelete').attr('disabled', true);
						$('#trayLabelSave').attr('disabled', true);
						$('#btnTrayReset').attr('disabled', true);
					} else {
						$('#btnTrayDelete').attr('disabled', false);
						$('#trayLabelSave').attr('disabled', false);
						$('#btnTrayReset').attr('disabled', false);
					}
					createTableTd();
// 					toastr.success('조회되었습니다.');
					
				} else {
					toastr.error(res.message);
				}
				
            },
            complete : function() {}
		});
// 		$('#my-spinner').hide();
	}

	//트레이테이블 저장되어있는 이전 값 + 현재 선택한 값 추가 하는 부분
	function createTableTd() {

// 		$('#my-spinner').show();
		$.ajax({
			url : '<c:url value="po/trayInfoBeforeAfterList"/>',
			type : 'GET',
			async: false,
			data : {
				'equipCd'	: function(){ return equipCd;	},
				'workOrdNo'	: function(){ return workOrdNo;	}
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {

					for(var i=0; i<data.length; i++){
						let html1 = '';
						let html2 = '';
						
						let countTr = 0;
							countTr = $('#trayLabelTable tbody tr').length == 0 ? 0 : $('#trayLabelTable tbody tr').length -1;
						
						let countTd = 0;
							countTd = $('#trayLabelTable tbody tr').eq(countTr).find('td').length == 0 ? 0 : $('#trayLabelTable tbody tr').eq(countTr).find('td').length +1;

							let colorStyle = data[i].incorporationGubun == "Y" && data[i].incorporationVisonGubun == "Y" ? "style='color: lightgreen;;'" :	data[i].incorporationGubun == "Y" ? "style='color: red;'" : data[i].incorporationVisonGubun == "Y" ? "style='color: blue;'" : "style=''";
						//let colorStyle = data[i].incorporationGubun == "Y" ? "style='color: red;'" : "style=''";

						//행 추가하는 부분
						if( countTr == 0 || countTr == 1 ) {

							if(countTd == 0){
								//처음 시작하는 부분
								html1 += '<tr>';
								html1 += '<td name="'+data[i].trayNo+'">#1</td>';
								html1 += '</tr>';
								html1 += '<tr id="'+data[i].labelLotNo+'" name="trayTableRow">';
								if( data[i].productStatus == "003" ) {
									//html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								} else {
									//html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								}
								html1 += '</tr>';
								$('#trayLabelTable tbody').append(html1);
							} else {
								if(countTd % 7 != 0){
									html2 += '<td name="'+data[i].trayNo+'">#'+countTd+'</td>';
									if( data[i].productStatus == "003" ) {
										//html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
										html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
									} else {
										//html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
										html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
									}
									$('#trayLabelTable tbody tr').eq(countTr-1).append(html2);
									$('#trayLabelTable tbody tr').eq(countTr).append(html1);
								} else {
									html1 = '';
									html2 += '<tr>';
									html2 += '<td name="'+data[i].trayNo+'">#1</td>';
									html2 += '</tr>';
									$('#trayLabelTable tbody').append(html2);

// 									html1 += '<tr>';
									html1 += '<tr id="'+data[i].labelLotNo+'" name="trayTableRow">';
									if( data[i].productStatus == "003" ) {
										//html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
										html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
									} else {
										//html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
										html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
									}
									html1 += '</tr>';
									$('#trayLabelTable tbody').append(html1);
								}
							}
						} else {
							if(countTd % 7 != 0){
								html2 += '<td name="'+data[i].trayNo+'">#'+countTd+'</td>';
								if( data[i].productStatus == "003" ) {
									//html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								} else {
									//html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								}
								$('#trayLabelTable tbody tr').eq(countTr-1).append(html2);
								$('#trayLabelTable tbody tr').eq(countTr).append(html1);
							} else {
								html1 = '';
// 								html2 += '<tr>';
								html2 += '<tr>';
								html2 += '<td name="'+data[i].trayNo+'">#1</td>';
								html2 += '</tr>';
								$('#trayLabelTable tbody').append(html2);

// 								html1 += '<tr>';
								html1 += '<tr id="'+data[i].labelLotNo+'" name="trayTableRow">';
								if( data[i].productStatus == "003" ) {
									//html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="perfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								} else {
									//html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'</td>';
									html1 += '<td class="imperfectTray" '+colorStyle+' name="'+data[i].trayNo+'">'+data[i].trayNo+'<input type="hidden" value="'+data[i].productStatus+'"></td>';
								}
								html1 += '</tr>';
								$('#trayLabelTable tbody').append(html1);
							}
						}
						//행 추가하는 부분 끝
					}
					
				} else {
					toastr.error(res.message);
				}
            },
            complete : function() {}
		});

// 		$('#my-spinner').hide();
	}
	
	//생산실적트레이 발행(등록)
	function trayLabelCreateFun() {

		let dataArray	= new Array();
		let rowData		= new Object();

		//필름 값 담아주는 부분 시작
		let filmLotNo = "";
	    for(var i=0; i<workOrderMatrlTable.data().length; i++){
	        if( workOrderMatrlTable.data()[i].baseCdAbbr == "F" ) {
                if( filmLotNo == "" ) {
                    filmLotNo = workOrderMatrlTable.data()[i].lotNo;
                } else {
                	if( filmLotNo.indexOf( workOrderMatrlTable.data()[i].lotNo ) < 0 ) {
                    	filmLotNo = filmLotNo + "/" + workOrderMatrlTable.data()[i].lotNo;
                	}
                }
	        }
	    }
		//필름 값 담아주는 부분 시작

		//값 담아주는 부분 시작
		rowData = new Object();
		rowData.menuAuth				= menuAuth;
		rowData.trayNumber				= $(this).find('td').eq(0).text();					//트레이 번호
		rowData.dayNightCd				= $('#trayDayNight option:selected').val();			//주야 구분
		rowData.productDate				= $('#trayProductDate').val().replace(/-/g, '');	//생산 날짜
		rowData.trayWorkerIdCd			= $('#trayWorkerIdCd').val();						//작업자
		rowData.workOrdNo				= workOrdNo;						//작지 번호
// 		rowData.lastWorkOrdNo			= lastWorkOrdNo;					//전 작지 번호는 어떻게 가지고 오지?........^^
		rowData.equipCd					= equipCd;							//설비코드
// 		rowData.trayNo					= trayNo;							//트레이번호
// 		rowData.workOrdSeq				= workOrdSeq;						//작지순서
		rowData.matrlCd					= $("#alnicuMatrlCd"+workOrdIndex).val();				//자재코드
		rowData.matrlLotNo				= mainMatrlLotNo;					//자재로트
// 		rowData.lastMatrlLotNo			= lastMatrlLotNo;					//전 자재로트는 어떻게 가지고 오지?........^^
// 		rowData.labelLotNo				= labelLotNo;						//라벨로트
// 		rowData.productStatus			= productStatus;					//생산상태
		rowData.goodsCd					= $("#goodsCd"+workOrdIndex).val();	//제품코드
// 		rowData.productQty				= productQty;						//생산수량
// 		rowData.incorporationGubun		= incorporationGubun;				//혼입구분
// 		rowData.ordLotNo				= ordLotNo;							//생산전표번호
		rowData.filmLotNo				= filmLotNo;
		dataArray.push(rowData);

		let data = JSON.stringify(dataArray);
		return data;

		/* $('#my-spinner').before('<div id="trayLodingLabel" style="width: 55vh;height: 8vh;position: fixed;left: 75vh;top: 55vh;font-size: 25px;color: black;background: white;text-align: center;"><label>현재 생산 실적 트레이를 생성하고 있습니다.</label><br><label>잠시만 기다려 주세요...( ﾉ ﾟｰﾟ)ﾉ</div>');
		$('#my-spinner').show();
		
		//등록
		$.ajax({
			url : '<c:url value="po/productionPerfTrayCreate"/>',
			type : 'POST',
			data : {
				'arrayData'	:	function(){ return data;		},
				'equipCd'	:	function(){ return equipCd;		},
				'workOrdNo'	:	function(){ return workOrdNo;	}
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success('생산실적트레이번호가 발행되었습니다.');
				} else {
					toastr.error(res.message);
				}
            },
            complete : function() {
        		document.getElementById('trayLodingLabel').remove();
        		$('#my-spinner').hide();
			}
		}); */
	}


	//싱글톤체크한 값에 따라 안내 메세지 및 화면 단 처리 부분
	function singleTonStateMessage(usingState){
		setTimeout(function() {
			if ( usingState ) {
				if( usingTrayCheckCount == "1" || usingTrayCheckCount == "2" || usingTrayCheckCount == "3" ) {
					toastr.warning('현재 트레이 생산 시스템이 사용중입니다.<br>잠시만 기다려주세요! (' + usingTrayCheckCount + '/3)', '', {timeOut: 5000});
					$('#trayLabelTable tbody').empty();
		        	trayButtonAdd();
		       		nowSingleTonCheck();
				} else {
					toastr.warning('현재 트레이 생산 시스템이 사용중입니다.<br>잠시 후 다시 시도해 주세요! (종료)', '', {timeOut: 5000});
					$('#trayPopUpModal').modal('hide');
					$('#my-spinner').hide();
				}
			} else {
				$('#trayLabelTable tbody').empty();
	           	trayButtonAdd();
				$('#my-spinner').hide();
				toastr.success("트레이 생산 시스템 사용이 종료되었습니다.<br>원하는 작업을 다시 진행 해주세요.", '', {timeOut: 5000});
			}
		}, 5000);
	}

	//현재 싱글 톤 확인 하는 부분
	function nowSingleTonCheck() {
		$.ajax({
			url: '<c:url value="po/productionPerfTraySingleTonCheck"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'	 	: 	menuAuth,
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					usingTrayCheckCount++;
					singleTonStateMessage(data);
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){}
		});
	}

	
	//---------------------------------------------------------------------------------------------------------//
	//---------------------------------------------------------------------------------------------------------//
	//Tray 관련 코드 작성 끝
	
	
    $( document ).ready( function() {
    	$('#btnMonitoringOnOff').click()
	});
    
</script>


<script>
	//웹 서버를 접속한다.
	var webSocket = new WebSocket("ws://localhost:8181");
	// 웹 서버와의 통신을 주고 받은 결과를 출력할 오브젝트를 가져옵니다.
	var messageTextArea = document.getElementById("installedPrinterName");
	// 소켓 접속이 되면 호출되는 함수
	webSocket.onopen = function(message){
		toastr.success('인쇄 서버에 연결되었습니다.')
		$('#wsStateView').text('연결됨');
		$('#wsStateView').css('color','#19FF00');
	};
	// 소켓 접속이 끝나면 호출되는 함수
	webSocket.onclose = function(message){
		toastr.error('인쇄 서버가 종료되었습니다.')
		$('#wsStateView').text('연결끊김');
		$('#wsStateView').css('color','#FF0004');
	};
	// 소켓 통신 중에 에러가 발생되면 호출되는 함수
	webSocket.onerror = function(message){
		toastr.warning('현재 인쇄프로그램이 종료되어있습니다. 인쇄프로그램을 시작해주세요.')
	};
	// 소켓 서버로 부터 메시지가 오면 호출되는 함수.
	webSocket.onmessage = function(message){
		// 출력 area에 메시지를 표시한다.
		console.log(message);
	};
	// 서버로 메시지를 전송하는 함수
	function sendMessage(cmd){
		if(webSocket.readyState == 1) {
			webSocket.send(cmd);
		} else {
			toastr.error('인쇄 서버와의 연결을 확인해주세요.');
			//webSocket = new WebSocket("ws://localhost:9998");
		}
	}
</script>


</body>
</html>