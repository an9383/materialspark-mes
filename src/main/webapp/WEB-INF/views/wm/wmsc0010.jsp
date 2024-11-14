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
					<li class="breadcrumb-item"><a href="#">생산관리</a></li>
					<li class="breadcrumb-item active">작업지시</li>
				</ol>
			</nav>
		</header>
		<!-- #main============================================================== -->
          <div class="container-fluid" id="main">
              <div class="row table-wrap-hid">	
                  <!--======================== .left-list ========================-->
                  <div class="left-list left-60" id="left-60" style="width:13%;">
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
				</div><!-- /.left-list -->
                    <!--======================== .right-sidebar 등록,수정 ========================-->
				<div class="right-list right-40" id="myrSidenav" style="width:86%;">
                    <div class="card" id="formBox">                                    
						<div class="card-body col-sm-12 p-2">
							<div class="row">
								<div class="col-md-4">
									<div class="row">
										<label class="input-label-sm">작지 계획일</label>
										<div class="form-group input-sub m-0 row">
											<input class="form-control" style="width:97px;" type="text" id="calender" disabled/>
											<button onclick="fnPopUpCalendar(calender,calender,'yyyy-mm-dd')"  class="btn btn-secondary input-sub-search" id="btnCalendar" type="button">
											<span class="oi oi-calendar"></span>
										</button>
										</div>
										&nbsp;&nbsp;
										<button type="button" class="btn btn-primary mr-2" id="btnRetv">조회</button>
									</div>
								</div>
								<div class="col-md-4">
									<button type="button" class="btn btn-warning float-left mr-2" id="autoPlanCreate" disabled>일별 작지계획 등록</button>
									<button type="button" class="btn btn-danger float-right mr-2" id="chooseAutoPlanCreate" disabled>기간별 작지계획 등록</button>
									<!-- <button type="button" class="btn btn-danger float-center mr-2" id="autoPlanDelete" >작지계획 전체삭제</button> -->
								</div>
								<div class="col-md-4">
									<button type="button" class="btn btn-primary float-right mr-2" id="btnSave" disabled>저장</button>
								</div>
							</div>
						</div>
	            	<!-- 상세정보 -->
					<div id="viewBox">
					<form id="workOrder">
						<table class="table table-bordered" id="workOrderPlan">
							<thead class="thead-light">
							<tr>
								<th>주야구분</th>
								<th>제조조건코드</th>
								<th>제품(기종)</th>
								<th>재질</th>
								<th>규격</th>
								<th>표면처리</th>
							</tr>
							</thead>
							<tr id="day">
								<input type="hidden" id="searchDay">
								<input type="hidden" id="dayEquipCondSeq" name="equipCondSeq">
								<input type="hidden" id="dayEquipCd" name="equipCd">
								<input type="hidden" id="dayGoodsCd" name="goodsCd">
								<input type="hidden" id="dayWorkGubunCd" name="workGubunCd" value="day">
								<th>주간</th>
								<td align="center" style="width:50px;"><span id="equipCondSeq1"></span></td>
								<td  align="center" style="width:100px;">
									<div class="input-sub m-0">
										<input type="text" class="form-control" id="addFormGoodsNm1" name="goodsCd" disabled>
										<button type="button" class="btn btn-primary input-sub-search" id="addForm1" onClick="manufacturerList()" disabled>
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
								</td>
								<td align="center" style="width:50px;"><span id="addFormQutyCd1"></span></td>
								<td align="center" style="width:150px;"><span id="addFormModel1"></span></td>
								<td align="center" style="width:100px;"><span id="addFormSurfaceTrtmtNm1"></span></td>
							</tr >
							<tr id="night">
								<input type="hidden" id="searchNight">
								<input type="hidden" id="nightEquipCondSeq" name="equipCondSeq">
								<input type="hidden" id="nightEquipCd" name="equipCd">
								<input type="hidden" id="nightGoodsCd" name="goodsCd">
								<input type="hidden" id="nightWorkGubunCd" name="workGubunCd" value="night">
								<th>야간</th>
								<td align="center" style="width:50px;"><span id="equipCondSeq2"></span></td>
								<td align="center" style="width:100px;">
										
									<div class="input-sub m-0">
										<input type="text" class="form-control" id="addFormGoodsNm2" name="goodsCd" disabled>
										<button type="button" class="btn btn-primary input-sub-search" id="addForm2" onClick="manufacturerList()" disabled>
											<span class="oi oi-magnifying-glass"></span>
										</button>
									</div>
								</td>
								<td align="center" style="width:50px;"><span id="addFormQutyCd2"></span></td>
								<td align="center" style="width:150px;"><span id="addFormModel2"></span></td>
								<td align="center" style="width:100px;"><span id="addFormSurfaceTrtmtNm2"></span></td>
							</tr>
						</table>
					</form>
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
								<th colspan="10" >시간(SEC)</th>
								<th colspan="4" >압력(Mpz)</th>
							</tr>
							</thead>
							<tr>
								<th></th>
								<th style="min-width:40px">1차푸셔-상</th>
								<th style="min-width:40px">1차푸셔-하</th>
								<th style="min-width:40px">1차진접-상</th>
								<th style="min-width:40px">1차진접-하</th>
								<th style="min-width:40px">2차진접-상</th>
								<th style="min-width:40px">2차진접-하</th>									
								<th style="min-width:40px">가접1	</th>
								<th style="min-width:40px">가접2	</th>
								<th style="min-width:40px">1차	</th>
								<th style="min-width:40px">1차푸셔</th>
								<th style="min-width:40px">2차	</th>
								<th style="min-width:40px">3차	</th>
								<th style="min-width:40px">1차진접</th>
								<th style="min-width:40px">2차진접</th>
								<th style="min-width:40px">리폼	</th>
								<th style="min-width:40px">냉각	</th>
								<th style="min-width:40px">가접	</th>
								<th style="min-width:40px">1차푸셔</th>
								<!-- <th style="min-width:40px">2차	</th> -->
								<th style="min-width:40px">1차진접</th>
								<th style="min-width:40px">2차진접</th>
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
								<td align="right"><span id="timeViewCoolCond"></span></td>
								<td align="right"><span id="pressureViewFitupCond"></span></td>
								<td align="right"><span id="pressureViewPush1Cond"></span></td>
								<td align="right"><span id="pressureViewJinjeopCond"></span></td>
								<td align="right"><span id="pressureViewJinjeop2Cond"></span></td>
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
								<td align="right"><span id="timeViewCoolAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewFitupAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewPush1AlwncePlus"></span></td>
								<td align="right"><span id="pressureViewJinjeopAlwncePlus"></span></td>
								<td align="right"><span id="pressureViewJinjeop2AlwncePlus"></span></td>							
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
								<td align="right"><span id="timeViewCoolAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewFitupAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewPush1AlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewJinjeopAlwnceMinus"></span></td>
								<td align="right"><span id="pressureViewJinjeop2AlwnceMinus"></span></td>
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
					<!-- 상세정보 끝-->
               </div>
              <!--// 등록, 수정 -->
          </div><!-- .right-sidebar -->
      </div><!-- /.row -->
    </div><!-- / #main  -->
</div><!-- /.page-wrapper -->
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
							<th style="min-width: 60px">제조조건코드</th>
							<th style="min-width: 50px">설비명</th>
							<th style="min-width: 50px">제품명</th>
							<th style="min-width: 50px">재질</th>
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
<!-- 일별 작지 자동등록 모달 시작-->
<div class="modal fade" id="planCreatePopupModal" tabindex="-1" role="dialog" aria-labelledby="planCreatePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">일별 등록 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="planRegDate1"></h6>
				<p>*일별 등록시 해당일자의 작지계획은 삭제되며, 각 설비별 가장 최근 제조조건으로 등록됩니다!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-warning" id="planCreateCheck" data-dismiss="modal" style="min-width: 70px;">일별 등록</button>
				<button type="button" class="btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 일별 작지 자동등록 모달 종료 -->

<!-- 일별 작지 자동등록 모달 시작-->
<div class="modal fade" id="chooseAutoPlanCreatePopupModal" tabindex="-1" role="dialog" aria-labelledby="planCreatePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">기간별 등록 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row" style="margin-bottom: 10px;">
					<label class="input-label-sm ml-2">등록 기간</label>
					<input class="form-control" style="width:140px;" type="date" id="chooseDateTo">
					<label class="input-label-sm ml-2">~</label>
					<input class="form-control" style="width:140px;" type="date" id="chooseDateFuture">
				</div>
				<p>*기간별 등록시 해당 기간(선택일자 포함)의 작지계획은 삭제되며, 각 설비별 시작일자 직전의 가장 최근 제조조건으로 등록됩니다!</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="choosePlanCreateCheck" data-dismiss="modal" style="min-width: 70px;">기간별 등록</button>
				<button type="button" class="btn btn-secondary" id="" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 일별 작지 자동등록 모달 종료 -->

<!-- 작지 자동등록 삭제 모달 시작-->
<!--
<div class="modal fade" id="planDeletePopupModal" tabindex="-1" role="dialog" aria-labelledby="planDeletePopupModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="saveBtnModalLabel">자동등록 삭제 확인</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<h6 id="planRegDate2"></h6>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" id="planDeleteCheck" data-dismiss="modal" style="min-width: 70px;">삭제</button>
				<button type="button" class="btn btn btn-secondary" id="planDeleteCancel" data-dismiss="modal" style="min-width: 70px;">취소</button>
			</div>
		</div>
	</div>
</div>
-->
<!-- 작지 자동등록 삭제 모달 종료 -->

<%@include file="../layout/bottom.jsp" %>

<script>

	let menuAuth = 'wmsc0010';
	let currentHref = 'wmsc0010';
	let currentPage = $('.'+currentHref).attr('id');
	$('#'+currentPage).closest('.has-child','li').addClass('has-open has-active');
	$('#'+currentPage).closest('.menu-item').addClass('has-active');
	$(document).attr("title", "작업지시");
	
	var serverDate =  "${serverDate}";
	var serverDateFuture =  "${serverDateFuture}";
    var equipGroup = "<%=session.getAttribute("equipGroupCd") %>";
	if( equipGroup == 'null'){
		equipGroup = null;
	}
	
	//공통코드 처리 시작
	var equipGroupCode = new Array(); // 설치장소
    <c:forEach items="${equipGroupCd}" var="info">
		var json=new Object();
		json.baseCd="${info.baseCd}";
		json.baseCdNm="${info.baseCdNm}";
		equipGroupCode.push(json);
    </c:forEach>
    //공통코드 처리 종료  
    
    // 목록
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
            	'menuAuth'	 	: 		menuAuth,
            	'equipGroup' : function() { return equipGroup; }
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

	var html1 = '<div class="row">';
	//html1 += '<div class="form-group input-sub m-0 row">';
	//html1 += '<input class="form-control" style="width:97px;" type="text" id="calender"/>';
	//html1 += '<button onclick="fnPopUpCalendar(calender,calender,\'yyyy-mm-dd\')"  class="btn btn-secondary input-sub-search" id="btnCalendar" type="button">';
	//html1 += '<span class="oi oi-calendar"></span>';
	//html1 += '</button>'; 
	//html1 += '</div>';
	html1 += '&nbsp;<label class="input-label-sm">설비그룹</label><select  class="custom-select" id="equipGroupCd" ></select>';
	html1 += '</div>';
	$('#equipCodeAdmTable_length').html(html1);
	selectBoxAppend(equipGroupCode, "equipGroupCd", equipGroup, "1");

	$("#equipGroupCd").change(function() {
    	equipGroup =  $('#equipGroupCd option:selected').val();
		$('#equipCodeAdmTable').DataTable().ajax.reload( function () {});
	 	equipCd = "";
	});
	
	$('#calender').val(serverDate);	//컨트롤단의 오늘날짜 초기설정
	var equipCd = null;				//설비코드 전역변수 선언(작업지시 계획조회, 제조조건 계획 조회 시 사용)
	var planSearchDay = null;		// 상세 View의 날짜
	//var planRegDate = null;
    var workOrderPlanRowIdx = null;
    var rowNumber = null;			// 주.야 구분  (행번호)
    var rowNumberTemp = null;		// 주,야 구분 행선택(파란줄) 풀림방지
    var planRegDate = null; 
    
    // 보기
    $('#equipCodeAdmTable tbody').on('click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
            $('#btnSave').attr('disabled', true);
            $('#autoPlanCreate').attr('disabled', true);
            $('#chooseAutoPlanCreate').attr('disabled', true);
            $('#addForm1').attr('disabled', true);
            $('#addForm2').attr('disabled', true);
    		planClear();
            bomClear();
            $('#workOrderPlan').find('tr.tableSelected').removeClass('tableSelected');
        }
        else {
        	$('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
        	$('#workOrderPlan').find('tr.tableSelected').removeClass('tableSelected');
			$(this).addClass('selected');
			planRegDate = $('#calender').val();
            
        	equipCd = equipCodeAdmTable.row( this ).data().equipCd;
       		$('#dayEquipCd').val(equipCd);
       		$('#nightEquipCd').val(equipCd);
       		planRegDate = $('#calender').val();

       		//지난날짜인지 계산
    		date();
    		
       		//작업지시계획 ajax 호출
       		workPlanRoad();
        }
    });

    //계획 상세정보
   	$('#workOrderPlan tbody').on('click', 'tr', function () {
   		if (equipCd==null){
   			toastr.warning('설비를 선택해 주세요.');
   	   	}	
   		else{
   			if ( $(this).hasClass('tableSelected') ) {
   	            $(this).removeClass('tableSelected');
   	         	//$('#btnSave').attr('disabled', true);
				rowNumber = null;
   	        }
   	        else {
   				$('tr.tableSelected').removeClass('tableSelected');
   				$(this).addClass('tableSelected');
   				workOrderPlanRowIdx = $(this).closest('tr').attr('id');
   			 	$('#btnSave').attr('disabled', false);
   				rowNumber = $(this).closest('tr').prevAll().length;
   				rowNumberTemp = rowNumber;
    			var equipCondSeq = null;
    			
    			//주간, 야간 선택행 판단
    			if (rowNumber == 0){
    				equipCondSeq = $('#dayEquipCondSeq').val();
//     				if( equipCondSeq == "" ){
//  					toastr.warning( equipCd+" & "+planRegDate+" 주간 작업지시가 없습니다.");
//     	   			}
//     				else {
 			    if( equipCondSeq != null && equipCondSeq != "" ){
    			      	$.ajax({
    			 	            url: '<c:url value="/wm/onlyBomDataList"/>',
    			 	            type: 'GET',
    			 	            data: {
    			 	            	'menuAuth'	 	: 		menuAuth,
    			 	            	'equipCondSeq'	: 		equipCondSeq,
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
										$('#timeViewCoolCond').text(timeData.coolCond);
  			 	                    	$('#timeViewCoolAlwncePlus').text(timeData.coolAlwncePlus);
  			 	                    	$('#timeViewCoolAlwnceMinus').text(timeData.coolAlwnceMinus);
    			
    			 	                    $('#pressureViewWarmupCond').text(pressureData.warmupCond);
    			 	                    $('#pressureViewWarmupAlwncePlus').text(pressureData.warmupAlwncePlus);
    			 	                    $('#pressureViewWarmupAlwnceMinus').text(pressureData.warmupAlwnceMinus);
    			 	                    $('#pressureViewFitupCond').text(pressureData.fitupCond);
    			 	                    $('#pressureViewFitupAlwncePlus').text(pressureData.fitupAlwncePlus);
    			 	                    $('#pressureViewFitupAlwnceMinus').text(pressureData.fitupAlwnceMinus);
    			 	                    $('#pressureViewPush1Cond').text(pressureData.push1Cond);
    			 	                    $('#pressureViewPush1AlwncePlus').text(pressureData.push1AlwncePlus);
    			 	                    $('#pressureViewPush1AlwnceMinus').text(pressureData.push1AlwnceMinus);
    			 	                    $('#pressureViewJinjeopCond').text(pressureData.jinjeopCond);
    			 	                    $('#pressureViewJinjeopAlwncePlus').text(pressureData.jinjeopAlwncePlus);
    			 	                    $('#pressureViewJinjeopAlwnceMinus').text(pressureData.jinjeopAlwnceMinus);
    			 	                    $('#pressureViewJinjeop2Cond').text(pressureData.jinjeop2Cond);
   			 	                   	 	$('#pressureViewJinjeop2AlwncePlus').text(pressureData.jinjeop2AlwncePlus);
   			 	                    	$('#pressureViewJinjeop2AlwnceMinus').text(pressureData.jinjeop2AlwnceMinus);
    			 	                    $('#pressureViewReformCond').text(pressureData.reformCond);
    			 	                    $('#pressureViewReformAlwncePlus').text(pressureData.reformAlwncePlus);
    			 	                    $('#pressureViewReformAlwnceMinus').text(pressureData.reformAlwnceMinus);
    			
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
    			 	                    
    			 	        			if (rowNumber == 0){
    			 	        				//toastr.success('주간조 BOM정보 조회 완료');
    			 	        			}
    			 	        			else if(rowNumber == 1){
    			 	        				//toastr.success('야간조 BOM정보 조회 완료');
    			 	        			}
    			 	                } else {
    			 	                	toastr.error(res.message, '', {timeOut: 5000});
    			 	                }
    			 	            }
    					});
    	   	   		} else{
    	   	   			bomClear();
        	   	   	}
    			}
    			else if(rowNumber == 1){
    				equipCondSeq = $('#nightEquipCondSeq').val();
    				//if( equipCondSeq=="" ){
 				//	toastr.warning( equipCd+" & "+planRegDate+" 야간 작업지시가 없습니다.");
    	   			//}
    				//else{
 			    if( equipCondSeq != null && equipCondSeq != "" ){
    			      	$.ajax({
    			 	            url: '<c:url value="/wm/onlyBomDataList"/>',
    			 	            type: 'GET',
    			 	            data: {
    			 	            	'menuAuth'	 	: 		menuAuth,
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
										$('#timeViewCoolCond').text(timeData.coolCond);
 			 	                    	$('#timeViewCoolAlwncePlus').text(timeData.coolAlwncePlus);
 			 	                    	$('#timeViewCoolAlwnceMinus').text(timeData.coolAlwnceMinus);
 			 	                    	
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
    			 	                    
    			 	        			if (rowNumber == 0){
    			 	        				//toastr.success('주간조 BOM정보 조회 완료');
    			 	        			}
    			 	        			else if(rowNumber == 1){
    			 	        				//toastr.success('야간조 BOM정보 조회 완료');
    			 	        			}
    			 	                }
    			 	            }
    					});
    	   			} else{
    	   	   			bomClear();
        	   	   	}
    			}
    			else {
    				alert("행 번호 오류");
    			}
 			}
		}
    });

	//제조조건 계획정보 모달 시작
   	var equipCondCommonAdmTable;
   	function manufacturerList()
   	{
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
			'ajax': {
					url: '<c:url value="em/manufacturerPlanListRead"/>',
					type: 'GET',
					data: {
						'menuAuth'	 	: 		menuAuth,
						'equipCd'		:		function() { return equipCd; }
					},
				},
				rowId: 'equipCondSeq',
				columns: [
					{ data: 'equipCondSeq' },
					{ data: 'equipNm' },
					{ data: 'goodsNm' },
					{ data: 'alniQutyNm' },
					{ data: 'model' },
					{ data: 'condRegDate',
						render: function(data, type, row) {
							return moment(data).format('YYYY-MM-DD');
						}
					},
		  		],
		        columnDefs: [
		        	{"className": "text-center", "targets": "_all"}
		        ],
		  		order: [
		  			[ 4, 'DESC' ],
		  		],
		    });

			$('#equipCondCommonAdmTable tbody').on('click', 'tr', function () {
				goodsCd = equipCondCommonAdmTable.row( this ).data().goodsCd;
				equipCondSeq = equipCondCommonAdmTable.row( this ).data().equipCondSeq;
				$.ajax({
		            url: '<c:url value="/wm/equipBomDataList"/>',
		            type: 'GET',
		            data: {
		            	'menuAuth'	 	: 	menuAuth,
		            	'equipCondSeq'	:	equipCondSeq,
		            	'goodsCd'		:	goodsCd,
		            },
		            success: function (res) {
		            	let manufacturerData = res.manufacturerData;
		                let tempaturData = res.tempaturData;
		                let timeData = res.timeData;
		                let pressureData = res.pressureData;
		                let sizeData = res.sizeData;
		                if (res.result == 'ok') {
		               		//toastr.success("조회 이상 없음");
							if(workOrderPlanRowIdx == "day") {
								$('#equipCondSeq1').text(equipCondSeq);								//제조조건코드
			               		$('#addFormGoodsNm1').val(manufacturerData.goodsNm);				//제품명
			               		$('#addFormModel1').text(manufacturerData.model);					//규격
			               		$('#addFormQutyCd1').text(manufacturerData.alniQutyNm);				//재질
			               		$('#addFormSurfaceTrtmtNm1').text(manufacturerData.surfaceTrtmtNm);	//표면처리
			               		$('#dayEquipCondSeq').val(tempaturData.equipCondSeq);				//주간조 hidden SEQ
			               		$('#dayGoodsCd').val(manufacturerData.goodsCd);						//제품코드
							}
							else if (workOrderPlanRowIdx == "night") {
								$('#equipCondSeq2').text(equipCondSeq);								//제조조건코드
			               		$('#addFormGoodsNm2').val(manufacturerData.goodsNm);				//제품명
			               		$('#addFormModel2').text(manufacturerData.model);					//규격
			               		$('#addFormQutyCd2').text(manufacturerData.alniQutyNm);				//재질
			               		$('#addFormSurfaceTrtmtNm2').text(manufacturerData.surfaceTrtmtNm);	//표면처리
			               		$('#nightEquipCondSeq').val(tempaturData.equipCondSeq);				//야간조 hidden SEQ
			               		$('#nightGoodsCd').val(manufacturerData.goodsCd);					//제품코드
							}
				
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
							$('#timeViewCoolCond').text(timeData.coolCond);
	 	                    $('#timeViewCoolAlwncePlus').text(timeData.coolAlwncePlus);
	 	                    $('#timeViewCoolAlwnceMinus').text(timeData.coolAlwnceMinus);
	
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
		                    
		                    $('#equipCondCommonAdmModal').modal('hide');
		                    $('#btnSave').attr('disabled', false);
		                    if( rowNumber == null){
			                    $('#workOrderPlan tbody tr').eq(rowNumberTemp).addClass('tableSelected');
							} else {
								$('#workOrderPlan tbody tr').eq(rowNumber).addClass('tableSelected');
							}		                    
		                } else {
		                	toastr.error(res.message, '', {timeOut: 5000});
		                }
		            }
                });
		    });
		}
		else {
			$('#equipCondCommonAdmTable').DataTable().ajax.reload();
		}

		$('#equipCondCommonAdmModal').modal('show');
   	}
	//제조조건 계획정보 모달 시작 종료
  	
  	var planRegDate = null;
  	//저장 btn 클릭 시
  	$('#btnSave').on('click', function() {
  		planRegDate = $('#calender').val();
  		var dayEquipCondSeq = null; 
  		var nightEquipCondSeq = null;
  		var urlDay = null;
  		var urlNight = null;

  		//주간, 야간 하나도 선택 안했을 시 예외처리
  		if ( rowNumber == null && rowNumberTemp == null){
  			toastr.warning('저장할 주간/야간을 선택해 주세요.');
  	  		return false;
  		}
  		
  		dayEquipCondSeq = $('#dayEquipCondSeq').val();
  		nightEquipCondSeq = $('#nightEquipCondSeq').val();

  		if (rowNumber == 0 || rowNumberTemp == 0) {
  	  		if ( $('#addFormGoodsNm1').val() == null || $('#addFormGoodsNm1').val() == "" ){
  	  			toastr.warning('저장할 주간 제품(기종)을 검색해 주세요!');
  	  			return false;
  	  		}
  	  		else if ($('#searchDay').val() == "false"){
	  	  		urlDay = "bm/workOrderPlanCreate";
	  	  		workOrderDay(urlDay, planRegDate, "C");
	  	  		//toastr.success('주간 생성');
	  	  	}
	  		else if ($('#searchDay').val() == "true"){
	  			urlDay = "bm/workOrderPlanUpdate";
	  			workOrderDay(urlDay, planRegDate, "U");
	  			//toastr.success('주간 수정');
  	  		}  			
  		}
  	  	
  		else if ( rowNumber == 1 || rowNumberTemp == 1 ){
  	  		if ( $('#addFormGoodsNm2').val() == null || $('#addFormGoodsNm2').val() == "" ){
  	  			toastr.warning('저장할 야간 제품(기종)을 검색해 주세요!');
  	  			return false;
  	  		}
  	  		else if ($('#searchNight').val() == "false"){
  	  	  		urlNight = "bm/workOrderPlanCreate";
  	  	  		workOrderNight(urlNight, planRegDate, "C");
  	  	  		//toastr.success('야간 생성');
  	  	  	}
  	  	  	else if ($('#searchNight').val() == "true"){
  	  			urlNight = "bm/workOrderPlanUpdate";
  	  			workOrderNight(urlNight, planRegDate, "U");
  	  			//toastr.success('야간 수정');
  	  	  	}
		}
  		else {
  			toastr.warning('주간/야간을 정확히 선택해 주세요.');
		}
    });

	//주간조 등록&수정
	function workOrderDay(url, planRegDate, flag){
		$.ajax({
	            url: url,
	            type: 'POST',
	            data: {
	            	'menuAuth'	 	: 		menuAuth,
	            	'equipCondSeq'		: 		$('#dayEquipCondSeq').val(),
	            	'equipCd'			: 		$('#dayEquipCd').val(),
	            	'goodsCd'			: 		$('#dayGoodsCd').val(),
	            	'workGubunCd'		: 		"D",
					'planRegDate'		:		function() { return planRegDate.replace(/-/g, ''); },
	            },
				success: function (res) {
					let data = res.data;
					if (res.result == 'ok') {
						if (flag == "C"){
							toastr.success('작업지시 주간계획이 등록되었습니다.');
				  	  	}
				  		else if (flag == "U"){
				  			toastr.success('작업지시 주간계획이 수정되었습니다.');
				  	  	}
					$('#btnSave').attr('disabled', true);
					} else {
						toastr.error(res.message, '', {timeOut: 5000});
					}
				},
				complete:function(){
					$('#searchDay').val("true")
				}
			});
    }
    
    //야간조 등록&수정
	function workOrderNight(url, planRegDate, flag){
		$.ajax({
			url: url,
			type: 'POST',
			data: {
				'menuAuth'	 	: 		menuAuth,
				'equipCondSeq'		: 		$('#nightEquipCondSeq').val(),
				'equipCd'			: 		$('#nightEquipCd').val(),
				'goodsCd'			: 		$('#nightGoodsCd').val(),
				'workGubunCd'		: 		"N",
				'planRegDate'		:		function() { return planRegDate.replace(/-/g, ''); },
  	            },
  			success: function (res) {
  				let data = res.data;
  				if (res.result == 'ok'){
					if (flag == "C"){
						toastr.success('작업지시 야간계획이 등록되었습니다.');
					} else if (flag == "U"){
						toastr.success('작업지시 야간계획이 수정되었습니다.');
					}
					$('#btnSave').attr('disabled', true);
  				} else {
  					toastr.error(res.message, '', {timeOut: 5000});
  	  			}
  			},
			complete:function(){
				$('#searchNight').val("true")
			}
		});
    }

	//달력 값 변경 시 작업지시 정보 초기화
	$('#btnCalendar').on('click', function() {
		$('#autoPlanCreate').attr('disabled', true);
		$('#chooseAutoPlanCreate').attr('disabled', true);
		$('#btnSave').attr('disabled', true);
	});
	
	$('#btnRetv').on('click', function() {
		if( equipCd == null || equipCd == ""){
			toastr.warning("설비명을 선택해주세요.");
			return false;
		}
		
		//지난날짜인지 계산
		date();
		
		//작업지시계획 ajax 호출
		planRegDate = $('#calender').val();
		workPlanRoad();
		
	});

	//bom 정보 초기화
  	function bomClear() {
  		$('#tempaturViewWarmupCond').text("");
  		$('#tempaturViewWarmupAlwncePlus').text("");
  		$('#tempaturViewWarmupAlwnceMinus').text("");
  		$('#tempaturViewFitup1UpCond').text("");
  		$('#tempaturViewFitup1UpAlwncePlus').text("");
  		$('#tempaturViewFitup1UpAlwnceMinus').text("");
  		$('#tempaturViewFitup1DownCond').text("");
  		$('#tempaturViewFitup1DownAlwncePlus').text("");
  		$('#tempaturViewFitup1DownAlwnceMinus').text("");
  		$('#tempaturViewFitup2UpleftCond').text("");
  		$('#tempaturViewFitup2UpleftAlwncePlus').text("");
  		$('#tempaturViewFitup2UpleftAlwnceMinus').text("");
  		$('#tempaturViewFitup2DownleftCond').text("");
  		$('#tempaturViewFitup2DownleftAlwncePlus').text("");
  		$('#tempaturViewFitup2DownleftAlwnceMinus').text("");
  		$('#tempaturViewFitup2UprightCond').text("");
  		$('#tempaturViewFitup2UprightAlwncePlus').text("");
  		$('#tempaturViewFitup2UprightAlwnceMinus').text("");
  		$('#tempaturViewFitup2DownrightCond').text("");
  		$('#tempaturViewFitup2DownrightAlwncePlus').text("");
  		$('#tempaturViewFitup2DownrightAlwnceMinus').text("");
  		$('#tempaturViewRollheatUpCond').text("");
  		$('#tempaturViewRollheatUpAlwncePlus').text("");
  		$('#tempaturViewRollheatUpAlwnceMinus').text("");
  		$('#tempaturViewRollheatDownCond').text("");
  		$('#tempaturViewRollheatDownAlwncePlus').text("");
  		$('#tempaturViewRollheatDownAlwnceMinus').text("");
  		$('#tempaturViewFirstUpleftCond').text("");
  		$('#tempaturViewFirstUpleftAlwncePlus').text("");
  		$('#tempaturViewFirstUpleftAlwnceMinus').text("");
  		$('#tempaturViewFirstDownleftCond').text("");
  		$('#tempaturViewFirstDownleftAlwncePlus').text("");
  		$('#tempaturViewFirstDownleftAlwnceMinus').text("");
  		$('#tempaturViewFirstUprightCond').text("");
  		$('#tempaturViewFirstUprightAlwncePlus').text("");
  		$('#tempaturViewFirstUprightAlwnceMinus').text("");
  		$('#tempaturViewFirstDownrightCond').text("");
  		$('#tempaturViewFirstDownrightAlwncePlus').text("");
  		$('#tempaturViewFirstDownrightAlwnceMinus').text("");
  		$('#tempaturViewPush1UpCond').text("");
  		$('#tempaturViewPush1UpAlwncePlus').text("");
  		$('#tempaturViewPush1UpAlwnceMinus').text("");
  		$('#tempaturViewPush1DownCond').text("");
  		$('#tempaturViewPush1DownAlwncePlus').text("");
  		$('#tempaturViewPush1DownAlwnceMinus').text("");
  		$('#tempaturViewSecondUpleftCond').text("");
  		$('#tempaturViewSecondUpleftAlwncePlus').text("");
  		$('#tempaturViewSecondUpleftAlwnceMinus').text("");
  		$('#tempaturViewSecondDownleftCond').text("");
  		$('#tempaturViewSecondDownleftAlwncePlus').text("");
  		$('#tempaturViewSecondDownleftAlwnceMinus').text("");
  		$('#tempaturViewSecondUprightCond').text("");
  		$('#tempaturViewSecondUprightAlwncePlus').text("");
  		$('#tempaturViewSecondUprightAlwnceMinus').text("");
  		$('#tempaturViewSecondDownrightCond').text("");
  		$('#tempaturViewSecondDownrightAlwncePlus').text("");
  		$('#tempaturViewSecondDownrightAlwnceMinus').text("");
  		$('#tempaturViewThirdUpleftCond').text("");
  		$('#tempaturViewThirdUpleftAlwncePlus').text("");
  		$('#tempaturViewThirdUpleftAlwnceMinus').text("");
  		$('#tempaturViewThirdDownleftCond').text("");
  		$('#tempaturViewThirdDownleftAlwncePlus').text("");
  		$('#tempaturViewThirdDownleftAlwnceMinus').text("");
  		$('#tempaturViewThirdUprightCond').text("");
  		$('#tempaturViewThirdUprightAlwncePlus').text("");
  		$('#tempaturViewThirdUprightAlwnceMinus').text("");
  		$('#tempaturViewThirdDownrightCond').text("");
  		$('#tempaturViewThirdDownrightAlwncePlus').text("");
  		$('#tempaturViewThirdDownrightAlwnceMinus').text("");
  		$('#tempaturViewJinjeop1UpCond').text("");
  		$('#tempaturViewJinjeop1UpAlwncePlus').text("");
  		$('#tempaturViewJinjeop1UpAlwnceMinus').text("");
  		$('#tempaturViewJinjeop1DownCond').text("");
  		$('#tempaturViewJinjeop1DownAlwncePlus').text("");
  		$('#tempaturViewJinjeop1DownAlwnceMinus').text("");
  		$('#tempaturViewJinjeop2UpCond').text("");
  		$('#tempaturViewJinjeop2UpAlwncePlus').text("");
  		$('#tempaturViewJinjeop2UpAlwnceMinus').text("");
  		$('#tempaturViewJinjeop2DownCond').text("");
  		$('#tempaturViewJinjeop2DownAlwncePlus').text("");
  		$('#tempaturViewJinjeop2DownAlwnceMinus').text("");

        $('#timeViewWarmupCond').text("");
        $('#timeViewWarmupAlwncePlus').text("");
        $('#timeViewWarmupAlwnceMinus').text("");
        $('#timeViewFitupCond').text("");
        $('#timeViewFitupAlwncePlus').text("");
        $('#timeViewFitupAlwnceMinus').text("");
        $('#timeViewFitup2Cond').text("");
        $('#timeViewFitup2AlwncePlus').text("");
        $('#timeViewFitup2AlwnceMinus').text("");
        $('#timeViewFirstCond').text("");
        $('#timeViewFirstAlwncePlus').text("");
        $('#timeViewFirstAlwnceMinus').text("");
        $('#timeViewSecondCond').text("");
        $('#timeViewSecondAlwncePlus').text("");
        $('#timeViewSecondAlwnceMinus').text("");
        $('#timeViewThirdCond').text("");
        $('#timeViewThirdAlwncePlus').text("");
        $('#timeViewThirdAlwnceMinus').text("");
        $('#timeViewJinjeopCond').text("");
        $('#timeViewJinjeopAlwncePlus').text("");
        $('#timeViewJinjeopAlwnceMinus').text("");
        $('#timeViewJinjeop2Cond').text("");
        $('#timeViewJinjeop2AlwncePlus').text("");
        $('#timeViewJinjeop2AlwnceMinus').text("");
        $('#timeViewPush1Cond').text("");
        $('#timeViewPush1AlwncePlus').text("");
        $('#timeViewPush1AlwnceMinus').text("");
        $('#timeViewReformCond').text("");
        $('#timeViewReformAlwncePlus').text("");
        $('#timeViewReformAlwnceMinus').text("");
        $('#timeViewCoolCond').text("");
        $('#timeViewCoolAlwncePlus').text("");
        $('#timeViewCoolAlwnceMinus').text("");
        
        $('#pressureViewWarmupCond').text("");
        $('#pressureViewWarmupAlwncePlus').text("");
        $('#pressureViewWarmupAlwnceMinus').text("");
        $('#pressureViewFitupCond').text("");
        $('#pressureViewFitupAlwncePlus').text("");
        $('#pressureViewFitupAlwnceMinus').text("");
        $('#pressureViewPush1Cond').text("");
        $('#pressureViewPush1AlwncePlus').text("");
        $('#pressureViewPush1AlwnceMinus').text("");
        $('#pressureViewJinjeopCond').text("");
        $('#pressureViewJinjeopAlwncePlus').text("");
        $('#pressureViewJinjeopAlwnceMinus').text("");
        $('#pressureViewJinjeop2Cond').text("");
        $('#pressureViewJinjeop2AlwncePlus').text("");
        $('#pressureViewJinjeop2AlwnceMinus').text("");
        $('#pressureViewReformCond').text("");
        $('#pressureViewReformAlwncePlus').text("");
        $('#pressureViewReformAlwnceMinus').text("");

        $('#sizeViewWpLeftCond').text("");
        $('#sizeViewWpLeftAlwncePlus').text("");
        $('#sizeViewWpLeftAlwnceMinus').text("");
        $('#sizeViewWpRightCond').text("");
        $('#sizeViewWpRightAlwncePlus').text("");
        $('#sizeViewWpRightAlwnceMinus').text("");
        $('#sizeViewPitchLeftCond').text("");
        $('#sizeViewPitchLeftAlwncePlus').text("");
        $('#sizeViewPitchLeftAlwnceMinus').text("");
        $('#sizeViewPitchRightCond').text("");
        $('#sizeViewPitchRightAlwncePlus').text("");
        $('#sizeViewPitchRightAlwnceMinus').text("");
        $('#sizeViewPpfWingLeftCond').text("");
        $('#sizeViewPpfWingLeftAlwncePlus').text("");
        $('#sizeViewPpfWingLeftAlwnceMinus').text("");
        $('#sizeViewPpfWingRightCond').text("");
        $('#sizeViewPpfWingRightAlwncePlus').text("");
        $('#sizeViewPpfWingRightAlwnceMinus').text("");
        $('#sizeViewPpfDepthLeftCond').text("");
        $('#sizeViewPpfDepthLeftAlwncePlus').text("");
        $('#sizeViewPpfDepthLeftAlwnceMinus').text("");
        $('#sizeViewPpfDepthRightCond').text("");
        $('#sizeViewPpfDepthRightAlwncePlus').text("");
        $('#sizeViewPpfDepthRightAlwnceMinus').text("");
        $('#sizeViewFilmCond').text("");
        $('#sizeViewFilmAlwncePlus').text("");
        $('#sizeViewFilmAlwnceMinus').text("");
        $('#sizeViewMetalDepthCond').text("");
        $('#sizeViewMetalDepthAlwncePlus').text("");
        $('#sizeViewMetalDepthAlwnceMinus').text("");
        $('#sizeViewMetalThicknessCond').text("");
        $('#sizeViewMetalThicknessAlwncePlus').text("");
        $('#sizeViewMetalThicknessAlwnceMinus').text("");
        $('#sizeViewThCenterCond').text("");
        $('#sizeViewThCenterAlwncePlus').text("");
        $('#sizeViewThCenterAlwnceMinus').text("");
        $('#sizeViewThEdgeCond').text("");
        $('#sizeViewThEdgeAlwncePlus').text("");
        $('#sizeViewThEdgeAlwnceMinus').text("");
        $('#sizeViewBurrCond').text("");
        $('#sizeViewBurrAlwncePlus').text("");
        $('#sizeViewBurrAlwnceMinus').text("");
  	}

	function planClear(){
		$('#equipCondSeq1').text("");
		$('#equipCondSeq2').text("");
		$('#addFormGoodsNm2').val("");
	    $('#addFormQutyCd2').val("");
	    $('#addFormModel2').val("");
	    $('#addFormSurfaceTrtmtNm2').val("");
	    $('#addFormGoodsNm1').val("");
	    $('#addFormQutyCd1').val("");
	    $('#addFormModel1').val("");
	    $('#addFormSurfaceTrtmtNm1').val("");
	    $('#dayEquipCondSeq').val("");
    	//$('#dayEquipCd').val("");
    	$('#dayGoodsCd').val("");
    	$('#dayWorkGubunCd').val("");
    	$('#nightEquipCondSeq').val("");
    	//$('#nightEquipCd').val("");
	    $('#nightGoodsCd').val("");
    	$('#nightWorkGubunCd').val("");
		$('#addFormGoodsNm1').val("");
    	$('#addFormGoodsNm2').val("");
		$('#addFormQutyCd1').text("");
		$('#addFormQutyCd2').text("");
		$('#addFormModel1').text("");
		$('#addFormModel2').text("");
		$('#addFormSurfaceTrtmtNm1').text("");
		$('#addFormSurfaceTrtmtNm2').text("");
		$('#searchDay').val("");
		$('#searchNight').val("");
	}

	function calculatorDay(date){ 
		return date.replace(/-/g, '');
	}


	//지난 날짜인지 계산
	function date(){
		//오늘날짜 & 선택날짜 비교 temp>0 이면 지난날짜
	    var today = "${serverDate}";
	    chooseDay = $('#calender').val();
	    today = calculatorDay(today);
		var chooseDay  = calculatorDay(chooseDay);
	    var intToday = 0;
	    var intChooseDay = 0;
	    intToday = parseInt(today);
	    intChooseDay = parseInt(chooseDay);
	    var dateTemp = 0;
	    dateTemp = intToday - intChooseDay;
	    planSearchDay = serverDate;
	    $('#btnSave').attr('disabled', false);
	    $('#addForm1').attr('disabled', false);
	    $('#addForm2').attr('disabled', false);
	    //지난 날짜는 검색 비활성화
	    if( dateTemp > 0 ){
	   		toastr.warning('지난 날짜는 조회만 가능합니다.');
	   		$('#addForm1').attr('disabled', true);
	        $('#addForm2').attr('disabled', true);
	        $('#btnSave').attr('disabled', true);
	        $('#autoPlanCreate').attr('disabled', true);
	        $('#chooseAutoPlanCreate').attr('disabled', true);
	    } else{
	    	$('#addForm1').attr('disabled', false);
	        $('#addForm2').attr('disabled', false);
	        $('#btnSave').attr('disabled', false);
	        $('#autoPlanCreate').attr('disabled', false);
	        $('#chooseAutoPlanCreate').attr('disabled', false);          
	    }
	}
	
    
	function workPlanRoad(){
		planClear();
        bomClear();
		$.ajax({
        	url: '<c:url value="wm/workOrderPlanList"/>',
            type: 'GET',
            data: {
            	'menuAuth'	 	: 		menuAuth,
            	'equipCd'		:		equipCd,
            	'planRegDate'	:		function() { return planRegDate.replace(/-/g, ''); },
            },
            success: function (res) {
                let day = res.day;
                let night = res.night
                if( res.result == 'ok' ){
	                // 보기
	                if  (res.day != null){
	                	$('#equipCondSeq1').text(day.equipCondSeq);
	                	$('#dayEquipCondSeq').val(day.equipCondSeq);
	                    $('#dayEquipCd').val(day.equipCd);
	                    $('#dayGoodsCd').val(day.goodsCd);
	                    $('#dayWorkGubunCd').val(day.workGubunCd);

	                    $('#addFormGoodsNm1').val(day.goodsNm);
	                    $('#addFormQutyCd1').text(day.qutyNm);
	                    $('#addFormModel1').text(day.model);
	                    $('#addFormSurfaceTrtmtNm1').text(day.surfaceTrtmtNm);
	                    //toastr.success('작업지시 주간조 조회 완료.');
	                    $('#searchDay').val("true");
					} else {
						$('#searchDay').val("false");
					}
	                if  (res.night != null){
	                	$('#equipCondSeq2').text(night.equipCondSeq);
	                	$('#nightEquipCondSeq').val(night.equipCondSeq);
	                    $('#nightEquipCd').val(night.equipCd);
	                    $('#nightGoodsCd').val(night.goodsCd);
	                    $('#nightWorkGubunCd').val(night.workGubunCd);
	                    
	                    $('#addFormGoodsNm2').val(night.goodsNm);
	                    $('#addFormQutyCd2').text(night.qutyNm);
	                    $('#addFormModel2').text(night.model);
	                    $('#addFormSurfaceTrtmtNm2').text(night.surfaceTrtmtNm);
	                    $('#searchNight').val("true");
	                    //toastr.success('작업지시 야간조 조회 완료.');         
					} else {
						$('#searchNight').val("false");
					}
                }
                else {
                	toastr.error(res.message, '', {timeOut: 5000});
				}
            }
        });
        
		rowNumber = null;
        rowNumberTemp = null;
	}
	
	//작지계획 자동등록
    var planRegDate = null;

    //일별 자동등록btn
	$('#autoPlanCreate').on('click', function () {
		planRegDate = $('#calender').val();
		$('#planRegDate1').text(planRegDate + " 계획 자동등록 하시겠습니까?");
		$('#planCreatePopupModal').modal('show');
	});

    //기간별 자동등록btn
	$('#chooseAutoPlanCreate').on('click', function () {
		$('#chooseDateFuture').val(serverDateFuture);
		$('#chooseDateTo').val(serverDate);
		$('#chooseAutoPlanCreatePopupModal').modal('show');
	});
	
    //일별 작지계획 등록
    $('#planCreateCheck').on('click', function () {
		planRegDate = $('#calender').val();
   		$.ajax({
			url: '<c:url value="wm/workOrderPlanAutoCreate"/>',
			type: 'POST',
			data: {
				'menuAuth'	 	: 		menuAuth,
				'planRegDate'	:		function() { return planRegDate.replace(/-/g, ''); },
			},
			success: function (res) {
				let day = res.day;
				let night = res.night
				if( res.result == 'ok' ){
					toastr.success("각 설비의 최근 작지계획으로 모두 등록되었습니다.", '', {timeOut: 5000});
		            $('#btnSave').attr('disabled', true);
		            $('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
		            $('#workOrderPlan').find('tr.tableSelected').removeClass('tableSelected');
		            planClear();
		            bomClear();
  				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
	});

	//기간별 작지계획 등록
    $('#choosePlanCreateCheck').on('click', function () {
		let dateTo = new Date($('#chooseDateTo').val());
		let dateFuture = new Date($('#chooseDateFuture').val());
		let dateDiff = Math.ceil((dateFuture.getTime()-dateTo.getTime())/(1000*3600*24));
		dateDiff++;		//선택 날짜의 차이 + 1 이 선택 기간의 일자수임
		if (isNaN(dateDiff)) {
			toastr.warning("등록 기간이 YYYY-MM-DD 형식인지 확인해주세요!");
			$('#chooseDateTo').focus();
			return false;
		}
		if (dateDiff <= 0) {
			toastr.warning("기간을 잘못 선택하였습니다.<br>다시 선택해 주세요!");
			$('#chooseDateTo').focus();
			return false;
		}
		if (dateDiff > 31) {
			toastr.warning("등록 가능 기간은 최대 한달입니다!");
			$('#chooseDateTo').focus();
			return false;
		}
		if (serverDate > $('#chooseDateTo').val()) {
			toastr.warning("지난날짜는 등록하실 수 없습니다!");
			$('#chooseDateTo').focus();
			return false;
		}
		
   		$.ajax({
			url: '<c:url value="wm/chooseWorkOrderPlanAutoCreate"/>',
			type: 'POST',
			beforeSend: function() {
				$('#my-spinner').show();
			},
			data: {
				'menuAuth'	 		: 		menuAuth,
				'chooseDateTo'		:		$('#chooseDateTo').val().replace(/-/g, ''),
				'chooseDateFuture'	:		$('#chooseDateFuture').val().replace(/-/g, ''),
				'serverDate'		:		serverDate.replace(/-/g, ''),
			},
			success: function (res) {
				if (res.result == 'ok'){
					toastr.success(res.message);
				} else if (res.result=='fail') {
					toastr.warning(res.message, '', {timeOut: 5000});	
  				} else if (res.result=='error') {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			},
			complete: function() {
				$('#my-spinner').hide();
			},
		});
	});
	
    //자동등록 삭제btn
	/* $('#autoPlanDelete').on('click', function () {
		planRegDate = $('#calender').val();
		$('#planRegDate2').text(planRegDate + " 작지계획 전체 삭제하시겠습니까?");
		$('#planDeletePopupModal').modal('show');
	}); */

	//자동등록 삭제 취소btn
	/* $('#planDeleteCancel').on('click', function () {
		$('#planDeletePopupModal').modal('hide');
	}); */
	
	// 작지계획 자동등록 삭제
    /* $('#planDeleteCheck').on('click', function () {
		planRegDate = $('#calender').val();
   		$.ajax({
			url: '<c:url value="wm/workOrderPlanAutoDelete"/>',
			type: 'POST',
			data: {
				'menuAuth'	 	: 		menuAuth,
				'planRegDate'	:		function() { return planRegDate.replace(/-/g, ''); },
			},
			success: function (res) {
				let day = res.day;
				let night = res.night
				if( res.result == 'ok' ){
					toastr.success("각 설비의 최근 작지계획 모두 삭제되었습니다.", '', {timeOut: 5000});
		            $('#btnSave').attr('disabled', true);
		            $('#equipCodeAdmTable').DataTable().$('tr.selected').removeClass('selected');
		            $('#workOrderPlan').find('tr.tableSelected').removeClass('tableSelected');
		            planClear();
		            bomClear();
  				} else {
					toastr.error(res.message, '', {timeOut: 5000});
				}
			}
		});
	}); */
    
</script>
</body>
</html>
