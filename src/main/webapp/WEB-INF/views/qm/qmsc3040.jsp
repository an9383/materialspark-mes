<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp"%>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar">
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">공정기술</a></li>
				<li class="breadcrumb-item active">초중말물관리</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<!--======================== .left-list ========================-->
		<div class="col-md-12 matrl-top-list">
			<!-- /.card -->
			<div class="card">
				<!--=====================-->
				<!-- .table-responsive -->
				<div class="table-responsive">
					<table class="table table-bordered table-td-center" id="workOrderTable">
						<thead class="thead-light">
							<tr>
								<th>생산일</th>
								<th>설비명</th>
								<th>거래처</th>
								<th>제품</th>
								<th>재질</th>
								<th>규격</th>
								<th>LOT NO</th>
								<th class="text-center">생산수량</th>
								<th>작업조</th>
								<th>작업자</th>
								<th>작지번호</th>								
							</tr>
						</thead>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
		</div>
		<!-- /.left-list -->
		<!--======================== .right-sidebar 등록,수정 ========================-->
		<div class="col-md-12 matrl-bottom-list" id="">
			<!-- <h6> 자재 정보 <span id="formText"></span></h6> -->
			<!-- 등록, 수정 -->
			<div class="card" id="formBox">
				<div class="card-body col-sm-12">
					<h6>치수검사</h6>
				</div>
				<form id="form">					
					<div class="table-responsive">
							<table class="table table-bordered" id="sizeCheckTable" style="text-align:center">
							<thead class="thead-light">
							<tr>
								<th style="min-width: 50px">구분</th>								
								<th style="min-width: 50px" colspan="13">MES 연동치수</th>
								<th style="min-width: 50px" colspan="7">Manual 측정 치수</th>
				
							</tr>
							
							<tr>
								<th style="vertical-align:middle;" id="lgSkGubun">SK on</th>
								<th style="vertical-align:middle;" id="metalDepthCondNm0">Metal 폭</th>
								<th style="vertical-align:middle;" id="pitchLeftCondNm0">Metal 총길이</th>
								<th style="vertical-align:middle;" id="ppfDepthLeftCondNm0">Film 폭 (좌)</th>
								<th style="vertical-align:middle;" id="ppfDepthCenterCondNm0">Film 폭 (중)</th>
								<th style="vertical-align:middle;" id="ppfDepthRightCondNm0">Film 폭 (우)</th>
								<th style="vertical-align:middle;" id="filmCondNm0">Film 총길이</th>
								<th style="vertical-align:middle;" id="wpLeftCondNm0">Welding Part (좌)</th>
								<th style="vertical-align:middle;" id="wpCenterCondNm0">Welding Part (중)</th>
								<th style="vertical-align:middle;" id="wpRightCondNm0">Welding Part (우)</th>
								<th style="vertical-align:middle;" id="wpDeviationCondNm0">Welding Part 좌/우 편차</th>
								<th style="vertical-align:middle;" id="x1X2CondNm0">대각선 길이 편차 (X1 – X2)</th>
								<th style="vertical-align:middle;" id="ppfWingLeftCondNm0">날개 Margin (좌)</th>
								<th style="vertical-align:middle;" id="ppfWingRightCondNm0">날개 Margin (우)</th>
								<th style="vertical-align:middle;" id="metalThicknessCondNm0">Metal 두께</th>
								<th style="vertical-align:middle;" id="thEdgeCondNm0">총 두께 (Edge 좌)</th>
								<th style="vertical-align:middle;" id="thCenterCondNm0">총 두께 (Center)</th>
								<th style="vertical-align:middle;" id="thEdgeRightCondNm0">총 두께 (Edge 우)</th>
								<th style="vertical-align:middle;" id="burrCondNm0">Metal Burr</th>
								<th style="vertical-align:middle;" id="gapOfLayerCondNm0">Layer</th>
								<th style="vertical-align:middle;" id="bendingCondNm0">Bending</th>																							
							</tr>
							<tr>
								<th id="lgSkGubun1">LGES</th>
								<th id="metalDepthCondNm1">d</th>
								<th id="pitchLeftCondNm1">L</th>
								<th id="ppfDepthLeftCondNm1">l1</th>
								<th id="ppfDepthCenterCondNm1">l2</th>
								<th id="ppfDepthRightCondNm1">l3</th>
								<th id="filmCondNm1">W</th>
								<th id="wpLeftCondNm1">S1</th>
								<th id="wpCenterCondNm1">S2</th>
								<th id="wpRightCondNm1">S3</th>
								<th id="wpDeviationCondNm1">S1-S3</th>
								<th id="x1X2CondNm1">X1-X2</th>
								<th id="ppfWingLeftCondNm1">M1</th>
								<th id="ppfWingRightCondNm1">M2</th>
								<th id="metalThicknessCondNm1">t</th>
								<th id="thEdgeCondNm1">T1</th>
								<th id="thCenterCondNm1">T2</th>
								<th id="thEdgeRightCondNm1">T3</th>
								<th id="burrCondNm1">Burr</th>
								<th id="gapOfLayerCondNm1">g</th>
								<th id="bendingCondNm1">b</th>																							
							</tr>
							</thead>
							<tr>
								<th>조건	</th>								
								<td><span id="metalDepthCond0"></span></td>
								<td><span id="pitchLeftCond0"></span></td>
								<td><span id="ppfDepthLeftCond0"></span></td>
								<td><span id="ppfDepthCenterCond0"></span></td>
								<td><span id="ppfDepthRightCond0"></span></td>
								<td><span id="filmCond0"></span></td>
								<td><span id="wpLeftCond0"></span></td>
								<td><span id="wpCenterCond0"></span></td>
								<td><span id="wpRightCond0"></span></td>
								<td><span id="wpDeviationCond0"></span></td>
								<td><span id="x1X2Cond0"></span></td>
								<td><span id="ppfWingLeftCond0"></span></td>
								<td><span id="ppfWingRightCond0"></span></td>
								<td><span id="metalThicknessCond0"></span></td>
								<td><span id="thEdgeCond0"></span></td>
								<td><span id="thCenterCond0"></span></td>
								<td><span id="thEdgeRightCond0"></span></td>
								<td><span id="burrCond0"></span></td>
								<td><span id="gapOfLayerCond0"></span></td>
								<td><span id="bendingCond0"></span></td>
								
								
							</tr>
							<tr>
								<th>초물</th>
								<td><span id="firstMetalDepthAlwnce1"></span></td>
								<td><span id="firstPitchLeftAlwnce1"></span></td>
								<td><span id="firstPpfDepthLeftAlwnce1"></span></td>
								<td><span id="firstPpfDepthCenterAlwnce1"></span></td>
								<td><span id="firstPpfDepthRightAlwnce1"></span></td>
								<td><span id="firstFilmAlwnce1"></span></td>
								<td><span id="firstWpLeftAlwnce1"></span></td>
								<td><span id="firstWpCenterAlwnce1"></span></td>
								<td><span id="firstWpRightAlwnce1"></span></td>
								<td><span id="firstWpDeviationAlwnce1"></span></td>
								<td><span id="firstX1X2Alwnce1"></span></td>
								<td><span id="firstPpfWingLeftAlwnce1"></span></td>
								<td><span id="firstPpfWingRightAlwnce1"></span></td>
								<td><span id="firstMetalThicknessAlwnce1"></span></td>
								<td><span id="firstThEdgeAlwnce1"></span></td>
								<td><span id="firstThCenterAlwnce1"></span></td>
								<td><span id="firstThEdgeRightAlwnce1"></span></td>
								<td><span id="firstBurrAlwnce1"></span></td>
								<td><span id="firstGapOfLayerAlwnce1"></span></td>
								<td><span id="firstBendingAlwnce1"></span></td>								
								
							</tr>     
							<tr>                                   
								<th>중물</th>
								<td><span id="secondMetalDepthAlwnce2"></span></td>
								<td><span id="secondPitchLeftAlwnce2"></span></td>
								<td><span id="secondPpfDepthLeftAlwnce2"></span></td>
								<td><span id="secondPpfDepthCenterAlwnce2"></span></td>
								<td><span id="secondPpfDepthRightAlwnce2"></span></td>
								<td><span id="secondFilmAlwnce2"></span></td>
								<td><span id="secondWpLeftAlwnce2"></span></td>
								<td><span id="secondWpCenterAlwnce2"></span></td>
								<td><span id="secondWpRightAlwnce2"></span></td>
								<td><span id="secondWpDeviationAlwnce2"></span></td>
								<td><span id="secondX1X2Alwnce2"></span></td>
								<td><span id="secondPpfWingLeftAlwnce2"></span></td>
								<td><span id="secondPpfWingRightAlwnce2"></span></td>
								<td><span id="secondMetalThicknessAlwnce2"></span></td>
								<td><span id="secondThEdgeAlwnce2"></span></td>
								<td><span id="secondThCenterAlwnce2"></span></td>
								<td><span id="secondThEdgeRightAlwnce2"></span></td>
								<td><span id="secondBurrAlwnce2"></span></td>
								<td><span id="secondGapOfLayerAlwnce2"></span></td>
								<td><span id="secondBendingAlwnce2"></span></td>
							</tr>            
							<tr>             
								<th>말물</th>
								<td><span id="thirdMetalDepthAlwnce3"></span></td>
								<td><span id="thirdPitchLeftAlwnce3"></span></td>
								<td><span id="thirdPpfDepthLeftAlwnce3"></span></td>
								<td><span id="thirdPpfDepthCenterAlwnce3"></span></td>
								<td><span id="thirdPpfDepthRightAlwnce3"></span></td>
								<td><span id="thirdFilmAlwnce3"></span></td>
								<td><span id="thirdWpLeftAlwnce3"></span></td>
								<td><span id="thirdWpCenterAlwnce3"></span></td>
								<td><span id="thirdWpRightAlwnce3"></span></td>
								<td><span id="thirdWpDeviationAlwnce3"></span></td>
								<td><span id="thirdX1X2Alwnce3"></span></td>
								<td><span id="thirdPpfWingLeftAlwnce3"></span></td>
								<td><span id="thirdPpfWingRightAlwnce3"></span></td>
								<td><span id="thirdMetalThicknessAlwnce3"></span></td>
								<td><span id="thirdThEdgeAlwnce3"></span></td>
								<td><span id="thirdThCenterAlwnce3"></span></td>
								<td><span id="thirdThEdgeRightAlwnce3"></span></td>
								<td><span id="thirdBurrAlwnce3"></span></td>
								<td><span id="thirdGapOfLayerAlwnce3"></span></td>
								<td><span id="thirdBendingAlwnce3"></span></td>
							</tr>
						</table>
					</div>					
				</form>
			</div>
			<div class="mt-2">
				<button type="button" class="btn btn-primary d-none float-right" id="btnSave">저장</button>
				<button class="btn btn-primary d-none" id="btnAddConfirmLoading" type="button" disabled="">
					<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
				</button>
			</div>
			<!--// 등록, 수정 -->
		</div>
		<!-- .right-sidebar -->
	</div>
	<!-- / #main  -->
</div>
<!-- /.page-wrapper -->

<!-- 생산실적전표번호 초,중물 모달 시작-->
<div class="modal fade bd-example-modal-lg" id="ordLotNoStepModal" tabindex="-1" role="dialog" aria-labelledby="matrlDtlTableModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" style="min-width:800px;">
		<div class="modal-content">
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
								<li class="nav-item"><a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">MES 연동치수</a></li>
								<li class="nav-item"><a class="nav-link" id="tab2Nav" data-toggle="tab" href="#tab2">Manual 측정치수</a></li>
								<li class="nav-item ml-auto">
									<button type="button" class="btn btn-danger float-left mr-2 touch5" id="btnStepDelete">삭제</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepSave">저장</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepEdit">수정</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnFirstStepInsert" disabled>초물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnSecondStepInsert" disabled>중물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnThirdStepInsert" disabled>말물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepReload">조회</button>
								</li>
							</ul>
							<div class="card-body p-0">
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade active show" id="tab1">
										<table class="table table-bordered d-none">
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
						                        <th class="touch3">말물</th>
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
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWarmupCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">가접1</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="fitup1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="fitup1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">가접2</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="fitup2UpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup2UpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="fitup2DownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup2DownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="fitup2UprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2UprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2UprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup2UprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="fitup2DownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFitup2DownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFitup2DownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFitup2DownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">롤히터</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="rollheatUpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatUpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatUpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdRollheatUpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="rollheatDownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstRollheatDownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondRollheatDownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdRollheatDownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">1차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="firstUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFirstUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="firstDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFirstDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="firstUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFirstUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="firstDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFirstDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFirstDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFirstDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">1차 푸셔</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="push1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPush1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="push1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPush1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPush1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPush1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">2차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="secondUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdSecondUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="secondDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdSecondDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="secondUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdSecondUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="secondDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstSecondDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondSecondDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdSecondDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="4">3차</th>
												<th class="touch3">(상좌)</th>
												<th class="touch3"><span id="thirdUpleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUpleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThirdUpleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하좌)</th>
												<th class="touch3"><span id="thirdDownleftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownleftCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThirdDownleftCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(상우)</th>
												<th class="touch3"><span id="thirdUprightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdUprightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThirdUprightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하우)</th>
												<th class="touch3"><span id="thirdDownrightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThirdDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThirdDownrightCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThirdDownrightCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">진접1</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="jinjeop1UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdJinjeop1UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="jinjeop1DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop1DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdJinjeop1DownCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3" rowspan="2">진접2</th>
												<th class="touch3">(상)</th>
												<th class="touch3"><span id="jinjeop2UpCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2UpCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdJinjeop2UpCond" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(하)</th>
												<th class="touch3"><span id="jinjeop2DownCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstJinjeop2DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondJinjeop2DownCond"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdJinjeop2DownCond" disabled></td>
											</tr>
										</table>
										<table class="table table-bordered">
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="40%"></colgroup>											
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="15%"></colgroup>
											<tr>
												<th colspan="2" class="touch3">연동 치수 항목</th>
						                        <th colspan="3" class="touch3">측정시간</th>
											</tr>
											<tr>
												<th rowspan="3" class="touch3"><span name="skLgGubun">SK on</span></th>
												<th rowspan="3" class="touch3">조건</th>
											</tr>
											<tr>
												<th class="touch3">초물</th>
						                        <th class="touch3">중물</th>
						                        <th class="touch3">말물</th>
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
												<th rowspan="" class="touch3"><span class="cond touch3" id="metalDepthCondNm"></span></th>												
												<th><span class="cond touch3" id="metalDepthCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdMetalDepthAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="pitchLeftCondNm"></span></th>
												<th class="touch3"><span class="cond" id="pitchLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPitchLeftAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="ppfDepthLeftCondNm"></span></th>												
												<th class="touch3"><span class="cond" id=ppfDepthLeftCond></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfDepthLeftAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="ppfDepthCenterCondNm"></span></th>
												<th class="touch3"><span class="cond" id="ppfDepthCenterCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthCenterAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthCenterAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfDepthCenterAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="ppfDepthRightCondNm"></span></th>											
												<th class="touch3"><span class="cond" id="ppfDepthRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfDepthRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="filmCondNm"></span></th>
												<th class="touch3"><span class="cond" id="filmCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFilmAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th rowspan="" class="touch3"><span class="cond touch3" id="wpLeftCondNm"></span></th>											
												<th><span class="cond" id="wpLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpLeftAlwnce" disabled></td>
											</tr>
											<tr>                                                                                        
												<th rowspan="" class="touch3"><span class="cond touch3" id="wpCenterCondNm"></span></th>
												<th class="touch3"><span class="cond" id="wpCenterCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpCenterAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpCenterAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpCenterAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th class="touch3"><span class="cond touch3" id="wpRightCondNm"></span></th>										
												<th class="touch3"><span class="cond" id="wpRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="wpDeviationCondNm"></span></th>
												<th class="touch3"><span class="cond" id="wpDeviationCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpDeviationAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpDeviationAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpDeviationAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="x1X2CondNm"></span></th>
												<th class="touch3"><span class="cond" id="x1X2Cond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstX1X2Alwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondX1X2Alwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdX1X2Alwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="ppfWingLeftCondNm"></span></th>
												<th class="touch3"><span class="cond" id="ppfWingLeftCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingLeftAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingLeftAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfWingLeftAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="ppfWingRightCondNm"></span></th>
												<th class="touch3"><span class="cond" id="ppfWingRightCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingRightAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingRightAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfWingRightAlwnce" disabled></td>
											</tr>
										</table>
									</div>
									<div class="tab-pane fade" id="tab2">
										<table class="table table-bordered">
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="40%"></colgroup>											
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="15%"></colgroup>
											<colgroup><col width="15%"></colgroup>
											<tr>
												<th colspan="5" class="touch3">Manual 측정 치수</th>												
											</tr>											
											<tr>
												<th rowspan="2" class="touch3"><span name="skLgGubun">SK on</span></th>
												<th rowspan="2" class="touch3">조건</th>
											</tr>
											<tr>
												<th class="touch3">초물</th>
						                        <th class="touch3">중물</th>
						                        <th class="touch3">말물</th>
											</tr>											
											<!--  -->
											
											
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="metalThicknessCondNm"></span></th>
												<th class="touch3"><span class="cond" id="metalThicknessCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdMetalThicknessAlwnce" disabled></td>
											</tr>
											
											
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="thEdgeCondNm"></span></th>
												<th class="touch3"><span class="cond" id="thEdgeCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThEdgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThEdgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThEdgeAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="thCenterCondNm"></span></th>
												<th class="touch3"><span class="cond" id="thCenterCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThCenterAlwnce"disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="thEdgeRightCondNm"></span></th>
												<th class="touch3"><span class="cond" id="thEdgeRightCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThEdgeRightAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThEdgeRightAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThEdgeRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="burrCondNm"></span></th>
												<th class="touch3"><span class="cond" id="burrCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="gapOfLayerCondNm"></span></th>
												<th class="touch3"><span class="cond" id="gapOfLayerCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstGapOfLayerAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondGapOfLayerAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdGapOfLayerAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="" class="touch3"><span class="cond touch3" id="bendingCondNm"></span></th>
												<th class="touch3"><span class="cond" id="bendingCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBendingAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBendingAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBendingAlwnce" disabled></td>
											</tr>
											
											
										
											<!-- 2023.01.25 미사용 처리 -->
											<tr class="d-none">
												<th class="touch3">R-Cut</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrRcutAlwnce"disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">R끝단</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrRedgeAlwnce" disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="pitchRightCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPitchRightAlwnce" disabled></td>
											</tr>
											<tr class="d-none">
												<th rowspan="2" class="touch3">돌기크기<br>좌상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftupHeight" disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftupWidth" disabled></td>
											</tr>
											<tr class="d-none">
												<th rowspan="2" class="touch3">돌기크기<br>좌하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftdownHeight" disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftdownWidth" disabled></td>
											</tr>
											<tr class="d-none">
												<th rowspan="2" class="touch3">돌기크기<br>우상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightupHeight" disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightupWidth" disabled></td>
											</tr>
											<tr class="d-none">
												<th rowspan="2" class="touch3">돌기크기<br>우하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightdownHeight" disabled></td>
											</tr>
											<tr class="d-none">
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightdownWidth" disabled></td>
											</tr>
											<!-- 2023.01.25 미사용 처리 -->
											
											<!-- <tr>
												<th class="touch3">Bending (b)</th>												
												<th>LGES ( < 1.0),  SKon ( < 0.5)</th>
												<td class="text-center">OK</td>
												<td class="text-center">OK</td>
												<td class="text-center">-</td>
											</tr> -->
											
											
										</table>
										<%-- <table class="table table-bordered">
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
						                        <th class="touch3">말물</th>
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
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpLeftAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span id="wpRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondWpRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdWpRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">Pitch</th>
												<th class="touch3">(좌)</th>
												<th class="touch3"><span class="cond" id="pitchLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPitchLeftAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="pitchRightCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPitchRightAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPitchRightAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">P.P Film 날개</th>
												<th class="touch3">(좌)</th>
												<th class="touch3"><span class="cond" id="ppfWingLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingLeftAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingLeftAlwnce" ></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfWingLeftAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="ppfWingRightCond"></span></th>                                                                         
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfWingRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfWingRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfWingRightAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th rowspan="2" class="touch3">P.P Film 폭</th>
												<th class="touch3">(좌)</th>
												<th><span class="cond" id="ppfDepthLeftCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthLeftAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfDepthLeftAlwnce" disabled></td>
											</tr>
											<tr>                                                                                        
												<th class="touch3">(우)</th>
												<th class="touch3"><span class="cond" id="ppfDepthRightCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstPpfDepthRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondPpfDepthRightAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdPpfDepthRightAlwnce" disabled></td>
											</tr>
											<tr>                                
												<th class="touch3">Film</th>
												<th class="touch3">총길이</th>
												<th class="touch3"><span class="cond" id="filmCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondFilmAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdFilmAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">METAL</th>
												<th class="touch3">폭</th>
												<th class="touch3"><span class="cond" id="metalDepthCond"></span></th>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalDepthAlwnce"></td>
												<td><input maxlength="6" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdMetalDepthAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">두께</th>
												<th class="touch3"><span class="cond" id="metalThicknessCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondMetalThicknessAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdMetalThicknessAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="3" class="touch3">총두께</th>
												<th class="touch3">Center</th>
												<th class="touch3"><span class="cond" id="thCenterCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThCenterAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThCenterAlwnce" disabled></td>
											</tr>                                                                                       
											<tr>
												<th class="touch3">Edge</th>
												<th class="touch3"><span class="cond" id="thEdgeCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstThEdgeAlwncePlus"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondThEdgeAlwncePlus"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdThEdgeAlwncePlus" disabled></td>
											</tr>
											<tr>
												<th class="touch3">Edge2</th>
												<th class="touch3"><span class="cond" id="thEdge2Cond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstInput"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondInput"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdInput" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">엣지샘플</th>
												<th class="touch3">검사수</th>
												<th class="touch3"><span class="cond" id="thEdgeCnt"></span></th>
												<td><input maxlength="8" min="0" max="10000" type="number" step="1" class="form-control number-float3 firstStep touch3" id="firstThEdgeCnt"></td>
												<td><input maxlength="8" min="0" max="10000" type="number" step="1" class="form-control number-float3 secondStep touch3" id="secondThEdgeCnt"></td>
												<td><input maxlength="8" min="0" max="10000" type="number" step="1" class="form-control number-float3 thirdStep touch3" id="thirdThEdgeCnt" disabled></td>
											</tr>                                                                                       
											<tr>
												<th class="touch3">합불판정</th>
												<th class="touch3"><span class="cond" id="thEdgeResult"></span></th>
												<td><select class="custom-select firstStep touch3" id="firstThEdgeResult"></select></td>
												<td><select class="custom-select secondStep touch3" id="secondThEdgeResult"></select></td>
												<td><select class="custom-select thirdStep touch3" id="thirdThEdgeResult" disabled></select></td>
											</tr>
											<tr>
												<th rowspan="3" class="touch3">Burr (MAX)</th>
												<th class="touch3">Metal</th>
												<th class="touch3"><span class="cond" id="burrCond"></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrMetalAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrMetalAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrMetalAlwnce" disabled></td>
											</tr>
											<tr>
												<th class="touch3">R-Cut</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRcutAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrRcutAlwnce"disabled></td>
											</tr>
											<tr>
												<th class="touch3">R끝단</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBurrRedgeAlwnce"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBurrRedgeAlwnce" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>좌상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftupHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftupWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>좌하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftdownHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeLeftdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeLeftdownWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>우상</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightupHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightupWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightupWidth" disabled></td>
											</tr>
											<tr>
												<th rowspan="2" class="touch3">돌기크기<br>우하</th>
												<th class="touch3">높이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownHeight"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightdownHeight" disabled></td>
											</tr>
											<tr>
												<th class="touch3">넓이</th>
												<th class="touch3"><span class="cond" id=""></span></th>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 firstStep touch3" id="firstBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 secondStep touch3" id="secondBulgeRightdownWidth"></td>
												<td><input maxlength="8" min="0" max="1000" type="number" step="0.001" class="form-control number-float3 thirdStep touch3" id="thirdBulgeRightdownWidth" disabled></td>
											</tr>
										</table> --%>
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

<!-- 조건 확인 모달 시작 -->
<div class="modal fade" id="rangeCheckPopupModal" tabindex="-1" role="dialog" aria-labelledby="rangeCheckPopupModalLabel" aria-hidden="true" style="z-index:99999">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id=""> 조건 오차범위를 벗어납니다.</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6>저장 하시겠습니까?</h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary touch6" id="rangeCheckSave" data-dismiss="modal" style="min-width: 70px;">저장</button>
				<button type="button" class="btn btn btn-secondary touch6" id="rangeCheckClose" data-dismiss="modal" style="min-width: 70px;">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 조건 확인 모달 끝 -->

<%@include file="../layout/bottom.jsp"%>

<script>
	
	let menuAuth = 'qmsc3040';
	let currentHref = 'qmsc3040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","초중말물관리");

	var serverDateFrom = "${serverDateFrom}";
	let skLgGubun = '001'; 

	$.fn.dataTable.ext.errMode = 'none';
	let workOrderTable = $('#workOrderTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
	    language: lang_kor,
	    paging: true,
	    info: true,
	    ordering: true,
	    processing: true,
	    autoWidth: false,
	    lengthChange: true,
	    searching: true,
	    pageLength: 10,
	    ajax: {
	        url: '<c:url value="/qm/workOrderReadDataList"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'		: menuAuth,
	        	'ordDate'		: function() { return moment(serverDateFrom).format('YYYYMMDD'); },
	        	'floorGubun'	: function() { return $('#selFloorGubun option:selected').val() },
	        }	        
	    },
		columns: [
			{ data: 'ordDate',
				render: function(data, type, row) {
					if(data != "") {
						return moment(data).format("YYYY-MM-DD");
					} else {
						return "-";
					}
                }
			},
			{ data: 'equipNm'},
			{ data: 'dealCorpNm'},
			{ data: 'goodsNm'},
			{ data: 'qutyNm'},
			{ data: 'model'},
			{ data: 'lotNo'},
			{ data: 'outputCnt'},
			{ data: 'workTeamNm'},
			{ data: 'mainWorkChargrNm'},
			{ data: 'workOrdNo'},
		],
		order: [
			[ 0, 'asc' ],
		],
		columnDefs: [
	           { targets: [7], render: $.fn.dataTable.render.number( ',' ) },
	           { targets: [7], className: 'text-right' },
	        ],
	});
	
	let html1 = '<div class="row">&nbsp;';
		html1 += '<label class="input-label-sm">일자</label>';
		html1 += '<div class="form-group input-sub m-0 row">';
		html1 += '<input class="form-control" type="text" style="width:97px;" id="date" name="date" />';
		html1 += '<button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')" class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button">';
		html1 += '<span class="oi oi-calendar"></span> </button> </div>';
		
		html1 += '<select class="custom-select ml-2 mr-2" id="selFloorGubun" style="width: 70px;">';
		html1 += '<option value="">전체</option>';
		html1 += '<option value="D">4층</option>';
		html1 += '<option value="C">6층</option>';
		html1 += '</select>';
		
		html1 += '<button type="button"  class="btn btn-primary" id="btnView">조회</button>';
		html1 += '<button type="button" class="btn btn-primary ml-2" id="btnOrdLotNoThirdStepNew">말물</button></div>';
		
	$('#workOrderTable_length').html(html1);
	$('#date').val(serverDateFrom);

	$('#btnView').on('click', function() {
		serverDateFrom = $('#date').val();	
		$('#workOrderTable').DataTable().ajax.reload();		  
	});
	
	let workOrdNo		= null;
	let equipCondSeq	= null;
	let lotNo			= null;
	let ordLotNoStepCd	='003';
	let workStatusCd	= null;
	let equipNm			= null;
	let equipCd			= null;
	let factoryCode 	= "<%=factoryCode%>";
	let lineGubun		= null;
	
	if( factoryCode == "003" ) {
		$('#gubunEdge').text("Edge(좌)");
		$('#gubunEdge2').text("Edge(우)");
	} else {
		$('#gubunEdge').text("Edge");
		$('#gubunEdge2').text("Edge2");
	}
	
	$('#workOrderTable tbody').on('click','tr',function() {
		if ($(this).hasClass('selected')) {
			$(this).removeClass('selected');			
		} else {
			$('#workOrderTable').DataTable().$('tr.selected').removeClass('selected');
			$(this).addClass('selected');		
			workOrdNo		= workOrderTable.row(this).data().workOrdNo;
			equipCondSeq	= workOrderTable.row(this).data().equipCondSeq;
			lotNo			= workOrderTable.row(this).data().lotNo;
			workStatusCd	= workOrderTable.row(this).data().workStatusCd;
			equipNm			= workOrderTable.row(this).data().equipNm;
			equipCd			= workOrderTable.row(this).data().equipCd;
			lineGubun		= ( equipNm.substr(0,1) == 'C' ? "4Line" : null ); 

			if(workOrderTable.row(this).data().dealCorpCd == '00018'){
				skLgGubun = '002';
			} else{
				skLgGubun = '001';
			}
			
			readFunc();
		}	
	});

	function readFunc(){
		$.ajax({
	        url: '<c:url value="/qm/sizeCheckDataListNew"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: menuAuth,
	        	'workOrdNo'		: workOrdNo,
	        	'equipCondSeq'	: equipCondSeq,
	        	'lineGubun'		: lineGubun,
	        },
	        success: function(res){
	        	
	        	var sizeData = res.cond; 
	        	var stepData = res.step;
	        	//console.log(stepData);
	        	//console.log(sizeData);

				if(res.result == "ok") {		          
	            	$('#metalDepthCond0').text("");
	            	$('#pitchLeftCond0').text("");
	            	$('#ppfDepthLeftCond0').text("");
	            	$('#ppfDepthCenterCond0').text("");
	            	$('#ppfDepthRightCond0').text("");
	            	$('#filmCond0').text("");
	            	$('#wpLeftCond0').text("");
	            	$('#wpCenterCond0').text("");
	            	$('#wpRightCond0').text("");
	            	$('#wpDeviationCond0').text("");
	            	$('#x1X2Cond0').text("");
	            	$('#ppfWingLeftCond0').text("");
	            	$('#ppfWingRightCond0').text("");
	            	$('#metalThicknessCond0').text("");
	            	$('#thEdgeCond0').text("");
	            	$('#thCenterCond0').text("");
	            	$('#thEdgeRightCond0').text("");
	            	$('#burrCond0').text("");
	            	$('#gapOfLayerCond0').text("");
	            	$('#bendingCond0').text("");	            	

	            	if(sizeData.metalDepthCond != null){
	            	$('#metalDepthCond0').text('-'+sizeData.metalDepthAlwnceMinus + ' [' + sizeData.metalDepthCond + '] +' + sizeData.metalDepthAlwncePlus);
	            	}
	            	if(sizeData.pitchLeftCond != null){
	            	$('#pitchLeftCond0').text('-'+sizeData.pitchLeftAlwnceMinus + ' [' + sizeData.pitchLeftCond + '] +' + sizeData.pitchLeftAlwncePlus);
	            	}
	            	if(sizeData.ppfDepthLeftCond != null){
	            	$('#ppfDepthLeftCond0').text('-'+sizeData.ppfDepthLeftAlwnceMinus + ' [' + sizeData.ppfDepthLeftCond + '] +' + sizeData.ppfDepthLeftAlwncePlus);
	            	}
					if(sizeData.ppfDepthCenterCond != null){
						$('#ppfDepthCenterCond0').text('-'+sizeData.ppfDepthCenterAlwnceMinus + ' [' + sizeData.ppfDepthCenterCond + '] +' + sizeData.ppfDepthCenterAlwncePlus);
		            }
		            
					if(sizeData.ppfDepthRightCond != null){
	            	$('#ppfDepthRightCond0').text('-'+sizeData.ppfDepthRightAlwnceMinus + ' [' + sizeData.ppfDepthRightCond + '] +' + sizeData.ppfDepthRightAlwncePlus);
					}
	            	if(sizeData.filmCond != null){
	            	$('#filmCond0').text('-'+sizeData.filmAlwnceMinus + ' [' + sizeData.filmCond + '] +' + sizeData.filmAlwncePlus);
	            	}
	            	if(sizeData.wpLeftCond != null){
	            	$('#wpLeftCond0').text('-'+sizeData.wpLeftAlwnceMinus + ' [' + sizeData.wpLeftCond + '] +' + sizeData.wpLeftAlwncePlus);
	            	}
	            	if(sizeData.wpCenterCond != null){
	            	$('#wpCenterCond0').text('-'+sizeData.wpCenterAlwnceMinus + ' [' + sizeData.wpCenterCond + '] +' + sizeData.wpCenterAlwncePlus);
	            	}
	            	if(sizeData.wpRightCond != null){
	            	$('#wpRightCond0').text('-'+sizeData.wpRightAlwnceMinus + ' [' + sizeData.wpRightCond + '] +' + sizeData.wpRightAlwncePlus);
	            	}
	            	if(sizeData.wpDeviationCond != null){
	            	$('#wpDeviationCond0').text('-'+sizeData.wpDeviationAlwnceMinus + ' [' + sizeData.wpDeviationCond + '] +' + sizeData.wpDeviationAlwncePlus);
	            	}
	            	if(sizeData.x1X2Cond != null){
	            	$('#x1X2Cond0').text('-'+sizeData.x1X2AlwnceMinus + ' [' + sizeData.x1X2Cond + '] +' + sizeData.x1X2AlwncePlus);
	            	}
	            	if(sizeData.ppfWingLeftCond != null){
	            	$('#ppfWingLeftCond0').text('-'+sizeData.ppfWingLeftAlwnceMinus + ' [' + sizeData.ppfWingLeftCond + '] +' + sizeData.ppfWingLeftAlwncePlus);
	            	}
	            	if(sizeData.ppfWingRightCond != null){
	            	$('#ppfWingRightCond0').text('-'+sizeData.ppfWingRightAlwnceMinus + ' [' + sizeData.ppfWingRightCond + '] +' + sizeData.ppfWingRightAlwncePlus);
	            	}
	            	if(sizeData.metalThicknessCond != null){
	            	$('#metalThicknessCond0').text('-'+sizeData.metalThicknessAlwnceMinus + ' [' + sizeData.metalThicknessCond + '] +' + sizeData.metalThicknessAlwncePlus);
	            	}
	            	if(sizeData.thEdgeCond != null){
	            	$('#thEdgeCond0').text('-'+sizeData.thEdgeAlwnceMinus + ' [' + sizeData.thEdgeCond + '] +' + sizeData.thEdgeAlwncePlus);
	            	}
	            	if(sizeData.thCenterCond != null){
	            	$('#thCenterCond0').text('-'+sizeData.thCenterAlwnceMinus + ' [' + sizeData.thCenterCond + '] +' + sizeData.thCenterAlwncePlus);
	            	}
	            	if(sizeData.thEdgeRightCond != null){
	            	$('#thEdgeRightCond0').text('-'+sizeData.thEdgeRightAlwnceMinus + ' [' + sizeData.thEdgeRightCond + '] +' + sizeData.thEdgeRightAlwncePlus);
	            	}
	            	if(sizeData.burrCond != null){
	            	$('#burrCond0').text('-'+sizeData.burrAlwnceMinus + ' [' + sizeData.burrCond + '] +' + sizeData.burrAlwncePlus);
	            	}
	            	if(sizeData.gapOfLayerCond != null){
	            	$('#gapOfLayerCond0').text('-'+sizeData.gapOfLayerMinus + ' [' + sizeData.gapOfLayerCond + '] +' + sizeData.gapOfLayerPlus);
	            	}
	            	if(sizeData.bendingCond != null){
	            	$('#bendingCond0').text('-'+sizeData.bendingAlwnceMinus + ' [' + sizeData.bendingCond + '] +' + sizeData.bendingAlwncePlus);
	            	}

	            	//console.log(stepData);

	            	$('#firstMetalDepthAlwnce1').text("");
	            	$('#firstPitchLeftAlwnce1').text("");
	            	$('#firstPpfDepthLeftAlwnce1').text("");
	            	$('#firstPpfDepthCenterAlwnce1').text("");
	            	$('#firstPpfDepthRightAlwnce1').text("");
	            	$('#firstFilmAlwnce1').text("");
	            	$('#firstWpLeftAlwnce1').text("");
	            	$('#firstWpCenterAlwnce1').text("");
	            	$('#firstWpRightAlwnce1').text("");
	            	$('#firstWpDeviationAlwnce1').text("");
	            	$('#firstX1X2Alwnce1').text("");
	            	$('#firstPpfWingLeftAlwnce1').text("");
	            	$('#firstPpfWingRightAlwnce1').text("");
	            	$('#firstMetalThicknessAlwnce1').text("");
	            	$('#firstThEdgeAlwnce1').text("");
	            	$('#firstThCenterAlwnce1').text("");
	            	$('#firstThEdgeRightAlwnce1').text("");
	            	$('#firstBurrAlwnce1').text("");
	            	$('#firstGapOfLayerAlwnce1').text("");
	            	$('#firstBendingAlwnce1').text("");

	            	$('#secondMetalDepthAlwnce2').text("");
	            	$('#secondPitchLeftAlwnce2').text("");
	            	$('#secondPpfDepthLeftAlwnce2').text("");
	            	$('#secondPpfDepthCenterAlwnce2').text("");
	            	$('#secondPpfDepthRightAlwnce2').text("");
	            	$('#secondFilmAlwnce2').text("");
	            	$('#secondWpLeftAlwnce2').text("");
	            	$('#secondWpCenterAlwnce2').text("");
	            	$('#secondWpRightAlwnce2').text("");
	            	$('#secondWpDeviationAlwnce2').text("");
	            	$('#secondX1X2Alwnce2').text("");
	            	$('#secondPpfWingLeftAlwnce2').text("");
	            	$('#secondPpfWingRightAlwnce2').text("");
	            	$('#secondMetalThicknessAlwnce2').text("");
	            	$('#secondThEdgeAlwnce2').text("");
	            	$('#secondThCenterAlwnce2').text("");
	            	$('#secondThEdgeRightAlwnce2').text("");
	            	$('#secondBurrAlwnce2').text("");
	            	$('#secondGapOfLayerAlwnce2').text("");
	            	$('#secondBendingAlwnce2').text("");

	            	$('#thirdMetalDepthAlwnce3').text("");
	            	$('#thirdPitchLeftAlwnce3').text("");
	            	$('#thirdPpfDepthLeftAlwnce3').text("");
	            	$('#thirdPpfDepthCenterAlwnce3').text("");
	            	$('#thirdPpfDepthRightAlwnce3').text("");
	            	$('#thirdFilmAlwnce3').text("");
	            	$('#thirdWpLeftAlwnce3').text("");
	            	$('#thirdWpCenterAlwnce3').text("");
	            	$('#thirdWpRightAlwnce3').text("");
	            	$('#thirdWpDeviationAlwnce3').text("");
	            	$('#thirdX1X2Alwnce3').text("");
	            	$('#thirdPpfWingLeftAlwnce3').text("");
	            	$('#thirdPpfWingRightAlwnce3').text("");
	            	$('#thirdMetalThicknessAlwnce3').text("");
	            	$('#thirdThEdgeAlwnce3').text("");
	            	$('#thirdThCenterAlwnce3').text("");
	            	$('#thirdThEdgeRightAlwnce3').text("");
	            	$('#thirdBurrAlwnce3').text("");
	            	$('#thirdGapOfLayerAlwnce3').text("");
	            	$('#thirdBendingAlwnce3').text("");

	          	
            		$.each(stepData, function(idx, item){
            			//if(item==null){
            			//	$('#firstWpLeftAlwnce').text("");
            			//	$('#firstWpRightAlwnce').text("");
        	 	        //	$('#firstPitchLeftAlwnce').text("");
        	 	        //	$('#firstPitchRightAlwnce').text("");
        	 	        //	$('#firstPpfWingLeftAlwnce').text("");
        	 	        //	$('#firstPpfWingRightAlwnce').text("");
        	 	        //	$('#firstPpfDepthLeftAlwnce').text("");
        	 	        //	$('#firstPpfDepthRightAlwnce').text("");
        	 	        //	$('#firstFilmAlwnce').text("");
        	 	        //	$('#firstMetalDepthAlwnce').text("");
        	 	        //	$('#firstMetalThicknessAlwnce').text("");
        	 	        //	$('#firstThCenterAlwnce').text("");
        	 	        //	$('#firstThEdgeAlwncePlus').text("");
        	 	        //	$('#firstBurrMetalAlwnce').text("");
        	 	        //	$('#firstBurrRcutAlwnce').text("");
        	 	        //	$('#firstBurrRedgeAlwnce').text("");
        	 	        //	
        	 	        //	$('#secondWpLeftAlwnce').text("");
         	 	        //	$('#secondWpRightAlwnce').text("");
         	 	        //	$('#secondPitchLeftAlwnce').text("");
         	 	        //	$('#secondPitchRightAlwnce').text("");
         	 	        //	$('#secondPpfWingLeftAlwnce').text("");
         	 	        //	$('#secondPpfWingRightAlwnce').text("");
         	 	        //	$('#secondPpfDepthLeftAlwnce').text("");
         	 	        //	$('#secondPpfDepthRightAlwnce').text("");
         	 	        //	$('#secondFilmAlwnce').text("");
         	 	        //	$('#secondMetalDepthAlwnce').text("");
         	 	        //	$('#secondMetalThicknessAlwnce').text("");
         	 	        //	$('#secondThCenterAlwnce').text("");
         	 	        //	$('#secondThEdgeAlwncePlus').text("");
         	 	        //	$('#secondBurrMetalAlwnce').text("");
         	 	        //	$('#secondBurrRcutAlwnce').text("");
        	 	        //	$('#secondBurrRedgeAlwnce').text("");
        	 	        //	
         	 	        //	$('#thirdWpLeftAlwnce').text("");
         	 	        //	$('#thirdWpRightAlwnce').text("");
         	 	        //	$('#thirdPitchLeftAlwnce').text("");
         	 	        //	$('#thirdPitchRightAlwnce').text("");
         	 	        //	$('#thirdPpfWingLeftAlwnce').text("");
         	 	        //	$('#thirdPpfWingRightAlwnce').text("");
         	 	        //	$('#thirdPpfDepthLeftAlwnce').text("");
         	 	        //	$('#thirdPpfDepthRightAlwnce').text("");
         	 	        //	$('#thirdFilmAlwnce').text("");
         	 	        //	$('#thirdMetalDepthAlwnce').text("");
         	 	        //	$('#thirdMetalThicknessAlwnce').text("");
         	 	        //	$('#thirdThCenterAlwnce').text("");
         	 	        //	$('#thirdThEdgeAlwncePlus').text("");
         	 	        //	$('#thirdBurrMetalAlwnce').text("");
         	 	        //	$('#thirdBurrRcutAlwnce').text("");
        	 	        //	$('#thirdBurrRedgeAlwnce').text("");
        	 	        //	
         	 	        //	$('#wpLeftCond').text("");
        	            //	$('#wpRightCond').text("");
        	            //	$('#pitchLeftCond').text("");
        	            //	$('#pitchRightCond').text("");
        	            //	$('#ppfWingLeftCond').text("");
        	            //	$('#ppfWingRightCond').text("");
        	            //	$('#ppfDepthLeftCond').text("");
        	            //	$('#ppfDepthRightCond').text("");
        	            //	$('#filmCond').text("");
        	            //	$('#metalDepthCond').text("");
        	            //	$('#metalThicknessCond').text("");
        	            //	$('#thCenterCond').text("");
        	            //	$('#thEdgeCond').text("");
        	            //	$('#burrCond').text("");  		        	
            			//}
            			//else{
		       				if(idx == 0){			          			
				 	        	//$('#firstWpLeftAlwnce1').text(item.wpLeftAlwnce);
				 	        	//$('#firstWpRightAlwnce1').text(item.wpRightAlwnce);
				 	        	//$('#firstPitchLeftAlwnce1').text(item.pitchLeftAlwnce);
				 	        	//$('#firstPitchRightAlwnce1').text(item.pitchRightAlwnce);
				 	        	//$('#firstPpfWingLeftAlwnce1').text(item.ppfWingLeftAlwnce);
				 	        	//$('#firstPpfWingRightAlwnce1').text(item.ppfWingRightAlwnce);
				 	        	//$('#firstPpfDepthLeftAlwnce1').text(item.ppfDepthLeftAlwnce);
				 	        	//$('#firstPpfDepthRightAlwnce1').text(item.ppfDepthRightAlwnce);
				 	        	//$('#firstFilmAlwnce1').text(item.filmAlwnce);
				 	        	//$('#firstMetalDepthAlwnce1').text(item.metalDepthAlwnce);
				 	        	//$('#firstMetalThicknessAlwnce1').text(item.metalThicknessAlwnce);
				 	        	//$('#firstThCenterAlwnce1').text(item.thCenterAlwnce);
				 	        	//$('#firstThEdgeAlwncePlus1').text(item.thEdgeAlwncePlus);
				 	        	//$('#firstInput1').text(item.thStepInput);
				 	        	//(item.thEdgeCnt == null) ? $('#firstThEdgeCnt1').text('0') : $('#firstThEdgeCnt1').text(item.thEdgeCnt);
				 	        	//if (item.thEdgeResult == '001') {
				 	        	//	$('#firstThEdgeResult1').text('합격');
					    		//	$("#firstThEdgeCnt1").attr("style", "");
					    		//	$("#firstThEdgeResult1").attr("style", "");
					 	        //} else if (item.thEdgeResult == '002') {
				 	        	//	$('#firstThEdgeResult1').text('불합격');
					    		//	$("#firstThEdgeCnt1").attr("style", "color: red;");
					    		//	$("#firstThEdgeResult1").attr("style", "color: red;");
						 	    //} else {
						 	    //	$('#firstThEdgeResult1').text('-');
					    		//	$("#firstThEdgeCnt1").attr("style", "");
					    		//	$("#firstThEdgeResult1").attr("style", "");
							 	//}
				 	        	//$('#firstBurrMetalAlwnce1').text(item.burrMetalAlwnce);
				 	        	//$('#firstBurrRcutAlwnce1').text(item.burrRcutAlwnce);
	        	 	        	//$('#firstBurrRedgeAlwnce1').text(item.burrRedgeAlwnce);

	        	 	        	
		       					$('#firstMetalDepthAlwnce1').text(item.metalDepthAlwnce);
		    	            	$('#firstPitchLeftAlwnce1').text(item.pitchLeftAlwnce);
		    	            	$('#firstPpfDepthLeftAlwnce1').text(item.ppfDepthLeftAlwnce);
		    	            	$('#firstPpfDepthCenterAlwnce1').text(item.ppfDepthCenterAlwnce);
		    	            	$('#firstPpfDepthRightAlwnce1').text(item.ppfDepthRightAlwnce);
		    	            	$('#firstFilmAlwnce1').text(item.filmAlwnce);
		    	            	$('#firstWpLeftAlwnce1').text(item.wpLeftAlwnce);
		    	            	$('#firstWpCenterAlwnce1').text(item.wpCenterAlwnce);
		    	            	$('#firstWpRightAlwnce1').text(item.wpRightAlwnce);
		    	            	$('#firstWpDeviationAlwnce1').text(item.wpDeviationAlwnce);
		    	            	$('#firstX1X2Alwnce1').text(item.x1X2Alwnce);
		    	            	$('#firstPpfWingLeftAlwnce1').text(item.ppfWingLeftAlwnce);
		    	            	$('#firstPpfWingRightAlwnce1').text(item.ppfWingRightAlwnce);
		    	            	$('#firstMetalThicknessAlwnce1').text(item.metalThicknessAlwnce);
		    	            	$('#firstThEdgeAlwnce1').text(item.thEdgeAlwncePlus);
		    	            	$('#firstThCenterAlwnce1').text(item.thCenterAlwnce);
		    	            	$('#firstThEdgeRightAlwnce1').text(item.thEdgeRightAlwnce);
		    	            	$('#firstBurrAlwnce1').text(item.burrMetalAlwnce);
		    	            	$('#firstGapOfLayerAlwnce1').text(item.gapOfLayer);
		    	            	$('#firstBendingAlwnce1').text(item.bendingAlwnce);


	        	 	        	
			          		} else if(idx == 1){
			          			//$('#secondWpLeftAlwnce2').text(item.wpLeftAlwnce);
			 	 	        	//$('#secondWpRightAlwnce2').text(item.wpRightAlwnce);
			 	 	        	//$('#secondPitchLeftAlwnce2').text(item.pitchLeftAlwnce);
			 	 	        	//$('#secondPitchRightAlwnce2').text(item.pitchRightAlwnce);
			 	 	        	//$('#secondPpfWingLeftAlwnce2').text(item.ppfWingLeftAlwnce);
			 	 	        	//$('#secondPpfWingRightAlwnce2').text(item.ppfWingRightAlwnce);
			 	 	        	//$('#secondPpfDepthLeftAlwnce2').text(item.ppfDepthLeftAlwnce);
			 	 	        	//$('#secondPpfDepthRightAlwnce2').text(item.ppfDepthRightAlwnce);
			 	 	        	//$('#secondFilmAlwnce2').text(item.filmAlwnce);
			 	 	        	//$('#secondMetalDepthAlwnce2').text(item.metalDepthAlwnce);
			 	 	        	//$('#secondMetalThicknessAlwnce2').text(item.metalThicknessAlwnce);
			 	 	        	//$('#secondThCenterAlwnce2').text(item.thCenterAlwnce);
			 	 	        	//$('#secondThEdgeAlwncePlus2').text(item.thEdgeAlwncePlus);
			 	 	        	//$('#secondInput2').text(item.thStepInput);
				 	        	//(item.thEdgeCnt == null) ? $('#secondThEdgeCnt2').text('0') : $('#secondThEdgeCnt2').text(item.thEdgeCnt);
				 	        	//if (item.thEdgeResult == '001') {
				 	        	//	$('#secondThEdgeResult2').text('합격');
					    		//	$("#secondThEdgeCnt2").attr("style", "");
					    		//	$("#secondThEdgeResult2").attr("style", "");
					 	        //} else if (item.thEdgeResult == '002') {
				 	        	//	$('#secondThEdgeResult2').text('불합격');
					    		//	$("#secondThEdgeCnt2").attr("style", "color: red;");
					    		//	$("#secondThEdgeResult2").attr("style", "color: red;");
						 	    //} else {
						 	    //	$('#secondThEdgeResult2').text('-');
					    		//	$("#secondThEdgeCnt2").attr("style", "");
					    		//	$("#secondThEdgeResult2").attr("style", "");
							 	//}
			 	 	        	//$('#secondBurrMetalAlwnce2').text(item.burrMetalAlwnce);
			 	 	        	//$('#secondBurrRcutAlwnce2').text(item.burrRcutAlwnce);
	        	 	        	//$('#secondBurrRedgeAlwnce2').text(item.burrRedgeAlwnce);

			          			$('#secondMetalDepthAlwnce2').text(item.metalDepthAlwnce);
		    	            	$('#secondPitchLeftAlwnce2').text(item.pitchLeftAlwnce);
		    	            	$('#secondPpfDepthLeftAlwnce2').text(item.ppfDepthLeftAlwnce);
		    	            	$('#secondPpfDepthCenterAlwnce2').text(item.ppfDepthCenterAlwnce);
		    	            	$('#secondPpfDepthRightAlwnce2').text(item.ppfDepthRightAlwnce);
		    	            	$('#secondFilmAlwnce2').text(item.filmAlwnce);
		    	            	$('#secondWpLeftAlwnce2').text(item.wpLeftAlwnce);
		    	            	$('#secondWpCenterAlwnce2').text(item.wpCenterAlwnce);
		    	            	$('#secondWpRightAlwnce2').text(item.wpRightAlwnce);
		    	            	$('#secondWpDeviationAlwnce2').text(item.wpDeviationAlwnce);
		    	            	$('#secondX1X2Alwnce2').text(item.x1X2Alwnce);
		    	            	$('#secondPpfWingLeftAlwnce2').text(item.ppfWingLeftAlwnce);
		    	            	$('#secondPpfWingRightAlwnce2').text(item.ppfWingRightAlwnce);
		    	            	$('#secondMetalThicknessAlwnce2').text(item.metalThicknessAlwnce);
		    	            	$('#secondThEdgeAlwnce2').text(item.thEdgeAlwncePlus);
		    	            	$('#secondThCenterAlwnce2').text(item.thCenterAlwnce);
		    	            	$('#secondThEdgeRightAlwnce2').text(item.thEdgeRightAlwnce);
		    	            	$('#secondBurrAlwnce2').text(item.burrMetalAlwnce);
		    	            	$('#secondGapOfLayerAlwnce2').text(item.gapOfLayer);
		    	            	$('#secondBendingAlwnce2').text(item.bendingAlwnce);
		    	            	
			          		} else if(idx == 2){
			          			//$('#thirdWpLeftAlwnce3').text(item.wpLeftAlwnce);
			 	 	        	//$('#thirdWpRightAlwnce3').text(item.wpRightAlwnce);
			 	 	        	//$('#thirdPitchLeftAlwnce3').text(item.pitchLeftAlwnce);
			 	 	        	//$('#thirdPitchRightAlwnce3').text(item.pitchRightAlwnce);
			 	 	        	//$('#thirdPpfWingLeftAlwnce3').text(item.ppfWingLeftAlwnce);
			 	 	        	//$('#thirdPpfWingRightAlwnce3').text(item.ppfWingRightAlwnce);
			 	 	        	//$('#thirdPpfDepthLeftAlwnce3').text(item.ppfDepthLeftAlwnce);
			 	 	        	//$('#thirdPpfDepthRightAlwnce3').text(item.ppfDepthRightAlwnce);
			 	 	        	//$('#thirdFilmAlwnce3').text(item.filmAlwnce);
			 	 	        	//$('#thirdMetalDepthAlwnce3').text(item.metalDepthAlwnce);
			 	 	        	//$('#thirdMetalThicknessAlwnce3').text(item.metalThicknessAlwnce);
			 	 	        	//$('#thirdThCenterAlwnce3').text(item.thCenterAlwnce);
			 	 	        	//$('#thirdThEdgeAlwncePlus3').text(item.thEdgeAlwncePlus);
			 	 	        	//$('#thirdInput3').text(item.thStepInput);
				 	        	//(item.thEdgeCnt == null) ? $('#thirdThEdgeCnt3').text('0') : $('#thirdThEdgeCnt3').text(item.thEdgeCnt);
				 	        	//if (item.thEdgeResult == '001') {
				 	        	//	$('#thirdThEdgeResult3').text('합격');
					    		//	$("#thirdThEdgeCnt3").attr("style", "");
					    		//	$("#thirdThEdgeResult3").attr("style", "");
					 	        //} else if (item.thEdgeResult == '002') {
				 	        	//	$('#thirdThEdgeResult3').text('불합격');
					    		//	$("#thirdThEdgeCnt3").attr("style", "color: red;");
					    		//	$("#thirdThEdgeResult3").attr("style", "color: red;");
						 	    //} else {
						 	    //	$('#thirdThEdgeResult3').text('-');
					    		//	$("#thirdThEdgeCnt3").attr("style", "");
					    		//	$("#thirdThEdgeResult3").attr("style", "");
							 	//}
			 	 	        	//$('#thirdBurrMetalAlwnce3').text(item.burrMetalAlwnce);
			 	 	        	//$('#thirdBurrRcutAlwnce3').text(item.burrRcutAlwnce);
	        	 	        	//$('#thirdBurrRedgeAlwnce3').text(item.burrRedgeAlwnce);

			          			$('#thirdMetalDepthAlwnce3').text(item.metalDepthAlwnce);
		    	            	$('#thirdPitchLeftAlwnce3').text(item.pitchLeftAlwnce);
		    	            	$('#thirdPpfDepthLeftAlwnce3').text(item.ppfDepthLeftAlwnce);
		    	            	$('#thirdPpfDepthCenterAlwnce3').text(item.ppfDepthCenterAlwnce);
		    	            	$('#thirdPpfDepthRightAlwnce3').text(item.ppfDepthRightAlwnce);
		    	            	$('#thirdFilmAlwnce3').text(item.filmAlwnce);
		    	            	$('#thirdWpLeftAlwnce3').text(item.wpLeftAlwnce);
		    	            	$('#thirdWpCenterAlwnce3').text(item.wpCenterAlwnce);
		    	            	$('#thirdWpRightAlwnce3').text(item.wpRightAlwnce);
		    	            	$('#thirdWpDeviationAlwnce3').text(item.wpDeviationAlwnce);
		    	            	$('#thirdX1X2Alwnce3').text(item.x1X2Alwnce);
		    	            	$('#thirdPpfWingLeftAlwnce3').text(item.ppfWingLeftAlwnce);
		    	            	$('#thirdPpfWingRightAlwnce3').text(item.ppfWingRightAlwnce);
		    	            	$('#thirdMetalThicknessAlwnce3').text(item.metalThicknessAlwnce);
		    	            	$('#thirdThEdgeAlwnce3').text(item.thEdgeAlwncePlus);
		    	            	$('#thirdThCenterAlwnce3').text(item.thCenterAlwnce);
		    	            	$('#thirdThEdgeRightAlwnce3').text(item.thEdgeRightAlwnce);
		    	            	$('#thirdBurrAlwnce3').text(item.burrMetalAlwnce);
		    	            	$('#thirdGapOfLayerAlwnce3').text(item.gapOfLayer);
		    	            	$('#thirdBendingAlwnce3').text(item.bendingAlwnce);
			          		}
            			//}
           		 	}); 		

            		calc('firstMetalDepthAlwnce1' ,sizeData.metalDepthCond ,sizeData.metalDepthAlwnceMinus ,sizeData.metalDepthAlwncePlus);
            		calc('firstPitchLeftAlwnce1' ,sizeData.pitchLeftCond ,sizeData.pitchLeftAlwnceMinus ,sizeData.pitchLeftAlwncePlus);
            		calc('firstPpfDepthLeftAlwnce1' ,sizeData.ppfDepthLeftCond ,sizeData.ppfDepthLeftAlwnceMinus ,sizeData.ppfDepthLeftAlwncePlus);
            		calc('firstPpfDepthCenterAlwnce1' ,sizeData.ppfDepthCenterCond ,sizeData.ppfDepthCenterAlwnceMinus ,sizeData.ppfDepthCenterAlwncePlus);
            		calc('firstPpfDepthRightAlwnce1' ,sizeData.ppfDepthRightCond ,sizeData.ppfDepthRightAlwnceMinus ,sizeData.ppfDepthRightAlwncePlus);
            		calc('firstFilmAlwnce1' ,sizeData.filmCond ,sizeData.filmAlwnceMinus ,sizeData.filmAlwncePlus);
            		calc('firstWpLeftAlwnce1' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
            		calc('firstWpCenterAlwnce1' ,sizeData.wpCenterCond ,sizeData.wpCenterAlwnceMinus ,sizeData.wpCenterAlwncePlus);
            		calc('firstWpRightAlwnce1' ,sizeData.wpRightCond ,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
            		calc('firstWpDeviationAlwnce1' ,sizeData.wpDeviationCond ,sizeData.wpDeviationAlwnceMinus ,sizeData.wpDeviationAlwncePlus);
            		calc('firstX1X2Alwnce1' ,sizeData.x1X2Cond ,sizeData.x1X2AlwnceMinus ,sizeData.x1X2AlwncePlus);
            		calc('firstPpfWingLeftAlwnce1' ,sizeData.ppfWingLeftCond ,sizeData.ppfWingLeftAlwnceMinus ,sizeData.ppfWingLeftAlwncePlus);
            		calc('firstPpfWingRightAlwnce1' ,sizeData.ppfWingRightCond ,sizeData.ppfWingRightAlwnceMinus ,sizeData.ppfWingRightAlwncePlus);
            		calc('firstMetalThicknessAlwnce1' ,sizeData.metalThicknessCond ,sizeData.metalThicknessAlwnceMinus ,sizeData.metalThicknessAlwncePlus);
            		calc('firstThEdgeAlwnce1' ,sizeData.thEdgeCond ,sizeData.thEdgeAlwnceMinus ,sizeData.thEdgeAlwncePlus);
            		calc('firstThCenterAlwnce1' ,sizeData.thCenterCond ,sizeData.thCenterAlwnceMinus ,sizeData.thCenterAlwncePlus);
            		calc('firstThEdgeRightAlwnce1' ,sizeData.thEdgeRightCond ,sizeData.thEdgeRightAlwnceMinus ,sizeData.thEdgeRightAlwncePlus);
            		calc('firstBurrAlwnce1' ,sizeData.burrCond ,sizeData.burrAlwnceMinus ,sizeData.burrAlwncePlus);
            		calc('firstGapOfLayerAlwnce1' ,sizeData.gapOfLayerCond ,sizeData.gapOfLayerMinus ,sizeData.gapOfLayerPlus);
            		calc('firstBendingAlwnce1' ,sizeData.bendingCond ,sizeData.bendingAlwnceMinus ,sizeData.bendingAlwncePlus);

            		calc('secondMetalDepthAlwnce2' ,sizeData.metalDepthCond ,sizeData.metalDepthAlwnceMinus ,sizeData.metalDepthAlwncePlus);
            		calc('secondPitchLeftAlwnce2' ,sizeData.pitchLeftCond ,sizeData.pitchLeftAlwnceMinus ,sizeData.pitchLeftAlwncePlus);
            		calc('secondPpfDepthLeftAlwnce2' ,sizeData.ppfDepthLeftCond ,sizeData.ppfDepthLeftAlwnceMinus ,sizeData.ppfDepthLeftAlwncePlus);
            		calc('secondPpfDepthCenterAlwnce2' ,sizeData.ppfDepthCenterCond ,sizeData.ppfDepthCenterAlwnceMinus ,sizeData.ppfDepthCenterAlwncePlus);
            		calc('secondPpfDepthRightAlwnce2' ,sizeData.ppfDepthRightCond ,sizeData.ppfDepthRightAlwnceMinus ,sizeData.ppfDepthRightAlwncePlus);
            		calc('secondFilmAlwnce2' ,sizeData.filmCond ,sizeData.filmAlwnceMinus ,sizeData.filmAlwncePlus);
            		calc('secondWpLeftAlwnce2' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
            		calc('secondWpCenterAlwnce2' ,sizeData.wpCenterCond ,sizeData.wpCenterAlwnceMinus ,sizeData.wpCenterAlwncePlus);
            		calc('secondWpRightAlwnce2' ,sizeData.wpRightCond ,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
            		calc('secondWpDeviationAlwnce2' ,sizeData.wpDeviationCond ,sizeData.wpDeviationAlwnceMinus ,sizeData.wpDeviationAlwncePlus);
            		calc('secondX1X2Alwnce2' ,sizeData.x1X2Cond ,sizeData.x1X2AlwnceMinus ,sizeData.x1X2AlwncePlus);
            		calc('secondPpfWingLeftAlwnce2' ,sizeData.ppfWingLeftCond ,sizeData.ppfWingLeftAlwnceMinus ,sizeData.ppfWingLeftAlwncePlus);
            		calc('secondPpfWingRightAlwnce2' ,sizeData.ppfWingRightCond ,sizeData.ppfWingRightAlwnceMinus ,sizeData.ppfWingRightAlwncePlus);
            		calc('secondMetalThicknessAlwnce2' ,sizeData.metalThicknessCond ,sizeData.metalThicknessAlwnceMinus ,sizeData.metalThicknessAlwncePlus);
            		calc('secondThEdgeAlwnce2' ,sizeData.thEdgeCond ,sizeData.thEdgeAlwnceMinus ,sizeData.thEdgeAlwncePlus);
            		calc('secondThCenterAlwnce2' ,sizeData.thCenterCond ,sizeData.thCenterAlwnceMinus ,sizeData.thCenterAlwncePlus);
            		calc('secondThEdgeRightAlwnce2' ,sizeData.thEdgeRightCond ,sizeData.thEdgeRightAlwnceMinus ,sizeData.thEdgeRightAlwncePlus);
            		calc('secondBurrAlwnce2' ,sizeData.burrCond ,sizeData.burrAlwnceMinus ,sizeData.burrAlwncePlus);
            		calc('secondGapOfLayerAlwnce2' ,sizeData.gapOfLayerCond ,sizeData.gapOfLayerMinus ,sizeData.gapOfLayerPlus);
            		calc('secondBendingAlwnce2' ,sizeData.bendingCond ,sizeData.bendingAlwnceMinus ,sizeData.bendingAlwncePlus);

            		calc('thirdMetalDepthAlwnce3' ,sizeData.metalDepthCond ,sizeData.metalDepthAlwnceMinus ,sizeData.metalDepthAlwncePlus);
            		calc('thirdPitchLeftAlwnce3' ,sizeData.pitchLeftCond ,sizeData.pitchLeftAlwnceMinus ,sizeData.pitchLeftAlwncePlus);
            		calc('thirdPpfDepthLeftAlwnce3' ,sizeData.ppfDepthLeftCond ,sizeData.ppfDepthLeftAlwnceMinus ,sizeData.ppfDepthLeftAlwncePlus);
            		calc('thirdPpfDepthCenterAlwnce3' ,sizeData.ppfDepthCenterCond ,sizeData.ppfDepthCenterAlwnceMinus ,sizeData.ppfDepthCenterAlwncePlus);
            		calc('thirdPpfDepthRightAlwnce3' ,sizeData.ppfDepthRightCond ,sizeData.ppfDepthRightAlwnceMinus ,sizeData.ppfDepthRightAlwncePlus);
            		calc('thirdFilmAlwnce3' ,sizeData.filmCond ,sizeData.filmAlwnceMinus ,sizeData.filmAlwncePlus);
            		calc('thirdWpLeftAlwnce3' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
            		calc('thirdWpCenterAlwnce3' ,sizeData.wpCenterCond ,sizeData.wpCenterAlwnceMinus ,sizeData.wpCenterAlwncePlus);
            		calc('thirdWpRightAlwnce3' ,sizeData.wpRightCond ,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
            		calc('thirdWpDeviationAlwnce3' ,sizeData.wpDeviationCond ,sizeData.wpDeviationAlwnceMinus ,sizeData.wpDeviationAlwncePlus);
            		calc('thirdX1X2Alwnce3' ,sizeData.x1X2Cond ,sizeData.x1X2AlwnceMinus ,sizeData.x1X2AlwncePlus);
            		calc('thirdPpfWingLeftAlwnce3' ,sizeData.ppfWingLeftCond ,sizeData.ppfWingLeftAlwnceMinus ,sizeData.ppfWingLeftAlwncePlus);
            		calc('thirdPpfWingRightAlwnce3' ,sizeData.ppfWingRightCond ,sizeData.ppfWingRightAlwnceMinus ,sizeData.ppfWingRightAlwncePlus);
            		calc('thirdMetalThicknessAlwnce3' ,sizeData.metalThicknessCond ,sizeData.metalThicknessAlwnceMinus ,sizeData.metalThicknessAlwncePlus);
            		calc('thirdThEdgeAlwnce3' ,sizeData.thEdgeCond ,sizeData.thEdgeAlwnceMinus ,sizeData.thEdgeAlwncePlus);
            		calc('thirdThCenterAlwnce3' ,sizeData.thCenterCond ,sizeData.thCenterAlwnceMinus ,sizeData.thCenterAlwncePlus);
            		calc('thirdThEdgeRightAlwnce3' ,sizeData.thEdgeRightCond ,sizeData.thEdgeRightAlwnceMinus ,sizeData.thEdgeRightAlwncePlus);
            		calc('thirdBurrAlwnce3' ,sizeData.burrCond ,sizeData.burrAlwnceMinus ,sizeData.burrAlwncePlus);
            		calc('thirdGapOfLayerAlwnce3' ,sizeData.gapOfLayerCond ,sizeData.gapOfLayerMinus ,sizeData.gapOfLayerPlus);
            		calc('thirdBendingAlwnce3' ,sizeData.bendingCond ,sizeData.bendingAlwnceMinus ,sizeData.bendingAlwncePlus);
            		



           		 	
            		//calc('firstWpLeftAlwnce1' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
	            	//calc('firstWpRightAlwnce1',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
	            	//calc('firstPitchLeftAlwnce1',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	//calc('firstPitchRightAlwnce1',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	//calc('firstPpfWingLeftAlwnce1',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);	            	
	            	//calc('firstPpfWingRightAlwnce1',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	//calc('firstPpfDepthLeftAlwnce1',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	//calc('firstPpfDepthRightAlwnce1',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	//calc('firstFilmAlwnce1',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	//calc('firstMetalDepthAlwnce1',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	//calc('firstMetalThicknessAlwnce1',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	//calc('firstThCenterAlwnce1',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	//calc('firstThEdgeAlwncePlus1',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	//calc('firstBurrMetalAlwnce1',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
	            	//
	            	//calc('secondWpLeftAlwnce2',sizeData.wpLeftCond,sizeData.wpLeftAlwnceMinus,sizeData.wpLeftAlwncePlus);
	            	//calc('secondWpRightAlwnce2',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus,sizeData.wpRightAlwncePlus);
	            	//calc('secondPitchLeftAlwnce2',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	//calc('secondPitchRightAlwnce2',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	//calc('secondPpfWingLeftAlwnce2',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);
	            	//calc('secondPpfWingRightAlwnce2',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	//calc('secondPpfDepthLeftAlwnce2',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	//calc('secondPpfDepthRightAlwnce2',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	//calc('secondFilmAlwnce2',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	//calc('secondMetalDepthAlwnce2',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	//calc('secondMetalThicknessAlwnce2',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	//calc('secondThCenterAlwnce2',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	//calc('secondThEdgeAlwncePlus2',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	//calc('secondBurrMetalAlwnce2',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
	            	//
	            	//calc('thirdWpLeftAlwnce3',sizeData.wpLeftCond,sizeData.wpLeftAlwnceMinus,sizeData.wpLeftAlwncePlus);
	            	//calc('thirdWpRightAlwnce3',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus,sizeData.wpRightAlwncePlus);
	            	//calc('thirdPitchLeftAlwnce3',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	//calc('thirdPitchRightAlwnce3',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	//calc('thirdPpfWingLeftAlwnce3',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);
	            	//calc('thirdPpfWingRightAlwnce3',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	//calc('thirdPpfDepthLeftAlwnce3',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	//calc('thirdPpfDepthRightAlwnce3',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	//calc('thirdFilmAlwnce3',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	//calc('thirdMetalDepthAlwnce3',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	//calc('thirdMetalThicknessAlwnce3',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	//calc('thirdThCenterAlwnce3',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	//calc('thirdThEdgeAlwncePlus3',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	//calc('thirdBurrMetalAlwnce3',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);    		
				}
				else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
	}
	function calc(id ,text ,minus ,plus){		
		if(parseFloat($('#' + id).text()) >= (parseFloat(text) - parseFloat(minus)) && parseFloat($('#' + id).text()) <= (parseFloat(text) + parseFloat(plus))){
			//console.log($('#' + id).text());
			$('#' + id).css("color","black");	
			
		} else{
			$('#' + id).css("color","red");			
		}
	}

	
	let saveCheck = 0;
	function calcSave(id ,text ,minus ,plus){		
		if(parseFloat($('#' + id).val()) >= (parseFloat(text) - parseFloat(minus)) && parseFloat($('#' + id).val()) <= (parseFloat(text) + parseFloat(plus))){
			console.log('맞음');
		} else{
			console.log('틀림');
			saveCheck = 1;				
			return false;
		}
	}

	//생산 전표번호당 종물입력btn
	$('#btnOrdLotNoThirdStepNew').on('click', function() {
		if (workOrdNo == null) {
			toastr.warning("말물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderTable").find(".selected").length != 1) {
			toastr.warning("말물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (lotNo == null || lotNo == '') {
			toastr.warning("말물을 입력할 주자재(MetalLot)를 선택해주세요!");
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
	  	  	  	toastr.warning("미발행 작업지시는 말물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 말물을 입력 할 수 없습니다!");
	  	  	  	return false;
	  	  	}

			ordLotNoStepCd = '003';

			$('#btnStepReload').removeClass('d-none');			//초,중,종물 재조회 버튼
			$('#btnFirstStepInsert').addClass('d-none');		//초물 등록 버튼
			$('#btnSecondStepInsert').addClass('d-none');	//중물 등록 버튼
			$('#btnThirdStepInsert').removeClass('d-none');	//중물 등록 버튼
			
			
			$('.firstStep').attr('disabled', true);
			$('.secondStep').attr('disabled', true);
			$('.thirdStep').attr('disabled', true);
			
			
			stepViewClear();
			btnThirdStep = true;
			agtTempDataRead(); // 에이젼트 온도 데이터 읽기
			agtTempCondRead(); // 에이전트 온도 조건 읽기
			agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
			agtSizeCondRead(); // 에이전트 치수 조건 읽기
			newStepData(); // LG, SK 구분
			$('#ordLotNoStepTitle').text(lotNo + ' / 말물');
			$('#ordLotNoStepModal').modal({backdrop: 'static'});
			$('#ordLotNoStepModal').modal('show');
		}
	});

	//에이전트 치수 데이터 조회
	function agtSizeDataRead() {
		$('#my-spinner').show();
		
		let url;
		
		if( lineGubun != null ) {
			url = '<c:url value="/po/agtSizeSixFloorList_F3"/>'
		} else {
			url = '<c:url value="/po/agtReadSize_F3"/>';
		}
		
   	    $.ajax({
   	    	url: url,
			type: 'POST',
			async: false,
			data: {
   	        	'menuAuth'	 	:	menuAuth,
	   	        'workOrdNo'		:	function() { return workOrdNo; },	   	     	
				'stepCd'		: 	function() { return '003'; },
	   	        'lotNo'			:	function() { return lotNo; },
   	        },
   	        success: function (res) {
   	        	var data = res.data;
				if(res.result == 'ok') {
					// 엣지샘플 - 합불판정 셀렉박스 초기화
					selectBoxAppend(resultCd, "firstThEdgeResult", "", "");
					selectBoxAppend(resultCd, "secondThEdgeResult", "", "");
					selectBoxAppend(resultCd, "thirdThEdgeResult", "", "");
					
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
					//console.log(data.length);
					//초,중물,종물 데이터가 없는 경우
					if(data == null || data.length == 0){
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
						} else if (ordLotNoStepCd == '003') {
							$('#btnThirdStepInsert').attr('disabled', true);
							$('#btnStepEdit').attr('disabled', true);
						}
						$('#btnStepEdit').attr('disabled', true);
						$('#btnStepDelete').attr('disabled', true);
    
					//초,중물,종물 데이터가 있는 경우
					} else {
						for(var i=0;i<data.length;i++) {
							if (data[i].stepCd == '001') {
								var stepNm = 'first';
								//if (sideView == 'firstStep') { // 초물보기 상태일 경우
								if (ordLotNoStepCd == '001') {
									$('#btnFirstStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
									$('#btnStepDelete').attr('disabled',false);
								}
								//초물만 있을경우 중물 등록버튼활성화, 초물을 등록하지 않으면 중물을 등록 할 수 없도록 중물등록 버튼 비활성화
								if ((data.length == 1 || data.length == 2) && data[i].stepCd == '001'){
									$('#btnSecondStepInsert').attr('disabled', false);
									//$('#btnStepEdit').attr('disabled', true);
								}
							} else if (data[i].stepCd == '002') {
								var stepNm = 'second';
								//if(sideView == 'secondStep') { // 중물보기 상태일 경우
								if (ordLotNoStepCd == '002') {
									$('#btnSecondStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
									$('#btnStepDelete').attr('disabled',false);
								}
								if (data.length == 2 && data[i].stepCd == '002'){
									$('#btnThirdStepInsert').attr('disabled', false);
									//$('#btnStepEdit').attr('disabled', true);
								}
							} else if(data[i].stepCd == '003') {
								var stepNm = 'third';
								if (ordLotNoStepCd == '003') {
									$('#btnThirdStepInsert').attr('disabled', true);
									$('#btnStepEdit').attr('disabled', false);
									$('#btnStepDelete').attr('disabled',false);
								}
							} else {
								if (ordLotNoStepCd == '001') {
									$('#btnFirstStepInsert').attr('disabled', false);
								} else if (ordLotNoStepCd == '002') {
									$('#btnSecondStepInsert').attr('disabled', false);
								} else if (ordLotNoStepCd == '003') {
									$('#btnThirdStepInsert').attr('disabled', false);
								}
								$('#btnStepDelete').attr('disabled', true);
							}
							
							//$('#'+stepNm+'WpLeftAlwnce').val(data[i].wpLeftAlwnce);
							//$('#'+stepNm+'WpRightAlwnce').val(data[i].wpRightAlwnce);
							//$('#'+stepNm+'PitchLeftAlwnce').val(data[i].pitchLeftAlwnce);
							//$('#'+stepNm+'PitchRightAlwnce').val(data[i].pitchRightAlwnce);
							//$('#'+stepNm+'PpfWingLeftAlwnce').val(data[i].ppfWingLeftAlwnce);
							//$('#'+stepNm+'PpfWingRightAlwnce').val(data[i].ppfWingRightAlwnce);
							//$('#'+stepNm+'PpfDepthLeftAlwnce').val(data[i].ppfDepthLeftAlwnce);
							//$('#'+stepNm+'PpfDepthRightAlwnce').val(data[i].ppfDepthRightAlwnce);
							//$('#'+stepNm+'FilmAlwnce').val(data[i].filmAlwnce);
							//$('#'+stepNm+'MetalDepthAlwnce').val(data[i].metalDepthAlwnce);
							//$('#'+stepNm+'MetalThicknessAlwnce').val(data[i].metalThicknessAlwnce);
							//$('#'+stepNm+'ThCenterAlwnce').val(data[i].thCenterAlwnce);
							//$('#'+stepNm+'ThEdgeAlwncePlus').val(data[i].thEdgeAlwncePlus);
							//$('#'+stepNm+'Input').val(data[i].thStepInput);
							//data[i].thEdgeCnt == null ? $('#'+stepNm+'ThEdgeCnt').val(0) : $('#'+stepNm+'ThEdgeCnt').val(data[i].thEdgeCnt);
							//$('#'+stepNm+'ThEdgeResult').val(data[i].thEdgeResult);
							//$('#'+stepNm+'BurrMetalAlwnce').val(data[i].burrMetalAlwnce);
							//$('#'+stepNm+'BurrRcutAlwnce').val(data[i].burrRcutAlwnce);
							//$('#'+stepNm+'BurrRedgeAlwnce').val(data[i].burrRedgeAlwnce);
							//$('#'+stepNm+'BulgeLeftupHeight').val(data[i].bulgeLeftupHeight);
							//$('#'+stepNm+'BulgeLeftdownHeight').val(data[i].bulgeLeftdownHeight);
							//$('#'+stepNm+'BulgeRightupHeight').val(data[i].bulgeRightupHeight);
							//$('#'+stepNm+'BulgeRightdownHeight').val(data[i].bulgeRightdownHeight);
							//$('#'+stepNm+'BulgeLeftupWidth').val(data[i].bulgeLeftupWidth);
							//$('#'+stepNm+'BulgeLeftdownWidth').val(data[i].bulgeLeftdownWidth);
							//$('#'+stepNm+'BulgeRightupWidth').val(data[i].bulgeRightupWidth);
							//$('#'+stepNm+'BulgeRightdownWidth').val(data[i].bulgeRightdownWidth);
							$('#'+stepNm+'PitchRightAlwnce').val(data[i].pitchRightAlwnce);
							$('#'+stepNm+'MetalDepthAlwnce').val(data[i].metalDepthAlwnce);
							$('#'+stepNm+'PitchLeftAlwnce').val(data[i].pitchLeftAlwnce);
							$('#'+stepNm+'PpfDepthLeftAlwnce').val(data[i].ppfDepthLeftAlwnce);
							$('#'+stepNm+'PpfDepthCenterAlwnce').val(data[i].ppfDepthCenterAlwnce);
							$('#'+stepNm+'PpfDepthRightAlwnce').val(data[i].ppfDepthRightAlwnce);
							$('#'+stepNm+'FilmAlwnce').val(data[i].filmAlwnce);
							$('#'+stepNm+'WpLeftAlwnce').val(data[i].wpLeftAlwnce);
							$('#'+stepNm+'WpCenterAlwnce').val(data[i].wpCenterAlwnce);
							$('#'+stepNm+'WpRightAlwnce').val(data[i].wpRightAlwnce);
							$('#'+stepNm+'WpDeviationAlwnce').val(data[i].wpDeviationAlwnce);
							$('#'+stepNm+'X1X2Alwnce').val(data[i].x1X2Alwnce);
							$('#'+stepNm+'PpfWingLeftAlwnce').val(data[i].ppfWingLeftAlwnce);
							$('#'+stepNm+'PpfWingRightAlwnce').val(data[i].ppfWingRightAlwnce);
							
							$('#'+stepNm+'MetalThicknessAlwnce').val(data[i].metalThicknessAlwnce);
							$('#'+stepNm+'ThEdgeAlwnce').val(data[i].thEdgeAlwncePlus);
							$('#'+stepNm+'ThCenterAlwnce').val(data[i].thCenterAlwnce);
							$('#'+stepNm+'ThEdgeRightAlwnce').val(data[i].thEdgeRightAlwnce);
							$('#'+stepNm+'BurrAlwnce').val(data[i].burrMetalAlwnce);
							$('#'+stepNm+'GapOfLayerAlwnce').val(data[i].gapOfLayer);
							$('#'+stepNm+'BendingAlwnce').val(data[i].bendingAlwnce);

							$('#'+stepNm+'BulgeLeftupHeight').val(data[i].bulgeLeftupHeight);
							$('#'+stepNm+'BulgeLeftdownHeight').val(data[i].bulgeLeftdownHeight);
							$('#'+stepNm+'BulgeRightupHeight').val(data[i].bulgeRightupHeight);
							$('#'+stepNm+'BulgeRightdownHeight').val(data[i].bulgeRightdownHeight);
							$('#'+stepNm+'BulgeLeftupWidth').val(data[i].bulgeLeftupWidth);
							$('#'+stepNm+'BulgeLeftdownWidth').val(data[i].bulgeLeftdownWidth);
							$('#'+stepNm+'BulgeRightupWidth').val(data[i].bulgeRightupWidth); 
							$('#'+stepNm+'BulgeRightdownWidth').val(data[i].bulgeRightdownWidth);
							console.log(data[i]);
							
						}
					}
    
				} else {
					toastr.error(res.message, '(에이전트 치수 데이터 조회)', {timeOut: 5000});
				}
   	        },
			complete:function(){
				$('#my-spinner').hide();
 				
			}
		});
		
	} 

	//에이전트 치수 조건 조회
	function agtSizeCondRead() {
		$('#my-spinner').show();
		
		let url;
		
		if( lineGubun != null ) {
			url = '<c:url value="/po/sizeSixFloorRead"/>'
		} else {
			url = '<c:url value="/po/workOrderStepData"/>';
		}
		
   	    $.ajax({
			url: url,
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
   	            	//$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
   	            	//$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
   	            	//$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
   	            	//$('#pitchRightCond').text('-'+condStepData.pitchRightAlwnceMinus + ' [' + condStepData.pitchRightCond + '] +' + condStepData.pitchRightAlwncePlus);
   	            	//$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
   	            	//$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
   	            	//$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
   	            	//$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
   	            	//$('#filmCond').text('-'+condStepData.filmAlwnceMinus + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
   	            	//$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
   	            	//$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
   	            	//$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
   	            	//$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
   	            	//$('#burrCond').text('-'+condStepData.burrAlwnceMinus + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);
					
   	            		if(condStepData.metalDepthCond != null){
   		            	$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
   		            	}
   		            	if(condStepData.pitchLeftCond != null){
   		            	$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
   		            	}
   		            	if(condStepData.ppfDepthLeftCond != null){
   		            	$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
   		            	}
   						if(condStepData.ppfDepthCenterCond != null){
   						$('#ppfDepthCenterCond').text('-'+condStepData.ppfDepthCenterAlwnceMinus + ' [' + condStepData.ppfDepthCenterCond + '] +' + condStepData.ppfDepthCenterAlwncePlus);
   			            }			            
   						if(condStepData.ppfDepthRightCond != null){
   		            	$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
   						}
   		            	if(condStepData.filmCond != null){
   		            	$('#filmCond').text('-'+condStepData.filmAlwnceMinus + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
   		            	}
   		            	if(condStepData.wpLeftCond != null){
   		            	$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
   		            	}
   		            	if(condStepData.wpCenterCond != null){
   		            	$('#wpCenterCond').text('-'+condStepData.wpCenterAlwnceMinus + ' [' + condStepData.wpCenterCond + '] +' + condStepData.wpCenterAlwncePlus);
   		            	}
   		            	if(condStepData.wpRightCond != null){
   		            	$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
   		            	}
   		            	if(condStepData.wpDeviationCond != null){
   		            	$('#wpDeviationCond').text('-'+condStepData.wpDeviationAlwnceMinus + ' [' + condStepData.wpDeviationCond + '] +' + condStepData.wpDeviationAlwncePlus);
   		            	}
   		            	if(condStepData.x1X2Cond != null){
   		            	$('#x1X2Cond').text('-'+condStepData.x1X2AlwnceMinus + ' [' + condStepData.x1X2Cond + '] +' + condStepData.x1X2AlwncePlus);
   		            	}
   		            	if(condStepData.ppfWingLeftCond != null){
   		            	$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
   		            	}
   		            	if(condStepData.ppfWingRightCond != null){
   		            	$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
   		            	}
   		            	if(condStepData.metalThicknessCond != null){
   		            	$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
   		            	}
   		            	if(condStepData.thEdgeCond != null){
   		            	$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
   		            	}
   		            	if(condStepData.thCenterCond != null){
   		            	$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
   		            	}
   		            	if(condStepData.thEdgeRightCond != null){
   		            	$('#thEdgeRightCond').text('-'+condStepData.thEdgeRightAlwnceMinus + ' [' + condStepData.thEdgeRightCond + '] +' + condStepData.thEdgeRightAlwncePlus);
   		            	}
   		            	if(condStepData.burrCond != null){
   		            	$('#burrCond').text('-'+condStepData.burrAlwnceMinus + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);
   		            	}
   		            	if(condStepData.gapOfLayerCond != null){
   		            	$('#gapOfLayerCond').text('-'+condStepData.gapOfLayerMinus + ' [' + condStepData.gapOfLayerCond + '] +' + condStepData.gapOfLayerPlus);
   		            	}
   		            	if(condStepData.bendingCond != null){
   		            	$('#bendingCond').text('-'+condStepData.bendingAlwnceMinus + ' [' + condStepData.bendingCond + '] +' + condStepData.bendingAlwncePlus);
   		            	}
   		            	
   	            	//$('#metalDepthCond').text('-'+condStepData.metalDepthAlwnceMinus  + ' [' + condStepData.metalDepthCond + '] +' + condStepData.metalDepthAlwncePlus);
   	            	//$('#pitchLeftCond').text('-'+condStepData.pitchLeftAlwnceMinus  + ' [' + condStepData.pitchLeftCond + '] +' + condStepData.pitchLeftAlwncePlus);
   	            	//$('#ppfDepthLeftCond').text('-'+condStepData.ppfDepthLeftAlwnceMinus  + ' [' + condStepData.ppfDepthLeftCond + '] +' + condStepData.ppfDepthLeftAlwncePlus);
   	            	//$('#ppfDepthCenterCond').text('-'+condStepData.ppfDepthCenterAlwnceMinus  + ' [' + condStepData.ppfDepthCenterCond + '] +' + condStepData.ppfDepthCenterAlwncePlus);
   	            	//$('#ppfDepthRightCond').text('-'+condStepData.ppfDepthRightAlwnceMinus  + ' [' + condStepData.ppfDepthRightCond + '] +' + condStepData.ppfDepthRightAlwncePlus);
   	            	//$('#filmCond').text('-'+condStepData.filmAlwnceMinus  + ' [' + condStepData.filmCond + '] +' + condStepData.filmAlwncePlus);
   	            	//$('#wpLeftCond').text('-'+condStepData.wpLeftAlwnceMinus  + ' [' + condStepData.wpLeftCond + '] +' + condStepData.wpLeftAlwncePlus);
   	            	//$('#wpCenterCond').text('-'+condStepData.wpCenterAlwnceMinus  + ' [' + condStepData.wpCenterCond + '] +' + condStepData.wpCenterAlwncePlus);
   	            	//$('#wpRightCond').text('-'+condStepData.wpRightAlwnceMinus  + ' [' + condStepData.wpRightCond + '] +' + condStepData.wpRightAlwncePlus);
   	            	//$('#wpDeviationCond').text('-'+condStepData.wpDeviationAlwnceMinus  + ' [' + condStepData.wpDeviationCond + '] +' + condStepData.wpDeviationAlwncePlus);
   	            	//$('#x1X2Cond').text('-'+condStepData.x1X2AlwnceMinus  + ' [' + condStepData.x1X2Cond + '] +' + condStepData.x1X2AlwncePlus);
   	            	//$('#ppfWingLeftCond').text('-'+condStepData.ppfWingLeftAlwnceMinus  + ' [' + condStepData.ppfWingLeftCond + '] +' + condStepData.ppfWingLeftAlwncePlus);
   	            	//$('#ppfWingRightCond').text('-'+condStepData.ppfWingRightAlwnceMinus  + ' [' + condStepData.ppfWingRightCond + '] +' + condStepData.ppfWingRightAlwncePlus);
   	            	//$('#metalThicknessCond').text('-'+condStepData.metalThicknessAlwnceMinus  + ' [' + condStepData.metalThicknessCond + '] +' + condStepData.metalThicknessAlwncePlus);
   	            	//$('#thEdgeCond').text('-'+condStepData.thEdgeAlwnceMinus  + ' [' + condStepData.thEdgeCond + '] +' + condStepData.thEdgeAlwncePlus);
   	            	//$('#thCenterCond').text('-'+condStepData.thCenterAlwnceMinus  + ' [' + condStepData.thCenterCond + '] +' + condStepData.thCenterAlwncePlus);
   	            	//$('#thEdgeRightCond').text('-'+condStepData.thEdgeRightAlwnceMinus  + ' [' + condStepData.thEdgeRightCond + '] +' + condStepData.thEdgeRightAlwncePlus);
   	            	//$('#burrCond').text('-'+condStepData.burrAlwnceMinus  + ' [' + condStepData.burrCond + '] +' + condStepData.burrAlwncePlus);
   	            	//$('#gapOfLayerCond').text('-'+condStepData.gapOfLayerMinus  + ' [' + condStepData.gapOfLayerCond + '] +' + condStepData.gapOfLayerPlus);
   	            	//$('#bendingCond').text('-'+condStepData.bendingAlwnceMinus  + ' [' + condStepData.bendingCond + '] +' + condStepData.bendingAlwncePlus);
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
		} else{
			sideView = 'thirdStep';
			
			$.ajax({
		        url: '<c:url value="/qm/sizeCheckDataListNew"/>',
		        type: 'GET',
		        data: {
		        	'menuAuth'	 	: 		menuAuth,
		        	'workOrdNo' 	:  workOrdNo,
		        	'equipCondSeq' : equipCondSeq
		        },
		        success: function(res){

		        	var sizeData = res.cond; 
		        	var stepData = res.step;
		  

					if(res.result == "ok") {
						calcSave('thirdWpLeftAlwnce',sizeData.wpLeftCond,sizeData.wpLeftAlwnceMinus,sizeData.wpLeftAlwncePlus);
		            	calcSave('thirdWpRightAlwnce',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus,sizeData.wpRightAlwncePlus);
		            	calcSave('thirdPitchLeftAlwnce',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
		            	calcSave('thirdPitchRightAlwnce',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
		            	calcSave('thirdPpfWingLeftAlwnce',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);
		            	calcSave('thirdPpfWingRightAlwnce',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
		            	calcSave('thirdPpfDepthLeftAlwnce',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
		            	calcSave('thirdPpfDepthRightAlwnce',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
		            	calcSave('thirdFilmAlwnce',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
		            	calcSave('thirdMetalDepthAlwnce',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
		            	calcSave('thirdMetalThicknessAlwnce',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
		            	calcSave('thirdThCenterAlwnce',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
		            	calcSave('thirdThEdgeAlwncePlus',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
		            	calcSave('thirdBurrMetalAlwnce',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
					}
					else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
		        }
			});				
		}
		setTimeout(() => {
			 
	
		//온도
		$.ajax({
			url: '<c:url value="/po/agtUpdateTemp"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				//'ordLotNo'				:	function() { return ordLotNo; },
				'stepCd'				:	function() { return ordLotNoStepCd; },//sideView == 'firstStep'?'001':'002',
				'lotNo'					:	function() { return lotNo; },
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

		for (var i = 1; i < 4; i++) {
			var stepArr = ['first', 'second', 'third'];
			// Edge2, 엣지샘플 값 저장
			$.ajax({
				url: '<c:url value="/po/agtUpdateSizeMore"/>',
				type: 'POST',
				async: false,
				data: {
					'menuAuth'				:	menuAuth,
					'workOrdNo'				:	function() { return workOrdNo; },
					'stepCd'				:	function() { return "00" + i; },//sideView == 'firstStep'?'001':'002',
					'lotNo'					:	function() { return lotNo; },
					'thStepInput'			:	$('#' + stepArr[i-1] + 'Input').val(),
					'thEdgeCnt'				:	$('#' + stepArr[i-1] + 'ThEdgeCnt').val(),
					'thEdgeResult'			:	$('#' + stepArr[i-1] + 'ThEdgeResult').val()
				},
				success: function (res) {
					let result = res.result;
					if (res.result == 'ok') {
						$('#' + stepArr[i-1] + 'Input').attr('disabled', true);
						$('#' + stepArr[i-1] + 'ThEdgeCnt').attr('disabled', true);
						$('#' + stepArr[i-1] + 'ThEdgeResult').attr('disabled', true);
					} else if (res.result == 'fail') {
					} else {
						toastr.error(res.message, '(에이전트 치수 수정)', {timeOut: 5000});
					}
				},
			});	
		}
		
		
		
		let url;
		
		if( lineGubun != null ) {
			url = '<c:url value="/po/agtSizeSixFloorUpdate_F3"/>'
		} else {
			url = '<c:url value="/po/agtUpdateSize"/>';
		}
		
		//치수
		$.ajax({
			url: url,
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				//'ordLotNo'				:	function() { return ordLotNo; },
				'stepCd'				:	function() { return ordLotNoStepCd; },//sideView == 'firstStep'?'001':'002',
				'lotNo'					:	function() { return lotNo; },
				//'wpLeftAlwnce'			:	$('#' + sideView.replace('Step', '') + 'WpLeftAlwnce').val(),
				//'wpRightAlwnce'			:	$('#' + sideView.replace('Step', '') + 'WpRightAlwnce').val(),
				//'pitchLeftAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PitchLeftAlwnce').val(),
				//'pitchRightAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PitchRightAlwnce').val(),
				//'ppfWingLeftAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PpfWingLeftAlwnce').val(),
				//'ppfWingRightAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfWingRightAlwnce').val(),
				//'ppfDepthLeftAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfDepthLeftAlwnce').val(),
				//'ppfDepthRightAlwnce'	:	$('#' + sideView.replace('Step', '') + 'PpfDepthRightAlwnce').val(),
				//'filmAlwnce'			:	$('#' + sideView.replace('Step', '') + 'FilmAlwnce').val(),
				//'metalDepthAlwnce'		:	$('#' + sideView.replace('Step', '') + 'MetalDepthAlwnce').val(),
				//'metalThicknessAlwnce'	:	$('#' + sideView.replace('Step', '') + 'MetalThicknessAlwnce').val(),
				//'thCenterAlwnce'		:	$('#' + sideView.replace('Step', '') + 'ThCenterAlwnce').val(),
				//'thEdgeAlwncePlus'		:	$('#' + sideView.replace('Step', '') + 'ThEdgeAlwncePlus').val(),
				//'thStepInput'	        :	$('#' + sideView.replace('Step', '') + 'Input').val(),
				//'bulgeLeftupHeight'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupHeight').val(),
				//'bulgeLeftdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownHeight').val(),
				//'bulgeRightupHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightupHeight').val(),
				//'bulgeRightdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownHeight').val(),
				//'bulgeLeftupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupWidth').val(),
				//'bulgeLeftdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownWidth').val(),
				//'bulgeRightupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeRightupWidth').val(),
				//'bulgeRightdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownWidth').val(),
				//'burrMetalAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrMetalAlwnce').val(),
				//'burrRcutAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRcutAlwnce').val(),
				//'burrRedgeAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRedgeAlwnce').val()

				'metalDepthAlwnce'      :   $('#' + sideView.replace('Step', '') + 'MetalDepthAlwnce').val(),
				'pitchLeftAlwnce'       :   $('#' + sideView.replace('Step', '') + 'PitchLeftAlwnce').val(),
				'ppfDepthLeftAlwnce'    :   $('#' + sideView.replace('Step', '') + 'PpfDepthLeftAlwnce').val(),
				'ppfDepthCenterAlwnce'  :   $('#' + sideView.replace('Step', '') + 'PpfDepthCenterAlwnce').val(),
				'ppfDepthRightAlwnce'   :   $('#' + sideView.replace('Step', '') + 'PpfDepthRightAlwnce').val(),
				'filmAlwnce'            :   $('#' + sideView.replace('Step', '') + 'FilmAlwnce').val(),
				'wpLeftAlwnce'          :   $('#' + sideView.replace('Step', '') + 'WpLeftAlwnce').val(),
				'wpCenterAlwnce'        :   $('#' + sideView.replace('Step', '') + 'WpCenterAlwnce').val(),
				'wpRightAlwnce'         :   $('#' + sideView.replace('Step', '') + 'WpRightAlwnce').val(),
				'wpDeviationAlwnce'     :   $('#' + sideView.replace('Step', '') + 'WpDeviationAlwnce').val(),
				'x1X2Alwnce'            :   $('#' + sideView.replace('Step', '') + 'X1X2Alwnce').val(),
				'ppfWingLeftAlwnce'     :   $('#' + sideView.replace('Step', '') + 'PpfWingLeftAlwnce').val(),
				'ppfWingRightAlwnce'    :   $('#' + sideView.replace('Step', '') + 'PpfWingRightAlwnce').val(),
				'pitchRightAlwnce'		:	$('#' + sideView.replace('Step', '') + 'PitchRightAlwnce').val(),
				
				'metalThicknessAlwnce'  :   $('#' + sideView.replace('Step', '') + 'MetalThicknessAlwnce').val(),
				'thEdgeAlwncePlus'      :   $('#' + sideView.replace('Step', '') + 'ThEdgeAlwnce').val(),
				'thCenterAlwnce'        :   $('#' + sideView.replace('Step', '') + 'ThCenterAlwnce').val(),
				'thEdgeRightAlwnce'     :   $('#' + sideView.replace('Step', '') + 'ThEdgeRightAlwnce').val(),
				'burrMetalAlwnce'       :   $('#' + sideView.replace('Step', '') + 'BurrAlwnce').val(),
				'gapOfLayer'      		:   $('#' + sideView.replace('Step', '') + 'GapOfLayerAlwnce').val(),
				'bendingAlwnce'         :   $('#' + sideView.replace('Step', '') + 'BendingAlwnce').val(),
				
				'bulgeLeftupHeight'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupHeight').val(),
				'bulgeLeftdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownHeight').val(),
				'bulgeRightupHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightupHeight').val(),
				'bulgeRightdownHeight'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownHeight').val(),
				'bulgeLeftupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeLeftupWidth').val(),
				'bulgeLeftdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeLeftdownWidth').val(),
				'bulgeRightupWidth'		:	$('#' + sideView.replace('Step', '') + 'BulgeRightupWidth').val(),
				'bulgeRightdownWidth'	:	$('#' + sideView.replace('Step', '') + 'BulgeRightdownWidth').val(),
				//'burrMetalAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrMetalAlwnce').val(),
				'burrRcutAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRcutAlwnce').val(),
				'burrRedgeAlwnce'		:	$('#' + sideView.replace('Step', '') + 'BurrRedgeAlwnce').val()
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

				if(saveCheck == 1){
					toastr.warning("조건범위를 벗어나는 항목이 있습니다.");		
					saveCheck = 0;
				} else{
					saveCheck = 0;
				}
				
				$('#btnStepSave').attr('disabled',true);					
				readFunc();
			}
		});				 
		
		}, "10");

	});
    
	//초,중물 입력 초기화
  	function stepViewClear()
	{
  		$(".cond, .firstStep, .secondStep, .thirdStep").val("");
  		//if (ordLotNoStepCd == '001') {
  			$(".firstStep").val("0");
  	  	//} else if (ordLotNoStepCd == '002') {
  	  		$(".secondStep").val("0");
  	  	//} else if (ordLotNoStepCd == '003') {
  	  		$(".thirdStep").val("0");
  	  	//}
		$("#firstRegTime, #secondRegTime, #thirdRegTime").val("");
	}

	//에이젼트 온도 데이터 읽기
	function agtTempDataRead() {
		$('#btnStepDelete').attr('disabled', true);
		$('#btnStepEdit').attr('disabled', true);
		$('#btnStepSave').attr('disabled', true);
		$.ajax({
			url: '<c:url value="po/agtReadTemp_F3"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'		:	menuAuth,
				'workOrdNo'		:	function() { return workOrdNo; },
				//'ordLotNo'		:	function() { return ordLotNo; },
				'stepCd'		: 	function() { return ordLotNoStepCd; },
				'lotNo'			:	function() { return lotNo; },
			},
			success: function (res) {
				var data = res.data;
				if(res.result == 'ok') {
					for(var i=0;i<data.length;i++) {
						if(data[i].stepCd == '001') {
							var stepNm = 'first';
							//if (sideView == 'firstStep') { // 초물보기 상태일 경우
							if (ordLotNoStepCd == '001') {
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
							//$('#btnStepEdit').attr('disabled',false);
							//$('#btnStepDelete').attr('disabled',false);
						} else if (data[i].stepCd == '002') {
							var stepNm = 'second';
							//if (sideView == 'secondStep') { // 중물보기 상태일 경우
							if (ordLotNoStepCd == '002') {
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
							//$('#btnStepEdit').attr('disabled',false);
							//$('#btnStepDelete').attr('disabled',false);
						} else if(data[i].stepCd == '003') {
							var stepNm = 'third';
							if (ordLotNoStepCd == '003') {
								$('#btnStepEdit').attr('disabled',false);
								$('#btnStepDelete').attr('disabled',false);
							}
							//$('#btnStepEdit').attr('disabled',false);
							//$('#btnStepDelete').attr('disabled',false);
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
				} else {
					toastr.error('(에이전트 온도 데이터 조회)' + res.message, '', {timeOut: 5000});
				}
			},
 			complete:function(res){
 			
 				
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
            	//$('#my-spinner').show();
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
				//$('#my-spinner').hide();
			}
		});

		return checkWorkOrdStatus;
	}

	//초중종물 수정 버튼 click
	$('#btnStepEdit').on('click',function() {
		//selectStepBtn(sideView);
		if (ordLotNoStepCd == '001') {
			$('.firstStep').attr('disabled',false);
			$('.secondStep').attr('disabled',true);
			$('.thirdStep').attr('disabled',true);
		} else if (ordLotNoStepCd == '002') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',false);
			$('.thirdStep').attr('disabled',true);
		} else if (ordLotNoStepCd == '003') {
			$('.firstStep').attr('disabled',true);
			$('.secondStep').attr('disabled',true);
			$('.thirdStep').attr('disabled',false);
			$("#firstInput").attr("disabled",false);		// 총두께 - Edge2 초물
			$("#secondInput").attr("disabled",false);		// 총두께 - Edge2 중물
			$("#firstThEdgeCnt").attr("disabled",false);	// 엣지샘플 - 검사수 초물
			$("#secondThEdgeCnt").attr("disabled",false);	// 엣지샘플 - 검사수 중물
			$("#firstThEdgeResult").attr("disabled",false);	// 엣지샘플 - 합불판정 초물
			$("#secondThEdgeResult").attr("disabled",false);// 엣지샘플 - 합불판정 중물
		} else {
			//console.log('??');
		}
		$('#btnStepSave').attr('disabled',false);
	});

	//초중종물 등록 버튼 click
	$('#btnThirdStepInsert').on('click',function() {
		
		var stepCd = '003'
		
		let url;
		
		if( lineGubun != null ) {
			url = '<c:url value="/po/workOrderStepInsertRedis_DB0_F3"/>'
		} else {
			url = '<c:url value="/po/workOrderStepInsertRedis_DB0_F2F3"/>';
		}
		
		$('#my-spinner').show();

		//DGS Redis사용
		$.ajax({
			url: url,
			type: 'POST',
			async: false,
			data: {
				'menuAuth'	 	:	menuAuth,
				'workOrdNo'		:	function() { return workOrdNo; },
				//'ordLotNo'		:	function() { return ordLotNo; },
				'equipCd'		:	function() { return equipCd; },
				'lotNo'			:	function() { return lotNo; },
				'stepCd'		:	function() { return stepCd; },//function() { return stepCd; },
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
				readFunc();
				$('#my-spinner').hide();
			}
		});
	});

	//초,중,종물 재조회
	$('#btnStepReload').on('click', function(){
		agtTempDataRead(); // 에이젼트 온도 데이터 읽기
		agtTempCondRead(); // 에이전트 온도 조건 읽기
		agtSizeDataRead(); // 에이젼트 치수 데이터 읽기
		agtSizeCondRead(); // 에이전트 치수 조건 읽기

		$('.thirdStep').attr('disabled',true); //입력창 비활성화
	});

	  //초물 삭제 버튼
    $('#btnStepDelete').on('click', function() {    	
    	var stepCd = '003';	
		$('#deleteStepPopupModal').modal({backdrop: 'static'});
    	$('#deleteStepPopupModal').modal('show');
    });

    //초물 삭제 확인
    $('#deleteStepCheck').on('click', function() {
    	var stepCd = '003';
    	
		let url;
		
		if( lineGubun != null ) {
			url = '<c:url value="/po/agtAllDelete_F3"/>'
		} else {
			url = '<c:url value="/po/agtFirstDelete"/>';
		}
	
		$.ajax({
			url: url,
			type: 'POST',
			async: false,
			data: {
   	        	'menuAuth'	 	:	menuAuth,
	   	        'workOrdNo'		:	function() { return workOrdNo; },
	   	     	//'ordLotNo'		:	function() { return ordLotNo; },
	   	     	'ifEquipCd'		:	function() { return equipNm; },
	   	     	'lotNo'			:	function() { return lotNo; },
	   	        'stepCd'		:	function() { return stepCd; },//function() { return stepCd; },
   	        },
			success: function (res) {
				let data = res.data;
				if (res.result == 'ok') {				
		   	 	
		   	 		$('#thirdWarmupCond').val("0");
   					$('#thirdFitup1UpCond').val("0");
   					$('#thirdFitup1DownCond').val("0");
   					$('#thirdFitup2UpleftCond').val("0");
   					$('#thirdFitup2DownleftCond').val("0");
   					$('#thirdFitup2UprightCond').val("0");
   					$('#thirdFitup2DownrightCond').val("0");
   					$('#thirdRollheatUpCond').val("0");
   					$('#thirdRollheatDownCond').val("0");
   					$('#thirdFirstUpleftCond').val("0");
   					$('#thirdFirstDownleftCond').val("0");
   					$('#thirdFirstUprightCond').val("0");
   					$('#thirdFirstDownrightCond').val("0");
   					$('#thirdPush1UpCond').val("0");
   					$('#thirdPush1DownCond').val("0");
   					$('#thirdFirstUpleftCond').val("0");
   					$('#thirdSecondUpleftCond').val("0");
   					$('#thirdSecondDownleftCond').val("0");
   					$('#thirdSecondUprightCond').val("0");
   					$('#thirdSecondDownrightCond').val("0");
   					$('#thirdThirdUpleftCond').val("0");
   					$('#thirdThirdDownleftCond').val("0");
   					$('#thirdThirdUprightCond').val("0");
   					$('#thirdThirdDownrightCond').val("0");
   					$('#thirdJinjeop1UpCond').val("0");
   					$('#thirdJinjeop1DownCond').val("0");
   					$('#thirdJinjeop2UpCond').val("0");
   					$('#thirdJinjeop2DownCond').val("0");

   					$('#thirdWpLeftAlwnce').val("0");
   					$('#thirdWpRightAlwnce').val("0");
   					$('#thirdPitchLeftAlwnce').val("0");
   					$('#thirdPitchRightAlwnce').val("0");
   					$('#thirdPpfWingLeftAlwnce').val("0");
   					$('#thirdPpfWingRightAlwnce').val("0");
   					$('#thirdPpfDepthLeftAlwnce').val("0");
   					$('#thirdPpfDepthRightAlwnce').val("0");
   					$('#thirdFilmAlwnce').val("0");
   					$('#thirdMetalDepthAlwnce').val("0");
   					$('#thirdMetalThicknessAlwnce').val("0");
   					$('#thirdThCenterAlwnce').val("0");
   					$('#thirdThEdgeAlwncePlus').val("0");

   					$('#thirdInput').val("0");
   					
   					$('#thirdBurrMetalAlwnce').val("0");
   					$('#thirdBurrRcutAlwnce').val("0");
   					$('#thirdBurrRedgeAlwnce').val("0");
   					$('#thirdBulgeLeftupHeight').val("0");
   					$('#thirdBulgeLeftdownHeight').val("0");
   					$('#thirdBulgeRightupHeight').val("0");
   					$('#thirdBulgeRightdownHeight').val("0");
   					$('#thirdBulgeLeftupWidth').val("0");
   					$('#thirdBulgeLeftdownWidth').val("0");
   					$('#thirdBulgeRightupWidth').val("0");
   					$('#thirdBulgeRightdownWidth').val("0");
   					
   					$('#btnThirdStepInsert').attr("disabled",false);

	   		   	 	
					toastr.success(res.message, '', {timeOut: 5000});
					$('#btnStepDelete').attr("disabled", true);
					$('#btnStepReload').trigger('click');
					$(".thirdStep").val("0");
				} else if (res.result == 'fail') {
					toastr.warning(res.message, '', {timeOut: 5000});
					$('#btnStepReload').trigger('click');
				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
   	        complete:function(){
   	        	readFunc();
   	        	$('#my-spinner').hide();
			}
		});
    });

    // 합불판정 SelectBox
    var resultCd = new Array(); // 사용여부
    resultCd.push({baseCd: '0', baseCdNm: '미선택'});
    resultCd.push({baseCd: '001', baseCdNm: '합격'});
    resultCd.push({baseCd: '002', baseCdNm: '불합격'});
	selectBoxAppend(resultCd, "firstThEdgeResult", "", "");
	selectBoxAppend(resultCd, "secondThEdgeResult", "", "");
	selectBoxAppend(resultCd, "thirdThEdgeResult", "", "");

	//치수 UI 데이터 변경
	function newStepData() {
		
		if(skLgGubun == '001'){
			$('span[name=skLgGubun]').text('Sk on');
			$('#metalDepthCondNm').text('Metal 폭');
			$('#pitchLeftCondNm').text('Metal 총길이');
			$('#ppfDepthLeftCondNm').text('Film 폭 (좌)');
			$('#ppfDepthCenterCondNm').text('Film 폭 (중)');
			$('#ppfDepthRightCondNm').text('Film 폭 (우)');
			$('#filmCondNm').text('Film 총길이');
			$('#wpLeftCondNm').text('Welding Part (좌)');
			$('#wpCenterCondNm').text('Welding Part (중)');
			$('#wpRightCondNm').text('Welding Part (우)');
			$('#wpDeviationCondNm').html('Welding Part  <br> 좌/우 편차');
			$('#x1X2CondNm').html('대각선 길이 편차 <br> (X1 – X2)');
			$('#ppfWingLeftCondNm').text('날개 Margin (좌)');
			$('#ppfWingRightCondNm').text('날개 Margin (우)');
			$('#metalThicknessCondNm').text('Metal 두께');
			$('#thEdgeCondNm').text('총 두께 (Edge 좌)');
			$('#thCenterCondNm').text('총 두께 (Center)');
			$('#thEdgeRightCondNm').text('총 두께 (Edge 우)');
			$('#burrCondNm').text('Metal Burr');
			$('#gapOfLayerCondNm').text('Layer');
			$('#bendingCondNm').text('Bending');
		} else{
			$('span[name=skLgGubun]').text('LGES');
			$('#metalDepthCondNm').text('d');
			$('#pitchLeftCondNm').text('L');
			$('#ppfDepthLeftCondNm').text('l1');
			$('#ppfDepthCenterCondNm').text('l2');
			$('#ppfDepthRightCondNm').text('l3');
			$('#filmCondNm').text('W');
			$('#wpLeftCondNm').text('S1');
			$('#wpCenterCondNm').text('S2');
			$('#wpRightCondNm').text('S3');
			$('#wpDeviationCondNm').text('S1 - S3');
			$('#x1X2CondNm').text('X1 - X2');
			$('#ppfWingLeftCondNm').text('M1');
			$('#ppfWingRightCondNm').text('M2');
			$('#metalThicknessCondNm').text('t');
			$('#thEdgeCondNm').text('T1');
			$('#thCenterCondNm').text('T2');
			$('#thEdgeRightCondNm').text('T3');
			$('#burrCondNm').text('Burr');
			$('#gapOfLayerCondNm').text('g');
			$('#bendingCondNm').text('b');
		}
		
		
				
	}
	
</script>
</body>
</html>
