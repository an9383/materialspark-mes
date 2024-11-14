<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/body-top.jsp" %>

<div class="page-wrapper" id="page-wrapper">
	<!--header ============================================================== -->
	<header class="page-title-bar row">
		<nav aria-label="breadcrumb" class="breadcrumb-padding">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">설비연동</a></li>
				<li class="breadcrumb-item active">가동시간</li>
			</ol>
		</nav>
	</header>
	<!-- #main============================================================== -->
	<div class="container-fluid" id="main">
		<div class="row table-wrap-hid">
			<!--======================== .left-list ========================-->
			<div class="left-list left-60" id="left-60" style="width: 12%;">
				<div class="card">
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
			<!--======================== .right-sidebar 등록,수정 ========================-->
			<div class="right-list right-70" id="myrSidenav" style="width: 87%;">		
				<div class="card-body col-sm-12" style="padding: 7px;">
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab">가동시간</a></li>
						</ul>
					</div>
				</div>
				<div class="table-responsive">
					<table id="workTimeTable" class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th style="width: 120px">작지번호</th>
								<th style="width: 50px">제품</th>
								<th style="width: 50px">재질</th>
								<th style="width: 120px">규격</th>
								<th style="width: 120px">LotNo</th>
								<th style="width: 50px">상태</th>
								<th style="width: 60px">시작시간</th>
								<th style="width: 60px">종료시간</th>
								<th style="width: 60px">가동시간</th>
								<th style="width: 50px">근무조</th>
								<th style="width: 70px">주작업담당</th>
								<th style="width: 70px">서브작업담당</th>
								<th style="width: 60px">가동시간합계</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<td colspan="" style="text-align: right">합계</td>
								<td colspan="7" style="text-align: right"></td>
								<td colspan="" id="sum1" style="text-align: right">0</td>
								<td colspan="3" style="text-align: right"></td>
							</tr>
						</tfoot>
					</table>
				</div>
				<div class="card-body col-sm-12" style="padding: 10px;">
					<div class="card-header card-tab">
						<ul class="nav nav-tabs card-header-tabs">
							<li class="nav-item"><a class="nav-link active show" data-toggle="tab" id="tabActualOutput">생산실적</a></li>
							<li class="nav-item"><a class="nav-link" data-toggle="tab" id="tabBomTalbe">제조조건</a>
							</li>
						</ul>
					</div>
				</div>
				<div id="actualOutput" >
					<div class="table-responsive">
						<table id="actualOutputTable" class="table table-bordered">
							<thead class="thead-light">
								<tr>
									<th style="width: 120px"class="text-center">작지번호</th>
									<th style="width: 60px" class="text-center">제품</th>
									<th style="width: 60px" class="text-center">재질</th>
									<th style="width: 120px"class="text-center">규격</th>
									<th style="width: 120px"class="text-center">Lot No</th>
									<th style="width: 60px" class="text-center">상태</th>
									<th style="width: 60px" class="text-center">투입중량</th>
									<th style="width: 60px" class="text-center">생산량</th>
									<th style="width: 60px" class="text-center">불량</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<td colspan="" style="text-align: right">합계</td>
									<td colspan="5" style="text-align: right"></td>
									<td colspan="" id="sum2" style="text-align: right">0</td>
									<td colspan="" id="sum3" style="text-align: right">0</td>
									<td colspan="" id="sum4" style="text-align: right">0</td>					
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				
				<div id="bomTable" class="d-none" >
					<div class="table-responsive">
						<table class="table table-bordered">
							<thead class="thead-light">
							<tr>
								<th style="min-width: 50px">구분	</th>
								<th colspan="21" >온도(°C)	</th>
							</tr>
							</thead>
							<tr>
								<th></th>
								<th>예열</th>    
								<th>가접1-상</th> 
								<th>가접1-하</th> 
								<th style="min-width: 45px">가접2-상좌</th>
								<th style="min-width: 45px">가접2-하좌</th>
								<th style="min-width: 45px">가접2-상우</th>
								<th style="min-width: 45px">가접2-하우</th>
								<th>롤히터-상</th> 
								<th>롤히터-하</th> 
								<th>1차-상좌</th> 
								<th>1차-하좌</th> 
								<th>1차-상우</th> 
								<th>1차-하우</th> 
								<th>2차-상좌</th> 
								<th>2차-하좌</th> 
								<th>2차-상우</th> 
								<th>2차-하우</th> 
								<th>3차-상좌</th> 
								<th>3차-하좌</th> 
								<th>3차-상우</th> 
								<th>3차-하우</th> 
							</tr>
							<tr>
								<th>조건	</th>
								<td align="right"><span id="tempaturViewWarmupCond" 		 ></span></td>
								<td align="right"><span id="tempaturViewFitup1UpCond" 		 ></span></td>
								<td align="right"><span id="tempaturViewFitup1DownCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFitup2UpleftCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFitup2DownleftCond"  ></span></td>
								<td align="right"><span id="tempaturViewFitup2UprightCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFitup2DownrightCond" ></span></td>
								<td align="right"><span id="tempaturViewRollheatUpCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewRollheatDownCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFirstUpleftCond"	 ></span></td>
								<td align="right"><span id="tempaturViewFirstDownleftCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFirstUprightCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewFirstDownrightCond"  ></span></td>
								<td align="right"><span id="tempaturViewSecondUpleftCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewSecondDownleftCond"  ></span></td>
								<td align="right"><span id="tempaturViewSecondUprightCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewSecondDownrightCond" ></span></td>
								<td align="right"><span id="tempaturViewThirdUpleftCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewThirdDownleftCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewThirdUprightCond" 	 ></span></td>
								<td align="right"><span id="tempaturViewThirdDownrightCond"  ></span></td>
								

							</tr>
							<tr>
								<th>공차 (+)</th>
								<td align="right"><span id="tempaturViewWarmupAlwncePlus" 			></span></td>
								<td align="right"><span id="tempaturViewFitup1UpAlwncePlus" 		></span></td>
								<td align="right"><span id="tempaturViewFitup1DownAlwncePlus" 		></span></td>
								<td align="right"><span id="tempaturViewFitup2UpleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFitup2DownleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFitup2UprightAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFitup2DownrightAlwncePlus"	></span></td>
								<td align="right"><span id="tempaturViewRollheatUpAlwncePlus" 		></span></td>
								<td align="right"><span id="tempaturViewRollheatDownAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFirstUpleftAlwncePlus" 		></span></td>
								<td align="right"><span id="tempaturViewFirstDownleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFirstUprightAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewFirstDownrightAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewSecondUpleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewSecondDownleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewSecondUprightAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewSecondDownrightAlwncePlus"	></span></td>
								<td align="right"><span id="tempaturViewThirdUpleftAlwncePlus" 		></span></td>
								<td align="right"><span id="tempaturViewThirdDownleftAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewThirdUprightAlwncePlus" 	></span></td>
								<td align="right"><span id="tempaturViewThirdDownrightAlwncePlus" 	></span></td>
							</tr>
							<tr>
								<th>공차 (-)</th>
								<td align="right"><span id="tempaturViewWarmupAlwnceMinus"			></span></td>
								<td align="right"><span id="tempaturViewFitup1UpAlwnceMinus"		></span></td>
								<td align="right"><span id="tempaturViewFitup1DownAlwnceMinus"		></span></td>
								<td align="right"><span id="tempaturViewFitup2UpleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFitup2DownleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFitup2UprightAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFitup2DownrightAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewRollheatUpAlwnceMinus"		></span></td>
								<td align="right"><span id="tempaturViewRollheatDownAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFirstUpleftAlwnceMinus"		></span></td>
								<td align="right"><span id="tempaturViewFirstDownleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFirstUprightAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewFirstDownrightAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewSecondUpleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewSecondDownleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewSecondUprightAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewSecondDownrightAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewThirdUpleftAlwnceMinus"		></span></td>
								<td align="right"><span id="tempaturViewThirdDownleftAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewThirdUprightAlwnceMinus"	></span></td>
								<td align="right"><span id="tempaturViewThirdDownrightAlwnceMinus"	></span></td>
							</tr>
						</table>
						<table class="table table-bordered">
							<thead class="thead-light">
							<tr>
								<th style="min-width: 50px">구분	</th>
								<th colspan="6" >온도(°C)	</th>
								<th colspan="9" >시간(SEC)</th>
								<th colspan="5" >압력(Mpz)</th>
							</tr>
							</thead>
							<tr>
								<th></th>
								<th style="min-width:45px">1차푸셔-상</th>
								<th style="min-width:45px">1차푸셔-하</th>
								<th style="min-width:45px">1차진접-상</th>
								<th style="min-width:45px">1차진접-하</th>
								<th style="min-width:45px">2차진접-상</th>
								<th style="min-width:45px">2차진접-하</th>
								<th style="min-width:40px">가접1	</th>
								<th style="min-width:40px">가접2	</th>
								<th style="min-width:40px">1차	</th>
								<th style="min-width:40px">1차푸셔</th>
								<th style="min-width:40px">2차	</th>
								<th style="min-width:40px">3차	</th>
								<th style="min-width:40px">1차진접</th>
								<th style="min-width:40px">2차진접</th>
								<th style="min-width:40px">리폼	</th>
								<th style="min-width:40px">가접	</th>
								<th style="min-width:40px">1차푸셔</th>
								<!-- <th style="min-width:40px">2차	</th> -->
								<th style="min-width:40px">1차진접</th>
								<th style="min-width:40px">2차진접</th>
								<th style="min-width:40px">냉각	</th>
							</tr>
							<tr>
								<th>조건	</th>
								<td align="right"><span id="tempaturViewPush1UpCond"></span></td>
								<td align="right"><span id="tempaturViewPush1DownCond"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1UpCond"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1DownCond"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2UpCond"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2DownCond"></span></td>
								<td align="right"><span id="timeViewFitupCond"></span></td>
								<td align="right"><span id="timeViewFitup2Cond"></span></td>
								<td align="right"><span id="timeViewFirstCond"></span></td>
								<td align="right"><span id="timeViewPush1Cond"></span></td>
								<td align="right"><span id="timeViewSecondCond"></span></td>
								<td align="right"><span id="timeViewThirdCond"></span></td>
								<td align="right"><span id="timeViewJinjeopCond"></span></td>
								<td align="right"><span id="timeViewJinjeop2Cond"></span></td>
								<td align="right"><span id="timeViewReformCond"></span></td>
								<td align="right"><span id="pressureViewFitupCond"></span></td>
								<td align="right"><span id="pressureViewPush1Cond"></span></td>
								<!-- <td align="right"><span id="pressureViewSecondCond"></span></td> -->
								<td align="right"><span id="pressureViewJinjeopCond"></span></td>
								<td align="right"><span id="pressureViewJinjeop2Cond"></span></td>
								<td align="right"><span id="pressureViewCoolCond"></span></td>
							</tr>
							<tr>
								<th>공차 (+)</th>
								<td align="right"><span id="tempaturViewPush1UpAlwncePlus"></span></td>
								<td align="right"><span id="tempaturViewPush1DownAlwncePlus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1UpAlwncePlus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1DownAlwncePlus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2UpAlwncePlus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2DownAlwncePlus"></span></td>
								<td align="right"><span id="timeViewFitupAlwncePlus"></span></td>
								<td align="right"><span id="timeViewFitup2AlwncePlus"></span></td>
								<td align="right"><span id="timeViewFirstAlwncePlus"></span></td>
								<td align="right"><span id="timeViewPush1AlwncePlus"></span></td>
								<td align="right"><span id="timeViewSecondAlwncePlus"></span></td>
								<td align="right"><span id="timeViewThirdAlwncePlus"></span></td>
								<td align="right"><span id="timeViewJinjeopAlwncePlus"></span></td>
								<td align="right"><span id="timeViewJinjeop2AlwncePlus"></span></td>
								<td align="right"><span id="timeViewReformAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewFitupAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewPush1AlwncePlus"></span></td>
								<!-- <td align="right"><span id="pressureViewSecondAlwncePlus"></span></td> -->
								<td align="right"><span id="pressureViewJinjeopAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewJinjeop2AlwncePlus"></span></td>
								<td align="right"><span id="pressureViewCoolAlwncePlus"></span></td>
							</tr>
							<tr>
								<th>공차 (-)</th>
								<td align="right"><span id="tempaturViewPush1UpAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewPush1DownAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1UpAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop1DownAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2UpAlwnceMinus"></span></td>
								<td align="right"><span id="tempaturViewJinjeop2DownAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewFitupAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewFitup2AlwnceMinus"></span></td>
								<td align="right"><span id="timeViewFirstAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewPush1AlwnceMinus"></span></td>
								<td align="right"><span id="timeViewSecondAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewThirdAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewJinjeopAlwnceMinus"></span></td>
								<td align="right"><span id="timeViewJinjeop2AlwnceMinus"></span></td>
								<td align="right"><span id="timeViewReformAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewFitupAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewPush1AlwnceMinus"></span></td>
								<!-- <td align="right"><span id="pressureViewSecondAlwnceMinus"></span></td> -->
								<td align="right"><span id="pressureViewJinjeopAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewJinjeop2AlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewCoolAlwnceMinus"></span></td>
							</tr>
						</table>
						<table class="table table-bordered" id="timeView">
							<thead class="thead-light">
							<tr>
								<th style="min-width: 50px">위치</th>
								<th colspan="2">Welding Part</th>
								<th colspan="2">Pitch</th>
								<th colspan="2">P.P Film 날개</th>
								<th colspan="2">P.P Film 폭</th>
								<th 		   >Film</th>
								<th colspan="2">METAL</th>
								<th colspan="2">총두께</th>
								<th colspan="3">Burr</th>
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
								<th>Edge</th>
								<th>Metal</th>
								<th>R-Cut</th>
								<th>R끝단</th>																
							</tr>
							<tr>
								<th>조건	</th>
								<td align="right"><span id="sizeViewWpLeftCond"></span></td>
								<td align="right"><span id="sizeViewWpRightCond"></span></td>
								<td align="right"><span id="sizeViewPitchLeftCond"></span></td>
								<td align="right"><span id="sizeViewPitchRightCond"></span></td>
								<td align="right"><span id="sizeViewPpfWingLeftCond"></span></td>
								<td align="right"><span id="sizeViewPpfWingRightCond"></span></td>
								<td align="right"><span id="sizeViewPpfDepthLeftCond"></span></td>
								<td align="right"><span id="sizeViewPpfDepthRightCond"></span></td>
								<td align="right"><span id="sizeViewFilmCond"></span></td>
								<td align="right"><span id="sizeViewMetalDepthCond"></span></td>
								<td align="right"><span id="sizeViewMetalThicknessCond"></span></td>
								<td align="right"><span id="sizeViewThCenterCond"></span></td>
								<td align="right"><span id="sizeViewThEdgeCond"></span></td>
								<td align="right" colspan="3"><span id="sizeViewBurrCond"></span></td>
							</tr>
							<tr>
								<th>공차 (+)</th>
								<td align="right"><span id="sizeViewWpLeftAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewWpRightAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPitchLeftAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPitchRightAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPpfWingLeftAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPpfWingRightAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPpfDepthLeftAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewPpfDepthRightAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewFilmAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewMetalDepthAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewMetalThicknessAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewThCenterAlwncePlus"></span></td>
								<td align="right"><span id="sizeViewThEdgeAlwncePlus"></span></td>
								<td align="right" colspan="3"><span id="sizeViewBurrAlwncePlus"></span></td>
							</tr>
							<tr>
								<th>공차 (-)</th>
								<td align="right"><span id="sizeViewWpLeftAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewWpRightAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPitchLeftAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPitchRightAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPpfWingLeftAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPpfWingRightAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPpfDepthLeftAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewPpfDepthRightAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewFilmAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewMetalDepthAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewMetalThicknessAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewThCenterAlwnceMinus"></span></td>
								<td align="right"><span id="sizeViewThEdgeAlwnceMinus"></span></td>
								<td align="right" colspan="3"><span id="sizeViewBurrAlwnceMinus"></span></td>
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
</div>
<!-- /.page-wrapper -->
<!-- 제조조건관리 모달 시작-->
<!-- <button type="button" class="btn btn-primary"  data-toggle="modal" data-target=".bd-example-modal-lg">제품코드조회</button> -->
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
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- 제조조건관리 모달 종료-->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'eisc0010';
	let currentHref = 'eisc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title","가동시간");
	
	//공통코드 처리 시작
	var equipGroupCode = new Array();	//설비그룹
    <c:forEach items="${equipGroup}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>

	var ordGubunCode = new Array();		//오더구분(주/야 구분)
    <c:forEach items="${ordGubunCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		ordGubunCode.push(json);
    </c:forEach>    
    //공통코드 처리 종료  
    
    // 목록
	var equipCd = null;		//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)    
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
    var ordDateCal =  "${serverDate}";
	var ordGubunCd = null; 
	
	let factoryCode	= "<%=factoryCode%>";
	let equipGubun	= null;
	if( factoryCode == "003" ) {
		equipGubun = "D";
	}

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
        pageLength: 10,
        ajax: {
            url: '<c:url value="bm/equipCodeAdmDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
            	'equipGroup' : function() { return equipGroup; },
            	'equipGubun' : function() { return equipGubun; },
            },
        },
        rowId: 'equipCd',
		columns: [
			{ data: 'equipNm' },
		],
		order: [
			[ 0, 'asc' ],
		],
        buttons: [
        ],
	    drawCallback: function( settings ) {
	    	$('#equipCodeAdmTable_previous').html('');
	    	$('#equipCodeAdmTable_next').html('');
	    	$('#equipCodeAdmTable tbody tr td').css('height','52px');
	    }
    });

    var html1 =  '<div class="row">&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select></div>';
	$('#equipCodeAdmTable_length').html(html1)
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	$('#workTimeTable').DataTable().clear().draw();
	 	$('#actualOutputTable').DataTable().clear().draw();
	 	equipCd = "";
	});

       
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
        }	
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
            bomDataClear();
            equipCd = equipCodeAdmTable.row( this ).data().equipCd;
            ordDateCal =  $('#ordDate').val();
	    	ordGubunCd =  $('#ordGubunCd option:selected').val();
        	$('#workTimeTable').DataTable().ajax.reload( function () {});
        	$('#actualOutputTable').DataTable().ajax.reload( function () {});
        }
    });

	//가동시간 목록
	$.fn.dataTable.ext.errMode = 'none';
	let workTimeTable = $('#workTimeTable').on( 'error.dt', function ( e, settings, techNote, message ) {
		if(techNote == 7) {
			toastr.error("로그인 세션이 만료 되었습니다.<br/>재로그인 해 주세요.", '', {timeOut: 5000});
			location.href = "/";
		}
	}).DataTable({
		language: lang_kor,
		paging: true,
		info: false,
		ordering: true,
		processing: true,
		searching: false,
		autoWidth: false,
		pageLength: 20,
        ajax: {
            url: '<c:url value="po/workOrderDataList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
                'equipCd' : function() { return equipCd; }, 
            	'ordDate' : function() { return ordDateCal.replace(/-/g, ''); },
            	'ordGubun' : function() { return ordGubunCd; },
            },
        },
		columns: [
			{ data: 'workOrdNo' },
			{ data: 'goodsNm' },
			{ data: 'qutyNm' },
			{ data: 'model' },
			{ data: 'ordLotNo' },
			{ data: 'workStatusNm' },
			{
				render: function(data, type, row) {
					return (row['workStartTime']?moment(row['workStartTime']).format('HH:mm'):'');	//HH 24형식, hh AM,PM형식
				}
			},
			{
				render: function(data, type, row) {
					return (row['workEndTime']?moment(row['workEndTime']).format('HH:mm'):'');
				}
			},
			{
				render: function(data, type, row) {
					
					let hour = parseInt(row['workTime'] / 60);
					let minute = row['workTime'] % 60;


					return hour + ":" + minute;
				}
			},
			{ data: 'workTeamNm' },
			{ data: 'mainWorkChargrNm' },
			{ data: 'subWorkChargrNm' },
			{ data: 'workTime' },
		],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5,6,7,8,9,10,11], className: 'text-center' },
        	{ targets: [12], visible : false },   
        ],
		order: [
			[ 0, 'asc' ],
		],
		drawCallback: function () {
            var sum1 = $('#workTimeTable').DataTable().column(12,{ page: 'current'} ).data().sum();
            let hour = parseInt(sum1 / 60);
			let minute = sum1 % 60;
            $('#sum1').html((hour + ":" + minute).toLocaleString());
        },
    });

	var html2 = '<div class="row">&nbsp;<label class="input-label-sm">가동일</label><div class="form-group input-sub m-0 row">';
	html2 += '<input class="form-control" style="width:97px;" type="text" id="ordDate" name="ordDate" />';
	html2 += '<button onclick="fnPopUpCalendar(ordDate,ordDate,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="ordDateCalendar" type="button">';
	html2 += '<span class="oi oi-calendar"></span>';
	html2 += '</button>';
	html2 += '</div>';
	html2 += '&nbsp;&nbsp;&nbsp;<label class="input-label-sm">주야</label><select  class="custom-select" id="ordGubunCd" ></select>&nbsp;  <button type="button" class="btn btn-primary" id="btnWorkOrdRetv">조회</button></div>';

	$('#workTimeTable_length').html(html2)
	
	$('#ordDate').val(ordDateCal);
	selectBoxAppend(ordGubunCode, "ordGubunCd", "", "1");
	//$('#workTimeTable_paginate').html("&nbsp;");
	
    $('#workTimeTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            //$(this).removeClass('selected');
		}	
        else {
        	$('#workTimeTable').DataTable().$('tr.selected').removeClass('selected');
            $(this).addClass('selected');

            let equipCondSeq = workTimeTable.row(this).data().equipCondSeq;
	      	$.ajax({
				url: '<c:url value="/wm/onlyBomDataList"/>',
				type: 'GET',
				data: {
					'equipCondSeq'	: equipCondSeq,
				},
				success: function (res) {
					let tempaturData = res.tempaturData;
					let timeData = res.timeData;
					let pressureData = res.pressureData;
					let sizeData = res.sizeData;
					
					if (res.result == 'ok') {
						$('#tempaturViewWarmupCond').text(tempaturData.warmupCond);
						$('#tempaturViewWarmupAlwncePlus').text(tempaturData.warmupAlwncePlus);
						$('#tempaturViewWarmupAlwnceMinus').text(tempaturData.warmupAlwnceMinus);
						$('#tempaturViewFitup1UpCond').text(tempaturData.fitup1UpCond);
						$('#tempaturViewFitup1UpAlwncePlus').text(tempaturData.fitup1UpAlwncePlus);
						$('#tempaturViewFitup1UpAlwnceMinus').text(tempaturData.fitup1UpAlwnceMinus);
						$('#tempaturViewFitup1DownCond').text(tempaturData.fitup1DownCond);
						$('#tempaturViewFitup1DownAlwncePlus').text(tempaturData.fitup1DownAlwncePlus);
						$('#tempaturViewFitup1DownAlwnceMinus').text(tempaturData.fitup1DownAlwnceMinus);
						$('#tempaturViewFitup2UpleftCond').text(tempaturData.fitup2UpleftCond);
						$('#tempaturViewFitup2UpleftAlwncePlus').text(tempaturData.fitup2UpleftAlwncePlus);
						$('#tempaturViewFitup2UpleftAlwnceMinus').text(tempaturData.fitup2UpleftAlwnceMinus);
						$('#tempaturViewFitup2DownleftCond').text(tempaturData.fitup2DownleftCond);
						$('#tempaturViewFitup2DownleftAlwncePlus').text(tempaturData.fitup2DownleftAlwncePlus);
						$('#tempaturViewFitup2DownleftAlwnceMinus').text(tempaturData.fitup2DownleftAlwnceMinus);
						$('#tempaturViewFitup2UprightCond').text(tempaturData.fitup2UprightCond);
						$('#tempaturViewFitup2UprightAlwncePlus').text(tempaturData.fitup2UprightAlwncePlus);
						$('#tempaturViewFitup2UprightAlwnceMinus').text(tempaturData.fitup2UprightAlwnceMinus);
						$('#tempaturViewFitup2DownrightCond').text(tempaturData.fitup2DownrightCond);
						$('#tempaturViewFitup2DownrightAlwncePlus').text(tempaturData.fitup2DownrightAlwncePlus);
						$('#tempaturViewFitup2DownrightAlwnceMinus').text(tempaturData.fitup2DownrightAlwnceMinus);
						$('#tempaturViewRollheatUpCond').text(tempaturData.rollheatUpCond);
						$('#tempaturViewRollheatUpAlwncePlus').text(tempaturData.rollheatUpAlwncePlus);
						$('#tempaturViewRollheatUpAlwnceMinus').text(tempaturData.rollheatUpAlwnceMinus);
						$('#tempaturViewRollheatDownCond').text(tempaturData.rollheatDownCond);
						$('#tempaturViewRollheatDownAlwncePlus').text(tempaturData.rollheatDownAlwncePlus);
						$('#tempaturViewRollheatDownAlwnceMinus').text(tempaturData.rollheatDownAlwnceMinus);
						$('#tempaturViewFirstUpleftCond').text(tempaturData.firstUpleftCond);
						$('#tempaturViewFirstUpleftAlwncePlus').text(tempaturData.firstUpleftAlwncePlus);
						$('#tempaturViewFirstUpleftAlwnceMinus').text(tempaturData.firstUpleftAlwnceMinus);
						$('#tempaturViewFirstDownleftCond').text(tempaturData.firstDownleftCond);
						$('#tempaturViewFirstDownleftAlwncePlus').text(tempaturData.firstDownleftAlwncePlus);
						$('#tempaturViewFirstDownleftAlwnceMinus').text(tempaturData.firstDownleftAlwnceMinus);
						$('#tempaturViewFirstUprightCond').text(tempaturData.firstUprightCond);
						$('#tempaturViewFirstUprightAlwncePlus').text(tempaturData.firstUprightAlwncePlus);
						$('#tempaturViewFirstUprightAlwnceMinus').text(tempaturData.firstUprightAlwnceMinus);
						$('#tempaturViewFirstDownrightCond').text(tempaturData.firstDownrightCond);
						$('#tempaturViewFirstDownrightAlwncePlus').text(tempaturData.firstDownrightAlwncePlus);
						$('#tempaturViewFirstDownrightAlwnceMinus').text(tempaturData.firstDownrightAlwnceMinus);

						$('#tempaturViewPush1UpCond').text(tempaturData.push1UpCond);
						$('#tempaturViewPush1UpAlwncePlus').text(tempaturData.push1UpAlwncePlus);
						$('#tempaturViewPush1UpAlwnceMinus').text(tempaturData.push1UpAlwnceMinus);
						$('#tempaturViewPush1DownCond').text(tempaturData.push1DownCond);
						$('#tempaturViewPush1DownAlwncePlus').text(tempaturData.push1DownAlwncePlus);
						$('#tempaturViewPush1DownAlwnceMinus').text(tempaturData.push1DownAlwnceMinus);
						
						$('#tempaturViewSecondUpleftCond').text(tempaturData.secondUpleftCond);
						$('#tempaturViewSecondUpleftAlwncePlus').text(tempaturData.secondUpleftAlwncePlus);
						$('#tempaturViewSecondUpleftAlwnceMinus').text(tempaturData.secondUpleftAlwnceMinus);
						$('#tempaturViewSecondDownleftCond').text(tempaturData.secondDownleftCond);
						$('#tempaturViewSecondDownleftAlwncePlus').text(tempaturData.secondDownleftAlwncePlus);
						$('#tempaturViewSecondDownleftAlwnceMinus').text(tempaturData.secondDownleftAlwnceMinus);
						$('#tempaturViewSecondUprightCond').text(tempaturData.secondUprightCond);
						$('#tempaturViewSecondUprightAlwncePlus').text(tempaturData.secondUprightAlwncePlus);
						$('#tempaturViewSecondUprightAlwnceMinus').text(tempaturData.secondUprightAlwnceMinus);
						$('#tempaturViewSecondDownrightCond').text(tempaturData.secondDownrightCond);
						$('#tempaturViewSecondDownrightAlwncePlus').text(tempaturData.secondDownrightAlwncePlus);
						$('#tempaturViewSecondDownrightAlwnceMinus').text(tempaturData.secondDownrightAlwnceMinus);
						$('#tempaturViewThirdUpleftCond').text(tempaturData.thirdUpleftCond);
						$('#tempaturViewThirdUpleftAlwncePlus').text(tempaturData.thirdUpleftAlwncePlus);
						$('#tempaturViewThirdUpleftAlwnceMinus').text(tempaturData.thirdUpleftAlwnceMinus);
						$('#tempaturViewThirdDownleftCond').text(tempaturData.thirdDownleftCond);
						$('#tempaturViewThirdDownleftAlwncePlus').text(tempaturData.thirdDownleftAlwncePlus);
						$('#tempaturViewThirdDownleftAlwnceMinus').text(tempaturData.thirdDownleftAlwnceMinus);
						$('#tempaturViewThirdUprightCond').text(tempaturData.thirdUprightCond);
						$('#tempaturViewThirdUprightAlwncePlus').text(tempaturData.thirdUprightAlwncePlus);
						$('#tempaturViewThirdUprightAlwnceMinus').text(tempaturData.thirdUprightAlwnceMinus);
						$('#tempaturViewThirdDownrightCond').text(tempaturData.thirdDownrightCond);
						$('#tempaturViewThirdDownrightAlwncePlus').text(tempaturData.thirdDownrightAlwncePlus);
						$('#tempaturViewThirdDownrightAlwnceMinus').text(tempaturData.thirdDownrightAlwnceMinus);
						$('#tempaturViewJinjeop1UpCond').text(tempaturData.jinjeop1UpCond);
						$('#tempaturViewJinjeop1UpAlwncePlus').text(tempaturData.jinjeop1UpAlwncePlus);
						$('#tempaturViewJinjeop1UpAlwnceMinus').text(tempaturData.jinjeop1UpAlwnceMinus);
						$('#tempaturViewJinjeop1DownCond').text(tempaturData.jinjeop1DownCond);
						$('#tempaturViewJinjeop1DownAlwncePlus').text(tempaturData.jinjeop1DownAlwncePlus);
						$('#tempaturViewJinjeop1DownAlwnceMinus').text(tempaturData.jinjeop1DownAlwnceMinus);
						$('#tempaturViewJinjeop2UpCond').text(tempaturData.jinjeop2UpCond);
						$('#tempaturViewJinjeop2UpAlwncePlus').text(tempaturData.jinjeop2UpAlwncePlus);
						$('#tempaturViewJinjeop2UpAlwnceMinus').text(tempaturData.jinjeop2UpAlwnceMinus);
						$('#tempaturViewJinjeop2DownCond').text(tempaturData.jinjeop2DownCond);
						$('#tempaturViewJinjeop2DownAlwncePlus').text(tempaturData.jinjeop2DownAlwncePlus);
						$('#tempaturViewJinjeop2DownAlwnceMinus').text(tempaturData.jinjeop2DownAlwnceMinus);

 	                    $('#timeViewWarmupCond').text(timeData.warmupCond);
 	                    $('#timeViewWarmupAlwncePlus').text(timeData.warmupAlwncePlus);
 	                    $('#timeViewWarmupAlwnceMinus').text(timeData.warmupAlwnceMinus);
 	                    $('#timeViewFitupCond').text(timeData.fitupCond);
 	                    $('#timeViewFitupAlwncePlus').text(timeData.fitupAlwncePlus);
 	                    $('#timeViewFitupAlwnceMinus').text(timeData.fitupAlwnceMinus);
 	               		$('#timeViewFitup2Cond').text(timeData.fitup2Cond);
	                    	$('#timeViewFitup2AlwncePlus').text(timeData.fitup2AlwncePlus);
	                    	$('#timeViewFitup2AlwnceMinus').text(timeData.fitup2AlwnceMinus);
 	                    $('#timeViewFirstCond').text(timeData.firstCond);
 	                    $('#timeViewFirstAlwncePlus').text(timeData.firstAlwncePlus);
 	                    $('#timeViewFirstAlwnceMinus').text(timeData.firstAlwnceMinus);
 	                    $('#timeViewSecondCond').text(timeData.secondCond);
 	                    $('#timeViewSecondAlwncePlus').text(timeData.secondAlwncePlus);
 	                    $('#timeViewSecondAlwnceMinus').text(timeData.secondAlwnceMinus);
 	                    $('#timeViewThirdCond').text(timeData.thirdCond);
	                    	$('#timeViewThirdAlwncePlus').text(timeData.thirdAlwncePlus);
	                    	$('#timeViewThirdAlwnceMinus').text(timeData.thirdAlwnceMinus);
 	                    $('#timeViewJinjeopCond').text(timeData.jinjeopCond);
 	                    $('#timeViewJinjeopAlwncePlus').text(timeData.jinjeopAlwncePlus);
 	                    $('#timeViewJinjeopAlwnceMinus').text(timeData.jinjeopAlwnceMinus);

 	                    $('#timeViewJinjeop2Cond').text(timeData.jinjeop2Cond);
	                    	$('#timeViewJinjeop2AlwncePlus').text(timeData.jinjeop2AlwncePlus);
	                    	$('#timeViewJinjeop2AlwnceMinus').text(timeData.jinjeop2AlwnceMinus);
	                    	$('#timeViewPush1Cond').text(timeData.push1Cond);
	                    	$('#timeViewPush1AlwncePlus').text(timeData.push1AlwncePlus);
	                    	$('#timeViewPush1AlwnceMinus').text(timeData.push1AlwnceMinus);
 	                    
 	                    $('#timeViewReformCond').text(timeData.reformCond);
 	                    $('#timeViewReformAlwncePlus').text(timeData.reformAlwncePlus);
 	                    $('#timeViewReformAlwnceMinus').text(timeData.reformAlwnceMinus);

 	                    $('#pressureViewWarmupCond').text(pressureData.warmupCond);
 	                    $('#pressureViewWarmupAlwncePlus').text(pressureData.warmupAlwncePlus);
 	                    $('#pressureViewWarmupAlwnceMinus').text(pressureData.warmupAlwnceMinus);
 	                    $('#pressureViewFitupCond').text(pressureData.fitupCond);
 	                    $('#pressureViewFitupAlwncePlus').text(pressureData.fitupAlwncePlus);
 	                    $('#pressureViewFitupAlwnceMinus').text(pressureData.fitupAlwnceMinus);
 	                    $('#pressureViewPush1Cond').text(pressureData.push1Cond);
 	                    $('#pressureViewPush1AlwncePlus').text(pressureData.push1AlwncePlus);
 	                    $('#pressureViewPush1AlwnceMinus').text(pressureData.push1AlwnceMinus);
 	                    //$('#pressureViewSecondCond').text(pressureData.secondCond);
 	                    //$('#pressureViewSecondAlwncePlus').text(pressureData.secondAlwncePlus);
 	                    //$('#pressureViewSecondAlwnceMinus').text(pressureData.secondAlwnceMinus);
 	                    $('#pressureViewJinjeopCond').text(pressureData.jinjeopCond);
 	                    $('#pressureViewJinjeopAlwncePlus').text(pressureData.jinjeopAlwncePlus);
 	                    $('#pressureViewJinjeopAlwnceMinus').text(pressureData.jinjeopAlwnceMinus);
 	                    $('#pressureViewJinjeop2Cond').text(pressureData.jinjeop2Cond);
	                   	 	$('#pressureViewJinjeop2AlwncePlus').text(pressureData.jinjeop2AlwncePlus);
	                    	$('#pressureViewJinjeop2AlwnceMinus').text(pressureData.jinjeop2AlwnceMinus);
 	                    $('#pressureViewReformCond').text(pressureData.reformCond);
 	                    $('#pressureViewReformAlwncePlus').text(pressureData.reformAlwncePlus);
 	                    $('#pressureViewReformAlwnceMinus').text(pressureData.reformAlwnceMinus);
 	                  	$('#pressureViewCoolCond').text(pressureData.coolCond);
	                    	$('#pressureViewCoolAlwncePlus').text(pressureData.coolAlwncePlus);
	                    	$('#pressureViewCoolAlwnceMinus').text(pressureData.coolAlwnceMinus);

 	                    $('#sizeViewWpLeftCond').text(sizeData.wpLeftCond);
 	                    $('#sizeViewWpLeftAlwncePlus').text(sizeData.wpLeftAlwncePlus);
 	                    $('#sizeViewWpLeftAlwnceMinus').text(sizeData.wpLeftAlwnceMinus);
 	                    $('#sizeViewWpRightCond').text(sizeData.wpRightCond);
 	                    $('#sizeViewWpRightAlwncePlus').text(sizeData.wpRightAlwncePlus);
 	                    $('#sizeViewWpRightAlwnceMinus').text(sizeData.wpRightAlwnceMinus);
 	                    $('#sizeViewPitchLeftCond').text(sizeData.pitchLeftCond);
 	                    $('#sizeViewPitchLeftAlwncePlus').text(sizeData.pitchLeftAlwncePlus);
 	                    $('#sizeViewPitchLeftAlwnceMinus').text(sizeData.pitchLeftAlwnceMinus);
 	                    $('#sizeViewPitchRightCond').text(sizeData.pitchRightCond);
 	                    $('#sizeViewPitchRightAlwncePlus').text(sizeData.pitchRightAlwncePlus);
 	                    $('#sizeViewPitchRightAlwnceMinus').text(sizeData.pitchRightAlwnceMinus);
 	                    $('#sizeViewPpfWingLeftCond').text(sizeData.ppfWingLeftCond);
 	                    $('#sizeViewPpfWingLeftAlwncePlus').text(sizeData.ppfWingLeftAlwncePlus);
 	                    $('#sizeViewPpfWingLeftAlwnceMinus').text(sizeData.ppfWingLeftAlwnceMinus);
 	                    $('#sizeViewPpfWingRightCond').text(sizeData.ppfWingRightCond);
 	                    $('#sizeViewPpfWingRightAlwncePlus').text(sizeData.ppfWingRightAlwncePlus);
 	                    $('#sizeViewPpfWingRightAlwnceMinus').text(sizeData.ppfWingRightAlwnceMinus);
 	                    $('#sizeViewPpfDepthLeftCond').text(sizeData.ppfDepthLeftCond);
 	                    $('#sizeViewPpfDepthLeftAlwncePlus').text(sizeData.ppfDepthLeftAlwncePlus);
 	                    $('#sizeViewPpfDepthLeftAlwnceMinus').text(sizeData.ppfDepthLeftAlwnceMinus);
 	                    $('#sizeViewPpfDepthRightCond').text(sizeData.ppfDepthRightCond);
 	                    $('#sizeViewPpfDepthRightAlwncePlus').text(sizeData.ppfDepthRightAlwncePlus);
 	                    $('#sizeViewPpfDepthRightAlwnceMinus').text(sizeData.ppfDepthRightAlwnceMinus);
 	                    $('#sizeViewFilmCond').text(sizeData.filmCond);
 	                    $('#sizeViewFilmAlwncePlus').text(sizeData.filmAlwncePlus);
 	                    $('#sizeViewFilmAlwnceMinus').text(sizeData.filmAlwnceMinus);
 	                    $('#sizeViewMetalDepthCond').text(sizeData.metalDepthCond);
 	                    $('#sizeViewMetalDepthAlwncePlus').text(sizeData.metalDepthAlwncePlus);
 	                    $('#sizeViewMetalDepthAlwnceMinus').text(sizeData.metalDepthAlwnceMinus);
 	                    $('#sizeViewMetalThicknessCond').text(sizeData.metalThicknessCond);
 	                    $('#sizeViewMetalThicknessAlwncePlus').text(sizeData.metalThicknessAlwncePlus);
 	                    $('#sizeViewMetalThicknessAlwnceMinus').text(sizeData.metalThicknessAlwnceMinus);
 	                    $('#sizeViewThCenterCond').text(sizeData.thCenterCond);
 	                    $('#sizeViewThCenterAlwncePlus').text(sizeData.thCenterAlwncePlus);
 	                    $('#sizeViewThCenterAlwnceMinus').text(sizeData.thCenterAlwnceMinus);
 	                    $('#sizeViewThEdgeCond').text(sizeData.thEdgeCond);
 	                    $('#sizeViewThEdgeAlwncePlus').text(sizeData.thEdgeAlwncePlus);
 	                    $('#sizeViewThEdgeAlwnceMinus').text(sizeData.thEdgeAlwnceMinus);
 	                    $('#sizeViewBurrCond').text(sizeData.burrCond);
 	                    $('#sizeViewBurrAlwncePlus').text(sizeData.burrAlwncePlus);
 	                    $('#sizeViewBurrAlwnceMinus').text(sizeData.burrAlwnceMinus);
					}
				}
			});
        }
    });

    $('#btnWorkOrdRetv').on('click', function() {
        if(equipCd != null && equipCd != "" ) {
	    	ordDateCal =  $('#ordDate').val();
	    	ordGubunCd =  $('#ordGubunCd option:selected').val();
			$('#workTimeTable').DataTable().ajax.reload( function () {});
			$('#actualOutputTable').DataTable().ajax.reload( function () {});
			//$('#').DataTable().ajax.reload( function () {});	//제조조건
        } else {
        	toastr.warning("설비정보를 선택해 주세요");
        }	
    });	

    //생산실적 목록
    let actualOutputTable = $('#actualOutputTable').DataTable({  
		language: lang_kor,
		paging: true,
		info: false,
		ordering: false,
		processing: true,
		searching: false,
		autoWidth: false,
        lengthChange: false,	//몇개씩 보여줄껀지
        pageLength: 20,
        ajax: {
            url: '<c:url value="/wm/readActualOutputDataList_eisc0010"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 : menuAuth,
                'equipCd' : function() { return equipCd; }, 
            	'ordDate' : function() { return ordDateCal.replace(/-/g, ''); },
            	'ordGubun': function() { return ordGubunCd; },
            },
        },
        columns: [
        	{ data: 'workOrdNo' },		//설비명
        	{ data: 'goodsNm' },		//제품명
        	{ data: 'qutyNm' },			//재질
        	{ data: 'model' },			//규격
        	{ data: 'ordLotNo' },		//lotNo
        	{ data: 'workStatusNm' },	//작업상태{}
        	{ data: 'targetWeight',
		   		render: function(data, type) {
		   			return parseFloat(data).toFixed(2);
		   		}
            },
        	{ data: 'outputCnt'},		//생산량
        	{ data: 'totalFaultyCnt'},	//불량 합계
        ],
		order: [
			[ 0, 'asc' ],
		],
        columnDefs: [
        	{ targets: [0,1,2,3,4,5], className: 'text-center' },
        	{ targets: [6,7,8], className: 'text-right' },
        	{ targets: [6,7,8] , render: $.fn.dataTable.render.number( ',' )},
        ],
		drawCallback: function () {
            var sum2 = $('#actualOutputTable').DataTable().column(6,{ page: 'current'} ).data().sum();           
            $('#sum2').html(sum2.toLocaleString());
            var sum3 = $('#actualOutputTable').DataTable().column(7,{ page: 'current'} ).data().sum();           
            $('#sum3').html(sum3.toLocaleString());
            var sum4 = $('#actualOutputTable').DataTable().column(8,{ page: 'current'} ).data().sum();           
            $('#sum4').html(sum4.toLocaleString());
        },
    });

    $('#tabActualOutput').on('click', function() {
    	$('#actualOutput').removeClass('d-none');
    	$('#bomTable').addClass('d-none');
    });
    $('#tabBomTalbe').on('click', function() {
    	$('#actualOutput').addClass('d-none');
    	$('#bomTable').removeClass('d-none');
    });

	//Bom 초기화
    function bomDataClear()	{
    	$(".bomData").text("");
    }
    

</script>
</body>
</html>
