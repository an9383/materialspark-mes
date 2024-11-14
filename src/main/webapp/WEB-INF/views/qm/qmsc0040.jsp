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
				<li class="breadcrumb-item active">초중종물관리</li>
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
								<th style="min-width: 50px">위치</th>
								<th colspan="2">Welding Part</th>
								<th colspan="2">Pitch</th>
								<th colspan="2">P.P Film 날개</th>
								<th colspan="2">P.P Film 폭</th>
								<th 		   >Film</th>
								<th colspan="2">METAL</th>
								<th colspan="3">총두께</th>
								<th colspan="2">엣지검사</th>
								<th colspan="3">Burr(MAX)</th>
							</tr>
							</thead>
							<tr>
								<th>시료</th>
								<th>(좌)</th>
								<th>(우)</th>
								<th>(좌)</th>
								<th>(우)</th>
								<th>(좌)</th>
								<th>(우)</th>
								<th>(좌)</th>
								<th>(우)</th>
								<th>총길이</th>
								<th>폭</th>
								<th>두께</th>
								<th>Center</th>
								<th id="gubunEdge">Edge</th>
								<th id="gubunEdge2">Edge2</th>
								<th>검사수</th>
								<th>합불판정</th>
								<th>Metal</th>
								<th>R-Cut</th>
								<th>R끝단</th>																
							</tr>
							<tr>
								<th>조건	</th>								
								<td><span id="wpLeftCond0"></span></td>
								<td><span id="wpRightCond0"></span></td>
								<td><span id="pitchLeftCond0"></span></td>
								<td><span id="pitchRightCond0"></span></td>
								<td><span id="ppfWingLeftCond0"></span></td>
								<td><span id="ppfWingRightCond0"></span></td>
								<td><span id="ppfDepthLeftCond0"></span></td>
								<td><span id="ppfDepthRightCond0"></span></td>
								<td><span id="filmCond0"></span></td>
								<td><span id="metalDepthCond0"></span></td>
								<td><span id="metalThicknessCond0"></span></td>
								<td><span id="thCenterCond0"></span></td>
								<td><span id="thEdgeCond0"></span></td>
								<td><span id="thStepInput0"></span></td>
								<td><span id="thEdgeCnt0"></span></td>
								<td><span id="thEdgeResult0"></span></td>
								<td colspan="3"><span id="burrCond0"></span></td>
							</tr>
							<tr>
								<th>초물</th>
								<td><span id="firstWpLeftAlwnce1"></span></td>
								<td><span id="firstWpRightAlwnce1"></span></td>
								<td><span id="firstPitchLeftAlwnce1"></span></td>
								<td><span id="firstPitchRightAlwnce1"></span></td>
								<td><span id="firstPpfWingLeftAlwnce1"></span></td>
								<td><span id="firstPpfWingRightAlwnce1"></span></td>
								<td><span id="firstPpfDepthLeftAlwnce1"></span></td>
								<td><span id="firstPpfDepthRightAlwnce1"></span></td>
								<td><span id="firstFilmAlwnce1"></span></td>
								<td><span id="firstMetalDepthAlwnce1"></span></td>
								<td><span id="firstMetalThicknessAlwnce1"></span></td>
								<td><span id="firstThCenterAlwnce1"></span></td>
								<td><span id="firstThEdgeAlwncePlus1"></span></td>
								<td><span id="firstInput1"></span></td>
								<td><span id="firstThEdgeCnt1"></span></td>
								<td><span id="firstThEdgeResult1"></span></td>
								<td><span id="firstBurrMetalAlwnce1"></span></td>
								<td><span id="firstBurrRcutAlwnce1"></span></td>
								<td><span id="firstBurrRedgeAlwnce1"></span></td>	
							</tr>     
							<tr>                                   
								<th>중물</th>
								<td><span id="secondWpLeftAlwnce2"></span></td>
								<td><span id="secondWpRightAlwnce2"></span></td>
								<td><span id="secondPitchLeftAlwnce2"></span></td>
								<td><span id="secondPitchRightAlwnce2"></span></td>
								<td><span id="secondPpfWingLeftAlwnce2"></span></td>
								<td><span id="secondPpfWingRightAlwnce2"></span></td>
								<td><span id="secondPpfDepthLeftAlwnce2"></span></td>
								<td><span id="secondPpfDepthRightAlwnce2"></span></td>
								<td><span id="secondFilmAlwnce2"></span></td>
								<td><span id="secondMetalDepthAlwnce2"></span></td>
								<td><span id="secondMetalThicknessAlwnce2"></span></td>
								<td><span id="secondThCenterAlwnce2"></span></td>
								<td><span id="secondThEdgeAlwncePlus2"></span></td>
								<td><span id="secondInput2"></span></td>
								<td><span id="secondThEdgeCnt2"></span></td>
								<td><span id="secondThEdgeResult2"></span></td>
								<td><span id="secondBurrMetalAlwnce2"></span></td>
								<td><span id="secondBurrRcutAlwnce2"></span></td>
								<td><span id="secondBurrRedgeAlwnce2"></span></td>
							</tr>            
							<tr>             
								<th>종물</th>
								<td><span id="thirdWpLeftAlwnce3"></span></td>
								<td><span id="thirdWpRightAlwnce3"></span></td>
								<td><span id="thirdPitchLeftAlwnce3"></span></td>
								<td><span id="thirdPitchRightAlwnce3"></span></td>
								<td><span id="thirdPpfWingLeftAlwnce3"></span></td>
								<td><span id="thirdPpfWingRightAlwnce3"></span></td>
								<td><span id="thirdPpfDepthLeftAlwnce3"></span></td>
								<td><span id="thirdPpfDepthRightAlwnce3"></span></td>
								<td><span id="thirdFilmAlwnce3"></span></td>
								<td><span id="thirdMetalDepthAlwnce3"></span></td>
								<td><span id="thirdMetalThicknessAlwnce3"></span></td>
								<td><span id="thirdThCenterAlwnce3"></span></td>
								<td><span id="thirdThEdgeAlwncePlus3"></span></td>
								<td><span id="thirdInput3"></span></td>
								<td><span id="thirdThEdgeCnt3"></span></td>
								<td><span id="thirdThEdgeResult3"></span></td>
								<td><span id="thirdBurrMetalAlwnce3"></span></td>
								<td><span id="thirdBurrRcutAlwnce3"></span></td>
								<td><span id="thirdBurrRedgeAlwnce3"></span></td>
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
								<li class="nav-item"><a class="nav-link active show" id="tab1Nav" data-toggle="tab" href="#tab1">온도</a></li>
								<li class="nav-item"><a class="nav-link" id="tab2Nav" data-toggle="tab" href="#tab2">치수</a></li>
								<li class="nav-item ml-auto">
									<button type="button" class="btn btn-danger float-left mr-2 touch5" id="btnStepDelete">삭제</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepSave">저장</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5" id="btnStepEdit">수정</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnFirstStepInsert" disabled>초물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnSecondStepInsert" disabled>중물 등록</button>
									<button type="button" class="btn btn-primary float-right mr-2 touch5 d-none" id="btnThirdStepInsert" disabled>종물 등록</button>
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
	
	let menuAuth = 'qmsc0040';
	let currentHref = 'qmsc0040';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","초중종물관리");

	var serverDateFrom = "${serverDateFrom}";

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
	        	'menuAuth'	 	: 		menuAuth,
	        	'ordDate' : function() { return moment(serverDateFrom).format('YYYYMMDD'); },
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
	
	var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">일자</label><div class="form-group input-sub m-0 row"><input class="form-control" type="text" style="width:97px;" id="date" name="date" /><button onclick="fnPopUpCalendar(date,date,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="buyDateCalendar" type="button"><span class="oi oi-calendar"></span></button></div>&nbsp;<button type="button"  class="btn btn-primary" id="btnView">조회</button>';
	html1 += '<button type="button" class="btn btn-primary ml-2" id="btnOrdLotNoThirdStepNew">종물</button></div>';				
	$('#workOrderTable_length').html(html1);
	$('#date').val(serverDateFrom);

	$('#btnView').on('click', function() {
		serverDateFrom = $('#date').val();	
		$('#workOrderTable').DataTable().ajax.reload();		  
	});
	
	var workOrdNo=null;
	var equipCondSeq=null;
	var lotNo = null;
	var ordLotNoStepCd ='003';
	var workStatusCd = null;
	var equipNm = null;
	var equipCd = null;
	let factoryCode 	= "<%=factoryCode%>";
	
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
			workOrdNo = workOrderTable.row(this).data().workOrdNo;
			equipCondSeq = workOrderTable.row(this).data().equipCondSeq;
			lotNo = workOrderTable.row(this).data().lotNo;
			workStatusCd =  workOrderTable.row(this).data().workStatusCd;
			equipNm = workOrderTable.row(this).data().equipNm;
			equipCd = workOrderTable.row(this).data().equipCd;
			readFunc();
		}	
	});

	function readFunc(){
		$.ajax({
	        url: '<c:url value="/qm/sizeCheckDataListNew"/>',
	        type: 'GET',
	        data: {
	        	'menuAuth'	 	: 		menuAuth,
	        	'workOrdNo' :  workOrdNo,
	        	'equipCondSeq' : equipCondSeq
	        },
	        success: function(res){
	        	
	        	var sizeData = res.cond; 
	        	var stepData = res.step;
	        	//console.log(stepData);
	        	//console.log(sizeData);

				if(res.result == "ok") {
		          	$('#wpLeftCond0').text("");
	            	$('#wpRightCond0').text("");
	            	$('#pitchLeftCond0').text("");
	            	$('#pitchRightCond0').text("");
	            	$('#ppfWingLeftCond0').text("");
	            	$('#ppfWingRightCond0').text("");
	            	$('#ppfDepthLeftCond0').text("");
	            	$('#ppfDepthRightCond0').text("");
	            	$('#filmCond0').text("");
	            	$('#metalDepthCond0').text("");
	            	$('#metalThicknessCond0').text("");
	            	$('#thCenterCond0').text("");
	            	$('#thEdgeCond0').text("");
	            	$('#thStepInput0').text("");
	            	$('#burrCond0').text("");  		
	            	
		        	$('#wpLeftCond0').text('-'+sizeData.wpLeftAlwnceMinus + ' [' + sizeData.wpLeftCond + '] +' + sizeData.wpLeftAlwncePlus);
	            	$('#wpRightCond0').text('-'+sizeData.wpRightAlwnceMinus + ' [' + sizeData.wpRightCond + '] +' + sizeData.wpRightAlwncePlus);
	            	$('#pitchLeftCond0').text('-'+sizeData.pitchLeftAlwnceMinus + ' [' + sizeData.pitchLeftCond + '] +' + sizeData.pitchLeftAlwncePlus);
	            	$('#pitchRightCond0').text('-'+sizeData.pitchRightAlwnceMinus + ' [' + sizeData.pitchRightCond + '] +' + sizeData.pitchRightAlwncePlus);
	            	$('#ppfWingLeftCond0').text('-'+sizeData.ppfWingLeftAlwnceMinus + ' [' + sizeData.ppfWingLeftCond + '] +' + sizeData.ppfWingLeftAlwncePlus);
	            	$('#ppfWingRightCond0').text('-'+sizeData.ppfWingRightAlwnceMinus + ' [' + sizeData.ppfWingRightCond + '] +' + sizeData.ppfWingRightAlwncePlus);
	            	$('#ppfDepthLeftCond0').text('-'+sizeData.ppfDepthLeftAlwnceMinus + ' [' + sizeData.ppfDepthLeftCond + '] +' + sizeData.ppfDepthLeftAlwncePlus);
	            	$('#ppfDepthRightCond0').text('-'+sizeData.ppfDepthRightAlwnceMinus + ' [' + sizeData.ppfDepthRightCond + '] +' + sizeData.ppfDepthRightAlwncePlus);
	            	$('#filmCond0').text('-'+sizeData.filmAlwnceMinus + ' [' + sizeData.filmCond + '] +' + sizeData.filmAlwncePlus);
	            	$('#metalDepthCond0').text('-'+sizeData.metalDepthAlwnceMinus + ' [' + sizeData.metalDepthCond + '] +' + sizeData.metalDepthAlwncePlus);
	            	$('#metalThicknessCond0').text('-'+sizeData.metalThicknessAlwnceMinus + ' [' + sizeData.metalThicknessCond + '] +' + sizeData.metalThicknessAlwncePlus);
	            	$('#thCenterCond0').text('-'+sizeData.thCenterAlwnceMinus + ' [' + sizeData.thCenterCond + '] +' + sizeData.thCenterAlwncePlus);
	            	$('#thEdgeCond0').text('-'+sizeData.thEdgeAlwnceMinus + ' [' + sizeData.thEdgeCond + '] +' + sizeData.thEdgeAlwncePlus);
	            	$('#burrCond0').text('-'+sizeData.burrAlwnceMinus + ' [' + sizeData.burrCond + '] +' + sizeData.burrAlwncePlus);

	            	


	            	
	            	console.log(stepData);

	            	
	            	$('#firstWpLeftAlwnce1').text("");
	            	$('#firstWpRightAlwnce1').text("");
	            	$('#firstPitchLeftAlwnce1').text("");
	            	$('#firstPitchRightAlwnce1').text("");
	            	$('#firstPpfWingLeftAlwnce1').text("");
	            	$('#firstPpfWingRightAlwnce1').text("");
	            	$('#firstPpfDepthLeftAlwnce1').text("");
	            	$('#firstPpfDepthRightAlwnce1').text("");
	            	$('#firstFilmAlwnce1').text("");
	            	$('#firstMetalDepthAlwnce1').text("");
	            	$('#firstMetalThicknessAlwnce1').text("");
	            	$('#firstThCenterAlwnce1').text("");
	            	$('#firstThEdgeAlwncePlus1').text("");
	            	$('#firstInput1').text("");
	            	$('#firstThEdgeCnt1').text("");
	            	$('#firstThEdgeResult1').text("");
	            	$('#firstBurrMetalAlwnce1').text("");
	            	$('#firstBurrRcutAlwnce1').text("");
	            	$('#firstBurrRedgeAlwnce1').text("");

	            	$('#secondWpLeftAlwnce2').text("");
	            	$('#secondWpRightAlwnce2').text("");
	            	$('#secondPitchLeftAlwnce2').text("");
	            	$('#secondPitchRightAlwnce2').text("");
	            	$('#secondPpfWingLeftAlwnce2').text("");
	            	$('#secondPpfWingRightAlwnce2').text("");
	            	$('#secondPpfDepthLeftAlwnce2').text("");
	            	$('#secondPpfDepthRightAlwnce2').text("");
	            	$('#secondFilmAlwnce2').text("");
	            	$('#secondMetalDepthAlwnce2').text("");
	            	$('#secondMetalThicknessAlwnce2').text("");
	            	$('#secondThCenterAlwnce2').text("");
	            	$('#secondThEdgeAlwncePlus2').text("");
	            	$('#secondInput2').text("");
	            	$('#secondThEdgeCnt2').text("");
	            	$('#secondThEdgeResult2').text("");
	            	$('#secondBurrMetalAlwnce2').text("");
	            	$('#secondBurrRcutAlwnce2').text("");
	            	$('#secondBurrRedgeAlwnce2').text("");

	            	$('#thirdWpLeftAlwnce3').text("");
	            	$('#thirdWpRightAlwnce3').text("");
	            	$('#thirdPitchLeftAlwnce3').text("");
	            	$('#thirdPitchRightAlwnce3').text("");
	            	$('#thirdPpfWingLeftAlwnce3').text("");
	            	$('#thirdPpfWingRightAlwnce3').text("");
	            	$('#thirdPpfDepthLeftAlwnce3').text("");
	            	$('#thirdPpfDepthRightAlwnce3').text("");
	            	$('#thirdFilmAlwnce3').text("");
	            	$('#thirdMetalDepthAlwnce3').text("");
	            	$('#thirdMetalThicknessAlwnce3').text("");
	            	$('#thirdThCenterAlwnce3').text("");
	            	$('#thirdThEdgeAlwncePlus3').text("");
	            	$('#thirdInput3').text("");
	            	$('#thirdThEdgeCnt3').text("");
	            	$('#thirdThEdgeResult3').text("");
	            	$('#thirdBurrMetalAlwnce3').text("");
	            	$('#thirdBurrRcutAlwnce3').text("");
	            	$('#thirdBurrRedgeAlwnce3').text("");

	          	
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
				 	        	$('#firstWpLeftAlwnce1').text(item.wpLeftAlwnce);
				 	        	$('#firstWpRightAlwnce1').text(item.wpRightAlwnce);
				 	        	$('#firstPitchLeftAlwnce1').text(item.pitchLeftAlwnce);
				 	        	$('#firstPitchRightAlwnce1').text(item.pitchRightAlwnce);
				 	        	$('#firstPpfWingLeftAlwnce1').text(item.ppfWingLeftAlwnce);
				 	        	$('#firstPpfWingRightAlwnce1').text(item.ppfWingRightAlwnce);
				 	        	$('#firstPpfDepthLeftAlwnce1').text(item.ppfDepthLeftAlwnce);
				 	        	$('#firstPpfDepthRightAlwnce1').text(item.ppfDepthRightAlwnce);
				 	        	$('#firstFilmAlwnce1').text(item.filmAlwnce);
				 	        	$('#firstMetalDepthAlwnce1').text(item.metalDepthAlwnce);
				 	        	$('#firstMetalThicknessAlwnce1').text(item.metalThicknessAlwnce);
				 	        	$('#firstThCenterAlwnce1').text(item.thCenterAlwnce);
				 	        	$('#firstThEdgeAlwncePlus1').text(item.thEdgeAlwncePlus);
				 	        	$('#firstInput1').text(item.thStepInput);
				 	        	(item.thEdgeCnt == null) ? $('#firstThEdgeCnt1').text('0') : $('#firstThEdgeCnt1').text(item.thEdgeCnt);
				 	        	if (item.thEdgeResult == '001') {
				 	        		$('#firstThEdgeResult1').text('합격');
					    			$("#firstThEdgeCnt1").attr("style", "");
					    			$("#firstThEdgeResult1").attr("style", "");
					 	        } else if (item.thEdgeResult == '002') {
				 	        		$('#firstThEdgeResult1').text('불합격');
					    			$("#firstThEdgeCnt1").attr("style", "color: red;");
					    			$("#firstThEdgeResult1").attr("style", "color: red;");
						 	    } else {
						 	    	$('#firstThEdgeResult1').text('-');
					    			$("#firstThEdgeCnt1").attr("style", "");
					    			$("#firstThEdgeResult1").attr("style", "");
							 	}
				 	        	$('#firstBurrMetalAlwnce1').text(item.burrMetalAlwnce);
				 	        	$('#firstBurrRcutAlwnce1').text(item.burrRcutAlwnce);
	        	 	        	$('#firstBurrRedgeAlwnce1').text(item.burrRedgeAlwnce);
			          		} else if(idx == 1){
			          			$('#secondWpLeftAlwnce2').text(item.wpLeftAlwnce);
			 	 	        	$('#secondWpRightAlwnce2').text(item.wpRightAlwnce);
			 	 	        	$('#secondPitchLeftAlwnce2').text(item.pitchLeftAlwnce);
			 	 	        	$('#secondPitchRightAlwnce2').text(item.pitchRightAlwnce);
			 	 	        	$('#secondPpfWingLeftAlwnce2').text(item.ppfWingLeftAlwnce);
			 	 	        	$('#secondPpfWingRightAlwnce2').text(item.ppfWingRightAlwnce);
			 	 	        	$('#secondPpfDepthLeftAlwnce2').text(item.ppfDepthLeftAlwnce);
			 	 	        	$('#secondPpfDepthRightAlwnce2').text(item.ppfDepthRightAlwnce);
			 	 	        	$('#secondFilmAlwnce2').text(item.filmAlwnce);
			 	 	        	$('#secondMetalDepthAlwnce2').text(item.metalDepthAlwnce);
			 	 	        	$('#secondMetalThicknessAlwnce2').text(item.metalThicknessAlwnce);
			 	 	        	$('#secondThCenterAlwnce2').text(item.thCenterAlwnce);
			 	 	        	$('#secondThEdgeAlwncePlus2').text(item.thEdgeAlwncePlus);
			 	 	        	$('#secondInput2').text(item.thStepInput);
				 	        	(item.thEdgeCnt == null) ? $('#secondThEdgeCnt2').text('0') : $('#secondThEdgeCnt2').text(item.thEdgeCnt);
				 	        	if (item.thEdgeResult == '001') {
				 	        		$('#secondThEdgeResult2').text('합격');
					    			$("#secondThEdgeCnt2").attr("style", "");
					    			$("#secondThEdgeResult2").attr("style", "");
					 	        } else if (item.thEdgeResult == '002') {
				 	        		$('#secondThEdgeResult2').text('불합격');
					    			$("#secondThEdgeCnt2").attr("style", "color: red;");
					    			$("#secondThEdgeResult2").attr("style", "color: red;");
						 	    } else {
						 	    	$('#secondThEdgeResult2').text('-');
					    			$("#secondThEdgeCnt2").attr("style", "");
					    			$("#secondThEdgeResult2").attr("style", "");
							 	}
			 	 	        	$('#secondBurrMetalAlwnce2').text(item.burrMetalAlwnce);
			 	 	        	$('#secondBurrRcutAlwnce2').text(item.burrRcutAlwnce);
	        	 	        	$('#secondBurrRedgeAlwnce2').text(item.burrRedgeAlwnce);
			          		} else if(idx == 2){
			          			$('#thirdWpLeftAlwnce3').text(item.wpLeftAlwnce);
			 	 	        	$('#thirdWpRightAlwnce3').text(item.wpRightAlwnce);
			 	 	        	$('#thirdPitchLeftAlwnce3').text(item.pitchLeftAlwnce);
			 	 	        	$('#thirdPitchRightAlwnce3').text(item.pitchRightAlwnce);
			 	 	        	$('#thirdPpfWingLeftAlwnce3').text(item.ppfWingLeftAlwnce);
			 	 	        	$('#thirdPpfWingRightAlwnce3').text(item.ppfWingRightAlwnce);
			 	 	        	$('#thirdPpfDepthLeftAlwnce3').text(item.ppfDepthLeftAlwnce);
			 	 	        	$('#thirdPpfDepthRightAlwnce3').text(item.ppfDepthRightAlwnce);
			 	 	        	$('#thirdFilmAlwnce3').text(item.filmAlwnce);
			 	 	        	$('#thirdMetalDepthAlwnce3').text(item.metalDepthAlwnce);
			 	 	        	$('#thirdMetalThicknessAlwnce3').text(item.metalThicknessAlwnce);
			 	 	        	$('#thirdThCenterAlwnce3').text(item.thCenterAlwnce);
			 	 	        	$('#thirdThEdgeAlwncePlus3').text(item.thEdgeAlwncePlus);
			 	 	        	$('#thirdInput3').text(item.thStepInput);
				 	        	(item.thEdgeCnt == null) ? $('#thirdThEdgeCnt3').text('0') : $('#thirdThEdgeCnt3').text(item.thEdgeCnt);
				 	        	if (item.thEdgeResult == '001') {
				 	        		$('#thirdThEdgeResult3').text('합격');
					    			$("#thirdThEdgeCnt3").attr("style", "");
					    			$("#thirdThEdgeResult3").attr("style", "");
					 	        } else if (item.thEdgeResult == '002') {
				 	        		$('#thirdThEdgeResult3').text('불합격');
					    			$("#thirdThEdgeCnt3").attr("style", "color: red;");
					    			$("#thirdThEdgeResult3").attr("style", "color: red;");
						 	    } else {
						 	    	$('#thirdThEdgeResult3').text('-');
					    			$("#thirdThEdgeCnt3").attr("style", "");
					    			$("#thirdThEdgeResult3").attr("style", "");
							 	}
			 	 	        	$('#thirdBurrMetalAlwnce3').text(item.burrMetalAlwnce);
			 	 	        	$('#thirdBurrRcutAlwnce3').text(item.burrRcutAlwnce);
	        	 	        	$('#thirdBurrRedgeAlwnce3').text(item.burrRedgeAlwnce);
			          		}
            			//}
           		 	}); 		
           		 	
            		calc('firstWpLeftAlwnce1' ,sizeData.wpLeftCond ,sizeData.wpLeftAlwnceMinus ,sizeData.wpLeftAlwncePlus);
	            	calc('firstWpRightAlwnce1',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus ,sizeData.wpRightAlwncePlus);
	            	calc('firstPitchLeftAlwnce1',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	calc('firstPitchRightAlwnce1',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	calc('firstPpfWingLeftAlwnce1',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);	            	
	            	calc('firstPpfWingRightAlwnce1',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	calc('firstPpfDepthLeftAlwnce1',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	calc('firstPpfDepthRightAlwnce1',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	calc('firstFilmAlwnce1',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	calc('firstMetalDepthAlwnce1',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	calc('firstMetalThicknessAlwnce1',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	calc('firstThCenterAlwnce1',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	calc('firstThEdgeAlwncePlus1',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	calc('firstBurrMetalAlwnce1',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
	            	
	            	calc('secondWpLeftAlwnce2',sizeData.wpLeftCond,sizeData.wpLeftAlwnceMinus,sizeData.wpLeftAlwncePlus);
	            	calc('secondWpRightAlwnce2',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus,sizeData.wpRightAlwncePlus);
	            	calc('secondPitchLeftAlwnce2',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	calc('secondPitchRightAlwnce2',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	calc('secondPpfWingLeftAlwnce2',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);
	            	calc('secondPpfWingRightAlwnce2',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	calc('secondPpfDepthLeftAlwnce2',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	calc('secondPpfDepthRightAlwnce2',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	calc('secondFilmAlwnce2',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	calc('secondMetalDepthAlwnce2',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	calc('secondMetalThicknessAlwnce2',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	calc('secondThCenterAlwnce2',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	calc('secondThEdgeAlwncePlus2',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	calc('secondBurrMetalAlwnce2',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);
	            	
	            	calc('thirdWpLeftAlwnce3',sizeData.wpLeftCond,sizeData.wpLeftAlwnceMinus,sizeData.wpLeftAlwncePlus);
	            	calc('thirdWpRightAlwnce3',sizeData.wpRightCond,sizeData.wpRightAlwnceMinus,sizeData.wpRightAlwncePlus);
	            	calc('thirdPitchLeftAlwnce3',sizeData.pitchLeftCond,sizeData.pitchLeftAlwnceMinus,sizeData.pitchLeftAlwncePlus);
	            	calc('thirdPitchRightAlwnce3',sizeData.pitchRightCond,sizeData.pitchRightAlwnceMinus,sizeData.pitchRightAlwncePlus);
	            	calc('thirdPpfWingLeftAlwnce3',sizeData.ppfWingLeftCond,sizeData.ppfWingLeftAlwnceMinus,sizeData.ppfWingLeftAlwncePlus);
	            	calc('thirdPpfWingRightAlwnce3',sizeData.ppfWingRightCond,sizeData.ppfWingRightAlwnceMinus,sizeData.ppfWingRightAlwncePlus);
	            	calc('thirdPpfDepthLeftAlwnce3',sizeData.ppfDepthLeftCond,sizeData.ppfDepthLeftAlwnceMinus,sizeData.ppfDepthLeftAlwncePlus);
	            	calc('thirdPpfDepthRightAlwnce3',sizeData.ppfDepthRightCond,sizeData.ppfDepthRightAlwnceMinus,sizeData.ppfDepthRightAlwncePlus);
	            	calc('thirdFilmAlwnce3',sizeData.filmCond,sizeData.filmAlwnceMinus,sizeData.filmAlwncePlus);
	            	calc('thirdMetalDepthAlwnce3',sizeData.metalDepthCond,sizeData.metalDepthAlwnceMinus,sizeData.metalDepthAlwncePlus);
	            	calc('thirdMetalThicknessAlwnce3',sizeData.metalThicknessCond,sizeData.metalThicknessAlwnceMinus,sizeData.metalThicknessAlwncePlus);
	            	calc('thirdThCenterAlwnce3',sizeData.thCenterCond,sizeData.thCenterAlwnceMinus,sizeData.thCenterAlwncePlus);
	            	calc('thirdThEdgeAlwncePlus3',sizeData.thEdgeCond,sizeData.thEdgeAlwnceMinus,sizeData.thEdgeAlwncePlus);
	            	calc('thirdBurrMetalAlwnce3',sizeData.burrCond,sizeData.burrAlwnceMinus,sizeData.burrAlwncePlus);    		
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
			toastr.warning("종물을 입력할 작업지시를 선택해주세요!");
			return false;
		}
		//자재행 선택하였는지 확인
		if ($("#workOrderTable").find(".selected").length != 1) {
			toastr.warning("종물을 입력할 주자재(MetalLot)를 선택해주세요!");
			return false;
		}
		if (lotNo == null || lotNo == '') {
			toastr.warning("종물을 입력할 주자재(MetalLot)를 선택해주세요!");
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
	  	  	  	toastr.warning("미발행 작업지시는 종물을 입력할 수 없습니다!");
	  	  	  	return false;
	  	  	}
			if (workStatusCd == "P") {
	  	  	  	toastr.warning("발행 작업지시는 종물을 입력 할 수 없습니다!");
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
			$('#ordLotNoStepTitle').text(lotNo + ' / 종물');
			$('#ordLotNoStepModal').modal({backdrop: 'static'});
			$('#ordLotNoStepModal').modal('show');
		}
	});

	//에이전트 치수 데이터 조회
	function agtSizeDataRead() {
		$('#my-spinner').show();
		
   	    $.ajax({
   	    	url: '<c:url value="/po/agtReadSize_F3"/>',
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
					console.log(data.length);
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
							data[i].thEdgeCnt == null ? $('#'+stepNm+'ThEdgeCnt').val(0) : $('#'+stepNm+'ThEdgeCnt').val(data[i].thEdgeCnt);
							$('#'+stepNm+'ThEdgeResult').val(data[i].thEdgeResult);
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
							console.log(data[i]);
						}
					}

				} else {
					toastr.error(res.message, '(에이전트 치수 데이터 조회)', {timeOut: 5000});
				}
   	        },
			complete:function(){
		
 				
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
		
		//치수
		$.ajax({
			url: '<c:url value="/po/agtUpdateSize"/>',
			type: 'POST',
			async: false,
			data: {
				'menuAuth'				:	menuAuth,
				'workOrdNo'				:	function() { return workOrdNo; },
				//'ordLotNo'				:	function() { return ordLotNo; },
				'stepCd'				:	function() { return ordLotNoStepCd; },//sideView == 'firstStep'?'001':'002',
				'lotNo'					:	function() { return lotNo; },
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
		
		
		$('#my-spinner').show();

		//DGS Redis사용
		$.ajax({
			url: '<c:url value="po/workOrderStepInsertRedis_DB0_F2F3"/>',
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
	
		$.ajax({
			url: '<c:url value="po/agtFirstDelete"/>',
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
	
</script>
</body>
</html>
