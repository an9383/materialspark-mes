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
							<label class="input-label-sm touch6">주야</label>
							<select class="custom-select custom-select-md touch6" id="ordGubunCd" style="width:70px;"></select>
						</div>
						&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary float-right touch6" id="btnWorkOrdRetv">조회</button>
						<div style="position:absolute;right:0 ">
							<select class="custom-select custom-select-md touch6" id="showMenu" style="width:100px; margin-right: 9px;">
								<option value="no">메뉴 숨김</option>
								<option value="yes">메뉴 표시</option>
							</select>
							<!-- <button type="button" class="btn btn-primary float-right touch6" id="btnMain" onclick="location.href='/main'">메인 화면</button> -->
							
							<button type="button" class="btn btn-primary float-right touch6" id="btnEnd" style="margin-right: 5px;">종료</button>
							<button type="button" class="btn btn-primary float-right touch6" id="btnStart" style="margin-right: 5px;">시작</button>
							<button type="button" class="btn btn-primary float-right touch6 d-none" id="btnCancel" style="margin-right: 5px;">진행 취소</button>
							
							<button type="button" class="btn btn-primary float-right touch6" id="closeFullScreen" style="margin-right: 5px;">전체화면 해제</button>
							<button type="button" class="btn btn-primary float-right touch6" id="openFullScreen" style="margin-right: 5px;">전체화면</button>
	                    </div>
					</div>
					
				</div>
				<div class="card" id="workOrderTableCard">
					<div class="col-md-12 matrl-top-list" style="min-height: 250px;" id="">
						<div class="table-responsive">
							<table id="workOrderTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
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
						</div>
					</div>
					<br>
					<div class="card-body col-sm-12" style="padding: 1px;">
						<h6>자재투입내역</h6>
					</div>
					<div class="col-md-12 matrl-bottom-list" style="min-height: 380px;">
						<div>
							<label class="input-label-sm float-left touch6">바코드</label>
							<input type="text" class="form-control float-left touch6" id="barcodeNo" name="barcodeNo">
							<span class="float-left  mr-2">&nbsp;&nbsp;&nbsp;&nbsp;</span>
							<input type="text" class="form-control float-left touch6" style="border: 0px;" id="matrlCdText" name="matrlCdText" disabled>
							<button type="button" class="btn btn-primary float-left touch6" id="btnMatrlList" disabled>추가 투입자재</button>
							<button type="button" class="btn btn-primary float-right touch6" id="btnSave">저장</button>
							<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnDelete">라인삭제</button>
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
										<th class="text-center">연결 여부</th>
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
					<div class="col-8">
						<div class="row d-none" id="faultyRegDateDiv">
							<label class="input-label-sm touch6">불량등록일</label>
							<input class="form-control touch6 mr-2" style="width:150px;" type="date" id="faultyRegDate" name="faultyRegDate">
							<select class="custom-select custom-select-md touch6" id="nowTime" onchange="nowTimeChange()" style="width:70px;">
								<option value="001">주간</option>
								<option value="002">야간</option>
							</select>
							<button type="button" class="btn btn-primary float-right touch6 ml-2" id="btnFaultyRetv">조회</button>
						</div>
					</div>
					<div class="col-4">
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="left-expand" class="closebtn float-right closePlan"><i class="mdi mdi-close closePlan"></i></a>
						</div>
					</div>
				</div>
				<div class="btn-group-vertical" id="btnCard" style="width: 100%;">
					<button type="button" class="btn btn-success btn-lg btnRight" id="btnPrint">인쇄(엑셀 다운)</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnFirstStep">초물 입력</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnSecondStep">중물 입력</button>
					<span><br></span>
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnOutput">생산실적 입력</button>
					<span><br></span>
					<!-- 
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnVisionOutput">비전엣지검사수량 입력</button>
					<span><br></span>
					 -->
					<button type="button" class="btn btn-primary btn-lg btnRight" id="btnFaulty">불량중량 입력</button>
					<span><br></span>
					<button type="button" class="btn btn-danger btn-lg btnRight" id="btnDowntime">비가동사유 등록</button>
					<span><br></span>
					<button type="button" class="btn btn-purple btn-lg btnRight" id="btnMonitoring">POP 모니터링</button>
					<span><br></span>
					<button type="button" class="btn btn-orange btn-lg btnRight" id="btnMonitoringHistory">모니터링 기록</button>
					<span><br></span>
					<button type="button" class="btn btn-outline-secondary btn-lg btnRight btn-primary" id="btnMonitoringOnOff" style="color:white;">모니터링 ON</button>
					<span><br></span>
					<button type="button" class="btn btn-dark btn-lg btnRight" id="btnMatrlFaulty">자재 불량 등록</button>
					<span><br></span>
					<button type="button" class="btn btn-warning btn-lg btnRight d-none" id="btnWorkOrdConnect">작지 연결</button>
					<span><br></span>
				</div>
				
				<!-- 초,중물 입력 시작 -->
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
								<th class="touch6">비전엣지<br>검사수량</th>
								<td><input type="text" style="color:orange" maxlength="7" min="0" max="100" class="form-control text-right number-float3 touch6" id="visionEdgeWeight" disabled></td>
								<td><input type="text" style="color:orange" maxlength="7" class="form-control text-right touch6" id="visionEdgeCnt" disabled></td>
							</tr>
							
						</table>
					<!-- </div> -->
					<div class="card-body col-md-12 row p-2">
						<div class="col-md-6">
						<button type="button" class="btn btn-danger float-left mr-2 touch6" id="btnOutputDelete">삭제</button>
						</div>
						<div class="col-md-6">
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
		                        <th colspan="2" class="text-center" style="min-width:65px;">생산</th>
		                        <th colspan="2" class="text-center" style="min-width:65px;">비전엣지 검사수량</th>
		                        <th rowspan="2" class="text-center" style="min-width:120px;">등록일시</th>
		                        <th rowspan="2" class="text-center" style="min-width:50px;">주간/야간</th>
		                        <th rowspan="2" class="text-center" style="min-width:40px;">등록자</th>
							</tr>
							<tr>
								<th class="text-center" style="min-width:50px;">중량(KG)</th>
		                        <th class="text-center" style="min-width:50px;">수량(Ea)</th>
		                        <th class="text-center" style="min-width:50px;">중량(KG)</th>
		                        <th class="text-center" style="min-width:50px; border-right:solid #d6d8e1 1px;">수량(Ea)</th>
							</tr>
						</thead>
					</table>
				</div>
				<!-- 생산실적 입력 끝 -->
				
				<!-- 불량등록 입력 시작 -->
				<div class="d-none" id="faultyCard"><!-- right-list 클래스 추가 후 rowspan 부분 회색으로 되지만 스크롤, 및 띠 생김 -->
					<div id="weeklyRange">		
						<!-- 주간 입력&저장 버튼 -->
						<div class="card-body col-sm-12 p-2 d-none" id="cardDay">
							<button type="button" class="btn btn-primary float-left touch6" id="inputDay">주간 입력</button>	
							<button type="button" class="btn btn-primary float-right day touch6" id="dayBtnSave">저장</button>		
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
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger touch6" id="btnDeleteOutputSubCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 생산실적 삭제 확인 모달 끝 -->
<!-- 초중물 삭제 확인 모달 시작 -->
<div class="modal fade" id="deleteStepPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteStep1PopupModalLabel" aria-hidden="true">
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
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div> 
			<div class="modal-body">
				<div class="row">
					<div class="col">
						<h5 class="modal-title" id="matrlDtlTableTitle" style="padding-left:10px;"></h5>
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
								<colgroup><col width="20%"></colgroup>
								<colgroup><col width="20%"></colgroup>
								<colgroup><col width="15%"></colgroup>
								<colgroup><col width="15%"></colgroup>
								<thead class="thead-light">
									<tr>
										<th class="text-center">설비명</th>
										<th class="text-center">제품</th>
										<th class="text-center">LOT NO</th>
										<th class="text-center">작지번호</th>
										<th class="text-center">상태</th>
										<th class="text-center">담당1</th>
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
							<tr>
								<th colspan="4">바코드</th>
								<td colspan="4"><input type="text" class="form-control float-left touch6" id="faultyBarcodeNo" style="min-width:100%"></td>
							</tr>
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
					<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnFaultyMatrlDelete">라인삭제</button>
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

<%@include file="../layout/bottom.jsp"%>

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
	$('#showMenu').val(menu);
	if (menu == "yes"){
		$('#page-wrapper').addClass("page-wrapper");
		$(".page-title-bar").css('margin-top','0px');
		
	} else if (menu == "no"){
		$('#page-wrapper').removeClass("page-wrapper");
		$(".page-title-bar").css('margin-top','40px');
	}

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
    //공통코드 처리 종료
	
	var equipCd = null;		//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)
    var equipGroup = "<%=session.getAttribute("popEquipGroupCd") %>";
	if( equipGroup == 'null' || equipGroup == ""){
		equipGroup = null;
	}

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
	var outputBtnStat = 'add';
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
						$('#agtEquipListWarningModal').modal({backdrop: 'static'});
						$('#agtEquipListWarningModal').modal('show');
					} else {
						for (var i=0; i<data.length; i++){
							var json=new Object();
							json.equipCd = data[i].equipCd;
							json.equipNm = data[i].equipNm;
							json.goodsNm = '-';
							json.ordLotNo = '-';
							json.workOrdNo = '-';
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
				if (agtEquipList[i].workOrdNo.substring(13,14) == 1 || agtEquipList[i].workOrdNo.substring(13,14) == 2) {
					html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>";
					html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
				} else if (agtEquipList[i].workOrdNo.substring(13,14) == 3 || agtEquipList[i].workOrdNo.substring(13,14) == 4) {
					html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>";
					html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
				} else {
					html += "<td class='text-center'>" + agtEquipList[i].ordLotNo + "</td>";
					html += "<td class='text-center'>" + agtEquipList[i].workOrdNo + "</td>";
				}
				html += "<td class='text-center'>" + agtEquipList[i].statusNm + "</td>";
				html += "<td class='text-center'>" + agtEquipList[i].mainWorkChargrNm + "</td>";
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
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
				html += "<td class='text-center'>-</td>";
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
            	'equipGroup'	:	function() { return equipGroup; },
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
	    	$('#equipCodeAdmTable tbody tr td').css('height','52px');
	    }
    });

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
            url: '<c:url value="po/outputCntDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'	: 	menuAuth,
                'workOrdNo'	:	function(){return workOrdNo;},     
            },  
	    },
	    rowId: '',
		columns: [
			{ data: 'workOrdSeq'},
			{ data: 'workOrdDate',
				render: function(data, type, row) {					
					if(data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					} 
				} 
			},
			{ data: 'outputWeight',
		   		render: function(data, type, row) {
		   			return parseFloat(data).toFixed(3);
		   		}
            },
			{ data: 'outputCnt'},
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
			{ data: 'regDate',
				render: function(data, type, row) {					
					return moment(data).format("YYYY-MM-DD HH:mm:ss");
				}
			},
			{ data: 'gubunNm'},
			{ data: 'userNm'},
		],
	    columnDefs: [
	    	{ targets: [0,1,6,7,8], className: 'text-center' },
	    	{ targets: [2,3,4,5,], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [2,3,4,5,], className: 'text-right sum' },
	    ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function(settings) {
			if($('#outputCardTable').DataTable().data().count() > 0) {
				var outputKg = 0;
				var outputEa = 0;
				var visionKg = 0;
				var visionEa = 0;
				$('#outputCardTable tbody tr').each(function(){
					outputKg += parseFloat(parseFloat($(this).find('td').eq(2).text().replace(/,/g,"")).toFixed(3));
					outputEa += parseInt($(this).find('td').eq(3).text().replace(/,/g,""));
					visionKg += parseFloat(parseFloat($(this).find('td').eq(4).text().replace(/,/g,"")).toFixed(5));
					visionEa += parseInt($(this).find('td').eq(5).text().replace(/,/g,""));
				});
				totalKg = outputKg + visionKg;
				totalEa = outputEa + visionEa;
				
				var lineAdd = '';
				lineAdd += '<tr>';
				lineAdd += '<td class="text-center">합계</td>';
				lineAdd += '<td></td>';
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
		}
	});

    $('#outputCardTable tbody').on('click', 'tr', function () {
        if($(this).find('td').eq(0).text() == '합계'){
			return false;
        }
        if($(this).find('td').eq(0).text() == "데이터가 없습니다."){
			return false;
        }
        if ($(this).hasClass('selected')) {
           
        } else {
        	$('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            workOrdSeq = outputCardTable.row(this).data().workOrdSeq;
        }
        outputBtnStat = 'edit';

        $('#btnOutputSave').attr('disabled',true);
    	$('#gubun').attr('disabled',true);
    	$('#firstWeight').attr('disabled',true);
    	$('#visionEdgeWeight').attr('disabled',true);
    	$('#workOrdDate').attr('disabled',true);
        if(workOrdSeq != null) {
	        $.ajax({
	            url: '<c:url value="po/outputCntDataRead"/>',
	            type: 'GET',
	            async: false,
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'workOrdNo'		: 		function(){return workOrdNo;},
	            	'workOrdSeq'	: 		function(){return workOrdSeq;},
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						$('#gubun').val(data.gubun);
						$('#workOrdDate').val(moment(data.workOrdDate).format("YYYY-MM-DD"));
						$('#workOrdRegDate').val(moment(data.regDate).format("YYYY-MM-DD HH:mm:ss"));
						$('#firstWeight').val(data.outputWeight);
						$('#firstCount').val(data.outputCnt);
						$('#visionEdgeWeight').val(data.visionEdgeWeight);
						$('#visionEdgeCnt').val(data.visionEdgeCnt);
					} else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					//$('#searchDay').val("true")
				}
			});
        }
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
			$('#btnWorkOrdConnect').addClass('d-none');
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

    //작업지시 테이블
    $.fn.dataTable.ext.errMode = 'none';
    let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
	    	toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
	       	location.href = "/";
		} ).DataTable({
		language: lang_kor,
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
						goodsNm_html += '<input type="hidden" id="alnicuMatrlCd'+row['workNo']+'" name="alnicuMatrlCd'+row['workNo']+'" value="'+row['alnicuMatrlCd']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="filmMatrlCd'+row['workNo']+'" name="filmMatrlCd'+row['workNo']+'" value="'+row['filmMatrlCd']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="equipCondSeq'+row['workNo']+'" name="equipCondSeq'+row['workNo']+'" value="'+row['equipCondSeq']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="ordLotNo'+row['workNo']+'" name="ordLotNo'+row['workNo']+'" value="'+row['ordLotNo']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="workOrdNo'+row['workNo']+'" name="workOrdNo'+row['workNo']+'" value="'+row['workOrdNo']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="workStatusCd'+row['workNo']+'" name="workStatusCd'+row['workNo']+'" value="'+row['workStatusCd']+'" disabled>';																		
						goodsNm_html += '<input type="hidden" id="goodsCd'+row['workNo']+'" name="goodsCd'+row['workNo']+'" value="'+row['goodsCd']+'" disabled>';
						goodsNm_html += '<input type="text" class="form-control touch6" id="goodsNm'+row['workNo']+'" name="goodsNm'+row['workNo']+'" value="'+row['goodsNm']+'" disabled>';
						goodsNm_html += '<input type="hidden" id="oldWorkTeamCd'+row['workNo']+'" name="oldWorkTeamCd'+row['workNo']+'" value="'+row['workTeamCd']+'" disabled>';																		
						if(sFlag == "") {
							goodsNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm1'+row['workNo']+'" onClick="selectEquipCondCommonList(\''+row["workNo"]+'\')">';
							goodsNm_html += '<span class="oi oi-magnifying-glass"></span>';
							goodsNm_html += '</button>';
						}
						goodsNm_html += '</div>';
						return goodsNm_html ;
	    		}
			},
			{ data: 'qutyNm',
	    		render: function(data, type, row, meta) {	
					return '<span id="qutyNm'+row['workNo']+'">'+data+'</span>';
	    		}
			},
			{ data: 'model',
	    		render: function(data, type, row, meta) {	
					return '<span id="model'+row['workNo']+'">'+data+'</span>';
	    		}
			},
			{ data: 'surfaceTrtmtNm', 
	    		render: function(data, type, row, meta) {
		    		if (data == null){
		    			return '-';
			    	} else {
			    		return '<span id="surfaceTrtmtNm'+row['workNo']+'">'+data+'</span>';
				    }
	    		}
			},
			{ data: 'customDealCorpNm',
	    		render: function(data, type, row, meta) {
	    			var sFlag = uiProcFlag(ordDateCal, row['workStatusCd']);	
		    		var dealCorpNm = data;
		    		if(dealCorpNm == null) dealCorpNm ="";
					var dealCorpNm_html = '<div class="input-sub m-0">';
						dealCorpNm_html += '<input type="hidden" class="form-control" id="dealCorpCd'+row['workNo']+'" name=dealCorpCd'+row['workNo']+'" value="'+row['customDealCorpCd']+'" disabled>';
						dealCorpNm_html += '<input type="text" class="form-control touch6" id="dealCorpNm'+row['workNo']+'" name="dealCorpNm'+row['workNo']+'" value="'+dealCorpNm+'" style="width:98%;" disabled>';
						if(sFlag == "") {
							//dealCorpNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm2'+row['workNo']+'" onClick="selectDealCorp(\''+row["workNo"] +'\')">';
							//dealCorpNm_html += '<span class="oi oi-magnifying-glass"></span>';
							//dealCorpNm_html += '</button>';
						}
						dealCorpNm_html += '</div>';
						return dealCorpNm_html ;
	    		}
			},
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
			{ data: 'workTeamCd',
	       		render: function(data, type, row, meta) {
	           		html = 	selectBoxHtml(workTeamCode, 'workTeamCd'+row['workNo'], data, row, meta);
	           		if(uiProcFlag(ordDateCal, row['workStatusCd']) == "disabled") {
	           			html = row['workTeamNm'];
	           		}
	           		return html;
	       		}
			},
			{ data: 'mainWorkChargrNm',
	    		render: function(data, type, row, meta) {
	    			var sFlag = uiProcFlag3(ordDateCal, row['workStatusCd']);
		    		var mainWorkChargrNm = data;
		    		if(mainWorkChargrNm == null) mainWorkChargrNm ="";	
					var mainWorkChargrNm_html = '<div class="input-sub m-0">';
						mainWorkChargrNm_html += '<input type="hidden" class="form-control" id="mainWorkChargr'+row['workNo']+'" name="mainWorkChargr'+row['workNo']+'" value="'+row['mainWorkChargr']+'" disabled>';
						mainWorkChargrNm_html += '<input type="text" class="form-control touch6" id="mainWorkChargrNm'+row['workNo']+'" name="mainWorkChargrNm'+row['workNo']+'" value="'+mainWorkChargrNm+'" style="width:98%;" disabled>';
						if(sFlag == "") {						
							mainWorkChargrNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm3'+row['workNo']+'" onClick="selectWorkCharger(\'main\',\''+row["workNo"] +'\')">';
							mainWorkChargrNm_html += '<span class="oi oi-magnifying-glass"></span>';
							mainWorkChargrNm_html += '</button>';
						}	
						mainWorkChargrNm_html += '</div>';
						return mainWorkChargrNm_html ;
	    		}				
			},	
			{ data: 'subWorkChargrNm',
	    		render: function(data, type, row, meta) {
	    			var sFlag = uiProcFlag3(ordDateCal, row['workStatusCd']);
	    			var subWorkChargrNm = data;
		    		if(subWorkChargrNm == null) subWorkChargrNm ="";			    			
					var subWorkChargrNm_html = '<div class="input-sub m-0">';
						subWorkChargrNm_html += '<input type="hidden" class="form-control" id="subWorkChargr'+row['workNo']+'" name="subWorkChargr'+row['workNo']+'" value="'+row['subWorkChargr']+'" disabled>';
						subWorkChargrNm_html += '<input type="text" class="form-control touch6" id="subWorkChargrNm'+row['workNo']+'" name="subWorkChargrNm'+row['workNo']+'" value="'+subWorkChargrNm+'" style="width:98%;" disabled>';
						if(sFlag == "") {
							subWorkChargrNm_html += '<button type="button" class="btn btn-primary input-sub-search-md" id="addForm4'+row['workNo']+'" onClick="selectWorkCharger(\'sub\',\''+row["workNo"] +'\')">';
							subWorkChargrNm_html += '<span class="oi oi-magnifying-glass"></span>';
							subWorkChargrNm_html += '</button>';
						}	
						subWorkChargrNm_html += '</div>';
						return subWorkChargrNm_html ;
	    		}				
			},																		
		],
	    columnDefs: [
	    	{ targets: [0,1,2,3,4,5,6,7,8,9,10], className: 'text-center' },
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
		
	$('#ordDate').val(ordDateCal);
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
			//작지 연결 버튼 활성화&비활성화
			if ( tempWorkStatus == 'B' && (tempWorkOrdNo.substring(13,14) == 1 || tempWorkOrdNo.substring(13,14) == 3)) {
				$('#btnWorkOrdConnect').removeClass('d-none');
			} else {
				$('#btnWorkOrdConnect').addClass('d-none');
			}
			
			//작지 시작&진행취소 버튼 활성화&비활성화
			if ( tempWorkStatus == 'S' ) {
				$('#btnStart').addClass("d-none");
				$('#btnCancel').removeClass("d-none");
	        } else {
	        	$('#btnCancel').addClass("d-none");
	        	$('#btnStart').removeClass("d-none");
			}
			
	  	  	if ( sideView == "firstStep" && tempWorkStatus == "B"){
	        	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	  	
			} else if ( sideView == "secondStep" && tempWorkStatus == "B"){
	        	toastr.warning("미발행 작업지시는 중물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	  	
			} else {
				if ( $(this).hasClass("selected") ) {
					//이미 선택된 행 선택 시에는 아무것도 하지 않음
					
				} else {
		        	$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		            //$('#left-expand').trigger('click');	//모든 변수 값 초기화
					
		            workOrdNo = workOrderTable.row(this).data().workOrdNo;
		            equipCondSeq = workOrderTable.row(this).data().equipCondSeq;
		            gravity = workOrderTable.row(this).data().gravity;
		            targetWeight = workOrderTable.row(this).data().targetWeight;
		            equipCapa = parseInt(workOrderTable.row(this).data().capa/2);
		            targetCnt = workOrderTable.row(this).data().targetCnt;
		        	outputWeight1 = workOrderTable.row(this).data().outputWeight1;
		        	outputWeight2 = workOrderTable.row(this).data().outputWeight2;
		        	outputWeight3 = workOrderTable.row(this).data().outputWeight3;
		        	outputWeight4 = workOrderTable.row(this).data().outputWeight4;
		        	outputCnt = workOrderTable.row(this).data().outputCnt;
		            workOrdIndex = workOrderTable.row(this).index() + 1;
		            
		        	var matrlText = "[자재코드 : " + $('#alnicuMatrlCd' + workOrdIndex).val() + "/" + $('#filmMatrlCd' + workOrdIndex).val() + "]";
		        	$('#matrlCdText').val(matrlText);
		        	matrlIndex = "";
		        	matrlRowCnt = "";
		        	workStatusCd = workOrderTable.row(this).data().workStatusCd;
		        	$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});
		        	if(uiProcFlag2(ordDateCal ,workStatusCd) == "") {
		        		uiProc(false);
		            } else {
		        		uiProc(true);
		            }
		
		        	//sideView 초물 처리
					if( sideView == "firstStep"){
						stepViewClear();
						agtTempDataRead(); // 에이젼트 온도 데이터 읽기
						agtTempCondRead(); // 에이전트 온도 조건 읽기
						agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
						agtSizeCondRead(); // 에이전트 치수 조건 읽기
						$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
						//btnFirstStep = true;
						
					//sideView 중물 처리
					} else if( sideView == "secondStep"){
						stepViewClear();
						agtTempDataRead(); // 에이젼트 온도 데이터 읽기
						agtTempCondRead(); // 에이전트 온도 조건 읽기
						agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
						agtSizeCondRead(); // 에이전트 치수 조건 읽기
						$('.firstStep, .secondStep, .thirdStep').attr('disabled',true); //입력창 비활성화
						//btnSecondStep = true;
		
					//sideView 생산실적 입력 처리
					} else if( sideView == "output"){
				  	  	if (tempWorkStatus != "S" && tempWorkStatus != "C"){
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
						
						outputRead();
						outputBtnStat = 'add';
						
					}
					//sideView 비가동사유 입력 처리
					//} else if( sideView == "output"){
			        //
					//	outputRead();
					//}
					
					matrlAddListWorkOrdNo = workOrderTable.row( this ).data().workOrdNo;
					matrlAddListGoodsCd = workOrderTable.row( this ).data().goodsCd;
					matrlAddListGoodsNm = workOrderTable.row( this ).data().goodsNm;

					$('#btnMatrlList').attr('disabled',false); // 투입자재목록 버튼
					$('#my-spinner').hide();
	        	}
	        }
		}
    });

	
	
	
	
	$('#ordGubunCd').change(function() {
		//작업지시
		ordDateCal =  $('#ordDate').val();
		if (mainView == "workOrder") {
			ordGubunCd =  $('#ordGubunCd option:selected').val();
			if(ordGubunCd == ""){
				ordGubunCd = null;
			}
			$('#workOrderTable').DataTable().ajax.reload( function () {});
			$('#btnWorkOrdConnect').addClass('d-none');
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
				$('#btnWorkOrdConnect').addClass('d-none');
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
        rowId: 'workOrdNo',
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
			    		var	html = '<input type="number" maxlength="7" min="0" max="' + row['inspectQty'] + '" step="0.001"  class="form-control number-float3" id="faultyQty" name="faultyQty" value="'+ parseFloat(faultyQty).toFixed(3) +'" onpaste="return false;" oncopy="return false;">';
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
	    			if(data != null) {
		    			var remakeNm = "신규투입";
		    			if(data == 'Y') {
							remakeNm = "재투입";
						}
	    				return remakeNm;
	    			} else {
		    			var remakeNm = "신규투입";
		    			if(barcodeData.statusCd == 'P') {
		    				remakeNm = "재투입";
						}
	    				return remakeNm;
	    			}
	    		}				
			},
			{ data: 'changeLocation',
	    		render: function(data, type, row, meta) {
	    			if(data != null) {
	    				return '<input type="text" class="form-control mw-100" name="changeLocation" id="changeLocation-' + meta.row + '" value="' + data + '">';
		    		} else {
		    			return '<input type="text" class="form-control mw-100" name="changeLocation" id="changeLocation-' + meta.row + '">';
			    	}
	    		}
			},
			{ data: 'connectNm' },
		],
        columnDefs: [
        	{ targets: [0,1,2,3,6,7,8,10], className: 'text-center' },
        	{ targets: [4,5], render: $.fn.dataTable.render.number( ',' ) },
        	{ targets: [4,5], className: 'text-right pt-0 pb-0' },
        ],
		order: [
			[ 7, 'asc' ],
		],
// 	    "drawCallback": function( settings ) {
// 	    	$('#workOrderMatrlTable tbody tr td').css('height','40px');
// 	    }
// 	    "complete": function( settings ) {
// 	    	matrlRowCnt = $('#workOrderMatrlTable').DataTable().data().count();
// 	    }
    });

    var matrlIndex;
    $('#workOrderMatrlTable tbody').on('click', 'tr', function () {
    	matrlIndex = $('#workOrderMatrlTable').DataTable().row( this ).index();
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }	
        else {
        	$('#workOrderMatrlTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
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
    	
	        //alert( $("#barcodeNo").val());
	  	  	$.ajax({
	            url: '<c:url value="po/workOrderMatrlData"/>',
	            type: 'GET',
	            async: false,
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'workOrdNo'		: 		function() { return workOrdNo; },
	            	'barcodeNo'		: 		$("#barcodeNo").val(),
	            	'goodsCd'		: 		$("#goodsCd"+workOrdIndex).val(),
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						barcodeData = data;
						$('#barcodeNo').val("");
						$('#workOrderMatrlTable').DataTable().row.add({}).draw(false);
						toastr.success("추가되었습니다.");
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
    	if($('#workOrderMatrlTable .selected').find('td').eq(8).text() == '신규투입') {
    		
    		$.ajax({
    			url: '<c:url value="/po/deleteMatrlCheck"/>',
    			type: 'POST',
    			async: false,
    			data: {
    				'menuAuth'	 	: 		 menuAuth,
    				'workOrdNo'   	:        workOrdNo,                 
    				'lotNo' 		:        $('#workOrderMatrlTable .selected').find('td').eq(3).text()
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
    					
    				} else if (res.result == 'error') {
    					toastr.error(res.message, '', {timeOut: 5000});
    					
    				}
    			},
    			complete:function(){
    			
    			}
    		});
        } else{
        	$('#workOrderMatrlTable').DataTable().rows('.selected' ).remove().draw();
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

    //작지 시작
	$('#btnStart').on('click', function() {
		if($("#workStatusCd"+workOrdIndex).val() == "P") {
			workOrderStatus("S");
		} else {
			toastr.warning('발행 상태 작지만 시작 가능합니다.');
		}
    });

    //작지 진행 취소
    $('#btnCancel').on('click', function() {
		if($("#workStatusCd"+workOrdIndex).val() == "S") {
			$('#workOrdCancelPopupModal').modal('show');
		} else {
			toastr.warning('진행 상태 작지만 취소 가능합니다.');
		}
    });
    
	//작지 진행 취소 확인
	$('#btnWorkOrdCancelCheck').on('click', function() {
		workOrderStatus("P");
	});

	//작지종료 모달 확인 취소
	$('#btnWorkOrdEndCancel').on('click', function() {
		$('#btnWorkOrdEndCancel').modal('hide');
	});

	//작지종료 버튼
	$('#btnEnd').on('click', function() {
    	if($("#workStatusCd"+workOrdIndex).val() == "S") {
			$('#workOrdEndCheckPopupModal').modal('show');
		} else {
			toastr.warning('진행 상태 작지만 종료 가능합니다.', '', {timeOut: 5000});
		}
    });

	//작지종료 모달 확인
	$('#btnWorkOrdEndCheck').on('click', function() {
		workOrderStatus("C");
	});

	//작지 상태 변경
    function workOrderStatus(status) {
    	var workOrdNo = $("#workOrdNo"+workOrdIndex).val();
  		$.ajax({
			url: '<c:url value="/po/workOrderUpdateStatus"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	: 		menuAuth,
				'workOrdNo'   	:        workOrdNo,                 
				'workStatusCd' 	:        status,
				'equipCd'		:		function() { return equipCd; },
  	        	'faultyRegDate'	:		function() { return ordDateCal.replace(/-/g, ''); },
			}, 
			beforeSend: function() {
			//  $('#btnAddConfirm').addClass('d-none');
			},            
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					toastr.success('작지 상태가 수정 되었습니다.');
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#workOrderMatrlTable').DataTable().clear().draw();
					matrlIndex = "";
					matrlRowCnt = "";
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				if ( status == 'C' || status == 'P' ){
					$('#btnCancel').addClass("d-none");
		        	$('#btnStart').removeClass("d-none");
				}
				//작지 진행취소 성공시 무조건 sideView 닫기
				//if ( status == 'P' ){
					$('#left-expand').trigger('click');
				//}
				$('#workOrderTable').DataTable().ajax.reload( function () {});
				$('#workOrderMatrlTable').DataTable().ajax.reload( function () {});
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

        var mainWorkChargr = $("#mainWorkChargr"+workOrdIndex).val();
        if ( !$.trim(mainWorkChargr) ) {
        	$("#addForm3"+workOrdIndex).focus();
            toastr.warning('담당1을 선택해 주세요.');
            return false;
        }
        var subWorkChargr = $("#subWorkChargr"+workOrdIndex).val();
        equipCondSeq = $("#equipCondSeq"+workOrdIndex).val();
        var ordLotNo = $("#ordLotNo"+workOrdIndex).val();
        var workOrdNo = $("#workOrdNo"+workOrdIndex).val();

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
	        rowData.mainWorkChargr = mainWorkChargr;
	        rowData.subWorkChargr = subWorkChargr;
	        rowData.equipCondSeq = equipCondSeq;
	        rowData.ordLotNo = ordLotNo;
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
						'equipCd': function() { return equipCd; }
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
				$('#goodsCd'+equipCondIdx).val(data.goodsCd);
				$('#goodsNm'+equipCondIdx).val(data.goodsNm);
				$('#alnicuMatrlCd'+equipCondIdx).val(data.alnicuMatrlCd);
				$('#filmMatrlCd'+equipCondIdx).val(data.filmMatrlCd);				
				$('#equipCondSeq'+equipCondIdx).val(data.equipCondSeq);
				$('#qutyNm'+equipCondIdx).text(data.alniQutyNm);
				$('#surfaceTrtmtNm'+equipCondIdx).text(data.surfaceTrtmtNm);
				$('#model'+equipCondIdx).text(data.model);
				
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
   	var userPopUpTable;
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
  	
  	$('#btnPrint').on('click', function(){
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
  	  	
        $.ajax({
	        url: '<c:url value="/po/workOrdexcel"/>',
	        type: 'GET',
	        //async: false,
	        datatype: 'json',
	        data:  {
	        	'menuAuth'	 	: 		menuAuth,
		        'alnicuMatrlCd'		: 	$('#alnicuMatrlCd'+workOrdIndex).val() ,
				'filmMatrlCd'		: 	$('#filmMatrlCd'+workOrdIndex).val() ,
				'equipCondSeq'		: 	$('#equipCondSeq'+workOrdIndex).val(),
				'ordLotNo'			:	$('#ordLotNo'+workOrdIndex).val() ,
				'workOrdNo' 		: 	$('#workOrdNo'+workOrdIndex).val(),
				'workStatusCd' 		: 	$('#workStatusCd'+workOrdIndex).val() ,
				'goodsCd'			: 	$('#goodsCd'+workOrdIndex).val() ,
				'goodsNm'			: 	$('#goodsNm'+workOrdIndex).val() ,
				'qutyNm'			: 	$('#qutyNm'+workOrdIndex).text(),
				'model'				: 	$('#model'+workOrdIndex).text() ,
				'surfaceTrtmtNm'	: 	$('#surfaceTrtmtNm'+workOrdIndex).text() ,
				'dealCorpCd' 		:	$('#dealCorpCd'+workOrdIndex).val() ,
				'dealCorpNm' 		:	$('#dealCorpNm'+workOrdIndex).val() ,
				'workTeamCd' 		: 	$('#workTeamCd'+workOrdIndex).val() ,
				'mainWorkChargr' 	: 	$('#mainWorkChargr'+workOrdIndex).val() ,
				'mainWorkChargrNm'	: 	$('#mainWorkChargrNm'+workOrdIndex).val() ,
				'subWorkChargr' 	: 	$('#subWorkChargr'+workOrdIndex).val() ,
				'subWorkChargrNm' 	: 	$('#subWorkChargrNm'+workOrdIndex).val()
	        },
	        beforeSend: function() {
	        	$('#my-spinner').show();
			},            
              success: function (res) {
  	            if (res.result == 'ok') {
  		            location.href = '<c:url value="/po/workOrdExcelDownload?id="/>' + $('#workOrdNo'+workOrdIndex).val();
  	            } else if (res.result == 'fail') {
  	            	toastr.error(res.message);
  				} else {
  					toastr.error("오류가 발생하였습니다. - excel/print-001");
  				}
  				//let path = "C:/tmp/tmp에 저장되었습니다.";
  	            //toastr.success(path); 
  			},
            complete:function(){
            	$('#my-spinner').hide();
                //$('#btnAddConfirm').removeClass('d-none');
            }
        });
	});

   	function uiProc(flag)
   	{
        $("#barcodeNo").attr("disabled",flag);                
        $("#btnDelete").attr("disabled",flag); 
        $("#btnSave").attr("disabled",flag);       
        $("#barcodeNo").val("");
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
	    $('#workOrderMatrlTable tbody tr').each(function(){
			var tbarcodeNo= $(this).find('td').eq(6).html();
			if(barcodeNo == tbarcodeNo) {  
				result = false;
				return result;
			}
		});
	    return result;
	}
	
	//rightList 닫기 버튼
	$('#left-expand').on('click', function(){
		$('#workOrderTableCard').removeClass('d-none');		//작업지시
		$('#equipSizeCondStepCard').addClass('d-none');		//불량 등록 입력
		$('#equipDowntimeTableCard').addClass("d-none");	//비가동사유 입력
		$('#btnWorkOrdConnect').addClass('d-none');			//작지연결 숨김
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
			$('#leftList').removeClass("d-none");			//설비리스트
			$("#leftList").css("display", true);
			$('#closeLeftView').addClass("d-none");			//오른쪽 화면 닫기 버튼
			$('#btnCard').removeClass("d-none");			//오른쪽 버튼 공간
			$('.btnRight').removeClass("d-none");			//오른쪽 버튼 모음
			$('#equipSizeCondStepCard').addClass("d-none");	//초,중물 입력
			$('#outPutCard').addClass("d-none");			//생산실적 입력
			$('#faultyCard').addClass("d-none");			//생산실적 입력
			$('#downtimeCard').addClass("d-none");			//비가동사유 입력
			$('#btnWorkOrdConnect').addClass("d-none");		//작지 연결
			if (tempWorkStatus == "S") {
				$('#btnCancel').removeClass('d-none');
				$('#btnStart').addClass('d-none');
			} else {
				$('#btnCancel').addClass('d-none');
				$('#btnStart').removeClass('d-none');
			}
			$('#btnEnd').removeClass('d-none');
		});
		//console.log(mainView);
		if(mainView != "workOrder" && mainView != "faulty" && mainView != "downtime") {
			workOrdNo = null;
			ordGubunCd = null;
			ordDateCal =  $('#ordDate').val();
			$('#ordGubunCd').val("");
			//$('#workOrderTable').DataTable().ajax.reload( function () {});
		}
		
		btnFirstStep = false;
		btnSecondStep = false;
		sideView = null;
		mainView = "workOrder";
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
  	  	if( workOrdNo == null){
  	  	  	toastr.warning("초물을 입력할 작업지시를 선택해주세요!");
  	  	  	return false;
  	  	}

		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		} else {
	  	  	if( workStatusCd == "B"){
	  	  	  	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if( workStatusCd == "P"){
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
			});
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);

			sideView = "firstStep";
			stepViewClear();
			btnFirstStep = true;
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
		}
	});
	
	//중물 입력 버튼
	$('#btnSecondStep').on('click', function(){
  	  	if (workOrdNo == null){
  	  	  	toastr.warning("초물을 입력할 작업지시를 선택해주세요!");
  	  	  	return false;
  	  	}

		//작지 상태확인
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, workStatusCd);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			workStatusCd = null;
			return false;
		
		} else {
	  	  	if( workStatusCd == "B"){
	  	  	  	toastr.warning("미발행 작업지시는 초물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if( workStatusCd == "P"){
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
				$('#btnFirstStepInsert').addClass('d-none');		//초물 등록 버튼
				$('#btnSecondStepInsert').removeClass('d-none');	//중물 등록 버튼
			});
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);

			sideView = "secondStep";
			stepViewClear();
			btnSecondStep = true;
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
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
		} else if(step == 'thirdStep'){
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',true);
			$('.thridStep').attr('disabled',false);
		} else {
			//console.log('??');
		}
	}

	//초중종물 수정 버튼 click
	$('#btnStepEdit').on('click',function() {
		selectStepBtn(sideView);
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
		
		$.ajax({
   	   	    //url: '<c:url value="po/workOrderStepInsert"/>',
			url: '<c:url value="po/workOrderStepInsertRedis_DB0"/>',
			type: 'POST',
			async: false,
			data: {
   	        	'menuAuth'	 	: menuAuth,
	   	        'workOrdNo'		: workOrdNo,
	   	     	'equipCd'		:	function() { return equipCd; },
	   	     	//'ifEquipCd'		: equipNm,
	   	        'stepCd'		: stepCd,
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
   	        complete:function(){
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
    	$('#deleteStepPopupModal').modal('show');
    });

   //초물 삭제 확인
    $('#deleteStepCheck').on('click', function() {    	
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
   	        	'menuAuth'	 	: menuAuth,
	   	        'workOrdNo'		: function(){return workOrdNo;},
	   	     	'ifEquipCd'		: function(){return equipNm;},
	   	        'stepCd'		: function(){return stepCd;},
   	        },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if (sideView == 'firstStep') {
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
	   					$('#firstBurrRedgeAlwnce').val("0");
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
	   					$('#secondBurrRedgeAlwnce').val("0");
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
		if (workOrdNo == "" || workOrdNo == null) {
		  	toastr.warning("생산실적을 입력할 작업지시를 선택해주세요!");
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
				width : "65%"
			}, 0);
			$("#rightList").animate({
				width : "34.5%"
			}, 0, function(){
				$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
				$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
				$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
				$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
				$('#outPutCard').removeClass("d-none");				//생산실적 입력
				$('#faultyCard').addClass("d-none");				//생산실적 입력
				$('#btnStepReload').addClass('d-none');				//초,중,종물 재조회 버튼
			});

			sideView = "output";
			
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

		//작업지시 상태 
		var checkWorkOrdStatusTemp = checkWorkOrdStatus(workOrdNo, tempWorkStatus);
		if (checkWorkOrdStatusTemp) {
			workOrdNo = null;
			tempWorkStatus = null;
			$('#btnCancel').addClass("d-none");
        	$('#btnStart').removeClass("d-none");
			$('#left-expand').trigger('click');
			return false;
			
		} else {
			if (tempWorkStatus != "S" && tempWorkStatus != "C") {
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
			});
			$('#btnWorkOrdRetv').addClass("d-none");
			$('.firstStep').attr('disabled', false);
			$('.secondStep').attr('disabled', true);
			$('#workSearchCond').addClass("d-none");			//작업지시 검색조건
			$('#showMenu').addClass("d-none");
			sideView = "faulty";
			mainView = "faulty";

	        //불량중량 입력 통계 컨트롤
	        ordDateCal = $('#ordDate').val();
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

	        $('#ordDateDiv').addClass('d-none');
	        $('#faultyRegDateDiv').removeClass('d-none');
		}
	});

	//비가동시간 입력 버튼
	$('#btnDowntime').on('click', function(){
	  	if( equipCd == null){
	  	  	toastr.warning("비가동사유를 등록할 설비명을 선택해주세요!");
	  	  	return false;
	  	}

	  	$("#leftList").animate({
			width : "13%"
	  	}, 0);
		$("#middleList").animate({
			width : "41%"
		}, 0, function(){
			setTimeout(function() {
				$('#workOrderTableCard').addClass("d-none");	//작업지시 테이블
				$('#equipFaultyTableCard').addClass("d-none");	//불량통계 테이블
				$('#equipDowntimeTableCard').removeClass("d-none");	//불량통계 테이블
			}, 150);
		});
		$("#rightList").animate({
			width : "45.5%"
		}, 0, function(){
			$('#closeLeftView').removeClass("d-none");			//오른쪽 화면 닫기 버튼
			$('#btnCard').addClass("d-none");					//오른쪽 버튼 공간
			$('.btnRight').addClass("d-none");					//오른쪽 버튼 모음
			$('#equipSizeCondStepCard').addClass("d-none");		//초,중물 입력
			$('#outPutCard').addClass("d-none");				//생산실적 입력
			$('#faultyCard').addClass("d-none");				//생산실적 입력
			$('#downtimeCard').removeClass("d-none");			//비가동사유 입력
			$('#btnStepReload').addClass('d-none');				//초,중,종물 재조회 버튼
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
		$('#ordGubunCd').val("D");
		ordGubunCd = "D";
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
	$('#btnWorkOrdConnect').on('click', function() {
  	 	var goodsCd = $("#goodsCd"+workOrdIndex).val();
        if ( !$.trim(goodsCd) ) {
			$("#goodsCd"+workOrdIndex).focus();
			toastr.warning('제품(기종)을 선택해 주세요!');
			return false;
        }
        var dealCorpCd = $("#dealCorpCd"+workOrdIndex).val();
        if ( !$.trim(dealCorpCd) ) {
			toastr.warning('거래처를 선택해 주세요!');
			$("#addForm2"+workOrdIndex).focus();
			return false;
        }
		var workTeamCd = $("#workTeamCd"+workOrdIndex).val();
        if ( !$.trim(workTeamCd) ) {
			$("#workTeamCd"+workOrdIndex).focus();
			toastr.warning('근무조를 선택해 주세요!');
			return false;
        }
		var mainWorkChargr = $("#mainWorkChargr"+workOrdIndex).val();
        if ( !$.trim(mainWorkChargr) ) {
			$("#addForm3"+workOrdIndex).focus();
			toastr.warning('담당1을 선택해 주세요!');
			return false;
        }
        
		connectWorkOrdNo = '';
		connectMainMatrlBarcode = '';
	    connectSubMatrlBarcode = '';
		connectMainMatrlCheck = false;
	    connectSubMatrlCheck = false;
		$('#connectBarcodeNo').val('');
		$('#btnWorkOrdConncetCheck').attr('disabled', true);
		$('#connectWorkOrdNoDtlTable').DataTable().clear().draw();
		//$('#connectWorkOrdNoModal').modal({backdrop: 'static'});
		$('#connectWorkOrdNoTable').DataTable().ajax.reload( function () {});
		$('#connectWorkOrdNoModal').modal('show');
		
	});

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
   	        	'menuAuth'	 	: menuAuth,
	   	        'workOrdNo'		: workOrdNo
   	        },
   	        success: function (res) {
   	        	var data = res.data;
				if(res.result == 'ok') {

					//초,중물 데이터가 없는 경우
					if(data == null || data == ''){
						if(sideView == 'firstStep') { // 초물보기 상태일 경우
							$('#btnFirstStepInsert').attr('disabled', false);
							$('#btnStepEdit').attr('disabled', true);
						}
						if(sideView == 'secondStep') { // 중물보기 상태일 경우
							$('#btnSecondStepInsert').attr('disabled', true);
							$('#btnStepEdit').attr('disabled', true);
						}

					//초,중물 데이터가 있는 경우
					} else {
						for(var i=0;i<data.length;i++) {
							if(data[i].stepCd == '001') {
								var stepNm = 'first';
								if(sideView == 'firstStep') { // 초물보기 상태일 경우
									$('#btnFirstStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
								}

								//초물만 있을경우 중물 등록버튼활성화, 초물을 등록하지 않으면 중물을 등록 할 수 없도록 중물등록 버튼 비활성화
								if ( data.length == 1 && data[0].stepCd == '001' ){
									$('#btnSecondStepInsert').attr('disabled', false);
									//$('#btnStepEdit').attr('disabled', true);
								}
								
							} else if(data[i].stepCd == '002') {
								var stepNm = 'second';
								if(sideView == 'secondStep') { // 중물보기 상태일 경우
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
							$('#'+stepNm+'BurrMetalAlwnce').val(data[i].burrMetalAlwnce);
							$('#'+stepNm+'BurrRcutAlwnce').val(data[i].burrRcutAlwnce);
							$('#'+stepNm+'BurrRedgeAlwnce').val(data[i].burrRedgeAlwnce);
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
 				if (workStatusCd != "S" && workStatusCd != "C") {
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
   	        	'menuAuth'	 	: menuAuth,
	   	        'workOrdNo'		: workOrdNo,
   				'equipCondSeq' 	: equipCondSeq,
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

		//온도
		$.ajax({
			url: '<c:url value="/po/agtUpdateTemp"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				'stepCd'				:	sideView == 'firstStep'?'001':'002',
				'warmupCond'			:	$('#'+sideView.replace('Step','')+'WarmupCond').val(),
				'fitup1UpCond'			:	$('#'+sideView.replace('Step','')+'Fitup1UpCond').val(),
				'fitup1DownCond'		:	$('#'+sideView.replace('Step','')+'Fitup1DownCond').val(),
				'fitup2UpleftCond'		:	$('#'+sideView.replace('Step','')+'Fitup2UpleftCond').val(),
				'fitup2DownleftCond'	:	$('#'+sideView.replace('Step','')+'Fitup2DownleftCond').val(),
				'fitup2UprightCond'		:	$('#'+sideView.replace('Step','')+'Fitup2UprightCond').val(),
				'fitup2DownrightCond'	:	$('#'+sideView.replace('Step','')+'Fitup2DownrightCond').val(),
				'rollheatUpCond'		:	$('#'+sideView.replace('Step','')+'RollheatUpCond').val(),
				'rollheatDownCond'		:	$('#'+sideView.replace('Step','')+'RollheatDownCond').val(),
				'firstUpleftCond'		:	$('#'+sideView.replace('Step','')+'FirstUpleftCond').val(),
				'firstDownleftCond'		:	$('#'+sideView.replace('Step','')+'FirstDownleftCond').val(),
				'firstUprightCond'		:	$('#'+sideView.replace('Step','')+'FirstUprightCond').val(),
				'firstDownrightCond'	:	$('#'+sideView.replace('Step','')+'FirstDownrightCond').val(),
				'push1UpCond'			:	$('#'+sideView.replace('Step','')+'Push1UpCond').val(),
				'push1DownCond'			:	$('#'+sideView.replace('Step','')+'Push1DownCond').val(),
				'firstUpleftCond'		:	$('#'+sideView.replace('Step','')+'FirstUpleftCond').val(),
				'secondUpleftCond'		:	$('#'+sideView.replace('Step','')+'SecondUpleftCond').val(),
				'secondDownleftCond'	:	$('#'+sideView.replace('Step','')+'SecondDownleftCond').val(),
				'secondUprightCond'		:	$('#'+sideView.replace('Step','')+'SecondUprightCond').val(),
				'secondDownrightCond'	:	$('#'+sideView.replace('Step','')+'SecondDownrightCond').val(),
				'thirdUpleftCond'		:	$('#'+sideView.replace('Step','')+'ThirdUpleftCond').val(),
				'thirdDownleftCond'		:	$('#'+sideView.replace('Step','')+'ThirdDownleftCond').val(),
				'thirdUprightCond'		:	$('#'+sideView.replace('Step','')+'ThirdUprightCond').val(),
				'thirdDownrightCond'	:	$('#'+sideView.replace('Step','')+'ThirdDownrightCond').val(),
				'jinjeop1UpCond'		:	$('#'+sideView.replace('Step','')+'Jinjeop1UpCond').val(),
				'jinjeop1DownCond'		:	$('#'+sideView.replace('Step','')+'Jinjeop1DownCond').val(),
				'jinjeop2UpCond'		:	$('#'+sideView.replace('Step','')+'Jinjeop2UpCond').val(),
				'jinjeop2DownCond'		:	$('#'+sideView.replace('Step','')+'Jinjeop2DownCond').val(),
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
				'stepCd'				:	sideView == 'firstStep'?'001':'002',
				'wpLeftAlwnce'			:	$('#'+sideView.replace('Step','')+'WpLeftAlwnce').val(),
				'wpRightAlwnce'			:	$('#'+sideView.replace('Step','')+'WpRightAlwnce').val(),
				'pitchLeftAlwnce'		:	$('#'+sideView.replace('Step','')+'PitchLeftAlwnce').val(),
				'pitchRightAlwnce'		:	$('#'+sideView.replace('Step','')+'PitchRightAlwnce').val(),
				'ppfWingLeftAlwnce'		:	$('#'+sideView.replace('Step','')+'PpfWingLeftAlwnce').val(),
				'ppfWingRightAlwnce'	:	$('#'+sideView.replace('Step','')+'PpfWingRightAlwnce').val(),
				'ppfDepthLeftAlwnce'	:	$('#'+sideView.replace('Step','')+'PpfDepthLeftAlwnce').val(),
				'ppfDepthRightAlwnce'	:	$('#'+sideView.replace('Step','')+'PpfDepthRightAlwnce').val(),
				'filmAlwnce'			:	$('#'+sideView.replace('Step','')+'FilmAlwnce').val(),
				'metalDepthAlwnce'		:	$('#'+sideView.replace('Step','')+'MetalDepthAlwnce').val(),
				'metalThicknessAlwnce'	:	$('#'+sideView.replace('Step','')+'MetalThicknessAlwnce').val(),
				'thCenterAlwnce'		:	$('#'+sideView.replace('Step','')+'ThCenterAlwnce').val(),
				'thEdgeAlwncePlus'		:	$('#'+sideView.replace('Step','')+'ThEdgeAlwncePlus').val(),
				'bulgeLeftupHeight'		:	$('#'+sideView.replace('Step','')+'BulgeLeftupHeight').val(),
				'bulgeLeftdownHeight'	:	$('#'+sideView.replace('Step','')+'BulgeLeftdownHeight').val(),
				'bulgeRightupHeight'	:	$('#'+sideView.replace('Step','')+'BulgeRightupHeight').val(),
				'bulgeRightdownHeight'	:	$('#'+sideView.replace('Step','')+'BulgeRightdownHeight').val(),
				'bulgeLeftupWidth'		:	$('#'+sideView.replace('Step','')+'BulgeLeftupWidth').val(),
				'bulgeLeftdownWidth'	:	$('#'+sideView.replace('Step','')+'BulgeLeftdownWidth').val(),
				'bulgeRightupWidth'		:	$('#'+sideView.replace('Step','')+'BulgeRightupWidth').val(),
				'bulgeRightdownWidth'	:	$('#'+sideView.replace('Step','')+'BulgeRightdownWidth').val(),
				'burrMetalAlwnce'		:	$('#'+sideView.replace('Step','')+'BurrMetalAlwnce').val(),
				'burrRcutAlwnce'		:	$('#'+sideView.replace('Step','')+'BurrRcutAlwnce').val(),
				'burrRedgeAlwnce'		:	$('#'+sideView.replace('Step','')+'BurrRedgeAlwnce').val()
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
  		$(".cond, .firstStep, .secondStep, .thridStep").val("0");
		$("#firstRegTime, #secondRegTime, #thirdRegTime").val("");
	}

	//에이젼트 온도 데이터 읽기
	function agtTempDataRead() {
		$('#btnStepDelete').attr('disabled',true);
		$('#btnStepEdit').attr('disabled',true);
		$('#btnStepSave').attr('disabled',true);
		$.ajax({
			url: '<c:url value="/po/agtReadTemp"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	: menuAuth,
				'workOrdNo'		: workOrdNo
			},
			success: function (res) {
				var data = res.data;
				if(res.result == 'ok') {
					for(var i=0;i<data.length;i++) {
						if(data[i].stepCd == '001') {
							var stepNm = 'first';
							if(sideView == 'firstStep') { // 초물보기 상태일 경우
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
						} else if(data[i].stepCd == '002') {
							var stepNm = 'second';
							if(sideView == 'secondStep') { // 중물보기 상태일 경우
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
						} else if(data[i].stepCd == '003') {
							var stepNm = 'third';
						} 
						$('#'+stepNm+'WarmupCond').val(data[i].warmupCond);
						$('#'+stepNm+'Fitup1UpCond').val(data[i].fitup1UpCond);
						$('#'+stepNm+'Fitup1DownCond').val(data[i].fitup1DownCond);
						$('#'+stepNm+'Fitup2UpleftCond').val(data[i].fitup2UpleftCond);
						$('#'+stepNm+'Fitup2DownleftCond').val(data[i].fitup2DownleftCond);
						$('#'+stepNm+'Fitup2UprightCond').val(data[i].fitup2UprightCond);
						$('#'+stepNm+'Fitup2DownrightCond').val(data[i].fitup2DownrightCond);
						$('#'+stepNm+'RollheatUpCond').val(data[i].rollheatUpCond);
						$('#'+stepNm+'RollheatDownCond').val(data[i].rollheatDownCond);
						$('#'+stepNm+'FirstUpleftCond').val(data[i].firstUpleftCond);
						$('#'+stepNm+'FirstDownleftCond').val(data[i].firstDownleftCond);
						$('#'+stepNm+'FirstUprightCond').val(data[i].firstUprightCond);
						$('#'+stepNm+'FirstDownrightCond').val(data[i].firstDownrightCond);
						$('#'+stepNm+'Push1UpCond').val(data[i].push1UpCond);
						$('#'+stepNm+'Push1DownCond').val(data[i].push1DownCond);
						$('#'+stepNm+'FirstUpleftCond').val(data[i].firstUpleftCond);
						$('#'+stepNm+'SecondUpleftCond').val(data[i].secondUpleftCond);
						$('#'+stepNm+'SecondDownleftCond').val(data[i].secondDownleftCond);
						$('#'+stepNm+'SecondUprightCond').val(data[i].secondUprightCond);
						$('#'+stepNm+'SecondDownrightCond').val(data[i].secondDownrightCond);
						$('#'+stepNm+'ThirdUpleftCond').val(data[i].thirdUpleftCond);
						$('#'+stepNm+'ThirdDownleftCond').val(data[i].thirdDownleftCond);
						$('#'+stepNm+'ThirdUprightCond').val(data[i].thirdUprightCond);
						$('#'+stepNm+'ThirdDownrightCond').val(data[i].thirdDownrightCond);
						$('#'+stepNm+'Jinjeop1UpCond').val(data[i].jinjeop1UpCond);
						$('#'+stepNm+'Jinjeop1DownCond').val(data[i].jinjeop1DownCond);
						$('#'+stepNm+'Jinjeop2UpCond').val(data[i].jinjeop2UpCond);
						$('#'+stepNm+'Jinjeop2DownCond').val(data[i].jinjeop2DownCond);
					}
				} else {
					toastr.error(res.message, '(에이전트 온도 데이터 조회)', {timeOut: 5000});
				}
			},
 			complete:function(res){
 				//엣지검사완료/외관검사완료/종료 시 등록된 정보 표시만
 				if (workStatusCd != "S" && workStatusCd != "C") {
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
			url: '<c:url value="/po/readTempCond"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	: menuAuth,
				'workOrdNo'		: workOrdNo
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
		$('#visionEdgeCnt').val( parseInt(parseFloat($('#visionEdgeWeight').val())/parseFloat(gravity)*1000) );
		//중량 소계
		//$('#totalOutputWeight').val( (parseFloat($('#firstWeight').val()) + parseFloat($('#secondWeight').val()) + parseFloat($('#thirdWeight').val()) + parseFloat($('#fourthWeight').val())).toFixed(3) );
		//수량 소계
		//$('#totatlOutputCount').val( parseInt($('#firstCount').val()) + parseInt($('#secondCount').val()) + parseInt($('#thirdCount').val()) + parseInt($('#fourthCount').val()) ); 
	});
	
	//생산1 입력
	$('#firstWeight').keyup(function (event) {
		$('#firstCount').val( parseInt(parseFloat($('#firstWeight').val())/parseFloat(gravity)*1000) );
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
    $('#btnOutputSave').on('click', function() {
    	if (workOrdNo == "" || workOrdNo == null) {
    		toastr.warning("생산실적을 입력할 작업지시를 선택해주세요!");
			return false;
    	}
		if($('#gubun option:selected').val() == ""){
			toastr.warning("주야구분을 선택해주세요.");
			$('#gubun').focus();
			return false;
		}
		if($('#firstWeight').val() == "0" && $('#visionEdgeWeight').val() == "0"){
			toastr.warning("생산중량 또는 비전엣지 검사수량을 입력해 주세요.");
			$('#firstWeight').select();
			return false;
		}
		if($('#workOrdDate').val() == ""){
			toastr.warning("전표일자를 선택해주세요.");
			$('#workOrdDate').focus();
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
		if(outputBtnStat == 'add'){
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
             	'workOrdNo'			:		workOrdNo,
             	'ordDate'			:		$('#ordDate').val().replace(/-/g,""),
             	'gubun'				:		$('#gubun').val(),
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
				let data = res.data;
				if (res.result == 'ok') {
					//$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#outputCardTable').DataTable().ajax.reload( function () {});
					$('#workOrdRegDate').val(moment(data).format("YYYY-MM-DD HH:mm:ss"));
					$('#btnOutputSave').attr('disabled',true);
					//$('#btnOutputEdit').attr('disabled',true);
					$('#gubun').attr('disabled',true);
					$('#firstWeight').attr('disabled',true);
					$('#visionEdgeWeight').attr('disabled',true);
					$('#workOrdDate').attr('disabled',true);
					toastr.success('생산실적 수정되었습니다.');
				} else {
					$('#outputCardTable').DataTable().ajax.reload( function () {});
					 toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				$('#my-spinner').hide();   	        	
			}
   	    });
    });

    $('#btnOutputEdit').on('click', function() {
    	if ( !$('#outputCardTable tr').hasClass('selected') ) {
			toastr.warning("수정할 라인을 선택해주세요.");
            return false;
        }
    	outputBtnStat = 'edit';
    	$('#gubun').attr('disabled',false);
    	$('#firstWeight').attr('disabled',false);
    	$('#visionEdgeWeight').attr('disabled',false);
    	$('#workOrdDate').attr('disabled',false);
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

    	$.ajax({
			url: '<c:url value="po/outputCntDataDelete"/>',
			type: 'POST',
			async: false,
			data: {
            	'menuAuth'	 	: 		menuAuth,
             	'workOrdNo'   	:       workOrdNo,             
             	'workOrdSeq'   	:       workOrdSeq,
             	'ordDate'		:		$('#ordDate').val().replace(/-/g,""),
            	'targetCnt'     :       tempTargetCnt,
    	
 	    		//'workStatusCd'  :       'E',		//컨트롤단에서 설정
             },
             success: function (res) {
                 if (res.result == 'ok') {
					$('#workOrderTable').DataTable().ajax.reload( function () {});
					$('#outputCardTable').DataTable().ajax.reload( function () {});
					$('#firstWeight').val("0");
					$('#firstCount').val("0");
					$('#visionEdgeWeight').val("0");
					$('#visionEdgeCnt').val("0");
					$('#workOrdRegDate').val("");
					$('#btnOutputSave').attr('disabled',true);
					$('#gubun').attr('disabled',true);
    				$('#firstWeight').attr('disabled',true);
    				$('#workOrdDate').attr('disabled',true);
               	   	toastr.success('생산실적 삭제 되었습니다.');
                 } else {
                	 toastr.error(res.message, '', {timeOut: 5000});
                 }
             },
   	        complete:function(){
   	        	
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
	  	            }
  	            
					total();	//합산 계산하기
					
				},
  	        complete:function(){
  	        	$('#my-spinner').hide();
			}
		});
	};

	$('#equipFaultyTable tbody').on('click', 'tr', function () {
		if( workOrdNo == null ){
			toastr.warning('작업지시를 선택해주세요.');
			return false;
		} else{
			if ( $(this).hasClass('tableSelected') ) {
				//$(this).removeClass('tableSelected');
			}
	        else {
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

  		//주간 공정불량
		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo; },
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
								if(parseInt(it.systemCode) == (parseInt(index / 2) + 1) && parseInt(it.faultySeq) == (parseInt(index % 2) + 1)) {
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
									if(parseInt(it.systemCode) == (parseInt(index/2)+1) && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
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

			//1개이상 등록하였으나 전체삭제
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
	function createFaultyArray(dayNightNm, dayNightCd, tempSideView)
	{
		var faultyArray = new Array();
		var faultyType;
		var gubun;
		var count = 0;
		
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
						rowData.equipCd = equipCd;
						rowData.workOrdNo = workOrdNo;
						rowData.ordDate	= ordDateCal.replace(/-/g, '');
						rowData.dayNightCd = dayNightCd;
						rowData.faulty = $(this).val();
						rowData.gubun = '003';
						rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						rowData.workOrdNo = workOrdNo;
						rowData.systemCode = (parseInt(index/5)+1);
						rowData.faultySeq =  (parseInt(index%5)+1);
						rowData.faultyDesc = '';
						//시간
						rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 5) ).val();
						
						count++;
						faultyArray.push(rowData);
					}
				});
			//} else if (gubun == '004') {
			} else if (gubun == '001' || gubun == '002' || gubun == '004') {
				$('#form' + dayNightNm + faultyType + ' table tbody tr td input[type=number]').each(function(index, item) {
					if($(this).val()!='0' && $(this).val()!='0.' && $(this).val()!='0.0' && $(this).val()!='0.00' && $(this).val()!='0.000') {
						var rowData = new Object();
						rowData.equipCd = equipCd;
						rowData.workOrdNo = workOrdNo;
						rowData.ordDate	= ordDateCal.replace(/-/g, '');
						rowData.dayNightCd = dayNightCd;
						rowData.faulty = $(this).val();
						rowData.gubun = gubun;
						rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
						rowData.systemCode = (parseInt(index / 2) + 1);
						rowData.faultySeq = (parseInt(index % 2) + 1);
						//rowData.faultyDesc = $(this).closest('tr').find('td input[type=text]').val();
						rowData.faultyDesc = $(this).closest('tr').find('td textarea').val();
						//시간
						rowData.faultyDatetime = $('#' + tempSideView + dayNightNm + '-' + (parseInt($(this).attr('id').split('-')[1]) + 2) ).val();
						
						count++;
						faultyArray.push(rowData);
					}
				});
			}

			//1개이상 등록하였으나 전체삭제
			if (count == 0) {
				var rowData = new Object();
				rowData.equipCd = equipCd;
				rowData.workOrdNo = workOrdNo;
				rowData.dayNightCd = dayNightCd;
				rowData.gubun = gubun;
				rowData.faultyRegDate = $('#faultyRegDate').val().replace(/-/g,"");
				rowData.systemCode = 'empty';
				faultyArray.push(rowData);
			}
		}

		//console.log(faultyArray);
		return faultyArray;
	}
	
	//주간 저장 버튼
	$('#dayBtnSave').on('click', function() {
		
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
			faultyArray = createFaultyArray('Day', 'D', tempSideView);
			
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
	   	            	toastr.error("동시에 다른 사용자가 등록을 시도했습니다.", '', {timeOut: 5000});
	   	            	toastr.error("다시 시도해주세요.", '', {timeOut: 5000});
	   	            	readTotal();
		   	        }
	   	        },
	   	        complete:function(){
	   	        	$('.day').attr('disabled', true);
	   	        	$('.dayTime').attr('disabled', true);
	   	        	$('#my-spinner').hide();
				}
			});
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
			faultyArray = createFaultyArray('Night', 'N', tempSideView); //Night 시 n 반드시 대문자 N
			
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
					}
	   	            else if (res.result == 'fail'){
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
		//원자재 주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo;},
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
		   	         			if(parseInt(it.systemCode) == (parseInt(index/2)+1) && parseInt(it.faultySeq) == (parseInt(index%2)+1)){
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
								if(parseInt(it.systemCode) == (parseInt(index/2)+1) && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
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
			}
			else if (replaceTemp == 1) {
				$('.select_replaceFaulty').css({ "background-color": "#FFFFFF", "color": "#000000" });
				replaceTemp = 0;
			}			
		}
	});

	//교체불량 주야 조회
	function readReplaceFaulty()	{

		//주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 		menuAuth,
  	        	'equipCd'			:		function() { return equipCd; },
  	        	'workOrdNo'			:		function() { return workOrdNo;},
  	        	'faultyRegDate'		:		function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
  	        	'dayNightCd'		:		"D",
  	        	'gubun'				:		"003",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#dayReplaceFaultySearchData').val("fail");
  	   	            } else {
		  	   	       	let data2 = res.readData;
		        		$.each(data2, function(i, it){
		   	         		$('#formDay3 table tbody tr td input[type=number]').each(function(index,item) {
		  	   	         		if(parseInt(it.systemCode) == (parseInt(index/5)+1) && parseInt(it.faultySeq) == (parseInt(index%5)+1)) {
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
					}
				} else {
					toastr.error("주간 " + replaceFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
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
  	        	'faultyRegDate'		:		function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
  	        	'dayNightCd'		:		"N",
  	        	'gubun'				:		"003",
  	        },
  	        success: function (res) {
  	            let result = res.result;
  	            let data = res.readData;
  	            if (res.result == 'ok') {
  	            	if ( data == null) {
  	            		$('#nightReplaceFaultySearchData').val("fail");
  	   	            } else {
	  	   	         	let data2 = res.readData;
			  	   	      
	  	   	     		$.each(data2, function(i, it){		  	   	        	
	   	         			$('#formNight3 table tbody tr td input[type=number]').each(function(index,item){
	  	   	         			if(parseInt(it.systemCode) == (parseInt(index/5)+1) && parseInt(it.faultySeq) == (parseInt(index%5)+1)){
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
					}
				} 
				else {
					toastr.error("주간 " + replaceFaultyNm + " 조회 실패하였습니다.", '', {timeOut: 5000});
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
		//주간
 		$.ajax({
			url: '<c:url value="po/readFaultyAll"/>',
			type: 'GET',
			async: false,
			data: {
  	        	'menuAuth'	 		: 	menuAuth,
  	        	'equipCd'			:	function() { return equipCd; },
  	        	'workOrdNo'			:	function() { return workOrdNo;},
  	        	'faultyRegDate'		:	function() { return $('#faultyRegDate').val().replace(/-/g,"");  },
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
		   	         			if(parseInt(it.systemCode) == (parseInt(index/2)+1) && parseInt(it.faultySeq) == (parseInt(index%2)+1)){
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
									if(parseInt(it.systemCode) == (parseInt(index/2)+1) && parseInt(it.faultySeq) == (parseInt(index%2)+1)) {
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
		$('#faultyRegDate').attr('disabled', false);
		$('.day').attr('disabled', false);
		$('.dayTime').attr('disabled', false);
		$('.night').attr('disabled', true);
		$('.nightTime').attr('disabled', true);
	});

	$('#inputNight').on('click', function() {
		$('#faultyRegDate').attr('disabled', false);
		$('.day').attr('disabled', true);
		$('.dayTime').attr('disabled', true);
		$('.night').attr('disabled', false);
		$('.nightTime').attr('disabled', false);
	});

	//주간 야간 SelectBox값이 변경되었을 떄
	function nowTimeChange(){
		var X = $('#nowTime').val();
		console.log(X);
		//001 : 주간
		//002 : 야간
		if(X=="001"){
			$("#weeklyRange").removeClass('d-none');	//주간
			$("#NighttimeRange").addClass('d-none');	//야간 
		}else{
			$("#weeklyRange").addClass('d-none');	//주간
			$("#NighttimeRange").removeClass('d-none');	//야간
		}
	}

	function faultyTime(){
		console.log("값 들어옴")
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
	
	function total()
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
        pageLength: 15,
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
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="prcssDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="prcssDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="prcssDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
			html += '<tr>' + header1 + '</tr>';
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
			
			html += '<tr>' + header1 + '</tr>';
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
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="matrlDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="matrlDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="matrlDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
			html += '<tr>' + header1 + '</tr>';
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
			
			html += '<tr>' + header1 + '</tr>';
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
			html += '<tr>' + body1 + '</tr>';
			html += '<tr>' + body2 + '</tr>';
			
			header = null;
			body1 = null;
			body2 = null;
			
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
			html += '<tr>' + body1 + '</tr>';
			html += '<tr>' + body2 + '</tr>';
			
			header = null;
			body1 = null;
			body2 = null;
			
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
			header1 += '<td rowspan="2" colspan="2" style="padding-top: 0px; padding-bottom: 0px;"><textarea maxlength="32" style="max-width:100%; height:60px; padding-bottom: 0px; resize:none;" value="-" class="form-control dayText day touch3" id="troubleDay-' + ((index + 1) * 5) + '"></textarea></td>';
			//header += '<td rowspan="2" colspan="2"><input maxlength="32" type="text"  style="max-width:100%" value="-" class="form-control dayText day touch3" id="dayTrb'+((index+1)*3)+'"></td>';
			
			//value="2021-09-03T12:30"
			header2 += '<td><input type="datetime-local" id="troubleDay-' + ((index + 1 ) * 5 - 2) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			header2 += '<td><input type="datetime-local" id="troubleDay-' + ((index + 1 ) * 5 - 1) + '" min="1900-01-01T00:00" max="2100-12-31T00:00" class="form-control dayTime" style="width:180px; padding-right: 0px; padding-left:3px;"></td>';
			
			html += '<tr>' + header1 + '</tr>';
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
			
			html += '<tr>' + header1 + '</tr>';
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
			if (agtEquipList.length == 0) {
				$('#agtEquipListWarningModal').modal('show');
			}
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
								if (agtEquipList[i].workOrdNo.substring(13,14) == 1 || agtEquipList[i].workOrdNo.substring(13,14) == 2) {
									html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>";
									html += "<td class='text-center' style='color:red; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
								} else if (agtEquipList[i].workOrdNo.substring(13,14) == 3 || agtEquipList[i].workOrdNo.substring(13,14) == 4) {
									html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].ordLotNo + "</td>";
									html += "<td class='text-center' style='color:blue; font-weight:bold; margin-bottom:0px;'>" + agtEquipList[i].workOrdNo + "</td>";
								} else {
									html += "<td class='text-center'>" + agtEquipList[i].ordLotNo + "</td>";
									html += "<td class='text-center'>" + agtEquipList[i].workOrdNo + "</td>";
								}
								html += "<td class='text-center'>" + agtEquipList[i].statusNm + "</td>";
								html += "<td class='text-center'>" + agtEquipList[i].mainWorkChargrNm + "</td>";
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
							toastr.warning("POP 모니터링 - 이상발생!", '', {timeOut: 5000});
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
		$('#faultyBarcodeNo').val('');
    	$('#frrrdDate').val(sToday);
    	$('#frrrdDesc').val('');
    	for (let i=0; i<matrlFaultyType.length; i++) {
    		$('#frrrdType' + matrlFaultyType[i].baseCd).prop("checked", false);
        }
        $('#matrlFaultytable').DataTable().clear().draw();
    	$('#faultyPopUpModal').modal({backdrop: 'static'});
    	$('#faultyPopUpModal').modal('show');
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
	    				return faultyInspectQty;
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
	        	        
			$.ajax({
	 			url: '<c:url value="/io/matrlFaultyScan_posc0010"/>',
				type: 'GET',
				async: false,
				data: {
					'menuAuth'	 	:	menuAuth,
					'barcodeNo'		:	$('#faultyBarcodeNo').val(),
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
	});

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
    });



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
			faultyBarcodeList.push(rowData);
		});
		//console.log(faultyBarcodeList);
		
		//인쇄 명령인지 판단
		var url = null;
		var temp = null;
		if(approvalCd != "010"){	
			url = '<c:url value="/qm/matrlInOutWhsInspectUpdateDtl_iosc0080"/>';
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
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					checkWorkOrdStatus = true;
					$('#workOrderTable').DataTable().ajax.reload( function () {});
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
	
</script>
</body>
</html>