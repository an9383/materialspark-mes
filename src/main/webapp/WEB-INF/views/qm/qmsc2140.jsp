<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<% String userNm = session.getAttribute("userNm").toString(); %>
<div class="page-wrapper" id="page-wrapper">

	<!-- 엣지검사 삭제 확인모달 시작-->
	<div class="modal fade" id="deleteAppearCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteAppearCheckPopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteAppearCheckModalLabel">엣지검사 삭제 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h6>삭제하시겠습니까?</h6>
					<p>*삭제 시 엣지 부불량 항목이 삭제 됩니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger touch6" id="btnDeleteAppearCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
					<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!--  엣지검사 삭제 확인모달 끝 -->
	
	<!-- 엣지검사 상태 확인모달 시작-->
	<div class="modal fade" id="stateCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="stateChestateLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="stateCheckModalLabel">엣지검사 상태 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h6>이전 작업이 진행 중입니다. 등록하시겠습니까?</h6>
					<p>*선택하신 생산전표 이전에 등록된 생산전표가 진행 중입니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary touch6" id="btnStateCheckSave" data-dismiss="modal" style="min-width: 70px;">등록</button>
					<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!--  엣지검사 상택 확인모달 끝 -->
	
	<!-- 엣지검사 검사완료 확인모달 시작-->
	<div class="modal fade" id="testDonePopupModal" tabindex="-1" role="dialog" aria-labelledby="testDonePopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="testDoneModalLabel">엣지검사 검사상태 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
				
					<div class="row">
						<label style="font-size: 15px; line-height: 48px; margin-right: 10px;">검사 상태</label>
						<select class="custom-select custom-select-md touch6 mt-2" id="workInspectionStatusSelectBox" style="width:100px; margin-right: 9px;"></select>
					</div>
					
					<h6 id="testDoneModalH6">검사를 상태를 (완료)변경 하시겠습니까?</h6>
					<p >*상태값으로 변경할 수 있습니다.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary touch6" id="btnPopupTestDone" data-dismiss="modal" style="min-width: 70px;">변경</button>
					<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!--  엣지검사 검사완료 확인모달 끝 -->
	
	<!-- 불량 개수 100보다 높으면 메세지 모달 시작 -->
	<div class="modal fade fadebd-example-modal-lg" id="numberUpHundCheckModal" tabindex="-1" role="dialog" aria-labelledby="numberUpHundCheckModalLabel" aria-hidden="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="">입력 값 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<hr class="text-secondary">
					<h6 style="color: black;font-size: 30px;background: aquamarine;text-align: center;font-weight: 500;" id="dateLabel"></h6>
					<p style="font-size: 15px;">*불량 개수가 많습니다. 저장하시겠습니까?</p>
					<hr class="text-secondary">
				</div>
				<div class="modal-footer" style="display: flex;justify-content: space-between;">
				<button type="button" class="btn btn btn-primary touch6" style="min-width: 70px;" id="btnRealSave">저장</button>
					<button type="button" class="btn btn btn-secondary touch6" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 불량 개수 100보다 높으면 메세지 모달 끝 -->
	
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">엣지검사</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid" id="mainCard">
			<div class="left-list left-60" id="leftList" style="width:12%; margin-right:3px; padding-bottom:0px;">
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
			<div class="right-list workOrder-left-list" id="middleList" style="width:52.5%; margin-right:3px;">
				<!-- 작업지시 정보 시작-->
				<div class="card-body" style="padding-top:5px; padding-bottom:5px;">
					<div class="row" style="position:relative">
						&nbsp;
						<div class="row p-1" id="ordDateDiv" >
							<label class="input-label-sm touch6">작업지시일</label>
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
						<!-- 
						<div id="workSearchCond">
							&nbsp;&nbsp;&nbsp;
							<label class="input-label-sm touch6" style="margin-top:5px;">주야</label>
							<select class="custom-select custom-select-md touch6" id="ordGubunCd" style="width:70px;"></select>
						</div>
						-->
						&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary float-right mr-5 touch6" id="btnWorkOrdRetv" style="margin-top:3px;">조회</button>
						
						<button type="button" class="btn btn-primary float-right touch6" style="margin-right:5px;" id="btnTestDone">검사상태 변경</button>
						
						<div class="row mt-1 d-none">
							<label class="input-label-sm touch6">작지번호 스캔</label>
							<input type="text" class="form-control touch6" id="workOrdNoScan">
							<button type="button" class="btn closeBtn" onclick="workOrdNoScanReset();">
								<i class="mdi mdi-close" style="line-height: 6px; zoom: 3;"></i>
							</button>
						</div>
						
						<button type="button" class="btn btn-primary touch6" onclick="btnScrollTop();" style="position: absolute; right: 6vh;">▲</button>
						<button type="button" class="btn btn-primary touch6" onclick="btnScrollBottom();" style="position: absolute; right: -1.5vh;">▼</button>
						
						<!--
						<button type="button" class="btn btn-primary float-right ml-5 touch6" id="btnAddWorkOrder" style="margin-top:3px;">작업지시 추가</button>
						<button type="button" class="btn btn-danger float-right ml-5 touch6" id="btnDeleteWorkOrder" style="margin-top:3px;">작업지시 삭제</button>
						-->
						<div style="position:absolute;right:0 ">
							<!--
							<select class="custom-select custom-select-md touch6" id="showMenu" style="width:100px; margin-right: 9px;">
								<option value="no">메뉴 숨김</option>
								<option value="yes">메뉴 표시</option>
							</select>
							<button type="button" class="btn btn-primary float-right touch6" id="btnMain" onclick="location.href='/main'">메인 화면</button>
							<button type="button" class="btn btn-primary float-right touch6" id="btnEnd" style="margin-right: 5px;">종료</button>
							<button type="button" class="btn btn-primary float-right touch6" id="btnStart" style="margin-right: 5px;">시작</button>
							<button type="button" class="btn btn-primary float-right touch6 d-none" id="btnCancel" style="margin-right: 5px;">진행 취소</button>
							<button type="button" class="btn btn-primary float-right touch6" id="closeFullScreen" style="margin-right: 5px;">전체화면 해제</button>
							<button type="button" class="btn btn-primary float-right touch6" id="openFullScreen" style="margin-right: 5px;">전체화면</button>
							-->
	                    </div>
					</div>
				</div>
				<div class="card" id="workOrderTableCard">
					<div id="workOrderScrollDiv" style="overflow:scroll; min-height:340px; max-height:680px;">
						<div class="table-responsive">
							<table id="workOrderTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width:80px">제품(기종)</th>
										<th style="min-width:45px">재질</th>
										<th style="min-width:140px">규격</th>
										<th style="min-width:120px">작지번호</th>
										<th style="min-width:50px">상태</th>
										<th style="min-width:100px">주재료</th>
										<th style="min-width:40px">불량 상태</th>	
										<th style="min-width:65px">생산<br> 작업자</th>
										<th style="min-width:38px">검사<br>상태</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
<!-- 					<button type="button" class="btn btn-primary float-right touch6" onclick="btnScrollBottom();" style="margin-bottom:5px;">▼</button> -->
				</div>
				
				<hr>
				 
				<!-- 작업지시 정보 끝 -->
				<div class="card-body col-sm-12" style="padding: 1px;">
					<!-- <h6>생산실적</h6> -->
				</div>
				
				<div class="col-md-12 matrl-bottom-list d-none" style="min-height:340px;">
					<!-- 
					<div>
						<label class="input-label-sm float-left touch6">바코드</label>
						<input type="text" class="form-control float-left touch6" id="barcodeNo" name="barcodeNo">
						<span class="float-left  mr-2">&nbsp;&nbsp;&nbsp;&nbsp;</span>
						<input type="text" class="form-control float-left touch6" style="border: 0px;" id="matrlCdText" name="matrlCdText" disabled>
						<button type="button" class="btn btn-primary float-left touch6" id="btnMatrlList" disabled>추가 투입자재</button>
						<button type="button" class="btn btn-primary float-right touch6" id="btnSave">저장</button>
						<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnDelete">라인삭제</button>
					</div>
					 -->
					<table class="table table-bordered" id="outputCardTable" style="padding-left:0px; padding-right:0px;">
						<thead class="thead-light">
						<tr>
							<th class="text-center" style="min-width:30px;">순번</th>
							<th class="text-center" style="min-width:70px;">엣지 검사일</th>
							<th class="text-center" style="min-width:120px;">주재료</th>
							<th class="text-center" style="min-width:150px;">생산전표번호</th>
							<th class="text-center" style="min-width:65px;">비전 불량수량</th>
							<!-- <th class="text-center" style="min-width:40px;">주야</th> -->
							<th class="text-center" style="min-width:40px;">검사담당</th>
							<th class="text-center" style="min-width:70px;">상태</th>
							<th class="text-center" style="min-width:50px;">생산 작업자</th>
						</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4" style="text-align: center">합계</td>
								<td id="visionEaSum" style="text-align: right">0</td>
								<td colspan="3"></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<div class="col-md-12 matrl-bottom-list" style="min-height:340px;">
					<table class="table table-bordered" id="outputCardTableSeq" style="padding-left:0px; padding-right:0px;">
						<thead class="thead-light">
						<tr>
							<th class="text-center" style="min-width:30px;">순번</th>
							<th class="text-center" style="min-width:70px;">외관 검사일</th>
							<th class="text-center" style="min-width:60px;">총 불량수량</th>				
							<th class="text-center" style="min-width:70px;">검사담당</th>
							<th class="text-center" style="min-width:60px;">주야구분</th>
			
						</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="" style="text-align: center">합계</td>
								<td></td>
								<td id="appearFaultySumSeq" style="text-align:right">0</td>
								<td></td>
								<td></td>
								
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<!-- 
			<div class="left-list left-sidebar" id="left-list" style="width:60%;">
				<div class="card">
					<div class="open-arrow" id="arrowLeft">
						<button id="left-width-btn" class="btn btn-primary input-sub-search" type="button">
							<i class="mdi mdi-arrow-left"></i>
						</button>
					</div>
					.table-responsive
					<div class="table-responsive">
						<table id="workOrderOutputSub" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 40px">검사일</th>
									<th style="min-width: 50px">설비명</th>
									<th style="min-width: 80px">규격</th>
									<th style="min-width: 100px">Lot No</th>
									<th style="min-width: 100px">생산 LotNo</th>
									<th style="min-width: 40px" class="text-center">검사량</th>
									<th style="min-width: 55px" class="text-center">샘플링수량</th>
									<th style="min-width: 50px" class="text-center">불량수량</th>
									<th style="min-width: 40px" class="text-center">불량률</th>
									<th style="min-width: 40px">검사자</th>
								</tr>
							</thead>
						</table>
					</div>
					/.table-responsive
				</div>
			</div>
			 -->
			<!-- /.left-list -->

			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width:35%;padding-top:0px;padding-bottom:0px;">
				<div class="card">
					<div class="card-body" style="padding-bottom:1px;padding-left: 0px;">
						<!-- 
						<div class="rightsidebar-close">
							<a href="javascript:void(0)" id="rightCardClose" class="closebtn float-right"><i class="mdi mdi-close"></i></a>
						</div>
						 -->
						<!-- 
						<button type="button" class="btn btn-primary float-left touch6" id="openFullScreen">전체화면</button>
						<button type="button" class="btn btn-primary float-left touch6" id="closeFullScreen">전체화면 해제</button>
						 -->
						 
		 				<div class="col-sm-12" style="display: flex;align-items: baseline;">
							 <div class="card-tab col-md-4">
								<ul class="nav nav-tabs card-header-tabs">
									<li class="nav-item">
										<a class="nav-link active show" data-toggle="tab" id="tabD">주간</a>
									</li>
									<li class="nav-item">
										<a class="nav-link" data-toggle="tab" id="tabN">야간</a>
									</li>
								</ul>
							</div>
							 
		 					<div class="col-md-8" style="display: flex;justify-content: flex-end;">
								<label class='mr-2' style="color: cornflowerblue;font-size: 18px;font-weight: 300;text-decoration: underline solid 1px;" id="workOrdNoTitle"></label>
								<button type="button" class="btn btn-primary float-right touch6" style="margin-right:5px;" id="btnAdd">등록</button>
								<button type="button" class="btn btn-primary float-right touch6" id="btnEdit">입력</button>
								<!-- <button type="button" class="btn btn-primary float-right touch6 d-none" id="btnAdd">등록</button> -->
								<button type="button" class="btn btn-danger float-left touch6 ml-1" id="btnDel">삭제</button>
							</div>
						</div>
					</div>
					
					<form id="form">
						<table class="table table-bordered">
							<colgroup>
								<col width="22%">
								<col width="28%">
								<col width="22%">
								<col width="28%">
							</colgroup>
							<!-- 
							<tr>
								<th class="touch6">작업지시 번호</th>
								<td><input type="text" class="form-control touch6" id="workOrdNo" name="workOrdNo" disabled></td>
								<th class="touch6">주재료(LotNo)</th>
								<td><input type="text" class="form-control touch6" id="lotNo" name="lotNo" disabled></td>
							</tr>
							<tr>
							<th class="touch6">제품(기종)</th>
								<td><input type="text" class="form-control touch6" id="goodsNm" name="goodsNm" disabled></td>
								<th class="touch6">재질</th>
								<td><input type="text" class="form-control touch6" id="qutyNm" name="qutyNm" disabled></td>
							</tr>
							 -->
							<tr>
								<th class="touch6 d-none">생산전표일자</th>
	                            <td class="d-none"><input type="date" class="form-control touch6" id="workOrdDate"	name="workOrdDate" disabled></td>
	                            
	                            <th class="touch6">검사일</th>
	                            <td><input type="date" class="form-control touch6" id="edgeInspctDate" name="edgeInspctDate" disabled></td>
	                            
	                            <th class="touch6">생산 주/야</th>
								<td><select class="custom-select custom-select-lg touch6" id="gubun" style="height:30px;color:red;" disabled></select></td>
							</tr>
							
							<tr>
								<th class="touch6">검사담당</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" id="pIdx">
										<input type="hidden" id="userNumber" name="userNumber">
										<input type="text" class="form-control touch6" id="userNm" name="userNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search-md" id="searchUser" onClick="selectPreWorkCharger()" disabled>
											<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
										</button>
									</div>
								</td>
								
								<th class="touch6 d-none">Sample 수량</th>
								<td class="d-none"><select class="custom-select custom-select-lg touch6" id="edgeSampleCnt" disabled></select></td>
								
								<th class="touch6">비전 불량수량</th>
								<td><input maxlength="7" type="text" class="form-control number text-right touch6" id="edgeFaultyCnt" name="edgeFaultyCnt" min="0" max="99999" disabled></td>
							</tr>
							
							<tr class="d-none">
								<th colspan="3" class="touch6">엣지홀 불량(측정치)</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeRollFaultySize" name="edgeRollFaultySize" style="max-width: 100%" disabled></td>
							</tr>
							<tr class="d-none">
								<th colspan="3" class="touch6">엣지기포 불량(측정치)</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeSymbolFaultySize" name="edgeSymbolFaultySize" style="max-width: 100%" disabled></td>
							</tr>
							<tr class="d-none">
								<th colspan="3" class="touch6">Bur 불량(측정치)</th>
								<td><input type="number" maxlength="7" step="0.01" min=0 max=100 class="form-control number-float2 touch6" id="edgeBurFaultySize" name="edgeBurFaultySize" style="max-width: 100%" disabled></td>
							</tr>
							
							<tr>
							 	<th class="" id="badTotalName1">...</th>
								<td id="badTotal1" style="text-align: right">0</td>
								<th class="" id="badTotalName2">...</th>
								<td id="badTotal2" style="text-align: right">0</td>
							</tr>
							
						</table>
					</form>
				</div>
				<!--// 등록, 수정 -->
				
				<!--엣지 불량 테이블 -->
				<div class="row col-sm-12">
					<div class="card-header card-tab col-md-9">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="tab1">...</a></li>
							<li class="nav-item d-none" style="display:none"><a class="nav-link" data-toggle="tab" id="tab2">...</a></li>
						</ul>
					</div>
				</div>
				
				<!-- (대) 불량 1 -->
				<div id="faultyDiv1">
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
						<tbody id="faultyTbody1">
							
						</tbody>
					</table>
				</div>
				<!-- (대) 불량 1 끝 -->
				<!-- (대) 불량 2 -->
				<div id="faultyDiv2" class="d-none">
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
						<tbody id="faultyTbody2">
							
						</tbody>
					</table>
				</div>
				<!-- (대) 불량 2 끝 -->
						
				<button type="button" class="btn btn-primary float-right mr-1 touch6" id="btnSave" disabled>저장</button>
				
					<br>
					<br>
					<div class="col-12 num_keypad">
						<table class="table table-bordered" >                                
							<tr>
								<td id="number5" style="height:1px; width:100px;">5</td>
								<td id="number6" style="height:1px; width:100px;">6</td>
								<td id="number7" style="height:1px; width:100px;">7</td>
								<td id="number8" style="height:1px; width:100px;">8</td>
								<td id="number9" style="height:1px; width:100px;">9</td>
								<td id="backSpace" style="height:1px; width:100px;">←<br>(BS)</td>
							</tr>
							<tr>
								<td id="number0" style="height:59px; width:100px;">0</td>
								<td id="number1" style="height:59px; width:100px;">1</td>
								<td id="number2" style="height:59px; width:100px;">2</td>
								<td id="number3" style="height:59px; width:100px;">3</td>
								<td id="number4" style="height:59px; width:100px;">4</td>
								<td id="enter" style="height:59px; width:100px;">ENT</td>
							</tr>
						</table>
					</div>
				
			</div>
			<!-- .right-sidebar -->
		</div>
		<!-- /.row -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 담당자조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="userPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width: 1300px">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="userPopUpLabel">검사 담당</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body" style="overflow: auto;">
				<hr class="text-secondary">
				<table id="userPopUpTable" class="table table-bordered">
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
<!-- 담당자조회 모달 종료-->
<!-- 입력 취소 확인 모달 시작 -->
<div class="modal fade" id="closePopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">진행정보 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>입력하던 정보가 있습니다. 닫으시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="btnCloseCheck" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				<button type="button" class="btn btn btn-secondary" id="btnCloseCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 입력 취소 모달 끝 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "60%"
			}, 200);
			$("#myrSidenav").animate({
				width : "39%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'qmsc21402050';
	let currentHref = 'qmsc2140';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","엣지검사");

	var upperThanHunnit = 0;
	
  	//공통코드 처리 시작
	var edgeBigNameCd=new Array();	//엣지검사 대분류
    <c:forEach items="${edgeBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		edgeBigNameCd.push(json);
    </c:forEach>
  	
	var systemCommonCode=new Array();	//엣지검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		systemCommonCode.push(json);
    </c:forEach>
    
    var sampleCountCode=new Array();
    <c:forEach items="${sampleCount}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		sampleCountCode.push(json);
	</c:forEach>
	
    var ordGubunCode = new Array(); // 주야구분
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>
    
    var workStatusCode = new Array(); // 검사상태
    <c:forEach items="${workStatusCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		workStatusCode.push(json);
    </c:forEach>    
	//공통코드 처리 종료
	
	
	let userName = "${userNm}";
	let userNumber = "${userNumber}";
	let factoryCode = "<%=factoryCode%>";
	
	$('#openFullScreen').css('margin-right','5px');
	$('#closeFullScreen').css('margin-right','5px');
	$('#btnAdd').css('margin-right','5px');
	$('#btnEdit').css('margin-right','5px');

	$('#tab1').text(edgeBigNameCd[0].baseCdNm);
	$('#tab2').text(edgeBigNameCd[1].baseCdNm);
	
	if( factoryCode != "003" ) {
		$($('#tab2')[0].parentNode).removeClass('d-none');
		$($('#tab2')[0].parentNode).attr('style', '');
	}
		
	$('#badTotalName1').text(edgeBigNameCd[0].baseCdNm);
	$('#badTotalName2').text(edgeBigNameCd[1].baseCdNm);

	//전체화면(f11)감지
    $(window).resize(function () {
        if ((screen.availHeight || screen.height - 30) <= window.innerHeight) {
        	$('#mainCard').css('height','915px');
        	//$('#rightList').css('min-height','915px');
        }
        else {
        	$('#mainCard').css('height','775px');
        	//$('#rightList').css('min-height','765px');
        }
    });

    metalFaultyHdCreate();
    filmFaultyHdCreate();

    var userNm = "<%=userNm%>";
	var serverDate = "${serverDate}"	//서버 날짜
	var chooseDate =  serverDate;		//선택 날짜
	var sideView = null;
	var readCheck = true;	//작지 클릭여부 상태갑
	$('#btnSave').attr('disabled', true);
	$('#btnedit').attr('disabled', true);
	selectBoxAppend(sampleCountCode, "edgeSampleCnt", "" , "2");
	selectBoxAppend(ordGubunCode, "gubun", "" , "");
	$('#ordDate').val(serverDate);
	
	var ordDate 		= serverDate;
	var equipCd 		= ' ';	//공백으로 mapper조건탈 수 있게 적용
	var workOrdNo 		= null;
	var workOrdNoScan 	= null;
	var lotNo 			= null;
	var capa 			= null;
	var mainMatrlCd 	= null;

	var sum = 0;
	var temp = "";
	
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
        ordering: false,
        processing: true,
        autoWidth: false,
        lengthChange: false,
        searching: false,
        pageLength: 11,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            async: false,
            data: {
            	'menuAuth'		:	menuAuth,
            	//'equipGroup'	:	function() { return equipGroup; },
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
	    },
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
    });
	
	//selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");
	
	$('#equipCodeAdmTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			//equipNm = "";
		} else {
			$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			equipCd = equipCodeAdmTable.row(this).data().equipCd;
			ordDate =  $('#ordDate').val();
			$('#workOrderTable').DataTable().ajax.reload( function () {});
			$('#outputCardTableSeq').DataTable().clear().draw();
			$('#workOrdNoTitle').text('');
			workOrdNo 		= null;
			workOrdNoScan 	= null;
			lotNo 			= null;
			mainMatrlCd	 	= null;
			capa 			= null;
			seq = null;
			viewDisabled(true);
			viewValueClear();
		}
    });

    $.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
        language: lang_kor,
        paging: false,
        info: true,
        ordering: false,
        processing: true,
        autoWidth: false,
        scrollX : false,
        searching: false,
        lengthChange: false,
        ajax: {
        	url: '<c:url value="/po/workOrderList_qmsc3050"/>',
            type: 'GET',
            data: {
            	'menuAuth'	: 	menuAuth,
             	'equipCd'	:	function() { return equipCd; }, 
             	'workOrdNo'	:	function() { return workOrdNoScan; }, 
         		'ordDate'	:	function() { return ordDate.replace(/-/g, ''); }
            },
		},
		columns: [
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: 'workOrdNo',
	       		render: function(data, type, row, meta) {
    				html = '';
	           		if( row['ordGubun'] == 'D') {
	           			html = '<p style="color:red; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	           		} else if( row['ordGubun'] == 'N') {
	               		html = '<p style="color:blue; font-weight:bold; margin-bottom:0px;">' + row['workOrdNo'] + '</p>';
	               	}
	           		return html;
	       		}
			},
			{ data: 'workStatusNm'		},
			{ data: 'lotNo'				},
			{ data: 'faultyStatusNm'	},
			{ data: 'workerIdNm',
	       		render: function(data, type, row, meta) {
    				var html = '<label>'+data+' ('+row['workTeamNm'] +'조)'+'</label>';
	           		return html;
	       		}
			},
			{ data: 'workInspectionStatusNm',
	       		render: function(data, type, row, meta) {
	       			if(data != null && data != ''){
	       				return data;
	       			}else{
	       				return '-';
	       			}
	       		}
			}
		],
		columnDefs: [
			{ targets: "_all", className: 'text-center' },
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
			$('#workOrderTable_paginate').html("");
			$('#workOrderTable_info').html("");
		}
    });

	/*//페이지가 다 끝난 후 실행
	workOrderTable.on('draw.dt', function(){
		$('#workOrderTable').DataTable().clear().draw();
	});*/

    //작지 조회
    $('#btnWorkOrdRetv').on('click', function() {
    	ordDate 		=  $('#ordDate').val();
    	workOrdNo 		= null;
    	workOrdNoScan 	= null;
    	ordLotNo 		= null;
    	mainMatrlCd 	= null;
    	subWorkStatusCd = null;
    	seq = null;
    	$("#btnSave").attr("disabled", true);
		$('#workOrdNoTitle').text('');
		$('#workOrdNoScan').val('');
		$('#workOrdNoScan').focus();
    	viewDisabled(true);
		viewValueClear();
    	$('#workOrderTable').DataTable().ajax.reload( function () {});
    	$('#outputCardTableSeq').DataTable().clear().draw();
    });

    var workerId		= '';	//작업자 ID 값
    var workerTeamCd	= '';	//작업조
    let workStatusCd	= '';
    let sudelGubunja = '1';
    
	$('#workOrderTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			//workOrdNo = "";
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			workOrdNo 		= workOrderTable.row(this).data().workOrdNo;
			lotNo 			= workOrderTable.row(this).data().lotNo;
			mainMatrlCd	 	= workOrderTable.row(this).data().matrlCd;
			capa 			= parseInt(workOrderTable.row(this).data().capa) / 2;
			equipCd			= workOrderTable.row(this).data().equipCd;
			workerId		= workOrderTable.row(this).data().workerId;
			workerTeamCd	= workOrderTable.row(this).data().workTeamCd;
			workStatusCd	= workOrderTable.row(this).data().workStatusCd;
			seq = '';
			viewDisabled(true);
			viewValueClear();
			sudelGubunja = '1';
			//$('#outputCardTable').DataTable().ajax.reload( function () {});
			/* sudel(workOrderTable.row(this).data().ordGubun, true); */
			
			if(factoryCode != "003") {
				if(workOrderTable.row(this).data().ordGubun == 'N'){			
					$('#tabN').trigger('click');
				} else{
					$('#tabD').trigger('click');
				}
			} else {
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
					$('#tabN').trigger('click');
					
				//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
				} else if (secondDiff >= 0 && secondDiff <= 25200) {
					$('#tabN').trigger('click');

				//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
				} else {
					$('#tabD').trigger('click');
				}
			}
			
			$('#outputCardTableSeq').DataTable().ajax.reload( function () {
				if($('#outputCardTableSeq').DataTable().data().count() != 0 ){
					$('#outputCardTableSeq tbody tr').eq(0).click();
				}
			});	
		}
    });

	//생산실적상세 테이블
    let outputCardTableSeq = $('#outputCardTableSeq').DataTable({
		language: lang_kor,
		paging: false,
		info: false,
		ordering: true,
		reordering: false,
		processing: true,
		lengthChange: false,
		searching: false,
		autoWidth: false,
		pageLength: 10,
        ajax: {
			url: '<c:url value="/qm/readEdgeGoodsFaultyAdmCodeList"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'			: 	menuAuth,
				'workOrdNo'			:	function() { return workOrdNo; },
				//'ordLotNo'			:	function() { return ordLotNo;}
			
			},
	    },
	    //rowId: '',
		columns: [
			{ data: 'seq' },
			{ data: 'faultyRegDate',
				render: function(data, type, row) {
					if(data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
				}
			},

			{ data: 'totalEdgeFaultyCnt',
				render: function(data, type, row) {
					return addCommas(data);
				}
			},
			{ data: 'inspctChargerNm' },
			{ data: 'dayNightCd' },

		],
	    columnDefs: [
	    	{ targets: [0,1,3,4], className: 'text-center' },
			{ targets: [2], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [2], className: 'text-right sum' },
		
		],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function () {
			var appearFaultySumSeq 	= $('#outputCardTableSeq').DataTable().column(2, {page: 'all'} ).data().sum();



			$('#appearFaultySumSeq').text(addCommas(appearFaultySumSeq));			
		},
		rowCallback: function (row, data) {
			
		},
	});


	var ordLotNo 		= null;
	var subWorkStatusCd = null;
	var workOrdSeq 		= null;
	var seq = null;
	
	$('#outputCardTableSeq tbody').on('click', 'tr', function () {
		if ($(this).find('td').eq(0).text() == '합계') {
			return false;
        }
        if ($(this).find('td').eq(0).text() == "데이터가 없습니다.") {
			return false;
		}
        
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
		} else {
			$('#outputCardTableSeq').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			let dayNightGubun = outputCardTableSeq.row(this).data().dayNightCd;
			ordLotNo	= outputCardTableSeq.row(this).data().ordLotNo;
			//workOrdSeq	= outputCardTableSeq.row(this).data().workOrdSeq;
			seq = outputCardTableSeq.row(this).data().seq;
			$('#workOrdNoTitle').text(outputCardTableSeq.row(this).data().workOrdNo);
			//viewDisabled(true);
			sudelGubunja = '2';		
			if(dayNightGubun == 'N'){
				$("#tabN").trigger("click");
			} else if(dayNightGubun == 'D'){
				$("#tabD").trigger("click");
			}
			
			
			$('#workOrdNoTitle').text(outputCardTableSeq.row(this).data().workOrdNo);
			$('#my-spinner').show();
			
			sudel(outputCardTableSeq.row(this).data().dayNightCd, true);
			$('#btnEdit').attr('disabled', false);
			$('#my-spinner').show();
			
			//scanWorkOrdOutputSubOrdLotNo();
			
		}
    });

	function scanWorkOrdOutputSubOrdLotNo() {
		$.ajax({
			url: '<c:url value="qm/scanWorkOrdOutputSubOrdLotNo"/>',
			type: 'GET',
			//async: false,
			data: {
				'menuAuth'	 	: 		menuAuth,
				'ordLotNo'		:		function() { return ordLotNo; },
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					if (data == null) {
						toastr.warning("검색 결과가 없습니다.");
						viewClear();
					} else {
						$('#edgeInspctDate').val(moment(data.edgeInspctDate).format("YYYY-MM-DD"));
						$('#workOrdDate').val(moment(data.workOrdDate).format("YYYY-MM-DD"));
						$('#userNumber').val(data.edgeInspctCharger);
						$('#userNm').val(data.edgeInspctChargerNm);
						$('#edgeSampleCnt').val(data.edgeSampleCnt);
						$('#gubun').val(data.gubun);
						$('#edgeFaultyCnt').val(addCommas(data.edgeFaultyCnt));
						$('#edgeRollFaultySize').val(data.edgeRollFaultySize);
						$('#edgeSymbolFaultySize').val(data.edgeSymbolFaultySize);
						$('#edgeBurFaultySize').val(data.edgeBurFaultySize);
						$('#btnSave').attr('disabled', true);
						$('#btnEdit').attr('disabled', false);
						$('#btnDel').attr('disabled', false);
					}
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
	        complete:function(){

				//엣지검사 상세조회 (엣지불량 TB Read) 코드화
 		        $.ajax({
 		        	url: '<c:url value="/qm/readEdgeGoodsFaultyAdmCode"/>',
 		            type: 'GET',
 		            data: {
 		            	'menuAuth'	 	: 		menuAuth,
 		            	//'workOrdNo'		:		workOrdNo,		//작업지시
 		            	'ordLotNo'		:		ordLotNo,		//생산LorNo
 		            },
 		            success: function (res) {
 		                let data = res.data;
 		                if (res.result == 'ok') {
 		                	$(".num_only").val("0");
 		                	var i = 0;
 		                	$.each($('.num_only'), function(index1,item1) {
 		                		if(data.length > i) {
 		                			$.each(data, function(index2,item2) {
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
 		 				$('#btnSave').attr('disabled', true);
  		 				viewDisabled(true);
 		 				totalDefectiveChange();
 						$('#my-spinner').hide();	
 						$('#btnEdit').attr('disabled', false);
						$('#btnDel').attr('disabled', false); 						
 					}
 				});
 				//엣지검사 상세조회 (엣지불량 TB Read) 코드화
			}
		});
	}





	//작지 테이블 클릭시
	function sudel( dayNightCd, viewBoolean ) {
		//엣지검사 상세조회 (엣지불량 TB Read) 코드화
        $.ajax({
        	url: '<c:url value="/qm/readTrayEdgeGoodsFaultyAdmCode_F2"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'workOrdNo'		:		workOrdNo,
            	'dayNightCd'	:		dayNightCd,
            	'seq'			:		seq,		//작업지시
            },
            success: function (res) {
                let data = res.data;
                if (res.result == 'ok') {
                	$(".num_only").val("0");
                	var i = 0;
                	$.each($('.num_only'), function(index1,item1) {
                		if(data.length > i) {
                			$.each(data, function(index2,item2) {
	                			if ($(item1).parent().find('input[type=hidden]').val() == item2.minorCd) {
	                				$(item1).parent().find('input[type=hidden][name=2]').val(parseInt(item2.faultyCnt) + parseInt($(item1).val()));
	                				$(item1).val(parseInt(item2.faultyCnt) + parseInt($(item1).val()));
		                			i++;
 		                		}
		                	});      		
                		}
  					});

                	if( data != "" ) {
                		$('#pIdx').val(data[0].pidx);
						$('#gubun').val(data[0].dayNightCd			== ""	|| data[0].dayNightCd		== null ? dayNightCd	: data[0].dayNightCd );
						$('#workOrdDate').val(data[0].workOrdDate	== ""	|| data[0].workOrdDate		== null ? ordDate		: moment(data[0].workOrdDate).format('YYYY-MM-DD') );
						$('#userNumber').val(data[0].inspctCharger	== ""	|| data[0].inspctCharger	== null ? userNumber	: data[0].inspctCharger );
						$('#userNm').val(data[0].inspctChargerNm	== "" 	|| data[0].inspctChargerNm	== null ? userNm		: data[0].inspctChargerNm );
						$('#edgeInspctDate').val( $('#workOrdDate').val() );
	                } else {
	                	$('#pIdx').val("");
						$('#edgeFaultyCnt').val(0);
						$('#gubun').val(dayNightCd);
						$('#workOrdDate').val("");
						$('#edgeInspctDate').val(ordDate);
						$('#userNumber').val(userNumber);
						$('#userNm').val(userNm);
					}
  						    	   							 		                              	
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
 				$('#btnSave').attr('disabled', viewBoolean);
 				 viewDisabled(true);
 				totalDefectiveChange();
 				$('#appearOutputCnt').attr('disabled', true);
 				if(sudelGubunja == '1'){
					$('.num_only').val("0");
				}
				$('#my-spinner').hide();	 						
			}
		});
		//엣지검사 상세조회 (엣지불량 TB Read) 코드화
	}


	
    
	//저장 버튼 클릭시
	$('#btnSave').on('click', function() {
		if (equipCd == null || equipCd == '' || equipCd == ' ') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (capa == null || capa == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (lotNo == null || lotNo == '') {
			toastr.warning('주재료를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (mainMatrlCd == null || mainMatrlCd == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (!$.trim($('#userNumber').val())) {
			toastr.warning('검사담당을 검색하세요.');
			$('#searchUser').focus();
			return false;
		}
		if (!$.trim($('#edgeFaultyCnt').val())) {
			toastr.warning('불량수량을 입력하세요.');
			$('#edgeFaultyCnt').select();
			return false;
		}
		/* if (!$.trim($('#edgeSampleCnt').val())) {
			toastr.warning('Sample 수량을 선택해주세요.');
			$('#edgeSampleCnt').focus();
			return false;
		} */
		//if ( parseInt($('#edgeSampleCnt option:selected').val()) < parseInt($('#edgeFaultyCnt').val()) ) {
		//    toastr.warning('불량수량이 Sample수량보다 클 수 없습니다.');
		//    $('#edgeFaultyCnt').select();
		//    return false;
		//}
		//if ( parseInt($('#outputCnt').val().replace(/,/g, '')) < parseInt($('#edgeSampleCnt').val().replace(/,/g, '')) ) {
		//    toastr.warning('Sample수량이 생산수량보다 많습니다 확인해주세요.');
		//    $('#edgeSampleCnt').select();
		//    return false;
		//}
		//if ( parseInt($('#outputCnt').val().replace(/,/g, '')) < parseInt($('#edgeFaultyCnt').val().replace(/,/g, '')) ) {
		//    toastr.warning('불량수량이 생산수량보다 많습니다. 확인해주세요!');
		//    $('#edgeFaultyCnt').select();
		//    return false;
		//}
		/*if ( $('#edgeFaultyCnt').val() == '0' || $('#edgeFaultyCnt').val() == '00') {
			toastr.warning('비전 불량수량을 입력해주세요!');
			$('#edgeFaultyCnt').select();
			return false;
		}*/
		if ( !$.trim($('#edgeRollFaultySize').val()) ) {
			toastr.warning('엣지홀 불량에 0이상 입력해주세요.');
			$('#edgeRollFaultySize').select();
			return false;
		}
		if ( !$.trim($('#edgeSymbolFaultySize').val()) ) {
			toastr.warning('엣지기호 불량에 0이상 입력해주세요.');
			$('#edgeSymbolFaultySize').select();
			return false;
		}
		if ( !$.trim($('#edgeBurFaultySize').val()) ) {
			toastr.warning('Bur 불량에 0이상 입력해주세요.');
			$('#edgeBurFaultySize').select();
			return false;
		}


		if(factoryCode != '003'){
			$.each($('#faultyTbody1 .num_only'), function(index1,item1) {
				if($(this).val().replace(/,/g,"") != $(item1).parent().find('input[type=hidden][name=2]').val()){
					if(leftZeroRemove($(this).val()).length > 2){
						upperThanHunnit++;
					}
				}
			});
			$.each($('#faultyTbody2 .num_only'), function(index1,item1) {
				if($(this).val().replace(/,/g,"") != $(item1).parent().find('input[type=hidden][name=2]').val()){
					if(leftZeroRemove($(this).val()).length > 2){
						upperThanHunnit++;
					}
				}
			});
			if(upperThanHunnit>0){
				$('#numberUpHundCheckModal').modal('show'); 
				upperThanHunnit = 0;
			} else saveFaulty();
		} else {
			saveFaulty();
		}
	});

	//확인 모달 저장 버튼 클릭 시
	$('#btnRealSave').on('click', function(){
		saveFaulty();
	});
	
	//저장 기능
	function saveFaulty(){
        var numCheck = false;
        
		$.each($('input.num_only'), function(index,item) {
			if (!$.trim($(this).val())) {
				$(this).focus();
				numCheck = true;
				return false;
			}
		});
		
		if (numCheck) {
			toastr.warning('잘못입력된 불량수량이 존재합니다<br>각 불량항목들을 확인해주세요!');
			return false;
		}
		
		// 엣지양품수량 >= 불량수량 이면 수행		
        faultyCntCheck();

//         console.log(sum);
		$('#my-spinner').show();

		var dataArray = new Array();
		var edgeOutputCnt = 0;

		//불량 1
		$.each($('#faultyTbody1 .num_only'), function() {
			if($(this).val() != '0' && $(this).val() != '00') {
				var rowData = new Object();
				rowData.pIdx	 		= $('#pIdx').val();
				rowData.workOrdNo 				= workOrdNo;											//	작업지시번호
				rowData.workStatusCd			= workStatusCd;
				rowData.lotNo 					= lotNo;												//
				rowData.gubun 					= $('#gubun').val();									//
				rowData.equipCd 				= equipCd;												//	설비명?
				rowData.ordDate 				= $('#ordDate').val().replace(/-/g,"");					//
				rowData.mainMatrlCd 			= mainMatrlCd;											//	
				rowData.ordLotNo 				= ordLotNo;												//	생산 LotNo
				rowData.targetCnt 				= capa;													//
				rowData.workOrdDate 			= $('#workOrdDate').val().replace(/-/g,"");				//	생산 전표일자
				rowData.edgeInspctDate			= $('#edgeInspctDate').val().replace(/-/g,"");			//	엣지검사일자
				rowData.edgeInspctCharger		= $('#userNumber').val();								//	검사담당(사번코드)
				rowData.edgeSampleCnt			= $('#edgeSampleCnt option:selected').val();			//	샘플 수량
				rowData.mainWorkChargr 			= workerId;												//	작업자
				rowData.teamCd 					= workerTeamCd;											//	작업조
				
// 				rowData.edgeFaultyCnt 			= $('#edgeFaultyCnt').val().replace(/,/g, '');			//	비전 불량 수량
				rowData.edgeFaultyCnt 			= sum;													//	비전 불량 수량
				
				rowData.edgeRollFaultySize 		= $('#edgeRollFaultySize').val();						//	엣지홀 불량 치수
				rowData.edgeSymbolFaultySize	= $('#edgeSymbolFaultySize').val();						//	엣지기호 불량 치수
				rowData.edgeBurFaultySize 		= $('#edgeBurFaultySize').val();						//	Bur불량 치수
				
				rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");			//	불량 등록일
				rowData.majorCd 				= '001';												//	대분류 코드
				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
				rowData.seq 			= seq;
				dataArray.push(rowData);
			}
		});

		//불량 2
		$.each($('#faultyTbody2 .num_only'), function() {
			if($(this).val() != '0' && $(this).val() != '00'){	
				var rowData = new Object();
				rowData.pIdx	 		= $('#pIdx').val();
				rowData.workOrdNo 				= workOrdNo;											//	작업지시번호
				rowData.workStatusCd			= workStatusCd;
				rowData.lotNo 					= lotNo;												//
				rowData.gubun 					= $('#gubun').val();									//
				rowData.equipCd 				= equipCd;												//	설비명?
				rowData.ordDate 				= $('#ordDate').val().replace(/-/g,"");					//
				rowData.mainMatrlCd 			= mainMatrlCd;											//	
				rowData.ordLotNo 				= ordLotNo;												//	생산 LotNo
				rowData.targetCnt 				= capa;													//
				rowData.workOrdDate 			= $('#workOrdDate').val().replace(/-/g,"");				//	생산 전표일자
				rowData.edgeInspctDate			= $('#edgeInspctDate').val().replace(/-/g,"");			//	엣지검사일자
				rowData.edgeInspctCharger		= $('#userNumber').val();								//	검사담당(사번코드)
				rowData.edgeSampleCnt			= $('#edgeSampleCnt option:selected').val();			//	샘플 수량
				rowData.mainWorkChargr 			= workerId;												//	작업자
				rowData.teamCd 					= workerTeamCd;											//	작업조
				
// 				rowData.edgeFaultyCnt 			= $('#edgeFaultyCnt').val().replace(/,/g, '');			//	비전 불량 수량
				rowData.edgeFaultyCnt 			= sum;													//	비전 불량 수량
				
				rowData.edgeRollFaultySize 		= $('#edgeRollFaultySize').val();						//	엣지홀 불량 치수
				rowData.edgeSymbolFaultySize	= $('#edgeSymbolFaultySize').val();						//	엣지기호 불량 치수
				rowData.edgeBurFaultySize 		= $('#edgeBurFaultySize').val();						//	Bur불량 치수
				
				rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");			//	불량 등록일
				rowData.majorCd 				= '002';												//	대분류 코드
				rowData.minorCd 				= $(this).parent().find('input[type=hidden]').val();	//	소분류코드
				rowData.faultyCnt 				= $(this).val().replace(/,/g,"");						//	불량 개수
				rowData.seq 			= seq;
				dataArray.push(rowData);
			}
		});

		if (dataArray.length == 0) {
			toastr.warning('불량 값을 입력해주세요.');
			$('#my-spinner').hide();
			return false;
		}

		if (dataArray.length == 0) {
			var rowData = new Object();
			rowData.pIdx	 		= $('#pIdx').val();
			rowData.workOrdNo 				= workOrdNo;											//	작업지시번호
			rowData.workStatusCd			= workStatusCd;
			rowData.lotNo 					= lotNo;												//
			rowData.gubun 					= $('#gubun').val();									//
			rowData.equipCd 				= equipCd;												//	설비명?
			rowData.ordDate 				= $('#ordDate').val().replace(/-/g,"");					//
			rowData.mainMatrlCd 			= mainMatrlCd;											//	
			rowData.ordLotNo 				= ordLotNo;												//	생산 LotNo
			rowData.targetCnt 				= capa;													//
			rowData.workOrdDate 			= $('#workOrdDate').val().replace(/-/g,"");				//	생산 전표일자
			rowData.edgeInspctDate			= $('#edgeInspctDate').val().replace(/-/g,"");			//	엣지검사일자
			rowData.edgeInspctCharger		= $('#userNumber').val();								//	검사담당(사번코드)
			rowData.edgeSampleCnt			= $('#edgeSampleCnt option:selected').val();			//	샘플 수량
			rowData.mainWorkChargr 			= workerId;												//	작업자
			rowData.teamCd 					= workerTeamCd;											//	작업조
			
			rowData.edgeFaultyCnt 			= '0';													//	비전 불량 수량
			
			rowData.edgeRollFaultySize 		= $('#edgeRollFaultySize').val();						//	엣지홀 불량 치수
			rowData.edgeSymbolFaultySize	= $('#edgeSymbolFaultySize').val();						//	엣지기호 불량 치수
			rowData.edgeBurFaultySize 		= $('#edgeBurFaultySize').val();						//	Bur불량 치수
			
			rowData.faultyRegDate 			= $('#edgeInspctDate').val().replace(/-/g,"");			//	불량 등록일
			rowData.majorCd 				= '001';												//	대분류 코드
			rowData.minorCd 				= '001';												//	소분류코드
			rowData.faultyCnt 				= '0';													//	불량 개수
			rowData.seq 			= seq;
			dataArray.push(rowData);
		}


// 		console.log(dataArray);
		
		var url = null;
 		if (sideView == "add") {
			url = '<c:url value="/qm/edgeCheckInsert_F2"/>';
 		} else if ( sideView == "edit" ){
 			url = '<c:url value="/qm/edgeCheckUpdate_F2"/>';		//1공장, 공장 공통
 		}
		
		/*$.ajax({
			url: url,
			type: 'POST',
			data: {
				'menuAuth'	 			: 		menuAuth,
				'equipCd'				:		function() { return equipCd; },
				'workOrdNo'				:		function() { return workOrdNo; },
				'ordLotNo'				:		function() { return ordLotNo; },
				'lotNo'					:		function() { return lotNo; },
				'mainMatrlCd'			:		function() { return mainMatrlCd; },
				'targetCnt'				:		function() { return capa; },
				'ordDate'				:		$('#ordDate').val().replace(/-/g,""),			//작업지시일
				'workOrdDate'			:		$('#workOrdDate').val().replace(/-/g,""),		//전표번호일자
				'edgeInspctDate'		:		$('#edgeInspctDate').val().replace(/-/g,""),	//엣지검사일자
				'edgeInspctCharger'		:		$('#userNumber').val(),							//검사담당(사번코드)
				'edgeSampleCnt'			:		$('#edgeSampleCnt option:selected').val(),		//샘플 수량
				'gubun'					:		$('#gubun').val(),
				'edgeFaultyCnt'			:		$('#edgeFaultyCnt').val().replace(/,/g, ''),	//불량 수량
				'edgeRollFaultySize'	:		$('#edgeRollFaultySize').val(),					//엣지홀 불량 치수
				'edgeSymbolFaultySize'	:		$('#edgeSymbolFaultySize').val(),				//엣지기호 불량 치수
				'edgeBurFaultySize'		:		$('#edgeBurFaultySize').val(),					//Bur불량 치수
			},
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {
					viewDisabled(true);
					$('#btnSave').attr('disabled', true);
					$('#outputCardTable').DataTable().ajax.reload();
					toastr.success(res.message);
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete:function(){
				totalDefectiveChange();
				//if ($('#subWorkStatusCd').val() == 'A') {
				//	toastr.warning('!','외관검사도 수정해 주세요', {timeOut: 5000});
				//}
				readCheck = false;
				$('#my-spinner').hide();
			}
		});*/


		$.ajax({
			url: url,
			type: 'POST',
			data: JSON.stringify(dataArray),
			dataType:"json",
			contentType : "application/json; charset=UTF-8",		                                                                                    				
			success: function (res) {                                                                  				
				let data = res.data;
				if(res.result == 'ok') {
					viewDisabled(true);
					$('#btnSave').attr('disabled', true);
					
					
					/* let rows 	= workOrderTable.rows('.selected').indexes();
	       			let index	= $('#workOrderTable').DataTable().row(rows).index();
	       			$('#workOrderTable').DataTable().ajax.reload(function(){
	       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
		       		});
	       			let rows2 	= outputCardTableSeq.rows('.selected').indexes();
	       			let index2	= $('#outputCardTableSeq').DataTable().row(rows2).index();
	       			$('#outputCardTableSeq').DataTable().ajax.reload(function(){
	       				$('#outputCardTableSeq tbody tr').eq(index2).addClass('selected');
		       		}); */
					toastr.success(res.message);
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
				$('.num_only').attr('disabled', true);
			},
			complete:function(){
				totalDefectiveChange();
				//if ($('#subWorkStatusCd').val() == 'A') {
				//	toastr.warning('!','외관검사도 수정해 주세요', {timeOut: 5000});
				//}
				
				let rows 	= workOrderTable.rows('.selected').indexes();
       			let index	= $('#workOrderTable').DataTable().row(rows).index();
       			$('#workOrderTable').DataTable().ajax.reload(function(){
       				$('#workOrderTable tbody tr').eq(index).click();
       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
	       		});
	       			
				readCheck = false;
				sudel($('#gubun').val(), true);
				$('#btnEdit').attr('disabled', false);
				if(factoryCode != '003'){
					$('#numberUpHundCheckModal').modal('hide'); 
				}
				$('#my-spinner').hide();
			}
		});
	}

	//등록 버튼 클릭시
	$('#btnAdd').on('click', function() {
		
		/*if(){
			$('#stateCheckPopupModal').modal({backdrop: 'static'});
			$('#stateCheckPopupModal').modal('show');
		}*/
		
		if (equipCd == null || equipCd == '' || equipCd == ' ') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (capa == null || capa == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (lotNo == null || lotNo == '') {
			toastr.warning('주재료를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (mainMatrlCd == null || mainMatrlCd == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		
		//검사 진행
		$.ajax({
			url : '<c:url value="/qm/workStatusCheckList"/>',
			type : 'POST',
			data : {
				'menuAuth'	: 	menuAuth,
                'equipCd'	:	function() { return equipCd; 					}, 
                'workOrdNo'	:	function() { return workOrdNo; 					}, 
            	'ordDate'	:	function() { return ordDate.replace(/-/g, '');	}
			},
			success : function(res) {
				let data = res.result;
				if (res.result == 'ok') {
					/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡ등록 진행ㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
					
					viewDisabled(false);
					//viewValueClear();
					$("#btnEdit").attr("disabled", true);
					$("#btnSave").attr("disabled", false);
					$('#edgeFaultyCnt').val('0');
					$(".num_only").val("0");
					$('input[type=hidden][name=2]').val("0");
					if ($('#userNumber').val() == '') {
						$('#searchUser').focus();
					} else {
						$('#edgeFaultyCnt').select();
					}
					
					sideView = "add";
					$('#edgeFaultyCnt').val("0");
					$('#badTotal1').text("0");
					$('#badTotal2').text("0");
					$('#userNm').val(userName);
					$('#userNumber').val(userNumber);
					
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
						$('#edgeInspctDate').val(today);
						//selectBoxAppend(ordGubunCode, "gubun", "N", "");
						
					//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
					} else if (secondDiff >= 0 && secondDiff <= 25200) {
						$('#workOrdDate').val(yesterday);
						$('#edgeInspctDate').val(yesterday);
						//selectBoxAppend(ordGubunCode, "gubun", "N", "");
			
					//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
					} else {
						$('#workOrdDate').val(today);
						$('#edgeInspctDate').val(today);
						//selectBoxAppend(ordGubunCode, "gubun", "D", "");
					}
					
					/*ㅡㅡㅡㅡㅡㅡㅡㅡㅡ등록 진행ㅡㅡㅡㅡㅡㅡㅡㅡㅡ*/
					
				} else if (res.result == 'haveValue') {
					$('#stateCheckPopupModal').modal({backdrop: 'static'});
					$('#stateCheckPopupModal').modal('show');
				} else if (res.result == 'error') {
					toastr.error(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
		//검사 진행
	});

	//주야구분 선택 빛 변경 시
	/* $('#gubun').on('change', function() {
		sudel($(this).val(), false);
	}); */
	
	//모달 값 확인 클릭 시
	$('#btnStateCheckSave').on('click', function(){
	
		viewDisabled(false);
		//viewValueClear();
		
		$('#edgeFaultyCnt').val("0");
		$('#badTotal1').text("0");
		$('#badTotal2').text("0");
		$('#userNm').val(userName);
		$('#userNumber').val(userNumber);
		
		$("#btnEdit").attr("disabled", true);
		$("#btnSave").attr("disabled", false);
		$('#edgeFaultyCnt').val('0');
		$(".num_only").val("0");
		if ($('#userNumber').val() == '') {
			$('#searchUser').focus();
		} else {
			$('#edgeFaultyCnt').select();
		}
		
		sideView = "add";
		
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
			$('#edgeInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "gubun", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#workOrdDate').val(yesterday);
			$('#edgeInspctDate').val(yesterday);
			//selectBoxAppend(ordGubunCode, "gubun", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#workOrdDate').val(today);
			$('#edgeInspctDate').val(today);
			//selectBoxAppend(ordGubunCode, "gubun", "D", "");
		}
	
	});
	
	//수정 버튼 클릭시
	$('#btnEdit').on('click', function() {

		if (equipCd == null || equipCd == '' || equipCd == ' ') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (capa == null || capa == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if($('#outputCardTableSeq tbody tr').hasClass('selected')=='') {
			toastr.warning('수정할 항목을 선택해주세요!', '', {timeOut: 5000});
			return false;
		}
		

		if( $('#pIdx').val() == "" ) {
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
				$('#workOrdDate').val(today);
				$('#edgeInspctDate').val(today);
				//selectBoxAppend(ordGubunCode, "gubun", "N", "");
				//sudel('N', false);
				
			//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
			} else if (secondDiff >= 0 && secondDiff <= 25200) {
				$('#workOrdDate').val(yesterday);
				$('#edgeInspctDate').val(yesterday);
				//selectBoxAppend(ordGubunCode, "gubun", "N", "");
				//sudel('N', false);

			//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
			} else {
				$('#workOrdDate').val(today);
				$('#edgeInspctDate').val(today);
				//selectBoxAppend(ordGubunCode, "gubun", "D", "");
				//sudel('D', false);
			}
		}
		
		viewDisabled(false);
		$("#btnSave").attr("disabled",false);
// 		$("#workOrdDate").attr("disabled",true);                                                                                                                                            
// 		$("#edgeInspctDate").attr("disabled",true);
// 		$('#gubun').attr('disabled',true);
		if($('#userNm').val() == "" && $('#userNumber').val()=="" ){
			$('#userNm').val(userName);
			$('#userNumber').val(userNumber);
		} 
		sideView = "edit";
	});

	$('#edgeSampleCnt').keypress(function (event) { 
		if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8 && event.which != 13) {
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
		}
		if ( event.which == 13 ){
			$('#edgeFaultyCnt').focus();
		}
	});
	$('#edgeFaultyCnt').keypress(function (event) { 
		if (event.which && (event.which <= 47 || event.which >= 58) && event.which != 8 && event.which != 13) {
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
		}
		//if ( event.which == 13 ){
		//	$("#btnSave").trigger("click");
		//}
	});

	//삭제 버튼 클릭 시
	$('#btnDel').on('click', function() {
		//조건 걸어주기
		if($('#workOrderTable tbody tr').hasClass('selected')=='') {
			toastr.warning('삭제할 항목을 선택해주세요!', '', {timeOut: 5000});
			return false;
		}
		
		if (equipCd == null || equipCd == '') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (capa == null || capa == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (lotNo == null || lotNo == '') {
			toastr.warning('주재료를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if (mainMatrlCd == null || mainMatrlCd == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		if($('#outputCardTableSeq tbody tr').hasClass('selected')=='') {
			toastr.warning('수정할 항목을 선택해주세요!', '', {timeOut: 5000});
			return false;
		}
		//조건 걸어주기
		
		$('#deleteAppearCheckModalLabel').text($('#gubun').val() == "D" ? '(주간)외관검사 삭제 확인' : '(야간)외관검사 삭제 확인');
		//$('#deleteAppearCheckModalLabel').attr('style', $('#gubun').val() == "D" ? 'color:red;' : 'color:blue;')
		$('#deleteAppearCheckPopupModal').modal({backdrop: 'static'});
		$('#deleteAppearCheckPopupModal').modal('show');
	});

	//모달 삭제 버큰 클릭 시
	$('#btnDeleteAppearCheck').on('click', function(){
		//삭제
		$.ajax({
			url : '<c:url value="qm/edgeCheckDelete_F2"/>',
			type : 'POST',
			data : {
				'workOrdNo'		: function() { return workOrdNo;	},
				'dayNightCd'	: function() { return $('#gubun').val();	},
				'seq'			: function() { return seq;	},
			
			},
			success : function(res) {
				let data = res.result;
				console.log(res.result);
				if (res.result == 'ok') {
					/* $('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
					viewDisabled(true);
					viewValueClear();
					$('#outputCardTable').DataTable().ajax.reload( function () {});
					
					let rows 	= workOrderTable.rows('.selected').indexes();
	       			let index	= $('#workOrderTable').DataTable().row(rows).index();
	       			
	       			$('#workOrderTable').DataTable().ajax.reload(function(){
	       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
		       		}); */

		       		viewDisabled(true);		       		
					viewValueClear();
					$('#outputCardTableSeq').DataTable().ajax.reload( function () {});				
					seq = '';	
					sudel($('#gubun').val(), true);					
					$(".num_only").val("0");
					$('#workOrdNoTitle').text('');
					toastr.success('삭제되었습니다.');
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else if (res.result == 'haveSeq') {
					toastr.warning(res.message, '', {timeOut: 5000});
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
		//삭제
	});
	
	
	//검사완료 버튼 클릭 시
	$('#btnTestDone').on('click', function(){
		
		let rowsValue = workOrderTable.rows('.selected').data()[0].workInspectionStatusCd
		
		/*if(rowsValue == null || rowsValue == ""){
			toastr.warning("검사를 먼저 진행해주세요.");
			return false;
		}*/
		
		selectBoxAppend(workStatusCode, "workInspectionStatusSelectBox", "C" , "2");
		
		$('#testDonePopupModal').modal({backdrop: 'static'});
		$('#testDonePopupModal').modal('show');
	});
	
	//팝업 selectBox값 변경 시
	$('#workInspectionStatusSelectBox').on('change', function(){
		if($(this).val() != ''){
			$('#testDoneModalH6').text("검사를 상태를 ("+$("option:selected", this).text()+")변경 하시겠습니까?");
		}else{
			$('#testDoneModalH6').text("상태값을 선택해주세요.");
		}
	});
	
	//팝업 검사완료 버튼 클릭 시
	$('#btnPopupTestDone').on('click', function(){
		
		if($('#workInspectionStatusSelectBox option:selected').val() == ""){
			toastr.warning("검사 상태값을 선택해 주세요.");
			return false;
		}
		
		//엣지검사 검사상태 등록
		$.ajax({
			url : '<c:url value="qm/workStatusCheckCreate"/>',
			type : 'POST',
			data : {
				'workOrdNo'					: function() { return workOrdNo;													},
				'workInspectionStatusCd'	: function() { return $('#workInspectionStatusSelectBox option:selected').val();	}
			},
			success : function(res) {
				let data = res.result;
				if (res.result == 'ok') {
					
					let rows 	= workOrderTable.rows('.selected').indexes();
	       			let index	= $('#workOrderTable').DataTable().row(rows).index();
	       			
	       			$('#workOrderTable').DataTable().ajax.reload(function(){
	       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
		       		});
					
					toastr.success('변경 되었습니다.');
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
		//엣지검사 검사상태 등록
	});
	
	//글자 클릭 시 복사
	$('#workOrdNoTitle').on('click', function(){

		$('#workOrdNoTitle').attr('style','color: blue;font-size: 20px;font-weight: 300;text-decoration: underline solid 1px; pointer-events : none;');
		
		setTimeout(function(){
			$('#workOrdNoTitle').attr('style','color: cornflowerblue;font-size: 20px;font-weight: 300;text-decoration: underline solid 1px;');
		},150);
		toastr.success('복사되었습니다.', '', {timeOut: 500});
		
		let val		= $("#workOrdNoTitle").text(); // 복사할 내용
        let t 		= document.createElement("textarea");
        var agent	= navigator.userAgent.toLowerCase();

     	// IE일 때
   		if(agent.indexOf("msie") != -1 || agent.indexOf('trident') != -1){   
   	   		document.body.appendChild(t);
   	  		t.value = val;
   	   		window.getSelection().selectAllChildren(t);
		}else{
			// chrome일 때
   	   		t.textContent   = val;
   	   		document.body.appendChild(t);
   	   		t.select();
   		}
   	 	document.execCommand("copy");
   	 	document.body.removeChild(t);
	});
	//글자 클릭 시 복사

	//담당자조회 팝업 시작
	var userPopUpTable;
	function selectPreWorkCharger()
	{
	     if(userPopUpTable == null || userPopUpTable == undefined)   {
	        userPopUpTable = $('#userPopUpTable').DataTable({
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
			$('#userPopUpTable tbody').on('click', 'tr', function () {
	            var data = userPopUpTable.row( this ).data();
	            $('#userNm').val(data.userNm);	//사원명
	            $('#userNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userPopUpModal').modal('hide');  
	            $('#edgeSampleCnt').focus();
			});
		} else {
			$('#userPopUpTable').DataTable().ajax.reload( function () {});
		}
			
     	$('#userPopUpModal').modal('show');   
     }
    //담당자조회 팝업 종료

    //View값 초기화
    function viewValueClear(){
    	$('#workOrdDate').val(null);
		$('#edgeInspctDate').val(null);
		$('#workTeamCd').val(null);
		$('#goodsNm').val(null);
		if ( readCheck ) {
			$('#userNumber').val(null);
			$('#userNm').val(null);
		}
		$('#qutyNm').val(null);
		$('#edgeSampleCnt').val(null);
		$('#ordLotNo').val(null);
		$('#edgeFaultyCnt').val('0');
		$('#ordLotNo').val(null);
		$('#outputCnt').val(null);
		$('#subWorkStatusCd').val(null);
		$('#edgeRollFaultySize').val('0.00');
		$('#edgeSymbolFaultySize').val('0.00');
		$('#edgeBurFaultySize').val('0.00');
		$('#workOrdNo').val(null);
		$(".num_only").val("");
		
		$('#badTotal1').text("0");
		$('#badTotal2').text("0");
		//$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
		//$('#outputCardTable').DataTable().clear().draw();
		//$('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
	}

	//버튼 클릭 제한
	function viewDisabled(flag)
	{
		$("#workOrdDate").attr("disabled", flag);
		$("#edgeInspctDate").attr("disabled", flag);
		$("#searchUser").attr("disabled", flag);
		$("#edgeSampleCnt").attr("disabled", flag);		
		//$("#gubun").attr("disabled", flag);
// 		$("#edgeFaultyCnt").attr("disabled", flag);
		$("#edgeRollFaultySize").attr("disabled", flag);
		$("#edgeSymbolFaultySize").attr("disabled", flag);
		$("#edgeRollFaultySize").attr("disabled", flag);
		$("#edgeSymbolFaultySize").attr("disabled", flag);
		$("#edgeBurFaultySize").attr("disabled", flag);
		//$("#btnEdit").attr("disabled", flag);
		//$("#btnDel").attr("disabled", flag);
		$('.num_only').attr('disabled', flag);
	}

	$('.num_only, .appearOutputCnt').keypress(function (event) { 
 		if ( !((event.which >= 48 && event.which <= 57) || event.which == 46 || event.which == 13)) {
			$('input').on("blur keyup", function() {
				$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
			});
			toastr.warning('양수(+)만 입력해주세요.');
			event.preventDefault();
		}
 		
	});
	
	function faultyCntCheck(){
		sum = 0;
		$.each($('input.num_only'), function(index,item){				
			sum += parseInt($(this).val() || 0);
		});
		
		temp = true
		return temp;
	}
	
	//외관불량수량 입력 키보드
	var tagId = "";
	var temp = "";
	$('.num_only').focusout(function() {
		tagId = $(this).attr('id');
	});

	$('#number0').on('click', function () {
		let temp = $('#'+tagId).val();		
		if (temp == "0"){
			$('#'+tagId).val("0");
		} else{
			$('#'+tagId).val(temp.concat("0"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number1').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("1");
		} else{
			$('#'+tagId).val(temp.concat("1"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number2').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("2");
		} else{
			$('#'+tagId).val(temp.concat("2"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number3').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("3");
		} else{
			$('#'+tagId).val(temp.concat("3"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number4').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("4");
		} else{
			$('#'+tagId).val(temp.concat("4"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number5').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("5");
		} else{
			$('#'+tagId).val(temp.concat("5"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number6').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("6");
		} else{
			$('#'+tagId).val(temp.concat("6"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number7').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("7");
		} else{
			$('#'+tagId).val(temp.concat("7"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number8').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("8");
		} else{
			$('#'+tagId).val(temp.concat("8"));
		}
		$(".num_only").trigger("keyup");
	});
	$('#number9').on('click', function () {
		let temp = $('#'+tagId).val();
		if (temp == "0"){
			$('#'+tagId).val("9");
		} else{
			$('#'+tagId).val(temp.concat("9"));
		}
		$(".num_only").trigger("keyup");
	});

	//백스페이스
	$('#backSpace').on('click', function () {
		let temp = $('#'+tagId).val();
		temp = temp.slice(0,-1); //문자
		$('#'+tagId).val(temp);
		if ($('#'+tagId).val(temp) || $('#'+tagId).val() == '00') {
			$('#'+tagId).val('0');
		}
		$(".num_only").trigger("keyup");
	});

	$('.num_only').on('click', function() {
		$(this).select();
	});
	
	//엔터
	$('#enter').on('click', function () {
		//해당아이디 엔터 강제이벤트로 가기
		$.each($('#faultyTbody1 .num_only'), function() {
			if (tagId == $(this).attr('id')){
				var str = $(this).attr('id');
				$('#metal'+ numberPad( ( parseInt( str.slice(-3, str.length) )+1 ),3) ).select();
			}
		});

		$.each($('#faultyTbody2 .num_only'), function() {
			if (tagId == $(this).attr('id')){
				var str = $(this).attr('id');
				$('#film'+ numberPad((parseInt(str.slice(-3, str.length))+1),3)).select();
			}
		});
		
		$(".num_only").trigger("keyup");
	});
	
	function numberPad(n, width) {
	    n = n + '';
	    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}

	//전체화면	
    $('#openFullScreen').on('click', function(){
    	openFullScreenMode();
    });

	//전체화면 해제
    $('#closeFullScreen').on('click', function(){
    	closeFullScreenMode();
    });

	$('#btnCloseCheck').on('click', function(){
		$('#closePopupModal').modal('hide');
		{
			$("#left-list").animate({
				width : "99%"
			}, 0);
			$("#myrSidenav").animate({
				width : "0%"
			}, 0, function(){
				$('#arrowLeft').css('display', 'block');
			});
		}
	});

	//rightList 닫기 버튼
	//$('#rightCardClose').on('click', function(){
	//	if( sideView == 'add' || sideView == 'edit' ){
	//		$('#closePopupModal').modal('show');
	//		return false;
	//	}
  	//  	$("#left-list").animate({
	//		width : "99%"
	//	}, 200);
	//	$("#myrSidenav").animate({
	//		width : "0%"
	//	}, 200, function(){
	//		$('#arrowLeft').css('display', 'block');
	//	});
	//});

	//$('#arrowLeft').on('click', function(){
  	//  	$("#left-list").animate({
	//		width : "60%"
	//	}, 200);
	//	$("#myrSidenav").animate({
	//		width : "39%"
	//	}, 200, function(){
	//		$('#arrowLeft').css('display', 'none');
	//	});
	//});

	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}

	function viewClear() {
		$('#workOrdDate').val(serverDate);
		$('#edgeInspctDate').val(serverDate);
		$('#workOrdNo').val('');
		$('#ordLotNo').val('');
		$('#goodsNm').val('');
		$('#qutyNm').val('');
		$('#workTeamCd').val('');
		$('#workTeamNm').val('');
		$('#outputCnt').val('');
		$('#subWorkStatusCd').val('');
		$('#mainWorkChargrNm').val('');
		$('#userNumber').val('');
		$('#userNm').val('');
		$('#edgeRollFaultySize').val('');
		$('#edgeSymbolFaultySize').val('');
		$('#edgeBurFaultySize').val('');
	}

	//총 불량품
	function totalDefectiveChange(){
		var badTotal1 = 0;
		var badTotal2 = 0;
		for(var i=0; i<$('#faultyTbody1 tr td').length; i++){
		    if($('#faultyTbody1 tr td').eq(i).find('input').val() != 0){
		    	badTotal1 = parseInt(badTotal1) + parseInt($('#faultyTbody1 tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#faultyTbody2 tr td').length; i++){
		    if($('#faultyTbody2 tr td').eq(i).find('input').val() != 0){
		    	badTotal2 = parseInt(badTotal2) + parseInt($('#faultyTbody2 tr td').eq(i).find('input').val());
		    }
		}
		$('#badTotal1').text(addCommas(badTotal1));
		$('#badTotal2').text(addCommas(badTotal2));
		$('#edgeFaultyCnt').val(addCommas(parseInt(badTotal1) + parseInt(badTotal2)));
    }

	$('#tab1').click(function(){	
		$('#faultyDiv1').removeClass("d-none");
		$('#faultyDiv2').addClass("d-none");
// 		$('#etcFaultyDiv').addClass("d-none");
	});
	
	$('#tab2').click(function(){
		$('#faultyDiv1').addClass("d-none");
		$('#faultyDiv2').removeClass("d-none");
// 		$('#etcFaultyDiv').addClass("d-none");
	});

	// 불량 테이블 생성
	function metalFaultyHdCreate(){   			
    	var Hd_metal	= '';  
    	var Hd_metal1	= '<tr>';
    	var Hd_metal2	= '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '001'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metal'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="metalCd'+arrayLength+'" name="1" value="'+item.baseCd+'">';
    			Hd_metal2 += '<input type="hidden" id="metalCd1'+arrayLength+'" name="2" value=""> </td>';
    			
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

		$('#faultyTbody1').html(Hd_metal); 	
	}

	//불량 테리블 2 생성
	function filmFaultyHdCreate(){   			
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '002'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" name="1" value="'+item.baseCd+'">';
    			Hd_metal2 += '<input type="hidden" id="filmCd1'+arrayLength+'" name="2" value=""> </td>';
    			
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

           
		$('#faultyTbody2').html(Hd_metal); 	
	}


	//상단 스크롤 이동 버튼 클릭 시
	function btnScrollTop(){
		var scrollTop = $('#workOrderScrollDiv').scrollTop();
    	$('#workOrderScrollDiv').scrollTop(scrollTop - 200);
	}

	//하단 스크롤 이동 버튼 클릭 시
    function btnScrollBottom(){
    	var scrollBottom = $('#workOrderScrollDiv').scrollTop();
    	$('#workOrderScrollDiv').scrollTop(scrollBottom + 200);
	}

	//작집번호 스캔시 및 입력 시 Enter처리
    $("#workOrdNoScan").keypress(function (e) {
        if (e.which == 13){
        	workOrdNo 		= null;
        	ordLotNo	 	= null;
        	mainMatrlCd 	= null;
        	subWorkStatusCd = null;
        	workOrdNoScan 	= $('#workOrdNoScan').val();

        	$("#btnEdit").attr("disabled", true);
    		$("#btnDel").attr("disabled", true);
    		$("#btnSave").attr("disabled", true);
    		$('#workOrdNoTitle').text('');
        	viewDisabled(true);
    		viewValueClear();
        	$('#workOrderTable').DataTable().ajax.reload( function () {});
        	$('#outputCardTableSeq').DataTable().clear().draw();
//     		$('#workOrdNoScan').val('');
//     		$('#workOrdNoScan').focus();
		}
    });

	//초기화버튼 클릭 시
   	function workOrdNoScanReset(){
   	   	if($('#workOrdNoScan').val() != ''){
	   	   	workOrdNoScan 	= null;
			$('#workOrdNoScan').val('');
			$('#workOrdNoScan').focus();
	    	$('#workOrderTable').DataTable().ajax.reload( function () {});
	    	$('#outputCardTableSeq').DataTable().clear().draw();
   	   	}else{
   	   		$('#workOrdNoScan').focus();
		}
	}

	//주간 탭 클릭 시
	$('#tabD').on('click', function(){
		//$('#gubun').val('seCond').trigger('change');
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		sudel('D', true);
		$('#gubun').val('D');
		$('#gubun').attr('style', 'height:30px;color: red;');
	});

	//야간 탭 클릭 시
	$('#tabN').on('click', function(){
		if (workOrdNo == null || workOrdNo == '') {
			toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		sudel('N', true);
		$('#gubun').val('N');
		$('#gubun').attr('style', 'height:30px;color: blue;');
	});

	//앞자리 0 시작이면 떼줌
	function leftZeroRemove(vValue) {
		var vVal = vValue;

		if (vVal.length > 1) {
			vVal = vVal.replace(/(^0+)/, "");

			if (vVal.length == 0) {
				vVal = 0;
			}
		} 

		return vVal;
	}

</script>

</body>
</html>
