<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<% String userNm = session.getAttribute("userNm").toString(); %>


<%@include file="../layout/body-top.jsp" %>


<div class="page-wrapper" id="page-wrapper">

	<!-- 작업지시 인쇄 ordLotNo 선택 모달 시작-->
	<div class="modal fade bd-example-modal-lg" id="workOrdSubOrdLotNoModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" style="min-width:1200px;">
			<div class="modal-content">
				<div class="modal-header" style="padding-bottom:0px;">
					<h5 class="modal-title" id="workOrdNoModalTitle" style="padding-left:10px;"></h5>
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

	<!-- 외관검사 삭제 확인모달 시작-->
	<div class="modal fade" id="deleteAppearCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="deleteAppearCheckPopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteAppearCheckModalLabel">외관검사 삭제 확인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<h6>삭제하시겠습니까?</h6>
					<p>*마지막에 등록한 항목부터 삭제가 가능합니다!</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger touch6" id="btnDeleteAppearCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
					<button type="button" class="btn btn btn-secondary touch6" id="" data-dismiss="modal" style="min-width: 70px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!--  외관검사 삭제 확인모달 끝 -->
	
	<!-- 외관검사 상태 확인모달 시작-->
	<div class="modal fade" id="stateCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="stateChestateLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="stateCheckModalLabel">외관검사 상태 확인</h5>
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
	<!--  외관검사 상택 확인모달 끝 -->
	
	<!-- 외관검사 검사완료 확인모달 시작-->
	<div class="modal fade" id="testDonePopupModal" tabindex="-1" role="dialog" aria-labelledby="testDonePopupModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="testDoneModalLabel">외관검사 검사상태 확인</h5>
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
	<!--  외관검사 검사완료 확인모달 끝 -->
	
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">품질관리</a></li>
				<li class="breadcrumb-item active">외관검사</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main" style="padding-bottom:0px; padding-right:0px;">
		<div class="row table-wrap-hid" id="mainCard">
			<div class="left-list left-60" id="leftList" style="width:12%; margin-right:3px; padding-bottom:0px;">
				<div class="card" style="margin-bottom: 0px;">
					<div class="table-responsive">
						<table id="equipCodeAdmTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="min-width: 50px">설비명</th>
								</tr>
							</thead>
						</table>
					</div>
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
<!-- 					<button type="button" class="btn btn-primary float-right touch6" onclick="btnScrollTop();" style="margin-bottom:5px;">▲</button> -->
					<div class="col-md-12 matrl-top-list" id="workOrderScrollDiv" style="overflow:scroll; min-height:370px; max-height:370px;">
						<div class="table-responsive">
							<table id="workOrderTable" class="table table-bordered">
								<thead class="thead-light">
									<tr>
										<th style="min-width:70px">설비명</th>
										<th style="min-width:80px">제품(기종)</th>
										<th style="min-width:45px">재질</th>
										<th style="min-width:140px">규격</th>
										<th style="min-width:120px">작지번호</th>
										<th style="min-width:50px">상태</th>
										<th style="min-width:80px">주재료</th>
										<th style="min-width:38px">불량<br>상태</th>
										<th style="min-width:65px">생산<br>작업자</th>
										<th style="min-width:38px">검사<br>상태</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
<!-- 					<button type="button" class="btn btn-primary float-right touch6" onclick="btnScrollBottom();" style="margin-bottom:5px;">▼</button> -->
				</div>
				
				<!-- 작업지시 정보 끝 -->
				<div class="card-body col-sm-12" style="padding: 1px;">
					<!-- <h6>생산실적</h6> -->
				</div>
				<div class="col-md-12 matrl-bottom-list" style="min-height:340px;">
					<table class="table table-bordered" id="outputCardTable" style="padding-left:0px; padding-right:0px;">
						<thead class="thead-light">
						<tr>
							<th class="text-center" style="min-width:30px;">순번</th>
							<th class="text-center" style="min-width:70px;">외관 검사일</th>
							<th class="text-center" style="min-width:120px;">주재료</th>
							<th class="text-center" style="min-width:150px;">생산전표번호</th>
							<th class="text-center" style="min-width:60px;">외관<br>양품수량</th>
							<th class="text-center" style="min-width:60px;">총 불량수량</th>
							<th class="text-center" style="min-width:60px;">총 불량률</th>
							<th class="text-center" style="min-width:45px;">검사<br>담당</th>
							<th class="text-center" style="min-width:40px;">상태</th>
							<th class="text-center" style="min-width:65px;">생산<br>작업자</th>
						</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="4" style="text-align: center">합계</td>
								<td id="appearOutputSum" style="text-align:right">0</td>
								<td id="appearFaultySum" style="text-align:right">0</td>
								<td id="appearTotalRatio" style="text-align:right">0</td>
								<td>총 합계</td>
								<td id="outputCntSum" class="text-right" colspan="2">0</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-sidebar" id="myrSidenav" style="width:35%; padding-top:0px; padding-bottom:0px;">
				<div class="card-body col-sm-12" style="padding-bottom:8px;">
					<!-- 
					<div class="rightsidebar-close">
						<a href="javascript:void(0)" id="rightCardClose" class="closebtn float-right"><i class="mdi mdi-close"></i></a>
					</div>
					 -->
				<!-- 
				<button type="button" class="btn btn-primary float-left touch6" id="openFullScreen" style="margin-right:5px;">전체화면</button>
				<button type="button" class="btn btn-primary float-left touch6" id="closeFullScreen" style="margin-right:5px;">전체화면 해제</button>
				-->
				<button type="button" class="btn btn-primary float-left touch6 d-none" id="btnSizeCondStep" disabled>종물 등록 & 수정</button>
				<button type="button" class="btn btn-danger float-left touch6 ml-1" id="btnDel" disabled>삭제</button>
				
				<label class='ml-5' style="color: cornflowerblue; font-size: 20px;font-weight: 300;text-decoration: underline solid 1px;" id="workOrdNoTitle"></label>
				<button type="button" class="btn btn-primary float-right touch6" style="margin-right:5px;" id="btnEdit" disabled>수정</button>
				<button type="button" class="btn btn-primary float-right touch6" style="margin-right:5px;" id="btnAdd">등록</button>
				<button type="button" class="btn btn-success float-right touch6" style="margin-right:5px;" id="btnPrint" disabled>인쇄(엑셀 다운)</button>
			</div>
				<div class="card" id="formBox" style="margin-bottom: 5px;">
					<div class="row mb-2">
						<!-- 작지 스캔 테이블 -->
						<table class="table table-bordered" id="workOrdScanTable" style="margin-bottom:8px;">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<tr>
								<th class="touch6">생산전표일자</th>
	                            <td><input type="date" class="form-control touch6" id="workOrdDate"	name="workOrdDate" disabled></td>
	                            
	                            <th class="touch6">외관 검사일</th>
	                            <td><input type="date" class="form-control touch6" id="appearInspctDate" name="appearInspctDate" disabled></td>
							</tr>
	
							<tr>
								<th class="touch6">생산 주/야</th>
								<td><select class="custom-select custom-select-lg touch6" id="gubun" style="height:30px;" disabled></select></td>
<!-- 								<th class="touch6">Sample 수량</th> -->
<!-- 								<td><select class="custom-select custom-select-lg touch6" id="edgeSampleCnt" disabled></select></td> -->
								
	                            <th class="touch6">검사담당</th>
								<td>
									<div class="input-sub m-0">
										<input type="hidden" id="packYn">
										<input type="hidden" id="userNumber">
										<input type="text" class="form-control touch6" id="userNm" disabled>
										<button type="button" class="btn btn-primary input-sub-search-md" id="searchUser" disabled>
											<span class="oi oi-magnifying-glass" style="font-size: 15px;"></span>
										</button>
									</div>
								</td>
							</tr>
							
							<tr>
								<th class="touch6">외관 양품수량</th>
								<td><input type="text" maxlength="6" min="0" max="100000" class="form-control num_only text-right touch6" id="appearOutputCnt" min="0" max="99999" disabled></td>
								<th class="touch6">총 외관불량수량</th>
								<td><input type="text" class="form-control text-right touch6" style="color:red;" id="appearFaultyCnt" disabled></td>
							</tr>
							
							<tr>
							 	<th class="touch6" id="badTotalNmae1">...</th>
								<td id="metalBadTotal" style="text-align: right">0</td>
								<th class="touch6" id="badTotalNmae2">...</th>
								<td id="filmBadTotal" style="text-align: right">0</td>
							</tr>
							
							<tr>
							
								<th class="touch6" id="badTotalNmae4">...</th>
								<td id="visionBadTotal" style="text-align: right">0</td>
								<th class="touch6" id="badTotalNmae5">...</th>
								<td id="badTotal5" style="text-align: right">0</td>
							
								<!-- <td colspan="4" style="padding: 0px;">
									<div class="row col-sm-12 p-0">
										<div class="col-md-4 p-0">
											<span class="touch6 fakeTh" id="badTotalNmae4">...</span>
											<span class="fakeTd" id="visionBadTotal">0</span>
										</div>
										<div class="col-md-4 p-0">
											<span class="touch6 fakeTh" style="border-left: 1px solid #dee2e6;" id="badTotalNmae5">...</span>
											<span class="fakeTd" id="badTotal5">0</span>
										</div>
										<div class="col-md-4 p-0">
											<span class="touch6 fakeTh" style="border-left: 1px solid #dee2e6;" id="badTotalNmae6">...</span>
											<span class="fakeTd" id="badTotal6">0</span>
										</div>
									</div>
								</td>-->
							</tr>
							
						</table>
						<!--외관 불량 테이블 -->
						<div class="row col-sm-12">
							<div class="card-header card-tab col-md-12">
								<ul class="nav nav-tabs card-header-tabs">
									<li class="nav-item"><a class="nav-link active" data-toggle="tab" id="tab1">...</a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab2">...</a></li>
									<!-- <li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab3">기타불량</a></li> -->
									<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab4">...</a></li>
									<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab5">...</a></li>
<!-- 									<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tab6">...</a></li> -->
								</ul>
							</div>
						</div>
						<br>
						<div id="metalFaultyDiv">
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
								<tbody id="metalFaultyTbody">
									
								</tbody>
							
							</table>
						</div>
						<div id="filmFaultyDiv" class="d-none">
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
								<tbody id="filmFaultyTbody">
									
								</tbody>
							</table>
						</div>
						<div id="etcFaultyDiv"  class="d-none">
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
								<tbody id="etcFaultyTbody">
									
								</tbody>
							</table>
						</div>
						
						<div id="visionFaultyDiv" class="d-none">
							<table class="table table-bordered exam">
								<colgroup></colgroup>
								<tbody id="visionFaultyTbody">
								</tbody>
							</table>
						</div>
						
						<div id="faultyDiv5" class="d-none">
							<table class="table table-bordered exam">
								<colgroup></colgroup>
								<tbody id="faultyTbody5">
								</tbody>
							</table>
						</div>
						
						<!-- <div id="faultyDiv6" class="d-none">
							<table class="table table-bordered exam">
								<colgroup></colgroup>
								<tbody id="faultyTbody6">
								</tbody>
							</table>
						</div> -->
						
					</div>
					<button type="button" class="btn btn-primary float-right touch6" id="btnSave" disabled>저장</button>
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
			</div><!-- .right-sidebar -->
		</div><!-- /.row -->
	</div><!-- / #main  -->
</div><!-- /.page-wrapper -->
        
<!-- 담당자조회 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="userPopUpModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width: 1300px">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
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
<!-- 초,중,종물 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="sizeCondStepPopUpModal" tabindex="-1" role="dialog" aria-labelledby="sizeCondStepPopUpModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg float-right" style="min-width:1800px; margin-right: 10px;">
		<div class="modal-content">
			<div class="row">
				<div class="modal-header col-6" style="padding-bottom: 0px;">
					<!-- 너비맞춤 -->
				</div>
				<div class="modal-header col-6" style="padding-bottom: 0px;">
					<div class="float-right row col-8">
						<h5 class="modal-title" id="sizeCondStepPopUpLabel1"></h5>
						<h5 class="modal-title" id="sizeCondStepPopUpLabel2">&nbsp;종물 등록 & 수정</h5>
					</div>
					<div class="float-right col-3">
						<button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnSizeCondStepSave" disabled>저장</button>
						<button type="button" class="btn btn-primary float-right touch6" id="btnSizeCondStepEdit" style="margin-right: 7px;" disabled>수정</button>
					</div>
					<button type="button" class="close m-0 p-1" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
			</div>
			<div class="modal-body">
			<!-- <hr class="text-secondary"> -->
				<!-- 상세정보 -->
				<div id="viewBox" class="row">
					<div class="col-6">
						<table class="table table-bordered" id="bulgeCondStepTable">
							<tr>
								<th rowspan="2" class="touch6">돌기크기 좌상</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 좌하</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 우상</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupWidth" disabled></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">돌기크기 우하</th>
								<th class="touch6">높이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">넓이</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" style="min-width:100%" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownWidth" disabled></td>
							</tr>
							<!-- 
							<tr>
								<th rowspan="4" class="touch6">돌기크기<br>(높이)</th>
								<th class="touch6">좌상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">좌하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownHeight"disabled></td>
							</tr>
							<tr>
								<th class="touch6">우상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupHeight" disabled></td>
							</tr>
							<tr>
								<th class="touch6">우하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownHeight"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownHeight" disabled></td>
							</tr>
							<tr>
								<th rowspan="4" class="touch6">돌기크기<br>(넓이)</th>
								<th class="touch6">좌상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftupWidth" disabled></td>
							</tr>
							<tr>
								<th class="touch6">좌하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeLeftdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeLeftdownWidth"disabled></td>
							</tr>
							<tr>
								<th class="touch6">우상</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightupWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightupWidth" disabled></td>
							</tr>
							<tr>
								<th class="touch6">우하</th>
								<th class="touch6"><span class="cond" id=""></span></th>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only firstStep touch6" id="firstBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only secondStep touch6" id="secondBulgeRightdownWidth"></td>
								<td><input maxlength="8" min="0" max="1000" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only thridStep touch6" id="thirdBulgeRightdownWidth" disabled></td>
							</tr>
							 -->
						</table>
						<br>
						<br>
						<br>
						<div class="row">
							<div class="col-6">
								<!-- 종물 키패드 오른쪽 정렬용 -->
							</div>
							<div class="col-6 num_keypad">
								<table class="table table-bordered">
									<tr>
										<td id="stepNumber7" style="height:80px; width:100px;">7</td>
										<td id="stepNumber8" style="height:80px; width:100px;">8</td>
										<td id="stepNumber9" style="height:80px; width:100px;">9</td>
										<td rowspan="2" id="stepBackSpace" style="height:80px; width:100px;">←<br>(BS)</td>
									</tr>
									<tr>
										<td id="stepNumber4" style="height:80px; width:100px;">4</td>
										<td id="stepNumber5" style="height:80px; width:100px;">5</td>
										<td id="stepNumber6" style="height:80px; width:100px;">6</td>
									</tr>
									<tr>
										<td id="stepNumber1" style="height:80px; width:100px;">1</td>
										<td id="stepNumber2" style="height:80px; width:100px;">2</td>
										<td id="stepNumber3" style="height:80px; width:100px;">3</td>
										<td rowspan="2" id="stepEnter" style="height:80px; width:100px;">ENT</td>
									</tr>
									<tr>
										<td colspan="2" id="stepNumber0" style="height:80px; width:100px;">0</td>
										<td id="stepDot" style="height:80px; width:100px;">.</td>
									<tr>
								</table>
							</div>
						</div>
					</div>
					
					<div class="col-6">
						<table class="table table-bordered" id="sizeCondStepTable" style="margin-bottom:0px;">
							<colgroup><col width="15%"></colgroup>
							<colgroup><col width="10%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="13%"></colgroup>
							<colgroup><col width="20%"></colgroup>
							<tr>
								<th rowspan="3" class="touch6">위치</th>
		                        <th rowspan="3" class="touch6">시료</th>
		                        <th rowspan="3" class="touch6">조건</th>
		                        <th colspan="3" class="touch6">측정시간</th>
							</tr>
							<tr>
								<th class="touch6">초물</th>
		                        <th class="touch6">중물</th>
		                        <th class="touch6">종물</th>
							</tr>
							<tr>
								<td><input type="time" maxlength="5" class="form-control text-center touch6 firstStep" id="firstRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center touch6 secondStep" id="secondRegTime" placeholder="HH:MM"></td>
		                        <td><input type="time" maxlength="5" class="form-control text-center touch6 thridStep" id="thirdRegTime" placeholder="HH:MM" disabled></td>
							</tr>
							<tr>
								<!-- <input type="hidden" id="workOrdNo"> -->
								<input type="hidden" id="equipCondSeq">
								<input type="hidden" id="firstStepSearch">
								<input type="hidden" id="secondStepSearch">
								<input type="hidden" id="thirdStepSearch">
								<th rowspan="2" class="touch6">Welding Part</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="wpLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondWpLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdWpLeftAlwnce" min="0" disabled></td>
							</tr>
							<tr>
								<th class="touch6">(우)</th>
								<th class="touch6"><span id="wpRightCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstWpRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondWpRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdWpRightAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">Pitch</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="pitchLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPitchLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPitchLeftAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th class="touch6">(우)</th>
								<th class="touch6"><span class="cond touch6" id="pitchRightCond"></span></th>                                                                         
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPitchRightAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPitchRightAlwnce" min="0"  ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">P.P Film 날개</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="ppfWingLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfWingLeftAlwnce" min="0"  ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfWingLeftAlwnce" min="0"  ></td>
							</tr>
							<tr>
								<th class="touch6">(우)</th>
								<th><span class="cond touch6" id="ppfWingRightCond"></span></th>                                                                         
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfWingRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfWingRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th rowspan="2" class="touch6">P.P Film 폭</th>
								<th class="touch6">(좌)</th>
								<th><span class="cond touch6" id="ppfDepthLeftCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfDepthLeftAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfDepthLeftAlwnce" min="0" ></td>
							</tr>
							<tr>                                                                                        
								<th class="touch6">(우)</th>
								<th><span class="cond touch6" id="ppfDepthRightCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondPpfDepthRightAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdPpfDepthRightAlwnce" min="0" ></td>
							</tr>
							<tr>                                
								<th class="touch6">Film</th>
								<th class="touch6">총길이</th>
								<th><span class="cond touch6" id="filmCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstFilmAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondFilmAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdFilmAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">METAL</th>
								<th class="touch6">폭</th>
								<th><span class="cond touch6" id="metalDepthCond"></span></th>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondMetalDepthAlwnce" min="0" ></td>
								<td><input maxlength="7" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdMetalDepthAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th class="touch6">두께</th>
								<th><span class="cond touch6" id="metalThicknessCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondMetalThicknessAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdMetalThicknessAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="2" class="touch6">총두께</th>
								<th class="touch6">Center</th>
								<th><span class="cond touch6" id="thCenterCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondThCenterAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdThCenterAlwnce" min="0" ></td>
							</tr>                                                                                       
							<tr>
								<th class="touch6">Edge</th>
								<th><span class="cond touch6" id="thEdgeCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondThEdgeAlwncePlus" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdThEdgeAlwncePlus" min="0" ></td>
							</tr>
							<tr>
								<th rowspan="3" class="touch6">Burr (MAX)</th>
								<th class="touch6">Metal</th>
								<th><span class="cond touch6" id="burrCond"></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrMetalAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrMetalAlwnce" min="0" ></td>
							</tr>
							<tr>
								<th class="touch6">R-Cut</th>
								<th><span class="cond touch6" id=""></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrRcutAlwnce" min="0" ></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrRcutAlwnce" min="0"></td>
							</tr>
							<tr>
								<th class="touch6">R끝단</th>
								<th><span class="cond touch6" id=""></span></th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 firstStep" id="firstBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 secondStep" id="secondBurrRedgeAlwnce" min="0"></td>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.001" class="form-control step-number-float3 number-float3 text-right step_num_only touch6 thridStep" id="thirdBurrRedgeAlwnce" min="0"></td>
							</tr>
							<tr>
								<th colspan="5" class="touch6" style="text-align:right">초,중,종 물의 W.P(좌)+P.P폭(좌) 평균값 </th>
								<td><input maxlength="8" min="0" max="100" type="text" step="0.01" class="form-control number-float2 touch6" id="average" min="0" disabled></td>
							</tr>
						</table>
					</div>
					
					</div>
					<!-- 상세정보 끝-->
					<div class="card-body col-sm-12 p-2" style="padding-bottom:8px;">
						<!-- <div class="row">  -->
							<!-- <h5 class="modal-title" class="float-left" id="workOrdNoLabel"></h5> -->
							<!-- <button type="button" class="btn btn-primary float-right mr-2 touch6" id="btnSizeCondStepSave" disabled>저장</button> -->
						<!-- </div> -->
					</div>
					
				<!-- <hr class="text-secondary"> -->
			</div>
			<!--
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
			-->
		</div>
	</div>
</div>
<!-- 초,중,종물 모달 종료-->
<!-- 입력 취소 확인 모달 시작 -->
<div class="modal fade" id="closePopupModal" tabindex="-1" role="dialog" aria-labelledby="workOrdEndCancelPopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" style="padding-bottom:0px;">
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

<style>
	.fakeTh {
		background: #f6f7f9;
		border-right: 1px solid #dee2e6;
		line-height: 30px;
		font-weight: 600;
		padding: 1.5% 5% 2% 5%;
    }
    .fakeTd{
    	float: right !important;
    	line-height: 30px;
    	font-size: 15px;
    	margin-right: 5px;
    }
</style>

<script>

	$("#left-width-btn").click(function() {
		{
			$("#left-list").animate({
				width : "50%"
			}, 200);
			$("#myrSidenav").animate({
				width : "49%"
			}, 200);
		}
	
		state = !state;
	});

	let menuAuth = 'qmsc2060';
	let currentHref = 'qmsc2060';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","외관검사");
	
	var sum = 0;
	
	//공통코드 처리 시작
	var goodsFaultyBigCd=new Array();	//외관검사 대분류
    <c:forEach items="${goodsFaultyBigName}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		goodsFaultyBigCd.push(json);
    </c:forEach>
    
	var systemCommonCode=new Array();	//외관검사 소분류
    <c:forEach items="${systemCommonCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		json.etc1="${info.etc1}";
		systemCommonCode.push(json);
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
    
   	$('#tab1').text(goodsFaultyBigCd[0].baseCdNm);
	$('#tab2').text(goodsFaultyBigCd[1].baseCdNm);
// 	$('#tab3').text(goodsFaultyBigCd[2].baseCdNm);
	$('#tab4').text(goodsFaultyBigCd[2].baseCdNm);
	$('#tab5').text(goodsFaultyBigCd[3].baseCdNm);
// 	$('#tab6').text(goodsFaultyBigCd[5].baseCdNm);

	$('#badTotalNmae1').text(goodsFaultyBigCd[0].baseCdNm);
	$('#badTotalNmae2').text(goodsFaultyBigCd[1].baseCdNm);
// 	$('#badTotalNmae3').text(goodsFaultyBigCd[2].baseCdNm);
	$('#badTotalNmae4').text(goodsFaultyBigCd[2].baseCdNm);
	$('#badTotalNmae5').text(goodsFaultyBigCd[3].baseCdNm);
// 	$('#badTotalNmae6').text(goodsFaultyBigCd[5].baseCdNm);
	
      
    //$('.modal-header').css('padding-bottom','0px');
    //$('.card-body.col-sm-12').css('padding-bottom','8px');
    //$('#main').css('padding-bottom','0px');
	//$('#myrSidenav').css('padding-top','0px');
	//$('#myrSidenav').css('padding-bottom','0px');
	//$('#openFullScreen').css('margin-right','5px');
	//$('#closeFullScreen').css('margin-right','5px');
	//$('#btnAdd').css('margin-right','5px');
	//$('#btnEdit').css('margin-right','5px');
	//$('#sizeCondStepTable').css('margin-bottom','0px');
    //$('#workOrdScanTable').css('margin-bottom','8px');
    
	var userNm = "<%=userNm%>";
	var serverDate =  "${serverDate}";	//서버 날짜
	var chooseDate =  serverDate;	//서버 날짜
	var sideView = null;	//조회 성공 여부
	$('#btnSave').attr('disabled', true);
	$('#btnedit').attr('disabled', true);
	$('.num_only').attr('disabled', true);
	$(".firstStep, .secondStep, .thridStep").attr("disabled",true);
	selectBoxAppend(ordGubunCode, "gubun", "" , "");
	var ordDate = serverDate;
	$('#ordDate').val(ordDate);
	
	metalFaultyHdCreate();
	filmFaultyHdCreate();
	etcFaultyHdCreate();
	visionFaultyHdCreate();
	faultyHdCreate5();
// 	faultyHdCreate6();

	var equipCd 		= ' ';	//공백으로 mapper조건탈 수 있게 적용
	var workOrdNo 		= null;
	var workOrdNoScan 	= null;
	var ordLotNo 		= null;
	var lotNo 			= null;
	var capa 			= null;
	var mainMatrlCd	 	= null;
	//var equipCondSeq = null;
		
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
	    }
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
			$('#outputCardTable').DataTable().clear().draw();
			$("#btnEdit").attr("disabled", true);
			$("#btnDel").attr("disabled", true);
			$("#btnSave").attr("disabled", true);
			$('#btnPrint').attr('disabled', true);
			$('#workOrdNoTitle').text('');
			workOrdNo 		= null;
			workOrdNoScan 	= null;
			lotNo 			= null;
			ordLotNo 		= null;
			mainMatrlCd 	= null;
			capa 			= null;
			viewDisabled(true);
			viewValueClear();
		}
    });

	$('#calender').val(serverDate);
	$("#ordLotNo").focus();

	//조회 버튼 클릭시
	$('#btnRetv').on('click', function() {
		chooseDate = $('#calender').val();
		$('#goodsFaultyAdmTable').DataTable().ajax.reload();
	});

	//작지번호 스캔시
	$("#ordLotNo").keypress(function (e) {
        if (e.which == 13){
        	//한타 영타로 변환
	    	var engToKor = korTypeToEng( $.trim($('#ordLotNo').val()) );
	    	//변환대 영타가 소문자여서 대문자로 변환 후 비교
	    	$('#ordLotNo').val(engToKor.toUpperCase());

	    	if (!$.trim($('#ordLotNo').val())) {
                toastr.warning('생산LotNo를 스캔해주세요!');
                $('#ordLotNo').focus();
                return false;
            }

	    	scanWorkOrdOutputSubOrdLotNo()
	    	
		}
    });
	
	//$('#goodsFaultyAdmTable tbody').on('click', 'tr', function () {
	//	if ($(this).hasClass('selected')) {
	//		//$(this).removeClass('selected');
	//	} else {
	//		$('#goodsFaultyAdmTable').DataTable().$('tr.selected').removeClass('selected');
	//		$(this).addClass('selected');
	//		$('#appearInspctDate').attr('disabled',true);
	//		sideView = null;
	//        var data = goodsFaultyAdmTable.row( this ).data();
	//        workOrdNo = data.workOrdNo;
	//        ordLotNo = data.ordLotNo;
	//        lotNo = data.lotNo;
	//        $.ajax({
	//			url: '<c:url value="qm/readWorkOrderOutputSub"/>',
	//			type: 'GET',
	//			data: {
	//				'menuAuth'	 	: 		menuAuth,
	//				//'workOrdNo'		:		workOrdNo,		//작업지시
	//				'ordLotNo'		: 		function() { return ordLotNo; },	//생산LorNo
	//			},
	//			success: function (res) {
	//				let data = res.data;
	//				if (res.result == 'ok') {
	//					workOrdNo = data.workOrdNo;
	//					ordLotNo = data.ordLotNo;
	//					equipCondSeq = data.equipCondSeq;
	//					$('#appearInspctDate').val(moment(data.appearInspctDate).format('YYYY-MM-DD'));
	//					$('#qutyNm').val(data.qutyNm);
	//					$('#goodsNm').val(data.goodsNm);
	//					$('#userNm').val(data.appearInspctChargerNm);
	//					$('#userNumber').val(data.appearInspctCharger);
	//					$('#edgeOutputCnt').val(addCommas(data.edgeOutputCnt));
	//					$('#appearFaultyCnt').val(addCommas(data.appearFaultyCnt));
	//					$('#ordLotNo').val(data.ordLotNo);
	//					$('#workOrdNo').val(data.workOrdNo);
	//					$('#subWorkStatusCd').val(data.subWorkStatusCd);
	//					$('#appearFaultyCnt').val(data.appearFaultyCnt);
	//					$('#packYn').val(data.packYn);
	//					$('.num_only').attr('disabled', true);
	//					$('#btnSave').attr('disabled', true);
	//				} else if (res.result == 'fail') {
	//					toastr.warning(res.message, '', {timeOut: 5000});
	//				} else if (res.result == 'error') {
	//					toastr.error(res.message, '', {timeOut: 5000});
	//				}
	//			},
	//			complete:function() {
	//				//외관불량 TB 상세조회
	// 		        $.ajax({
	// 		        	url: '<c:url value="qm/readGoodsFaultyAdm"/>',
	// 		            type: 'GET',
	// 		            data: {
	// 		            	'menuAuth'	 	: 		menuAuth,
	// 		            	//'workOrdNo'		:		workOrdNo,		//작업지시
	// 		            	'ordLotNo'		:		ordLotNo,		//생산LorNo
	// 		            },
	// 		            success: function (res) {
	// 		                let data = res.data;
	// 		                if (res.result == 'ok') {
	// 		                	$(".num_only").val("0");
	// 		                	var i = 0;
	// 		                	$.each($('.num_only'), function(index1,item1) {
	// 		                		if(data.length > i) {
	// 		                			$.each(data, function(index2,item2) {
	//	 		                			if ($(item1).parent().find('input[type=hidden]').val() == item2.minorCd) {
	//	 		                				$(item1).val(item2.faultyCnt);
	//		 		                			i++;
	//			 		                	}
	//		 		                	});      		
	// 		                		}
	//    	   					});	    	   							 		                              	
	// 		                	searchData = true;
	// 						} else if (res.result == 'fail') {
	// 		                	toastr.warning(res.message, '', {timeOut: 5000});
	// 		                	searchData = false;
	// 						} else if (res.result == 'error') {
	// 		                	toastr.error(res.message, '', {timeOut: 5000});
	// 		                	searchData = false;
	// 						}
	// 					},
	// 					complete:function() {
	// 		 				$('#btnEdit').attr('disabled', false);
	// 		 				$('#btnSave').attr('disabled', true);
	//						$("#btnSizeCondStep").attr("disabled", false);
	// 		 				viewDisabled(true);
	// 		 				totalDefectiveChange();
	// 						//if ($('#packYn').val() == 'Y') {
	// 						//	$('#btnEdit').attr('disabled', true);
	// 						//	toastr.warning('포장된 제품으로 조회만 가능합니다!','', {timeOut: 5000});
	// 						//}	 						
	// 					}
	// 				});
	//			}
	//		});
	//	}
	//});

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
			{ data: 'equipNm'	},
			{ data: 'goodsNm'	},
			{ data: 'qutyNm'	},
			{ data: 'model'		},
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
			{ data: 'workStatusNm' 		},
			{ data: 'lotNo' 			},
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
			{ targets: '_all', className: 'text-center' },
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

    //작지 조회
    $('#btnWorkOrdRetv').on('click', function() {
    	ordDate =  $('#ordDate').val();
    	workOrdNo 		= null;
    	workOrdNoScan 	= null;
    	ordLotNo	 	= null;
    	mainMatrlCd 	= null;
    	subWorkStatusCd = null;
    	$("#btnEdit").attr("disabled", true);
		$("#btnDel").attr("disabled", true);
		$("#btnSave").attr("disabled", true);
		$('#btnPrint').attr('disabled', true);
		$('#workOrdNoTitle').text('');
		$('#workOrdNoScan').val('');
		$('#workOrdNoScan').focus();
    	viewDisabled(true);
		viewValueClear();
    	$('#workOrderTable').DataTable().ajax.reload( function () {});
    	$('#outputCardTable').DataTable().clear().draw();
    });

    var workerId		= '';	//작업자 ID 값
    var workerTeamCd	= '';	//작업조
    
	$('#workOrderTable tbody').on('click', 'tr', function () {
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			//workOrdNo = "";
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			workOrdNo = workOrderTable.row(this).data().workOrdNo;
			//equipCondSeq = workOrderTable.row(this).data().equipCondSeq;
			lotNo 			= workOrderTable.row(this).data().lotNo;
			mainMatrlCd 	= workOrderTable.row(this).data().matrlCd;
			capa 			= parseInt(workOrderTable.row(this).data().capa) / 2;
			equipCd			= workOrderTable.row(this).data().equipCd;
			workerId		= workOrderTable.row(this).data().workerId;
			workerTeamCd	= workOrderTable.row(this).data().workTeamCd;
			$('#workOrdNoTitle').text('');
			$('#btnPrint').attr('disabled', true);
			viewDisabled(true);
			viewValueClear();
			$('#outputCardTable').DataTable().ajax.reload( function () {});
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
			url: '<c:url value="/qm/edgeCheckList_F3"/>',
			type: 'GET',
			async: false,
			data: {
				'menuAuth'			: 	menuAuth,
				'workOrdNo'			:	function() { return workOrdNo; },
				'subWorkStatusCd'	:	'A',
				//'lotNo'			:	function() { return mainMatrlLotNo; },
			},
	    },
	    //rowId: '',
		columns: [
			{ data: 'workOrdSeq' },
			{ data: 'appearInspctDate',
				render: function(data, type, row) {
					if(data != null) {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
				}
			},
			{ data: 'lotNo' },
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
			{ data: 'appearOutputCnt',
				render: function(data, type, row) {
					return addCommas(data);
				}
			},
			{ data: 'appearFaultyCnt',
				render: function(data, type, row) {
					return addCommas(data);
				}
			},
			{ data: 'appearFaultyRatio',
				render: function(data, type, row) {
					return data + '%';
				}		
			},
			{ data: 'appearInspctChargerNm' },
			{ data: 'subWorkStatusNm' 		},
			/* { data: 'workerIdNm',
	       		render: function(data, type, row, meta) {
    				var html = '<label>'+data+' ('+row['workTeamNm'] +'조)'+'</label>';
	           		return html;
	       		}
			} */
			{ data: 'mainWorkChargrNm2',
	       		render: function(data, type, row, meta) {
    				var html = '<label>'+data+' ('+row['teamNm'] +'조)'+'</label>';
	           		return html;
	       		}
			}
		],
	    columnDefs: [
	    	{ targets: [0,1,2,3,7,8,9], className: 'text-center' },
			{ targets: [4,5], render: $.fn.dataTable.render.number( ',' ) },
			{ targets: [4,5], className: 'text-right sum' },
			{ targets: [6], className: 'text-right' },
		],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function () {
			var appearOutputSum 	= $('#outputCardTable').DataTable().column(4, {page: 'all'} ).data().sum();
			var appearFaultySum 	= $('#outputCardTable').DataTable().column(5, {page: 'all'} ).data().sum();
			var appearTotalRatio	= $('#outputCardTable').DataTable().column(6, {page: 'all'} ).data().sum();	//불량률
			var outputCntSum 		= parseInt(appearOutputSum) + parseInt(appearFaultySum);
// 			var appearTotalRatio = 	0;

			if(appearOutputSum != 0){
				appearTotalRatio = (appearFaultySum/outputCntSum) *100 	//불량률
			}

			$('#appearOutputSum').text(addCommas(appearOutputSum));
			$('#appearFaultySum').text(addCommas(appearFaultySum));
			$('#appearTotalRatio').text((appearTotalRatio.toFixed(2))+'%');
			$('#outputCntSum').text(addCommas(outputCntSum));
		},
		rowCallback: function (row, data) {
			if (data.packYn == 'Y') {
				$(row).addClass('skyYellow');
			}
		},
	});
	
	var ordLotNo		= null;
	var packYn 			= null;
	var subWorkStatusCd = null;
	var workOrdSeq 		= null;
	
	$('#outputCardTable tbody').on('click', 'tr', function () {
		if ($(this).find('td').eq(0).text() == '합계') {
			return false;
        }
        if ($(this).find('td').eq(0).text() == "데이터가 없습니다.") {
			return false;
		}

		$('#btnSave').attr('disabled', true);
		$('#btnPrint').attr('disabled', false);
        
		if ($(this).hasClass('selected')) {
			//$(this).removeClass('selected');
			//workOrdNo = "";
		} else {
			$('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');
			subWorkStatusCd = outputCardTable.row(this).data().subWorkStatusCd;
			ordLotNo		= outputCardTable.row(this).data().ordLotNo;
			packYn			= outputCardTable.row(this).data().packYn;
			workOrdSeq		= outputCardTable.row(this).data().workOrdSeq;
			$('#workOrdNoTitle').text(outputCardTable.row(this).data().workOrdLotNo);
			$('#my-spinner').show();
			
			scanWorkOrdOutputSubOrdLotNo();
		}
    });

	function scanWorkOrdOutputSubOrdLotNo() {
		$.ajax({
	    	url: '<c:url value="/qm/scanWorkOrdOutputSubOrdLotNo"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	        	'ordLotNo'		:		function() { return ordLotNo; },
	        },
	        success: function (res) {
	            let data = res.data;
	            if (res.result == 'ok') {
	            	if (data == null || data == "") {
	                	toastr.warning("검색 결과가 없습니다!");
	                //} else if (data.subWorkStatusCd == 'B') {
					//	toastr.warning("해당 생산LotNo는 미발행 상태의 생산LotNo입니다. 생산LotNo를 확인해주세요!", '', {timeOut: 5000});
					//} else if (data.subWorkStatusCd == 'P') {
					//	toastr.warning("해당 생산LotNo는 발행 상태의 생산LotNo입니다. 생산LotNo를 확인해주세요!", '', {timeOut: 5000});
					//} else if (data.subWorkStatusCd == 'S') {
					//	toastr.warning("해당 생산LotNo는 진행 상태의 생산LotNo입니다. 생산LotNo를 확인해주세요!", '', {timeOut: 5000});
					//} else if (data.subWorkStatusCd == 'C') {
					//	toastr.warning("해당 생산LotNo는 엣지검사 대상 생산LotNo입니다. 생산LotNo를 확인해주세요!", '', {timeOut: 5000});
					//} else if (data.subWorkStatusCd == 'C' || data.subWorkStatusCd == 'EF3') {
					//	sideView = 'add';
					//	subWorkStatusCd = data.subWorkStatusCd;
					//	ordLotNo = data.ordLotNo;
					//	packYn = data.packYn;
					//	equipCondSeq = data.equipCondSeq;
					//	$('#appearInspctDate').val(moment(data.appearInspctDate).format('YYYY-MM-DD'));
					//	$('#qutyNm').val(data.qutyNm);
					//	$('#goodsNm').val(data.goodsNm);
					//	$('#userNm').val(data.appearInspctChargerNm);
					//	$('#userNumber').val(data.appearInspctCharger);
					//	$('#edgeOutputCnt').val(addCommas(data.edgeOutputCnt));
					//	$('#appearFaultyCnt').val(addCommas(data.appearFaultyCnt));
					//	$('#ordLotNo').val(data.ordLotNo);
					//	$('#workOrdNo').val(data.workOrdNo);
					//	$('#subWorkStatusCd').val(data.subWorkStatusCd);
					//	$('#appearFaultyCnt').val(data.appearFaultyCnt);
					//	$('#packYn').val(data.packYn);
					//	$('.num_only').attr('disabled', true);
					//	$('#btnSave').attr('disabled', true);
		            //    toastr.success("외관검사 대상 생산 LotNo번호 스캔 되었습니다.");
	                //} else if(data.subWorkStatusCd == 'G') {
					//	//toastr.warning("해당 생산 LotNo는 외관검사 대상 생산 LotNo입니다. 생산LotNo를 확인해주세요!", '', {timeOut: 5000});
					} else if (data.subWorkStatusCd == 'A') {
						sideView 		= 'edit';
						subWorkStatusCd = data.subWorkStatusCd;
						workOrdNo 		= data.workOrdNo;
						ordLotNo 		= data.ordLotNo;
						packYn 			= data.packYn;
						equipCondSeq	= data.equipCondSeq;
						
						$('#workOrdDate').val(moment(data.workOrdDate).format('YYYY-MM-DD'));
						$('#appearInspctDate').val(moment(data.appearInspctDate).format('YYYY-MM-DD'));
						//$('#qutyNm').val(data.qutyNm);
						//$('#goodsNm').val(data.goodsNm);
						$('#userNm').val(data.appearInspctChargerNm);
						$('#userNumber').val(data.appearInspctCharger);
						//$('#edgeOutputCnt').val(addCommas(data.edgeOutputCnt));
// 						$('#appearFaultyCnt').val(addCommas(data.appearFaultyCnt));
						//$('#ordLotNo').val(data.ordLotNo);
						//$('#workOrdNo').val(data.workOrdNo);
						//$('#subWorkStatusCd').val(data.subWorkStatusCd);
						$(".num_only").val("0");
						$('#appearOutputCnt').val(addCommas(data.appearOutputCnt));
						$('#appearFaultyCnt').val(addCommas(data.appearFaultyCnt));
						$('#packYn').val(data.packYn);
						$('.num_only').attr('disabled', true);
						$('#btnSave').attr('disabled', true);
					} else {
						toastr.warning("알수없는 생산LotNo 상태값입니다. 관리자에게 문의해주세요!<br>ErrorType-qmsc3060_001-" + data.subWorkStatusCd, '', {timeOut: 5000});
					}
	            }
			},
			complete:function() {
				//외관불량 TB 상세조회
 		        $.ajax({
 		        	url: '<c:url value="/qm/readGoodsFaultyAdm"/>',
 		            type: 'GET',
 		            data: {
 		            	'menuAuth'	 	: 		menuAuth,
 		            	//'workOrdNo'		:		workOrdNo,		//작업지시
 		            	'ordLotNo'		:		ordLotNo,		//생산LorNo
 		            },
 		            success: function (res) {
 		                let data = res.data;
 		                if (res.result == 'ok') {
 		                	//$(".num_only").val("0");
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
 		 				//$('#btnEdit').attr('disabled', false);
 		 				$('#btnSave').attr('disabled', true);
						$("#btnSizeCondStep").attr("disabled", false);
 		 				viewDisabled(true);
 		 				totalDefectiveChange();
 						if (packYn == 'Y') {
 							$('#btnEdit').attr('disabled', true);
 							toastr.warning('포장 완료된 제품으로 조회만 가능합니다!','', {timeOut: 5000});
 						} else {
 							$('#btnEdit').attr('disabled', false);
 							$('#btnDel').attr('disabled', false);
 	 					}
 						$('#my-spinner').hide();	 						
 					}
 				});
			}
		});
	}
	
	//총 불량품
	function totalDefectiveChange(){
		var metalBadTotal	= 0;
		var filmBadTotal	= 0;
		var visionBadTotal	= 0;
		var badTotal5		= 0;
		var badTotal6		= 0;
		
		for(var i=0; i<$('#metalFaultyTbody tr td').length; i++){
		    if($('#metalFaultyTbody tr td').eq(i).find('input').val() != 0){
		    	metalBadTotal = parseInt(metalBadTotal) + parseInt($('#metalFaultyTbody tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#filmFaultyDiv tr td').length; i++){
		    if($('#filmFaultyDiv tr td').eq(i).find('input').val() != 0){
		    	filmBadTotal = parseInt(filmBadTotal) + parseInt($('#filmFaultyDiv tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#visionFaultyDiv tr td').length; i++){
		    if($('#visionFaultyDiv tr td').eq(i).find('input').val() != 0){
		    	visionBadTotal = parseInt(visionBadTotal) + parseInt($('#visionFaultyDiv tr td').eq(i).find('input').val());
		    }
		}
		for(var i=0; i<$('#faultyDiv5 tr td').length; i++){
		    if($('#faultyDiv5 tr td').eq(i).find('input').val() != 0){
		    	badTotal5 = parseInt(badTotal5) + parseInt($('#faultyDiv5 tr td').eq(i).find('input').val());
		    }
		}
		/*for(var i=0; i<$('#faultyDiv6 tr td').length; i++){
		    if($('#faultyDiv6 tr td').eq(i).find('input').val() != 0){
		    	badTotal6 = parseInt(badTotal6) + parseInt($('#faultyDiv6 tr td').eq(i).find('input').val());
		    }
		}*/
		$('#metalBadTotal').text(addCommas(metalBadTotal));
		$('#filmBadTotal').text(addCommas(filmBadTotal));
		$('#visionBadTotal').text(addCommas(visionBadTotal));
		$('#badTotal5').text(addCommas(badTotal5));
// 		$('#badTotal6').text(addCommas(badTotal6));
		$('#appearFaultyCnt').val(addCommas(parseInt(metalBadTotal) + parseInt(filmBadTotal) + parseInt(visionBadTotal) + parseInt(badTotal5) ));
    }

	//사용자 검색버튼
	$('#searchUser').on('click', function(){
		selectPreWorkCharger();
	});
		
	//초중종물 읽기
    $('#btnSizeCondStep').on('click', function(){
    	selectSizeCondStep();
    });
    
	//저장 버튼 클릭시
	$('#btnSave').on('click', function() {
		if (equipCd == null || equipCd == '' || equipCd == ' ') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		//if (equipCondSeq == null || equipCondSeq == '') {
		//	toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
		//	return false;
		//}
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
        if ($('#appearOutputCnt').val() == '0' || $('#appearOutputCnt').val() == '00') {
            toastr.warning('외관양품수량을 입력해 주세요!');
            $('#appearOutputCnt').focus();
            return false;
        }
        if (!$.trim($('#userNumber').val())) {
            toastr.warning('검사담당을 검색하세요.');
            $('#searchUser').focus();
            return false;
        }
        if (parseInt(removeCommas($('#appearOutputCnt').val())) > 99999) {
        	toastr.warning('외관 양품수량을 확인해주세요!');
            $('#appearOutputCnt').select();
            return false;
		}
        
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
        var trueFalse = faultyCntCheck();
		
        //if (trueFalse) {
			$('#my-spinner').show();
			
			var dataArray = new Array();
			var edgeOutputCnt = 0;
			$.each($('#metalFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00') {
					var rowData = new Object();
					rowData.equipCd 		= equipCd;
					rowData.workOrdNo 		= workOrdNo;
					rowData.ordLotNo 		= ordLotNo;
					rowData.lotNo 			= lotNo;
					rowData.mainMatrlCd 	= mainMatrlCd;
					rowData.targetCnt 		= capa;
					rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
					rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
					rowData.gubun 			= $('#gubun').val();
					rowData.faultyRegDate 	= $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd 		= '001';
					rowData.minorCd 		= $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt 		= $(this).val().replace(/,/g,"");
					rowData.sum 			= sum;
					rowData.inspctChargr	= $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
					rowData.appearFaultyCnt = sum;
					
					rowData.mainWorkChargr 	= workerId;		//	작업자
					rowData.teamCd 			= workerTeamCd;	//	작업조
					dataArray.push(rowData);
				}
			});
			
			$.each($('#filmFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.equipCd 		= equipCd;
					rowData.workOrdNo 		= workOrdNo;
					rowData.ordLotNo 		= ordLotNo;
					rowData.lotNo 			= lotNo;
					rowData.mainMatrlCd 	= mainMatrlCd;
					rowData.targetCnt 		= capa;
					rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
					rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
					rowData.gubun 			= $('#gubun').val();
					rowData.faultyRegDate	= $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd 		= '002';
					rowData.minorCd 		= $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt 		= $(this).val().replace(/,/g,"");
					rowData.sum 			= sum;
					rowData.inspctChargr 	= $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
					rowData.appearFaultyCnt = sum;

					rowData.mainWorkChargr 	= workerId;		//	작업자
					rowData.teamCd 			= workerTeamCd;	//	작업조
					dataArray.push(rowData);
				}
			});

			$.each($('#visionFaultyTbody .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.equipCd 		= equipCd;
					rowData.workOrdNo 		= workOrdNo;
					rowData.ordLotNo 		= ordLotNo;
					rowData.lotNo 			= lotNo;
					rowData.mainMatrlCd 	= mainMatrlCd;
					rowData.targetCnt 		= capa;
					rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
					rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
					rowData.gubun 			= $('#gubun').val();
					rowData.faultyRegDate	= $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd 		= '004';
					rowData.minorCd 		= $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt 		= $(this).val().replace(/,/g,"");
					rowData.sum 			= sum;
					rowData.inspctChargr 	= $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
					rowData.appearFaultyCnt = sum; 

					rowData.mainWorkChargr 	= workerId;		//	작업자
					rowData.teamCd 			= workerTeamCd;	//	작업조
					dataArray.push(rowData);
				}
			});

			$.each($('#faultyTbody5 .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.equipCd 		= equipCd;
					rowData.workOrdNo 		= workOrdNo;
					rowData.ordLotNo 		= ordLotNo;
					rowData.lotNo 			= lotNo;
					rowData.mainMatrlCd 	= mainMatrlCd;
					rowData.targetCnt 		= capa;
					rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
					rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
					rowData.gubun 			= $('#gubun').val();
					rowData.faultyRegDate	= $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd 		= '005';
					rowData.minorCd 		= $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt 		= $(this).val().replace(/,/g,"");
					rowData.sum 			= sum;
					rowData.inspctChargr 	= $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
					rowData.appearFaultyCnt = sum; 

					rowData.mainWorkChargr 	= workerId;		//	작업자
					rowData.teamCd 			= workerTeamCd;	//	작업조
					dataArray.push(rowData);
				}
			});

			/*$.each($('#faultyTbody6 .num_only'), function() {
				if($(this).val() != '0' && $(this).val() != '00'){	
					var rowData = new Object();
					rowData.equipCd 		= equipCd;
					rowData.workOrdNo 		= workOrdNo;
					rowData.ordLotNo 		= ordLotNo;
					rowData.lotNo 			= lotNo;
					rowData.mainMatrlCd 	= mainMatrlCd;
					rowData.targetCnt 		= capa;
					rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
					rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
					rowData.gubun 			= $('#gubun').val();
					rowData.faultyRegDate	= $('#appearInspctDate').val().replace(/-/g,"");
					rowData.majorCd 		= '006';
					rowData.minorCd 		= $(this).parent().find('input[type=hidden]').val();
					rowData.faultyCnt 		= $(this).val().replace(/,/g,"");
					rowData.sum 			= sum;
					rowData.inspctChargr 	= $('#userNumber').val();
					rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
					rowData.appearFaultyCnt = sum; 

					rowData.mainWorkChargr 	= workerId;		//	작업자
					rowData.teamCd 			= workerTeamCd;	//	작업조
					dataArray.push(rowData);
				}
			});*/

			if (dataArray.length == 0) {
				var rowData = new Object();
				rowData.equipCd 		= equipCd;
				rowData.workOrdNo	 	= workOrdNo;
				rowData.ordLotNo 		= ordLotNo;
				rowData.lotNo 			= lotNo;
				rowData.mainMatrlCd 	= mainMatrlCd;
				rowData.targetCnt 		= capa;
				rowData.ordDate 		= $('#ordDate').val().replace(/-/g,"");
				rowData.workOrdDate 	= $('#workOrdDate').val().replace(/-/g,"");
				rowData.gubun 			= $('#gubun').val();
				rowData.faultyRegDate 	= $('#appearInspctDate').val().replace(/-/g,"");
				rowData.majorCd 		= '001';
				rowData.minorCd 		= '001';
				rowData.faultyCnt 		= '0';
				rowData.sum 			= 0;
				rowData.inspctChargr 	= $('#userNumber').val();
				rowData.appearOutputCnt = parseInt($('#appearOutputCnt').val().replace(/,/g,""));
				rowData.appearFaultyCnt = '0';

				rowData.mainWorkChargr 	= workerId;		//	작업자
				rowData.teamCd 			= workerTeamCd;	//	작업조
				dataArray.push(rowData);
			}
            
            var url = "";
    		if (sideView == 'add'){
    			url = '<c:url value="/qm/appearCheckInsert_F3"/>';
    		} else if (sideView == 'edit'){
    			url = '<c:url value="/qm/appearCheckUpdate_F3"/>';
    		}

    		$.ajax({
				//외관검사 등록 OR 업데이트
				url: url,
				type: 'POST',
				data: JSON.stringify(dataArray),
				dataType:"json",
				contentType : "application/json; charset=UTF-8",		                                                                                    				
				success: function (res) {                                                                  				
					let data = res.data;
					if(res.result == 'ok') {
						toastr.success(res.message);
					} else if (res.result == 'fail') {
						toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
						toastr.error(res.message, '', {timeOut: 5000});
					}
					$('.num_only').attr('disabled', true);
    			},
    			complete:function(){
    				$('#outputCardTable').DataTable().ajax.reload();
    				
    				let rows 	= workOrderTable.rows('.selected').indexes();
	       			let index	= $('#workOrderTable').DataTable().row(rows).index();
	       			$('#workOrderTable').DataTable().ajax.reload(function(){
	       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
		       		});
    				
    				viewDisabled(true);
    				$('#searchUser').attr("disabled", true);
    				$('#btnSave').attr("disabled", true);
    				//$('#btnSizeCondStep').attr("disabled", false);
    				//$("#btnSizeCondStep").focus();
    				$('#workOrdDate').attr('disabled',true);
    				$('#appearInspctDate').attr('disabled',true);
    				$('#btnPrint').attr('disabled', true);
    				totalDefectiveChange();
    				$('#my-spinner').hide();
				}
			});
		//}
	});

	//등록 버튼 클릭시
	$('#btnAdd').on('click', function() {
		if (equipCd == null || equipCd == '' || equipCd == ' ') {
			toastr.warning('설비명을 선택해 주세요!', '', {timeOut: 5000});
			return false;
		}
		//if (equipCondSeq == null || equipCondSeq == '') {
		//	toastr.warning('작지번호를 선택해 주세요!', '', {timeOut: 5000});
		//	return false;
		//}
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
					sideView = 'add';
					viewDisabled(false);
					viewValueClear();
					$('#searchUser').focus();
					$(".num_only").val("0");
					$("#btnEdit").attr("disabled", true);
					$("#btnSave").attr("disabled", false);		
					$("#btnSizeCondStep").attr("disabled", true);
					$('#btnPrint').attr('disabled', true);
					searchData = false;

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
						$('#appearInspctDate').val(today);
						selectBoxAppend(ordGubunCode, "gubun", "N", "");
						
					//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
					} else if (secondDiff >= 0 && secondDiff <= 25200) {
						$('#workOrdDate').val(yesterday);
						$('#appearInspctDate').val(yesterday);
						selectBoxAppend(ordGubunCode, "gubun", "N", "");

					//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
					} else {
						$('#workOrdDate').val(today);
						$('#appearInspctDate').val(today);
						selectBoxAppend(ordGubunCode, "gubun", "D", "");
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
	
	
	//모달 값 확인 클릭 시
	$('#btnStateCheckSave').on('click', function(){
	
		sideView = 'add';
		viewDisabled(false);
		viewValueClear();
		$('#searchUser').focus();
		$(".num_only").val("0");
		$("#btnEdit").attr("disabled", true);
		$("#btnSave").attr("disabled", false);		
		$("#btnSizeCondStep").attr("disabled", true);
		$('#btnPrint').attr('disabled', true);
		searchData = false;

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
			$('#appearInspctDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");
			
		//현재시간이 00:00:00 ~ 07:00:00 이면 전표(생산)일자는 전날, 야간으로 표시
		} else if (secondDiff >= 0 && secondDiff <= 25200) {
			$('#workOrdDate').val(yesterday);
			$('#appearInspctDate').val(yesterday);
			selectBoxAppend(ordGubunCode, "gubun", "N", "");

		//현재시간이 07:00:00 ~ 18:59:59 이면 전표(생산)일자는 오늘, 주간으로 표시
		} else {
			$('#workOrdDate').val(today);
			$('#appearInspctDate').val(today);
			selectBoxAppend(ordGubunCode, "gubun", "D", "");
		}
	
	});
	
	
	
	//수정 버튼 클릭시
	$('#btnEdit').on('click', function() {
		sideView = 'edit';
		viewDisabled(false);
		$("#btnSave").attr("disabled",false);
		$("#ordLotNo").attr("disabled",true);
		$('.num_only').attr('disabled', false);
		$("#metalMmb").select();
		$('#workOrdDate').attr('disabled',true);
		$('#appearInspctDate').attr('disabled',true);
		$('#gubun').attr('disabled',true);
		$('#btnPrint').attr('disabled', true);
	});

	//삭제 버튼 클릭 시
	$('#btnDel').on('click', function() {
		//조건 걸어주기
		if($('#outputCardTable tbody tr').hasClass('selected')=='') {
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
		//조건 걸어주기
		
		$('#deleteAppearCheckPopupModal').modal({backdrop: 'static'});
		$('#deleteAppearCheckPopupModal').modal('show');
	});

	//모달 삭제 버큰 클릭 시
	$('#btnDeleteAppearCheck').on('click', function(){
		//삭제
		$.ajax({
			url : '<c:url value="qm/appearCheckDelete_F3"/>',
			type : 'POST',
			data : {
				'ordLotNo'		: function() { return ordLotNo;		},
				'workOrdNo'		: function() { return workOrdNo;	},
				'workOrdSeq'	: function() { return workOrdSeq;	}
			},
			success : function(res) {
				let data = res.result;
				if (res.result == 'ok') {
					$('#outputCardTable').DataTable().$('tr.selected').removeClass('selected');
					viewDisabled(true);
					viewValueClear();
					$('#outputCardTable').DataTable().ajax.reload( function () {});
					
					let rows 	= workOrderTable.rows('.selected').indexes();
	       			let index	= $('#workOrderTable').DataTable().row(rows).index();
	       			
	       			$('#workOrderTable').DataTable().ajax.reload(function(){
	       				$('#workOrderTable tbody tr').eq(index).addClass('selected');
		       		});
					
					$("#btnEdit").attr("disabled", true);
					$("#btnDel").attr("disabled", true);
					$("#btnSave").attr("disabled", true);
					$('#btnPrint').attr('disabled', true);
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
		
		//외관검사 검사상태 등록
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
		//외관검사 검사상태 등록
		
	});
	

	//인쇄(엑셀 다운) 버튼클릭 시
	$('#btnPrint').on('click', function(){
  		$('#workOrdSubOrdLotNoTable').DataTable().ajax.reload(function(){});
  		$('#workOrdNoModalTitle').html(workOrdNo);
  		$('#workOrdSubOrdLotNoModal').modal('show');
	});

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
			url: '<c:url value="/po/workOrdExcelDownOrdLotNoList_F3"/>',
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
			{ data: 'totalCnt' 			},
			{ data: 'userNm'			},			
			{ data: 'subWorkStatusNm'	},
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
			let excelSumOutputKg	= $('#workOrdSubOrdLotNoTable').DataTable().column(4,{ page: 'all'} ).data().sum();
			let excelSumOutputCnt	= $('#workOrdSubOrdLotNoTable').DataTable().column(5,{ page: 'all'} ).data().sum();
			let excelSumVisionKg	= $('#workOrdSubOrdLotNoTable').DataTable().column(6,{ page: 'all'} ).data().sum();
			let excelSumVisionCnt	= $('#workOrdSubOrdLotNoTable').DataTable().column(7,{ page: 'all'} ).data().sum();
			let excelTotalOutputKg	= excelSumOutputKg + excelSumVisionKg;
			let excelTotalOutputCnt	= excelSumOutputCnt + excelSumVisionCnt;
			
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
    });

    var workOrdLotNo 	= '';
    var workOrdSubLotNo = '';
    var workOrdIndex 	= '';

  	//인쇄(엑셀 다운) 대상 OrdLotNo목록
	$('#workOrdSubOrdLotNoTable tbody').on('click', 'tr', function () {
		//스캔 barcode가  부자재이면 기존selected 해제 후 스캔 barcode selectd
		if ($(this).hasClass('selected')) {
            //$(this).removeClass('selected');
        } else {
            $('#workOrdSubOrdLotNoTable').DataTable().$('td.selected').removeClass('selected');
            for (var i=0; i<=1; i++) {
    			$(this).find('td').eq(i).addClass('selected');
    		}
    		
    		workOrdLotNo 	= workOrdSubOrdLotNoTable.row(this).data().workOrdLotNo;
            workOrdSubLotNo = workOrdSubOrdLotNoTable.row(this).data().lotNo;
		}
    });

  	//모달 인쇄(엑셀 다윤) 버튼 클릭 시
  	$('#btnPrintCheck').on('click', function() {
  	  	if (workOrdNo == null) {
  	  	  	toastr.warning("인쇄(엑셀 다운)할 작업지시를 선택해주세요!");
  	  	  	return false;
  	  	}
		if (workOrdLotNo == null || workOrdLotNo == '') {
  	  	  	toastr.warning("인쇄할 생산LotNo를 선택해 주세요!");
  	  	  	return false;
  	  	}
		
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
	        	'equipCd'		 		: 	function() { return equipCd; },
		        'alnicuMatrlCd'			: 	workOrderTable.rows('.selected').data()[0].alnicuMatrlCd,
				'filmMatrlCd'			: 	workOrderTable.rows('.selected').data()[0].filmMatrlCd,
				'equipCondSeq'			: 	workOrderTable.rows('.selected').data()[0].equipCondSeq,
				//'ordLotNo'			:	workOrderTable.rows('.selected').data()[0].ordLotNo,
				'workOrdNo' 			: 	workOrderTable.rows('.selected').data()[0].workOrdNo,
				'workStatusCd' 			: 	workOrderTable.rows('.selected').data()[0].workStatusCd,
				'goodsCd'				: 	workOrderTable.rows('.selected').data()[0].goodsCd,
				'goodsNm'				: 	workOrderTable.rows('.selected').data()[0].goodsNm,
				'qutyNm'				: 	workOrderTable.rows('.selected').data()[0].qutyNm,
				'model'					: 	workOrderTable.rows('.selected').data()[0].model,
				'surfaceTrtmtNm'		: 	workOrderTable.rows('.selected').data()[0].surfaceTrtmtNm,
				'dealCorpCd' 			:	workOrderTable.rows('.selected').data()[0].dealCorpCd,
				'dealCorpNm' 			:	workOrderTable.rows('.selected').data()[0].dealCorpNm,
				'workTeamCd' 			: 	workOrderTable.rows('.selected').data()[0].workTeamCd,
				'mainWorkChargr' 		: 	workOrderTable.rows('.selected').data()[0].mainWorkChargr,
				'mainWorkChargrNm'		: 	workOrderTable.rows('.selected').data()[0].mainWorkChargrNm,
				'subWorkChargr' 		: 	workOrderTable.rows('.selected').data()[0].subWorkChargr,
				'subWorkChargrNm' 		: 	workOrderTable.rows('.selected').data()[0].subWorkChargrNm,
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
					location.href = '<c:url value="/po/workOrdExcelDownload?id="/>' + workOrdLotNo;
				} else if (res.result == 'fail') {
					toastr.error(res.message);
				} else {
					toastr.error("오류가 발생하였습니다. - excel/print-001_F3");
				}
			},
			complete:function(){
				workOrdLotNo 	= '';
				workOrdSubLotNo = '';
				$('#my-spinner').hide();
			}
		});
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
	            $('#userNm').val(data.userNm);			//사원명
	            $('#userNumber').val(data.userNumber);	//사원코드(hidden)
	            $('#userPopUpModal').modal('hide');
	            $('#metalMmb').select();
			});
		} else{
			$('#userPopUpTable').DataTable().ajax.reload();
		}
			
     	$('#userPopUpModal').modal('show');   
     }
    //담당자조회 팝업 종료

	//View값 초기화
	function viewValueClear(){
		$('#workOrdDate').val("");
		$('#appearInspctDate').val("");
		$('#userNumber').val("");
		$('#userNm').val("");
		$('#appearOutputCnt').val("0")
		$('#appearFaultyCnt').val("0");
		$('#metalBadTotal').text("0");
		$('#filmBadTotal').text("0");
		$('#visionBadTotal').text("0");
		$('#badTotal5').text("0");
// 		$('#badTotal6').text("0");
		$(".num_only").val("");
	}

    //입력항목들 disabled
    function viewDisabled(flag){
    	$('#workOrdDate').attr("disabled", flag);
    	$('#appearInspctDate').attr("disabled", flag);
    	$('#searchUser').attr("disabled", flag);
    	$("#appearOutputCnt").attr("disabled", flag);
    	$("#gubun").attr("disabled", flag);
    	$('.num_only').attr('disabled', flag);
    }

	$('.num_only').keypress(function (event) { 
		
		if ($(this).attr("maxlength") < $(this).val().length) {
			$(this).val($(this).val().substring(0, $(this).attr("maxlength")));
			$(this).val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			event.preventDefault();
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
			event.preventDefault();
		}
		
		if ( !((event.which >= 48 && event.which <= 57) || event.which == 13 || (event.which >= 37 && event.which <= 40))) {
	 		if ( event.which == 46 ) {
				toastr.warning('정수만 입력 가능합니다.');
				$(this).val("0");
				event.preventDefault();
			}else{
				$('input').on("blur keyup", function() {
					$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
				});
				toastr.warning('양수(+)만 입력해주세요.');
				event.preventDefault();
			}
			
		}
	});
	
	function faultyCntCheck(){
		//$('input.num_only').on('keyup',function(){
/* 			var sum1 = parseInt($("#metalMmb").val() || 0);
			var sum2 = parseInt($("#metalMms").val() || 0);
			var sum3 = parseInt($("#metalPms").val() || 0);
			var sum4 = parseInt($("#metalFstab").val() || 0);
			var sum5 = parseInt($("#metalPstab").val() || 0);
			var sum6 = parseInt($("#metalAliensbst").val() || 0);
			var sum7 = parseInt($("#metalBreak").val() || 0);
			var sum8 = parseInt($("#metalPolutn").val() || 0);
			var sum9 = parseInt($("#metalBrowning").val() || 0);
			var sum10 = parseInt($("#metalPpolutn").val() || 0);
			var sum11 = parseInt($("#metalGilt").val() || 0);
			var sum12 = parseInt($("#metalThickness").val() || 0);
			var sum13 = parseInt($("#metalEtc").val() || 0);
			var sum14 = parseInt($("#filmPfs").val() || 0);
			var sum15 = parseInt($("#filmBreak").val() || 0);
			var sum16 = parseInt($("#filmTornout").val() || 0);
			var sum17 = parseInt($("#filmSurfceBb").val() || 0);
			var sum18 = parseInt($("#filmEdgeBb").val() || 0);
			var sum19 = parseInt($("#filmTeflon").val() || 0);
			var sum20 = parseInt($("#filmAliensbst").val() || 0);
			var sum21 = parseInt($("#filmPolutn").val() || 0);
			var sum22 = parseInt($("#filmAgglomt").val() || 0);
			var sum23 = parseInt($("#filmOverlap").val() || 0);
			var sum24 = parseInt($("#filmUnjinjeop").val() || 0);
			var sum25 = parseInt($("#filmUnattch").val() || 0);
			var sum26 = parseInt($("#filmMf").val() || 0);
			var sum27 = parseInt($("#filmWing").val() || 0);
			var sum28 = parseInt($("#filmEtc").val() || 0);
			var sum29 = parseInt($("#etcSize").val() || 0);
			var sum30 = parseInt($("#etcCutting").val() || 0);
			var sum31 = parseInt($("#etcFilmPress").val() || 0);
			var sum32 = parseInt($("#etcFilmDepth").val() || 0);
			var sum33 = parseInt($("#etcLayer").val() || 0);
			var sum34 = parseInt($("#etcWashboard").val() || 0);
			var sum35 = parseInt($("#etcWhitetape").val() || 0);
			var sum36 = parseInt($("#etcPattem").val() || 0);
			var sum37 = parseInt($("#etcStabbed").val() || 0);
			var sum38 = parseInt($("#etcHaze").val() || 0);
			var sum39 = parseInt($("#etcSurface").val() || 0);
			var sum40 = parseInt($("#etcSwelling").val() || 0);
			var sum41 = parseInt($("#etcFeeding").val() || 0);
			var sum42 = parseInt($("#etcFilm").val() || 0);
			var sum43 = parseInt($("#etcSlash").val() || 0);
			var sum44 = parseInt($("#etcJinjeop").val() || 0);
			var sum45 = parseInt($("#etcCrack").val() || 0);
			var sum46 = parseInt($("#etcCrease").val() || 0);
			var sum47 = parseInt($("#etcEtc").val() || 0);

			
			var sum = sum1 + sum2 + sum3 + sum4 + sum5 + sum6 + sum7 + sum8 + sum9 + sum10;
			sum+= sum11 + sum12 + sum13 + sum14 + sum15 + sum16 + sum17 + sum18 + sum19 + sum20; 
			sum+= sum21 + sum22 + sum23 + sum24 + sum25 + sum26 + sum27 + sum28 + sum29 + sum30;
			sum+= sum31 + sum32 + sum33 + sum34 + sum35 + sum36 + sum37 + sum38 + sum39 + sum40;
			sum+= sum41 + sum42 + sum44 + sum44 + sum45 + sum46 + sum47; */
			//$("#appearFaultyCnt").val(sum);
			sum = 0;
			$.each($('input.num_only'), function(index,item){				
				sum += parseInt($(this).val() || 0);
			});
			if (sideView == 'add'){
				sum = sum - parseInt($('#appearOutputCnt').val().replace(/,/g,""));
			}
			else if (sideView == 'edit'){
    			sum = sum - parseInt($('#appearOutputCnt').val());
    		}
			//var temp;
			//if( parseInt($("#edgeOutputCnt").val().replace(/,/g, '')) < parseInt(sum) ){
			//	toastr.warning('불량수량이 엣지양품수량보다 많습니다 확인해주세요.');
			//	temp = false;
			//} else {
				temp = true
			//}

			return temp;
		 //});
	}
	//});
	
	//var location = null; 요거하면 url주소가 null로 돌아감 왜?
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

	$('#number0, #number1, #number2, #number3, #number4, #number5, #number6, #number7, #number8, #number9').on('click', function(){
		if ($('#appearOutputCnt').attr("maxlength") < $('#appearOutputCnt').val().length) {
			$('#appearOutputCnt').val($('#appearOutputCnt').val().substring(0, $('#appearOutputCnt').attr("maxlength")));
			$('#appearOutputCnt').val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			event.preventDefault();
		}
 		if ( parseFloat($('#appearOutputCnt').attr("max")) < parseFloat($('#appearOutputCnt').val())) {
 			$('#appearOutputCnt').val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
			event.preventDefault();
		}
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
		$.each($('#metalFaultyTbody .num_only'), function() {
			if (tagId == $(this).attr('id')){
				var str = $(this).attr('id');
				$('#metal'+ numberPad((parseInt(str.slice(-3, str.length))+1),3)).select();
			}
		});
		$.each($('#filmFaultyTbody .num_only'), function() {
			if (tagId == $(this).attr('id')){
				var str = $(this).attr('id');
				$('#film'+ numberPad((parseInt(str.slice(-3, str.length))+1),3)).select();
			}
		});
		if( tagId == 'appearOutputCnt' ){
			if( $('#tab1').hasClass('active') ){
				$('#metal001').select();
			} else if ( $('#tab2').hasClass('active') ){
				$('#film019').select();
			}/*  else if ( $('#tab4').hasClass('active') ){
				$('#vision057').select();
			} else if( $('#tab5').hasClass('active') ){
				$('#5058').select();
			} */
		} 
		
		
		/* 
		if (tagId == "metalMmb"){
			$('#metalMms').select();
		} else 	if (tagId == "metalMms"){
			$('#metalPms').select();
		} else 	if (tagId == "metalPms"){
			$('#metalFstab').select();
		} else 	if (tagId == "metalFstab"){
			$('#metalPstab').select();
		} else 	if (tagId == "metalPstab"){
			$('#metalAliensbst').select();
		} else 	if (tagId == "metalAliensbst"){
			$('#metalBreak').select();
		} else 	if (tagId == "metalBreak"){
			$('#metalPolutn').select();
		} else 	if (tagId == "metalPolutn"){
			$('#metalBrowning').select();
		} else 	if (tagId == "metalBrowning"){
			$('#metalPpolutn').select();
		} else 	if (tagId == "metalPpolutn"){
			$('#metalGilt').select();
		} else 	if (tagId == "metalGilt"){
			$('#metalThickness').select();
		} else 	if (tagId == "metalThickness"){
			$('#metalEtc').select();
		} else 	if (tagId == "metalEtc"){
			$('#filmPfs').select();
		} else 	if (tagId == "filmPfs"){
			$('#filmBreak').select();
		} else 	if (tagId == "filmBreak"){
			$('#filmTornout').select();
		} else 	if (tagId == "filmTornout"){
			$('#filmSurfceBb').select();
		} else 	if (tagId == "filmSurfceBb"){
			$('#filmEdgeBb').select();
		} else 	if (tagId == "filmEdgeBb"){
			$('#filmTeflon').select();
		} else 	if (tagId == "filmTeflon"){
			$('#filmAliensbst').select();
		} else 	if (tagId == "filmAliensbst"){
			$('#filmPolutn').select();
		} else 	if (tagId == "filmPolutn"){
			$('#filmAgglomt').select();
		} else 	if (tagId == "filmAgglomt"){
			$('#filmOverlap').select();
		} else 	if (tagId == "filmOverlap"){
			$('#filmUnjinjeop').select();
		} else 	if (tagId == "filmUnjinjeop"){
			$('#filmUnattch').select();
		} else 	if (tagId == "filmUnattch"){
			$('#filmWing').select();
		} else 	if (tagId == "filmWing"){
			$('#filmMf').select();
		} else 	if (tagId == "filmMf"){
			$('#filmEtc').select();
		} else 	if (tagId == "filmEtc"){
			$('#etcSize').select();
		} else 	if (tagId == "etcSize"){
			$('#etcCutting').select();
		} else 	if (tagId == "etcCutting"){
			$('#etcFilmPress').select();
		} else 	if (tagId == "etcFilmPress"){
			$('#etcFilmDepth').select();
		} else 	if (tagId == "etcFilmDepth"){
			$('#etcLayer').select();
		} else 	if (tagId == "etcLayer"){
			$('#etcWashboard').select();
		} else 	if (tagId == "etcWashboard"){
			$('#etcWhitetape').select();
		} else 	if (tagId == "etcWhitetape"){
			$('#etcPattem').select();
		} else 	if (tagId == "etcPattem"){
			$('#etcStabbed').select();
		} else 	if (tagId == "etcStabbed"){
			$('#etcHaze').select();
		} else 	if (tagId == "etcHaze"){
			$('#etcSurface').select();
		} else 	if (tagId == "etcSurface"){
			$('#etcSwelling').select();
		} else 	if (tagId == "etcSwelling"){
			$('#etcFeeding').select();

		} else 	if (tagId == "etcFeeding"){
			$('#etcFilm').select();

			
		} else 	if (tagId == "etcFilm"){
			$('#etcSlash').select();
		} else 	if (tagId == "etcSlash"){
			$('#etcJinjeop').select();
		} else 	if (tagId == "etcJinjeop"){
			$('#etcCrack').select();
		} else 	if (tagId == "etcCrack"){
			$('#etcCrease').select();
		} else 	if (tagId == "etcCrease"){
			$('#etcEtc').select();
		} else 	if (tagId == "etcEtc"){
			$('#btnSave').focus();
		} */
			
		$(".num_only").trigger("keyup");
	});

	//숫자입력 글자 수, min, max 제한
	$('.num_sum').keyup(function (event) {
 		if ($(this).attr("maxlength") < $(this).val().length) {
			$(this).val($(this).val().substring(0, $(this).attr("maxlength")));
			$(this).val("0");
			toastr.warning('최대 입력 글자를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최대 수치를 초과하였습니다.');
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			toastr.warning('최소 크기를 초과하였습니다.');
		}
	});

	//콤마(,) 생성
	function addCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

	//전체화면	
    $('#openFullScreen').on('click', function(){
    	openFullScreenMode();
    });

	//전체화면 해제
    $('#closeFullScreen').on('click', function(){
    	closeFullScreenMode();
    });

	//전체화면(f11)감지
    $(window).resize(function () {
        if ((screen.availHeight || screen.height - 30) <= window.innerHeight) {
        	$('#mainCard').css('height','915px');
        	//$('#rightList').css('min-height','915px');
        }
        else {
        	$('#mainCard').css('height','815px');
        	//$('#rightList').css('min-height','765px');
        }
    });

	//View 초기화
  	function viewClear()
	{
  		//$(".cond, .number-float1, .number-").val(null);
		$(".cond, .step_num_only").val(null);
    	$('#firstRegTime').val("");
    	$('#secondRegTime').val("");
    	$('#thirdRegTime').val("");
    	$("#average").val("");
	}

	function viewForm(flag)	{
		//$(".firstStep, .secondStep, .thridStep").attr("disabled",flag);
		$(".thridStep").attr("disabled",flag);
	}

	//초,중,종물 팝업 시작
   	function selectSizeCondStep()
   	{
   		$('#my-spinner').show();
   		
   		$('.number-').css('color', 'black');
   		$('#sizeCondStepPopUpModal').modal({backdrop: 'static'});
		$('#sizeCondStepPopUpModal').modal('show');
        viewClear();
        viewForm(true);
        
   	    $.ajax({
   	    	url: '<c:url value="qm/readWorkOrdOutputSubStepData"/>',
   	        type: 'GET',
   	        data: {
   	        	'menuAuth'	 	: 	menuAuth,
	   	        'workOrdNo'		: 	function() { return workOrdNo; },
	   	     	'ordLotNo'		: 	function() { return ordLotNo; },
   				'equipCondSeq' 	: 	function() { return equipCondSeq; },
   	        },
   	        success: function (res) {
   	         	let condStepData = res.condStepData;
				let firstStepData = res.firstStepData;
				let secondStepData = res.secondStepData;
				let thirdStepData = res.thirdStepData;
				let readWorkOrdOutputSubVo = res.readWorkOrdOutputSubVo;

				//종물을 다른 생산실적(ordLotNo)에서 입력했는지 확인
				if (thirdStepData != null && thirdStepData.ordLotNo != ordLotNo) {
					toastr.warning(thirdStepData.ordLotNo + ' 에서 등록&수정된 종물입니다.', '', {timeOut: 5000});
				}
				
				//치수 조건
   	            if (res.result == 'ok') {
   	            	$('#sizeCondStepPopUpLabel1').text(readWorkOrdOutputSubVo.ordLotNo + ' - ' + readWorkOrdOutputSubVo.lotNo);
   	            	
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

					$('#thirdWpLeftAlwnce').attr("minVal", (parseFloat(condStepData.wpLeftCond) - parseFloat(condStepData.wpLeftAlwnceMinus)).toFixed(3) );
					$('#thirdWpLeftAlwnce').attr("maxVal", (parseFloat(condStepData.wpLeftCond) + parseFloat(condStepData.wpLeftAlwncePlus)).toFixed(3) );
					$('#thirdWpRightAlwnce').attr("minVal", (parseFloat(condStepData.wpRightCond) - parseFloat(condStepData.wpRightAlwnceMinus)).toFixed(3) );
					$('#thirdWpRightAlwnce').attr("maxVal", (parseFloat(condStepData.wpRightCond) + parseFloat(condStepData.wpRightAlwncePlus)).toFixed(3) );
					$('#thirdPitchLeftAlwnce').attr("minVal", (parseFloat(condStepData.pitchLeftCond) - parseFloat(condStepData.pitchLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPitchLeftAlwnce').attr("maxVal", (parseFloat(condStepData.pitchLeftCond) + parseFloat(condStepData.pitchLeftAlwncePlus)).toFixed(3) );
					$('#thirdPitchRightAlwnce').attr("minVal", (parseFloat(condStepData.pitchRightCond) - parseFloat(condStepData.pitchRightAlwnceMinus)).toFixed(3) );
					$('#thirdPitchRightAlwnce').attr("maxVal", (parseFloat(condStepData.pitchRightCond) + parseFloat(condStepData.pitchRightAlwncePlus)).toFixed(3) );
					$('#thirdPpfWingLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingLeftCond) - parseFloat(condStepData.ppfWingLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPpfWingLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingLeftCond) + parseFloat(condStepData.ppfWingLeftAlwncePlus)).toFixed(3) );
					$('#thirdPpfWingRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfWingRightCond) - parseFloat(condStepData.ppfWingRightAlwnceMinus)).toFixed(3) );
					$('#thirdPpfWingRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfWingRightCond) + parseFloat(condStepData.ppfWingRightAlwncePlus)).toFixed(3) );
					$('#thirdPpfDepthLeftAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthLeftCond) - parseFloat(condStepData.ppfDepthLeftAlwnceMinus)).toFixed(3) );
					$('#thirdPpfDepthLeftAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthLeftCond) + parseFloat(condStepData.ppfDepthLeftAlwncePlus)).toFixed(3) );
					$('#thirdPpfDepthRightAlwnce').attr("minVal", (parseFloat(condStepData.ppfDepthRightCond) - parseFloat(condStepData.ppfDepthRightAlwnceMinus)).toFixed(3) );
					$('#thirdPpfDepthRightAlwnce').attr("maxVal", (parseFloat(condStepData.ppfDepthRightCond) + parseFloat(condStepData.ppfDepthRightAlwncePlus)).toFixed(3) );
					$('#thirdFilmAlwnce').attr("minVal", (parseFloat(condStepData.filmCond) - parseFloat(condStepData.filmAlwnceMinus)).toFixed(3) );
					$('#thirdFilmAlwnce').attr("maxVal", (parseFloat(condStepData.filmCond) + parseFloat(condStepData.filmAlwncePlus)).toFixed(3) );
					$('#thirdMetalDepthAlwnce').attr("minVal", (parseFloat(condStepData.metalDepthCond) - parseFloat(condStepData.metalDepthAlwnceMinus)).toFixed(3) );
					$('#thirdMetalDepthAlwnce').attr("maxVal", (parseFloat(condStepData.metalDepthCond) + parseFloat(condStepData.metalDepthAlwncePlus)).toFixed(3) );
					$('#thirdMetalThicknessAlwnce').attr("minVal", (parseFloat(condStepData.metalThicknessCond) - parseFloat(condStepData.metalThicknessAlwnceMinus)).toFixed(3) );
					$('#thirdMetalThicknessAlwnce').attr("maxVal", (parseFloat(condStepData.metalThicknessCond) + parseFloat(condStepData.metalThicknessAlwncePlus)).toFixed(3) );
					$('#thirdThCenterAlwnce').attr("minVal", (parseFloat(condStepData.thCenterCond) - parseFloat(condStepData.thCenterAlwnceMinus)).toFixed(3) );
					$('#thirdThCenterAlwnce').attr("maxVal", (parseFloat(condStepData.thCenterCond) + parseFloat(condStepData.thCenterAlwncePlus)).toFixed(3) );
					$('#thirdThEdgeAlwncePlus').attr("minVal", (parseFloat(condStepData.thEdgeCond) - parseFloat(condStepData.thEdgeAlwnceMinus)).toFixed(3) );
					$('#thirdThEdgeAlwncePlus').attr("maxVal", (parseFloat(condStepData.thEdgeCond) + parseFloat(condStepData.thEdgeAlwncePlus)).toFixed(3) );
					$('#thirdBurrMetalAlwnce').attr("minVal", (parseFloat(condStepData.burrCond) - parseFloat(condStepData.burrAlwnceMinus)).toFixed(3) );
					$('#thirdBurrMetalAlwnce').attr("maxVal", (parseFloat(condStepData.burrCond) + parseFloat(condStepData.burrAlwncePlus)).toFixed(3) );
					
   	            	//초물
	   	            if( res.firstStepData != null ){
	   	            	$('#firstStepSearch').val("success");

	   	            	//if ( firstStepData.regTime == null || firstStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
							//$('#firstRegTime').val(moment(secondStepData.regDate).format('HH:mm'));
		   	            	//$('#firstRegTime').val(firstStepData.regTime);
						//}
	   	            	wpLeft1 = firstStepData.wpLeftAlwnce;
	   	            	ppLeft1 = firstStepData.ppfDepthLeftAlwnce;
						$('#firstWpLeftAlwnce').val(firstStepData.wpLeftAlwnce);
						$('#firstWpRightAlwnce').val(firstStepData.wpRightAlwnce);
						$('#firstPitchLeftAlwnce').val(firstStepData.pitchLeftAlwnce);
						$('#firstPitchRightAlwnce').val(firstStepData.pitchRightAlwnce);
						$('#firstPpfWingLeftAlwnce').val(firstStepData.ppfWingLeftAlwnce);
						$('#firstPpfWingRightAlwnce').val(firstStepData.ppfWingRightAlwnce);
						$('#firstPpfDepthLeftAlwnce').val(firstStepData.ppfDepthLeftAlwnce);
						$('#firstPpfDepthRightAlwnce').val(firstStepData.ppfDepthRightAlwnce);
						$('#firstFilmAlwnce').val(firstStepData.filmAlwnce);
						$('#firstMetalDepthAlwnce').val(firstStepData.metalDepthAlwnce);
						$('#firstMetalThicknessAlwnce').val(firstStepData.metalThicknessAlwnce);
						$('#firstThCenterAlwnce').val(firstStepData.thCenterAlwnce);
						$('#firstThEdgeAlwncePlus').val(firstStepData.thEdgeAlwncePlus);
						$('#firstBurrMetalAlwnce').val(firstStepData.burrMetalAlwnce);
						$('#firstBurrRcutAlwnce').val(firstStepData.burrRcutAlwnce);
						$('#firstBurrRedgeAlwnce').val(firstStepData.burrRedgeAlwnce);
						$('#firstBulgeLeftupHeight').val(firstStepData.bulgeLeftupHeight);
						$('#firstBulgeLeftdownHeight').val(firstStepData.bulgeLeftdownHeight);
						$('#firstBulgeRightupHeight').val(firstStepData.bulgeRightupHeight);
						$('#firstBulgeRightdownHeight').val(firstStepData.bulgeRightdownHeight);
						$('#firstBulgeLeftupWidth').val(firstStepData.bulgeLeftupWidth);
						$('#firstBulgeLeftdownWidth').val(firstStepData.bulgeLeftdownWidth);
						$('#firstBulgeRightupWidth').val(firstStepData.bulgeRightupWidth);
						$('#firstBulgeRightdownWidth').val(firstStepData.bulgeRightdownWidth);
					} else {
						$('#firstStepSearch').val("fail");
						$('.firstStep').val('0');
						wpLeft1 = 0;
						ppLeft1 = 0;
					}

   	            	//중물
					if( res.secondStepData != null ){
	   	            	$('#secondStepSearch').val("success");
	   	            	//if ( secondStepData.regTime == null || secondStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
		   	            	//$('#secondRegTime').val(moment(secondStepData.regDate).format('HH:mm'));
		   	            	//$('#secondRegTime').val(secondStepData.regTime);
						//}
	   	            	wpLeft2 = secondStepData.wpLeftAlwnce;
	   	            	ppLeft2 = secondStepData.ppfDepthLeftAlwnce;
						$('#secondWpLeftAlwnce').val(secondStepData.wpLeftAlwnce);
						$('#secondWpRightAlwnce').val(secondStepData.wpRightAlwnce);
						$('#secondPitchLeftAlwnce').val(secondStepData.pitchLeftAlwnce);
						$('#secondPitchRightAlwnce').val(secondStepData.pitchRightAlwnce);
						$('#secondPpfWingLeftAlwnce').val(secondStepData.ppfWingLeftAlwnce);
						$('#secondPpfWingRightAlwnce').val(secondStepData.ppfWingRightAlwnce);
						$('#secondPpfDepthLeftAlwnce').val(secondStepData.ppfDepthLeftAlwnce);
						$('#secondPpfDepthRightAlwnce').val(secondStepData.ppfDepthRightAlwnce);
						$('#secondFilmAlwnce').val(secondStepData.filmAlwnce);
						$('#secondMetalDepthAlwnce').val(secondStepData.metalDepthAlwnce);
						$('#secondMetalThicknessAlwnce').val(secondStepData.metalThicknessAlwnce);
						$('#secondThCenterAlwnce').val(secondStepData.thCenterAlwnce);
						$('#secondThEdgeAlwncePlus').val(secondStepData.thEdgeAlwncePlus);
						$('#secondBurrMetalAlwnce').val(secondStepData.burrMetalAlwnce);
						$('#secondBurrRcutAlwnce').val(secondStepData.burrRcutAlwnce);
						$('#secondBurrRedgeAlwnce').val(secondStepData.burrRedgeAlwnce);
						$('#secondBulgeLeftupHeight').val(secondStepData.bulgeLeftupHeight);
						$('#secondBulgeLeftdownHeight').val(secondStepData.bulgeLeftdownHeight);
						$('#secondBulgeRightupHeight').val(secondStepData.bulgeRightupHeight);
						$('#secondBulgeRightdownHeight').val(secondStepData.bulgeRightdownHeight);
						$('#secondBulgeLeftupWidth').val(secondStepData.bulgeLeftupWidth);
						$('#secondBulgeLeftdownWidth').val(secondStepData.bulgeLeftdownWidth);
						$('#secondBulgeRightupWidth').val(secondStepData.bulgeRightupWidth);
						$('#secondBulgeRightdownWidth').val(secondStepData.bulgeRightdownWidth);
					} else {
						$('#secondStepSearch').val("fail");
						$('.secondStep').val('0');
						wpLeft2 = 0;
						ppLeft2 = 0;
					}

   	            	//종물
					if( res.thirdStepData != null ){
						$('#thirdStepSearch').val("success");
						//if ( thirdStepData.regTime == null || thirdStepData.regTime == "" ) {
						//	let Now = new Date();
						//	$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<=10?"0"+Now.getMinutes():Now.getMinutes()) );
		   	            //} else {
		   	            //	$('#thirdRegTime').val(moment(thirdStepData.regDate).format('HH:mm'));
		   	            //	//$('#thirdRegTime').val(thirdStepData.regTime);
						//}
						wpLeft3 = thirdStepData.wpLeftAlwnce;
	   	            	ppLeft3 = thirdStepData.ppfDepthLeftAlwnce;
						$('#thirdRegTime').val(thirdStepData.regTime);
						$('#thirdWpLeftAlwnce').val(thirdStepData.wpLeftAlwnce);
						$('#thirdWpRightAlwnce').val(thirdStepData.wpRightAlwnce);
						$('#thirdPitchLeftAlwnce').val(thirdStepData.pitchLeftAlwnce);
						$('#thirdPitchRightAlwnce').val(thirdStepData.pitchRightAlwnce);
						$('#thirdPpfWingLeftAlwnce').val(thirdStepData.ppfWingLeftAlwnce);
						$('#thirdPpfWingRightAlwnce').val(thirdStepData.ppfWingRightAlwnce);
						$('#thirdPpfDepthLeftAlwnce').val(thirdStepData.ppfDepthLeftAlwnce);
						$('#thirdPpfDepthRightAlwnce').val(thirdStepData.ppfDepthRightAlwnce);
						$('#thirdFilmAlwnce').val(thirdStepData.filmAlwnce);
						$('#thirdMetalDepthAlwnce').val(thirdStepData.metalDepthAlwnce);
						$('#thirdMetalThicknessAlwnce').val(thirdStepData.metalThicknessAlwnce);
						$('#thirdThCenterAlwnce').val(thirdStepData.thCenterAlwnce);
						$('#thirdThEdgeAlwncePlus').val(thirdStepData.thEdgeAlwncePlus);
						$('#thirdBurrMetalAlwnce').val(thirdStepData.burrMetalAlwnce);
						$('#thirdBurrRcutAlwnce').val(thirdStepData.burrRcutAlwnce);
						$('#thirdBurrRedgeAlwnce').val(thirdStepData.burrRedgeAlwnce);
						$('#thirdBulgeLeftupHeight').val(thirdStepData.bulgeLeftupHeight);
						$('#thirdBulgeLeftdownHeight').val(thirdStepData.bulgeLeftdownHeight);
						$('#thirdBulgeRightupHeight').val(thirdStepData.bulgeRightupHeight);
						$('#thirdBulgeRightdownHeight').val(thirdStepData.bulgeRightdownHeight);
						$('#thirdBulgeLeftupWidth').val(thirdStepData.bulgeLeftupWidth);
						$('#thirdBulgeLeftdownWidth').val(thirdStepData.bulgeLeftdownWidth);
						$('#thirdBulgeRightupWidth').val(thirdStepData.bulgeRightupWidth);
						$('#thirdBulgeRightdownWidth').val(thirdStepData.bulgeRightdownWidth);
					} else {
						$('#thirdStepSearch').val("fail");
						wpLeft3 = 0;
						ppLeft3 = 0;
					}

					for (var i=0; i<14; i++) {
						if ( i == 0 ){
							if ( parseFloat($('#thirdWpLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdWpLeftAlwnce').val()) && parseFloat($('#thirdWpLeftAlwnce').val()) <= parseFloat($('#thirdWpLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdWpLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdWpLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 1 ) {
							if ( parseFloat($('#thirdWpRightAlwnce').attr("minVal")) <= parseFloat($('#thirdWpRightAlwnce').val()) && parseFloat($('#thirdWpRightAlwnce').val()) <= parseFloat($('#thirdWpRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdWpRightAlwnce').css('color', 'black');
							} else {
								$('#thirdWpRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 2 ) {
							if ( parseFloat($('#thirdPitchLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchLeftAlwnce').val()) && parseFloat($('#thirdPitchLeftAlwnce').val()) <= parseFloat($('#thirdPitchLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPitchLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPitchLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 3 ) {
							if ( parseFloat($('#thirdPitchRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchRightAlwnce').val()) && parseFloat($('#thirdPitchRightAlwnce').val()) <= parseFloat($('#thirdPitchRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPitchRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPitchRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 4 ) {
							if ( parseFloat($('#thirdPpfWingLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingLeftAlwnce').val()) && parseFloat($('#thirdPpfWingLeftAlwnce').val()) <= parseFloat($('#thirdPpfWingLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfWingLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfWingLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 5 ) {
							if ( parseFloat($('#thirdPpfWingRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingRightAlwnce').val()) && parseFloat($('#thirdPpfWingRightAlwnce').val()) <= parseFloat($('#thirdPpfWingRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfWingRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfWingRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 6 ) {
							if ( parseFloat($('#thirdPpfDepthLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthLeftAlwnce').val()) && parseFloat($('#thirdPpfDepthLeftAlwnce').val()) <= parseFloat($('#thirdPpfDepthLeftAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfDepthLeftAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfDepthLeftAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 7 ) {
							if ( parseFloat($('#thirdPpfDepthRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthRightAlwnce').val()) && parseFloat($('#thirdPpfDepthRightAlwnce').val()) <= parseFloat($('#thirdPpfDepthRightAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdPpfDepthRightAlwnce').css('color', 'black');
							} else {
								$('#thirdPpfDepthRightAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 8 ) {
							if ( parseFloat($('#thirdFilmAlwnce').attr("minVal")) <= parseFloat($('#thirdFilmAlwnce').val()) && parseFloat($('#thirdFilmAlwnce').val()) <= parseFloat($('#thirdFilmAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdFilmAlwnce').css('color', 'black');
							} else {
								$('#thirdFilmAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 9 ) {
							if ( parseFloat($('#thirdMetalDepthAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalDepthAlwnce').val()) && parseFloat($('#thirdMetalDepthAlwnce').val()) <= parseFloat($('#thirdMetalDepthAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdMetalDepthAlwnce').css('color', 'black');
							} else {
								$('#thirdMetalDepthAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 10 ) {
							if ( parseFloat($('#thirdMetalThicknessAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalThicknessAlwnce').val()) && parseFloat($('#thirdMetalThicknessAlwnce').val()) <= parseFloat($('#thirdMetalThicknessAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdMetalThicknessAlwnce').css('color', 'black');
							} else {
								$('#thirdMetalThicknessAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 11 ) {
							if ( parseFloat($('#thirdThCenterAlwnce').attr("minVal")) <= parseFloat($('#thirdThCenterAlwnce').val()) && parseFloat($('#thirdThCenterAlwnce').val()) <= parseFloat($('#thirdThCenterAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdThCenterAlwnce').css('color', 'black');
							} else {
								$('#thirdThCenterAlwnce').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 12 ) {
							if ( parseFloat($('#thirdThEdgeAlwncePlus').attr("minVal")) <= parseFloat($('#thirdThEdgeAlwncePlus').val()) && parseFloat($('#thirdThEdgeAlwncePlus').val()) <= parseFloat($('#thirdThEdgeAlwncePlus').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdThEdgeAlwncePlus').css('color', 'black');
							} else {
								$('#thirdThEdgeAlwncePlus').css('color', 'red');
								arr[i] = false;
							}
						} else if ( i == 13 ) {
							if ( parseFloat($('#thirdBurrMetalAlwnce').attr("minVal")) <= parseFloat($('#thirdBurrMetalAlwnce').val()) && parseFloat($('#thirdBurrMetalAlwnce').val()) <= parseFloat($('#thirdBurrMetalAlwnce').attr("maxVal")) ) {
								arr[i] = true;
								$('#thirdBurrMetalAlwnce').css('color', 'black');
							} else {
								$('#thirdBurrMetalAlwnce').css('color', 'red');
								arr[i] = false;
							}
						}
			        }
			           	            	
   	            	//조회된 값이 없을때 평균값도 공백으로
   	            	if (res.firstStepData == null && res.secondStepData == null && res.thirdStepData == null ) {
   	            		$("#average").val("");
	   	            } else {
	   	            	average();	//초중종물의 WP(좌) PP폭(좌) 의 평균값 계산
					}

					
				} else {
					toastr.error("치수 조건을 조회오류가 발생하였습니다.", '', {timeOut: 5000});
  	        	    //$('#searchData').val("fail");
				}
   	        },
   	        complete:function(){
   	        	if ( $('#thirdStepSearch').val() == "fail" ){
       	    		viewSetData();
       			}
   	        	//$('#workOrdNoLabel').text(workOrdNo + " 종물 등록 & 수정");
   	        	$('#btnSizeCondStepEdit').attr('disabled', false);
   	        	$('#btnSizeCondStepSave').attr('disabled', true);
   	        	$('#my-spinner').hide();
			}
		});
		
   	}
	//초,중,종물 팝업 끝
	
	//초,중,종물 종물 수정 버튼
	$('#btnSizeCondStepEdit').on('click', function() {
    	if ( $('#thirdStepSearch').val() == "fail" ){
    		viewSetData();
		}
    	$('#btnSizeCondStepSave').attr('disabled', false);
    	viewForm(false);
    	$('.number-').css('color', 'black');
    	btnSaveClick = false;
    	let Now = new Date();
		//if( ($('#firstRegTime').val()=="") || ($('#firstRegTime').val()==null)){
		//	$('#firstRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
        //
		//if( ($('#secondRegTime').val()=="") || ($('#secondRegTime').val()==null)){
		//	$('#secondRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		//}
		if( ($('#thirdRegTime').val()=="") || ($('#thirdRegTime').val()==null)){
			$('#thirdRegTime').val( Now.getHours() + ":" + (Now.getMinutes()<10?"0"+Now.getMinutes():Now.getMinutes()) );
		}

		$('#thirdWpLeftAlwnce').select();
    });
    
    var btnSaveClick = false;	//저장처리 클릭 여부 확인
    var arr = [false, false, false, false, false, false, false, false, false, false, false, false, false, false];
    //초,중,종물 저장처리
    $('#btnSizeCondStepSave').on('click', function() {
        //입력값이 조건(+,-)안에 포함되는지 검사. 포함되지 않는다면 빨간색으로 표시
		for (var i=0; i<14; i++) {
			if ( i == 0 ){
				if ( parseFloat($('#thirdWpLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdWpLeftAlwnce').val()) && parseFloat($('#thirdWpLeftAlwnce').val()) <= parseFloat($('#thirdWpLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdWpLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdWpLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 1 ) {
				if ( parseFloat($('#thirdWpRightAlwnce').attr("minVal")) <= parseFloat($('#thirdWpRightAlwnce').val()) && parseFloat($('#thirdWpRightAlwnce').val()) <= parseFloat($('#thirdWpRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdWpRightAlwnce').css('color', 'black');
				} else {
					$('#thirdWpRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 2 ) {
				if ( parseFloat($('#thirdPitchLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchLeftAlwnce').val()) && parseFloat($('#thirdPitchLeftAlwnce').val()) <= parseFloat($('#thirdPitchLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPitchLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPitchLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 3 ) {
				if ( parseFloat($('#thirdPitchRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPitchRightAlwnce').val()) && parseFloat($('#thirdPitchRightAlwnce').val()) <= parseFloat($('#thirdPitchRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPitchRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPitchRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 4 ) {
				if ( parseFloat($('#thirdPpfWingLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingLeftAlwnce').val()) && parseFloat($('#thirdPpfWingLeftAlwnce').val()) <= parseFloat($('#thirdPpfWingLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfWingLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfWingLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 5 ) {
				if ( parseFloat($('#thirdPpfWingRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfWingRightAlwnce').val()) && parseFloat($('#thirdPpfWingRightAlwnce').val()) <= parseFloat($('#thirdPpfWingRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfWingRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfWingRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 6 ) {
				if ( parseFloat($('#thirdPpfDepthLeftAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthLeftAlwnce').val()) && parseFloat($('#thirdPpfDepthLeftAlwnce').val()) <= parseFloat($('#thirdPpfDepthLeftAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfDepthLeftAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfDepthLeftAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 7 ) {
				if ( parseFloat($('#thirdPpfDepthRightAlwnce').attr("minVal")) <= parseFloat($('#thirdPpfDepthRightAlwnce').val()) && parseFloat($('#thirdPpfDepthRightAlwnce').val()) <= parseFloat($('#thirdPpfDepthRightAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdPpfDepthRightAlwnce').css('color', 'black');
				} else {
					$('#thirdPpfDepthRightAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 8 ) {
				if ( parseFloat($('#thirdFilmAlwnce').attr("minVal")) <= parseFloat($('#thirdFilmAlwnce').val()) && parseFloat($('#thirdFilmAlwnce').val()) <= parseFloat($('#thirdFilmAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdFilmAlwnce').css('color', 'black');
				} else {
					$('#thirdFilmAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 9 ) {
				if ( parseFloat($('#thirdMetalDepthAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalDepthAlwnce').val()) && parseFloat($('#thirdMetalDepthAlwnce').val()) <= parseFloat($('#thirdMetalDepthAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdMetalDepthAlwnce').css('color', 'black');
				} else {
					$('#thirdMetalDepthAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 10 ) {
				if ( parseFloat($('#thirdMetalThicknessAlwnce').attr("minVal")) <= parseFloat($('#thirdMetalThicknessAlwnce').val()) && parseFloat($('#thirdMetalThicknessAlwnce').val()) <= parseFloat($('#thirdMetalThicknessAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdMetalThicknessAlwnce').css('color', 'black');
				} else {
					$('#thirdMetalThicknessAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 11 ) {
				if ( parseFloat($('#thirdThCenterAlwnce').attr("minVal")) <= parseFloat($('#thirdThCenterAlwnce').val()) && parseFloat($('#thirdThCenterAlwnce').val()) <= parseFloat($('#thirdThCenterAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdThCenterAlwnce').css('color', 'black');
				} else {
					$('#thirdThCenterAlwnce').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 12 ) {
				if ( parseFloat($('#thirdThEdgeAlwncePlus').attr("minVal")) <= parseFloat($('#thirdThEdgeAlwncePlus').val()) && parseFloat($('#thirdThEdgeAlwncePlus').val()) <= parseFloat($('#thirdThEdgeAlwncePlus').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdThEdgeAlwncePlus').css('color', 'black');
				} else {
					$('#thirdThEdgeAlwncePlus').css('color', 'red');
					arr[i] = false;
				}
			} else if ( i == 13 ) {
				if ( parseFloat($('#thirdBurrMetalAlwnce').attr("minVal")) <= parseFloat($('#thirdBurrMetalAlwnce').val()) && parseFloat($('#thirdBurrMetalAlwnce').val()) <= parseFloat($('#thirdBurrMetalAlwnce').attr("maxVal")) ) {
					arr[i] = true;
					$('#thirdBurrMetalAlwnce').css('color', 'black');
				} else {
					$('#thirdBurrMetalAlwnce').css('color', 'red');
					arr[i] = false;
				}
			}
        }

        //범위가 벗어난 곳이 있는지 확인 후 안내메세지 출력
        var j = 0;	//조건범위 이탈 수량
		for ( var i=0; i<14; i++) {
			if ( arr[i] == false ) {
				j++;
			}
		}

        //범위가 벗어난곳이 없고, 저장버튼을 처음누르는 것이면 저장처리
		if ( j != 0 && btnSaveClick == false ){
			toastr.warning("조건을 벗어난 부분이 " + j + "군데 있습니다. 확인해 주세요!", '', {timeOut: 5000});
			btnSaveClick = true;
		} else {
			
			$('#my-spinner').show();
			
			let url = null;
			if( $('#thirdStepSearch').val() == "fail" ){
	        	url = "/po/insertWorkOrderStepData"
	    	}
	        else if( $('#thirdStepSearch').val() == "success" ){
	        	url = "/po/updateWorkOrderStepData"
	    	}
	    	$.ajax({
	   	    	url: url,
	   	        type: 'POST',
	   	        data: {
	   	        	'menuAuth'	 				: 		menuAuth,
	   	        	'workOrdNo'					: 		function() { return workOrdNo; },
	   	        	'ordLotNo'					: 		function() { return ordLotNo; },
	   	        	'lotNo'						: 		function() { return lotNo; },
	   	        	
	   	        	//'firstRegTime'				: $('#firstRegTime').val(),
		   	        //'firstWpLeftAlwnce'			: $('#firstWpLeftAlwnce').val(),
	   	    		//'firstWpRightAlwnce'		: $('#firstWpRightAlwnce').val(),
		    		//'firstPitchLeftAlwnce'		: $('#firstPitchLeftAlwnce').val(),
		    		//'firstPitchRightAlwnce'		: $('#firstPitchRightAlwnce').val(),
	    			//'firstPpfWingLeftAlwnce'	: $('#firstPpfWingLeftAlwnce').val(),
		    		//'firstPpfWingRightAlwnce'	: $('#firstPpfWingRightAlwnce').val(),
	    			//'firstPpfDepthLeftAlwnce'	: $('#firstPpfDepthLeftAlwnce').val(),
		    		//'firstPpfDepthRightAlwnce'	: $('#firstPpfDepthRightAlwnce').val(),
	    			//'firstFilmAlwnce'			: $('#firstFilmAlwnce').val(),
		    		//'firstMetalDepthAlwnce'		: $('#firstMetalDepthAlwnce').val(),
	    			//'firstMetalThicknessAlwnce'	: $('#firstMetalThicknessAlwnce').val(),
		    		//'firstThCenterAlwnce'		: $('#firstThCenterAlwnce').val(),
	    			//'firstThEdgeAlwncePlus'		: $('#firstThEdgeAlwncePlus').val(),
		    		//'firstBurrMetalAlwnce'		: $('#firstBurrMetalAlwnce').val(),
		    		//'firstBurrRcutAlwnce'		: $('#firstBurrRcutAlwnce').val(),
		    		//'firstBurrRedgeAlwnce'		: $('#firstBurrRedgeAlwnce').val(),
		    		//'firstBulgeLeftupHeight'	: $('#firstBulgeLeftupHeight').val(),
		    		//'firstBulgeLeftdownHeight'	: $('#firstBulgeLeftdownHeight').val(),
		    		//'firstBulgeRightupHeight'	: $('#firstBulgeRightupHeight').val(),
		    		//'firstBulgeRightdownHeight'	: $('#firstBulgeRightdownHeight').val(),
		    		//'firstBulgeLeftupWidth'		: $('#firstBulgeLeftupWidth').val(),
		    		//'firstBulgeLeftdownWidth'	: $('#firstBulgeLeftdownWidth').val(),
		    		//'firstBulgeRightupWidth'	: $('#firstBulgeRightupWidth').val(),
		    		//'firstBulgeRightdownWidth'	: $('#firstBulgeRightdownWidth').val(),
	                //
		    		//'secondRegTime'				: $('#secondRegTime').val(),
					//'secondWpLeftAlwnce'		: $('#secondWpLeftAlwnce').val(),
		    		//'secondWpRightAlwnce'		: $('#secondWpRightAlwnce').val(),
					//'secondPitchLeftAlwnce'		: $('#secondPitchLeftAlwnce').val(),
		    		//'secondPitchRightAlwnce'	: $('#secondPitchRightAlwnce').val(),
					//'secondPpfWingLeftAlwnce'	: $('#secondPpfWingLeftAlwnce').val(),
		    		//'secondPpfWingRightAlwnce'	: $('#secondPpfWingRightAlwnce').val(),
					//'secondPpfDepthLeftAlwnce'	: $('#secondPpfDepthLeftAlwnce').val(),
		    		//'secondPpfDepthRightAlwnce'	: $('#secondPpfDepthRightAlwnce').val(),
					//'secondFilmAlwnce'			: $('#secondFilmAlwnce').val(),
		    		//'secondMetalDepthAlwnce'	: $('#secondMetalDepthAlwnce').val(),
		    		//'secondMetalThicknessAlwnce': $('#secondMetalThicknessAlwnce').val(),
		    		//'secondThCenterAlwnce'		: $('#secondThCenterAlwnce').val(),
					//'secondThEdgeAlwncePlus'	: $('#secondThEdgeAlwncePlus').val(),
		    		//'secondBurrMetalAlwnce'		: $('#secondBurrMetalAlwnce').val(),
					//'secondBurrRcutAlwnce'		: $('#secondBurrRcutAlwnce').val(),
		    		//'secondBurrRedgeAlwnce'		: $('#secondBurrRedgeAlwnce').val(),
		    		//'secondBulgeLeftupHeight'	: $('#secondBulgeLeftupHeight').val(),
		    		//'secondBulgeLeftdownHeight'	: $('#secondBulgeLeftdownHeight').val(),
		    		//'secondBulgeRightupHeight'	: $('#secondBulgeRightupHeight').val(),
		    		//'secondBulgeRightdownHeight': $('#secondBulgeRightdownHeight').val(),
		    		//'secondBulgeLeftupWidth'	: $('#secondBulgeLeftupWidth').val(),
		    		//'secondBulgeLeftdownWidth'	: $('#secondBulgeLeftdownWidth').val(),
		    		//'secondBulgeRightupWidth'	: $('#secondBulgeRightupWidth').val(),
		    		//'secondBulgeRightdownWidth'	: $('#secondBulgeRightdownWidth').val(),
	        
		    		'thirdRegTime'				: $('#thirdRegTime').val(),
					'thirdWpLeftAlwnce'			: $('#thirdWpLeftAlwnce').val(),
		    		'thirdWpRightAlwnce'		: $('#thirdWpRightAlwnce').val(),
					'thirdPitchLeftAlwnce'		: $('#thirdPitchLeftAlwnce').val(),
		    		'thirdPitchRightAlwnce'		: $('#thirdPitchRightAlwnce').val(),
					'thirdPpfWingLeftAlwnce'	: $('#thirdPpfWingLeftAlwnce').val(),
		    		'thirdPpfWingRightAlwnce'	: $('#thirdPpfWingRightAlwnce').val(),
		    		'thirdPpfDepthLeftAlwnce'	: $('#thirdPpfDepthLeftAlwnce').val(),
		    		'thirdPpfDepthRightAlwnce'	: $('#thirdPpfDepthRightAlwnce').val(),
					'thirdFilmAlwnce'			: $('#thirdFilmAlwnce').val(),
		    		'thirdMetalDepthAlwnce'		: $('#thirdMetalDepthAlwnce').val(),
					'thirdMetalThicknessAlwnce'	: $('#thirdMetalThicknessAlwnce').val(),
		    		'thirdThCenterAlwnce'		: $('#thirdThCenterAlwnce').val(),
					'thirdThEdgeAlwncePlus'		: $('#thirdThEdgeAlwncePlus').val(),
		    		'thirdBurrMetalAlwnce'		: $('#thirdBurrMetalAlwnce').val(),
					'thirdBurrRcutAlwnce'		: $('#thirdBurrRcutAlwnce').val(),
		    		'thirdBurrRedgeAlwnce'		: $('#thirdBurrRedgeAlwnce').val(),
		    		'thirdBulgeLeftupHeight'	: $('#thirdBulgeLeftupHeight').val(),
		    		'thirdBulgeLeftdownHeight'	: $('#thirdBulgeLeftdownHeight').val(),
		    		'thirdBulgeRightupHeight'	: $('#thirdBulgeRightupHeight').val(),
		    		'thirdBulgeRightdownHeight'	: $('#thirdBulgeRightdownHeight').val(),
		    		'thirdBulgeLeftupWidth'		: $('#thirdBulgeLeftupWidth').val(),
		    		'thirdBulgeLeftdownWidth'	: $('#thirdBulgeLeftdownWidth').val(),
		    		'thirdBulgeRightupWidth'	: $('#thirdBulgeRightupWidth').val(),
		    		'thirdBulgeRightdownWidth'	: $('#thirdBulgeRightdownWidth').val(),
	   	        },
	   	        success: function (res) {
	   	            let result = res.result;
	   	            if (res.result == 'ok') {
						if( $('#thirdStepSearch').val() == "fail" ){
							toastr.success("저장 되었습니다.");
	   	            		$('#thirdStepSearch').val("success");
		   	      		} else if( $('#thirdStepSearch').val() == "success" ){
		   	        		toastr.success("수정 되었습니다.");
		   	      		}
						//저장*수정 시 평균값 계산
						wpLeft1 = $('#firstWpLeftAlwnce').val();
						wpLeft2 = $('#secondWpLeftAlwnce').val();
						wpLeft3 = $('#thirdWpLeftAlwnce').val();
						ppLeft1 = $('#firstPpfDepthLeftAlwnce').val();
						ppLeft2 = $('#secondPpfDepthLeftAlwnce').val();
						ppLeft3 = $('#thirdPpfDepthLeftAlwnce').val();
						average();
					} else if (res.result == 'fail') {
	   	            	toastr.warning(res.message, '', {timeOut: 5000});
					} else if (res.result == 'error') {
	   	            	toastr.error(res.message, '', {timeOut: 5000});
	   	            }
	   	        },
	   	        complete:function(){
	   	        	viewForm(true);
	   	        	$("#btnSizeCondStepSave").attr("disabled",true);
	   	        	$('#my-spinner').hide();
	   	        }
	   	    });
		}
    });

    $("#thirdWpLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdWpRightAlwnce").select();
		}
	});

	$("#thirdWpRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchLeftAlwnce").select();
		}
	});

	$("#thirdPitchLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPitchRightAlwnce").select();
		}
	});

	$("#thirdPitchRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingLeftAlwnce").select();
		}
	});

	$("#thirdPpfWingLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfWingRightAlwnce").select();
		}
	});

	$("#thirdPpfWingRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthLeftAlwnce").select();
		}
	});

	$("#thirdPpfDepthLeftAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdPpfDepthRightAlwnce").select();
		}
	});

	$("#thirdPpfDepthRightAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdFilmAlwnce").select();
		}
	});

	$("#thirdFilmAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalDepthAlwnce").select();
		}
	});

	$("#thirdMetalDepthAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdMetalThicknessAlwnce").select();
		}
	});

	$("#thirdMetalThicknessAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThCenterAlwnce").select();
		}
	});

	$("#thirdThCenterAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdThEdgeAlwncePlus").select();
		}
	});

	$("#thirdThEdgeAlwncePlus").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrMetalAlwnce").select();
		}
	});
	
	$("#thirdBurrMetalAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRcutAlwnce").select();
		}
	});

	$("#thirdBurrRcutAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBurrRedgeAlwnce").select();
		}
	});

	$("#thirdBurrRedgeAlwnce").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftupHeight").select();
		}
	});

	$("#thirdBulgeLeftupHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftupWidth").select();
		}
	});

	$("#thirdBulgeLeftupWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftdownHeight").select();
		}
	});

	$("#thirdBulgeLeftdownHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeLeftdownWidth").select();
		}
	});

	$("#thirdBulgeLeftdownWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightupHeight").select();
		}
	});

	$("#thirdBulgeRightupHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightupWidth").select();
		}
	});

	$("#thirdBulgeRightupWidth").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightdownHeight").select();
		}
	});

	$("#thirdBulgeRightdownHeight").keypress(function (e) {
		if (e.which == 13){
			$("#thirdBulgeRightdownWidth").select();
		}
	});

	$("#thirdBulgeRightdownWidth").keypress(function (e) {
		if (e.which == 13){
			$("#btnSizeCondStepSave").focus();
		}
	});
	

    //새로 등록시 값 0세팅
    function viewSetData()	{
    	//$(".number-float1, .number-").val("0");
    	//$(".step-number-float3").val("0");
    	$(".thridStep").val("0");
    }
    
	//평균 구하기
	function average()	{
		var tempDivsion = 0;
		if ( $('#firstStepSearch').val() == "success" ){
			tempDivsion += 1;
		}
		if ( $('#secondStepSearch').val() == "success" ){
			tempDivsion += 1;
		}
		if ( $('#thirdStepSearch').val() == "success" ){
			tempDivsion += 1;
		}
		var temp = ((parseFloat(wpLeft1) + parseFloat(wpLeft2) + parseFloat(wpLeft3) + parseFloat(ppLeft1) + parseFloat(ppLeft2) + parseFloat(ppLeft3)) / tempDivsion ).toFixed(1);
		$("#average").val(temp);
	}

	//종물 치수입력 키보드
	var stepTagId = "";
	var stepTemp = "";
	$('.step_num_only').focusout(function() {
		stepTagId = $(this).attr('id');
	});

	$('#stepNumber0').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();		
		if (stepTemp == "0"){
			$('#'+stepTagId).val("0");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("0"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber1').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("1");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("1"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber2').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("2");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("2"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber3').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("3");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("3"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber4').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("4");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("4"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber5').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("5");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("5"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber6').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("6");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("6"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber7').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("7");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("7"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber8').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("8");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("8"));
		}
		stepNumberFloat3();
	});
	$('#stepNumber9').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("9");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("9"));
		}
		stepNumberFloat3();
	});
	$('#stepDot').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		if (stepTemp == "0"){
			$('#'+stepTagId).val("0.");
		} else{
			$('#'+stepTagId).val(stepTemp.concat("."));
		}
		stepNumberFloat3();
	});

	//백스페이스
	$('#stepBackSpace').on('click', function () {
		let stepTemp = $('#'+stepTagId).val();
		stepTemp = stepTemp.slice(0,-1); //문자
		$('#'+stepTagId).val(stepTemp);
		stepNumberFloat3();
	});

	$('.step_num_only').on('click', function() {
		$(this).select();
	});
	
	//엔터
	$('#stepEnter').on('click', function () {
		//해당아이디 엔터 강제이벤트로 가기
		if (stepTagId == "thirdWpLeftAlwnce"){
			$('#thirdWpRightAlwnce').select();
		} else 	if (stepTagId == "thirdWpRightAlwnce"){
			$('#thirdPitchLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPitchLeftAlwnce"){
			$('#thirdPitchRightAlwnce').select();
		} else 	if (stepTagId == "thirdPitchRightAlwnce"){
			$('#thirdPpfWingLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPpfWingLeftAlwnce"){
			$('#thirdPpfWingRightAlwnce').select();
		} else 	if (stepTagId == "thirdPpfWingRightAlwnce"){
			$('#thirdPpfDepthLeftAlwnce').select();
		} else 	if (stepTagId == "thirdPpfDepthLeftAlwnce"){
			$('#thirdPpfDepthRightAlwnce').select();
		} else 	if (stepTagId == "thirdPpfDepthRightAlwnce"){
			$('#thirdFilmAlwnce').select();
		} else 	if (stepTagId == "thirdFilmAlwnce"){
			$('#thirdMetalDepthAlwnce').select();
		} else 	if (stepTagId == "thirdMetalDepthAlwnce"){
			$('#thirdMetalThicknessAlwnce').select();
		} else 	if (stepTagId == "thirdMetalThicknessAlwnce"){
			$('#thirdThCenterAlwnce').select();
		} else 	if (stepTagId == "thirdThCenterAlwnce"){
			$('#thirdThEdgeAlwncePlus').select();
		} else 	if (stepTagId == "thirdThEdgeAlwncePlus"){
			$('#thirdBurrMetalAlwnce').select();
		} else 	if (stepTagId == "thirdBurrMetalAlwnce"){
			$('#thirdBurrRcutAlwnce').select();
		} else 	if (stepTagId == "thirdBurrRcutAlwnce"){
			$('#thirdBurrRedgeAlwnce').select();
		} else 	if (stepTagId == "thirdBurrRedgeAlwnce"){
			$('#thirdBulgeLeftupHeight').select();
		} else 	if (stepTagId == "thirdBulgeLeftupHeight"){
			$('#thirdBulgeLeftupWidth').select();
		} else 	if (stepTagId == "thirdBulgeLeftupWidth"){
			$('#thirdBulgeLeftdownHeight').select();
		} else 	if (stepTagId == "thirdBulgeLeftdownHeight"){
			$('#thirdBulgeLeftdownWidth').select();
		} else 	if (stepTagId == "thirdBulgeLeftdownWidth"){
			$('#thirdBulgeRightupHeight').select();
		} else 	if (stepTagId == "thirdBulgeRightupHeight"){
			$('#thirdBulgeRightupWidth').select();
		} else 	if (stepTagId == "thirdBulgeRightupWidth"){
			$('#thirdBulgeRightdownHeight').select();
		} else 	if (stepTagId == "thirdBulgeRightdownHeight"){
			$('#thirdBulgeRightdownWidth').select();
		} else 	if (stepTagId == "thirdBulgeRightdownWidth"){
			$('#btnSizeCondStepSave').focus();
		}
		
		//$(".num_only").trigger("keyup");
	});

	function stepNumberFloat3(){
		//if ( !(	(event.which >= 48 && event.which <= 57) || (event.which >= 96 && event.which <= 105) || (event.which >= 37 && event.which <= 40) || event.which == 8 || event.which == 9 || event.which == 13 || event.which == 16 || event.which == 46 || event.which == 109|| event.which == 110 || event.which == 189 || event.which == 190)	) {
		//	$('.number-').on("blur keyup", function() {
		//		$('#'+stepTagId).val( $('#'+stepTagId).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
		//	});
		//	toastr.warning('양수(+)만 입력해주세요.');
		//	event.preventDefault();
		//	$('#'+stepTagId).val("0");
 		//	$('#'+stepTagId).select();
		//	return false;
		//}
		console.log($('#'+stepTagId).val());
 		if ($('#'+stepTagId).val() == "00" || $('#'+stepTagId).val() == "") {
			$('#'+stepTagId).val("0");
			$('#'+stepTagId).select();
			return false;
		}
 		if ($('#'+stepTagId).attr("maxlength") < $('#'+stepTagId).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
 		if ( parseFloat($('#'+stepTagId).attr("max")) < parseFloat($('#'+stepTagId).val())) {
			toastr.warning('최대 크기를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
 		if ( parseFloat($('#'+stepTagId).attr("min")) > parseFloat($('#'+stepTagId).val())) {
			toastr.warning('최소 크기를 초과하였습니다.');
			$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
			return false;
		}
		// .개수 세기
		if ( $('#'+stepTagId).val().split('.').length > 2  ) {
			toastr.warning('소수점은 한번만 입력해주세요.');
			$('#'+stepTagId).val("0");
			$('#'+stepTagId).select();
			return false;
		}
		//소수점 자리수 제한
 		var _pattern3 = /^\d*[.]\d{4}$/;	//누르고있는 키는 예외처리 안됨
        if (_pattern3.test( $('#'+stepTagId).val())) {
        	toastr.warning("소수점 셋째 자리까지 입력 가능합니다.");
        	$('#'+stepTagId).val("0");
 			$('#'+stepTagId).select();
            return false;
		}
	}
	
	//숫자만 입력, 길이, 소수점 세자리까지 제한
	//$('.step-number-float3').keyup(function (event) {
 	//	
	//});
	
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
	$('#rightCardClose').on('click', function(){
		if( sideView == 'add' || sideView == 'edit' ){
			$('#closePopupModal').modal('show');
			return false;
		}
  	  	$("#left-list").animate({
			width : "99%"
		}, 200);
		$("#myrSidenav").animate({
			width : "0%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'block');
		});
	});

	$('#arrowLeft').on('click', function(){
  	  	$("#left-list").animate({
			width : "50%"
		}, 200);
		$("#myrSidenav").animate({
			width : "49%"
		}, 200, function(){
			$('#arrowLeft').css('display', 'none');
		});
	});

	function getDateType(date) {
		return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
	}
	
	//function appearUpdate() {
	//	//작업지시에 외관검사 Update
   	//	$.ajax({
    //   		url: '<c:url value="qm/appearWorkOrderInsert"/>',
	//		type: 'POST',
	//		data: {
	//			'menuAuth'	 			: 	menuAuth,
	//			'ordLotNo'				:	$('#ordLotNo').val(),			//작지번호스캔(작업지시)
	//			'appearInspctCharger'	:	$('#userNumber').val(),			//검사담당(사번코드)
	//			'appearInspctDate'		:	$('#appearInspctDate').val().replace(/-/g,""),	
	//			'appearOutputCnt'		:	parseInt($('#edgeOutputCnt').val() - sum),		//외관 양품 개수				
	//			'appearFaultyCnt'		:	function(){return sum},	//외관 총 불량 개수
	//		},
	//		success: function (res) {
	//			let appearFaultyCnt = res.data;
	//			$('#appearInspctDate').attr('disabled',true);
	//			if( res.result == 'ok' ){
	//				if(searchData == true) {
	//					toastr.success("외관검사 불량 수정 되었습니다.");
	//				}
	//				else if(searchData == false){
	//					toastr.success("외관검사 불량 저장 되었습니다. 종물을 등록해 주세요!");
	//				}
	//				$('#appearFaultyCnt').val(addCommas(appearFaultyCnt));
	//			} else if ( res.result == 'fail' ){
	//				toastr.error(res.message, '', {timeOut: 5000});
	//			}
	//		},
	//		complete:function(){
	//			$('#goodsFaultyAdmTable').DataTable().ajax.reload();
	//			viewDisabled(true);
	//			$('#searchUser').attr("disabled", true);
	//			$('#btnSave').attr("disabled", true);
	//			$('#btnSizeCondStep').attr("disabled", false);
	//			$("#btnSizeCondStep").focus();
	//		}
	//	});
	//}

	$('#tab1').click(function(){	
		$('#metalFaultyDiv').removeClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcFaultyDiv').addClass("d-none");
		$('#visionFaultyDiv').addClass("d-none");
		$('#faultyDiv5').addClass("d-none");
// 		$('#faultyDiv6').addClass("d-none");
	});
	
	$('#tab2').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').removeClass("d-none");
		$('#etcFaultyDiv').addClass("d-none");
		$('#visionFaultyDiv').addClass("d-none");
		$('#faultyDiv5').addClass("d-none");
// 		$('#faultyDiv6').addClass("d-none");
	});
	
	$('#tab3').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcFaultyDiv').removeClass("d-none");
		$('#visionFaultyDiv').addClass("d-none");
		$('#faultyDiv5').addClass("d-none");
// 		$('#faultyDiv6').addClass("d-none");
	});

	$('#tab4').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcFaultyDiv').addClass("d-none");
		$('#visionFaultyDiv').removeClass("d-none");
		$('#faultyDiv5').addClass("d-none");
// 		$('#faultyDiv6').addClass("d-none");
	});

	$('#tab5').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcFaultyDiv').addClass("d-none");
		$('#visionFaultyDiv').addClass("d-none");
		$('#faultyDiv5').removeClass("d-none");
// 		$('#faultyDiv6').addClass("d-none");
	});

	/*$('#tab6').click(function(){
		$('#metalFaultyDiv').addClass("d-none");
		$('#filmFaultyDiv').addClass("d-none");
		$('#etcFaultyDiv').addClass("d-none");
		$('#visionFaultyDiv').addClass("d-none");
		$('#faultyDiv5').addClass("d-none");
// 		$('#faultyDiv6').removeClass("d-none");
	});*/

	function metalFaultyHdCreate(){
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index, item){				
    		if(item.etc1 == '001'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="metal'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="metalCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
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
           
		$('#metalFaultyTbody').html(Hd_metal); 	
	}

	function filmFaultyHdCreate(){
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '002'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="film'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="filmCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
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

           
		$('#filmFaultyTbody').html(Hd_metal); 	
	}

	function etcFaultyHdCreate(){
    	var Hd_metal = '';  
    	var Hd_metal1 = '<tr>';
    	var Hd_metal2 = '<tr>';
		var arrayLength = 0;
    	
    	$.each(systemCommonCode, function(index,item){				
    		if(item.etc1 == '003'){ 
        		
    			Hd_metal1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_metal2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="etc'+item.baseCd+'" disabled>';
    			Hd_metal2 += '<input type="hidden" id="etcCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
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

           
		$('#etcFaultyTbody').html(Hd_metal); 	
	}

	function visionFaultyHdCreate(){
    	var Hd_vision	= '';  
    	var Hd_vision1	= '<tr>';
    	var Hd_vision2	= '<tr>';
		var arrayLength = 0;
		var count		= 0;
		var rtn 		= '<col width="11%">'
    	
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '004'){ 
        		count++;
        		
    			Hd_vision1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_vision2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="vision'+item.baseCd+'" disabled>';
    			Hd_vision2 += '<input type="hidden" id="etcCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_vision1 += '</tr>';
	    			Hd_vision2 += '</tr>';
	    			Hd_vision += Hd_vision1;
	    			Hd_vision += Hd_vision2;
	    			Hd_vision1 = '';
	    			Hd_vision2 = '';
	    			Hd_vision1 += '<tr>';
        			Hd_vision2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_vision += Hd_vision1;
		Hd_vision += Hd_vision2;
		
		$('#visionFaultyTbody').html(Hd_vision);

		if(count <= 8){
			for(var i=0; i<count; i++){
				$('#visionFaultyDiv table colgroup').append(rtn);
			}
		}else{
			for(var i=0; i<8; i++){
				$('#visionFaultyDiv table colgroup').append(rtn);
			}
		}
	}

	//5 부불량
	function faultyHdCreate5(){
    	var Hd_5	= '';  
    	var Hd_5_1	= '<tr>';
    	var Hd_5_2	= '<tr>';
		var arrayLength = 0;
		var count		= 0;
		var rtn 		= '<col width="11%">'
    	
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '005'){ 
        		count++;
        		
    			Hd_5_1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_5_2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="5'+item.baseCd+'" disabled>';
    			Hd_5_2 += '<input type="hidden" id="etcCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_5_1 += '</tr>';
	    			Hd_5_2 += '</tr>';
	    			Hd_5 += Hd_5_1;
	    			Hd_5 += Hd_5_2;
	    			Hd_5_1 = '';
	    			Hd_5_2 = '';
	    			Hd_5_1 += '<tr>';
        			Hd_5_2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_5 += Hd_5_1;
		Hd_5 += Hd_5_2;
		
		$('#faultyTbody5').html(Hd_5);

		if(count <= 8){
			for(var i=0; i<count; i++){
				$('#faultyDiv5 table colgroup').append(rtn);
			}
		}else{
			for(var i=0; i<8; i++){
				$('#faultyDiv5 table colgroup').append(rtn);
			}
		}
	}

	//6 부불량
	/*function faultyHdCreate6(){
    	var Hd_6	= '';  
    	var Hd_6_1	= '<tr>';
    	var Hd_6_2	= '<tr>';
		var arrayLength = 0;
		var count		= 0;
		var rtn 		= '<col width="11%">'
    	
    	$.each(systemCommonCode, function(index,item){
    		if(item.etc1 == '006'){ 
        		count++;
        		
    			Hd_6_1 += '<th>'+item.baseCdNm+'</th>';
    			Hd_6_2 += '<td><input maxlength="6" min="0" max="100000" step="1" type="number" class="form-control num_only num_sum text-right touch6" id="6'+item.baseCd+'" disabled>';
    			Hd_6_2 += '<input type="hidden" id="etcCd'+arrayLength+'" value="'+item.baseCd+'"> </td>';
    			
    			arrayLength++;  
	    		if((arrayLength+1)%8==1){
	    			Hd_6_1 += '</tr>';
	    			Hd_6_2 += '</tr>';
	    			Hd_6 += Hd_6_1;
	    			Hd_6 += Hd_6_2;
	    			Hd_6_1 = '';
	    			Hd_6_2 = '';
	    			Hd_6_1 += '<tr>';
        			Hd_6_2 += '<tr>';
	        	} 
        	}
		});		
    	Hd_6 += Hd_6_1;
		Hd_6 += Hd_6_2;
		
		$('#faultyTbody6').html(Hd_6);

		if(count <= 8){
			for(var i=0; i<count; i++){
				$('#faultyDiv6 table colgroup').append(rtn);
			}
		}else{
			for(var i=0; i<8; i++){
				$('#faultyDiv6 table colgroup').append(rtn);
			}
		}
	}*/

	function numberPad(n, width) {
	    n = n + '';
	    return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
	}

	$(".number").keyup(function(evt) {
 		if ($(this).attr("maxlength") < $(this).val().length) {
			toastr.warning('최대 입력 글자를 초과하였습니다.');
			$(this).val("0");
			$(this).select();
			return false;
		}
 		if ( parseFloat($(this).attr("max")) < parseFloat($(this).val())) {
 			$(this).val("0");
			$(this).select();
			toastr.warning('최대 수치를 초과하였습니다.');
			return false;
		}
 		if ( parseFloat($(this).attr("min")) > parseFloat($(this).val())) {
 			$(this).val("0");
			$(this).select();
			toastr.warning('최소 크기를 초과하였습니다.');
			return false;
		}
		
        //입력 정규식 0~9 .
    	reg = /[^0-9.]/gi;
    	let temp = $(this).val().replace(/,/g, '');
    	if (reg.test(temp)) {
    		toastr.warning("숫자만 입력해 주세요.")
    		$(this).val("0");
			$(this).select();
    		return false;
    	}
    	
        var charCode = (evt.which) ? evt.which : event.keyCode;
		//toastr.warning(charCode);
		if ( !(	(charCode > 36 && charCode < 41) || (charCode > 47 && charCode < 58) || (charCode > 95 && charCode < 106) || ( charCode == 8 || charCode == 9 || charCode == 13 || charCode == 46 || charCode == 110 || charCode == 190)	)	){
			toastr.warning("숫자만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
			return false;
		}
		
		// 1000 이하의 숫자만 입력가능
		//var _pattern1 = /^\d{4}$/; // 현재 value값이 3자리 숫자이면 . 만 입력가능
		//if (_pattern1.test(costUnit)) {
		//	toastr.warning("1000이하로 입력가능합니다.")
	    //	$(this).val($(this).val().slice(0,-1));
	    //    return false;
		//}

		// 소수점(.)이 두번 이상 나오지 못하게
		var _pattern0 = /^\d*[.]\d*$/; // 현재 value값에 소수점(.) 이 있으면 . 입력불가
		if (_pattern0.test(temp)) {
			toastr.warning("정수만 입력해 주세요.")
			$(this).val("0");
			$(this).select();
		}
		//else {
		//	if ( charCode == 110 || charCode == 190 ) {
		//		toastr.warning(".는 한번만 입력 가능합니다.")
		//		$(this).val(	addCommas(temp.slice(0,-1))	);
		//		return false;
        //    }
		//}
		
		// 소수점 첫째자리까지만 입력가능
		//var _pattern2 = /^\d*[.]\d{2}$/; // 현재 value값이 소수점 둘째짜리 숫자이면 더이상 입력 불가
		//if (_pattern2.test(costUnit)) {
		//	toastr.warning("소수점 첫째자리까지 입력가능합니다.")
		//	$(this).val(	addCommas(costUnit.slice(0,-1))	);
		//	return false;
		//}
		//if( parseInt(temp) > parseInt($("#outputCnt").val().replace(/,/g, ''))){
		//	toastr.warning("입력값이 생산수량을 초과 할 수 없습니다.");
		//	$(this).val("0");
		//	$(this).select();
		//	return false;
		//}
		
		$(this).val(addCommas(temp));
    });

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
        	$('#outputCardTable').DataTable().clear().draw();
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
	    	$('#outputCardTable').DataTable().clear().draw();
   	   	}else{
   	   		$('#workOrdNoScan').focus();
		}
	}
	

</script>
</body>
</html>